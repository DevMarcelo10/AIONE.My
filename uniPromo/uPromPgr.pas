unit uPromPgr;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDControl,
   LMDLabel, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, uRESTDWBasicDB,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit,LMDCustomEdit,
   LMDMaskEdit, LMDCustomMaskEdit, Vcl.ExtCtrls, LMDEdit, Vcl.StdCtrls,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uConst;

type
 TFrmPromPgr = class(TForm)
   PanelEdits: TLMDSimplePanel;
   LMDLabel1: TLMDLabel;
   btIncluir: TAdvGlowButton;
   LMDLabel2: TLMDLabel;
   edPrVenda: TLMDMaskEdit;
   edQtdven: TLMDMaskEdit;
   LMDSimplePanel2: TLMDSimplePanel;
   LMDSimplePanel1: TLMDSimplePanel;
   LMDLabel6: TLMDLabel;
   edIDProd: TLMDEdit;
   edNompro: TLMDLabeledEdit;
   LMDLabel3: TLMDLabel;
   edPreco: TLMDMaskEdit;
   DBGrid1: TDBGrid;
   TabPromPgr: TRESTDWClientSQL;
   SouPromPgr: TDataSource;
   TabPromPgrIDProm: TIntegerField;
   TabPromPgrIDProd: TIntegerField;
   TabPromPgrQtdven: TFloatField;
   TabPromPgrPreVenda: TFloatField;
   PanelTop: TLMDSimplePanel;
   LMDLabel4: TLMDLabel;
   procedure FormShow(Sender: TObject);
   procedure edIDProdExit(Sender: TObject);
   procedure btIncluirClick(Sender: TObject);
   procedure DBGrid1CellClick(Column: TColumn);
   procedure TabPromPgrAfterInsert(DataSet: TDataSet);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure edIDProdKeyPress(Sender: TObject; var Key: Char);
   procedure TabPromPgrAfterOpen(DataSet: TDataSet);
   procedure edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
   procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
   procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
   procedure FormCreate(Sender: TObject);
   procedure edPrVendaKeyPress(Sender: TObject; var Key: Char);
   private
   { Private declarations }
     indAdd:Boolean;
     retProdBusca:TArqPedidoIte;
     procedure AjustGrid;
   public
   { Public declarations }
     recIDProd:Integer;
     recIDProm:Integer;
   end;

var
   FrmPromPgr: TFrmPromPgr;

implementation

{$R *.dfm}

uses uDM, uBuscaPro, uLibFarm;

procedure TFrmPromPgr.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromPgr.FormShow(Sender: TObject);
begin
   indAdd := False;
   if recIDProd > 0 then
   begin
      edIDProd.Text := recIDProd.ToString;
      edIDProdExit(Self);
   end;
   edIDProd.SetFocus;
end;

procedure TFrmPromPgr.edIDProdExit(Sender: TObject);
var
   auxProd:String;
   QueAuxi:TRESTDWClientSQL;
begin
   edNompro.Clear;
   edNompro.Tag      := 0;
   _PrecoVen         := 0.00;
   edPreco.AsFloat   := 0.00;
   edQtdven.AsFloat  := 0.00;
   edPrVenda.AsFloat := 0.00;
   auxProd := AllTrim(edIDProd.Text);
   TabPromPgr.Close;
   if auxProd = '' then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT IDProd,Despro,PrecoVen FROM arqproduto WHERE '+iif(Length(auxProd) < 13, 'IDProd'+' = '+auxProd,'CodEAN'+' = '+Aspas(auxProd));
         Open;
         if IsEmpty then
         begin
            MostraMsg('Aviso','Produto não encontrado!', mtWarning, [mbOK]);
            edIDProd.SetFocus;
            Exit;
         end else
         begin
            edNompro.Tag    := FieldByName('IDProd').AsInteger;
            edNompro.Text   := FieldByName('Despro').AsString;
            edPreco.AsFloat := FieldByName('PrecoVen').AsFloat;
            TabPromPgr.SQL.Text := 'SELECT * FROM arqpromopgr WHERE '+
            'IDProm = '+recIDProm.ToString+' AND IDProd = '+edNompro.Tag.ToString+' ORDER BY Qtdven';
            TabPromPgr.Open;
         end; //if
      end; //with
   finally
      AjustGrid;
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmPromPgr.edIDProdKeyPress(Sender: TObject; var Key: Char);
begin
   if ExisteStr(Key) then Key := #0;
end;

procedure TFrmPromPgr.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if Key = VK_ESCAPE then
   begin
     edIDProd.Text := '';
     edIDProd.Tag  := 0;
     Exit;
   end;
   soInteger := iif(ExisteStr(edIDProd.Text.Trim), '', OnlyNumbers(edIDProd.Text));
   if soInteger <> '' then Exit;
   edNomproCustomButtons0Click(Self,0);
end;

procedure TFrmPromPgr.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   if edNompro.Text.Trim = '' then Exit;
   TabPromPgr.Close;
   try
      var recWidth := 610;
      FrmBuscaPro  := TFrmBuscaPro.Create(Application);
      with FrmBuscaPro do
      begin
         lPoint := edNompro.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := iif(recWidth > 0, recWidth, edNompro.Width);
         edRetorno    := TEdit(edNompro);
         edBusca.Text := edNompro.Text;
         ShowModal;
      end; // with
   finally
      retProdBusca := FrmBuscaPro.prodBusca;
      FrmBuscaPro.Free;
   end;

   edPreco.AsFloat   := 0.00;
   edQtdven.AsFloat  := 0.00;
   edPrVenda.AsFloat := 0.00;
   if retProdBusca.IDProd > 0 then
   begin
      edIDProd.Text   := retProdBusca.IDProd.ToString;
      edNompro.Text   := retProdBusca.Despro;
      edPreco.AsFloat := retProdBusca.PrecoVen;
      edPrVenda.SetFocus;
      TabPromPgr.SQL.Text := 'SELECT * FROM arqpromopgr WHERE '+
      'IDProm = '+recIDProm.ToString+' AND IDProd = '+edNompro.Tag.ToString+' ORDER BY Qtdven';
      TabPromPgr.Open;
   end
   else edIDProd.Text := '';
end;

procedure TFrmPromPgr.edPrVendaKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      if (edQtdven.AsFloat > 0.00) and (edPrVenda.AsFloat > 0.00) then btIncluir.Click
end;

procedure TFrmPromPgr.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmPromPgr.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   LMDSimplePanel2.SetFocus;
   if edNompro.Tag      <= 0    then Erro := 1 else
   if edQtdven.AsFloat  <= 0.00 then Erro := 2 else
   if edPrVenda.AsFloat <= 0.00 then Erro := 3;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso', 'Favor escolher um produto!', mtWarning, [mbOk]);
         edIDProd.SetFocus;
      end else
      if Erro = 2 then
      begin
         MostraMsg('Aviso', 'Favor preencher a quantidade limite!', mtWarning, [mbOk]);
         edQtdven.SetFocus;
      end else
      if Erro = 3 then
      begin
         MostraMsg('Aviso', 'Favor entrar o valor do produto com desconto!', mtWarning, [mbOk]);
         edPrVenda.SetFocus;
      end; //if
      Exit;
   end; //if

   TabPromPgr.Last;

   if TabPromPgr.IsEmpty then
   begin
      if edPrVenda.AsFloat >= edPreco.AsFloat then
      begin
         MostraMsg('Aviso', 'Preço de promoção não pode ser maior ou igual que o preço atual!', mtWarning, [mbOk]);
         edPrVenda.SetFocus;
         Exit
      end;
   end else
   begin
      if edQtdven.AsFloat <= TabPromPgrQtdven.Value then
      begin
         MostraMsg('Aviso', 'Quantidade em promoção não pode ser menor ou igual que a anterior!', mtWarning, [mbOk]);
         edQtdven.SetFocus;
         Exit
      end;
      if edPrVenda.AsFloat >= TabPromPgrPreVenda.Value then
      begin
         MostraMsg('Aviso', 'Preço de promoção não pode ser maior ou igual que o anterior!', mtWarning, [mbOk]);
         edPrVenda.SetFocus;
         Exit
      end;
   end; //if

   try
      try
         indAdd := True;
         TabPromPgr.Append;
         TabPromPgrIDProm.Value   := recIDProm;
         TabPromPgrIDProd.Value   := edNompro.Tag;
         TabPromPgrQtdven.Value   := edQtdven.AsFloat;
         TabPromPgrPreVenda.Value := edPrVenda.AsFloat;
         TabPromPgr.Post;
         TabPromPgr.Refresh;
      except
         on E:Exception do
         begin
            if AnsiPos('Duplicate',E.Message) > 0 then
            begin
               MostraMsg('Aviso', 'Quantidade já associada ao produto!', mtWarning, [mbOk]);
               TabPromPgr.Cancel;
               edQtdven.SetFocus;
            end else
            begin
               SalvaLog(USUARIO,PastaLog,'ERRO ao tentar salvar arqprompgr Produto/Quantidade -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar',mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      indAdd := False;
      edQtdven.SetFocus;
      AjustGrid;
   end;
   edQtdven.AsFloat  := 0.00;
   edPrVenda.AsFloat := 0.00;
   edQtdven.SetFocus;
end;

procedure TFrmPromPgr.TabPromPgrAfterInsert(DataSet: TDataSet);
begin
   if not indAdd then TabPromPgr.Delete;
end;

procedure TFrmPromPgr.TabPromPgrAfterOpen(DataSet: TDataSet);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmPromPgr.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00BFD5FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID <= 1 then
      DBGrid1.Canvas.TextRect(Rect,Rect.Left + Rect.Width - DBGrid1.Canvas.TextWidth(Column.Field.DisplayText)-3, Rect.Top+5, Column.Field.DisplayText)
   else if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+4, 0);
end;

procedure TFrmPromPgr.DBGrid1CellClick(Column: TColumn);
begin
   if TabPromPgr.RecordCount > 0 then
   begin
      if Column.ID = 2 then
      begin
         if MostraMsg('Confirmação', 'Confirma eliminação deste item da promoção?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabPromPgr.Delete;
               AjustGrid;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir arqprompgr -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
         DBGrid1.SelectedField := TabPromPgrPreVenda;
      end; //if
   end; //if
end;

procedure TFrmPromPgr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPromPgr.Close;
   Action := caFree;
end;

end.
