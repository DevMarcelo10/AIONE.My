unit uNFEven;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,LMDControl,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage,  LMDCustomControl, Vcl.Graphics,
  LMDCustomPanel, LMDCustomBevelPanel, DB, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomLabel, LMDSimplePanel, RxToolEdit, RxDBCtrl, Vcl.Grids, Vcl.DBGrids,
  AdvGlowButton, LMDCustomMaskEdit, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox,
  LMDBaseEdit, LMDCustomEdit, LMDDBEdit, Vcl.StdCtrls, MarcLib, LMDMaskEdit, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client, LMDEdit, Vcl.ExtCtrls, uRESTDWBasicTypes,
  uRESTDWBasicDB, LMDCustomExtSpinEdit, LMDSpinEdit, LMDDBSpinEdit, Vcl.DBCtrls, LMDComboBoxExt,
  LMDDBLookupCtrls, System.StrUtils, Vcl.Mask, System.DateUtils;

type
  THackDBGrid = class(TDBGrid);

  TFrmNFEven = class(TForm)
    PanelBas: TLMDSimplePanel;
    TabNFEve: TRESTDWClientSQL;
    SouNFEve: TDataSource;
    SouNFEveIte: TDataSource;
    PanelIte: TLMDSimplePanel;
    PaneliIte: TPanel;
    LMDLabel2: TLMDLabel;
    LMDLabel1: TLMDLabel;
    LMDLabel7: TLMDLabel;
    edQtdped: TLMDMaskEdit;
    edVlruni: TLMDMaskEdit;
    edTotite: TLMDMaskEdit;
    edDespro: TLMDLabeledEdit;
    LMDLabel8: TLMDLabel;
    edUnipro: TLMDEdit;
    edCodNCM: TLMDEdit;
    LMDLabel10: TLMDLabel;
    edAliICMS: TLMDMaskEdit;
    lbcst: TLMDLabel;
    edPerCof: TLMDMaskEdit;
    DBGrid1: TDBGrid;
    PanelBotton: TLMDSimplePanel;
    btPrever: TAdvGlowButton;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    PanelTop: TLMDSimplePanel;
    edPess: TLMDDBLabeledEdit;
    cbTipoFrete: TLMDLabeledListComboBox;
    edMotDevu: TLMDDBLabeledEdit;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    btEnviaNF: TAdvGlowButton;
    TabNFEveIDFilial: TIntegerField;
    TabNFEveIDPed: TIntegerField;
    TabNFEveDatped: TDateTimeField;
    TabNFEveIDPess: TIntegerField;
    TabNFEveVlrDesc: TFloatField;
    TabNFEveTotDesc: TFloatField;
    TabNFEveTotPedido: TFloatField;
    TabNFEveVlrFrete: TFloatField;
    TabNFEveVlrSeguro: TFloatField;
    TabNFEveVlrOutros: TFloatField;
    TabNFEveIDCFOP: TIntegerField;
    TabNFEveModNF: TWideStringField;
    TabNFEveSerNF: TWideStringField;
    TabNFEveNroNF: TIntegerField;
    TabNFEveEmiNF: TDateTimeField;
    TabNFEveChaveNF: TWideStringField;
    TabNFEveProtoNF: TWideStringField;
    TabNFEveResulNF: TWideStringField;
    TabNFEveContigencia: TBooleanField;
    TabNFEveStatus: TWideStringField;
    TabNFEveObsNF: TWideMemoField;
    TabNFEveSituNF: TWideStringField;
    TabNFEveDatHorAlt: TDateTimeField;
    TabNFEveIndDelete: TWideStringField;
    TabNFEveNompes: TWideStringField;
    TabNFEveDesnat: TWideStringField;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    TabNFEveIDTransp: TIntegerField;
    TabNFEvePesoBru: TFloatField;
    TabNFEvePesoLiq: TFloatField;
    TabNFEveMarca: TWideStringField;
    TabNFEveEspecie: TWideStringField;
    TabNFEveMotDevu: TWideStringField;
    TabNFEveTipFrete: TSmallintField;
    edSpinParc: TLMDDBLabeledSpinEdit;
    TabNFEveIDForPagNF: TWideStringField;
    TabNFEveNroParc: TSmallintField;
    LMDLabel5: TLMDLabel;
    edVlrDesc: TLMDMaskEdit;
    LMDLabel9: TLMDLabel;
    LMDLabel6: TLMDLabel;
    edAliRedICM: TLMDMaskEdit;
    LMDLabel15: TLMDLabel;
    edAliIcmDif: TLMDMaskEdit;
    LMDLabel3: TLMDLabel;
    edClaIBSCBS: TLMDLabeledEdit;
    edBasCIMS: TLMDMaskEdit;
    LMDLabel4: TLMDLabel;
    LMDLabel11: TLMDLabel;
    edImpSel: TLMDMaskEdit;
    edAliST: TLMDMaskEdit;
    LMDLabel12: TLMDLabel;
    edBaseST: TLMDMaskEdit;
    LMDLabel13: TLMDLabel;
    btSalvaIte: TAdvGlowButton;
    btLimpar: TAdvGlowButton;
    edItens: TLMDLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    btReferen: TAdvGlowButton;
    btObserva: TAdvGlowButton;
    TabCFOP: TRESTDWClientSQL;
    SouCFOP: TDataSource;
    TabCFOPIDCFOP: TFDAutoIncField;
    TabCFOPDesnat: TWideStringField;
    TabCFOPDesNatred: TWideStringField;
    TabCFOPEntSai: TWideStringField;
    TabCFOPCFOP_EST: TSmallintField;
    TabCFOPCFOP_INT: TSmallintField;
    TabCFOPCFOP_EST_ST: TSmallintField;
    TabCFOPCFOP_INT_ST: TSmallintField;
    TabCFOPCFOP_EST_ISE: TSmallintField;
    TabCFOPCFOP_INT_ISE: TSmallintField;
    TabCFOPCFOP_ECF: TSmallintField;
    TabCFOPCFOP_NFCE: TSmallintField;
    TabCFOPAlteraEnt: TWideStringField;
    TabCFOPMovEst: TWideStringField;
    LMDLabel16: TLMDLabel;
    LMDLabel17: TLMDLabel;
    btTransp: TAdvGlowButton;
    TabCFOPIndRefe: TBooleanField;
    Shape5: TShape;
    edCstite: TLMDComboBoxExt;
    edCSTPISCOF: TLMDComboBoxExt;
    Shape4: TShape;
    TabForPagNF: TRESTDWClientSQL;
    SouForPagNF: TDataSource;
    TabForPagNFIDForPagNF: TWideStringField;
    TabForPagNFDesForPagNF: TWideStringField;
    TabForPagNFIDGruCard: TBooleanField;
    LMDDBLookupComboBox1: TLMDDBLookupComboBox;
    TabNFEveIte: TRESTDWClientSQL;
    TabNFEveIteIDFilial: TIntegerField;
    TabNFEveIteIDPed: TIntegerField;
    TabNFEveIteIDItem: TIntegerField;
    TabNFEveIteIDProd: TIntegerField;
    TabNFEveIteDesitem: TWideStringField;
    TabNFEveIteCodEAN: TWideStringField;
    TabNFEveIteCodNCM: TWideStringField;
    TabNFEveIteCodCEST: TWideStringField;
    TabNFEveIteCSTPisCof: TSmallintField;
    TabNFEveIteCST_CSON: TWideStringField;
    TabNFEveIteCodClasIte: TWideStringField;
    TabNFEveIteUniVen: TWideStringField;
    TabNFEveIteVlruni: TFloatField;
    TabNFEveIteQtdped: TFloatField;
    TabNFEveIteVlrDesc: TFloatField;
    TabNFEveIteBaseICMS: TFloatField;
    TabNFEveIteAliqICMS: TFloatField;
    TabNFEveIteAliqRedICM: TFloatField;
    TabNFEveIteAliqIcmDif: TFloatField;
    TabNFEveIteBaseST: TFloatField;
    TabNFEveIteAliqST: TFloatField;
    TabNFEveIteAliqIS: TFloatField;
    TabNFEveIteDesclaIte: TWideStringField;
    TabNFEveIteDespro: TWideStringField;
    TabNFEveIteTotIteCalc: TFloatField;
    LMDDBLookupComboBox2: TLMDDBLookupComboBox;
    TabNFEveIteAliPis: TFloatField;
    TabNFEveIteAliCof: TFloatField;
    LMDLabel14: TLMDLabel;
    TabNFEveCpfCnpjTran: TWideStringField;
    TabNFEveNomeTran: TWideStringField;
    TabNFEveIETran: TWideStringField;
    TabNFEveEndTran: TWideStringField;
    TabNFEveCidTran: TWideStringField;
    TabNFEveEstTran: TWideStringField;
    TabNFEvePlaVeiTran: TWideStringField;
    TabNFEveUFPlaVeiTran: TWideStringField;
    TabNFEveRNTCTran: TWideStringField;
    LMDLabel18: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel19: TLMDLabel;
    Shape6: TShape;
    edDate: TDateEdit;
    edTime: TLMDMaskEdit;
    TabNFEveDatHorSai: TDateTimeField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btExcNCMUFClick(Sender: TObject);
    procedure LMDDBLabeledEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit2CustomButtons0Click(Sender: TObject; index: Integer);
    procedure btSalvaIteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edCodKeyPress(Sender: TObject; var Key: Char);
    procedure edDesproExit(Sender: TObject);
    procedure edQtdpedExit(Sender: TObject);
    procedure TabNFEveAfterInsert(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btLimaCanClick(Sender: TObject);
    procedure edPessCustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLookupComboBox1Change(Sender: TObject);
    procedure edSpinParcChange(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure TabNFEveBeforePost(DataSet: TDataSet);
    procedure btEnviaNFClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure edPessExit(Sender: TObject);
    procedure edPessKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesproKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesproEnter(Sender: TObject);
    procedure edClaIBSCBSKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edClaIBSCBSCustomButtons0Click(Sender: TObject; index: Integer);
    procedure TabNFEveIteBeforePost(DataSet: TDataSet);
    procedure edAliSTExit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btObservaClick(Sender: TObject);
    procedure btTranspClick(Sender: TObject);
    procedure btReferenClick(Sender: TObject);
  private
    Editar:Boolean;
    auxRegTrib:Integer;
    auxAliPis,auxAliCof:Double;
    procedure LimpaCampos;
    procedure SalvarItem;
    procedure SomaNota;
    procedure AjustGrid;
    function  SalvarCapa:Boolean;
    { Private declarations }
  public
    { Public declarations }
    dsAnt:TDataSetState;
  end;

var
  FrmNFEven: TFrmNFEven;

implementation

{$R *.dfm}


//--> FAZER ENVIO DA NF AO SEFAZ.

uses uDM, uConst, uLibFarm, uNFEvenObs, uNFEvenTra, uNFEvenRef;

procedure TFrmNFEven.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT RegTributa,PercPIS,PerCOFINS FROM arqparametros LIMIT 1';
         QueAuxi.Open;
         auxAliPis  := QueAuxi.FieldByName('PercPIS').AsFloat;
         auxAliCof  := QueAuxi.FieldByName('PerCOFINS').AsFloat;
         auxRegTrib := QueAuxi.FieldByName('RegTributa').AsInteger;
         if auxRegTrib = 2 then auxRegTrib := 3;
      except
         on E:Exception do
         begin
            MostraMsg('Erro','Não foi possível continuar -> '+E.Message,mtError, [mbOk]);
            SalvaLog(USUARIO, PastaLog, '[ERRO] Tentando abrir arqparametros (uNFEven) -> '+E.Message);
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

   Editar := False;
   SouNFEveIte.Enabled := False;
   SouNFEve.Enabled    := False;

   TabNFEve.SQL.Text := 'SELECT EVE.*,PES.Nompes,OPE.Desnat FROM arqnfeven EVE LEFT JOIN arqcfop OPE '+
   'ON EVE.IDCFOP = OPE.IDCFOP LEFT JOIN arqpessoa PES ON EVE.IDPess = PES.IDPess WHERE Status = "A"';
   TabNFEve.Open;
   if not TabNFEve.IsEmpty then
   begin
      cbTipoFrete.ItemIndex := TabNFEveTipFrete.AsInteger;
      edDate.Date   := DateOF(TabNFEveDatHorSai.Value);
      edTime.AsTime := TimeOF(TabNFEveDatHorSai.Value);
      StrToDateTime(edDate.Text+' '+edTime.Text+':00');
   end
   else TabNFEve.Append;
   TabNFEveIte.Open;
   SouNFEve.Enabled    := True;
   SouNFEveIte.Enabled := True;
   TabCFOP.Open;
   TabForPagNF.Open;
   AjustGrid;
   edPess.SetFocus;
end;

procedure TFrmNFEven.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmNFEven.edPessCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabNFEve,'arqpessoa',TDBEdit(edPess),'IDPess','IDPess','Nompes','Nompes','',0);
end;

procedure TFrmNFEven.edPessKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_RETURN) or (IsNumeric(edPess.Text.Trim)) then Exit;
   btBuscasDB(TabNFEve,'arqpessoa',TDBEdit(edPess),'IDPess','IDPess','Nompes','Nompes','',Key);
end; //

procedure TFrmNFEven.edPessExit(Sender: TObject);
var
   auxCampo:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if IsNumeric(edPess.Text.Trim) then
   begin
      auxCampo := iif(edPess.Text.Trim.Length < 11, 'IDPess','CpfCnpjPes');
      QueAuxi  := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Text := 'SELECT IDPess,Nompes FROM arqpessoa WHERE '+auxCampo+' = '+Aspas(edPess.Text.Trim);
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
            begin
               TabNFEveIDPess.Value := QueAuxi.FieldByName('IDPess').AsInteger;
               TabNFEveNompes.Value := QueAuxi.FieldByName('Nompes').AsString;
            end else
            begin
               MostraMsg('Aviso', 'Pessoa não encontrada!', mtWarning, [mbOk]);
               edPess.Text := '';
               TabNFEveIDPess.Value := 0;
               TabNFEveNompes.Value := '';
               edPess.SetFocus;
               Exit;
            end; //if
         except
            on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível executar busca da pessoa -> '+E.Message,mtError, [mbOk]);
               SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível executar busca da pessoa (uNFEven) -> '+E.Message);
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
end;

procedure TFrmNFEven.LMDDBLabeledEdit2CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabNFEve,'arqpessoa',TDBEdit(edPess),'IDPes','IDPess','Nompes','Nompes','', 0);
end;

procedure TFrmNFEven.LMDDBLabeledEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then Exit;
end;

procedure TFrmNFEven.edSpinParcChange(Sender: TObject);
begin
   if edSpinParc.Value < 0 then edSpinParc.Value := 0;
end;

procedure TFrmNFEven.LMDDBLookupComboBox1Change(Sender: TObject);
begin
   if TabNFEveIDCFOP.Value = 4 then
        edMotDevu.Enabled := TabNFEveIDCFOP.Value = 4
   else edMotDevu.Clear;
end;

procedure TFrmNFEven.btSalvarClick(Sender: TObject);
begin
   if TabNFEve.State in dsEditModes then SalvarCapa;
end;

// -------------------- Salvar Capa da Nota Fiscal ----------------- //
function TFrmNFEven.SalvarCapa:Boolean;
var
   Erro:Integer;
begin
   Result := False;
   if TabNFEve.State in dsEditModes then
   begin
      PanelBotton.SetFocus;
      PanelTop.SetFocus;
      if (TabNFEveIDPess.Value <= 0) and (TabNFEveIDCFOP.Value <= 0) then Exit;

      Erro := 0;
      if TabNFEveIDPess.Value <= 0 then Erro := 1 else
      if TabNFEveIDCFOP.Value <= 0 then Erro := 2 else
      if cbTipoFrete.ItemIndex < 0 then Erro := 3 else
      if TabNFEveIDForPagNF.Value = '' then Erro := 4;
      if Erro <> 0 then
      begin
         MostraMsg('Incompleto', 'Este campo deve ser preenchido!', mtWarning, [mbOk]);
         case Erro of
            1: edPess.SetFocus;
            2: LMDDBLookupComboBox1.SetFocus;
            3: cbTipoFrete.SetFocus;
            4: LMDDBLookupComboBox2.SetFocus;
            5: edMotDevu.SetFocus;
         end;
         Exit;
      end; //if

      if (TabNFEveIDCFOP.Value = 4) and (TabNFEveMotDevu.AsString.Trim = '') then
      begin
         MostraMsg('Incompleto', 'É necessário que seja informado o Motivo da Devolução!',mtWarning, [mbOk]);
         edMotDevu.SetFocus;
         Exit;
      end; //if
      TabNFEveDatHorSai.Value := StrToDateTime(edDate.Text+' '+edTime.Text+':00');
      if TabNFEveDatHorSai.Value < Now then TabNFEveDatHorSai.Value := Now;
      try
         TabNFEve.Post;
         AjustGrid;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog,'[ERRO] Não foi possível salvar NF Eventual (uNFEven) - IDPed: '+TabNFEveIDPed.AsString+' -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar NF.'+#10+E.Message, mtError, [mbOk], 0);
            Exit;
         end;
      end;
   end; //if
   Result := True;
   if edDespro.Enabled then
      edDespro.SetFocus;
end;

procedure TFrmNFEven.edAliSTExit(Sender: TObject);
begin
   btSalvaIte.Click;
end;

procedure TFrmNFEven.edClaIBSCBSCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqclatribite',TLMDEdit(edClaIBSCBS),'CodClasIte','DesClaIte','',0,True);
end;

procedure TFrmNFEven.edClaIBSCBSKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then Exit;
   btBuscas('arqclatribite',TLMDEdit(edClaIBSCBS),'CodClasIte','DesClaIte','',Key,True);
end;

procedure TFrmNFEven.edCodKeyPress(Sender: TObject; var Key: Char);
begin
   if ExisteStr(Key) then Key := #0;
end;

procedure TFrmNFEven.edDesproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto', TLMDEdit(edDespro), 'IDProd','Despro','', 0, True);
end;

procedure TFrmNFEven.edDesproKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
      edDespro.Clear;
      edDespro.Tag := 0;
      Exit;
   end;
   // if (Key = VK_RETURN) or (IsNumeric(edDespro.Text.Trim)) then Exit;
   // btBuscas('arqproduto',TLMDEdit(edDespro),'IDProd','Despro','',Key);
end;

procedure TFrmNFEven.edDesproEnter(Sender: TObject);
begin
   edDespro.Enabled := not Editar;
end;

function GetCSTsByCFOP(const ACFOP,ARegime:Integer): TStrings;
begin
  Result := TStringList.Create;

  case ACFOP of
    5403, 1403, 1411, 5411, 1407, 1603, 1653, 5927, 5949:
      case ARegime of
        3:begin
            // CST ligados a ST: tributada + ST, isenta + ST, ST retida, etc.
            Result.Add('10');  // Tributada e com cobrança de ICMS-ST
            Result.Add('30');  // Isenta/não tributada com cobrança de ICMS-ST
            Result.Add('60');  // ICMS cobrado anteriormente por ST
            Result.Add('70');  // Tributada com redução + ST
            Result.Add('90');  // Outras – uso de exceção
          end;
        1:begin
            // CSOSN ligados a ST
            Result.Add('201'); // Tributada com permissão de crédito + ST
            Result.Add('202'); // Tributada sem permissão de crédito + ST
            Result.Add('203'); // Isenta de ICMS + ST
            Result.Add('500'); // ICMS-ST cobrado anteriormente
            Result.Add('900'); // Outras
          end;
      end;

    5603:
      case ARegime of
        3:begin
            Result.Add('41'); // Não tributada
            Result.Add('49'); // Outras não tributadas
            Result.Add('50'); // Suspensão/diferimento, conforme UF
            Result.Add('90'); // Outras
          end;
        1:begin
            Result.Add('400'); // Não tributada pelo Simples
            Result.Add('900'); // Outras
          end;
      end;

    1910, 5910, 5915:
      case ARegime of
        3:begin
            Result.Add('41'); // Não tributada
            Result.Add('49'); // Outras não tributadas
            Result.Add('50'); // Suspensão/diferimento (se UF usar)
          end;
        1:begin
            Result.Add('300'); // Imune (quando aplicável)
            Result.Add('400'); // Não tributada
            Result.Add('900'); // Outras
          end;
      end;
  else
    // CFOP não mapeado para ST – retorna lista vazia
    // (pode opcionalmente preencher com algo padrão, se quiser)
  end;
end;

function GetCST_PIS_COF(const ACFOP:String; ARegime:Integer): TStrings;
begin
  Result := TStringList.Create;
  case ARegime of
    3:begin
        // ----- SAÍDAS -----
        if MatchStr(ACFOP, ['5102','5202','5403','5411','5603','5910','5915','5927','5949']) then
        begin
          Result.Add('01');   Result.Add('07');
          Result.Add('02');   Result.Add('08');
          Result.Add('03');   Result.Add('09');
          Result.Add('04');   Result.Add('49');
          Result.Add('06');
        end else
        // ----- ENTRADAS -----
        if MatchStr(ACFOP, ['1102','1202','1403','1407','1411','1556','1603','1653','1910']) then
        begin
          Result.Add('50');   Result.Add('55');
          Result.Add('51');   Result.Add('56');
          Result.Add('52');   Result.Add('57');
          Result.Add('53');   Result.Add('58');
          Result.Add('54');   Result.Add('59');
        end;
      end;

    1:begin
        // Saídas
        if MatchStr(ACFOP, ['5102','5202','5403','5411','5603','5910','5915','5927','5949']) then
        begin
          Result.Add('49'); // padrão para saída SN
        end else
        // Entradas
        if MatchStr(ACFOP, ['1102','1202','1403','1407','1411','1556','1603','1653','1910']) then
        begin
          Result.Add('99'); // padrão para entrada SN
        end;
      end;
  end;
end;

procedure TFrmNFEven.edDesproExit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   auxTipTri,auxCodCla:Integer;
begin
   edUnipro.Text := '';
   edCodNCM.Text := '';
   edClaIBSCBS.Text    := '';
   edClaIBSCBS.Tag     := 0;
   edAliST.AsFloat     := 0.00;
   edAliICMS.AsFloat   := 0.00;
   edAliRedICM.AsFloat := 0.00;
   edAliIcmDif.AsFloat := 0.00;
   edCstite.ItemIndex  := -1;
   edCstite.Items.Clear;
   edCSTPISCOF.ItemIndex := -1;
   edCSTPISCOF.Items.Clear;

   if edDespro.Text.Trim = '' then Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT ICM.PerICMS FROM arqpessoa PES LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
         'LEFT JOIN arqicmsuf ICM ON MUN.Estmun = ICM.UFICMS WHERE IDPess = '+TabNFEveIDPess.AsString+' LIMIT 1';
         QueAuxi.Open;
         edAliICMS.AsFloat := QueAuxi.FieldByName('PerICMS').AsFloat;

         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT PRO.IDProd,PRO.Despro,PRO.CodNCM,UNI.SiglaUN,PRO.TipoTriICMS,PRO.AliqRedICM,PRO.AliqIcmDif,'+
         'PRO.AliqMVA,PRO.CSOSN,PRO.CSTICMS,PRO.CodClasIte,CLA.DesClaIte FROM arqproduto PRO LEFT JOIN arqunidades UNI '+
         'ON PRO.IDUniVen = UNI.IDUni LEFT JOIN arqclatribite CLA ON PRO.CodClasIte = CLA.CodClasIte ';
         if IsNumeric(edDespro.Text.Trim) then
         begin
            if edDespro.Text.Trim.Length >= 8 then
            begin
               QueAuxi.SQL.Add('LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd '+
               'WHERE PRO.CodEANpri = '+Aspas(edDespro.Text.Trim)+' OR EAN.CodEAN = '+Aspas(edDespro.Text.Trim));
            end
            else QueAuxi.SQL.Add('WHERE PRO.IDProd = '+edDespro.Text.Trim);
         end
         else if edDespro.Tag > 0 then QueAuxi.SQL.Add('WHERE PRO.IDProd = '+edDespro.Tag.ToString);

         if AnsiPos('WHERE',QueAuxi.SQL.Text) > 0 then
         begin
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
            begin
               if QueAuxi.FieldByName('CodClasIte').AsString <> '' then
                    auxCodCla := QueAuxi.FieldByName('CodClasIte').AsInteger
               else auxCodCla := 0;
               edDespro.Tag        := QueAuxi.FieldByName('IDProd').AsInteger;
               edDespro.Text       := QueAuxi.FieldByName('Despro').AsString;
               edUnipro.Text       := QueAuxi.FieldByName('SiglaUN').AsString;
               edCodNCM.Text       := QueAuxi.FieldByName('CodNCM').AsString;
               edClaIBSCBS.Text    := QueAuxi.FieldByName('DesClaIte').AsString;
               edClaIBSCBS.Tag     := auxCodCla;
               auxTipTri           := QueAuxi.FieldByName('TipoTriICMS').AsInteger;
               edAliST.AsFloat     := QueAuxi.FieldByName('AliqMVA').AsFloat;
               edAliRedICM.AsFloat := QueAuxi.FieldByName('AliqRedICM').AsFloat;
               edAliIcmDif.AsFloat := QueAuxi.FieldByName('AliqIcmDif').AsFloat;
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'SELECT CFOP_EST,CFOP_EST_ST FROM arqcfop WHERE IDCFOP = '+TabNFEveIDCFOP.AsString;
               QueAuxi.Open;
               edCstite.Items    := GetCSTsByCFOP(QueAuxi.FieldByName(iif(auxTipTri = 3,'CFOP_EST_ST','CFOP_EST')).AsInteger, auxRegTrib);
               edCstite.Style    := TLMDDropDownStyle.csDropDownList;
               edCSTPISCOF.Items := GetCST_PIS_COF(QueAuxi.FieldByName(iif(auxTipTri = 3,'CFOP_EST_ST','CFOP_EST')).AsString, auxRegTrib);
               edCSTPISCOF.Style := TLMDDropDownStyle.csDropDownList;
            end else
            begin
               edDespro.Text := '';
               edDespro.Tag  := 0;
               MostraMsg('Aviso', 'Produto não encontrado!', mtWarning, [mbOk]);
               Exit;
            end; //if
         end else
         begin
            edCstite.Style    := TLMDDropDownStyle.csDropDown;
            edCSTPISCOF.Style := TLMDDropDownStyle.csDropDown;
         end; //if
      except
         on E:Exception do
         begin
            MostraMsg('Erro','Não foi possível executar busca do produto!', mtError, [mbOk]);
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível executar busca do produto (uNFEven) -> '+E.Message);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmNFEven.edQtdpedExit(Sender: TObject);
begin
   edTotite.AsFloat := edQtdped.AsFloat * (edVlruni.AsFloat - edVlrDesc.AsFloat);
end;

procedure TFrmNFEven.btExcNCMUFClick(Sender: TObject);
var
   QueryTmp:TRESTDWClientSQL;
begin
   if not TabNFEveIte.IsEmpty then
   begin
      if MessageDlg('Confirma exclusão do item da Nota?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         QueryTmp := TRESTDWClientSQL.Create(nil);
         try
            with QueryTmp do
            begin
               DataBase := DM.DWDataBase;
               SQL.Text := 'DELETE FROM arqnfevenite WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIteIDPed.AsString+' AND IDIte = '+TabNFEveIteIDItem.AsString;
               try
                  ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'[ERRO] Excluir Item Nota Eventual - ID: '+TabNFEveIteIDPed.AsString+' - Item: '+TabNFEveIteIDItem.AsString+' = '+E.Message);
                     MostraMsg('Erro', 'Não foi possível excluir nesse momento!', mtError, [mbOk], 0);
                     Exit;
                  end;
               end; //try
            end; //with
         finally
            QueryTmp.Close;
            FreeAndNil(QueryTmp);
         end;
         TabNFEveIte.Delete;
      end; //if
   end; //if
   LimpaCampos;
   SomaNota;
end;

// ----------------- Salvar Item -----------------
procedure TFrmNFEven.btSalvaIteClick(Sender: TObject);
begin
   if not SalvarCapa then Exit;

   if edDespro.Text.Trim = '' then
   begin
      MostraMsg('Incompleto', 'Favor entrar com a descrição do item!', mtWarning, [mbOk], 0);
      edDespro.SetFocus;
      Exit;
   end; //if
   if edUnipro.Text.Trim = '' then
   begin
      MostraMsg('Incompleto', 'Favor entrar com a Unidade do Produto!', mtWarning, [mbOk], 0);
      edUnipro.SetFocus;
      Exit;
   end; //if
   if edCodNCM.Text.Trim.Length <> 8 then
   begin
      MostraMsg('Incompleto', 'Favor entrar com NCM válido!', mtWarning, [mbOk], 0);
      edCodNCM.SetFocus;
      Exit;
   end; //if
   if edCstite.Value.Trim = '' then
   begin
      MostraMsg('Incompleto', 'Favor entrar com CST/CSON válido!', mtWarning, [mbOk], 0);
      edCstite.SetFocus;
      Exit;
   end; //if
   if edCSTPISCOF.Value.Trim = '' then
   begin
      MostraMsg('Incompleto', 'Favor entrar com PIS/COFINS válido!', mtWarning, [mbOk], 0);
      edCSTPISCOF.SetFocus;
      Exit;
   end; //if
   if edQtdped.AsFloat <= 0.00 then
   begin
      MostraMsg('Incompleto', 'Favor entrar com a Quantidade!', mtWarning, [mbOk], 0);
      edQtdped.SetFocus;
      Exit;
   end; //if
   if edVlruni.AsFloat <= 0.00 then
   begin
      MostraMsg('Incompleto', 'Favor entrar com o Valor Unitário!', mtWarning, [mbOk], 0);
      edQtdped.SetFocus;
      Exit;
   end; //if
   if edVlruni.AsFloat <= edVlrDesc.AsFloat then
   begin
      MostraMsg('Erro', 'Valor do desconto incompatível com o valor unitário!', mtWarning, [mbOk], 0);
      edVlrDesc.SetFocus;
      Exit;
   end; //if

   SalvarItem;
   edDespro.SetFocus;
end;

procedure TFrmNFEven.SalvarItem;
var
   NroIteAux:Integer;
begin
   if Editar then
   begin
      TabNFEveIte.Locate('IDFilial;IDPed;IDItem', VarArrayOf([FILIAL, TabNFEveIDPed.Value, PaneliIte.Tag]), []);
      TabNFEveIte.Edit;
   end
   else TabNFEveIte.Append;
   TabNFEveIteIDProd.Value     := edDespro.Tag;
   TabNFEveIteDesitem.Value    := edDespro.Text.Trim;
   TabNFEveIteUniVen.Value     := edUnipro.Text.Trim;
   TabNFEveIteCodNCM.Value     := edCodNCM.Text;
   TabNFEveIteCST_CSON.Value   := edCstite.Value;
   TabNFEveIteCSTPisCof.Value  := edCSTPISCOF.Value.ToInteger;
   TabNFEveIteCodClasIte.Value := StrZero(edClaIBSCBS.Tag.ToString,6);
   TabNFEveIteQtdped.Value     := edQtdped.AsFloat;
   TabNFEveIteVlruni.Value     := edVlruni.AsFloat;
   TabNFEveIteVlrDesc.Value    := edVlrDesc.AsFloat;
   TabNFEveIteAliqRedICM.Value := edAliRedICM.AsFloat;
   TabNFEveIteAliqIcmDif.Value := edAliIcmDif.AsFloat;
   TabNFEveIteBaseICMS.Value   := edBasCIMS.AsFloat;
   TabNFEveIteAliqICMS.Value   := edAliICMS.AsFloat;
   TabNFEveIteAliPis.Value     := auxAliPis;
   TabNFEveIteAliCof.Value     := auxAliCof;
   TabNFEveIteBaseST.Value     := edBaseST.AsFloat;
   TabNFEveIteAliqST.Value     := edAliST.AsFloat;
   try
      TabNFEveIte.Post;
      Editar := False;
      PaneliIte.Tag := 0;
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO, PastaLog,'[ERRO] Não foi possível salvar Item NF Avulsa (uNFEnven) - IDPed: '+TabNFEveIDPed.AsString+' - Item: '+TabNFEveIteDesitem.AsString+ ' -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível salvar Item da NF.', mtError, [mbOk], 0);
      end;
   end;
   SomaNota;
   LimpaCampos;
end;

procedure TFrmNFEven.TabNFEveAfterInsert(DataSet: TDataSet);
begin
   dsAnt := dsInsert;
   TabNFEveIDFilial.Value    := FILIAL;
   TabNFEveDatped.AsDateTime := VeDataServer;
   TabNFEveTotPedido.AsFloat := 0.00;
   TabNFEveTotDesc.AsFloat   := 0.00;
   TabNFEveStatus.AsString   := 'A';
   TabNFEveNroParc.AsInteger := 0;
end;

procedure TFrmNFEven.TabNFEveBeforePost(DataSet: TDataSet);
var
   QueAuxi: TRESTDWClientSQL;
begin
   if TabNFEve.State = dsInsert then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Text := 'SELECT COALESCE(MAX(IDPed), 0)+1 AS NewID FROM arqnfeven WHERE IDFilial = '+FILIAL.ToString;
            QueAuxi.Open;
            TabNFEveIDPed.Value := QueAuxi.FieldByName('NewID').AsInteger;
         except
            on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível salvar NF Eventual. -> '+E.Message, mtError, [mbOk]);
               SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar NF Eventual, erro ao gerar o IDPed (uNFEven) -> '+E.Message);
               Abort;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
   TabNFEveTipFrete.Value := cbTipoFrete.ItemIndex;
end;

procedure TFrmNFEven.TabNFEveIteBeforePost(DataSet: TDataSet);
var
   QueAuxi: TRESTDWClientSQL;
begin
   if TabNFEveIte.State = dsInsert then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Text := 'SELECT COALESCE(MAX(IDItem), 0)+1 AS NewID FROM arqnfevenite WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIDPed.AsString;
            QueAuxi.Open;
            TabNFEveIteIDFilial.Value := FILIAL;
            TabNFEveIteIDPed.Value    := TabNFEveIDPed.AsInteger;
            TabNFEveIteIDItem.Value   := QueAuxi.FieldByName('NewID').AsInteger;
         except
            on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível salvar Item da NF Eventual -> '+E.Message, mtError, [mbOk]);
               SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar NF Eventual, erro ao gerar o IDPed (uNFEven) -> '+E.Message);
               Abort;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if

end;

procedure TFrmNFEven.btExcluirClick(Sender: TObject);
begin
   if MessageDlg('Confirma exclusão de toda NF?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
      var QueAuxi:TRESTDWClientSQL;
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Add('DELETE FROM arqnfevenite WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIDPed.AsString+' AND IDItem = '+TabNFEveIteIDItem.AsString+';');
            QueAuxi.SQL.Add('DELETE FROM arqnfevenref WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIDPed.AsString+' AND IDItem = '+TabNFEveIteIDItem.AsString+';');
            QueAuxi.SQL.Add('DELETE FROM arqnfeven    WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIDPed.AsString+';');
            QueAuxi.ExecSQL;
            TabNFEveIte.Refresh;
            AjustGrid;
            SomaNota;
         except
         on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível excluir NF. -> '+E.Message,mtError, [mbOk]);
               SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir NF no arqnfeven (uNFEven) -> '+E.Message);
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
  end; //if
end;

// --------------- Totaliza Dados da Nota Fiscal ---------------- //
procedure TFrmNFEven.SomaNota;
var
   auxTotIte:Integer;
   QueAuxi:TRESTDWClientSQL;
   auxTotPedi,auxTotDesc:Double;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT SUM((Qtdped * (Vlruni - VlrDesc))) AS TotNota, SUM(Qtdped * VlrDesc) AS TotDesc, '+
         'COUNT(*) AS TotItem FROM arqnfevenite WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIDPed.AsString;
         try
            Open;
            if not IsEmpty then
            begin
               auxTotIte  := FieldByName('TotItem').AsInteger;
               auxTotPedi := FieldByName('TotNota').AsFloat;
               auxTotDesc := FieldByName('TotDesc').AsFloat;
            end else
            begin
               auxTotIte  := 0;
               auxTotPedi := 0.00;
               auxTotDesc := 0.00;
            end;
            TabNFEve.Edit;
            TabNFEveTotDesc.Value   := auxTotDesc;
            TabNFEveTotPedido.Value := auxTotPedi;
            TabNFEve.Post;
            edItens.Text := auxTotIte.ToString;
            AjustGrid;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'[ERRO] Totalizar NF Eventual - IDPed: '+TabNFEveIDPed.AsString+' - Item: '+TabNFEveIteIDItem.AsString+' = '+E.Message);
               MostraMsg('Erro', 'Não foi possível totalizar NF.', mtError, [mbOk], 0);
               Exit;
            end;
         end; //try
      end; //with
   finally
      QueAuxi.Close;
      FreeANdNil(QueAuxi);
   end;
end;

procedure TFrmNFEven.btLimaCanClick(Sender: TObject);
begin
   LimpaCampos;
   edDespro.SetFocus;
end;

procedure TFrmNFEven.btLimparClick(Sender: TObject);
begin
   LimpaCampos;
end;

procedure TFrmNFEven.btObservaClick(Sender: TObject);
begin
   if not SalvarCapa then Exit;
   try
      Self.AlphaBlendValue := 80;
      if not (TabNFEve.State in dsEditModes) then TabNFEve.Edit;
      Application.CreateForm(TFrmNFEvenObs, FrmNFEvenObs);
      CentralizarControl(FrmNFEvenObs, PanelBas);
      FrmNFEvenObs.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmNFEvenObs := nil;
      TabNFEve.Post;
      TabNFEve.Edit;
      AjustGrid;
   end; // try
end;

procedure TFrmNFEven.btReferenClick(Sender: TObject);
begin
   if not SalvarCapa then Exit;
   try
      Self.AlphaBlendValue := 80;
      Application.CreateForm(TFrmNFEvenRef, FrmNFEvenRef);
      CentralizarControl(FrmNFEvenRef, PanelBas);
      FrmNFEvenRef.recIDPed := TabNFEveIDPed.Value;
      FrmNFEvenRef.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmNFEvenRef := nil;
   end; // try
end;

procedure TFrmNFEven.btTranspClick(Sender: TObject);
begin
   if not SalvarCapa then Exit;
   try
      Self.AlphaBlendValue := 80;
      if not (TabNFEve.State in dsEditModes) then TabNFEve.Edit;
      Application.CreateForm(TFrmNFEvenTra, FrmNFEvenTra);
      CentralizarControl(FrmNFEvenTra, PanelBas);
      FrmNFEvenTra.recNFEven       := TabNFEve;
      FrmNFEvenTra.recFieldCpfCnpj := TabNFEveCpfCnpjTran;
      FrmNFEvenTra.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmNFEvenTra := nil;
      TabNFEve.Post;
      TabNFEve.Edit;
      AjustGrid;
   end; // try
end;

procedure TFrmNFEven.LimpaCampos;
begin
   Editar := False;
   PaneliIte.Tag := 0;
   edDespro.Enabled    := True;
   edDespro.Text       := '';
   edDespro.Tag        := 0;
   edClaIBSCBS.Text    := '';
   edClaIBSCBS.Tag     := 0;
   edUnipro.Text       := '';
   edCodNCM.Text       := '';
   edCstite.Text       := '';
   edCSTPISCOF.Text    := '';
   edQtdped.AsFloat    := 0.00;
   edVlruni.AsFloat    := 0.00;
   edVlrDesc.AsFloat   := 0.00;
   edTotite.AsFloat    := 0.00;
   edImpSel.AsFloat    := 0.00;
   edBasCIMS.AsFloat   := 0.00;
   edAliICMS.AsFloat   := 0.00;
   edAliRedICM.AsFloat := 0.00;
   edAliIcmDif.AsFloat := 0.00;
   edBaseST.AsFloat    := 0.00;
   edAliST.AsFloat     := 0.00;
   AjustGrid;
end;

procedure TFrmNFEven.DBGrid1DblClick(Sender: TObject);
var
   auxClaIBSCBS:Integer;
begin
   Editar := True;
   if IsNumeric(TabNFEveIteCodClasIte.AsString) then
        auxClaIBSCBS := TabNFEveIteCodClasIte.AsInteger
   else auxClaIBSCBS := 0;
   PaneliIte.Tag       := TabNFEveIteIDItem.Value;
   edDespro.Enabled    := False;
   edDespro.Text       := TabNFEveIteDesitem.Value;
   edDespro.Tag        := TabNFEveIteIDProd.Value;
   edClaIBSCBS.Text    := TabNFEveIteDesclaIte.Value;
   edClaIBSCBS.Tag     := auxClaIBSCBS;
   edUnipro.Text       := TabNFEveIteUniVen.Value;
   edCodNCM.Text       := TabNFEveIteCodNCM.Value;
   edCstite.Text       := TabNFEveIteCST_CSON.Value;
   edCSTPISCOF.Text    := TabNFEveIteCSTPisCof.AsString;
   edQtdped.AsFloat    := TabNFEveIteQtdped.Value;
   edVlruni.AsFloat    := TabNFEveIteVlruni.Value;
   edVlrDesc.AsFloat   := TabNFEveIteVlrDesc.Value;
   edTotite.AsFloat    := TabNFEveIteTotIteCalc.Value;
   edImpSel.AsFloat    := TabNFEveIteAliqIS.Value;
   edBasCIMS.AsFloat   := TabNFEveIteBaseICMS.Value;
   edAliICMS.AsFloat   := TabNFEveIteAliqICMS.Value;
   edAliRedICM.AsFloat := TabNFEveIteAliqRedICM.Value;
   edAliIcmDif.AsFloat := TabNFEveIteAliqIcmDif.Value;
   edBaseST.AsFloat    := TabNFEveIteBaseST.Value;
   edAliST.AsFloat     := TabNFEveIteAliqST.Value;
   edUnipro.SetFocus;
end;

// -------------------- Enviar NF Para o SEFAZ -------------------- //
procedure TFrmNFEven.btEnviaNFClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
Exit;
   if TabCFOPIndRefe.AsBoolean then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqnfevenref WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIDPed.AsString;
            QueAuxi.Open;
            if QueAuxi.IsEmpty then
            begin
               MostraMsg('Incompleto', 'É necessário que seja informada NF referencida!',mtWarning, [mbOk]);
               btReferen.Click;
               Exit;
            end; //if
         except
            on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível salvar -> '+E.Message, mtError, [mbOk]);
               SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possivel abrir  -> '+E.Message);
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
end;

// ----------------- Exclusão de Item da NF ----------------- //
procedure TFrmNFEven.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 0 then
   begin
      if MostraMsg('Confirmação','Confirma exclusão desse item?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         var QueAuxi:TRESTDWClientSQL;
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            try
               QueAuxi.SQL.Text := 'DELETE FROM arqnfevenite WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+TabNFEveIDPed.AsString+' AND IDItem = '+TabNFEveIteIDItem.AsString;
               QueAuxi.ExecSQL;
               TabNFEveIte.Refresh;
               AjustGrid;
               SomaNota;
            except
            on E:Exception do
               begin
                  MostraMsg('Erro','Não foi possível excluir item. -> '+E.Message,mtError, [mbOk]);
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir item no arqnfevenite (uNFEven) -> '+E.Message);
                  Exit;
               end;
            end;
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end;
   end;  //if
end;

procedure TFrmNFEven.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   with TDBGrid(Sender) do
   begin
      if (THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) then
      begin
         Canvas.Brush.Color := $00ECF2FF;
         Canvas.Font.Color  := clBlack;
         Canvas.FillRect(Rect);
      end; //if

      if Column.ID = 0  then DM.ImagesGer.Draw(Canvas, Rect.Left+4,Rect.Top+3, 0);

      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter then
            Canvas.TextRect(Rect,Rect.Left + (Rect.Width - Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then
            Canvas.TextRect(Rect,Rect.Left + Rect.Width - Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify then
            Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
      end; //if
   end; //with
end;

procedure TFrmNFEven.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabNFEveIte.Close;
   TabNFEve.Close;
   TabForPagNF.Close;
   TabCFOP.Close;
   Action := caFree;
end;

end.
