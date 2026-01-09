"""
AIONE IA - Analisador de Condições Comerciais de Fornecedores
Análise de prazos, bonificações e flexibilidade
"""

from datetime import date, timedelta
from typing import Dict, List, Optional
from decimal import Decimal

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .analisador import MetricasComercial, ParametrosScoreFornecedor

logger = get_logger(__name__)


class AnalisadorComercialFornecedor:
    """
    Analisador de condições comerciais de fornecedores.

    Avalia aspectos comerciais através de:
    - Prazo médio de pagamento
    - Pedido mínimo
    - Bonificações e rebates
    - Flexibilidade nas negociações

    Attributes:
        db: Gerenciador de banco de dados

    Example:
        >>> analisador = AnalisadorComercialFornecedor(db)
        >>> metricas = analisador.analisar('12345678000190', 1)
        >>> print(metricas.prazo_medio_pgto)
        45
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
    ) -> MetricasComercial:
        """
        Analisa condições comerciais do fornecedor.

        Métricas calculadas:
        1. Prazo médio de pagamento
        2. Pedido mínimo
        3. Bonificações/rebates
        4. Flexibilidade

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise em dias
            parametros: Parâmetros de configuração

        Returns:
            MetricasComercial com todas as métricas calculadas
        """
        params = parametros or ParametrosScoreFornecedor()

        # Busca condições comerciais
        comercial = self._buscar_condicoes(cnpj_forn, id_filial, dias)

        # Calcula score
        score = self._calcular_score(comercial, params)

        return MetricasComercial(
            prazo_medio_pgto=comercial['prazo_medio'],
            pedido_minimo=comercial['pedido_minimo'],
            tem_bonificacao=comercial['tem_bonificacao'],
            tem_rebate=comercial['tem_rebate'],
            flex_pedido=comercial['flex_pedido'],
            score=score
        )

    def _buscar_condicoes(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int
    ) -> Dict:
        """
        Busca condições comerciais do fornecedor.

        Usa:
        - Prazo de pagamento das últimas compras
        - Tabela de negociações especiais (ia_arqnegocesp)
        - Cadastro do fornecedor

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Dict com condições comerciais
        """
        data_inicio = date.today() - timedelta(days=dias)

        # Prazo médio de pagamento (das últimas compras)
        sql_prazo = """
            SELECT
                AVG(DATEDIFF(r.DatVenc, r.DatRece)) as prazo_medio,
                MIN(r.VlrTot) as menor_pedido,
                MAX(r.VlrTot) as maior_pedido,
                COUNT(*) as qtd_pedidos,
                AVG(r.VlrTot) as ticket_medio
            FROM arqcomprarec r
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND r.DatVenc IS NOT NULL
        """

        result_prazo = self.db.execute_query(sql_prazo, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        prazo_medio = 30  # Default
        pedido_minimo = 0
        qtd_pedidos = 0
        menor_pedido = 0
        maior_pedido = 0

        if result_prazo and result_prazo[0]['prazo_medio']:
            prazo_medio = int(result_prazo[0]['prazo_medio'])
            menor_pedido = float(result_prazo[0]['menor_pedido'] or 0)
            maior_pedido = float(result_prazo[0]['maior_pedido'] or 0)
            qtd_pedidos = int(result_prazo[0]['qtd_pedidos'] or 0)

        # Tenta buscar pedido mínimo do cadastro do fornecedor
        sql_cadastro = """
            SELECT PedMin as pedido_minimo
            FROM arqpessoa
            WHERE CpfCnpjPes = :cnpj_forn
              AND IDEsppes = 2
            LIMIT 1
        """

        try:
            result_cad = self.db.execute_query(sql_cadastro, {'cnpj_forn': cnpj_forn})
            if result_cad and result_cad[0]['pedido_minimo']:
                pedido_minimo = float(result_cad[0]['pedido_minimo'])
        except Exception as e:
            self.logger.debug(f"Erro ao buscar cadastro fornecedor: {e}")

        # Se não tem no cadastro, usa o menor pedido realizado
        if pedido_minimo == 0 and menor_pedido > 0:
            pedido_minimo = menor_pedido

        # Busca negociações especiais
        tem_bonificacao = False
        tem_rebate = False
        flex_pedido = False

        try:
            sql_nego = """
                SELECT
                    TipoNego,
                    COUNT(*) as qtd
                FROM ia_arqnegocesp
                WHERE CNPJForn = :cnpj_forn
                  AND DatVigFim >= CURDATE()
                  AND Status = 'ATIVO'
                GROUP BY TipoNego
            """

            result_nego = self.db.execute_query(sql_nego, {'cnpj_forn': cnpj_forn})

            if result_nego:
                for r in result_nego:
                    tipo = r['TipoNego']
                    if tipo == 'BONIFICACAO':
                        tem_bonificacao = True
                    elif tipo == 'REBATE':
                        tem_rebate = True
                    elif tipo == 'FLEX_PEDIDO':
                        flex_pedido = True
        except Exception as e:
            self.logger.debug(f"Tabela ia_arqnegocesp não disponível: {e}")

        # Avalia flexibilidade baseado no histórico de pedidos
        if not flex_pedido and qtd_pedidos >= 5:
            # Se teve pedidos variados, é flexível
            if maior_pedido > 0 and menor_pedido > 0:
                variacao = (maior_pedido - menor_pedido) / maior_pedido * 100
                # Se variação > 50%, aceita pedidos variados = flexível
                if variacao > 50:
                    flex_pedido = True

            # Se aceitou pedidos abaixo do mínimo cadastrado
            if pedido_minimo > 0 and menor_pedido < pedido_minimo * 0.8:
                flex_pedido = True

        return {
            'prazo_medio': prazo_medio,
            'pedido_minimo': round(pedido_minimo, 2),
            'tem_bonificacao': tem_bonificacao,
            'tem_rebate': tem_rebate,
            'flex_pedido': flex_pedido,
            'qtd_pedidos': qtd_pedidos,
            'ticket_medio': round(float(result_prazo[0]['ticket_medio'] or 0), 2) if result_prazo else 0
        }

    def _calcular_score(
        self,
        comercial: Dict,
        params: ParametrosScoreFornecedor
    ) -> float:
        """
        Calcula score comercial (0-100).

        Componentes:
        - Prazo de pagamento (50%): quanto maior, melhor
        - Bonificações/rebates (30%): ter é bom
        - Flexibilidade (20%): ter é bom

        Args:
            comercial: Dict com condições comerciais
            params: Parâmetros de configuração

        Returns:
            Score de 0 a 100
        """
        # Score prazo (quanto maior, melhor)
        prazo = comercial['prazo_medio']
        if prazo >= params.prazo_pgto_otimo:
            score_prazo = 100
        elif prazo >= params.prazo_pgto_bom:
            faixa = params.prazo_pgto_otimo - params.prazo_pgto_bom
            posicao = prazo - params.prazo_pgto_bom
            score_prazo = 80 + (20 * posicao / faixa) if faixa > 0 else 80
        elif prazo >= params.prazo_pgto_regular:
            faixa = params.prazo_pgto_bom - params.prazo_pgto_regular
            posicao = prazo - params.prazo_pgto_regular
            score_prazo = 60 + (20 * posicao / faixa) if faixa > 0 else 60
        elif prazo >= params.prazo_pgto_ruim:
            faixa = params.prazo_pgto_regular - params.prazo_pgto_ruim
            posicao = prazo - params.prazo_pgto_ruim
            score_prazo = 40 + (20 * posicao / faixa) if faixa > 0 else 40
        else:
            score_prazo = max(0, 40 * prazo / params.prazo_pgto_ruim) if params.prazo_pgto_ruim > 0 else 0

        # Score bonificações/rebates
        score_bonus = 0
        if comercial['tem_bonificacao']:
            score_bonus += 50
        if comercial['tem_rebate']:
            score_bonus += 50
        # Se não tem nenhum, não penaliza muito
        if not comercial['tem_bonificacao'] and not comercial['tem_rebate']:
            score_bonus = 40

        # Score flexibilidade
        score_flex = 100 if comercial['flex_pedido'] else 50

        # Pondera (50% prazo, 30% bonus, 20% flex)
        score = (score_prazo * 0.50) + (score_bonus * 0.30) + (score_flex * 0.20)

        return round(max(0, min(100, score)), 2)

    def negociacoes_ativas(
        self,
        cnpj_forn: str
    ) -> List[Dict]:
        """
        Lista negociações especiais ativas com o fornecedor.

        Args:
            cnpj_forn: CNPJ do fornecedor

        Returns:
            Lista de negociações ativas
        """
        try:
            sql = """
                SELECT
                    IDNegoc,
                    TipoNego,
                    DescNego,
                    DatVigIni,
                    DatVigFim,
                    PercDesc,
                    VlrMinPed,
                    Condicoes
                FROM ia_arqnegocesp
                WHERE CNPJForn = :cnpj_forn
                  AND DatVigFim >= CURDATE()
                  AND Status = 'ATIVO'
                ORDER BY TipoNego, DatVigFim
            """

            return self.db.execute_query(sql, {'cnpj_forn': cnpj_forn}) or []

        except Exception as e:
            self.logger.debug(f"Tabela ia_arqnegocesp não disponível: {e}")
            return []

    def historico_condicoes(
        self,
        cnpj_forn: str,
        id_filial: int,
        meses: int = 12
    ) -> List[Dict]:
        """
        Retorna histórico de condições comerciais por mês.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            meses: Quantidade de meses

        Returns:
            Lista com condições por mês
        """
        sql = """
            SELECT
                DATE_FORMAT(r.DatRece, '%Y-%m') as mes,
                COUNT(*) as qtd_pedidos,
                ROUND(AVG(DATEDIFF(r.DatVenc, r.DatRece)), 0) as prazo_medio,
                ROUND(AVG(r.VlrTot), 2) as ticket_medio,
                ROUND(MIN(r.VlrTot), 2) as menor_pedido,
                ROUND(MAX(r.VlrTot), 2) as maior_pedido
            FROM arqcomprarec r
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL :meses MONTH)
              AND r.DatVenc IS NOT NULL
            GROUP BY DATE_FORMAT(r.DatRece, '%Y-%m')
            ORDER BY mes ASC
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'meses': meses
        }) or []

    def fornecedores_melhores_condicoes(
        self,
        id_filial: int,
        dias: int = 180,
        limite: int = 20
    ) -> List[Dict]:
        """
        Lista fornecedores com melhores condições comerciais.

        Args:
            id_filial: ID da filial
            dias: Período de análise
            limite: Limite de fornecedores

        Returns:
            Lista de fornecedores ordenados por condições
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT
                r.CNPJCPFFor as cnpj,
                p.NomPes as nome,
                COUNT(*) as qtd_pedidos,
                ROUND(AVG(DATEDIFF(r.DatVenc, r.DatRece)), 0) as prazo_medio,
                ROUND(SUM(r.VlrTot), 2) as volume_total,
                ROUND(AVG(r.VlrTot), 2) as ticket_medio
            FROM arqcomprarec r
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = r.CNPJCPFFor AND p.IDEsppes = 2
            WHERE r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND r.DatVenc IS NOT NULL
            GROUP BY r.CNPJCPFFor, p.NomPes
            HAVING qtd_pedidos >= 3
            ORDER BY prazo_medio DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []

    def comparar_prazos(
        self,
        id_filial: int,
        dias: int = 180
    ) -> Dict:
        """
        Compara prazos médios entre fornecedores da filial.

        Args:
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Dict com estatísticas de prazos
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT
                MIN(prazo_medio) as menor_prazo,
                MAX(prazo_medio) as maior_prazo,
                AVG(prazo_medio) as prazo_medio_geral,
                COUNT(*) as qtd_fornecedores
            FROM (
                SELECT
                    r.CNPJCPFFor,
                    AVG(DATEDIFF(r.DatVenc, r.DatRece)) as prazo_medio
                FROM arqcomprarec r
                WHERE r.IDFilial = :id_filial
                  AND r.TipEnt = '0'
                  AND r.DatRece >= :data_inicio
                  AND r.DatVenc IS NOT NULL
                GROUP BY r.CNPJCPFFor
                HAVING COUNT(*) >= 3
            ) sub
        """

        result = self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        if result and result[0]:
            r = result[0]
            return {
                'menor_prazo': int(r['menor_prazo'] or 0),
                'maior_prazo': int(r['maior_prazo'] or 0),
                'prazo_medio_geral': round(float(r['prazo_medio_geral'] or 0), 0),
                'qtd_fornecedores': int(r['qtd_fornecedores'] or 0)
            }

        return {
            'menor_prazo': 0,
            'maior_prazo': 0,
            'prazo_medio_geral': 0,
            'qtd_fornecedores': 0
        }

    def evolucao_prazo(
        self,
        cnpj_forn: str,
        id_filial: int,
        meses: int = 12
    ) -> List[Dict]:
        """
        Retorna evolução do prazo de pagamento ao longo do tempo.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            meses: Quantidade de meses

        Returns:
            Lista com prazo por mês
        """
        sql = """
            SELECT
                DATE_FORMAT(r.DatRece, '%Y-%m') as mes,
                ROUND(AVG(DATEDIFF(r.DatVenc, r.DatRece)), 0) as prazo_medio,
                COUNT(*) as qtd_pedidos
            FROM arqcomprarec r
            WHERE r.CNPJCPFFor = :cnpj_forn
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL :meses MONTH)
              AND r.DatVenc IS NOT NULL
            GROUP BY DATE_FORMAT(r.DatRece, '%Y-%m')
            ORDER BY mes ASC
        """

        return self.db.execute_query(sql, {
            'cnpj_forn': cnpj_forn,
            'id_filial': id_filial,
            'meses': meses
        }) or []

    def fornecedores_com_bonificacao(
        self,
        id_filial: int = None,
        limite: int = 50
    ) -> List[Dict]:
        """
        Lista fornecedores que oferecem bonificação ou rebate.

        Args:
            id_filial: ID da filial (opcional, para filtrar por compras)
            limite: Limite de fornecedores

        Returns:
            Lista de fornecedores com bonificação/rebate
        """
        try:
            sql = """
                SELECT DISTINCT
                    n.CNPJForn as cnpj,
                    p.NomPes as nome,
                    GROUP_CONCAT(DISTINCT n.TipoNego) as tipos_negociacao,
                    MAX(n.PercDesc) as maior_desconto,
                    MIN(n.DatVigFim) as proxima_expiracao
                FROM ia_arqnegocesp n
                LEFT JOIN arqpessoa p ON p.CpfCnpjPes = n.CNPJForn AND p.IDEsppes = 2
                WHERE n.DatVigFim >= CURDATE()
                  AND n.Status = 'ATIVO'
                  AND n.TipoNego IN ('BONIFICACAO', 'REBATE')
                GROUP BY n.CNPJForn, p.NomPes
                ORDER BY maior_desconto DESC
                LIMIT :limite
            """

            return self.db.execute_query(sql, {'limite': limite}) or []

        except Exception as e:
            self.logger.debug(f"Tabela ia_arqnegocesp não disponível: {e}")
            return []

    def sugerir_renegociacao(
        self,
        cnpj_forn: str,
        id_filial: int,
        dias: int = 365
    ) -> Dict:
        """
        Sugere pontos para renegociação com base no histórico.

        Args:
            cnpj_forn: CNPJ do fornecedor
            id_filial: ID da filial
            dias: Período de análise

        Returns:
            Dict com sugestões de renegociação
        """
        metricas = self.analisar(cnpj_forn, id_filial, dias)
        comparacao = self.comparar_prazos(id_filial, dias)

        sugestoes = []
        oportunidades = []

        # Analisa prazo
        if comparacao['prazo_medio_geral'] > 0:
            if metricas.prazo_medio_pgto < comparacao['prazo_medio_geral']:
                diferenca = comparacao['prazo_medio_geral'] - metricas.prazo_medio_pgto
                sugestoes.append(
                    f"Prazo atual ({metricas.prazo_medio_pgto}d) abaixo da média "
                    f"({comparacao['prazo_medio_geral']:.0f}d). "
                    f"Negociar aumento de {diferenca:.0f} dias."
                )
                oportunidades.append('PRAZO')

            if metricas.prazo_medio_pgto < comparacao['maior_prazo']:
                sugestoes.append(
                    f"Melhor prazo do mercado é {comparacao['maior_prazo']}d. "
                    f"Usar como referência na negociação."
                )

        # Analisa bonificação
        if not metricas.tem_bonificacao:
            sugestoes.append("Negociar programa de bonificação por volume.")
            oportunidades.append('BONIFICACAO')

        # Analisa rebate
        if not metricas.tem_rebate:
            sugestoes.append("Negociar programa de rebate trimestral/anual.")
            oportunidades.append('REBATE')

        # Analisa flexibilidade
        if not metricas.flex_pedido and metricas.pedido_minimo > 0:
            sugestoes.append(
                f"Pedido mínimo de R$ {metricas.pedido_minimo:,.2f}. "
                f"Negociar flexibilização para pedidos menores."
            )
            oportunidades.append('FLEXIBILIDADE')

        return {
            'cnpj': cnpj_forn,
            'score_atual': metricas.score,
            'prazo_atual': metricas.prazo_medio_pgto,
            'prazo_mercado': comparacao['prazo_medio_geral'],
            'tem_bonificacao': metricas.tem_bonificacao,
            'tem_rebate': metricas.tem_rebate,
            'flex_pedido': metricas.flex_pedido,
            'sugestoes': sugestoes,
            'oportunidades': oportunidades,
            'potencial_melhoria': len(oportunidades) > 0
        }
