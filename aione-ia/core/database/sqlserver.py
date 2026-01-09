"""
AIONE IA - SQL Server Database Manager
Implementação específica para SQL Server usando pyodbc
"""

import logging
from urllib.parse import quote_plus

from sqlalchemy import Engine, create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session, sessionmaker

from .base import DatabaseManager


logger = logging.getLogger(__name__)


class SQLServerManager(DatabaseManager):
    """Gerenciador de banco de dados SQL Server com pyodbc."""

    def __init__(
        self,
        host: str,
        port: int = 1433,
        database: str = "",
        user: str = "",
        password: str = "",
        pool_size: int = 5,
        max_overflow: int = 10,
        pool_recycle: int = 3600,
        driver: str = "ODBC+Driver+17+for+SQL+Server",
        trusted_connection: bool = False,
        **kwargs
    ):
        """
        Inicializa gerenciador SQL Server.

        Args:
            host: Host do SQL Server
            port: Porta do SQL Server (padrão 1433)
            database: Nome do banco de dados
            user: Usuário SQL Server (ignorado se trusted_connection=True)
            password: Senha SQL Server (ignorado se trusted_connection=True)
            pool_size: Tamanho do pool de conexões
            max_overflow: Conexões extras além do pool
            pool_recycle: Tempo para reciclar conexões (segundos)
            driver: Driver ODBC (padrão ODBC Driver 17 for SQL Server)
            trusted_connection: Se True, usa Windows Authentication
            **kwargs: Parâmetros adicionais
        """
        super().__init__(
            host=host,
            port=port,
            database=database,
            user=user,
            password=password,
            pool_size=pool_size,
            max_overflow=max_overflow,
            pool_recycle=pool_recycle,
            **kwargs
        )
        self.driver = driver
        self.trusted_connection = trusted_connection

    def _build_connection_string(self) -> str:
        """Constrói string de conexão SQL Server."""
        if self.trusted_connection:
            # Windows Authentication
            base_url = f"mssql+pyodbc://@{self.host}:{self.port}/{self.database}"
            params = [f"driver={self.driver}", "trusted_connection=yes"]
        else:
            # SQL Server Authentication
            escaped_password = quote_plus(self.password) if self.password else ""
            base_url = f"mssql+pyodbc://{self.user}:{escaped_password}@{self.host}:{self.port}/{self.database}"
            params = [f"driver={self.driver}"]

        # Adiciona parâmetros adicionais
        for key, value in self.kwargs.items():
            params.append(f"{key}={value}")

        if params:
            base_url += "?" + "&".join(params)

        return base_url

    def connect(self) -> None:
        """Estabelece conexão com SQL Server."""
        try:
            if self._engine is None:
                connection_string = self._build_connection_string()

                self._engine = create_engine(
                    connection_string,
                    pool_size=self.pool_size,
                    max_overflow=self.max_overflow,
                    pool_recycle=self.pool_recycle,
                    pool_pre_ping=True,  # Verifica conexão antes de usar
                    echo=False,  # Não loga SQL por padrão
                    future=True,
                    # SQL Server specific settings
                    connect_args={
                        "check_same_thread": False,  # Para uso em threads
                        "timeout": 20  # Timeout de conexão
                    }
                )

                self._session_factory = sessionmaker(bind=self._engine)

            # Testa a conexão
            with self._engine.connect() as conn:
                conn.execute(text("SELECT 1"))

            self._is_connected = True
            auth_type = "Windows" if self.trusted_connection else "SQL Server"
            logger.info(f"Conectado ao SQL Server ({auth_type}): {self.host}:{self.port}/{self.database}")

        except SQLAlchemyError as e:
            self._is_connected = False
            logger.error(f"Erro ao conectar no SQL Server: {e}")
            raise
        except Exception as e:
            self._is_connected = False
            logger.error(f"Erro inesperado ao conectar no SQL Server: {e}")
            raise

    def disconnect(self) -> None:
        """Fecha conexão com SQL Server."""
        try:
            if self._engine:
                self._engine.dispose()
                self._engine = None
                self._session_factory = None

            self._is_connected = False
            logger.info("Conexão SQL Server fechada")

        except Exception as e:
            logger.error(f"Erro ao fechar conexão SQL Server: {e}")

    def get_engine(self) -> Engine:
        """Retorna engine SQLAlchemy."""
        if not self._engine:
            self.connect()
        return self._engine

    def get_session(self) -> Session:
        """Retorna nova sessão SQL Server."""
        if not self._session_factory:
            self.connect()
        return self._session_factory()

    def test_connection(self) -> bool:
        """
        Testa conexão com SQL Server.

        Returns:
            True se conexão bem-sucedida, False caso contrário
        """
        try:
            if not self._is_connected:
                self.connect()

            with self.get_session() as session:
                session.execute(text("SELECT 1"))
                return True

        except Exception as e:
            logger.warning(f"Teste de conexão SQL Server falhou: {e}")
            self._is_connected = False
            return False

    def get_tables(self) -> list[str]:
        """
        Retorna lista de tabelas do banco SQL Server.

        Returns:
            Lista de nomes das tabelas

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT table_name
            FROM information_schema.tables
            WHERE table_type = 'BASE TABLE'
              AND table_catalog = DB_NAME()
            ORDER BY table_name
        """

        try:
            result = self.execute_query(query)
            return [row['table_name'] for row in result]
        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter tabelas SQL Server: {e}")
            raise

    def get_columns(self, table: str) -> list[dict]:
        """
        Retorna informações das colunas de uma tabela SQL Server.

        Args:
            table: Nome da tabela

        Returns:
            Lista de dicionários com informações das colunas

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT
                c.column_name,
                c.data_type,
                c.is_nullable,
                CASE WHEN pk.column_name IS NOT NULL THEN 'PRI' ELSE '' END as column_key,
                c.column_default,
                CASE WHEN COLUMNPROPERTY(OBJECT_ID(:schema_table), c.column_name, 'IsIdentity') = 1
                     THEN 'auto_increment' ELSE '' END as extra,
                c.character_maximum_length,
                c.numeric_precision,
                c.numeric_scale
            FROM information_schema.columns c
            LEFT JOIN (
                SELECT ku.column_name
                FROM information_schema.table_constraints tc
                JOIN information_schema.key_column_usage ku
                    ON tc.constraint_name = ku.constraint_name
                WHERE tc.constraint_type = 'PRIMARY KEY'
                  AND tc.table_name = :table
            ) pk ON c.column_name = pk.column_name
            WHERE c.table_name = :table
              AND c.table_catalog = DB_NAME()
            ORDER BY c.ordinal_position
        """

        try:
            # SQL Server precisa do nome completo para COLUMNPROPERTY
            schema_table = f"dbo.{table}"
            result = self.execute_query(query, {"table": table, "schema_table": schema_table})

            columns = []
            for row in result:
                column_info = {
                    "name": row["column_name"],
                    "type": row["data_type"],
                    "nullable": row["is_nullable"] == "YES",
                    "primary_key": row["column_key"] == "PRI",
                    "auto_increment": "auto_increment" in (row["extra"] or ""),
                    "default": row["column_default"],
                    "max_length": row["character_maximum_length"],
                    "precision": row["numeric_precision"],
                    "scale": row["numeric_scale"]
                }
                columns.append(column_info)

            return columns

        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter colunas da tabela {table}: {e}")
            raise

    def get_table_size(self, table: str) -> dict:
        """
        Retorna informações sobre o tamanho da tabela.

        Args:
            table: Nome da tabela

        Returns:
            Dicionário com informações de tamanho

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT
                SUM(p.rows) as row_count,
                SUM(a.total_pages) * 8 * 1024 as total_size,
                SUM(a.used_pages) * 8 * 1024 as data_size,
                (SUM(a.total_pages) - SUM(a.used_pages)) * 8 * 1024 as index_size
            FROM sys.tables t
            INNER JOIN sys.partitions p ON t.object_id = p.object_id
            INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
            WHERE t.name = :table
              AND p.index_id <= 1
        """

        try:
            result = self.execute_query(query, {"table": table})
            if result:
                size_info = result[0]
                return {
                    "row_count": int(size_info["row_count"] or 0),
                    "data_size": int(size_info["data_size"] or 0),
                    "index_size": int(size_info["index_size"] or 0),
                    "total_size": int(size_info["total_size"] or 0)
                }

            return {"row_count": 0, "data_size": 0, "index_size": 0, "total_size": 0}

        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter tamanho da tabela {table}: {e}")
            raise

    def table_exists(self, table: str) -> bool:
        """
        Verifica se tabela existe no banco.

        Args:
            table: Nome da tabela

        Returns:
            True se tabela existe, False caso contrário

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT COUNT(*) as count
            FROM information_schema.tables
            WHERE table_name = :table
              AND table_catalog = DB_NAME()
        """

        try:
            result = self.execute_scalar(query, {"table": table})
            return result > 0
        except SQLAlchemyError as e:
            logger.error(f"Erro ao verificar existência da tabela {table}: {e}")
            raise

    def rebuild_index(self, table: str, index_name: str = None) -> bool:
        """
        Reconstrói índices de uma tabela SQL Server.

        Args:
            table: Nome da tabela
            index_name: Nome do índice específico (se None, reconstrói todos)

        Returns:
            True se reconstrução bem-sucedida

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        try:
            # Valida nome da tabela
            if not table.replace('_', '').replace('-', '').isalnum():
                raise ValueError(f"Nome de tabela inválido: {table}")

            if index_name:
                # Valida nome do índice
                if not index_name.replace('_', '').replace('-', '').isalnum():
                    raise ValueError(f"Nome de índice inválido: {index_name}")
                sql = f"ALTER INDEX [{index_name}] ON [{table}] REBUILD"
            else:
                sql = f"ALTER INDEX ALL ON [{table}] REBUILD"

            self.execute_query(sql)

            index_info = f"índice {index_name}" if index_name else "todos os índices"
            logger.info(f"Reconstrução de {index_info} da tabela {table} concluída")
            return True

        except SQLAlchemyError as e:
            logger.error(f"Erro ao reconstruir índices da tabela {table}: {e}")
            raise

    def update_statistics(self, table: str) -> bool:
        """
        Atualiza estatísticas de uma tabela SQL Server.

        Args:
            table: Nome da tabela

        Returns:
            True se atualização bem-sucedida

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        try:
            # Valida nome da tabela
            if not table.replace('_', '').replace('-', '').isalnum():
                raise ValueError(f"Nome de tabela inválido: {table}")

            self.execute_query(f"UPDATE STATISTICS [{table}]")
            logger.info(f"Estatísticas da tabela {table} atualizadas")
            return True

        except SQLAlchemyError as e:
            logger.error(f"Erro ao atualizar estatísticas da tabela {table}: {e}")
            raise

    def get_schemas(self) -> list[str]:
        """
        Retorna lista de schemas do banco SQL Server.

        Returns:
            Lista de nomes dos schemas

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT name as schema_name
            FROM sys.schemas
            WHERE name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys', 'db_owner', 'db_accessadmin',
                              'db_securityadmin', 'db_ddladmin', 'db_backupoperator', 'db_datareader',
                              'db_datawriter', 'db_denydatareader', 'db_denydatawriter')
            ORDER BY name
        """

        try:
            result = self.execute_query(query)
            return [row['schema_name'] for row in result]
        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter schemas SQL Server: {e}")
            raise

    def get_server_info(self) -> dict:
        """
        Retorna informações do servidor SQL Server.

        Returns:
            Dicionário com informações do servidor

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        queries = {
            "version": "SELECT @@VERSION as version",
            "servername": "SELECT @@SERVERNAME as servername",
            "max_connections": "SELECT @@MAX_CONNECTIONS as max_connections",
            "language": "SELECT @@LANGUAGE as language",
            "spid": "SELECT @@SPID as spid",
            "database_name": "SELECT DB_NAME() as database_name"
        }

        try:
            info = {}
            for key, query in queries.items():
                result = self.execute_scalar(query)
                info[key] = result

            return info

        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter informações do servidor SQL Server: {e}")
            raise

    def get_indexes(self, table: str) -> list[dict]:
        """
        Retorna informações dos índices de uma tabela.

        Args:
            table: Nome da tabela

        Returns:
            Lista de dicionários com informações dos índices

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT
                i.name as index_name,
                c.name as column_name,
                i.is_unique,
                i.is_primary_key,
                i.type_desc as index_type,
                ic.is_descending_key
            FROM sys.indexes i
            INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
            INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
            INNER JOIN sys.tables t ON i.object_id = t.object_id
            WHERE t.name = :table
            ORDER BY i.name, ic.index_column_id
        """

        try:
            result = self.execute_query(query, {"table": table})

            indexes = []
            for row in result:
                index_info = {
                    "name": row["index_name"],
                    "column": row["column_name"],
                    "unique": row["is_unique"],
                    "primary": row["is_primary_key"],
                    "type": row["index_type"],
                    "descending": row["is_descending_key"]
                }
                indexes.append(index_info)

            return indexes

        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter índices da tabela {table}: {e}")
            raise

    def shrink_database(self) -> bool:
        """
        Reduz o tamanho do banco de dados SQL Server.

        Returns:
            True se operação bem-sucedida

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        try:
            self.execute_query("DBCC SHRINKDATABASE(0)")
            logger.info(f"Banco de dados {self.database} reduzido com sucesso")
            return True

        except SQLAlchemyError as e:
            logger.error(f"Erro ao reduzir banco de dados {self.database}: {e}")
            raise

    def check_database_integrity(self) -> list[dict]:
        """
        Verifica integridade do banco de dados.

        Returns:
            Lista com resultados da verificação

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        try:
            # DBCC CHECKDB retorna múltiplas linhas com informações
            result = self.execute_query("DBCC CHECKDB WITH NO_INFOMSGS")
            logger.info(f"Verificação de integridade do banco {self.database} concluída")
            return result

        except SQLAlchemyError as e:
            logger.error(f"Erro na verificação de integridade do banco {self.database}: {e}")
            raise