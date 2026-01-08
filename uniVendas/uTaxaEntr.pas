unit uTaxaEntr;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.StdCtrls,
   MarcLib, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   uRESTDWBasicTypes, uRESTDWBasicDB, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, LMDEdit,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
   LMDBaseEdit, LMDCustomEdit, LMDDBEdit, LMDBaseControl, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, AdvGlowButton, LMDControl, LMDCustomControl, Vcl.DBCtrls,
   LMDLabel,LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDButtonControl,
   LMDCustomCheckBox, LMDDBCheckBox, LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit,
   LMDDBSpinEdit, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox, LMDMaskEdit,
   LMDCheckBox;

type
   TFrmTaxaEntr = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    SouTaxEnt: TDataSource;
    TabTaxEnt: TRESTDWClientSQL;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    Shape1: TShape;
    PanelBckBut: TLMDSimplePanel;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    edBusca: TLMDLabeledEdit;
    TabTaxEntCEPIni: TWideStringField;
    TabTaxEntCEPFIn: TWideStringField;
    TabTaxEntHorIni: TTimeField;
    TabTaxEntHorFin: TTimeField;
    TabTaxEntVlrIni: TFloatField;
    TabTaxEntVlrFin: TFloatField;
    TabTaxEntPagPIX: TWideStringField;
    TabTaxEntPagCre: TWideStringField;
    TabTaxEntPagDeb: TWideStringField;
    TabTaxEntPagDin: TWideStringField;
    TabTaxEntPagPra: TWideStringField;
    TabTaxEntPagChe: TWideStringField;
    TabTaxEntIDTaxEnt: TFDAutoIncField;
    TabTaxEntDestax: TWideStringField;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    btFiliais: TAdvGlowButton;
    btCidades: TAdvGlowButton;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    edHorini: TLMDMaskEdit;
    LMDLabel6: TLMDLabel;
    LMDLabel4: TLMDLabel;
    edHorfin: TLMDMaskEdit;
    LMDLabel5: TLMDLabel;
    LMDLabel7: TLMDLabel;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBCheckBox1: TLMDDBCheckBox;
    LMDDBCheckBox2: TLMDDBCheckBox;
    LMDDBCheckBox3: TLMDDBCheckBox;
    LMDDBCheckBox4: TLMDDBCheckBox;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBCheckBox6: TLMDDBCheckBox;
    TabTaxEntVlrTaxEnt: TFloatField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabTaxEntAfterInsert(DataSet: TDataSet);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btCidadesClick(Sender: TObject);
    procedure btFiliaisClick(Sender: TObject);
  private
    { Private declarations }
    procedure BuscaTaxa;
    function  Salvar:Boolean;
  public
    { Public declarations }
  end;

var
   FrmTaxaEntr: TFrmTaxaEntr;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uTaxCidBai, uTaxaFilial;

procedure TFrmTaxaEntr.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTaxaEntr.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmTaxaEntr.FormShow(Sender: TObject);
begin
   SouTaxEnt.DataSet := nil;
   TabTaxEnt.SQL.Text := 'SELECT * FROM arqtaxaent LIMIT 1';
   TabTaxEnt.Open;
   SouTaxEnt.DataSet := TabTaxEnt;
   TabTaxEnt.Append;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmTaxaEntr.btNovoClick(Sender: TObject);
begin
   LMDDBLabeledEdit1.DataField := '';
   if TabTaxEnt.State in dsEditModes then TabTaxEnt.Cancel;
   TabTaxEnt.Append;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmTaxaEntr.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmTaxaEntr.Salvar:Boolean;
var
   retID:Integer;
   FocusObject:TWinControl;
   DBEditErro:TLMDDBLabeledEdit;
begin
   Result := True;
   if TabTaxEnt.State in dsEditModes then
   begin
      Result := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;

      if TabTaxEntDestax.AsString.Trim = '' then DBEditErro := LMDDBLabeledEdit2;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if

      try
         TabTaxEntHorIni.Value := edHorini.AsTime;
         TabTaxEntHorFin.Value := edHorFin.AsTime;
         TabTaxEnt.Post;
         LMDDBLabeledEdit1.DataField := 'IDTaxEnt';
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Taxas -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
            Exit;
         end;
      end;
      PanelCadastro.Visible := False;
      Sleep(10);
      PanelCadastro.Visible := True;
   end; //if
   Result := True;
end;

procedure TFrmTaxaEntr.TabTaxEntAfterInsert(DataSet: TDataSet);
begin
   edHorini.Text := '00:00';
   edHorfin.Text := '00:00';
   TabTaxEntPagPIX.Value := '1';
   TabTaxEntPagCre.Value := '1';
   TabTaxEntPagDeb.Value := '1';
   TabTaxEntPagDin.Value := '1';
   TabTaxEntPagPra.Value := '1';
   TabTaxEntPagChe.Value := '0';
   TabTaxEntVlrIni.Value    := 0.00;
   TabTaxEntVlrFin.Value    := 0.00;
   TabTaxEntVlrTaxEnt.Value := 0.00;
end;

// -------------- Exclusão da Conta  ------------ //
procedure TFrmTaxaEntr.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabTaxEnt.State <> dsInsert then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            if MostraMsg('Confirmação','Confirma exclusão desta Taxa?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Add('DELETE FROM arqtaxaent WHERE IDTaxEnt = '+TabTaxEntIDTaxEnt.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqtaxafil WHERE IDTaxEnt = '+TabTaxEntIDTaxEnt.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqtaxaentmun WHERE IDTaxEnt = '+TabTaxEntIDTaxEnt.AsString+';');
               QueAuxi.ExecSQL;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQTAXAENT ID = '+TabTaxEntIDTaxEnt.AsString+', Taxa = '+TabTaxEntDestax.AsString);
               TabTaxEnt.Close;
               TabTaxEnt.Open;
               btNovo.Click;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir Taxa de Entrega: arqtaxaent, ID = '+TabTaxEntIDTaxEnt.AsString+' -> '+E.Message);
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
      if TabTaxEnt.State in dsEditModes then TabTaxEnt.Cancel;
      btNovo.Click;
   end;
end;

procedure TFrmTaxaEntr.edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqtaxaent',TLMDEdit(edBusca),'IDTaxEnt','Destax','',0,True);
   BuscaTaxa;
end;

procedure TFrmTaxaEntr.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqtaxaent',TLMDEdit(edBusca),'IDTaxEnt','Destax','',Key,True);
   BuscaTaxa;
end;

procedure TFrmTaxaEntr.BuscaTaxa;
begin
   if edBusca.Tag <= 0 then
   begin
      MostraMsg('Aviso', 'É preciso escolher uma Taxa!',mtWarning, [mbOk]);
      edBusca.SetFocus;
      Exit;
   end;
   TabTaxEnt.Cancel;
   TabTaxEnt.Close;
   TabTaxEnt.SQL.Text := 'SELECT * FROM arqtaxaent WHERE IDTaxEnt = '+edBusca.Tag.ToString;
   TabTaxEnt.Open;
   edBusca.Clear;
   edBusca.Tag := 0;
   edHorini.AsTime := TabTaxEntHorIni.Value;
   edHorFin.AsTime := TabTaxEntHorFin.Value;
   LMDDBLabeledEdit1.DataField := 'IDTaxEnt';
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmTaxaEntr.btCidadesClick(Sender: TObject);
begin
   if TabTaxEnt.State in dsEditModes then
   begin
      MostraMsg('Aviso', 'Favor Salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   FrmTaxCidBai := TFrmTaxCidBai.Create(Application);
   try
      FrmTaxCidBai.recIDTaxEnt := TabTaxEntIDTaxEnt.Value;
      FrmTaxCidBai.ShowModal;
   finally
      FrmTaxCidBai.Free;
   end;
end;

procedure TFrmTaxaEntr.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmTaxaEntr.btFiliaisClick(Sender: TObject);
begin
   if TabTaxEnt.State in dsEditModes then
   begin
      MostraMsg('Aviso', 'Favor Salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   FrmTaxaFilial := TFrmTaxaFilial.Create(Application);
   try
      FrmTaxaFilial.recIDTaxEnt := TabTaxEntIDTaxEnt.Value;
      FrmTaxaFilial.ShowModal;
   finally
      FrmTaxaFilial.Free;
   end;
end;

procedure TFrmTaxaEntr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabTaxEnt.Active then TabTaxEnt.Close;
   FadeInOut(Self,'Out',10);
end;

end.

