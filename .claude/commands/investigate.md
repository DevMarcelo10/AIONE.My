---
description: Investigação sistemática através de perguntas focadas antes de planejar implementação
argument-hint: [tópico ou objetivo]
---

# Protocolo de Investigação

Antes de planejar ou implementar, investigar: $ARGUMENTS

## Processo

### 1. Descoberta Inicial
Fazer 3-5 perguntas focadas sobre:
- Estado atual (o que existe hoje no sistema?)
- Resultado desejado (o que deve existir?)
- Restrições (banco de dados, componentes disponíveis, limitações?)
- Critérios de sucesso (como saberemos que funciona?)

### 2. Análise do Código Base
- Buscar formulários similares existentes
- Identificar padrões de implementação usados
- Mapear tabelas e relacionamentos do banco
- Verificar componentes LMD/TMS disponíveis
- Notar soluções existentes para problemas similares

### 3. Lacunas de Conhecimento
Identificar o que você não sabe:
- Incógnitas técnicas (estrutura de tabelas, APIs REST-DW)
- Ambiguidades de regras de negócio
- Casos extremos que precisam esclarecimento
- Integrações com PBMs ou sistemas externos

### 4. Saída
Fornecer um resumo estruturado:
```
## Entendimento
[O que aprendi sobre o tópico]

## Questões em Aberto
[Perguntas que precisam respostas antes de prosseguir]

## Abordagem Sugerida
[Direção de alto nível baseada nas descobertas]

## Arquivos Relevantes
[Lista de units e formulários relacionados]
```

## Regras
- Perguntar antes de assumir
- Explorar antes de planejar
- Entender antes de implementar
- Trazer ambiguidades à tona cedo
- Considerar impacto em outros módulos do sistema
