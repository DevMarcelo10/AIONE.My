from datetime import date, timedelta
from typing import List, Dict, Optional
import math

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .comparador import (
    ResultadoComparacao, MetricasConsolidadas,
    TipoPeriodo, ClassificacaoAcerto
)

class CalculadorMetrica:
    """
    Calculador de métricas de acurácia do forecast.

    Métricas:
    - MAPE: Mean Absolute Percentage Error
    - BIAS: Viés sistemático
    - MAE: Mean Absolute Error
    - RMSE: Root Mean Square Error
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def calcular_metricas(self, resultados: List[ResultadoComparacao],
                          id_filial: int,
                          periodo: str,
                          tipo_periodo: TipoPeriodo,
                          data_inicio: date,
                          data_fim: date,
                          id_grupo: int = None) -> MetricasConsolidadas:
        """
        Calcula métricas consolidadas a partir de uma lista de comparações.

        Args:
            resultados: Lista de ResultadoComparacao
            id_filial: ID da filial
            periodo: Identificador do período (ex: "2025-01")
            tipo_periodo: DIARIO, SEMANAL ou MENSAL
            data_inicio: Data início
            data_fim: Data fim
            id_grupo: ID do grupo (opcional)

        Returns: MetricasConsolidadas
        """

        if not resultados:
            return MetricasConsolidadas(
                id_filial=id_filial,
                id_grupo=id_grupo,
                periodo=periodo,
                tipo_periodo=tipo_periodo,
                data_inicio=data_inicio,
                data_fim=data_fim
            )

        # Filtra resultados válidos (com previsão ou realização)
        validos = [r for r in resultados if r.qtd_prevista > 0 or r.qtd_realizada > 0]

        if not validos:
            return MetricasConsolidadas(
                id_filial=id_filial,
                id_grupo=id_grupo,
                periodo=periodo,
                tipo_periodo=tipo_periodo,
                data_inicio=data_inicio,
                data_fim=data_fim,
                qtd_produtos=len(resultados)
            )

        # Calcula MAPE (Mean Absolute Percentage Error)
        mape = self._calcular_mape(validos)

        # Calcula BIAS (viés)
        bias = self._calcular_bias(validos)

        # Calcula MAE (Mean Absolute Error)
        mae = self._calcular_mae(validos)

        # Calcula RMSE (Root Mean Square Error)
        rmse = self._calcular_rmse(validos)

        # Acurácia média
        acuracia_media = sum(r.acuracia for r in validos) / len(validos)

        # Distribuição por classificação
        distribuicao = self._calcular_distribuicao(resultados)

        # Métricas de ruptura
        rupturas = self._calcular_metricas_ruptura(resultados)

        # Busca período anterior para comparar
        mape_anterior, variacao_mape, tendencia = self._buscar_periodo_anterior(
            id_filial, id_grupo, tipo_periodo, data_inicio
        )

        return MetricasConsolidadas(
            id_filial=id_filial,
            id_grupo=id_grupo,
            periodo=periodo,
            tipo_periodo=tipo_periodo,
            data_inicio=data_inicio,
            data_fim=data_fim,
            mape=round(mape, 4),
            bias=round(bias, 4),
            mae=round(mae, 4),
            rmse=round(rmse, 4),
            acuracia_media=round(acuracia_media, 2),
            qtd_produtos=len(resultados),
            qtd_excelente=distribuicao['EXCELENTE'],
            qtd_bom=distribuicao['BOM'],
            qtd_regular=distribuicao['REGULAR'],
            qtd_ruim=distribuicao['RUIM'],
            qtd_pessimo=distribuicao['PESSIMO'],
            dias_ruptura_total=rupturas['dias_total'],
            produtos_ruptura=rupturas['produtos'],
            vlr_perda_estimada=rupturas['vlr_perda'],
            taxa_ruptura=rupturas['taxa'],
            mape_anterior=mape_anterior,
            variacao_mape=variacao_mape,
            tendencia=tendencia
        )

    def _calcular_mape(self, resultados: List[ResultadoComparacao]) -> float:
        """
        Calcula MAPE (Mean Absolute Percentage Error).

        MAPE = (1/n) * Σ(|Ai - Fi| / Ai) * 100

        Onde:
        - Ai = Valor real (actual)
        - Fi = Valor previsto (forecast)
        """

        erros = []
        for r in resultados:
            if r.qtd_realizada > 0:
                erro = abs(r.qtd_realizada - r.qtd_prevista) / r.qtd_realizada
                erros.append(erro)
            elif r.qtd_prevista > 0:
                erros.append(1.0)  # 100% de erro

        if erros:
            return (sum(erros) / len(erros)) * 100

        return 0.0

    def _calcular_bias(self, resultados: List[ResultadoComparacao]) -> float:
        """
        Calcula BIAS (viés sistemático).

        BIAS = (1/n) * Σ(Fi - Ai) / Ai * 100

        Positivo = superestima (prevê mais do que vende)
        Negativo = subestima (prevê menos do que vende)
        """

        vieses = []
        for r in resultados:
            if r.qtd_realizada > 0:
                vies = (r.qtd_prevista - r.qtd_realizada) / r.qtd_realizada
                vieses.append(vies)

        if vieses:
            return (sum(vieses) / len(vieses)) * 100

        return 0.0

    def _calcular_mae(self, resultados: List[ResultadoComparacao]) -> float:
        """
        Calcula MAE (Mean Absolute Error).

        MAE = (1/n) * Σ|Ai - Fi|
        """

        erros = [r.desvio_abs for r in resultados]

        if erros:
            return sum(erros) / len(erros)

        return 0.0

    def _calcular_rmse(self, resultados: List[ResultadoComparacao]) -> float:
        """
        Calcula RMSE (Root Mean Square Error).

        RMSE = √[(1/n) * Σ(Ai - Fi)²]
        """

        erros_quadrados = [r.desvio ** 2 for r in resultados]

        if erros_quadrados:
            return math.sqrt(sum(erros_quadrados) / len(erros_quadrados))

        return 0.0

    def _calcular_distribuicao(self, resultados: List[ResultadoComparacao]) -> Dict:
        """Calcula distribuição por classificação de acurácia"""

        return {
            'EXCELENTE': sum(1 for r in resultados if r.classificacao == ClassificacaoAcerto.EXCELENTE),
            'BOM': sum(1 for r in resultados if r.classificacao == ClassificacaoAcerto.BOM),
            'REGULAR': sum(1 for r in resultados if r.classificacao == ClassificacaoAcerto.REGULAR),
            'RUIM': sum(1 for r in resultados if r.classificacao == ClassificacaoAcerto.RUIM),
            'PESSIMO': sum(1 for r in resultados if r.classificacao == ClassificacaoAcerto.PESSIMO)
        }

    def _calcular_metricas_ruptura(self, resultados: List[ResultadoComparacao]) -> Dict:
        """Calcula métricas relacionadas a rupturas"""

        dias_total = sum(r.dias_ruptura for r in resultados)
        produtos_ruptura = sum(1 for r in resultados if r.teve_ruptura)

        # Estima valor perdido (simplificado)
        vlr_perda = 0  # Pode ser expandido com preço médio

        taxa = (produtos_ruptura / len(resultados) * 100) if resultados else 0

        return {
            'dias_total': dias_total,
            'produtos': produtos_ruptura,
            'vlr_perda': vlr_perda,
            'taxa': round(taxa, 2)
        }

    def _buscar_periodo_anterior(self, id_filial: int, id_grupo: int,
                                  tipo_periodo: TipoPeriodo,
                                  data_referencia: date) -> tuple:
        """Busca métricas do período anterior para comparação"""

        # Determina período anterior
        if tipo_periodo == TipoPeriodo.DIARIO:
            data_ant = data_referencia - timedelta(days=1)
        elif tipo_periodo == TipoPeriodo.SEMANAL:
            data_ant = data_referencia - timedelta(weeks=1)
        else:  # MENSAL
            # Mês anterior
            if data_referencia.month == 1:
                data_ant = date(data_referencia.year - 1, 12, 1)
            else:
                data_ant = date(data_referencia.year, data_referencia.month - 1, 1)

        periodo_ant = data_ant.strftime('%Y-%m') if tipo_periodo == TipoPeriodo.MENSAL else data_ant.strftime('%Y-%W')

        conditions = [
            "IDFilial = :id_filial",
            "TipoPeriodo = :tipo",
            "DatInicio < :data_ref"
        ]
        params = {
            'id_filial': id_filial,
            'tipo': tipo_periodo.value,
            'data_ref': data_referencia
        }

        if id_grupo:
            conditions.append("IDGrupo = :id_grupo")
            params['id_grupo'] = id_grupo
        else:
            conditions.append("IDGrupo IS NULL")

        sql = f"""
            SELECT MAPE
            FROM ia_arqmetrica
            WHERE {' AND '.join(conditions)}
            ORDER BY DatInicio DESC
            LIMIT 1
        """

        result = self.db.execute_query(sql, params)

        if result:
            mape_anterior = float(result[0]['MAPE'])
            variacao_mape = None  # Será calculado após ter MAPE atual
            tendencia = "ESTAVEL"
            return mape_anterior, variacao_mape, tendencia

        return None, None, "ESTAVEL"

    def calcular_tendencia(self, mape_atual: float, mape_anterior: float) -> tuple:
        """Calcula variação e tendência do MAPE"""

        if mape_anterior is None or mape_anterior == 0:
            return None, "ESTAVEL"

        variacao = mape_atual - mape_anterior

        if variacao <= -2:  # Melhorou mais de 2 pontos
            tendencia = "MELHORANDO"
        elif variacao >= 2:  # Piorou mais de 2 pontos
            tendencia = "PIORANDO"
        else:
            tendencia = "ESTAVEL"

        return round(variacao, 4), tendencia

    def resumo_acuracia(self, id_filial: int, meses: int = 3) -> Dict:
        """
        Retorna resumo de acurácia dos últimos X meses.
        """

        sql = """
            SELECT
                Periodo,
                MAPE,
                AcuraciaMedia,
                QtdProdutos,
                TaxaRuptura,
                Tendencia
            FROM ia_arqmetrica
            WHERE IDFilial = :id_filial
              AND TipoPeriodo = 'MENSAL'
              AND IDGrupo IS NULL
            ORDER BY DatInicio DESC
            LIMIT :meses
        """

        result = self.db.execute_query(sql, {'id_filial': id_filial, 'meses': meses})

        if not result:
            return {'periodos': [], 'mape_medio': 0, 'tendencia_geral': 'ESTAVEL'}

        periodos = []
        for r in result:
            periodos.append({
                'periodo': r['Periodo'],
                'mape': float(r['MAPE']),
                'acuracia': float(r['AcuraciaMedia']),
                'produtos': r['QtdProdutos'],
                'taxa_ruptura': float(r['TaxaRuptura'])
            })

        mape_medio = sum(p['mape'] for p in periodos) / len(periodos)

        # Tendência geral (compara primeiro com último)
        if len(periodos) >= 2:
            if periodos[0]['mape'] < periodos[-1]['mape'] - 2:
                tendencia_geral = "MELHORANDO"
            elif periodos[0]['mape'] > periodos[-1]['mape'] + 2:
                tendencia_geral = "PIORANDO"
            else:
                tendencia_geral = "ESTAVEL"
        else:
            tendencia_geral = "ESTAVEL"

        return {
            'periodos': periodos,
            'mape_medio': round(mape_medio, 2),
            'tendencia_geral': tendencia_geral
        }