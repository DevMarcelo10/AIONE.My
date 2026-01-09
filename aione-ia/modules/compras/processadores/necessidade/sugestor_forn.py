"""
AIONE IA - Sugestor de Fornecedor
Sugestor de fornecedor para necessidades de compra
"""

from datetime import date, timedelta
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils.logger import get_logger

from .gerador import NecessidadeItem, ParametrosNecessidade


class SugestorFornecedor:
    """Sugestor de fornecedor para necessidades de compra"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def sugerir_fornecedor(self, item: NecessidadeItem,
                           parametros: ParametrosNecessidade = None) -> NecessidadeItem:
        """
        Sugere o melhor fornecedor para um item.

        Critérios:
        1. Fornecedor com melhor score que vende o produto
        2. Se preferir_melhor_preco=True, prioriza menor preço
        3. Evita fornecedores críticos se configurado

        Atualiza item com:
        - cnpj_fornecedor
        - nome_fornecedor
        - score_fornecedor
        - preco_sugerido
        - vlr_total
        """
        params = parametros or ParametrosNecessidade()

        # Busca fornecedores do produto
        fornecedores = self._buscar_fornecedores_produto(item.id_prod, item.id_filial)

        if not fornecedores:
            item.alertas.append("Nenhum fornecedor encontrado para este produto")
            return item

        # Filtra fornecedores críticos se configurado
        if params.evitar_fornecedor_critico:
            fornecedores_filtrados = [f for f in fornecedores if f.get('classificacao') != 'CRITICO']

            if not fornecedores_filtrados:
                # Se todos são críticos, mantém o melhor
                item.alertas.append("Todos os fornecedores são críticos")
            else:
                fornecedores = fornecedores_filtrados

        # Ordena por critério
        if params.preferir_melhor_preco:
            fornecedores.sort(key=lambda f: f.get('preco_medio') or 9999999)
        else:
            fornecedores.sort(key=lambda f: f.get('score') or 0, reverse=True)

        # Seleciona o melhor
        melhor = fornecedores[0]

        item.cnpj_fornecedor = melhor.get('cnpj')
        item.nome_fornecedor = melhor.get('nome')
        item.score_fornecedor = melhor.get('score')
        item.preco_sugerido = melhor.get('preco_medio')

        if item.preco_sugerido and item.qtd_sugerida:
            item.vlr_total = round(item.preco_sugerido * item.qtd_sugerida, 2)

        # Alertas
        if melhor.get('classificacao') in ['RUIM', 'CRITICO']:
            item.alertas.append(f"Fornecedor {melhor.get('classificacao')}: avaliar alternativas")

        if len(fornecedores) == 1:
            item.alertas.append("Fornecedor único para este produto")

        return item

    def _buscar_fornecedores_produto(self, id_prod: int,
                                     id_filial: int) -> List[Dict]:
        """
        Busca fornecedores que vendem o produto com seus scores e preços.
        """
        data_inicio = date.today() - timedelta(days=180)

        sql = """
            SELECT
                h.CpfCnpj as cnpj,
                COALESCE(p.NomPes, h.CpfCnpj) as nome,
                COALESCE(fs.ScoreGeral, 50) as score,
                fs.Classificacao as classificacao,
                AVG(h.VlrMovi) as preco_medio,
                MIN(h.VlrMovi) as preco_minimo,
                MAX(DATE(h.DatMovi)) as ultima_compra,
                COUNT(*) as qtd_compras
            FROM ia_arqhistcom h
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = h.CpfCnpj
            LEFT JOIN ia_arqfornscor fs ON fs.CNPJForn = h.CpfCnpj
                                        AND fs.IDFilial = h.IDFilial
                                        AND fs.Status = 'ATIVO'
            WHERE h.IDProd = :id_prod
              AND h.IDFilial = :id_filial
              AND h.TipoHist = 'ENTRADA'
              AND DATE(h.DatMovi) >= :data_inicio
              AND h.CpfCnpj IS NOT NULL
              AND h.CpfCnpj != ''
            GROUP BY h.CpfCnpj, p.NomPes, fs.ScoreGeral, fs.Classificacao
            ORDER BY score DESC, preco_medio ASC
        """

        return self.db.executar_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        }) or []

    def sugerir_para_lista(self, itens: List[NecessidadeItem],
                           parametros: ParametrosNecessidade = None) -> List[NecessidadeItem]:
        """Sugere fornecedor para uma lista de itens."""
        params = parametros or ParametrosNecessidade()

        for item in itens:
            self.sugerir_fornecedor(item, params)

        return itens

    def obter_condicoes_fornecedor(self, cnpj: str, id_filial: int) -> Dict:
        """Obtém condições comerciais do fornecedor."""
        sql = """
            SELECT
                fs.PrazoMedioPgto as prazo_pgto,
                fs.LeadTimeMedio as lead_time,
                fs.PedidoMinimo as pedido_minimo,
                fs.TemBonificacao as tem_bonificacao,
                fs.TemRebate as tem_rebate
            FROM ia_arqfornscor fs
            WHERE fs.CNPJForn = :cnpj
              AND fs.IDFilial = :id_filial
              AND fs.Status = 'ATIVO'
            LIMIT 1
        """

        result = self.db.executar_query(sql, {'cnpj': cnpj, 'id_filial': id_filial})

        if result:
            return {
                'prazo_pgto': result[0].get('prazo_pgto'),
                'lead_time': result[0].get('lead_time'),
                'pedido_minimo': float(result[0].get('pedido_minimo') or 0),
                'tem_bonificacao': bool(result[0].get('tem_bonificacao')),
                'tem_rebate': bool(result[0].get('tem_rebate'))
            }

        return {
            'prazo_pgto': None,
            'lead_time': None,
            'pedido_minimo': 0,
            'tem_bonificacao': False,
            'tem_rebate': False
        }

    def alternativas_fornecedor(self, id_prod: int, id_filial: int,
                                excluir_cnpj: str = None,
                                top: int = 3) -> List[Dict]:
        """Lista fornecedores alternativos para um produto."""
        data_inicio = date.today() - timedelta(days=180)

        sql = """
            SELECT
                h.CpfCnpj as cnpj,
                COALESCE(p.NomPes, h.CpfCnpj) as nome,
                COALESCE(fs.ScoreGeral, 50) as score,
                fs.Classificacao as classificacao,
                AVG(h.VlrMovi) as preco_medio
            FROM ia_arqhistcom h
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = h.CpfCnpj
            LEFT JOIN ia_arqfornscor fs ON fs.CNPJForn = h.CpfCnpj
                                        AND fs.IDFilial = h.IDFilial
                                        AND fs.Status = 'ATIVO'
            WHERE h.IDProd = :id_prod
              AND h.IDFilial = :id_filial
              AND h.TipoHist = 'ENTRADA'
              AND DATE(h.DatMovi) >= :data_inicio
              AND h.CpfCnpj IS NOT NULL
              AND (:excluir IS NULL OR h.CpfCnpj != :excluir)
            GROUP BY h.CpfCnpj, p.NomPes, fs.ScoreGeral, fs.Classificacao
            ORDER BY score DESC
            LIMIT :top
        """

        return self.db.executar_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'excluir': excluir_cnpj,
            'top': top
        }) or []
