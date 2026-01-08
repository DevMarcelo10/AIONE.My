unit uCaixa;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, LMDListComboBox, LMDDBListComboBox,
   Vcl.StdCtrls, LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel, Data.DB,
   LMDCustomListComboBox, Vcl.ExtCtrls, LMDCustomLabel, MarcLib, Vcl.DBCtrls,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, LMDEdit, LMDMaskEdit, LMDCustomMaskEdit, AdvGlowButton,
   LMDCustomBevelPanel, uRESTDWBasicDB;

type
   TFrmCaixa = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelDadCom: TLMDSimplePanel;
    timAlpha: TTimer;
    PnaelBasMenus: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    btEntregas: TAdvGlowButton;
    btSuprir: TAdvGlowButton;
    btLancar: TAdvGlowButton;
    btSangria: TAdvGlowButton;
    btReceber: TAdvGlowButton;
    PanelMenFor: TLMDSimplePanel;
    btConFor: TAdvGlowButton;
    btPedEle: TAdvGlowButton;
    btNegoci: TAdvGlowButton;
    btBanFor: TAdvGlowButton;
    Shape2: TShape;
    btObsFor: TAdvGlowButton;
    btPendente: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    barselBut: TShape;
    PanelSubCad: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    btBusca: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel7: TLMDLabel;
    LMDLabel1: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    edSaldo: TLMDMaskEdit;
    edSaidas: TLMDMaskEdit;
    edEntrada: TLMDMaskEdit;
    edAbre: TLMDMaskEdit;
    edOperador: TLMDLabeledEdit;
    LMDLabel5: TLMDLabel;
    edDatAbre: TLMDLabeledEdit;
    LMDLabel6: TLMDLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btAbreFormsClick(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
    auxIDCaixa:Integer;
    CxVerifica:Boolean;
    FormAtivo:TForm;
    procedure FechaSubForm;
    procedure AbreSubForm(NomeForm:String);
  public
    { Public declarations }
    procedure AtuSaldo;
  end;

var
   FrmCaixa: TFrmCaixa;

implementation


//--> NESSE PONTO: FAZER O ITEM "LANÇAMENTOS".


{$R *.dfm}

uses uDM, uConst, uLibFarm, uPrincipal, uAbreCx, uPendente, uSupSanCx, uCaixaLan;

procedure TFrmCaixa.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   CxVerifica := False;
end;

procedure TFrmCaixa.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
   btPendente.Click;
end;

procedure TFrmCaixa.btAbreFormsClick(Sender: TObject);
begin
   AbreSubForm(Trim(Copy(TAdvGlowButton(Sender).Name,3,6)));
   barselBut.Left  := TAdvGlowButton(Sender).Left;
   barselBut.Width := TAdvGlowButton(Sender).Width;
end;

// ----------- Abre Sub Formulários ----------- //
procedure TFrmCaixa.AbreSubForm(NomeForm:String);
var
   PanelPos:TPoint;
   TFormAtivo:TFormClass;
   QueAuxi:TRESTDWClientSQL;
   CenterX,CenterY:Integer;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         // ---- Verificação Inicial se Existe Caixa em Aberto ---- //
         if not CxVerifica then
         begin
            QueAuxi.SQL.Text := 'SELECT CAI.IDCaixa,CAI.VlrAbre,CAI.DatHorAbre,UPPER(USU.Nomusu) AS Nomusu FROM arqcaixa CAI '+
            'LEFT JOIN arqusuario USU ON CAI.IDUsu = USU.IDusu WHERE CAI.IDFilial = '+FILIAL.ToString+' AND CAI.IDUsu = '+IDUSU.ToString+' '+
            'AND (ISNULL(DatHorFecha) OR DatHorFecha < "2000-01-01") ORDER BY CAI.IDCaixa DESC LIMIT 1';
            QueAuxi.Open;
            if QueAuxi.IsEmpty then
            begin
               edAbre.AsCurrency    := 0.00;
               edSaidas.AsCurrency  := 0.00;
               edEntrada.AsCurrency := 0.00;
               try
                  PanelPos := FrmPrincipal.PanelBas.ClientToScreen(Point(0,0));
                  if FrmAbreCx = nil then Application.CreateForm(TFrmAbreCx, FrmAbreCx);
                  CenterX := PanelPos.X + (FrmPrincipal.PanelBas.Width  div 2);
                  CenterY := PanelPos.Y + (FrmPrincipal.PanelBas.Height div 2);
                  FrmAbreCx.Left := CenterX - (FrmAbreCx.Width  div 2);
                  FrmAbreCx.Top  := CenterY - (FrmAbreCx.Height div 2);
                  FrmAbreCx.IDCaixa := 0;
                  FrmAbreCx.ShowModal;
               finally
                  auxIDCaixa           := QueAuxi.FieldByName('IDCaixa').AsInteger;
                  edOperador.Text      := FrmAbreCx.edNomusu.Text;
                  edDatAbre.Text       := DateTimeToStr(FrmAbreCx.edDatAbre.Date);
                  edAbre.AsCurrency    := FrmAbreCx.edVlrAbreCx.Value;
                  edEntrada.AsCurrency := 0.00;
                  edSaidas.AsCurrency  := 0.00;
                  edSaldo.AsCurrency   := FrmAbreCx.edVlrAbreCx.Value;
                  FrmAbreCx := nil;
               end;
            end else
            begin
               auxIDCaixa        := QueAuxi.FieldByName('IDCaixa').AsInteger;
               edOperador.Text   := QueAuxi.FieldByName('Nomusu').AsString;
               edDatAbre.Text    := Copy(QueAuxi.FieldByName('DatHorAbre').AsString,1,16);
               edAbre.AsCurrency := QueAuxi.FieldByName('VlrAbre').AsFloat;
            end; //if
            AtuSaldo;
         end; //if
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO,PastaLog, 'ERRO: Verificando se existe caixa em aberto - uCaixa -> '+E.Message);
            MostraMsg('Erro','Não foi possível verificar se há caixa em aberto!',mtError, [mbOk]);
            Exit;
         end;
      end;
      CxVerifica := True;
      edSaldo.AsCurrency := edAbre.AsCurrency + edEntrada.AsCurrency - edSaidas.AsCurrency;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

   FechaSubForm;
   if NomeForm = 'Penden' then TFormAtivo := TFrmCxPend   else
   if NomeForm = 'Sangri' then TFormAtivo := TFrmSupSanCx else
   if NomeForm = 'Suprir' then TFormAtivo := TFrmSupSanCx else
   if NomeForm = 'Lancar' then TFormAtivo := TFrmCaixaLan
   else begin
      MostraMsg('Aviso', 'Em desenvolvimento !!!', mtWarning, [mbOk]);
      Exit;
   end;
   //if NomeForm = 'Recebe' then TFormAtivo := TFrmTransmite else
   //if NomeForm = 'Entreg' then TFormAtivo := TFrmSNEstoq   else
   FormAtivo := TFormAtivo.Create(Application);
   FormAtivo.Parent := PanelSubCad;
   if FormAtivo is TFrmSupSanCx then
   begin
      TFrmSupSanCx(FormAtivo).auxSupSan := iif(NomeForm = 'Sangri','A','S');
      TFrmSupSanCx(FormAtivo).recSaldo  := edSaldo.AsCurrency;
   end;
   FormAtivo.Show;
end;

// ------- VERIFICA SE HÁ SUPRIMENTO/SANGRIAS P/ CAIXA ------ //
procedure TFrmCaixa.AtuSaldo;
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text :=
         'SELECT COALESCE(SUM(CASE WHEN SupSan = "S" THEN ValorMov ELSE 0 END), 0) AS TotSuprim, '+
         'COALESCE(SUM(CASE WHEN SupSan = "A" THEN ValorMov ELSE 0 END), 0) AS TotSangra '+
         'FROM arqcaixasupsan WHERE IDFilial = '+FILIAL.ToString+' AND IDCaixa = '+auxIDCaixa.ToString;
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            edSaidas.AsCurrency  := QueAuxi.FieldByName('TotSangra').AsFloat;
            edEntrada.AsCurrency := QueAuxi.FieldByName('TotSuprim').AsFloat;
         end;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO,PastaLog, 'ERRO: Atualizando Saldo de Caixa -> uCaixa -> '+E.Message);
            MostraMsg('Erro','Não foi possível atualizar saldo de caixa!',mtError, [mbOk]);
            Exit;
         end;
      end;
      CxVerifica := True;
      edSaldo.AsCurrency := edAbre.AsCurrency + edEntrada.AsCurrency - edSaidas.AsCurrency;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

// ----------- Fecha Formulários ----------- //
procedure TFrmCaixa.FechaSubForm;
begin
   if Assigned(FormAtivo) then
   begin
      FormAtivo.Close;
      FreeAndNil(FormAtivo);
   end;
end;

procedure TFrmCaixa.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaSubForm;
   Action := caFree;
end;

end.

