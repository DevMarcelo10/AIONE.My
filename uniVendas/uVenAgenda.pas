unit uVenAgenda;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, Vcl.DBCtrls,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Comp.Client,
   uRESTDWBasicTypes, Vcl.StdCtrls;

type
  TFrmAgeVenda = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabeledEdit1: TLMDLabeledEdit;
    LMDLabeledEdit3: TLMDLabeledEdit;
    LMDLabeledEdit4: TLMDLabeledEdit;
    LMDLabeledEdit2: TLMDLabeledEdit;
    LMDLabeledEdit5: TLMDLabeledEdit;
    btSalvar: TAdvGlowButton;
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDProd:Integer;
 end;

var
   FrmAgeVenda: TFrmAgeVenda;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmAgeVenda.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmAgeVenda.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmAgeVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
