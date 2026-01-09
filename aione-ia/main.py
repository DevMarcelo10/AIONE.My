"""
AIONE IA - Entry Point Principal
Sistema de Inteligência Artificial para ERP de Farmácias
"""

import importlib
import sys
from contextlib import asynccontextmanager

import uvicorn
from fastapi import FastAPI

from config import settings
from core.api.app import create_base_app
from core.database.factory import DatabaseFactory
from core.scheduler.manager import SchedulerManager
from core.utils.logger import get_logger

logger = get_logger(__name__)


def load_module_routes(app: FastAPI, module_name: str) -> bool:
    """Carrega rotas de um módulo dinamicamente"""
    try:
        module = importlib.import_module(f"modules.{module_name}.routes")
        if hasattr(module, "router"):
            app.include_router(
                module.router,
                prefix=f"/api/{module_name}",
                tags=[module_name.capitalize()]
            )
            logger.info(f"Módulo '{module_name}' carregado com sucesso")
            return True
        else:
            logger.warning(f"Módulo '{module_name}' não possui router definido")
            return False
    except ModuleNotFoundError as e:
        logger.error(f"Módulo '{module_name}' não encontrado: {e}")
        return False
    except Exception as e:
        logger.error(f"Erro ao carregar módulo '{module_name}': {e}")
        return False


def load_module_jobs(scheduler: SchedulerManager, module_name: str) -> bool:
    """Carrega jobs agendados de um módulo"""
    try:
        module = importlib.import_module(f"modules.{module_name}.jobs")
        if hasattr(module, "register_jobs"):
            module.register_jobs(scheduler)
            logger.info(f"Jobs do módulo '{module_name}' registrados")
            return True
        return False
    except ModuleNotFoundError:
        # Módulo não tem jobs, isso é ok
        return False
    except Exception as e:
        logger.error(f"Erro ao carregar jobs do módulo '{module_name}': {e}")
        return False


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Gerencia ciclo de vida da aplicação"""
    logger.info("=" * 50)
    logger.info("AIONE IA - Iniciando serviços...")
    logger.info("=" * 50)

    # Inicializa banco de dados
    try:
        db = DatabaseFactory.create()
        if db.test_connection():
            logger.info(f"Banco de dados conectado ({settings.db_type})")
        else:
            logger.error("Falha na conexão com banco de dados")
    except Exception as e:
        logger.error(f"Erro ao conectar banco: {e}")

    # Inicializa scheduler
    scheduler = SchedulerManager()

    # Carrega módulos ativos
    loaded_modules = []
    for module_name in settings.active_modules_list:
        if load_module_routes(app, module_name):
            loaded_modules.append(module_name)
            load_module_jobs(scheduler, module_name)

    logger.info(f"Módulos carregados: {', '.join(loaded_modules) or 'nenhum'}")

    # Inicia scheduler
    scheduler.start()
    logger.info("Scheduler iniciado")

    logger.info(f"API disponível em http://{settings.api_host}:{settings.api_port}")
    logger.info("=" * 50)

    yield

    # Shutdown
    logger.info("Encerrando serviços...")
    scheduler.shutdown()
    logger.info("AIONE IA finalizado")


def create_app() -> FastAPI:
    """Cria e configura a aplicação FastAPI"""
    app = create_base_app(lifespan=lifespan)
    return app


app = create_app()


if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host=settings.api_host,
        port=settings.api_port,
        reload=settings.debug,
        log_level=settings.log_level.lower(),
    )
