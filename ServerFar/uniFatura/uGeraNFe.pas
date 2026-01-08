unit uGeraNFe;

interface

uses
   Windows, Messages, Forms, Classes, Controls, Dialogs, ExtCtrls, System.StrUtils,
   spdNFeUtils, spdNFe, spdNFeType, System.SysUtils, MarcLib, DateUtils, uNFRetorno,
   System.IOUtils, uCalculaNF, uImpostosRT, uConst, uXMLAutorizado, System.Math,
   FireDAC.Comp.Client;

   type
   // Dados da capa (parte inicial) da NFe
   TCapaNF = record
      Tabela      : String;
      Pedido      : String;
      regime      : TRegime;
      CFOP        : String;
      natOp       : String;
      DatHorSai   : TDateTime;
      tpNF        : String;
      idDest      : String;
      finNFe      : String;
      tpNFDebito  : String;
      tpNFCredito : String;
      indPres     : String;
      UFOrigem    : String;
      UFDestino   : String;
      Difal       : Boolean;
      indFinal    : Boolean;
      ContrICMS   : Boolean;
      AliInterna  : Double;
      AliExterna  : Double;
      SerieNF     : String;
      DestinoOper : TDestinoOper;
      VFrete      : Double;
      VSeg        : Double;
      VOutro      : Double;
      VDescFim    : Double;
   end;

   // Dados do destinatário da NFe
   TDestNF = record
     CpfCnpj   : String;
     xNome     : String;
     xLgr      : String;
     nro       : String;
     xCpl      : String;
     xBairro   : String;
     cMun      : String;
     xMun      : String;
     UF        : String;
     CEP       : String;
     fone      : String;
     IE        : String;
     indIEDest : String;
     email     : String;
   end;

   // Dados do Local da Entrga da NFe
   TLocalEnt = record
     CpfCnpj : String;
     xNome   : String;
     xLgr    : String;
     nro     : String;
     xCpl    : String;
     xBairro : String;
     cMun    : String;
     xMun    : String;
     UF      : String;
     CEP     : String;
     fone    : String;
     IE      : String;
     email   : String;
   end;

   // Item usado para início da geração itens NFe
   TItemNF = record
     cProd         : Integer;    MVA_ST     : Double;
     cEAN          : String;     RedBCST    : Double;
     NCM           : String;     CST_PIS    : String;
     xProd         : String;     AliqPIS    : Double;
     CEST          : String;     CST_COFINS : String;
     CFOP          : String;     AliqCOFINS : Double;
     CodBenFis     : String;     Origem     : String;
     ClassRT       : String;     AliqIS     : Double;
     uCom          : String;     AliqIBSEst : Double;
     qCom          : Double;     AliqIBSMun : Double;
     vUnCom        : Double;     AliqCBS    : Double;
     vDesc         : Double;     PerRedIBS  : Double;
     CST_CSON      : String;     PerRedCBS  : Double;
     AliqICMS      : Double;     TribMun    : Double;
     AliqFCP       : Double;     TribEst    : Double;
     AliqICMSDest  : Double;     TribFed    : Double;
     AliqFCPDest   : Double;     TribImp    : Double;
     AliqRedBC     : Double;     TpTriICMS  : Integer;
     AliqCreICMSSN : Double;     AliqICMSST : Double;
     AliqIcmDif    : Double;
   end;

   // Dados de Transporte
   TTransporte = record
     modFrete : String;
     CpfCnpj  : String;
     xNome    : String;
     IE       : String;
     xEnder   : String;
     xMun     : String;
     UF       : String;
     placa    : String;
     UF_Placa : String;
     RNTC     : String;
   end;

   TVolumes = record
     qVol     : Integer;
     esp      : String;
     marca    : String;
     nVol     : Integer;
     pesoL    : Double;
     pesoB    : Double;
   end;

   // Dados da Forma de Pagamento
   TDadosPag = record
     indPag    : String;
     tPag      : String;
     vPag      : Double;
     dPag      : TDate;
     tpIntegra : String;
     CNPJ      : String;
     tBand     : String;
     cAut      : String;
   end;

   // Notas Fiscais Referenciadas
   TNFRefer = record
      refNFe : String;
   end;

   // Infomrações fiscais da NFe
   TInfFiscal = record
      infAdFisco : String;
   end;

   // Informações adicionais (campo onservações da NFe)
   TInfCompl = record
      infCpl : String;
   end;

   function MontarXML(XmlEnvi,XmlRet:String):Boolean;
   function ConfAmbienteNF(recSpdNFe:TspdNFe):Boolean;
   function InutilizaNF(NroNotIni:String; NroNotFim:String = ''; recMotivo:String = ''):Boolean;
   function GerarNF(Capa:TCapaNF; Dest:TDestNF; Entrega:TLocalEnt; InfFiscal:TArray<TInfFiscal>;
            InfCompl:TArray<TInfCompl>; refNFe:TArray<TNFRefer>; ItensNF:TArray<TItemNF>; Transp:TTransporte; Volumes:TVolumes;
            Pagtos:TArray<TDadosPag>; recSpdNFe:TspdNFe; recFilial:String; out retXML_NF:String; Preview:Boolean = False):String;

implementation

uses uDM, uLibServer;

var
   PastaNF:String;
   NRO_NOTA:Integer;
   NFSalvar: TNFSalvar;
   HOMOLOGANDO,CONTIGENCIA,RT_ATIVO:Boolean;
   PrintNF,uNFRetorno,MENEnvMailNF,SITEConsNF:String;

// ---------- Enviar XML (NF) ao SEFAZ --------- //
function EnviaNF(recSpdNFe:TspdNFe; recFILIAL:String; recNroPed:Integer; IN_CONT:Boolean; recXML_NF,recKEY_NF:String):TRetornoNFe;
var
   F:TextFile;
   NomArquivo,xpXML,XmlProc,retErro:String;
begin
   if IN_CONT then
   begin
      // ---------- Emissão em Contingência ---------- //
      NomArquivo := PastaNF+'\XMLContigencia\'+recKEY_NF+'.XML';
      AssignFile(F,NomArquivo);
      Rewrite(F);
      Writeln(F,recXML_NF);
      CloseFile(F);
      //locServer.spdNFe.ImprimirDaNFe('0001',recXML_NF,PastaNF+'\Templates\vm60\Danfc\retrato.rtm', PrintNF);
      NFSalvar.Status := 'F';
      SalvarNF(NFSalvar, recFILIAL, True);
      Result.cStat   := '100';
      Result.xMotivo := 'NFe emitida em contigência.';
   end else
   begin
      // ------------- Emissão Normal -------------- //
      Result := EnviarNFSincrono(recSpdNFe,'0001',recXML_NF);
      if not Result.Sucesso then
      begin
         NFSalvar.CodRet := iif(Result.CStat <> '', Result.CStat, '9999');
         SalvarNF(NFSalvar, recFILIAL);
         if MatchStr(Result.cStat,['108','109']) or (Result.CStat = '') then
              SalvaLog(USUARIO,PastaLog,'NFe não enviada - PEDIDO: '+recNroPed.ToString+' Chave: '+recKEY_NF+' -> '+Result.xMotivo)
         else SalvaLog(USUARIO,PastaLog,'NFe rejeitada ou denegada - PEDIDO: '+recNroPed.ToString+' Chave: '+recKEY_NF+' -> '+Result.cStat+' - '+Result.xMotivo);
      end else
      begin
         XmlProc := MontarNFeAutorizada_XML(recXML_NF, Result.XmlBruto);
         TFile.WriteAllText(PastaNF+'\XmlDestinoAIONE\'+Result.ChNFe+'-NFe.xml', XmlProc, TEncoding.UTF8);
         NFSalvar.CodRet := Result.CStat;
         NFSalvar.NroPro := Result.NProt;
         NFSalvar.Status := 'F';
         NFSalvar.NroNF  := Result.NrNota;
         NFSalvar.Chave  := Result.ChNFe;
         NFSalvar.DatEmi := Result.DhRecbto;
         SalvarNF(NFSalvar, recFILIAL);
      end;
   end; //if
end;

// --------- Inutilização de Número de NF Por Erro de Geração --------- //
function InutilizaNF(NroNotIni:String; NroNotFim:String = ''; recMotivo:String = ''):Boolean;
var
   cStat,xMotivo,xmlResult:String;
begin
(* ConfAmbienteNF;
   if NroNotFim.Trim = '' then NroNotFim := NroNotIni;
   if recMotivo.Trim = '' then recMotivo := 'ERRO DE GERACAO NUMERICA POR FALHA DO SISTEMA';
   xmlResult := DM.spdNFe.InutilizarNF('', Copy(IntToStr(Year(Date)),3,2), DM.spdNFe.CNPJ, '65', iif(HOMOLOGANDO,'2','1'), NronotIni, NronotFim, recMotivo);
   cStat     := obterNroResultado(xmlResult, '<cStat','</cStat',     Pos('<dhRecbto',xmlResult));
   xMotivo   := obterNroResultado(xmlResult, '<xMotivo','</xMotivo', Pos('<dhRecbto',xmlResult));
   Result.Sucesso := cStat = '100';
   Result.cStat   := cStat;
   Result.xMotivo := xMotivo; *)
end;

// ------------------ Geração da NF-e Para Emissão ---------------- //
function GerarNF(Capa:TCapaNF; Dest:TDestNF; Entrega:TLocalEnt; InfFiscal:TArray<TInfFiscal>; InfCompl:TArray<TInfCompl>;
                 refNFe:TArray<TNFRefer>; ItensNF:TArray<TItemNF>; Transp:TTransporte; Volumes:TVolumes;
                 Pagtos:TArray<TDadosPag>; recSpdNFe:TspdNFe; recFilial:String; out retXML_NF:String; Preview:Boolean = False):String;
var
   F:TextFile;
   TotImpApro,auxvProd:Double;
   DataHoje:TDateTime;
   Ac,NRO_NOTA:Integer;
   locServer:TDMServer;
   DocValorAdd: TDocAcessorios;
   IteCal: TArray<TItemEntrada>;
   aTotais: TTotaisNota;
   aImpostos: TArray<TItemImpostos>;
   RT_Itens: TArray<TItemInputRT>;
   RT_OutIt: TArray<TItemOutputRT>;
   RT_Tot: TTotaisNotaRT;
   retResNFe: TRetornoNFe;
   strInfFiscal,strInfCompl:AnsiString;
   auxUF,KEY_NF,XML_NF,auxCST,auxCSON,auxCST_CSON:String;
   QueAuxi,QueParam: TFDQuery;
   Tecno:TTecnoSpeed;
   auxTCSOSN: TCSOSN;
begin
   QueAuxi  := TFDQuery.Create(nil);
   QueParam := TFDQuery.Create(nil);
   locServer := TDMServer.Create(nil);
   QueAuxi.Connection  := locServer.FDConnect;
   QueParam.Connection := locServer.FDConnect;
   try
      try
         if not ConfAmbienteNF(recSpdNFe) then raise Exception.Create('Não foi possível configurar ambiente de NFe.');
         DataHoje := Now;

         // ------- Geração do Número e Chave da NF-e ------- //
         QueAuxi.SQL.Text := 'SELECT COALESCE(MAX(NroNF), 0) AS UltNotFis FROM '+
         '(SELECT NroNF FROM arqpedido WHERE ModNF = "55" AND IDFilial = '+recFILIAL+
         ' UNION ALL SELECT NroNF FROM arqnfeven WHERE ModNF = "55" AND IDFilial = '+recFILIAL+') AS t';
         QueAuxi.Open;
         NRO_NOTA := QueAuxi.FieldByName('UltNotFis').AsInteger;
         if NRO_NOTA <= 0 then
         begin
            // ---- Somente P/ Implantação ---- //
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'SELECT NroUltNFE FROM arqparametros LIMIT 1';
            QueAuxi.Open;
            NRO_NOTA := QueAuxi.FieldByName('NroUltNFE').AsInteger + 1;
            QueAuxi.Close;
         end; //if

         QueParam.SQL.Text := 'SELECT * FROM arqparametros LIMIT 1';
         QueParam.Open;

         //--> RT_ATIVO := (QueParam.FieldByName('RegTributa').AsString = '3') and (DateOf(DataServer) >= StrToDate('05/01/2026'));
         RT_ATIVO := True;

         // ---- Geração dos Registros TecnoSpeed ---- //
         with locServer.spdNFeDS do
         begin
            LoteNFe.Clear;
            auxUF         := Capa.UFOrigem;
            VersaoEsquema := pl_010b;
            XMLDicionario := PastaNF+'\Templates\vm60\Conversor\NFeDataSets.xml';
            ValidaRegrasNegocio := False;
            Incluir;
            begin
               Campo('Id_A03').Value       := '';
               Campo('versao_A02').Value   := '4.00';
               Campo('cUF_B02').Value      := CodigoUF(auxUF);
               Campo('cNF_B03').Value      := IntToStr(11111111 + Random(99999999 - 11111111 + 1));
               Campo('natOp_B04').Value    := Capa.natOp;
               Campo('mod_B06').Value      := '55';
               Campo('serie_B07').Value    := iif(HOMOLOGANDO,'99',Capa.SerieNF);
               Campo('nNF_B08').Value      := NRO_NOTA.ToString;
               Campo('dhEmi_B09').Value    := FormatDateTime('YYYY-mm-dd"T"HH:mm:ss', DataHoje)+'-03:00';
               Campo('dhSaiEnt_B10').Value := FormatDateTime('YYYY-mm-dd"T"HH:mm:ss', Capa.DatHorSai)+'-03:00';
               Campo('tpNF_B11').Value     := Capa.tpNF;
               Campo('cMunFG_B12').Value   := QueParam.FieldByName('Codmun').AsString;
         	   Campo('idDest_B11a').Value  := Ord(Capa.DestinoOper).ToString;
               Campo('tpImp_B21').Value    := '1';
               if CONTIGENCIA then
                    Campo('tpEmis_B22').Value := iif(AnsiMatchStr(auxUF, ['SP','RJ','MG','ES','PR','SC']), '6', '7')
               else Campo('tpEmis_B22').Value := '1';
               Campo('cDV_B23').Value         := '';
               Campo('tpAmb_B24').value       := iif(HOMOLOGANDO,'2','1');
               Campo('finNFe_B25').Value      := Capa.finNFe;
               if Capa.tpNFDebito <> ''  then Campo('tpNFDebito_B25_1').Value  := Capa.tpNFDebito;
               if Capa.TpNFCredito <> '' then Campo('tpNFCredito_B25_2').Value := Capa.TpNFCredito;
           	   Campo('indFinal_B25a').Value := iif(Capa.indFinal,'1','0');
            	Campo('indPres_B25b').Value  := Capa.indPres;
               //--> Campo('indIntermed_B25c').Value := '0';
               Campo('procEmi_B26').Value   := '0';
               Campo('verProc_B27').Value   := '1.00';

               if CONTIGENCIA then
               begin
                  Campo('xJust_B29').Value  := 'Erro ao conectar com Internet ou instabilidade do SEFAZ';
                  Campo('dhCont_B28').Value := FormatDateTime('YYYY-mm-dd"T"HH:mm:ss',QueParam.FieldByName('DatContNF').AsDateTime)+'-03:00';
               end;

               // ----- Grupo de Compra Governamental ----- //
               // Campo('tpEnteGov_B32').Value := ;
               // Campo('pRedutor_B33').Value  := ;
               // Campo('tpOperGov_B34').Value := ;

               // --- Grupo de Notas de Antecipação de Pagamento ---- //
               // Campo('refNFe_BB02').Value   := ;

               // ------ Informação de NF Referenciada ------ //
               for var Ia := 0 to High(refNFe) do
               begin
                  IncluirPart('NREF');
                  Campo('refNFe_BA02').Value := refNFe[Ia].refNFe;
                  SalvarPart('NREF');
               end; //for

               // ---------------- DADOS DO EMITENTE ---------------- //
               Campo('CNPJ_C02').Value    := QueParam.FieldByName('CNPJFar').AsString;
               Campo('xNome_C03').Value   := QueParam.FieldByName('Nomefar').AsString.Trim;
               Campo('xFant_C04').Value   := QueParam.FieldByName('Nomefan').AsString.Trim;
               Campo('xLgr_C06').Value    := QueParam.FieldByName('Endfar').AsString.Trim;
               Campo('nro_C07').Value     := QueParam.FieldByName('NroEnt').AsString.Trim;
               if QueParam.FieldByName('CompEnd').AsString.Trim <> '' then
                  Campo('xCpl_C08').Value := QueParam.FieldByName('CompEnd').AsString.Trim;
               Campo('xBairro_C09').Value := QueParam.FieldByName('Baifar').AsString.Trim;
               Campo('cMun_C10').Value    := QueParam.FieldByName('Codmun').AsString;
               Campo('xMun_C11').Value    := QueParam.FieldByName('Nommun').AsString.Trim;
               Campo('UF_C12').Value      := QueParam.FieldByName('Estmun').AsString;
               Campo('CEP_C13').Value     := QueParam.FieldByName('Cepfar').AsString;
               Campo('cPais_C14').Value   := '1058';
               Campo('xPais_C15').Value   := 'BRASIL';
               if QueParam.FieldByName('FoneFar').AsString.Trim <> '' then
                  Campo('fone_C16').Value := QueParam.FieldByName('FoneFar').AsString;
               Campo('IE_C17').Value      := QueParam.FieldByName('InsEstFar').AsString;
               Campo('CRT_C21').Value     := QueParam.FieldByName('RegTributa').AsString;

               // --------- DADOS DO DESTINATÁRIO --------- //
               if HOMOLOGANDO then
               begin
                  Campo('CPF_E03').Value   := '18054586043';
                  Campo('xNome_E04').Value := 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL';
                  Campo('indIEDest_E16a').Value := '9';
               end else
               begin
                  if Dest.CpfCnpj.Trim.Length = 11 then
                       Campo('CPF_E03').Value  := Dest.CpfCnpj
                  else Campo('CNPJ_E02').Value := Dest.CpfCnpj;
                  Campo('xNome_E04').Value     := Dest.xNome;
               end; //if

               Campo('xLgr_E06').Value    := Dest.xLgr;
               Campo('nro_E07').Value     := iif(Dest.nro.Trim <> '', Dest.nro,'SN');
               if Dest.xCpl.Trim <> '' then Campo('xCpl_E08').Value := Dest.xCpl.Trim;
               Campo('xBairro_E09').Value := Dest.xBairro;
               Campo('cMun_E10').Value    := Dest.cMun;
               Campo('xMun_E11').Value    := Dest.xMun;
               Campo('UF_E12').Value      := Dest.UF;
               if Dest.CEP.Trim  <> '' then Campo('CEP_E13').Value  := Dest.CEP.Trim;
               if Dest.fone.Trim <> '' then Campo('fone_E16').Value := Dest.fone.Trim;
               if OnlyNumbers(Dest.IE) <> '' then
               begin
                  if not HOMOLOGANDO then Campo('indIEDest_E16a').Value := '1';
                  Campo('IE_E17').Value := OnlyNumbers(Dest.IE);
               end else
               if not HOMOLOGANDO then
               begin
                  if Dest.indIEDest = '1' then
                       Campo('indIEDest_E16a').Value := '2'
                  else Campo('indIEDest_E16a').Value := '9';
               end; //if
               if Dest.indIEDest.Trim <> '' then Campo('email_E19').Value := Dest.indIEDest.Trim;

               // -------- Local de Entrega -------- //
               if Entrega.CpfCnpj.Trim <> '' then
               begin
                   if Entrega.CpfCnpj.Trim.Length = 11 then
                       Campo('CPF_G03').Value  := Entrega.CpfCnpj.Trim
                  else Campo('CNPJ_G02').Value := Entrega.CpfCnpj.Trim;
                  Campo('xNome_G02b').Value    := Entrega.xNome.Trim;
                  Campo('xLgr_G03').Value      := Entrega.xLgr.Trim;
                  Campo('nro_G04').Value       := iif(Entrega.nro.Trim <> '', Entrega.nro.Trim,'SN');
                  if Entrega.xCpl.Trim <> '' then Campo('xCpl_G05').Value := Entrega.xCpl.Trim;
                  Campo('xBairro_G06').Value := Entrega.xBairro.Trim;
                  Campo('cMun_G07').Value    := Entrega.cMun;
                  Campo('xMun_G08').Value    := Entrega.xMun.Trim;
                  Campo('UF_G09').Value      := Entrega.UF;
                  if Entrega.CEP.Trim  <> ''  then Campo('CEP_G10').Value := Entrega.CEP.Trim;
                  if Entrega.fone.Trim <> ''  then Campo('fone_G13').Value := Entrega.fone.Trim;
                  if Entrega.email.Trim <> '' then Campo('email_G14').Value := Entrega.email.Trim;
                  if OnlyNumbers(Entrega.IE) <> '' then Campo('IE_G15').Value := OnlyNumbers(Entrega.IE);
               end; //if

               // ------------------- ITENS DA NF-E ------------------- //
               SetLength(IteCal,  Length(ItensNF));
               SetLength(RT_Itens,Length(ItensNF));

               // ------ Cálculo dos Impostos ------ //
               for var Ii := 0 to High(ItensNF) do
               begin
                  with IteCal[Ii] do
                  begin
                     CFOP   := ItensNF[Ii].CFOP;
                     NCM    := ItensNF[Ii].NCM;
                     CEST   := ItensNF[Ii].CEST;
                     Orig   := ItensNF[Ii].Origem.ToInteger;  // 0..8
                     EhSN := Capa.Regime = TRegime.rtSimples;
                     if Capa.Regime = TRegime.rtRPA then
                          CST   := GetICMSCST(ItensNF[Ii].CST_CSON)
                     else CSOSN := GetCSOSN  (ItensNF[Ii].CST_CSON);
                     CSTPIS    := GetPISCST   (ItensNF[Ii].CST_PIS);
                     CSTCOFINS := GetCOFINSCST(ItensNF[Ii].CST_PIS);
                     Qtd       := ItensNF[Ii].qCom;
                     VUn       := ItensNF[Ii].vUnCom;
                     VDescItem := ItensNF[Ii].vDesc;
                     ModBC     := TModalidadeBC.mbcValorOperacao;
                     PRedBC    := ItensNF[Ii].AliqRedBC;
                     PICMS     := ItensNF[Ii].AliqICMS;
                     PFCP      := ItensNF[Ii].AliqFCP;
                     TemST     := MatchStr(ItensNF[Ii].CST_CSON, ['10','30','60','70','201','202','203','500']) or (ItensNF[Ii].TpTriICMS = 3);
                     ModBCST   := iif((ItensNF[Ii].MVA_ST <= 0.00) and (ItensNF[Ii].RedBCST <= 0.00), TModalidadeBCST.mbcstVlrOperacao, TModalidadeBCST.mbcstMargemValorAgregado);
                     PMVAST    := ItensNF[Ii].MVA_ST;
                     PRedBCST  := ItensNF[Ii].RedBCST;
                     PICMSST   := ItensNF[Ii].AliqICMSST;
                     VPAUTA    := 0.00;
                     PFCPST    := 0.00;
                     TemDIFAL      := Capa.Difal;
                     AliqInter     := Capa.AliInterna;
                     AliqIntraDest := Capa.AliExterna;
                     FCPDIFAL      := 0.00;
                     MotDeson      := 9;
                     PIsencao      := ItensNF[Ii].AliqIcmDif;  // % (usa-se como pDif para CST 51)
                     PPIS          := ItensNF[Ii].AliqPIS;
                     PCOFINS       := ItensNF[Ii].AliqCOFINS;
                     VAliqPIS      := 0.00;     // R$/un (monofásico)
                     VAliqCOFINS   := 0.00;     // R$/un

                     // ----- Taxas Aproximadas - IBPT ----- //
                     TribMun := ItensNF[Ii].TribMun;
                     TribEst := ItensNF[Ii].TribEst;
                     TribFed := ItensNF[Ii].TribFed;
                     TribImp := ItensNF[Ii].TribImp;

                     // ---- Benefícios fiscais (por UF × CST/CSOSN) ----
                     // cBenef         : string;  // <cBenef> do item
                     // cBenefRBC      : string;  // <cBenefRBC> (ex.: redução da base/diferimento – p/ CST 51 ou UF que exija)
                     // pCredPresumido : Double;  // % crédito presumido (se a UF exigir expor)
                     // vCredPresumido : Double;  // valor do crédito presumido (se a UF exigir expor)
                     // ObsBenef       : string;  // texto p/ infCpl (opcional)
                  end; //with

                  // ----- Reforma Tributária ----- //
                  if RT_ATIVO then
                  begin
                     RT_Itens[Ii]     := TItemInputRT.Make;
                     RT_Itens[Ii].Id  := Ii.ToString;
                     RT_Itens[Ii].Qtd := ItensNF[Ii].qCom;
                     RT_Itens[Ii].PrecoLiquidoUnit  := ItensNF[Ii].vUnCom;
                     RT_Itens[Ii].DescItemValor     := ItensNF[Ii].vDesc;

                     RT_Itens[Ii].ISAplicavel       := ItensNF[Ii].AliqIS > 0.00;
                     RT_Itens[Ii].Rates.IS_Seletivo := ItensNF[Ii].AliqIS;

                     RT_Itens[Ii].Rates.IBS_UF      := ItensNF[Ii].AliqIBSEst;
                     RT_Itens[Ii].Rates.IBS_Mun     := ItensNF[Ii].AliqIBSMun;
                     RT_Itens[Ii].Rates.CBS         := ItensNF[Ii].AliqCBS;

                     RT_Itens[Ii].AbatIBS_UF_Perc   := ItensNF[Ii].PerRedIBS;
                     RT_Itens[Ii].AbatIBSMun_Perc   := ItensNF[Ii].PerRedIBS;
                     RT_Itens[Ii].AbatCBS_Perc      := ItensNF[Ii].PerRedCBS;
                  end; //if
               end; //for

               DocValorAdd.VFrete     := Capa.VFrete;
               DocValorAdd.VSeg       := Capa.VSeg;
               DocValorAdd.VOutros    := Capa.VOutro;
               DocValorAdd.VDescTotal := Capa.VDescFim;
               DocValorAdd.Rateio     := TRateioAcessorio.raPorValor;

               if RT_ATIVO then
                  if not CalcImpostosNFe(Capa.regime, iif(Capa.UFOrigem = Capa.UFDestino, TDestinoOper.doInterna, TDestinoOper.doInterestadual),
                         IteCal, DocValorAdd, aImpostos, aTotais, nil) then raise Exception.Create('Error ao calcular os impostos da NFe (uGeraNFe)');

               if not CalcImpostosLoteRT(RT_Itens, Capa.VDescFim, RT_OutIt, RT_Tot) then
                  raise Exception.Create('Error ao calcular os impostos da Reforma Tribut. da NFe (uGeraNFe)');

               // ----- Atualização dos DM.spdNFeDS.Campos dos Itens da NFe ----- //
               with locServer.spdNFeDS do
               begin
                  for var iDS := 0 to High(ItensNF) do
                  begin
                     IncluirItem;
                     begin
                        auxvProd := SimpleRoundTo(ItensNF[iDS].qCom * ItensNF[iDS].vUnCom, -2);
                        Campo('nItem_H02').Value := (iDS+1).ToString;
                        Campo('cProd_I02').Value := ItensNF[iDS].cProd.ToString;
                        Campo('cEAN_I03').Value  := ItensNF[iDS].cEAN;
                        Campo('NCM_I05').Value   := ItensNF[iDS].NCM;
                        Campo('xProd_I04').Value := iif(not HOMOLOGANDO, ItensNF[iDS].xProd, 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL');
                        if ItensNF[iDS].CEST <> ''      then Campo('CEST_I05c').Value   := ItensNF[iDS].CEST;
                        if ItensNF[iDS].CodBenFis <> '' then Campo('cBenef_I05f').Value := ItensNF[iDS].CodBenFis;
                        Campo('CFOP_I08').Value     := Capa.CFOP;
                        Campo('uCom_I09').Value     := ItensNF[iDS].uCom;
                        Campo('qCom_I10').Value     := FormatDouble(ItensNF[iDS].qCom,   11,2);
                        Campo('vUnCom_I10a').Value  := FormatDouble(ItensNF[iDS].vUnCom, 11,2);
                        Campo('vProd_I11').Value    := FormatDouble(auxvProd,11,2);
                        Campo('cEANTrib_I12').Value := ItensNF[iDS].cEAN;
                        Campo('uTrib_I13').Value    := ItensNF[iDS].uCom;
                        Campo('qTrib_I14').Value    := FormatDouble(ItensNF[iDS].qCom, 11,2);
                        Campo('vUnTrib_I14a').Value := FormatDouble(auxvProd, 11,2);
                        if ItensNF[iDS].vDesc > 0.00 then Campo('vDesc_I17').Value := FormatDouble(ItensNF[iDS].vDesc,11,2);
                        TotImpApro := aImpostos[iDS].vIBPMun + aImpostos[iDS].vIBPEst + aImpostos[iDS].vIBPFed + aImpostos[iDS].vIBPImp;
                        Campo('indTot_I17b').Value  := '1';
                        Campo('vTotTrib_M02').Value := FormatDouble(TotImpApro, 11,2);

                        // ==================== TRIBUTAÇÃO DO ITEM ==================== //
                        spNDataSet := locServer.spdNFeDS;
                        spCDataSet := nil;

                        // ------------- SIMPLES NACIONAL RT - 1 ------------- //
                        if Capa.regime = TRegime.rtSimples then
                        begin
                           // ---- ICMS --- //
                           auxCSON := ItensNF[iDS].CST_CSON;
                           if auxCSON = '101' then Tecno.ICMSSN101(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]);
                           if auxCSON = '201' then Tecno.ICMSSN201(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]);
                           if auxCSON = '500' then Tecno.ICMSSN500(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]);
                           if auxCSON = '900' then Tecno.ICMSSN900(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]);
                           if MatchStr(auxCSON, ['202','203']) then
                           begin
                              auxTCSOSN := iif(auxCSON = '202', TCSOSN.sn202, TCSOSN.sn203);
                              Tecno.ICMSSN202_203(locServer.spdNFeDS, auxTCSOSN, IteCal[iDS], aImpostos[iDS]);
                           end;
                           if MatchStr(auxCSON, ['102','103','300','400']) then
                           begin
                              if auxCSON = '102' then auxTCSOSN := TCSOSN.sn102 else
                              if auxCSON = '103' then auxTCSOSN := TCSOSN.sn103 else
                              if auxCSON = '300' then auxTCSOSN := TCSOSN.sn300 else
                              if auxCSON = '400' then auxTCSOSN := TCSOSN.sn400;
                              Tecno.ICMSSN102_103_300_400(locServer.spdNFeDS, auxTCSOSN, IteCal[iDS]);
                           end; //if

                           auxCST := ItensNF[iDS].CST_PIS;    // PIS e CONFINS
                           Campo('CST_Q06').Value := auxCST;  // ---- PIS
                           Campo('CST_S06').Value := auxCST;  // --- COFINS
                        end else
                        // ------------- REGIME NORMAL (RT - 2/3) ------------ //
                        if  Capa.Regime = TRegime.rtRPA then
                        begin
                           // ---- ICMS --- //
                           auxCST := ItensNF[iDS].CST_CSON;
                           if auxCST = '00' then Tecno.ICMS00(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '10' then Tecno.ICMS10(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '20' then Tecno.ICMS20(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '30' then Tecno.ICMS30(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '40' then Tecno.ICMS40(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '41' then Tecno.ICMS41(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '50' then Tecno.ICMS50(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '51' then Tecno.ICMS51(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '60' then Tecno.ICMS60(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '70' then Tecno.ICMS70(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]) else
                           if auxCST = '90' then Tecno.ICMS90(locServer.spdNFeDS, IteCal[iDS], aImpostos[iDS]);
                        end; //if

                        // ------ PIS / CONFINS ------ //
                        Tecno.PIS_COFINS(locServer.spdNFeDS, IteCal[iDS],aImpostos[iDS]);

                        // ------------------- REFORMA TRIBUTÁRIA ------------------- //
                        if RT_ATIVO then
                        begin
                           // ------ Imposto Seletivo (IS) ------- //
                           if ItensNF[iDS].AliqIS > 0.00 then
                           begin
                              Campo('CSTIS_UB02').Value        := '';  // Tabela ainda não publicada
                              Campo('cClassTribIS_UB03').Value := '';  // Tabela ainda não publicada
                              Campo('vBCIS_UB05').Value        := FormatDouble(RT_OutIt[iDS].vBCIS,  11,2);
                              Campo('pIS_UB06').Value          := FormatDouble(RT_OutIt[iDS].pISEspec,3,2);
                              Campo('uTrib_UB09').Value        := ItensNF[iDS].uCom;
                              Campo('vIS_UB11').Value          := FormatDouble(RT_OutIt[iDS].vIS, 11,2);
                           end; //if

                           // ---------- Imposto IBS / CBS ------- //
                           Campo('CST_UB13').Value        := Copy(ItensNF[iDS].ClassRT,1,3);
                           Campo('cClassTrib_UB14').Value := ItensNF[iDS].ClassRT;
                           Campo('vBC_UB16').Value        := FormatDouble(RT_OutIt[iDS].vBCIBSCBS, 11,2);
                           Campo('vIBS_UB54a').Value      := FormatDouble(RT_OutIt[iDS].vTribRegIBSUF + RT_OutIt[iDS].vTribRegIBSMun,11,2);  //... (Soma de vIBSUF e vIBSMun)

                           // ------ IBS UF ------ //
                           Campo('pIBSUF_UB18').Value     := FormatDouble(QueParam.FieldByName('AliqIBSEst').AsFloat,6,2);
                           Campo('pRedAliq_UB27').Value   := FormatDouble(ItensNF[iDS].PerRedIBS,6,2);
                           Campo('pAliqEfet_UB28').Value  := FormatDouble(RT_OutIt[iDS].pAliqEfetRegIBSUF,6,2);
                           Campo('vIBSUF_UB35').Value     := FormatDouble(RT_OutIt[iDS].vTribRegIBSUF,10,2);

                           // ---- IBS Muni. ---- //
                           Campo('pIBSMun_UB37').Value    := FormatDouble(QueParam.FieldByName('AliqIBSMun').AsFloat,3,2);
                           Campo('pRedAliq_UB46').Value   := FormatDouble(ItensNF[iDS].PerRedIBS, 3,2);
                           Campo('pAliqEfet_UB47').Value  := FormatDouble(RT_OutIt[iDS].pAliqEfetRegIBSMun, 3,2);
                           Campo('vIBSMun_UB54').Value    := FormatDouble(RT_OutIt[iDS].vTribRegIBSMun, 11,2);

                           // ---- IMPOSTO CBS ---- //
                           Campo('pCBS_UB56').Value       := FormatDouble(QueParam.FieldByName('AliqCBS').AsFloat,3,2);
                           Campo('pRedAliq_UB65').Value   := FormatDouble(ItensNF[iDS].PerRedCBS,3,2);
                           Campo('pAliqEfet_UB66').Value  := FormatDouble(RT_OutIt[iDS].pAliqEfetRegCBS,6,2);
                           Campo('vCBS_UB67').Value       := FormatDouble(RT_OutIt[iDS].vTribRegCBS,10,2);
                        end; //if
                     end; //begin
                     SalvarItem;
                  end; //for
               end; //with

               // --------- Totalizadores da NFe --------- //
               TTecnoSpeed.Totals(locServer.spdNFeDS, aTotais, False);

               // ----- Totalizadores da Reforma Trib. ----- //
               if RT_ATIVO then
               begin
                  Campo('vBCIBSCBS_W35').Value := FormatDouble(RT_Tot.vBCIBSCBS, 11,2);
                  Campo('vDif_W38').Value      := '0.00';
                  Campo('vDevTrib_W39').Value  := '0.00';
                  Campo('vIBSUF_W41').Value    := FormatDouble(RT_Tot.TotalIBSUF, 11,2);
                  Campo('vDif_W43').Value      := '0.00';
                  Campo('vDevTrib_W44').Value  := '0.00';
                  Campo('vIBSMun_W46').Value   := FormatDouble(RT_Tot.TotalIBSMun, 11,2);
                  Campo('vIBS_W47').Value      := FormatDouble(RT_Tot.vIBS, 11,2);
                  Campo('vCredPres_W48').Value := '0.00';
                  Campo('vCredPresCondSus_W49').Value  := '0.00';
                  Campo('vCredPres_W56a').Value        := '0.00';
                  Campo('vCredPresCondSus_W56b').Value := '0.00';
                  Campo('vDif_W53').Value     := '0.00';
                  Campo('vDevTrib_W54').Value := '0.00';
                  Campo('vCBS_W56').Value     := FormatDouble(RT_Tot.TotalCBS, 11,2);
                  Campo('vNFTot_W60').Value   := FormatDouble(RT_Tot.vNFTot,   11,2);
               end; //if

               // ------- Dados de Transporte ------- //
               Campo('modFrete_X02').Value := Transp.modFrete;

               if Transp.modFrete <> '9' then
               begin
                  if OnlyNumbers(Transp.CpfCnpj) <> '' then
                  begin
                    if OnlyNumbers(Transp.CpfCnpj).Length > 11 then
                         Campo('CNPJ_X04').Value := OnlyNumbers(Transp.CpfCnpj)
                    else Campo('CPF_X05').Value  := OnlyNumbers(Transp.CpfCnpj);  
                    Campo('xNome_X06').Value     := Transp.xNome;
                    Campo('IE_X07').Value        := Transp.IE;
                    Campo('xEnder_X08').Value    := Transp.xEnder;
                    Campo('xMun_X09').Value      := Transp.xMun;
                    Campo('UF_X10').Value        := Transp.UF;
                  end; //if
                  if Transp.placa.Trim <> '' then
                  begin
                     Campo('placa_X19').Value := Transp.placa;
                     Campo('UF_X20').Value    := Transp.UF_Placa;
                     if Transp.RNTC.Trim <> '' then Campo('RNTC_X21').Value := Transp.RNTC;
                  end; //if
               end;
               
               // ------- Dados dos Volumes ------- //
               if Volumes.qVol > 0         then Campo('qVol_X27').Value  := Volumes.qVol.ToString;
               if Volumes.esp.Trim   <> '' then Campo('esp_X28').Value   := Volumes.esp; 
               if Volumes.marca.Trim <> '' then Campo('marca_X29').Value := Volumes.marca;
               if Volumes.nVol  > 0        then Campo('nVol_X30').Value  := Volumes.nVol.ToString;
               if Volumes.pesoL > 0.00     then Campo('pesoL_X31').Value := FormatDouble(Volumes.pesoL,8,2);
               if Volumes.pesoB > 0.00     then Campo('pesoB_X32').Value := FormatDouble(Volumes.pesoB,8,2);

               // ------ Dados de Pagamentos ------ //
               if Length(Pagtos) > 0 then
               begin
                  for var iPG := 0 to High(Pagtos) do
                  begin
                     IncluirPart('YA');
                     begin
                        Campo('indPag_YA01b').Value := Pagtos[iPG].indPag;
                        Campo('tPag_YA02').Value    := Pagtos[iPG].tPag;
                        Campo('vPag_YA03').Value    := FormatDouble(Pagtos[iPG].vPag,11,2);
                        Campo('dPag_YA03a').Value   := DataMySQL(DateOf(Pagtos[iPG].dPag));
                        if Pagtos[iPG].CNPJ <> '' then
                        begin
                           Campo('tpIntegra_YA04a').Value := Pagtos[iPG].tpIntegra;
                           Campo('CNPJ_YA05').Value  := Pagtos[iPG].CNPJ;
                           Campo('tBand_YA06').Value := Pagtos[iPG].tBand;
                           Campo('cAut_YA07').Value  := Pagtos[iPG].cAut;
                        end;
                     end; //begin
                     SalvarPart('YA');
                  end; //for
               end else 
               begin   
                  IncluirPart('YA');
                  Campo('tPag_YA02').Value := '90';
                  SalvarPart('YA');
               end; //if
            
               // ---- Informações Responsável Técnico ---- //
               Campo('CNPJ_ZD02').Value     := '27124815000139';
               Campo('xContato_ZD04').Value := 'Marcelo Rezende Arantes';
               Campo('email_ZD05').Value    := 'arantes.marcelo@gmail.com';
               Campo('fone_ZD06').Value     := '34999770150';

               // -------- Observações Fiscais -------- //
               if HOMOLOGANDO then
               begin
                  Campo('infAdFisco_Z02').Value := 'OBSERVACAO TESTE DA DANFE - FISCO  OBSERVACAO TESTE DA DANFE - FISCO';
                  Campo('infCpl_Z03').Value     := 'OBSERVACAO TESTE DA DANFE CONTRIBUINTE  OBSERVACAO TESTE DA DANFE CONTRIBUINTE';
               end else
               begin
                  // ---- Informações Adicionais P/ Fisco ---- //
                  strInfFiscal := '';
                  if Length(InfFiscal) > 0 then
                  begin
                     for var iFis := 0 to High(InfFiscal) do
                        strInfFiscal := strInfFiscal + InfFiscal[iFis].infAdFisco+'|';
                     Campo('infAdFisco_Z02').Value := strInfFiscal;
                  end; //if
                  
                  // --- Informações Compl. do Contribuinte --- //
                  strInfCompl := iif(Capa.regime = TRegime.rtSimples, 'DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL','')+
                                 'Total aproximado dos tributos = '+MascNro(aTotais.vAproxImp,11,2).Trim+' (Ref. Lei nº 12.741/2012)';
                  if Length(InfCompl) > 0 then
                  begin
                     for var iFis := 0 to High(InfCompl) do
                        strInfCompl := strInfCompl + InfCompl[iFis].infCpl+'  ';
                     Campo('infCpl_Z03').Value := Trim(strInfCompl);
                  end; //if
               end; //if
            end; //begin
            Salvar;

            KEY_NF := Copy(Campo('Id_A03').AsString,4,44);
            XML_NF := LoteNFe.GetText;
         end; //with

         if not Preview then
         begin
            NFSalvar.Tabela := Capa.Tabela;
            NFSalvar.CmpKey := 'IDPed';
            NFSalvar.IDCFOP := '1';
            NFSalvar.Modelo := '55';
            NFSalvar.CmpDad := Capa.Pedido;
            NFSalvar.Chave  := KEY_NF;
            SalvarNF(NFSalvar, recFILIAL);
         end; //ig

         XML_NF := recSpdNFe.AssinarNota(XML_NF);

         // ------ TESTE ------- ///
         //  var arq: TextFile;
         //  AssignFile(arq, '.\NF_Teste.xml');
         //  Rewrite(arq);
         //  Writeln(arq, XML_NF);
         //  CloseFile(arq);

         if not Preview then
         begin
            retResNFe := EnviaNF(recSpdNFe, recFILIAL, Capa.Pedido.ToInteger, CONTIGENCIA, XML_NF, KEY_NF);
            if not retResNFe.Sucesso then raise Exception.Create('NFe não enviada, Tabela: "'+Capa.Tabela+'", Pedido = '+Capa.Pedido+', Motivo: '+retResNFe.xMotivo);
         end
         else retXML_NF := XML_NF;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Envio de NFe (uGerarNFe) -> '+E.Message);
            Result := 'Não foi possível enviar NF. Motivo: '+retResNFe.xMotivo;
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      QueParam.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueParam);
      locServer.FDConnect.Close;
      locServer.Free;
   end;
end;

// ------------ Configuração do Ambiente Para Envio das NFe ----------- //
function ConfAmbienteNF(recSpdNFe:TspdNFe):Boolean;
var
   QueParam:TFDQuery;
   locServer:TDMServer;
begin
   Result := False;
   locServer := TDMServer.Create(nil);
   QueParam  := TFDQuery.Create(nil);
   try
      try
         QueParam.Connection := locServer.FDConnect;
         QueParam.SQL.Text := 'SELECT * FROM arqparametros LIMIT 1';
         QueParam.Open;
         if QueParam.IsEmpty then
         begin
            SalvaLog(USUARIO, PastaLog,'ERRO ao tentar buscar dados dos parâmetros para emissão de NF, tabela arqparametros vazia: uGeraNFEc');
            Exit;
         end;

         with recSpdNFe, QueParam do
         begin
            PRINTERNF    := FieldByName('PrinterNFe').AsString;
            HOMOLOGANDO  := FieldByName('HomolNFe').AsBoolean;
            CONTIGENCIA  := FieldByName('IndContNFe').AsBoolean;
            MENEnvMailNF := FieldByName('MenEnvMailNF').AsString;
            SITEConsNF   := FieldByName('SiteConsNFe').AsString;
            VersaoManual := vm60;
            HttpLibs := 'SBB';
            PastaNF  := FieldByName('PastaConfNFe').AsString.Trim;
            PrintNF  := FieldByName('PrinterNFe').AsString.Trim;
            UF       := FieldByName('Estmun').AsString.Trim;
            CNPJ     := FieldByName('CNPJFar').AsString.Trim;
            Ambiente := iif(FieldByName('HomolNFe').AsBoolean, akHomologacao, akProducao);
            ValidarEsquemaAntesEnvio := True;
            DiretorioEsquemas        := PastaNF+'\Esquemas\';
            DiretorioTemplates       := PastaNF+'\Templates\';
            DiretorioLog             := PastaNF+'\Log\';
            DiretorioLicense         := PastaNF+'\License\';
            ArquivoServidoresHom     := PastaNF+'\NFeServidoresHom.ini';
            ArquivoServidoresProd    := PastaNF+'\NFeServidoresProd.ini';
            DiretorioXmlDestinatario := PastaNF+'\XmlDestinatario\';
            DiretorioLogErro         := PastaNF+'\Erros\';
            DiretorioTemporario      := PastaNF+'\Temp\';
            SenhaCertificado         := FieldByName('SenDigital').AsString.Trim;
            NomeCertificado.Clear;
            NomeCertificado.Add(FieldByName('CerDigital').AsString.Trim);
            with DaNFeSettings do
            begin
               if FieldByName('IndContNFe').AsBoolean then
                    QtdeCopias    := iif(FieldByName('NroViasNF').AsInteger < 2, 2, FieldByName('NroViasNF').AsInteger)
               else QtdeCopias    := FieldByName('NroViasNF').AsInteger;
               LogotipoEmitente   := FieldByName('ImagemNF').AsString.Trim;
               FraseContingencia  := 'DANFE em contigência.';
               ConfigurarSoftwareHouse('27124815000139','17ee76f292e5c98566cb6b413c0c8dc6');
            end; //with
            with EmailSettings do
            begin
               Mensagem := '';
               Assunto  := '';
               Porta    := FieldByName('MailPorta').AsInteger;
               Senha    := FieldByName('MailSenha').AsString.Trim;
               Usuario  := FieldByName('MailUsuario').AsString.Trim;
               ServidorSmtp   := FieldByName('ServidorSMTP').AsString.Trim;
               EmailRemetente := FieldByName('MailUsuario').AsString.Trim;
               Autenticacao   := FieldByName('MailAutentica').AsBoolean;
            end //with;
         end; //with
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog,'ERRO ao tentar buscar dados dos parâmetros para emissaão de NF: uGeraNFEc -> '+E.Message);
            Exit;
         end;
      end;
   finally
      QueParam.Close;
      FreeAndNil(QueParam);
      locServer.FDConnect.Close;
      locServer.Free;
   end;
end;

function MontarXML(XmlEnvi,XmlRet:String):Boolean;
var
  XmlProc:string;
begin
   // XmlEnvi := TFile.ReadAllText('C:\Fontes\AIONE.My\NFCe\Log\2025-10-14-15-23-09-74-50251036419289000125650990000000061655295034-env-sinc-lot.xml',  TEncoding.UTF8);
   // XmlRet  := TFile.ReadAllText('C:\Fontes\AIONE.My\NFCe\Log\2025-10-14-15-23-11-999-50251036419289000125650990000000061655295034-env-sinc-ret.xml', TEncoding.UTF8);
   XmlProc := MontarNFeAutorizada_XML(XmlEnvi, XmlRet);
   TFile.WriteAllText(PastaNF+'\XmlDestinoAIONE\'+'XML_estruturado-nfce.xml', XmlProc, TEncoding.UTF8);
end;


end.

