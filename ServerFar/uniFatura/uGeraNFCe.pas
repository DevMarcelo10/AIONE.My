unit uGeraNFCe;

interface

uses
   Windows, Messages, Forms, Classes, Controls, Dialogs, ExtCtrls, System.StrUtils,
   spdNFeUtils, spdNFCe, spdNFCeType, System.SysUtils, MarcLib, DateUtils, uNFCRetorno,
   System.IOUtils, uConst, FireDAC.Comp.Client, uCalculaNF, uImpostosRT, System.Math;

   function ConfAmbienteNFC(recSpdNFCe:TspdNFCe):Boolean;
   function GerarNFC(recFILIAL,NroPedRec:String; CPFnf,Mailnf:Boolean):String;
   function EnviaNFC(recSpdNFCe:TspdNFCe; recFILIAL,recNroPed:String; IN_CONT:Boolean; recXML_NFC,recKEY_NFC:String):TNFCeResultado;
   function InutilizaNFC(NroNotIni:String; NroNotFim:String = ''; recMotivo:String = ''):TNFCeResultado;

implementation

uses uDM, uLibServer, uXMLAutorizado;

var
   NRO_NOTA:Integer;
   PastaNFC:String;
   NFSalvar: TNFSalvar;
   HOMOLOGANDO,CONTIGENCIA,RT_ATIVO:Boolean;
   PrintNFC,uNFCRetorno,MENEnvMailNF,SITEConsNFC:String;

// ------------------ Geração da NFC-e Para Emissão ---------------- //
function GerarNFC(recFILIAL,NroPedRec:String; CPFnf,Mailnf:Boolean):String;
var
   F:TextFile;
   Ac,Ii:Integer;
   TotImpApro,auxvProd:Double;
   DataHoje:TDateTime;
   locServer:TDMServer;
   auxRegime:TRegime;
   IteCal:TArray<TItemEntrada>;
   DocValorAdd: TDocAcessorios;
   aTotais:TTotaisNota;
   aImpostos:TArray<TItemImpostos>;
   RT_IteCal: TArray<TItemInputRT>;
   RT_OutIt: TArray<TItemOutputRT>;
   RT_Tot: TTotaisNotaRT;
   QuePedi,QueItem,QueParam,QuePagto,QueTxApr:TFDQuery;
   retResNFe: TNFCeResultado;
   Tecno:TTecnoSpeed;
   auxTCSOSN: TCSOSN;
   KEY_NFC,XML_NFC,auxCST_CSON,auxPIS_COF,preCFOP,auxEAN:String;
begin
   QuePedi   := TFDQuery.Create(nil);
   QueItem   := TFDQuery.Create(nil);
   QueParam  := TFDQuery.Create(nil);
   QuePagto  := TFDQuery.Create(nil);
   QueTxapr  := TFDQuery.Create(nil);
   locServer := TDMServer.Create(nil);
   QuePedi.Connection  := locServer.FDConnect;
   QueItem.Connection  := locServer.FDConnect;
   QueParam.Connection := locServer.FDConnect;
   QuePagto.Connection := locServer.FDConnect;
   QueTxapr.Connection := locServer.FDConnect;
   try
      try
         DataHoje := Now;
         // ------- Geração do Número da NFC-e ------- //
         QuePedi.SQL.Text := 'SELECT COALESCE(MAX(NroNF), 0) AS UltNotFis FROM '+
         '(SELECT NroNF FROM arqpedido WHERE ModNF = "65" AND IDFilial = '+recFILIAL+
         ' UNION ALL SELECT NroNF FROM arqnfeven WHERE ModNF = "65" AND IDFilial = '+recFILIAL+') AS t';
         QuePedi.Open;
         if QuePedi.FieldByName('UltNotFis').AsInteger <= 0 then
         begin
            // ---- Somente P/ Implantação ---- //
            QueParam.SQL.Text := 'SELECT NroUltNFC FROM arqparametros LIMIT 1';
            QueParam.Open;
            NRO_NOTA := QueParam.FieldByName('NroUltNFC').AsInteger + 1;
            QueParam.Close;
         end
         else NRO_NOTA := QuePedi.FieldByName('UltNotFis').AsInteger + 1;

         // ------ Abre Tabelas de Pedido e IteCal ------ //
         QuePedi.Close;
         QuePedi.SQL.Text := 'SELECT * FROM arqpedido PED '+
         'LEFT JOIN arqpessoa PES ON PED.IDPess = PES.IDPess LEFT JOIN arqmuni MUN ON MUN.Codmun = PES.Codmun '+
         'WHERE PED.IDFilial = '+recFILIAL+' AND PED.IDPed = '+NroPedRec;
         QuePedi.Open;
         QueItem.SQL.Text := 'SELECT PEI.*,PRO.*,UNV.*,IVA.PerRedCBS,IVA.PerRedIBS FROM arqpedidoite PEI '+
         'LEFT JOIN arqproduto PRO ON PEI.IDProd = PRO.IDProd '+
         'LEFT JOIN arqunidades UNV ON PRO.IDUniVen = UNV.IDUni '+
         'LEFT JOIN arqclaivaite IVA ON PRO.CodClasIte = IVA.CodClasIte '+
         'WHERE PEI.IDFilial = '+recFILIAL+' AND PEI.IDPed = '+NroPedRec;
         QueItem.Open;
         if QueItem.IsEmpty then raise Exception.Create('Não existem produtos nesse pedido');

         QuePagto.SQL.Text :=
         'SELECT PAG.*, PGT.IndPagVis, PGT.IDForPagNF, CAR.CNPJadi, GNF.IDGruCard FROM arqpedidopag PAG '+
         'LEFT JOIN arqforpagto PGT ON PAG.IDForPag = PAG.IDForPag '+
         'LEFT JOIN arqcartao CAR ON PAG.IDCartao = CAR.IDCartao '+
         'LEFT JOIN arqforpagnf GNF ON GNF.IDForPagNF = PGT.IDForPagNF '+
         'WHERE PAG.IDFilial = '+recFILIAL+' AND PAG.IDPed = '+NroPedRec+' GROUP BY IDPed';
         QuePagto.Open;
         if QuePagto.IsEmpty then raise Exception.Create('Não existem formas de pagamento nesse pedido');

         if not ConfAmbienteNFC(locServer.spdNFCe) then raise Exception.Create('Não foi possivel buscar parâmetros da NFC');

         // ----- Configurações Gerais da NFCe ----- //
         QueParam.SQL.Text := 'SELECT * FROM arqparametros PAR LEFT JOIN arqicmsuf ICM ON PAR.Estmun = ICM.UFICMS LIMIT 1';
         QueParam.Open;

         RT_ATIVO := (QueParam.FieldByName('RegTributa').AsString = '3'); // and (DateOf(DataServer) >= StrToDate('05/01/2026'));

         // ----- Taxas Aproximadas - IBPT ----- //
         QueTxapr.SQL.Text := 'SELECT * FROM arqibpt WHERE UF = :UF AND CodNCM = :CodNCM';

         // ---- Geração dos Registros TecnoSpeed ---- //
         with locServer.spdNFCeDS do
         begin
            LoteNFCe.Clear;
            VersaoEsquema := pl_010b;
            XMLDicionario := PastaNFC+'\Templates\vm60\Conversor\NFCeDataSets.xml';
            ValidaRegrasNegocio := False;
            Incluir;
            begin
               Campo('Id_A03').Value      := '';
               Campo('versao_A02').Value  := '4.00';
               Campo('cUF_B02').Value     := CodigoUF(QueParam.FieldByName('Estmun').AsString);
               Campo('cNF_B03').Value     := IntToStr(11111111 + Random(99999999 - 11111111 + 1));
               Campo('natOp_B04').Value   := 'VENDA DE MERCADORIA ADQ. DE TERCEIRO';
               Campo('mod_B06').Value     := '65';
               Campo('serie_B07').Value   := iif(HOMOLOGANDO,'99',QueParam.FieldByName('SerNFC').AsString);
               Campo('nNF_B08').Value     := NRO_NOTA.ToString;
               Campo('dhEmi_B09').Value   := FormatDateTime('YYYY-mm-dd"T"HH:mm:ss',DataHoje)+'-03:00';
               Campo('cMunFG_B12').Value  := QueParam.FieldByName('Codmun').AsString;
               Campo('tpNF_B11').Value    := '1';
         	   Campo('idDest_B11a').Value := '1';
               Campo('tpImp_B21').Value   := '4';
               if CONTIGENCIA then
               begin
                  Campo('tpEmis_B22').Value := '9';
                  Campo('xJust_B29').Value  := 'Erro ao conectar com Internet ou instabilidade do SEFAZ';
                  Campo('dhCont_B28').Value := FormatDateTime('YYYY-mm-dd"T"HH:mm:ss',QueParam.FieldByName('DatContNFC').AsDateTime)+'-03:00';
               end
               else Campo('tpEmis_B22').Value  := '1';
               Campo('cDV_B23').Value          := '';
               Campo('tpAmb_B24').value        := iif(HOMOLOGANDO,'2','1');
               Campo('finNFe_B25').Value       := '1';
           	   Campo('indFinal_B25a').Value    := '1';
            	Campo('indPres_B25b').Value     := '1';
               // Campo('indIntermed_B25c').Value := '0'; //--> novo
               Campo('procEmi_B26').Value      := '0';
               Campo('verProc_B27').Value      := '1.00';

               // ------- Dados do Emitente ------- //
               Campo('CNPJ_C02').Value    := QueParam.FieldByName('CNPJFar').AsString;
               Campo('xNome_C03').Value   := QueParam.FieldByName('Nomefar').AsString.Trim;
               Campo('xFant_C04').Value   := QueParam.FieldByName('Nomefan').AsString.Trim;
               Campo('xLgr_C06').Value    := QueParam.FieldByName('Endfar').AsString.Trim;
               Campo('nro_C07').Value     := QueParam.FieldByName('NroEnt').AsString.Trim;
               Campo('xBairro_C09').Value := QueParam.FieldByName('Baifar').AsString.Trim;
               Campo('cMun_C10').Value    := QueParam.FieldByName('Codmun').AsString;
               Campo('xMun_C11').Value    := QueParam.FieldByName('Nommun').AsString.Trim;
               Campo('UF_C12').Value      := QueParam.FieldByName('Estmun').AsString;
               Campo('CEP_C13').Value     := QueParam.FieldByName('Cepfar').AsString;
               Campo('fone_C16').Value    := QueParam.FieldByName('FoneFar').AsString;
               Campo('IE_C17').Value      := QueParam.FieldByName('InsEstFar').AsString;
               Campo('CRT_C21').Value     := QueParam.FieldByName('RegTributa').AsString;
               Campo('cPais_C14').Value   := '1058';
               Campo('xPais_C15').Value   := 'BRASIL';

               // ----- Dados do Distinatário ----- //
               if HOMOLOGANDO then
               begin
                  Campo('CPF_E03').Value   := '18054586043';
                  Campo('xNome_E04').Value := 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL';
                  Campo('indIEDest_E16a').Value := '9';
               end else
               begin
                  if CPFnf and (QuePedi.FieldByName('CpfCnpjPes').AsString.Trim.Length = 11) then
                  begin
                     Campo('CPF_E03').Value   := QuePedi.FieldByName('CpfCnpjPes').AsString.Trim;
                     Campo('xNome_E04').Value := QuePedi.FieldByName('Nompes').AsString.Trim;
                     Campo('indIEDest_E16a').Value := '9';
                     if (QuePedi.FieldByName('Endpes').AsString.Trim <> '') and
                        (QuePedi.FieldByName('Baipes').AsString.Trim <> '') and
                        (QuePedi.FieldByName('Codmun').AsInteger > 0) then
                     begin
                        Campo('xLgr_E06').Value    := QuePedi.FieldByName('Endpes').AsString;
                        Campo('nro_E07').Value     := iif(QuePedi.FieldByName('Nroend').AsString.Trim <> '', QuePedi.FieldByName('Nroend').AsString,'SN');
                        Campo('xBairro_E09').Value := QuePedi.FieldByName('Baipes').AsString;
                        Campo('cMun_E10').Value    := QuePedi.FieldByName('Codmun').AsString;
                        Campo('xMun_E11').Value    := QuePedi.FieldByName('Nommun').AsString;
                        Campo('UF_E12').Value      := QuePedi.FieldByName('Estmun').AsString;
                        if QuePedi.FieldByName('Ceppes').AsString.Trim  <> '' then
                        Campo('CEP_E13').Value     := QuePedi.FieldByName('Ceppes').AsString.Trim;
                        if QuePedi.FieldByName('CompEnd').AsString.Trim <> '' then
                           Campo('xCpl_E08').Value := QuePedi.FieldByName('CompEnd').AsString.Trim;
                        if QuePedi.FieldByName('CelularPes').AsString.Trim <> '' then
                           Campo('fone_E16').Value := QuePedi.FieldByName('CelularPes').AsString.Trim;
                        Campo('cPais_E14').Value   := '1058';
                        Campo('xPais_E15').Value   := 'BRASIL';
                     end; //if
                  end; //if
               end; //if

               // --------------- Itens da NFCe -------------- //
               with QueItem do
               begin
                  // ---- Cálculo dos Impostos ---- //
                  SetLength(IteCal, RecordCount);
                  SetLength(RT_IteCal, RecordCount);
                  auxRegime := iif(QueParam.FieldByName('RegTributa').AsString = '3', TRegime.rtRPA, TRegime.rtSimples);
                  Ii := 0;
                  First;
                  while not Eof do
                  begin
                     auxCST_CSON := iif(auxRegime = TRegime.rtRPA, StrZero(FieldByName('CSTICMS').AsString,2), FieldByName('CSOSN').AsString);
                     auxPIS_COF  := StrZero(FieldByName('CSTPisCofSai').AsString,2);
                     if QueTxapr.Active then QueTxapr.Close;
                     QueTxapr.ParamByName('UF').AsString     := QueParam.FieldByName('Estmun').AsString;
                     QueTxapr.ParamByName('CodNCM').AsString := FieldByName('CodNCM').AsString;
                     QueTxapr.Open;

                     with IteCal[Ii] do
                     begin
                        CFOP       := iif(MatchStr(auxCST_CSON,['60','201','202','203','500']),'5405','5102');
                        NCM        := FieldByName('CodNCM').AsString;
                        Orig       := Copy(FieldByName('CSTICMS').AsString,1,1).ToInteger;  // 0..8
                        EhSN       := auxRegime = TRegime.rtSimples;
                        if auxRegime = TRegime.rtRPA then
                             CST   := GetICMSCST(auxCST_CSON)
                        else CSOSN := GetCSOSN(auxCST_CSON);
                        CSTPIS     := GetPISCST(auxPIS_COF);
                        CSTCOFINS  := GetCOFINSCST(auxPIS_COF);
                        Qtd        := FieldByName('Qtdped').AsFloat;
                        VUn        := FieldByName('PrecoVen').AsFloat;
                        VDescItem  := FieldByName('VlrDesc').AsFloat;
                        ModBC      := TModalidadeBC.mbcValorOperacao;
                        PRedBC     := FieldByName('AliqRedICM').AsFloat;
                        PICMS      := QueParam.FieldByName('PerICMS').AsFloat;
                        PFCP       := QueParam.FieldByName('PerFCP').AsFloat;
                        TemST      := MatchStr(auxCST_CSON, ['10','30','60','70','201','202','203','500']) or (FieldByName('TipoTriICMS').AsInteger = 3);
                        ModBCST    := iif(FieldByName('AliqMVA').AsFloat <= 0.00, TModalidadeBCST.mbcstVlrOperacao, TModalidadeBCST.mbcstMargemValorAgregado);
                        PMVAST     := FieldByName('AliqMVA').AsFloat;
                        TemDIFAL   := QueParam.FieldByName('IndDIFAL').AsBoolean;
                        AliqInter  := QueParam.FieldByName('PerICMS').AsFloat;
                        PIsencao   := FieldByName('AliqIcmDif').AsFloat;  // % (usa-se como pDif para CST 51)
                        PPIS       := QueParam.FieldByName('PercPIS').AsFloat;
                        PCOFINS    := QueParam.FieldByName('PerCOFINS').AsFloat;
                        PRedBCST   := 0.00;
                        PICMSST    := 0.00;
                        VPAUTA     := 0.00;
                        PFCPST     := 0.00;
                        FCPDIFAL   := 0.00;
                        MotDeson   := 9;
                        VAliqPIS      := 0.00;   // R$/un (monofásico)
                        VAliqCOFINS   := 0.00;   // R$/un
                        AliqIntraDest := 0.00;

                        // ----- Taxas Aproximadas - IBPT ----- //
                        TribMun := QueTxapr.FieldByName('TaxaMun').AsFloat;
                        TribEst := QueTxapr.FieldByName('TaxaEst').AsFloat;
                        TribFed := QueTxapr.FieldByName('TaxaFed').AsFloat;
                        TribImp := QueTxapr.FieldByName('TaxaImp').AsFloat;
                     end; //with

                     // ----- Reforma Tributária ----- //
                     if RT_ATIVO then
                     begin
                        RT_IteCal[Ii]     := TItemInputRT.Make;
                        RT_IteCal[Ii].Id  := FieldByName('IDProd').AsString;
                        RT_IteCal[Ii].Qtd := FieldByName('Qtdped').AsFloat;
                        RT_IteCal[Ii].PrecoLiquidoUnit  := FieldByName('PrecoVen').AsFloat;
                        RT_IteCal[Ii].DescItemValor     := FieldByName('VlrDesc').AsFloat;

                        RT_IteCal[Ii].ISAplicavel       := FieldByName('AliqIS').AsFloat > 0.00;
                        RT_IteCal[Ii].Rates.IS_Seletivo := FieldByName('AliqIS').AsFloat;

                        RT_IteCal[Ii].Rates.IBS_UF      := QueParam.FieldByName('AliqIBSEst').AsFloat;
                        RT_IteCal[Ii].Rates.IBS_Mun     := QueParam.FieldByName('AliqIBSMun').AsFloat;
                        RT_IteCal[Ii].Rates.CBS         := QueParam.FieldByName('AliqCBS').AsFloat;

                        RT_IteCal[Ii].AbatIBS_UF_Perc   := FieldByName('PerRedIBS').AsFloat;
                        RT_IteCal[Ii].AbatIBSMun_Perc   := FieldByName('PerRedIBS').AsFloat;
                        RT_IteCal[Ii].AbatCBS_Perc      := FieldByName('PerRedCBS').AsFloat;
                     end; //if

                     Inc(Ii);
                     QueItem.Next;
                  end; //while

                  DocValorAdd.VFrete     := 0.00;
                  DocValorAdd.VSeg       := 0.00;
                  DocValorAdd.VOutros    := 0.00;
                  DocValorAdd.VDescTotal := QuePedi.FieldByName('VlrDesc').AsFloat;
                  DocValorAdd.Rateio     := TRateioAcessorio.raPorValor;

                  if not CalcImpostosNFe(auxRegime, iif(QueParam.FieldByName('Estmun').AsString = QuePedi.FieldByName('Estmun').AsString, TDestinoOper.doInterna, TDestinoOper.doInterestadual),
                     IteCal, DocValorAdd, aImpostos, aTotais, nil) then raise Exception.Create('Error ao calcular os impostos da NFe (uGeraNFe)');

                  if RT_ATIVO then
                     if not CalcImpostosLoteRT(RT_IteCal, QuePedi.FieldByName('VlrDesc').AsFloat, RT_OutIt, RT_Tot) then
                     raise Exception.Create('Error ao calcular os impostos da Reforma Tribut. da NFe (uGeraNFe)');

                  // ----- Atualização dos spdNFCeDS.Campos dos Itens da NFCe ----- //
                  Ii := 0;
                  First;
                  while not Eof do
                  begin
                     IncluirItem;
                     begin              
                        auxvProd    := SimpleRoundTo(FieldByName('Qtdped').AsFloat * FieldByName('PrecoVen').AsFloat, -2);
                        auxEAN      := iif(FieldByName('CodEANpri').AsString.Trim = '', 'SEM GTIN', FieldByName('CodEANpri').AsString);
                        auxCST_CSON := iif(auxRegime = TRegime.rtRPA, StrZero(FieldByName('CSTICMS').AsString,2), FieldByName('CSOSN').AsString);
                        Campo('nItem_H02').Value := (Ii+1).ToString;
                        Campo('cProd_I02').Value := QueItem.FieldByName('IDProd').AsString;
                        Campo('cEAN_I03').Value  := auxEAN;
                        Campo('NCM_I05').Value   := QueItem.FieldByName('CodNCM').AsString;
                        if HOMOLOGANDO then
                             Campo('xProd_I04').Value := 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL'
                        else Campo('xProd_I04').Value := QueItem.FieldByName('Despro').AsString.Trim;
                        if MatchStr(auxCST_CSON,['60','201','202','203','500']) then 
                           Campo('CEST_I05c').Value := QueItem.FieldByName('CodCEST').AsString;
                        Campo('CFOP_I08').Value     := iif(MatchStr(auxCST_CSON,['60','201','202','203','500']),'5405','5102');
                        Campo('uCom_I09').Value     := FieldByName('SiglaUN').AsString;
                        Campo('qCom_I10').Value     := FormatDouble(FieldByName('Qtdped').AsFloat,  11,2);
                        Campo('vUnCom_I10a').Value  := FormatDouble(FieldByName('PrecoVen').AsFloat,11,2);
                        Campo('vProd_I11').Value    := FormatDouble(auxvProd,11,2);
                        Campo('cEANTrib_I12').Value := auxEAN;
                        Campo('uTrib_I13').Value    := FieldByName('SiglaUN').AsString;
                        Campo('qTrib_I14').Value    := FormatDouble(FieldByName('Qtdped').AsFloat, 11,2);
                        Campo('vUnTrib_I14a').Value := FormatDouble(auxvProd, 11,2);
                        if aImpostos[Ii].vDesc > 0.00 then Campo('vDesc_I17').Value := FormatDouble(aImpostos[Ii].vDesc, 11,2);
                        TotImpApro := aImpostos[Ii].vIBPMun + aImpostos[Ii].vIBPEst + aImpostos[Ii].vIBPFed + aImpostos[Ii].vIBPImp;
                        Campo('indTot_I17b').Value  := '1';
                        Campo('vTotTrib_M02').Value := FormatDouble(TotImpApro, 11,2);

                        // ==================== TRIBUTAÇÃO DO ITEM ==================== //
                        spNDataSet := nil;
                        spCDataSet := locServer.spdNFCeDS;

                        // ------------- SIMPLES NACIONAL RT - 1 ------------- //
                        auxCST_CSON := iif(auxRegime = TRegime.rtRPA, StrZero(FieldByName('CSTICMS').AsString,2), FieldByName('CSOSN').AsString);
                        if auxRegime = TRegime.rtSimples then
                        begin
                           // ---- ICMS --- //
                           if auxCST_CSON = '101' then Tecno.ICMSSN101(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]);
                           if auxCST_CSON = '201' then Tecno.ICMSSN201(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]);
                           if auxCST_CSON = '500' then Tecno.ICMSSN500(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]);
                           if auxCST_CSON = '900' then Tecno.ICMSSN900(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]);
                           if MatchStr(auxCST_CSON, ['202','203']) then
                           begin
                              auxTCSOSN := iif(auxCST_CSON = '202', TCSOSN.sn202, TCSOSN.sn203);
                              Tecno.ICMSSN202_203(locServer.spdNFeDS, auxTCSOSN, IteCal[Ii], aImpostos[Ii]);
                           end;
                           if MatchStr(auxCST_CSON, ['102','103','300','400']) then
                           begin
                              if auxCST_CSON = '102' then auxTCSOSN := TCSOSN.sn102 else
                              if auxCST_CSON = '103' then auxTCSOSN := TCSOSN.sn103 else
                              if auxCST_CSON = '300' then auxTCSOSN := TCSOSN.sn300 else
                              if auxCST_CSON = '400' then auxTCSOSN := TCSOSN.sn400;
                              Tecno.ICMSSN102_103_300_400(locServer.spdNFeDS, auxTCSOSN, IteCal[Ii]);
                           end; //if

                           Campo('CST_Q06').Value := auxPIS_COF;  // ---- PIS
                           Campo('CST_S06').Value := auxPIS_COF;  // --- COFINS
                        end else
                        // ------------- REGIME NORMAL (RT - 2/3) ------------ //
                        if  auxRegime = TRegime.rtRPA then
                        begin
                           // ---- ICMS --- //
                           if auxCST_CSON = '00' then Tecno.ICMS00(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '10' then Tecno.ICMS10(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '20' then Tecno.ICMS20(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '30' then Tecno.ICMS30(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '40' then Tecno.ICMS40(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '41' then Tecno.ICMS41(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '50' then Tecno.ICMS50(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '51' then Tecno.ICMS51(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '60' then Tecno.ICMS60(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '70' then Tecno.ICMS70(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]) else
                           if auxCST_CSON = '90' then Tecno.ICMS90(locServer.spdNFeDS, IteCal[Ii], aImpostos[Ii]);
                        end; //if

                        // ------ PIS / CONFINS ------ //
                        Tecno.PIS_COFINS(locServer.spdNFeDS, IteCal[Ii],aImpostos[Ii]);

                        // ------------------- REFORMA TRIBUTÁRIA ------------------- //
                        if RT_ATIVO then
                        begin
                           // ------ Imposto Seletivo (IS) ------- //
                           if FieldByName('AliqIS').AsFloat > 0.00 then
                           begin
                              Campo('CSTIS_UB02').Value        := '';  // Tabela ainda não publicada
                              Campo('cClassTribIS_UB03').Value := '';  // Tabela ainda não publicada
                              Campo('vBCIS_UB05').Value        := FormatDouble(RT_OutIt[Ii].vBCIS,  11,2);
                              Campo('pIS_UB06').Value          := FormatDouble(RT_OutIt[Ii].pISEspec,3,2);
                              Campo('uTrib_UB09').Value        := FieldByName('SiglaUN').AsString;
                              Campo('vIS_UB11').Value          := FormatDouble(RT_OutIt[Ii].vIS, 11,2);
                           end; //if

                           // ---------- Imposto IBS / CBS ------- //
                           Campo('CST_UB13').Value        := Copy(FieldByName('CodClasIte').AsString,1,3);
                           Campo('cClassTrib_UB14').Value := FieldByName('CodClasIte').AsString;
                           Campo('vBC_UB16').Value        := FormatDouble(RT_OutIt[Ii].vBCIBSCBS, 11,2);
                           Campo('vIBS_UB54a').Value      := FormatDouble(RT_OutIt[Ii].vTribRegIBSUF + RT_OutIt[Ii].vTribRegIBSMun,11,2);  //... (Soma de vIBSUF e vIBSMun)

                           // ------ IBS UF ------ //
                           Campo('pIBSUF_UB18').Value     := FormatDouble(QueParam.FieldByName('AliqIBSEst').AsFloat,6,2);
                           Campo('pRedAliq_UB27').Value   := FormatDouble(FieldByName('PerRedIBS').AsFloat,6,2);
                           Campo('pAliqEfet_UB28').Value  := FormatDouble(RT_OutIt[Ii].pAliqEfetRegIBSUF,6,2);
                           Campo('vIBSUF_UB35').Value     := FormatDouble(RT_OutIt[Ii].vTribRegIBSUF,10,2);

                           // ---- IBS Muni. ---- //
                           Campo('pIBSMun_UB37').Value    := FormatDouble(QueParam.FieldByName('AliqIBSMun').AsFloat,3,2);
                           Campo('pRedAliq_UB46').Value   := FormatDouble(FieldByName('PerRedIBS').AsFloat, 3,2);
                           Campo('pAliqEfet_UB47').Value  := FormatDouble(RT_OutIt[Ii].pAliqEfetRegIBSMun, 3,2);
                           Campo('vIBSMun_UB54').Value    := FormatDouble(RT_OutIt[Ii].vTribRegIBSMun, 11,2);

                           // ---- IMPOSTO CBS ---- //
                           Campo('pCBS_UB56').Value       := FormatDouble(QueParam.FieldByName('AliqCBS').AsFloat, 3,2);
                           Campo('pRedAliq_UB65').Value   := FormatDouble(FieldByName('PerRedCBS').AsFloat, 3,2);
                           Campo('pAliqEfet_UB66').Value  := FormatDouble(RT_OutIt[Ii].pAliqEfetRegCBS, 6,2);
                           Campo('vCBS_UB67').Value       := FormatDouble(RT_OutIt[Ii].vTribRegCBS, 10,2);
                        end; //if
                     end; //begin

                     Inc(Ii);
                     SalvarItem;
                     QueItem.Next;
                  end; //while
               end; //with

               // --------- Totalizadores da NFCe --------- //
               TTecnoSpeed.Totals(locServer.spdNFeDS, aTotais, False);

               // ----- Totalizadores da Reforma Tributária ----- //
               if RT_ATIVO then
               begin
                  Campo('vBCIBSCBS_W35').Value := FormatDouble(RT_Tot.vBCIBSCBS,11,2);
                  Campo('vDif_W38').Value      := '0.00';
                  Campo('vDevTrib_W39').Value  := '0.00';
                  Campo('vIBSUF_W41').Value    := FormatDouble(RT_Tot.TotalIBSUF,11,2);
                  Campo('vDif_W43').Value      := '0.00';
                  Campo('vDevTrib_W44').Value  := '0.00';
                  Campo('vIBSMun_W46').Value   := FormatDouble(RT_Tot.TotalIBSMun,11,2);
                  Campo('vIBS_W47').Value      := FormatDouble(RT_Tot.vIBS,11,2);
                  Campo('vCredPres_W48').Value         := '0.00';
                  Campo('vCredPresCondSus_W49').Value  := '0.00';
                  Campo('vCredPres_W56a').Value        := '0.00';
                  Campo('vCredPresCondSus_W56b').Value := '0.00';
                  Campo('vDif_W53').Value     := '0.00';
                  Campo('vDevTrib_W54').Value := '0.00';
                  Campo('vCBS_W56').Value     := FormatDouble(RT_Tot.TotalCBS,11,2);
                  Campo('vNFTot_W60').Value   := FormatDouble(RT_Tot.vNFTot,  11,2);
               end; //if

               // ------ Dados de Pagamentos ------ //
               while not QuePagto.Eof do
               begin
                  IncluirPart('YA');
                  begin
                     Campo('indPag_YA01b').Value := iif(QuePagto.FieldByName('IndPagVis').AsString = '0','1','0');
                     Campo('tPag_YA02').Value    := QuePagto.FieldByName('IDForPagNF').AsString;
                     Campo('vPag_YA03').Value    := FormatDouble(QuePagto.FieldByName('VlrPago').AsFloat,11,2);
                     Campo('dPag_YA03a').Value   := DataMySQL(DateOf(DataHoje));
                     if QuePagto.FieldByName('IDGruCard').AsBoolean then
                     begin
                        Campo('tpIntegra_YA04a').Value := '1'; //iif(QuePagto.FieldByName('IndPOS').AsString = '1','2','1');
                        Campo('CNPJ_YA05').Value  := QuePagto.FieldByName('CNPJadi').AsString;
                        Campo('tBand_YA06').Value := QuePagto.FieldByName('IDBan').AsString.PadLeft(2,'0');
                        Campo('cAut_YA07').Value  := QuePagto.FieldByName('NroNSU').AsString.Trim;
                     end; //if
                  end; //begin
                  SalvarPart('YA');
                  QuePagto.Next;
               end; //while

               // ----- Transporte  ----- //
               Campo('modFrete_X02').Value  := '9';

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
                  Campo('infCpl_Z03').Value     := iif(QueParam.FieldByName('RegTributa').AsString <> '3','DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL','');
                  Campo('infAdFisco_Z02').Value := '';
               end;
            end; //begin
            Salvar;

            KEY_NFC := Copy(Campo('Id_A03').AsString,4,44);
            XML_NFC := LoteNFCe.GetText;
            XML_NFC := locServer.spdNFCe.AssinarNota(XML_NFC);
         end; //with

         /// ------ TESTE ------- ///
         //  var arq: TextFile;
         //  AssignFile(arq, '.\NFC_Teste.xml');
         //  Rewrite(arq);
         //  Writeln(arq, XML_NFC);
         //  CloseFile(arq);

         NFSalvar.Tabela := 'arqpedido';
         NFSalvar.CmpKey := 'IDPed';
         NFSalvar.IDCFOP := '1';
         NFSalvar.Modelo := '65';
         NFSalvar.CmpDad := NroPedRec;
         NFSalvar.Chave  := KEY_NFC;
         SalvarNF(NFSalvar, recFILIAL);

         retResNFe := EnviaNFC(locServer.spdNFCe, recFILIAL, NroPedRec, CONTIGENCIA, XML_NFC, KEY_NFC);
         if retResNFe.CStat <> '100' then raise Exception.Create(retResNFe.xMotivo);
         Result := ''
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Envio de NFCe (uGerarNFCe) -> '+E.Message);
            Result := 'Não foi possível enviar NF. Motivo: '+E.Message;
            Exit;
         end;
      end;
   finally
      QuePedi.Close;   FreeAndNil(QuePedi);
      QueItem.Close;   FreeAndNil(QueItem);
      QueParam.Close;  FreeAndNil(QueParam);
      QuePagto.Close;  FreeAndNil(QuePagto);
      QueTxapr.Close;  FreeAndNil(QueTxapr);
      locServer.FDConnect.Close;
      locServer.Free;
   end;
end;

// ---------- Enviar XML (NFC) ao SEFAZ --------- //
function EnviaNFC(recSpdNFCe:TspdNFCe; recFILIAL,recNroPed:String; IN_CONT:Boolean; recXML_NFC,recKEY_NFC:String):TNFCeResultado;
var
   F:TextFile;
   NomArquivo,xpXML,XmlProc,retErro:String;
begin
   if IN_CONT then
   begin
      // ---------- Emissão em Contingência ---------- //
      NomArquivo := PastaNFC+'\XMLContigencia\'+recKEY_NFC+'.XML';
      AssignFile(F,NomArquivo);
      Rewrite(F);
      Writeln(F,recXML_NFC);
      CloseFile(F);
      //locServer.spdNFCe.ImprimirDanfce('0001',recXML_NFC,PastaNFC+'\Templates\vm60\Danfce\retrato.rtm', PrintNFC);
      NFSalvar.Status := 'F';
      SalvarNF(NFSalvar, recFILIAL, True);
      Result.cStat   := '100';
      Result.xMotivo := 'NFCe emitida em contigência.';
   end else
   begin
      // ------------- Emissão Normal -------------- //
      Result := EnviarNFCeSincrono(recSpdNFCe, '0001', recXML_NFC);
      if not Result.Sucesso then
      begin
         NFSalvar.CodRet := iif(Result.CStat <> '', Result.CStat, '9999');
         SalvarNF(NFSalvar, recFILIAL);
         if MatchStr(Result.cStat,['108','109']) or (Result.CStat = '') then
              SalvaLog(USUARIO,PastaLog,'NFCe não enviada - PEDIDO: '+recNroPed+' Chave: '+recKEY_NFC+' -> '+Result.xMotivo)
         else SalvaLog(USUARIO,PastaLog,'NFCe rejeitada ou denegada - PEDIDO: '+recNroPed+' Chave: '+recKEY_NFC+' -> '+Result.cStat+' - '+Result.xMotivo);
      end else
      begin
         XmlProc := MontarNFeAutorizada_XML(recXML_NFC, Result.XmlBruto);
         TFile.WriteAllText(PastaNFC+'\XmlDestinoAIONE\'+Result.ChNFe+'-NFCe.xml', XmlProc, TEncoding.UTF8);
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

// --------- Inutilização de Número de NFC Por Erro de Geração --------- //
function InutilizaNFC(NroNotIni:String; NroNotFim:String = ''; recMotivo:String = ''):TNFCeResultado;
var
   cStat,xMotivo,xmlResult:String;
begin
   {ConfAmbienteNFC;
   if NroNotFim.Trim = '' then NroNotFim := NroNotIni;
   if recMotivo.Trim = '' then recMotivo := 'ERRO DE GERACAO NUMERICA POR FALHA DO SISTEMA';
   xmlResult := locserver.spdNFCe.InutilizarNF('', Copy(IntToStr(Year(Date)),3,2), locserver.spdNFCe.CNPJ, '65', iif(HOMOLOGANDO,'2','1'), NronotIni, NronotFim, recMotivo);
   cStat     := obterNroResultado(xmlResult, '<cStat','</cStat',     Pos('<dhRecbto',xmlResult));
   xMotivo   := obterNroResultado(xmlResult, '<xMotivo','</xMotivo', Pos('<dhRecbto',xmlResult));
   Result.Sucesso := cStat = '100';
   Result.cStat   := cStat;
   Result.xMotivo := xMotivo; }
end;

// ------------ Configuração do Ambiente Para Envio das NFCe ----------- //
function ConfAmbienteNFC(recSpdNFCe:TspdNFCe):Boolean;
var
   QueParam:TFDQuery;
   locServer:TDMServer;
begin
   Result    := False;
   QueParam  := TFDQuery.Create(nil);
   locServer := TDMServer.Create(nil);
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

         with recSpdNFCe, QueParam do
         begin
            PRINTERNF    := FieldByName('PrinterNFC').AsString;
            HOMOLOGANDO  := FieldByName('HomolNFCe').AsBoolean;
            CONTIGENCIA  := FieldByName('IndContNFC').AsBoolean;
            MENEnvMailNF := FieldByName('MenEnvMailNF').AsString;
            SITEConsNFC  := FieldByName('SiteConsNFC').AsString;

            VersaoManual := vm60;
            HttpLibs := 'SBB';
            PastaNFC := FieldByName('PastaConfNFCe').AsString.Trim;
            PrintNFC := FieldByName('PrinterNFC').AsString.Trim;
            UF       := FieldByName('Estmun').AsString.Trim;
            CNPJ     := FieldByName('CNPJFar').AsString.Trim;
            Ambiente := iif(FieldByName('HomolNFCe').AsBoolean, akHomologacao, akProducao);
            ValidarEsquemaAntesEnvio := True;
            DiretorioEsquemas        := PastaNFC+'\Esquemas\';
            DiretorioTemplates       := PastaNFC+'\Templates\';
            DiretorioLog             := PastaNFC+'\Log\';
            DiretorioLicense         := PastaNFC+'\License\';
            ArquivoServidoresHom     := PastaNFC+'\nfceServidoresHom.ini';
            ArquivoServidoresProd    := PastaNFC+'\nfceServidoresProd.ini';
            DiretorioXmlDestinatario := PastaNFC+'\XmlDestinatario\';
            DiretorioLogErro         := PastaNFC+'\Erros\';
            DiretorioTemporario      := PastaNFC+'\Temp\';
            SenhaCertificado         := FieldByName('SenDigital').AsString.Trim;
            NomeCertificado.Clear;
            NomeCertificado.Add(FieldByName('CerDigital').AsString.Trim);
            with DanfceSettings do
            begin
               if FieldByName('IndContNFC').AsBoolean then
                    QtdeCopias    := iif(FieldByName('NroViasNF').AsInteger < 2, 2, FieldByName('NroViasNF').AsInteger)
               else QtdeCopias    := FieldByName('NroViasNF').AsInteger;
               ModeloDanfce       := PastaNFC+'\Templates\vm60\Danfce\retrato.rtm';
               LogotipoEmitente   := FieldByName('ImagemNF').AsString.Trim;
               FraseContingencia  := 'DANFE em contigência.';
               TokenNFCe          := FieldByName('CSCNFCe').AsString.Trim;
               IdTokenNFCe        := FieldByName('TokenNFCe').AsString.Trim;
               ExibirDetalhamento := True;
               ModeloDanfceMensagemEletronica := PastaNFC+'\Templates\vm60\Danfce\retrato.rtm';
               ConfigurarSoftwareHouse('27124815000139','17ee76f292e5c98566cb6b413c0c8dc6');
            end; //with
            with EmailSettings do
            begin
               Mensagem := '';
               Assunto   := '';
               Porta     := FieldByName('MailPorta').AsInteger;
               Senha     := FieldByName('MailSenha').AsString.Trim;
               Usuario   := FieldByName('MailUsuario').AsString.Trim;
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
      locServer.Free;
   end;
end;

end.

