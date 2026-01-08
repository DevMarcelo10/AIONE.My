unit uTesteForm;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
   AdvGlowButton, AdvSmoothPanel, ModernDateEdit, LMDBaseGraphicControl, DBGridEx, LMDCustomLabel,
   LMDCustomControl, LMDBaseControl, LMDBaseLabel, LMDLabel, LMDControl, Data.DB, Vcl.DBGrids, LMDDBEdit,
   LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDButtonControl, LMDCustomCheckBox, LMDDBCheckBox,
   LMDCustomMaskEdit, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox, LMDBaseEdit, LMDCustomEdit;

type
   TFrmTesteForm = class(TForm)
    PanelPrincipal: TAdvSmoothPanel;
    PanelConteudo: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    edDBNompes: TLMDDBLabeledEdit;
    edDBCidpes: TLMDDBLabeledEdit;
    edIDEsppes: TLMDDBLabeledEdit;
    edTipoPes: TLMDLabeledListComboBox;
    CheckIseIE: TLMDDBCheckBox;
    ModernDBDateEdit1: TModernDBDateEdit;
    DBGridEx1: TDBGridEx;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    btFechar: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   FrmTesteForm: TFrmTesteForm;

implementation

{$R *.dfm}

uses uDM, uConst, MarcLib, uLibFarm;

procedure TFrmTesteForm.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTesteForm.FormShow(Sender: TObject);
begin
//
end;

procedure TFrmTesteForm.btSalvarClick(Sender: TObject);
begin
   MostraMsg('Info', 'Clicou em salvar!' [mbOk]);
end;

procedure TFrmTesteForm.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTesteForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
