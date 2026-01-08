unit uConsultJSONParser;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Generics.Collections;

type
  TCabecalho = class
  public
    CNPJ: string;
    DT_TRANS: string;
    HR_TRANS: string;
    TP_ARQ: string;
  end;

  TResumo = class
  public
    TOTAL: string;
    CERTOS: string;
    AJUSTADO: string;
    ANALISECLIENTE: string;
    ANALISECONSULT: string;
  end;

  TCFOP = class
  public
    CFOP_EI: string;
    CFOP_SI: string;
    CFOP_EE: string;
    CFOP_SE: string;
  end;

  TCFOPItem = class
  public
    OP_INTERNO: TObjectList<TCFOP>;
    OP_INTESTADUAL: TObjectList<TCFOP>;
    constructor Create;
    destructor Destroy; override;
  end;

  TProduto = class
  public
    COD_BARRAS: string;
    COD_INTERNO: string;
    DESCRICAO: string;
    COD_NCM: string;
    CSTPIS_E: string;
    CSTPIS_S: string;
    CSTCOF_E: string;
    CSTCOF_S: string;
    ALIQ_PIS: string;
    ALIQ_COFINS: string;
    Aliq_IPI: string;
    ENQ_IPI: string;
    NATRECEITA: string;
    Aliq_ICMS: string;
    FEM_ICMS: string;
    TP_ALIQICMS: string;
    CST_CSOSN_S: string;
    CST_ICMS_E: string;
    CST_ICMS_S: string;
    CST_IPI: string;
    COD_CEST: string;
    TIP_MED: string;
    LISTA: string;
    MVA: string;
    ALIQREDICMS: string;
    pRED_ALIQICMS: string;
    COD_BENEF: string;
    MOD_BC: string;
    MOT_DES: string;
    pICMSST: string;
    PMvast: string;
    ALIQ_DESICMS: string;
    CFOP: TObjectList<TCFOPItem>;
    constructor Create;
    destructor Destroy; override;
  end;

  TErro = class
  public
    COD_INTERNO: string;
    DESCRICAO: string;
    MSGERR: string;
  end;

  TJSONResponse = class
  public
    CABECALHO: TObjectList<TCabecalho>;
    RESUMO: TObjectList<TResumo>;
    PRODUTO: TObjectList<TProduto>;
    ERRO: TObjectList<TErro>;
    constructor Create;
    destructor Destroy; override;
  end;

function ParseJSONResponse(const AJSONString: string): TJSONResponse;

implementation

{ TCFOPItem }

constructor TCFOPItem.Create;
begin
  OP_INTERNO := TObjectList<TCFOP>.Create;
  OP_INTESTADUAL := TObjectList<TCFOP>.Create;
end;

destructor TCFOPItem.Destroy;
begin
  OP_INTERNO.Free;
  OP_INTESTADUAL.Free;
  inherited;
end;

{ TProduto }

constructor TProduto.Create;
begin
  CFOP := TObjectList<TCFOPItem>.Create;
end;

destructor TProduto.Destroy;
begin
  CFOP.Free;
  inherited;
end;

{ TJSONResponse }

constructor TJSONResponse.Create;
begin
  CABECALHO := TObjectList<TCabecalho>.Create;
  RESUMO := TObjectList<TResumo>.Create;
  PRODUTO := TObjectList<TProduto>.Create;
  ERRO := TObjectList<TErro>.Create;
end;

destructor TJSONResponse.Destroy;
begin
  CABECALHO.Free;
  RESUMO.Free;
  PRODUTO.Free;
  ERRO.Free;
  inherited;
end;

function ParseJSONResponse(const AJSONString: string): TJSONResponse;
var
  LJSON: TJSONObject;
  LCabecalhoArray, LResumoArray, LProdutoArray, LErroArray: TJSONArray;
  LItem: TJSONValue;
  LResponse: TJSONResponse;

  function JSONValueToString(AValue: TJSONValue): string;
  begin
    if Assigned(AValue) then
      Result := AValue.Value
    else
      Result := '';
  end;

  function ParseCFOPItem(AJSONObject: TJSONObject): TCFOPItem;
  var
    LCFOPItem: TCFOPItem;
    LCFOPArray: TJSONArray;
    LCFOP: TCFOP;
    LItem: TJSONValue;
  begin
    LCFOPItem := TCFOPItem.Create;
    LCFOPArray := AJSONObject.GetValue<TJSONArray>('OP_INTERNO');
    if Assigned(LCFOPArray) then
    begin
      for LItem in LCFOPArray do
      begin
        LCFOP := TCFOP.Create;
        LCFOP.CFOP_EI := JSONValueToString(LItem.GetValue<TJSONValue>('CFOP_EI'));
        LCFOP.CFOP_SI := JSONValueToString(LItem.GetValue<TJSONValue>('CFOP_SI'));
        LCFOPItem.OP_INTERNO.Add(LCFOP);
      end;
    end;

    LCFOPArray := AJSONObject.GetValue<TJSONArray>('OP_INTESTADUAL');
    if Assigned(LCFOPArray) then
    begin
      for LItem in LCFOPArray do
      begin
        LCFOP := TCFOP.Create;
        LCFOP.CFOP_EE := JSONValueToString(LItem.GetValue<TJSONValue>('CFOP_EE'));
        LCFOP.CFOP_SE := JSONValueToString(LItem.GetValue<TJSONValue>('CFOP_SE'));
        LCFOPItem.OP_INTESTADUAL.Add(LCFOP);
      end;
    end;

    Result := LCFOPItem;
  end;

  procedure ParseCabecalho(AJSONArray: TJSONArray; AResponse: TJSONResponse);
  var
    LItem: TJSONValue;
    LCabecalho: TCabecalho;
  begin
    for LItem in AJSONArray do
    begin
      LCabecalho := TCabecalho.Create;
      LCabecalho.CNPJ := JSONValueToString(LItem.GetValue<TJSONValue>('CNPJ'));
      LCabecalho.DT_TRANS := JSONValueToString(LItem.GetValue<TJSONValue>('DT_TRANS'));
      LCabecalho.HR_TRANS := JSONValueToString(LItem.GetValue<TJSONValue>('HR_TRANS'));
      LCabecalho.TP_ARQ := JSONValueToString(LItem.GetValue<TJSONValue>('TP_ARQ'));
      AResponse.CABECALHO.Add(LCabecalho);
    end;
  end;

  procedure ParseResumo(AJSONArray: TJSONArray; AResponse: TJSONResponse);
  var
    LItem: TJSONValue;
    LResumo: TResumo;
  begin
    for LItem in AJSONArray do
    begin
      LResumo := TResumo.Create;
      LResumo.TOTAL := JSONValueToString(LItem.GetValue<TJSONValue>('TOTAL'));
      LResumo.CERTOS := JSONValueToString(LItem.GetValue<TJSONValue>('CERTOS'));
      LResumo.AJUSTADO := JSONValueToString(LItem.GetValue<TJSONValue>('AJUSTADO'));
      LResumo.ANALISECLIENTE := JSONValueToString(LItem.GetValue<TJSONValue>('ANALISECLIENTE'));
      LResumo.ANALISECONSULT := JSONValueToString(LItem.GetValue<TJSONValue>('ANALISECONSULT'));
      AResponse.RESUMO.Add(LResumo);
    end;
  end;

  procedure ParseProduto(AJSONArray: TJSONArray; AResponse: TJSONResponse);
  var
    LItem, LCFOPItem: TJSONValue;
    LProduto: TProduto;
  begin
    for LItem in AJSONArray do
    begin
      LProduto := TProduto.Create;
      LProduto.COD_BARRAS := JSONValueToString(LItem.GetValue<TJSONValue>('COD_BARRAS'));
      LProduto.COD_INTERNO := JSONValueToString(LItem.GetValue<TJSONValue>('COD_INTERNO'));
      LProduto.DESCRICAO := JSONValueToString(LItem.GetValue<TJSONValue>('DESCRICAO'));
      LProduto.COD_NCM := JSONValueToString(LItem.GetValue<TJSONValue>('COD_NCM'));
      LProduto.CSTPIS_E := JSONValueToString(LItem.GetValue<TJSONValue>('CSTPIS_E'));
      LProduto.CSTPIS_S := JSONValueToString(LItem.GetValue<TJSONValue>('CSTPIS_S'));
      LProduto.CSTCOF_E := JSONValueToString(LItem.GetValue<TJSONValue>('CSTCOF_E'));
      LProduto.CSTCOF_S := JSONValueToString(LItem.GetValue<TJSONValue>('CSTCOF_S'));
      LProduto.ALIQ_PIS := JSONValueToString(LItem.GetValue<TJSONValue>('ALIQ_PIS'));
      LProduto.ALIQ_COFINS := JSONValueToString(LItem.GetValue<TJSONValue>('ALIQ_COFINS'));
      LProduto.Aliq_IPI := JSONValueToString(LItem.GetValue<TJSONValue>('Aliq_IPI'));
      LProduto.ENQ_IPI := JSONValueToString(LItem.GetValue<TJSONValue>('ENQ_IPI'));
      LProduto.NATRECEITA := JSONValueToString(LItem.GetValue<TJSONValue>('NATRECEITA'));
      LProduto.Aliq_ICMS := JSONValueToString(LItem.GetValue<TJSONValue>('Aliq_ICMS'));
      LProduto.FEM_ICMS := JSONValueToString(LItem.GetValue<TJSONValue>('FEM_ICMS'));
      LProduto.TP_ALIQICMS := JSONValueToString(LItem.GetValue<TJSONValue>('TP_ALIQICMS'));
      LProduto.CST_CSOSN_S := JSONValueToString(LItem.GetValue<TJSONValue>('CST_CSOSN_S'));
      LProduto.CST_ICMS_E := JSONValueToString(LItem.GetValue<TJSONValue>('CST_ICMS_E'));
      LProduto.CST_ICMS_S := JSONValueToString(LItem.GetValue<TJSONValue>('CST_ICMS_S'));
      LProduto.CST_IPI := JSONValueToString(LItem.GetValue<TJSONValue>('CST_IPI'));
      LProduto.COD_CEST := JSONValueToString(LItem.GetValue<TJSONValue>('COD_CEST'));
      LProduto.TIP_MED := JSONValueToString(LItem.GetValue<TJSONValue>('TIP_MED'));
      LProduto.LISTA := JSONValueToString(LItem.GetValue<TJSONValue>('LISTA'));
      LProduto.MVA := JSONValueToString(LItem.GetValue<TJSONValue>('MVA'));
      LProduto.ALIQREDICMS := JSONValueToString(LItem.GetValue<TJSONValue>('ALIQREDICMS'));
      LProduto.pRED_ALIQICMS := JSONValueToString(LItem.GetValue<TJSONValue>('pRED_ALIQICMS'));
      LProduto.COD_BENEF := JSONValueToString(LItem.GetValue<TJSONValue>('COD_BENEF'));
      LProduto.MOD_BC := JSONValueToString(LItem.GetValue<TJSONValue>('MOD_BC'));
      LProduto.MOT_DES := JSONValueToString(LItem.GetValue<TJSONValue>('MOT_DES'));
      LProduto.pICMSST := JSONValueToString(LItem.GetValue<TJSONValue>('pICMSST'));
      LProduto.PMvast := JSONValueToString(LItem.GetValue<TJSONValue>('PMvast'));
      LProduto.ALIQ_DESICMS := JSONValueToString(LItem.GetValue<TJSONValue>('ALIQ_DESICMS'));

      for LCFOPItem in LItem.GetValue<TJSONArray>('CFOP') do
      begin
        LProduto.CFOP.Add(ParseCFOPItem(LCFOPItem as TJSONObject));
      end;

      AResponse.PRODUTO.Add(LProduto);
    end;
  end;

  procedure ParseErro(AJSONArray: TJSONArray; AResponse: TJSONResponse);
  var
    LItem: TJSONValue;
    LErro: TErro;
  begin
    for LItem in AJSONArray do
    begin
      LErro := TErro.Create;
      LErro.COD_INTERNO := JSONValueToString(LItem.GetValue<TJSONValue>('COD_INTERNO'));
      LErro.DESCRICAO := JSONValueToString(LItem.GetValue<TJSONValue>('DESCRICAO'));
      LErro.MSGERR := JSONValueToString(LItem.GetValue<TJSONValue>('MSGERR'));
      AResponse.ERRO.Add(LErro);
    end;
  end;

begin
  LResponse := TJSONResponse.Create;
  try
    LJSON := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
    try
      if LJSON.TryGetValue<TJSONArray>('CABECALHO', LCabecalhoArray) then
         if Assigned(LCabecalhoArray) then ParseCabecalho(LCabecalhoArray, LResponse);
      if LJSON.TryGetValue<TJSONArray>('RESUMO', LResumoArray) then
         if Assigned(LResumoArray) then ParseResumo(LResumoArray, LResponse);
      if LJSON.TryGetValue<TJSONArray>('PRODUTO', LProdutoArray) then
         if Assigned(LProdutoArray) then ParseProduto(LProdutoArray, LResponse);
      if LJSON.TryGetValue<TJSONArray>('ERRO', LErroArray) then
         if Assigned(LErroArray) then ParseErro(LErroArray, LResponse);
    finally
      LJSON.Free;
    end;
    Result := LResponse;
  except
    LResponse.Free;
    raise;
  end;
end;

end.

