"""
AIONE IA - Routes do Módulo de Compras
FastAPI endpoints para gestão de coletores, alertas e eventos
"""

from datetime import datetime, date
from typing import List, Optional, Dict, Any
import asyncio

from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel, Field
from sqlalchemy import and_, or_, desc, func
from sqlalchemy.orm import Session

from core.database import DatabaseManager, get_database
from core.utils import get_logger
from .models import Regiao, FonteExterna, Coleta, Evento, Alerta, Correlacao
from .jobs import executar_coletor

# Imports para Forecast
try:
    from .processadores import ForecastEngine, ForecastRepositorio, ParametrosForecast
    FORECAST_AVAILABLE = True
except ImportError:
    FORECAST_AVAILABLE = False

# Imports para Classificação
try:
    from .processadores import (
        ClassificadorProdutos,
        ClassificacaoRepositorio,
        ParametrosClassificacao,
        AnalisadorCurvaABC
    )
    CLASSIFICACAO_AVAILABLE = True
except ImportError:
    CLASSIFICACAO_AVAILABLE = False

# Imports para Fornecedor
try:
    from .processadores import (
        AnalisadorFornecedor,
        AnalisadorPrecoFornecedor,
        AnalisadorEntregaFornecedor,
        AnalisadorQualidadeFornecedor,
        AnalisadorComercialFornecedor,
        FornecedorScoreRepositorio,
        ParametrosScoreFornecedor
    )
    FORNECEDOR_AVAILABLE = True
except ImportError:
    FORNECEDOR_AVAILABLE = False

# Imports para Integração
try:
    from .processadores.integracao import (
        SmartPed,
        CoteFacilIntegrador,
        GeradorPedido,
        SincronizadorERP,
        IntegracaoRepositorio,
        CriterioSelecao
    )
    INTEGRACAO_AVAILABLE = True
except ImportError:
    INTEGRACAO_AVAILABLE = False

# Imports para Aprendizado
try:
    from .processadores.aprendizado import (
        Comparador,
        CalculadorMetrica,
        Ajustador,
        AnalisadorAprendizado,
        AprendizadoRepositorio
    )
    APRENDIZADO_AVAILABLE = True
except ImportError:
    APRENDIZADO_AVAILABLE = False


logger = get_logger(__name__)
router = APIRouter(prefix="/compras", tags=["Compras"])


# ==================== SCHEMAS PYDANTIC ====================

class StatusColetor(BaseModel):
    ultima_coleta: Optional[datetime] = None
    status: Optional[str] = None
    proxima: Optional[datetime] = None
    ativo: bool = True
    frequencia_horas: Optional[int] = None


class StatusColetores(BaseModel):
    clima: StatusColetor
    saude: StatusColetor
    trends: StatusColetor
    eventos: StatusColetor


class ExecutarColetorResponse(BaseModel):
    sucesso: bool
    regioes: int
    alertas: int
    erros: List[str] = []
    tempo_execucao: Optional[float] = None


class AlertaResponse(BaseModel):
    IDAlerta: int
    TipAlerta: str
    Severidade: str
    IDRegiao: int
    regiao_nome: str
    DatInicio: date
    DatFinal: date
    DescAlert: str
    AcaoSuger: Optional[str] = None
    Visualiz: bool
    DatVisual: Optional[datetime] = None

    class Config:
        from_attributes = True


class VisualizarTodosResponse(BaseModel):
    atualizados: int


class EventoResponse(BaseModel):
    IDEvento: int
    TipoEvt: str
    DescEvt: str
    DatInicio: date
    DatFinal: date
    IDRegiao: Optional[int] = None
    regiao_nome: Optional[str] = None
    PercImpac: Optional[float] = None
    Categor: Optional[str] = None
    Origem: str

    class Config:
        from_attributes = True


class CriarEventoRequest(BaseModel):
    tipo: str = Field(..., description="Tipo do evento")
    descricao: str = Field(..., max_length=200, description="Descrição do evento")
    data_inicio: date = Field(..., description="Data de início")
    data_fim: date = Field(..., description="Data de fim")
    regiao_id: Optional[int] = Field(None, description="ID da região")
    impacto: Optional[float] = Field(None, ge=0, le=100, description="Percentual de impacto")
    categorias: Optional[str] = Field(None, description="Categorias afetadas (JSON)")


class CriarEventoResponse(BaseModel):
    id: int


class RegiaoResponse(BaseModel):
    IDRegiao: int
    NomeReg: str
    UF_Reg: str
    CodIBGE: Optional[int] = None
    Latitude: Optional[float] = None
    Longitude: Optional[float] = None
    GeoTrends: Optional[str] = None
    GeoMetro: Optional[str] = None
    GeoEstado: Optional[str] = None
    NivelGeo: Optional[str] = None
    Populacao: Optional[int] = None
    Ativo: bool

    class Config:
        from_attributes = True


class CriarRegiaoRequest(BaseModel):
    nome: str = Field(..., max_length=50)
    uf: str = Field(..., max_length=2)
    cod_ibge: Optional[int] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    populacao: Optional[int] = None
    geo_trends: Optional[str] = Field(None, max_length=30)
    geo_metro: Optional[str] = Field(None, max_length=30)
    geo_estado: Optional[str] = Field(None, max_length=10)
    nivel_geo: Optional[str] = None


class CorrelacaoResponse(BaseModel):
    IDCorrel: int
    TipoEvento: str
    IDGrupo: Optional[int] = None
    IDCateg: Optional[int] = None
    IDProd: Optional[int] = None
    PercImpac: float
    DiasAntes: int
    DiasDurac: int
    Confianca: float
    Origem: str

    class Config:
        from_attributes = True


class CriarCorrelacaoRequest(BaseModel):
    tipo_evento: str = Field(..., max_length=30)
    id_grupo: Optional[int] = None
    id_categ: Optional[int] = None
    id_prod: Optional[int] = None
    perc_impac: float = Field(..., description="Percentual de impacto")
    dias_antes: int = Field(0, description="Dias antes do evento")
    dias_durac: int = Field(1, description="Duração em dias")
    confianca: float = Field(100.0, ge=0, le=100, description="Confiança na correlação")


# ==================== DEPENDENCY INJECTION ====================

def get_session(db: DatabaseManager = Depends(get_database)) -> Session:
    """Retorna sessão do banco de dados."""
    with db.session_scope() as session:
        yield session


# ==================== ENDPOINTS - COLETORES ====================

@router.get("/coletores/status",
           response_model=StatusColetores,
           tags=["Coletores"],
           summary="Status de todos os coletores")
async def get_coletores_status(session: Session = Depends(get_session)):
    """Retorna status de todos os coletores baseado na tabela ia_arqfonteext."""
    try:
        fontes = session.query(FonteExterna).all()

        # Mapeia tipos de fonte
        tipos_map = {
            'CLIMA': 'clima',
            'SAUDE': 'saude',
            'TENDENCIA': 'trends',
            'EVENTO': 'eventos'
        }

        status_dict = {}

        for fonte in fontes:
            key = tipos_map.get(fonte.TipoFonte)
            if key:
                status_dict[key] = StatusColetor(
                    ultima_coleta=fonte.DatUltCol,
                    status=fonte.StatusUlt,
                    ativo=fonte.Ativo,
                    frequencia_horas=fonte.Frequenc
                )

        # Garante que todos os tipos estejam presentes
        for tipo in ['clima', 'saude', 'trends', 'eventos']:
            if tipo not in status_dict:
                status_dict[tipo] = StatusColetor(ativo=False)

        return StatusColetores(**status_dict)

    except Exception as e:
        logger.error(f"Erro ao obter status dos coletores: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/coletores/{tipo}/executar",
            response_model=ExecutarColetorResponse,
            tags=["Coletores"],
            summary="Executa coletor manualmente")
async def executar_coletor_manual(
    tipo: str,
    db: DatabaseManager = Depends(get_database)
):
    """Executa coleta manual para o tipo especificado."""
    tipos_validos = ['clima', 'saude', 'trends', 'eventos']  # Todos implementados

    if tipo not in tipos_validos:
        raise HTTPException(
            status_code=400,
            detail=f"Tipo inválido. Use: {', '.join(tipos_validos)}"
        )

    try:
        resultado = await executar_coletor(tipo, db)

        return ExecutarColetorResponse(
            sucesso=resultado.get('sucesso', True),
            regioes=resultado.get('regioes', 0),
            alertas=resultado.get('alertas', 0),
            erros=resultado.get('erros', []),
            tempo_execucao=resultado.get('tempo_execucao')
        )

    except Exception as e:
        logger.error(f"Erro ao executar coletor {tipo}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - ALERTAS ====================

@router.get("/alertas",
           response_model=List[AlertaResponse],
           tags=["Alertas"],
           summary="Lista alertas com filtros")
async def get_alertas(
    regiao_id: Optional[int] = Query(None, description="Filtrar por região"),
    severidade: Optional[str] = Query(None, description="Filtrar por severidade"),
    visualizados: Optional[bool] = Query(None, description="Filtrar por visualização"),
    limit: int = Query(50, ge=1, le=500, description="Limite de resultados"),
    session: Session = Depends(get_session)
):
    """Lista alertas com filtros opcionais."""
    try:
        query = session.query(Alerta).join(Regiao)

        # Aplicar filtros
        if regiao_id:
            query = query.filter(Alerta.IDRegiao == regiao_id)

        if severidade:
            query = query.filter(Alerta.Severidade == severidade.upper())

        if visualizados is not None:
            query = query.filter(Alerta.Visualiz == visualizados)

        # Ordenar por data (mais recentes primeiro)
        alertas = (query
                  .order_by(desc(Alerta.DatInicio))
                  .limit(limit)
                  .all())

        # Converter para response
        result = []
        for alerta in alertas:
            result.append(AlertaResponse(
                IDAlerta=alerta.IDAlerta,
                TipAlerta=alerta.TipAlerta,
                Severidade=alerta.Severidade,
                IDRegiao=alerta.IDRegiao,
                regiao_nome=alerta.regiao.NomeReg,
                DatInicio=alerta.DatInicio,
                DatFinal=alerta.DatFinal,
                DescAlert=alerta.DescAlert,
                AcaoSuger=alerta.AcaoSuger,
                Visualiz=alerta.Visualiz,
                DatVisual=alerta.DatVisual
            ))

        return result

    except Exception as e:
        logger.error(f"Erro ao buscar alertas: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/alertas/{id}",
           response_model=AlertaResponse,
           tags=["Alertas"],
           summary="Retorna alerta específico")
async def get_alerta(
    id: int,
    session: Session = Depends(get_session)
):
    """Retorna alerta específico com todos os campos."""
    try:
        alerta = (session.query(Alerta)
                 .join(Regiao)
                 .filter(Alerta.IDAlerta == id)
                 .first())

        if not alerta:
            raise HTTPException(status_code=404, detail="Alerta não encontrado")

        return AlertaResponse(
            IDAlerta=alerta.IDAlerta,
            TipAlerta=alerta.TipAlerta,
            Severidade=alerta.Severidade,
            IDRegiao=alerta.IDRegiao,
            regiao_nome=alerta.regiao.NomeReg,
            DatInicio=alerta.DatInicio,
            DatFinal=alerta.DatFinal,
            DescAlert=alerta.DescAlert,
            AcaoSuger=alerta.AcaoSuger,
            Visualiz=alerta.Visualiz,
            DatVisual=alerta.DatVisual
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao buscar alerta {id}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/alertas/{id}/visualizar",
           response_model=Dict[str, bool],
           tags=["Alertas"],
           summary="Marca alerta como visualizado")
async def visualizar_alerta(
    id: int,
    session: Session = Depends(get_session)
):
    """Marca alerta específico como visualizado."""
    try:
        alerta = session.query(Alerta).filter(Alerta.IDAlerta == id).first()

        if not alerta:
            raise HTTPException(status_code=404, detail="Alerta não encontrado")

        alerta.marcar_visualizado()
        session.commit()

        return {"sucesso": True}

    except HTTPException:
        raise
    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao visualizar alerta {id}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/alertas/visualizar-todos",
           response_model=VisualizarTodosResponse,
           tags=["Alertas"],
           summary="Marca todos alertas como visualizados")
async def visualizar_todos_alertas(
    regiao_id: Optional[int] = Query(None, description="Filtrar por região"),
    session: Session = Depends(get_session)
):
    """Marca todos os alertas não visualizados como visualizados."""
    try:
        query = session.query(Alerta).filter(Alerta.Visualiz == False)

        if regiao_id:
            query = query.filter(Alerta.IDRegiao == regiao_id)

        # Atualiza em lote
        count = query.update({
            Alerta.Visualiz: True,
            Alerta.DatVisual: func.now()
        })

        session.commit()

        return VisualizarTodosResponse(atualizados=count)

    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao visualizar todos alertas: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - EVENTOS ====================

@router.get("/eventos",
           response_model=List[EventoResponse],
           tags=["Eventos"],
           summary="Lista eventos com filtros")
async def get_eventos(
    regiao_id: Optional[int] = Query(None, description="Filtrar por região"),
    tipo: Optional[str] = Query(None, description="Filtrar por tipo"),
    dias_futuros: int = Query(30, ge=0, description="Dias futuros a incluir"),
    session: Session = Depends(get_session)
):
    """Lista eventos com filtros opcionais."""
    try:
        from datetime import datetime, timedelta

        query = session.query(Evento).outerjoin(Regiao)

        # Filtrar por região
        if regiao_id:
            query = query.filter(Evento.IDRegiao == regiao_id)

        # Filtrar por tipo
        if tipo:
            query = query.filter(Evento.TipoEvt == tipo.upper())

        # Filtrar por período (eventos atuais + futuros)
        data_limite = datetime.now().date() + timedelta(days=dias_futuros)
        query = query.filter(Evento.DatFinal >= datetime.now().date())
        query = query.filter(Evento.DatInicio <= data_limite)

        # Ordenar por data
        eventos = query.order_by(Evento.DatInicio).all()

        # Converter para response
        result = []
        for evento in eventos:
            result.append(EventoResponse(
                IDEvento=evento.IDEvento,
                TipoEvt=evento.TipoEvt,
                DescEvt=evento.DescEvt,
                DatInicio=evento.DatInicio,
                DatFinal=evento.DatFinal,
                IDRegiao=evento.IDRegiao,
                regiao_nome=evento.regiao.NomeReg if evento.regiao else None,
                PercImpac=float(evento.PercImpac) if evento.PercImpac else None,
                Categor=evento.Categor,
                Origem=evento.Origem
            ))

        return result

    except Exception as e:
        logger.error(f"Erro ao buscar eventos: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/eventos/{id}",
           response_model=EventoResponse,
           tags=["Eventos"],
           summary="Retorna evento específico")
async def get_evento(
    id: int,
    session: Session = Depends(get_session)
):
    """Retorna evento específico."""
    try:
        evento = (session.query(Evento)
                 .outerjoin(Regiao)
                 .filter(Evento.IDEvento == id)
                 .first())

        if not evento:
            raise HTTPException(status_code=404, detail="Evento não encontrado")

        return EventoResponse(
            IDEvento=evento.IDEvento,
            TipoEvt=evento.TipoEvt,
            DescEvt=evento.DescEvt,
            DatInicio=evento.DatInicio,
            DatFinal=evento.DatFinal,
            IDRegiao=evento.IDRegiao,
            regiao_nome=evento.regiao.NomeReg if evento.regiao else None,
            PercImpac=float(evento.PercImpac) if evento.PercImpac else None,
            Categor=evento.Categor,
            Origem=evento.Origem
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao buscar evento {id}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/eventos",
            response_model=CriarEventoResponse,
            tags=["Eventos"],
            summary="Cria evento manual")
async def criar_evento(
    evento_data: CriarEventoRequest,
    session: Session = Depends(get_session)
):
    """Cria novo evento manual."""
    try:
        # Validar região se informada
        if evento_data.regiao_id:
            regiao = session.query(Regiao).filter(Regiao.IDRegiao == evento_data.regiao_id).first()
            if not regiao:
                raise HTTPException(status_code=400, detail="Região não encontrada")

        # Criar evento
        evento = Evento(
            TipoEvt=evento_data.tipo.upper(),
            DescEvt=evento_data.descricao,
            DatInicio=evento_data.data_inicio,
            DatFinal=evento_data.data_fim,
            IDRegiao=evento_data.regiao_id,
            PercImpac=evento_data.impacto,
            Categor=evento_data.categorias,
            Origem='MANUAL'
        )

        session.add(evento)
        session.commit()
        session.refresh(evento)

        logger.info(f"Evento manual criado: {evento.IDEvento}")

        return CriarEventoResponse(id=evento.IDEvento)

    except HTTPException:
        raise
    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao criar evento: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - REGIÕES ====================

@router.get("/regioes",
           response_model=List[RegiaoResponse],
           tags=["Regiões"],
           summary="Lista regiões")
async def get_regioes(
    ativo: Optional[bool] = Query(None, description="Filtrar por status ativo"),
    session: Session = Depends(get_session)
):
    """Lista regiões com filtro opcional por status."""
    try:
        query = session.query(Regiao)

        if ativo is not None:
            query = query.filter(Regiao.Ativo == ativo)

        regioes = query.order_by(Regiao.UF_Reg, Regiao.NomeReg).all()

        return [RegiaoResponse.model_validate(regiao) for regiao in regioes]

    except Exception as e:
        logger.error(f"Erro ao buscar regiões: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/regioes/{id}",
           response_model=RegiaoResponse,
           tags=["Regiões"],
           summary="Retorna região específica")
async def get_regiao(
    id: int,
    session: Session = Depends(get_session)
):
    """Retorna região específica."""
    try:
        regiao = session.query(Regiao).filter(Regiao.IDRegiao == id).first()

        if not regiao:
            raise HTTPException(status_code=404, detail="Região não encontrada")

        return RegiaoResponse.model_validate(regiao)

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao buscar região {id}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/regioes",
            response_model=Dict[str, int],
            tags=["Regiões"],
            summary="Cria nova região")
async def criar_regiao(
    regiao_data: CriarRegiaoRequest,
    session: Session = Depends(get_session)
):
    """Cria nova região."""
    try:
        regiao = Regiao(
            NomeReg=regiao_data.nome,
            UF_Reg=regiao_data.uf,
            CodIBGE=regiao_data.cod_ibge,
            Latitude=regiao_data.latitude,
            Longitude=regiao_data.longitude,
            Populacao=regiao_data.populacao,
            GeoTrends=regiao_data.geo_trends,
            GeoMetro=regiao_data.geo_metro,
            GeoEstado=regiao_data.geo_estado,
            NivelGeo=regiao_data.nivel_geo,
            Ativo=True
        )

        session.add(regiao)
        session.commit()
        session.refresh(regiao)

        logger.info(f"Região criada: {regiao.IDRegiao}")

        return {"id": regiao.IDRegiao}

    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao criar região: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/regioes/{id}",
           response_model=Dict[str, bool],
           tags=["Regiões"],
           summary="Atualiza região")
async def atualizar_regiao(
    id: int,
    regiao_data: CriarRegiaoRequest,
    session: Session = Depends(get_session)
):
    """Atualiza região existente."""
    try:
        regiao = session.query(Regiao).filter(Regiao.IDRegiao == id).first()

        if not regiao:
            raise HTTPException(status_code=404, detail="Região não encontrada")

        # Atualizar campos
        regiao.NomeReg = regiao_data.nome
        regiao.UF_Reg = regiao_data.uf
        regiao.CodIBGE = regiao_data.cod_ibge
        regiao.Latitude = regiao_data.latitude
        regiao.Longitude = regiao_data.longitude
        regiao.Populacao = regiao_data.populacao
        regiao.GeoTrends = regiao_data.geo_trends
        regiao.GeoMetro = regiao_data.geo_metro
        regiao.GeoEstado = regiao_data.geo_estado
        regiao.NivelGeo = regiao_data.nivel_geo

        session.commit()

        logger.info(f"Região atualizada: {id}")

        return {"sucesso": True}

    except HTTPException:
        raise
    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao atualizar região {id}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/regioes/{id}/ativar",
           response_model=Dict[str, bool],
           tags=["Regiões"],
           summary="Ativa região")
async def ativar_regiao(
    id: int,
    session: Session = Depends(get_session)
):
    """Ativa região específica."""
    return await _alterar_status_regiao(id, True, session)


@router.put("/regioes/{id}/desativar",
           response_model=Dict[str, bool],
           tags=["Regiões"],
           summary="Desativa região")
async def desativar_regiao(
    id: int,
    session: Session = Depends(get_session)
):
    """Desativa região específica."""
    return await _alterar_status_regiao(id, False, session)


async def _alterar_status_regiao(id: int, ativo: bool, session: Session) -> Dict[str, bool]:
    """Helper para alterar status da região."""
    try:
        regiao = session.query(Regiao).filter(Regiao.IDRegiao == id).first()

        if not regiao:
            raise HTTPException(status_code=404, detail="Região não encontrada")

        regiao.Ativo = ativo
        session.commit()

        logger.info(f"Região {id} {'ativada' if ativo else 'desativada'}")

        return {"sucesso": True}

    except HTTPException:
        raise
    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao alterar status da região {id}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - CORRELAÇÕES ====================

@router.get("/correlacoes",
           response_model=List[CorrelacaoResponse],
           tags=["Correlações"],
           summary="Lista correlações")
async def get_correlacoes(
    tipo_evento: Optional[str] = Query(None, description="Filtrar por tipo de evento"),
    origem: Optional[str] = Query(None, description="Filtrar por origem"),
    session: Session = Depends(get_session)
):
    """Lista correlações com filtros opcionais."""
    try:
        query = session.query(Correlacao)

        if tipo_evento:
            query = query.filter(Correlacao.TipoEvento == tipo_evento.upper())

        if origem:
            query = query.filter(Correlacao.Origem == origem.upper())

        correlacoes = query.order_by(Correlacao.TipoEvento, desc(Correlacao.Confianca)).all()

        return [CorrelacaoResponse.model_validate(correlacao) for correlacao in correlacoes]

    except Exception as e:
        logger.error(f"Erro ao buscar correlações: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/correlacoes",
            response_model=Dict[str, int],
            tags=["Correlações"],
            summary="Cria correlação manual")
async def criar_correlacao(
    correlacao_data: CriarCorrelacaoRequest,
    session: Session = Depends(get_session)
):
    """Cria nova correlação manual."""
    try:
        correlacao = Correlacao(
            TipoEvento=correlacao_data.tipo_evento.upper(),
            IDGrupo=correlacao_data.id_grupo,
            IDCateg=correlacao_data.id_categ,
            IDProd=correlacao_data.id_prod,
            PercImpac=correlacao_data.perc_impac,
            DiasAntes=correlacao_data.dias_antes,
            DiasDurac=correlacao_data.dias_durac,
            Confianca=correlacao_data.confianca,
            Origem='MANUAL'
        )

        session.add(correlacao)
        session.commit()
        session.refresh(correlacao)

        logger.info(f"Correlação criada: {correlacao.IDCorrel}")

        return {"id": correlacao.IDCorrel}

    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao criar correlação: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.delete("/correlacoes/{id}",
              response_model=Dict[str, bool],
              tags=["Correlações"],
              summary="Remove correlação")
async def remover_correlacao(
    id: int,
    session: Session = Depends(get_session)
):
    """Remove correlação específica."""
    try:
        correlacao = session.query(Correlacao).filter(Correlacao.IDCorrel == id).first()

        if not correlacao:
            raise HTTPException(status_code=404, detail="Correlação não encontrada")

        session.delete(correlacao)
        session.commit()

        logger.info(f"Correlação removida: {id}")

        return {"sucesso": True}

    except HTTPException:
        raise
    except Exception as e:
        session.rollback()
        logger.error(f"Erro ao remover correlação {id}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== SCHEMAS PYDANTIC - FORECAST ====================

class ForecastRequest(BaseModel):
    dias_cobertura: int = 30
    dias_historico: int = 90
    tempo_reposicao: int = 3


class ForecastResponse(BaseModel):
    id_prod: int
    id_filial: int
    consumo_medio_diario: float
    estoque_atual: float
    estoque_seguranca: float
    ponto_pedido: float
    dias_cobertura: float
    cen_otimista: float
    cen_conservador: float
    cen_critico: float
    risco_ruptura: float
    confianca: float
    qualidade_dados: str
    fator_ajuste: float
    alertas: List[str]
    tendencia: Optional[str] = None


class ResumoFilialResponse(BaseModel):
    total_produtos: int
    com_forecast_ativo: int
    abaixo_ponto_pedido: int
    risco_ruptura_alto: int
    sem_giro: int
    qualidade_dados: dict


# ==================== ENDPOINTS - FORECAST ====================

@router.get("/forecast/produto/{id_prod}",
            response_model=ForecastResponse,
            tags=["Forecast"],
            summary="Obtém forecast de um produto")
async def obter_forecast_produto(
    id_prod: int,
    id_filial: int,
    id_regiao: Optional[int] = None,
    recalcular: bool = False,
    db: DatabaseManager = Depends(get_database)
):
    """
    Obtém forecast para um produto específico.

    - Se existir forecast ativo em cache, retorna ele
    - Se recalcular=True ou não existir, calcula novo
    """
    try:
        if not FORECAST_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de forecast não disponível")

        engine = ForecastEngine(db)

        if recalcular:
            resultado = engine.gerar_forecast(id_prod, id_filial, id_regiao)
        else:
            resultado = engine.obter_forecast(id_prod, id_filial)
            if not resultado:
                resultado = engine.gerar_forecast(id_prod, id_filial, id_regiao)

        if isinstance(resultado, dict):
            return resultado

        m = resultado.metricas
        return ForecastResponse(
            id_prod=m.id_prod,
            id_filial=m.id_filial,
            consumo_medio_diario=m.consumo_medio_diario,
            estoque_atual=m.estoque_atual,
            estoque_seguranca=m.estoque_seguranca,
            ponto_pedido=m.ponto_pedido,
            dias_cobertura=m.dias_cobertura,
            cen_otimista=m.cen_otimista,
            cen_conservador=m.cen_conservador,
            cen_critico=m.cen_critico,
            risco_ruptura=m.risco_ruptura,
            confianca=resultado.confianca,
            qualidade_dados=resultado.qualidade_dados,
            fator_ajuste=resultado.fator_ajuste,
            alertas=resultado.alertas,
            tendencia=m.tendencia
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter forecast produto {id_prod}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/forecast/filial/{id_filial}",
            tags=["Forecast"],
            summary="Lista forecasts de uma filial")
async def listar_forecast_filial(
    id_filial: int,
    id_regiao: Optional[int] = None,
    apenas_criticos: bool = False,
    id_grupo: Optional[int] = None,
    ordem: str = "risco",
    limite: int = 100,
    db: DatabaseManager = Depends(get_database)
):
    """
    Lista forecasts de uma filial.

    - apenas_criticos: só retorna produtos abaixo do ponto de pedido
    - ordem: 'risco' (maior risco primeiro) ou 'produto'
    """
    try:
        if not FORECAST_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de forecast não disponível")

        repositorio = ForecastRepositorio(db)

        forecasts = repositorio.listar_filial(
            id_filial=id_filial,
            apenas_ativos=True,
            apenas_criticos=apenas_criticos,
            id_grupo=id_grupo,
            ordem=ordem,
            limite=limite
        )

        return forecasts

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar forecast filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/forecast/filial/{id_filial}/calcular",
             tags=["Forecast"],
             summary="Calcula forecast para filial")
async def calcular_forecast_filial(
    id_filial: int,
    id_regiao: Optional[int] = None,
    apenas_criticos: bool = True,
    limite: int = 100,
    db: DatabaseManager = Depends(get_database)
):
    """
    Calcula (ou recalcula) forecast para produtos de uma filial.

    - apenas_criticos=True: processa só produtos com estoque baixo
    """
    try:
        if not FORECAST_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de forecast não disponível")

        engine = ForecastEngine(db)

        resultados = engine.gerar_forecast_filial(
            id_filial=id_filial,
            id_regiao=id_regiao,
            apenas_criticos=apenas_criticos,
            limite=limite,
            salvar=True
        )

        return {
            "sucesso": True,
            "processados": len(resultados),
            "com_risco_alto": sum(1 for r in resultados if r.metricas.risco_ruptura > 0.3)
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao calcular forecast filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/forecast/filial/{id_filial}/resumo",
            response_model=ResumoFilialResponse,
            tags=["Forecast"],
            summary="Resumo estatístico da filial")
async def resumo_forecast_filial(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna resumo estatístico dos forecasts da filial.
    """
    try:
        if not FORECAST_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de forecast não disponível")

        repositorio = ForecastRepositorio(db)
        return repositorio.resumo_filial(id_filial)

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter resumo filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/forecast/historico/{id_prod}",
            tags=["Forecast"],
            summary="Histórico de vendas para análise")
async def historico_vendas_produto(
    id_prod: int,
    id_filial: int,
    dias: int = 90,
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna histórico de vendas e análises de um produto.
    """
    try:
        from .processadores.series_temporais import AnalisadorSeriesTemporal
        from .processadores.sazonalidade import DetectorSazonalidade

        analisador = AnalisadorSeriesTemporal(db)
        detector = DetectorSazonalidade()

        analise = analisador.analisar(id_prod, id_filial, dias)
        sazonalidade = detector.analisar(analise['historico'])

        return {
            "vendas_diarias": analise['historico'].to_dict('records') if not analise['historico'].empty else [],
            "estatisticas": analise['estatisticas'],
            "tendencia": analise['tendencia'],
            "distribuicao": analise['distribuicao'],
            "sazonalidade": sazonalidade,
            "qualidade_dados": analise['qualidade_dados'],
            "dias_analisados": analise['dias_analisados']
        }

    except Exception as e:
        logger.error(f"Erro ao obter histórico produto {id_prod}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/forecast/expirar",
             tags=["Forecast"],
             summary="Marca forecasts expirados")
async def marcar_expirados(
    db: DatabaseManager = Depends(get_database)
):
    """
    Marca como EXPIRADO forecasts cuja data de validade passou.
    Normalmente executado pelo job diário.
    """
    try:
        if not FORECAST_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de forecast não disponível")

        repositorio = ForecastRepositorio(db)
        count = repositorio.marcar_expirados()

        return {"expirados": count}

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao marcar expirados: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== SCHEMAS PYDANTIC - CLASSIFICAÇÃO ====================

class ClassificacaoResponse(BaseModel):
    """Resposta de classificação de um produto."""
    id_prod: int
    id_filial: int
    classificacao: str
    score_geral: float
    curva_abc: str
    score_giro: float
    classe_giro: str
    dias_cobertura: float
    score_margem: float
    classe_margem: str
    margem_media: float
    score_regularidade: float
    coef_variacao: float
    score_vencimento: float
    risco_vencimento: str
    dias_para_vencer: int
    score_tendencia: float
    tendencia: str
    alertas: List[str] = []
    recomendacoes: List[str] = []
    data_calculo: datetime

    class Config:
        from_attributes = True


class ResumoClassificacaoResponse(BaseModel):
    """Resumo estatístico de classificação da filial."""
    total_produtos: int
    saudaveis: int
    atencao: int
    toxicos: int
    perc_saudaveis: float
    perc_atencao: float
    perc_toxicos: float
    por_curva: Dict[str, int]
    por_risco_vencimento: Dict[str, int]
    data_atualizacao: Optional[datetime] = None


class CurvaABCResponse(BaseModel):
    """Resposta de análise de Curva ABC."""
    id_prod: int
    faturamento: float
    perc_faturamento: float
    perc_acumulado: float
    curva_abc: str
    rank: int


class CurvaABCResumoResponse(BaseModel):
    """Resumo da Curva ABC da filial."""
    total_produtos: int
    faturamento_total: float
    curva_a: Dict[str, Any]
    curva_b: Dict[str, Any]
    curva_c: Dict[str, Any]
    curva_d: Dict[str, Any]


# ==================== SCHEMAS PYDANTIC - FORNECEDOR ====================

class MetricasPrecoResponse(BaseModel):
    """Métricas de preço do fornecedor."""
    variacao_vs_mercado: float = 0
    reajuste_anual: float = 0
    desconto_medio: float = 0
    total_produtos: int = 0
    score: float = 0


class MetricasEntregaResponse(BaseModel):
    """Métricas de entrega do fornecedor."""
    lead_time_medio: float = 0
    pontualidade_perc: float = 0
    atraso_medio_dias: float = 0
    total_pedidos: int = 0
    pedidos_atraso: int = 0
    score: float = 0


class MetricasQualidadeResponse(BaseModel):
    """Métricas de qualidade do fornecedor."""
    taxa_devolucao: float = 0
    taxa_avaria: float = 0
    problemas_validade: int = 0
    total_itens_recebidos: int = 0
    itens_devolvidos: int = 0
    score: float = 0


class MetricasComercialResponse(BaseModel):
    """Métricas comerciais do fornecedor."""
    prazo_medio_pgto: float = 0
    pedido_minimo: float = 0
    tem_bonificacao: bool = False
    tem_rebate: bool = False
    flex_pedido: bool = False
    score: float = 0


class FornecedorScoreResponse(BaseModel):
    """Resposta completa de score do fornecedor."""
    cnpj: str
    nome: str
    id_filial: int
    score_geral: float
    classificacao: str
    ranking: Optional[int] = None
    score_preco: float
    score_entrega: float
    score_qualidade: float
    score_comercial: float
    metricas_preco: MetricasPrecoResponse
    metricas_entrega: MetricasEntregaResponse
    metricas_qualidade: MetricasQualidadeResponse
    metricas_comercial: MetricasComercialResponse
    vlr_compras_12m: float = 0
    qtd_produtos: int = 0
    perc_part_compras: float = 0
    exclusividades: int = 0
    tendencia: str
    score_anterior: Optional[float] = None
    var_score: Optional[float] = None
    alertas: List[str] = []
    recomendacoes: List[str] = []
    data_calculo: datetime
    periodo_analise: int = 180

    class Config:
        from_attributes = True


class ResumoFornecedorFilialResponse(BaseModel):
    """Resumo estatístico de fornecedores da filial."""
    total_fornecedores: int
    excelentes: int
    bons: int
    regulares: int
    ruins: int
    criticos: int
    perc_excelentes: float
    perc_bons: float
    perc_regulares: float
    perc_ruins: float
    perc_criticos: float
    score_medio: float
    score_preco_medio: float
    score_entrega_medio: float
    score_qualidade_medio: float
    score_comercial_medio: float
    ultima_atualizacao: Optional[datetime] = None


class RankingFornecedorResponse(BaseModel):
    """Item do ranking de fornecedores."""
    ranking: int
    cnpj: str
    nome: str
    score_geral: float
    classificacao: str
    score_preco: float
    score_entrega: float
    score_qualidade: float
    score_comercial: float
    vlr_compras_12m: float
    tendencia: str


class FornecedorCriticoResponse(BaseModel):
    """Fornecedor crítico com alertas."""
    cnpj: str
    nome: str
    score_geral: float
    classificacao: str
    score_preco: float
    score_entrega: float
    score_qualidade: float
    score_comercial: float
    alertas: List[str] = []
    recomendacoes: List[str] = []


class HistoricoScoreResponse(BaseModel):
    """Item do histórico de scores."""
    mes: str
    score_geral: float
    classificacao: str
    score_preco: float
    score_entrega: float
    score_qualidade: float
    score_comercial: float


# ==================== ENDPOINTS - CLASSIFICAÇÃO ====================

@router.get("/classificacao/produto/{id_prod}",
            response_model=ClassificacaoResponse,
            tags=["Classificação"],
            summary="Obtém classificação de um produto")
async def obter_classificacao_produto(
    id_prod: int,
    id_filial: int,
    recalcular: bool = False,
    db: DatabaseManager = Depends(get_database)
):
    """
    Obtém classificação para um produto específico.

    - Se existir classificação ativa em cache, retorna ela
    - Se recalcular=True ou não existir, calcula nova
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        repositorio = ClassificacaoRepositorio(db)

        if not recalcular:
            existente = await repositorio.buscar(id_prod, id_filial)
            if existente:
                return ClassificacaoResponse(
                    id_prod=existente['IDProd'],
                    id_filial=existente['IDFilial'],
                    classificacao=existente['Classif'],
                    score_geral=existente['ScoreGeral'],
                    curva_abc=existente['CurvaABC'],
                    score_giro=existente['ScoreGiro'],
                    classe_giro=existente['ClassGiro'],
                    dias_cobertura=existente['DiasCobert'],
                    score_margem=existente['ScoreMargem'],
                    classe_margem=existente['ClassMargem'],
                    margem_media=existente['MargemMedia'],
                    score_regularidade=existente['ScoreRegul'],
                    coef_variacao=existente['CoefVariac'],
                    score_vencimento=existente['ScoreVenc'],
                    risco_vencimento=existente['RiscoVenc'],
                    dias_para_vencer=existente['DiasVencer'],
                    score_tendencia=existente['ScoreTend'],
                    tendencia=existente['Tendencia'],
                    alertas=existente.get('AlertaJSON', []) or [],
                    recomendacoes=existente.get('RecomendJSON', []) or [],
                    data_calculo=existente['DatCalculo']
                )

        # Calcula nova classificação
        classificador = ClassificadorProdutos(db)
        resultado = await classificador.classificar_produto(id_prod, id_filial)

        # Salva no repositório
        await repositorio.salvar(resultado)

        return ClassificacaoResponse(
            id_prod=resultado.id_prod,
            id_filial=resultado.id_filial,
            classificacao=resultado.classificacao.value,
            score_geral=resultado.score_geral,
            curva_abc=resultado.curva_abc.value,
            score_giro=resultado.score_giro,
            classe_giro=resultado.classe_giro.value,
            dias_cobertura=resultado.dias_cobertura,
            score_margem=resultado.score_margem,
            classe_margem=resultado.classe_margem.value,
            margem_media=resultado.margem_media,
            score_regularidade=resultado.score_regularidade,
            coef_variacao=resultado.coef_variacao,
            score_vencimento=resultado.score_vencimento,
            risco_vencimento=resultado.risco_vencimento.value,
            dias_para_vencer=resultado.dias_para_vencer,
            score_tendencia=resultado.score_tendencia,
            tendencia=resultado.tendencia.value,
            alertas=resultado.alertas,
            recomendacoes=resultado.recomendacoes,
            data_calculo=resultado.data_calculo
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter classificação produto {id_prod}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/classificacao/filial/{id_filial}",
            tags=["Classificação"],
            summary="Lista classificações de uma filial")
async def listar_classificacao_filial(
    id_filial: int,
    classificacao: Optional[str] = Query(None, description="Filtrar por classificação (SAUDAVEL/ATENCAO/TOXICO)"),
    curva_abc: Optional[str] = Query(None, description="Filtrar por curva ABC"),
    ordem: str = Query("score", description="Ordenação: score, produto, classificacao"),
    limite: int = Query(100, ge=1, le=1000),
    db: DatabaseManager = Depends(get_database)
):
    """
    Lista classificações de uma filial com filtros.
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        repositorio = ClassificacaoRepositorio(db)

        resultados = await repositorio.buscar_por_filial(
            id_filial=id_filial,
            classificacao=classificacao,
            curva_abc=curva_abc,
            ordem=ordem,
            limite=limite
        )

        return resultados

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar classificação filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/classificacao/filial/{id_filial}/calcular",
             tags=["Classificação"],
             summary="Calcula classificação para filial")
async def calcular_classificacao_filial(
    id_filial: int,
    apenas_ativos: bool = Query(True, description="Processar apenas produtos ativos"),
    limite: int = Query(500, ge=1, le=5000, description="Limite de produtos"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Calcula (ou recalcula) classificação para produtos de uma filial.
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        classificador = ClassificadorProdutos(db)
        repositorio = ClassificacaoRepositorio(db)

        # Classifica todos os produtos
        resultados = await classificador.classificar_filial(
            id_filial=id_filial,
            apenas_ativos=apenas_ativos,
            limite=limite
        )

        # Salva em lote
        salvos = await repositorio.salvar_lote(resultados)

        # Contabiliza
        saudaveis = sum(1 for r in resultados if r.classificacao.value == 'SAUDAVEL')
        atencao = sum(1 for r in resultados if r.classificacao.value == 'ATENCAO')
        toxicos = sum(1 for r in resultados if r.classificacao.value == 'TOXICO')

        return {
            "sucesso": True,
            "processados": len(resultados),
            "salvos": salvos,
            "saudaveis": saudaveis,
            "atencao": atencao,
            "toxicos": toxicos
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao calcular classificação filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/classificacao/filial/{id_filial}/resumo",
            response_model=ResumoClassificacaoResponse,
            tags=["Classificação"],
            summary="Resumo estatístico da classificação da filial")
async def resumo_classificacao_filial(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna resumo estatístico das classificações da filial.
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        repositorio = ClassificacaoRepositorio(db)
        resumo = await repositorio.obter_resumo(id_filial)

        return ResumoClassificacaoResponse(
            total_produtos=resumo['total_produtos'],
            saudaveis=resumo['saudaveis'],
            atencao=resumo['atencao'],
            toxicos=resumo['toxicos'],
            perc_saudaveis=resumo['perc_saudaveis'],
            perc_atencao=resumo['perc_atencao'],
            perc_toxicos=resumo['perc_toxicos'],
            por_curva=resumo['por_curva'],
            por_risco_vencimento=resumo['por_risco_vencimento'],
            data_atualizacao=resumo.get('data_atualizacao')
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter resumo classificação filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/classificacao/filial/{id_filial}/toxicos",
            tags=["Classificação"],
            summary="Lista produtos tóxicos da filial")
async def listar_toxicos_filial(
    id_filial: int,
    limite: int = Query(100, ge=1, le=500),
    db: DatabaseManager = Depends(get_database)
):
    """
    Lista produtos classificados como TÓXICOS da filial.
    Ordenados por score (piores primeiro).
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        repositorio = ClassificacaoRepositorio(db)

        resultados = await repositorio.buscar_por_filial(
            id_filial=id_filial,
            classificacao='TOXICO',
            ordem='score',
            limite=limite
        )

        return resultados

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar tóxicos filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/classificacao/filial/{id_filial}/bloqueados",
            tags=["Classificação"],
            summary="Lista produtos bloqueados por classificação")
async def listar_bloqueados_filial(
    id_filial: int,
    limite: int = Query(100, ge=1, le=500),
    db: DatabaseManager = Depends(get_database)
):
    """
    Lista produtos que foram bloqueados para compra por classificação TÓXICA.
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        repositorio = ClassificacaoRepositorio(db)

        resultados = await repositorio.buscar_por_filial(
            id_filial=id_filial,
            classificacao='TOXICO',
            apenas_bloqueados=True,
            ordem='score',
            limite=limite
        )

        return resultados

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar bloqueados filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/classificacao/curva-abc/{id_filial}",
            response_model=CurvaABCResumoResponse,
            tags=["Classificação"],
            summary="Obtém resumo da Curva ABC da filial")
async def obter_curva_abc_filial(
    id_filial: int,
    dias: int = Query(90, ge=30, le=365, description="Dias de histórico"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna resumo da Curva ABC (Pareto) da filial.
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        analisador = AnalisadorCurvaABC(db)
        resumo = analisador.resumo_curva_filial(id_filial, dias)

        return CurvaABCResumoResponse(
            total_produtos=resumo['total_produtos'],
            faturamento_total=resumo['faturamento_total'],
            curva_a=resumo['curva_a'],
            curva_b=resumo['curva_b'],
            curva_c=resumo['curva_c'],
            curva_d=resumo['curva_d']
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter curva ABC filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/classificacao/curva-abc/{id_filial}/detalhes",
            tags=["Classificação"],
            summary="Lista detalhes da Curva ABC da filial")
async def detalhar_curva_abc_filial(
    id_filial: int,
    curva: Optional[str] = Query(None, description="Filtrar por curva (A/B/C/D)"),
    dias: int = Query(90, ge=30, le=365),
    limite: int = Query(100, ge=1, le=1000),
    db: DatabaseManager = Depends(get_database)
):
    """
    Lista produtos da Curva ABC com detalhes.
    """
    try:
        if not CLASSIFICACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de classificação não disponível")

        analisador = AnalisadorCurvaABC(db)
        df = analisador.calcular_curva_filial(id_filial, dias)

        if df.empty:
            return []

        # Filtra por curva se especificado
        if curva:
            df = df[df['curva_abc'] == curva.upper()]

        # Limita resultados
        df = df.head(limite)

        # Converte para lista de dicionários
        resultados = []
        for _, row in df.iterrows():
            resultados.append(CurvaABCResponse(
                id_prod=int(row['IDProd']),
                faturamento=float(row['faturamento']),
                perc_faturamento=float(row['perc_faturamento']) * 100,
                perc_acumulado=float(row['perc_acumulado']) * 100,
                curva_abc=row['curva_abc'],
                rank=int(row['rank'])
            ))

        return resultados

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao detalhar curva ABC filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - FORNECEDOR ====================

@router.get("/fornecedor/{cnpj}",
            response_model=FornecedorScoreResponse,
            tags=["Fornecedor"],
            summary="Obtém score de um fornecedor")
async def obter_score_fornecedor(
    cnpj: str,
    id_filial: int,
    recalcular: bool = False,
    db: DatabaseManager = Depends(get_database)
):
    """
    Obtém score completo de um fornecedor.

    - Se existir score ativo em cache, retorna ele
    - Se recalcular=True ou não existir, calcula novo
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        repositorio = FornecedorScoreRepositorio(db)

        if not recalcular:
            existente = await repositorio.buscar(cnpj, id_filial)
            if existente:
                return _converter_registro_para_response(existente)

        # Calcula novo score
        analisador = AnalisadorFornecedor(db)
        resultado = analisador.analisar(cnpj, id_filial)

        # Salva no repositório
        await repositorio.salvar(resultado)

        return _converter_resultado_para_response(resultado)

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter score fornecedor {cnpj}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/filial/{id_filial}",
            tags=["Fornecedor"],
            summary="Lista fornecedores de uma filial")
async def listar_fornecedores_filial(
    id_filial: int,
    classificacao: Optional[str] = Query(None, description="Filtrar por classificação"),
    ordem: str = Query("score", description="Ordenação: score, nome, volume"),
    limite: int = Query(100, ge=1, le=500),
    db: DatabaseManager = Depends(get_database)
):
    """
    Lista fornecedores de uma filial com filtros.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        repositorio = FornecedorScoreRepositorio(db)

        resultados = await repositorio.buscar_por_filial(
            id_filial=id_filial,
            classificacao=classificacao,
            ordem=ordem,
            limite=limite
        )

        return resultados

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar fornecedores filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/fornecedor/filial/{id_filial}/calcular",
             tags=["Fornecedor"],
             summary="Calcula scores para fornecedores da filial")
async def calcular_scores_filial(
    id_filial: int,
    dias: int = Query(180, ge=30, le=365, description="Período de análise em dias"),
    limite: int = Query(100, ge=1, le=500, description="Limite de fornecedores"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Calcula (ou recalcula) scores para todos os fornecedores de uma filial.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        analisador = AnalisadorFornecedor(db)
        repositorio = FornecedorScoreRepositorio(db)

        # Busca fornecedores ativos da filial
        fornecedores = analisador.listar_fornecedores_ativos(id_filial, dias, limite)

        resultados = []
        erros = []

        for forn in fornecedores:
            try:
                resultado = analisador.analisar(forn['cnpj'], id_filial, dias)
                await repositorio.salvar(resultado)
                resultados.append(resultado)
            except Exception as e:
                erros.append(f"{forn['cnpj']}: {str(e)}")
                logger.warning(f"Erro ao analisar fornecedor {forn['cnpj']}: {e}")

        # Contabiliza
        excelentes = sum(1 for r in resultados if r.classificacao.value == 'EXCELENTE')
        bons = sum(1 for r in resultados if r.classificacao.value == 'BOM')
        regulares = sum(1 for r in resultados if r.classificacao.value == 'REGULAR')
        ruins = sum(1 for r in resultados if r.classificacao.value == 'RUIM')
        criticos = sum(1 for r in resultados if r.classificacao.value == 'CRITICO')

        return {
            "sucesso": True,
            "processados": len(resultados),
            "excelentes": excelentes,
            "bons": bons,
            "regulares": regulares,
            "ruins": ruins,
            "criticos": criticos,
            "erros": erros[:10] if erros else []
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao calcular scores filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/filial/{id_filial}/resumo",
            response_model=ResumoFornecedorFilialResponse,
            tags=["Fornecedor"],
            summary="Resumo estatístico de fornecedores da filial")
async def resumo_fornecedores_filial(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna resumo estatístico dos scores de fornecedores da filial.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        repositorio = FornecedorScoreRepositorio(db)
        resumo = await repositorio.obter_resumo(id_filial)

        return ResumoFornecedorFilialResponse(**resumo)

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter resumo fornecedores filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/filial/{id_filial}/ranking",
            response_model=List[RankingFornecedorResponse],
            tags=["Fornecedor"],
            summary="Ranking de melhores fornecedores")
async def ranking_fornecedores_filial(
    id_filial: int,
    top: int = Query(10, ge=1, le=50, description="Quantidade no ranking"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna ranking dos melhores fornecedores da filial.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        repositorio = FornecedorScoreRepositorio(db)
        ranking = await repositorio.ranking(id_filial, top)

        return [
            RankingFornecedorResponse(
                ranking=r['ranking'],
                cnpj=r['CNPJForn'],
                nome=r['NomeForn'],
                score_geral=float(r['ScoreGeral']),
                classificacao=r['Classificacao'],
                score_preco=float(r['ScorePreco']),
                score_entrega=float(r['ScoreEntrega']),
                score_qualidade=float(r['ScoreQualidade']),
                score_comercial=float(r['ScoreComercial']),
                vlr_compras_12m=float(r['VlrCompras12m'] or 0),
                tendencia=r['Tendencia']
            )
            for r in ranking
        ]

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter ranking fornecedores filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/filial/{id_filial}/criticos",
            response_model=List[FornecedorCriticoResponse],
            tags=["Fornecedor"],
            summary="Lista fornecedores críticos")
async def fornecedores_criticos_filial(
    id_filial: int,
    limite: int = Query(20, ge=1, le=100),
    db: DatabaseManager = Depends(get_database)
):
    """
    Lista fornecedores classificados como CRÍTICO ou RUIM.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        repositorio = FornecedorScoreRepositorio(db)
        criticos = await repositorio.fornecedores_criticos(id_filial, limite)

        return [
            FornecedorCriticoResponse(
                cnpj=r['CNPJForn'],
                nome=r['NomeForn'],
                score_geral=float(r['ScoreGeral']),
                classificacao=r['Classificacao'],
                score_preco=float(r['ScorePreco']),
                score_entrega=float(r['ScoreEntrega']),
                score_qualidade=float(r['ScoreQualidade']),
                score_comercial=float(r['ScoreComercial']),
                alertas=r.get('AlertasJSON', []) or [],
                recomendacoes=r.get('RecomendJSON', []) or []
            )
            for r in criticos
        ]

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar fornecedores críticos filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/{cnpj}/historico",
            response_model=List[HistoricoScoreResponse],
            tags=["Fornecedor"],
            summary="Histórico de scores do fornecedor")
async def historico_score_fornecedor(
    cnpj: str,
    id_filial: int,
    meses: int = Query(12, ge=1, le=24, description="Meses de histórico"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna histórico mensal de scores do fornecedor.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        repositorio = FornecedorScoreRepositorio(db)
        historico = await repositorio.historico_score(cnpj, id_filial, meses)

        return [
            HistoricoScoreResponse(
                mes=r['mes'],
                score_geral=float(r['ScoreGeral']),
                classificacao=r['Classificacao'],
                score_preco=float(r['ScorePreco']),
                score_entrega=float(r['ScoreEntrega']),
                score_qualidade=float(r['ScoreQualidade']),
                score_comercial=float(r['ScoreComercial'])
            )
            for r in historico
        ]

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter histórico fornecedor {cnpj}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/{cnpj}/preco",
            response_model=MetricasPrecoResponse,
            tags=["Fornecedor"],
            summary="Análise de preço do fornecedor")
async def analise_preco_fornecedor(
    cnpj: str,
    id_filial: int,
    dias: int = Query(180, ge=30, le=365),
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna análise detalhada de preços do fornecedor.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        analisador = AnalisadorPrecoFornecedor(db)
        metricas = analisador.analisar(cnpj, id_filial, dias)

        return MetricasPrecoResponse(
            variacao_vs_mercado=metricas.variacao_vs_mercado,
            reajuste_anual=metricas.reajuste_anual,
            desconto_medio=metricas.desconto_medio,
            total_produtos=metricas.total_produtos,
            score=metricas.score
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao analisar preço fornecedor {cnpj}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/{cnpj}/entrega",
            response_model=MetricasEntregaResponse,
            tags=["Fornecedor"],
            summary="Análise de entrega do fornecedor")
async def analise_entrega_fornecedor(
    cnpj: str,
    id_filial: int,
    dias: int = Query(180, ge=30, le=365),
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna análise detalhada de entregas do fornecedor.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        analisador = AnalisadorEntregaFornecedor(db)
        metricas = analisador.analisar(cnpj, id_filial, dias)

        return MetricasEntregaResponse(
            lead_time_medio=metricas.lead_time_medio,
            pontualidade_perc=metricas.pontualidade_perc,
            atraso_medio_dias=metricas.atraso_medio_dias,
            total_pedidos=metricas.total_pedidos,
            pedidos_atraso=metricas.pedidos_atraso,
            score=metricas.score
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao analisar entrega fornecedor {cnpj}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/{cnpj}/qualidade",
            response_model=MetricasQualidadeResponse,
            tags=["Fornecedor"],
            summary="Análise de qualidade do fornecedor")
async def analise_qualidade_fornecedor(
    cnpj: str,
    id_filial: int,
    dias: int = Query(180, ge=30, le=365),
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna análise detalhada de qualidade do fornecedor.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        analisador = AnalisadorQualidadeFornecedor(db)
        metricas = analisador.analisar(cnpj, id_filial, dias)

        return MetricasQualidadeResponse(
            taxa_devolucao=metricas.taxa_devolucao,
            taxa_avaria=metricas.taxa_avaria,
            problemas_validade=metricas.problemas_validade,
            total_itens_recebidos=metricas.total_itens_recebidos,
            itens_devolvidos=metricas.itens_devolvidos,
            score=metricas.score
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao analisar qualidade fornecedor {cnpj}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedor/{cnpj}/comercial",
            response_model=MetricasComercialResponse,
            tags=["Fornecedor"],
            summary="Análise comercial do fornecedor")
async def analise_comercial_fornecedor(
    cnpj: str,
    id_filial: int,
    dias: int = Query(180, ge=30, le=365),
    db: DatabaseManager = Depends(get_database)
):
    """
    Retorna análise detalhada de condições comerciais do fornecedor.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        analisador = AnalisadorComercialFornecedor(db)
        metricas = analisador.analisar(cnpj, id_filial, dias)

        return MetricasComercialResponse(
            prazo_medio_pgto=metricas.prazo_medio_pgto,
            pedido_minimo=metricas.pedido_minimo,
            tem_bonificacao=metricas.tem_bonificacao,
            tem_rebate=metricas.tem_rebate,
            flex_pedido=metricas.flex_pedido,
            score=metricas.score
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao analisar comercial fornecedor {cnpj}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/fornecedor/expirar",
             tags=["Fornecedor"],
             summary="Marca scores expirados")
async def marcar_scores_expirados(
    db: DatabaseManager = Depends(get_database)
):
    """
    Marca como EXPIRADO scores cuja data de validade passou.
    Normalmente executado pelo job diário.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        repositorio = FornecedorScoreRepositorio(db)
        count = await repositorio.marcar_expirados()

        return {"expirados": count}

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao marcar scores expirados: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== HELPERS - FORNECEDOR ====================

def _converter_resultado_para_response(resultado) -> FornecedorScoreResponse:
    """Converte ResultadoScoreFornecedor para FornecedorScoreResponse."""
    return FornecedorScoreResponse(
        cnpj=resultado.cnpj,
        nome=resultado.nome,
        id_filial=resultado.id_filial,
        score_geral=resultado.score_geral,
        classificacao=resultado.classificacao.value,
        ranking=resultado.ranking,
        score_preco=resultado.score_preco,
        score_entrega=resultado.score_entrega,
        score_qualidade=resultado.score_qualidade,
        score_comercial=resultado.score_comercial,
        metricas_preco=MetricasPrecoResponse(
            variacao_vs_mercado=resultado.metricas_preco.variacao_vs_mercado,
            reajuste_anual=resultado.metricas_preco.reajuste_anual,
            desconto_medio=resultado.metricas_preco.desconto_medio,
            total_produtos=resultado.metricas_preco.total_produtos,
            score=resultado.metricas_preco.score
        ),
        metricas_entrega=MetricasEntregaResponse(
            lead_time_medio=resultado.metricas_entrega.lead_time_medio,
            pontualidade_perc=resultado.metricas_entrega.pontualidade_perc,
            atraso_medio_dias=resultado.metricas_entrega.atraso_medio_dias,
            total_pedidos=resultado.metricas_entrega.total_pedidos,
            pedidos_atraso=resultado.metricas_entrega.pedidos_atraso,
            score=resultado.metricas_entrega.score
        ),
        metricas_qualidade=MetricasQualidadeResponse(
            taxa_devolucao=resultado.metricas_qualidade.taxa_devolucao,
            taxa_avaria=resultado.metricas_qualidade.taxa_avaria,
            problemas_validade=resultado.metricas_qualidade.problemas_validade,
            total_itens_recebidos=resultado.metricas_qualidade.total_itens_recebidos,
            itens_devolvidos=resultado.metricas_qualidade.itens_devolvidos,
            score=resultado.metricas_qualidade.score
        ),
        metricas_comercial=MetricasComercialResponse(
            prazo_medio_pgto=resultado.metricas_comercial.prazo_medio_pgto,
            pedido_minimo=resultado.metricas_comercial.pedido_minimo,
            tem_bonificacao=resultado.metricas_comercial.tem_bonificacao,
            tem_rebate=resultado.metricas_comercial.tem_rebate,
            flex_pedido=resultado.metricas_comercial.flex_pedido,
            score=resultado.metricas_comercial.score
        ),
        vlr_compras_12m=resultado.vlr_compras_12m,
        qtd_produtos=resultado.qtd_produtos,
        perc_part_compras=resultado.perc_part_compras,
        exclusividades=resultado.exclusividades,
        tendencia=resultado.tendencia.value,
        score_anterior=resultado.score_anterior,
        var_score=resultado.var_score,
        alertas=resultado.alertas,
        recomendacoes=resultado.recomendacoes,
        data_calculo=resultado.data_calculo,
        periodo_analise=resultado.periodo_analise
    )


def _converter_registro_para_response(registro: Dict) -> FornecedorScoreResponse:
    """Converte registro do banco para FornecedorScoreResponse."""
    return FornecedorScoreResponse(
        cnpj=registro['CNPJForn'],
        nome=registro['NomeForn'],
        id_filial=registro['IDFilial'],
        score_geral=float(registro['ScoreGeral']),
        classificacao=registro['Classificacao'],
        ranking=registro.get('Ranking'),
        score_preco=float(registro['ScorePreco']),
        score_entrega=float(registro['ScoreEntrega']),
        score_qualidade=float(registro['ScoreQualidade']),
        score_comercial=float(registro['ScoreComercial']),
        metricas_preco=MetricasPrecoResponse(
            variacao_vs_mercado=float(registro.get('PrecoMedioVar') or 0),
            reajuste_anual=float(registro.get('ReajusteAnual') or 0),
            desconto_medio=float(registro.get('DescontoMedio') or 0),
            score=float(registro['ScorePreco'])
        ),
        metricas_entrega=MetricasEntregaResponse(
            lead_time_medio=float(registro.get('LeadTimeMedio') or 0),
            pontualidade_perc=float(registro.get('PontualidadePerc') or 0),
            atraso_medio_dias=float(registro.get('AtrasoMedioDias') or 0),
            total_pedidos=int(registro.get('TotalPedidos') or 0),
            pedidos_atraso=int(registro.get('PedidosAtraso') or 0),
            score=float(registro['ScoreEntrega'])
        ),
        metricas_qualidade=MetricasQualidadeResponse(
            taxa_devolucao=float(registro.get('TaxaDevolucao') or 0),
            taxa_avaria=float(registro.get('TaxaAvaria') or 0),
            problemas_validade=int(registro.get('ProblemaValid') or 0),
            total_itens_recebidos=int(registro.get('TotalItensRec') or 0),
            itens_devolvidos=int(registro.get('ItensDevolvidos') or 0),
            score=float(registro['ScoreQualidade'])
        ),
        metricas_comercial=MetricasComercialResponse(
            prazo_medio_pgto=float(registro.get('PrazoMedioPgto') or 0),
            pedido_minimo=float(registro.get('PedidoMinimo') or 0),
            tem_bonificacao=bool(registro.get('TemBonificacao')),
            tem_rebate=bool(registro.get('TemRebate')),
            flex_pedido=bool(registro.get('FlexPedido')),
            score=float(registro['ScoreComercial'])
        ),
        vlr_compras_12m=float(registro.get('VlrCompras12m') or 0),
        qtd_produtos=int(registro.get('QtdProdutos') or 0),
        perc_part_compras=float(registro.get('PercPartCompras') or 0),
        exclusividades=int(registro.get('Exclusividades') or 0),
        tendencia=registro['Tendencia'],
        score_anterior=float(registro['ScoreAnterior']) if registro.get('ScoreAnterior') else None,
        var_score=float(registro['VarScore']) if registro.get('VarScore') else None,
        alertas=registro.get('AlertasJSON', []) or [],
        recomendacoes=registro.get('RecomendJSON', []) or [],
        data_calculo=registro['DatCalculo'],
        periodo_analise=int(registro.get('PeriodoAnalise') or 180)
    )


# ==================== ENDPOINTS - RECOMENDAÇÃO DE FORNECEDOR ====================

@router.get("/fornecedores/recomendar/{id_prod}",
            tags=["Fornecedores"],
            summary="Recomenda fornecedores para um produto")
async def recomendar_fornecedor_produto(
    id_prod: int,
    id_filial: int,
    top: int = Query(3, ge=1, le=10, description="Quantidade de recomendações"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Recomenda os melhores fornecedores para um produto específico.

    Combina score do fornecedor (60%) com ranking de preço para o produto (40%).
    Retorna lista ordenada por score combinado.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        analisador = AnalisadorFornecedor(db)
        recomendacoes = analisador.recomendar_fornecedor(id_prod, id_filial, top)

        return {
            "id_prod": id_prod,
            "id_filial": id_filial,
            "total_recomendacoes": len(recomendacoes),
            "recomendacoes": recomendacoes
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao recomendar fornecedor para produto {id_prod}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/fornecedores/comparar-precos/{id_prod}",
            tags=["Fornecedores"],
            summary="Compara preços de fornecedores para um produto")
async def comparar_precos_produto(
    id_prod: int,
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """
    Compara preços de todos os fornecedores que vendem um produto específico.

    Retorna lista de fornecedores com preços, variação vs média e score geral.
    """
    try:
        if not FORNECEDOR_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de fornecedor não disponível")

        analisador = AnalisadorFornecedor(db)
        comparacao = analisador.comparar_fornecedores_produto(id_prod, id_filial)

        return {
            "id_prod": id_prod,
            "id_filial": id_filial,
            "total_fornecedores": len(comparacao),
            "fornecedores": comparacao
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao comparar preços para produto {id_prod}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - NECESSIDADES ====================

# Verificar disponibilidade do módulo de necessidades
try:
    from .processadores.necessidade import (
        GeradorNecessidade,
        NecessidadeRepositorio,
        ParametrosNecessidade,
        CenarioForecast
    )
    NECESSIDADE_AVAILABLE = True
except ImportError:
    NECESSIDADE_AVAILABLE = False
    logger.warning("Módulo de necessidades não disponível")


@router.post("/necessidades/filial/{id_filial}/gerar",
             tags=["Necessidades"],
             summary="Gera necessidades de compra")
async def gerar_necessidades_filial(
    id_filial: int,
    cenario: str = Query("CONSERVADOR", description="OTIMISTA, CONSERVADOR ou CRITICO"),
    incluir_toxicos: bool = Query(False, description="Incluir produtos tóxicos"),
    agrupar_pedidos: bool = Query(True, description="Agrupar em pedidos por fornecedor"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Gera lista de necessidades de compra para a filial.

    - cenario: OTIMISTA, CONSERVADOR ou CRITICO
    - incluir_toxicos: Incluir produtos classificados como tóxicos
    - agrupar_pedidos: Agrupar necessidades em pedidos por fornecedor
    """
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        params = ParametrosNecessidade(
            cenario_padrao=CenarioForecast(cenario),
            incluir_toxicos=incluir_toxicos,
            agrupar_por_fornecedor=agrupar_pedidos
        )

        gerador = GeradorNecessidade(db)
        resultado = gerador.gerar_necessidades(id_filial, params, salvar=True)

        return {
            "sucesso": True,
            "resumo": resultado['resumo'],
            "total_necessidades": len(resultado['necessidades']),
            "total_pedidos": len(resultado['pedidos'])
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao gerar necessidades filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/necessidades/filial/{id_filial}",
            tags=["Necessidades"],
            summary="Lista necessidades pendentes")
async def listar_necessidades(
    id_filial: int,
    prioridade: Optional[str] = Query(None, description="Filtrar por prioridade"),
    status: str = Query("PENDENTE", description="Status das necessidades"),
    limite: int = Query(100, ge=1, le=500),
    db: DatabaseManager = Depends(get_database)
):
    """Lista necessidades de compra com filtros."""
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        repositorio = NecessidadeRepositorio(db)
        return repositorio.listar_necessidades(
            id_filial=id_filial,
            status=status,
            prioridade=prioridade,
            limite=limite
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar necessidades filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/necessidades/filial/{id_filial}/resumo",
            tags=["Necessidades"],
            summary="Resumo das necessidades")
async def resumo_necessidades(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """Retorna resumo das necessidades da filial."""
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        repositorio = NecessidadeRepositorio(db)
        return repositorio.resumo_filial(id_filial)

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter resumo necessidades filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/necessidades/produto/{id_prod}",
            tags=["Necessidades"],
            summary="Gera necessidade para um produto")
async def necessidade_produto(
    id_prod: int,
    id_filial: int,
    salvar: bool = Query(False, description="Salvar no banco"),
    db: DatabaseManager = Depends(get_database)
):
    """Calcula necessidade de compra para um produto específico."""
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        gerador = GeradorNecessidade(db)
        item = gerador.gerar_necessidade_produto(id_prod, id_filial, salvar=salvar)
        return item.to_dict()

    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao gerar necessidade produto {id_prod}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/necessidades/{id_necessi}/status",
            tags=["Necessidades"],
            summary="Atualiza status de necessidade")
async def atualizar_status_necessidade(
    id_necessi: int,
    status: str = Query(..., description="PENDENTE, APROVADA, REJEITADA, PEDIDO, CANCELADA"),
    usuario: str = Query(None, description="Usuário que realizou a ação"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Atualiza status de uma necessidade.
    Status: PENDENTE, APROVADA, REJEITADA, PEDIDO, CANCELADA
    """
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        repositorio = NecessidadeRepositorio(db)
        repositorio.atualizar_status_necessidade(id_necessi, status, usuario)
        return {"sucesso": True}

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao atualizar status necessidade {id_necessi}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - PEDIDOS SUGERIDOS ====================

@router.get("/pedidos-sugeridos/filial/{id_filial}",
            tags=["Necessidades"],
            summary="Lista pedidos sugeridos")
async def listar_pedidos_sugeridos(
    id_filial: int,
    status: str = Query("SUGERIDO", description="Status dos pedidos"),
    prioridade: Optional[str] = Query(None, description="Filtrar por prioridade máxima"),
    limite: int = Query(50, ge=1, le=200),
    db: DatabaseManager = Depends(get_database)
):
    """Lista pedidos sugeridos agrupados por fornecedor."""
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        repositorio = NecessidadeRepositorio(db)
        return repositorio.listar_pedidos(
            id_filial=id_filial,
            status=status,
            prioridade=prioridade,
            limite=limite
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao listar pedidos sugeridos filial {id_filial}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/pedidos-sugeridos/{id_pedido}",
            tags=["Necessidades"],
            summary="Obtém pedido com itens")
async def obter_pedido_sugerido(
    id_pedido: int,
    db: DatabaseManager = Depends(get_database)
):
    """Obtém detalhes de um pedido sugerido com seus itens."""
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        repositorio = NecessidadeRepositorio(db)
        resultado = repositorio.obter_pedido_com_itens(id_pedido)

        if not resultado:
            raise HTTPException(status_code=404, detail="Pedido não encontrado")

        return resultado

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter pedido sugerido {id_pedido}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/pedidos-sugeridos/{id_pedido}/status",
            tags=["Necessidades"],
            summary="Atualiza status do pedido")
async def atualizar_status_pedido(
    id_pedido: int,
    status: str = Query(..., description="SUGERIDO, APROVADO, ENVIADO, RECEBIDO, CANCELADO"),
    usuario: str = Query(None, description="Usuário que realizou a ação"),
    id_pedido_erp: int = Query(None, description="ID do pedido no ERP"),
    db: DatabaseManager = Depends(get_database)
):
    """
    Atualiza status de um pedido sugerido.
    Status: SUGERIDO, APROVADO, ENVIADO, RECEBIDO, CANCELADO
    """
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        repositorio = NecessidadeRepositorio(db)
        repositorio.atualizar_status_pedido(id_pedido, status, usuario, id_pedido_erp)
        return {"sucesso": True}

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao atualizar status pedido {id_pedido}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/pedidos-sugeridos/{id_pedido}/aprovar",
             tags=["Necessidades"],
             summary="Aprova pedido sugerido")
async def aprovar_pedido(
    id_pedido: int,
    usuario: str = Query(..., description="Usuário aprovador"),
    db: DatabaseManager = Depends(get_database)
):
    """Aprova um pedido sugerido para envio."""
    try:
        if not NECESSIDADE_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de necessidades não disponível")

        repositorio = NecessidadeRepositorio(db)
        repositorio.atualizar_status_pedido(id_pedido, 'APROVADO', usuario)
        return {"sucesso": True, "mensagem": "Pedido aprovado"}

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao aprovar pedido {id_pedido}: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - SMARTPED ====================

@router.post("/smartped/gerar/{id_nec_ped}",
             tags=["SmartPed"],
             summary="Gera pedido a partir de necessidade")
async def smartped_gerar_pedido(
    id_nec_ped: int,
    usuario: str = Query("SISTEMA", description="Usuário que está gerando"),
    db: DatabaseManager = Depends(get_database)
):
    """Gera pedido de compra a partir de um pedido sugerido."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        smartped = SmartPed(db)
        pedido = smartped.gerar_pedido_de_necessidade(id_nec_ped, usuario)
        return pedido.to_dict()

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        logger.error(f"Erro ao gerar pedido SmartPed: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/smartped/gerar-aprovados/{id_filial}",
             tags=["SmartPed"],
             summary="Gera pedidos para todas necessidades aprovadas")
async def smartped_gerar_aprovados(
    id_filial: int,
    usuario: str = Query("SISTEMA", description="Usuário que está gerando"),
    db: DatabaseManager = Depends(get_database)
):
    """Gera pedidos para todas as necessidades aprovadas da filial."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        smartped = SmartPed(db)
        pedidos = smartped.gerar_pedidos_aprovados(id_filial, usuario)

        return {
            "sucesso": True,
            "total_pedidos": len(pedidos),
            "vlr_total": sum(p.vlr_total for p in pedidos)
        }

    except Exception as e:
        logger.error(f"Erro ao gerar pedidos aprovados: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/smartped/aprovar/{id_pedido}",
            tags=["SmartPed"],
            summary="Aprova pedido")
async def smartped_aprovar(
    id_pedido: int,
    usuario: str = Query(..., description="Usuário aprovador"),
    db: DatabaseManager = Depends(get_database)
):
    """Aprova um pedido para envio."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        smartped = SmartPed(db)
        smartped.aprovar_pedido(id_pedido, usuario)
        return {"sucesso": True}

    except Exception as e:
        logger.error(f"Erro ao aprovar pedido SmartPed: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/smartped/enviar/{id_pedido}",
            tags=["SmartPed"],
            summary="Envia pedido ao fornecedor")
async def smartped_enviar(
    id_pedido: int,
    db: DatabaseManager = Depends(get_database)
):
    """Marca pedido como enviado ao fornecedor."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        smartped = SmartPed(db)
        smartped.enviar_pedido(id_pedido)
        return {"sucesso": True}

    except Exception as e:
        logger.error(f"Erro ao enviar pedido SmartPed: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - COTEFÁCIL ====================

@router.post("/cotefacil/criar",
             tags=["CoteFácil"],
             summary="Cria cotação")
async def cotefacil_criar_cotacao(
    id_filial: int = Query(..., description="ID da filial"),
    ids_necessidades: List[int] = Query(..., description="IDs das necessidades"),
    cnpjs_fornecedores: List[str] = Query(..., description="CNPJs dos fornecedores"),
    dias_validade: int = Query(3, ge=1, le=30, description="Dias até encerramento"),
    criterio: str = Query("MENOR_PRECO", description="Critério de seleção"),
    usuario: str = Query("SISTEMA", description="Usuário criador"),
    db: DatabaseManager = Depends(get_database)
):
    """Cria uma nova cotação a partir de necessidades."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        integrador = CoteFacilIntegrador(db)
        cotacao = integrador.criar_cotacao(
            id_filial=id_filial,
            ids_necessidades=ids_necessidades,
            cnpjs_fornecedores=cnpjs_fornecedores,
            dias_validade=dias_validade,
            criterio=CriterioSelecao(criterio),
            usuario=usuario
        )

        return {
            "sucesso": True,
            "id_cotacao": cotacao.id_cotacao,
            "codigo": cotacao.cod_cotacao,
            "qtd_itens": len(cotacao.itens),
            "qtd_fornecedores": len(cotacao.fornecedores)
        }

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        logger.error(f"Erro ao criar cotação: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/cotefacil/abrir/{id_cotacao}",
             tags=["CoteFácil"],
             summary="Abre cotação")
async def cotefacil_abrir(
    id_cotacao: int,
    db: DatabaseManager = Depends(get_database)
):
    """Abre a cotação e envia convites aos fornecedores."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        integrador = CoteFacilIntegrador(db)
        integrador.abrir_cotacao(id_cotacao)
        return {"sucesso": True}

    except Exception as e:
        logger.error(f"Erro ao abrir cotação: {e}")
        raise HTTPException(status_code=500, detail=str(e))


class RespostaFornecedorItem(BaseModel):
    id_prod: int
    qtd: float = Field(ge=0)
    vlr_unitario: float = Field(ge=0)
    prazo: int = Field(default=0, ge=0)
    observacao: str = ""


@router.post("/cotefacil/resposta/{id_cotacao}",
             tags=["CoteFácil"],
             summary="Registra resposta de fornecedor")
async def cotefacil_registrar_resposta(
    id_cotacao: int,
    cnpj_forn: str = Query(..., description="CNPJ do fornecedor"),
    respostas: List[RespostaFornecedorItem] = None,
    db: DatabaseManager = Depends(get_database)
):
    """
    Registra respostas de um fornecedor.
    """
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        integrador = CoteFacilIntegrador(db)
        respostas_dict = [r.model_dump() for r in respostas] if respostas else []
        count = integrador.registrar_resposta(id_cotacao, cnpj_forn, respostas_dict)
        return {"sucesso": True, "respostas_registradas": count}

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        logger.error(f"Erro ao registrar respostas: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/cotefacil/encerrar/{id_cotacao}",
             tags=["CoteFácil"],
             summary="Encerra cotação")
async def cotefacil_encerrar(
    id_cotacao: int,
    db: DatabaseManager = Depends(get_database)
):
    """Encerra a cotação e calcula rankings."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        integrador = CoteFacilIntegrador(db)
        resumo = integrador.encerrar_cotacao(id_cotacao)
        return resumo

    except Exception as e:
        logger.error(f"Erro ao encerrar cotação: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/cotefacil/selecionar-vencedor/{id_cotacao}",
             tags=["CoteFácil"],
             summary="Seleciona vencedor")
async def cotefacil_selecionar_vencedor(
    id_cotacao: int,
    cnpj_vencedor: str = Query(None, description="CNPJ do vencedor (opcional)"),
    usuario: str = Query("SISTEMA", description="Usuário"),
    db: DatabaseManager = Depends(get_database)
):
    """Seleciona o fornecedor vencedor da cotação."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        integrador = CoteFacilIntegrador(db)
        vencedor = integrador.selecionar_vencedor(id_cotacao, cnpj_vencedor, usuario)
        return vencedor

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        logger.error(f"Erro ao selecionar vencedor: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/cotefacil/gerar-pedido/{id_cotacao}",
             tags=["CoteFácil"],
             summary="Gera pedido a partir da cotação")
async def cotefacil_gerar_pedido(
    id_cotacao: int,
    usuario: str = Query("SISTEMA", description="Usuário"),
    db: DatabaseManager = Depends(get_database)
):
    """Gera pedido de compra a partir da cotação finalizada."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        integrador = CoteFacilIntegrador(db)
        pedido = integrador.gerar_pedido_de_cotacao(id_cotacao, usuario)
        return pedido.to_dict()

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        logger.error(f"Erro ao gerar pedido da cotação: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/cotefacil/cotacao/{id_cotacao}",
            tags=["CoteFácil"],
            summary="Obtém cotação completa")
async def cotefacil_obter_cotacao(
    id_cotacao: int,
    db: DatabaseManager = Depends(get_database)
):
    """Obtém cotação com itens, fornecedores e respostas."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        repositorio = IntegracaoRepositorio(db)
        resultado = repositorio.obter_cotacao_completa(id_cotacao)

        if not resultado:
            raise HTTPException(status_code=404, detail="Cotação não encontrada")

        return resultado

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter cotação: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/cotefacil/filial/{id_filial}",
            tags=["CoteFácil"],
            summary="Lista cotações da filial")
async def cotefacil_listar(
    id_filial: int,
    status: str = Query(None, description="Filtrar por status"),
    limite: int = Query(50, ge=1, le=200),
    db: DatabaseManager = Depends(get_database)
):
    """Lista cotações da filial."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        repositorio = IntegracaoRepositorio(db)
        return repositorio.listar_cotacoes(id_filial, status, limite)

    except Exception as e:
        logger.error(f"Erro ao listar cotações: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - PEDIDOS IA ====================

@router.get("/pedidos-ia/filial/{id_filial}",
            tags=["Pedidos IA"],
            summary="Lista pedidos da filial")
async def listar_pedidos_ia(
    id_filial: int,
    status: str = Query(None, description="Filtrar por status"),
    origem: str = Query(None, description="Filtrar por origem (SMARTPED, COTEFACIL, MANUAL)"),
    limite: int = Query(50, ge=1, le=200),
    db: DatabaseManager = Depends(get_database)
):
    """Lista pedidos de compra."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        repositorio = IntegracaoRepositorio(db)
        return repositorio.listar_pedidos(id_filial, status, origem, limite)

    except Exception as e:
        logger.error(f"Erro ao listar pedidos: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/pedidos-ia/{id_pedido}",
            tags=["Pedidos IA"],
            summary="Obtém pedido com itens")
async def obter_pedido_ia(
    id_pedido: int,
    db: DatabaseManager = Depends(get_database)
):
    """Obtém detalhes de um pedido com seus itens."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        repositorio = IntegracaoRepositorio(db)
        resultado = repositorio.obter_pedido_com_itens(id_pedido)

        if not resultado:
            raise HTTPException(status_code=404, detail="Pedido não encontrado")

        return resultado

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter pedido: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/pedidos-ia/filial/{id_filial}/resumo",
            tags=["Pedidos IA"],
            summary="Resumo dos pedidos")
async def resumo_pedidos_ia(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """Resumo dos pedidos da filial."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        repositorio = IntegracaoRepositorio(db)
        return repositorio.resumo_pedidos_filial(id_filial)

    except Exception as e:
        logger.error(f"Erro ao obter resumo de pedidos: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# ==================== ENDPOINTS - SINCRONIZAÇÃO ERP ====================

@router.post("/erp/sincronizar/{id_filial}",
             tags=["ERP"],
             summary="Sincroniza pedidos com ERP")
async def erp_sincronizar(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """Sincroniza todos os pedidos pendentes com o ERP."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        sincronizador = SincronizadorERP(db)
        return sincronizador.sincronizar_pedidos_pendentes(id_filial)

    except Exception as e:
        logger.error(f"Erro ao sincronizar pedidos: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/erp/exportar/{id_pedido}",
             tags=["ERP"],
             summary="Exporta pedido para ERP")
async def erp_exportar_pedido(
    id_pedido: int,
    usuario: str = Query("SISTEMA", description="Usuário"),
    db: DatabaseManager = Depends(get_database)
):
    """Exporta um pedido específico para o ERP."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        gerador = GeradorPedido(db)
        id_erp = gerador.gerar_pedido_erp(id_pedido, usuario)
        return {"sucesso": True, "id_pedido_erp": id_erp}

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        logger.error(f"Erro ao exportar pedido para ERP: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/erp/importar-recebimento/{id_pedido_erp}",
             tags=["ERP"],
             summary="Importa recebimento do ERP")
async def erp_importar_recebimento(
    id_pedido_erp: int,
    db: DatabaseManager = Depends(get_database)
):
    """Importa dados de recebimento de um pedido do ERP."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        sincronizador = SincronizadorERP(db)
        return sincronizador.importar_recebimento(id_pedido_erp)

    except Exception as e:
        logger.error(f"Erro ao importar recebimento: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/erp/relatorio/{id_filial}",
            tags=["ERP"],
            summary="Relatório de sincronização")
async def erp_relatorio(
    id_filial: int,
    dias: int = Query(7, ge=1, le=90, description="Dias para análise"),
    db: DatabaseManager = Depends(get_database)
):
    """Relatório de sincronização com o ERP."""
    try:
        if not INTEGRACAO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de integração não disponível")

        sincronizador = SincronizadorERP(db)
        return sincronizador.relatorio_sincronizacao(id_filial, dias)

    except Exception as e:
        logger.error(f"Erro ao gerar relatório: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# =========================================================================
# ROTAS APRENDIZADO
# =========================================================================

@router.post("/aprendizado/filial/{id_filial}/executar",
             tags=["Aprendizado"],
             summary="Executa ciclo de aprendizado")
async def aprendizado_executar(
    id_filial: int,
    data_inicio: str = None,
    data_fim: str = None,
    aplicar_ajustes: bool = True,
    db: DatabaseManager = Depends(get_database)
):
    """
    Executa ciclo completo de aprendizado para uma filial.

    - Compara previsões com realidade
    - Calcula métricas (MAPE, BIAS, etc)
    - Sugere e aplica ajustes
    """
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        from datetime import datetime

        dt_inicio = datetime.strptime(data_inicio, '%Y-%m-%d').date() if data_inicio else None
        dt_fim = datetime.strptime(data_fim, '%Y-%m-%d').date() if data_fim else None

        analisador = AnalisadorAprendizado(db)
        return analisador.executar_ciclo_aprendizado(
            id_filial, dt_inicio, dt_fim, aplicar_ajustes
        )

    except Exception as e:
        logger.error(f"Erro ao executar aprendizado: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/aprendizado/filial/{id_filial}/dashboard",
            tags=["Aprendizado"],
            summary="Dashboard de aprendizado")
async def aprendizado_dashboard(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """Retorna dados consolidados para dashboard de aprendizado."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        analisador = AnalisadorAprendizado(db)
        return analisador.obter_dashboard(id_filial)

    except Exception as e:
        logger.error(f"Erro ao obter dashboard: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/aprendizado/filial/{id_filial}/metricas",
            tags=["Aprendizado"],
            summary="Lista métricas históricas")
async def aprendizado_metricas(
    id_filial: int,
    tipo_periodo: str = "MENSAL",
    id_grupo: int = None,
    limite: int = 12,
    db: DatabaseManager = Depends(get_database)
):
    """Lista métricas consolidadas dos últimos períodos."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        repositorio = AprendizadoRepositorio(db)
        return repositorio.listar_metricas(id_filial, tipo_periodo, id_grupo, limite)

    except Exception as e:
        logger.error(f"Erro ao listar métricas: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/aprendizado/filial/{id_filial}/comparacoes",
            tags=["Aprendizado"],
            summary="Lista comparações")
async def aprendizado_comparacoes(
    id_filial: int,
    id_prod: int = None,
    classificacao: str = None,
    limite: int = 100,
    db: DatabaseManager = Depends(get_database)
):
    """Lista comparações previsão x realidade."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        repositorio = AprendizadoRepositorio(db)
        return repositorio.listar_comparacoes(
            id_filial=id_filial,
            id_prod=id_prod,
            classificacao=classificacao,
            limite=limite
        )

    except Exception as e:
        logger.error(f"Erro ao listar comparações: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/aprendizado/filial/{id_filial}/produtos-criticos",
            tags=["Aprendizado"],
            summary="Produtos com pior acurácia")
async def aprendizado_produtos_criticos(
    id_filial: int,
    top: int = 20,
    db: DatabaseManager = Depends(get_database)
):
    """Lista produtos que precisam de atenção (pior acurácia)."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        analisador = AnalisadorAprendizado(db)
        return analisador.produtos_criticos(id_filial, top)

    except Exception as e:
        logger.error(f"Erro ao listar produtos críticos: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/aprendizado/produto/{id_prod}",
            tags=["Aprendizado"],
            summary="Análise de produto")
async def aprendizado_produto(
    id_prod: int,
    id_filial: int,
    meses: int = 3,
    db: DatabaseManager = Depends(get_database)
):
    """Análise detalhada de um produto específico."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        analisador = AnalisadorAprendizado(db)
        return analisador.analisar_produto(id_prod, id_filial, meses)

    except Exception as e:
        logger.error(f"Erro ao analisar produto: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# =========================================================================
# ROTAS AJUSTES
# =========================================================================

@router.get("/aprendizado/ajustes/filial/{id_filial}/pendentes",
            tags=["Aprendizado"],
            summary="Ajustes pendentes")
async def ajustes_pendentes(
    id_filial: int,
    db: DatabaseManager = Depends(get_database)
):
    """Lista ajustes sugeridos mas não aplicados."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        ajustador = Ajustador(db)
        return ajustador.listar_ajustes_pendentes(id_filial)

    except Exception as e:
        logger.error(f"Erro ao listar ajustes pendentes: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/aprendizado/ajustes/filial/{id_filial}/historico",
            tags=["Aprendizado"],
            summary="Histórico de ajustes")
async def ajustes_historico(
    id_filial: int,
    id_prod: int = None,
    dias: int = 30,
    db: DatabaseManager = Depends(get_database)
):
    """Histórico de ajustes aplicados."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        ajustador = Ajustador(db)
        return ajustador.historico_ajustes(id_filial, id_prod, dias)

    except Exception as e:
        logger.error(f"Erro ao obter histórico de ajustes: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/aprendizado/ajustes/{id_ajuste}/aplicar",
             tags=["Aprendizado"],
             summary="Aplica ajuste")
async def aplicar_ajuste(
    id_ajuste: int,
    usuario: str = "SISTEMA",
    db: DatabaseManager = Depends(get_database)
):
    """Aplica um ajuste pendente."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        # Busca ajuste
        sql = "SELECT * FROM ia_arqajuste WHERE IDAjuste = :id"
        ajuste = db.execute_query(sql, {'id': id_ajuste})

        if not ajuste:
            return {"sucesso": False, "erro": "Ajuste não encontrado"}

        # Monta objeto e aplica
        from .processadores.aprendizado.comparador import SugestaoAjuste, TipoAjuste

        a = ajuste[0]
        sugestao = SugestaoAjuste(
            id_filial=a['IDFilial'],
            id_prod=a['IDProd'],
            id_grupo=a.get('IDGrupo'),
            tipo_ajuste=TipoAjuste(a['TipoAjuste']),
            valor_anterior=float(a['ValorAnterior']),
            valor_novo=float(a['ValorNovo']),
            variacao_perc=float(a['VariacaoPerc']),
            motivo=a['MotivoAjuste']
        )

        ajustador = Ajustador(db)
        resultado = ajustador.aplicar_ajuste(sugestao, usuario)

        return {"sucesso": resultado}

    except Exception as e:
        logger.error(f"Erro ao aplicar ajuste: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/aprendizado/resumo-acuracia/{id_filial}",
            tags=["Aprendizado"],
            summary="Resumo de acurácia")
async def resumo_acuracia(
    id_filial: int,
    meses: int = 3,
    db: DatabaseManager = Depends(get_database)
):
    """Resumo de acurácia dos últimos meses."""
    try:
        if not APRENDIZADO_AVAILABLE:
            raise HTTPException(status_code=503, detail="Módulo de aprendizado não disponível")

        calculador = CalculadorMetrica(db)
        return calculador.resumo_acuracia(id_filial, meses)

    except Exception as e:
        logger.error(f"Erro ao obter resumo de acurácia: {e}")
        raise HTTPException(status_code=500, detail=str(e))