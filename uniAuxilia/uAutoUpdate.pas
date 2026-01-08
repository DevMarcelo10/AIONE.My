unit uAutoUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, AdvGlowButton, System.Zip, MarcLib,
  Winapi.ShellAPI, uRESTDWServerEvents, IdComponent, AdvPanel, LMDControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, AdvSmoothProgressBar,
  Vcl.Imaging.pngimage, LMDCustomControl, uRESTDWParams, MySQLSchemaSync,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.DApt,
  uRESTDWBasicDB;

type
  TSyncResult = record
    DDLCount: Integer;
    Applied: Integer;
  end;

  TFrmAutoUpdate = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    Image1: TImage;
    lbEmpresa: TLabel;
    PanelButons: TAdvPanel;
    btAtualizar: TAdvGlowButton;
    btCancelar: TAdvGlowButton;
    Progress: TAdvSmoothProgressBar;
    lbStatus: TLabel;
    MemoLog: TMemo;
    procedure FormShow(Sender: TObject);
    procedure RESTClientPooler1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure RESTClientPooler1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure RESTClientPooler1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure btCancelarClick(Sender: TObject);
    procedure GetLocalVersion(out VerLocApp,VerLocDB:Integer);
    procedure GetNewVersion(out recVersaoApp,recVersaoDB:Integer);
    procedure ReStart;
    function  DownloadUpdate:Boolean;
    function  UnZip:Boolean;
    procedure btAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function  RunSync(const SrcHost, SrcDB, SrcUser, SrcPass: string; SrcPort: Integer;
              const DstHost, DstDB, DstUser, DstPass: string; DstPort: Integer;
              const Apply, DropExtras, IncludeTriggers: Boolean;
              out OutPlan: TStringList): TSyncResult;
  private
    { Private declarations }
    indWork:Boolean;
    FBytesToTransfer:Int64;
    VersaoApp,VersaoDB,VersaoAppLoc,VersaoDBLoc:Integer;
    NomeExe,NomeZip,DirName,DirDest:String;
  public
    { Public declarations }
  end;

var
  FrmAutoUpdate: TFrmAutoUpdate;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmAutoUpdate.FormCreate(Sender: TObject);
begin
   indWork := False;
end;

procedure TFrmAutoUpdate.FormShow(Sender: TObject);
begin
   NomeExe := ExtractFileName(Application.ExeName);
   NomeZip := ChangeFileExt(NomeExe,'.zip');
   DirName := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
   DirDest := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+IncludeTrailingPathDelimiter('Atualiza');
   GetLocalVersion(VersaoAppLoc, VersaoDBLoc);
   GetNewVersion(VersaoApp, VersaoDB);
   if (VersaoApp <= VersaoAppLoc) and (VersaoDB <= VersaoDBLoc) then
   begin
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   Visible := True;
   Height  := 285;
   lbStatus.Visible    := False;
   PanelButons.Visible := True;
   //lbStatus.Caption := 'Existe uma nova versão do disponível.';
end;

procedure TFrmAutoUpdate.RESTClientPooler1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
   if not indWork then Exit;
   if FBytesToTransfer = 0 then Exit;
   Progress.Position := AWorkCount;
end;

procedure TFrmAutoUpdate.RESTClientPooler1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
   if not indWork then Exit;
   FBytesToTransfer := AWorkCountMax;
   Progress.Maximum := FBytesToTransfer;
   Progress.Position := 0;
end;

procedure TFrmAutoUpdate.RESTClientPooler1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
   if not indWork then Exit;
   Progress.Position := FBytesToTransfer;
   FBytesToTransfer := 0;
end;

// ------- Retorna o Número da Versão do Sistema ------- //
procedure TFrmAutoUpdate.GetLocalVersion(out VerLocApp,VerLocDB:Integer);
var
   QueAuxi:TRESTDWClientSQL;
   VerInfo:Pointer;
   VerValue:PVSFixedFileInfo;
   VerInfoSize,VerValueSize,Dummy,V1,V2,V3,V4:DWORD;
begin
   VerLocApp   := 0;
   VerLocDB    := 0;
   VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
   if VerInfoSize > 0 then
   begin
      GetMem(VerInfo, VerInfoSize);
      try
        if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then
        begin
           VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
           with VerValue^ do
           begin
              V1 := dwFileVersionMS shr 16;
              V2 := dwFileVersionMS and $FFFF;
              V3 := dwFileVersionLS shr 16;
              V4 := dwFileVersionLS and $FFFF;
           end; //with
           VerLocApp := StrToInt(IntToStr(V1)+IntToStr(V2)+StrZero(IntToStr(V3),2));
        end; //if
      finally
         FreeMem(VerInfo, VerInfoSize);
      end;
   end; //if

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT VerDB FROM arqparametros LIMIT 1';
         QueAuxi.Open;
         VerLocDB := QueAuxi.FieldByName('VerDB').AsInteger;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível atualizar Schema do DB ao tentar abrir arqparametros.'+E.Message);
            MostraMsg('Erro', 'Não foi possível atualizar Schema do Banco de Dados', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

// ----- Retorna Número Versão Atualizada do Sistema ----- //
procedure TFrmAutoUpdate.GetNewVersion(out recVersaoApp,recVersaoDB:Integer);
var
   vErrorMsg:String;
   DWParams:TRESTDWParams;
begin
   try
      recVersaoApp := 0;
      recVersaoDB  := 0;
      DWParams     := TRESTDWParams.Create;
      try
         DM.DWClientAIONE.CreateDWParams('VersaoApp', DWParams);
         DM.DWClientAIONE.SendEvent('VersaoApp', DWParams, vErrorMsg);
         recVersaoApp := DWParams.ItemsString['Versao'].AsInteger;
         recVersaoDB  := DWParams.ItemsString['VersaoDB'].AsInteger;
      finally
         DWParams.Free;
      end;
   except
   end;
end;

function TFrmAutoUpdate.DownloadUpdate:Boolean;
var
   vErrorMsg:String;
   DWParams:TRESTDWParams;
   StringStream:TStringStream;
begin
   lbStatus.Caption := 'Executando download da nova versão...';
   Application.ProcessMessages;
   Result   := True;
   DWParams := TRESTDWParams.Create;
   try
      try
         DM.DWClientEvents.CreateDWParams('DownloadFile', DWParams);
         DWParams.ItemsString['Arquivo'].AsString := NomeZip;
         DM.DWClientEvents.SendEvent('DownloadFile', DWParams, vErrorMsg);
         if vErrorMsg = '' then
         begin
            StringStream := TStringStream.Create('');
            DWParams.ItemsString['Result'].SaveToStream(StringStream);
            try
               if not DirectoryExists(DirDest) then CreateDir(DirDest);
               ForceDirectories(ExtractFilePath(DirDest+NomeZip));
               if FileExists(DirDest + NomeZip) then DeleteFile(PWideChar(DirDest+NomeZip));
               StringStream.SaveToFile(DirDest+NomeZip);
               StringStream.SetSize(0);
            finally
               FreeAndNil(StringStream);
            end; //try
         end
         else raise Exception.Create(vErrorMsg);
      except
         on E:Exception do
         begin
            Result := False;
            MessageDlg('Não foi possível atualizar.'+#10+E.Message,mtError,[mbOk], 0);
         end; //try
      end;
   finally
      FreeAndNil(DWParams);
   end; //try
   if not Result then
   begin
      Self.Close;
      Application.Terminate;
   end;
end;

function TFrmAutoUpdate.UnZip:Boolean;
var
   UnZipper: TZipFile;
begin
   lbStatus.Caption := 'Descompactando atualização...';
   Application.ProcessMessages;
   try
      if FileExists(DirDest+NomeExe) then DeleteFile(PWideChar(DirDest+NomeExe));
      UnZipper := TZipFile.Create();
      UnZipper.Open(DirDest+NomeZip, zmRead);
      UnZipper.ExtractAll(DirDest);
      UnZipper.Close;
      Result := True;
   except
      Result := False;
      MessageDlg('Não foi possível atualizar.'+#10+'Arquivo compactado foi corrompido!',mtError,[mbOk], 0);
      Self.Close;
      Application.Terminate;
   end;
   FreeAndNil(UnZipper);
end;

procedure TFrmAutoUpdate.ReStart;
var
   Lista:TStringList;
   BatchName,NomeDos:String;
begin
   lbStatus.Caption := 'Reiniciando o sistema...';
   Application.ProcessMessages;
   try
      BatchName := DirDest+'atualiza.bat';
      NomeDos   := DirName+NomeExe;
      Lista := TStringList.Create;
      Lista.Clear;
      FileSetAttr(ParamStr(0),0);
      Lista.Add(':Label1');
      Lista.Add('@echo off');
      Lista.Add('del '+NomeDos);
      Lista.Add('if Exist '+NomeDos+' goto Label1');
      Lista.Add('Move '+NomeExe+' '+NomeDos);
      Lista.Add('Call '+NomeDos);
      Lista.Add('RMDIR '+DirDest+' /S /Q');
      Lista.Add(DirName+NomeExe);
      Lista.SaveToFile(BatchName);
      ChDir(DirDest);
      ShellExecute(0, nil,'cmd.exe', PWideChar('/c '+'"'+BatchName+'"'),nil,SW_HIDE);
   finally
      Lista.Free;
      Application.Terminate;
   end;
end;

procedure TFrmAutoUpdate.btAtualizarClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   Plan: TStringList;
   R: TSyncResult;
begin
   PanelButons.Visible := False;
   Self.Height := 175;
   Application.ProcessMessages;
   try
      if (VersaoApp <= VersaoAppLoc) and (VersaoDB <= VersaoDBLoc) then
      begin
         ShowMessage('Versão já atualizada');
         Exit;
      end;

      // ----- Sincroniza Schemas do banco de Dados ----- //
      if VersaoDBLoc < VersaoDB then
      begin
         try
            R := RunSync(IPAIONE,'dbaione','root','f68interdb', 3307,
                         IPLocal, 'dbaione','root','f68interdb', 3307, True, True, True, Plan);
            try
               MemoLog.Lines.Add(Format('Plano: %d DDLs; Aplicados: %d', [R.DDLCount, R.Applied]));
               MemoLog.Lines.AddStrings(Plan); // opcional
            finally
               Plan.Free;
            end;

            // QueAuxi := TRESTDWClientSQL.Create(nil);
            // QueAuxi.DataBase := DM.DWDataBase;
            // QueAuxi.SQL.Text := 'UPDATE arqparametros SET VerDB = '+VersaoDB.ToString;
            // QueAuxi.ExecSQL;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, '[ERRO] Tentativa de atualizar Schema do banco de dados (uAutoUpdate) -> '+E.Message);
               ShowMessage('Erro: '+E.Message);
            end;
         end; //try
      end; //if

      // ------ Atualiza Sistema AIONE.EXE ------ //
      if VersaoApp > VersaoAppLoc then
      begin
         DM.DownNewVersao := True;
         indWork := True;
         lbStatus.Visible := True;
         Application.ProcessMessages;
         if not DownloadUpdate then Exit;
         if not UnZip then Exit;
      end; //if
   except
      Self.Close;
      Application.Terminate;
   end;
   if VersaoApp > VersaoAppLoc then
        ReStart
   else Close;
end;

procedure TFrmAutoUpdate.btCancelarClick(Sender: TObject);
begin
   DM.DownNewVersao := True;
   Application.Terminate;
end;

function NewMySQL(const Host,DB,User,Pass:String; Port: Integer = 3307): TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.Params.Values['DriverID']     := 'MySQL';
  Result.Params.Values['Server']       := Host;
  Result.Params.Values['Port']         := Port.ToString;
  Result.Params.Values['Database']     := DB;
  Result.Params.Values['User_Name']    := User;
  Result.Params.Values['Password']     := Pass;
  Result.Params.Values['CharacterSet'] := 'utf8mb3';
//Result.Params.Values['SSLMode'] := 'required'; // se precisar TLS
end;

function TFrmAutoUpdate.RunSync(const SrcHost, SrcDB, SrcUser, SrcPass: string; SrcPort: Integer;
  const DstHost, DstDB, DstUser, DstPass: string; DstPort: Integer;
  const Apply, DropExtras, IncludeTriggers: Boolean;
  out OutPlan: TStringList): TSyncResult;
var
  ConnSrc, ConnDst: TFDConnection;
  Opt: TSyncOptions;
  Plan: TStringList;
  i: Integer;
begin
  Result.DDLCount := 0;
  Result.Applied := 0;
  OutPlan := nil;
  ConnSrc := nil;
  ConnDst := nil;
  Plan := nil;

  try
    ConnSrc := NewMySQL(SrcHost, SrcDB, SrcUser, SrcPass, SrcPort);
    ConnDst := NewMySQL(DstHost, DstDB, DstUser, DstPass, DstPort);
    ConnSrc.Connected := True;
    ConnDst.Connected := True;

    // Opções mínimas (sempre gera plano; aplicação fica aqui fora)
    SetSyncDryRun(True);          // primeiro: DRY-RUN (apenas gera plano .sql)
    Opt.Execute := False;
    Opt.DropExtras := True;       // <- necessário para ficar "EXATAMENTE IGUAL"
    Opt.IncludeTriggers := True;
    Opt.TargetDefaultEngine  := 'InnoDB';
    Opt.TargetDefaultCharset := 'utf8mb3';
    Opt.TargetDefaultCollation := 'utf8mb3_bin';

    // Gera plano
    Result.DDLCount := CompareAndSyncSchemas(ConnSrc, ConnDst, SrcDB, DstDB, Opt, Plan);
    OutPlan := TStringList.Create;
    OutPlan.Assign(Plan);

    // Aplica se solicitado
    if Apply and (Plan.Count > 0) then
    begin

Plan.SaveToFile('.\PLAN.SQL');
Exit;

      ConnDst.StartTransaction;
      try
        for i := 0 to Plan.Count - 1 do
        begin
          // Por quê: manter ordem planejada reduz conflitos de dependência
          ConnDst.ExecSQL(Plan[i]);
          Inc(Result.Applied);
        end;
        ConnDst.Commit;
      except
        on E: Exception do
        begin
          ConnDst.Rollback;
          raise; // deixe o caller tratar/mostrar E.Message
        end;
      end;
    end;
  finally
    Plan.Free;
    ConnSrc.Free;
    ConnDst.Free;
  end;
end;

end.
