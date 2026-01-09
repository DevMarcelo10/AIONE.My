"""
AIONE IA - Repositório de Integração
Sistema de persistência de pedidos e cotações
"""

from datetime import datetime, date, timedelta
from typing import List, Dict, Optional
import json

from core.database import DatabaseManager
from core.utils.logger import get_logger


class IntegracaoRepositorio:
    """Repositório para persistência de pedidos e cotações"""

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    # =========================================================================
    # PEDIDOS (ia_arqpedido)
    # =========================================================================

    def salvar_pedido(self, pedido) -> int:
        """Salva um pedido de compra"""

        sql = """
            INSERT INTO ia_arqpedido (
                IDFilial, IDNecPed, CNPJForn, NomeForn,
                QtdItens, VlrBruto, VlrDesconto, VlrTotal,
                CondPgto, PrazoPgto, DatEntrega, ObsPedido,
                Origem, IDCotacao,
                Status, DatGeracao, UserGeracao
            ) VALUES (
                :id_filial, :id_nec_ped, :cnpj, :nome,
                :qtd_itens, :vlr_bruto, :vlr_desconto, :vlr_total,
                :cond_pgto, :prazo_pgto, :dat_entrega, :obs,
                :origem, :id_cotacao,
                :status, NOW(), :usuario
            )
        """

        params = {
            'id_filial': pedido.id_filial,
            'id_nec_ped': pedido.id_nec_ped,
            'cnpj': pedido.cnpj_forn,
            'nome': pedido.nome_forn,
            'qtd_itens': pedido.qtd_itens,
            'vlr_bruto': pedido.vlr_bruto,
            'vlr_desconto': pedido.vlr_desconto,
            'vlr_total': pedido.vlr_total,
            'cond_pgto': pedido.cond_pgto,
            'prazo_pgto': pedido.prazo_pgto,
            'dat_entrega': pedido.dat_entrega,
            'obs': pedido.obs_pedido,
            'origem': pedido.origem.value,
            'id_cotacao': pedido.id_cotacao,
            'status': pedido.status.value,
            'usuario': pedido.user_geracao
        }

        id_pedido = self.db.execute_insert(sql, params)

        # Salva itens
        for item in pedido.itens:
            self._salvar_item_pedido(id_pedido, item)

        self.logger.debug(f"Pedido salvo: ID={id_pedido}")

        return id_pedido

    def _salvar_item_pedido(self, id_pedido: int, item):
        """Salva item do pedido"""

        sql = """
            INSERT INTO ia_arqpedidoite (
                IDPedidoIA, IDNecessi, IDProd,
                CodProd, DesProd, CodEAN,
                QtdSolicit, VlrUnitario, VlrDesconto, VlrTotal,
                VlrRefHistorico, VarPreco,
                Status, ObsItem
            ) VALUES (
                :id_pedido, :id_necessi, :id_prod,
                :cod_prod, :des_prod, :cod_ean,
                :qtd, :vlr_unit, :vlr_desc, :vlr_total,
                :vlr_ref, :var_preco,
                :status, :obs
            )
        """

        params = {
            'id_pedido': id_pedido,
            'id_necessi': item.id_necessi,
            'id_prod': item.id_prod,
            'cod_prod': item.cod_prod,
            'des_prod': item.des_prod,
            'cod_ean': item.cod_ean,
            'qtd': item.qtd_solicitada,
            'vlr_unit': item.vlr_unitario,
            'vlr_desc': item.vlr_desconto,
            'vlr_total': item.vlr_total,
            'vlr_ref': item.vlr_ref_historico,
            'var_preco': item.var_preco,
            'status': item.status,
            'obs': item.obs_item
        }

        self.db.execute_insert(sql, params)

    def listar_pedidos(self, id_filial: int,
                       status: str = None,
                       origem: str = None,
                       limite: int = 50) -> List[Dict]:
        """Lista pedidos com filtros"""

        conditions = ["IDFilial = :id_filial"]
        params = {'id_filial': id_filial, 'limite': limite}

        if status:
            conditions.append("Status = :status")
            params['status'] = status

        if origem:
            conditions.append("Origem = :origem")
            params['origem'] = origem

        sql = f"""
            SELECT * FROM ia_arqpedido
            WHERE {' AND '.join(conditions)}
            ORDER BY DatGeracao DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, params)

    def obter_pedido_com_itens(self, id_pedido: int) -> Dict:
        """Obtém pedido com seus itens"""

        sql_ped = "SELECT * FROM ia_arqpedido WHERE IDPedidoIA = :id"
        pedido = self.db.execute_query(sql_ped, {'id': id_pedido})

        if not pedido:
            return None

        sql_itens = """
            SELECT * FROM ia_arqpedidoite
            WHERE IDPedidoIA = :id
            ORDER BY IDPedidoIte
        """
        itens = self.db.execute_query(sql_itens, {'id': id_pedido})

        result = dict(pedido[0])
        result['itens'] = itens

        return result

    def atualizar_status_pedido(self, id_pedido: int, status: str,
                                 usuario: str = None) -> bool:
        """Atualiza status do pedido"""

        campos = ["Status = :status"]
        params = {'id': id_pedido, 'status': status}

        if status == 'APROVADO':
            campos.append("DatAprovacao = NOW()")
            campos.append("UserAprovacao = :usuario")
            params['usuario'] = usuario
        elif status == 'ENVIADO':
            campos.append("DatEnvio = NOW()")

        sql = f"UPDATE ia_arqpedido SET {', '.join(campos)} WHERE IDPedidoIA = :id"
        self.db.execute_query(sql, params)

        return True

    # =========================================================================
    # COTAÇÕES (ia_arqcotacao)
    # =========================================================================

    def salvar_cotacao(self, cotacao, usuario: str) -> int:
        """Salva uma cotação"""

        sql = """
            INSERT INTO ia_arqcotacao (
                IDFilial, CodCotacao,
                DatAbertura, DatEncerramento,
                QtdItens, QtdFornecedores, VlrEstimado,
                TipoCotacao, PermiteParc, AutoSelecao, CriterioSel,
                Status, UserCriacao
            ) VALUES (
                :id_filial, :cod,
                :dat_abertura, :dat_encerramento,
                :qtd_itens, :qtd_forn, :vlr_estimado,
                'FECHADA', :permite_parc, :auto_sel, :criterio,
                :status, :usuario
            )
        """

        params = {
            'id_filial': cotacao.id_filial,
            'cod': cotacao.cod_cotacao,
            'dat_abertura': cotacao.dat_abertura,
            'dat_encerramento': cotacao.dat_encerramento,
            'qtd_itens': len(cotacao.itens),
            'qtd_forn': len(cotacao.fornecedores),
            'vlr_estimado': cotacao.vlr_estimado,
            'permite_parc': 1 if cotacao.permite_parcial else 0,
            'auto_sel': 1 if cotacao.auto_selecao else 0,
            'criterio': cotacao.criterio_selecao.value,
            'status': cotacao.status.value,
            'usuario': usuario
        }

        id_cotacao = self.db.execute_insert(sql, params)

        # Salva itens
        for item in cotacao.itens:
            self._salvar_item_cotacao(id_cotacao, item)

        # Salva fornecedores
        for forn in cotacao.fornecedores:
            self._salvar_fornecedor_cotacao(id_cotacao, forn)

        self.logger.debug(f"Cotação salva: ID={id_cotacao}")

        return id_cotacao

    def _salvar_item_cotacao(self, id_cotacao: int, item):
        """Salva item da cotação"""

        sql = """
            INSERT INTO ia_arqcotacaoite (
                IDCotacao, IDNecessi, IDProd,
                CodProd, DesProd, CodEAN,
                QtdSolicit, VlrRefHistorico
            ) VALUES (
                :id_cotacao, :id_necessi, :id_prod,
                :cod_prod, :des_prod, :cod_ean,
                :qtd, :vlr_ref
            )
        """

        params = {
            'id_cotacao': id_cotacao,
            'id_necessi': item.id_necessi,
            'id_prod': item.id_prod,
            'cod_prod': item.cod_prod,
            'des_prod': item.des_prod,
            'cod_ean': item.cod_ean,
            'qtd': item.qtd_solicitada,
            'vlr_ref': item.vlr_ref_historico
        }

        self.db.execute_insert(sql, params)

    def _salvar_fornecedor_cotacao(self, id_cotacao: int, forn: Dict):
        """Salva fornecedor convidado para cotação"""

        sql = """
            INSERT INTO ia_arqcotacaoforn (
                IDCotacao, CNPJForn, NomeForn, EmailForn, TelForn,
                Status
            ) VALUES (
                :id_cotacao, :cnpj, :nome, :email, :tel,
                'PENDENTE'
            )
        """

        params = {
            'id_cotacao': id_cotacao,
            'cnpj': forn.get('cnpj'),
            'nome': forn.get('nome'),
            'email': forn.get('email'),
            'tel': forn.get('telefone')
        }

        self.db.execute_insert(sql, params)

    def listar_cotacoes(self, id_filial: int,
                        status: str = None,
                        limite: int = 50) -> List[Dict]:
        """Lista cotações com filtros"""

        conditions = ["IDFilial = :id_filial"]
        params = {'id_filial': id_filial, 'limite': limite}

        if status:
            conditions.append("Status = :status")
            params['status'] = status

        sql = f"""
            SELECT * FROM ia_arqcotacao
            WHERE {' AND '.join(conditions)}
            ORDER BY DatAbertura DESC
            LIMIT :limite
        """

        return self.db.execute_query(sql, params)

    def obter_cotacao_completa(self, id_cotacao: int) -> Dict:
        """Obtém cotação com itens, fornecedores e respostas"""

        sql_cot = "SELECT * FROM ia_arqcotacao WHERE IDCotacao = :id"
        cotacao = self.db.execute_query(sql_cot, {'id': id_cotacao})

        if not cotacao:
            return None

        result = dict(cotacao[0])

        # Itens
        sql_itens = "SELECT * FROM ia_arqcotacaoite WHERE IDCotacao = :id"
        result['itens'] = self.db.execute_query(sql_itens, {'id': id_cotacao})

        # Fornecedores
        sql_forn = "SELECT * FROM ia_arqcotacaoforn WHERE IDCotacao = :id"
        result['fornecedores'] = self.db.execute_query(sql_forn, {'id': id_cotacao})

        # Respostas
        sql_resp = """
            SELECT r.*, p.Despro as nome_produto
            FROM ia_arqcotaresp r
            INNER JOIN arqproduto p ON p.IDProd = r.IDProd
            WHERE r.IDCotacao = :id
            ORDER BY r.CNPJForn, r.IDProd
        """
        result['respostas'] = self.db.execute_query(sql_resp, {'id': id_cotacao})

        return result

    # =========================================================================
    # RESUMOS
    # =========================================================================

    def resumo_pedidos_filial(self, id_filial: int) -> Dict:
        """Resumo dos pedidos da filial"""

        sql = """
            SELECT
                COUNT(*) as total,
                SUM(CASE WHEN Status = 'RASCUNHO' THEN 1 ELSE 0 END) as rascunho,
                SUM(CASE WHEN Status = 'APROVADO' THEN 1 ELSE 0 END) as aprovados,
                SUM(CASE WHEN Status = 'ENVIADO' THEN 1 ELSE 0 END) as enviados,
                SUM(CASE WHEN Status = 'CONFIRMADO' THEN 1 ELSE 0 END) as confirmados,
                SUM(CASE WHEN Status = 'RECEBIDO' THEN 1 ELSE 0 END) as recebidos,
                SUM(CASE WHEN SincronizadoERP = 0 AND Status != 'CANCELADO' THEN 1 ELSE 0 END) as pendentes_erp,
                SUM(VlrTotal) as vlr_total
            FROM ia_arqpedido
            WHERE IDFilial = :id_filial
              AND DatGeracao >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        """

        result = self.db.execute_query(sql, {'id_filial': id_filial})

        if result:
            r = result[0]
            return {
                'total': r['total'] or 0,
                'por_status': {
                    'RASCUNHO': r['rascunho'] or 0,
                    'APROVADO': r['aprovados'] or 0,
                    'ENVIADO': r['enviados'] or 0,
                    'CONFIRMADO': r['confirmados'] or 0,
                    'RECEBIDO': r['recebidos'] or 0
                },
                'pendentes_erp': r['pendentes_erp'] or 0,
                'vlr_total': float(r['vlr_total'] or 0)
            }

        return {
            'total': 0,
            'por_status': {},
            'pendentes_erp': 0,
            'vlr_total': 0
        }

    def resumo_cotacoes_filial(self, id_filial: int) -> Dict:
        """Resumo das cotações da filial"""

        sql = """
            SELECT
                COUNT(*) as total,
                SUM(CASE WHEN Status = 'ABERTA' THEN 1 ELSE 0 END) as abertas,
                SUM(CASE WHEN Status = 'ENCERRADA' THEN 1 ELSE 0 END) as encerradas,
                SUM(CASE WHEN Status = 'FINALIZADA' THEN 1 ELSE 0 END) as finalizadas,
                AVG(QtdRespostas) as media_respostas
            FROM ia_arqcotacao
            WHERE IDFilial = :id_filial
              AND DatAbertura >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        """

        result = self.db.execute_query(sql, {'id_filial': id_filial})

        if result:
            r = result[0]
            return {
                'total': r['total'] or 0,
                'abertas': r['abertas'] or 0,
                'encerradas': r['encerradas'] or 0,
                'finalizadas': r['finalizadas'] or 0,
                'media_respostas': float(r['media_respostas'] or 0)
            }

        return {'total': 0, 'abertas': 0, 'encerradas': 0, 'finalizadas': 0, 'media_respostas': 0}
