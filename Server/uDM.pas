unit uDM;

interface

uses
  SysUtils, Classes, System.JSON, Dialogs, FireDAC.Dapt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Phys.FB,FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Stan.StorageJSON,
  FireDAC.Phys.MSSQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.Intf, FireDAC.Phys.MySQL, Vcl.ExtCtrls,  Winapi.ShellAPI, Variants,
  FireDAC.Comp.DataSet, MarcFMX, VCL.Forms, IdCoderMIME, System.Math, System.StrUtils,
  System.DateUtils, uRESTDWDatamodule, uRESTDWParams, uRESTDWServerContext,
  uRESTDWIdBase,uRESTDWServerEvents, uRESTDWBasic, uRestDWDriverFD, uRESTDWBasicDB,
  uRESTDWComponentBase, uRESTDWBasicClass;

const
  WelcomeSample = False;

type
  TDMServer = class(TServerMethodDataModule)
    RESTDWPoolerDB: TRESTDWPoolerDB;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDConnect: TFDConnection;
    RESTDWDriverFD: TRESTDWDriverFD;
    DWServerEvents: TRESTDWServerEvents;
    procedure ServerMethodDataModuleDestroy(Sender: TObject);
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure DWServerEvents1EventsDownloadFileReplyEvent(var Params:TRESTDWParams; var Result: string);
    procedure DWServerEvents1EventsDataServerReplyEvent(var Params:TRESTDWParams; var Result: string);
    procedure DWServerEvents1EventsUpLoadFileReplyEvent(var Params:TRESTDWParams; var Result: string);
    procedure DWServerEventsEventsFraseIAReplyEvent(var Params: TRESTDWParams; var Result: string);
    procedure DWServerEventsEventsVersaoAppReplyEvent(var Params: TRESTDWParams; var Result: string);
    procedure DWServerEventsEventsDownloadFileReplyEvent(var Params: TRESTDWParams; var Result: string);
    procedure DWServerEventsEventsValidaKeyReplyEvent(var Params: TRESTDWParams; var Result: string);
  private
    IdHD:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMServer: TDMServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses uDWServer;

procedure TDMServer.ServerMethodDataModuleCreate(Sender: TObject);
begin
   IdHD := ExtractDiskSerial('C');
   ArqLog := ExtractFileDir(Application.ExeName)+'\doc\';
   if not DirectoryExists(ArqLog) then CreateDir(ArqLog);
   RESTDWPoolerDB.Active := True;
end;

procedure TDMServer.DWServerEvents1EventsDataServerReplyEvent(var Params:TRESTDWParams; var Result: string);
begin
   Params.ItemsString['DataNow'].AsDateTime := Now;
end;

procedure TDMServer.DWServerEvents1EventsDownloadFileReplyEvent(var Params:TRESTDWParams; var Result: string);
var
   vArquivo:String;
   vFile:TMemoryStream;
begin
   if Params.ItemsString['Arquivo'] <> nil then
   begin
      vFile := TMemoryStream.Create;
      try
         try
            vArquivo := DirName+Trim(Params.ItemsString['Arquivo'].AsString);
            if vArquivo <> '' Then
            begin
               if FileExists(vArquivo) then
               begin
                  vFile.LoadFromFile(vArquivo);
                  vFile.Position  := 0;
                  Params.ItemsString['Result'].LoadFromStream(vFile);
               end;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(ArqLog,'IASERVER - ERRO: tentando DownloadFile: '+vArquivo+' -> '+E.Message);
               Exit;
            end;
         end;
      finally
         FreeAndNil(vFile);
      end;
   end; //if
end;

procedure TDMServer.DWServerEvents1EventsUpLoadFileReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   JSONValue: TJSONValue;
   vArquivo,vDiretorio: String;
   vFileIn,vFile:TMemoryStream;
begin
   if Params.ItemsString['arquivo'] <> nil Then
   begin
      vDiretorio := '';
      if Params.ItemsString['diretorio'] <> nil then
      begin
         if Params.ItemsString['diretorio'].AsString <> '' then
         begin
            vDiretorio := IncludeTrailingPathDelimiter(Params.ItemsString['diretorio'].AsString);
            ForceDirectories(vDiretorio);
         end;
      end; //if
      JSONValue := TJSONValue.Create;
      JSONValue.Encoding := Encoding;
      vArquivo := vDiretorio + Trim(ExtractFileName(Params.ItemsString['arquivo'].AsString));
      if FileExists(vArquivo) then DeleteFile(vArquivo);
      vFileIn := TMemoryStream.Create;
      Params.ItemsString['filesend'].SaveToStream(vFileIn);
      try
         vFileIn.Position   := 0;
         vFileIn.SaveToFile(vArquivo);
      finally
         if Params.ItemsString['result'] <> nil then Params.ItemsString['result'].AsBoolean := (vFileIn.Size > 0);
         vFileIn.Clear;
         vFileIn.Free;
      end;
   end; //if
end;

procedure TDMServer.DWServerEventsEventsDownloadFileReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   vArquivo:String;
   vFile:TMemoryStream;
begin
   if Params.ItemsString['Arquivo'] <> nil then
   begin
      vFile := TMemoryStream.Create;
      try
         try
            vArquivo := DirName+Trim(Params.ItemsString['Arquivo'].AsString);
            if vArquivo <> '' then
            begin
               if FileExists(vArquivo) then
               begin
                  vFile.LoadFromFile(vArquivo);
                  vFile.Position  := 0;
                  Params.ItemsString['Result'].LoadFromStream(vFile);
               end
               else SalvaLog(ArqLog,'IASERVER - ERRO -> DownloadFile -> Não achou aquivo na pasta: '+vArquivo);
            end
            else SalvaLog(ArqLog,'IASERVER - ERRO -> DownloadFile -> Não achou aquivo na pasta: '+vArquivo);
         except
            on E:Exception do
            begin
               SalvaLog(ArqLog,'IASERVER - ERRO: tentando DownloadFile: vArquivo está vazio.');
               Exit;
            end;
         end;
      finally
         FreeAndNil(vFile);
      end;
   end; //if
end;

// -------------------- Retorna Frase IA -------------------- //
procedure TDMServer.DWServerEventsEventsFraseIAReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   SQLAuxi:TFDQuery;
   auxNroPos:Integer;
begin
   if Params.ItemsString['Etapa'] = nil then Exit;
   SQLAuxi := TFDQuery.Create(nil);
   try
      try
         SQLAuxi.Connection := FDConnect;
         SQLAuxi.SQL.Text   := 'SELECT Frase FROM dbaiserver.arqfrasesia WHERE Etapa = '+Aspas(Params.ItemsString['Etapa'].AsString)+
         ' AND IndSub = '+Params.ItemsString['IndSub'].AsString;
         SQLAuxi.Open;
         if SQLAuxi.IsEmpty then
         begin
            Params.ItemsString['Frase'].AsString := '';
            Exit;
         end;
         auxNroPos := RandomRange(1, SQLAuxi.RecordCount);
         if auxNroPos > 0 then SQLAuxi.MoveBy(auxNroPos);
         Params.ItemsString['Frase'].AsString := SQLAuxi.FieldByName('Frase').AsAnsiString;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog,'IASERVER - ERRO -> FraseIAReply -> Etapa: '+Params.ItemsString['Etapa'].AsString+'  IndSub: '+Params.ItemsString['IndSub'].AsString+' = '+E.Message);
            Exit;
         end;
      end;
   finally
      SQLAuxi.Close;
      FreeAndNil(SQLAuxi);
   end;
end;

// --------------- Valida a Chave de Registro da Filial no Servidor --------------- //
procedure TDMServer.DWServerEventsEventsValidaKeyReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   SQLInter:TFDQuery;
   MsgErro,FARMA,FILIAL:String;
begin
   MsgErro := '';
   if (Params.ItemsString['Farmacia'] <> nil) and (Params.ItemsString['Filial'] <> nil) then
   begin
      FARMA    := Params.ItemsString['Farmacia'].AsString;
      FILIAL   := Params.ItemsString['Filial'].AsString;
      SQLInter := TFDQuery.Create(nil);
      try
         try
            FDConnect.Connected := False;
            FDConnect.Connected := True;
            SQLInter.Connection := FDConnect;
            SQLInter.SQL.Text := 'SELECT Venlic,Indati FROM arqfarmacias WHERE IDFarm = '+FARMA;
            SQLInter.Open;
            if not SQLInter.IsEmpty then
            begin
               if not SQLInter.FieldByName('Indati').AsBoolean then MsgErro := 'Farmácia não está ativada!' else
               if SQLInter.FieldByName('Venlic').AsDateTime < Date then MsgErro := 'Licença expirada!' else
            end
            else MsgErro := 'Não encontrada Farmácia Cliente!';

            if MsgErro = '' then
            begin
               SQLInter.Close;
               SQLInter.SQL.Text := 'SELECT Nomfar,CnpjFar,Indati FROM arqfiliais WHERE IDFarm = '+FARMA+' AND IDFilial = '+FILIAL;
               SQLInter.Open;
               if not SQLInter.IsEmpty then
               begin
                  if SQLInter.FieldByName('Indati').AsBoolean then
                  begin
                     Params.ItemsString['Empresa'].AsString := SQLInter.FieldByName('Nomfar').AsString.Trim;
                     Params.ItemsString['CNPJ'].AsString    := FormataCNPJ(SQLInter.FieldByName('CnpjFar').AsString);
                  end
                  else MsgErro := 'Filial não ativa!';
               end
               else MsgErro := 'Não encontrado Filial na Empresa!';
            end; //if
         except
            on E:Exception do
            begin
               MsgErro := 'Erro de conexão com servidor!';
               SalvaLog(ArqLog,'IASERVER - ERRO -> EventsValidaKey: FARMACIA '+FARMA+' FILIAL: '+FILIAL+' = '+E.Message);
            end;
         end;
      finally
         SQLInter.Close;
         FreeAndNil(SQLInter);
         FDConnect.Close;
      end; //try
   end
   else MsgErro := 'Não há parâmetros para conexão.';
   Params.ItemsString['Result'].AsString := MsgErro;
end;

procedure TDMServer.DWServerEventsEventsVersaoAppReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   QueAuxi:TFDQuery;
begin
   try
      Params.ItemsString['Versao'].AsString   := '0';
      Params.ItemsString['VersaoDB'].AsString := '0';
      try
         FDConnect.Connected := False;
         FDConnect.Connected := True;
         QueAuxi := TFDQuery.Create(nil);
         QueAuxi.Connection := FDConnect;
         QueAuxi.SQL.Text   := 'SELECT VerERP FROM dbaiserver.arqpage LIMIT 1';
         QueAuxi.Open;
         Params.ItemsString['Versao'].AsString   := QueAuxi.FieldByName('VerERP').AsString;
         QueAuxi.Close;
         QueAuxi.SQL.Text   := 'SELECT VerDB FROM dbaione.arqparametros LIMIT 1';
         QueAuxi.Open;
         Params.ItemsString['VersaoDB'].AsString := QueAuxi.FieldByName('VerDB').AsString;
      except
         on E:Exception do
         begin
            SalvaLog(ArqLog,'ERRO -> EventsVersaoApp = '+E.Message);
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      FDConnect.Close;
   end;
end;

procedure TDMServer.ServerMethodDataModuleDestroy(Sender: TObject);
begin
   FDConnect.Close;
   RESTDWPoolerDB.Active := False;
end;

end.

