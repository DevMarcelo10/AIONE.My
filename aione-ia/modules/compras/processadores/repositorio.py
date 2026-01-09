"""
AIONE IA - Repositório de Forecast
Camada de persistência para resultados de forecast na tabela ia_arqforecast
"""

from datetime import datetime, date, timedelta
from typing import List, Optional, Dict, Any
import json
from sqlalchemy import text

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .metricas import ResultadoForecast, MetricasProduto


class ForecastRepositorio:
    """Repositório para persistência de forecasts em ia_arqforecast"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    # =========================================================================
    # MÉTODOS DE GRAVAÇÃO
    # =========================================================================

    def salvar(self, resultado: ResultadoForecast,
               dias_validade: int = 7) -> int:
        """
        Salva resultado do forecast na tabela.
        Marca forecasts anteriores do mesmo produto/filial como SUBSTITUIDO.

        Args:
            resultado: ResultadoForecast com métricas calculadas
            dias_validade: Dias até o forecast expirar

        Returns: IDForecast gerado
        """
        try:
            metricas = resultado.metricas

            # Marca anteriores como SUBSTITUIDO
            self._marcar_substituidos(metricas.id_prod, metricas.id_filial)

            # Prepara dados para insert
            data_validade = date.today() + timedelta(days=dias_validade)

            # Buscar ID do grupo se não informado
            id_grupo = metricas.id_grupo or self._obter_grupo_produto(metricas.id_prod)

            sql = """
                INSERT INTO ia_arqforecast (
                    IDProd, IDFilial, IDGrupo,
                    DatCalculo, DatValidade,
                    DiasHist, DiasCobreAlvo, TempoRepo,
                    ConsMedio, ConsDesvio, ConsCoefVar, Tendencia,
                    EstqAtual, EstqSegur, PontoPed, DiasCobre,
                    CenOtim, CenCons, CenCrit,
                    FatorAjuste, EventosJSON, AlertasJSON,
                    Confianca, QualidDados, RiscoRupt,
                    SazonalDetec, IndSazonJSON,
                    Status
                ) VALUES (
                    :id_prod, :id_filial, :id_grupo,
                    NOW(), :data_validade,
                    :dias_hist, :dias_cobre_alvo, :tempo_repo,
                    :cons_medio, :cons_desvio, :cons_coef_var, :tendencia,
                    :estq_atual, :estq_segur, :ponto_ped, :dias_cobre,
                    :cen_otim, :cen_cons, :cen_crit,
                    :fator_ajuste, :eventos_json, :alertas_json,
                    :confianca, :qualid_dados, :risco_rupt,
                    :sazonal_detec, :ind_sazon_json,
                    'ATIVO'
                )
            """

            params = {
                'id_prod': metricas.id_prod,
                'id_filial': metricas.id_filial,
                'id_grupo': id_grupo,
                'data_validade': data_validade,
                'dias_hist': metricas.dias_historico,
                'dias_cobre_alvo': getattr(metricas, 'dias_cobertura_alvo', 30),
                'tempo_repo': getattr(metricas, 'tempo_reposicao', 7),
                'cons_medio': metricas.consumo_medio_diario,
                'cons_desvio': metricas.desvio_padrao_diario,
                'cons_coef_var': metricas.coef_variacao,
                'tendencia': metricas.tendencia or 'ESTAVEL',
                'estq_atual': metricas.estoque_atual,
                'estq_segur': metricas.estoque_seguranca,
                'ponto_ped': metricas.ponto_pedido,
                'dias_cobre': metricas.dias_cobertura,
                'cen_otim': metricas.cen_otimista,
                'cen_cons': metricas.cen_conservador,
                'cen_crit': metricas.cen_critico,
                'fator_ajuste': resultado.fator_ajuste,
                'eventos_json': json.dumps(resultado.ajustes_aplicados, default=str, ensure_ascii=False),
                'alertas_json': json.dumps(resultado.alertas, default=str, ensure_ascii=False),
                'confianca': resultado.confianca,
                'qualid_dados': resultado.qualidade_dados,
                'risco_rupt': metricas.risco_ruptura,
                'sazonal_detec': 1 if resultado.sazonalidade_detectada else 0,
                'ind_sazon_json': json.dumps(resultado.indices_sazonais, default=str, ensure_ascii=False)
            }

            with self.db.session_scope() as session:
                result = session.execute(text(sql), params)
                session.commit()

                # Obter ID do registro inserido
                id_forecast = result.lastrowid or session.execute(text("SELECT LAST_INSERT_ID()")).scalar()

                self.logger.info(
                    f"Forecast salvo: ID={id_forecast}, Prod={metricas.id_prod}, "
                    f"Filial={metricas.id_filial}, Validade={data_validade}"
                )

                return id_forecast

        except Exception as e:
            self.logger.error(f"Erro ao salvar forecast: {e}")
            raise

    def salvar_lote(self, resultados: List[ResultadoForecast],
                    dias_validade: int = 7) -> int:
        """
        Salva múltiplos forecasts em lote.

        Returns: Quantidade de registros salvos
        """
        count = 0
        total = len(resultados)

        for i, resultado in enumerate(resultados, 1):
            try:
                self.salvar(resultado, dias_validade)
                count += 1
                self.logger.debug(f"Progresso lote: {i}/{total}")

            except Exception as e:
                self.logger.error(f"Erro ao salvar forecast prod {resultado.metricas.id_prod}: {e}")
                continue

        self.logger.info(f"Lote salvo: {count}/{total} forecasts processados com sucesso")
        return count

    def _marcar_substituidos(self, id_prod: int, id_filial: int) -> int:
        """Marca forecasts anteriores como SUBSTITUIDO"""
        try:
            sql = """
                UPDATE ia_arqforecast
                SET Status = 'SUBSTITUIDO'
                WHERE IDProd = :id_prod
                  AND IDFilial = :id_filial
                  AND Status = 'ATIVO'
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_prod': id_prod,
                    'id_filial': id_filial
                })
                session.commit()
                rows_affected = result.rowcount

                if rows_affected > 0:
                    self.logger.debug(f"Marcados {rows_affected} forecasts como SUBSTITUIDO")

                return rows_affected

        except Exception as e:
            self.logger.warning(f"Erro ao marcar substituidos: {e}")
            return 0

    def _obter_grupo_produto(self, id_prod: int) -> Optional[int]:
        """Busca IDGrupo do produto"""
        try:
            sql = "SELECT IDGrupo FROM arqproduto WHERE IDProd = :id_prod"

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {'id_prod': id_prod})
                row = result.fetchone()

                return row.IDGrupo if row else None

        except Exception as e:
            self.logger.warning(f"Erro ao obter grupo produto {id_prod}: {e}")
            return None

    def marcar_expirados(self) -> int:
        """
        Marca como EXPIRADO forecasts cuja DatValidade passou.
        Deve ser executado diariamente.

        Returns: Quantidade de registros atualizados
        """
        try:
            sql = """
                UPDATE ia_arqforecast
                SET Status = 'EXPIRADO'
                WHERE Status = 'ATIVO'
                  AND DatValidade < CURDATE()
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql))
                session.commit()
                rows_affected = result.rowcount

                self.logger.info(f"Forecasts expirados: {rows_affected} registros atualizados")
                return rows_affected

        except Exception as e:
            self.logger.error(f"Erro ao marcar expirados: {e}")
            return 0

    # =========================================================================
    # MÉTODOS DE LEITURA
    # =========================================================================

    def obter_ativo(self, id_prod: int, id_filial: int) -> Optional[Dict]:
        """
        Obtém forecast ativo para um produto/filial.

        Returns: Dict com dados do forecast ou None se não existir
        """
        try:
            sql = """
                SELECT fc.*, p.Despro as produto_nome, g.Desgru as grupo_nome
                FROM ia_arqforecast fc
                INNER JOIN arqproduto p ON fc.IDProd = p.IDProd
                LEFT JOIN arqgrupo g ON fc.IDGrupo = g.IDGrupo
                WHERE fc.IDProd = :id_prod
                  AND fc.IDFilial = :id_filial
                  AND fc.Status = 'ATIVO'
                  AND fc.DatValidade >= CURDATE()
                ORDER BY fc.DatCalculo DESC
                LIMIT 1
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_prod': id_prod,
                    'id_filial': id_filial
                })
                row = result.fetchone()

                if row:
                    return self._parse_registro(dict(row._mapping))
                return None

        except Exception as e:
            self.logger.error(f"Erro ao obter forecast ativo: {e}")
            return None

    def obter_por_id(self, id_forecast: int) -> Optional[Dict]:
        """Obtém forecast específico por ID"""
        try:
            sql = """
                SELECT fc.*, p.Despro as produto_nome, g.Desgru as grupo_nome
                FROM ia_arqforecast fc
                INNER JOIN arqproduto p ON fc.IDProd = p.IDProd
                LEFT JOIN arqgrupo g ON fc.IDGrupo = g.IDGrupo
                WHERE fc.IDForecast = :id
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {'id': id_forecast})
                row = result.fetchone()

                if row:
                    return self._parse_registro(dict(row._mapping))
                return None

        except Exception as e:
            self.logger.error(f"Erro ao obter forecast por ID {id_forecast}: {e}")
            return None

    def listar_filial(self, id_filial: int,
                      apenas_ativos: bool = True,
                      apenas_criticos: bool = False,
                      id_grupo: int = None,
                      ordem: str = 'risco',
                      limite: int = 100) -> List[Dict]:
        """
        Lista forecasts de uma filial.

        Args:
            id_filial: ID da filial
            apenas_ativos: Se True, só retorna Status='ATIVO' e não expirados
            apenas_criticos: Se True, só retorna abaixo do ponto de pedido
            id_grupo: Filtrar por grupo específico
            ordem: 'risco' (maior risco primeiro) ou 'produto'
            limite: Máximo de registros

        Returns: Lista de forecasts
        """
        try:
            conditions = ["fc.IDFilial = :id_filial"]
            params = {'id_filial': id_filial, 'limite': limite}

            if apenas_ativos:
                conditions.append("fc.Status = 'ATIVO'")
                conditions.append("fc.DatValidade >= CURDATE()")

            if apenas_criticos:
                conditions.append("fc.EstqAtual <= fc.PontoPed")

            if id_grupo:
                conditions.append("fc.IDGrupo = :id_grupo")
                params['id_grupo'] = id_grupo

            order_by = "fc.RiscoRupt DESC" if ordem == 'risco' else "p.Despro"

            sql = f"""
                SELECT fc.*, p.Despro as produto_nome, g.Desgru as grupo_nome
                FROM ia_arqforecast fc
                INNER JOIN arqproduto p ON fc.IDProd = p.IDProd
                LEFT JOIN arqgrupo g ON fc.IDGrupo = g.IDGrupo
                WHERE {' AND '.join(conditions)}
                ORDER BY {order_by}
                LIMIT :limite
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), params)
                rows = result.fetchall()

                forecasts = [self._parse_registro(dict(row._mapping)) for row in rows]

                self.logger.debug(
                    f"Listagem filial {id_filial}: {len(forecasts)} registros retornados"
                )

                return forecasts

        except Exception as e:
            self.logger.error(f"Erro ao listar forecasts da filial {id_filial}: {e}")
            return []

    def listar_produtos_sem_forecast(self, id_filial: int,
                                     limite: int = 100) -> List[Dict]:
        """
        Lista produtos que não têm forecast ativo.
        Útil para identificar produtos que precisam de cálculo.
        """
        try:
            sql = """
                SELECT DISTINCT p.IDProd, p.Despro, p.IDGrupo, g.Desgru as grupo_nome
                FROM arqproduto p
                LEFT JOIN arqgrupo g ON p.IDGrupo = g.IDGrupo
                WHERE p.Ativo = '1'
                  AND p.IDProd NOT IN (
                      SELECT f.IDProd FROM ia_arqforecast f
                      WHERE f.IDFilial = :id_filial
                        AND f.Status = 'ATIVO'
                        AND f.DatValidade >= CURDATE()
                  )
                ORDER BY p.Despro
                LIMIT :limite
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_filial': id_filial,
                    'limite': limite
                })
                rows = result.fetchall()

                produtos = [dict(row._mapping) for row in rows]

                self.logger.info(
                    f"Produtos sem forecast filial {id_filial}: {len(produtos)} encontrados"
                )

                return produtos

        except Exception as e:
            self.logger.error(f"Erro ao listar produtos sem forecast: {e}")
            return []

    def resumo_filial(self, id_filial: int) -> Dict:
        """
        Retorna resumo estatístico dos forecasts de uma filial.

        Returns: {
            'total_produtos': int,
            'com_forecast_ativo': int,
            'abaixo_ponto_pedido': int,
            'risco_ruptura_alto': int,  # risco > 30%
            'sem_giro': int,            # CMD = 0
            'qualidade_dados': {'BOA': x, 'MEDIA': y, ...}
        }
        """
        try:
            sql = """
                SELECT
                    COUNT(*) as total,
                    SUM(CASE WHEN EstqAtual <= PontoPed THEN 1 ELSE 0 END) as abaixo_pp,
                    SUM(CASE WHEN RiscoRupt > 0.3 THEN 1 ELSE 0 END) as risco_alto,
                    SUM(CASE WHEN ConsMedio = 0 THEN 1 ELSE 0 END) as sem_giro,
                    SUM(CASE WHEN QualidDados = 'BOA' THEN 1 ELSE 0 END) as qual_boa,
                    SUM(CASE WHEN QualidDados = 'MEDIA' THEN 1 ELSE 0 END) as qual_media,
                    SUM(CASE WHEN QualidDados = 'RUIM' THEN 1 ELSE 0 END) as qual_ruim,
                    SUM(CASE WHEN QualidDados = 'INSUFICIENTE' THEN 1 ELSE 0 END) as qual_insuf,
                    AVG(Confianca) as confianca_media,
                    MAX(DatCalculo) as ultima_atualizacao
                FROM ia_arqforecast
                WHERE IDFilial = :id_filial
                  AND Status = 'ATIVO'
                  AND DatValidade >= CURDATE()
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {'id_filial': id_filial})
                row = result.fetchone()

                if row:
                    r = dict(row._mapping)
                    return {
                        'total_produtos': r['total'] or 0,
                        'com_forecast_ativo': r['total'] or 0,
                        'abaixo_ponto_pedido': r['abaixo_pp'] or 0,
                        'risco_ruptura_alto': r['risco_alto'] or 0,
                        'sem_giro': r['sem_giro'] or 0,
                        'qualidade_dados': {
                            'BOA': r['qual_boa'] or 0,
                            'MEDIA': r['qual_media'] or 0,
                            'RUIM': r['qual_ruim'] or 0,
                            'INSUFICIENTE': r['qual_insuf'] or 0
                        },
                        'confianca_media': float(r['confianca_media'] or 0),
                        'ultima_atualizacao': r['ultima_atualizacao'].isoformat() if r['ultima_atualizacao'] else None
                    }

        except Exception as e:
            self.logger.error(f"Erro ao gerar resumo da filial {id_filial}: {e}")

        return {
            'total_produtos': 0,
            'com_forecast_ativo': 0,
            'abaixo_ponto_pedido': 0,
            'risco_ruptura_alto': 0,
            'sem_giro': 0,
            'qualidade_dados': {'BOA': 0, 'MEDIA': 0, 'RUIM': 0, 'INSUFICIENTE': 0},
            'confianca_media': 0.0,
            'ultima_atualizacao': None
        }

    # =========================================================================
    # MÉTODOS AUXILIARES
    # =========================================================================

    def _parse_registro(self, registro: Dict) -> Dict:
        """Converte registro do banco para dict com JSON parseado"""
        try:
            # Parse dos campos JSON
            if registro.get('EventosJSON'):
                try:
                    registro['EventosJSON'] = json.loads(registro['EventosJSON'])
                except (json.JSONDecodeError, TypeError):
                    registro['EventosJSON'] = []
            else:
                registro['EventosJSON'] = []

            if registro.get('AlertasJSON'):
                try:
                    registro['AlertasJSON'] = json.loads(registro['AlertasJSON'])
                except (json.JSONDecodeError, TypeError):
                    registro['AlertasJSON'] = []
            else:
                registro['AlertasJSON'] = []

            if registro.get('IndSazonJSON'):
                try:
                    registro['IndSazonJSON'] = json.loads(registro['IndSazonJSON'])
                except (json.JSONDecodeError, TypeError):
                    registro['IndSazonJSON'] = {}
            else:
                registro['IndSazonJSON'] = {}

            # Converter datas para ISO string se necessário
            for campo in ['DatCalculo', 'DatValidade']:
                if registro.get(campo) and hasattr(registro[campo], 'isoformat'):
                    registro[campo] = registro[campo].isoformat()

            # Converter valores numéricos
            campos_numericos = [
                'ConsMedio', 'ConsDesvio', 'ConsCoefVar', 'EstqAtual',
                'EstqSegur', 'PontoPed', 'DiasCobre', 'CenOtim', 'CenCons',
                'CenCrit', 'FatorAjuste', 'Confianca', 'RiscoRupt'
            ]

            for campo in campos_numericos:
                if registro.get(campo) is not None:
                    try:
                        registro[campo] = float(registro[campo])
                    except (ValueError, TypeError):
                        pass

            return registro

        except Exception as e:
            self.logger.warning(f"Erro ao parsear registro: {e}")
            return registro

    def existe_ativo(self, id_prod: int, id_filial: int) -> bool:
        """Verifica se existe forecast ativo para o produto/filial"""
        try:
            sql = """
                SELECT 1 FROM ia_arqforecast
                WHERE IDProd = :id_prod
                  AND IDFilial = :id_filial
                  AND Status = 'ATIVO'
                  AND DatValidade >= CURDATE()
                LIMIT 1
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_prod': id_prod,
                    'id_filial': id_filial
                })
                row = result.fetchone()
                return row is not None

        except Exception as e:
            self.logger.error(f"Erro ao verificar forecast ativo: {e}")
            return False

    def limpar_historico(self, dias_manter: int = 90) -> int:
        """
        Remove forecasts antigos (EXPIRADO ou SUBSTITUIDO) com mais de X dias.

        Returns: Quantidade de registros removidos
        """
        try:
            sql = """
                DELETE FROM ia_arqforecast
                WHERE Status IN ('EXPIRADO', 'SUBSTITUIDO')
                  AND DatCalculo < DATE_SUB(CURDATE(), INTERVAL :dias DAY)
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {'dias': dias_manter})
                session.commit()
                rows_deleted = result.rowcount

                self.logger.info(f"Histórico limpo: {rows_deleted} registros removidos")
                return rows_deleted

        except Exception as e:
            self.logger.error(f"Erro ao limpar histórico: {e}")
            return 0

    def obter_produtos_para_recalculo(self, id_filial: int = None,
                                     max_produtos: int = 500) -> List[Dict]:
        """
        Obtém lista de produtos que precisam ter forecast recalculado.

        Args:
            id_filial: ID da filial (None para todas)
            max_produtos: Máximo de produtos para retornar

        Returns:
            Lista de dicionários com IDProd e IDFilial
        """
        try:
            conditions = ["p.Ativo = '1'"]
            params = {'max_produtos': max_produtos}

            if id_filial:
                conditions.append("pl.IDFilial = :id_filial")
                params['id_filial'] = id_filial

            sql = f"""
                SELECT DISTINCT
                    pl.IDProd,
                    pl.IDFilial,
                    p.Despro as produto_nome,
                    COALESCE(fc.RiscoRupt, 1) as risco_atual,
                    COALESCE(fc.DiasCobre, 0) as dias_cobertura,
                    fc.DatCalculo
                FROM arqprodutolot pl
                INNER JOIN arqproduto p ON p.IDProd = pl.IDProd
                LEFT JOIN ia_arqforecast fc ON fc.IDProd = pl.IDProd
                    AND fc.IDFilial = pl.IDFilial
                    AND fc.Status = 'ATIVO'
                WHERE {' AND '.join(conditions)}
                  AND (
                      pl.QtdLote <= 10                    -- Estoque muito baixo
                      OR COALESCE(fc.DiasCobre, 0) <= 7   -- Cobertura crítica
                      OR COALESCE(fc.RiscoRupt, 0) > 0.3   -- Alto risco
                      OR fc.DatCalculo IS NULL             -- Nunca calculado
                      OR fc.DatValidade < CURDATE()        -- Expirado
                      OR fc.DatCalculo < DATE_SUB(NOW(), INTERVAL 7 DAY)  -- Desatualizado
                  )
                ORDER BY
                    COALESCE(fc.RiscoRupt, 1) DESC,     -- Maior risco primeiro
                    pl.QtdLote ASC,                     -- Menor estoque primeiro
                    COALESCE(fc.DatCalculo, '1970-01-01') ASC  -- Mais antigo primeiro
                LIMIT :max_produtos
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), params)
                rows = result.fetchall()

                produtos = [
                    {
                        'IDProd': row.IDProd,
                        'IDFilial': row.IDFilial,
                        'produto_nome': row.produto_nome,
                        'risco_atual': float(row.risco_atual),
                        'dias_cobertura': float(row.dias_cobertura)
                    }
                    for row in rows
                ]

                self.logger.info(f"Produtos para recálculo: {len(produtos)} encontrados")
                return produtos

        except Exception as e:
            self.logger.error(f"Erro ao obter produtos para recálculo: {e}")
            return []