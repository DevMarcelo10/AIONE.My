"""
AIONE IA - Jobs do Módulo de Compras
Funções para registrar jobs do módulo no scheduler
"""

import asyncio
import time
from datetime import datetime
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.scheduler import SchedulerManager
from core.utils import get_logger
from .models import FonteExterna, Regiao


logger = get_logger(__name__)


async def executar_coletor(tipo: str, db: DatabaseManager) -> Dict:
    """
    Executa coletor específico manualmente.

    Args:
        tipo: Tipo do coletor (clima, saude, trends, eventos)
        db: Instância do DatabaseManager

    Returns:
        Dicionário com resultado da execução
    """
    inicio = time.time()
    resultado = {
        'sucesso': True,
        'regioes': 0,
        'alertas': 0,
        'erros': [],
        'tempo_execucao': None
    }

    try:
        # Import dinâmico dos coletores
        if tipo == 'clima':
            from .coletores.clima import ColetorClima
            coletor = ColetorClima(db)
        elif tipo == 'saude':
            from .coletores.saude import ColetorSaude
            coletor = ColetorSaude(db)
        elif tipo == 'trends':
            from .coletores.trends import ColetorTrends
            coletor = ColetorTrends(db)
        elif tipo == 'eventos':
            from .coletores.eventos import ColetorEventos
            coletor = ColetorEventos(db)
        else:
            tipos_validos = ['clima', 'saude', 'trends', 'eventos']
            raise ValueError(f"Tipo de coletor inválido: {tipo}. Use: {', '.join(tipos_validos)}")

        logger.info(f"Iniciando execução manual do coletor {tipo}")

        # Usar o método executar() da ColetorBase que já faz tudo
        resultado_execucao = await coletor.executar()

        # Mapear resultado para o formato esperado
        resultado.update({
            'sucesso': resultado_execucao.get('sucesso', True),
            'regioes': resultado_execucao.get('regioes', 0),
            'alertas': resultado_execucao.get('alertas', 0),
            'erros': [f"{erro['regiao']}: {erro['erro']}" for erro in resultado_execucao.get('erros', [])]
        })

        logger.info(
            f"Execução do coletor {tipo} concluída: "
            f"{resultado['regioes']} regiões, {resultado['alertas']} alertas, "
            f"{len(resultado['erros'])} erros"
        )

    except Exception as e:
        resultado['sucesso'] = False
        resultado['erros'].append(f"Erro geral: {str(e)}")
        logger.error(f"Erro na execução do coletor {tipo}: {e}")

    finally:
        resultado['tempo_execucao'] = round(time.time() - inicio, 2)

        # Cleanup do coletor se necessário
        try:
            if hasattr(coletor, 'close'):
                await coletor.close()
        except:
            pass

    return resultado


async def _executar_coletor_job(tipo_fonte: str, db: DatabaseManager) -> None:
    """
    Job interno para execução automática de coletores.

    Args:
        tipo_fonte: Tipo da fonte (CLIMA, SAUDE, TENDENCIA, EVENTO)
        db: Instância do DatabaseManager
    """
    tipo_map = {
        'CLIMA': 'clima',
        'SAUDE': 'saude',
        'TENDENCIA': 'trends',
        'EVENTO': 'eventos'
    }

    tipo = tipo_map.get(tipo_fonte)
    if not tipo:
        logger.error(f"Tipo de fonte desconhecido: {tipo_fonte}")
        return

    try:
        resultado = await executar_coletor(tipo, db)

        if not resultado['sucesso'] or resultado['erros']:
            logger.warning(
                f"Coletor {tipo} executado com problemas: {resultado['erros']}"
            )
        else:
            logger.info(f"Coletor {tipo} executado com sucesso")

    except Exception as e:
        logger.error(f"Erro na execução agendada do coletor {tipo}: {e}")


def registrar_jobs(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra todos os jobs do módulo de compras.
    Consulta ia_arqfonteext para frequências configuradas.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        logger.info("Registrando jobs do módulo de compras...")

        # Buscar configurações das fontes no banco
        with db.session_scope() as session:
            fontes = session.query(FonteExterna).filter(
                FonteExterna.Ativo == True
            ).all()

            if not fontes:
                logger.warning("Nenhuma fonte externa ativa encontrada")
                return

        # Registrar job para cada fonte ativa
        coletores_disponiveis = {'CLIMA', 'SAUDE', 'TENDENCIA', 'EVENTO'}  # Todos implementados
        jobs_registrados = 0

        for fonte in fontes:
            try:
                # Verificar se o coletor está implementado
                if fonte.TipoFonte not in coletores_disponiveis:
                    logger.warning(f"Coletor {fonte.TipoFonte} ainda não implementado, ignorando job")
                    continue

                job_id = f"coletor_{fonte.TipoFonte.lower()}"

                # Criar função específica para esta fonte
                async def job_func(tipo_fonte=fonte.TipoFonte):
                    await _executar_coletor_job(tipo_fonte, db)

                # Adicionar job com intervalo configurado
                scheduler.add_job(
                    job_id=job_id,
                    func=job_func,
                    trigger='interval',
                    hours=fonte.Frequenc
                )

                jobs_registrados += 1
                logger.info(
                    f"Job '{job_id}' registrado: execução a cada {fonte.Frequenc}h"
                )

            except Exception as e:
                logger.error(f"Erro ao registrar job para fonte {fonte.NomeFonte}: {e}")

        logger.info(f"Jobs do módulo de compras registrados: {jobs_registrados} jobs ativos")

        # Registrar jobs de forecast
        registrar_jobs_forecast(scheduler, db)

        # Registrar jobs de classificação
        registrar_jobs_classificacao(scheduler, db)

        # Registrar jobs de fornecedor
        registrar_jobs_fornecedor(scheduler, db)

        # Registrar jobs de necessidades
        registrar_jobs_necessidades(scheduler, db)

        # Registrar jobs de integração (SmartPed/CoteFácil/ERP)
        registrar_jobs_integracao(scheduler, db)

        # Registrar jobs de manutenção
        registrar_jobs_manutencao(scheduler, db)

        # Registrar jobs de aprendizado
        registrar_jobs_aprendizado(scheduler, db)

    except Exception as e:
        logger.error(f"Erro ao registrar jobs do módulo de compras: {e}")


# Funções auxiliares para jobs específicos

async def job_limpeza_dados_antigos(db: DatabaseManager, dias_manter: int = 90) -> None:
    """
    Job para limpeza de dados antigos de coletas.

    Args:
        db: Instância do DatabaseManager
        dias_manter: Número de dias de dados para manter
    """
    try:
        from datetime import datetime, timedelta
        from .models import Coleta

        data_limite = datetime.now() - timedelta(days=dias_manter)

        with db.session_scope() as session:
            # Contar registros antigos
            count = session.query(Coleta).filter(
                Coleta.DatColeta < data_limite
            ).count()

            if count > 0:
                # Remover registros antigos
                deleted = session.query(Coleta).filter(
                    Coleta.DatColeta < data_limite
                ).delete()

                session.commit()

                logger.info(f"Limpeza concluída: {deleted} registros antigos removidos")
            else:
                logger.info("Nenhum registro antigo para limpeza")

    except Exception as e:
        logger.error(f"Erro na limpeza de dados antigos: {e}")


async def job_verificar_fontes_offline(db: DatabaseManager, horas_limite: int = 48) -> None:
    """
    Job para verificar fontes que estão há muito tempo sem coletar dados.

    Args:
        db: Instância do DatabaseManager
        horas_limite: Horas sem coleta para considerar fonte offline
    """
    try:
        from datetime import datetime, timedelta

        limite = datetime.now() - timedelta(hours=horas_limite)

        with db.session_scope() as session:
            fontes_offline = session.query(FonteExterna).filter(
                FonteExterna.Ativo == True,
                FonteExterna.DatUltCol < limite
            ).all()

            if fontes_offline:
                for fonte in fontes_offline:
                    logger.warning(
                        f"Fonte {fonte.NomeFonte} offline há "
                        f"{(datetime.now() - fonte.DatUltCol).total_seconds() / 3600:.1f} horas"
                    )

                    # Aqui você poderia implementar notificações
                    # ou tentativas de reconexão

            else:
                logger.info("Todas as fontes estão online")

    except Exception as e:
        logger.error(f"Erro ao verificar fontes offline: {e}")


def registrar_jobs_manutencao(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra jobs de manutenção do módulo.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        # Job de limpeza diária às 02:00
        async def job_limpeza():
            await job_limpeza_dados_antigos(db)

        scheduler.add_job(
            job_id="compras_limpeza_dados",
            func=job_limpeza,
            trigger='cron',
            hour=2,
            minute=0
        )

        # Job de verificação a cada 6 horas
        async def job_verificacao():
            await job_verificar_fontes_offline(db)

        scheduler.add_job(
            job_id="compras_verificar_fontes",
            func=job_verificacao,
            trigger='interval',
            hours=6
        )

        logger.info("Jobs de manutenção do módulo de compras registrados")

    except Exception as e:
        logger.error(f"Erro ao registrar jobs de manutenção: {e}")


# =============================================================================
# SISTEMA DE JOBS AUTOMÁTICOS DE FORECAST
# =============================================================================

async def salvar_forecast_cache(db: DatabaseManager, resultado_forecast: Dict, id_prod: int, id_filial: int, parametros) -> None:
    """
    Salva resultado do forecast no cache da tabela ia_arqforecast.

    Args:
        db: Instância do DatabaseManager
        resultado_forecast: Resultado completo do forecast
        id_prod: ID do produto
        id_filial: ID da filial
        parametros: Parâmetros usados no forecast
    """
    try:
        from datetime import datetime, timedelta
        import json

        with db.session_scope() as session:
            # 1. MARCAR REGISTROS ANTIGOS COMO SUBSTITUIDOS
            update_antigos = """
                UPDATE ia_arqforecast SET Status = 'SUBSTITUIDO'
                WHERE IDProd = :id_prod AND IDFilial = :id_filial
                  AND Status = 'ATIVO'
            """

            db.executar_query(update_antigos, {
                'id_prod': id_prod,
                'id_filial': id_filial
            })

            # 2. BUSCAR GRUPO DO PRODUTO
            query_grupo = """
                SELECT IDGrupo FROM arqproduto
                WHERE IDProd = :id_prod
            """

            grupo_result = db.executar_query(query_grupo, {'id_prod': id_prod})
            id_grupo = grupo_result[0]['IDGrupo'] if grupo_result else None

            # 3. EXTRAIR DADOS DO RESULTADO
            metricas = resultado_forecast.get('metricas', {})

            # Data de validade (7 dias a partir do cálculo)
            data_calculo = datetime.now()
            data_validade = (data_calculo + timedelta(days=7)).date()

            # Preparar JSONs para auditoria
            alertas_json = json.dumps(resultado_forecast.get('alertas', []))
            eventos_json = json.dumps(resultado_forecast.get('ajustes_aplicados', []))

            # Determinar qualidade dos dados
            confianca = resultado_forecast.get('confianca', 0)
            if confianca >= 80:
                qualidade = 'BOA'
            elif confianca >= 60:
                qualidade = 'MEDIA'
            elif confianca >= 30:
                qualidade = 'RUIM'
            else:
                qualidade = 'INSUFICIENTE'

            # Determinar tendência (simplificado)
            tendencia = 'ESTAVEL'  # Default
            if hasattr(metricas, 'tendencia'):
                tendencia_valor = metricas.get('tendencia', {}).get('direcao', 'estavel').upper()
                if tendencia_valor in ['CRESCENTE', 'ESTAVEL', 'DECRESCENTE']:
                    tendencia = tendencia_valor

            # 4. INSERIR NOVO REGISTRO
            insert_query = """
                INSERT INTO ia_arqforecast (
                    IDProd, IDFilial, IDGrupo, DatCalculo, DatValidade,
                    DiasHist, DiasCobreAlvo, TempoRepo,
                    ConsMedio, ConsDesvio, ConsCoefVar, Tendencia,
                    EstqAtual, EstqSegur, PontoPed, DiasCobre,
                    CenOtim, CenCons, CenCrit,
                    FatorAjuste, EventosJSON, AlertasJSON,
                    Confianca, QualidDados, RiscoRupt,
                    SazonalDetec, Status
                ) VALUES (
                    :id_prod, :id_filial, :id_grupo, :data_calculo, :data_validade,
                    :dias_hist, :dias_cobre_alvo, :tempo_repo,
                    :cons_medio, :cons_desvio, :cons_coef_var, :tendencia,
                    :estq_atual, :estq_segur, :ponto_ped, :dias_cobre,
                    :cen_otim, :cen_cons, :cen_crit,
                    :fator_ajuste, :eventos_json, :alertas_json,
                    :confianca, :qualid_dados, :risco_rupt,
                    :sazonal_detec, 'ATIVO'
                )
            """

            db.executar_query(insert_query, {
                'id_prod': id_prod,
                'id_filial': id_filial,
                'id_grupo': id_grupo,
                'data_calculo': data_calculo,
                'data_validade': data_validade,

                # Parâmetros
                'dias_hist': metricas.get('dias_historico', parametros.dias_historico_analise),
                'dias_cobre_alvo': parametros.dias_cobertura_alvo,
                'tempo_repo': parametros.tempo_reposicao_padrao,

                # Métricas de consumo
                'cons_medio': metricas.get('consumo_medio_diario', 0),
                'cons_desvio': metricas.get('desvio_padrao_diario', 0),
                'cons_coef_var': metricas.get('coef_variacao', 0),
                'tendencia': tendencia,

                # Estoque
                'estq_atual': metricas.get('estoque_atual', 0),
                'estq_segur': metricas.get('estoque_seguranca', 0),
                'ponto_ped': metricas.get('ponto_pedido', 0),
                'dias_cobre': metricas.get('dias_cobertura', 0),

                # Cenários
                'cen_otim': metricas.get('cen_otimista', 0),
                'cen_cons': metricas.get('cen_conservador', 0),
                'cen_crit': metricas.get('cen_critico', 0),

                # Ajustes
                'fator_ajuste': resultado_forecast.get('fator_ajuste', 1.0),
                'eventos_json': eventos_json,
                'alertas_json': alertas_json,

                # Qualidade
                'confianca': confianca,
                'qualid_dados': qualidade,
                'risco_rupt': metricas.get('risco_ruptura', 0),

                # Sazonalidade
                'sazonal_detec': 1 if resultado_forecast.get('sazonalidade_detectada', False) else 0
            })

            logger.debug(f"Cache forecast criado: produto {id_prod}, filial {id_filial}, validade {data_validade}")

    except Exception as e:
        logger.error(f"Erro ao salvar cache forecast para produto {id_prod}/filial {id_filial}: {e}")


async def job_atualizar_forecast_diario(db: DatabaseManager) -> Dict:
    """
    Job principal de atualização diária de forecast.
    Executa todos os dias às 4:00 AM.

    Estratégia de processamento:
    1. Produtos críticos primeiro (baixo estoque, alto risco)
    2. Amostragem inteligente para produtos normais
    3. Cache de resultados na ia_arqforecast
    4. Logs detalhados de performance

    Args:
        db: Instância do DatabaseManager

    Returns:
        Dict com resultado da execução
    """
    inicio = time.time()
    resultado = {
        'sucesso': True,
        'produtos_processados': 0,
        'produtos_criticos': 0,
        'produtos_amostra': 0,
        'erros': [],
        'tempo_execucao': None,
        'filiais_processadas': set()
    }

    try:
        from .processadores.forecast import ForecastEngine
        from .processadores.metricas import ParametrosForecast

        logger.info("=== INICIANDO JOB FORECAST DIÁRIO ===")

        engine = ForecastEngine(db)
        parametros = ParametrosForecast(
            dias_cobertura_alvo=30,
            nivel_servico=0.95
        )

        # FASE 1: Identificar produtos críticos
        query_criticos = """
            SELECT DISTINCT
                pl.IDProd,
                pl.IDFilial,
                p.Despro as produto_nome,
                f.Nomfil as filial_nome,
                pl.QtdLote as estoque_atual,
                COALESCE(fc.DiasCobre, 0) as dias_cobertura_cache,
                COALESCE(fc.RiscoRupt, 0) as risco_ruptura_cache
            FROM arqprodutolot pl
            INNER JOIN arqproduto p ON p.IDProd = pl.IDProd
            INNER JOIN arqfilial f ON f.IDFilial = pl.IDFilial
            LEFT JOIN ia_arqforecast fc ON fc.IDProd = pl.IDProd
                AND fc.IDFilial = pl.IDFilial
                AND fc.Status = 'ATIVO'
            WHERE p.Ativo = '1'       -- Produtos ativos
              AND f.IndAtivo = 1      -- Filiais ativas
              AND (
                  pl.QtdLote <= 10                    -- Estoque muito baixo
                  OR COALESCE(fc.DiasCobre, 0) <= 7   -- Cobertura crítica
                  OR COALESCE(fc.RiscoRupt, 0) > 0.3   -- Alto risco ruptura
                  OR fc.DatCalculo IS NULL           -- Nunca calculado
                  OR fc.DatValidade < CURDATE()      -- Expirado
                  OR fc.DatCalculo < DATE_SUB(NOW(), INTERVAL 7 DAY)  -- Desatualizado
              )
            ORDER BY
                COALESCE(fc.RiscoRupt, 1) DESC,  -- Maior risco primeiro
                pl.QtdLote ASC,                     -- Menor estoque primeiro
                COALESCE(fc.DatCalculo, '1970-01-01') ASC  -- Mais desatualizado primeiro
            LIMIT 500  -- Máximo 500 produtos críticos por execução
        """

        produtos_criticos = db.executar_query(query_criticos)
        logger.info(f"Encontrados {len(produtos_criticos)} produtos críticos para processamento")

        # Processar produtos críticos
        for produto in produtos_criticos:
            try:
                id_prod = produto['IDProd']
                id_filial = produto['IDFilial']

                resultado_forecast = await engine.gerar_forecast(
                    id_prod=id_prod,
                    id_filial=id_filial,
                    parametros=parametros
                )

                # Salvar no cache
                await salvar_forecast_cache(
                    db,
                    resultado_forecast.__dict__ if hasattr(resultado_forecast, '__dict__') else resultado_forecast,
                    id_prod,
                    id_filial,
                    parametros
                )

                resultado['produtos_processados'] += 1
                resultado['produtos_criticos'] += 1
                resultado['filiais_processadas'].add(id_filial)

                if resultado['produtos_criticos'] % 50 == 0:
                    logger.info(f"Processados {resultado['produtos_criticos']} produtos críticos...")

            except Exception as e:
                erro_msg = f"Produto {produto['IDProd']}/Filial {produto['IDFilial']}: {str(e)}"
                resultado['erros'].append(erro_msg)
                logger.warning(f"Erro ao processar produto crítico: {erro_msg}")

        # FASE 2: Amostragem inteligente para produtos normais
        # Processar 20% dos produtos restantes por filial
        query_amostragem = """
            SELECT DISTINCT
                pl.IDProd,
                pl.IDFilial,
                p.Despro as produto_nome
            FROM arqprodutolot pl
            INNER JOIN arqproduto p ON p.IDProd = pl.IDProd
            INNER JOIN arqfilial f ON f.IDFilial = pl.IDFilial
            LEFT JOIN ia_arqforecast fc ON fc.IDProd = pl.IDProd
                AND fc.IDFilial = pl.IDFilial
                AND fc.Status = 'ATIVO'
            WHERE p.Ativo = '1'       -- Produtos ativos
              AND f.IndAtivo = 1      -- Filiais ativas
              AND pl.QtdLote > 10
              AND COALESCE(fc.DiasCobre, 999) > 7
              AND COALESCE(fc.RiscoRupt, 0) <= 0.3
              AND (fc.DatCalculo IS NULL
                   OR fc.DatValidade < CURDATE()
                   OR fc.DatCalculo < DATE_SUB(NOW(), INTERVAL 30 DAY))
            ORDER BY RAND()  -- Amostragem aleatória
            LIMIT 200  -- Máximo 200 produtos de amostra por execução
        """

        produtos_amostra = db.executar_query(query_amostragem)
        logger.info(f"Selecionados {len(produtos_amostra)} produtos para amostragem")

        # Processar amostra de produtos normais
        for produto in produtos_amostra:
            try:
                id_prod = produto['IDProd']
                id_filial = produto['IDFilial']

                resultado_forecast = await engine.gerar_forecast(
                    id_prod=id_prod,
                    id_filial=id_filial,
                    parametros=parametros
                )

                # Salvar no cache
                await salvar_forecast_cache(
                    db,
                    resultado_forecast.__dict__ if hasattr(resultado_forecast, '__dict__') else resultado_forecast,
                    id_prod,
                    id_filial,
                    parametros
                )

                resultado['produtos_processados'] += 1
                resultado['produtos_amostra'] += 1
                resultado['filiais_processadas'].add(id_filial)

            except Exception as e:
                erro_msg = f"Produto {produto['IDProd']}/Filial {produto['IDFilial']}: {str(e)}"
                resultado['erros'].append(erro_msg)
                logger.warning(f"Erro ao processar produto amostra: {erro_msg}")

        # FASE 3: Estatísticas finais
        tempo_execucao = time.time() - inicio
        resultado['tempo_execucao'] = round(tempo_execucao, 2)
        resultado['filiais_processadas'] = len(resultado['filiais_processadas'])

        # Log resumo
        logger.info(
            f"=== JOB FORECAST CONCLUÍDO ===\n"
            f"Produtos processados: {resultado['produtos_processados']}\n"
            f"- Críticos: {resultado['produtos_criticos']}\n"
            f"- Amostra: {resultado['produtos_amostra']}\n"
            f"Filiais: {resultado['filiais_processadas']}\n"
            f"Erros: {len(resultado['erros'])}\n"
            f"Tempo: {resultado['tempo_execucao']}s"
        )

        if resultado['erros']:
            logger.warning(f"Erros durante execução: {resultado['erros'][:5]}")  # Só os primeiros 5

    except Exception as e:
        resultado['sucesso'] = False
        erro_msg = f"Erro geral no job forecast: {str(e)}"
        resultado['erros'].append(erro_msg)
        logger.error(erro_msg)

    return resultado


async def job_expirar_forecasts_antigos(db: DatabaseManager) -> None:
    """
    Job para marcar forecasts expirados com base na DatValidade.
    """
    try:
        # Marcar como EXPIRADO os registros que passaram da validade
        query_expirar = """
            UPDATE ia_arqforecast
            SET Status = 'EXPIRADO'
            WHERE Status = 'ATIVO'
              AND DatValidade < CURDATE()
        """

        resultado = db.executar_query(query_expirar)
        logger.info(f"Forecasts expirados marcados")

    except Exception as e:
        logger.error(f"Erro ao expirar forecasts antigos: {e}")


async def job_limpeza_forecast_antigo(db: DatabaseManager, dias_manter: int = 180) -> None:
    """
    Job para limpeza física de cache de forecast muito antigo.

    Args:
        db: Instância do DatabaseManager
        dias_manter: Dias de cache para manter (padrão: 180 dias)
    """
    try:
        from datetime import datetime, timedelta

        data_limite = datetime.now() - timedelta(days=dias_manter)

        # Remover registros muito antigos fisicamente
        query_limpeza = """
            DELETE FROM ia_arqforecast
            WHERE DatCalculo < :data_limite
              AND Status IN ('EXPIRADO', 'SUBSTITUIDO')
        """

        resultado = db.executar_query(query_limpeza, {'data_limite': data_limite})
        linhas_removidas = resultado if isinstance(resultado, int) else 0

        logger.info(f"Limpeza forecast: {linhas_removidas} registros antigos removidos")

    except Exception as e:
        logger.error(f"Erro na limpeza de forecast antigo: {e}")


def registrar_jobs_forecast(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra jobs específicos do sistema de forecast.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        logger.info("Registrando jobs do sistema de forecast...")

        # Job principal de forecast diário às 04:00
        async def job_forecast_diario():
            # 1. Expirar forecasts antigos primeiro
            await job_expirar_forecasts_antigos(db)

            # 2. Executar cálculo de forecast
            resultado = await job_atualizar_forecast_diario(db)

            # Notificar em caso de muitos erros
            if not resultado['sucesso'] or len(resultado['erros']) > 50:
                logger.error(f"Job forecast com muitos problemas: {resultado}")

        scheduler.add_job(
            job_id="forecast_diario",
            func=job_forecast_diario,
            trigger='cron',
            hour=4,  # 04:00 AM
            minute=0,
            misfire_grace_time=7200  # 2 horas de tolerância se sistema estiver offline
        )

        # Job de limpeza semanal às 03:00 de domingo
        async def job_limpeza_forecast():
            await job_limpeza_forecast_antigo(db)

        scheduler.add_job(
            job_id="forecast_limpeza",
            func=job_limpeza_forecast,
            trigger='cron',
            day_of_week=6,  # Domingo
            hour=3,
            minute=0
        )

        logger.info("Jobs do sistema de forecast registrados com sucesso")

    except Exception as e:
        logger.error(f"Erro ao registrar jobs de forecast: {e}")


# =============================================================================
# JOB ALTERNATIVO DE FORECAST (CONFORME ESPECIFICAÇÃO)
# =============================================================================

def job_atualizar_forecast():
    """
    Job diário para atualizar forecasts.

    Executa às 4h da manhã:
    1. Marca forecasts expirados
    2. Recalcula produtos críticos (abaixo ponto pedido)
    3. Recalcula produtos com eventos/alertas ativos
    """

    from core.database import DatabaseFactory
    from config import settings

    logger.info("=" * 50)
    logger.info("Iniciando atualização diária de forecast")
    logger.info("=" * 50)

    db = DatabaseFactory.create_from_config(settings)
    db.connect()

    try:
        from .processadores import ForecastRepositorio, ForecastEngine

        repositorio = ForecastRepositorio(db)
        engine = ForecastEngine(db)

        # 1. Marca expirados
        expirados = repositorio.marcar_expirados()
        logger.info(f"Forecasts expirados: {expirados}")

        # 2. Busca filiais ativas
        filiais = db.execute_query("SELECT IDFilial FROM arqfilial WHERE Ativo = '1'")

        total_processados = 0
        total_criticos = 0

        for filial in filiais:
            id_filial = filial['IDFilial']
            logger.info(f"Processando filial {id_filial}")

            try:
                # Recalcula produtos críticos
                resultados = engine.gerar_forecast_filial(
                    id_filial=id_filial,
                    apenas_criticos=True,
                    limite=500,
                    salvar=True
                )

                total_processados += len(resultados)
                total_criticos += sum(1 for r in resultados if r.metricas.risco_ruptura > 0.3)

                logger.info(f"Filial {id_filial}: {len(resultados)} produtos processados")

            except Exception as e:
                logger.error(f"Erro na filial {id_filial}: {e}")

        # 3. Limpa histórico antigo (opcional)
        removidos = repositorio.limpar_historico(dias_manter=90)

        logger.info("=" * 50)
        logger.info(f"Forecast diário concluído:")
        logger.info(f"  - Expirados: {expirados}")
        logger.info(f"  - Processados: {total_processados}")
        logger.info(f"  - Com risco alto: {total_criticos}")
        logger.info(f"  - Histórico removido: {removidos}")
        logger.info("=" * 50)

    except Exception as e:
        logger.error(f"Erro no job de forecast: {e}")
        raise

    finally:
        db.disconnect()


def registrar_jobs_alternativos(scheduler, db):
    """
    Registra todos os jobs do módulo de compras (versão alternativa).
    """

    # Jobs dos coletores (existentes)
    from .coletores import ColetorClima, ColetorSaude, ColetorTrends, ColetorEventos

    coletores = {
        'CLIMA': ColetorClima(db),
        'SAUDE': ColetorSaude(db),
        'TENDENCIA': ColetorTrends(db),
        'EVENTO': ColetorEventos(db)
    }

    for tipo, coletor in coletores.items():
        try:
            fonte = coletor.obter_fonte()
            if fonte and fonte.get('Ativo'):
                scheduler.add_job(
                    job_id=f"coletor_{tipo.lower()}",
                    func=coletor.executar,
                    trigger='interval',
                    hours=fonte.get('Frequenc', 24)
                )
                logger.info(f"Job registrado: coletor_{tipo.lower()}")
        except Exception as e:
            logger.warning(f"Erro ao registrar coletor {tipo}: {e}")

    # Job de forecast diário (4h da manhã)
    scheduler.add_job(
        job_id="forecast_diario",
        func=job_atualizar_forecast,
        trigger='cron',
        hour=4,
        minute=0
    )
    logger.info("Job registrado: forecast_diario (4:00)")

    # Job de limpeza semanal (domingo 3h)
    scheduler.add_job(
        job_id="limpeza_semanal",
        func=lambda: ForecastRepositorio(db).limpar_historico(90),
        trigger='cron',
        day_of_week='sun',
        hour=3,
        minute=0
    )
    logger.info("Job registrado: limpeza_semanal (dom 3:00)")


# =============================================================================
# SISTEMA DE JOBS AUTOMÁTICOS DE CLASSIFICAÇÃO
# =============================================================================

async def job_classificar_produtos(db: DatabaseManager) -> Dict:
    """
    Job principal de classificação de produtos.
    Executa todos os dias às 5:00 AM.

    Estratégia de processamento:
    1. Processar todas as filiais ativas
    2. Classificar todos os produtos com giro nos últimos 90 dias
    3. Salvar resultados na ia_arqprodclas
    4. Logs detalhados de performance

    Args:
        db: Instância do DatabaseManager

    Returns:
        Dict com resultado da execução
    """
    inicio = time.time()
    resultado = {
        'sucesso': True,
        'produtos_processados': 0,
        'saudaveis': 0,
        'atencao': 0,
        'toxicos': 0,
        'filiais_processadas': 0,
        'erros': [],
        'tempo_execucao': None
    }

    try:
        from .processadores import ClassificadorProdutos, ClassificacaoRepositorio, ParametrosClassificacao

        logger.info("=== INICIANDO JOB CLASSIFICAÇÃO DIÁRIO ===")

        parametros = ParametrosClassificacao()
        classificador = ClassificadorProdutos(db, parametros)
        repositorio = ClassificacaoRepositorio(db)

        # 1. Buscar filiais ativas
        query_filiais = """
            SELECT IDFilial, Nomfil FROM arqfilial
            WHERE IndAtivo = 1
            ORDER BY IDFilial
        """
        filiais = db.execute_query(query_filiais)

        if not filiais:
            logger.warning("Nenhuma filial ativa encontrada")
            resultado['sucesso'] = False
            resultado['erros'].append("Nenhuma filial ativa encontrada")
            return resultado

        logger.info(f"Encontradas {len(filiais)} filiais ativas")

        # 2. Processar cada filial
        for filial in filiais:
            id_filial = filial['IDFilial']
            nome_filial = filial['Nomfil']

            try:
                logger.info(f"Processando filial {id_filial}: {nome_filial}")

                # Classificar todos os produtos ativos da filial
                resultados_filial = await classificador.classificar_filial(
                    id_filial=id_filial,
                    apenas_ativos=True,
                    limite=5000  # Limite alto para processamento batch
                )

                if not resultados_filial:
                    logger.warning(f"Filial {id_filial}: nenhum produto para classificar")
                    continue

                # Salvar em lote
                salvos = await repositorio.salvar_lote(resultados_filial, dias_validade=7)

                # Contabilizar
                saudaveis = sum(1 for r in resultados_filial if r.classificacao.value == 'SAUDAVEL')
                atencao = sum(1 for r in resultados_filial if r.classificacao.value == 'ATENCAO')
                toxicos = sum(1 for r in resultados_filial if r.classificacao.value == 'TOXICO')

                resultado['produtos_processados'] += len(resultados_filial)
                resultado['saudaveis'] += saudaveis
                resultado['atencao'] += atencao
                resultado['toxicos'] += toxicos
                resultado['filiais_processadas'] += 1

                logger.info(
                    f"Filial {id_filial}: {len(resultados_filial)} produtos classificados - "
                    f"Saudáveis: {saudaveis}, Atenção: {atencao}, Tóxicos: {toxicos}"
                )

            except Exception as e:
                erro_msg = f"Filial {id_filial}: {str(e)}"
                resultado['erros'].append(erro_msg)
                logger.error(f"Erro ao processar filial: {erro_msg}")

        # 3. Estatísticas finais
        tempo_execucao = time.time() - inicio
        resultado['tempo_execucao'] = round(tempo_execucao, 2)

        # Log resumo
        logger.info(
            f"=== JOB CLASSIFICAÇÃO CONCLUÍDO ===\n"
            f"Produtos processados: {resultado['produtos_processados']}\n"
            f"- Saudáveis: {resultado['saudaveis']}\n"
            f"- Atenção: {resultado['atencao']}\n"
            f"- Tóxicos: {resultado['toxicos']}\n"
            f"Filiais: {resultado['filiais_processadas']}\n"
            f"Erros: {len(resultado['erros'])}\n"
            f"Tempo: {resultado['tempo_execucao']}s"
        )

        if resultado['erros']:
            logger.warning(f"Erros durante execução: {resultado['erros'][:5]}")

    except Exception as e:
        resultado['sucesso'] = False
        erro_msg = f"Erro geral no job classificação: {str(e)}"
        resultado['erros'].append(erro_msg)
        logger.error(erro_msg)

    return resultado


async def job_expirar_classificacoes_antigas(db: DatabaseManager) -> int:
    """
    Job para marcar classificações expiradas com base na DatValidade.

    Args:
        db: Instância do DatabaseManager

    Returns:
        Número de registros expirados
    """
    try:
        query_expirar = """
            UPDATE ia_arqprodclas
            SET Status = 'EXPIRADO'
            WHERE Status = 'ATIVO'
              AND DatValidade < CURDATE()
        """

        db.execute_query(query_expirar)
        logger.info("Classificações expiradas marcadas")
        return 0  # Não temos acesso ao rowcount via execute_query

    except Exception as e:
        logger.error(f"Erro ao expirar classificações antigas: {e}")
        return 0


async def job_limpeza_classificacao_antiga(db: DatabaseManager, dias_manter: int = 180) -> int:
    """
    Job para limpeza física de classificações muito antigas.

    Args:
        db: Instância do DatabaseManager
        dias_manter: Dias de classificações para manter (padrão: 180 dias)

    Returns:
        Número de registros removidos
    """
    try:
        from datetime import datetime, timedelta

        data_limite = datetime.now() - timedelta(days=dias_manter)

        query_limpeza = """
            DELETE FROM ia_arqprodclas
            WHERE DatCalculo < :data_limite
              AND Status IN ('EXPIRADO', 'SUBSTITUIDO')
        """

        db.execute_query(query_limpeza, {'data_limite': data_limite})
        logger.info(f"Limpeza classificação: registros antigos removidos")
        return 0

    except Exception as e:
        logger.error(f"Erro na limpeza de classificação antiga: {e}")
        return 0


def registrar_jobs_classificacao(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra jobs específicos do sistema de classificação.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        logger.info("Registrando jobs do sistema de classificação...")

        # Job principal de classificação diária às 05:00
        async def job_classificacao_diaria():
            # 1. Expirar classificações antigas primeiro
            await job_expirar_classificacoes_antigas(db)

            # 2. Executar classificação
            resultado = await job_classificar_produtos(db)

            # Notificar em caso de muitos erros
            if not resultado['sucesso'] or len(resultado['erros']) > 10:
                logger.error(f"Job classificação com problemas: {resultado}")

        scheduler.add_job(
            job_id="classificacao_diaria",
            func=job_classificacao_diaria,
            trigger='cron',
            hour=5,  # 05:00 AM (após o forecast das 04:00)
            minute=0,
            misfire_grace_time=7200  # 2 horas de tolerância
        )

        # Job de limpeza mensal (primeiro domingo do mês às 03:30)
        async def job_limpeza_classificacao():
            await job_limpeza_classificacao_antiga(db)

        scheduler.add_job(
            job_id="classificacao_limpeza",
            func=job_limpeza_classificacao,
            trigger='cron',
            day=1,  # Dia 1 do mês
            hour=3,
            minute=30
        )

        logger.info("Jobs do sistema de classificação registrados com sucesso")

    except Exception as e:
        logger.error(f"Erro ao registrar jobs de classificação: {e}")


# =============================================================================
# SISTEMA DE JOBS AUTOMÁTICOS DE SCORE DE FORNECEDORES
# =============================================================================

async def job_calcular_scores_fornecedores(db: DatabaseManager) -> Dict:
    """
    Job principal de cálculo de scores de fornecedores.
    Executa todos os dias às 06:00 AM.

    Estratégia de processamento:
    1. Processar todas as filiais ativas
    2. Analisar fornecedores com compras nos últimos 180 dias
    3. Salvar resultados na ia_arqfornscor
    4. Logs detalhados de performance

    Args:
        db: Instância do DatabaseManager

    Returns:
        Dict com resultado da execução
    """
    inicio = time.time()
    resultado = {
        'sucesso': True,
        'fornecedores_processados': 0,
        'excelentes': 0,
        'bons': 0,
        'regulares': 0,
        'ruins': 0,
        'criticos': 0,
        'filiais_processadas': 0,
        'erros': [],
        'tempo_execucao': None
    }

    try:
        from .processadores import AnalisadorFornecedor, FornecedorScoreRepositorio

        logger.info("=== INICIANDO JOB SCORE FORNECEDORES ===")

        analisador = AnalisadorFornecedor(db)
        repositorio = FornecedorScoreRepositorio(db)

        # 1. Buscar filiais ativas
        query_filiais = """
            SELECT IDFilial, Nomfil FROM arqfilial
            WHERE IndAtivo = 1
            ORDER BY IDFilial
        """
        filiais = db.execute_query(query_filiais)

        if not filiais:
            logger.warning("Nenhuma filial ativa encontrada")
            resultado['sucesso'] = False
            resultado['erros'].append("Nenhuma filial ativa encontrada")
            return resultado

        logger.info(f"Encontradas {len(filiais)} filiais ativas")

        # 2. Processar cada filial
        for filial in filiais:
            id_filial = filial['IDFilial']
            nome_filial = filial['Nomfil']

            try:
                logger.info(f"Processando filial {id_filial}: {nome_filial}")

                # Buscar fornecedores ativos da filial
                fornecedores = analisador.listar_fornecedores_ativos(
                    id_filial=id_filial,
                    dias=180,
                    limite=200  # Limite por filial
                )

                if not fornecedores:
                    logger.warning(f"Filial {id_filial}: nenhum fornecedor ativo encontrado")
                    continue

                logger.info(f"Filial {id_filial}: {len(fornecedores)} fornecedores para processar")

                # Processar cada fornecedor
                for forn in fornecedores:
                    try:
                        resultado_score = analisador.analisar(
                            cnpj_forn=forn['cnpj'],
                            id_filial=id_filial,
                            dias=180
                        )

                        # Salvar no repositório
                        await repositorio.salvar(resultado_score, dias_validade=30)

                        # Contabilizar por classificação
                        resultado['fornecedores_processados'] += 1
                        classif = resultado_score.classificacao.value
                        if classif == 'EXCELENTE':
                            resultado['excelentes'] += 1
                        elif classif == 'BOM':
                            resultado['bons'] += 1
                        elif classif == 'REGULAR':
                            resultado['regulares'] += 1
                        elif classif == 'RUIM':
                            resultado['ruins'] += 1
                        elif classif == 'CRITICO':
                            resultado['criticos'] += 1

                    except Exception as e:
                        erro_msg = f"Fornecedor {forn['cnpj']}/Filial {id_filial}: {str(e)}"
                        resultado['erros'].append(erro_msg)
                        logger.warning(f"Erro ao processar fornecedor: {erro_msg}")

                resultado['filiais_processadas'] += 1

                logger.info(
                    f"Filial {id_filial}: {len(fornecedores)} fornecedores processados"
                )

            except Exception as e:
                erro_msg = f"Filial {id_filial}: {str(e)}"
                resultado['erros'].append(erro_msg)
                logger.error(f"Erro ao processar filial: {erro_msg}")

        # 3. Estatísticas finais
        tempo_execucao = time.time() - inicio
        resultado['tempo_execucao'] = round(tempo_execucao, 2)

        # Log resumo
        logger.info(
            f"=== JOB SCORE FORNECEDORES CONCLUÍDO ===\n"
            f"Fornecedores processados: {resultado['fornecedores_processados']}\n"
            f"- Excelentes: {resultado['excelentes']}\n"
            f"- Bons: {resultado['bons']}\n"
            f"- Regulares: {resultado['regulares']}\n"
            f"- Ruins: {resultado['ruins']}\n"
            f"- Críticos: {resultado['criticos']}\n"
            f"Filiais: {resultado['filiais_processadas']}\n"
            f"Erros: {len(resultado['erros'])}\n"
            f"Tempo: {resultado['tempo_execucao']}s"
        )

        if resultado['erros']:
            logger.warning(f"Erros durante execução: {resultado['erros'][:5]}")

    except Exception as e:
        resultado['sucesso'] = False
        erro_msg = f"Erro geral no job score fornecedores: {str(e)}"
        resultado['erros'].append(erro_msg)
        logger.error(erro_msg)

    return resultado


async def job_expirar_scores_fornecedores(db: DatabaseManager) -> int:
    """
    Job para marcar scores de fornecedores expirados com base na DatValidade.

    Args:
        db: Instância do DatabaseManager

    Returns:
        Número de registros expirados
    """
    try:
        query_expirar = """
            UPDATE ia_arqfornscor
            SET Status = 'EXPIRADO'
            WHERE Status = 'ATIVO'
              AND DatValidade < CURDATE()
        """

        db.execute_query(query_expirar)
        logger.info("Scores de fornecedores expirados marcados")
        return 0

    except Exception as e:
        logger.error(f"Erro ao expirar scores de fornecedores: {e}")
        return 0


async def job_limpeza_scores_fornecedores(db: DatabaseManager, dias_manter: int = 365) -> int:
    """
    Job para limpeza física de scores de fornecedores muito antigos.

    Args:
        db: Instância do DatabaseManager
        dias_manter: Dias de scores para manter (padrão: 365 dias)

    Returns:
        Número de registros removidos
    """
    try:
        from datetime import datetime, timedelta

        data_limite = datetime.now() - timedelta(days=dias_manter)

        query_limpeza = """
            DELETE FROM ia_arqfornscor
            WHERE DatCalculo < :data_limite
              AND Status IN ('EXPIRADO', 'SUBSTITUIDO')
        """

        db.execute_query(query_limpeza, {'data_limite': data_limite})
        logger.info(f"Limpeza scores fornecedores: registros antigos removidos")
        return 0

    except Exception as e:
        logger.error(f"Erro na limpeza de scores de fornecedores: {e}")
        return 0


async def job_alertar_fornecedores_criticos(db: DatabaseManager) -> Dict:
    """
    Job para gerar alertas sobre fornecedores críticos.
    Identifica fornecedores com score baixo e tendência de piora.

    Args:
        db: Instância do DatabaseManager

    Returns:
        Dict com fornecedores críticos identificados
    """
    try:
        # Buscar fornecedores críticos ou em deterioração
        query_criticos = """
            SELECT
                f.CNPJForn,
                f.NomeForn,
                f.IDFilial,
                fil.Nomfil,
                f.ScoreGeral,
                f.Classificacao,
                f.Tendencia,
                f.ScoreAnterior,
                f.VarScore,
                f.AlertasJSON
            FROM ia_arqfornscor f
            INNER JOIN arqfilial fil ON fil.IDFilial = f.IDFilial
            WHERE f.Status = 'ATIVO'
              AND (
                  f.Classificacao IN ('CRITICO', 'RUIM')
                  OR (f.Tendencia = 'PIORANDO' AND f.VarScore < -10)
              )
            ORDER BY f.ScoreGeral ASC
            LIMIT 50
        """

        criticos = db.execute_query(query_criticos)

        if criticos:
            logger.warning(
                f"ALERTA: {len(criticos)} fornecedores críticos identificados!\n"
                f"Fornecedores mais críticos:\n" +
                "\n".join([
                    f"  - {c['NomeForn']} ({c['CNPJForn']}): Score {c['ScoreGeral']}, "
                    f"Classificação: {c['Classificacao']}, Tendência: {c['Tendencia']}"
                    for c in criticos[:10]
                ])
            )

        return {
            'total_criticos': len(criticos) if criticos else 0,
            'fornecedores': criticos or []
        }

    except Exception as e:
        logger.error(f"Erro ao buscar fornecedores críticos: {e}")
        return {'total_criticos': 0, 'fornecedores': [], 'erro': str(e)}


async def job_analisar_fornecedores(db: DatabaseManager) -> Dict:
    """
    Job mensal para análise completa de todos os fornecedores.

    Diferente do job diário de score, este job:
    - Executa análise completa (não apenas atualização de scores)
    - Usa método analisar_todos_fornecedores() do AnalisadorFornecedor
    - Persiste resultados com salvar=True
    - Processa todas as filiais ativas

    Execução: Dia 1 de cada mês às 06:00.

    Args:
        db: Instância do DatabaseManager

    Returns:
        Dict com resultado da execução
    """
    inicio = time.time()
    resultado = {
        'sucesso': True,
        'filiais_processadas': 0,
        'total_fornecedores': 0,
        'distribuicao': {
            'excelentes': 0,
            'bons': 0,
            'regulares': 0,
            'ruins': 0,
            'criticos': 0
        },
        'erros': [],
        'tempo_execucao': None
    }

    try:
        from .processadores.fornecedor import AnalisadorFornecedor, ParametrosScoreFornecedor

        logger.info("=== INICIANDO JOB ANÁLISE MENSAL DE FORNECEDORES ===")

        analisador = AnalisadorFornecedor(db)
        parametros = ParametrosScoreFornecedor()  # Parâmetros padrão

        # Buscar filiais ativas
        query_filiais = """
            SELECT IDFilial, NomeFilial
            FROM arqfilial
            WHERE Ativo = 1
            ORDER BY IDFilial
        """
        filiais = db.executar_query(query_filiais) or []

        if not filiais:
            logger.warning("Nenhuma filial ativa encontrada")
            resultado['erros'].append("Nenhuma filial ativa")
            return resultado

        # Processar cada filial
        for filial in filiais:
            id_filial = filial['IDFilial']
            nome_filial = filial.get('NomeFilial', f'Filial {id_filial}')

            try:
                logger.info(f"Processando filial {id_filial}: {nome_filial}")

                # Análise completa com persistência
                resultados_filial = analisador.analisar_todos_fornecedores(
                    id_filial=id_filial,
                    parametros=parametros,
                    salvar=True
                )

                resultado['filiais_processadas'] += 1
                resultado['total_fornecedores'] += len(resultados_filial)

                # Contabilizar distribuição
                for res in resultados_filial:
                    classificacao = res.classificacao.value
                    if classificacao == 'EXCELENTE':
                        resultado['distribuicao']['excelentes'] += 1
                    elif classificacao == 'BOM':
                        resultado['distribuicao']['bons'] += 1
                    elif classificacao == 'REGULAR':
                        resultado['distribuicao']['regulares'] += 1
                    elif classificacao == 'RUIM':
                        resultado['distribuicao']['ruins'] += 1
                    elif classificacao == 'CRITICO':
                        resultado['distribuicao']['criticos'] += 1

                logger.info(
                    f"Filial {id_filial} concluída: {len(resultados_filial)} fornecedores"
                )

            except Exception as e:
                erro_msg = f"Filial {id_filial}: {str(e)}"
                resultado['erros'].append(erro_msg)
                logger.error(f"Erro na análise da filial {id_filial}: {e}")

        # Resumo final
        logger.info(
            f"=== JOB ANÁLISE MENSAL CONCLUÍDO ===\n"
            f"Filiais: {resultado['filiais_processadas']}\n"
            f"Fornecedores: {resultado['total_fornecedores']}\n"
            f"Distribuição: {resultado['distribuicao']}\n"
            f"Erros: {len(resultado['erros'])}"
        )

    except Exception as e:
        resultado['sucesso'] = False
        resultado['erros'].append(f"Erro geral: {str(e)}")
        logger.error(f"Erro no job de análise mensal de fornecedores: {e}")

    finally:
        resultado['tempo_execucao'] = round(time.time() - inicio, 2)

    return resultado


def registrar_jobs_fornecedor(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra jobs específicos do sistema de score de fornecedores.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        logger.info("Registrando jobs do sistema de score de fornecedores...")

        # Job principal de score de fornecedores às 06:00 (após forecast e classificação)
        async def job_fornecedor_diario():
            # 1. Expirar scores antigos primeiro
            await job_expirar_scores_fornecedores(db)

            # 2. Executar cálculo de scores
            resultado = await job_calcular_scores_fornecedores(db)

            # 3. Alertar sobre fornecedores críticos
            await job_alertar_fornecedores_criticos(db)

            # Notificar em caso de muitos erros
            if not resultado['sucesso'] or len(resultado['erros']) > 20:
                logger.error(f"Job score fornecedores com problemas: {resultado}")

        scheduler.add_job(
            job_id="fornecedor_score_diario",
            func=job_fornecedor_diario,
            trigger='cron',
            hour=6,  # 06:00 AM (após forecast 04:00 e classificação 05:00)
            minute=0,
            misfire_grace_time=7200  # 2 horas de tolerância
        )

        # Job de limpeza trimestral (primeiro dia de cada trimestre às 03:45)
        async def job_limpeza_fornecedor():
            await job_limpeza_scores_fornecedores(db)

        scheduler.add_job(
            job_id="fornecedor_limpeza",
            func=job_limpeza_fornecedor,
            trigger='cron',
            month='1,4,7,10',  # Janeiro, Abril, Julho, Outubro
            day=1,
            hour=3,
            minute=45
        )

        # Job semanal de alerta de fornecedores críticos (segunda-feira às 08:00)
        async def job_alerta_fornecedor():
            await job_alertar_fornecedores_criticos(db)

        scheduler.add_job(
            job_id="fornecedor_alerta_semanal",
            func=job_alerta_fornecedor,
            trigger='cron',
            day_of_week='mon',
            hour=8,
            minute=0
        )

        # Job mensal de análise completa (dia 1 de cada mês às 06:00)
        async def job_analise_mensal_fornecedor():
            resultado = await job_analisar_fornecedores(db)
            if not resultado['sucesso']:
                logger.error(f"Job análise mensal fornecedores falhou: {resultado['erros']}")

        scheduler.add_job(
            job_id="fornecedor_analise_mensal",
            func=job_analise_mensal_fornecedor,
            trigger='cron',
            day=1,  # Primeiro dia de cada mês
            hour=6,
            minute=0,
            misfire_grace_time=14400  # 4 horas de tolerância
        )

        logger.info("Jobs do sistema de score de fornecedores registrados com sucesso")

    except Exception as e:
        logger.error(f"Erro ao registrar jobs de fornecedor: {e}")


# =============================================================================
# SISTEMA DE JOBS AUTOMÁTICOS DE NECESSIDADES DE COMPRA
# =============================================================================

async def job_gerar_necessidades(db: DatabaseManager) -> Dict:
    """
    Job diário para gerar necessidades de compra.
    Executa todos os dias às 06:30 AM (após forecast, classificação e score de fornecedor).

    Estratégia de processamento:
    1. Processar todas as filiais ativas
    2. Gerar necessidades baseadas no forecast
    3. Priorizar e sugerir fornecedores
    4. Agrupar em pedidos sugeridos
    5. Persistir resultados

    Args:
        db: Instância do DatabaseManager

    Returns:
        Dict com resultado da execução
    """
    inicio = time.time()
    resultado = {
        'sucesso': True,
        'filiais_processadas': 0,
        'total_necessidades': 0,
        'total_pedidos': 0,
        'por_prioridade': {
            'urgentes': 0,
            'alta': 0,
            'normal': 0,
            'baixa': 0
        },
        'vlr_total': 0,
        'erros': [],
        'tempo_execucao': None
    }

    try:
        from .processadores.necessidade import (
            GeradorNecessidade,
            ParametrosNecessidade,
            NecessidadeRepositorio
        )

        logger.info("=== INICIANDO JOB GERAÇÃO DE NECESSIDADES ===")

        gerador = GeradorNecessidade(db)
        repositorio = NecessidadeRepositorio(db)
        parametros = ParametrosNecessidade()

        # 1. Cancelar necessidades expiradas
        expiradas = repositorio.cancelar_expiradas()
        if expiradas > 0:
            logger.info(f"Necessidades expiradas canceladas: {expiradas}")

        # 2. Buscar filiais ativas
        query_filiais = """
            SELECT IDFilial, Nomfil FROM arqfilial
            WHERE IndAtivo = 1
            ORDER BY IDFilial
        """
        filiais = db.executar_query(query_filiais)

        if not filiais:
            logger.warning("Nenhuma filial ativa encontrada")
            resultado['sucesso'] = False
            resultado['erros'].append("Nenhuma filial ativa encontrada")
            return resultado

        logger.info(f"Encontradas {len(filiais)} filiais ativas")

        # 3. Processar cada filial
        for filial in filiais:
            id_filial = filial['IDFilial']
            nome_filial = filial['Nomfil']

            try:
                logger.info(f"Processando filial {id_filial}: {nome_filial}")

                # Gerar necessidades (já salva automaticamente)
                resultado_filial = gerador.gerar_necessidades(
                    id_filial=id_filial,
                    parametros=parametros,
                    salvar=True
                )

                # Contabilizar
                necessidades = resultado_filial.get('necessidades', [])
                pedidos = resultado_filial.get('pedidos', [])
                resumo = resultado_filial.get('resumo', {})

                resultado['total_necessidades'] += len(necessidades)
                resultado['total_pedidos'] += len(pedidos)
                resultado['por_prioridade']['urgentes'] += resumo.get('por_prioridade', {}).get('URGENTE', 0)
                resultado['por_prioridade']['alta'] += resumo.get('por_prioridade', {}).get('ALTA', 0)
                resultado['por_prioridade']['normal'] += resumo.get('por_prioridade', {}).get('NORMAL', 0)
                resultado['por_prioridade']['baixa'] += resumo.get('por_prioridade', {}).get('BAIXA', 0)
                resultado['vlr_total'] += resumo.get('vlr_total', 0)
                resultado['filiais_processadas'] += 1

                logger.info(
                    f"Filial {id_filial}: {len(necessidades)} necessidades, "
                    f"{len(pedidos)} pedidos sugeridos"
                )

            except Exception as e:
                erro_msg = f"Filial {id_filial}: {str(e)}"
                resultado['erros'].append(erro_msg)
                logger.error(f"Erro ao processar filial: {erro_msg}")

        # 4. Estatísticas finais
        tempo_execucao = time.time() - inicio
        resultado['tempo_execucao'] = round(tempo_execucao, 2)

        # Log resumo
        logger.info(
            f"=== JOB NECESSIDADES CONCLUÍDO ===\n"
            f"Filiais processadas: {resultado['filiais_processadas']}\n"
            f"Total necessidades: {resultado['total_necessidades']}\n"
            f"Total pedidos sugeridos: {resultado['total_pedidos']}\n"
            f"Por prioridade:\n"
            f"  - Urgentes: {resultado['por_prioridade']['urgentes']}\n"
            f"  - Alta: {resultado['por_prioridade']['alta']}\n"
            f"  - Normal: {resultado['por_prioridade']['normal']}\n"
            f"  - Baixa: {resultado['por_prioridade']['baixa']}\n"
            f"Valor total: R$ {resultado['vlr_total']:,.2f}\n"
            f"Erros: {len(resultado['erros'])}\n"
            f"Tempo: {resultado['tempo_execucao']}s"
        )

        if resultado['erros']:
            logger.warning(f"Erros durante execução: {resultado['erros'][:5]}")

    except Exception as e:
        resultado['sucesso'] = False
        erro_msg = f"Erro geral no job necessidades: {str(e)}"
        resultado['erros'].append(erro_msg)
        logger.error(erro_msg)

    return resultado


async def job_alertar_necessidades_urgentes(db: DatabaseManager) -> Dict:
    """
    Job para gerar alertas sobre necessidades urgentes não atendidas.

    Args:
        db: Instância do DatabaseManager

    Returns:
        Dict com necessidades urgentes identificadas
    """
    try:
        query_urgentes = """
            SELECT
                n.IDNecessi,
                n.IDFilial,
                f.Nomfil,
                n.IDProd,
                p.Despro,
                n.Prioridade,
                n.EstqAtual,
                n.DiasCobre,
                n.RiscoRupt,
                n.QtdSugerida,
                n.VlrTotalSuger,
                n.CNPJFornSuger,
                n.NomeFornSuger,
                n.DatGeracao
            FROM ia_arqnecessi n
            INNER JOIN arqfilial f ON f.IDFilial = n.IDFilial
            INNER JOIN arqproduto p ON p.IDProd = n.IDProd
            WHERE n.Status = 'PENDENTE'
              AND n.Prioridade IN ('URGENTE', 'ALTA')
              AND n.DatValidade >= CURDATE()
            ORDER BY
                FIELD(n.Prioridade, 'URGENTE', 'ALTA'),
                n.ScorePrior DESC
            LIMIT 100
        """

        urgentes = db.executar_query(query_urgentes) or []

        if urgentes:
            urgentes_count = sum(1 for u in urgentes if u['Prioridade'] == 'URGENTE')
            alta_count = len(urgentes) - urgentes_count

            logger.warning(
                f"ALERTA: {len(urgentes)} necessidades urgentes/alta prioridade pendentes!\n"
                f"  - Urgentes: {urgentes_count}\n"
                f"  - Alta prioridade: {alta_count}\n"
                f"Produtos mais críticos:\n" +
                "\n".join([
                    f"  - {u['Despro'][:40]} (Filial {u['IDFilial']}): "
                    f"Estoque {u['EstqAtual']}, Cobre {u['DiasCobre']:.0f} dias, "
                    f"Risco {u['RiscoRupt']*100:.0f}%"
                    for u in urgentes[:10]
                ])
            )

        return {
            'total_urgentes': len(urgentes),
            'necessidades': urgentes
        }

    except Exception as e:
        logger.error(f"Erro ao buscar necessidades urgentes: {e}")
        return {'total_urgentes': 0, 'necessidades': [], 'erro': str(e)}


async def job_limpeza_necessidades_antigas(db: DatabaseManager, dias_manter: int = 90) -> int:
    """
    Job para limpeza física de necessidades muito antigas.

    Args:
        db: Instância do DatabaseManager
        dias_manter: Dias de necessidades para manter (padrão: 90 dias)

    Returns:
        Número de registros removidos
    """
    try:
        from datetime import datetime, timedelta

        data_limite = datetime.now() - timedelta(days=dias_manter)

        # Limpar necessidades antigas
        query_limpar_nec = """
            DELETE FROM ia_arqnecessi
            WHERE DatGeracao < :data_limite
              AND Status IN ('CANCELADA', 'REJEITADA')
        """
        db.executar_query(query_limpar_nec, {'data_limite': data_limite})

        # Limpar pedidos antigos
        query_limpar_ped = """
            DELETE FROM ia_arqnecped
            WHERE DatGeracao < :data_limite
              AND Status IN ('CANCELADO', 'REJEITADO')
        """
        db.executar_query(query_limpar_ped, {'data_limite': data_limite})

        logger.info(f"Limpeza necessidades: registros antigos removidos")
        return 0

    except Exception as e:
        logger.error(f"Erro na limpeza de necessidades antigas: {e}")
        return 0


def registrar_jobs_necessidades(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra jobs específicos do sistema de necessidades de compra.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        logger.info("Registrando jobs do sistema de necessidades...")

        # Job principal de geração de necessidades às 06:30
        # (após forecast 04:00, classificação 05:00 e score fornecedor 06:00)
        async def job_necessidades_diario():
            resultado = await job_gerar_necessidades(db)

            # Alertar sobre urgentes
            await job_alertar_necessidades_urgentes(db)

            # Notificar em caso de muitos erros
            if not resultado['sucesso'] or len(resultado['erros']) > 10:
                logger.error(f"Job necessidades com problemas: {resultado}")

        scheduler.add_job(
            job_id="necessidades_diario",
            func=job_necessidades_diario,
            trigger='cron',
            hour=6,  # 06:30 AM
            minute=30,
            misfire_grace_time=7200  # 2 horas de tolerância
        )

        # Job de alerta 2x ao dia (às 09:00 e 15:00)
        async def job_alerta_necessidades():
            await job_alertar_necessidades_urgentes(db)

        scheduler.add_job(
            job_id="necessidades_alerta_manha",
            func=job_alerta_necessidades,
            trigger='cron',
            hour=9,
            minute=0
        )

        scheduler.add_job(
            job_id="necessidades_alerta_tarde",
            func=job_alerta_necessidades,
            trigger='cron',
            hour=15,
            minute=0
        )

        # Job de limpeza mensal (primeiro domingo do mês às 04:00)
        async def job_limpeza_necessidades():
            await job_limpeza_necessidades_antigas(db)

        scheduler.add_job(
            job_id="necessidades_limpeza",
            func=job_limpeza_necessidades,
            trigger='cron',
            day=1,  # Dia 1 do mês
            hour=4,
            minute=0
        )

        logger.info("Jobs do sistema de necessidades registrados com sucesso")

    except Exception as e:
        logger.error(f"Erro ao registrar jobs de necessidades: {e}")


# =============================================================================
# SISTEMA DE JOBS AUTOMÁTICOS DE INTEGRAÇÃO (SmartPed/CoteFácil/ERP)
# =============================================================================

def job_sincronizar_erp():
    """
    Job para sincronizar pedidos com ERP.
    Executa a cada hora.
    """

    from core.database import DatabaseFactory
    from config import settings

    logger.info("Iniciando sincronização com ERP")

    db = DatabaseFactory.create_from_config(settings)
    db.connect()

    try:
        from .processadores.integracao import SincronizadorERP

        sincronizador = SincronizadorERP(db)

        # Busca filiais ativas
        filiais = db.execute_query("SELECT IDFilial FROM arqfilial WHERE Ativo = '1'")

        total_exportados = 0
        total_atualizados = 0
        total_erros = 0

        for filial in filiais:
            id_filial = filial['IDFilial']

            try:
                resultado = sincronizador.sincronizar_pedidos_pendentes(id_filial)
                total_exportados += resultado['exportados']
                total_atualizados += resultado['atualizados']
                total_erros += resultado['erros']
            except Exception as e:
                logger.error(f"Erro sincronização filial {id_filial}: {e}")

        logger.info(f"Sincronização ERP: {total_exportados} exportados, {total_atualizados} atualizados, {total_erros} erros")

    except Exception as e:
        logger.error(f"Erro no job de sincronização: {e}")
        raise

    finally:
        db.disconnect()


def job_encerrar_cotacoes():
    """
    Job para encerrar cotações expiradas.
    Executa diariamente às 7h.
    """

    from core.database import DatabaseFactory
    from config import settings

    logger.info("Verificando cotações para encerrar")

    db = DatabaseFactory.create_from_config(settings)
    db.connect()

    try:
        from .processadores.integracao import CoteFacilIntegrador

        # Busca cotações abertas com prazo expirado
        sql = """
            SELECT IDCotacao, IDFilial
            FROM ia_arqcotacao
            WHERE Status = 'ABERTA'
              AND DatEncerramento < NOW()
        """
        cotacoes = db.execute_query(sql)

        integrador = CoteFacilIntegrador(db)

        for cot in cotacoes:
            try:
                integrador.encerrar_cotacao(cot['IDCotacao'])
                logger.info(f"Cotação {cot['IDCotacao']} encerrada automaticamente")
            except Exception as e:
                logger.error(f"Erro ao encerrar cotação {cot['IDCotacao']}: {e}")

        logger.info(f"Verificação de cotações concluída: {len(cotacoes)} encerradas")

    except Exception as e:
        logger.error(f"Erro no job de cotações: {e}")
        raise

    finally:
        db.disconnect()


def registrar_jobs_integracao(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra jobs específicos do sistema de integração.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        logger.info("Registrando jobs do sistema de integração...")

        # Job de sincronização ERP (a cada hora, minuto 30)
        scheduler.add_job(
            job_id="sincronizar_erp",
            func=job_sincronizar_erp,
            trigger='cron',
            minute=30  # A cada hora, minuto 30
        )
        logger.info("Job registrado: sincronizar_erp (a cada hora)")

        # Job de encerrar cotações (7h da manhã)
        scheduler.add_job(
            job_id="encerrar_cotacoes",
            func=job_encerrar_cotacoes,
            trigger='cron',
            hour=7,
            minute=0
        )
        logger.info("Job registrado: encerrar_cotacoes (7:00)")

        logger.info("Jobs do sistema de integração registrados com sucesso")

    except Exception as e:
        logger.error(f"Erro ao registrar jobs de integração: {e}")


# =============================================================================
# SISTEMA DE JOBS AUTOMÁTICOS DE APRENDIZADO
# =============================================================================

def job_aprendizado_semanal():
    """
    Job semanal de aprendizado.
    Executa toda segunda-feira às 5h.

    - Compara previsões da semana anterior com vendas reais
    - Calcula métricas
    - Sugere e aplica ajustes automáticos
    """

    from datetime import date, timedelta
    from core.database import DatabaseFactory
    from config import settings
    from .processadores.aprendizado import AnalisadorAprendizado

    logger.info("=" * 50)
    logger.info("Iniciando ciclo semanal de aprendizado")
    logger.info("=" * 50)

    db = DatabaseFactory.create_from_config(settings)
    db.connect()

    try:
        analisador = AnalisadorAprendizado(db)

        # Período: semana anterior (segunda a domingo)
        hoje = date.today()
        dias_desde_segunda = hoje.weekday()  # 0=segunda
        fim_semana = hoje - timedelta(days=dias_desde_segunda + 1)  # Domingo anterior
        inicio_semana = fim_semana - timedelta(days=6)  # Segunda anterior

        logger.info(f"Período: {inicio_semana} a {fim_semana}")

        # Executa para todas as filiais
        resultado = analisador.executar_para_todas_filiais(
            data_inicio=inicio_semana,
            data_fim=fim_semana
        )

        logger.info("=" * 50)
        logger.info(f"Aprendizado semanal concluído:")
        logger.info(f"  - Filiais processadas: {resultado['filiais_processadas']}")
        logger.info(f"  - Sucesso: {resultado['sucesso']}")
        logger.info(f"  - Erros: {resultado['erro']}")
        logger.info("=" * 50)

    except Exception as e:
        logger.error(f"Erro no job de aprendizado: {e}")
        raise

    finally:
        db.disconnect()


def job_aprendizado_mensal():
    """
    Job mensal de aprendizado.
    Executa no dia 1 de cada mês às 4h.

    - Consolida métricas do mês anterior
    - Gera relatório de performance
    """

    from datetime import date, timedelta
    from core.database import DatabaseFactory
    from config import settings
    from .processadores.aprendizado import AnalisadorAprendizado

    logger.info("=" * 50)
    logger.info("Iniciando consolidação mensal de aprendizado")
    logger.info("=" * 50)

    db = DatabaseFactory.create_from_config(settings)
    db.connect()

    try:
        analisador = AnalisadorAprendizado(db)

        # Período: mês anterior
        hoje = date.today()
        primeiro_dia_mes = date(hoje.year, hoje.month, 1)
        fim_mes_anterior = primeiro_dia_mes - timedelta(days=1)
        inicio_mes_anterior = date(fim_mes_anterior.year, fim_mes_anterior.month, 1)

        logger.info(f"Período: {inicio_mes_anterior} a {fim_mes_anterior}")

        # Executa para todas as filiais
        resultado = analisador.executar_para_todas_filiais(
            data_inicio=inicio_mes_anterior,
            data_fim=fim_mes_anterior
        )

        # Log detalhado por filial
        for id_filial, detalhe in resultado.get('detalhes', {}).items():
            if detalhe.get('sucesso'):
                metricas = detalhe.get('metricas', {})
                logger.info(f"Filial {id_filial}: MAPE={metricas.get('mape', 0):.2f}%, "
                           f"Acurácia={metricas.get('acuracia_media', 0):.1f}%")

        logger.info("=" * 50)
        logger.info("Consolidação mensal concluída")
        logger.info("=" * 50)

    except Exception as e:
        logger.error(f"Erro no job mensal: {e}")
        raise

    finally:
        db.disconnect()


def registrar_jobs_aprendizado(scheduler: SchedulerManager, db: DatabaseManager) -> None:
    """
    Registra jobs específicos do sistema de aprendizado.

    Args:
        scheduler: Instância do SchedulerManager
        db: Instância do DatabaseManager
    """
    try:
        logger.info("Registrando jobs do sistema de aprendizado...")

        # Job de aprendizado semanal (segundas às 5h)
        scheduler.add_job(
            job_id="aprendizado_semanal",
            func=job_aprendizado_semanal,
            trigger='cron',
            day_of_week='mon',
            hour=5,
            minute=0
        )
        logger.info("Job registrado: aprendizado_semanal (seg 5:00)")

        # Job de aprendizado mensal (dia 1 às 4h)
        scheduler.add_job(
            job_id="aprendizado_mensal",
            func=job_aprendizado_mensal,
            trigger='cron',
            day=1,
            hour=4,
            minute=0
        )
        logger.info("Job registrado: aprendizado_mensal (dia 1, 4:00)")

        logger.info("Jobs do sistema de aprendizado registrados com sucesso")

    except Exception as e:
        logger.error(f"Erro ao registrar jobs de aprendizado: {e}")