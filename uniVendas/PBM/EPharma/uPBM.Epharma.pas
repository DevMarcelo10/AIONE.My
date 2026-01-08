unit uPBM.Epharma;

{******************************************************************************
  PBM Epharma - Cliente para integração com Epharma
  
  Protocolo: REST/JSON + OAuth 2.0
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
  TEpharmaClient = class(TPBMClientBase)
  private
    const
      URL_HOMOLOGACAO = 'https://hml-api.epharma.com.br/api/v1';
      URL_PRODUCAO = 'https://api.epharma.com.br/api/v1';
  protected
    function GetBaseURL: string; override;
    function ObterTokenInterno: string; override;
  public
    constructor Create(const AClientID, AClientSecret, ACodEstabelecimento: string;
      AHomologacao: Boolean = True);
    
    // IPBMClient
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

{ TEpharmaClient }

constructor TEpharmaClient.Create(const AClientID, AClientSecret, ACodEstabelecimento: string;
  AHomologacao: Boolean);
begin
  inherited Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
  FNomeOperadora := 'Epharma';
  FCodigoOperadora := 'EPHARMA';
end;

function TEpharmaClient.GetBaseURL: string;
begin
  if FHomologacao then
    Result := URL_HOMOLOGACAO
  else
    Result := URL_PRODUCAO;
end;

function TEpharmaClient.ObterTokenInterno: string;
var
  LURL, LBody, LResponse: string;
  LJSON: TJSONObject;
  LHeaders: TArray<TPair<string, string>>;
begin
  Result := '';
  LURL := GetBaseURL + '/oauth/token';
  
  LBody := Format('grant_type=client_credentials&client_id=%s&client_secret=%s',
    [TNetEncoding.URL.Encode(FConfig.ClientID),
     TNetEncoding.URL.Encode(FConfig.ClientSecret)]);
  
  LHeaders := [
    TPair<string, string>.Create('Content-Type', 'application/x-www-form-urlencoded')
  ];
  
  try
    DoLog(ltInfo, 'Obtendo token Epharma...', '');
    LResponse := FHTTPClient.Post(LURL, LBody, LHeaders);
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) and LJSON.TryGetValue<string>('access_token', Result) then
        DoLog(ltInfo, 'Token obtido com sucesso', '')
      else
      begin
        DoLog(ltError, 'Falha ao obter token', LResponse);
        FUltimoErro := 'Falha ao obter token: ' + LResponse;
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      FUltimoErro := 'Erro ao obter token: ' + E.Message;
      DoLog(ltError, FUltimoErro, '');
    end;
  end;
end;

function TEpharmaClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate): IPBMElegibilidade;
var
  LProdutos: TArray<TPBMProduto>;
begin
  SetLength(LProdutos, 0);
  Result := ConsultarElegibilidade(ACarteirinha, ACPF, ADataNascimento, LProdutos);
end;

function TEpharmaClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade;
var
  LURL, LResponse: string;
  LResult: TPBMElegibilidadeResult;
  LJSON, LBenef: TJSONObject;
  LDescontos: TJSONArray;
  I: Integer;
begin
  LResult := TPBMElegibilidadeResult.Create;
  Result := LResult;
  
  try
    LURL := Format('%s/elegibilidade?carteirinha=%s&cpf=%s&dataNascimento=%s',
      [GetBaseURL, ACarteirinha, ACPF, FormatDateTime('yyyy-mm-dd', ADataNascimento)]);
    
    DoLog(ltInfo, 'Consultando elegibilidade Epharma', LURL);
    LResponse := FHTTPClient.Get(LURL, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := LJSON.GetValue<Boolean>('elegivel', False);
        LResult.Elegivel := LResult.Sucesso;
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        LResult.CodigoErro := LJSON.GetValue<string>('codigo', '');
        
        if LJSON.TryGetValue<TJSONObject>('beneficiario', LBenef) then
        begin
          LResult.NomeBeneficiario := LBenef.GetValue<string>('nome', '');
          LResult.Plano := LBenef.GetValue<string>('plano', '');
        end;
        
        // Descontos por produto
        if LJSON.TryGetValue<TJSONArray>('descontos', LDescontos) then
        begin
          var LDescontosArr: TArray<TPBMDescontoProduto>;
          SetLength(LDescontosArr, LDescontos.Count);
          for I := 0 to LDescontos.Count - 1 do
          begin
            LDescontosArr[I].EAN := LDescontos.Items[I].GetValue<string>('ean', '');
            LDescontosArr[I].DescontoPercentual := LDescontos.Items[I].GetValue<Double>('percentual', 0);
            LDescontosArr[I].DescontoValor := LDescontos.Items[I].GetValue<Double>('valor', 0);
            LDescontosArr[I].Elegivel := LDescontos.Items[I].GetValue<Boolean>('elegivel', False);
          end;
          LResult.Descontos := LDescontosArr;
        end;
      end
      else
      begin
        LResult.Sucesso := False;
        LResult.Mensagem := 'Resposta inválida do servidor';
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := 'Erro: ' + E.Message;
      LResult.CodigoErro := 'EXCEPTION';
      FUltimoErro := E.Message;
    end;
  end;
end;

function TEpharmaClient.AutorizarVenda(const ACarteirinha, ACPF: string;
  ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>;
  AValorTotal: Currency; const ATransacaoID: string): IPBMAutorizacao;
var
  LReceita: TPBMReceita;
begin
  FillChar(LReceita, SizeOf(LReceita), 0);
  Result := AutorizarVenda(ACarteirinha, ACPF, ADataNascimento, AProdutos,
    AValorTotal, ATransacaoID, LReceita);
end;

function TEpharmaClient.AutorizarVenda(const ACarteirinha, ACPF: string;
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
    
    // Monta JSON da requisição
    LReq := TJSONObject.Create;
    try
      LReq.AddPair('carteirinha', ACarteirinha);
      LReq.AddPair('cpf', ACPF);
      LReq.AddPair('dataNascimento', FormatDateTime('yyyy-mm-dd', ADataNascimento));
      LReq.AddPair('codigoEstabelecimento', FConfig.CodEstabelecimento);
      LReq.AddPair('transacaoId', ATransacaoID);
      LReq.AddPair('valorTotal', TJSONNumber.Create(AValorTotal));
      
      // Receita (se informada)
      if AReceita.CRM <> '' then
      begin
        LReq.AddPair('crmMedico', AReceita.CRM);
        LReq.AddPair('ufMedico', AReceita.UF);
        LReq.AddPair('nomeMedico', AReceita.NomeMedico);
      end;
      
      // Itens/Produtos
      LItens := TJSONArray.Create;
      for I := 0 to High(AProdutos) do
      begin
        LItem := TJSONObject.Create;
        LItem.AddPair('ean', AProdutos[I].EAN);
        LItem.AddPair('quantidade', TJSONNumber.Create(AProdutos[I].Quantidade));
        LItem.AddPair('precoUnitario', TJSONNumber.Create(AProdutos[I].PrecoUnitario));
        LItem.AddPair('precoTotal', TJSONNumber.Create(AProdutos[I].PrecoTotal));
        LItens.AddElement(LItem);
      end;
      LReq.AddPair('itens', LItens);
      
      LBody := LReq.ToJSON;
    finally
      LReq.Free;
    end;
    
    DoLog(ltInfo, 'Autorizando venda Epharma', LBody);
    LResponse := FHTTPClient.Post(LURL, LBody, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := LJSON.GetValue<Boolean>('autorizado', False);
        LResult.NSU := LJSON.GetValue<string>('nsu', '');
        LResult.CodigoAutorizacao := LJSON.GetValue<string>('codigoAutorizacao', '');
        LResult.Protocolo := LJSON.GetValue<string>('protocolo', '');
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        LResult.CodigoErro := LJSON.GetValue<string>('codigo', '');
        LResult.ValorDesconto := LJSON.GetValue<Double>('valorDesconto', 0);
        LResult.ValorSubsidio := LJSON.GetValue<Double>('valorSubsidio', 0);
        LResult.ValorLiquido := LJSON.GetValue<Double>('valorLiquido', 0);
        LResult.NomeBeneficiario := LJSON.GetValue<string>('nomeBeneficiario', '');
      end
      else
      begin
        LResult.Sucesso := False;
        LResult.Mensagem := 'Resposta inválida do servidor';
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := 'Erro: ' + E.Message;
      LResult.CodigoErro := 'EXCEPTION';
      FUltimoErro := E.Message;
    end;
  end;
end;

function TEpharmaClient.CancelarVenda(const ANSU, ACodigoAutorizacao,
  AMotivo: string): IPBMCancelamento;
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
      LReq.AddPair('codigoEstabelecimento', FConfig.CodEstabelecimento);
      LBody := LReq.ToJSON;
    finally
      LReq.Free;
    end;
    
    DoLog(ltInfo, 'Cancelando venda Epharma - NSU: ' + ANSU, LBody);
    LResponse := FHTTPClient.Post(LURL, LBody, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := LJSON.GetValue<Boolean>('cancelado', False);
        LResult.ProtocoloCancelamento := LJSON.GetValue<string>('protocolo', '');
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        LResult.CodigoErro := LJSON.GetValue<string>('codigo', '');
        if LResult.Sucesso then
          LResult.DataCancelamento := Now;
      end
      else
      begin
        LResult.Sucesso := False;
        LResult.Mensagem := 'Resposta inválida do servidor';
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := 'Erro: ' + E.Message;
      LResult.CodigoErro := 'EXCEPTION';
      FUltimoErro := E.Message;
    end;
  end;
end;

function TEpharmaClient.ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao;
var
  LURL, LResponse: string;
  LResult: TPBMConsultaResult;
  LJSON: TJSONObject;
begin
  LResult := TPBMConsultaResult.Create;
  Result := LResult;
  
  try
    LURL := Format('%s/transacao/%s', [GetBaseURL, ANSU]);
    
    DoLog(ltInfo, 'Consultando transação Epharma - NSU: ' + ANSU, '');
    LResponse := FHTTPClient.Get(LURL, GetAuthHeaders);
    LResult.CodigoHTTP := FHTTPClient.LastStatusCode;
    
    LJSON := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    try
      if Assigned(LJSON) then
      begin
        LResult.Sucesso := True;
        LResult.NSU := LJSON.GetValue<string>('nsu', ANSU);
        LResult.Status := LJSON.GetValue<string>('status', '');
        LResult.Mensagem := LJSON.GetValue<string>('mensagem', '');
        LResult.ValorBruto := LJSON.GetValue<Double>('valorBruto', 0);
        LResult.ValorDesconto := LJSON.GetValue<Double>('valorDesconto', 0);
        LResult.ValorLiquido := LJSON.GetValue<Double>('valorLiquido', 0);
      end
      else
      begin
        LResult.Sucesso := False;
        LResult.Mensagem := 'Resposta inválida do servidor';
      end;
    finally
      LJSON.Free;
    end;
  except
    on E: Exception do
    begin
      LResult.Sucesso := False;
      LResult.Mensagem := 'Erro: ' + E.Message;
      LResult.CodigoErro := 'EXCEPTION';
      FUltimoErro := E.Message;
    end;
  end;
end;

end.
