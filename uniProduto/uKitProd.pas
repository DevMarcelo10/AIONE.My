unit uKitProd;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseEdit, LMDCustomEdit,
   LMDLabel, RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseLabel, LMDBaseGraphicControl,
   LMDCustomLabel, LMDCustomBevelPanel, Vcl.ExtCtrls, AdvGlowButton, MarcLib, Data.DB,
   LMDButtonControl, LMDDBCheckBox, Vcl.StdCtrls, LMDCheckBox, LMDSimplePanel, LMDDBEdit,
   Vcl.Mask, LMDControl, LMDCustomCheckBox, LMDCustomControl, LMDCustomPanel, System.DateUtils,
   LMDCustomMaskEdit, LMDMaskEdit, Vcl.Grids, Vcl.DBGrids, System.Rtti, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Comp.Client,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicDB, uRESTDWBasicTypes,
   LMDEdit, LMDRadioButton, Vcl.ComCtrls, AdvDateTimePicker, AdvDBDateTimePicker, LMDThemedComboBox,
   LMDCustomComboBox, LMDComboBox;

type
  TFrmKitProduto = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelPromo: TLMDSimplePanel;
    PanelDescr: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBCheckBox3: TLMDDBCheckBox;
    CheckDia2: TLMDCheckBox;
    CheckDia3: TLMDCheckBox;
    CheckDia4: TLMDCheckBox;
    CheckDia5: TLMDCheckBox;
    CheckDia6: TLMDCheckBox;
    CheckDia7: TLMDCheckBox;
    CheckDia1: TLMDCheckBox;
    TabKits: TRESTDWClientSQL;
    SouKits: TDataSource;
    btFechar: TAdvGlowButton;
    PanelKit: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    PanelTik: TLMDSimplePanel;
    LMDLabel7: TLMDLabel;
    edCodpro: TLMDEdit;
    edDespro: TLMDLabeledEdit;
    RadioKit: TLMDRadioButton;
    RadioAgr: TLMDRadioButton;
    LMDLabel9: TLMDLabel;
    LMDLabel8: TLMDLabel;
    edQuant: TLMDMaskEdit;
    LMDLabel10: TLMDLabel;
    edDesc: TLMDMaskEdit;
    edValor: TLMDMaskEdit;
    LMDLabel11: TLMDLabel;
    btSalvaPro1: TAdvGlowButton;
    DBGrid1: TDBGrid;
    btBusca: TAdvGlowButton;
    TabProdIte: TRESTDWClientSQL;
    SouProdIte: TDataSource;
    TabProdAgr: TRESTDWClientSQL;
    SouProdAgr: TDataSource;
    TabProdIteIDKit: TIntegerField;
    TabProdIteIDProd: TIntegerField;
    TabProdIteQtdKit: TFloatField;
    TabProdItePerDesIte: TFloatField;
    TabProdIteVlrVenIte: TFloatField;
    TabProdAgrIDKit: TIntegerField;
    TabProdAgrIDProd: TIntegerField;
    TabProdAgrQtdagr: TFloatField;
    TabProdAgrPerDesagr: TFloatField;
    TabProdAgrVlrVenagr: TFloatField;
    TabProdIteDespro: TWideStringField;
    TabProdAgrDespro: TWideStringField;
    PanelTot: TLMDSimplePanel;
    LMDSimplePanel7: TLMDSimplePanel;
    LMDLabel17: TLMDLabel;
    edPreVen: TLMDMaskEdit;
    LMDLabel19: TLMDLabel;
    TabKitsIDKit: TFDAutoIncField;
    TabKitsDeskit: TWideStringField;
    TabKitsDataIni: TDateTimeField;
    TabKitsDataFin: TDateTimeField;
    TabKitsDiaSema: TWideStringField;
    TabKitsTipoKit: TWideStringField;
    TabKitsIndAtivo: TWideStringField;
    edVlrTotKit: TLMDDBLabeledEdit;
    TabKitsVlrTotKit: TFloatField;
    edDateIni: TAdvDBDateTimePicker;
    edDateFin: TAdvDBDateTimePicker;
    TabProdItePrecoVen: TFloatField;
    PanelAgrega: TLMDSimplePanel;
    LMDSimplePanel5: TLMDSimplePanel;
    DBGrid2: TDBGrid;
    PanelAgr: TLMDSimplePanel;
    LMDLabel12: TLMDLabel;
    LMDLabel13: TLMDLabel;
    LMDLabel14: TLMDLabel;
    LMDLabel15: TLMDLabel;
    LMDLabel16: TLMDLabel;
    LMDLabel20: TLMDLabel;
    edCodproA: TLMDEdit;
    edDesproA: TLMDLabeledEdit;
    edQuantA: TLMDMaskEdit;
    edDescA: TLMDMaskEdit;
    edValorA: TLMDMaskEdit;
    btSalvaPro2: TAdvGlowButton;
    LMDSimplePanel8: TLMDSimplePanel;
    LMDLabel18: TLMDLabel;
    edPreVenA: TLMDMaskEdit;
    ComboTipo: TLMDComboBox;
    LMDLabel5: TLMDLabel;
    TabProdAgrTipoIte: TWideStringField;
    TabProdAgrTipoIteCalc: TWideStringField;
    TabProdAgrPrecoVen: TFloatField;
    PanelButtons: TLMDSimplePanel;
    btNovo: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure TabKitsAfterInsert(DataSet: TDataSet);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RadioKitClick(Sender: TObject);
    procedure RadioAgrClick(Sender: TObject);
    procedure edCodproEnter(Sender: TObject);
    procedure btSalvaPro1Click(Sender: TObject);
    procedure RadioKitEnter(Sender: TObject);
    procedure edCodproExit(Sender: TObject);
    procedure edCodproKeyPress(Sender: TObject; var Key: Char);
    procedure edDesproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edValorExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure edCodproAEnter(Sender: TObject);
    procedure edCodproAExit(Sender: TObject);
    procedure edDesproACustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesproAKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edValorAExit(Sender: TObject);
    procedure btSalvaPro2Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure TabKitsAfterOpen(DataSet: TDataSet);
    procedure edVlrTotKitExit(Sender: TObject);
    procedure TabProdAgrCalcFields(DataSet: TDataSet);
    procedure SouKitsDataChange(Sender: TObject; Field: TField);
    procedure edQuantExit(Sender: TObject);
    procedure edQuantAExit(Sender: TObject);
  private
    { Private declarations }
    EmEdit:Boolean;
    procedure LimpaCampos;
    procedure AtiDesAgr(recAtiva: Boolean);
    procedure AjustGrid(recDBGrid: TDBGrid);
    function  Salvar:Boolean;
    procedure LimpaCamposA;
    procedure AtuEdkit;
    procedure SomaKit;
  public
    { Public declarations }
  end;

var
   FrmKitProduto: TFrmKitProduto;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uKitBus, uMetaBus;

procedure TFrmKitProduto.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmKitProduto.FormShow(Sender: TObject);
begin
   EmEdit := False;
   PanelAgrega.Visible := False;
   PanelAgrega.Align   := alClient;
   PanelKit.Visible    := True;
   PanelKit.Align      := alClient;
   edDateIni.BorderColor := $00EEE8E8;
   edDateFin.BorderColor := $00EEE8E8;
   SouKits.DataSet := nil;
   TabKits.Open;
   TabKits.Append;
   SouKits.DataSet := TabKits;
   AtuEdkit;
   TabProdIte.Open;
   TabProdAgr.Open;
   AjustGrid(DBGrid1);
   AjustGrid(DBGrid2);
   ComboTipo.ItemIndex := 0;
   RadioKit.ReadOnly   := False;
   RadioAgr.ReadOnly   := False;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmKitProduto.SouKitsDataChange(Sender: TObject; Field: TField);
begin
   if not Assigned(SouKits.DataSet) then Exit;
   with SouKits.DataSet.FieldByName('IDKit') do
   begin
      if not IsNull and (AsInteger > 0) then
         LMDDBLabeledEdit2.Visible := True
    else LMDDBLabeledEdit2.Visible := False;
   end;
end;

procedure TFrmKitProduto.edVlrTotKitExit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabKitsIDKit.Value <= 0 then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      if PanelKit.Visible then
      begin
         QueAuxi.SQL.Text := 'SELECT SUM(VlrVenIte * QtdKit) AS SomaOriginal FROM arqkitprodite WHERE IDKit = '+TabKitsIDKit.AsString;
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            if TabKitsVlrTotKit.Value <> QueAuxi.FieldByName('SomaOriginal').AsFloat then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text :=
               'SET @IDKit := '+TabKitsIDKit.AsString+'; SET @VlrAlvoKit := '+FormatDouble(TabKitsVlrTotKit.AsFloat,11,2)+'; SET @Modo := "FULL"; '+
               'DROP TEMPORARY TABLE IF EXISTS tmp_ponderacao; '+
               'CREATE TEMPORARY TABLE tmp_ponderacao (IDKit BIGINT, IDProd BIGINT,Peso DECIMAL(18,6), PRIMARY KEY (IDKit,IDProd)) ENGINE=MEMORY; '+
               'INSERT INTO tmp_ponderacao (IDKit, IDProd, Peso) '+
               'SELECT a.IDKit, a.IDProd, '+
               'CASE WHEN @Modo = "FULL" THEN (a.PrecoVen * a.QtdKit) ELSE a.VlrVenIte END AS Peso '+
               'FROM arqkitprodite a WHERE a.IDKit = @IDKit; '+
               'SELECT SUM(Peso) INTO @Base FROM tmp_ponderacao WHERE IDKit = @IDKit; '+
               'UPDATE arqkitprodite t JOIN tmp_ponderacao p ON p.IDKit = t.IDKit AND p.IDProd = t.IDProd '+
               'SET t.VlrVenIte = ROUND( (p.Peso / NULLIF(@Base,0)) * @VlrAlvoKit, 2) WHERE t.IDKit = @IDKit; '+
               'SELECT ROUND(SUM(VlrVenIte), 2) INTO @Distrib FROM arqkitprodite WHERE IDKit = @IDKit; '+
               'SET @Delta := ROUND(@VlrAlvoKit - @Distrib, 2); '+
               'UPDATE arqkitprodite t JOIN (SELECT IDKit, IDProd FROM tmp_ponderacao WHERE IDKit = @IDKit '+
               'ORDER BY Peso DESC, IDProd LIMIT 1) pick ON pick.IDKit = t.IDKit AND pick.IDProd = t.IDProd '+
               'SET t.VlrVenIte = ROUND(t.VlrVenIte + @Delta, 2) WHERE @Delta <> 0 AND t.IDKit = @IDKit; '+
               'UPDATE arqkitprodite SET PerDesIte = ROUND( (1 - (VlrVenIte / NULLIF(PrecoVen * QtdKit, 0))) * 100, 2) WHERE IDKit = @IDKit; '+
               'DROP TEMPORARY TABLE IF EXISTS tmp_ponderacao';
               QueAuxi.ExecSQL;
               TabProdIte.Close;
               TabProdIte.Open;
               AjustGrid(DBGrid1);
            end; //if
         end; //if
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmKitProduto.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmKitProduto.AjustGrid(recDBGrid:TDBGrid);
begin
   TStringGrid(recDBGrid).DefaultRowHeight := BaseRowHeight -5;
   recDBGrid.Width := DBGrid1.Width - 5;
   recDBGrid.Width := DBGrid1.Width + 5;
end;

procedure TFrmKitProduto.TabKitsAfterInsert(DataSet: TDataSet);
begin
   TabKitsTipoKit.Value  := 'K';
   TabKitsIndAtivo.Value := '1';
   TabKitsDataIni.Value  := DataServer;
   TabKitsDataFin.Value  := IncDay(DataServer,30);
   AtiDesAgr(False);
end;

procedure TFrmKitProduto.TabKitsAfterOpen(DataSet: TDataSet);
begin
   RadioKit.ReadOnly := not TabProdIte.IsEmpty;
   RadioAgr.ReadOnly := not TabProdIte.IsEmpty;
end;

procedure TFrmKitProduto.TabProdAgrCalcFields(DataSet: TDataSet);
begin
   TabProdAgrTipoIteCalc.Value := iif(TabProdAgrTipoIte.Value = 'A','AGREGADO','PRINCIPAL');
end;

procedure TFrmKitProduto.edCodproAEnter(Sender: TObject);
begin
   if TabKitsIDKit.Value <= 0 then
   begin
      MostraMsg('Aviso','Favor salvar primeiro!', mtWarning, [mbOK]);
      LMDDBLabeledEdit1.SetFocus;
      Exit;
   end;
end;

procedure TFrmKitProduto.edCodproAExit(Sender: TObject);
var
   auxProd:String;
   QueAuxi:TRESTDWClientSQL;
begin
   edDesproA.Clear;
   edDesproA.Tag := 0;
   auxProd := edCodproA.Text.Trim;
   if auxProd = '' then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT IDProd,Despro,PrecoVen,QtdFrac FROM arqproduto WHERE '+iif(Length(auxProd) < 9, 'IDProd'+' = '+auxProd,'CodEANPri'+' = '+Aspas(auxProd));
         Open;
         if IsEmpty then
         begin
            MostraMsg('Aviso','Produto não encontrado!', mtWarning, [mbOK]);
            edCodproA.SetFocus;
            Exit;
         end else
         begin
            if FieldByName('PrecoVen').AsFloat <= 0.00 then
            begin
               MostraMsg('Aviso', 'Este Produto não tem valor de vendas!', mtWarning, [mbOk]);
               edCodproA.SetFocus;
               Exit
            end;
            edDesproA.Tag  := FieldByName('IDProd').AsInteger;
            edDesproA.Text := FieldByName('Despro').AsString;
            _PrecoVen      := Roundx(FieldByName('PrecoVen').AsFloat / iif(FieldByName('QtdFrac').AsFloat > 0, FieldByName('QtdFrac').AsFloat,1) ,2);
            edPreVenA.AsCurrency := _PrecoVen;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmKitProduto.edCodproEnter(Sender: TObject);
begin
   if TabKitsIDKit.Value <= 0 then
   begin
      MostraMsg('Aviso','Favor salvar primeiro!', mtWarning, [mbOK]);
      LMDDBLabeledEdit1.SetFocus;
      Exit;
   end;
end;

procedure TFrmKitProduto.edCodproExit(Sender: TObject);
var
   auxProd:String;
   QueAuxi:TRESTDWClientSQL;
begin
   edDespro.Clear;
   edDespro.Tag := 0;
   auxProd := edCodpro.Text.Trim;
   if auxProd = '' then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT IDProd,Despro,PrecoVen,QtdFrac FROM arqproduto WHERE '+iif(Length(auxProd) < 9, 'IDProd'+' = '+auxProd,'CodEANPri'+' = '+Aspas(auxProd));
         Open;
         if IsEmpty then
         begin
            MostraMsg('Aviso','Produto não encontrado!', mtWarning, [mbOK]);
            edCodpro.SetFocus;
            Exit;
         end else
         begin
            if FieldByName('PrecoVen').AsFloat <= 0.00 then
            begin
               MostraMsg('Aviso', 'Este Produto não tem valor de vendas!', mtWarning, [mbOk]);
               edDespro.SetFocus;
               Exit
            end;
            edDespro.Tag  := FieldByName('IDProd').AsInteger;
            edDespro.Text := FieldByName('Despro').AsString;
            edPreVen.AsCurrency := Roundx(FieldByName('PrecoVen').AsFloat / iif(FieldByName('QtdFrac').AsFloat > 0, FieldByName('QtdFrac').AsFloat,1) ,2);
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmKitProduto.edCodproKeyPress(Sender: TObject; var Key: Char);
begin
   if ExisteStr(Key) then Key := #0;
end;

procedure TFrmKitProduto.edDesproACustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto',TLMDEdit(edDesproA),'IDProd','Despro','', 0, True);
   if edDesproA.Tag <= 0 then
   begin
      edCodproA.Text := '';
      _PrecoVen := 0.00;
      edPreVenA.AsCurrency := 0.00;
   end else
   begin
      edCodproA.Text := edDesproA.Tag.ToString;
      edPreVenA.AsCurrency := _PrecoVen;
   end;
end;

procedure TFrmKitProduto.edDesproAKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqproduto',TLMDEdit(edDesproA),'IDProd','Despro','', Key);
   if _PrecoVen <= 0.00 then
   begin
      edDesproA.Tag  := 0;
      edDesproA.Text := '';
      MostraMsg('Aviso', 'Este Produto não tem valor de vendas!', mtWarning, [mbOk]);
      edDesproA.SetFocus;
   end;
   if edDesproA.Tag <= 0 then
   begin
      edCodproA.Text := '';
      _PrecoVen := 0.00;
      edPreVenA.AsCurrency := 0.00;
   end else
   begin
      edCodproA.Text := edDesproA.Tag.ToString;
      edPreVenA.AsCurrency := _PrecoVen;
   end;
end;

procedure TFrmKitProduto.edDesproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto',TLMDEdit(edDespro),'IDProd','Despro','', 0, True);
   if edDespro.Tag <= 0 then
   begin
      edCodpro.Text := '';
      _PrecoVen := 0.00;
      edPreVen.AsCurrency := 0.00;
   end else
   begin
      edCodpro.Text := edDespro.Tag.ToString;
      edPreVen.AsCurrency := _PrecoVen;
   end;
end;

procedure TFrmKitProduto.edDesproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      btBuscas('arqproduto',TLMDEdit(edDespro),'IDProd','Despro','', Key);
      if _PrecoVen <= 0.00 then
      begin
         edDespro.Tag := 0;
         MostraMsg('Aviso', 'Este Produto não tem valor de vendas!', mtWarning, [mbOk]);
         edDespro.SetFocus;
      end;
      if edDespro.Tag <= 0 then
      begin
         edCodpro.Text := '';
         _PrecoVen := 0.00;
         edPreVen.AsCurrency := 0.00;
      end else
      begin
         edCodpro.Text := edDespro.Tag.ToString;
         edPreVen.AsCurrency := _PrecoVen;
      end;
   end; //if
end;

procedure TFrmKitProduto.edQuantAExit(Sender: TObject);
var
   auxPreVenTot:Double;
begin
   if (edDesproA.Tag > 0) and (edQuantA.AsCurrency > 0.00) then
   begin
      auxPreVenTot := edQuantA.AsCurrency * edPreVenA.AsCurrency;
      edValorA.AsCurrency := Roundx(auxPreVenTot - (auxPreVenTot * (edDescA.AsCurrency/100)), 2);
   end
   else edValorA.AsCurrency := 0.00;
end;

procedure TFrmKitProduto.edQuantExit(Sender: TObject);
var
   auxPreVenTot:Double;
begin
   if (edDespro.Tag > 0) and (edQuant.AsCurrency > 0.00) then
   begin
      auxPreVenTot := edQuant.AsCurrency * edPreVen.AsCurrency;
      edValor.AsCurrency := Roundx(auxPreVenTot - (auxPreVenTot * (edDesc.AsCurrency/100)), 2);
   end
   else edValor.AsCurrency := 0.00;
end;

procedure TFrmKitProduto.edValorExit(Sender: TObject);
var
   auxPreVenTot:Double;
begin
   if edValor.AsCurrency > 0.00 then
   begin
      auxPreVenTot := edQuant.AsCurrency * edPreVen.AsCurrency;
      if auxPreVenTot > 0 then
         edDesc.AsCurrency := (1 - (edValor.AsCurrency / auxPreVenTot)) * 100;
      btSalvaPro1.Click;
   end; //if
end;

procedure TFrmKitProduto.edValorAExit(Sender: TObject);
var
   auxPreVenTot:Double;
begin
   if (edDesproA.Tag > 0) and (edValorA.AsCurrency > 0.00) then
   begin
      auxPreVenTot := edQuantA.AsCurrency * edPreVenA.AsCurrency;
      if auxPreVenTot > 0 then
         edDescA.AsCurrency := (1 - (edValorA.AsCurrency / auxPreVenTot)) * 100;
      btSalvaPro2.Click;
   end; //if
end;

procedure TFrmKitProduto.RadioAgrClick(Sender: TObject);
begin
   AtiDesAgr(RadioAgr.Checked);
end;

procedure TFrmKitProduto.RadioKitClick(Sender: TObject);
begin
   AtiDesAgr(not RadioKit.Checked);
end;

procedure TFrmKitProduto.RadioKitEnter(Sender: TObject);
begin
   if not (TabKits.State in dsEditModes) then TabKits.Edit;
end;

procedure TFrmKitProduto.AtiDesAgr(recAtiva:Boolean);
begin
   PanelAgrega.Visible := recAtiva;
   PanelTot.Visible := not recAtiva;
   PanelKit.Visible := not recAtiva;
end;

procedure TFrmKitProduto.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmKitProduto.Salvar:Boolean;
var
   auxDiaSema:String;
   retID,I,Erro:Integer;
begin
   Result := True;
   PanelTop.SetFocus;
   if not (TabKits.State in dsEditModes) then Exit;
   Erro := 0;
   if Length(TabKitsDeskit.AsString.Trim) < 5 then Erro := 1 else
   if TabKitsDataIni.AsDateTime < 10 then Erro := 2 else
   if TabKitsDataFin.AsDateTime < 10 then Erro := 3 else
   if TabKitsDataIni.AsDateTime > TabKitsDataFin.AsDateTime then Erro := 4;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso', 'Favor preencher a descrição corretamente!', mtWarning, [mbOk]);
         LMDDBLabeledEdit1.SetFocus;
      end else
      if Erro = 2 then
      begin
         MostraMsg('Aviso', 'A data inical deve ser preenchida!', mtWarning, [mbOk]);
         edDateIni.SetFocus;
      end else
      if Erro = 3 then
      begin
         MostraMsg('Aviso', 'A data final deve ser preenchida!', mtWarning, [mbOk]);
         edDateFin.SetFocus;
      end else
      if Erro = 4 then
      begin
         MostraMsg('Erro', 'Esta data/hora inicial maior que a final!', mtError, [mbOk]);
         edDateIni.SetFocus;
      end; //if
      Result := False;
      Exit;
   end; //if

   if not (TabKits.State in dsEditModes) then TabKits.Edit;
   TabKitsTipoKit.Value := iif(RadioKit.Checked,'K','A');
   auxDiaSema := '';
   for I := 1 to 7 do
   begin
      if TLMDCheckBox(Self.FindComponent('CheckDia'+I.ToString)).Checked then
         auxDiaSema := auxDiaSema + iif(auxDiaSema.Trim = '','',',')+I.ToString;
   end; //for
   TabKitsDiaSema.Value := auxDiaSema;
   try
      retID := MyApplayUpdates(TabKits, 'IDKit', 'IDKit = '+TabKitsIDKit.AsString, TabKits.State);
      if TabKitsIDKit.Value >= 0 then
           retID := TabKitsIDKit.Value
      else if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
      TabKits.Cancel;
      TabKits.Close;
      TabKits.SQL.Text := 'SELECT * FROM arqkitprod WHERE IDKit = '+retID.ToString;
      TabKits.Open;
      TabProdIte.Refresh;
      TabProdAgr.Refresh;
      AjustGrid(DBGrid1);
      AjustGrid(DBGrid2);
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar KIT Produtos -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
         Result := False;
         Exit;
      end;
   end; //try
   edDateIni.Enabled := False;
   edDateFin.Enabled := False;
   RadioKit.ReadOnly := True;
   RadioAgr.ReadOnly := True;
end;

procedure TFrmKitProduto.btNovoClick(Sender: TObject);
begin
   TabKits.Close;
   TabKits.SQL.Text := 'SELECT * FROM arqkitprod LIMIT 1';
   TabKits.Open;
   TabKits.Append;
   AjustGrid(DBGrid1);
   AjustGrid(DBGrid2);
   LimpaCampos;
   RadioKit.ReadOnly := False;
   RadioAgr.ReadOnly := False;
   edDateIni.Enabled := True;
   edDateFin.Enabled := True;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmKitProduto.SomaKit;
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         if not (TabKits.State in dsEditModes) then TabKits.Edit;
         if RadioKit.Checked then
         begin
            SQL.Text := 'SELECT SUM(VlrVenIte) As TotalKIT FROM arqkitprodite WHERE IDKit = '+TabKitsIDKit.AsString;
            Open;
            if not IsEmpty then
                 TabKitsVlrTotKit.Value := FieldByName('TotalKIT').AsFloat
            else TabKitsVlrTotKit.Value := 0.00;
         end else
         begin
            SQL.Text := 'SELECT SUM(VlrVenagr) As TotalAGR FROM arqkitprodagr WHERE IDKit = '+TabKitsIDKit.AsString;
            Open;
            if not IsEmpty then
                 TabKitsVlrTotKit.Value := FieldByName('TotalAGR').AsFloat
            else TabKitsVlrTotKit.Value := 0.00;
         end; //if
      end; //with
      TabKits.Post;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   RadioKit.ReadOnly := not TabProdIte.IsEmpty;
   RadioAgr.ReadOnly := not TabProdIte.IsEmpty;
end;

procedure TFrmKitProduto.btBuscaClick(Sender: TObject);
var
   I:Integer;
   PanelPos:TPoint;
begin
   if FrmKitBus = nil then FrmKitBus := TFrmKitBus.Create(Self);
   try
      Self.AlphaBlendValue := 195;
      PanelPos := PanelCadastro.ClientToScreen(Point(0, 0));
      FrmKitBus.Top  := PanelPos.Y + 39;
      FrmKitBus.Left := PanelPos.X + 75;
      FrmKitBus.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      if FrmKitBus.retIDKit > 0 then
      begin
         try
            TabKits.Cancel;
            TabKits.Close;
            TabKits.SQL.Text := 'SELECT * FROM arqkitprod WHERE IDKit = '+FrmKitBus.retIDKit.ToString;
            TabKits.Open;
            for I := 1 to 7 do
               TLMDCheckBox(Self.FindComponent('CheckDia'+I.ToString)).Checked := AnsiPos(I.ToString,TabKitsDiaSema.Value) > 0;
            RadioKit.Checked := TabKitsTipoKit.Value = 'K';
            RadioAgr.Checked := TabKitsTipoKit.Value = 'A';
            AjustGrid(DBGrid1);
            AjustGrid(DBGrid2);
            RadioKit.ReadOnly := True;
            RadioAgr.ReadOnly := True;
            edDateIni.Enabled := False;
            edDateFin.Enabled := False;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar encontrar KIT -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível encontrar Kit!', mtError, [mbOk]);
            end;
         end;
      end; //if
      FreeAndNil(FrmKitBus);
   end;
end;

// --------------- Exclusão do Kit -------------- //
procedure TFrmKitProduto.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabKits.State <> dsInsert) and (TabKitsIDKit.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            //--> SQL.Text := 'SELECT IDPeve FROM arqpeve WHERE IDProm = '+TabPromoIDProm.AsString+' LIMIT 1';
            //--> Open;
            //--> if not IsEmpty then
            //--> begin
            //-->    MostraMsg('Não pode ser excluído','Existem itens vendidos nesse Kit/Agregação.', mtInformation, [mbOk]);
            //-->    Exit;
            //--> end;
            if MostraMsg('Confirmação', 'Deseja realmente excluir este Kit/Agregação?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqkitprodite WHERE IDKit = '+TabKitsIDKit.AsString+';');
                  SQL.Add('DELETE FROM arqkitprodagr WHERE IDKit = '+TabKitsIDKit.AsString+';');
                  SQL.Add('DELETE FROM arqkitprod WHERE IDKit = '   +TabKitsIDKit.AsString+';');
                  ExecSQL;
                  btNovo.Click;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir registro do aquivo: arqkitprod, IDKit = '+TabKitsIDKit.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO arqkitprod, IDKit = '+TabKitsIDKit.AsString+' - '+TabKitsDesKit.AsString);
            end; //if
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end else
   begin
      TabKits.Cancel;
      TabKits.Append;
   end;
end;

procedure TFrmKitProduto.LimpaCampos;
begin
   EmEdit := False;
   edCodpro.Clear;
   edDespro.Clear;
   edDespro.Tag := 0;
   edQuant.AsCurrency  := 1.00;
   edDesc.AsCurrency   := 0.00;
   edPreVen.AsCurrency := 0.00;
   edValor.AsCurrency  := 0.00;
   ComboTipo.ItemIndex := 0;
   edCodpro.Enabled    := True;
   edDespro.Enabled    := True;
   PanelTik.Tag := 0;
   _PrecoVen    := 0.00;
end;

procedure TFrmKitProduto.LimpaCamposA;
begin
   EmEdit := False;
   edCodproA.Clear;
   edDesproA.Clear;
   edDesproA.Tag := 0;

   edQuantA.AsCurrency  := 0.00;
   edDescA.AsCurrency   := 0.00;
   edPreVenA.AsCurrency := 0.00;
   edValorA.AsCurrency  := 0.00;
   edCodproA.Enabled    := True;
   edDesproA.Enabled    := True;
   PanelAgr.Tag := 0;
  _PrecoVen     := 0.00;
   edCodproA.SetFocus;
end;

procedure TFrmKitProduto.btSalvaPro1Click(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   LMDSimplePanel7.SetFocus;
   if edDespro.Tag <= 0 then
   begin
      MostraMsg('Aviso', 'Favor escolher um produto!', mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end else
   if (edQuant.AsCurrency <= 0.00) and RadioKit.Checked then
   begin
      MostraMsg('Aviso', 'Favor entrar com a quantidade!', mtWarning, [mbOk]);
      edQuant.SetFocus;
      Exit;
   end;
   {if (edValor.AsCurrency <= 0.00) and RadioKit.Checked then
   begin
      MostraMsg('Aviso', 'Favor entrar com o valor final do produto!', mtWarning, [mbOk]);
      edValor.SetFocus;
      Exit;
   end;}

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text :=
         'SET @IDKitRef = '+TabKitsIDKit.AsString+'; SET @IDProd = '+edDespro.Tag.ToString+'; SET @QtdKit = '+FormatDouble(edQuant.AsFloat,9,2)+'; '+
         'SELECT DISTINCT k2.IDKit,mref.Deskit FROM arqkitprodite AS k2 JOIN arqkitprod AS m2 ON m2.IDKit = k2.IDKit '+
         'LEFT JOIN arqkitprod AS mref ON mref.IDKit = @IDKitRef WHERE k2.IDKit <> @IDKitRef '+
         'AND EXISTS (SELECT 1 FROM arqkitprodite f WHERE f.IDKit = k2.IDKit AND f.IDProd = @IDProd AND f.QtdKit = @QtdKit) '+
         'AND NOT EXISTS (SELECT 1 FROM arqkitprodite x WHERE x.IDKit = k2.IDKit AND NOT EXISTS ( '+
         'SELECT 1 FROM (SELECT r.IDProd, r.QtdKit FROM arqkitprodite r WHERE r.IDKit = @IDKitRef AND r.IDProd <> @IDProd '+
         'UNION ALL '+
         'SELECT @IDProd AS IDProd, @QtdKit AS QtdKit FROM dual) AS ref_comp '+
         'WHERE ref_comp.IDProd = x.IDProd AND ref_comp.QtdKit = x.QtdKit)) '+
         'AND NOT EXISTS ('+
         'SELECT 1 FROM (SELECT r.IDProd, r.QtdKit FROM arqkitprodite r WHERE r.IDKit = @IDKitRef AND r.IDProd <> @IDProd '+
         'UNION ALL '+
         'SELECT @IDProd AS IDProd, @QtdKit AS QtdKit) AS ref_comp '+
         'WHERE NOT EXISTS ('+
         'SELECT 1 FROM arqkitprodite x WHERE x.IDKit = k2.IDKit AND x.IDProd = ref_comp.IDProd AND x.QtdKit = ref_comp.QtdKit)) '+
         'AND COALESCE(m2.DataIni, "0001-01-01") <= COALESCE(@RefDataFin, mref.DataFin, "2999-12-31") '+
         'AND COALESCE(m2.DataFin, "2999-12-31") >= COALESCE(@RefDataIni, mref.DataIni, "0001-01-01") '+
         'ORDER BY k2.IDKit';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            MostraMsg('Aviso', 'Produto já incluso em no Kit '+QueAuxi.FieldByName('Deskit').AsString.Trim+' em período similar!',mtWarning, [mbOk]);
            Exit;
         end;

         if not EmEdit then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqkitprodite WHERE IDKit = '+TabKitsIDKit.AsString+' AND IDProd = '+edDespro.Tag.ToString;
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
            begin
               Application.ProcessMessages;
               MostraMsg('Aviso', 'Produto já incluso no Kit!',mtWarning, [mbOk]);
               Exit;
            end; //if
         end; //if
      except
         on E:Exception do
         begin
            MostraMsg('Erro', 'Não foi possível salvar o produto no Kit!',mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

   if PanelTik.Tag <= 0 then
   begin
      TabProdIte.Append;
      TabProdIteIDKit.Value  := TabKitsIDKit.Value;
      TabProdIteIDProd.Value := edDespro.Tag;
      TabProdIteDespro.Value := edDespro.Text;
   end
   else TabProdIte.Edit;
   TabProdIteQtdKit.Value    := edQuant.AsCurrency;
   TabProdItePrecoVen.Value  := edPreVen.AsCurrency;
   TabProdItePerDesIte.Value := edDesc.AsCurrency;
   TabProdIteVlrVenIte.Value := edValor.AsCurrency;
   try
      TabProdIte.Post;
      AjustGrid(DBGrid1);
      SomaKit;
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar registro do aquivo: arqkitprodite, IDKit = '+TabKitsIDKit.AsString+' -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível salvar o produto no Kit!',mtError, [mbOk]);
         Exit;
      end;
   end;
   LimpaCampos;
   AjustGrid(DBGrid1);
end;

procedure TFrmKitProduto.btSalvaPro2Click(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   LMDSimplePanel8.SetFocus;
   if edDesproA.Tag <= 0 then
   begin
      MostraMsg('Aviso', 'Favor escolher um produto!', mtWarning, [mbOk]);
      edCodproA.SetFocus;
      Exit;
   end else
   if edQuantA.AsCurrency <= 0.00 then
   begin
      MostraMsg('Aviso', 'Favor entrar com a quantidade!', mtWarning, [mbOk]);
      edQuantA.SetFocus;
      Exit;
   end;
   if edValorA.AsCurrency <= 0.00 then
   begin
      MostraMsg('Aviso', 'Favor entrar com o valor final do produto!', mtWarning, [mbOk]);
      edValorA.SetFocus;
      Exit;
   end;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         if ComboTipo.ItemIndex > 0 then
         begin
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqkitprodagr WHERE IDKit = '+TabKitsIDKit.AsString+' AND TipoIte = "P" LIMIT 1';
            QueAuxi.Open;
            if QueAuxi.IsEmpty then
            begin
               MostraMsg('Aviso', 'É necessário que existam itens PRINCIPAIS inicialmente!',mtWarning, [mbOk]);
               ComboTipo.SetFocus;
               Exit;
            end; //if
         end; //if

         QueAuxi.Close;
         QueAuxi.SQL.Text :=
         'SET @IDKitRef = '+TabKitsIDKit.AsString+'; SET @IDProd = '+edDesproA.Tag.ToString+'; SET @QtdKit = '+FormatDouble(edQuantA.AsFloat,9,2)+'; '+
         'SELECT DISTINCT k2.IDKit,mref.Deskit FROM arqkitprodite AS k2 JOIN arqkitprod AS m2 ON m2.IDKit = k2.IDKit '+
         'LEFT JOIN arqkitprod AS mref ON mref.IDKit = @IDKitRef WHERE k2.IDKit <> @IDKitRef '+
         'AND EXISTS (SELECT 1 FROM arqkitprodite f WHERE f.IDKit = k2.IDKit AND f.IDProd = @IDProd AND f.QtdKit = @QtdKit) '+
         'AND NOT EXISTS (SELECT 1 FROM arqkitprodite x WHERE x.IDKit = k2.IDKit AND NOT EXISTS ( '+
         'SELECT 1 FROM (SELECT r.IDProd, r.QtdKit FROM arqkitprodite r WHERE r.IDKit = @IDKitRef AND r.IDProd <> @IDProd '+
         'UNION ALL '+
         'SELECT @IDProd AS IDProd, @QtdKit AS QtdKit FROM dual) AS ref_comp '+
         'WHERE ref_comp.IDProd = x.IDProd AND ref_comp.QtdKit = x.QtdKit)) '+
         'AND NOT EXISTS ('+
         'SELECT 1 FROM (SELECT r.IDProd, r.QtdKit FROM arqkitprodite r WHERE r.IDKit = @IDKitRef AND r.IDProd <> @IDProd '+
         'UNION ALL '+
         'SELECT @IDProd AS IDProd, @QtdKit AS QtdKit) AS ref_comp '+
         'WHERE NOT EXISTS ('+
         'SELECT 1 FROM arqkitprodite x WHERE x.IDKit = k2.IDKit AND x.IDProd = ref_comp.IDProd AND x.QtdKit = ref_comp.QtdKit)) '+
         'AND COALESCE(m2.DataIni, "0001-01-01") <= COALESCE(@RefDataFin, mref.DataFin, "2999-12-31") '+
         'AND COALESCE(m2.DataFin, "2999-12-31") >= COALESCE(@RefDataIni, mref.DataIni, "0001-01-01") '+
         'ORDER BY k2.IDKit';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            MostraMsg('Aviso', 'Produto já incluso em no Kit/Agregação '+QueAuxi.FieldByName('Deskit').AsString.Trim+' em período similar!',mtWarning, [mbOk]);
            Exit;
         end;

         if not EmEdit then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqkitprodagr WHERE IDKit = '+TabKitsIDKit.AsString+' AND IDProd = '+edDesproA.Tag.ToString;
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
            begin
               Application.ProcessMessages;
               MostraMsg('Aviso', 'Produto já incluso nessa agregação!',mtWarning, [mbOk]);
               Exit;
            end; //if
         end; //if
      except
         on E:Exception do
         begin
            MostraMsg('Erro', 'Não foi possível salvar o produto na agregação!',mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

   if PanelAgr.Tag <= 0 then
   begin
      TabProdAgr.Append;
      TabProdAgrIDKit.Value  := TabKitsIDKit.Value;
      TabProdAgrIDProd.Value := edDesproA.Tag;
      TabProdAgrDespro.Value := edDesproA.Text;
   end
   else TabProdAgr.Edit;
   TabProdAgrQtdAgr.Value    := edQuantA.AsCurrency;
   TabProdAgrPrecoVen.Value  := edPreVenA.AsCurrency;
   TabProdAgrPerDesAgr.Value := edDescA.AsCurrency;
   TabProdAgrVlrVenAgr.Value := edValorA.AsCurrency;
   TabProdAgrTipoIte.Value   := iif(ComboTipo.ItemIndex = 0,'P','A');
   try
      TabProdAgr.Post;
      AjustGrid(DBGrid2);
      SomaKit;
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar registro do aquivo: arqkitprodagr, IDKit = '+TabKitsIDKit.AsString+' -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível salvar o produto na agregação!',mtError, [mbOk]);
         Exit;
      end;
   end;
   LimpaCamposA;
   AjustGrid(DBGrid2);
end;

// ------------- Exclui Produto do Kit ------------- //
procedure TFrmKitProduto.DBGrid1CellClick(Column: TColumn);
begin
   if TabProdIte.IsEmpty then Exit;
   if Column.ID = 5 then
   begin
      if (TabProdIte.RecordCount < 2) and (not TabProdAgr.IsEmpty) then
      begin
         MostraMsg('Erro', 'Não é possível excluir, existem produtos associados nos agregados!',mtError, [mbOk]);
         DBGrid1.SelectedField := TabProdIteVlrVenIte;
         Exit;
      end;
      if MostraMsg('Confirmação','Confirma eliminação do Produto do Kit?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabProdIte.Delete;
            SomaKit;
            AjustGrid(DBGrid1);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqkitprodite -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabProdIteVlrVenIte;
      RadioKit.ReadOnly := not TabProdIte.IsEmpty;
      RadioAgr.ReadOnly := not TabProdIte.IsEmpty;
   end; //if
end;

procedure TFrmKitProduto.DBGrid1DblClick(Sender: TObject);
begin
   if TabProdIte.IsEmpty then Exit;
   PanelTik.Tag  := TabProdIteIDKit.Value;
   edCodpro.Text := TabProdIteIDProd.AsString;
   edDespro.Text := TabProdIteDespro.AsString;
   edDespro.Tag  := TabProdIteIDProd.AsInteger;
   edQuant.AsCurrency  := TabProdIteQtdKit.Value;
   edDesc.AsCurrency   := TabProdItePerDesIte.Value;
   edPreVen.AsCurrency := TabProdItePrecoVen.AsFloat;
   edValor.AsCurrency  := TabProdIteVlrVenIte.Value;
   edCodpro.Enabled    := False;
   edDespro.Enabled    := False;
   EmEdit := True;
   edQuant.SetFocus;
end;

procedure TFrmKitProduto.AtuEdkit;
var
   I:integer;
begin
   for I := 1 to 7 do
      TLMDCheckBox(Self.FindComponent('CheckDia'+I.ToString)).Checked := AnsiPos(I.ToString,TabKitsDiaSema.Value) > 0;
   RadioKit.Checked := TabKitsTipoKit.Value = 'K';
   RadioAgr.Checked := TabKitsTipoKit.Value = 'A';
end;

procedure TFrmKitProduto.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00D7E4FF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
   end;
   (Sender as TDBGrid).Canvas.FillRect(Rect);
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 5 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3, Rect.Top+3, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmKitProduto.DBGrid2CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProdAgr.IsEmpty then Exit;
   if Column.ID = 6 then
   begin
      if MostraMsg('Confirmação','Confirma eliminação do Produto Agregado',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            try
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqkitprodagr WHERE IDKit = '+TabKitsIDKit.AsString+' AND TipoIte = "P" LIMIT 3';
               QueAuxi.Open;
               if QueAuxi.RecordCount < 2 then
               begin
                  MostraMsg('Aviso', 'Não é permitido excluir todos itens PRINCIPAIS!',mtWarning, [mbOk]);
                  edCodproA.SetFocus;
                  DBGrid2.SelectedField := TabProdAgrVlrVenAgr;
                  Exit;
               end; //if
            except
               on E:Exception do
               begin
                  MostraMsg('Erro', 'Não foi possível salvar o produto na agregação!',mtError, [mbOk]);
                  Exit;
               end;
            end;
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;

         try
            TabProdAgr.Delete;
            AjustGrid(DBGrid2);
            SomaKit;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqkitprodagr -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
            end;
         end; //try
      end; //if
      DBGrid2.SelectedField := TabProdAgrVlrVenAgr;
   end; //if
end;

procedure TFrmKitProduto.DBGrid2DblClick(Sender: TObject);
begin
   if TabProdAgr.IsEmpty then Exit;
   PanelAgr.Tag   := TabProdAgrIDKit.Value;
   edCodproA.Text := TabProdAgrIDProd.AsString;
   edDesproA.Text := TabProdAgrDespro.AsString;
   edDesproA.Tag  := TabProdAgrIDProd.AsInteger;
   ComboTipo.ItemIndex  := iif(TabProdAgrTipoIte.Value = 'P',0,1);
   edPreVenA.AsCurrency := TabProdAgrPrecoVen.Value;
   edQuantA.AsCurrency  := TabProdAgrQtdAgr.Value;
   edDescA.AsCurrency   := TabProdAgrPerDesAgr.Value;
   edValorA.AsCurrency  := TabProdAgrVlrVenAgr.Value;
   edCodproA.Enabled    := False;
   edDesproA.Enabled    := False;
   EmEdit := True;
   edQuantA.SetFocus;
end;

procedure TFrmKitProduto.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   i,prevIndex:Integer;
begin
   if (Key = VK_TAB) and (ssShift in Shift) then
   begin
      prevIndex := -1;
      for i := 0 to Self.ControlCount - 1 do
      begin
         if Self.Controls[i] = ActiveControl then
         begin
            if prevIndex >= 0 then
            begin
               TWinControl(Self.Controls[prevIndex]).SetFocus;
               Break;
            end;
         end
         else if TWinControl(Self.Controls[i]).CanFocus then prevIndex := i;
      end; //for
      Key := 0;
   end; //if
end;

procedure TFrmKitProduto.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmKitProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabKits.State in dsEditModes then TabKits.Cancel;
   TabProdIte.Close;
   TabProdAgr.Close;
   TabKits.Close;
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;

end.

(* --------------- SQL MODELO VENCEDOR ----------------- *
SET @IDKitRef = 2; SET @IDProd = 800; SET @QtdKit = 1;

SELECT DISTINCT k2.IDKit FROM arqkitprodite AS k2 JOIN arqkitprod AS m2 ON m2.IDKit = k2.IDKit
LEFT JOIN arqkitprod AS mref ON mref.IDKit = @IDKitRef WHERE k2.IDKit <> @IDKitRef
AND EXISTS (SELECT 1 FROM arqkitprodite f WHERE f.IDKit = k2.IDKit AND f.IDProd = @IDProd AND f.QtdKit = @QtdKit)
AND NOT EXISTS (SELECT 1 FROM arqkitprodite x WHERE x.IDKit = k2.IDKit AND NOT EXISTS (
SELECT 1 FROM (SELECT r.IDProd, r.QtdKit FROM arqkitprodite r WHERE r.IDKit = @IDKitRef AND r.IDProd <> @IDProd
UNION ALL
SELECT @IDProd AS IDProd, @QtdKit AS QtdKit FROM dual) AS ref_comp
WHERE ref_comp.IDProd = x.IDProd AND ref_comp.QtdKit = x.QtdKit))
AND NOT EXISTS (
SELECT 1 FROM (SELECT r.IDProd, r.QtdKit FROM arqkitprodite r WHERE r.IDKit = @IDKitRef AND r.IDProd <> @IDProd
UNION ALL
SELECT @IDProd AS IDProd, @QtdKit AS QtdKit) AS ref_comp
WHERE NOT EXISTS (
SELECT 1 FROM arqkitprodite x WHERE x.IDKit = k2.IDKit AND x.IDProd = ref_comp.IDProd AND x.QtdKit = ref_comp.QtdKit))
AND COALESCE(m2.DataIni, '0001-01-01') <= COALESCE(@RefDataFin, mref.DataFin, '2999-12-31')
AND COALESCE(m2.DataFin, '2999-12-31') >= COALESCE(@RefDataIni, mref.DataIni, '0001-01-01')
ORDER BY k2.IDKit;

-----------------------------------------------------------------------------------------------

Exemplos:

Caso eu informe:
SET @IDKitRef = 2; SET @IDProd = 800; SET @QtdKit = 1;
Deve retornar o IDKit 1, pois existe uma mesma combinação para IDPROD e QTDKIT e não tem mais nenhum IDPROD adicional para IDKIT = 1

Caso eu informe:
SET @IDKitRef = 2; SET @IDProd = 3035; SET @QtdKit = 1;
Não retorne nada, pois mesmo já havendo um IDPROD com a mesma QtdKIT no agrupamento com IDKIT = 12, existem mais IDPROD difrentes relacionados com o mesmo IDKIT.

Caso eu informe:
SET @IDKitRef = 12; SET @IDProd = 800; SET @QtdKit = 1;
Não retorne nada, pois mesmo já havendo um IDPROD com a mesma QtdKIT no agrupamento com IDKIT = 1, existem vários outros IDPROD realcionados com o mesmo IDKIT

Caso eu informe:
SET @IDKitRef = 13; SET @IDProd = 4095; SET @QtdKit = 3;
Não retorne nada, pois mesmo já havendo um IDPROD com a mesma QtdKIT no agrupamento com IDKIT = 12, e já exista um IDPROD = 4095 em IDKIT = 12 a quantidade do pararametro é diferente, ou seja = 3

Caso eu informe:
SET @IDKitRef = 14; SET @IDProd = 4095; SET @QtdKit = 2;
Deve retorne o valor de IDKit = 12, pois nesse haverá uma igualdade de KITS com os MESMOS IDPROD, QTDKIT para IDKIT = 14 comparando com o agrupamento de IDKIT = 12

*)


