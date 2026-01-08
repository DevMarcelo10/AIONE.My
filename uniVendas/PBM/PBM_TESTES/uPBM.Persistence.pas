unit uPBM.Persistence;

{******************************************************************************
  PBM Persistence Layer
  
  Camada de persistência para autorizações, NSU, rewards e logs.
  Compatível com MySQL via FireDAC ou dbExpress.
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.DateUtils,
  System.Generics.Collections, Data.DB, FireDAC.Comp.Client,
  uPBM.Interfaces;

type
  // Forward declarations
  TPBMPersistence = class;
  
  {$REGION 'Enums'}
  TPBMOperadoraTipo = (otPBM, otFidelidade, otGoverno);
  TPBMAutorizacaoStatus = (asAutorizada, asCancelada, asEstornada, asPendente, asErro);
  TPBMRewardTipo = (rtCredito, rtDebito, rtExpiracao, rtAjuste);
  {$ENDREGION}

  {$REGION 'Records - Estruturas de dados'}
  
  /// <summary>Configuração de operadora PBM</summary>
  RPBMOperadora = record
    ID: Integer;
    Codigo: string;
    Nome: string;
    Tipo: TPBMOperadoraTipo;
    EndpointHom: string;
    EndpointProd: string;
    ClientID: string;
    ClientSecret: string;
    CodEstabelecimento: string;
    Usuario: string;
    Senha: string;
    APIKey: string;
    Ativo: Boolean;
    UsaToken: Boolean;
    TokenValidade: Integer;
    
    class function TipoToStr(ATipo: TPBMOperadoraTipo): string; static;
    class function StrToTipo(const AStr: string): TPBMOperadoraTipo; static;
  end;
  
  /// <summary>Token OAuth em cache</summary>
  RPBMToken = record
    ID: Integer;
    OperadoraID: Integer;
    AccessToken: string;
    TokenType: string;
    ExpiresAt: TDateTime;
    RefreshToken: string;
    
    function IsValid: Boolean;
    function MinutesRemaining: Integer;
  end;
  
  /// <summary>Item de autorização (medicamento)</summary>
  RPBMAutorizacaoItem = record
    ID: Int64;
    AutorizacaoID: Int64;
    EAN: string;
    Descricao: string;
    Quantidade: Double;
    PrecoTabela: Currency;
    PrecoPMC: Currency;
    PrecoVenda: Currency;
    DescontoPercentual: Double;
    DescontoValor: Currency;
    ValorFinal: Currency;
    CRMPrescritor: string;
    UFPrescritor: string;
  end;
  
  /// <summary>Autorização de venda PBM</summary>
  RPBMAutorizacao = record
    ID: Int64;
    OperadoraID: Integer;
    VendaID: Int64;
    
    // Identificadores
    NSU: string;
    CodigoAutorizacao: string;
    Protocolo: string;
    TransacaoID: string;
    
    // Beneficiário
    Carteirinha: string;
    CPF: string;
    NomeBeneficiario: string;
    Plano: string;
    
    // Valores
    ValorBruto: Currency;
    ValorDesconto: Currency;
    ValorLiquido: Currency;
    ValorSubsidio: Currency;
    
    // Status
    Status: TPBMAutorizacaoStatus;
    MotivoCancelamento: string;
    
    // Datas
    DataAutorizacao: TDateTime;
    DataCancelamento: TDateTime;
    
    // Extras
    RequestJSON: string;
    ResponseJSON: string;
    
    // Itens
    Itens: TArray<RPBMAutorizacaoItem>;
    
    class function StatusToStr(AStatus: TPBMAutorizacaoStatus): string; static;
    class function StrToStatus(const AStr: string): TPBMAutorizacaoStatus; static;
  end;
  
  /// <summary>Movimento de rewards/pontos</summary>
  RPBMReward = record
    ID: Int64;
    OperadoraID: Integer;
    AutorizacaoID: Int64;
    ClienteID: Int64;
    
    CartaoFidelidade: string;
    CPF: string;
    
    Tipo: TPBMRewardTipo;
    Pontos: Integer;
    SaldoAnterior: Integer;
    SaldoAtual: Integer;
    
    Descricao: string;
    DataMovimento: TDateTime;
    DataExpiracao: TDate;
    
    class function TipoToStr(ATipo: TPBMRewardTipo): string; static;
    class function StrToTipo(const AStr: string): TPBMRewardTipo; static;
  end;
  
  /// <summary>Log de comunicação</summary>
  RPBMLog = record
    ID: Int64;
    OperadoraID: Integer;
    AutorizacaoID: Int64;
    
    Operacao: string;
    Endpoint: string;
    Metodo: string;
    
    RequestHeaders: string;
    RequestBody: string;
    ResponseCode: Integer;
    ResponseBody: string;
    
    TempoMS: Integer;
    Tentativa: Integer;
    
    Sucesso: Boolean;
    ErroMensagem: string;
    
    CreatedAt: TDateTime;
  end;
  
  {$ENDREGION}

  {$REGION 'Interfaces'}
  
  /// <summary>Interface para persistência PBM</summary>
  IPBMPersistence = interface
    ['{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}']
    // Operadoras
    function GetOperadora(const ACodigo: string): RPBMOperadora;
    function GetOperadoraByID(AID: Integer): RPBMOperadora;
    function ListOperadoras(AAtivas: Boolean = True): TArray<RPBMOperadora>;
    function SaveOperadora(var AOperadora: RPBMOperadora): Boolean;
    
    // Tokens
    function GetToken(AOperadoraID: Integer): RPBMToken;
    function SaveToken(const AToken: RPBMToken): Boolean;
    procedure ClearExpiredTokens;
    
    // Autorizações
    function GetAutorizacao(AID: Int64): RPBMAutorizacao;
    function GetAutorizacaoByNSU(AOperadoraID: Integer; const ANSU: string): RPBMAutorizacao;
    function SaveAutorizacao(var AAutorizacao: RPBMAutorizacao): Int64;
    function UpdateAutorizacaoStatus(AID: Int64; AStatus: TPBMAutorizacaoStatus; 
      const AMotivo: string = ''): Boolean;
    function VincularVenda(AAutorizacaoID, AVendaID: Int64): Boolean;
    function ListAutorizacoes(AOperadoraID: Integer; ADataIni, ADataFim: TDate): TArray<RPBMAutorizacao>;
    function ListPendentes: TArray<RPBMAutorizacao>;
    
    // Itens
    function SaveAutorizacaoItens(AAutorizacaoID: Int64; const AItens: TArray<RPBMAutorizacaoItem>): Boolean;
    function GetAutorizacaoItens(AAutorizacaoID: Int64): TArray<RPBMAutorizacaoItem>;
    
    // Rewards
    function SaveReward(var AReward: RPBMReward): Int64;
    function GetSaldoRewards(AOperadoraID: Integer; const ACPF: string): Integer;
    function ListRewards(AOperadoraID: Integer; const ACPF: string; ALimit: Integer = 50): TArray<RPBMReward>;
    
    // Log
    procedure Log(AOperadoraID: Integer; AAutorizacaoID: Int64; const AOperacao, AEndpoint, AMetodo: string;
      const ARequestHeaders, ARequestBody: string; AResponseCode: Integer; const AResponseBody: string;
      ATempoMS, ATentativa: Integer; ASucesso: Boolean; const AErro: string = '');
    function GetLogs(AOperadoraID: Integer; ADataIni, ADataFim: TDateTime; ALimit: Integer = 100): TArray<RPBMLog>;
  end;
  
  {$ENDREGION}

  {$REGION 'Implementação'}
  
  /// <summary>Implementação da persistência com FireDAC/MySQL</summary>
  TPBMPersistence = class(TInterfacedObject, IPBMPersistence)
  private
    FConnection: TFDConnection;
    FOwnsConnection: Boolean;
    
    function ExecuteScalar(const ASQL: string): Variant;
    function OpenQuery(const ASQL: string): TFDQuery;
    procedure ExecSQL(const ASQL: string);
    
    function OperadoraFromDS(ADS: TDataSet): RPBMOperadora;
    function TokenFromDS(ADS: TDataSet): RPBMToken;
    function AutorizacaoFromDS(ADS: TDataSet): RPBMAutorizacao;
    function ItemFromDS(ADS: TDataSet): RPBMAutorizacaoItem;
    function RewardFromDS(ADS: TDataSet): RPBMReward;
    function LogFromDS(ADS: TDataSet): RPBMLog;
    
  public
    constructor Create(AConnection: TFDConnection; AOwnsConnection: Boolean = False);
    destructor Destroy; override;
    
    // IPBMPersistence
    function GetOperadora(const ACodigo: string): RPBMOperadora;
    function GetOperadoraByID(AID: Integer): RPBMOperadora;
    function ListOperadoras(AAtivas: Boolean = True): TArray<RPBMOperadora>;
    function SaveOperadora(var AOperadora: RPBMOperadora): Boolean;
    
    function GetToken(AOperadoraID: Integer): RPBMToken;
    function SaveToken(const AToken: RPBMToken): Boolean;
    procedure ClearExpiredTokens;
    
    function GetAutorizacao(AID: Int64): RPBMAutorizacao;
    function GetAutorizacaoByNSU(AOperadoraID: Integer; const ANSU: string): RPBMAutorizacao;
    function SaveAutorizacao(var AAutorizacao: RPBMAutorizacao): Int64;
    function UpdateAutorizacaoStatus(AID: Int64; AStatus: TPBMAutorizacaoStatus; 
      const AMotivo: string = ''): Boolean;
    function VincularVenda(AAutorizacaoID, AVendaID: Int64): Boolean;
    function ListAutorizacoes(AOperadoraID: Integer; ADataIni, ADataFim: TDate): TArray<RPBMAutorizacao>;
    function ListPendentes: TArray<RPBMAutorizacao>;
    
    function SaveAutorizacaoItens(AAutorizacaoID: Int64; const AItens: TArray<RPBMAutorizacaoItem>): Boolean;
    function GetAutorizacaoItens(AAutorizacaoID: Int64): TArray<RPBMAutorizacaoItem>;
    
    function SaveReward(var AReward: RPBMReward): Int64;
    function GetSaldoRewards(AOperadoraID: Integer; const ACPF: string): Integer;
    function ListRewards(AOperadoraID: Integer; const ACPF: string; ALimit: Integer = 50): TArray<RPBMReward>;
    
    procedure Log(AOperadoraID: Integer; AAutorizacaoID: Int64; const AOperacao, AEndpoint, AMetodo: string;
      const ARequestHeaders, ARequestBody: string; AResponseCode: Integer; const AResponseBody: string;
      ATempoMS, ATentativa: Integer; ASucesso: Boolean; const AErro: string = '');
    function GetLogs(AOperadoraID: Integer; ADataIni, ADataFim: TDateTime; ALimit: Integer = 100): TArray<RPBMLog>;
  end;
  
  {$ENDREGION}

  {$REGION 'Helper - Integração com IPBMClient'}
  
  /// <summary>Helper para integrar IPBMClient com persistência</summary>
  TPBMClientHelper = class
  public
    /// <summary>Persiste autorização a partir do response da API</summary>
    class function PersistirAutorizacao(
      APersistence: IPBMPersistence;
      AOperadoraID: Integer;
      const AAutorizacao: IPBMAutorizacao;
      const ATransacaoID, ACarteirinha, ACPF: string;
      AValorBruto: Currency;
      const AItens: TArray<RPBMAutorizacaoItem>;
      const ARequestJSON, AResponseJSON: string
    ): Int64;
    
    /// <summary>Persiste cancelamento</summary>
    class function PersistirCancelamento(
      APersistence: IPBMPersistence;
      AOperadoraID: Integer;
      const ANSU, AMotivo: string
    ): Boolean;
    
    /// <summary>Registra log de comunicação</summary>
    class procedure RegistrarLog(
      APersistence: IPBMPersistence;
      AOperadoraID: Integer;
      AAutorizacaoID: Int64;
      const AOperacao, AEndpoint, AMetodo: string;
      const ARequest, AResponse: string;
      AResponseCode, ATempoMS, ATentativa: Integer;
      ASucesso: Boolean;
      const AErro: string = ''
    );
  end;
  
  {$ENDREGION}

implementation

uses
  System.Variants, FireDAC.Stan.Param;

{$REGION 'RPBMOperadora'}

class function RPBMOperadora.TipoToStr(ATipo: TPBMOperadoraTipo): string;
begin
  case ATipo of
    otPBM:       Result := 'PBM';
    otFidelidade: Result := 'FIDELIDADE';
    otGoverno:   Result := 'GOVERNO';
  else
    Result := 'PBM';
  end;
end;

class function RPBMOperadora.StrToTipo(const AStr: string): TPBMOperadoraTipo;
begin
  if SameText(AStr, 'FIDELIDADE') then
    Result := otFidelidade
  else if SameText(AStr, 'GOVERNO') then
    Result := otGoverno
  else
    Result := otPBM;
end;

{$ENDREGION}

{$REGION 'RPBMToken'}

function RPBMToken.IsValid: Boolean;
begin
  Result := (AccessToken <> '') and (ExpiresAt > Now);
end;

function RPBMToken.MinutesRemaining: Integer;
begin
  if ExpiresAt > Now then
    Result := MinutesBetween(Now, ExpiresAt)
  else
    Result := 0;
end;

{$ENDREGION}

{$REGION 'RPBMAutorizacao'}

class function RPBMAutorizacao.StatusToStr(AStatus: TPBMAutorizacaoStatus): string;
begin
  case AStatus of
    asAutorizada: Result := 'AUTORIZADA';
    asCancelada:  Result := 'CANCELADA';
    asEstornada:  Result := 'ESTORNADA';
    asPendente:   Result := 'PENDENTE';
    asErro:       Result := 'ERRO';
  else
    Result := 'PENDENTE';
  end;
end;

class function RPBMAutorizacao.StrToStatus(const AStr: string): TPBMAutorizacaoStatus;
begin
  if SameText(AStr, 'AUTORIZADA') then
    Result := asAutorizada
  else if SameText(AStr, 'CANCELADA') then
    Result := asCancelada
  else if SameText(AStr, 'ESTORNADA') then
    Result := asEstornada
  else if SameText(AStr, 'ERRO') then
    Result := asErro
  else
    Result := asPendente;
end;

{$ENDREGION}

{$REGION 'RPBMReward'}

class function RPBMReward.TipoToStr(ATipo: TPBMRewardTipo): string;
begin
  case ATipo of
    rtCredito:   Result := 'CREDITO';
    rtDebito:    Result := 'DEBITO';
    rtExpiracao: Result := 'EXPIRACAO';
    rtAjuste:    Result := 'AJUSTE';
  else
    Result := 'CREDITO';
  end;
end;

class function RPBMReward.StrToTipo(const AStr: string): TPBMRewardTipo;
begin
  if SameText(AStr, 'DEBITO') then
    Result := rtDebito
  else if SameText(AStr, 'EXPIRACAO') then
    Result := rtExpiracao
  else if SameText(AStr, 'AJUSTE') then
    Result := rtAjuste
  else
    Result := rtCredito;
end;

{$ENDREGION}

{$REGION 'TPBMPersistence'}

constructor TPBMPersistence.Create(AConnection: TFDConnection; AOwnsConnection: Boolean);
begin
  inherited Create;
  FConnection := AConnection;
  FOwnsConnection := AOwnsConnection;
end;

destructor TPBMPersistence.Destroy;
begin
  if FOwnsConnection and Assigned(FConnection) then
    FConnection.Free;
  inherited;
end;

function TPBMPersistence.ExecuteScalar(const ASQL: string): Variant;
var
  LQuery: TFDQuery;
begin
  Result := Null;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Text := ASQL;
    LQuery.Open;
    if not LQuery.IsEmpty then
      Result := LQuery.Fields[0].Value;
  finally
    LQuery.Free;
  end;
end;

function TPBMPersistence.OpenQuery(const ASQL: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConnection;
  Result.SQL.Text := ASQL;
  Result.Open;
end;

procedure TPBMPersistence.ExecSQL(const ASQL: string);
begin
  FConnection.ExecSQL(ASQL);
end;

function TPBMPersistence.OperadoraFromDS(ADS: TDataSet): RPBMOperadora;
begin
  Result := Default(RPBMOperadora);
  Result.ID := ADS.FieldByName('id').AsInteger;
  Result.Codigo := ADS.FieldByName('codigo').AsString;
  Result.Nome := ADS.FieldByName('nome').AsString;
  Result.Tipo := RPBMOperadora.StrToTipo(ADS.FieldByName('tipo').AsString);
  Result.EndpointHom := ADS.FieldByName('endpoint_hom').AsString;
  Result.EndpointProd := ADS.FieldByName('endpoint_prod').AsString;
  Result.ClientID := ADS.FieldByName('client_id').AsString;
  Result.ClientSecret := ADS.FieldByName('client_secret').AsString;
  Result.CodEstabelecimento := ADS.FieldByName('cod_estabelec').AsString;
  Result.Usuario := ADS.FieldByName('usuario').AsString;
  Result.Senha := ADS.FieldByName('senha').AsString;
  Result.APIKey := ADS.FieldByName('api_key').AsString;
  Result.Ativo := ADS.FieldByName('ativo').AsBoolean;
  Result.UsaToken := ADS.FieldByName('usa_token').AsBoolean;
  Result.TokenValidade := ADS.FieldByName('token_validade').AsInteger;
end;

function TPBMPersistence.TokenFromDS(ADS: TDataSet): RPBMToken;
begin
  Result := Default(RPBMToken);
  Result.ID := ADS.FieldByName('id').AsInteger;
  Result.OperadoraID := ADS.FieldByName('operadora_id').AsInteger;
  Result.AccessToken := ADS.FieldByName('access_token').AsString;
  Result.TokenType := ADS.FieldByName('token_type').AsString;
  Result.ExpiresAt := ADS.FieldByName('expires_at').AsDateTime;
  Result.RefreshToken := ADS.FieldByName('refresh_token').AsString;
end;

function TPBMPersistence.AutorizacaoFromDS(ADS: TDataSet): RPBMAutorizacao;
begin
  Result := Default(RPBMAutorizacao);
  Result.ID := ADS.FieldByName('id').AsLargeInt;
  Result.OperadoraID := ADS.FieldByName('operadora_id').AsInteger;
  Result.VendaID := ADS.FieldByName('venda_id').AsLargeInt;
  Result.NSU := ADS.FieldByName('nsu').AsString;
  Result.CodigoAutorizacao := ADS.FieldByName('codigo_autorizacao').AsString;
  Result.Protocolo := ADS.FieldByName('protocolo').AsString;
  Result.TransacaoID := ADS.FieldByName('transacao_id').AsString;
  Result.Carteirinha := ADS.FieldByName('carteirinha').AsString;
  Result.CPF := ADS.FieldByName('cpf').AsString;
  Result.NomeBeneficiario := ADS.FieldByName('nome_beneficiario').AsString;
  Result.Plano := ADS.FieldByName('plano').AsString;
  Result.ValorBruto := ADS.FieldByName('valor_bruto').AsCurrency;
  Result.ValorDesconto := ADS.FieldByName('valor_desconto').AsCurrency;
  Result.ValorLiquido := ADS.FieldByName('valor_liquido').AsCurrency;
  Result.ValorSubsidio := ADS.FieldByName('valor_subsidio').AsCurrency;
  Result.Status := RPBMAutorizacao.StrToStatus(ADS.FieldByName('status').AsString);
  Result.MotivoCancelamento := ADS.FieldByName('motivo_cancelamento').AsString;
  Result.DataAutorizacao := ADS.FieldByName('data_autorizacao').AsDateTime;
  if not ADS.FieldByName('data_cancelamento').IsNull then
    Result.DataCancelamento := ADS.FieldByName('data_cancelamento').AsDateTime;
  Result.RequestJSON := ADS.FieldByName('request_json').AsString;
  Result.ResponseJSON := ADS.FieldByName('response_json').AsString;
end;

function TPBMPersistence.ItemFromDS(ADS: TDataSet): RPBMAutorizacaoItem;
begin
  Result := Default(RPBMAutorizacaoItem);
  Result.ID := ADS.FieldByName('id').AsLargeInt;
  Result.AutorizacaoID := ADS.FieldByName('autorizacao_id').AsLargeInt;
  Result.EAN := ADS.FieldByName('ean').AsString;
  Result.Descricao := ADS.FieldByName('descricao').AsString;
  Result.Quantidade := ADS.FieldByName('quantidade').AsFloat;
  Result.PrecoTabela := ADS.FieldByName('preco_tabela').AsCurrency;
  Result.PrecoPMC := ADS.FieldByName('preco_pmc').AsCurrency;
  Result.PrecoVenda := ADS.FieldByName('preco_venda').AsCurrency;
  Result.DescontoPercentual := ADS.FieldByName('desconto_percentual').AsFloat;
  Result.DescontoValor := ADS.FieldByName('desconto_valor').AsCurrency;
  Result.ValorFinal := ADS.FieldByName('valor_final').AsCurrency;
  Result.CRMPrescritor := ADS.FieldByName('crm_prescritor').AsString;
  Result.UFPrescritor := ADS.FieldByName('uf_prescritor').AsString;
end;

function TPBMPersistence.RewardFromDS(ADS: TDataSet): RPBMReward;
begin
  Result := Default(RPBMReward);
  Result.ID := ADS.FieldByName('id').AsLargeInt;
  Result.OperadoraID := ADS.FieldByName('operadora_id').AsInteger;
  Result.AutorizacaoID := ADS.FieldByName('autorizacao_id').AsLargeInt;
  Result.ClienteID := ADS.FieldByName('cliente_id').AsLargeInt;
  Result.CartaoFidelidade := ADS.FieldByName('cartao_fidelidade').AsString;
  Result.CPF := ADS.FieldByName('cpf').AsString;
  Result.Tipo := RPBMReward.StrToTipo(ADS.FieldByName('tipo').AsString);
  Result.Pontos := ADS.FieldByName('pontos').AsInteger;
  Result.SaldoAnterior := ADS.FieldByName('saldo_anterior').AsInteger;
  Result.SaldoAtual := ADS.FieldByName('saldo_atual').AsInteger;
  Result.Descricao := ADS.FieldByName('descricao').AsString;
  Result.DataMovimento := ADS.FieldByName('data_movimento').AsDateTime;
  if not ADS.FieldByName('data_expiracao').IsNull then
    Result.DataExpiracao := ADS.FieldByName('data_expiracao').AsDateTime;
end;

function TPBMPersistence.LogFromDS(ADS: TDataSet): RPBMLog;
begin
  Result := Default(RPBMLog);
  Result.ID := ADS.FieldByName('id').AsLargeInt;
  Result.OperadoraID := ADS.FieldByName('operadora_id').AsInteger;
  Result.AutorizacaoID := ADS.FieldByName('autorizacao_id').AsLargeInt;
  Result.Operacao := ADS.FieldByName('operacao').AsString;
  Result.Endpoint := ADS.FieldByName('endpoint').AsString;
  Result.Metodo := ADS.FieldByName('metodo').AsString;
  Result.RequestHeaders := ADS.FieldByName('request_headers').AsString;
  Result.RequestBody := ADS.FieldByName('request_body').AsString;
  Result.ResponseCode := ADS.FieldByName('response_code').AsInteger;
  Result.ResponseBody := ADS.FieldByName('response_body').AsString;
  Result.TempoMS := ADS.FieldByName('tempo_ms').AsInteger;
  Result.Tentativa := ADS.FieldByName('tentativa').AsInteger;
  Result.Sucesso := ADS.FieldByName('sucesso').AsBoolean;
  Result.ErroMensagem := ADS.FieldByName('erro_mensagem').AsString;
  Result.CreatedAt := ADS.FieldByName('created_at').AsDateTime;
end;

// === OPERADORAS ===

function TPBMPersistence.GetOperadora(const ACodigo: string): RPBMOperadora;
var
  LQuery: TFDQuery;
begin
  Result := Default(RPBMOperadora);
  LQuery := OpenQuery(Format(
    'SELECT * FROM pbm_operadoras WHERE codigo = %s', [QuotedStr(ACodigo)]));
  try
    if not LQuery.IsEmpty then
      Result := OperadoraFromDS(LQuery);
  finally
    LQuery.Free;
  end;
end;

function TPBMPersistence.GetOperadoraByID(AID: Integer): RPBMOperadora;
var
  LQuery: TFDQuery;
begin
  Result := Default(RPBMOperadora);
  LQuery := OpenQuery(Format('SELECT * FROM pbm_operadoras WHERE id = %d', [AID]));
  try
    if not LQuery.IsEmpty then
      Result := OperadoraFromDS(LQuery);
  finally
    LQuery.Free;
  end;
end;

function TPBMPersistence.ListOperadoras(AAtivas: Boolean): TArray<RPBMOperadora>;
var
  LQuery: TFDQuery;
  LList: TList<RPBMOperadora>;
begin
  LList := TList<RPBMOperadora>.Create;
  try
    if AAtivas then
      LQuery := OpenQuery('SELECT * FROM pbm_operadoras WHERE ativo = 1 ORDER BY nome')
    else
      LQuery := OpenQuery('SELECT * FROM pbm_operadoras ORDER BY nome');
    try
      while not LQuery.Eof do
      begin
        LList.Add(OperadoraFromDS(LQuery));
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TPBMPersistence.SaveOperadora(var AOperadora: RPBMOperadora): Boolean;
var
  LSQL: string;
begin
  if AOperadora.ID = 0 then
  begin
    // INSERT
    LSQL := Format(
      'INSERT INTO pbm_operadoras (codigo, nome, tipo, endpoint_hom, endpoint_prod, ' +
      'client_id, client_secret, cod_estabelec, usuario, senha, api_key, ativo, usa_token, token_validade) ' +
      'VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %d, %d, %d)',
      [QuotedStr(AOperadora.Codigo), QuotedStr(AOperadora.Nome),
       QuotedStr(RPBMOperadora.TipoToStr(AOperadora.Tipo)),
       QuotedStr(AOperadora.EndpointHom), QuotedStr(AOperadora.EndpointProd),
       QuotedStr(AOperadora.ClientID), QuotedStr(AOperadora.ClientSecret),
       QuotedStr(AOperadora.CodEstabelecimento), QuotedStr(AOperadora.Usuario),
       QuotedStr(AOperadora.Senha), QuotedStr(AOperadora.APIKey),
       Ord(AOperadora.Ativo), Ord(AOperadora.UsaToken), AOperadora.TokenValidade]);
    ExecSQL(LSQL);
    AOperadora.ID := ExecuteScalar('SELECT LAST_INSERT_ID()');
  end
  else
  begin
    // UPDATE
    LSQL := Format(
      'UPDATE pbm_operadoras SET codigo = %s, nome = %s, tipo = %s, ' +
      'endpoint_hom = %s, endpoint_prod = %s, client_id = %s, client_secret = %s, ' +
      'cod_estabelec = %s, usuario = %s, senha = %s, api_key = %s, ' +
      'ativo = %d, usa_token = %d, token_validade = %d WHERE id = %d',
      [QuotedStr(AOperadora.Codigo), QuotedStr(AOperadora.Nome),
       QuotedStr(RPBMOperadora.TipoToStr(AOperadora.Tipo)),
       QuotedStr(AOperadora.EndpointHom), QuotedStr(AOperadora.EndpointProd),
       QuotedStr(AOperadora.ClientID), QuotedStr(AOperadora.ClientSecret),
       QuotedStr(AOperadora.CodEstabelecimento), QuotedStr(AOperadora.Usuario),
       QuotedStr(AOperadora.Senha), QuotedStr(AOperadora.APIKey),
       Ord(AOperadora.Ativo), Ord(AOperadora.UsaToken), AOperadora.TokenValidade,
       AOperadora.ID]);
    ExecSQL(LSQL);
  end;
  Result := True;
end;

// === TOKENS ===

function TPBMPersistence.GetToken(AOperadoraID: Integer): RPBMToken;
var
  LQuery: TFDQuery;
begin
  Result := Default(RPBMToken);
  LQuery := OpenQuery(Format(
    'SELECT * FROM pbm_tokens WHERE operadora_id = %d AND expires_at > NOW() ' +
    'ORDER BY expires_at DESC LIMIT 1', [AOperadoraID]));
  try
    if not LQuery.IsEmpty then
      Result := TokenFromDS(LQuery);
  finally
    LQuery.Free;
  end;
end;

function TPBMPersistence.SaveToken(const AToken: RPBMToken): Boolean;
begin
  // Remove tokens antigos da mesma operadora
  ExecSQL(Format('DELETE FROM pbm_tokens WHERE operadora_id = %d', [AToken.OperadoraID]));
  
  // Insere novo token
  ExecSQL(Format(
    'INSERT INTO pbm_tokens (operadora_id, access_token, token_type, expires_at, refresh_token) ' +
    'VALUES (%d, %s, %s, %s, %s)',
    [AToken.OperadoraID, QuotedStr(AToken.AccessToken), QuotedStr(AToken.TokenType),
     QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', AToken.ExpiresAt)),
     QuotedStr(AToken.RefreshToken)]));
  Result := True;
end;

procedure TPBMPersistence.ClearExpiredTokens;
begin
  ExecSQL('DELETE FROM pbm_tokens WHERE expires_at < NOW()');
end;

// === AUTORIZAÇÕES ===

function TPBMPersistence.GetAutorizacao(AID: Int64): RPBMAutorizacao;
var
  LQuery: TFDQuery;
begin
  Result := Default(RPBMAutorizacao);
  LQuery := OpenQuery(Format('SELECT * FROM pbm_autorizacoes WHERE id = %d', [AID]));
  try
    if not LQuery.IsEmpty then
    begin
      Result := AutorizacaoFromDS(LQuery);
      Result.Itens := GetAutorizacaoItens(AID);
    end;
  finally
    LQuery.Free;
  end;
end;

function TPBMPersistence.GetAutorizacaoByNSU(AOperadoraID: Integer; const ANSU: string): RPBMAutorizacao;
var
  LQuery: TFDQuery;
begin
  Result := Default(RPBMAutorizacao);
  LQuery := OpenQuery(Format(
    'SELECT * FROM pbm_autorizacoes WHERE operadora_id = %d AND nsu = %s',
    [AOperadoraID, QuotedStr(ANSU)]));
  try
    if not LQuery.IsEmpty then
    begin
      Result := AutorizacaoFromDS(LQuery);
      Result.Itens := GetAutorizacaoItens(Result.ID);
    end;
  finally
    LQuery.Free;
  end;
end;

function TPBMPersistence.SaveAutorizacao(var AAutorizacao: RPBMAutorizacao): Int64;
var
  LSQL: string;
  LVendaID: string;
begin
  if AAutorizacao.VendaID > 0 then
    LVendaID := IntToStr(AAutorizacao.VendaID)
  else
    LVendaID := 'NULL';
    
  LSQL := Format(
    'INSERT INTO pbm_autorizacoes (operadora_id, venda_id, nsu, codigo_autorizacao, protocolo, ' +
    'transacao_id, carteirinha, cpf, nome_beneficiario, plano, valor_bruto, valor_desconto, ' +
    'valor_liquido, valor_subsidio, status, data_autorizacao, request_json, response_json) ' +
    'VALUES (%d, %s, %s, %s, %s, %s, %s, %s, %s, %s, %.4f, %.4f, %.4f, %.4f, %s, %s, %s, %s)',
    [AAutorizacao.OperadoraID, LVendaID, 
     QuotedStr(AAutorizacao.NSU), QuotedStr(AAutorizacao.CodigoAutorizacao),
     QuotedStr(AAutorizacao.Protocolo), QuotedStr(AAutorizacao.TransacaoID),
     QuotedStr(AAutorizacao.Carteirinha), QuotedStr(AAutorizacao.CPF),
     QuotedStr(AAutorizacao.NomeBeneficiario), QuotedStr(AAutorizacao.Plano),
     AAutorizacao.ValorBruto, AAutorizacao.ValorDesconto,
     AAutorizacao.ValorLiquido, AAutorizacao.ValorSubsidio,
     QuotedStr(RPBMAutorizacao.StatusToStr(AAutorizacao.Status)),
     QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', AAutorizacao.DataAutorizacao)),
     QuotedStr(AAutorizacao.RequestJSON), QuotedStr(AAutorizacao.ResponseJSON)]);
  
  ExecSQL(LSQL);
  AAutorizacao.ID := ExecuteScalar('SELECT LAST_INSERT_ID()');
  Result := AAutorizacao.ID;
  
  // Salva itens se houver
  if Length(AAutorizacao.Itens) > 0 then
    SaveAutorizacaoItens(AAutorizacao.ID, AAutorizacao.Itens);
end;

function TPBMPersistence.UpdateAutorizacaoStatus(AID: Int64; AStatus: TPBMAutorizacaoStatus;
  const AMotivo: string): Boolean;
var
  LSQL: string;
begin
  if AStatus in [asCancelada, asEstornada] then
    LSQL := Format(
      'UPDATE pbm_autorizacoes SET status = %s, motivo_cancelamento = %s, ' +
      'data_cancelamento = NOW() WHERE id = %d',
      [QuotedStr(RPBMAutorizacao.StatusToStr(AStatus)), QuotedStr(AMotivo), AID])
  else
    LSQL := Format(
      'UPDATE pbm_autorizacoes SET status = %s WHERE id = %d',
      [QuotedStr(RPBMAutorizacao.StatusToStr(AStatus)), AID]);
  
  ExecSQL(LSQL);
  Result := True;
end;

function TPBMPersistence.VincularVenda(AAutorizacaoID, AVendaID: Int64): Boolean;
begin
  ExecSQL(Format('UPDATE pbm_autorizacoes SET venda_id = %d WHERE id = %d',
    [AVendaID, AAutorizacaoID]));
  Result := True;
end;

function TPBMPersistence.ListAutorizacoes(AOperadoraID: Integer; ADataIni, ADataFim: TDate): TArray<RPBMAutorizacao>;
var
  LQuery: TFDQuery;
  LList: TList<RPBMAutorizacao>;
  LAuth: RPBMAutorizacao;
begin
  LList := TList<RPBMAutorizacao>.Create;
  try
    LQuery := OpenQuery(Format(
      'SELECT * FROM pbm_autorizacoes WHERE operadora_id = %d ' +
      'AND DATE(data_autorizacao) BETWEEN %s AND %s ORDER BY data_autorizacao DESC',
      [AOperadoraID, QuotedStr(FormatDateTime('yyyy-mm-dd', ADataIni)),
       QuotedStr(FormatDateTime('yyyy-mm-dd', ADataFim))]));
    try
      while not LQuery.Eof do
      begin
        LAuth := AutorizacaoFromDS(LQuery);
        LList.Add(LAuth);
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TPBMPersistence.ListPendentes: TArray<RPBMAutorizacao>;
var
  LQuery: TFDQuery;
  LList: TList<RPBMAutorizacao>;
begin
  LList := TList<RPBMAutorizacao>.Create;
  try
    LQuery := OpenQuery(
      'SELECT * FROM pbm_autorizacoes WHERE status IN (''PENDENTE'', ''ERRO'') ' +
      'OR (status = ''AUTORIZADA'' AND venda_id IS NULL) ORDER BY created_at DESC');
    try
      while not LQuery.Eof do
      begin
        LList.Add(AutorizacaoFromDS(LQuery));
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

// === ITENS ===

function TPBMPersistence.SaveAutorizacaoItens(AAutorizacaoID: Int64;
  const AItens: TArray<RPBMAutorizacaoItem>): Boolean;
var
  LItem: RPBMAutorizacaoItem;
begin
  for LItem in AItens do
  begin
    ExecSQL(Format(
      'INSERT INTO pbm_autorizacao_itens (autorizacao_id, ean, descricao, quantidade, ' +
      'preco_tabela, preco_pmc, preco_venda, desconto_percentual, desconto_valor, ' +
      'valor_final, crm_prescritor, uf_prescritor) ' +
      'VALUES (%d, %s, %s, %.3f, %.4f, %.4f, %.4f, %.2f, %.4f, %.4f, %s, %s)',
      [AAutorizacaoID, QuotedStr(LItem.EAN), QuotedStr(LItem.Descricao),
       LItem.Quantidade, LItem.PrecoTabela, LItem.PrecoPMC, LItem.PrecoVenda,
       LItem.DescontoPercentual, LItem.DescontoValor, LItem.ValorFinal,
       QuotedStr(LItem.CRMPrescritor), QuotedStr(LItem.UFPrescritor)]));
  end;
  Result := True;
end;

function TPBMPersistence.GetAutorizacaoItens(AAutorizacaoID: Int64): TArray<RPBMAutorizacaoItem>;
var
  LQuery: TFDQuery;
  LList: TList<RPBMAutorizacaoItem>;
begin
  LList := TList<RPBMAutorizacaoItem>.Create;
  try
    LQuery := OpenQuery(Format(
      'SELECT * FROM pbm_autorizacao_itens WHERE autorizacao_id = %d', [AAutorizacaoID]));
    try
      while not LQuery.Eof do
      begin
        LList.Add(ItemFromDS(LQuery));
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

// === REWARDS ===

function TPBMPersistence.SaveReward(var AReward: RPBMReward): Int64;
var
  LAuthID, LClienteID, LExpiracao: string;
begin
  if AReward.AutorizacaoID > 0 then
    LAuthID := IntToStr(AReward.AutorizacaoID)
  else
    LAuthID := 'NULL';
    
  if AReward.ClienteID > 0 then
    LClienteID := IntToStr(AReward.ClienteID)
  else
    LClienteID := 'NULL';
    
  if AReward.DataExpiracao > 0 then
    LExpiracao := QuotedStr(FormatDateTime('yyyy-mm-dd', AReward.DataExpiracao))
  else
    LExpiracao := 'NULL';
  
  ExecSQL(Format(
    'INSERT INTO pbm_rewards (operadora_id, autorizacao_id, cliente_id, cartao_fidelidade, ' +
    'cpf, tipo, pontos, saldo_anterior, saldo_atual, descricao, data_movimento, data_expiracao) ' +
    'VALUES (%d, %s, %s, %s, %s, %s, %d, %d, %d, %s, %s, %s)',
    [AReward.OperadoraID, LAuthID, LClienteID, QuotedStr(AReward.CartaoFidelidade),
     QuotedStr(AReward.CPF), QuotedStr(RPBMReward.TipoToStr(AReward.Tipo)),
     AReward.Pontos, AReward.SaldoAnterior, AReward.SaldoAtual,
     QuotedStr(AReward.Descricao),
     QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', AReward.DataMovimento)),
     LExpiracao]));
  
  AReward.ID := ExecuteScalar('SELECT LAST_INSERT_ID()');
  Result := AReward.ID;
end;

function TPBMPersistence.GetSaldoRewards(AOperadoraID: Integer; const ACPF: string): Integer;
var
  LVal: Variant;
begin
  LVal := ExecuteScalar(Format(
    'SELECT saldo_atual FROM pbm_rewards WHERE operadora_id = %d AND cpf = %s ' +
    'ORDER BY data_movimento DESC LIMIT 1',
    [AOperadoraID, QuotedStr(ACPF)]));
  if VarIsNull(LVal) then
    Result := 0
  else
    Result := LVal;
end;

function TPBMPersistence.ListRewards(AOperadoraID: Integer; const ACPF: string;
  ALimit: Integer): TArray<RPBMReward>;
var
  LQuery: TFDQuery;
  LList: TList<RPBMReward>;
begin
  LList := TList<RPBMReward>.Create;
  try
    LQuery := OpenQuery(Format(
      'SELECT * FROM pbm_rewards WHERE operadora_id = %d AND cpf = %s ' +
      'ORDER BY data_movimento DESC LIMIT %d',
      [AOperadoraID, QuotedStr(ACPF), ALimit]));
    try
      while not LQuery.Eof do
      begin
        LList.Add(RewardFromDS(LQuery));
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

// === LOG ===

procedure TPBMPersistence.Log(AOperadoraID: Integer; AAutorizacaoID: Int64;
  const AOperacao, AEndpoint, AMetodo, ARequestHeaders, ARequestBody: string;
  AResponseCode: Integer; const AResponseBody: string;
  ATempoMS, ATentativa: Integer; ASucesso: Boolean; const AErro: string);
var
  LAuthID: string;
begin
  if AAutorizacaoID > 0 then
    LAuthID := IntToStr(AAutorizacaoID)
  else
    LAuthID := 'NULL';
    
  ExecSQL(Format(
    'INSERT INTO pbm_log (operadora_id, autorizacao_id, operacao, endpoint, metodo, ' +
    'request_headers, request_body, response_code, response_body, tempo_ms, tentativa, ' +
    'sucesso, erro_mensagem) VALUES (%d, %s, %s, %s, %s, %s, %s, %d, %s, %d, %d, %d, %s)',
    [AOperadoraID, LAuthID, QuotedStr(AOperacao), QuotedStr(AEndpoint), QuotedStr(AMetodo),
     QuotedStr(ARequestHeaders), QuotedStr(ARequestBody), AResponseCode,
     QuotedStr(AResponseBody), ATempoMS, ATentativa, Ord(ASucesso), QuotedStr(AErro)]));
end;

function TPBMPersistence.GetLogs(AOperadoraID: Integer; ADataIni, ADataFim: TDateTime;
  ALimit: Integer): TArray<RPBMLog>;
var
  LQuery: TFDQuery;
  LList: TList<RPBMLog>;
begin
  LList := TList<RPBMLog>.Create;
  try
    LQuery := OpenQuery(Format(
      'SELECT * FROM pbm_log WHERE operadora_id = %d ' +
      'AND created_at BETWEEN %s AND %s ORDER BY created_at DESC LIMIT %d',
      [AOperadoraID, QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', ADataIni)),
       QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', ADataFim)), ALimit]));
    try
      while not LQuery.Eof do
      begin
        LList.Add(LogFromDS(LQuery));
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{$ENDREGION}

{$REGION 'TPBMClientHelper'}

class function TPBMClientHelper.PersistirAutorizacao(
  APersistence: IPBMPersistence;
  AOperadoraID: Integer;
  const AAutorizacao: IPBMAutorizacao;
  const ATransacaoID, ACarteirinha, ACPF: string;
  AValorBruto: Currency;
  const AItens: TArray<RPBMAutorizacaoItem>;
  const ARequestJSON, AResponseJSON: string): Int64;
var
  LAuth: RPBMAutorizacao;
begin
  LAuth := Default(RPBMAutorizacao);
  LAuth.OperadoraID := AOperadoraID;
  LAuth.NSU := AAutorizacao.NSU;
  LAuth.CodigoAutorizacao := AAutorizacao.CodigoAutorizacao;
  LAuth.TransacaoID := ATransacaoID;
  LAuth.Carteirinha := ACarteirinha;
  LAuth.CPF := ACPF;
  LAuth.NomeBeneficiario := AAutorizacao.NomeBeneficiario;
  LAuth.ValorBruto := AValorBruto;
  LAuth.ValorDesconto := AAutorizacao.ValorDesconto;
  LAuth.ValorLiquido := AValorBruto - AAutorizacao.ValorDesconto;
  LAuth.DataAutorizacao := Now;
  LAuth.RequestJSON := ARequestJSON;
  LAuth.ResponseJSON := AResponseJSON;
  LAuth.Itens := AItens;
  
  if AAutorizacao.Sucesso then
    LAuth.Status := asAutorizada
  else
    LAuth.Status := asErro;
  
  Result := APersistence.SaveAutorizacao(LAuth);
end;

class function TPBMClientHelper.PersistirCancelamento(
  APersistence: IPBMPersistence;
  AOperadoraID: Integer;
  const ANSU, AMotivo: string): Boolean;
var
  LAuth: RPBMAutorizacao;
begin
  LAuth := APersistence.GetAutorizacaoByNSU(AOperadoraID, ANSU);
  if LAuth.ID > 0 then
    Result := APersistence.UpdateAutorizacaoStatus(LAuth.ID, asCancelada, AMotivo)
  else
    Result := False;
end;

class procedure TPBMClientHelper.RegistrarLog(
  APersistence: IPBMPersistence;
  AOperadoraID: Integer;
  AAutorizacaoID: Int64;
  const AOperacao, AEndpoint, AMetodo, ARequest, AResponse: string;
  AResponseCode, ATempoMS, ATentativa: Integer;
  ASucesso: Boolean;
  const AErro: string);
begin
  APersistence.Log(AOperadoraID, AAutorizacaoID, AOperacao, AEndpoint, AMetodo,
    '', ARequest, AResponseCode, AResponse, ATempoMS, ATentativa, ASucesso, AErro);
end;

{$ENDREGION}

end.
