unit uIAVendaCli;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, RxToolEdit,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Vcl.Mask,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmIAVenCli = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    TabPend: TRESTDWClientSQL;
    SouPend: TDataSource;
    LMDSimplePanel1: TLMDSimplePanel;
    Label21: TLabel;
    edNompes: TLMDLabeledEdit;
    Label4: TLabel;
    edDatcad: TLMDLabeledEdit;
    DBGrid2: TDBGrid;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    TabPedidoIte: TRESTDWClientSQL;
    SouPedidoIte: TDataSource;
    Label1: TLabel;
    edUltComp: TLMDLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    edEndpes: TLMDLabeledEdit;
    Label2: TLabel;
    Label3: TLabel;
    LMDLabeledEdit3: TLMDLabeledEdit;
    Label5: TLabel;
    LMDLabeledEdit1: TLMDLabeledEdit;
    Label6: TLabel;
    LMDLabeledEdit2: TLMDLabeledEdit;
    Label7: TLabel;
    LMDLabeledEdit4: TLMDLabeledEdit;
    LMDLabeledEdit5: TLMDLabeledEdit;
    Label8: TLabel;
    Label9: TLabel;
    LMDLabeledEdit6: TLMDLabeledEdit;
    Label10: TLabel;
    LMDLabeledEdit7: TLMDLabeledEdit;
    LMDLabeledEdit8: TLMDLabeledEdit;
    Label11: TLabel;
    Label12: TLabel;
    LMDLabeledEdit9: TLMDLabeledEdit;
    LMDSimplePanel5: TLMDSimplePanel;
    LMDSimplePanel6: TLMDSimplePanel;
    LMDSimplePanel7: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    DBGrid1: TDBGrid;
    LMDSimplePanel8: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    DBGrid3: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
 private
    { Private declarations }
    procedure AjustGrid;
 public
    { Public declarations }
    recIDCliente:Integer;
 end;

var
   FrmIAVenCli: TFrmIAVenCli;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmIAVenCli.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmIAVenCli.FormShow(Sender: TObject);
begin
   //TabPedidoIte.SQL.Text := '';
   //TabPedidoIte.Open;
   AjustGrid;
end;

procedure TFrmIAVenCli.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 7;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
   TStringGrid(DBGrid2).DefaultRowHeight := BaseRowHeight - 7;
   DBGrid2.Width := DBGrid2.Width - 10;
   DBGrid2.Width := DBGrid2.Width + 10;
   TStringGrid(DBGrid3).DefaultRowHeight := BaseRowHeight - 7;
   DBGrid3.Width := DBGrid3.Width - 10;
   DBGrid3.Width := DBGrid3.Width + 10;
end;

procedure TFrmIAVenCli.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
end;

procedure TFrmIAVenCli.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmIAVenCli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPedidoIte.Close;
   TabPend.Close;
   Action := caFree;
end;

end.
