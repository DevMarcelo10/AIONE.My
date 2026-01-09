"""
AIONE IA - Gerador de Necessidades de Compra
Motor principal para geração de necessidades baseadas em forecast e classificação
"""

from dataclasses import dataclass, field
from datetime import datetime, date
from typing import List, Dict, Optional, Any
from enum import Enum

from core.database import DatabaseManager
from core.utils.logger import get_logger

logger = get_logger(__name__)


# =============================================================================
# ENUMS
# =============================================================================

class Prioridade(str, Enum):
    """Níveis de prioridade para necessidade de compra"""
    URGENTE = 'URGENTE'   # Ruptura iminente (< 3 dias) ou estoque zerado
    ALTA = 'ALTA'         # Abaixo do ponto de pedido
    NORMAL = 'NORMAL'     # Reposição programada
    BAIXA = 'BAIXA'       # Oportunidade de compra


class CenarioForecast(str, Enum):
    """Cenários de forecast para cálculo de quantidade"""
    OTIMISTA = 'OTIMISTA'
    CONSERVADOR = 'CONSERVADOR'
    CRITICO = 'CRITICO'


class StatusNecessidade(str, Enum):
    """Status do item de necessidade"""
    PENDENTE = 'PENDENTE'
    APROVADA = 'APROVADA'
    REJEITADA = 'REJEITADA'
    PEDIDO = 'PEDIDO'
    CANCELADA = 'CANCELADA'


class StatusPedido(str, Enum):
    """Status do pedido sugerido"""
    SUGERIDO = 'SUGERIDO'
    APROVADO = 'APROVADO'
    ENVIADO = 'ENVIADO'
    RECEBIDO = 'RECEBIDO'
    CANCELADO = 'CANCELADO'


# =============================================================================
# DATACLASSES - PARÂMETROS
# =============================================================================

@dataclass
class ParametrosNecessidade:
    """Parâmetros configuráveis da geração de necessidades"""

    # Cenário padrão
    cenario_padrao: CenarioForecast = CenarioForecast.CONSERVADOR

    # Dias de cobertura alvo
    dias_cobertura_alvo: int = 30

    # Limiares de prioridade
    dias_ruptura_urgente: int = 3       # Urgente se < 3 dias de estoque
    risco_ruptura_urgente: float = 0.5  # Urgente se risco > 50%

    # Filtros
    incluir_toxicos: bool = False       # Incluir produtos tóxicos?
    incluir_sem_giro: bool = False      # Incluir produtos sem giro?
    min_risco_ruptura: float = 0.0      # Mínimo risco para incluir

    # Fornecedor
    evitar_fornecedor_critico: bool = True
    preferir_melhor_preco: bool = False  # False = preferir melhor score

    # Agrupamento
    agrupar_por_fornecedor: bool = True
    atingir_pedido_minimo: bool = True

    # Validade
    dias_validade: int = 3              # Recalcular após X dias


# =============================================================================
# DATACLASSES - ITEM DE NECESSIDADE
# =============================================================================

@dataclass
class NecessidadeItem:
    """Item de necessidade de compra"""

    # Identificação
    id_filial: int
    id_prod: int
    id_grupo: Optional[int] = None
    nome_produto: str = ""

    # Prioridade
    prioridade: Prioridade = Prioridade.NORMAL
    score_prioridade: int = 0

    # Situação atual
    estoque_atual: float = 0.0
    estoque_seguranca: float = 0.0
    ponto_pedido: float = 0.0
    dias_cobertura: float = 0.0
    risco_ruptura: float = 0.0

    # Quantidade
    qtd_sugerida: float = 0.0
    qtd_minima: Optional[float] = None
    qtd_maxima: Optional[float] = None
    cenario_usado: CenarioForecast = CenarioForecast.CONSERVADOR

    # Fornecedor sugerido
    cnpj_fornecedor: Optional[str] = None
    nome_fornecedor: Optional[str] = None
    score_fornecedor: Optional[float] = None
    preco_sugerido: Optional[float] = None
    vlr_total: Optional[float] = None

    # Classificação
    classif_produto: Optional[str] = None
    curva_abc: Optional[str] = None
    bloqueado: bool = False
    motivo_bloqueio: Optional[str] = None

    # Justificativa
    motivo_necessidade: str = ""
    alertas: List[str] = field(default_factory=list)

    # Status
    status: StatusNecessidade = StatusNecessidade.PENDENTE
    data_geracao: datetime = None

    def __post_init__(self):
        if self.data_geracao is None:
            self.data_geracao = datetime.now()
        if self.alertas is None:
            self.alertas = []

    def to_dict(self) -> Dict[str, Any]:
        """Converte para dicionário"""
        return {
            'id_filial': self.id_filial,
            'id_prod': self.id_prod,
            'id_grupo': self.id_grupo,
            'nome_produto': self.nome_produto,
            'prioridade': self.prioridade.value,
            'score_prioridade': self.score_prioridade,
            'estoque_atual': self.estoque_atual,
            'estoque_seguranca': self.estoque_seguranca,
            'ponto_pedido': self.ponto_pedido,
            'dias_cobertura': self.dias_cobertura,
            'risco_ruptura': self.risco_ruptura,
            'qtd_sugerida': self.qtd_sugerida,
            'qtd_minima': self.qtd_minima,
            'qtd_maxima': self.qtd_maxima,
            'cenario_usado': self.cenario_usado.value,
            'cnpj_fornecedor': self.cnpj_fornecedor,
            'nome_fornecedor': self.nome_fornecedor,
            'score_fornecedor': self.score_fornecedor,
            'preco_sugerido': self.preco_sugerido,
            'vlr_total': self.vlr_total,
            'classif_produto': self.classif_produto,
            'curva_abc': self.curva_abc,
            'bloqueado': self.bloqueado,
            'motivo_bloqueio': self.motivo_bloqueio,
            'motivo_necessidade': self.motivo_necessidade,
            'alertas': self.alertas,
            'status': self.status.value,
            'data_geracao': self.data_geracao.isoformat() if self.data_geracao else None
        }


# =============================================================================
# DATACLASSES - PEDIDO SUGERIDO
# =============================================================================

@dataclass
class PedidoSugerido:
    """Pedido sugerido agrupado por fornecedor"""

    id_filial: int
    cnpj_fornecedor: str
    nome_fornecedor: str

    # Totais
    itens: List[NecessidadeItem] = field(default_factory=list)
    qtd_itens: int = 0
    vlr_total: float = 0.0

    # Fornecedor
    score_fornecedor: Optional[float] = None
    classif_fornecedor: Optional[str] = None
    vlr_minimo_pedido: Optional[float] = None
    atinge_minimo: bool = True

    # Prioridade
    prioridade_max: Prioridade = Prioridade.NORMAL
    qtd_urgentes: int = 0
    qtd_alta: int = 0

    # Condições
    prazo_pgto: Optional[int] = None
    lead_time: Optional[int] = None

    # Status
    status: StatusPedido = StatusPedido.SUGERIDO
    data_geracao: datetime = None

    def __post_init__(self):
        if self.data_geracao is None:
            self.data_geracao = datetime.now()
        if self.itens is None:
            self.itens = []

    def adicionar_item(self, item: NecessidadeItem):
        """Adiciona item ao pedido e recalcula totais"""
        self.itens.append(item)
        self._recalcular_totais()

    def remover_item(self, id_prod: int):
        """Remove item do pedido pelo ID do produto"""
        self.itens = [i for i in self.itens if i.id_prod != id_prod]
        self._recalcular_totais()

    def _recalcular_totais(self):
        """Recalcula totais do pedido"""
        self.qtd_itens = len(self.itens)
        self.vlr_total = sum(i.vlr_total or 0 for i in self.itens)

        # Atualiza prioridade máxima
        prioridades = {'URGENTE': 4, 'ALTA': 3, 'NORMAL': 2, 'BAIXA': 1}
        self.prioridade_max = Prioridade.BAIXA
        for i in self.itens:
            if prioridades.get(i.prioridade.value, 0) > prioridades.get(self.prioridade_max.value, 0):
                self.prioridade_max = i.prioridade

        self.qtd_urgentes = sum(1 for i in self.itens if i.prioridade == Prioridade.URGENTE)
        self.qtd_alta = sum(1 for i in self.itens if i.prioridade == Prioridade.ALTA)

        # Verifica mínimo
        if self.vlr_minimo_pedido:
            self.atinge_minimo = self.vlr_total >= self.vlr_minimo_pedido

    def to_dict(self) -> Dict[str, Any]:
        """Converte para dicionário"""
        return {
            'id_filial': self.id_filial,
            'cnpj_fornecedor': self.cnpj_fornecedor,
            'nome_fornecedor': self.nome_fornecedor,
            'qtd_itens': self.qtd_itens,
            'vlr_total': self.vlr_total,
            'vlr_minimo_pedido': self.vlr_minimo_pedido,
            'atinge_minimo': self.atinge_minimo,
            'score_fornecedor': self.score_fornecedor,
            'classif_fornecedor': self.classif_fornecedor,
            'prioridade_max': self.prioridade_max.value,
            'qtd_urgentes': self.qtd_urgentes,
            'qtd_alta': self.qtd_alta,
            'prazo_pgto': self.prazo_pgto,
            'lead_time': self.lead_time,
            'status': self.status.value,
            'data_geracao': self.data_geracao.isoformat() if self.data_geracao else None,
            'itens': [i.to_dict() for i in self.itens]
        }


# =============================================================================
# MOTOR PRINCIPAL
# =============================================================================

class GeradorNecessidade:
    """Motor principal de geração de necessidades de compra"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

        # Componentes (lazy loading)
        self._priorizador = None
        self._sugestor = None
        self._agrupador = None
        self._repositorio = None

        # Parâmetros padrão
        self.parametros = ParametrosNecessidade()

    @property
    def priorizador(self):
        """Lazy loading do priorizador"""
        if self._priorizador is None:
            from .priorizador import Priorizador
            self._priorizador = Priorizador(self.db)
        return self._priorizador

    @property
    def sugestor(self):
        """Lazy loading do sugestor de fornecedor"""
        if self._sugestor is None:
            from .sugestor_forn import SugestorFornecedor
            self._sugestor = SugestorFornecedor(self.db)
        return self._sugestor

    @property
    def agrupador(self):
        """Lazy loading do agrupador"""
        if self._agrupador is None:
            from .agrupador import AgrupadorPedidos
            self._agrupador = AgrupadorPedidos(self.db)
        return self._agrupador

    @property
    def repositorio(self):
        """Lazy loading do repositório"""
        if self._repositorio is None:
            from .repositorio import NecessidadeRepositorio
            self._repositorio = NecessidadeRepositorio(self.db)
        return self._repositorio

    # =========================================================================
    # MÉTODO PRINCIPAL
    # =========================================================================

    def gerar_necessidades(self, id_filial: int,
                           parametros: ParametrosNecessidade = None,
                           salvar: bool = True) -> Dict:
        """
        Gera lista de necessidades de compra para uma filial.

        Fluxo:
        1. Busca produtos que precisam de compra (forecast + classificação)
        2. Filtra por critérios (não incluir tóxicos, etc)
        3. Calcula quantidade a comprar
        4. Prioriza
        5. Sugere fornecedor
        6. Agrupa em pedidos
        7. Persiste

        Returns: {
            'necessidades': List[NecessidadeItem],
            'pedidos': List[PedidoSugerido],
            'resumo': Dict
        }
        """
        params = parametros or self.parametros

        self.logger.info(f"Gerando necessidades para filial {id_filial}")

        try:
            # 1. Busca produtos que precisam de compra
            produtos = self._buscar_produtos_necessidade(id_filial, params)
            self.logger.info(f"Encontrados {len(produtos)} produtos com necessidade potencial")

            # 2. Cria itens de necessidade
            itens = []
            for prod in produtos:
                item = self._criar_item_necessidade(prod, id_filial, params)
                if item and not item.bloqueado:
                    itens.append(item)
                elif item and item.bloqueado:
                    # Salva bloqueados separadamente para registro
                    if salvar:
                        self.repositorio.salvar_necessidade(item, params.dias_validade)

            self.logger.info(f"Criados {len(itens)} itens de necessidade (excluindo bloqueados)")

            # 3. Prioriza
            itens = self.priorizador.priorizar_lista(itens, params)

            # 4. Sugere fornecedor
            itens = self.sugestor.sugerir_para_lista(itens, params)

            # 5. Agrupa em pedidos
            pedidos = []
            if params.agrupar_por_fornecedor:
                pedidos = self.agrupador.agrupar_por_fornecedor(itens, params)

                # Tenta completar pedidos abaixo do mínimo
                if params.atingir_pedido_minimo:
                    for i, pedido in enumerate(pedidos):
                        if not pedido.atinge_minimo:
                            pedidos[i] = self.agrupador.completar_pedido_minimo(
                                pedido, id_filial, params
                            )

            # 6. Persiste
            if salvar:
                if params.agrupar_por_fornecedor:
                    self.repositorio.salvar_pedidos_lote(pedidos)
                else:
                    self.repositorio.salvar_necessidades_lote(itens, params.dias_validade)

            # 7. Resumo
            resumo = {
                'total_itens': len(itens),
                'total_pedidos': len(pedidos),
                'prioridades': self.priorizador.resumo_prioridades(itens),
                'pedidos': self.agrupador.resumo_pedidos(pedidos) if pedidos else {},
                'vlr_total': sum(i.vlr_total or 0 for i in itens)
            }

            self.logger.info(f"Geração concluída: {len(itens)} itens, {len(pedidos)} pedidos")

            return {
                'necessidades': itens,
                'pedidos': pedidos,
                'resumo': resumo
            }

        except Exception as e:
            self.logger.error(f"Erro ao gerar necessidades: {e}")
            raise

    # =========================================================================
    # MÉTODOS AUXILIARES
    # =========================================================================

    def _buscar_produtos_necessidade(self, id_filial: int,
                                     params: ParametrosNecessidade) -> List[Dict]:
        """
        Busca produtos que precisam de compra.

        Usa dados do forecast (ia_arqforecast) e classificação (ia_arqprodclas).
        """
        conditions = ["fc.IDFilial = :id_filial", "fc.Status = 'ATIVO'"]

        # Filtra por risco de ruptura mínimo
        if params.min_risco_ruptura > 0:
            conditions.append(f"fc.RiscoRupt >= {params.min_risco_ruptura}")

        # Filtra produtos abaixo do ponto de pedido ou com cobertura baixa
        conditions.append(f"(fc.EstqAtual <= fc.PontoPed OR fc.DiasCobre < {params.dias_cobertura_alvo})")

        # Filtra tóxicos
        if not params.incluir_toxicos:
            conditions.append("(pc.Classif IS NULL OR pc.Classif != 'TOXICO')")

        sql = f"""
            SELECT
                fc.IDProd,
                fc.IDFilial,
                fc.IDGrupo,
                p.Despro as nome_produto,

                -- Forecast
                fc.EstqAtual,
                fc.EstqSegur,
                fc.PontoPed,
                fc.DiasCobre,
                fc.RiscoRupt,
                fc.ConsMedio,
                fc.CenOtim,
                fc.CenCons,
                fc.CenCrit,
                fc.Tendencia,

                -- Classificação
                pc.Classif as classif_produto,
                pc.CurvaABC,
                pc.BloqCompra,
                pc.BloqMotivo

            FROM ia_arqforecast fc
            LEFT JOIN ia_arqprodclas pc ON pc.IDProd = fc.IDProd
                                        AND pc.IDFilial = fc.IDFilial
                                        AND pc.Status = 'ATIVO'
            INNER JOIN arqproduto p ON p.IDProd = fc.IDProd
            WHERE {' AND '.join(conditions)}
            ORDER BY fc.RiscoRupt DESC, fc.DiasCobre ASC
        """

        return self.db.executar_query(sql, {'id_filial': id_filial}) or []

    def _criar_item_necessidade(self, prod: Dict, id_filial: int,
                                params: ParametrosNecessidade) -> NecessidadeItem:
        """Cria item de necessidade a partir dos dados do produto"""

        # Determina quantidade baseada no cenário
        if params.cenario_padrao == CenarioForecast.OTIMISTA:
            qtd_base = float(prod.get('CenOtim') or 0)
        elif params.cenario_padrao == CenarioForecast.CRITICO:
            qtd_base = float(prod.get('CenCrit') or 0)
        else:
            qtd_base = float(prod.get('CenCons') or 0)

        # Ajusta pela classificação
        classif = prod.get('classif_produto')
        if classif == 'ATENCAO':
            qtd_base *= 0.8  # Reduz 20% para produtos em atenção
        elif classif == 'TOXICO':
            qtd_base = 0  # Não comprar

        # Verifica bloqueio
        bloqueado = bool(prod.get('BloqCompra'))
        motivo_bloq = prod.get('BloqMotivo')

        if classif == 'TOXICO' and not params.incluir_toxicos:
            bloqueado = True
            motivo_bloq = "Produto classificado como TÓXICO"

        item = NecessidadeItem(
            id_filial=id_filial,
            id_prod=prod['IDProd'],
            id_grupo=prod.get('IDGrupo'),
            nome_produto=prod.get('nome_produto', ''),

            estoque_atual=float(prod.get('EstqAtual') or 0),
            estoque_seguranca=float(prod.get('EstqSegur') or 0),
            ponto_pedido=float(prod.get('PontoPed') or 0),
            dias_cobertura=float(prod.get('DiasCobre') or 0),
            risco_ruptura=float(prod.get('RiscoRupt') or 0),

            qtd_sugerida=max(0, qtd_base),
            cenario_usado=params.cenario_padrao,

            classif_produto=classif,
            curva_abc=prod.get('CurvaABC'),
            bloqueado=bloqueado,
            motivo_bloqueio=motivo_bloq
        )

        return item

    def gerar_necessidade_produto(self, id_prod: int, id_filial: int,
                                  parametros: ParametrosNecessidade = None,
                                  salvar: bool = True) -> NecessidadeItem:
        """
        Gera necessidade para um produto específico.
        """
        params = parametros or self.parametros

        # Busca dados do produto
        sql = """
            SELECT
                fc.IDProd, fc.IDFilial, fc.IDGrupo, p.Despro as nome_produto,
                fc.EstqAtual, fc.EstqSegur, fc.PontoPed, fc.DiasCobre, fc.RiscoRupt,
                fc.ConsMedio, fc.CenOtim, fc.CenCons, fc.CenCrit,
                pc.Classif as classif_produto, pc.CurvaABC, pc.BloqCompra, pc.BloqMotivo
            FROM ia_arqforecast fc
            LEFT JOIN ia_arqprodclas pc ON pc.IDProd = fc.IDProd
                                        AND pc.IDFilial = fc.IDFilial AND pc.Status = 'ATIVO'
            INNER JOIN arqproduto p ON p.IDProd = fc.IDProd
            WHERE fc.IDProd = :id_prod AND fc.IDFilial = :id_filial AND fc.Status = 'ATIVO'
        """

        result = self.db.executar_query(sql, {'id_prod': id_prod, 'id_filial': id_filial})

        if not result:
            raise ValueError(f"Produto {id_prod} não encontrado ou sem forecast")

        item = self._criar_item_necessidade(result[0], id_filial, params)
        item = self.priorizador.calcular_prioridade(item, params)
        item = self.sugestor.sugerir_fornecedor(item, params)

        if salvar and not item.bloqueado:
            self.repositorio.salvar_necessidade(item, params.dias_validade)

        return item

    def obter_necessidades_pendentes(self, id_filial: int,
                                     prioridade: str = None,
                                     limite: int = 100) -> List[Dict]:
        """Retorna necessidades pendentes"""
        return self.repositorio.listar_necessidades(
            id_filial=id_filial,
            status='PENDENTE',
            prioridade=prioridade,
            limite=limite
        )

    def obter_pedidos_sugeridos(self, id_filial: int,
                                limite: int = 50) -> List[Dict]:
        """Retorna pedidos sugeridos"""
        return self.repositorio.listar_pedidos(
            id_filial=id_filial,
            status='SUGERIDO',
            limite=limite
        )
