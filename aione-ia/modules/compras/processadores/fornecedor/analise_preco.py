"""
AIONE IA - Analisador de Preços de Fornecedores
Análise de competitividade de preços
"""

from datetime import date, timedelta
from typing import Dict, List, Optional
from decimal import Decimal

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .analisador import MetricasPreco, ParametrosScoreFornecedor

logger = get_logger(__name__)


class AnalisadorPrecoFornecedor:
    """
    Analisador de preços de fornecedores.

    Avalia competitividade do fornecedor através de:
    - Variação de preço vs média do mercado
    - Reajuste de preços no período
    - Descontos obtidos

    Attributes:
        db: Gerenciador de banco de dados

    Example:
        >>> analisador = AnalisadorPrecoFornecedor(db)
        >>> metricas = analisador.analisar('12345678000190', 1)
        >>> print(metricas.score)
        75.5
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
    ) -> MetricasPreco:
        """
        Analisa preços praticados pelo fornecedor.

        Métricas calculadas:
        1. Variação vs mercado (média de outros fornecedores)
        2. Reajuste nos últimos 12 meses
        3. Desconto médio obtido

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise em dias
            parametros: Parâmetros de configuração

        Returns:
            MetricasPreco com todas as métricas calculadas
        """
        params = parametros or ParametrosScoreFornecedor()

        # 1. Variação vs mercado
        variacao_mercado = self._calcular_variacao_mercado(cnpj_forn, id_filial, dias)

        # 2. Reajuste anual
        reajuste = self._calcular_reajuste_anual(cnpj_forn, id_filial)

        # 3. Desconto médio
        desconto = self._calcular_desconto_medio(cnpj_forn, id_filial, dias)

        # Calcula score
        score = self._calcular_score(variacao_mercado, reajuste, desconto, params)

        return MetricasPreco(
            variacao_vs_mercado=round(variacao_mercado['variacao'], 2),
            reajuste_anual=round(reajuste['percentual'], 2),
            desconto_medio=round(desconto['percentual'], 2),
            score=score,
            qtd_produtos_analisados=variacao_mercado['qtd_produtos']
        )

    def _calcular_variacao_mercado(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int
    ) -> Dict:
        """
        Calcula variação de preço do fornecedor vs média do mercado.

        Para cada produto em comum, compara:
        - Preço médio do fornecedor
        - Preço médio de outros fornecedores

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Dict com 'variacao' (%) e 'qtd_produtos'
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            WITH precos_fornecedor AS (
                -- Preço médio do fornecedor por produto
                SELECT
                    h.IDProd,
                    AVG(h.VlrMovi) as preco_forn,
                    COUNT(*) as compras
                FROM ia_arqhistcom h
                WHERE h.CpfCnpj = :cnpj_forn
                  AND h.IDFilial = :id_filial
                  AND h.TipoHist = 'ENTRADA'
                  AND DATE(h.DatMovi) >= :data_inicio
                  AND h.VlrMovi > 0
                GROUP BY h.IDProd
            ),
            precos_mercado AS (
                -- Preço médio de outros fornecedores por produto
                SELECT
                    h.IDProd,
                    AVG(h.VlrMovi) as preco_mercado,
                    COUNT(DISTINCT h.CpfCnpj) as qtd_fornecedores
                FROM ia_arqhistcom h
                WHERE h.CpfCnpj != :cnpj_forn
                  AND h.IDFilial = :id_filial
                  AND h.TipoHist = 'ENTRADA'
                  AND DATE(h.DatMovi) >= :data_inicio
                  AND h.VlrMovi > 0
                GROUP BY h.IDProd
                HAVING qtd_fornecedores >= 2  -- Pelo menos 2 outros fornecedores
            )
            SELECT
                AVG(
                    CASE
                        WHEN pm.preco_mercado > 0
                        THEN ((pf.preco_forn - pm.preco_mercado) / pm.preco_mercado * 100)
                        ELSE 0
                    END
                ) as variacao_media,
                COUNT(*) as qtd_produtos
            FROM precos_fornecedor pf
            INNER JOIN precos_mercado pm ON pm.IDProd = pf.IDProd
        """

        result = self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        if result and result[0]['variacao_media'] is not None:
            return {
                'variacao': float(result[0]['variacao_media']),
                'qtd_produtos': int(result[0]['qtd_produtos'] or 0)
            }

        return {'variacao': 0, 'qtd_produtos': 0}

    def _calcular_reajuste_anual(
        self,
        cnpj_forn: str,
        id_filial: int
    ) -> Dict:
        """
        Calcula reajuste de preços nos últimos 12 meses.

        Compara preço médio dos primeiros 3 meses vs últimos 3 meses.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial

        Returns:
            Dict com 'percentual' de reajuste
        """
        hoje = date.today()
        inicio_periodo = hoje - timedelta(days=365)
        fim_primeiro_tri = inicio_periodo + timedelta(days=90)
        inicio_ultimo_tri = hoje - timedelta(days=90)

        sql = """
            SELECT
                periodo,
                AVG(VlrMovi) as preco_medio
            FROM (
                SELECT
                    h.VlrMovi,
                    CASE
                        WHEN DATE(h.DatMovi) <= :fim_primeiro_tri THEN 'INICIO'
                        WHEN DATE(h.DatMovi) >= :inicio_ultimo_tri THEN 'FIM'
                        ELSE 'MEIO'
                    END as periodo
                FROM ia_arqhistcom h
                WHERE h.CpfCnpj = :cnpj_forn
                  AND h.IDFilial = :id_filial
                  AND h.TipoHist = 'ENTRADA'
                  AND DATE(h.DatMovi) >= :inicio_periodo
                  AND h.VlrMovi > 0
            ) sub
            WHERE periodo IN ('INICIO', 'FIM')
            GROUP BY periodo
        """

        result = self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'inicio_periodo': inicio_periodo,
            'fim_primeiro_tri': fim_primeiro_tri,
            'inicio_ultimo_tri': inicio_ultimo_tri
        })

        precos = {r['periodo']: float(r['preco_medio']) for r in result} if result else {}

        if 'INICIO' in precos and 'FIM' in precos and precos['INICIO'] > 0:
            reajuste = ((precos['FIM'] - precos['INICIO']) / precos['INICIO']) * 100
            return {'percentual': reajuste}

        return {'percentual': 0}

    def _calcular_desconto_medio(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int
    ) -> Dict:
        """
        Calcula desconto médio obtido do fornecedor.

        Usa tabela de negociações especiais (ia_arqnegocesp) se disponível.
        Ou calcula diferença entre preço de tabela e preço praticado.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Dict com 'percentual' de desconto
        """
        # Tenta buscar de negociações especiais
        sql_nego = """
            SELECT AVG(PercDesc) as desconto_medio
            FROM ia_arqnegocesp
            WHERE CNPJForn = :cnpj_forn
              AND DatVigIni <= CURDATE()
              AND DatVigFim >= CURDATE()
              AND TipoNego = 'DESCONTO'
        """

        try:
            result = self.db.execute_query(sql_nego, {'cnpj_forn': cnpj_forn})

            if result and result[0]['desconto_medio'] is not None:
                return {'percentual': float(result[0]['desconto_medio'])}
        except Exception as e:
            # Tabela pode não existir
            self.logger.debug(f"Tabela ia_arqnegocesp não disponível: {e}")

        # Se não tem negociação especial, retorna 0
        return {'percentual': 0}

    def _calcular_score(
        self,
        variacao: Dict,
        reajuste: Dict,
        desconto: Dict,
        params: ParametrosScoreFornecedor
    ) -> float:
        """
        Calcula score de preço (0-100).

        Componentes:
        - Variação vs mercado (60%): quanto menor/negativo, melhor
        - Reajuste anual (25%): quanto menor, melhor
        - Desconto obtido (15%): quanto maior, melhor

        Args:
            variacao: Dict com variação vs mercado
            reajuste: Dict com reajuste anual
            desconto: Dict com desconto médio
            params: Parâmetros de configuração

        Returns:
            Score de 0 a 100
        """
        # Score variação (quanto menor/negativo, melhor)
        var = variacao['variacao']
        if var <= params.variacao_preco_otima:
            score_var = 100
        elif var <= params.variacao_preco_boa:
            # Interpola entre ótimo (100) e bom (80)
            faixa = params.variacao_preco_boa - params.variacao_preco_otima
            posicao = var - params.variacao_preco_otima
            score_var = 100 - (20 * posicao / faixa) if faixa > 0 else 80
        elif var <= params.variacao_preco_regular:
            faixa = params.variacao_preco_regular - params.variacao_preco_boa
            posicao = var - params.variacao_preco_boa
            score_var = 80 - (20 * posicao / faixa) if faixa > 0 else 60
        elif var <= params.variacao_preco_ruim:
            faixa = params.variacao_preco_ruim - params.variacao_preco_regular
            posicao = var - params.variacao_preco_regular
            score_var = 60 - (20 * posicao / faixa) if faixa > 0 else 40
        else:
            score_var = max(0, 40 - (var - params.variacao_preco_ruim) * 2)

        # Score reajuste (quanto menor, melhor)
        reaj = reajuste['percentual']
        if reaj <= 0:
            score_reaj = 100
        elif reaj <= 5:
            score_reaj = 100 - (reaj * 4)  # 0-5% = 100-80
        elif reaj <= 10:
            score_reaj = 80 - ((reaj - 5) * 4)  # 5-10% = 80-60
        elif reaj <= 15:
            score_reaj = 60 - ((reaj - 10) * 4)  # 10-15% = 60-40
        else:
            score_reaj = max(0, 40 - (reaj - 15) * 2)

        # Score desconto (quanto maior, melhor)
        desc = desconto['percentual']
        if desc >= 10:
            score_desc = 100
        elif desc >= 5:
            score_desc = 80 + ((desc - 5) * 4)  # 5-10% = 80-100
        elif desc >= 3:
            score_desc = 60 + ((desc - 3) * 10)  # 3-5% = 60-80
        elif desc >= 1:
            score_desc = 40 + ((desc - 1) * 10)  # 1-3% = 40-60
        else:
            score_desc = 20 + (desc * 20)  # 0-1% = 20-40

        # Pondera (60% variação, 25% reajuste, 15% desconto)
        score = (score_var * 0.60) + (score_reaj * 0.25) + (score_desc * 0.15)

        return round(max(0, min(100, score)), 2)

    def comparar_fornecedores_produto(
        self,
        id_prod: int,
        id_filial: int,
        dias: int = 90
    ) -> List[Dict]:
        """
        Compara preços de diferentes fornecedores para um produto.

        Útil para decisão de compra.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Lista de fornecedores com preços ordenados do menor para maior
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT
                h.CpfCnpj as cnpj,
                p.NomPes as nome_fornecedor,
                ROUND(AVG(h.VlrMovi), 2) as preco_medio,
                ROUND(MIN(h.VlrMovi), 2) as preco_minimo,
                ROUND(MAX(h.VlrMovi), 2) as preco_maximo,
                COUNT(*) as qtd_compras,
                MAX(DATE(h.DatMovi)) as ultima_compra
            FROM ia_arqhistcom h
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = h.CpfCnpj AND p.IDEsppes = 2
            WHERE h.IDProd = :id_prod
              AND h.IDFilial = :id_filial
              AND h.TipoHist = 'ENTRADA'
              AND DATE(h.DatMovi) >= :data_inicio
              AND h.VlrMovi > 0
            GROUP BY h.CpfCnpj, p.NomPes
            ORDER BY preco_medio ASC
        """

        return self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        }) or []

    def produtos_mais_caros(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int = 90,
        limite: int = 20
    ) -> List[Dict]:
        """
        Lista produtos em que o fornecedor está mais caro que concorrentes.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise
            limite: Limite de produtos

        Returns:
            Lista de produtos com variação de preço
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            WITH precos_forn AS (
                SELECT
                    h.IDProd,
                    AVG(h.VlrMovi) as preco_forn
                FROM ia_arqhistcom h
                WHERE h.CpfCnpj = :cnpj_forn
                  AND h.IDFilial = :id_filial
                  AND h.TipoHist = 'ENTRADA'
                  AND DATE(h.DatMovi) >= :data_inicio
                  AND h.VlrMovi > 0
                GROUP BY h.IDProd
            ),
            precos_mercado AS (
                SELECT
                    h.IDProd,
                    AVG(h.VlrMovi) as preco_mercado,
                    MIN(h.VlrMovi) as menor_preco
                FROM ia_arqhistcom h
                WHERE h.CpfCnpj != :cnpj_forn
                  AND h.IDFilial = :id_filial
                  AND h.TipoHist = 'ENTRADA'
                  AND DATE(h.DatMovi) >= :data_inicio
                  AND h.VlrMovi > 0
                GROUP BY h.IDProd
            )
            SELECT
                pf.IDProd,
                p.Despro as produto,
                ROUND(pf.preco_forn, 2) as preco_fornecedor,
                ROUND(pm.preco_mercado, 2) as preco_mercado,
                ROUND(pm.menor_preco, 2) as menor_preco,
                ROUND((pf.preco_forn - pm.preco_mercado) / pm.preco_mercado * 100, 2) as variacao_perc
            FROM precos_forn pf
            INNER JOIN precos_mercado pm ON pm.IDProd = pf.IDProd
            INNER JOIN arqproduto p ON p.IDProd = pf.IDProd
            WHERE pf.preco_forn > pm.preco_mercado
            ORDER BY variacao_perc DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []
