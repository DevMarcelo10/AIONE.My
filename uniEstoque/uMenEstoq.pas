unit uMenEstoq;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   AdvGlowButton, LMDControl, LMDCustomControl, LMDCustomPanel,
   LMDCustomBevelPanel, LMDSimplePanel, AdvSmoothPanel, Vcl.ExtCtrls;

type
  TFrmMenEsto = class(TForm)
    timAlpha: TTimer;
    PanelShow: TAdvSmoothPanel;
    PanelBtMenu: TAdvSmoothPanel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btTransf: TAdvGlowButton;
    btOpera: TAdvGlowButton;
    btBalan: TAdvGlowButton;
    procedure btTransfClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AbreForm(Formu:TForm; TFormu:TFormClass);
    procedure FechaForms;
    { Private declarations }
  public
    { Public declarations }
  end;

var
   FrmMenEsto: TFrmMenEsto;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPrincipal;

procedure TFrmMenEsto.FormCreate(Sender: TObject);
begin
   //AdjustZoom(Self);
end;

procedure TFrmMenEsto.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmMenEsto.btTransfClick(Sender: TObject);
begin
//   AbreForm(FrmTraEsto, TFrmTraEsto);
end;

procedure TFrmMenEsto.AbreForm(Formu: TForm; TFormu: TFormClass);
begin
   PanelBtMenu.Visible := False;
   FrmPrincipal.FechaForms;
   TrimAppMemorySize;
   Formu := TFormu.Create(Application);
   Formu.Parent := FrmPrincipal.PanelBas;
   CentralizarControl(Formu, Self);
   Formu.Show
end;

procedure TFrmMenEsto.FormResize(Sender: TObject);
begin
   btTransf.Margins.Top := (PanelBtMenu.ClientHeight - (7 * (btTransf.Height+2))) div 2;
end;

procedure TFrmMenEsto.FechaForms;
var
   I:Integer;
begin
   for I := Application.ComponentCount - 1 downto 0 do
   begin
      if (Application.Components[I] is TFrmPrincipal) or (Application.Components[I] is TFrmMenEsto) then Continue;
      try
         if Application.Components[I] is TForm then (Application.Components[I] as TForm).Close;
      except
      end;
   end; //for
end;

procedure TFrmMenEsto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
