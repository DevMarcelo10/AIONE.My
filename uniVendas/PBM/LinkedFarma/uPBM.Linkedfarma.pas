unit uPBM.Linkedfarma;
{******************************************************************************
  PBM LinkedFarma - REST/JSON + API Key - Fidelização
******************************************************************************}
interface
uses
  System.SysUtils, System.Classes, System.JSON, System.DateUtils,
  System.Generics.Collections, uPBM.Interfaces, uPBM.Base, uPBM.Results;

type
  TLinkedfarmaClient = class(TPBMClientBase)
  private const
    URL_HOMOLOGACAO = 'https://hml-api.linkedfarma.com.br/api/v1';
    URL_PRODUCAO = 'https://api.linkedfarma.com.br/api/v1';
  protected
    function GetBaseURL: string; override;
    function ObterTokenInterno: string; override;
    function GetAuthHeaders: TArray<TPair<string,string>>; override;
  public
    constructor Create(const AClientID, AClientSecret, ACodEstabelecimento: string; AHomologacao: Boolean = True);
    function ConsultarElegibilidade(const ACarteirinha, ACPF: string; ADataNascimento: TDate): IPBMElegibilidade; overload; override;
    function ConsultarElegibilidade(const ACarteirinha, ACPF: string; ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade; overload; override;
    function AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency; const ATransacaoID: string): IPBMAutorizacao; overload; override;
    function AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency; const ATransacaoID: string; const AReceita: TPBMReceita): IPBMAutorizacao; overload; override;
    function CancelarVenda(const ANSU, ACodigoAutorizacao, AMotivo: string): IPBMCancelamento; override;
    function ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao; override;
  end;

implementation

constructor TLinkedfarmaClient.Create(const AClientID, AClientSecret, ACodEstabelecimento: string; AHomologacao: Boolean);
begin
  inherited Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
  FNomeOperadora := 'LinkedFarma';
  FCodigoOperadora := 'LINKEDFARMA';
end;

function TLinkedfarmaClient.GetBaseURL: string;
begin
  if FHomologacao then Result := URL_HOMOLOGACAO else Result := URL_PRODUCAO;
end;

function TLinkedfarmaClient.ObterTokenInterno: string;
begin
  Result := FConfig.APIKey;
  if Result = '' then Result := FConfig.ClientSecret;
end;

function TLinkedfarmaClient.GetAuthHeaders: TArray<TPair<string,string>>;
begin
  Result := [
    TPair<string,string>.Create('X-API-Key', FTokenManager.GetToken),
    TPair<string,string>.Create('Content-Type', 'application/json'),
    TPair<string,string>.Create('Accept', 'application/json')
  ];
end;

function TLinkedfarmaClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string; ADataNascimento: TDate): IPBMElegibilidade;
var LP: TArray<TPBMProduto>;
begin
  SetLength(LP, 0);
  Result := ConsultarElegibilidade(ACarteirinha, ACPF, ADataNascimento, LP);
end;

function TLinkedfarmaClient.ConsultarElegibilidade(const ACarteirinha, ACPF: string; ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade;
var
  LR: TPBMElegibilidadeResult;
  LJ: TJSONObject;
  LResp: string;
begin
  LR := TPBMElegibilidadeResult.Create;
  Result := LR;
  try
    LResp := FHTTPClient.Get(Format('%s/cliente/cpf/%s', [GetBaseURL, ACPF]), GetAuthHeaders);
    LR.CodigoHTTP := FHTTPClient.LastStatusCode;
    LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject;
    try
      if Assigned(LJ) then
      begin
        LR.Sucesso := LJ.GetValue<Boolean>('ativo', False);
        LR.Elegivel := LR.Sucesso;
        LR.Mensagem := LJ.GetValue<string>('mensagem', '');
        LR.NomeBeneficiario := LJ.GetValue<string>('nome', '');
        LR.SaldoPontos := LJ.GetValue<Integer>('saldoPontos', 0);
      end;
    finally
      LJ.Free;
    end;
  except
    on E: Exception do
    begin
      LR.Sucesso := False;
      LR.Mensagem := E.Message;
    end;
  end;
end;

function TLinkedfarmaClient.AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate;
  const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency; const ATransacaoID: string): IPBMAutorizacao;
var LRec: TPBMReceita;
begin
  FillChar(LRec, SizeOf(LRec), 0);
  Result := AutorizarVenda(ACarteirinha, ACPF, ADataNascimento, AProdutos, AValorTotal, ATransacaoID, LRec);
end;

function TLinkedfarmaClient.AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate;
  const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency; const ATransacaoID: string;
  const AReceita: TPBMReceita): IPBMAutorizacao;
var
  LR: TPBMAutorizacaoResult;
  LJ, LReq, LIt: TJSONObject;
  LItens: TJSONArray;
  LResp: string;
  I: Integer;
begin
  LR := TPBMAutorizacaoResult.Create;
  Result := LR;
  try
    LReq := TJSONObject.Create;
    try
      LReq.AddPair('cpf', ACPF);
      LReq.AddPair('codigoLoja', FConfig.CodEstabelecimento);
      LReq.AddPair('transacaoId', ATransacaoID);
      LReq.AddPair('valorTotal', TJSONNumber.Create(AValorTotal));
      
      LItens := TJSONArray.Create;
      for I := 0 to High(AProdutos) do
      begin
        LIt := TJSONObject.Create;
        LIt.AddPair('ean', AProdutos[I].EAN);
        LIt.AddPair('quantidade', TJSONNumber.Create(AProdutos[I].Quantidade));
        LIt.AddPair('preco', TJSONNumber.Create(AProdutos[I].PrecoUnitario));
        LItens.AddElement(LIt);
      end;
      LReq.AddPair('itens', LItens);
      
      LResp := FHTTPClient.Post(GetBaseURL + '/venda', LReq.ToJSON, GetAuthHeaders);
    finally
      LReq.Free;
    end;
    
    LR.CodigoHTTP := FHTTPClient.LastStatusCode;
    LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject;
    try
      if Assigned(LJ) then
      begin
        LR.Sucesso := LJ.GetValue<Boolean>('sucesso', False);
        LR.NSU := LJ.GetValue<string>('nsu', '');
        LR.CodigoAutorizacao := LJ.GetValue<string>('autorizacao', '');
        LR.Mensagem := LJ.GetValue<string>('mensagem', '');
        LR.ValorDesconto := LJ.GetValue<Double>('desconto', 0);
        LR.PontosCredito := LJ.GetValue<Integer>('pontosCredito', 0);
        LR.SaldoPontos := LJ.GetValue<Integer>('saldoPontos', 0);
      end;
    finally
      LJ.Free;
    end;
  except
    on E: Exception do
    begin
      LR.Sucesso := False;
      LR.Mensagem := E.Message;
    end;
  end;
end;

function TLinkedfarmaClient.CancelarVenda(const ANSU, ACodigoAutorizacao, AMotivo: string): IPBMCancelamento;
var
  LR: TPBMCancelamentoResult;
  LJ, LReq: TJSONObject;
  LResp: string;
begin
  LR := TPBMCancelamentoResult.Create;
  Result := LR;
  try
    LReq := TJSONObject.Create;
    try
      LReq.AddPair('nsu', ANSU);
      LReq.AddPair('motivo', AMotivo);
      LResp := FHTTPClient.Post(GetBaseURL + '/venda/cancelar', LReq.ToJSON, GetAuthHeaders);
    finally
      LReq.Free;
    end;
    
    LR.CodigoHTTP := FHTTPClient.LastStatusCode;
    LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject;
    try
      if Assigned(LJ) then
      begin
        LR.Sucesso := LJ.GetValue<Boolean>('cancelado', False);
        LR.ProtocoloCancelamento := LJ.GetValue<string>('protocolo', '');
        LR.Mensagem := LJ.GetValue<string>('mensagem', '');
        if LR.Sucesso then LR.DataCancelamento := Now;
      end;
    finally
      LJ.Free;
    end;
  except
    on E: Exception do
    begin
      LR.Sucesso := False;
      LR.Mensagem := E.Message;
    end;
  end;
end;

function TLinkedfarmaClient.ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao;
var
  LR: TPBMConsultaResult;
  LJ: TJSONObject;
  LResp: string;
begin
  LR := TPBMConsultaResult.Create;
  Result := LR;
  try
    LResp := FHTTPClient.Get(GetBaseURL + '/venda/' + ANSU, GetAuthHeaders);
    LR.CodigoHTTP := FHTTPClient.LastStatusCode;
    LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject;
    try
      if Assigned(LJ) then
      begin
        LR.Sucesso := True;
        LR.NSU := ANSU;
        LR.Status := LJ.GetValue<string>('status', '');
        LR.ValorBruto := LJ.GetValue<Double>('valorBruto', 0);
        LR.ValorDesconto := LJ.GetValue<Double>('desconto', 0);
      end;
    finally
      LJ.Free;
    end;
  except
    on E: Exception do
    begin
      LR.Sucesso := False;
      LR.Mensagem := E.Message;
    end;
  end;
end;

end.
