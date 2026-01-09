"""
AIONE IA - Core
Módulo núcleo com componentes compartilhados
"""

from core.database.factory import DatabaseFactory
from core.utils.logger import get_logger

__all__ = ["DatabaseFactory", "get_logger"]
