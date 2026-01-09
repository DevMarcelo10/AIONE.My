"""
AIONE IA - Repositório de Necessidades
Repositório para persistência de necessidades e pedidos
"""

from datetime import datetime, date, timedelta
from typing import List, Dict, Optional
import json

from core.database import DatabaseManager
from core.utils.logger import get_logger

from .gerador import (
    NecessidadeItem,
    PedidoSugerido,
    StatusNecessidade,
    StatusPedido,
    Prioridade,
    CenarioForecast
)


class NecessidadeRepositorio:
    """Repositório para persistência de necessidades e pedidos"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    # =========================================================================
    # NECESSIDADES (ia_arqnecessi)
    # =========================================================================

    def salvar_necessidade(self, item: NecessidadeItem,
                           dias_validade: int = 3) -> int:
        """Salva uma necessidade de compra"""
        data_validade = date.today() + timedelta(days=dias_validade)

        sql = """
            INSERT INTO ia_arqnecessi (
                IDFilial, IDProd, IDGrupo,
                Prioridade, ScorePrior,
                EstqAtual, EstqSegur, PontoPed, DiasCobre, RiscoRupt,
                QtdSugerida, QtdMinima, QtdMaxima, CenarioUsado,
                CNPJFornSuger, NomeFornSuger, ScoreFornSuger, PrecoSuger, VlrTotalSuger,
                ClassifProd, CurvaABC, BloqCompra, MotivoBloq,
                MotivoNeces, AlertasJSON,
                Status, DatGeracao, DatValidade
            ) VALUES (
                :id_filial, :id_prod, :id_grupo,
                :prioridade, :score_prior,
                :estq_atual, :estq_segur, :ponto_ped, :dias_cobre, :risco_rupt,
                :qtd_sugerida, :qtd_minima, :qtd_maxima, :cenario,
                :cnpj_forn, :nome_forn, :score_forn, :preco, :vlr_total,
                :classif_prod, :curva_abc, :bloq_compra, :motivo_bloq,
                :motivo_neces, :alertas_json,
                'PENDENTE', NOW(), :data_validade
            )
        """

        params = {
            'id_filial': item.id_filial,
            'id_prod': item.id_prod,
            'id_grupo': item.id_grupo,
            'prioridade': item.prioridade.value,
            'score_prior': item.score_prioridade,
            'estq_atual': item.estoque_atual,
            'estq_segur': item.estoque_seguranca,
            'ponto_ped': item.ponto_pedido,
            'dias_cobre': item.dias_cobertura,
            'risco_rupt': item.risco_ruptura,
            'qtd_sugerida': item.qtd_sugerida,
            'qtd_minima': item.qtd_minima,
            'qtd_maxima': item.qtd_maxima,
            'cenario': item.cenario_usado.value,
            'cnpj_forn': item.cnpj_fornecedor,
            'nome_forn': item.nome_fornecedor[:100] if item.nome_fornecedor else None,
            'score_forn': item.score_fornecedor,
            'preco': item.preco_sugerido,
            'vlr_total': item.vlr_total,
            'classif_prod': item.classif_produto,
            'curva_abc': item.curva_abc,
            'bloq_compra': 1 if item.bloqueado else 0,
            'motivo_bloq': item.motivo_bloqueio,
            'motivo_neces': item.motivo_necessidade[:200] if item.motivo_necessidade else '',
            'alertas_json': json.dumps(item.alertas, ensure_ascii=False),
            'data_validade': data_validade
        }

        self.db.executar_query(sql, params)

        # Retorna ID inserido
        result = self.db.executar_query("SELECT LAST_INSERT_ID() as id")
        return result[0]['id'] if result else 0

    def salvar_necessidades_lote(self, itens: List[NecessidadeItem],
                                 dias_validade: int = 3) -> int:
        """Salva múltiplas necessidades"""
        count = 0
        for item in itens:
            try:
                self.salvar_necessidade(item, dias_validade)
                count += 1
            except Exception as e:
                self.logger.error(f"Erro ao salvar necessidade prod {item.id_prod}: {e}")

        self.logger.info(f"Salvas {count}/{len(itens)} necessidades")
        return count

    def listar_necessidades(self, id_filial: int,
                            status: str = 'PENDENTE',
                            prioridade: str = None,
                            cnpj_fornecedor: str = None,
                            limite: int = 100) -> List[Dict]:
        """Lista necessidades com filtros"""
        conditions = ["n.IDFilial = :id_filial"]
        params = {'id_filial': id_filial, 'limite': limite}

        if status:
            conditions.append("n.Status = :status")
            params['status'] = status

        if prioridade:
            conditions.append("n.Prioridade = :prioridade")
            params['prioridade'] = prioridade

        if cnpj_fornecedor:
            conditions.append("n.CNPJFornSuger = :cnpj")
            params['cnpj'] = cnpj_fornecedor

        sql = f"""
            SELECT n.*, p.Despro as nome_produto
            FROM ia_arqnecessi n
            LEFT JOIN arqproduto p ON p.IDProd = n.IDProd
            WHERE {' AND '.join(conditions)}
            ORDER BY n.ScorePrior DESC
            LIMIT :limite
        """

        result = self.db.executar_query(sql, params) or []
        return [self._parse_necessidade(r) for r in result]

    def atualizar_status_necessidade(self, id_necessi: int,
                                     status: str,
                                     usuario: str = None) -> bool:
        """Atualiza status de uma necessidade"""
        sql = """
            UPDATE ia_arqnecessi
            SET Status = :status,
                DatAprovacao = CASE WHEN :status IN ('APROVADA', 'REJEITADA') THEN NOW() ELSE DatAprovacao END,
                UserAprov = :usuario
            WHERE IDNecessi = :id
        """

        self.db.executar_query(sql, {
            'id': id_necessi,
            'status': status,
            'usuario': usuario
        })

        return True

    def vincular_ao_pedido(self, ids_necessidades: List[int],
                           id_pedido: int) -> int:
        """Vincula necessidades a um pedido"""
        if not ids_necessidades:
            return 0

        ids_str = ','.join(str(id_nec) for id_nec in ids_necessidades)

        sql = f"""
            UPDATE ia_arqnecessi
            SET IDNecPed = :id_pedido, Status = 'PEDIDO'
            WHERE IDNecessi IN ({ids_str})
        """

        self.db.executar_query(sql, {'id_pedido': id_pedido})
        return len(ids_necessidades)

    def cancelar_expiradas(self) -> int:
        """Cancela necessidades expiradas"""
        sql = """
            UPDATE ia_arqnecessi
            SET Status = 'CANCELADA'
            WHERE Status = 'PENDENTE'
              AND DatValidade < CURDATE()
        """

        self.db.executar_query(sql)

        # Contar afetados
        result = self.db.executar_query("SELECT ROW_COUNT() as count")
        count = result[0]['count'] if result else 0

        self.logger.info(f"Necessidades expiradas canceladas: {count}")
        return count

    # =========================================================================
    # PEDIDOS (ia_arqnecped)
    # =========================================================================

    def salvar_pedido(self, pedido: PedidoSugerido) -> int:
        """Salva um pedido sugerido"""
        sql = """
            INSERT INTO ia_arqnecped (
                IDFilial, CNPJForn, NomeForn, ScoreForn, ClassifForn,
                QtdItens, VlrTotal, VlrMinPedido, AtingeMinimoStr,
                PrioridadeMax, QtdUrgentes, QtdAlta,
                PrazoPgto, LeadTime,
                Status, DatGeracao
            ) VALUES (
                :id_filial, :cnpj, :nome, :score, :classif,
                :qtd_itens, :vlr_total, :vlr_minimo, :atinge,
                :prioridade, :qtd_urgentes, :qtd_alta,
                :prazo, :lead_time,
                'SUGERIDO', NOW()
            )
        """

        params = {
            'id_filial': pedido.id_filial,
            'cnpj': pedido.cnpj_fornecedor,
            'nome': pedido.nome_fornecedor[:100] if pedido.nome_fornecedor else '',
            'score': pedido.score_fornecedor,
            'classif': pedido.classif_fornecedor,
            'qtd_itens': pedido.qtd_itens,
            'vlr_total': pedido.vlr_total,
            'vlr_minimo': pedido.vlr_minimo_pedido,
            'atinge': 'SIM' if pedido.atinge_minimo else 'NAO',
            'prioridade': pedido.prioridade_max.value,
            'qtd_urgentes': pedido.qtd_urgentes,
            'qtd_alta': pedido.qtd_alta,
            'prazo': pedido.prazo_pgto,
            'lead_time': pedido.lead_time
        }

        self.db.executar_query(sql, params)

        # Retorna ID inserido
        result = self.db.executar_query("SELECT LAST_INSERT_ID() as id")
        id_pedido = result[0]['id'] if result else 0

        # Salva e vincula necessidades ao pedido
        ids_necessidades = []
        for item in pedido.itens:
            id_nec = self.salvar_necessidade(item)
            ids_necessidades.append(id_nec)

        self.vincular_ao_pedido(ids_necessidades, id_pedido)

        return id_pedido

    def salvar_pedidos_lote(self, pedidos: List[PedidoSugerido]) -> int:
        """Salva múltiplos pedidos"""
        count = 0
        for pedido in pedidos:
            try:
                self.salvar_pedido(pedido)
                count += 1
            except Exception as e:
                self.logger.error(f"Erro ao salvar pedido {pedido.cnpj_fornecedor}: {e}")

        self.logger.info(f"Salvos {count}/{len(pedidos)} pedidos")
        return count

    def listar_pedidos(self, id_filial: int,
                       status: str = None,
                       prioridade: str = None,
                       limite: int = 50) -> List[Dict]:
        """Lista pedidos sugeridos"""
        conditions = ["IDFilial = :id_filial"]
        params = {'id_filial': id_filial, 'limite': limite}

        if status:
            conditions.append("Status = :status")
            params['status'] = status

        if prioridade:
            conditions.append("PrioridadeMax = :prioridade")
            params['prioridade'] = prioridade

        sql = f"""
            SELECT *
            FROM ia_arqnecped
            WHERE {' AND '.join(conditions)}
            ORDER BY
                FIELD(PrioridadeMax, 'URGENTE', 'ALTA', 'NORMAL', 'BAIXA'),
                VlrTotal DESC
            LIMIT :limite
        """

        return self.db.executar_query(sql, params) or []

    def obter_pedido_com_itens(self, id_pedido: int) -> Optional[Dict]:
        """Obtém pedido com seus itens"""
        sql_pedido = "SELECT * FROM ia_arqnecped WHERE IDNecPed = :id"
        pedido = self.db.executar_query(sql_pedido, {'id': id_pedido})

        if not pedido:
            return None

        sql_itens = """
            SELECT n.*, p.Despro as nome_produto
            FROM ia_arqnecessi n
            LEFT JOIN arqproduto p ON p.IDProd = n.IDProd
            WHERE n.IDNecPed = :id
            ORDER BY n.ScorePrior DESC
        """
        itens = self.db.executar_query(sql_itens, {'id': id_pedido}) or []

        result = dict(pedido[0])
        result['itens'] = [self._parse_necessidade(i) for i in itens]

        return result

    def atualizar_status_pedido(self, id_pedido: int,
                                status: str,
                                usuario: str = None,
                                id_pedido_erp: int = None) -> bool:
        """Atualiza status de um pedido"""
        sql = """
            UPDATE ia_arqnecped
            SET Status = :status,
                DatAprovacao = CASE WHEN :status = 'APROVADO' THEN NOW() ELSE DatAprovacao END,
                DatEnvio = CASE WHEN :status = 'ENVIADO' THEN NOW() ELSE DatEnvio END,
                UserAprov = COALESCE(:usuario, UserAprov),
                IDPedidoERP = COALESCE(:id_erp, IDPedidoERP)
            WHERE IDNecPed = :id
        """

        self.db.executar_query(sql, {
            'id': id_pedido,
            'status': status,
            'usuario': usuario,
            'id_erp': id_pedido_erp
        })

        return True

    def resumo_filial(self, id_filial: int) -> Dict:
        """Resumo das necessidades da filial"""
        sql = """
            SELECT
                COUNT(*) as total,
                SUM(CASE WHEN Status = 'PENDENTE' THEN 1 ELSE 0 END) as pendentes,
                SUM(CASE WHEN Prioridade = 'URGENTE' AND Status = 'PENDENTE' THEN 1 ELSE 0 END) as urgentes,
                SUM(CASE WHEN Prioridade = 'ALTA' AND Status = 'PENDENTE' THEN 1 ELSE 0 END) as alta,
                SUM(CASE WHEN BloqCompra = 1 THEN 1 ELSE 0 END) as bloqueados,
                SUM(CASE WHEN Status = 'PENDENTE' THEN VlrTotalSuger ELSE 0 END) as vlr_total_pendente
            FROM ia_arqnecessi
            WHERE IDFilial = :id_filial
              AND DatValidade >= CURDATE()
        """

        result = self.db.executar_query(sql, {'id_filial': id_filial})

        if result:
            r = result[0]
            return {
                'total': r['total'] or 0,
                'pendentes': r['pendentes'] or 0,
                'urgentes': r['urgentes'] or 0,
                'alta_prioridade': r['alta'] or 0,
                'bloqueados': r['bloqueados'] or 0,
                'vlr_total_pendente': float(r['vlr_total_pendente'] or 0)
            }

        return {
            'total': 0, 'pendentes': 0, 'urgentes': 0,
            'alta_prioridade': 0, 'bloqueados': 0, 'vlr_total_pendente': 0
        }

    def _parse_necessidade(self, registro: Dict) -> Dict:
        """Parse JSON fields"""
        if registro.get('AlertasJSON'):
            try:
                registro['AlertasJSON'] = json.loads(registro['AlertasJSON'])
            except:
                registro['AlertasJSON'] = []

        return registro

    # =========================================================================
    # ASYNC ALIASES (para rotas)
    # =========================================================================

    async def buscar(self, id_filial: int, status: str = 'PENDENTE') -> List[Dict]:
        """Alias async de listar_necessidades."""
        return self.listar_necessidades(id_filial, status=status)

    async def obter_resumo(self, id_filial: int) -> Dict:
        """Alias async de resumo_filial."""
        return self.resumo_filial(id_filial)
