unit uInfoIni;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   AdvSmoothPanel, Vcl.ExtCtrls, Vcl.Imaging.PNGimage, Vcl.StdCtrls,
   AdvReflectionLabel, LMDBaseControl, LMDBaseGraphicControl, LMDLabel,
   LMDBaseLabel, LMDCustomLabel, MarcLib, System.DateUtils, AdvGlowButton,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDBaseEdit, LMDCustomEdit, LMDEdit;

type
   TFrmInfoIni = class(TForm)
    PanelBas: TAdvSmoothPanel;
    PanelCenter: TAdvSmoothPanel;
    lbHoras: TAdvReflectionLabel;
    lbDiaSemana: TAdvReflectionLabel;
    lbFalar: TLMDLabel;
    timAlpha: TTimer;
    lbSaudar: TLMDLabel;
    PanelBusca: TAdvSmoothPanel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    edBusca: TLMDEdit;
    btBusca: TAdvGlowButton;
    procedure FormResize(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure edBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   FrmInfoIni: TFrmInfoIni;

implementation

{$R *.dfm}

uses uDM, uConst, uPrincipal, uLibFarm;

procedure TFrmInfoIni.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmInfoIni.FormShow(Sender: TObject);
begin
   lbDiaSemana.HTMLText.Clear;
   lbDiaSemana.HTMLText.Add(DataExtenso(Now, True));
   lbHoras.HTMLText.Clear;
   lbHoras.HTMLText.Add(FormatDateTime('hh:mm',Time));
   lbSaudar.Caption := '';
   lbFalar.Caption  := '';
end;

procedure TFrmInfoIni.timAlphaTimer(Sender: TObject);
var
   Hora:Word;
   Saldar:String;
begin
   timAlpha.Enabled := False;
   //FadeInOut(Self, 'In', 8);
   Hora := HourOf(Now);
   if (Hora >= 0)  and (Hora < 12) then Saldar := 'Bom dia, '   else
   if (Hora >= 12) and (Hora < 18) then Saldar := 'Boa tarde, ' else Saldar := 'Boa noite, ';
   TypingSimulation(lbSaudar, Saldar + USUARIO, 50, 0);
   TypingSimulation(lbFalar, 'Estamos esquentando os motores, em breve TUDO PRONTO...', 50, 2000);
end;

procedure TFrmInfoIni.btBuscaClick(Sender: TObject);
begin
   if AnsiPos('CADASTRO', UpperCase(edBusca.Text)) > 0 then
   begin
      if (AnsiPos('CLIENTE',    UpperCase(edBusca.Text)) > 0) or (AnsiPos('FORNECEDOR', UpperCase(edBusca.Text)) > 0) or
         (AnsiPos('FABRICANTE', UpperCase(edBusca.Text)) > 0) or (AnsiPos('PESSOA',     UpperCase(edBusca.Text)) > 0) then LINPROMPT := 'PESSOA' else
      if (AnsiPos('CONVÊNIO',   UpperCase(edBusca.Text)) > 0) or (AnsiPos('CONVENIO',   UpperCase(edBusca.Text)) > 0) then LINPROMPT := 'CONVENIO' else
      if (AnsiPos('PRODUTO',    UpperCase(edBusca.Text)) > 0) then LINPROMPT := 'PRODUTO' else
      if (AnsiPos('DESCONTO',   UpperCase(edBusca.Text)) > 0) then LINPROMPT := 'DESCONTO';
//---> FrmPrincipal.btCadastro.Click;
   end;
end;

procedure TFrmInfoIni.edBuscaKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then btBusca.Click;
end;

procedure TFrmInfoIni.FormResize(Sender: TObject);
begin
   PanelCenter.Top  := ((Self.Height - PanelCenter.Height) div 2) - 55;
   PanelCenter.Left := ((Self.Width  - PanelCenter.Width)  div 2);
   PanelBusca.Left  := (Self.Width   - PanelBusca.Width)   div 2 + 10;
   PanelBusca.Top   := (Self.Height  - PanelBusca.Height) - 30;
end;

end.
