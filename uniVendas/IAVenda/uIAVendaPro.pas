unit uIAVendaPro;

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
  TFrmIAVenPro = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    Label21: TLabel;
    edNompes: TLMDLabeledEdit;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    TabProd: TRESTDWClientSQL;
    SouProd: TDataSource;
    LMDSimplePanel2: TLMDSimplePanel;
    Label1: TLabel;
    LMDLabeledEdit1: TLMDLabeledEdit;
    DBGrid1: TDBGrid;
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
   FrmIAVenPro: TFrmIAVenPro;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmIAVenPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmIAVenPro.FormShow(Sender: TObject);
begin
   //TabProd.SQL.Text := '';
   //TabProd.Open;
   AjustGrid;
end;

procedure TFrmIAVenPro.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 7;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmIAVenPro.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 5 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4,Rect.Top+4, 8); // Descontos
   if Column.ID = 6 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4,Rect.Top+4,10); // Estoque
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
end;

procedure TFrmIAVenPro.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmIAVenPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabProd.Close;
   Action := caFree;
end;

end.
