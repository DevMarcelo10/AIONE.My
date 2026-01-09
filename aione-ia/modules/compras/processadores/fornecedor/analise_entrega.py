"""
AIONE IA - Analisador de Entregas de Fornecedores
Análise de pontualidade e lead time
"""

from datetime import date, timedelta
from typing import Dict, List, Optional
from decimal import Decimal

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .analisador import MetricasEntrega, ParametrosScoreFornecedor

logger = get_logger(__name__)


class AnalisadorEntregaFornecedor:
    """
    Analisador de entregas de fornecedores.

    Avalia desempenho de entrega através de:
    - Lead time médio (dias entre pedido e recebimento)
    - Pontualidade (% de entregas no prazo)
    - Atrasos (frequência e duração média)

    Attributes:
        db: Gerenciador de banco de dados

    Example:
        >>> analisador = AnalisadorEntregaFornecedor(db)
        >>> metricas = analisador.analisar('12345678000190', 1)
        >>> print(metricas.pontualidade_perc)
        85.5
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o analisador.

        Args:
            db: Gerenciador de banco de dados
        """
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def analisar(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int = 180,
        parametros: Optional[ParametrosScoreFornecedor] = None
    ) -> MetricasEntrega:
        """
        Analisa entregas do fornecedor.

        Métricas calculadas:
        1. Lead time médio (dias entre pedido e recebimento)
        2. Pontualidade (% entregas no prazo)
        3. Atraso médio (quando atrasa)

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise em dias
            parametros: Parâmetros de configuração

        Returns:
            MetricasEntrega com todas as métricas calculadas
        """
        params = parametros or ParametrosScoreFornecedor()

        # Busca dados de entregas
        entregas = self._buscar_entregas(cnpj_forn, id_filial, dias)

        if not entregas['total_pedidos']:
            # Score neutro se não tem dados suficientes
            return MetricasEntrega(score=50)

        # Calcula score
        score = self._calcular_score(entregas, params)

        return MetricasEntrega(
            lead_time_medio=round(entregas['lead_time_medio'], 1),
            pontualidade_perc=round(entregas['pontualidade'], 1),
            atraso_medio_dias=round(entregas['atraso_medio'], 1),
            total_pedidos=entregas['total_pedidos'],
            pedidos_atraso=entregas['pedidos_atraso'],
            score=score
        )

    def _buscar_entregas(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int
    ) -> Dict:
        """
        Busca dados de entregas do fornecedor.

        Usa:
        - arqcomprarec.DatPed (data do pedido)
        - arqcomprarec.DatRece (data do recebimento)
        - arqcomprarec.DatPrevi (data prevista - se disponível)

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Dict com métricas de entrega
        """
        data_inicio = date.today() - timedelta(days=dias)

        # Análise de lead time e pontualidade
        sql = """
            SELECT
                COUNT(*) as total_pedidos,
                AVG(DATEDIFF(r.DatRece, r.DatPed)) as lead_time_medio,
                SUM(CASE
                    WHEN r.DatPrevi IS NOT NULL AND r.DatRece <= r.DatPrevi THEN 1
                    WHEN r.DatPrevi IS NULL THEN 1  -- Sem previsão = considerado no prazo
                    ELSE 0
                END) as pedidos_no_prazo,
                SUM(CASE
                    WHEN r.DatPrevi IS NOT NULL AND r.DatRece > r.DatPrevi THEN 1
                    ELSE 0
                END) as pedidos_atraso,
                AVG(CASE
                    WHEN r.DatPrevi IS NOT NULL AND r.DatRece > r.DatPrevi
                    THEN DATEDIFF(r.DatRece, r.DatPrevi)
                    ELSE NULL
                END) as atraso_medio
            FROM arqcomprarec r
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'  -- Finalizada
              AND r.DatRece >= :data_inicio
              AND r.DatPed IS NOT NULL
              AND r.DatRece IS NOT NULL
        """

        result = self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        if not result or not result[0]['total_pedidos']:
            return {
                'total_pedidos': 0,
                'lead_time_medio': 0,
                'pontualidade': 0,
                'pedidos_atraso': 0,
                'atraso_medio': 0
            }

        r = result[0]
        total = int(r['total_pedidos'] or 0)
        no_prazo = int(r['pedidos_no_prazo'] or 0)

        return {
            'total_pedidos': total,
            'lead_time_medio': float(r['lead_time_medio'] or 0),
            'pontualidade': (no_prazo / total * 100) if total > 0 else 0,
            'pedidos_atraso': int(r['pedidos_atraso'] or 0),
            'atraso_medio': float(r['atraso_medio'] or 0)
        }

    def _calcular_score(
        self,
        entregas: Dict,
        params: ParametrosScoreFornecedor
    ) -> float:
        """
        Calcula score de entrega (0-100).

        Componentes:
        - Pontualidade (60%): quanto maior, melhor
        - Lead time (40%): quanto menor, melhor

        Args:
            entregas: Dict com métricas de entrega
            params: Parâmetros de configuração

        Returns:
            Score de 0 a 100
        """
        # Score pontualidade
        pont = entregas['pontualidade']
        if pont >= params.pontualidade_otima:
            score_pont = 100
        elif pont >= params.pontualidade_boa:
            faixa = params.pontualidade_otima - params.pontualidade_boa
            posicao = pont - params.pontualidade_boa
            score_pont = 80 + (20 * posicao / faixa) if faixa > 0 else 80
        elif pont >= params.pontualidade_regular:
            faixa = params.pontualidade_boa - params.pontualidade_regular
            posicao = pont - params.pontualidade_regular
            score_pont = 60 + (20 * posicao / faixa) if faixa > 0 else 60
        elif pont >= params.pontualidade_ruim:
            faixa = params.pontualidade_regular - params.pontualidade_ruim
            posicao = pont - params.pontualidade_ruim
            score_pont = 40 + (20 * posicao / faixa) if faixa > 0 else 40
        else:
            score_pont = max(0, 40 * pont / params.pontualidade_ruim) if params.pontualidade_ruim > 0 else 0

        # Score lead time (quanto menor, melhor)
        lt = entregas['lead_time_medio']
        if lt <= params.lead_time_otimo:
            score_lt = 100
        elif lt <= params.lead_time_bom:
            faixa = params.lead_time_bom - params.lead_time_otimo
            posicao = lt - params.lead_time_otimo
            score_lt = 100 - (20 * posicao / faixa) if faixa > 0 else 80
        elif lt <= params.lead_time_regular:
            faixa = params.lead_time_regular - params.lead_time_bom
            posicao = lt - params.lead_time_bom
            score_lt = 80 - (20 * posicao / faixa) if faixa > 0 else 60
        elif lt <= params.lead_time_ruim:
            faixa = params.lead_time_ruim - params.lead_time_regular
            posicao = lt - params.lead_time_regular
            score_lt = 60 - (20 * posicao / faixa) if faixa > 0 else 40
        else:
            score_lt = max(0, 40 - (lt - params.lead_time_ruim) * 2)

        # Pondera (60% pontualidade, 40% lead time)
        score = (score_pont * 0.60) + (score_lt * 0.40)

        return round(max(0, min(100, score)), 2)

    def historico_entregas(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int = 180
    ) -> List[Dict]:
        """
        Retorna histórico detalhado de entregas.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Lista de entregas com detalhes
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT
                r.IDRec,
                r.DatPed,
                r.DatPrevi,
                r.DatRece,
                DATEDIFF(r.DatRece, r.DatPed) as lead_time,
                CASE
                    WHEN r.DatPrevi IS NOT NULL AND r.DatRece > r.DatPrevi
                    THEN DATEDIFF(r.DatRece, r.DatPrevi)
                    ELSE 0
                END as dias_atraso,
                CASE
                    WHEN r.DatPrevi IS NULL THEN 'SEM_PREVISAO'
                    WHEN r.DatRece <= r.DatPrevi THEN 'NO_PRAZO'
                    ELSE 'ATRASADO'
                END as status,
                r.VlrTotRec as valor_total
            FROM arqcomprarec r
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND r.DatPed IS NOT NULL
            ORDER BY r.DatRece DESC
            LIMIT 50
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        }) or []

    def fornecedores_mais_pontuais(
        self,
        id_filial: int,
        dias: int = 180,
        limite: int = 20
    ) -> List[Dict]:
        """
        Lista fornecedores mais pontuais da filial.

        Args:
            id_filial: ID da filial
            dias: Período de análise
            limite: Limite de fornecedores

        Returns:
            Lista de fornecedores ordenados por pontualidade
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT
                r.CNPJCPFFor as cnpj,
                p.NomPes as nome,
                COUNT(*) as total_pedidos,
                SUM(CASE
                    WHEN r.DatPrevi IS NOT NULL AND r.DatRece <= r.DatPrevi THEN 1
                    WHEN r.DatPrevi IS NULL THEN 1
                    ELSE 0
                END) as pedidos_no_prazo,
                ROUND(
                    SUM(CASE
                        WHEN r.DatPrevi IS NOT NULL AND r.DatRece <= r.DatPrevi THEN 1
                        WHEN r.DatPrevi IS NULL THEN 1
                        ELSE 0
                    END) / COUNT(*) * 100,
                    1
                ) as pontualidade_perc,
                ROUND(AVG(DATEDIFF(r.DatRece, r.DatPed)), 1) as lead_time_medio
            FROM arqcomprarec r
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = r.CNPJCPFFor AND p.IDEsppes = 2
            WHERE r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND r.DatPed IS NOT NULL
            GROUP BY r.CNPJCPFFor, p.NomPes
            HAVING total_pedidos >= 3
            ORDER BY pontualidade_perc DESC, lead_time_medio ASC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []

    def evolucao_pontualidade(
        self,
        cnpj_forn: str,
        id_filial: int,
        meses: int = 6
    ) -> List[Dict]:
        """
        Retorna evolução mensal da pontualidade.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            meses: Quantidade de meses

        Returns:
            Lista com pontualidade por mês
        """
        sql = """
            SELECT
                DATE_FORMAT(r.DatRece, '%Y-%m') as mes,
                COUNT(*) as total_pedidos,
                SUM(CASE
                    WHEN r.DatPrevi IS NOT NULL AND r.DatRece <= r.DatPrevi THEN 1
                    WHEN r.DatPrevi IS NULL THEN 1
                    ELSE 0
                END) as pedidos_no_prazo,
                ROUND(
                    SUM(CASE
                        WHEN r.DatPrevi IS NOT NULL AND r.DatRece <= r.DatPrevi THEN 1
                        WHEN r.DatPrevi IS NULL THEN 1
                        ELSE 0
                    END) / COUNT(*) * 100,
                    1
                ) as pontualidade_perc
            FROM arqcomprarec r
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL :meses MONTH)
              AND r.DatPed IS NOT NULL
            GROUP BY DATE_FORMAT(r.DatRece, '%Y-%m')
            ORDER BY mes ASC
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'meses': meses
        }) or []
