"""
AIONE IA - Analisador de Séries Temporais
Análise estatística de histórico de vendas para identificar tendências e padrões
"""

from datetime import date, datetime, timedelta
from typing import List, Dict, Optional, Tuple
import pandas as pd
import numpy as np
from scipy import stats
from sqlalchemy import text

from core.database import DatabaseManager
from core.utils.logger import get_logger


class AnalisadorSeriesTemporal:
    """Analisador de séries temporais para histórico de vendas"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    # =========================================================================
    # MÉTODOS DE EXTRAÇÃO DE DADOS
    # =========================================================================

    def obter_historico_vendas(self, id_prod: int, id_filial: int,
                               dias: int = 90) -> pd.DataFrame:
        """
        Busca vendas do produto/filial nos últimos X dias.

        Query em ia_arqhistcom:
        - TipoHist = 'SAÍDA'
        - OriItem = 'AIONE' (ignora migrações para forecast)
        - Agrupa por data

        Returns: DataFrame com colunas [data, quantidade, valor, dia_semana, semana_mes, mes]
        """
        try:
            data_inicio = date.today() - timedelta(days=dias)

            sql = """
                SELECT
                    DATE(DatMovi) as data,
                    SUM(QtdMovi) as quantidade,
                    SUM(VlrMovi * QtdMovi) as valor,
                    DAYOFWEEK(DatMovi) - 1 as dia_semana,
                    CEIL(DAY(DatMovi) / 7) as semana_mes,
                    MONTH(DatMovi) as mes
                FROM ia_arqhistcom
                WHERE IDProd = :id_prod
                  AND IDFilial = :id_filial
                  AND TipoHist = 'SAÍDA'
                  AND OriItem = 'AIONE'
                  AND DATE(DatMovi) >= :data_inicio
                GROUP BY DATE(DatMovi)
                ORDER BY DATE(DatMovi)
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_prod': id_prod,
                    'id_filial': id_filial,
                    'data_inicio': data_inicio
                })
                dados = result.fetchall()

            if not dados:
                self.logger.warning(f"Nenhum histórico encontrado para produto {id_prod}, filial {id_filial}")
                return pd.DataFrame(columns=['data', 'quantidade', 'valor', 'dia_semana', 'semana_mes', 'mes'])

            # Converter para DataFrame
            df = pd.DataFrame([dict(row._mapping) for row in dados])
            df['data'] = pd.to_datetime(df['data'])

            # Garantir tipos corretos
            df['quantidade'] = pd.to_numeric(df['quantidade'], errors='coerce').fillna(0)
            df['valor'] = pd.to_numeric(df['valor'], errors='coerce').fillna(0)
            df['dia_semana'] = pd.to_numeric(df['dia_semana'], errors='coerce').fillna(0)
            df['semana_mes'] = pd.to_numeric(df['semana_mes'], errors='coerce').fillna(1)
            df['mes'] = pd.to_numeric(df['mes'], errors='coerce').fillna(1)

            self.logger.debug(f"Histórico obtido: {len(df)} registros para produto {id_prod}")
            return df

        except Exception as e:
            self.logger.error(f"Erro ao obter histórico: {e}")
            return pd.DataFrame(columns=['data', 'quantidade', 'valor', 'dia_semana', 'semana_mes', 'mes'])

    def obter_estoque_atual(self, id_prod: int, id_filial: int) -> float:
        """
        Calcula estoque atual baseado em entradas - saídas.

        Usa ia_arqhistcom para calcular saldo.
        Alternativa: usar tabela de estoque do ERP se disponível.
        """
        try:
            sql = """
                SELECT
                    SUM(CASE WHEN TipoHist = 'ENTRADA' THEN QtdMovi ELSE 0 END) -
                    SUM(CASE WHEN TipoHist = 'SAÍDA' THEN QtdMovi ELSE 0 END) as saldo
                FROM ia_arqhistcom
                WHERE IDProd = :id_prod
                  AND IDFilial = :id_filial
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_prod': id_prod,
                    'id_filial': id_filial
                })
                row = result.fetchone()

            if row and row.saldo is not None:
                saldo = float(row.saldo)
                self.logger.debug(f"Estoque calculado produto {id_prod}: {saldo}")
                return max(0, saldo)  # Não pode ter estoque negativo

            return 0.0

        except Exception as e:
            self.logger.error(f"Erro ao calcular estoque: {e}")
            return 0.0

    def obter_grupo_produto(self, id_prod: int) -> Optional[int]:
        """Retorna IDGrupo do produto"""
        try:
            sql = "SELECT IDGrupo FROM arqproduto WHERE IDProd = :id_prod"

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {'id_prod': id_prod})
                row = result.fetchone()

            if row:
                return row.IDGrupo
            return None

        except Exception as e:
            self.logger.warning(f"Erro ao obter grupo produto {id_prod}: {e}")
            return None

    def obter_ultima_compra(self, id_prod: int, id_filial: int) -> Optional[Dict]:
        """
        Retorna dados da última compra (entrada).
        """
        try:
            sql = """
                SELECT
                    DATE(DatMovi) as data,
                    QtdMovi as quantidade,
                    VlrMovi as valor_unitario,
                    CpfCnpj as fornecedor
                FROM ia_arqhistcom
                WHERE IDProd = :id_prod
                  AND IDFilial = :id_filial
                  AND TipoHist = 'ENTRADA'
                ORDER BY DatMovi DESC
                LIMIT 1
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_prod': id_prod,
                    'id_filial': id_filial
                })
                row = result.fetchone()

            if row:
                return dict(row._mapping)
            return None

        except Exception as e:
            self.logger.warning(f"Erro ao obter última compra: {e}")
            return None

    # =========================================================================
    # MÉTODOS DE ANÁLISE
    # =========================================================================

    def calcular_estatisticas_basicas(self, df: pd.DataFrame) -> Dict:
        """
        Calcula estatísticas do histórico.

        Returns: {
            'media': float,
            'mediana': float,
            'desvio_padrao': float,
            'min': float,
            'max': float,
            'amplitude': float,
            'coef_variacao': float,
            'q1': float,
            'q2': float,
            'q3': float,
            'dias_com_venda': int,
            'dias_sem_venda': int,
            'total_periodo': int
        }
        """
        try:
            if df.empty or 'quantidade' not in df.columns:
                return self._estatisticas_vazias()

            qtd = df['quantidade']

            # Filtrar apenas valores válidos
            qtd_valida = qtd[qtd >= 0]

            if len(qtd_valida) == 0:
                return self._estatisticas_vazias()

            media = qtd_valida.mean()
            desvio = qtd_valida.std() if len(qtd_valida) > 1 else 0

            return {
                'media': float(media) if not pd.isna(media) else 0,
                'mediana': float(qtd_valida.median()) if not pd.isna(qtd_valida.median()) else 0,
                'desvio_padrao': float(desvio) if not pd.isna(desvio) else 0,
                'min': float(qtd_valida.min()) if not pd.isna(qtd_valida.min()) else 0,
                'max': float(qtd_valida.max()) if not pd.isna(qtd_valida.max()) else 0,
                'amplitude': float(qtd_valida.max() - qtd_valida.min()) if len(qtd_valida) > 0 else 0,
                'coef_variacao': float(desvio / media) if media > 0 and not pd.isna(desvio) else 0,
                'q1': float(qtd_valida.quantile(0.25)) if len(qtd_valida) > 0 else 0,
                'q2': float(qtd_valida.quantile(0.50)) if len(qtd_valida) > 0 else 0,
                'q3': float(qtd_valida.quantile(0.75)) if len(qtd_valida) > 0 else 0,
                'dias_com_venda': int((qtd > 0).sum()),
                'total_vendido': float(qtd_valida.sum())
            }

        except Exception as e:
            self.logger.error(f"Erro ao calcular estatísticas: {e}")
            return self._estatisticas_vazias()

    def _estatisticas_vazias(self) -> Dict:
        """Retorna estatísticas zeradas"""
        return {
            'media': 0, 'mediana': 0, 'desvio_padrao': 0,
            'min': 0, 'max': 0, 'amplitude': 0, 'coef_variacao': 0,
            'q1': 0, 'q2': 0, 'q3': 0,
            'dias_com_venda': 0, 'total_vendido': 0
        }

    def detectar_outliers(self, df: pd.DataFrame, metodo: str = 'iqr') -> pd.DataFrame:
        """
        Identifica outliers usando IQR ou Z-score.

        Args:
            df: DataFrame com coluna 'quantidade'
            metodo: 'iqr' ou 'zscore'

        Returns: DataFrame com coluna 'outlier' (True/False)
        """
        try:
            df = df.copy()
            df['outlier'] = False

            if df.empty or 'quantidade' not in df.columns:
                return df

            qtd = df['quantidade']

            if len(qtd) < 4:  # Precisa de pelo menos 4 pontos
                return df

            if metodo == 'iqr':
                q1 = qtd.quantile(0.25)
                q3 = qtd.quantile(0.75)
                iqr = q3 - q1

                if iqr > 0:
                    lower = q1 - 1.5 * iqr
                    upper = q3 + 1.5 * iqr
                    df['outlier'] = (qtd < lower) | (qtd > upper)

            elif metodo == 'zscore':
                mean = qtd.mean()
                std = qtd.std()
                if std > 0:
                    z_scores = np.abs((qtd - mean) / std)
                    df['outlier'] = z_scores > 3

            outliers_count = df['outlier'].sum()
            if outliers_count > 0:
                self.logger.debug(f"Outliers detectados: {outliers_count} usando {metodo}")

            return df

        except Exception as e:
            self.logger.error(f"Erro ao detectar outliers: {e}")
            df['outlier'] = False
            return df

    def calcular_tendencia(self, df: pd.DataFrame) -> Dict:
        """
        Calcula tendência usando regressão linear.

        Returns: {
            'coeficiente': float,      # inclinação da reta
            'r_squared': float,        # R² da regressão
            'tendencia': str,          # 'CRESCENTE', 'ESTAVEL', 'DECRESCENTE'
            'variacao_percentual': float
        }
        """
        try:
            if df.empty or len(df) < 7:
                return {
                    'coeficiente': 0,
                    'r_squared': 0,
                    'tendencia': 'ESTAVEL',
                    'variacao_percentual': 0
                }

            # Usa índice numérico para regressão
            x = np.arange(len(df))
            y = df['quantidade'].values

            # Filtrar valores válidos
            mask = ~(np.isnan(y) | np.isinf(y))
            x_clean = x[mask]
            y_clean = y[mask]

            if len(x_clean) < 3:
                return {
                    'coeficiente': 0,
                    'r_squared': 0,
                    'tendencia': 'ESTAVEL',
                    'variacao_percentual': 0
                }

            slope, intercept, r_value, p_value, std_err = stats.linregress(x_clean, y_clean)

            # Determina tendência baseado no coeficiente e R²
            r_squared = r_value ** 2

            if r_squared < 0.1:  # R² baixo = sem tendência clara
                tendencia = 'ESTAVEL'
            elif slope > 0.1:  # Inclinação positiva significativa
                tendencia = 'CRESCENTE'
            elif slope < -0.1:  # Inclinação negativa significativa
                tendencia = 'DECRESCENTE'
            else:
                tendencia = 'ESTAVEL'

            # Variação percentual
            valor_inicial = intercept
            valor_final = intercept + slope * len(x_clean)
            variacao = ((valor_final - valor_inicial) / valor_inicial * 100) if valor_inicial > 0 else 0

            self.logger.debug(f"Tendência calculada: {tendencia} (R²={r_squared:.3f})")

            return {
                'coeficiente': float(slope),
                'r_squared': float(r_squared),
                'tendencia': tendencia,
                'variacao_percentual': float(variacao)
            }

        except Exception as e:
            self.logger.error(f"Erro ao calcular tendência: {e}")
            return {
                'coeficiente': 0,
                'r_squared': 0,
                'tendencia': 'ESTAVEL',
                'variacao_percentual': 0
            }

    def gerar_distribuicao_probabilistica(self, df: pd.DataFrame) -> Dict:
        """
        Ajusta distribuição aos dados e retorna percentis.

        Returns: {
            'distribuicao': str,       # nome da distribuição
            'p10': float,
            'p25': float,
            'p50': float,
            'p75': float,
            'p90': float,
            'aderencia': float
        }
        """
        try:
            if df.empty or len(df) < 5:
                return {
                    'distribuicao': 'insuficiente',
                    'p10': 0, 'p25': 0, 'p50': 0, 'p75': 0, 'p90': 0,
                    'aderencia': 0
                }

            qtd = df['quantidade'].values

            # Filtrar valores válidos
            qtd_clean = qtd[~(np.isnan(qtd) | np.isinf(qtd))]
            qtd_clean = qtd_clean[qtd_clean >= 0]

            if len(qtd_clean) < 3:
                return {
                    'distribuicao': 'insuficiente',
                    'p10': 0, 'p25': 0, 'p50': 0, 'p75': 0, 'p90': 0,
                    'aderencia': 0
                }

            # Calcula percentis empíricos
            percentis = {
                'distribuicao': 'empirica',
                'p10': float(np.percentile(qtd_clean, 10)),
                'p25': float(np.percentile(qtd_clean, 25)),
                'p50': float(np.percentile(qtd_clean, 50)),
                'p75': float(np.percentile(qtd_clean, 75)),
                'p90': float(np.percentile(qtd_clean, 90)),
                'aderencia': 1.0  # Empírica sempre adere 100%
            }

            self.logger.debug(f"Distribuição calculada: P50={percentis['p50']:.2f}")
            return percentis

        except Exception as e:
            self.logger.error(f"Erro ao gerar distribuição: {e}")
            return {
                'distribuicao': 'erro',
                'p10': 0, 'p25': 0, 'p50': 0, 'p75': 0, 'p90': 0,
                'aderencia': 0
            }

    def preencher_dias_sem_venda(self, df: pd.DataFrame,
                                  data_inicio: date,
                                  data_fim: date,
                                  valor_preenchimento: float = 0) -> pd.DataFrame:
        """
        Preenche dias sem registro com valor especificado.
        Importante para produtos de venda intermitente.
        """
        try:
            # Criar range de todas as datas
            todas_datas = pd.date_range(start=data_inicio, end=data_fim, freq='D')

            if df.empty:
                # Cria DataFrame com todos os dias zerados
                return pd.DataFrame({
                    'data': todas_datas,
                    'quantidade': valor_preenchimento,
                    'valor': 0,
                    'dia_semana': todas_datas.dayofweek,
                    'semana_mes': ((todas_datas.day - 1) // 7) + 1,
                    'mes': todas_datas.month
                })

            # Garantir que 'data' é datetime
            if 'data' in df.columns:
                df['data'] = pd.to_datetime(df['data'])

                # Reindexar para incluir todos os dias
                df_indexed = df.set_index('data')

                # Criar DataFrame completo com todas as datas
                df_completo = pd.DataFrame(index=todas_datas)

                # Mesclar com dados existentes
                df_final = df_completo.join(df_indexed, how='left')

                # Preencher valores ausentes
                df_final['quantidade'] = df_final['quantidade'].fillna(valor_preenchimento)
                df_final['valor'] = df_final['valor'].fillna(0)

                # Recalcular campos de data
                df_final['dia_semana'] = df_final.index.dayofweek
                df_final['semana_mes'] = ((df_final.index.day - 1) // 7) + 1
                df_final['mes'] = df_final.index.month

                # Reset index para ter 'data' como coluna
                df_final = df_final.reset_index().rename(columns={'index': 'data'})

                self.logger.debug(f"Dias preenchidos: {len(todas_datas)} total, {len(df)} com vendas")
                return df_final

            else:
                self.logger.warning("Coluna 'data' não encontrada no DataFrame")
                return df

        except Exception as e:
            self.logger.error(f"Erro ao preencher dias sem venda: {e}")
            return df

    # =========================================================================
    # MÉTODO PRINCIPAL
    # =========================================================================

    def analisar(self, id_prod: int, id_filial: int,
                 dias: int = 90) -> Dict:
        """
        Executa análise completa de séries temporais.

        Returns: {
            'historico': pd.DataFrame,
            'estatisticas': dict,
            'distribuicao': dict,
            'tendencia': dict,
            'outliers_count': int,
            'dias_analisados': int,
            'qualidade_dados': str  # 'BOA', 'MEDIA', 'RUIM', 'INSUFICIENTE'
        }
        """
        try:
            self.logger.info(f"Iniciando análise de séries temporais: produto {id_prod}, filial {id_filial}")

            # 1. Obter histórico
            df = self.obter_historico_vendas(id_prod, id_filial, dias)

            if df.empty:
                self.logger.warning(f"Sem histórico para produto {id_prod}, filial {id_filial}")
                return {
                    'historico': pd.DataFrame(),
                    'estatisticas': self._estatisticas_vazias(),
                    'distribuicao': {'distribuicao': 'insuficiente', 'p10': 0, 'p25': 0, 'p50': 0, 'p75': 0, 'p90': 0, 'aderencia': 0},
                    'tendencia': {'coeficiente': 0, 'r_squared': 0, 'tendencia': 'ESTAVEL', 'variacao_percentual': 0},
                    'outliers_count': 0,
                    'dias_analisados': dias,
                    'dias_com_venda': 0,
                    'qualidade_dados': 'INSUFICIENTE'
                }

            # 2. Determinar qualidade dos dados
            dias_com_venda = len(df)
            if dias_com_venda < 5:
                qualidade = 'INSUFICIENTE'
            elif dias_com_venda < 15:
                qualidade = 'RUIM'
            elif dias_com_venda < 30:
                qualidade = 'MEDIA'
            else:
                qualidade = 'BOA'

            # 3. Preencher dias sem venda
            data_inicio = date.today() - timedelta(days=dias)
            data_fim = date.today()
            df_completo = self.preencher_dias_sem_venda(df, data_inicio, data_fim)

            # 4. Calcular análises
            estatisticas = self.calcular_estatisticas_basicas(df)
            distribuicao = self.gerar_distribuicao_probabilistica(df)
            tendencia = self.calcular_tendencia(df)

            # 5. Detectar outliers
            df_outliers = self.detectar_outliers(df)
            outliers_count = df_outliers['outlier'].sum() if 'outlier' in df_outliers.columns else 0

            resultado = {
                'historico': df_completo,
                'estatisticas': estatisticas,
                'distribuicao': distribuicao,
                'tendencia': tendencia,
                'outliers_count': int(outliers_count),
                'dias_analisados': dias,
                'dias_com_venda': dias_com_venda,
                'qualidade_dados': qualidade
            }

            self.logger.info(
                f"Análise concluída: {dias_com_venda} dias com vendas, qualidade={qualidade}, "
                f"tendência={tendencia.get('tendencia', 'N/A')}"
            )

            return resultado

        except Exception as e:
            self.logger.error(f"Erro na análise de séries temporais: {e}")
            return {
                'historico': pd.DataFrame(),
                'estatisticas': self._estatisticas_vazias(),
                'distribuicao': {'distribuicao': 'erro', 'p10': 0, 'p25': 0, 'p50': 0, 'p75': 0, 'p90': 0, 'aderencia': 0},
                'tendencia': {'coeficiente': 0, 'r_squared': 0, 'tendencia': 'ESTAVEL', 'variacao_percentual': 0},
                'outliers_count': 0,
                'dias_analisados': dias,
                'dias_com_venda': 0,
                'qualidade_dados': 'INSUFICIENTE'
            }