unit uCompRec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDSimplePanel,
  LMDDBEdit, MarcLib, LMDMemo, AdvGlowButton, Vcl.ExtCtrls, AdvSmoothPanel, ACBrNFe,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, LMDCustomBevelPanel,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, RxDBCtrl,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, LMDCheckBox,
  LMDEdit, LMDButtonControl, LMDBaseGraphicControl, LMDBaseLabel, uRESTDWBasicTypes,
  uRESTDWBasicDB, pcnConversao, LMDCustomMemo, System.StrUtils, LMDCustomCheckBox,
  Data.DB, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, LMDBaseEdit, LMDCustomEdit, LMDLabel,
  LMDCustomLabel, Vcl.Imaging.pngimage, LMDControl, LMDCustomControl, LMDCustomPanel,
  Vcl.DBCtrls, uShadowForm;

type
  TFrmCompEnt = class(TForm)
    SouCompRec: TDataSource;
    PanelPri: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel8: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelIte: TLMDSimplePanel;
    PanelRodape: TLMDSimplePanel;
    LMDLabel14: TLMDLabel;
    edTotProd: TLMDDBLabeledEdit;
    edNroIte: TLMDEdit;
    edTotEnt: TLMDDBLabeledEdit;
    btEtiqueta: TAdvGlowButton;
    btImprime: TAdvGlowButton;
    btPrecificar: TAdvGlowButton;
    timTipRec: TTimer;
    OpenDialog: TOpenDialog;
    SouCompRecLot: TDataSource;
    btTitulos: TAdvGlowButton;
    lbTipoEnt: TLMDLabel;
    btFinalPreEnt: TAdvGlowButton;
    SouCompRecIt: TDataSource;
    Shape4: TShape;
    PanelCabecalho: TLMDSimplePanel;
    edNroPedFor: TLMDLabeledEdit;
    edPessoa: TLMDDBLabeledEdit;
    edFilial: TLMDDBLabeledEdit;
    LMDLabel15: TLMDLabel;
    meObs: TLMDLabeledMemo;
    edNroNFe: TLMDDBLabeledEdit;
    edNroSerie: TLMDDBLabeledEdit;
    Shape5: TShape;
    TabCompRec: TRESTDWClientSQL;
    TabCompRecIDRec: TFDAutoIncField;
    TabCompRecIDPess: TIntegerField;
    TabCompRecIDFilial: TIntegerField;
    TabCompRecTipRece: TWideStringField;
    TabCompRecDatRece: TDateTimeField;
    TabCompRecTotRece: TFloatField;
    TabCompRecTotProd: TFloatField;
    TabCompRecNroPedFor: TWideStringField;
    TabCompRecTipEnt: TWideStringField;
    TabCompRecObsped: TWideMemoField;
    TabCompRecNroSerie: TIntegerField;
    TabCompRecNompes: TWideStringField;
    TabCompRecNomfil: TWideStringField;
    TabCompRecIt: TRESTDWClientSQL;
    TabCompRecItIDRec: TIntegerField;
    TabCompRecItNroite: TSmallintField;
    TabCompRecItIDProd: TIntegerField;
    TabCompRecItQtdfra: TFloatField;
    TabCompRecItTotrec: TFloatField;
    TabCompRecItPerDesc: TFloatField;
    TabCompRecItVlrDesc: TFloatField;
    TabCompRecItVlruni: TFloatField;
    TabCompRecItVlrPIS: TFloatField;
    TabCompRecItVlrCOF: TFloatField;
    TabCompRecItPerIPI: TFloatField;
    TabCompRecItVlrIPI: TFloatField;
    TabCompRecItPerICMS: TFloatField;
    TabCompRecItVlrICMS: TFloatField;
    TabCompRecItVlrST: TFloatField;
    TabCompRecItVlrOut: TFloatField;
    TabCompRecItCFOP: TIntegerField;
    TabCompRecItIDProdFor: TWideStringField;
    TabCompRecItVlrPMC: TFloatField;
    TabCompRecItIdRegMS: TLargeintField;
    TabCompRecItCodEAN: TWideStringField;
    TabCompRecItDespro: TWideStringField;
    TabCompRecItVlrUniFinCalc: TFloatField;
    TabCompRecItTotIteRecCalc: TFloatField;
    TabCompRecLot: TRESTDWClientSQL;
    TabCompRecLotIDRec: TIntegerField;
    TabCompRecLotNroite: TIntegerField;
    TabCompRecLotIDProd: TIntegerField;
    TabCompRecLotNrolot: TWideStringField;
    TabCompRecLotDatfab: TDateField;
    TabCompRecLotDatven: TDateField;
    TabCompRecLotcAgreg: TWideStringField;
    TabCompRecLotQtdrec: TFloatField;
    TabCompRecItClasTera: TWideStringField;
    TabCompRecItProdExist: TWideStringField;
    TabCompRecNrotit: TWideStringField;
    TabCompRecNotFis: TIntegerField;
    btProdutos: TAdvGlowButton;
    TabCompRecDatEmi: TDateTimeField;
    TabCompRecIDChaAce: TWideStringField;
    TabCompRecItCST_CSOSN: TSmallintField;
    TabCompRecItIDCFOP: TIntegerField;
    TabCompRecItCST_ORI: TWideStringField;
    TabCompRecItCFOP_EST: TIntegerField;
    TabCompRecItCFOP_EST_ST: TIntegerField;
    TabCompRecItCFOP_INT: TIntegerField;
    TabCompRecItCFOP_INT_ST: TIntegerField;
    TabCompRecItOrigem: TIntegerField;
    TabCompRecItQuantProdConf: TFloatField;
    TabCompRecItVlrTot: TFloatField;
    TabCompRecItDescrProdNota: TWideStringField;
    edChaAces: TLMDDBLabeledEdit;
    PanelItem: TAdvSmoothPanel;
    Shape7: TShape;
    dgProduto: TDBGrid;
    PanelCabItem: TAdvSmoothPanel;
    btLimpaIte: TAdvGlowButton;
    btSalvaIte: TAdvGlowButton;
    edTotQuantRec: TLMDDBLabeledEdit;
    edFracao: TLMDDBLabeledEdit;
    edVlrUniFin: TLMDDBLabeledEdit;
    edTotItem: TLMDDBLabeledEdit;
    edValIPI: TLMDDBLabeledEdit;
    edPerIPI: TLMDDBLabeledEdit;
    edPerICMS: TLMDDBLabeledEdit;
    edVlrICMS: TLMDDBLabeledEdit;
    edVlrDesc: TLMDDBLabeledEdit;
    edPerDesc: TLMDDBLabeledEdit;
    edVlrST: TLMDDBLabeledEdit;
    edVlrOut: TLMDDBLabeledEdit;
    edVlruni: TLMDDBLabeledEdit;
    edCSTCSOSN: TLMDDBLabeledEdit;
    edCFOP: TLMDDBLabeledEdit;
    edNomPro: TLMDDBLabeledEdit;
    edCodPro: TLMDDBLabeledEdit;
    edNroInt: TLMDDBLabeledEdit;
    TabCompRecItVlrUltPreComp: TFloatField;
    edQuantProdConf: TLMDDBLabeledEdit;
    TabCompRecItVlrCustoMed: TFloatField;
    TabCompRecCNPJCPFFor: TWideStringField;
    TabCompRecItVlrVendaSuger: TFloatField;
    LMDSimplePanel4: TLMDSimplePanel;
    dtEmissao: TDBDateEdit;
    Shape2: TShape;
    Shape3: TShape;
    edPendencias: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    Shape11: TShape;
    TabCompRecItVlrVendaAtual: TFloatField;
    TabCompRecLotQtdRecFab: TFloatField;
    TabCompRecItVlrVendaSugerOrig: TFloatField;
    btConfere: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure PanelItMouseEnter(Sender: TObject);
    procedure PanelItMouseExit(Sender: TObject);
    procedure dgProdutoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dgProdutoCellClick(Column: TColumn);
    procedure edPerICMKeyPress(Sender: TObject; var Key: Char);
    procedure btEtiquetaClick(Sender: TObject);
    procedure btTitulosClick(Sender: TObject);
    procedure KeyStrCancel(Sender: TObject; var Key: Char);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btFecharClick(Sender: TObject);
    procedure edCodCFOPExit(Sender: TObject);
    procedure timTipRecTimer(Sender: TObject);
    procedure btProdutosClick(Sender: TObject);
    procedure edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure btFinalPreEntClick(Sender: TObject);
    procedure TabCompRecItAfterOpen(DataSet: TDataSet);
    procedure TabCompRecItCalcFields(DataSet: TDataSet);
    procedure edPendenciasClick(Sender: TObject);
    procedure edCFOPCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edCSTCSOSNCustomButtons0Click(Sender: TObject; index: Integer);
    procedure dgProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPrecificarClick(Sender: TObject);
    procedure dgProdutoExit(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure TabCompRecItAfterPost(DataSet: TDataSet);
    procedure edCSTCSOSNKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btImprimeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btConfereClick(Sender: TObject);
  private
    { Private declarations }
    auxIDFil:Integer;
    auxImporta:Boolean;
    auxTotRateio,auxQtdFra,auxMargem,auxVenda:Double;
    auxNomFil,auxTipRec,auxTipEnt,vErro,auxCol,auxNomArqXML:String;
    function  recNFEXML:Boolean;
    procedure recManiDest;
    function  RecalCustoMed(recIDProd:Integer):Boolean;
    function  CadProdutos(recCodEAN,recDespro,recCodProFor:String):Boolean;
    function  BuscaFilial(CNPJCPF:String):boolean;
    procedure AjustaGrid;
    procedure ParamColCon;
    procedure GravaDadosFra(VlrFrac:Double;Origem:Integer);
    procedure GravaDadosCFOP;
    function  ConfereNatFin:Boolean;
    procedure HabilBotoes(Botoes:Boolean;Panel:Integer);
  public
    { Public declarations }
    recIDRec:Integer;
  end;

var
  FrmCompEnt: TFrmCompEnt;

implementation

uses uDM, uConst, uCompras, uLibFarm, uEntradaLote, uCompTipRec, uProdutoCad, uCompRecPre,
     uPessoasCad, uNotasPendEnt, uManiDest, uConfRecEnt, uCompRecTit, uWaitForm;

{$R *.dfm}

procedure TFrmCompEnt.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Self.Top     := Self.Top - 20;
   auxTipRec    := '1';
   auxTotRateio := 0.00;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT ObrConfRec FROM arqparametros';
      QueAuxi.Open;
      btConfere.Visible := QueAuxi.FIeldByName('ObrConfRec').AsBoolean;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   AjustaGrid;
   edPessoa.SetFocus;
end;

procedure TFrmCompEnt.AjustaGrid;
begin
   TStringGrid(dgProduto).DefaultRowHeight := BaseRowHeight - 3;
   dgProduto.Width := dgProduto.Width - 10;
   dgProduto.Width := dgProduto.Width + 10;
end;

procedure TFrmCompEnt.timTipRecTimer(Sender: TObject);
var
   i:Integer;
   AuxClickBtConfirma: Boolean;
begin
   timTipRec.Enabled := False;
   Self.AlphaBlendValue := 165;
   try
      Application.CreateForm(TFrmCompTipRec, FrmCompTipRec);
      CentralizarControl(FrmCompTipRec, PanelPri);
      FrmCompTipRec.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxTipRec := FrmCompTipRec.retOpcao;
      auxTipEnt := FrmCompTipRec.retTipEnt;
      AuxClickBtConfirma := FrmCompTipRec.ClickBtConfirma;
      FreeAndNil(FrmCompTipRec);
   end;

   //--> VERIFICAR ESSES DADOS FIXOS ABAIXO
   auxIDFil  := FILIAL;
   auxNomFil := 'FILIAL 01';

   if not AuxClickBtConfirma then Exit;

   if (auxTipRec = '1') and (not recNFEXML) then
   begin
      timTipRec.Enabled := True;
      Exit;
   end;

   if auxTipRec = '3' then
   begin
      recManiDest;
      if auxImporta and (not recNFEXML) then
      begin
         timTipRec.Enabled := True;
         Exit;
      end else
      begin
         timTipRec.Enabled := True;
         Exit;
      end; //if
   end; //if

   lbTipoEnt.Caption := iif(auxTipEnt = '1','NORMAL','PRÉ RECEBIMENTO');
   edPessoa.SetFocus;
end;

function TFrmCompEnt.BuscaFilial(CNPJCPF:String):boolean;
var
   QueFilial:TRESTDWClientSQL;
begin
   Result := True;
   QueFilial := TRESTDWClientSQL.Create(nil);
   try
      QueFilial.DataBase := DM.DWDataBase;
      QueFilial.SQL.Text := 'SELECT * FROM arqfilial WHERE CNPJFil = '+Aspas(CNPJCPF);
      QueFilial.Open;
      if QueFilial.IsEmpty then
      begin
//-->    MostraMsg('Aviso','Esta nota não coresponde ao CNPJ da Filial!',mtWarning, [mbOk]);
//-->    Result := False;
//-->    Para funcionar depois tirar estas 2 linhas abaixo e descomentar as 2 de cima
         auxIDFil  := FILIAL;
         auxNomFil := 'FILIAL 01';
      end;// if
   finally
      QueFilial.Close;
      FreeAndNil(QueFilial);
   end;// try
end;

// --------------- Entrada Produtos VIA XML NFe --------------- //
procedure TFrmCompEnt.recManiDest;
var
   auxIDRec:Integer;
begin
   try
      Application.CreateForm(TFrmManiDest, FrmManiDest);
      CentralizarControl(FrmManiDest, PanelPri);
      Self.AlphaBlendValue := 175;
      FrmManiDest.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxNomArqXML := FrmManiDest.recNomArqXML;
      auxImporta   := FrmManiDest.recImporta;
      FrmManiDest.Free;
   end; //try
end;

function TFrmCompEnt.recNFEXML:Boolean;
var
   auxRegMS:Int64;
   auxIDTit:Integer;
   ACBrNFe:TACBrNFe;
   QueAuxi,QueProd,QueGrava,QueProdNFe,QueComp,QuePreco:TRESTDWClientSQL;
   auxQtdFrac,auxVlrOutIte,auxVlrDesc,auxPerDesc,auxVlrST,auxVlrPMC,AuxQuantConf,AuxQuantCal,auxVlrTot,auxVlrPreVen,auxVlrPerMar:Double;
   auxVlrPreCom,auxVlrUltPreCom,auxPerVar,auxPrecoFab,auxVlrVendaSuger,auxVlrUniTot,auxVlrIPI:Double;
   auxVlrPIS,auxVlrCOFINS,auxVlrICMS,auxVlrUni,auxValor,auxVlrCustoMed,auxCustoMed,auxQtdest:Double;
   auxVlruniNota,auxVlrOutIteNotas,auxVlrIPINota,auxVlrDescNota,auxVlrPISNota,auxVlrCOFINSNota,auxVlrICMSNota,auxVlrSTNota:Double;
   I,Lot,AuxQtdIte,auxNroNFe,auxNroSerie,auxIDPess,auxIDRec,auxIDProd,auxCFOP,auxNroIte,auxIDConv,auxIdFabr,auxIDNatfin:Integer;
   vSQL,auxCNPJCPF,auxNomPes,auxNomProd,auxSNGPC,auxProdExist,auxNrotit,auxCodCST,auxOrigem,auxChave:String;
   auxTotCusMedAtu,auxVlrTotEst,QtdEstAtu:Double;
begin
   Result     := False;
   AuxQtdIte  := 0;
   auxQtdFrac := 0;
   if auxTipRec = '1' then
   begin
      if not OpenDialog.Execute then Exit;
   end else
   if (auxTipRec = '3') and (auxNomArqXML = '') then Exit;

   ShowWait('Aguarde...', Self);
   ACBrNFe := TACBrNFe.Create(nil);
   QueProd := TRESTDWClientSQL.Create(nil);
   QueProd.DataBase := DM.DWDataBase;
   QueProd.SQL.Text :=
   'SELECT PRO.IDProd,PRO.CodEANPri,PRO.QtdFrac,PRO.Despro,PRO.ClasTera,PRO.PrecoVen,PRO.PrecoPMC,PRO.MarkupCim,'+
   'PRO.Markup,PRO.IdFabr,PRO.PrecoFab,PRO.CustoMed,EAN.CodEAN,COALESCE(SUM(LOT.Qtdest),0) AS Qtdest FROM arqproduto PRO '+
   'LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd LEFT JOIN arqprodutolot LOT ON PRO.IDProd = LOT.IDProd '+
   'WHERE CodEANPri != "" GROUP BY PRO.IDProd';

   QueAuxi    := TRESTDWClientSQL.Create(nil);  QueAuxi.DataBase    := DM.DWDataBase;
   QueProdNFe := TRESTDWClientSQL.Create(nil);  QueProdNFe.DataBase := DM.DWDataBase;
   QueGrava   := TRESTDWClientSQL.Create(nil);  QueGrava.DataBase   := DM.DWDataBase;
   QueComp    := TRESTDWClientSQL.Create(nil);  QueComp.DataBase    := DM.DWDataBase;
   QuePreco   := TRESTDWClientSQL.Create(nil);  QueComp.DataBase    := DM.DWDataBase;

   try
      try
         QueProd.Open;
         ACBrNFe.NotasFiscais.Clear;
         if auxTipRec = '1' then
            ACBrNFe.NotasFiscais.LoadFromFile(OpenDialog.FileName, False)
         else if auxTipRec = '3' then ACBrNFe.NotasFiscais.LoadFromFile(auxNomArqXML, False);

         auxNroNFe   := ACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF;
         auxCNPJCPF  := ACBrNFe.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
         auxNroSerie := ACBrNFe.NotasFiscais.Items[0].NFe.Ide.serie;
         auxChave    := ACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID;

         // Testa para ver se é NFe ou outro tipo de nota
         if Copy(auxChave,1,3) <> 'NFe' then
         begin
            MostraMsg('Aviso','XML não é de uma nota fiscal NFe, esta nota fiscal é '+Copy(auxChave,1,3)+' favor verifique o tipo de nota fiscal.', mtWarning, [mbOk]);
            Exit;
         end;// if
         auxChave := Copy(auxChave,4);
         QueProdNFe.SQL.Text := 'SELECT * FROM arqcomprarec WHERE NotFis = '+auxNroNFe.ToString+' AND NroSerie = '+auxNroSerie.ToString;
         QueProdNFe.Open;

         // Teste para ver se esta nota referente ao XML já foi lançado no sistema
         if not QueProdNFe.IsEmpty then
         begin
            MostraMsg('Aviso','NF número '+ACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF.ToString+' e série '+ACBrNFe.NotasFiscais.Items[0].NFe.Ide.serie.ToString+' já entrada!', mtWarning, [mbOk]);
            Exit;
         end; //if

         if auxCNPJCPF.Trim = '' then raise Exception.Create('CNPJ/CPF da NFe inválido.');
         QueAuxi.SQL.Text := 'SELECT PES.IDPess,PES.Nompes,BAN.IDNatfin,CON.IDConv FROM arqpessoa PES '+
         'LEFT JOIN arqpessbanc BAN ON BAN.IDPess = PES.IDPess LEFT JOIN arqpessconv PCON ON PCON.IDPess = PES.IDPess '+
         'LEFT JOIN arqconvenio CON ON CON.IDConv = PCON.IDConv WHERE PES.CpfCnpjPes = '+Aspas(auxCNPJCPF);
         QueAuxi.Open;
         if QueAuxi.IsEmpty then
         begin
            if MostraMsg('Confirmação','Fornecedor com CNPJ/CPF: '+auxCNPJCPF+' não encontrado, deseja cadastrar?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
            try
               FrmPesCad := TFrmPesCad.Create(Application);
               CentralizarControl(FrmPesCad, FrmCompras);
               FrmPesCad.recIDPess := -1;
               FrmPesCad.recEsppes := 2;
               FrmPesCad.recOrigem := 'RECE';
               FrmPesCad.recCampo  := 'CpfCnpjPes';
               FrmPesCad.recValor  := auxCNPJCPF;
               FrmPesCad.ShowModal;
            finally
               auxIDPess := FrmPesCad.recIDPess;
               FrmPesCad := nil;
            end;

            if auxIDPess > 0 then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'SELECT PES.IDPess,PES.Nompes,BAN.IDNatfin,CON.IDConv FROM arqpessoa PES '+
               'LEFT JOIN arqpessbanc BAN ON BAN.IDPess = PES.IDPess LEFT JOIN arqpessconv PCON ON PCON.IDPess = PES.IDPess '+
               'LEFT JOIN arqconvenio CON ON CON.IDConv = PCON.IDConv WHERE PES.IDPess = '+auxIDPess.ToString;
               QueAuxi.Open;
               auxIDPess   := QueAuxi.FieldByName('IDPess').AsInteger;
               auxNompes   := QueAuxi.FieldByName('Nompes').AsString;
               auxIDNatfin := QueAuxi.FieldByName('IDNatfin').AsInteger;
               auxIDConv   := QueAuxi.FieldByName('IDConv').AsInteger;
               if auxIDNatfin = 0 then
               begin
                  QueAuxi.Close;
                  QueAuxi.SQL.Text := 'SELECT IDNatFinEntMerRec FROM arqparametros';
                  QueAuxi.Open;
                  auxIDNatfin := QueAuxi.FieldByName('IDNatFinEntMerRec').AsInteger;
               end; //if
            end
            else Exit;
         end else
         begin
            auxIDPess   := QueAuxi.FieldByName('IDPess').AsInteger;
            auxNompes   := QueAuxi.FieldByName('Nompes').AsString;
            auxIDNatfin := QueAuxi.FieldByName('IDNatfin').AsInteger;
            auxIDConv   := QueAuxi.FieldByName('IDConv').AsInteger;
            if auxIDNatfin = 0 then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'SELECT IDNatFinEntMerRec,PastaCertDigital FROM arqparametros';
               QueAuxi.Open;
               auxIDNatfin := QueAuxi.FieldByName('IDNatFinEntMerRec').AsInteger;
            end; //if
         end; //if

         TabCompRec.DisableControls;
         try
            QueGrava.Close;
            QueGrava.SQL.Text := 'INSERT INTO arqcomprarec (IDPess,IDFilial,TipRece,DatRece,TotRece,'+
            'TotProd,NroPedFor,NotFis,NroSerie,DatEmi,Nrotit,TipEnt,IDChaAce,CNPJCPFFor,Obsped) VALUES ('+
            auxIDPess.ToString+','+
            auxIDFil.ToString+','+
            Aspas(auxTipRec)+','+
            Aspas(FormatDateTime('yyyy-mm-dd',VeDataServer))+','+
            FormatDouble(ACBrNFe.NotasFiscais.Items[0].NFe.Total.ICMSTot.vNF,11,2)+','+
            FormatDouble(ACBrNFe.NotasFiscais.Items[0].NFe.Total.ICMSTot.vProd,11,2)+','+
            Aspas(edNroPedFor.Text)+','+
            Aspas(IntToStr(ACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF))+','+
            Aspas(IntToStr(ACBrNFe.NotasFiscais.Items[0].NFe.Ide.serie))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',ACBrNFe.NotasFiscais.Items[0].NFe.Ide.dEmi))+','+
            Aspas(ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Fat.nFat)+','+
            Aspas(auxTipEnt)+','+
            Aspas(auxChave)+','+
            Aspas(auxCNPJCPF)+','+
            Aspas(meObs.Text)+');';
            QueGrava.SQL.Add('SELECT LAST_INSERT_ID() AS ULT_IDRec;');
            QueGrava.Open;
            auxIDRec :=  QueGrava.FieldByName('ULT_IDRec').AsInteger;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar TabCompRec em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
               Result := False;
               Exit;
            end;
         end; //try

         TabCompRec.Close;
         TabComprec.SQL.Text := 'SELECT REC.*,PES.Nompes,FIL.Nomfil FROM arqcomprarec REC LEFT JOIN '+
         'arqpessoa PES  ON REC.IDPess = PES.IDPess LEFT JOIN arqfilial FIL ON REC.IDFilial = FIL.IDFilial '+
         'WHERE IDRec = '+auxIDRec.ToString;
         TabCompRec.Open;

         // ------ Salva Dados do XML nas Tabelas de Recebimento ------ //
         QueGrava.Close;
         QueGrava.SQL.Clear;
         TabCompRecIt.DisableControls;
         for I := 0 to ACBrNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do
         begin
            with ACBrNFe.NotasFiscais.Items[0].NFe.Det.Items[I] do
            begin
               if Prod.cEAN.Trim <> '' then
               begin
                  if not QueProd.Locate('CodEANPri',Prod.cEAN,[]) then
                  begin
                     if not QueProd.Locate('CodEAN',Prod.cEAN,[]) then
                     begin
                        ShowMessage(Prod.cEAN);
                        auxIDProd    := 0;
                        auxNomProd   := '';
                        auxQtdFrac   := 0;
                        auxSNGPC     := '';
                        auxVlrPreVen := 0;
                        auxVlrPerMar := 0;
                        auxIdFabr    := 0;
                        auxProdExist := '0';
                        auxCustoMed  := 0;
                        auxQtdest    := 0;
                     end else
                     begin
                        auxIDProd    := QueProd.FieldByName('IDProd').AsInteger;
                        auxNomProd   := QueProd.FieldByName('Despro').AsString;
                        auxQtdFrac   := QueProd.FieldByName('QtdFrac').AsFloat;
                        auxSNGPC     := QueProd.FieldByName('ClasTera').AsString;
                        auxVlrPreVen := QueProd.FieldByName('PrecoVen').AsFloat;
                        if QueProd.FieldByName('MarkupCim').AsFloat > 0.00 then
                             auxVlrPerMar := QueProd.FieldByName('MarkupCim').AsFloat
                        else auxVlrPerMar := QueProd.FieldByName('Markup').AsFloat;
                        auxIdFabr    := QueProd.FieldByName('IdFabr').AsInteger;
                        auxPrecoFab  := QueProd.FieldByName('PrecoFab').AsFloat;
                        auxProdExist := '1';
                        auxCustoMed  := QueProd.FieldByName('CustoMed').AsFloat;
                        auxQtdest    := QueProd.FieldByName('Qtdest').AsFloat;
                     end;// if
                  end else
                  begin
                     auxIDProd    := QueProd.FieldByName('IDProd').AsInteger;
                     auxNomProd   := QueProd.FieldByName('Despro').AsString;
                     auxQtdFrac   := QueProd.FieldByName('QtdFrac').AsFloat;
                     auxSNGPC     := QueProd.FieldByName('ClasTera').AsString;
                     auxVlrPreVen := QueProd.FieldByName('PrecoVen').AsFloat;
                     if QueProd.FieldByName('MarkupCim').AsFloat > 0.00 then
                          auxVlrPerMar := QueProd.FieldByName('MarkupCim').AsFloat
                     else auxVlrPerMar := QueProd.FieldByName('Markup').AsFloat;
                     auxIdFabr    := QueProd.FieldByName('IdFabr').AsInteger;
                     auxPrecoFab  := QueProd.FieldByName('PrecoFab').AsFloat;
                     auxProdExist := '1';
                     auxCustoMed  := QueProd.FieldByName('CustoMed').AsFloat;
                     auxQtdest    := QueProd.FieldByName('Qtdest').AsFloat;
                  end;// if
               end else
               begin
                  auxIDProd    := 0;
                  auxNomProd   := '';
                  auxQtdFrac   := 0;
                  auxSNGPC     := '';
                  auxVlrPreVen := 0;
                  auxVlrPerMar := 0;
                  auxIdFabr    := 0;
                  auxPrecoFab  := 0;
                  auxProdExist := '0';
                  auxCustoMed  := 0;
                  auxQtdest    := 0;
               end; //if

               // Pega os valores originais da nota
               auxVlruniNota     := Prod.vUnCom;             // VlrUniNota
               auxVlrOutIteNotas := Prod.vOutro;             // VlrOutNota
               auxVlrIPINota     := Imposto.IPI.vIPI;        // VlrIPINota
               auxVlrDescNota    := Prod.vDesc;              // VlrDescNota
               auxVlrPISNota     := Imposto.PIS.vPIS;        // VlrPISNota
               auxVlrCOFINSNota  := Imposto.COFINS.vCOFINS;  // VlrCOFNota
               auxVlrICMSNota    := Imposto.ICMS.vICMS;      // VlrICMSNota
               auxVlrSTNota      := Imposto.ICMS.vICMSST;    // VlrSTNota

               // Pega a quantidade conferida se for entrada normal
               if auxTipEnt = '1' then
               begin
                  if auxQtdFrac > 0 then
                  begin
                     AuxQuantConf := Prod.qCom * auxQtdFrac;
                     AuxQuantCal  := Prod.qCom * auxQtdFrac;
                  end else
                  begin
                     AuxQuantConf := Prod.qCom;
                     AuxQuantCal  := Prod.qCom;
                  end;// if
               end else
               begin
                  AuxQuantConf := 0;
                  if auxQtdFrac > 0 then
                       AuxQuantCal  := Prod.qCom * auxQtdFrac
                  else AuxQuantCal  := Prod.qCom;
               end; //if

               if auxQtdFrac > 0 then
                    auxVlrUni := Prod.vUnCom/auxQtdFrac
               else auxVlrUni := Prod.vUnCom;
               auxVlrOutIte := Prod.vOutro/AuxQuantCal;   // Valor total no item dos outros dividido pela fração daquele item
               auxVlrIPI    := Imposto.IPI.vIPI/AuxQuantCal;
               auxVlrDesc   := Prod.vDesc/AuxQuantCal;

               if Prod.vUnCom > 0 then
                    auxPerDesc := ((Prod.vDesc/Prod.vUnCom)*100)/AuxQuantCal
               else auxPerDesc := 0;

               auxVlrPIS    := Imposto.PIS.vPIS/AuxQuantCal;
               auxVlrCOFINS := Imposto.COFINS.vCOFINS/AuxQuantCal;
               auxVlrICMS   := Imposto.ICMS.vICMS/AuxQuantCal;
               auxVlrST     := Imposto.ICMS.vICMSST/AuxQuantCal; // Valor total no item do ICMSST dividido pela quantidade daquele item

               if Prod.CFOP <> '' then
               begin
                  if (Copy(Prod.CFOP,1,1) = '6') then
                       auxCFOP := StrToInt('2' + Copy(Prod.CFOP,2,3))
                  else if Copy(Prod.CFOP,1,1) = '5' then
                       auxCFOP := StrToInt('1' + Copy(Prod.CFOP,2,3))
                  else auxCFOP := StrToInt(Prod.CFOP);
               end
               else auxCFOP := 0;

               if Prod.med.Count > 0 then
               begin
                  auxVlrPMC := Prod.med.Items[0].vPMC;
                  auxVlrVendaSuger := Prod.med.Items[0].vPMC;
                  if (Length(Prod.med.Items[0].cProdANVISA) = 13) and (IsNumeric(Prod.med.Items[0].cProdANVISA)) and
                     (Copy(Prod.med.Items[0].cProdANVISA,1,1) = '1') then
                       auxRegMS := StrToInt64(Prod.med.Items[0].cProdANVISA)
                  else auxRegMS := 0;
               end else
               begin
                  auxVlrPMC := QueProd.FieldByName('PrecoPMC').AsFloat;
                  auxVlrUniTot := (Prod.vUnCom - auxVlrDesc) + auxVlrST + auxVlrOutIte + auxVlrIPI;
                  auxRegMS  := 0;
               end; //if

               // Cálculo do preço de venda sugerido
               if auxVlrVendaSuger = 0 then
               begin
                  auxValor := (auxVlruni - auxVlrDesc) + auxVlrST + auxVlrOutIte + auxVlrIPI;
                  auxVlrVendaSuger := ((auxValor * auxVlrPerMar) / 100) + auxValor;
               end;

               // Pega o código do CST do XML da nota fiscal
               auxCodCST := CSTICMSToStr(ACBrNFe.NotasFiscais.Items[0].NFe.Det.Items[I].Imposto.ICMS.CST);

               // Pega o código da origem da mercadoria que vem no XML da nota fiscal
               auxOrigem := OrigToStr(Imposto.ICMS.orig);
               auxVlrTot := (auxVlruni - auxVlrDesc)+auxVlrST + auxVlrOutIte + auxVlrIPI;

               // Pega o preço de compra atual
               auxVlrPreCom := auxVlrTot;
               auxVlrTot := AuxQuantCal * auxVlrTot;

               // Pega o percentual da variação do preço de venda atual com o preço de venda sugerido.
               if auxVlrPreVen > 0 then
                    auxPerVar := ((auxVlrVendaSuger - auxVlrPreVen)/auxVlrPreVen)*100
               else auxPerVar := 100;

               // ----- Cálculo do Custo Médio ---- //
               auxTotCusMedAtu := auxQtdest * auxCustoMed;
               auxVlrTotEst    := auxTotCusMedAtu + (AuxQuantCal * auxVlrPreCom);
               QtdEstAtu       := auxQtdest + AuxQuantCal;
               auxVlrCustoMed  := auxVlrTotEst / QtdEstAtu;
               QueGrava.SQL.Add(
               'INSERT INTO arqcomprarecite (IDRec,IDProd,Totrec,VlrUniNota,Qtdfra,PerDesc,VlrDesc,VlrDescNota,'+
               'Vlruni,VlrTot,PerIPI,VlrIPI,VlrIPINota,VlrPIS,VlrPISNota,VlrCOF,VlrCOFNota,PerICMS,VlrICMS,VlrICMSNota,'+
               'VlrST,VlrSTNota,VlrOut,VlrOutNota,CFOP,IDProdFor,VlrPMC,ProdExist,IdRegMS,CodEAN,CST_ORI,Origem,'+
               'QuantProdConf,DescrProdNota,VlrVendaAtual,VlrPerMargem,VlrVendaSuger,VlrVendaSugerOrig,VlrPerVariacao,VlrPreComp,'+
               'VlrUltPreComp,IdFabr,PrecoFab,VlrCustoMed) VALUES ('+
               auxIDRec.ToString+','+
               auxIDProd.ToString+','+
               FormatDouble(Prod.qCom,11,4)+','+
               FormatDouble(auxVlruniNota,11,4)+','+
               FormatDouble(AuxQtdFrac,11,4)+','+
               FormatDouble(auxPerDesc,11,4)+','+
               FormatDouble(auxVlrDesc,11,4)+','+
               FormatDouble(auxVlrDescNota,11,4)+','+
               FormatDouble(auxVlruni,11,4)+','+
               FormatDouble(auxVlrTot,11,4)+','+
               FormatDouble(Imposto.IPI.pIPI,11,4)+','+
               FormatDouble(auxVlrIPI,11,4)+','+
               FormatDouble(auxVlrIPINota,11,4)+','+
               FormatDouble(auxVlrPIS,11,4)+','+
               FormatDouble(auxVlrPISNota,11,4)+','+
               FormatDouble(auxVlrCOFINS,11,4)+','+
               FormatDouble(auxVlrCOFINSNota,11,4)+','+
               FormatDouble(Imposto.ICMS.pICMS,11,4)+','+
               FormatDouble(auxVlrICMS,11,4)+','+
               FormatDouble(auxVlrICMSNota,11,4)+','+
               FormatDouble(auxVlrST,11,4)+','+
               FormatDouble(auxVlrSTNota,11,4)+','+
               FormatDouble(auxVlrOutIte,11,4)+','+
               FormatDouble(auxVlrOutIteNotas,11,4)+','+
               auxCFOP.ToString+','+
               Aspas(Prod.cProd)+','+
               FormatDouble(auxVlrPMC,11,2)+','+
               Aspas(auxProdExist)+','+
               auxRegMS.ToString+','+
               Aspas(Prod.cEAN)+','+
               Aspas(auxCodCST)+','+
               Aspas(auxOrigem)+','+
               FormatDouble(AuxQuantConf,11,4)+','+
               Aspas(Prod.xProd)+','+
               FormatDouble(auxVlrPreVen,11,4)+','+
               FormatDouble(auxVlrPerMar,11,4)+','+
               FormatDouble(auxVlrVendaSuger,11,4)+','+
               FormatDouble(auxVlrVendaSuger,11,4)+','+
               FormatDouble(auxPerVar,11,4)+','+
               FormatDouble(auxVlrPreCom,11,4)+','+
               FormatDouble(auxVlrUltPreCom,11,4)+','+
               Aspas(IntToStr(auxIdFabr))+','+
               FormatDouble(auxPrecoFab,11,4)+','+
               FormatDouble(auxVlrCustoMed,11,4)+');');
            end; //with
            Inc(AuxQtdIte);
         end; //for

         if not QueGrava.SQL.Text.Trim.IsEmpty then
         begin
            try
               QueGrava.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar TabCompRecIt em uCompRec -> '+E.Message);
                  MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
                  Result := False;
                  Exit;
               end;
            end;
         end
         else raise Exception.Create('Não há itens hà nessa NF');

         TabCompRecIt.Close;
         TabCompRecIt.SQL.Text := 'SELECT REC.*,PRO.Despro,PRO.QtdFrac,PRO.ClasTera FROM arqcomprarecite REC ' +
         'LEFT JOIN arqproduto PRO ON REC.IDProd = PRO.IDProd WHERE REC.IDRec = '+ auxIDRec.ToString;
         TabCompRecIt.Open;

         // -----  Tabela da Precificação ----- //
         QuePreco.SQL.Text := 'SELECT REC.*,PRO.Despro,PRO.QtdFrac,PRO.ClasTera,PES.Nompes FROM arqcomprarecite REC ' +
         'LEFT JOIN arqproduto PRO ON REC.IDProd = PRO.IDProd LEFT JOIN arqpessoa PES ON REC.IDFabr = PES.IDPess '+
         'WHERE REC.IDRec = '+auxIDRec.ToString;
         QuePreco.Open;

         QueGrava.SQL.Clear;
         QueGrava.Close;
         TabCompRecLot.DisableControls;
         for I := 0 to ACBrNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do
         begin
            Inc(auxNroIte);
            with ACBrNFe.NotasFiscais.Items[0].NFe.Det.Items[I] do
            begin
               if Prod.cEAN.Trim <> '' then
               begin
                  if not QueProd.Locate('CodEANPri',Prod.cEAN,[]) then
                  begin
                     if not QueProd.Locate('CodEAN',Prod.cEAN,[]) then
                          auxIDProd := 0
                     else auxIDProd := QueProd.FieldByName('IDProd').AsInteger;
                  end
                  else auxIDProd := QueProd.FieldByName('IDProd').AsInteger;
               end //if
               else auxIDProd := 0;

               if Prod.rastro.Count > 0 then
               begin
                  for Lot := 0 to Prod.rastro.Count - 1 do
                  begin
                     if TabCompRecIt.Locate('IDRec;IDProd', VarArrayOf([auxIDRec,auxIDProd]), []) then
                     begin
                        if Prod.med.Count > 0 then
                        begin
                           if (Length(Prod.med.Items[Lot].cProdANVISA) = 13) and (IsNumeric(Prod.med.Items[Lot].cProdANVISA)) and
                              (Copy(Prod.med.Items[Lot].cProdANVISA,1,1) = '1') then
                              auxRegMS := StrToInt64(Prod.med.Items[Lot].cProdANVISA)
                           else auxRegMS := 0;
                        end
                        else auxRegMS := 0;
                        if auxQtdFrac > 0 then
                             AuxQuantCal := auxQtdFrac * Prod.rastro.Items[Lot].qLote
                        else AuxQuantCal := Prod.rastro.Items[Lot].qLote;
                        QueGrava.SQL.Add('INSERT INTO arqcomprareclot (IDRec,Nroite,IDProd,Nrolot,Datfab,Datven,IdRegMS,cAgreg,Qtdrec,QtdRecFab) VALUES ('+
                        AuxIDRec.ToString +','+
                        auxNroIte.ToString+','+
                        auxIDProd.ToString+','+
                        Aspas(Prod.rastro.Items[Lot].nLote)+','+
                        Aspas(FormatDateTime('yyyy-mm-dd',Prod.rastro.Items[Lot].dFab))+','+
                        Aspas(FormatDateTime('yyyy-mm-dd',Prod.rastro.Items[Lot].dVal))+','+
                        auxRegMS.ToString+','+
                        Aspas(Prod.rastro.Items[Lot].cAgreg)+','+
                        FormatDouble(AuxQuantCal,11,2)+','+
                        FormatDouble(AuxQuantCal,11,2)+'); ');
                     end; //if
                  end; //for
               end else
               begin
                  if TabCompRecIt.Locate('IDRec;IDProd', VarArrayOf([auxIDRec,auxIDProd]), []) then
                  begin
                     if auxQtdFrac > 0 then
                          AuxQuantCal := auxQtdFrac * Prod.qCom
                     else AuxQuantCal := Prod.qCom;
                     QueGrava.SQL.Add('INSERT INTO arqcomprareclot (IDRec,Nroite,IDProd,Nrolot,Qtdrec,QtdRecFab) VALUES ('+
                     AuxIDRec.ToString+','+
                     auxNroIte.ToString+','+
                     auxIDProd.ToString+','+
                     Aspas('UNICO')+','+
                     FormatDouble(AuxQuantCal,11,2)+','+
                     FormatDouble(AuxQuantCal,11,2)+'); ');
                  end; //if
               end; //if
            end; //with
         end; //for

         // ---- Grava Lotes dos Itens ------ //
         try
            QueGrava.ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar TabCompRecLot em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
               Result := False;
               Exit;
            end;
         end; //try
         TabCompRecLot.Close;
         TabCompRecLot.SQL.Text := 'SELECT * FROM arqcomprareclot WHERE IDRec = '+auxIDRec.ToString;
         TabCompRecLot.Open;

         // ------ Grava Titulos da NF do XML ------ //
         for I := 0 to ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Count-1 do
         begin
            try
               QueGrava.SQL.Clear;
               QueGrava.Close;
               QueGrava.SQL.Text := 'INSERT INTO arqtitulotemp (IDPess,NotFis,NroSerie,Nrotit,Destit,'+
               'PagRec,IDTiptit,Datemi,Datven,DesAsso,Vlrtit,Saltit,IDFilial,IDNatFin,IDConv) VALUES ('+
               auxIDPess.ToString+','+
               Aspas(IntToStr(ACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF))+','+
               Aspas(IntToStr(ACBrNFe.NotasFiscais.Items[0].NFe.Ide.serie))+','+
               ASpas(ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Fat.nFat)+','+
               ASpas(Format('%3.3d',[StrToInt(ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[I].nDup)]))+','+
               Aspas('P')+','+
               Aspas('2')+','+ // Boleto de outro banco
               Aspas(FormatDateTime('yyyy-mm-dd',ACBrNFe.NotasFiscais.Items[0].NFe.Ide.dEmi))+','+
               Aspas(FormatDateTime('yyyy-mm-dd',ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[I].dVenc))+','+
               Aspas('0')+','+
               FormatDouble(ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[I].vDup,11,2)+','+
               FormatDouble(ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[I].vDup,11,2)+','+
               auxIDFil.ToString+','+
               auxIDNatfin.ToString+','+
               auxIDConv.ToString+'); ';
               QueGrava.SQL.Add('SELECT LAST_INSERT_ID() AS ULT_IDTit;');
               QueGrava.Open;
               auxIDTit :=  QueGrava.FieldByName('ULT_IDTit').AsInteger;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar TabTituloTemp em uCompRec -> '+E.Message);
                  MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
                  Result := False;
                  Exit;
               end;
            end; //try
            try
               QueAuxi.SQL.Clear;
               QueAuxi.Close;
               auxNrotit := ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Fat.nFat;
               QueAuxi.SQL.Text := 'INSERT INTO arqtitulorattemp (IDTitu,IDNatFin,OrigTitu,ValorRat,RatFixo) VALUES (' +
               auxIDTit.ToString+','+
               auxIDNatfin.ToString+','+
               Aspas('1')+','+
               FormatDouble(ACBrNFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[I].vDup,11,2)+','+
               Aspas('0')+')';
               QueAuxi.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar TabTituloTemp em uCompRec -> '+E.Message);
                  MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
                  Result := False;
                  Exit;
               end;
            end;
         end; //for
      except
         on E:Exception do
         begin
            MostraMsg('Erro','Não foi possível continuar com a entrada. '+E.Message,mtError, [mbOK]);
            Exit;
         end;
      end;

      // ---- Muda o Status da NFe na Tabela de Manifestação ---- //
      try
         QueGrava.Close;
         QueGrava.SQL.Text := 'UPDATE arqmandest SET StatusNFE = '+Aspas('2')+
         ' WHERE IDFilial = '+auxIDFil.ToString+' AND CNPJCPFFor = '+Aspas(auxCNPJCPF)+
         ' AND NotFis = '+auxNroNFe.ToString+' AND NroSerie = '+auxNroSerie.ToString;
         QueGrava.ExecSQL(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível gravar as alterações na tabela arqmandest do status da NFe (uCompRec) -> '+E.Message);
            MostraMsg('Erro','Não foi possível gravar as alterações.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
   finally
      ACBrNFe.Free;
      QueAuxi.Close;      FreeAndNil(QueAuxi);
      QueProd.Close;      FreeAndNil(QueProd);
      QueProdNFe.Close;   FreeAndNil(QueProdNFe);
      QueGrava.Close;     FreeAndNil(QueGrava);
      QueComp.Close;      FreeAndNil(QueComp);
      TabCompRec.EnableControls;
      TabCompRecIt.EnableControls;
      TabCompRecLot.EnableControls;
      HideWait;
   end;
   edNroIte.Text := AuxQtdIte.ToString;
   Result := True;
   AjustaGrid;
end;

procedure TFrmCompEnt.edCodCFOPExit(Sender: TObject);
begin
   btSalvaIte.Click;
end;

procedure TFrmCompEnt.ParamColCon;
var
   QueFili,QuePess:TRESTDWClientSQL;
   AuxEstFil,AuxEstFor:String;
begin
   QueFili := TRESTDWClientSQL.Create(nil);
   QuePess := TRESTDWClientSQL.Create(nil);
   QueFili.DataBase := DM.DWDataBase;
   QuePess.DataBase := DM.DWDataBase;
   try
      QueFili.SQL.Text := 'SELECT MUN.Estmun FROM arqfilial FIL '+
      'LEFT JOIN arqmuni MUN ON FIL.Codmun = MUN.Codmun WHERE FIL.IDFilial = '+auxIDFil.ToString;
      QueFili.Open;
      AuxEstFil := QueFili.FieldByName('Estmun').AsString;

      QuePess.SQL.Text := 'SELECT MUN.Estmun FROM arqpessoa PES ' +
      'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun WHERE PES.IDPess = '+TabCompRecIDPess.AsString;
      QuePess.Open;
      AuxEstFor := QuePess.FieldByName('Estmun').AsString;
      if AuxEstFil = AuxEstFor then
      begin
         if MatchStr(TabCompRecItCST_ORI.AsString.Trim, ['10','30','60','70']) then
              auxCol := 'CFOP_EST_ST'
         else auxCol := 'CFOP_EST';
      end else
      begin
         if MatchStr(TabCompRecItCST_ORI.AsString.Trim, ['10','30','60','70']) then
              auxCol := 'CFOP_INT_ST'
         else auxCol := 'CFOP_INT';
      end; //if
      if MatchStr(TabCompRecItCST_ORI.AsString.Trim, ['101','102','103','300','400','900']) then
         auxCol := 'CFOP_EST'
      else
      if MatchStr(TabCompRecItCST_ORI.AsString.Trim, ['201','202','203','500']) then
         auxCol := 'CFOP_EST_ST';
   finally
      QueFili.Close;
      QuePess.Close;
      FreeAndNil(QueFili);
      FreeAndNil(QuePess);
   end;// try
end;

procedure TFrmCompEnt.KeyStrCancel(Sender: TObject; var Key: Char);
begin
   if ExisteStr(Key) then Key := #0;
end;

procedure TFrmCompEnt.GravaDadosCFOP;
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET CFOP = '+TabCompRecItCFOP.ToString+
         ' WHERE IDRec = '+TabCompRecItIDRec.AsString+' AND Nroite = '+TabCompRecItNroite.AsString+
         ' AND IDProd = ' +TabCompRecItIDProd.AsString;
         QueAuxi.ExecSQL(vErro);
      except // try
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar o CFOP do produto na entrada da nota TabCompRecIt em uCompRec -> '+E.Message);
            MostraMsg('Erro','Não foi possível gravar a alteração do CFOP do produto.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
      TabCompRecIt.Close;
      TabCompRecIt.Open;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmCompEnt.edCFOPCustomButtons0Click(Sender: TObject; index: Integer);
var
   Filtro:String;
begin
   if not TabCompRecIt.IsEmpty then
   begin
      ParamColCon;
      Filtro := 'EntSai = '+Aspas('E')+'AND AlteraEnt = '+ Aspas('1');
      btBuscasDB(TabCompRecIt,'arqcfop',TDBEdit(edCFOP),'IDCFOP','IDCFOP',auxCol,auxCol,Filtro,0);
      if (auxCol = 'CFOP_EST') and (TabCompRecItCFOP_EST.AsInteger > 0) then
      begin
         TabCompRecItCFOP.AsInteger     := TabCompRecItCFOP_EST.AsInteger;
         TabCompRecItCFOP_EST.AsInteger := 0;
         GravaDadosCFOP;
      end
      else if (auxCol = 'CFOP_EST_ST') and (TabCompRecItCFOP_EST_ST.AsInteger > 0) then
      begin
         TabCompRecItCFOP.AsInteger        := TabCompRecItCFOP_EST_ST.AsInteger;
         TabCompRecItCFOP_EST_ST.AsInteger := 0;
         GravaDadosCFOP;
      end
      else if (auxCol = 'CFOP_INT') and (TabCompRecItCFOP_INT.AsInteger > 0) then
      begin
         TabCompRecItCFOP.AsInteger     := TabCompRecItCFOP_INT.AsInteger;
         TabCompRecItCFOP_INT.AsInteger := 0;
         GravaDadosCFOP;
      end
      else if (auxCol = 'CFOP_INT_ST') and (TabCompRecItCFOP_INT_ST.AsInteger > 0) then
      begin
         TabCompRecItCFOP.AsInteger        := TabCompRecItCFOP_INT_ST.AsInteger;
         TabCompRecItCFOP_INT_ST.AsInteger := 0;
         GravaDadosCFOP;
      end; // if
   end;// if
end;

procedure TFrmCompEnt.edCSTCSOSNCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if not TabCompRecIt.IsEmpty then
      btBuscasDB(TabCompRecIt,'arqcstcsosn',TDBEdit(edCSTCSOSN),'CST_CSOSN','CST_CSOSN','CST_CSOSN','CST_CSOSN','',0);
end;

procedure TFrmCompEnt.edCSTCSOSNKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (not TabCompRecIt.IsEmpty) and (Key <> VK_RETURN) then
      btBuscasDB(TabCompRecIt,'arqcstcsosn',TDBEdit(edCSTCSOSN),'CST_CSOSN','CST_CSOSN','CST_CSOSN','CST_CSOSN','',Key);
end;

procedure TFrmCompEnt.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if IsValidEANCode(edCodpro.Text) then
        CadProdutos(edCodpro.Text,'','')
   else CadProdutos('','','');
end;

procedure TFrmCompEnt.edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
var
   auxRecIDPess:Integer;
begin
   Self.AlphaBlendValue := 165;
   Application.CreateForm(TFrmPesCad, FrmPesCad);
   try
      if TabCompRecIDPess.AsInteger > 0 then
           FrmPesCad.recIDPess := TabCompRecIDPess.AsInteger
      else FrmPesCad.recIDPess := 0;
      CentralizarControl(FrmPesCad, FrmCompEnt);
      FrmPesCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxRecIDPess := FrmPesCad.recIDPess;
      FrmPesCad := nil;
   end;// try
end;

function TFrmCompEnt.CadProdutos(recCodEAN,recDespro,recCodProFor:String):Boolean;
var
   auxRecIDProd:Integer;
   QueProd:TRESTDWClientSQL;
begin
   Result := False;
   Self.AlphaBlendValue := 165;
   Application.CreateForm(TFrmProdCad, FrmProdCad);
   try
      if recCodProFor <> '' then
           FrmProdCad.recIDProd := StrToInt(recCodProFor)
      else FrmProdCad.recIDProd := 0;
      FrmProdCad.recValor  := recCodEAN;
      FrmProdCad.recOrigem := 'REC';
      FrmProdCad.recDespro := recDespro;
      CentralizarControl(FrmProdCad, FrmCompEnt);
      FrmProdCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxRecIDProd := FrmProdCad.recIDProd;
      FrmProdCad   := nil;
   end;// try
   QueProd := TRESTDWClientSQL.Create(nil);
   try
      QueProd.DataBase := DM.DWDataBase;
      QueProd.SQL.Text := 'SELECT * FROM arqproduto WHERE IDProd = '+auxRecIDProd.ToString;
      QueProd.Open;
      if QueProd.IsEmpty then
      begin
         if QueProd.IsEmpty then
              Result := False
         else Result := True;
      end; //if
   finally
      QueProd.Close;
      FreeAndNil(QueProd);
   end; //try
end;

procedure TFrmCompEnt.edPerICMKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then btSalvaIte.Click;
end;

procedure TFrmCompEnt.LMDLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmCompEnt.PanelItMouseEnter(Sender: TObject);
begin
   TLMDSimplePanel(Sender).Color := $00FEF1E9;
end;

procedure TFrmCompEnt.PanelItMouseExit(Sender: TObject);
begin
   TLMDSimplePanel(Sender).Color := clWhite;
end;

procedure TFrmCompEnt.btPrecificarClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabCompRecIt.IsEmpty then
   begin
      MostraMsg('Aviso','Pedido incompleto, não há itens!',mtWarning, [mbOk]);
      Exit;
   end;
   try
      FrmCompRecPre := TFrmCompRecPre.Create(Application);
      CentralizarControl(FrmCompRecPre, Self);
      FrmCompRecPre.recItIDRec := TabCompRecItIDRec.AsInteger;
      FrmCompRecPre.ShowModal;
   finally
      FreeAndNil(FrmCompRecPre);
   end;
end;

// -------------- Botão de Produtos --------------- //
procedure TFrmCompEnt.btProdutosClick(Sender: TObject);
var
   auxVlrPerMar:Double;
   auxRecIDProd:Integer;
   auxPos: TBookmark;
   auxIDProd,auxIDFabr:integer;
   auxVlrVenSur:Double;
   QueProd,QueAuxi:TRESTDWClientSQL;
begin
   if TabCompRecIt.IsEmpty then
   begin
      MostraMsg('Aviso','Pedido incompleto, não há itens!',mtWarning, [mbOk]);
      Exit;
   end;
   auxPos    := TabCompRecIt.GetBookmark;
   auxIDProd := TabCompRecItIDProd.AsInteger;
   try
      Application.CreateForm(TFrmProdCad, FrmProdCad);
      if TabCompRecItIDProd.AsString <> '' then
           FrmProdCad.recIDProd := StrToInt(TabCompRecItIDProd.AsString)
      else FrmProdCad.recIDProd := 0;
      FrmProdCad.recValor  := TabCompRecItCodEAN.AsString;
      FrmProdCad.recOrigem := 'REC';
      if TabCompRecItIDProd.AsInteger > 0 then
           FrmProdCad.recDespro := TabCompRecItDespro.AsString
      else FrmProdCad.recDespro := TabCompRecItDescrProdNota.AsString;
      CentralizarControl(FrmProdCad, FrmCompEnt);
      Self.AlphaBlendValue := 155;
      FrmProdCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxRecIDProd := FrmProdCad.recIDProd;
      FrmProdCad   := nil;
   end; // try

   ShowWait('Aguarde...', Self);
   QueProd := TRESTDWClientSQL.Create(nil);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueProd.DataBase := DM.DWDataBase;
      QueAuxi.DataBase := DM.DWDataBase;
      QueProd.SQL.Text := 'SELECT * FROM arqproduto WHERE IDProd = '+auxRecIDProd.ToString;
      QueProd.Open;
      if QueProd.RecordCount > 0 then
      begin
         auxVlrPerMar := QueProd.FieldByName('Markup').AsFloat;
         // --- Grava o valor de venda sugerido, quando volta do cadastro do produto e é um produto novo.
         if auxIDProd = 0 then
         begin
            if TabCompRecItVlrPMC.AsFloat = 0 then
               auxVlrVenSur := (TabCompRecItVlrUniFinCalc.AsFloat * auxVlrPerMar / 100)+TabCompRecItVlrUniFinCalc.AsFloat
            else  auxVlrVenSur := TabCompRecItVlrPMC.AsFloat;
         end
         else auxVlrVenSur := TabCompRecItVlrVendaSuger.AsFloat;

         // --- Quando volta do cadastro de produto e não foi informado fabricante --- //
         try
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET '+
            'IDProd = '       +QueProd.FieldByName('IDProd').AsString+','+
            'ProdExist = '    +Aspas('1')+','+
            'IDFabr = '       +iif(QueProd.FieldByName('IDFabr').AsInteger <= 0, '0', QueProd.FieldByName('IDFabr').AsString)+','+
            'QtdFra = '       +FormatDouble(QueProd.FieldByName('QtdFrac').AsFloat,9,2)+','+
            'VlrPerMargem = ' +FormatDouble(auxVlrPerMar,11,2)+','+
            'VlrVendaAtual = '+FormatDouble(QueProd.FieldByName('PrecoVen').AsFloat,11,2)+','+
            'PrecoFab = '     +FormatDouble(QueProd.FieldByName('PrecoFab').AsFloat,11,2)+','+
            'VlrVendaSuger = '+FormatDouble(auxVlrVenSur,11,4)+' '+
            'WHERE IDRec = '  +TabCompRecItIDRec.AsString+' AND Nroite = '  +TabCompRecItNroite.AsString;
            QueAuxi.ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar as alterações em TabCompRecIt em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar as alterações.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;// if
         end; //try
         try
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'UPDATE arqcomprareclot SET IDProd = '+QueProd.FieldByName('IDProd').AsString+
            ' WHERE IDRec = '+TabCompRecItIDRec.AsString+' AND Nroite = '+TabCompRecItNroite.AsString;
            QueAuxi.ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar as alterações em TabCompRecLot em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar as alterações.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;// if
         end; //try
      end;// if
      if TabCompRecItQtdfra.AsFloat <> QueProd.FieldByName('QtdFrac').AsFloat then
         GravaDadosFra(TabCompRecItQtdfra.AsFloat,0)
      else
      begin
         TabCompRecIt.Close;
         TabCompRecIt.Open;
      end;// if
   finally
      QueAuxi.Close;
      QueProd.Close;
      FreeAndNil(QueProd);
      FreeAndNil(QueAuxi);
      HideWait;
   end;// try
   TabCompRecIt.GotoBookmark(auxPos);
   TabCompRecIt.FreeBookmark(auxPos);
end;

// ---------------- Calcula o Custo Médio ----------------- //
function TFrmCompEnt.RecalCustoMed(recIDProd:Integer):Boolean;
var
   auxPrecoVen:String;
   QueAuxi,QueIncl:TRESTDWClientSQL;
   QtdEstAtu,CusMedAtu,QtdEntra,PreEntra,VlrEstAtu,VlrEntra,TotalQtd,QtdSaida,auxPrecoFab:Double;
begin
   Result      := False;
   QtdEstAtu   := 0;
   TotalQtd    := 0;
   CusMedAtu   := 0;
   QtdSaida    := 0;
   auxPrecoFab := 0;
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueIncl.DataBase := DM.DWDataBase;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT CusMedOri FROM arqproduto WHERE IDProd = '+recIDProd.ToString;
         QueAuxi.Open;
         CusMedAtu := QueAuxi.FieldByName('CusMedOri').AsFloat;
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT LOT.Qtdrec AS QtdEntra, ITE.Vlruni AS PreEntra FROM arqcomprareclot LOT '+
         'LEFT JOIN arqcomprarecite ITE ON LOT.IDRec = ITE.IDRec LEFT JOIN arqcomprarec REC ON LOT.IDRec = REC.IDRec '+
         'WHERE LOT.IDProd = ' + recIDProd.ToString+' ORDER BY REC.DatRece ASC';
         QueAuxi.Open;
         while not QueAuxi.Eof do
         begin
            QtdEntra := QueAuxi.FieldByName('QtdEntra').AsFloat;
            PreEntra := QueAuxi.FieldByName('PreEntra').AsFloat;
            VlrEntra := QtdEntra * PreEntra;
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT SUM(ITE.Qtdped) AS QtdSaida FROM arqpedidoite ITE ' +
            'LEFT JOIN arqpedido PED ON ITE.IDPed = PED.IDPed WHERE ITE.IDProd = '+recIDProd.ToString+' '+
            'AND PED.Datped <= (SELECT REC.DatRece FROM arqcomprarec REC WHERE REC.IDRec = '+recIDRec.ToString+') '+
            'AND ITE.IdFilial = PED.IdFilial';
            QueAuxi.Open;
            QtdSaida := QueAuxi.FieldByName('QtdSaida').AsFloat;
            QueAuxi.Close;
            TotalQtd  := TotalQtd + QtdEntra - QtdSaida;
            VlrEstAtu := (TotalQtd * CusMedAtu) + VlrEntra;
            if TotalQtd > 0 then
                 CusMedAtu := VlrEstAtu / TotalQtd
            else CusMedAtu := 0.00;
            QueAuxi.Next;
         end; //while
//       auxPrecoFab := RoundX(edTotItem.AsFloat / edTotQuantRec.AsInteger,2);
         QueAuxi.SQL.Text := 'UPDATE arqproduto SET CustoMed = '+FormatDouble(CusMedAtu,9,2)+' WHERE IDProd = '+recIDProd.ToString+';';
         QueAuxi.SQL.Add('UPDATE arqproduto SET PrecoFab = '+FormatDouble(auxPrecoFab,9,2)  +' WHERE IDProd = '+recIDProd.ToString+' AND TipoPre != "1";');
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then raise Exception.Create(vErro);
         QueAuxi.SQL.Text := 'UPDATE arqproduto SET PrecoVen = CASE WHEN Markup > 0.00 THEN PrecoFab + ROUND(PrecoFab * (Markup/100),2) ELSE PrecoFab END WHERE IDProd = '+recIDProd.ToString;
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then raise Exception.Create(vErro);
         // ----- Atualiza Preço em Promoção no Caso de Alteração do Preço de Fábrica ---- //
         QueIncl.SQL.Clear;
         QueAuxi.SQL.Text := 'SELECT PRP.IDProm,PRP.IDProd,PRO.PrecoVen FROM arqpromocao PRM LEFT JOIN '+
         'arqpromopro PRP ON PRM.IDProm = PRP.IDProm LEFT JOIN arqproduto PRO ON PRP.IDProd = PRO.IDProd '+
         'WHERE Date(NOW()) BETWEEN PRM.DataON AND PRM.DataOFF AND NOT PRM.ManPre';
         QueAuxi.Open;
         while not QueAuxi.Eof do
         begin
            auxPrecoVen := FormatDouble(QueAuxi.FieldByName('PrecoVen').AsFloat,9,2);
            QueIncl.SQL.Add(
            'UPDATE arqpromopro PRP SET PrePromo = '+auxPrecoVen+' - ('+auxPrecoVen+' * (IF(PerDesIA > 0.00,PerDesIA,PerDesMan) / 100)) '+
            'WHERE PRP.IDProm = '+QueAuxi.FieldByName('IDProm').AsString+' AND IDProd = '+QueAuxi.FieldByName('IDProd').AsString+';');
            QueAuxi.Next;
         end; //while
         if QueIncl.SQL.Text.Trim <> '' then
         begin
            QueIncl.ExecSQL(vErro);
            if vErro <> '' then raise Exception.Create(vErro);
         end;// if
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar atualizar custo médio/preço fábrica: uCompRec -> '+E.Message);
            MostraMsg('Erro','Não foi possível realizar o recebimento. '+E.Message, mtError, [mbOk]);
            Exit;
         end;
      end;// try
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueIncl);
   end;// try
end;

procedure TFrmCompEnt.btImprimeClick(Sender: TObject);
begin
   if TabCompRecIt.IsEmpty then
   begin
      MostraMsg('Aviso','Pedido incompleto, não há itens!',mtWarning, [mbOk]);
      Exit;
   end;
   //--> À DESENVOLVER
end;

procedure TFrmCompEnt.HabilBotoes(Botoes:Boolean;Panel:Integer);
begin
   PanelCabecalho.Enabled := Botoes;
   PanelRodape.Enabled    := Botoes;
end;

procedure TFrmCompEnt.btNovoClick(Sender: TObject);
begin
   btNovo.SetFocus;
   TabCompRec.Close;
   TabCompRecIt.Close;
   TabCompRecLot.Close;
   edNroIte.Text := '';
   auxTotRateio  := 0;
   auxQtdFra     := 0;
   timTipRecTimer(Sender);
end;

// ------------------ Verifica se Há Pendèncias ------------------ //
procedure TFrmCompEnt.edPendenciasClick(Sender: TObject);
var
   auxIDRec:Integer;
   QueAuxi,QueGrava:TRESTDWClientSQL;
begin
   edPendencias.SetFocus;
   TabCompRec.Close;
   TabCompRecIt.Close;
   TabCompRecLot.Close;
   edNroIte.Text := '';
   auxTotRateio  := 0;
   auxQtdFra     := 0;
   try
      Self.AlphaBlendValue := 165;
      Application.CreateForm(TFrmNotasPendEnt, FrmNotasPendEnt);
      CentralizarControl(FrmNotasPendEnt, PanelPri);
      FrmNotasPendEnt.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxIDRec := FrmNotasPendEnt.recIDRec;
      FrmNotasPendEnt := nil;
   end;

   if auxIDRec > 0 then
   begin
      ShowWait('Aguarde...', Self);
      QueAuxi  := TRESTDWClientSQL.Create(nil);
      QueGrava := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase  := DM.DWDataBase;
      QueGrava.DataBase := DM.DWDataBase;
      try
         // ---- Carrega o cabeçalho da nota fiscal ----- //
         try
            TabCompRec.Close;
            TabCompRec.SQL.Text := 'SELECT REC.*,PES.Nompes,FIL.Nomfil FROM arqcomprarec REC LEFT JOIN ' +
            'arqpessoa PES ON REC.IDPess = PES.IDPess LEFT JOIN arqfilial FIL ON REC.IDFilial = FIL.IDFilial ' +
            'WHERE REC.IDRec = '+auxIDRec.ToString;
            TabCompRec.Open;
         except
            on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível abrir o cabeçalho da nota selecionada.', mtError, [mbOk]);
               Exit;
            end;
         end;

         try
            TabCompRecIt.Close;
            TabCompRecIt.SQL.Clear;
            TabCompRecIt.SQL.Text := 'SELECT REC.*,PRO.Despro,PRO.QtdFrac,PRO.ClasTera FROM arqcomprarecite REC ' +
            'LEFT JOIN arqproduto PRO ON REC.IDProd = PRO.IDProd WHERE REC.IDRec = '+auxIDRec.ToString;
            TabCompRecIt.Open;
            edNroIte.Text := IntToStr(TabCompRecIt.RecordCount); // Número de itens
         except
            on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível abrir os itens da nota selecionada.', mtError, [mbOk]);
               Exit
            end;
         end;

         TabCompRecIt.First;
         while TabCompRecIt.Eof do
         begin
            if TabCompRecItProdExist.AsString = '0' then
            begin
               QueAuxi.SQL.Text := 'SELECT PRO.IDProd,PRO.CodEANPri,EAN.CodEAN FROM arqproduto PRO '+
               'LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd '+
               'WHERE CodEANPri != '' AND (CodEANPri = '+TabCompRecItCodEAN.AsString+' OR CodEAN = '+TabCompRecItCodEAN.AsString+') '+
               'GROUP BY PRO.IDProd';
               QueAuxi.Open;
               if not QueAuxi.IsEmpty then
               begin
                  try
                     QueGrava.SQL.Text := 'UPDATE arqcomprarecite SET ProdExist = 1 WHERE IDRec = '+TabCompRecItIDRec.AsString+
                     ' AND Nroite = ' +TabCompRecItNroite.AsString+' AND IDProd = ' +TabCompRecItIDProd.AsString;
                     QueGrava.ExecSQL(vErro);
                  except
                     on E: Exception do
                     begin
                        SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível alterar se produto cadastrado ou não no carregamento das notas pendentes TabCompRecIt em uCompRec -> '+E.Message);
                        MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtError, [mbOk]);
                        Exit;
                     end;
                  end;
               end;
            end;
            TabCompRecIt.Next;
         end; //while

         // ---- Carrega os lotes dos produtos ligados a nota fiscal ---- //
         try
            TabCompRecLot.Close;
            TabCompRecLot.SQL.Clear;
            TabCompRecLot.SQL.Text := 'SELECT * FROM arqcomprareclot WHERE IDRec = '+auxIDRec.ToString;
            TabCompRecLot.Open;
         except
            on E:Exception do
            begin
               MostraMsg('Erro','Não foi possível abrir os lotes dos produtos da nota selecionada.', mtWarning, [mbOk]);
            end;
         end; //try
      finally
         QueAuxi.Close;
         QueGrava.Close;
         FreeAndNil(QueAuxi);
         FreeAndNil(QueGrava);
         HideWait;
      end;
   end;
end;

procedure TFrmCompEnt.dgProdutoCellClick(Column: TColumn);
begin
   if Column.ID = 19 then
   begin
      if (TabCompRecIDRec.AsInteger > 0) or (TabCompRecItIDProd.AsInteger > 0) then
      begin
         try
            Application.CreateForm(TFrmEntradaLote, FrmEntradaLote);
            FrmEntradaLote.recIDRec  := TabCompRecItIDRec.AsInteger;
            FrmEntradaLote.recNroite := TabCompRecItNroite.AsInteger;
            FrmEntradaLote.recIDProd := TabCompRecItIDProd.AsInteger;
            FrmEntradaLote.recQuant  := TabCompRecItTotrec.AsFloat;
            FrmEntradaLote.ShowModal;
         finally
            FreeAndNil(FrmEntradaLote);
         end;
      end; //if
      dgProduto.SelectedField := TabCompRecItClasTera;
   end; //if
   TabCompRecIt.ApplyUpdates;
end;

procedure TFrmCompEnt.GravaDadosFra(VlrFrac:Double;Origem:Integer);
var
   auxPos:TBookmark;
   QueAuxi,QueItem:TRESTDWClientSQL;
   auxVlrUniNota,auxVlrDescNota,auxVlrIPINota,auxVlrICMSNota,auxVlrSTNota,auxVlrOutNota,auxFra:Double;
   auxVlrUni,auxVlrDesc,auxVlrIPI,auxVlrICMS,auxVlrST,auxVlrOut,auxConferido,auxVlrPreCom,auxVlrVarPre:Double;
   auxVlrUniTot,auxVlrVendaSuger,auxVlrPerMar,AuxQuantLot:Double;
begin
   auxVlrDesc := 0;
   auxVlrST   := 0;
   auxVlrIPI  := 0;
   auxVlrOut  := 0;
   auxVlrICMS := 0;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueItem := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueItem.DataBase := DM.DWDataBase;
      QueItem.SQL.Text := 'SELECT Qtdfra,VlrUniNota,VlrDescNota,VlrIPINota,VlrICMSNota,VlrSTNota,VlrOutNota,VlrPerMargem '+
      'FROM arqcomprarecite WHERE IDRec = '+TabCompRecItIDRec.AsString+' AND '+
      'Nroite = '+TabCompRecItNroite.AsString+' AND IDProd = '+TabCompRecItIDProd.AsString;
      QueItem.Open;
      if QueItem.FieldByName('Qtdfra').AsFloat = VlrFrac then
      begin
         auxPos := TabCompRecIt.GetBookmark;
         TabCompRecIt.Close;
         TabCompRecIt.Open;
         TabCompRecIt.GotoBookmark(auxPos);
         TabCompRecIt.FreeBookmark(auxPos);
         Exit;
      end; //if

      if origem = 0 then // Fração alterada no cadastro de produto
           auxFra := QueItem.FieldByName('Qtdfra').AsFloat
      else auxFra := VlrFrac;

      auxVlrUniNota  := QueItem.FieldByName('VlrUniNota').AsFloat;
      auxVlrDescNota := QueItem.FieldByName('VlrDescNota').AsFloat;
      auxVlrIPINota  := QueItem.FieldByName('VlrIPINota').AsFloat;
      auxVlrICMSNota := QueItem.FieldByName('VlrICMSNota').AsFloat;
      auxVlrSTNota   := QueItem.FieldByName('VlrSTNota').AsFloat;
      auxVlrOutNota  := QueItem.FieldByName('VlrOutNota').AsFloat;
      auxVlrPerMar   := QueItem.FieldByName('VlrPerMargem').AsFloat;
      auxVlrUni      := auxVlrUniNota/auxFra;
      auxConferido   := TabCompRecItTotrec.AsFloat * auxFra;
      if auxVlrDescNota > 0 then auxVlrDesc := auxVlrDescNota/auxConferido;
      if auxVlrIPINota  > 0 then auxVlrIPI  := auxVlrIPINota/auxConferido;
      if auxVlrICMSNota > 0 then auxVlrICMS := auxVlrICMSNota/auxConferido;
      if auxVlrSTNota   > 0 then auxVlrST   := auxVlrSTNota/auxConferido;
      if auxVlrOutNota  > 0 then auxVlrOut  := auxVlrOutNota/auxConferido;

      // ----- Calcula o ultimo preço de compra ----- /
      auxVlrPreCom     := (auxVlrUni - auxVlrDesc) + auxVlrST;
      auxVlrUniTot     := (auxVlrUni - auxVlrDesc) + auxVlrST + auxVlrIPI + auxVlrOut;
      auxVlrVendaSuger := ((auxVlrUniTot * auxVlrPerMar)/100) + auxVlrUniTot;
      if TabCompRecItVlrVendaAtual.AsFloat > 0 then
           auxVlrVarPre := ((auxVlrVendaSuger - TabCompRecItVlrVendaAtual.AsFloat) / TabCompRecItVlrVendaAtual.AsFloat) * 100
      else auxVlrVarPre := 100;

      try
         QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET '+
         'QuantProdConf = '+FormatDouble(auxConferido,11,2)+','+
         'Qtdfra = '+FormatDouble(auxFra,11,2)+','+
         'VlrUni = '+FormatDouble(auxVlrUni,11,4)+','+
         'VlrDesc = '+FormatDouble(auxVlrDesc,11,4)+','+
         'VlrIPI = '+FormatDouble(auxVlrIPI,11,4)+','+
         'VlrICMS = '+FormatDouble(auxVlrICMS,11,4)+','+
         'VlrST = '+FormatDouble(auxVlrST,11,4)+','+
         'VlrOut = '+FormatDouble(auxVlrOut,11,4)+','+
         'VlrPreComp = '+FormatDouble(auxVlrPreCom,11,4)+','+
         'VlrPerVariacao = '+FormatDouble(auxVlrVarPre,11,4)+
         'VlrVendaSuger = '+FormatDouble(auxVlrVendaSuger,11,4)+
         ' WHERE IDRec = '+TabCompRecItIDRec.AsString+
         ' AND Nroite = '+TabCompRecItNroite.AsString+
         ' AND IDProd = '+TabCompRecItIDProd.AsString;
         QueAuxi.ExecSQL(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a fração do produto na entrada da nota TabCompRecIt em uCompRec -> '+E.Message);
            MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;

      TabCompRecLot.Filtered := False;
      TabCompRecLot.Filter   := 'IDRec = '+TabCompRecItIDRec.AsString+' AND Nroite = '+TabCompRecItNroite.AsString+' AND IDProd = '+TabCompRecItIDProd.AsString;
      TabCompRecLot.Filtered := True;
      TabCompRecLot.First;
      while not TabCompRecLot.Eof do
      begin
         AuxQuantLot := TabCompRecLotQtdRecFab.AsFloat * auxFra;
         try
            QueAuxi.SQL.Text := 'UPDATE arqcomprareclot SET Qtdrec = '+FormatDouble(AuxQuantLot,11,2)+
            ' WHERE IDRec = '+TabCompRecItIDRec.AsString+' AND Nroite = '+TabCompRecItNroite.AsString+
            ' AND IDProd = '+TabCompRecItIDProd.AsString+' AND Nrolot = '+Aspas(TabCompRecLotNrolot.AsString);
            QueAuxi.ExecSQL(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a fração do produto no lote arqcomprareclot em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;
         TabCompRecLot.Next;
      end;

      if Origem = 1 then  // Fração alterada no grid do produto
      begin
         try
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'UPDATE arqproduto SET QtdFrac = '+
            FormatDouble(TabCompRecItQtdfra.AsFloat,11,2)+' WHERE IDProd = '+Aspas(IntToStr(TabCompRecItIDProd.AsInteger));
            QueAuxi.ExecSQL(vErro);
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a fração do produto na tabela de arqproduto em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;
      end;
      auxPos := TabCompRecIt.GetBookmark;
      TabCompRecIt.Close;
      TabCompRecIt.Open;
      TabCompRecIt.GotoBookmark(auxPos);
      TabCompRecIt.FreeBookmark(auxPos);
   finally
      QueAuxi.Close;
      QueItem.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueItem);
    end;
end;

procedure TFrmCompEnt.dgProdutoExit(Sender: TObject);
begin
   if TabCompRecIt.Active then TabCompRecIt.ApplyUpdates;
end;

procedure TFrmCompEnt.dgProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (dgProduto.DataSource.DataSet.RecNo = dgProduto.DataSource.DataSet.RecordCount) then Abort;
   if Key in [VK_RETURN,VK_TAB] then TabCompRecIt.ApplyUpdates;
end;

procedure TFrmCompEnt.dgProdutoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if not TabCompRecIt.IsEmpty then
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
        (Sender as TDBGrid).Canvas.Brush.Color := $00E1EBFF;
        (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);

      if Column.ID = 0 then
      begin
         if TabCompRecItProdExist.AsString = '1' then
         begin
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+6, 15);
            dgProduto.Canvas.Brush.Color:= clAqua;
         end
         else DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+6, 16);
      end; //if

      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
      end;

      if Column.Field = TabCompRecItDespro then
      begin
         if TabCompRecItDespro.AsString = '' then
         begin
            dgProduto.Canvas.FillRect(Rect);
            dgProduto.Canvas.TextOut(Rect.Left+3,Rect.Top+5,TabCompRecItDescrProdNota.AsString);
         end;
      end;

      if Column.Field = TabCompRecItClasTera then
      begin
         if TabCompRecItClasTera.AsString = '0' then
         begin
            dgProduto.Canvas.FillRect(Rect);
            dgProduto.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
         end else
         if TabCompRecItClasTera.AsString = '1' then
         begin
            dgProduto.Canvas.FillRect(Rect);
            dgProduto.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'ANTIMICROBIANO');
         end else
         if TabCompRecItClasTera.AsString = '2' then
         begin
            dgProduto.Canvas.FillRect(Rect);
            dgProduto.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'PSICOTRÓPICO');
         end;
      end; //if

      if Column.ID = 19 then
      begin
         DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+12, Rect.Top+5, 24);
         dgProduto.Canvas.Brush.Color:= clAqua;
      end;
   end else
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
        (Sender as TDBGrid).Canvas.Brush.Color := $00FDF2EC;
        (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmCompEnt.TabCompRecItAfterOpen(DataSet: TDataSet);
begin
   AjustaGrid;
end;

procedure TFrmCompEnt.TabCompRecItAfterPost(DataSet: TDataSet);
begin
   GravaDadosFra(TabCompRecItQtdfra.AsFloat,1);
end;

procedure TFrmCompEnt.TabCompRecItCalcFields(DataSet: TDataSet);
begin
   TabCompRecItVlrUniFinCalc.Value := (TabCompRecItVlruni.AsFloat - TabCompRecItVlrDesc.AsFloat)+TabCompRecItVlrST.AsFloat+TabCompRecItVlrIPI.AsFloat+TabCompRecItVlrOut.AsFloat;
   TabCompRecItTotIteRecCalc.Value := TabCompRecItTotrec.AsFloat * TabCompRecItVlrUniFinCalc.Value;
end;

procedure TFrmCompEnt.btTitulosClick(Sender: TObject);
begin
   if TabCompRecIt.IsEmpty then
   begin
      MostraMsg('Aviso','Pedido incompleto, não há itens!',mtWarning, [mbOk]);
      Exit;
   end;

   if TabCompRecIDPess.Value <= 0 then
   begin
      MostraMsg('Aviso','É preciso entrar com o fornecedor!',mtWarning, [mbOk]);
      edPessoa.SetFocus;
      Exit;
   end;

   try
      FrmCompRecTit := TFrmCompRecTit.Create(Application);
      FrmCompRecTit.recIDPess   := TabCompRecIDPess.Value;
      FrmCompRecTit.recDatemi   := TabCompRecDatEmi.Value;
      FrmCompRecTit.recNotFis   := TabCompRecNotFis.AsString;
      FrmCompRecTit.recNrotit   := TabCompRecNrotit.Value;
      FrmCompRecTit.recNroSerie := TabCompRecNroSerie.AsString;
      TShadowHelper.ShowModalWithShadow(Application.MainForm, FrmCompRecTit);
   finally
      FreeAndNil(FrmCompRecTit);
   end;
end;

function TFrmCompEnt.ConfereNatFin: Boolean;
var
   QueParam:TRESTDWClientSQL;
begin
   Result := True;
   QueParam := TRESTDWClientSQL.Create(nil);
   try
      QueParam.DataBase := DM.DWDataBase;
      QueParam.SQL.Text  := 'SELECT * FROM arqparametros';
      QueParam.Open;
      if (QueParam.FieldByName('IDNatFinDesAce').AsInteger <= 0) or (QueParam.FieldByName('IDNatFinDesAsso').AsInteger <= 0) or
         (QueParam.FieldByName('IDNatFinVlrJur').AsInteger <= 0) or (QueParam.FieldByName('IDNatFinPerJur').AsInteger  <= 0) or
         (QueParam.FieldByName('IDNatFinVlrMul').AsInteger <= 0) or (QueParam.FieldByName('IDNatFinPerMul').AsInteger  <= 0) then
         Result := False;
   finally
      QueParam.Close;
      FreeAndNil(QueParam);
   end;
end;

procedure TFrmCompEnt.btFinalPreEntClick(Sender: TObject);
var
   auxRetManifesto:String;
   auxIDTitu,auxIDSngpcCom:Integer;
   auxVlrVendaSuger,auxPrecoFab,auxVlrPerMargem:Double;
   QueProd,QueAuxi,QueGrava,QueFili,QueLote,QueInvi,QuePara,QueTitT,QuePreco,QueIncl:TRESTDWClientSQL;
begin
   btFinalPreEnt.SetFocus;
   if MostraMsg('Confirmação','Confirma finalização de recebimento?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   if TabCompRecIt.IsEmpty then
   begin
      MostraMsg('Nenhuma NFe carregada','Favor carregar uma NFe! '+TabCompRecItDespro.AsString,mtWarning, [mbOk]);
      Exit;
   end;

   QueProd  := TRESTDWClientSQL.Create(nil);    QueProd.DataBase  := DM.DWDataBase;
   QueAuxi  := TRESTDWClientSQL.Create(nil);    QueAuxi.DataBase  := DM.DWDataBase;
   QueGrava := TRESTDWClientSQL.Create(nil);    QueGrava.DataBase := DM.DWDataBase;
   QueFili  := TRESTDWClientSQL.Create(nil);    QueFili.DataBase  := DM.DWDataBase;
   QueLote  := TRESTDWClientSQL.Create(nil);    QueLote.DataBase  := DM.DWDataBase;
   QueInvi  := TRESTDWClientSQL.Create(nil);    QueInvi.DataBase  := DM.DWDataBase;
   QuePara  := TRESTDWClientSQL.Create(nil);    QuePara.DataBase  := DM.DWDataBase;
   QueTitT  := TRESTDWClientSQL.Create(nil);    QueTitT.DataBase  := DM.DWDataBase;
   QuePreco := TRESTDWClientSQL.Create(nil);    QuePreco.DataBase := DM.DWDataBase;

   ShowWait('Aguarde...', Self);
   try
      try
         TabCompRecIt.First;
         while not TabCompRecIt.Eof do
         begin
            if TabCompRecItProdExist.AsString = '0' then
            begin
               MostraMsg('Produto não cadastrado','Favor cadastrar o produto antes de confirmar o recebimento -> '+TabCompRecItDespro.AsString,mtWarning, [mbOk]);
               Exit;
            end;
            QueProd.SQL.Text := 'SELECT PRO.IDProd,PRO.CodEANPri,PRO.ClasTera,EAN.CodEAN FROM arqproduto PRO LEFT JOIN '+
            'arqprodutoean EAN ON PRO.IDProd = EAN.IDProd WHERE CodEANPri != "" AND PRO.IDProd = '+TabCompRecItIDProd.AsString;
            QueProd.Open;
            if QueProd.FieldByName('ClasTera').AsString = '1' then
            begin
               QueAuxi.SQL.Text := 'SELECT Nrolot FROM arqcomprareclot WHERE IDRec = '+TabCompRecItIDRec.AsString+
               ' AND Nroite = '+TabCompRecItNroite.AsString+' AND IDProd = '+TabCompRecItIDProd.AsString;
               QueAuxi.Open;
               if QueAuxi.FieldByName('Nrolot').AsString = 'UNICO' then
                  raise Exception.Create('Favor cadastrar lote para o produto antes de confirmar o recebimento -> '+TabCompRecItDespro.AsString);
            end; //if
            TabCompRecIt.Next;
         end; //while

         QueTitT.SQL.Text := 'SELECT IDNatFin FROM arqtitulotemp WHERE IDPess = '+TabCompRecIDPess.AsString+' AND '+
         'NotFis = '+Aspas(TabCompRecNotFis.AsString)+' AND NroSerie = '+Aspas(TabCompRecNroSerie.AsString)+' AND IDNatFin = 0';
         QueTitT.Open;
         if not QueTitT.IsEmpty then raise Exception.Create('Há títulos sem Natureza Financeira, favor verificar ');

         // --- Grava o Estoque Final --- //
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'UPDATE arqcomprarec SET TipEnt = "0" WHERE IDRec = '+TabCompRecIDRec.AsString;
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then Raise Exception.Create(vErro);

         QuePreco.SQL.Text := '';
         while not QuePreco.Eof do
         begin
            if QuePreco.FieldByName('IndSel').AsString = '1' then
            begin
               auxVlrVendaSuger := QuePreco.FieldByName('VlrVendaSuger').AsFloat * QuePreco.FieldByName('TabPrecQtdFrac').AsFloat;
               auxVlrPerMargem  := QuePreco.FieldByName('VlrPerMargem').AsFloat;
               auxPrecoFab      := QuePreco.FieldByName('PrecoFab').AsFloat *QuePreco.FieldByName('QtdFrac').AsFloat;
               QueAuxi.SQL.Text := 'UPDATE arqproduto SET '+
               'PrecoVen = '+FormatDouble(auxVlrVendaSuger,11,4)+','+
               'PrecoPMC = '+FormatDouble(QuePreco.FieldByName('VlrPMC').AsFloat,11,2)+','+
               'PrecoFab = '+FormatDouble(auxPrecoFab,11,2)+','+
               'Markup = '  +FormatDouble(QuePreco.FieldByName('VlrPerMargem').AsFloat,11,2)+','+
               'CustoMed = '+FormatDouble(QuePreco.FieldByName('VlrCustoMed').AsFloat,11,2)+' '+
               'WHERE IDProd = '+QuePreco.FieldByName('IDProd').AsString;
               QueAuxi.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            end else
            begin
               // ----- Grava apenas o Custo Médio ------ //
               QueAuxi.SQL.Text := 'UPDATE arqproduto SET CustoMed = '+FormatDouble(QuePreco.FieldByName('VlrCustoMed').AsFloat,11,2)+
               ' WHERE IDProd = '+QuePreco.FieldByName('IDProd').AsString;
               QueAuxi.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            end; //if

            QuePreco.Next;
         end; //while

         // --- Grava no lote do SNGPC --- //
         QuePara.SQL.Text := 'SELECT ControleSNGPC, SNGPCObrCompra FROM arqparametros';
         QuePara.Open;
         if (QuePara.FieldByName('ControleSNGPC').AsBoolean) and QuePara.FieldByName('SNGPCObrCompra').AsBoolean then
         begin
            // Verifica se existe Inventário ativo para continuar com a gravação no Lote do SNGPC
            QueInvi.Close;
            QueInvi.SQL.Text := 'SELECT IDInvIni FROM arqsngpcinve WHERE IndFecha = 1';
            QueInvi.Open;
            if QueInvi.RecordCount > 0 then
            begin
               TabCompRecIt.Filtered := False;
               TabCompRecIt.Filter   := 'ClasTera != 0';
               TabCompRecIt.Filtered := True;
               if TabCompRecIt.RecordCount > 0 then
               begin
                  // Grava a nota fiscal
                  QueGrava.Close;
                  QueGrava.SQL.Text := 'INSERT INTO arqsngpccom (IDFilial,IDInvIni,IDPess,Nronot,Datlan,Tipope,IndConf) VALUES ('+
                  TabCompRecIDFilial.AsString+','+
                  QueInvi.FieldByName('IDInvIni').AsString+','+
                  TabCompRecIDPess.AsString+','+
                  TabCompRecNotFis.AsString+','+
                  Aspas(FormatDateTime('yyyy-mm-dd',TabCompRecDatRece.AsDateTime))+','+
                  Aspas('0')+','+ // Tipo operação 0-Entrada/Compra | 1 - Transferência
                  Aspas('0')+');';
                  QueGrava.SQL.Add('SELECT LAST_INSERT_ID() AS ULT_ID;');
                  QueGrava.Open;
                  auxIDSngpcCom := QueGrava.FieldByName('ULT_ID').AsInteger;
               end; //if

               TabCompRecIt.First;
               while not TabCompRecIt.Eof do
               begin
                  if not (TabCompRecItClasTera.AsString = '0') then
                  begin
                     // Grava o produto da nota fiscal
                     TabCompRecLot.Filtered := False;
                     TabCompRecLot.Filter   := 'IDRec = '+TabCompRecItIDRec.AsString+' AND Nroite = '+TabCompRecItNroite.AsString+
                     ' AND IDProd = '+TabCompRecItIDProd.AsString;
                     TabCompRecLot.Filtered := True;
                     TabCompRecLot.First;
                     while not TabCompRecLot.Eof do
                     begin
                        QueGrava.Close;
                        QueGrava.SQL.Text := 'INSERT INTO arqsngpccomite (IDSngpcCom,IDProd,Nrolot,Qtdmov,DatVen) VALUES ('+
                        auxIDSngpcCom.ToString+','+
                        TabCompRecItIDProd.AsString+','+
                        Aspas(TabCompRecLotNrolot.AsString)+','+
                        FormatDouble(TabCompRecLotQtdrec.AsFloat,11,2)+','+
                        Aspas(FormatDateTime('yyyy-mm-dd',TabCompRecLotDatven.AsDateTime))+')';
                        QueGrava.ExecSQL(vErro);
                        if vErro <> '' then Raise Exception.Create(vErro);
                        TabCompRecLot.Next;
                     end; //while
                  end; //if
                  TabCompRecIt.Next;
               end; //while
            end; //if
         end; //if

         // --- Salva os Títulos --- //
         QueTitT.First;
         while not QueTitT.Eof do
         begin
            QueGrava.Close;
            QueGrava.SQL.Text := 'INSERT INTO arqtitulo (IDPess,Nrotit,Destit,PagRec,NotFis,IDTiptit,Datemi,Datven,DesAsso,'+
            'VlrAces,VlrDevo,Vlrtit,Saltit,Histit,IDFilial,IDPed,IDNatFin,IDConv,CodBarra,NossoNro,ValorJuros,ValorMulta,'+
            'PercenJuros,PercenMulta,ChavePIXQRCode) VALUES ('+
            QueTitT.FieldByName('IDPess').AsString+','+
            QueTitT.FieldByName('Nrotit').AsString+','+
            Aspas(QueTitT.FieldByName('Destit').AsString)+','+
            Aspas(QueTitT.FieldByName('PagRec').AsString)+','+
            QueTitT.FieldByName('NotFis').AsString+','+
            QueTitT.FieldByName('IDTiptit').AsString+','+
            Aspas(FormatDateTime('yyyy-mm-dd',QueTitT.FieldByName('Datemi').AsDateTime))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',QueTitT.FieldByName('Datven').AsDateTime))+','+
            FormatDouble(QueTitT.FieldByName('DesAsso').AsFloat,11,2)+','+
            FormatDouble(QueTitT.FieldByName('VlrAces').AsFloat,11,2)+','+
            FormatDouble(QueTitT.FieldByName('VlrDevo').AsFloat,11,2)+','+
            FormatDouble(QueTitT.FieldByName('Vlrtit').AsFloat ,11,2)+','+
            FormatDouble(QueTitT.FieldByName('Saltit').AsFloat ,11,2)+','+
            Aspas(QueTitT.FieldByName('Histit').AsString)+','+
            QueTitT.FieldByName('IDFilial').AsString+','+
            QueTitT.FieldByName('IDPed').AsString+','+
            QueTitT.FieldByName('IDNatFin').AsString+','+
            QueTitT.FieldByName('IDConv').AsString+','+
            Aspas(QueTitT.FieldByName('CodBarra').AsString)+','+
            Aspas(QueTitT.FieldByName('NossoNro').AsString)+','+
            FormatDouble(QueTitT.FieldByName('ValorJuros').AsFloat, 11,2)+','+
            FormatDouble(QueTitT.FieldByName('ValorMulta').AsFloat, 11,2)+','+
            FormatDouble(QueTitT.FieldByName('PercenJuros').AsFloat,11,2)+','+
            FormatDouble(QueTitT.FieldByName('PercenMulta').AsFloat,11,2)+','+
            Aspas(QueTitT.FieldByName('ChavePIXQRCode').AsString)+');';
            QueGrava.SQL.Add('SELECT LAST_INSERT_ID() AS ULT_IDTitu;');
            QueGrava.Open;
            auxIDTitu :=  QueGrava.FieldByName('ULT_IDTitu').AsInteger;

            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT * FROM arqtitulorattemp  WHERE IDTitu = '+QueTitT.FieldByName('IDTitu').AsString+' AND OrigTitu = 1';
            QueAuxi.Open;
            QueAuxi.First;
            while not QueAuxi.Eof do
            begin
               QueGrava.Close;
               QueGrava.SQL.Text := 'INSERT INTO arqtitulorat (IDTitu,IDNatFin,ValorRat) VALUES ('+
               auxIDTitu.ToString+','+
               QueAuxi.FieldByName('IDNatFin').AsString+','+
               FormatDouble(QueAuxi.FieldByName('ValorRat').AsFloat,11,2)+')';
               QueGrava.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
               QueAuxi.Next;
            end; //while

            // Exclusão dos rateios da natureza financeira dos titulos da tabela temporária
            QueAuxi.SQL.Clear;
            QueAuxi.SQL.Text := 'DELETE FROM arqtitulorattemp WHERE IDTitu = '+QueTitT.FieldByName('IDTitu').AsString+' AND OrigTitu = 1';
            QueAuxi.ExecSQL;

            QueTitT.Next;
         end; //while

         // Exclusão dos títulos da tabela temporária
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Text := 'DELETE FROM arqtitulotemp WHERE IDPess = ' +QueTitT.FieldByName('IDPess').AsString+
         ' AND NotFis = '+QueTitT.FieldByName('NotFis').AsString+' AND NroSerie = '+QueTitT.FieldByName('NroSerie').AsString+
         ' AND Nrotit = '+QueTitT.FieldByName('Nrotit').AsString;
         QueAuxi.ExecSQL;

         // Grava a manifestação do destinatário no SEFAZ
         QueFili.Close;
         QueFili.SQL.Text := 'SELECT CNPJFil FROM arqfilial WHERE IDFilial = '+auxIDFil.ToString;
         QueFili.Open;
         auxRetManifesto := Manifestar(DM.ACBrNFe,QueFili.FieldByName('CNPJFil').AsString,TabCompRecIDChaAce.AsString,' ',91,teManifDestCiencia);
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT IDFilial FROM arqmandest WHERE CNPJCPFFor = '+Aspas(TabCompRecCNPJCPFFor.AsString)+' AND '+
         'IDFilial = '+auxIDFil.ToString+' AND NotFis = '  +TabCompRecNotFis.AsString+' AND NroSerie = '+TabCompRecNroSerie.AsString;
         QueAuxi.Open;
         if not (QueAuxi.IsEmpty) then // Se encontrar na arqmandest grava o retorno do manifesto no SEFAZ
         begin
            QueGrava.Close;
            QueGrava.SQL.Text := 'UPDATE arqmandest SET RetManifesto = '+Aspas(auxRetManifesto)+
            ' WHERE CNPJCPFFor = '+Aspas(TabCompRecCNPJCPFFor.AsString)+' AND IDFilial = '+auxIDFil.ToString+
            ' AND NotFis = '+TabCompRecNotFis.AsString+' AND NroSerie = '+TabCompRecNroSerie.AsString;
            QueGrava.ExecSQL(vErro);
         end; //if

         TabCompRec.Close;
         TabCompRecIt.Close;
         TabCompRecLot.Close;
         edNroIte.Text := '';
         auxQtdFra     := 0;
      except
         on E:Exception do
         begin
            HideWait;
            SalvaLog(USUARIO, PastaLog, '[ERRO] '+E.Message+' (uCompRec) ');
            MostraMsg('Erro','Não foi possivel finalizar.'+#10+E.Message, mtError, [mbOk]);
         end;
      end;
   finally
      QueProd.Close;   FreeAndNil(QueProd);
      QueAuxi.Close;   FreeAndNil(QueAuxi);
      QueGrava.Close;  FreeAndNil(QueGrava);
      QueFili.Close;   FreeAndNil(QueFili);
      QueLote.Close;   FreeAndNil(QueLote);
      QueInvi.Close;   FreeAndNil(QueInvi);
      QuePara.Close;   FreeAndNil(QuePara);
      QueTitT.Close;   FreeAndNil(QueTitT);
      QuePreco.Close;  FreeAndNil(QuePreco);
      HideWait;
   end;
end;

procedure TFrmCompEnt.btEtiquetaClick(Sender: TObject);
begin
   if TabCompRecIt.IsEmpty then
   begin
      MostraMsg('Aviso','Pedido incompleto, não há itens!',mtWarning, [mbOk]);
      Exit;
   end;
   //--> À DESENVOLVER
end;

procedure TFrmCompEnt.btConfereClick(Sender: TObject);
begin
   try
      Self.AlphaBlendValue := 175;
      Application.CreateForm(TFrmConfRecEnt, FrmConfRecEnt);
      CentralizarControl(FrmConfRecEnt, PanelPri);
      FrmConfRecEnt.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmConfRecEnt := nil;
   end;
end;

procedure TFrmCompEnt.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompEnt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.

