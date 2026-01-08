unit uBuscaPro;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, StdCtrls, LMDControl, LMDCustomPanel, uDM, uConst, uLibFarm,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, Vcl.ExtCtrls;

type
  TFrmBuscaPro = class(TForm)
    PanelBusca: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TEdit;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    Timer: TTimer;
    QueryAuxIDProd: TIntegerField;
    QueryAuxDespro: TWideStringField;
    QueryAuxDesSubs: TWideMemoField;
    QueryAuxNompes: TWideStringField;
    QueryAuxEstTotal: TFloatField;
    QueryAuxPrecoVen: TFloatField;
    QueryAuxPrecoPMC: TFloatField;
    QueryAuxPrecoFP: TFloatField;
    QueryAuxPrecoFab: TFloatField;
    QueryAuxCustoMed: TFloatField;
    QueryAuxEstFilial1: TIntegerField;
    QueryAuxEstFilial2: TIntegerField;
    QueryAuxEstFilial3: TIntegerField;
    QueryAuxEstFilial4: TIntegerField;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    procedure AbreSQL;
    procedure ExecuteBusca;
    { Private declarations }
  public
    { Public declarations }
    recCarc:Word;
    edRetorno: TEdit;
    WidthColuna:Integer;
    prodBusca: TArqPedidoIte;
    VenProdExibComEst: Integer;
    ArqBusca,CampoOrigem,CampoRetor,CampoBusca,CamposFiltro,Filtro,CampoShow:String;
  end;

var
   FrmBuscaPro: TFrmBuscaPro;

implementation

{$R *.dfm}

uses uConEsto, uShadowForm;

procedure TFrmBuscaPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaPro.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   AbreSQL;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaPro.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   ExecuteBusca;
end;

procedure TFrmBuscaPro.edBuscaChange(Sender: TObject);
begin
   Timer.Enabled := False;
   Timer.Enabled := True;
end;

procedure TFrmBuscaPro.ExecuteBusca;
var
   Tam:Integer;
begin
   Tam := Length(edBusca.Text);
   if Tam <= 2 then
   begin
      if QueryAux.Active then QueryAux.Close;
   end
   else AbreSQL;
end;

procedure TFrmBuscaPro.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_DOWN then
   begin
      Key := 0;
      if QueryAux.Active then QueryAux.Next
   end else
   if Key = VK_UP then
   begin
      Key := 0;
      if QueryAux.Active then QueryAux.Prior;
   end else
   if Key = VK_ESCAPE then
   begin
      edBusca.Text := '';
      Close;
   end else
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaPro.AbreSQL;
var
   soInteger:String;
begin
   with QueryAux do
   begin
      QueryAux.Close;
      SQL.Clear;
      SQL.Text :=
      'SELECT p.IDProd,p.Despro,GROUP_CONCAT(DISTINCT s.DesSubs SEPARATOR ", ") AS DesSubs,pe.Nompes,SUM(COALESCE(pl.Qtdest, 0)) AS EstTotal,'+
      'P.PrecoVen, P.PrecoPMC, P.PrecoFP, P.PrecoFab, P.CustoMed, 0 as EstFilial1, 0 as EstFilial2, 0 as EstFilial3, 0 as EstFilial4 '+
      'FROM arqproduto p LEFT JOIN arqprodutosub ps ON p.IDProd = ps.IDProd LEFT JOIN arqsubstancia s ON ps.IDSubs = s.IDSubs '+
      'LEFT JOIN arqpessoa pe ON p.IDFabr = pe.IDPess LEFT JOIN arqprodutolot pl ON p.IDProd = pl.IDProd ';
      soInteger := iif(ExisteStr(Trim(edBusca.Text)),  '', OnlyNumbers(edBusca.Text));
      if soInteger <> '' then
      begin
         if soInteger.Length > 11 then
              SQL.Add('LEFT JOIN arqprodutoean EAN ON p.IDProd = EAN.IDProd WHERE p.CodEANpri = '+Aspas(soInteger)+' OR EAN.CodEAN = '+Aspas(soInteger))
         else SQL.Add('WHERE P.IDProd = '+soInteger);
      end
      else SQL.Add('WHERE p.Despro LIKE CONCAT("%", '+Aspas(edBusca.Text)+', "%") OR s.DesSubs LIKE CONCAT("%", '+Aspas(edBusca.Text)+', "%") ');
      SQL.Add(' GROUP BY p.IDProd,p.Despro,pe.Nompes ORDER BY p.Despro LIMIT 500');

      // 0-Exibe todos os Produtos / 1-Exibe Apenas Produto com Estoque
      if VenProdExibComEst = 1 then
      begin
        SQL.Text:= 'SELECT * FROM ('+SQL.Text+') temp WHERE EstTotal > 0';
      end;
      QueryAux.Open;
   end; //with
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -5;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaPro.DBGrid1CellClick(Column: TColumn);
var
  prodID: Integer;
begin
   // ----- Estoque -----
   if Column.ID = 3 then
   begin
     prodID:= 0;
     if QueryAuxIDProd.AsInteger > 0 then
     begin
       prodID:= QueryAuxIDProd.AsInteger
     end else if QueryAuxIDProd.AsInteger > 0 then
     begin
       prodID:= QueryAuxIDProd.AsInteger;
     end else
     begin
       MostraMsg('Aviso', 'Favor escolher um produto!',mtWarning, [mbOk]);
       Exit;
     end;
     FrmConEsto := TFrmConEsto.Create(Application);
     try
        CentralizarControl(FrmConEsto, PanelBusca);
        FrmConEsto.recIDProd := QueryAuxIDProd.AsInteger;
        FrmConEsto.ShowModal;
     finally
        FrmConEsto.Free;
     end;
   end;
end;

procedure TFrmBuscaPro.DBGrid1DblClick(Sender:TObject);
begin
   with QueryAux do
   begin
      if IsEmpty or (FieldByName('Despro').AsString.Trim = '') then Exit;
      prodBusca.IDFilial := FILIAL;
      prodBusca.IDPed    := 0;
      prodBusca.Nroite   := 0;
      prodBusca.Nrolot   := '';
      prodBusca.IDVend   := 0;
      prodBusca.IndComi  := 1;
      prodBusca.VlrPIS   := 0;
      prodBusca.VlrCOF   := 0;
      prodBusca.Qtdped   := 1;
      prodBusca.PerDesc  := 0;
      prodBusca.VlrDesc  := 0;
      prodBusca.VlrVenda := 0;
      prodBusca.IndConf  := '0';
      prodBusca.IDProd   := FieldByName('IDProd').AsInteger;
      prodBusca.PrecoVen := FieldByName('PrecoVen').AsFloat;
      prodBusca.PrecoPMC := FieldByName('PrecoPMC').AsFloat;
      prodBusca.PrecoFP  := FieldByName('PrecoFP').AsFloat;
      prodBusca.PrecoFab := FieldByName('PrecoFab').AsFloat;
      prodBusca.CustoMed := FieldByName('CustoMed').AsFloat;
      prodBusca.Despro   := FieldByName('Despro').AsString;
      prodBusca.Nomefab  := FieldByName('Nompes').AsString;
      prodBusca.EstTotal := FieldByName('EstTotal').AsFloat;
      edRetorno.Tag      := FieldByName('IDProd').AsInteger;
   end; //with
   Close;
end;

procedure TFrmBuscaPro.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
   if key = VK_SPACE  then
   begin
     FrmConEsto := TFrmConEsto.Create(Application);
     try
        FrmConEsto.recIDProd := QueryAuxIDProd.AsInteger;
        FrmConEsto.ShowModal;
     finally
        FrmConEsto.Free;
     end;
   end;
end;

procedure TFrmBuscaPro.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
   end;
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 3 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3,Rect.Top+4,10); // Estoque
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmBuscaPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if edRetorno.Tag = 0 then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.
