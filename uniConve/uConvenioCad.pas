unit uConvenioCad;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes,Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, AdvEdit, LMDCustomPanel, LMDDBEdit,
   LMDSimplePanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
   LMDLabel, RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseLabel,
   LMDBaseGraphicControl, LMDCustomLabel, LMDCustomBevelPanel, Vcl.DBCtrls,
   Vcl.ExtCtrls, AdvGlowButton, MarcLib, Data.DB, LMDButtonControl,
   LMDCustomCheckBox, LMDDBCheckBox, LMDCustomExtSpinEdit,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS,
   uRESTDWBasicDB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, LMDEdit,
   uRESTDWBasicTypes, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox,
   LMDDBListComboBox, LMDDBExtSpinEdit, AdvSmoothPanel, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
   TFrmConvCad = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    edPessoa: TLMDDBLabeledEdit;
    timAlpha: TTimer;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    LMDDBCheckBox3: TLMDDBCheckBox;
    LMDDBCheckBox4: TLMDDBCheckBox;
    LMDDBCheckBox6: TLMDDBCheckBox;
    LMDDBCheckBox1: TLMDDBCheckBox;
    LMDDBCheckBox2: TLMDDBCheckBox;
    LMDDBCheckBox7: TLMDDBCheckBox;
    LMDDBCheckBox8: TLMDDBCheckBox;
    LMDDBCheckBox9: TLMDDBCheckBox;
    LMDDBCheckBox10: TLMDDBCheckBox;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btVoltar: TAdvGlowButton;
    LMDLabel5: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDDBLabeledEdit12: TLMDDBLabeledEdit;
    LMDDBLabeledEdit15: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    edDesconto: TLMDDBLabeledEdit;
    TabConv: TRESTDWClientSQL;
    SouConv: TDataSource;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDDBCheckBox11: TLMDDBCheckBox;
    LMDDBLabeledListComboBox3: TLMDDBLabeledListComboBox;
    LMDDBLabeledEdit14: TLMDDBLabeledEdit;
    LMDDBLabeledEdit16: TLMDDBLabeledEdit;
    edSenha: TLMDEdit;
    LMDLabel7: TLMDLabel;
    TabConvIDConv: TFDAutoIncField;
    TabConvNomcon: TWideStringField;
    TabConvIDPessPri: TIntegerField;
    TabConvTipConv: TWideStringField;
    TabConvDiaFecha: TSmallintField;
    TabConvDiaVence: TSmallintField;
    TabConvPerJurAtr: TFloatField;
    TabConvIndDesVenVis: TWideStringField;
    TabConvIndDesVenPra: TWideStringField;
    TabConvIndRepCom: TWideStringField;
    TabConvIndPreProm: TWideStringField;
    TabConvIndDesProg: TWideStringField;
    TabConvIndLibLim: TWideStringField;
    TabConvIndSolSen: TWideStringField;
    TabConvIndVenVis: TWideStringField;
    TabConvIndVenPra: TWideStringField;
    TabConvIndPonFid: TWideStringField;
    TabConvNroDiaCar: TSmallintField;
    TabConvNroMaxPar: TSmallintField;
    TabConvPraParBlo: TSmallintField;
    TabConvLimCreCli: TFloatField;
    TabConvVlrMinCup: TFloatField;
    TabConvObsNFC: TWideStringField;
    TabConvIDDesc: TIntegerField;
    TabConvObscon: TWideStringField;
    TabConvDatcadCon: TDateTimeField;
    TabConvIndAtivo: TWideStringField;
    TabConvEmailWeb: TWideStringField;
    TabConvSenhaWeb: TWideStringField;
    TabConvNompes: TWideStringField;
    TabConvDesDesc: TWideStringField;
    LMDDBLabeledExtSpinEdit1: TLMDDBLabeledExtSpinEdit;
    LMDDBLabeledExtSpinEdit2: TLMDDBLabeledExtSpinEdit;
    btFiliais: TAdvGlowButton;
    btCliAti: TAdvGlowButton;
    btLimita: TAdvGlowButton;
    btConfBol: TAdvGlowButton;
    TabConvCodban: TIntegerField;
    TabConvAgeBco: TWideStringField;
    TabConvDigAgeBco: TWideStringField;
    TabConvContaBco: TWideStringField;
    TabConvDigitoBco: TWideStringField;
    TabConvCodCedBco: TWideStringField;
    TabConvCodTraBco: TWideStringField;
    TabConvMaxNroBco: TIntegerField;
    TabConvModCobBco: TWideStringField;
    TabConvCarCobBco: TWideStringField;
    TabConvAceiteBco: TBooleanField;
    TabConvPerMulBco: TFloatField;
    TabConvNomban: TWideStringField;
    TabConvUltNosNBco: TIntegerField;
    TabConvPerMorBco: TFloatField;
    TabConvIndDelete: TWideStringField;
    TabConvIndDelWeb: TWideStringField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btVoltarClick(Sender: TObject);
    procedure TabConvAfterInsert(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDescontoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDescontoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit2Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btLimitaClick(Sender: TObject);
    procedure btCliAtiClick(Sender: TObject);
    procedure edPessoaExit(Sender: TObject);
    procedure LMDDBLabeledEdit16Exit(Sender: TObject);
    procedure btFiliaisClick(Sender: TObject);
    procedure LMDDBLabeledExtSpinEdit1Exit(Sender: TObject);
    procedure btConfBolClick(Sender: TObject);
   private
      { Private declarations }
      function Salvar: Boolean;
      function VerifCliResp:Boolean;
   public
      { Public declarations }
      RctAuxi:TRect;
      recIDConv:Integer;
      auxSQL,recCampo,recValor:String;
      FPainelOrigem: TAdvSmoothPanel;
   end;

var
   FrmConvCad:TFrmConvCad;
   basIDConv:Integer = 0;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uConvGru, uConvCli, uConvFil, uConvBol;

procedure TFrmConvCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmConvCad.FormShow(Sender: TObject);
begin
   Self.Top  := RctAuxi.Top  + ((RctAuxi.Height - Self.Height) div 2) - 40;
   Self.Left := RctAuxi.Left + ((RctAuxi.Width  - Self.Width)  div 2);
   SouConv.DataSet  := nil;
   auxSQL := 'SELECT CON.*,PES.Nompes,DES.DesDesc,BCO.Nomban FROM arqconvenio CON '+
   'LEFT JOIN arqbanco BCO ON CON.Codban = BCO.Codban '+
   'LEFT JOIN arqdesconto DES ON CON.IDDesc = DES.IDDesc '+
   'LEFT JOIN arqpessoa PES ON CON.IDPessPri = PES.IDPess '+
   'WHERE IndDelete != '+Aspas('1');
   TabConv.SQL.Text := auxSQL+iif(recIDConv > 0,' AND CON.IDConv = '+recIDConv.ToString,'')+' LIMIT 1';
   TabConv.Open;
   if recIDConv <= 0 then
        btNovo.Click 
   else edSenha.Text := TabConvSenhaWeb.AsString;
   SouConv.DataSet := TabConv;
   LMDDBLabeledListComboBox3.SetFocus;
end;

procedure TFrmConvCad.LMDDBLabeledEdit2Change(Sender: TObject);
begin
   if LMDDBLabeledEdit2.Field <> nil then
   begin
      if LMDDBLabeledEdit2.Field.FieldName = 'IDConv' then
      begin
         if TabConvIDConv.AsInteger > 0 then
              LMDDBLabeledEdit2.DataField := 'IDConv'
         else LMDDBLabeledEdit2.DataField := '';
      end;
   end; //if
end;

procedure TFrmConvCad.LMDDBLabeledExtSpinEdit1Exit(Sender: TObject);
begin
   if TabConv.FieldByName(TLMDDBLabeledExtSpinEdit(Sender).DataField).AsInteger > 30 then
   begin
      MostraMsg('Aviso','Limite de o dia 30.', mtWarning, [mbOk]);
      TLMDDBLabeledExtSpinEdit(Sender).SetFocus;
   end;
end;

procedure TFrmConvCad.TabConvAfterInsert(DataSet: TDataSet);
begin
   TabConvTipConv.Value      := 'A VISTA';
   TabConvIndAtivo.Value     := '1';
   TabConvIndDesVenVis.Value := '0';
   TabConvIndDesVenPra.Value := '0';
   TabConvIndDesProg.Value   := '0';
   TabConvIndPreProm.Value   := '0';
   TabConvIndDesVenVis.Value := '0';
   TabConvIndDesVenPra.Value := '0';
   TabConvIndLibLim.Value    := '0';
   TabConvIndSolSen.Value    := '0';
   TabConvIndRepCom.Value    := '0';
   TabConvIndPonFid.Value    := '0';
   TabConvIndVenVis.Value    := '0';
   TabConvIndVenPra .Value   := '0';
   TabConvPraParBlo.Value    := 0;
   TabConvNroDiaCar.Value    := 0;
   TabConvDiaFecha.Value     := 0;
   TabConvNroMaxPar.Value    := 0;
   TabConvDiaFecha.Value     := 0;
   TabConvDiaVence.Value     := 0;
   TabConvVlrMinCup.Value    := 0.00;
   TabConvDatcadCon.Value    := DataServer;
end;

procedure TFrmConvCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmConvCad.edDescontoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabConv,'arqdesconto',TDBEdit(edDesconto),'IDDesc','IDDesc','DesDesc','DesDesc','',0);
end;

procedure TFrmConvCad.edDescontoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabConv,'arqdesconto',TDBEdit(edDesconto),'IDDesc','IDDesc','DesDesc','DesDesc','',Key);
end;

procedure TFrmConvCad.edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabConv,'arqpessoa',TDBEdit(edPessoa),'IDPessPri','IDPess','Nompes','Nompes','IDEsppes != 11',0);
   if VerifCliResp then edPessoa.SetFocus;
end;

procedure TFrmConvCad.edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabConv,'arqpessoa',TDBEdit(edPessoa),'IDPessPri','IDPess','Nompes','Nompes','IDEsppes != 11',Key);
   if VerifCliResp then edPessoa.SetFocus;
end;

procedure TFrmConvCad.LMDDBLabeledEdit16Exit(Sender: TObject);
begin
   if TabConvEmailWeb.AsString.Trim <> '' then
   begin
      if not ValidarEmail(TabConvEmailWeb.AsString.Trim) then
      begin
         MostraMsg('Aviso','Favor verificar o formato do Email!',mtWarning, [mbOk]);
         LMDDBLabeledEdit16.SetFocus;
      end;
   end;
end;

procedure TFrmConvCad.edPessoaExit(Sender: TObject);
begin
   if VerifCliResp then edPessoa.SetFocus;
end;

// ----- Verifica se já tem Empresa Cliente Associada -------- //
function TFrmConvCad.VerifCliResp:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if TabConvIDPessPri.AsInteger <= 0 then Exit;
   try
      QueAuxi := TRESTDWClientSQL.Create(nil);
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT IDConv FROM arqconvenio WHERE IDPessPri = '+TabConvIDPessPri.AsString+' AND IDConv != '+TabConvIDConv.AsString;
         Open;
         if not IsEmpty then
         begin
            if (FieldByName('IDConv').AsInteger <> TabConvIDConv.AsInteger) and (TabConv.State <> dsInsert) then
            begin
               MostraMsg('Aviso','Este Cliente já está associado à outro Convênio!',mtWarning, [mbOk]);
               Result := True;
               Exit;
            end;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmConvCad.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmConvCad.Salvar: Boolean;
var
   antID,retID:Integer;
   QueAuxi:TRESTDWClientSQL;
   FocusObject:TWinControl;
   DBEditErro:TLMDDBLabeledEdit;
begin
   Result := False;
   FocusObject := Screen.ActiveControl;
   PanelTop.SetFocus;
   FocusObject.SetFocus;

   if TabConvEmailWeb.AsString.Trim <> '' then
      if not ValidarEmail(TabConvEmailWeb.AsString.Trim) then Exit;

   DBEditErro := nil;
   if TabConvIDPessPri.Value <= 0 then DBEditErro := edPessoa else
   if TabConvNomcon.AsString.Trim.Length < 3 then DBEditErro := LMDDBLabeledEdit1;
   if DBEditErro <> nil then
   begin
      MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
      DBEditErro.SetFocus;
      Exit;
   end; //if

   if TabConvDiaFecha.AsInteger > 30 then
   begin
      MostraMsg('Aviso','Limite de o dia 30.', mtWarning, [mbOk]);
      LMDDBLabeledExtSpinEdit1.SetFocus;
      Exit;
   end;
   if TabConvDiaFecha.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','É necessário informar o dia de fechamento.', mtWarning, [mbOk]);
      LMDDBLabeledExtSpinEdit1.SetFocus;
      Exit;
   end;
   if TabConvDiaVence.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','É necessário informar o dia de vencimento', mtWarning, [mbOk]);
      LMDDBLabeledExtSpinEdit2.SetFocus;
      Exit;
   end;
   if TabConvDiaVence.AsInteger > 30 then
   begin
      MostraMsg('Aviso','Limite de o dia 30.', mtWarning, [mbOk]);
      LMDDBLabeledExtSpinEdit2.SetFocus;
      Exit;
   end;

   if VerifCliResp then Exit;

   try
      if not (TabConv.State in dsEditModes) then TabConv.Edit;
      TabConvSenhaWeb.AsString := edSenha.Text;
      antID := iif(TabConv.State = dsEdit, TabConvIDConv.Value, -1);
      retID := MyApplayUpdates(TabConv, 'IDConv', 'IDConv = '+recIDConv.ToString, TabConv.State);
      if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
      recIDConv := iif(TabConv.State = dsEdit, antID, retID);
      TabConv.DisableControls;
      TabConv.Cancel;
      TabConv.Close;
      TabConv.SQL.Text := auxSQL+' AND CON.IDConv = '+recIDConv.ToString;
      TabConv.Open;
      TabConv.EnableControls;
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO,PastaLog,'ERRO ao tentar salvar Convênio -> '+E.Message);
         MostraMsg('Erro','Não foi possível salvar!',mtError, [mbOk]);
         Exit;
      end;
   end;
   PanelCadastro.Visible := False;
   Sleep(20);
   PanelCadastro.Visible := True;
   Result := True;
end;

procedure TFrmConvCad.btLimitaClick(Sender: TObject);
begin
   Self.AlphaBlendValue := 180;
   if TabConvIDConv.Value <= 0 then
   begin
      MostraMsg('Aviso','Favor Salvar primeiro!',mtWarning, [mbOk]);
      Exit;
   end;
   try
      FrmConLimGru := TFrmConLimGru.Create(Application);
      FrmConLimGru.recIDConv := TabConvIDConv.Value;
      FrmConLimGru.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      if TabConv.State in dsEditModes then TabConv.Post;
      FrmConLimGru.Free;
   end;
end;

procedure TFrmConvCad.btNovoClick(Sender: TObject);
begin
   TabConv.Cancel;
   TabConv.Append;
   edSenha.Clear;
   LMDDBLabeledListComboBox3.SetFocus;
end;

// -------------- Exclusão de Convênio ------------ //
procedure TFrmConvCad.btCliAtiClick(Sender: TObject);
begin
   if TabConvIDConv.Value <= 0 then
   begin
      MostraMsg('Aviso','Favor Salvar primeiro!',mtWarning, [mbOk]);
      Exit;
   end;
   Self.AlphaBlendValue := 180;
   try
      FrmConPesAti := TFrmConPesAti.Create(Application);
      FrmConPesAti.recIDConv := TabConvIDConv.Value;
      FrmConPesAti.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmConPesAti.Free;
   end;
end;

procedure TFrmConvCad.btConfBolClick(Sender: TObject);
begin
   if TabConvIDConv.Value <= 0 then
   begin
      MostraMsg('Aviso','Favor Salvar primeiro!',mtWarning, [mbOk]);
      Exit;
   end;
   Self.AlphaBlendValue := 180;
   try
      if not (TabConv.State in dsEditModes) then TabConv.Edit;
      FrmConBoleto := TFrmConBoleto.Create(Application);
      FrmConBoleto.recIDConv := TabConvIDConv.Value;
      FrmConBoleto.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      if TabConv.State in dsEditModes then TabConv.Post;
      FrmConPesAti.Free;
   end;
end;

procedure TFrmConvCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabConv.State <> dsInsert) and (TabConvIDConv.Value > 0) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT 1 FROM arqpessconv WHERE IDConv = '+TabConvIDConv.AsString+' LIMIT 1';
            QueAuxi.Open;
            if not IsEmpty then
            begin
               MostraMsg('Não pode ser excluído','Existem clientes associados à esse convênio.', mtInformation, [mbOk]);
               Exit;
            end;
            if MostraMsg('Confirmação','Deseja realmente excluir este convênio?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  if TabConvTipConv.Value <> 'EMPRESARIAL' then
                  begin
                     SQL.Add('DELETE FROM arqconvfilcli WHERE IDConv = '+TabConvIDConv.AsString+';');
                     SQL.Add('DELETE FROM arqconvenio WHERE IDConv = '  +TabConvIDConv.AsString+';');
                  end else
                  begin
                     SQL.Add('UPDATE arqconvfilcli SET IndDelete = '+Aspas('1')+' WHERE IDConv = '+TabConvIDConv.AsString+';');
                     SQL.Add('UPDATE arqconvenio SET IndDelete = '+Aspas('1')+' WHERE IDConv = '+TabConvIDConv.AsString+';');
                  end;
                  ExecSQL;
               except
                  on E: Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqconvenio, IDConv = '+TabConvIDConv.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQCONVENIOS IDConv = '+TabConvIDConv.AsString+' - Pessoa: '+TabConvIDPessPri.AsString);
            end; //if
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end 
   else TabConv.Cancel;
   btNovo.Click;
end;

procedure TFrmConvCad.btFiliaisClick(Sender: TObject);
begin
   if TabConvIDConv.Value <= 0 then
   begin
      MostraMsg('Aviso','Favor Salvar primeiro!',mtWarning, [mbOk]);
      Exit;
   end;
   Self.AlphaBlendValue := 180;
   try
      FrmConFilial := TFrmConFilial.Create(Application);
      FrmConFilial.recIDConv := TabConvIDConv.Value;
      FrmConFilial.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmConFilial.Free;
   end;
end;

procedure TFrmConvCad.btVoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmConvCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmConvCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabConv.State in dsEditModes then TabConv.Cancel;
   TabConv.Close;
   FPainelOrigem.Visible := True;
   FadeInOut(Self,'Out',10);
   SimularCliqueControlePorNome('FrmConvenios','edbusca');
   Action := caFree;
end;

end.
