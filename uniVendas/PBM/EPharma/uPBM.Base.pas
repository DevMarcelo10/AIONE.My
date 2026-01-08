unit uPBM.Base;

interface

uses
   System.SysUtils, System.Classes, System.JSON, System.SyncObjs,
   System.Net.HttpClient, System.DateUtils, System.Generics.Collections,
   uPBM.Interfaces;

type
   /// <summary>Implementação base de resultado PBM</summary>
   TPBMResultadoBase = class(TInterfacedObject, IPBMResultado)
   protected
      FSucesso: Boolean;
      FMensagem: string;
      FCodigo: string;
      FStatus: TPBMStatus;
      FRawJSON: string;
   public
      function GetSucesso: Boolean;
      function GetMensagem: string;
      function GetCodigo: string;
      function GetStatus: TPBMStatus;
      function GetRawJSON: string;
      procedure ParseJSON(AJSON: TJSONObject); virtual; abstract;
      class function FromJSON(const AJSON: string): IPBMResultado; virtual;
   end;

   /// <summary>Implementação de configuração PBM</summary>
   TPBMConfig = class(TInterfacedObject, IPBMConfig)
   private
      FClientID: string;
      FClientSecret: string;
      FHomologacao: Boolean;
      FTimeout: Integer;
      FMaxRetries: Integer;
   public
      constructor Create;
      function GetClientID: string;
      function GetClientSecret: string;
      function GetHomologacao: Boolean;
      function GetTimeout: Integer;
      function GetMaxRetries: Integer;
      procedure SetClientID(const Value: string);
      procedure SetClientSecret(const Value: string);
      procedure SetHomologacao(Value: Boolean);
      procedure SetTimeout(Value: Integer);
      procedure SetMaxRetries(Value: Integer);
   end;

   /// <summary>Gerenciador de token com cache thread-safe</summary>
   TTokenManager = class
   private
      FToken: string;
      FExpiracao: TDateTime;
      FLock: TCriticalSection;
      FOnObterToken: TFunc<string>;
      FTempoVida: Integer; // segundos
   public
      constructor Create(ATempoVida: Integer = 3500); // ~1h com margem
      destructor Destroy; override;
      function GetToken: string;
      procedure Invalidar;
      property OnObterToken: TFunc<string> read FOnObterToken write FOnObterToken;
   end;

   /// <summary>Cliente HTTP com retry e backoff exponencial</summary>
   THTTPClientEx = class
   private
      FClient: THTTPClient;
      FMaxRetries: Integer;
      FBaseDelay: Integer;
      FTimeout: Integer;
      FOnLog: TPBMLogEvent;
      procedure Log(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create;
      destructor Destroy; override;
      function Get(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
      function Post(const AURL, ABody: string; const AHeaders: TArray<TPair<string,string>>): string;
      function Delete(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
      property MaxRetries: Integer read FMaxRetries write FMaxRetries;
      property BaseDelay: Integer read FBaseDelay write FBaseDelay;
      property Timeout: Integer read FTimeout write FTimeout;
      property OnLog: TPBMLogEvent read FOnLog write FOnLog;
   end;

   /// <summary>Cliente base abstrato para PBMs</summary>
   TPBMClientBase = class abstract(TInterfacedObject, IPBMClient)
   protected
      FConfig: IPBMConfig;
      FTokenManager: TTokenManager;
      FHTTPClient: THTTPClientEx;
      FUltimoErro: string;
      FOnLog: TPBMLogEvent;
      procedure Log(const AMsg: string; const ATipo: string = 'INFO');
      function GetBaseURL: string; virtual; abstract;
      function ObterTokenInterno: string; virtual; abstract;
      function GetAuthHeaders: TArray<TPair<string,string>>; virtual;
   public
      constructor Create(const AClientID, AClientSecret: string; AHomologacao: Boolean);
      destructor Destroy; override;
      
      // IPBMClient
      function GetConfig: IPBMConfig;
      function GetConectado: Boolean; virtual;
      function GetUltimoErro: string;
      procedure SetOnLog(Value: TPBMLogEvent);
      
      function Ping: Boolean; virtual; abstract;
      function ConsultarBeneficiario(const ACarteirinha: string; const ACPF: string = ''): IPBMBeneficiario; virtual; abstract;
      function AutorizarVenda(const ACarteirinha, ACPF: string; ADataNasc: TDateTime;
         const AProdutos: TPBMProdutos; AValorTotal: Currency; const ATransacao: string): IPBMAutorizacao; virtual; abstract;
      function CancelarVenda(const ANSU, ATransacao, AMotivo: string): IPBMCancelamento; virtual; abstract;
   end;

implementation

{ TPBMResultadoBase }

function TPBMResultadoBase.GetSucesso: Boolean;
begin
   Result := FSucesso;
end;

function TPBMResultadoBase.GetMensagem: string;
begin
   Result := FMensagem;
end;

function TPBMResultadoBase.GetCodigo: string;
begin
   Result := FCodigo;
end;

function TPBMResultadoBase.GetStatus: TPBMStatus;
begin
   Result := FStatus;
end;

function TPBMResultadoBase.GetRawJSON: string;
begin
   Result := FRawJSON;
end;

class function TPBMResultadoBase.FromJSON(const AJSON: string): IPBMResultado;
begin
   Result := nil; // Override nas classes filhas
end;

{ TPBMConfig }

constructor TPBMConfig.Create;
begin
   inherited;
   FHomologacao := True;
   FTimeout := 30000;
   FMaxRetries := 3;
end;

function TPBMConfig.GetClientID: string;
begin
   Result := FClientID;
end;

function TPBMConfig.GetClientSecret: string;
begin
   Result := FClientSecret;
end;

function TPBMConfig.GetHomologacao: Boolean;
begin
   Result := FHomologacao;
end;

function TPBMConfig.GetTimeout: Integer;
begin
   Result := FTimeout;
end;

function TPBMConfig.GetMaxRetries: Integer;
begin
   Result := FMaxRetries;
end;

procedure TPBMConfig.SetClientID(const Value: string);
begin
   FClientID := Value;
end;

procedure TPBMConfig.SetClientSecret(const Value: string);
begin
   FClientSecret := Value;
end;

procedure TPBMConfig.SetHomologacao(Value: Boolean);
begin
   FHomologacao := Value;
end;

procedure TPBMConfig.SetTimeout(Value: Integer);
begin
   FTimeout := Value;
end;

procedure TPBMConfig.SetMaxRetries(Value: Integer);
begin
   FMaxRetries := Value;
end;

{ TTokenManager }

constructor TTokenManager.Create(ATempoVida: Integer);
begin
   inherited Create;
   FLock := TCriticalSection.Create;
   FTempoVida := ATempoVida;
   FExpiracao := 0;
end;

destructor TTokenManager.Destroy;
begin
   FLock.Free;
   inherited;
end;

function TTokenManager.GetToken: string;
begin
   FLock.Enter;
   try
      // Token expirado ou inexistente?
      if (FToken = '') or (Now > FExpiracao) then
      begin
         if Assigned(FOnObterToken) then
         begin
            FToken := FOnObterToken();
            FExpiracao := IncSecond(Now, FTempoVida);
         end;
      end;
      Result := FToken;
   finally
      FLock.Leave;
   end;
end;

procedure TTokenManager.Invalidar;
begin
   FLock.Enter;
   try
      FToken := '';
      FExpiracao := 0;
   finally
      FLock.Leave;
   end;
end;

{ THTTPClientEx }

constructor THTTPClientEx.Create;
begin
   inherited;
   FClient := THTTPClient.Create;
   FMaxRetries := 3;
   FBaseDelay := 500; // ms
   FTimeout := 30000;
end;

destructor THTTPClientEx.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure THTTPClientEx.Log(const AMsg: string; const ATipo: string);
begin
   if Assigned(FOnLog) then
      FOnLog(AMsg, ATipo);
end;

function THTTPClientEx.Get(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
var
   LResponse: IHTTPResponse;
   LRetry, LDelay: Integer;
   LHeader: TPair<string,string>;
begin
   Result := '';
   LDelay := FBaseDelay;
   
   for LRetry := 0 to FMaxRetries - 1 do
   begin
      try
         FClient.ConnectionTimeout := FTimeout;
         FClient.ResponseTimeout := FTimeout;
         
         for LHeader in AHeaders do
            FClient.CustomHeaders[LHeader.Key] := LHeader.Value;
         
         LResponse := FClient.Get(AURL);
         
         if LResponse.StatusCode in [200..299] then
         begin
            Result := LResponse.ContentAsString;
            Exit;
         end
         else if LResponse.StatusCode >= 500 then
         begin
            Log(Format('HTTP %d - Retry %d/%d', [LResponse.StatusCode, LRetry + 1, FMaxRetries]), 'WARN');
            Sleep(LDelay);
            LDelay := LDelay * 2; // Backoff exponencial
         end
         else
         begin
            Result := LResponse.ContentAsString;
            Exit; // Erro do cliente, não faz retry
         end;
      except
         on E: Exception do
         begin
            Log(Format('Erro: %s - Retry %d/%d', [E.Message, LRetry + 1, FMaxRetries]), 'ERROR');
            if LRetry = FMaxRetries - 1 then
               raise;
            Sleep(LDelay);
            LDelay := LDelay * 2;
         end;
      end;
   end;
end;

function THTTPClientEx.Post(const AURL, ABody: string; const AHeaders: TArray<TPair<string,string>>): string;
var
   LResponse: IHTTPResponse;
   LRetry, LDelay: Integer;
   LHeader: TPair<string,string>;
   LContent: TStringStream;
begin
   Result := '';
   LDelay := FBaseDelay;
   
   for LRetry := 0 to FMaxRetries - 1 do
   begin
      LContent := TStringStream.Create(ABody, TEncoding.UTF8);
      try
         FClient.ConnectionTimeout := FTimeout;
         FClient.ResponseTimeout := FTimeout;
         
         for LHeader in AHeaders do
            FClient.CustomHeaders[LHeader.Key] := LHeader.Value;
         
         LResponse := FClient.Post(AURL, LContent);
         
         if LResponse.StatusCode in [200..299] then
         begin
            Result := LResponse.ContentAsString;
            Exit;
         end
         else if LResponse.StatusCode >= 500 then
         begin
            Log(Format('HTTP %d - Retry %d/%d', [LResponse.StatusCode, LRetry + 1, FMaxRetries]), 'WARN');
            Sleep(LDelay);
            LDelay := LDelay * 2;
         end
         else
         begin
            Result := LResponse.ContentAsString;
            Exit;
         end;
      finally
         LContent.Free;
      end;
   end;
end;

function THTTPClientEx.Delete(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
var
   LResponse: IHTTPResponse;
   LHeader: TPair<string,string>;
begin
   FClient.ConnectionTimeout := FTimeout;
   FClient.ResponseTimeout := FTimeout;
   
   for LHeader in AHeaders do
      FClient.CustomHeaders[LHeader.Key] := LHeader.Value;
   
   LResponse := FClient.Delete(AURL);
   Result := LResponse.ContentAsString;
end;

{ TPBMClientBase }

constructor TPBMClientBase.Create(const AClientID, AClientSecret: string; AHomologacao: Boolean);
begin
   inherited Create;
   FConfig := TPBMConfig.Create;
   FConfig.ClientID := AClientID;
   FConfig.ClientSecret := AClientSecret;
   FConfig.Homologacao := AHomologacao;
   
   FHTTPClient := THTTPClientEx.Create;
   FTokenManager := TTokenManager.Create;
   FTokenManager.OnObterToken := ObterTokenInterno;
end;

destructor TPBMClientBase.Destroy;
begin
   FTokenManager.Free;
   FHTTPClient.Free;
   inherited;
end;

procedure TPBMClientBase.Log(const AMsg: string; const ATipo: string);
begin
   if Assigned(FOnLog) then
      FOnLog(AMsg, ATipo);
end;

function TPBMClientBase.GetConfig: IPBMConfig;
begin
   Result := FConfig;
end;

function TPBMClientBase.GetConectado: Boolean;
begin
   Result := FTokenManager.GetToken <> '';
end;

function TPBMClientBase.GetUltimoErro: string;
begin
   Result := FUltimoErro;
end;

procedure TPBMClientBase.SetOnLog(Value: TPBMLogEvent);
begin
   FOnLog := Value;
   FHTTPClient.OnLog := Value;
end;

function TPBMClientBase.GetAuthHeaders: TArray<TPair<string,string>>;
begin
   Result := [
      TPair<string,string>.Create('Authorization', 'Bearer ' + FTokenManager.GetToken),
      TPair<string,string>.Create('Content-Type', 'application/json'),
      TPair<string,string>.Create('Accept', 'application/json')
   ];
end;

end.
