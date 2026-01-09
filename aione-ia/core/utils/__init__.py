"""
AIONE IA - Utils Module
Utilitários compartilhados para sistema AIONE
"""

# Importa funções do logger
from .logger import (
    get_logger,
    set_log_level,
    get_log_file,
)

# Importa todas as funções dos helpers
from .helpers import (
    # Funções de data/hora
    now_br,
    today_br,
    format_datetime,
    parse_datetime,

    # Funções de texto
    sanitize_string,
    truncate,

    # Funções de validação
    is_valid_cnpj,
    is_valid_cpf,
    format_cnpj,
    format_cpf,

    # Funções de conversão
    safe_float,
    safe_int,
    safe_decimal,

    # Funções de JSON
    json_dumps,
    json_loads,

    # Decorators
    retry,

    # Funções auxiliares extras
    format_currency,
    clean_phone,
    format_phone,
)

# Lista de todas as funções exportadas
__all__ = [
    # Logger
    'get_logger',
    'set_log_level',
    'get_log_file',

    # Data/hora
    'now_br',
    'today_br',
    'format_datetime',
    'parse_datetime',

    # Texto
    'sanitize_string',
    'truncate',

    # Validação
    'is_valid_cnpj',
    'is_valid_cpf',
    'format_cnpj',
    'format_cpf',

    # Conversão
    'safe_float',
    'safe_int',
    'safe_decimal',

    # JSON
    'json_dumps',
    'json_loads',

    # Decorators
    'retry',

    # Auxiliares extras
    'format_currency',
    'clean_phone',
    'format_phone',
]

# Versão do módulo
__version__ = '1.0.0'