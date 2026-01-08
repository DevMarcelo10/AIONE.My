unit uPBM.Orizon;

{******************************************************************************
  PBM Orizon - Cliente para integração
  Protocolo: REST/JSON + API Key
  Tipo: Corporativo (PBM)
******************************************************************************}

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.DateUtils,
  System.Generics.Collections,
  uPBM.Interfaces, uPBM.Base, uPBM.Results;

type
  TOrizonClient = class(TPBMClientBase)
  private
    const
      URL_HOMOLOGACAO = 'https://hml.orizonbrasil.com.br/api/pbm/v1';
      URL_PRODUCAO = 'https://api.orizonbrasil.com.br/api/pbm/v1';
  protected
    function GetBaseURL: string; override;
    function ObterTokenInterno: string; override;
    function GetAuthHeaders: TArray<TPair<string,string>>; override;
  public
    constructor Create(const AClientID, AClientSecret, ACodEstabelecimento: string;
      AHomologacao: Boolean = True);
    
    function ConsultarElegibilidade(const ACarteirinha, ACPF: string;
      ADataNascimento: TDate): IPBMElegibilidade; overload; override;
    function ConsultarElegibilidade(const ACarteirinha, ACPF: string;
      ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade; overload; override;
    function AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate;
      const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency;
      const ATransacaoID: string): IPBMAutorizacao; overload; override;
    function AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate;
      const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency;
      const ATransacaoID: string; const AReceita: TPBMReceita): IPBMAutorizacao; overload; override;
    function CancelarVenda(const ANSU, ACodigoAutorizacao, AMotivo: string): IPBMCancelamento; override;
    function ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao; override;
  end;

implementation

constructor TOrizonClient.Create(const AClientID, AClientSecret, ACodEstabelecimento: string;
  AHomologacao: Boolean);
begin
  inherited Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
  FNomeOperadora := 'Orizon';
  FCodigoOperadora := 'ORIZON';
end;

function TOrizonClient.GetBaseURL: string;
begin
  if FHomologacao then Result := URL_HOMOLOGACAO else Result := URL_PRODUCAO;
end;

function TOrizonClient.ObterTokenInterno: string;
begin
  // Orizon usa API Key, não precisa de token OAuth
  Result := FConfig.APIKey;
  if Result = '' then
    Result := FConfig.ClientSecret;
end;

function TOrizonClient.GetAuthHeaders: TArray<TPair<string,string>>;
begin
  Result := [
    TPair<string,string>.Create('X-API-Key', FTokenManager.GetToken),
    TPair<string,string>.Create('Content-Type', 'application/json'),
    TPair<string,string>.Create('Accept', 'application/json')
  ];
end;

function TOrizonClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate): IPBMElegibilidade;
var
  LProdutos: TArray<TPBMProduto>;
begin
  SetLength(LProdutos, 0);
  Result := ConsultarElegibilidade(ACarteirinha, ACPF, ADataNascimento, LProdutos);
end;

function TOrizonClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade;
var
  LURL, LResponse: string;
  LResult: TPBMElegibilidadeResult;
  LJSON: TJSONObject;
begin
  LResult := TPBMElegibilidadeResult.Create;
  Result := LResult;
  
  try
    LURL := Format('%s/elegibilidade?carteirinha=%s&cpf=%s&dataNascimento=%s',
      [GetBaseURL, ACarteirinha, ACPF, FormatDateTime('yyyy-mm-dd', ADataNascimento)]);
    
    LResponse := FHTTPClient.Get(LURL, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := LJSON.GetValue<Boolean>('elegivel', False);
        LResult.Elegivel := LResult.Sucesso;
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        LResult.NomeBeneficiario := LJSON.GetValue<string>('nome', '');
        LResult.Plano := LJSON.GetValue<string>('plano', '');
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := E.Message;
    end;
  end;
end;

function TOrizonClient.AutorizarVenda(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>;
  AValorTotal: Currency; const ATransacaoID: string): IPBMAutorizacao;
var
  LReceita: TPBMReceita;
begin
  FillChar(LReceita, SizeOf(LReceita), 0);
  Result := AutorizarVenda(ACarteirinha, ACPF, ADataNascimento, AProdutos, AValorTotal, ATransacaoID, LReceita);
end;

function TOrizonClient.AutorizarVenda(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>;
  AValorTotal: Currency; const ATransacaoID: string;
  const AReceita: TPBMReceita): IPBMAutorizacao;
var
  LURL, LBody, LResponse: string;
  LResult: TPBMAutorizacaoResult;
  LJSON, LReq, LItem: TJSONObject;
  LItens: TJSONArray;
  I: Integer;
begin
  LResult := TPBMAutorizacaoResult.Create;
  Result := LResult;
  
  try
    LURL := GetBaseURL + '/autorizacao';
    
    LReq := TJSONObject.Create;
    try
      LReq.AddPair('carteirinha', ACarteirinha);
      LReq.AddPair('cpf', ACPF);
      LReq.AddPair('dataNascimento', FormatDateTime('yyyy-mm-dd', ADataNascimento));
      LReq.AddPair('codigoEstabelecimento', FConfig.CodEstabelecimento);
      LReq.AddPair('transacaoId', ATransacaoID);
      LReq.AddPair('valorTotal', TJSONNumber.Create(AValorTotal));
      
      LItens := TJSONArray.Create;
      for I := 0 to High(AProdutos) do
      begin
        LItem := TJSONObject.Create;
        LItem.AddPair('ean', AProdutos[I].EAN);
        LItem.AddPair('quantidade', TJSONNumber.Create(AProdutos[I].Quantidade));
        LItem.AddPair('precoUnitario', TJSONNumber.Create(AProdutos[I].PrecoUnitario));
        LItens.AddElement(LItem);
      end;
      LReq.AddPair('itens', LItens);
      LBody := LReq.ToJSON;
    finally
      LReq.Free;
    end;
    
    LResponse := FHTTPClient.Post(LURL, LBody, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := LJSON.GetValue<Boolean>('autorizado', False);
        LResult.NSU := LJSON.GetValue<string>('nsu', '');
        LResult.CodigoAutorizacao := LJSON.GetValue<string>('codigoAutorizacao', '');
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        LResult.ValorDesconto := LJSON.GetValue<Double>('valorDesconto', 0);
        LResult.ValorLiquido := LJSON.GetValue<Double>('valorLiquido', 0);
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := E.Message;
    end;
  end;
end;

function TOrizonClient.CancelarVenda(const ANSU, ACodigoAutorizacao, AMotivo: string): IPBMCancelamento;
var
  LURL, LBody, LResponse: string;
  LResult: TPBMCancelamentoResult;
  LJSON, LReq: TJSONObject;
begin
  LResult := TPBMCancelamentoResult.Create;
  Result := LResult;
  
  try
    LURL := GetBaseURL + '/cancelamento';
    LReq := TJSONObject.Create;
    try
      LReq.AddPair('nsu', ANSU);
      LReq.AddPair('codigoAutorizacao', ACodigoAutorizacao);
      LReq.AddPair('motivo', AMotivo);
      LBody := LReq.ToJSON;
    finally
      LReq.Free;
    end;
    
    LResponse := FHTTPClient.Post(LURL, LBody, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := LJSON.GetValue<Boolean>('cancelado', False);
        LResult.ProtocoloCancelamento := LJSON.GetValue<string>('protocolo', '');
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        if LResult.Sucesso then LResult.DataCancelamento := Now;
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := E.Message;
    end;
  end;
end;

function TOrizonClient.ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao;
var
  LURL, LResponse: string;
  LResult: TPBMConsultaResult;
  LJSON: TJSONObject;
begin
  LResult := TPBMConsultaResult.Create;
  Result := LResult;
  
  try
    LURL := GetBaseURL + '/transacao/' + ANSU;
    LResponse := FHTTPClient.Get(LURL, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := True;
        LResult.NSU := ANSU;
        LResult.Status := LJSON.GetValue<string>('status', '');
        LResult.ValorBruto := LJSON.GetValue<Double>('valorBruto', 0);
        LResult.ValorDesconto := LJSON.GetValue<Double>('valorDesconto', 0);
        LResult.ValorLiquido := LJSON.GetValue<Double>('valorLiquido', 0);
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := E.Message;
    end;
  end;
end;

end.
