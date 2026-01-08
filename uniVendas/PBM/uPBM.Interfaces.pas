unit uPBM.Interfaces;

{******************************************************************************
  PBM Interfaces - Contratos Base
  
  Interfaces compartilhadas para todos os 12 PBMs suportados.
  Permite uso polimórfico através do Factory.
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  {$REGION 'Types'}
  
  /// <summary>Status das operações PBM</summary>
  TPBMStatus = (
    psNenhum,
    psPendente,
    psProcessando,
    psAutorizado,
    psNegado,
    psCancelado,
    psEstornado,
    psErro,
    psTimeout
  );
  
  /// <summary>Tipo de log</summary>
  TPBMLogTipo = (
    ltInfo,
    ltWarning,
    ltError,
    ltDebug,
    ltRequest,
    ltResponse
  );
  
  /// <summary>Evento de log para callbacks</summary>
  TPBMLogEvent = procedure(Sender: TObject; ATipo: TPBMLogTipo; 
    const AMensagem: string; const ADetalhes: string = '') of object;
  
  /// <summary>Evento de mudança de status</summary>
  TPBMStatusEvent = procedure(Sender: TObject; AStatus: TPBMStatus; 
    const AMensagem: string) of object;
  
  /// <summary>Produto para autorização</summary>
  TPBMProduto = record
    EAN: string;
    Descricao: string;
    Quantidade: Double;
    PrecoUnitario: Currency;
    PrecoTotal: Currency;
    // Campos de desconto
    DescontoPercentual: Double;
    DescontoValor: Currency;
    PrecoFinal: Currency;
    // Campos opcionais
    CodigoInterno: string;
    NCM: string;
    CEST: string;
    Lote: string;
    Validade: TDate;
  end;
  
  /// <summary>Desconto retornado por produto</summary>
  TPBMDescontoProduto = record
    EAN: string;
    Descricao: string;
    DescontoPercentual: Double;
    DescontoValor: Currency;
    PrecoOriginal: Currency;
    PrecoFinal: Currency;
    Elegivel: Boolean;
    MotivoNaoElegivel: string;
  end;
  
  /// <summary>Dados da receita médica</summary>
  TPBMReceita = record
    CRM: string;
    UF: string;
    NomeMedico: string;
    DataReceita: TDate;
    TipoReceita: string; // SIMPLES, ESPECIAL, etc
  end;
  
  /// <summary>Lista de produtos para autorização</summary>
  TPBMProdutos = class
  private
    FItems: TArray<TPBMProduto>;
    function GetCount: Integer;
    function GetItem(Index: Integer): TPBMProduto;
    procedure SetItem(Index: Integer; const AValue: TPBMProduto);
    function GetValorTotal: Currency;
    function GetValorDesconto: Currency;
    function GetValorLiquido: Currency;
  public
    constructor Create;
    
    procedure Clear;
    procedure Add(const AProduto: TPBMProduto); overload;
    procedure Add(const AEAN, ADescricao: string; AQuantidade: Double; 
      APrecoUnitario: Currency); overload;
    procedure Delete(AIndex: Integer);
    function ToArray: TArray<TPBMProduto>;
    
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPBMProduto read GetItem write SetItem; default;
    property ValorTotal: Currency read GetValorTotal;
    property ValorDesconto: Currency read GetValorDesconto;
    property ValorLiquido: Currency read GetValorLiquido;
  end;
  
  {$ENDREGION}

  {$REGION 'Interface de Configuração'}
  
  /// <summary>Interface de configuração do client PBM</summary>
  IPBMConfig = interface
    ['{A0000002-0000-0000-0000-000000000002}']
    // Ambiente
    function GetHomologacao: Boolean;
    procedure SetHomologacao(AValue: Boolean);
    function GetBaseURL: string;
    procedure SetBaseURL(const AValue: string);
    
    // Credenciais
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
    
    // Timeouts
    function GetTimeout: Integer;
    procedure SetTimeout(AValue: Integer);
    function GetRetryCount: Integer;
    procedure SetRetryCount(AValue: Integer);
    function GetRetryDelay: Integer;
    procedure SetRetryDelay(AValue: Integer);
    
    // Eventos
    function GetOnLog: TPBMLogEvent;
    procedure SetOnLog(AValue: TPBMLogEvent);
    function GetOnStatus: TPBMStatusEvent;
    procedure SetOnStatus(AValue: TPBMStatusEvent);
    
    // Properties
    property Homologacao: Boolean read GetHomologacao write SetHomologacao;
    property BaseURL: string read GetBaseURL write SetBaseURL;
    property ClientID: string read GetClientID write SetClientID;
    property ClientSecret: string read GetClientSecret write SetClientSecret;
    property CodEstabelecimento: string read GetCodEstabelecimento write SetCodEstabelecimento;
    property Usuario: string read GetUsuario write SetUsuario;
    property Senha: string read GetSenha write SetSenha;
    property APIKey: string read GetAPIKey write SetAPIKey;
    property Timeout: Integer read GetTimeout write SetTimeout;
    property RetryCount: Integer read GetRetryCount write SetRetryCount;
    property RetryDelay: Integer read GetRetryDelay write SetRetryDelay;
    property OnLog: TPBMLogEvent read GetOnLog write SetOnLog;
    property OnStatus: TPBMStatusEvent read GetOnStatus write SetOnStatus;
  end;
  
  {$ENDREGION}

  {$REGION 'Interface de Beneficiário'}
  
  /// <summary>Interface para dados do beneficiário</summary>
  IPBMBeneficiario = interface
    ['{A0000003-0000-0000-0000-000000000003}']
    function GetCarteirinha: string;
    procedure SetCarteirinha(const AValue: string);
    function GetCPF: string;
    procedure SetCPF(const AValue: string);
    function GetNome: string;
    procedure SetNome(const AValue: string);
    function GetDataNascimento: TDate;
    procedure SetDataNascimento(AValue: TDate);
    function GetSexo: string;
    procedure SetSexo(const AValue: string);
    function GetTelefone: string;
    procedure SetTelefone(const AValue: string);
    function GetEmail: string;
    procedure SetEmail(const AValue: string);
    function GetPlano: string;
    procedure SetPlano(const AValue: string);
    function GetMatricula: string;
    procedure SetMatricula(const AValue: string);
    function GetElegivel: Boolean;
    procedure SetElegivel(AValue: Boolean);
    function GetMensagem: string;
    procedure SetMensagem(const AValue: string);
    
    property Carteirinha: string read GetCarteirinha write SetCarteirinha;
    property CPF: string read GetCPF write SetCPF;
    property Nome: string read GetNome write SetNome;
    property DataNascimento: TDate read GetDataNascimento write SetDataNascimento;
    property Sexo: string read GetSexo write SetSexo;
    property Telefone: string read GetTelefone write SetTelefone;
    property Email: string read GetEmail write SetEmail;
    property Plano: string read GetPlano write SetPlano;
    property Matricula: string read GetMatricula write SetMatricula;
    property Elegivel: Boolean read GetElegivel write SetElegivel;
    property Mensagem: string read GetMensagem write SetMensagem;
  end;
  
  {$ENDREGION}

  {$REGION 'Interfaces de Retorno'}
  
  /// <summary>Interface base para todos os resultados de operações PBM</summary>
  IPBMResultado = interface
    ['{A0000001-0000-0000-0000-000000000001}']
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetCodigoHTTP: Integer;
    
    property Sucesso: Boolean read GetSucesso;
    property Mensagem: string read GetMensagem;
    property CodigoErro: string read GetCodigoErro;
    property CodigoHTTP: Integer read GetCodigoHTTP;
  end;
  
  /// <summary>Resultado de consulta de elegibilidade</summary>
  IPBMElegibilidade = interface(IPBMResultado)
    ['{A1111111-1111-1111-1111-111111111111}']
    function GetNomeBeneficiario: string;
    function GetPlano: string;
    function GetElegivel: Boolean;
    function GetDescontos: TArray<TPBMDescontoProduto>;
    function GetSaldoPontos: Integer;
    
    property NomeBeneficiario: string read GetNomeBeneficiario;
    property Plano: string read GetPlano;
    property Elegivel: Boolean read GetElegivel;
    property Descontos: TArray<TPBMDescontoProduto> read GetDescontos;
    property SaldoPontos: Integer read GetSaldoPontos;
  end;
  
  /// <summary>Resultado de autorização de venda</summary>
  IPBMAutorizacao = interface(IPBMResultado)
    ['{A2222222-2222-2222-2222-222222222222}']
    function GetNSU: string;
    function GetCodigoAutorizacao: string;
    function GetProtocolo: string;
    function GetNomeBeneficiario: string;
    function GetValorDesconto: Currency;
    function GetValorSubsidio: Currency;
    function GetValorLiquido: Currency;
    function GetPontosCredito: Integer;
    function GetPontosDebito: Integer;
    function GetSaldoPontos: Integer;
    
    property NSU: string read GetNSU;
    property CodigoAutorizacao: string read GetCodigoAutorizacao;
    property Protocolo: string read GetProtocolo;
    property NomeBeneficiario: string read GetNomeBeneficiario;
    property ValorDesconto: Currency read GetValorDesconto;
    property ValorSubsidio: Currency read GetValorSubsidio;
    property ValorLiquido: Currency read GetValorLiquido;
    property PontosCredito: Integer read GetPontosCredito;
    property PontosDebito: Integer read GetPontosDebito;
    property SaldoPontos: Integer read GetSaldoPontos;
  end;
  
  /// <summary>Resultado de cancelamento</summary>
  IPBMCancelamento = interface(IPBMResultado)
    ['{A3333333-3333-3333-3333-333333333333}']
    function GetProtocoloCancelamento: string;
    function GetDataCancelamento: TDateTime;
    
    property ProtocoloCancelamento: string read GetProtocoloCancelamento;
    property DataCancelamento: TDateTime read GetDataCancelamento;
  end;
  
  /// <summary>Resultado de consulta de transação</summary>
  IPBMConsultaTransacao = interface(IPBMResultado)
    ['{A4444444-4444-4444-4444-444444444444}']
    function GetNSU: string;
    function GetStatus: string;
    function GetDataTransacao: TDateTime;
    function GetValorBruto: Currency;
    function GetValorDesconto: Currency;
    function GetValorLiquido: Currency;
    
    property NSU: string read GetNSU;
    property Status: string read GetStatus;
    property DataTransacao: TDateTime read GetDataTransacao;
    property ValorBruto: Currency read GetValorBruto;
    property ValorDesconto: Currency read GetValorDesconto;
    property ValorLiquido: Currency read GetValorLiquido;
  end;
  
  {$ENDREGION}

  {$REGION 'Interface Principal'}
  
  /// <summary>Interface principal do client PBM</summary>
  IPBMClient = interface
    ['{A0000000-0000-0000-0000-000000000000}']
    
    // Configuração
    procedure SetAmbiente(AHomologacao: Boolean);
    function GetAmbiente: Boolean;
    function GetNomeOperadora: string;
    function GetCodigoOperadora: string;
    
    /// <summary>Consulta elegibilidade do beneficiário</summary>
    /// <param name="ACarteirinha">Número da carteirinha</param>
    /// <param name="ACPF">CPF do beneficiário</param>
    /// <param name="ADataNascimento">Data de nascimento</param>
    function ConsultarElegibilidade(
      const ACarteirinha, ACPF: string;
      ADataNascimento: TDate
    ): IPBMElegibilidade; overload;
    
    /// <summary>Consulta elegibilidade com produtos</summary>
    function ConsultarElegibilidade(
      const ACarteirinha, ACPF: string;
      ADataNascimento: TDate;
      const AProdutos: TArray<TPBMProduto>
    ): IPBMElegibilidade; overload;
    
    /// <summary>Autoriza venda PBM</summary>
    /// <param name="ACarteirinha">Número da carteirinha</param>
    /// <param name="ACPF">CPF do beneficiário</param>
    /// <param name="ADataNascimento">Data de nascimento</param>
    /// <param name="AProdutos">Array de produtos</param>
    /// <param name="AValorTotal">Valor total da venda</param>
    /// <param name="ATransacaoID">ID único da transação (NSU interno)</param>
    function AutorizarVenda(
      const ACarteirinha, ACPF: string;
      ADataNascimento: TDate;
      const AProdutos: TArray<TPBMProduto>;
      AValorTotal: Currency;
      const ATransacaoID: string
    ): IPBMAutorizacao; overload;
    
    /// <summary>Autoriza venda com receita</summary>
    function AutorizarVenda(
      const ACarteirinha, ACPF: string;
      ADataNascimento: TDate;
      const AProdutos: TArray<TPBMProduto>;
      AValorTotal: Currency;
      const ATransacaoID: string;
      const AReceita: TPBMReceita
    ): IPBMAutorizacao; overload;
    
    /// <summary>Cancela uma venda autorizada</summary>
    /// <param name="ANSU">NSU da autorização original</param>
    /// <param name="ACodigoAutorizacao">Código de autorização original</param>
    /// <param name="AMotivo">Motivo do cancelamento</param>
    function CancelarVenda(
      const ANSU, ACodigoAutorizacao, AMotivo: string
    ): IPBMCancelamento;
    
    /// <summary>Consulta status de uma transação</summary>
    /// <param name="ANSU">NSU da transação</param>
    function ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao;
    
    // Properties
    property Homologacao: Boolean read GetAmbiente write SetAmbiente;
    property NomeOperadora: string read GetNomeOperadora;
    property CodigoOperadora: string read GetCodigoOperadora;
  end;
  
  {$ENDREGION}

  {$REGION 'Implementações Base'}
  
  /// <summary>Implementação base de configuração</summary>
  TPBMConfig = class(TInterfacedObject, IPBMConfig)
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
    
    // IPBMConfig
    function GetHomologacao: Boolean;
    procedure SetHomologacao(AValue: Boolean);
    function GetBaseURL: string;
    procedure SetBaseURL(const AValue: string);
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
    function GetTimeout: Integer;
    procedure SetTimeout(AValue: Integer);
    function GetRetryCount: Integer;
    procedure SetRetryCount(AValue: Integer);
    function GetRetryDelay: Integer;
    procedure SetRetryDelay(AValue: Integer);
    function GetOnLog: TPBMLogEvent;
    procedure SetOnLog(AValue: TPBMLogEvent);
    function GetOnStatus: TPBMStatusEvent;
    procedure SetOnStatus(AValue: TPBMStatusEvent);
    
    // Helper para disparar log
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
  
  /// <summary>Implementação base de beneficiário</summary>
  TPBMBeneficiario = class(TInterfacedObject, IPBMBeneficiario)
  private
    FCarteirinha: string;
    FCPF: string;
    FNome: string;
    FDataNascimento: TDate;
    FSexo: string;
    FTelefone: string;
    FEmail: string;
    FPlano: string;
    FMatricula: string;
    FElegivel: Boolean;
    FMensagem: string;
  public
    constructor Create; overload;
    constructor Create(const ACPF: string; ADataNascimento: TDate); overload;
    constructor Create(const ACarteirinha, ACPF: string; ADataNascimento: TDate); overload;
    
    // IPBMBeneficiario
    function GetCarteirinha: string;
    procedure SetCarteirinha(const AValue: string);
    function GetCPF: string;
    procedure SetCPF(const AValue: string);
    function GetNome: string;
    procedure SetNome(const AValue: string);
    function GetDataNascimento: TDate;
    procedure SetDataNascimento(AValue: TDate);
    function GetSexo: string;
    procedure SetSexo(const AValue: string);
    function GetTelefone: string;
    procedure SetTelefone(const AValue: string);
    function GetEmail: string;
    procedure SetEmail(const AValue: string);
    function GetPlano: string;
    procedure SetPlano(const AValue: string);
    function GetMatricula: string;
    procedure SetMatricula(const AValue: string);
    function GetElegivel: Boolean;
    procedure SetElegivel(AValue: Boolean);
    function GetMensagem: string;
    procedure SetMensagem(const AValue: string);
    
    // Properties
    property Carteirinha: string read FCarteirinha write FCarteirinha;
    property CPF: string read FCPF write FCPF;
    property Nome: string read FNome write FNome;
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
    property Sexo: string read FSexo write FSexo;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
    property Plano: string read FPlano write FPlano;
    property Matricula: string read FMatricula write FMatricula;
    property Elegivel: Boolean read FElegivel write FElegivel;
    property Mensagem: string read FMensagem write FMensagem;
  end;
  
  /// <summary>Implementação base de resultado</summary>
  TPBMResultado = class(TInterfacedObject, IPBMResultado)
  protected
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
    FCodigoHTTP: Integer;
  public
    function GetSucesso: Boolean; virtual;
    function GetMensagem: string; virtual;
    function GetCodigoErro: string; virtual;
    function GetCodigoHTTP: Integer; virtual;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
    property CodigoHTTP: Integer read FCodigoHTTP write FCodigoHTTP;
  end;
  
  /// <summary>Implementação base de elegibilidade</summary>
  TPBMElegibilidade = class(TPBMResultado, IPBMElegibilidade)
  private
    FNomeBeneficiario: string;
    FPlano: string;
    FElegivel: Boolean;
    FDescontos: TArray<TPBMDescontoProduto>;
    FSaldoPontos: Integer;
  public
    function GetNomeBeneficiario: string;
    function GetPlano: string;
    function GetElegivel: Boolean;
    function GetDescontos: TArray<TPBMDescontoProduto>;
    function GetSaldoPontos: Integer;
    
    property NomeBeneficiario: string read FNomeBeneficiario write FNomeBeneficiario;
    property Plano: string read FPlano write FPlano;
    property Elegivel: Boolean read FElegivel write FElegivel;
    property Descontos: TArray<TPBMDescontoProduto> read FDescontos write FDescontos;
    property SaldoPontos: Integer read FSaldoPontos write FSaldoPontos;
  end;
  
  /// <summary>Implementação base de autorização</summary>
  TPBMAutorizacao = class(TPBMResultado, IPBMAutorizacao)
  private
    FNSU: string;
    FCodigoAutorizacao: string;
    FProtocolo: string;
    FNomeBeneficiario: string;
    FValorDesconto: Currency;
    FValorSubsidio: Currency;
    FValorLiquido: Currency;
    FPontosCredito: Integer;
    FPontosDebito: Integer;
    FSaldoPontos: Integer;
  public
    function GetNSU: string;
    function GetCodigoAutorizacao: string;
    function GetProtocolo: string;
    function GetNomeBeneficiario: string;
    function GetValorDesconto: Currency;
    function GetValorSubsidio: Currency;
    function GetValorLiquido: Currency;
    function GetPontosCredito: Integer;
    function GetPontosDebito: Integer;
    function GetSaldoPontos: Integer;
    
    property NSU: string read FNSU write FNSU;
    property CodigoAutorizacao: string read FCodigoAutorizacao write FCodigoAutorizacao;
    property Protocolo: string read FProtocolo write FProtocolo;
    property NomeBeneficiario: string read FNomeBeneficiario write FNomeBeneficiario;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property ValorSubsidio: Currency read FValorSubsidio write FValorSubsidio;
    property ValorLiquido: Currency read FValorLiquido write FValorLiquido;
    property PontosCredito: Integer read FPontosCredito write FPontosCredito;
    property PontosDebito: Integer read FPontosDebito write FPontosDebito;
    property SaldoPontos: Integer read FSaldoPontos write FSaldoPontos;
  end;
  
  /// <summary>Implementação base de cancelamento</summary>
  TPBMCancelamento = class(TPBMResultado, IPBMCancelamento)
  private
    FProtocoloCancelamento: string;
    FDataCancelamento: TDateTime;
  public
    function GetProtocoloCancelamento: string;
    function GetDataCancelamento: TDateTime;
    
    property ProtocoloCancelamento: string read FProtocoloCancelamento write FProtocoloCancelamento;
    property DataCancelamento: TDateTime read FDataCancelamento write FDataCancelamento;
  end;
  
  /// <summary>Implementação base de consulta</summary>
  TPBMConsultaTransacao = class(TPBMResultado, IPBMConsultaTransacao)
  private
    FNSU: string;
    FStatus: string;
    FDataTransacao: TDateTime;
    FValorBruto: Currency;
    FValorDesconto: Currency;
    FValorLiquido: Currency;
  public
    function GetNSU: string;
    function GetStatus: string;
    function GetDataTransacao: TDateTime;
    function GetValorBruto: Currency;
    function GetValorDesconto: Currency;
    function GetValorLiquido: Currency;
    
    property NSU: string read FNSU write FNSU;
    property Status: string read FStatus write FStatus;
    property DataTransacao: TDateTime read FDataTransacao write FDataTransacao;
    property ValorBruto: Currency read FValorBruto write FValorBruto;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property ValorLiquido: Currency read FValorLiquido write FValorLiquido;
  end;
  
  {$ENDREGION}

implementation

{ TPBMConfig }

constructor TPBMConfig.Create;
begin
  inherited Create;
  FHomologacao := True;
  FTimeout := 30000; // 30 segundos
  FRetryCount := 3;
  FRetryDelay := 500; // 500ms
end;

function TPBMConfig.GetHomologacao: Boolean;
begin
  Result := FHomologacao;
end;

procedure TPBMConfig.SetHomologacao(AValue: Boolean);
begin
  FHomologacao := AValue;
end;

function TPBMConfig.GetBaseURL: string;
begin
  Result := FBaseURL;
end;

procedure TPBMConfig.SetBaseURL(const AValue: string);
begin
  FBaseURL := AValue;
end;

function TPBMConfig.GetClientID: string;
begin
  Result := FClientID;
end;

procedure TPBMConfig.SetClientID(const AValue: string);
begin
  FClientID := AValue;
end;

function TPBMConfig.GetClientSecret: string;
begin
  Result := FClientSecret;
end;

procedure TPBMConfig.SetClientSecret(const AValue: string);
begin
  FClientSecret := AValue;
end;

function TPBMConfig.GetCodEstabelecimento: string;
begin
  Result := FCodEstabelecimento;
end;

procedure TPBMConfig.SetCodEstabelecimento(const AValue: string);
begin
  FCodEstabelecimento := AValue;
end;

function TPBMConfig.GetUsuario: string;
begin
  Result := FUsuario;
end;

procedure TPBMConfig.SetUsuario(const AValue: string);
begin
  FUsuario := AValue;
end;

function TPBMConfig.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TPBMConfig.SetSenha(const AValue: string);
begin
  FSenha := AValue;
end;

function TPBMConfig.GetAPIKey: string;
begin
  Result := FAPIKey;
end;

procedure TPBMConfig.SetAPIKey(const AValue: string);
begin
  FAPIKey := AValue;
end;

function TPBMConfig.GetTimeout: Integer;
begin
  Result := FTimeout;
end;

procedure TPBMConfig.SetTimeout(AValue: Integer);
begin
  FTimeout := AValue;
end;

function TPBMConfig.GetRetryCount: Integer;
begin
  Result := FRetryCount;
end;

procedure TPBMConfig.SetRetryCount(AValue: Integer);
begin
  FRetryCount := AValue;
end;

function TPBMConfig.GetRetryDelay: Integer;
begin
  Result := FRetryDelay;
end;

procedure TPBMConfig.SetRetryDelay(AValue: Integer);
begin
  FRetryDelay := AValue;
end;

function TPBMConfig.GetOnLog: TPBMLogEvent;
begin
  Result := FOnLog;
end;

procedure TPBMConfig.SetOnLog(AValue: TPBMLogEvent);
begin
  FOnLog := AValue;
end;

function TPBMConfig.GetOnStatus: TPBMStatusEvent;
begin
  Result := FOnStatus;
end;

procedure TPBMConfig.SetOnStatus(AValue: TPBMStatusEvent);
begin
  FOnStatus := AValue;
end;

procedure TPBMConfig.DoLog(ATipo: TPBMLogTipo; const AMensagem, ADetalhes: string);
begin
  if Assigned(FOnLog) then
    FOnLog(Self, ATipo, AMensagem, ADetalhes);
end;

procedure TPBMConfig.DoStatus(AStatus: TPBMStatus; const AMensagem: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Self, AStatus, AMensagem);
end;

{ TPBMBeneficiario }

constructor TPBMBeneficiario.Create;
begin
  inherited Create;
  FElegivel := False;
end;

constructor TPBMBeneficiario.Create(const ACPF: string; ADataNascimento: TDate);
begin
  Create;
  FCPF := ACPF;
  FDataNascimento := ADataNascimento;
end;

constructor TPBMBeneficiario.Create(const ACarteirinha, ACPF: string; ADataNascimento: TDate);
begin
  Create(ACPF, ADataNascimento);
  FCarteirinha := ACarteirinha;
end;

function TPBMBeneficiario.GetCarteirinha: string;
begin
  Result := FCarteirinha;
end;

procedure TPBMBeneficiario.SetCarteirinha(const AValue: string);
begin
  FCarteirinha := AValue;
end;

function TPBMBeneficiario.GetCPF: string;
begin
  Result := FCPF;
end;

procedure TPBMBeneficiario.SetCPF(const AValue: string);
begin
  FCPF := AValue;
end;

function TPBMBeneficiario.GetNome: string;
begin
  Result := FNome;
end;

procedure TPBMBeneficiario.SetNome(const AValue: string);
begin
  FNome := AValue;
end;

function TPBMBeneficiario.GetDataNascimento: TDate;
begin
  Result := FDataNascimento;
end;

procedure TPBMBeneficiario.SetDataNascimento(AValue: TDate);
begin
  FDataNascimento := AValue;
end;

function TPBMBeneficiario.GetSexo: string;
begin
  Result := FSexo;
end;

procedure TPBMBeneficiario.SetSexo(const AValue: string);
begin
  FSexo := AValue;
end;

function TPBMBeneficiario.GetTelefone: string;
begin
  Result := FTelefone;
end;

procedure TPBMBeneficiario.SetTelefone(const AValue: string);
begin
  FTelefone := AValue;
end;

function TPBMBeneficiario.GetEmail: string;
begin
  Result := FEmail;
end;

procedure TPBMBeneficiario.SetEmail(const AValue: string);
begin
  FEmail := AValue;
end;

function TPBMBeneficiario.GetPlano: string;
begin
  Result := FPlano;
end;

procedure TPBMBeneficiario.SetPlano(const AValue: string);
begin
  FPlano := AValue;
end;

function TPBMBeneficiario.GetMatricula: string;
begin
  Result := FMatricula;
end;

procedure TPBMBeneficiario.SetMatricula(const AValue: string);
begin
  FMatricula := AValue;
end;

function TPBMBeneficiario.GetElegivel: Boolean;
begin
  Result := FElegivel;
end;

procedure TPBMBeneficiario.SetElegivel(AValue: Boolean);
begin
  FElegivel := AValue;
end;

function TPBMBeneficiario.GetMensagem: string;
begin
  Result := FMensagem;
end;

procedure TPBMBeneficiario.SetMensagem(const AValue: string);
begin
  FMensagem := AValue;
end;

{ TPBMProdutos }

constructor TPBMProdutos.Create;
begin
  inherited Create;
  SetLength(FItems, 0);
end;

procedure TPBMProdutos.Clear;
begin
  SetLength(FItems, 0);
end;

function TPBMProdutos.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TPBMProdutos.GetItem(Index: Integer): TPBMProduto;
begin
  Result := FItems[Index];
end;

procedure TPBMProdutos.SetItem(Index: Integer; const AValue: TPBMProduto);
begin
  FItems[Index] := AValue;
end;

procedure TPBMProdutos.Add(const AProduto: TPBMProduto);
begin
  SetLength(FItems, Length(FItems) + 1);
  FItems[High(FItems)] := AProduto;
end;

procedure TPBMProdutos.Add(const AEAN, ADescricao: string; AQuantidade: Double;
  APrecoUnitario: Currency);
var
  LProduto: TPBMProduto;
begin
  LProduto.EAN := AEAN;
  LProduto.Descricao := ADescricao;
  LProduto.Quantidade := AQuantidade;
  LProduto.PrecoUnitario := APrecoUnitario;
  LProduto.PrecoTotal := AQuantidade * APrecoUnitario;
  LProduto.DescontoPercentual := 0;
  LProduto.DescontoValor := 0;
  LProduto.PrecoFinal := LProduto.PrecoTotal;
  Add(LProduto);
end;

procedure TPBMProdutos.Delete(AIndex: Integer);
var
  I: Integer;
begin
  if (AIndex < 0) or (AIndex >= Length(FItems)) then
    Exit;
    
  for I := AIndex to High(FItems) - 1 do
    FItems[I] := FItems[I + 1];
    
  SetLength(FItems, Length(FItems) - 1);
end;

function TPBMProdutos.ToArray: TArray<TPBMProduto>;
begin
  Result := FItems;
end;

function TPBMProdutos.GetValorTotal: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(FItems) do
    Result := Result + FItems[I].PrecoTotal;
end;

function TPBMProdutos.GetValorDesconto: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(FItems) do
    Result := Result + FItems[I].DescontoValor;
end;

function TPBMProdutos.GetValorLiquido: Currency;
begin
  Result := GetValorTotal - GetValorDesconto;
end;

{ TPBMResultado }

function TPBMResultado.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMResultado.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMResultado.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

function TPBMResultado.GetCodigoHTTP: Integer;
begin
  Result := FCodigoHTTP;
end;

{ TPBMElegibilidade }

function TPBMElegibilidade.GetNomeBeneficiario: string;
begin
  Result := FNomeBeneficiario;
end;

function TPBMElegibilidade.GetPlano: string;
begin
  Result := FPlano;
end;

function TPBMElegibilidade.GetElegivel: Boolean;
begin
  Result := FElegivel;
end;

function TPBMElegibilidade.GetDescontos: TArray<TPBMDescontoProduto>;
begin
  Result := FDescontos;
end;

function TPBMElegibilidade.GetSaldoPontos: Integer;
begin
  Result := FSaldoPontos;
end;

{ TPBMAutorizacao }

function TPBMAutorizacao.GetNSU: string;
begin
  Result := FNSU;
end;

function TPBMAutorizacao.GetCodigoAutorizacao: string;
begin
  Result := FCodigoAutorizacao;
end;

function TPBMAutorizacao.GetProtocolo: string;
begin
  Result := FProtocolo;
end;

function TPBMAutorizacao.GetNomeBeneficiario: string;
begin
  Result := FNomeBeneficiario;
end;

function TPBMAutorizacao.GetValorDesconto: Currency;
begin
  Result := FValorDesconto;
end;

function TPBMAutorizacao.GetValorSubsidio: Currency;
begin
  Result := FValorSubsidio;
end;

function TPBMAutorizacao.GetValorLiquido: Currency;
begin
  Result := FValorLiquido;
end;

function TPBMAutorizacao.GetPontosCredito: Integer;
begin
  Result := FPontosCredito;
end;

function TPBMAutorizacao.GetPontosDebito: Integer;
begin
  Result := FPontosDebito;
end;

function TPBMAutorizacao.GetSaldoPontos: Integer;
begin
  Result := FSaldoPontos;
end;

{ TPBMCancelamento }

function TPBMCancelamento.GetProtocoloCancelamento: string;
begin
  Result := FProtocoloCancelamento;
end;

function TPBMCancelamento.GetDataCancelamento: TDateTime;
begin
  Result := FDataCancelamento;
end;

{ TPBMConsultaTransacao }

function TPBMConsultaTransacao.GetNSU: string;
begin
  Result := FNSU;
end;

function TPBMConsultaTransacao.GetStatus: string;
begin
  Result := FStatus;
end;

function TPBMConsultaTransacao.GetDataTransacao: TDateTime;
begin
  Result := FDataTransacao;
end;

function TPBMConsultaTransacao.GetValorBruto: Currency;
begin
  Result := FValorBruto;
end;

function TPBMConsultaTransacao.GetValorDesconto: Currency;
begin
  Result := FValorDesconto;
end;

function TPBMConsultaTransacao.GetValorLiquido: Currency;
begin
  Result := FValorLiquido;
end;

end.
