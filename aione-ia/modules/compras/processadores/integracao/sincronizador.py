"""
AIONE IA - Sincronizador com ERP
Sistema de sincronização de pedidos entre IA e ERP
"""

from datetime import datetime
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils.logger import get_logger
from .gerador_pedido import GeradorPedido


class SincronizadorERP:
    """
    Sincronizador de pedidos entre IA e ERP.

    Funções:
    - Exportar pedidos aprovados para o ERP
    - Importar status do ERP para a IA
    - Sincronizar recebimentos
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)
        self.gerador = GeradorPedido(db)

    def sincronizar_pedidos_pendentes(self, id_filial: int) -> Dict:
        """
        Sincroniza todos os pedidos pendentes de uma filial.

        Returns: {
            'exportados': int,
            'atualizados': int,
            'erros': int,
            'detalhes': List
        }
        """

        self.logger.info(f"Sincronizando pedidos da filial {id_filial}")

        resultado = {
            'exportados': 0,
            'atualizados': 0,
            'erros': 0,
            'detalhes': []
        }

        # 1. Exporta pedidos aprovados para o ERP
        exportados = self._exportar_para_erp(id_filial)
        resultado['exportados'] = exportados['sucesso']
        resultado['erros'] += exportados['erros']
        resultado['detalhes'].extend(exportados['detalhes'])

        # 2. Atualiza status dos pedidos já no ERP
        atualizados = self._atualizar_status_do_erp(id_filial)
        resultado['atualizados'] = atualizados['sucesso']
        resultado['erros'] += atualizados['erros']
        resultado['detalhes'].extend(atualizados['detalhes'])

        self.logger.info(f"Sincronização concluída: {resultado['exportados']} exportados, {resultado['atualizados']} atualizados, {resultado['erros']} erros")

        return resultado

    def _exportar_para_erp(self, id_filial: int) -> Dict:
        """Exporta pedidos aprovados que ainda não estão no ERP"""

        sql = """
            SELECT IDPedidoIA
            FROM ia_arqpedido
            WHERE IDFilial = :id_filial
              AND Status IN ('APROVADO', 'ENVIADO')
              AND SincronizadoERP = 0
        """

        pedidos = self.db.execute_query(sql, {'id_filial': id_filial})

        resultado = {'sucesso': 0, 'erros': 0, 'detalhes': []}

        for ped in pedidos:
            id_pedido = ped['IDPedidoIA']
            try:
                id_erp = self.gerador.gerar_pedido_erp(id_pedido)
                resultado['sucesso'] += 1
                resultado['detalhes'].append({
                    'id_pedido_ia': id_pedido,
                    'id_pedido_erp': id_erp,
                    'status': 'exportado'
                })
            except Exception as e:
                resultado['erros'] += 1
                resultado['detalhes'].append({
                    'id_pedido_ia': id_pedido,
                    'erro': str(e),
                    'status': 'erro'
                })

                # Registra erro no pedido
                self._registrar_erro_sincronizacao(id_pedido, str(e))

        return resultado

    def _atualizar_status_do_erp(self, id_filial: int) -> Dict:
        """Atualiza status dos pedidos a partir do ERP"""

        sql = """
            SELECT IDPedidoIA, IDPedidoERP
            FROM ia_arqpedido
            WHERE IDFilial = :id_filial
              AND SincronizadoERP = 1
              AND Status NOT IN ('RECEBIDO', 'CANCELADO')
        """

        pedidos = self.db.execute_query(sql, {'id_filial': id_filial})

        resultado = {'sucesso': 0, 'erros': 0, 'detalhes': []}

        for ped in pedidos:
            id_pedido = ped['IDPedidoIA']
            try:
                sync = self.gerador.sincronizar_status_erp(id_pedido)
                if sync['sincronizado']:
                    resultado['sucesso'] += 1
                    resultado['detalhes'].append({
                        'id_pedido_ia': id_pedido,
                        'status_anterior': ped.get('Status'),
                        'status_novo': sync['status_ia'],
                        'status': 'atualizado'
                    })
            except Exception as e:
                resultado['erros'] += 1
                resultado['detalhes'].append({
                    'id_pedido_ia': id_pedido,
                    'erro': str(e),
                    'status': 'erro'
                })

        return resultado

    def _registrar_erro_sincronizacao(self, id_pedido: int, erro: str):
        """Registra erro de sincronização no pedido"""

        sql = """
            UPDATE ia_arqpedido
            SET ErroSincroniz = :erro
            WHERE IDPedidoIA = :id
        """
        self.db.execute_query(sql, {'id': id_pedido, 'erro': erro})

    def importar_recebimento(self, id_pedido_erp: int) -> Dict:
        """
        Importa dados de recebimento do ERP.
        Atualiza quantidades recebidas nos itens do pedido IA.
        """

        self.logger.info(f"Importando recebimento do pedido ERP {id_pedido_erp}")

        # Busca pedido IA vinculado
        sql_ped = """
            SELECT IDPedidoIA FROM ia_arqpedido
            WHERE IDPedidoERP = :id_erp
        """
        result = self.db.execute_query(sql_ped, {'id_erp': id_pedido_erp})

        if not result:
            return {'sucesso': False, 'motivo': 'Pedido não encontrado na IA'}

        id_pedido_ia = result[0]['IDPedidoIA']

        # Busca recebimentos no ERP
        sql_rec = """
            SELECT
                ri.IDProd,
                SUM(ri.Qtdrec) as qtd_recebida
            FROM arqcomprarecite ri
            INNER JOIN arqcomprarec r ON r.IDRec = ri.IDRec
            WHERE r.IDPed = :id_erp
              AND r.TipEnt = '0'
            GROUP BY ri.IDProd
        """
        recebimentos = self.db.execute_query(sql_rec, {'id_erp': id_pedido_erp})

        # Atualiza itens do pedido IA
        for rec in recebimentos:
            sql_update = """
                UPDATE ia_arqpedidoite
                SET QtdRecebida = :qtd,
                    Status = CASE
                        WHEN :qtd >= QtdSolicit THEN 'RECEBIDO'
                        WHEN :qtd > 0 THEN 'PARCIAL'
                        ELSE Status
                    END
                WHERE IDPedidoIA = :id_ped
                  AND IDProd = :id_prod
            """
            self.db.execute_query(sql_update, {
                'qtd': rec['qtd_recebida'],
                'id_ped': id_pedido_ia,
                'id_prod': rec['IDProd']
            })

        # Verifica se pedido está totalmente recebido
        sql_check = """
            SELECT
                SUM(CASE WHEN Status = 'RECEBIDO' THEN 1 ELSE 0 END) as recebidos,
                COUNT(*) as total
            FROM ia_arqpedidoite
            WHERE IDPedidoIA = :id_ped
        """
        check = self.db.execute_query(sql_check, {'id_ped': id_pedido_ia})

        if check and check[0]['recebidos'] == check[0]['total']:
            # Marca pedido como recebido
            sql_ped_status = """
                UPDATE ia_arqpedido
                SET Status = 'RECEBIDO'
                WHERE IDPedidoIA = :id_ped
            """
            self.db.execute_query(sql_ped_status, {'id_ped': id_pedido_ia})

        return {
            'sucesso': True,
            'id_pedido_ia': id_pedido_ia,
            'itens_atualizados': len(recebimentos)
        }

    def relatorio_sincronizacao(self, id_filial: int, dias: int = 7) -> Dict:
        """
        Relatório de sincronização dos últimos X dias.
        """

        sql = """
            SELECT
                COUNT(*) as total,
                SUM(CASE WHEN SincronizadoERP = 1 THEN 1 ELSE 0 END) as sincronizados,
                SUM(CASE WHEN SincronizadoERP = 0 AND Status NOT IN ('RASCUNHO', 'CANCELADO') THEN 1 ELSE 0 END) as pendentes,
                SUM(CASE WHEN ErroSincroniz IS NOT NULL THEN 1 ELSE 0 END) as com_erro
            FROM ia_arqpedido
            WHERE IDFilial = :id_filial
              AND DatGeracao >= DATE_SUB(CURDATE(), INTERVAL :dias DAY)
        """

        result = self.db.execute_query(sql, {'id_filial': id_filial, 'dias': dias})

        if result:
            r = result[0]
            return {
                'periodo_dias': dias,
                'total_pedidos': r['total'] or 0,
                'sincronizados': r['sincronizados'] or 0,
                'pendentes': r['pendentes'] or 0,
                'com_erro': r['com_erro'] or 0,
                'taxa_sincronizacao': (
                    (r['sincronizados'] / r['total'] * 100)
                    if r['total'] > 0 else 0
                )
            }

        return {
            'periodo_dias': dias,
            'total_pedidos': 0,
            'sincronizados': 0,
            'pendentes': 0,
            'com_erro': 0,
            'taxa_sincronizacao': 0
        }
