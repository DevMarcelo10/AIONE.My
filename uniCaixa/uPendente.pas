unit uPendente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDLabel, DB,
  LMDBaseGraphicControl, LMDBaseLabel, LMDEdit, LMDCustomLabel, LMDControl, MarcLib,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.ExtCtrls,
  Vcl.StdCtrls, LMDBaseEdit, LMDCustomEdit, AdvGlowButton, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, Vcl.ImgList,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, uRESTDWBasicTypes,
  uRESTDWBasicDB, uDM, uConst, System.ImageList, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  THackDBGrid = class(TDBGrid);

  TFrmCxPend = class(TForm)
    PanelPri: TLMDSimplePanel;
    ImagesCx: TImageList;
    TabPedido: TRESTDWClientSQL;
    TabPedidoIDPed: TIntegerField;
    TabPedidoDatped: TDateTimeField;
    TabPedidoIDPess: TIntegerField;
    TabPedidoIDDesc: TIntegerField;
    TabPedidoIDConv: TIntegerField;
    TabPedidoIDPBM: TIntegerField;
    TabPedidoTotDesc: TFloatField;
    TabPedidoTotPedido: TFloatField;
    TabPedidoStatus: TWideStringField;
    TabPedidoTotBruCalc: TFloatField;
    TabPedidoNomeCli: TWideStringField;
    TabPedidoNomPBM: TWideStringField;
    SouPedido: TDataSource;
    TabPedIte: TRESTDWClientSQL;
    TabPedIteIDFilial: TIntegerField;
    TabPedIteIDPed: TIntegerField;
    TabPedIteNroite: TSmallintField;
    TabPedIteIDProd: TIntegerField;
    TabPedIteIDVend: TIntegerField;
    TabPedItePerDesc: TFloatField;
    TabPedItePrecoVen: TFloatField;
    TabPedItePrecoPMC: TFloatField;
    TabPedItePrecoFP: TFloatField;
    TabPedItePrecoFab: TFloatField;
    TabPedIteCustoMed: TFloatField;
    TabPedIteVlrPIS: TFloatField;
    TabPedIteVlrCOF: TFloatField;
    TabPedIteQtdped: TFloatField;
    TabPedIteVlrDesc: TFloatField;
    TabPedIteVlrVenda: TFloatField;
    TabPedIteDatHorAlt: TDateTimeField;
    TabPedIteIndComi: TBooleanField;
    TabPedIteDespro: TWideStringField;
    TabPedIteNomeFab: TWideStringField;
    TabPedIteUsoRece: TWideStringField;
    TabPedIteTotItemCalc: TFloatField;
    SouPedIte: TDataSource;
    TabPedidoIDVend: TIntegerField;
    TabPedidoIDEntre: TIntegerField;
    TabPedidoEmiNF: TDateTimeField;
    TabPedidoIndEntr: TWideStringField;
    TabPedidoNomven: TWideStringField;
    TabPedidoDesForPag: TWideStringField;
    TabPedIteNomven: TWideStringField;
    LMDSimplePanel6: TLMDSimplePanel;
    Shape3: TShape;
    Shape5: TShape;
    LMDSimplePanel1: TLMDSimplePanel;
    Shape2: TShape;
    Shape1: TShape;
    DBGrid1: TDBGrid;
    PanelTop: TLMDSimplePanel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    LMDLabel8: TLMDLabel;
    TabPedidoNroCesta: TWideStringField;
    TabPedidoIDFilial: TIntegerField;
    TabPedIteQtdConf: TFloatField;
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid2: TDBGrid;
    PanelBot: TLMDSimplePanel;
    PanelHelp: TLMDSimplePanel;
    LMDLabel10: TLMDLabel;
    LMDLabel9: TLMDLabel;
    LMDLabel11: TLMDLabel;
    PanelConf: TLMDSimplePanel;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    edConfPro: TLMDLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    TabPedidoIDForPag: TSmallintField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabPedIteCalcFields(DataSet: TDataSet);
    procedure TabPedidoAfterScroll(DataSet: TDataSet);
    procedure edConfProExit(Sender: TObject);
    procedure edConfProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edConfProCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edConfProCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    retProdBusca: TArqPedidoIte;
    Editar,emBusca,ConfCega:Boolean;
    procedure AjustGrid;
  public
    { Public declarations }
  end;

var
  FrmCxPend: TFrmCxPend;

implementation

uses uLibFarm, uFechaPG, uBuscaPro, uVendasAddIt;

{$R *.dfm}

procedure TFrmCxPend.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Left := (Parent.Width  - Width)  div 2;
   Top  := (Parent.Height - Height) div 2;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT IndCxCega FROM arqparametros LIMIT 1';
         QueAuxi.Open;
         ConfCega := QueAuxi.FieldByName('IndCxCega').AsBoolean;
         if ConfCega then
         begin
            DBGrid2.Columns[1].Width   := DBGrid2.Columns[1].Width + DBGrid2.Columns[2].Width;
            DBGrid2.Columns[2].Visible := False;
         end;
         TabPedido.SQL.Text :=
         'SELECT PED.*,CLI.Nompes AS NomeCli,VEN.Nompes AS Nomven,PBM.NomPBM,FPG.DesForPag FROM arqpedido PED '+
         'LEFT JOIN  arqforpagto FPG ON PED.IDForPag = FPG.IDForPag LEFT JOIN arqpbm PBM ON PED.IDPBM = PBM.IDPBM '+
         'LEFT JOIN arqpessoa CLI ON PED.IDPess = CLI.IDPess LEFT JOIN arqpessoa VEN ON PED.IDVend = VEN.IDPess '+
         'WHERE Status = "A" AND PED.TotPedido > 0.00 AND NOT IndDelete';
         TabPedido.Open;
         TabPedIte.Open;
      except
         MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
         PostMessage(Self.Handle, WM_CLOSE, 0, 0);
         Exit;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   AjustGrid;
   Editar  := False;
   emBusca := False;
   PanelHelp.Visible := False;
   edConfPro.SetFocus;
end;

procedure TFrmCxPend.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
   TStringGrid(DBGrid2).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid2.Width := DBGrid2.Width - 10;
   DBGrid2.Width := DBGrid2.Width + 10;
end;

procedure TFrmCxPend.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if ((THackDBGrid(TDBGrid(Sender)).DataLink.ActiveRecord + 1 = THackDBGrid(TDBGrid(Sender)).Row) and (not (TDataSet(TDBGrid(Sender).DataSource.DataSet).State in dsEditModes))) or (gdFocused in State) or (gdSelected in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if TDBGrid(Sender).Tag = 2 then
   begin
      if Column.ID = 0 then
      begin
         if TabPedIteQtdConf.Value = 0 then ImagesCx.Draw((Sender as TDBGrid).Canvas, Rect.Left+9,Rect.Top+3, 0) else
         if TabPedIteQtdConf.Value = TabPedIteQtdped.Value then ImagesCx.Draw((Sender as TDBGrid).Canvas, Rect.Left+9,Rect.Top+3, 3) else
         if TabPedIteQtdConf.Value > TabPedIteQtdped.Value then ImagesCx.Draw((Sender as TDBGrid).Canvas, Rect.Left+9,Rect.Top+3, 1) else
         if TabPedIteQtdConf.Value < TabPedIteQtdped.Value then ImagesCx.Draw((Sender as TDBGrid).Canvas, Rect.Left+9,Rect.Top+3, 2);
      end;
      if Column.ID = 8 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+8,Rect.Top+4, 0);
   end;
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
   if TDBGrid(Sender).Tag = 1 then
   begin
      if Column.ID = 8 then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         if TabPedidoIndEntr.AsString = '1' then
              Check := DFCS_CHECKED
         else Check := 0;
         R := Rect;
         InflateRect(R,-3,-3);
         DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
      end; //if
   end; //if
end;

procedure TFrmCxPend.edConfProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if Key = VK_ESCAPE then
   begin
     edConfPro.Text := '';
     edConfPro.Tag  := 0;
     Exit;
   end;
   soInteger := iif(ExisteStr(edConfPro.Text.Trim), '', OnlyNumbers(edConfPro.Text));
   if soInteger <> '' then Exit;
   edConfProCustomButtons1Click(Self,1);
end;

procedure TFrmCxPend.edConfProCustomButtons0Click(Sender: TObject; index: Integer);
begin
   Self.AlphaBlendValue := 100;
   FrmVendaAdd := TFrmVendaAdd.Create(Application);
   try
      if TWinControl(Sender).Name = 'edConfPro' then
      begin
         FrmVendaAdd.recIDProd := edConfPro.Tag;
         FrmVendaAdd.recNompro := edConfPro.Text;
      end else
      begin
         FrmVendaAdd.recIDProd := 0;
         FrmVendaAdd.recNompro := '';
      end;
      CentralizarControl(FrmVendaAdd, PanelPri);
      FrmVendaAdd.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmVendaAdd.Free;
   end;
end;

procedure TFrmCxPend.edConfProCustomButtons1Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   if edConfPro.Text.Trim = '' then Exit;
   try
      var recWidth := 610;
      FrmBuscaPro  := TFrmBuscaPro.Create(Application);
      with FrmBuscaPro do
      begin
         lPoint := edConfPro.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := iif(recWidth > 0, recWidth, edConfPro.Width);
         edRetorno    := TEdit(edConfPro);
         edBusca.Text := edConfPro.Text;
         ShowModal;
      end; // with
   finally
      retProdBusca := FrmBuscaPro.prodBusca;
      FrmBuscaPro.Free;
   end;
   if retProdBusca.IDProd > 0 then
   begin
     edConfPro.Text := retProdBusca.Despro;
     edConfPro.Tag  := retProdBusca.IDProd;
     edConfPro.SetFocus;
   end;
end;

// ------------ Processo de Conferência de Itens ------------ //
procedure TFrmCxPend.edConfProExit(Sender: TObject);
var
   soInteger:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if edConfPro.Text.Trim = '' then Exit;
   soInteger := iif(ExisteStr(edConfPro.Text.Trim), '', OnlyNumbers(edConfPro.Text));
   if soInteger.Length > 11 then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         try
            QueAuxi.DataBase := DM.DWDataBase;
            QueAuxi.SQL.Text := 'SELECT P.IDProd FROM arqproduto P LEFT JOIN arqprodutoean EAN ON '+
            'P.IDProd = EAN.IDProd WHERE P.CodEANpri = '+Aspas(soInteger)+' OR EAN.CodEAN = '+Aspas(soInteger);
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then edConfPro.Tag := QueAuxi.FieldByName('IDProd').AsInteger;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível buscar produto conferência, uPendente -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível buscar produto!',mtError, [mbOk]);
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;

   if not TabPedIte.Locate('IDProd',edConfPro.Tag,[]) then
   begin
      if MostraMsg('Confirmação','Produto não encontrado nesse pedido. Deseja incluir?', mtConfirmation,[mbYes, mbNo]) = mrNo then
      begin
         edConfPro.SelStart  := 1;
         edConfPro.SelLength := Length(edConfPro.Text);
         edConfPro.SetFocus;
         Exit;
      end else
      begin
         edConfProCustomButtons0Click(edConfPro,0);
         edConfPro.Text := '';
         edConfPro.Tag  := 0;
         edConfPro.SetFocus;
      end; //if
   end else
   begin
      TabPedIte.Edit;
      TabPedIteQtdConf.Value := TabPedIteQtdConf.Value + 1;
      TabPedIte.Post;
      edConfPro.Clear;
      edConfPro.Tag := 0;
      edConfPro.SetFocus;
   end; //if
   TabPedIte.Refresh;
   AjustGrid;
end;

procedure TFrmCxPend.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 8 then
   begin
      if not (TabPedido.State in dsEditModes) then TabPedido.Edit;
      TabPedidoIndEntr.AsString := iif(TabPedidoIndEntr.AsString = '0','1','0');
      TabPedido.Post;
      DBGrid1.SelectedField := TabPedidoNomPBM;
   end; //if
end;

// --------- Abrir a Tela de Fechamento de Vendas (Formas de Pagto) --------- //
procedure TFrmCxPend.DBGrid1DblClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabPedidoTotPedido.AsFloat <= 0.00 then
   begin
      MostraMsg('Aviso', 'Não é possível finalizar venda. Pedido com total zerado!',mtWarning, [mbOk]);
      DBGrid1.SetFocus;
      Exit;
   end;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT 1 FROM arqpedidoite WHERE IDFilial = '+FILIAL.ToString+
         ' AND IDPed = '+TabPedidoIDPed.AsString+' AND Qtdped > QtdConf';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            MostraMsg('Aviso', 'Não é possível finalizar venda. Há itens NÃO conferidos!',mtWarning, [mbOk]);
            edConfPro.SetFocus;
            Exit;
         end; //if
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível finalizar venda, uPendente -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível finalizar venda!',mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

   Self.AlphaBlendValue := 100;
   FrmFechaPG := TFrmFechaPG.Create(Application);
   try
      CentralizarControl(FrmFechaPG, PanelPri);
      FrmFechaPG.recIDPed := TabPedidoIDPed.Value;
      FrmFechaPG.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmFechaPG.Free;
   end;
end;

procedure TFrmCxPend.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_RETURN then DBGrid1DblClick(DBGrid1);
end;

procedure TFrmCxPend.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_F5 then DBGrid1DblClick(DBGrid1);
end;

procedure TFrmCxPend.TabPedidoAfterScroll(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmCxPend.TabPedIteCalcFields(DataSet: TDataSet);
begin
   if TabPedIteQtdConf.Value <= TabPedIteQtdped.Value then
        TabPedIteTotItemCalc.AsFloat := (TabPedIteQtdped.Value  * TabPedIteVlrVenda.Value)
   else TabPedIteTotItemCalc.AsFloat := (TabPedIteQtdConf.Value * TabPedIteVlrVenda.Value);
end;

procedure TFrmCxPend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPedIte.Close;
   TabPedido.Close;
end;

end.

