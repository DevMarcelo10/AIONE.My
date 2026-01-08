unit uIBPTCapa;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.Net.HttpClientComponent,
  System.Net.URLClient, System.NetEncoding, Xml.XMLIntf, Xml.XMLDoc, MarcFMX,
  Xml.omnixmldom;

type
  TIBPTBasicTags = record
    Versao: string;
    VigenciaInicio: string;
    VigenciaFim: string;
    Chave: string;
    Fonte: string;
  end;

/// Retorna apenas Versao, VigenciaInicio, VigenciaFim, Chave e Fonte para um NCM/UF.
/// GTIN padrão: "SEM GTIN".
function FetchIBPTBasicTags(const CodigoNCM, UF: string; out R: TIBPTBasicTags; const GTIN: string = 'SEM GTIN'):String;

implementation

const
  C_API   = 'https://apidoni.ibpt.org.br/api/v1/produtos';
  C_TOKEN = 'CrUR88KTVnkUxHj3N4sJIgE_hIVoLzoE52EdpewpZ2EIWAkM0wLeMYFzWIgNuXc5';
  C_CNPJ  = '56185202000100';
  C_EX    = '0';
  C_DESCR = '';
  C_UN    = '';
  C_VALOR = '0';

function UrlEncode(const S: string): string; inline;
begin
  Result := TNetEncoding.URL.Encode(S);
end;

function BuildURL(const CodigoNCM, UF, GTIN: string): string;
var
  G: string;
begin
  G := Trim(GTIN);
  if G = '' then G := 'SEM GTIN';
  Result :=
    C_API + '?' +
    'token='  + UrlEncode(C_TOKEN) +
    '&cnpj='  + UrlEncode(C_CNPJ) +
    '&codigo='+ UrlEncode(CodigoNCM) +
    '&uf='    + UrlEncode(UpperCase(UF)) +
    '&ex='    + UrlEncode(C_EX) +
    '&valor='  + UrlEncode(C_VALOR) +
    '&descricao='    + UrlEncode(C_DESCR) +
    '&unidadeMedida='+ UrlEncode(C_UN) +
    '&gtin='+ UrlEncode(G);
end;
// 'https://apidoni.ibpt.org.br/api/v1/produtos?token=CrUR88KTVnkUxHj3N4sJIgE_hIVoLzoE52EdpewpZ2EIWAkM0wLeMYFzWIgNuXc5&cnpj=56185202000100&codigo=10011100&uf=MS&ex=0&descricao=&unidadeMedida=&valor=0&gtin=SEM%20GTIN


function ReadNodeTextByLocalName(const Root: IXMLNode; const Name: string): string;
var
  I: Integer;
  N: IXMLNode;
begin
  Result := '';
  if (Root = nil) then Exit;
  for I := 0 to Root.ChildNodes.Count - 1 do
  begin
    N := Root.ChildNodes[I];
    if SameText(N.LocalName, Name) then
      Exit(Trim(N.Text));
  end;
end;

function FetchIBPTBasicTags(const CodigoNCM, UF: string; out R: TIBPTBasicTags; const GTIN: string): String;
var
  HTTP: TNetHTTPClient;
  Resp: IHTTPResponse;
  XML:  IXMLDocument;
  Root: IXMLNode;
  URL: string;
  Body: string;
begin
   Result := 'ERRO';
   FillChar(R, SizeOf(R), 0);
   if (Length(UF) <> 2)     then raise Exception.Create('UF deve ter 2 letras (ex.: MS).');
   if (CodigoNCM.Trim = '') then raise Exception.Create('Código NCM obrigatório.');
   HTTP := TNetHTTPClient.Create(nil);
   try
      try
         // TLS forte
         HTTP.SecureProtocols   := [THTTPSecureProtocol.TLS12, THTTPSecureProtocol.TLS13];
         HTTP.ConnectionTimeout := 10000;
         HTTP.ResponseTimeout   := 20000;
         HTTP.Accept    := 'application/xml, text/xml;q=0.9,*/*;q=0.8';
         HTTP.UserAgent := 'IBPTCapa/1.0 (Delphi RAD 11)';

         URL := BuildURL(CodigoNCM, UF, GTIN);
         Resp := HTTP.Get(URL);

         if (Resp = nil) then raise Exception.Create('Sem resposta da API.');
         if Resp.StatusCode <> 200 then raise Exception.CreateFmt('HTTP %d - %s', [Resp.StatusCode, Resp.StatusText]);
         Body := Resp.ContentAsString(TEncoding.UTF8);
         if Body.Trim.IsEmpty then raise Exception.Create('Corpo vazio da API.');

         XML := TXMLDocument.Create(nil);
         XML.Options := [doNodeAutoCreate, doNodeAutoIndent];
         XML.LoadFromXML(Body);
         XML.Active := True;

         Root := XML.DocumentElement; // ProdutoDTO
         if (Root = nil) or not SameText(Root.LocalName, 'ProdutoDTO') then
            raise Exception.Create('XML inesperado: elemento raiz não é ProdutoDTO.');

         R.Versao         := ReadNodeTextByLocalName(Root, 'Versao');
         R.VigenciaInicio := ReadNodeTextByLocalName(Root, 'VigenciaInicio');
         R.VigenciaFim    := ReadNodeTextByLocalName(Root, 'VigenciaFim');
         R.Chave          := ReadNodeTextByLocalName(Root, 'Chave');
         R.Fonte          := ReadNodeTextByLocalName(Root, 'Fonte');
         Result := '';
      except
         on E:Exception do
         begin
            SalvaLog('.\log\', 'ERRO CRÍTICO: ao tentar abrir acessar API IBPT no uIBPTCapa -> '+E.Message);
            Result := E.Message;
         end;
      end;
  finally
      HTTP.Free;
  end;
end;

end.

