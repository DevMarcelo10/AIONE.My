unit uReceitaC;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, LMDCustomMaskEdit, LMDCustomExtCombo,
   LMDCustomListComboBox, LMDListComboBox, LMDCustomParentPanel, LMDBackPanel,
   LMDCustomMemo, LMDDBMemo, LMDCustomGroupBox, LMDCustomButtonGroup,
   LMDCustomRadioGroup, LMDDBRadioGroup;

type
  TFrmReceitaC = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDBackPanel1: TLMDBackPanel;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    edMedico: TLMDDBLabeledEdit;
    edTipoPes: TLMDLabeledListComboBox;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBMemo1: TLMDDBMemo;
    LMDDBRadioGroup1: TLMDDBRadioGroup;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    LMDDBLabeledEdit12: TLMDDBLabeledEdit;
    LMDDBLabeledEdit13: TLMDDBLabeledEdit;
    LMDDBLabeledEdit14: TLMDDBLabeledEdit;
    LMDDBLabeledEdit15: TLMDDBLabeledEdit;
    LMDDBRadioGroup2: TLMDDBRadioGroup;
    btSalvar: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmReceitaC: TFrmReceitaC;

implementation

{$R *.dfm}

uses uDM, uLibFarm;

procedure TFrmReceitaC.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmReceitaC.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
end;

procedure TFrmReceitaC.FormShow(Sender: TObject);
begin
  LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmReceitaC.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmReceitaC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
