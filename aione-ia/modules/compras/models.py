"""
AIONE IA - Compras Models
Modelos SQLAlchemy 2.0 para o módulo de compras
"""

from datetime import date, datetime
from decimal import Decimal
from typing import Dict, List, Optional

from sqlalchemy import (
    BigInteger, Boolean, Date, DateTime, Integer, String, Text,
    DECIMAL, Enum, ForeignKey, func
)
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship


class ComprasBase(DeclarativeBase):
    """Base declarativa específica do módulo de compras."""
    pass


class Regiao(ComprasBase):
    """
    Modelo para regiões geográficas.

    Tabela: ia_arqregioes
    """
    __tablename__ = 'ia_arqregioes'

    # Campos principais
    IDRegiao: Mapped[int] = mapped_column(Integer, primary_key=True)
    NomeReg: Mapped[str] = mapped_column(String(50))
    UF_Reg: Mapped[str] = mapped_column(String(2))
    CodIBGE: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)

    # Coordenadas geográficas
    Latitude: Mapped[Optional[Decimal]] = mapped_column(DECIMAL(10, 7), nullable=True)
    Longitude: Mapped[Optional[Decimal]] = mapped_column(DECIMAL(10, 7), nullable=True)

    # Dados geográficos
    GeoTrends: Mapped[Optional[str]] = mapped_column(String(30), nullable=True)
    GeoMetro: Mapped[Optional[str]] = mapped_column(String(30), nullable=True)
    GeoEstado: Mapped[Optional[str]] = mapped_column(String(10), nullable=True)
    NivelGeo: Mapped[Optional[str]] = mapped_column(
        Enum('CIDADE', 'METRO', 'ESTADO', name='nivel_geo_enum'),
        nullable=True
    )

    # Dados demográficos
    Populacao: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    Ativo: Mapped[bool] = mapped_column(Boolean, default=True)

    # Relationships
    coletas: Mapped[List["Coleta"]] = relationship("Coleta", back_populates="regiao")
    eventos: Mapped[List["Evento"]] = relationship("Evento", back_populates="regiao")
    alertas: Mapped[List["Alerta"]] = relationship("Alerta", back_populates="regiao")

    def __repr__(self) -> str:
        return f"<Regiao(IDRegiao={self.IDRegiao}, NomeReg='{self.NomeReg}', UF='{self.UF_Reg}')>"

    def to_dict(self) -> Dict:
        """Converte para dicionário para serialização."""
        return {
            'IDRegiao': self.IDRegiao,
            'NomeReg': self.NomeReg,
            'UF_Reg': self.UF_Reg,
            'CodIBGE': self.CodIBGE,
            'Latitude': float(self.Latitude) if self.Latitude else None,
            'Longitude': float(self.Longitude) if self.Longitude else None,
            'GeoTrends': self.GeoTrends,
            'GeoMetro': self.GeoMetro,
            'GeoEstado': self.GeoEstado,
            'NivelGeo': self.NivelGeo,
            'Populacao': self.Populacao,
            'Ativo': self.Ativo
        }


class FonteExterna(ComprasBase):
    """
    Modelo para fontes externas de dados.

    Tabela: ia_arqfonteext
    """
    __tablename__ = 'ia_arqfonteext'

    # Campos principais
    IDFonte: Mapped[int] = mapped_column(Integer, primary_key=True)
    NomeFonte: Mapped[str] = mapped_column(String(50))
    TipoFonte: Mapped[str] = mapped_column(
        Enum('CLIMA', 'SAUDE', 'EVENTO', 'TENDENCIA', name='tipo_fonte_enum')
    )

    # Configuração da API
    UrlApi: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    ChaveApi: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    Frequenc: Mapped[int] = mapped_column(Integer, default=24)

    # Status
    Ativo: Mapped[bool] = mapped_column(Boolean, default=True)
    DatUltCol: Mapped[Optional[datetime]] = mapped_column(DateTime, nullable=True)
    StatusUlt: Mapped[Optional[str]] = mapped_column(
        Enum('SUCESSO', 'ERRO', name='status_coleta_enum'),
        nullable=True
    )

    # Relationships
    coletas: Mapped[List["Coleta"]] = relationship("Coleta", back_populates="fonte")

    def __repr__(self) -> str:
        return f"<FonteExterna(IDFonte={self.IDFonte}, NomeFonte='{self.NomeFonte}', TipoFonte='{self.TipoFonte}')>"

    def to_dict(self) -> Dict:
        """Converte para dicionário para serialização."""
        return {
            'IDFonte': self.IDFonte,
            'NomeFonte': self.NomeFonte,
            'TipoFonte': self.TipoFonte,
            'UrlApi': self.UrlApi,
            'ChaveApi': self.ChaveApi,
            'Frequenc': self.Frequenc,
            'Ativo': self.Ativo,
            'DatUltCol': self.DatUltCol.isoformat() if self.DatUltCol else None,
            'StatusUlt': self.StatusUlt
        }


class Coleta(ComprasBase):
    """
    Modelo para dados coletados de fontes externas.

    Tabela: ia_arqcoletaex
    """
    __tablename__ = 'ia_arqcoletaex'

    # Campos principais
    IDColeta: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    IDFonte: Mapped[int] = mapped_column(Integer, ForeignKey('ia_arqfonteext.IDFonte'))
    DatColeta: Mapped[datetime] = mapped_column(DateTime, default=func.now())
    IDRegiao: Mapped[Optional[int]] = mapped_column(
        Integer,
        ForeignKey('ia_arqregioes.IDRegiao'),
        nullable=True
    )

    # Dados coletados
    DadosBruto: Mapped[str] = mapped_column(Text)
    Processado: Mapped[bool] = mapped_column(Boolean, default=False)

    # Relationships
    fonte: Mapped["FonteExterna"] = relationship("FonteExterna", back_populates="coletas")
    regiao: Mapped[Optional["Regiao"]] = relationship("Regiao", back_populates="coletas")
    eventos: Mapped[List["Evento"]] = relationship("Evento", back_populates="coleta")
    alertas: Mapped[List["Alerta"]] = relationship("Alerta", back_populates="coleta")

    def __repr__(self) -> str:
        return f"<Coleta(IDColeta={self.IDColeta}, IDFonte={self.IDFonte}, DatColeta='{self.DatColeta}')>"

    def to_dict(self) -> Dict:
        """Converte para dicionário para serialização."""
        return {
            'IDColeta': self.IDColeta,
            'IDFonte': self.IDFonte,
            'DatColeta': self.DatColeta.isoformat() if self.DatColeta else None,
            'IDRegiao': self.IDRegiao,
            'DadosBruto': self.DadosBruto,
            'Processado': self.Processado
        }


class Evento(ComprasBase):
    """
    Modelo para eventos que impactam vendas.

    Tabela: ia_arqeventos
    """
    __tablename__ = 'ia_arqeventos'

    # Campos principais
    IDEvento: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    TipoEvt: Mapped[str] = mapped_column(
        Enum('SURTO', 'CAMPANHA', 'FERIADO', 'EVENTO', 'CLIMA', name='tipo_evento_enum')
    )
    DescEvt: Mapped[str] = mapped_column(String(200))

    # Período
    DatInicio: Mapped[date] = mapped_column(Date)
    DatFinal: Mapped[date] = mapped_column(Date)

    # Localização e impacto
    IDRegiao: Mapped[Optional[int]] = mapped_column(
        Integer,
        ForeignKey('ia_arqregioes.IDRegiao'),
        nullable=True
    )
    PercImpac: Mapped[Optional[Decimal]] = mapped_column(DECIMAL(5, 2), nullable=True)
    Categor: Mapped[Optional[str]] = mapped_column(Text, nullable=True)  # JSON

    # Origem e rastreamento
    Origem: Mapped[str] = mapped_column(
        Enum('MANUAL', 'AUTOMATICA', name='origem_enum'),
        default='AUTOMATICA'
    )
    IDColeta: Mapped[Optional[int]] = mapped_column(
        BigInteger,
        ForeignKey('ia_arqcoletaex.IDColeta'),
        nullable=True
    )

    # Relationships
    regiao: Mapped[Optional["Regiao"]] = relationship("Regiao", back_populates="eventos")
    coleta: Mapped[Optional["Coleta"]] = relationship("Coleta", back_populates="eventos")

    def __repr__(self) -> str:
        return f"<Evento(IDEvento={self.IDEvento}, TipoEvt='{self.TipoEvt}', DescEvt='{self.DescEvt}')>"

    def to_dict(self) -> Dict:
        """Converte para dicionário para serialização."""
        return {
            'IDEvento': self.IDEvento,
            'TipoEvt': self.TipoEvt,
            'DescEvt': self.DescEvt,
            'DatInicio': self.DatInicio.isoformat() if self.DatInicio else None,
            'DatFinal': self.DatFinal.isoformat() if self.DatFinal else None,
            'IDRegiao': self.IDRegiao,
            'PercImpac': float(self.PercImpac) if self.PercImpac else None,
            'Categor': self.Categor,
            'Origem': self.Origem,
            'IDColeta': self.IDColeta
        }


class Alerta(ComprasBase):
    """
    Modelo para alertas gerados pela análise de dados externos.

    Tabela: ia_arqalertaex
    """
    __tablename__ = 'ia_arqalertaex'

    # Campos principais
    IDAlerta: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    IDColeta: Mapped[int] = mapped_column(BigInteger, ForeignKey('ia_arqcoletaex.IDColeta'))
    TipAlerta: Mapped[str] = mapped_column(
        Enum(
            'SURTO', 'ONDA_FRIO', 'ONDA_CALOR', 'TEMPO_SECO',
            'EVENTO_GRANDE', 'TENDENCIA_ALTA',
            name='tipo_alerta_enum'
        )
    )
    Severidade: Mapped[str] = mapped_column(
        Enum('BAIXA', 'MEDIA', 'ALTA', 'CRITICA', name='severidade_enum')
    )

    # Localização e período
    IDRegiao: Mapped[int] = mapped_column(Integer, ForeignKey('ia_arqregioes.IDRegiao'))
    DatInicio: Mapped[date] = mapped_column(Date)
    DatFinal: Mapped[date] = mapped_column(Date)

    # Conteúdo do alerta
    DescAlert: Mapped[str] = mapped_column(Text)
    AcaoSuger: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    # Controle de visualização
    Visualiz: Mapped[bool] = mapped_column(Boolean, default=False)
    DatVisual: Mapped[Optional[datetime]] = mapped_column(DateTime, nullable=True)

    # Relationships
    coleta: Mapped["Coleta"] = relationship("Coleta", back_populates="alertas")
    regiao: Mapped["Regiao"] = relationship("Regiao", back_populates="alertas")

    def __repr__(self) -> str:
        return f"<Alerta(IDAlerta={self.IDAlerta}, TipAlerta='{self.TipAlerta}', Severidade='{self.Severidade}')>"

    def to_dict(self) -> Dict:
        """Converte para dicionário para serialização."""
        return {
            'IDAlerta': self.IDAlerta,
            'IDColeta': self.IDColeta,
            'TipAlerta': self.TipAlerta,
            'Severidade': self.Severidade,
            'IDRegiao': self.IDRegiao,
            'DatInicio': self.DatInicio.isoformat() if self.DatInicio else None,
            'DatFinal': self.DatFinal.isoformat() if self.DatFinal else None,
            'DescAlert': self.DescAlert,
            'AcaoSuger': self.AcaoSuger,
            'Visualiz': self.Visualiz,
            'DatVisual': self.DatVisual.isoformat() if self.DatVisual else None
        }

    def marcar_visualizado(self) -> None:
        """Marca o alerta como visualizado."""
        self.Visualiz = True
        self.DatVisual = func.now()


class Correlacao(ComprasBase):
    """
    Modelo para correlações entre eventos e vendas de produtos.

    Tabela: ia_arqcorrelac
    """
    __tablename__ = 'ia_arqcorrelac'

    # Campos principais
    IDCorrel: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    TipoEvento: Mapped[str] = mapped_column(String(30))

    # Produto/Categoria afetados
    IDGrupo: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    IDCateg: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    IDProd: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)

    # Impacto e timing
    PercImpac: Mapped[Decimal] = mapped_column(DECIMAL(6, 2))
    DiasAntes: Mapped[int] = mapped_column(Integer, default=0)
    DiasDurac: Mapped[int] = mapped_column(Integer, default=1)

    # Confiabilidade
    Confianca: Mapped[Decimal] = mapped_column(DECIMAL(5, 2), default=100)
    Origem: Mapped[str] = mapped_column(
        Enum('MANUAL', 'APRENDIDA', name='origem_correlacao_enum'),
        default='MANUAL'
    )

    def __repr__(self) -> str:
        return (f"<Correlacao(IDCorrel={self.IDCorrel}, TipoEvento='{self.TipoEvento}', "
                f"PercImpac={self.PercImpac})>")

    def to_dict(self) -> Dict:
        """Converte para dicionário para serialização."""
        return {
            'IDCorrel': self.IDCorrel,
            'TipoEvento': self.TipoEvento,
            'IDGrupo': self.IDGrupo,
            'IDCateg': self.IDCateg,
            'IDProd': self.IDProd,
            'PercImpac': float(self.PercImpac) if self.PercImpac else None,
            'DiasAntes': self.DiasAntes,
            'DiasDurac': self.DiasDurac,
            'Confianca': float(self.Confianca) if self.Confianca else None,
            'Origem': self.Origem
        }

    def calcular_fator_impacto(self) -> float:
        """
        Calcula o fator de impacto baseado no percentual e confiança.

        Returns:
            float: Fator de impacto ajustado pela confiança
        """
        if self.PercImpac and self.Confianca:
            return float(self.PercImpac) * (float(self.Confianca) / 100)
        return 0.0

    @classmethod
    def buscar_por_evento(cls, session, tipo_evento: str) -> List["Correlacao"]:
        """
        Busca correlações por tipo de evento.

        Args:
            session: Sessão SQLAlchemy
            tipo_evento: Tipo do evento a buscar

        Returns:
            Lista de correlações encontradas
        """
        return session.query(cls).filter(cls.TipoEvento == tipo_evento).all()

    @classmethod
    def buscar_por_produto(cls, session, id_produto: int) -> List["Correlacao"]:
        """
        Busca correlações que afetam um produto específico.

        Args:
            session: Sessão SQLAlchemy
            id_produto: ID do produto

        Returns:
            Lista de correlações encontradas
        """
        return session.query(cls).filter(
            (cls.IDProd == id_produto) |
            (cls.IDGrupo.isnot(None)) |
            (cls.IDCateg.isnot(None))
        ).all()


# Lista de todos os modelos para importação fácil
__all__ = [
    'ComprasBase',
    'Regiao',
    'FonteExterna',
    'Coleta',
    'Evento',
    'Alerta',
    'Correlacao'
]