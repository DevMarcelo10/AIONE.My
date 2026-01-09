"""
AIONE IA - Scheduler Manager
Gerenciador de agendamentos usando APScheduler com BackgroundScheduler
"""

import traceback
from typing import Callable, Dict, Optional

from apscheduler.events import EVENT_JOB_EXECUTED, EVENT_JOB_ERROR, EVENT_JOB_MISSED
from apscheduler.job import Job
from apscheduler.schedulers.background import BackgroundScheduler

from core.utils import get_logger


logger = get_logger(__name__)


class SchedulerManager:
    """
    Gerenciador de tarefas agendadas usando APScheduler.

    Configurado com timezone brasileiro e defaults apropriados.
    """

    def __init__(self):
        """
        Inicializa o SchedulerManager.

        Configurações:
        - timezone='America/Sao_Paulo'
        - job_defaults: coalesce=True, max_instances=1, misfire_grace_time=3600
        """
        # Configurações do job por padrão
        job_defaults = {
            'coalesce': True,           # Une execuções perdidas em uma só
            'max_instances': 1,         # Apenas uma instância por job
            'misfire_grace_time': 3600  # 1 hora de tolerância para jobs perdidos
        }

        # Cria scheduler com timezone brasileiro
        self._scheduler = BackgroundScheduler(
            timezone='America/Sao_Paulo',
            job_defaults=job_defaults
        )

        # Armazena referências dos jobs
        self.jobs: Dict[str, Job] = {}

        # Adiciona listeners de eventos
        self._add_event_listeners()

        logger.info("SchedulerManager inicializado")

    def start(self) -> None:
        """
        Inicia o scheduler.

        Raises:
            Exception: Se ocorrer erro ao iniciar
        """
        try:
            if not self._scheduler.running:
                self._scheduler.start()
                logger.info("Scheduler iniciado com sucesso")
            else:
                logger.warning("Scheduler já está rodando")
        except Exception as e:
            logger.error(f"Erro ao iniciar scheduler: {e}")
            raise

    def stop(self) -> None:
        """
        Para o scheduler gracefully.

        Aguarda a conclusão de jobs em execução.
        """
        try:
            if self._scheduler.running:
                self._scheduler.shutdown(wait=True)
                logger.info("Scheduler parado com sucesso")
            else:
                logger.warning("Scheduler já está parado")
        except Exception as e:
            logger.error(f"Erro ao parar scheduler: {e}")
        finally:
            # Limpa referências dos jobs
            self.jobs.clear()

    def add_job(
        self,
        job_id: str,
        func: Callable,
        trigger: str,
        **trigger_args
    ) -> Job:
        """
        Adiciona job ao scheduler.

        Args:
            job_id: ID único do job
            func: Função a ser executada
            trigger: Tipo do trigger ('interval' ou 'cron')
            **trigger_args: Argumentos específicos do trigger

        Returns:
            Job: Instância do job criado

        Raises:
            ValueError: Se trigger inválido
            Exception: Se erro ao criar job

        Examples:
            >>> # Job a cada 30 minutos
            >>> scheduler.add_job(
            ...     'backup_db',
            ...     backup_database,
            ...     'interval',
            ...     minutes=30
            ... )

            >>> # Job diário às 02:00
            >>> scheduler.add_job(
            ...     'cleanup',
            ...     cleanup_temp_files,
            ...     'cron',
            ...     hour=2,
            ...     minute=0
            ... )
        """
        if trigger not in ('interval', 'cron'):
            raise ValueError(f"Trigger inválido: {trigger}. Use 'interval' ou 'cron'")

        try:
            # Remove job existente com mesmo ID
            if job_id in self.jobs:
                self.remove_job(job_id)

            # Cria novo job
            job = self._scheduler.add_job(
                func=func,
                trigger=trigger,
                id=job_id,
                name=job_id,
                replace_existing=True,
                **trigger_args
            )

            # Armazena referência
            self.jobs[job_id] = job

            logger.info(
                f"Job '{job_id}' adicionado com trigger '{trigger}' "
                f"e argumentos {trigger_args}"
            )

            return job

        except Exception as e:
            logger.error(f"Erro ao adicionar job '{job_id}': {e}")
            raise

    def remove_job(self, job_id: str) -> bool:
        """
        Remove job se existir.

        Args:
            job_id: ID do job a ser removido

        Returns:
            True se removido, False se não existia

        Examples:
            >>> success = scheduler.remove_job('backup_db')
        """
        try:
            if job_id in self.jobs:
                self._scheduler.remove_job(job_id)
                del self.jobs[job_id]
                logger.info(f"Job '{job_id}' removido com sucesso")
                return True
            else:
                logger.warning(f"Job '{job_id}' não encontrado para remoção")
                return False

        except Exception as e:
            logger.error(f"Erro ao remover job '{job_id}': {e}")
            return False

    def run_job_now(self, job_id: str) -> bool:
        """
        Executa job imediatamente.

        Args:
            job_id: ID do job a ser executado

        Returns:
            True se executado, False caso contrário

        Examples:
            >>> success = scheduler.run_job_now('backup_db')
        """
        try:
            if job_id in self.jobs:
                job = self.jobs[job_id]
                job.modify(next_run_time=None)  # Executa agora
                logger.info(f"Job '{job_id}' agendado para execução imediata")
                return True
            else:
                logger.warning(f"Job '{job_id}' não encontrado para execução")
                return False

        except Exception as e:
            logger.error(f"Erro ao executar job '{job_id}': {e}")
            return False

    def get_job_status(self, job_id: str) -> Optional[Dict]:
        """
        Retorna status de um job específico.

        Args:
            job_id: ID do job

        Returns:
            Dicionário com status ou None se não encontrado

        Examples:
            >>> status = scheduler.get_job_status('backup_db')
            >>> print(status['next_run_time'])
        """
        try:
            if job_id in self.jobs:
                job = self.jobs[job_id]
                return {
                    'job_id': job_id,
                    'name': job.name,
                    'next_run_time': job.next_run_time.isoformat() if job.next_run_time else None,
                    'trigger': str(job.trigger),
                    'func_name': job.func.__name__ if hasattr(job.func, '__name__') else str(job.func),
                    'pending': getattr(job, 'pending', False)
                }
            else:
                return None

        except Exception as e:
            logger.error(f"Erro ao obter status do job '{job_id}': {e}")
            return None

    def get_all_status(self) -> Dict[str, Dict]:
        """
        Retorna status de todos os jobs.

        Returns:
            Dicionário com status de todos os jobs

        Examples:
            >>> all_status = scheduler.get_all_status()
            >>> for job_id, status in all_status.items():
            ...     print(f"{job_id}: {status['next_run_time']}")
        """
        all_status = {}

        for job_id in self.jobs.keys():
            status = self.get_job_status(job_id)
            if status:
                all_status[job_id] = status

        return all_status

    def _add_event_listeners(self) -> None:
        """
        Adiciona listeners para eventos do scheduler.

        Monitora execução, erros e jobs perdidos.
        """
        def job_executed_listener(event):
            """Listener para jobs executados com sucesso."""
            logger.info(
                f"Job '{event.job_id}' executado com sucesso "
                f"em {event.scheduled_run_time.isoformat()}"
            )

        def job_error_listener(event):
            """Listener para erros em jobs."""
            logger.error(
                f"Erro no job '{event.job_id}': {event.exception}"
            )
            # Log do traceback completo
            if event.traceback:
                logger.debug(f"Traceback do job '{event.job_id}':\n{event.traceback}")

        def job_missed_listener(event):
            """Listener para jobs perdidos."""
            logger.warning(
                f"Job '{event.job_id}' perdeu execução agendada para "
                f"{event.scheduled_run_time.isoformat()}"
            )

        # Adiciona listeners
        self._scheduler.add_listener(job_executed_listener, EVENT_JOB_EXECUTED)
        self._scheduler.add_listener(job_error_listener, EVENT_JOB_ERROR)
        self._scheduler.add_listener(job_missed_listener, EVENT_JOB_MISSED)

        logger.debug("Event listeners adicionados ao scheduler")

    def pause_job(self, job_id: str) -> bool:
        """
        Pausa um job.

        Args:
            job_id: ID do job a ser pausado

        Returns:
            True se pausado com sucesso
        """
        try:
            if job_id in self.jobs:
                self._scheduler.pause_job(job_id)
                logger.info(f"Job '{job_id}' pausado")
                return True
            else:
                logger.warning(f"Job '{job_id}' não encontrado para pausar")
                return False

        except Exception as e:
            logger.error(f"Erro ao pausar job '{job_id}': {e}")
            return False

    def resume_job(self, job_id: str) -> bool:
        """
        Resume um job pausado.

        Args:
            job_id: ID do job a ser resumido

        Returns:
            True se resumido com sucesso
        """
        try:
            if job_id in self.jobs:
                self._scheduler.resume_job(job_id)
                logger.info(f"Job '{job_id}' resumido")
                return True
            else:
                logger.warning(f"Job '{job_id}' não encontrado para resumir")
                return False

        except Exception as e:
            logger.error(f"Erro ao resumir job '{job_id}': {e}")
            return False

    def modify_job(self, job_id: str, **changes) -> bool:
        """
        Modifica parâmetros de um job existente.

        Args:
            job_id: ID do job a ser modificado
            **changes: Mudanças a serem aplicadas

        Returns:
            True se modificado com sucesso
        """
        try:
            if job_id in self.jobs:
                self._scheduler.modify_job(job_id, **changes)
                logger.info(f"Job '{job_id}' modificado: {changes}")
                return True
            else:
                logger.warning(f"Job '{job_id}' não encontrado para modificar")
                return False

        except Exception as e:
            logger.error(f"Erro ao modificar job '{job_id}': {e}")
            return False

    @property
    def is_running(self) -> bool:
        """
        Verifica se o scheduler está rodando.

        Returns:
            True se rodando
        """
        return self._scheduler.running

    @property
    def job_count(self) -> int:
        """
        Número de jobs registrados.

        Returns:
            Quantidade de jobs
        """
        return len(self.jobs)