# Template de Módulo AIONE IA

Este diretório serve como template para criação de novos módulos do sistema AIONE IA.

## Como Criar um Novo Módulo

### 1. Copiar o Template

```bash
cp -r modules/__template__ modules/novo_modulo
```

### 2. Renomear Arquivos e Referências

Substitua todas as ocorrências de `__template__` pelo nome do seu módulo:

- No `__init__.py`: altere o import e docstring
- No `routes.py`: altere o nome no status e imports
- No `models.py`: altere a docstring

### 3. Estrutura Recomendada

```
modules/seu_modulo/
├── __init__.py          # Export do router
├── models.py            # Modelos Pydantic (Request/Response)
├── routes.py            # Endpoints FastAPI
├── jobs.py              # Jobs agendados (opcional)
├── coletores/           # Coletores de dados externos (opcional)
│   ├── __init__.py
│   └── fonte.py
├── processadores/       # Lógica de processamento (opcional)
│   ├── __init__.py
│   └── processador.py
└── README.md            # Documentação do módulo
```

### 4. Registrar o Módulo

Adicione o nome do módulo na variável `ACTIVE_MODULES` do arquivo `.env`:

```env
ACTIVE_MODULES=compras,seu_modulo
```

### 5. Implementar Jobs (Opcional)

Se seu módulo precisa de tarefas agendadas, crie um arquivo `jobs.py`:

```python
from core.scheduler.manager import SchedulerManager
from core.utils.logger import get_logger

logger = get_logger(__name__)

async def job_exemplo():
    """Job de exemplo"""
    logger.info("Executando job de exemplo")
    # Sua lógica aqui

def register_jobs(scheduler: SchedulerManager) -> None:
    """Registra jobs do módulo"""
    scheduler.add_job_daily(
        job_id="seu_modulo_exemplo",
        func=job_exemplo,
        hour=6,
        minute=0
    )
```

## Convenções

### Nomenclatura

- **Módulos**: snake_case (ex: `compras`, `gestao_estoque`)
- **Classes**: PascalCase (ex: `ProcessadorVendas`)
- **Funções**: snake_case (ex: `calcular_media`)
- **Constantes**: UPPER_SNAKE_CASE (ex: `LIMITE_MAXIMO`)

### Models

- Sufixo `Request` para modelos de entrada
- Sufixo `Response` para modelos de saída
- Use `Field()` com description para documentação automática

### Routes

- Use tags para agrupar endpoints
- Docstrings viram documentação do Swagger
- Sempre trate exceções e logue erros

### Logs

```python
from core.utils.logger import get_logger

logger = get_logger(__name__)

logger.debug("Mensagem de debug")
logger.info("Mensagem informativa")
logger.warning("Aviso")
logger.error("Erro")
```

### Banco de Dados

```python
from core.database.factory import get_db

db = get_db()

# Query simples
result = db.execute("SELECT * FROM tabela WHERE id = :id", {"id": 1})

# Query para DataFrame
df = db.execute_df("SELECT * FROM tabela", {})

# Valor escalar
count = db.execute_scalar("SELECT COUNT(*) FROM tabela", {})
```

## Exemplo Completo

Veja o módulo `compras` como referência de implementação completa.
