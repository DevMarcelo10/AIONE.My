unit uFatores;

interface

uses
   Windows, Messages, MarcLib, VCL.Dialogs, System.SysUtils,
   System.Classes, System.StrUtils, System.Types, IdHTTP,
   System.JSON, IdSSLOpenSSL, DateUtils;

type
   TCotacaoDolar = record
      Valor:Double;
      Data:String;
   end;

   TIndiceBCP = record
      Data: TDate;
      Valor: Double;
   end;

   function GetCotacaoDolarDia(dataCotacao:TDate):Double;
   function CotacaoDolarPeriodo(recDatIni,recDatFin:TDate):TArray<TCotacaoDolar>;
   function GetIndiceBCP(dataInicial,dataFinal:TDate; recTipo:String; recUltimos:Integer):TArray<TIndiceBCP>;

implementation

// -------------- Acesso API de Cotação Dolar -------------- //
function GetCotacaoDolarDia(dataCotacao:TDate):Double;
var
   httpClient:TIdHTTP;
   jsonArray:TJSONArray;
   url,response:String;
   jsonResponse,jsonValue:TJSONObject;
   IdSSLIOHandler:TIdSSLIOHandlerSocketOpenSSL;
begin
   Result := 0;
   httpClient := TIdHTTP.Create(nil);
   httpClient.Request.Accept := 'application/json';
   IdSSLIOHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];
   httpClient.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36';
   try
      url := Format('https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/' +
      'CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao=''%s''&$top=100&$format=json&$select=cotacaoVenda',
      [FormatDateTime('mm-dd-yyyy', dataCotacao)]);
      response     := httpClient.Get(url);
      jsonResponse := TJSONObject.ParseJSONValue(response) as TJSONObject;
      jsonArray    := jsonResponse.GetValue('value') as TJSONArray;
      if jsonArray.Count > 0 then
      begin
         jsonValue := jsonArray.Items[0] as TJSONObject;
         Result    := jsonValue.GetValue<Double>('cotacaoVenda');
      end;
   finally
      httpClient.Free;
   end;
end;

function CotacaoDolarPeriodo(recDatIni,recDatFin:TDate):TArray<TCotacaoDolar>;
var
   I:Integer;
   httpClient:TIdHTTP;
   Cotacao:TCotacaoDolar;
   url,response:String;
   jsonArray:TJSONArray;
   jsonResponse,jsonValue:TJSONObject;
   IdSSLIOHandler:TIdSSLIOHandlerSocketOpenSSL;
begin
   httpClient := TIdHTTP.Create(nil);
   httpClient.Request.Accept := 'application/json';
   IdSSLIOHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];
   httpClient.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36';
   try
      url := Format('https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/' +
      'CotacaoDolarPeriodo(dataInicial=@dataInicial,dataFinalCotacao=@dataFinalCotacao)?' +
      '@dataInicial=''%s''&@dataFinalCotacao=''%s''&$top=100&$format=json&$select=cotacaoCompra,cotacaoVenda,dataHoraCotacao',
      [FormatDateTime('mm-dd-yyyy', recDatIni), FormatDateTime('mm-dd-yyyy', recDatFin)]);
      response     := httpClient.Get(url);
      jsonResponse := TJSONObject.ParseJSONValue(response) as TJSONObject;
      jsonArray    := jsonResponse.GetValue('value') as TJSONArray;
      SetLength(Result, jsonArray.Count);
      for I := 0 to jsonArray.Count - 1 do
      begin
         jsonValue     := jsonArray.Items[I] as TJSONObject;
         Cotacao.Valor := jsonValue.GetValue<Double>('cotacaoVenda');
         Cotacao.Data  := Copy((jsonValue.GetValue<string>('dataHoraCotacao')),1,10);
         Result[I]     := Cotacao;
      end; //for
   finally
      httpClient.Free;
   end;
end;

// ---------- Consumo API: Índices Econômicos Banco Central ---------- //
function GetIndiceBCP(dataInicial,dataFinal:TDate; recTipo:String; recUltimos:Integer):TArray<TIndiceBCP>;
var
   I:Integer;
   indice:TIndiceBCP;
   httpClient:TIdHTTP;
   jsonValue:TJSONObject;
   jsonResponse:TJSONArray;
   url,response,auxTip:String;
   Resultado:TArray<TIndiceBCP>;
   IdSSLIOHandler:TIdSSLIOHandlerSocketOpenSSL;
begin
//https://api.bcb.gov.br/dados/serie/bcdata.16122/dados?formato=json&dataInicial=01/10/2023&dataFinal=31/12/2023
//https://api.bcb.gov.br/dados/serie/bcdata.sgs.4393/dados?formato=json&dataInicial=01/10/2023&dataFinal=31/12/2023'
   httpClient := TIdHTTP.Create(nil);
   IdSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(httpClient);
   httpClient.IOHandler := IdSSLIOHandler;
   httpClient.Request.Accept := 'application/json';
   IdSSLIOHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];
   httpClient.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36';
   try
      if recTipo = 'ICC' then auxTip := '4393'  else  //... Índice de Confiança do Consumidor
      if recTipo = 'CEA' then auxTip := '4394'  else  //... Índice de Condições Econômicas Atuais
      if recTipo = 'CEF' then auxTip := '4395'  else  //... Índice de Expectativas Futuras Consumidor
      if recTipo = 'LIC' then auxTip := '4189'  else  //... Taxa de juros Selic anualizada base 252
      if recTipo = 'PCA' then auxTip := '16122' else  //... Índice nacional de preços ao consumidor - Amplo (IPCA)
      if recTipo = 'PIC' then auxTip := '21127' else  //... Percentual inadimplência cartão de crédito rotativo
      if recTipo = 'PJC' then auxTip := '22022';      //... Percentual médio juros cartão de crédito rotativo
      if recUltimos > 0 then
           url := 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.'+auxTip+'/dados/ultimos/'+recUltimos.ToString+'?formato=json'
      else url := Format('https://api.bcb.gov.br/dados/serie/bcdata.sgs.'+auxTip+'/dados?formato=json&dataInicial=%s&dataFinal=%s', [FormatDateTime('dd/mm/yyyy', dataInicial), FormatDateTime('dd/mm/yyyy', dataFinal)]);
      response     := httpClient.Get(url);
      jsonResponse := TJSONObject.ParseJSONValue(response) as TJSONArray;
      SetLength(Result, jsonResponse.Count);
      for I := 0 to jsonResponse.Count - 1 do
      begin
         jsonValue    := jsonResponse.Items[I] as TJSONObject;
         indice.Data  := StrToDate(jsonValue.GetValue<string>('data'));
         indice.Valor := jsonValue.GetValue<Double>('valor');
         Result[I]    := indice;
      end; //for
   finally
      httpClient.Free;
   end;
end;

end.

(* BASE DE APIS:
     - https://www.fecomercio.com.br/pesquisas/indice/icc
     - https://data.amerigeoss.org/id/organization/br
     - https://dadosabertos.bcb.gov.br/
     - https://dadosabertos.bcb.gov.br/dataset
     - https://sidra.ibge.gov.br/pesquisa/censo-demografico/demografico-2022/universo-populacao-por-idade-e-sexo
     - https://www.ibge.gov.br/busca.html?searchword=censo

---------------------------------------------------------------------------
COTAÇÃO DOLAR
   https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao='12-15-2023'&$top=100&$format=json&$select=cotacaoVenda
   https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarPeriodo(dataInicial=@dataInicial,dataFinalCotacao=@dataFinalCotacao)?@dataInicial='12-01-2023'&@dataFinalCotacao='12-18-2023'&$top=100&$format=json&$select=cotacaoCompra,cotacaoVenda,dataHoraCotacao

TAXAS BANCO CENTRAL:
https://dadosabertos.bcb.gov.br/dataset/4393-indice-de-confianca-do-consumidor
https://dadosabertos.bcb.gov.br/dataset/4394-indice-de-condicoes-economicas-atuais
https://dadosabertos.bcb.gov.br/dataset/4395-indice-de-expectativas-futuras
https://data.amerigeoss.org/id/dataset/1178-taxa-de-juros-selic-anualizada-base-252
https://dadosabertos.bcb.gov.br/dataset/22022-taxa-media-de-juros-das-operacoes-de-credito-com-recursos-livres---pessoas-fisicas---cartao-d
https://dadosabertos.bcb.gov.br/dataset/21127-inadimplencia-da-carteira-de-credito-com-recursos-livres---pessoas-fisicas---cartao-de-credit
*)
