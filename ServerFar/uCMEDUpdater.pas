unit uCMEDUpdater;

interface

uses
  System.SysUtils, System.Classes, uRESTDWBasicDB, FireDAC.Comp.Client,
  uDM, System.Variants, Data.DB, MarcFMX, uDWServer, System.Threading;

  procedure ExeAtuCMED;

implementation

function RemoveZerosDireita(const Value: String): String;
var
   I: Integer;
begin
   I := Length(Value);
   while (I > 0) and (Value[I] = '0') do Dec(I);
   Result := Copy(Value, 1, I);
end;

function FormatarStrReais(const valor:String):String;
begin
   Result := valor.Trim;
   if Result <> '' then
   begin
      Result := StringReplace(Result,'.','', [rfReplaceAll]);
      Result := StringReplace(Result,',','.',[rfReplaceAll]);
   end
   else Result := '0.00';
end;

function SincronizaCMED(QueDest:TFDQuery; QueOrig:TRESTDWClientSQL; locServer:TDMServer; nomTabDest:String):Boolean;
var
   I,acReg:Integer;
   SyncQuery:TFDQuery;
   FieldValue: Variant;
   DestinoFields,ValueList:TStringList;
   FieldNames,UpdateFields,InsertSQL,ValuesSQL,txtValueList:String;
begin
   Result := False;
   SyncQuery     := TFDQuery.Create(nil);
   ValueList     := TStringList.Create;
   DestinoFields := TStringList.Create;
   try
      try
         SyncQuery.Connection := locServer.FDConnect;
         SyncQuery.SQL.Text := 'SHOW COLUMNS FROM '+nomTabDest;
         SyncQuery.Open;
         while not SyncQuery.Eof do
         begin
            DestinoFields.Add(SyncQuery.FieldByName('Field').AsString);
            SyncQuery.Next;
         end;
         SyncQuery.Close;
         FieldNames   := '';
         UpdateFields := '';
         for I := 0 to DestinoFields.Count -1 do
         begin
            if I > 0 then
            begin
               FieldNames   := FieldNames+', ';
               UpdateFields := UpdateFields+', ';
            end;
            FieldNames   := FieldNames  +DestinoFields[I];
            UpdateFields := UpdateFields+DestinoFields[I]+' = VALUES('+DestinoFields[I]+')';
         end; //for
         acReg := 0;
         QueOrig.First;
         while not QueOrig.Eof do
         begin
            ValuesSQL := '(';
            for I := 0 to DestinoFields.Count - 1 do
            begin
               if I > 0 then ValuesSQL := ValuesSQL+',';
               FieldValue := QueOrig.FieldByName(DestinoFields[I]).Value;
               if VarIsNull(FieldValue) then ValuesSQL := ValuesSQL + 'NULL'
               else
               if QueOrig.FieldByName(DestinoFields[I]).DataType in [ftString,ftWideString,ftMemo,ftWideMemo,ftFixedChar,ftFixedWideChar,ftGuid] then
                  ValuesSQL := ValuesSQL + QuotedStr(FieldValue)
               else
               if QueOrig.FieldByName(DestinoFields[I]).DataType in [ftSingle,ftFloat,ftExtended,ftCurrency,ftBCD,ftFMTBcd] then
                    ValuesSQL := ValuesSQL + FormatarStrReais(FieldValue)
               else ValuesSQL := ValuesSQL + VarToStr(FieldValue);
            end; //for
            ValueList.Add(ValuesSQL+')');
            Inc(acReg);
            QueOrig.Next;
            if (acReg = 50) or QueOrig.Eof then
            begin
               txtValueList := StringReplace(ValueList.Text, sLineBreak, ',', [rfReplaceAll]);
               txtValueList := Copy(txtValueList,1,txtValueList.Length-1);
               InsertSQL := 'INSERT INTO '+nomTabDest+' ('+FieldNames+') VALUES '+txtValueList+' ON DUPLICATE KEY UPDATE '+UpdateFields;
               SyncQuery.SQL.Text := InsertSQL;
               SyncQuery.ExecSQL;
               ValueList.Clear;
               acReg := 0;
            end; //if
         end; //while
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog, 'IAServerF - Tentando sincronizar tabela '+nomTabDest+' -> '+E.Message+#10+SyncQuery.SQL.Text);
            Exit;
         end;
      end;
  finally
      FreeAndNil(SyncQuery);
      ValueList.Free;
      DestinoFields.Free;
  end;
end;

function SincronizaSUBS(QueOrig:TRESTDWClientSQL; locServer:TDMServer):Boolean;
var
   acReg:Integer;
   SyncQuery,QueIncl:TFDQuery;
begin
   Result := False;
   SyncQuery := TFDQuery.Create(nil);
   SyncQuery.Connection := locServer.FDConnect;
   QueIncl := TFDQuery.Create(nil);
   QueIncl.Connection := locServer.FDConnect;
   try
      try
         acReg := 0;
         QueOrig.First;
         while not QueOrig.Eof do
         begin
            SyncQuery.Close;
            SyncQuery.SQL.Text := 'SELECT IDSubs FROM arqsubstancia WHERE DesSubs = '+Aspas(QueOrig.FieldByName('DesSubs').AsString);
            SyncQuery.Open;
            if not SyncQuery.IsEmpty then
            begin
               QueIncl.SQL.Add(
               'UPDATE arqsubstancia SET '+
               'TipReceita = '  +Aspas(QueOrig.FieldByName('TipReceita').AsString)+','+
               'IndControle = ' +QueOrig.FieldByName('IndControle').AsString+','+
               'IndUsoCont = '  +QueOrig.FieldByName('IndUsoCont').AsString+' '+
               'WHERE IDSubs = '+SyncQuery.FieldByName('IDSubs').AsString+';');
            end else
            begin
               QueIncl.SQL.Add(
               'INSERT INTO arqsubstancia (DesSubs,TipReceita,IndControle,IndUsoCont) VALUES ('+
               Aspas(QueOrig.FieldByName('DesSubs').AsString)+','+
               Aspas(QueOrig.FieldByName('TipReceita').AsString)+','+
               QueOrig.FieldByName('IndControle').AsString+','+
               QueOrig.FieldByName('IndUsoCont').AsString+');');
            end; //if
            Inc(acReg);
            QueOrig.Next;
            if (acReg = 50) or QueOrig.Eof then
            begin
               QueIncl.ExecSQL;
               QueIncl.SQL.Clear;
               acReg := 0;
            end; //if
         end; //while
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog, 'IAServerF - Tentando sincronizar tabela arqsubstancia -> '+E.Message+#10+SyncQuery.SQL.Text);
            Exit;
         end;
      end;
   finally
      SyncQuery.Close;
      FreeAndNil(SyncQuery);
      FreeAndNil(QueIncl);
   end;
end;

// ----------------- Executa a Atualização do CMED ------------ //
procedure ExeAtuCMED;
const
   ANTI = 'G04A9,J1A,J1B,J1C1,J1C2,J1D1,J1D2,J1E,J1F,J1G1,J1G2,J1H1,J3A,J4A1,J4A5,J8B,P1A,S1A';
   PSIC = 'A14A1,D10B,G3B,H4C,H4X,M1A3,N1B2,N1A2,N1A2,N2A,N3A,N4A,N5A1,N5A9,N5B1,N5C,N6A1,N6A3,N6A4,N6A5,N6A9,N6B,N6C,N7B,N7D1,N7D9,N7E';
var
   Task:ITask;
   acReg,acPas:Integer;
   iniTime,fimTime:TTime;
   sucCMED:Boolean;
   locServer:TDMServer;
   TaskComplete:Boolean;
   auxDataAtu:TDateTime;
   auxPrecoPMC,auxPrecoPF:Double;
   OrigCMED,OrigSUBS:TRESTDWClientSQL;
   DestCMED,QueICMS,QueFabr,QueIncl:TFDQuery;
   strPerICM,strPerALC,strPerGEN,auxClasTera,basClasTera:String;
begin
   acPas   := 0;
   iniTime := EncodeTime(05,00,0,0);
   fimTime := EncodeTime(06,00,0,0);
   if (Time >= iniTime) and (Time <= fimTime) then
   begin
      TTask.Run(procedure var Success:Boolean;
      begin
         FrmServer.Timer.Enabled := False;

         // -------- Verifica Atualizações CMED ------- //  1800000 MLS
         locServer := TDMServer.Create(nil);
         QueICMS   := TFDQuery.Create(nil);
         QueIncl   := TFDQuery.Create(nil);
         QueFabr   := TFDQuery.Create(nil);
         DestCMED  := TFDQuery.Create(nil);
         OrigCMED  := TRESTDWClientSQL.Create(nil);
         DestCMED.Connection := locServer.FDConnect;
         QueICMS.Connection  := locServer.FDConnect;
         QueFabr.Connection  := locServer.FDConnect;
         QueIncl.Connection  := locServer.FDConnect;
         OrigCMED.DataBase   := FrmServer.DWDataBase;
         OrigCMED.BinaryRequest := True;

         OrigSUBS := TRESTDWClientSQL.Create(nil);
         OrigSUBS.BinaryRequest := True;
         OrigSUBS.DataBase := FrmServer.DWDataBase;
         try
            try
               FrmServer.DWDataBase.Connected := True;
               OrigCMED.SQL.Text := 'SELECT UltAtuCMED FROM dbaiserver.arqpage';
               OrigCMED.Open;
               if OrigCMED.IsEmpty then
               begin
                  raise Exception.Create('[ERRO] Erro ao tentar atualizar tabelas do arqcmed -> Tabela Origem dbaiserver.arqpage não encontrada.');
                  Exit;
               end;
               DestCMED.SQL.Text := 'SELECT UltAtuCMED FROM arqparametros';
               DestCMED.Open;
               if DestCMED.IsEmpty then
               begin
                  raise Exception.Create('[ERRO] Erro ao tentar atualizar tabelas do arqcmed -> Tabela Destino arqparametros não encontrada.');
                  Exit;
               end;

               if OrigCMED.FieldByName('UltAtuCMED').AsDateTime <= DestCMED.FieldByName('UltAtuCMED').AsDateTime then Exit;
               auxDataAtu := OrigCMED.FieldByName('UltAtuCMED').AsDateTime;

               // ........ Sincroniza Dados Entre as Tabelas CMED Origem e Destino ........ //
               OrigCMED.Close;
               OrigCMED.SQL.Text := 'SELECT * FROM dbaiserver.arqcmed';
               OrigCMED.Open;
               if OrigCMED.IsEmpty then
               begin
                  raise Exception.Create('ERRO: Erro ao tentar atualizar tabelas do arqcmed -> Tabela Origem arqcmed não encontrada.');
                  Exit;
               end;
               DestCMED.Close;
               DestCMED.SQL.Text := 'SELECT * FROM arqcmed';
               DestCMED.Open;

               sucCMED := SincronizaCMED(DestCMED, OrigCMED, locServer, 'arqcmed');

               if sucCMED then
               begin
                  // ..... Atualiza Preços Tabela arqproduto da Farmácia ..... //
                  acPas := 1;
                  strPerICM := '';
                  strPerALC := '';
                  strPerGEN := '';
                  QueICMS.SQL.Text := 'SELECT ICM.*,MUN.IndALC FROM arqparametros PAR LEFT JOIN '+
                  'arqmuni MUN ON PAR.Codmun = MUN.Codmun LEFT JOIN arqicmsuf ICM ON MUN.Estmun = ICM.UFICMS';
                  QueICMS.Open;
                  while not QueICMS.Eof do
                  begin
                     if QueICMS.FieldByName('IndGEN').AsString = '1' then
                        strPerGEN := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)))
                     else
                     if QueICMS.FieldByName('IndALC').AsBoolean then
                          strPerALC := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)))
                     else strPerICM := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)));
                     QueICMS.Next;
                  end; //while

                  acReg := 0;
                  QueIncl.SQL.Clear;
                  OrigCMED.First;
                  while not OrigCMED.Eof do
                  begin
                     // ..... Coleta Preços de Acordo com o ICMS da Farmácia ..... //
                     if not OrigCMED.FieldByName('IndICMS0').AsBoolean then
                     begin
                        if (OrigCMED.FieldByName('TipoPro').AsString = 'G') and (strPerGEN <> '') then
                        begin
                           auxPrecoPMC := OrigCMED.FieldByName('PrePMC'+strPerGEN).AsFloat;
                           auxPrecoPF  := OrigCMED.FieldByName('PreFab'+strPerGEN).AsFloat;
                        end else
                        begin
                           auxPrecoPMC := OrigCMED.FieldByName('PrePMC'+strPerICM).AsFloat;
                           auxPrecoPF  := OrigCMED.FieldByName('PreFab'+strPerICM).AsFloat;
                        end;
                     end else
                     begin
                        auxPrecoPMC := OrigCMED.FieldByName('PrePMC00').AsFloat;
                        auxPrecoPF  := OrigCMED.FieldByName('PreFab00').AsFloat;
                     end; //if

                     // ..... Inclui / Veririfca se Existe Fabricante ..... //
                     acPas := 2;
                     QueFabr.Close;
                     QueFabr.SQL.Text := 'SELECT IDPess FROM arqpessoa WHERE CpfCnpjPes = '+Aspas(OrigCMED.FieldByName('CNPJlab').AsString);
                     QueFabr.Open;
                     if QueFabr.IsEmpty then
                     begin
                        QueFabr.Close;
                        QueFabr.SQL.Text := 'INSERT INTO arqpessoa (CpfCnpjPes,Nompes,IDEsppes,TipoPes) VALUES ('+
                        Aspas(OrigCMED.FieldByName('CNPJlab').AsString)+','+Aspas(Copy(OrigCMED.FieldByName('NomLab').AsString,1,80))+',3,'+Aspas('0')+')';
                        QueFabr.ExecSQL;
                        QueFabr.Close;
                        QueFabr.SQL.Text := 'SELECT IDPess FROM arqpessoa WHERE CpfCnpjPes = '+Aspas(OrigCMED.FieldByName('CNPJlab').AsString);
                        QueFabr.Open;
                     end; //if

                     acPas := 3;
                     auxClasTera := '0';
                     basClasTera := Trim(Copy(OrigCMED.FieldByName('ClasTerap').AsString,1,AnsiPos('-',OrigCMED.FieldByName('ClasTerap').AsString)-1));
                     if AnsiPos(basClasTera, ANTI) > 0 then auxClasTera := '1' else
                     if AnsiPos(basClasTera, PSIC) > 0 then auxClasTera := '2';

                     QueIncl.SQL.Add('UPDATE arqproduto SET '+
                     'IDFabr = '   +QueFabr.FieldByName('IDPess').AsString+','+
                     'ClasTera = ' +Aspas(auxClasTera)+','+
                     'TipLista = ' +Aspas(OrigCMED.FieldByName('TipoLista').AsString) +','+
                     'TipoPre = '  +Aspas('1')+','+
                     'TipoPro = '  +Aspas(OrigCMED.FieldByName('TipoPro').AsString)+','+
                     'RegistoMS = '+Aspas(OrigCMED.FieldByName('RegistoMS').AsString)+','+
                     'PrecoFab = ' +FormatDouble(auxPrecoPF, 11,2)+','+
                     'PrecoPMC = ' +FormatDouble(auxPrecoPMC,11,2)+','+
                     'PrecoVen = ' +FormatDouble(auxPrecoPMC,11,2)+','+
                     'UltAtuCMED = NOW()');
                     if auxPrecoPF > 0.00 then
                     begin
                        QueIncl.SQL.Add(',MarkupCim = ROUND((('+FormatDouble(auxPrecoPMC,11,2)+' - '+FormatDouble(auxPrecoPF,11,2)+') / '+FormatDouble(auxPrecoPF,11,2)+') * 100,2),'+
                        'Markup = ROUND((('+FormatDouble(auxPrecoPMC,11,2)+' - '+FormatDouble(auxPrecoPF,11,2)+') / '+FormatDouble(auxPrecoPF,11,2)+') * 100,2)');
                     end;
                     QueIncl.SQL.Add(' WHERE CodEANPri = '+Aspas(OrigCMED.FieldByName('CodEAN').AsString)+';');
                     Inc(AcReg);
                     OrigCMED.Next;
                     if (acReg > 500) or OrigCMED.Eof then
                     begin
                        QueIncl.ExecSQL;
                        QueIncl.SQL.Clear;
                        AcReg := 0;
                     end;
                  end; //while

                  // ..... Sincroniza Dados Entre as Tabelas arqsubscmed e arqsubstancia ..... //
                  acPas := 4;
                  OrigSUBS.Close;
                  OrigSUBS.SQL.Text := 'SELECT * FROM dbaiserver.arqsubscmed';
                  OrigSUBS.Open;
                  if OrigSUBS.IsEmpty then
                  begin
                     raise Exception.Create('[ERRO] Erro ao tentar atualizar -> Tabela arqsubscmed não encontrada.');
                     Exit;
                  end;
                  acPas   := 5;
                  Success := SincronizaSUBS(OrigSUBS,locServer);
               end;
               TThread.Synchronize(nil, procedure
               begin
                  if Success then
                  begin
                     DestCMED.Close;
                     DestCMED.SQL.Text := 'UPDATE arqparametros SET UltAtuCMED = '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',auxDataAtu));
                     DestCMED.ExecSQL;
                  end; //if
               end);
            except
               on E:Exception do
               begin
                  SalvaLog(ArqLog,'[ERRO] IAServerF - Tentando atualizar tabelas arqcmed/arqsubstancia, Passo: '+acPas.ToString+' -> '+E.Message);
                  Exit;
               end;
            end;
         finally
            OrigCMED.Close;   FreeAndNil(OrigCMED);
            DestCMED.Close;   FreeAndNil(DestCMED);
            OrigSUBS.Close;   FreeAndNil(OrigSUBS);
            QueICMS.Close;    FreeAndNil(QueICMS);
            QueFabr.Close;    FreeAndNil(QueFabr);
            QueIncl.Close;    FreeAndNil(QueIncl);
            locServer.FDConnect.Close;
            if FrmServer.DWDataBase.Connected then FrmServer.DWDataBase.Connected := False;
            FrmServer.Timer.Enabled := True;
         end; //try
      end);
   end; //if
end;

end.
