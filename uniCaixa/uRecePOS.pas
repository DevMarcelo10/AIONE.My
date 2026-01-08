unit uRecePOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDBaseControl, LMDBaseLabel,
  LMDBaseGraphicControl, LMDCustomLabel, LMDLabel, LMDBaseEdit, LMDCustomEdit, LMDDBEdit,
  LMDCustomMaskEdit, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox,
  AdvGlowButton, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Data.DB,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB;

type
  TFrmRecePos = class(TForm)
    PanelBase: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    edPOS: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    edTipPag: TLMDLabeledListComboBox;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    btFechar: TAdvGlowButton;
    TabPedidoPos: TRESTDWClientSQL;
    SouPedidoPos: TDataSource;
    TabPedidoPosIDFilial: TIntegerField;
    TabPedidoPosIDPed: TIntegerField;
    TabPedidoPosNropag: TSmallintField;
    TabPedidoPosNroPos: TSmallintField;
    TabPedidoPosIDBan: TIntegerField;
    TabPedidoPosNroNSU: TWideStringField;
    TabPedidoPosTipcar: TWideStringField;
    TabPedidoPosVlrPago: TFloatField;
    TabPedidoPosDesban: TWideStringField;
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDPed,recNropag:Integer;
  end;

var
  FrmRecePos: TFrmRecePos;

implementation

{$R *.dfm}

uses uDM, uConst;

procedure TFrmRecePos.FormShow(Sender: TObject);
begin
   TabPedidoPos.ParamByName('IDFilial').AsInteger := FILIAL;
   TabPedidoPos.ParamByName('IDPed').AsInteger    := recIDPed;
   TabPedidoPos.ParamByName('Nropag').AsInteger   := recNropag;
   TabPedidoPos.Open;
   edPOS.SetFocus;
end;

procedure TFrmRecePos.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmRecePos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPedidoPos.Close;
   Action := caFree;
end;

end.
