unit uDM;

interface

uses
  SysUtils, Classes, System.JSON, Dialogs, FireDAC.Dapt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Phys.FB,FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Stan.StorageJSON,
  FireDAC.Phys.MSSQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.MySQL, Vcl.ExtCtrls,
  FireDAC.Comp.DataSet, MarcFMX, VCL.Forms, IdCoderMIME, System.Math, System.StrUtils,
  System.DateUtils, uRESTDWDatamodule, uRESTDWParams, uRESTDWServerContext, spdNFCe,
  uRESTDWServerEvents, uRESTDWBasic, uRestDWDriverFD, uRESTDWBasicDB, spdNFCeDataSets,
  uRESTDWComponentBase, spdNFeDataSets, System.IniFiles, spdNFe, uCalculaNF, ACBrBase,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.Intf, spdNFCeType, System.Contnrs, ACBrDFe, ACBrNFe,
  uCertificados;

const
  WelcomeSample = False;

type
  TDMServer = class(TServerMethodDataModule)
    RESTDWPoolerDB: TRESTDWPoolerDB;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDConnect: TFDConnection;
    RESTDWDriverFD: TRESTDWDriverFD;
    DWServerEvents: TRESTDWServerEvents;
    spdNFe_base: TspdNFe;
    spdNFeDS: TspdNFeDataSets;
    spdNFCe: TspdNFCe;
    spdNFCeDS: TspdNFCeDataSets;
    ACBrNFe: TACBrNFe;
    procedure ServerMethodDataModuleDestroy(Sender: TObject);
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure DWServerEvents1EventsDownloadFileReplyEvent(var Params:TRESTDWParams; var Result: string);
    procedure DWServerEvents1EventsDataServerReplyEvent(var Params:TRESTDWParams; var Result: string);
    procedure DWServerEvents1EventsUpLoadFileReplyEvent(var Params:TRESTDWParams; var Result: string);
    procedure DWServerEventsEventsEmiteNFReplyEvent(var Params: TRESTDWParams; var Result: string);
    procedure DWServerEventsEventsGetCertificadosReplyEvent(var Params: TRESTDWParams; var Result: string);
    function  EmiteNFPed(recTabela,recFILIAL,NroDocto:String; out recXML:String; Preview:Boolean = False):String;
    procedure DWServerEventsEventsGetXMLReplyEvent(var Params: TRESTDWParams; var Result: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses uDWServer, uGeraNFe, uGeraNFCe, uNFCRetorno;

procedure TDMServer.ServerMethodDataModuleCreate(Sender: TObject);
begin
   RESTDWPoolerDB.Active := True;
end;

procedure TDMServer.DWServerEvents1EventsDataServerReplyEvent(var Params:TRESTDWParams; var Result: string);
begin
   Params.ItemsString['DataNow'].AsDateTime := Now;
end;

procedure TDMServer.DWServerEvents1EventsDownloadFileReplyEvent(var Params:TRESTDWParams; var Result: string);
var
   vArquivo:String;
   vFile:TMemoryStream;
begin
   if Params.ItemsString['Arquivo'] <> nil then
   begin
      vFile := TMemoryStream.Create;
      try
         try
            vArquivo := DirName+Trim(Params.ItemsString['Arquivo'].AsString);
            if vArquivo <> '' Then
            begin
               if FileExists(vArquivo) then
               begin
                  vFile.LoadFromFile(vArquivo);
                  vFile.Position  := 0;
                  Params.ItemsString['Result'].LoadFromStream(vFile);
               end;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(ArqLog,'ERRO: tentando DownloadFile: '+vArquivo+' -> '+E.Message);
               Exit;
            end;
         end;
      finally
         FreeAndNil(vFile);
      end;
   end; //if
end;

procedure TDMServer.DWServerEvents1EventsUpLoadFileReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   JSONValue: TJSONValue;
   vArquivo,vDiretorio: String;
   vFileIn,vFile:TMemoryStream;
begin
   if Params.ItemsString['arquivo'] <> nil Then
   begin
      vDiretorio := '';
      if Params.ItemsString['diretorio'] <> nil then
      begin
         if Params.ItemsString['diretorio'].AsString <> '' then
         begin
            vDiretorio := IncludeTrailingPathDelimiter(Params.ItemsString['diretorio'].AsString);
            ForceDirectories(vDiretorio);
         end;
      end; //if
      JSONValue := TJSONValue.Create;
      JSONValue.Encoding := Encoding;
      vArquivo := vDiretorio + Trim(ExtractFileName(Params.ItemsString['arquivo'].AsString));
      if FileExists(vArquivo) then DeleteFile(vArquivo);
      vFileIn := TMemoryStream.Create;
      Params.ItemsString['filesend'].SaveToStream(vFileIn);
      try
         vFileIn.Position   := 0;
         vFileIn.SaveToFile(vArquivo);
      finally
         if Params.ItemsString['result'] <> nil then Params.ItemsString['result'].AsBoolean := (vFileIn.Size > 0);
         vFileIn.Clear;
         vFileIn.Free;
      end;
   end; //if
end;

// -------------- Recebe Parametros P/ Emissão de NF (Mod.55) -------------- //
procedure TDMServer.DWServerEventsEventsEmiteNFReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   CPFnf,Mailnf:Boolean;
   Tabela,NroDocto,rFilial,Modelo,recXML:String;
begin
   if (Params.ItemsString['Tabela'] = nil) or (Params.ItemsString['NroDocto'] = nil) then Exit;
   rFilial  := Params.ItemsString['FILIAL'].AsString;
   Tabela   := Params.ItemsString['Tabela'].AsString;
   Modelo   := Params.ItemsString['Modelo'].AsString;
   NroDocto := Params.ItemsString['NroDocto'].AsString;
   CPFnf    := Params.ItemsString['CPFnf'].AsString  = '1';
   Mailnf   := Params.ItemsString['Mailnf'].AsString = '1';
   if Tabela = 'arqpedido' then
   begin
      if Modelo = '65' then
           Params.ItemsString['Result'].AsString := GerarNFC(rFilial, NroDocto, CPFnf, Mailnf)
      else Params.ItemsString['Result'].AsString := EmiteNFPed(Tabela, rFilial, NroDocto, recXML);
   end;
end;

// ----------- Retorna os Certificados Disponíveis no Servidor ---------- //
procedure TDMServer.DWServerEventsEventsGetCertificadosReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   txtRaza,txtCNPJ,txtCert,txtVenc,txtSeri:String;
   iteRaza,iteCNPJ,iteCert,iteVenc,iteSeri:TStringList;
begin
   txtRaza := '';
   txtCert := '';
   txtVenc := '';
   txtSeri := '';
   iteRaza := TStringList.Create;
   iteCNPJ := TStringList.Create;
   iteCert := TStringList.Create;
   iteVenc := TStringList.Create;
   iteSeri := TStringList.Create;
   try
      ACBrNFe.SSL.LerCertificadosStore;
      for var I := 0 to ACBrNFe.SSL.ListaCertificados.Count-1 do
      begin
         with ACBrNFe.SSL.ListaCertificados.Items[I] do
         begin
            txtRaza := txtRaza + RazaoSocial+'|';
            txtCNPJ := txtCNPJ + FormataCGC(CNPJ)+'|';
            txtSeri := txtSeri + NumeroSerie+'|';
            txtVenc := txtVenc + DateToStr(DataVenc)+'|';
            txtCert := txtCert + FormatDNOrdered(SubjectName,NumeroSerie)+'|';
         end;  //with
      end; // for
      Params.ItemsString['Razao'].AsString        := txtRaza;
      Params.ItemsString['CNPJ'].AsString         := txtCNPJ;
      Params.ItemsString['Serie'].AsString        := txtSeri;
      Params.ItemsString['Vencimentos'].AsString  := txtVenc;
      Params.ItemsString['Certificados'].AsString := txtCert;
   finally
      iteRaza.Free;
      iteCNPJ.Free;
      iteCert.Free;
      iteVenc.Free;
      iteSeri.Free;
   end;
end;

// -------------------- Retorna o XML de Uma NF -------------------- //
procedure TDMServer.DWServerEventsEventsGetXMLReplyEvent(var Params: TRESTDWParams; var Result: string);
var
   Preview:Boolean;
   vFile:TMemoryStream;
   ChaveNF,ModeloNF,rFilial,Tabela,NroDocto,recXML:String;
begin
   if Params.ItemsString['Filial']    = nil then Exit;
   if Params.ItemsString['ChaveNF']   = nil then Exit;
   if Params.ItemsString['ModeloNF']  = nil then Exit;
   rFilial  := Params.ItemsString['Filial'].AsString;
   ChaveNF  := Params.ItemsString['ChaveNF'].AsString.Trim;
   ModeloNF := Params.ItemsString['ModeloNF'].AsString.Trim;
   Tabela   := Params.ItemsString['Tabela'].AsString;
   NroDocto := Params.ItemsString['NroDocto'].AsString;
   ConfAmbienteNF(spdNFe_base);
   EmiteNFPed(Tabela, rFilial, NroDocto, recXML, True);
   Params.ItemsString['arqXML'].AsString := recXML;
end;

// -------------- Emissão de NF (Mod.55) -------------- //
function TDMServer.EmiteNFPed(recTabela,recFILIAL,NroDocto:String; out recXML:String; Preview:Boolean = False):String;
var
   I:Integer;
   SL:TStringList;
   Capa: TCapaNF;
   Destino: TDestNF;
   Entrega: TLocalEnt;
   InfFiscal: TArray<TInfFiscal>;
   InfCompl: TArray<TInfCompl>;
   refNFe: TArray<TNFRefer>;
   ItensNF: TArray<TItemNF>;
   Transp: TTransporte;
   Volumes: TVolumes;
   Pagtos: TArray<TDadosPag>;
   auxCST,Retorno,TabelaIte,TabelaPag,preCFOP:String;
   QuePedi,QueItem,QueParam,QuePagto,QueNFref,QueTxApr: TFDQuery;
begin
   Result   := '';
   QuePedi  := TFDQuery.Create(nil);
   QueItem  := TFDQuery.Create(nil);
   QueParam := TFDQuery.Create(nil);
   QuePagto := TFDQuery.Create(nil);
   QueNFref := TFDQuery.Create(nil);
   QueTxapr := TFDQuery.Create(nil);
   QuePedi.Connection  := FDConnect;
   QueItem.Connection  := FDConnect;
   QueParam.Connection := FDConnect;
   QuePagto.Connection := FDConnect;
   QueNFref.Connection := FDConnect;
   QueTxapr.Connection := FDConnect;
   TabelaIte := iif(recTabela = 'arqpedido', 'arqpedidoite', 'arqnfevenite');
   TabelaPag := iif(recTabela = 'arqpedido', 'arqpedidopag', 'arqnfevenpag');

   try
      try
         // ------ Abre Tabelas de Pedido e Itens ------ //
         QuePedi.Close;
         QuePedi.SQL.Text := 'SELECT PED.*,PES.*,MUN.*,ICM.* FROM '+recTabela+' PED '+
         'LEFT JOIN arqpessoa PES ON PED.IDPess = PES.IDPess '+
         'LEFT JOIN arqmuni MUN ON MUN.Codmun = PES.Codmun '+
         'LEFT JOIN arqicmsuf ICM ON MUN.Estmun = ICM.UFICMS '+
         'WHERE PED.IDFilial = '+recFILIAL+' AND PED.IDPed = '+NroDocto;
         QuePedi.Open;

         QueItem.SQL.Text := 'SELECT PEI.*,PRO.*,UNV.*,RT.PerRedCBS,RT.PerRedIBS FROM '+TabelaIte+' PEI '+
         'LEFT JOIN arqproduto PRO ON PEI.IDProd = PRO.IDProd '+
         'LEFT JOIN arqunidades UNV ON PRO.IDUniVen = UNV.IDUni '+
         'LEFT JOIN arqclaivaite RT ON PRO.CodClasIte = RT.CodClasIte '+
         'WHERE PEI.IDFilial = '+recFILIAL+' AND PEI.IDPed = '+NroDocto;
         QueItem.Open;
         if QueItem.IsEmpty then raise Exception.Create('Não existem produtos nesse pedido');

         QuePagto.SQL.Text :=
         'SELECT PAG.*, PGT.IndPagVis, PGT.IDForPagNF, CAR.CNPJadi, GNF.IDGruCard FROM '+TabelaPag+' PAG '+
         'LEFT JOIN arqforpagto PGT ON PAG.IDForPag = PAG.IDForPag '+
         'LEFT JOIN arqcartao CAR ON PAG.IDCartao = CAR.IDCartao '+
         'LEFT JOIN arqforpagnf GNF ON GNF.IDForPagNF = PGT.IDForPagNF '+
         'WHERE PAG.IDFilial = '+recFILIAL+' AND PAG.IDPed = '+NroDocto;
         QuePagto.Open;
         if QuePagto.IsEmpty then raise Exception.Create('Não existem formas de pagamento nesse pedido');

         if recTabela = 'arqnfeven' then
         begin
            QueNFref.SQL.Text := 'SELECT * FROM arqnfevenref WHERE PAG.IDFilial = '+recFILIAL+' AND PAG.IDPed = '+NroDocto;
            QueNFref.Open;
         end;

         // ----- Configurações Gerais da NFe ----- //
         QueParam.SQL.Text := 'SELECT * FROM arqparametros PAR LEFT JOIN arqicmsuf ICM ON PAR.Estmun = ICM.UFICMS LIMIT 1';
         QueParam.Open;

         // ---- Geração dos Registros ---- //
         auxCST  := iif(QueParam.FieldByName('RegTributa').AsString = '1', QueItem.FieldByName('CSOSN').AsString, Copy(QueItem.FieldByName('CSTICMS').AsString,2,2));
         preCFOP := iif(QueParam.FieldByName('Estmun').AsString = QuePedi.FieldByName('Estmun').AsString,'5','6');
         with Capa do
         begin
            Tabela      := recTabela;
            Pedido      := NroDocto;
            tpNF        := '1'; // Saída
            regime      := iif(QueParam.FieldByName('RegTributa').AsString = '1', TRegime.rtSimples, TRegime.rtRPA);
            CFOP        := preCFOP + iif(MatchStr(auxCST,['60','201','202','203','500']),'405','102');
            natOp       := 'VENDA DE MERCADORIA ADQ. DE TERCEIRO';
            Difal       := QueParam.FieldByName('IndDIFAL').AsBoolean;
            UFOrigem    := QueParam.FieldByName('Estmun').AsString;
            UFDestino   := QuePedi.FieldByName('Estmun').AsString;
            indFinal    := QuePedi.FieldByName('CpfCnpjPes').AsString.Trim.Length = 11;
            ContrICMS   := OnlyNumbers(QuePedi.FieldByName('InsEstPes').AsString.Trim) <> '';
            AliInterna  := QueParam.FieldByName('PerICMS').AsFloat;
            AliExterna  := QuePedi.FieldByName('PerICMS').AsFloat;
            SerieNF     := QueParam.FieldByName('SerNFe').AsString;
            DestinoOper := iif(QueParam.FieldByName('Estmun').AsString = QuePedi.FieldByName('Estmun').AsString, TDestinoOper.doInterna, TDestinoOper.doInterestadual);
            indPres     := '1';
            finNFe      := '1';
            VFrete      := QuePedi.FieldByName('VlrFrete').AsFloat;
            VSeg        := QuePedi.FieldByName('VlrSeguro').AsFloat;
            VOutro      := QuePedi.FieldByName('VlrOutros').AsFloat;
            VDescFim    := QuePedi.FieldByName('VlrDesc').AsFloat;
            DatHorSai   := IncMinute(Now(),1);
         end; //with

         with Destino, QuePedi do
         begin
            CpfCnpj := FieldByName('CpfCnpjPes').AsString;
            xNome   := FieldByName('Nompes').AsString;
            xLgr    := FieldByName('Endpes').AsString;
            nro     := FieldByName('Nroend').AsString;
            xCpl    := FieldByName('CompEnd').AsString;
            xBairro := FieldByName('Baipes').AsString;
            cMun    := FieldByName('Codmun').AsString;
            xMun    := FieldByName('Nommun').AsString;
            UF      := FieldByName('Estmun').AsString;
            IE      := FieldByName('InsEstPes').AsString;
            CEP     := FieldByName('Ceppes').AsString;
            fone    := FieldByName('CelularPes').AsString;
            email   := FieldByName('EmailPes').AsString;
         end; //with

         // ----- Taxas Aproximadas - IBPT ----- //
         QueTxapr.SQL.Text := 'SELECT * FROM arqibpt WHERE UF = :UF AND CodNCM = :CodNCM';

         // ------------------- ITENS DA NF-E ------------------- //
         with QueItem do
         begin
            I := 0;
            SetLength(ItensNF, RecordCount);
            First;
            while not Eof do
            begin
               if QueTxapr.Active then QueTxapr.Close;
               QueTxapr.ParamByName('UF').AsString     := QueParam.FieldByName('Estmun').AsString;
               QueTxapr.ParamByName('CodNCM').AsString := FieldByName('CodNCM').AsString;
               QueTxapr.Open;
               ItensNF[I].cProd         := FieldByName('IDProd').AsInteger;
               ItensNF[I].cEAN          := iif(FieldByName('CodEANpri').AsString.Trim = '', 'SEM GTIN', FieldByName('CodEANpri').AsString);
               ItensNF[I].NCM           := FieldByName('CodNCM').AsString;
               ItensNF[I].xProd         := FieldByName('Despro').AsString.Trim;
               ItensNF[I].CEST          := FieldByName('CodCEST').AsString;
               ItensNF[I].CodBenFis     := FieldByName('CodBenFis').AsString;
               ItensNF[I].uCom          := FieldByName('SiglaUN').AsString;
               ItensNF[I].qCom          := FieldByName('Qtdped').AsFloat;
               ItensNF[I].vUnCom        := FieldByName('PrecoVen').AsFloat;
               ItensNF[I].vDesc         := FieldByName('VlrDesc').AsFloat;
               ItensNF[I].CFOP          := preCFOP + iif(MatchStr(auxCST,['60','201','202','203','500']),'405','102');
               ItensNF[I].CST_CSON      := iif(Capa.regime = TRegime.rtSimples, FieldByName('CSOSN').AsString, Copy(FieldByName('CSTICMS').AsString,2,2));
               ItensNF[I].Origem        := Copy(FieldByName('CSTICMS').AsString,1,1);
               ItensNF[I].AliqICMS      := QueParam.FieldByName('PerICMS').AsFloat;
               ItensNF[I].AliqFCP       := QueParam.FieldByName('PerFCP').AsFloat;
               ItensNF[I].AliqICMSDest  := QuePedi.FieldByName('PerICMS').AsFloat;
               ItensNF[I].AliqFCPDest   := QuePedi.FieldByName('PerFCP').AsFloat;
               ItensNF[I].AliqRedBC     := FieldByName('AliqRedICM').AsFloat;
               ItensNF[I].TpTriICMS     := FieldByName('TipoTriICMS').AsInteger;
               ItensNF[I].CST_PIS       := StrZero(Copy(FieldByName('CodnatSai').AsString,2,2),2);
               ItensNF[I].CST_COFINS    := StrZero(Copy(FieldByName('CodnatSai').AsString,2,2),2);
               ItensNF[I].AliqPIS       := QueParam.FieldByName('PercPIS').AsFloat;
               ItensNF[I].AliqCOFINS    := QueParam.FieldByName('PerCOFINS').AsFloat;
               ItensNF[I].ClassRT       := FieldByName('CodClasIte').AsString;
               ItensNF[I].AliqIS        := FieldByName('AliqIS').AsFloat;
               ItensNF[I].AliqIBSEst    := QueParam.FieldByName('AliqIBSEst').AsFloat;
               ItensNF[I].AliqIBSMun    := QueParam.FieldByName('AliqIBSMun').AsFloat;
               ItensNF[I].AliqCBS       := QueParam.FieldByName('AliqCBS').AsFloat;
               ItensNF[I].PerRedIBS     := FieldByName('PerRedIBS').AsFloat;
               ItensNF[I].PerRedCBS     := FieldByName('PerRedCBS').AsFloat;
               ItensNF[I].TribMun       := QueTxapr.FieldByName('TaxaMun').AsFloat;
               ItensNF[I].TribEst       := QueTxapr.FieldByName('TaxaEst').AsFloat;
               ItensNF[I].TribFed       := QueTxapr.FieldByName('TaxaFed').AsFloat;
               ItensNF[I].TribImp       := QueTxapr.FieldByName('TaxaImp').AsFloat;
               ItensNF[I].AliqCreICMSSN := QueParam.FieldByName('PerCreICMSSN').AsFloat;
               ItensNF[I].AliqICMSST    := 0.00;
               ItensNF[I].MVA_ST        := 0.00;
               ItensNF[I].RedBCST       := 0.00;
               QueTxapr.Close;
               Inc(I);
               Next;
            end; //while
         end; //with

         // ------ Dados de Pagamentos ------ //
         with QuePagto do
         begin
            I := 0;
            SetLength(Pagtos, RecordCount);
            First;
            while not Eof do
            begin
               Pagtos[I].indPag := iif(FieldByName('IndPagVis').AsString = '0','1','0');
               Pagtos[I].tPag   := FieldByName('IDForPagNF').AsString;
               Pagtos[I].vPag   := FieldByName('VlrPago').AsFloat;
               Pagtos[I].dPag   := DateOf(Now());
               if FieldByName('IDGruCard').AsBoolean then
               begin
                  Pagtos[I].tpIntegra := '1'; //iif(FieldByName('IndPOS').AsString = '1','2','1');
                  Pagtos[I].CNPJ  := FieldByName('CNPJadi').AsString;
                  Pagtos[I].tBand := FieldByName('IDBan').AsString.PadLeft(2,'0');
                  Pagtos[I].cAut  := FieldByName('NroNSU').AsString.Trim;
               end
               else Pagtos[I].CNPJ := '';
               Inc(I);
               Next;
            end; //while
         end; //with

         if recTabela = 'arqnfeven' then
         begin
            // ----- Local de Entrega ----- //
            Transp.modFrete := QuePedi.FieldByName('TipFrete').AsString;
            Transp.CpfCnpj  := OnlyNumbers(QuePedi.FieldByName('CpfCnpjTran').AsString);
            Transp.xNome    := QuePedi.FieldByName('NomeTran').AsString;
            Transp.xEnder   := QuePedi.FieldByName('EndTran').AsString;
            Transp.xMun     := QuePedi.FieldByName('CidTran').AsString;
            Transp.UF       := QuePedi.FieldByName('EstTran').AsString;
            Transp.IE       := QuePedi.FieldByName('IETran').AsString;
            Transp.placa    := QuePedi.FieldByName('PlaVeiTran').AsString;
            Transp.UF_Placa := QuePedi.FieldByName('UFPlaVeiTran').AsString;
            Transp.RNTC     := QuePedi.FieldByName('RNTCTran').AsString;

            // ---- NF Referenciada ---- //
            if not QueNFref.IsEmpty then
            begin
               I := 0;
               SetLength(refNFe, QueNFref.RecordCount);
               while not QueNFref.Eof do
               begin
                  refNFe[I].refNFe := QueNFref.FieldByName('ChaveNF').AsString.Trim;
                  QueNFref.Next;
               end;
            end; //if

            // -------- Observações Fiscais -------- //
            // SetLength(InfFiscal,1);
            // InfFiscal[0].infAdFisco := '';
            SL := TStringList.Create;
            try
               SL.Text := QuePedi.FieldByName('ObsNF').AsString;
               if SL.Count > 0 then
               begin
                  SetLength(InfCompl, SL.Count);
                  for I := 0 to SL.Count -1 do InfCompl[I].infCpl := SL[I];
               end;
            finally
               SL.Free;
            end;
         end
         else Transp.modFrete := '9';

         Retorno := GerarNF(Capa, Destino, Entrega, InfFiscal, InfCompl, refNFe, ItensNF, Transp, Volumes, Pagtos, spdNFe_base, recFilial, recXML);
         if Retorno <> '' then raise Exception.Create(Retorno);
      except
         on E:Exception do
         begin
            Result := 'ERRO ao tentar gerar NFe -> '+E.Message;
            Exit;
         end;
      end;
   finally
      QuePedi.Close;   FreeAndNil(QuePedi);
      QueItem.Close;   FreeAndNil(QueItem);
      QueParam.Close;  FreeAndNil(QueParam);
      QuePagto.Close;  FreeAndNil(QuePagto);
      QueTxapr.Close;  FreeAndNil(QueTxapr);
      QueNFref.Close;  FreeAndNil(QueNFref);
   end;
end;

procedure TDMServer.ServerMethodDataModuleDestroy(Sender: TObject);
begin
   FDConnect.Close;
   RESTDWPoolerDB.Active := False
end;

end.

