unit uFechaPG;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.StdCtrls,
   MarcLib, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   uRESTDWBasicTypes, uRESTDWBasicDB, Data.DB, LMDEdit, Vcl.ExtCtrls, Vcl.Mask,
   LMDBaseEdit, LMDCustomEdit, LMDDBEdit, LMDBaseControl, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.Grids,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, LMDLabel, RxToolEdit, RxCurrEdit, Vcl.DBGrids,
   AdvGlowButton, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDSimplePanel;

type
   TFrmFechaPG = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    Shape1: TShape;
    PanelBckBut: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelMen: TLMDSimplePanel;
    LMDSimplePanel1: TLMDSimplePanel;
    btPag2: TAdvGlowButton;
    btPag1: TAdvGlowButton;
    btPag3: TAdvGlowButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    btPag4: TAdvGlowButton;
    TabPedidoPag: TRESTDWClientSQL;
    SouPedidoPag: TDataSource;
    TabPedidoPagIDFilial: TIntegerField;
    TabPedidoPagIDPed: TIntegerField;
    TabPedidoPagNropag: TSmallintField;
    TabPedidoPagIDForPag: TSmallintField;
    TabPedidoPagIndPOS: TWideStringField;
    TabPedidoPagIDCartao: TSmallintField;
    TabPedidoPagNroNSU: TWideStringField;
    TabPedidoPagTipcar: TWideStringField;
    TabPedidoPagVlrPago: TFloatField;
    TabPedidoPagDesForPag: TWideStringField;
    TabPedidoPagNomred: TWideStringField;
    PanelButtons: TLMDSimplePanel;
    PanelTotais: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    Label8: TLabel;
    edVlrPagar: TCurrencyEdit;
    Label1: TLabel;
    edAjustes: TCurrencyEdit;
    Label2: TLabel;
    edVlrPago: TCurrencyEdit;
    btPag5: TAdvGlowButton;
    Label3: TLabel;
    edTroco: TCurrencyEdit;
    btPag7: TAdvGlowButton;
    btPag6: TAdvGlowButton;
    btPag8: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabPedidoPagBeforePost(DataSet: TDataSet);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabPedidoPagBeforeInsert(DataSet: TDataSet);
    procedure TabPedidoPagAfterPost(DataSet: TDataSet);
    procedure btPagtoClick(Sender: TObject);
    procedure edVlrPagoExit(Sender: TObject);
  private
    indNotInsert:Boolean;
    QuePedido:TRESTDWClientSQL;
    procedure AjustGrid;
    function GeraItForPag(recIDForPag:Integer; recVlrPago:Double):Boolean;
    { Private declarations }
  public
    { Public declarations }
    recIDPed:Integer;
  end;

var
   FrmFechaPG: TFrmFechaPG;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPendente, uRecePOS;

procedure TFrmFechaPG.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   QuePedido := TRESTDWClientSQL.Create(nil);
   QuePedido.DataBase := DM.DWDataBase;
   indNotInsert := False;
end;

procedure TFrmFechaPG.FormShow(Sender: TObject);
var
   Comp:TComponent;
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT IDForPag FROM arqforpagto WHERE IndAtivo';
         QueAuxi.Open;
         while not QueAuxi.Eof do
         begin
            Comp := Self.FindComponent('btPag'+QueAuxi.FieldByName('IDForPag').AsString);
            if Assigned(Comp) and (Comp is TControl) then TControl(Comp).Visible := True;
            QueAuxi.Next;
         end;
         QuePedido.SQL.Text := 'SELECT * FROM arqpedido WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+recIDPed.ToString;
         QuePedido.Open;
         TabPedidoPag.ParamByName('IDFilial').AsInteger := FILIAL;
         TabPedidoPag.ParamByName('IDPed').AsInteger    := recIDPed;
         TabPedidoPag.Open;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'Não foi possível finalizar a venda -> uFechaPG -> '+E.Message);
            MostraMsg('Erro','Não foi possível finalizar e venda!', mtWarning, [mbOk]);
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   if QuePedido.FieldByName('IDForPag').AsInteger > 0 then
   begin
      if not TabPedidoPag.Locate('IDFilial;IDPed;IDForPag', VarArrayof([FILIAL,recIDPed,QuePedido.FieldByName('IDForPag').AsInteger]), []) then
         GeraItForPag(QuePedido.FieldByName('IDForPag').AsInteger, QuePedido.FieldByName('TotPedido').AsFloat);
   end;
   TabPedidoPagAfterPost(TabPedidoPag);
   AjustGrid;
   DBGrid1.SetFocus;
end;

procedure TFrmFechaPG.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmFechaPG.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   auxIDForPag:Integer;
begin
   indNotInsert := False;
   if (key = VK_F2) and (not btPag1.Visible) then Exit;
   if (key = VK_F3) and (not btPag2.Visible) then Exit;
   if (key = VK_F4) and (not btPag3.Visible) then Exit;
   if (key = VK_F5) and (not btPag4.Visible) then Exit;
   if (key = VK_F6) and (not btPag5.Visible) then Exit;
   if (key = VK_F7) and (not btPag6.Visible) then Exit;
   if (key = VK_F8) and (not btPag7.Visible) then Exit;
   if (key = VK_F9) and (not btPag8.Visible) then Exit;

   if key = VK_F2 then GeraItForPag(1, edVlrPagar.Value);
   if key = VK_F3 then GeraItForPag(2, edVlrPagar.Value);
   if key = VK_F4 then GeraItForPag(3, edVlrPagar.Value);
   if key = VK_F5 then GeraItForPag(4, edVlrPagar.Value);
   if key = VK_F6 then GeraItForPag(5, edVlrPagar.Value);
   if key = VK_F7 then GeraItForPag(6, edVlrPagar.Value);
   if key = VK_F8 then GeraItForPag(7, edVlrPagar.Value);
   if key = VK_F9 then GeraItForPag(8, edVlrPagar.Value);
   if Key = VK_ESCAPE then Close;
   indNotInsert := True;
end;

procedure TFrmFechaPG.btPagtoClick(Sender: TObject);
begin
   GeraItForPag(TAdvGlowButton(Sender).Tag, edVlrPagar.Value);
end;

function TFrmFechaPG.GeraItForPag(recIDForPag:Integer; recVlrPago:Double):Boolean;
begin
   Result := True;
   try
      if recVlrPago > 0.00 then
      begin
         TabPedidoPag.Append;
         TabPedidoPagIDFilial.Value := FILIAL;
         TabPedidoPagIDPed.Value    := recIDPed;
         TabPedidoPagIDForPag.Value := recIDForPag;
         TabPedidoPagVlrPago.Value  := recVlrPago;
         TabPedidoPag.Post;
         TabPedidoPag.Refresh;
         AjustGrid;
      end; //if
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO, PastaLog, 'Não foi possível finalizar a venda -> uFechaPG -> '+E.Message);
         MostraMsg('Erro','Não foi possível finalizar e venda!', mtWarning, [mbOk]);
         Result := False;
         Exit;
      end;
   end;
end;

procedure TFrmFechaPG.TabPedidoPagAfterPost(DataSet: TDataSet);
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT SUM(VlrPago) AS TotForPag FROM arqpedidopag WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+recIDPed.ToString;
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
              edVlrPago.Value := QueAuxi.FieldByName('TotForPag').AsFloat
         else edVlrPago.Value := 0.00;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'Não foi possível finalizar a venda -> uFechaPG: TabPedidoPagAfterInsert -> '+E.Message);
            MostraMsg('Erro','Não foi possível finalizar e venda!', mtWarning, [mbOk]);
            Self.Close;
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   edVlrPagar.Value := QuePedido.FieldByName('TotPedido').AsFloat - edVlrPago.Value;
   edVlrPagoExit(edVlrPago);
end;

procedure TFrmFechaPG.TabPedidoPagBeforeInsert(DataSet: TDataSet);
begin
   if indNotInsert then Abort;
end;

procedure TFrmFechaPG.TabPedidoPagBeforePost(DataSet: TDataSet);
begin
   if TabPedidoPagVlrPago.Value <= 0.00 then
   begin
      MostraMsg('Erro','Valor Pago deve conter um valor positivo válido!', mtWarning, [mbOk]);
      Abort;
      Exit;
   end;
end;

procedure TFrmFechaPG.DBGrid1CellClick(Column: TColumn);
var
   PanelPos:TPoint;
   CenterX,CenterY:Integer;
begin
   if Column.ID = 3 then
   begin
      try
         PanelPos := DBGrid1.ClientToScreen(Point(0,0));
         if FrmRecePos = nil then Application.CreateForm(TFrmRecePos, FrmRecePos);
         CenterX := PanelPos.X + (DBGrid1.Width  div 2);
         CenterY := PanelPos.Y + (DBGrid1.Height div 2);
         FrmRecePos.Left := CenterX - (FrmRecePos.Width  div 2);
         FrmRecePos.Top  := CenterY - (FrmRecePos.Height div 2);
         FrmRecePos.recIDPed  := recIDPed;
         FrmRecePos.recNropag := TabPedidoPagNropag.Value;
         FrmRecePos.ShowModal;
      finally
         FrmRecePos := nil;
         DBGrid1.SelectedField := TabPedidoPagVlrPago;
      end;
   end else
   if Column.ID = 4 then
   begin
      if MostraMsg('Confirmação','Confirma exclusão deste Valor Pago?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         try
            TabPedidoPag.Delete;
            TabPedidoPagAfterPost(TabPedidoPag);
         except
            MostraMsg('Erro','Não foi possível excluir valor pago!', mtError, [mbOk]);
            Exit;
         end;
         DBGrid1.SelectedField := TabPedidoPagVlrPago;
      end; //if
   end; //if
end;

procedure TFrmFechaPG.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 3 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+7,Rect.Top+4,14);
   if Column.ID = 4 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4,Rect.Top+3, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmFechaPG.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Shift = [ssCtrl]) and (Key = 46) then KEY := 0;
   if ((Key = VK_TAB) or (Key = VK_RETURN)) and (DBGrid1.SelectedField = TabPedidoPagVlrPago) and (TabPedidoPagVlrPago.Value > 0.00) then
   begin
      if TabPedidoPag.State in dsEditModes then
         TabPedidoPag.Post;
   end;
end;

procedure TFrmFechaPG.edVlrPagoExit(Sender: TObject);
begin
   if edVlrPago.Value < 0.00 then edVlrPago.SetFocus;
   if edVlrPago.Value > QuePedido.FieldByName('TotPedido').AsFloat then
      edTroco.Value := edVlrPago.Value - QuePedido.FieldByName('TotPedido').AsFloat + edAjustes.Value;
end;

procedure TFrmFechaPG.btSalvarClick(Sender: TObject);
begin
    MostraMsg('Informação','Nesse local será finalizada a venda!', mtWarning, [mbOk]);
end;

procedure TFrmFechaPG.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmFechaPG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QuePedido.Close;
   TabPedidoPag.Close;
   FreeAndNil(QuePedido);
   Action := caFree;
end;

end.

