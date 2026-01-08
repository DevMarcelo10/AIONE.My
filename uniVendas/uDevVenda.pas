unit uDevVenda;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, RxToolEdit;

type
  TFrmDevVenda = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    TabPedido: TRESTDWClientSQL;
    SouPedido: TDataSource;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    Label21: TLabel;
    edNompes: TLMDLabeledEdit;
    Label1: TLabel;
    LMDLabeledEdit1: TLMDLabeledEdit;
    Label22: TLabel;
    Label2: TLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btBuscar: TAdvGlowButton;
    Label4: TLabel;
    edNotFis: TLMDLabeledEdit;
    Label3: TLabel;
    LMDLabeledEdit2: TLMDLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    DBGrid2: TDBGrid;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    LMDSimplePanel5: TLMDSimplePanel;
    TabPedidoIte: TRESTDWClientSQL;
    SouPedidoIte: TDataSource;
    btGeraDev: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2CellClick(Column: TColumn);
 private
    { Private declarations }
    procedure AjustGrid;
 public
    { Public declarations }
 end;

var
   FrmDevVenda: TFrmDevVenda;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmDevVenda.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmDevVenda.FormShow(Sender: TObject);
begin
   //TabPedido.SQL.Text := '';
   //TabPedido.Open;
   AjustGrid;
end;

procedure TFrmDevVenda.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmDevVenda.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
   if Column.FieldName = 'IndSel' then
   begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      //if QuePedidoIteIndSel.AsString = '1' then
      //     Check := DFCS_CHECKED
      //else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmDevVenda.DBGrid2CellClick(Column: TColumn);
begin
   {if Column.FieldName = 'IndSel' then
   begin
      if not (TabPedidoIte.State in dsEditModes) then TabPedidoIte.Edit;
      TabPedidoIteIndSel.AsString := iif(TabPedidoIteIndSel.AsString = '0','1','0');
      TabPedidoIte.Post;
      DBGrid2.SelectedField := TabPedidoIteVlrVenda;
   end; //if }
end;

procedure TFrmDevVenda.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmDevVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPedidoIte.Close;
   TabPedido.Close;
   Action := caFree;
end;

end.
