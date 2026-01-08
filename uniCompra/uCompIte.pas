unit uCompIte;

interface

uses
   Winapi.Windows, Winapi.Messages, AdvGlowButton, Vcl.Controls, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel, System.Classes,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, VCL.Forms,
   LMDSimplePanel, LMDBaseEdit, LMDCustomEdit, LMDDBEdit, Data.DB, Vcl.Grids,
   Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, Vcl.Dialogs,
   uRESTDWBasicDB, System.SysUtils, MarcLib, Vcl.Graphics, LMDCustomMaskEdit,
   LMDMaskEdit;

type
  TFrmCompIte = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    TabProduto: TRESTDWClientSQL;
    SouProduto: TDataSource;
    TabProdutoPrecoVen: TFloatField;
    TabProdutoPrecoFab: TFloatField;
    TabProdutoQtdFrac: TFloatField;
    TabProdutoUltEntrada: TDateField;
    TabProdutoUltVenda: TDateField;
    TabProdutoQtdest: TFloatField;
    TabFornRec: TRESTDWClientSQL;
    SouFornRec: TDataSource;
    TabFornRecIDPess: TIntegerField;
    TabFornRecIDProd: TIntegerField;
    TabFornRecQtdrec: TFloatField;
    TabFornRecVlruni: TFloatField;
    TabFornRecDatrec: TDateField;
    edQtdPed: TLMDLabeledMaskEdit;
    TabFornRecNompes: TWideStringField;
    TabProdutoDespro: TWideStringField;
    TabProdutoDesSubs: TWideStringField;
    TabProdutoCodEANpri: TWideStringField;
    TabProdutoNomfab: TWideStringField;
    TabProdutoCustoMed: TFloatField;
    LMDSimplePanel3: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recQtdped:Double;
    recIDComp,recNroIte,recIDProd:String;
  end;

var
  FrmCompIte: TFrmCompIte;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmCompIte.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCompIte.FormShow(Sender: TObject);
begin
   try
      TabProduto.SQL.Text := 'SELECT PRO.*,FAB.Nompes AS Nomfab,'+
      '(SELECT SUM(Qtdest) FROM arqprodutolot LOT WHERE PRO.IDProd = LOT.IDProd AND Qtdest > 0 GROUP BY LOT.IDProd) AS Qtdest,'+
      '(SELECT SUB.DesSubs FROM arqprodutosub SUP LEFT JOIN arqsubstancia SUB ON SUP.IDSubs = SUB.IDSubs WHERE PRO.IDProd = SUP.IDProd LIMIT 1) AS DesSubs '+
      'FROM arqproduto PRO LEFT JOIN arqpessoa FAB ON PRO.IDFabr = FAB.IDPess WHERE PRO.IDProd = '+recIDProd;
      TabProduto.Open;

      TabFornRec.SQL.Text :=
      'SELECT acr.IDPess, PES.Nompes, acri.IDProd, Date(acr.Datrec) AS Datrec, acri.Qtdrec,acri.Vlruni '+
      'FROM arqcomprarec acr JOIN arqcomprarecite acri ON acr.IDRec = acri.IDRec '+
      'LEFT JOIN arqpessoa PES ON acr.IDPess = PES.IDPess '+
      'INNER JOIN (SELECT IDPess,IDProd,MAX(Datrec) AS UltimoRec FROM arqcomprarec '+
      'INNER JOIN arqcomprarecite ON arqcomprarec.IDRec = arqcomprarecite.IDRec GROUP BY IDPess, IDProd) AS Ult_Rec '+
      'ON acr.IDPess = Ult_Rec.IDPess AND acri.IDProd = Ult_Rec.IDProd AND acr.Datrec = Ult_Rec.UltimoRec '+
      'WHERE acri.IDProd = '+recIDProd;
      TabFornRec.Open;
   except
      on E:Exception do
      begin
         if TabProduto.Active  then TabProduto.Close;
         if TabFornRec.Active  then TabFornRec.Close;
         if DM.DWDataBase.Active then DM.DWDataBase.Close;
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar abrir TabCompras -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível conectar ao servidor!', mtError, [mbOk]);
         PostMessage(Self.Handle, WM_CLOSE, 0, 0);
         Exit;
      end;
   end;
   edQtdPed.AsFloat := recQtdped;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmCompIte.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
   end;
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmCompIte.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompIte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabProduto.Close;
   TabFornRec.Close;
   Action := caFree;
end;

end.

