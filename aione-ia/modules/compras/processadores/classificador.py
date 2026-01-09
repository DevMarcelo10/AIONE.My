"""
AIONE IA - Classificador de Produtos
Motor principal de classificação (SAUDÁVEL / ATENÇÃO / TÓXICO)
"""

from dataclasses import dataclass, field
from datetime import datetime, date
from typing import List, Dict, Optional, Any
from enum import Enum

from core.database import DatabaseManager
from core.utils.logger import get_logger

logger = get_logger(__name__)


# =============================================================================
# ENUMS DE CLASSIFICAÇÃO
# =============================================================================

class Classificacao(str, Enum):
    """Classificação final do produto"""
    SAUDAVEL = 'SAUDAVEL'
    ATENCAO = 'ATENCAO'
    TOXICO = 'TOXICO'


class CurvaABC(str, Enum):
    """Classificação ABC por faturamento"""
    A = 'A'  # Top produtos (70% faturamento)
    B = 'B'  # Intermediários (70-90%)
    C = 'C'  # Baixo giro (90-98%)
    D = 'D'  # Sem movimento (98-100%)


class ClasseGiro(str, Enum):
    """Classificação do giro de estoque"""
    OTIMO = 'OTIMO'      # Até 30 dias cobertura
    BOM = 'BOM'          # 31-60 dias
    REGULAR = 'REGULAR'  # 61-90 dias
    RUIM = 'RUIM'        # 91-180 dias
    PESSIMO = 'PESSIMO'  # Acima de 180 dias


class ClasseMargem(str, Enum):
    """Classificação da margem de lucro"""
    OTIMA = 'OTIMA'        # >= 30%
    BOA = 'BOA'            # 20-30%
    REGULAR = 'REGULAR'    # 10-20%
    BAIXA = 'BAIXA'        # 0-10%
    NEGATIVA = 'NEGATIVA'  # < 0%


class RiscoVencimento(str, Enum):
    """Nível de risco de vencimento"""
    BAIXO = 'BAIXO'      # > 90 dias
    MEDIO = 'MEDIO'      # 61-90 dias
    ALTO = 'ALTO'        # 31-60 dias
    CRITICO = 'CRITICO'  # <= 30 dias


class Tendencia(str, Enum):
    """Tendência de vendas"""
    CRESCENTE = 'CRESCENTE'
    ESTAVEL = 'ESTAVEL'
    DECRESCENTE = 'DECRESCENTE'


# =============================================================================
# PARÂMETROS DE CONFIGURAÇÃO
# =============================================================================

@dataclass
class ParametrosClassificacao:
    """
    Parâmetros configuráveis da classificação.

    Permite ajustar todos os limiares e pesos utilizados
    no processo de classificação de produtos.

    Attributes:
        dias_analise: Período de análise em dias (default: 90)
        dias_validade: Dias de validade da classificação (default: 7)
        curva_a_ate: Percentual acumulado para curva A (default: 0.70)
        curva_b_ate: Percentual acumulado para curva B (default: 0.90)
        curva_c_ate: Percentual acumulado para curva C (default: 0.98)
        giro_otimo_ate: Dias cobertura para giro ótimo (default: 30)
        giro_bom_ate: Dias cobertura para giro bom (default: 60)
        giro_regular_ate: Dias cobertura para giro regular (default: 90)
        giro_ruim_ate: Dias cobertura para giro ruim (default: 180)
        margem_otima_min: Margem mínima para classificação ótima (default: 30.0)
        margem_boa_min: Margem mínima para classificação boa (default: 20.0)
        margem_regular_min: Margem mínima para classificação regular (default: 10.0)
        margem_baixa_min: Margem mínima para classificação baixa (default: 0.0)
        freq_alta_min: Frequência mínima para venda alta (default: 70.0)
        freq_media_min: Frequência mínima para venda média (default: 40.0)
        freq_baixa_min: Frequência mínima para venda baixa (default: 15.0)
        dias_venc_critico: Dias para vencimento crítico (default: 30)
        dias_venc_alto: Dias para vencimento alto (default: 60)
        dias_venc_medio: Dias para vencimento médio (default: 90)
        peso_giro: Peso do giro no score geral (default: 30.0)
        peso_margem: Peso da margem no score geral (default: 25.0)
        peso_regularidade: Peso da regularidade no score geral (default: 20.0)
        peso_vencimento: Peso do vencimento no score geral (default: 15.0)
        peso_tendencia: Peso da tendência no score geral (default: 10.0)
        score_saudavel_min: Score mínimo para SAUDÁVEL (default: 60.0)
        score_atencao_min: Score mínimo para ATENÇÃO (default: 35.0)
    """

    # Dias de análise
    dias_analise: int = 90
    dias_validade: int = 7

    # Curva ABC (percentuais acumulados)
    curva_a_ate: float = 0.70      # 70% do faturamento
    curva_b_ate: float = 0.90      # 70-90%
    curva_c_ate: float = 0.98      # 90-98%
    # Curva D = resto (98-100%)

    # Giro (dias de cobertura)
    giro_otimo_ate: int = 30       # Até 30 dias = ótimo
    giro_bom_ate: int = 60         # 31-60 dias = bom
    giro_regular_ate: int = 90     # 61-90 dias = regular
    giro_ruim_ate: int = 180       # 91-180 dias = ruim
    # Acima de 180 = péssimo

    # Margem (%)
    margem_otima_min: float = 30.0
    margem_boa_min: float = 20.0
    margem_regular_min: float = 10.0
    margem_baixa_min: float = 0.0
    # Abaixo de 0 = negativa

    # Regularidade (frequência de venda %)
    freq_alta_min: float = 70.0    # Vende em 70%+ dos dias
    freq_media_min: float = 40.0   # Vende em 40-70%
    freq_baixa_min: float = 15.0   # Vende em 15-40%
    # Abaixo de 15% = esporádico

    # Vencimento
    dias_venc_critico: int = 30    # Vence em até 30 dias
    dias_venc_alto: int = 60       # Vence em 31-60 dias
    dias_venc_medio: int = 90      # Vence em 61-90 dias
    # Acima de 90 = baixo

    # Pesos para score geral (soma = 100)
    peso_giro: float = 30.0
    peso_margem: float = 25.0
    peso_regularidade: float = 20.0
    peso_vencimento: float = 15.0
    peso_tendencia: float = 10.0

    # Limiares de classificação final (score geral)
    score_saudavel_min: float = 60.0  # >= 60 = SAUDÁVEL
    score_atencao_min: float = 35.0   # 35-59 = ATENÇÃO
    # < 35 = TÓXICO

    def validar(self) -> bool:
        """
        Valida se os parâmetros são consistentes.

        Returns:
            True se válido, False caso contrário
        """
        # Verifica soma dos pesos
        soma_pesos = (
            self.peso_giro +
            self.peso_margem +
            self.peso_regularidade +
            self.peso_vencimento +
            self.peso_tendencia
        )
        if abs(soma_pesos - 100.0) > 0.01:
            logger.warning(f"Soma dos pesos ({soma_pesos}) difere de 100")
            return False

        # Verifica ordem das curvas
        if not (self.curva_a_ate < self.curva_b_ate < self.curva_c_ate < 1.0):
            logger.warning("Percentuais de curva ABC fora de ordem")
            return False

        # Verifica ordem dos giros
        if not (self.giro_otimo_ate < self.giro_bom_ate < self.giro_regular_ate < self.giro_ruim_ate):
            logger.warning("Dias de giro fora de ordem")
            return False

        # Verifica ordem das margens
        if not (self.margem_baixa_min < self.margem_regular_min < self.margem_boa_min < self.margem_otima_min):
            logger.warning("Percentuais de margem fora de ordem")
            return False

        return True


# =============================================================================
# RESULTADO DA CLASSIFICAÇÃO
# =============================================================================

@dataclass
class ResultadoClassificacao:
    """
    Resultado da classificação de um produto.

    Contém todos os indicadores calculados e a classificação final
    do produto em uma filial específica.

    Attributes:
        id_prod: ID do produto
        id_filial: ID da filial
        id_grupo: ID do grupo do produto (opcional)
        classificacao: Classificação final (SAUDAVEL/ATENCAO/TOXICO)
        score_geral: Score geral 0-100
        curva_abc: Classificação ABC (A/B/C/D)
        perc_faturamento: Percentual do faturamento
        rank_faturamento: Ranking por faturamento na filial
        giro_medio: Giro médio (vezes/ano)
        dias_cobertura: Dias de cobertura médio
        score_giro: Score de giro 0-100
        classe_giro: Classificação do giro
        margem_media: Margem média %
        margem_minima: Margem mínima praticada
        margem_maxima: Margem máxima praticada
        score_margem: Score de margem 0-100
        classe_margem: Classificação da margem
        coef_variacao: Coeficiente de variação das vendas
        dias_com_venda: Dias com venda no período
        dias_total: Total de dias analisados
        freq_venda: Frequência de venda %
        score_regularidade: Score de regularidade 0-100
        tendencia: Tendência de vendas
        var_tendencia: Variação % da tendência
        qtd_vencida: Quantidade vencida
        vlr_vencido: Valor perdido por vencimento
        perc_perda: % de perda sobre compras
        risco_vencimento: Nível de risco de vencimento
        dias_para_venc: Dias até vencimento do lote mais antigo
        score_vencimento: Score de vencimento 0-100
        estoque_atual: Estoque atual
        estoque_valor: Valor em estoque (custo)
        estoque_excesso: Quantidade em excesso
        bloquear_compra: Flag de bloqueio de compra
        motivo_bloqueio: Motivo do bloqueio
        alertas: Lista de alertas gerados
        recomendacoes: Lista de recomendações
        data_calculo: Data/hora do cálculo
    """

    # Identificação
    id_prod: int
    id_filial: int
    id_grupo: Optional[int] = None

    # Classificação final
    classificacao: Classificacao = Classificacao.ATENCAO
    score_geral: float = 0.0

    # Curva ABC
    curva_abc: CurvaABC = CurvaABC.D
    perc_faturamento: float = 0.0
    rank_faturamento: int = 0

    # Giro
    giro_medio: float = 0.0
    dias_cobertura: float = 999.0
    score_giro: float = 0.0
    classe_giro: ClasseGiro = ClasseGiro.PESSIMO

    # Margem
    margem_media: float = 0.0
    margem_minima: float = 0.0
    margem_maxima: float = 0.0
    score_margem: float = 0.0
    classe_margem: ClasseMargem = ClasseMargem.NEGATIVA

    # Regularidade
    coef_variacao: float = 0.0
    dias_com_venda: int = 0
    dias_total: int = 90
    freq_venda: float = 0.0
    score_regularidade: float = 0.0

    # Tendência
    tendencia: str = 'ESTAVEL'
    var_tendencia: float = 0.0

    # Vencimento
    qtd_vencida: float = 0.0
    vlr_vencido: float = 0.0
    perc_perda: float = 0.0
    risco_vencimento: RiscoVencimento = RiscoVencimento.BAIXO
    dias_para_venc: Optional[int] = None
    score_vencimento: float = 100.0

    # Estoque
    estoque_atual: float = 0.0
    estoque_valor: float = 0.0
    estoque_excesso: float = 0.0

    # Bloqueios
    bloquear_compra: bool = False
    motivo_bloqueio: Optional[str] = None

    # Alertas e recomendações
    alertas: List[str] = field(default_factory=list)
    recomendacoes: List[str] = field(default_factory=list)

    # Metadados
    data_calculo: datetime = None

    def __post_init__(self):
        """Inicialização pós-criação"""
        if self.data_calculo is None:
            self.data_calculo = datetime.now()
        if self.alertas is None:
            self.alertas = []
        if self.recomendacoes is None:
            self.recomendacoes = []

    def to_dict(self) -> Dict[str, Any]:
        """
        Converte para dicionário.

        Returns:
            Dicionário com todos os campos
        """
        return {
            'id_prod': self.id_prod,
            'id_filial': self.id_filial,
            'id_grupo': self.id_grupo,
            'classificacao': self.classificacao.value if isinstance(self.classificacao, Enum) else self.classificacao,
            'score_geral': self.score_geral,
            'curva_abc': self.curva_abc.value if isinstance(self.curva_abc, Enum) else self.curva_abc,
            'perc_faturamento': self.perc_faturamento,
            'rank_faturamento': self.rank_faturamento,
            'giro_medio': self.giro_medio,
            'dias_cobertura': self.dias_cobertura,
            'score_giro': self.score_giro,
            'classe_giro': self.classe_giro.value if isinstance(self.classe_giro, Enum) else self.classe_giro,
            'margem_media': self.margem_media,
            'margem_minima': self.margem_minima,
            'margem_maxima': self.margem_maxima,
            'score_margem': self.score_margem,
            'classe_margem': self.classe_margem.value if isinstance(self.classe_margem, Enum) else self.classe_margem,
            'coef_variacao': self.coef_variacao,
            'dias_com_venda': self.dias_com_venda,
            'dias_total': self.dias_total,
            'freq_venda': self.freq_venda,
            'score_regularidade': self.score_regularidade,
            'tendencia': self.tendencia,
            'var_tendencia': self.var_tendencia,
            'qtd_vencida': self.qtd_vencida,
            'vlr_vencido': self.vlr_vencido,
            'perc_perda': self.perc_perda,
            'risco_vencimento': self.risco_vencimento.value if isinstance(self.risco_vencimento, Enum) else self.risco_vencimento,
            'dias_para_venc': self.dias_para_venc,
            'score_vencimento': self.score_vencimento,
            'estoque_atual': self.estoque_atual,
            'estoque_valor': self.estoque_valor,
            'estoque_excesso': self.estoque_excesso,
            'bloquear_compra': self.bloquear_compra,
            'motivo_bloqueio': self.motivo_bloqueio,
            'alertas': self.alertas,
            'recomendacoes': self.recomendacoes,
            'data_calculo': self.data_calculo.isoformat() if self.data_calculo else None
        }

    def adicionar_alerta(self, alerta: str) -> None:
        """
        Adiciona um alerta à lista.

        Args:
            alerta: Texto do alerta
        """
        if alerta and alerta not in self.alertas:
            self.alertas.append(alerta)

    def adicionar_recomendacao(self, recomendacao: str) -> None:
        """
        Adiciona uma recomendação à lista.

        Args:
            recomendacao: Texto da recomendação
        """
        if recomendacao and recomendacao not in self.recomendacoes:
            self.recomendacoes.append(recomendacao)


# =============================================================================
# MOTOR PRINCIPAL DE CLASSIFICAÇÃO
# =============================================================================

class ClassificadorProdutos:
    """
    Motor principal de classificação de produtos.

    Orquestra os analisadores especializados para calcular
    a classificação final de cada produto.

    Attributes:
        db: Gerenciador de banco de dados
        parametros: Parâmetros de classificação
        analisador_abc: Analisador de curva ABC
        analisador_giro: Analisador de giro
        analisador_margem: Analisador de margem
        analisador_vencimento: Analisador de vencimento
        repositorio: Repositório de persistência

    Example:
        >>> classificador = ClassificadorProdutos(db)
        >>> resultado = await classificador.classificar_produto(123, 1)
        >>> print(resultado.classificacao)
        SAUDAVEL
    """

    def __init__(
        self,
        db: DatabaseManager,
        parametros: Optional[ParametrosClassificacao] = None
    ):
        """
        Inicializa o classificador.

        Args:
            db: Gerenciador de banco de dados
            parametros: Parâmetros de classificação (opcional)
        """
        self.db = db
        self.parametros = parametros or ParametrosClassificacao()

        # Valida parâmetros
        if not self.parametros.validar():
            logger.warning("Parâmetros de classificação com inconsistências")

        # Analisadores serão injetados ou criados sob demanda
        self._analisador_abc = None
        self._analisador_giro = None
        self._analisador_margem = None
        self._analisador_vencimento = None
        self._repositorio = None

        logger.info("ClassificadorProdutos inicializado")

    @property
    def analisador_abc(self):
        """Lazy loading do analisador ABC"""
        if self._analisador_abc is None:
            from .curva_abc import AnalisadorCurvaABC
            self._analisador_abc = AnalisadorCurvaABC(self.db, self.parametros)
        return self._analisador_abc

    @property
    def analisador_giro(self):
        """Lazy loading do analisador de giro"""
        if self._analisador_giro is None:
            from .analise_giro import AnalisadorGiro
            self._analisador_giro = AnalisadorGiro(self.db, self.parametros)
        return self._analisador_giro

    @property
    def analisador_margem(self):
        """Lazy loading do analisador de margem"""
        if self._analisador_margem is None:
            from .analise_margem import AnalisadorMargem
            self._analisador_margem = AnalisadorMargem(self.db, self.parametros)
        return self._analisador_margem

    @property
    def analisador_vencimento(self):
        """Lazy loading do analisador de vencimento"""
        if self._analisador_vencimento is None:
            from .analise_vencimento import AnalisadorVencimento
            self._analisador_vencimento = AnalisadorVencimento(self.db, self.parametros)
        return self._analisador_vencimento

    @property
    def repositorio(self):
        """Lazy loading do repositório"""
        if self._repositorio is None:
            from .repositorio_class import ClassificacaoRepositorio
            self._repositorio = ClassificacaoRepositorio(self.db)
        return self._repositorio

    async def classificar_produto(
        self,
        id_prod: int,
        id_filial: int
    ) -> ResultadoClassificacao:
        """
        Classifica um produto específico.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            ResultadoClassificacao com todos os indicadores
        """
        logger.debug(f"Classificando produto {id_prod} na filial {id_filial}")

        # Inicializa resultado
        resultado = ResultadoClassificacao(
            id_prod=id_prod,
            id_filial=id_filial,
            dias_total=self.parametros.dias_analise
        )

        # Busca grupo do produto
        resultado.id_grupo = await self._buscar_grupo(id_prod)

        # Executa análises
        await self._analisar_curva_abc(resultado)
        await self._analisar_giro(resultado)
        await self._analisar_margem(resultado)
        await self._analisar_vencimento(resultado)
        await self._analisar_tendencia(resultado)

        # Calcula score geral e classificação final
        self._calcular_score_geral(resultado)
        self._definir_classificacao(resultado)

        # Gera alertas e recomendações
        self._gerar_alertas(resultado)
        self._gerar_recomendacoes(resultado)

        # Verifica bloqueio
        self._verificar_bloqueio(resultado)

        logger.debug(
            f"Produto {id_prod}: {resultado.classificacao.value} "
            f"(score={resultado.score_geral:.1f})"
        )

        return resultado

    async def classificar_filial(
        self,
        id_filial: int,
        apenas_ativos: bool = True
    ) -> List[ResultadoClassificacao]:
        """
        Classifica todos os produtos de uma filial.

        Args:
            id_filial: ID da filial
            apenas_ativos: Se True, classifica apenas produtos ativos

        Returns:
            Lista de ResultadoClassificacao
        """
        logger.info(f"Iniciando classificação da filial {id_filial}")

        # Busca produtos da filial
        produtos = await self._buscar_produtos_filial(id_filial, apenas_ativos)

        resultados = []
        total = len(produtos)

        for i, id_prod in enumerate(produtos, 1):
            if i % 100 == 0:
                logger.info(f"Classificando produto {i}/{total}")

            resultado = await self.classificar_produto(id_prod, id_filial)
            resultados.append(resultado)

        logger.info(f"Classificação concluída: {total} produtos")

        return resultados

    async def classificar_e_salvar(
        self,
        id_filial: int,
        apenas_ativos: bool = True
    ) -> Dict[str, Any]:
        """
        Classifica e persiste resultados no banco.

        Args:
            id_filial: ID da filial
            apenas_ativos: Se True, classifica apenas produtos ativos

        Returns:
            Resumo da classificação
        """
        # Classifica
        resultados = await self.classificar_filial(id_filial, apenas_ativos)

        # Salva
        await self.repositorio.salvar_lote(resultados, self.parametros.dias_validade)

        # Gera resumo
        resumo = self._gerar_resumo(resultados)

        logger.info(
            f"Filial {id_filial}: {resumo['total']} produtos classificados - "
            f"SAUDÁVEL={resumo['saudavel']}, ATENÇÃO={resumo['atencao']}, TÓXICO={resumo['toxico']}"
        )

        return resumo

    # =========================================================================
    # MÉTODOS PRIVADOS - ANÁLISES
    # =========================================================================

    async def _buscar_grupo(self, id_prod: int) -> Optional[int]:
        """Busca o grupo do produto"""
        query = "SELECT IDGrupo FROM arqproduto WHERE IDProd = :id_prod"
        result = await self.db.execute(query, {'id_prod': id_prod})
        if result:
            return result[0].get('IDGrupo')
        return None

    async def _buscar_produtos_filial(
        self,
        id_filial: int,
        apenas_ativos: bool
    ) -> List[int]:
        """Busca lista de produtos da filial"""
        query = """
            SELECT DISTINCT p.IDProd
            FROM arqproduto p
            WHERE EXISTS (
                SELECT 1 FROM arqprodutolot l
                WHERE l.IDProd = p.IDProd
                  AND l.IDFilial = :id_filial
            )
        """
        if apenas_ativos:
            query += " AND p.Ativo = 'S'"

        result = await self.db.execute(query, {'id_filial': id_filial})
        return [r['IDProd'] for r in result]

    async def _analisar_curva_abc(self, resultado: ResultadoClassificacao) -> None:
        """Executa análise de curva ABC"""
        abc = await self.analisador_abc.analisar(
            resultado.id_prod,
            resultado.id_filial
        )
        resultado.curva_abc = abc.curva
        resultado.perc_faturamento = abc.percentual
        resultado.rank_faturamento = abc.ranking

    async def _analisar_giro(self, resultado: ResultadoClassificacao) -> None:
        """Executa análise de giro"""
        giro = await self.analisador_giro.analisar(
            resultado.id_prod,
            resultado.id_filial
        )
        resultado.giro_medio = giro.giro_medio
        resultado.dias_cobertura = giro.dias_cobertura
        resultado.score_giro = giro.score
        resultado.classe_giro = giro.classe
        resultado.estoque_atual = giro.estoque_atual
        resultado.estoque_valor = giro.estoque_valor
        resultado.estoque_excesso = giro.estoque_excesso
        resultado.coef_variacao = giro.coef_variacao
        resultado.dias_com_venda = giro.dias_com_venda
        resultado.freq_venda = giro.freq_venda
        resultado.score_regularidade = giro.score_regularidade

    async def _analisar_margem(self, resultado: ResultadoClassificacao) -> None:
        """Executa análise de margem"""
        margem = await self.analisador_margem.analisar(
            resultado.id_prod,
            resultado.id_filial
        )
        resultado.margem_media = margem.margem_media
        resultado.margem_minima = margem.margem_minima
        resultado.margem_maxima = margem.margem_maxima
        resultado.score_margem = margem.score
        resultado.classe_margem = margem.classe

    async def _analisar_vencimento(self, resultado: ResultadoClassificacao) -> None:
        """Executa análise de vencimento"""
        venc = await self.analisador_vencimento.analisar(
            resultado.id_prod,
            resultado.id_filial
        )
        resultado.qtd_vencida = venc.qtd_vencida
        resultado.vlr_vencido = venc.vlr_vencido
        resultado.perc_perda = venc.perc_perda
        resultado.risco_vencimento = venc.risco
        resultado.dias_para_venc = venc.dias_para_venc
        resultado.score_vencimento = venc.score

    async def _analisar_tendencia(self, resultado: ResultadoClassificacao) -> None:
        """Analisa tendência de vendas"""
        # Usa dados do analisador de giro que já calculou tendência
        # TODO: Implementar análise de tendência mais sofisticada
        pass

    # =========================================================================
    # MÉTODOS PRIVADOS - CÁLCULOS
    # =========================================================================

    def _calcular_score_geral(self, resultado: ResultadoClassificacao) -> None:
        """Calcula score geral ponderado"""
        p = self.parametros

        # Score de tendência (simplificado)
        score_tendencia = 50.0  # Neutro por padrão
        if resultado.tendencia == 'CRESCENTE':
            score_tendencia = 80.0
        elif resultado.tendencia == 'DECRESCENTE':
            score_tendencia = 20.0

        # Cálculo ponderado
        resultado.score_geral = (
            (resultado.score_giro * p.peso_giro +
             resultado.score_margem * p.peso_margem +
             resultado.score_regularidade * p.peso_regularidade +
             resultado.score_vencimento * p.peso_vencimento +
             score_tendencia * p.peso_tendencia) / 100.0
        )

    def _definir_classificacao(self, resultado: ResultadoClassificacao) -> None:
        """Define classificação final baseada no score"""
        p = self.parametros

        if resultado.score_geral >= p.score_saudavel_min:
            resultado.classificacao = Classificacao.SAUDAVEL
        elif resultado.score_geral >= p.score_atencao_min:
            resultado.classificacao = Classificacao.ATENCAO
        else:
            resultado.classificacao = Classificacao.TOXICO

    # =========================================================================
    # MÉTODOS PRIVADOS - ALERTAS E RECOMENDAÇÕES
    # =========================================================================

    def _gerar_alertas(self, resultado: ResultadoClassificacao) -> None:
        """Gera alertas baseados nos indicadores"""
        # Alerta de vencimento
        if resultado.risco_vencimento == RiscoVencimento.CRITICO:
            resultado.adicionar_alerta(
                f"CRÍTICO: Lote vence em {resultado.dias_para_venc} dias"
            )
        elif resultado.risco_vencimento == RiscoVencimento.ALTO:
            resultado.adicionar_alerta(
                f"ALERTA: Lote vence em {resultado.dias_para_venc} dias"
            )

        # Alerta de estoque parado
        if resultado.classe_giro == ClasseGiro.PESSIMO:
            resultado.adicionar_alerta(
                f"Estoque parado: {resultado.dias_cobertura:.0f} dias de cobertura"
            )

        # Alerta de margem negativa
        if resultado.classe_margem == ClasseMargem.NEGATIVA:
            resultado.adicionar_alerta(
                f"Margem negativa: {resultado.margem_media:.1f}%"
            )

        # Alerta de perda por vencimento
        if resultado.perc_perda > 5:
            resultado.adicionar_alerta(
                f"Perda por vencimento: {resultado.perc_perda:.1f}% das compras"
            )

        # Alerta de excesso de estoque
        if resultado.estoque_excesso > 0:
            resultado.adicionar_alerta(
                f"Excesso de estoque: {resultado.estoque_excesso:.0f} unidades"
            )

    def _gerar_recomendacoes(self, resultado: ResultadoClassificacao) -> None:
        """Gera recomendações baseadas nos indicadores"""
        # Produto tóxico
        if resultado.classificacao == Classificacao.TOXICO:
            resultado.adicionar_recomendacao(
                "Avaliar descontinuação ou promoção agressiva"
            )

        # Giro ruim
        if resultado.classe_giro in [ClasseGiro.RUIM, ClasseGiro.PESSIMO]:
            resultado.adicionar_recomendacao(
                "Reduzir quantidade de compra ou negociar consignação"
            )

        # Margem baixa em produto de alto giro
        if (resultado.curva_abc == CurvaABC.A and
            resultado.classe_margem in [ClasseMargem.BAIXA, ClasseMargem.NEGATIVA]):
            resultado.adicionar_recomendacao(
                "Renegociar preço de compra - produto de alto giro com margem baixa"
            )

        # Vencimento próximo
        if resultado.risco_vencimento in [RiscoVencimento.ALTO, RiscoVencimento.CRITICO]:
            resultado.adicionar_recomendacao(
                "Promover venda imediata do lote próximo ao vencimento"
            )

        # Vendas irregulares
        if resultado.freq_venda < self.parametros.freq_baixa_min:
            resultado.adicionar_recomendacao(
                "Produto de venda esporádica - manter estoque mínimo"
            )

    def _verificar_bloqueio(self, resultado: ResultadoClassificacao) -> None:
        """Verifica se deve bloquear compras"""
        motivos = []

        # Bloqueia se tóxico com estoque alto
        if (resultado.classificacao == Classificacao.TOXICO and
            resultado.dias_cobertura > 180):
            motivos.append("Produto tóxico com estoque > 180 dias")

        # Bloqueia se vencimento crítico
        if resultado.risco_vencimento == RiscoVencimento.CRITICO:
            motivos.append("Lote com vencimento crítico")

        # Bloqueia se perda muito alta
        if resultado.perc_perda > 20:
            motivos.append(f"Perda por vencimento > 20%")

        if motivos:
            resultado.bloquear_compra = True
            resultado.motivo_bloqueio = "; ".join(motivos)

    # =========================================================================
    # MÉTODOS PRIVADOS - RESUMO
    # =========================================================================

    def _gerar_resumo(self, resultados: List[ResultadoClassificacao]) -> Dict[str, Any]:
        """Gera resumo da classificação"""
        total = len(resultados)

        saudavel = sum(1 for r in resultados if r.classificacao == Classificacao.SAUDAVEL)
        atencao = sum(1 for r in resultados if r.classificacao == Classificacao.ATENCAO)
        toxico = sum(1 for r in resultados if r.classificacao == Classificacao.TOXICO)
        bloqueados = sum(1 for r in resultados if r.bloquear_compra)

        curva_a = sum(1 for r in resultados if r.curva_abc == CurvaABC.A)
        curva_b = sum(1 for r in resultados if r.curva_abc == CurvaABC.B)
        curva_c = sum(1 for r in resultados if r.curva_abc == CurvaABC.C)
        curva_d = sum(1 for r in resultados if r.curva_abc == CurvaABC.D)

        return {
            'total': total,
            'saudavel': saudavel,
            'atencao': atencao,
            'toxico': toxico,
            'bloqueados': bloqueados,
            'curva_a': curva_a,
            'curva_b': curva_b,
            'curva_c': curva_c,
            'curva_d': curva_d,
            'perc_saudavel': (saudavel / total * 100) if total > 0 else 0,
            'perc_atencao': (atencao / total * 100) if total > 0 else 0,
            'perc_toxico': (toxico / total * 100) if total > 0 else 0
        }
