"""
AIONE IA - [NOME_DO_MODULO] Models
Modelos Pydantic do módulo
"""

from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


# === Request Models ===

class ExemploRequest(BaseModel):
    """Request de exemplo"""
    id_filial: int = Field(..., description="ID da filial")
    parametro: str = Field(..., description="Descrição do parâmetro")
    opcional: Optional[int] = Field(default=None, description="Parâmetro opcional")


# === Response Models ===

class ExemploResponse(BaseModel):
    """Response de exemplo"""
    id: int
    mensagem: str
    data_processamento: datetime
    resultados: list[dict] = Field(default_factory=list)


# === Modelos de Domínio ===

class ItemExemplo(BaseModel):
    """Item de exemplo do domínio"""
    id: int
    nome: str
    valor: float
    ativo: bool = True
