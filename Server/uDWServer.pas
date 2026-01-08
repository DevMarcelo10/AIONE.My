unit uDWServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Forms, Vcl.Graphics, Vcl.Controls, Vcl.Dialogs, Winapi.IpTypes, Vcl.ExtCtrls,
  FireDAC.Stan.StorageJSON, Vcl.AppEvnts, Vcl.StdCtrls, Web.HTTPApp, Vcl.ComCtrls,
  Vcl.Imaging.Jpeg, Vcl.Imaging.Pngimage, Vcl.Menus, FireDAC.UI.Intf, Data.DB,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Phys.FB,
  FireDAC.Stan.Error, FireDAC.Stan.Def, FireDAC.Stan.Pool,FireDAC.Phys, MarcFMX,
  FireDAC.Stan.Async, FireDAC.Comp.Client, uRESTDWIdBase, uRESTDWBasic,
  uRESTDWComponentBase, System.Threading, UnitTypes, System.Generics.Collections;

type
  TFrmServer = class(TForm)
    Label8: TLabel;
    AppEvents: TApplicationEvents;
    CtiPrincipal: TTrayIcon;
    PmMenu: TPopupMenu;
    RestaurarAplicao1: TMenuItem;
    N5: TMenuItem;
    SairdaAplicao1: TMenuItem;
    Panel1: TPanel;
    imgLogo: TImage;
    ButtonStart: TButton;
    ButtonStop: TButton;
    Timer: TTimer;
    DWPooler: TRESTDWIdServicePooler;
    procedure AppEventsIdle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure CtiPrincipalDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SairdaAplicao1Click(Sender: TObject);
    procedure RestaurarAplicao1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure StartServer;
    procedure ChangeStatusWindow;
    procedure HideApplication;
    function  GetHandleOnTaskBar:THandle;
  public
    { Public declarations }
    procedure ShowApplication;
    procedure ShowBalloonTips(IconMessage: Integer = 0; MessageValue:String = '');
  end;

var
  FrmServer: TFrmServer;
  StartDir:String;
  DirName:String = '.\Atualizacoes\';
  PastaCMED:String = '';
  ArqLog:String = '';

implementation

{$IFDEF FPC} {$R *.lfm}  {$ELSE} {$R *.dfm} {$ENDIF}

uses uDM, DownloadCMED, uIBPTCapa, uIBPTUpdater;

procedure TFrmServer.FormCreate(Sender: TObject);
begin
   PastaCMED := ExtractFileDir(Application.ExeName)+'\CMED';
   DWPooler.ServerMethodClass := TDMServer;
   ArqLog := ExtractFileDir(Application.ExeName)+'\doc\';
end;

function TFrmServer.GetHandleOnTaskBar: THandle;
begin
   Result := Application.Handle;
end;

procedure TFrmServer.ChangeStatusWindow;
begin
  if Self.Visible Then
       SairdaAplicao1.Caption := 'Minimizar para a bandeja'
  else SairdaAplicao1.Caption := 'Sair da Aplicação';
  Application.ProcessMessages;
end;

procedure TFrmServer.CtiPrincipalDblClick(Sender: TObject);
begin
   ShowApplication;
end;

procedure TFrmServer.HideApplication;
begin
   CtiPrincipal.Visible     := True;
   Application.ShowMainForm := False;
   if Self <> nil then Self.Visible := False;
   Application.Minimize;
   ShowWindow(GetHandleOnTaskBar, SW_HIDE);
   ChangeStatusWindow;
end;

procedure TFrmServer.RestaurarAplicao1Click(Sender: TObject);
begin
   ShowApplication;
End;

procedure TFrmServer.ShowApplication;
begin
   CtiPrincipal.Visible     := False;
   Application.ShowMainForm := True;
   if Self <> nil then
   begin
      Self.Visible     := True;
      Self.WindowState := WsNormal;
   end;
   ShowWindow(GetHandleOnTaskBar, SW_SHOW);
   ChangeStatusWindow;
end;

procedure TFrmServer.ShowBalloonTips(IconMessage: Integer = 0; MessageValue:String = '');
begin
   case IconMessage of
     0: CtiPrincipal.BalloonFlags := BfInfo;
     1: CtiPrincipal.BalloonFlags := BfWarning;
     2: CtiPrincipal.BalloonFlags := BfError;
   else
     CtiPrincipal.BalloonFlags := BfInfo;
   end; //case
   CtiPrincipal.BalloonTitle := FrmServer.Caption;
   CtiPrincipal.BalloonHint  := MessageValue;
   CtiPrincipal.ShowBalloonHint;
   Application.ProcessMessages;
end;

procedure TFrmServer.AppEventsIdle(Sender: TObject; var Done: Boolean);
begin
   ButtonStart.Enabled := not DWPooler.Active;
   ButtonStop.Enabled  := DWPooler.Active;
end;

procedure TFrmServer.ButtonStartClick(Sender: TObject);
begin
   Timer.Enabled := True;
   StartServer;
end;

procedure TFrmServer.ButtonStopClick(Sender: TObject);
begin
   Timer.Enabled   := False;
   DWPooler.Active := False;
   ShowApplication;
end;

procedure TFrmServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := not DWPooler.Active;
   if not CanClose Then
   begin
     CanClose := not Self.Visible;
     if CanClose Then
        CanClose := Application.MessageBox('Você deseja realmente fechar o servidor?', 'Pergunta ?', Mb_IconQuestion + Mb_YesNo) = MrYes
     else HideApplication;
   end;
end;

procedure TFrmServer.StartServer;
begin
   if not DWPooler.Active then
   begin
      DWPooler.Active := True;
      if not DWPooler.Active then Exit;
      HideApplication;
   end
end;

procedure TFrmServer.TimerTimer(Sender: TObject);  // Interval: 1800000 mls
const
   UFs: array[0..26] of string = ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA',
   'MG','MS','MT','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO');
var
   Ac:Integer;
   Task:ITask;
   iniTime,fimTime:TTime;
   Tags:TIBPTBasicTags;
   locServer:TDMServer;
   TaskComplete:Boolean;
   QueAuxi,QueIBPT:TFDQuery;
   Res:TIBPTBatchResult;
   Updater: TIBPTUpdater;
   Codigos: array of string;
   Registros:TList<TRegistro>;
   nomeLink,auxErro,auxVigencia:String;
   Success:Boolean;
begin
   iniTime := EncodeTime(03,0,0,0);  // 03:00 horas
   fimTime := EncodeTime(04,0,0,0);  // 04:00 horas
   if (Time >= iniTime) and (Time <= fimTime) then
   begin
      Timer.Enabled := False;
      auxErro := FetchIBPTBasicTags('10011100', 'MS', Tags);
      if auxErro <> '' then Exit;
      auxVigencia := Tags.VigenciaInicio;

      //TTask.Run(procedure var Success: Boolean;
      //begin
         Success   := False;
         QueAuxi   := TFDQuery.Create(nil);
         QueIBPT   := TFDQuery.Create(nil);
         locServer := TDMServer.Create(nil);
         QueAuxi.Connection := locServer.FDConnect;
         try
            try
               locServer.FDConnect.Connected := True;
            except
               SalvaLog(ArqLog,'IASERVER - ERRO CRÍTICO: Não foi possível conectar ao banco de dados dbaiserver para atualizar CMED e IBPT');
               Exit;
            end;

            // -------- Verifica Atualizações CMED ------- //
            nomeLink := GetXLSLink;
            if nomeLink <> '' then
            begin
               try
                  QueAuxi.SQL.Text := 'SELECT LinkCMED FROM arqpage';
                  QueAuxi.Open;
                  if QueAuxi.IsEmpty then raise Exception.Create('Dados da tabela arqpage (CMED) não foram encontrados.');
                  if QueAuxi.FieldByName('LinkCMED').AsString <> nomeLink then
                  begin
                     if DownXlsCMED(PastaCMED, Registros) then
                        Success := AtuServerCMED(Registros);
                     //TThread.Synchronize(nil, procedure
                     //begin
                        if Success then
                        begin
                           QueAuxi.Close;
                           QueAuxi.SQL.Text := 'UPDATE arqpage SET UltAtuCMED = NOW(), LinkCMED = '+Aspas(nomeLink);
                           QueAuxi.ExecSQL;
                         end; //if
                     //end);
                  end;
               except
                  on E:Exception do
                  begin
                     SalvaLog(ArqLog, 'ERRO CRÍTICO: ao tentar abrir tabela arqpage para verificar link CMED -> '+E.Message);
                  end;
               end;
            end
            else SalvaLog(ArqLog,'IASERVER - ERRO: ao tentar verificar link CMED -> Não encontrado: "'+nomeLink+'"');

            // -------- Verifica atualizações para IBPT -------- //  https://deolhonoimposto.ibpt.org.br/
            QueIBPT.Connection := locServer.FDConnect;
            QueIBPT.ResourceOptions.SilentMode := True;
            QueIBPT.FetchOptions.Mode  := fmAll;
            QueIBPT.FetchOptions.Items := QueIBPT.FetchOptions.Items + [fiMeta];
            QueIBPT.FetchOptions.RowsetSize := 1000;
            QueIBPT.FetchOptions.Unidirectional := True;
            QueIBPT.SQL.Text := 'SELECT DISTINCT CodNCM FROM arqibpt';
            try
               QueAuxi.SQL.Text := 'SELECT DataVigIBPT FROM arqpage';
               QueAuxi.Open;
               if QueAuxi.IsEmpty then
                  raise Exception.Create('Dados da tabela arqpage (IBPT) não foram encontrados.');
               if QueAuxi.FieldByName('DataVigIBPT').AsDateTime < Date then
               begin
                  if StrToDate(auxVigencia) < QueAuxi.FieldByName('DataVigIBPT').AsDateTime then Exit;
                  QueIBPT.SQL.Text := 'SELECT CodNCM FROM arqibpt GROUP BY CodNCM';
                  QueIBPT.Open;
                    //TThread.Synchronize(nil, procedure
                    //begin
                       Ac := 0;
                       SetLength(Codigos, QueIBPT.RecordCount);
                       while not QueIBPT.Eof do
                       begin
                          Codigos[Ac] := QueIBPT.FieldByName('CodNCM').AsString;
                          Inc(Ac);
                          QueIBPT.Next;
                       end; //while

                       for var I := 0 to 26 do
                       begin
                          Updater := TIBPTUpdater.Create(locServer.FDConnect);
                          try
                             Res := Updater.UpdateIBPTBatch(UFs[I], Codigos,
                             procedure(Processed, Total: Integer; const Codigo, Msg: string)
                             begin
                               //Memo1.Lines.Add('UF: '+UFs[I]+' -> '+Format('[%d/%d] NCM %s -> %s',[Processed, Total, Codigo, Msg]));
                             end);
                          finally
                             Updater.Free;
                          end;
                       end; //for

                       QueAuxi.Close;
                       QueAuxi.SQL.Text := 'UPDATE arqpage SET '+
                       'DataVigIBPT = '+Aspas(DataMySQL(StrToDate(Tags.VigenciaFim)))+', '+
                       'FonteIBPT = '  +Aspas(Tags.Fonte);
                       QueAuxi.ExecSQL;
                    //end);
               end;
            except
               on E:Exception do
               begin
                  SalvaLog(ArqLog, 'ERRO CRÍTICO: ao tentar abrir tabela arqpage para verificar data vigência IBPT-> '+E.Message);
               end;
            end;
         finally
            QueAuxi.Close;
            QueIBPT.Close;
            FreeAndNil(QueAuxi);
            FreeAndNil(QueIBPT);
            locServer.FDConnect.Close;
            FreeAndNil(locServer);
         end;
      //end);
   end; //if
end;

procedure TFrmServer.SairdaAplicao1Click(Sender: TObject);
begin
   Close;
end;

// ----------- TESTES ----------- //
procedure TFrmServer.Button1Click(Sender: TObject);
var
  Tags:TIBPTBasicTags;
  locServer:TDMServer;
  Updater: TIBPTUpdater;
  Codigos: array of String;
  Res: TIBPTBatchResult;
begin
//   if FetchIBPTBasicTags('10011100', 'MS', Tags) = '' then
//      ShowMessage(Format('Versao=%s | VigInic=%s | VigFim=%s | Chave=%s | Fonte=%s',
//                        [Tags.Versao, Tags.VigenciaInicio, Tags.VigenciaFim, Tags.Chave, Tags.Fonte]));
//EXIT;

   try
      locServer := TDMServer.Create(nil);
      locServer.FDConnect.Connected := True;
   except
      SalvaLog(ArqLog,'IASERVER - ERRO CRÍTICO: Não foi possível conectar ao banco de dados dbaiserver para atualizar CMED e IBPT');
      Exit;
   end;

  SetLength(Codigos, 3);
  Codigos[0] := '29309035';
  Codigos[1] := '52091200';
  Codigos[2] := '72091800';

  Updater := TIBPTUpdater.Create(locServer.FDConnect);
  try
    Res := Updater.UpdateIBPTBatch(
      'SC',
      Codigos,
      procedure(Processed, Total: Integer; const Codigo, Msg: string)
      begin
        //Memo1.Lines.Add(Format('[%d/%d] NCM %s -> %s',[Processed, Total, Codigo, Msg]));
      end,
      '',           // GTIN ('' => 'SEM GTIN')
      4,            // MaxRetries
      600,          // BaseDelayMs
      10000,        // MaxDelayMs
      300,          // MinIntervalMs (throttle)
    );
    ShowMessage(Format('Sucessos: %d; Falhas: %d', [Res.UpdatedCount, Length(Res.Failed)]));
  finally
    locServer.FDConnect.Close;
    FreeAndNil(locServer);
    Updater.Free;
  end;
end;

end.


