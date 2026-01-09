"""
AIONE IA - Priorizador de Necessidades
Calculador de prioridade de necessidades de compra
"""

from datetime import date
from typing import Dict, List

from core.database import DatabaseManager
from core.utils.logger import get_logger

from .gerador import Prioridade, NecessidadeItem, ParametrosNecessidade


class Priorizador:
    """Calculador de prioridade de necessidades de compra"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def calcular_prioridade(self, item: NecessidadeItem,
                            parametros: ParametrosNecessidade = None) -> NecessidadeItem:
        """
        Calcula prioridade de um item de necessidade.

        Critérios (em ordem):
        1. URGENTE: Estoque zerado OU dias cobertura < 3 OU risco > 50%
        2. ALTA: Abaixo do ponto de pedido
        3. NORMAL: Abaixo do estoque ideal (cobertura < alvo)
        4. BAIXA: Oportunidade (evento futuro, promoção)

        Score de priorização (0-1000):
        - Base pela prioridade: URGENTE=800, ALTA=600, NORMAL=400, BAIXA=200
        - Ajustes:
          - Curva A: +100
          - Risco ruptura: +risco*100
          - Dias cobertura: +(30-dias)*5
          - Classificação SAUDAVEL: +50
        """
        params = parametros or ParametrosNecessidade()

        # Determina prioridade
        prioridade = self._determinar_prioridade(item, params)
        item.prioridade = prioridade

        # Calcula score
        score = self._calcular_score(item, params)
        item.score_prioridade = score

        # Gera motivo
        item.motivo_necessidade = self._gerar_motivo(item, params)

        return item

    def _determinar_prioridade(self, item: NecessidadeItem,
                               params: ParametrosNecessidade) -> Prioridade:
        """Determina prioridade baseado nos critérios"""

        # URGENTE: Situação crítica
        if item.estoque_atual <= 0:
            return Prioridade.URGENTE

        if item.dias_cobertura < params.dias_ruptura_urgente:
            return Prioridade.URGENTE

        if item.risco_ruptura > params.risco_ruptura_urgente:
            return Prioridade.URGENTE

        # ALTA: Abaixo do ponto de pedido
        if item.estoque_atual < item.ponto_pedido:
            return Prioridade.ALTA

        # NORMAL: Abaixo da cobertura alvo
        if item.dias_cobertura < params.dias_cobertura_alvo:
            return Prioridade.NORMAL

        # BAIXA: Oportunidade
        return Prioridade.BAIXA

    def _calcular_score(self, item: NecessidadeItem,
                        params: ParametrosNecessidade) -> int:
        """
        Calcula score de priorização (0-1000).
        Quanto maior, mais prioritário.
        """
        # Score base pela prioridade
        base_scores = {
            Prioridade.URGENTE: 800,
            Prioridade.ALTA: 600,
            Prioridade.NORMAL: 400,
            Prioridade.BAIXA: 200
        }
        score = base_scores.get(item.prioridade, 400)

        # Ajuste por curva ABC
        curva_bonus = {'A': 100, 'B': 50, 'C': 25, 'D': 0}
        score += curva_bonus.get(item.curva_abc, 0)

        # Ajuste por risco de ruptura (0-100 pontos)
        score += int(item.risco_ruptura * 100)

        # Ajuste por dias de cobertura (quanto menor, maior prioridade)
        if item.dias_cobertura < 30:
            score += int((30 - item.dias_cobertura) * 3)

        # Ajuste por classificação do produto
        if item.classif_produto == 'SAUDAVEL':
            score += 30  # Produtos saudáveis têm prioridade
        elif item.classif_produto == 'TOXICO':
            score -= 100  # Produtos tóxicos perdem prioridade

        # Limita entre 0 e 1000
        return max(0, min(1000, score))

    def _gerar_motivo(self, item: NecessidadeItem,
                      params: ParametrosNecessidade) -> str:
        """Gera texto explicativo do motivo da necessidade"""
        motivos = []

        if item.estoque_atual <= 0:
            motivos.append("Estoque zerado")
        elif item.dias_cobertura < params.dias_ruptura_urgente:
            motivos.append(f"Cobertura de apenas {item.dias_cobertura:.0f} dia(s)")
        elif item.risco_ruptura > params.risco_ruptura_urgente:
            motivos.append(f"Risco de ruptura {item.risco_ruptura*100:.0f}%")
        elif item.estoque_atual < item.ponto_pedido:
            motivos.append("Abaixo do ponto de pedido")
        elif item.dias_cobertura < params.dias_cobertura_alvo:
            motivos.append(f"Cobertura abaixo do alvo ({item.dias_cobertura:.0f}/{params.dias_cobertura_alvo} dias)")
        else:
            motivos.append("Reposição programada")

        if item.curva_abc == 'A':
            motivos.append("Produto curva A")

        return "; ".join(motivos)

    def priorizar_lista(self, itens: List[NecessidadeItem],
                        parametros: ParametrosNecessidade = None) -> List[NecessidadeItem]:
        """
        Calcula prioridade de uma lista de itens e ordena.
        Retorna ordenado por score_prioridade DESC.
        """
        params = parametros or ParametrosNecessidade()

        # Calcula prioridade de cada item
        for item in itens:
            self.calcular_prioridade(item, params)

        # Ordena por score (maior primeiro)
        itens.sort(key=lambda x: x.score_prioridade, reverse=True)

        return itens

    def resumo_prioridades(self, itens: List[NecessidadeItem]) -> Dict:
        """Retorna resumo das prioridades."""
        if not itens:
            return {
                'total': 0,
                'urgente': 0,
                'alta': 0,
                'normal': 0,
                'baixa': 0,
                'bloqueados': 0,
                'score_medio': 0
            }

        return {
            'total': len(itens),
            'urgente': sum(1 for i in itens if i.prioridade == Prioridade.URGENTE),
            'alta': sum(1 for i in itens if i.prioridade == Prioridade.ALTA),
            'normal': sum(1 for i in itens if i.prioridade == Prioridade.NORMAL),
            'baixa': sum(1 for i in itens if i.prioridade == Prioridade.BAIXA),
            'bloqueados': sum(1 for i in itens if i.bloqueado),
            'score_medio': sum(i.score_prioridade for i in itens) / len(itens) if itens else 0
        }
