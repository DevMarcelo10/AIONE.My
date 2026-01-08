unit uTitulosBai;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, DB,
  LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit,
  LMDCustomEdit, LMDDBEdit, LMDBaseControl, LMDLabel, LMDBaseLabel, LMDCustomLabel,
  LMDSimplePanel, LMDBaseGraphicControl, LMDCustomCheckBox, LMDButtonControl,
  Vcl.StdCtrls, AdvGlowButton,Vcl.Mask, RxDBCtrl, LMDRadioButton, LMDEdit, MarcLib,
  Vcl.ExtCtrls, Vcl.Grids, AdvGrid, DBAdvGrid, RxCurrEdit, LMDCheckBox, RxToolEdit,
  AdvToolBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, ACBrBase,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBGrids, uRESTDWBasicTypes, uRESTDWBasicDB, ACBrPagFor, LMDCustomComponent,
  LMDVistaDialogs, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TFrmTitBai = class(TForm)
    PanelQuitacao: TLMDSimplePanel;
    QueTitu: TRESTDWClientSQL;
    SouQueTitu: TDataSource;
    PanelBaixa: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelTotal: TLMDSimplePanel;
    Label35: TLabel;
    QueTituIDTitu: TFDAutoIncField;
    QueTituIDPess: TIntegerField;
    QueTituIDTiptit: TIntegerField;
    QueTituDatemi: TDateField;
    QueTituDatven: TDateField;
    QueTituDesAsso: TFloatField;
    QueTituVlrAces: TFloatField;
    QueTituVlrDevo: TFloatField;
    QueTituVlrtit: TFloatField;
    QueTituSaltit: TFloatField;
    QueTituIDFilial: TIntegerField;
    QueTituIDPed: TIntegerField;
    QueTituIDNatFin: TIntegerField;
    LMDSimplePanel3: TLMDSimplePanel;
    edTotPer: TCurrencyEdit;
    PanelFiltros: TLMDSimplePanel;
    Label21: TLabel;
    Label22: TLabel;
    Label38: TLabel;
    LMDSimplePanel11: TLMDSimplePanel;
    Label37: TLabel;
    Label39: TLabel;
    RadioPag: TLMDRadioButton;
    RadioRec: TLMDRadioButton;
    edNompes: TLMDLabeledEdit;
    edFilial: TLMDLabeledEdit;
    Label1: TLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btBuscar: TAdvGlowButton;
    edNotFis: TLMDLabeledEdit;
    Label4: TLabel;
    IndBaixados: TLMDCheckBox;
    ACBrPagFor1: TACBrPagFor;
    LMDSimplePanel4: TLMDSimplePanel;
    edTotSel: TCurrencyEdit;
    Label13: TLabel;
    QueTituNrotit: TWideStringField;
    QueTituDestit: TWideStringField;
    QueTituPagRec: TWideStringField;
    QueTituNotFis: TIntegerField;
    QueTituHistit: TWideStringField;
    QueTituCodBarra: TWideStringField;
    QueTituIndSel: TWideStringField;
    QueTituIndEnvBco: TWideStringField;
    QueTituDesnat: TWideStringField;
    QueTituCodconDebPro: TWideStringField;
    QueTituCodconCrePro: TWideStringField;
    QueTituCodconDebBai: TWideStringField;
    QueTituCodconCreBai: TWideStringField;
    QueTituNompes: TWideStringField;
    QueTituCpfCnpjPes: TWideStringField;
    QueTituEndpes: TWideStringField;
    QueTituNroEnd: TWideStringField;
    QueTituCompEnd: TWideStringField;
    QueTituBaipes: TWideStringField;
    QueTituCeppes: TWideStringField;
    QueTituIDPix: TWideStringField;
    QueTituCodban: TIntegerField;
    QueTituAgencia: TWideStringField;
    QueTituNroConta: TWideStringField;
    QueTituNomfil: TWideStringField;
    QueTituNommun: TWideStringField;
    QueTituEstmun: TWideStringField;
    odAbrirArq: TLMDFileOpenDialog;
    QueTituIDConv: TIntegerField;
    QueTituNossoNro: TWideStringField;
    QueTituCodForLan: TIntegerField;
    QueTituCodTipSer: TIntegerField;
    QueTituCodChaPix: TIntegerField;
    QueTituCodRec: TIntegerField;
    QueTituNumReferencia: TWideStringField;
    QueTituDatCompApur: TDateField;
    QueTituValorJuros: TFloatField;
    QueTituValorMulta: TFloatField;
    QueTituPercenJuros: TFloatField;
    QueTituPercenMulta: TFloatField;
    QueTituIDTipCon: TWideStringField;
    QueTituChavePIXQRCode: TWideStringField;
    QueTituAgBenef: TLargeintField;
    QueTituDatpag: TDateField;
    LMDSimplePanel6: TLMDSimplePanel;
    Label16: TLabel;
    ckVencimento: TLMDCheckBox;
    ckPagamento: TLMDCheckBox;
    Label17: TLabel;
    edConv: TLMDLabeledEdit;
    ckEmissao: TLMDCheckBox;
    ckEnvNao: TLMDCheckBox;
    ckEnvSim: TLMDCheckBox;
    QueTituNumEnvBco: TIntegerField;
    Shape1: TShape;
    LMDSimplePanel9: TLMDSimplePanel;
    PanelBotoes: TLMDSimplePanel;
    btRetornoBco: TAdvGlowButton;
    btBaiTudo: TAdvGlowButton;
    btSelecao: TAdvGlowButton;
    btBaixa: TAdvGlowButton;
    btEnviaBco: TAdvGlowButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    Label10: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    LMDDBEdit2: TLMDDBEdit;
    LMDDBEdit4: TLMDDBEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    DatPagAux: TDateEdit;
    VlrDesAux: TCurrencyEdit;
    TotPagAux: TCurrencyEdit;
    VlrJurBanco: TCurrencyEdit;
    Label6: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    Label14: TLabel;
    LMDDBEdit1: TLMDDBEdit;
    VlrJurAux: TCurrencyEdit;
    VlrPagAux: TCurrencyEdit;
    VlrMulBanco: TCurrencyEdit;
    Label12: TLabel;
    Label11: TLabel;
    LMDDBEdit5: TLMDDBEdit;
    edCodcon: TLMDLabeledEdit;
    btDesmarTudo: TAdvGlowButton;
    btSelecTudo: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btBuscarClick(Sender: TObject);
    procedure btBaixaClick(Sender: TObject);
    procedure EfetivaBaixa(TipoBai:String);
    procedure VlrJurAuxExit(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edCodconCustomButtons0Click(Sender: TObject; index: Integer);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edCodconKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QueTituAfterOpen(DataSet: TDataSet);
    procedure btBaiTudoClick(Sender: TObject);
    procedure IndBaixadosChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btEnviaBcoClick(Sender: TObject);
    procedure btRetornoBcoClick(Sender: TObject);
    procedure LMDDBEdit1DataChange(Sender: TObject);
    procedure edConvCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edConvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ckEmissaoClick(Sender: TObject);
    procedure ckVencimentoClick(Sender: TObject);
    procedure ckPagamentoClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ckEnvNaoClick(Sender: TObject);
    procedure ckEnvSimClick(Sender: TObject);
    procedure btSelecTudoClick(Sender: TObject);
    procedure btDesmarTudoClick(Sender: TObject);
  private
    { Private declarations }
    TamPanel:Integer;
    DatIniFil,DatFinFil:TDateTime;
    CodLojGer,CodConDeb,CodConCre:String;
    procedure AjustGrid;
    procedure MostraMulJur;
  public
    { Public declarations }
    BaiConDeb,BaiConCre:String;
  end;

var
  FrmTitBai: TFrmTitBai;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uTituloEst, ACBrPagForConversao, uRetTitBco;

procedure TFrmTitBai.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTitBai.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmTitBai.FormShow(Sender: TObject);
begin
   edDataIni.Date := Date;
   edDataFin.Date := IncMonth(Date);
   AjustGrid;
   edNompes.SetFocus;
end;

procedure TFrmTitBai.IndBaixadosChange(Sender: TObject);
begin
   if IndBaixados.Checked then
   begin
      TamPanel := PanelBaixa.Height;
      Self.Height := Self.Height - PanelBaixa.Height;
      PanelBaixa.Visible := False;
   end
   else
   begin
      Self.Height := Self.Height + TamPanel;
      PanelBaixa.Visible := True;
   end;
end;

procedure TFrmTitBai.QueTituAfterOpen(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmTitBai.btBuscarClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   Datas:String;
begin
   _CodConta := '';
   _IDConta  := -1;
   edCodcon.Tag := 0;
   edCodcon.Clear;
   DatPagAux.Date := Date;
   if edDataIni.Date > 0 then DatIniFil := edDataIni.Date else DatIniFil := 0;
   if edDataFin.Date > 0 then DatFinFil := edDataFin.Date else DatFinFil := StrToDate('01/01/2200');
   Screen.Cursor := crHourGlass;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text := 'UPDATE arqtitulo SET IndSel = '+Aspas('0')+
         ' WHERE Datven BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',DatIniFil))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',DatFinFil))+
         ' AND PagRec = '+Aspas(iif(RadioPag.Checked,'P','R'))+
         ' AND Saltit '  +iif(not IndBaixados.Checked, '> 0.00','<= 0.00');
         if edNompes.Tag > 0 then QueAuxi.SQL.Add(' AND IDPess = '+  edNompes.Tag.ToString);
         if edFilial.Tag > 0 then QueAuxi.SQL.Add(' AND IDFilial = '+edFilial.Tag.ToString);
         if edNotFis.Text.Trim <> '' then QueAuxi.SQL.Add(' AND NotFis = '+Aspas(edNotFis.Text.Trim));
         QueAuxi.ExecSQL;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível selecionar títulos (uTitulosBai) -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível selecionar títulos!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end; //try

      with QueTitu do
      begin  // Faz o where de acordo com a data que foi escolhida
         if ckEmissao.Checked then
            Datas := 'WHERE DatEmi BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',DatIniFil))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',DatFinFil))
         else
         if ckVencimento.Checked then
            Datas := 'WHERE Datven BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',DatIniFil))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',DatFinFil))
         else
         if ckPagamento.Checked then
            Datas := 'WHERE BAI.Datpag BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',DatIniFil))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',DatFinFil));

         DisableControls;
         QueTitu.Close;
         SQL.Clear;
         if edConv.Tag <> 0 then
         begin
            QueTitu.SQL.Text :=
            'SELECT TIT.*,NAT.Desnat,NAT.CodconDebPro,NAT.CodconCrePro,NAT.CodconDebBai,NAT.CodconCreBai,PES.Nompes,PES.CpfCnpjPes,'+
            'PES.Endpes,PES.NroEnd,PES.CompEnd,PES.Baipes,PES.Ceppes,BAN.IDPix,BAN.Codban,BAN.Agencia,BAN.NroConta,BAN.CodChaPix,CON.IDConv,CON.Nomcon,BAT.IDTipCon,'+
            'FIL.Nomfil,MUN.Nommun,MUN.Estmun,TIP.CodForLan,TIP.CodTipSer,BAI.Datpag FROM arqtitulo TIT '+
            'LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '+
            'LEFT JOIN arqpessbanc BAN ON BAN.IDPess = PES.IDPess '+
            'LEFT JOIN arqpessconv PCON ON PCON.IDPess = PES.IDPess '+
            'LEFT JOIN arqconvenio CON ON CON.IDConv = PCON.IDConv '+
            'LEFT JOIN arqbancotip BAT ON BAT.IDTipCon = BAN.IDTipCon ' +
            'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
            'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '+
            'LEFT JOIN arqnatfin NAT ON TIT.IDNatfin = NAT.IDNatfin '+
            'LEFT JOIN arqtiptitu TIP ON TIT.IDTiptit = TIP.IDTiptit '+
            'LEFT JOIN arqtitulobai BAI on TIT.IDTitu = BAI.IDTitu '+
            Datas+
            ' AND TIT.PagRec = '+Aspas(iif(RadioPag.Checked,'P','R'))+
            ' AND TIT.Saltit '  +iif(not IndBaixados.Checked, '> 0.00','<= 0.00')+
            ' AND CON.IDConv = '+edConv.Tag.ToString;
            if ckEnvSim.Checked then SQL.Add(' AND TIT.IndEnvBco = S');
            if ckEnvNao.Checked then SQL.Add(' AND TIT.IndEnvBco = N');
            if edNompes.Tag > 0 then SQL.Add(' AND TIT.IDPess = '+  edNompes.Tag.ToString);
            if edFilial.Tag > 0 then SQL.Add(' AND TIT.IDFilial = '+edFilial.Tag.ToString);

            if edNotFis.Text.Trim <> '' then SQL.Add(' AND TIT.NotFis = '+Aspas(edNotFis.Text.Trim));
            if ckEmissao.Checked then
               SQL.Add(' ORDER BY TIT.IDPess,TIT.DatEmi')
            else
            if ckVencimento.Checked then
               SQL.Add(' ORDER BY TIT.IDPess,TIT.Datven')
            else
            if ckPagamento.Checked then
               SQL.Add(' ORDER BY TIT.IDPess,BAI.Datpag');
         end
         else
         begin
            QueTitu.SQL.Text :=
            'SELECT TIT.*,NAT.Desnat,NAT.CodconDebPro,NAT.CodconCrePro,NAT.CodconDebBai,NAT.CodconCreBai,PES.Nompes,PES.CpfCnpjPes,'+
            'PES.Endpes,PES.NroEnd,PES.CompEnd,PES.Baipes,PES.Ceppes,BAN.IDPix,BAN.Codban,BAN.Agencia,BAN.NroConta,BAN.CodChaPix,BAT.IDTipCon,'+
            'FIL.Nomfil,MUN.Nommun,MUN.Estmun,TIP.CodForLan,TIP.CodTipSer,BAI.Datpag FROM arqtitulo TIT '+
            'LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '+
            'LEFT JOIN arqpessbanc BAN ON BAN.IDPess = PES.IDPess '+
            'LEFT JOIN arqbancotip BAT ON BAT.IDTipCon = BAN.IDTipCon ' +
            'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
            'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '+
            'LEFT JOIN arqnatfin NAT ON TIT.IDNatfin = NAT.IDNatfin '+
            'LEFT JOIN arqtiptitu TIP ON TIT.IDTiptit = TIP.IDTiptit '+
            'LEFT JOIN arqtitulobai BAI on TIT.IDTitu = BAI.IDTitu '+
            Datas+
            ' AND TIT.PagRec = '+Aspas(iif(RadioPag.Checked,'P','R'))+
            ' AND TIT.Saltit '  +iif(not IndBaixados.Checked, '> 0.00','<= 0.00');
            if ckEnvSim.Checked then SQL.Add(' AND TIT.IndEnvBco = '+Aspas('S'));
            if ckEnvNao.Checked then SQL.Add(' AND TIT.IndEnvBco = '+Aspas('N'));
            if edNompes.Tag > 0 then SQL.Add(' AND TIT.IDPess = '+  edNompes.Tag.ToString);
            if edFilial.Tag > 0 then SQL.Add(' AND TIT.IDFilial = '+edFilial.Tag.ToString);
            if edNotFis.Text.Trim <> '' then SQL.Add(' AND TIT.NotFis = '+Aspas(edNotFis.Text.Trim));
            if ckEmissao.Checked then
               SQL.Add(' ORDER BY TIT.IDPess,TIT.DatEmi')
            else
            if ckVencimento.Checked then
               SQL.Add(' ORDER BY TIT.IDPess,TIT.Datven')
            else
            if ckPagamento.Checked then
               SQL.Add(' ORDER BY TIT.IDPess,BAI.Datpag');

         end;
         QueTitu.Open;
         First;
         edTotPer.Value := 0.00;
         while not Eof do
         begin
            if not IndBaixados.Checked then
                 edTotPer.Value := edTotPer.Value + FieldByName('Saltit').AsFloat
            else edTotPer.Value := edTotPer.Value + FieldByName('Vlrtit').AsFloat;
            Next;
         end;
         First;
      end;// with
   finally
      FreeAndNil(QueAuxi);
      QueTitu.EnableControls;
      QueTituAfterOpen(QueTitu);
      Screen.Cursor := crDefault;
      AjustGrid;
   end;
end;

procedure TFrmTitBai.btDesmarTudoClick(Sender: TObject);
begin
   if QueTitu.IsEmpty then exit;
   QueTitu.First;
   while not QueTitu.Eof do
   begin
      QueTitu.Edit;
      QueTituIndSel.AsString := '0';
      QueTitu.Post;
      QueTitu.Next;
   end;
   edTotSel.Value  := 0;
   VlrPagAux.Value := 0;
end;

// ------- Processo de Geração dos Dados P/ Envio ao Banco (Contas à Pagar) -------- //
procedure TFrmTitBai.btEnviaBcoClick(Sender: TObject);
var
   TotalLote,ValorMulta,ValorJuros: Double;
   NomeArquivo,SeqArq,CodBarra,TipoChavePIX,AuxBanco: String;
   AuxCodForLan,AuxCodTipSer:String;
   CodBanco,NroSeqEnv,Codban,CodSeqArq,retID,Dias,Tam,i,AuxEnvBco: Integer;
   QueBanco,QueFilial,QueFornec,QueAuxi: TRESTDWClientSQL;
   Ok: Boolean;
begin
   NomeArquivo := PathExe+'PagamentoBanco\';
   if not DirectoryExists(NomeArquivo) then CreateDir(NomeArquivo);

   if QueTitu.IsEmpty then
   begin
      MostraMsg('Aviso','Não há títulos à enviar!',mtWarning, [mbOk]);
      Exit;
   end; //if

   if MostraMsg('Confirmação','Confirma geração do envio ao banco dos títulos selecionados?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;

   if not Ping(IPRemoto,PortaRemoto) then
   begin
      SalvaLog(USUARIO, PastaLog, 'btEnviaBcoClick -> Perda de conexão com o servidor');
      MostraMsg('Erro','Perda de conexão com o servidor!',mtError, [mbOk]);
      DatPagAux.SetFocus;
      Exit;
   end; //if

   if _IDConta <= 0 then
   begin
      MostraMsg('Aviso','Não é possível enviar sem escolher um banco destino válido!',mtWarning, [mbOk]);
      edCodcon.SetFocus;
      Exit;
   end; //if

   QueFilial := TRESTDWClientSQL.Create(nil);
   QueBanco  := TRESTDWClientSQL.Create(nil);
   QueFornec := TRESTDWClientSQL.Create(nil);
   QueAuxi   := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase   := DM.DWDataBase;
      QueBanco.DataBase  := DM.DWDataBase;
      QueFilial.DataBase := DM.DWDataBase;

      try
         QueFilial.SQL.Text := 'SELECT FIL.*,MUN.Nommun,MUN.Estmun FROM arqfilial FIL '+
                               'LEFT JOIN arqmuni MUN ON FIL.Codmun = MUN.Codmun WHERE FIL.IDFilial = '+IDUSU.ToString;
         QueFilial.Open;
         if QueFilial.IsEmpty then
         begin
            MostraMsg('Aviso','Não foi encontrado uma empresa filial/matriz pra configurar!',mtWarning, [mbOk]);
            edCodcon.SetFocus;
            Exit;
         end;
         QueBanco.SQL.Text := 'SELECT * FROM arqbanco WHERE IDCon = '+_IDConta.ToString + ' AND IDFilial = ' + QueFilial.FieldByName('IDFilial').AsString;
         QueBanco.Open;
         if QueBanco.IsEmpty then
         begin
            MostraMsg('Aviso','Não foi encontrado um banco destino relacionado!',mtWarning, [mbOk]);
            edCodcon.SetFocus;
            Exit;
         end;
         Codban := QueBanco.FieldByName('Codban').AsInteger;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível selecionar banco para envio (uTitulosBai.btEnviaBcoClick) -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível selecionar banco para envio!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end; //try

      with QueTitu do
      begin
         Filter   := 'IndEnvBco = '+Aspas('N')+' AND IndSel = '+Aspas('1');
         Filtered := True;
         First;
         if IsEmpty then
         begin
            MostraMsg('Aviso','Não há títulos selecionados à enviar!',mtWarning, [mbOk]);
            edTotSel.Value  := 0;
            VlrPagAux.Value := 0;
            QueTitu.Filtered := False;
            QueTitu.Close;
            QueTitu.Open;
            Exit;
         end; // if IsEmpty

         ACBrPagFor1.Arquivos.Clear;

         with ACBrPagFor1 do
         begin
            with Arquivos.New.PagFor do
            begin
               // Geral //
               // Usado pela caixa (T=Teste; P=Produção)
               Geral.AmbienteCliente := 'T';

               Configuracoes.Geral.Banco := StrToBanco(Ok, IntToStr(QueBanco.FieldByName('Codban').AsInteger));
               geral.Banco := Configuracoes.Geral.Banco;
               // Registro 0 //
               Registro0.Empresa.Inscricao.Tipo   := tiCNPJ;
               Registro0.Empresa.Inscricao.Numero := QueFilial.FieldByName('CNPJFil').AsString;
               Registro0.Empresa.Convenio                      := QueBanco.FieldByName('Convenio').AsString;
               Registro0.Empresa.ContaCorrente.Agencia.Codigo  := StrToInt(QueBanco.FieldByName('AgeBco').AsString);
               Registro0.Empresa.ContaCorrente.Agencia.DV      := QueBanco.FieldByName('DigAgeBco').AsString;
               Registro0.Empresa.ContaCorrente.Conta.Numero    := StrToInt(QueBanco.FieldByName('ContaBco').AsString);
               Registro0.Empresa.ContaCorrente.Conta.DV        := QueBanco.FieldByName('DigitoBco').AsString;
               Registro0.Empresa.ContaCorrente.DV              := ' ';
               Registro0.Empresa.ContaCorrente.Conta.TipoConta := 1;
               Registro0.Empresa.Nome        := QueFilial.FieldByName('Nomfil').AsString;
               Registro0.NomeBanco           := QueBanco.FieldByName('Nomban').AsString;
               Registro0.Arquivo.Codigo      := taRemessa;
               Registro0.Arquivo.DataGeracao := StrToDate(FormatDateTime('dd/MM/yyyy', Date));
               Registro0.Arquivo.HoraGeracao := StrToTime(FormatDateTime('hh:mm:ss', Time));
               Registro0.Arquivo.Sequencia   := QueBanco.FieldByName('NroSeqEnv').AsInteger;
               Registro0.Arquivo.Densidade   := 01600;

               // Usado pela Caixa (Parâmetro de Transmissão) Código Informado pelo Banco
               Registro0.Arquivo.ParamTransm := '00';

               Registro0.ReservadoBanco      := '';
               Registro0.ReservadoEmpresa    := '';

               // Usado pelo Banco do Brasil (True = Teste, False = Produção)
               Registro0.RemessaTeste := True;

               while not Eof do
               begin
                  if Length(IntToStr(QueTituCodTipSer.AsInteger)) = 1 then
                     AuxCodTipSer := '0' + IntToStr(QueTituCodTipSer.AsInteger)
                  else if Length(IntToStr(QueTituCodTipSer.AsInteger)) = 2 then
                     AuxCodTipSer := IntToStr(QueTituCodTipSer.AsInteger);

                  if Length(IntToStr(QueTituCodForLan.AsInteger)) = 1 then
                     AuxCodForLan := '0' + IntToStr(QueTituCodForLan.AsInteger)
                  else if Length(IntToStr(QueTituCodForLan.AsInteger)) = 2 then
                     AuxCodForLan := IntToStr(QueTituCodForLan.AsInteger);

                   // Crédito em conta corrente, Ordem pagamento, Pagamento via TED  PIX normal  //
                  if QueTituCodTipSer.AsInteger = 20 then
                  begin
                     with Lote.New do
                     begin
                        /// Registro 1 ///
                        TotalLote := 0.0;
                        Registro1.Servico.Operacao         := toCredito;
                        Registro1.Servico.TipoServico      := StrToTpServico(Ok, AuxCodTipSer);
                        Registro1.Servico.FormaLancamento  := StrToFmLancamento(Ok, AuxCodForLan);
                        Registro1.Empresa.Inscricao.Tipo   := tiCNPJ;
                        Registro1.Empresa.Inscricao.Numero := QueFilial.FieldByName('CNPJFil').AsString;
                        Registro1.Empresa.Convenio                      := QueBanco.FieldByName('Convenio').AsString;
                        Registro1.Empresa.ContaCorrente.Agencia.Codigo  := StrToInt(QueBanco.FieldByName('AgeBco').AsString);
                        Registro1.Empresa.ContaCorrente.Agencia.DV      := QueBanco.FieldByName('DigAgeBco').AsString;
                        Registro1.Empresa.ContaCorrente.Conta.Numero    := StrToInt(QueBanco.FieldByName('ContaBco').AsString);
                        Registro1.Empresa.ContaCorrente.Conta.DV        := QueBanco.FieldByName('DigitoBco').AsString;
                        Registro1.Empresa.ContaCorrente.DV              := ' ';
                        Registro1.Empresa.ContaCorrente.Conta.TipoConta := 1;
                        Registro1.Empresa.Nome         := QueFilial.FieldByName('Nomfil').AsString;
                        Registro1.Informacao1          := '';
                        Registro1.Endereco.Logradouro  := QueFilial.FieldByName('Endfil').AsString;
                        Registro1.Endereco.Numero      := QueFilial.FieldByName('NroEnd').AsString;
                        Registro1.Endereco.Complemento := QueFilial.FieldByName('CompEnd').AsString;
                        Registro1.Endereco.Cidade      := QueFilial.FieldByName('Nommun').AsString;
                        Registro1.Endereco.CEP         := StrToInt(QueFilial.FieldByName('CEPFil').AsString);
                        Registro1.Endereco.Estado      := QueFilial.FieldByName('Estmun').AsString;
                        if QueTituCodForLan.Value = 41 then // Se for TED
                        begin
                           Registro1.IndFormaPag       := ifpDebitoContaCorrente;
                           // Usado pela Caixa
                           Registro1.TipoCompromisso   := 1;
                           Registro1.CodigoCompromisso := 1;
                        end;

                        // Segmento A //
                        with SegmentoA.New do
                        begin
                           CodMovimento  := imInclusaoRegistroDetalheLiberado;
                           TipoMovimento := tmInclusao;

                           with Favorecido do
                           begin
                              // “018” para “TED” (Valor igual ou superior a R$ 0,01);
                              // “700” para “DOC Eletrônico” (Valor inferior a R$ 5.000,00); ou
                              // “888” para “TED” (Qualquer valor) quando for necessário o envio
                              // de TED utilizando o código ISPB.
                              if QueTituCodForLan.AsInteger = 41 then // Se for TED
                                 Camara := 018
                              else if QueTituCodForLan.AsInteger = 45 then  // Se for PIX
                                 Camara := 009
                              else  // Se for CREDITO CONTA CORRENTE OU ORDEM PAGAMENTO
                                 Camara := 000;

                              AuxBanco := IntToStr(QueTituCodban.AsInteger);
                              if Length(AuxBanco) < 3 then
                              begin
                                 if Length(AuxBanco) = 1 then
                                    AuxBanco := '00'+AuxBanco
                                 else if Length(AuxBanco) = 2 then
                                    AuxBanco := '0'+AuxBanco;
                              end;

                              Banco  := StrToBanco(Ok, AuxBanco);
                              ContaCorrente.Agencia.Codigo  := StrToInt(QueTituAgencia.AsString);
                              ContaCorrente.Agencia.DV      := '';
                              ContaCorrente.Conta.TipoConta := 1;
                              ContaCorrente.Conta.Numero    := StrToInt(Copy(QueTituNroConta.AsString, 1, Length(QueTituNroConta.AsString)-1));
                              ContaCorrente.Conta.DV        := Copy(QueTituNroConta.AsString, Length(QueTituNroConta.AsString), 1);
                              Nome                          := QueTituNompes.AsString;
                           end; // with Favorecido

                           with Credito do
                           begin
                              SeuNumero      := QueTituNrotit.AsString;
                              DataPagamento  := StrToDate(FormatDateTime('dd/MM/yyyy', Now()));
                              Moeda.Tipo     := tmReal;
                              Moeda.Qtde     := 0.0;
                              ValorPagamento := QueTituSaltit.AsFloat;
                              NossoNumero    := '';
                              DataReal       := StrToDate(FormatDateTime('dd/MM/yyyy', Now()));
                              ValorReal      := 0;
                           end; // with Credito
                           if QueTituCodForLan.AsInteger = 45 then  // Se for PIX
                           begin
                              // Formatação para identificação Pagamento via PIX
                              // CCCCCCCCCCCCCCIIIIIIIIRR, onde:
                              // C = Número de inscrição CNPJ (14 dígitos) ou Número do CPF (11 digitos com 0 a esq)
                              // I = Código do ISPB (8 dígitos)
                              // R = Tipo de Conta  (2 dígitos = 01 – Conta corrente)
                              Informacao2 := QueFilial.FieldByName('CNPJFil').AsString + BancoToIspb(TBanco(QueBanco.FieldByName('Codban').AsInteger)) + '01';
                           end
                           else Informacao2 := '';

                           CodigoDOC := '';
                           if QueTituCodForLan.AsInteger = 41 then // Se for TED
                           begin
                              CodigoTED  := '00005'; // Pagamento à fornecedores
                              CodigoComp := 'CC';    // “CC” quando for Conta Corrente ou “PP” quando for Conta Poupança
                           end else
                           begin
                              CodigoTED  := '';
                              CodigoComp := '';
                           end;
                           Aviso := 0;

                           TotalLote := TotalLote + Credito.ValorPagamento;

                           /// Segmento B ///
                           with SegmentoB.New do
                           begin
                              with Inscricao do
                              begin
                                 if Length(QueTituCpfCnpjPes.AsString) = 11 then
                                      Tipo := tiCPF
                                 else Tipo := tiCNPJ;
                                 Numero := QueTituCpfCnpjPes.AsString;
                              end;
                              if QueTituCodForLan.AsInteger = 45 then // Se for PIX
                              begin
                                 if length(IntToStr(QueTituCodChaPix.AsInteger)) = 1 then
                                    TipoChavePIX := '0'+ IntToStr(QueTituCodChaPix.AsInteger);
                                 PixTipoChave := StrToTipoChavePIX(ok, TipoChavePIX);
                                 PixMensagem  := '';
                                 PixTXID      := '';
                                 PixChave     := QueTituIDPix.AsString;
                              end else
                              begin
                                 with Endereco do
                                 begin
                                    Logradouro  := QueTituEndpes.AsString;
                                    Numero      := QueTituNroEnd.AsString;
                                    Complemento := QueTituCompEnd.AsString;
                                    Bairro      := QueTituBaipes.AsString;
                                    Cidade      := QueTituNommun.AsString;
                                    CEP         := QueTituCeppes.AsInteger;
                                    Estado      := QueTituEstmun.AsString;
                                 end; // with Endereco

                                 DataVencimento := StrToDate(FormatDateTime('dd/MM/yyyy', QueTituDatven.AsDateTime));
                                 Valor          := QueTituSaltit.AsFloat;
                                 Abatimento     := 0.00;
                                 Desconto       := 0.00;
                                 Mora           := 0.00;
                                 Multa          := 0.00;
                                 CodigoDoc      := '';
                                 Aviso          := 0;
                                 CodigoUG       := 0;
                              end; //  if
                           end; // with
                        end; // with

                        // Registro 5 //
                        Registro5.Valor          := TotalLote;
                        Registro5.QtdeMoeda      := 0.0;
                        Registro5.NumAvisoDebito := 0;
                     end; //with
                  end; //if

                  // Pagamento títulos de próprio banco | Pagamento tìtulos de outros bancos | Pagamento via PIX QR CODE //
                  if QueTituCodTipSer.AsInteger = 3 then
                  begin
                     // Aqui é Titulos de Outros Bancos BOLETOS
                     with Lote.New do
                     begin
                        // Registro 1 //
                        TotalLote := 0.0;
                        Registro1.Servico.Operacao         := toCredito;
                        Registro1.Servico.TipoServico      := StrToTpServico(Ok, AuxCodTipSer);
                        Registro1.Servico.FormaLancamento  := StrToFmLancamento(Ok, AuxCodForLan);
                        Registro1.Empresa.Inscricao.Tipo   := tiCNPJ;
                        Registro1.Empresa.Inscricao.Numero := QueFilial.FieldByName('CNPJFil').AsString;
                        Registro1.Empresa.Convenio                      := QueBanco.FieldByName('Convenio').AsString;
                        Registro1.Empresa.ContaCorrente.Agencia.Codigo  := StrToInt(QueBanco.FieldByName('AgeBco').AsString);
                        Registro1.Empresa.ContaCorrente.Agencia.DV      := QueBanco.FieldByName('DigAgeBco').AsString;
                        Registro1.Empresa.ContaCorrente.Conta.Numero    := StrToInt(QueBanco.FieldByName('ContaBco').AsString);
                        Registro1.Empresa.ContaCorrente.Conta.DV        := QueBanco.FieldByName('DigitoBco').AsString;
                        Registro1.Empresa.ContaCorrente.DV              := ' ';
                        Registro1.Empresa.ContaCorrente.Conta.TipoConta := 1;
                        Registro1.Empresa.Nome         := QueFilial.FieldByName('Nomfil').AsString;
                        Registro1.Informacao1          := '';
                        Registro1.Endereco.Logradouro  := QueFilial.FieldByName('Endfil').AsString;
                        Registro1.Endereco.Numero      := QueFilial.FieldByName('NroEnd').AsString;
                        Registro1.Endereco.Complemento := QueFilial.FieldByName('CompEnd').AsString;
                        Registro1.Endereco.Cidade      := QueFilial.FieldByName('Nommun').AsString;
                        Registro1.Endereco.CEP         := StrToInt(QueFilial.FieldByName('CEPFil').AsString);
                        Registro1.Endereco.Estado      := QueFilial.FieldByName('Estmun').AsString;

                        /// Adequação do código de barras para o formato de 44 dígitos caso este tenha 47 dígitos ///
                        if Length(QueTituCodBarra.AsString) = 47 then
                        begin
                           CodBarra := Copy(QueTituCodBarra.AsString,1,4);
                           CodBarra := CodBarra + Copy(QueTituCodBarra.AsString,33,15);
                           CodBarra := CodBarra + Copy(QueTituCodBarra.AsString,5,5);
                           CodBarra := CodBarra + Copy(QueTituCodBarra.AsString,11,10);
                           CodBarra := CodBarra + Copy(QueTituCodBarra.AsString,22,10);
                        end; //if
                        if Length(QueTituCodBarra.AsString) = 44 then
                           CodBarra := QueTituCodBarra.AsString;

                        // Segmento J //
                        with SegmentoJ.New do
                        begin
                           TipoMovimento    := tmInclusao;
                           CodMovimento     := imInclusaoRegistroDetalheLiberado;
                           if QueTituCodForLan.AsInteger = 47 then // 47 igual pix QR CODE
                                CodigoBarras := ' '
                           else CodigoBarras := CodBarra;
                           NomeCedente      := QueTituNompes.AsString;
                           DataVencimento   := StrToDate(FormatDateTime('dd/MM/yyyy', QueTituDatven.AsDateTime));
                           ValorTitulo      := QueTituVlrtit.AsFloat;
                           Desconto         := QueTituDesAsso.AsFloat;
                           Acrescimo        := QueTituVlrAces.AsFloat;
                           DataPagamento    := StrToDate(FormatDateTime('dd/MM/yyyy', Now()));
                           ValorPagamento   := QueTituSaltit.AsFloat;
                           QtdeMoeda        := 0.0;
                           ReferenciaSacado := '';
                           CodigoMoeda      := 09;

                           // Usado pela Caixa
                           SeuNumero   := QueTituNossoNro.AsString;
                           NossoNumero := '';

                           /// Segmento J52 ///
                           with SegmentoJ52.New do
                           begin
                              TipoMovimento := tmInclusao;
                              CodMovimento  := imInclusaoRegistroDetalheLiberado;

                              with Pagador do
                              begin
                                with Inscricao do
                                begin
                                   Tipo   := tiCNPJ;
                                   Numero := QueFilial.FieldByName('CNPJFil').AsString;
                                end;
                                Nome := QueFilial.FieldByName('Nomfil').AsString;
                              end; // with

                              with Beneficiario do
                              begin
                                with Inscricao do
                                begin
                                  if Length(QueTituCpfCnpjPes.AsString) = 11 then
                                       Tipo   := tiCPF
                                  else Tipo   := tiCNPJ;
                                  Numero := QueTituCpfCnpjPes.AsString;
                                end;

                                Nome := QueTituNompes.AsString;
                              end; // with Beneficiario

                              if QueTituCodForLan.AsInteger = 47 then // 47 igual pix QR CODE - Pega a chave e o TX ID
                              begin
                                 if Length(QueTituChavePIXQRCode.Text) > 0 then
                                 begin
                                    if Copy(QueTituChavePIXQRCode.Text,6,2) <> '12' then
                                    begin
                                       if Copy(QueTituChavePIXQRCode.Text,11,2) <> '12' then
                                       begin
                                          MostraMsg('Aviso','Este Pix não é um PIX QR Code dinamico ou copia e cola!',mtWarning, [mbOk]);
                                          Exit;
                                       end;
                                    end;
                                    Inc(i, 13);
                                    while i < (Length(QueTituChavePIXQRCode.Text) -1) do
                                    begin
                                       if Copy(QueTituChavePIXQRCode.Text,i,1) = 'b' then
                                       begin
                                          if Copy(QueTituChavePIXQRCode.Text,i,14) = 'br.gov.bcb.pix' then
                                          begin
                                             Inc(i,16);
                                             Tam := StrToInt(Copy(QueTituChavePIXQRCode.Text,i,2));
                                             Inc(i,2);
                                             Chave := Copy(QueTituChavePIXQRCode.Text,i,Tam); // Chave do pix QR Code
                                             Inc(i,Tam -1);
                                          end; // if
                                       end; // if
                                       if Copy(QueTituChavePIXQRCode.Text,i,1) = '6' then
                                       begin
                                          if Copy(QueTituChavePIXQRCode.Text,i,2) = '62' then
                                          begin
                                             Inc(i,4);
                                             if Copy(QueTituChavePIXQRCode.Text,i,2) = '05' then
                                             begin
                                                Inc(i,2);
                                                Tam := StrToInt(Copy(QueTituChavePIXQRCode.Text,i,2));
                                                Inc(i,2);
                                                TXID := Copy(QueTituChavePIXQRCode.Text,i,Tam); // TX Id
                                                Break;
                                             end; // if
                                          end; // if
                                       end; // if
                                       Inc(i,1);
                                    end; // while
                                 end; // if
                              end else
                              begin
                                 with SacadorAvalista do
                                 begin
                                    with Inscricao do
                                    begin
                                       Tipo   := tiIsento;
                                       Numero := '00000000000000';
                                    end;
                                    Nome := '';
                                 end; //
                              end; // else
                           end; // with

                           TotalLote := TotalLote + ValorPagamento;
                        end; // with

                        /// Registro 5 ///
                        Registro5.Valor          := TotalLote;
                        Registro5.QtdeMoeda      := 0.0;
                        Registro5.NumAvisoDebito := 0;
                     end; //
                  end; // if

                  // Pagamento de contas - TRIBUTOS E CONSUMO
                  if QueTituCodTipSer.AsInteger = 22 then
                  begin
                     with Lote.New do
                     begin
                        // Registro 1 ///
                        TotalLote := 0.0;
                        Registro1.Servico.Operacao         := toCredito;
                        Registro1.Servico.TipoServico      := StrToTpServico(Ok, AuxCodTipSer);
                        Registro1.Servico.FormaLancamento  := StrToFmLancamento(Ok, AuxCodForLan);
                        Registro1.Empresa.Inscricao.Tipo   := tiCNPJ;
                        Registro1.Empresa.Inscricao.Numero := QueFilial.FieldByName('CNPJFil').AsString;
                        Registro1.Empresa.Convenio                      := QueBanco.FieldByName('Convenio').AsString;
                        Registro1.Empresa.ContaCorrente.Agencia.Codigo  := StrToInt(QueBanco.FieldByName('AgeBco').AsString);
                        Registro1.Empresa.ContaCorrente.Agencia.DV      := QueBanco.FieldByName('DigAgeBco').AsString;
                        Registro1.Empresa.ContaCorrente.Conta.Numero    := StrToInt(QueBanco.FieldByName('ContaBco').AsString);
                        Registro1.Empresa.ContaCorrente.Conta.DV        := QueBanco.FieldByName('DigitoBco').AsString;
                        Registro1.Empresa.ContaCorrente.DV              := ' ';
                        Registro1.Empresa.ContaCorrente.Conta.TipoConta := 1;
                        Registro1.Empresa.Nome         := QueFilial.FieldByName('Nomfil').AsString;
                        Registro1.Informacao1          := '';
                        Registro1.Endereco.Logradouro  := QueFilial.FieldByName('Endfil').AsString;
                        Registro1.Endereco.Numero      := QueFilial.FieldByName('NroEnd').AsString;
                        Registro1.Endereco.Complemento := QueFilial.FieldByName('CompEnd').AsString;
                        Registro1.Endereco.Cidade      := QueFilial.FieldByName('Nommun').AsString;
                        Registro1.Endereco.CEP         := StrToInt(QueFilial.FieldByName('CEPFil').AsString);
                        Registro1.Endereco.Estado      := QueFilial.FieldByName('Estmun').AsString;

                        if QueTituCodForLan.AsInteger = 11 then // Se for boleto de tributos, impostos com código de barras
                        begin
                           /// Adequação do código de barras para o formato de 44 dígitos caso este tenha 48 dígitos ///
                           if Length(QueTituCodBarra.AsString) = 48 then
                           begin
                              // '83620000002 1 63060086326 4 03521299609 0 10029465189 6'
                              // '83620000002  63060086326  03521299609  10029465189'
                              CodBarra := Copy(QueTituCodBarra.AsString,1,11);
                              CodBarra := CodBarra + Copy(QueTituCodBarra.AsString,13,11);
                              CodBarra := CodBarra + Copy(QueTituCodBarra.AsString,25,11);
                              CodBarra := CodBarra + Copy(QueTituCodBarra.AsString,37,11);
                           end; // if Length(QueTituCodBarra.AsString) = 48

                           if Length(QueTituCodBarra.AsString) = 44 then
                              CodBarra := QueTituCodBarra.AsString;

                           /// Segmento O ///
                           with SegmentoO.New do
                           begin
                             TipoMovimento      := tmInclusao;
                             CodMovimento       := imInclusaoRegistroDetalheLiberado;
                             CodigoBarras       := CodBarra;
                             NomeConcessionaria := QueTituNompes.AsString;
                             DataVencimento     := StrToDate(FormatDateTime('dd/MM/yyyy', QueTituDatven.Value));
                             DataPagamento      := StrToDate(FormatDateTime('dd/MM/yyyy', Now()));
                             ValorPagamento     := QueTituSaltit.Value;
                             SeuNumero          := QueTituNrotit.AsString;
                             NossoNumero        := '';
                             TotalLote := TotalLote + ValorPagamento;
                           end; //
                        end else
                        begin
                           if QueTituCodForLan.AsInteger = 17 then // Se for GPS (guia previdência social)
                           begin
                              with SegmentoN1.New do
                              begin
                                 Receita              := QueTituCodRec.AsInteger;
                                 TipoContribuinte     := tiCNPJ;
                                 idContribuinte       := QueFilial.FieldByName('CNPJFil').AsString;
                                 Competencia          := StrToInt(FormatDateTime('MM/yyyy', QueTituDatven.Value)); // Ver este
                                 ValorTributo         := QueTituSaltit.Value;
                                 ValorOutrasEntidades := 0;
                                 AtualizacaoMonetaria := 0;
                              end; // with
                           end; // if
                           if QueTituCodForLan.AsInteger = 16 then // Se for DARF normal
                           begin
                              ValorMulta := 0;
                              // Calculo da multa
                              if QueTituValorMulta.AsFloat > 0 then
                                 ValorMulta := QueTituValorMulta.AsFloat
                              else if QueTituPercenMulta.AsFloat > 0 then
                                 ValorMulta := (QueTituPercenMulta.AsFloat * QueTituVlrtit.Value) /100;

                              ValorJuros := 0;
                              // Calculo dos juros
                              if QueTituValorJuros.AsFloat > 0 then
                                 ValorJuros := QueTituValorJuros.AsFloat
                              else if QueTituPercenJuros.AsFloat > 0 then
                              begin
                                 Dias := Trunc(Now() - QueTituDatven.AsDateTime);
                                 ValorJuros := ((Dias * QueTituPercenJuros.AsFloat) * QueTituVlrtit.Value) /100;
                              end;

                              with SegmentoN2.New do
                              begin
                                 Receita          := QueTituCodRec.AsInteger;
                                 TipoContribuinte := tiCNPJ;
                                 idContribuinte   := QueFilial.FieldByName('CNPJFil').AsString;
                                 Periodo          := StrToDate(FormatDateTime('dd/MM/yyyy', QueTituDatven.Value)); // ver este
                                 Referencia       := '';  // Ver este
                                 ValorPrincipal   := QueTituSaltit.Value; // Ver este
                                 Multa            := ValorMulta;  // Ver este
                                 Juros            := ValorJuros;  // Ver este
                                 DataVencimento   := StrToDate(FormatDateTime('dd/MM/yyyy', QueTituDatven.Value));
                              end; // with
                           end; // if
                           if QueTituCodForLan.AsInteger = 18 then // Se for DARF simples
                           begin
                              ValorMulta := 0;
                              // Calculo da multa
                              if QueTituValorMulta.AsFloat > 0 then
                                 ValorMulta := QueTituValorMulta.AsFloat
                              else if QueTituPercenMulta.AsFloat > 0 then
                                 ValorMulta := (QueTituPercenMulta.AsFloat * QueTituVlrtit.Value) /100;

                              ValorJuros := 0;
                              // Calculo dos juros
                              if QueTituValorJuros.AsFloat > 0 then
                                 ValorJuros := QueTituValorJuros.AsFloat
                              else if QueTituPercenJuros.AsFloat > 0 then
                              begin
                                 Dias := Trunc(Now() - QueTituDatven.AsDateTime);
                                 ValorJuros := ((Dias * QueTituPercenJuros.AsFloat) * QueTituVlrtit.Value) /100;
                              end;

                              with SegmentoN3.New do
                              begin
                                 Receita          := QueTituCodRec.AsInteger;
                                 TipoContribuinte := tiCNPJ;
                                 idContribuinte   := QueFilial.FieldByName('CNPJFil').AsString;
                                 Periodo          := StrToDate(FormatDateTime('dd/MM/yyyy', QueTituDatven.Value)); // ver este
                                 ReceitaBruta     := 0; // Ver este
                                 Percentual       := 0; // Ver este
                                 ValorPrincipal   := QueTituSaltit.Value; // Ver este
                                 Multa            := ValorMulta; // Ver este
                                 Juros            := ValorJuros; // Ver este
                                 DataVencimento   := StrToDate(FormatDateTime('dd/MM/yyyy', QueTituDatven.Value));
                              end; //
                           end; // if
                        end; // if

                       /// Registro 5 ///
                       Registro5.Valor          := TotalLote;
                       Registro5.QtdeMoeda      := 0.0;
                       Registro5.NumAvisoDebito := 0;
                     end; // with Lote.New
                  end; // if QueTituCodTipSer.AsInteger = 22
                  AuxEnvBco := QueTituNumEnvBco.AsInteger + 1;
                  QueAuxi.SQL.Clear;
                  QueAuxi.SQL.Text := 'UPDATE arqtitulo SET NumEnvBco = '+AuxEnvBco.ToString+' WHERE IDTitu = '+QueTituIDTitu.AsString;
                  QueAuxi.ExecSQL;
                  Next;
               end; // while
            end; // with
         end; // with


         NroSeqEnv := QueBanco.FieldByName('NroSeqEnv').AsInteger +1;
         if QueBanco.FieldByName('DiaGerArq').AsDateTime < Date then
              CodSeqArq := 0
         else CodSeqArq := QueBanco.FieldByName('CodSeqArq').AsInteger + 1;

         SeqArq := IntToStr(CodSeqArq);
         if length(SeqArq) = 1 then SeqArq := '0'+ SeqArq;

         NomeArquivo := NomeArquivo + QueBanco.FieldByName('Convenio').AsString + FormatDateTime('DD', Date) + SeqArq + '.REM';
         ACBrPagFor1.GravarTxtRemessa(NomeArquivo);

         MostraMsg('Aviso','Arquivo '+ NomeArquivo + ' gerado com sucesso',mtWarning, [mbOk]);

         // Mostra o arquivo de retorno
         NomeArquivo := PathExe+'PagamentoBanco\';
         odAbrirArq.Title := 'Mostrando o arquivo para envio';
         odAbrirArq.DefaultExtension := '*.txt';
         odAbrirArq.DefaultFolder := NomeArquivo;

         odAbrirArq.Execute;

         QueAuxi.SQL.Text := '';
         QueTitu.First;
         while not QueTitu.Eof do
         begin
            QueAuxi.SQL.Text := 'UPDATE arqtitulo SET IndEnvBco = "S" WHERE IDTitu = '+ IntToStr(QueTituIDTitu.AsInteger);
            QueAuxi.ExecSQL;
            QueAuxi.SQL.Text := '';
            QueTitu.Next;
         end; // while not QueTitu.Eof

         QueAuxi.SQL.Text := '';
         QueAuxi.SQL.Text := 'UPDATE arqbanco SET NroSeqEnv = ' + IntToStr(NroSeqEnv) + ', ' +
         'DiaGerArq = STR_TO_DATE( "' + FormatDateTime('dd/MM/yyyy', Date) + '", "%d/%m/%Y" ), ' +
         'CodSeqArq = '+IntToStr(CodSeqArq)+' WHERE Codban = '+ IntToStr(Codban);
         QueAuxi.ExecSQL;
      end; //with QueTitu
   finally
      QueAuxi.Close;
      QueFornec.Close;
      QueBanco.Close;
      QUeFilial.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueFornec);
      FreeAndNil(QueBanco);
      FreeAndNil(QueFilial);
      QueTitu.Filtered := False;
      QueTitu.Close;
      QueTitu.Open;
      AjustGrid;
      VlrPagAux.Clear;  TotPagAux.Clear;
      VlrJurAux.Clear;  VlrDesAux.Clear;
      edTotSel.Value := 0;
   end; // Try
end;

procedure TFrmTitBai.VlrJurAuxExit(Sender: TObject);
begin
   TotPagAux.Value := VlrPagAux.Value - VlrDesAux.Value + VlrJurAux.Value;
end;

procedure TFrmTitBai.DBGrid1CellClick(Column: TColumn);
begin
   if Column.FieldName = 'IndSel' then
   begin
      if not (QueTitu.State in dsEditModes) then QueTitu.Edit;
      QueTituIndSel.AsString := iif(QueTituIndSel.AsString = '0','1','0');
      QueTitu.Post;
      if QueTituIndSel.AsString = '1' then
      begin
         edTotSel.Value  := edTotSel.Value + QueTitu.FieldByName('Saltit').AsFloat;
         VlrPagAux.Value := VlrPagAux.Value + QueTitu.FieldByName('Saltit').AsFloat;
      end else
      begin
         edTotSel.Value  := edTotSel.Value - QueTitu.FieldByName('Saltit').AsFloat;
         VlrPagAux.Value := VlrPagAux.Value - QueTitu.FieldByName('Saltit').AsFloat;
      end;
      DBGrid1.SelectedField := QueTituSaltit;
   end; //if
end;

procedure TFrmTitBai.DBGrid1DblClick(Sender: TObject);
begin
   if IndBaixados.Checked then
   begin
      if not Ping(IPRemoto,PortaRemoto) then
      begin
         SalvaLog(USUARIO, PastaLog, 'uTituloBai -> Perda de conexão com o servidor');
         MostraMsg('Erro','Perda de conexão com o servidor!',mtWarning, [mbOk]);
         DatPagAux.SetFocus;
         Exit;
      end; //if
      try
         Application.CreateForm(TFrmTitEst, FrmTitEst);
         FrmTitEst.recIDTitu := QueTituIDTitu.AsInteger;
         FrmTitEst.ShowModal;
      finally
         QueTitu.Close;
         QueTitu.Open;
      end;
   end else
   begin
      with QueTitu do
      begin
         DatPagAux.Date := FieldByName('Datven').AsDateTime;
         VlrPagAux.Text := FieldByName('Saltit').AsString;
         TotPagAux.Text := FieldByName('Saltit').AsString;
         VlrJurAux.Text := '';
         VlrDesAux.Text := '';
         btBaixa.SetFocus;
      end; //with
   end; //if
end;

procedure TFrmTitBai.btBaixaClick(Sender: TObject);
begin
   if DatPagAux.Date = 0 then
   begin
      MostraMsg('Dado Faltante','Favor entrar com a Data do Pagamento!',mtWarning, [mbOk]);
      DatPagAux.SetFocus;
      Exit;
   end;
   if VlrPagAux.Value <= 0.00 then
   begin
      MostraMsg('Dado Faltante','Favor informar o Valor Pago!',mtWarning, [mbOk]);
      VlrPagAux.SetFocus;
      Exit;
   end;

   if QueTituIDNatFin.AsInteger > 0 then
   begin
      BaiConDeb := QueTituCodconCrePro.AsString;
      BaiConCre := iif(edCodcon.Tag > 0,_CodConta,'');
      if Length(BaiConCre) <= 3 then
      begin
         MostraMsg('Pagar Via Faltando','Pagar Via não está preenchida. Favor escolher uma Via!',mtWarning, [mbOk]);
         edCodcon.SetFocus;
         Exit;
      end; //if
   end; //if

   if not Ping(IPRemoto,PortaRemoto) then
   begin
      SalvaLog(USUARIO, PastaLog, 'uTituloBai -> Perda de conexão com o servidor');
      MostraMsg('Erro','Perda de conexão com o servidor!',mtError, [mbOk]);
      DatPagAux.SetFocus;
      Exit;
   end; //if
   EfetivaBaixa('BN');
   QueTitu.DisableControls;
   QueTitu.Close;
   btBuscar.Click;
   QueTitu.Refresh;
   QueTitu.EnableControls;
   VlrPagAux.Clear;    TotPagAux.Clear;
   VlrJurAux.Clear;    VlrDesAux.Clear;
   edCodcon.Tag := 0;  edCodcon.Text := '';
end;

procedure TFrmTitBai.btBaiTudoClick(Sender: TObject);
var
   Filtro:String;
begin
   if MostraMsg('Confirmação','Confirma baixa '+iif(TAdvGlowButton(Sender).Tag = 2,'dos títulos selecionados','de TODOS títulos')+'?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;

   if not Ping(IPRemoto,PortaRemoto) then
   begin
      SalvaLog(USUARIO, PastaLog, 'uTituloBai -> Perda de conexão com o servidor');
      MostraMsg('Erro','Perda de conexão com o servidor!',mtError, [mbOk]);
      DatPagAux.SetFocus;
      Exit;
   end; //if

   BaiConCre := iif(edCodcon.Tag > 0, edCodcon.Tag.ToString, '');

   if Length(BaiConCre) <= 2 then
   begin
      MostraMsg('Pagar Via Faltando','Pagar Via não está preenchida. Favor escolher uma Via!',mtWarning, [mbOk]);
      edCodcon.SetFocus;
      Exit;
   end; //if

   with QueTitu do
   begin
      First;
      while not Eof do
      begin
         if (TAdvGlowButton(Sender).Tag = 2) and (QueTituIndSel.AsString <> '1') then
         begin
            Next;
            Continue;
         end;
         BaiConDeb := QueTituCodconCrePro.AsString;
         if (BaiConCre = '') or (BaiConDeb = '') then
         begin
            BaiConDeb := '';
            BaiConCre := ''
         end;
         EfetivaBaixa('BT');
         Next;
      end; //while
   end; //with
   QueTitu.Close;
   QueTitu.Open;
   AjustGrid;
   VlrPagAux.Clear;  TotPagAux.Clear;
   VlrJurAux.Clear;  VlrDesAux.Clear;
end;

procedure TFrmTitBai.EfetivaBaixa(TipoBai:String);
var
   vErro:String;
   NroBaiAux:Integer;
   QueAuxi:TRESTDWClientSQL;
   TotPagSalva,SalTitAux:Double;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT MAX(Nrobai) AS UltBai FROM arqtituloBai WHERE IDTitu = '+QueTituIDTitu.AsString;
         QueAuxi.Open;
         if FieldByName('UltBai').AsString = '' then
              NroBaiAux := 1
         else NroBaiAux := FieldByName('UltBai').AsInteger + 1;
         try
            QueAuxi.Close;
            SQL.Text := 'INSERT INTO arqtitulobai (IDTitu,NroBai,CodconDeb,CodconCre,Datpag,VlrJuro,VlrDesc,VlrPago,TotPago) VALUES ('+
            QueTituIDTitu.AsString+','+
            NroBaiAux.ToString+','+
            Aspas(BaiConDeb)+','+
            Aspas(BaiConCre)+',';
            if TipoBai = 'BN' then
            begin
               SQL.Add(
               Aspas(FormatDateTime('yyyy-mm-dd',DatPagAux.Date))+','+
               FormatDouble(VlrJurAux.Value,11,2)+','+
               FormatDouble(VlrDesAux.Value,11,2)+','+
               FormatDouble(VlrPagAux.Value,11,2)+','+
               FormatDouble(VlrPagAux.Value + VlrJurAux.Value - VlrDesAux.Value,11,2)+')');
               TotPagSalva := VlrPagAux.Value + VlrJurAux.Value - VlrDesAux.Value;
            end else
            begin
               SQL.Add(
               Aspas(FormatDateTime('yyyy-mm-dd',DatPagAux.Date))+','+
               FormatDouble(0.00,11,2)+','+
               FormatDouble(0.00,11,2)+','+
               FormatDouble(QueTituSaltit.AsFloat,11,2)+','+
               FormatDouble(QueTituSaltit.AsFloat,11,2)+')');
               TotPagSalva := QueTituSaltit.AsFloat;
            end; //if
            ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqtitulobai na uTitulosBai -> '+E.Message);
               MostraMsg('Erro','Não foi possível gravar a baixa da conta.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
         if (TotPagSalva < QueTituSaltit.AsFloat) and (VlrDesAux.Value = 0.00) then
             SalTitAux := QueTituSaltit.AsFloat - TotPagSalva
         else SalTitAux := 0.00;
         try
            SQL.Clear;
            SQL.Text := 'UPDATE arqtitulo SET Saltit = '+FormatDouble(SalTitAux,11,2)+', IndSel = '+Aspas('0')+' WHERE IDTitu = '+QueTituIDTitu.AsString;
            ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar em arqtitulo na uTitulosBai -> '+E.Message);
               MostraMsg('Erro','Não foi possível alterar a conta para paga.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try

         edTotPer.Value := edTotPer.Value - edTotSel.Value;
         edTotSel.Value := 0;
      end; //with
   finally
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmTitBai.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',0,True);
end;

procedure TFrmTitBai.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',Key);
end;

procedure TFrmTitBai.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmTitBai.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',Key);
end;

procedure TFrmTitBai.edConvCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqconvenio',TLMDEdit(edConv),'IDConv','Nomcon','',0,True);
end;

procedure TFrmTitBai.edConvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqconvenio',TLMDEdit(edConv),'IDConv','Nomcon','',Key);
end;

procedure TFrmTitBai.edCodconKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   Filtro:String;
begin
   _CodConta := '';
   _IDConta  := -1;
   Filtro := '(Codcon LIKE '+Aspas('11101%')+' OR Codcon LIKE '+Aspas('11102%')+') AND Nivcon = '+Aspas('5');
   btBuscas('arqplacon',TLMDEdit(edCodcon),'IDCon','Nomcon',Filtro,Key);
end;

procedure TFrmTitBai.edCodconCustomButtons0Click(Sender: TObject; index: Integer);
var
   Filtro,ConLimite:String;
   QueAuxi:TRESTDWClientSQL;
begin
   Filtro := '(Codcon LIKE '+Aspas('11101%')+' OR Codcon LIKE '+Aspas('11102%')+') AND Nivcon = '+Aspas('5');
   btBuscas('arqplacon',TLMDEdit(edCodcon),'IDCon','Nomcon',Filtro,0,True);
end;

procedure TFrmTitBai.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then
      (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText)
   else
   if Column.Alignment = taRightJustify then
   (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText)
   else
   if Column.Alignment = taLeftJustify  then
   (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   if Column.FieldName = 'IndSel' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if QueTituIndSel.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmTitBai.MostraMulJur;
var
   Dias:Integer;
begin
   VlrMulBanco.Value := 0;
   // Calculo da multa
   if QueTituValorMulta.AsFloat > 0 then VlrMulBanco.Value := QueTituValorMulta.AsFloat;

   if QueTituPercenMulta.AsFloat > 0 then VlrMulBanco.Value := (QueTituPercenMulta.AsFloat * QueTituVlrtit.AsFloat) /100;
   VlrJurBanco.Value := 0;
   // Calculo dos juros
   if QueTituValorJuros.AsFloat > 0 then
      VlrJurBanco.Value := QueTituValorJuros.AsFloat
   else if QueTituPercenJuros.AsFloat > 0 then
   begin
      Dias := Trunc(Now() - QueTituDatven.AsDateTime);
      VlrJurBanco.Value := ((Dias * QueTituPercenJuros.AsFloat) * QueTituVlrtit.AsFloat) /100;
   end;
end;

procedure TFrmTitBai.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Shift = [ssCtrl]) and (Key = 46) then Key := 0;
end;

procedure TFrmTitBai.DBGrid1TitleClick(Column: TColumn);
begin
   column.Field.FocusControl;
   if QueTitu.IndexFieldNames = Column.FieldName + ':A' then
        QueTitu.IndexFieldNames := Column.FieldName + ':D'
   else QueTitu.IndexFieldNames := Column.FieldName + ':A';
end;

procedure TFrmTitBai.LMDDBEdit1DataChange(Sender: TObject);
begin
   MostraMulJur;
end;

procedure TFrmTitBai.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTitBai.btRetornoBcoClick(Sender: TObject);
begin
   Application.CreateForm(TFrmRetTitBco, FrmRetTitBco);
   FrmRetTitBco.ShowModal;
end;

procedure TFrmTitBai.btSelecTudoClick(Sender: TObject);
begin
   if QueTitu.IsEmpty then Exit;
   MostraMsg('Títulos Enviados para Banco','Os títulos enviados para banco não vão ser selecionados!', mtWarning, [mbOk]);
   QueTitu.First;
   while not QueTitu.Eof do
   begin
      if QueTituIndEnvBco.AsString = 'N' then
      begin
         QueTitu.Edit;
         QueTituIndSel.AsString := '1';
         QueTitu.Post;
         edTotSel.Value  := edTotSel.Value + QueTitu.FieldByName('Saltit').AsFloat;
         VlrPagAux.Value := VlrPagAux.Value + QueTitu.FieldByName('Saltit').AsFloat;
      end;
      QueTitu.Next;
   end;
end;

procedure TFrmTitBai.ckEmissaoClick(Sender: TObject);
begin
   if ckEmissao.Checked then
   begin
      ckPagamento.Checked  := False;
      ckVencimento.Checked := False;
   end;
   ckEmissao.Checked := True;
end;

procedure TFrmTitBai.ckEnvNaoClick(Sender: TObject);
begin
   ckEnvSim.Checked := False;
end;

procedure TFrmTitBai.ckEnvSimClick(Sender: TObject);
begin
   ckEnvNao.Checked := False;
end;

procedure TFrmTitBai.ckPagamentoClick(Sender: TObject);
begin
   if ckPagamento.Checked then
   begin
      ckVencimento.Checked  := False;
      ckEmissao.Checked := False;
   end;
   ckPagamento.Checked := True;
end;

procedure TFrmTitBai.ckVencimentoClick(Sender: TObject);
begin
   if ckVencimento.Checked then
   begin
      ckPagamento.Checked  := False;
      ckEmissao.Checked := False;
   end;
   ckVencimento.Checked := True;
end;

procedure TFrmTitBai.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if QueTitu.Active then QueTitu.Close;
   Self   := nil;
   Action := caFree;
end;

end.

