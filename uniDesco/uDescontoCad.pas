unit uDescontoCad;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, RxToolEdit, RxDBCtrl, Data.DB,
   LMDBaseControl, LMDBaseLabel, LMDBaseGraphicControl, LMDCustomLabel,
   LMDCustomBevelPanel, Vcl.ExtCtrls, AdvGlowButton, MarcLib, LMDButtonControl,
   LMDCustomCheckBox, LMDDBCheckBox, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, System.Rtti,
  LMDCheckBox;

type
  TFrmDesCad = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btVoltar: TAdvGlowButton;
    TabDesc: TRESTDWClientSQL;
    SouDesc: TDataSource;
    TabDescIDDesc: TIntegerField;
    TabDescDataON: TDateTimeField;
    TabDescDataOFF: TDateTimeField;
    TabDescPerDesc: TFloatField;
    LMDSimplePanel3: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    LMDLabel1: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel6: TLMDLabel;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    DBDateEdit2: TDBDateEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    DBDateEdit1: TDBDateEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit29: TLMDDBLabeledEdit;
    btNovo: TAdvGlowButton;
    btPrgres: TAdvGlowButton;
    TabDescDesDesc: TWideStringField;
    TabDescIndSeg: TWideStringField;
    TabDescIndTer: TWideStringField;
    TabDescIndQua: TWideStringField;
    TabDescIndQui: TWideStringField;
    TabDescIndSex: TWideStringField;
    TabDescIndSab: TWideStringField;
    TabDescIndDom: TWideStringField;
    TabDescIndAll: TWideStringField;
    TabDescIndVenDin: TWideStringField;
    TabDescIndVenPix: TWideStringField;
    TabDescIndVenDeb: TWideStringField;
    TabDescIndVenCre: TWideStringField;
    TabDescIndVenPra: TWideStringField;
    TabDescIndVenChe: TWideStringField;
    PanelBack: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    PanelButMen: TLMDSimplePanel;
    PanelBas: TLMDSimplePanel;
    btProduto: TAdvGlowButton;
    btFabri: TAdvGlowButton;
    btSubGru: TAdvGlowButton;
    btGrupo: TAdvGlowButton;
    btConv: TAdvGlowButton;
    btClientes: TAdvGlowButton;
    TabDescIndVenCon: TWideStringField;
    TabDescIndVenVou: TWideStringField;
    LMDLabel4: TLMDLabel;
    CheckDia2: TLMDCheckBox;
    CheckDia3: TLMDCheckBox;
    CheckDia4: TLMDCheckBox;
    CheckDia5: TLMDCheckBox;
    CheckDia6: TLMDCheckBox;
    CheckDia7: TLMDCheckBox;
    CheckDia1: TLMDCheckBox;
    ckVenVou: TLMDCheckBox;
    ckVenChe: TLMDCheckBox;
    ckVenPra: TLMDCheckBox;
    ckVenDeb: TLMDCheckBox;
    ckVenDin: TLMDCheckBox;
    ckVenCre: TLMDCheckBox;
    ckVenPix: TLMDCheckBox;
    TabDescPrioridade: TIntegerField;
    TabRegras: TRESTDWClientSQL;
    TabRegrasIDDesc: TFDAutoIncField;
    TabRegrasPossuiCliente: TLargeintField;
    TabRegrasPossuiConvenio: TLargeintField;
    TabRegrasPossuiGrupo: TLargeintField;
    TabRegrasPossuiSubGrupo: TLargeintField;
    TabRegrasPossuiFabricante: TLargeintField;
    TabRegrasPossuiProdutos: TLargeintField;
    btFilial: TAdvGlowButton;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btVoltarClick(Sender: TObject);
    procedure TabDescAfterInsert(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPrgresClick(Sender: TObject);
    procedure LMDDBLabeledEdit2DataChange(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure LMDDBLabeledEdit29Exit(Sender: TObject);
    procedure DBDateEdit2Exit(Sender: TObject);
  private
    { Private declarations }
    AtiForm:TForm;
    auxSQL:String;
    function CalculaPrioridade(PossuiCliente, PossuiConvenio, PossuiGrupo,
                             PossuiSubGrupo, PossuiFabricante, PossuiProdutos: Integer): Integer;
    function Salvar: Boolean;
    procedure VerTemProgr;
  public
    { Public declarations }
    recIDDesc:Integer;
    recCampo,recValor:String;
  end;

var
   FrmDesCad: TFrmDesCad;
   basIDDesc: Integer = 0;

implementation

{$R *.dfm}

uses uDM, uConst, uPrincipal, uLibFarm, uDescPgr, uDescPro,
     uDescFab, uDescGru, uDescSub, uDescConv, uDescCli, uDescFil;

procedure TFrmDesCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmDesCad.FormShow(Sender: TObject);
begin
   auxSQL := 'SELECT DES.* FROM arqdesconto DES WHERE ';
   SouDesc.DataSet  := nil;
   TabDesc.SQL.Text := auxSQL+'DES.IDDesc = '+recIDDesc.ToString+' LIMIT 1';
   TabDesc.Open;
   if recIDDesc <= 0 then TabDesc.Append;
   SouDesc.DataSet := TabDesc;
   VerTemProgr;
   //
   if TabDesc.FieldByName('IndAll').AsString = '1' then
   begin
     CheckDia1.Checked:= True;
     CheckDia2.Checked:= True;
     CheckDia3.Checked:= True;
     CheckDia4.Checked:= True;
     CheckDia5.Checked:= True;
     CheckDia6.Checked:= True;
     CheckDia7.Checked:= True;
   end else
   begin
     CheckDia1.Checked:= (TabDesc.FieldByName('IndDom').AsString = '1');
     CheckDia2.Checked:= (TabDesc.FieldByName('IndSeg').AsString = '1');
     CheckDia3.Checked:= (TabDesc.FieldByName('IndTer').AsString = '1');
     CheckDia4.Checked:= (TabDesc.FieldByName('IndQua').AsString = '1');
     CheckDia5.Checked:= (TabDesc.FieldByName('IndQui').AsString = '1');
     CheckDia6.Checked:= (TabDesc.FieldByName('IndSex').AsString = '1');
     CheckDia7.Checked:= (TabDesc.FieldByName('IndSab').AsString = '1');
   end;
   //
   ckVenPix.Checked:= (TabDesc.FieldByName('IndVenPix').AsString = '1');
   ckVenCre.Checked:= (TabDesc.FieldByName('IndVenCre').AsString = '1');
   ckVenDin.Checked:= (TabDesc.FieldByName('IndVenDin').AsString = '1');
   ckVenDeb.Checked:= (TabDesc.FieldByName('IndVenDeb').AsString = '1');
   ckVenPra.Checked:= (TabDesc.FieldByName('IndVenPra').AsString = '1');
   ckVenChe.Checked:= (TabDesc.FieldByName('IndVenChe').AsString = '1');
   ckVenVou.Checked:= (TabDesc.FieldByName('IndVenVou').AsString = '1');
end;

procedure TFrmDesCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmDesCad.MenuClick(Sender: TObject);
var
   TAtiForm:TFormClass;
   Ctx:TRttiContext;
   Field:TRttiField;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabDescIDDesc.Value <= 0 then
   begin
      MostraMsg('Aviso', 'Favor salvar a Regra antes!',mtWarning, [mbOk]);
      Exit;
   end;

   if AtiForm <> nil then AtiForm.Close;
   case TAdvGlowButton(Sender).Tag of
      1: TAtiForm := TFrmDescPro;
      2: TAtiForm := TFrmDescFab;
      3: begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            QueAuxi.DataBase := DM.DWDataBase;
            try
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqdescgru WHERE IDDesc = '+TabDescIDDesc.AsString+' LIMIT 1';
               QueAuxi.Open;
               if QueAuxi.IsEmpty then
               begin
                  MostraMsg('Aviso', 'É necessário entrar primeiro com os Grupos!',mtWarning, [mbOk]);
                  Exit;
               end
               else TAtiForm := TFrmDescSub;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end;
      4: TAtiForm := TFrmDescGru;
      5: TAtiForm := TFrmDescCon;
      6: TAtiForm := TFrmDescCli;
      7: TAtiForm := TFrmDescFil;
   end; //case
   AtiForm := TAtiForm.Create(nil);
   Ctx := TRttiContext.Create;
   try
      Field := Ctx.GetType(AtiForm.ClassType).GetField('recIDDesc');
      if Assigned(Field) then Field.SetValue(AtiForm, TabDescIDDesc.Value);
      AtiForm.Parent := PanelBas;
      AtiForm.Show;
   finally
      Ctx.Free;
   end;
end;

procedure TFrmDesCad.VerTemProgr;
var
   QueAuxi:TRESTDWClientSQL;
begin
   if recIDDesc > 0 then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text := 'SELECT 1 FROM arqdescontopgr WHERE IDDesc = '+recIDDesc.ToString;
         QueAuxi.Open;
         LMDDBLabeledEdit29.Enabled := QueAuxi.IsEmpty;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
end;

procedure TFrmDesCad.LMDDBLabeledEdit29Exit(Sender: TObject);
begin
   if (TabDescPerDesc.Value < 0.00) or (TabDescPerDesc.Value >= 100.00) then
   begin
      MostraMsg('Aviso', 'Percentual de desconto inválido!', mtWarning, [mbOk]);
      LMDDBLabeledEdit29.SetFocus;
   end;
end;

procedure TFrmDesCad.LMDDBLabeledEdit2DataChange(Sender: TObject);
begin
   if LMDDBLabeledEdit2.Field <> nil then
   begin
      if LMDDBLabeledEdit2.Field.FieldName = 'IDDesc' then
      begin
         if TabDescIDDesc.AsInteger > 0 then
              LMDDBLabeledEdit2.DataField := 'IDDesc'
         else LMDDBLabeledEdit2.DataField := '';
      end;
   end; //if
end;

procedure TFrmDesCad.TabDescAfterInsert(DataSet: TDataSet);
begin
   TabDescDataON.Value := DataServer;
   TabDescIndVenPix.Value := '1';
   TabDescIndVenDin.Value := '1';
   TabDescIndVenDeb.Value := '1';
   TabDescIndVenCre.Value := '1';
   TabDescIndVenPra.Value := '1';
   TabDescIndVenChe.Value := '1';
   TabDescPerDesc.Value   := 0.00;
end;

procedure TFrmDesCad.btSalvarClick(Sender: TObject);
begin
   if TabDesc.State in [dsBrowse] then TabDesc.Edit;

   TabDescPrioridade.AsInteger:= 0;

   if CheckDia1.Checked and CheckDia2.Checked and CheckDia3.Checked and CheckDia4.Checked and
       CheckDia5.Checked and CheckDia6.Checked  and CheckDia7.Checked then
   begin
     TabDesc.FieldByName('IndAll').AsString:= '1';
     TabDesc.FieldByName('IndDom').AsString:= '1';
     TabDesc.FieldByName('IndSeg').AsString:= '1';
     TabDesc.FieldByName('IndTer').AsString:= '1';
     TabDesc.FieldByName('IndQua').AsString:= '1';
     TabDesc.FieldByName('IndQui').AsString:= '1';
     TabDesc.FieldByName('IndSex').AsString:= '1';
     TabDesc.FieldByName('IndSab').AsString:= '1';
   end else
   begin
     TabDesc.FieldByName('IndAll').AsString:= '0';
     TabDesc.FieldByName('IndDom').AsString:= iif(CheckDia1.Checked, '1', '0');
     TabDesc.FieldByName('IndSeg').AsString:= iif(CheckDia2.Checked, '1', '0');
     TabDesc.FieldByName('IndTer').AsString:= iif(CheckDia3.Checked, '1', '0');
     TabDesc.FieldByName('IndQua').AsString:= iif(CheckDia4.Checked, '1', '0');
     TabDesc.FieldByName('IndQui').AsString:= iif(CheckDia5.Checked, '1', '0');
     TabDesc.FieldByName('IndSex').AsString:= iif(CheckDia6.Checked, '1', '0');
     TabDesc.FieldByName('IndSab').AsString:= iif(CheckDia7.Checked, '1', '0');
   end; //if
   TabDesc.FieldByName('IndVenPix').AsString:= iif(ckVenPix.Checked, '1', '0');
   TabDesc.FieldByName('IndVenCre').AsString:= iif(ckVenCre.Checked, '1', '0');
   TabDesc.FieldByName('IndVenDin').AsString:= iif(ckVenDin.Checked, '1', '0');
   TabDesc.FieldByName('IndVenDeb').AsString:= iif(ckVenDeb.Checked, '1', '0');
   TabDesc.FieldByName('IndVenPra').AsString:= iif(ckVenPra.Checked, '1', '0');
   TabDesc.FieldByName('IndVenChe').AsString:= iif(ckVenChe.Checked, '1', '0');
   TabDesc.FieldByName('IndVenVou').AsString:= iif(ckVenVou.Checked, '1', '0');
   Salvar;
end;

// ----- Função para calcular a prioridade da regra baseada na hierarquia -------- //
function TFrmDesCad.CalculaPrioridade(PossuiCliente, PossuiConvenio, PossuiGrupo,
                    PossuiSubGrupo, PossuiFabricante, PossuiProdutos: Integer): Integer;
begin
  Result := 0;
  // HIERARQUIA (do menor para o maior):
  // Nível 10: REGRA POR GRUPO ESPECÍFICO
  if (PossuiGrupo >= 1) and (PossuiSubGrupo = 0) and (PossuiFabricante = 0) and
     (PossuiProdutos = 0) and (PossuiConvenio = 0) and (PossuiCliente = 0) then
    Result := 10
  // Nível 20: REGRA POR GRUPO ESPECÍFICO / FABRICANTE
  else if (PossuiGrupo >= 1) and (PossuiSubGrupo = 0) and (PossuiFabricante >= 1) and
          (PossuiProdutos = 0) and (PossuiConvenio = 0) and (PossuiCliente = 0) then
    Result := 20
  // Nível 30: REGRA POR GRUPO ESPECÍFICO / SUBGRUPO ESPECÍFICO
  else if (PossuiGrupo >= 1) and (PossuiSubGrupo >= 1) and (PossuiFabricante = 0) and
          (PossuiProdutos = 0) and (PossuiConvenio = 0) and (PossuiCliente = 0) then
    Result := 30
  // Nível 40: REGRA POR GRUPO ESPECÍFICO / SUBGRUPO ESPECÍFICO / FABRICANTE
  else if (PossuiGrupo >= 1) and (PossuiSubGrupo >= 1) and (PossuiFabricante >= 1) and
          (PossuiProdutos = 0) and (PossuiConvenio = 0) and (PossuiCliente = 0) then
    Result := 40
  // Nível 50: REGRA POR PRODUTO
  else if (PossuiProdutos >= 1) and (PossuiConvenio = 0) and (PossuiCliente = 0) then
    Result := 50
  // Nível 60: REGRA POR PRODUTO / CONVENIO
  else if (PossuiProdutos >= 1) and (PossuiConvenio >= 1) and (PossuiCliente = 0) then
    Result := 60
  // Nível 70: REGRA POR PRODUTO / CLIENTE
  else if (PossuiProdutos >= 1) and (PossuiCliente >= 1) and (PossuiConvenio = 0) then
    Result := 70
  // Nível 80: REGRA POR CONVENIO
  else if (PossuiConvenio >= 1) and (PossuiGrupo = 0) and (PossuiSubGrupo = 0) and
          (PossuiFabricante = 0) and (PossuiProdutos = 0) and (PossuiCliente = 0) then
    Result := 80
  // Nível 90: REGRA POR CONVENIO / GRUPO ESPECÍFICO
  else if (PossuiConvenio >= 1) and (PossuiGrupo >= 1) and (PossuiSubGrupo = 0) and
          (PossuiFabricante = 0) and (PossuiProdutos = 0) and (PossuiCliente = 0) then
    Result := 90
  // Nível 100: REGRA POR CONVENIO / GRUPO ESPECÍFICO / SUBGRUPO ESPECÍFICO
  else if (PossuiConvenio >= 1) and (PossuiGrupo >= 1) and (PossuiSubGrupo >= 1) and
          (PossuiFabricante = 0) and (PossuiProdutos = 0) and (PossuiCliente = 0) then
    Result := 100
  // Nível 110: REGRA POR CONVENIO / GRUPO ESPECÍFICO / SUBGRUPO ESPECÍFICO / FABRICANTE
  else if (PossuiConvenio >= 1) and (PossuiGrupo >= 1) and (PossuiSubGrupo >= 1) and
          (PossuiFabricante >= 1) and (PossuiProdutos = 0) and (PossuiCliente = 0) then
    Result := 110
  // Nível 120: REGRA POR CLIENTE
  else if (PossuiCliente >= 1) and (PossuiGrupo = 0) and (PossuiSubGrupo = 0) and
          (PossuiFabricante = 0) and (PossuiProdutos = 0) and (PossuiConvenio = 0) then
    Result := 120
  // Nível 130: REGRA POR CLIENTE / GRUPO ESPECÍFICO
  else if (PossuiCliente >= 1) and (PossuiGrupo >= 1) and (PossuiSubGrupo = 0) and
          (PossuiFabricante = 0) and (PossuiProdutos = 0) and (PossuiConvenio = 0) then
    Result := 130
  // Nível 140: REGRA POR CLIENTE / GRUPO ESPECÍFICO / SUBGRUPO ESPECÍFICO
  else if (PossuiCliente >= 1) and (PossuiGrupo >= 1) and (PossuiSubGrupo >= 1) and
          (PossuiFabricante = 0) and (PossuiProdutos = 0) and (PossuiConvenio = 0) then
    Result := 140
  // Nível 150: REGRA POR CLIENTE / GRUPO ESPECÍFICO / SUBGRUPO ESPECÍFICO / FABRICANTE
  else if (PossuiCliente >= 1) and (PossuiGrupo >= 1) and (PossuiSubGrupo >= 1) and
          (PossuiFabricante >= 1) and (PossuiProdutos = 0) and (PossuiConvenio = 0) then
    Result := 150;
end;

procedure TFrmDesCad.DBDateEdit2Exit(Sender: TObject);
begin
   if DBDateEdit1.Date > DBDateEdit2.Date then
   begin
      MostraMsg('Aviso', 'Datinicial não pode ser maior que a final!', mtWarning, [mbOk]);
      DBDateEdit2.SetFocus;
   end;
end;

// ------------------- Salvar ------------------- //
function TFrmDesCad.Salvar:Boolean;
var
   Erro,retID:Integer;
   FocusObject:TWinControl;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := True;
   if TabDesc.State in dsEditModes then
   begin
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      Erro := 0;
      if TabDescDesDesc.AsString.Trim.Length < 6 then Erro := 1 else
      if DBDateEdit1.Date < 10 then Erro := 2;
      if DBDateEdit1.Date < 10 then Erro := 2;
      if Erro > 0 then
      begin
         Result := False;
         if Erro = 1 then
         begin
            MostraMsg('Aviso', 'Favor preencher a descrição corretamente!', mtWarning, [mbOk]);
            LMDDBLabeledEdit1.SetFocus;
         end else
         if Erro = 2 then
         begin
            MostraMsg('Aviso', 'A data da ativação deve ser preenchida!', mtWarning, [mbOk]);
            DBDateEdit1.SetFocus;
         end; //if
         Exit;
      end; //if
      if (TabDescPerDesc.Value < 0.00) or (TabDescPerDesc.Value >= 100.00) then
      begin
         MostraMsg('Aviso', 'Percentual de desconto inválido!', mtWarning, [mbOk]);
         LMDDBLabeledEdit29.SetFocus;
         Exit;
      end;

      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text :=
         'SELECT DesDesc FROM arqdesconto WHERE '+iif(TabDescIDDesc.Value > 0,'IDDesc != '+TabDescIDDesc.AsString+' AND ','')+
         '((DataON  BETWEEN '+FormatDateTime('yyyy-mm-dd',DBDateEdit1.Date)+' AND '+FormatDateTime('yyyy-mm-dd',DBDateEdit2.Date)+') OR'+
         ' (DataOFF BETWEEN '+FormatDateTime('yyyy-mm-dd',DBDateEdit1.Date)+' AND '+FormatDateTime('yyyy-mm-dd',DBDateEdit2.Date)+'))';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            Result := False;
            MostraMsg('Aviso', 'Na regra: '+QueAuxi.FieldByName('DesDesc').AsString+' já possui desconto com regras que impedem essa!', mtWarning, [mbOk]);
            LMDDBLabeledEdit1.SetFocus;
            Exit;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;

      try
         retID := MyApplayUpdates(TabDesc, 'IDDesc', 'IDDesc = '+recIDDesc.ToString, TabDesc.State);
         if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
         if retID > 0 then recIDDesc := retID;
         TabDesc.Cancel;
         TabDesc.Close;
         TabDesc.SQL.Text := auxSQL+'DES.IDDesc = '+recIDDesc.ToString+' LIMIT 1';
         TabDesc.Open;

         // CalculaPrioridade = Caso Regra de Hierarquia não definida, retorna zero
         recIDDesc:= TabDescIDDesc.AsInteger;
         var PrioridadeCalc: Integer:= 0;

         TabRegras.Close;
         TabRegras.ParamByName('IDDesc').AsInteger:= recIDDesc;
         TabRegras.Open;

         PrioridadeCalc:= CalculaPrioridade(
            TabRegras.FieldByName('PossuiCliente').AsInteger,
            TabRegras.FieldByName('PossuiConvenio').AsInteger,
            TabRegras.FieldByName('PossuiGrupo').AsInteger,
            TabRegras.FieldByName('PossuiSubGrupo').AsInteger,
            TabRegras.FieldByName('PossuiFabricante').AsInteger,
            TabRegras.FieldByName('PossuiProdutos').AsInteger);
         TabRegras.Close;

         if PrioridadeCalc = 0 then
         begin
           MostraMsg('Aviso', 'Regra de Hierarquia não definida, Desconto desativado!',mtWarning, [mbOk]);
         end else
         begin
           var QueAux := TRESTDWClientSQL.Create(nil);
           QueAux.DataBase := DM.DWDataBase;
           QueAux.SQL.Text := Format('update arqdesconto set prioridade = %s where IDDesc = %s ',[PrioridadeCalc.ToString, recIDDesc.ToString]);
           QueAux.ExecSQL;
           QueAux.Free;
         end;
      except
         on E:Exception do
         begin
            Result := False;
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar Regra de Desconto -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar!', mtError, [mbOk]);
            Exit;
         end;
      end;
      PanelCadastro.Visible := False;
      Sleep(10);
      PanelCadastro.Visible := True;
   end; //if
end;

procedure TFrmDesCad.btNovoClick(Sender: TObject);
begin
   if TabDesc.State in dsEditModes then
      if MostraMsg('Confirmação', 'A regra em tela não foi salva. Deseja cancelar e gerar uma nova?', mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   TabDesc.Cancel;
   TabDesc.Append;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmDesCad.btPrgresClick(Sender: TObject);
begin
   if not Salvar then Exit;
   if TabDescPerDesc.Value > 0.00 then
   begin
      if MostraMsg('Confirmação', 'Já foi escolhido um %, deseja mudar a modalidade?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         TabDesc.Edit;
         TabDescPerDesc.Value := 0.00;
         if not Salvar then Exit;
         LMDDBLabeledEdit29.Enabled := False;
      end
      else Exit;
   end; //if
   try
      FrmDescPgr := TFrmDescPgr.Create(Application);
      FrmDescPgr.recIDDesc := TabDescIDDesc.Value;
      FrmDescPgr.ShowModal;
   finally
      VerTemProgr;
      FrmDescPgr.Free;
   end;
end;

// ------------- Exclusão de Regras ------------ //
procedure TFrmDesCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabDesc.State <> dsInsert) and (TabDescIDDesc.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            if MostraMsg('Confirmação', 'Deseja realmente excluir esta regra de desconto?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqdesccli WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  SQL.Add('DELETE FROM arqdesccon WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  SQL.Add('DELETE FROM arqdescsub WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  SQL.Add('DELETE FROM arqdescgru WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  SQL.Add('DELETE FROM arqdescfab WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  SQL.Add('DELETE FROM arqdescpro WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  SQL.Add('DELETE FROM arqdescontopgr WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  SQL.Add('DELETE FROM arqdesconto    WHERE IDDesc = '+TabDescIDDesc.AsString+';');
                  ExecSQL;
                  Self.Close;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, '[ERRO] ao tentar excluir registro do aquivo: arqdesconto, IDDesc = '+TabDescIDDesc.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQDESCONTOS IDDesc = '+TabDescIDDesc.AsString);
            end; //if
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end else
   begin
      TabDesc.Cancel;
      TabDesc.Append;
   end;
end;

procedure TFrmDesCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
   end
   else if Key = VK_F2 then btSalvar.Click;
end;

procedure TFrmDesCad.btVoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmDesCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabDesc.State in dsEditModes then TabDesc.Cancel;
   TabDesc.Close;
   FadeInOut(Self,'Out',10);
   SimularCliqueControlePorNome('FrmDescontos','edbusca');
   Action := caFree;
end;

end.


