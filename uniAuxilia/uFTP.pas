unit uFTP;

interface

uses
   IdFTP, IdComponent, SysUtils, Classes;

   function CriarDiretorioFTP(FTP: TIdFTP; const Diretorio: string; out MsgErro: string): Boolean;
   function EnviarArquivoFTP(FTP: TIdFTP; const ArquivoLocal, ArquivoRemoto: string; out MsgErro: string): Boolean;
   function BaixarArquivoFTP(FTP: TIdFTP; const ArquivoRemoto, ArquivoLocal: string; out MsgErro: string): Boolean;
   function ListarArquivosFTP(FTP: TIdFTP; ListaDeArquivos: TStrings; const Diretorio: string; out MsgErro: string): Boolean;
   function ArquivoExisteFTP(FTP: TIdFTP; const Diretorio, NomeArquivo: string; out MsgErro: string): Boolean;

implementation

function CriarDiretorioFTP(FTP: TIdFTP; const Diretorio: string; out MsgErro: string): Boolean;
begin
   Result  := False;
   MsgErro := '';
   try
      if not FTP.Connected then
      begin
         MsgErro := 'FTP não conectado';
         Exit;
      end;
      FTP.MakeDir(Diretorio);
      Result := True;
   except
      on E: Exception do
         MsgErro := 'Erro ao criar diretório FTP: ' + E.Message;
   end;
end;

function EnviarArquivoFTP(FTP: TIdFTP; const ArquivoLocal, ArquivoRemoto: string; out MsgErro: string): Boolean;
begin
   Result  := False;
   MsgErro := '';
   try
      if not FTP.Connected then
      begin
         MsgErro := 'FTP não conectado';
         Exit;
      end;
      FTP.Put(ArquivoLocal, ArquivoRemoto, False);
      Result := True;
   except
      on E: Exception do
         MsgErro := 'Erro ao enviar arquivo FTP: ' + E.Message;
   end;
end;

function BaixarArquivoFTP(FTP: TIdFTP; const ArquivoRemoto, ArquivoLocal: string; out MsgErro: string): Boolean;
begin
   Result  := False;
   MsgErro := '';
   try
      if not FTP.Connected then
      begin
         MsgErro := 'FTP não conectado';
         Exit;
      end;
      FTP.Get(ArquivoRemoto, ArquivoLocal, True);
      Result := True;
   except
      on E: Exception do
         MsgErro := 'Erro ao baixar arquivo FTP: ' + E.Message;
   end;
end;

function ListarArquivosFTP(FTP: TIdFTP; ListaDeArquivos: TStrings; const Diretorio: string; out MsgErro: string): Boolean;
begin
   Result  := False;
   MsgErro := '';
   try
      if not FTP.Connected then
      begin
         MsgErro := 'FTP não conectado';
         Exit;
      end;
      FTP.ChangeDir(Diretorio);
      FTP.List(ListaDeArquivos, '', False);
      Result := True;
   except
      on E: Exception do
         MsgErro := 'Erro ao listar arquivos FTP: ' + E.Message;
   end;
end;

function ArquivoExisteFTP(FTP: TIdFTP; const Diretorio, NomeArquivo: string; out MsgErro: string): Boolean;
var
   I: Integer;
   ListaArq: TStringList;
begin
   Result  := False;
   MsgErro := '';
   ListaArq := TStringList.Create;
   try
      try
         if not FTP.Connected then
         begin
            MsgErro := 'FTP não conectado';
            Exit;
         end;
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
      except
         on E: Exception do
            MsgErro := 'Erro ao verificar arquivo FTP: ' + E.Message;
      end;
   finally
      ListaArq.Free;
   end;
end;

end.
