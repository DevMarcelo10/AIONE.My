unit uNatFina;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, RxToolEdit, LMDDBRadioGroup,
   LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel, LMDCustomLabel,
   LMDCustomBevelPanel, Data.DB, Vcl.ExtCtrls, AdvGlowButton, MarcLib,
   AdvEdit, LMDEdit, Vcl.DBCtrls, uRESTDWBasicDB, LMDCustomParentPanel,
   LMDCustomGroupBox, LMDCustomButtonGroup, LMDCustomRadioGroup,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
   TFrmNatFin = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    SouNatFin: TDataSource;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    Shape1: TShape;
    PanelBase: TLMDSimplePanel;
    PanelBckBut: TLMDSimplePanel;
    PanelPagRec: TLMDSimplePanel;
    LMDDBLabeledEdit23: TLMDDBLabeledEdit;
    LMDDBLabeledEdit26: TLMDDBLabeledEdit;
    LMDDBLabeledEdit27: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    Shape2: TShape;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit0: TLMDDBLabeledEdit;
    edBusNat: TLMDLabeledEdit;
    LMDDBRadioGroup1: TLMDDBRadioGroup;
    TabNatFin: TRESTDWClientSQL;
    TabNatFinIDNatfin: TFDAutoIncField;
    TabNatFinDesnat: TWideStringField;
    TabNatFinCodconDebPro: TWideStringField;
    TabNatFinCodconCrePro: TWideStringField;
    TabNatFinCodconDebBai: TWideStringField;
    TabNatFinCodconCreBai: TWideStringField;
    TabNatFinRecDes: TWideStringField;
    TabNatFinNomconDebPro: TWideStringField;
    TabNatFinNomconCrePro: TWideStringField;
    TabNatFinNomconDebBai: TWideStringField;
    TabNatFinNomconCreBai: TWideStringField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit0DataChange(Sender: TObject);
    procedure LMDDBLabeledEdit1Enter(Sender: TObject);
    procedure LMDDBLabeledEdit23KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit23CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit4CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit11Exit(Sender: TObject);
    procedure LMDDBLabeledEdit3Exit(Sender: TObject);
    procedure LMDDBLabeledEdit5Exit(Sender: TObject);
    procedure LMDDBLabeledEdit7Exit(Sender: TObject);
    procedure edBusNatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBusNatCustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit6CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit6KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabNatFinAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    auxSQL:String;
    function Salvar:Boolean;
    function BuscaCod(recTabela, recCampo, recRetorno, recCodigo: String): String;
  public
    { Public declarations }
  end;

var
   FrmNatFin: TFrmNatFin;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmNatFin.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmNatFin.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmNatFin.FormShow(Sender: TObject);
begin
   auxSQL :=
   'SELECT NAT.*,'+
   'DEB1.Nomcon AS NomconDebPro,CRE1.Nomcon AS NomconCrePro,'+
   'DEB2.Nomcon AS NomconDebBai,CRE2.Nomcon AS NomconCreBai '+
   'FROM arqnatfin NAT '+
   'LEFT JOIN arqplacon DEB1 ON NAT.CodconDebPro = DEB1.Codcon '+
   'LEFT JOIN arqplacon CRE1 ON NAT.CodconCrePro = CRE1.Codcon '+
   'LEFT JOIN arqplacon DEB2 ON NAT.CodconDebBai = DEB2.Codcon '+
   'LEFT JOIN arqplacon CRE2 ON NAT.CodconCreBai = CRE2.Codcon ';
   TabNatFin.SQL.Text := auxSQL + 'ORDER BY NAT.Desnat LIMIT 1';
   TabNatFin.Open;
   TabNatFin.Append;
   SouNatFin.DataSet := TabNatFin;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmNatFin.LMDDBLabeledEdit0DataChange(Sender: TObject);
begin
   if TabNatFinIDNatFin.AsInteger > 0 then
        LMDDBLabeledEdit0.DataField := 'IDNatFin'
   else LMDDBLabeledEdit0.DataField := '';
end;

procedure TFrmNatFin.btNovoClick(Sender: TObject);
begin
   if not PanelPagRec.Visible then Exit;
   if TabNatFin.State in dsEditModes then TabNatFin.Cancel;
   TabNatFin.Close;
   TabNatFin.SQL.Text := auxSQL+' LIMIT 1';
   TabNatFin.Open;
   TabNatFin.Append;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmNatFin.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmNatFin.Salvar:Boolean;
var
   retID:Integer;
   FocusObject:TWinControl;
   QueAuxi:TRESTDWClientSQL;
   DBEditErro:TLMDDBLabeledEdit;
begin
   Result := True;
   if TabNatFin.State in dsEditModes then
   begin
      try
         Result := False;
         FocusObject := Screen.ActiveControl;
         PanelTop.SetFocus;
         FocusObject.SetFocus;
         if TabNatFinDesnat.AsString.Trim = '' then
         begin
            MostraMsg('Dado não informado','Favor preencher a Descrição da Natureza!',mtWarning, [mbOk]);
            LMDDBLabeledEdit2.SetFocus;
            Exit;
         end; //if

         if (Copy(TabNatFinCodconDebPro.AsString,1,1) <> '2') and (TabNatFinCodconDebPro.AsString.Trim <> '') then
         begin
            MostraMsg('Aviso','Contas de Provisão devem ser sempre do PASSIVO.',mtWarning, [mbOk]);
            LMDDBLabeledEdit11.SetFocus;
            Exit;
         end;
         if (Copy(TabNatFinCodconCrePro.AsString,1,1) <> '2') and (TabNatFinCodconCrePro.AsString.Trim <> '') then
         begin
            MostraMsg('Aviso','Contas de Provisão devem ser sempre do PASSIVO.',mtWarning, [mbOk]);
            LMDDBLabeledEdit3.SetFocus;
            Exit;
         end;

         if TabNatFin.State = dsInsert then
         begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            QueAuxi.DataBase := DM.DWDataBase;
            try
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqnatfin WHERE '+
               'CodconDebPro = '+Aspas(TabNatFinCodconDebPro.AsString)+' AND '+
               'CodconCrePro = '+Aspas(TabNatFinCodconCrePro.AsString)+' AND '+
               'CodconDebBai = '+Aspas(TabNatFinCodconDebBai.AsString)+' AND '+
               'CodconCreBai = '+Aspas(TabNatFinCodconCreBai.AsString);
               QueAuxi.Open;
               if not QueAuxi.IsEmpty then
               begin
                  MostraMsg('Aviso','Já existe uma Natureza com essas mesmas contas relacionadas!',mtWarning, [mbOk]);
                  LMDDBLabeledEdit2.SetFocus;
                  Exit;
               end;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end; //if

         retID := MyApplayUpdates(TabNatFin, 'IDNatFin', 'IDNatFin = '+TabNatFinIDNatFin.AsString, TabNatFin.State);
         if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
         TabNatFin.Cancel;
         TabNatFin.Close;
         TabNatFin.SQL.Text := auxSQL+' WHERE IDNatFin = '+retID.ToString;
         TabNatFin.Open;
         PanelBase.Visible := False;
         Sleep(10);
         PanelBase.Visible := True;
         edBusNat.Tag  := 0;
         edBusNat.Text := '';
         LMDDBLabeledEdit2.SetFocus;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao efetivar a busca da conta nas baixas de títulos -> '+E.Message);
            MostraMsg('Erro', 'Não foi efetivar a busca da conta!'+#10+E.Message, mtError, [mbOk]);
            Exit;
         end;
      end;
   end; //if
end;

procedure TFrmNatFin.TabNatFinAfterInsert(DataSet: TDataSet);
begin
   TabNatFinRecDes.Value := 'R';
end;

// ------------ Exclusão da Natureza ------------ //
procedure TFrmNatFin.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if not PanelPagRec.Visible then Exit;

   if (TabNatFin.State <> dsInsert) and (TabNatFinIDNatFin.Value > 0) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            if MostraMsg('Confirmação','Confirma exclusão da Natureza?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'DELETE FROM arqnatfin WHERE IDNatFin = '+TabNatFinIDNatFin.AsString;
               QueAuxi.ExecSQL;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQNATFIN IDNatFin = '+TabNatFinIDNatFin.AsString+', Desnat = '+TabNatFinDesnat.AsString);
               btNovo.Click;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir Natureza Financeira: arqnatfin, IDNatFin = '+TabNatFinIDNatFin.AsString+', Desnat = '+TabNatFinDesnat.AsString+' -> '+E.Message);
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
      if TabNatfin.State in dsEditModes then TabNatfin.Cancel;
      btNovo.Click;
   end;
end;

procedure TFrmNatFin.LMDDBLabeledEdit1Enter(Sender: TObject);
begin
   if TabNatfin.State <> dsInsert then LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmNatFin.LMDDBLabeledEdit23CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit23),'CodconDebPro','Codcon','Nomcon','NomconDebPro','Nivcon > "2"', 0);
end;
procedure TFrmNatFin.LMDDBLabeledEdit23KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit23),'CodconDebPro','Codcon','Nomcon','NomconDebPro','Nivcon > "2"', Key);
end;

procedure TFrmNatFin.LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit1),'CodconCrePro','Codcon','Nomcon','NomconCrePro','Nivcon > "2"', 0);
end;
procedure TFrmNatFin.LMDDBLabeledEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit1),'CodconCrePro','Codcon','Nomcon','NomconCrePro','Nivcon > "2"', Key);
end;

procedure TFrmNatFin.LMDDBLabeledEdit4CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit4),'CodconDebBai','Codcon','Nomcon','NomconDebBai','Nivcon > "2"', 0);
end;

procedure TFrmNatFin.LMDDBLabeledEdit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit4),'CodconDebBai','Codcon','Nomcon','NomconDebBai','Nivcon > "2"', Key);
end;

procedure TFrmNatFin.LMDDBLabeledEdit6CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit6),'CodconCreBai','Codcon','Nomcon','NomconCreBai','Nivcon > "2"', 0);
end;

procedure TFrmNatFin.LMDDBLabeledEdit6KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabNatFin,'arqplacon',TDBEdit(LMDDBLabeledEdit6),'CodconCreBai','Codcon','Nomcon','NomconCreBai','Nivcon > "2"', Key);
end;

procedure TFrmNatFin.LMDDBLabeledEdit11Exit(Sender: TObject);
begin
   if TLMDDBLabeledEdit(Sender).Text.Trim <> '' then
   begin
      if not (TabNatFin.State in dsEditModes) then TabNatFin.Edit;
      TabNatFinNomconDebPro.Value := BuscaCod('arqplacon','Codcon','Nomcon',TLMDDBLabeledEdit(Sender).Text.Trim);
   end;
end;

procedure TFrmNatFin.LMDDBLabeledEdit3Exit(Sender: TObject);
begin
   if TLMDDBLabeledEdit(Sender).Text.Trim <> '' then
   begin
      if not (TabNatFin.State in dsEditModes) then TabNatFin.Edit;
      TabNatFinNomconCrePro.Value := BuscaCod('arqplacon','Codcon','Nomcon',TLMDDBLabeledEdit(Sender).Text.Trim);
   end;
end;

procedure TFrmNatFin.LMDDBLabeledEdit5Exit(Sender: TObject);
begin
   if TLMDDBLabeledEdit(Sender).Text.Trim <> '' then
   begin
      if not (TabNatFin.State in dsEditModes) then TabNatFin.Edit;
      TabNatFinnOMconDebBai.Value := BuscaCod('arqplacon','Codcon','Nomcon',TLMDDBLabeledEdit(Sender).Text.Trim);
   end;
end;

procedure TFrmNatFin.LMDDBLabeledEdit7Exit(Sender: TObject);
begin
   if TLMDDBLabeledEdit(Sender).Text.Trim <> '' then
   begin
      if not (TabNatFin.State in dsEditModes) then TabNatFin.Edit;
      TabNatFinNomconCreBai.Value := BuscaCod('arqplacon','Codcon','Nomcon',TLMDDBLabeledEdit(Sender).Text.Trim);
   end;
end;

function TFrmNatFin.BuscaCod(recTabela,recCampo,recRetorno,recCodigo:String):String;
var
   QueryTmp:TRESTDWClientSQL;
begin
   Result := '';
   try
      QueryTmp := TRESTDWClientSQL.Create(nil);
      with QueryTmp do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT '+recRetorno+' FROM '+recTabela+' WHERE '+recCampo+' = '+Aspas(OnlyNumbers(recCodigo))+' AND Nivcon >= "3" LIMIT 1';
         Open;
         if not IsEmpty then
              Result := FieldByName(recRetorno).AsString
         else MostraMsg('Aviso', 'Código não encontrado ou não válido!',mtWarning, [mbOk]);
      end; //with
   finally
      QueryTmp.Close;
      FreeAndNil(QueryTmp);
   end;
end;

procedure TFrmNatFin.edBusNatCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqnatfin',TLMDEdit(edBusNat),'IDNatFin','Desnat','',0,True);
   if edBusNat.Tag > 0 then
   begin
      if TabNatFin.State in dsEditModes then TabNatFin.Cancel;
      TabNatFin.Close;
      TabNatFin.SQL.Text := auxSQL+' WHERE IDNatFin = '+edBusNat.Tag.ToString;
      TabNatFin.Open;
   end; //if
end;

procedure TFrmNatFin.edBusNatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqnatfin',TLMDEdit(edBusNat),'IDNatFin','Desnat','',Key);
   if edBusNat.Tag > 0 then
   begin
      if TabNatFin.State in dsEditModes then TabNatFin.Cancel;
      TabNatFin.Close;
      TabNatFin.SQL.Text := auxSQL+' WHERE IDNatFin = '+edBusNat.Tag.ToString;
      TabNatFin.Open;
   end; //if
end;

procedure TFrmNatFin.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmNatFin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabNatfin.Active then TabNatfin.Close;
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;

end.

