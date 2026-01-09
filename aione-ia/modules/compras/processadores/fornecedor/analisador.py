"""
AIONE IA - Analisador Principal de Fornecedores
Motor de análise e score de fornecedores
"""

from dataclasses import dataclass, field
from datetime import datetime, date, timedelta
from typing import List, Dict, Optional, Any
from enum import Enum

from core.database import DatabaseManager
from core.utils.logger import get_logger

logger = get_logger(__name__)


class ClassificacaoFornecedor(str, Enum):
    """Classificação do fornecedor baseada no score geral."""
    EXCELENTE = 'EXCELENTE'   # 85-100
    BOM = 'BOM'               # 70-84
    REGULAR = 'REGULAR'       # 50-69
    RUIM = 'RUIM'             # 30-49
    CRITICO = 'CRITICO'       # 0-29


class TendenciaFornecedor(str, Enum):
    """Tendência do score do fornecedor."""
    MELHORANDO = 'MELHORANDO'
    ESTAVEL = 'ESTAVEL'
    PIORANDO = 'PIORANDO'


@dataclass
class ParametrosScoreFornecedor:
    """
    Parâmetros configuráveis da análise de fornecedores.

    Attributes:
        dias_analise: Período de análise em dias
        dias_validade: Dias de validade do score
        peso_preco: Peso do critério preço (%)
        peso_entrega: Peso do critério entrega (%)
        peso_qualidade: Peso do critério qualidade (%)
        peso_comercial: Peso do critério comercial (%)
    """

    # Período de análise
    dias_analise: int = 180          # 6 meses
    dias_validade: int = 30          # Recalcular mensalmente

    # Pesos dos critérios (soma = 100)
    peso_preco: float = 35.0
    peso_entrega: float = 25.0
    peso_qualidade: float = 20.0
    peso_comercial: float = 20.0

    # Limiares de classificação
    score_excelente_min: float = 85.0
    score_bom_min: float = 70.0
    score_regular_min: float = 50.0
    score_ruim_min: float = 30.0
    # Abaixo de 30 = CRÍTICO

    # Preço - Variação vs mercado
    variacao_preco_otima: float = -5.0    # Até 5% abaixo do mercado
    variacao_preco_boa: float = 0.0       # Na média
    variacao_preco_regular: float = 5.0   # Até 5% acima
    variacao_preco_ruim: float = 10.0     # Até 10% acima

    # Entrega - Pontualidade
    pontualidade_otima: float = 95.0      # 95%+ no prazo
    pontualidade_boa: float = 85.0        # 85%+
    pontualidade_regular: float = 70.0    # 70%+
    pontualidade_ruim: float = 50.0       # 50%+

    # Entrega - Lead time em dias
    lead_time_otimo: int = 2              # Até 2 dias
    lead_time_bom: int = 5                # Até 5 dias
    lead_time_regular: int = 10           # Até 10 dias
    lead_time_ruim: int = 15              # Até 15 dias

    # Qualidade - Taxa de devolução
    devolucao_otima: float = 1.0          # Até 1%
    devolucao_boa: float = 3.0            # Até 3%
    devolucao_regular: float = 5.0        # Até 5%
    devolucao_ruim: float = 10.0          # Até 10%

    # Comercial - Prazo de pagamento
    prazo_pgto_otimo: int = 60            # 60+ dias
    prazo_pgto_bom: int = 45              # 45+ dias
    prazo_pgto_regular: int = 30          # 30+ dias
    prazo_pgto_ruim: int = 15             # 15+ dias

    def validar(self) -> bool:
        """Valida se os pesos somam 100%."""
        soma = self.peso_preco + self.peso_entrega + self.peso_qualidade + self.peso_comercial
        return abs(soma - 100.0) < 0.01


@dataclass
class MetricasPreco:
    """
    Métricas de preço do fornecedor.

    Attributes:
        variacao_vs_mercado: % de variação vs média de outros fornecedores
        reajuste_anual: % de reajuste nos últimos 12 meses
        desconto_medio: % de desconto médio obtido
        score: Score de preço (0-100)
        qtd_produtos_analisados: Quantidade de produtos na análise
    """
    variacao_vs_mercado: float = 0.0
    reajuste_anual: float = 0.0
    desconto_medio: float = 0.0
    score: float = 0.0
    qtd_produtos_analisados: int = 0


@dataclass
class MetricasEntrega:
    """
    Métricas de entrega do fornecedor.

    Attributes:
        lead_time_medio: Dias médios entre pedido e recebimento
        pontualidade_perc: % de entregas no prazo
        atraso_medio_dias: Dias de atraso médio (quando atrasa)
        total_pedidos: Total de pedidos analisados
        pedidos_atraso: Quantidade de pedidos com atraso
        score: Score de entrega (0-100)
    """
    lead_time_medio: float = 0.0
    pontualidade_perc: float = 0.0
    atraso_medio_dias: float = 0.0
    total_pedidos: int = 0
    pedidos_atraso: int = 0
    score: float = 0.0


@dataclass
class MetricasQualidade:
    """
    Métricas de qualidade do fornecedor.

    Attributes:
        taxa_devolucao: % de devoluções sobre compras
        taxa_avaria: % de avarias no recebimento
        problemas_validade: Quantidade de problemas com validade
        total_itens_recebidos: Total de itens recebidos
        itens_devolvidos: Quantidade de itens devolvidos
        score: Score de qualidade (0-100)
    """
    taxa_devolucao: float = 0.0
    taxa_avaria: float = 0.0
    problemas_validade: int = 0
    total_itens_recebidos: int = 0
    itens_devolvidos: int = 0
    score: float = 0.0


@dataclass
class MetricasComercial:
    """
    Métricas comerciais do fornecedor.

    Attributes:
        prazo_medio_pgto: Prazo médio de pagamento em dias
        pedido_minimo: Valor do pedido mínimo
        tem_bonificacao: Se oferece bonificação
        tem_rebate: Se oferece rebate
        flex_pedido: Se é flexível no pedido mínimo
        score: Score comercial (0-100)
    """
    prazo_medio_pgto: int = 0
    pedido_minimo: float = 0.0
    tem_bonificacao: bool = False
    tem_rebate: bool = False
    flex_pedido: bool = False
    score: float = 0.0


@dataclass
class ResultadoScoreFornecedor:
    """
    Resultado completo da análise de um fornecedor.

    Attributes:
        cnpj: CNPJ do fornecedor
        nome: Nome/Razão social
        id_filial: ID da filial (0=todas)
        score_geral: Score geral (0-100)
        classificacao: Classificação (EXCELENTE/BOM/REGULAR/RUIM/CRITICO)
        ranking: Posição no ranking da filial
    """

    # Identificação
    cnpj: str
    nome: str
    id_filial: int

    # Score geral
    score_geral: float = 0.0
    classificacao: ClassificacaoFornecedor = ClassificacaoFornecedor.REGULAR
    ranking: int = 0

    # Scores por critério
    score_preco: float = 0.0
    score_entrega: float = 0.0
    score_qualidade: float = 0.0
    score_comercial: float = 0.0

    # Métricas detalhadas
    metricas_preco: MetricasPreco = None
    metricas_entrega: MetricasEntrega = None
    metricas_qualidade: MetricasQualidade = None
    metricas_comercial: MetricasComercial = None

    # Volume
    vlr_compras_12m: float = 0.0
    qtd_produtos: int = 0
    perc_part_compras: float = 0.0
    exclusividades: int = 0

    # Tendência
    tendencia: TendenciaFornecedor = TendenciaFornecedor.ESTAVEL
    score_anterior: float = 0.0
    var_score: float = 0.0

    # Alertas e recomendações
    alertas: List[str] = field(default_factory=list)
    recomendacoes: List[str] = field(default_factory=list)

    # Metadados
    data_calculo: datetime = None
    periodo_analise: int = 180

    def __post_init__(self):
        """Inicializa valores padrão."""
        if self.data_calculo is None:
            self.data_calculo = datetime.now()
        if self.metricas_preco is None:
            self.metricas_preco = MetricasPreco()
        if self.metricas_entrega is None:
            self.metricas_entrega = MetricasEntrega()
        if self.metricas_qualidade is None:
            self.metricas_qualidade = MetricasQualidade()
        if self.metricas_comercial is None:
            self.metricas_comercial = MetricasComercial()

    def to_dict(self) -> Dict[str, Any]:
        """Converte para dicionário."""
        return {
            'cnpj': self.cnpj,
            'nome': self.nome,
            'id_filial': self.id_filial,
            'score_geral': self.score_geral,
            'classificacao': self.classificacao.value,
            'ranking': self.ranking,
            'score_preco': self.score_preco,
            'score_entrega': self.score_entrega,
            'score_qualidade': self.score_qualidade,
            'score_comercial': self.score_comercial,
            'vlr_compras_12m': self.vlr_compras_12m,
            'qtd_produtos': self.qtd_produtos,
            'perc_part_compras': self.perc_part_compras,
            'exclusividades': self.exclusividades,
            'tendencia': self.tendencia.value,
            'score_anterior': self.score_anterior,
            'var_score': self.var_score,
            'alertas': self.alertas,
            'recomendacoes': self.recomendacoes,
            'data_calculo': self.data_calculo.isoformat() if self.data_calculo else None,
            'periodo_analise': self.periodo_analise
        }


# Importação dos componentes
from .analise_preco import AnalisadorPrecoFornecedor
from .analise_entrega import AnalisadorEntregaFornecedor
from .analise_qualidade import AnalisadorQualidadeFornecedor
from .analise_comercial import AnalisadorComercialFornecedor
from .repositorio import FornecedorScoreRepositorio


class AnalisadorFornecedor:
    """Motor principal de análise e score de fornecedores."""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

        # Componentes
        self.analisador_preco = AnalisadorPrecoFornecedor(db)
        self.analisador_entrega = AnalisadorEntregaFornecedor(db)
        self.analisador_qualidade = AnalisadorQualidadeFornecedor(db)
        self.analisador_comercial = AnalisadorComercialFornecedor(db)
        self.repositorio = FornecedorScoreRepositorio(db)

        # Parâmetros padrão
        self.parametros = ParametrosScoreFornecedor()

    # =========================================================================
    # MÉTODO PRINCIPAL
    # =========================================================================

    def analisar(self, cnpj: str, id_filial: int,
                 dias: int = 180,
                 parametros: ParametrosScoreFornecedor = None,
                 salvar: bool = False) -> ResultadoScoreFornecedor:
        """
        Analisa um fornecedor e calcula seu score.

        Args:
            cnpj: CNPJ do fornecedor
            id_filial: ID da filial (0 = consolidado)
            dias: Período de análise em dias
            parametros: Parâmetros customizados
            salvar: Se True, persiste em ia_arqfornscor

        Returns:
            ResultadoScoreFornecedor
        """
        params = parametros or self.parametros

        self.logger.info(f"Analisando fornecedor {cnpj}, filial {id_filial}")

        try:
            # Busca nome do fornecedor
            nome = self._obter_nome_fornecedor(cnpj)

            # 1. Análise de preço
            metricas_preco = self.analisador_preco.analisar(cnpj, id_filial, dias, params)

            # 2. Análise de entrega
            metricas_entrega = self.analisador_entrega.analisar(cnpj, id_filial, dias, params)

            # 3. Análise de qualidade
            metricas_qualidade = self.analisador_qualidade.analisar(cnpj, id_filial, dias, params)

            # 4. Análise comercial
            metricas_comercial = self.analisador_comercial.analisar(cnpj, id_filial, dias, params)

            # 5. Busca volume e importância
            volume = self._calcular_volume(cnpj, id_filial)

            # 6. Calcula score geral
            score_geral = self._calcular_score_geral(
                metricas_preco.score,
                metricas_entrega.score,
                metricas_qualidade.score,
                metricas_comercial.score,
                params
            )

            # 7. Determina classificação
            classificacao = self._determinar_classificacao(score_geral, params)

            # 8. Busca score anterior e calcula tendência
            score_anterior = self._obter_score_anterior(cnpj, id_filial)
            tendencia, var_score = self._calcular_tendencia(score_geral, score_anterior)

            # 9. Gera alertas e recomendações
            alertas = self._gerar_alertas(
                metricas_preco, metricas_entrega,
                metricas_qualidade, metricas_comercial,
                classificacao
            )
            recomendacoes = self._gerar_recomendacoes(
                classificacao, metricas_preco, metricas_entrega,
                metricas_qualidade, metricas_comercial
            )

            # 10. Monta resultado
            resultado = ResultadoScoreFornecedor(
                cnpj=cnpj,
                nome=nome,
                id_filial=id_filial,

                # Score geral
                score_geral=score_geral,
                classificacao=classificacao,

                # Scores por critério
                score_preco=metricas_preco.score,
                score_entrega=metricas_entrega.score,
                score_qualidade=metricas_qualidade.score,
                score_comercial=metricas_comercial.score,

                # Métricas detalhadas
                metricas_preco=metricas_preco,
                metricas_entrega=metricas_entrega,
                metricas_qualidade=metricas_qualidade,
                metricas_comercial=metricas_comercial,

                # Volume
                vlr_compras_12m=volume['vlr_compras'],
                qtd_produtos=volume['qtd_produtos'],
                perc_part_compras=volume['perc_participacao'],
                exclusividades=volume['exclusividades'],

                # Tendência
                tendencia=tendencia,
                score_anterior=score_anterior,
                var_score=var_score,

                # Alertas
                alertas=alertas,
                recomendacoes=recomendacoes,

                # Metadados
                periodo_analise=dias
            )

            # 11. Salvar
            if salvar:
                self.repositorio.salvar(resultado, params.dias_validade)

            self.logger.info(f"Fornecedor {cnpj} analisado: {classificacao.value} (score={score_geral:.1f})")

            return resultado

        except Exception as e:
            self.logger.error(f"Erro ao analisar fornecedor {cnpj}: {e}")
            raise

    # =========================================================================
    # MÉTODOS DE LOTE
    # =========================================================================

    def analisar_todos_fornecedores(self, id_filial: int,
                                     parametros: ParametrosScoreFornecedor = None,
                                     salvar: bool = True) -> List[ResultadoScoreFornecedor]:
        """
        Analisa todos os fornecedores de uma filial.

        Args:
            id_filial: ID da filial
            parametros: Parâmetros customizados
            salvar: Se True, persiste resultados

        Returns:
            Lista de ResultadoScoreFornecedor
        """
        params = parametros or self.parametros

        self.logger.info(f"Analisando todos fornecedores da filial {id_filial}")

        # Lista fornecedores com compras no período
        fornecedores = self.listar_fornecedores_ativos(id_filial, params.dias_analise)

        resultados = []
        for forn in fornecedores:
            try:
                resultado = self.analisar(
                    cnpj=forn['cnpj'],
                    id_filial=id_filial,
                    dias=params.dias_analise,
                    parametros=params,
                    salvar=salvar
                )
                resultados.append(resultado)
            except Exception as e:
                self.logger.error(f"Erro fornecedor {forn['cnpj']}: {e}")

        # Atualiza rankings
        if salvar:
            self.repositorio.atualizar_rankings(id_filial)

        # Resumo
        excelentes = sum(1 for r in resultados if r.classificacao == ClassificacaoFornecedor.EXCELENTE)
        criticos = sum(1 for r in resultados if r.classificacao == ClassificacaoFornecedor.CRITICO)

        self.logger.info(f"Filial {id_filial}: {len(resultados)} fornecedores, {excelentes} excelentes, {criticos} críticos")

        return resultados

    def listar_fornecedores_ativos(self, id_filial: int, dias: int = 180,
                                    limite: int = 500) -> List[Dict]:
        """
        Lista fornecedores com compras no período.

        Args:
            id_filial: ID da filial
            dias: Período de análise
            limite: Limite de fornecedores

        Returns:
            Lista de dicts com cnpj e nome
        """
        data_inicio = date.today() - timedelta(days=dias)

        sql = """
            SELECT DISTINCT
                r.CNPJCPFFor as cnpj,
                p.NomPes as nome,
                COUNT(DISTINCT r.IDRec) as qtd_compras,
                SUM(r.VlrTotRec) as vlr_total
            FROM arqcomprarec r
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = r.CNPJCPFFor AND p.IDEsppes = 2
            WHERE r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
              AND r.CNPJCPFFor IS NOT NULL
              AND r.CNPJCPFFor != ''
            GROUP BY r.CNPJCPFFor, p.NomPes
            HAVING qtd_compras >= 2
            ORDER BY vlr_total DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, {
            'id_filial': id_filial,
            'data_inicio': data_inicio,
            'limite': limite
        }) or []

    # =========================================================================
    # MÉTODOS AUXILIARES
    # =========================================================================

    def _obter_nome_fornecedor(self, cnpj: str) -> str:
        """Obtém nome do fornecedor."""
        sql = "SELECT NomPes FROM arqpessoa WHERE CpfCnpjPes = :cnpj AND IDEsppes = 2 LIMIT 1"
        result = self.db.execute_query(sql, {'cnpj': cnpj})
        return result[0]['NomPes'] if result else cnpj

    def _calcular_volume(self, cnpj: str, id_filial: int) -> Dict:
        """Calcula volume de compras do fornecedor."""
        data_inicio = date.today() - timedelta(days=365)

        # Volume do fornecedor
        sql_forn = """
            SELECT
                SUM(r.VlrTotRec) as vlr_compras,
                COUNT(DISTINCT ri.IDProd) as qtd_produtos
            FROM arqcomprarec r
            INNER JOIN arqcomprarecite ri ON ri.IDRec = r.IDRec
            WHERE r.CNPJCPFFor = :cnpj
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
        """

        result_forn = self.db.execute_query(sql_forn, {
            'cnpj': cnpj,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        vlr_forn = float(result_forn[0]['vlr_compras'] or 0) if result_forn else 0
        qtd_prod = int(result_forn[0]['qtd_produtos'] or 0) if result_forn else 0

        # Volume total da filial
        sql_total = """
            SELECT SUM(r.VlrTotRec) as vlr_total
            FROM arqcomprarec r
            WHERE r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= :data_inicio
        """

        result_total = self.db.execute_query(sql_total, {
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        vlr_total = float(result_total[0]['vlr_total'] or 0) if result_total else 0

        # Produtos exclusivos (só esse fornecedor vende)
        sql_excl = """
            SELECT COUNT(*) as exclusivos
            FROM (
                SELECT ri.IDProd
                FROM arqcomprarec r
                INNER JOIN arqcomprarecite ri ON ri.IDRec = r.IDRec
                WHERE r.IDFilial = :id_filial
                  AND r.TipEnt = '0'
                  AND r.DatRece >= :data_inicio
                GROUP BY ri.IDProd
                HAVING COUNT(DISTINCT r.CNPJCPFFor) = 1
                   AND MAX(r.CNPJCPFFor) = :cnpj
            ) sub
        """

        result_excl = self.db.execute_query(sql_excl, {
            'cnpj': cnpj,
            'id_filial': id_filial,
            'data_inicio': data_inicio
        })

        exclusividades = int(result_excl[0]['exclusivos'] or 0) if result_excl else 0

        return {
            'vlr_compras': vlr_forn,
            'qtd_produtos': qtd_prod,
            'perc_participacao': round((vlr_forn / vlr_total * 100), 2) if vlr_total > 0 else 0,
            'exclusividades': exclusividades
        }

    def _calcular_score_geral(self, score_preco: float, score_entrega: float,
                               score_qualidade: float, score_comercial: float,
                               params: ParametrosScoreFornecedor) -> float:
        """Calcula score geral ponderado."""
        score = (
            score_preco * (params.peso_preco / 100) +
            score_entrega * (params.peso_entrega / 100) +
            score_qualidade * (params.peso_qualidade / 100) +
            score_comercial * (params.peso_comercial / 100)
        )
        return round(score, 2)

    def _determinar_classificacao(self, score: float,
                                   params: ParametrosScoreFornecedor) -> ClassificacaoFornecedor:
        """Determina classificação baseada no score."""
        if score >= params.score_excelente_min:
            return ClassificacaoFornecedor.EXCELENTE
        elif score >= params.score_bom_min:
            return ClassificacaoFornecedor.BOM
        elif score >= params.score_regular_min:
            return ClassificacaoFornecedor.REGULAR
        elif score >= params.score_ruim_min:
            return ClassificacaoFornecedor.RUIM
        else:
            return ClassificacaoFornecedor.CRITICO

    def _obter_score_anterior(self, cnpj: str, id_filial: int) -> float:
        """Busca score anterior do fornecedor."""
        sql = """
            SELECT ScoreGeral
            FROM ia_arqfornscor
            WHERE CNPJForn = :cnpj
              AND IDFilial = :id_filial
              AND Status = 'SUBSTITUIDO'
            ORDER BY DatCalculo DESC
            LIMIT 1
        """

        result = self.db.execute_query(sql, {'cnpj': cnpj, 'id_filial': id_filial})
        if result and result[0]['ScoreGeral']:
            return float(result[0]['ScoreGeral'])
        return 0

    def _calcular_tendencia(self, score_atual: float,
                            score_anterior: float) -> tuple:
        """Calcula tendência do score."""
        if score_anterior == 0:
            return TendenciaFornecedor.ESTAVEL, 0

        variacao = score_atual - score_anterior

        if variacao >= 5:
            return TendenciaFornecedor.MELHORANDO, round(variacao, 2)
        elif variacao <= -5:
            return TendenciaFornecedor.PIORANDO, round(variacao, 2)
        else:
            return TendenciaFornecedor.ESTAVEL, round(variacao, 2)

    def _gerar_alertas(self, preco: MetricasPreco, entrega: MetricasEntrega,
                       qualidade: MetricasQualidade, comercial: MetricasComercial,
                       classificacao: ClassificacaoFornecedor) -> List[str]:
        """Gera alertas baseados na análise."""
        alertas = []

        if preco.variacao_vs_mercado > 10:
            alertas.append(f"Preços {preco.variacao_vs_mercado:.1f}% acima do mercado")

        if entrega.pontualidade_perc < 70:
            alertas.append(f"Pontualidade baixa: {entrega.pontualidade_perc:.0f}%")

        if entrega.lead_time_medio > 10:
            alertas.append(f"Lead time alto: {entrega.lead_time_medio:.0f} dias")

        if qualidade.taxa_devolucao > 5:
            alertas.append(f"Taxa de devolução alta: {qualidade.taxa_devolucao:.1f}%")

        if qualidade.problemas_validade > 0:
            alertas.append(f"{qualidade.problemas_validade} produtos com validade curta")

        if comercial.prazo_medio_pgto < 30:
            alertas.append(f"Prazo de pagamento curto: {comercial.prazo_medio_pgto} dias")

        if classificacao == ClassificacaoFornecedor.CRITICO:
            alertas.append("ATENÇÃO: Fornecedor crítico - avaliar substituição")

        return alertas

    def _gerar_recomendacoes(self, classificacao: ClassificacaoFornecedor,
                              preco: MetricasPreco, entrega: MetricasEntrega,
                              qualidade: MetricasQualidade,
                              comercial: MetricasComercial) -> List[str]:
        """Gera recomendações baseadas na análise."""
        recomendacoes = []

        if classificacao == ClassificacaoFornecedor.EXCELENTE:
            recomendacoes.append("Manter e priorizar nas compras")
            recomendacoes.append("Avaliar expansão do mix de produtos")

        elif classificacao == ClassificacaoFornecedor.BOM:
            if preco.variacao_vs_mercado > 5:
                recomendacoes.append("Negociar melhores preços")
            recomendacoes.append("Manter relacionamento")

        elif classificacao == ClassificacaoFornecedor.REGULAR:
            if preco.score < 60:
                recomendacoes.append("Buscar alternativas de preço")
            if entrega.score < 60:
                recomendacoes.append("Cobrar melhorias na entrega")
            recomendacoes.append("Monitorar de perto")

        elif classificacao in [ClassificacaoFornecedor.RUIM, ClassificacaoFornecedor.CRITICO]:
            recomendacoes.append("Buscar fornecedores alternativos")
            recomendacoes.append("Reduzir dependência")
            if not comercial.tem_bonificacao:
                recomendacoes.append("Negociar bonificações como compensação")

        return recomendacoes

    # =========================================================================
    # RECOMENDAÇÃO DE FORNECEDOR POR PRODUTO
    # =========================================================================

    def recomendar_fornecedor(self, id_prod: int, id_filial: int,
                               top: int = 3) -> List[Dict]:
        """
        Recomenda os melhores fornecedores para um produto.
        Combina score do fornecedor com preço do produto.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
            top: Quantidade de fornecedores a retornar

        Returns:
            Lista com fornecedores recomendados
        """
        sql = """
            SELECT
                f.CNPJForn,
                f.NomeForn,
                f.ScoreGeral,
                f.Classificacao,
                h.preco_medio,
                h.ultima_compra,
                (f.ScoreGeral * 0.6 + (100 - h.ranking_preco * 10) * 0.4) as score_combinado
            FROM ia_arqfornscor f
            INNER JOIN (
                SELECT
                    r.CNPJCPFFor as CpfCnpj,
                    AVG(ri.VlrUniCom) as preco_medio,
                    MAX(r.DatRece) as ultima_compra,
                    RANK() OVER (ORDER BY AVG(ri.VlrUniCom) ASC) as ranking_preco
                FROM arqcomprarec r
                INNER JOIN arqcomprarecite ri ON ri.IDRec = r.IDRec
                WHERE ri.IDProd = :id_prod
                  AND r.IDFilial = :id_filial
                  AND r.TipEnt = '0'
                  AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL 180 DAY)
                GROUP BY r.CNPJCPFFor
            ) h ON h.CpfCnpj = f.CNPJForn
            WHERE f.IDFilial = :id_filial
              AND f.Status = 'ATIVO'
            ORDER BY score_combinado DESC
            LIMIT :top
        """

        return self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial,
            'top': top
        }) or []

    def comparar_fornecedores_produto(self, id_prod: int, id_filial: int) -> List[Dict]:
        """
        Compara todos os fornecedores que vendem um produto.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Lista comparativa de fornecedores
        """
        sql = """
            SELECT
                r.CNPJCPFFor as cnpj,
                p.NomPes as nome,
                f.ScoreGeral as score,
                f.Classificacao as classificacao,
                AVG(ri.VlrUniCom) as preco_medio,
                MIN(ri.VlrUniCom) as preco_min,
                MAX(ri.VlrUniCom) as preco_max,
                COUNT(*) as qtd_compras,
                MAX(r.DatRece) as ultima_compra,
                AVG(DATEDIFF(r.DatRece, r.DatPed)) as lead_time_medio
            FROM arqcomprarec r
            INNER JOIN arqcomprarecite ri ON ri.IDRec = r.IDRec
            LEFT JOIN arqpessoa p ON p.CpfCnpjPes = r.CNPJCPFFor AND p.IDEsppes = 2
            LEFT JOIN ia_arqfornscor f ON f.CNPJForn = r.CNPJCPFFor
                AND f.IDFilial = r.IDFilial AND f.Status = 'ATIVO'
            WHERE ri.IDProd = :id_prod
              AND r.IDFilial = :id_filial
              AND r.TipEnt = '0'
              AND r.DatRece >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
            GROUP BY r.CNPJCPFFor, p.NomPes, f.ScoreGeral, f.Classificacao
            ORDER BY f.ScoreGeral DESC, preco_medio ASC
        """

        return self.db.execute_query(sql, {
            'id_prod': id_prod,
            'id_filial': id_filial
        }) or []
