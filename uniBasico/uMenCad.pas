unit uMenCad;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   AdvGlowButton, LMDControl, LMDCustomControl, LMDCustomPanel,
   LMDCustomBevelPanel, LMDSimplePanel, AdvSmoothPanel, Vcl.ExtCtrls;

type
  TFrmMenCad = class(TForm)
    timAlpha: TTimer;
    PanelBtMenu: TAdvSmoothPanel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    PanelShow: TAdvSmoothPanel;
    btPessoas: TAdvGlowButton;
    btConvenio: TAdvGlowButton;
    btDescontos: TAdvGlowButton;
    btMetVen: TAdvGlowButton;
    btSNGPC: TAdvGlowButton;
    btProduto: TAdvGlowButton;
    btComis: TAdvGlowButton;
    btUsuario: TAdvGlowButton;
    btPromocao: TAdvGlowButton;
    procedure btPessoasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btConvenioClick(Sender: TObject);
    procedure btProdutoClick(Sender: TObject);
    procedure btDescontosClick(Sender: TObject);
    procedure btPromocaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btSNGPCClick(Sender: TObject);
    procedure btComisClick(Sender: TObject);
    procedure btMetVenClick(Sender: TObject);
  private
    procedure AbreForm(Formu:TForm; TFormu:TFormClass);
    { Private declarations }
  public
    { Public declarations }
  end;

var
   FrmMenCad: TFrmMenCad;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoas, uConvenio, uProdutos,
     uDescontos, uPromocao, uSNGPC, uComissao, uMetasVen, uPrincipal;

procedure TFrmMenCad.FormCreate(Sender: TObject);
begin
   //AdjustZoom(Self);
end;

procedure TFrmMenCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmMenCad.btPessoasClick(Sender: TObject);
begin
   AbreForm(FrmPessoas, TFrmPessoas);
end;

procedure TFrmMenCad.btConvenioClick(Sender: TObject);
begin
   AbreForm(FrmConvenios, TFrmConvenios);
end;

procedure TFrmMenCad.btProdutoClick(Sender: TObject);
begin
   AbreForm(FrmProdutos, TFrmProdutos);
end;

procedure TFrmMenCad.btDescontosClick(Sender: TObject);
begin
   AbreForm(FrmDescontos, TFrmDescontos);
end;

procedure TFrmMenCad.btPromocaoClick(Sender: TObject);
begin
   AbreForm(FrmPromocao, TFrmPromocao);
end;

procedure TFrmMenCad.btComisClick(Sender: TObject);
begin
   AbreForm(FrmComissao, TFrmComissao);
end;

procedure TFrmMenCad.btMetVenClick(Sender: TObject);
begin
   AbreForm(FrmMetaVen, TFrmMetaVen);
end;

procedure TFrmMenCad.btSNGPCClick(Sender: TObject);
begin
   AbreForm(FrmSNGPC, TFrmSNGPC);
end;

procedure TFrmMenCad.AbreForm(Formu: TForm; TFormu: TFormClass);
begin
   PanelBtMenu.Visible := False;
   FrmPrincipal.FechaForms;
   TrimAppMemorySize;
   Formu := TFormu.Create(Application);
   Formu.Parent := FrmPrincipal.PanelBas;
   CentralizarControl(Formu, Self);
   Formu.Show;
end;

procedure TFrmMenCad.FormResize(Sender: TObject);
begin
   btPessoas.Margins.Top := (PanelBtMenu.ClientHeight - (9 * (btPessoas.Height+2))) div 2;
end;

procedure TFrmMenCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
