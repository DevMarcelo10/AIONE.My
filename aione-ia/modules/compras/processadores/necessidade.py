"""
AIONE IA - Necessidade Processor
Processador de necessidades de compra
"""

from datetime import datetime

import pandas as pd

from core.database.factory import get_db
from core.utils.helpers import safe_divide
from core.utils.logger import get_logger
from modules.compras.models import (
    PrioridadeCompra,
    ProdutoSugestao,
    TipoSugestao,
)

logger = get_logger(__name__)


class NecessidadeProcessor:
    """
    Processador de necessidades de compra

    Analisa:
    - Estoque atual vs mínimo
    - Média de vendas diárias
    - Cobertura de estoque
    - Tendências de demanda

    Gera sugestões priorizadas de compra.
    """

    def __init__(self):
        self.db = get_db()

    async def processar(
        self,
        id_filial: int,
        dias_cobertura: int = 30,
        incluir_inativos: bool = False,
        categorias: list[int] | None = None,
        fornecedores: list[int] | None = None
    ) -> list[ProdutoSugestao]:
        """
        Processa necessidades de compra

        Args:
            id_filial: ID da filial
            dias_cobertura: Dias de estoque desejados
            incluir_inativos: Incluir produtos inativos
            categorias: Filtrar por IDs de categorias
            fornecedores: Filtrar por IDs de fornecedores

        Returns:
            Lista de ProdutoSugestao ordenada por prioridade
        """
        # Busca dados de produtos e estoque
        produtos = self._buscar_produtos(
            id_filial, incluir_inativos, categorias, fornecedores
        )

        if produtos.empty:
            return []

        # Busca média de vendas
        vendas = self._buscar_media_vendas(id_filial, dias=60)

        # Merge dos dados
        dados = produtos.merge(vendas, on="id_produto", how="left")
        dados["media_vendas_dia"] = dados["media_vendas_dia"].fillna(0)

        # Calcula métricas
        sugestoes = []
        for _, row in dados.iterrows():
            sugestao = self._analisar_produto(row, dias_cobertura)
            if sugestao:
                sugestoes.append(sugestao)

        # Ordena por prioridade
        ordem_prioridade = {
            PrioridadeCompra.CRITICA: 0,
            PrioridadeCompra.ALTA: 1,
            PrioridadeCompra.MEDIA: 2,
            PrioridadeCompra.BAIXA: 3,
        }
        sugestoes.sort(key=lambda x: (ordem_prioridade[x.prioridade], -x.valor_estimado))

        return sugestoes

    def _buscar_produtos(
        self,
        id_filial: int,
        incluir_inativos: bool,
        categorias: list[int] | None,
        fornecedores: list[int] | None
    ) -> pd.DataFrame:
        """Busca produtos com estoque atual"""
        query = """
            SELECT
                p.IDProd as id_produto,
                p.Despro as descricao,
                p.CodEANpri as ean,
                COALESCE(e.estoque, 0) as estoque_atual,
                p.Estmin as estoque_minimo,
                p.CustoMed as ultimo_custo,
                p.PrecoVen as preco_venda,
                p.IDGrupo as id_grupo,
                p.IDFabr as id_fornecedor
            FROM arqproduto p
            LEFT JOIN (
                SELECT IDProd, SUM(Qtdrec) as estoque
                FROM arqprodutolot
                WHERE IDFilial = :id_filial
                GROUP BY IDProd
            ) e ON p.IDProd = e.IDProd
            WHERE 1=1
        """

        params = {"id_filial": id_filial}

        if not incluir_inativos:
            query += " AND p.Ativo = '1'"

        if categorias:
            query += " AND p.IDGrupo IN :categorias"
            params["categorias"] = tuple(categorias)

        if fornecedores:
            query += " AND p.IDFabr IN :fornecedores"
            params["fornecedores"] = tuple(fornecedores)

        return self.db.execute_df(query, params)

    def _buscar_media_vendas(self, id_filial: int, dias: int) -> pd.DataFrame:
        """Busca média de vendas diárias por produto"""
        query = """
            SELECT
                i.IDProd as id_produto,
                SUM(i.Qtdped) / :dias as media_vendas_dia
            FROM arqpedido p
            JOIN arqpedidoite i ON p.IDFilial = i.IDFilial AND p.IDPed = i.IDPed
            WHERE p.IDFilial = :id_filial
              AND p.Datped >= DATE_SUB(CURDATE(), INTERVAL :dias DAY)
              AND p.Status = 'F'
            GROUP BY i.IDProd
        """
        return self.db.execute_df(query, {"id_filial": id_filial, "dias": dias})

    def _analisar_produto(self, row: pd.Series, dias_cobertura: int) -> ProdutoSugestao | None:
        """Analisa um produto e gera sugestão se necessário"""
        estoque_atual = row["estoque_atual"]
        estoque_minimo = row["estoque_minimo"]
        media_vendas = row["media_vendas_dia"]
        custo = row["ultimo_custo"] or 0

        # Calcula dias de estoque
        dias_estoque = safe_divide(estoque_atual, media_vendas, default=999)

        # Determina se precisa comprar
        necessita_compra = False
        tipo_sugestao = TipoSugestao.REPOSICAO
        prioridade = PrioridadeCompra.BAIXA

        # Critério 1: Estoque abaixo do mínimo
        if estoque_atual < estoque_minimo:
            necessita_compra = True
            if estoque_atual <= 0:
                prioridade = PrioridadeCompra.CRITICA
                tipo_sugestao = TipoSugestao.URGENTE
            elif estoque_atual < estoque_minimo * 0.5:
                prioridade = PrioridadeCompra.ALTA

        # Critério 2: Cobertura insuficiente
        elif dias_estoque < dias_cobertura:
            necessita_compra = True
            if dias_estoque < 7:
                prioridade = PrioridadeCompra.ALTA
            elif dias_estoque < 14:
                prioridade = PrioridadeCompra.MEDIA

        if not necessita_compra:
            return None

        # Calcula quantidade sugerida
        necessidade = media_vendas * dias_cobertura
        quantidade_sugerida = max(0, necessidade - estoque_atual)

        # Arredonda para cima
        quantidade_sugerida = int(quantidade_sugerida) + (1 if quantidade_sugerida % 1 > 0 else 0)

        if quantidade_sugerida <= 0:
            return None

        # Calcula margem
        margem = None
        if custo > 0 and row["preco_venda"] > 0:
            margem = ((row["preco_venda"] - custo) / row["preco_venda"]) * 100

        return ProdutoSugestao(
            id_produto=int(row["id_produto"]),
            descricao=row["descricao"],
            ean=row["ean"],
            estoque_atual=estoque_atual,
            estoque_minimo=estoque_minimo,
            media_vendas_dia=round(media_vendas, 2),
            dias_estoque=round(dias_estoque, 1),
            quantidade_sugerida=quantidade_sugerida,
            valor_estimado=round(quantidade_sugerida * custo, 2),
            tipo_sugestao=tipo_sugestao,
            prioridade=prioridade,
            ultimo_custo=custo,
            margem_atual=round(margem, 1) if margem else None
        )
