"""
AIONE IA - Gerador de Pedido para ERP
Sistema de conversão de pedidos IA para formato ERP
"""

from datetime import datetime, date
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils.logger import get_logger


class GeradorPedido:
    """
    Gerador de pedidos no formato do ERP.

    Converte pedidos da IA (ia_arqpedido) para o formato
    do ERP (arqcompraped/arqcomprapedite).
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def gerar_pedido_erp(self, id_pedido_ia: int,
                          usuario: str = "SISTEMA") -> int:
        """
        Gera pedido no ERP a partir do pedido IA.

        Args:
            id_pedido_ia: ID do pedido na tabela ia_arqpedido
            usuario: Usuário que está gerando

        Returns: ID do pedido gerado no ERP (arqcompraped)
        """

        self.logger.info(f"Gerando pedido ERP a partir do pedido IA {id_pedido_ia}")

        # Busca pedido IA
        pedido_ia = self._buscar_pedido_ia(id_pedido_ia)

        if not pedido_ia:
            raise ValueError(f"Pedido IA {id_pedido_ia} não encontrado")

        if pedido_ia['Status'] not in ('APROVADO', 'ENVIADO'):
            raise ValueError("Pedido deve estar APROVADO ou ENVIADO")

        if pedido_ia['SincronizadoERP']:
            raise ValueError("Pedido já sincronizado com ERP")

        # Busca itens
        itens = self._buscar_itens_pedido_ia(id_pedido_ia)

        if not itens:
            raise ValueError("Pedido sem itens")

        # Gera código do pedido
        cod_pedido = self._gerar_codigo_pedido(pedido_ia['IDFilial'])

        # Insere cabeçalho do pedido no ERP
        id_pedido_erp = self._inserir_pedido_erp(pedido_ia, cod_pedido, usuario)

        # Insere itens
        for item in itens:
            self._inserir_item_pedido_erp(id_pedido_erp, item)

        # Atualiza pedido IA com referência ao ERP
        self._atualizar_pedido_ia_sincronizado(id_pedido_ia, id_pedido_erp)

        self.logger.info(f"Pedido ERP gerado: ID={id_pedido_erp}, Código={cod_pedido}")

        return id_pedido_erp

    def _buscar_pedido_ia(self, id_pedido_ia: int) -> Dict:
        """Busca dados do pedido IA"""

        sql = "SELECT * FROM ia_arqpedido WHERE IDPedidoIA = :id"
        result = self.db.execute_query(sql, {'id': id_pedido_ia})
        return result[0] if result else None

    def _buscar_itens_pedido_ia(self, id_pedido_ia: int) -> List[Dict]:
        """Busca itens do pedido IA"""

        sql = """
            SELECT i.*, p.CodPro, p.Despro, p.CodEAN, p.IDUnidade
            FROM ia_arqpedidoite i
            INNER JOIN arqproduto p ON p.IDProd = i.IDProd
            WHERE i.IDPedidoIA = :id
            ORDER BY i.IDPedidoIte
        """
        return self.db.execute_query(sql, {'id': id_pedido_ia})

    def _gerar_codigo_pedido(self, id_filial: int) -> str:
        """Gera código sequencial do pedido"""

        sql = """
            SELECT COALESCE(MAX(CAST(SUBSTRING(CodPed, 4) AS UNSIGNED)), 0) + 1 as proximo
            FROM arqcompraped
            WHERE IDFilial = :id_filial
              AND CodPed LIKE 'PED%'
        """
        result = self.db.execute_query(sql, {'id_filial': id_filial})
        proximo = result[0]['proximo'] if result else 1

        return f"PED{proximo:08d}"

    def _inserir_pedido_erp(self, pedido_ia: Dict, cod_pedido: str, usuario: str) -> int:
        """Insere cabeçalho do pedido no ERP"""

        sql = """
            INSERT INTO arqcompraped (
                IDFilial, CodPed,
                CNPJCPFFor, NomFor,
                DatPed, DatPrevi,
                VlrTotal, CondPgto,
                ObsPed, SitPed,
                UserCad, DatCad
            ) VALUES (
                :id_filial, :cod_ped,
                :cnpj, :nome,
                CURDATE(), :dat_entrega,
                :vlr_total, :cond_pgto,
                :obs, '0',
                :usuario, NOW()
            )
        """

        params = {
            'id_filial': pedido_ia['IDFilial'],
            'cod_ped': cod_pedido,
            'cnpj': pedido_ia['CNPJForn'],
            'nome': pedido_ia['NomeForn'],
            'dat_entrega': pedido_ia.get('DatEntrega') or date.today(),
            'vlr_total': pedido_ia['VlrTotal'],
            'cond_pgto': pedido_ia.get('CondPgto', ''),
            'obs': f"Gerado automaticamente pela IA. Ref: {pedido_ia['IDPedidoIA']}",
            'usuario': usuario
        }

        return self.db.execute_insert(sql, params)

    def _inserir_item_pedido_erp(self, id_pedido_erp: int, item: Dict):
        """Insere item do pedido no ERP"""

        sql = """
            INSERT INTO arqcomprapedite (
                IDPed, IDProd, CodPro,
                QtdPed, VlrUnit, VlrTotal,
                IDUnidade
            ) VALUES (
                :id_ped, :id_prod, :cod_prod,
                :qtd, :vlr_unit, :vlr_total,
                :id_unidade
            )
        """

        params = {
            'id_ped': id_pedido_erp,
            'id_prod': item['IDProd'],
            'cod_prod': item.get('CodPro', ''),
            'qtd': item['QtdSolicit'],
            'vlr_unit': item['VlrUnitario'],
            'vlr_total': item['VlrTotal'],
            'id_unidade': item.get('IDUnidade', 1)
        }

        self.db.execute_insert(sql, params)

    def _atualizar_pedido_ia_sincronizado(self, id_pedido_ia: int, id_pedido_erp: int):
        """Atualiza pedido IA como sincronizado"""

        sql = """
            UPDATE ia_arqpedido
            SET IDPedidoERP = :id_erp,
                SincronizadoERP = 1,
                DatSincroniz = NOW()
            WHERE IDPedidoIA = :id_ia
        """
        self.db.execute_query(sql, {'id_erp': id_pedido_erp, 'id_ia': id_pedido_ia})

    def sincronizar_status_erp(self, id_pedido_ia: int) -> Dict:
        """
        Sincroniza status do pedido com o ERP.
        Busca status atual no ERP e atualiza na tabela IA.
        """

        pedido_ia = self._buscar_pedido_ia(id_pedido_ia)

        if not pedido_ia or not pedido_ia.get('IDPedidoERP'):
            return {'sincronizado': False, 'motivo': 'Pedido não vinculado ao ERP'}

        # Busca status no ERP
        sql = """
            SELECT SitPed, DatRece
            FROM arqcompraped
            WHERE IDPed = :id_erp
        """
        result = self.db.execute_query(sql, {'id_erp': pedido_ia['IDPedidoERP']})

        if not result:
            return {'sincronizado': False, 'motivo': 'Pedido não encontrado no ERP'}

        status_erp = result[0]['SitPed']

        # Mapeia status do ERP para status IA
        mapa_status = {
            '0': 'RASCUNHO',      # Aberto
            '1': 'ENVIADO',       # Enviado
            '2': 'CONFIRMADO',    # Confirmado
            '3': 'RECEBIDO',      # Recebido
            '9': 'CANCELADO'      # Cancelado
        }

        novo_status = mapa_status.get(status_erp, 'ENVIADO')

        # Atualiza status na IA
        sql_update = """
            UPDATE ia_arqpedido
            SET Status = :status
            WHERE IDPedidoIA = :id
        """
        self.db.execute_query(sql_update, {'status': novo_status, 'id': id_pedido_ia})

        return {
            'sincronizado': True,
            'status_erp': status_erp,
            'status_ia': novo_status
        }
