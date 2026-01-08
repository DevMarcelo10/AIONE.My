
unit uIBPTUpdater;

interface

uses
   System.SysUtils, System.Classes, System.Net.URLClient, System.Net.HttpClient,
   System.Net.HttpClientComponent, System.NetEncoding, System.NetConsts,
   Data.DB, System.Diagnostics, System.Math, System.StrUtils, System.Character,
   Xml.XMLDoc, System.Variants, System.Generics.Collections, Xml.XMLIntf,
   FireDAC.Comp.Client, FireDAC.Stan.Param, System.IOUtils, MarcFMX;

type
   // Dados essenciais do produto retornado pela API
   TIBPTProduto = record
      UF: string;
      CodNCM: string;
      TaxaMun: Double;
      TaxaEst: Double;
      TaxaFed: Double;
      TaxaImp: Double;
   end;

   // Resultado de processamento em lote
   TIBPTBatchResult = record
      UpdatedCount: Integer;
      Failed: TArray<string>; // NCMs que falharam
   end;

   // Callback de progresso opcional
   TIBPTProgress = reference to procedure(Processed, Total: Integer; const Codigo, Msg: string);

   // Exceção específica do módulo (com log automático)
   EIBPTError = class(Exception)
   public
      constructor Create(const Msg: string); reintroduce;
      class procedure Log(const Msg: string); static;
   end;

   // Classe principal
   TIBPTUpdater = class
   private
      FConn: TFDConnection;
      FHTTP: TNetHTTPClient;
      FAllowInsecure: Boolean;
      FLastRequestTick: Int64;
      FUsePostIfBadRequest: Boolean;

      class function InvariantToFloat(const S: string): Double; static;
      class function ReadNodeFloat(const Root: IXMLNode; const Name, NS: string): Double; static;
      class function ReadNodeText(const Root: IXMLNode; const Name, NS: string): string; static;

      function BuildQuery(const Codigo, UF, GTIN: string): string;
      function ApiURL: string; inline;

      function FetchProdutoGET(const Codigo, UF, GTIN: string; out Resp: IHTTPResponse): IHTTPResponse;
      function FetchProdutoPOST(const Codigo, UF, GTIN: string; out Resp: IHTTPResponse): IHTTPResponse;
      function FetchProduto(const Codigo, UF, GTIN: string; out Produto: TIBPTProduto): Boolean;

      procedure UpsertProduto(const P: TIBPTProduto);
      procedure HTTPValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate; var Accepted: Boolean);

      class procedure SafeSleep(Milliseconds: Cardinal); static;
      function ShouldRetryHTTP(StatusCode: Integer): Boolean;
      function RetryBackoffMs(Attempt, BaseDelayMs, MaxDelayMs: Integer): Integer;
      procedure Throttle(const MinIntervalMs: Integer);
      function ExtractErrorBody(const Resp: IHTTPResponse): string;

   public
      constructor Create(const AConnection: TFDConnection);
      destructor Destroy; override;

      // Se True, ao receber 400 no GET, tenta POST form-url-encoded
      property UsePostIfBadRequest: Boolean read FUsePostIfBadRequest write FUsePostIfBadRequest;

      // Upsert de um único NCM/UF no banco
      function UpdateIBPT(const ACodigo, AUF: string; const AGTIN: string = ''): Boolean;

      // Apenas busca na API e retorna record (não grava)
      function FetchIBPT(const ACodigo, AUF: string; const AGTIN: string = ''): TIBPTProduto;

      // Lote com retry + throttle
      function UpdateIBPTBatch(const AUF: string;
        const ACodigos: array of String; const OnProgress: TIBPTProgress = nil;
        const AGTIN: string = ''; const MaxRetries: Integer = 3;
        const BaseDelayMs: Integer = 500; const MaxDelayMs: Integer = 8000;
        const MinIntervalMs: Integer = 250): TIBPTBatchResult;

      // Overload para TStrings
      function UpdateIBPTBatchStrings(const AUF: string;
        const ACodigos: TStrings; const OnProgress: TIBPTProgress = nil;
        const AGTIN: string = ''; const MaxRetries: Integer = 3;
        const BaseDelayMs: Integer = 500; const MaxDelayMs: Integer = 8000;
        const MinIntervalMs: Integer = 250): TIBPTBatchResult;

      function GetVigenciaFim(const ACodigo, AUF: string; const AGTIN: string = ''): string; overload;
   end;

implementation

const
   C_NS    = 'http://schemas.datacontract.org/2004/07/Aplicacao.DTO';
   C_TOKEN = 'CrUR88KTVnkUxHj3N4sJIgE_hIVoLzoE52EdpewpZ2EIWAkM0wLeMYFzWIgNuXc5';
   C_CNPJ  = '56185202000100';
   C_EX    = '0';

   { EIBPTError }

constructor EIBPTError.Create(const Msg: string);
begin
   inherited Create(Msg);
   Log(Msg);
end;

class procedure EIBPTError.Log(const Msg: string);
var
   dt: TDateTime;
   baseDir, logDir, fileName, line: string;
begin
   try
      dt := Now;
      baseDir := ExtractFilePath(ParamStr(0));
      logDir := TPath.Combine(baseDir, 'log');
      TDirectory.CreateDirectory(logDir);
      fileName := TPath.Combine(logDir, FormatDateTime('yyyy"-"mm"-"dd', dt)+ '.log');
      line := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', dt) + ' [IBPT] ' + Msg +sLineBreak;
      TFile.AppendAllText(fileName, line, TEncoding.UTF8);
   except
   end;
end;

{ TIBPTUpdater }

constructor TIBPTUpdater.Create(const AConnection: TFDConnection);
begin
   inherited Create;
   if AConnection = nil then
      raise EIBPTError.Create('TFDConnection não informado.');
   FConn := AConnection;
   FHTTP := TNetHTTPClient.Create(nil);
   FHTTP.SecureProtocols := [THTTPSecureProtocol.TLS12, THTTPSecureProtocol.TLS13];
   FHTTP.OnValidateServerCertificate := HTTPValidateServerCertificate;
   FHTTP.ConnectionTimeout := 10000;
   FHTTP.ResponseTimeout   := 20000;
   FHTTP.Accept    := 'application/xml, text/xml;q=0.9, */*;q=0.8';
   FHTTP.UserAgent := 'IBPTUpdater/1.4 (Delphi RAD 11; TLS12+)';
   FAllowInsecure  := False;
   FUsePostIfBadRequest := True;
   FLastRequestTick := 0;
   Randomize; // jitter no backoff
end;

destructor TIBPTUpdater.Destroy;
begin
   FHTTP.Free;
   inherited;
end;

procedure TIBPTUpdater.HTTPValidateServerCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const Certificate: TCertificate;
  var Accepted: Boolean);
begin
   // Somente para ambientes de teste. Em produção mantenha a validação padrão.
   // if FAllowInsecure then Accepted := True;
end;

class function TIBPTUpdater.InvariantToFloat(const S: string): Double;
var
   FS: TFormatSettings;
begin
   FS := TFormatSettings.Invariant; // '.' decimal
   if not TryStrToFloat(S, Result, FS) then Result := 0.0;
end;

function TIBPTUpdater.ApiURL: string;
begin
   Result := 'https://apidoni.ibpt.org.br/api/v1/produtos';
end;

function TIBPTUpdater.BuildQuery(const Codigo, UF, GTIN: string): string;

   procedure AddParam(var Q: string; const K, V: string);
   begin
      if V = '' then
         Exit; // não envia vazios
      if Q <> '' then
         Q := Q + '&';
      Q := Q + TNetEncoding.URL.Encode(K) + '=' + TNetEncoding.URL.Encode(V);
   end;

var
   LGTIN: string;
   Q: string;
begin
   LGTIN := GTIN.Trim;
   if LGTIN = '' then
      LGTIN := 'SEM GTIN';
   Q := '';
   AddParam(Q, 'token', C_TOKEN);
   AddParam(Q, 'cnpj', C_CNPJ);
   AddParam(Q, 'codigo', Codigo);
   AddParam(Q, 'uf', UpperCase(UF));
   AddParam(Q, 'ex', C_EX);
   AddParam(Q, 'gtin', LGTIN);
   Result := Q;
end;

class function TIBPTUpdater.ReadNodeFloat(const Root: IXMLNode; const Name, NS: string): Double;
var
   I: Integer;
   N: IXMLNode;
   S: string;
begin
   Result := 0.0;
   if (Root = nil) then
      Exit;

   for I := 0 to Root.ChildNodes.Count - 1 do
   begin
      N := Root.ChildNodes[I];
      if SameText(N.LocalName, Name) then
      begin
         S := Trim(N.Text);
         if S <> '' then
            Result := InvariantToFloat(S);
         Exit;
      end;
   end;
end;

class function TIBPTUpdater.ReadNodeText(const Root: IXMLNode; const Name, NS: string): string;
var
   I: Integer;
   N: IXMLNode;
begin
   Result := '';
   if (Root = nil) then Exit;

   for I := 0 to Root.ChildNodes.Count - 1 do
   begin
      N := Root.ChildNodes[I];
      if SameText(N.LocalName, Name) then
      begin
         Result := Trim(N.Text);
         Exit;
      end;
   end;
end;

function TIBPTUpdater.ExtractErrorBody(const Resp: IHTTPResponse): string;
begin
   Result := '';
   try
      if (Resp <> nil) and (Resp.ContentStream <> nil) then
         Result := Resp.ContentAsString(TEncoding.UTF8);
   except
      Result := '';
   end;
end;

function TIBPTUpdater.FetchProdutoGET(const Codigo, UF, GTIN: string; out Resp: IHTTPResponse): IHTTPResponse;
var
   Query, URL: string;
begin
   Query := BuildQuery(Codigo, UF, GTIN);
   URL := ApiURL + '?' + Query + '&ex=+&descricao=&unidadeMedida=&valor=0';
   Resp := FHTTP.Get(URL);
   Result := Resp;
end;

function TIBPTUpdater.FetchProdutoPOST(const Codigo, UF, GTIN: string; out Resp: IHTTPResponse): IHTTPResponse;
var
   Query: string;
   Content: TStringStream;
   Headers: TNetHeaders;
begin
   Query := BuildQuery(Codigo, UF, GTIN);
   Content := TStringStream.Create(Query, TEncoding.ASCII);
   try
      Headers := [TNameValuePair.Create('Content-Type',
        'application/x-www-form-urlencoded'), TNameValuePair.Create('Accept',
        'application/xml')];
      Resp := FHTTP.Post(ApiURL, Content, nil, Headers);
      Result := Resp;
   finally
      Content.Free;
   end;
end;

function TIBPTUpdater.FetchProduto(const Codigo, UF, GTIN: string; out Produto: TIBPTProduto): Boolean;
var
   Resp: IHTTPResponse;
   Xml: IXMLDocument;
   Root: IXMLNode;
   Body: string;
begin
   Result := False;

   // GET
   try
      Resp := FetchProdutoGET(Codigo, UF, GTIN, Resp);
   except
      on E: ENetHTTPException do raise EIBPTError.Create('Falha HTTPS/TLS ao conectar na API IBPT: ' +E.Message);
      on E: Exception do raise EIBPTError.Create('Erro de rede ao consultar IBPT: ' +E.Message);
   end;

   // Fallback POST se 400
   if (Resp <> nil) and (Resp.StatusCode = 400) and FUsePostIfBadRequest then
      Resp := FetchProdutoPOST(Codigo, UF, GTIN, Resp);

   if (Resp = nil) then raise EIBPTError.Create('Sem resposta da API do IBPT.');

   if Resp.StatusCode <> 200 then
   begin
      Body := ExtractErrorBody(Resp);
      if Body <> '' then
           raise EIBPTError.CreateFmt('%d %s - %s',[Resp.StatusCode, Resp.StatusText, Copy(Body, 1, 300)])
      else raise EIBPTError.CreateFmt('%d %s',[Resp.StatusCode, Resp.StatusText]);
   end;

   Body := Resp.ContentAsString(TEncoding.UTF8);
   if Body.Trim.IsEmpty then raise EIBPTError.Create('Retorno vazio da API do IBPT.');

   Xml := TXMLDocument.Create(nil);
   Xml.Options := [doNodeAutoCreate, doNodeAutoIndent];
   Xml.LoadFromXML(Body);
   Xml.Active := True;

   Root := Xml.DocumentElement; // ProdutoDTO
   if (Root = nil) or not SameText(Root.LocalName, 'ProdutoDTO') then raise EIBPTError.Create('XML inesperado da API do IBPT.');

   FillChar(Produto, SizeOf(Produto), 0);
   Produto.UF := UpperCase(UF);
   Produto.CodNCM  := StrZero(Codigo.Trim, 8);
   Produto.TaxaMun := ReadNodeFloat(Root, 'Municipal', C_NS);
   Produto.TaxaEst := ReadNodeFloat(Root, 'Estadual', C_NS);
   Produto.TaxaFed := ReadNodeFloat(Root, 'Nacional', C_NS);
   Produto.TaxaImp := ReadNodeFloat(Root, 'Importado', C_NS);
   Result := True;
end;

procedure TIBPTUpdater.UpsertProduto(const P: TIBPTProduto);
var
   Q:TFDQuery;
   SQLUpsert:String;
begin
   // Atualiza UltAtu no insert e somente quando houver mudança de alguma taxa no update.
   SQLUpsert :=
   'INSERT INTO arqibpt (UF, CodNCM, TaxaMun, TaxaEst, TaxaFed, TaxaImp, UltAtu) '+
   'VALUES (:UF, :CodNCM, :TaxaMun, :TaxaEst, :TaxaFed, :TaxaImp, CURRENT_TIMESTAMP) '+
   'ON DUPLICATE KEY UPDATE ' + 'TaxaMun = VALUES(TaxaMun), '+
   'TaxaEst = VALUES(TaxaEst), ' + 'TaxaFed = VALUES(TaxaFed), '+
   'TaxaImp = VALUES(TaxaImp), ' + 'UltAtu = IF('+
   '(VALUES(TaxaMun) <> arqibpt.TaxaMun) OR (VALUES(TaxaEst) <> arqibpt.TaxaEst) OR ' +
   '(VALUES(TaxaFed) <> arqibpt.TaxaFed) OR (VALUES(TaxaImp) <> arqibpt.TaxaImp), CURRENT_TIMESTAMP, arqibpt.UltAtu)';

   Q := TFDQuery.Create(nil);
   try
      Q.Connection := FConn;
      Q.SQL.Text := SQLUpsert;
      Q.Params.ParamByName('UF').AsString := P.UF;
      Q.Params.ParamByName('CodNCM').AsString := P.CodNCM;
      Q.Params.ParamByName('TaxaMun').AsFloat := P.TaxaMun;
      Q.Params.ParamByName('TaxaEst').AsFloat := P.TaxaEst;
      Q.Params.ParamByName('TaxaFed').AsFloat := P.TaxaFed;
      Q.Params.ParamByName('TaxaImp').AsFloat := P.TaxaImp;
      if not FConn.InTransaction then FConn.StartTransaction;
      try
         Q.ExecSQL;
         FConn.Commit;
      except
         on E: Exception do
         begin
            if FConn.InTransaction then FConn.Rollback;
            raise EIBPTError.Create('Falha ao gravar em arqibpt: ' + E.Message);
         end;
      end;
   finally
      Q.Free;
   end;
end;

class procedure TIBPTUpdater.SafeSleep(Milliseconds: Cardinal);
var
   Target: UInt64;
begin
   Target := TThread.GetTickCount64 + Milliseconds;
   while TThread.GetTickCount64 < Target do Sleep(Min(50, Integer(Target - TThread.GetTickCount64))); // evita travar UI
end;

function TIBPTUpdater.ShouldRetryHTTP(StatusCode: Integer): Boolean;
begin
   Result := (StatusCode = 429) or (StatusCode >= 500);
end;

function TIBPTUpdater.RetryBackoffMs(Attempt, BaseDelayMs,
  MaxDelayMs: Integer): Integer;
var
   Expo: Int64;
   Jitter: Integer;
begin
   Expo := BaseDelayMs * Int64(1 shl Attempt);
   if Expo > MaxDelayMs then Expo := MaxDelayMs;
   Jitter := Random(BaseDelayMs + 1); // espalha carga
   Result := Min(MaxDelayMs, Integer(Expo) + Jitter);
end;

procedure TIBPTUpdater.Throttle(const MinIntervalMs: Integer);
var
   NowTick: Int64;
   Elapsed: Int64;
begin
   if MinIntervalMs <= 0 then Exit;

   NowTick := TThread.GetTickCount64;
   if FLastRequestTick <> 0 then
   begin
      Elapsed := NowTick - FLastRequestTick;
      if Elapsed < MinIntervalMs then SafeSleep(MinIntervalMs - Elapsed);
   end;
   FLastRequestTick := TThread.GetTickCount64;
end;

function TIBPTUpdater.UpdateIBPT(const ACodigo, AUF: string; const AGTIN: string): Boolean;
var
   P: TIBPTProduto;
begin
   Result := False;
   if FetchProduto(ACodigo, AUF, AGTIN, P) then
   begin
      UpsertProduto(P);
      Result := True;
   end;
end;

function TIBPTUpdater.FetchIBPT(const ACodigo, AUF, AGTIN: string): TIBPTProduto;
var
   Ok: Boolean;
begin
   Ok := FetchProduto(ACodigo, AUF, AGTIN, Result);
   if not Ok then raise EIBPTError.Create('Não foi possível obter dados do IBPT.');
end;

function TIBPTUpdater.UpdateIBPTBatch(const AUF: string;
  const ACodigos: array of String; const OnProgress: TIBPTProgress;
  const AGTIN: string; const MaxRetries, BaseDelayMs, MaxDelayMs,
  MinIntervalMs: Integer): TIBPTBatchResult;
var
   Total, I, Attempt: Integer;
   Codigo: string;
   Updated: Integer;
   FailList: TList<string>;
   Resp: IHTTPResponse;
   Body: string;
   Produto: TIBPTProduto;
   Ok: Boolean;
begin
   Updated := 0;
   Total := Length(ACodigos);
   FailList := TList<string>.Create;
   try
      for I := 0 to Total - 1 do
      begin
         Codigo := Trim(ACodigos[I]);
         if Codigo = '' then
         begin
            FailList.Add('(vazio)');
            if Assigned(OnProgress) then OnProgress(I + 1, Total, Codigo, 'Ignorado: código vazio');
            Continue;
         end;

         Attempt := 0;
         Ok := False;

         while Attempt <= MaxRetries do
         begin
            Throttle(MinIntervalMs);
            // GET
            try
               Resp := FetchProdutoGET(Codigo, AUF, AGTIN, Resp);
            except
               on E: ENetHTTPException do
               begin
                  Inc(Attempt);
                  if Attempt > MaxRetries then
                  begin
                     FailList.Add(Codigo);
                     if Assigned(OnProgress) then OnProgress(I + 1, Total, Codigo,'Rede/TLS: ' + E.Message);
                     Break;
                  end;
                  SafeSleep(RetryBackoffMs(Attempt, BaseDelayMs, MaxDelayMs));
                  Continue;
               end;
               on E: Exception do
               begin
                  Inc(Attempt);
                  if Attempt > MaxRetries then
                  begin
                     FailList.Add(Codigo);
                     if Assigned(OnProgress) then OnProgress(I + 1, Total, Codigo,'Erro de rede: ' + E.Message);
                     Break;
                  end;
                  SafeSleep(RetryBackoffMs(Attempt, BaseDelayMs, MaxDelayMs));
                  Continue;
               end;
            end;

            // Fallback POST em 400
            if (Resp <> nil) and (Resp.StatusCode = 400) and FUsePostIfBadRequest
            then
               Resp := FetchProdutoPOST(Codigo, AUF, AGTIN, Resp);

            if (Resp = nil) then
            begin
               Inc(Attempt);
               if Attempt > MaxRetries then
               begin
                  FailList.Add(Codigo);
                  if Assigned(OnProgress) then
                     OnProgress(I + 1, Total, Codigo, 'Sem resposta');
                  Break;
               end;
               SafeSleep(RetryBackoffMs(Attempt, BaseDelayMs, MaxDelayMs));
               Continue;
            end;

            if Resp.StatusCode <> 200 then
            begin
               Body := ExtractErrorBody(Resp);
               if ShouldRetryHTTP(Resp.StatusCode) and (Attempt < MaxRetries)
               then
               begin
                  Inc(Attempt);
                  SafeSleep(RetryBackoffMs(Attempt, BaseDelayMs, MaxDelayMs));
                  Continue;
               end else
               begin
                  FailList.Add(Codigo);
                  if Assigned(OnProgress) then OnProgress(I + 1, Total, Codigo,Format('HTTP %d: %s%s', [Resp.StatusCode,
                     Resp.StatusText, IfThen(Body <> '', ' - ' + Copy(Body, 1,200), '')]));
                  Break;
               end;
            end;

            // Parse + grava
            try
               if FetchProduto(Codigo, AUF, AGTIN, Produto) then
               begin
                  UpsertProduto(Produto);
                  Inc(Updated);
                  Ok := True;
                  if Assigned(OnProgress) then
                     OnProgress(I + 1, Total, Codigo, 'OK');
               end else
               begin
                  FailList.Add(Codigo);
                  if Assigned(OnProgress) then
                     OnProgress(I + 1, Total, Codigo, 'Falha ao processar');
               end;
            except
               on E: Exception do
               begin
                  FailList.Add(Codigo);
                  if Assigned(OnProgress) then
                     OnProgress(I + 1, Total, Codigo,
                       'Erro ao gravar: ' + E.Message);
               end;
            end;
            Break;
         end;
      end;
      Result.UpdatedCount := Updated;
      Result.Failed := FailList.ToArray;
   finally
      FailList.Free;
   end;
end;

function TIBPTUpdater.UpdateIBPTBatchStrings(const AUF: string;
  const ACodigos: TStrings; const OnProgress: TIBPTProgress;
  const AGTIN: string; const MaxRetries, BaseDelayMs, MaxDelayMs,
  MinIntervalMs: Integer): TIBPTBatchResult;
var
   Arr: TArray<string>;
   I: Integer;
begin
   SetLength(Arr, ACodigos.Count);
   for I := 0 to ACodigos.Count - 1 do Arr[I] := ACodigos[I];
   Result := UpdateIBPTBatch(AUF, Arr, OnProgress, AGTIN, MaxRetries, BaseDelayMs, MaxDelayMs, MinIntervalMs);
end;

function TIBPTUpdater.GetVigenciaFim(const ACodigo, AUF: string; const AGTIN: string): string;
var
   Resp: IHTTPResponse;
   Body: string;
   Xml: IXMLDocument;
   Root: IXMLNode;
begin
   // GET
   try
      Resp := FetchProdutoGET(ACodigo, AUF, AGTIN, Resp);
   except
      on E: ENetHTTPException do raise EIBPTError.Create('Falha HTTPS/TLS ao conectar na API IBPT: ' +E.Message);
      on E: Exception do raise EIBPTError.Create('Erro de rede ao consultar IBPT: ' +E.Message);
   end;

   // Fallback POST em 400
   if (Resp <> nil) and (Resp.StatusCode = 400) and FUsePostIfBadRequest then
      Resp := FetchProdutoPOST(ACodigo, AUF, AGTIN, Resp);

   if (Resp = nil) then raise EIBPTError.Create('Sem resposta da API do IBPT.');

   if Resp.StatusCode <> 200 then
      raise EIBPTError.CreateFmt('%d %s%s', [Resp.StatusCode, Resp.StatusText,
        IfThen(Resp.ContentStream <> nil, ' - ' + Copy(Resp.ContentAsString(TEncoding.UTF8), 1, 200), '')]);

   Body := Resp.ContentAsString(TEncoding.UTF8);
   if Body.Trim.IsEmpty then raise EIBPTError.Create('Retorno vazio da API do IBPT.');

   Xml := TXMLDocument.Create(nil);
   Xml.Options := [doNodeAutoCreate, doNodeAutoIndent];
   Xml.LoadFromXML(Body);
   Xml.Active := True;

   Root := Xml.DocumentElement; // ProdutoDTO
   if (Root = nil) or not SameText(Root.LocalName, 'ProdutoDTO') then
      raise EIBPTError.Create('XML inesperado da API do IBPT.');
   Result := ReadNodeText(Root, 'VigenciaFim', C_NS);
end;

end.
