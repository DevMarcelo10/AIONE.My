"""
AIONE IA - Helpers
Funções auxiliares de uso geral para o sistema AIONE
"""

import functools
import json
import re
import time
import unicodedata
from datetime import datetime, date
from decimal import Decimal, DecimalException
from typing import Any, Callable, Optional, TypeVar, Union
from zoneinfo import ZoneInfo


# Timezone do Brasil
BR_TIMEZONE = ZoneInfo('America/Sao_Paulo')

# Type hints
F = TypeVar('F', bound=Callable[..., Any])


# ===========================================
# FUNÇÕES DE DATA/HORA
# ===========================================

def now_br() -> datetime:
    """
    Retorna datetime atual no fuso horário do Brasil.

    Returns:
        datetime atual em America/Sao_Paulo

    Examples:
        >>> agora = now_br()
        >>> print(agora.strftime('%d/%m/%Y %H:%M:%S'))
    """
    return datetime.now(BR_TIMEZONE)


def today_br() -> date:
    """
    Retorna data atual no fuso horário do Brasil.

    Returns:
        date atual no Brasil

    Examples:
        >>> hoje = today_br()
        >>> print(hoje.strftime('%d/%m/%Y'))
    """
    return now_br().date()


def format_datetime(dt: datetime, fmt: str = "%d/%m/%Y %H:%M") -> str:
    """
    Formata datetime para string usando formato brasileiro.

    Args:
        dt: datetime a ser formatado
        fmt: formato de saída (padrão brasileiro)

    Returns:
        String formatada

    Examples:
        >>> dt = datetime(2024, 12, 25, 14, 30)
        >>> format_datetime(dt)
        '25/12/2024 14:30'
        >>> format_datetime(dt, "%d/%m/%Y")
        '25/12/2024'
    """
    if dt is None:
        return ""
    return dt.strftime(fmt)


def parse_datetime(text: str, fmt: str = "%d/%m/%Y %H:%M") -> datetime:
    """
    Converte string para datetime usando formato brasileiro.

    Args:
        text: string a ser convertida
        fmt: formato de entrada (padrão brasileiro)

    Returns:
        datetime convertido

    Raises:
        ValueError: se não conseguir converter

    Examples:
        >>> dt = parse_datetime("25/12/2024 14:30")
        >>> dt = parse_datetime("25/12/2024", "%d/%m/%Y")
    """
    if not text:
        raise ValueError("String vazia")
    return datetime.strptime(text.strip(), fmt)


# ===========================================
# FUNÇÕES DE TEXTO
# ===========================================

def sanitize_string(text: str) -> str:
    """
    Remove acentos e caracteres especiais, mantendo apenas alfanuméricos.

    Args:
        text: texto a ser sanitizado

    Returns:
        texto sanitizado

    Examples:
        >>> sanitize_string("José da Silva Saúde & Cia.")
        'Jose da Silva Saude  Cia'
        >>> sanitize_string("123 ABC ção")
        '123 ABC cao'
    """
    if not text:
        return ""

    # Remove acentos usando NFD (decomposição)
    text = unicodedata.normalize('NFD', text)
    text = ''.join(c for c in text if unicodedata.category(c) != 'Mn')

    # Mantém apenas letras, números e espaços
    text = re.sub(r'[^A-Za-z0-9\s]', '', text)

    # Remove espaços extras
    text = re.sub(r'\s+', ' ', text).strip()

    return text


def truncate(text: str, max_len: int, suffix: str = "...") -> str:
    """
    Trunca texto respeitando limite de caracteres.

    Args:
        text: texto a ser truncado
        max_len: comprimento máximo
        suffix: sufixo para indicar truncamento

    Returns:
        texto truncado

    Examples:
        >>> truncate("Este é um texto muito longo", 15)
        'Este é um te...'
        >>> truncate("Texto curto", 20)
        'Texto curto'
    """
    if not text:
        return ""

    if len(text) <= max_len:
        return text

    if max_len < len(suffix):
        return suffix[:max_len]

    return text[:max_len - len(suffix)] + suffix


# ===========================================
# FUNÇÕES DE VALIDAÇÃO
# ===========================================

def _calculate_cpf_digit(cpf_digits: list[int], weights: list[int]) -> int:
    """Calcula dígito verificador do CPF."""
    total = sum(digit * weight for digit, weight in zip(cpf_digits, weights))
    remainder = total % 11
    return 0 if remainder < 2 else 11 - remainder


def is_valid_cpf(cpf: str) -> bool:
    """
    Valida CPF brasileiro.

    Args:
        cpf: CPF a ser validado (com ou sem formatação)

    Returns:
        True se válido, False caso contrário

    Examples:
        >>> is_valid_cpf("123.456.789-09")
        True
        >>> is_valid_cpf("12345678909")
        True
        >>> is_valid_cpf("111.111.111-11")
        False
    """
    if not cpf:
        return False

    # Remove formatação
    cpf = re.sub(r'[^0-9]', '', cpf)

    # Verifica se tem 11 dígitos
    if len(cpf) != 11:
        return False

    # Verifica se não são todos iguais
    if cpf == cpf[0] * 11:
        return False

    # Converte para lista de inteiros
    digits = [int(d) for d in cpf]

    # Verifica primeiro dígito
    first_digit = _calculate_cpf_digit(digits[:9], list(range(10, 1, -1)))
    if digits[9] != first_digit:
        return False

    # Verifica segundo dígito
    second_digit = _calculate_cpf_digit(digits[:10], list(range(11, 1, -1)))
    if digits[10] != second_digit:
        return False

    return True


def _calculate_cnpj_digit(cnpj_digits: list[int], weights: list[int]) -> int:
    """Calcula dígito verificador do CNPJ."""
    total = sum(digit * weight for digit, weight in zip(cnpj_digits, weights))
    remainder = total % 11
    return 0 if remainder < 2 else 11 - remainder


def is_valid_cnpj(cnpj: str) -> bool:
    """
    Valida CNPJ brasileiro.

    Args:
        cnpj: CNPJ a ser validado (com ou sem formatação)

    Returns:
        True se válido, False caso contrário

    Examples:
        >>> is_valid_cnpj("11.222.333/0001-81")
        True
        >>> is_valid_cnpj("11222333000181")
        True
        >>> is_valid_cnpj("11.111.111/1111-11")
        False
    """
    if not cnpj:
        return False

    # Remove formatação
    cnpj = re.sub(r'[^0-9]', '', cnpj)

    # Verifica se tem 14 dígitos
    if len(cnpj) != 14:
        return False

    # Verifica se não são todos iguais
    if cnpj == cnpj[0] * 14:
        return False

    # Converte para lista de inteiros
    digits = [int(d) for d in cnpj]

    # Pesos para cálculo dos dígitos
    weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    # Verifica primeiro dígito
    first_digit = _calculate_cnpj_digit(digits[:12], weights1)
    if digits[12] != first_digit:
        return False

    # Verifica segundo dígito
    second_digit = _calculate_cnpj_digit(digits[:13], weights2)
    if digits[13] != second_digit:
        return False

    return True


def format_cpf(cpf: str) -> str:
    """
    Formata CPF no padrão brasileiro (000.000.000-00).

    Args:
        cpf: CPF a ser formatado

    Returns:
        CPF formatado

    Examples:
        >>> format_cpf("12345678909")
        '123.456.789-09'
        >>> format_cpf("123.456.789-09")
        '123.456.789-09'
    """
    if not cpf:
        return ""

    # Remove formatação existente
    cpf = re.sub(r'[^0-9]', '', cpf)

    if len(cpf) != 11:
        return cpf  # Retorna original se não tiver 11 dígitos

    return f"{cpf[:3]}.{cpf[3:6]}.{cpf[6:9]}-{cpf[9:]}"


def format_cnpj(cnpj: str) -> str:
    """
    Formata CNPJ no padrão brasileiro (00.000.000/0000-00).

    Args:
        cnpj: CNPJ a ser formatado

    Returns:
        CNPJ formatado

    Examples:
        >>> format_cnpj("11222333000181")
        '11.222.333/0001-81'
        >>> format_cnpj("11.222.333/0001-81")
        '11.222.333/0001-81'
    """
    if not cnpj:
        return ""

    # Remove formatação existente
    cnpj = re.sub(r'[^0-9]', '', cnpj)

    if len(cnpj) != 14:
        return cnpj  # Retorna original se não tiver 14 dígitos

    return f"{cnpj[:2]}.{cnpj[2:5]}.{cnpj[5:8]}/{cnpj[8:12]}-{cnpj[12:]}"


# ===========================================
# FUNÇÕES DE CONVERSÃO
# ===========================================

def safe_float(value: Any, default: float = 0.0) -> float:
    """
    Converte valor para float com segurança.

    Args:
        value: valor a ser convertido
        default: valor padrão se conversão falhar

    Returns:
        float convertido ou default

    Examples:
        >>> safe_float("123.45")
        123.45
        >>> safe_float("abc", 0.0)
        0.0
        >>> safe_float(None, 10.0)
        10.0
    """
    if value is None:
        return default

    try:
        # Trata strings no formato brasileiro (vírgula decimal)
        if isinstance(value, str):
            value = value.strip().replace(',', '.')
        return float(value)
    except (ValueError, TypeError):
        return default


def safe_int(value: Any, default: int = 0) -> int:
    """
    Converte valor para int com segurança.

    Args:
        value: valor a ser convertido
        default: valor padrão se conversão falhar

    Returns:
        int convertido ou default

    Examples:
        >>> safe_int("123")
        123
        >>> safe_int("123.45")
        123
        >>> safe_int("abc", 0)
        0
    """
    if value is None:
        return default

    try:
        # Para floats e strings numéricas, converte primeiro para float
        return int(float(value))
    except (ValueError, TypeError):
        return default


def safe_decimal(value: Any, precision: int = 2) -> Decimal:
    """
    Converte valor para Decimal com precisão específica.

    Args:
        value: valor a ser convertido
        precision: número de casas decimais

    Returns:
        Decimal convertido

    Examples:
        >>> safe_decimal("123.456", 2)
        Decimal('123.46')
        >>> safe_decimal("abc", 2)
        Decimal('0.00')
    """
    if value is None:
        return Decimal('0').quantize(Decimal(10) ** -precision)

    try:
        # Trata strings no formato brasileiro
        if isinstance(value, str):
            value = value.strip().replace(',', '.')

        decimal_value = Decimal(str(value))
        return decimal_value.quantize(Decimal(10) ** -precision)

    except (DecimalException, ValueError, TypeError):
        return Decimal('0').quantize(Decimal(10) ** -precision)


# ===========================================
# FUNÇÕES DE JSON
# ===========================================

class DateTimeEncoder(json.JSONEncoder):
    """Encoder JSON customizado para datetime e Decimal."""

    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, date):
            return obj.isoformat()
        elif isinstance(obj, Decimal):
            return float(obj)
        return super().default(obj)


def json_dumps(obj: Any, **kwargs) -> str:
    """
    Serializa objeto para JSON com suporte a datetime e Decimal.

    Args:
        obj: objeto a ser serializado
        **kwargs: argumentos adicionais para json.dumps

    Returns:
        string JSON

    Examples:
        >>> data = {"data": datetime(2024, 12, 25), "preco": Decimal("123.45")}
        >>> json_dumps(data)
        '{"data": "2024-12-25T00:00:00", "preco": 123.45}'
    """
    try:
        return json.dumps(
            obj,
            cls=DateTimeEncoder,
            ensure_ascii=False,
            **kwargs
        )
    except (TypeError, ValueError) as e:
        raise ValueError(f"Erro ao serializar JSON: {e}") from e


def json_loads(text: str) -> Any:
    """
    Deserializa JSON para objeto Python com tratamento de erro.

    Args:
        text: string JSON a ser deserializada

    Returns:
        objeto Python

    Raises:
        ValueError: se JSON inválido

    Examples:
        >>> json_loads('{"nome": "João", "idade": 30}')
        {'nome': 'João', 'idade': 30}
    """
    if not text or not text.strip():
        return {}

    try:
        return json.loads(text.strip())
    except json.JSONDecodeError as e:
        raise ValueError(f"JSON inválido: {e}") from e


# ===========================================
# DECORATORS
# ===========================================

def retry(
    max_attempts: int = 3,
    delay: float = 1.0,
    exceptions: tuple = (Exception,)
) -> Callable[[F], F]:
    """
    Decorator para retry automático em caso de exceção.

    Args:
        max_attempts: número máximo de tentativas
        delay: tempo entre tentativas (segundos)
        exceptions: tupla de exceções que acionam retry

    Returns:
        decorator

    Examples:
        >>> @retry(max_attempts=3, delay=0.5)
        ... def conectar_api():
        ...     # código que pode falhar
        ...     pass

        >>> @retry(exceptions=(ConnectionError, TimeoutError))
        ... def operacao_rede():
        ...     # código de rede
        ...     pass
    """
    def decorator(func: F) -> F:
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            last_exception = None

            for attempt in range(max_attempts):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts - 1:  # Não aguarda na última tentativa
                        time.sleep(delay)
                    continue

            # Relança a última exceção após esgotar tentativas
            raise last_exception

        return wrapper
    return decorator


# ===========================================
# FUNÇÕES AUXILIARES EXTRAS
# ===========================================

def format_currency(
    value: Union[float, int, Decimal, None],
    symbol: str = "R$",
    decimal_places: int = 2
) -> str:
    """
    Formata valor como moeda brasileira.

    Args:
        value: valor a ser formatado
        symbol: símbolo da moeda
        decimal_places: casas decimais

    Returns:
        valor formatado

    Examples:
        >>> format_currency(1234.56)
        'R$ 1.234,56'
        >>> format_currency(1000, "US$")
        'US$ 1.000,00'
    """
    if value is None:
        value = 0

    # Formata com separador de milhares
    formatted = f"{float(value):,.{decimal_places}f}"

    # Converte para formato brasileiro
    formatted = formatted.replace(",", "X").replace(".", ",").replace("X", ".")

    return f"{symbol} {formatted}"


def clean_phone(phone: str) -> str:
    """
    Remove formatação de telefone, mantendo apenas dígitos.

    Args:
        phone: telefone a ser limpo

    Returns:
        apenas dígitos

    Examples:
        >>> clean_phone("(11) 99999-9999")
        '11999999999'
        >>> clean_phone("+55 11 99999-9999")
        '5511999999999'
    """
    if not phone:
        return ""
    return re.sub(r'[^0-9]', '', phone)


def format_phone(phone: str, include_country: bool = False) -> str:
    """
    Formata telefone no padrão brasileiro.

    Args:
        phone: telefone a ser formatado
        include_country: se deve incluir código do país

    Returns:
        telefone formatado

    Examples:
        >>> format_phone("11999999999")
        '(11) 99999-9999'
        >>> format_phone("5511999999999", True)
        '+55 (11) 99999-9999'
    """
    phone = clean_phone(phone)

    if not phone:
        return ""

    # Remove código do país se presente
    if phone.startswith("55") and len(phone) > 11:
        country_code = phone[:2]
        phone = phone[2:]
    else:
        country_code = "55"

    # Formata conforme número de dígitos
    if len(phone) == 11:  # Celular
        formatted = f"({phone[:2]}) {phone[2:7]}-{phone[7:]}"
    elif len(phone) == 10:  # Fixo
        formatted = f"({phone[:2]}) {phone[2:6]}-{phone[6:]}"
    else:
        return phone  # Retorna original se não conseguir formatar

    if include_country:
        formatted = f"+{country_code} {formatted}"

    return formatted