unit uCompRecTit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  RxToolEdit, RxDBCtrl, LMDSimplePanel, AdvGlowButton, LMDDBEdit, LMDControl, LMDEdit,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf, MarcLib, Vcl.DBCtrls,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes,
  FireDAC.Comp.Client, uRESTDWBasicDB, uShadowForm;

type
  TFrmCompRecTit = class(TForm)
    PanelCabTit: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    edChaPix: TLMDLabeledEdit;
    edTiptit: TLMDDBLabeledEdit;
    edNatFin: TLMDDBLabeledEdit;
    edHist: TLMDDBLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    edDatVenTit: TDBDateEdit;
    edValTit: TLMDDBLabeledEdit;
    edCodBarTit: TLMDDBLabeledEdit;
    edNosNumTit: TLMDDBLabeledEdit;
    btExcluiTit: TAdvGlowButton;
    btConfirmaTit: TAdvGlowButton;
    btCancelaTit: TAdvGlowButton;
    PanelRodTit: TLMDSimplePanel;
    edVlrTotTit: TLMDDBLabeledEdit;
    TabTitulo: TRESTDWClientSQL;
    TabTituloIDTitu: TIntegerField;
    TabTituloIDPess: TIntegerField;
    TabTituloNotFis: TIntegerField;
    TabTituloNroSerie: TIntegerField;
    TabTituloNrotit: TWideStringField;
    TabTituloDestit: TWideStringField;
    TabTituloPagRec: TWideStringField;
    TabTituloIDTiptit: TIntegerField;
    TabTituloDatemi: TDateField;
    TabTituloDatven: TDateField;
    TabTituloDesAsso: TFloatField;
    TabTituloVlrAces: TFloatField;
    TabTituloVlrDevo: TFloatField;
    TabTituloVlrtit: TFloatField;
    TabTituloSaltit: TFloatField;
    TabTituloHistit: TWideStringField;
    TabTituloIDFilial: TIntegerField;
    TabTituloIDPed: TIntegerField;
    TabTituloIDNatFin: TIntegerField;
    TabTituloIDConv: TIntegerField;
    TabTituloCodBarra: TWideStringField;
    TabTituloIndSel: TWideStringField;
    TabTituloIndEnvBco: TWideStringField;
    TabTituloNossoNro: TWideStringField;
    TabTituloCodRec: TIntegerField;
    TabTituloNumReferencia: TWideStringField;
    TabTituloDatCompApur: TDateField;
    TabTituloValorJuros: TFloatField;
    TabTituloValorMulta: TFloatField;
    TabTituloPercenJuros: TFloatField;
    TabTituloPercenMulta: TFloatField;
    TabTituloChavePIXQRCode: TWideStringField;
    TabTituloAgBenef: TLargeintField;
    TabTituloNumEnvBco: TIntegerField;
    TabTituloNompes: TWideStringField;
    TabTituloNomfil: TWideStringField;
    TabTituloDesTiptit: TWideStringField;
    TabTituloDesnat: TWideStringField;
    TabTituloSalTitCalc: TFloatField;
    SouTitulo: TDataSource;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    btFechar: TAdvGlowButton;
    btRateios: TAdvGlowButton;
    btIncluiTit: TAdvGlowButton;
    LMDSimplePanel3: TLMDSimplePanel;
    dgTitulos: TDBGrid;
    procedure edTiptitExit(Sender: TObject);
    function  BuscaChavePix:Boolean;
    procedure edTiptitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edTiptitCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinExit(Sender: TObject);
    procedure edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btIncluiTitClick(Sender: TObject);
    procedure btExcluiTitClick(Sender: TObject);
    procedure btConfirmaTitClick(Sender: TObject);
    procedure btCancelaTitClick(Sender: TObject);
    procedure dgTitulosCellClick(Column: TColumn);
    procedure dgTitulosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dgTitulosEnter(Sender: TObject);
    procedure dgTitulosExit(Sender: TObject);
    procedure dgTitulosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dgTitulosMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TabTituloCalcFields(DataSet: TDataSet);
    procedure btFecharClick(Sender: TObject);
    procedure btRateiosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edValTitKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    auxNosNum,auxCodBar:String;
    procedure GravaTit;
    procedure AtuVlrTotTit;
  public
    { Public declarations }
    recDatemi:TDate;
    recIDPess:Integer;
    recNotFis,recNroSerie,recNrotit:String;
  end;

var
  FrmCompRecTit: TFrmCompRecTit;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uValorRatTemp, uCompRecRat, uWaitForm;

procedure TFrmCompRecTit.FormShow(Sender: TObject);
begin
   try
      TabTitulo.ParamByName('IDPess').AsInteger  := recIDPess;
      TabTitulo.ParamByName('NotFis').AsString   := recNotFis;
      TabTitulo.ParamByName('NroSerie').AsString := recNroSerie;
      TabTitulo.Open;
      TStringGrid(dgTitulos).DefaultRowHeight := BaseRowHeight - 3;
      AjustaDBGrid(dgTitulos);
      AtuVlrTotTit;
      edTiptit.SetFocus;
   except
      on E: Exception do
      begin
         SalvaLog(USUARIO, PastaLog, '[ERRO] Tentando abrir formulário FrmCompRecTit -> '+E.Message);
         MostraMsg('Erro','Não foi possível continuar.'+E.Message, mtError, [mbOk]);
         PostMessage(Self.Handle, WM_CLOSE, 0, 0);
         Exit;
      end; //on
   end;
end;

procedure TFrmCompRecTit.edTiptitExit(Sender: TObject);
begin
   BuscaChavePix;
end;

function TFrmCompRecTit.BuscaChavePix:Boolean;
var
   QuePess:TRESTDWClientSQL;
begin
   Result := False;
   if (TabTituloIDTiptit.AsInteger = 9) and (TabTituloIDPess.AsInteger <> 0) then
   begin
      QuePess := TRESTDWClientSQL.Create(nil);
      QuePess.DataBase := DM.DWDataBase;
      try
         QuePess.SQL.Text := 'SELECT * FROM arqpessbanc WHERE IDPess = '+TabTituloIDPess.AsString;
         QuePess.Open;
         if QuePess.IsEmpty then
         begin
            MostraMsg('Aviso','Não foi encontrada chave PIX para este fornecedor!'+#13+
            'Favor informar a chave Pix no Cadastro de pessoas em Dados Financeiros', mtWarning, [mbOk]);
            edChaPix.Text := '';
            Exit;
         end; //if

         if QuePess.FieldByName('IDPix').AsString = '' then
         begin
            MostraMsg('Aviso','Não foi encontrada chave PIX.'+#13+'Informar a Chave no Cadastro de pessoas em Dados Financeiros', mtWarning, [mbOk]);
            edChaPix.Text := '';
            Exit;
         end; //if
         edChaPix.Text := QuePess.FieldByName('IDPix').AsString;
         Result := True;
      finally
         QuePess.Close;
         FreeAndNil(QuePess);
      end;
   end; //if
end;

procedure TFrmCompRecTit.AtuVlrTotTit;
var
   auxVlrTotTit:Double;
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := ' SELECT SUM(Saltit) AS TotSalTit FROM arqtitulotemp WHERE IDPess = '+recIDPess.ToString+
         ' AND NotFis = '+Aspas(recNotFis)+' AND NroSerie = '+Aspas(recNroSerie)+' AND Nrotit = '+Aspas(recNrotit);
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
              auxVlrTotTit := QueAuxi.FieldByName('TotSalTit').AsFloat
         else auxVlrTotTit := 0.00;
         edVlrTotTit.Text  := FormatFloat('###,###,##0.00',auxVlrTotTit);
      except
         on E:Exception do
         begin
            MostraMsg('Erro','Não foi possível Totalizar titulos. -> '+E.Message, mtError, [mbOk]);
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível totalizar títulos (uCompRecTit) -> '+E.Message);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmCompRecTit.btCancelaTitClick(Sender: TObject);
begin
   edNosNumTit.Text      := '';
   edCodBarTit.Text      := '';
   edDatVenTit.Enabled   := False;
   edValTit.Enabled      := False;
   edNosNumTit.Enabled   := False;
   edCodBarTit.Enabled   := False;
   btExcluiTit.Enabled   := True;
   btIncluiTit.Enabled   := True;
   btConfirmaTit.Enabled := False;
   btCancelaTit.Enabled  := False;
   edTiptit.Enabled      := True;
   edNatFin.Enabled      := True;
   edHist.Enabled        := True;
   dgTitulos.Enabled     := True;
   TabTitulo.Cancel;
end;

procedure TFrmCompRecTit.btConfirmaTitClick(Sender: TObject);
var
   auxDestit,vErro:String;
   auxValTit:Double;
   QueAuxi,QueGrava:TRESTDWClientSQL;
   auxIDConv,auxIDNatFin,auxIDTitu:Integer;
begin
   btConfirmaTit.SetFocus;
   auxValTit := TabTituloVlrtit.AsFloat;

   if edDatVenTit.Date = 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a Data de vencimento!',mtWarning, [mbOk]);
      edDatVenTit.SetFocus;
      Exit;
   end;
   if auxValTit = 0 then
   begin
      MostraMsg('Valor inválido','Favor verificar a valor do título!',mtWarning, [mbOk]);
      edValTit.SetFocus;
      Exit;
   end;// if

   QueAuxi  := TRESTDWClientSQL.Create(nil);
   QueGrava := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase  := DM.DWDataBase;
   QueGrava.DataBase := DM.DWDataBase;
   try
      try
         auxDestit := IntToStr(TabTitulo.RecordCount + 1);
         auxDestit := StrZero(auxDestit, 3);
         QueAuxi.SQL.Text :=
         'SELECT PES.*, NAT.Desnat,CON.IDConv FROM arqpessoa PES LEFT JOIN arqnatfin NAT ON NAT.IDNatfin = PES.IDNatfin '+
         'LEFT JOIN arqpessconv PCON ON PCON.IDPess = PES.IDPess LEFT JOIN arqconvenio CON ON CON.IDConv = PCON.IDConv '+
         'WHERE PES.IDPess = '+recIDPess.ToString;
         QueAuxi.Open;
         auxIDNatFin := QueAuxi.FieldByName('IDNatfin').AsInteger;
         auxIDConv   := QueAuxi.FieldByName('IDConv').AsInteger;
         if auxIDNatFin = 0 then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+FILIAL.ToString;
            QueAuxi.Open;
            auxIDNatFin := QueAuxi.FieldByName('IDNatFinEntMerRec').AsInteger;
         end;// if

         // ---- Grava o titulo ---- //
         QueGrava.SQL.Text := 'INSERT INTO arqtitulotemp (IDPess,NotFis,NroSerie,Nrotit,Destit,PagRec,'+
         'IDTiptit,Datemi,Datven,Vlrtit,Saltit,IDFilial,IDNatFin,IDConv,NossoNro,CodBarra) VALUES ('+
         recIDPess.ToString+','+
         Aspas(recNotFis)+','+
         Aspas(recNroSerie)+','+
         Aspas(recNrotit)+','+
         Aspas(auxDestit)+','+
         Aspas('P')+','+
         Aspas('2')+','+ // Boleto bancário de outro banco.
         Aspas(FormatDateTime('yyyy-mm-dd',recDatemi))+','+
         Aspas(FormatDateTime('yyyy-mm-dd',edDatVenTit.Date))+','+
         FormatDouble(auxValTit,11,2)+','+
         FormatDouble(auxValTit,11,2)+','+
         FILIAL.ToString+','+
         auxIDNatFin.ToString+','+
         auxIDConv.ToString+','+
         Aspas(edNosNumTit.Text)+','+
         Aspas(edCodBarTit.Text)+'); ';
         QueGrava.SQL.Add('SELECT LAST_INSERT_ID() AS ULT_IDTitu;');
         QueGrava.Open;
         auxIDTitu := QueGrava.FieldByName('ULT_IDTitu').AsInteger;
         AtuVlrTotTit;
         TabTitulo.Refresh;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar arqtitulotemp (uCompRecTit) -> '+E.Message);
            MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end; //try

      // ---- Grava o rateio do titulo ---- //
      try
         QueGrava.Close;
         QueGrava.SQL.Text := 'INSERT INTO arqtitulorattemp (IDTitu,IDNatFin,OrigTitu,ValorRat,RatFixo) VALUES (' +
         auxIDTitu.ToString+','+
         auxIDNatfin.ToString+','+
         Aspas('1')+','+
         FormatDouble(auxValTit,11,2)+','+
         Aspas('0')+')';
         QueGrava.ExecSQL(vErro);
         if vErro <> '' then Raise Exception.Create(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar arqtitulorattemp (uCompRecTit) -> '+E.Message);
            MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end; //try
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueGrava);
   end;// try
   TabTitulo.Refresh;
   btCancelaTitClick(Sender);
end;

procedure TFrmCompRecTit.btExcluiTitClick(Sender: TObject);
var
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabTitulo.RecordCount = 0 then
   begin
      MostraMsg('Aviso','Não existem títulos para excluir!', mtWarning, [mbOk]);
      Exit;
   end;
   if MostraMsg('Confirmação','Deseja excluir a última parcela?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   TabTitulo.Last;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Add('DELETE FROM arqtitulotemp WHERE IDPess = ' +TabTituloIDPess.AsString+
         ' AND NotFis = '+TabTituloNotFis.AsString+' AND NroSerie = '+TabTituloNroSerie.AsString+
         ' AND Nrotit = '+TabTituloNrotit.AsString+' AND Destit = '  +TabTituloDestit.AsString+'; ');
         QueAuxi.SQL.Add('DELETE FROM arqtitulorattemp WHERE IDTitu = '+TabTituloIDTitu.AsString+';');
         QueAuxi.ExecSQL(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir último título de TabTituloTemp (uCompRecTit) -> '+E.Message);
            MostraMsg('Erro','Não foi possível excluir.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
      AtuVlrTotTit;
      TabTitulo.Refresh;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmCompRecTit.btIncluiTitClick(Sender: TObject);
begin
   edDatVenTit.Enabled   := True;
   edValTit.Enabled      := True;
   edNosNumTit.Enabled   := True;
   edCodBarTit.Enabled   := True;
   btConfirmaTit.Enabled := True;
   btCancelaTit.Enabled  := True;
   btExcluiTit.Enabled   := False;
   btIncluiTit.Enabled   := False;
   edTiptit.Enabled      := False;
   edNatFin.Enabled      := False;
   edHist.Enabled        := False;
   dgTitulos.Enabled     := False;
   edDatVenTit.SetFocus;
   TabTitulo.Append;
end;

procedure TFrmCompRecTit.btRateiosClick(Sender: TObject);
begin
   try
      FrmCompRecRat := TFrmCompRecRat.Create(Application);
      FrmCompRecRat.recIDTitu := TabTituloIDTitu.Value;
      TShadowHelper.ShowModalWithShadow(Self,FrmCompRecRat);
   finally
      AtuVlrTotTit;
   end;
end;

procedure TFrmCompRecTit.GravaTit;
var
   auxPos: TBookmark;
   QueAuxi,QueTitu:TRESTDWClientSQL;
   auxNossoNro,auxCodBarra,VeRRO:String;
begin
   ShowWait('Aguarde...', Self);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueTitu := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueTitu.DataBase := DM.DWDataBase;
      QueTitu.SQL.Clear;
      QueTitu.SQL.Text := 'SELECT NossoNro,CodBarra FROM arqtitulotemp WHERE '+
      ' IDPess = '+TabTituloIDPess.AsString+  ' AND NotFis = '+Aspas(TabTituloNotFis.AsString)+
      ' AND NroSerie = '+Aspas(TabTituloNroSerie.AsString)+' AND Nrotit = '+Aspas(TabTituloNrotit.AsString)+
      ' AND Destit = '  +Aspas(TabTituloDestit.AsString);
      QueTitu.Open;
      if (QueTitu.FieldByName('NossoNro').AsString = TabTituloNossoNro.AsString) and
         (QueTitu.FieldByName('CodBarra').AsString = TabTituloCodBarra.AsString) then exit;
      try
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Text := 'UPDATE arqtitulotemp SET '+
         'NossoNro = '+Aspas(TabTituloNossoNro.AsString)+','+
         'CodBarra = '+Aspas(TabTituloCodBarra.AsString)+
         ' WHERE IdTitu = 0 AND IDPess = '+TabTituloIDPess.AsString+
         ' AND NotFis = '+TabTituloNotFis.AsString+
         ' AND NroSerie = '+TabTituloNroSerie.AsString+
         ' AND Nrotit = '+TabTituloNrotit.AsString+
         ' AND Destit = '+TabTituloDestit.AsString;
         QueAuxi.ExecSQL(vErro);
      except // try
         on E:Exception do
         begin
            HideWait;
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível fazer a alteração no título TabTitulo em uCompRec -> '+E.Message);
            MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
      auxPos := TabTitulo.GetBookmark;
      TabTitulo.Close;
      TabTitulo.Open;
      TabTitulo.GotoBookmark(auxPos);
      TabTitulo.FreeBookmark(auxPos);
   finally
      QueAuxi.Close;
      QueTitu.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueTitu);
      HideWait;
   end;
end;

procedure TFrmCompRecTit.dgTitulosCellClick(Column: TColumn);
begin
   auxNosNum := TabTituloNossoNro.AsString;
   auxCodBar := TabTituloCodBarra.AsString;
end;

procedure TFrmCompRecTit.dgTitulosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if not TabTitulo.IsEmpty then
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
         TDBGrid(Sender).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
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

procedure TFrmCompRecTit.dgTitulosEnter(Sender: TObject);
begin
   auxNosNum := TabTituloNossoNro.AsString;
   auxCodBar := TabTituloCodBarra.AsString;
end;

procedure TFrmCompRecTit.dgTitulosExit(Sender: TObject);
begin
   if (auxNosNum <> TabTituloNossoNro.AsString) or (auxCodBar <> TabTituloCodBarra.AsString) then
   begin
      GravaTit;
      auxNosNum := TabTituloNossoNro.AsString;
      auxCodBar := TabTituloCodBarra.AsString;
   end;
end;

procedure TFrmCompRecTit.dgTitulosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (dgTitulos.DataSource.DataSet.RecNo = dgTitulos.DataSource.DataSet.RecordCount ) then abort;
   if  Key in [VK_RETURN,VK_TAB] then TabTitulo.ApplyUpdates;
   if (auxNosNum <> TabTituloNossoNro.AsString) or (auxCodBar <> TabTituloCodBarra.AsString) then
   begin
      GravaTit;
      auxNosNum := TabTituloNossoNro.AsString;
      auxCodBar := TabTituloCodBarra.AsString;
   end;
end;

procedure TFrmCompRecTit.dgTitulosMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (auxNosNum <> TabTituloNossoNro.AsString) or (auxCodBar <> TabTituloCodBarra.AsString) then
   begin
      GravaTit;
      auxNosNum := TabTituloNossoNro.AsString;
      auxCodBar := TabTituloCodBarra.AsString;
   end else
   begin
      auxNosNum := TabTituloNossoNro.AsString;
      auxCodBar := TabTituloCodBarra.AsString;
   end;
end;

procedure TFrmCompRecTit.edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if not TabTitulo.IsEmpty then
   begin
      edNatFin.SetFocus;
      try
         FrmVlrRatTemp := TFrmVlrRatTemp.Create(Application);
         FrmVlrRatTemp.recIDTitu   := TabTituloIDTitu.AsInteger;
         FrmVlrRatTemp.recSaltit   := TabTituloVlrtit.AsFloat;
         FrmVlrRatTemp.recOrigTitu := '1';
         CentralizarControl(FrmVlrRatTemp, Self);
         FrmVlrRatTemp.ShowModal;
      finally
         if FrmVlrRatTemp.recIDNatFin > 0 then
         begin
            if not(TabTitulo.State in dsEditModes) then TabTitulo.Edit;
            TabTituloIDNatFin.AsInteger := FrmVlrRatTemp.recIDNatFin;
            TabTituloDesnat.AsString    := FrmVlrRatTemp.recDesNatFin;
         end; //if
         FrmVlrRatTemp.Free;
      end;
   end; //if
end;

procedure TFrmCompRecTit.edNatFinExit(Sender: TObject);
var
   vErro:sTRING;
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'UPDATE arqtitulotemp SET IDNatFin = '+TabTituloIDNatFin.AsString+
         ' WHERE IDPess = '+TabTituloIDPess.AsString+  ' AND NotFis = '+TabTituloNotFis.AsString+
         ' AND NroSerie = '+TabTituloNroSerie.AsString+' AND Nrotit = '+Aspas(TabTituloNrotit.AsString)+
         ' AND Destit = '  +Aspas(TabTituloDestit.AsString);
         QueAuxi.ExecSQL(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível alterar a natureza financeira do título na entrada da nota TabTitulo (uCompRecTit) -> '+E.Message);
            MostraMsg('Erro','Não foi possível salvar Natureza Financeira!'+#10+E.Message, mtError, [mbOk]);
            Exit;
         end;
      end;
      TabTitulo.Refresh;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmCompRecTit.edTiptitCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if not TabTitulo.IsEmpty then
   begin
      edTiptit.SetFocus;
      btBuscasDB(TabTitulo,'arqtiptitu',TDBEdit(edTiptit),'IDTiptit','IDTiptit','DesTiptit','DesTiptit','',0);
   end;
end;

procedure TFrmCompRecTit.TabTituloCalcFields(DataSet: TDataSet);
begin
   TabTituloSalTitCalc.AsFloat := (TabTituloVlrtit.AsFloat - TabTituloDesAsso.AsFloat) + TabTituloVlrAces.AsFloat;
end;

procedure TFrmCompRecTit.edTiptitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabTitulo,'arqtiptitu',TDBEdit(edTiptit),'IDTiptit','IDTiptit','DesTiptit','DesTiptit','',Key);
end;

procedure TFrmCompRecTit.edValTitKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = '-' then Key := #0;
end;

procedure TFrmCompRecTit.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompRecTit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabTitulo.Close;
   Action := caFree;
end;

end.

