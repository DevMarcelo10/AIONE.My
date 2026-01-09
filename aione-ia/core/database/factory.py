"""
AIONE IA - Database Factory
Factory para criar instâncias corretas do gerenciador de banco de dados
"""

import logging
from typing import Any, Dict, Optional

from .base import DatabaseManager


logger = logging.getLogger(__name__)


class DatabaseFactory:
    """Factory para criação de gerenciadores de banco de dados."""

    # Mapeamento dos tipos de banco para suas classes
    _DATABASE_TYPES = {
        'mysql': {
            'module': 'core.database.mysql',
            'class': 'MySQLManager',
            'default_port': 3306
        },
        'postgres': {
            'module': 'core.database.postgres',
            'class': 'PostgreSQLManager',
            'default_port': 5432
        },
        'postgresql': {  # Alias para postgres
            'module': 'core.database.postgres',
            'class': 'PostgreSQLManager',
            'default_port': 5432
        },
        'sqlserver': {
            'module': 'core.database.sqlserver',
            'class': 'SQLServerManager',
            'default_port': 1433
        },
        'mssql': {  # Alias para sqlserver
            'module': 'core.database.sqlserver',
            'class': 'SQLServerManager',
            'default_port': 1433
        }
    }

    @staticmethod
    def create(
        db_type: str,
        host: str,
        port: Optional[int] = None,
        database: str = "",
        user: str = "",
        password: str = "",
        **kwargs
    ) -> DatabaseManager:
        """
        Factory para criar instância do banco correto.

        Args:
            db_type: Tipo do banco ('mysql', 'postgres'/'postgresql', 'sqlserver'/'mssql')
            host: Host do banco de dados
            port: Porta do banco (usa padrão do tipo se não especificado)
            database: Nome do banco de dados
            user: Usuário para conexão
            password: Senha para conexão
            **kwargs: Parâmetros específicos do driver

        Returns:
            Instância de DatabaseManager

        Raises:
            ValueError: Se db_type inválido ou parâmetros obrigatórios ausentes
            ImportError: Se driver do banco não estiver instalado
            Exception: Outros erros durante criação da instância

        Examples:
            >>> # MySQL
            >>> db = DatabaseFactory.create(
            ...     db_type='mysql',
            ...     host='localhost',
            ...     database='mydb',
            ...     user='user',
            ...     password='pass'
            ... )

            >>> # PostgreSQL
            >>> db = DatabaseFactory.create(
            ...     db_type='postgres',
            ...     host='localhost',
            ...     database='mydb',
            ...     user='user',
            ...     password='pass'
            ... )

            >>> # SQL Server com Windows Auth
            >>> db = DatabaseFactory.create(
            ...     db_type='sqlserver',
            ...     host='localhost',
            ...     database='mydb',
            ...     trusted_connection=True
            ... )
        """
        # Valida tipo do banco
        db_type_lower = db_type.lower().strip()
        if db_type_lower not in DatabaseFactory._DATABASE_TYPES:
            valid_types = ', '.join(DatabaseFactory._DATABASE_TYPES.keys())
            raise ValueError(
                f"Tipo de banco '{db_type}' não suportado. "
                f"Tipos válidos: {valid_types}"
            )

        # Valida parâmetros obrigatórios
        if not host:
            raise ValueError("Host é obrigatório")

        if not database:
            raise ValueError("Nome do banco de dados é obrigatório")

        # Obtém informações do tipo de banco
        db_info = DatabaseFactory._DATABASE_TYPES[db_type_lower]

        # Define porta padrão se não especificada
        if port is None:
            port = db_info['default_port']

        # Valida autenticação (exceto para SQL Server com Windows Auth)
        is_sqlserver = db_type_lower in ('sqlserver', 'mssql')
        uses_trusted_connection = kwargs.get('trusted_connection', False)

        if not is_sqlserver or not uses_trusted_connection:
            if not user:
                raise ValueError("Usuário é obrigatório (exceto SQL Server com Windows Auth)")

        try:
            # Import dinâmico da classe do banco
            module_path = db_info['module']
            class_name = db_info['class']

            import importlib
            module = importlib.import_module(module_path)
            manager_class = getattr(module, class_name)

            # Cria e retorna instância
            instance = manager_class(
                host=host,
                port=port,
                database=database,
                user=user,
                password=password,
                **kwargs
            )

            logger.info(f"Criada instância {class_name} para {db_type_lower}://{host}:{port}/{database}")
            return instance

        except ImportError as e:
            logger.error(f"Driver para {db_type} não encontrado: {e}")
            raise ImportError(
                f"Driver para {db_type} não está instalado. "
                f"Instale: pip install {DatabaseFactory._get_driver_package(db_type_lower)}"
            ) from e
        except Exception as e:
            logger.error(f"Erro ao criar instância {class_name}: {e}")
            raise

    @staticmethod
    def create_from_config(settings) -> DatabaseManager:
        """
        Cria conexão a partir das configurações do ambiente.

        Args:
            settings: Objeto de configurações com atributos:
                - DB_TYPE: tipo do banco
                - DB_HOST: host do banco
                - DB_PORT: porta do banco (opcional)
                - DB_NAME: nome do banco
                - DB_USER: usuário (opcional para Windows Auth)
                - DB_PASSWORD: senha (opcional para Windows Auth)
                - Outros atributos específicos do banco

        Returns:
            Instância de DatabaseManager

        Raises:
            AttributeError: Se configurações obrigatórias estão ausentes
            ValueError: Se valores de configuração são inválidos

        Examples:
            >>> # Com objeto settings
            >>> class Settings:
            ...     DB_TYPE = 'mysql'
            ...     DB_HOST = 'localhost'
            ...     DB_NAME = 'mydb'
            ...     DB_USER = 'user'
            ...     DB_PASSWORD = 'password'
            >>>
            >>> settings = Settings()
            >>> db = DatabaseFactory.create_from_config(settings)
        """
        try:
            # Obtém configurações obrigatórias
            db_type = getattr(settings, 'DB_TYPE', '').lower()
            host = getattr(settings, 'DB_HOST', '')
            database = getattr(settings, 'DB_NAME', '') or getattr(settings, 'DB_DATABASE', '')

            # Configurações opcionais
            port = getattr(settings, 'DB_PORT', None)
            user = getattr(settings, 'DB_USER', '') or getattr(settings, 'DB_USERNAME', '')
            password = getattr(settings, 'DB_PASSWORD', '') or getattr(settings, 'DB_PASS', '')

            # Valida configurações obrigatórias
            if not db_type:
                raise AttributeError("DB_TYPE é obrigatório nas configurações")
            if not host:
                raise AttributeError("DB_HOST é obrigatório nas configurações")
            if not database:
                raise AttributeError("DB_NAME ou DB_DATABASE é obrigatório nas configurações")

            # Monta kwargs com configurações específicas do banco
            kwargs = {}

            # Configurações específicas do MySQL
            if db_type == 'mysql':
                kwargs['charset'] = getattr(settings, 'DB_CHARSET', 'utf8mb4')

            # Configurações específicas do PostgreSQL
            elif db_type in ('postgres', 'postgresql'):
                kwargs['schema'] = getattr(settings, 'DB_SCHEMA', 'public')

            # Configurações específicas do SQL Server
            elif db_type in ('sqlserver', 'mssql'):
                kwargs['driver'] = getattr(settings, 'DB_DRIVER', 'ODBC+Driver+17+for+SQL+Server')
                kwargs['trusted_connection'] = getattr(settings, 'DB_TRUSTED_CONNECTION', False)

            # Configurações de pool
            kwargs['pool_size'] = getattr(settings, 'DB_POOL_SIZE', 5)
            kwargs['max_overflow'] = getattr(settings, 'DB_MAX_OVERFLOW', 10)
            kwargs['pool_recycle'] = getattr(settings, 'DB_POOL_RECYCLE', 3600)

            # Outros kwargs personalizados
            for attr_name in dir(settings):
                if attr_name.startswith('DB_') and not attr_name.startswith('DB_TYPE') and \
                   not attr_name.startswith('DB_HOST') and not attr_name.startswith('DB_PORT') and \
                   not attr_name.startswith('DB_NAME') and not attr_name.startswith('DB_DATABASE') and \
                   not attr_name.startswith('DB_USER') and not attr_name.startswith('DB_USERNAME') and \
                   not attr_name.startswith('DB_PASSWORD') and not attr_name.startswith('DB_PASS'):

                    # Converte DB_CUSTOM_PARAM para custom_param
                    param_name = attr_name[3:].lower()  # Remove 'DB_'
                    if param_name not in kwargs:
                        kwargs[param_name] = getattr(settings, attr_name)

            logger.info(f"Criando conexão a partir de configurações: {db_type}://{host}/{database}")

            return DatabaseFactory.create(
                db_type=db_type,
                host=host,
                port=port,
                database=database,
                user=user,
                password=password,
                **kwargs
            )

        except AttributeError as e:
            logger.error(f"Configuração ausente: {e}")
            raise
        except Exception as e:
            logger.error(f"Erro ao criar conexão a partir de configurações: {e}")
            raise

    @staticmethod
    def get_supported_types() -> list[str]:
        """
        Retorna lista de tipos de banco suportados.

        Returns:
            Lista com tipos de banco suportados
        """
        return list(DatabaseFactory._DATABASE_TYPES.keys())

    @staticmethod
    def get_type_info(db_type: str) -> Dict[str, Any]:
        """
        Retorna informações sobre um tipo de banco.

        Args:
            db_type: Tipo do banco

        Returns:
            Dicionário com informações do tipo

        Raises:
            ValueError: Se tipo não suportado
        """
        db_type_lower = db_type.lower().strip()
        if db_type_lower not in DatabaseFactory._DATABASE_TYPES:
            valid_types = ', '.join(DatabaseFactory._DATABASE_TYPES.keys())
            raise ValueError(
                f"Tipo de banco '{db_type}' não suportado. "
                f"Tipos válidos: {valid_types}"
            )

        info = DatabaseFactory._DATABASE_TYPES[db_type_lower].copy()
        info['driver_package'] = DatabaseFactory._get_driver_package(db_type_lower)
        return info

    @staticmethod
    def _get_driver_package(db_type: str) -> str:
        """
        Retorna nome do pacote do driver para um tipo de banco.

        Args:
            db_type: Tipo do banco

        Returns:
            Nome do pacote do driver
        """
        driver_packages = {
            'mysql': 'PyMySQL',
            'postgres': 'psycopg2-binary',
            'postgresql': 'psycopg2-binary',
            'sqlserver': 'pyodbc',
            'mssql': 'pyodbc'
        }
        return driver_packages.get(db_type, 'unknown')

    @staticmethod
    def test_driver_availability(db_type: str) -> bool:
        """
        Testa se o driver para um tipo de banco está disponível.

        Args:
            db_type: Tipo do banco

        Returns:
            True se driver disponível, False caso contrário
        """
        try:
            db_type_lower = db_type.lower().strip()
            if db_type_lower not in DatabaseFactory._DATABASE_TYPES:
                return False

            # Tenta importar o módulo do driver
            if db_type_lower == 'mysql':
                import pymysql
            elif db_type_lower in ('postgres', 'postgresql'):
                import psycopg2
            elif db_type_lower in ('sqlserver', 'mssql'):
                import pyodbc

            return True

        except ImportError:
            return False