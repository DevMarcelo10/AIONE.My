unit uCidBairro;

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
  TFrmCidBairro = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edBusca: TLMDLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDSimplePanel4: TLMDSimplePanel;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    TabBairro: TRESTDWClientSQL;
    SouBairro: TDataSource;
    TabBairroCodmun: TIntegerField;
    TabBairroCodbai: TIntegerField;
    TabBairroNombai: TWideStringField;
    edNommun: TLMDLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure TabBairroAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
    recCodmun:Integer;
    recNommun:String;
 end;

var
   FrmCidBairro: TFrmCidBairro;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmCidBairro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCidBairro.FormShow(Sender: TObject);
begin
   edNommun.Text := recNommun;
   TabBairro.SQL.Text := 'SELECT * FROM arqbairro WHERE Codmun = '+recCodmun.ToString+' LIMIT 1';
   TabBairro.Open;
   btNovo.Click;
end;

procedure TFrmCidBairro.TabBairroAfterInsert(DataSet: TDataSet);
begin
   TabBairroCodmun.Value := recCodmun;
end;

procedure TFrmCidBairro.btSalvarClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelTop.SetFocus;
   if TabBairro.State in dsEditModes then
   begin
      if TabBairroNombai.AsString.Trim.Length <= 1 then
      begin
         MostraMsg('Aviso', 'Entrar com a descrição correta do Bairro!', mtWarning, [mbOk]);
         LMDDBLabeledEdit1.SetFocus;
         Exit;
      end; //if
      try
         try
            if TabBairro.State = dsInsert then TabBairroCodbai.Value := -100;
            TabBairro.Post;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Bairro -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível salvar.', mtError, [mbOk]);
               Exit;
            end; //on
         end;
      finally
         LMDSimplePanel2.Visible := False;
         Sleep(10);
         LMDSimplePanel2.Visible := True;
         btNovo.Click;
      end;
   end; //if
end;

procedure TFrmCidBairro.edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if (TabBairro.State in dsEditModes) and (TabBairroNombai.AsString.Trim <> '') and TabBairro.Modified then
   begin
      MostraMsg('Acão','É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   TabBairro.Cancel;
   TabBairro.Close;
   btBuscas('arqbairro',TLMDEdit(edBusca),'Codbai','Nombai','Codmun = '+recCodmun.ToString,0,True);
   if edBusca.Tag > 0 then
   begin
      TabBairro.SQL.Text := 'SELECT * FROM arqbairro WHERE Codmun = '+recCodmun.ToString+' AND Codbai = '+edBusca.Tag.ToString;
      TabBairro.Open;
      TabBairro.Edit;
      LMDDBLabeledEdit1.SetFocus;
   end else
   begin
      TabBairro.SQL.Text := 'SELECT * FROM arqbairro WHERE Codmun = '+recCodmun.ToString+' LIMIT 1';
      TabBairro.Open;
      TabBairro.Append;
   end;
end;

procedure TFrmCidBairro.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (TabBairro.State in dsEditModes) and (TabBairroNombai.AsString.Trim <> '') and TabBairro.Modified then
   begin
      MostraMsg('Ação','É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   TabBairro.Cancel;
   TabBairro.Close;
   btBuscas('arqbairro',TLMDEdit(edBusca),'Codbai','Nombai','Codmun = '+recCodmun.ToString,Key,True);
   if edBusca.Tag > 0 then
   begin
      TabBairro.SQL.Text := 'SELECT * FROM arqbairro WHERE Codmun = '+recCodmun.ToString+' AND Codbai = '+edBusca.Tag.ToString;
      TabBairro.Open;
      TabBairro.Edit;
      LMDDBLabeledEdit1.SetFocus;
   end else
   begin
      TabBairro.SQL.Text := 'SELECT * FROM arqbairro WHERE Codmun = '+recCodmun.ToString+' LIMIT 1';
      TabBairro.Open;
      TabBairro.Append;
   end;
end;

procedure TFrmCidBairro.btNovoClick(Sender: TObject);
begin
   if not (TabBairro.State in dsEditModes) then
   begin
      edBusca.Clear;
      edBusca.Tag := 0;
      TabBairro.Close;
      TabBairro.SQL.Text := 'SELECT * FROM arqbairro WHERE Codmun = '+recCodmun.ToString+' LIMIT 1';
      TabBairro.Open;
      TabBairro.Append;
      LMDDBLabeledEdit1.SetFocus;
   end
   else MostraMsg('Aviso','Favor salvar primeiro.', mtWarning, [mbOk]);
end;

procedure TFrmCidBairro.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabBairro.State <> dsInsert then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT 1 FROM arqtaxaentmun WHERE Codmun = '+recCodmun.ToString+' AND Codbai = '+TabBairroCodbai.AsString+' LIMIT 1';
            Open;
            if not IsEmpty then
            begin
              MostraMsg('Não pode ser excluído','Existem taxas associadass à este Bairro!', mtInformation, [mbOk]);
               Exit;
            end;
            if MostraMsg('Confirmação','Confirma exclusão deste Bairro?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.Close;
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqbairro WHERE Codmun = '+recCodmun.ToString+' AND Codbai = '+TabBairroCodbai.AsString+';');
                  ExecSQL;
                  btNovo.Click;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqbairro, Codbai = '+TabBairroCodbai.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQBAIRRO, Codbai = '+TabBairroCodbai.AsString+' - '+TabBairroNombai.AsString);
            end; // if
         end; // with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
   TabBairro.Cancel;
   btNovo.Click;
end;

procedure TFrmCidBairro.btFecharClick(Sender: TObject);
begin
   PanelTop.SetFocus;
   if (TabBairro.State in dsEditModes) and (TabBairroNombai.AsString.Trim <> '') then
   begin
      MostraMsg('Acão', 'É necessário salvar antes!',mtWarning, [mbOk]);
      Exit;
   end;
   Close;
end;

procedure TFrmCidBairro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabBairro.Cancel;
   TabBairro.Close;
   Action := caFree;
end;

end.
