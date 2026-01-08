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
  
  /// <summary>Produto para autorização</summary>
  TPBMProduto = record
    EAN: string;
    Descricao: string;
    Quantidade: Double;
    PrecoUnitario: Currency;
    PrecoTotal: Currency;
    // Campos opcionais
    CodigoInterno: string;
    NCM: string;
    CEST: string;
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
  
  {$ENDREGION}

  {$REGION 'Interfaces de Retorno'}
  
  /// <summary>Resultado de consulta de elegibilidade</summary>
  IPBMElegibilidade = interface
    ['{A1111111-1111-1111-1111-111111111111}']
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetNomeBeneficiario: string;
    function GetPlano: string;
    function GetElegivel: Boolean;
    function GetDescontos: TArray<TPBMDescontoProduto>;
    function GetSaldoPontos: Integer;
    
    property Sucesso: Boolean read GetSucesso;
    property Mensagem: string read GetMensagem;
    property CodigoErro: string read GetCodigoErro;
    property NomeBeneficiario: string read GetNomeBeneficiario;
    property Plano: string read GetPlano;
    property Elegivel: Boolean read GetElegivel;
    property Descontos: TArray<TPBMDescontoProduto> read GetDescontos;
    property SaldoPontos: Integer read GetSaldoPontos;
  end;
  
  /// <summary>Resultado de autorização de venda</summary>
  IPBMAutorizacao = interface
    ['{A2222222-2222-2222-2222-222222222222}']
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
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
    
    property Sucesso: Boolean read GetSucesso;
    property Mensagem: string read GetMensagem;
    property CodigoErro: string read GetCodigoErro;
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
  IPBMCancelamento = interface
    ['{A3333333-3333-3333-3333-333333333333}']
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetProtocoloCancelamento: string;
    function GetDataCancelamento: TDateTime;
    
    property Sucesso: Boolean read GetSucesso;
    property Mensagem: string read GetMensagem;
    property CodigoErro: string read GetCodigoErro;
    property ProtocoloCancelamento: string read GetProtocoloCancelamento;
    property DataCancelamento: TDateTime read GetDataCancelamento;
  end;
  
  /// <summary>Resultado de consulta de transação</summary>
  IPBMConsultaTransacao = interface
    ['{A4444444-4444-4444-4444-444444444444}']
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetNSU: string;
    function GetStatus: string;
    function GetDataTransacao: TDateTime;
    function GetValorBruto: Currency;
    function GetValorDesconto: Currency;
    function GetValorLiquido: Currency;
    
    property Sucesso: Boolean read GetSucesso;
    property Mensagem: string read GetMensagem;
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
  
  /// <summary>Implementação base de elegibilidade</summary>
  TPBMElegibilidade = class(TInterfacedObject, IPBMElegibilidade)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
    FNomeBeneficiario: string;
    FPlano: string;
    FElegivel: Boolean;
    FDescontos: TArray<TPBMDescontoProduto>;
    FSaldoPontos: Integer;
  public
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetNomeBeneficiario: string;
    function GetPlano: string;
    function GetElegivel: Boolean;
    function GetDescontos: TArray<TPBMDescontoProduto>;
    function GetSaldoPontos: Integer;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
    property NomeBeneficiario: string read FNomeBeneficiario write FNomeBeneficiario;
    property Plano: string read FPlano write FPlano;
    property Elegivel: Boolean read FElegivel write FElegivel;
    property Descontos: TArray<TPBMDescontoProduto> read FDescontos write FDescontos;
    property SaldoPontos: Integer read FSaldoPontos write FSaldoPontos;
  end;
  
  /// <summary>Implementação base de autorização</summary>
  TPBMAutorizacao = class(TInterfacedObject, IPBMAutorizacao)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
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
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
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
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
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
  TPBMCancelamento = class(TInterfacedObject, IPBMCancelamento)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
    FProtocoloCancelamento: string;
    FDataCancelamento: TDateTime;
  public
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetProtocoloCancelamento: string;
    function GetDataCancelamento: TDateTime;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
    property ProtocoloCancelamento: string read FProtocoloCancelamento write FProtocoloCancelamento;
    property DataCancelamento: TDateTime read FDataCancelamento write FDataCancelamento;
  end;
  
  /// <summary>Implementação base de consulta</summary>
  TPBMConsultaTransacao = class(TInterfacedObject, IPBMConsultaTransacao)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FNSU: string;
    FStatus: string;
    FDataTransacao: TDateTime;
    FValorBruto: Currency;
    FValorDesconto: Currency;
    FValorLiquido: Currency;
  public
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetNSU: string;
    function GetStatus: string;
    function GetDataTransacao: TDateTime;
    function GetValorBruto: Currency;
    function GetValorDesconto: Currency;
    function GetValorLiquido: Currency;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property NSU: string read FNSU write FNSU;
    property Status: string read FStatus write FStatus;
    property DataTransacao: TDateTime read FDataTransacao write FDataTransacao;
    property ValorBruto: Currency read FValorBruto write FValorBruto;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property ValorLiquido: Currency read FValorLiquido write FValorLiquido;
  end;
  
  {$ENDREGION}

implementation

{ TPBMElegibilidade }

function TPBMElegibilidade.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMElegibilidade.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMElegibilidade.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

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

function TPBMAutorizacao.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMAutorizacao.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMAutorizacao.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

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

function TPBMCancelamento.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMCancelamento.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMCancelamento.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

function TPBMCancelamento.GetProtocoloCancelamento: string;
begin
  Result := FProtocoloCancelamento;
end;

function TPBMCancelamento.GetDataCancelamento: TDateTime;
begin
  Result := FDataCancelamento;
end;

{ TPBMConsultaTransacao }

function TPBMConsultaTransacao.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMConsultaTransacao.GetMensagem: string;
begin
  Result := FMensagem;
end;

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
