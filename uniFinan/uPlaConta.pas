unit uPlaConta;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, Vcl.StdCtrls, RxToolEdit, Data.DB,
   LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel, LMDCustomLabel,
   Vcl.ExtCtrls, AdvGlowButton, MarcLib, AdvEdit, LMDEdit,LMDCustomBevelPanel,
   Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB,
   LMDCustomParentPanel, LMDCustomGroupBox, LMDCustomButtonGroup, LMDDBRadioGroup,
   Vcl.Grids, Vcl.DBGrids, LMDCustomRadioGroup;

type
   TFrmPlaCon = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    SouPlco: TDataSource;
    TabPlco: TRESTDWClientSQL;
    PanelButtons: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit0: TLMDDBLabeledEdit;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    TabPlcoIDCon: TFDAutoIncField;
    TabPlcoCodcon: TWideStringField;
    TabPlcoNomcon: TWideStringField;
    TabPlcoNivcon: TWideStringField;
    TabAuxPlco: TRESTDWClientSQL;
    TabAuxPlcoIDCon: TFDAutoIncField;
    TabAuxPlcoCodcon: TWideStringField;
    TabAuxPlcoNomcon: TWideStringField;
    TabAuxPlcoNivcon: TWideStringField;
    SouAuxPlc: TDataSource;
    PanelBckBut: TLMDSimplePanel;
    edBusPlc: TLMDLabeledEdit;
    TabPlcoIndFixa: TWideStringField;
    TabAuxPlcoIndFixa: TWideStringField;
    TabPlcoDevCre: TWideStringField;
    LMDDBRadioGroup1: TLMDDBRadioGroup;
    TabAuxPlcoDevCre: TWideStringField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit0DataChange(Sender: TObject);
    procedure LMDDBLabeledEdit1Enter(Sender: TObject);
    procedure LMDDBLabeledEdit1Exit(Sender: TObject);
    procedure LMDDBLabeledEdit2Exit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure TabAuxPlcoAfterOpen(DataSet: TDataSet);
    procedure edBusPlcKeyPress(Sender: TObject; var Key: Char);
    procedure edBusPlcCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure TabPlcoAfterInsert(DataSet: TDataSet);
    procedure LMDDBRadioGroup1Click(Sender: TObject);
    procedure LMDDBRadioGroup1Enter(Sender: TObject);
  private
    { Private declarations }
    auxDevCre:String;
    function Salvar:Boolean;
    function VeNivelSup(Conta:String):Boolean;
    procedure AjustGrid;
  public
    { Public declarations }
  end;

var
   FrmPlaCon: TFrmPlaCon;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaPlc;

procedure TFrmPlaCon.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPlaCon.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmPlaCon.FormShow(Sender: TObject);
begin
   auxDevCre := '';
   TabAuxPlco.Open;
   AjustGrid;
   SouPlco.DataSet := nil;
   TabPlco.SQL.Text := 'SELECT * FROM arqplacon LIMIT 1';
   TabPlco.Open;
   SouPlco.DataSet := TabPlco;
   TabPlco.Append;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmPlaCon.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmPlaCon.LMDDBLabeledEdit0DataChange(Sender: TObject);
begin
   if TabPlcoIDCon.AsInteger > 0 then
        LMDDBLabeledEdit0.DataField := 'IDCon'
   else LMDDBLabeledEdit0.DataField := '';
end;

procedure TFrmPlaCon.btNovoClick(Sender: TObject);
begin
   if TabPlco.State in dsEditModes then TabPlco.Cancel;
   TabPlco.Append;
   LMDDBLabeledEdit1.Enabled := True;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmPlaCon.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmPlaCon.Salvar:Boolean;
var
   Conta:String;
   retID:Integer;
   tamConta:Boolean;
   FocusObject:TWinControl;
   QueAuxi:TRESTDWClientSQL;
   DBEditErro:TLMDDBLabeledEdit;
begin
   Result := True;
   if (TabPlcoCodcon.AsString.Trim = '') and (TabPlcoNomCon.AsString.Trim = '') then Exit;
   if TabPlco.State in dsEditModes then
   begin
      if TabPlcoIndFixa.AsString = 'S' then
      begin
         MostraMsg('Aviso','Conta FIXA padrão e não pode ser modificada!',mtWarning, [mbOk]);
         TabPlco.Cancel;
         Exit;
      end;

      Result := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;

      tamConta := False;
      Conta := TabPlcoCodcon.AsString.Trim;
      if Conta.Length in [1..3] then tamConta := True else
      if Conta.Length  = 6 then tamConta := True else
      if Conta.Length  = 8 then tamConta := True;

      if not tamConta then DBEditErro := LMDDBLabeledEdit1 else
      if TabPlcoNomcon.AsString.Trim = '' then DBEditErro := LMDDBLabeledEdit2;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if

      if TabPlco.State = dsInsert then
      begin
         if TabPlcoCodcon.AsString.Length = 1 then TabPlcoNivcon.Value := '1' else
         if TabPlcoCodcon.AsString.Length = 2 then TabPlcoNivcon.Value := '2' else
         if TabPlcoCodcon.AsString.Length = 3 then TabPlcoNivcon.Value := '3' else
         if TabPlcoCodcon.AsString.Length = 5 then TabPlcoNivcon.Value := '4' else
         if TabPlcoCodcon.AsString.Length > 5 then TabPlcoNivcon.Value := '5' ;
      end; //if

      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            if TabPlco.State = dsInsert then
            begin
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqplacon WHERE Codcon = '+Aspas(TabPlcoCodcon.AsString.Trim);
               QueAuxi.Open;
               if not QueAuxi.IsEmpty then
               begin
                  MostraMsg('Aviso','Já existe uma Conta com esse número!', mtWarning, [mbOk]);
                  LMDDBLabeledEdit1.SetFocus;
                  Exit;
               end;
            end; //if
            retID := MyApplayUpdates(TabPlco, 'IDCon', 'IDCon = '+TabPlcoIDCon.AsString, TabPlco.State);
            if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');

            if TabPlcoNivcon.Value = '1' then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'UPDATE arqplacon SET DevCre = '+Aspas(auxDevCre)+' WHERE SUBSTRING(Codcon,1,1) = '+Aspas(TabPlcoCodcon.AsString);
               QueAuxi.ExecSQL;
            end;

            TabAuxPlco.Close;
            TabAuxPlco.Open;
            TabAuxPlco.Locate('Codcon',TabPlcoCodcon.AsString,[]);
            TabPlco.Cancel;
            btNovo.Click;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Plano de Contas -> '+E.Message);
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

// -------------- Exclusão da Conta  ------------ //
procedure TFrmPlaCon.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabPlco.State <> dsInsert) and (TabPlcoIDCon.Value > 0) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         if TabPlcoIndFixa.AsString = 'S' then
         begin
            MostraMsg('Aviso','Conta FIXA padrão e não pode ser excluída!',mtWarning, [mbOk]);
            Exit;
         end; //if

         if TabPlcoCodcon.AsString.Trim.Length < 6 then
         begin
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqplacon WHERE Codcon LIKE '+Aspas(TabPlcoCodcon.AsString.Trim+'%');
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
            begin
               MostraMsg('Aviso','Está conta poussui conta(s) inferior(es) e não pode ser excluída!',mtWarning, [mbOk]);
               Exit;
            end; //if
         end; //if
         try
            if MostraMsg('Confirmação','Confirma exclusão da Conta?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'DELETE FROM arqplacon WHERE IDCon = '+TabPlcoIDCon.AsString;
               QueAuxi.ExecSQL;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQPLACON IDCon = '+TabPlcoIDCon.AsString+', Nomcon = '+TabPlcoNomcon.AsString);
               TabPlco.Close;
               TabPlco.Open;
               TabAuxPlco.Close;
               TabAuxPlco.Open;
               AjustGrid;
               btNovo.Click;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir Conta: arqplacon, IDCon = '+TabPlcoIDCon.AsString+' -> '+E.Message);
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
      if TabPlco.State in dsEditModes then TabPlco.Cancel;
      btNovo.Click;
   end;
end;

procedure TFrmPlaCon.LMDDBLabeledEdit1Enter(Sender: TObject);
begin
   if TabPlco.State <> dsInsert then LMDDBLabeledEdit2.SetFocus;
   LMDDBLabeledEdit1.Enabled := TabPlco.State = dsInsert;
end;

procedure TFrmPlaCon.LMDDBLabeledEdit1Exit(Sender: TObject);
begin
   if TabPlco.State in dsEditModes then
   begin
      if not VeNivelSup(LMDDBLabeledEdit1.Text) then
      begin
         MostraMsg('Aviso','Favor cadastrar, antes, conta de nível superior.', mtWarning, [mbOk]);
         LMDDBLabeledEdit1.SetFocus;
         Exit;
      end;
   end; //if
end;

procedure TFrmPlaCon.LMDDBLabeledEdit2Exit(Sender: TObject);
begin
   if (TabPlco.State in dsEditModes) then btSalvar.Click;
end;

procedure TFrmPlaCon.LMDDBRadioGroup1Click(Sender: TObject);
var
   Conta:String;
begin
   Conta := OnlyNumbers(LMDDBLabeledEdit1.Text);
   if Conta.Length > 1 then PanelTop.SetFocus;
end;

procedure TFrmPlaCon.LMDDBRadioGroup1Enter(Sender: TObject);
begin
   LMDDBRadioGroup1Click(Sender);
end;

// 9.9.9.99.999
function TFrmPlaCon.VeNivelSup(Conta:String):Boolean;
var
   ContaSup:String;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   Conta  := OnlyNumbers(Conta);
   if Conta.Length in [4,5] then
   begin
      Conta := Copy(Conta,1,3)+StrZero(Copy(Conta.Trim,4,2),2);
      LMDDBLabeledEdit1.Text := Conta;
   end else
   if Length(Conta) >= 6 then
   begin
      Conta := Copy(Conta,1,5)+StrZero(Copy(Conta.Trim,6,3),3);
      LMDDBLabeledEdit1.Text := Conta;
   end;
   if Conta.Length <= 1 then
   begin
      Result := True;
      Exit;
   end;
   if Length(Conta) <= 2 then ContaSup := Copy(Conta,1,1) else
   if Length(Conta) <= 3 then ContaSup := Copy(Conta,1,2) else
   if Length(Conta) <= 5 then ContaSup := Copy(Conta,1,3) else
   if Length(Conta) >  5 then ContaSup := Copy(Conta,1,5);
   try
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT DevCre FROM arqplacon WHERE Codcon = '+Aspas(ContaSup);
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         auxDevCre := QueAuxi.FieldByName('DevCre').AsString;
         if not (TabPlco.State in dsEditModes) then TabPlco.Edit;
         TabPlcoDevCre.Value := auxDevCre;
      end;
      Result := not QueAuxi.IsEmpty;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmPlaCon.DBGrid1DblClick(Sender: TObject);
begin
   if TabAuxPlco.IsEmpty then Exit;
   if TabPlco.State in dsEditModes then TabPlco.Cancel;
   TabPlco.Close;
   TabPlco.SQL.Text := 'SELECT * FROM arqplacon WHERE IDCon = '+TabAuxPlcoIDCon.AsString;
   TabPlco.Open;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmPlaCon.TabAuxPlcoAfterOpen(DataSet: TDataSet);
begin
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmPlaCon.TabPlcoAfterInsert(DataSet: TDataSet);
begin
   TabPlcoIndFixa.AsString := 'N';
end;

procedure TFrmPlaCon.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmPlaCon.edBusPlcCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      edBusPlc.Tag := 0;
      FrmBuscaPlc := TFrmBuscaPlc.Create(Application);
      with FrmBuscapLC do
      begin
         lPoint := Self.edBusPlc.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edBusPlc.Width;
         edRetorno := TEdit(Self.edBusPlc);
         edBusca.Text := Self.edBusPlc.Text;
         ShowModal;
      end; // with
   finally
      if edBusPlc.Tag > 0 then
      begin
         if TabPlco.State in dsEditModes then TabPlco.Cancel;
         TabPlco.Close;
         TabPlco.SQL.Text := 'SELECT * FROM arqplacon WHERE IDCOn = '+edBusPlc.Tag.ToString;
         TabPlco.Open;
         TabAuxPlco.Locate('IDCon',edBusPlc.Tag,[]);
         FrmBuscaPlc.Free;
      end; //if
   end;
   AjustGrid;
   LMDDBLabeledEdit2.SetFocus;
end;

procedure TFrmPlaCon.edBusPlcKeyPress(Sender: TObject; var Key: Char);
var
   lPoint:TPoint;
begin
   if (not (Key in ['0'..'9', 'A'..'Z', 'a'..'z'])) then Exit;
   try
      edBusPlc.Tag := 0;
      FrmBuscaPlc := TFrmBuscaPlc.Create(Application);
      with FrmBuscapLC do
      begin
         lPoint := Self.edBusPlc.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edBusPlc.Width;
         edRetorno    := TEdit(Self.edBusPlc);
         edBusca.Text := Key;
         ShowModal;
      end; // with
   finally
      if edBusPlc.Tag > 0 then
      begin
         if TabPlco.State in dsEditModes then TabPlco.Cancel;
         TabPlco.Close;
         TabPlco.SQL.Text := 'SELECT * FROM arqplacon WHERE IDCon = '+edBusPlc.Tag.ToString;
         TabPlco.Open;
         TabAuxPlco.Locate('IDCon', edBusPlc.Tag, []);
         FrmBuscaPlc.Free;
      end; //if
      Key := #0;
      LMDDBLabeledEdit2.SetFocus;
   end;
   AjustGrid;
end;

procedure TFrmPlaCon.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmPlaCon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabAuxPlco.Active then TabAuxPlco.Close;
   if TabPlco.Active    then TabPlco.Close;
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;

{procedure ProcessarPlanoDeContasESalvarCSV(const InputFileName, OutputFileName: string);
var
  FileLines: TStringList;
  CSVOutput: TStringList;
  Line, CodigoConta, DescricaoConta: string;
  NivelConta: Integer;
  I, LastSpacePos: Integer;
  CSVLine: string;
begin
  FileLines := TStringList.Create;
  CSVOutput := TStringList.Create;
  try
    // Carregar o arquivo TXT
    FileLines.LoadFromFile(InputFileName);

    // Adicionar cabeçalho no arquivo CSV
    CSVOutput.Add('Código;Descrição;Nível');

    for I := 0 to FileLines.Count - 1 do
    begin
      Line := FileLines[I];

      // Encontrar a última posição de espaço na linha
      LastSpacePos := LastDelimiter(' ', Line);

      // Extrair o nível da conta (último caractere)
      NivelConta := StrToIntDef(Line[Length(Line)], 0);

      // Extrair o código da conta (parte antes do primeiro espaço)
      CodigoConta := OnlyNumbers(Copy(Line, 1, Pos(' ', Line) - 1));

      // Extrair a descrição da conta (parte entre o código e o último espaço)
      DescricaoConta := Copy(Line, Pos(' ', Line) + 1, LastSpacePos - Pos(' ', Line) - 1);

      // Criar a linha do CSV com os dados separados por ';'
      CSVLine := Format('%s;%s;%d', [CodigoConta, DescricaoConta, NivelConta]);

      // Adicionar a linha no CSV
      CSVOutput.Add(CSVLine);
    end;

    // Salvar o resultado em um arquivo CSV
    CSVOutput.SaveToFile(OutputFileName);
  finally
    FileLines.Free;
    CSVOutput.Free;
  end;
end; }

procedure TFrmPlaCon.Button1Click(Sender: TObject);
begin
   //ProcessarPlanoDeContasESalvarCSV('C:\Fontes\AIOne\Documentos\Modelo_PLC.txt', 'C:\Fontes\AI.One\Documentos\Modelo_PLC.csv');
end;

end.

