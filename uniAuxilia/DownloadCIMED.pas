unit DownloadCIMED;

interface

uses
  Windows, SysUtils, Classes, Dialogs, ShellAPI, IdHTTP, IdSSLOpenSSL, StrUtils;

procedure DownloadCSV;

implementation

function ExtractXLSLink(const HTMLContent: string): string;
var
  StartPos, EndPos: Integer;
begin
  Result := '';
  // Procura pela primeira ocorrência da classe "govbr-card-content"
  StartPos := Pos('class="govbr-card-content"', HTMLContent);
  while StartPos > 0 do
  begin
    StartPos := PosEx('href="', HTMLContent, StartPos);
    if StartPos > 0 then
    begin
      Inc(StartPos, 6);
      EndPos := PosEx('"', HTMLContent, StartPos);
      if EndPos > 0 then
      begin
        Result := Copy(HTMLContent, StartPos, EndPos - StartPos);
        // Verifica se o link contém ".xls"
        if ContainsStr(Result, '.xls') then
             Exit(Result)
        else Result := '';
      end;
    end;
    // Procura pela próxima ocorrência de "class="govbr-card-content""
    StartPos := PosEx('class="govbr-card-content"', HTMLContent, EndPos);
  end;
end;

procedure OpenURLInBrowser(const URL: string);
begin
  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

procedure KillBrowserProcess;
begin
  ShellExecute(0, 'open', 'taskkill', '/IM chrome.exe /F', nil, SW_HIDE);
  ShellExecute(0, 'open', 'taskkill', '/IM firefox.exe /F', nil, SW_HIDE);
  ShellExecute(0, 'open', 'taskkill', '/IM msedge.exe /F', nil, SW_HIDE);
end;

procedure DownloadCSV;
var
  IdHTTP: TIdHTTP;
  IdSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  HTMLContent, XLSURL: string;
begin
  IdHTTP := TIdHTTP.Create(nil);
  IdSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    // Configura o SSL
    IdHTTP.IOHandler := IdSSLHandler;
    IdSSLHandler.SSLOptions.Method := sslvTLSv1_2; // Use TLS 1.2 ou superior
    IdSSLHandler.SSLOptions.Mode := sslmClient;

    // URL da página onde está o link do arquivo XLS
    HTMLContent := IdHTTP.Get('https://www.gov.br/anvisa/pt-br/assuntos/medicamentos/cmed/precos');

    // Extrair o link do arquivo XLS
    XLSURL := ExtractXLSLink(HTMLContent);

    if XLSURL <> '' then
    begin
      // Ajustar o URL relativo para absoluto, se necessário
      if Pos('http', XLSURL) <> 1 then
        XLSURL := 'https://www.gov.br' + XLSURL;

      // Abrir o link no navegador padrão
      OpenURLInBrowser(XLSURL);
      ShowMessage('Link do arquivo aberto no navegador padrão.');

      // Esperar alguns segundos para o download iniciar
      Sleep(10000); // Ajuste o tempo conforme necessário

      // Tentar fechar o navegador
      KillBrowserProcess;
    end
    else
    begin
      ShowMessage('Não foi possível encontrar o link do arquivo XLS.');
    end;
  finally
    IdHTTP.Free;
    IdSSLHandler.Free;
  end;
end;

end.

