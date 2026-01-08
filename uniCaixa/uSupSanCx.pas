unit uSupSanCx;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.StdCtrls,
   MarcLib, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   uRESTDWBasicTypes, uRESTDWBasicDB, Data.DB, LMDEdit, Vcl.ExtCtrls, LMDBaseEdit,
   LMDCustomEdit, LMDDBEdit, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
   LMDCustomLabel, AdvGlowButton, LMDControl, LMDCustomControl, Vcl.DBCtrls,
   LMDLabel,LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDButtonControl,
   LMDDBSpinEdit, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client;

type
   TFrmSupSanCx = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelButtons: TLMDSimplePanel;
    btNovo: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    TabSupSan: TRESTDWClientSQL;
    SouSupSan: TDataSource;
    edContaDeb: TLMDDBLabeledEdit;
    edContaCre: TLMDDBLabeledEdit;
    edValor: TLMDDBLabeledEdit;
    TabSupSanIDFilial: TIntegerField;
    TabSupSanIDCaixa: TIntegerField;
    TabSupSanDataMov: TDateTimeField;
    TabSupSanValorMov: TFloatField;
    TabSupSanIDConDeb: TIntegerField;
    TabSupSanIDConCre: TIntegerField;
    TabSupSanSupSan: TWideStringField;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    btBusca: TAdvGlowButton;
    TabSupSanNomconCre: TWideStringField;
    TabSupSanNomconDeb: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabSupSanAfterInsert(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure edContaDebKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edContaDebCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edContaCreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edContaCreCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btBuscaClick(Sender: TObject);
  private
    auxIDCaixa:Integer;  
    function Salvar: Boolean;
    { Private declarations }
  public
    { Public declarations }
    auxSupSan:String;
    recSaldo:Double;
  end;

var
   FrmSupSanCx: TFrmSupSanCx;

implementation

{$R *.dfm}

uses uDM, uConst, uCaixa, uSupSanBus, uLibFarm;

procedure TFrmSupSanCx.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmSupSanCx.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if auxSupSan = 'A' then
   begin
      lbTitulo.Caption := 'Sangria de Caixa';
      edContaDeb.EditLabel.Caption := 'CONTA DÉBITO CAIXA';
      edContaCre.EditLabel.Caption := 'CONTA CRÉDITO';
   end else
   begin
      lbTitulo.Caption := 'Suprimento de Caixa';
      edContaDeb.EditLabel.Caption := 'CONTA DÉBITO';
      edContaCre.EditLabel.Caption := 'CONTA CRÉDITO CAIXA';
   end;
   Application.ProcessMessages;
   
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT IDCaixa FROM arqcaixa WHERE IDFilial = '+FILIAL.ToString+' AND '+
      'IDUsu = '+IDUSU.ToString+' AND VlrFecha <= 0.00 ORDER BY DatHorAbre DESC LIMIT 1';
      QueAuxi.Open;
      if QueAuxi.IsEmpty then
           auxIDCaixa := 0
      else auxIDCaixa := QueAuxi.FieldByName('IDCaixa').AsInteger; 
      QueAuxi.Close;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   TabSupSan.DisableControls;
   TabSupSan.ParamByName('IDFilial').AsInteger := FILIAL;
   TabSupSan.ParamByName('IDCaixa').AsInteger  := auxIDCaixa;
   TabSupSan.ParamByName('DataMov').AsInteger  := 0;
   TabSupSan.Open;
   SouSupSan.AutoEdit := auxIDCaixa > 0;
   edContaDeb.Enabled := auxIDCaixa > 0;
   edContaCre.Enabled := auxIDCaixa > 0;
   edValor.Enabled    := auxIDCaixa > 0;
   TabSupSan.Append;
   TabSupSan.EnableControls;
   edContaDeb.SetFocus;
end;

procedure TFrmSupSanCx.TabSupSanAfterInsert(DataSet: TDataSet);
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT '+iif(auxSupSan = 'A',
      'PAR.ConDebSan AS IDConDeb, PAR.ConCreSan AS IDConCre',
      'PAR.ConDebSup AS IDConDeb, PAR.ConCreSup AS IDConCre')+','+
      'PLCD.Nomcon AS NomConDeb, PLCC.Nomcon AS NomConCre FROM arqparametros PAR ' +
      'LEFT JOIN arqplacon PLCD ON '+iif(auxSupSan = 'A','PAR.ConDebSan','PAR.ConDebSup')+' = PLCD.IDCon '+
      'LEFT JOIN arqplacon PLCC ON '+iif(auxSupSan = 'A','PAR.ConCreSan','PAR.ConCreSup')+' = PLCC.IDCon';
      QueAuxi.Open;
      TabSupSanIDConDeb.Value  := QueAuxi.FieldByName('IDConDeb').AsInteger;
      TabSupSanIDConCre.Value  := QueAuxi.FieldByName('IDConCre').AsInteger;
      TabSupSanNomconDeb.Value := QueAuxi.FieldByName('NomConDeb').AsString;
      TabSupSanNomconCre.Value := QueAuxi.FieldByName('NomConCre').AsString;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   SouSupSan.AutoEdit := True;
   edContaDeb.Enabled := True;
   edContaCre.Enabled := True;
   edValor.Enabled    := True;
   TabSupSanIDFilial.Value := FILIAL;
   TabSupSanSupSan.Value   := auxSupSan;
   TabSupSanIDCaixa.Value  := auxIDCaixa;
   TabSupSanDataMov.Value  := VeDataServer;
   TabSupSanValorMov.Value := 0.00;
end;

procedure TFrmSupSanCx.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

procedure TFrmSupSanCx.edContaCreCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabSupSan,'arqplacon',TDBEdit(edContaDeb),'IDConCre','IDCon','Nomcon','NomconCre','Nivcon = 5',0);
end;

procedure TFrmSupSanCx.edContaCreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabSupSan,'arqplacon',TDBEdit(edContaDeb),'IDConCre','IDCon','Nomcon','NomconCre','Nivcon = 5',Key);
end;

procedure TFrmSupSanCx.edContaDebCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabSupSan,'arqplacon',TDBEdit(edContaDeb),'IDConDeb','IDCon','Nomcon','NomconDeb','Nivcon = 5',0);
end;

procedure TFrmSupSanCx.edContaDebKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabSupSan,'arqplacon',TDBEdit(edContaDeb),'IDConDeb','IDCon','Nomcon','NomconDeb','Nivcon = 5',Key);
end;

function TFrmSupSanCx.Salvar:Boolean;
var
   ErroMsg:String;
   antSaldo:Double;
begin
   ErroMsg := '';
   PanelTop.SetFocus;
   if TabSupSan.State in dsEditModes then
   begin
      if TabSupSanIDConDeb.Value <= 0 then 
      begin
         ErroMsg := 'Favor escolher a conta Débito.';
         edContaDeb.SetFocus;
      end else 
      if TabSupSanIDConCre.Value <= 0 then 
      begin
         ErroMsg := 'Favor escolher a conta Crébito.';
         edContaCre.SetFocus;
      end else
      if TabSupSanValorMov.Value <= 0.00 then 
      begin
         ErroMsg := 'Favor entrar com o valor.';
         edValor.SetFocus;
      end;
      if auxSupSan = 'S' then
           antSaldo := recSaldo - TabSupSanValorMov.OldValue + TabSupSanValorMov.Value
      else antSaldo := recSaldo + TabSupSanValorMov.OldValue - TabSupSanValorMov.Value;
      if antSaldo < 0.00 then
      begin
         ErroMsg := 'Com esse movimento o saldo do caixa ficará NEGATIVO.';
         edValor.SetFocus;
      end;

      if ErroMsg <> '' then
      begin
         MostraMsg('Aviso', ErroMsg, mtWarning, [mbOk]);
         Exit;
      end;

      try
         TabSupSan.Post;   
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO,PastaLog,'ERRO ao tentar salvar Sangria/Suprimento de Caixa -> '+E.Message);
            MostraMsg('Erro','Não foi possível salvar!',mtError, [mbOk]);
            Exit;
         end;
      end;
      Self.Close;
   end; //if
end;

procedure TFrmSupSanCx.btNovoClick(Sender: TObject);
begin
   TabSupSan.Append;
   edContaDeb.SetFocus;   
end;

procedure TFrmSupSanCx.btBuscaClick(Sender: TObject);
var
   I:Integer;
   PanelPos:TPoint;
begin
   if FrmSupSanBus = nil then FrmSupSanBus := TFrmSupSanBus.Create(Self);
   try
      Self.AlphaBlendValue := 130;
      PanelPos := PanelCadastro.ClientToScreen(Point(0, 0));
      FrmSupSanBus.Top  := PanelPos.Y + 25;
      FrmSupSanBus.Left := PanelPos.X + 35;
      FrmSupSanBus.recIDCaixa := auxIDCaixa;
      FrmSupSanBus.recSupSan  := auxSupSan;
      FrmSupSanBus.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      if FrmSupSanBus.retDataMov > 0 then
      begin
         try
            TabSupSan.Close;
            TabSupSan.ParamByName('IDFilial').AsInteger := FILIAL;
            TabSupSan.ParamByName('IDCaixa').AsInteger  := auxIDCaixa;
            TabSupSan.ParamByName('DataMov').AsDateTime := FrmSupSanBus.retDataMov;
            TabSupSan.Open;
            TabSupSan.EnableControls;
            TabSupSan.Edit;
            edContaDeb.SetFocus;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar encontrar KIT -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível encontrar Kit!', mtError, [mbOk]);
            end;
         end;
      end; //if
      FreeAndNil(FrmSupSanBus);
   end;
end;

procedure TFrmSupSanCx.btExcluirClick(Sender: TObject);
var
   antSaldo:Double;
begin
   if MostraMsg('Confirmação','Confirma exclusão?',mtConfirmation, [mbYes, mbNo]) = mrYes then
   begin
      if TabSupSan.State <> dsInsert then
      begin      
         if auxSupSan = 'S' then
         begin
            if (recSaldo - TabSupSanValorMov.Value) < 0.00 then
            begin
               MostraMsg('Erro','Com essa exclusão o saldo do caixa ficará NEGATIVO.', mtError, [mbOK]);
               Exit;
            end;
         end; //if
         try
            TabSupSan.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO,PastaLog,'ERRO: Não foi possível excluir arqcaixasupsan -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir!', mtError, [mbOK]);
               Exit;
            end;
         end; // try
      end
      else TabSupSan.Cancel;
      btNovo.Click;
   end; // if
end;

procedure TFrmSupSanCx.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmSupSanCx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabSupSan.State in dsEditModes then
   begin 
      if (TabSupSanIDConDeb.Value > 0) or (TabSupSanIDConCre.Value > 0) or (TabSupSanValorMov.Value > 0.00) then
         MostraMsg('Aviso', 'Movimento não foi salvo!', mtWarning, [mbOk]);
   end; //if
   TabSupSan.Close;
   FrmCaixa.AtuSaldo;
end;

end.

