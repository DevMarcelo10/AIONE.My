unit uVendasAddIt;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.StdCtrls, LMDSimplePanel, LMDControl, Data.DB,
   LMDCustomControl, LMDCustomPanel, Vcl.ExtCtrls, AdvGlowButton,
   uRESTDWBasicTypes, AdvEdBtn, uRESTDWBasicDB, LMDBaseGraphicControl,
   LMDCustomLabel, LMDCustomBevelPanel, VCL.Forms,  Vcl.Controls,
   LMDBaseLabel, LMDLabel, LMDBaseControl, Vcl.DBGrids, LMDMaskEdit,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, MarcLib,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Vcl.Graphics,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   Vcl.Dialogs, LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDCustomMaskEdit;

type
  TFrmVendaAdd = class(TForm)
    PanelBase: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelDados: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel4: TLMDLabel;
    edFabr: TLMDLabeledEdit;
    edNomven: TLMDLabeledEdit;
    edQtdped: TLMDMaskEdit;
    edVlrVenda: TLMDMaskEdit;
    edPerDesc: TLMDMaskEdit;
    LMDMaskEdit2: TLMDMaskEdit;
    btSalvar: TAdvGlowButton;
    edNompro: TLMDLabeledEdit;
    btSalvaIte: TAdvGlowButton;
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDProd:Integer;
    recNompro:String;
  end;

var
   FrmVendaAdd: TFrmVendaAdd;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmVendaAdd.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmVendaAdd.FormShow(Sender: TObject);
begin
   edNompro.Text := recNompro;
   edNompro.Tag  := recIDProd;
   if edNompro.Tag > 0 then
        btSalvaIte.Click
   else edNompro.SetFocus;
end;

procedure TFrmVendaAdd.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmVendaAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
