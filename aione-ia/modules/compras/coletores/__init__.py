"""
AIONE IA - Coletores de Dados Externos
Módulos para coleta de dados de fontes externas
"""

from .base import ColetorBase
from .clima import ColetorClima
from .eventos import ColetorEventos
from .saude import ColetorSaude
from .trends import ColetorTrends

__all__ = [
    "ColetorBase",
    "ColetorClima",
    "ColetorEventos",
    "ColetorSaude",
    "ColetorTrends"
]