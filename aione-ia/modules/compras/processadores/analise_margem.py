"""
AIONE IA - Analisador de Margem
Análise de margem de lucro dos produtos
"""

from dataclasses import dataclass
from datetime import date, timedelta
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .classificador import ClasseMargem, ParametrosClassificacao

logger = get_logger(__name__)


@dataclass
class ResultadoMargem:
    """
    Resultado da análise de margem de um produto.

    Attributes:
        id_prod: ID do produto
        id_filial: ID da filial
        margem_media: Margem média %
        margem_minima: Margem mínima praticada
        margem_maxima: Margem máxima praticada
        score: Score de margem 0-100
        classe: Classificação da margem
        preco_medio_venda: Preço médio de venda
        custo_medio: Custo médio
        qtd_vendas: Quantidade de vendas no período
    """
    id_prod: int
    id_filial: int
    margem_media: float = 0.0
    margem_minima: float = 0.0
    margem_maxima: float = 0.0
    score: float = 0.0
    classe: ClasseMargem = ClasseMargem.NEGATIVA
    preco_medio_venda: float = 0.0
    custo_medio: float = 0.0
    qtd_vendas: int = 0
    total_vendido: float = 0.0
    lucro_total: float = 0.0
    qtd_vendas_negativas: int = 0


class AnalisadorMargem:
    """
    Analisador de margem de produtos.

    Calcula margem média, mínima e máxima baseado nas
    vendas realizadas no período usando ia_arqhistcom.

    Attributes:
        db: Gerenciador de banco de dados
        parametros: Parâmetros de classificação

    Example:
        >>> analisador = AnalisadorMargem(db, parametros)
        >>> resultado = analisador.analisar_produto(123, 1)
        >>> print(resultado['classe_margem'])
        BOA
    """

    def __init__(
        self,
        db: DatabaseManager,
        parametros: Optional[ParametrosClassificacao] = None
    ):
        """
        Inicializa o analisador.

        Args:
            db: Gerenciador de banco de dados
            parametros: Parâmetros de classificação
        """
        self.db = db
        self.parametros = parametros or ParametrosClassificacao()

    async def analisar(
        self,
        id_prod: int,
        id_filial: int
    ) -> ResultadoMargem:
        """
        Analisa a margem de um produto (interface async).

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            ResultadoMargem com os indicadores
        """
        result = self.analisar_produto(id_prod, id_filial)

        return ResultadoMargem(
            id_prod=id_prod,
            id_filial=id_filial,
            margem_media=result['margem_ponderada'],
            margem_minima=result['margem_minima'],
            margem_maxima=result['margem_maxima'],
            score=result['score_margem'],
            classe=ClasseMargem(result['classe_margem']),
            preco_medio_venda=result.get('preco_medio_venda', 0),
            custo_medio=result.get('custo_medio', 0),
            qtd_vendas=result.get('qtd_vendas', 0),
            total_vendido=result['total_vendido'],
            lucro_total=result['lucro_total'],
            qtd_vendas_negativas=result['qtd_vendas_negativas']
        )

    def analisar_produto(
        self,
        id_prod: int,
        id_filial: int,
        dias: int = None,
        parametros: Optional[ParametrosClassificacao] = None
    ) -> Dict:
        """
        Analisa margem de um produto.

        Margem = (VlrMovi - VlrCusto) / VlrMovi * 100

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            dias: Dias de análise
            parametros: Parâmetros de classificação

        Returns:
            Dicionário com métricas de margem
        """
        params = parametros or self.parametros
        dias = dias or params.dias_analise
        data_inicio = date.today() - timedelta(days=dias)

        # Busca vendas com margens da tabela de histórico
        sql = """
            SELECT
                h.QtdMovi,
                h.VlrMovi,
                h.VlrCusto,
                h.MargLiq,
                CASE
                    WHEN h.VlrMovi > 0 THEN ((h.VlrMovi - h.VlrCusto) / h.VlrMovi * 100)
                    ELSE 0
                END as margem_calc
            FROM ia_arqhistcom h
            WHERE h.IDProd = :id_prod
              AND h.IDFilial = :id_filial
              AND h.TipoHist = 'SAÍDA'
              AND DATE(h.DatMovi) >= :data_inicio
              AND h.VlrMovi > 0
        """

        result = self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        if not result:
            return {
                'margem_media': 0,
                'margem_minima': 0,
                'margem_maxima': 0,
                'margem_ponderada': 0,
                'score_margem': 0,
                'classe_margem': ClasseMargem.NEGATIVA.value,
                'total_vendido': 0,
                'lucro_total': 0,
                'qtd_vendas_negativas': 0,
                'qtd_vendas': 0,
                'preco_medio_venda': 0,
                'custo_medio': 0
            }

        # Calcula métricas
        margens = []
        soma_margem_ponderada = 0
        soma_qtd = 0
        total_vendido = 0
        lucro_total = 0
        vendas_negativas = 0

        for row in result:
            margem = float(row['margem_calc'] or row.get('MargLiq', 0) or 0)
            qtd = float(row['QtdMovi'] or 0)
            vlr = float(row['VlrMovi'] or 0)
            custo = float(row['VlrCusto'] or 0)

            margens.append(margem)
            soma_margem_ponderada += margem * qtd
            soma_qtd += qtd
            total_vendido += vlr * qtd
            lucro_total += (vlr - custo) * qtd

            if margem < 0:
                vendas_negativas += 1

        # Calcula médias
        margem_media = sum(margens) / len(margens) if margens else 0
        margem_ponderada = soma_margem_ponderada / soma_qtd if soma_qtd > 0 else 0
        margem_minima = min(margens) if margens else 0
        margem_maxima = max(margens) if margens else 0

        # Preço e custo médio
        preco_medio = total_vendido / soma_qtd if soma_qtd > 0 else 0
        custo_medio = (total_vendido - lucro_total) / soma_qtd if soma_qtd > 0 else 0

        # Score e classificação
        score_margem = self._calcular_score_margem(margem_ponderada, params)
        classe_margem = self._classificar_margem(margem_ponderada, params)

        return {
            'margem_media': round(margem_media, 2),
            'margem_minima': round(margem_minima, 2),
            'margem_maxima': round(margem_maxima, 2),
            'margem_ponderada': round(margem_ponderada, 2),
            'score_margem': round(score_margem, 2),
            'classe_margem': classe_margem.value,
            'total_vendido': round(total_vendido, 2),
            'lucro_total': round(lucro_total, 2),
            'qtd_vendas_negativas': vendas_negativas,
            'qtd_vendas': len(result),
            'preco_medio_venda': round(preco_medio, 2),
            'custo_medio': round(custo_medio, 2)
        }

    def _calcular_score_margem(
        self,
        margem: float,
        params: ParametrosClassificacao
    ) -> float:
        """
        Calcula score de margem (0-100).

        Args:
            margem: Margem em percentual
            params: Parâmetros de classificação

        Returns:
            Score de 0 a 100
        """
        if margem >= params.margem_otima_min:
            # Ótima: 80-100
            excesso = margem - params.margem_otima_min
            return min(100, 80 + excesso)

        elif margem >= params.margem_boa_min:
            # Boa: 60-80
            faixa = params.margem_otima_min - params.margem_boa_min
            posicao = margem - params.margem_boa_min
            return 60 + (20 * posicao / faixa)

        elif margem >= params.margem_regular_min:
            # Regular: 40-60
            faixa = params.margem_boa_min - params.margem_regular_min
            posicao = margem - params.margem_regular_min
            return 40 + (20 * posicao / faixa)

        elif margem >= params.margem_baixa_min:
            # Baixa: 20-40
            faixa = params.margem_regular_min - params.margem_baixa_min
            posicao = margem - params.margem_baixa_min
            return 20 + (20 * posicao / faixa)

        else:
            # Negativa: 0-20
            return max(0, 20 + margem)  # margem negativa reduz score

    def _classificar_margem(
        self,
        margem: float,
        params: ParametrosClassificacao
    ) -> ClasseMargem:
        """
        Classifica margem.

        Args:
            margem: Margem em percentual
            params: Parâmetros de classificação

        Returns:
            Classificação da margem
        """
        if margem >= params.margem_otima_min:
            return ClasseMargem.OTIMA
        elif margem >= params.margem_boa_min:
            return ClasseMargem.BOA
        elif margem >= params.margem_regular_min:
            return ClasseMargem.REGULAR
        elif margem >= params.margem_baixa_min:
            return ClasseMargem.BAIXA
        else:
            return ClasseMargem.NEGATIVA

    def produtos_margem_negativa(
        self,
        id_filial: int,
        dias: int = 90,
        limite: int = 100
    ) -> List[Dict]:
        """
        Lista produtos vendidos com margem negativa.

        Args:
            id_filial: ID da filial
            dias: Dias de análise
            limite: Limite de registros

        Returns:
            Lista de produtos com margem negativa
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT
                h.IDProd,
                p.Despro,
                COUNT(*) as qtd_vendas,
                AVG((h.VlrMovi - h.VlrCusto) / h.VlrMovi * 100) as margem_media,
                SUM((h.VlrCusto - h.VlrMovi) * h.QtdMovi) as prejuizo
            FROM ia_arqhistcom h
            INNER JOIN arqproduto p ON p.IDProd = h.IDProd
            WHERE h.IDFilial = :id_filial
              AND h.TipoHist = 'SAÍDA'
              AND DATE(h.DatMovi) >= :data_inicio
              AND h.VlrMovi > 0
              AND h.VlrCusto > h.VlrMovi
            GROUP BY h.IDProd, p.Despro
            ORDER BY prejuizo DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []

    def analisar_margem_por_periodo(
        self,
        id_prod: int,
        id_filial: int,
        periodos: int = 3
    ) -> List[Dict]:
        """
        Analisa evolução da margem por períodos de 30 dias.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            periodos: Número de períodos

        Returns:
            Lista com margem média por período
        """
        resultados = []
        dias_periodo = 30

        for i in range(periodos):
            inicio = (periodos - i) * dias_periodo
            fim = (periodos - i - 1) * dias_periodo

            sql = """
                SELECT
                    AVG(
                        CASE
                            WHEN h.VlrMovi > 0 THEN ((h.VlrMovi - h.VlrCusto) / h.VlrMovi * 100)
                            ELSE 0
                        END
                    ) as margem_media
                FROM ia_arqhistcom h
                WHERE h.IDProd = :id_prod
                  AND h.IDFilial = :id_filial
                  AND h.TipoHist = 'SAÍDA'
                  AND DATE(h.DatMovi) >= DATE_SUB(CURDATE(), INTERVAL :inicio DAY)
                  AND DATE(h.DatMovi) < DATE_SUB(CURDATE(), INTERVAL :fim DAY)
                  AND h.VlrMovi > 0
            """

            result = self.db.execute_query(sql, {
                'id_prod': id_prod,
                'id_filial': id_filial,
                'inicio': inicio,
                'fim': fim
            })

            margem = 0.0
            if result and result[0].get('margem_media'):
                margem = float(result[0]['margem_media'])

            resultados.append({
                'periodo': i + 1,
                'dias_atras_inicio': inicio,
                'dias_atras_fim': fim,
                'margem_media': round(margem, 2)
            })

        return resultados
