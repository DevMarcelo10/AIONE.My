unit uABCFarma;

interface

uses
  System.SysUtils, System.Classes, IdHTTP, IdSSLOpenSSL, System.JSON;

type
  EWebAPIException = class(Exception)
    ErrorCode: Integer;
    constructor Create(const Msg: string; Code: Integer);
  end;

  TWebAPIResponse = class
    Page: string;
    TotalPages: Integer;
    TotalItems: Integer;
    Data: TJSONArray;
  end;

  TWebAPI = class
  private
    FHTTP: TIdHTTP;
    FSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    function SendRequest(const CNPJ: string; const Senha: string; const CNPJ_SH: string; const Pagina: Integer): TWebAPIResponse;
    function ParseResponse(const JSONText: string): TWebAPIResponse;
  public
    constructor Create;
    destructor Destroy; override;
    function GetData(const CNPJ: string; const Senha: string; const CNPJ_SH: string; const Pagina: Integer): TWebAPIResponse;
  end;

implementation

{ EWebAPIException }

constructor EWebAPIException.Create(const Msg: string; Code: Integer);
begin
  inherited Create(Msg);
  ErrorCode := Code;
end;

{ TWebAPI }

constructor TWebAPI.Create;
begin
  FHTTP := TIdHTTP.Create(nil);
  FSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(FHTTP);
  FHTTP.IOHandler := FSSLHandler;
  FHTTP.HandleRedirects := True;
end;

destructor TWebAPI.Destroy;
begin
  FHTTP.Free;
  FSSLHandler.Free;
  inherited;
end;

function TWebAPI.SendRequest(const CNPJ, Senha, CNPJ_SH: string; const Pagina: Integer): TWebAPIResponse;
var
  Params: TStringList;
  ResponseText: string;
begin
  Params := TStringList.Create;
  try
    FHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
    Params.Add('cnpj_cpf=' + CNPJ);
    Params.Add('senha=' + Senha);
    Params.Add('cnpj_sh=' + CNPJ_SH);
    Params.Add('pagina=' + IntToStr(Pagina));
    ResponseText := FHTTP.Post('https://webserviceabcfarma.org.br/webservice/', Params);
    Result := ParseResponse(ResponseText);
  finally
    Params.Free;
  end;
end;

function TWebAPI.ParseResponse(const JSONText: string): TWebAPIResponse;
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject.ParseJSONValue(JSONText) as TJSONObject;
  try
    if JSONObj.GetValue('error_code') <> nil then
    begin
      raise EWebAPIException.Create(JSONObj.GetValue<string>('error_message'), JSONObj.GetValue<Integer>('error_code'));
    end;

    Result := TWebAPIResponse.Create;
    Result.Page := JSONObj.GetValue<string>('pagina');
    Result.TotalPages := JSONObj.GetValue<Integer>('total_paginas');
    Result.TotalItems := JSONObj.GetValue<Integer>('total_itens');
    Result.Data := JSONObj.GetValue<TJSONArray>('data');
  finally
    JSONObj.Free;
  end;
end;

function TWebAPI.GetData(const CNPJ, Senha, CNPJ_SH: string; const Pagina: Integer): TWebAPIResponse;
begin
  Result := SendRequest(CNPJ, Senha, CNPJ_SH, Pagina);
end;

end.


(* -------- EXEMPLO: Unit de consumo da Classe Acima ----------
uses
  uWebAPI, System.SysUtils;

procedure ExecuteAPICall;
var
  WebAPI: TWebAPI;
  Response: TWebAPIResponse;
  Product: TJSONObject;
  I: Integer;
begin
  WebAPI := TWebAPI.Create;
  try
    try
      // Tente obter dados da API
      Response := WebAPI.GetData('seu_cnpj_aqui', 'sua_senha_aqui', 'cnpj_software_house_aqui', 1);
      if Assigned(Response) and Assigned(Response.Data) then
      begin
        Writeln('Página: ' + Response.Page);
        Writeln('Total de Páginas: ' + IntToStr(Response.TotalPages));
        Writeln('Total de Itens: ' + IntToStr(Response.TotalItems));

        // Iterar sobre cada item em 'data'
        for I := 0 to Response.Data.Count - 1 do
        begin
          Product := Response.Data.Items[I] as TJSONObject;
          Writeln('Produto ID: ' + Product.GetValue<string>('ID_PRODUTO'));
          Writeln('Nome: ' + Product.GetValue<string>('NOME'));
          Writeln('Descrição: ' + Product.GetValue<string>('DESCRICAO'));
          // Continuar exibindo outros campos conforme necessário
        end;
      end
      else
        Writeln('Nenhum dado foi retornado pela API.');
    except
      on E: EWebAPIException do
      begin
        // Tratar exceções específicas da API
        Writeln('Erro da API: ' + E.Message + ' (Código: ' + IntToStr(E.ErrorCode) + ')');
      end;
      on E: Exception do
      begin
        // Tratar exceções gerais
        Writeln('Erro geral: ' + E.Message);
      end;
    end;
  finally
    WebAPI.Free;
    if Assigned(Response) then
      Response.Free;
  end;
end;
*)

