"""
AIONE IA - Agrupador de Pedidos
Agrupador de necessidades em pedidos por fornecedor
"""

from datetime import datetime
from typing import Dict, List, Optional
from collections import defaultdict

from core.database import DatabaseManager
from core.utils.logger import get_logger

from .gerador import NecessidadeItem, PedidoSugerido, ParametrosNecessidade, Prioridade
from .sugestor_forn import SugestorFornecedor


class AgrupadorPedidos:
    """Agrupador de necessidades em pedidos por fornecedor"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)
        self.sugestor = SugestorFornecedor(db)

    def agrupar_por_fornecedor(self, itens: List[NecessidadeItem],
                               parametros: ParametrosNecessidade = None) -> List[PedidoSugerido]:
        """
        Agrupa necessidades em pedidos por fornecedor.

        Regras:
        1. Agrupa itens pelo fornecedor sugerido
        2. Busca condições comerciais do fornecedor
        3. Verifica se atinge pedido mínimo
        4. Se não atinge, pode:
           - Adicionar itens oportunidade
           - Ou marcar como abaixo do mínimo
        """
        params = parametros or ParametrosNecessidade()

        # Agrupa por fornecedor
        por_fornecedor = defaultdict(list)

        for item in itens:
            if item.cnpj_fornecedor and not item.bloqueado:
                por_fornecedor[item.cnpj_fornecedor].append(item)

        # Cria pedidos
        pedidos = []

        for cnpj, itens_forn in por_fornecedor.items():
            if not itens_forn:
                continue

            # Busca dados do fornecedor
            primeiro_item = itens_forn[0]
            condicoes = self.sugestor.obter_condicoes_fornecedor(cnpj, primeiro_item.id_filial)

            # Busca score e classificação
            score_forn = self._obter_score_fornecedor(cnpj, primeiro_item.id_filial)

            pedido = PedidoSugerido(
                id_filial=primeiro_item.id_filial,
                cnpj_fornecedor=cnpj,
                nome_fornecedor=primeiro_item.nome_fornecedor or cnpj,
                score_fornecedor=score_forn.get('score'),
                classif_fornecedor=score_forn.get('classificacao'),
                vlr_minimo_pedido=condicoes.get('pedido_minimo'),
                prazo_pgto=condicoes.get('prazo_pgto'),
                lead_time=condicoes.get('lead_time')
            )

            # Adiciona itens
            for item in itens_forn:
                pedido.adicionar_item(item)

            pedidos.append(pedido)

        # Ordena pedidos por prioridade máxima
        pedidos.sort(key=lambda p: (
            {'URGENTE': 4, 'ALTA': 3, 'NORMAL': 2, 'BAIXA': 1}.get(p.prioridade_max.value, 0),
            p.vlr_total
        ), reverse=True)

        self.logger.info(f"Gerados {len(pedidos)} pedidos a partir de {len(itens)} itens")

        return pedidos

    def _obter_score_fornecedor(self, cnpj: str, id_filial: int) -> Dict:
        """Obtém score e classificação do fornecedor"""
        sql = """
            SELECT ScoreGeral as score, Classificacao as classificacao
            FROM ia_arqfornscor
            WHERE CNPJForn = :cnpj
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
            LIMIT 1
        """

        result = self.db.executar_query(sql, {'cnpj': cnpj, 'id_filial': id_filial})

        if result:
            return {
                'score': float(result[0]['score'] or 0),
                'classificacao': result[0]['classificacao']
            }

        return {'score': 50, 'classificacao': None}

    def completar_pedido_minimo(self, pedido: PedidoSugerido,
                                id_filial: int,
                                parametros: ParametrosNecessidade = None) -> PedidoSugerido:
        """
        Tenta completar um pedido que não atingiu o mínimo.

        Busca produtos do mesmo fornecedor que poderiam ser comprados
        como oportunidade para atingir o mínimo.
        """
        if pedido.atinge_minimo or not pedido.vlr_minimo_pedido:
            return pedido

        falta = pedido.vlr_minimo_pedido - pedido.vlr_total

        # Busca produtos do fornecedor que não estão no pedido
        produtos_existentes = {item.id_prod for item in pedido.itens}
        ids_str = ','.join(str(p) for p in produtos_existentes) if produtos_existentes else '0'

        sql = f"""
            SELECT DISTINCT
                h.IDProd,
                p.Despro,
                p.IDGrupo,
                AVG(h.VlrMovi) as preco_medio,
                fc.DiasCobre,
                fc.EstqAtual,
                fc.ConsMedio
            FROM ia_arqhistcom h
            INNER JOIN arqproduto p ON p.IDProd = h.IDProd
            LEFT JOIN ia_arqforecast fc ON fc.IDProd = h.IDProd
                                        AND fc.IDFilial = h.IDFilial
                                        AND fc.Status = 'ATIVO'
            LEFT JOIN ia_arqprodclas pc ON pc.IDProd = h.IDProd
                                        AND pc.IDFilial = h.IDFilial
                                        AND pc.Status = 'ATIVO'
            WHERE h.CpfCnpj = :cnpj
              AND h.IDFilial = :id_filial
              AND h.TipoHist = 'ENTRADA'
              AND h.IDProd NOT IN ({ids_str})
              AND p.Ativo = '1'
              AND (pc.Classif IS NULL OR pc.Classif != 'TOXICO')
              AND (fc.DiasCobre IS NULL OR fc.DiasCobre < 60)
            ORDER BY fc.DiasCobre ASC
            LIMIT 10
        """

        result = self.db.executar_query(sql, {
            'cnpj': pedido.cnpj_fornecedor,
            'id_filial': id_filial
        }) or []

        for prod in result:
            if pedido.vlr_total >= pedido.vlr_minimo_pedido:
                break

            # Cria item oportunidade
            preco = float(prod.get('preco_medio') or 0)
            cons_medio = float(prod.get('ConsMedio') or 0)

            if preco <= 0 or cons_medio <= 0:
                continue

            # Quantidade para 15 dias
            qtd = cons_medio * 15

            item = NecessidadeItem(
                id_filial=id_filial,
                id_prod=prod['IDProd'],
                id_grupo=prod.get('IDGrupo'),
                nome_produto=prod.get('Despro', ''),
                prioridade=Prioridade.BAIXA,
                score_prioridade=100,
                estoque_atual=float(prod.get('EstqAtual') or 0),
                dias_cobertura=float(prod.get('DiasCobre') or 30),
                qtd_sugerida=qtd,
                cnpj_fornecedor=pedido.cnpj_fornecedor,
                nome_fornecedor=pedido.nome_fornecedor,
                preco_sugerido=preco,
                vlr_total=round(preco * qtd, 2),
                motivo_necessidade="Oportunidade para atingir pedido mínimo"
            )

            pedido.adicionar_item(item)

        return pedido

    def resumo_pedidos(self, pedidos: List[PedidoSugerido]) -> Dict:
        """Retorna resumo dos pedidos gerados"""
        if not pedidos:
            return {
                'total_pedidos': 0,
                'total_itens': 0,
                'vlr_total': 0,
                'pedidos_urgentes': 0,
                'pedidos_abaixo_minimo': 0,
                'por_classificacao_forn': {}
            }

        return {
            'total_pedidos': len(pedidos),
            'total_itens': sum(p.qtd_itens for p in pedidos),
            'vlr_total': sum(p.vlr_total for p in pedidos),
            'pedidos_urgentes': sum(1 for p in pedidos if p.prioridade_max == Prioridade.URGENTE),
            'pedidos_abaixo_minimo': sum(1 for p in pedidos if not p.atinge_minimo),
            'por_classificacao_forn': {
                'EXCELENTE': sum(1 for p in pedidos if p.classif_fornecedor == 'EXCELENTE'),
                'BOM': sum(1 for p in pedidos if p.classif_fornecedor == 'BOM'),
                'REGULAR': sum(1 for p in pedidos if p.classif_fornecedor == 'REGULAR'),
                'RUIM': sum(1 for p in pedidos if p.classif_fornecedor == 'RUIM'),
                'CRITICO': sum(1 for p in pedidos if p.classif_fornecedor == 'CRITICO')
            }
        }
