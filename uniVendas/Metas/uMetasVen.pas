unit uMetasVen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDControl,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.ExtCtrls,
  LMDButtonControl, LMDCustomCheckBox, LMDDBCheckBox, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDMaskEdit, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, MarcLib, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, uRESTDWBasicDB, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uRESTDWBasicTypes, LMDCheckBox, DateUtils, LMDCustomParentPanel,
  LMDCustomGroupBox, LMDCustomButtonGroup, LMDCustomRadioGroup, LMDDBRadioGroup,
  System.Rtti, LMDRadioButton, LMDEdit;

type
  TFrmMetaVen = class(TForm)
    PanelBase: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    btFechar: TAdvGlowButton;
    btBusca: TAdvGlowButton;
    PanelMaster: TLMDSimplePanel;
    Shape2: TShape;
    CheckAtiva: TLMDCheckBox;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    PanelBack: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    PanelButMen: TLMDSimplePanel;
    PanelBas: TLMDSimplePanel;
    btGrupo: TAdvGlowButton;
    btSubGru: TAdvGlowButton;
    btFabrica: TAdvGlowButton;
    btProduto: TAdvGlowButton;
    btFilial: TAdvGlowButton;
    btClientes: TAdvGlowButton;
    RadioFil: TLMDRadioButton;
    RadioVen: TLMDRadioButton;
    edDesMeta: TLMDEdit;
    LMDLabel4: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    Shape4: TShape;
    edDateIni: TDateEdit;
    edTimeIni: TLMDMaskEdit;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDLabel6: TLMDLabel;
    Shape5: TShape;
    edDateFin: TDateEdit;
    edTimeFin: TLMDMaskEdit;
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btFilialClick(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
  private
    AtiForm:TForm;
    TAtiForm:TFormClass;
    auxIDMetVen:Integer;
    function Salvar:Boolean;
    function VerTemReg:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMetaVen: TFrmMetaVen;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uMetaFil, uMetaVnd, uMetaGru, uMetaSub, uMetaFab, uMetaPro, uMetaBus;

procedure TFrmMetaVen.FormShow(Sender: TObject);
begin
   auxIDMetVen := 0;
   btNovo.Click;
end;

procedure TFrmMetaVen.btNovoClick(Sender: TObject);
begin
   if AtiForm <> nil then AtiForm.Close;
   auxIDMetVen    := 0;
   edDesMeta.Text := '';
   edDateIni.Text := '';
   edTimeIni.Text := '';
   edDateFin.Text := '';
   edTimeFin.Text := '';
   edDateIni.ReadOnly := False;
   edTimeIni.ReadOnly := False;
   edDateFin.ReadOnly := False;
   edTimeFin.ReadOnly := False;
   RadioFil.ReadOnly  := False;
   RadioVen.ReadOnly  := False;
   RadioFil.Checked   := True;
   CheckAtiva.Checked := True;
   edDateIni.SetFocus;
end;

procedure TFrmMetaVen.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

{procedure TFrmMetaVen.edTimeIniExit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if edDateIni.Date <= StrToDate('01/01/2000') then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT * FROM arqmetas WHERE DatHorIniMet = '+Aspas(DataMySQL(edDateIni.Date)+' '+edTimeIni.Text+':00');
         QueAuxi.Open;
         if not QueAuxi.Eof then
         begin
            auxIDMetVen := QueAuxi.FieldByName('IDMetVen').AsInteger;
            edDesMeta.Text     := QueAuxi.FieldByName('DesMeta').AsString;
            edDateFin.Date     := DateOf(QueAuxi.FieldByName('DatHorFinMet').AsDateTime);
            edTimeFin.AsTime   := TimeOf(QueAuxi.FieldByName('DatHorFinMet').AsDateTime);
            CheckAtiva.Checked := QueAuxi.FieldByName('IndAtivo').AsBoolean;
            RadioFil.Checked   := QueAuxi.FieldByName('TipMeta').AsString = 'F';
            RadioVen.Checked   := QueAuxi.FieldByName('TipMeta').AsString = 'V';
            VerTemReg;
        end else
         begin
            auxIDMetVen := 0;
            edDesMeta.Text := '';
            edDateFin.Text := '';
            edTimeFin.Text := '';
            CheckAtiva.Checked := True;
            RadioFil.Checked   := True;
         end;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar encontrar Meta -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível encontrar Meta', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end; }

function TFrmMetaVen.Salvar:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if edDesMeta.Text.Trim.Length <= 3 then
   begin
      MostraMsg('Dado não informado','Favor preencher corretamente a descrição!',mtWarning, [mbOk]);
      edDesMeta.SetFocus;
      Exit;
   end;
   if edDateIni.Date <= StrToDate('01/01/2000') then
   begin
      MostraMsg('Dado não informado','Favor preencher com uma Data Inicial.',mtWarning, [mbOk]);
      edDateIni.SetFocus;
      Exit;
   end;
   if edDateFin.Date <= StrToDate('01/01/2000') then
   begin
      MostraMsg('Dado não informado','Favor preencher com uma Data Final.',mtWarning, [mbOk]);
      edDateIni.SetFocus;
      Exit;
   end;
   if edDateIni.Date > edDateFin.Date then
   begin
      MostraMsg('Erro','A data inicial deve ser menor que a data final.',mtWarning, [mbOk]);
      edDateIni.SetFocus;
      Exit;
   end;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT * FROM arqmetas WHERE DatHorIniMet = '+Aspas(DataMySQL(edDateIni.Date)+' '+edTimeIni.Text+':00');
         QueAuxi.Open;
         if QueAuxi.IsEmpty then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'INSERT INTO arqmetas (DesMeta,DatHorIniMet,DatHorFinMet,IndAtivo,TipMeta) VALUES ('+
            Aspas(edDesMeta.Text.Trim)+','+Aspas(DataMySQL(edDateIni.Date)+' '+
            edTimeIni.Text+':00')+','+Aspas(DataMySQL(edDateFin.Date)+' '+edTimeFin.Text+':00')+','+
            iif(CheckAtiva.Checked,'1','0')+','+Aspas(iif(RadioFil.Checked,'F','V'))+');';
            QueAuxi.SQL.Add('SELECT LAST_INSERT_ID() AS NEW_IDMetVen;');
            QueAuxi.Open;
            auxIDMetVen := QueAuxi.FieldByName('NEW_IDMetVen').AsInteger;
         end else
         begin
            auxIDMetVen := QueAuxi.FieldByName('IDMetVen').AsInteger;
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'UPDATE arqmetas SET DesMeta = '+Aspas(edDesMeta.Text.Trim)+',DatHorFinMet = '+
            Aspas(DataMySQL(edDateFin.Date)+' '+edTimeFin.Text+':00')+',IndAtivo = '+iif(CheckAtiva.Checked,'1','0')+','+
            'TipMeta = '+Aspas(iif(RadioFil.Checked,'F','V'))+' WHERE IDMetVen = '+auxIDMetVen.ToString+';';
            QueAuxi.ExecSQL;
         end; //if
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Metas de Vendas -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   Result := True;
end;

{function TFrmMetaVen.JaExiste(recID:Integer):String;
var
   TipRet:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := 'ERRO';
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text :=
         'SELECT M2.IDMetVen AS IDConflito,'+
         '  CASE '+
         '    WHEN EXISTS ('+
         '      SELECT 1 FROM arqmetasub S1 JOIN arqmetasub S2 ON S1.IDGruSub = S2.IDGruSub '+
         '      WHERE S1.IDMetVen = M1.IDMetVen AND S2.IDMetVen = M2.IDMetVen ) THEN 1 '+
         '    WHEN EXISTS ('+
         '      SELECT 1 FROM arqmetavnd V1 JOIN arqmetavnd V2 ON V1.IDVend = V2.IDVend '+
         '      WHERE V1.IDMetVen = M1.IDMetVen AND V2.IDMetVen = M2.IDMetVen) THEN 2 '+
         '    WHEN EXISTS ('+
         '      SELECT 1 FROM arqmetapro P1 JOIN arqmetapro P2 ON P1.IDProd = P2.IDProd '+
         '      WHERE P1.IDMetVen = M1.IDMetVen AND P2.IDMetVen = M2.IDMetVen) THEN 3 '+
         '    WHEN EXISTS ('+
         '      SELECT 1 FROM arqmetagru G1 JOIN arqmetagru G2 ON G1.IDGrupo = G2.IDGrupo '+
         '      WHERE G1.IDMetVen = M1.IDMetVen AND G2.IDMetVen = M2.IDMetVen ) THEN 4 '+
         '    WHEN EXISTS ('+
         '      SELECT 1 FROM arqmetafil F1 JOIN arqmetafil F2 ON F1.IDFilial = F2.IDFilial '+
         '      WHERE F1.IDMetVen = M1.IDMetVen AND F2.IDMetVen = M2.IDMetVen ) THEN 5 '+
         '    WHEN EXISTS ('+
         '      SELECT 1 FROM arqmetafab B1 JOIN arqmetafab B2 ON B1.IDPess = B2.IDPess '+
         '      WHERE B1.IDMetVen = M1.IDMetVen AND B2.IDMetVen = M2.IDMetVen) THEN 6 '+
         '    ELSE 0 '+
         '  END AS TabelaCongruente '+
         'FROM arqmetas M1 JOIN arqmetas M2 ON M1.IDMetVen <> M2.IDMetVen '+
         'WHERE M1.IDMetVen = :BaseID AND NOT (M2.DatHorIniMet > M1.DatHorFinMet OR M2.DatHorFinMet < M1.DatHorIniMet) '+
         'HAVING TabelaCongruente IS NOT NULL LIMIT 1;';
         QueAuxi.ParamByName('BaseID').AsInteger := recID;
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            TipRet := QueAuxi.FieldByName('TabelaCongruente').AsInteger;
            case TipRet of
               1: Result := 'Sub Grupo';
               2: Result := 'Vendedor';
               3: Result := 'Produto';
               4: Result := 'Grupo';
               5: Result := 'Filial';
               6: Result := 'Fabricante';
               else Result := '';
            end
         end
         else Result := '';
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao buscar registro em função JaExiste em uMetasVen -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end; }

procedure TFrmMetaVen.btBuscaClick(Sender: TObject);
var
   PanelPos:TPoint;
   QueAuxi:TRESTDWClientSQL;
begin
   if FrmMetaBus = nil then FrmMetaBus := TFrmMetaBus.Create(Self);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      PanelPos := PanelBase.ClientToScreen(Point(0, 0));
      FrmMetaBus.Top  := PanelPos.Y + 45;
      FrmMetaBus.Left := PanelPos.X + PanelBase.Width - FrmMetaBus.Width - 43;
      FrmMetaBus.ShowModal;
   finally
      if FrmMetaBus.retIDMetVen > 0 then
      begin
         try
            try
               QueAuxi.SQL.Text := 'SELECT * FROM arqmetas WHERE IDMetVen = '+FrmMetaBus.retIDMetVen.ToString;
               QueAuxi.Open;
               auxIDMetVen        := QueAuxi.FieldByName('IDMetVen').AsInteger;
               edDesMeta.Text     := QueAuxi.FieldByName('DesMeta').AsString;
               edDateIni.Date     := DateOf(QueAuxi.FieldByName('DatHorIniMet').AsDateTime);
               edTimeIni.AsTime   := TimeOf(QueAuxi.FieldByName('DatHorIniMet').AsDateTime);
               edDateFin.Date     := DateOf(QueAuxi.FieldByName('DatHorFinMet').AsDateTime);
               edTimeFin.AsTime   := TimeOf(QueAuxi.FieldByName('DatHorFinMet').AsDateTime);
               CheckAtiva.Checked := QueAuxi.FieldByName('IndAtivo').AsBoolean;
               RadioFil.Checked   := QueAuxi.FieldByName('TipMeta').AsString = 'F';
               RadioVen.Checked   := QueAuxi.FieldByName('TipMeta').AsString = 'V';
               if AtiForm <> nil then AtiForm.Close;
               VerTemReg;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar encontrar Meta -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível encontrar Meta!', mtError, [mbOk]);
               end;
            end;
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
      FreeAndNil(FrmMetaBus);
   end;
end;

procedure TFrmMetaVen.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if auxIDMetVen <= 0 then Exit;
   try
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT 1 FROM arqmetas WHERE IDMetVen = '+auxIDMetVen.ToString+' LIMIT 1';
      QueAuxi.Open;
      if QueAuxi.IsEmpty then
      begin
         MostraMsg('Não pode ser excluído','Não encontrado Meta com esses parâmetros!', mtInformation, [mbOk]);
         Exit;
      end;
      if MostraMsg('Confirmação','Confirma exclusão de toda Meta desse período?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         try
            QueAuxi.Close;
            QueAuxi.SQL.Clear;
            QueAuxi.SQL.Add('DELETE FROM arqmetapro WHERE IDMetVen = '+auxIDMetVen.ToString+';');
            QueAuxi.SQL.Add('DELETE FROM arqmetafab WHERE IDMetVen = '+auxIDMetVen.ToString+';');
            QueAuxi.SQL.Add('DELETE FROM arqmetasub WHERE IDMetVen = '+auxIDMetVen.ToString+';');
            QueAuxi.SQL.Add('DELETE FROM arqmetagru WHERE IDMetVen = '+auxIDMetVen.ToString+';');
            QueAuxi.SQL.Add('DELETE FROM arqmetavnd WHERE IDMetVen = '+auxIDMetVen.ToString+';');
            QueAuxi.SQL.Add('DELETE FROM arqmetafil WHERE IDMetVen = '+auxIDMetVen.ToString+';');
            QueAuxi.SQL.Add('DELETE FROM arqmetas   WHERE IDMetVen = '+auxIDMetVen.ToString+';');
            QueAuxi.ExecSQL;
         except
            on E: Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqmetas, IDMetVen = '+auxIDMetVen.ToString+' -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
               Exit;
            end;
         end;
         SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQMETAS IDMetVen = '+auxIDMetVen.ToString);
         btNovo.Click;
      end; // if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

function TFrmMetaVen.VerTemReg:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if auxIDMetVen <= 0 then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT 1 FROM arqmetafil WHERE IDMetVen = '+auxIDMetVen.ToString+' LIMIT 1';
         QueAuxi.Open;
         Result := not QueAuxi.IsEmpty;
         if not Result then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqmetavnd WHERE IDMetVen = '+auxIDMetVen.ToString+' LIMIT 1';
            QueAuxi.Open;
            Result := not QueAuxi.IsEmpty;
         end; //if
      except
         on E:Exception do
         begin
            MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   edDateIni.ReadOnly := Result;   edTimeIni.ReadOnly := Result;
   edDateFin.ReadOnly := Result;   edTimeFin.ReadOnly := Result;
   RadioFil.ReadOnly  := Result;   RadioVen.ReadOnly  := Result;
end;

procedure TFrmMetaVen.btFilialClick(Sender: TObject);
var
   Ctx:TRttiContext;
   auxFilVen:Integer;
   QueAuxi:TRESTDWClientSQL;
   auxDataIni,auxDataFin:TDateTime;
   Field1,Field2,Field3,Field4:TRttiField;
begin
   if not Salvar then Exit;
   
   if auxIDMetVen <= 0 then
   begin
      MostraMsg('Aviso', 'Favor salvar a Meta antes!',mtWarning, [mbOk]);
      Exit;
   end;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      if TAdvGlowButton(Sender).Tag > 2 then
      begin
         QueAuxi.SQL.Text := 'SELECT 1 FROM '+iif(RadioFil.Checked,'arqmetafil','arqmetavnd')+' WHERE IDMetVen = '+auxIDMetVen.ToString+' LIMIT 1';
         QueAuxi.Open;
         if QueAuxi.IsEmpty then
         begin
            MostraMsg('Aviso', 'É necessário entrar primeiro com '+iif(RadioFil.Checked,'as filiais','os vendedores')+'!',mtWarning, [mbOk]);
            Exit;
         end;
      end; //if
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT DatHorIniMet,DatHorFinMet,TipMeta FROM arqmetas WHERE IDMetVen = '+auxIDMetVen.ToString+' LIMIT 1';
      QueAuxi.Open;
      auxFilVen  := iif(QueAuxi.FieldByName('TipMeta').AsString = 'F',0,1);
      auxDataIni := QueAuxi.FieldByName('DatHorIniMet').AsDateTime;
      auxDataFin := QueAuxi.FieldByName('DatHorFinMet').AsDateTime;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   if (TAdvGlowButton(Sender).Tag = 2) and RadioFil.Checked then
   begin
      MostraMsg('Aviso', 'o Formato de Metas é por Filial.',mtWarning, [mbOk]);
      Exit;
   end;
   if (TAdvGlowButton(Sender).Tag = 1) and RadioVen.Checked then
   begin
      MostraMsg('Aviso', 'o Formato de Metas é por Vendedor.',mtWarning, [mbOk]);
      Exit;
   end;

   if AtiForm <> nil then AtiForm.Close;
   case TAdvGlowButton(Sender).Tag of
      1: TAtiForm := TFrmMetaFil;
      2: TAtiForm := TFrmMetaVnd;
      3: TAtiForm := TFrmMetaGru;
      4: begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            QueAuxi.DataBase := DM.DWDataBase;
            try
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqmetagru WHERE IDMetVen = '+auxIDMetVen.ToString+' LIMIT 1';
               QueAuxi.Open;
               if QueAuxi.IsEmpty then
               begin
                  MostraMsg('Aviso', 'É necessário entrar primeiro com os Grupos!',mtWarning, [mbOk]);
                  Exit;
               end
               else TAtiForm := TFrmMetaSub;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end;
      5: TAtiForm := TFrmMetaFab;
      6: TAtiForm := TFrmMetaPro;
   end; //case
   AtiForm := TAtiForm.Create(nil);
   Ctx := TRttiContext.Create;
   try
      Field1 := Ctx.GetType(AtiForm.ClassType).GetField('recIDMeta');
      Field2 := Ctx.GetType(AtiForm.ClassType).GetField('recDataIni');
      Field3 := Ctx.GetType(AtiForm.ClassType).GetField('recDataFin');
      Field4 := Ctx.GetType(AtiForm.ClassType).GetField('recFilVen');
      if Assigned(Field1) then Field1.SetValue(AtiForm, auxIDMetVen);
      if Assigned(Field2) then Field2.SetValue(AtiForm, auxDataIni);
      if Assigned(Field3) then Field3.SetValue(AtiForm, auxDataFin);
      if Assigned(Field4) then Field4.SetValue(AtiForm, auxFilVen);
      AtiForm.Parent := PanelBas;
      AtiForm.Show;
   finally
      Ctx.Free;
   end;
end;

procedure TFrmMetaVen.btFecharClick(Sender: TObject);
begin
   Close;
end;

end.
