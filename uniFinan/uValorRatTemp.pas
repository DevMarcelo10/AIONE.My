unit uValorRatTemp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, RxToolEdit,
  RxCurrEdit, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomLabel, LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit,
  MarcLib, LMDEdit, FireDAC.Stan.Intf, FireDAC.Stan.Option, Vcl.ExtCtrls,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, LMDMaskEdit,
  uRESTDWBasicTypes, uRESTDWBasicDB, Vcl.DBCtrls, AdvGlowButton,
  LMDCustomMaskEdit;

type
  TFrmVlrRatTemp = class(TForm)
    TabRateio: TRESTDWClientSQL;
    SouNatFin: TDataSource;
    PanelBack: TLMDSimplePanel;
    PanelRod: TLMDSimplePanel;
    Label35: TLabel;
    edTotPer: TCurrencyEdit;
    PanelRatNatFin: TLMDSimplePanel;
    TabRateioIDTitu: TLongWordField;
    TabRateioIDNatFin: TIntegerField;
    TabRateioRatFixo: TWideStringField;
    TabRateioValorRat: TFloatField;
    TabRateioDesnat: TWideStringField;
    PanelButtons: TLMDSimplePanel;
    btRatFin: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edNatFin: TLMDLabeledEdit;
    edVlrRateio: TLMDLabeledMaskEdit;
    btIncluir: TAdvGlowButton;
    btCancelar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btConfirmar: TAdvGlowButton;
    PanelRatNatFixo: TLMDSimplePanel;
    DBGrid2: TDBGrid;
    PanelCab: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure edNatFinKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btIncluirClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btRatFinClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TabRateioAfterOpen(DataSet: TDataSet);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function  CalcSaldo:Boolean;
    procedure AbreSql;
    procedure AjustGrid;
  public
    { Public declarations }
    recSaltit:Double;
    recIDTitu,recIDNatFin:Integer;
    recOrigTitu,recDesNatFin:String;
  end;

var
  FrmVlrRatTemp: TFrmVlrRatTemp;

implementation

{$R *.dfm}

uses uLibFarm, uDM, uConst;

procedure TFrmVlrRatTemp.FormShow(Sender: TObject);
begin
   PanelRatNatFin.Visible  := True;
   PanelRatNatFixo.Visible := False;
   AbreSql;
   CalcSaldo;
   btIncluir.SetFocus;
end;

procedure TFrmVlrRatTemp.TabRateioAfterOpen(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmVlrRatTemp.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
   TStringGrid(DBGrid2).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid2.Width := DBGrid2.Width - 10;
   DBGrid2.Width := DBGrid2.Width + 10;
end;

procedure TFrmVlrRatTemp.AbreSQL;
begin
   if PanelRatNatFin.Visible then
   begin
      TabRateio.Close;
      TabRateio.SQL.Text := 'SELECT RAT.*,NAT.Desnat FROM arqtitulorattemp RAT '+
      'LEFT JOIN arqnatfin NAT ON RAT.IDNatFin = NAT.IDNatfin '+
      'WHERE IDTitu = '+recIDTitu.ToString+' AND RatFixo = 0 AND OrigTitu = '+Aspas(recOrigTitu);
      TabRateio.Open;
   end; //if
   if PanelRatNatFixo.Visible then
   begin
      TabRateio.Close;
      TabRateio.SQL.Text := 'SELECT RAT.*,NAT.Desnat FROM arqtitulorattemp RAT '+
      'LEFT JOIN arqnatfin NAT ON RAT.IDNatFin = NAT.IDNatfin '+
      'WHERE IDTitu = '+recIDTitu.ToString+' AND RatFixo = 1 AND OrigTitu = '+Aspas(recOrigTitu);
      TabRateio.Open;
   end; //if
end;

procedure TFrmVlrRatTemp.btRatFinClick(Sender: TObject);
begin
   if PanelRatNatFin.Visible then
   begin
      btRatFin.Caption := 'Rateio Natureza Financeira';
      lbTitulo.Caption := 'Rateio Natureza Financeira Fixa';
      PanelRatNatFin.Visible  := False;
      PanelRatNatFixo.Visible := True;
      AbreSQL;
   end else
   begin
      btRatFin.Caption := 'Rateio Natureza Financeira Fixa';
      lbTitulo.Caption := 'Rateio Natureza Financeira';
      PanelRatNatFin.Visible  := True;
      PanelRatNatFixo.Visible := False;
      AbreSQL;
   end;
end;

procedure TFrmVlrRatTemp.btIncluirClick(Sender: TObject);
begin
   if edTotPer.Value = 0 then
   begin
      MostraMsg('Quantidade zerada','Favor verificar Quantidade P/ Natureza!',mtWarning, [mbOk]);
      Exit;
   end;
   edNatFin.Enabled    := True;
   edVlrRateio.Enabled := True;
   edNatFin.Color      := clWhite;
   edVlrRateio.Color   := clWhite;
   btIncluir.Enabled   := False;
   btExcluir.Enabled   := False;
   btCancelar.Enabled  := True;
   btConfirmar.Enabled := True;
   edNatFin.SetFocus;
end;

procedure TFrmVlrRatTemp.btCancelarClick(Sender: TObject);
begin
   edNatFin.Text       := '';
   edNatFin.Tag        := 0;
   edVlrRateio.AsFloat := 0;
   edNatFin.Enabled    := True;
   edVlrRateio.Enabled := True;
   edNatFin.Color      := $00EFEFEF;
   edVlrRateio.Color   := $00EFEFEF;
   btIncluir.Enabled   := True;
   btExcluir.Enabled   := True;
   btConfirmar.Enabled := False;
   btCancelar.Enabled  := False;
end;

procedure TFrmVlrRatTemp.btConfirmarClick(Sender: TObject);
var
   QueGrava,QueAuxi:TRESTDWClientSQL;
   auxValor:Double;
   Destit:Integer;
begin
   if edNatFin.Tag = 0 then
   begin
      MostraMsg('Natureza financeira inválida','Favor informar uma Natureza Financeira!',mtWarning, [mbOk]);
      Exit;
   end; //if

   if edVlrRateio.AsFloat <= 0 then
   begin
      MostraMsg('Valor inválido','Favor informar um valor válido!',mtWarning, [mbOk]);
      Exit;
   end; //if

   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT * FROM arqtitulorattemp WHERE IDTitu = '+recIDTitu.ToString+
      ' AND IDNatFin = '+edNatFin.Tag.ToString+' AND RatFixo = 0'+' AND OrigTitu = '+Aspas(recOrigTitu);
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         MostraMsg('Erro', 'Essa Natureza já foi usanda na divisão de valor.', mtError, [mbOk]);
         Exit;
      end; //if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end; //try

   auxValor := RoundX((edTotPer.Value - edVlrRateio.AsFloat),2);
   if auxValor >= 0 then
   begin
      QueGrava := TRESTDWClientSQL.Create(nil);
      try
         try
            QueGrava.DataBase := DM.DWDataBase;
            QueGrava.SQL.Text := 'INSERT INTO arqtitulorattemp (IDTitu,IDNatFin,OrigTitu,ValorRat,RatFixo) VALUES (' +
            recIDTitu.ToString+','+
            edNatFin.Tag.ToString+','+
            Aspas(recOrigTitu)+','+
            FormatDouble(edVlrRateio.AsFloat,11,2)+','+
            Aspas('0')+')';
            QueGrava.ExecSQL;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível incluir rateio na tabela arqtitulorattemp em uValorRatTemp -> '+E.Message);
               MostraMsg('Erro','Não foi possível incluir registro.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
         TabRateio.Close;
         TabRateio.Open;
         recIDNatFin    := edNatFin.Tag;
         recDesNatFin   := edNatFin.Text;
         edTotPer.Value := edTotPer.Value - edVlrRateio.AsFloat;
         edNatFin.Text  := '';
         edNatFin.Tag   := 0;
         edVlrRateio.AsFloat := 0;
      finally
         QueGrava.Close;
         FreeAndNil(QueGrava);
      end;// try
   end
   else MostraMsg('Valores divergentes','Valor Maior que o saldo do rateio. Favor verificar!',mtWarning, [mbOk]);
   btCancelar.Click;
   btIncluir.SetFocus;
end;

procedure TFrmVlrRatTemp.btExcluirClick(Sender: TObject);
var
   QueExclui: TRESTDWClientSQL;
   auxValor:Double;
begin
   if TabRateioIDNatFin.AsInteger = 0 then
   begin
      MostraMsg('Seleção em branco','Nenhuma Natureza Financeira selecionada!',mtWarning, [mbOk]);
      Exit;
   end; //if
   if MostraMsg('Confirmação','Confirmar a exclusão da Natureza Financeira '+ TabRateioDesnat.AsString+ '?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
   QueExclui := TRESTDWClientSQL.Create(nil);
   QueExclui.DataBase := DM.DWDataBase;
   try
      auxValor := TabRateioValorRat.AsFloat;
      try
         QueExclui.Close;
         QueExclui.SQL.Text := 'DELETE FROM arqtitulorattemp WHERE IDTitu = '+recIDTitu.ToString+' AND RatFixo = 0 '+
         'AND IDNatFin = '+TabRateioIDNatFin.AsString+' AND OrigTitu = '+Aspas(recOrigTitu);
         QueExclui.ExecSQL;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir rateio na tabela arqtitulorattemp em uValorRatTemp -> '+E.Message);
            MostraMsg('Erro','Não foi possível excluir registro.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
      TabRateio.Close;
      TabRateio.Open;
      edTotPer.Value := edTotPer.Value + auxValor;
   finally
      QueExclui.Close;
      FreeAndNil(QueExclui);
   end; //try
   if not TabRateio.IsEmpty then
   begin
      TabRateio.First;
      recIDNatFin  := TabRateioIDNatFin.AsInteger;
      recDesNatFin := TabRateioDesnat.AsString;
   end else
   begin
      recIDNatFin  := 0;
      recDesNatFin := '';
   end; //if
   btIncluir.SetFocus;
end;

procedure TFrmVlrRatTemp.edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
begin
   edNatFin.SetFocus;
   btBuscas('arqnatfin',TLMDEdit(edNatFin),'IDNatFin','Desnat','',0,True);
end;

procedure TFrmVlrRatTemp.edNatFinKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscas('arqnatfin',TLMDEdit(edNatFin),'IDNatFin','Desnat','',0,True);
end;

procedure TFrmVlrRatTemp.btFecharClick(Sender: TObject);
begin
   if not (edTotPer.Value = 0) then
   begin
      MostraMsg('Aviso', 'Ainda tem valor à ser dividido entre as Nat.Financeiras!',mtWarning, [mbOk]);
      Exit;
   end
   else Close;
end;

function TFrmVlrRatTemp.CalcSaldo:Boolean;
var
   auxSaldo:Double;
   auxIDNatFin:Integer;
   QueAux: TRESTDWClientSQL;
begin
   Result   := True;
   auxSaldo := 0.00;
   QueAux   := TRESTDWClientSQL.Create(nil);
   try
      QueAux.DataBase := DM.DWDataBase;
      QueAux.SQL.Text := '';
      QueAux.SQL.Text := 'SELECT * FROM arqtitulorattemp WHERE IDTitu = '+recIDTitu.ToString+' AND RatFixo = 0'+' AND OrigTitu = '+Aspas(recOrigTitu);
      QueAux.Open;
      QueAux.First;
      while not QueAux.Eof do
      begin
         auxSaldo := auxSaldo + QueAux.FieldByName('ValorRat').AsFloat;
         QueAux.Next;
      end;
      edTotPer.Value := recSaltit - auxSaldo;
      if auxSaldo > recSaltit then
      begin
         MostraMsg('Aviso', 'O Total dividido está maior que o Valor do Título!',mtWarning, [mbOk]);
         Result := False;
         Exit;
      end;// if
   finally
      QueAux.Close;
      FreeAndNil(QueAux);
   end;// try
end;

procedure TFrmVlrRatTemp.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if not TabRateio.IsEmpty then
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
         TDBGrid(Sender).Canvas.Font.Color  := clBlack;
      end;// if
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter then
            (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then
            (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify then
            (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
      end;// if
   end else
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
        (Sender as TDBGrid).Canvas.Brush.Color := $00FDF2EC;
        (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;// if
end;

procedure TFrmVlrRatTemp.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if not TabRateio.IsEmpty then
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
         TDBGrid(Sender).Canvas.Font.Color  := clBlack;
      end; //if
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter then
            (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then
            (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify then
            (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
      end;// if
   end else
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
        (Sender as TDBGrid).Canvas.Brush.Color := $00FDF2EC;
        (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;// if
end;

procedure TFrmVlrRatTemp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabRateio.Close;
   Action := caFree;
end;

end.
