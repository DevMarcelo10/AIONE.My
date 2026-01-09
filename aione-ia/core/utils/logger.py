"""
AIONE IA - Logger
Sistema de logging centralizado com configuração avançada
"""

import logging
import os
import sys
from logging.handlers import RotatingFileHandler
from pathlib import Path
from typing import Optional


class ColoredFormatter(logging.Formatter):
    """Formatter com cores para terminal."""

    # Cores ANSI conforme especificação
    COLORS = {
        "DEBUG": "\033[90m",       # Cinza
        "INFO": "\033[37m",        # Branco
        "WARNING": "\033[93m",     # Amarelo
        "ERROR": "\033[91m",       # Vermelho
        "CRITICAL": "\033[1;91m",  # Vermelho bold
    }
    RESET = "\033[0m"

    def format(self, record: logging.LogRecord) -> str:
        """
        Formata a mensagem com cores.

        Args:
            record: LogRecord a ser formatado

        Returns:
            Mensagem formatada com cores
        """
        # Faz uma cópia do record para não alterar o original
        record_copy = logging.makeLogRecord(record.__dict__)

        # Aplica cor apenas no terminal
        if hasattr(sys.stdout, 'isatty') and sys.stdout.isatty():
            color = self.COLORS.get(record_copy.levelname, self.RESET)
            record_copy.levelname = f"{color}{record_copy.levelname}{self.RESET}"

        return super().format(record_copy)


class AIOneLogger:
    """Gerenciador centralizado de logging para AIONE IA."""

    _initialized = False
    _loggers = {}

    @classmethod
    def initialize(cls) -> None:
        """
        Inicializa o sistema de logging.
        Chamado automaticamente na primeira vez que get_logger é usado.
        """
        if cls._initialized:
            return

        # Obtém nível de log do ambiente ou usa INFO como padrão
        log_level_str = os.getenv('LOG_LEVEL', 'INFO').upper()
        try:
            log_level = getattr(logging, log_level_str)
        except AttributeError:
            log_level = logging.INFO

        # Formato conforme especificação
        base_format = "%(asctime)s | %(levelname)-8s | %(name)s | %(message)s"
        date_format = "%Y-%m-%d %H:%M:%S"

        # Cria diretório de logs automaticamente
        log_dir = Path("logs")
        log_dir.mkdir(exist_ok=True)

        # Configuração do logger raiz
        root_logger = logging.getLogger()
        root_logger.setLevel(log_level)

        # Remove handlers existentes para evitar duplicação
        for handler in root_logger.handlers[:]:
            root_logger.removeHandler(handler)

        # Handler para console com cores
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(log_level)
        console_handler.setFormatter(ColoredFormatter(base_format, date_format))
        root_logger.addHandler(console_handler)

        # Handler para arquivo rotativo
        log_file = log_dir / "aione-ia.log"
        file_handler = RotatingFileHandler(
            filename=log_file,
            maxBytes=10 * 1024 * 1024,  # 10MB
            backupCount=5,
            encoding='utf-8'
        )
        file_handler.setLevel(log_level)
        file_handler.setFormatter(logging.Formatter(base_format, date_format))
        root_logger.addHandler(file_handler)

        # Silencia logs verbosos de bibliotecas externas
        external_loggers = [
            'httpx', 'httpcore', 'uvicorn', 'uvicorn.access',
            'uvicorn.error', 'fastapi', 'apscheduler', 'sqlalchemy',
            'urllib3', 'requests', 'asyncio'
        ]

        for logger_name in external_loggers:
            logging.getLogger(logger_name).setLevel(logging.WARNING)

        cls._initialized = True

        # Log de inicialização
        init_logger = logging.getLogger('aione.logger')
        init_logger.info(f"Sistema de logging inicializado - Nível: {log_level_str}")

    @classmethod
    def get_logger(cls, name: str) -> logging.Logger:
        """
        Retorna logger configurado, evitando duplicação de handlers.

        Args:
            name: Nome do logger (geralmente __name__)

        Returns:
            Logger configurado

        Examples:
            >>> logger = get_logger(__name__)
            >>> logger.info("Mensagem de teste")
            >>> logger.error("Erro de teste")
        """
        # Inicializa sistema se necessário
        if not cls._initialized:
            cls.initialize()

        # Retorna logger existente ou cria novo
        if name not in cls._loggers:
            logger = logging.getLogger(name)
            # Não adiciona handlers aqui - usa os do root logger
            cls._loggers[name] = logger

        return cls._loggers[name]

    @classmethod
    def set_level(cls, level: str) -> None:
        """
        Altera o nível de logging dinamicamente.

        Args:
            level: Novo nível (DEBUG, INFO, WARNING, ERROR, CRITICAL)

        Examples:
            >>> AIOneLogger.set_level('DEBUG')
            >>> AIOneLogger.set_level('WARNING')
        """
        try:
            log_level = getattr(logging, level.upper())
            root_logger = logging.getLogger()
            root_logger.setLevel(log_level)

            # Atualiza handlers
            for handler in root_logger.handlers:
                handler.setLevel(log_level)

            logger = cls.get_logger('aione.logger')
            logger.info(f"Nível de logging alterado para: {level.upper()}")

        except AttributeError:
            logger = cls.get_logger('aione.logger')
            logger.error(f"Nível de logging inválido: {level}")

    @classmethod
    def get_log_file_path(cls) -> Path:
        """
        Retorna o caminho do arquivo de log atual.

        Returns:
            Caminho do arquivo de log
        """
        return Path("logs") / "aione-ia.log"

    @classmethod
    def rotate_logs(cls) -> None:
        """
        Força rotação dos logs manualmente.
        """
        root_logger = logging.getLogger()

        for handler in root_logger.handlers:
            if isinstance(handler, RotatingFileHandler):
                handler.doRollover()

        logger = cls.get_logger('aione.logger')
        logger.info("Rotação manual de logs executada")


def get_logger(name: str) -> logging.Logger:
    """
    Função de conveniência para obter logger configurado.

    Args:
        name: Nome do logger (geralmente __name__)

    Returns:
        Logger configurado

    Examples:
        >>> from core.utils import get_logger
        >>> logger = get_logger(__name__)
        >>> logger.info("Sistema iniciado")
        >>> logger.warning("Atenção: configuração não encontrada")
        >>> logger.error("Erro ao conectar no banco")
    """
    return AIOneLogger.get_logger(name)


def set_log_level(level: str) -> None:
    """
    Função de conveniência para alterar nível de logging.

    Args:
        level: Novo nível de logging

    Examples:
        >>> set_log_level('DEBUG')  # Para desenvolvimento
        >>> set_log_level('WARNING')  # Para produção
    """
    AIOneLogger.set_level(level)


def get_log_file() -> Path:
    """
    Função de conveniência para obter caminho do arquivo de log.

    Returns:
        Caminho do arquivo de log atual
    """
    return AIOneLogger.get_log_file_path()


# Inicializa o sistema na importação do módulo
AIOneLogger.initialize()