unit uGruposSub;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls;

type
  TFrmGruposSub = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomgru: TLMDLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    Shape1: TShape;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBCheckBox1: TLMDDBCheckBox;
    LMDSimplePanel4: TLMDSimplePanel;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    edIDGrupo: TLMDDBLabeledEdit;
    TabGrupoSub: TRESTDWClientSQL;
    SouGrupoSub: TDataSource;
    TabGrupoSubIDGruSub: TFDAutoIncField;
    TabGrupoSubIDGrupo: TIntegerField;
    TabGrupoSubDesgruSub: TWideStringField;
    TabGrupoSubMarkup: TFloatField;
    TabGrupoSubDescMax: TFloatField;
    TabGrupoSubPercom: TFloatField;
    TabGrupoSubDescPra: TBooleanField;
    TabGrupoSubSolPerf: TBooleanField;
    TabGrupoSubDesgru: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure TabGrupoSubAfterInsert(DataSet: TDataSet);
    procedure edIDGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edIDGrupoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit2Change(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmGruposSub: TFrmGruposSub;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmGruposSub.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmGruposSub.FormShow(Sender: TObject);
begin
   TabGrupoSub.SQL.Text := 'SELECT SUB.*,GRU.Desgru FROM arqgruposub SUB LEFT JOIN arqgrupo GRU ON SUB.IDGrupo = GRU.IDGrupo';
   TabGrupoSub.Open;
   TabGrupoSub.Append;
   edNomgru.SetFocus;
end;

procedure TFrmGruposSub.LMDDBLabeledEdit2Change(Sender: TObject);
begin
   if LMDDBLabeledEdit2.Field <> nil then
   begin
      if LMDDBLabeledEdit2.Field.FieldName = 'IDGruSub' then
      begin
         if TabGrupoSubIDGruSub.AsInteger > 0 then
              LMDDBLabeledEdit2.DataField := 'IDGruSub'
         else LMDDBLabeledEdit2.DataField := '';
      end;
   end; //if

end;

procedure TFrmGruposSub.TabGrupoSubAfterInsert(DataSet: TDataSet);
begin
   TabGrupoSubMarkup.Value  := 0.00;
   TabGrupoSubPercom.Value  := 0.00;
   TabGrupoSubDescMax.Value := 0.00;
   TabGrupoSubDescPra.Value := False;
   TabGrupoSubSolPerf.Value := False;
end;

procedure TFrmGruposSub.btSalvarClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelTop.SetFocus;
   if TabGrupoSub.State in dsEditModes then
   begin
      if Length(TabGrupoSubDesgruSub.Value) <= 2 then Erro := 1 else
      if TabGrupoSubIDGrupo.Value <= 0 then Erro := 2;
      if Erro > 0 then
      begin
         if Erro = 1 then
         begin
            MostraMsg('Aviso', 'Entrar com a descrição do sub grupo!', mtWarning, [mbOk]);
            LMDDBLabeledEdit1.SetFocus;
         end else
         if Erro = 2 then
         begin
            MostraMsg('Aviso', 'Entrar o Grupo associado!', mtWarning, [mbOk]);
            edIDGrupo.SetFocus;
         end;
         Exit;
      end; //if
      try
         try
            TabGrupoSub.Post;
         except
            on E: Exception do
            begin
               SalvaLog(USUARIO,PastaLog, 'ERRO ao tentar salvar Sub Grupo de Produtos -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar.',mtError,[mbOk]);
               Exit;
            end; //on
         end;
      finally
         LMDSimplePanel2.Visible := False;
         Sleep(10);
         LMDSimplePanel2.Visible := True;
         //btNovo.Click;
      end;
   end; //if
end;

procedure TFrmGruposSub.edIDGrupoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabGrupoSub,'arqgrupo', TDBEdit(edIDGrupo), 'IDGrupo','IDGrupo','Desgru','Desgru','', 0);
end;

procedure TFrmGruposSub.edIDGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabGrupoSub,'arqgrupo', TDBEdit(edIDGrupo), 'IDGrupo','IDGrupo','Desgru','Desgru','', Key);
end;

procedure TFrmGruposSub.edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if (TabGrupoSub.State in dsEditModes) and (Trim(TabGrupoSubDesgruSub.Value) <> '') and TabGrupoSub.Modified then
   begin
      MostraMsg('Acão','É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   TabGrupoSub.Cancel;
   btBuscas('arqgruposub', TLMDEdit(edNomgru), 'IDGruSub', 'DesgruSub', '', 0);
   if edNomgru.Tag > 0 then
   begin
      TabGrupoSub.Locate('IDGruSub',edNomgru.Tag, []);
      TabGrupoSub.Edit;
      LMDDBLabeledEdit1.SetFocus;
   end;
end;

procedure TFrmGruposSub.edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (TabGrupoSub.State in dsEditModes) and (Trim(TabGrupoSubDesgruSub.Value) <> '') and TabGrupoSub.Modified then
   begin
      MostraMsg('Acão','É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   TabGrupoSub.Cancel;
   btBuscas('arqgruposub',TLMDEdit(edNomgru),'IDGruSub','DesgruSub','',Key);
   if edNomgru.Tag > 0 then
   begin
      TabGrupoSub.Locate('IDGruSub',edNomgru.Tag, []);
      TabGrupoSub.Edit;
      LMDDBLabeledEdit1.SetFocus;
   end;
end;

procedure TFrmGruposSub.btNovoClick(Sender: TObject);
begin
   if not (TabGrupoSub.State in dsEditModes) then
   begin
      edNomgru.Clear;
      edNomgru.Tag := 0;
      TabGrupoSub.Append;
      LMDDBLabeledEdit1.SetFocus;
   end
   else MostraMsg('Aviso','Favor salvar primeiro.', mtWarning, [mbOk]);
end;

procedure TFrmGruposSub.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabGrupoSub.State <> dsInsert) and (TabGrupoSubIDGruSub.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT IDProd FROM arqproduto WHERE IDGruSub = '+TabGrupoSubIDGruSub.AsString+' LIMIT 1';
            Open;
            if not IsEmpty then
            begin
              MostraMsg('Não pode ser excluído','Já existem produtos associados à este Sub Grupo!', mtInformation, [mbOk]);
               Exit;
            end;
            if MostraMsg('Confirmação','Confirma exclusão desta Sub Grupo?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqgruposub WHERE IDGruSub = '+TabGrupoSubIDGruSub.AsString+';');
                  ExecSQL;
                  TabGrupoSub.Refresh;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqgruposub, IDGrupoSub = '+TabGrupoSubIDGruSub.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQGRUPOSUB, IDGrupoSub = '+TabGrupoSubIDGruSub.AsString+' - '+TabGrupoSubDesgruSub.AsString);
            end; // if
         end; // with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
   TabGrupoSub.Cancel;
   btNovo.Click;
end;

procedure TFrmGruposSub.btFecharClick(Sender: TObject);
begin
   PanelTop.SetFocus;
   if (TabGrupoSub.State in dsEditModes) and (Trim(TabGrupoSubDesgruSub.Value) <> '') then
   begin
      MostraMsg('Acão', 'É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   Close;
end;

procedure TFrmGruposSub.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabGrupoSub.Cancel;
   TabGrupoSub.Close;
   Action := caFree;
end;

end.
