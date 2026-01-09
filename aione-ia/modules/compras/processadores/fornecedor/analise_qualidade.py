"""
AIONE IA - Analisador de Qualidade de Fornecedores
Análise de devoluções, avarias e problemas de validade
"""

from datetime import date, timedelta
from typing import Dict, List, Optional
from decimal import Decimal

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .analisador import MetricasQualidade, ParametrosScoreFornecedor

logger = get_logger(__name__)


class AnalisadorQualidadeFornecedor:
    """
    Analisador de qualidade de fornecedores.

    Avalia qualidade dos produtos entregues através de:
    - Taxa de devolução (% sobre itens recebidos)
    - Taxa de avarias no recebimento
    - Problemas com validade de produtos (validade curta)

    Attributes:
        db: Gerenciador de banco de dados

    Example:
        >>> analisador = AnalisadorQualidadeFornecedor(db)
        >>> metricas = analisador.analisar('12345678000190', 1)
        >>> print(metricas.taxa_devolucao)
        2.5
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o analisador.

        Args:
            db: Gerenciador de banco de dados
        """
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def analisar(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int = 180,
        parametros: Optional[ParametrosScoreFornecedor] = None
    ) -> MetricasQualidade:
        """
        Analisa qualidade das entregas do fornecedor.

        Métricas calculadas:
        1. Taxa de devolução (% devolvido sobre recebido)
        2. Taxa de avaria (% com avaria no recebimento)
        3. Problemas de validade (produtos com validade curta)

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise em dias
            parametros: Parâmetros de configuração

        Returns:
            MetricasQualidade com todas as métricas calculadas
        """
        params = parametros or ParametrosScoreFornecedor()

        # Busca dados de qualidade
        qualidade = self._buscar_dados_qualidade(cnpj_forn, id_filial, dias)

        if not qualidade['total_itens']:
            # Score neutro se não tem dados suficientes
            return MetricasQualidade(score=50)

        # Calcula score
        score = self._calcular_score(qualidade, params)

        return MetricasQualidade(
            taxa_devolucao=round(qualidade['taxa_devolucao'], 2),
            taxa_avaria=round(qualidade['taxa_avaria'], 2),
            problemas_validade=qualidade['problemas_validade'],
            total_itens_recebidos=qualidade['total_itens'],
            itens_devolvidos=qualidade['itens_devolvidos'],
            score=score
        )

    def _buscar_dados_qualidade(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int
    ) -> Dict:
        """
        Busca dados de qualidade do fornecedor.

        Usa tabelas:
        - arqcomprarec/arqcomprarecite para recebimentos
        - Tabela de devoluções se existir
        - arqcomprareclot para análise de validade

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Dict com métricas de qualidade
        """
        data_inicio = date.today() - timedelta(days=dias)

        # Total recebido do fornecedor
        sql_recebido = """
            SELECT
                COUNT(*) as total_itens,
                SUM(i.Qtdrec) as qtd_total
            FROM arqcomprarec r
            INNER JOIN arqcomprarecite i ON i.IDRec = r.IDRec
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
        """

        result_rec = self.db.execute_query(sql_recebido, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        total_itens = int(result_rec[0]['total_itens'] or 0) if result_rec else 0
        qtd_total = float(result_rec[0]['qtd_total'] or 0) if result_rec else 0

        if total_itens == 0:
            return {
                'total_itens': 0,
                'itens_devolvidos': 0,
                'taxa_devolucao': 0,
                'taxa_avaria': 0,
                'problemas_validade': 0
            }

        # Problemas de validade (lotes com menos de 6 meses de validade no recebimento)
        sql_validade = """
            SELECT COUNT(*) as problemas
            FROM arqcomprarec r
            INNER JOIN arqcomprareclot l ON l.IDRec = r.IDRec
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND l.Datven IS NOT NULL
              AND DATEDIFF(l.Datven, r.DatRece) < 180
        """

        result_val = self.db.execute_query(sql_validade, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        problemas_validade = int(result_val[0]['problemas'] or 0) if result_val else 0

        # Devoluções - tenta buscar da tabela de devoluções
        itens_devolvidos = 0
        taxa_devolucao = 0.0

        # Tenta buscar devoluções por TipEnt = '3' (devolução)
        try:
            sql_dev = """
                SELECT COUNT(*) as devolvidos
                FROM arqcomprarec r
                INNER JOIN arqcomprarecite i ON i.IDRec = r.IDRec
                WHERE r.CNPJCPFFor = :cnpj_forn
                  AND r.IDFilial = :id_filial
                  AND r.TipEnt = '3'
                  AND r.DatRece >= :data_inicio
            """
            result_dev = self.db.execute_query(sql_dev, {
                'cnpj_forn': cnpj_forn,
                'id_filial': id_filial,
                'data_inicio': data_inicio
            })
            if result_dev and result_dev[0]['devolvidos']:
                itens_devolvidos = int(result_dev[0]['devolvidos'])
                taxa_devolucao = (itens_devolvidos / total_itens * 100) if total_itens > 0 else 0
        except Exception as e:
            self.logger.debug(f"Erro ao buscar devoluções: {e}")

        # Tenta buscar devoluções alternativo via ia_arqhistcom
        if itens_devolvidos == 0:
            try:
                sql_hist_dev = """
                    SELECT COUNT(*) as devolvidos
                    FROM ia_arqhistcom h
                    WHERE h.CpfCnpj = :cnpj_forn
                      AND h.IDFilial = :id_filial
                      AND h.TipoHist = 'DEVOLUCAO'
                      AND DATE(h.DatMovi) >= :data_inicio
                """
                result_hist = self.db.execute_query(sql_hist_dev, {
                    'cnpj_forn': cnpj_forn,
                    'id_filial': id_filial,
                    'data_inicio': data_inicio
                })
                if result_hist and result_hist[0]['devolvidos']:
                    itens_devolvidos = int(result_hist[0]['devolvidos'])
                    taxa_devolucao = (itens_devolvidos / total_itens * 100) if total_itens > 0 else 0
            except Exception as e:
                self.logger.debug(f"Erro ao buscar devoluções via histórico: {e}")

        # Taxa de avaria (estimativa baseada em devoluções por qualidade)
        # Se não houver tabela específica, estima como 30% das devoluções
        taxa_avaria = min(taxa_devolucao * 0.3, 10)

        return {
            'total_itens': total_itens,
            'itens_devolvidos': itens_devolvidos,
            'taxa_devolucao': taxa_devolucao,
            'taxa_avaria': taxa_avaria,
            'problemas_validade': problemas_validade
        }

    def _calcular_score(
        self,
        qualidade: Dict,
        params: ParametrosScoreFornecedor
    ) -> float:
        """
        Calcula score de qualidade (0-100).

        Componentes:
        - Taxa de devolução (60%): quanto menor, melhor
        - Problemas de validade (40%): quanto menos, melhor

        Args:
            qualidade: Dict com métricas de qualidade
            params: Parâmetros de configuração

        Returns:
            Score de 0 a 100
        """
        # Score devolução (quanto menor, melhor)
        dev = qualidade['taxa_devolucao']
        if dev <= params.devolucao_otima:
            score_dev = 100
        elif dev <= params.devolucao_boa:
            faixa = params.devolucao_boa - params.devolucao_otima
            posicao = dev - params.devolucao_otima
            score_dev = 100 - (20 * posicao / faixa) if faixa > 0 else 80
        elif dev <= params.devolucao_regular:
            faixa = params.devolucao_regular - params.devolucao_boa
            posicao = dev - params.devolucao_boa
            score_dev = 80 - (20 * posicao / faixa) if faixa > 0 else 60
        elif dev <= params.devolucao_ruim:
            faixa = params.devolucao_ruim - params.devolucao_regular
            posicao = dev - params.devolucao_regular
            score_dev = 60 - (20 * posicao / faixa) if faixa > 0 else 40
        else:
            score_dev = max(0, 40 - (dev - params.devolucao_ruim) * 4)

        # Score validade
        total = qualidade['total_itens']
        prob_val = qualidade['problemas_validade']

        if total > 0:
            perc_problemas = (prob_val / total) * 100
            if perc_problemas <= 1:
                score_val = 100
            elif perc_problemas <= 3:
                score_val = 80
            elif perc_problemas <= 5:
                score_val = 60
            elif perc_problemas <= 10:
                score_val = 40
            else:
                score_val = max(0, 40 - (perc_problemas - 10) * 2)
        else:
            score_val = 50  # Neutro

        # Pondera (60% devolução, 40% validade)
        score = (score_dev * 0.60) + (score_val * 0.40)

        return round(max(0, min(100, score)), 2)

    def produtos_problematicos(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int = 180,
        limite: int = 20
    ) -> List[Dict]:
        """
        Lista produtos com problemas de qualidade do fornecedor.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise
            limite: Limite de produtos

        Returns:
            Lista de produtos com problemas
        """
        data_inicio = date.today() - timedelta(days=dias)

        # Produtos com validade curta
        sql = """
            SELECT
                p.IDProd,
                p.Despro as produto,
                COUNT(*) as qtd_problemas,
                ROUND(AVG(DATEDIFF(l.Datven, r.DatRece)), 0) as dias_validade_media,
                MIN(DATEDIFF(l.Datven, r.DatRece)) as menor_validade
            FROM arqcomprarec r
            INNER JOIN arqcomprareclot l ON l.IDRec = r.IDRec
            INNER JOIN arqproduto p ON p.IDProd = l.IDProd
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND l.Datven IS NOT NULL
              AND DATEDIFF(l.Datven, r.DatRece) < 180
            GROUP BY p.IDProd, p.Despro
            ORDER BY qtd_problemas DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []

    def fornecedores_melhor_qualidade(
        self,
        id_filial: int,
        dias: int = 180,
        limite: int = 20
    ) -> List[Dict]:
        """
        Lista fornecedores com melhor qualidade na filial.

        Args:
            id_filial: ID da filial
            dias: Período de análise
            limite: Limite de fornecedores

        Returns:
            Lista de fornecedores ordenados por qualidade
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            WITH recebimentos AS (
                SELECT
                    r.CNPJCPFFor as cnpj,
                    COUNT(*) as total_itens
                FROM arqcomprarec r
                INNER JOIN arqcomprarecite i ON i.IDRec = r.IDRec
                WHERE r.IDFilial = :id_filial
                  AND r.TipEnt = '0'
                  AND r.DatRece >= :data_inicio
                GROUP BY r.CNPJCPFFor
            ),
            problemas_validade AS (
                SELECT
                    r.CNPJCPFFor as cnpj,
                    COUNT(*) as qtd_problemas
                FROM arqcomprarec r
                INNER JOIN arqcomprareclot l ON l.IDRec = r.IDRec
                WHERE r.IDFilial = :id_filial
                  AND r.TipEnt = '0'
                  AND r.DatRece >= :data_inicio
                  AND l.Datven IS NOT NULL
                  AND DATEDIFF(l.Datven, r.DatRece) < 180
                GROUP BY r.CNPJCPFFor
            )
            SELECT
                rec.cnpj,
                p.NomPes as nome,
                rec.total_itens,
                COALESCE(pv.qtd_problemas, 0) as problemas_validade,
                ROUND(
                    (1 - COALESCE(pv.qtd_problemas, 0) / rec.total_itens) * 100,
                    2
                ) as taxa_aprovacao
            FROM recebimentos rec
            LEFT JOIN problemas_validade pv ON pv.cnpj = rec.cnpj
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = rec.cnpj AND p.IDEsppes = 2
            WHERE rec.total_itens >= 10
            ORDER BY taxa_aprovacao DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []

    def lotes_validade_curta(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int = 180,
        limite: int = 50
    ) -> List[Dict]:
        """
        Lista lotes recebidos com validade curta.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise
            limite: Limite de lotes

        Returns:
            Lista de lotes com validade curta
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT
                l.IDProd,
                p.Despro as produto,
                l.Numlot as lote,
                r.DatRece as data_recebimento,
                l.Datven as data_validade,
                DATEDIFF(l.Datven, r.DatRece) as dias_ate_vencer,
                l.Qtdlot as quantidade
            FROM arqcomprarec r
            INNER JOIN arqcomprareclot l ON l.IDRec = r.IDRec
            INNER JOIN arqproduto p ON p.IDProd = l.IDProd
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND l.Datven IS NOT NULL
              AND DATEDIFF(l.Datven, r.DatRece) < 180
            ORDER BY dias_ate_vencer ASC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []

    def evolucao_qualidade(
        self,
        cnpj_forn: str,
        id_filial: int,
        meses: int = 6
    ) -> List[Dict]:
        """
        Retorna evolução mensal da qualidade do fornecedor.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            meses: Quantidade de meses

        Returns:
            Lista com qualidade por mês
        """
        sql = """
            WITH recebimentos_mes AS (
                SELECT
                    DATE_FORMAT(r.DatRece, '%Y-%m') as mes,
                    COUNT(*) as total_itens
                FROM arqcomprarec r
                INNER JOIN arqcomprarecite i ON i.IDRec = r.IDRec
                WHERE r.CNPJCPFFor = :cnpj_forn
                  AND r.IDFilial = :id_filial
                  AND r.TipEnt = '0'
                  AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL :meses MONTH)
                GROUP BY DATE_FORMAT(r.DatRece, '%Y-%m')
            ),
            problemas_mes AS (
                SELECT
                    DATE_FORMAT(r.DatRece, '%Y-%m') as mes,
                    COUNT(*) as problemas
                FROM arqcomprarec r
                INNER JOIN arqcomprareclot l ON l.IDRec = r.IDRec
                WHERE r.CNPJCPFFor = :cnpj_forn
                  AND r.IDFilial = :id_filial
                  AND r.TipEnt = '0'
                  AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL :meses MONTH)
                  AND l.Datven IS NOT NULL
                  AND DATEDIFF(l.Datven, r.DatRece) < 180
                GROUP BY DATE_FORMAT(r.DatRece, '%Y-%m')
            )
            SELECT
                rm.mes,
                rm.total_itens,
                COALESCE(pm.problemas, 0) as problemas,
                ROUND(
                    (1 - COALESCE(pm.problemas, 0) / rm.total_itens) * 100,
                    2
                ) as taxa_aprovacao
            FROM recebimentos_mes rm
            LEFT JOIN problemas_mes pm ON pm.mes = rm.mes
            ORDER BY rm.mes ASC
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'meses': meses
        }) or []

    def comparar_qualidade_fornecedores(
        self,
        id_filial: int,
        cnpjs: List[str],
        dias: int = 180
    ) -> List[Dict]:
        """
        Compara qualidade entre fornecedores específicos.

        Args:
            id_filial: ID da filial
            cnpjs: Lista de CNPJs para comparar
            dias: Período de análise

        Returns:
            Lista com métricas de cada fornecedor
        """
        resultados = []

        for cnpj in cnpjs:
            metricas = self.analisar(cnpj, id_filial, dias)

            # Busca nome do fornecedor
            sql_nome = """
                SELECT NomPes as nome
                FROM arqpessoa
                WHERE CpfCnpjPes = :cnpj AND IDEsppes = 2
                LIMIT 1
            """
            result_nome = self.db.execute_query(sql_nome, {'cnpj': cnpj})
            nome = result_nome[0]['nome'] if result_nome else cnpj

            resultados.append({
                'cnpj': cnpj,
                'nome': nome,
                'taxa_devolucao': metricas.taxa_devolucao,
                'taxa_avaria': metricas.taxa_avaria,
                'problemas_validade': metricas.problemas_validade,
                'total_itens': metricas.total_itens_recebidos,
                'score': metricas.score
            })

        # Ordena por score (melhor qualidade primeiro)
        resultados.sort(key=lambda x: x['score'], reverse=True)

        return resultados
