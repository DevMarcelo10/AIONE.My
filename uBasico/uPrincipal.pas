unit uPrincipal;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Classes,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDSimplePanel, Vcl.ExtCtrls, AdvGlowButton, Vcl.Imaging.PNGimage,
   Vcl.StdCtrls, AdvSmoothPanel;

type
   TFrmPrincipal = class(TForm)
    PanelBotMenu: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    btUsuario: TAdvGlowButton;
    btFechar: TAdvGlowButton;
    btMinimize: TAdvGlowButton;
    timFIni: TTimer;
    imgLogo: TImage;
    PanelMenu: TLMDSimplePanel;
    PanelBas: TAdvSmoothPanel;
    procedure FormResize(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btMinimizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCadastroClick(Sender: TObject);
    procedure timFIniTimer(Sender: TObject);
    procedure btVendaMouseEnter(Sender: TObject);
    procedure btVendaMouseLeave(Sender: TObject);
    procedure btVendaClick(Sender: TObject);
    procedure btCaixaClick(Sender: TObject);
    procedure btComprasClick(Sender: TObject);
    procedure btEstoqueClick(Sender: TObject);
    procedure btFinanceiroClick(Sender: TObject);
    procedure btFiscalClick(Sender: TObject);
    procedure btIAgptClick(Sender: TObject);
    procedure btConfigClick(Sender: TObject);
    procedure PanelBotMenuMouseEnter(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
     { Private declarations }
  public
     { Public declarations }
      procedure FechaForms;
  end;

var
   FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uDM, uConst, uMenu, uLibFarm, uInfoIni, uMenCad, uMenFin, uMenEstoq,
     uVendas, uMenComp, uCaixa, uConfig, uFiscal, uCompras;  // uIAgpt,

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   Application.HintPause     := 1200;
   Application.HintHidePause := 2500;
   CentralizarControl(PanelMenu,PanelBotMenu);
   //--> Self.Caption := Self.Caption+' - Versão '+GetBuildInfoAsString+' - '+TituloFrm;
end;

procedure TFrmPrincipal.btMinimizeClick(Sender: TObject);
begin
   Self.WindowState := wsMinimized;
end;

procedure TFrmPrincipal.btVendaMouseEnter(Sender: TObject);
begin
   TAdvGlowButton(Sender).ShowCaption := True;
end;

procedure TFrmPrincipal.btVendaMouseLeave(Sender: TObject);
begin
   TAdvGlowButton(Sender).ShowCaption := False;
end;

procedure TFrmPrincipal.PanelBotMenuMouseEnter(Sender: TObject);
begin
   if not FrmMenu.Showing then
   begin
      FrmMenu.Show;
      FadeInOut(FrmMenu,'In',15);
   end;
end;

procedure TFrmPrincipal.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
   MousePos:TPoint;
begin
   if FrmMenu <> nil then
   begin
      try
         MousePos := ScreenToClient(Mouse.CursorPos);
         if (FrmMenu.Showing) and (not PanelBotMenu.ClientRect.Contains(PanelBotMenu.ScreenToClient(Mouse.CursorPos))) then
         begin
            if FrmMenu.AlphaBlendValue = 255 then
            begin
               FadeInOut(FrmMenu,'Out',15);
               FrmMenu.Close;
            end;
         end;
      except
      end;
   end; //if
end;

procedure TFrmPrincipal.timFIniTimer(Sender: TObject);
begin
   timFIni.Enabled := False;
   FrmInfoIni := TFrmInfoIni.Create(PanelBas);
   FrmInfoIni.Parent := PanelBas;
   FrmInfoIni.Show;
   Application.CreateForm(TFrmMenu, FrmMenu);
   FrmMenu.Parent := PanelMenu;
end;

procedure TFrmPrincipal.btVendaClick(Sender: TObject);
var
   MainFormPos: TPoint;
begin
   FechaForms;
   FrmVendas := TFrmVendas.Create(Application);
   FrmVendas.Parent := PanelBas;
   MainFormPos    := PanelBas.ClientToScreen(Point(0, 0));
   FrmVendas.Left := MainFormPos.X + (PanelBas.Width  div 2) - (FrmVendas.Width  div 2);
   FrmVendas.Top  := MainFormPos.Y + (PanelBas.Height div 2) - (FrmVendas.Height div 2) - PanelTop.Height;
   FrmVendas.Show;
end;

procedure TFrmPrincipal.btCaixaClick(Sender: TObject);
begin
   FechaForms;
   CentralizarControl(FrmCaixa, PanelBas);
   FrmCaixa.Show;
end;

procedure TFrmPrincipal.btComprasClick(Sender: TObject);
begin
   FechaForms;
   FrmMenComp := TFrmMenComp.Create(Application);
   FrmMenComp.Parent := PanelBas;
   CentralizarControl(FrmMenComp, PanelBas);
   FrmMenComp.Show;
end;

procedure TFrmPrincipal.btEstoqueClick(Sender: TObject);
begin
   FechaForms;
   FrmMenEsto := TFrmMenEsto.Create(Application);
   FrmMenEsto.Parent := PanelBas;
   CentralizarControl(FrmMenEsto, PanelBas);
   FrmMenEsto.Show;
end;

procedure TFrmPrincipal.btCadastroClick(Sender: TObject);
begin
   FechaForms;
   FrmMenCad := TFrmMenCad.Create(Application);
   FrmMenCad.Parent := PanelBas;
   FrmMenCad.Show;
end;

procedure TFrmPrincipal.btFinanceiroClick(Sender: TObject);
begin
   FechaForms;
   FrmMenFin := TFrmMenFin.Create(Application);
   FrmMenFin.Parent := PanelBas;
   FrmMenFin.Show;
end;

procedure TFrmPrincipal.btFiscalClick(Sender: TObject);
begin
   FechaForms;
   FrmFiscal := TFrmFiscal.Create(Application);
   FrmFiscal.Parent := PanelBas;
   CentralizarControl(FrmFiscal, PanelBas);
   FrmFiscal.Show;
end;

procedure TFrmPrincipal.btIAgptClick(Sender: TObject);
begin
   FechaForms;
   //FrmIAgpt := TFrmIAgpt.Create(Application);
   //FrmIAgpt.Parent := PanelBas;
   //CentralizarControl(FrmIAgpt, PanelBas);
   //FrmIAgpt.Show;
end;

procedure TFrmPrincipal.btConfigClick(Sender: TObject);
begin
   FechaForms;
   FrmConfig := TFrmConfig.Create(Application);
   FrmConfig.Parent := PanelBas;
   CentralizarControl(FrmConfig, PanelBas);
   FrmConfig.Show;
end;

procedure TFrmPrincipal.FechaForms;
var
   I:Integer;
begin
   if FrmInfoIni.Showing then FrmInfoIni.Close;
   for I := Application.ComponentCount - 1 downto 0 do
   begin
      if (Application.Components[I] is TFrmPrincipal) or (Application.Components[I] is TFrmMenCad) then Continue;
      try
         if Application.Components[I] is TForm then (Application.Components[I] as TForm).Close;
      except
      end;
   end; //for
end;

procedure TFrmPrincipal.FormResize(Sender: TObject);
begin
   if Self.WindowState = wsNormal then
        Align := alNone
   else Align := alClient;
   PanelMenu.Left := (Width - PanelMenu.Width) div 2;
end;

procedure TFrmPrincipal.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if not PodeFechar then
   begin
      CanClose := False;
      Exit;
   end;
   try
      FechaForms;
   except
   end;
end;

end.
