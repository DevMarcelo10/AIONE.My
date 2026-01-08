unit uManiDest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  LMDCustomMaskEdit, LMDMaskEdit, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, LMDButtonControl,
  LMDCustomCheckBox, LMDCheckBox, LMDBaseEdit, LMDCustomEdit, LMDEdit, MarcLib, LMDLabel,
  AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  Vcl.ExtCtrls, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDSimplePanel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, ACBrNFe,
  FireDAC.Stan.Error, FireDAC.DatS, uRESTDWBasicDB, FireDAC.Comp.DataSet, uWaitForm,
  FireDAC.DApt.Intf, FireDAC.Comp.Client, uRESTDWBasicTypes, FireDAC.Phys.Intf,
  ACBrUtil.DateTime;

type
  TFrmManiDest = class(TForm)
    PanelPri: TLMDSimplePanel;
    Shape3: TShape;
    Shape5: TShape;
    PanelTop: TLMDSimplePanel;
    LMDLabel8: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCabe: TLMDSimplePanel;
    edNomfil: TLMDLabeledEdit;
    PanelDatas: TLMDSimplePanel;
    Label16: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    ckEmissao: TLMDCheckBox;
    edDatainicio: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfinal: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btBuscar: TAdvGlowButton;
    edNotfis: TLMDLabeledMaskEdit;
    edNomPes: TLMDLabeledEdit;
    PanelRodape: TLMDSimplePanel;
    btImportar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    dgDados: TDBGrid;
    TabManDest: TRESTDWClientSQL;
    SouTabManDest: TDataSource;
    btManifestar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    ckALancar: TLMDCheckBox;
    ckLancada: TLMDCheckBox;
    ckPendente: TLMDCheckBox;
    TabManDestIDManDest: TFDAutoIncField;
    TabManDestIDPess: TIntegerField;
    TabManDestNotFis: TIntegerField;
    TabManDestNroSerie: TIntegerField;
    TabManDestIDChaAce: TWideStringField;
    TabManDestDatEmi: TDateTimeField;
    TabManDestStatusNFE: TWideStringField;
    TabManDestManNFE: TWideStringField;
    TabManDestVlrNotFis: TFloatField;
    TabManDestNomPess: TWideStringField;
    TabManDestIndSel: TWideStringField;
    TabManDestIDFilial: TIntegerField;
    TabManDestNomfil: TWideStringField;
    btConsultar: TAdvGlowButton;
    TabManDestCNPJCPFFor: TWideStringField;
    TabManDestRetManifesto: TWideStringField;
    Label2: TLabel;
    procedure ckALancarClick(Sender: TObject);
    procedure ckPendenteClick(Sender: TObject);
    procedure ckLancadaClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btImportarClick(Sender: TObject);
    procedure TabManDestAfterOpen(DataSet: TDataSet);
    procedure dgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dgDadosCellClick(Column: TColumn);
    procedure btConsultarClick(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure edNomPesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomfilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomPesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomfilCustomButtons0Click(Sender: TObject; index: Integer);
    procedure dgDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btManifestarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    { Private declarations }
    auxNomFil:String;
    auxIDFil:Integer;
    vErro:string;
    procedure AjustaGrid;
    procedure AbreTabela;
  public
    { Public declarations }
    recNomArqXML:String;
    recImporta:Boolean;
  end;

var
  FrmManiDest: TFrmManiDest;

implementation

uses uDM, uConst, pcnConversao, uLibFarm, uJustManiDest;

{$R *.dfm}

procedure TFrmManiDest.FormShow(Sender: TObject);
begin
   auxIDFil := FILIAL;
   dgDados.SelectedField := TabManDestNomPess;
   AbreTabela;
   edNomfil.Tag  := auxIDFil;
   edNomfil.Text := auxNomFil;
   recImporta    := False;
end;

procedure TFrmManiDest.AbreTabela;
var
   QueFili:TRESTDWClientSQL;
begin
   TabManDest.Close;
   TabManDest.SQL.Text := 'SELECT MAN.*,FIL.Nomfil  FROM arqmandest MAN '+
   'LEFT JOIN arqfilial FIL ON MAN.IDFilial = FIL.IDFilial ORDER BY MAN.DatEmi,MAN.IDPess';
   TabManDest.Open;
   QueFili := TRESTDWClientSQL.Create(nil);
   try
      QueFili.DataBase := DM.DWDataBase;
      QueFili.Close;
      QueFili.SQL.Text := 'SELECT Nomfil FROM arqfilial WHERE IDFilial = '+auxIDFil.ToString;
      QueFili.Open;
      auxNomFil := QueFili.FieldByName('Nomfil').AsString;
   finally
      QueFili.Close;
      FreeAndNil(QueFili);
   end; //try
end;

procedure TFrmManiDest.AjustaGrid;
begin
   TStringGrid(dgDados).DefaultRowHeight := BaseRowHeight - 3;
   dgDados.Width := dgDados.Width - 10;
   dgDados.Width := dgDados.Width + 10;
end;

procedure TFrmManiDest.TabManDestAfterOpen(DataSet: TDataSet);
begin
   AjustaGrid;
end;

procedure TFrmManiDest.btBuscarClick(Sender: TObject);
begin
   auxIDFil  := edNomfil.Tag;
   auxNomFil := edNomfil.Text;
   TabManDest.Close;
   TabManDest.SQL.Clear;
   TabManDest.SQL.Text := 'SELECT MAN.*,FIL.Nomfil FROM arqmandest MAN LEFT JOIN '+
   'arqfilial FIL ON MAN.IDFilial = FIL.IDFilial WHERE MAN.IDFilial = '+edNomfil.Tag.ToString;
   if edNomPes.Tag > 0 then TabManDest.SQL.Add(' AND IDPess = '+  edNomPes.Tag.ToString);
   if edNotfis.AsInteger > 0 then TabManDest.SQL.Add(' AND NotFis = '+edNotfis.AsString);
   if ckALancar.Checked  then TabManDest.SQL.Add(' AND StatusNFE = ' +Aspas('1'));
   if ckPendente.Checked then TabManDest.SQL.Add(' AND StatusNFE = ' +Aspas('2'));
   if ckLancada.Checked  then TabManDest.SQL.Add(' AND StatusNFE = ' +Aspas('3'));
   if ckEmissao.Checked and (edDataIni.Date <> 0) and (edDataFin.Date <> 0) then
      TabManDest.SQL.Add(' AND Datemi BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDataIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDataFin.Date)));
   TabManDest.SQL.Add(' ORDER BY MAN.DatEmi,MAN.IDPess');
   TabManDest.Open;
end;

procedure TFrmManiDest.btConsultarClick(Sender: TObject);
var
   auxIDChaAce,auxSitDFe,auxNomPes,auxCNPJCPF:String;
   i,auxIDPess,auxNotFis,auxNroSerie,auxCodUF:Integer;
   QueGrava,QuePess,QueAuxi,QueParam:TRESTDWClientSQL;
   auxMinuto:Double;
   Path,FileName,Ano,Mes:string;
   auxData:Tdatetime;
   SearchRec: TSearchRec;
begin
   if MostraMsg('Confirmação','Confirma a consultas das NFe no SEFAZ?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;

   ShowWait('Aguarde...', Self);
   QueGrava := TRESTDWClientSQL.Create(nil);
   QuePess  := TRESTDWClientSQL.Create(nil);
   QueAuxi  := TRESTDWClientSQL.Create(nil);
   QueParam := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;
   QuePess.DataBase  := DM.DWDataBase;
   QueAuxi.DataBase  := DM.DWDataBase;
   QueParam.DataBase := DM.DWDataBase;
   try
      QueParam.SQL.Text := 'SELECT Estmun,UltNSUNFe,MaxNSUNFe,DataHoraUltAcesso,PastaCertDigital,SenhaCertMan,PastaManifesto FROM arqparametros WHERE IDFilial = '+auxIDFil.ToString;
      QueParam.Open;
      if QueParam.FieldByName('UltNSUNFe').AsString <> '0' then
      begin
         if QueParam.FieldByName('MaxNSUNFe').AsString = QueParam.FieldByName('UltNSUNFe').AsString then
         begin
            auxMinuto := (Now - QueParam.FieldByName('DataHoraUltAcesso').AsDateTime)*1440;
            if auxminuto < 65 then
            begin
               MostraMsg('Aviso','Não passou uma hora desde o último acesso!',mtWarning, [mbOk]);
               Exit;
            end;
         end; //if
      end; //if

      auxCodUF := CodigoUF(QueParam.FieldByName('Estmun').AsString).ToInteger;
      DM.ACBrNFe.Configuracoes.Certificados.ArquivoPFX           := QueParam.FieldByName('PastaCertDigital').AsString.Trim;
      DM.ACBrNFe.Configuracoes.Certificados.Senha                := QueParam.FieldByName('SenhaCertMan').AsString.Trim;
      DM.ACBrNFe.Configuracoes.Arquivos.PathSchemas              := QueParam.FieldByName('PastaManifesto').AsString.Trim+'\Schemas';
      DM.ACBrNFe.Configuracoes.Arquivos.DownloadDFe.PathDownload := QueParam.FieldByName('PastaManifesto').AsString.Trim;
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT CNPJFil FROM arqfilial WHERE IDFilial = '+auxIDFil.ToString;
      QueAuxi.Open;
      DM.ACBrNFe.DistribuicaoDFePorUltNSU(auxCodUF, QueAuxi.FieldByName('CNPJFil').AsString, QueParam.FieldByName('UltNSUNFe').AsString);
      auxData := Now;

      for i := 0 to DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count -1 do
      begin
         // --- Resumo da NFe --- //
         if DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.CNPJCPF <> '' then
         begin
            Quepess.Close;
            Quepess.SQL.Text := 'SELECT IDPess,Nompes,CpfCnpjPes FROM arqpessoa '+
            'WHERE CpfCnpjPes = '+Aspas(DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.CNPJCPF);
            Quepess.Open;
            if QuePess.IsEmpty then
            begin
              auxIDPess  := 0;
              auxNomPes  := DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.xNome;
              auxCNPJCPF := DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.CNPJCPF;
            end else
            begin
              auxIDPess  := QuePess.FieldByName('IDPess').AsInteger;
              auxNomPes  := QuePess.FieldByName('Nompes').AsString;
              auxCNPJCPF := QuePess.FieldByName('CpfCnpjPes').AsString;
            end;
            if DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.chDFe <> '' then
            begin
              auxIDChaAce := DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.chDFe;
              auxNroSerie := StrToInt(Copy(DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.chDFe,23,3));
              auxNotFis   := StrToInt(Copy(DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.chDFe,26,9));
            end else
            begin
              auxIDChaAce := '';
              auxNroSerie := 0;
              auxNotFis   := 0;
            end; //if
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT IDPess FROM arqmandest WHERE CNPJCPFFor = '+Aspas(auxCNPJCPF)+
            ' AND NotFis = '+auxNotFis.ToString+' AND NroSerie = '+auxNroSerie.ToString;
            QueAuxi.Open;
            if QueAuxi.IsEmpty then
            begin
               try
                  Ano := IntToStr(Year(auxData));
                  Mes := StrZero(IntToStr(Month(auxData)),2);
                  FileName := DM.ACBrNFe.Configuracoes.Arquivos.DownloadDFe.PathDownload;
                  Path := FileName+'\'+Ano+Mes+'\'+auxIDChaAce+'-resNFe.xml';
                  if FileExists(Path) then
                  begin
                     try DeleteFile(Path);
                     except
                     end;
                  end;
                  auxSitDFe := SituacaoDFeToStr(DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.cSitDFe);
                  QueGrava.SQL.Text := 'INSERT INTO arqmandest (IDPess,IDFilial,NotFis,NroSerie,IDChaAce,DatEmi,StatusNFE,ManNFE,VlrNotFis,NomPess,CNPJCPFFor) VALUES ('+
                  auxIDPess.ToString+','+
                  auxIDFil.ToString+','+
                  auxNotFis.ToString+','+
                  auxNroSerie.ToString+','+
                  Aspas(auxIDChaAce)+','+
                  Aspas(FormatDateTime('yyyy-mm-dd',DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.dhEmi))+','+
                  Aspas('1')+','+
                  Aspas(auxSitDFe)+','+
                  FormatDouble(DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resDFe.vNF,11,2)+','+
                  Aspas(auxNomPes)+','+
                  Aspas(auxCNPJCPF)+')';
                  QueGrava.ExecSQL(vErro);
                  if vErro <> '' then Raise Exception.Create(vErro);
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar TabManDest em uManiDest -> '+E.Message);
                     MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end;
            end; //if
         end; //if
      end; //for

      try
         QueGrava.Close;
         QueGrava.SQL.Text := 'UPDATE arqparametros SET '+
         'UltNSUNFe = '+Aspas(DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.ultNSU)+','+
         'MaxNSUNFe = '+Aspas(DM.ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.maxNSU)+','+
         'DataHoraUltAcesso = '+Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss', Now))+' '+
         'WHERE IDFilial = '+auxIDFil.ToString;
         QueGrava.ExecSQL(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar as alterações na tabela arqparametros de ultimo NSU, Max NSU e data e hora em uManiDest -> '+E.Message);
            MostraMsg('Erro','Não foi possível gravar as alterações.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
      TabManDest.Close;
      TabManDest.Open;
   finally
      QueGrava.Close;  FreeAndNil(QueGrava);
      QuePess.Close;   FreeAndNil(QuePess);
      QueAuxi.Close;   FreeAndNil(QueAuxi);
      QueParam.Close;  FreeAndNil(QueParam);
      HideWait;
   end; //try
end;

procedure TFrmManiDest.btManifestarClick(Sender: TObject);
var
   Index:Integer;
   QueParam,QueFili:TRESTDWClientSQL;
begin
   Index := dgDados.DataSource.DataSet.RecNo;
   TabManDest.Filtered := False;
   TabManDest.Filter   := 'IndSel = 1';
   TabManDest.Filtered := True;
   if TabManDest.RecordCount > 1 then
   begin
      MostraMsg('Aviso','Favor selecionar apenas uma NFe!',mtWarning, [mbOk]);
      TabManDest.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end;

   if TabManDest.RecordCount < 1 then
   begin
      MostraMsg('Aviso','Nenhma NFe selecionada!',mtWarning, [mbOk]);
      TabManDest.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end;

   QueFili  := TRESTDWClientSQL.Create(nil);
   QueParam := TRESTDWClientSQL.Create(nil);
   QueFili.DataBase  := DM.DWDataBase;
   QueParam.DataBase := DM.DWDataBase;
   try
      try
         QueParam.SQL.Text := 'SELECT PastaCertDigital,SenhaCertMan,PastaManifesto FROM arqparametros';
         QueParam.Open;
         if QueParam.FieldByName('PastaCertDigital').AsString.Trim = '' then
            raise Exception.Create('Certificado não escolhido, favor verificar configurações!');
         DM.ACBrNFe.Configuracoes.Certificados.ArquivoPFX := QueParam.FieldByName('PastaCertDigital').AsString.Trim;
         DM.ACBrNFe.Configuracoes.Certificados.Senha      := QueParam.FieldByName('SenhaCertMan').AsString.Trim;
         DM.ACBrNFe.Configuracoes.Arquivos.PathSchemas    := QueParam.FieldByName('PastaManifesto').AsString.Trim+'\Schemas';
         QueFili.SQL.Text := 'SELECT CNPJFil FROM arqfilial WHERE IDFilial = '+auxIDFil.ToString;
         QueFili.Open;
         Application.CreateForm(TFrmJustManiDest, FrmJustManiDest);
         FrmJustManiDest.recNomPess    := TabManDestNomPess.AsString;
         FrmJustManiDest.recNotFis     := TabManDestNotFis.AsInteger;
         FrmJustManiDest.recNroSerie   := TabManDestNroSerie.AsInteger;
         FrmJustManiDest.recDatEmi     := TabManDestDatEmi.AsDateTime;
         FrmJustManiDest.recVlrNotFis  := TabManDestVlrNotFis.AsFloat;
         FrmJustManiDest.recIDChaAce   := TabManDestIDChaAce.AsString;
         FrmJustManiDest.recCNPJFil    := QueFili.FieldByName('CNPJFil').AsString;
         FrmJustManiDest.recIDFilial   := auxIDFil;
         FrmJustManiDest.recACBrNFe    := DM.ACBrNFe;
         FrmJustManiDest.recCNPJCPFFor := TabManDestCNPJCPFFor.AsString;
         FrmJustManiDest.ShowModal;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Certificado não selecionado em uManiDest -> '+E.Message);
            MostraMsg('Erro',E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
   finally
      FrmJustManiDest.Free;
      QueFili.Close;
      QueParam.Close;
      FreeAndNil(QueFili);
      FreeAndNil(QueParam);
   end;

   TabManDest.Filtered := False;
   TabManDest.Close;
   TabManDest.Open;
   dgDados.DataSource.DataSet.RecNo := Index;
   dgDados.Refresh;
end;

procedure TFrmManiDest.btImportarClick(Sender: TObject);
var
   FileName,Path,Ano,Mes:string;
   QueFili:TRESTDWClientSQL;
   Index:integer;
   auxAchoArq:boolean;
begin
   auxAchoArq := False;
   Index := dgDados.DataSource.DataSet.RecNo;
   TabManDest.Filtered := False;
   TabManDest.Filter   := 'IndSel = 1';
   TabManDest.Filtered := True;

   if TabManDest.RecordCount > 1 then
   begin
      MostraMsg('Aviso','Favor selecionar apenas uma NFe!',mtWarning, [mbOk]);
      TabManDest.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end;

   if TabManDest.RecordCount < 1 then
   begin
      MostraMsg('Aviso','Nenhma NFe selecionada!',mtWarning, [mbOk]);
      TabManDest.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end;

   Ano := IntToStr(Year(TabManDestDatEmi.AsDateTime));
   Mes := StrZero(IntToStr(Month(TabManDestDatEmi.AsDateTime)),2);
   FileName := DM.ACBrNFe.Configuracoes.Arquivos.DownloadDFe.PathDownload;
   Path := FileName+'\'+Ano+Mes+'\'+TabManDestIDChaAce.AsString+'-nfe.xml';

   if FileExists(Path) then
      auxAchoArq := True
   else
   begin
      if Mes = '12' then
      begin
         Ano := IntToStr(StrToInt(Ano)+1);
         Mes := '01';
      end
      else Mes := IntToStr(StrToInt(Mes) + 1);
      Mes := StrZero(Mes,2);
      Path := FileName+'\'+Ano+Mes+'\'+TabManDestIDChaAce.AsString+'-nfe.xml';
      if FileExists(Path) then auxAchoArq := True;
   end;

   if not auxAchoArq then
   begin
      MostraMsg('Aviso','Não foi encontrado o XML desta NFe!',mtWarning, [mbOk]);
      TabManDest.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end;

   recNomArqXML := Path;
   recImporta   := True;
   TabManDest.Filtered := False;
   dgDados.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   dgDados.Refresh;
   btFecharClick(Sender);
end;

procedure TFrmManiDest.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   Index:integer;
begin
   Index := dgDados.DataSource.DataSet.RecNo; //Salva o índice
   TabManDest.Filtered := False;
   TabManDest.Filter   := 'IndSel = 1';
   TabManDest.Filtered := True;
   if TabManDest.RecordCount < 1 then
   begin
      MostraMsg('Aviso','Nenhma NFe selecionada!',mtWarning, [mbOk]);
      TabManDest.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end; // if
   if MostraMsg('Confirmação','Confirma exclusão das notas fiscais selecionadas?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;

   ShowWait('Aguarde...', Self);
   TabManDest.DisableControls;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      TabManDest.First;
      while not TabManDest.Eof do
      begin
         if TabManDestIndSel.AsString = '1' then // se for 1 está marcado vai excluir
         begin
            try
               QueAuxi.SQL.Text := 'DELETE FROM arqmandest WHERE IDManDest = '+TabManDestIDManDest.AsString;
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir de arqmandest em uManiDest -> '+E.Message);
                  MostraMsg('Erro','Não foi possível Excluir as notas fiscais selecionadas.'+#10+E.Message, mtError, [mbOk]);
               end;
            end;
         end; //if
         TabManDest.Next;
      end; //while
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      TabManDest.EnableControls;
      TabManDest.Filtered := False;
      TabManDest.Close;
      TabManDest.Open;
      HideWait;
   end; // try
   
   if not (TabManDest.IsEmpty) then
   begin
      if TabManDest.RecordCount > Index then
      begin
         dgDados.DataSource.DataSet.RecNo := Index;
         dgDados.Refresh;
      end else
      begin
         index := TabManDest.RecordCount;
         dgDados.DataSource.DataSet.RecNo := Index;
         dgDados.Refresh;
      end;
   end; //if
end;

procedure TFrmManiDest.ckALancarClick(Sender: TObject);
begin
   ckLancada.Checked  := False;
   ckPendente.Checked := False;
end;

procedure TFrmManiDest.ckLancadaClick(Sender: TObject);
begin
   ckPendente.Checked := False;
   ckALancar.Checked  := False;
end;

procedure TFrmManiDest.ckPendenteClick(Sender: TObject);
begin
   ckLancada.Checked := False;
   ckALancar.Checked := False;
end;

procedure TFrmManiDest.dgDadosCellClick(Column: TColumn);
begin
   if TabManDest.RecordCount > 0 then
   begin
      if Column.FieldName = 'IndSel' then
      begin
         if not (TabManDest.State in dsEditModes) then TabManDest.Edit;
         TabManDestIndSel.AsString := iif(TabManDestIndSel.AsString = '0','1','0');
         TabManDest.Post;
         dgDados.SelectedField := TabManDestNomPess;
      end;
   end; //if
end;

procedure TFrmManiDest.dgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if not TabManDest.IsEmpty then
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
         TDBGrid(Sender).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end else
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
        (Sender as TDBGrid).Canvas.Brush.Color := $00FDF2EC;
        (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      end;
      (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;

   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;

   if (Column.FieldName = 'IndSel') and (TabManDest.RecordCount > 0) then
   begin
      dgDados.Canvas.FillRect(Rect);
      if TabManDestIndSel.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if

   if Column.Field = dgDados.DataSource.DataSet.FieldByName('StatusNFE') then
   begin
      if Column.Field.Asstring = '1' then
      begin
         dgDados.Canvas.FillRect(Rect);
         dgDados.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'A LANÇAR');
      end else if Column.Field.Asstring = '2' then
      begin
         dgDados.Canvas.FillRect(Rect);
         dgDados.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'PENDENTE');
      end else if Column.Field.Asstring = '3' then
      begin
         dgDados.Canvas.FillRect(Rect);
         dgDados.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'LANÇADA');
      end;
   end; //if

   if Column.Field = dgDados.DataSource.DataSet.FieldByName('ManNFE') then
   begin
      if Column.Field.Asstring = '1' then
      begin
         dgDados.Canvas.FillRect(Rect);
         dgDados.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'AUTORIZADO');
      end else if Column.Field.Asstring = '2' then
      begin
         dgDados.Canvas.FillRect(Rect);
         dgDados.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'DENEGADO');
      end else if Column.Field.Asstring = '3' then
      begin
         dgDados.Canvas.FillRect(Rect);
         dgDados.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'CANCELADO');
      end else if Column.Field.Asstring = '4' then
      begin
         dgDados.Canvas.FillRect(Rect);
         dgDados.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'ENCERRADO');
      end;
   end; //if
end;

procedure TFrmManiDest.dgDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (dgDados.DataSource.DataSet.RecNo = dgDados.DataSource.DataSet.RecordCount) then Abort;
end;

procedure TFrmManiDest.edNomfilCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edNomfil),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmManiDest.edNomfilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key <> VK_RETURN then
      btBuscas('arqfilial',TLMDEdit(edNomfil),'IDFilial','Nomfil','',Key,True);
end;

procedure TFrmManiDest.edNomPesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNomPes),'IDPess','Nompes','',0,True);
end;

procedure TFrmManiDest.edNomPesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key <> VK_RETURN then
      btBuscas('arqpessoa',TLMDEdit(Sender),'IDPess','Nompes','',Key);
end;

procedure TFrmManiDest.btFecharClick(Sender: TObject);
begin
   Close;
end;

end.
