"""
AIONE IA - Repositório de Classificação
Persistência de classificações na tabela ia_arqprodclas
"""

import json
from datetime import datetime, date, timedelta
from typing import List, Optional, Dict, Any

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .classificador import ResultadoClassificacao, Classificacao, CurvaABC

logger = get_logger(__name__)


class ClassificacaoRepositorio:
    """
    Repositório para persistência de classificações.

    Gerencia a tabela ia_arqprodclas com operações de
    inserção, atualização e consulta.

    Attributes:
        db: Gerenciador de banco de dados

    Example:
        >>> repo = ClassificacaoRepositorio(db)
        >>> await repo.salvar(resultado)
        >>> classificacao = await repo.buscar(123, 1)
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o repositório.

        Args:
            db: Gerenciador de banco de dados
        """
        self.db = db

    async def salvar(
        self,
        resultado: ResultadoClassificacao,
        dias_validade: int = 7
    ) -> int:
        """
        Salva uma classificação.

        Args:
            resultado: Resultado da classificação
            dias_validade: Dias de validade

        Returns:
            ID da classificação inserida
        """
        # Marca registros anteriores como substituídos
        await self._marcar_substituido(resultado.id_prod, resultado.id_filial)

        # Prepara dados
        data_validade = date.today() + timedelta(days=dias_validade)

        query = """
            INSERT INTO ia_arqprodclas (
                IDProd, IDFilial, IDGrupo,
                Classif, ScoreGeral,
                CurvaABC, PercFatur, RankFatur,
                GiroMedio, DiasCobre, ScoreGiro, ClassGiro,
                MargMedia, MargMinima, MargMaxima, ScoreMargem, ClassMargem,
                CoefVariacao, DiasComVenda, DiasTotal, FreqVenda, ScoreRegular,
                Tendencia, VarTendencia,
                QtdVencida, VlrVencido, PercPerda, RiscoVenc, DiasParaVenc, ScoreVenc,
                EstqAtual, EstqValor, EstqExcesso,
                BloqCompra, BloqMotivo,
                AlertaJSON, RecomendJSON,
                DatCalculo, DatValidade, Status
            ) VALUES (
                :id_prod, :id_filial, :id_grupo,
                :classif, :score_geral,
                :curva_abc, :perc_fatur, :rank_fatur,
                :giro_medio, :dias_cobre, :score_giro, :class_giro,
                :marg_media, :marg_minima, :marg_maxima, :score_margem, :class_margem,
                :coef_variacao, :dias_com_venda, :dias_total, :freq_venda, :score_regular,
                :tendencia, :var_tendencia,
                :qtd_vencida, :vlr_vencido, :perc_perda, :risco_venc, :dias_para_venc, :score_venc,
                :estq_atual, :estq_valor, :estq_excesso,
                :bloq_compra, :bloq_motivo,
                :alerta_json, :recomend_json,
                :dat_calculo, :dat_validade, 'ATIVO'
            )
        """

        params = {
            'id_prod': resultado.id_prod,
            'id_filial': resultado.id_filial,
            'id_grupo': resultado.id_grupo,
            'classif': resultado.classificacao.value if hasattr(resultado.classificacao, 'value') else resultado.classificacao,
            'score_geral': resultado.score_geral,
            'curva_abc': resultado.curva_abc.value if hasattr(resultado.curva_abc, 'value') else resultado.curva_abc,
            'perc_fatur': resultado.perc_faturamento,
            'rank_fatur': resultado.rank_faturamento,
            'giro_medio': resultado.giro_medio,
            'dias_cobre': resultado.dias_cobertura,
            'score_giro': resultado.score_giro,
            'class_giro': resultado.classe_giro.value if hasattr(resultado.classe_giro, 'value') else resultado.classe_giro,
            'marg_media': resultado.margem_media,
            'marg_minima': resultado.margem_minima,
            'marg_maxima': resultado.margem_maxima,
            'score_margem': resultado.score_margem,
            'class_margem': resultado.classe_margem.value if hasattr(resultado.classe_margem, 'value') else resultado.classe_margem,
            'coef_variacao': resultado.coef_variacao,
            'dias_com_venda': resultado.dias_com_venda,
            'dias_total': resultado.dias_total,
            'freq_venda': resultado.freq_venda,
            'score_regular': resultado.score_regularidade,
            'tendencia': resultado.tendencia,
            'var_tendencia': resultado.var_tendencia,
            'qtd_vencida': resultado.qtd_vencida,
            'vlr_vencido': resultado.vlr_vencido,
            'perc_perda': resultado.perc_perda,
            'risco_venc': resultado.risco_vencimento.value if hasattr(resultado.risco_vencimento, 'value') else resultado.risco_vencimento,
            'dias_para_venc': resultado.dias_para_venc,
            'score_venc': resultado.score_vencimento,
            'estq_atual': resultado.estoque_atual,
            'estq_valor': resultado.estoque_valor,
            'estq_excesso': resultado.estoque_excesso,
            'bloq_compra': 1 if resultado.bloquear_compra else 0,
            'bloq_motivo': resultado.motivo_bloqueio,
            'alerta_json': json.dumps(resultado.alertas, ensure_ascii=False) if resultado.alertas else None,
            'recomend_json': json.dumps(resultado.recomendacoes, ensure_ascii=False) if resultado.recomendacoes else None,
            'dat_calculo': resultado.data_calculo or datetime.now(),
            'dat_validade': data_validade
        }

        result = await self.db.execute(query, params)

        logger.debug(f"Classificação salva: produto {resultado.id_prod}, filial {resultado.id_filial}")

        return result.lastrowid if hasattr(result, 'lastrowid') else 0

    async def salvar_lote(
        self,
        resultados: List[ResultadoClassificacao],
        dias_validade: int = 7
    ) -> int:
        """
        Salva múltiplas classificações em lote.

        Args:
            resultados: Lista de resultados
            dias_validade: Dias de validade

        Returns:
            Quantidade de registros salvos
        """
        if not resultados:
            return 0

        count = 0
        for resultado in resultados:
            try:
                await self.salvar(resultado, dias_validade)
                count += 1
            except Exception as e:
                logger.error(f"Erro ao salvar classificação do produto {resultado.id_prod}: {e}")

        logger.info(f"Lote salvo: {count}/{len(resultados)} classificações")

        return count

    async def buscar(
        self,
        id_prod: int,
        id_filial: int
    ) -> Optional[Dict[str, Any]]:
        """
        Busca classificação ativa de um produto.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial

        Returns:
            Dicionário com a classificação ou None
        """
        query = """
            SELECT *
            FROM ia_arqprodclas
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
              AND DatValidade >= CURDATE()
            ORDER BY DatCalculo DESC
            LIMIT 1
        """

        result = await self.db.execute(
            query,
            {'id_prod': id_prod, 'id_filial': id_filial}
        )

        if result:
            return self._converter_resultado(result[0])

        return None

    async def buscar_por_filial(
        self,
        id_filial: int,
        classificacao: Optional[str] = None,
        curva: Optional[str] = None,
        bloqueados: Optional[bool] = None,
        limite: int = 1000
    ) -> List[Dict[str, Any]]:
        """
        Busca classificações de uma filial com filtros.

        Args:
            id_filial: ID da filial
            classificacao: Filtro por classificação (SAUDAVEL/ATENCAO/TOXICO)
            curva: Filtro por curva ABC (A/B/C/D)
            bloqueados: Filtro por bloqueio de compra
            limite: Limite de registros

        Returns:
            Lista de classificações
        """
        query = """
            SELECT c.*, p.Despro as produto
            FROM ia_arqprodclas c
            JOIN arqproduto p ON c.IDProd = p.IDProd
            WHERE c.IDFilial = :id_filial
              AND c.Status = 'ATIVO'
              AND c.DatValidade >= CURDATE()
        """

        params = {'id_filial': id_filial}

        if classificacao:
            query += " AND c.Classif = :classif"
            params['classif'] = classificacao

        if curva:
            query += " AND c.CurvaABC = :curva"
            params['curva'] = curva

        if bloqueados is not None:
            query += " AND c.BloqCompra = :bloq"
            params['bloq'] = 1 if bloqueados else 0

        query += f" ORDER BY c.ScoreGeral DESC LIMIT {limite}"

        result = await self.db.execute(query, params)

        return [self._converter_resultado(r) for r in result] if result else []

    async def buscar_toxicos(
        self,
        id_filial: int,
        limite: int = 100
    ) -> List[Dict[str, Any]]:
        """
        Busca produtos tóxicos de uma filial.

        Args:
            id_filial: ID da filial
            limite: Limite de registros

        Returns:
            Lista de produtos tóxicos ordenados por score
        """
        return await self.buscar_por_filial(
            id_filial=id_filial,
            classificacao='TOXICO',
            limite=limite
        )

    async def buscar_bloqueados(
        self,
        id_filial: int,
        limite: int = 100
    ) -> List[Dict[str, Any]]:
        """
        Busca produtos com compra bloqueada.

        Args:
            id_filial: ID da filial
            limite: Limite de registros

        Returns:
            Lista de produtos bloqueados
        """
        return await self.buscar_por_filial(
            id_filial=id_filial,
            bloqueados=True,
            limite=limite
        )

    async def obter_resumo(self, id_filial: int) -> Dict[str, Any]:
        """
        Obtém resumo das classificações de uma filial.

        Args:
            id_filial: ID da filial

        Returns:
            Dicionário com estatísticas
        """
        query = """
            SELECT
                Classif as classificacao,
                CurvaABC as curva,
                COUNT(*) as quantidade,
                SUM(EstqValor) as valor_estoque,
                SUM(CASE WHEN BloqCompra = 1 THEN 1 ELSE 0 END) as bloqueados
            FROM ia_arqprodclas
            WHERE IDFilial = :id_filial
              AND Status = 'ATIVO'
              AND DatValidade >= CURDATE()
            GROUP BY Classif, CurvaABC
        """

        result = await self.db.execute(query, {'id_filial': id_filial})

        resumo = {
            'total': 0,
            'por_classificacao': {
                'SAUDAVEL': 0,
                'ATENCAO': 0,
                'TOXICO': 0
            },
            'por_curva': {
                'A': 0,
                'B': 0,
                'C': 0,
                'D': 0
            },
            'valor_estoque': {
                'total': 0,
                'saudavel': 0,
                'atencao': 0,
                'toxico': 0
            },
            'bloqueados': 0
        }

        if result:
            for r in result:
                qtd = int(r['quantidade'])
                valor = float(r['valor_estoque'] or 0)
                classif = r['classificacao']
                curva = r['curva']

                resumo['total'] += qtd
                resumo['por_classificacao'][classif] = resumo['por_classificacao'].get(classif, 0) + qtd
                resumo['por_curva'][curva] = resumo['por_curva'].get(curva, 0) + qtd
                resumo['valor_estoque']['total'] += valor
                resumo['valor_estoque'][classif.lower()] = resumo['valor_estoque'].get(classif.lower(), 0) + valor
                resumo['bloqueados'] += int(r['bloqueados'])

        return resumo

    async def expirar_antigos(self, id_filial: Optional[int] = None) -> int:
        """
        Marca classificações expiradas.

        Args:
            id_filial: ID da filial (None = todas)

        Returns:
            Quantidade de registros atualizados
        """
        query = """
            UPDATE ia_arqprodclas
            SET Status = 'EXPIRADO'
            WHERE Status = 'ATIVO'
              AND DatValidade < CURDATE()
        """

        params = {}
        if id_filial:
            query += " AND IDFilial = :id_filial"
            params['id_filial'] = id_filial

        result = await self.db.execute(query, params)

        count = result.rowcount if hasattr(result, 'rowcount') else 0
        if count > 0:
            logger.info(f"Expiradas {count} classificações")

        return count

    async def _marcar_substituido(self, id_prod: int, id_filial: int) -> None:
        """
        Marca classificações anteriores como substituídas.

        Args:
            id_prod: ID do produto
            id_filial: ID da filial
        """
        query = """
            UPDATE ia_arqprodclas
            SET Status = 'SUBSTITUIDO'
            WHERE IDProd = :id_prod
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
        """

        await self.db.execute(
            query,
            {'id_prod': id_prod, 'id_filial': id_filial}
        )

    def _converter_resultado(self, row: dict) -> Dict[str, Any]:
        """
        Converte resultado do banco para dicionário.

        Args:
            row: Linha do banco

        Returns:
            Dicionário formatado
        """
        resultado = dict(row)

        # Converte JSON
        if resultado.get('AlertaJSON'):
            try:
                resultado['alertas'] = json.loads(resultado['AlertaJSON'])
            except:
                resultado['alertas'] = []
        else:
            resultado['alertas'] = []

        if resultado.get('RecomendJSON'):
            try:
                resultado['recomendacoes'] = json.loads(resultado['RecomendJSON'])
            except:
                resultado['recomendacoes'] = []
        else:
            resultado['recomendacoes'] = []

        # Remove campos JSON originais
        resultado.pop('AlertaJSON', None)
        resultado.pop('RecomendJSON', None)

        return resultado
