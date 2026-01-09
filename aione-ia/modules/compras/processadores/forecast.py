"""
AIONE IA - Motor Principal de Forecast
Motor orquestrador completo que integra todas as análises para gerar forecast probabilístico
"""

import pandas as pd
import numpy as np
from typing import List, Dict, Optional
from datetime import datetime, date, timedelta
from sqlalchemy import text

from core.database import DatabaseManager
from core.utils import get_logger

from .metricas import CalculadoraMetricas, ParametrosForecast, ResultadoForecast, MetricasProduto
from .series_temporais import AnalisadorSeriesTemporal
from .sazonalidade import DetectorSazonalidade
from .ajuste_eventos import AjustadorEventos

logger = get_logger(__name__)


class ForecastEngine:
    """
    Motor principal de forecast probabilístico.

    Orquestra todas as análises e gera o forecast final integrando:
    - Análise de séries temporais
    - Detecção de sazonalidade
    - Ajustes por eventos externos
    - Cálculos probabilísticos de estoque
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o motor de forecast.

        Args:
            db: Instância do DatabaseManager
        """
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

        # Componentes especializados
        self.analisador = AnalisadorSeriesTemporal(db)
        self.detector_sazonalidade = DetectorSazonalidade()
        self.ajustador_eventos = AjustadorEventos(db)
        self.calculadora = CalculadoraMetricas()

        # Parâmetros padrão
        self.parametros = ParametrosForecast()

        # Cache para performance
        self._cache_grupos = {}
        self._cache_tempo_reposicao = {}

    # ==================== MÉTODO PRINCIPAL ====================

    def gerar_forecast(self, id_prod: int,
                       id_filial: int,
                       id_regiao: int = None,
                       parametros: ParametrosForecast = None) -> ResultadoForecast:
        """
        Gera forecast completo para um produto/filial.

        Etapas:
        1. Extrai histórico de vendas
        2. Analisa séries temporais
        3. Detecta sazonalidade
        4. Busca eventos futuros e calcula ajustes
        5. Gera distribuição probabilística
        6. Calcula métricas de estoque
        7. Gera 3 cenários

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            id_regiao: ID da região (None para buscar automaticamente)
            parametros: Parâmetros personalizados (None para usar padrão)

        Returns:
            ResultadoForecast com análise completa
        """
        try:
            params = parametros or self.parametros
            alertas = []

            # ETAPA 1: Histórico
            self.logger.info(f"Forecast produto {id_prod}, filial {id_filial}")

            analise = self.analisador.analisar(
                id_prod, id_filial,
                dias=params.dias_historico_analise
            )

            if analise['qualidade_dados'] == 'INSUFICIENTE':
                alertas.append("Dados insuficientes para forecast confiável")
                # Usa médias do grupo ou valores padrão
                analise = self._fallback_grupo(id_prod, id_filial)

            # ETAPA 2: Sazonalidade
            sazonalidade = None
            if params.considerar_sazonalidade and len(analise['historico']) >= 30:
                sazonalidade = self.detector_sazonalidade.analisar(
                    analise['historico'],
                    min_dias=30
                )
                if sazonalidade['sazonalidade_detectada']:
                    self.logger.info(f"Sazonalidade detectada - força: {sazonalidade['forca_sazonalidade']:.2f}")

            # ETAPA 3: Eventos futuros
            ajustes = {'fator_ajuste': 1.0, 'eventos_aplicados': [], 'alertas_aplicados': [], 'correlacoes_usadas': []}

            if params.considerar_eventos:
                if id_regiao is None:
                    id_regiao = self._obter_regiao_filial(id_filial)

                if id_regiao:
                    data_inicio = date.today()
                    data_fim = data_inicio + timedelta(days=params.dias_cobertura_alvo)

                    ajustes = self.ajustador_eventos.calcular_ajustes(
                        id_prod=id_prod,
                        id_grupo=self._obter_grupo(id_prod),
                        id_filial=id_filial,
                        id_regiao=id_regiao,
                        data_inicio=data_inicio,
                        data_fim=data_fim
                    )

                    if ajustes['fator_ajuste'] != 1.0:
                        self.logger.info(f"Ajuste por eventos aplicado: {ajustes['fator_ajuste']:.2f}")

            # ETAPA 4: Cálculo base
            cmd = analise['estatisticas']['media']
            desvio = analise['estatisticas']['desvio_padrao']
            estoque_atual = self.analisador.obter_estoque_atual(id_prod, id_filial)

            if cmd <= 0:
                alertas.append("CMD zero ou negativo - usando fallback")
                cmd = self._calcular_cmd_fallback(id_prod, id_filial)

            # ETAPA 5: Aplicar ajustes
            cmd_ajustado = cmd * ajustes['fator_ajuste']

            # Aplicar ajuste sazonal se disponível
            if sazonalidade and not sazonalidade.get('usar_padrao', True):
                data_inicio = date.today()
                projecoes = self.detector_sazonalidade.projetar_demanda_periodo(
                    cmd_ajustado, data_inicio, params.dias_cobertura_alvo, sazonalidade
                )
                if projecoes:
                    fator_sazonal = np.mean([p['indice_aplicado'] for p in projecoes])
                    cmd_ajustado *= fator_sazonal
                    self.logger.debug(f"Fator sazonal aplicado: {fator_sazonal:.3f}")

            # ETAPA 6: Métricas
            tempo_reposicao = self._obter_tempo_reposicao(id_prod, id_filial) or params.tempo_reposicao_padrao

            estoque_seguranca = self.calculadora.calcular_estoque_seguranca(
                desvio, tempo_reposicao
            )

            ponto_pedido = self.calculadora.calcular_ponto_pedido(
                cmd_ajustado,
                tempo_reposicao,
                estoque_seguranca
            )

            dias_cobertura = self.calculadora.calcular_dias_cobertura(
                estoque_atual, cmd_ajustado
            )

            # ETAPA 7: Cenários
            distribuicao = analise['distribuicao']

            # Demanda total para o período de cobertura (ajustada)
            demanda_p10 = distribuicao['p10'] * params.dias_cobertura_alvo * ajustes['fator_ajuste']
            demanda_p50 = distribuicao['p50'] * params.dias_cobertura_alvo * ajustes['fator_ajuste']
            demanda_p90 = distribuicao['p90'] * params.dias_cobertura_alvo * ajustes['fator_ajuste']

            # Quantidade a comprar = Demanda - Estoque + Estoque Segurança
            cen_otimista = max(0, demanda_p10 - estoque_atual + estoque_seguranca)
            cen_conservador = max(0, demanda_p50 - estoque_atual + estoque_seguranca)
            cen_critico = max(0, demanda_p90 - estoque_atual + estoque_seguranca)

            # ETAPA 8: Risco
            risco_ruptura = self.calculadora.calcular_risco_ruptura(
                estoque_atual, cmd_ajustado, desvio, tempo_reposicao
            )

            if risco_ruptura > 0.3:
                alertas.append(f"Risco de ruptura: {risco_ruptura*100:.0f}%")

            tempo_ate_ruptura = self.calculadora.calcular_tempo_ate_ruptura(estoque_atual, cmd_ajustado)

            # Verificar alertas críticos
            if tempo_ate_ruptura <= tempo_reposicao:
                alertas.append(f"CRÍTICO: Ruptura em {tempo_ate_ruptura} dias")
            elif dias_cobertura < tempo_reposicao * 2:
                alertas.append(f"Baixa cobertura: {dias_cobertura:.1f} dias")

            # ETAPA 9: Montar resultado
            metricas = MetricasProduto(
                id_prod=id_prod,
                id_filial=id_filial,
                consumo_medio_diario=cmd_ajustado,
                desvio_padrao_diario=desvio,
                coef_variacao=desvio/cmd if cmd > 0 else 0,
                estoque_atual=estoque_atual,
                estoque_seguranca=estoque_seguranca,
                ponto_pedido=ponto_pedido,
                dias_cobertura=dias_cobertura,
                cen_otimista=cen_otimista,
                cen_conservador=cen_conservador,
                cen_critico=cen_critico,
                risco_ruptura=risco_ruptura,
                tempo_ate_ruptura=tempo_ate_ruptura,
                dias_historico=analise['dias_analisados'],
                data_calculo=datetime.now()
            )

            # Calcular confiança geral
            confianca = self._calcular_confianca(
                analise['qualidade_dados'],
                sazonalidade.get('forca_sazonalidade', 0) if sazonalidade else 0,
                len(ajustes['correlacoes_usadas'])
            )

            resultado = ResultadoForecast(
                metricas=metricas,
                historico_vendas=analise['historico'].to_dict('records')[-30:] if len(analise['historico']) > 30 else analise['historico'].to_dict('records'),
                ajustes_aplicados=ajustes['eventos_aplicados'] + ajustes['alertas_aplicados'],
                confianca=confianca,
                alertas=alertas
            )

            self.logger.info(
                f"Forecast gerado: CMD={cmd_ajustado:.2f}, "
                f"Cenário conservador={cen_conservador:.0f}, "
                f"Confiança={confianca:.0f}%"
            )

            return resultado

        except Exception as e:
            self.logger.error(f"Erro ao gerar forecast: {e}")
            raise

    # ==================== MÉTODOS DE LOTE ====================

    def gerar_forecast_filial(self, id_filial: int,
                              id_regiao: int = None,
                              apenas_abaixo_ponto_pedido: bool = False,
                              limite: int = None) -> List[ResultadoForecast]:
        """
        Gera forecast para todos os produtos de uma filial.

        Args:
            id_filial: Filial a processar
            id_regiao: Região para eventos (opcional)
            apenas_abaixo_ponto_pedido: Se True, só processa produtos críticos
            limite: Máximo de produtos (None = todos)

        Returns:
            Lista de ResultadoForecast
        """
        try:
            self.logger.info(f"Gerando forecast para filial {id_filial}")

            # Buscar produtos da filial
            produtos = self._buscar_produtos_filial(id_filial, apenas_abaixo_ponto_pedido, limite)

            if not produtos:
                self.logger.warning(f"Nenhum produto encontrado para filial {id_filial}")
                return []

            resultados = []
            sucessos = 0

            for produto in produtos:
                try:
                    resultado = self.gerar_forecast(
                        produto['id_prod'],
                        id_filial,
                        id_regiao
                    )
                    resultados.append(resultado)
                    sucessos += 1

                    self.logger.debug(f"Forecast gerado para produto {produto['id_prod']}")

                except Exception as e:
                    self.logger.error(f"Erro no produto {produto['id_prod']}: {e}")
                    continue

            self.logger.info(f"Forecast filial {id_filial}: {sucessos}/{len(produtos)} produtos processados")
            return resultados

        except Exception as e:
            self.logger.error(f"Erro no forecast da filial: {e}")
            return []

    def gerar_forecast_grupo(self, id_grupo: int,
                             id_filial: int,
                             id_regiao: int = None) -> List[ResultadoForecast]:
        """
        Gera forecast para todos os produtos de um grupo.

        Args:
            id_grupo: Grupo a processar
            id_filial: Filial específica
            id_regiao: Região para eventos (opcional)

        Returns:
            Lista de ResultadoForecast
        """
        try:
            self.logger.info(f"Gerando forecast para grupo {id_grupo}, filial {id_filial}")

            # Buscar produtos do grupo
            produtos = self._buscar_produtos_grupo(id_grupo, id_filial)

            if not produtos:
                self.logger.warning(f"Nenhum produto encontrado para grupo {id_grupo}")
                return []

            resultados = []
            sucessos = 0

            for produto in produtos:
                try:
                    resultado = self.gerar_forecast(
                        produto['id_prod'],
                        id_filial,
                        id_regiao
                    )
                    resultados.append(resultado)
                    sucessos += 1

                except Exception as e:
                    self.logger.error(f"Erro no produto {produto['id_prod']}: {e}")
                    continue

            self.logger.info(f"Forecast grupo {id_grupo}: {sucessos}/{len(produtos)} produtos processados")
            return resultados

        except Exception as e:
            self.logger.error(f"Erro no forecast do grupo: {e}")
            return []

    # ==================== MÉTODOS AUXILIARES ====================

    def _fallback_grupo(self, id_prod: int, id_filial: int) -> Dict:
        """
        Quando produto não tem histórico suficiente,
        usa média do grupo ou valores padrão.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Análise simulada baseada em dados do grupo
        """
        try:
            id_grupo = self._obter_grupo(id_prod)

            # Tentar buscar média do grupo
            with self.db.session_scope() as session:
                query = text("""
                    SELECT
                        AVG(h.QtdHist) as media_grupo,
                        STDDEV(h.QtdHist) as desvio_grupo,
                        COUNT(*) as total_vendas
                    FROM ia_arqhistcom h
                    INNER JOIN arqproduto p ON h.IDProd = p.IDProd
                    WHERE p.IDGrupo = :id_grupo
                      AND h.IDFilial = :id_filial
                      AND h.TipoHist = 'SAÍDA'
                      AND h.DatHist >= DATE_SUB(NOW(), INTERVAL 90 DAY)
                """)

                result = session.execute(query, {
                    'id_grupo': id_grupo,
                    'id_filial': id_filial
                })
                row = result.fetchone()

                if row and row.media_grupo:
                    media_grupo = float(row.media_grupo)
                    desvio_grupo = float(row.desvio_grupo or media_grupo * 0.3)  # 30% se não há desvio

                    # Simular histórico baseado na média do grupo
                    historico_simulado = pd.DataFrame({
                        'data': pd.date_range(end=date.today(), periods=30, freq='D'),
                        'quantidade': np.random.normal(media_grupo, desvio_grupo, 30)
                    })
                    historico_simulado['quantidade'] = historico_simulado['quantidade'].clip(lower=0)

                    self.logger.info(f"Usando fallback do grupo {id_grupo}: média={media_grupo:.2f}")

                    return {
                        'qualidade_dados': 'GRUPO_FALLBACK',
                        'estatisticas': {
                            'media': media_grupo,
                            'desvio_padrao': desvio_grupo
                        },
                        'distribuicao': {
                            'p10': media_grupo * 0.7,
                            'p50': media_grupo,
                            'p90': media_grupo * 1.5
                        },
                        'historico': historico_simulado,
                        'dias_analisados': 30
                    }

            # Se não encontrou dados do grupo, usar valores padrão
            self.logger.warning(f"Usando valores padrão para produto {id_prod}")

            historico_padrao = pd.DataFrame({
                'data': pd.date_range(end=date.today(), periods=7, freq='D'),
                'quantidade': [1.0] * 7  # 1 unidade por dia
            })

            return {
                'qualidade_dados': 'PADRAO_FALLBACK',
                'estatisticas': {
                    'media': 1.0,
                    'desvio_padrao': 0.5
                },
                'distribuicao': {
                    'p10': 0.5,
                    'p50': 1.0,
                    'p90': 2.0
                },
                'historico': historico_padrao,
                'dias_analisados': 7
            }

        except Exception as e:
            self.logger.error(f"Erro no fallback do grupo: {e}")
            # Fallback do fallback
            return {
                'qualidade_dados': 'ERRO_FALLBACK',
                'estatisticas': {'media': 1.0, 'desvio_padrao': 0.5},
                'distribuicao': {'p10': 0.5, 'p50': 1.0, 'p90': 2.0},
                'historico': pd.DataFrame({'data': [date.today()], 'quantidade': [1.0]}),
                'dias_analisados': 1
            }

    def _obter_grupo(self, id_prod: int) -> int:
        """Busca IDGrupo do produto com cache."""
        if id_prod in self._cache_grupos:
            return self._cache_grupos[id_prod]

        try:
            with self.db.session_scope() as session:
                query = text("SELECT IDGrupo FROM arqproduto WHERE IDProd = :id_prod")
                result = session.execute(query, {'id_prod': id_prod})
                row = result.fetchone()

                id_grupo = row.IDGrupo if row else 1  # Grupo padrão
                self._cache_grupos[id_prod] = id_grupo
                return id_grupo

        except Exception as e:
            self.logger.warning(f"Erro ao obter grupo do produto: {e}")
            return 1  # Grupo padrão

    def _obter_regiao_filial(self, id_filial: int) -> Optional[int]:
        """Busca IDRegiao da filial."""
        try:
            with self.db.session_scope() as session:
                query = text("SELECT IDRegiao FROM arqfilial WHERE IDFilial = :id_filial")
                result = session.execute(query, {'id_filial': id_filial})
                row = result.fetchone()
                return row.IDRegiao if row else None

        except Exception as e:
            self.logger.warning(f"Erro ao obter região da filial: {e}")
            return None

    def _calcular_confianca(self, qualidade_dados: str,
                            confianca_sazonalidade: float,
                            qtd_correlacoes: int) -> float:
        """
        Calcula confiança geral do forecast (0-100).

        Fatores:
        - Qualidade dos dados: 40%
        - Sazonalidade detectada: 30%
        - Correlações aplicadas: 30%

        Args:
            qualidade_dados: 'BOA', 'REGULAR', 'INSUFICIENTE', etc.
            confianca_sazonalidade: 0-1 da análise sazonal
            qtd_correlacoes: Número de correlações aplicadas

        Returns:
            Confiança de 0 a 100
        """
        try:
            # Fator de qualidade dos dados (40%)
            qualidade_score = {
                'EXCELENTE': 1.0,
                'BOA': 0.8,
                'REGULAR': 0.6,
                'INSUFICIENTE': 0.3,
                'GRUPO_FALLBACK': 0.5,
                'PADRAO_FALLBACK': 0.2,
                'ERRO_FALLBACK': 0.1
            }.get(qualidade_dados, 0.4)

            # Fator de sazonalidade (30%)
            sazonal_score = min(1.0, confianca_sazonalidade)

            # Fator de correlações (30%)
            correlacao_score = min(1.0, qtd_correlacoes / 3)  # Máximo com 3 correlações

            # Combinar fatores
            confianca_final = (
                qualidade_score * 0.4 +
                sazonal_score * 0.3 +
                correlacao_score * 0.3
            )

            return min(100.0, confianca_final * 100)

        except Exception as e:
            self.logger.warning(f"Erro ao calcular confiança: {e}")
            return 50.0  # Confiança média como fallback

    def _obter_tempo_reposicao(self, id_prod: int, id_filial: int) -> Optional[int]:
        """
        Busca tempo de reposição específico do produto/fornecedor.
        Se não encontrar, retorna None (usa padrão).

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Tempo de reposição em dias ou None
        """
        cache_key = f"{id_prod}_{id_filial}"
        if cache_key in self._cache_tempo_reposicao:
            return self._cache_tempo_reposicao[cache_key]

        try:
            with self.db.session_scope() as session:
                query = text("""
                    SELECT pr.TempoRepos
                    FROM arqproduto p
                    LEFT JOIN arqprodutorepos pr ON p.IDForned = pr.IDForned
                      AND pr.IDFilial = :id_filial
                    WHERE p.IDProd = :id_prod
                      AND pr.TempoRepos IS NOT NULL
                """)

                result = session.execute(query, {
                    'id_prod': id_prod,
                    'id_filial': id_filial
                })
                row = result.fetchone()

                tempo = int(row.TempoRepos) if row and row.TempoRepos else None
                self._cache_tempo_reposicao[cache_key] = tempo
                return tempo

        except Exception as e:
            self.logger.debug(f"Erro ao buscar tempo de reposição: {e}")
            return None

    def _calcular_cmd_fallback(self, id_prod: int, id_filial: int) -> float:
        """Calcula CMD fallback quando análise falha."""
        try:
            # Tentar média dos últimos 30 dias
            with self.db.session_scope() as session:
                query = text("""
                    SELECT AVG(QtdHist) as media
                    FROM ia_arqhistcom
                    WHERE IDProd = :id_prod
                      AND IDFilial = :id_filial
                      AND TipoHist = 'SAÍDA'
                      AND DatHist >= DATE_SUB(NOW(), INTERVAL 30 DAY)
                """)

                result = session.execute(query, {
                    'id_prod': id_prod,
                    'id_filial': id_filial
                })
                row = result.fetchone()

                if row and row.media:
                    return float(row.media)

            # Se não encontrou, usar 1.0 como padrão mínimo
            return 1.0

        except Exception:
            return 1.0

    def _buscar_produtos_filial(self, id_filial: int,
                                apenas_criticos: bool = False,
                                limite: int = None) -> List[Dict]:
        """Busca produtos da filial para processamento."""
        try:
            with self.db.session_scope() as session:
                where_clause = "p.AtivoPrd = 'S'"

                if apenas_criticos:
                    # Apenas produtos com estoque baixo
                    where_clause += " AND COALESCE(SUM(pl.QtdEstoque), 0) < 100"

                query = text(f"""
                    SELECT p.IDProd as id_prod, p.NomePrd as nome_prod
                    FROM arqproduto p
                    LEFT JOIN arqprodutolot pl ON p.IDProd = pl.IDProd
                      AND pl.IDFilial = :id_filial
                      AND pl.DatValidade > NOW()
                    WHERE {where_clause}
                    GROUP BY p.IDProd, p.NomePrd
                    ORDER BY COALESCE(SUM(pl.QtdEstoque), 0) ASC
                    {f'LIMIT {limite}' if limite else ''}
                """)

                result = session.execute(query, {'id_filial': id_filial})
                return [dict(row) for row in result.fetchall()]

        except Exception as e:
            self.logger.error(f"Erro ao buscar produtos da filial: {e}")
            return []

    def _buscar_produtos_grupo(self, id_grupo: int, id_filial: int) -> List[Dict]:
        """Busca produtos do grupo para processamento."""
        try:
            with self.db.session_scope() as session:
                query = text("""
                    SELECT p.IDProd as id_prod, p.NomePrd as nome_prod
                    FROM arqproduto p
                    WHERE p.IDGrupo = :id_grupo
                      AND p.AtivoPrd = 'S'
                    ORDER BY p.NomePrd
                """)

                result = session.execute(query, {
                    'id_grupo': id_grupo
                })
                return [dict(row) for row in result.fetchall()]

        except Exception as e:
            self.logger.error(f"Erro ao buscar produtos do grupo: {e}")
            return []
