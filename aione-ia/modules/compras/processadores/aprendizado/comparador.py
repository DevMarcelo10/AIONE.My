from dataclasses import dataclass, field
from datetime import datetime, date, timedelta
from typing import List, Dict, Optional, Any
from enum import Enum

from core.database import DatabaseManager
from core.utils.logger import get_logger

class TipoDesvio(str, Enum):
    ACERTO = 'ACERTO'           # Desvio < 10%
    SUBESTIMOU = 'SUBESTIMOU'   # Previu menos do que vendeu
    SUPERESTIMOU = 'SUPERESTIMOU'  # Previu mais do que vendeu

class ClassificacaoAcerto(str, Enum):
    EXCELENTE = 'EXCELENTE'   # Acurácia >= 95%
    BOM = 'BOM'               # Acurácia 85-94%
    REGULAR = 'REGULAR'       # Acurácia 70-84%
    RUIM = 'RUIM'             # Acurácia 50-69%
    PESSIMO = 'PESSIMO'       # Acurácia < 50%

class TipoPeriodo(str, Enum):
    DIARIO = 'DIARIO'
    SEMANAL = 'SEMANAL'
    MENSAL = 'MENSAL'

class TipoAjuste(str, Enum):
    ESTOQUE_SEGURANCA = 'ESTOQUE_SEGURANCA'
    SAZONALIDADE = 'SAZONALIDADE'
    TENDENCIA = 'TENDENCIA'
    CORRELACAO_EVENTO = 'CORRELACAO_EVENTO'
    LEAD_TIME = 'LEAD_TIME'
    PONTO_PEDIDO = 'PONTO_PEDIDO'

@dataclass
class ResultadoComparacao:
    """Resultado da comparação previsão x realidade"""

    # Identificação
    id_filial: int
    id_prod: int
    id_grupo: Optional[int] = None

    # Período
    data_inicio: date = None
    data_fim: date = None
    dias_analise: int = 0

    # Previsão
    qtd_prevista: float = 0.0
    cenario_usado: str = "CONSERVADOR"
    confianca_previsao: float = 0.0

    # Realidade
    qtd_realizada: float = 0.0
    qtd_ruptura: float = 0.0
    dias_ruptura: int = 0

    # Desvio
    desvio: float = 0.0
    desvio_perc: float = 0.0
    desvio_abs: float = 0.0
    tipo_desvio: TipoDesvio = TipoDesvio.ACERTO

    # Acurácia
    acuracia: float = 0.0
    classificacao: ClassificacaoAcerto = ClassificacaoAcerto.REGULAR

    # Fatores
    teve_evento: bool = False
    teve_promocao: bool = False
    teve_ruptura: bool = False
    fatores: List[str] = field(default_factory=list)

    def to_dict(self) -> Dict[str, Any]:
        return {
            'id_filial': self.id_filial,
            'id_prod': self.id_prod,
            'data_inicio': str(self.data_inicio),
            'data_fim': str(self.data_fim),
            'qtd_prevista': self.qtd_prevista,
            'qtd_realizada': self.qtd_realizada,
            'desvio_perc': self.desvio_perc,
            'acuracia': self.acuracia,
            'classificacao': self.classificacao.value,
            'tipo_desvio': self.tipo_desvio.value,
            'teve_ruptura': self.teve_ruptura
        }

@dataclass
class MetricasConsolidadas:
    """Métricas consolidadas de um período"""

    id_filial: int
    id_grupo: Optional[int] = None
    periodo: str = ""
    tipo_periodo: TipoPeriodo = TipoPeriodo.MENSAL
    data_inicio: date = None
    data_fim: date = None

    # Métricas de acurácia
    mape: float = 0.0           # Mean Absolute Percentage Error
    bias: float = 0.0           # Viés (positivo=superestima)
    mae: float = 0.0            # Mean Absolute Error
    rmse: float = 0.0           # Root Mean Square Error
    acuracia_media: float = 0.0

    # Distribuição
    qtd_produtos: int = 0
    qtd_excelente: int = 0
    qtd_bom: int = 0
    qtd_regular: int = 0
    qtd_ruim: int = 0
    qtd_pessimo: int = 0

    # Ruptura
    dias_ruptura_total: int = 0
    produtos_ruptura: int = 0
    vlr_perda_estimada: float = 0.0
    taxa_ruptura: float = 0.0

    # Comparativo
    mape_anterior: Optional[float] = None
    variacao_mape: Optional[float] = None
    tendencia: str = "ESTAVEL"

    def to_dict(self) -> Dict[str, Any]:
        return {
            'id_filial': self.id_filial,
            'id_grupo': self.id_grupo,
            'periodo': self.periodo,
            'mape': self.mape,
            'bias': self.bias,
            'acuracia_media': self.acuracia_media,
            'qtd_produtos': self.qtd_produtos,
            'taxa_ruptura': self.taxa_ruptura,
            'tendencia': self.tendencia,
            'distribuicao': {
                'excelente': self.qtd_excelente,
                'bom': self.qtd_bom,
                'regular': self.qtd_regular,
                'ruim': self.qtd_ruim,
                'pessimo': self.qtd_pessimo
            }
        }

@dataclass
class SugestaoAjuste:
    """Sugestão de ajuste baseada no aprendizado"""

    id_filial: int
    id_prod: Optional[int] = None
    id_grupo: Optional[int] = None

    tipo_ajuste: TipoAjuste = TipoAjuste.ESTOQUE_SEGURANCA
    valor_anterior: float = 0.0
    valor_novo: float = 0.0
    variacao_perc: float = 0.0

    motivo: str = ""
    baseado_em: str = ""
    automatico: bool = True
    prioridade: int = 0  # 1=alta, 2=média, 3=baixa

    def to_dict(self) -> Dict[str, Any]:
        return {
            'id_filial': self.id_filial,
            'id_prod': self.id_prod,
            'tipo_ajuste': self.tipo_ajuste.value,
            'valor_anterior': self.valor_anterior,
            'valor_novo': self.valor_novo,
            'variacao_perc': self.variacao_perc,
            'motivo': self.motivo,
            'prioridade': self.prioridade
        }

class Comparador:
    """
    Comparador de previsão x realidade.

    Compara o que o forecast previu com o que realmente aconteceu.
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def comparar_produto(self, id_prod: int, id_filial: int,
                         data_inicio: date, data_fim: date) -> ResultadoComparacao:
        """
        Compara previsão x realidade para um produto em um período.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            data_inicio: Data início do período
            data_fim: Data fim do período

        Returns: ResultadoComparacao
        """

        dias = (data_fim - data_inicio).days + 1

        # Busca previsão (forecast do período)
        previsao = self._buscar_previsao(id_prod, id_filial, data_inicio, data_fim)

        # Busca realidade (vendas do período)
        realidade = self._buscar_vendas_reais(id_prod, id_filial, data_inicio, data_fim)

        # Busca rupturas
        ruptura = self._buscar_rupturas(id_prod, id_filial, data_inicio, data_fim)

        # Busca fatores (eventos, promoções)
        fatores = self._buscar_fatores(id_prod, id_filial, data_inicio, data_fim)

        # Calcula desvio
        qtd_prevista = previsao.get('qtd_prevista', 0)
        qtd_realizada = realidade.get('qtd_vendida', 0)

        desvio = qtd_realizada - qtd_prevista
        desvio_abs = abs(desvio)

        if qtd_prevista > 0:
            desvio_perc = (desvio / qtd_prevista) * 100
        elif qtd_realizada > 0:
            desvio_perc = 100  # Previu zero, vendeu algo
        else:
            desvio_perc = 0  # Ambos zero

        # Determina tipo de desvio
        if abs(desvio_perc) <= 10:
            tipo_desvio = TipoDesvio.ACERTO
        elif desvio > 0:
            tipo_desvio = TipoDesvio.SUBESTIMOU
        else:
            tipo_desvio = TipoDesvio.SUPERESTIMOU

        # Calcula acurácia (100 - MAPE)
        if qtd_realizada > 0:
            mape_item = (desvio_abs / qtd_realizada) * 100
        else:
            mape_item = 0 if qtd_prevista == 0 else 100

        acuracia = max(0, 100 - mape_item)

        # Classifica acerto
        classificacao = self._classificar_acuracia(acuracia)

        return ResultadoComparacao(
            id_filial=id_filial,
            id_prod=id_prod,
            id_grupo=previsao.get('id_grupo'),
            data_inicio=data_inicio,
            data_fim=data_fim,
            dias_analise=dias,
            qtd_prevista=qtd_prevista,
            cenario_usado=previsao.get('cenario', 'CONSERVADOR'),
            confianca_previsao=previsao.get('confianca', 0),
            qtd_realizada=qtd_realizada,
            qtd_ruptura=ruptura.get('qtd_perdida', 0),
            dias_ruptura=ruptura.get('dias', 0),
            desvio=desvio,
            desvio_perc=round(desvio_perc, 2),
            desvio_abs=desvio_abs,
            tipo_desvio=tipo_desvio,
            acuracia=round(acuracia, 2),
            classificacao=classificacao,
            teve_evento=fatores.get('teve_evento', False),
            teve_promocao=fatores.get('teve_promocao', False),
            teve_ruptura=ruptura.get('dias', 0) > 0,
            fatores=fatores.get('lista', [])
        )

    def comparar_filial(self, id_filial: int,
                        data_inicio: date, data_fim: date,
                        id_grupo: int = None) -> List[ResultadoComparacao]:
        """
        Compara todos os produtos de uma filial (ou grupo).
        """

        # Busca produtos com forecast no período
        produtos = self._buscar_produtos_com_forecast(id_filial, data_inicio, id_grupo)

        resultados = []
        for prod in produtos:
            try:
                resultado = self.comparar_produto(
                    prod['IDProd'], id_filial, data_inicio, data_fim
                )
                resultados.append(resultado)
            except Exception as e:
                self.logger.error(f"Erro ao comparar produto {prod['IDProd']}: {e}")

        self.logger.info(f"Comparados {len(resultados)} produtos da filial {id_filial}")

        return resultados

    def _buscar_previsao(self, id_prod: int, id_filial: int,
                         data_inicio: date, data_fim: date) -> Dict:
        """Busca previsão do forecast para o período"""

        dias = (data_fim - data_inicio).days + 1

        # Busca forecast mais próximo da data_inicio
        sql = """
            SELECT
                fc.IDGrupo as id_grupo,
                fc.ConsMedio * :dias as qtd_prevista,
                fc.CenCons as cenario_conservador,
                fc.Confianca as confianca,
                'CONSERVADOR' as cenario
            FROM ia_arqforecast fc
            WHERE fc.IDProd = :id_prod
              AND fc.IDFilial = :id_filial
              AND fc.Status = 'ATIVO'
            ORDER BY fc.DatCalculo DESC
            LIMIT 1
        """

        result = self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'dias': dias
        })

        if result:
            return {
                'id_grupo': result[0].get('id_grupo'),
                'qtd_prevista': float(result[0].get('qtd_prevista') or 0),
                'cenario': result[0].get('cenario', 'CONSERVADOR'),
                'confianca': float(result[0].get('confianca') or 0)
            }

        return {'qtd_prevista': 0, 'cenario': 'CONSERVADOR', 'confianca': 0}

    def _buscar_vendas_reais(self, id_prod: int, id_filial: int,
                             data_inicio: date, data_fim: date) -> Dict:
        """Busca vendas reais do período"""

        sql = """
            SELECT
                COALESCE(SUM(h.QtdMovi), 0) as qtd_vendida,
                COALESCE(SUM(h.VlrMovi * h.QtdMovi), 0) as vlr_vendido,
                COUNT(DISTINCT DATE(h.DatMovi)) as dias_venda
            FROM ia_arqhistcom h
            WHERE h.IDProd = :id_prod
              AND h.IDFilial = :id_filial
              AND h.TipoHist = 'SAIDA'
              AND DATE(h.DatMovi) BETWEEN :data_inicio AND :data_fim
        """

        result = self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'data_fim': data_fim
        })

        if result:
            return {
                'qtd_vendida': float(result[0].get('qtd_vendida') or 0),
                'vlr_vendido': float(result[0].get('vlr_vendido') or 0),
                'dias_venda': int(result[0].get('dias_venda') or 0)
            }

        return {'qtd_vendida': 0, 'vlr_vendido': 0, 'dias_venda': 0}

    def _buscar_rupturas(self, id_prod: int, id_filial: int,
                         data_inicio: date, data_fim: date) -> Dict:
        """Busca dias com ruptura (estoque zerado)"""

        # Busca do histórico de estoque ou movimentações
        sql = """
            SELECT
                COUNT(*) as dias_ruptura
            FROM (
                SELECT DATE(h.DatMovi) as dia
                FROM ia_arqhistcom h
                WHERE h.IDProd = :id_prod
                  AND h.IDFilial = :id_filial
                  AND DATE(h.DatMovi) BETWEEN :data_inicio AND :data_fim
                GROUP BY DATE(h.DatMovi)
                HAVING SUM(CASE WHEN h.TipoHist = 'ENTRADA' THEN h.QtdMovi ELSE 0 END) -
                       SUM(CASE WHEN h.TipoHist = 'SAIDA' THEN h.QtdMovi ELSE 0 END) <= 0
            ) as dias_sem_estoque
        """

        result = self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'data_fim': data_fim
        })

        dias_ruptura = int(result[0].get('dias_ruptura') or 0) if result else 0

        # Estima perda por ruptura (média diária * dias ruptura)
        if dias_ruptura > 0:
            sql_media = """
                SELECT AVG(qtd_dia) as media_dia
                FROM (
                    SELECT DATE(h.DatMovi), SUM(h.QtdMovi) as qtd_dia
                    FROM ia_arqhistcom h
                    WHERE h.IDProd = :id_prod
                      AND h.IDFilial = :id_filial
                      AND h.TipoHist = 'SAIDA'
                      AND DATE(h.DatMovi) BETWEEN :data_inicio AND :data_fim
                    GROUP BY DATE(h.DatMovi)
                ) as vendas_dia
            """
            media = self.db.execute_query(sql_media, {
                'id_prod': id_prod,
                'id_filial': id_filial,
                'data_inicio': data_inicio,
                'data_fim': data_fim
            })
            media_dia = float(media[0].get('media_dia') or 0) if media else 0
            qtd_perdida = media_dia * dias_ruptura
        else:
            qtd_perdida = 0

        return {
            'dias': dias_ruptura,
            'qtd_perdida': qtd_perdida
        }

    def _buscar_fatores(self, id_prod: int, id_filial: int,
                        data_inicio: date, data_fim: date) -> Dict:
        """Busca fatores que podem ter influenciado (eventos, promoções)"""

        fatores = []
        teve_evento = False
        teve_promocao = False

        # Verifica eventos
        sql_eventos = """
            SELECT e.NomEvento, e.TipoEvento
            FROM ia_arqevento e
            WHERE e.IDFilial = :id_filial
              AND e.DatEvento BETWEEN :data_inicio AND :data_fim
              AND e.Status = 'ATIVO'
        """
        eventos = self.db.execute_query(sql_eventos, {
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'data_fim': data_fim
        })

        if eventos:
            teve_evento = True
            for ev in eventos:
                fatores.append(f"Evento: {ev['NomEvento']}")

        # Verifica promoções (simplificado - pode ser expandido)
        sql_promo = """
            SELECT COUNT(*) as qtd
            FROM ia_arqhistcom h
            WHERE h.IDProd = :id_prod
              AND h.IDFilial = :id_filial
              AND h.TipoHist = 'SAIDA'
              AND DATE(h.DatMovi) BETWEEN :data_inicio AND :data_fim
              AND h.PercDesc > 10
        """
        promo = self.db.execute_query(sql_promo, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'data_fim': data_fim
        })

        if promo and promo[0].get('qtd', 0) > 0:
            teve_promocao = True
            fatores.append("Promoção detectada (desconto > 10%)")

        return {
            'teve_evento': teve_evento,
            'teve_promocao': teve_promocao,
            'lista': fatores
        }

    def _buscar_produtos_com_forecast(self, id_filial: int,
                                       data_referencia: date,
                                       id_grupo: int = None) -> List[Dict]:
        """Busca produtos que têm forecast ativo"""

        conditions = ["fc.IDFilial = :id_filial", "fc.Status = 'ATIVO'"]
        params = {'id_filial': id_filial}

        if id_grupo:
            conditions.append("fc.IDGrupo = :id_grupo")
            params['id_grupo'] = id_grupo

        sql = f"""
            SELECT DISTINCT fc.IDProd, fc.IDGrupo
            FROM ia_arqforecast fc
            WHERE {' AND '.join(conditions)}
        """

        return self.db.execute_query(sql, params)

    def _classificar_acuracia(self, acuracia: float) -> ClassificacaoAcerto:
        """Classifica a acurácia"""

        if acuracia >= 95:
            return ClassificacaoAcerto.EXCELENTE
        elif acuracia >= 85:
            return ClassificacaoAcerto.BOM
        elif acuracia >= 70:
            return ClassificacaoAcerto.REGULAR
        elif acuracia >= 50:
            return ClassificacaoAcerto.RUIM
        else:
            return ClassificacaoAcerto.PESSIMO