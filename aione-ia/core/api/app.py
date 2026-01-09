"""
AIONE IA - FastAPI Application
Configuração principal da aplicação FastAPI
"""

import importlib
from datetime import datetime
from typing import List

from fastapi import FastAPI, HTTPException

from core.utils import get_logger, now_br
from .middleware import add_middlewares


logger = get_logger(__name__)


def create_app(settings, modules: List[str]) -> FastAPI:
    """
    Cria instância FastAPI configurada.

    Args:
        settings: Objeto de configurações do projeto
        modules: Lista de módulos ativos para registrar rotas

    Returns:
        FastAPI: Instância configurada da aplicação

    Examples:
        >>> app = create_app(settings, ['compras', 'vendas'])
    """
    app = FastAPI(
        title="AIONE-IA",
        description="Motor de Inteligência Artificial para ERP de Farmácias",
        version=getattr(settings, 'VERSION', '1.0.0'),
        docs_url="/docs" if getattr(settings, 'DEBUG', False) else None,
        redoc_url="/redoc" if getattr(settings, 'DEBUG', False) else None,
        openapi_url="/openapi.json" if getattr(settings, 'DEBUG', False) else None,
    )

    # Adiciona middlewares
    add_middlewares(app, settings)

    # Registra endpoints base
    _register_base_endpoints(app, settings, modules)

    # Registra rotas dos módulos ativos
    for module_name in modules:
        try:
            register_module_routes(app, module_name)
            logger.info(f"Módulo '{module_name}' registrado com sucesso")
        except Exception as e:
            logger.error(f"Erro ao registrar módulo '{module_name}': {e}")

    logger.info(f"AIONE-IA inicializado com {len(modules)} módulos")
    return app


def register_module_routes(app: FastAPI, module_name: str) -> None:
    """
    Registra rotas de um módulo dinamicamente.

    Args:
        app: Instância do FastAPI
        module_name: Nome do módulo para importar rotas

    Raises:
        ImportError: Se o módulo não puder ser importado
        AttributeError: Se o módulo não tiver 'router'

    Examples:
        >>> register_module_routes(app, 'compras')
        # Importa modules.compras.routes e adiciona com prefix /api/compras
    """
    try:
        # Importa dinamicamente: modules.{module_name}.routes
        routes_module = importlib.import_module(f"modules.{module_name}.routes")

        if not hasattr(routes_module, 'router'):
            raise AttributeError(f"Módulo '{module_name}' não possui 'router'")

        router = routes_module.router

        # Adiciona router com prefix e tag
        app.include_router(
            router,
            prefix=f"/api/{module_name}",
            tags=[module_name.capitalize()]
        )

        logger.debug(f"Router do módulo '{module_name}' registrado em /api/{module_name}")

    except ImportError as e:
        logger.error(f"Erro ao importar módulo '{module_name}': {e}")
        raise ImportError(f"Não foi possível importar módulo '{module_name}': {e}")

    except AttributeError as e:
        logger.error(f"Módulo '{module_name}' malformado: {e}")
        raise AttributeError(f"Módulo '{module_name}' não possui router válido: {e}")


def _register_base_endpoints(app: FastAPI, settings, modules: List[str]) -> None:
    """
    Registra endpoints base sempre disponíveis.

    Args:
        app: Instância do FastAPI
        settings: Configurações da aplicação
        modules: Lista de módulos carregados
    """

    @app.get("/health",
             summary="Health Check",
             description="Verifica status da aplicação e módulos",
             tags=["Sistema"])
    async def health_check():
        """
        Endpoint de health check.

        Returns:
            dict: Status da aplicação, timestamp e módulos carregados
        """
        return {
            "status": "ok",
            "timestamp": now_br().isoformat(),
            "modules": modules
        }

    @app.get("/info",
             summary="Informações do Sistema",
             description="Retorna informações gerais da aplicação",
             tags=["Sistema"])
    async def system_info():
        """
        Endpoint com informações do sistema.

        Returns:
            dict: Versão, tipo de banco e módulos carregados
        """
        try:
            # Tenta obter tipo do banco das configurações
            db_type = getattr(settings, 'DB_TYPE', 'unknown')
        except AttributeError:
            db_type = 'not_configured'

        return {
            "version": getattr(settings, 'VERSION', '1.0.0'),
            "db_type": db_type,
            "modules_loaded": modules,
            "total_modules": len(modules),
            "debug": getattr(settings, 'DEBUG', False),
            "environment": getattr(settings, 'ENVIRONMENT', 'production')
        }

    @app.get("/",
             summary="Root Endpoint",
             description="Endpoint raiz com informações básicas",
             tags=["Sistema"])
    async def root():
        """
        Endpoint raiz.

        Returns:
            dict: Informações básicas da API
        """
        return {
            "service": "AIONE-IA",
            "description": "Motor de Inteligência Artificial para ERP de Farmácias",
            "version": getattr(settings, 'VERSION', '1.0.0'),
            "status": "online",
            "docs": "/docs" if getattr(settings, 'DEBUG', False) else None
        }


def get_module_list(modules_config: str) -> List[str]:
    """
    Converte string de módulos em lista.

    Args:
        modules_config: String com módulos separados por vírgula

    Returns:
        Lista de nomes de módulos

    Examples:
        >>> get_module_list("compras,vendas,estoque")
        ['compras', 'vendas', 'estoque']
    """
    if not modules_config:
        return []

    modules = [
        module.strip()
        for module in modules_config.split(',')
        if module.strip()
    ]

    logger.debug(f"Módulos carregados: {modules}")
    return modules


def validate_modules(modules: List[str]) -> List[str]:
    """
    Valida se os módulos existem antes de registrar.

    Args:
        modules: Lista de módulos para validar

    Returns:
        Lista de módulos válidos

    Examples:
        >>> valid_modules = validate_modules(['compras', 'invalid_module'])
        # Retorna apenas ['compras']
    """
    valid_modules = []

    for module_name in modules:
        try:
            # Tenta importar o módulo para verificar se existe
            importlib.import_module(f"modules.{module_name}")
            valid_modules.append(module_name)
            logger.debug(f"Módulo '{module_name}' validado")

        except ImportError:
            logger.warning(f"Módulo '{module_name}' não encontrado, ignorando")

        except Exception as e:
            logger.error(f"Erro ao validar módulo '{module_name}': {e}")

    return valid_modules