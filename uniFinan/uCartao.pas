unit uCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, DB,
  LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit,
  LMDCustomEdit, LMDBaseControl, LMDLabel, LMDBaseLabel, LMDCustomLabel, Vcl.DBGrids,
  LMDSimplePanel, LMDBaseGraphicControl, LMDButtonControl, uRESTDWBasicTypes,
  Vcl.StdCtrls, AdvGlowButton,Vcl.Mask, RxDBCtrl, LMDRadioButton, LMDEdit,
  Vcl.ExtCtrls, Vcl.Grids, AdvGrid, DBAdvGrid, RxCurrEdit, RxToolEdit, Vcl.ExtDlgs,
  AdvToolBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Comp.Client;

type
  TFrmCartao = class(TForm)
    PanelQuitacao: TLMDSimplePanel;
    PanelBaixa: TLMDSimplePanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    VlrJurAux: TCurrencyEdit;
    VlrDesAux: TCurrencyEdit;
    VlrPagAux: TCurrencyEdit;
    TotPagAux: TCurrencyEdit;
    edCodcon: TLMDLabeledEdit;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    btBaiTudo: TAdvGlowButton;
    Shape2: TShape;
    PanelFiltros: TLMDSimplePanel;
    Label21: TLabel;
    Label22: TLabel;
    Label38: TLabel;
    LMDSimplePanel11: TLMDSimplePanel;
    Label37: TLabel;
    Label39: TLabel;
    RadioLan: TLMDRadioButton;
    RadioVen: TLMDRadioButton;
    edFilial: TLMDLabeledEdit;
    Label1: TLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btBuscar: TAdvGlowButton;
    edNotFis: TLMDLabeledEdit;
    Label4: TLabel;
    btSelecao: TAdvGlowButton;
    LMDSimplePanel4: TLMDSimplePanel;
    Label13: TLabel;
    Label14: TLabel;
    RadioAbe: TLMDRadioButton;
    RadioCon: TLMDRadioButton;
    edNomcar: TLMDLabeledEdit;
    OpenPastaDialog: TOpenPictureDialog;
    Label2: TLabel;
    edArquivo: TLMDLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edArquivoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomcarCustomButtons0Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
    procedure AjustGrid;
  public
    { Public declarations }
  end;

var
  FrmCartao: TFrmCartao;

implementation

{$R *.dfm}

uses uConst, uLibFarm, uBanCartao;

procedure TFrmCartao.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCartao.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmCartao.FormShow(Sender: TObject);
begin
   edDataIni.Date := Date;
   edDataFin.Date := IncMonth(Date);
   AjustGrid;
   edNomcar.SetFocus;
end;

procedure TFrmCartao.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   {if Column.FieldName = 'IndSel' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if QueTituIndSel.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if }
end;

procedure TFrmCartao.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Shift = [ssCtrl]) and (Key = 46) then Key := 0;
end;

procedure TFrmCartao.edArquivoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   OpenPastaDialog.Execute;
   edArquivo.Text := OpenPastaDialog.FileName;
end;

procedure TFrmCartao.edNomcarCustomButtons0Click(Sender: TObject; index: Integer);
begin
   FrmBanCart := TFrmBanCart.Create(Application);
   try
      FrmBanCart.ShowModal;
   finally
      FrmBanCart.Free;
   end;
end;

procedure TFrmCartao.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCartao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Self   := nil;
   Action := caFree;
end;

end.

