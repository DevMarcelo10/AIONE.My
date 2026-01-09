"""
AIONE IA - Processadores de Necessidade de Compra
Sistema de geração e priorização de necessidades de compra para farmácias
"""

from .gerador import (
    GeradorNecessidade,
    Prioridade,
    CenarioForecast,
    StatusNecessidade,
    StatusPedido,
    ParametrosNecessidade,
    NecessidadeItem,
    PedidoSugerido
)
from .priorizador import Priorizador
from .sugestor_forn import SugestorFornecedor
from .agrupador import AgrupadorPedidos
from .repositorio import NecessidadeRepositorio

__all__ = [
    # Motor principal
    'GeradorNecessidade',
    # Componentes
    'Priorizador',
    'SugestorFornecedor',
    'AgrupadorPedidos',
    'NecessidadeRepositorio',
    # Enums
    'Prioridade',
    'CenarioForecast',
    'StatusNecessidade',
    'StatusPedido',
    # Dataclasses
    'ParametrosNecessidade',
    'NecessidadeItem',
    'PedidoSugerido'
]
