unit uPBM.Base;

{******************************************************************************
  PBM Base - Classes base para implementação dos PBMs
  
  Contém:
  - TPBMResultadoBase: Implementação base de IPBMResultado
  - TPBMConfigBase: Implementação base de IPBMConfig  
  - TTokenManager: Gerenciador de token com cache thread-safe
  - THTTPClientEx: Cliente HTTP com retry e backoff exponencial
  - TPBMClientBase: Cliente base abstrato para PBMs
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

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
    FCodigoErro: string;
    FCodigoHTTP: Integer;
    FStatus: TPBMStatus;
    FRawJSON: string;
  public
    constructor Create;
    
    // IPBMResultado
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetCodigoHTTP: Integer;
    
    // Extras
    function GetStatus: TPBMStatus;
    function GetRawJSON: string;
    procedure ParseJSON(AJSON: TJSONObject); virtual;
    class function FromJSON(const AJSON: string): IPBMResultado; virtual;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
    property CodigoHTTP: Integer read FCodigoHTTP write FCodigoHTTP;
    property Status: TPBMStatus read FStatus write FStatus;
    property RawJSON: string read FRawJSON write FRawJSON;
  end;

  /// <summary>Implementação de configuração PBM</summary>
  TPBMConfigBase = class(TInterfacedObject, IPBMConfig)
  private
    FHomologacao: Boolean;
    FBaseURL: string;
    FClientID: string;
    FClientSecret: string;
    FCodEstabelecimento: string;
    FUsuario: string;
    FSenha: string;
    FAPIKey: string;
    FTimeout: Integer;
    FRetryCount: Integer;
    FRetryDelay: Integer;
    FOnLog: TPBMLogEvent;
    FOnStatus: TPBMStatusEvent;
  public
    constructor Create;
    
    // IPBMConfig - Ambiente
    function GetHomologacao: Boolean;
    procedure SetHomologacao(AValue: Boolean);
    function GetBaseURL: string;
    procedure SetBaseURL(const AValue: string);
    
    // IPBMConfig - Credenciais
    function GetClientID: string;
    procedure SetClientID(const AValue: string);
    function GetClientSecret: string;
    procedure SetClientSecret(const AValue: string);
    function GetCodEstabelecimento: string;
    procedure SetCodEstabelecimento(const AValue: string);
    function GetUsuario: string;
    procedure SetUsuario(const AValue: string);
    function GetSenha: string;
    procedure SetSenha(const AValue: string);
    function GetAPIKey: string;
    procedure SetAPIKey(const AValue: string);
    
    // IPBMConfig - Timeouts
    function GetTimeout: Integer;
    procedure SetTimeout(AValue: Integer);
    function GetRetryCount: Integer;
    procedure SetRetryCount(AValue: Integer);
    function GetRetryDelay: Integer;
    procedure SetRetryDelay(AValue: Integer);
    
    // IPBMConfig - Eventos
    function GetOnLog: TPBMLogEvent;
    procedure SetOnLog(AValue: TPBMLogEvent);
    function GetOnStatus: TPBMStatusEvent;
    procedure SetOnStatus(AValue: TPBMStatusEvent);
    
    // Helpers
    procedure DoLog(ATipo: TPBMLogTipo; const AMensagem: string; const ADetalhes: string = '');
    procedure DoStatus(AStatus: TPBMStatus; const AMensagem: string);
    
    // Properties
    property Homologacao: Boolean read FHomologacao write FHomologacao;
    property BaseURL: string read FBaseURL write FBaseURL;
    property ClientID: string read FClientID write FClientID;
    property ClientSecret: string read FClientSecret write FClientSecret;
    property CodEstabelecimento: string read FCodEstabelecimento write FCodEstabelecimento;
    property Usuario: string read FUsuario write FUsuario;
    property Senha: string read FSenha write FSenha;
    property APIKey: string read FAPIKey write FAPIKey;
    property Timeout: Integer read FTimeout write FTimeout;
    property RetryCount: Integer read FRetryCount write FRetryCount;
    property RetryDelay: Integer read FRetryDelay write FRetryDelay;
    property OnLog: TPBMLogEvent read FOnLog write FOnLog;
    property OnStatus: TPBMStatusEvent read FOnStatus write FOnStatus;
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
    function IsValid: Boolean;
    procedure Invalidar;
    procedure SetToken(const AToken: string; ATempoVida: Integer = 0);
    property OnObterToken: TFunc<string> read FOnObterToken write FOnObterToken;
    property TempoVida: Integer read FTempoVida write FTempoVida;
  end;

  /// <summary>Cliente HTTP com retry e backoff exponencial</summary>
  THTTPClientEx = class
  private
    FClient: THTTPClient;
    FMaxRetries: Integer;
    FBaseDelay: Integer;
    FTimeout: Integer;
    FOnLog: TPBMLogEvent;
    FLastStatusCode: Integer;
    FLastResponse: string;
    procedure DoLog(ATipo: TPBMLogTipo; const AMsg: string; const ADetalhes: string = '');
  public
    constructor Create;
    destructor Destroy; override;
    function Get(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
    function Post(const AURL, ABody: string; const AHeaders: TArray<TPair<string,string>>): string;
    function Put(const AURL, ABody: string; const AHeaders: TArray<TPair<string,string>>): string;
    function Delete(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
    
    property MaxRetries: Integer read FMaxRetries write FMaxRetries;
    property BaseDelay: Integer read FBaseDelay write FBaseDelay;
    property Timeout: Integer read FTimeout write FTimeout;
    property OnLog: TPBMLogEvent read FOnLog write FOnLog;
    property LastStatusCode: Integer read FLastStatusCode;
    property LastResponse: string read FLastResponse;
  end;

  /// <summary>Cliente base abstrato para PBMs</summary>
  TPBMClientBase = class abstract(TInterfacedObject, IPBMClient)
  protected
    FConfig: TPBMConfigBase;
    FTokenManager: TTokenManager;
    FHTTPClient: THTTPClientEx;
    FUltimoErro: string;
    FHomologacao: Boolean;
    FNomeOperadora: string;
    FCodigoOperadora: string;
    
    procedure DoLog(ATipo: TPBMLogTipo; const AMsg: string; const ADetalhes: string = '');
    function GetBaseURL: string; virtual; abstract;
    function ObterTokenInterno: string; virtual; abstract;
    function GetAuthHeaders: TArray<TPair<string,string>>; virtual;
  public
    constructor Create(const AClientID, AClientSecret, ACodEstabelecimento: string; 
      AHomologacao: Boolean);
    destructor Destroy; override;
    
    // IPBMClient - Configuração
    procedure SetAmbiente(AHomologacao: Boolean);
    function GetAmbiente: Boolean;
    function GetNomeOperadora: string;
    function GetCodigoOperadora: string;
    
    // IPBMClient - Operações (devem ser implementadas nas classes filhas)
    function ConsultarElegibilidade(const ACarteirinha, ACPF: string;
      ADataNascimento: TDate): IPBMElegibilidade; overload; virtual; abstract;
    function ConsultarElegibilidade(const ACarteirinha, ACPF: string;
      ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade; overload; virtual; abstract;
    function AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate;
      const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency;
      const ATransacaoID: string): IPBMAutorizacao; overload; virtual; abstract;
    function AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate;
      const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency;
      const ATransacaoID: string; const AReceita: TPBMReceita): IPBMAutorizacao; overload; virtual; abstract;
    function CancelarVenda(const ANSU, ACodigoAutorizacao, AMotivo: string): IPBMCancelamento; virtual; abstract;
    function ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao; virtual; abstract;
    
    // Extras
    function GetConfig: TPBMConfigBase;
    function GetConectado: Boolean; virtual;
    function GetUltimoErro: string;
    function Ping: Boolean; virtual;
    
    property Config: TPBMConfigBase read FConfig;
    property Homologacao: Boolean read FHomologacao write SetAmbiente;
    property NomeOperadora: string read FNomeOperadora;
    property CodigoOperadora: string read FCodigoOperadora;
  end;

implementation

{ TPBMResultadoBase }

constructor TPBMResultadoBase.Create;
begin
  inherited Create;
  FSucesso := False;
  FCodigoHTTP := 0;
  FStatus := psNenhum;
end;

function TPBMResultadoBase.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMResultadoBase.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMResultadoBase.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

function TPBMResultadoBase.GetCodigoHTTP: Integer;
begin
  Result := FCodigoHTTP;
end;

function TPBMResultadoBase.GetStatus: TPBMStatus;
begin
  Result := FStatus;
end;

function TPBMResultadoBase.GetRawJSON: string;
begin
  Result := FRawJSON;
end;

procedure TPBMResultadoBase.ParseJSON(AJSON: TJSONObject);
begin
  // Override nas classes filhas
end;

class function TPBMResultadoBase.FromJSON(const AJSON: string): IPBMResultado;
begin
  Result := nil; // Override nas classes filhas
end;

{ TPBMConfigBase }

constructor TPBMConfigBase.Create;
begin
  inherited Create;
  FHomologacao := True;
  FTimeout := 30000; // 30 segundos
  FRetryCount := 3;
  FRetryDelay := 500; // 500ms
end;

function TPBMConfigBase.GetHomologacao: Boolean;
begin
  Result := FHomologacao;
end;

procedure TPBMConfigBase.SetHomologacao(AValue: Boolean);
begin
  FHomologacao := AValue;
end;

function TPBMConfigBase.GetBaseURL: string;
begin
  Result := FBaseURL;
end;

procedure TPBMConfigBase.SetBaseURL(const AValue: string);
begin
  FBaseURL := AValue;
end;

function TPBMConfigBase.GetClientID: string;
begin
  Result := FClientID;
end;

procedure TPBMConfigBase.SetClientID(const AValue: string);
begin
  FClientID := AValue;
end;

function TPBMConfigBase.GetClientSecret: string;
begin
  Result := FClientSecret;
end;

procedure TPBMConfigBase.SetClientSecret(const AValue: string);
begin
  FClientSecret := AValue;
end;

function TPBMConfigBase.GetCodEstabelecimento: string;
begin
  Result := FCodEstabelecimento;
end;

procedure TPBMConfigBase.SetCodEstabelecimento(const AValue: string);
begin
  FCodEstabelecimento := AValue;
end;

function TPBMConfigBase.GetUsuario: string;
begin
  Result := FUsuario;
end;

procedure TPBMConfigBase.SetUsuario(const AValue: string);
begin
  FUsuario := AValue;
end;

function TPBMConfigBase.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TPBMConfigBase.SetSenha(const AValue: string);
begin
  FSenha := AValue;
end;

function TPBMConfigBase.GetAPIKey: string;
begin
  Result := FAPIKey;
end;

procedure TPBMConfigBase.SetAPIKey(const AValue: string);
begin
  FAPIKey := AValue;
end;

function TPBMConfigBase.GetTimeout: Integer;
begin
  Result := FTimeout;
end;

procedure TPBMConfigBase.SetTimeout(AValue: Integer);
begin
  FTimeout := AValue;
end;

function TPBMConfigBase.GetRetryCount: Integer;
begin
  Result := FRetryCount;
end;

procedure TPBMConfigBase.SetRetryCount(AValue: Integer);
begin
  FRetryCount := AValue;
end;

function TPBMConfigBase.GetRetryDelay: Integer;
begin
  Result := FRetryDelay;
end;

procedure TPBMConfigBase.SetRetryDelay(AValue: Integer);
begin
  FRetryDelay := AValue;
end;

function TPBMConfigBase.GetOnLog: TPBMLogEvent;
begin
  Result := FOnLog;
end;

procedure TPBMConfigBase.SetOnLog(AValue: TPBMLogEvent);
begin
  FOnLog := AValue;
end;

function TPBMConfigBase.GetOnStatus: TPBMStatusEvent;
begin
  Result := FOnStatus;
end;

procedure TPBMConfigBase.SetOnStatus(AValue: TPBMStatusEvent);
begin
  FOnStatus := AValue;
end;

procedure TPBMConfigBase.DoLog(ATipo: TPBMLogTipo; const AMensagem, ADetalhes: string);
begin
  if Assigned(FOnLog) then
    FOnLog(Self, ATipo, AMensagem, ADetalhes);
end;

procedure TPBMConfigBase.DoStatus(AStatus: TPBMStatus; const AMensagem: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Self, AStatus, AMensagem);
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

function TTokenManager.IsValid: Boolean;
begin
  FLock.Enter;
  try
    Result := (FToken <> '') and (Now < FExpiracao);
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

procedure TTokenManager.SetToken(const AToken: string; ATempoVida: Integer);
begin
  FLock.Enter;
  try
    FToken := AToken;
    if ATempoVida > 0 then
      FExpiracao := IncSecond(Now, ATempoVida)
    else
      FExpiracao := IncSecond(Now, FTempoVida);
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
  FLastStatusCode := 0;
end;

destructor THTTPClientEx.Destroy;
begin
  FClient.Free;
  inherited;
end;

procedure THTTPClientEx.DoLog(ATipo: TPBMLogTipo; const AMsg, ADetalhes: string);
begin
  if Assigned(FOnLog) then
    FOnLog(Self, ATipo, AMsg, ADetalhes);
end;

function THTTPClientEx.Get(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
var
  LResponse: IHTTPResponse;
  LRetry, LDelay: Integer;
  LHeader: TPair<string,string>;
begin
  Result := '';
  LDelay := FBaseDelay;
  FLastStatusCode := 0;
  FLastResponse := '';
  
  for LRetry := 0 to FMaxRetries - 1 do
  begin
    try
      FClient.ConnectionTimeout := FTimeout;
      FClient.ResponseTimeout := FTimeout;
      
      // Limpa headers anteriores
      FClient.CustomHeaders['Authorization'] := '';
      FClient.CustomHeaders['Content-Type'] := '';
      
      for LHeader in AHeaders do
        FClient.CustomHeaders[LHeader.Key] := LHeader.Value;
      
      DoLog(ltRequest, 'GET ' + AURL, '');
      LResponse := FClient.Get(AURL);
      FLastStatusCode := LResponse.StatusCode;
      FLastResponse := LResponse.ContentAsString;
      
      if (LResponse.StatusCode >= 200) and (LResponse.StatusCode <= 299) then
      begin
        Result := FLastResponse;
        DoLog(ltResponse, Format('HTTP %d', [LResponse.StatusCode]), Result);
        Exit;
      end
      else if LResponse.StatusCode >= 500 then
      begin
        DoLog(ltWarning, Format('HTTP %d - Retry %d/%d', [LResponse.StatusCode, LRetry + 1, FMaxRetries]), FLastResponse);
        Sleep(LDelay);
        LDelay := LDelay * 2; // Backoff exponencial
      end
      else
      begin
        Result := FLastResponse;
        DoLog(ltError, Format('HTTP %d', [LResponse.StatusCode]), Result);
        Exit; // Erro do cliente, não faz retry
      end;
    except
      on E: Exception do
      begin
        DoLog(ltError, Format('Erro: %s - Retry %d/%d', [E.Message, LRetry + 1, FMaxRetries]), '');
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
  FLastStatusCode := 0;
  FLastResponse := '';
  
  for LRetry := 0 to FMaxRetries - 1 do
  begin
    LContent := TStringStream.Create(ABody, TEncoding.UTF8);
    try
      FClient.ConnectionTimeout := FTimeout;
      FClient.ResponseTimeout := FTimeout;
      
      // Limpa headers anteriores
      FClient.CustomHeaders['Authorization'] := '';
      FClient.CustomHeaders['Content-Type'] := '';
      
      for LHeader in AHeaders do
        FClient.CustomHeaders[LHeader.Key] := LHeader.Value;
      
      DoLog(ltRequest, 'POST ' + AURL, ABody);
      LResponse := FClient.Post(AURL, LContent);
      FLastStatusCode := LResponse.StatusCode;
      FLastResponse := LResponse.ContentAsString;
      
      if (LResponse.StatusCode >= 200) and (LResponse.StatusCode <= 299) then
      begin
        Result := FLastResponse;
        DoLog(ltResponse, Format('HTTP %d', [LResponse.StatusCode]), Result);
        Exit;
      end
      else if LResponse.StatusCode >= 500 then
      begin
        DoLog(ltWarning, Format('HTTP %d - Retry %d/%d', [LResponse.StatusCode, LRetry + 1, FMaxRetries]), FLastResponse);
        Sleep(LDelay);
        LDelay := LDelay * 2;
      end
      else
      begin
        Result := FLastResponse;
        DoLog(ltError, Format('HTTP %d', [LResponse.StatusCode]), Result);
        Exit;
      end;
    finally
      LContent.Free;
    end;
  end;
end;

function THTTPClientEx.Put(const AURL, ABody: string; const AHeaders: TArray<TPair<string,string>>): string;
var
  LResponse: IHTTPResponse;
  LHeader: TPair<string,string>;
  LContent: TStringStream;
begin
  FLastStatusCode := 0;
  FLastResponse := '';
  
  LContent := TStringStream.Create(ABody, TEncoding.UTF8);
  try
    FClient.ConnectionTimeout := FTimeout;
    FClient.ResponseTimeout := FTimeout;
    
    for LHeader in AHeaders do
      FClient.CustomHeaders[LHeader.Key] := LHeader.Value;
    
    DoLog(ltRequest, 'PUT ' + AURL, ABody);
    LResponse := FClient.Put(AURL, LContent);
    FLastStatusCode := LResponse.StatusCode;
    FLastResponse := LResponse.ContentAsString;
    Result := FLastResponse;
    DoLog(ltResponse, Format('HTTP %d', [LResponse.StatusCode]), Result);
  finally
    LContent.Free;
  end;
end;

function THTTPClientEx.Delete(const AURL: string; const AHeaders: TArray<TPair<string,string>>): string;
var
  LResponse: IHTTPResponse;
  LHeader: TPair<string,string>;
begin
  FLastStatusCode := 0;
  FLastResponse := '';
  
  FClient.ConnectionTimeout := FTimeout;
  FClient.ResponseTimeout := FTimeout;
  
  for LHeader in AHeaders do
    FClient.CustomHeaders[LHeader.Key] := LHeader.Value;
  
  DoLog(ltRequest, 'DELETE ' + AURL, '');
  LResponse := FClient.Delete(AURL);
  FLastStatusCode := LResponse.StatusCode;
  FLastResponse := LResponse.ContentAsString;
  Result := FLastResponse;
  DoLog(ltResponse, Format('HTTP %d', [LResponse.StatusCode]), Result);
end;

{ TPBMClientBase }

constructor TPBMClientBase.Create(const AClientID, AClientSecret, ACodEstabelecimento: string;
  AHomologacao: Boolean);
begin
  inherited Create;
  
  FConfig := TPBMConfigBase.Create;
  FConfig.ClientID := AClientID;
  FConfig.ClientSecret := AClientSecret;
  FConfig.CodEstabelecimento := ACodEstabelecimento;
  FConfig.Homologacao := AHomologacao;
  
  FHomologacao := AHomologacao;
  FHTTPClient := THTTPClientEx.Create;
  FHTTPClient.Timeout := FConfig.Timeout;
  FHTTPClient.MaxRetries := FConfig.RetryCount;
  FHTTPClient.BaseDelay := FConfig.RetryDelay;
  
  FTokenManager := TTokenManager.Create;
  FTokenManager.OnObterToken := ObterTokenInterno;
end;

destructor TPBMClientBase.Destroy;
begin
  FTokenManager.Free;
  FHTTPClient.Free;
  FConfig.Free;
  inherited;
end;

procedure TPBMClientBase.DoLog(ATipo: TPBMLogTipo; const AMsg, ADetalhes: string);
begin
  if Assigned(FConfig.OnLog) then
    FConfig.OnLog(Self, ATipo, AMsg, ADetalhes);
end;

procedure TPBMClientBase.SetAmbiente(AHomologacao: Boolean);
begin
  FHomologacao := AHomologacao;
  FConfig.Homologacao := AHomologacao;
  FTokenManager.Invalidar; // Invalida token ao mudar ambiente
end;

function TPBMClientBase.GetAmbiente: Boolean;
begin
  Result := FHomologacao;
end;

function TPBMClientBase.GetNomeOperadora: string;
begin
  Result := FNomeOperadora;
end;

function TPBMClientBase.GetCodigoOperadora: string;
begin
  Result := FCodigoOperadora;
end;

function TPBMClientBase.GetConfig: TPBMConfigBase;
begin
  Result := FConfig;
end;

function TPBMClientBase.GetConectado: Boolean;
begin
  Result := FTokenManager.IsValid;
end;

function TPBMClientBase.GetUltimoErro: string;
begin
  Result := FUltimoErro;
end;

function TPBMClientBase.Ping: Boolean;
begin
  // Tenta obter token para verificar conectividade
  try
    Result := FTokenManager.GetToken <> '';
  except
    Result := False;
  end;
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
