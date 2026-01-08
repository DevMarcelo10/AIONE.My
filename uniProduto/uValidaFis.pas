unit uValidaFis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDBaseGraphicControl, Data.DB,
  LMDBaseLabel, LMDCustomLabel, LMDLabel, Vcl.Imaging.pngimage, Vcl.ExtCtrls, LMDControl,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, AdvGlowButton,
  Vcl.StdCtrls, uRESTDWBasicDB, uConsultJSONParser, uConsultFiscal, LMDBaseEdit, LMDMemo,
  LMDCustomMemo, System.StrUtils, MarcLib, LMDEdit;


type
  TFrmValidaFis = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    btValidaFisco: TAdvGlowButton;
    Timer: TTimer;
    MemoErro: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExecValidaFisco;
    procedure btValidaFiscoClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    procedure AtuValorTab(recTabProd:TRESTDWClientSQL; recProduto:TProduto);
    { Private declarations }
  public
    { Public declarations }
    recIDProd:Integer;
    recCodEAN,recDespro:String;
    TabProdRec:TRESTDWClientSQL;
    recEdDesori:TLMDLabeledEdit;
  end;

var
  FrmValidaFis: TFrmValidaFis;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uProdutoCad;

procedure TFrmValidaFis.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   ExecValidaFisco;
end;

procedure TFrmValidaFis.ExecValidaFisco;
var
   acReg:Integer;
   Lines:TStringList;
   oErros:TErro;
   oProdutos:TProduto;
   QueAuxi:TRESTDWClientSQL;
   JSONResponse:TJSONResponse;
   recToken,auxUsuIntFiscal,auxPassIntFiscal,RequestJSON,Response:String;
begin
   Screen.Cursor := crHourGlass;
   Application.ProcessMessages;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT UsuIntFiscal,PassIntFiscal FROM arqparametros LIMIT 1';
      QueAuxi.Open;
      if QueAuxi.IsEmpty then
      begin
         MostraMsg('Erro','Parâmetros Fiscais não encontrados!', mtError, [mbOk]);
         Self.Close;
         Exit;
      end;
      auxUsuIntFiscal  := QueAuxi.FieldByName('UsuIntFiscal').AsString;
      auxPassIntFiscal := QueAuxi.FieldByName('PassIntFiscal').AsString;
      recToken := ConsultToken(auxUsuIntFiscal, auxPassIntFiscal);
      if AnsiPos('Erro',recToken) > 0 then
      begin
         MostraMsg('Erro','Não foi possível gerar o Token Fiscal!', mtError, [mbOk]);
         Self.Close;
         Exit;
      end;

      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT CNPJFar,Estmun,RTRIBFiscal,FAT12M FROM arqparametros LIMIT 1';
      QueAuxi.Open;
      if QueAuxi.IsEmpty then
      begin
         MostraMsg('Erro','Parâmetros Fiscais não encontrados!', mtError, [mbOk]);
         Self.Close;
         Exit;
      end;

      MemoErro.Lines.Clear;
      btValidaFisco.Enabled := False;
      Lines := TStringList.Create;
      try
         if not (TabProdRec.State in dsEditModes) then TabProdRec.Edit;
         Lines.Add(recCodEAN+';'+recIDProd.ToString+';'+recDespro);
//MUDAR/ RequestJSON  := BuildJSONRequest(QueAuxi.FieldByName('CNPJFar').AsString, QueAuxi.FieldByName('Estmun').AsString, QueAuxi.FieldByName('RTRIBFiscal').AsString, QueAuxi.FieldByName('FAT12M').AsString, Lines, recToken);
         RequestJSON  := BuildJSONRequest('27124815000139', 'MG', '1', '101', Lines, recToken);
         Response     := SendConsultRequest(RequestJSON);
         JSONResponse := ParseJSONResponse(Response);
         for oProdutos in JSONResponse.PRODUTO do AtuValorTab(TabProdRec, oProdutos);
         for oErros in JSONResponse.ERRO do
         begin
             MemoErro.Lines.Add('PRODUTO: '+oErros.COD_INTERNO+' - '+oErros.DESCRICAO);
             MemoErro.Lines.Add('ERRO: '+Copy(oErros.MSGERR, LastDelimiter(':',oErros.MSGERR)+1, oErros.MSGERR.Length));
             MemoErro.Lines.Add('');
         end;
      finally
         Lines.Free;
      end;
   finally
      LMDLabel1.Caption := 'Validação concluída...';
      Screen.Cursor := crDefault;
      btValidaFisco.Enabled := True;
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   if MemoErro.Lines.Count = 0 then Self.Close;
end;

procedure TFrmValidaFis.AtuValorTab(recTabProd:TRESTDWClientSQL; recProduto:TProduto);
var
   QueAuxi:TRESTDWClientSQL;
   FormatSettings:TFormatSettings;
begin
   FormatSettings := TFormatSettings.Create;
   FormatSettings.DecimalSeparator := '.';
   with recTabProd do
   begin
      FieldByName('CodNCM').AsString       := recProduto.COD_NCM;
      FieldByName('CodCEST').AsString      := recProduto.COD_CEST;
      FieldByName('CSTPisCofEnt').AsString := recProduto.CSTPIS_E;
      FieldByName('CSTPisCofSai').AsString := recProduto.CSTPIS_S;
      FieldByName('CodBenFis').AsString    := recProduto.COD_BENEF;
      FieldByName('CodnatEnt').AsString    := recProduto.NATRECEITA;
      FieldByName('CodnatSai').AsString    := recProduto.NATRECEITA;
      FieldByName('CSTICMS').AsString      := StrZero(recProduto.CST_ICMS_S,3);
      FieldByName('CodOrig').AsString      := Copy(FieldByName('CSTICMS').AsString,1,1);
      if recEdDesori <> nil then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            QueAuxi.DataBase := DM.DWDataBase;
            QueAuxi.SQL.Text := 'SELECT DesOrig FROM arqoriprod WHERE CodOrig = '+FieldByName('CodOrig').AsString+' LIMIT 1';
            QueAuxi.Open;
            if not QueAuxi.IsEmpty then
               recEdDesori.Text := QueAuxi.FieldByName('DesOrig').AsString
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if

      FieldByName('CSTIPI').AsString    := recProduto.CST_IPI;
      FieldByName('CSOSN').AsString     := recProduto.CST_CSOSN_S;
      FieldByName('AliqICMS').AsFloat   := StrToFloat(recProduto.Aliq_IPI,   FormatSettings);
      FieldByName('AliqRedICM').AsFloat := StrToFloat(recProduto.ALIQREDICMS,FormatSettings);
      FieldByName('AliPisCof').AsFloat  := StrToFloat(recProduto.ALIQ_PIS,   FormatSettings);
      FieldByName('AliqIVA').AsFloat    := StrToFloat(recProduto.MVA,        FormatSettings);
      if recProduto.LISTA = '0'  then FieldByName('TipLista').AsString := 'NEUTRA'   else
      if recProduto.LISTA = '1'  then FieldByName('TipLista').AsString := 'POSITIVA' else
      if recProduto.LISTA = '-1' then FieldByName('TipLista').AsString := 'NEGATIVA' else
      TabProdRec.FieldByName('TipLista').AsString := '';
      if recProduto.TP_ALIQICMS = 'T'  then FieldByName('TipoTriICMS').AsString := '0' else
      if recProduto.TP_ALIQICMS = 'R'  then FieldByName('TipoTriICMS').AsString := '1' else
      if recProduto.TP_ALIQICMS = 'I'  then FieldByName('TipoTriICMS').AsString := '2' else
      if recProduto.TP_ALIQICMS = 'ST' then FieldByName('TipoTriICMS').AsString := '3' else
      FieldByName('TipoTriICMS').AsString := 'NÃO TRIBUTADO';
      if FrmProdCad <> nil then
      begin
         SimularTabControle('FrmProdCad','LMDDBLabeledEdit11');
         SimularTabControle('FrmProdCad','LMDDBLabeledEdit14');
         SimularTabControle('FrmProdCad','LMDDBLabeledEdit12');
         SimularTabControle('FrmProdCad','LMDDBLabeledEdit16');
         SimularTabControle('FrmProdCad','LMDDBLabeledEdit16');
         SimularCliqueControle(FrmProdCad.LMDDBLabeledEdit6);
         SimularCliqueControle(FrmProdCad.LMDDBLabeledEdit6);
         FrmProdCad.AtuCombosFiscal;
      end; //if
   end; //with
end;

procedure TFrmValidaFis.btValidaFiscoClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmValidaFis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Self := nil;
end;

end.
