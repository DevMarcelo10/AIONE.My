unit uCalculaNF;

{$SCOPEDENUMS ON}

interface

uses
  System.SysUtils, System.Math, System.Generics.Collections,
  spdNFeDataSets, spdNFCeDataSets, MarcLib, System.StrUtils;

type
  // ================== Config e Tipos Base ==================
  TRegime = (rtRPA, rtSimples);

  TDestinoOper = (doInterna = 1, doInterestadual = 2, doExterior = 3);

  TModalidadeBCST = (mbcstPrecoTabelado = 0, mbcstListaNegativa = 1, mbcstListaPositiva = 2,
                     mbcstListaNeutra = 3, mbcstMargemValorAgregado = 4, mbcstPauta = 5, mbcstVlrOperacao = 6);
  TModalidadeBC = (mbcMargemValorAgregado = 0, mbcPauta = 1, mbcPrecoTabelado = 2, mbcValorOperacao = 3);

  TRateioAcessorio = (raPorValor, raPorQuantidade);

  // CST/CSOSN (subset usual em varejo)
  TICMSCST = (icms00, icms10, icms20, icms30, icms40, icms41, icms50, icms51, icms60, icms70, icms90);
  TCSOSN   = (sn101, sn102, sn103, sn201, sn202, sn203, sn300, sn400, sn500, sn900);
  TPISCST  = (pis01, pis02, pis03, pis04, pis05, pis06, pis07, pis08, pis09, pis49, pis50, pis51, pis52, pis53, pis54, pis55, pis56, pis60, pis61, pis62, pis63, pis64, pis65, pis66, pis67, pis70, pis71, pis72, pis73, pis74, pis75, pis98, pis99);
  TCOFINSCST = (cof01, cof02, cof03, cof04, cof05, cof06, cof07, cof08, cof09, cof49, cof50, cof51, cof52, cof53, cof54, cof55, cof56, cof60, cof61, cof62, cof63, cof64, cof65, cof66, cof67, cof70, cof71, cof72, cof73, cof74, cof75, cof98, cof99);

  // Entrada (parâmetros) por item
  TItemEntrada = record
    // Identificação fiscal/comercial
    CFOP      : string;
    NCM       : string;
    CEST      : string;
    CBarra    : string;
    Orig      : Integer;    // 0..8
    CST       : TICMSCST;   // RPA
    CSOSN     : TCSOSN;     // SN
    CSTPIS    : TPISCST;
    CSTCOFINS : TCOFINSCST;

    // Quantidades e preços
    Qtd       : Double;
    VUn       : Double;   // preço unitário bruto
    VDescItem : Double;   // desconto individual (total)

    // ICMS próprio
    ModBC    : TModalidadeBC;
    PRedBC   : Double;   // % redução BC
    PICMS    : Double;   // %
    // ST
    TemST    : Boolean;
    ModBCST  : TModalidadeBCST;
    PMVAST   : Double;   // %
    PRedBCST : Double;   // %
    PICMSST  : Double;   // %
    VPAUTA   : Double;   // pauta por unidade (se aplicável)

    // FCP
    PFCP  : Double;   // %

    // FCP-ST
    PFCPST : Double;   // %

    // DIFAL (CF-e não contribuinte)
    TemDIFAL      : Boolean;
    AliqInter     : Double;   // %
    AliqIntraDest : Double;   // %
    FCPDIFAL      : Double;   // %

    // Benefícios
    MotDeson      : Integer;  // motivo, se houver
    PIsencao      : Double;   // % (usa-se como pDif para CST 51)

    // PIS/COFINS
    PPIS          : Double;   // %
    PCOFINS       : Double;   // %
    VAliqPIS      : Double;   // R$/un (monofásico)
    VAliqCOFINS   : Double;   // R$/un

    // IBPT aprox. (%)
    TribMun : Double; // %
    TribEst : Double; // %
    TribFed : Double; // %
    TribImp : Double; // %

    // Flags
    EhSN              : Boolean;  // Simples Nacional?

    // ---- Benefícios fiscais (por UF × CST/CSOSN) ----
    cBenef         : string;  // <cBenef> do item
    cBenefRBC      : string;  // <cBenefRBC> (ex.: redução da base/diferimento – p/ CST 51 ou UF que exija)
    pCredPresumido : Double;  // % crédito presumido (se a UF exigir expor)
    vCredPresumido : Double;  // valor do crédito presumido (se a UF exigir expor)
    ObsBenef       : string;  // texto p/ infCpl (opcional)
  end;

  // Acessórios (rateio)
  TDocAcessorios = record
    VFrete       : Double;
    VSeg         : Double;
    VOutros      : Double;
    VDescTotal   : Double;
    Rateio       : TRateioAcessorio;
  end;

  // Saída por item
  TItemImpostos = record
    // comerciais
    vProd, vFrete, vSeg, vOutro, vDesc, vItem: Double;
    // ICMS
    vBC, vICMS, vICMSDeson, vFCP: Double;
    // ST
    vBCST, vICMSST, vFCPST: Double;
    // DIFAL
    vBCUFDest, vICMSUFDest, vICMSUFRemet, vFCPUFDest: Double;
    // PIS/COFINS
    vBCPIS, vPIS, vBCCOFINS, vCOFINS: Double;
    // IBPT aproximado (valores)
    vIBPMun, vIBPEst, vIBPFed, vIBPImp: Double;
  end;

  // Totais
  TTotaisNota = record
    vBC, vICMS, vICMSDeson, vFCP: Double;
    vBCST, vST, vFCPST: Double;
    vProd, vFrete, vSeg, vOutro, vDesc: Double;
    vPIS, vCOFINS: Double;
    vBCUFDest, vICMSUFDest, vICMSUFRemet, vFCPUFDest: Double;
    vIBPTMun, vIBPTEst, vIBPTFed, vIBPTImp, vAproxImp: Double;
    vNF: Double;
  end;

  // ================== Regras Plugáveis (UF/NCM/CEST) ==================
  IRegraFiscalProvider = interface
    ['{8E7E7A85-2B9B-4C80-9F1D-6B2E8B7E9D9B}']
    procedure PrepararParametros(var Item: TItemEntrada; const UFEmitente, UFDestino: string);
  end;

  function GetICMSCST(const Code:String):TICMSCST;
  function GetCSOSN  (const Code: string):TCSOSN;
  function GetPISCST(const Code: string):TPISCST;
  function GetCOFINSCST(const Code: string):TCOFINSCST;

   function CalcImpostosNFe(
     const ARegime   : TRegime;
     const DestOper  : TDestinoOper;
     const Itens     : TArray<TItemEntrada>;
     const Doc       : TDocAcessorios;
     out   Impostos  : TArray<TItemImpostos>;
     out   Totais    : TTotaisNota;
     const RegraProv : IRegraFiscalProvider = nil): Boolean;

// ======================= TecnoSpeed (W/Q/S e grupos N/O) ======================= //
type
  TTecnoSpeed = record
    // ===== ICMS - RPA (CST) =====
    class procedure ICMS00(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static;
    class procedure ICMS10(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static;
    class procedure ICMS20(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static;
    class procedure ICMS30(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static;
    class procedure ICMS40(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static; // Isenção/NT/Suspensão (desoneração)
    class procedure ICMS41(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static; // Não tributada (desoneração)
    class procedure ICMS50(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static; // Suspensão (desoneração)
    class procedure ICMS51(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static; // Diferimento (vICMSOp/pDif/vICMSDif)
    class procedure ICMS60(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static; // ST cobrado anteriormente (retido)
    class procedure ICMS70(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static; // Redução + ST
    class procedure ICMS90(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static; // Outros (com/sem ST)

    // ===== ICMS - Simples Nacional (CSOSN) =====
    class procedure ICMSSN101(spDataSet:TspdNFeDataSets; const En: TItemEntrada;  const It: TItemImpostos); static; // Crédito
    class procedure ICMSSN102_103_300_400(spDataSet:TspdNFeDataSets; const CSOSN: TCSOSN; const En: TItemEntrada); static; // Sem débito/sem crédito
    class procedure ICMSSN201(spDataSet:TspdNFeDataSets; const En: TItemEntrada;  const It: TItemImpostos); static; // Crédito + ST
    class procedure ICMSSN202_203(spDataSet:TspdNFeDataSets; const CSOSN: TCSOSN; const En: TItemEntrada; const It: TItemImpostos); static; // ST
    class procedure ICMSSN500(spDataSet:TspdNFeDataSets; const En: TItemEntrada;  const It: TItemImpostos); static; // ST cobrado anteriormente (retido no SN)
    class procedure ICMSSN900(spDataSet:TspdNFeDataSets; const En: TItemEntrada;  const It: TItemImpostos); static; // Outros (SN)

    // PIS/COFINS (Q/S)
    class procedure PIS_COFINS(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos); static;

    // Totais (Wxx)
    class procedure Totals(spDataSet:TspdNFeDataSets; const Tot: TTotaisNota; const SomaSTnoVNF: Boolean); static;
  end;

var
   spNDataSet:TspdNFeDataSets;
   spCDataSet:TspdNFCeDataSets;

implementation

// ========================= Utils ========================= //
function Round2(const V: Double): Double; inline;
begin
  Result := SimpleRoundTo(V, -2); //  2 casas
end;

function Nz(const V: Double):Double; inline;
begin
  if IsNaN(V) or IsInfinite(V) then Exit(0);
  Result := V;
end;

function ToStr2(const V: Double): string; inline;
var
   FS: TFormatSettings;
begin
  FS := TFormatSettings.Create;
  FS.DecimalSeparator := '.';
  Result := FormatFloat('0.00##', V, FS);
end;

// ================================= Rateio =================================
procedure RatearAcessoriosPorValor(const Itens: TArray<TItemEntrada>; const Doc: TDocAcessorios;
                                   out RateioFrete, RateioSeg, RateioOutros, RateioDesc: TArray<Double>);
var
  i: Integer;
  SomaBase, SomaQtd:Double;
begin
  SetLength(RateioFrete, Length(Itens));
  SetLength(RateioSeg,   Length(Itens));
  SetLength(RateioOutros,Length(Itens));
  SetLength(RateioDesc,  Length(Itens));
  SomaBase := 0; SomaQtd := 0;
  for i := 0 to High(Itens) do
  begin
    SomaBase := SomaBase + Max(0, Itens[i].Qtd * Itens[i].VUn - Itens[i].VDescItem);
    SomaQtd  := SomaQtd  + Max(0, Itens[i].Qtd);
  end;
  if (Doc.Rateio = TRateioAcessorio.raPorQuantidade) and (SomaQtd = 0) then
    SomaQtd := 1
  else if (Doc.Rateio = TRateioAcessorio.raPorValor) and (SomaBase = 0) then
    SomaBase := 1;
  for i := 0 to High(Itens) do
  begin
    var peso: Double;
    if Doc.Rateio = TRateioAcessorio.raPorQuantidade then
      peso := Max(0, Itens[i].Qtd) / SomaQtd
    else
      peso := Max(0, Itens[i].Qtd * Itens[i].VUn - Itens[i].VDescItem) / SomaBase;
    RateioFrete[i]  := Round2(Nz(Doc.VFrete)  * peso);
    RateioSeg[i]    := Round2(Nz(Doc.VSeg)    * peso);
    RateioOutros[i] := Round2(Nz(Doc.VOutros) * peso);
    RateioDesc[i]   := Round2(Nz(Doc.VDescTotal) * peso);
  end;
end;

// ========================= Cálculos =========================
function CalcBaseItem(const It: TItemEntrada; const Fre, Seg, Outr, DescRateio: Double;
                      out vProd, vItem, vFrete, vSeg, vOutros, vDesc: Double): Double;
begin
  vProd   := Round2(It.Qtd * It.VUn);
  vFrete  := Round2(Fre);
  vSeg    := Round2(Seg);
  vOutros := Round2(Outr);
  vDesc   := Round2(Nz(It.VDescItem) + DescRateio);
  vItem   := Round2(vProd + vFrete + vSeg + vOutros - vDesc);
  if vItem < 0 then vItem := 0;
  Result := vItem; // base valor da operação (antes de reduções específicas) //
end;

procedure CalcICMSProprio(const It: TItemEntrada; const vItemBase: Double; out vBC, vICMS, vFCP, vDeson: Double);
var
  base:Double;
  vICMSOp:Double;
begin
  vBC := 0; vICMS := 0; vFCP := 0; vDeson := 0;

  if (not It.EhSN) or (It.CSOSN = TCSOSN.sn900) then
  begin
     base := vItemBase;
     if It.PRedBC > 0 then
       base := Round2(base * (1 - It.PRedBC/100));
     vBC    := Round2(Max(0, base));
     vICMSOp:= Round2(vBC * Nz(It.PICMS)/100);
     vICMS  := vICMSOp;
     // Diferimento (CST 51): reduzir o vICMS sem somar em vICMSDeson //
     if (It.PIsencao > 0) and (It.CST = TICMSCST.icms51) then
     begin
       vICMS := Round2(Max(0, vICMSOp * (1 - It.PIsencao/100)));
       // vDeson permanece 0 (vICMSDif será exibido no grupo N33/N34/N35) //
     end
     // Demais casos de desoneração e isenção //
     else
     if (It.PIsencao > 0) then
     begin
       vDeson := Round2(vICMS * It.PIsencao/100);
       vICMS  := Round2(Max(0, vICMS - vDeson));
     end;
     if It.PFCP > 0 then
       vFCP := Round2(vBC * It.PFCP/100);
  end; //if
end;

procedure CalcST(const It: TItemEntrada; const vItemBase: Double; const vICMSProprio: Double; ARegime:TRegime;
                 out vBCST, vICMSST, vFCPST: Double);
var
   bcst:Double;
begin
   vBCST := 0; vICMSST := 0; vFCPST := 0;
   if not It.TemST then Exit;
   if ARegime = TRegime.rtRPA then 
      if not (It.CST in [TICMSCST.icms10,TICMSCST.icms30,TICMSCST.icms60,TICMSCST.icms70,TICMSCST.icms90]) then Exit;
   if ARegime = TRegime.rtSimples then 
      if not (It.CSOSN in [TCSOSN.sn201,TCSOSN.sn202,TCSOSN.sn203,TCSOSN.sn900]) then Exit;
   case It.ModBCST of
      TModalidadeBCST.mbcstMargemValorAgregado:
      begin
         bcst := vItemBase;
         if It.PRedBCST > 0 then bcst := Round2(bcst * (1 - It.PRedBCST/100));
         if It.PMVAST   > 0 then bcst := Round2(bcst * (1 + It.PMVAST/100));
      end;
      TModalidadeBCST.mbcstPauta: bcst := Round2(It.Qtd * It.VPAUTA);
   else
      bcst := vItemBase;
   end;
   vBCST   := Round2(Max(0, bcst));
   vICMSST := Round2(Max(0, vBCST * It.PICMSST/100 - vICMSProprio));
   if It.PFCPST > 0 then
      vFCPST := Round2(vBCST * It.PFCPST/100);
end;

procedure CalcDIFAL(const It: TItemEntrada; const DestOper: TDestinoOper; const vItemBase: Double;
                    out vBCUFDest, vICMSUFDest, vICMSUFRemet, vFCPUFDest: Double);
var
  aliqDest, aliqDif: Double;
begin
  vBCUFDest := 0; vICMSUFDest := 0; vICMSUFRemet := 0; vFCPUFDest := 0;
  if not It.TemDIFAL then Exit;
  if DestOper <> TDestinoOper.doInterestadual then Exit;
  vBCUFDest := Round2(vItemBase);
  aliqDest  := Nz(It.AliqIntraDest)/100;
  aliqDif   := Max(0, aliqDest - Nz(It.AliqInter)/100);
  vICMSUFDest  := Round2(vBCUFDest * aliqDif);
  vICMSUFRemet := 0; // pós-2019: 100% destino
  if It.FCPDIFAL > 0 then
    vFCPUFDest := Round2(vBCUFDest * It.FCPDIFAL/100);
end; //

procedure CalcPISCOFINS(const It: TItemEntrada; const vItemBase: Double; out vBCPIS, vPIS, vBCCOFINS, vCOFINS: Double);
var
  base: Double;
begin
  vBCPIS := 0; vPIS := 0; vBCCOFINS := 0; vCOFINS := 0;
  // base usual (sem ST): valor da operação
  base := vItemBase;
  // Monofásico por unidade
  if (It.VAliqPIS > 0) then
    vPIS := Round2(It.Qtd * It.VAliqPIS)
  else if (It.PPIS > 0) and not (It.CSTPIS in [TPISCST.pis04, TPISCST.pis06, TPISCST.pis07, TPISCST.pis08, TPISCST.pis09, TPISCST.pis49, TPISCST.pis99]) then
  begin
    vBCPIS := Round2(base);
    vPIS   := Round2(vBCPIS * It.PPIS/100);
  end;
  if (It.VAliqCOFINS > 0) then
    vCOFINS := Round2(It.Qtd * It.VAliqCOFINS)
  else if (It.PCOFINS > 0) and not (It.CSTCOFINS in [TCOFINSCST.cof04, TCOFINSCST.cof06, TCOFINSCST.cof07, TCOFINSCST.cof08, TCOFINSCST.cof09, TCOFINSCST.cof49, TCOFINSCST.cof99]) then
  begin
    vBCCOFINS := Round2(base);
    vCOFINS   := Round2(vBCCOFINS * It.PCOFINS/100);
  end;
end;

// ---------------- IBPT aproximado ----------------
procedure CalcIBPTAproximado(const X: TItemEntrada; const Base: Double; out vMun, vEst, vFed, vImp: Double);
begin
   vMun := Round2(base * (X.TribMun / 100.0));
   vEst := Round2(base * (X.TribEst / 100.0));
   vFed := Round2(base * (X.TribFed / 100.0));
   vImp := Round2(base * (X.TribImp / 100.0));
end;

// ======================= Principal =======================
function CalcImpostosNFe(
  const ARegime   : TRegime;               const DestOper  : TDestinoOper;
  const Itens     : TArray<TItemEntrada>;  const Doc       : TDocAcessorios;
  out   Impostos  : TArray<TItemImpostos>; out   Totais    : TTotaisNota;
  const RegraProv : IRegraFiscalProvider): Boolean;
var
  i: Integer;
  RF, RSg, ROt, RDc: TArray<Double>;
  vProd, vItem, vFre, vSeg, vOut, vDesc: Double;
  vBC, vICMS, vFCP, vDeson: Double;
  vBCST, vICMSST, vFCPST: Double;
  vBCUFDest, vICMSUFDest, vICMSUFRem, vFCPUFDest: Double;
  vBCPIS, vPIS, vBCCOFINS, vCOFINS: Double;
  vIBPTMun, vIBPTEst, vIBPTFed, vIBPTImp: Double;
begin
  Result := False;
  FillChar(Totais, SizeOf(TTotaisNota), 0);
  if Length(Itens) = 0 then Exit;
  SetLength(Impostos, Length(Itens));

  // Opcional: plugar regras por UF/NCM/CEST antes do cálculo
  if Assigned(RegraProv) then
    for i := 0 to High(Itens) do
      RegraProv.PrepararParametros(TItemEntrada(Itens[i]), '', ''); // preencha UFEmitente/UFDestino conforme seu contexto

  RatearAcessoriosPorValor(Itens, Doc, RF, RSg, ROt, RDc);

  for i := 0 to High(Itens) do
  begin
    // Base comercial do item
    CalcBaseItem(Itens[i], RF[i], RSg[i], ROt[i], RDc[i], vProd, vItem, vFre, vSeg, vOut, vDesc);
    // ICMS próprio
    CalcICMSProprio(Itens[i], vItem, vBC, vICMS, vFCP, vDeson);
    // ST
    CalcST(Itens[i], vItem, vICMS, ARegime, vBCST, vICMSST, vFCPST);
    // DIFAL
    CalcDIFAL(Itens[i], DestOper, vItem, vBCUFDest, vICMSUFDest, vICMSUFRem, vFCPUFDest);
    // PIS/COFINS
    CalcPISCOFINS(Itens[i], vItem, vBCPIS, vPIS, vBCCOFINS, vCOFINS);
    // IBPT (aprox.)
    CalcIBPTAproximado(Itens[i], vItem, vIBPTMun, vIBPTEst, vIBPTFed, vIBPTImp);

    // Monta saída do item
    Impostos[i].vProd        := vProd;
    Impostos[i].vFrete       := vFre;
    Impostos[i].vSeg         := vSeg;
    Impostos[i].vOutro       := vOut;
    Impostos[i].vDesc        := vDesc;
    Impostos[i].vItem        := vItem;
    Impostos[i].vBC          := vBC;
    Impostos[i].vICMS        := vICMS;
    Impostos[i].vICMSDeson   := vDeson;
    Impostos[i].vFCP         := vFCP;
    Impostos[i].vBCST        := vBCST;
    Impostos[i].vICMSST      := vICMSST;
    Impostos[i].vFCPST       := vFCPST;
    Impostos[i].vBCUFDest    := vBCUFDest;
    Impostos[i].vICMSUFDest  := vICMSUFDest;
    Impostos[i].vICMSUFRemet := vICMSUFRem;
    Impostos[i].vFCPUFDest   := vFCPUFDest;
    Impostos[i].vBCPIS       := vBCPIS;
    Impostos[i].vPIS         := vPIS;
    Impostos[i].vBCCOFINS    := vBCCOFINS;
    Impostos[i].vCOFINS      := vCOFINS;
    Impostos[i].vIBPMun      := vIBPTMun;
    Impostos[i].vIBPEst      := vIBPTEst;
    Impostos[i].vIBPFed      := vIBPTFed;
    Impostos[i].vIBPImp      := vIBPTImp;

    // Totais
    Totais.vProd       := Round2(Totais.vProd   + vProd);
    Totais.vFrete      := Round2(Totais.vFrete  + vFre);
    Totais.vSeg        := Round2(Totais.vSeg    + vSeg);
    Totais.vOutro      := Round2(Totais.vOutro  + vOut);
    Totais.vDesc       := Round2(Totais.vDesc   + vDesc);
    Totais.vBC         := Round2(Totais.vBC     + vBC);
    Totais.vICMS       := Round2(Totais.vICMS   + vICMS);
    Totais.vICMSDeson  := Round2(Totais.vICMSDeson + vDeson);
    Totais.vFCP        := Round2(Totais.vFCP    + vFCP);
    Totais.vBCST       := Round2(Totais.vBCST   + vBCST);
    Totais.vST         := Round2(Totais.vST     + vICMSST);
    Totais.vFCPST      := Round2(Totais.vFCPST  + vFCPST);
    Totais.vPIS        := Round2(Totais.vPIS    + vPIS);
    Totais.vCOFINS     := Round2(Totais.vCOFINS + vCOFINS);
    Totais.vBCUFDest   := Round2(Totais.vBCUFDest   + vBCUFDest);
    Totais.vICMSUFDest := Round2(Totais.vICMSUFDest + vICMSUFDest);
    Totais.vICMSUFRemet:= Round2(Totais.vICMSUFRemet+ vICMSUFRem);
    Totais.vFCPUFDest  := Round2(Totais.vFCPUFDest  + vFCPUFDest);
    Totais.vIBPTMun    := Round2(Totais.vIBPTMun  + vIBPTMun);
    Totais.vIBPTEst    := Round2(Totais.vIBPTEst  + vIBPTEst);
    Totais.vIBPTFed    := Round2(Totais.vIBPTFed  + vIBPTFed);
    Totais.vIBPTImp    := Round2(Totais.vIBPTImp  + vIBPTImp);
    Totais.vAproxImp   := Round2(Totais.vAproxImp + vIBPTMun + vIBPTEst + vIBPTFed + vIBPTImp);
    Totais.vNF         := Round2(Totais.vNF + vItem);
  end;
  Result := True;
end;

// ======================= TecnoSpeed Construtores ======================= //
procedure VlrToCmp(recCampo,recValor:String);
begin
   if spNDataSet <> nil then
        spNDataSet.Campo(recCampo).Value := recValor
   else spCDataSet.Campo(recCampo).Value := recValor;
end;

// ===== CST (RPA) =====
class procedure TTecnoSpeed.ICMS00(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   VlrToCmp('orig_N11' , En.Orig.ToString);
   VlrToCmp('CST_N12'  , '00');
   VlrToCmp('modBC_N13', Ord(En.ModBC).ToString);
   VlrToCmp('vBC_N15'  , ToStr2(It.vBC));
   VlrToCmp('pICMS_N16', ToStr2(En.PICMS));
   VlrToCmp('vICMS_N17', ToStr2(It.vICMS));
   if It.vFCP > 0 then
   begin
      VlrToCmp('pFCP_N17a', ToStr2(En.PFCP));
      VlrToCmp('vFCP_N17b', ToStr2(It.vFCP));
   end;
   if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
end;

class procedure TTecnoSpeed.ICMS10(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11' , En.Orig.ToString);
      VlrToCmp('CST_N12'  , '10');
      VlrToCmp('modBC_N13', Ord(En.ModBC).ToString);
      VlrToCmp('vBC_N15'  , ToStr2(It.vBC));
      VlrToCmp('pICMS_N16', ToStr2(En.PICMS));
      VlrToCmp('vICMS_N17', ToStr2(It.vICMS));
      if It.vFCP > 0 then
      begin
         VlrToCmp('pFCP_N17a', ToStr2(En.PFCP));
         VlrToCmp('vFCP_N17b', ToStr2(It.vFCP));
      end;
      VlrToCmp('modBCST_N18', IntToStr(Ord(En.ModBCST)));
      if En.PMVAST   > 0 then VlrToCmp('pMVAST_N19'  , ToStr2(En.PMVAST));
      if En.PRedBCST > 0 then VlrToCmp('pRedBCST_N20', ToStr2(En.PRedBCST));
      VlrToCmp('vBCST_N21'  , ToStr2(It.vBCST));
      VlrToCmp('pICMSST_N22', ToStr2(En.PICMSST));
      VlrToCmp('vICMSST_N23', ToStr2(It.vICMSST));
      if It.vFCPST > 0 then
      begin
         VlrToCmp('pFCPST_N26', ToStr2(En.PFCPST));
         VlrToCmp('vFCPST_N27', ToStr2(It.vFCPST));
       end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end; // with
end;

class procedure TTecnoSpeed.ICMS20(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11' , En.Orig.ToString);
      VlrToCmp('CST_N12'  , '20');
      VlrToCmp('modBC_N13', Ord(En.ModBC).ToString);
      if En.PRedBC > 0 then VlrToCmp('pRedBC_N14', ToStr2(En.PRedBC));
      VlrToCmp('vBC_N15',   ToStr2(It.vBC));
      VlrToCmp('pICMS_N16', ToStr2(En.PICMS));
      VlrToCmp('vICMS_N17', ToStr2(It.vICMS));
      if It.vFCP > 0 then
      begin
         VlrToCmp('pFCP_N17a', ToStr2(En.PFCP));
         VlrToCmp('vFCP_N17b', ToStr2(It.vFCP));
      end;
      if It.vICMSDeson > 0 then
      begin
         VlrToCmp('vICMSDeson_N28a', ToStr2(It.vICMSDeson));
         VlrToCmp('motDesICMS_N28', IntToStr(En.MotDeson));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end; // with
end;

class procedure TTecnoSpeed.ICMS30(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11', En.Orig.ToString);
      VlrToCmp('CST_N12' , '30');
      VlrToCmp('modBCST_N18', IntToStr(Ord(En.ModBCST)));
      if En.PMVAST   > 0 then VlrToCmp('pMVAST_N19'  , ToStr2(En.PMVAST));
      if En.PRedBCST > 0 then VlrToCmp('pRedBCST_N20', ToStr2(En.PRedBCST));
      VlrToCmp('vBCST_N21' ,  ToStr2(It.vBCST));
      VlrToCmp('pICMSST_N22', ToStr2(En.PICMSST));
      VlrToCmp('vICMSST_N23', ToStr2(It.vICMSST));
      if It.vFCPST > 0 then
      begin
         VlrToCmp('pFCPST_N26', ToStr2(En.PFCPST));
         VlrToCmp('vFCPST_N27', ToStr2(It.vFCPST));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMS40(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11', En.Orig.ToString);
      VlrToCmp('CST_N12' , '40');
      if It.vICMSDeson > 0 then
      begin
         VlrToCmp('vICMSDeson_N28a', ToStr2(It.vICMSDeson));
         VlrToCmp('motDesICMS_N28' , IntToStr(En.MotDeson));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMS41(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11', En.Orig.ToString);
      VlrToCmp('CST_N12' , '41');
      if It.vICMSDeson > 0 then
      begin
         VlrToCmp('vICMSDeson_N28a', ToStr2(It.vICMSDeson));
         VlrToCmp('motDesICMS_N28' , IntToStr(En.MotDeson));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end; //with
end;

class procedure TTecnoSpeed.ICMS50(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11', En.Orig.ToString);
      VlrToCmp('CST_N12' , '50');
      if It.vICMSDeson > 0 then
      begin
         VlrToCmp('vICMSDeson_N28a', ToStr2(It.vICMSDeson));
         VlrToCmp('motDesICMS_N28' , IntToStr(En.MotDeson));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMS51(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11' , En.Orig.ToString);
      VlrToCmp('CST_N12'  , '51');
      VlrToCmp('modBC_N13', Ord(En.ModBC).ToString);
      if En.PRedBC > 0 then VlrToCmp('pRedBC_N14', ToStr2(En.PRedBC));
      VlrToCmp('vBC_N15'    , ToStr2(It.vBC));
      VlrToCmp('pICMS_N16'  , ToStr2(En.PICMS));
      VlrToCmp('vICMSOp_N33', ToStr2(Round2(It.vBC * (En.PICMS/100))));
      if En.PIsencao > 0 then
      begin
        VlrToCmp('pDif_N34'    , ToStr2(En.PIsencao));
        VlrToCmp('vICMSDif_N35', ToStr2(Round2((It.vBC * (En.PICMS/100)) * En.PIsencao/100)));
      end;
      VlrToCmp('vICMS_N17', ToStr2(It.vICMS));
      if It.vFCP > 0 then
      begin
         VlrToCmp('pFCP_N17a', ToStr2(En.PFCP));
         VlrToCmp('vFCP_N17b', ToStr2(It.vFCP));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
      if En.cBenefRBC <> '' then VlrToCmp('cBenefRBC', En.cBenefRBC);
   end; // with
end;

class procedure TTecnoSpeed.ICMS60(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11'      , En.Orig.ToString);
      VlrToCmp('CST_N12'       , '60');
      VlrToCmp('vBCSTRet_N26'  , ToStr2(It.vBCST));
      VlrToCmp('vICMSSTRet_N27', ToStr2(It.vICMSST));
      if It.vFCPST > 0 then
      begin
         VlrToCmp('pFCPSTRet_N26a', ToStr2(En.PFCPST));
         VlrToCmp('vFCPSTRet_N26b', ToStr2(It.vFCPST));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMS70(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11' , En.Orig.ToString);
      VlrToCmp('CST_N12'  , '70');
      VlrToCmp('modBC_N13', Ord(En.ModBC).ToString);
      if En.PRedBC > 0 then VlrToCmp('pRedBC_N14', ToStr2(En.PRedBC));
      VlrToCmp('vBC_N15'  , ToStr2(It.vBC));
      VlrToCmp('pICMS_N16', ToStr2(En.PICMS));
      VlrToCmp('vICMS_N17', ToStr2(It.vICMS));
      if It.vFCP > 0 then
      begin
         VlrToCmp('pFCP_N17a', ToStr2(En.PFCP));
         VlrToCmp('vFCP_N17b', ToStr2(It.vFCP));
      end;
      VlrToCmp('modBCST_N18', IntToStr(Ord(En.ModBCST)));
      if En.PMVAST   > 0 then VlrToCmp('pMVAST_N19',   ToStr2(En.PMVAST));
      if En.PRedBCST > 0 then VlrToCmp('pRedBCST_N20', ToStr2(En.PRedBCST));
      VlrToCmp('vBCST_N21'  , ToStr2(It.vBCST));
      VlrToCmp('pICMSST_N22', ToStr2(En.PICMSST));
      VlrToCmp('vICMSST_N23', ToStr2(It.vICMSST));
      if It.vFCPST > 0 then
      begin
         VlrToCmp('pFCPST_N26', ToStr2(En.PFCPST));
         VlrToCmp('vFCPST_N27', ToStr2(It.vFCPST));
      end;
      if It.vICMSDeson > 0 then
      begin
         VlrToCmp('vICMSDeson_N28a', ToStr2(It.vICMSDeson));
         VlrToCmp('motDesICMS_N28', IntToStr(En.MotDeson));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMS90(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11' , En.Orig.ToString);
      VlrToCmp('CST_N12'  , '90');
      VlrToCmp('modBC_N13', Ord(En.ModBC).ToString);
      if En.PRedBC > 0 then VlrToCmp('pRedBC_N14', ToStr2(En.PRedBC));
      VlrToCmp('vBC_N15'  , ToStr2(It.vBC));
      VlrToCmp('pICMS_N16', ToStr2(En.PICMS));
      VlrToCmp('vICMS_N17', ToStr2(It.vICMS));
      if It.vFCP > 0 then
      begin
         VlrToCmp('pFCP_N17a', ToStr2(En.PFCP));
         VlrToCmp('vFCP_N17b', ToStr2(It.vFCP));
      end;
      if En.TemST then
      begin
        VlrToCmp('modBCST_N18', IntToStr(Ord(En.ModBCST)));
        if En.PMVAST   > 0 then VlrToCmp('pMVAST_N19'  , ToStr2(En.PMVAST));
        if En.PRedBCST > 0 then VlrToCmp('pRedBCST_N20', ToStr2(En.PRedBCST));
        VlrToCmp('vBCST_N21'  , ToStr2(It.vBCST));
        VlrToCmp('pICMSST_N22', ToStr2(En.PICMSST));
        VlrToCmp('vICMSST_N23', ToStr2(It.vICMSST));
        if It.vFCPST > 0 then
        begin
           VlrToCmp('pFCPST_N26', ToStr2(En.PFCPST));
           VlrToCmp('vFCPST_N27', ToStr2(It.vFCPST));
        end;
      end;
      if It.vICMSDeson > 0 then
      begin
         VlrToCmp('vICMSDeson_N28a', ToStr2(It.vICMSDeson));
         VlrToCmp('motDesICMS_N28', IntToStr(En.MotDeson));
         end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end; // with
end;

// ===== CSOSN (SN) =====
class procedure TTecnoSpeed.ICMSSN101(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11'   , En.Orig.ToString);
      VlrToCmp('CSOSN_N12a' , '101');
      VlrToCmp('pCredSN_N29', ToStr2(En.PICMS));
      VlrToCmp('vCredICMSSN_N30', ToStr2(It.vICMS));
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end; // with
end;

class procedure TTecnoSpeed.PIS_COFINS(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
     // PIS (grupo Q)
     if En.VAliqPIS > 0 then
     begin
       VlrToCmp('qBCProd_Q10'  , ToStr2(En.Qtd));
       VlrToCmp('vAliqProd_Q11', ToStr2(iif(It.vPIS > 0.00, En.VAliqPIS, 0.00)));
       VlrToCmp('vPIS_Q09'     , ToStr2(It.vPIS));
     end else
     begin
       VlrToCmp('vBC_Q07' , ToStr2(It.vBCPIS));
       VlrToCmp('pPIS_Q08', ToStr2(iif(It.vPIS > 0.00, En.PPIS, 0.00)));
       VlrToCmp('vPIS_Q09', ToStr2(It.vPIS));
     end;

     // COFINS (grupo S)
     if (En.VAliqCOFINS > 0) then
     begin
       VlrToCmp('qBCProd_S09'  , ToStr2(En.Qtd));
       VlrToCmp('vAliqProd_S10', ToStr2(iif(It.vCOFINS > 0.00, En.VAliqCOFINS, 0.00)));
       VlrToCmp('vCOFINS_S11'  , ToStr2(It.vCOFINS));
     end else
     begin
       VlrToCmp('vBC_S07'    , ToStr2(It.vBCCOFINS));
       VlrToCmp('pCOFINS_S08', ToStr2(iif(It.vCOFINS > 0.00, En.PCOFINS, 0.00)));
       VlrToCmp('vCOFINS_S11', ToStr2(It.vCOFINS));
     end;
   end; // with
end;

class procedure TTecnoSpeed.ICMSSN102_103_300_400(spDataSet:TspdNFeDataSets; const CSOSN: TCSOSN; const En: TItemEntrada);
var
   Code: string;
begin
   with spDataSet do
   begin
      case CSOSN of
        TCSOSN.sn102: Code := '102';
        TCSOSN.sn103: Code := '103';
        TCSOSN.sn300: Code := '300';
        TCSOSN.sn400: Code := '400';
      else
        Code := '102';
      end;
      VlrToCmp('orig_N11'  , En.Orig.ToString);
      VlrToCmp('CSOSN_N12a', Code);
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMSSN201(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11'   , En.Orig.ToString);
      VlrToCmp('CSOSN_N12a' , '201');
      VlrToCmp('modBCST_N18', IntToStr(Ord(En.ModBCST)));
      if En.PMVAST   > 0 then VlrToCmp('pMVAST_N19'  , ToStr2(En.PMVAST));
      if En.PRedBCST > 0 then VlrToCmp('pRedBCST_N20', ToStr2(En.PRedBCST));
      VlrToCmp('vBCST_N21'  , ToStr2(It.vBCST));
      VlrToCmp('pICMSST_N22', ToStr2(En.PICMSST));
      VlrToCmp('vICMSST_N23', ToStr2(It.vICMSST));
      if It.vFCPST > 0 then
      begin
         VlrToCmp('pFCPST_N26', ToStr2(En.PFCPST));
         VlrToCmp('vFCPST_N27', ToStr2(It.vFCPST));
      end;
      VlrToCmp('pCredSN_N29'    , ToStr2(En.PICMS));
      VlrToCmp('vCredICMSSN_N30', ToStr2(It.vICMS));
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMSSN202_203(spDataSet:TspdNFeDataSets; const CSOSN: TCSOSN; const En: TItemEntrada; const It: TItemImpostos);
var
  Code: string;
begin
   with spDataSet do
   begin
      case CSOSN of
        TCSOSN.sn202: Code := '202';
        TCSOSN.sn203: Code := '203';
      else
        Code := '202';
      end;
      VlrToCmp('orig_N11'   , En.Orig.ToString);
      VlrToCmp('CSOSN_N12a' , Code);
      VlrToCmp('modBCST_N18', IntToStr(Ord(En.ModBCST)));
      if En.PMVAST   > 0 then VlrToCmp('pMVAST_N19'  , ToStr2(En.PMVAST));
      if En.PRedBCST > 0 then VlrToCmp('pRedBCST_N20', ToStr2(En.PRedBCST));
      VlrToCmp('vBCST_N21'  , ToStr2(It.vBCST));
      VlrToCmp('pICMSST_N22', ToStr2(En.PICMSST));
      VlrToCmp('vICMSST_N23', ToStr2(It.vICMSST));
      if It.vFCPST > 0 then
      begin
         VlrToCmp('pFCPST_N26', ToStr2(En.PFCPST));
         VlrToCmp('vFCPST_N27', ToStr2(It.vFCPST));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMSSN500(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11'   , En.Orig.ToString);
      VlrToCmp('CSOSN_N12a' , '500');
      //VlrToCmp('vBCSTRet_N26'  , ToStr2(It.vBCST));
      //VlrToCmp('vICMSSTRet_N27', ToStr2(It.vICMSST));
      //if It.vFCPST > 0 then
      //begin
      //   VlrToCmp('pFCPSTRet_N26a', ToStr2(En.PFCPST));
      //    VlrToCmp('vFCPSTRet_N26b', ToStr2(It.vFCPST));
      // end;
      //if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end;
end;

class procedure TTecnoSpeed.ICMSSN900(spDataSet:TspdNFeDataSets; const En: TItemEntrada; const It: TItemImpostos);
begin
   with spDataSet do
   begin
      VlrToCmp('orig_N11'  , En.Orig.ToString);
      VlrToCmp('CSOSN_N12a', '900');
      if It.vBC > 0 then
      begin
         VlrToCmp('modBC_N13', Ord(En.ModBC).ToString);
         if En.PRedBC > 0 then VlrToCmp('pRedBC_N14', ToStr2(En.PRedBC));
         VlrToCmp('vBC_N15'  , ToStr2(It.vBC));
         VlrToCmp('pICMS_N16', ToStr2(En.PICMS));
         VlrToCmp('vICMS_N17', ToStr2(It.vICMS));
         if It.vFCP > 0 then
         begin
            VlrToCmp('pFCP_N17a', ToStr2(En.PFCP));
            VlrToCmp('vFCP_N17b', ToStr2(It.vFCP));
         end;
      end;
      if En.TemST then
      begin
         VlrToCmp('modBCST_N18', IntToStr(Ord(En.ModBCST)));
         if En.PMVAST   > 0 then VlrToCmp('pMVAST_N19'  , ToStr2(En.PMVAST));
         if En.PRedBCST > 0 then VlrToCmp('pRedBCST_N20', ToStr2(En.PRedBCST));
         VlrToCmp('vBCST_N21'  , ToStr2(It.vBCST));
         VlrToCmp('pICMSST_N22', ToStr2(En.PICMSST));
         VlrToCmp('vICMSST_N23', ToStr2(It.vICMSST));
         if It.vFCPST > 0 then
         begin
            VlrToCmp('pFCPST_N26', ToStr2(En.PFCPST));
            VlrToCmp('vFCPST_N27', ToStr2(It.vFCPST));
         end;
      end;
      if (En.PICMS > 0) and (It.vICMS > 0) then
      begin
         VlrToCmp('pCredSN_N29'    , ToStr2(En.PICMS));
         VlrToCmp('vCredICMSSN_N30', ToStr2(It.vICMS));
      end;
      if It.vICMSDeson > 0 then
      begin
         VlrToCmp('vICMSDeson_N28a', ToStr2(It.vICMSDeson));
         VlrToCmp('motDesICMS_N28' , IntToStr(En.MotDeson));
      end;
      if En.cBenef <> '' then VlrToCmp('cBenef', En.cBenef);
   end; //with
end;

class procedure TTecnoSpeed.Totals(spDataSet:TspdNFeDataSets; const Tot: TTotaisNota; const SomaSTnoVNF: Boolean);
var
   vNFCalc: Double;
begin
   // ICMSTot (W03..W16)
   with spDataSet do
   begin
      VlrToCmp('vBC_W03'       , ToStr2(Tot.vBC));
      VlrToCmp('vICMS_W04'     , ToStr2(Tot.vICMS));
      VlrToCmp('vFCP_W04h'     , ToStr2(Tot.vFCP));
      VlrToCmp('vBCST_W05'     , ToStr2(Tot.vBCST));
      VlrToCmp('vST_W06'       , ToStr2(Tot.vST));
      VlrToCmp('vFCPST_W06a'   , ToStr2(Tot.vFCPST));
      VlrToCmp('vProd_W07'     , ToStr2(Tot.vProd));
      VlrToCmp('vFrete_W08'    , ToStr2(Tot.vFrete));
      VlrToCmp('vSeg_W09'      , ToStr2(Tot.vSeg));
      VlrToCmp('vDesc_W10'     , ToStr2(Tot.vDesc));
      VlrToCmp('vOutro_W15'    , ToStr2(Tot.vOutro));
      VlrToCmp('vPIS_W13'      , ToStr2(Tot.vPIS));
      VlrToCmp('vCOFINS_W14'   , ToStr2(Tot.vCOFINS));
      VlrToCmp('vICMSDeson_W04a',ToStr2(Tot.vICMSDeson));
      VlrToCmp('vTotTrib_W16a'  ,ToStr2(Tot.vAproxImp));
      vNFCalc := Tot.vNF;
      if SomaSTnoVNF then vNFCalc := Round2(vNFCalc + Tot.vST);
      VlrToCmp('vNF_W16', ToStr2(vNFCalc));

      VlrToCmp('vFCPSTRet_W06b', '0.00');  // Total do FCP retido Anteriormente por ST
      VlrToCmp('vII_W11'       , '0.00');  // Totais ISSQN
      VlrToCmp('vIPI_W12'      , '0.00');  // Valor Total do IPI
      VlrToCmp('vIPIDevol_W12a', '0.00');  // Total do IPI Devolvido

      // DIFAL totais (W04e..W04g)
      if Tot.vICMSUFDest  > 0.00 then VlrToCmp('vICMSUFDest_W04e', ToStr2(Tot.vICMSUFDest));
      if Tot.vICMSUFRemet > 0.00 then VlrToCmp('vICMSUFRemet_W04f',ToStr2(Tot.vICMSUFRemet));
      if Tot.vFCPUFDest   > 0.00 then VlrToCmp('vFCPUFDest_W04g' , ToStr2(Tot.vFCPUFDest));
   end; //with
end;

function GetICMSCST(const Code:String):TICMSCST;
var
  n: Integer;
begin
  n := StrToIntDef(Code, Low(Integer));
  case n of
    0:  Result := TICMSCST.icms00;
    10: Result := TICMSCST.icms10;
    20: Result := TICMSCST.icms20;
    30: Result := TICMSCST.icms30;
    40: Result := TICMSCST.icms40;
    41: Result := TICMSCST.icms41;
    50: Result := TICMSCST.icms50;
    51: Result := TICMSCST.icms51;
    60: Result := TICMSCST.icms60;
    70: Result := TICMSCST.icms70;
    90: Result := TICMSCST.icms90;
  end;
end;

function GetCSOSN(const Code: string):TCSOSN;
var
  n: Integer;
begin
  n := StrToIntDef(Code, Low(Integer));
  case n of
    101: Result := TCSOSN.sn101;
    102: Result := TCSOSN.sn102;
    103: Result := TCSOSN.sn103;
    201: Result := TCSOSN.sn201;
    202: Result := TCSOSN.sn202;
    203: Result := TCSOSN.sn203;
    300: Result := TCSOSN.sn300;
    400: Result := TCSOSN.sn400;
    500: Result := TCSOSN.sn500;
    900: Result := TCSOSN.sn900;
  end;
end;

function GetPISCST(const Code: string):TPISCST;
var
  n: Integer;
begin
  n := StrToIntDef(Code, Low(Integer));
  case n of
     1: Result := TPISCST.pis01;
     2: Result := TPISCST.pis02;
     3: Result := TPISCST.pis03;
     4: Result := TPISCST.pis04;
     5: Result := TPISCST.pis05;
     6: Result := TPISCST.pis06;
     7: Result := TPISCST.pis07;
     8: Result := TPISCST.pis08;
     9: Result := TPISCST.pis09;
    49: Result := TPISCST.pis49;
    50: Result := TPISCST.pis50;
    51: Result := TPISCST.pis51;
    52: Result := TPISCST.pis52;
    53: Result := TPISCST.pis53;
    54: Result := TPISCST.pis54;
    55: Result := TPISCST.pis55;
    56: Result := TPISCST.pis56;
    60: Result := TPISCST.pis60;
    61: Result := TPISCST.pis61;
    62: Result := TPISCST.pis62;
    63: Result := TPISCST.pis63;
    64: Result := TPISCST.pis64;
    65: Result := TPISCST.pis65;
    66: Result := TPISCST.pis66;
    67: Result := TPISCST.pis67;
    70: Result := TPISCST.pis70;
    71: Result := TPISCST.pis71;
    72: Result := TPISCST.pis72;
    73: Result := TPISCST.pis73;
    74: Result := TPISCST.pis74;
    75: Result := TPISCST.pis75;
    98: Result := TPISCST.pis98;
    99: Result := TPISCST.pis99;
  end;
end;

function GetCOFINSCST(const Code: string):TCOFINSCST;
var
  n: Integer;
begin
  n := StrToIntDef(Code, Low(Integer));
  case n of
     1: Result := TCOFINSCST.cof01;
     2: Result := TCOFINSCST.cof02;
     3: Result := TCOFINSCST.cof03;
     4: Result := TCOFINSCST.cof04;
     5: Result := TCOFINSCST.cof05;
     6: Result := TCOFINSCST.cof06;
     7: Result := TCOFINSCST.cof07;
     8: Result := TCOFINSCST.cof08;
     9: Result := TCOFINSCST.cof09;
    49: Result := TCOFINSCST.cof49;
    50: Result := TCOFINSCST.cof50;
    51: Result := TCOFINSCST.cof51;
    52: Result := TCOFINSCST.cof52;
    53: Result := TCOFINSCST.cof53;
    54: Result := TCOFINSCST.cof54;
    55: Result := TCOFINSCST.cof55;
    56: Result := TCOFINSCST.cof56;
    60: Result := TCOFINSCST.cof60;
    61: Result := TCOFINSCST.cof61;
    62: Result := TCOFINSCST.cof62;
    63: Result := TCOFINSCST.cof63;
    64: Result := TCOFINSCST.cof64;
    65: Result := TCOFINSCST.cof65;
    66: Result := TCOFINSCST.cof66;
    67: Result := TCOFINSCST.cof67;
    70: Result := TCOFINSCST.cof70;
    71: Result := TCOFINSCST.cof71;
    72: Result := TCOFINSCST.cof72;
    73: Result := TCOFINSCST.cof73;
    74: Result := TCOFINSCST.cof74;
    75: Result := TCOFINSCST.cof75;
    98: Result := TCOFINSCST.cof98;
    99: Result := TCOFINSCST.cof99;
  end;
end;

end.
