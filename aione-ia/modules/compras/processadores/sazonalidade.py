"""
AIONE IA - Detector de Sazonalidade
Detectar e quantificar padrões sazonais nas vendas de produtos farmacêuticos
"""

from datetime import date, timedelta
from typing import Dict, List
import pandas as pd
import numpy as np
import math

from core.utils.logger import get_logger


class DetectorSazonalidade:
    """Detector de padrões sazonais em vendas"""

    def __init__(self):
        self.logger = get_logger(self.__class__.__name__)

        # Índices sazonais padrão para farmácias (quando não há dados suficientes)
        self.INDICES_PADRAO = {
            'dia_semana': {
                0: 0.85,   # Segunda (menor movimento)
                1: 0.95,   # Terça
                2: 1.00,   # Quarta
                3: 1.00,   # Quinta
                4: 1.10,   # Sexta (pico)
                5: 1.15,   # Sábado (pico)
                6: 0.70    # Domingo (menor)
            },
            'semana_mes': {
                1: 1.15,   # 1ª semana (pós-salário)
                2: 1.00,   # 2ª semana
                3: 0.95,   # 3ª semana
                4: 0.90,   # 4ª semana (fim do dinheiro)
                5: 0.95    # 5ª semana (se houver)
            },
            'mes': {
                1: 0.90,   # Janeiro (férias)
                2: 0.95,   # Fevereiro
                3: 1.00,   # Março
                4: 1.00,   # Abril
                5: 1.05,   # Maio (outono, gripes)
                6: 1.15,   # Junho (inverno)
                7: 1.20,   # Julho (pico inverno)
                8: 1.10,   # Agosto
                9: 1.00,   # Setembro
                10: 0.95,  # Outubro
                11: 0.95,  # Novembro
                12: 1.00   # Dezembro
            }
        }

    # =========================================================================
    # MÉTODOS DE CÁLCULO
    # =========================================================================

    def calcular_indices_dia_semana(self, df: pd.DataFrame) -> Dict:
        """
        Calcula índice sazonal por dia da semana.

        Fórmula: Índice = Média do dia / Média geral

        Args:
            df: DataFrame com colunas [data, quantidade, dia_semana]

        Returns: {
            0: 0.85,  # Segunda
            1: 0.95,  # Terça
            ...
            6: 0.70,  # Domingo
            'confianca': float  # 0-1 baseado na quantidade de dados
        }
        """
        try:
            if df.empty or 'quantidade' not in df.columns or 'dia_semana' not in df.columns:
                self.logger.debug("Dados insuficientes para cálculo de índices dia da semana")
                return {**self.INDICES_PADRAO['dia_semana'], 'confianca': 0.0}

            # Filtrar apenas dados válidos
            df_valid = df[df['quantidade'] >= 0].copy()

            if df_valid.empty:
                return {**self.INDICES_PADRAO['dia_semana'], 'confianca': 0.0}

            media_geral = df_valid['quantidade'].mean()

            if media_geral == 0:
                self.logger.debug("Média geral zero para índices dia da semana")
                return {**self.INDICES_PADRAO['dia_semana'], 'confianca': 0.0}

            # Agrupa por dia da semana
            medias_dia = df_valid.groupby('dia_semana')['quantidade'].mean()

            indices = {}
            for dia in range(7):
                if dia in medias_dia.index and medias_dia[dia] > 0:
                    indices[dia] = float(medias_dia[dia] / media_geral)
                else:
                    indices[dia] = self.INDICES_PADRAO['dia_semana'][dia]

            # Confiança baseada na quantidade de semanas
            semanas = len(df_valid) / 7.0
            confianca = min(1.0, semanas / 8.0)  # 8 semanas = confiança máxima

            indices['confianca'] = float(confianca)

            self.logger.debug(f"Índices dia semana calculados: confiança={confianca:.2f}")
            return indices

        except Exception as e:
            self.logger.error(f"Erro ao calcular índices dia semana: {e}")
            return {**self.INDICES_PADRAO['dia_semana'], 'confianca': 0.0}

    def calcular_indices_semana_mes(self, df: pd.DataFrame) -> Dict:
        """
        Calcula índice sazonal por semana do mês.
        Semana 1: dias 1-7, Semana 2: dias 8-14, etc.
        """
        try:
            if df.empty or 'quantidade' not in df.columns or 'semana_mes' not in df.columns:
                self.logger.debug("Dados insuficientes para cálculo de índices semana do mês")
                return {**self.INDICES_PADRAO['semana_mes'], 'confianca': 0.0}

            # Filtrar apenas dados válidos
            df_valid = df[df['quantidade'] >= 0].copy()

            if df_valid.empty:
                return {**self.INDICES_PADRAO['semana_mes'], 'confianca': 0.0}

            media_geral = df_valid['quantidade'].mean()

            if media_geral == 0:
                self.logger.debug("Média geral zero para índices semana do mês")
                return {**self.INDICES_PADRAO['semana_mes'], 'confianca': 0.0}

            medias_semana = df_valid.groupby('semana_mes')['quantidade'].mean()

            indices = {}
            for semana in range(1, 6):
                if semana in medias_semana.index and medias_semana[semana] > 0:
                    indices[semana] = float(medias_semana[semana] / media_geral)
                else:
                    indices[semana] = self.INDICES_PADRAO['semana_mes'][semana]

            # Confiança baseada na quantidade de meses
            meses = len(df_valid) / 30.0
            confianca = min(1.0, meses / 3.0)  # 3 meses = confiança máxima

            indices['confianca'] = float(confianca)

            self.logger.debug(f"Índices semana mês calculados: confiança={confianca:.2f}")
            return indices

        except Exception as e:
            self.logger.error(f"Erro ao calcular índices semana mês: {e}")
            return {**self.INDICES_PADRAO['semana_mes'], 'confianca': 0.0}

    def calcular_indices_mes(self, df: pd.DataFrame) -> Dict:
        """
        Calcula índice sazonal por mês do ano.
        Requer pelo menos 12 meses de dados para confiança alta.
        """
        try:
            if df.empty or 'quantidade' not in df.columns or 'mes' not in df.columns:
                self.logger.debug("Dados insuficientes para cálculo de índices mensais")
                return {**self.INDICES_PADRAO['mes'], 'confianca': 0.0}

            # Filtrar apenas dados válidos
            df_valid = df[df['quantidade'] >= 0].copy()

            if df_valid.empty:
                return {**self.INDICES_PADRAO['mes'], 'confianca': 0.0}

            media_geral = df_valid['quantidade'].mean()

            if media_geral == 0:
                self.logger.debug("Média geral zero para índices mensais")
                return {**self.INDICES_PADRAO['mes'], 'confianca': 0.0}

            medias_mes = df_valid.groupby('mes')['quantidade'].mean()

            indices = {}
            for mes in range(1, 13):
                if mes in medias_mes.index and medias_mes[mes] > 0:
                    indices[mes] = float(medias_mes[mes] / media_geral)
                else:
                    indices[mes] = self.INDICES_PADRAO['mes'][mes]

            # Confiança baseada na quantidade de meses com dados
            meses_com_dados = len(medias_mes)
            confianca = min(1.0, meses_com_dados / 12.0)

            indices['confianca'] = float(confianca)

            self.logger.debug(f"Índices mensais calculados: {meses_com_dados} meses, confiança={confianca:.2f}")
            return indices

        except Exception as e:
            self.logger.error(f"Erro ao calcular índices mensais: {e}")
            return {**self.INDICES_PADRAO['mes'], 'confianca': 0.0}

    # =========================================================================
    # MÉTODOS DE APLICAÇÃO
    # =========================================================================

    def aplicar_ajuste_sazonal(self, valor_base: float,
                               data_alvo: date,
                               indices: Dict) -> float:
        """
        Aplica ajuste sazonal a um valor base.

        Combina índices usando média geométrica.
        """
        try:
            if valor_base <= 0:
                return valor_base

            dia_semana = data_alvo.weekday()
            semana_mes = ((data_alvo.day - 1) // 7) + 1
            mes = data_alvo.month

            # Obtém índices (usa padrão se não disponível)
            idx_dia_data = indices.get('dia_semana', {})
            idx_semana_data = indices.get('semana_mes', {})
            idx_mes_data = indices.get('mes', {})

            # Extrai valores numéricos, ignorando 'confianca'
            idx_dia = idx_dia_data.get(dia_semana, 1.0) if isinstance(idx_dia_data, dict) else 1.0
            idx_semana = idx_semana_data.get(semana_mes, 1.0) if isinstance(idx_semana_data, dict) else 1.0
            idx_mes = idx_mes_data.get(mes, 1.0) if isinstance(idx_mes_data, dict) else 1.0

            # Garantir que são valores numéricos válidos
            if not isinstance(idx_dia, (int, float)) or idx_dia <= 0:
                idx_dia = 1.0
            if not isinstance(idx_semana, (int, float)) or idx_semana <= 0:
                idx_semana = 1.0
            if not isinstance(idx_mes, (int, float)) or idx_mes <= 0:
                idx_mes = 1.0

            # Média geométrica
            indice_combinado = (idx_dia * idx_semana * idx_mes) ** (1.0/3.0)

            resultado = valor_base * indice_combinado

            self.logger.debug(
                f"Ajuste sazonal aplicado: {valor_base:.2f} → {resultado:.2f} "
                f"(dia:{idx_dia:.2f}, sem:{idx_semana:.2f}, mês:{idx_mes:.2f})"
            )

            return float(resultado)

        except Exception as e:
            self.logger.error(f"Erro ao aplicar ajuste sazonal: {e}")
            return valor_base

    def projetar_demanda_periodo(self, cmd: float,
                                  data_inicio: date,
                                  dias: int,
                                  indices: Dict) -> List[Dict]:
        """
        Projeta demanda dia a dia para um período.

        Returns: [
            {'data': date, 'demanda_esperada': float, 'indice_aplicado': float},
            ...
        ]
        """
        try:
            projecoes = []

            if cmd <= 0:
                # Se CMD é zero, retorna lista com zeros
                for i in range(dias):
                    data = data_inicio + timedelta(days=i)
                    projecoes.append({
                        'data': data,
                        'demanda_esperada': 0.0,
                        'indice_aplicado': 1.0
                    })
                return projecoes

            for i in range(dias):
                data = data_inicio + timedelta(days=i)
                demanda = self.aplicar_ajuste_sazonal(cmd, data, indices)

                indice = demanda / cmd if cmd > 0 else 1.0

                projecoes.append({
                    'data': data,
                    'demanda_esperada': float(demanda),
                    'indice_aplicado': float(indice)
                })

            self.logger.debug(f"Projeção gerada: {dias} dias, CMD base={cmd:.2f}")
            return projecoes

        except Exception as e:
            self.logger.error(f"Erro ao projetar demanda: {e}")
            return []

    # =========================================================================
    # MÉTODO PRINCIPAL
    # =========================================================================

    def analisar(self, df: pd.DataFrame,
                 min_dias: int = 30) -> Dict:
        """
        Análise completa de sazonalidade.

        Returns: {
            'dia_semana': dict,
            'semana_mes': dict,
            'mes': dict,
            'sazonalidade_detectada': bool,
            'forca_sazonalidade': float,  # 0-1
            'usar_padrao': bool,          # True se dados insuficientes
            'recomendacao': str
        }
        """
        try:
            self.logger.info("Iniciando análise de sazonalidade")

            usar_padrao = df.empty or len(df) < min_dias

            if usar_padrao:
                self.logger.info(f"Dados insuficientes ({len(df) if not df.empty else 0} < {min_dias}), usando padrões")
                return {
                    'dia_semana': {**self.INDICES_PADRAO['dia_semana'], 'usar_padrao': True},
                    'semana_mes': {**self.INDICES_PADRAO['semana_mes'], 'usar_padrao': True},
                    'mes': {**self.INDICES_PADRAO['mes'], 'usar_padrao': True},
                    'sazonalidade_detectada': False,
                    'forca_sazonalidade': 0.0,
                    'usar_padrao': True,
                    'recomendacao': 'Dados insuficientes, usando índices padrão de farmácia'
                }

            # Calcula índices
            idx_dia = self.calcular_indices_dia_semana(df)
            idx_semana = self.calcular_indices_semana_mes(df)
            idx_mes = self.calcular_indices_mes(df)

            # Avalia força da sazonalidade (variação dos índices)
            def variacao_indices(indices: Dict) -> float:
                """Calcula variação dos índices (desvio padrão)"""
                try:
                    valores = [v for k, v in indices.items()
                              if isinstance(v, (int, float)) and k != 'confianca' and v > 0]
                    if not valores or len(valores) < 2:
                        return 0.0
                    return float(np.std(valores))
                except Exception:
                    return 0.0

            var_dia = variacao_indices(idx_dia)
            var_semana = variacao_indices(idx_semana)
            var_mes = variacao_indices(idx_mes)

            # Força combinada ponderada pela confiança
            conf_dia = idx_dia.get('confianca', 0.0)
            conf_semana = idx_semana.get('confianca', 0.0)
            conf_mes = idx_mes.get('confianca', 0.0)

            # Média ponderada da força
            if conf_dia + conf_semana + conf_mes > 0:
                forca = ((var_dia * conf_dia) + (var_semana * conf_semana) + (var_mes * conf_mes)) / (conf_dia + conf_semana + conf_mes)
            else:
                forca = 0.0

            sazonalidade_detectada = forca > 0.1  # Mais de 10% de variação

            # Gerar recomendação
            if sazonalidade_detectada:
                if forca > 0.3:
                    recomendacao = "Sazonalidade forte detectada - aplicar ajustes"
                elif forca > 0.2:
                    recomendacao = "Sazonalidade moderada detectada"
                else:
                    recomendacao = "Sazonalidade fraca detectada"
            else:
                recomendacao = "Sazonalidade não significativa"

            resultado = {
                'dia_semana': idx_dia,
                'semana_mes': idx_semana,
                'mes': idx_mes,
                'sazonalidade_detectada': sazonalidade_detectada,
                'forca_sazonalidade': float(forca),
                'usar_padrao': False,
                'recomendacao': recomendacao
            }

            self.logger.info(
                f"Análise concluída: força={forca:.3f}, "
                f"detectada={sazonalidade_detectada}, conf_dia={conf_dia:.2f}"
            )

            return resultado

        except Exception as e:
            self.logger.error(f"Erro na análise de sazonalidade: {e}")
            return {
                'dia_semana': {**self.INDICES_PADRAO['dia_semana'], 'usar_padrao': True},
                'semana_mes': {**self.INDICES_PADRAO['semana_mes'], 'usar_padrao': True},
                'mes': {**self.INDICES_PADRAO['mes'], 'usar_padrao': True},
                'sazonalidade_detectada': False,
                'forca_sazonalidade': 0.0,
                'usar_padrao': True,
                'recomendacao': 'Erro na análise, usando padrões de farmácia'
            }