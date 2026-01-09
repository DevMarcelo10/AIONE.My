"""
AIONE IA - Analisador de Curva ABC
Classificação de produtos por faturamento (Pareto)
"""

from dataclasses import dataclass
from datetime import date, timedelta
from typing import Dict, List, Optional

import pandas as pd

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .classificador import CurvaABC, ParametrosClassificacao

logger = get_logger(__name__)


@dataclass
class ResultadoABC:
    """
    Resultado da análise de Curva ABC de um produto.

    Attributes:
        id_prod: ID do produto
        id_filial: ID da filial
        curva: Classificação ABC (A/B/C/D)
        percentual: Percentual do faturamento
        ranking: Posição no ranking de faturamento
        valor_vendas: Valor total de vendas no período
        percentual_acumulado: Percentual acumulado até este produto
    """
    id_prod: int
    id_filial: int
    curva: CurvaABC = CurvaABC.D
    percentual: float = 0.0
    ranking: int = 0
    valor_vendas: float = 0.0
    percentual_acumulado: float = 0.0


class AnalisadorCurvaABC:
    """
    Analisador de Curva ABC por faturamento.

    Classifica produtos pela participação no faturamento (Pareto):
    - A: Top produtos (70% do faturamento)
    - B: Intermediários (70-90%)
    - C: Baixo giro (90-98%)
    - D: Sem movimento ou mínimo (98-100%)

    Attributes:
        db: Gerenciador de banco de dados
        parametros: Parâmetros de classificação

    Example:
        >>> analisador = AnalisadorCurvaABC(db)
        >>> df = analisador.calcular_curva_filial(1, 90)
        >>> print(df.head())
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
        self._cache_curva: Dict[int, pd.DataFrame] = {}  # Cache por filial

    def calcular_curva_filial(
        self,
        id_filial: int,
        dias: int = 90,
        parametros: Optional[ParametrosClassificacao] = None
    ) -> pd.DataFrame:
        """
        Calcula Curva ABC para todos os produtos de uma filial.

        Args:
            id_filial: ID da filial
            dias: Dias de histórico a considerar
            parametros: Parâmetros de classificação (opcional)

        Returns:
            DataFrame com colunas:
                - IDProd
                - faturamento
                - perc_faturamento
                - perc_acumulado
                - curva_abc
                - rank
        """
        params = parametros or self.parametros
        data_inicio = date.today() - timedelta(days=dias)

        # Busca faturamento por produto da tabela de histórico
        sql = """
            SELECT
                h.IDProd,
                SUM(h.QtdMovi * h.VlrMovi) as faturamento
            FROM ia_arqhistcom h
            WHERE h.IDFilial = :id_filial
              AND h.TipoHist = 'SAÍDA'
              AND DATE(h.DatMovi) >= :data_inicio
            GROUP BY h.IDProd
            HAVING faturamento > 0
            ORDER BY faturamento DESC
        """

        result = self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        if not result:
            return pd.DataFrame(columns=[
                'IDProd', 'faturamento', 'perc_faturamento',
                'perc_acumulado', 'curva_abc', 'rank'
            ])

        df = pd.DataFrame(result)

        # Calcula percentuais
        total_faturamento = df['faturamento'].sum()
        df['perc_faturamento'] = df['faturamento'] / total_faturamento
        df['perc_acumulado'] = df['perc_faturamento'].cumsum()
        df['rank'] = range(1, len(df) + 1)

        # Classifica ABC
        df['curva_abc'] = df['perc_acumulado'].apply(
            lambda x: self._classificar_curva(x, params)
        )

        # Armazena em cache
        self._cache_curva[id_filial] = df.copy()

        logger.info(f"Curva ABC filial {id_filial}: {len(df)} produtos analisados")

        return df

    def _classificar_curva(
        self,
        perc_acumulado: float,
        params: ParametrosClassificacao
    ) -> str:
        """
        Classifica produto na curva ABC baseado no percentual acumulado.

        Args:
            perc_acumulado: Percentual acumulado (0-1)
            params: Parâmetros de classificação

        Returns:
            Valor do enum CurvaABC
        """
        if perc_acumulado <= params.curva_a_ate:
            return CurvaABC.A.value
        elif perc_acumulado <= params.curva_b_ate:
            return CurvaABC.B.value
        elif perc_acumulado <= params.curva_c_ate:
            return CurvaABC.C.value
        else:
            return CurvaABC.D.value

    async def analisar(
        self,
        id_prod: int,
        id_filial: int
    ) -> ResultadoABC:
        """
        Analisa a curva ABC de um produto (interface async).

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            ResultadoABC com a classificação
        """
        result = self.obter_curva_produto(id_prod, id_filial)

        return ResultadoABC(
            id_prod=id_prod,
            id_filial=id_filial,
            curva=CurvaABC(result['curva_abc']),
            percentual=result['perc_faturamento'] * 100,
            ranking=result['rank'],
            valor_vendas=result['faturamento'],
            percentual_acumulado=result['perc_acumulado'] * 100
        )

    def obter_curva_produto(
        self,
        id_prod: int,
        id_filial: int,
        dias: int = 90,
        parametros: Optional[ParametrosClassificacao] = None
    ) -> Dict:
        """
        Obtém classificação ABC de um produto específico.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            dias: Dias de histórico
            parametros: Parâmetros de classificação

        Returns:
            Dicionário com:
                - curva_abc: str
                - faturamento: float
                - perc_faturamento: float
                - perc_acumulado: float
                - rank: int
                - total_produtos: int
        """
        # Usa cache se disponível
        if id_filial in self._cache_curva:
            df = self._cache_curva[id_filial]
        else:
            df = self.calcular_curva_filial(id_filial, dias, parametros)

        if df.empty:
            return {
                'curva_abc': CurvaABC.D.value,
                'faturamento': 0,
                'perc_faturamento': 0,
                'perc_acumulado': 1,
                'rank': 0,
                'total_produtos': 0
            }

        # Busca produto específico
        produto = df[df['IDProd'] == id_prod]

        if produto.empty:
            # Produto não vendeu no período
            return {
                'curva_abc': CurvaABC.D.value,
                'faturamento': 0,
                'perc_faturamento': 0,
                'perc_acumulado': 1,
                'rank': len(df) + 1,
                'total_produtos': len(df)
            }

        row = produto.iloc[0]
        return {
            'curva_abc': row['curva_abc'],
            'faturamento': float(row['faturamento']),
            'perc_faturamento': float(row['perc_faturamento']),
            'perc_acumulado': float(row['perc_acumulado']),
            'rank': int(row['rank']),
            'total_produtos': len(df)
        }

    def resumo_curva_filial(self, id_filial: int, dias: int = 90) -> Dict:
        """
        Retorna resumo da Curva ABC da filial.

        Args:
            id_filial: ID da filial
            dias: Dias de histórico

        Returns:
            Dicionário com:
                - total_produtos: int
                - faturamento_total: float
                - curva_a: {qtd, perc_produtos, perc_faturamento}
                - curva_b: {...}
                - curva_c: {...}
                - curva_d: {...}
        """
        df = self.calcular_curva_filial(id_filial, dias)

        if df.empty:
            return {
                'total_produtos': 0,
                'faturamento_total': 0,
                'curva_a': {'qtd': 0, 'perc_produtos': 0, 'perc_faturamento': 0},
                'curva_b': {'qtd': 0, 'perc_produtos': 0, 'perc_faturamento': 0},
                'curva_c': {'qtd': 0, 'perc_produtos': 0, 'perc_faturamento': 0},
                'curva_d': {'qtd': 0, 'perc_produtos': 0, 'perc_faturamento': 0}
            }

        total = len(df)
        fat_total = df['faturamento'].sum()

        resumo = {
            'total_produtos': total,
            'faturamento_total': float(fat_total)
        }

        for curva in ['A', 'B', 'C', 'D']:
            filtro = df[df['curva_abc'] == curva]
            resumo[f'curva_{curva.lower()}'] = {
                'qtd': len(filtro),
                'perc_produtos': len(filtro) / total * 100 if total > 0 else 0,
                'perc_faturamento': filtro['faturamento'].sum() / fat_total * 100 if fat_total > 0 else 0
            }

        return resumo

    def limpar_cache(self, id_filial: Optional[int] = None) -> None:
        """
        Limpa o cache de curva ABC.

        Args:
            id_filial: ID da filial (se None, limpa todo o cache)
        """
        if id_filial is not None:
            self._cache_curva.pop(id_filial, None)
        else:
            self._cache_curva.clear()
