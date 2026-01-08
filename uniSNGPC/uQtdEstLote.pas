unit uQtdEstLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
  LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDMaskEdit, AdvGlowButton;

type
  TFrmQtdEstLote = class(TForm)
    PanelTop: TLMDSimplePanel;
    pnQtdLot: TLMDSimplePanel;
    edQtdLot: TLMDMaskEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    lbCabecalho: TLMDLabel;
    btConfirmar: TAdvGlowButton;
    btCancelar: TAdvGlowButton;
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQtdLotKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    recNroLote: String;
    recQtdLoteDisp: Currency;
    recQtdSel: Currency;
  end;

var
  FrmQtdEstLote: TFrmQtdEstLote;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmQtdEstLote.btConfirmarClick(Sender: TObject);
begin
  if edQtdLot.AsCurrency > recQtdLoteDisp then
  begin
    ShowMessage('Estoque Lote SNGPC Insuficiente'+#13+
                'Qtd. Disponível: ' + FormatFloat('#,##0.00',recQtdLoteDisp) +
                ' Qtd. Solicitada: ' + FormatFloat('#,##0.00',edQtdLot.AsCurrency));
//    MostraMsg('Estoque Lote SNGPC Insuficiente',
//              'Qtd. Disponível: ' + FormatFloat('#,##0.00',recQtdLoteDisp) +
//              ' Qtd. Solicitada: ' + FormatFloat('#,##0.00',edQtdLot.AsCurrency),
//               mtWarning, [mbOk]);
    edQtdLot.Clear;
    edQtdLot.SetFocus;
    Exit;
  end;
  //
  recQtdSel:= edQtdLot.AsCurrency;
  //
  Close;
end;

procedure TFrmQtdEstLote.edQtdLotKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then
      btConfirmarClick(Sender);
end;

procedure TFrmQtdEstLote.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;

  //CTRL + S
  if (Key = 83) and (ssCtrl in Shift) then
  begin
    btConfirmarClick(Sender);
    key:= 0;
  end;
end;

procedure TFrmQtdEstLote.FormShow(Sender: TObject);
begin
  lbCabecalho.Caption:= 'QUANTIDADE LOTE '+recNroLote;

  edQtdLot.AsCurrency:= recQtdSel;

  edQtdLot.SelectAll;
end;

procedure TFrmQtdEstLote.btCancelarClick(Sender: TObject);
begin
  recQtdSel:= 0;
  Close;
end;

end.
