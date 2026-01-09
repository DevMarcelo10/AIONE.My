"""
AIONE IA - CoteFácil Integrador
Sistema de integração com cotação eletrônica
"""

from dataclasses import dataclass, field
from datetime import datetime, date, timedelta
from typing import List, Dict, Optional
from enum import Enum
import json

from core.database import DatabaseManager
from core.utils.logger import get_logger


class StatusCotacao(str, Enum):
    RASCUNHO = 'RASCUNHO'
    ABERTA = 'ABERTA'
    ENCERRADA = 'ENCERRADA'
    CANCELADA = 'CANCELADA'
    FINALIZADA = 'FINALIZADA'


class CriterioSelecao(str, Enum):
    MENOR_PRECO = 'MENOR_PRECO'
    MELHOR_SCORE = 'MELHOR_SCORE'
    MANUAL = 'MANUAL'


@dataclass
class ItemCotacao:
    """Item de uma cotação"""
    id_prod: int
    cod_prod: str = ""
    des_prod: str = ""
    cod_ean: str = ""
    qtd_solicitada: float = 0.0
    vlr_ref_historico: Optional[float] = None
    vlr_ref_mercado: Optional[float] = None
    id_necessi: Optional[int] = None


@dataclass
class RespostaCotacao:
    """Resposta de um fornecedor para um item"""
    cnpj_forn: str
    id_prod: int
    qtd_disponivel: float
    vlr_unitario: float
    vlr_total: float
    prazo_entrega: int = 0
    observacao: str = ""
    var_vs_referencia: float = 0.0
    ranking_preco: int = 0
    melhor_oferta: bool = False


@dataclass
class Cotacao:
    """Cotação de compra"""

    id_cotacao: Optional[int] = None
    id_filial: int = 0
    cod_cotacao: str = ""

    # Período
    dat_abertura: datetime = None
    dat_encerramento: datetime = None

    # Itens
    itens: List[ItemCotacao] = field(default_factory=list)

    # Fornecedores
    fornecedores: List[Dict] = field(default_factory=list)

    # Respostas
    respostas: List[RespostaCotacao] = field(default_factory=list)

    # Configuração
    permite_parcial: bool = True
    auto_selecao: bool = False
    criterio_selecao: CriterioSelecao = CriterioSelecao.MENOR_PRECO

    # Status
    status: StatusCotacao = StatusCotacao.RASCUNHO
    vlr_estimado: float = 0.0

    # Vencedor
    cnpj_vencedor: Optional[str] = None
    nome_vencedor: Optional[str] = None
    vlr_vencedor: float = 0.0

    def __post_init__(self):
        if self.dat_abertura is None:
            self.dat_abertura = datetime.now()


class CoteFacilIntegrador:
    """
    Integrador com sistema CoteFácil (cotação eletrônica).

    Funcionalidades:
    - Criar cotação a partir de necessidades
    - Enviar convites para fornecedores
    - Receber e processar respostas
    - Selecionar vencedor
    - Gerar pedido a partir da cotação
    """

    def __init__(self, db: DatabaseManager, config: Dict = None):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

        # Configuração da API CoteFácil (simulada)
        self.config = config or {}
        self.api_url = self.config.get('api_url', 'https://api.cotefacil.com.br')
        self.api_key = self.config.get('api_key', '')

    # =========================================================================
    # CRIAÇÃO DE COTAÇÃO
    # =========================================================================

    def criar_cotacao(self, id_filial: int,
                      ids_necessidades: List[int],
                      cnpjs_fornecedores: List[str],
                      dias_validade: int = 3,
                      criterio: CriterioSelecao = CriterioSelecao.MENOR_PRECO,
                      usuario: str = "SISTEMA") -> Cotacao:
        """
        Cria uma nova cotação a partir de necessidades.

        Args:
            id_filial: ID da filial
            ids_necessidades: IDs das necessidades a cotar
            cnpjs_fornecedores: CNPJs dos fornecedores a convidar
            dias_validade: Dias até encerramento
            criterio: Critério de seleção do vencedor
            usuario: Usuário que criou

        Returns: Cotação criada
        """
        from .repositorio import IntegracaoRepositorio

        self.logger.info(f"Criando cotação: {len(ids_necessidades)} itens, {len(cnpjs_fornecedores)} fornecedores")

        # Busca dados das necessidades
        itens = self._buscar_necessidades(ids_necessidades)

        if not itens:
            raise ValueError("Nenhuma necessidade válida encontrada")

        # Busca dados dos fornecedores
        fornecedores = self._buscar_fornecedores(cnpjs_fornecedores)

        if not fornecedores:
            raise ValueError("Nenhum fornecedor válido encontrado")

        # Calcula valor estimado
        vlr_estimado = sum(
            (i.get('QtdSugerida') or 0) * (i.get('PrecoSuger') or 0)
            for i in itens
        )

        # Monta cotação
        cotacao = Cotacao(
            id_filial=id_filial,
            cod_cotacao=self._gerar_codigo_cotacao(id_filial),
            dat_abertura=datetime.now(),
            dat_encerramento=datetime.now() + timedelta(days=dias_validade),
            criterio_selecao=criterio,
            vlr_estimado=vlr_estimado,
            status=StatusCotacao.RASCUNHO
        )

        # Adiciona itens
        for item in itens:
            cotacao.itens.append(ItemCotacao(
                id_prod=item['IDProd'],
                cod_prod=item.get('CodPro', ''),
                des_prod=item.get('Despro', ''),
                cod_ean=item.get('CodEAN', ''),
                qtd_solicitada=float(item.get('QtdSugerida') or 0),
                vlr_ref_historico=float(item.get('PrecoSuger') or 0),
                id_necessi=item.get('IDNecessi')
            ))

        # Adiciona fornecedores
        cotacao.fornecedores = fornecedores

        # Salva cotação
        repositorio = IntegracaoRepositorio(self.db)
        id_cotacao = repositorio.salvar_cotacao(cotacao, usuario)
        cotacao.id_cotacao = id_cotacao

        self.logger.info(f"Cotação criada: ID={id_cotacao}, Código={cotacao.cod_cotacao}")

        return cotacao

    def abrir_cotacao(self, id_cotacao: int) -> bool:
        """
        Abre a cotação e envia convites aos fornecedores.
        """

        self.logger.info(f"Abrindo cotação {id_cotacao}")

        # Atualiza status
        sql = """
            UPDATE ia_arqcotacao
            SET Status = 'ABERTA',
                DatAbertura = NOW()
            WHERE IDCotacao = :id
              AND Status = 'RASCUNHO'
        """
        self.db.execute_query(sql, {'id': id_cotacao})

        # Marca fornecedores como convidados
        sql_forn = """
            UPDATE ia_arqcotacaoforn
            SET Status = 'CONVIDADO',
                DatConvite = NOW()
            WHERE IDCotacao = :id
        """
        self.db.execute_query(sql_forn, {'id': id_cotacao})

        # Em implementação real, enviar e-mails/notificações
        self._enviar_convites(id_cotacao)

        return True

    # =========================================================================
    # RECEBIMENTO DE RESPOSTAS
    # =========================================================================

    def registrar_resposta(self, id_cotacao: int, cnpj_forn: str,
                           respostas: List[Dict]) -> int:
        """
        Registra respostas de um fornecedor.

        Args:
            id_cotacao: ID da cotação
            cnpj_forn: CNPJ do fornecedor
            respostas: Lista de respostas [{'id_prod', 'qtd', 'vlr_unitario', 'prazo'}]

        Returns: Quantidade de respostas registradas
        """

        self.logger.info(f"Registrando {len(respostas)} respostas do fornecedor {cnpj_forn}")

        # Verifica se cotação está aberta
        cotacao = self._buscar_cotacao(id_cotacao)
        if cotacao['Status'] != 'ABERTA':
            raise ValueError("Cotação não está aberta para respostas")

        # Busca IDs necessários
        id_cotacao_forn = self._buscar_id_cotacao_forn(id_cotacao, cnpj_forn)

        count = 0
        for resp in respostas:
            try:
                # Busca item da cotação
                id_cotacao_ite = self._buscar_id_cotacao_ite(id_cotacao, resp['id_prod'])

                if not id_cotacao_ite:
                    continue

                # Busca preço de referência
                vlr_ref = self._buscar_preco_referencia(id_cotacao, resp['id_prod'])

                # Calcula variação
                vlr_unit = float(resp.get('vlr_unitario', 0))
                var_ref = 0
                if vlr_ref and vlr_ref > 0:
                    var_ref = ((vlr_unit - vlr_ref) / vlr_ref) * 100

                # Insere resposta
                sql = """
                    INSERT INTO ia_arqcotaresp (
                        IDCotacao, IDCotacaoForn, IDCotacaoIte,
                        CNPJForn, IDProd,
                        QtdDisponivel, VlrUnitario, VlrTotal,
                        PrazoEntrega, Observacao,
                        VarVsReferencia, DatResposta, Status
                    ) VALUES (
                        :id_cotacao, :id_forn, :id_ite,
                        :cnpj, :id_prod,
                        :qtd, :vlr_unit, :vlr_total,
                        :prazo, :obs,
                        :var_ref, NOW(), 'RECEBIDA'
                    )
                """

                self.db.execute_insert(sql, {
                    'id_cotacao': id_cotacao,
                    'id_forn': id_cotacao_forn,
                    'id_ite': id_cotacao_ite,
                    'cnpj': cnpj_forn,
                    'id_prod': resp['id_prod'],
                    'qtd': resp.get('qtd', resp.get('qtd_disponivel', 0)),
                    'vlr_unit': vlr_unit,
                    'vlr_total': vlr_unit * float(resp.get('qtd', 0)),
                    'prazo': resp.get('prazo', resp.get('prazo_entrega', 0)),
                    'obs': resp.get('observacao', ''),
                    'var_ref': var_ref
                })

                count += 1

            except Exception as e:
                self.logger.error(f"Erro ao registrar resposta: {e}")

        # Atualiza status do fornecedor
        if count > 0:
            sql_forn = """
                UPDATE ia_arqcotacaoforn
                SET Status = 'RESPONDIDO',
                    DatResposta = NOW(),
                    QtdItensResp = :qtd,
                    VlrTotalResp = (
                        SELECT SUM(VlrTotal) FROM ia_arqcotaresp
                        WHERE IDCotacaoForn = :id_forn
                    )
                WHERE IDCotacaoForn = :id_forn
            """
            self.db.execute_query(sql_forn, {'id_forn': id_cotacao_forn, 'qtd': count})

            # Atualiza contagem de respostas na cotação
            self._atualizar_contagem_respostas(id_cotacao)

        self.logger.info(f"Registradas {count} respostas")

        return count

    # =========================================================================
    # SELEÇÃO DE VENCEDOR
    # =========================================================================

    def encerrar_cotacao(self, id_cotacao: int) -> Dict:
        """
        Encerra a cotação e calcula rankings.
        """

        self.logger.info(f"Encerrando cotação {id_cotacao}")

        # Atualiza status
        sql = """
            UPDATE ia_arqcotacao
            SET Status = 'ENCERRADA',
                DatFechamento = NOW()
            WHERE IDCotacao = :id
              AND Status = 'ABERTA'
        """
        self.db.execute_query(sql, {'id': id_cotacao})

        # Calcula rankings por item
        self._calcular_rankings(id_cotacao)

        # Busca resumo
        return self._resumo_cotacao(id_cotacao)

    def selecionar_vencedor(self, id_cotacao: int,
                            cnpj_vencedor: str = None,
                            usuario: str = "SISTEMA") -> Dict:
        """
        Seleciona o fornecedor vencedor da cotação.

        Se cnpj_vencedor não for informado, usa o critério configurado.
        """

        self.logger.info(f"Selecionando vencedor para cotação {id_cotacao}")

        cotacao = self._buscar_cotacao(id_cotacao)

        if cotacao['Status'] not in ('ENCERRADA', 'ABERTA'):
            raise ValueError("Cotação deve estar ABERTA ou ENCERRADA")

        # Determina vencedor
        if cnpj_vencedor:
            vencedor = self._buscar_dados_fornecedor(cnpj_vencedor)
        else:
            vencedor = self._selecionar_automatico(id_cotacao, cotacao.get('CriterioSel'))

        if not vencedor:
            raise ValueError("Nenhum fornecedor elegível para vencer")

        # Atualiza cotação
        sql = """
            UPDATE ia_arqcotacao
            SET Status = 'FINALIZADA',
                CNPJVencedor = :cnpj,
                NomeVencedor = :nome,
                VlrVencedor = :vlr,
                UserFechamento = :usuario
            WHERE IDCotacao = :id
        """

        self.db.execute_query(sql, {
            'id': id_cotacao,
            'cnpj': vencedor['cnpj'],
            'nome': vencedor['nome'],
            'vlr': vencedor['vlr_total'],
            'usuario': usuario
        })

        # Marca respostas do vencedor como selecionadas
        sql_resp = """
            UPDATE ia_arqcotaresp
            SET Status = 'SELECIONADA'
            WHERE IDCotacao = :id AND CNPJForn = :cnpj
        """
        self.db.execute_query(sql_resp, {'id': id_cotacao, 'cnpj': vencedor['cnpj']})

        # Marca fornecedor como vencedor
        sql_forn = """
            UPDATE ia_arqcotacaoforn
            SET Vencedor = 1
            WHERE IDCotacao = :id AND CNPJForn = :cnpj
        """
        self.db.execute_query(sql_forn, {'id': id_cotacao, 'cnpj': vencedor['cnpj']})

        self.logger.info(f"Vencedor selecionado: {vencedor['nome']} - R$ {vencedor['vlr_total']:.2f}")

        return vencedor

    def gerar_pedido_de_cotacao(self, id_cotacao: int,
                                 usuario: str = "SISTEMA") -> 'PedidoCompra':
        """
        Gera pedido de compra a partir da cotação finalizada.
        """
        from .smartped import PedidoCompra, ItemPedido, OrigemPedido, StatusPedido
        from .repositorio import IntegracaoRepositorio

        self.logger.info(f"Gerando pedido a partir da cotação {id_cotacao}")

        cotacao = self._buscar_cotacao(id_cotacao)

        if cotacao['Status'] != 'FINALIZADA':
            raise ValueError("Cotação deve estar FINALIZADA")

        if not cotacao['CNPJVencedor']:
            raise ValueError("Cotação não tem vencedor definido")

        # Busca respostas selecionadas
        respostas = self._buscar_respostas_vencedor(id_cotacao, cotacao['CNPJVencedor'])

        # Monta pedido
        pedido = PedidoCompra(
            id_filial=cotacao['IDFilial'],
            cnpj_forn=cotacao['CNPJVencedor'],
            nome_forn=cotacao['NomeVencedor'],
            origem=OrigemPedido.COTEFACIL,
            id_cotacao=id_cotacao,
            user_geracao=usuario,
            status=StatusPedido.RASCUNHO
        )

        # Adiciona itens
        for resp in respostas:
            # Busca dados do produto
            prod = self._buscar_produto(resp['IDProd'])

            item = ItemPedido(
                id_prod=resp['IDProd'],
                cod_prod=prod.get('CodPro', ''),
                des_prod=prod.get('Despro', ''),
                cod_ean=prod.get('CodEAN', ''),
                qtd_solicitada=float(resp.get('QtdDisponivel') or 0),
                vlr_unitario=float(resp.get('VlrUnitario') or 0),
                vlr_ref_historico=float(resp.get('VlrRefHistorico') or 0)
            )
            pedido.adicionar_item(item)

        # Salva pedido
        repositorio = IntegracaoRepositorio(self.db)
        id_pedido = repositorio.salvar_pedido(pedido)
        pedido.id_pedido_ia = id_pedido

        # Vincula pedido à cotação
        sql = "UPDATE ia_arqcotacao SET IDPedidoIA = :id_ped WHERE IDCotacao = :id_cot"
        self.db.execute_query(sql, {'id_ped': id_pedido, 'id_cot': id_cotacao})

        self.logger.info(f"Pedido gerado: ID={id_pedido}, {pedido.qtd_itens} itens, R$ {pedido.vlr_total:.2f}")

        return pedido

    # =========================================================================
    # MÉTODOS AUXILIARES
    # =========================================================================

    def _gerar_codigo_cotacao(self, id_filial: int) -> str:
        """Gera código único da cotação"""
        return f"COT{id_filial:02d}{datetime.now().strftime('%Y%m%d%H%M%S')}"

    def _buscar_necessidades(self, ids: List[int]) -> List[Dict]:
        """Busca dados das necessidades"""
        if not ids:
            return []

        placeholders = ','.join([f':id_{i}' for i in range(len(ids))])
        params = {f'id_{i}': id_val for i, id_val in enumerate(ids)}

        sql = f"""
            SELECT n.*, p.CodPro, p.Despro, p.CodEAN
            FROM ia_arqnecessi n
            INNER JOIN arqproduto p ON p.IDProd = n.IDProd
            WHERE n.IDNecessi IN ({placeholders})
              AND n.BloqCompra = 0
        """

        return self.db.execute_query(sql, params)

    def _buscar_fornecedores(self, cnpjs: List[str]) -> List[Dict]:
        """Busca dados dos fornecedores"""
        if not cnpjs:
            return []

        placeholders = ','.join([f':cnpj_{i}' for i in range(len(cnpjs))])
        params = {f'cnpj_{i}': cnpj for i, cnpj in enumerate(cnpjs)}

        sql = f"""
            SELECT
                p.CpfCnpjPes as cnpj,
                p.NomPes as nome,
                p.Email as email,
                p.Telefone as telefone
            FROM arqpessoa p
            WHERE p.CpfCnpjPes IN ({placeholders})
        """

        return self.db.execute_query(sql, params)

    def _buscar_cotacao(self, id_cotacao: int) -> Dict:
        """Busca dados da cotação"""
        sql = "SELECT * FROM ia_arqcotacao WHERE IDCotacao = :id"
        result = self.db.execute_query(sql, {'id': id_cotacao})
        return result[0] if result else None

    def _buscar_id_cotacao_forn(self, id_cotacao: int, cnpj: str) -> int:
        """Busca ID do fornecedor na cotação"""
        sql = """
            SELECT IDCotacaoForn FROM ia_arqcotacaoforn
            WHERE IDCotacao = :id AND CNPJForn = :cnpj
        """
        result = self.db.execute_query(sql, {'id': id_cotacao, 'cnpj': cnpj})
        return result[0]['IDCotacaoForn'] if result else None

    def _buscar_id_cotacao_ite(self, id_cotacao: int, id_prod: int) -> int:
        """Busca ID do item na cotação"""
        sql = """
            SELECT IDCotacaoIte FROM ia_arqcotacaoite
            WHERE IDCotacao = :id AND IDProd = :id_prod
        """
        result = self.db.execute_query(sql, {'id': id_cotacao, 'id_prod': id_prod})
        return result[0]['IDCotacaoIte'] if result else None

    def _buscar_preco_referencia(self, id_cotacao: int, id_prod: int) -> float:
        """Busca preço de referência do item"""
        sql = """
            SELECT VlrRefHistorico FROM ia_arqcotacaoite
            WHERE IDCotacao = :id AND IDProd = :id_prod
        """
        result = self.db.execute_query(sql, {'id': id_cotacao, 'id_prod': id_prod})
        return float(result[0]['VlrRefHistorico'] or 0) if result else 0

    def _atualizar_contagem_respostas(self, id_cotacao: int):
        """Atualiza contagem de respostas na cotação"""
        sql = """
            UPDATE ia_arqcotacao c
            SET QtdRespostas = (
                SELECT COUNT(DISTINCT CNPJForn) FROM ia_arqcotaresp
                WHERE IDCotacao = c.IDCotacao
            )
            WHERE IDCotacao = :id
        """
        self.db.execute_query(sql, {'id': id_cotacao})

    def _calcular_rankings(self, id_cotacao: int):
        """Calcula rankings de preço para cada item"""

        # Busca itens
        sql_itens = "SELECT IDCotacaoIte, IDProd FROM ia_arqcotacaoite WHERE IDCotacao = :id"
        itens = self.db.execute_query(sql_itens, {'id': id_cotacao})

        for item in itens:
            # Atualiza ranking por item
            sql = """
                UPDATE ia_arqcotaresp r1
                SET RankingPreco = (
                    SELECT COUNT(*) + 1
                    FROM ia_arqcotaresp r2
                    WHERE r2.IDCotacaoIte = r1.IDCotacaoIte
                      AND r2.VlrUnitario < r1.VlrUnitario
                ),
                MelhorOferta = (
                    SELECT CASE WHEN r1.VlrUnitario = MIN(r3.VlrUnitario) THEN 1 ELSE 0 END
                    FROM ia_arqcotaresp r3
                    WHERE r3.IDCotacaoIte = r1.IDCotacaoIte
                )
                WHERE r1.IDCotacaoIte = :id_ite
            """
            self.db.execute_query(sql, {'id_ite': item['IDCotacaoIte']})

    def _selecionar_automatico(self, id_cotacao: int, criterio: str) -> Dict:
        """Seleciona vencedor automaticamente"""

        if criterio == 'MENOR_PRECO':
            sql = """
                SELECT
                    cf.CNPJForn as cnpj,
                    cf.NomeForn as nome,
                    cf.VlrTotalResp as vlr_total
                FROM ia_arqcotacaoforn cf
                WHERE cf.IDCotacao = :id
                  AND cf.Status = 'RESPONDIDO'
                ORDER BY cf.VlrTotalResp ASC
                LIMIT 1
            """
        elif criterio == 'MELHOR_SCORE':
            sql = """
                SELECT
                    cf.CNPJForn as cnpj,
                    cf.NomeForn as nome,
                    cf.VlrTotalResp as vlr_total,
                    fs.ScoreGeral
                FROM ia_arqcotacaoforn cf
                LEFT JOIN ia_arqfornscor fs ON fs.CNPJForn = cf.CNPJForn AND fs.Status = 'ATIVO'
                WHERE cf.IDCotacao = :id
                  AND cf.Status = 'RESPONDIDO'
                ORDER BY fs.ScoreGeral DESC, cf.VlrTotalResp ASC
                LIMIT 1
            """
        else:
            return None

        result = self.db.execute_query(sql, {'id': id_cotacao})
        return result[0] if result else None

    def _buscar_respostas_vencedor(self, id_cotacao: int, cnpj: str) -> List[Dict]:
        """Busca respostas do vencedor"""
        sql = """
            SELECT r.*, ci.VlrRefHistorico
            FROM ia_arqcotaresp r
            INNER JOIN ia_arqcotacaoite ci ON ci.IDCotacaoIte = r.IDCotacaoIte
            WHERE r.IDCotacao = :id
              AND r.CNPJForn = :cnpj
              AND r.Status = 'SELECIONADA'
        """
        return self.db.execute_query(sql, {'id': id_cotacao, 'cnpj': cnpj})

    def _buscar_produto(self, id_prod: int) -> Dict:
        """Busca dados do produto"""
        sql = "SELECT CodPro, Despro, CodEAN FROM arqproduto WHERE IDProd = :id"
        result = self.db.execute_query(sql, {'id': id_prod})
        return result[0] if result else {}

    def _buscar_dados_fornecedor(self, cnpj: str) -> Dict:
        """Busca dados completos do fornecedor"""
        sql = """
            SELECT p.NomPes as nome
            FROM arqpessoa p
            WHERE p.CpfCnpjPes = :cnpj
        """
        result = self.db.execute_query(sql, {'cnpj': cnpj})

        if result:
            return {'cnpj': cnpj, 'nome': result[0]['nome'], 'vlr_total': 0}
        return None

    def _enviar_convites(self, id_cotacao: int):
        """Envia convites para fornecedores (simulado)"""
        # Em implementação real, enviar e-mails ou integrar com API
        self.logger.info(f"Enviando convites para cotação {id_cotacao}")

    def _resumo_cotacao(self, id_cotacao: int) -> Dict:
        """Retorna resumo da cotação"""

        sql = """
            SELECT
                c.*,
                (SELECT COUNT(*) FROM ia_arqcotacaoite WHERE IDCotacao = c.IDCotacao) as qtd_itens,
                (SELECT COUNT(*) FROM ia_arqcotacaoforn WHERE IDCotacao = c.IDCotacao AND Status = 'RESPONDIDO') as qtd_respostas
            FROM ia_arqcotacao c
            WHERE c.IDCotacao = :id
        """

        result = self.db.execute_query(sql, {'id': id_cotacao})
        return result[0] if result else {}
