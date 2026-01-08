unit uDWServer;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.ExtCtrls,
   System.Classes, Vcl.Forms, Vcl.Graphics, Vcl.Controls, Vcl.Dialogs, Winapi.IpTypes,
   FireDAC.Stan.StorageJSON, Vcl.AppEvnts, Vcl.StdCtrls, Web.HTTPApp, Vcl.ComCtrls,
   Vcl.Imaging.Jpeg, Vcl.Imaging.Pngimage, Vcl.Menus, FireDAC.UI.Intf, Data.DB,
   FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Phys.FB,
   FireDAC.Stan.Error, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, MarcFMX,
   FireDAC.Stan.Async, FireDAC.Comp.Client, uRESTDWIdBase, uRESTDWBasic, LMDLabel,
   uRESTDWComponentBase, LMDBaseControl, uRESTDWServerEvents, LMDCustomLabel,
   System.Threading, uRESTDWBasicDB, FireDAC.Stan.Param, FireDAC.DatS, LMDBaseLabel,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes,
   uRESTDWMassiveBuffer, LMDBaseGraphicControl;

type
   TFrmServer = class(TForm)
      Label8: TLabel;
      CtiPrincipal: TTrayIcon;
      PmMenu: TPopupMenu;
      RestaurarAplicao1: TMenuItem;
      N5: TMenuItem;
      SairdaAplicao1: TMenuItem;
      imgLogo: TImage;
      LMDLabel1: TLMDLabel;
      Timer: TTimer;
      DWDataBase: TRESTDWIdDatabase;
      DWClientPoolerCon: TRESTDWIdClientPooler;
      DWClientEventsCon: TRESTDWClientEvents;
      timSincr: TTimer;
      DWClientPooler: TRESTDWIdClientPooler;
      DWClientEvents: TRESTDWClientEvents;
      DWPooler: TRESTDWIdServicePooler;
      procedure ButtonStopClick(Sender: TObject);
      procedure CtiPrincipalDblClick(Sender: TObject);
      procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
      procedure SairdaAplicao1Click(Sender: TObject);
      procedure RestaurarAplicao1Click(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure TimerTimer(Sender: TObject);
      procedure timSincrTimer(Sender: TObject);
   private
      { Private declarations }
      procedure StartServer;
      procedure ChangeStatusWindow;
      procedure HideApplication;
      procedure TSincronizaTerminate(Sender: TObject);
      function  GetHandleOnTaskBar: THandle;
   public
      { Public declarations }
      procedure ShowApplication;
      procedure ShowBalloonTips(IconMessage: Integer = 0; MessageValue: String = '');
   end;

var
   FrmServer: TFrmServer;
   DirName: String   = '.\Atualizacoes\';
   gCNPJEMP: String  = '';
   FARMACIA: String  = '';
   FILIAL: String    = '';
   ArqLog: String    = '';
   IPSERVER: String     = 'localhost'; // 162.215.175.59:4489
   IPSERVERLoc: String  = 'localhost';
   SENHADBLoc: String   = 'f68interdb';
   PORTADBLoc: String   = '3307';
   DWPort: Integer      = 8092;

implementation

{$IFDEF FPC} {$R *.lfm}  {$ELSE} {$R *.dfm} {$ENDIF}

uses uDM, uVeChaves, uSincroniza, uCMEDUpdater, uIBPTSync;

procedure TFrmServer.FormCreate(Sender: TObject);
var
   EMPRESA: String;
begin
   ArqLog := ExtractFileDir(Application.ExeName) + '\doc\';
   if not DirectoryExists(ArqLog) then CreateDir(ArqLog);
   DWClientPooler.Host        := IPSERVER;
   DWClientPoolerCon.Host     := IPSERVER;
   DWDataBase.PoolerService   := IPSERVER;
   DWPooler.ServerMethodClass := TDMServer;
   EMPRESA := VerificaKEY;
   if EMPRESA = 'ERROR' then
   begin
      Application.Terminate;
      Exit;
   end;
   Caption := Caption+' - '+Copy(EMPRESA, 1, 25);
   Timer.Enabled := True;
end;

procedure TFrmServer.FormShow(Sender: TObject);
begin
   StartServer;
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
   CtiPrincipal.Visible := True;
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
   CtiPrincipal.Visible := False;
   Application.ShowMainForm := True;
   if Self <> nil then
   begin
      Self.Visible := True;
      Self.WindowState := WsNormal;
   end;
   ShowWindow(GetHandleOnTaskBar, SW_SHOW);
   ChangeStatusWindow;
end;

procedure TFrmServer.ShowBalloonTips(IconMessage: Integer = 0; MessageValue: String = '');
begin
   case IconMessage of
      0: CtiPrincipal.BalloonFlags := BfInfo;
      1: CtiPrincipal.BalloonFlags := BfWarning;
      2: CtiPrincipal.BalloonFlags := BfError;
   else
      CtiPrincipal.BalloonFlags := BfInfo;
   end; // case
   CtiPrincipal.BalloonTitle := FrmServer.Caption;
   CtiPrincipal.BalloonHint  := MessageValue;
   CtiPrincipal.ShowBalloonHint;
   Application.ProcessMessages;
end;

procedure TFrmServer.ButtonStopClick(Sender: TObject);
begin
   ShowApplication;
end;

procedure TFrmServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := not DWPooler.Active;
   if not CanClose Then
   begin
      CanClose := not Self.Visible;
      if CanClose Then
         CanClose := Application.MessageBox('Você deseja realmente fechar o servidor?', 'Pergunta ?',Mb_IconQuestion + Mb_YesNo) = MrYes
      else HideApplication;
   end;
end;

procedure TFrmServer.StartServer;
begin
   if not DWPooler.Active then
   begin
      DWPooler.Active := True;
      if not DWPooler.Active then Exit;
   end
end;

procedure TFrmServer.TimerTimer(Sender: TObject);  // 1800000 ms
begin
   ExeAtuCMED;  //-- Atualiza CMED
   //--> VOLTAR:  SyncIBPTFromMaster(DWDataBase, NOW);
end;

// 60000 //--------> REATIVAR ESSE QUANDO O SISTEMA DE CONVÊNIOS RETORNAR = Enabled = True
procedure TFrmServer.timSincrTimer(Sender: TObject);
var
   MyThread:TThread;
begin
   timSincr.Enabled := False;
   MyThread := TThread.CreateAnonymousThread(
   procedure
   begin
      DownloadConv(DWClientEventsCon);
      UploadConvConv(DWClientEventsCon);
   end);
   MyThread.OnTerminate := TSincronizaTerminate;
   MyThread.Start;
end;

procedure TFrmServer.TSincronizaTerminate(Sender: TObject);
begin
   timSincr.Enabled := True;
end;

procedure TFrmServer.SairdaAplicao1Click(Sender: TObject);
begin
   Close;
end;

procedure TFrmServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   DWPooler.Active := False;
end;

end.
