unit uBanCartao;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, LMDBaseEdit,
   LMDCustomPanel, LMDSimplePanel, LMDEdit, LMDCustomBevelPanel, LMDDBEdit,
   AdvGlowButton, LMDCustomEdit, Vcl.ExtCtrls, FireDAC.Stan.Intf, RxToolEdit,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Stan.Option,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, Vcl.StdCtrls,
   uRESTDWBasicDB, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf;

type
  TFrmBanCart = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    PanelBckBut: TLMDSimplePanel;
    edBusca: TLMDLabeledEdit;
    LMDSimplePanel6: TLMDSimplePanel;
    LMDSimplePanel5: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    DBGrid2: TDBGrid;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDSimplePanel7: TLMDSimplePanel;
    LMDSimplePanel8: TLMDSimplePanel;
    DBGrid3: TDBGrid;
    LMDSimplePanel9: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    LMDSimplePanel10: TLMDSimplePanel;
    DBGrid4: TDBGrid;
    LMDSimplePanel11: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    PanelRodape: TLMDSimplePanel;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    LMDSimplePanel12: TLMDSimplePanel;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    LMDDBLabeledEdit12: TLMDDBLabeledEdit;
    LMDDBLabeledEdit13: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit14: TLMDDBLabeledEdit;
    TabBand: TRESTDWClientSQL;
    SouBand: TDataSource;
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    TabBandIDBan: TIntegerField;
    TabBandDesban: TWideStringField;
    TabBandIndAntecipa: TBooleanField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
 private
    { Private declarations }
    procedure AjustGrid(Sender: TObject);
 public
    { Public declarations }
 end;

var
   FrmBanCart: TFrmBanCart;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBanCart.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBanCart.FormShow(Sender: TObject);
begin
   AjustGrid(DBGrid1);
   AjustGrid(DBGrid2);
   AjustGrid(DBGrid3);
   AjustGrid(DBGrid4);
end;

procedure TFrmBanCart.AjustGrid(Sender: TObject);
begin
   TabBand.Open;
   TDBGrid(Sender).Width := TDBGrid(Sender).Width - 5;
   TDBGrid(Sender).Width := TDBGrid(Sender).Width + 5;
end;

procedure TFrmBanCart.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   colLixo:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   end;
   colLixo := TDBGrid(Sender).Tag;
   if Column.ID = colLixo then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3,Rect.Top+3,0);
   TStringGrid(TDBGrid(Sender)).DefaultRowHeight := BaseRowHeight - 4;
end;

procedure TFrmBanCart.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmBanCart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabBand.Close;
   Action := caFree;
end;

end.
