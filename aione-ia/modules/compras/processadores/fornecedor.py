"""
AIONE IA - Fornecedor Processor
Processador de análise de fornecedores
"""

from datetime import datetime

import pandas as pd

from core.database.factory import get_db
from core.utils.helpers import safe_divide
from core.utils.logger import get_logger

logger = get_logger(__name__)


class FornecedorProcessor:
    """
    Processador de análise de fornecedores

    Analisa:
    - Volume de compras
    - Pontualidade de entrega
    - Qualidade (taxa de devolução)
    - Competitividade de preços
    - Diversidade de produtos

    Gera rankings e recomendações de fornecedores.
    """

    def __init__(self):
        self.db = get_db()

    async def ranking_fornecedores(
        self,
        id_filial: int,
        periodo_dias: int = 90
    ) -> list[dict]:
        """
        Gera ranking de fornecedores

        Args:
            id_filial: ID da filial
            periodo_dias: Período de análise

        Returns:
            Lista de fornecedores com scores
        """
        # Busca dados de recebimentos
        recebimentos = self._buscar_recebimentos(id_filial, periodo_dias)

        if recebimentos.empty:
            return []

        # Calcula scores
        fornecedores = []
        for _, row in recebimentos.iterrows():
            score = self._calcular_score(row)
            fornecedores.append({
                "id_fornecedor": int(row["id_fornecedor"]),
                "nome": row["nome"],
                "total_recebimentos": int(row["total_recebimentos"]),
                "valor_total": float(row["valor_total"]),
                "prazo_medio": float(row["prazo_medio"]) if row["prazo_medio"] else None,
                "total_produtos": int(row["total_produtos"]),
                "score": round(score, 2)
            })

        # Ordena por score
        fornecedores.sort(key=lambda x: x["score"], reverse=True)

        return fornecedores

    async def sugerir_fornecedor(
        self,
        id_produto: int,
        id_filial: int
    ) -> dict | None:
        """
        Sugere melhor fornecedor para um produto

        Args:
            id_produto: ID do produto
            id_filial: ID da filial

        Returns:
            Dados do fornecedor sugerido ou None
        """
        query = """
            SELECT
                p.IDPess as id_fornecedor,
                p.Nompes as nome,
                COUNT(*) as total_compras,
                AVG(i.VlrUniNota) as preco_medio,
                MAX(r.DatRece) as ultima_compra
            FROM arqcomprarec r
            JOIN arqcomprarecite i ON r.IDRec = i.IDRec
            JOIN arqpessoa p ON r.IDPess = p.IDPess
            WHERE i.IDProd = :id_produto
              AND r.IDFilial = :id_filial
              AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL 180 DAY)
            GROUP BY p.IDPess, p.Nompes
            ORDER BY total_compras DESC, preco_medio ASC
            LIMIT 1
        """
        result = self.db.execute(
            query,
            {"id_produto": id_produto, "id_filial": id_filial}
        )

        if not result:
            return None

        row = result[0]
        return {
            "id_fornecedor": row[0],
            "nome": row[1],
            "total_compras": row[2],
            "preco_medio": float(row[3]) if row[3] else None,
            "ultima_compra": str(row[4]) if row[4] else None
        }

    async def comparar_precos(
        self,
        id_produto: int,
        id_filial: int
    ) -> list[dict]:
        """
        Compara preços do produto entre fornecedores

        Args:
            id_produto: ID do produto
            id_filial: ID da filial

        Returns:
            Lista de fornecedores com preços
        """
        query = """
            SELECT
                p.IDPess as id_fornecedor,
                p.Nompes as nome,
                AVG(i.VlrUniNota) as preco_medio,
                MIN(i.VlrUniNota) as preco_minimo,
                MAX(i.VlrUniNota) as preco_maximo,
                COUNT(*) as total_compras,
                MAX(r.DatRece) as ultima_compra
            FROM arqcomprarec r
            JOIN arqcomprarecite i ON r.IDRec = i.IDRec
            JOIN arqpessoa p ON r.IDPess = p.IDPess
            WHERE i.IDProd = :id_produto
              AND r.IDFilial = :id_filial
              AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
            GROUP BY p.IDPess, p.Nompes
            ORDER BY preco_medio ASC
        """
        df = self.db.execute_df(
            query,
            {"id_produto": id_produto, "id_filial": id_filial}
        )

        return df.to_dict(orient="records")

    def _buscar_recebimentos(self, id_filial: int, dias: int) -> pd.DataFrame:
        """Busca dados agregados de recebimentos por fornecedor"""
        query = """
            SELECT
                r.IDPess as id_fornecedor,
                p.Nompes as nome,
                COUNT(DISTINCT r.IDRec) as total_recebimentos,
                SUM(r.TotRece) as valor_total,
                AVG(DATEDIFF(r.DatRece, r.DatEmi)) as prazo_medio,
                COUNT(DISTINCT i.IDProd) as total_produtos
            FROM arqcomprarec r
            JOIN arqcomprarecite i ON r.IDRec = i.IDRec
            JOIN arqpessoa p ON r.IDPess = p.IDPess
            WHERE r.IDFilial = :id_filial
              AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL :dias DAY)
            GROUP BY r.IDPess, p.Nompes
        """
        return self.db.execute_df(query, {"id_filial": id_filial, "dias": dias})

    def _calcular_score(self, row: pd.Series) -> float:
        """
        Calcula score do fornecedor (0-100)

        Critérios:
        - Volume (40%): Valor total de compras
        - Frequência (20%): Total de recebimentos
        - Pontualidade (25%): Prazo médio de entrega
        - Diversidade (15%): Quantidade de produtos diferentes
        """
        # Normalização simples (em produção, usar percentis)
        score_volume = min(100, (row["valor_total"] / 10000) * 40)
        score_frequencia = min(100, (row["total_recebimentos"] / 10) * 20)

        # Pontualidade (quanto menor o prazo, melhor)
        prazo = row["prazo_medio"] if row["prazo_medio"] else 7
        score_pontualidade = max(0, (1 - prazo / 30) * 25)

        score_diversidade = min(100, (row["total_produtos"] / 50) * 15)

        return score_volume + score_frequencia + score_pontualidade + score_diversidade
