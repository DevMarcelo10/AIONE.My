unit uAbreCx;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.StdCtrls,
   MarcLib, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDEdit, Vcl.ExtCtrls,Vcl.Mask, LMDBaseEdit, LMDCustomEdit, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, AdvGlowButton, LMDControl,
   LMDCustomControl, Vcl.DBCtrls, LMDLabel,LMDCustomPanel, LMDCustomBevelPanel,
   LMDSimplePanel, LMDCustomMaskEdit, LMDMaskEdit, RxCurrEdit, DateUtils, RxToolEdit,
   uRESTDWBasicDB;

type
   TFrmAbreCx = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    Shape4: TShape;
    edDatAbre: TDateEdit;
    edHorAbre: TLMDMaskEdit;
    LMDLabel1: TLMDLabel;
    PanelButtons: TLMDSimplePanel;
    btNovo: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    edNomusu: TLMDLabeledEdit;
    LMDLabel3: TLMDLabel;
    edVlrAbreCx: TCurrencyEdit;
    LMDLabel4: TLMDLabel;
    edDatHorFecha: TLMDSimplePanel;
    LMDLabel7: TLMDLabel;
    edVlrFecha: TCurrencyEdit;
    lbDatHorFecha: TLMDLabel;
    btReabre: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btReabreClick(Sender: TObject);
  private
    function Salvar: Boolean;
    { Private declarations }
  public
    { Public declarations }
    IDCaixa:Integer;
  end;

var
   FrmAbreCx: TFrmAbreCx;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmAbreCx.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmAbreCx.FormShow(Sender: TObject);
var
   QueCaixa:TRESTDWClientSQL;
begin
   if IDCaixa = 0 then
   begin
      btReabre.Enabled  := False;
      btExcluir.Enabled := False;
   end;
   QueCaixa := TRESTDWClientSQL.Create(nil);
   QueCaixa.DataBase := DM.DWDataBase;
   if IDCaixa > 0 then
   begin
      try
         try
            QueCaixa.SQL.Text := 'SELECT CAI.*,USU.Nomusu FROM arqcaixa CAI LEFT JOIN arqusuario USU ON CAI.IDUsu = USU.IDUsu '+
            'WHERE IDFilial = '+FILIAL.ToString+' AND IDCaixa = '+IDCaixa.ToString;
            QueCaixa.Open;
            if not QueCaixa.IsEmpty then
            begin
               edNomusu.Text     := QueCaixa.FieldByName('Nomusu').AsString;
               edVlrAbreCx.Value := QueCaixa.FieldByName('VlrAbre').AsFloat;
               edDatAbre.Date    := DateOf(QueCaixa.FieldByName('DatHorAbre').AsDateTime);
               edHorAbre.AsTime  := TimeOf(QueCaixa.FieldByName('DatHorAbre').AsDateTime);
               edVlrFecha.Value  := QueCaixa.FieldByName('VlrFecha').AsFloat;
               lbDatHorFecha.Caption := Copy(QueCaixa.FieldByName('DatHorFecha').AsString,1,16);
               edDatAbre.SetFocus;
            end; //if
         except
            MostraMsg('Erro','Não foi possível continuar',mtError, [mbOk]);
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
         end;
      finally
         QueCaixa.Close;
         FreeAndNil(QueCaixa);
      end;
   end
   else btNovo.Click;
end;

procedure TFrmAbreCx.btNovoClick(Sender: TObject);
begin
   edNomusu.Text     := USUARIO;
   edVlrAbreCx.Value := 0.00;
   edDatAbre.Date    := Date;
   edHorAbre.AsTime  := Time;
   edVlrFecha.Value  := 0.00;
   lbDatHorFecha.Caption := '';
   edDatAbre.SetFocus;
end;

procedure TFrmAbreCx.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

function TFrmAbreCx.Salvar:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   if IDCaixa > 0 then
   begin
      Result := True;
      Exit;
   end;

   Result := False;
   if edDatAbre.Date <= StrToDate('01/01/2000') then
   begin
      MostraMsg('Dado não informado','Favor preencher Data/Hora.',mtWarning, [mbOk]);
      edDatAbre.SetFocus;
      Exit;
   end;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'INSERT INTO arqcaixa (IDFilial,IDUsu,VlrAbre,DatHorAbre) VALUES ('+
         FILIAL.ToString+','+IDUSU.ToString+','+
         FormatDouble(edVlrAbreCx.Value,11,2)+','+Aspas(DataMySQL(edDatAbre.Date)+' '+edHorAbre.Text+':00')+');';
         QueAuxi.SQL.Add('SELECT LAST_INSERT_ID() AS NEW_IDCaixa;');
         QueAuxi.Open;
         IDCaixa := QueAuxi.FieldByName('NEW_IDCaixa').AsInteger;
         Self.Close;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar abertura de caixa -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar!', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   Result := True;
end;

procedure TFrmAbreCx.btReabreClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if IDCaixa <= 0 then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         if MostraMsg('Confirmação','Confirma reabertura do caixa?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
         QueAuxi.SQL.Text := 'UPDATE arqcaixa SET VlrFecha = 0.00, DatHorFecha = NULL WHERE IDCaixa = '+IDCaixa.ToString;
         QueAuxi.ExecSQL;
         edVlrFecha.Value := 0.00;
         lbDatHorFecha.Caption := '';
         Exit;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar reabertura de Caixa -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível reabrir caixa!', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmAbreCx.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if IDCaixa <= 0 then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         if MostraMsg('Confirmação','Confirma exclusão?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
         QueAuxi.SQL.Text := 'DELETE FROM arqcaixa WHERE IDCaixa = '+IDCaixa.ToString;
         QueAuxi.ExecSQL;
         btNovoClick(Self);
         Exit;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir Abertura de Caixa -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível excluir', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmAbreCx.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmAbreCx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.

