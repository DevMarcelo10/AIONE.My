"""
AIONE IA - Processadores de Compras
Sistema de previsão de demanda e classificação de produtos para farmácias
"""

# Forecast
from .forecast import ForecastEngine
from .series_temporais import AnalisadorSeriesTemporal
from .sazonalidade import DetectorSazonalidade
from .ajuste_eventos import AjustadorEventos
from .metricas import CalculadoraMetricas, MetricasProduto, ParametrosForecast, ResultadoForecast
from .repositorio import ForecastRepositorio

# Classificador
from .classificador import (
    ClassificadorProdutos,
    Classificacao,
    CurvaABC,
    ClasseGiro,
    ClasseMargem,
    RiscoVencimento,
    Tendencia,
    ParametrosClassificacao,
    ResultadoClassificacao
)
from .curva_abc import AnalisadorCurvaABC, ResultadoABC
from .analise_giro import AnalisadorGiro, ResultadoGiro
from .analise_margem import AnalisadorMargem, ResultadoMargem
from .analise_vencimento import AnalisadorVencimento, ResultadoVencimento
from .repositorio_class import ClassificacaoRepositorio

# Fornecedor
from .fornecedor import (
    AnalisadorFornecedor,
    AnalisadorPrecoFornecedor,
    AnalisadorEntregaFornecedor,
    AnalisadorQualidadeFornecedor,
    AnalisadorComercialFornecedor,
    FornecedorScoreRepositorio,
    ClassificacaoFornecedor,
    TendenciaFornecedor,
    ParametrosScoreFornecedor,
    MetricasPreco,
    MetricasEntrega,
    MetricasQualidade,
    MetricasComercial,
    ResultadoScoreFornecedor
)

# Necessidade
from .necessidade import (
    GeradorNecessidade,
    Priorizador,
    SugestorFornecedor,
    AgrupadorPedidos,
    NecessidadeRepositorio,
    Prioridade,
    CenarioForecast,
    StatusNecessidade,
    StatusPedido,
    ParametrosNecessidade,
    NecessidadeItem,
    PedidoSugerido
)

# Integração
from .integracao import (
    SmartPed,
    CoteFacilIntegrador,
    GeradorPedido,
    SincronizadorERP,
    IntegracaoRepositorio,
    PedidoCompra,
    ItemPedido,
    StatusPedido as StatusPedidoIA,
    OrigemPedido,
    Cotacao,
    ItemCotacao,
    RespostaCotacao,
    StatusCotacao,
    CriterioSelecao
)

# Aprendizado
from .aprendizado import (
    Comparador,
    CalculadorMetrica,
    Ajustador,
    AnalisadorAprendizado,
    AprendizadoRepositorio
)

__all__ = [
    # Forecast
    'ForecastEngine',
    'AnalisadorSeriesTemporal',
    'DetectorSazonalidade',
    'AjustadorEventos',
    'CalculadoraMetricas',
    'MetricasProduto',
    'ParametrosForecast',
    'ResultadoForecast',
    'ForecastRepositorio',
    # Classificador - Classes principais
    'ClassificadorProdutos',
    'ParametrosClassificacao',
    'ResultadoClassificacao',
    # Classificador - Enums
    'Classificacao',
    'CurvaABC',
    'ClasseGiro',
    'ClasseMargem',
    'RiscoVencimento',
    'Tendencia',
    # Classificador - Analisadores
    'AnalisadorCurvaABC',
    'AnalisadorGiro',
    'AnalisadorMargem',
    'AnalisadorVencimento',
    # Classificador - Resultados
    'ResultadoABC',
    'ResultadoGiro',
    'ResultadoMargem',
    'ResultadoVencimento',
    # Classificador - Repositório
    'ClassificacaoRepositorio',
    # Fornecedor - Classes principais
    'AnalisadorFornecedor',
    'FornecedorScoreRepositorio',
    # Fornecedor - Analisadores
    'AnalisadorPrecoFornecedor',
    'AnalisadorEntregaFornecedor',
    'AnalisadorQualidadeFornecedor',
    'AnalisadorComercialFornecedor',
    # Fornecedor - Enums e parâmetros
    'ClassificacaoFornecedor',
    'TendenciaFornecedor',
    'ParametrosScoreFornecedor',
    # Fornecedor - Métricas
    'MetricasPreco',
    'MetricasEntrega',
    'MetricasQualidade',
    'MetricasComercial',
    'ResultadoScoreFornecedor',
    # Necessidade - Classes principais
    'GeradorNecessidade',
    'Priorizador',
    'SugestorFornecedor',
    'AgrupadorPedidos',
    'NecessidadeRepositorio',
    # Necessidade - Enums
    'Prioridade',
    'CenarioForecast',
    'StatusNecessidade',
    'StatusPedido',
    # Necessidade - Dataclasses
    'ParametrosNecessidade',
    'NecessidadeItem',
    'PedidoSugerido',
    # Integração - Classes principais
    'SmartPed',
    'CoteFacilIntegrador',
    'GeradorPedido',
    'SincronizadorERP',
    'IntegracaoRepositorio',
    # Integração - Dataclasses
    'PedidoCompra',
    'ItemPedido',
    'Cotacao',
    'ItemCotacao',
    'RespostaCotacao',
    # Integração - Enums
    'StatusPedidoIA',
    'OrigemPedido',
    'StatusCotacao',
    'CriterioSelecao',
    # Aprendizado
    'Comparador',
    'CalculadorMetrica',
    'Ajustador',
    'AnalisadorAprendizado',
    'AprendizadoRepositorio'
]
