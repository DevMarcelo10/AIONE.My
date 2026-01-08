---
name: ia-compras
description: Estrutura e padrões do módulo IA de Compras. Use quando trabalhar com sugestões de compra, análise de estoque, ou integrações com fontes externas.
---

# Módulo IA de Compras

## Visão Geral

Sistema de inteligência artificial para geração automática de sugestões de compra baseado em:
- Análise de estoque e consumo
- Histórico de compras e preços
- Eventos externos (surtos, campanhas, clima, feriados)
- Score de fornecedores
- Classificação de produtos (saúde do estoque)

---

## Estrutura do Banco de Dados

### Tabelas Core (Pedidos IA)

#### `ia_arqcompra` (Master - Pedido de Compra IA)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDComp | int PK | ID do pedido |
| DatCria | datetime | Data criação |
| IDUsu | int | Usuário que gerou |
| TotItens | int | Total de itens |
| ValorEst | varchar | Valor estimado |
| Status | enum | ANÁLISE → REVISÃO → COTAÇÃO → PEDIDO → FINALIZADO |
| ObsComp | text | Observações |

#### `ia_arqcompraite` (Detail - Itens do Pedido IA)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDCompIte | bigint PK | ID do item |
| IDComp | int FK | → ia_arqcompra |
| IDProd | int FK | → arqproduto |
| IDFilial | int FK | → arqfilial |
| QtdSugIA | decimal | Quantidade sugerida pela IA |
| QtdAjust | decimal | Quantidade ajustada pelo usuário |
| CenOtim | decimal | Cenário Otimista |
| CenCons | decimal | Cenário Conservador |
| CenCrit | decimal | Cenário Crítico |
| DiasCobre | int | Dias de cobertura |
| EstqAtual | decimal | Estoque atual |
| EstqSegur | decimal | Estoque de segurança |
| PontoPed | decimal | Ponto de pedido |
| ConsMedio | decimal | Consumo médio |
| TempoRepo | int | Tempo de reposição (dias) |
| Risco | enum | BAIXO / MÉDIO / ALTO |
| Classif | enum | SAUDAVEL / ATENÇÃO / TÓXICO |
| Acao | enum | COMPRAR / TRANSFERIR / NÃO COMPRAR / AGUARDAR |
| Status | enum | PENDENTE / APROVADO / REJEITADO / COTADO / PEDIDO |
| IDFilialOri | int | Filial origem (para transferência) |
| JustificaIA | text | Justificativa da IA |
| IDUsuDec | int | Usuário que decidiu |
| DatDecis | datetime | Data da decisão |

---

### Tabelas de Análise/Inteligência

#### `ia_arqprodclas` (Classificação de Produtos)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDProd | int PK FK | → arqproduto |
| Classif | enum | SAUDAVEL / ATENCAO / TOXICO |
| ScoreGiro | decimal | Score de giro |
| ScoreMarg | decimal | Score de margem |
| ScoreRisc | decimal | Score de risco |
| DiasCobre | int | Dias de cobertura atual |
| CustoPara | decimal | Custo de produto parado |
| DatAnalise | datetime | Data última análise |
| BloqRecomp | tinyint | Bloqueado para recompra |
| MotivBloq | text | Motivo do bloqueio |

#### `ia_arqfornscor` (Score de Fornecedores)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDForn | int PK FK | → arqpessoa (IDEsppes=2) |
| ScoreGer | decimal | Score geral |
| ScorePrec | decimal | Score de preço |
| ScorePraz | decimal | Score de prazo |
| ScoreRupt | decimal | Score de ruptura |
| ScoreCump | decimal | Score de cumprimento |
| MediaDesc | decimal | Média de desconto obtido |
| EmpuraEst | tinyint | Fornecedor "empurra" estoque |
| DatAnalise | datetime | Data última análise |

#### `ia_arqhistprec` (Histórico de Preços)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDHistPrec | bigint PK | ID |
| IDProd | int FK | → arqproduto |
| IDForn | int FK | → arqpessoa |
| DatCota | date | Data da cotação |
| PrecoUni | decimal | Preço unitário |
| PercDesc | decimal | Percentual desconto |
| QtdMin | int | Quantidade mínima |
| PrazoEntr | int | Prazo entrega (dias) |
| DatValid | date | Validade da cotação |

#### `ia_arqcorrelac` (Correlações Aprendidas)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDCorrel | int PK | ID |
| TipoEvento | varchar | Tipo do evento |
| IDGrupo | int FK | → arqgrupo |
| IDCateg | int | Categoria |
| IDProd | int FK | → arqproduto |
| PercImpac | decimal | Percentual de impacto |
| DiasAntes | int | Dias antes do evento |
| DiasDurac | int | Duração do impacto |
| Confianca | decimal | Nível de confiança |
| Origem | enum | MANUAL / APRENDIDA |

#### `ia_arqdecapren` (Decisões Aprendidas)
Armazena decisões do usuário para machine learning.

#### `ia_arqhistcom` (Histórico de Compras)
Histórico consolidado para análise.

---

### Tabelas de Eventos Externos

#### `ia_arqeventos` (Eventos)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDEvento | int PK | ID |
| TipoEvt | enum | SURTO / CAMPANHA / FERIADO / EVENTO / CLIMA |
| DescEvt | varchar | Descrição |
| DatInicio | date | Data início |
| DatFinal | date | Data final |
| IDRegiao | int FK | → ia_arqregioes |
| PercImpac | decimal | Percentual impacto |
| Categor | longtext | Categorias afetadas (JSON) |
| Origem | enum | MANUAL / AUTOMATICA |
| IDColeta | bigint FK | → ia_arqcoletaex |

#### `ia_arqregioes` (Regiões Geográficas)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDRegiao | int PK | ID |
| NomeReg | varchar | Nome da região |
| UF_Reg | char(2) | UF |
| CodIBGE | int | Código IBGE |
| Latitude | decimal | Latitude |
| Longitude | decimal | Longitude |
| GeoTrends | varchar | ID Google Trends |
| GeoMetro | varchar | Área metropolitana |
| GeoEstado | varchar | Estado |
| NivelGeo | enum | CIDADE / METRO / ESTADO |
| Populacao | int | População |
| Ativo | tinyint | Ativo |

#### `ia_arqfonteext` (Fontes Externas)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDFonte | int PK | ID |
| NomeFonte | varchar | Nome |
| TipoFonte | enum | CLIMA / SAUDE / EVENTO / TENDENCIA |
| UrlApi | varchar | URL da API |
| ChaveApi | varchar | Chave de acesso |
| Frequenc | int | Frequência coleta (minutos) |
| Ativo | tinyint | Ativo |
| DatUltCol | datetime | Última coleta |
| StatusUlt | enum | SUCESSO / ERRO |

#### `ia_arqcoletaex` (Dados Coletados)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDColeta | bigint PK | ID |
| IDFonte | int FK | → ia_arqfonteext |
| DatColeta | datetime | Data/hora coleta |
| IDRegiao | int FK | → ia_arqregioes |
| DadosBruto | longtext | JSON com dados brutos |
| Processado | tinyint | Foi processado |

#### `ia_arqalertaex` (Alertas Externos)
Alertas gerados a partir dos dados coletados.

#### `ia_arqnegocesp` (Negociações Especiais)
Negociações especiais com fornecedores.

---

### Tabelas Base (Existentes no Sistema)

#### `arqproduto` (Produtos)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDProd | int PK | ID do produto |
| Despro | varchar | Descrição |
| CodEANpri | varchar | **Código EAN PRINCIPAL** |
| IDFabr | int FK | Fabricante (→ arqpessoa) |
| IDGrupo | int FK | Grupo |
| IDGruSub | int FK | Subgrupo |
| Estmin | double | Estoque mínimo |
| Estmax | double | Estoque máximo |
| CustoMed | double | Custo médio |
| PrecoVen | double | Preço venda |
| Ativo | char(1) | Ativo (1/0) |

#### `arqprodutoean` (EANs Secundários)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDProd | int PK FK | → arqproduto |
| CodEAN | varchar PK | Código EAN alternativo |

**Nota:** Um produto pode ter múltiplos códigos de barras. O principal fica em `arqproduto.CodEANpri`, os alternativos em `arqprodutoean`.

#### `arqprodutolot` (Estoque por Lote)
Estoque detalhado por lote e filial.

#### `arqpessoa` (Pessoas/Fornecedores)
| Campo | Tipo | Descrição |
|-------|------|-----------|
| IDPess | int PK | ID |
| Nompes | varchar | Nome |
| IDEsppes | int | **Tipo: 1=Cliente, 2=Fornecedor, 3=Médico** |

#### `arqfilial` (Filiais)
Cadastro de filiais da empresa.

#### `arqcomprarec` (Master - Compras Recebidas)
Cabeçalho das compras/notas recebidas.

#### `arqcomprarecite` (Detail - Itens Recebidos)
Itens das compras recebidas. Relação **1:N** com `arqcomprarec`.

---

## Fluxo do Processo

```
1. COLETA
   ia_arqfonteext → ia_arqcoletaex → ia_arqeventos

2. ANÁLISE
   arqproduto + arqprodutolot → ia_arqprodclas
   arqpessoa (fornecedores) → ia_arqfornscor
   arqcomprarec + arqcomprarecite → ia_arqhistprec

3. CORRELAÇÃO
   ia_arqeventos + ia_arqprodclas → ia_arqcorrelac

4. GERAÇÃO
   Algoritmo IA → ia_arqcompra + ia_arqcompraite

5. REVISÃO
   Usuário revisa → Status: ANÁLISE → REVISÃO → COTAÇÃO

6. DECISÃO
   ia_arqcompraite.Acao + ia_arqdecapren

7. PEDIDO
   ia_arqcompra → Pedido real ao fornecedor
```

---

## Classificação de Produtos

| Classificação | Descrição | Ação Sugerida |
|---------------|-----------|---------------|
| SAUDAVEL | Estoque adequado, bom giro | Manter |
| ATENCAO | Estoque baixo ou giro lento | Avaliar |
| TOXICO | Excesso ou sem giro | Não comprar / Transferir |

---

## Níveis de Risco

| Risco | Descrição |
|-------|-----------|
| BAIXO | Produto com histórico estável |
| MÉDIO | Variações moderadas de demanda |
| ALTO | Alta volatilidade ou produto novo |

---

## Ações Sugeridas

| Ação | Descrição |
|------|-----------|
| COMPRAR | Incluir no pedido de compra |
| TRANSFERIR | Buscar de outra filial |
| NÃO COMPRAR | Estoque suficiente |
| AGUARDAR | Aguardar mais dados/análise |
