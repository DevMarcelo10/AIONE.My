"""
AIONE IA - Analisador de Vencimento
Análise de risco de vencimento e perdas
"""

from dataclasses import dataclass, field
from datetime import date, timedelta
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .classificador import RiscoVencimento, ParametrosClassificacao

logger = get_logger(__name__)


@dataclass
class ResultadoVencimento:
    """
    Resultado da análise de vencimento de um produto.

    Attributes:
        id_prod: ID do produto
        id_filial: ID da filial
        qtd_vencida: Quantidade vencida (últimos 12 meses)
        vlr_vencido: Valor perdido por vencimento
        perc_perda: % de perda sobre compras
        risco: Nível de risco de vencimento
        dias_para_venc: Dias até vencimento do lote mais antigo
        score: Score de vencimento 0-100 (maior = menos risco)
        lotes_risco: Lista de lotes com risco
    """
    id_prod: int
    id_filial: int
    qtd_vencida: float = 0.0
    vlr_vencido: float = 0.0
    perc_perda: float = 0.0
    risco: RiscoVencimento = RiscoVencimento.BAIXO
    dias_para_venc: Optional[int] = None
    score: float = 100.0
    lotes_risco: List[Dict] = field(default_factory=list)
    qtd_proxima_vencer: float = 0.0


class AnalisadorVencimento:
    """
    Analisador de vencimentos e perdas.

    Avalia risco de vencimento baseado em:
    - Histórico de perdas
    - Lotes próximos do vencimento
    - Relação compra/venda

    Attributes:
        db: Gerenciador de banco de dados
        parametros: Parâmetros de classificação

    Example:
        >>> analisador = AnalisadorVencimento(db, parametros)
        >>> resultado = analisador.analisar_produto(123, 1)
        >>> print(resultado['risco_vencimento'])
        BAIXO
    """

    def __init__(
        self,
        db: DatabaseManager,
        parametros: Optional[ParametrosClassificacao] = None
    ):
        """
        Inicializa o analisador.

        Args:
            db: Gerenciador de banco de dados
            parametros: Parâmetros de classificação
        """
        self.db = db
        self.parametros = parametros or ParametrosClassificacao()

    async def analisar(
        self,
        id_prod: int,
        id_filial: int
    ) -> ResultadoVencimento:
        """
        Analisa o risco de vencimento de um produto (interface async).

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            ResultadoVencimento com os indicadores
        """
        result = self.analisar_produto(id_prod, id_filial)

        return ResultadoVencimento(
            id_prod=id_prod,
            id_filial=id_filial,
            qtd_vencida=result['qtd_vencida_12m'],
            vlr_vencido=result['vlr_vencido_12m'],
            perc_perda=result['perc_perda'],
            risco=RiscoVencimento(result['risco_vencimento']),
            dias_para_venc=result['dias_para_vencer'],
            score=result['score_vencimento'],
            lotes_risco=result['lotes_detalhes'],
            qtd_proxima_vencer=result['qtd_proxima_vencer']
        )

    def analisar_produto(
        self,
        id_prod: int,
        id_filial: int,
        parametros: Optional[ParametrosClassificacao] = None
    ) -> Dict:
        """
        Analisa risco de vencimento de um produto.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            parametros: Parâmetros de classificação

        Returns:
            Dicionário com métricas de vencimento
        """
        params = parametros or self.parametros

        # Busca lotes do produto
        lotes = self._obter_lotes_produto(id_prod, id_filial)

        # Busca histórico de perdas (últimos 12 meses)
        perdas = self._obter_perdas_produto(id_prod, id_filial)

        # Analisa lotes
        dias_para_vencer = None
        qtd_proxima_vencer = 0
        lotes_detalhes = []

        for lote in lotes:
            data_venc = lote.get('Datven') or lote.get('data_validade')
            qtd_saldo = float(lote.get('saldo') or lote.get('quantidade') or 0)

            if data_venc and qtd_saldo > 0:
                # Converte para date se necessário
                if isinstance(data_venc, str):
                    from datetime import datetime
                    data_venc = datetime.strptime(data_venc[:10], '%Y-%m-%d').date()

                dias = (data_venc - date.today()).days

                if dias_para_vencer is None or dias < dias_para_vencer:
                    dias_para_vencer = dias

                # Conta quantidade próxima ao vencimento (< 90 dias)
                if dias <= params.dias_venc_medio:
                    qtd_proxima_vencer += qtd_saldo

                lotes_detalhes.append({
                    'lote': lote.get('Nrolot') or lote.get('numero_lote'),
                    'vencimento': data_venc.isoformat() if hasattr(data_venc, 'isoformat') else str(data_venc),
                    'dias_para_vencer': dias,
                    'quantidade': qtd_saldo
                })

        # Calcula métricas de perda
        qtd_vencida = float(perdas.get('qtd_vencida', 0) or 0)
        vlr_vencido = float(perdas.get('vlr_vencido', 0) or 0)
        total_comprado = float(perdas.get('total_comprado', 0) or 0)

        perc_perda = (qtd_vencida / total_comprado * 100) if total_comprado > 0 else 0

        # Risco e score
        risco = self._classificar_risco(dias_para_vencer, perc_perda, params)
        score = self._calcular_score_vencimento(dias_para_vencer, perc_perda, params)

        return {
            'dias_para_vencer': dias_para_vencer,
            'qtd_proxima_vencer': round(qtd_proxima_vencer, 4),
            'qtd_vencida_12m': round(qtd_vencida, 4),
            'vlr_vencido_12m': round(vlr_vencido, 2),
            'perc_perda': round(perc_perda, 2),
            'risco_vencimento': risco.value,
            'score_vencimento': round(score, 2),
            'lotes_detalhes': lotes_detalhes
        }

    def _obter_lotes_produto(self, id_prod: int, id_filial: int) -> List[Dict]:
        """
        Busca lotes do produto com saldo.
        Tenta primeiro arqcomprareclot, depois arqprodutolot.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Lista de lotes
        """
        # Tenta buscar da tabela de lotes de recebimento
        sql_rec = """
            SELECT
                l.Nrolot,
                l.Datven,
                l.Qtdrec as saldo
            FROM arqcomprareclot l
            INNER JOIN arqcomprarec r ON r.IDRec = l.IDRec
            WHERE l.IDProd = :id_prod
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND l.Datven IS NOT NULL
              AND l.Datven >= CURDATE()
              AND l.Qtdrec > 0
            ORDER BY l.Datven ASC
        """

        result = self.db.execute_query(sql_rec, {
            'id_prod': id_prod,
            'id_filial': id_filial
        })

        if result:
            return result

        # Fallback: busca na tabela de lotes de produto
        sql_lot = """
            SELECT
                l.Lote as Nrolot,
                l.Datvlt as Datven,
                l.Qtdatu as saldo
            FROM arqprodutolot l
            WHERE l.IDProd = :id_prod
              AND l.IDFilial = :id_filial
              AND l.Datvlt IS NOT NULL
              AND l.Datvlt >= CURDATE()
              AND l.Qtdatu > 0
            ORDER BY l.Datvlt ASC
        """

        return self.db.execute_query(sql_lot, {
            'id_prod': id_prod,
            'id_filial': id_filial
        }) or []

    def _obter_perdas_produto(self, id_prod: int, id_filial: int) -> Dict:
        """
        Busca histórico de perdas nos últimos 12 meses.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Dicionário com dados de perdas
        """
        data_inicio = date.today() - timedelta(days=365)

        # Total comprado no período
        sql_comprado = """
            SELECT COALESCE(SUM(QtdMovi), 0) as total
            FROM ia_arqhistcom
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND TipoHist = 'ENTRADA'
              AND DATE(DatMovi) >= :data_inicio
        """

        result_comprado = self.db.execute_query(sql_comprado, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        # Tenta buscar perdas da tabela de movimentação
        sql_perdas = """
            SELECT
                COALESCE(SUM(ABS(m.Qtdmov)), 0) as qtd,
                COALESCE(SUM(ABS(m.Qtdmov) * m.Cusmov), 0) as valor
            FROM arqprodutomov m
            WHERE m.IDProd = :id_prod
              AND m.IDFilial = :id_filial
              AND m.Datmov >= :data_inicio
              AND m.Tipmov IN ('P', 'V', 'D')
        """

        result_perdas = self.db.execute_query(sql_perdas, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        qtd_vencida = 0
        vlr_vencido = 0
        if result_perdas and result_perdas[0]:
            qtd_vencida = float(result_perdas[0].get('qtd', 0) or 0)
            vlr_vencido = float(result_perdas[0].get('valor', 0) or 0)

        return {
            'qtd_vencida': qtd_vencida,
            'vlr_vencido': vlr_vencido,
            'total_comprado': result_comprado[0]['total'] if result_comprado else 0
        }

    def _classificar_risco(
        self,
        dias_para_vencer: Optional[int],
        perc_perda: float,
        params: ParametrosClassificacao
    ) -> RiscoVencimento:
        """
        Classifica risco de vencimento.

        Args:
            dias_para_vencer: Dias até vencimento
            perc_perda: Percentual de perda
            params: Parâmetros de classificação

        Returns:
            Nível de risco
        """
        # Se não tem data de vencimento, verifica apenas histórico
        if dias_para_vencer is None:
            if perc_perda >= 10:
                return RiscoVencimento.ALTO
            elif perc_perda >= 5:
                return RiscoVencimento.MEDIO
            return RiscoVencimento.BAIXO

        # Pelo tempo até vencer
        if dias_para_vencer <= params.dias_venc_critico:
            return RiscoVencimento.CRITICO
        elif dias_para_vencer <= params.dias_venc_alto:
            return RiscoVencimento.ALTO
        elif dias_para_vencer <= params.dias_venc_medio:
            return RiscoVencimento.MEDIO

        # Pelo histórico de perdas
        if perc_perda >= 10:
            return RiscoVencimento.ALTO
        elif perc_perda >= 5:
            return RiscoVencimento.MEDIO

        return RiscoVencimento.BAIXO

    def _calcular_score_vencimento(
        self,
        dias_para_vencer: Optional[int],
        perc_perda: float,
        params: ParametrosClassificacao
    ) -> float:
        """
        Calcula score de vencimento (0-100).
        Maior score = menor risco.

        Args:
            dias_para_vencer: Dias até vencimento
            perc_perda: Percentual de perda
            params: Parâmetros de classificação

        Returns:
            Score de 0 a 100
        """
        score = 100.0

        # Penaliza por dias para vencer
        if dias_para_vencer is not None:
            if dias_para_vencer <= params.dias_venc_critico:
                score -= 60
            elif dias_para_vencer <= params.dias_venc_alto:
                score -= 40
            elif dias_para_vencer <= params.dias_venc_medio:
                score -= 20

        # Penaliza por histórico de perdas (máximo 30 pontos)
        score -= min(30, perc_perda * 3)

        return max(0, score)

    def produtos_proximos_vencer(
        self,
        id_filial: int,
        dias: int = 30,
        limite: int = 100
    ) -> List[Dict]:
        """
        Lista produtos que vencem nos próximos X dias.

        Args:
            id_filial: ID da filial
            dias: Dias até vencimento
            limite: Limite de registros

        Returns:
            Lista de produtos próximos ao vencimento
        """
        data_limite = date.today() + timedelta(days=dias)

        sql = """
            SELECT
                l.IDProd,
                p.Despro,
                l.Nrolot,
                l.Datven,
                DATEDIFF(l.Datven, CURDATE()) as dias_para_vencer,
                l.Qtdrec as quantidade
            FROM arqcomprareclot l
            INNER JOIN arqcomprarec r ON r.IDRec = l.IDRec
            INNER JOIN arqproduto p ON p.IDProd = l.IDProd
            WHERE r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND l.Datven IS NOT NULL
              AND l.Datven BETWEEN CURDATE() AND :data_limite
              AND l.Qtdrec > 0
            ORDER BY l.Datven ASC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_limite': data_limite,
            'limite': limite
        }) or []

    def calcular_valor_em_risco(self, id_filial: int) -> Dict:
        """
        Calcula valor total em risco de vencimento por faixa.

        Args:
            id_filial: ID da filial

        Returns:
            Dicionário com valores por faixa de risco
        """
        p = self.parametros

        sql = """
            SELECT
                CASE
                    WHEN DATEDIFF(l.Datvlt, CURDATE()) <= :critico THEN 'CRITICO'
                    WHEN DATEDIFF(l.Datvlt, CURDATE()) <= :alto THEN 'ALTO'
                    WHEN DATEDIFF(l.Datvlt, CURDATE()) <= :medio THEN 'MEDIO'
                    ELSE 'BAIXO'
                END as risco,
                COUNT(DISTINCT l.IDProd) as qtd_produtos,
                COUNT(*) as qtd_lotes,
                SUM(l.Qtdatu) as qtd_total,
                SUM(l.Qtdatu * l.Cuslot) as valor_total
            FROM arqprodutolot l
            WHERE l.IDFilial = :id_filial
              AND l.Qtdatu > 0
              AND l.Datvlt IS NOT NULL
              AND DATEDIFF(l.Datvlt, CURDATE()) <= :medio
            GROUP BY
                CASE
                    WHEN DATEDIFF(l.Datvlt, CURDATE()) <= :critico THEN 'CRITICO'
                    WHEN DATEDIFF(l.Datvlt, CURDATE()) <= :alto THEN 'ALTO'
                    WHEN DATEDIFF(l.Datvlt, CURDATE()) <= :medio THEN 'MEDIO'
                    ELSE 'BAIXO'
                END
        """

        result = self.db.execute_query(sql, {
            'id_filial': id_filial,
            'critico': p.dias_venc_critico,
            'alto': p.dias_venc_alto,
            'medio': p.dias_venc_medio
        })

        resumo = {
            'CRITICO': {'qtd_produtos': 0, 'qtd_lotes': 0, 'qtd_total': 0, 'valor_total': 0},
            'ALTO': {'qtd_produtos': 0, 'qtd_lotes': 0, 'qtd_total': 0, 'valor_total': 0},
            'MEDIO': {'qtd_produtos': 0, 'qtd_lotes': 0, 'qtd_total': 0, 'valor_total': 0}
        }

        if result:
            for r in result:
                risco = r['risco']
                if risco in resumo:
                    resumo[risco] = {
                        'qtd_produtos': int(r['qtd_produtos']),
                        'qtd_lotes': int(r['qtd_lotes']),
                        'qtd_total': float(r['qtd_total'] or 0),
                        'valor_total': float(r['valor_total'] or 0)
                    }

        # Totais
        resumo['TOTAL'] = {
            'qtd_produtos': sum(v['qtd_produtos'] for k, v in resumo.items() if k != 'TOTAL'),
            'qtd_lotes': sum(v['qtd_lotes'] for k, v in resumo.items() if k != 'TOTAL'),
            'qtd_total': sum(v['qtd_total'] for k, v in resumo.items() if k != 'TOTAL'),
            'valor_total': sum(v['valor_total'] for k, v in resumo.items() if k != 'TOTAL')
        }

        return resumo
