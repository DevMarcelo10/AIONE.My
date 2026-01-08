unit uTitulosCad;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, Vcl.StdCtrls, Vcl.Mask, MarcLib,
   RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel,
   LMDCustomLabel, LMDCustomBevelPanel, Data.DB,Vcl.ExtCtrls, AdvGlowButton,
   AdvEdit, LMDEdit, Vcl.DBCtrls, FireDAC.Stan.Intf, Vcl.Grids, FireDAC.Stan.Error,
   LMDCustomParentPanel, LMDCustomGroupBox, LMDCustomButtonGroup, LMDCustomRadioGroup,
   LMDDBRadioGroup, uRESTDWBasicTypes, uRESTDWBasicDB, FireDAC.Stan.Option,
   FireDAC.Stan.Param,  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TFrmTitCad = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    SouTitu: TDataSource;
    TabTitu: TRESTDWClientSQL;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    btBusca: TAdvGlowButton;
    TabTituIDTitu: TFDAutoIncField;
    TabTituIDPess: TIntegerField;
    TabTituNrotit: TWideStringField;
    TabTituDestit: TWideStringField;
    TabTituPagRec: TWideStringField;
    TabTituIDTiptit: TIntegerField;
    TabTituDatemi: TDateField;
    TabTituDatven: TDateField;
    TabTituDesAsso: TFloatField;
    TabTituVlrAces: TFloatField;
    TabTituVlrtit: TFloatField;
    TabTituSaltit: TFloatField;
    TabTituHistit: TWideStringField;
    TabTituIDFilial: TIntegerField;
    TabTituIDPed: TIntegerField;
    TabTituIDNatFin: TIntegerField;
    TabTituNompes: TWideStringField;
    TabTituNomfil: TWideStringField;
    TabTituVlrDevo: TFloatField;
    TabTituDesTiptit: TWideStringField;
    TabTituNotFis: TIntegerField;
    btMulti: TAdvGlowButton;
    TabTituDesnat: TWideStringField;
    btNegocios: TAdvGlowButton;
    TabTituIndSel: TWideStringField;
    TabTituIDTitBai: TIntegerField;
    PanelEdits: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel3: TLMDLabel;
    rgPagRec: TLMDDBRadioGroup;
    edNroTit: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    edTiptit: TLMDDBLabeledEdit;
    LMDDBLabeledEdit0: TLMDDBLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    DBDateEdit1: TDBDateEdit;
    edValorTit: TLMDDBLabeledEdit;
    edPessoa: TLMDDBLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    DBDateEdit2: TDBDateEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    edNatFin: TLMDDBLabeledEdit;
    edNomFil: TLMDDBLabeledEdit;
    edDescAssoc: TLMDDBLabeledEdit;
    edDespAcesso: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    edHist: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    edCodBarra: TLMDDBLabeledEdit;
    TabTituCodBarra: TWideStringField;
    PanelRodape: TLMDSimplePanel;
    PanelButtons: TLMDSimplePanel;
    btNovo: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    edValJuro: TLMDDBLabeledEdit;
    edValMulta: TLMDDBLabeledEdit;
    edPerJuro: TLMDDBLabeledEdit;
    edPerMulta: TLMDDBLabeledEdit;
    edNosNum: TLMDDBLabeledEdit;
    edCodRec: TLMDDBLabeledEdit;
    Shape2: TShape;
    edNumRef: TLMDDBLabeledEdit;
    pnDatDoc: TLMDSimplePanel;
    edDatDoc: TDBDateEdit;
    lbDataDoc: TLMDLabel;
    TabTituIDConv: TIntegerField;
    TabTituNossoNro: TWideStringField;
    TabTituCodRec: TIntegerField;
    TabTituNumReferencia: TWideStringField;
    TabTituDatCompApur: TDateField;
    TabTituValorJuros: TFloatField;
    TabTituValorMulta: TFloatField;
    TabTituPercenJuros: TFloatField;
    TabTituPercenMulta: TFloatField;
    edPIX: TLMDLabeledEdit;
    TabTituChavePIXQRCode: TWideStringField;
    edAgBenef: TLMDDBLabeledEdit;
    TabTituAgBenef: TLargeintField;
    TabTituIndEnvBco: TWideStringField;
    Shape1: TShape;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabTituAfterInsert(DataSet: TDataSet);
    procedure LMDDBLabeledEdit0DataChange(Sender: TObject);
    procedure edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edTiptitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edTiptitCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomFilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edValorTitExit(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure btMultiClick(Sender: TObject);
    procedure LMDDBLabeledEdit10CustomButtons0Click(Sender: TObject; index: Integer);
    procedure TabTituBeforeEdit(DataSet: TDataSet);
    procedure edTiptitExit(Sender: TObject);
    procedure rgPagRecClick(Sender: TObject);
    procedure edAgBenefChange(Sender: TObject);
    procedure edPessoaExit(Sender: TObject);
    procedure edCodBarraKeyPress(Sender: TObject; var Key: Char);
    procedure edPessoaCustomButtons1Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
    auxSQL,AuxChaPixQRCode,AuxPixTXID:String;
    auxTotRateio,ValorRateio:Double;
    recIDTitu:Integer;
    saiBusEsp:Boolean;
    Rateio : TStringGrid;
    function Salvar:Boolean;
    function AtuSalTitu:Boolean;
    procedure AbreSQL;
    procedure AcertaCampos;
    procedure SalvaRateio(auxIDTitu,auxIDFilial,auxRetID:Integer);
    procedure ExcluiRateioTemp;
    procedure CriaStrGrid;
    procedure BuscaChavePix;
    procedure BuscaFilial;
  public
    { Public declarations }
  end;
var
   FrmTitCad: TFrmTitCad;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaTit, uBuscaPes, uMultTit,
     uValorRatTemp, uWaitForm, uPessoasCad;

procedure TFrmTitCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   CriaStrGrid;
end;

procedure TFrmTitCad.FormShow(Sender: TObject);
begin
   auxTotRateio := 0.00;
   saiBusEsp := False;
   AbreSQL;
   TabTitu.Append;
   edTiptit.SetFocus;
   AcertaCampos;
   AuxChaPixQRCode := '';
   AuxPixTXID      := '';
   BuscaFilial;
end;

procedure TFrmTitCad.AbreSQL;
begin
   if TabTitu.Active then TabTitu.Close;
   auxSQL := 'SELECT TIT.*,PES.Nompes,FIL.Nomfil,TIP.DesTiptit,NAT.Desnat,BAI.IDTitu AS IDTitBai FROM arqtitulo TIT '+
   'LEFT JOIN arqtiptitu TIP ON TIT.IDTiptit = TIP.IDTiptit LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '+
   'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial LEFT JOIN arqnatfin NAT ON TIT.IDNatFin = NAT.IDNatFin '+
   'LEFT JOIN arqtitulobai BAI ON TIT.IDTitu = BAI.IDTitu';
   TabTitu.SQL.Text := auxSQL+iif(recIDTitu > 0,' WHERE TIT.IDTitu = '+recIDTitu.ToString,'')+' LIMIT 1';
   TabTitu.Open;
   recIDTitu := 0;
end;

procedure TFrmTitCad.CriaStrGrid;
begin
   Rateio := TStringGrid.Create(Self);
   Rateio.Parent   := Self;
   Rateio.Visible  := False;
   Rateio.RowCount := 0;
   Rateio.ColCount := 3;
   Rateio.Enabled  := True;
end;

procedure TFrmTitCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

// Acerta os componentes que podem ser editados ou não //
procedure TFrmTitCad.AcertaCampos;
begin
     // 0 = A pagar
   if rgPagRec.ItemIndex = 0 then
   begin
       //  0 = nenhum selecionado, 4 = NOTA FISCAL, 5 = CHEQUE, 6 = NOTA PROMISSÓRIA
       //  7 = DEPÓSITO EM CONTA, 8 = DÉBITO AUTOMÁTICO, 9 = PIX, 10 = PIX QR CODE
       // 11 = CREDITO EM CONTA CORRENTE, 12 = ORDEM PAGAMENTO, 13 = TED
      if TabTituIDTiptit.AsInteger in [0,4,5,6,7,8,9,10,11,12,13] then
      begin
         edNosNum.Color     := $00F5F5F5;
         edCodRec.Color     := $00F5F5F5;
         edNumRef.Color     := $00F5F5F5;
         edValJuro.Color    := $00F5F5F5;
         edPerJuro.Color    := $00F5F5F5;
         edValMulta.Color   := $00F5F5F5;
         edPerMulta.Color   := $00F5F5F5;
         edDatDoc.Color     := $00F5F5F5;
         pnDatDoc.Color     := $00F5F5F5;
         edNosNum.Enabled   := False;
         edCodRec.Enabled   := False;
         edNumRef.Enabled   := False;
         edValJuro.Enabled  := False;
         edPerJuro.Enabled  := False;
         edValMulta.Enabled := False;
         edPerMulta.Enabled := False;
         pnDatDoc.Enabled   := False;
         edDatDoc.Enabled   := False;
         lbDataDoc.Caption  := 'DATA DOCUMENTO';
      end; // if

      // 1 = BOLETO BANCARIO PROPRIO BANCO, 2 = BOLETO BANCARIO OUTRO BANCO
      if TabTituIDTiptit.AsInteger in [1,2] then
      begin
         edCodRec.Color   := $00F5F5F5;
         edNumRef.Color   := $00F5F5F5;
         edDatDoc.Color   := $00F5F5F5;
         pnDatDoc.Color   := $00F5F5F5;
         edCodRec.Enabled := False;
         edNumRef.Enabled := False;
         pnDatDoc.Enabled := False;
         edDatDoc.Enabled := False;
         edNosNum.Color   := clWhite;
         edValJuro.Color  := clWhite;
         edPerJuro.Color  := clWhite;
         edValMulta.Color := clWhite;
         edPerMulta.Color := clWhite;
         edNosNum.Enabled   := True;
         edValJuro.Enabled  := True;
         edPerJuro.Enabled  := True;
         edValMulta.Enabled := True;
         edPerMulta.Enabled := True;
         lbDataDoc.Caption  := 'DATA DOCUMENTO';
      end; // if
      // 16 = GPS
      if TabTituIDTiptit.AsInteger = 16 then
      begin
         edNumRef.Color   := $00F5F5F5;
         edNosNum.Color   := $00F5F5F5;
         edValJuro.Color  := $00F5F5F5;
         edPerJuro.Color  := $00F5F5F5;
         edValMulta.Color := $00F5F5F5;
         edPerMulta.Color := $00F5F5F5;
         edNumRef.Enabled   := False;
         edNosNum.Enabled   := False;
         edValJuro.Enabled  := False;
         edPerJuro.Enabled  := False;
         edValMulta.Enabled := False;
         edPerMulta.Enabled := False;
         edCodRec.Color := clWhite;
         edDatDoc.Color := clWhite;
         pnDatDoc.Color := clWhite;
         edCodRec.Enabled  := True;
         pnDatDoc.Enabled  := True;
         edDatDoc.Enabled  := True;
         lbDataDoc.Caption := 'POR COMPETÊNCIA';
      end;
      // if 14 = DARF normal, 15 = DARF simples
      if (TabTituIDTiptit.AsInteger = 14) or (TabTituIDTiptit.AsInteger = 15) then
      begin
         if TabTituIDTiptit.AsInteger = 14 then
         begin
            edNumRef.Color   := clWhite;
            edNumRef.Enabled := True;
         end else
         begin
            edNumRef.Color   := $00F5F5F5;
            edNumRef.Enabled := False;
         end;
         edNosNum.Color   := $00F5F5F5;
         edNosNum.Enabled := False;
         edCodRec.Color   := clWhite;
         edValJuro.Color  := clWhite;
         edPerJuro.Color  := clWhite;
         edValMulta.Color := clWhite;
         edPerMulta.Color := clWhite;
         edDatDoc.Color   := clWhite;
         pnDatDoc.Color   := clWhite;
         edCodRec.Enabled   := True;
         edValJuro.Enabled  := True;
         edPerJuro.Enabled  := True;
         edValMulta.Enabled := True;
         edPerMulta.Enabled := True;
         pnDatDoc.Enabled   := True;
         edDatDoc.Enabled   := True;
         lbDataDoc.Caption  := 'PER APURAÇÃO';
      end;
   end else
   if rgPagRec.ItemIndex = 1 then
   begin
      // 1 = BOLETO BANCARIO PROPRIO BANCO, 2 = BOLETO BANCARIO OUTRO BANCO
      if (TabTituIDTiptit.AsInteger = 1) or (TabTituIDTiptit.AsInteger = 2) then
      begin
         edCodRec.Color   := $00F5F5F5;
         edNumRef.Color   := $00F5F5F5;
         edDatDoc.Color   := $00F5F5F5;
         pnDatDoc.Color   := $00F5F5F5;
         edCodRec.Enabled := False;
         edNumRef.Enabled := False;
         pnDatDoc.Enabled := False;
         edDatDoc.Enabled := False;
         edNosNum.Color   := clWhite;
         edValJuro.Color  := clWhite;
         edPerJuro.Color  := clWhite;
         edValMulta.Color := clWhite;
         edPerMulta.Color := clWhite;
         edNosNum.Enabled   := True;
         edValJuro.Enabled  := True;
         edPerJuro.Enabled  := True;
         edValMulta.Enabled := True;
         edPerMulta.Enabled := True;
         lbDataDoc.Caption  := 'DATA DOCUMENTO';
      end else
      begin
         edCodRec.Color   := $00F5F5F5;
         edNumRef.Color   := $00F5F5F5;
         edDatDoc.Color   := $00F5F5F5;
         pnDatDoc.Color   := $00F5F5F5;
         edNosNum.Color   := $00F5F5F5;
         edValJuro.Color  := $00F5F5F5;
         edPerJuro.Color  := $00F5F5F5;
         edValMulta.Color := $00F5F5F5;
         edPerMulta.Color := $00F5F5F5;
         edCodRec.Enabled   := False;
         edNumRef.Enabled   := False;
         pnDatDoc.Enabled   := False;
         edDatDoc.Enabled   := False;
         edNosNum.Enabled   := False;
         edValJuro.Enabled  := False;
         edPerJuro.Enabled  := False;
         edValMulta.Enabled := False;
         edPerMulta.Enabled := False;
         lbDataDoc.Caption  := 'DATA DOCUMENTO';
      end; //if
   end; //if

   if TabTituIDTiptit.AsInteger = 9 then // PIX
   begin
      edPIX.Width  := 413;
      edPIX.Top    := 261;
      edPIX.Left   := 20;
      edPIX.Height := 23;
      edPIX.Visible  := True;
      edPIX.TabOrder := 8;
      edCodBarra.Visible := False;
   end else
   begin
      edCodBarra.Visible   := True;
      edCodBarra.TabOrder  := 8;
      edPIX.Visible := False;
      edPIX.Text    := '';
      AuxChaPixQRCode := '';
      AuxPixTXID      := '';
      if TabTituIDTiptit.AsInteger = 10 then  // PIX QR CODE
      begin
         edCodBarra.DataField := 'ChavePIXQRCode';
         edCodBarra.EditLabel.Caption := 'CHAVE PIX QR CODE';
      end else
      begin
         edCodBarra.DataField := 'CodBarra';
         edCodBarra.EditLabel.Caption := 'CÓDIGO DE BARRAS';
      end;
   end; //if
end;

procedure TFrmTitCad.LMDDBLabeledEdit0DataChange(Sender: TObject);
begin
   if TabTituIDTitu.AsInteger > 0 then
        LMDDBLabeledEdit0.DataField := 'IDTitu'
   else LMDDBLabeledEdit0.DataField := '';
end;

procedure TFrmTitCad.edAgBenefChange(Sender: TObject);
begin
   if Length(edAgBenef.Text) > 15 then
   begin
      edAgBenef.Text := Copy(edAgBenef.Text,1,15);
   end;
end;

procedure TFrmTitCad.edCodBarraKeyPress(Sender: TObject; var Key: Char);
var
   auxCodBar,auxTexto:String;
   auxCarac:Char;
   I:Integer;
begin
   if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
      key := #0;
   auxTexto := edCodBarra.Text.Trim;
   for I := 1 to Length(auxTexto) do
   begin
      auxCarac := auxTexto[I];
      if (auxCarac in ['0'..'9']) then
      begin
         auxCodBar := auxCodBar + auxCarac;
      end;
   end;
   edCodBarra.Text := auxCodBar;
end;

procedure TFrmTitCad.LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
begin
   edNomFil.SetFocus;
   btBuscasDB(TabTitu,'arqfilial',TDBEdit(edNomFil),'IDFilial','IDFilial','Nomfil','Nomfil','',0);
end;

procedure TFrmTitCad.edNomFilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabTitu,'arqfilial',TDBEdit(edNomFil),'IDFilial','IDFilial','Nomfil','Nomfil','',Key);
end;

procedure TFrmTitCad.edTiptitCustomButtons0Click(Sender: TObject; index: Integer);
begin
   edTiptit.SetFocus;
   btBuscasDB(TabTitu,'arqtiptitu',TDBEdit(edTiptit),'IDTiptit','IDTiptit','DesTiptit','DesTiptit','',0);
   AcertaCampos;
end;

procedure TFrmTitCad.edTiptitExit(Sender: TObject);
begin
   AcertaCampos;
   BuscaChavePix;
end;

procedure TFrmTitCad.edTiptitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabTitu,'arqtiptitu',TDBEdit(edTiptit),'IDTiptit','IDTiptit','DesTiptit','DesTiptit','',Key);
end;

procedure TFrmTitCad.edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
var
   auxRecIDPess:Integer;
begin
   Self.AlphaBlendValue := 165;
   Application.CreateForm(TFrmPesCad, FrmPesCad);
   try
      if TabTituIDPess.AsInteger > 0 then
           FrmPesCad.recIDPess := TabTituIDPess.AsInteger
      else FrmPesCad.recIDPess := 0;
      CentralizarControl(FrmPesCad, FrmTitCad);
      FrmPesCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxRecIDPess := FrmPesCad.recIDPess;
      FrmPesCad := nil;
      BuscaChavePix;
   end;// try
end;

procedure TFrmTitCad.edPessoaCustomButtons1Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   edPessoa.SetFocus;
   try
      edPessoa.Tag := 0;
      FrmBuscaPes := TFrmBuscaPes.Create(Application);
      with FrmBuscaPes do
      begin
         lPoint := Self.edPessoa.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edPessoa.Width;
         edRetorno    := TLMDEdit(edPessoa);
         edBusca.Text := Self.edPessoa.Text;
         ShowModal;
      end; // with
   finally
      if not (TabTitu.State in dsEditModes) then TabTitu.Edit;
      TabTituIDPess.Value := edPessoa.Tag;
      FrmBuscaPes.Free;
      saiBusEsp := True;
   end;// try
end;

procedure TFrmTitCad.edPessoaExit(Sender: TObject);
begin
   BuscaChavePix;
end;

procedure TFrmTitCad.edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_RETURN) then edPessoaCustomButtons0Click(Sender, 0);
   if (ssCtrl in Shift) or (IsNumeric(Copy(TLMDEdit(Sender).Text.Trim,1,3))) then Exit;
   if not saiBusEsp then btBuscasDB(TabTitu,'arqpessoa',TDBEdit(Sender),'IDPess','IDPess','Nompes','Nompes','',Key);
   saiBusEsp := False;
end;

procedure TFrmTitCad.edValorTitExit(Sender: TObject);
begin
   AtuSalTitu;
end;

procedure TFrmTitCad.rgPagRecClick(Sender: TObject);
begin
   AcertaCampos;
end;

procedure TFrmTitCad.btNovoClick(Sender: TObject);
begin
   btNovo.SetFocus;
   if TabTitu.State in dsEditModes then
   begin
      if MostraMsg('Confirmação','Confirmar gravação dos dados do título?', mtConfirmation,[mbYes, mbNo]) = mrNo then
      begin
         TabTitu.Cancel;
         TabTitu.Close;
         TabTitu.SQL.Text := auxSQL + ' LIMIT 1';
         TabTitu.Open;
         TabTitu.Append;
         BuscaFilial;
         edTiptit.SetFocus;
         ExcluiRateioTemp;
      end else
      begin
         if TabTituIndEnvBco.AsString = 'S' then
         begin
            MostraMsg('Titulo enviado para Banco','Este titulo não pode ser alterado!',mtWarning, [mbOk]);
            TabTitu.Cancel;
            TabTitu.Close;
            TabTitu.SQL.Text := auxSQL + ' LIMIT 1';
            TabTitu.Open;
            TabTitu.Append;
            BuscaFilial;
            edTiptit.SetFocus;
            ExcluiRateioTemp;
         end
         else Salvar;
      end;// if
   end else
   begin
      TabTitu.Cancel;
      TabTitu.Close;
      TabTitu.SQL.Text := auxSQL + ' LIMIT 1';
      TabTitu.Open;
      TabTitu.Append;
      BuscaFilial;
      edTiptit.SetFocus;
   end;// if
end;

procedure TFrmTitCad.TabTituAfterInsert(DataSet: TDataSet);
begin
   auxTotRateio := 0.00;
   TabTituDatemi.Value    := Date;
   TabTituPagRec.Value    := 'P';
   TabTituIDTiptit.Value  := 0;
   TabTituIndSel.Value    := '0';
   TabTituDesTiptit.Value := '';
   TabTituDestit.AsString := '1';
end;

procedure TFrmTitCad.TabTituBeforeEdit(DataSet: TDataSet);
begin
   if (not TabTituIDTitBai.IsNull) and (TabTitu.State <> dsInsert) then
   begin
      MostraMsg('Aviso','Este titulo já possui baixas e não pode ser modificado!',mtWarning, [mbOk]);
      Abort;
   end
   else PanelEdits.Enabled := True;
end;

procedure TFrmTitCad.SalvaRateio(auxIDTitu,auxIDFilial,auxRetID:Integer);
var
   QueAuxi,QueGrava,QueParam,QueRate: TRESTDWClientSQL;
   nLinha : Integer;
begin
   QueAuxi  := TRESTDWClientSQL.Create(nil);
   QueGrava := TRESTDWClientSQL.Create(nil);
   QueParam := TRESTDWClientSQL.Create(nil);
   QueRate  := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase  := DM.DWDataBase;
   QueGrava.DataBase := DM.DWDataBase;
   QueParam.DataBase := DM.DWDataBase;
   QueRate.DataBase  := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT * FROM arqtitulorattemp WHERE IDTitu = '+auxIDTitu.ToString;
      Queauxi.Open;
      if Queauxi.RecordCount > 0 then
      begin
         if auxIDTitu > 0 then
         begin
            try
               QueRate.Close;
               QueRate.SQL.Text := 'DELETE FROM arqtitulorat WHERE IDTitu = '+auxIDTitu.ToString;
               QueRate.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir rateio na tabela arqtitulorat em uTitulosCad -> '+E.Message);
                  MostraMsg('Erro','Não foi possível excluir registro.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end;// try
         end;// if

         while not Queauxi.Eof do
         begin
            try
               QueGrava.Close;
               QueGrava.SQL.Clear;
               QueGrava.SQL.Text := 'INSERT INTO arqtitulorat (IDTitu, IDNatFin, ValorRat) VALUES ('+
               auxRetID.ToString+','+
               Queauxi.FieldByName('IDNatFin').AsString+','+
               FormatDouble(Queauxi.FieldByName('ValorRat').AsFloat,11,2)+')';
               QueGrava.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível incluir rateio na tabela arqtitulorat em uTitulosCad -> '+E.Message);
                  MostraMsg('Erro','Não foi possível incluir registro.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end; // try
            Queauxi.Next;
         end; // while

         QueParam.Close;
         QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+auxIDFilial.ToString;
         QueParam.Open;
         // grava rateio das despesas acessórias
         if Not (QueAuxi.Locate('IDNatFin', QueParam.FieldByName('IDNatFinDesAce').AsString,[])) then
         begin
            if TabTituVlrAces.AsFloat > 0 then
            begin
               try
                  QueGrava.Close;
                  QueGrava.SQL.Clear;
                  QueGrava.SQL.Text := 'INSERT INTO arqtitulorat (IDTitu, IDNatFin, ValorRat) VALUES ('+
                  auxRetID.ToString+','+
                  QueParam.FieldByName('IDNatFinDesAce').AsString+','+
                  FormatDouble(TabTituVlrAces.AsFloat,11,2)+')';
                  QueGrava.ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível incluir rateio na tabela arqtitulorat em uTitulosCad -> '+E.Message);
                     MostraMsg('Erro','Não foi possível incluir registro.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end;// try
            end;// if
         end;// if

         // Grava rateio dos descontos associado
         if not (QueAuxi.Locate('IDNatFin', QueParam.FieldByName('IDNatFinDesAsso').AsString,[])) then
         begin
            if TabTituDesAsso.AsFloat > 0 then
            begin
               try
                  QueGrava.Close;
                  QueGrava.SQL.Clear;
                  QueGrava.SQL.Text := 'INSERT INTO arqtitulorat (IDTitu, IDNatFin, ValorRat) VALUES ('+
                  auxRetID.ToString+','+
                  QueParam.FieldByName('IDNatFinDesAsso').AsString+','+
                  FormatDouble(Queauxi.FieldByName('ValorRat').AsFloat,11,2)+')';
                  QueGrava.ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível incluir rateio na tabela arqtitulorat em uTitulosCad -> '+E.Message);
                     MostraMsg('Erro','Não foi possível incluir registro.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end;// try
            end;// if
         end;// if
      end else
      begin
         QueParam.Close;
         QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+auxIDFilial.ToString;
         QueParam.Open;
         QueRate.Close;
         QueRate.SQL.Text := 'SELECT * FROM arqtitulorat WHERE IDTitu = '+auxRetID.ToString;
         QueRate.Open;
         // Grava rateio das despesas acessórias
         if QueRate.Locate('IDNatFin', QueParam.FieldByName('IDNatFinDesAce').AsString,[]) then
         begin
            if TabTituVlrAces.AsFloat <> QueRate.FieldByName('ValorRat').AsFloat then
            begin
               try
                  QueGrava.Close;
                  QueGrava.SQL.Clear;
                  QueGrava.SQL.Text := 'UPDATE arqtitulorat SET '+
                  ' ValorRat = '+FormatDouble(TabTituVlrAces.AsFloat,11,2)+
                  ' WHERE IDTitu = '+auxRetID.ToString+
                  ' AND IDNatFin = '+QueParam.FieldByName('IDNatFinDesAce').AsString;
                  QueGrava.ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível Alterar o rateio na tabela arqtitulorat em uTitulosCad -> '+E.Message);
                     MostraMsg('Erro','Não foi possível alterar registro.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end;// try
            end;// if
         end;// if

         // Grava rateio dos descontos associado
         if QueRate.Locate('IDNatFin', QueParam.FieldByName('IDNatFinDesAsso').AsString,[]) then
         begin
            if TabTituDesAsso.AsFloat <> QueRate.FieldByName('ValorRat').AsFloat then
            begin
               try
                  QueGrava.Close;
                  QueGrava.SQL.Clear;
                  QueGrava.SQL.Text := 'UPDATE arqtitulorat SET'+
                  ' ValorRat = '+FormatDouble(TabTituDesAsso.AsFloat,11,2)+
                  ' WHERE IDTitu = '+auxRetID.ToString+
                  ' AND IDNatFin = '+QueParam.FieldByName('IDNatFinDesAsso').AsString;
                  QueGrava.ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível Alterar o rateio na tabela arqtitulorat em uTitulosCad -> '+E.Message);
                     MostraMsg('Erro','Não foi possível alterar registro.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end; //try
            end; //if
         end; //if
      end;
      ExcluiRateioTemp;
   finally
      QueAuxi.Close;
      QueGrava.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueGrava);
   end;// try
end;

procedure TFrmTitCad.ExcluiRateioTemp;
var
   QueAuxi: TRESTDWClientSQL;
   auxIDTitu:Integer;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      if TabTituIDTitu.AsInteger <= 0 then
           auxIDTitu := 0
      else auxIDTitu := TabTituIDTitu.AsInteger;
      // Exclusão dos rateios da natureza financeira dos titulos da tabela temporária
      try
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Text := 'DELETE FROM arqtitulorattemp WHERE IDTitu = '+auxIDTitu.ToString;
         QueAuxi.ExecSQL;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir os rateios da tabela temporária de IDTitu: '+auxIDTitu.ToString+' da tabela arqtitulorattemp em uTitulosCad -> '+E.Message);
            MostraMsg('Erro','Não foi possível Excluir os rateios da tabela temporária do título.'+#10+E.Message, mtWarning, [mbOk]);
         end;
      end; //try
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmTitCad.BuscaChavePix;
var
   QuePess:TRESTDWClientSQL;
begin
   if (TabTituIDTiptit.AsInteger = 9) and (TabTituIDPess.AsInteger <> 0) then
   begin
      QuePess := TRESTDWClientSQL.Create(nil);
      try
         QuePess.DataBase   := DM.DWDataBase;
         QuePess.SQL.Text := 'SELECT * FROM arqpessbanc WHERE IDPess = '+TabTituIDPess.AsString;
         QuePess.Open;
         if QuePess.IsEmpty then
         begin
            MostraMsg('Aviso','Não foi encontrada chave PIX para está pessoa!'+#13+
                      'Favor informar a chave Pix no Cadastro de Pessoa em Dados Financeiros',mtWarning, [mbOk]);
            edPIX.Text := '';
            Exit;
         end;// if
         edPIX.Text := QuePess.FieldByName('IDPix').AsString;
      finally
         QuePess.Close;
         FreeAndNil(QuePess);
      end;// try
   end;// if
end;

procedure TFrmTitCad.BuscaFilial;
var
   QueFilial:TRESTDWClientSQL;
begin
   QueFilial := TRESTDWClientSQL.Create(nil);
   try
      QueFilial.DataBase := DM.DWDataBase;
      QueFilial.SQL.Text := 'SELECT * FROM arqfilial WHERE IDFilial = '+FILIAL.ToString;
      QueFilial.Open;
      if QueFilial.IsEmpty then
      begin
         MostraMsg('Aviso','Não foi encontrada Filial',mtWarning, [mbOk]);
         Exit;
      end;// if
      TabTituIDFilial.AsInteger := IDUSU;
      TabTituNomFil.AsString    := QueFilial.FieldByName('Nomfil').AsString;
   finally
      QueFilial.Close;
      FreeAndNil(QueFilial);
   end;// try
end;

procedure TFrmTitCad.btSalvarClick(Sender: TObject);
begin
   btSalvar.SetFocus;
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmTitCad.Salvar:Boolean;
var
   retID,auxIDTitu,auxIDFilial,auxRetID:Integer;
   FocusObject:TWinControl;
   QueAuxi,QuePess:TRESTDWClientSQL;
   DBEditErro:TLMDDBLabeledEdit;
begin
   if TabTitu.State in dsEditModes then
   begin // Testa se a pessoa tem chave PIX cadastrada, se não tiver não grava.
      if (TabTituIDTiptit.AsInteger = 9) and (TabTituIDPess.AsInteger <> 0) then
      begin
         QuePess := TRESTDWClientSQL.Create(nil);
         try
            QuePess.DataBase   := DM.DWDataBase;
            QuePess.SQL.Text := 'SELECT * FROM arqpessbanc WHERE IDPess = '+TabTituIDPess.AsString;
            QuePess.Open;
            if (QuePess.IsEmpty) or (QuePess.FieldByName('IDPix').AsString = '') then
            begin
               MostraMsg('Aviso','Não foi encontrada chave PIX para está pessoa!'+#13+
                         'Favor informar a chave Pix no Cadastro de Pessoa em Dados Financeiros',mtWarning, [mbOk]);
               Exit;
            end;
            edPIX.Text := QuePess.FieldByName('IDPix').AsString;
         finally
            QuePess.Close;
            FreeAndNil(QuePess);
         end;// try
      end;// if

      if TabTituIndEnvBco.AsString = 'S' then
      begin
         MostraMsg('Titulo enviado para Banco','Este titulo não pode ser alterado!',mtWarning, [mbOk]);
         Exit;
      end; // if

      Result  := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;
      if TabTituIDTiptit.AsInteger <= 0   then DBEditErro := edTiptit else
      if TabTituNrotit.AsString.Trim = '' then DBEditErro := edNroTit else
      if TabTituIDPess.AsInteger <= 0     then DBEditErro := edPessoa else
      if TabTituIDNatFin.AsInteger <= 0   then DBEditErro := edNatFin else
      if TabTituIDFilial.AsInteger <= 0   then DBEditErro := edNomFil else
      if TabTituVlrtit.AsFloat <= 0.00    then DBEditErro := edValorTit;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end; //if

      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text := 'SELECT * FROM arqtitulo WHERE IDPess = '+TabTituIDPess.AsString+' AND Nrotit = '+
         Aspas(TabTituNrotit.AsString)+'  AND Destit = '+Aspas(TabTituDestit.AsString)+' AND IDTitu != '+TabTituIDTitu.AsString;
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            MostraMsg('Título Duplicado','Já existe um título com esse documento e parcela para essa Pessoa!',mtWarning, [mbOk]);
            edNroTit.SetFocus;
            Exit
         end;// if
         if TabTituIDTitu.AsInteger > 0 then
              auxIDTitu := TabTituIDTitu.AsInteger
         else auxIDTitu := 0;
         QueAuxi.Close;

         QueAuxi.SQL.Text := 'SELECT SUM(ValorRat) AS ValorRateio FROM arqtitulorattemp '+
         'WHERE IDTitu = '+auxIDTitu.ToString+' AND RatFixo = 0';
         QueAuxi.Open;
         if not (QueAuxi.FieldByName('ValorRateio').AsFloat = TabTituVlrtit.AsFloat) then
         begin
            MostraMsg('Valor natureza financeira','Valor da natureza financeira diferente do valor do titulo!',mtWarning, [mbOk]);
            edNatFin.SetFocus;
            Exit
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi)
      end;// try

      if TabTituDatemi.AsDateTime <= StrToDate('01/01/2024') then
      begin
         MostraMsg('Data inválida','Favor verificar a Data de Emissão!',mtWarning, [mbOk]);
         DBDateEdit2.SetFocus;
         Exit;
      end;// if

      if (TabTituDatven.AsDateTime <= StrToDate('01/01/2024')) or (TabTituDatemi.AsDateTime > TabTituDatven.AsDateTime) then
      begin
         MostraMsg('Data inválida','Favor verificar a Data de Vencimento!',mtWarning, [mbOk]);
         DBDateEdit1.SetFocus;
         Exit;
      end;// if

      if ((TabTituIDTiptit.AsInteger = 1) or (TabTituIDTiptit.AsInteger = 2)) and (rgPagRec.ItemIndex = 0) then
      begin
         if TabTituCodBarra.AsString = '' then
         begin
            MostraMsg('Código barras informado não está correto','Favor preencher corretamente !',mtWarning, [mbOk]);
            edCodBarra.SetFocus;
            Exit;
         end;// if
      end;// if

      if TabTituIDTiptit.AsInteger = 9 then
      begin
         if edPIX.Text = '' then
         begin
            MostraMsg('Código da chave pix informado não está correto','Favor preencher corretamente !',mtWarning, [mbOk]);
            edPIX.SetFocus;
            Exit;
         end;// if
      end;// if

      if TabTituIDTiptit.AsInteger = 10 then
      begin
         if TabTituChavePIXQRCode.AsString = '' then
         begin
            MostraMsg('Código da chave pix QR CODE informado não está correto','Favor preencher corretamente !',mtWarning, [mbOk]);
            edCodBarra.SetFocus;
            Exit;
         end;// if
      end;// if

      if edCodRec.Enabled then
      begin
         if (length(IntToStr(TabTituCodRec.AsInteger)) < 4) and (length(IntToStr(TabTituCodRec.AsInteger)) > 5) then
         begin
            MostraMsg('Dado informado não está correto','Favor preencher o Código da Receita corretamente !',mtWarning, [mbOk]);
            DBDateEdit1.SetFocus;
            Exit;
         end; //if
      end; //if

      if not AtuSalTitu then Exit;

      if TabTituSaltit.AsFloat < 0.00 then
      begin
         MostraMsg('Saldo Inválido','Verificar os valores do títulos.'+#10+'Cálculo descontos e acréscimos está negativo!',mtWarning, [mbOk]);
         DBDateEdit1.SetFocus;
         Exit;
      end; //if
      // Enviado ao banco para pagamento  N=Não  S=Sim
      TabTituIndEnvBco.AsString := 'N';
      ShowWait('Aguarde...', Self);

      // Pegando o código do convenio da pessoa selecionada.
      QuePess := TRESTDWClientSQL.Create(nil);
      QuePess.DataBase   := DM.DWDataBase;
      try
         QuePess.SQL.Text := 'SELECT PES.IDPess, CON.IDConv FROM arqpessoa PES '+
         'LEFT JOIN arqpessconv PCON ON PCON.IDPess = PES.IDPess '+
         'LEFT JOIN arqconvenio CON ON CON.IDConv = PCON.IDConv '+
         'WHERE PES.IDPess = '+TabTituIDPess.AsString;
         QuePess.Open;
         if not QuePess.IsEmpty then
            TabTituIDConv.AsInteger := QuePess.FieldByName('IDConv').AsInteger;
      finally
         QuePess.Close;
         FreeAndNil(QuePess);
      end;// try

      try
         try
            retID := MyApplayUpdates(TabTitu, 'IDTitu', 'IDTitu = '+TabTituIDTitu.AsString, TabTitu.State);
            if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
            if TabTituIDTitu.AsInteger > 0 then
            begin
               auxIDTitu := TabTituIDTitu.AsInteger;
               auxRetID  := TabTituIDTitu.AsInteger;
            end else
            begin
               auxIDTitu := 0;
               auxRetID  := retID;
            end;
            auxIDFilial := TabTituIDFilial.AsInteger;
            SalvaRateio(auxIDTitu,auxIDFilial,auxRetID);
            TabTitu.Cancel;
            TabTitu.Close;
            TabTitu.SQL.Text := auxSQL+' WHERE TIT.IDTitu = '+retID.ToString;
            TabTitu.Open;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Pessoa -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
               Exit;
            end;
         end;// try
      finally
         HideWait;
      end;// try
      PanelCadastro.Visible := False;
      Sleep(10);
      PanelCadastro.Visible := True;
   end; //if
   Result := True;
end;

// ------------ Calcula e Atualiza o Saldo do Título ------------ //
function TFrmTitCad.AtuSalTitu:Boolean;
var
   auxTotPago:Double;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   auxTotPago := 0.00;
   if (TabTituIDTitu.Value > 0) and (TabTitu.State <> dsInsert) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Text := 'SELECT SUM(VlrPago) AS TotPago FROM arqtitulobai WHERE IDTitu = '+TabTituIDTitu.AsString;
            QueAuxi.Open;
            if QueAuxi.FieldByName('TotPago').AsString.Trim <> '' then
               auxTotPago := QueAuxi.FieldByName('TotPago').AsFloat;
         except
            Result := False;
            Exit;
          end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;// try
   end; //if
   if not (TabTitu.State in dsEditModes) then TabTitu.Edit;
   TabTituSaltit.Value := TabTituVlrtit.Value - auxTotPago - TabTituVlrDevo.Value - TabTituDesAsso.Value + TabTituVlrAces.Value;
   Result := True;
end;

// -------------- Exclusão do Título  ------------ //
procedure TFrmTitCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   btExcluir.SetFocus;
   if (TabTitu.State <> dsInsert) and (TabTituIDTitu.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            if MostraMsg('Confirmação','Confirma exclusão do Título?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            begin
               try
                  QueAuxi.SQL.Text := 'SELECT SUM(VlrPago) AS TotPago FROM arqtitulobai WHERE IDTitu = '+TabTituIDTitu.AsString;
                  QueAuxi.Open;
                  if QueAuxi.FieldByName('TotPago').AsString.Trim <> '' then
                  begin
                     MostraMsg('Aviso','Não será possível excluir, esse título já possui baixas!',mtWarning, [mbOk]);
                     Exit;
                  end;
                  QueAuxi.Close;
                  SQL.Text := 'DELETE FROM arqtitulo WHERE IDTitu = '+   TabTituIDTitu.AsString+'; '+
                              'DELETE FROM arqtitulorat WHERE IDTitu = '+TabTituIDTitu.AsString+';'+
                              'DELETE FROM arqtitulorattemp WHERE IDTitu = '+TabTituIDTitu.AsString+';';
                  ExecSQL;
                  if TabTitu.State in dsEditModes then TabTitu.Cancel;
                  btNovo.Click;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqtitulo, IDTitu = '+TabTituIDTitu.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
            end; // if
         end; // with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;// try
   end else
   begin
      if TabTitu.State in dsEditModes then TabTitu.Cancel;
      btNovo.Click;
   end;
end;

procedure TFrmTitCad.btBuscaClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   FrmBusTit := TFrmBusTit.Create(Application);
   try
      FrmBusTit.ShowModal;
   finally
      if FrmBusTit.retIDTitu > 0 then
      begin
         auxTotRateio := 0.00;
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            QueAuxi.SQL.Text := 'SELECT SUM(ValorRat) AS TotRateio FROM arqtitulorat WHERE IDTitu = '+FrmBusTit.retIDTitu.ToString;
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
               if not QueAuxi.FieldByName('TotRateio').IsNull then
                  auxTotRateio := QueAuxi.FieldByName('TotRateio').AsFloat;
         finally
            QueAuxi.Close;
            FreeANdNil(QueAuxi);
         end;
         recIDTitu := FrmBusTit.retIDTitu;
         AbreSQL;
      end;
      FrmBusTit.Free;
   end;
   AcertaCampos;
end;

procedure TFrmTitCad.LMDDBLabeledEdit10CustomButtons0Click(Sender: TObject; index: Integer);
var
   auxIDTitu,auxRatFixo: Integer;
   QueAuxi,QueGrava,QueParam,QueRate: TRESTDWClientSQL;
begin
   edNatFin.SetFocus;
   if TabTituSaltit.AsFloat <= 0 then
   begin
      MostraMsg('Aviso', 'É necessário informar o valor total do título antes de fazer a divisão!',mtWarning, [mbOk]);
      edValorTit.SetFocus;
      Exit;
   end;// if

   if TabTituIDTitu.AsInteger <= 0 then
      auxIDTitu := 0
   else
   begin
      ShowWait('Aguarde...', Self);
      auxIDTitu := TabTituIDTitu.AsInteger;
      QueAuxi   := TRESTDWClientSQL.Create(nil);
      QueGrava  := TRESTDWClientSQL.Create(nil);
      QueParam  := TRESTDWClientSQL.Create(nil);
      QueRate   := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase  := DM.DWDataBase;
      QueGrava.DataBase := DM.DWDataBase;
      QueParam.DataBase := DM.DWDataBase;
      QueRate.DataBase  := DM.DWDataBase;

      try
         QueRate.Close;
         QueRate.SQL.Text := 'SELECT * FROM arqtituloratTemp WHERE IDTitu = '+TabTituIDTitu.AsString;
         QueRate.Open;
         if QueRate.RecordCount = 0 then
         begin
            QueParam.Close;
            QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+TabTituIDFilial.AsString;
            QueParam.Open;
            QueParam.First;
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT * FROM arqtitulorat WHERE IDTitu = '+TabTituIDTitu.AsString;
            QueAuxi.Open;
            QueAuxi.First;
            while not QueAuxi.Eof do
            begin
               if (QueParam.FieldByName('IDNatFinVlrDevo').AsInteger = QueAuxi.FieldByName('IDNatFin').AsInteger) or
                  (QueParam.FieldByName('IDNatFinDesAce').AsInteger  = QueAuxi.FieldByName('IDNatFin').AsInteger) or
                  (QueParam.FieldByName('IDNatFinDesAsso').AsInteger = QueAuxi.FieldByName('IDNatFin').AsInteger) or
                  (QueParam.FieldByName('IDNatFinVlrJur').AsInteger  = QueAuxi.FieldByName('IDNatFin').AsInteger) or
                  (QueParam.FieldByName('IDNatFinPerJur').AsInteger  = QueAuxi.FieldByName('IDNatFin').AsInteger) or
                  (QueParam.FieldByName('IDNatFinVlrMul').AsInteger  = QueAuxi.FieldByName('IDNatFin').AsInteger) or
                  (QueParam.FieldByName('IDNatFinPerMul').AsInteger  = QueAuxi.FieldByName('IDNatFin').AsInteger) then
                    auxRatFixo := 1
               else auxRatFixo := 0;
               try
                  QueGrava.Close;
                  QueGrava.SQL.Clear;
                  QueGrava.SQL.Text := 'INSERT INTO arqtitulorattemp (IDTitu, IDNatFin, ValorRat, RatFixo) VALUES ('+
                  auxIDTitu.ToString+','+
                  Queauxi.FieldByName('IDNatFin').AsString+','+
                  FormatDouble(Queauxi.FieldByName('ValorRat').AsFloat,11,2)+','+
                  auxRatFixo.ToString+')';
                  QueGrava.ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível incluir rateio na tabela arqtitulorattemp em uTitulosCad -> '+E.Message);
                     MostraMsg('Erro','Não foi possível incluir registro.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end;// try
               QueAuxi.Next;
            end;// while
         end;// if
      finally
         QueAuxi.Close;
         QueGrava.Close;
         QueParam.Close;
         QueRate.Close;
         FreeANdNil(QueAuxi);
         FreeANdNil(QueGrava);
         FreeANdNil(QueParam);
         FreeANdNil(QueRate);
         HideWait;
      end; //try
   end;

   try
      FrmVlrRatTemp             := TFrmVlrRatTemp.Create(Application);
      FrmVlrRatTemp.recIDTitu   := auxIDTitu;
      FrmVlrRatTemp.recSaltit   := TabTituVlrtit.AsFloat;
      FrmVlrRatTemp.recOrigTitu := '0';
      FrmVlrRatTemp.ShowModal;
   finally
      if FrmVlrRatTemp.recIDNatFin > 0 then
      begin
         if not(TabTitu.State in dsEditModes) then TabTitu.Edit;
         TabTituIDNatFin.AsInteger := FrmVlrRatTemp.recIDNatFin;
         TabTituDesnat.AsString    := FrmVlrRatTemp.recDesNatFin;
      end;// if
      FrmVlrRatTemp.Free;
   end;// try
end;

procedure TFrmTitCad.btMultiClick(Sender: TObject);
begin
   FrmMulTit := TFrmMulTit.Create(Application);
   try
      FrmMulTit.ShowModal;
   finally
      FrmMulTit.Free;
   end;
end;

procedure TFrmTitCad.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmTitCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ExcluiRateioTemp;
   if TabTitu.Active then TabTitu.Close;
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;

end.
