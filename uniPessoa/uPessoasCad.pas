unit uPessoasCad;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, ACBrSocket, LMDCustomMaskEdit, LMDCustomExtCombo,
   LMDLabel, LMDListComboBox, LMDDBListComboBox, Vcl.StdCtrls, Vcl.Mask,
   RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel,
   LMDCustomListComboBox, LMDCustomLabel, LMDCustomBevelPanel, Data.DB, IdSSL,
   Vcl.ExtCtrls, AdvGlowButton, MarcLib, ACBrBase, ACBrCEP, AdvEdit, IdHTTP,
   LMDButtonControl, LMDCustomCheckBox, LMDDBCheckBox, System.JSON, IdSSLOpenSSL,
   Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uRESTDWBasicTypes, uRESTDWBasicDB, System.DateUtils, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, AdvSmoothPanel, ModernDateEdit;

type
   TFrmPesCad = class(TForm)
    timAlpha: TTimer;
    ACBrCEP: TACBrCEP;
    SouPess: TDataSource;
    TabPess: TRESTDWClientSQL;
    TabPessIDPess: TFDAutoIncField;
    TabPessTipoPes: TWideStringField;
    TabPessIDEsppes: TSmallintField;
    TabPessCpfCnpjPes: TWideStringField;
    TabPessNompes: TWideStringField;
    TabPessNomfanPes: TWideStringField;
    TabPessEndpes: TWideStringField;
    TabPessNroEnd: TWideStringField;
    TabPessCompEnd: TWideStringField;
    TabPessBaipes: TWideStringField;
    TabPessCeppes: TWideStringField;
    TabPessCodmun: TIntegerField;
    TabPessInsEstPes: TWideStringField;
    TabPessIndIseIE: TWideStringField;
    TabPessFonePes: TWideStringField;
    TabPessCelularPes: TWideStringField;
    TabPessEmailPes: TWideStringField;
    TabPessWebSitePes: TWideStringField;
    TabPessRGEPes: TWideStringField;
    TabPessRGEOrg: TWideStringField;
    TabPessRGEEst: TWideStringField;
    TabPessSexoPes: TWideStringField;
    TabPessIndNFDoc: TWideStringField;
    TabPessIDFilial: TIntegerField;
    TabPessIDNatfin: TIntegerField;
    TabPessNroRegProf: TWideStringField;
    TabPessConRegProf: TWideStringField;
    TabPessEstRegProf: TWideStringField;
    TabPessDatnasPes: TDateField;
    TabPessLongitude: TSingleField;
    TabPessLatitude: TSingleField;
    TabPessIDPlace: TWideStringField;
    TabPessCNAEPes: TWideStringField;
    TabPessOpcSim: TWideStringField;
    TabPessOpcMei: TWideStringField;
    TabPessTxtAviso: TWideStringField;
    TabPessDatcadPes: TDateTimeField;
    TabPessObspes: TWideMemoField;
    TabPessIndAtivo: TWideStringField;
    TabPessDatHorAlt: TDateTimeField;
    TabPessNommun: TWideStringField;
    TabPessEstmun: TWideStringField;
    TabPessDesEsppes: TWideStringField;
    TabPessDesnat: TWideStringField;
    PanelCadastro: TAdvSmoothPanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btVoltar: TAdvGlowButton;
    LMDLabel1: TLMDLabel;
    edInsEst: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    edDBNompes: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    edDBCep: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    edDBEndpes: TLMDDBLabeledEdit;
    edDBFone: TLMDDBLabeledEdit;
    edDBCelular: TLMDDBLabeledEdit;
    edDBCidpes: TLMDDBLabeledEdit;
    LMDDBLabeledEdit13: TLMDDBLabeledEdit;
    LMDDBLabeledEdit14: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    edIDEsppes: TLMDDBLabeledEdit;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    edTipoPes: TLMDLabeledListComboBox;
    edSexoPes: TLMDLabeledListComboBox;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBCheckBox1: TLMDDBCheckBox;
    CheckIseIE: TLMDDBCheckBox;
    PanelMed: TLMDSimplePanel;
    LMDDBLabeledListComboBox4: TLMDDBLabeledListComboBox;
    edCRMMed: TLMDDBLabeledEdit;
    LMDDBLabeledListComboBox1: TLMDDBLabeledListComboBox;
    PanelRG: TLMDSimplePanel;
    lbEmissor: TLMDDBLabeledListComboBox;
    lbEmissorUF: TLMDDBLabeledListComboBox;
    lbIdentidade: TLMDDBLabeledEdit;
    PanelDadCom: TLMDSimplePanel;
    PanelSubCad: TLMDSimplePanel;
    PnaelBasMenus: TLMDSimplePanel;
    Shape2: TShape;
    PanelMenFor: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    LMDSimplePanel1: TLMDSimplePanel;
    barselBut: TShape;
    btNovoItem: TAdvGlowButton;
    PanelButtons: TLMDSimplePanel;
    btNovo: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    btConta: TAdvGlowButton;
    btAutor: TAdvGlowButton;
    btConve: TAdvGlowButton;
    btUCont: TAdvGlowButton;
    btCredi: TAdvGlowButton;
    btTraba: TAdvGlowButton;
    btDadBan: TAdvGlowButton;
    btObser: TAdvGlowButton;
    btConFor: TAdvGlowButton;
    btPedEle: TAdvGlowButton;
    btNegoci: TAdvGlowButton;
    btBanFor: TAdvGlowButton;
    btObsFor: TAdvGlowButton;
    ModernDBDateEdit1: TModernDBDateEdit;
    procedure edCidpesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btVoltarClick(Sender: TObject);
    procedure TabPessAfterInsert(DataSet: TDataSet);
    procedure TabPessAfterRefresh(DataSet: TDataSet);
    procedure LMDDBLabeledEdit1Exit(Sender: TObject);
    procedure LMDDBLabeledListComboBox2Exit(Sender: TObject);
    procedure LMDDBLabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure edDBCepExit(Sender: TObject);
    procedure ACBrCEPBuscaEfetuada(Sender: TObject);
    procedure edDBFoneExit(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure edDBCidpesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btAbreFormsClick(Sender: TObject);
    procedure edIDEsppesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btNovoItemClick(Sender: TObject);
    procedure edIDEsppesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edIDEsppesExit(Sender: TObject);
    procedure LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit2DataChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LMDDBLabeledEdit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit4CustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    auxSQL:String;
    FormAtivo: TForm;
    procedure FechaSubForm;
    procedure SetMaskCPFCNPJ(recCampo: String);
    procedure AbreSubForm(NomeForm: String; MostraAdd:Boolean; NewReg:Boolean = False);
    function  Salvar: Boolean;
    function  VerificaCPFCNPJ: Boolean;
    function  VerificaFone(recFone: String): Boolean;
    function  VerificaCEP: Boolean;
    procedure QuadroProf;
  public
    { Public declarations }
    recIDPess,recEsppes:Integer;
    recCampo,recValor,recOrigem, recNompes: String;
  end;

var
   FrmPesCad: TFrmPesCad;
   basIDPess: Integer = 0;
   TabAtual: TRESTDWClientSQL;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessConta, uPessAutor, uPessConv, uPessCred,
     uPessTraba, uPessUsoCont, uPessObser, uPessBanc,  uPessNego;

procedure TFrmPesCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesCad.FormShow(Sender: TObject);
begin
   PanelRG.Top      := PanelMed.Top;
   PanelRG.Left     := PanelMed.Left;
   PanelRG.Visible  := True;
   PanelMed.Visible := False;
   SouPess.DataSet  := nil;
   if TabPess.Active then TabPess.Close;
   auxSQL := 'SELECT PES.*,MUN.Nommun,MUN.Estmun,ESP.DesEsppes,NAT.Desnat FROM arqpessoa PES '+
   'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun LEFT JOIN arqesppes ESP ON PES.IDEsppes = ESP.IDEsppes '+
   'LEFT JOIN arqnatfin NAT ON PES.IDNatfin = NAT.IDNatFin ';
   TabPess.SQL.Text := auxSQL + iif(recIDPess > 0,' WHERE PES.IDPess = '+recIDPess.ToString,'')+' LIMIT 1';
   TabPess.Open;
   if recIDPess <= 0 then
   begin
      TabPess.Append;
      if recEsppes = 2 then
      begin
         TabPessIDEsppes.Value  := recEsppes;
         TabPessDesEsppes.Value := 'FORNECEDOR';
      end;
      if recCampo = 'CpfCnpjPes' then SetMaskCPFCNPJ(recCampo)
      else TabPessCpfCnpjPes.EditMask := '';
      if (recCampo <> '') and (recCampo <> 'IDPess') then TabPess.FieldByName(recCampo).AsString := recValor;
   end else
   begin
      edIDEsppesExit(Self);
      LMDDBLabeledListComboBox2Exit(Self);
      SetMaskCPFCNPJ(TabPessCpfCnpjPes.Value);
      AbreSubForm('Conta',btConta.Tag = 1);
   end;
   SouPess.DataSet := TabPess;
   edTipoPes.ItemIndex := TabPessTipoPes.AsInteger;
   edSexoPes.ItemIndex := TabPessSexoPes.AsInteger;
   LMDDBLabeledEdit1.SetFocus;
   keybd_event(VK_TAB, 0, 0, 0);   
end;

// ------------ Valida CPF / CNPJ do Cadastro ------------ //
function TFrmPesCad.VerificaCPFCNPJ: Boolean;
var
   Resultado:Boolean;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   QuadroProf;

   if (Length(TabPessCpfCnpjPes.Value) = 11) or (Length(TabPessCpfCnpjPes.Value) = 14) then
   begin
      if Length(TabPessCpfCnpjPes.Value) = 14 then
           Resultado := CNPJ(TabPessCpfCnpjPes.Value)
      else Resultado := CPF (TabPessCpfCnpjPes.Value);
      if not Resultado then
      begin
         MostraMsg('Verifique o '+iif(Length(TabPessCpfCnpjPes.Value) = 14,'CNPJ','CPF'), iif(Length(TabPessCpfCnpjPes.Value) = 14, 'CNPJ','CPF') + ' não é válido!', mtWarning, [mbOk]);
         LMDDBLabeledEdit1.SetFocus;
         Exit;
      end;
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         QueAuxi.DataBase := DM.DWDataBase;
         QueAuxi.SQL.Text := 'SELECT IDPess FROM arqpessoa WHERE IDPess != '+iif(TabPessIDPess.Value > 0, TabPessIDPess.AsString,'-1');
         QueAuxi.SQL.Add(' AND CpfCnpjPes = ' + Aspas(TabPessCpfCnpjPes.Value));
         QueAuxi.Open;
         if not QueAuxi.Eof then
         begin
            MostraMsg('Verifique o '+iif(Length(TabPessCpfCnpjPes.Value) = 14,'CNPJ', 'CPF'), iif(Length(TabPessCpfCnpjPes.Value) = 14,'CNPJ','CPF')+' já cadastrado para outro convênio!', mtWarning, [mbOk]);
            LMDDBLabeledEdit1.SetFocus;
            Exit;
         end
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; // if
   Result := True;
end;

procedure TFrmPesCad.LMDDBLabeledEdit1Exit(Sender: TObject);
begin
   if not TabPess.Active then Exit;
   if not (TabPess.State in dsEditModes) then TabPess.Edit;
   SetMaskCPFCNPJ(TabPessCpfCnpjPes.Value);
   LMDDBLabeledListComboBox2Exit(Self);
   if (TabPessCpfCnpjPes.AsString.Trim = '') or (EliminaCaracteres(TabPessCpfCnpjPes.AsString, ' 0') = '') then
   begin
      TabPessCpfCnpjPes.Clear;
      Exit;
   end;
   VerificaCPFCNPJ;
   if TabPessIDEsppes.Value in [4,10] then
   begin
      PanelMed.SetFocus;
      Exit;
   end else
   if Length(OnlyNumbers(TabPessCpfCnpjPes.Value)) = 14 then
   begin
      edInsEst.Visible   := True;
      CheckIseIE.Visible := True;
      edInsEst.SetFocus;
   end else
   begin
      PanelRG.SetFocus;
      Exit;
   end;
end;

procedure TFrmPesCad.LMDDBLabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
   if not(Key in ['0'..'9',#8]) then Key := #0;
end;

procedure TFrmPesCad.LMDDBLabeledEdit2DataChange(Sender: TObject);
begin
   if LMDDBLabeledEdit2.Field <> nil then
   begin
      if LMDDBLabeledEdit2.Field.FieldName = 'IDPess' then
      begin
         if TabPessIDPess.AsInteger > 0 then
              LMDDBLabeledEdit2.DataField := 'IDPess'
         else LMDDBLabeledEdit2.DataField := '';
      end;
   end; //if
end;

procedure TFrmPesCad.LMDDBLabeledEdit4CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabPess,'arqnatfin',TDBEdit(LMDDBLabeledEdit4),'IDNatFin','IDNatFin','Desnat','Desnat','',0);
end;

procedure TFrmPesCad.LMDDBLabeledEdit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabPess,'arqnatfin',TDBEdit(LMDDBLabeledEdit4),'IDNatFin','IDNatFin','Desnat','Desnat','',Key);
end;

// ---------------- Valida CEP ---------------- //
function TFrmPesCad.VerificaCEP: Boolean;
begin
   Result := False;
   if (Length(TabPessCeppes.AsString) < 8) and (TabPessCeppes.AsString.Trim <> '') then
   begin
      MostraMsg('CEP inválido', 'Confirme o número do CEP!', mtError, [mbOk]);
      edDBCep.SetFocus;
      Exit;
   end;
   Result := True;
end;

procedure TFrmPesCad.edDBCepExit(Sender: TObject);
begin
   if not VerificaCEP then Exit;
   try
      if (TabPessCeppes.AsString <> TabPessCeppes.OldValue) and (Trim(TabPessCeppes.AsString) <> '') then
         ACBrCEP.BuscarPorCEP(TabPessCeppes.AsString);
   except
      MostraMsg('CEP inválido', 'Confirme o número do CEP!', mtError, [mbOk]);
      edDBCep.SetFocus;
      Exit;
   end;
end;

procedure TFrmPesCad.ACBrCEPBuscaEfetuada(Sender: TObject);
begin
   with ACBrCEP do
   begin
      if Enderecos.Count > 0 then
      begin
         if not(TabPess.State in dsEditModes) then TabPess.Edit;
         TabPessEndpes.Value := AnsiUpperCase(iif(Trim(Enderecos[0].Logradouro) <> '',Enderecos[0].Logradouro, TabPessEndpes.Value));
         TabPessBaipes.Value := AnsiUpperCase(iif(Trim(Enderecos[0].Bairro)     <> '',Enderecos[0].Bairro, TabPessBaipes.Value));
         TabPessCodmun.Value := StrToInt(Enderecos[0].IBGE_Municipio);
         TabPessNommun.Value := UpperCase(Enderecos[0].Municipio);
         TabPessEstmun.Value := Enderecos[0].UF;
      end
      else MostraMsg('CEP inválido', 'Número de CEP não foi encontrado',mtError, [mbOk]);
   end; // with
end;

// -------------- Valida Fone Fixo ou Celular -------------- //
function TFrmPesCad.VerificaFone(recFone: String): Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if Trim(TabPess.FieldByName(recFone).AsString) <> '' then
   begin
      if recFone = 'FonePes' then
      begin
         if not ValidaFoneFixo(TabPess.FieldByName(recFone).AsString.Trim)
         then
         begin
            MostraMsg('Fone inválido', 'Confirme o número do Fone!',mtError, [mbOk]);
            edDBFone.SetFocus;
            Exit;
         end;
      end else
      begin
         if not ValidaCelular(TabPess.FieldByName(recFone).AsString.Trim) then
         begin
            MostraMsg('Celular inválido', 'Confirme o número do Celular!',mtError, [mbOk]);
            edDBCelular.SetFocus;
            Exit;
         end;
      end; //if
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            QueAuxi.SQL.Text := 'SELECT IDPess,Nompes,'+recFone+' FROM arqpessoa WHERE IDPess != ' + iif(TabPessIDPess.Value > 0,TabPessIDPess.AsString, '-1');
            QueAuxi.SQL.Add(' AND '+recFone+' = '+Aspas(TabPess.FieldByName(recFone).AsString.Trim));
            Open;
            if not IsEmpty then
               MostraMsg('Número usado', 'Número de Fone ou celular já usado para outra pessoa.', mtError, [mbOk]);
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
   Result := True;
end;

procedure TFrmPesCad.edDBFoneExit(Sender: TObject);
begin
   VerificaFone(TLMDDBLabeledEdit(Sender).DataField);
end;

procedure TFrmPesCad.edIDEsppesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabPess,'arqesppes',TDBEdit(edIDEsppes),'IDEsppes','IDEsppes','DesEsppes','DesEsppes', '', Key);
end;

procedure TFrmPesCad.edIDEsppesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabPess,'arqesppes',TDBEdit(edIDEsppes),'IDEsppes','IDEsppes','DesEsppes','DesEsppes', '', 0);
   FechaSubForm;
   edIDEsppesExit(Self);
end;

// --------- Mostra Campos Para Ins.Estadual ou RG / Fornecedor --------- //
procedure TFrmPesCad.edIDEsppesExit(Sender: TObject);
begin
   if TabPessIDEsppes.Value in [2,3] then
   begin
      PanelMenCli.Visible := False;
      PanelMenFor.Visible := True;
   end else
   begin
      PanelMenCli.Visible := True;
      PanelMenFor.Visible := False;
   end;
   if TabPessIDEsppes.Value in [4,10] then
   begin
      PanelMed.Visible   := True;
      PanelRG.Visible    := False;
      edInsEst.Visible   := False;
      CheckIseIE.Visible := False;
   end;
end;

procedure TFrmPesCad.LMDDBLabeledListComboBox2Exit(Sender: TObject);
begin
   if (TabPessTipoPes.Value = 'PROD. RURAL') or (Length(TabPessCpfCnpjPes.Value) = 14) then
   begin
      PanelRG.Visible    := False;
      PanelMed.Visible   := False;
      edCRMMed.Visible   := False;
      edInsEst.Visible   := True;
      CheckIseIE.Visible := True;
      edInsEst.SetFocus;
   end
   else QuadroProf;
end;

procedure TFrmPesCad.QuadroProf;
begin
   if TabPessIDEsppes.Value in [4,10] then
   begin
      PanelMed.Visible   := True;
      PanelRG.Visible    := False;
      edInsEst.Visible   := False;
      CheckIseIE.Visible := False;
   end else
   begin
      PanelRG.Top        := PanelMed.Top;
      PanelRG.Left       := PanelMed.Left;
      PanelRG.Visible    := True;
      PanelMed.Visible   := False;
      edInsEst.Visible   := False;
      CheckIseIE.Visible := False;

   end;
   if (Length(OnlyNumbers(TabPessCpfCnpjPes.Value)) = 14) or (Length(OnlyNumbers(LMDDBLabeledEdit1.Text)) = 14) then
   begin
      PanelRG.Visible    := False;
      PanelMed.Visible   := False;
      edInsEst.Visible   := True;
      CheckIseIE.Visible := True;
   end;
end;

procedure TFrmPesCad.SetMaskCPFCNPJ(recCampo: String);
begin
   if TabPess.State in dsEditModes then
   begin
      if Length(recCampo)      = 11 then TabPessCpfCnpjPes.EditMask := '###.###.###-##;0;_'
      else if Length(recCampo) = 14 then TabPessCpfCnpjPes.EditMask := '##.###.###/####-##;0;_'
      else TabPessCpfCnpjPes.EditMask := '';
   end;
end;

procedure TFrmPesCad.TabPessAfterInsert(DataSet: TDataSet);
begin
   if recOrigem <> 'PROD' then
   begin
      TabPessDesEsppes.Value := 'CLIENTE';
      TabPessIDEsppes.Value  := 1;
   end else
   begin
      TabPessDesEsppes.Value := 'FABRICANTE';
      TabPessIDEsppes.Value  := 3;
   end;
   edTipoPes.ItemIndex    := 0;
   edSexoPes.ItemIndex    := 0;
   TabPessTipoPes.Value   := '0';
   TabPessSexoPes.Value   := '0';
   TabPessIndNFDoc.Value  := '0';
   TabPessOpcSim.Value    := '1';
   TabPessOpcMei.Value    := '1';
   TabPessIndAtivo.Value  := '1';
   TabPessIndIseIE.Value  := '0';
   TabPessDatcadPes.Value := DataServer;
end;

procedure TFrmPesCad.TabPessAfterRefresh(DataSet: TDataSet);
begin
   if TabPess.State in dsEditModes then
   begin
      if TabPessCpfCnpjPes.AsString.Length = 11      then TabPessCpfCnpjPes.EditMask := '###.###.###-##;0;_'
      else if TabPessCpfCnpjPes.AsString.Length = 14 then TabPessCpfCnpjPes.EditMask := '##.###.###/####-##;0;_'
      else TabPessCpfCnpjPes.EditMask := '';
   end;
end;

procedure TFrmPesCad.timAlphaTimer(Sender: TObject);
begin
   CentralizarControl(PanelCadastro, Self);
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmPesCad.edCidpesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabPess,'arqmuni',TDBEdit(edDBCidpes),'Codmun','Codmun','Nommun','Nommun','',0);
end;

procedure TFrmPesCad.edDBCidpesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabPess,'arqmuni',TDBEdit(edDBCidpes),'Codmun','Codmun','Nommun','Nommun','',Key);
end;

procedure TFrmPesCad.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmPesCad.Salvar:Boolean;
var
   retID,antID:Integer;
   FocusObject:TWinControl;
   DBEditErro:TLMDDBLabeledEdit;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabPess.State in dsEditModes then
   begin
      Result := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;
      if TabPessNompes.AsString.Trim.Length < 3 then DBEditErro := edDBNompes else
      if TabPessEndpes.AsString.Trim.Length < 1 then DBEditErro := edDBEndpes else
      if TabPessCodmun.Value <= 0 then DBEditErro := edDBCidpes;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if
      if (LMDDBLabeledEdit14.Text.Trim <> '') and (not ValidarEmail(LMDDBLabeledEdit14.Text.Trim)) then
      begin
         MostraMsg('Email inválido!', 'Verifique o formato do EMail!',mtError, [mbOk]);
         LMDDBLabeledEdit14.SetFocus;
         Exit
      end;
      if not VerificaCPFCNPJ then Exit;
      if not VerificaCEP     then Exit;
      if (TabPessIDEsppes.Value = 4) or (TabPessIDEsppes.Value = 10) then
      begin
         if (TabPessConRegProf.AsString.Trim = '') or (TabPessNroRegProf.AsString.Trim = '') or (TabPessEstRegProf.AsString.Trim = '') then
         begin
            MostraMsg('Dados Profissionais', 'Complete todos os dados do profissonal.',mtWarning, [mbOk]);
            LMDDBLabeledListComboBox1.SetFocus;
            Exit;
         end;
      end; //if
      if not VerificaFone('FonePes')    then Exit;
      if not VerificaFone('CelularPes') then Exit;
      if TabPessCelularPes.AsString.Trim = '' then
      begin
         if MostraMsg('Confirmação','Tem certeza que não entrará com o CELULAR?', mtConfirmation,[mbYes, mbNo]) = mrNo then
         begin
            edDBCelular.SetFocus;
            Exit;
         end;
      end; //if

      TabPessSexoPes.AsString := edSexoPes.ItemIndex.ToString;
      TabPessTipoPes.AsString := edTipoPes.ItemIndex.ToString;
      TabPessCpfCnpjPes.Value := OnlyNumBers(TabPessCpfCnpjPes.Value);
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            antID := iif(TabPess.State = dsEdit, TabPessIDPess.Value, -1);
            retID := MyApplayUpdates(TabPess, 'IDPess', 'IDPess = '+recIDPess.ToString, TabPess.State);
            if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
            recIDPess := iif(TabPess.State = dsEdit, antID, retID);
            recNompes := TabPessNompes.AsString;
            TabPess.DisableControls;
            TabPess.Cancel;
            TabPess.Close;
            TabPess.SQL.Text := auxSQL+' WHERE PES.IDPess = '+recIDPess.ToString;
            TabPess.Open;
            TabPess.EnableControls;
            PanelRG.Top  := PanelMed.Top;
            PanelRG.Left := PanelMed.Left;
            PanelRG.Visible  := True;
            PanelMed.Visible := False;
            if recOrigem = 'PROD' then Self.Close;
            AbreSubForm('Conta',btConta.Tag = 1);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Pessoa -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
      PanelCadastro.Visible := False;
      Sleep(10);
      PanelCadastro.Visible := True;
   end; //if
   Result := True;
end;

procedure TFrmPesCad.btNovoClick(Sender: TObject);
begin
   if TabPess.State in dsEditModes then TabPess.Cancel;
   FechaSubForm;
   TabPess.Append;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmPesCad.btNovoItemClick(Sender: TObject);
begin
   if TabAtual.State <> dsInsert then TabAtual.Append;
end;

procedure TFrmPesCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabPess.State <> dsInsert) and (TabPessIDPess.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT Nroped FROM arqpedido WHERE IDPess = '+TabPessIDPess.AsString+' LIMIT 1';
            Open;
            if not IsEmpty then
            begin
               MostraMsg('Não pode ser excluído','Já existem vendas para esta pessoa!', mtInformation, [mbOk]);
               Exit;
            end;
            if MostraMsg('Confirmação','Confirma exclusão de TODOS dados desta pessoa?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqpessoa   WHERE IDPess = '+TabPessIDPess.AsString+';');
                  SQL.Add('DELETE FROM arqpessasso WHERE IDPess = '+TabPessIDPess.AsString+';');
                  SQL.Add('DELETE FROM arqpessauto WHERE IDPess = '+TabPessIDPess.AsString+';');
                  SQL.Add('DELETE FROM arqpessconv WHERE IDPess = '+TabPessIDPess.AsString+';');
                  SQL.Add('DELETE FROM arqpessbanc WHERE IDPess = '+TabPessIDPess.AsString+';');
                  SQL.Add('DELETE FROM arqpessucon WHERE IDPess = '+TabPessIDPess.AsString+';');
                  SQL.Add('DELETE FROM arqpesstrab WHERE IDPess = '+TabPessIDPess.AsString+';');
                  ExecSQL;
               except
                  on E: Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqpessoa, IDPess = '+TabPessIDPess.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQPESSOA IDPess = '+TabPessIDPess.AsString + ' - ' + TabPessNompes.AsString);
               Self.Close;
            end; // if
         end; // with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end else
   begin
      if TabPess.State in dsEditModes then TabPess.Cancel;
      Self.Close;
   end;
end;

procedure TFrmPesCad.btAbreFormsClick(Sender: TObject);
begin
   AbreSubForm(Trim(Copy(TAdvGlowButton(Sender).Name,3,6)),TAdvGlowButton(Sender).Tag = 1);
   barselBut.Left  := TAdvGlowButton(Sender).Left;
   barselBut.Width := TAdvGlowButton(Sender).Width;
end;

// ----------- Abre Sub Formulários ----------- //
procedure TFrmPesCad.AbreSubForm(NomeForm: String; MostraAdd:Boolean; NewReg:Boolean = False);
var
   TFormAtivo:TFormClass;
begin
   if TabPess.State in dsEditModes then
      if not Salvar then Exit;
   btNovoItem.Visible := MostraAdd;
   basIDPess := TabPessIDPess.Value;
   FechaSubForm;
   if NomeForm = 'Conta'  then TFormAtivo := TFrmPesConta else
   if NomeForm = 'Autor'  then TFormAtivo := TFrmPesAutor else
   if NomeForm = 'Conve'  then TFormAtivo := TFrmPesConv  else
   if NomeForm = 'Credi'  then TFormAtivo := TFrmPesCred  else
   if NomeForm = 'Traba'  then TFormAtivo := TFrmPesTraba else
   if NomeForm = 'UCont'  then TFormAtivo := TFrmPesUCon  else
   if NomeForm = 'Obser'  then TFormAtivo := TFrmPesObser else
   if NomeForm = 'ConFor' then TFormAtivo := TFrmPesConta else
   if NomeForm = 'ObsFor' then TFormAtivo := TFrmPesObser else
   if NomeForm = 'DadBan' then TFormAtivo := TFrmPesBanc  else
   if NomeForm = 'Negoci' then TFormAtivo := TFrmPesNego  else
   if NomeForm = 'BanFor' then TFormAtivo := TFrmPesBanc  else Exit;
   FormAtivo := TFormAtivo.Create(Application);
   FormAtivo.Parent := PanelSubCad;
   FormAtivo.Show;
end;

procedure TFrmPesCad.LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
var
  HTTP: TIdHTTP;
  QueAuxi: TRESTDWClientSQL;
  Response, CNPJ, MsgErr: string;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  JSONObj: TJSONObject;
  DtIni: TDateTime;

  function JsonStr(const Obj: TJSONObject; const Name: string): string;
  var
     V:TJSONValue;
  begin
     V := Obj.GetValue(Name);
     if Assigned(V) then
          Result := V.Value
     else Result := '';
  end;
  function JsonInt64(const Obj: TJSONObject; const Name: string): Int64;
  var
     V: TJSONValue;
  begin
     V := Obj.GetValue(Name);
     if Assigned(V) then
         Result := StrToInt64Def(V.Value, 0)
    else Result := 0;
  end;

  function TryISO8601Date(const S: string; out D: TDateTime): Boolean;
  begin
     Result := TryISO8601ToDate(S, D); // Datas vêm como YYYY-MM-DD; evita depender de formato regional
  end;

var
   Municipio, UF: string;
begin
   CNPJ := OnlyNumbers(LMDDBLabeledEdit1.Text);
   if Length(CNPJ) <> 14 then
   begin
      MostraMsg('Aviso', 'Somente para Pessoas jurídicas!', mtWarning, [mbOk]);
      Exit;
   end;
   QuadroProf;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   HTTP    := TIdHTTP.Create(nil);
   SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(HTTP);
   JSONObj    := nil;
   try
      SSLHandler.SSLOptions.Method := sslvTLSv1_2;
      SSLHandler.SSLOptions.Mode   := sslmClient;
      HTTP.IOHandler := SSLHandler;
      HTTP.Request.Accept := 'application/json';
      HTTP.Request.UserAgent := 'Delphi-Indy-Client';

      try
         Response := HTTP.Get('https://brasilapi.com.br/api/cnpj/v1/' + CNPJ);
         JSONObj := TJSONObject.ParseJSONValue(Response) as TJSONObject;
         if not Assigned(JSONObj) then raise Exception.Create('Resposta JSON inválida da BrasilAPI.');
         if not (TabPess.State in dsEditModes) then TabPess.Edit;

         TabPessNompes.Value    := JsonStr(JSONObj, 'razao_social');
         TabPessNomfanPes.Value := JsonStr(JSONObj, 'nome_fantasia');
         TabPessEndpes.Value    := Trim(JsonStr(JSONObj, 'descricao_tipo_de_logradouro') + ' ' + JsonStr(JSONObj, 'logradouro'));
         TabPessNroEnd.Value    := JsonStr(JSONObj, 'numero');
         TabPessCompEnd.Value   := JsonStr(JSONObj, 'complemento');
         TabPessBaipes.Value    := JsonStr(JSONObj, 'bairro');
         TabPessCeppes.Value    := JsonStr(JSONObj, 'cep');
         TabPessCNAEPes.Value   := IntToStr(JsonInt64(JSONObj, 'cnae_fiscal'));

         if TryISO8601Date(JsonStr(JSONObj, 'data_inicio_atividade'), DtIni) then  TabPessDatnasPes.Value := DtIni;
         Municipio := JsonStr(JSONObj, 'municipio');
         UF := JsonStr(JSONObj, 'uf');
         TabPessNommun.Value := Municipio;
         TabPessEstmun.Value := UF;

         // Busca Codmun pela sua tabela local (mantido do seu fluxo)
         try
            if Municipio <> '' then
            begin
               QueAuxi.DataBase := DM.DWDataBase;
               QueAuxi.SQL.Text := 'SELECT Codmun FROM arqmuni WHERE Nommun = ' + Trim(Aspas(Municipio));
               QueAuxi.Open;
               if not QueAuxi.IsEmpty then TabPessCodmun.Value := QueAuxi.FieldByName('Codmun').AsInteger;
            end;
         except
         end;
      except
         on E: EIdHTTPProtocolException do
         begin
            MsgErr := '';
            case HTTP.ResponseCode of
               400: MsgErr := 'CNPJ inválido ou mal formatado.';
               404: MsgErr := 'CNPJ não encontrado na API Minha Receita (BrasilAPI).';
               429: MsgErr := 'Limite de solicitações excedido para este período.';
               500: MsgErr := 'Erro ao processar a solicitação na API.';
            else MsgErr := Format('Erro HTTP %d: %s', [HTTP.ResponseCode, E.Message]);
            end;
            MostraMsg('Aviso', MsgErr, mtWarning, [mbOk]);
         end;
         on E:Exception do
         begin
            MostraMsg('Erro', 'Falha ao consultar CNPJ: ' + E.Message, mtError, [mbOk]);
         end;
      end;
   finally
     QueAuxi.Close;
     FreeAndNil(QueAuxi);
     FreeAndNil(JSONObj);
     FreeAndNil(SSLHandler);
     FreeAndNil(HTTP);
   end;
end;

// -------------- Busca Dados Pessoa Jurídica ---- api.cnpjs.dev --------- //
{procedure TFrmPesCad.LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
var
   HTTP:TIdHTTP;
   QueAuxi:TRESTDWClientSQL;
   Response,auxDatnas,CNPJ,MsgErr:String;
   SSLHandler:TIdSSLIOHandlerSocketOpenSSL;
   JSONObj,JSONEndereco,JSONCNAE:TJSONObject;
begin
   CNPJ := OnlyNumbers(LMDDBLabeledEdit1.Text);
   if Length(CNPJ) <> 14 then
   begin
      MostraMsg('Aviso', 'Somente para Pessoas jurídicas!',mtWarning, [mbOk]);
      Exit;
   end;
   QuadroProf;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   HTTP    := TIdHTTP.Create(nil);
   SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(HTTP);
   try
      SSLHandler.SSLOptions.Method := sslvTLSv1_2;
      SSLHandler.SSLOptions.Mode   := sslmClient;
      HTTP.IOHandler := SSLHandler;
      try
         Response := HTTP.Get('https://api.cnpjs.dev/v1/'+CNPJ);
         JSONObj  := TJSONObject.ParseJSONValue(Response) as TJSONObject;
         JSONCNAE := JSONObj.GetValue<TJSONObject>('cnae_fiscal_principal');
         JSONEndereco := JSONObj.GetValue<TJSONObject>('endereco');
         if not (TabPess.State in dsEditModes) then TabPess.Edit;
         auxDatnas := JSONObj.GetValue('data_inicio_atividade').Value;
         auxDatnas := Copy(auxDatnas,9,2)+'/'+Copy(auxDatnas,6,2)+'/'+Copy(auxDatnas,1,4);
         TabPessNompes.Value    := JSONObj.GetValue<string>('razao_social');
         TabPessNomfanPes.Value := JSONObj.GetValue<string>('nome_fantasia');
         TabPessEndpes.Value    := JSONEndereco.GetValue<string>('tipo_logradouro')+' '+JSONEndereco.GetValue<string>('logradouro');
         TabPessNroEnd.Value    := JSONEndereco.GetValue<string>('numero');
         TabPessCompEnd.Value   := JSONEndereco.GetValue<string>('complemento');
         TabPessBaipes.Value    := JSONEndereco.GetValue<string>('bairro');
         TabPessDatnasPes.Value := StrToDate(auxDatnas);
         TabPessCeppes.Value    := JSONEndereco.GetValue<string>('cep');
         TabPessCeppes.Value    := JSONEndereco.GetValue<string>('cep');
         TabPessCNAEPes.Value   := JSONCNAE.GetValue<string>('codigo');
         try
            QueAuxi.DataBase := DM.DWDataBase;
            QueAuxi.SQL.Text := 'SELECT Codmun FROM arqmuni WHERE Nommun = '+Trim(Aspas(JSONEndereco.GetValue<string>('municipio')));
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
            begin
               TabPessCodmun.Value := QueAuxi.FieldByName('Codmun').AsInteger;
               TabPessNommun.Value := JSONEndereco.GetValue<string>('municipio');
               TabPessEstmun.Value := JSONEndereco.GetValue<string>('uf');
            end;
         except
         end;
      except
         on E:EIdHTTPProtocolException do
         begin
           MsgErr := '';
           case HTTP.ResponseCode of
              400: MsgErr := 'A solicitação foi malformada ou um parâmetro faltando.';
              401: MsgErr := 'A solicitação não incluiu as credenciais necessárias.';
              403: MsgErr := 'Sem permissão para acessar a API.';
              404: MsgErr := 'CNPJ não foi encontrado.';
              429: MsgErr := 'Limite de solicitações para este período foi atingido.';
              500: MsgErr := 'Erro ao processar a solicitação.';
           end;
           MostraMsg('Aviso', MsgErr,mtWarning, [mbOk]);
        end;
      end;
   finally
      SSLHandler.Free;
      JSONObj.Free;
      HTTP.Free;
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end; }

// ----------- Fecha Formulários ----------- //
procedure TFrmPesCad.FechaSubForm;
begin
   if Assigned(FormAtivo) then
   begin
      FormAtivo.Close;
      FreeAndNil(FormAtivo);
   end;
end;

procedure TFrmPesCad.btVoltarClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmPesCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmPesCad.FormPaint(Sender: TObject);
begin
  DrawGradientBackground(Canvas, ClientRect);
end;

procedure TFrmPesCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   QueAuxi:TRESTDWClientSQL;
begin
   CanClose := True;
   if (TabPessIDEsppes.Value = 1) and (TabPessCpfCnpjPes.AsString.Trim <> '') then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqpessconv WHERE IDPess = '+TabPessIDPess.AsString;
            QueAuxi.Open;
            if QueAuxi.IsEmpty then
            begin
               MostraMsg('Aviso', 'Favor associar o cliente à um convênio!',mtError, [mbOk]);
               AbreSubForm('Conve',btConve.Tag = 1);
               CanClose := False;
               Exit;
            end;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar verificar existencia de convênios unit: arqpessoa (uPessoasCad), IDPess = '+TabPessIDPess.AsString+' -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível efetivar verificar a existência de convênios associado!',mtError, [mbOk]);
               CanClose := False;
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
end;

procedure TFrmPesCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaSubForm;
   if TabPess.Active then
   begin
      if recOrigem <> 'CAD' then
      begin
        recIDPess := TabPessIDPess.AsInteger;
        recNompes := TabPessNompes.AsString;
      end;
      TabPess.Close;
   end;
   FadeInOut(Self,'Out',10);
   if recOrigem = 'CAD' then
      SimularCliqueControlePorNome('FrmPessoas','edbusca');
   Action := caFree;
end;

end.



