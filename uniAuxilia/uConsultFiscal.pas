unit uConsultFiscal;

interface

uses
   System.SysUtils, System.Classes, System.Net.URLClient, System.Net.HttpClient,
   System.Net.HttpClientComponent, REST.Client, REST.Types, System.JSON;

   function ConsultToken(recUsuario,recSenha:String):String;
   function SendConsultRequest(const ARequest: string): string;
   function BuildJSONRequest(recCNPJ,recUF,RTRIB,recFAT12M:String; Lines:TStringList; Token:String):String;

implementation

// ---------------- Geração do Tolken ---------------- //
function ConsultToken(recUsuario,recSenha:String):String;
var
   Boundary:String;
   FormData:TStringList;
   Response:IHTTPResponse;
   HttpClient:TNetHTTPClient;
   StringStream:TStringStream;
begin
   Result := '';
   HttpClient := TNetHTTPClient.Create(nil);
   FormData := TStringList.Create;
   try
     HttpClient.CookieManager.AddServerCookie('PHPSESSID=oc5u95l4nbtbtecea9rt75uh96', 'https://consultthis.com.br');
     Boundary := '----WebKitFormBoundary7MA4YWxkTrZu0gW';
     FormData.Add('--' + Boundary);
     FormData.Add('Content-Disposition: form-data; name="wUsuario"');
     FormData.Add('');
     FormData.Add(recUsuario);
     FormData.Add('--' + Boundary);
     FormData.Add('Content-Disposition: form-data; name="wSenna"');
     FormData.Add('');
     FormData.Add(recSenha);
     FormData.Add('--' + Boundary + '--');
     StringStream := TStringStream.Create(FormData.Text, TEncoding.UTF8);
     try
       HttpClient.ContentType := 'multipart/form-data; boundary=' + Boundary;
       Response := HttpClient.Post('https://consultthis.com.br/ws/WSDLjH.php', StringStream);
       if Response.StatusCode = 200 then
            Result := Response.ContentAsString()
       else Result := Format('Erro de protocolo HTTP: %d %s', [Response.StatusCode, Response.StatusText]);
     except
       on E:Exception do Result := 'Erro: '+E.Message;
     end;
   finally
     StringStream.Free;
     FormData.Free;
     HttpClient.Free;
   end;
end;

// ------------ Envia Requisição P/ Servidor Consult ---------- //
function SendConsultRequest(const ARequest:String):String;
var
   RestClient:TRESTClient;
   RestRequest:TRESTRequest;
   RestResponse:TRESTResponse;
begin
   RestClient   := TRESTClient.Create('https://consultthis.com.br/ws/WSDLjH.php');
   RestRequest  := TRESTRequest.Create(nil);
   RestResponse := TRESTResponse.Create(nil);
   try
     RestRequest.Client   := RestClient;
     RestRequest.Response := RestResponse;
     RestRequest.Method   := rmPOST;
     RestRequest.AddParameter('wJSON', ARequest, pkGETorPOST);
     RestRequest.Execute;
     Result := RestResponse.Content;
   finally
     RestClient.Free;
     RestRequest.Free;
     RestResponse.Free;
   end;
end;

// ----------- Efetua a Construção do Json P/ Envio --------- //
function BuildJSONRequest(recCNPJ,recUF,RTRIB,recFAT12M:String; Lines:TStringList; Token:String):String;
var
   I:Integer;
   Fields:TArray<string>;
   HeaderArray,ProductArray:TJSONArray;
   JSONObj,HeaderObj,ProductObj:TJSONObject;
begin
   JSONObj      := TJSONObject.Create;
   HeaderArray  := TJSONArray.Create;
   ProductArray := TJSONArray.Create;
   try
      // ..... Constroi Cabeçalho
      HeaderObj := TJSONObject.Create;
      HeaderObj.AddPair('CNPJ', recCNPJ);
      HeaderObj.AddPair('UF', recUF);
      HeaderObj.AddPair('RTRIB', RTRIB);
      HeaderObj.AddPair('DATA', FormatDateTime('yyyy-mm-dd', Now()));
      HeaderObj.AddPair('HORA', FormatDateTime('HH:mm:ss', Now()));
      HeaderObj.AddPair('TOKEN', Token);
      HeaderObj.AddPair('COD_FAT12M', recFAT12M);
      HeaderObj.AddPair('ARQ', '1');
      HeaderArray.AddElement(HeaderObj);
      JSONObj.AddPair('CABECALHO', HeaderArray);
      // .... Constroi Dados de Produtos
      for I := 0 to Lines.Count-1 do
      begin
         Fields := Lines[I].Split([';']);
         if Length(Fields) >= 4 then
         begin
            ProductObj := TJSONObject.Create;
            ProductObj.AddPair('COD_BARRAS', Fields[0]);
            ProductObj.AddPair('COD_INTERNO',Fields[1]);
            ProductObj.AddPair('DESCRICAO',  Fields[2]);
            ProductObj.AddPair('COD_NCM',    Fields[3]);
            ProductArray.AddElement(ProductObj);
         end; //if
      end; //for
      JSONObj.AddPair('PRODUTO', ProductArray);
      Result := JSONObj.ToString;
   finally
      JSONObj.Free;
   end;
end;

 {ProductObj.AddPair('COD_BARRAS', Lines[i]); Inc(i);
  ProductObj.AddPair('COD_INTERNO', Lines[i]); Inc(i);
  ProductObj.AddPair('DESCRICAO', Lines[i]); Inc(i);
  ProductObj.AddPair('COD_NCM', Lines[i]); Inc(i);
  ProductObj.AddPair('MVA_EST', Lines[i]); Inc(i);
  ProductObj.AddPair('COD_CEST', Lines[i]); Inc(i);
  ProductObj.AddPair('CFOP_E', Lines[i]); Inc(i);
  ProductObj.AddPair('CFOP_S', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_CSOSN_E', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_CSOSN_S', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_ICMS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_ICMS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_PIS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_PIS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_COFINS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_COFINS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_IPI_E', Lines[i]); Inc(i);
  ProductObj.AddPair('CST_IPI_S', Lines[i]); Inc(i);
  ProductObj.AddPair('ENQ_IPI', Lines[i]); Inc(i);
  ProductObj.AddPair('SIT_TRIB', Lines[i]); Inc(i);
  ProductObj.AddPair('ALIQ_PIS', Lines[i]); Inc(i);
  ProductObj.AddPair('ALIQ_COFINS', Lines[i]); Inc(i);
  ProductObj.AddPair('ALIQ_ICMS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('ALIQ_ICMS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('FEM_ICMS', Lines[i]); Inc(i);
  ProductObj.AddPair('ALIQ_IPI', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_ITEM_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_ITEM_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_PIS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_PIS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_COFINS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_COFINS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_ICMS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_ICMS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_IPI_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_BC_IPI_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_PIS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_PIS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_COFINS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_COFINS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_ICMS_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_ICMS_S', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_IPI_E', Lines[i]); Inc(i);
  ProductObj.AddPair('VL_IPI_S', Lines[i]); Inc(i);
  ProductObj.AddPair('MOT_DESICMS', Lines[i]); Inc(i);
  ProductObj.AddPair('QTDE_E', Lines[i]); Inc(i);
  ProductObj.AddPair('QTDE_S', Lines[i]); Inc(i);
  ProductObj.AddPair('LISTA', Lines[i]); Inc(i);
  ProductObj.AddPair('LABORATORIO', Lines[i]); Inc(i);
  ProductObj.AddPair('TIP_MED', Lines[i]); Inc(i);}
end.

