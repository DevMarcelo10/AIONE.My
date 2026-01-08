---
name: rest-dw
description: Padrões REST-DW para comunicação cliente-servidor. Use quando trabalhar com TRESTDWClientSQL, queries REST, ou master-detail.
---

# REST-DW Patterns

## Configuração Essencial

**SEMPRE adicione aos uses:**
```pascal
uses
   uRESTDWBasicDB, uRESTDWBasicTypes;
```

## Consultas Básicas

### SELECT
```pascal
Qry := TRESTDWClientSQL.Create(nil);
Qry.DataBase := DM.DWDataBase;
try
   Qry.SQL.Text := 'SELECT * FROM tabela WHERE id = :id';
   Qry.ParamByName('id').AsInteger := 123;
   Qry.Open;
   
   if not Qry.IsEmpty then
      Result := Qry.FieldByName('nome').AsString;
finally
   Qry.Close;
   FreeAndNil(Qry);
end;
```

### INSERT
```pascal
Qry.UpdateTableName := 'arqtabela';  // ⚠️ OBRIGATÓRIO
Qry.FieldByName('IDCampo').ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];

Qry.Insert;
Qry.FieldByName('Nome').AsString := 'Valor';
Qry.Post;

var vError: String;
if not Qry.ApplyUpdates(vError) then
   MostraMsg('Erro', vError, mtError, [mbOk]);
```

### UPDATE
```pascal
Qry.UpdateTableName := 'arqtabela';
Qry.FieldByName('IDCampo').ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];

Qry.Edit;
Qry.FieldByName('Nome').AsString := 'Novo Valor';
Qry.Post;

var vError: String;
if not Qry.ApplyUpdates(vError) then
   MostraMsg('Erro', vError, mtError, [mbOk]);
```

### DELETE
```pascal
Qry.UpdateTableName := 'arqtabela';
Qry.FieldByName('IDCampo').ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];

Qry.Delete;

var vError: String;
if not Qry.ApplyUpdates(vError) then
   MostraMsg('Erro', vError, mtError, [mbOk]);
```

### EXECSQL
```pascal
Qry.Close;
Qry.SQL.Clear;
Qry.SQL.Add('UPDATE tabela SET campo = :valor WHERE id = :id');
Qry.ParamByName('valor').AsString := 'novo';
Qry.ParamByName('id').AsInteger := 123;

var vError: String;
if not Qry.ExecSQL(vError) then
   MostraMsg('Erro', vError, mtError, [mbOk])
else
   ShowMessage(Format('Linhas afetadas: %d', [Qry.RowsAffected]));
```

## Master-Detail

### Configuração Master
```pascal
object TabMaster: TRESTDWClientSQL
   DataBase = DM.DWDataBase
   SQL.Strings = (
      'SELECT * FROM arqmaster WHERE IDMaster = :id')
   UpdateTableName = 'arqmaster'
end
```

### Configuração Detail
```pascal
object TabDetail: TRESTDWClientSQL
   MasterDataSet = TabMaster           // ⚠️ CRUCIAL
   DataBase = DM.DWDataBase
   
   SQL.Strings = (
      'SELECT * FROM arqdetail WHERE IDMaster = :IDMaster')
   
   RelationFields.Strings = (
      'IDMaster=IDMaster')              // ⚠️ CRUCIAL
   
   UpdateTableName = 'arqdetail'
   
   Params = <
      item
         DataType = ftInteger
         Name = 'IDMaster'
         ParamType = ptInput
      end>
end
```

## Eventos Customizados

### Servidor (definir)
```pascal
procedure TServerMethodDM.EventGetDataReplyEvent(
   var Params: TRESTDWParams; var Result: string);
var
   JSONValue: TRESTDWJSONValue;
begin
   JSONValue := TRESTDWJSONValue.Create;
   try
      FDQuery1.Open;
      JSONValue.LoadFromDataset('dados', FDQuery1, False, dmDataware);
      Params.ItemsString['result'].AsObject := JSONValue.ToJson;
   finally
      JSONValue.Free;
   end;
end;
```

### Cliente (chamar)
```pascal
var
   dwParams: TRESTDWParams;
   vError, vResult: String;
begin
   DM.RESTClientEvents.CreateDWParams('getdata', dwParams);
   try
      dwParams.ItemsString['parametro'].AsString := 'valor';
      
      DM.RESTClientEvents.SendEvent('getdata', dwParams, vError, vResult);
      
      if vError = '' then
         ShowMessage(vResult)
      else
         ShowMessage('Erro: ' + vError);
   finally
      dwParams.Free;
   end;
end;
```

## Erros Comuns

### "UpdateTableName not defined"
```pascal
// ❌ ERRADO
Qry.Post;
Qry.ApplyUpdates(vError);

// ✅ CORRETO
Qry.UpdateTableName := 'arqtabela';
Qry.Post;
Qry.ApplyUpdates(vError);
```

### "No records updated"
```pascal
// ❌ ERRADO
Qry.Edit;
Qry.Post;
Qry.ApplyUpdates(vError);

// ✅ CORRETO
Qry.FieldByName('IDCampo').ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];
Qry.Edit;
Qry.Post;
Qry.ApplyUpdates(vError);
```

### "Access violation on Free"
```pascal
// ❌ ERRADO
Qry.Free;

// ✅ CORRETO
FreeAndNil(Qry);
```

## Melhores Práticas

1. SEMPRE use try-finally
2. Feche antes de reabrir: `Qry.Close; Qry.SQL.Clear;`
3. Use parâmetros (nunca concatenação)
4. Verifique ApplyUpdates e trate erros
5. Reutilize conexões (não crie novas por query)
6. Habilite compressão: `Compression := True`
7. Defina UpdateTableName antes de DML
8. Marque chaves com ProviderFlags
