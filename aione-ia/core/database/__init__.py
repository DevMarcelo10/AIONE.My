"""
AIONE IA - Database Module
Suporte a múltiplos bancos de dados: MySQL, PostgreSQL, SQL Server
"""

from .base import DatabaseManager
from .factory import DatabaseFactory
from .mysql import MySQLManager
from .postgres import PostgreSQLManager
from .sqlserver import SQLServerManager

__all__ = [
    'DatabaseManager',
    'DatabaseFactory',
    'MySQLManager',
    'PostgreSQLManager',
    'SQLServerManager'
]

# Versão do módulo
__version__ = '1.0.0'

# Função de conveniência para criar conexões
def create_database_manager(db_type: str, **kwargs) -> DatabaseManager:
    """
    Função de conveniência para criar instâncias de gerenciadores de banco.

    Args:
        db_type: Tipo do banco de dados
        **kwargs: Argumentos para o construtor

    Returns:
        Instância de DatabaseManager

    Examples:
        >>> # MySQL
        >>> db = create_database_manager(
        ...     'mysql',
        ...     host='localhost',
        ...     database='mydb',
        ...     user='user',
        ...     password='pass'
        ... )

        >>> # PostgreSQL
        >>> db = create_database_manager(
        ...     'postgres',
        ...     host='localhost',
        ...     database='mydb',
        ...     user='user',
        ...     password='pass'
        ... )

        >>> # SQL Server
        >>> db = create_database_manager(
        ...     'sqlserver',
        ...     host='localhost',
        ...     database='mydb',
        ...     user='user',
        ...     password='pass'
        ... )
    """
    return DatabaseFactory.create(db_type, **kwargs)

def create_from_config(settings) -> DatabaseManager:
    """
    Função de conveniência para criar conexão a partir de configurações.

    Args:
        settings: Objeto com configurações de banco

    Returns:
        Instância de DatabaseManager

    Examples:
        >>> class Settings:
        ...     DB_TYPE = 'mysql'
        ...     DB_HOST = 'localhost'
        ...     DB_NAME = 'mydb'
        ...     DB_USER = 'user'
        ...     DB_PASSWORD = 'password'
        ...
        >>> settings = Settings()
        >>> db = create_from_config(settings)
    """
    return DatabaseFactory.create_from_config(settings)

def get_supported_databases() -> list[str]:
    """
    Retorna lista de tipos de banco suportados.

    Returns:
        Lista com tipos de banco suportados
    """
    return DatabaseFactory.get_supported_types()

def test_driver(db_type: str) -> bool:
    """
    Testa se o driver para um tipo de banco está disponível.

    Args:
        db_type: Tipo do banco

    Returns:
        True se driver disponível, False caso contrário
    """
    return DatabaseFactory.test_driver_availability(db_type)