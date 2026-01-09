"""
AIONE IA - Métricas e Estruturas de Dados do Forecast
Sistema de cálculo de métricas para previsão probabilística de demanda
"""

import math
from dataclasses import dataclass, asdict, field
from datetime import datetime, date
from typing import Optional, List, Dict, Any
from decimal import Decimal

from scipy import stats
import numpy as np

from core.utils import get_logger

logger = get_logger(__name__)


# =============================================================================
# DATACLASSES PARA ESTRUTURAR DADOS
# =============================================================================

@dataclass
class MetricasProduto:
    """
    Métricas calculadas para um produto/filial.

    Contém todas as métricas necessárias para gestão de estoque
    e previsão de demanda probabilística.
    """
    id_prod: int
    id_filial: int
    id_grupo: Optional[int] = None

    # Consumo
    consumo_medio_diario: float = 0.0      # CMD - Consumo Médio Diário
    desvio_padrao_diario: float = 0.0      # σ - Desvio Padrão da Demanda
    coef_variacao: float = 0.0             # CV = σ/CMD - Coeficiente de Variação
    tendencia: Optional[str] = None        # CRESCENTE/ESTAVEL/DECRESCENTE

    # Estoque
    estoque_atual: float = 0.0
    estoque_seguranca: float = 0.0         # ES = Z * σ * √(TR + PR)
    ponto_pedido: float = 0.0              # PP = (CMD * TR) + ES
    dias_cobertura: float = 0.0            # DC = EstoqueAtual / CMD

    # Cenários de quantidade a comprar (para X dias)
    cen_otimista: float = 0.0              # P10 - Cenário otimista (10% chance de vender mais)
    cen_conservador: float = 0.0           # P50 - Cenário conservador (mediana esperada)
    cen_critico: float = 0.0               # P90 - Cenário crítico (90% chance de vender mais)

    # Risco
    risco_ruptura: float = 0.0             # Probabilidade de ruptura (0-1)
    tempo_ate_ruptura: int = 999           # Dias estimados até ruptura

    # Metadados
    dias_historico: int = 0                # Dias de histórico analisados
    dias_cobertura_alvo: int = 30          # Dias de cobertura alvo
    tempo_reposicao: int = 3               # Tempo de reposição usado no cálculo
    data_calculo: Optional[datetime] = None

    def __post_init__(self):
        """Pós-processamento após inicialização."""
        if self.data_calculo is None:
            self.data_calculo = datetime.now()

        # Calcular coeficiente de variação
        if self.consumo_medio_diario > 0:
            self.coef_variacao = self.desvio_padrao_diario / self.consumo_medio_diario
        else:
            self.coef_variacao = 0.0

    def to_dict(self) -> Dict[str, Any]:
        """Converte para dicionário serializável."""
        data = asdict(self)
        # Converter datetime para string
        if self.data_calculo:
            data['data_calculo'] = self.data_calculo.isoformat()
        return data

    def classificar_criticidade(self) -> str:
        """
        Classifica a criticidade do produto baseado nas métricas.

        Returns:
            'CRITICO' | 'ATENCAO' | 'NORMAL' | 'SOBRA'
        """
        if self.risco_ruptura > 0.5 or self.dias_cobertura <= 3:
            return 'CRITICO'
        elif self.risco_ruptura > 0.3 or self.dias_cobertura <= 7:
            return 'ATENCAO'
        elif self.dias_cobertura <= 15:
            return 'NORMAL'
        else:
            return 'SOBRA'


@dataclass
class ParametrosForecast:
    """
    Parâmetros configuráveis do forecast.

    Define os parâmetros usados nos cálculos de previsão
    e podem ser ajustados por produto ou categoria.
    """
    dias_cobertura_alvo: int = 30          # Dias que a compra deve cobrir
    dias_historico_analise: int = 90       # Dias de histórico a considerar
    nivel_servico: float = 0.95            # 95% = Z de 1.65
    tempo_reposicao_padrao: int = 3        # Lead time padrão em dias
    considerar_sazonalidade: bool = True   # Aplicar ajustes sazonais
    considerar_eventos: bool = True        # Considerar eventos externos
    min_vendas_para_forecast: int = 5      # Mínimo de vendas para calcular
    dias_validade_forecast: int = 7        # Dias até expirar o forecast

    # Limites para qualidade
    min_dias_historico: int = 14           # Mínimo de dias para forecast confiável
    min_confianca_boa: float = 80.0        # % mínima para qualidade BOA
    min_confianca_media: float = 60.0      # % mínima para qualidade MEDIA
    min_confianca_ruim: float = 30.0       # % mínima para qualidade RUIM

    def validar(self) -> List[str]:
        """
        Valida os parâmetros e retorna lista de erros.

        Returns:
            Lista de mensagens de erro (vazia se válido)
        """
        erros = []

        if self.dias_cobertura_alvo <= 0:
            erros.append("dias_cobertura_alvo deve ser maior que 0")

        if self.dias_historico_analise <= 0:
            erros.append("dias_historico_analise deve ser maior que 0")

        if not (0.5 <= self.nivel_servico <= 0.999):
            erros.append("nivel_servico deve estar entre 0.5 e 0.999")

        if self.tempo_reposicao_padrao <= 0:
            erros.append("tempo_reposicao_padrao deve ser maior que 0")

        return erros


@dataclass
class ResultadoForecast:
    """
    Resultado completo do forecast para um produto.

    Contém todas as informações do cálculo, histórico
    e ajustes aplicados para auditoria.
    """
    metricas: Optional[MetricasProduto] = None
    historico_vendas: List[Dict] = field(default_factory=list)            # Últimas vendas analisadas
    ajustes_aplicados: List[Dict] = field(default_factory=list)           # Eventos/alertas considerados
    indices_sazonais: Dict = field(default_factory=dict)                  # Índices de sazonalidade aplicados
    confianca: float = 0.0                                                # 0-100% confiança no forecast
    qualidade_dados: str = 'INSUFICIENTE'                                 # BOA/MEDIA/RUIM/INSUFICIENTE
    fator_ajuste: float = 1.0                                             # Fator aplicado por eventos/sazonalidade
    alertas: List[str] = field(default_factory=list)                      # Alertas gerados durante cálculo
    sazonalidade_detectada: bool = False

    # Metadados de execução
    tempo_execucao_ms: Optional[int] = None                               # Tempo de execução em ms
    versao_algoritmo: str = "1.0"                                         # Versão do algoritmo usado

    def to_dict(self) -> Dict[str, Any]:
        """Converte para dicionário serializável."""
        return {
            'metricas': self.metricas.to_dict() if self.metricas else {},
            'historico_vendas': self.historico_vendas,
            'ajustes_aplicados': self.ajustes_aplicados,
            'indices_sazonais': self.indices_sazonais,
            'confianca': self.confianca,
            'qualidade_dados': self.qualidade_dados,
            'fator_ajuste': self.fator_ajuste,
            'alertas': self.alertas,
            'sazonalidade_detectada': self.sazonalidade_detectada,
            'tempo_execucao_ms': self.tempo_execucao_ms,
            'versao_algoritmo': self.versao_algoritmo
        }

    def adicionar_alerta(self, alerta: str):
        """Adiciona um alerta ao resultado."""
        if alerta not in self.alertas:
            self.alertas.append(alerta)

    def adicionar_ajuste(self, tipo: str, descricao: str, fator: float):
        """Adiciona um ajuste aplicado ao resultado."""
        self.ajustes_aplicados.append({
            'tipo': tipo,
            'descricao': descricao,
            'fator': fator,
            'data_aplicacao': datetime.now().isoformat()
        })


# =============================================================================
# CALCULADORA DE MÉTRICAS
# =============================================================================

class CalculadoraMetricas:
    """
    Calculadora de métricas de estoque e forecast.

    Implementa os cálculos estatísticos e fórmulas de gestão de estoque
    para gerar previsões probabilísticas de demanda.
    """

    def __init__(self, nivel_servico: float = 0.95):
        """
        Inicializa a calculadora com nível de serviço desejado.

        Args:
            nivel_servico: Nível de serviço desejado (ex: 0.95 = 95%)
        """
        self.nivel_servico = nivel_servico
        self.z_score = self._calcular_z_score(nivel_servico)
        self.logger = logger

    def _calcular_z_score(self, nivel: float) -> float:
        """
        Retorna Z-score para o nível de serviço desejado.

        Args:
            nivel: Nível de serviço (ex: 0.95 para 95%)

        Returns:
            Z-score correspondente (ex: 0.95 → 1.65)
        """
        try:
            return stats.norm.ppf(nivel)
        except Exception as e:
            self.logger.warning(f"Erro ao calcular Z-score para nível {nivel}: {e}. Usando Z=1.65")
            return 1.65  # Fallback para 95%

    def calcular_consumo_medio(self, vendas: List[float], dias: int) -> tuple[float, float]:
        """
        Calcula consumo médio diário e desvio padrão.

        Fórmulas:
        - CMD = Σ(vendas) / dias
        - σ = √(Σ(venda - CMD)² / (n-1))

        Args:
            vendas: Lista de quantidades vendidas por dia
            dias: Número total de dias do período (incluindo dias sem venda)

        Returns:
            Tupla (consumo_medio_diario, desvio_padrao)
        """
        if not vendas or dias <= 0:
            return 0.0, 0.0

        try:
            # Remover valores None/negativos
            vendas_validas = [v for v in vendas if v is not None and v >= 0]

            if len(vendas_validas) < 2:
                return 0.0, 0.0

            # Preencher array para todos os dias (incluindo zeros para dias sem venda)
            vendas_completas = vendas_validas + [0.0] * (dias - len(vendas_validas))
            vendas_array = np.array(vendas_completas)

            # Calcular média e desvio
            media = np.mean(vendas_array)
            desvio = np.std(vendas_array, ddof=1) if len(vendas_array) > 1 else 0.0

            self.logger.debug(f"CMD calculado: {media:.4f}, Desvio: {desvio:.4f}")

            return float(media), float(desvio)

        except Exception as e:
            self.logger.error(f"Erro ao calcular consumo médio: {e}")
            return 0.0, 0.0

    def calcular_estoque_seguranca(self, desvio: float, tempo_reposicao: int,
                                   periodo_revisao: int = 0) -> float:
        """
        Calcula estoque de segurança usando fórmula estatística.

        Fórmula: ES = Z * σ * √(TR + PR)
        Onde:
        - Z = Z-score do nível de serviço (ex: 1.65 para 95%)
        - σ = Desvio padrão da demanda diária
        - TR = Tempo de reposição (lead time) em dias
        - PR = Período de revisão em dias (0 para revisão contínua)

        Args:
            desvio: Desvio padrão da demanda diária
            tempo_reposicao: Tempo de reposição em dias
            periodo_revisao: Período de revisão em dias (padrão: 0)

        Returns:
            Estoque de segurança calculado
        """
        try:
            if desvio <= 0 or tempo_reposicao <= 0:
                return 0.0

            tempo_total = tempo_reposicao + periodo_revisao
            estoque_seguranca = self.z_score * desvio * math.sqrt(tempo_total)

            self.logger.debug(
                f"ES calculado: Z={self.z_score:.2f}, σ={desvio:.4f}, "
                f"√(TR+PR)={math.sqrt(tempo_total):.2f}, ES={estoque_seguranca:.4f}"
            )

            return max(0.0, estoque_seguranca)

        except Exception as e:
            self.logger.error(f"Erro ao calcular estoque de segurança: {e}")
            return 0.0

    def calcular_ponto_pedido(self, cmd: float, tempo_reposicao: int,
                              estoque_seguranca: float) -> float:
        """
        Calcula ponto de pedido (reorder point).

        Fórmula: PP = (CMD * TR) + ES
        Onde:
        - CMD = Consumo Médio Diário
        - TR = Tempo de reposição em dias
        - ES = Estoque de segurança

        Args:
            cmd: Consumo médio diário
            tempo_reposicao: Tempo de reposição em dias
            estoque_seguranca: Estoque de segurança

        Returns:
            Ponto de pedido calculado
        """
        try:
            if cmd <= 0 or tempo_reposicao <= 0:
                return estoque_seguranca

            demanda_lead_time = cmd * tempo_reposicao
            ponto_pedido = demanda_lead_time + estoque_seguranca

            self.logger.debug(
                f"PP calculado: CMD={cmd:.4f}, TR={tempo_reposicao}, "
                f"ES={estoque_seguranca:.4f}, PP={ponto_pedido:.4f}"
            )

            return max(0.0, ponto_pedido)

        except Exception as e:
            self.logger.error(f"Erro ao calcular ponto de pedido: {e}")
            return 0.0

    def calcular_dias_cobertura(self, estoque: float, cmd: float) -> float:
        """
        Calcula dias de cobertura do estoque atual.

        Fórmula: DC = EstoqueAtual / CMD

        Args:
            estoque: Estoque atual disponível
            cmd: Consumo médio diário

        Returns:
            Dias de cobertura (999 se CMD = 0)
        """
        try:
            if cmd <= 0:
                return 999.0 if estoque > 0 else 0.0

            dias_cobertura = estoque / cmd

            self.logger.debug(f"DC calculado: Estoque={estoque:.4f}, CMD={cmd:.4f}, DC={dias_cobertura:.2f}")

            return max(0.0, dias_cobertura)

        except Exception as e:
            self.logger.error(f"Erro ao calcular dias de cobertura: {e}")
            return 0.0

    def calcular_quantidade_compra(self, cmd: float, dias_cobertura: int,
                                   estoque_atual: float, estoque_seguranca: float) -> float:
        """
        Calcula quantidade sugerida de compra para atingir cobertura desejada.

        Fórmula: QC = (CMD * DC) + ES - EstoqueAtual
        Onde:
        - QC = Quantidade a comprar
        - CMD = Consumo médio diário
        - DC = Dias de cobertura desejados
        - ES = Estoque de segurança
        - EstoqueAtual = Estoque disponível

        Args:
            cmd: Consumo médio diário
            dias_cobertura: Dias de cobertura desejados
            estoque_atual: Estoque atual disponível
            estoque_seguranca: Estoque de segurança

        Returns:
            Quantidade a comprar (mínimo 0)
        """
        try:
            if cmd <= 0 or dias_cobertura <= 0:
                return 0.0

            estoque_alvo = (cmd * dias_cobertura) + estoque_seguranca
            quantidade_compra = estoque_alvo - estoque_atual

            self.logger.debug(
                f"QC calculado: CMD={cmd:.4f}, DC={dias_cobertura}, "
                f"ES={estoque_seguranca:.4f}, EstAlvo={estoque_alvo:.4f}, "
                f"EstAtual={estoque_atual:.4f}, QC={quantidade_compra:.4f}"
            )

            return max(0.0, quantidade_compra)

        except Exception as e:
            self.logger.error(f"Erro ao calcular quantidade de compra: {e}")
            return 0.0

    def calcular_risco_ruptura(self, estoque: float, cmd: float, desvio: float,
                               tempo_reposicao: int) -> float:
        """
        Calcula probabilidade de ruptura durante o tempo de reposição.

        Usa distribuição normal para estimar a probabilidade de que
        a demanda durante o lead time exceda o estoque disponível.

        Fórmula: P(Ruptura) = P(Demanda_LT > Estoque) = 1 - Φ((Estoque - μ_LT) / σ_LT)
        Onde:
        - μ_LT = CMD * TR (demanda esperada no lead time)
        - σ_LT = σ * √TR (desvio no lead time)
        - Φ = função de distribuição cumulativa normal

        Args:
            estoque: Estoque atual disponível
            cmd: Consumo médio diário
            desvio: Desvio padrão da demanda diária
            tempo_reposicao: Tempo de reposição em dias

        Returns:
            Probabilidade de ruptura (0 a 1)
        """
        try:
            if cmd <= 0 or tempo_reposicao <= 0:
                return 0.0 if estoque > 0 else 1.0

            # Demanda esperada durante o lead time
            demanda_esperada = cmd * tempo_reposicao

            # Se não há variação, ruptura é determinística
            if desvio <= 0:
                return 1.0 if estoque < demanda_esperada else 0.0

            # Desvio padrão da demanda durante o lead time
            desvio_lead_time = desvio * math.sqrt(tempo_reposicao)

            # Z-score para o estoque atual
            z_estoque = (estoque - demanda_esperada) / desvio_lead_time

            # Probabilidade de ruptura = P(Demanda > Estoque) = 1 - CDF(z)
            prob_ruptura = 1 - stats.norm.cdf(z_estoque)

            self.logger.debug(
                f"Risco ruptura: Estoque={estoque:.4f}, DemEsp={demanda_esperada:.4f}, "
                f"σLT={desvio_lead_time:.4f}, Z={z_estoque:.4f}, P(rupt)={prob_ruptura:.4f}"
            )

            return max(0.0, min(1.0, prob_ruptura))

        except Exception as e:
            self.logger.error(f"Erro ao calcular risco de ruptura: {e}")
            return 0.0

    def calcular_tempo_ate_ruptura(self, estoque: float, cmd: float) -> int:
        """
        Calcula tempo estimado até ruptura com consumo médio.

        Fórmula: Dias = EstoqueAtual / CMD

        Args:
            estoque: Estoque atual
            cmd: Consumo médio diário

        Returns:
            Dias estimados até ruptura (999 se CMD = 0)
        """
        try:
            if estoque <= 0:
                return 0

            if cmd <= 0:
                return 999  # "Infinito" - sem consumo

            dias = int(estoque / cmd)

            self.logger.debug(f"Tempo até ruptura: {dias} dias (Estoque={estoque:.4f}, CMD={cmd:.4f})")

            return max(0, dias)

        except Exception as e:
            self.logger.error(f"Erro ao calcular tempo até ruptura: {e}")
            return 0

    def calcular_cenarios_probabilisticos(self, cmd: float, desvio: float, dias_cobertura: int,
                                          estoque_atual: float, estoque_seguranca: float) -> tuple[float, float, float]:
        """
        Calcula cenários probabilísticos de quantidade a comprar (P10, P50, P90).

        Utiliza distribuição normal da demanda para calcular os percentis
        e determinar quantidades de compra para diferentes níveis de risco.

        Args:
            cmd: Consumo médio diário
            desvio: Desvio padrão da demanda diária
            dias_cobertura: Dias de cobertura desejados
            estoque_atual: Estoque atual
            estoque_seguranca: Estoque de segurança

        Returns:
            Tupla (cenario_otimista_P10, cenario_conservador_P50, cenario_critico_P90)
        """
        try:
            if cmd <= 0 or dias_cobertura <= 0:
                return 0.0, 0.0, 0.0

            # Demanda base para o período
            demanda_base = cmd * dias_cobertura

            if desvio <= 0:
                # Sem variação, todos os cenários são iguais
                qtd_base = self.calcular_quantidade_compra(cmd, dias_cobertura, estoque_atual, estoque_seguranca)
                return qtd_base, qtd_base, qtd_base

            # Desvio padrão para o período completo
            desvio_periodo = desvio * math.sqrt(dias_cobertura)

            # Percentis da demanda (P10 = otimista, P50 = conservador, P90 = crítico)
            demanda_p10 = stats.norm.ppf(0.10, demanda_base, desvio_periodo)  # 10% chance de mais
            demanda_p50 = stats.norm.ppf(0.50, demanda_base, desvio_periodo)  # 50% chance (mediana)
            demanda_p90 = stats.norm.ppf(0.90, demanda_base, desvio_periodo)  # 90% chance de mais

            # Quantidade a comprar para cada cenário
            cen_otimista = max(0.0, demanda_p10 + estoque_seguranca - estoque_atual)
            cen_conservador = max(0.0, demanda_p50 + estoque_seguranca - estoque_atual)
            cen_critico = max(0.0, demanda_p90 + estoque_seguranca - estoque_atual)

            self.logger.debug(
                f"Cenários calculados - P10: {cen_otimista:.4f}, "
                f"P50: {cen_conservador:.4f}, P90: {cen_critico:.4f}"
            )

            return cen_otimista, cen_conservador, cen_critico

        except Exception as e:
            self.logger.error(f"Erro ao calcular cenários probabilísticos: {e}")
            return 0.0, 0.0, 0.0

    def avaliar_qualidade_dados(self, num_vendas: int, dias_historico: int,
                                coef_variacao: float) -> tuple[float, str]:
        """
        Avalia a qualidade dos dados para determinar confiança do forecast.

        Args:
            num_vendas: Número de vendas no período
            dias_historico: Dias de histórico analisados
            coef_variacao: Coeficiente de variação da demanda

        Returns:
            Tupla (confianca_percentual, qualidade_categoria)
        """
        try:
            confianca = 100.0  # Começar com máxima confiança

            # Penalizar falta de histórico
            if dias_historico < 30:
                confianca *= 0.6
            elif dias_historico < 60:
                confianca *= 0.8

            # Penalizar poucas vendas
            if num_vendas < 5:
                confianca *= 0.3
            elif num_vendas < 10:
                confianca *= 0.6
            elif num_vendas < 20:
                confianca *= 0.8

            # Penalizar alta variabilidade
            if coef_variacao > 2.0:
                confianca *= 0.4
            elif coef_variacao > 1.5:
                confianca *= 0.6
            elif coef_variacao > 1.0:
                confianca *= 0.8

            # Determinar categoria de qualidade
            if confianca >= 80:
                qualidade = 'BOA'
            elif confianca >= 60:
                qualidade = 'MEDIA'
            elif confianca >= 30:
                qualidade = 'RUIM'
            else:
                qualidade = 'INSUFICIENTE'

            return confianca, qualidade

        except Exception as e:
            self.logger.error(f"Erro ao avaliar qualidade dos dados: {e}")
            return 0.0, 'INSUFICIENTE'