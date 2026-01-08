unit uCaixaProc;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   Vcl.ExtCtrls, AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDCustomBevelPanel;

type
   TFrmProcCX = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelBack: TLMDSimplePanel;
    timAlpha: TTimer;
    PnaelBasMenus: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    btCofre: TAdvGlowButton;
    btPixCon: TAdvGlowButton;
    btConfe: TAdvGlowButton;
    PanelMenFor: TLMDSimplePanel;
    btConFor: TAdvGlowButton;
    btPedEle: TAdvGlowButton;
    btNegoci: TAdvGlowButton;
    btBanFor: TAdvGlowButton;
    Shape2: TShape;
    btObsFor: TAdvGlowButton;
    btCartao: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    barselBut: TShape;
    PanelBase: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btAbreFormsClick(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
    FormAtivo:TForm;
    procedure FechaSubForm;
    procedure AbreSubForm(NomeForm:String);
  public
    { Public declarations }
  end;

var
   FrmProcCX: TFrmProcCX;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uCartao, uPixConf, uCofre, uCxConf;

procedure TFrmProcCX.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmProcCX.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmProcCX.btAbreFormsClick(Sender: TObject);
begin
   AbreSubForm(Trim(Copy(TAdvGlowButton(Sender).Name,3,6)));
   barselBut.Left  := TAdvGlowButton(Sender).Left;
   barselBut.Width := TAdvGlowButton(Sender).Width;
end;

// ----------- Abre Sub Formulários ----------- //
procedure TFrmProcCX.AbreSubForm(NomeForm:String);
var
   PanelPos:TPoint;
   TFormAtivo:TFormClass;
begin
   FechaSubForm;
   if NomeForm = 'Cartao' then TFormAtivo := TFrmCartao  else
   if NomeForm = 'PixCon' then TFormAtivo := TFrmPixConf else
   if NomeForm = 'Cofre'  then TFormAtivo := TFrmCofre   else
   if NomeForm = 'Confe'  then TFormAtivo := TFrmCxConf;
   FormAtivo := TFormAtivo.Create(Application);
   FormAtivo.Parent := PanelBase;
   CentralizarControl(FormAtivo, PanelBase);
   FormAtivo.Show;
end;

// ----------- Fecha Formulários ----------- //
procedure TFrmProcCX.FechaSubForm;
begin
   if Assigned(FormAtivo) then
   begin
      FormAtivo.Close;
      FreeAndNil(FormAtivo);
   end;
end;

procedure TFrmProcCX.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmProcCX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaSubForm;
   Action := caFree;
end;

end.


