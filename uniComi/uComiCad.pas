unit uComiCad;

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
   FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, LMDCustomParentPanel,
   LMDCustomGroupBox, LMDCustomButtonGroup, LMDCustomRadioGroup, LMDDBRadioGroup,
   System.Rtti;

type
  TFrmComiCad = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btVoltar: TAdvGlowButton;
    TabComi: TRESTDWClientSQL;
    SouComi: TDataSource;
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
    LMDDBCheckBox11: TLMDDBCheckBox;
    LMDDBCheckBox12: TLMDDBCheckBox;
    LMDDBCheckBox13: TLMDDBCheckBox;
    LMDDBCheckBox14: TLMDDBCheckBox;
    LMDDBCheckBox15: TLMDDBCheckBox;
    LMDDBCheckBox1: TLMDDBCheckBox;
    LMDDBLabeledEdit29: TLMDDBLabeledEdit;
    btNovo: TAdvGlowButton;
    btPrgres: TAdvGlowButton;
    TabComiIDComi: TFDAutoIncField;
    TabComiDesComi: TWideStringField;
    TabComiPerDesIni: TFloatField;
    TabComiPerDesFin: TFloatField;
    TabComiQtdIni: TFloatField;
    TabComiQtdFin: TFloatField;
    TabComiPerCom: TFloatField;
    TabComiVlrCom: TFloatField;
    TabComiDatIni: TDateField;
    TabComiDatFin: TDateField;
    TabComiIndVenDin: TWideStringField;
    TabComiIndVenPix: TWideStringField;
    TabComiIndVenDeb: TWideStringField;
    TabComiIndVenCre: TWideStringField;
    TabComiIndVenPra: TWideStringField;
    TabComiIndVenChe: TWideStringField;
    TabComiIndDesEst: TWideStringField;
    TabComiTipComi: TWideStringField;
    TabComiIndProg: TWideStringField;
    TabComiIndAtivo: TWideStringField;
    PanelBack: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    PanelButMen: TLMDSimplePanel;
    PanelBas: TLMDSimplePanel;
    btProduto: TAdvGlowButton;
    btClientes: TAdvGlowButton;
    btGrupo: TAdvGlowButton;
    btFabri: TAdvGlowButton;
    LMDDBRadioGroup1: TLMDDBRadioGroup;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDLabel7: TLMDLabel;
    LMDDBCheckBox2: TLMDDBCheckBox;
    btSubGru: TAdvGlowButton;
    LMDDBRadioGroup2: TLMDDBRadioGroup;
    TabComiBasComi: TWideStringField;
    btFilial: TAdvGlowButton;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btVoltarClick(Sender: TObject);
    procedure TabComiAfterInsert(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPrgresClick(Sender: TObject);
    procedure LMDDBLabeledEdit2DataChange(Sender: TObject);
    procedure LMDDBRadioGroup1Change(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure LMDDBRadioGroup2Change(Sender: TObject);
    function  VerDuplica(recIDComi,recCodigo:Integer; recTipCod:String):Boolean;
  private
    { Private declarations }
    auxSQL:String;
    procedure FechaSubForms;
    function  Salvar(recBtProg:Boolean):Boolean;
    procedure VerTemProgr;
    function TemMaster: Boolean;
  public
    { Public declarations }
    AtiForm:TForm;
    recIDComi:Integer;
    recCampo,recValor:String;
  end;

var
   FrmComiCad: TFrmComiCad;
   basIDComi: Integer = 0;

implementation

{$R *.dfm}

uses uDM, uConst, uMenCad, uPrincipal, uComissao, uLibFarm, uComiGru, uComiSub,
     uComiFab, uComiPro, uComiFil, uComiVen, uComiPgr;

procedure TFrmComiCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmComiCad.FormShow(Sender: TObject);
begin
   auxSQL := 'SELECT * FROM arqcomi ';
   SouComi.DataSet  := nil;
   TabComi.SQL.Text := auxSQL+iif(recIDComi > 0,' WHERE IDComi = '+recIDComi.ToString,'')+' LIMIT 1';
   TabComi.Open;
   if recIDComi <= 0 then TabComi.Append;
   SouComi.DataSet := TabComi;
   VerTemProgr;
end;

procedure TFrmComiCad.VerTemProgr;
var
   QueAuxi:TRESTDWClientSQL;
begin
   if recIDComi > 0 then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text := 'SELECT 1 FROM arqcomipgr WHERE IDComi = '+recIDComi.ToString;
         QueAuxi.Open;
         LMDDBLabeledEdit29.Enabled := QueAuxi.IsEmpty;
         LMDDBLabeledEdit3.Enabled  := QueAuxi.IsEmpty;
         LMDDBLabeledEdit4.Enabled  := QueAuxi.IsEmpty;
         TabComi.Edit;
         TabComiIndProg.Value := iif(QueAuxi.IsEmpty,'0','1');
         TabComi.Post;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
end;

procedure TFrmComiCad.LMDDBLabeledEdit2DataChange(Sender: TObject);
begin
   if LMDDBLabeledEdit2.Field <> nil then
   begin
      if LMDDBLabeledEdit2.Field.FieldName = 'IDComi' then
      begin
         if TabComiIDComi.AsInteger > 0 then
              LMDDBLabeledEdit2.DataField := 'IDComi'
         else LMDDBLabeledEdit2.DataField := '';
      end;
   end; //if
end;

procedure TFrmComiCad.LMDDBRadioGroup1Change(Sender: TObject);
begin
   if LMDDBRadioGroup1.ItemIndex = 0 then
   begin
      LMDDBLabeledEdit29.DataField := 'PerDesIni';
      LMDDBLabeledEdit3.DataField  := 'PerDesFin';
      LMDDBLabeledEdit29.EditLabel.Caption := '% DESC.INI.';
      LMDDBLabeledEdit3.EditLabel.Caption  := '% DESC.FIN.';
   end else
   begin
      LMDDBLabeledEdit29.DataField := 'QtdIni';
      LMDDBLabeledEdit3.DataField  := 'QtdFin';
      LMDDBLabeledEdit29.EditLabel.Caption := 'QTD.INIC.';
      LMDDBLabeledEdit3.EditLabel.Caption  := 'QTD.FINAL';
   end; //if
end;

procedure TFrmComiCad.LMDDBRadioGroup2Change(Sender: TObject);
begin
   if LMDDBRadioGroup2.ItemIndex = 1 then
   begin
      LMDDBLabeledEdit4.DataField := 'PerCom';
      LMDDBLabeledEdit4.EditLabel.Caption := '% COMI.'
   end else
   begin
      LMDDBLabeledEdit4.DataField := 'VlrCom';
      LMDDBLabeledEdit4.EditLabel.Caption := 'VALOR R$'
   end;
end;

procedure TFrmComiCad.TabComiAfterInsert(DataSet: TDataSet);
begin
   TabComiDatIni.Clear;
   TabComiDatFin.Clear;
   TabComiIndVenPix.Value := '1';
   TabComiIndVenDin.Value := '1';
   TabComiIndVenDeb.Value := '1';
   TabComiIndVenCre.Value := '1';
   TabComiIndVenPra.Value := '1';
   TabComiIndVenChe.Value := '1';
   TabComiTipComi.Value   := 'D';
   TabComiBasComi.Value   := 'C';
   TabComiIndAtivo.Value  := '1';
   TabComiIndProg.Value   := '0';
   TabComiIndDesEst.Value := '0';
   TabComiPerDesIni.Value := 0.00;
   TabComiPerDesFin.Value := 0.00;
   TabComiPerCom.Value    := 0.00;
end;

procedure TFrmComiCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmComiCad.btSalvarClick(Sender: TObject);
begin
   Salvar(False);
end;

// ------------------- Salvar ------------------- //
function TFrmComiCad.Salvar(recBtProg:Boolean):Boolean;
var
   Erro,retID:Integer;
   FocusObject:TWinControl;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := True;
   FocusObject := Screen.ActiveControl;
   PanelTop.SetFocus;
   Erro := 0;
   if not (TabComi.State in dsEditModes) then TabComi.Edit;
   if TabComiDesComi.AsString.Trim.Length < 6 then Erro := 1 else
   if DBDateEdit1.Date < 10 then Erro := 2 else
   if DBDateEdit2.Date < 10 then Erro := 3 else
   if DBDateEdit1.Date > DBDateEdit2.Date then Erro := 4 else
   if TabComiPerDesIni.Value > TabComiPerDesFin.Value then Erro := 6 else
   if TabComiQtdIni.Value > TabComiQtdFin.Value then Erro := 10 else
   if (TabComiIndProg.Value = '0') and (not recBtProg) then
   begin
      if TabComiTipComi.Value = 'D' then
      begin
         if TabComiPerDesFin.Value <= 0 then Erro := 5;
      end else
      begin
         if TabComiQtdFin.Value <= 0 then Erro := 7;
      end;
      if (TabComiPerCom.Value <= 0.00) and (TabComiVlrCom.Value <= 0.00) then Erro := 8 else
      if (TabComiPerCom.Value >  0.00) and (TabComiVlrCom.Value >  0.00) then Erro := 9;
   end; //if
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
         MostraMsg('Aviso', 'A data inicial da ativação deve ser preenchida!', mtWarning, [mbOk]);
         DBDateEdit1.SetFocus;
      end else
      if Erro = 3 then
      begin
         MostraMsg('Aviso', 'A data final da ativação deve ser preenchida!', mtWarning, [mbOk]);
         DBDateEdit2.SetFocus;
      end else
      if Erro = 4 then
      begin
         MostraMsg('Aviso', 'A data inicial está maior que data final!', mtWarning, [mbOk]);
         DBDateEdit1.SetFocus;
      end else
      if Erro = 5 then
      begin
         MostraMsg('Aviso', 'Percentual desc. final deve ser preenchido!', mtWarning, [mbOk]);
         LMDDBLabeledEdit3.SetFocus;
      end else
      if Erro = 6 then
      begin
         MostraMsg('Aviso', 'O percentual inicial está maior que o percentual final!', mtWarning, [mbOk]);
         LMDDBLabeledEdit29.SetFocus;
      end else
      if Erro = 10 then
      begin
         MostraMsg('Aviso', 'A quantidade inicial está maior que a quantidade final!', mtWarning, [mbOk]);
         LMDDBLabeledEdit29.SetFocus;
      end else
      if Erro = 7 then
      begin
         MostraMsg('Aviso', 'Quantidade final deve ser preenchida!', mtWarning, [mbOk]);
         LMDDBLabeledEdit29.SetFocus;
      end else
      if Erro = 8 then
      begin
         MostraMsg('Aviso', 'Colocar % de comissão ou Valor!', mtWarning, [mbOk]);
         LMDDBLabeledEdit4.SetFocus;
      end else
      if Erro = 9 then
      begin
         MostraMsg('Aviso', 'Somente é permitido % de comissão ou Valor!', mtWarning, [mbOk]);
         LMDDBLabeledEdit4.SetFocus;
      end; //if
      Exit;
   end; //if

   if TabComiTipComi.Value = 'D' then
   begin
      TabComiQtdIni.Value := 0.00;
      TabComiQtdFin.Value := 0.00;
   end else
   begin
      TabComiPerDesIni.Value := 0.00;
      TabComiPerDesFin.Value := 0.00;
   end;

   if TabComiIndProg.Value = '1' then
   begin
      TabComiQtdIni.Value := 0.00;
      TabComiQtdFin.Value := 0.00;
      TabComiPerCom.Value := 0.00;
      TabComiVlrCom.Value := 0.00;
      TabComiPerDesIni.Value := 0.00;
      TabComiPerDesFin.Value := 0.00;
      LMDDBLabeledEdit29.Enabled := False;
      LMDDBLabeledEdit3.Enabled  := False;
      LMDDBLabeledEdit4.Enabled  := False;
   end; //if

   try
      retID := MyApplayUpdates(TabComi, 'IDComi', 'IDComi = '+recIDComi.ToString, TabComi.State);
      if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
      if retID > 0 then recIDComi := retID;
      TabComi.Cancel;
      TabComi.Close;
      TabComi.SQL.Text := auxSQL+' WHERE IDComi = '+recIDComi.ToString+' LIMIT 1';
      TabComi.Open;
   except
      on E:Exception do
      begin
         Result := False;
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Regra de Comissão -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
         Exit;
      end;
   end;
   PanelCadastro.Visible := False;
   Sleep(10);
   PanelCadastro.Visible := True;
end;

function TFrmComiCad.TemMaster:Boolean;
var
   temFil,temVen:Boolean;
   QueAuxi:TRESTDWClientSQL;
begin
   Result  := True;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         try
            SQL.Text := 'SELECT 1 FROM arqcomifil WHERE IDComi = '+TabComiIDComi.AsString+' LIMIT 1';
            QueAuxi.Open;
            temFil := not QueAuxi.IsEmpty;
            QueAuxi.Close;
            SQL.Text := 'SELECT 1 FROM arqcomiven WHERE IDComi = '+TabComiIDComi.AsString+' LIMIT 1';
            QueAuxi.Open;
            temVen := not QueAuxi.IsEmpty;
            if (not temVen) and (not temFil) then
            begin
               Result := False;
               MostraMsg('Aviso', 'É necessário escolher Filiais e/ou Vendedores!',mtWarning, [mbOk]);
               Exit;
            end;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar buscar registros iguais: arqcomi, IDComi = '+TabComiIDComi.AsString+' -> '+E.Message);
               Exit;
            end;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

function TFrmComiCad.VerDuplica(recIDComi,recCodigo:Integer; recTipCod:String):Boolean;
var
   QueAuxi:TRESTDWClientSQL;
   recDatIni,recDatFin:TDateTime;
begin
   Result  := True;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         try
            SQL.Text := 'SELECT DatIni,DatFin FROM arqcomi WHERE IDComi = '+recIDComi.ToString;
            Open;
            recDatIni := FieldByName('DatIni').AsDateTime;
            recDatFin := FieldByName('DatFin').AsDateTime;
            Close;
            SQL.Text := 'SELECT DISTINCT C.DesComi,CF.IDFilial FROM arqcomi C LEFT JOIN arqcomifil CF ON '+
            'CF.IDComi = C.IDComi AND CF.IDFilial IN (SELECT IDFilial FROM arqcomifil WHERE IDComi = '+recIDComi.ToString+') ';
            if recTipCod = 'PRO' then SQL.Add('LEFT JOIN arqcomipro CP ON CP.IDComi = C.IDComi WHERE  CP.IDProd = ' +recCodigo.ToString) else
            if recTipCod = 'GRU' then SQL.Add('LEFT JOIN arqcomigru CG ON CG.IDComi = C.IDComi WHERE CG.IDGrupo = ' +recCodigo.ToString) else
            if recTipCod = 'SUB' then SQL.Add('LEFT JOIN arqcomisub CS ON CS.IDComi = C.IDComi WHERE CS.IDGruSub = '+recCodigo.ToString) else
            if recTipCod = 'FAB' then SQL.Add('LEFT JOIN arqcomifab FA ON FA.IDComi = C.IDComi WHERE  FA.IDPess = ' +recCodigo.ToString) else
            if recTipCod = 'VEN' then SQL.Add('LEFT JOIN arqcomiven VE ON VE.IDComi = C.IDComi WHERE  VE.IDPess = ' +recCodigo.ToString);
            SQL.Add(' AND C.IDComi != '+recIDComi.ToString+
            ' AND (C.DatIni BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',recDatIni))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',recDatFin))+
            ' OR   C.DatFin BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',recDatIni))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',recDatFin))+')');
            QueAuxi.Open;
            if not IsEmpty then
            begin
               if recTipCod = 'PRO' then MostraMsg('Aviso', 'Produto já está associado à regra '+   FieldByName('DesComi').AsString+'!',mtWarning, [mbOk]) else
               if recTipCod = 'GRU' then MostraMsg('Aviso', 'Grupo já está associado à regra '+     FieldByName('DesComi').AsString+'!',mtWarning, [mbOk]) else
               if recTipCod = 'SUB' then MostraMsg('Aviso', 'Sub Grupo já está associado à regra '+ FieldByName('DesComi').AsString+'!',mtWarning, [mbOk]) else
               if recTipCod = 'FAB' then MostraMsg('Aviso', 'Fabricante já está associado à regra '+FieldByName('DesComi').AsString+'!',mtWarning, [mbOk]) else
               if recTipCod = 'VEN' then MostraMsg('Aviso', 'Vendedor já está associado à regra '+  FieldByName('DesComi').AsString+'!',mtWarning, [mbOk]);
               Exit;
            end; //if
            Result := False;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar buscar registros iguais: arqcomi, IDComi = '+TabComiIDComi.AsString+' -> '+E.Message);
               Exit;
            end;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmComiCad.btNovoClick(Sender: TObject);
begin
   if TabComi.State in dsEditModes then
      if MostraMsg('Confirmação', 'A regra em tela não foi salva. Deseja cancelar e gerar uma nova?', mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   if AtiForm <> nil then AtiForm.Close;
   TabComi.Cancel;
   TabComi.Append;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmComiCad.btPrgresClick(Sender: TObject);
begin
   if not Salvar(True) then Exit;
   if (TabComiQtdIni.Value > 0.00) or (TabComiPerDesIni.Value > 0.00) then
   begin
      if MostraMsg('Confirmação', 'Já foi escolhido um % ou valor, deseja mudar a modalidade?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         TabComi.Edit;
         TabComiQtdIni.Value := 0.00;
         TabComiQtdFin.Value := 0.00;
         TabComiPerDesIni.Value := 0.00;
         TabComiPerDesFin.Value := 0.00;
         TabComiPerCom.Value    := 0.00;
         TabComiVlrCom.Value    := 0.00;
         TabComiIndProg.Value   := '1';
         TabComi.Post;
         LMDDBLabeledEdit29.Enabled := False;
         LMDDBLabeledEdit3.Enabled  := False;
         LMDDBLabeledEdit4.Enabled  := False;
      end
      else Exit;
   end; //if
   try
      FrmComiPgr := TFrmComiPgr.Create(Application);
      FrmComiPgr.recIDComi := TabComiIDComi.Value;
      FrmComiPgr.recValCom := TabComiBasComi.Value;
      FrmComiPgr.recDesQtd := TabComiTipComi.Value;
      FrmComiPgr.ShowModal;
   finally
      VerTemProgr;
      FrmComiPgr.Free;
   end;
end;

// ------------- Exclusão de Regras ------------ //
procedure TFrmComiCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabComi.State <> dsInsert) and (TabComiIDComi.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            if MostraMsg('Confirmação', 'Deseja realmente excluir esta regra de Comissão?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqcomipgr WHERE IDComi = '+TabComiIDComi.AsString+';');
                  SQL.Add('DELETE FROM arqcomiven WHERE IDComi = '+TabComiIDComi.AsString+';');
                  SQL.Add('DELETE FROM arqcomipro WHERE IDComi = '+TabComiIDComi.AsString+';');
                  SQL.Add('DELETE FROM arqcomisub WHERE IDComi = '+TabComiIDComi.AsString+';');
                  SQL.Add('DELETE FROM arqcomigru WHERE IDComi = '+TabComiIDComi.AsString+';');
                  SQL.Add('DELETE FROM arqcomifil WHERE IDComi = '+TabComiIDComi.AsString+';');
                  SQL.Add('DELETE FROM arqcomifab WHERE IDComi = '+TabComiIDComi.AsString+';');
                  SQL.Add('DELETE FROM arqcomi    WHERE IDComi = '+TabComiIDComi.AsString+';');
                  ExecSQL;
                  Self.Close;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir registro do aquivo: arqcomi, IDComi = '+TabComiIDComi.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQCOMI IDComi = '+TabComiIDComi.AsString);
            end; //if
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end else
   begin
      TabComi.Cancel;
      TabComi.Append;
   end;
end;

procedure TFrmComiCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmComiCad.MenuClick(Sender: TObject);
var
   TAtiForm:TFormClass;
   Ctx:TRttiContext;
   Field:TRttiField;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabComiIDComi.Value <= 0 then
   begin
      MostraMsg('Aviso', 'Favor salvar a Regra antes!',mtWarning, [mbOk]);
      Exit;
   end;

   if (TAdvGlowButton(Sender).Tag <> 4) and (TAdvGlowButton(Sender).Tag <> 5) then
      if not TemMaster then Exit;

   if AtiForm <> nil then AtiForm.Close;
   case TAdvGlowButton(Sender).Tag of
      1: TAtiForm := TFrmComiGru;
      2: begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            QueAuxi.DataBase := DM.DWDataBase;
            try
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqcomigru WHERE IDComi = '+TabComiIDComi.AsString+' LIMIT 1';
               QueAuxi.Open;
               if QueAuxi.IsEmpty then
               begin
                  MostraMsg('Aviso', 'É necessário entrar primeiro com os Grupos!',mtWarning, [mbOk]);
                  Exit;
               end
               else TAtiForm := TFrmComiSub;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end;
      3: TAtiForm := TFrmComiFab;
      4: TAtiForm := TFrmComiPro;
      5: TAtiForm := TFrmComiFil;
      6: TAtiForm := TFrmComiVen;
   end; //case
   AtiForm := TAtiForm.Create(nil);
   Ctx := TRttiContext.Create;
   try
      Field := Ctx.GetType(AtiForm.ClassType).GetField('recIDComi');
      if Assigned(Field) then Field.SetValue(AtiForm, TabComiIDComi.Value);
      AtiForm.Parent := PanelBas;
      AtiForm.Show;
   finally
      Ctx.Free;
   end;
end;

procedure TFrmComiCad.btVoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmComiCad.FechaSubForms;
var
   I:Integer;
begin
   for I := Application.ComponentCount - 1 downto 0 do
   begin
      if (Application.Components[I] is TFrmPrincipal) or (Application.Components[I] is TFrmMenCad) or
         (Application.Components[I] is TFrmComissao)  or (Application.Components[I] is TFrmComissao) then Continue;
      try
         if Application.Components[I] is TForm then (Application.Components[I] as TForm).Close;
      except
      end;
   end; //for
end;

procedure TFrmComiCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabComi.State in dsEditModes then TabComi.Cancel;
   TabComi.Close;
   FadeInOut(Self,'Out',10);
   SimularCliqueControlePorNome('FrmComissao','edbusca');
   Action := caFree;
end;

end.


