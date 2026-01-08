unit uGrupos;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, LMDEdit,
   LMDCustomPanel, LMDSimplePanel, AdvGlowButton, MarcLib, LMDBaseEdit,
   LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDCustomBevelPanel, LMDDBCheckBox, Vcl.ExtCtrls, Vcl.StdCtrls,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Vcl.DBCtrls,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   uRESTDWBasicDB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmGrupos = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomgru: TLMDLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBCheckBox1: TLMDDBCheckBox;
    LMDDBCheckBox2: TLMDDBCheckBox;
    LMDDBCheckBox3: TLMDDBCheckBox;
    LMDDBCheckBox4: TLMDDBCheckBox;
    LMDDBCheckBox6: TLMDDBCheckBox;
    Shape1: TShape;
    LMDSimplePanel2: TLMDSimplePanel;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    edTippro: TLMDDBLabeledEdit;
    TabGrupo: TRESTDWClientSQL;
    TabGrupoIDGrupo: TIntegerField;
    TabGrupoDesgru: TWideStringField;
    TabGrupoIDTippro: TSmallintField;
    TabGrupoMarkup: TFloatField;
    TabGrupoPercom: TFloatField;
    TabGrupoDescMax: TFloatField;
    TabGrupoIndEtiq: TBooleanField;
    TabGrupoDescPra: TBooleanField;
    TabGrupoPreEtiq: TBooleanField;
    TabGrupoSolPerf: TBooleanField;
    TabGrupoIndLote: TBooleanField;
    TabGrupoInfPresc: TBooleanField;
    TabGrupoDesTippro: TWideStringField;
    SouGrupo: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure TabGrupoAfterInsert(DataSet: TDataSet);
    procedure edTipproCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edTipproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edTipproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmGrupos: TFrmGrupos;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uTipoProSer;

procedure TFrmGrupos.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmGrupos.FormShow(Sender: TObject);
begin
   TabGrupo.SQL.Text := 'SELECT GRU.*,TIP.DesTippro FROM arqgrupo GRU LEFT JOIN ';
   TabGrupo.SQL.Add('arqprodutotip TIP ON GRU.IDTippro = TIP.IDTippro ');
   TabGrupo.Open;
   TabGrupo.Append;
   edNomgru.SetFocus;
end;

procedure TFrmGrupos.TabGrupoAfterInsert(DataSet: TDataSet);
begin
   TabGrupoMarkup.Value  := 0.00;
   TabGrupoPercom.Value  := 0.00;
   TabGrupoDescMax.Value := 0.00;
   TabGrupoIndEtiq.Value := False;
   TabGrupoPreEtiq.Value := False;
   TabGrupoDescPra.Value := False;
   TabGrupoSolPerf.Value := False;
   TabGrupoIndLote.Value := False;
   TabGrupoInfPresc.Value := False;
end;

procedure TFrmGrupos.btSalvarClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelTop.SetFocus;
   if TabGrupo.State in dsEditModes then
   begin
      if Length(TabGrupoDesgru.Value) <= 2 then Erro := 1;
      if Erro > 0 then
      begin
         if Erro = 1 then
         begin
            MostraMsg('Aviso', 'Entrar com a descrição do grupo!', mtWarning, [mbOk]);
            LMDDBLabeledEdit1.SetFocus;
         end; //if
         Exit;
      end; //if
      try
         try
            TabGrupo.Post;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO,PastaLog, 'ERRO ao tentar salvar Grupo de Produtos -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar.',mtError,[mbOk]);
               Exit;
            end; //on
         end;
      finally
         btNovo.Click;
      end;
   end; //if
end;

procedure TFrmGrupos.edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if (TabGrupo.State in dsEditModes) and (Trim(TabGrupoDesgru.Value) <> '') and TabGrupo.Modified then
   begin
      MostraMsg('Acão', 'É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   TabGrupo.Cancel;
   btBuscas('arqgrupo',TLMDEdit(edNomgru),'IDGrupo','Desgru','',0);
   if edNomgru.Tag > 0 then
   begin
      TabGrupo.Locate('IDGrupo',edNomgru.Tag, []);
      TabGrupo.Edit;
      LMDDBLabeledEdit1.SetFocus;
   end;
end;

procedure TFrmGrupos.edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (TabGrupo.State in dsEditModes) and (Trim(TabGrupoDesgru.Value) <> '') and TabGrupo.Modified then
   begin
      MostraMsg('Acão', 'É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   TabGrupo.Cancel;
   btBuscas('arqgrupo',TLMDEdit(edNomgru),'IDGrupo','Desgru','',Key);
   if edNomgru.Tag > 0 then
   begin
      TabGrupo.Locate('IDGrupo',edNomgru.Tag, []);
      TabGrupo.Edit;
      LMDDBLabeledEdit1.SetFocus;
   end;
end;

procedure TFrmGrupos.edTipproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmTipProSer, TFrmTipProSer, Self);
end;

procedure TFrmGrupos.edTipproCustomButtons1Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabGrupo,'arqprodutotip', TDBEdit(edTippro),'IDTippro','IDTippro','DesTippro','DesTippro','',0);
end;

procedure TFrmGrupos.edTipproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabGrupo,'arqprodutotip', TDBEdit(edTippro),'IDTippro','IDTippro','DesTippro','DesTippro','',Key);
end;

procedure TFrmGrupos.btNovoClick(Sender: TObject);
begin
   if not (TabGrupo.State in dsEditModes) then
   begin
      edNomgru.Clear;
      edNomgru.Tag := 0;
      TabGrupo.Append;
      LMDDBLabeledEdit1.SetFocus;
   end
   else MostraMsg('Aviso','Favor salvar primeiro.', mtWarning, [mbOk]);
end;

procedure TFrmGrupos.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabGrupo.State <> dsInsert) and (TabGrupoIDGrupo.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT IDProd FROM arqproduto WHERE IDGrupo = '+TabGrupoIDGrupo.AsString+' LIMIT 1';
            Open;
            if not IsEmpty then
            begin
               MostraMsg('Não pode ser excluído','Já existem produtos associados à este Grupo!', mtInformation, [mbOk]);
               Exit;
            end;
            if MostraMsg('Confirmação','Confirma exclusão deste Grupo?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqgrupo WHERE IDGrupo = '+TabGrupoIDGrupo.AsString+';');
                  ExecSQL;
                  TabGrupo.Refresh;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqgrupo, IDGrupo = '+TabGrupoIDGrupo.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!', mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog,'EXCLUSAO ARQGRUPO IDGrupo = '+TabGrupoIDGrupo.AsString+' - '+TabGrupoDesgru.AsString);
            end; // if
         end; // with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end
   else TabGrupo.Cancel;
   btNovo.Click;
end;

procedure TFrmGrupos.btFecharClick(Sender: TObject);
begin
   PanelTop.SetFocus;
   if (TabGrupo.State in dsEditModes) and (Trim(TabGrupoDesgru.Value) <> '') then
   begin
      MostraMsg('Acão', 'É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   Close;
end;

procedure TFrmGrupos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabGrupo.Cancel;
   TabGrupo.Close;
   Action := caFree;
end;

end.
