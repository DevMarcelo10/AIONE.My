unit uConvBol;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, MarcLib, LMDBaseControl,LMDEdit, LMDBaseEdit,
   LMDBaseGraphicControl, LMDBaseLabel, LMDLabel, LMDControl, Vcl.ExtCtrls,
   LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomLabel, VirtualTable, System.Types, LMDCustomEdit,
   Vcl.StdCtrls, FireDAC.Stan.Intf, uRESTDWBasicDB, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes, FireDAC.Comp.Client,
   LMDDBEdit, LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, LMDDBSpinEdit,
   LMDButtonControl, LMDCustomCheckBox, LMDDBCheckBox, Vcl.DBCtrls;

type
  TFrmConBoleto = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCadastro: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    edBanco: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledSpinEdit1: TLMDDBLabeledSpinEdit;
    LMDDBLabeledSpinEdit2: TLMDDBLabeledSpinEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledSpinEdit3: TLMDDBLabeledSpinEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDLabel1: TLMDLabel;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDLabel2: TLMDLabel;
    LMDDBCheckBox5: TLMDDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBancoCustomButtons0Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDConv:Integer;
  end;

var
   FrmConBoleto: TFrmConBoleto;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uConvenioCad;

procedure TFrmConBoleto.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmConBoleto.FormShow(Sender: TObject);
begin
   edBanco.SetFocus;
end;

procedure TFrmConBoleto.edBancoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(FrmConvCad.TabConv,'arqbanco',TDBEdit(edBanco),'Codban','Codban','Nomban','Nomban','',0);
end;

procedure TFrmConBoleto.edBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(FrmConvCad.TabConv,'arqbanco',TDBEdit(edBanco),'Codban','Codban','Nomban','Nomban','',Key);
end;

procedure TFrmConBoleto.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmConBoleto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Self := nil;
end;

end.
