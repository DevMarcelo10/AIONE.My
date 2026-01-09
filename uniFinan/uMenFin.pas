unit uMenFin;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   AdvGlowButton, LMDControl, LMDCustomControl, LMDCustomPanel,
   LMDCustomBevelPanel, LMDSimplePanel, AdvSmoothPanel, Vcl.ExtCtrls;

type
  TFrmMenFin = class(TForm)
    timAlpha: TTimer;
    PanelShow: TAdvSmoothPanel;
    PanelBtMenu: TAdvSmoothPanel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btTitulos: TAdvGlowButton;
    btBaixas: TAdvGlowButton;
    btPlacon: TAdvGlowButton;
    btNatFin: TAdvGlowButton;
    btBancos: TAdvGlowButton;
    btCartao: TAdvGlowButton;
    btAnalises: TAdvGlowButton;
    procedure btTitulosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btPlaconClick(Sender: TObject);
    procedure btNatFinClick(Sender: TObject);
    procedure btBaixasClick(Sender: TObject);
    procedure btBancosClick(Sender: TObject);
    procedure btCartaoClick(Sender: TObject);
  private
    procedure AbreForm(Formu:TForm; TFormu:TFormClass);
    procedure FechaForms;
    { Private declarations }
  public
    { Public declarations }
  end;

var
   FrmMenFin: TFrmMenFin;

implementation

{$R *.dfm}

uses uDM, uConst, uPrincipal, uLibFarm, uTitulosCad, uPlaConta,
     uNatFina, uBancos, uTitulosBai, uCartao;

procedure TFrmMenFin.FormCreate(Sender: TObject);
begin
   //AdjustZoom(Self);
end;

procedure TFrmMenFin.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmMenFin.btTitulosClick(Sender: TObject);
begin
   AbreForm(FrmTitCad, TFrmTitCad);
end;

procedure TFrmMenFin.btPlaconClick(Sender: TObject);
begin
   AbreForm(FrmPlaCon, TFrmPlaCon);
end;

procedure TFrmMenFin.btNatFinClick(Sender: TObject);
begin
   AbreForm(FrmNatFin, TFrmNatFin);
end;

procedure TFrmMenFin.btBancosClick(Sender: TObject);
begin
   AbreForm(FrmBancos, TFrmBancos);
end;

procedure TFrmMenFin.btCartaoClick(Sender: TObject);
begin
   AbreForm(FrmCartao, TFrmCartao);
end;

procedure TFrmMenFin.btBaixasClick(Sender: TObject);
begin
   AbreForm(FrmTitBai,TFrmTitBai);
end;

procedure TFrmMenFin.AbreForm(Formu: TForm; TFormu: TFormClass);
begin
   PanelBtMenu.Visible := False;
   FrmPrincipal.FechaForms;
   TrimAppMemorySize;
   Formu := TFormu.Create(Application);
   Formu.Parent := FrmPrincipal.PanelBas;
   CentralizarControl(Formu, Self);
   Formu.Show;
end;

procedure TFrmMenFin.FormResize(Sender: TObject);
begin
   btTitulos.Margins.Top := (PanelBtMenu.ClientHeight - (7 * (btTitulos.Height+2))) div 2;
end;

procedure TFrmMenFin.FechaForms;
var
   I:Integer;
begin
   for I := Application.ComponentCount - 1 downto 0 do
   begin
      if (Application.Components[I] is TFrmPrincipal) or (Application.Components[I] is TFrmMenFin) then Continue;
      try
         if Application.Components[I] is TForm then (Application.Components[I] as TForm).Close;
      except
      end;
   end; //for
end;

procedure TFrmMenFin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
