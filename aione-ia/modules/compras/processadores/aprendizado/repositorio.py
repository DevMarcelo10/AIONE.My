from datetime import datetime, date
from typing import List, Dict, Optional
import json

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .comparador import ResultadoComparacao, MetricasConsolidadas, TipoPeriodo

class AprendizadoRepositorio:
    """Repositório para persistência de dados de aprendizado"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    # =========================================================================
    # COMPARAÇÕES (ia_arqaprendiz)
    # =========================================================================

    def salvar_comparacao(self, comparacao: ResultadoComparacao) -> int:
        """Salva uma comparação previsão x realidade"""

        sql = """
            INSERT INTO ia_arqaprendiz (
                IDFilial, IDProd, IDGrupo,
                DatInicio, DatFim, DiasAnalise,
                QtdPrevista, CenarioUsado, ConfiancaPrev,
                QtdRealizada, QtdRuptura, DiasRuptura,
                Desvio, DesvioPerc, DesvioAbs, TipoDesvio,
                Acuracia, ClassifAcerto,
                TeveEvento, TevePromocao, TeveRuptura, FatoresJSON,
                DatCalculo
            ) VALUES (
                :id_filial, :id_prod, :id_grupo,
                :dat_inicio, :dat_fim, :dias,
                :qtd_prevista, :cenario, :confianca,
                :qtd_realizada, :qtd_ruptura, :dias_ruptura,
                :desvio, :desvio_perc, :desvio_abs, :tipo_desvio,
                :acuracia, :classificacao,
                :teve_evento, :teve_promocao, :teve_ruptura, :fatores,
                NOW()
            )
            ON DUPLICATE KEY UPDATE
                QtdPrevista = VALUES(QtdPrevista),
                QtdRealizada = VALUES(QtdRealizada),
                Desvio = VALUES(Desvio),
                DesvioPerc = VALUES(DesvioPerc),
                Acuracia = VALUES(Acuracia),
                ClassifAcerto = VALUES(ClassifAcerto),
                DatCalculo = NOW()
        """

        params = {
            'id_filial': comparacao.id_filial,
            'id_prod': comparacao.id_prod,
            'id_grupo': comparacao.id_grupo,
            'dat_inicio': comparacao.data_inicio,
            'dat_fim': comparacao.data_fim,
            'dias': comparacao.dias_analise,
            'qtd_prevista': comparacao.qtd_prevista,
            'cenario': comparacao.cenario_usado,
            'confianca': comparacao.confianca_previsao,
            'qtd_realizada': comparacao.qtd_realizada,
            'qtd_ruptura': comparacao.qtd_ruptura,
            'dias_ruptura': comparacao.dias_ruptura,
            'desvio': comparacao.desvio,
            'desvio_perc': comparacao.desvio_perc,
            'desvio_abs': comparacao.desvio_abs,
            'tipo_desvio': comparacao.tipo_desvio.value,
            'acuracia': comparacao.acuracia,
            'classificacao': comparacao.classificacao.value,
            'teve_evento': 1 if comparacao.teve_evento else 0,
            'teve_promocao': 1 if comparacao.teve_promocao else 0,
            'teve_ruptura': 1 if comparacao.teve_ruptura else 0,
            'fatores': json.dumps(comparacao.fatores, ensure_ascii=False)
        }

        return self.db.execute_insert(sql, params)

    def salvar_comparacoes_lote(self, comparacoes: List[ResultadoComparacao]) -> int:
        """Salva múltiplas comparações"""

        count = 0
        for comp in comparacoes:
            try:
                self.salvar_comparacao(comp)
                count += 1
            except Exception as e:
                self.logger.error(f"Erro ao salvar comparação prod {comp.id_prod}: {e}")

        self.logger.info(f"Salvas {count}/{len(comparacoes)} comparações")
        return count

    def listar_comparacoes(self, id_filial: int,
                           data_inicio: date = None,
                           data_fim: date = None,
                           id_prod: int = None,
                           classificacao: str = None,
                           limite: int = 100) -> List[Dict]:
        """Lista comparações com filtros"""

        conditions = ["IDFilial = :id_filial"]
        params = {'id_filial': id_filial, 'limite': limite}

        if data_inicio:
            conditions.append("DatInicio >= :dat_inicio")
            params['dat_inicio'] = data_inicio

        if data_fim:
            conditions.append("DatFim <= :dat_fim")
            params['dat_fim'] = data_fim

        if id_prod:
            conditions.append("IDProd = :id_prod")
            params['id_prod'] = id_prod

        if classificacao:
            conditions.append("ClassifAcerto = :classif")
            params['classif'] = classificacao

        sql = f"""
            SELECT a.*, p.Despro as nome_produto
            FROM ia_arqaprendiz a
            LEFT JOIN arqproduto p ON p.IDProd = a.IDProd
            WHERE {' AND '.join(conditions)}
            ORDER BY a.DatCalculo DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, params)

    def produtos_pior_acuracia(self, id_filial: int,
                                top: int = 20) -> List[Dict]:
        """Lista produtos com pior acurácia"""

        sql = """
            SELECT
                a.IDProd,
                p.Despro as nome_produto,
                AVG(a.Acuracia) as acuracia_media,
                AVG(a.DesvioPerc) as desvio_medio,
                COUNT(*) as periodos,
                SUM(a.DiasRuptura) as dias_ruptura_total
            FROM ia_arqaprendiz a
            INNER JOIN arqproduto p ON p.IDProd = a.IDProd
            WHERE a.IDFilial = :id_filial
              AND a.DatCalculo >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
            GROUP BY a.IDProd, p.Despro
            HAVING COUNT(*) >= 2
            ORDER BY acuracia_media ASC
            LIMIT :top
        """

        return self.db.execute_query(sql, {'id_filial': id_filial, 'top': top})

    # =========================================================================
    # MÉTRICAS (ia_arqmetrica)
    # =========================================================================

    def salvar_metricas(self, metricas: MetricasConsolidadas) -> int:
        """Salva métricas consolidadas"""

        sql = """
            INSERT INTO ia_arqmetrica (
                IDFilial, IDGrupo, Periodo, TipoPeriodo, DatInicio, DatFim,
                MAPE, BIAS, MAE, RMSE, AcuraciaMedia,
                QtdProdutos, QtdExcelente, QtdBom, QtdRegular, QtdRuim, QtdPessimo,
                DiasRupturaTotal, ProdutosRuptura, VlrPerdaEstim, TaxaRuptura,
                MAPEAnterior, VariacaoMAPE, Tendencia,
                DatCalculo
            ) VALUES (
                :id_filial, :id_grupo, :periodo, :tipo, :dat_inicio, :dat_fim,
                :mape, :bias, :mae, :rmse, :acuracia,
                :qtd_prod, :qtd_exc, :qtd_bom, :qtd_reg, :qtd_ruim, :qtd_pess,
                :dias_rupt, :prod_rupt, :vlr_perda, :taxa_rupt,
                :mape_ant, :var_mape, :tendencia,
                NOW()
            )
            ON DUPLICATE KEY UPDATE
                MAPE = VALUES(MAPE),
                BIAS = VALUES(BIAS),
                AcuraciaMedia = VALUES(AcuraciaMedia),
                Tendencia = VALUES(Tendencia),
                DatCalculo = NOW()
        """

        params = {
            'id_filial': metricas.id_filial,
            'id_grupo': metricas.id_grupo,
            'periodo': metricas.periodo,
            'tipo': metricas.tipo_periodo.value,
            'dat_inicio': metricas.data_inicio,
            'dat_fim': metricas.data_fim,
            'mape': metricas.mape,
            'bias': metricas.bias,
            'mae': metricas.mae,
            'rmse': metricas.rmse,
            'acuracia': metricas.acuracia_media,
            'qtd_prod': metricas.qtd_produtos,
            'qtd_exc': metricas.qtd_excelente,
            'qtd_bom': metricas.qtd_bom,
            'qtd_reg': metricas.qtd_regular,
            'qtd_ruim': metricas.qtd_ruim,
            'qtd_pess': metricas.qtd_pessimo,
            'dias_rupt': metricas.dias_ruptura_total,
            'prod_rupt': metricas.produtos_ruptura,
            'vlr_perda': metricas.vlr_perda_estimada,
            'taxa_rupt': metricas.taxa_ruptura,
            'mape_ant': metricas.mape_anterior,
            'var_mape': metricas.variacao_mape,
            'tendencia': metricas.tendencia
        }

        return self.db.execute_insert(sql, params)

    def listar_metricas(self, id_filial: int,
                        tipo_periodo: str = 'MENSAL',
                        id_grupo: int = None,
                        limite: int = 12) -> List[Dict]:
        """Lista métricas consolidadas"""

        conditions = ["IDFilial = :id_filial", "TipoPeriodo = :tipo"]
        params = {'id_filial': id_filial, 'tipo': tipo_periodo, 'limite': limite}

        if id_grupo:
            conditions.append("IDGrupo = :id_grupo")
            params['id_grupo'] = id_grupo
        else:
            conditions.append("IDGrupo IS NULL")

        sql = f"""
            SELECT *
            FROM ia_arqmetrica
            WHERE {' AND '.join(conditions)}
            ORDER BY DatInicio DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, params)

    def obter_ultima_metrica(self, id_filial: int,
                              tipo_periodo: str = 'MENSAL',
                              id_grupo: int = None) -> Dict:
        """Obtém a métrica mais recente"""

        conditions = ["IDFilial = :id_filial", "TipoPeriodo = :tipo"]
        params = {'id_filial': id_filial, 'tipo': tipo_periodo}

        if id_grupo:
            conditions.append("IDGrupo = :id_grupo")
            params['id_grupo'] = id_grupo
        else:
            conditions.append("IDGrupo IS NULL")

        sql = f"""
            SELECT *
            FROM ia_arqmetrica
            WHERE {' AND '.join(conditions)}
            ORDER BY DatInicio DESC
            LIMIT 1
        """

        result = self.db.execute_query(sql, params)
        return result[0] if result else None

    # =========================================================================
    # DASHBOARD
    # =========================================================================

    def dashboard_aprendizado(self, id_filial: int) -> Dict:
        """Retorna dados para dashboard de aprendizado"""

        # Última métrica
        ultima = self.obter_ultima_metrica(id_filial)

        # Evolução dos últimos 6 meses
        evolucao = self.listar_metricas(id_filial, 'MENSAL', None, 6)

        # Produtos com pior acurácia
        piores = self.produtos_pior_acuracia(id_filial, 10)

        # Ajustes recentes
        sql_ajustes = """
            SELECT COUNT(*) as total,
                   SUM(CASE WHEN ResultadoOK = 1 THEN 1 ELSE 0 END) as sucesso
            FROM ia_arqajuste
            WHERE IDFilial = :id_filial
              AND Aplicado = 1
              AND DatAplicacao >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        """
        ajustes = self.db.execute_query(sql_ajustes, {'id_filial': id_filial})

        return {
            'ultima_metrica': {
                'periodo': ultima.get('Periodo') if ultima else None,
                'mape': float(ultima.get('MAPE') or 0) if ultima else 0,
                'acuracia': float(ultima.get('AcuraciaMedia') or 0) if ultima else 0,
                'tendencia': ultima.get('Tendencia') if ultima else 'ESTAVEL',
                'taxa_ruptura': float(ultima.get('TaxaRuptura') or 0) if ultima else 0
            },
            'evolucao': [
                {
                    'periodo': m['Periodo'],
                    'mape': float(m['MAPE']),
                    'acuracia': float(m['AcuraciaMedia'])
                }
                for m in reversed(evolucao)
            ],
            'produtos_criticos': piores[:5],
            'ajustes_30_dias': {
                'total': ajustes[0]['total'] if ajustes else 0,
                'taxa_sucesso': (
                    (ajustes[0]['sucesso'] / ajustes[0]['total'] * 100)
                    if ajustes and ajustes[0]['total'] > 0 else 0
                )
            }
        }