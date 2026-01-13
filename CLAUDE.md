# Guia de Desenvolvimento AIONE

## Comportamento

- Converse em Português brasileiro
- Execute correções diretamente sem pedir confirmação quando for óbvio
- Apenas pergunte quando houver ambiguidade real
- Assuma contexto completo do projeto Delphi/MySQL
- Não explique o que vai fazer, apenas faça (exceto mudanças estruturais grandes)

## IMPORTANTE
- Todas configurações adicionais e skills para o use do CLAUDE CODE, estão nas subpastas de .Claude desse projeto.

## Visão Geral do Projeto

AIONE.My é um ERP completo para farmácias desenvolvido em Delphi com arquitetura cliente-servidor REST.

**Stack Tecnológico:**
- Linguagem: Delphi RAD 12.1 (Object Pascal)
- Framework: VCL (Visual Component Library)
- Arquitetura: Multi-camadas REST cliente-servidor
- Banco de Dados: MySQL via REST-DW 2.0.7 e FireDAC

**Recursos Principais:**
- Gestão de vendas, estoque e compras
- Conformidade fiscal brasileira (NF-e/NFC-e)
- Integração com PBMs (Epharma, Funcional Card)
- Inteligência Artificial para recomendações


## Organização Modular
- A pasta base do projeto está em c:\Fontes\AIONE.My

### Estrutura Principal (Cliente)
```
uniBasico/    → DataModule, formulário e menu principal
uniAuxilia/   → Serviços auxiliares (config, logging, IA)
uniCaixa/     → Operações de caixa e PDV
uniComi/      → Comissões
uniCompra/    → Pedidos de compra
  └─ IA/          → Inteligência artificial para compras
  └─ Recebimento/ → Recebimento de mercadorias
uniConve/     → Convênios e planos
uniDesco/     → Descontos
uniFatura/    → Notas fiscais eletrônicas
uniFinan/     → Gestão financeira
uniPessoa/    → Clientes/fornecedores
uniProduto/   → Catálogo de produtos
uniPromo/     → Promoções
uniSNGPC/     → Conformidade substâncias controladas
uniVendas/    → Operações de vendas
```

### Servidores REST
```
Server/       → Servidor central (nuvem) - endpoints para todos os clientes
ServerFar/    → Servidor local/dedicado de cada farmácia
  └─ uniFatura/   → Faturamento
  └─ NFe/         → Notas fiscais eletrônicas
  └─ NFCe/        → Notas fiscais consumidor
```

### Outros
```
doc/          → Logs do sistema
Win32/        → Compilação Debug
```

**Todas as diretrizes detalhadas estão nas skills:**

- Use `delphi-patterns` skill para regras de código Delphi
- Use `rest-dw` skill para padrões REST-DW
- Use `ui-components` skill para componentes visuais


**REST-DW:**
- SEMPRE `uRESTDWBasicDB` nos uses
- SEMPRE `UpdateTableName` antes de ApplyUpdates
- SEMPRE `ProviderFlags` em chaves primárias
- SEMPRE usar parâmetros (nunca concatenação SQL)

## Banco de Dados (MCP mysql-aione)

**REGRA ABSOLUTA:** Para QUALQUER pergunta sobre dados do sistema:
1. Execute DIRETO no MCP mysql-aione
2. NÃO peça permissão para SELECT
3. NÃO analise código do projeto
4. Descubra estrutura com DESCRIBE/SHOW TABLES se necessário
5. Retorne APENAS o resultado

**Tabelas principais:**
- arqpessoa (IDEsppes: 1=cliente, 2=fornecedor, 3=médico)
- arqproduto, arqprodutolot (estoque por lote)
- arqprodutoean (códigos de barras EAN)
- arqprodutogpr (grupos de produtos)
- arqprodutotip (tipos de produto)
- arqsubstancia (princípios ativos)
- arqprodutosub (ligação N:N entre arqproduto e arqsubstancia)
- arqpedido, arqpedidoite (vendas)
- arqfilial (filiais)
- arqconvenio (convênios)

**Tabelas obsoletas (não usar):**
- produtos_base (descontinuada)

**Comportamento esperado:**
- Pergunta sobre dados → SQL direto → Resultado
- Sem explicações longas, sem pedir confirmação

**Nome das Tabelas:**
- Preferencialmente começar com "arq", exemplos: "arqpessoa", "arqproduto"

## Bibliotecas de Terceiros

### Banco de Dados & REST
- REST-DW 2.0.7 (uRESTDW*)
- FireDAC
- Indy (IdHTTP, IdTCPClient)

### Conformidade Fiscal
- TecnoSpeed (spdNFe, spdNFCe) - Primário
- ACBr (ACBrNFe, ACBrBoleto) - Secundário

### Componentes UI
- LMD Tools Suite (lmdrt*)
- TMS Components
- RxLib

### MarcLib
```
Localização: C:\Program Files (x86)\Embarcadero\MarcLib\MarcLib.pas
Descrição: 100+ funções auxiliares
Uso: Preferir quando disponível
```

## Comandos Disponíveis

- `/create-form` - Criar novo formulário seguindo padrões
- `/investigate` - Investigar funcionalidade antes de implementar
- `/review-staged` - Revisar mudanças contra padrões Delphi

## Estruturas Importantes

### Variáveis Globais (uConst.pas)
```pascal
EMPRESA: TEmpresa    // Dados da farmácia atual
FILIAL: Integer      // ID da filial ativa
USUARIO: String      // Usuário logado
PastaLog: String     // Diretório de logs
```

### Conexão REST
```pascal
DM.DWDataBase: TRESTDWIdDatabase          // Conexão principal
DM.RESTClientPooler: TRESTDWIdClientPooler // Servidor local
DM.FDConnect: TFDConnection                // Fallback direto
```

## Armadilhas Comuns

1. Esquecer `uRESTDWBasicDB` → Erro de compilação
2. Não definir `UpdateTableName` → "UpdateTableName not defined"
3. Esquecer `ProviderFlags` → "No records updated"
4. Memory leaks → Sempre `FreeAndNil` em `try-finally`
5. Indentação errada → SEMPRE 3 espaços

## Checklist de Revisão

- [ ] Indentação com 3 espaços
- [ ] `begin`/`end` sempre
- [ ] `FreeAndNil` para objetos
- [ ] `try-finally` para recursos
- [ ] `uRESTDWBasicDB` nos uses
- [ ] `UpdateTableName` definido
- [ ] `ProviderFlags` em chaves
- [ ] Parâmetros em SQL
- [ ] Validações antes de salvar
- [ ] `SalvaLog` para erros

## Workflow Recomendado

1. Use `/investigate` para entender o contexto
2. Use `/create-form` para criar novo formulário
3. Implemente seguindo os padrões das skills
4. Use `/review-staged` antes de commitar
5. Teste manualmente
6. Commit e push

## LEMBRETES IMPORTANTES

💡 Princípios Guias ao Desenvolver:

🔹 Não reinvente a roda
		Se já existe algo pronto, testado e consolidado então use.

🔹 DRY (Don’t Repeat Yourself)
		Nada de lógica duplicada.
		Se o mesmo código aparece em dois lugares, você deve centralizar em um único local.
		Mesmo botão em três telas? Cria um componente só e reutiliza.
		Comandos, funções, procedimentos e propriedades que você tiver dúvidas se o Delphi suportará, verifique antes de implementar.
		Delphi é uma linguagem pouco treinada pela IA, então, use formas de suprir isso entendendo melhor o código já existente no projeto.

🔹 YAGNI (You Aren’t Gonna Need It)
		Se não precisar de determinado recurso no momento, não implemente agora.
		Começa simples, mas sem abrir mão do necessário, e vai evoluindo.

🔹 KISS (Keep It Simple, Stupid)
		Prefira sempre a solução mais simples possível.
		Se dá pra resolver com 50 linhas, não escreva 500.
		Alerta simples não precisa virar um sistema de notificações inteiro.
		Sempre faça códigos limpos.

🔹 Separation of Concerns
		Cada arquivo com uma responsabilidade.
		Arquivo com 2000 linhas fazendo 4 coisas diferentes não é uma boa prática, separar isso melhora: a leitura, manutenção e testes.
