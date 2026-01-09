from datetime import date, datetime, timedelta
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .comparador import Comparador, ResultadoComparacao, TipoPeriodo
from .calculador_metrica import CalculadorMetrica
from .ajustador import Ajustador
from .repositorio import AprendizadoRepositorio

class AnalisadorAprendizado:
    """
    Motor principal de aprendizado contínuo.

    Orquestra:
    1. Comparação previsão x realidade
    2. Cálculo de métricas
    3. Análise e sugestão de ajustes
    4. Aplicação de ajustes automáticos
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

        # Componentes
        self.comparador = Comparador(db)
        self.calculador = CalculadorMetrica(db)
        self.ajustador = Ajustador(db)
        self.repositorio = AprendizadoRepositorio(db)

        # Configurações
        self.config = {
            'aplicar_ajustes_automaticos': True,
            'min_acuracia_ajuste_auto': 60,  # Só ajusta se acurácia < 60%
            'dias_analise_padrao': 30
        }

    def executar_ciclo_aprendizado(self, id_filial: int,
                                    data_inicio: date = None,
                                    data_fim: date = None,
                                    aplicar_ajustes: bool = True) -> Dict:
        """
        Executa ciclo completo de aprendizado para uma filial.

        Args:
            id_filial: ID da filial
            data_inicio: Data início (default: 30 dias atrás)
            data_fim: Data fim (default: ontem)
            aplicar_ajustes: Se deve aplicar ajustes automáticos

        Returns: Resumo do ciclo executado
        """

        self.logger.info(f"Iniciando ciclo de aprendizado para filial {id_filial}")

        # Define período
        if not data_fim:
            data_fim = date.today() - timedelta(days=1)  # Ontem

        if not data_inicio:
            data_inicio = data_fim - timedelta(days=self.config['dias_analise_padrao'] - 1)

        periodo = data_inicio.strftime('%Y-%m')
        dias = (data_fim - data_inicio).days + 1

        try:
            # 1. Compara previsão x realidade
            self.logger.info("Etapa 1: Comparando previsões com realidade...")
            comparacoes = self.comparador.comparar_filial(id_filial, data_inicio, data_fim)

            # Salva comparações
            self.repositorio.salvar_comparacoes_lote(comparacoes)

            # 2. Calcula métricas consolidadas
            self.logger.info("Etapa 2: Calculando métricas...")
            metricas = self.calculador.calcular_metricas(
                resultados=comparacoes,
                id_filial=id_filial,
                periodo=periodo,
                tipo_periodo=TipoPeriodo.MENSAL,
                data_inicio=data_inicio,
                data_fim=data_fim
            )

            # Atualiza tendência
            if metricas.mape_anterior is not None:
                variacao, tendencia = self.calculador.calcular_tendencia(
                    metricas.mape, metricas.mape_anterior
                )
                metricas.variacao_mape = variacao
                metricas.tendencia = tendencia

            # Salva métricas
            self.repositorio.salvar_metricas(metricas)

            # 3. Analisa e sugere ajustes
            self.logger.info("Etapa 3: Analisando e sugerindo ajustes...")
            sugestoes = self.ajustador.analisar_e_sugerir(comparacoes, id_filial)

            # 4. Aplica ajustes automáticos se habilitado
            ajustes_aplicados = 0
            if aplicar_ajustes and self.config['aplicar_ajustes_automaticos']:
                self.logger.info("Etapa 4: Aplicando ajustes automáticos...")

                for sugestao in sugestoes:
                    if sugestao.automatico and sugestao.prioridade <= 2:
                        if self.ajustador.aplicar_ajuste(sugestao):
                            ajustes_aplicados += 1

            # Monta resumo
            resumo = {
                'sucesso': True,
                'periodo': {
                    'inicio': str(data_inicio),
                    'fim': str(data_fim),
                    'dias': dias
                },
                'comparacoes': {
                    'total': len(comparacoes),
                    'excelente': metricas.qtd_excelente,
                    'bom': metricas.qtd_bom,
                    'regular': metricas.qtd_regular,
                    'ruim': metricas.qtd_ruim,
                    'pessimo': metricas.qtd_pessimo
                },
                'metricas': {
                    'mape': metricas.mape,
                    'bias': metricas.bias,
                    'acuracia_media': metricas.acuracia_media,
                    'tendencia': metricas.tendencia,
                    'taxa_ruptura': metricas.taxa_ruptura
                },
                'ajustes': {
                    'sugeridos': len(sugestoes),
                    'aplicados': ajustes_aplicados
                }
            }

            self.logger.info(f"Ciclo concluído: MAPE={metricas.mape:.2f}%, Acurácia={metricas.acuracia_media:.1f}%")

            return resumo

        except Exception as e:
            self.logger.error(f"Erro no ciclo de aprendizado: {e}")
            return {
                'sucesso': False,
                'erro': str(e)
            }

    def executar_para_todas_filiais(self, data_inicio: date = None,
                                     data_fim: date = None) -> Dict:
        """Executa ciclo de aprendizado para todas as filiais"""

        sql = "SELECT IDFilial FROM arqfilial WHERE Ativo = '1'"
        filiais = self.db.execute_query(sql)

        resultados = {}
        total_ok = 0
        total_erro = 0

        for filial in filiais:
            id_filial = filial['IDFilial']
            resultado = self.executar_ciclo_aprendizado(
                id_filial, data_inicio, data_fim
            )
            resultados[id_filial] = resultado

            if resultado.get('sucesso'):
                total_ok += 1
            else:
                total_erro += 1

        return {
            'filiais_processadas': len(filiais),
            'sucesso': total_ok,
            'erro': total_erro,
            'detalhes': resultados
        }

    def analisar_produto(self, id_prod: int, id_filial: int,
                         meses: int = 3) -> Dict:
        """
        Análise detalhada de um produto específico.
        """

        data_fim = date.today() - timedelta(days=1)
        data_inicio = date.today() - timedelta(days=meses * 30)

        # Busca histórico de comparações
        comparacoes = self.repositorio.listar_comparacoes(
            id_filial=id_filial,
            data_inicio=data_inicio,
            data_fim=data_fim,
            id_prod=id_prod
        )

        if not comparacoes:
            return {'produto': id_prod, 'dados': 'Sem dados suficientes'}

        # Calcula médias
        acuracia_media = sum(c['Acuracia'] for c in comparacoes) / len(comparacoes)
        bias_medio = sum(c['DesvioPerc'] for c in comparacoes) / len(comparacoes)
        dias_ruptura = sum(c.get('DiasRuptura', 0) for c in comparacoes)

        # Gera sugestões específicas
        from .comparador import ResultadoComparacao, TipoDesvio, ClassificacaoAcerto

        resultados = []
        for c in comparacoes:
            r = ResultadoComparacao(
                id_filial=c['IDFilial'],
                id_prod=c['IDProd'],
                data_inicio=c['DatInicio'],
                data_fim=c['DatFim'],
                qtd_prevista=float(c['QtdPrevista']),
                qtd_realizada=float(c['QtdRealizada']),
                desvio_perc=float(c['DesvioPerc']),
                acuracia=float(c['Acuracia']),
                tipo_desvio=TipoDesvio(c['TipoDesvio']),
                classificacao=ClassificacaoAcerto(c['ClassifAcerto']),
                teve_ruptura=c.get('TeveRuptura', 0) == 1
            )
            resultados.append(r)

        sugestoes = self.ajustador._analisar_produto(id_prod, id_filial, resultados)

        return {
            'produto': id_prod,
            'periodos_analisados': len(comparacoes),
            'acuracia_media': round(acuracia_media, 2),
            'bias_medio': round(bias_medio, 2),
            'dias_ruptura_total': dias_ruptura,
            'evolucao': [
                {
                    'periodo': f"{c['DatInicio']} a {c['DatFim']}",
                    'previsto': float(c['QtdPrevista']),
                    'realizado': float(c['QtdRealizada']),
                    'acuracia': float(c['Acuracia'])
                }
                for c in comparacoes
            ],
            'sugestoes': [s.to_dict() for s in sugestoes]
        }

    def obter_dashboard(self, id_filial: int) -> Dict:
        """Retorna dados para dashboard"""

        return self.repositorio.dashboard_aprendizado(id_filial)

    def produtos_criticos(self, id_filial: int, top: int = 20) -> List[Dict]:
        """Lista produtos que precisam de atenção"""

        return self.repositorio.produtos_pior_acuracia(id_filial, top)