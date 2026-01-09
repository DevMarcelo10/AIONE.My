"""
AIONE IA - Coletor de Dados de Saúde
Coleta dados do InfoGripe e gera alertas de surtos
"""

import time
from datetime import datetime, timedelta, date
from io import StringIO
from typing import Dict, List, Optional

import httpx
import pandas as pd

from core.database import DatabaseManager
from core.utils import get_logger
from modules.compras.models import Regiao
from .base import ColetorBase


logger = get_logger(__name__)


class ColetorSaude(ColetorBase):
    """
    Coletor de dados de saúde do InfoGripe.

    Coleta dados de síndrome gripal e gera alertas de surtos
    baseado em limiares configuráveis.
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o coletor de saúde.

        Args:
            db: Instância do DatabaseManager
        """
        super().__init__(db)
        self._csv_cache: Optional[str] = None
        self._cache_timestamp: Optional[float] = None
        self._client: Optional[httpx.AsyncClient] = None

    # ==================== PROPRIEDADES ====================

    @property
    def nome(self) -> str:
        return "InfoGripe"

    @property
    def tipo_fonte(self) -> str:
        return "SAUDE"

    @property
    def frequencia_horas(self) -> int:
        return 24

    # ==================== CONSTANTES ====================

    # URL do CSV do InfoGripe
    URL_CSV = "https://gitlab.fiocruz.br/marcelo.gomes/infogripe/-/raw/master/Dados/InfoGripe/dados_semanais_faixa_etaria_sexo_virus_sem_filtro_sintomas.csv"

    # Limiares para detecção de surtos
    LIMIARES = {
        "surto_media": 1.5,    # multiplicador da média
        "surto_alta": 2.0,
        "surto_critica": 3.0
    }

    # Categorias de produtos afetados
    CATEGORIAS = [
        "antigripais",
        "antitérmicos",
        "vitamina_c",
        "descongestionantes",
        "soro",
        "máscaras"
    ]

    # Ações recomendadas por severidade
    ACOES = {
        "MEDIA": "Monitorar estoque de antigripais e antitérmicos",
        "ALTA": "Aumentar estoque de antigripais, antitérmicos, vitamina C em 50%",
        "CRITICA": "Reforço urgente: antigripais, antitérmicos, soro, máscaras"
    }

    # ==================== MÉTODOS HTTP ====================

    @property
    def client(self) -> httpx.AsyncClient:
        """Cliente HTTP com timeout configurado."""
        if self._client is None:
            self._client = httpx.AsyncClient(timeout=30.0)
        return self._client

    async def close(self) -> None:
        """Fecha cliente HTTP."""
        if self._client:
            await self._client.aclose()
            self._client = None

    # ==================== MÉTODOS DE COLETA ====================

    async def _baixar_csv(self) -> Optional[str]:
        """
        Baixa CSV do InfoGripe com cache de 1 hora.

        Returns:
            Conteúdo do CSV como string ou None se erro
        """
        now = time.time()

        # Verifica cache (1 hora = 3600 segundos)
        if (self._csv_cache and self._cache_timestamp and
            now - self._cache_timestamp < 3600):
            self.logger.debug("Usando cache do CSV InfoGripe")
            return self._csv_cache

        try:
            self.logger.info(f"Baixando CSV do InfoGripe: {self.URL_CSV}")
            response = await self.client.get(self.URL_CSV)
            response.raise_for_status()

            # Atualiza cache
            self._csv_cache = response.text
            self._cache_timestamp = now

            self.logger.info(f"CSV InfoGripe baixado com sucesso ({len(response.text)} bytes)")
            return self._csv_cache

        except httpx.TimeoutException:
            self.logger.warning("Timeout ao baixar CSV do InfoGripe")
            return None
        except httpx.HTTPStatusError as e:
            self.logger.warning(f"Erro HTTP ao baixar CSV do InfoGripe: {e.response.status_code}")
            return None
        except Exception as e:
            self.logger.error(f"Erro inesperado ao baixar CSV do InfoGripe: {e}")
            return None

    def _filtrar_dados_regiao(self, df: pd.DataFrame, regiao: Regiao) -> pd.DataFrame:
        """
        Filtra dados por UF da região.

        Args:
            df: DataFrame com dados do InfoGripe
            regiao: Região para filtrar

        Returns:
            DataFrame filtrado
        """
        try:
            # Possíveis nomes de coluna para UF
            colunas_uf = ['UF', 'uf', 'estado', 'Estado', 'sigla_uf']
            coluna_uf = None

            for col in colunas_uf:
                if col in df.columns:
                    coluna_uf = col
                    break

            if not coluna_uf:
                self.logger.warning(f"Coluna UF não encontrada. Colunas disponíveis: {list(df.columns)}")
                return pd.DataFrame()

            # Filtra por UF
            df_filtrado = df[df[coluna_uf] == regiao.UF_Reg].copy()
            self.logger.debug(f"Dados filtrados para {regiao.UF_Reg}: {len(df_filtrado)} registros")

            return df_filtrado

        except Exception as e:
            self.logger.error(f"Erro ao filtrar dados por UF {regiao.UF_Reg}: {e}")
            return pd.DataFrame()

    def _filtrar_semanas_recentes(self, df: pd.DataFrame, semanas: int = 4) -> pd.DataFrame:
        """
        Filtra últimas N semanas epidemiológicas.

        Args:
            df: DataFrame com dados
            semanas: Número de semanas a manter

        Returns:
            DataFrame filtrado
        """
        try:
            # Possíveis nomes de coluna para semana epidemiológica
            colunas_semana = ['semana_epi', 'SE', 'semana', 'week', 'epi_week']
            coluna_semana = None

            for col in colunas_semana:
                if col in df.columns:
                    coluna_semana = col
                    break

            if not coluna_semana:
                self.logger.warning("Coluna de semana epidemiológica não encontrada")
                return df.tail(semanas) if len(df) > 0 else df

            # Ordena por semana e pega as últimas N
            df_sorted = df.sort_values(coluna_semana)
            df_recente = df_sorted.tail(semanas)

            self.logger.debug(f"Filtrado últimas {semanas} semanas: {len(df_recente)} registros")
            return df_recente

        except Exception as e:
            self.logger.error(f"Erro ao filtrar semanas recentes: {e}")
            return df.tail(semanas) if len(df) > 0 else df

    def _agregar_casos_por_semana(self, df: pd.DataFrame) -> Dict[str, int]:
        """
        Agrega casos totais por semana.

        Args:
            df: DataFrame com dados filtrados

        Returns:
            Dicionário {semana: casos_totais}
        """
        try:
            # Possíveis nomes de coluna para casos
            colunas_casos = ['casos', 'casos_est', 'casos_totais', 'total_cases', 'n_casos']
            coluna_casos = None

            for col in colunas_casos:
                if col in df.columns:
                    coluna_casos = col
                    break

            if not coluna_casos:
                # Tenta somar todas as colunas numéricas que podem ser casos
                colunas_numericas = df.select_dtypes(include=['number']).columns
                casos_cols = [col for col in colunas_numericas
                             if 'caso' in col.lower() or 'total' in col.lower()]

                if casos_cols:
                    df['casos_calculados'] = df[casos_cols].sum(axis=1)
                    coluna_casos = 'casos_calculados'
                else:
                    self.logger.warning("Nenhuma coluna de casos encontrada")
                    return {}

            # Agrega por semana
            colunas_semana = ['semana_epi', 'SE', 'semana', 'week', 'epi_week']
            coluna_semana = None

            for col in colunas_semana:
                if col in df.columns:
                    coluna_semana = col
                    break

            if not coluna_semana:
                # Se não tem coluna de semana, usa index
                agregacao = {str(i): int(row[coluna_casos]) for i, row in df.iterrows()}
            else:
                agregacao = df.groupby(coluna_semana)[coluna_casos].sum().to_dict()

            # Converte chaves para string e valores para int
            resultado = {str(k): int(v) for k, v in agregacao.items()}

            self.logger.debug(f"Casos por semana: {resultado}")
            return resultado

        except Exception as e:
            self.logger.error(f"Erro ao agregar casos por semana: {e}")
            return {}

    # ==================== MÉTODOS ABSTRATOS ====================

    async def coletar(self, regiao: Regiao) -> Dict:
        """
        Coleta dados do InfoGripe para uma região.

        Args:
            regiao: Região para coletar dados

        Returns:
            Dicionário com dados agregados ou vazio se erro
        """
        try:
            # Baixa CSV
            csv_content = await self._baixar_csv()
            if not csv_content:
                self.logger.warning(f"CSV indisponível para região {regiao.NomeReg}")
                return {
                    "regiao_id": regiao.IDRegiao,
                    "casos_por_semana": {},
                    "erro": "csv_indisponivel"
                }

            # Tenta diferentes encodings
            for encoding in ['utf-8', 'latin-1', 'iso-8859-1']:
                try:
                    df = pd.read_csv(StringIO(csv_content), encoding=encoding)
                    break
                except UnicodeDecodeError:
                    continue
            else:
                self.logger.error("Não foi possível decodificar o CSV com nenhum encoding")
                return {"regiao_id": regiao.IDRegiao, "casos_por_semana": {}, "erro": "encoding_error"}

            # Filtra por região
            df_regiao = self._filtrar_dados_regiao(df, regiao)
            if df_regiao.empty:
                self.logger.info(f"Nenhum dado encontrado para UF {regiao.UF_Reg}")
                return {"regiao_id": regiao.IDRegiao, "casos_por_semana": {}}

            # Filtra últimas 4 semanas
            df_recente = self._filtrar_semanas_recentes(df_regiao, 4)

            # Agrega casos por semana
            casos_por_semana = self._agregar_casos_por_semana(df_recente)

            resultado = {
                "regiao_id": regiao.IDRegiao,
                "regiao_nome": regiao.NomeReg,
                "uf": regiao.UF_Reg,
                "casos_por_semana": casos_por_semana,
                "data_coleta": datetime.now().isoformat()
            }

            self.logger.info(f"Dados coletados para {regiao.NomeReg}: {len(casos_por_semana)} semanas")
            return resultado

        except Exception as e:
            self.logger.error(f"Erro ao coletar dados de saúde para {regiao.NomeReg}: {e}")
            return {
                "regiao_id": regiao.IDRegiao,
                "casos_por_semana": {},
                "erro": str(e)
            }

    def processar(self, dados_brutos: Dict, regiao: Regiao) -> List[Dict]:
        """
        Processa dados brutos e gera alertas de surtos no formato esperado pela ColetorBase.

        Args:
            dados_brutos: Dados retornados por coletar()
            regiao: Região dos dados

        Returns:
            Lista de dicionários com alertas/eventos no formato ColetorBase
        """
        alertas_eventos = []

        try:
            casos_por_semana = dados_brutos.get("casos_por_semana", {})

            if not casos_por_semana:
                self.logger.debug(f"Nenhum dado de casos para processar em {regiao.NomeReg}")
                return alertas_eventos

            # Converte para lista de valores
            casos_valores = [int(v) for v in casos_por_semana.values() if str(v).isdigit()]

            if len(casos_valores) < 2:
                self.logger.debug(f"Dados insuficientes para análise em {regiao.NomeReg}")
                return alertas_eventos

            # Calcula estatísticas
            casos_ultima_semana = casos_valores[-1]
            casos_historico = casos_valores[:-1]  # Todas exceto a última
            media_historica = sum(casos_historico) / len(casos_historico) if casos_historico else 0

            # Detecta tendência
            if len(casos_valores) >= 3:
                casos_penultima = casos_valores[-2]
                if casos_ultima_semana > casos_penultima * 1.2:
                    tendencia = "crescente"
                elif casos_ultima_semana < casos_penultima * 0.8:
                    tendencia = "decrescente"
                else:
                    tendencia = "estável"
            else:
                tendencia = "estável"

            # Verifica limiares de surto
            if media_historica > 0:
                fator_multiplicador = casos_ultima_semana / media_historica

                severidade = None
                if fator_multiplicador >= self.LIMIARES["surto_critica"]:
                    severidade = "CRITICA"
                elif fator_multiplicador >= self.LIMIARES["surto_alta"]:
                    severidade = "ALTA"
                elif fator_multiplicador >= self.LIMIARES["surto_media"]:
                    severidade = "MEDIA"

                if severidade:
                    data_hoje = date.today()
                    data_fim = data_hoje + timedelta(days=7)

                    # Criar alerta no formato ColetorBase
                    alerta = {
                        "tipo": "alerta",
                        "dados": {
                            "tipo": "SURTO",
                            "severidade": severidade,
                            "regiao_id": regiao.IDRegiao,
                            "data_inicio": data_hoje,
                            "data_fim": data_fim,
                            "descricao": (
                                f"Possível surto de síndrome gripal detectado em {regiao.NomeReg}. "
                                f"Casos na última semana ({casos_ultima_semana}) são {fator_multiplicador:.1f}x "
                                f"a média histórica ({media_historica:.1f}). Tendência: {tendencia}."
                            ),
                            "acao": self.ACOES.get(severidade, "Monitorar situação")
                        }
                    }

                    # Criar evento correspondente
                    evento = {
                        "tipo": "evento",
                        "dados": {
                            "tipo": "SURTO",
                            "descricao": f"Surto de síndrome gripal: {casos_ultima_semana} casos ({fator_multiplicador:.1f}x média)",
                            "data_inicio": data_hoje,
                            "data_fim": data_fim,
                            "regiao_id": regiao.IDRegiao,
                            "impacto": min(50.0 + (fator_multiplicador - 1) * 20, 100.0),  # Aumenta com intensidade
                            "categorias": self.CATEGORIAS
                        }
                    }

                    alertas_eventos.extend([alerta, evento])

                    self.logger.info(
                        f"Alerta SURTO {severidade} gerado para {regiao.NomeReg}: "
                        f"{casos_ultima_semana} casos (média: {media_historica:.1f})"
                    )

            self.logger.debug(f"Processamento concluído para {regiao.NomeReg}: {len(alertas_eventos)} alertas/eventos gerados")

        except Exception as e:
            self.logger.error(f"Erro ao processar dados de saúde para {regiao.NomeReg}: {e}")

        return alertas_eventos

    # ==================== CONTEXT MANAGER ====================

    async def __aenter__(self):
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        await self.close()