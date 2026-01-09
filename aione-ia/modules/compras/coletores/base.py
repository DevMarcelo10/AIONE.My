"""
AIONE IA - Coletor Base
Classe abstrata para todos os coletores de dados externos
"""

import json
from abc import ABC, abstractmethod
from datetime import date, datetime
from typing import Dict, List

from core.database import DatabaseManager
from core.utils import get_logger
from modules.compras.models import Regiao, FonteExterna, Coleta, Evento, Alerta


class ColetorBase(ABC):
    """
    Classe abstrata base para coletores de dados externos.

    Fornece funcionalidades comuns de persistência e gestão de dados.
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o coletor com conexão ao banco.

        Args:
            db: Instância do DatabaseManager
        """
        self.db = db
        self.logger = get_logger(self.__class__.__name__)

    # ==================== PROPRIEDADES ABSTRATAS ====================

    @property
    @abstractmethod
    def nome(self) -> str:
        """Nome do coletor."""
        pass

    @property
    @abstractmethod
    def tipo_fonte(self) -> str:
        """Tipo da fonte de dados (CLIMA, SAUDE, TENDENCIA, EVENTO)."""
        pass

    @property
    @abstractmethod
    def frequencia_horas(self) -> int:
        """Frequência de coleta em horas."""
        pass

    # ==================== MÉTODOS ABSTRATOS ====================

    @abstractmethod
    async def coletar(self, regiao: Regiao) -> Dict:
        """
        Coleta dados para uma região específica.

        Args:
            regiao: Região para coletar dados

        Returns:
            Dicionário com dados coletados
        """
        pass

    @abstractmethod
    def processar(self, dados_brutos: Dict, regiao: Regiao) -> List[Dict]:
        """
        Processa dados brutos e gera alertas/eventos.

        Args:
            dados_brutos: Dados retornados por coletar()
            regiao: Região dos dados

        Returns:
            Lista de dicionários com alertas e eventos a criar
        """
        pass

    # ==================== MÉTODOS CONCRETOS ====================

    async def executar(self) -> Dict:
        """
        Executa coleta completa para todas as regiões ativas.

        Returns:
            Dicionário com resultado da execução:
            {"sucesso": bool, "regioes": int, "alertas": int, "erros": list}
        """
        resultado = {
            "sucesso": True,
            "regioes": 0,
            "alertas": 0,
            "erros": []
        }

        try:
            self.logger.info(f"Iniciando execução do coletor {self.nome}")

            # Obter regiões ativas
            regioes = self.obter_regioes_ativas()
            if not regioes:
                self.logger.warning("Nenhuma região ativa encontrada")
                return resultado

            # Processar cada região
            for regiao in regioes:
                try:
                    self.logger.debug(f"Processando região {regiao.NomeReg}")

                    # Coletar dados brutos
                    dados = await self.coletar(regiao)

                    if not dados or dados.get('erro'):
                        erro_msg = dados.get('erro', 'Dados vazios') if dados else 'Falha na coleta'
                        resultado['erros'].append({
                            "regiao": regiao.NomeReg,
                            "erro": erro_msg
                        })
                        continue

                    # Salvar coleta no banco
                    id_coleta = self.salvar_coleta(dados, regiao.IDRegiao)

                    # Processar dados e gerar alertas/eventos
                    eventos_alertas = self.processar(dados, regiao)

                    # Criar alertas e eventos no banco
                    for item in eventos_alertas:
                        try:
                            if item["tipo"] == "alerta":
                                self.criar_alerta(
                                    id_coleta=id_coleta,
                                    **item["dados"]
                                )
                                resultado["alertas"] += 1

                            elif item["tipo"] == "evento":
                                self.criar_evento(
                                    id_coleta=id_coleta,
                                    **item["dados"]
                                )

                        except Exception as e:
                            self.logger.error(f"Erro ao criar {item['tipo']}: {e}")
                            resultado['erros'].append({
                                "regiao": regiao.NomeReg,
                                "erro": f"Erro ao criar {item['tipo']}: {str(e)}"
                            })

                    resultado["regioes"] += 1
                    self.logger.debug(
                        f"Região {regiao.NomeReg}: {len(eventos_alertas)} itens processados"
                    )

                except Exception as e:
                    self.logger.error(f"Erro ao processar região {regiao.NomeReg}: {e}")
                    resultado["erros"].append({
                        "regiao": regiao.NomeReg,
                        "erro": str(e)
                    })

            # Atualizar status da fonte
            sucesso = len(resultado["erros"]) == 0
            self.atualizar_status_fonte(sucesso=sucesso)
            resultado["sucesso"] = sucesso

            self.logger.info(
                f"Execução concluída: {resultado['regioes']} regiões, "
                f"{resultado['alertas']} alertas, {len(resultado['erros'])} erros"
            )

        except Exception as e:
            self.logger.error(f"Erro geral na execução: {e}")
            resultado["sucesso"] = False
            resultado["erros"].append({"geral": str(e)})

        return resultado

    def obter_regioes_ativas(self) -> List[Regiao]:
        """
        Retorna regiões com Ativo=1.

        Returns:
            Lista de regiões ativas
        """
        try:
            with self.db.session_scope() as session:
                regioes = session.query(Regiao).filter(
                    Regiao.Ativo == True
                ).all()

                self.logger.debug(f"Encontradas {len(regioes)} regiões ativas")
                return regioes

        except Exception as e:
            self.logger.error(f"Erro ao obter regiões ativas: {e}")
            return []

    def salvar_coleta(self, dados: Dict, regiao_id: int) -> int:
        """
        Salva em ia_arqcoletaex e retorna IDColeta.

        Args:
            dados: Dados coletados
            regiao_id: ID da região

        Returns:
            ID da coleta criada
        """
        try:
            with self.db.session_scope() as session:
                # Obter fonte
                fonte = self.obter_fonte()
                if not fonte:
                    raise ValueError(f"Fonte não encontrada para tipo: {self.tipo_fonte}")

                # Criar registro de coleta
                coleta = Coleta(
                    IDFonte=fonte.IDFonte,
                    DatColeta=datetime.now(),
                    IDRegiao=regiao_id,
                    DadosBruto=json.dumps(dados, default=str, ensure_ascii=False),
                    Processado=False
                )

                session.add(coleta)
                session.commit()
                session.refresh(coleta)

                # Marcar como processado
                coleta.Processado = True
                session.commit()

                self.logger.debug(f"Coleta salva: ID={coleta.IDColeta}")
                return coleta.IDColeta

        except Exception as e:
            self.logger.error(f"Erro ao salvar coleta: {e}")
            raise

    def criar_evento(
        self,
        tipo: str,
        descricao: str,
        data_inicio: date,
        data_fim: date,
        regiao_id: int,
        impacto: float,
        categorias: List[str],
        id_coleta: int
    ) -> int:
        """
        Cria em ia_arqeventos e retorna IDEvento.

        Args:
            tipo: Tipo do evento
            descricao: Descrição do evento
            data_inicio: Data de início
            data_fim: Data de fim
            regiao_id: ID da região
            impacto: Percentual de impacto
            categorias: Lista de categorias afetadas
            id_coleta: ID da coleta que gerou o evento

        Returns:
            ID do evento criado
        """
        try:
            with self.db.session_scope() as session:
                evento = Evento(
                    TipoEvt=tipo.upper(),
                    DescEvt=descricao,
                    DatInicio=data_inicio,
                    DatFinal=data_fim,
                    IDRegiao=regiao_id,
                    PercImpac=impacto,
                    Categor=json.dumps(categorias, ensure_ascii=False),
                    Origem='AUTOMATICA',
                    IDColeta=id_coleta
                )

                session.add(evento)
                session.commit()
                session.refresh(evento)

                self.logger.debug(f"Evento criado: ID={evento.IDEvento}, Tipo={tipo}")
                return evento.IDEvento

        except Exception as e:
            self.logger.error(f"Erro ao criar evento: {e}")
            raise

    def criar_alerta(
        self,
        tipo: str,
        severidade: str,
        regiao_id: int,
        data_inicio: date,
        data_fim: date,
        descricao: str,
        acao: str,
        id_coleta: int
    ) -> int:
        """
        Cria em ia_arqalertaex e retorna IDAlerta.

        Args:
            tipo: Tipo do alerta
            severidade: Severidade (BAIXA, MEDIA, ALTA, CRITICA)
            regiao_id: ID da região
            data_inicio: Data de início
            data_fim: Data de fim
            descricao: Descrição do alerta
            acao: Ação sugerida
            id_coleta: ID da coleta que gerou o alerta

        Returns:
            ID do alerta criado
        """
        try:
            with self.db.session_scope() as session:
                alerta = Alerta(
                    IDColeta=id_coleta,
                    TipAlerta=tipo.upper(),
                    Severidade=severidade.upper(),
                    IDRegiao=regiao_id,
                    DatInicio=data_inicio,
                    DatFinal=data_fim,
                    DescAlert=descricao,
                    AcaoSuger=acao,
                    Visualiz=False
                )

                session.add(alerta)
                session.commit()
                session.refresh(alerta)

                self.logger.debug(f"Alerta criado: ID={alerta.IDAlerta}, Tipo={tipo}")
                return alerta.IDAlerta

        except Exception as e:
            self.logger.error(f"Erro ao criar alerta: {e}")
            raise

    def atualizar_status_fonte(self, sucesso: bool) -> None:
        """
        Atualiza DatUltCol e StatusUlt em ia_arqfonteext.

        Args:
            sucesso: True se coleta foi bem sucedida
        """
        try:
            with self.db.session_scope() as session:
                fonte = session.query(FonteExterna).filter(
                    FonteExterna.TipoFonte == self.tipo_fonte
                ).first()

                if fonte:
                    fonte.DatUltCol = datetime.now()
                    fonte.StatusUlt = 'SUCESSO' if sucesso else 'ERRO'
                    session.commit()

                    self.logger.debug(
                        f"Status da fonte atualizado: {fonte.StatusUlt}"
                    )
                else:
                    self.logger.warning(
                        f"Fonte não encontrada para tipo: {self.tipo_fonte}"
                    )

        except Exception as e:
            self.logger.error(f"Erro ao atualizar status da fonte: {e}")

    def obter_fonte(self) -> FonteExterna:
        """
        Retorna registro da fonte pelo tipo_fonte.

        Returns:
            Instância de FonteExterna ou None se não encontrada
        """
        try:
            with self.db.session_scope() as session:
                fonte = session.query(FonteExterna).filter(
                    FonteExterna.TipoFonte == self.tipo_fonte
                ).first()

                if not fonte:
                    self.logger.warning(
                        f"Fonte não encontrada para tipo: {self.tipo_fonte}"
                    )

                return fonte

        except Exception as e:
            self.logger.error(f"Erro ao obter fonte: {e}")
            return None