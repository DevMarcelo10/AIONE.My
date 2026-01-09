"""
AIONE IA - MySQL Database Manager
Implementação específica para MySQL usando pymysql
"""

import logging
from urllib.parse import quote_plus

from sqlalchemy import Engine, create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session, sessionmaker

from .base import DatabaseManager


logger = logging.getLogger(__name__)


class MySQLManager(DatabaseManager):
    """Gerenciador de banco de dados MySQL com pymysql."""

    def __init__(
        self,
        host: str,
        port: int = 3306,
        database: str = "",
        user: str = "",
        password: str = "",
        pool_size: int = 5,
        max_overflow: int = 10,
        pool_recycle: int = 3600,
        charset: str = "utf8mb4",
        **kwargs
    ):
        """
        Inicializa gerenciador MySQL.

        Args:
            host: Host do MySQL
            port: Porta do MySQL (padrão 3306)
            database: Nome do banco de dados
            user: Usuário MySQL
            password: Senha MySQL
            pool_size: Tamanho do pool de conexões
            max_overflow: Conexões extras além do pool
            pool_recycle: Tempo para reciclar conexões (segundos)
            charset: Charset da conexão (padrão utf8mb4)
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
        self.charset = charset

    def _build_connection_string(self) -> str:
        """Constrói string de conexão MySQL."""
        # Escapa caracteres especiais na senha
        escaped_password = quote_plus(self.password) if self.password else ""

        base_url = f"mysql+pymysql://{self.user}:{escaped_password}@{self.host}:{self.port}/{self.database}"

        # Adiciona parâmetros de charset
        params = [f"charset={self.charset}"]

        # Adiciona parâmetros adicionais
        for key, value in self.kwargs.items():
            params.append(f"{key}={value}")

        if params:
            base_url += "?" + "&".join(params)

        return base_url

    def connect(self) -> None:
        """Estabelece conexão com MySQL."""
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
                    future=True
                )

                self._session_factory = sessionmaker(bind=self._engine)

            # Testa a conexão
            with self._engine.connect() as conn:
                conn.execute(text("SELECT 1"))

            self._is_connected = True
            logger.info(f"Conectado ao MySQL: {self.host}:{self.port}/{self.database}")

        except SQLAlchemyError as e:
            self._is_connected = False
            logger.error(f"Erro ao conectar no MySQL: {e}")
            raise
        except Exception as e:
            self._is_connected = False
            logger.error(f"Erro inesperado ao conectar no MySQL: {e}")
            raise

    def disconnect(self) -> None:
        """Fecha conexão com MySQL."""
        try:
            if self._engine:
                self._engine.dispose()
                self._engine = None
                self._session_factory = None

            self._is_connected = False
            logger.info("Conexão MySQL fechada")

        except Exception as e:
            logger.error(f"Erro ao fechar conexão MySQL: {e}")

    def get_engine(self) -> Engine:
        """Retorna engine SQLAlchemy."""
        if not self._engine:
            self.connect()
        return self._engine

    def get_session(self) -> Session:
        """Retorna nova sessão MySQL."""
        if not self._session_factory:
            self.connect()
        return self._session_factory()

    def test_connection(self) -> bool:
        """
        Testa conexão com MySQL.

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
            logger.warning(f"Teste de conexão MySQL falhou: {e}")
            self._is_connected = False
            return False

    def get_tables(self) -> list[str]:
        """
        Retorna lista de tabelas do banco MySQL.

        Returns:
            Lista de nomes das tabelas

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = DATABASE()
              AND table_type = 'BASE TABLE'
            ORDER BY table_name
        """

        try:
            result = self.execute_query(query)
            return [row['table_name'] for row in result]
        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter tabelas MySQL: {e}")
            raise

    def get_columns(self, table: str) -> list[dict]:
        """
        Retorna informações das colunas de uma tabela MySQL.

        Args:
            table: Nome da tabela

        Returns:
            Lista de dicionários com informações das colunas

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        query = """
            SELECT
                column_name,
                data_type,
                is_nullable,
                column_key,
                column_default,
                extra,
                character_maximum_length,
                numeric_precision,
                numeric_scale
            FROM information_schema.columns
            WHERE table_schema = DATABASE()
              AND table_name = :table
            ORDER BY ordinal_position
        """

        try:
            result = self.execute_query(query, {"table": table})

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
                table_rows as row_count,
                data_length as data_size,
                index_length as index_size,
                (data_length + index_length) as total_size
            FROM information_schema.tables
            WHERE table_schema = DATABASE()
              AND table_name = :table
        """

        try:
            result = self.execute_query(query, {"table": table})
            if result:
                return {
                    "row_count": result[0]["row_count"] or 0,
                    "data_size": result[0]["data_size"] or 0,
                    "index_size": result[0]["index_size"] or 0,
                    "total_size": result[0]["total_size"] or 0
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
            WHERE table_schema = DATABASE()
              AND table_name = :table
        """

        try:
            result = self.execute_scalar(query, {"table": table})
            return result > 0
        except SQLAlchemyError as e:
            logger.error(f"Erro ao verificar existência da tabela {table}: {e}")
            raise

    def optimize_table(self, table: str) -> bool:
        """
        Otimiza uma tabela MySQL.

        Args:
            table: Nome da tabela

        Returns:
            True se otimização bem-sucedida

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        try:
            # OPTIMIZE TABLE não pode usar parâmetros, então validamos o nome
            if not table.replace('_', '').replace('-', '').isalnum():
                raise ValueError(f"Nome de tabela inválido: {table}")

            result = self.execute_query(f"OPTIMIZE TABLE `{table}`")
            success = any(row.get('Msg_type') == 'status' for row in result)

            if success:
                logger.info(f"Tabela {table} otimizada com sucesso")
            else:
                logger.warning(f"Otimização da tabela {table} pode ter falhado")

            return success

        except SQLAlchemyError as e:
            logger.error(f"Erro ao otimizar tabela {table}: {e}")
            raise

    def get_server_info(self) -> dict:
        """
        Retorna informações do servidor MySQL.

        Returns:
            Dicionário com informações do servidor

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        queries = {
            "version": "SELECT VERSION() as version",
            "charset": "SELECT @@character_set_server as charset",
            "collation": "SELECT @@collation_server as collation",
            "max_connections": "SELECT @@max_connections as max_connections",
            "uptime": "SELECT VARIABLE_VALUE as uptime FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME='Uptime'"
        }

        try:
            info = {}
            for key, query in queries.items():
                result = self.execute_scalar(query)
                info[key] = result

            return info

        except SQLAlchemyError as e:
            logger.error(f"Erro ao obter informações do servidor MySQL: {e}")
            raise