---
description: Revisar mudanças staged contra os padrões Delphi do projeto
allowed-tools: Bash(git:*)
---

# Revisar Mudanças Staged

Revisar todas as mudanças staged para qualidade e aderência aos padrões.

## Processo

### 1. Obter Mudanças Staged
```bash
git diff --cached
```

### 2. Checklist de Revisão

**Indentação e Formatação**
- [ ] 3 espaços de indentação (NUNCA tabs, 2 ou 4)
- [ ] `begin`/`end` mesmo para linha única
- [ ] `FreeAndNil` em vez de `.Free`
- [ ] `try-finally` para todos os recursos

**REST-DW**
- [ ] `uRESTDWBasicDB` nos uses quando usar TRESTDWClientSQL
- [ ] `UpdateTableName` definido antes de ApplyUpdates
- [ ] `ProviderFlags` configurado em campos chave
- [ ] Parâmetros em vez de concatenação SQL

**Master-Detail (se aplicável)**
- [ ] `MasterDataSet` definido no detail
- [ ] `RelationFields.Strings` configurado
- [ ] `Params` configurado no detail
- [ ] Salvar master antes dos itens

**Nomenclatura**
- [ ] Classes: `TFrmXxx`
- [ ] Componentes: prefixos corretos (ed*, bt*, Tab*, Sou*)
- [ ] Variáveis: nomes descritivos (não `aux`, `i`, `x`)

**Tratamento de Erros**
- [ ] `try-except` em operações críticas
- [ ] `SalvaLog` para erros importantes
- [ ] `MostraMsg` para feedback ao usuário
- [ ] Validações antes de salvar

**Banco de Dados**
- [ ] Queries fechadas em `try-finally`
- [ ] `Close` antes de `FreeAndNil`
- [ ] Verificação de `IsEmpty` antes de acessar campos
- [ ] `DisableControls`/`EnableControls` ao percorrer registros

**Qualidade Geral**
- [ ] Sem código comentado (deletar)
- [ ] Sem variáveis não usadas
- [ ] Sem magic numbers (extrair para constantes)
- [ ] Funções com responsabilidade única

### 3. Formato de Saída

```
## Resumo
[Visão geral das mudanças]

## Problemas Encontrados
### Críticos (deve corrigir)
- [Problema + sugestão + linha]

### Sugeridos (deveria corrigir)
- [Problema + sugestão + linha]

## Aprovação
✅ Pronto para commit | ⚠️ Correções menores necessárias | ❌ Precisa de mudanças
```

## Prioridade

1. **Crítico**: Indentação errada, memory leaks, falta de UpdateTableName
2. **Alto**: Nomenclatura, tratamento de erros, validações
3. **Médio**: Magic numbers, código duplicado
4. **Baixo**: Preferências de estilo menores
