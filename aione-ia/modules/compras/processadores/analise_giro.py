"""
AIONE IA - Analisador de Giro de Estoque
Análise de giro, cobertura e regularidade de vendas
"""

from dataclasses import dataclass
from datetime import date, timedelta
from typing import Dict, List, Optional
import statistics

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .classificador import ClasseGiro, ParametrosClassificacao

logger = get_logger(__name__)


@dataclass
class ResultadoGiro:
    """
    Resultado da análise de giro de um produto.

    Attributes:
        id_prod: ID do produto
        id_filial: ID da filial
        giro_medio: Giro médio (vezes/ano)
        dias_cobertura: Dias de cobertura do estoque
        score: Score de giro 0-100
        classe: Classificação do giro
        estoque_atual: Quantidade em estoque
        estoque_valor: Valor em estoque (custo)
        estoque_excesso: Quantidade em excesso
        venda_media_dia: Venda média diária
        coef_variacao: Coeficiente de variação das vendas
        dias_com_venda: Dias com venda no período
        freq_venda: Frequência de venda %
        score_regularidade: Score de regularidade 0-100
    """
    id_prod: int
    id_filial: int
    giro_medio: float = 0.0
    dias_cobertura: float = 999.0
    score: float = 0.0
    classe: ClasseGiro = ClasseGiro.PESSIMO
    estoque_atual: float = 0.0
    estoque_valor: float = 0.0
    estoque_excesso: float = 0.0
    venda_media_dia: float = 0.0
    coef_variacao: float = 0.0
    dias_com_venda: int = 0
    freq_venda: float = 0.0
    score_regularidade: float = 0.0
    total_vendido: float = 0.0
    estoque_ideal: float = 0.0


class AnalisadorGiro:
    """
    Analisador de giro de estoque.

    Calcula indicadores de giro, cobertura de estoque e
    regularidade de vendas usando ia_arqhistcom.

    Attributes:
        db: Gerenciador de banco de dados
        parametros: Parâmetros de classificação

    Example:
        >>> analisador = AnalisadorGiro(db, parametros)
        >>> resultado = analisador.analisar_produto(123, 1)
        >>> print(resultado['classe_giro'])
        BOM
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
    ) -> ResultadoGiro:
        """
        Analisa o giro de estoque de um produto (interface async).

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            ResultadoGiro com os indicadores
        """
        result = self.analisar_produto(id_prod, id_filial)

        return ResultadoGiro(
            id_prod=id_prod,
            id_filial=id_filial,
            giro_medio=result['giro_medio'],
            dias_cobertura=result['dias_cobertura'],
            score=result['score_giro'],
            classe=ClasseGiro(result['classe_giro']),
            estoque_atual=result['estoque_atual'],
            estoque_valor=result['estoque_valor'],
            estoque_excesso=result['estoque_excesso'],
            venda_media_dia=result['consumo_medio_diario'],
            coef_variacao=result.get('coef_variacao', 0),
            dias_com_venda=result['dias_com_venda'],
            freq_venda=result.get('freq_venda', 0),
            score_regularidade=result.get('score_regularidade', 0),
            total_vendido=result['total_vendido'],
            estoque_ideal=result['estoque_ideal']
        )

    def analisar_produto(
        self,
        id_prod: int,
        id_filial: int,
        dias: int = None,
        parametros: Optional[ParametrosClassificacao] = None
    ) -> Dict:
        """
        Analisa giro de estoque de um produto.

        Métricas calculadas:
        - Giro médio (vezes/ano)
        - Dias de cobertura
        - Score de giro (0-100)
        - Classificação do giro

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            dias: Dias de análise (default: parametros.dias_analise)
            parametros: Parâmetros de classificação

        Returns:
            Dicionário com métricas de giro
        """
        params = parametros or self.parametros
        dias = dias or params.dias_analise
        data_inicio = date.today() - timedelta(days=dias)

        # Busca consumo no período
        sql_consumo = """
            SELECT
                SUM(QtdMovi) as total_vendido,
                COUNT(DISTINCT DATE(DatMovi)) as dias_com_venda,
                AVG(QtdMovi) as media_por_venda
            FROM ia_arqhistcom
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND TipoHist = 'SAÍDA'
              AND DATE(DatMovi) >= :data_inicio
        """

        result_consumo = self.db.execute_query(sql_consumo, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        # Busca estoque atual
        estoque_atual = self._obter_estoque_atual(id_prod, id_filial)
        estoque_valor = self._obter_valor_estoque(id_prod, id_filial)

        # Busca vendas diárias para calcular coef. variação
        vendas_diarias = self._obter_vendas_diarias(id_prod, id_filial, data_inicio)

        # Calcula métricas
        total_vendido = float(result_consumo[0]['total_vendido'] or 0) if result_consumo else 0
        dias_com_venda = int(result_consumo[0]['dias_com_venda'] or 0) if result_consumo else 0

        # Consumo médio diário (considerando todos os dias)
        consumo_medio_diario = total_vendido / dias if dias > 0 else 0

        # Dias de cobertura
        if consumo_medio_diario > 0:
            dias_cobertura = estoque_atual / consumo_medio_diario
        else:
            dias_cobertura = 999 if estoque_atual > 0 else 0

        # Giro médio (vezes por ano)
        consumo_anual = consumo_medio_diario * 365
        if estoque_atual > 0:
            giro_medio = consumo_anual / estoque_atual
        else:
            giro_medio = 0

        # Coeficiente de variação
        coef_variacao = 0
        if vendas_diarias and len(vendas_diarias) > 1:
            qtds = [v['qtd'] for v in vendas_diarias]
            media = statistics.mean(qtds)
            if media > 0:
                desvio = statistics.stdev(qtds)
                coef_variacao = desvio / media

        # Frequência de venda
        freq_venda = (dias_com_venda / dias * 100) if dias > 0 else 0

        # Score e classificação
        score_giro = self._calcular_score_giro(dias_cobertura, params)
        classe_giro = self._classificar_giro(dias_cobertura, params)

        # Score de regularidade
        score_regularidade = self._calcular_score_regularidade(freq_venda, coef_variacao, params)

        # Estoque ideal (para X dias) e excesso
        estoque_ideal = consumo_medio_diario * params.giro_otimo_ate
        estoque_excesso = max(0, estoque_atual - estoque_ideal)

        return {
            'giro_medio': round(giro_medio, 2),
            'dias_cobertura': round(dias_cobertura, 2),
            'consumo_medio_diario': round(consumo_medio_diario, 4),
            'estoque_atual': estoque_atual,
            'estoque_valor': estoque_valor,
            'score_giro': round(score_giro, 2),
            'classe_giro': classe_giro.value,
            'estoque_excesso': round(estoque_excesso, 4),
            'estoque_ideal': round(estoque_ideal, 4),
            'dias_com_venda': dias_com_venda,
            'total_vendido': total_vendido,
            'coef_variacao': round(coef_variacao, 4),
            'freq_venda': round(freq_venda, 2),
            'score_regularidade': round(score_regularidade, 2)
        }

    def _obter_estoque_atual(self, id_prod: int, id_filial: int) -> float:
        """
        Calcula estoque atual baseado em entradas - saídas.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Saldo de estoque
        """
        sql = """
            SELECT
                SUM(CASE WHEN TipoHist = 'ENTRADA' THEN QtdMovi ELSE 0 END) -
                SUM(CASE WHEN TipoHist = 'SAÍDA' THEN QtdMovi ELSE 0 END) as saldo
            FROM ia_arqhistcom
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
        """

        result = self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial
        })

        if result and result[0]['saldo']:
            return float(result[0]['saldo'])
        return 0.0

    def _obter_valor_estoque(self, id_prod: int, id_filial: int) -> float:
        """
        Obtém valor do estoque atual.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Valor do estoque
        """
        sql = """
            SELECT COALESCE(SUM(Qtdatu * Cuslot), 0) as valor
            FROM arqprodutolot
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Qtdatu > 0
        """

        result = self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial
        })

        if result:
            return float(result[0].get('valor', 0) or 0)
        return 0.0

    def _obter_vendas_diarias(
        self,
        id_prod: int,
        id_filial: int,
        data_inicio: date
    ) -> List[Dict]:
        """
        Obtém vendas diárias do período.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            data_inicio: Data inicial

        Returns:
            Lista de vendas por dia
        """
        sql = """
            SELECT
                DATE(DatMovi) as data,
                SUM(QtdMovi) as qtd
            FROM ia_arqhistcom
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND TipoHist = 'SAÍDA'
              AND DATE(DatMovi) >= :data_inicio
            GROUP BY DATE(DatMovi)
            ORDER BY data
        """

        result = self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        return [{'data': r['data'], 'qtd': float(r['qtd'])} for r in result] if result else []

    def _calcular_score_giro(
        self,
        dias_cobertura: float,
        params: ParametrosClassificacao
    ) -> float:
        """
        Calcula score de giro (0-100).
        Quanto menor os dias de cobertura, maior o score.

        Args:
            dias_cobertura: Dias de cobertura do estoque
            params: Parâmetros de classificação

        Returns:
            Score de 0 a 100
        """
        if dias_cobertura <= params.giro_otimo_ate:
            # Ótimo: 80-100
            return 80 + (20 * (1 - dias_cobertura / params.giro_otimo_ate))

        elif dias_cobertura <= params.giro_bom_ate:
            # Bom: 60-80
            faixa = params.giro_bom_ate - params.giro_otimo_ate
            posicao = dias_cobertura - params.giro_otimo_ate
            return 80 - (20 * posicao / faixa)

        elif dias_cobertura <= params.giro_regular_ate:
            # Regular: 40-60
            faixa = params.giro_regular_ate - params.giro_bom_ate
            posicao = dias_cobertura - params.giro_bom_ate
            return 60 - (20 * posicao / faixa)

        elif dias_cobertura <= params.giro_ruim_ate:
            # Ruim: 20-40
            faixa = params.giro_ruim_ate - params.giro_regular_ate
            posicao = dias_cobertura - params.giro_regular_ate
            return 40 - (20 * posicao / faixa)

        else:
            # Péssimo: 0-20
            excesso = dias_cobertura - params.giro_ruim_ate
            return max(0, 20 - (excesso / 10))

    def _classificar_giro(
        self,
        dias_cobertura: float,
        params: ParametrosClassificacao
    ) -> ClasseGiro:
        """
        Classifica giro baseado nos dias de cobertura.

        Args:
            dias_cobertura: Dias de cobertura do estoque
            params: Parâmetros de classificação

        Returns:
            Classificação do giro
        """
        if dias_cobertura <= params.giro_otimo_ate:
            return ClasseGiro.OTIMO
        elif dias_cobertura <= params.giro_bom_ate:
            return ClasseGiro.BOM
        elif dias_cobertura <= params.giro_regular_ate:
            return ClasseGiro.REGULAR
        elif dias_cobertura <= params.giro_ruim_ate:
            return ClasseGiro.RUIM
        else:
            return ClasseGiro.PESSIMO

    def _calcular_score_regularidade(
        self,
        freq_venda: float,
        coef_variacao: float,
        params: ParametrosClassificacao
    ) -> float:
        """
        Calcula score de regularidade de vendas (0-100).

        Args:
            freq_venda: Frequência de venda (%)
            coef_variacao: Coeficiente de variação
            params: Parâmetros de classificação

        Returns:
            Score de 0 a 100
        """
        # Componente de frequência (0-60 pontos)
        if freq_venda >= params.freq_alta_min:
            score_freq = 60
        elif freq_venda >= params.freq_media_min:
            score_freq = 40 + (freq_venda - params.freq_media_min) / (params.freq_alta_min - params.freq_media_min) * 20
        elif freq_venda >= params.freq_baixa_min:
            score_freq = 20 + (freq_venda - params.freq_baixa_min) / (params.freq_media_min - params.freq_baixa_min) * 20
        else:
            score_freq = freq_venda / params.freq_baixa_min * 20 if params.freq_baixa_min > 0 else 0

        # Componente de estabilidade - CV baixo = melhor (0-40 pontos)
        if coef_variacao <= 0.5:
            score_cv = 40
        elif coef_variacao <= 1.0:
            score_cv = 40 - (coef_variacao - 0.5) * 40
        elif coef_variacao <= 1.5:
            score_cv = 20 - (coef_variacao - 1.0) * 40
        else:
            score_cv = 0

        return min(100, score_freq + score_cv)

    def produtos_sem_giro(
        self,
        id_filial: int,
        dias: int = 90,
        limite: int = 100
    ) -> List[Dict]:
        """
        Lista produtos sem vendas no período.

        Args:
            id_filial: ID da filial
            dias: Dias de análise
            limite: Limite de registros

        Returns:
            Lista de produtos sem giro
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT DISTINCT p.IDProd, p.Despro, p.IDGrupo
            FROM arqproduto p
            WHERE p.Ativo = '1'
              AND p.IDProd NOT IN (
                  SELECT DISTINCT h.IDProd
                  FROM ia_arqhistcom h
                  WHERE h.IDFilial = :id_filial
                    AND h.TipoHist = 'SAÍDA'
                    AND DATE(h.DatMovi) >= :data_inicio
              )
              AND p.IDProd IN (
                  SELECT h2.IDProd
                  FROM ia_arqhistcom h2
                  WHERE h2.IDFilial = :id_filial
                  GROUP BY h2.IDProd
                  HAVING SUM(CASE WHEN h2.TipoHist = 'ENTRADA' THEN h2.QtdMovi ELSE -h2.QtdMovi END) > 0
              )
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []
