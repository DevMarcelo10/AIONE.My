unit uConst;

interface

type

  TArqConvenio = record
    IDConv: Integer;
    Nomcon: String;
    IndVenVis:    Boolean; // Permite venda a vista
    IndVenPra:    Boolean; // Permite venda a prazo
    IndDesProg:   Boolean; // Permite desconto progressivo
    IndPreProm:   Boolean; // Permite preços promocionais
    IndDesVenVis: Boolean; // Permite desconto a vista
    IndDesVenPra: Boolean; // Permite desconto a prazo
    NroMaxPar: Integer;    // Número Máximo de Parcelas Permitido
    LimCreCli: Currency;   // Limite de Crédito Para Cleintes em R$
    DiaVence: Integer;     // Dia do Mês P/ Pagamento do Convênio (ESSE SERÁ A DATA DE VENCIMENTO DE TODA COMPRA A PRAZO DOS CLIENTES ASSOCIADOS A ESSE CONVENIO)
    DiaFecha: Integer;     // Dia do Mês P/ Fechamento do Convênio (ESSA É A DATA DO FECHAMENTO QUE FAZ A VIRADA DOS PROXIMOS VENCIMENTOS)
  end;

  TEmpresa = record
    CNPJ      : String;   // CNPJ da Farmácia (FILIAL)
    RAZAO     : String;   // Razão Social da Farmácia
    INSEST    : String;
    ENDERECO  : String;
    NROEND    : String;
    COMPEND   : String;
    BAIRRO    : String;
    CODMUN    : String;
    CIDADE    : String;
    UF        : String;
    CEP       : String;
  end;

  TArqPedidoIte = record
    IDFilial: Integer;     // ID da Filial da Farmácia
    IDPed: Integer;        // ID do Pedido de Vendas
    Nroite: SmallInt;      // Número Item (AutoInc via trigger)
    IDProd: Integer;       // ID do Produto
    Nrolot: string;        // Número do Lote do Produto
    IDVend: Integer;       // ID do Vendedor do Item
    IndComi: Integer;      // Incide comissão Default(1) Sim
    PrecoVen: Currency;    // Preço de Venda tabela na data da venda
    PrecoPMC: Currency;    // Preço Máximo ao Consumidor na data da venda
    PrecoFP: Currency;     // Preço Fármacia Popular na data da venda
    PrecoFab: Currency;    // Preço unitário de Fábrica na data da venda
    CustoMed: Currency;    // Custo Médio na Data da Venda
    VlrPIS: Currency;      // Valor do PIS
    VlrCOF: Currency;      // Valor do COFINS
    Qtdped: Currency;      // Quantidade vendida
    PerDesc: Currency;     // Percentual do Desconto
    VlrDesc: Currency;     // Valor unitário do Desconto
    VlrVenda: Currency;    // Valor unitário da venda do Item (com desconto)
    IndConf: Char;         // Indicador se Conferido pelo Caixa ('0' = Não / '1' = Sim)
    UsoRece: String;       // Uso da Receita: AM;C1;C2;C3;C4;C5A1;A2;A3B1;B2',

    Despro: string;        // Descrição do Produto
    IDFabr: Integer;       // Código do Fabricante
  	 Nomefab: string;       // Nome Fabricante (tabela arqpessoa)
    EstTotal: Currency;    // Estoque Total
    PrecoUni: Currency;    // Igual "PrecoVen", mas não é alterado, fica como referência

    IndBloDes: Boolean;          // "Bloquear descontos” ('0' = Não /'1' = Sim) Produto não pode conceder desconto Máximo digitado,definido Grupo/Subgrupo
    IDGrupo  : Integer;          // Grupo do Produto
    Desgru   : String;           // Descrição do Grupo
    GrupoDescMax: Currency;      // Percentual de desconto máximo
    GrupoPerDescPrazo: Boolean;  // Indica se permite descontos à prazo (0=Não/1=Sim)
    IDGruSub : Integer;          // SubGrupo do Produto
    DesgruSub: String;           // Descrição do SubGrupo
    GruSubDescMax: Currency;     // Percentual de desconto máximo
    GruSubPerDescPrazo: Boolean; // Indica se permite descontos à prazo (0=Não/1=Sim)
    DesSubs: String;             // Substâncias/Molêculas
    Desloc: String;              // Local do Estoque
    DescMaxCalc: Currency;       // (Calculado sobre GrupoDescMax e GruSubDescMax) Desconto permitido manualmente de acordo com a regra

    IDProm: Integer;       // ID da promoção ativa e selecionada, caso seleção seja compatível (Cliente, Convênio e Produto)
    IDDesc: Integer;       // ID do desconto ativo e selecionado
    FormFpgCod: String;    // Códigos das Formas de Pagto Aceitas para a Promoção ou Desconto
  end;

  TNFSalvar = record
    Tabela : String;   // Tabela à salvar os dados da Nota  (ex. arqpedido)
    CmpKey : String;   // Nome do campo chave da Tabela (ex. IDPed)
    CmpDad : String;   // Dados à ser atribuido à CmpDat
    IDCFOP : String;   // ID do CFOP da Nota Fiscal
    Status : String;   // Status do registro (ex. se é um pedido de vendas, seria o Status do Pedido)
    CodRet : String;   // Código de Retorno do SEFAZ
    NroPro : String;   // Protocolo do SEFAZ
    NroNF  : String;   // Número da Nota Fiscal
    Chave  : String;   // Chave da Nota Fiscal
    DatEmi : String;   // Data de Emissão da Nota
    Modelo : String;   // Modelo da nota (55 / 65)
  end;

var
   DataServer:TDateTime;
   USUARIO:String    = 'Parceiro';
   IDUSU:Integer     = 1;
   LINPROMPT:String  = '';
   PRINTERNF:String  = '';
   PathExe  :String  = '';
   PastaLog :String  = '';
   PodeFechar: Boolean = True;

   BaseRowHeight:Integer    = 21;
   BaseFormZoom:Integer     = 100;
   GlobalScaleFactor:Double = 1;

   _PrecoVen: Double  = 0.00;
   _MarkupGru: Double = 0.00;
   _MarkupSub: Double = 0.00;
   _Fracao: Double    = 0.00;
   _PerRedCBS: Double = 0.00;
   _PerRedIBS: Double = 0.00;
   _CodConta:String   = '';
   _IDConta:Integer   = 0;
   _DESPRO:String     = '';
   _NOMFAB:String     = '';

   EMPRESA:TEmpresa;
   FILIAL: Integer;  // Código da Filial;

   IPRemoto:String = '';
   PortaRemoto: Integer = 8093;
   IPLocal:String = 'localhost';
   PortaLocal: Integer  = 0;

// Abertas as portas 8092, 8093, 3306, 3307, 9090

const
   DWPass = '';
   DWPort = '';
   DWUser = 'restuser';
   IPAIONE     = 'ns1.aione.com.br'; //'162.215.175.59'; //ns1.aione.com.br
   ER_DUP_KEY  = 1062;
   ChaveCripto = 'PXa1e4ww45hqJc232D';
   OriginalRowHeight = 21;
   clGradientStart = $00F0E6E8;  // Rosa claro (topo)
   clGradientEnd   = $00A8C4E8;  // Pêssego/laranja claro (base)

implementation

end.
