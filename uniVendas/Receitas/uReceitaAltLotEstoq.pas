unit uReceitaAltLotEstoq;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomLabel, LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel,
  RxCurrEdit, Vcl.StdCtrls, LMDEdit, Vcl.Mask, RxToolEdit, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDMaskEdit,
  Vcl.ExtCtrls, LMDDBEdit, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
  uRESTDWBasicDB;

type
  TFrmReceitaAltLotEstoq = class(TForm)
    pnQtdLot: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    btConfirmar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    lbCabecalho: TLMDLabel;
    btCancelar: TAdvGlowButton;
    edQtdLot: TLMDMaskEdit;
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    recNroLote: String;
    recQtdLoteDisp: Currency;
    recQtdSel: Currency;
  end;

var
  FrmReceitaAltLotEstoq: TFrmReceitaAltLotEstoq;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmReceitaAltLotEstoq.btConfirmarClick(Sender: TObject);
begin
  if edQtdLot.AsCurrency > recQtdLoteDisp then
  begin
    MostraMsg('Estoque Lote SNGPC Insuficiente',
    'Qtd. Disponível: ' + FormatFloat('#,##0.00',recQtdLoteDisp) +
    ' Qtd. Solicitada: ' + FormatFloat('#,##0.00',edQtdLot.AsCurrency), mtWarning, [mbOk]);
    edQtdLot.Clear;
    edQtdLot.SetFocus;
    Exit;
  end;
  //
  recQtdSel:= edQtdLot.AsCurrency;
  //
  Close;
end;

procedure TFrmReceitaAltLotEstoq.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;

  //CTRL + S
  if (Key = 83) and (ssCtrl in Shift) then
  begin
    btConfirmarClick(Sender);
    key:= 0;
  end;
end;

procedure TFrmReceitaAltLotEstoq.FormShow(Sender: TObject);
begin
  lbCabecalho.Caption:= 'QUANTIDADE LOTE '+recNroLote;

  edQtdLot.AsCurrency:= recQtdSel;

  edQtdLot.SelectAll;
end;

procedure TFrmReceitaAltLotEstoq.btCancelarClick(Sender: TObject);
begin
  recQtdSel:= 0;
  Close;
end;

end.
