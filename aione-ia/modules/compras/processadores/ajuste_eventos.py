"""
AIONE IA - Ajustador de Eventos
Ajustar previsões de demanda baseado em eventos futuros detectados pelos coletores
"""

from datetime import date, timedelta
from typing import List, Dict, Optional
from decimal import Decimal
import json
from sqlalchemy import text

from core.database import DatabaseManager
from core.utils.logger import get_logger


class AjustadorEventos:
    """Ajustador de forecast baseado em eventos e alertas"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

        # Cache para correlações frequentemente usadas
        self._cache_correlacoes = {}

        # Mapeamento de categorias para grupos de produtos
        # Deve ser configurado conforme cadastro do cliente
        self.CATEGORIAS_GRUPOS = {
            'antigripais': [1],
            'antitérmicos': [1, 2],
            'vitaminas': [3],
            'vitamina_c': [3],
            'vitaminas_infantis': [3],
            'hidratantes': [4],
            'hidratantes_labiais': [4],
            'protetor_solar': [5],
            'protetores_solar': [5],
            'soro': [6],
            'soro_fisiologico': [6],
            'repelentes': [7],
            'analgésicos': [8],
            'descongestionantes': [9],
            'antialérgicos': [10],
            'colirios': [11],
            'máscaras': [12],
            'preservativos': [13],
            'antiácidos': [14],
            'perfumaria': [15],
            'dermocosméticos': [16],
            'piolhicidas': [17]
        }

        # Multiplicadores de severidade
        self.MULT_SEVERIDADE = {
            'BAIXA': 0.5,
            'MEDIA': 1.0,
            'ALTA': 1.5,
            'CRITICA': 2.0
        }

    # =========================================================================
    # MÉTODOS DE BUSCA
    # =========================================================================

    def obter_eventos_periodo(self, data_inicio: date, data_fim: date,
                              id_regiao: int = None) -> List[Dict]:
        """
        Busca eventos ativos no período.
        """
        try:
            sql = """
                SELECT
                    IDEvento, TipoEvt, DescEvt,
                    DatInicio, DatFinal,
                    IDRegiao, PercImpac, Categor
                FROM ia_arqeventos
                WHERE DatInicio <= :data_fim
                  AND DatFinal >= :data_inicio
                  AND (IDRegiao = :id_regiao OR IDRegiao IS NULL)
                ORDER BY DatInicio
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'data_inicio': data_inicio,
                    'data_fim': data_fim,
                    'id_regiao': id_regiao
                })
                eventos = [dict(row._mapping) for row in result.fetchall()]

            self.logger.debug(f"Eventos encontrados no período: {len(eventos)}")
            return eventos

        except Exception as e:
            self.logger.error(f"Erro ao buscar eventos: {e}")
            return []

    def obter_alertas_ativos(self, id_regiao: int = None) -> List[Dict]:
        """
        Busca alertas não expirados.
        """
        try:
            sql = """
                SELECT
                    IDAlerta, TipAlerta, Severidade,
                    IDRegiao, DatInicio, DatFinal,
                    DescAlert, AcaoSuger
                FROM ia_arqalertaex
                WHERE DatFinal >= CURDATE()
                  AND (IDRegiao = :id_regiao OR IDRegiao IS NULL)
                ORDER BY
                    FIELD(Severidade, 'CRITICA', 'ALTA', 'MEDIA', 'BAIXA'),
                    DatInicio
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {'id_regiao': id_regiao})
                alertas = [dict(row._mapping) for row in result.fetchall()]

            self.logger.debug(f"Alertas ativos encontrados: {len(alertas)}")
            return alertas

        except Exception as e:
            self.logger.error(f"Erro ao buscar alertas: {e}")
            return []

    def obter_correlacoes_produto(self, id_prod: int,
                                   id_grupo: int = None) -> List[Dict]:
        """
        Busca correlações aplicáveis ao produto.
        Prioridade: Produto específico > Grupo > Geral
        """
        try:
            # Verificar cache
            cache_key = f"{id_prod}_{id_grupo}"
            if cache_key in self._cache_correlacoes:
                return self._cache_correlacoes[cache_key]

            sql = """
                SELECT
                    IDCorrel, TipoEvento, IDGrupo, IDCateg, IDProd,
                    PercImpac, DiasAntes, DiasDurac, Confianca, Origem
                FROM ia_arqcorrelac
                WHERE (IDProd = :id_prod OR IDProd IS NULL)
                  AND (IDGrupo = :id_grupo OR IDGrupo IS NULL)
                ORDER BY
                    CASE WHEN IDProd IS NOT NULL THEN 1
                         WHEN IDGrupo IS NOT NULL THEN 2
                         ELSE 3 END
            """

            with self.db.session_scope() as session:
                result = session.execute(text(sql), {
                    'id_prod': id_prod,
                    'id_grupo': id_grupo
                })
                correlacoes = [dict(row._mapping) for row in result.fetchall()]

            # Cachear resultado
            self._cache_correlacoes[cache_key] = correlacoes

            self.logger.debug(f"Correlações encontradas para produto {id_prod}: {len(correlacoes)}")
            return correlacoes

        except Exception as e:
            self.logger.error(f"Erro ao buscar correlações: {e}")
            return []

    # =========================================================================
    # MÉTODOS DE CÁLCULO
    # =========================================================================

    def calcular_impacto_evento(self, evento: Dict,
                                id_prod: int,
                                id_grupo: int) -> Dict:
        """
        Calcula impacto de um evento específico no produto.
        """
        try:
            # Verifica se produto pertence às categorias do evento
            categorias_evento = self._parse_categorias(evento.get('Categor'))

            if not self._produto_afetado(id_grupo, categorias_evento):
                return {'aplicavel': False}

            impacto_base = float(evento.get('PercImpac', 0)) / 100.0  # Converte % para decimal

            # Busca correlação específica
            correlacoes = self.obter_correlacoes_produto(id_prod, id_grupo)
            correlacao = self._encontrar_correlacao(correlacoes, evento.get('TipoEvt'))

            if correlacao:
                impacto_base = float(correlacao.get('PercImpac', 0)) / 100.0
                self.logger.debug(f"Correlação encontrada para evento {evento.get('TipoEvt')}: {impacto_base:.2%}")

            impacto_final = {
                'evento': evento.get('DescEvt'),
                'tipo': evento.get('TipoEvt'),
                'impacto_percentual': 1.0 + impacto_base,  # Ex: +50% = 1.5
                'data_inicio_impacto': evento.get('DatInicio'),
                'data_fim_impacto': evento.get('DatFinal'),
                'confianca': float(correlacao.get('Confianca', 50)) if correlacao else 50.0,
                'correlacao_id': correlacao.get('IDCorrel') if correlacao else None,
                'aplicavel': True
            }

            self.logger.info(f"Impacto evento calculado: {evento.get('DescEvt')} = {impacto_base:.1%}")
            return impacto_final

        except Exception as e:
            self.logger.error(f"Erro ao calcular impacto do evento: {e}")
            return {'aplicavel': False}

    def calcular_impacto_alerta(self, alerta: Dict,
                                id_prod: int,
                                id_grupo: int) -> Dict:
        """
        Calcula impacto de um alerta no produto.
        """
        try:
            tipo_alerta = alerta.get('TipAlerta')
            severidade = alerta.get('Severidade', 'MEDIA')

            # Mapeia tipo de alerta para categorias
            categorias_alerta = self._categorias_por_tipo_alerta(tipo_alerta)

            if not self._produto_afetado(id_grupo, categorias_alerta):
                return {'aplicavel': False}

            # Busca correlação
            correlacoes = self.obter_correlacoes_produto(id_prod, id_grupo)
            correlacao = self._encontrar_correlacao(correlacoes, tipo_alerta)

            if correlacao:
                impacto_base = float(correlacao.get('PercImpac', 0)) / 100.0
            else:
                impacto_base = 0.3  # 30% padrão

            # Aplica multiplicador de severidade
            mult = self.MULT_SEVERIDADE.get(severidade, 1.0)
            impacto_final_valor = impacto_base * mult

            impacto_final = {
                'alerta': alerta.get('DescAlert'),
                'tipo': tipo_alerta,
                'severidade': severidade,
                'impacto_percentual': 1.0 + impacto_final_valor,
                'data_inicio_impacto': alerta.get('DatInicio'),
                'data_fim_impacto': alerta.get('DatFinal'),
                'multiplicador_severidade': mult,
                'correlacao_id': correlacao.get('IDCorrel') if correlacao else None,
                'aplicavel': True
            }

            self.logger.info(f"Impacto alerta calculado: {tipo_alerta} ({severidade}) = {impacto_final_valor:.1%}")
            return impacto_final

        except Exception as e:
            self.logger.error(f"Erro ao calcular impacto do alerta: {e}")
            return {'aplicavel': False}

    def combinar_impactos(self, impactos: List[Dict]) -> float:
        """
        Combina múltiplos impactos em um fator único.

        Regras:
        - Impactos do mesmo tipo: usa o maior
        - Impactos de tipos diferentes: multiplica
        - Limite máximo: 3.0 (300%)
        - Limite mínimo: 0.5 (50%)
        """
        try:
            if not impactos:
                return 1.0

            # Agrupa por tipo, pega maior de cada tipo
            por_tipo = {}
            for imp in impactos:
                if not imp.get('aplicavel', False):
                    continue

                tipo = imp.get('tipo', 'OUTROS')
                valor = float(imp.get('impacto_percentual', 1.0))

                if tipo not in por_tipo or valor > por_tipo[tipo]:
                    por_tipo[tipo] = valor

            if not por_tipo:
                return 1.0

            # Multiplica impactos de tipos diferentes
            fator_final = 1.0
            for tipo, valor in por_tipo.items():
                fator_multiplicativo = valor  # valor já é 1 + percentual
                fator_final *= fator_multiplicativo

            # Aplica limites
            fator_limitado = max(0.5, min(3.0, fator_final))

            self.logger.debug(f"Combinação de impactos: {len(por_tipo)} tipos → fator {fator_limitado:.2f}")
            return float(fator_limitado)

        except Exception as e:
            self.logger.error(f"Erro ao combinar impactos: {e}")
            return 1.0

    # =========================================================================
    # MÉTODO PRINCIPAL
    # =========================================================================

    def calcular_ajustes(self, id_prod: int,
                          id_grupo: int,
                          id_filial: int,
                          id_regiao: int,
                          data_inicio: date,
                          data_fim: date) -> Dict:
        """
        Calcula todos os ajustes aplicáveis ao produto no período.

        Returns: {
            'fator_ajuste': float,
            'eventos_aplicados': List[Dict],
            'alertas_aplicados': List[Dict],
            'correlacoes_usadas': List[int],
            'detalhamento_diario': List[Dict],
            'recomendacao': str
        }
        """
        try:
            self.logger.info(
                f"Calculando ajustes para produto {id_prod} (grupo {id_grupo}) "
                f"no período {data_inicio} a {data_fim}"
            )

            eventos_aplicados = []
            alertas_aplicados = []
            correlacoes_usadas = []
            detalhamento_diario = []

            # Busca eventos
            eventos = self.obter_eventos_periodo(data_inicio, data_fim, id_regiao)
            for evento in eventos:
                impacto = self.calcular_impacto_evento(evento, id_prod, id_grupo)
                if impacto.get('aplicavel'):
                    eventos_aplicados.append(impacto)
                    if impacto.get('correlacao_id'):
                        correlacoes_usadas.append(impacto['correlacao_id'])

            # Calcular impactos de alertas
            alertas = self.obter_alertas_ativos(id_regiao)
            for alerta in alertas:
                impacto = self.calcular_impacto_alerta(alerta, id_prod, id_grupo)
                if impacto.get('aplicavel'):
                    alertas_aplicados.append(impacto)
                    if impacto.get('correlacao_id'):
                        correlacoes_usadas.append(impacto['correlacao_id'])

            # Combinar todos os impactos
            todos_impactos = eventos_aplicados + alertas_aplicados
            fator_ajuste = self.combinar_impactos(todos_impactos)

            # Gerar detalhamento diário
            data_atual = data_inicio
            while data_atual <= data_fim:
                impactos_dia = []

                # Verificar eventos ativos no dia
                for evento in eventos_aplicados:
                    if (evento.get('data_inicio_impacto', data_inicio) <= data_atual <=
                        evento.get('data_fim_impacto', data_fim)):
                        impactos_dia.append(evento)

                # Verificar alertas ativos no dia
                for alerta in alertas_aplicados:
                    if (alerta.get('data_inicio_impacto', data_inicio) <= data_atual <=
                        alerta.get('data_fim_impacto', data_fim)):
                        impactos_dia.append(alerta)

                fator_dia = self.combinar_impactos(impactos_dia)

                detalhamento_diario.append({
                    'data': data_atual,
                    'fator_ajuste': fator_dia,
                    'eventos_ativos': len([i for i in impactos_dia if 'evento' in i]),
                    'alertas_ativos': len([i for i in impactos_dia if 'alerta' in i])
                })

                data_atual += timedelta(days=1)

            # Monta recomendação
            recomendacao = self._gerar_recomendacao(
                fator_ajuste, len(eventos_aplicados), len(alertas_aplicados)
            )

            resultado = {
                'fator_ajuste': float(fator_ajuste),
                'eventos_aplicados': eventos_aplicados,
                'alertas_aplicados': alertas_aplicados,
                'correlacoes_usadas': list(set(correlacoes_usadas)),  # Remover duplicatas
                'detalhamento_diario': detalhamento_diario,
                'recomendacao': recomendacao
            }

            self.logger.info(
                f"Ajuste calculado: {fator_ajuste:.2f} "
                f"({len(eventos_aplicados)} eventos, {len(alertas_aplicados)} alertas)"
            )

            return resultado

        except Exception as e:
            self.logger.error(f"Erro ao calcular ajustes: {e}")
            return {
                'fator_ajuste': 1.0,
                'eventos_aplicados': [],
                'alertas_aplicados': [],
                'correlacoes_usadas': [],
                'detalhamento_diario': [],
                'recomendacao': 'Erro no cálculo - sem ajuste aplicado'
            }

    def aplicar_ajuste_cenario(self, valor_base: float,
                               fator_ajuste: float,
                               tipo_cenario: str) -> float:
        """
        Aplica ajuste a um cenário específico de forecast.

        Args:
            valor_base: Valor original do cenário
            fator_ajuste: Fator de ajuste calculado
            tipo_cenario: Tipo do cenário ('OTIMISTA', 'CONSERVADOR', 'CRITICO')

        Returns:
            Valor ajustado
        """
        try:
            if valor_base <= 0 or fator_ajuste == 1.0:
                return valor_base

            # Ajuste percentual baseado no fator
            ajuste_percentual = fator_ajuste - 1.0  # Ex: 1.5 -> +0.5 (+50%)

            # Aplicar modificador por cenário
            if tipo_cenario == 'OTIMISTA':
                # Cenário otimista: reduz impacto de eventos negativos, amplifica positivos
                if ajuste_percentual > 0:
                    modificador = 1.2  # +20% no impacto positivo
                else:
                    modificador = 0.5  # -50% no impacto negativo
            elif tipo_cenario == 'CRITICO':
                # Cenário crítico: amplifica impacto de eventos negativos, reduz positivos
                if ajuste_percentual > 0:
                    modificador = 0.7  # -30% no impacto positivo
                else:
                    modificador = 1.3  # +30% no impacto negativo
            else:  # CONSERVADOR
                modificador = 1.0  # Aplica ajuste integral

            ajuste_final = ajuste_percentual * modificador
            resultado = valor_base * (1.0 + ajuste_final)

            self.logger.debug(
                f"Ajuste aplicado: {valor_base:.2f} → {resultado:.2f} "
                f"(fator: {fator_ajuste:.2f}, cenário: {tipo_cenario})"
            )

            return max(0.0, resultado)  # Não pode ser negativo

        except Exception as e:
            self.logger.error(f"Erro ao aplicar ajuste ao cenário: {e}")
            return valor_base

    # =========================================================================
    # MÉTODOS AUXILIARES
    # =========================================================================

    def _parse_categorias(self, categorias_json: str) -> List[str]:
        """Parse JSON de categorias"""
        if not categorias_json:
            return []

        try:
            if isinstance(categorias_json, list):
                return categorias_json
            if isinstance(categorias_json, str):
                # Tentar como JSON
                try:
                    return json.loads(categorias_json)
                except json.JSONDecodeError:
                    # Tentar como string separada por vírgulas
                    return [cat.strip().lower() for cat in categorias_json.split(',')]
            return []
        except Exception as e:
            self.logger.warning(f"Erro ao parsear categorias '{categorias_json}': {e}")
            return []

    def _produto_afetado(self, id_grupo: int, categorias: List[str]) -> bool:
        """Verifica se grupo do produto está nas categorias"""
        if not categorias or not id_grupo:
            return False

        try:
            for categoria in categorias:
                categoria_lower = str(categoria).lower()
                grupos = self.CATEGORIAS_GRUPOS.get(categoria_lower, [])
                if id_grupo in grupos:
                    self.logger.debug(f"Produto grupo {id_grupo} afetado pela categoria '{categoria_lower}'")
                    return True

            return False

        except Exception as e:
            self.logger.warning(f"Erro ao verificar se produto afetado: {e}")
            return False

    def _encontrar_correlacao(self, correlacoes: List[Dict], tipo_evento: str) -> Optional[Dict]:
        """Encontra correlação mais específica para o tipo de evento"""
        try:
            for corr in correlacoes:
                if corr.get('TipoEvento') == tipo_evento:
                    return corr
            return None
        except Exception as e:
            self.logger.warning(f"Erro ao encontrar correlação: {e}")
            return None

    def _categorias_por_tipo_alerta(self, tipo_alerta: str) -> List[str]:
        """Retorna categorias afetadas por tipo de alerta"""
        mapeamento = {
            'ONDA_FRIO': ['antigripais', 'vitaminas', 'hidratantes'],
            'ONDA_CALOR': ['hidratantes', 'protetor_solar', 'soro'],
            'TEMPO_SECO': ['soro_fisiologico', 'colirios', 'hidratantes'],
            'SURTO': ['antigripais', 'antitérmicos', 'máscaras'],
            'TENDENCIA_ALTA': [],  # Genérico
            'EVENTO_GRANDE': ['preservativos', 'antiácidos', 'analgésicos'],
            'EPOCA_GRIPAL': ['antigripais', 'antitérmicos', 'vitaminas', 'máscaras'],
            'VERAO': ['protetor_solar', 'hidratantes', 'repelentes'],
            'INVERNO': ['antigripais', 'vitaminas', 'hidratantes'],
            'CARNAVAL': ['preservativos', 'antiácidos', 'hidratantes'],
            'FESTA_JUNINA': ['antigripais', 'antiácidos'],
            'VOLTA_AULAS': ['vitaminas_infantis', 'piolhicidas']
        }

        return mapeamento.get(tipo_alerta, [])

    def _gerar_recomendacao(self, fator: float, qtd_eventos: int, qtd_alertas: int) -> str:
        """Gera texto de recomendação"""
        try:
            if fator == 1.0:
                return "Sem ajustes de eventos identificados"

            partes = []

            if qtd_eventos > 0:
                partes.append(f"{qtd_eventos} evento(s) afetando demanda")

            if qtd_alertas > 0:
                partes.append(f"{qtd_alertas} alerta(s) ativo(s)")

            # Interpretação do fator
            if fator > 1.5:
                impacto = "Aumento significativo"
                variacao = f"+{(fator-1)*100:.0f}%"
            elif fator > 1.1:
                impacto = "Aumento moderado"
                variacao = f"+{(fator-1)*100:.0f}%"
            elif fator < 0.8:
                impacto = "Redução significativa"
                variacao = f"-{(1-fator)*100:.0f}%"
            elif fator < 0.9:
                impacto = "Redução moderada"
                variacao = f"-{(1-fator)*100:.0f}%"
            else:
                impacto = "Ajuste leve"
                if fator > 1:
                    variacao = f"+{(fator-1)*100:.0f}%"
                else:
                    variacao = f"-{(1-fator)*100:.0f}%"

            partes.append(f"{impacto} ({variacao}) na demanda esperada")

            return ". ".join(partes)

        except Exception as e:
            self.logger.warning(f"Erro ao gerar recomendação: {e}")
            return f"Fator de ajuste: {fator:.2f}"

    def limpar_cache(self):
        """Limpa cache de correlações"""
        self._cache_correlacoes.clear()
        self.logger.info("Cache de correlações limpo")