"""
AIONE IA - Middlewares
Sistema de middlewares para FastAPI
"""

import time
import traceback
import uuid
from datetime import datetime
from typing import Callable

from fastapi import FastAPI, Request, Response, HTTPException
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from starlette.middleware.base import BaseHTTPMiddleware

from core.utils import get_logger, now_br


logger = get_logger(__name__)


class ErrorResponse(BaseModel):
    """Modelo padronizado para respostas de erro."""

    error: str
    message: str
    request_id: str
    timestamp: datetime

    class Config:
        json_encoders = {
            datetime: lambda v: v.isoformat()
        }


def add_middlewares(app: FastAPI, settings) -> None:
    """
    Adiciona todos os middlewares à aplicação FastAPI.

    Args:
        app: Instância do FastAPI
        settings: Configurações da aplicação

    Examples:
        >>> add_middlewares(app, settings)
        # Adiciona CORS, RequestID, Timing e ErrorHandler
    """
    # CORS - Configurável via settings ou padrão
    cors_origins = getattr(settings, 'CORS_ORIGINS', ["*"])
    if isinstance(cors_origins, str):
        cors_origins = [origin.strip() for origin in cors_origins.split(',')]

    app.add_middleware(
        CORSMiddleware,
        allow_origins=cors_origins,
        allow_credentials=getattr(settings, 'CORS_ALLOW_CREDENTIALS', True),
        allow_methods=getattr(settings, 'CORS_ALLOW_METHODS', ["*"]),
        allow_headers=getattr(settings, 'CORS_ALLOW_HEADERS', ["*"]),
    )

    # Middleware de Request ID
    app.add_middleware(RequestIDMiddleware)

    # Middleware de Timing
    app.add_middleware(TimingMiddleware)

    # Exception handlers
    _add_exception_handlers(app)

    logger.info("Middlewares configurados com sucesso")


def _add_exception_handlers(app: FastAPI) -> None:
    """
    Adiciona exception handlers customizados.

    Args:
        app: Instância do FastAPI
    """

    @app.exception_handler(HTTPException)
    async def http_exception_handler(request: Request, exc: HTTPException):
        """Handler para HTTPException."""
        request_id = getattr(request.state, 'request_id', 'unknown')

        error_response = ErrorResponse(
            error=f"http_{exc.status_code}",
            message=exc.detail,
            request_id=request_id,
            timestamp=now_br()
        )

        logger.warning(
            f"HTTP {exc.status_code}: {exc.detail} "
            f"[Request ID: {request_id}] "
            f"[Path: {request.method} {request.url.path}]"
        )

        return JSONResponse(
            status_code=exc.status_code,
            content=error_response.dict()
        )

    @app.exception_handler(RequestValidationError)
    async def validation_exception_handler(request: Request, exc: RequestValidationError):
        """Handler para erros de validação."""
        request_id = getattr(request.state, 'request_id', 'unknown')

        # Constrói mensagem detalhada dos erros
        errors_detail = []
        for error in exc.errors():
            location = " -> ".join(str(x) for x in error["loc"])
            errors_detail.append(f"{location}: {error['msg']}")

        error_message = "Dados inválidos: " + "; ".join(errors_detail)

        error_response = ErrorResponse(
            error="validation_error",
            message=error_message,
            request_id=request_id,
            timestamp=now_br()
        )

        logger.warning(
            f"Validation Error: {error_message} "
            f"[Request ID: {request_id}] "
            f"[Path: {request.method} {request.url.path}]"
        )

        return JSONResponse(
            status_code=422,
            content=error_response.dict()
        )

    @app.exception_handler(Exception)
    async def generic_exception_handler(request: Request, exc: Exception):
        """Handler para exceções genéricas."""
        request_id = getattr(request.state, 'request_id', 'unknown')

        error_response = ErrorResponse(
            error="internal_server_error",
            message="Erro interno do servidor",
            request_id=request_id,
            timestamp=now_br()
        )

        logger.error(
            f"Erro não tratado: {str(exc)} "
            f"[Request ID: {request_id}] "
            f"[Path: {request.method} {request.url.path}]"
        )
        logger.debug(f"Traceback completo:\n{traceback.format_exc()}")

        return JSONResponse(
            status_code=500,
            content=error_response.dict()
        )


class RequestIDMiddleware(BaseHTTPMiddleware):
    """Middleware que adiciona X-Request-ID único a cada requisição."""

    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        """
        Processa requisição adicionando ID único.

        Args:
            request: Objeto da requisição
            call_next: Próximo middleware na cadeia

        Returns:
            Response com header X-Request-ID
        """
        # Gera ou usa X-Request-ID existente
        request_id = request.headers.get('x-request-id') or str(uuid.uuid4())

        # Armazena no state da requisição para uso em outros middlewares/handlers
        request.state.request_id = request_id

        # Processa a requisição
        response = await call_next(request)

        # Adiciona header na resposta
        response.headers['X-Request-ID'] = request_id

        return response


class TimingMiddleware(BaseHTTPMiddleware):
    """Middleware que adiciona X-Response-Time com tempo de processamento."""

    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        """
        Processa requisição medindo tempo de resposta.

        Args:
            request: Objeto da requisição
            call_next: Próximo middleware na cadeia

        Returns:
            Response com header X-Response-Time
        """
        start_time = time.time()

        # Processa a requisição
        response = await call_next(request)

        # Calcula tempo de processamento
        process_time = time.time() - start_time

        # Adiciona header na resposta (em milissegundos)
        response.headers['X-Response-Time'] = f"{process_time * 1000:.2f}ms"

        # Log opcional para monitoramento
        request_id = getattr(request.state, 'request_id', 'unknown')

        if process_time > 1.0:  # Log apenas requisições lentas (>1s)
            logger.warning(
                f"Requisição lenta: {request.method} {request.url.path} "
                f"[{process_time:.2f}s] [Request ID: {request_id}]"
            )
        else:
            logger.debug(
                f"Request: {request.method} {request.url.path} "
                f"[{process_time:.3f}s] [Request ID: {request_id}]"
            )

        return response


class SecurityHeadersMiddleware(BaseHTTPMiddleware):
    """Middleware opcional para adicionar headers de segurança."""

    def __init__(self, app, enable_security_headers: bool = True):
        super().__init__(app)
        self.enable_security_headers = enable_security_headers

    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        """
        Adiciona headers de segurança à resposta.

        Args:
            request: Objeto da requisição
            call_next: Próximo middleware na cadeia

        Returns:
            Response com headers de segurança
        """
        response = await call_next(request)

        if self.enable_security_headers:
            # Headers de segurança recomendados
            security_headers = {
                'X-Content-Type-Options': 'nosniff',
                'X-Frame-Options': 'DENY',
                'X-XSS-Protection': '1; mode=block',
                'Referrer-Policy': 'strict-origin-when-cross-origin',
                'Content-Security-Policy': "default-src 'self'",
            }

            for header_name, header_value in security_headers.items():
                response.headers[header_name] = header_value

        return response


def add_security_middleware(app: FastAPI, settings) -> None:
    """
    Adiciona middleware de segurança opcionalmente.

    Args:
        app: Instância do FastAPI
        settings: Configurações da aplicação
    """
    enable_security = getattr(settings, 'ENABLE_SECURITY_HEADERS', False)

    if enable_security:
        app.add_middleware(SecurityHeadersMiddleware, enable_security_headers=True)
        logger.info("Headers de segurança habilitados")


def get_request_id(request: Request) -> str:
    """
    Obtém o ID da requisição atual.

    Args:
        request: Objeto da requisição

    Returns:
        ID da requisição ou 'unknown'

    Examples:
        >>> request_id = get_request_id(request)
    """
    return getattr(request.state, 'request_id', 'unknown')