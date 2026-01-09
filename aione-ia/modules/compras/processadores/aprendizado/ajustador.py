from datetime import date, datetime
from typing import List, Dict, Optional

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .comparador import (
    ResultadoComparacao, SugestaoAjuste, TipoAjuste,
    TipoDesvio, ClassificacaoAcerto
)

class Ajustador:
    """
    Ajustador de parâmetros do sistema.

    Analisa resultados e sugere ajustes para melhorar previsões.
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

        # Configurações de limites para ajustes
        self.config = {
            'max_ajuste_estoque_seguranca': 0.5,   # Máximo 50% de ajuste
            'max_ajuste_sazonalidade': 0.3,        # Máximo 30% de ajuste
            'min_registros_para_ajuste': 3,        # Mínimo de períodos para ajustar
            'limiar_acuracia_ruim': 70,            # Abaixo disso, sugere ajuste
            'limiar_bias_significativo': 15        # Bias > 15% é significativo
        }

    def analisar_e_sugerir(self, resultados: List[ResultadoComparacao],
                           id_filial: int) -> List[SugestaoAjuste]:
        """
        Analisa resultados e gera sugestões de ajuste.

        Args:
            resultados: Lista de comparações
            id_filial: ID da filial

        Returns: Lista de sugestões de ajuste
        """

        sugestoes = []

        # Agrupa por produto
        por_produto = {}
        for r in resultados:
            if r.id_prod not in por_produto:
                por_produto[r.id_prod] = []
            por_produto[r.id_prod].append(r)

        # Analisa cada produto
        for id_prod, lista in por_produto.items():
            sugestoes_prod = self._analisar_produto(id_prod, id_filial, lista)
            sugestoes.extend(sugestoes_prod)

        # Ordena por prioridade
        sugestoes.sort(key=lambda s: s.prioridade)

        self.logger.info(f"Geradas {len(sugestoes)} sugestões de ajuste")

        return sugestoes

    def _analisar_produto(self, id_prod: int, id_filial: int,
                          resultados: List[ResultadoComparacao]) -> List[SugestaoAjuste]:
        """Analisa um produto e gera sugestões"""

        sugestoes = []

        if len(resultados) < self.config['min_registros_para_ajuste']:
            return sugestoes

        # Calcula médias
        acuracia_media = sum(r.acuracia for r in resultados) / len(resultados)
        bias_medio = sum(r.desvio_perc for r in resultados) / len(resultados)
        teve_rupturas = any(r.teve_ruptura for r in resultados)

        # 1. Verifica se precisa ajustar estoque de segurança
        if teve_rupturas:
            sugestao = self._sugerir_ajuste_estoque_seguranca(
                id_prod, id_filial, resultados
            )
            if sugestao:
                sugestoes.append(sugestao)

        # 2. Verifica se há bias sistemático
        if abs(bias_medio) > self.config['limiar_bias_significativo']:
            sugestao = self._sugerir_ajuste_tendencia(
                id_prod, id_filial, resultados, bias_medio
            )
            if sugestao:
                sugestoes.append(sugestao)

        # 3. Verifica se acurácia está ruim
        if acuracia_media < self.config['limiar_acuracia_ruim']:
            sugestao = self._sugerir_revisao_geral(
                id_prod, id_filial, resultados, acuracia_media
            )
            if sugestao:
                sugestoes.append(sugestao)

        return sugestoes

    def _sugerir_ajuste_estoque_seguranca(self, id_prod: int, id_filial: int,
                                           resultados: List[ResultadoComparacao]) -> Optional[SugestaoAjuste]:
        """Sugere ajuste no estoque de segurança"""

        # Busca estoque de segurança atual
        sql = """
            SELECT EstqSegur, ConsMedio
            FROM ia_arqforecast
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
        """
        result = self.db.execute_query(sql, {'id_prod': id_prod, 'id_filial': id_filial})

        if not result:
            return None

        estq_segur_atual = float(result[0].get('EstqSegur') or 0)
        cons_medio = float(result[0].get('ConsMedio') or 0)

        if cons_medio <= 0:
            return None

        # Calcula quantidade de rupturas
        total_ruptura = sum(r.qtd_ruptura for r in resultados if r.teve_ruptura)
        dias_ruptura = sum(r.dias_ruptura for r in resultados)

        # Sugere aumento proporcional ao que foi perdido
        if dias_ruptura > 0:
            aumento_sugerido = (total_ruptura / len(resultados)) * 1.5
            novo_estq_segur = estq_segur_atual + aumento_sugerido

            # Limita o ajuste máximo
            max_ajuste = estq_segur_atual * self.config['max_ajuste_estoque_seguranca']
            if aumento_sugerido > max_ajuste:
                aumento_sugerido = max_ajuste
                novo_estq_segur = estq_segur_atual + aumento_sugerido

            variacao = ((novo_estq_segur - estq_segur_atual) / estq_segur_atual * 100) if estq_segur_atual > 0 else 100

            return SugestaoAjuste(
                id_filial=id_filial,
                id_prod=id_prod,
                tipo_ajuste=TipoAjuste.ESTOQUE_SEGURANCA,
                valor_anterior=estq_segur_atual,
                valor_novo=round(novo_estq_segur, 2),
                variacao_perc=round(variacao, 2),
                motivo=f"Produto teve {dias_ruptura} dias de ruptura nos últimos períodos",
                baseado_em=f"Análise de {len(resultados)} períodos",
                prioridade=1  # Alta prioridade
            )

        return None

    def _sugerir_ajuste_tendencia(self, id_prod: int, id_filial: int,
                                   resultados: List[ResultadoComparacao],
                                   bias_medio: float) -> Optional[SugestaoAjuste]:
        """Sugere ajuste de tendência baseado no bias"""

        # Busca fator de tendência atual
        sql = """
            SELECT Tendencia, ConsMedio
            FROM ia_arqforecast
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
        """
        result = self.db.execute_query(sql, {'id_prod': id_prod, 'id_filial': id_filial})

        if not result:
            return None

        tendencia_atual = result[0].get('Tendencia', 'ESTAVEL')
        cons_medio = float(result[0].get('ConsMedio') or 0)

        # Determina ajuste baseado no bias
        # Bias positivo = está prevendo mais do que vende (superestima)
        # Bias negativo = está prevendo menos do que vende (subestima)

        if bias_medio > 0:
            # Superestimando - precisa reduzir previsão
            fator_ajuste = 1 - (min(bias_medio, 30) / 100)
            motivo = f"Previsões superestimam vendas em média {bias_medio:.1f}%"
        else:
            # Subestimando - precisa aumentar previsão
            fator_ajuste = 1 + (min(abs(bias_medio), 30) / 100)
            motivo = f"Previsões subestimam vendas em média {abs(bias_medio):.1f}%"

        cons_medio_novo = cons_medio * fator_ajuste
        variacao = ((cons_medio_novo - cons_medio) / cons_medio * 100) if cons_medio > 0 else 0

        return SugestaoAjuste(
            id_filial=id_filial,
            id_prod=id_prod,
            tipo_ajuste=TipoAjuste.TENDENCIA,
            valor_anterior=cons_medio,
            valor_novo=round(cons_medio_novo, 4),
            variacao_perc=round(variacao, 2),
            motivo=motivo,
            baseado_em=f"Bias médio de {len(resultados)} períodos",
            prioridade=2  # Média prioridade
        )

    def _sugerir_revisao_geral(self, id_prod: int, id_filial: int,
                                resultados: List[ResultadoComparacao],
                                acuracia_media: float) -> Optional[SugestaoAjuste]:
        """Sugere revisão geral do produto"""

        return SugestaoAjuste(
            id_filial=id_filial,
            id_prod=id_prod,
            tipo_ajuste=TipoAjuste.PONTO_PEDIDO,
            valor_anterior=0,
            valor_novo=0,
            variacao_perc=0,
            motivo=f"Acurácia média de apenas {acuracia_media:.1f}% - revisar parâmetros",
            baseado_em=f"Análise de {len(resultados)} períodos",
            prioridade=3  # Baixa prioridade (requer análise manual)
        )

    def aplicar_ajuste(self, sugestao: SugestaoAjuste,
                       usuario: str = "SISTEMA") -> bool:
        """
        Aplica um ajuste sugerido.

        Args:
            sugestao: Sugestão a aplicar
            usuario: Usuário que está aplicando

        Returns: True se aplicado com sucesso
        """

        try:
            if sugestao.tipo_ajuste == TipoAjuste.ESTOQUE_SEGURANCA:
                self._aplicar_ajuste_estoque_seguranca(sugestao)

            elif sugestao.tipo_ajuste == TipoAjuste.TENDENCIA:
                self._aplicar_ajuste_tendencia(sugestao)

            elif sugestao.tipo_ajuste == TipoAjuste.PONTO_PEDIDO:
                # Requer recálculo completo
                self._solicitar_recalculo(sugestao)

            # Registra ajuste aplicado
            self._registrar_ajuste(sugestao, usuario)

            self.logger.info(f"Ajuste aplicado: {sugestao.tipo_ajuste.value} para produto {sugestao.id_prod}")

            return True

        except Exception as e:
            self.logger.error(f"Erro ao aplicar ajuste: {e}")
            return False

    def _aplicar_ajuste_estoque_seguranca(self, sugestao: SugestaoAjuste):
        """Aplica ajuste no estoque de segurança"""

        sql = """
            UPDATE ia_arqforecast
            SET EstqSegur = :novo_valor
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
        """
        self.db.execute_query(sql, {
            'novo_valor': sugestao.valor_novo,
            'id_prod': sugestao.id_prod,
            'id_filial': sugestao.id_filial
        })

    def _aplicar_ajuste_tendencia(self, sugestao: SugestaoAjuste):
        """Aplica ajuste na tendência/consumo médio"""

        sql = """
            UPDATE ia_arqforecast
            SET ConsMedio = :novo_valor
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
        """
        self.db.execute_query(sql, {
            'novo_valor': sugestao.valor_novo,
            'id_prod': sugestao.id_prod,
            'id_filial': sugestao.id_filial
        })

    def _solicitar_recalculo(self, sugestao: SugestaoAjuste):
        """Marca produto para recálculo completo do forecast"""

        sql = """
            UPDATE ia_arqforecast
            SET DatValidade = CURDATE()
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
        """
        self.db.execute_query(sql, {
            'id_prod': sugestao.id_prod,
            'id_filial': sugestao.id_filial
        })

    def _registrar_ajuste(self, sugestao: SugestaoAjuste, usuario: str):
        """Registra ajuste no histórico"""

        sql = """
            INSERT INTO ia_arqajuste (
                IDFilial, IDProd, IDGrupo,
                TipoAjuste, ValorAnterior, ValorNovo, VariacaoPerc,
                MotivoAjuste, BaseadoEm,
                Automatico, Aplicado, DatAplicacao, UserAplicacao,
                DatCriacao
            ) VALUES (
                :id_filial, :id_prod, :id_grupo,
                :tipo, :anterior, :novo, :variacao,
                :motivo, :baseado,
                :auto, 1, NOW(), :usuario,
                NOW()
            )
        """

        self.db.execute_insert(sql, {
            'id_filial': sugestao.id_filial,
            'id_prod': sugestao.id_prod,
            'id_grupo': sugestao.id_grupo,
            'tipo': sugestao.tipo_ajuste.value,
            'anterior': sugestao.valor_anterior,
            'novo': sugestao.valor_novo,
            'variacao': sugestao.variacao_perc,
            'motivo': sugestao.motivo,
            'baseado': sugestao.baseado_em,
            'auto': 1 if sugestao.automatico else 0,
            'usuario': usuario
        })

    def listar_ajustes_pendentes(self, id_filial: int) -> List[Dict]:
        """Lista ajustes sugeridos mas não aplicados"""

        sql = """
            SELECT *
            FROM ia_arqajuste
            WHERE IDFilial = :id_filial
              AND Aplicado = 0
            ORDER BY DatCriacao DESC
        """
        return self.db.execute_query(sql, {'id_filial': id_filial})

    def historico_ajustes(self, id_filial: int,
                          id_prod: int = None,
                          dias: int = 30) -> List[Dict]:
        """Histórico de ajustes aplicados"""

        conditions = ["IDFilial = :id_filial", "Aplicado = 1"]
        params = {'id_filial': id_filial, 'dias': dias}

        if id_prod:
            conditions.append("IDProd = :id_prod")
            params['id_prod'] = id_prod

        sql = f"""
            SELECT *
            FROM ia_arqajuste
            WHERE {' AND '.join(conditions)}
              AND DatAplicacao >= DATE_SUB(CURDATE(), INTERVAL :dias DAY)
            ORDER BY DatAplicacao DESC
        """
        return self.db.execute_query(sql, params)