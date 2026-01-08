unit uVenIACli;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  MDSimplePanel, AdvGlowButton, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDMaskEdit, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, LMDSimplePanel;

type
  TFrmVenIACli = class(TForm)
    PanelBas: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelMenCli: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel4: TLMDLabel;
    edTotalpedIte: TLMDMaskEdit;
    DBGrid2: TDBGrid;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    LMDLabel5: TLMDLabel;
    LMDMaskEdit1: TLMDMaskEdit;
    DBGrid1: TDBGrid;
    PanelNfoIA: TLMDSimplePanel;
    TabUltComp: TRESTDWClientSQL;
    SouUltCom: TDataSource;
    TabUltCompIDProd: TIntegerField;
    TabUltCompProduto: TWideStringField;
    TabUltCompUltimaCompra: TDateField;
    TabUltCompQtdeTotalComprada: TFloatField;
    TabUltCompQtdeEmEstoque: TFloatField;
    TabUltCompVencMaisProx: TDateField;
    TabUltCompPrecoVen: TFloatField;
    TabUltCompPrecoFab: TFloatField;
    TabUltCompMarkup: TFloatField;
    TabProdSug: TRESTDWClientSQL;
    SouProdSug: TDataSource;
    TabProdSugIDProd: TIntegerField;
    TabProdSugDespro: TWideStringField;
    TabProdSugQtdAssociada: TLargeintField;
    TabProdSugEstoque: TFloatField;
    TabProdSugVencProx: TDateField;
    TabProdSugMarkup: TFloatField;
    TabProdSugPrecoVen: TFloatField;
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure TFrmVenIACli.AjustGrid;
  public
    { Public declarations }
    recIDPess,recIDPed:Integer;
  end;

var
  FrmVenIACli: TFrmVenIACli;

implementation

{$R *.dfm}

procedure TFrmVenIACli.FormShow(Sender: TObject);
begin
   try
      TabUltComp.SQL.Text :=
      'SELECT P.IDProd,PR.Despro,Date(MAX(R.DatPed)) AS UltimaCompra,'+
      'SUM(P.QtdPed) AS QtdeTotalComprada, SUM(PL.Qtdest) AS QtdeEmEstoque,'+
      'MIN(PL.Datven) AS VencMaisProx,PR.PrecoVen,PR.PrecoFab, PR.Markup FROM arqpessoa C '+
      'LEFT JOIN arqpedido R ON R.IDPess = C.IDPess '+
      'LEFT JOIN arqpedidoite P ON P.IDPed = R.IDPed AND P.IDFilial = R.IDFilial '
      'LEFT JOIN arqproduto PR ON PR.IDProd = P.IDProd '
      'LEFT JOIN arqprodutolot PL ON PL.IDProd = P.IDProd AND PL.IDFilial = P.IDFilial AND PL.Datven > CURDATE() '
      'WHERE C.IDPess = '+recIDPess.ToString+' AND Date(R.DatPed) >= CURDATE() - INTERVAL 18 MONTH AND R.Status = "F" '+
      'GROUP BY P.IDProd HAVING QtdeEmEstoque > 0 ORDER BY UltimaCompra DESC LIMIT 10';
      TabUltComp.Open;

      if recIDPed > 0 then
      begin
         TabProdSug.SQL.Text :=
         'SELECT P2.IDProd,PR2.Despro,COUNT(*) AS QtdAssociada,SUM(PL.Qtdest) AS Estoque,PR2.PrecoVen,'+
         'MIN(PL.Datven) AS VencProx,PR2.Markup FROM arqpedido R '+
         'LEFT JOIN arqpedidoite P1 ON P1.IDPed = R.IDPed AND P1.IDFilial = R.IDFilial '+
         'LEFT JOIN arqpedidoite P2 ON P2.IDPed = R.IDPed AND P2.IDFilial = R.IDFilial AND P2.IDProd != P1.IDProd '+
         'LEFT JOIN arqproduto PR2 ON PR2.IDProd = P2.IDProd '+
         'LEFT JOIN arqprodutolot PL ON PL.IDProd = P2.IDProd AND PL.Datven > CURDATE() '+
         'WHERE P1.IDProd IN (SELECT DISTINCT IDProd FROM arqpedidoite WHERE IDPed = '+recIDPed.ToString+' AND IDFilial = '+FILIAL.ToString+') '+
         'AND R.DatPed >= CURDATE() - INTERVAL 18 MONTH AND R.Status = "F" '+
         'GROUP BY P2.IDProd, PR2.Despro, PR2.Markup  HAVING Estoque > 0 '+
         'ORDER BY QtdAssociada DESC, Estoque DESC LIMIT 10';
         TabProdSug.Open;
      end; //if
      AjustGrid;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
end;

procedure TFrmVenIACli.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmVenIACli.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   TStringGrid(DBGrid2).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid2.Width := DBGrid2.Width - 5;
   DBGrid2.Width := DBGrid2.Width + 5;
end;

procedure TFrmVenIACli.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmVenIACli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabUltComp.Close;
   TabProdSug.Close;
end;

end.
