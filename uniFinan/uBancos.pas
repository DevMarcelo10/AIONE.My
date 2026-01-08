unit uBancos;

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
   LMDDBSpinEdit, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox;

type
   TFrmBancos = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    SouBanco: TDataSource;
    TabBanco: TRESTDWClientSQL;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    Shape1: TShape;
    PanelBckBut: TLMDSimplePanel;
    edBusBan: TLMDLabeledEdit;
    TabBancoCodban: TIntegerField;
    TabBancoAgeBco: TWideStringField;
    TabBancoContaBco: TWideStringField;
    TabBancoNomban: TWideStringField;
    TabBancoDigAgeBco: TWideStringField;
    TabBancoDigitoBco: TWideStringField;
    TabBancoCodCedBco: TWideStringField;
    TabBancoCodTraBco: TWideStringField;
    TabBancoMaxNroBco: TIntegerField;
    TabBancoUltNosNBco: TIntegerField;
    TabBancoModCobBco: TWideStringField;
    TabBancoCarCobBco: TWideStringField;
    TabBancoAceiteBco: TBooleanField;
    TabBancoPerMulBco: TFloatField;
    TabBancoPerMorBco: TFloatField;
    TabBancoNroSeqEnv: TIntegerField;
    TabBancoIDCon: TIntegerField;
    LMDLabel1: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledSpinEdit1: TLMDDBLabeledSpinEdit;
    LMDDBLabeledSpinEdit2: TLMDDBLabeledSpinEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledSpinEdit3: TLMDDBLabeledSpinEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBLabeledEdit23: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    TabBancoNomcon: TWideStringField;
    edCNABMod: TLMDLabeledListComboBox;
    TabBancoCNABMod: TWideStringField;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    TabBancoConvenio: TWideStringField;
    TabBancoIDFilial: TIntegerField;
    LMDDBLabeledEdit12: TLMDDBLabeledEdit;
    TabBancoNomfil: TWideStringField;
    edBusFil: TLMDLabeledEdit;
    btBusca: TAdvGlowButton;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit1Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edBusBanCustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit23KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit23CustomButtons0Click(Sender: TObject; index: Integer);
    procedure TabBancoAfterInsert(DataSet: TDataSet);
    procedure LMDDBLabeledEdit12KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit12CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edBusFilCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btBuscaClick(Sender: TObject);
    procedure edBusFilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBusBanKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function Salvar:Boolean;
  public
    { Public declarations }
  end;

var
   FrmBancos: TFrmBancos;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBancos.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBancos.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmBancos.FormShow(Sender: TObject);
begin
   SouBanco.DataSet := nil;
   TabBanco.SQL.Text := 'SELECT BAN.*,PLC.Nomcon,FIL.Nomfil FROM arqbanco BAN '+
   'LEFT JOIN arqfilial FIL ON BAN.IDFilial = FIL.IDFilial '+
   'LEFT JOIN arqplacon PLC ON BAN.IDCon = PLC.IDCon';
   TabBanco.Open;
   SouBanco.DataSet := TabBanco;
   TabBanco.Append;
   edCNABMod.ItemIndex := 1;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmBancos.btNovoClick(Sender: TObject);
begin
   if TabBanco.State in dsEditModes then TabBanco.Cancel;
   TabBanco.Append;
   LMDDBLabeledEdit1.Enabled := True;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmBancos.edBusBanCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqbanco',TLMDEdit(edBusBan),'Codban','Nomban','',0,True);
end;

procedure TFrmBancos.edBusBanKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqbanco',TLMDEdit(edBusBan),'Codban','Nomban','',Key,True);
end;

procedure TFrmBancos.edBusFilCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edBusFil),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmBancos.edBusFilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edBusFil),'IDFilial','Nomfil','',Key,True);
end;

procedure TFrmBancos.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmBancos.Salvar:Boolean;
var
   retID:Integer;
   FocusObject:TWinControl;
   QueAuxi:TRESTDWClientSQL;
   DBEditErro:TLMDDBLabeledEdit;
begin
   Result := True;
   if (TabBancoCodban.AsString.Trim = '') and (TabBancoNomBan.AsString.Trim = '') and (TabBancoIDFilial.AsInteger <= 0) then Exit;
   if TabBanco.State in dsEditModes then
   begin
      Result := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;

      if TabBancoIDFilial.AsInteger     <= 0  then DBEditErro := LMDDBLabeledEdit12 else
      if TabBancoCodban.AsString.Trim    = '' then DBEditErro := LMDDBLabeledEdit1  else
      if TabBancoNomban.AsString.Trim    = '' then DBEditErro := LMDDBLabeledEdit2  else
      if TabBancoAgeBco.AsString.Trim    = '' then DBEditErro := LMDDBLabeledEdit4  else
      if TabBancoContaBco.AsString.Trim  = '' then DBEditErro := LMDDBLabeledEdit10 else
      if TabBancoDigitoBco.AsString.Trim = '' then DBEditErro := LMDDBLabeledEdit3;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if

      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            if TabBanco.State = dsInsert then
            begin
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqbanco WHERE Codban = '+Aspas(TabBancoCodban.AsString.Trim)+' AND IDFilial = '+TabBancoIDFilial.AsString;
               QueAuxi.Open;
               if not QueAuxi.IsEmpty then
               begin
                  MostraMsg('Aviso','Já existe um Banco para essa Filial com esse código!', mtWarning, [mbOk]);
                  LMDDBLabeledEdit1.SetFocus;
                  Exit;
               end;
            end; //if
            TabBancoCNABMod.AsString := edCNABMod.Text;
            TabBanco.Post;
            btNovo.Click;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Bancos -> '+E.Message);
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

procedure TFrmBancos.TabBancoAfterInsert(DataSet: TDataSet);
begin
   TabBancoAceiteBco.Value := True;
   TabBancoPerMulBco.Value := 0.00;
   TabBancoPerMorBco.Value := 0.00;
   TabBancoCNABMod.Value   := '400';
   edCNABMod.ItemIndex     := 1;
end;

// -------------- Exclusão da Conta  ------------ //
procedure TFrmBancos.btBuscaClick(Sender: TObject);
begin
   if (edBusBan.Tag <= 0) or (edBusFil.Tag <= 0) then
   begin
      MostraMsg('Aviso', 'É preciso escolher Filial e Banco!',mtWarning, [mbOk]);
      edBusFil.SetFocus;
      Exit;
   end;
   TabBanco.Cancel;
   TabBanco.Locate('Codban;IDFilial',VarArrayOf([edBusBan.Tag, edBusFil.Tag]),[]);
   edCNABMod.Text := TabBancoCNABMod.AsString;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmBancos.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabBanco.State <> dsInsert) and (TabBancoCodban.AsString.Trim = '') then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            if MostraMsg('Confirmação','Confirma exclusão deste Banco?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'DELETE FROM arqbanco WHERE Codban = '+TabBancoCodban.AsString;
               QueAuxi.ExecSQL;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQBANCO CODIGO = '+TabBancoCodban.AsString+', Nomban = '+TabBancoNomban.AsString);
               TabBanco.Close;
               TabBanco.Open;
               btNovo.Click;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir Conta: arqbanco, Codban = '+TabBancoCodban.AsString+' -> '+E.Message);
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
      if TabBanco.State in dsEditModes then TabBanco.Cancel;
      btNovo.Click;
   end;
end;

procedure TFrmBancos.LMDDBLabeledEdit12CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabBanco,'arqfilial',TDBEdit(LMDDBLabeledEdit12),'IDFilial','IDFilial','Nomfil','Nomfil','',0);
end;

procedure TFrmBancos.LMDDBLabeledEdit12KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabBanco,'arqfilial',TDBEdit(LMDDBLabeledEdit12),'IDFilial','IDFilial','Nomfil','Nomfil','',Key);
end;

procedure TFrmBancos.LMDDBLabeledEdit1Enter(Sender: TObject);
begin
   if TabBanco.State <> dsInsert then LMDDBLabeledEdit2.SetFocus;
   LMDDBLabeledEdit1.Enabled := TabBanco.State = dsInsert;
end;

procedure TFrmBancos.LMDDBLabeledEdit23CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabBanco,'arqplacon',TDBEdit(LMDDBLabeledEdit23),'IDCon','IDCon','Nomcon','Nomcon','',0);
end;

procedure TFrmBancos.LMDDBLabeledEdit23KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabBanco,'arqplacon',TDBEdit(LMDDBLabeledEdit23),'IDCon','IDCon','Nomcon','Nomcon','',Key);
end;

procedure TFrmBancos.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmBancos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabBanco.Active then TabBanco.Close;
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;

end.

