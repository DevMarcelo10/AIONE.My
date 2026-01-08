unit uEntradaLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, Marclib, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, Vcl.Mask,
  RxToolEdit, RxDBCtrl, AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl, RxCurrEdit,
  LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDMaskEdit, LMDEdit, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmEntradaLote = class(TForm)
    TabCompRecLot: TRESTDWClientSQL;
    TabCompRecLotIDRec: TIntegerField;
    TabCompRecLotNroite: TIntegerField;
    TabCompRecLotIDProd: TIntegerField;
    TabCompRecLotNrolot: TWideStringField;
    TabCompRecLotDatfab: TDateField;
    TabCompRecLotDatven: TDateField;
    TabCompRecLotQtdrec: TFloatField;
    SouTabCompRecLot: TDataSource;
    PanelTop: TLMDSimplePanel;
    PanelCab: TLMDSimplePanel;
    LMDLabel8: TLMDLabel;
    PanelCen: TLMDSimplePanel;
    btIncluir: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    edQuant: TLMDLabeledMaskEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    dtVencimento: TDateEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    dtFabricacao: TDateEdit;
    edNumLote: TLMDLabeledEdit;
    LMDLabel1: TLMDLabel;
    LMDLabel15: TLMDLabel;
    PanelRod: TLMDSimplePanel;
    Label35: TLabel;
    edTotQuant: TCurrencyEdit;
    edRegMS: TLMDLabeledMaskEdit;
    TabCompRecLotIdRegMS: TLargeintField;
    btAlterar: TAdvGlowButton;
    btCancelar: TAdvGlowButton;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    dgLote: TDBGrid;
    btConfirmar: TAdvGlowButton;
    procedure btSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure dgLoteDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TabCompRecLotAfterOpen(DataSet: TDataSet);
    procedure dgLoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    vErro:String;
    auxAlterar: Integer;
    auxQuantAlt:Double;
    procedure CalcQuant;
    procedure AjustaGrid;
  public
    { Public declarations }
    auxRegMS:Int64;
    auxNumLote:String;
    recQuant,auxQuant:Double;
    auxDatFab,auxDatVen:TDateTime;
    recIDRec,recNroite,recIDProd:Integer;
  end;
var
  FrmEntradaLote: TFrmEntradaLote;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmEntradaLote.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;
procedure TFrmEntradaLote.FormShow(Sender: TObject);
begin
   TabCompRecLot.SQL.Text := 'SELECT * FROM arqcomprareclot WHERE IDRec = '+recIDRec.ToString+
   ' AND Nroite = '+recNroite.ToString+' AND Nrolot <> '+Aspas('UNICO')+' ORDER BY Nrolot';
   TabCompRecLot.Open;
   SouTabCompRecLot.Enabled := True;
   dgLote.SetFocus;
   CalcQuant;
end;

procedure TFrmEntradaLote.TabCompRecLotAfterOpen(DataSet: TDataSet);
begin
   AjustaGrid;
end;

procedure TFrmEntradaLote.btIncluirClick(Sender: TObject);
begin
   if edTotQuant.Value = 0 then
   begin
      MostraMsg('Quantidade zerada','Favor verificar a quantidade para incluir um novo lote!',mtWarning, [mbOk]);
      Exit;
   end;
   edNumLote.Color      := clWhite;
   edRegMS.Color        := clWhite;
   dtFabricacao.Color   := clWhite;
   dtVencimento.Color   := clWhite;
   edQuant.Color        := clWhite;
   edNumLote.Enabled    := True;
   edRegMS.Enabled      := True;
   dtFabricacao.Enabled := True;
   dtVencimento.Enabled := True;
   edQuant.Enabled      := True;
   btIncluir.Enabled    := False;
   btAlterar.Enabled    := False;
   btExcluir.Enabled    := False;
   btConfirmar.Enabled  := True;
   btCancelar.Enabled   := True;
   auxAlterar := 0;
   edNumLote.SetFocus;
end;

procedure TFrmEntradaLote.btAlterarClick(Sender: TObject);
begin
   if TabCompRecLotIDRec.AsInteger = 0 then
   begin
      MostraMsg('Seleção em branco','Nenhum lote selecionado!',mtWarning, [mbOk]);
      exit;
   end;
   auxAlterar := 1;
   edNumLote.Color      := clWhite;
   edRegMS.Color        := clWhite;
   dtFabricacao.Color   := clWhite;
   dtVencimento.Color   := clWhite;
   edQuant.Color        := clWhite;
   edNumLote.Enabled    := True;
   edRegMS.Enabled      := True;
   dtFabricacao.Enabled := True;
   dtVencimento.Enabled := True;
   edQuant.Enabled      := True;
   btIncluir.Enabled    := False;
   btAlterar.Enabled    := False;
   btExcluir.Enabled    := False;
   btConfirmar.Enabled  := True;
   btCancelar.Enabled   := True;
   edNumLote.Text       := TabCompRecLotNrolot.AsString;
   edRegMS.AsFloat      := TabCompRecLotIdRegMS.Value;
   dtFabricacao.Date    := TabCompRecLotDatfab.AsDateTime;
   dtVencimento.Date    := TabCompRecLotDatven.AsDateTime;
   edQuant.AsFloat      := TabCompRecLotQtdrec.AsFloat;
   auxQuantAlt          := TabCompRecLotQtdrec.AsFloat + edTotQuant.Value;
end;

procedure TFrmEntradaLote.btConfirmarClick(Sender: TObject);
var
   auxQuant:Double;
   auxRegMS:String;
   QueGrava,QueAuxi:TRESTDWClientSQL;
begin
   if edNumLote.Text = '' then
   begin
      MostraMsg('Número lote inválido','Favor informar um Número válido!',mtWarning, [mbOk]);
      Exit;
   end;
   auxRegMS := FloatToStr(edRegMS.AsFloat);
   if (Length(auxRegMS) <> 13) and (not (IsNumeric(auxRegMS))) and (Copy(auxRegMS,1,1) <> '1') then
   begin
      MostraMsg('Registro MS inválido','Favor informar um registro MS válido!',mtWarning, [mbOk]);
      Exit;
   end;
   if dtFabricacao.Date <= 0 then
   begin
      MostraMsg('Data inválida','Favor informar uma data de fabricação válida!',mtWarning, [mbOk]);
      Exit;
   end;
   if dtVencimento.Date <= 0 then
   begin
      MostraMsg('Data inválida','Favor informar uma data de vencimento válida!',mtWarning, [mbOk]);
      Exit;
   end;
   if edQuant.AsFloat <= 0 then
   begin
      MostraMsg('Quantidade inválida','Favor informar uma quantidade válida!',mtWarning, [mbOk]);
      Exit;
   end;
   if auxAlterar = 0 then
   begin
      auxQuant := RoundX((edTotQuant.Value - edQuant.AsFloat),2);
      if auxQuant < 0 then
      begin
         MostraMsg('Aviso','Quantidade maior que o saldo do lote, favor verificar!',mtWarning, [mbOk]);
         exit;
      end; //if
   end else
   begin
      if auxQuantAlt < edQuant.AsFloat then
      begin
         MostraMsg('Aviso','Quantidade maior que o saldo do lote, favor verificar!',mtWarning, [mbOk]);
         exit;
      end
      else auxQuant := auxQuantAlt - edQuant.AsFloat;
   end; //if
   QueAuxi  := TRESTDWClientSQL.Create(nil);
   QueGrava := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase  := DM.DWDataBase;
   QueGrava.DataBase := DM.DWDataBase;
   try
      if auxAlterar = 0 then
      begin
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Text := 'SELECT * FROM arqcomprareclot WHERE IDRec = '+recIDRec.ToString+' AND Nroite = '+recNroite.ToString+' AND Nrolot = '+Aspas(edNumLote.Text);
         QueAuxi.Open;
         if QueAuxi.RecordCount > 0 then
         begin
            MostraMsg('Erro', 'Esse número de lote já está cadastrado!', mtError, [mbOk]);
            Exit;
         end;
      end; //if
      try
         if auxAlterar = 0 then
         begin
            QueGrava.SQL.Clear;
            QueGrava.Close;
            QueGrava.SQL.Text := 'INSERT INTO arqcomprareclot (IDRec,Nroite,IDProd,Nrolot,IdRegMS,Datfab,Datven,Qtdrec) VALUES ('+
            recIDRec.ToString +','+
            recNroite.ToString+','+
            recIDProd.ToString+','+
            Aspas(edNumLote.Text)+','+
            Aspas(FloatToStr(edRegMS.AsFloat))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',dtFabricacao.Date))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',dtVencimento.Date))+','+
            FormatDouble(edQuant.AsFloat,11,2)+')';
            QueGrava.ExecSQL(vErro);
         end else
         begin
            QueGrava.SQL.Clear;
            QueGrava.Close;
            QueGrava.SQL.Text := 'UPDATE arqcomprareclot SET '+
            'Nrolot = ' +Aspas(edNumLote.Text)+','+
            'IdRegMS = '+Aspas(FloatToStr(edRegMS.AsFloat)) +','+
            'Datfab = ' +Aspas(FormatDateTime('yyyy-mm-dd',dtFabricacao.Date))+','+
            'Datven = ' +Aspas(FormatDateTime('yyyy-mm-dd',TabCompRecLotDatven.AsDateTime))+','+
            'Qtdrec = ' +FormatDouble(edQuant.AsFloat,11,2)+' '+
            'WHERE IDRec = '+TabCompRecLotIDRec.AsString+' AND Nroite = '+TabCompRecLotNroite.AsString+' AND IDProd = '+TabCompRecLotIDProd.AsString;
            QueGrava.ExecSQL(vErro);
         end; //if
         if vErro <> '' then Raise Exception.Create(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar TabCompRecLot (uCompRec) -> '+E.Message);
            MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
      TabCompRecLot.Close;
      TabCompRecLot.Open;
      edTotQuant.Value := auxQuant;
   finally
      QueAuxi.Close;
      QueGrava.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueGrava);
   end;
   btCancelarClick(Sender);
end;

procedure TFrmEntradaLote.btCancelarClick(Sender: TObject);
begin
   edNumLote.Text       := '';
   edRegMS.AsFloat      := 0;
   dtFabricacao.Text    := '';
   dtVencimento.Text    := '';
   edQuant.AsFloat      := 0;
   edNumLote.Color      := $00EFEFEF;
   edRegMS.Color        := $00EFEFEF;
   dtFabricacao.Color   := $00EFEFEF;
   dtVencimento.Color   := $00EFEFEF;
   edQuant.Color        := $00EFEFEF;
   edNumLote.Enabled    := False;
   edRegMS.Enabled      := False;
   dtFabricacao.Enabled := False;
   dtVencimento.Enabled := False;
   edQuant.Enabled      := False;
   btIncluir.Enabled    := True;
   btAlterar.Enabled    := True;
   btExcluir.Enabled    := True;
   btConfirmar.Enabled  := False;
   btCancelar.Enabled   := False;
end;

procedure TFrmEntradaLote.AjustaGrid;
begin
   TStringGrid(dgLote).DefaultRowHeight := BaseRowHeight - 5;
   dgLote.Width := dgLote.Width - 5;
   dgLote.Width := dgLote.Width + 5;
end;

procedure TFrmEntradaLote.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   auxValor:Double;
begin
   if TabCompRecLotIDRec.AsInteger = 0 then
   begin
      MostraMsg('Aviso','Nenhum lote selecionado!', mtWarning, [mbOk]);
      exit;
   end;
   if MostraMsg('Confirmação','Confirma a exclusão do lote '+ TabCompRecLotNrolot.AsString+' ?', mtConfirmation,[mbYes, mbNo]) = mrNo then exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         auxValor := TabCompRecLotQtdrec.AsFloat;
         QueAuxi.SQL.Clear;
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'DELETE FROM arqcomprareclot WHERE IDRec = '+TabCompRecLotIDRec.AsString +
         ' AND Nroite = '+TabCompRecLotNroite.AsString+' AND Nrolot = '+Aspas(TabCompRecLotNrolot.AsString);
         QueAuxi.ExecSQL(vErro);
         TabCompRecLot.Close;
         TabCompRecLot.Open;
         edTotQuant.Value := edTotQuant.Value + auxValor;
         if vErro <> '' then Raise Exception.Create(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir lote na TabCompRecLot (uEntradaLote) -> '+E.Message);
            MostraMsg('Erro','Não foi possível excluir.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end; //try
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmEntradaLote.CalcQuant;
var
   auxSaldo:Double;
   QueAux:TRESTDWClientSQL;
begin
   auxSaldo := 0;
   QueAux   := TRESTDWClientSQL.Create(nil);
   try
      QueAux.DataBase := DM.DWDataBase;
      QueAux.SQL.Text := 'SELECT * FROM arqcomprareclot WHERE IDRec = '+recIDRec.ToString+' AND Nroite = '+recNroite.ToString;
      QueAux.Open;
      QueAux.First;
      while not QueAux.Eof do
      begin
         auxSaldo := auxSaldo + QueAux.FieldByName('Qtdrec').AsFloat;
         QueAux.Next;
      end;
      edTotQuant.Value := recQuant - auxSaldo;
   finally
      QueAux.Close;
      FreeAndNil(QueAux);
   end;// try
end;

procedure TFrmEntradaLote.dgLoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (dgLote.DataSource.DataSet.RecNo = dgLote.DataSource.DataSet.RecordCount ) then Abort;
end;

procedure TFrmEntradaLote.dgLoteDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if not TabCompRecLot.IsEmpty then
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
         TDBGrid(Sender).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end else
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
        (Sender as TDBGrid).Canvas.Brush.Color := $00FDF2EC;
        (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end; //if
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end; //if
end;

procedure TFrmEntradaLote.btSairClick(Sender: TObject);
var
   QueAux: TRESTDWClientSQL;
begin
   if edTotQuant.Value > 0 then
   begin
      QueAux := TRESTDWClientSQL.Create(nil);
      try
         QueAux.DataBase := DM.DWDataBase;
         QueAux.SQL.Text := 'SELECT GRU.IndLote FROM arqproduto PRO LEFT JOIN arqgrupo GRU ' +
         'ON PRO.IDGrupo = GRU.IDGrupo WHERE PRO.IDProd = '+recIDProd.ToString;
         QueAux.Open;
         if QueAux.FieldByName('IndLote').Value then
         begin
            MostraMsg('Aviso','Quantidade controlada por lote. Informe os lotes até zerar quantidade restante!' ,mtWarning, [mbOk]);
            Exit;
         end;
      finally
         QueAux.Close;
         FreeAndNil(QueAux);
      end;
   end; //if
   Close;
end;

procedure TFrmEntradaLote.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmEntradaLote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
