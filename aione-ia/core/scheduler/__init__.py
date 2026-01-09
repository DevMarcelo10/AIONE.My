"""
AIONE IA - Scheduler Module
Gerenciamento de tarefas agendadas com APScheduler
"""

from .manager import SchedulerManager

# Exporta classe principal
__all__ = ["SchedulerManager"]

# Instância global do scheduler
scheduler = None


def get_scheduler() -> SchedulerManager:
    """
    Retorna a instância global do scheduler.

    Returns:
        SchedulerManager: Instância do scheduler

    Examples:
        >>> from core.scheduler import get_scheduler
        >>> scheduler = get_scheduler()
        >>> scheduler.start()
    """
    global scheduler
    if scheduler is None:
        scheduler = SchedulerManager()
    return scheduler


def initialize_scheduler() -> SchedulerManager:
    """
    Inicializa e retorna o scheduler global.

    Returns:
        SchedulerManager: Instância inicializada

    Examples:
        >>> from core.scheduler import initialize_scheduler
        >>> scheduler = initialize_scheduler()
        >>> scheduler.add_job('test', my_function, 'interval', minutes=5)
    """
    global scheduler
    scheduler = SchedulerManager()
    return scheduler


def shutdown_scheduler() -> None:
    """
    Para e limpa a instância global do scheduler.

    Examples:
        >>> from core.scheduler import shutdown_scheduler
        >>> shutdown_scheduler()
    """
    global scheduler
    if scheduler is not None:
        scheduler.stop()
        scheduler = None