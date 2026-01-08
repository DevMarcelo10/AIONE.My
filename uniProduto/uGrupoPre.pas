unit uGrupoPre;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtCombo,
   LMDLabel, LMDListComboBox, LMDDBListComboBox, Vcl.StdCtrls, Vcl.Mask,
   RxToolEdit, LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel,
   LMDCustomListComboBox, LMDCustomLabel, LMDCustomBevelPanel, Data.DB,
   Vcl.ExtCtrls, AdvGlowButton, MarcLib, AdvEdit, LMDButtonControl, LMDEdit,
   LMDCustomCheckBox, LMDDBCheckBox, Vcl.DBCtrls, FireDAC.Stan.Intf, Vcl.DBGrids,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uRESTDWBasicTypes, uRESTDWBasicDB, LMDCustomParentPanel, LMDCustomGroupBox,
   LMDCustomButtonGroup, LMDCustomRadioGroup, LMDDBRadioGroup, Vcl.Grids;

type
   TFrmGrupoPre = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit0: TLMDDBLabeledEdit;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    TabProd: TRESTDWClientSQL;
    SouProd: TDataSource;
    PanelBckBut: TLMDSimplePanel;
    edBusca: TLMDLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    edCodpro: TLMDEdit;
    edNompro: TLMDLabeledEdit;
    LMDLabel6: TLMDLabel;
    btIncProd: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    btAssProd: TAdvGlowButton;
    btDelMarc: TAdvGlowButton;
    btEtiq: TAdvGlowButton;
    TabGrupoPre: TRESTDWClientSQL;
    TabGrupoPreIDGruPre: TSmallintField;
    TabGrupoPreDesGruPre: TWideStringField;
    SouGrupoPre: TDataSource;
    TabProdIDProd: TIntegerField;
    TabProdDespro: TWideStringField;
    TabProdCustoMed: TFloatField;
    TabProdPrecoVen: TFloatField;
    TabProdPrecoFab: TFloatField;
    TabProdIndSel: TWideStringField;
    TabProdQtdest: TFloatField;
    TabProdPrePromo: TFloatField;
    TabProdPerDesIA: TFloatField;
    TabProdPerDesMan: TFloatField;
    TabProdMarkup: TFloatField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit0DataChange(Sender: TObject);
    procedure TabProdAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure LMDDBLabeledEdit11Exit(Sender: TObject);
    procedure edCodproExit(Sender: TObject);
    procedure edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btIncProdClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btAssProdClick(Sender: TObject);
    procedure btDelMarcClick(Sender: TObject);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
    auxSQL,auxSQLPro:String;
    procedure AjustGrid;
    function Salvar:Boolean;
    function BuscaProd(recAuxProd:String):Boolean;
    function IncluiProd(recCampo,recChave:String):Boolean;
  public
    { Public declarations }
  end;

var
   FrmGrupoPre: TFrmGrupoPre;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaLoc, uAssProLoc;

procedure TFrmGrupoPre.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmGrupoPre.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmGrupoPre.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 11;
   auxSQLPro :=
   'SELECT ap.IDProd,ap.Despro,ap.CustoMed,ap.PrecoVen,ap.PrecoFab,ap.IndSel,ap.Markup AS Margem,'+
   'SUM(LOT.Qtdest) AS Qtdest,arp.PrePromo,arp.PerDesIA,arp.PerDesMan, '+
   'CASE WHEN ap.CustoMed > 0 THEN ((arp.PrePromo - ap.CustoMed) / ap.CustoMed) * 100 ELSE NULL END AS CalculatedMarkup,'+
   'CASE'+
   '    WHEN arp.PrePromo IS NOT NULL AND arp.PrePromo > 0 THEN ((arp.PrePromo - ap.CustoMed) / ap.CustoMed) * 100 '+
   '    ELSE ap.Markup '+
   'END AS Markup '+
   'FROM arqproduto ap '+
   'LEFT JOIN arqprodutolot LOT ON ap.IDProd = LOT.IDProd '+
   'LEFT JOIN '+
   '(SELECT arp.IDProd,arp.PrePromo,arp.PerDesIA,arp.PerDesMan,arp.IDProm,MAX(arp.IDProm) AS MostRecentPromo '+
   'FROM arqpromopro arp  '+
   'INNER JOIN arqpromocao apc ON arp.IDProm = apc.IDProm '+
   'WHERE apc.IndAtivo = "1" AND CURDATE() BETWEEN apc.DataON AND apc.DataOFF GROUP BY arp.IDProd) AS arp ON ap.IDProd = arp.IDProd ';
   auxSQL := 'SELECT * FROM arqprodutogpr ';
   SouGrupoPre.DataSet := nil;
   TabGrupoPre.SQL.Text := auxSQL+'LIMIT 1';
   TabGrupoPre.Open;
   SouGrupoPre.DataSet := TabGrupoPre;
   TabGrupoPre.Append;
   AjustGrid;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmGrupoPre.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmGrupoPre.LMDDBLabeledEdit0DataChange(Sender: TObject);
begin
   if TabGrupoPreIDGruPre.AsInteger > 0 then
        LMDDBLabeledEdit0.DataField := 'IDGruPre'
   else LMDDBLabeledEdit0.DataField := '';
end;

procedure TFrmGrupoPre.btNovoClick(Sender: TObject);
begin
   if TabGrupoPre.State in dsEditModes then TabGrupoPre.Cancel;
   TabGrupoPre.Append;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmGrupoPre.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmGrupoPre.Salvar:Boolean;
var
   retID:Integer;
   tamConta:Boolean;
   FocusObject:TWinControl;
   QueAuxi:TRESTDWClientSQL;
   DBEditErro:TLMDDBLabeledEdit;
begin
   Result := True;
   FocusObject := Screen.ActiveControl;
   PanelTop.SetFocus;
   FocusObject.SetFocus;

   if TabGrupoPreDesGruPre.AsString.Trim = '' then Exit;
   if TabGrupoPre.State in dsEditModes then
   begin
      Result := False;

      if TabGrupoPreDesGruPre.AsString.Trim = '' then DBEditErro := LMDDBLabeledEdit2;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if

      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      TabGrupoPre.DisableControls;
      try
         try
            retID := MyApplayUpdates(TabGrupoPre, 'IDGruPre', 'IDGruPre = '+TabGrupoPreIDGruPre.AsString, TabGrupoPre.State);
            if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
            TabProd.Close;
            TabGrupoPre.Cancel;
            TabGrupoPre.Close;
            TabGrupoPre.SQL.Text := auxSQL+' WHERE IDGruPre = '+retID.ToString;
            TabGrupoPre.Open;
            TabProd.SQL.Text := auxSQLPro+' WHERE ap.IDGruPre = '+retID.ToString+' GROUP BY ap.IDProd,ap.IDGruPre ORDER BY ap.Despro';
            TabProd.Open;
            AjustGrid;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Locais de Estoque -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
               Exit;
            end;
         end;
      finally
         TabGrupoPre.EnableControls;
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
      PanelCadastro.Visible := False;
      Sleep(10);
      PanelCadastro.Visible := True;
   end; //if
   Result := True;
end;

// -------------- Exclusão da Conta  ------------ //
procedure TFrmGrupoPre.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabGrupoPre.State <> dsInsert) and (TabGrupoPreIDGruPre.AsInteger > 0) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         if not TabProd.IsEmpty then
         begin
            MostraMsg('Aviso','Este Grupo possui produtos relacionados!',mtWarning, [mbOk]);
            Exit;
         end; //if
         try
            if MostraMsg('Confirmação','Confirma exclusão do Grupo de Preços?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'DELETE FROM arqlocesto WHERE IDGruPre = '+TabGrupoPreIDGruPre.AsString;
               QueAuxi.ExecSQL;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQPRODUTOGRP IDGruPre = '+TabGrupoPreIDGruPre.AsString+', DesGruPre = '+TabGrupoPreDesGruPre.AsString);
               TabGrupoPre.DisableControls;
               TabGrupoPre.Close;
               TabGrupoPre.Open;
               TabProd.Close;
               AjustGrid;
               TabGrupoPre.EnableControls;
               btNovo.Click;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir Local de Estoque, IDGruPre = '+TabGrupoPreIDGruPre.AsString+', DesGruPre = '+TabGrupoPreDesGruPre.AsString+' -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end else
   begin
      if TabGrupoPre.State in dsEditModes then TabGrupoPre.Cancel;
      btNovo.Click;
   end;
end;

procedure TFrmGrupoPre.LMDDBLabeledEdit11Exit(Sender: TObject);
begin
//   if (TabGrupoPre.State in dsEditModes) then btSalvar.Click;
end;

procedure TFrmGrupoPre.TabProdAfterOpen(DataSet: TDataSet);
begin
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmGrupoPre.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProd.IsEmpty then Exit;
   if Column.ID = 10 then
   begin
      if MostraMsg('Confirmação','Confirma exclusão deste produto do Grupo?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            try
               with QueAuxi do
               begin
                  DataBase := DM.DWDataBase;
                  SQL.Text := 'UPDATE arqproduto SET IDGruPre = null WHERE IDProd = '+TabProdIDProd.AsString;
                  ExecSQL;
                  TabProd.DisableControls;
                  TabProd.Close;
                  TabProd.Open;
                  TabProd.EnableControls;
                  AjustGrid;
               end;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO,PastaLog,'ERRO: Não foi possível desassociar produto do grupo = uGrupoPre -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível desassociar produto do Grupo.', mtError, [mbOK]);
                  Exit;
               end;
            end; //try
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
      DBGrid1.SelectedField := TabProdDespro;
   end else
   if Column.FieldName = 'IndSel' then
   begin
      if not (TabProd.State in dsEditModes) then TabProd.Edit;
      TabProdIndSel.AsString := iif(TabProdIndSel.AsString = '0','1','0');
      TabProd.Post;
      DBGrid1.SelectedField := TabProdDespro;
   end; //if
end;

procedure TFrmGrupoPre.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 10 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4,Rect.Top+4, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
   if Column.FieldName = 'IndSel' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabProdIndSel.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmGrupoPre.edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
begin
   try
      btBuscas('arqprodutogpr',TLMDEdit(edBusca),'IDGruPre','DesGruPre','',0,True);
   finally
      if edBusca.Tag > 0 then
      begin
         TabProd.Close;
         TabGrupoPre.Close;
         TabGrupoPre.SQL.Text := auxSQL+' WHERE IDGruPre = '+edBusca.Tag.ToString;
         TabGrupoPre.Open;
         TabProd.SQL.Text := auxSQLPro+' WHERE ap.IDGruPre = '+edBusca.Tag.ToString+' GROUP BY ap.IDProd,ap.IDGruPre ORDER BY ap.Despro';
         TabProd.Open;
      end; //if
      FrmBuscaLoc.Free;
   end;
   AjustGrid;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmGrupoPre.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   try
      btBuscas('arqprodutogpr',TLMDEdit(edBusca),'IDGruPre','DesGruPre','',Key,True);
   finally
      if edBusca.Tag > 0 then
      begin
         TabProd.Close;
         TabGrupoPre.Close;
         TabGrupoPre.SQL.Text := auxSQL+' WHERE IDGruPre = '+edBusca.Tag.ToString;
         TabGrupoPre.Open;
         TabProd.SQL.Text := auxSQLPro+' WHERE ap.IDGruPre = '+edBusca.Tag.ToString+' GROUP BY ap.IDProd,ap.IDGruPre ORDER BY ap.Despro';
         TabProd.Open;
      end; //if
      FrmBuscaLoc.Free;
   end;
   AjustGrid;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmGrupoPre.edCodproExit(Sender: TObject);
var
   auxProd:String;
begin
   edNompro.Clear;
   edNompro.Tag := 0;
   auxProd      := Trim(edCodpro.Text);
   if auxProd = '' then Exit;
   BuscaProd(auxProd);
end;

procedure TFrmGrupoPre.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','',0);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      BuscaProd(edCodpro.Text);
   end
   else edCodpro.Text := '';
end;

procedure TFrmGrupoPre.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','',Key);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      BuscaProd(edCodpro.Text);
   end
   else edCodpro.Text := '';
end;

function TFrmGrupoPre.BuscaProd(recAuxProd:String):Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := True;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT IDProd,Despro FROM arqproduto WHERE '+
         iif(recAuxProd.Length < 13, 'IDProd'+' = '+recAuxProd,'CodEANPri'+' = '+Aspas(recAuxProd))+' GROUP BY IDProd';
         QueAuxi.Open;
         if IsEmpty then
         begin
            MostraMsg('Aviso','Produto não encontrado!', mtWarning, [mbOK]);
            edCodpro.SetFocus;
            Result := False;
            Exit;
         end else
         begin
            edNompro.Tag  := FieldByName('IDProd').AsInteger;
            edNompro.Text := FieldByName('Despro').AsString;
            btIncProd.Click;
         end; //if
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmGrupoPre.btIncProdClick(Sender: TObject);
begin
   if TabGrupoPre.State in dsEditModes then
   begin
      MostraMsg('Aviso','Favor salvar Grupo antes!', mtWarning, [mbOK]);
      Exit;
   end;

   if TabGrupoPreIDgRUpRE.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um Grupo de Preços!', mtWarning, [mbOK]);
      edBusca.SetFocus;
      Exit;
   end;
   if edNompro.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um Grupo de Preços!', mtWarning, [mbOK]);
      edCodpro.SetFocus;
      Exit;
   end;
   IncluiProd('IDProd',edNompro.Tag.ToString);
end;

// ---------- Associa Local de Estoque à Produtos ---------- //
function TFrmGrupoPre.IncluiProd(recCampo,recChave:String):Boolean;
var
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      try
         QueAuxi.DataBase := DM.DWDataBase;
         QueAuxi.SQL.Text := 'UPDATE arqproduto SET IDGruPre = '+TabGrupoPreIDGruPre.AsString+' WHERE '+recCampo+' = '+recChave;
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then raise Exception.Create(vErro);
         edCodpro.Clear;
         edNompro.Clear;
         edNompro.Tag := 0;
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível associar Grupo de Preço uGrupoPre -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível asssociar Grupo de Preços!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end;
   finally
      FreeAndNil(QueAuxi);
      TabProd.DisableControls;
      TabProd.Close;
      TabProd.Open;
      TabProd.EnableControls;
      AjustGrid;
      edCodpro.SetFocus;
   end;
end;

// -------- Associação em Massa de Produtos ao Local ---------- //
procedure TFrmGrupoPre.btAssProdClick(Sender: TObject);
var
   retDespro,vErro:String;
   QueAuxi:TRESTDWClientSQL;
   retIDFabr,retIDGrupo,retIDGruSub:Integer;
begin
   if TabGrupoPre.State in dsEditModes then
   begin
      MostraMsg('Aviso','Favor salvar Grupo antes!', mtWarning, [mbOK]);
      Exit;
   end;
   if TabGrupoPreIDGruPre.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um Grupo de Preço!', mtWarning, [mbOK]);
      Exit;
   end;

   FrmAssProLoc := TFrmAssProLoc.Create(Application);
   try
      CentralizarControl(FrmAssProLoc, Self);
      FrmAssProLoc.ShowModal;
   finally
      retIDFabr   := FrmAssProLoc.retIDFabr;
      retIDGrupo  := FrmAssProLoc.retIDGrupo;
      retIDGruSub := FrmAssProLoc.retIDGruSub;
      retDespro   := FrmAssProLoc.retDespro;
      retDespro   := StringReplace(retDespro, '%', '', [rfReplaceAll]);
      FrmAssProLoc.Free;
   end;

   if (retIDFabr <= 0) and (retIDGrupo <= 0) and (retIDGruSub <= 0) and (retDespro = '') then Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'UPDATE arqproduto SET IDGruPre = '+TabGrupoPreIDGruPre.AsString+' WHERE IDProd = IDProd'+
         iif(retIDFabr   > 0, ' AND IDFabr = '  +retIDFabr.ToString,  '')+
         iif(retIDGrupo  > 0, ' AND IDGrupo = ' +retIDGrupo.ToString, '')+
         iif(retIDGruSub > 0, ' AND IDGruSub = '+retIDGruSub.ToString,'')+
         iif(retDespro  <> '',' AND Despro LIKE '+Aspas('%'+retDespro+'%'),'');
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then raise Exception.Create(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível associação em massa do grupo de preços uGrupoPre -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível finalizar asssociação dos Grupos!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end;
   finally
      FreeAndNil(QueAuxi);
      TabProd.DisableControls;
      TabProd.Close;
      TabProd.Open;
      TabProd.EnableControls;
      AjustGrid;
      edCodpro.SetFocus;
   end;
end;

// ---------- Elimina a Associação de Produtos Marcados ---------- //
procedure TFrmGrupoPre.btDelMarcClick(Sender: TObject);
var
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabGrupoPreIDGruPre.AsInteger > 0 then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Clear;
      TabProd.DisableControls;
      try
         if TabProd.IsEmpty then
         begin
            MostraMsg('Aviso','Este Grupo não possui produtos relacionados!',mtWarning, [mbOk]);
            Exit;
         end; //if
         try
            if MostraMsg('Confirmação','Confirma eliminação de todos marcardos?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               Screen.Cursor := crHourGlass;
               TabProd.First;
               while not TabProd.Eof do
               begin
                  if TabProdIndSel.AsString = '1' then
                     QueAuxi.SQL.Add('UPDATE arqproduto SET IDGruPre = NULL WHERE IDProd = '+TabProdIDProd.AsString+';');
                  TabProd.Next;
               end;
               QueAuxi.ExecSQL(vErro);
               if vErro <> '' then raise Exception.Create(vErro);
               TabProd.Close;
               TabProd.Open;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar eliminar todos marcados no Grupo de Preços, IDGruPre = '+TabGrupoPreIDGruPre.AsString+', DesGruPre = '+TabGrupoPreDesGruPre.AsString+' -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível efetivar a eliminação!',mtError, [mbOk]);
               Exit;
            end;
         end;
      finally
         Screen.Cursor := crDefault;
         TabProd.EnableControls;
         AjustGrid;
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;
end;

procedure TFrmGrupoPre.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmGrupoPre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabProd.Active   then TabProd.Close;
   if TabGrupoPre.Active then TabGrupoPre.Close;
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;


end.

