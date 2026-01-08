unit uModelo_Dash;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseEdit, LMDCustomEdit,
   LMDLabel, RxToolEdit, RxDBCtrl, Data.DB, LMDBaseControl, LMDBaseLabel, Vcl.DBGrids,
   LMDBaseGraphicControl, LMDCustomLabel, LMDCustomBevelPanel, AdvGlowButton, MarcLib,
   Vcl.StdCtrls, LMDSimplePanel, LMDDBEdit, LMDControl, Vcl.Grids, LMDMaskEdit,
   LMDCustomControl, LMDCustomPanel, AdvSmoothPanel, LMDCustomMaskEdit, LMDScrollBox,
   LMDCustomScrollBox, AdvGaugeCircle, AdvSmoothListBox, Vcl.ExtCtrls, LMDEdit,
   uRESTDWBasicTypes, Vcl.Imaging.PngImage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, AdvEdit,
   uRESTDWBasicDB, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   LMDCustomComponent, LMDEditAutoComplete, AdvEdBtn;

type
  TFrmCompraCad = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelPromo: TLMDSimplePanel;
    PanelBas: TAdvSmoothPanel;
    PanelCenter: TAdvSmoothPanel;
    lbFrase1: TLMDLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    LMDMaskEdit1: TLMDMaskEdit;
    Shape1: TShape;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    Shape2: TShape;
    LMDMaskEdit2: TLMDMaskEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    Shape3: TShape;
    LMDMaskEdit3: TLMDMaskEdit;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    Shape4: TShape;
    LMDMaskEdit4: TLMDMaskEdit;
    LMDLabel6: TLMDLabel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    LMDLabel7: TLMDLabel;
    LMDLabel8: TLMDLabel;
    LMDSimplePanel5: TLMDSimplePanel;
    LMDLabel9: TLMDLabel;
    Shape5: TShape;
    LMDMaskEdit5: TLMDMaskEdit;
    LMDSimplePanel6: TLMDSimplePanel;
    LMDLabel10: TLMDLabel;
    Shape6: TShape;
    LMDMaskEdit6: TLMDMaskEdit;
    LMDSimplePanel7: TLMDSimplePanel;
    LMDLabel11: TLMDLabel;
    Shape7: TShape;
    LMDMaskEdit7: TLMDMaskEdit;
    LMDSimplePanel8: TLMDSimplePanel;
    LMDLabel12: TLMDLabel;
    Shape8: TShape;
    LMDMaskEdit8: TLMDMaskEdit;
    AdvSmoothPanel3: TAdvSmoothPanel;
    LMDLabel18: TLMDLabel;
    LMDSimplePanel13: TLMDSimplePanel;
    LMDLabel21: TLMDLabel;
    Shape13: TShape;
    LMDMaskEdit9: TLMDMaskEdit;
    LMDSimplePanel9: TLMDSimplePanel;
    LMDLabel15: TLMDLabel;
    LMDMaskEdit12: TLMDMaskEdit;
    AdvSmoothPanel2: TAdvSmoothPanel;
    LMDLabel13: TLMDLabel;
    LMDSimplePanel10: TLMDSimplePanel;
    LMDLabel14: TLMDLabel;
    Shape9: TShape;
    LMDMaskEdit10: TLMDMaskEdit;
    LMDSimplePanel11: TLMDSimplePanel;
    LMDLabel16: TLMDLabel;
    LMDMaskEdit11: TLMDMaskEdit;
    PanelGrid: TAdvSmoothPanel;
    LMDLabel17: TLMDLabel;
    AdvSmoothPanel5: TAdvSmoothPanel;
    AdvGaugeCircle1: TAdvGaugeCircle;
    DBGrid1: TDBGrid;
    LMDSimplePanel12: TLMDSimplePanel;
    LMDLabel19: TLMDLabel;
    Image1: TImage;
    LMDSimplePanel14: TLMDSimplePanel;
    LMDLabel22: TLMDLabel;
    Shape10: TShape;
    LMDMaskEdit13: TLMDMaskEdit;
    Image2: TImage;
    LMDLabel23: TLMDLabel;
    LMDSimplePanel15: TLMDSimplePanel;
    LMDLabel24: TLMDLabel;
    Shape11: TShape;
    Image3: TImage;
    LMDLabel25: TLMDLabel;
    LMDMaskEdit14: TLMDMaskEdit;
    LMDLabel26: TLMDLabel;
    LMDSimplePanel16: TLMDSimplePanel;
    LMDLabel27: TLMDLabel;
    Image4: TImage;
    LMDLabel28: TLMDLabel;
    LMDMaskEdit15: TLMDMaskEdit;
    LMDLabel20: TLMDLabel;
    TabCompraIte: TRESTDWClientSQL;
    SouCompraIte: TDataSource;
    TabCompraIteIDComp: TIntegerField;
    TabCompraIteNroite: TSmallintField;
    TabCompraIteIDProd: TIntegerField;
    TabCompraIteQtddemIA: TFloatField;
    TabCompraIteQtdped: TFloatField;
    TabCompraIteQtdpedRec: TFloatField;
    TabCompraIteVlrult: TFloatField;
    TabCompraIteQtdest: TFloatField;
    TabCompraIteIDFilial: TIntegerField;
    TabCompraIteIndPed: TBooleanField;
    TabCompraIteStatus: TWideStringField;
    TabCompraIteDespro: TWideStringField;
    btFechar: TAdvGlowButton;
    DBGridSub: TDBGrid;
    TabCompraSub: TRESTDWClientSQL;
    T: TIntegerField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField4: TFloatField;
    TabCompraSubVlrult: TFloatField;
    SouCompraMol: TDataSource;
    TabCompraSubIDSubs: TIntegerField;
    TabCompraSubDesSubs: TWideStringField;
    LMDSimplePanel17: TLMDSimplePanel;
    btAgruSubs: TAdvGlowButton;
    btProdutos: TAdvGlowButton;
    btAddItem: TAdvGlowButton;
    edBusca: TAdvEditBtn;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btAgruSubsClick(Sender: TObject);
    procedure btProdutosClick(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGridSubCellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridSubDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure AtuDBGrid;
    { Private declarations }
  public
    { Public declarations }
    RctAuxi:TRect;
    recIDComp:Integer;
  end;

var
   FrmCompraCad: TFrmCompraCad;

implementation

{$R *.dfm}

uses uDM, uMenComp, uLibFarm, uCompIte;

procedure TFrmCompraCad.FormCreate(Sender: TObject);
var
   I:Integer;
begin
   for I := 0 to Self.ComponentCount - 1 do
   begin
      if Self.Components[i] is TLMDMaskEdit then
      begin
         TLMDMaskEdit(Self.Components[I]).MaskType := meNone;
         TLMDMaskEdit(Self.Components[I]).CurrencySettings.NegativeFormatStr := '-R$ 1,1';
         TLMDMaskEdit(Self.Components[I]).CurrencySettings.PositiveFormatStr := 'R$ 1,1';
         TLMDMaskEdit(Self.Components[I]).MaskType := meCurrency;
      end;
   end; //for
end;

procedure TFrmCompraCad.FormShow(Sender: TObject);
var
   I:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Self.Top  := RctAuxi.Top  + ((RctAuxi.Height - Self.Height) div 2) - 40;
   Self.Left := RctAuxi.Left + ((RctAuxi.Width  - Self.Width)  div 2);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         FrmMenComp.auxIDComp := -1;
         QueAuxi.SQL.Text := 'SELECT IDComp,COUNT(*) AS TotReg FROM arqcompra WHERE FIND_IN_SET(Status,'+Aspas('0,1')+')';
         QueAuxi.Open;
         if QueAuxi.FieldByName('TotReg').AsString <> '0' then
         begin
            FrmMenComp.StatusIndicator.Caption := QueAuxi.FieldByName('TotReg').AsString;
            FrmMenComp.PanelStatus.Visible := True;
            if QueAuxi.FieldByName('TotReg').AsInteger = 1 then FrmMenComp.auxIDComp := QueAuxi.FieldByName('IDComp').AsInteger;
         end
         else FrmMenComp.PanelStatus.Visible := False;

         TabCompraIte.SQL.Text := 'SELECT arqcompraite.*,arqproduto.Despro FROM arqcompraite '+
         'LEFT JOIN arqproduto ON arqcompraite.IDProd = arqproduto.IDProd WHERE IDComp = '+recIDComp.ToString;
         TabCompraIte.Open;

         TabCompraSub.SQL.Text := 'SELECT arqcomprasub.*,arqsubstancia.DesSubs FROM arqcomprasub '+
         'LEFT JOIN arqsubstancia ON arqcomprasub.IDSubs = arqsubstancia.IDSubs WHERE IDComp = '+recIDComp.ToString;
         TabCompraSub.Open;
      except
         on E:Exception do
         begin
            if TabCompraIte.Active  then TabCompraIte.Close;
            if DM.DWDataBase.Active then DM.DWDataBase.Close;
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar abrir TabCompras -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível conectar ao servidor!', mtError, [mbOk]);
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   AtuDBGrid;
end;

procedure TFrmCompraCad.AtuDBGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := 24;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   TStringGrid(DBGridSub).DefaultRowHeight := 24;
   DBGridSub.Width := DBGridSub.Width - 5;
   DBGridSub.Width := DBGridSub.Width + 5;
end;

procedure TFrmCompraCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self,'In', 8);
end;

// --------------- Exclusão de Todo Pedido de Compra ------------ //
procedure TFrmCompraCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   try
      QueAuxi := TRESTDWClientSQL.Create(nil);
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         if MostraMsg('Confirmação', 'Deseja realmente excluir esta compra?', mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               SQL.Clear;
               SQL.Add('DELETE FROM arqcompra WHERE IDComp = '   +recIDComp.ToString+';');
               SQL.Add('DELETE FROM arqcompraite WHERE IDComp = '+recIDComp.ToString+';');
               SQL.Add('DELETE FROM arqcomprasub WHERE IDComp = '+recIDComp.ToString+';');
               ExecSQL;
               Self.Close;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir registro do aquivo: arqcompra, IDComp = '+recIDComp.ToString+' -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                  Exit;
               end;
            end;
            SalvaLog(USUARIO, PastaLog, 'EXCLUSAO arqcompra, IDComp = '+recIDComp.ToString);
         end; //if
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmCompraCad.DBGrid1CellClick(Column: TColumn);
var
   Rct:TRect;
   FormSombra:TForm;
   auxNroIte:Integer;
begin
   if Column.ID >= 6 then
   begin
      if Column.ID = 7 then
      begin
         if MostraMsg('Confirmação','Confirma exclusão deste item do pedido?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            TabCompraIte.Delete;
      end else
      if Column.ID = 6 then
      begin
         FormSombra := CriarFormSombra;
         try
            FormSombra.Show;
            GetWindowRect(TWinControl(PanelGrid).Handle, Rct);
            FrmCompIte := TFrmCompIte.Create(Application);
            FrmCompIte.auxRect   := Rct;
            FrmCompIte.recIDComp := TabCompraIteIDComp.AsString;
            FrmCompIte.recNroIte := TabCompraIteNroite.AsString;
            FrmCompIte.recIDProd := TabCompraIteIDProd.AsString;
            FrmCompIte.recQtdped := TabCompraIteQtdped.AsFloat;
            FrmCompIte.ShowModal;
         finally
            FrmCompIte := nil;
            FormSombra.Free;
            TabCompraIte.DisableControls;
            auxNroIte := TabCompraIteNroite.AsInteger;
            TabCompraIte.Refresh;
            TabCompraIte.Locate('NroIte',auxNroIte,[]);
            TabCompraIte.EnableControls;
            AtuDBGrid;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabCompraIteVlrult;
   end; //if
end;

procedure TFrmCompraCad.DBGridSubCellClick(Column: TColumn);
var
   Rct:TRect;
begin
   if Column.ID = 6 then
   begin
      if MostraMsg('Confirmação','Confirma a exclusão desta Substância do pedido?', mtConfirmation,[mbYes, mbNo]) = mrYes then
         TabCompraSub.Delete;
      DBGrid1.SelectedField := TabCompraSubVlrult;
   end;
end;

procedure TFrmCompraCad.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Column.FieldName = 'Qtdped' then
      (Sender as TDBGrid).Canvas.Brush.Color := $00F4F8FF;
   if (gdSelected in State) or (gdFocused in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
   end;
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 6 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+6, Rect.Top+4, 5) else
   if Column.ID = 7 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0) else
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmCompraCad.DBGridSubDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Column.FieldName = 'Qtdped' then
      (Sender as TDBGrid).Canvas.Brush.Color := $00F4F8FF;
   if (gdSelected in State) or (gdFocused in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
   end;
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 5 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+6, Rect.Top+4, 5) else
   if Column.ID = 6 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0) else
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left +  Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText);
end;

procedure TFrmCompraCad.edBuscaChange(Sender: TObject);
var
   searchText:String;
   TabAtiva:TRESTDWClientSQL;
begin
   searchText := edBusca.Text;
   if btAgruSubs.Visible then
        TabAtiva := TabCompraIte
   else TabAtiva := TabCompraSub;
   if Length(searchText) >= 1 then
   begin
      TabAtiva.DisableControls;
      try
        TabAtiva.Locate(iif(btAgruSubs.Visible,'Despro','DesSubs'), searchText, [loPartialKey]);
      finally
        TabAtiva.EnableControls;
      end;
   end;
end;

procedure TFrmCompraCad.btAgruSubsClick(Sender: TObject);
begin
   edBusca.Clear;
   btAgruSubs.Visible := False;
   btProdutos.Visible := True;
   DBGridSub.BringToFront;
end;

procedure TFrmCompraCad.btProdutosClick(Sender: TObject);
begin
   edBusca.Clear;
   btAgruSubs.Visible := True;
   btProdutos.Visible := False;
   DBGrid1.BringToFront;
end;

procedure TFrmCompraCad.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompraCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabCompraIte.Active  then TabCompraIte.Close;
   if DM.DWDataBase.Active then DM.DWDataBase.Close;
   FadeInOut(Self,'Out',10);
   Self := nil;
end;

end.
