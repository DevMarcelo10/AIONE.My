unit uTituloEst;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Grids, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, LMDBaseControl, LMDBaseGraphicControl, Vcl.DBGrids,
  LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, Data.DB,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, AdvGlowButton, MarcLib, uRESTDWBasicTypes,
  uRESTDWBasicDB, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmTitEst = class(TForm)
    PanelBas: TLMDSimplePanel;
    TmpTituBai: TRESTDWClientSQL;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    SouTItuBai: TDataSource;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    TmpTituBaiIDTitu: TFDAutoIncField;
    TmpTituBaiNroBai: TIntegerField;
    TmpTituBaiDatpag: TDateField;
    TmpTituBaiVlrJuro: TFloatField;
    TmpTituBaiVlrDesc: TFloatField;
    TmpTituBaiVlrPago: TFloatField;
    TmpTituBaiTotPago: TFloatField;
    TmpTituBaiCodconDeb: TWideStringField;
    TmpTituBaiCodconCre: TWideStringField;
    TmpTituBaiNomdebLook: TWideStringField;
    TmpTituBaiNomcreLook: TWideStringField;
    PanelTotal: TLMDSimplePanel;
    Label33: TLabel;
    btFechar: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDTitu:Integer;
  end;

var
  FrmTitEst: TFrmTitEst;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmTitEst.FormShow(Sender: TObject);
begin
   TmpTituBai.SQL.Text :=
   'SELECT TIP.*, PCD.Nomcon AS NomdebLook,PCC.Nomcon AS NomcreLook FROM arqtitulobai TIP '+
   'LEFT JOIN arqplacon PCD ON TIP.CodConDeb = PCD.Codcon LEFT JOIN arqplacon PCC ON TIP.CodConCre = PCC.Codcon '+
   'WHERE IDTitu = '+recIDTitu.ToString+' ORDER BY NroBai';
   TmpTituBai.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmTitEst.DBGrid1DblClick(Sender: TObject);
var
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação','Confirma o estorno desta Baixa?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      try
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'UPDATE arqtitulo SET Saltit = Saltit + '+FormatDouble(TmpTituBaiVlrPago.AsFloat,12,2)+' WHERE IDTitu = '+recIdTitu.ToString+';';
            SQL.Add('DELETE FROM arqtitulobai WHERE IDTitu = '+recIdTitu.ToString+';');
            ExecSQL(vErro);
            SalvaLog(USUARIO, PastaLog, 'Esotno de Baixa do Título: IDTitu = '+recIDTitu.ToString);
         end; //with
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar a estorna baixa de título -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível efetivar o estorno!'+#10+E.Message, mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      FreeAndNil(QueAuxi);
   end;
   TmpTituBai.Close;
   TmpTituBai.Open;
   if not TmpTituBai.IsEmpty then
   begin
      TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
      DBGrid1.Width := DBGrid1.Width - 10;
      DBGrid1.Width := DBGrid1.Width + 10;
   end
   else Self.Close;
end;

procedure TFrmTitEst.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmTitEst.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTitEst.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TmpTituBai.Close;
   Action := caFree;
end;

end.
