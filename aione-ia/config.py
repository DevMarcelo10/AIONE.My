"""
AIONE IA - Configurações Globais
Utiliza pydantic-settings para carregar e validar configurações do .env
"""

from functools import lru_cache
from typing import Literal

from pydantic import Field, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Configurações da aplicação carregadas do arquivo .env"""

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )

    # Banco de Dados
    db_type: Literal["mysql", "postgres", "sqlserver"] = Field(
        default="mysql",
        description="Tipo do banco de dados"
    )
    db_host: str = Field(default="localhost", description="Host do banco")
    db_port: int = Field(default=3306, description="Porta do banco")
    db_name: str = Field(default="dbaione", description="Nome do banco")
    db_user: str = Field(default="root", description="Usuário do banco")
    db_password: str = Field(default="", description="Senha do banco")

    # API
    api_host: str = Field(default="0.0.0.0", description="Host da API")
    api_port: int = Field(default=8000, description="Porta da API")
    debug: bool = Field(default=False, description="Modo debug")

    # Módulos
    active_modules: str = Field(
        default="compras",
        description="Módulos ativos separados por vírgula"
    )

    # Logs
    log_level: Literal["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"] = Field(
        default="INFO",
        description="Nível de log"
    )

    @field_validator("db_port", mode="before")
    @classmethod
    def validate_db_port(cls, v, info):
        """Ajusta porta padrão baseado no tipo de banco"""
        if v is None or v == 0:
            db_type = info.data.get("db_type", "mysql")
            default_ports = {
                "mysql": 3306,
                "postgres": 5432,
                "sqlserver": 1433,
            }
            return default_ports.get(db_type, 3306)
        return v

    @property
    def active_modules_list(self) -> list[str]:
        """Retorna lista de módulos ativos"""
        return [m.strip() for m in self.active_modules.split(",") if m.strip()]

    @property
    def database_url(self) -> str:
        """Retorna URL de conexão do banco baseado no tipo"""
        drivers = {
            "mysql": f"mysql+pymysql://{self.db_user}:{self.db_password}@{self.db_host}:{self.db_port}/{self.db_name}",
            "postgres": f"postgresql+psycopg2://{self.db_user}:{self.db_password}@{self.db_host}:{self.db_port}/{self.db_name}",
            "sqlserver": f"mssql+pyodbc://{self.db_user}:{self.db_password}@{self.db_host}:{self.db_port}/{self.db_name}?driver=ODBC+Driver+17+for+SQL+Server",
        }
        return drivers.get(self.db_type, drivers["mysql"])


@lru_cache
def get_settings() -> Settings:
    """Retorna instância cacheada das configurações"""
    return Settings()


# Instância global para acesso direto
settings = get_settings()
