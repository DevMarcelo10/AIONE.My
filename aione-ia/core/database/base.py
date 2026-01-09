"""
AIONE IA - Database Base
Classe abstrata para gerenciamento de banco de dados
"""

import logging
import time
from abc import ABC, abstractmethod
from contextlib import contextmanager
from typing import Any, Generator, Optional

from sqlalchemy import Engine, create_engine, text
from sqlalchemy.exc import SQLAlchemyError, OperationalError, DisconnectionError
from sqlalchemy.orm import Session, sessionmaker


logger = logging.getLogger(__name__)


class DatabaseManager(ABC):
    """Classe abstrata base para gerenciadores de banco de dados"""

    def __init__(
        self,
        host: str,
        port: int,
        database: str,
        user: str,
        password: str,
        pool_size: int = 5,
        max_overflow: int = 10,
        pool_recycle: int = 3600,
        **kwargs
    ):
        """
        Inicializa o gerenciador de banco de dados.

        Args:
            host: Host do banco de dados
            port: Porta do banco de dados
            database: Nome do banco de dados
            user: Usuário para conexão
            password: Senha para conexão
            pool_size: Tamanho do pool de conexões
            max_overflow: Número máximo de conexões além do pool
            pool_recycle: Tempo em segundos para reciclar conexões
            **kwargs: Parâmetros específicos do driver
        """
        self.host = host
        self.port = port
        self.database = database
        self.user = user
        self.password = password
        self.pool_size = pool_size
        self.max_overflow = max_overflow
        self.pool_recycle = pool_recycle
        self.kwargs = kwargs

        self._engine: Optional[Engine] = None
        self._session_factory: Optional[sessionmaker] = None
        self._is_connected = False
        self._transaction_session: Optional[Session] = None

    @abstractmethod
    def _build_connection_string(self) -> str:
        """Constrói string de conexão específica do banco."""
        pass

    @abstractmethod
    def connect(self) -> None:
        """Estabelece conexão com o banco de dados."""
        pass

    @abstractmethod
    def disconnect(self) -> None:
        """Fecha conexão com o banco de dados."""
        pass

    @abstractmethod
    def get_engine(self) -> Engine:
        """Retorna a engine SQLAlchemy."""
        pass

    @abstractmethod
    def get_session(self) -> Session:
        """Retorna nova sessão do banco de dados."""
        pass

    @abstractmethod
    def test_connection(self) -> bool:
        """Testa conexão com o banco de dados."""
        pass

    @property
    def is_connected(self) -> bool:
        """Indica se está conectado ao banco."""
        return self._is_connected

    @property
    def connection_string(self) -> str:
        """String de conexão com senha oculta."""
        conn_str = self._build_connection_string()
        # Oculta a senha na string
        if self.password and self.password in conn_str:
            conn_str = conn_str.replace(self.password, "***")
        return conn_str

    @contextmanager
    def session_scope(self) -> Generator[Session, None, None]:
        """
        Context manager para sessões com commit/rollback automático.

        Yields:
            Session: Sessão do SQLAlchemy

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        session = self.get_session()
        try:
            yield session
            session.commit()
            logger.debug("Transação commitada com sucesso")
        except Exception as e:
            session.rollback()
            logger.error(f"Erro na transação, rollback executado: {e}")
            raise
        finally:
            session.close()

    def _retry_operation(self, operation, max_retries: int = 3, delay: float = 1.0):
        """
        Executa operação com retry automático.

        Args:
            operation: Função a ser executada
            max_retries: Número máximo de tentativas
            delay: Delay entre tentativas em segundos

        Returns:
            Resultado da operação

        Raises:
            Exception: Última exceção após todas as tentativas
        """
        last_exception = None

        for attempt in range(max_retries + 1):
            try:
                return operation()
            except (OperationalError, DisconnectionError) as e:
                last_exception = e
                if attempt < max_retries:
                    logger.warning(f"Tentativa {attempt + 1} falhou: {e}. Tentando novamente em {delay}s...")
                    time.sleep(delay)
                    # Reconecta na próxima tentativa
                    self._is_connected = False
                else:
                    logger.error(f"Todas as {max_retries + 1} tentativas falharam")

        raise last_exception

    def execute_query(self, sql: str, params: Optional[dict] = None) -> list[dict]:
        """
        Executa query SELECT e retorna resultados.

        Args:
            sql: Query SQL a ser executada
            params: Parâmetros para a query

        Returns:
            Lista de dicionários com os resultados

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        def _execute():
            if not self.is_connected:
                self.connect()

            with self.session_scope() as session:
                result = session.execute(text(sql), params or {})
                columns = result.keys()
                return [dict(zip(columns, row)) for row in result.fetchall()]

        return self._retry_operation(_execute)

    def execute_scalar(self, sql: str, params: Optional[dict] = None) -> Any:
        """
        Executa query e retorna valor escalar (primeira coluna da primeira linha).

        Args:
            sql: Query SQL a ser executada
            params: Parâmetros para a query

        Returns:
            Valor escalar do resultado

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        def _execute():
            if not self.is_connected:
                self.connect()

            with self.session_scope() as session:
                result = session.execute(text(sql), params or {})
                return result.scalar()

        return self._retry_operation(_execute)

    def execute_insert(self, sql: str, params: Optional[dict] = None) -> int:
        """
        Executa INSERT e retorna ID do registro inserido.

        Args:
            sql: Query INSERT a ser executada
            params: Parâmetros para a query

        Returns:
            ID do registro inserido (se disponível)

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        def _execute():
            if not self.is_connected:
                self.connect()

            with self.session_scope() as session:
                result = session.execute(text(sql), params or {})
                # Tenta retornar o ID inserido
                if hasattr(result, 'lastrowid') and result.lastrowid:
                    return result.lastrowid
                return result.rowcount

        return self._retry_operation(_execute)

    def execute_many(self, sql: str, params_list: list[dict]) -> int:
        """
        Executa query para múltiplos registros.

        Args:
            sql: Query SQL a ser executada
            params_list: Lista de parâmetros para cada execução

        Returns:
            Número de registros afetados

        Raises:
            SQLAlchemyError: Erros de banco de dados
        """
        def _execute():
            if not self.is_connected:
                self.connect()

            with self.session_scope() as session:
                total_affected = 0
                for params in params_list:
                    result = session.execute(text(sql), params)
                    total_affected += result.rowcount
                return total_affected

        return self._retry_operation(_execute)

    def begin_transaction(self) -> None:
        """
        Inicia transação manual.

        Raises:
            RuntimeError: Se já existe uma transação ativa
        """
        if self._transaction_session:
            raise RuntimeError("Já existe uma transação ativa")

        if not self.is_connected:
            self.connect()

        self._transaction_session = self.get_session()
        self._transaction_session.begin()
        logger.debug("Transação manual iniciada")

    def commit(self) -> None:
        """
        Commita transação manual.

        Raises:
            RuntimeError: Se não existe transação ativa
        """
        if not self._transaction_session:
            raise RuntimeError("Nenhuma transação ativa para commitar")

        try:
            self._transaction_session.commit()
            logger.debug("Transação manual commitada")
        finally:
            self._transaction_session.close()
            self._transaction_session = None

    def rollback(self) -> None:
        """
        Faz rollback da transação manual.

        Raises:
            RuntimeError: Se não existe transação ativa
        """
        if not self._transaction_session:
            raise RuntimeError("Nenhuma transação ativa para rollback")

        try:
            self._transaction_session.rollback()
            logger.debug("Rollback da transação manual executado")
        finally:
            self._transaction_session.close()
            self._transaction_session = None

    def __enter__(self):
        """Suporte a context manager para conexão."""
        self.connect()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Fecha conexão ao sair do context manager."""
        self.disconnect()