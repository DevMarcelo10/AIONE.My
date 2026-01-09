"""
AIONE IA - Coletor de Google Trends
Coleta tendências de busca e gera alertas de alta demanda
"""

import asyncio
import time
from datetime import datetime, timedelta, date
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils import get_logger
from modules.compras.models import Regiao
from .base import ColetorBase


logger = get_logger(__name__)


class ColetorTrends(ColetorBase):
    """
    Coletor de tendências de busca do Google Trends.

    Monitora termos relacionados à saúde para prever demandas
    e gera alertas baseado em limiares de interesse.
    """

    @property
    def nome(self) -> str:
        return "GoogleTrends"

    @property
    def tipo_fonte(self) -> str:
        return "TENDENCIA"

    @property
    def frequencia_horas(self) -> int:
        return 4

    # Keywords organizadas por categoria
    KEYWORDS_SAUDE = [
        "dor de cabeça",
        "gripe",
        "febre",
        "alergia",
        "dor de garganta"
    ]

    KEYWORDS_DENGUE = [
        "dengue",
        "mosquito",
        "repelente"
    ]

    # Limiares de interesse (0-100)
    LIMIARES = {
        "alta": 75,
        "muito_alta": 90
    }

    # Ações recomendadas por keyword
    ACOES = {
        "gripe": "Verificar estoque de antigripais e antitérmicos",
        "febre": "Verificar estoque de antitérmicos",
        "dengue": "Reforçar repelentes e analgésicos",
        "alergia": "Verificar antialérgicos e colírios",
        "dor de cabeça": "Verificar analgésicos",
        "dor de garganta": "Verificar anti-inflamatórios e pastilhas"
    }

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o coletor de Google Trends.

        Args:
            db: Instância do DatabaseManager
        """
        super().__init__(db)
        self._pytrends = None
        self._last_request_time = 0

    async def _get_pytrends(self):
        """Inicializa pytrends de forma lazy."""
        if self._pytrends is None:
            try:
                # Import dinâmico para evitar erro se não estiver instalado
                from pytrends.request import TrendReq

                # Executa em thread separada pois TrendReq pode fazer I/O
                loop = asyncio.get_event_loop()
                self._pytrends = await loop.run_in_executor(
                    None, lambda: TrendReq(hl='pt-BR', tz=-180, timeout=(10, 25))
                )
                logger.debug("Cliente pytrends inicializado")

            except ImportError:
                logger.error("pytrends não instalado. Execute: pip install pytrends")
                raise
            except Exception as e:
                logger.error(f"Erro ao inicializar pytrends: {e}")
                raise

        return self._pytrends

    def _determinar_geo_code(self, regiao: Regiao) -> Optional[str]:
        """
        Determina código geográfico baseado no nível da região.

        Args:
            regiao: Região para determinar código

        Returns:
            Código geográfico ou None se não disponível
        """
        try:
            if regiao.NivelGeo == "CIDADE" and regiao.GeoTrends:
                return regiao.GeoTrends
            elif regiao.NivelGeo == "METRO" and regiao.GeoMetro:
                return regiao.GeoMetro
            elif regiao.NivelGeo == "ESTADO" and regiao.GeoEstado:
                return regiao.GeoEstado
            elif regiao.UF_Reg:
                # Fallback: tenta usar código UF brasileiro
                codigos_uf = {
                    'AC': 'BR-AC', 'AL': 'BR-AL', 'AP': 'BR-AP', 'AM': 'BR-AM',
                    'BA': 'BR-BA', 'CE': 'BR-CE', 'DF': 'BR-DF', 'ES': 'BR-ES',
                    'GO': 'BR-GO', 'MA': 'BR-MA', 'MT': 'BR-MT', 'MS': 'BR-MS',
                    'MG': 'BR-MG', 'PA': 'BR-PA', 'PB': 'BR-PB', 'PR': 'BR-PR',
                    'PE': 'BR-PE', 'PI': 'BR-PI', 'RJ': 'BR-RJ', 'RN': 'BR-RN',
                    'RS': 'BR-RS', 'RO': 'BR-RO', 'RR': 'BR-RR', 'SC': 'BR-SC',
                    'SP': 'BR-SP', 'SE': 'BR-SE', 'TO': 'BR-TO'
                }
                return codigos_uf.get(regiao.UF_Reg, 'BR')
            else:
                return 'BR'  # Brasil como fallback

        except Exception as e:
            logger.warning(f"Erro ao determinar código geo para {regiao.NomeReg}: {e}")
            return 'BR'

    async def _rate_limit(self):
        """Implementa rate limiting de 2s entre requisições."""
        now = time.time()
        elapsed = now - self._last_request_time

        if elapsed < 2.0:
            wait_time = 2.0 - elapsed
            logger.debug(f"Rate limiting: aguardando {wait_time:.1f}s")
            await asyncio.sleep(wait_time)

        self._last_request_time = time.time()

    async def _coletar_keywords_grupo(
        self,
        keywords: List[str],
        geo_code: str,
        max_retries: int = 3
    ) -> Dict[str, float]:
        """
        Coleta interesse para um grupo de keywords (máx 5).

        Args:
            keywords: Lista de até 5 keywords
            geo_code: Código geográfico
            max_retries: Tentativas máximas

        Returns:
            Dicionário {keyword: interesse_relativo}
        """
        for tentativa in range(max_retries):
            try:
                # Rate limiting
                await self._rate_limit()

                pytrends = await self._get_pytrends()

                # Executa coleta em thread separada (pytrends é síncrono)
                loop = asyncio.get_event_loop()
                resultado = await loop.run_in_executor(
                    None,
                    self._coletar_sync,
                    pytrends,
                    keywords,
                    geo_code
                )

                return resultado

            except Exception as e:
                logger.warning(
                    f"Tentativa {tentativa + 1} falhou para {keywords} "
                    f"(geo: {geo_code}): {e}"
                )

                # Se erro 400 (região sem dados), tenta fallback
                if "400" in str(e) and geo_code != 'BR':
                    logger.info(f"Região {geo_code} sem dados, tentando Brasil")
                    geo_code = 'BR'
                    continue

                # Se TooManyRequestsError ou erro similar
                if tentativa < max_retries - 1:
                    if "429" in str(e) or "too many" in str(e).lower():
                        wait_time = 60
                        logger.warning(f"Rate limit atingido, aguardando {wait_time}s")
                        await asyncio.sleep(wait_time)
                    else:
                        # Para outros erros, aguarda menos tempo
                        await asyncio.sleep(5)

        # Se todas as tentativas falharam
        logger.error(f"Falha ao coletar keywords {keywords} após {max_retries} tentativas")
        return {}

    def _coletar_sync(
        self,
        pytrends,
        keywords: List[str],
        geo_code: str
    ) -> Dict[str, float]:
        """
        Método síncrono para coleta via pytrends.

        Args:
            pytrends: Instância do TrendReq
            keywords: Keywords a coletar
            geo_code: Código geográfico

        Returns:
            Dicionário com interesses
        """
        try:
            # Constrói payload para últimos 7 dias
            pytrends.build_payload(
                kw_list=keywords,
                geo=geo_code,
                timeframe='now 7-d'
            )

            # Obtém interesse ao longo do tempo
            interest_df = pytrends.interest_over_time()

            if interest_df.empty:
                logger.debug(f"Nenhum dado de interesse para {keywords} em {geo_code}")
                return {}

            # Remove coluna 'isPartial' se existir
            if 'isPartial' in interest_df.columns:
                interest_df = interest_df.drop('isPartial', axis=1)

            # Calcula média dos últimos valores para cada keyword
            resultado = {}
            for keyword in keywords:
                if keyword in interest_df.columns:
                    valores = interest_df[keyword].dropna()
                    if not valores.empty:
                        # Média dos últimos 3 dias ou todos se menos que 3
                        interesse_medio = float(valores.tail(3).mean())
                        resultado[keyword] = interesse_medio

            return resultado

        except Exception as e:
            logger.error(f"Erro em coleta síncrona: {e}")
            raise

    async def coletar(self, regiao: Regiao) -> Dict:
        """
        Coleta tendências do Google Trends para uma região.

        Args:
            regiao: Região para coletar dados

        Returns:
            Dicionário com interesses por keyword ou vazio se erro
        """
        try:
            # Determina código geográfico
            geo_code = self._determinar_geo_code(regiao)
            if not geo_code:
                logger.warning(f"Código geográfico não disponível para {regiao.NomeReg}")
                return {"regiao_id": regiao.IDRegiao, "interesses": {}, "erro": "geo_indisponivel"}

            logger.info(f"Coletando trends para {regiao.NomeReg} (geo: {geo_code})")

            # Combina todas as keywords
            todas_keywords = self.KEYWORDS_SAUDE + self.KEYWORDS_DENGUE

            # Divide em grupos de até 5 (limitação do Google Trends)
            grupos = [todas_keywords[i:i+5] for i in range(0, len(todas_keywords), 5)]

            interesses = {}
            geo_final = geo_code

            # Coleta cada grupo
            for i, grupo in enumerate(grupos):
                logger.debug(f"Coletando grupo {i+1}/{len(grupos)}: {grupo}")

                resultado_grupo = await self._coletar_keywords_grupo(grupo, geo_final)

                if resultado_grupo:
                    interesses.update(resultado_grupo)
                elif geo_final != 'BR':
                    # Se falhou e não é Brasil, tenta fallback
                    logger.info(f"Fallback para Brasil no grupo {i+1}")
                    geo_final = 'BR'
                    resultado_grupo = await self._coletar_keywords_grupo(grupo, geo_final)
                    if resultado_grupo:
                        interesses.update(resultado_grupo)

            # Se mudou o geo_code por fallback, atualiza região
            if geo_final != geo_code and geo_final == 'BR':
                logger.info(f"Região {regiao.NomeReg} atualizada para usar geo Brasil")
                # Aqui poderia atualizar o NivelGeo da região se necessário

            resultado = {
                "regiao_id": regiao.IDRegiao,
                "regiao_nome": regiao.NomeReg,
                "geo_code": geo_final,
                "interesses": interesses,
                "data_coleta": datetime.now().isoformat()
            }

            logger.info(
                f"Dados coletados para {regiao.NomeReg}: "
                f"{len(interesses)} keywords com dados"
            )

            return resultado

        except Exception as e:
            logger.error(f"Erro ao coletar trends para {regiao.NomeReg}: {e}")
            return {
                "regiao_id": regiao.IDRegiao,
                "interesses": {},
                "erro": str(e)
            }

    def processar(self, dados_brutos: Dict, regiao: Regiao) -> List[Dict]:
        """
        Processa dados de trends e gera alertas de tendência alta no formato esperado pela ColetorBase.

        Args:
            dados_brutos: Dados retornados por coletar()
            regiao: Região dos dados

        Returns:
            Lista de dicionários com alertas/eventos no formato ColetorBase
        """
        alertas_eventos = []

        try:
            interesses = dados_brutos.get("interesses", {})

            if not interesses:
                self.logger.debug(f"Nenhum dado de interesse para processar em {regiao.NomeReg}")
                return alertas_eventos

            # Processa cada keyword
            for keyword, interesse in interesses.items():
                try:
                    interesse_val = float(interesse)

                    # Verifica limiares
                    severidade = None
                    if interesse_val >= self.LIMIARES["muito_alta"]:
                        severidade = "ALTA"
                    elif interesse_val >= self.LIMIARES["alta"]:
                        severidade = "MEDIA"

                    if severidade:
                        # Determina categorias baseada na keyword
                        if keyword in self.KEYWORDS_DENGUE:
                            categorias = ["repelentes", "analgésicos", "antitérmicos"]
                        elif keyword in ["gripe", "febre"]:
                            categorias = ["antigripais", "antitérmicos"]
                        elif keyword == "alergia":
                            categorias = ["antialérgicos", "colírios"]
                        elif keyword == "dor de cabeça":
                            categorias = ["analgésicos"]
                        elif keyword == "dor de garganta":
                            categorias = ["anti-inflamatórios", "pastilhas"]
                        else:
                            categorias = ["medicamentos_gerais"]

                        acao = self.ACOES.get(keyword, f"Verificar estoque relacionado a '{keyword}'")

                        data_hoje = date.today()
                        data_fim = data_hoje + timedelta(days=3)

                        # Criar alerta no formato ColetorBase
                        alerta = {
                            "tipo": "alerta",
                            "dados": {
                                "tipo": "TENDENCIA_ALTA",
                                "severidade": severidade,
                                "regiao_id": regiao.IDRegiao,
                                "data_inicio": data_hoje,
                                "data_fim": data_fim,
                                "descricao": (
                                    f"Alta tendência de busca por '{keyword}' detectada em {regiao.NomeReg}. "
                                    f"Interesse relativo: {interesse_val:.0f}/100. "
                                    f"Possível aumento da demanda por produtos relacionados."
                                ),
                                "acao": acao
                            }
                        }

                        # Criar evento correspondente
                        evento = {
                            "tipo": "evento",
                            "dados": {
                                "tipo": "TENDENCIA_ALTA",
                                "descricao": f"Tendência alta para '{keyword}': {interesse_val:.0f}% de interesse",
                                "data_inicio": data_hoje,
                                "data_fim": data_fim,
                                "regiao_id": regiao.IDRegiao,
                                "impacto": min(interesse_val, 100.0),  # Usar interesse relativo como impacto
                                "categorias": categorias
                            }
                        }

                        alertas_eventos.extend([alerta, evento])

                        self.logger.info(
                            f"Alerta TENDENCIA_ALTA {severidade} gerado para '{keyword}' "
                            f"em {regiao.NomeReg}: interesse {interesse_val:.0f}%"
                        )

                except (ValueError, TypeError) as e:
                    self.logger.warning(f"Erro ao processar interesse da keyword '{keyword}': {e}")

            self.logger.debug(f"Processamento concluído para {regiao.NomeReg}: {len(alertas_eventos)} alertas/eventos gerados")

        except Exception as e:
            self.logger.error(f"Erro ao processar dados de trends para {regiao.NomeReg}: {e}")

        return alertas_eventos

    async def close(self):
        """Limpa recursos."""
        self._pytrends = None

    async def __aenter__(self):
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        await self.close()