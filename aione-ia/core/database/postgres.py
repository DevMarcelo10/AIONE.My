"""
AIONE IA - PostgreSQL Database Manager
Implementação específica para PostgreSQL usando psycopg2
"""

import logging
from urllib.parse import quote_plus

from sqlalchemy import Engine, create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session, sessionmaker

from .base import DatabaseManager


logger = logging.getLogger(__name__)


class PostgreSQLManager(DatabaseManager):
    """Gerenciador de banco de dados PostgreSQL com psycopg2."""

    def __init__(
        self,
        host: str,
        port: int = 5432,
        database: str = "",
        user: str = "",
        password: str = "",
        pool_size: int = 5,
        max_overflow: int = 10,
        pool_recycle: int = 3600,
        schema: str = "public",
        **kwargs
    ):
        """
        Inicializa gerenciador PostgreSQL.

        Args:
            host: Host do PostgreSQL
            port: Porta do PostgreSQL (padrão 5432)
            database: Nome do banco de dados
            user: Usuário PostgreSQL
            password: Senha PostgreSQL
            pool_size: Tamanho do pool de conexões
            max_overflow: Conexões extras além do pool
            pool_recycle: Tempo para reciclar conexões (segundos)
            schema: Schema padrão (padrão public)
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
        self.schema = schema

    def _build_connection_string(self) -> str:
        """Constrói string de conexão PostgreSQL."""
        # Escapa caracteres especiais na senha
        escaped_password = quote_plus(self.password) if self.password else ""

        base_url = f"postgresql+psycopg2://{self.user}:{escaped_password}@{self.host}:{self.port}/{self.database}"

        # Adiciona parâmetros adicionais
        params = []
        for key, value in self.kwargs.items():
            params.append(f"{key}={value}")

        if params:
            base_url += "?" + "&".join(params)

        return base_url

    def connect(self) -> None:
        """Estabelece conexão com PostgreSQL."""
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
                    # PostgreSQL specific settings
                    connect_args={
                        "options": f"-csearch_path={self.schema}"
                    }
                )

                self._session_factory = sessionmaker(bind=self._engine)

            # Testa a conexão
            with self._engine.connect() as conn:
                conn.execute(text("SELECT 1"))

            self._is_connected = True
            logger.info(f"Conectado ao PostgreSQL: {self.host}:{self.port}/{self.database}")

        except SQLAlchemyError as e:
            self._is_connected = False
            logger.error(f"Erro ao conectar no PostgreSQL: {e}")
            raise
        except Exception as e:
            self._is_connected = False
            logger.error(f"Erro inesperado ao conectar no PostgreSQL: {e}")
            raise

    def disconnect(self) -> None:
        """Fecha conexão com PostgreSQL."""
        try:
            if self._engine:
                self._engine.dispose()
                self._engine = None
                self._session_factory = None

            self._is_connected = False
            logger.info("Conexão PostgreSQL fechada")

        except Exception as e:
            logger.error(f"Erro ao fechar conexão PostgreSQL: {e}")

    def get_engine(self) -> Engine:
        """Retorna engine SQLAlchemy."""
        if not self._engine:
            self.connect()
        return self._engine

    def get_session(self) -> Session:
        """Retorna nova sessão PostgreSQL."""
        if not self._session_factory:
            self.connect()
        return self._session_factory()

    def test_connection(self) -> bool:
        """
        Testa conexão com PostgreSQL.

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
            logger.warning(f"Teste de conexão PostgreSQL falhou: {e}")
            self._is_connected = False
            return False

    def get_tables(self) -> list[str]:
        """
        Retorna lista de tabelas do banco PostgreSQL.

        Returns:
            Lista de nomes das tabelas

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = :schema
              AND table_type = 'BASE TABLE'
            ORDER BY table_name
        """

        try:
            result = self.execute_query(query, {"schema": self.schema})
            return [row['table_name'] for row in result]
        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter tabelas PostgreSQL: {e}")
            raise

    def get_columns(self, table: str) -> list[dict]:
        """
        Retorna informações das colunas de uma tabela PostgreSQL.

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
                CASE WHEN c.column_default LIKE 'nextval%%' THEN 'auto_increment' ELSE '' END as extra,
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
                  AND tc.table_schema = :schema
                  AND tc.table_name = :table
            ) pk ON c.column_name = pk.column_name
            WHERE c.table_schema = :schema
              AND c.table_name = :table
            ORDER BY c.ordinal_position
        """

        try:
            result = self.execute_query(query, {"schema": self.schema, "table": table})

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
        # PostgreSQL usa queries diferentes para obter tamanhos
        queries = {
            "row_count": f"""
                SELECT reltuples::bigint as row_count
                FROM pg_class
                WHERE relname = :table
            """,
            "table_size": f"""
                SELECT pg_total_relation_size(:table_oid) as total_size,
                       pg_relation_size(:table_oid) as data_size,
                       pg_total_relation_size(:table_oid) - pg_relation_size(:table_oid) as index_size
            """,
            "table_oid": f"""
                SELECT oid
                FROM pg_class
                WHERE relname = :table
            """
        }

        try:
            # Primeiro obtém o OID da tabela
            oid_result = self.execute_scalar(queries["table_oid"], {"table": table})
            if not oid_result:
                return {"row_count": 0, "data_size": 0, "index_size": 0, "total_size": 0}

            # Obtém contagem de linhas
            row_count = self.execute_scalar(queries["row_count"], {"table": table}) or 0

            # Obtém tamanhos
            size_result = self.execute_query(queries["table_size"], {"table_oid": oid_result})
            if size_result:
                size_info = size_result[0]
                return {
                    "row_count": int(row_count),
                    "data_size": int(size_info["data_size"] or 0),
                    "index_size": int(size_info["index_size"] or 0),
                    "total_size": int(size_info["total_size"] or 0)
                }

            return {"row_count": int(row_count), "data_size": 0, "index_size": 0, "total_size": 0}

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
            WHERE table_schema = :schema
              AND table_name = :table
        """

        try:
            result = self.execute_scalar(query, {"schema": self.schema, "table": table})
            return result > 0
        except SQLAlchemyError as e:
            logger.error(f"Erro ao verificar existência da tabela {table}: {e}")
            raise

    def vacuum_table(self, table: str, full: bool = False) -> bool:
        """
        Executa VACUUM em uma tabela PostgreSQL.

        Args:
            table: Nome da tabela
            full: Se True, executa VACUUM FULL (mais lento mas mais eficiente)

        Returns:
            True se VACUUM bem-sucedido

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        try:
            # VACUUM não pode usar parâmetros e deve ser executado fora de transação
            if not table.replace('_', '').replace('-', '').isalnum():
                raise ValueError(f"Nome de tabela inválido: {table}")

            vacuum_type = "VACUUM FULL" if full else "VACUUM"

            # Executa usando connection diretamente para evitar transação
            with self.get_engine().connect() as conn:
                # Necessário para comandos VACUUM
                conn.execute(text("COMMIT"))
                conn.execute(text(f'{vacuum_type} "{table}"'))

            logger.info(f"VACUUM {'FULL ' if full else ''}executado na tabela {table}")
            return True

        except SQLAlchemyError as e:
            logger.error(f"Erro ao executar VACUUM na tabela {table}: {e}")
            raise

    def analyze_table(self, table: str) -> bool:
        """
        Executa ANALYZE em uma tabela PostgreSQL para atualizar estatísticas.

        Args:
            table: Nome da tabela

        Returns:
            True se ANALYZE bem-sucedido

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        try:
            # Valida nome da tabela
            if not table.replace('_', '').replace('-', '').isalnum():
                raise ValueError(f"Nome de tabela inválido: {table}")

            self.execute_query(f'ANALYZE "{table}"')
            logger.info(f"ANALYZE executado na tabela {table}")
            return True

        except SQLAlchemyError as e:
            logger.error(f"Erro ao executar ANALYZE na tabela {table}: {e}")
            raise

    def get_schemas(self) -> list[str]:
        """
        Retorna lista de schemas do banco PostgreSQL.

        Returns:
            Lista de nomes dos schemas

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT schema_name
            FROM information_schema.schemata
            WHERE schema_name NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
            ORDER BY schema_name
        """

        try:
            result = self.execute_query(query)
            return [row['schema_name'] for row in result]
        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter schemas PostgreSQL: {e}")
            raise

    def get_server_info(self) -> dict:
        """
        Retorna informações do servidor PostgreSQL.

        Returns:
            Dicionário com informações do servidor

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        queries = {
            "version": "SELECT version() as version",
            "uptime": "SELECT EXTRACT(EPOCH FROM now() - pg_postmaster_start_time()) as uptime",
            "max_connections": "SELECT setting::int as max_connections FROM pg_settings WHERE name='max_connections'",
            "current_database": "SELECT current_database() as current_database",
            "current_schema": "SELECT current_schema() as current_schema"
        }

        try:
            info = {}
            for key, query in queries.items():
                result = self.execute_scalar(query)
                info[key] = result

            return info

        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter informações do servidor PostgreSQL: {e}")
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
                i.relname as index_name,
                a.attname as column_name,
                ix.indisunique as is_unique,
                ix.indisprimary as is_primary,
                am.amname as index_type
            FROM pg_index ix
            JOIN pg_class i ON i.oid = ix.indexrelid
            JOIN pg_class t ON t.oid = ix.indrelid
            JOIN pg_attribute a ON a.attrelid = t.oid AND a.attnum = ANY(ix.indkey)
            JOIN pg_am am ON i.relam = am.oid
            WHERE t.relname = :table
            ORDER BY i.relname, a.attname
        """

        try:
            result = self.execute_query(query, {"table": table})

            indexes = []
            for row in result:
                index_info = {
                    "name": row["index_name"],
                    "column": row["column_name"],
                    "unique": row["is_unique"],
                    "primary": row["is_primary"],
                    "type": row["index_type"]
                }
                indexes.append(index_info)

            return indexes

        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter índices da tabela {table}: {e}")
            raise