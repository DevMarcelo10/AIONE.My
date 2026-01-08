unit uConvFil;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, MarcLib, LMDBaseControl,LMDEdit,
   LMDBaseGraphicControl, LMDBaseLabel, Vcl.DBGrids, LMDLabel, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomLabel, VirtualTable, System.Types, System.StrUtils,
   LMDBaseEdit, LMDCustomEdit, Vcl.StdCtrls, FireDAC.Stan.Intf, uRESTDWBasicDB,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes,
   FireDAC.Comp.Client, Vcl.ExtCtrls, LMDDBEdit, ACBrBase, ACBrSocket, ACBrCEP;

type
  TFrmConFilial = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCadastro: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    SouConvCli: TDataSource;
    TabConvCli: TRESTDWClientSQL;
    TabConvCliIDConv: TIntegerField;
    TabConvCliCodmun: TIntegerField;
    LMDSimplePanel1: TLMDSimplePanel;
    edDBNomfil: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    edDBCep: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    edDBEndpes: TLMDDBLabeledEdit;
    edDBFone: TLMDDBLabeledEdit;
    edDBCidpes: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    btExcluir: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    ACBrCEP: TACBrCEP;
    btNovo: TAdvGlowButton;
    TabConvCliCNPJFil: TWideStringField;
    TabConvCliNomRed: TWideStringField;
    TabConvCliEndfil: TWideStringField;
    TabConvCliNroEnd: TWideStringField;
    TabConvCliCompEnd: TWideStringField;
    TabConvCliBaifil: TWideStringField;
    TabConvCliCEPFil: TWideStringField;
    TabConvCliNomfil: TWideStringField;
    TabConvCliInsEstFil: TWideStringField;
    TabConvCliFoneFil: TWideStringField;
    TabConvCliNomcon: TWideStringField;
    TabConvCliIndAtivo: TBooleanField;
    TabConvCliNommun: TWideStringField;
    TabConvCliEstmun: TWideStringField;
    TabConvCliIndDelete: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure TabConvCliAfterPost(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure edDBCepExit(Sender: TObject);
    procedure ACBrCEPBuscaEfetuada(Sender: TObject);
    procedure LMDDBLabeledEdit1Enter(Sender: TObject);
    procedure TabConvCliAfterInsert(DataSet: TDataSet);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    function Salvar:Boolean;
    function VerificaCEP:Boolean;
    { Private declarations }
  public
    { Public declarations }
    recIDConv:Integer;
  end;

var
   FrmConFilial: TFrmConFilial;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaPes;

procedure TFrmConFilial.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmConFilial.FormShow(Sender: TObject);
begin
   try
      TabConvCli.SQL.Text := 'SELECT CLI.*,MUN.Nommun,MUN.Estmun FROM arqconvfilcli CLI LEFT JOIN arqmuni MUN '+
      'ON CLI.Codmun = MUN.Codmun WHERE IDConv = '+recIDConv.ToString+' AND IndDelete != "1" ORDER BY Nomfil';
      TabConvCli.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
   DBGrid1.SetFocus;
end;

procedure TFrmConFilial.LMDDBLabeledEdit1Enter(Sender: TObject);
begin
   if TabConvCli.State <> dsInsert then edDBNomfil.SetFocus;
end;

procedure TFrmConFilial.btNovoClick(Sender: TObject);
begin
   if (TabConvCli.State in dsEditModes) and (TabConvCliCNPJFil.AsString.Trim <> '') then
      if not Salvar then Exit;
   if TabConvCli.State in dsEditModes then TabConvCli.Cancel;
   TabConvCli.Append;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmConFilial.TabConvCliAfterInsert(DataSet: TDataSet);
begin
   TabConvCliIndDelete.Value := 'N';
   TabConvCliIDConv.Value := recIDConv;
end;

procedure TFrmConFilial.TabConvCliAfterPost(DataSet: TDataSet);
begin
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmConFilial.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

procedure TFrmConFilial.DBGrid1CellClick(Column: TColumn);
begin
   if not Salvar then Exit;
   if Column.ID = 11 then
   begin
      if TabConvcLI.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação desta empresa?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            if not (TabConvCli.State in dsEditModes) then TabConvCli.Edit;
            TabConvCliIndDelete.Value := '1';
            TabConvCli.Post;
            TabConvCli.Refresh;
         end;
      end;
      DBGrid1.SelectedField := TabConvCliFoneFil;
   end;
end;

procedure TFrmConFilial.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 11 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+2, 3);
end;

procedure TFrmConFilial.edDBCepExit(Sender: TObject);
begin
   if not VerificaCEP then Exit;
   try
      if (TabConvCliCEPFil.AsString <> TabConvCliCEPFil.OldValue) and (TabConvCliCEPFil.AsString.Trim <> '') then
         ACBrCEP.BuscarPorCEP(TabConvCliCEPFil.AsString);
   except
      MostraMsg('CEP inválido', 'Confirme o número do CEP!', mtError, [mbOk]);
      edDBCep.SetFocus;
      Exit;
   end;
end;

function TFrmConFilial.Salvar:Boolean;
var
   FocusObject:TWinControl;
   DBEditErro:TLMDDBLabeledEdit;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := True;
   if TabConvCli.State in dsEditModes then
   begin
      PanelTop.SetFocus;
      FocusObject := Screen.ActiveControl;
      if TabConvCliCNPJFil.AsString.Trim.Length <> 14 then DBEditErro := LMDDBLabeledEdit1 else
      if TabConvCliNomfil.AsString.Trim.Length    < 3 then DBEditErro := edDBNomfil;
      if DBEditErro <> nil then
      begin
         Result := False;
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if

      if TabConvCli.State = dsInsert then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            try
               QueAuxi.DataBase := DM.DWDataBase;
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqconvfilcli WHERE CNPJFil = '+Aspas(TabConvCliCNPJFil.AsString.Trim)+' AND IDConv = '+recIDConv.ToString+' LIMIT 1';
               QueAuxi.Open;
               if not QueAuxi.IsEmpty then
               begin
                  Result := False;
                  MostraMsg('Aviso','Esta empresa já está associada à um outro convênio.', mtInformation, [mbOk]);
                  Exit;
               end;
            except
               Result := False;
               MostraMsg('Erro', 'Não foi possível salvar!',mtError, [mbOk]);
               Exit;
            end;
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
      TabConvCli.Post;
      DBGrid1.SetFocus;
   end; //if
end;

procedure TFrmConFilial.ACBrCEPBuscaEfetuada(Sender: TObject);
begin
   with ACBrCEP do
   begin
      if Enderecos.Count > 0 then
      begin
         if not(TabConvCli.State in dsEditModes) then TabConvCli.Edit;
         TabConvCliEndfil.Value := AnsiUpperCase(iif(Enderecos[0].Logradouro.Trim <> '',Enderecos[0].Logradouro, TabConvCliEndfil.Value));
         TabConvCliBaifil.Value := AnsiUpperCase(iif(Enderecos[0].Bairro.Trim     <> '',Enderecos[0].Bairro, TabConvCliBaifil.Value));
         TabConvCliCodmun.Value := StrToInt(Enderecos[0].IBGE_Municipio);
         TabConvCliNommun.Value := UpperCase(Enderecos[0].Municipio);
         TabConvCliEstmun.Value := Enderecos[0].UF;
      end
      else MostraMsg('CEP inválido', 'Número de CEP não foi encontrado',mtError, [mbOk]);
   end; // with
end;

procedure TFrmConFilial.btExcluirClick(Sender: TObject);
begin
   TabConvCli.Cancel;
end;

// ---------------- Valida CEP ---------------- //
function TFrmConFilial.VerificaCEP:Boolean;
begin
   Result := False;
   if (TabConvCliCEPFil.AsString.Trim.Length < 8) and (TabConvCliCEPFil.AsString.Trim <> '') then
   begin
      MostraMsg('CEP inválido', 'Confirme o número do CEP!', mtError, [mbOk]);
      edDBCep.SetFocus;
      Exit;
   end;
   Result := True;
end;

procedure TFrmConFilial.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmConFilial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabConvCli.Cancel;
   TabConvCli.Close;
   Action := caFree;
end;

end.
