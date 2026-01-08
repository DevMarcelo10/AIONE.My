unit uVeChaves;

interface

uses Dialogs, System.SysUtils, Vcl.Forms, Variants, System.DateUtils,
     System.StrUtils, System.Types, uRESTDWBasicDB, uRESTDWParams,
     System.Classes, IdHttp, WinInet;

     function VerificaKEY:String;
     function IsInternetConnected:Boolean;

const
   Chave = 'MYZR968@358a&48fx29@QDz9e4wyI2hqJc68dDDbNT9jKdHlLvqoSXe7TWA';

implementation

uses uDWServer, MarcFMX;

function VerificaKEY:String;
var
   Lista:TStringList;
   DWParams:TRESTDWParams;
   MsgErro,LOCDEMO,Retorno:String;
begin
   Result := 'ERROR';

   Lista := TStringList.Create;
   try
      try
         if not IsInternetConnected then
            raise Exception.Create('Sem de Internet no momento, favor verificar.');
         if not FileExists(ExtractFilePath(ParamStr(0))+'recsystem.dat') then
            raise Exception.Create('Arquivo de registro não encontrado.'+#10+'Contatar suporte AIONE.');
         Lista.LoadFromFile(ExtractFilePath(ParamStr(0))+'recsystem.dat');
         Retorno := MarcCripto('D',Lista[0],Chave);
         Lista.Delimiter := '|';
         Lista.DelimitedText := Retorno;
         if Lista.Count <= 0 then
            raise Exception.Create('Arquivo de registro inválido.'+#10+'Contatar suporte AIONE.');
         if (not ValidaCNPJ(Lista[1])) or (not IsNumeric(Lista[2])) or (not IsNumeric(Lista[3])) then
            raise Exception.Create('Arquivo de registro inválido.'+#10+'Contatar suporte AIONE.');
         gCNPJEMP := Lista[1];
         FARMACIA := Lista[2];
         FILIAL   := Lista[3];
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog,'ERRO: IAServer'+E.Message);
            MessageDlg('IAServer '+E.Message, mtError, [mbOk], 0);
            Exit;
         end;
      end; //try
   finally
      Lista.Free;
   end;

   if not Ping(IPSERVER, DWPort)  then
   begin
      MessageDlg('Não foi possível conectar.'+#10+'Perda temporária de conexão com servidor!', mtError, [mbOk], 0);
      Exit;
   end;

   try
      MsgErro  := '';
      DWParams := TRESTDWParams.Create;
      FrmServer.DWClientEvents.CreateDWParams('ValidaKey', DWParams);
      DWParams.ItemsString['Farmacia'].AsString := FARMACIA;
      DWParams.ItemsString['Filial'].AsString   := FILIAL;
      try
         FrmServer.DWClientEvents.SendEvent('ValidaKey', DWParams, MsgErro);
         if DWParams.ItemsString['Result'].AsString = '' then
         begin
            if gCNPJEMP <> OnlyNumbers(DWParams.ItemsString['CNPJ'].AsString) then
            begin
               SalvaLog(ArqLog,'INVÁLIDO: CNPJ do arquivo de registro diferente do cadastro.');
               raise Exception.Create('CNPJ não autorizado.'+#10+'Contatar suporte AIONE.');
            end;
            Result := DWParams.ItemsString['Empresa'].AsString.Trim+' - '+DWParams.ItemsString['CNPJ'].AsString.Trim;
         end else
         begin
            if DWParams.ItemsString['Result'].AsString <> '' then
            begin
               SalvaLog(ArqLog,'ERRO: Não foi possível SendEvent(ValidaKey)'+#10+DWParams.ItemsString['Result'].AsString);
               raise Exception.Create('Não foi possível acessar o servidor.'+#10+DWParams.ItemsString['Result'].AsString);
            end;
         end;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog,'ERRO: Não foi possível iniciar aplicação, sem acesso ao servidor AIONE. - > '+E.Message);
            MessageDlg('Não foi possível iniciar aplicação.'+#10+E.Message, mtError, [mbOk], 0);
            Exit;
         end;
      end; //try
   finally
      FreeAndNil(DWParams);
   end;
end;

function IsInternetConnected:Boolean;
var
   IdHTTP:TIdHTTP;
   dwConnectionTypes:DWORD;
begin
   dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
   Result := InternetGetConnectedState(@dwConnectionTypes, 0);
   if Result then
   begin
      IdHTTP := TIdHTTP.Create(nil);
      try
         try
            IdHTTP.Get('http://www.google.com');
            Result := True;
         except
            on E:Exception do
            begin
               SalvaLog(ArqLog,'ERRO: Não foi possível acessar site de consulta internet'+E.Message);
               Result := False;
            end;
         end;
      finally
         IdHTTP.Free;
      end;
   end; //if
end;

end.

