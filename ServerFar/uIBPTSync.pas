unit uIBPTSync;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, System.IOUtils, System.Math,
  uRESTDWBasicDB, uRESTDWIdBase, MarcFMX, uDWServer, uDM;

type
  // Exceção com log automático, contendo [IBPT]
  EIBPTSyncError = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
    class procedure Log(const Msg: string); static;
  end;

  // Sincroniza arqibpt do master (remoto) → cliente (local) para a UF.
  // Copia TODOS se cliente estiver vazio para a UF; caso contrário,
  // só os com UltAtu > ABaseDate OU ausentes no cliente.
  // Retorna quantidade de linhas processadas. Usa Array DML com lotes (ABatchSize).
  function SyncIBPTFromMaster(const AMasterConn: TRESTDWIdDatabase; const ABaseDate: TDateTime; const ABatchSize: Integer = 500): Integer;

implementation

// -------------- Logging de Erros -------------- //
constructor EIBPTSyncError.Create(const Msg: string);
begin
   inherited Create(Msg);
   Log(Msg);
end;

class procedure EIBPTSyncError.Log(const Msg: string);
var
  dt:TDateTime;
  baseDir,logDir,fileName,line:String;
begin
   try
      dt := Now;
      baseDir := ExtractFilePath(ParamStr(0));
      logDir  := TPath.Combine(baseDir, 'doc');
      TDirectory.CreateDirectory(logDir);
      fileName := TPath.Combine(logDir, 'log_'+FormatDateTime('yyyy-mm-dd',Date)+'.dat');
      line     := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', dt) + '[IBPT]' + Msg + sLineBreak;
      TFile.AppendAllText(fileName, line, TEncoding.UTF8);
   except
   end;
end;

// ------------- Sincronização ------------- //
function SyncIBPTFromMaster(const AMasterConn: TRESTDWIdDatabase;const ABaseDate: TDateTime;const ABatchSize: Integer = 500): Integer;
type
  TRow = record
    UF: string;
    CodNCM: Integer;
    TaxaMun, TaxaEst, TaxaFed, TaxaImp: Double;
    UltAtu: TDateTime;
  end;
var
   Row:TRow;
   UF:String;
   Rows: TList<TRow>;
   StartedTxn: Boolean;
   locServer:TDMServer;
   QSrc: TRESTDWClientSQL;
   QClientKeys,QIns:TFDQuery;
   Need, i, N, BatchEnd: Integer;
   ClientHas: TDictionary<Integer, Byte>;

   procedure PrepareInsertQuery(const Q: TFDQuery);
   begin
      Q.SQL.Text := 'INSERT INTO arqibpt ('+
      'UF, CodNCM, TaxaMun, TaxaEst, TaxaFed, TaxaImp, UltAtu) VALUES (' +
      ':UF, :CodNCM, :TaxaMun, :TaxaEst, :TaxaFed, :TaxaImp, :UltAtu) ' +
      'ON DUPLICATE KEY UPDATE TaxaMun = VALUES(TaxaMun), TaxaEst = VALUES(TaxaEst), ' +
      'TaxaFed = VALUES(TaxaFed), TaxaImp = VALUES(TaxaImp), UltAtu = VALUES(UltAtu)';
   end;

   procedure ExecBatchRange(const FromIdx, ToIdx: Integer);
   var
      Count,idx,arrIdx:Integer;
   begin
      Count := ToIdx - FromIdx + 1;
      if Count <= 0 then Exit;
      QIns.Params.ArraySize := Count;
      for arrIdx := 0 to Count - 1 do
      begin
         idx := FromIdx + arrIdx;
         QIns.Params.ParamByName('UF').AsStrings[arrIdx]      := Rows[idx].UF;
         QIns.Params.ParamByName('CodNCM').AsIntegers[arrIdx] := Rows[idx].CodNCM;
         QIns.Params.ParamByName('TaxaMun').AsFloats[arrIdx]  := Rows[idx].TaxaMun;
         QIns.Params.ParamByName('TaxaEst').AsFloats[arrIdx]  := Rows[idx].TaxaEst;
         QIns.Params.ParamByName('TaxaFed').AsFloats[arrIdx]  := Rows[idx].TaxaFed;
         QIns.Params.ParamByName('TaxaImp').AsFloats[arrIdx]  := Rows[idx].TaxaImp;
         QIns.Params.ParamByName('UltAtu').AsDateTimes[arrIdx] := Rows[idx].UltAtu;
      end; //for
      QIns.Execute(QIns.Params.ArraySize, 0);
   end;
begin
   Result := 0;
   FrmServer.Timer.Enabled := False;
   locServer := TDMServer.Create(nil);
   QClientKeys := TFDQuery.Create(nil);
   ClientHas := TDictionary<Integer, Byte>.Create;
   Rows := TList<TRow>.Create;
   QIns := TFDQuery.Create(nil);
   QIns.Connection := LocServer.FDConnect;
   QSrc := TRESTDWClientSQL.Create(nil);
   QSrc.BinaryRequest := True;
   try
      try
         if not Ping(IPSERVER, DWPort) then raise Exception.Create('Falha ao conectar com servidor AIONE.');

         QIns.SQL.Text := 'SELECT * FROM arqparametro LIMIT 1';
         QIns.Open;
         UF := QIns.FieldByName('Estmun').AsString.Trim.ToUpper;
         QIns.Close;

         // 1) Carregar chaves do cliente (por UF)
         QClientKeys.Connection := LocServer.FDConnect;
         QClientKeys.SQL.Text := 'SELECT CodNCM FROM arqibpt WHERE UF = '+Aspas(UF);
         QClientKeys.Open;
         while not QClientKeys.Eof do
         begin
            ClientHas.AddOrSetValue(QClientKeys.Fields[0].AsInteger, 1);
            QClientKeys.Next;
         end;
         QClientKeys.Close;

         // 2) Ler todos registros do master para a UF
         QSrc.DataBase := AMasterConn;
         QSrc.SQL.Text := 'SELECT * FROM arqibpt WHERE UF = '+Aspas(UF);
         QSrc.Open;

         // 3) Selecionar: UltAtu > Base OU ausente no cliente
         while not QSrc.Eof do
         begin
            Need := 0;
            if QSrc.FieldByName('UltAtu').AsDateTime > ABaseDate then Inc(Need);
            if not ClientHas.ContainsKey(QSrc.FieldByName('CodNCM').AsInteger) then Inc(Need);
            if Need > 0 then
            begin
               Row.UF      := QSrc.FieldByName('UF').AsString;
               Row.CodNCM  := QSrc.FieldByName('CodNCM').AsInteger;
               Row.TaxaMun := QSrc.FieldByName('TaxaMun').AsFloat;
               Row.TaxaEst := QSrc.FieldByName('TaxaEst').AsFloat;
               Row.TaxaFed := QSrc.FieldByName('TaxaFed').AsFloat;
               Row.TaxaImp := QSrc.FieldByName('TaxaImp').AsFloat;
               Row.UltAtu  := QSrc.FieldByName('UltAtu').AsDateTime;
               Rows.Add(Row);
            end; //if
            QSrc.Next;
         end; //while
         QSrc.Close;

         if Rows.Count = 0 then Exit(0);

         // 4) Upsert em lotes no cliente
         PrepareInsertQuery(QIns);

         StartedTxn :=  not LocServer.FDConnect.InTransaction;
         if StartedTxn then LocServer.FDConnect.StartTransaction;
         N := Rows.Count;
         i := 0;
         while i < N do
         begin
            BatchEnd := Min(i + ABatchSize - 1, N - 1);
            ExecBatchRange(i, BatchEnd);
            Inc(Result, BatchEnd - i + 1);
            i := BatchEnd + 1;
         end; //while
         if StartedTxn then LocServer.FDConnect.Commit;
      except
         on E:Exception do
         begin
            if LocServer.FDConnect.InTransaction and StartedTxn then LocServer.FDConnect.Rollback;
            raise EIBPTSyncError.Create('uIBPTSync: Falha ao sincronizar IBPT (UF:'+UF+'): '+E.Message);
         end;
      end;
   finally
      QSrc.Close;
      QClientKeys.Close;
      Rows.Free;
      QSrc.Free;
      QIns.Free;
      ClientHas.Free;
      QClientKeys.Free;
      locServer.FDConnect.Close;
      if FrmServer.DWDataBase.Connected then FrmServer.DWDataBase.Connected := False;
      FrmServer.Timer.Enabled := True;
   end;
end;

end.

