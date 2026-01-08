unit uPBM.Results;

{******************************************************************************
  PBM Results - Implementações de resultados para uso nas operadoras
  
  Classes concretas que implementam IPBMElegibilidade, IPBMAutorizacao,
  IPBMCancelamento e IPBMConsultaTransacao para uso nas operadoras.
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

interface

uses
  System.SysUtils, System.Classes,
  uPBM.Interfaces;

type
  /// <summary>Implementação concreta de elegibilidade</summary>
  TPBMElegibilidadeResult = class(TInterfacedObject, IPBMResultado, IPBMElegibilidade)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
    FCodigoHTTP: Integer;
    FNomeBeneficiario: string;
    FPlano: string;
    FElegivel: Boolean;
    FDescontos: TArray<TPBMDescontoProduto>;
    FSaldoPontos: Integer;
  public
    constructor Create;
    
    // IPBMResultado
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetCodigoHTTP: Integer;
    
    // IPBMElegibilidade
    function GetNomeBeneficiario: string;
    function GetPlano: string;
    function GetElegivel: Boolean;
    function GetDescontos: TArray<TPBMDescontoProduto>;
    function GetSaldoPontos: Integer;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
    property CodigoHTTP: Integer read FCodigoHTTP write FCodigoHTTP;
    property NomeBeneficiario: string read FNomeBeneficiario write FNomeBeneficiario;
    property Plano: string read FPlano write FPlano;
    property Elegivel: Boolean read FElegivel write FElegivel;
    property Descontos: TArray<TPBMDescontoProduto> read FDescontos write FDescontos;
    property SaldoPontos: Integer read FSaldoPontos write FSaldoPontos;
  end;

  /// <summary>Implementação concreta de autorização</summary>
  TPBMAutorizacaoResult = class(TInterfacedObject, IPBMResultado, IPBMAutorizacao)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
    FCodigoHTTP: Integer;
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
    constructor Create;
    
    // IPBMResultado
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetCodigoHTTP: Integer;
    
    // IPBMAutorizacao
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
    property CodigoHTTP: Integer read FCodigoHTTP write FCodigoHTTP;
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

  /// <summary>Implementação concreta de cancelamento</summary>
  TPBMCancelamentoResult = class(TInterfacedObject, IPBMResultado, IPBMCancelamento)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
    FCodigoHTTP: Integer;
    FProtocoloCancelamento: string;
    FDataCancelamento: TDateTime;
  public
    constructor Create;
    
    // IPBMResultado
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetCodigoHTTP: Integer;
    
    // IPBMCancelamento
    function GetProtocoloCancelamento: string;
    function GetDataCancelamento: TDateTime;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
    property CodigoHTTP: Integer read FCodigoHTTP write FCodigoHTTP;
    property ProtocoloCancelamento: string read FProtocoloCancelamento write FProtocoloCancelamento;
    property DataCancelamento: TDateTime read FDataCancelamento write FDataCancelamento;
  end;

  /// <summary>Implementação concreta de consulta de transação</summary>
  TPBMConsultaResult = class(TInterfacedObject, IPBMResultado, IPBMConsultaTransacao)
  private
    FSucesso: Boolean;
    FMensagem: string;
    FCodigoErro: string;
    FCodigoHTTP: Integer;
    FNSU: string;
    FStatus: string;
    FDataTransacao: TDateTime;
    FValorBruto: Currency;
    FValorDesconto: Currency;
    FValorLiquido: Currency;
  public
    constructor Create;
    
    // IPBMResultado
    function GetSucesso: Boolean;
    function GetMensagem: string;
    function GetCodigoErro: string;
    function GetCodigoHTTP: Integer;
    
    // IPBMConsultaTransacao
    function GetNSU: string;
    function GetStatus: string;
    function GetDataTransacao: TDateTime;
    function GetValorBruto: Currency;
    function GetValorDesconto: Currency;
    function GetValorLiquido: Currency;
    
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
    property CodigoErro: string read FCodigoErro write FCodigoErro;
    property CodigoHTTP: Integer read FCodigoHTTP write FCodigoHTTP;
    property NSU: string read FNSU write FNSU;
    property Status: string read FStatus write FStatus;
    property DataTransacao: TDateTime read FDataTransacao write FDataTransacao;
    property ValorBruto: Currency read FValorBruto write FValorBruto;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property ValorLiquido: Currency read FValorLiquido write FValorLiquido;
  end;

implementation

{ TPBMElegibilidadeResult }

constructor TPBMElegibilidadeResult.Create;
begin
  inherited Create;
  FSucesso := False;
  FElegivel := False;
  FSaldoPontos := 0;
end;

function TPBMElegibilidadeResult.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMElegibilidadeResult.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMElegibilidadeResult.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

function TPBMElegibilidadeResult.GetCodigoHTTP: Integer;
begin
  Result := FCodigoHTTP;
end;

function TPBMElegibilidadeResult.GetNomeBeneficiario: string;
begin
  Result := FNomeBeneficiario;
end;

function TPBMElegibilidadeResult.GetPlano: string;
begin
  Result := FPlano;
end;

function TPBMElegibilidadeResult.GetElegivel: Boolean;
begin
  Result := FElegivel;
end;

function TPBMElegibilidadeResult.GetDescontos: TArray<TPBMDescontoProduto>;
begin
  Result := FDescontos;
end;

function TPBMElegibilidadeResult.GetSaldoPontos: Integer;
begin
  Result := FSaldoPontos;
end;

{ TPBMAutorizacaoResult }

constructor TPBMAutorizacaoResult.Create;
begin
  inherited Create;
  FSucesso := False;
  FValorDesconto := 0;
  FValorSubsidio := 0;
  FValorLiquido := 0;
  FPontosCredito := 0;
  FPontosDebito := 0;
  FSaldoPontos := 0;
end;

function TPBMAutorizacaoResult.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMAutorizacaoResult.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMAutorizacaoResult.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

function TPBMAutorizacaoResult.GetCodigoHTTP: Integer;
begin
  Result := FCodigoHTTP;
end;

function TPBMAutorizacaoResult.GetNSU: string;
begin
  Result := FNSU;
end;

function TPBMAutorizacaoResult.GetCodigoAutorizacao: string;
begin
  Result := FCodigoAutorizacao;
end;

function TPBMAutorizacaoResult.GetProtocolo: string;
begin
  Result := FProtocolo;
end;

function TPBMAutorizacaoResult.GetNomeBeneficiario: string;
begin
  Result := FNomeBeneficiario;
end;

function TPBMAutorizacaoResult.GetValorDesconto: Currency;
begin
  Result := FValorDesconto;
end;

function TPBMAutorizacaoResult.GetValorSubsidio: Currency;
begin
  Result := FValorSubsidio;
end;

function TPBMAutorizacaoResult.GetValorLiquido: Currency;
begin
  Result := FValorLiquido;
end;

function TPBMAutorizacaoResult.GetPontosCredito: Integer;
begin
  Result := FPontosCredito;
end;

function TPBMAutorizacaoResult.GetPontosDebito: Integer;
begin
  Result := FPontosDebito;
end;

function TPBMAutorizacaoResult.GetSaldoPontos: Integer;
begin
  Result := FSaldoPontos;
end;

{ TPBMCancelamentoResult }

constructor TPBMCancelamentoResult.Create;
begin
  inherited Create;
  FSucesso := False;
  FDataCancelamento := 0;
end;

function TPBMCancelamentoResult.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMCancelamentoResult.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMCancelamentoResult.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

function TPBMCancelamentoResult.GetCodigoHTTP: Integer;
begin
  Result := FCodigoHTTP;
end;

function TPBMCancelamentoResult.GetProtocoloCancelamento: string;
begin
  Result := FProtocoloCancelamento;
end;

function TPBMCancelamentoResult.GetDataCancelamento: TDateTime;
begin
  Result := FDataCancelamento;
end;

{ TPBMConsultaResult }

constructor TPBMConsultaResult.Create;
begin
  inherited Create;
  FSucesso := False;
  FDataTransacao := 0;
  FValorBruto := 0;
  FValorDesconto := 0;
  FValorLiquido := 0;
end;

function TPBMConsultaResult.GetSucesso: Boolean;
begin
  Result := FSucesso;
end;

function TPBMConsultaResult.GetMensagem: string;
begin
  Result := FMensagem;
end;

function TPBMConsultaResult.GetCodigoErro: string;
begin
  Result := FCodigoErro;
end;

function TPBMConsultaResult.GetCodigoHTTP: Integer;
begin
  Result := FCodigoHTTP;
end;

function TPBMConsultaResult.GetNSU: string;
begin
  Result := FNSU;
end;

function TPBMConsultaResult.GetStatus: string;
begin
  Result := FStatus;
end;

function TPBMConsultaResult.GetDataTransacao: TDateTime;
begin
  Result := FDataTransacao;
end;

function TPBMConsultaResult.GetValorBruto: Currency;
begin
  Result := FValorBruto;
end;

function TPBMConsultaResult.GetValorDesconto: Currency;
begin
  Result := FValorDesconto;
end;

function TPBMConsultaResult.GetValorLiquido: Currency;
begin
  Result := FValorLiquido;
end;

end.
