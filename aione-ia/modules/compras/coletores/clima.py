"""
AIONE IA - Coletor de Clima
Coleta dados climáticos do Open-Meteo e detecta condições extremas
"""

import httpx
from datetime import date, datetime, timedelta
from typing import Dict, List

from core.database import DatabaseManager
from core.utils import get_logger
from modules.compras.models import Regiao
from .base import ColetorBase


logger = get_logger(__name__)


class ColetorClima(ColetorBase):
    """
    Coletor de dados climáticos do Open-Meteo.

    Detecta ondas de frio, calor e tempo seco baseado em limiares configuráveis.
    Gera alertas e eventos para impacto na demanda de produtos farmacêuticos.
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o coletor de clima.

        Args:
            db: Instância do DatabaseManager
        """
        super().__init__(db)
        self._client = None

    # ==================== PROPRIEDADES ====================

    @property
    def nome(self) -> str:
        return "Open-Meteo"

    @property
    def tipo_fonte(self) -> str:
        return "CLIMA"

    @property
    def frequencia_horas(self) -> int:
        return 6

    # ==================== CONSTANTES ====================

    URL_API = "https://api.open-meteo.com/v1/forecast"

    LIMIARES = {
        "frio_media": 10,       # °C
        "frio_alta": 5,         # °C
        "calor_media": 35,      # °C
        "calor_alta": 40,       # °C
        "seco_dias": 7          # dias sem chuva
    }

    CATEGORIAS = {
        "ONDA_FRIO": ["antigripais", "vitaminas", "descongestionantes", "antitérmicos"],
        "ONDA_CALOR": ["hidratantes", "protetor_solar", "soro", "antialérgicos"],
        "TEMPO_SECO": ["soro_fisiologico", "colirios", "hidratantes", "descongestionantes"]
    }

    ACOES = {
        "ONDA_FRIO": "Aumentar estoque de antigripais, vitamina C, descongestionantes",
        "ONDA_CALOR": "Aumentar estoque de hidratantes, protetor solar, soro fisiológico",
        "TEMPO_SECO": "Aumentar estoque de soro fisiológico, colírios, hidratantes"
    }

    # ==================== MÉTODOS HTTP ====================

    @property
    def client(self) -> httpx.AsyncClient:
        """Retorna cliente HTTP, criando se necessário."""
        if self._client is None:
            self._client = httpx.AsyncClient(timeout=30.0)
        return self._client

    async def close(self):
        """Fecha cliente HTTP."""
        if self._client:
            await self._client.aclose()
            self._client = None

    # ==================== MÉTODO DE COLETA ====================

    async def coletar(self, regiao: Regiao) -> Dict:
        """
        Coleta dados climáticos para uma região específica.

        Args:
            regiao: Região para coletar dados

        Returns:
            Dicionário com dados climáticos dos próximos 7 dias
        """
        try:
            # Verificar se região tem coordenadas
            if not regiao.Latitude or not regiao.Longitude:
                self.logger.warning(f"Região {regiao.NomeReg} sem coordenadas geográficas")
                return {
                    "regiao_id": regiao.IDRegiao,
                    "regiao_nome": regiao.NomeReg,
                    "erro": "coordenadas_indisponiveis"
                }

            # Montar URL da requisição
            params = {
                "latitude": float(regiao.Latitude),
                "longitude": float(regiao.Longitude),
                "daily": "temperature_2m_max,temperature_2m_min,precipitation_sum",
                "timezone": "America/Sao_Paulo",
                "forecast_days": 7
            }

            self.logger.debug(f"Coletando clima para {regiao.NomeReg}: {params['latitude']}, {params['longitude']}")

            # Fazer requisição
            response = await self.client.get(self.URL_API, params=params)
            response.raise_for_status()

            dados_api = response.json()

            if not dados_api.get('daily'):
                self.logger.warning(f"API não retornou dados daily para {regiao.NomeReg}")
                return {
                    "regiao_id": regiao.IDRegiao,
                    "regiao_nome": regiao.NomeReg,
                    "erro": "dados_daily_indisponiveis"
                }

            # Estruturar dados de resposta
            daily = dados_api['daily']
            resultado = {
                "regiao_id": regiao.IDRegiao,
                "regiao_nome": regiao.NomeReg,
                "latitude": params['latitude'],
                "longitude": params['longitude'],
                "data_coleta": datetime.now().isoformat(),
                "previsao_7_dias": []
            }

            # Processar cada dia
            dates = daily.get('time', [])
            temps_max = daily.get('temperature_2m_max', [])
            temps_min = daily.get('temperature_2m_min', [])
            precipitacao = daily.get('precipitation_sum', [])

            for i in range(min(len(dates), 7)):
                dia_dados = {
                    "data": dates[i],
                    "temperatura_maxima": temps_max[i] if i < len(temps_max) else None,
                    "temperatura_minima": temps_min[i] if i < len(temps_min) else None,
                    "precipitacao": precipitacao[i] if i < len(precipitacao) else 0
                }
                resultado["previsao_7_dias"].append(dia_dados)

            self.logger.info(f"Dados climáticos coletados para {regiao.NomeReg}: {len(resultado['previsao_7_dias'])} dias")
            return resultado

        except httpx.TimeoutException:
            self.logger.warning(f"Timeout ao coletar clima para {regiao.NomeReg}")
            return {
                "regiao_id": regiao.IDRegiao,
                "regiao_nome": regiao.NomeReg,
                "erro": "timeout"
            }

        except httpx.HTTPStatusError as e:
            self.logger.warning(f"Erro HTTP {e.response.status_code} ao coletar clima para {regiao.NomeReg}")
            return {
                "regiao_id": regiao.IDRegiao,
                "regiao_nome": regiao.NomeReg,
                "erro": f"http_error_{e.response.status_code}"
            }

        except Exception as e:
            self.logger.error(f"Erro inesperado ao coletar clima para {regiao.NomeReg}: {e}")
            return {
                "regiao_id": regiao.IDRegiao,
                "regiao_nome": regiao.NomeReg,
                "erro": f"erro_inesperado: {str(e)}"
            }

    # ==================== MÉTODO DE PROCESSAMENTO ====================

    def processar(self, dados_brutos: Dict, regiao: Regiao) -> List[Dict]:
        """
        Processa dados climáticos e gera alertas/eventos baseados em limiares.

        Args:
            dados_brutos: Dados retornados por coletar()
            regiao: Região dos dados

        Returns:
            Lista de alertas e eventos a criar
        """
        alertas_eventos = []

        try:
            previsao = dados_brutos.get("previsao_7_dias", [])

            if not previsao:
                self.logger.debug(f"Nenhuma previsão para processar em {regiao.NomeReg}")
                return alertas_eventos

            # Extrair temperaturas e precipitação
            temperaturas_max = []
            temperaturas_min = []
            precipitacoes = []

            for dia in previsao:
                if dia.get('temperatura_maxima') is not None:
                    temperaturas_max.append(dia['temperatura_maxima'])
                if dia.get('temperatura_minima') is not None:
                    temperaturas_min.append(dia['temperatura_minima'])
                if dia.get('precipitacao') is not None:
                    precipitacoes.append(dia['precipitacao'])

            # Detectar condições extremas
            self._detectar_onda_frio(temperaturas_min, regiao, alertas_eventos)
            self._detectar_onda_calor(temperaturas_max, regiao, alertas_eventos)
            self._detectar_tempo_seco(precipitacoes, regiao, alertas_eventos)

            self.logger.debug(
                f"Processamento clima {regiao.NomeReg}: {len(alertas_eventos)} alertas/eventos gerados"
            )

        except Exception as e:
            self.logger.error(f"Erro ao processar dados climáticos para {regiao.NomeReg}: {e}")

        return alertas_eventos

    def _detectar_onda_frio(self, temperaturas_min: List[float], regiao: Regiao, alertas_eventos: List[Dict]):
        """Detecta ondas de frio baseado nas temperaturas mínimas."""
        if not temperaturas_min:
            return

        # Contar dias consecutivos com frio
        dias_frio_media = 0
        dias_frio_alta = 0

        for temp in temperaturas_min:
            if temp <= self.LIMIARES["frio_alta"]:
                dias_frio_alta += 1
                dias_frio_media += 1
            elif temp <= self.LIMIARES["frio_media"]:
                dias_frio_media += 1
            else:
                # Reset contador se temperatura sobe
                if dias_frio_media >= 3 or dias_frio_alta >= 2:
                    break
                dias_frio_media = 0
                dias_frio_alta = 0

        # Determinar severidade
        severidade = None
        if dias_frio_alta >= 3:
            severidade = "ALTA"
        elif dias_frio_alta >= 2:
            severidade = "MEDIA"
        elif dias_frio_media >= 4:
            severidade = "MEDIA"

        if severidade:
            temp_minima = min(temperaturas_min)
            data_hoje = date.today()

            alerta = {
                "tipo": "alerta",
                "dados": {
                    "tipo": "ONDA_FRIO",
                    "severidade": severidade,
                    "regiao_id": regiao.IDRegiao,
                    "data_inicio": data_hoje,
                    "data_fim": data_hoje + timedelta(days=dias_frio_media),
                    "descricao": (
                        f"Onda de frio detectada em {regiao.NomeReg}. "
                        f"Temperatura mínima prevista: {temp_minima:.1f}°C. "
                        f"{dias_frio_media} dias consecutivos com frio. "
                        f"Possível aumento na demanda por antigripais e antitérmicos."
                    ),
                    "acao": self.ACOES["ONDA_FRIO"]
                }
            }

            evento = {
                "tipo": "evento",
                "dados": {
                    "tipo": "ONDA_FRIO",
                    "descricao": f"Onda de frio: {temp_minima:.1f}°C por {dias_frio_media} dias",
                    "data_inicio": data_hoje,
                    "data_fim": data_hoje + timedelta(days=dias_frio_media),
                    "regiao_id": regiao.IDRegiao,
                    "impacto": min(50.0 + dias_frio_media * 5, 100.0),  # Aumenta com duração
                    "categorias": self.CATEGORIAS["ONDA_FRIO"]
                }
            }

            alertas_eventos.extend([alerta, evento])

            self.logger.info(
                f"ONDA_FRIO {severidade} detectada em {regiao.NomeReg}: "
                f"{temp_minima:.1f}°C por {dias_frio_media} dias"
            )

    def _detectar_onda_calor(self, temperaturas_max: List[float], regiao: Regiao, alertas_eventos: List[Dict]):
        """Detecta ondas de calor baseado nas temperaturas máximas."""
        if not temperaturas_max:
            return

        # Contar dias consecutivos com calor
        dias_calor_media = 0
        dias_calor_alta = 0

        for temp in temperaturas_max:
            if temp >= self.LIMIARES["calor_alta"]:
                dias_calor_alta += 1
                dias_calor_media += 1
            elif temp >= self.LIMIARES["calor_media"]:
                dias_calor_media += 1
            else:
                # Reset contador se temperatura baixa
                if dias_calor_media >= 3 or dias_calor_alta >= 2:
                    break
                dias_calor_media = 0
                dias_calor_alta = 0

        # Determinar severidade
        severidade = None
        if dias_calor_alta >= 3:
            severidade = "ALTA"
        elif dias_calor_alta >= 2:
            severidade = "MEDIA"
        elif dias_calor_media >= 4:
            severidade = "MEDIA"

        if severidade:
            temp_maxima = max(temperaturas_max)
            data_hoje = date.today()

            alerta = {
                "tipo": "alerta",
                "dados": {
                    "tipo": "ONDA_CALOR",
                    "severidade": severidade,
                    "regiao_id": regiao.IDRegiao,
                    "data_inicio": data_hoje,
                    "data_fim": data_hoje + timedelta(days=dias_calor_media),
                    "descricao": (
                        f"Onda de calor detectada em {regiao.NomeReg}. "
                        f"Temperatura máxima prevista: {temp_maxima:.1f}°C. "
                        f"{dias_calor_media} dias consecutivos com calor intenso. "
                        f"Possível aumento na demanda por hidratantes e protetor solar."
                    ),
                    "acao": self.ACOES["ONDA_CALOR"]
                }
            }

            evento = {
                "tipo": "evento",
                "dados": {
                    "tipo": "ONDA_CALOR",
                    "descricao": f"Onda de calor: {temp_maxima:.1f}°C por {dias_calor_media} dias",
                    "data_inicio": data_hoje,
                    "data_fim": data_hoje + timedelta(days=dias_calor_media),
                    "regiao_id": regiao.IDRegiao,
                    "impacto": min(40.0 + dias_calor_media * 5, 100.0),  # Aumenta com duração
                    "categorias": self.CATEGORIAS["ONDA_CALOR"]
                }
            }

            alertas_eventos.extend([alerta, evento])

            self.logger.info(
                f"ONDA_CALOR {severidade} detectada em {regiao.NomeReg}: "
                f"{temp_maxima:.1f}°C por {dias_calor_media} dias"
            )

    def _detectar_tempo_seco(self, precipitacoes: List[float], regiao: Regiao, alertas_eventos: List[Dict]):
        """Detecta tempo seco prolongado baseado na precipitação."""
        if not precipitacoes:
            return

        # Contar dias consecutivos sem chuva (precipitação < 1mm)
        dias_sem_chuva = 0
        for precipitacao in precipitacoes:
            if precipitacao < 1.0:
                dias_sem_chuva += 1
            else:
                break  # Para no primeiro dia com chuva

        # Verificar se atinge o limiar
        if dias_sem_chuva >= self.LIMIARES["seco_dias"]:
            # Determinar severidade baseado na duração
            if dias_sem_chuva >= 14:
                severidade = "ALTA"
            elif dias_sem_chuva >= 10:
                severidade = "MEDIA"
            else:
                severidade = "MEDIA"

            data_hoje = date.today()
            precipitacao_total = sum(precipitacoes)

            alerta = {
                "tipo": "alerta",
                "dados": {
                    "tipo": "TEMPO_SECO",
                    "severidade": severidade,
                    "regiao_id": regiao.IDRegiao,
                    "data_inicio": data_hoje,
                    "data_fim": data_hoje + timedelta(days=dias_sem_chuva),
                    "descricao": (
                        f"Tempo seco prolongado detectado em {regiao.NomeReg}. "
                        f"{dias_sem_chuva} dias consecutivos sem chuva significativa. "
                        f"Precipitação total prevista: {precipitacao_total:.1f}mm. "
                        f"Possível aumento na demanda por soro fisiológico e colírios."
                    ),
                    "acao": self.ACOES["TEMPO_SECO"]
                }
            }

            evento = {
                "tipo": "evento",
                "dados": {
                    "tipo": "TEMPO_SECO",
                    "descricao": f"Tempo seco: {dias_sem_chuva} dias sem chuva",
                    "data_inicio": data_hoje,
                    "data_fim": data_hoje + timedelta(days=dias_sem_chuva),
                    "regiao_id": regiao.IDRegiao,
                    "impacto": min(30.0 + dias_sem_chuva * 2, 80.0),  # Aumenta com duração
                    "categorias": self.CATEGORIAS["TEMPO_SECO"]
                }
            }

            alertas_eventos.extend([alerta, evento])

            self.logger.info(
                f"TEMPO_SECO {severidade} detectado em {regiao.NomeReg}: "
                f"{dias_sem_chuva} dias sem chuva"
            )

    # ==================== CONTEXT MANAGER ====================

    async def __aenter__(self):
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        await self.close()