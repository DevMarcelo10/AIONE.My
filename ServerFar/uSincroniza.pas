unit uSincroniza;

interface

uses
   Windows, Messages, MarcFMX, Dialogs, FireDAC.Comp.Client, System.SysUtils,
   System.Classes, uDWServer, uRESTDWParams, uRESTDWBasicDB, uRESTDWIdBase,
   uRESTDWMassiveBuffer, DB, System.DateUtils,System.Variants, System.JSON,
   uRESTDWServerEvents;

   function  DownloadConv(recDWClientEvents:TRESTDWClientEvents):Boolean;
   function  Sincroniza(NomeTabela:String):Boolean;
   function  UploadConvConv(recDWClientEvents:TRESTDWClientEvents):Boolean;
   procedure ConcectAtuParam(recConnect:TFDConnection; rDatabase,rServer,rUser_name,rPassword,rPort:String);

var
   FDConnect:TFDConnection;

implementation

// ------------------- Efetiva Download --------------- //
function DownloadConv(recDWClientEvents:TRESTDWClientEvents):Boolean;
var
   I:Integer;
   auxUltAtu:TDateTIme;
   DWParams:TRESTDWParams;
   QueDest:TFDQuery;
   QueOrig:TFDQuery;
   JSONObj:TJSONObject;
   JSONArray:TJSONArray;
   RecordObj:TJSONObject;
   auxCNPJFar,vRetMsg,JSONString:String;
begin
   Result := False;
   FrmServer.DWDataBase.Active := False;
   FrmServer.DWDataBase.PoolerName := 'TDMServer.RESTDWPoolerSin';
   DWParams  := TRESTDWParams.Create;
   FDConnect := TFDConnection.Create(nil);
   QueOrig   := TFDQuery.Create(nil);
   QueDest   := TFDQuery.Create(nil);
   QueOrig.Connection := FDConnect;
   QueDest.Connection := FDConnect;
   try
      try
         ConcectAtuParam(FDConnect,'dbaione',IPSERVERLoc,'root',SENHADBLoc,PORTADBLoc);
         FDConnect.Connected := True;
         QueOrig.SQL.Text := 'SELECT CNPJFar,UltDownConv FROM dbaione.arqparametros LIMIT 1';
         QueOrig.Open;
         auxCNPJFar := QueOrig.FieldByName('CNPJFar').AsString;
         auxUltAtu  := QueOrig.FieldByName('UltDownConv').AsDateTime;

         // ----------- DOWNLOAD Pessoas/Clientes (Conveniados) dos Convênios ------- //
         QueOrig.Close;
         QueOrig.SQL.Text := 'SELECT CON.*,PES.CpfCnpjPes FROM arqconvenio CON LEFT JOIN arqpessoa PES ON CON.IDPessPri = PES.IDPess WHERE CON.TipConv = '+Aspas('EMPRESARIAL');
         QueOrig.Open;
         if not QueOrig.IsEmpty then
         begin
            QueDest.SQL.Clear;
            recDWClientEvents.CreateDWParams('getconveniado', DWParams);
            while not QueOrig.Eof do
            begin
               DWParams.ItemsString['CNPJ_FARMACIA'].AsString := auxCNPJFar;
               DWParams.ItemsString['CNPJ_CONVENIO'].AsString := QueOrig.FieldByName('CpfCnpjPes').AsString;
               DWParams.ItemsString['ULT_ATUALIZA'].AsString  := FormatDateTime('yyyy-mm-dd hh:mm:ss', auxUltAtu);
               recDWClientEvents.SendEvent('getconveniado', DWParams, JSONString);
               if AnsiPos('ERROR_',JSONString) <= 0 then
               begin
                  JSONObj := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
                  JSONArray := JSONObj.GetValue<TJSONArray>('getconveniado');
                  if JSONArray <> nil then
                  begin
                     for I := 0 to JSONArray.Count - 1 do
                     begin
                        RecordObj := JSONArray.Items[I] as TJSONObject;
                        QueDest.SQL.Add('UPDATE arqpessconv COV LEFT JOIN arqpessoa PES ON COV.IDPess = PES.IDPess SET IndAtivo = '+
                        Aspas(RecordObj.GetValue<String>('ATIVO'))+', VlrLimite = '+FloatToStr(RecordObj.GetValue<Double>('VLR_LIMITE'))+
                        ' WHERE COV.IDConv = '+QueOrig.FieldByName('IDConv').AsString+' AND PES.CpfCnpjPes = '+Aspas(RecordObj.GetValue<String>('CPF_CNPJ'))+';');
                     end; // for
                     QueDest.ExecSQL;
                  end; //if
               end
               else SalvaLog(ArqLog,'ERRO ao salvar sincronização Download no AIONE Convênios -> CNPJ Convênio = '+QueOrig.FieldByName('CpfCnpjPes').AsString);
               QueOrig.Next;
            end; //while
         end; //if
         Sleep(3000);
         QueOrig.Close;
         QueOrig.SQL.Text := 'UPDATE dbaione.arqparametros SET UltDownConv = CURRENT_TIMESTAMP';
         QueOrig.ExecSQL;
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog,'ERRO ao tentar sincronização Download no AIONE Convênios -> '+E.Message);
            Exit;
         end;
      end; //try
   finally
      QueDest.Close;   FreeAndNil(QueDest);
      QueOrig.Close;   FreeAndNil(QueOrig);
      FDConnect.Connected := False;
      FDConnect.Free;
   end;
end;

// ----------------- Efetiva Upload AIONE Convênios ------------- //
function UploadConvConv(recDWClientEvents:TRESTDWClientEvents):Boolean;
var
   acReg:Integer;
   QueOrig:TFDQuery;
   auxUltAtu:TDateTime;
   DWParams:TRESTDWParams;
   QueDest,QueAuxi:TRESTDWClientSQL;
   auxCNPJFar,auxChave,vErro,auxNomTab,vRetMsg:String;
begin
   Result := False;
   acReg  := 0;
   FrmServer.DWDataBase.Active := False;
   FrmServer.DWDataBase.PoolerName := 'TDMServer.RESTDWPoolerSin';
   FDConnect := TFDConnection.Create(nil);
   QueOrig   := TFDQuery.Create(nil);
   QueOrig.Connection := FDConnect;
   QueDest := TRESTDWClientSQL.Create(nil);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueDest.DataBase := FrmServer.DWDataBase;
   QueAuxi.DataBase := FrmServer.DWDataBase;
   DWParams := TRESTDWParams.Create;
   try
      try
         recDWClientEvents.CreateDWParams('', DWParams);
         ConcectAtuParam(FDConnect,'dbaione',IPSERVERLoc,'root',SENHADBLoc,PORTADBLoc);
         FDConnect.Connected := True;
         QueOrig.SQL.Text := 'SELECT CNPJFar,UltDownConv FROM dbaione.arqparametros LIMIT 1';
         QueOrig.Open;
         auxCNPJFar := QueOrig.FieldByName('CNPJFar').AsString;
         auxUltAtu  := QueOrig.FieldByName('UltDownConv').AsDateTime;

         // ........ Tabela de Filiais (Empresas) ........ //
         QueOrig.Close;
         QueOrig.SQL.Text := 'SELECT CLI.*, PES.CpfCnpjPes FROM dbaione.arqconvfilcli CLI '+
         'LEFT JOIN dbaione.arqconvenio CON ON CLI.IDConv = CON.IDConv '+
         'LEFT JOIN dbaione.arqpessoa PES ON CON.IDPessPri = PES.IDPess WHERE '+
         'CLI.DatHorAlt > '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',auxUltAtu))+' GROUP BY CLI.IDConv,CLI.CNPJFil';
         QueOrig.Open;
         if not QueOrig.IsEmpty then
         begin
            recDWClientEvents.CreateDWParams('postfilial', DWParams);
            while not QueOrig.Eof do
            begin
               DWParams.ItemsString['CNPJ_FARMACIA'].AsString := auxCNPJFar;
               DWParams.ItemsString['CNPJ_CONVENIO'].AsString := QueOrig.FieldByName('CpfCnpjPes').AsString;
               DWParams.ItemsString['CNPJ_FILIAL'].AsString   := QueOrig.FieldByName('CNPJFil').AsString;
               if QueOrig.FieldByName('IndDelete').AsString <> '1' then
               begin
                  DWParams.ItemsString['NOME'].AsString        := QueOrig.FieldByName('Nomfil').AsString;
                  DWParams.ItemsString['ENDERECO'].AsString    := QueOrig.FieldByName('Endfil').AsString;
                  DWParams.ItemsString['NUM_END'].AsString     := QueOrig.FieldByName('NroEnd').AsString;
                  DWParams.ItemsString['COMP_END'].AsString    := QueOrig.FieldByName('CompEnd').AsString;
                  DWParams.ItemsString['BAIRRO'].AsString      := QueOrig.FieldByName('Baifil').AsString;
                  DWParams.ItemsString['CEP'].AsString         := QueOrig.FieldByName('CEPFil').AsString;
                  DWParams.ItemsString['CIDADE_IBGE'].AsString := QueOrig.FieldByName('Codmun').AsString;
                  DWParams.ItemsString['TELEFONE'].AsString    := QueOrig.FieldByName('FoneFil').AsString;
               end
               else DWParams.ItemsString['EXCLUIR'].AsString := '1';
               recDWClientEvents.SendEvent('postfilial', DWParams, vRetMsg);
               if AnsiPos('OK',vRetMsg) <= 0 then raise Exception.Create(vRetMsg);
               QueOrig.Next;
            end; //while

            // ..... Efetiva exclusão física dos registros marcados com IndDelete = "1"
            QueOrig.Close;
            QueOrig.SQL.Text := 'DELETE FROM dbaione.arqconvfilcli WHERE IndDelete = '+Aspas('1');
            QueOrig.ExecSQL;
         end; //if

         // ........ Tabela de Convênios ........ //
         QueOrig.Close;
         QueOrig.SQL.Text := 'SELECT CON.Nomcon,CON.DiaFecha,CON.DiaVence,CON.EmailWeb,CON.SenhaWeb,CON.IndDelete,CON.IndDelWeb,'+
         'PES.CpfCnpjPes,PES.Nompes,PES.Endpes,PES.NroEnd,PES.CompEnd,PES.Ceppes,PES.Baipes,PES.Codmun,PES.FonePes '+
         'FROM dbaione.arqconvenio CON LEFT JOIN dbaione.arqpessoa PES ON CON.IDPessPri = PES.IDPess '+
         'WHERE CON.TipConv = "EMPRESARIAL" AND CON.EmailWeb != "" AND NOT ISNULL(CON.EmailWeb) AND CON.SenhaWeb != "" AND '+
         'NOT ISNULL(CON.SenhaWeb) AND CON.DatHorAlt > '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',auxUltAtu))+' GROUP BY CON.IDConv';
         QueOrig.Open;

         if not QueOrig.IsEmpty then
         begin
            recDWClientEvents.CreateDWParams('postconvenio', DWParams);
            while not QueOrig.Eof do
            begin
               DWParams.ItemsString['CNPJ_FARMACIA'].AsString := auxCNPJFar;
               DWParams.ItemsString['CNPJ_CONVENIO'].AsString := QueOrig.FieldByName('CpfCnpjPes').AsString;
               DWParams.ItemsString['CNPJ_CONVENIO'].AsString := QueOrig.FieldByName('CpfCnpjPes').AsString;
               if (QueOrig.FieldByName('IndDelete').AsString <> '1') and (QueOrig.FieldByName('IndDelWeb').AsString <> '1') then
               begin
                  DWParams.ItemsString['NOME_CONV'].AsString   := QueOrig.FieldByName('Nomcon').AsString;
                  DWParams.ItemsString['NOME_MATRIZ'].AsString := QueOrig.FieldByName('Nompes').AsString;
                  DWParams.ItemsString['ENDERECO'].AsString    := QueOrig.FieldByName('Endpes').AsString;
                  DWParams.ItemsString['NUM_END'].AsString     := QueOrig.FieldByName('NroEnd').AsString;
                  DWParams.ItemsString['COMP_END'].AsString    := QueOrig.FieldByName('CompEnd').AsString;
                  DWParams.ItemsString['BAIRRO'].AsString      := QueOrig.FieldByName('Baipes').AsString;
                  DWParams.ItemsString['CEP'].AsString         := QueOrig.FieldByName('Ceppes').AsString;
                  DWParams.ItemsString['CIDADE_IBGE'].AsString := QueOrig.FieldByName('Codmun').AsString;
                  DWParams.ItemsString['TELEFONE'].AsString    := QueOrig.FieldByName('Fonepes').AsString;
                  DWParams.ItemsString['DIA_VENCE'].AsString   := QueOrig.FieldByName('DiaVence').AsString;
                  DWParams.ItemsString['DIA_FECHA'].AsString   := QueOrig.FieldByName('DiaFecha').AsString;
                  DWParams.ItemsString['EMAIL_LOGIN'].AsString := QueOrig.FieldByName('EmailWeb').AsString;
                  DWParams.ItemsString['SENHA_LOGIN'].AsString := QueOrig.FieldByName('SenhaWeb').AsString;
               end
               else DWParams.ItemsString['EXCLUIR'].AsString := '1';
               recDWClientEvents.SendEvent('postconvenio', DWParams, vRetMsg);
               if AnsiPos('OK',vRetMsg) <= 0 then raise Exception.Create(vRetMsg);
               QueOrig.Next;
            end; //while

            // ..... Efetiva exclusão física dos registros marcados com IndDelete = "1"
            QueOrig.Close;
            QueOrig.SQL.Clear;
            QueOrig.SQL.Add('DELETE FROM dbaione.arqconvfilcli WHERE IDConv IN (SELECT IDConv FROM dbaione.arqconvenio WHERE IndDelete = "1");');
            QueOrig.SQL.Add('DELETE FROM dbaione.arqconvenio WHERE IndDelete = "1";');
            QueOrig.ExecSQL;
         end; //if

         // ---------------- Clientes (Conveniados) dos Convênios ------------ //
         QueOrig.Close;
         QueOrig.SQL.Text :=
         'SELECT PES.Nompes,PES.Endpes,PES.NroEnd,PES.CompEnd,PES.Baipes,PES.CEPPes,PES.Codmun,'+
         'PES.CelularPes,PES.CpfCnpjPes,MUN.Nommun,MUN.Estmun,CON.IDPessPri,COP.NroMatric,COP.NroCartao,'+
         'COP.VlrLimite,COP.DatcadCon,COP.IndAtivo,COP.CNPJFil, PEC.CpfCnpjPes AS CNPJCon FROM arqpessoa PES '+
         'LEFT JOIN arqpessconv COP ON PES.IDPess = COP.IDPess LEFT JOIN arqconvenio CON ON COP.IDConv = CON.IDConv '+
         'LEFT JOIN arqpessoa PEC ON CON.IDPessPri = PEC.IDPess LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
         'WHERE CON.TipConv = '+Aspas('EMPRESARIAL')+' AND COP.CNPJFil != "" AND NOT ISNULL(COP.CNPJFil) AND ('+
         'PES.DatHorAlt >= '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss', auxUltAtu))+' OR '+
         'COP.DatHorAlt >= '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss', auxUltAtu))+') GROUP BY PES.IDPess,COP.IDConv';
         QueOrig.Open;

         if not QueOrig.IsEmpty then
         begin
            recDWClientEvents.CreateDWParams('postconveniado', DWParams);
            while not QueOrig.Eof do
            begin
               DWParams.ItemsString['CNPJ_FARMACIA'].AsString := auxCNPJFar;
               DWParams.ItemsString['CNPJ_CONVENIO'].AsString := Copy(QueOrig.FieldByName('CNPJCon').AsString,1,14);
               DWParams.ItemsString['CPF_CNPJ'].AsString      := Copy(QueOrig.FieldByName('CpfCnpjPes').AsString.Trim,1,14);
               DWParams.ItemsString['CNPJ_FILIAL'].AsString   := Copy(QueOrig.FieldByName('CNPJFil').AsString.Trim,1,14);
               DWParams.ItemsString['NOME'].AsString          := Copy(QueOrig.FieldByName('Nompes').AsString.Trim, 1,45);
               DWParams.ItemsString['ENDERECO'].AsString      := Copy(QueOrig.FieldByName('Endpes').AsString.Trim, 1,50);
               DWParams.ItemsString['NUMEND'].AsString        := Copy(QueOrig.FieldByName('NroEnd').AsString.Trim, 1,08);
               DWParams.ItemsString['COMPLEND'].AsString      := Copy(QueOrig.FieldByName('CompEnd').AsString.Trim,1,35);
               DWParams.ItemsString['BAIRRO'].AsString        := Copy(QueOrig.FieldByName('Baipes').AsString.Trim, 1,40);
               DWParams.ItemsString['CEP'].AsString           := Copy(QueOrig.FieldByName('CEPPes').AsString.Trim, 1,08);
               DWParams.ItemsString['CIDADEIBGE'].AsString    := Copy(QueOrig.FieldByName('Codmun').AsString.Trim, 1,7);
               DWParams.ItemsString['TELEFONE'].AsString      := Copy(QueOrig.FieldByName('CelularPes').AsString.Trim,1,11);
               DWParams.ItemsString['MATRICULA'].AsString     := Copy(QueOrig.FieldByName('NroMatric').AsString.Trim, 1,18);
               DWParams.ItemsString['CARTAO'].AsString        := Copy(QueOrig.FieldByName('NroCartao').AsString.Trim, 1,18);
               DWParams.ItemsString['VALOR_LIMITE'].AsString  := FloatToStr(QueOrig.FieldByName('VlrLimite').AsFloat);
               DWParams.ItemsString['DATA_HORA_ALT'].AsString := FormatDateTime('yyyy-mm-dd hh:mm:ss', Now());
               DWParams.ItemsString['ATIVO'].AsString         := Copy(QueOrig.FieldByName('IndAtivo').AsString.Trim,1,1);
               recDWClientEvents.SendEvent('postconveniado', DWParams, vRetMsg);
               if AnsiPos('OK',vRetMsg) <= 0 then raise Exception.Create(vRetMsg);
               QueOrig.Next;
            end; //while
         end; //if

         // ---------------- Vendas (Consumo) dos Conveniados ------------ //
         QueOrig.Close;
         QueOrig.SQL.Text :=
         'SELECT PEV.IDPed,PEV.Datped,PEV.TotPedido,COP.CNPJFil,PEC.CpfCnpjPes AS CNPJCon,'+
         'CLI.CpfCnpjPes AS CpfCnpjPesCli, PEV.IndDelete FROM arqpedido PEV '+
         'LEFT JOIN arqpessconv COP ON COP.IDPess = PEV.IDPess '+
         'LEFT JOIN arqconvenio CON ON COP.IDConv = CON.IDConv '+
         'LEFT JOIN arqpessoa CLI ON PEV.IDPess = CLI.IDPess '+
         'LEFT JOIN arqpessoa PEC ON CON.IDPessPri = PEC.IDPess '+
         'WHERE CON.TipConv = '+Aspas('EMPRESARIAL')+' AND COP.CNPJFil != "" AND NOT ISNULL(COP.CNPJFil) AND '+
         'PEV.DatHorAlt >= '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss', auxUltAtu))+' '+
         'GROUP BY PEV.IDFilial,PEV.IDPed,PEV.IDPess,COP.IDConv';
         QueOrig.Open;

         if not QueOrig.IsEmpty then
         begin
            recDWClientEvents.CreateDWParams('postconsumo', DWParams);
            while not QueOrig.Eof do
            begin
               if QueOrig.FieldByName('IndDelete').AsString <> '1' then
               begin
                  DWParams.ItemsString['CNPJ_FARMACIA'].AsString := auxCNPJFar;
                  DWParams.ItemsString['CNPJ_CONVENIO'].AsString := Copy(QueOrig.FieldByName('CNPJCon').AsString,1,14);
                  DWParams.ItemsString['CPF_CNPJ'].AsString      := Copy(QueOrig.FieldByName('CpfCnpjPesCli').AsString.Trim,1,14);
                  DWParams.ItemsString['CNPJ_FILIAL'].AsString   := Copy(QueOrig.FieldByName('CNPJFil').AsString.Trim,1,14);
                  DWParams.ItemsString['DOCUMENTO'].AsString     := Copy(QueOrig.FieldByName('IDPed').AsString.Trim,1,12);
                  DWParams.ItemsString['DATA_HORA'].AsString     := FormatDateTime('yyyy-mm-dd hh:mm:ss',QueOrig.FieldByName('Datped').AsDateTime);
                  DWParams.ItemsString['VALOR'].AsString         := FloatToStr(QueOrig.FieldByName('TotPedido').AsFloat);
                  recDWClientEvents.SendEvent('postconsumo', DWParams, vRetMsg);
               end
               else DWParams.ItemsString['EXCLUIR'].AsString := '1';
               if AnsiPos('OK',vRetMsg) <= 0 then raise Exception.Create(vRetMsg);
               QueOrig.Next;
            end; //while
         end; //if

         QueOrig.Close;
         QueOrig.SQL.Text := 'UPDATE dbaione.arqparametros SET UltUpLoadCon = CURRENT_TIMESTAMP';
         QueOrig.ExecSQL;
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog,'ERRO ao tentar sincronização Upload com AIONE Convênios -> '+E.Message);
            Exit;
         end;
      end; //try
   finally
      FreeAndNil(DWParams);
      QueOrig.Close;    FreeAndNil(QueOrig);
      QueDest.Close;    FreeAndNil(QueDest);
      QueAuxi.Close;    FreeAndNil(QueAuxi);
      FDConnect.Connected := False;
      FDConnect.Free;
      if FrmServer.DWDataBase.Active then FrmServer.DWDataBase.Active := False;
   end;
end;

function PrepareSQLValue(Field:TField):String;
begin
   if not Field.IsNull then
   begin
      case Field.DataType of
         ftString, ftMemo, ftWideString: Result := Aspas(Field.AsString);
         ftFloat, ftCurrency, ftBCD: Result := StringReplace(FloatToStr(Field.AsFloat), ',', '.', [rfReplaceAll]);
         ftDate, ftTime, ftDateTime: Result := Aspas(FormatDateTime('YYYY-MM-DD HH:MM:SS', Field.AsDateTime));
      else Result := Field.AsString;
      end;
   end
   else Result := 'NULL';
end;


//----> PRECISA TESTAR ABAIXO:

// ---------- Sincronização de Tabelas ----------- //
function Sincroniza(NomeTabela:String):Boolean;
var
   I,acReg:Integer;
   auxUltAtu:TDateTIme;
   FDConnect:TFDConnection;
   QueOrig:TFDQuery;
   QueDest:TRESTDWClientSQL;
   vErro,auxCampo,auxValue,auxValores:String;
begin
   Result := False;
   acReg  := 0;
   FrmServer.DWDataBase.Active := False;
   FrmServer.DWDataBase.PoolerName := 'TDMServer.RESTDWPoolerSin';
   FDConnect := TFDConnection.Create(nil);
   QueOrig   := TFDQuery.Create(nil);
   QueOrig.Connection := FDConnect;
   QueDest := TRESTDWClientSQL.Create(nil);
   QueDest.DataBase := FrmServer.DWDataBase;
   QueDest.SQL.Text := 'SELECT * FROM '+NomeTabela+' LIMIT 1 ';
   try
      try
         QueOrig.SQL.Text := 'SELECT * FROM '+NomeTabela+' WHERE AND DatHorAlt >= '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss', auxUltAtu));
         QueOrig.Open;
         if not QueOrig.IsEmpty then
         begin
            auxCampo  := '';
            auxValue  := '';
            QueDest.Open;

            for I := 0 to Pred(QueDest.Fields.Count) do
            begin
              if (QueDest.FindField(QueOrig.Fields[I].FieldName) <> nil) and (QueDest.Fields[I].AutoGenerateValue <> arAutoInc) then
              begin
                  auxCampo   := auxCampo+iif(auxCampo.Trim = '','',',')+'%s';
                  if not (pfInKey in QueDest.Fields[I].ProviderFlags) then
                     auxValue := auxValue+iif(auxValue.Trim = '',' ON DUPLICATE KEY UPDATE ',',')+QueOrig.Fields[I].FieldName+' = VALUES ('+QueOrig.Fields[I].FieldName+')';
              end; //if
            end;
            if not (QueDest.State in [dsEdit,dsInsert]) then

            if auxCampo.Trim <> '' then
            begin
               auxValores := '';
               QueDest.Close;
               QueDest.SQL.Clear;
               QueDest.SQL.Text := 'INSERT INTO '+NomeTabela+' ('+auxCampo+') VALUES ';
               QueOrig.First;
               while not QueOrig.Eof do
               begin
                  for I := 0 to Pred(QueDest.Fields.Count) do
                  begin
                     if QueDest.FindField(QueOrig.Fields[I].FieldName) <> nil then
                     begin
                        auxValores := auxValores+iif(auxValores.Trim = '','',',')+
                        PrepareSQLValue(QueOrig.FieldByName(QueOrig.Fields[I].FieldName));
                     end;
                  end; //for
                  QueDest.SQL.Add('('+auxValores+'),');
                  QueOrig.Next;
               end; //while

               QueDest.SQL.Text := Copy(QueDest.SQL.Text,1,LastDelimiter(',',QueDest.SQL.Text)-1)+' ';
               QueDest.SQL.Add(auxValue);
               if not QueDest.ExecSQL(vErro) then
               begin
                  SalvaLog(ArqLog,'ERRO ao tentar Upload com AIONE tabela: '+NomeTabela+' -> '+vErro);
                  Exit
               end;
            end; //IF
         end; //if
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog,'ERRO ao tentar sincronização Sincronização, Tabela: '+NomeTabela+' -> '+E.Message);
            Exit;
         end;
      end;
   finally
      QueOrig.Close;  FreeAndNil(QueOrig);
      QueDest.Close;  FreeAndNil(QueDest);
   end;
end;

procedure ConcectAtuParam(recConnect:TFDConnection; rDatabase,rServer,rUser_name,rPassword,rPort:String);
begin
   with recConnect do
   begin
      Connected := False;
      Params.Clear;
      Params.Values['DriverID']  := 'MySQL';
      Params.Values['Database']  := rDatabase;
      Params.Values['Server']    := rServer;
      Params.Values['User_name'] := rUser_name;
      Params.Values['Password']  := rPassword;
      Params.Values['Port']      := rPort;
      LoginPrompt := False;
   end; //with
end;

end.

