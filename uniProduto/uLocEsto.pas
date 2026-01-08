unit uLocEsto;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDBaseGraphicControl,LMDBaseLabel, Data.DB,
   LMDLabel, Vcl.StdCtrls,  RxToolEdit, LMDBaseControl, AdvEdit, LMDEdit,
   LMDCustomLabel, LMDCustomBevelPanel, Vcl.ExtCtrls, AdvGlowButton, MarcLib,
   Vcl.DBCtrls, FireDAC.Stan.Intf, Vcl.DBGrids, FireDAC.Stan.Option, Vcl.Grids,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uRESTDWBasicTypes, uRESTDWBasicDB;

type
   TFrmLocEsto = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    SouLocEst: TDataSource;
    TabLocEst: TRESTDWClientSQL;
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
    TabLocEstIDLoc: TFDAutoIncField;
    TabLocEstIDFilial: TIntegerField;
    TabLocEstDesloc: TWideStringField;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    TabLocEstNomfil: TWideStringField;
    TabProdIDProd: TFDAutoIncField;
    TabProdDespro: TWideStringField;
    LMDSimplePanel1: TLMDSimplePanel;
    edCodpro: TLMDEdit;
    edNompro: TLMDLabeledEdit;
    LMDLabel6: TLMDLabel;
    btIncProd: TAdvGlowButton;
    TabProdQtdest: TFloatField;
    LMDSimplePanel2: TLMDSimplePanel;
    btAssProd: TAdvGlowButton;
    btDelMarc: TAdvGlowButton;
    btEtiq: TAdvGlowButton;
    TabProdIndSel: TWideStringField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit0DataChange(Sender: TObject);
    procedure LMDDBLabeledEdit1Enter(Sender: TObject);
    procedure TabProdAfterOpen(DataSet: TDataSet);
    procedure edBusPlcCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure LMDDBLabeledEdit11KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit11Exit(Sender: TObject);
    procedure edCodproExit(Sender: TObject);
    procedure edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btIncProdClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btAssProdClick(Sender: TObject);
    procedure btDelMarcClick(Sender: TObject);
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
   FrmLocEsto: TFrmLocEsto;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaLoc, uAssProLoc;

procedure TFrmLocEsto.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmLocEsto.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmLocEsto.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 11;
   auxSQLPro := 'SELECT PRO.IDProd,PRO.Despro,PRO.IndSel,SUM(LOT.Qtdest) AS Qtdest FROM arqproduto PRO LEFT JOIN arqprodutolot LOT ON PRO.IDProd = LOT.IDProd WHERE ';
   auxSQL := 'SELECT LOC.*,FIL.Nomfil FROM arqlocesto LOC LEFT JOIN arqfilial FIL ON LOC.IDFilial = FIL.IDFilial ';
   SouLocEst.DataSet := nil;
   TabLocEst.SQL.Text := auxSQL+'LIMIT 1';
   TabLocEst.Open;
   SouLocEst.DataSet := TabLocEst;
   TabLocEst.Append;
   AjustGrid;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmLocEsto.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmLocEsto.LMDDBLabeledEdit0DataChange(Sender: TObject);
begin
   if TabLocEstIDLoc.AsInteger > 0 then
        LMDDBLabeledEdit0.DataField := 'IDLoc'
   else LMDDBLabeledEdit0.DataField := '';
end;

procedure TFrmLocEsto.btNovoClick(Sender: TObject);
begin
   if TabLocEst.State in dsEditModes then TabLocEst.Cancel;
   TabLocEst.Append;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmLocEsto.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmLocEsto.Salvar:Boolean;
var
   retID:Integer;
   tamConta:Boolean;
   FocusObject:TWinControl;
   QueAuxi:TRESTDWClientSQL;
   DBEditErro:TLMDDBLabeledEdit;
begin
   Result := True;
   if (TabLocEstDesloc.AsString.Trim = '') and (TabLocEstIDFilial.AsInteger <= 0) then Exit;
   if TabLocEst.State in dsEditModes then
   begin
      Result := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;

      if TabLocEstDesloc.AsString.Trim = '' then DBEditErro := LMDDBLabeledEdit2;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if

      if TabLocEstIDFilial.AsInteger <= 0 then
      begin
         MostraMsg('Dado não informado','Favor Favoro informaar Matriz ou Filial',mtWarning, [mbOk]);
         LMDDBLabeledEdit11.SetFocus;
         Exit;
      end;

      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      TabLocEst.DisableControls;
      try
         try
            if TabLocEst.State = dsInsert then
            begin
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqlocesto WHERE Desloc = '+Aspas(TabLocEstDesloc.AsString.Trim)+' AND IDFilial = '+TabLocEstIDFilial.AsString;
               QueAuxi.Open;
               if not QueAuxi.IsEmpty then
               begin
                  MostraMsg('Aviso','Já existe um local com esse nome para essa Filial!', mtWarning, [mbOk]);
                  LMDDBLabeledEdit2.SetFocus;
                  Exit;
               end;
            end; //if
            retID := MyApplayUpdates(TabLocEst, 'IDLoc', 'IDLoc = '+TabLocEstIDLoc.AsString, TabLocEst.State);
            if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
            TabProd.Close;
            TabLocEst.Cancel;
            TabLocEst.Close;
            TabLocEst.SQL.Text := auxSQL+' WHERE IDLoc = '+retID.ToString;
            TabLocEst.Open;
            TabProd.SQL.Text := auxSQLPro+'PRO.IDLoc = '+retID.ToString+' GROUP BY PRO.IDProd,PRO.IDLoc ORDER BY Despro';
            TabProd.Open;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Locais de Estoque -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
               Exit;
            end;
         end;
      finally
         TabLocEst.EnableControls;
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
procedure TFrmLocEsto.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabLocEst.State <> dsInsert) and (TabLocEstIDLoc.AsInteger > 0) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         if not TabProd.IsEmpty then
         begin
            MostraMsg('Aviso','Este local possui produtos relacionados!',mtWarning, [mbOk]);
            Exit;
         end; //if
         try
            if MostraMsg('Confirmação','Confirma exclusão do Local?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'DELETE FROM arqlocesto WHERE IDLoc = '+TabLocEstIDLoc.AsString;
               QueAuxi.ExecSQL;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQLOCESTO IDLoc = '+TabLocEstIDLoc.AsString+', Desloc = '+TabLocEstDesloc.AsString);
               TabLocEst.DisableControls;
               TabLocEst.Close;
               TabLocEst.Open;
               TabProd.Close;
               AjustGrid;
               TabLocEst.EnableControls;
               btNovo.Click;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir Local de Estoque, IDLoc = '+TabLocEstIDLoc.AsString+', Desloc = '+TabLocEstDesloc.AsString+' -> '+E.Message);
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
      if TabLocEst.State in dsEditModes then TabLocEst.Cancel;
      btNovo.Click;
   end;
end;

procedure TFrmLocEsto.LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabLocEst,'arqfilial',TDBEdit(LMDDBLabeledEdit11),'IDFilial','IDFilial','Nomfil','Nomfil','',0);
end;

procedure TFrmLocEsto.LMDDBLabeledEdit11Exit(Sender: TObject);
begin
//   if (TabLocEst.State in dsEditModes) then btSalvar.Click;
end;

procedure TFrmLocEsto.LMDDBLabeledEdit11KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabLocEst,'arqfilial',TDBEdit(LMDDBLabeledEdit11),'IDFilial','IDFilial','Nomfil','Nomfil','',Key);
end;

procedure TFrmLocEsto.LMDDBLabeledEdit1Enter(Sender: TObject);
begin
   if TabLocEst.State <> dsInsert then LMDDBLabeledEdit2.SetFocus;
   LMDDBLabeledEdit11.Enabled := TabLocEst.State = dsInsert;
end;

procedure TFrmLocEsto.TabProdAfterOpen(DataSet: TDataSet);
begin
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmLocEsto.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProd.IsEmpty then Exit;
   if Column.ID = 3 then
   begin
      if MostraMsg('Confirmação','Confirma exclusão deste produto do local?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            try
               with QueAuxi do
               begin
                  DataBase := DM.DWDataBase;
                  SQL.Text := 'UPDATE arqproduto SET IDLoc = null WHERE IDProd = '+TabProdIdProd.AsString;
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
                  SalvaLog(USUARIO,PastaLog,'ERRO: Não foi possível desassociar produto do Local = uLocEsto -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível desassociar produto do Local.', mtError, [mbOK]);
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

procedure TFrmLocEsto.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
   if Column.ID = 3 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4,Rect.Top+4, 0);
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

procedure TFrmLocEsto.edBusPlcCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      edBusca.Tag := 0;
      FrmBuscaLoc := TFrmBuscaLoc.Create(Application);
      with FrmBuscaLoc do
      begin
         lPoint := Self.edBusca.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edBusca.Width;
         edRetorno := TEdit(Self.edBusca);
         edBusca.Text := Self.edBusca.Text;
         ShowModal;
      end; // with
   finally
      if edBusca.Tag > 0 then
      begin
         TabProd.Close;
         TabLocEst.Close;
         TabLocEst.SQL.Text := auxSQL+' WHERE IDLoc = '+edBusca.Tag.ToString;
         TabLocEst.Open;
         TabProd.SQL.Text := auxSQLPro+'PRO.IDLoc = '+edBusca.Tag.ToString+' GROUP BY PRO.IDProd,PRO.IDLoc ORDER BY Despro';
         TabProd.Open;
      end; //if
      FrmBuscaLoc.Free;
   end;
   AjustGrid;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmLocEsto.edCodproExit(Sender: TObject);
var
   auxProd:String;
begin
   edNompro.Clear;
   edNompro.Tag := 0;
   auxProd      := Trim(edCodpro.Text);
   if auxProd = '' then Exit;
   BuscaProd(auxProd);
end;

procedure TFrmLocEsto.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','',0);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      BuscaProd(edCodpro.Text);
   end
   else edCodpro.Text := '';
end;

procedure TFrmLocEsto.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','',Key);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      BuscaProd(edCodpro.Text);
   end
   else edCodpro.Text := '';
end;

function TFrmLocEsto.BuscaProd(recAuxProd:String):Boolean;
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

procedure TFrmLocEsto.btIncProdClick(Sender: TObject);
begin
   if TabLocEst.State in dsEditModes then
   begin
      MostraMsg('Aviso','Favor salvar Local antes!', mtWarning, [mbOK]);
      Exit;
   end;

   if TabLocEstIDLoc.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um Local de Estoque!', mtWarning, [mbOK]);
      edBusca.SetFocus;
      Exit;
   end;
   if edNompro.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um Produto!', mtWarning, [mbOK]);
      edCodpro.SetFocus;
      Exit;
   end;
   IncluiProd('IDProd',edNompro.Tag.ToString);
end;

// ---------- Associa Local de Estoque à Produtos ---------- //
function TFrmLocEsto.IncluiProd(recCampo,recChave:String):Boolean;
var
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      try
         QueAuxi.DataBase := DM.DWDataBase;
         QueAuxi.SQL.Text := 'UPDATE arqproduto SET IDLoc = '+TabLocEstIDLoc.AsString+' WHERE '+recCampo+' = '+recChave;
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then raise Exception.Create(vErro);
         edCodpro.Clear;
         edNompro.Clear;
         edNompro.Tag := 0;
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível associar locais de estoque uLocEsto -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível associar locais!'+#10+E.Message, mtError, [mbOK]);
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
procedure TFrmLocEsto.btAssProdClick(Sender: TObject);
var
   retDespro,vErro:String;
   QueAuxi:TRESTDWClientSQL;
   retIDFabr,retIDGrupo,retIDGruSub:Integer;
begin
   if TabLocEst.State in dsEditModes then
   begin
      MostraMsg('Aviso','Favor salvar Local antes!', mtWarning, [mbOK]);
      Exit;
   end;
   if TabLocEstIDLoc.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um Local de Estoque!', mtWarning, [mbOK]);
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
         QueAuxi.SQL.Text := 'UPDATE arqproduto SET IDLoc = '+TabLocEstIDLoc.AsString+' WHERE IDProd = IDProd'+
         iif(retIDFabr   > 0, ' AND IDFabr = '  +retIDFabr.ToString,  '')+
         iif(retIDGrupo  > 0, ' AND IDGrupo = ' +retIDGrupo.ToString, '')+
         iif(retIDGruSub > 0, ' AND IDGruSub = '+retIDGruSub.ToString,'')+
         iif(retDespro  <> '',' AND Despro LIKE '+Aspas('%'+retDespro+'%'),'');
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then raise Exception.Create(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível associação em massa de locais de estoque uLocEsto -> '+E.Message);
            MostraMsg('Erro', 'Não foi possivel finalizar asssociação dos locais!'+#10+E.Message, mtError, [mbOK]);
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
procedure TFrmLocEsto.btDelMarcClick(Sender: TObject);
var
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabLocEstIDLoc.AsInteger > 0 then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Clear;
      TabProd.DisableControls;
      try
         if TabProd.IsEmpty then
         begin
            MostraMsg('Aviso','Este local não possui produtos relacionados!',mtWarning, [mbOk]);
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
                     QueAuxi.SQL.Add('UPDATE arqproduto SET IDLoc = NULL WHERE IDProd = '+TabProdIDProd.AsString+';');
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
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar eliminar todos marcados no Local de Estoque, IDLoc = '+TabLocEstIDLoc.AsString+', Desloc = '+TabLocEstDesloc.AsString+' -> '+E.Message);
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

procedure TFrmLocEsto.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmLocEsto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabProd.Active   then TabProd.Close;
   if TabLocEst.Active then TabLocEst.Close;
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;


end.

