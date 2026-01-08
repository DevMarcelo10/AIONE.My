unit uPBM.FuncionalCard;

{******************************************************************************
  PBM Funcional Card - Cliente para integração
  
  Protocolo: REST/JSON + JWT
  Tipo: Corporativo (PBM)
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.DateUtils,
  System.Generics.Collections, System.NetEncoding,
  uPBM.Interfaces, uPBM.Base, uPBM.Results;

type
  TFuncionalCardClient = class(TPBMClientBase)
  private
    const
      URL_HOMOLOGACAO = 'https://hml-api.funcionalcard.com.br/api/v2';
      URL_PRODUCAO = 'https://api.funcionalcard.com.br/api/v2';
  protected
    function GetBaseURL: string; override;
    function ObterTokenInterno: string; override;
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

constructor TFuncionalCardClient.Create(const AClientID, AClientSecret, ACodEstabelecimento: string;
  AHomologacao: Boolean);
begin
  inherited Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
  FNomeOperadora := 'Funcional Card';
  FCodigoOperadora := 'FUNCIONALCARD';
end;

function TFuncionalCardClient.GetBaseURL: string;
begin
  if FHomologacao then
    Result := URL_HOMOLOGACAO
  else
    Result := URL_PRODUCAO;
end;

function TFuncionalCardClient.ObterTokenInterno: string;
var
  LURL, LBody, LResponse: string;
  LJSON: TJSONObject;
  LHeaders: TArray<TPair<string, string>>;
var
  LReq: TJSONObject;
begin
  Result := '';
  LURL := GetBaseURL + '/auth/token';
  
  LReq := TJSONObject.Create;
  try
    LReq.AddPair('client_id', FConfig.ClientID);
    LReq.AddPair('client_secret', FConfig.ClientSecret);
    LBody := LReq.ToJSON;
  finally
    LReq.Free;
  end;
  
  LHeaders := [
    TPair<string, string>.Create('Content-Type', 'application/json')
  ];
  
  try
    DoLog(ltInfo, 'Obtendo token Funcional Card...', '');
    LResponse := FHTTPClient.Post(LURL, LBody, LHeaders);
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) and LJSON.TryGetValue<string>('token', Result) then
        DoLog(ltInfo, 'Token obtido com sucesso', '')
      else
        FUltimoErro := 'Falha ao obter token';
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
      FUltimoErro := 'Erro ao obter token: ' + E.Message;
  end;
end;

function TFuncionalCardClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate): IPBMElegibilidade;
var
  LProdutos: TArray<TPBMProduto>;
begin
  SetLength(LProdutos, 0);
  Result := ConsultarElegibilidade(ACarteirinha, ACPF, ADataNascimento, LProdutos);
end;

function TFuncionalCardClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade;
var
  LURL, LResponse: string;
  LResult: TPBMElegibilidadeResult;
  LJSON: TJSONObject;
begin
  LResult := TPBMElegibilidadeResult.Create;
  Result := LResult;
  
  try
    LURL := Format('%s/beneficiario/elegibilidade?cartao=%s&cpf=%s&nascimento=%s',
      [GetBaseURL, ACarteirinha, ACPF, FormatDateTime('ddmmyyyy', ADataNascimento)]);
    
    LResponse := FHTTPClient.Get(LURL, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := LJSON.GetValue<Boolean>('sucesso', False);
        LResult.Elegivel := LJSON.GetValue<Boolean>('elegivel', False);
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

function TFuncionalCardClient.AutorizarVenda(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>;
  AValorTotal: Currency; const ATransacaoID: string): IPBMAutorizacao;
var
  LReceita: TPBMReceita;
begin
  FillChar(LReceita, SizeOf(LReceita), 0);
  Result := AutorizarVenda(ACarteirinha, ACPF, ADataNascimento, AProdutos,
    AValorTotal, ATransacaoID, LReceita);
end;

function TFuncionalCardClient.AutorizarVenda(const ACarteirinha, ACPF: string;
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
    LURL := GetBaseURL + '/venda/autorizar';
    
    LReq := TJSONObject.Create;
    try
      LReq.AddPair('cartao', ACarteirinha);
      LReq.AddPair('cpf', ACPF);
      LReq.AddPair('nascimento', FormatDateTime('ddmmyyyy', ADataNascimento));
      LReq.AddPair('estabelecimento', FConfig.CodEstabelecimento);
      LReq.AddPair('transacao', ATransacaoID);
      LReq.AddPair('valorTotal', TJSONNumber.Create(AValorTotal));
      
      LItens := TJSONArray.Create;
      for I := 0 to High(AProdutos) do
      begin
        LItem := TJSONObject.Create;
        LItem.AddPair('ean', AProdutos[I].EAN);
        LItem.AddPair('qtd', TJSONNumber.Create(AProdutos[I].Quantidade));
        LItem.AddPair('preco', TJSONNumber.Create(AProdutos[I].PrecoUnitario));
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
        LResult.CodigoAutorizacao := LJSON.GetValue<string>('autorizacao', '');
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        LResult.ValorDesconto := LJSON.GetValue<Double>('desconto', 0);
        LResult.ValorLiquido := LJSON.GetValue<Double>('liquido', 0);
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

function TFuncionalCardClient.CancelarVenda(const ANSU, ACodigoAutorizacao,
  AMotivo: string): IPBMCancelamento;
var
  LURL, LBody, LResponse: string;
  LResult: TPBMCancelamentoResult;
  LJSON, LReq: TJSONObject;
begin
  LResult := TPBMCancelamentoResult.Create;
  Result := LResult;
  
  try
    LURL := GetBaseURL + '/venda/cancelar';
    LReq := TJSONObject.Create;
    try
      LReq.AddPair('nsu', ANSU);
      LReq.AddPair('autorizacao', ACodigoAutorizacao);
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
        if LResult.Sucesso then
          LResult.DataCancelamento := Now;
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

function TFuncionalCardClient.ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao;
var
  LURL, LResponse: string;
  LResult: TPBMConsultaResult;
  LJSON: TJSONObject;
begin
  LResult := TPBMConsultaResult.Create;
  Result := LResult;
  
  try
    LURL := GetBaseURL + '/venda/consultar/' + ANSU;
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
        LResult.ValorDesconto := LJSON.GetValue<Double>('desconto', 0);
        LResult.ValorLiquido := LJSON.GetValue<Double>('liquido', 0);
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
