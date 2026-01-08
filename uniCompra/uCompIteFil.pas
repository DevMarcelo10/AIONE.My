unit uCompIteFil;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.StdCtrls, LMDSimplePanel, LMDControl, Data.DB,
   LMDCustomControl, LMDCustomPanel, AdvSmoothPanel, Vcl.ExtCtrls,
   uRESTDWBasicTypes, AdvEdBtn, uRESTDWBasicDB, AdvGlowButton, Vcl.Grids,
   LMDBaseGraphicControl, LMDCustomLabel, LMDCustomBevelPanel, VCL.Forms,
   Vcl.Controls, LMDBaseLabel, LMDLabel, LMDBaseControl,  Vcl.DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Vcl.Graphics,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  THackDBGrid = class(TDBGrid);

  TFrmCompFil = class(TForm)
    PanelBas: TAdvSmoothPanel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    Label1: TLMDLabel;
    btFechar: TAdvGlowButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    PanelGrids: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    TabCompraIte: TRESTDWClientSQL;
    SouCompraIte: TDataSource;
    TabCompraIteIDFilial: TIntegerField;
    TabCompraIteIDProd: TIntegerField;
    TabCompraIteQtddemIA: TFloatField;
    TabCompraIteQtdped: TFloatField;
    TabCompraIteQtdest: TFloatField;
    TabCompraIteVlrult: TFloatField;
    TabCompraIteDespro: TWideStringField;
    TabCompraIteNomfil: TWideStringField;
    TabCompraIteIndPed: TBooleanField;
    lbTitulo: TLMDLabel;
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabCompraIteBeforePost(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDComp,recIDProd:Integer;
  end;

var
   FrmCompFil: TFrmCompFil;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmCompFil.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCompFil.FormShow(Sender: TObject);
begin
   TabCompraIte.SQL.Text :=
   'SELECT ITE.*,PRO.Despro,FIL.Nomfil FROM arqcompraite ITE LEFT JOIN arqproduto PRO '+
   'ON ITE.IDProd = PRO.IDProd LEFT JOIN arqfilial FIL ON ITE.IDFilial = FIL.IDFilial '+
   'WHERE ITE.IDComp = '+recIDComp.ToString+' AND ITE.IDProd = '+recIDProd.ToString;
   TabCompraIte.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   lbTitulo.Caption := TabCompraIteDespro.AsString;
   DBGrid1.SelectedField := TabCompraIteQtdped;
end;

procedure TFrmCompFil.DBGrid1CellClick(Column: TColumn);
begin
   if Column.FieldName = 'IndPed' then
   begin
      if not (TabCompraIte.State in dsEditModes) then TabCompraIte.Edit;
      TabCompraIteIndPed.AsBoolean := not TabCompraIteIndPed.AsBoolean;
      TabCompraIte.Post;
      DBGrid1.SelectedField := TabCompraIteVlrult;
   end; //if
end;

procedure TFrmCompFil.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if Column.FieldName = 'Qtdped' then (Sender as TDBGrid).Canvas.Brush.Color := $00F4F8FF;
   if ((THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) and (not (TabCompraIte.State in dsEditModes))) or (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      (Sender as TDBGrid).Canvas.FillRect(Rect);
   end;
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+2, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+2, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
   if Column.FieldName = 'IndPed' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabCompraIteIndPed.AsBoolean = True then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmCompFil.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Shift = [SsCtrl]) and (Key = 46) then Key := 0;
end;

procedure TFrmCompFil.TabCompraIteBeforePost(DataSet: TDataSet);
begin
   if TabCompraIte.State = dsInsert then Abort;
end;

procedure TFrmCompFil.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompFil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabCompraIte.State in dsEditModes then TabCompraIte.Post;
   TabCompraIte.Close;
   Action := TCloseAction.caFree;
end;


end.
