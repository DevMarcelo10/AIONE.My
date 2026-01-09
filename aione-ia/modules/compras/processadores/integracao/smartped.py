"""
AIONE IA - SmartPed
Sistema de geração inteligente de pedidos de compra
"""

from dataclasses import dataclass, field
from datetime import datetime, date, timedelta
from typing import List, Dict, Optional, Any
from enum import Enum

from core.database import DatabaseManager
from core.utils.logger import get_logger


class StatusPedido(str, Enum):
    RASCUNHO = 'RASCUNHO'
    APROVADO = 'APROVADO'
    ENVIADO = 'ENVIADO'
    CONFIRMADO = 'CONFIRMADO'
    RECEBIDO = 'RECEBIDO'
    CANCELADO = 'CANCELADO'


class OrigemPedido(str, Enum):
    SMARTPED = 'SMARTPED'
    COTEFACIL = 'COTEFACIL'
    MANUAL = 'MANUAL'


@dataclass
class ItemPedido:
    """Item de um pedido de compra"""

    id_prod: int
    cod_prod: str = ""
    des_prod: str = ""
    cod_ean: str = ""

    qtd_solicitada: float = 0.0
    vlr_unitario: float = 0.0
    vlr_desconto: float = 0.0
    vlr_total: float = 0.0

    vlr_ref_historico: Optional[float] = None
    var_preco: Optional[float] = None

    id_necessi: Optional[int] = None
    obs_item: str = ""
    status: str = "PENDENTE"

    def calcular_total(self):
        """Calcula valor total do item"""
        self.vlr_total = round((self.vlr_unitario - self.vlr_desconto) * self.qtd_solicitada, 2)

        if self.vlr_ref_historico and self.vlr_ref_historico > 0:
            self.var_preco = round(
                ((self.vlr_unitario - self.vlr_ref_historico) / self.vlr_ref_historico) * 100, 2
            )


@dataclass
class PedidoCompra:
    """Pedido de compra gerado pela IA"""

    # Identificação
    id_pedido_ia: Optional[int] = None
    id_filial: int = 0
    id_nec_ped: Optional[int] = None

    # Fornecedor
    cnpj_forn: str = ""
    nome_forn: str = ""

    # Itens
    itens: List[ItemPedido] = field(default_factory=list)

    # Totais
    qtd_itens: int = 0
    vlr_bruto: float = 0.0
    vlr_desconto: float = 0.0
    vlr_total: float = 0.0

    # Condições
    cond_pgto: str = ""
    prazo_pgto: int = 0
    dat_entrega: Optional[date] = None
    obs_pedido: str = ""

    # Origem
    origem: OrigemPedido = OrigemPedido.SMARTPED
    id_cotacao: Optional[int] = None

    # Status
    status: StatusPedido = StatusPedido.RASCUNHO
    dat_geracao: datetime = None
    dat_aprovacao: Optional[datetime] = None
    dat_envio: Optional[datetime] = None
    user_geracao: str = ""
    user_aprovacao: str = ""

    # ERP
    id_pedido_erp: Optional[int] = None
    sincronizado_erp: bool = False

    def __post_init__(self):
        if self.dat_geracao is None:
            self.dat_geracao = datetime.now()
        if self.itens is None:
            self.itens = []

    def adicionar_item(self, item: ItemPedido):
        """Adiciona item e recalcula totais"""
        item.calcular_total()
        self.itens.append(item)
        self._recalcular_totais()

    def _recalcular_totais(self):
        """Recalcula totais do pedido"""
        self.qtd_itens = len(self.itens)
        self.vlr_bruto = sum(i.vlr_unitario * i.qtd_solicitada for i in self.itens)
        self.vlr_desconto = sum(i.vlr_desconto * i.qtd_solicitada for i in self.itens)
        self.vlr_total = sum(i.vlr_total for i in self.itens)

    def to_dict(self) -> Dict[str, Any]:
        """Converte para dicionário"""
        return {
            'id_pedido_ia': self.id_pedido_ia,
            'id_filial': self.id_filial,
            'cnpj_forn': self.cnpj_forn,
            'nome_forn': self.nome_forn,
            'qtd_itens': self.qtd_itens,
            'vlr_total': self.vlr_total,
            'cond_pgto': self.cond_pgto,
            'prazo_pgto': self.prazo_pgto,
            'origem': self.origem.value,
            'status': self.status.value,
            'sincronizado_erp': self.sincronizado_erp,
            'itens': [
                {
                    'id_prod': i.id_prod,
                    'des_prod': i.des_prod,
                    'qtd_solicitada': i.qtd_solicitada,
                    'vlr_unitario': i.vlr_unitario,
                    'vlr_total': i.vlr_total,
                    'var_preco': i.var_preco
                }
                for i in self.itens
            ]
        }


class SmartPed:
    """
    SmartPed - Gerador de Pedidos Inteligente.

    Converte necessidades aprovadas em pedidos de compra.
    Usa fornecedor sugerido e preço histórico.
    """

    def __init__(self, db: DatabaseManager):
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    def gerar_pedido_de_necessidade(self, id_nec_ped: int,
                                     usuario: str = "SISTEMA") -> PedidoCompra:
        """
        Gera pedido de compra a partir de um pedido sugerido (ia_arqnecped).

        Args:
            id_nec_ped: ID do pedido sugerido
            usuario: Usuário que está gerando

        Returns: PedidoCompra gerado
        """
        from .repositorio import IntegracaoRepositorio

        self.logger.info(f"Gerando pedido SmartPed para necessidade {id_nec_ped}")

        # Busca pedido sugerido
        pedido_sug = self._buscar_pedido_sugerido(id_nec_ped)

        if not pedido_sug:
            raise ValueError(f"Pedido sugerido {id_nec_ped} não encontrado")

        if pedido_sug['Status'] not in ('SUGERIDO', 'APROVADO'):
            raise ValueError(f"Pedido sugerido deve estar SUGERIDO ou APROVADO")

        # Busca itens do pedido (necessidades)
        itens = self._buscar_itens_necessidade(id_nec_ped)

        if not itens:
            raise ValueError(f"Nenhum item encontrado para o pedido {id_nec_ped}")

        # Busca condições do fornecedor
        condicoes = self._buscar_condicoes_fornecedor(
            pedido_sug['CNPJForn'],
            pedido_sug['IDFilial']
        )

        # Monta pedido
        pedido = PedidoCompra(
            id_filial=pedido_sug['IDFilial'],
            id_nec_ped=id_nec_ped,
            cnpj_forn=pedido_sug['CNPJForn'],
            nome_forn=pedido_sug['NomeForn'],
            origem=OrigemPedido.SMARTPED,
            cond_pgto=condicoes.get('cond_pgto', ''),
            prazo_pgto=condicoes.get('prazo_pgto', 30),
            dat_entrega=date.today() + timedelta(days=condicoes.get('lead_time', 7)),
            user_geracao=usuario,
            status=StatusPedido.RASCUNHO
        )

        # Adiciona itens
        for item_nec in itens:
            item = ItemPedido(
                id_prod=item_nec['IDProd'],
                cod_prod=item_nec.get('CodPro', ''),
                des_prod=item_nec.get('Despro', ''),
                cod_ean=item_nec.get('CodEAN', ''),
                qtd_solicitada=float(item_nec.get('QtdSugerida') or 0),
                vlr_unitario=float(item_nec.get('PrecoSuger') or 0),
                vlr_ref_historico=float(item_nec.get('PrecoSuger') or 0),
                id_necessi=item_nec.get('IDNecessi')
            )
            pedido.adicionar_item(item)

        # Salva pedido
        repositorio = IntegracaoRepositorio(self.db)
        id_pedido = repositorio.salvar_pedido(pedido)
        pedido.id_pedido_ia = id_pedido

        # Atualiza status do pedido sugerido
        self._atualizar_status_necessidade(id_nec_ped, 'PEDIDO')

        self.logger.info(f"Pedido SmartPed gerado: ID={id_pedido}, {pedido.qtd_itens} itens, R$ {pedido.vlr_total:.2f}")

        return pedido

    def gerar_pedidos_aprovados(self, id_filial: int,
                                 usuario: str = "SISTEMA") -> List[PedidoCompra]:
        """
        Gera pedidos para todas as necessidades aprovadas de uma filial.
        """

        sql = """
            SELECT IDNecPed
            FROM ia_arqnecped
            WHERE IDFilial = :id_filial
              AND Status = 'APROVADO'
            ORDER BY FIELD(PrioridadeMax, 'URGENTE', 'ALTA', 'NORMAL', 'BAIXA')
        """

        result = self.db.execute_query(sql, {'id_filial': id_filial})

        pedidos = []
        for r in result:
            try:
                pedido = self.gerar_pedido_de_necessidade(r['IDNecPed'], usuario)
                pedidos.append(pedido)
            except Exception as e:
                self.logger.error(f"Erro ao gerar pedido para {r['IDNecPed']}: {e}")

        self.logger.info(f"Gerados {len(pedidos)} pedidos SmartPed para filial {id_filial}")

        return pedidos

    def _buscar_pedido_sugerido(self, id_nec_ped: int) -> Dict:
        """Busca dados do pedido sugerido"""

        sql = """
            SELECT * FROM ia_arqnecped
            WHERE IDNecPed = :id
        """
        result = self.db.execute_query(sql, {'id': id_nec_ped})
        return result[0] if result else None

    def _buscar_itens_necessidade(self, id_nec_ped: int) -> List[Dict]:
        """Busca itens (necessidades) do pedido"""

        sql = """
            SELECT
                n.*,
                p.CodPro,
                p.Despro,
                p.CodEAN
            FROM ia_arqnecessi n
            INNER JOIN arqproduto p ON p.IDProd = n.IDProd
            WHERE n.IDNecPed = :id
              AND n.Status IN ('PENDENTE', 'APROVADA', 'PEDIDO')
              AND n.BloqCompra = 0
            ORDER BY n.ScorePrior DESC
        """

        return self.db.execute_query(sql, {'id': id_nec_ped})

    def _buscar_condicoes_fornecedor(self, cnpj: str, id_filial: int) -> Dict:
        """Busca condições comerciais do fornecedor"""

        sql = """
            SELECT
                PrazoMedioPgto as prazo_pgto,
                LeadTimeMedio as lead_time
            FROM ia_arqfornscor
            WHERE CNPJForn = :cnpj
              AND IDFilial = :id_filial
              AND Status = 'ATIVO'
            LIMIT 1
        """

        result = self.db.execute_query(sql, {'cnpj': cnpj, 'id_filial': id_filial})

        if result:
            return {
                'cond_pgto': f"{result[0].get('prazo_pgto', 30)} dias",
                'prazo_pgto': int(result[0].get('prazo_pgto') or 30),
                'lead_time': int(result[0].get('lead_time') or 7)
            }

        return {'cond_pgto': '30 dias', 'prazo_pgto': 30, 'lead_time': 7}

    def _atualizar_status_necessidade(self, id_nec_ped: int, status: str):
        """Atualiza status do pedido sugerido"""

        sql = """
            UPDATE ia_arqnecped
            SET Status = :status
            WHERE IDNecPed = :id
        """
        self.db.execute_query(sql, {'id': id_nec_ped, 'status': status})

    def aprovar_pedido(self, id_pedido_ia: int, usuario: str) -> bool:
        """Aprova um pedido gerado"""

        sql = """
            UPDATE ia_arqpedido
            SET Status = 'APROVADO',
                DatAprovacao = NOW(),
                UserAprovacao = :usuario
            WHERE IDPedidoIA = :id
              AND Status = 'RASCUNHO'
        """

        self.db.execute_query(sql, {'id': id_pedido_ia, 'usuario': usuario})
        self.logger.info(f"Pedido {id_pedido_ia} aprovado por {usuario}")

        return True

    def enviar_pedido(self, id_pedido_ia: int) -> bool:
        """
        Marca pedido como enviado.
        Em implementação real, aqui seria o envio para o fornecedor.
        """

        sql = """
            UPDATE ia_arqpedido
            SET Status = 'ENVIADO',
                DatEnvio = NOW()
            WHERE IDPedidoIA = :id
              AND Status = 'APROVADO'
        """

        self.db.execute_query(sql, {'id': id_pedido_ia})
        self.logger.info(f"Pedido {id_pedido_ia} enviado ao fornecedor")

        return True
