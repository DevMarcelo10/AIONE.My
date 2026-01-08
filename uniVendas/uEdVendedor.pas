unit uEdVendedor;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls;

type
  TFrmEdtVend = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    edVend: TLMDLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edVendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edVendCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDVend:Integer;
 end;

var
   FrmEdtVend: TFrmEdtVend;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmEdtVend.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmEdtVend.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
end;

procedure TFrmEdtVend.FormShow(Sender: TObject);
begin
  //btBuscar.SetFocus;
end;

procedure TFrmEdtVend.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmEdtVend.edVendCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edVend),'IDPess','Nompes','(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,0);
end;

procedure TFrmEdtVend.edVendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edVend),'IDPess','Nompes','(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,Key);
end;

procedure TFrmEdtVend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   recIDVend := edVend.Tag;
   Action := caFree;
end;

end.
