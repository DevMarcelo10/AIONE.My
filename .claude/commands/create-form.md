---
description: Criar novo formulário Delphi com padrões do projeto (Master-Detail se necessário)
argument-hint: [descrição do formulário]
---

# Criar Formulário Delphi

Implementar: $ARGUMENTS

## Fluxo

### 1. Análise
Antes de criar código:
- Identificar se é formulário simples ou master-detail
- Verificar formulários similares no projeto
- Identificar tabelas do banco de dados envolvidas
- Definir componentes necessários (LMD, TMS, etc)

### 2. Estrutura de Arquivos
Criar par de arquivos:
- `uNomeForm.pas` - Código Pascal
- `uNomeForm.dfm` - Designer visual

### 3. Padrões do Projeto

**Nomenclatura:**
- Classe: `TFrmNome` (ex: `TFrmPesCad`)
- Arquivo: `uNomeForm.pas` (ex: `uPessoasCad.pas`)
- Formulários de cadastro: `uNomeCad.pas`

**Componentes:**
- Painéis: `Panel*` (PanelCadastro, PanelTop, PanelRodape)
- Campos: `ed*` (edNompes, edCpfCnpj)
- Botões: `bt*` (btSalvar, btVoltar, btNovo)
- DataSets: `Tab*` (TabPess, TabProduto)
- DataSource: `Sou*` (SouPess, SouProduto)

**Indentação:**
- SEMPRE 3 espaços (nunca tabs, nunca 2 ou 4)
- `begin`/`end` obrigatório mesmo para linha única
- `FreeAndNil` em vez de `.Free`
- `try-finally` para todos os recursos

### 4. Master-Detail (se aplicável)
Se for formulário com itens:
- Configurar `MasterDataSet` no detail
- Definir `RelationFields.Strings`
- Configurar `Params` no detail
- DBGrid com `OnDrawColumnCell` para cores alternadas

### 5. Eventos Padrão
```pascal
procedure FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);  // Ajuste DPI
end;

procedure FormShow(Sender: TObject);
begin
   // Abrir datasets
   // Conectar DataSources
   FadeInOut(Self, 'In', 10);
end;

procedure FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // Fechar datasets
   FadeInOut(Self, 'Out', 10);
   Action := caFree;
end;
```

### 6. Checklist Final
- [ ] Indentação com 3 espaços
- [ ] `uRESTDWBasicDB` nos uses se usar TRESTDWClientSQL
- [ ] `UpdateTableName` definido
- [ ] `ProviderFlags` nas chaves primárias
- [ ] `try-finally` em todas as queries
- [ ] `FreeAndNil` para liberar objetos
- [ ] Validações antes de salvar
- [ ] Tratamento de erros com `SalvaLog`

### 7. Layout de Formularios "TForm"
- Na pasta: ".claude\Images" temos arquivos do tipo ".dfm" onde estão exemplos de configurações, cores, tamanhos e uso de componentes visuais para usar como exemplo e padrão.
- Sendo esses: 
	- Modelo_Master_Detail_base.dfm 
	- Modelo_TelaCadastro_base.dfm

## Saída
Criar arquivos `.pas` e `.dfm` completos e funcionais.
