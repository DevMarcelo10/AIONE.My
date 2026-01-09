# PBM Integration Framework - AIONE.My

## 12 Operadoras Suportadas

| # | Código | Nome | Tipo | Protocolo |
|---|--------|------|------|-----------|
| 1 | EPHARMA | Epharma | PBM Corporativo | REST/JSON + OAuth 2.0 |
| 2 | FUNCIONALCARD | Funcional Card | PBM Corporativo | REST/JSON + JWT |
| 3 | ORIZON | Orizon | PBM Comercial | REST/JSON + API Key |
| 4 | VIDALINK | Vidalink | PBM Corporativo | REST/JSON + JWT |
| 5 | FARMACIAPOPULAR | Farmácia Popular | Governo | SOAP/XML + DATASUS |
| 6 | PHARMALINK | Pharmalink | Indústria | SOAP/XML + Terminal |
| 7 | TRNCENTRE | TRN Centre | Agregador | REST/JSON + OAuth 2.0 |
| 8 | PECFEBRAFAR | PEC Febrafar | Associativo | REST/JSON + Token |
| 9 | LINKEDFARMA | LinkedFarma | Fidelidade | REST/JSON + API Key |
| 10 | ELLOMAIS | Ello+ / Facillite | Fidelidade | REST/JSON + API Key |
| 11 | NOSSOCLUBE | Nosso Clube / Cosmos | Fidelidade | REST/JSON + API Key |
| 12 | OBJECTPRO | Object Pro | Fidelidade | REST/JSON + API Key |

## Estrutura de Arquivos

```
PBM/
├── SQL/
│   └── pbm_tables.sql        # Script MySQL com tabelas
├── Test/
│   └── PBM_TestAll.dpr       # Projeto de teste completo
├── uPBM.Interfaces.pas       # Interfaces base (IPBMClient)
├── uPBM.Factory.pas          # Factory para criar clients
├── uPBM.Persistence.pas      # Camada de persistência
├── uPBM.PDV.pas              # Form visual unificado
├── uPBM.PDV.dfm              # DFM do form
└── uPBM.Exemplo.PDV.pas      # Exemplos de uso
```

## Instalação

### 1. Banco de Dados MySQL

Execute o script SQL para criar as tabelas:

```sql
mysql -u root -p aione < SQL/pbm_tables.sql
```

### 2. Configurar Operadoras

Após criar as tabelas, configure cada operadora com suas credenciais:

```sql
UPDATE pbm_operadoras SET
  client_id = 'SEU_CLIENT_ID',
  client_secret = 'SEU_CLIENT_SECRET',
  cod_estabelec = 'SEU_CODIGO_LOJA',
  usuario = 'SEU_USUARIO',
  senha = 'SUA_SENHA',
  api_key = 'SUA_API_KEY'
WHERE codigo = 'EPHARMA';
```

### 3. Adicionar Units ao Projeto

Adicione ao seu projeto Delphi:

```pascal
uses
  uPBM.Interfaces,
  uPBM.Factory,
  uPBM.Persistence,
  uPBM.PDV;
```

## Uso Básico

### Uso via Form Visual

```pascal
var
  GPBM: TPBMIntegracao;
begin
  // Inicialização
  GPBM := TPBMIntegracao.Create(DM.Connection);
  
  // Chamar autorização
  LAuth := GPBM.AutorizarVenda(FVenda.ID, LProdutos);
  
  if LAuth.ID > 0 then
    ShowMessage('Desconto: R$ ' + FormatFloat('#,##0.00', LAuth.ValorDesconto));
end;
```

### Uso Direto da API

```pascal
var
  LClient: IPBMClient;
  LAuth: IPBMAutorizacao;
begin
  // Cria client via Factory
  LClient := TPBMFactory.CreateClient(
    ptEpharma,
    'CLIENT_ID',
    'CLIENT_SECRET',
    'COD_ESTABELECIMENTO',
    True // Homologação
  );
  
  // Autoriza venda
  LAuth := LClient.AutorizarVenda(
    '123456789',           // Carteirinha
    '12345678909',         // CPF
    EncodeDate(1980,1,1),  // Data Nasc
    LProdutos,             // Array de produtos
    126.90,                // Valor total
    'TRANS001'             // ID da transação
  );
  
  if LAuth.Sucesso then
    ShowMessage('NSU: ' + LAuth.NSU);
end;
```

## Executar Testes

1. Configure a conexão MySQL em `PBM_TestAll.dpr`
2. Compile e execute o projeto
3. Verifique o resultado de cada operadora

```
═══════════════════════════════════════════════════════════════
  PBM TEST SUITE - Testando 12 Operadoras
  Ambiente: HOMOLOGAÇÃO
═══════════════════════════════════════════════════════════════

--- CORPORATIVOS ---
✓ [EPHARMA] Elegibilidade - OK (234ms)
✓ [EPHARMA] Autorizacao - OK (456ms)
...
```

## Tabelas MySQL

| Tabela | Descrição |
|--------|-----------|
| pbm_operadoras | Cadastro das 12 operadoras com credenciais |
| pbm_tokens | Cache de tokens OAuth/JWT |
| pbm_autorizacoes | Registro de todas as autorizações |
| pbm_autorizacao_itens | Itens/medicamentos de cada autorização |
| pbm_rewards | Movimentos de pontos (fidelidade) |
| pbm_log | Log de todas as comunicações com APIs |

## Views

| View | Descrição |
|------|-----------|
| vw_pbm_resumo_diario | Totais por operadora/dia |
| vw_pbm_pendentes | Autorizações com problema |

## Atalhos do Form PDV

| Tecla | Ação |
|-------|------|
| F2 | Consultar elegibilidade |
| F5 | Autorizar venda |
| F6 | Cancelar autorização |
| F12 | Limpar formulário |
| ESC | Fechar |

## Requisitos

- Delphi 10.3+ (Rio ou superior)
- FireDAC
- MySQL 5.7+ ou MariaDB 10.3+
- Units de cada PBM (uPBM.Epharma, uPBM.FuncionalCard, etc.)

## Suporte

Para implementar uma nova operadora, siga o padrão:

1. Crie `uPBM.NovaOperadora.pas` implementando `IPBMClient`
2. Adicione o tipo em `TPBMType`
3. Registre no `TPBMFactory.CreateClient`
4. Adicione INSERT no `pbm_tables.sql`
