"""
AIONE IA - Coletor de Eventos de Calendário
Coleta feriados e eventos sazonais que impactam demanda farmacêutica
"""

import httpx
import json
from datetime import date, datetime, timedelta
from typing import Dict, List, Optional

from core.database import DatabaseManager
from core.utils import get_logger
from modules.compras.models import Regiao, Evento
from .base import ColetorBase


logger = get_logger(__name__)


class ColetorEventos(ColetorBase):
    """
    Coletor de eventos de calendário e feriados.

    Monitora datas comemorativas, feriados e eventos sazonais
    que podem impactar a demanda por produtos farmacêuticos.
    """

    def __init__(self, db: DatabaseManager):
        """
        Inicializa o coletor de eventos.

        Args:
            db: Instância do DatabaseManager
        """
        super().__init__(db)
        self._client: Optional[httpx.AsyncClient] = None

    # ==================== PROPRIEDADES ====================

    @property
    def nome(self) -> str:
        return "Calendario"

    @property
    def tipo_fonte(self) -> str:
        return "EVENTO"

    @property
    def frequencia_horas(self) -> int:
        return 24

    # ==================== CONSTANTES ====================

    URL_FERIADOS = "https://date.nager.at/api/v3/PublicHolidays/{ano}/BR"

    # Eventos fixos com impacto em farmácias
    EVENTOS_CALENDARIO = {
        "CARNAVAL": {
            "dias_antes": 7,
            "duracao": 5,
            "impacto": 80,
            "categorias": ["preservativos", "antiácidos", "analgésicos", "protetor_solar", "hidratantes"],
            "acao": "Reforçar preservativos, antiácidos, analgésicos, protetor solar"
        },
        "VOLTA_AULAS": {
            "mes": 2,
            "dia_inicio": 1,
            "duracao": 15,
            "impacto": 50,
            "categorias": ["piolhicidas", "vitaminas_infantis", "antialérgicos"],
            "acao": "Estocar piolhicidas, vitaminas infantis"
        },
        "DIA_MAES": {
            "dias_antes": 7,
            "duracao": 1,
            "impacto": 40,
            "categorias": ["perfumaria", "dermocosméticos"],
            "acao": "Reforçar perfumaria e dermocosméticos"
        },
        "DIA_NAMORADOS": {
            "data": (6, 12),
            "dias_antes": 7,
            "duracao": 1,
            "impacto": 40,
            "categorias": ["perfumaria", "dermocosméticos", "preservativos"],
            "acao": "Reforçar perfumaria, dermocosméticos, preservativos"
        },
        "DIA_PAIS": {
            "dias_antes": 7,
            "duracao": 1,
            "impacto": 30,
            "categorias": ["perfumaria", "dermocosméticos"],
            "acao": "Reforçar perfumaria masculina"
        },
        "INVERNO": {
            "mes_inicio": 6,
            "mes_fim": 9,
            "impacto": 60,
            "categorias": ["antigripais", "vitaminas", "hidratantes_labiais"],
            "acao": "Estoque sazonal de inverno"
        },
        "BLACK_FRIDAY": {
            "mes": 11,
            "semana": 4,  # 4ª sexta de novembro
            "dias_antes": 7,
            "duracao": 3,
            "impacto": 30,
            "categorias": ["dermocosméticos", "perfumaria", "vitaminas"],
            "acao": "Preparar promoções e estoque"
        },
        "NATAL_ANO_NOVO": {
            "mes": 12,
            "dia_inicio": 15,
            "duracao": 20,
            "impacto": 50,
            "categorias": ["perfumaria", "dermocosméticos", "antiácidos", "analgésicos"],
            "acao": "Reforço geral para festas"
        }
    }

    # Feriados nacionais como fallback
    FERIADOS_NACIONAIS = [
        (1, 1, "Ano Novo"),
        (2, 20, "Carnaval"),  # Data aproximada
        (4, 21, "Tiradentes"),
        (5, 1, "Dia do Trabalho"),
        (9, 7, "Independência do Brasil"),
        (10, 12, "Nossa Senhora Aparecida"),
        (11, 2, "Finados"),
        (11, 15, "Proclamação da República"),
        (12, 25, "Natal")
    ]

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

    # ==================== MÉTODOS DE CÁLCULO ====================

    def calcular_pascoa(self, ano: int) -> date:
        """
        Algoritmo de cálculo da Páscoa (Computus).

        Args:
            ano: Ano para calcular a Páscoa

        Returns:
            Data da Páscoa
        """
        # Algoritmo de Gauss para cálculo da Páscoa
        a = ano % 19
        b = ano // 100
        c = ano % 100
        d = b // 4
        e = b % 4
        f = (b + 8) // 25
        g = (b - f + 1) // 3
        h = (19 * a + b - d - g + 15) % 30
        i = c // 4
        k = c % 4
        l = (32 + 2 * e + 2 * i - h - k) % 7
        m = (a + 11 * h + 22 * l) // 451
        mes = (h + l - 7 * m + 114) // 31
        dia = ((h + l - 7 * m + 114) % 31) + 1

        return date(ano, mes, dia)

    def calcular_carnaval(self, ano: int) -> date:
        """47 dias antes da Páscoa."""
        pascoa = self.calcular_pascoa(ano)
        return pascoa - timedelta(days=47)

    def calcular_dia_maes(self, ano: int) -> date:
        """2º domingo de maio."""
        primeiro_maio = date(ano, 5, 1)
        # Encontrar primeiro domingo de maio
        dias_para_domingo = (6 - primeiro_maio.weekday()) % 7
        primeiro_domingo = primeiro_maio + timedelta(days=dias_para_domingo)
        # Segundo domingo
        return primeiro_domingo + timedelta(days=7)

    def calcular_dia_pais(self, ano: int) -> date:
        """2º domingo de agosto."""
        primeiro_agosto = date(ano, 8, 1)
        # Encontrar primeiro domingo de agosto
        dias_para_domingo = (6 - primeiro_agosto.weekday()) % 7
        primeiro_domingo = primeiro_agosto + timedelta(days=dias_para_domingo)
        # Segundo domingo
        return primeiro_domingo + timedelta(days=7)

    def calcular_black_friday(self, ano: int) -> date:
        """4ª sexta-feira de novembro."""
        primeiro_novembro = date(ano, 11, 1)
        # Encontrar primeira sexta-feira
        dias_para_sexta = (4 - primeiro_novembro.weekday()) % 7
        primeira_sexta = primeiro_novembro + timedelta(days=dias_para_sexta)
        # Quarta sexta-feira
        return primeira_sexta + timedelta(days=21)

    def evento_existe(self, descricao: str, data_inicio: date) -> bool:
        """
        Verifica se evento já cadastrado.

        Args:
            descricao: Descrição do evento
            data_inicio: Data de início

        Returns:
            True se evento já existe
        """
        try:
            with self.db.session_scope() as session:
                evento = session.query(Evento).filter(
                    Evento.DescEvt == descricao,
                    Evento.DatInicio == data_inicio
                ).first()

                return evento is not None

        except Exception as e:
            self.logger.warning(f"Erro ao verificar existência do evento: {e}")
            return False

    # ==================== MÉTODOS ABSTRATOS ====================

    async def coletar(self, regiao: Regiao) -> Dict:
        """
        Coleta eventos e feriados para uma região específica.

        Args:
            regiao: Região para coletar dados

        Returns:
            Dicionário com eventos dos próximos 30 dias
        """
        try:
            eventos_proximos = []
            hoje = date.today()
            ano_atual = hoje.year
            ano_proximo = ano_atual + 1

            # Coletar feriados da API
            feriados_api = []
            for ano in [ano_atual, ano_proximo]:
                try:
                    feriados_ano = await self._buscar_feriados_api(ano)
                    feriados_api.extend(feriados_ano)
                except Exception as e:
                    self.logger.warning(f"Falha ao buscar feriados {ano} da API: {e}")

            # Se API falhou, usar feriados hardcoded
            if not feriados_api:
                self.logger.info("Usando feriados nacionais como fallback")
                feriados_api = self._obter_feriados_fallback()

            # Calcular eventos do calendário
            eventos_calculados = self._calcular_eventos_calendario(ano_atual, ano_proximo)

            # Combinar todos os eventos
            todos_eventos = feriados_api + eventos_calculados

            # Filtrar eventos dos próximos 30 dias
            limite_data = hoje + timedelta(days=30)
            for evento in todos_eventos:
                data_evento = evento.get('data')
                if isinstance(data_evento, str):
                    data_evento = datetime.fromisoformat(data_evento).date()

                if hoje <= data_evento <= limite_data:
                    eventos_proximos.append(evento)

            # Ordenar por data
            eventos_proximos.sort(key=lambda x: x['data'] if isinstance(x['data'], date) else datetime.fromisoformat(x['data']).date())

            resultado = {
                "regiao_id": regiao.IDRegiao,
                "regiao_nome": regiao.NomeReg,
                "eventos_proximos": eventos_proximos,
                "data_coleta": datetime.now().isoformat()
            }

            self.logger.info(
                f"Eventos coletados para {regiao.NomeReg}: {len(eventos_proximos)} eventos próximos"
            )

            return resultado

        except Exception as e:
            self.logger.error(f"Erro ao coletar eventos para {regiao.NomeReg}: {e}")
            return {
                "regiao_id": regiao.IDRegiao,
                "eventos_proximos": [],
                "erro": str(e)
            }

    async def _buscar_feriados_api(self, ano: int) -> List[Dict]:
        """Busca feriados da API externa."""
        try:
            url = self.URL_FERIADOS.format(ano=ano)
            response = await self.client.get(url)
            response.raise_for_status()

            feriados_api = response.json()
            feriados = []

            for feriado in feriados_api:
                data_str = feriado.get('date')
                if data_str:
                    data_feriado = datetime.fromisoformat(data_str).date()
                    feriados.append({
                        "nome": feriado.get('localName', feriado.get('name', 'Feriado')),
                        "data": data_feriado,
                        "tipo": "feriado_nacional",
                        "impacto": 20,  # Impacto baixo para feriados gerais
                        "categorias": ["antiácidos", "analgésicos"],  # Produtos gerais
                        "acao": "Verificar estoque básico"
                    })

            return feriados

        except Exception as e:
            self.logger.error(f"Erro ao buscar feriados do ano {ano}: {e}")
            raise

    def _obter_feriados_fallback(self) -> List[Dict]:
        """Retorna feriados nacionais como fallback."""
        feriados = []
        hoje = date.today()

        for mes, dia, nome in self.FERIADOS_NACIONAIS:
            for ano in [hoje.year, hoje.year + 1]:
                try:
                    data_feriado = date(ano, mes, dia)
                    feriados.append({
                        "nome": nome,
                        "data": data_feriado,
                        "tipo": "feriado_nacional",
                        "impacto": 20,
                        "categorias": ["antiácidos", "analgésicos"],
                        "acao": "Verificar estoque básico"
                    })
                except ValueError:
                    continue

        return feriados

    def _calcular_eventos_calendario(self, ano_atual: int, ano_proximo: int) -> List[Dict]:
        """Calcula eventos do calendário com datas móveis."""
        eventos = []

        for ano in [ano_atual, ano_proximo]:
            # Carnaval
            data_carnaval = self.calcular_carnaval(ano)
            config_carnaval = self.EVENTOS_CALENDARIO["CARNAVAL"]
            eventos.append({
                "nome": "Carnaval",
                "data": data_carnaval,
                "tipo": "CARNAVAL",
                "impacto": config_carnaval["impacto"],
                "categorias": config_carnaval["categorias"],
                "acao": config_carnaval["acao"],
                "duracao": config_carnaval["duracao"]
            })

            # Dia das Mães
            data_dia_maes = self.calcular_dia_maes(ano)
            config_maes = self.EVENTOS_CALENDARIO["DIA_MAES"]
            eventos.append({
                "nome": "Dia das Mães",
                "data": data_dia_maes,
                "tipo": "DIA_MAES",
                "impacto": config_maes["impacto"],
                "categorias": config_maes["categorias"],
                "acao": config_maes["acao"],
                "duracao": config_maes["duracao"]
            })

            # Dia dos Pais
            data_dia_pais = self.calcular_dia_pais(ano)
            config_pais = self.EVENTOS_CALENDARIO["DIA_PAIS"]
            eventos.append({
                "nome": "Dia dos Pais",
                "data": data_dia_pais,
                "tipo": "DIA_PAIS",
                "impacto": config_pais["impacto"],
                "categorias": config_pais["categorias"],
                "acao": config_pais["acao"],
                "duracao": config_pais["duracao"]
            })

            # Black Friday
            data_black_friday = self.calcular_black_friday(ano)
            config_black = self.EVENTOS_CALENDARIO["BLACK_FRIDAY"]
            eventos.append({
                "nome": "Black Friday",
                "data": data_black_friday,
                "tipo": "BLACK_FRIDAY",
                "impacto": config_black["impacto"],
                "categorias": config_black["categorias"],
                "acao": config_black["acao"],
                "duracao": config_black["duracao"]
            })

            # Eventos com datas fixas
            # Dia dos Namorados
            config_namorados = self.EVENTOS_CALENDARIO["DIA_NAMORADOS"]
            mes, dia = config_namorados["data"]
            try:
                data_namorados = date(ano, mes, dia)
                eventos.append({
                    "nome": "Dia dos Namorados",
                    "data": data_namorados,
                    "tipo": "DIA_NAMORADOS",
                    "impacto": config_namorados["impacto"],
                    "categorias": config_namorados["categorias"],
                    "acao": config_namorados["acao"],
                    "duracao": config_namorados["duracao"]
                })
            except ValueError:
                pass

            # Volta às Aulas
            config_aulas = self.EVENTOS_CALENDARIO["VOLTA_AULAS"]
            try:
                data_volta_aulas = date(ano, config_aulas["mes"], config_aulas["dia_inicio"])
                eventos.append({
                    "nome": "Volta às Aulas",
                    "data": data_volta_aulas,
                    "tipo": "VOLTA_AULAS",
                    "impacto": config_aulas["impacto"],
                    "categorias": config_aulas["categorias"],
                    "acao": config_aulas["acao"],
                    "duracao": config_aulas["duracao"]
                })
            except ValueError:
                pass

            # Natal e Ano Novo
            config_natal = self.EVENTOS_CALENDARIO["NATAL_ANO_NOVO"]
            try:
                data_natal = date(ano, config_natal["mes"], config_natal["dia_inicio"])
                eventos.append({
                    "nome": "Período Natalino",
                    "data": data_natal,
                    "tipo": "NATAL_ANO_NOVO",
                    "impacto": config_natal["impacto"],
                    "categorias": config_natal["categorias"],
                    "acao": config_natal["acao"],
                    "duracao": config_natal["duracao"]
                })
            except ValueError:
                pass

            # Inverno (evento sazonal)
            config_inverno = self.EVENTOS_CALENDARIO["INVERNO"]
            try:
                data_inverno = date(ano, config_inverno["mes_inicio"], 1)
                eventos.append({
                    "nome": "Início do Inverno",
                    "data": data_inverno,
                    "tipo": "INVERNO",
                    "impacto": config_inverno["impacto"],
                    "categorias": config_inverno["categorias"],
                    "acao": config_inverno["acao"],
                    "duracao": 90  # 3 meses de inverno
                })
            except ValueError:
                pass

        return eventos

    def processar(self, dados_brutos: Dict, regiao: Regiao) -> List[Dict]:
        """
        Processa eventos e gera alertas/eventos no formato esperado pela ColetorBase.

        Args:
            dados_brutos: Dados retornados por coletar()
            regiao: Região dos dados

        Returns:
            Lista de dicionários com alertas/eventos no formato ColetorBase
        """
        alertas_eventos = []

        try:
            eventos_proximos = dados_brutos.get("eventos_proximos", [])

            if not eventos_proximos:
                self.logger.debug(f"Nenhum evento próximo para processar em {regiao.NomeReg}")
                return alertas_eventos

            hoje = date.today()

            # Processar eventos dos próximos 14 dias
            for evento_data in eventos_proximos:
                try:
                    data_evento = evento_data.get('data')
                    if isinstance(data_evento, str):
                        data_evento = datetime.fromisoformat(data_evento).date()

                    dias_para_evento = (data_evento - hoje).days

                    # Só processar eventos dos próximos 14 dias
                    if dias_para_evento > 14:
                        continue

                    nome_evento = evento_data.get('nome', 'Evento')
                    tipo_evento = evento_data.get('tipo', 'GERAL')

                    # Verificar se evento já existe
                    if self.evento_existe(nome_evento, data_evento):
                        self.logger.debug(f"Evento {nome_evento} em {data_evento} já existe, pulando")
                        continue

                    duracao = evento_data.get('duracao', 1)
                    data_fim = data_evento + timedelta(days=duracao - 1)
                    impacto = evento_data.get('impacto', 30)
                    categorias = evento_data.get('categorias', [])
                    acao = evento_data.get('acao', f"Verificar demanda para {nome_evento}")

                    # Criar evento no formato ColetorBase
                    evento = {
                        "tipo": "evento",
                        "dados": {
                            "tipo": tipo_evento,
                            "descricao": f"{nome_evento} - {data_evento.strftime('%d/%m/%Y')}",
                            "data_inicio": data_evento,
                            "data_fim": data_fim,
                            "regiao_id": regiao.IDRegiao,
                            "impacto": float(impacto),
                            "categorias": categorias
                        }
                    }

                    alertas_eventos.append(evento)

                    # Se evento está em menos de 7 dias, criar alerta
                    if dias_para_evento <= 7:
                        severidade = "ALTA" if impacto >= 60 else "MEDIA"

                        alerta = {
                            "tipo": "alerta",
                            "dados": {
                                "tipo": "EVENTO_GRANDE",
                                "severidade": severidade,
                                "regiao_id": regiao.IDRegiao,
                                "data_inicio": hoje,
                                "data_fim": data_evento,
                                "descricao": (
                                    f"{nome_evento} se aproxima em {dias_para_evento} dias ({data_evento.strftime('%d/%m/%Y')}). "
                                    f"Possível aumento significativo na demanda. Impacto estimado: {impacto}%."
                                ),
                                "acao": acao
                            }
                        }

                        alertas_eventos.append(alerta)

                        self.logger.info(
                            f"Alerta EVENTO_GRANDE {severidade} gerado para {nome_evento} "
                            f"em {regiao.NomeReg}: {dias_para_evento} dias restantes"
                        )

                except Exception as e:
                    self.logger.warning(f"Erro ao processar evento {evento_data.get('nome', 'desconhecido')}: {e}")

            self.logger.debug(f"Processamento concluído para {regiao.NomeReg}: {len(alertas_eventos)} alertas/eventos gerados")

        except Exception as e:
            self.logger.error(f"Erro ao processar eventos para {regiao.NomeReg}: {e}")

        return alertas_eventos

    # ==================== CONTEXT MANAGER ====================

    async def __aenter__(self):
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        await self.close()