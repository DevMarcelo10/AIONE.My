"""
AIONE IA - Módulo de Análise de Fornecedores
Avaliação e score de fornecedores baseado em múltiplos critérios
"""

from .analisador import (
    AnalisadorFornecedor,
    ClassificacaoFornecedor,
    TendenciaFornecedor,
    ParametrosScoreFornecedor,
    MetricasPreco,
    MetricasEntrega,
    MetricasQualidade,
    MetricasComercial,
    ResultadoScoreFornecedor
)
from .analise_preco import AnalisadorPrecoFornecedor
from .analise_entrega import AnalisadorEntregaFornecedor
from .analise_qualidade import AnalisadorQualidadeFornecedor
from .analise_comercial import AnalisadorComercialFornecedor
from .repositorio import FornecedorScoreRepositorio

__all__ = [
    # Classes principais
    'AnalisadorFornecedor',
    'FornecedorScoreRepositorio',

    # Analisadores específicos
    'AnalisadorPrecoFornecedor',
    'AnalisadorEntregaFornecedor',
    'AnalisadorQualidadeFornecedor',
    'AnalisadorComercialFornecedor',

    # Enums e tipos
    'ClassificacaoFornecedor',
    'TendenciaFornecedor',
    'ParametrosScoreFornecedor',

    # Dataclasses de métricas
    'MetricasPreco',
    'MetricasEntrega',
    'MetricasQualidade',
    'MetricasComercial',
    'ResultadoScoreFornecedor'
]
