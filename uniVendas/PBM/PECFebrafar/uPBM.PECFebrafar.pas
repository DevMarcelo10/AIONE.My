unit uPBM.PECFebrafar;
{******************************************************************************
  PBM PEC Febrafar - REST/JSON + Token - Associativo
******************************************************************************}
interface
uses System.SysUtils, System.Classes, System.JSON, System.DateUtils, System.Generics.Collections, uPBM.Interfaces, uPBM.Base, uPBM.Results;

type
  TPECFebrafar = class(TPBMClientBase)
  private const
    URL_HOMOLOGACAO = 'https://hml.febrafar.com.br/api/pec/v1';
    URL_PRODUCAO = 'https://api.febrafar.com.br/api/pec/v1';
  protected
    function GetBaseURL: string; override;
    function ObterTokenInterno: string; override;
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

constructor TPECFebrafar.Create(const AClientID, AClientSecret, ACodEstabelecimento: string; AHomologacao: Boolean);
begin inherited Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao); FNomeOperadora := 'PEC Febrafar'; FCodigoOperadora := 'PECFEBRAFAR'; end;

function TPECFebrafar.GetBaseURL: string;
begin if FHomologacao then Result := URL_HOMOLOGACAO else Result := URL_PRODUCAO; end;

function TPECFebrafar.ObterTokenInterno: string;
begin Result := FConfig.APIKey; if Result = '' then Result := FConfig.ClientSecret; end;

function TPECFebrafar.ConsultarElegibilidade(const ACarteirinha, ACPF: string; ADataNascimento: TDate): IPBMElegibilidade;
var LP: TArray<TPBMProduto>; begin SetLength(LP, 0); Result := ConsultarElegibilidade(ACarteirinha, ACPF, ADataNascimento, LP); end;

function TPECFebrafar.ConsultarElegibilidade(const ACarteirinha, ACPF: string; ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>): IPBMElegibilidade;
var LR: TPBMElegibilidadeResult; LJ: TJSONObject; LResp: string;
begin LR := TPBMElegibilidadeResult.Create; Result := LR; try LResp := FHTTPClient.Get(Format('%s/elegibilidade?carteirinha=%s&cpf=%s', [GetBaseURL, ACarteirinha, ACPF]), GetAuthHeaders); LR.CodigoHTTP := FHTTPClient.LastStatusCode; LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject; try if Assigned(LJ) then begin LR.Sucesso := LJ.GetValue<Boolean>('elegivel', False); LR.Elegivel := LR.Sucesso; LR.Mensagem := LJ.GetValue<string>('mensagem', ''); LR.NomeBeneficiario := LJ.GetValue<string>('nome', ''); end; finally LJ.Free; end; except on E: Exception do begin LR.Sucesso := False; LR.Mensagem := E.Message; end; end; end;

function TPECFebrafar.AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency; const ATransacaoID: string): IPBMAutorizacao;
var LRec: TPBMReceita; begin FillChar(LRec, SizeOf(LRec), 0); Result := AutorizarVenda(ACarteirinha, ACPF, ADataNascimento, AProdutos, AValorTotal, ATransacaoID, LRec); end;

function TPECFebrafar.AutorizarVenda(const ACarteirinha, ACPF: string; ADataNascimento: TDate; const AProdutos: TArray<TPBMProduto>; AValorTotal: Currency; const ATransacaoID: string; const AReceita: TPBMReceita): IPBMAutorizacao;
var LR: TPBMAutorizacaoResult; LJ, LReq, LIt: TJSONObject; LItens: TJSONArray; LResp: string; I: Integer;
begin LR := TPBMAutorizacaoResult.Create; Result := LR; try LReq := TJSONObject.Create; try LReq.AddPair('carteirinha', ACarteirinha).AddPair('cpf', ACPF).AddPair('codigoEstabelecimento', FConfig.CodEstabelecimento).AddPair('valorTotal', TJSONNumber.Create(AValorTotal)); LItens := TJSONArray.Create; for I := 0 to High(AProdutos) do begin LIt := TJSONObject.Create; LIt.AddPair('ean', AProdutos[I].EAN).AddPair('quantidade', TJSONNumber.Create(AProdutos[I].Quantidade)).AddPair('precoUnitario', TJSONNumber.Create(AProdutos[I].PrecoUnitario)); LItens.AddElement(LIt); end; LReq.AddPair('itens', LItens); LResp := FHTTPClient.Post(GetBaseURL + '/autorizacao', LReq.ToJSON, GetAuthHeaders); finally LReq.Free; end; LR.CodigoHTTP := FHTTPClient.LastStatusCode; LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject; try if Assigned(LJ) then begin LR.Sucesso := LJ.GetValue<Boolean>('autorizado', False); LR.NSU := LJ.GetValue<string>('nsu', ''); LR.CodigoAutorizacao := LJ.GetValue<string>('autorizacao', ''); LR.Mensagem := LJ.GetValue<string>('mensagem', ''); LR.ValorDesconto := LJ.GetValue<Double>('desconto', 0); end; finally LJ.Free; end; except on E: Exception do begin LR.Sucesso := False; LR.Mensagem := E.Message; end; end; end;

function TPECFebrafar.CancelarVenda(const ANSU, ACodigoAutorizacao, AMotivo: string): IPBMCancelamento;
var LR: TPBMCancelamentoResult; LJ, LReq: TJSONObject; LResp: string;
begin LR := TPBMCancelamentoResult.Create; Result := LR; try LReq := TJSONObject.Create; try LReq.AddPair('nsu', ANSU).AddPair('motivo', AMotivo); LResp := FHTTPClient.Post(GetBaseURL + '/cancelamento', LReq.ToJSON, GetAuthHeaders); finally LReq.Free; end; LR.CodigoHTTP := FHTTPClient.LastStatusCode; LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject; try if Assigned(LJ) then begin LR.Sucesso := LJ.GetValue<Boolean>('cancelado', False); LR.ProtocoloCancelamento := LJ.GetValue<string>('protocolo', ''); LR.Mensagem := LJ.GetValue<string>('mensagem', ''); if LR.Sucesso then LR.DataCancelamento := Now; end; finally LJ.Free; end; except on E: Exception do begin LR.Sucesso := False; LR.Mensagem := E.Message; end; end; end;

function TPECFebrafar.ConsultarTransacao(const ANSU: string): IPBMConsultaTransacao;
var LR: TPBMConsultaResult; LJ: TJSONObject; LResp: string;
begin LR := TPBMConsultaResult.Create; Result := LR; try LResp := FHTTPClient.Get(GetBaseURL + '/transacao/' + ANSU, GetAuthHeaders); LR.CodigoHTTP := FHTTPClient.LastStatusCode; LJ := TJSONObject.ParseJSONValue(LResp) as TJSONObject; try if Assigned(LJ) then begin LR.Sucesso := True; LR.NSU := ANSU; LR.Status := LJ.GetValue<string>('status', ''); end; finally LJ.Free; end; except on E: Exception do begin LR.Sucesso := False; LR.Mensagem := E.Message; end; end; end;

end.
