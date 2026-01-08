unit uImpostosRT;
(*
   IBS = IMPOSTO SOBRE BENS E SERVIÇOS
   CBS = CONTRIBUIÇÃO SOBRE BENS E SERVIÇOS
   FORMULA DA BASE DE CALCULO IBS E CBS
   VBC = vProd + vServ + vFrete + vSeg + vOutro + vII(imposto de importação) - vDesc - vPIS - vCofins - vICMS - vICMSUFDest - vFCP - vFCPUFDest - vICMSMono - vISSQN + vIS(imposto seletivo)
   As Operações abaixo quem define é o cclasstrib, ele que diz se vai ter o ou nao credito presumido e etc...
   //--------------------------------------
   FORMULA DA ALIQUOTA EFETIVA ESTADUAL
   pAliquEfet = pIBSUF * (1-pRedAliq) * (1-pRedutor)
   obs1: pRedAliqu é a liquota de redução para o IBS Estadual
   obs2: pRedutor é a aliquota de redução caso ocorra compra governamental
   (no rio grande do sul tem a tabela da classtrib dependendo do classtrib pode ter ou nao redução de aliquota)
   //--------------------------------------------
   FORMULA PARA CALCULAR O DIFERIMENTO ESTADUAL
   vDif = vBC * pIBSUF * pDif
   obs: pDif é a aliquota de Diferimento para o IBS Estadual
   //-------------------------------------------------
   FORMULA PARA CALCULAR O CRÉDITO PRESUMIDO IBS
   vCredPres = vBC - pCredPres
   //------------------------------------------------
   FORMULA PARA O IBS ESTADUAL
   vIBSUF = (vBC * pAliqEfet) - vDif - vDecTrib - vCredPres
   obs: vDevTrib é o valor do tributo devolvido ("Cashback" de desconto na fatura)
   //----------------------------------------------------
   FORMULA PARA O IBS MUNICIPAL
   vIBSMun = (vBC * pAliqEfet) - vDif - vDevTrib - vCredPres
   obs1: os calculos para o pAliquEfe, vDif e vCredPres do IBS Municpal sao exatamente os mesmos do IBS Estadual, respeitando suas aliquotas que são diferentes.
   obs2: Só os calculos que são os mesmos e nao os valores e aliquotas, pois estes sao diferentes.
   //-----------------------------------------------------
   FORMULA PARA CALCULAR O CBS
   vCBS = (vBC * pAliqEfet) - vDif - vDevTrib - vCredPres
   obs1: os calculos para o pAliquEfe, vDif e vCredPres do IBS Municpal sao exatamente os mesmos do IBS Estadual, respeitando suas aliquotas que são diferentes.
   //-----------------------------------------------------
   ALIQUOTAS DO IBSUF, IBSMUN E CBS
   Aliquotas para 2025/2026
   pIBSUF = 0,1%
   pIBSMun = 0,0%
   pCBS = 0,9%
   Em 2026, não haverá recolhimento financeiro efetivo do IBS e CBS, desde que as obrigações acessórias sejam cumpridas
*)
{
  Cálculos do novo sistema (IBS/CBS/IS) "por fora" para NF-e / NFC-e.
  Versão v4.2
  - Item único e LOTE (com desconto por item + desconto global rateado).
  - Abatimentos (%) em IBS_UF / IBS_Mun / CBS → alíquotas EFETIVAS e tags pAliqEfetReg*.
  - IS (Imposto Seletivo):
      * ad valorem: UB05 (vBCIS), UB06 (pIS), UB11 (vIS)
      * ad rem:     UB07 (pISEspec), UB09 (uTrib), UB10 (qTrib), UB11 (vIS)
    IS integra a base de IBS/CBS (gIBSCBS/vBC).
  - Sem ToDecimal (usa divisões /100.0).
}
interface
uses
  System.SysUtils, System.Math;

const
  CURRENCY_DECIMALS = 2; // casas decimais para valores monetários

type
  // Alíquotas em PERCENTUAL (ex.: 7,08 = 7,08%)
  TTribRates = record
    IBS_UF: Double;        // parcela estadual (UF) do IBS
    IBS_Mun: Double;       // parcela municipal do IBS (se devido)
    CBS: Double;           // CBS
    IS_Seletivo: Double;   // IS ad valorem (%) – usado quando ISAplicavel=True e não houver IS ad rem
  end;

  // Modalidade do IS (para preenchimento de UB**)
  TISTipo = (isNenhum, isAdValorem, isAdRem);

  // Parâmetros de uma VENDA por item (entrada do cálculo por item)
  TVendaParams = record
    Qtd: Double;                // quantidade vendida (padrão = 1.0)
    PrecoFinalUnit: Double;     // preço final por unidade (com tributos por fora). Se > 0, tem prioridade
    PrecoLiquidoUnit: Double;   // preço líquido por unidade (sem tributos)
    ISAplicavel: Boolean;       // se IS incide na operação
    ArredondarPorItem: Boolean; // True: arredonda por item; False: arredonda somente no total
    // Parâmetros opcionais de IS ad rem (quando aplicável)
    ISAdRem_Valor: Double;      // UB07 - pISEspec (valor específico por uTrib)
    ISAdRem_uTrib: string;      // UB09 - uTrib (ex.: 'UN', 'KG', 'L')
    ISAdRem_qTrib: Double;      // UB10 - qTrib (quantidade tributável TOTAL do item no cálculo por item)
    class function Make: TVendaParams; static;
  end;

  // Resultado consolidado por item (espelho para XML)
  TItemResultado = record
    // Por unidade
    LUnit: Double;              // Preço líquido por unidade
    BaseIBSCBSUnit: Double;     // Base IBS/CBS por unidade (LUnit + ISUnit quando ISAplicavel)
    ISUnit: Double;             // Valor do IS por unidade
    IBSUFUnit: Double;          // IBS (UF) por unidade
    IBSMunUnit: Double;         // IBS (Município) por unidade
    CBSUnit: Double;            // CBS por unidade
    TotalUnit: Double;          // Total por unidade (L + IS + IBSUF + IBSMun + CBS)

    // Totais (multiplicado por Qtd)
    LTotal: Double;
    BaseIBSCBSTotal: Double;
    ISTotal: Double;
    IBSUFTotal: Double;
    IBSMunTotal: Double;
    CBSTotal: Double;
    TotalNF: Double;            // vNF sugerido (somatório do item)

    // Espelho dos campos para o XML – IBS/CBS (por item)
    vProd: Double;              // = LTotal
    vBCIBSCBS: Double;          // = BaseIBSCBSTotal
    pAliqEfetRegIBSUF: Double;  // em % (EFETIVA)
    vTribRegIBSUF: Double;      // = IBSUFTotal
    pAliqEfetRegIBSMun: Double; // em % (EFETIVA)
    vTribRegIBSMun: Double;     // = IBSMunTotal
    pAliqEfetRegCBS: Double;    // em % (EFETIVA)
    vTribRegCBS: Double;        // = CBSTotal

    // Espelho dos campos para o XML – IS (UB**)
    ISTipo: TISTipo;            // isAdValorem / isAdRem / isNenhum
    vBCIS: Double;              // UB05 – base ad valorem (quando isAdValorem)
    pIS: Double;                // UB06 – alíquota ad valorem (%)
    pISEspec: Double;           // UB07 – alíquota específica (ad rem)
    uTribIS: string;            // UB09 – unidade tributável (ad rem)
    qTribIS: Double;            // UB10 – quantidade tributável (ad rem; total do item)
    vIS: Double;                // UB11 – valor do IS (sempre que houver IS)
    vNF: Double;                // = TotalNF

    // Débitos (saída)
    DebitoIBSUF: Double;
    DebitoIBSMun: Double;
    DebitoCBS: Double;
  end;

  // Entrada por item para processamento em lote
  TItemInputRT = record
    Id: string;   // identificador (SKU/seq)
    Qtd: Double;  // quantidade

    // Informe UM dos dois preços (o outro deixe 0):
    PrecoFinalUnit: Double;     // preço final por unidade (com tributos por fora)
    PrecoLiquidoUnit: Double;   // preço líquido por unidade

    // Desconto por ITEM – aplica sobre o TOTAL do item (após Qtd)
    // Prioridade: Valor >> Percentual
    DescItemValor: Double;      // valor absoluto a abater do total do item
    DescItemPercent: Double;    // percentual a abater do total do item (0..100)

    // ABATIMENTOS de alíquota (em % do abatimento) – por item
    AbatIBS_UF_Perc: Double;    // reduz % da alíquota IBS_UF nominal
    AbatIBSMun_Perc: Double;    // reduz % da alíquota IBS_Mun nominal
    AbatCBS_Perc: Double;       // reduz % da alíquota CBS nominal
    ISAplicavel: Boolean;       // se IS incide neste item
    ArredondarPorItem: Boolean; // True = arredonda por item; False = arredonda só no total

    // Parâmetros opcionais de IS ad rem (por UNIDADE)
    ISAdRem_Valor: Double;      // UB07 - pISEspec (valor específico por uTrib)
    ISAdRem_uTrib: string;      // UB09 - uTrib
    ISAdRem_qTribUnit: Double;  // UB10 - qTrib por UNIDADE (no lote multiplicarei por Qtd)
    Rates: TTribRates;          // IBS_UF / IBS_Mun / CBS / IS_Seletivo (em %)
    class function Make: TItemInputRT; static;
  end;

  // Saída por item (pós rateio do desconto global)
  TItemOutputRT = record
    Id: string;

    // Preços intermediários
    PF_Base: Double;            // total do item após desconto por item
    PF_Alocado: Double;         // parcela do desconto global alocada ao item
    PF_Final: Double;           // PF_Base - PF_Alocado (total efetivo do item)

    // Resultado tributário do item (campos TItemResultado – totais)
    LTotal: Double;
    BaseIBSCBSTotal: Double;
    ISTotal: Double;
    IBSUFTotal: Double;
    IBSMunTotal: Double;
    CBSTotal: Double;
    TotalNF: Double;            // vNF do item

    // Tags prontas para XML – IBS/CBS
    vProd: Double;
    vBCIBSCBS: Double;
    pAliqEfetRegIBSUF: Double;
    vTribRegIBSUF: Double;
    pAliqEfetRegIBSMun: Double;
    vTribRegIBSMun: Double;
    pAliqEfetRegCBS: Double;
    vTribRegCBS: Double;

    // Tags prontas para XML – IS (UB**)
    ISTipo: TISTipo;
    vBCIS: Double;              // UB05 (ad valorem)
    pIS: Double;                // UB06 (ad valorem)
    pISEspec: Double;           // UB07 (ad rem)
    uTribIS: string;            // UB09 (ad rem)
    qTribIS: Double;            // UB10 (ad rem)
    vIS: Double;                // UB11
    vNF: Double;                // Total do item
  end;

  // Totais da nota (resumo)
  TTotaisNotaRT = record
    SubtotalItens: Double;      // soma PF_Base (antes do rateio global)
    DescontoGlobal: Double;     // valor de desconto global recebido
    TotalItens: Double;         // soma dos vNF (PF_Base - rateio)
    TotalIS: Double;
    TotalIBSUF: Double;
    TotalIBSMun: Double;
    TotalCBS: Double;
    vBCIBSCBS: Double;
    vIBS: Double;
    vNFTot: Double;
end;

{ ---- PROTÓTIPOS FORA DO TYPE ---- }
// Helpers para alíquotas efetivas (aplica abatimentos)
function MakeRatesEfetivos(const Rates: TTribRates; const AbatIBS_UF, AbatIBSMun, AbatCBS: Double): TTribRates;

// Cálculo por ITEM (sem créditos de compra)
function CalcImpostosVenda(const Venda: TVendaParams; const RatesVenda: TTribRates; out R: TItemResultado): Boolean;

// Overload: aplica abatimentos (em %) e calcula com as alíquotas EFETIVAS
function CalcImpostosVendaEfetivo(const Venda: TVendaParams; const RatesNominais: TTribRates;
  const AbatIBS_UF, AbatIBSMun, AbatCBS: Double; out R: TItemResultado): Boolean;

// LOTE: itens + desconto global (rateio proporcional)
function CalcImpostosLoteRT(const Itens: TArray<TItemInputRT>; const DescontoGlobal: Double; out Resultados: TArray<TItemOutputRT>; out Totais: TTotaisNotaRT): Boolean;

implementation

// ---------- utilitários ---------- //
function RoundMoney(const V: Double): Double;
begin
  Result := SimpleRoundTo(V, -CURRENCY_DECIMALS);
end;

// ---------- construtores ---------- //
class function TVendaParams.Make: TVendaParams;
begin
  Result.Qtd := 1.0;
  Result.PrecoFinalUnit := 0.0;
  Result.PrecoLiquidoUnit := 0.0;
  Result.ISAplicavel := False;
  Result.ArredondarPorItem := True;
  // IS ad rem opcionais
  Result.ISAdRem_Valor := 0.0;
  Result.ISAdRem_uTrib := '';
  Result.ISAdRem_qTrib := 0.0;
end;

class function TItemInputRT.Make: TItemInputRT;
begin
  Result.Id := '';
  Result.Qtd := 1.0;
  Result.PrecoFinalUnit := 0.0;
  Result.PrecoLiquidoUnit := 0.0;
  Result.DescItemValor := 0.0;
  Result.DescItemPercent := 0.0;
  Result.AbatIBS_UF_Perc := 0.0;
  Result.AbatIBSMun_Perc := 0.0;
  Result.AbatCBS_Perc := 0.0;
  Result.ISAplicavel := False;
  Result.ArredondarPorItem := True;
  Result.Rates.IBS_UF := 0.0;
  Result.Rates.IBS_Mun := 0.0;
  Result.Rates.CBS := 0.0;
  Result.Rates.IS_Seletivo := 0.0;
  // IS ad rem por UNIDADE
  Result.ISAdRem_Valor := 0.0;
  Result.ISAdRem_uTrib := '';
  Result.ISAdRem_qTribUnit := 0.0;
end;

// ---------- Núcleo do cálculo (por item) ---------- //
function MakeRatesEfetivos(const Rates: TTribRates; const AbatIBS_UF, AbatIBSMun, AbatCBS: Double): TTribRates;
  function Reduz(Aliq, Abat: Double): Double; inline;
  var p: Double;
  begin
    if Abat <= 0 then Exit(Aliq);
    p := 1.0 - (Abat / 100.0);
    if p < 0 then p := 0;
    Result := Max(0.0, Aliq * p);
  end;
begin
  Result := Rates;
  Result.IBS_UF := Reduz(Rates.IBS_UF, AbatIBS_UF);
  Result.IBS_Mun := Reduz(Rates.IBS_Mun, AbatIBSMun);
  Result.CBS := Reduz(Rates.CBS, AbatCBS);
  // IS_Seletivo não recebe abatimento aqui (adicionar se houver política específica)
end;

function BackOutLiquidoFromFinal(const PrecoFinalUnit: Double; const Rates: TTribRates;
  const ISAplicavel: Boolean): Double;
var
  aIBS_UF, aIBS_Mun, aCBS, aIS, denom: Double;
begin
  aIBS_UF := Rates.IBS_UF / 100.0;
  aIBS_Mun := Rates.IBS_Mun / 100.0;
  aCBS := Rates.CBS / 100.0;
  aIS  := Rates.IS_Seletivo / 100.0;
  if ISAplicavel then
       denom := (1.0 + aIS) * (1.0 + aIBS_UF + aIBS_Mun + aCBS)
  else denom := (1.0 + aIBS_UF + aIBS_Mun + aCBS);
  if denom <= 0 then Exit(0.0);
  Result := PrecoFinalUnit / denom;
end;

function BackOutLiquidoFromFinalEx(const PF: Double; const Rates: TTribRates;
  const ISAplicavel: Boolean; const ISAdRem_Valor, ISAdRem_qTrib: Double): Double;
var
  aIBS_UF, aIBS_Mun, aCBS: Double;
  ISfixo: Double;
begin
  aIBS_UF := Rates.IBS_UF / 100.0;
  aIBS_Mun := Rates.IBS_Mun / 100.0;
  aCBS := Rates.CBS / 100.0;
  if ISAplicavel and (ISAdRem_Valor > 0) and (ISAdRem_qTrib > 0) then
  begin
    ISfixo := ISAdRem_Valor * ISAdRem_qTrib;
    Result := (PF - ISfixo) / (1.0 + aIBS_UF + aIBS_Mun + aCBS);
  end
  else Result := BackOutLiquidoFromFinal(PF, Rates, ISAplicavel);
end;

function CalcTotaisFromLiquido(const LUnit: Double; const Rates: TTribRates;
  const ISAplicavel: Boolean; const ISTipo: TISTipo; const ISAdRem_Valor, ISAdRem_qTrib: Double;
  out BaseIBSCBS, VIS, VIBSUF, VIBSMun, VCBS, VTotal: Double): Boolean;
var
  aIBS_UF, aIBS_Mun, aCBS, aIS: Double;
begin
  aIBS_UF  := Rates.IBS_UF / 100.0;
  aIBS_Mun := Rates.IBS_Mun / 100.0;
  aCBS := Rates.CBS / 100.0;
  aIS  := Rates.IS_Seletivo / 100.0;
  case ISTipo of
    isAdValorem:
      if ISAplicavel and (aIS > 0) then
           VIS := LUnit * aIS
      else VIS := 0.0;
    isAdRem:
      if ISAplicavel and (ISAdRem_Valor > 0) and (ISAdRem_qTrib > 0) then
           VIS := ISAdRem_Valor * ISAdRem_qTrib
      else VIS := 0.0;
  else VIS := 0.0;
  end;
  BaseIBSCBS := LUnit + VIS; // IS integra a base do IBS/CBS
  VIBSUF  := BaseIBSCBS * aIBS_UF;
  VIBSMun := BaseIBSCBS * aIBS_Mun;
  VCBS    := BaseIBSCBS * aCBS;
  VTotal := LUnit + VIS + VIBSUF + VIBSMun + VCBS;
  Result := True;
end;

function CalcImpostosVenda(const Venda: TVendaParams; const RatesVenda: TTribRates; out R: TItemResultado): Boolean;
var
  LUnit, BaseU, ISU, IBSUFU, IBSMunU, CBSU, TotU: Double;
  LTot, BaseT, IST, IBSUFT, IBSMunT, CBST, TotT: Double;
  Q: Double;
  ISTipo: TISTipo;

  procedure AplicaArredondamentoPorItem;
  begin
    // Arredonda por unidade e depois multiplica pela quantidade
    LTot    := RoundMoney(LUnit)    * Q;
    BaseT   := RoundMoney(BaseU)    * Q;
    IST     := RoundMoney(ISU)      * Q;
    IBSUFT  := RoundMoney(IBSUFU)   * Q;
    IBSMunT := RoundMoney(IBSMunU)  * Q;
    CBST    := RoundMoney(CBSU)     * Q;
    TotT    := RoundMoney(TotU)     * Q;
  end;

  procedure AplicaArredondamentoSomenteNoTotal;
  begin
    // Mantém precisão em unidade; arredonda somente após multiplicar
    LTot    := RoundMoney(LUnit * Q);
    BaseT   := RoundMoney(BaseU * Q);
    IST     := RoundMoney(ISU * Q);
    IBSUFT  := RoundMoney(IBSUFU * Q);
    IBSMunT := RoundMoney(IBSMunU * Q);
    CBST    := RoundMoney(CBSU * Q);
    TotT    := RoundMoney(TotU * Q);
  end;
begin
  Result := False;
  Q := Venda.Qtd;
  if Q <= 0 then Q := 1.0;

  // Determina modalidade do IS
  if not Venda.ISAplicavel then ISTipo := isNenhum
  else if (Venda.ISAdRem_Valor > 0) and (Venda.ISAdRem_qTrib > 0) then ISTipo := isAdRem
  else if RatesVenda.IS_Seletivo > 0 then ISTipo := isAdValorem
  else ISTipo := isNenhum;

  // Determina LUnit (líquido) a partir do preço informado
  if Venda.PrecoFinalUnit > 0 then
  begin
    if ISTipo = isAdRem then
         LUnit := BackOutLiquidoFromFinalEx(Venda.PrecoFinalUnit, RatesVenda, Venda.ISAplicavel,Venda.ISAdRem_Valor, Venda.ISAdRem_qTrib)
    else LUnit := BackOutLiquidoFromFinal(Venda.PrecoFinalUnit, RatesVenda, Venda.ISAplicavel);
  end
  else LUnit := Venda.PrecoLiquidoUnit;

  if LUnit < 0 then LUnit := 0.0;

  // Calcula componentes por unidade
  CalcTotaisFromLiquido(LUnit, RatesVenda, Venda.ISAplicavel, ISTipo,Venda.ISAdRem_Valor, Venda.ISAdRem_qTrib,BaseU, ISU, IBSUFU, IBSMunU, CBSU, TotU);

  // Totais com estratégia de arredondamento
  if Venda.ArredondarPorItem then
       AplicaArredondamentoPorItem
  else AplicaArredondamentoSomenteNoTotal;

  // Preenche resultado do item (saída) – por unidade e totais
  R.LUnit           := RoundMoney(LUnit);
  R.BaseIBSCBSUnit  := RoundMoney(BaseU);
  R.ISUnit          := RoundMoney(ISU);
  R.IBSUFUnit       := RoundMoney(IBSUFU);
  R.IBSMunUnit      := RoundMoney(IBSMunU);
  R.CBSUnit         := RoundMoney(CBSU);
  R.TotalUnit       := RoundMoney(TotU);
  R.LTotal          := LTot;
  R.BaseIBSCBSTotal := BaseT;
  R.ISTotal         := IST;
  R.IBSUFTotal      := IBSUFT;
  R.IBSMunTotal     := IBSMunT;
  R.CBSTotal        := CBST;
  R.TotalNF         := TotT;

  // Tags por item — IBS/CBS com ALÍQUOTAS EFETIVAS
  R.vProd              := LTot;
  R.vBCIBSCBS          := BaseT;
  R.pAliqEfetRegIBSUF  := RatesVenda.IBS_UF;
  R.vTribRegIBSUF      := IBSUFT;
  R.pAliqEfetRegIBSMun := RatesVenda.IBS_Mun;
  R.vTribRegIBSMun     := IBSMunT;
  R.pAliqEfetRegCBS    := RatesVenda.CBS;
  R.vTribRegCBS := CBST;

  // IS – preencher conforme modalidade
  R.ISTipo := ISTipo;
  case ISTipo of
    isAdValorem:
      begin
        R.vBCIS := LTot;                   // UB05 – base ad valorem
        R.pIS   := RatesVenda.IS_Seletivo; // UB06 – %
        R.pISEspec := 0;                   // UB07 n/a
        R.uTribIS  := '';                  // UB09 n/a
        R.qTribIS  := 0;                   // UB10 n/a
      end;
    isAdRem:
      begin
        R.vBCIS := 0;                      // UB05 n/a
        R.pIS   := 0;                      // UB06 n/a
        R.pISEspec := Venda.ISAdRem_Valor; // UB07
        R.uTribIS  := Venda.ISAdRem_uTrib; // UB09
        R.qTribIS  := Venda.ISAdRem_qTrib; // UB10 (total do item, já recebido no por-item)
      end;
  else
    R.vBCIS := 0; R.pIS := 0; R.pISEspec := 0; R.uTribIS := ''; R.qTribIS := 0;
  end;
  R.vIS := IST;   // UB11
  R.vNF := TotT;

  // Débitos (saída)
  R.DebitoIBSUF := IBSUFT;
  R.DebitoIBSMun := IBSMunT;
  R.DebitoCBS := CBST;
  Result := True;
end;

function CalcImpostosVendaEfetivo(const Venda: TVendaParams; const RatesNominais: TTribRates;
  const AbatIBS_UF, AbatIBSMun, AbatCBS: Double; out R: TItemResultado): Boolean;
var
   Eff: TTribRates;
begin
   Eff := MakeRatesEfetivos(RatesNominais, AbatIBS_UF, AbatIBSMun, AbatCBS);
   Result := CalcImpostosVenda(Venda, Eff, R);
end;

// ---------- Processamento em Lote ---------- //
// Aplica desconto por item (sobre o TOTAL do item: PF_unit * Qtd), priorizando valor absoluto
function AplicarDescontoItemTotal(const PFUnit: Double; const Qtd: Double; const DescValor, DescPercent: Double): Double;
var
  total, desc: Double;
begin
  total := PFUnit * Qtd;
  if DescValor > 0 then desc := DescValor
  else if DescPercent > 0 then desc := total * (DescPercent / 100.0)
  else desc := 0.0;
  if desc > total then desc := total; // evita negativo
  Result := RoundMoney(total - desc);
end;

// Rateia o desconto global proporcionalmente aos PF_base (2 casas, com correção de centavos)
procedure RatearDescontoGlobal(const PF_Bases: TArray<Double>; const DescontoGlobal: Double; out Rateio: TArray<Double>);
var
  n, i, j: Integer;
  soma, quota, somaArred, resto: Double;
  fracs: array of Double;
  idxMaior: Integer;
  maiorFrac: Double;
begin
  n := Length(PF_Bases);
  SetLength(Rateio, n);
  if (n = 0) or (DescontoGlobal <= 0) then Exit;
  soma := 0.0;
  for i := 0 to n - 1 do
    soma := soma + PF_Bases[i];
  if soma <= 0 then Exit;
  SetLength(fracs, n);
  somaArred := 0.0;

  for i := 0 to n - 1 do
  begin
    quota := DescontoGlobal * (PF_Bases[i] / soma);
    Rateio[i] := RoundMoney(quota);
    somaArred := somaArred + Rateio[i];
    // parte fracionária (em centavos) ANTES do arredondamento
    fracs[i] := Frac(quota * Power(10, CURRENCY_DECIMALS));
  end;

  resto := RoundMoney(DescontoGlobal - somaArred);

  // Ajusta nos itens com maior fração até fechar os centavos
  while Abs(resto) >= 0.01 do
  begin
    idxMaior := -1;
    maiorFrac := -1;
    for j := 0 to n - 1 do
      if fracs[j] > maiorFrac then
      begin
        maiorFrac := fracs[j];
        idxMaior := j;
      end;

    if idxMaior < 0 then Break;

    if resto > 0 then
    begin
      Rateio[idxMaior] := Rateio[idxMaior] + 0.01;
      resto := RoundMoney(resto - 0.01);
    end else
    begin
      if Rateio[idxMaior] >= 0.01 then
      begin
        Rateio[idxMaior] := Rateio[idxMaior] - 0.01; // (se quiser, troque por proteção adicional)
        resto := RoundMoney(resto + 0.01);
      end
      else fracs[idxMaior] := -1; // não dá para tirar deste; escolha o próximo
    end;

    fracs[idxMaior] := -1;  // invalida para não repetir sempre o mesmo
  end;
end;

function CalcImpostosLoteRT(const Itens: TArray<TItemInputRT>; const DescontoGlobal: Double;
         out Resultados: TArray<TItemOutputRT>; out Totais: TTotaisNotaRT): Boolean;
var
  n, i: Integer;
  PF_base_arr, rateio_arr: TArray<Double>;
  PF_unit_bruto, PF_base, descaloc, PF_final: Double;
  VP: TVendaParams;
  R: TItemResultado;
  ok: Boolean;
  Eff: TTribRates;
begin
  Result := False;
  n := Length(Itens);
  SetLength(Resultados, n);
  if n = 0 then
  begin
    Totais.SubtotalItens  := 0;
    Totais.DescontoGlobal := RoundMoney(DescontoGlobal);
    Totais.TotalItens     := 0;
    Totais.TotalIS        := 0;
    Totais.TotalIBSUF     := 0;
    Totais.TotalIBSMun    := 0;
    Totais.TotalCBS       := 0;
    Totais.vBCIBSCBS      := 0;
    Totais.vIBS           := 0;
    Totais.vNFTot         := 0;
    Exit(True);
  end;

  // Passo 1 – calcular PF_Base (após desconto por item)
  SetLength(PF_base_arr, n);
  Totais.SubtotalItens := 0;
  for i := 0 to n - 1 do
  begin
    // Alíquotas EFETIVAS (aplicando abatimentos do item)
    Eff := MakeRatesEfetivos(Itens[i].Rates, Itens[i].AbatIBS_UF_Perc, Itens[i].AbatIBSMun_Perc, Itens[i].AbatCBS_Perc);
    if Itens[i].PrecoFinalUnit > 0 then
      PF_unit_bruto := Itens[i].PrecoFinalUnit
    else
      // se vier líquido, estima PF unitário teórico com as ALÍQUOTAS EFETIVAS
      PF_unit_bruto := (Itens[i].PrecoLiquidoUnit) * (1 + (Eff.IS_Seletivo / 100.0) * Ord(Itens[i].ISAplicavel)) *
                       (1 + (Eff.IBS_UF + Eff.IBS_Mun + Eff.CBS) / 100.0);
    PF_base := AplicarDescontoItemTotal(PF_unit_bruto, Itens[i].Qtd, Itens[i].DescItemValor, Itens[i].DescItemPercent);
    PF_base_arr[i] := PF_base;
    Totais.SubtotalItens := Totais.SubtotalItens + PF_base;
  end;
  Totais.SubtotalItens := RoundMoney(Totais.SubtotalItens);

  // Passo 2 – ratear DescontoGlobal proporcionalmente
  RatearDescontoGlobal(PF_base_arr, RoundMoney(DescontoGlobal), rateio_arr);

  // Passo 3 – recalcular cada item com PF_final = PF_base - rateio
  Totais.TotalIS     := 0;
  Totais.TotalIBSUF  := 0;
  Totais.TotalIBSMun := 0;
  Totais.TotalCBS    := 0;
  Totais.TotalItens  := 0;

  for i := 0 to n - 1 do
  begin
    descaloc := 0.0;
    if (Length(rateio_arr) = n) then
      descaloc := rateio_arr[i];
    PF_final := RoundMoney(PF_base_arr[i] - descaloc);

    // Monta os parâmetros de venda para o cálculo final (consolidado por item)
    VP := TVendaParams.Make;
    VP.Qtd := 1; // PF_final já é total do item
    VP.PrecoFinalUnit := PF_final;
    VP.PrecoLiquidoUnit := 0.0;
    VP.ISAplicavel := Itens[i].ISAplicavel;
    VP.ArredondarPorItem := Itens[i].ArredondarPorItem;

    // IS ad rem total para o item: qTrib por unidade * quantidade
    VP.ISAdRem_Valor := Itens[i].ISAdRem_Valor;
    VP.ISAdRem_uTrib := Itens[i].ISAdRem_uTrib;
    VP.ISAdRem_qTrib := Itens[i].ISAdRem_qTribUnit * Itens[i].Qtd;

    // Usa as ALÍQUOTAS EFETIVAS
    Eff := MakeRatesEfetivos(Itens[i].Rates, Itens[i].AbatIBS_UF_Perc, Itens[i].AbatIBSMun_Perc, Itens[i].AbatCBS_Perc);
    ok := CalcImpostosVenda(VP, Eff, R);
    if not ok then Exit(False);

    // Output por item
    Resultados[i].Id := Itens[i].Id;
    Resultados[i].PF_Base := PF_base_arr[i];
    Resultados[i].PF_Alocado := descaloc;
    Resultados[i].PF_Final := PF_final;
    Resultados[i].LTotal := R.LTotal;
    Resultados[i].BaseIBSCBSTotal := R.BaseIBSCBSTotal;
    Resultados[i].ISTotal := R.ISTotal;
    Resultados[i].IBSUFTotal := R.IBSUFTotal;
    Resultados[i].IBSMunTotal := R.IBSMunTotal;
    Resultados[i].CBSTotal := R.CBSTotal;
    Resultados[i].TotalNF := R.TotalNF;
    Resultados[i].vProd := R.vProd;
    Resultados[i].vBCIBSCBS := R.vBCIBSCBS;
    Resultados[i].pAliqEfetRegIBSUF := R.pAliqEfetRegIBSUF;
    Resultados[i].vTribRegIBSUF := R.vTribRegIBSUF;
    Resultados[i].pAliqEfetRegIBSMun := R.pAliqEfetRegIBSMun;
    Resultados[i].vTribRegIBSMun := R.vTribRegIBSMun;
    Resultados[i].pAliqEfetRegCBS := R.pAliqEfetRegCBS;
    Resultados[i].vTribRegCBS := R.vTribRegCBS;

    // IS espelhado
    Resultados[i].ISTipo   := R.ISTipo;
    Resultados[i].vBCIS    := R.vBCIS;
    Resultados[i].pIS      := R.pIS;
    Resultados[i].pISEspec := R.pISEspec;
    Resultados[i].uTribIS  := R.uTribIS;
    Resultados[i].qTribIS  := R.qTribIS;
    Resultados[i].vIS      := R.vIS;
    Resultados[i].vNF      := R.vNF;

    // Totais da nota
    Totais.TotalIS     := Totais.TotalIS + R.ISTotal;
    Totais.TotalIBSUF  := Totais.TotalIBSUF + R.IBSUFTotal;
    Totais.TotalIBSMun := Totais.TotalIBSMun + R.IBSMunTotal;
    Totais.TotalCBS    := Totais.TotalCBS + R.CBSTotal;
    Totais.TotalItens  := Totais.TotalItens + R.TotalNF;
    Totais.vBCIBSCBS   := Totais.vBCIBSCBS + R.BaseIBSCBSTotal;
  end;

  Totais.DescontoGlobal := RoundMoney(DescontoGlobal);
  Totais.TotalIS        := RoundMoney(Totais.TotalIS);
  Totais.TotalIBSUF     := RoundMoney(Totais.TotalIBSUF);
  Totais.TotalIBSMun    := RoundMoney(Totais.TotalIBSMun);
  Totais.TotalCBS       := RoundMoney(Totais.TotalCBS);
  Totais.TotalItens     := RoundMoney(Totais.TotalItens);
  Totais.vBCIBSCBS      := RoundMoney(Totais.vBCIBSCBS);
  Totais.vIBS           := RoundMoney(Totais.TotalIBSUF + Totais.TotalIBSMun);
  Totais.vNFTot         := Totais.TotalItens; // vNF total da NF-e (já inclui IBS e CBS por item)
  Result := True;
end;

end.
