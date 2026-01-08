unit uFTP;

interface

uses
  IdFTP, IdComponent, SysUtils, Classes;

  function CriarDiretorioFTP(FTP: TIdFTP; const Diretorio: string):Boolean;
  function EnviarArquivoFTP(FTP: TIdFTP; const ArquivoLocal, ArquivoRemoto: string):Boolean;
  function BaixarArquivoFTP(FTP: TIdFTP; const ArquivoRemoto, ArquivoLocal: string):Boolean;
  function ListarArquivosFTP(FTP: TIdFTP; ListaDeArquivos: TStrings; const Diretorio: string):Boolean;
  function ArquivoExisteFTP(FTP: TIdFTP; const Diretorio, NomeArquivo: string):Boolean;

implementation

function CriarDiretorioFTP(FTP: TIdFTP; const Diretorio: string):Boolean;
begin
   Result := False;
   try
      if not FTP.Connected then Exit;
      FTP.MakeDir(Diretorio);
      Result := True;
   except
   end;
end;

function EnviarArquivoFTP(FTP: TIdFTP; const ArquivoLocal, ArquivoRemoto: string):Boolean;
begin
   Result := False;
   try
      if not FTP.Connected then Exit;
      FTP.Put(ArquivoLocal, ArquivoRemoto, False); // False para sobrepor, se já existir
      Result := True;
   except
   end;
end;

function BaixarArquivoFTP(FTP: TIdFTP; const ArquivoRemoto, ArquivoLocal: string):Boolean;
begin
   Result := False;
   try
      if not FTP.Connected then Exit;
      FTP.Get(ArquivoRemoto, ArquivoLocal, True); // True para substituir se o arquivo local já existir
      Result := True;
   except
   end;
end;

function ListarArquivosFTP(FTP: TIdFTP; ListaDeArquivos: TStrings; const Diretorio: string):Boolean;
begin
   Result := False;
   try
     if not FTP.Connected then Exit;
     FTP.ChangeDir(Diretorio);
     FTP.List(ListaDeArquivos, '', False);
     Result := True;
   except
   end;
end;

function ArquivoExisteFTP(FTP: TIdFTP; const Diretorio, NomeArquivo: string):Boolean;
var
   I:Integer;
   ListaArq:TStringList;
begin
   Result   := False;
   ListaArq := TStringList.Create;
   try
      FTP.ChangeDir(Diretorio);
      FTP.List(ListaArq, '', False);
      for I := 0 to ListaArq.Count - 1 do
      begin
         if SameText(ListaArq[I], NomeArquivo) then
         begin
            Result := True;
            Break;
         end;
      end;
   finally
      ListaArq.Free;
   end;end;
end.

// ......... Exemplo de uso ......... //
(*procedure TForm1.ConectarSalvarArquivoFTP;
var
  FTP: TIdFTP;
  ListaDeArquivos: TStringList;
begin
  FTP := TIdFTP.Create(nil);
  ListaDeArquivos := TStringList.Create;
  try
    ConectarFTP(FTP, 'ftp.meuservidor.com', 'usuario', 'senha');

    // Cria um diretório
    CriarDiretorioFTP(FTP, 'NovoDiretorio');

    // Envia um arquivo
    EnviarArquivoFTP(FTP, 'C:\Caminho\Para\Arquivo.txt', 'NovoDiretorio/Arquivo.txt');

    // Baixa um arquivo
    BaixarArquivoFTP(FTP, 'NovoDiretorio/Arquivo.txt', 'C:\Caminho\Para\Baixar\Arquivo.txt');

    // Lista arquivos no diretório
    ListarArquivosFTP(FTP, ListaDeArquivos, 'NovoDiretorio');
    ShowMessage(ListaDeArquivos.Text); // Exibe a lista de arquivos

    // Desconectar
    FTP.Disconnect;
  finally
    FTP.Free;
    ListaDeArquivos.Free;
  end;
end;

procedure TForm1.VerificarArquivoNoFTP;
var
  FTP: TIdFTP;
  ExisteArquivo: Boolean;
begin
  FTP := TIdFTP.Create(nil);
  try
    // Configurações de conexão
    FTP.Host := 'ftp.meuservidor.com';
    FTP.Username := 'usuario';
    FTP.Password := 'senha';
    FTP.Connect;
    // Verifica se o arquivo existe no diretório especificado
    ExisteArquivo := ArquivoExisteFTP(FTP, '/DiretorioDeTeste', 'meuarquivo.txt');
    if ExisteArquivo then
      ShowMessage('O arquivo existe no diretório FTP.')
    else
      ShowMessage('O arquivo NÃO existe no diretório FTP.');
    // Desconecta após a verificação
    FTP.Disconnect;
  finally
    FTP.Free;
  end;
end;

*)
