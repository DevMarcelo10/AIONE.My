"""
AIONE IA - Repositório de Score de Fornecedores
Persistência dos scores de fornecedores na tabela ia_arqfornscor
"""

from datetime import datetime, date, timedelta
from typing import List, Dict, Optional
import json

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .analisador import ResultadoScoreFornecedor, ClassificacaoFornecedor


class FornecedorScoreRepositorio:
    """
    Repositório para persistência de scores de fornecedores.

    Gerencia a tabela ia_arqfornscor com:
    - Inserção de novos scores
    - Consulta de scores ativos
    - Histórico de evolução
    - Expiração de scores antigos
    - Atualização de rankings

    Attributes:
        db: Gerenciador de banco de dados

    Example:
        >>> repo = FornecedorScoreRepositorio(db)
        >>> id_score = repo.salvar(resultado)
        >>> score = repo.obter_ativo('12345678000190', 1)
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    # =========================================================================
    # GRAVAÇÃO
    # =========================================================================

    def salvar(self, resultado: ResultadoScoreFornecedor,
               dias_validade: int = 30) -> int:
        """
        Salva score do fornecedor.
        Marca anteriores como SUBSTITUIDO.

        Args:
            resultado: Resultado da análise do fornecedor
            dias_validade: Dias de validade do score

        Returns:
            IDFornScore gerado
        """
        # Marca anteriores
        self._marcar_substituidos(resultado.id_filial, resultado.cnpj)

        data_validade = date.today() + timedelta(days=dias_validade)

        sql = """
            INSERT INTO ia_arqfornscor (
                IDFilial, CNPJForn, NomeForn,
                ScoreGeral, Classificacao, Ranking,
                ScorePreco, ScoreEntrega, ScoreQualidade, ScoreComercial,
                PrecoMedioVar, ReajusteAnual, DescontoMedio,
                LeadTimeMedio, PontualidadePerc, AtrasoMedioDias, TotalPedidos, PedidosAtraso,
                TaxaDevolucao, TaxaAvaria, ProblemaValid, TotalItensRec, ItensDevolvidos,
                PrazoMedioPgto, PedidoMinimo, TemBonificacao, TemRebate, FlexPedido,
                VlrCompras12m, QtdProdutos, PercPartCompras, Exclusividades,
                Tendencia, ScoreAnterior, VarScore,
                AlertasJSON, RecomendJSON,
                DatCalculo, DatValidade, PeriodoAnalise, Status
            ) VALUES (
                :id_filial, :cnpj, :nome,
                :score_geral, :classificacao, :ranking,
                :score_preco, :score_entrega, :score_qualidade, :score_comercial,
                :preco_var, :reajuste, :desconto,
                :lead_time, :pontualidade, :atraso_medio, :total_pedidos, :pedidos_atraso,
                :taxa_dev, :taxa_avaria, :prob_valid, :total_itens, :itens_dev,
                :prazo_pgto, :ped_minimo, :tem_bonif, :tem_rebate, :flex_ped,
                :vlr_compras, :qtd_produtos, :perc_part, :exclusividades,
                :tendencia, :score_anterior, :var_score,
                :alertas_json, :recomend_json,
                NOW(), :data_validade, :periodo_analise, 'ATIVO'
            )
        """

        mp = resultado.metricas_preco
        me = resultado.metricas_entrega
        mq = resultado.metricas_qualidade
        mc = resultado.metricas_comercial

        params = {
            'id_filial': resultado.id_filial,
            'cnpj': resultado.cnpj,
            'nome': resultado.nome,
            'score_geral': resultado.score_geral,
            'classificacao': resultado.classificacao.value,
            'ranking': resultado.ranking,
            'score_preco': resultado.score_preco,
            'score_entrega': resultado.score_entrega,
            'score_qualidade': resultado.score_qualidade,
            'score_comercial': resultado.score_comercial,
            'preco_var': mp.variacao_vs_mercado if mp else 0,
            'reajuste': mp.reajuste_anual if mp else 0,
            'desconto': mp.desconto_medio if mp else 0,
            'lead_time': me.lead_time_medio if me else 0,
            'pontualidade': me.pontualidade_perc if me else 0,
            'atraso_medio': me.atraso_medio_dias if me else 0,
            'total_pedidos': me.total_pedidos if me else 0,
            'pedidos_atraso': me.pedidos_atraso if me else 0,
            'taxa_dev': mq.taxa_devolucao if mq else 0,
            'taxa_avaria': mq.taxa_avaria if mq else 0,
            'prob_valid': mq.problemas_validade if mq else 0,
            'total_itens': mq.total_itens_recebidos if mq else 0,
            'itens_dev': mq.itens_devolvidos if mq else 0,
            'prazo_pgto': mc.prazo_medio_pgto if mc else 0,
            'ped_minimo': mc.pedido_minimo if mc else 0,
            'tem_bonif': 1 if mc and mc.tem_bonificacao else 0,
            'tem_rebate': 1 if mc and mc.tem_rebate else 0,
            'flex_ped': 1 if mc and mc.flex_pedido else 0,
            'vlr_compras': resultado.vlr_compras_12m,
            'qtd_produtos': resultado.qtd_produtos,
            'perc_part': resultado.perc_part_compras,
            'exclusividades': resultado.exclusividades,
            'tendencia': resultado.tendencia.value if resultado.tendencia else 'ESTAVEL',
            'score_anterior': resultado.score_anterior,
            'var_score': resultado.var_score,
            'alertas_json': json.dumps(resultado.alertas, ensure_ascii=False),
            'recomend_json': json.dumps(resultado.recomendacoes, ensure_ascii=False),
            'data_validade': data_validade,
            'periodo_analise': resultado.periodo_analise
        }

        id_score = self.db.execute_insert(sql, params)
        self.logger.debug(f"Score fornecedor salvo: ID={id_score}, CNPJ={resultado.cnpj}")

        return id_score

    def salvar_lote(self, resultados: List[ResultadoScoreFornecedor],
                    dias_validade: int = 30,
                    atualizar_rankings: bool = True) -> int:
        """
        Salva múltiplos scores em lote.

        Args:
            resultados: Lista de resultados
            dias_validade: Dias de validade
            atualizar_rankings: Se True, atualiza rankings após salvar

        Returns:
            Quantidade de registros salvos
        """
        salvos = 0
        filiais_processadas = set()

        for resultado in resultados:
            try:
                self.salvar(resultado, dias_validade)
                salvos += 1
                filiais_processadas.add(resultado.id_filial)
            except Exception as e:
                self.logger.warning(f"Erro ao salvar fornecedor {resultado.cnpj}: {e}")

        # Atualiza rankings de todas as filiais processadas
        if atualizar_rankings:
            for id_filial in filiais_processadas:
                try:
                    self.atualizar_rankings(id_filial)
                except Exception as e:
                    self.logger.warning(f"Erro ao atualizar rankings filial {id_filial}: {e}")

        self.logger.info(f"Lote de scores salvos: {salvos}/{len(resultados)}")
        return salvos

    def _marcar_substituidos(self, id_filial: int, cnpj: str):
        """Marca scores anteriores como SUBSTITUIDO."""
        sql = """
            UPDATE ia_arqfornscor
            SET Status = 'SUBSTITUIDO'
            WHERE IDFilial = :id_filial
              AND CNPJForn = :cnpj
              AND Status = 'ATIVO'
        """
        self.db.execute_query(sql, {'id_filial': id_filial, 'cnpj': cnpj})

    def atualizar_rankings(self, id_filial: int):
        """
        Atualiza rankings dos fornecedores da filial.
        Ranking 1 = melhor score.

        Args:
            id_filial: ID da filial
        """
        sql = """
            UPDATE ia_arqfornscor f1
            INNER JOIN (
                SELECT
                    IDFornScor,
                    ROW_NUMBER() OVER (ORDER BY ScoreGeral DESC) as novo_ranking
                FROM ia_arqfornscor
                WHERE IDFilial = :id_filial
                  AND Status = 'ATIVO'
            ) f2 ON f2.IDFornScor = f1.IDFornScor
            SET f1.Ranking = f2.novo_ranking
        """

        self.db.execute_query(sql, {'id_filial': id_filial})
        self.logger.info(f"Rankings atualizados para filial {id_filial}")

    def marcar_expirados(self) -> int:
        """
        Marca como EXPIRADO scores vencidos.

        Returns:
            Quantidade de registros atualizados
        """
        sql = """
            UPDATE ia_arqfornscor
            SET Status = 'EXPIRADO'
            WHERE Status = 'ATIVO'
              AND DatValidade < CURDATE()
        """
        result = self.db.execute_query(sql)
        self.logger.info("Scores expirados marcados")
        return result if isinstance(result, int) else 0

    def limpar_historico(self, dias_manter: int = 365) -> int:
        """
        Remove registros muito antigos.

        Args:
            dias_manter: Dias de histórico para manter

        Returns:
            Quantidade de registros removidos
        """
        data_limite = date.today() - timedelta(days=dias_manter)

        sql = """
            DELETE FROM ia_arqfornscor
            WHERE DatCalculo < :data_limite
              AND Status IN ('EXPIRADO', 'SUBSTITUIDO')
        """

        try:
            result = self.db.execute_query(sql, {'data_limite': data_limite})
            self.logger.info(f"Histórico de scores anterior a {data_limite} removido")
            return result if isinstance(result, int) else 0
        except Exception as e:
            self.logger.error(f"Erro ao limpar histórico: {e}")
            return 0

    # =========================================================================
    # LEITURA
    # =========================================================================

    def obter_ativo(self, cnpj: str, id_filial: int) -> Optional[Dict]:
        """
        Obtém score ativo de um fornecedor.

        Args:
            cnpj: CNPJ do fornecedor
            id_filial: ID da filial

        Returns:
            Dict com dados do score ou None
        """
        sql = """
            SELECT * FROM ia_arqfornscor
            WHERE CNPJForn = :cnpj
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
              AND DatValidade >= CURDATE()
            LIMIT 1
        """
        result = self.db.execute_query(sql, {'cnpj': cnpj, 'id_filial': id_filial})

        if result:
            return self._parse_registro(result[0])
        return None

    def listar_filial(self, id_filial: int,
                      classificacao: str = None,
                      ordem: str = 'score',
                      limite: int = 100) -> List[Dict]:
        """
        Lista scores de fornecedores de uma filial.

        Args:
            id_filial: ID da filial
            classificacao: Filtrar por EXCELENTE/BOM/REGULAR/RUIM/CRITICO
            ordem: 'score' (maior primeiro) ou 'ranking'
            limite: Máximo de registros

        Returns:
            Lista de scores
        """
        conditions = ["IDFilial = :id_filial", "Status = 'ATIVO'", "DatValidade >= CURDATE()"]
        params = {'id_filial': id_filial, 'limite': limite}

        if classificacao:
            conditions.append("Classificacao = :classif")
            params['classif'] = classificacao.upper()

        order_by = "ScoreGeral DESC" if ordem == 'score' else "Ranking ASC"

        sql = f"""
            SELECT * FROM ia_arqfornscor
            WHERE {' AND '.join(conditions)}
            ORDER BY {order_by}
            LIMIT :limite
        """

        result = self.db.execute_query(sql, params) or []
        return [self._parse_registro(r) for r in result]

    def ranking_fornecedores(self, id_filial: int, top: int = 10) -> List[Dict]:
        """
        Retorna top N fornecedores da filial.

        Args:
            id_filial: ID da filial
            top: Quantidade no ranking

        Returns:
            Lista com ranking
        """
        sql = """
            SELECT
                CNPJForn, NomeForn, ScoreGeral, Classificacao, Ranking,
                ScorePreco, ScoreEntrega, ScoreQualidade, ScoreComercial,
                VlrCompras12m, QtdProdutos, Tendencia
            FROM ia_arqfornscor
            WHERE IDFilial = :id_filial
              AND Status = 'ATIVO'
              AND DatValidade >= CURDATE()
            ORDER BY ScoreGeral DESC
            LIMIT :top
        """

        result = self.db.execute_query(sql, {'id_filial': id_filial, 'top': top}) or []

        # Adiciona posição no ranking se não tiver
        for i, r in enumerate(result):
            if not r.get('Ranking'):
                r['Ranking'] = i + 1

        return result

    def fornecedores_criticos(self, id_filial: int, limite: int = 20) -> List[Dict]:
        """
        Lista fornecedores críticos ou ruins.

        Args:
            id_filial: ID da filial
            limite: Limite de registros

        Returns:
            Lista de fornecedores críticos
        """
        sql = """
            SELECT
                CNPJForn, NomeForn, ScoreGeral, Classificacao, Ranking,
                ScorePreco, ScoreEntrega, ScoreQualidade, ScoreComercial,
                Tendencia, VarScore, AlertasJSON, RecomendJSON
            FROM ia_arqfornscor
            WHERE IDFilial = :id_filial
              AND Status = 'ATIVO'
              AND Classificacao IN ('CRITICO', 'RUIM')
            ORDER BY ScoreGeral ASC
            LIMIT :limite
        """

        result = self.db.execute_query(sql, {
            'id_filial': id_filial,
            'limite': limite
        }) or []

        return [self._parse_registro(r) for r in result]

    def resumo_filial(self, id_filial: int) -> Dict:
        """
        Retorna resumo dos scores da filial.

        Args:
            id_filial: ID da filial

        Returns:
            Dict com estatísticas
        """
        sql = """
            SELECT
                COUNT(*) as total,
                SUM(CASE WHEN Classificacao = 'EXCELENTE' THEN 1 ELSE 0 END) as excelente,
                SUM(CASE WHEN Classificacao = 'BOM' THEN 1 ELSE 0 END) as bom,
                SUM(CASE WHEN Classificacao = 'REGULAR' THEN 1 ELSE 0 END) as regular,
                SUM(CASE WHEN Classificacao = 'RUIM' THEN 1 ELSE 0 END) as ruim,
                SUM(CASE WHEN Classificacao = 'CRITICO' THEN 1 ELSE 0 END) as critico,
                AVG(ScoreGeral) as score_medio,
                AVG(ScorePreco) as score_preco_medio,
                AVG(ScoreEntrega) as score_entrega_medio,
                AVG(ScoreQualidade) as score_qualidade_medio,
                AVG(ScoreComercial) as score_comercial_medio,
                SUM(VlrCompras12m) as vlr_total_compras,
                MAX(DatCalculo) as ultima_atualizacao
            FROM ia_arqfornscor
            WHERE IDFilial = :id_filial
              AND Status = 'ATIVO'
              AND DatValidade >= CURDATE()
        """

        result = self.db.execute_query(sql, {'id_filial': id_filial})

        if result and result[0]:
            r = result[0]
            total = int(r['total'] or 0)

            return {
                'total_fornecedores': total,
                'por_classificacao': {
                    'EXCELENTE': int(r['excelente'] or 0),
                    'BOM': int(r['bom'] or 0),
                    'REGULAR': int(r['regular'] or 0),
                    'RUIM': int(r['ruim'] or 0),
                    'CRITICO': int(r['critico'] or 0)
                },
                'percentuais': {
                    'excelente': round((r['excelente'] or 0) / total * 100, 1) if total > 0 else 0,
                    'bom': round((r['bom'] or 0) / total * 100, 1) if total > 0 else 0,
                    'regular': round((r['regular'] or 0) / total * 100, 1) if total > 0 else 0,
                    'ruim': round((r['ruim'] or 0) / total * 100, 1) if total > 0 else 0,
                    'critico': round((r['critico'] or 0) / total * 100, 1) if total > 0 else 0
                },
                'score_medio': round(float(r['score_medio'] or 0), 2),
                'scores_por_criterio': {
                    'preco': round(float(r['score_preco_medio'] or 0), 2),
                    'entrega': round(float(r['score_entrega_medio'] or 0), 2),
                    'qualidade': round(float(r['score_qualidade_medio'] or 0), 2),
                    'comercial': round(float(r['score_comercial_medio'] or 0), 2)
                },
                'vlr_total_compras': float(r['vlr_total_compras'] or 0),
                'ultima_atualizacao': r['ultima_atualizacao']
            }

        return {
            'total_fornecedores': 0,
            'por_classificacao': {'EXCELENTE': 0, 'BOM': 0, 'REGULAR': 0, 'RUIM': 0, 'CRITICO': 0},
            'percentuais': {'excelente': 0, 'bom': 0, 'regular': 0, 'ruim': 0, 'critico': 0},
            'score_medio': 0,
            'scores_por_criterio': {'preco': 0, 'entrega': 0, 'qualidade': 0, 'comercial': 0},
            'vlr_total_compras': 0,
            'ultima_atualizacao': None
        }

    def historico_score(self, cnpj: str, id_filial: int, meses: int = 12) -> List[Dict]:
        """
        Retorna histórico de scores do fornecedor.

        Args:
            cnpj: CNPJ do fornecedor
            id_filial: ID da filial
            meses: Meses de histórico

        Returns:
            Lista com evolução do score
        """
        sql = """
            SELECT
                DATE_FORMAT(DatCalculo, '%Y-%m') as mes,
                ScoreGeral,
                Classificacao,
                ScorePreco,
                ScoreEntrega,
                ScoreQualidade,
                ScoreComercial
            FROM ia_arqfornscor
            WHERE CNPJForn = :cnpj
              AND IDFilial = :id_filial
              AND DatCalculo >= DATE_SUB(CURDATE(), INTERVAL :meses MONTH)
            ORDER BY DatCalculo ASC
        """

        return self.db.execute_query(sql, {
            'cnpj': cnpj,
            'id_filial': id_filial,
            'meses': meses
        }) or []

    def comparar_fornecedores(self, cnpjs: List[str], id_filial: int) -> List[Dict]:
        """
        Compara múltiplos fornecedores.

        Args:
            cnpjs: Lista de CNPJs a comparar
            id_filial: ID da filial

        Returns:
            Lista com dados dos fornecedores para comparação
        """
        if not cnpjs:
            return []

        placeholders = ', '.join([f':cnpj_{i}' for i in range(len(cnpjs))])
        params = {'id_filial': id_filial}
        for i, cnpj in enumerate(cnpjs):
            params[f'cnpj_{i}'] = cnpj

        sql = f"""
            SELECT
                CNPJForn, NomeForn, ScoreGeral, Classificacao, Ranking,
                ScorePreco, ScoreEntrega, ScoreQualidade, ScoreComercial,
                VlrCompras12m, QtdProdutos, Tendencia, VarScore
            FROM ia_arqfornscor
            WHERE IDFilial = :id_filial
              AND Status = 'ATIVO'
              AND CNPJForn IN ({placeholders})
            ORDER BY ScoreGeral DESC
        """

        return self.db.execute_query(sql, params) or []

    def _parse_registro(self, registro: Dict) -> Dict:
        """
        Parse JSON fields do registro.

        Args:
            registro: Registro do banco

        Returns:
            Registro com JSONs parseados
        """
        if registro.get('AlertasJSON'):
            try:
                registro['AlertasJSON'] = json.loads(registro['AlertasJSON'])
            except:
                registro['AlertasJSON'] = []

        if registro.get('RecomendJSON'):
            try:
                registro['RecomendJSON'] = json.loads(registro['RecomendJSON'])
            except:
                registro['RecomendJSON'] = []

        return registro

    # =========================================================================
    # MÉTODOS ASYNC (COMPATIBILIDADE COM ROUTES)
    # =========================================================================

    async def buscar(self, cnpj: str, id_filial: int) -> Optional[Dict]:
        """Alias async para obter_ativo."""
        return self.obter_ativo(cnpj, id_filial)

    async def buscar_por_filial(self, id_filial: int,
                                 classificacao: str = None,
                                 ordem: str = 'score',
                                 limite: int = 100) -> List[Dict]:
        """Alias async para listar_filial."""
        return self.listar_filial(id_filial, classificacao, ordem, limite)

    async def obter_resumo(self, id_filial: int) -> Dict:
        """Alias async para resumo_filial."""
        return self.resumo_filial(id_filial)

    async def ranking(self, id_filial: int, top: int = 10) -> List[Dict]:
        """Alias async para ranking_fornecedores."""
        return self.ranking_fornecedores(id_filial, top)
