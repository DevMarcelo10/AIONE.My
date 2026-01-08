unit uVendas;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
   LMDLabel, Vcl.StdCtrls,
   RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel,
   LMDCustomLabel, LMDCustomBevelPanel, Data.DB,
   Vcl.ExtCtrls, AdvGlowButton, MarcLib, AdvEdit, LMDEdit,
   Vcl.DBCtrls, FireDAC.Stan.Intf, Vcl.DBGrids,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uRESTDWBasicTypes, uRESTDWBasicDB,
   LMDMaskEdit,
   Vcl.Grids, Rtti, TypInfo, uDM, uConst, LMDActnList, System.Actions, Vcl.ActnList,
   System.Generics.Collections,
   uArqPedido, uRESTDWServerEvents, uTabDescProg, uTabPromProg,
   System.Math, uTabConfigRecCtl, LMDBackPanel, uReceitaBase, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
   TArqParametros = record
     CNPJFar: String;
     IDFilial: Integer;
     VenFecha: Integer;          // '0-Obrigatório / 1-Rápido - Fechamento da Venda'
     VenCesta: Integer;          // '0-Obrigatório / 1-Opcional - Nr. Cesta no Fechamento da Venda'
     VenProdExibComEst: Integer; // '0-Exibe todos os Produtos / 1-Exibe Apenas Produto com Estoque'
     VenProdBloqSemEst: Integer; // '0-Permite Venda de Produtos sem estoque / 1-Bloqueio de venda Produto sem estoque'
     VenCustoMed: Integer;       // '0-Permite / 1-Não permite - Venda com preço de venda abaixo do custo médio'
     VenFormaPagtoClienteObg: String; // 'Armazena Código das Formas de Pagto onde o Cliente é obrigatório na Venda';
   end;

   TFrmVendas = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    SouPedido: TDataSource;
    TabPedido: TRESTDWClientSQL;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    btBusca: TAdvGlowButton;
    btPend: TAdvGlowButton;
    PanelBase: TLMDSimplePanel;
    PanelRodape: TLMDSimplePanel;
    PanelButtons: TLMDSimplePanel;
    btNovo: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    PanelProd: TLMDSimplePanel;
    btOrcam: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    PanelItens: TLMDSimplePanel;
    PnaelBasMenus: TLMDSimplePanel;
    PanelPedAbe: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    edNompro: TLMDLabeledEdit;
    edQtdped: TLMDMaskEdit;
    LMDLabel3: TLMDLabel;
    edFabr: TLMDLabeledEdit;
    edVlrVenda: TLMDMaskEdit;
    LMDLabel6: TLMDLabel;
    LMDLabel1: TLMDLabel;
    LMDLabel4: TLMDLabel;
    edTotalpedIte: TLMDMaskEdit;
    btLimpaIte: TAdvGlowButton;
    btSalvaIte: TAdvGlowButton;
    edPerDesc: TLMDMaskEdit;
    edTotIte: TLMDMaskEdit;
    dbgItens: TDBGrid;
    TabPedIte: TRESTDWClientSQL;
    SouPedIte: TDataSource;
    TabPedidoIDFilial: TIntegerField;
    TabPedidoIDPed: TIntegerField;
    TabPedidoDatped: TDateTimeField;
    TabPedidoIDPess: TIntegerField;
    TabPedidoIDDesc: TIntegerField;
    TabPedidoIDConv: TIntegerField;
    TabPedidoTotDesc: TFloatField;
    TabPedidoTotPedido: TFloatField;
    TabPedidoStatus: TWideStringField;
    TabPedidoNomeCli: TWideStringField;
    TabPedIteIDFilial: TIntegerField;
    TabPedIteIDPed: TIntegerField;
    TabPedIteNroite: TSmallintField;
    TabPedIteIDProd: TIntegerField;
    TabPedIteNrolot: TWideStringField;
    TabPedIteIDVend: TIntegerField;
    TabPedIteIndComi: TBooleanField;
    TabPedItePrecoVen: TFloatField;
    TabPedItePrecoPMC: TFloatField;
    TabPedItePrecoFP: TFloatField;
    TabPedItePrecoFab: TFloatField;
    TabPedIteCustoMed: TFloatField;
    TabPedIteVlrPIS: TFloatField;
    TabPedIteVlrCOF: TFloatField;
    TabPedIteQtdped: TFloatField;
    TabPedIteVlrDesc: TFloatField;
    TabPedIteVlrVenda: TFloatField;
    TabPedIteDatHorAlt: TDateTimeField;
    TabPedIteDespro: TWideStringField;
    TabPedIteNomeFab: TWideStringField;
    TabPedIteTotItemCalc: TFloatField;
    TabPedItePerDesc: TFloatField;
    btPedido0: TAdvGlowButton;
    btPed3: TAdvGlowButton;
    edTotBruto: TLMDDBLabeledEdit;
    edTotDescontos: TLMDDBLabeledEdit;
    edTotPedido: TLMDDBLabeledEdit;
    btDevol: TAdvGlowButton;
    TabPedidoTotBruCalc: TFloatField;
    btDigRece: TAdvGlowButton;
    LMDLabel8: TLMDLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    Shape2: TShape;
    LMDDBLabeledEdit0: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    edClie: TLMDDBLabeledEdit;
    edConv: TLMDDBLabeledEdit;
    edPBM: TLMDDBLabeledEdit;
    TabPedidoNomPBM: TWideStringField;
    TabPedidoIDPBM: TIntegerField;
    TabPedIteUsoRece: TWideStringField;
    btServicos: TAdvGlowButton;
    TabPedidoNomcon: TWideStringField;
    TabPedidoIDVend: TIntegerField;
    TabPedidoIDEntre: TIntegerField;
    TabPedidoIDForPag: TSmallintField;
    TabPedidoIndEntr: TWideStringField;
    TabPedidoNomven: TWideStringField;
    edVend: TLMDDBLabeledEdit;
    TabPedidoNext: TRESTDWClientSQL;
    TabPedidoNextNext_IDPed: TLargeintField;
    LMDActionList1: TLMDActionList;
    acVendaBuscarConcluidas: TAction;
    acVendaBuscarPendentes: TAction;
    acVendaLimpar: TAction;
    acVendaNova: TAction;
    acVendaSalvar: TAction;
    acGridItemLimpa: TAction;
    acGridItemSalva: TAction;
    acGridItemExclui: TAction;
    acGridItemInsere: TAction;
    acGridItemAgendamento: TAction;
    acVendaDevolucao: TAction;
    AdvGlowButton1: TAdvGlowButton;
    acGridItemDesconto: TAction;
    acGridItemEstoque: TAction;
    acGridItemReceitas: TAction;
    LMDSimplePanel2: TLMDSimplePanel;
    edGrupo: TLMDDBLabeledEdit;
    edGrupoSub: TLMDDBLabeledEdit;
    edGrupoDescMax: TLMDDBLabeledEdit;
    TabPedIteEstTotal: TIntegerField;
    tabFormaPagto: TRESTDWClientSQL;
    tabFormaPagtoIDForPag: TSmallintField;
    tabFormaPagtoDesForPag: TWideStringField;
    tabFormaPagtoIndAtivo: TBooleanField;
    tabPedForPagto: TRESTDWClientSQL;
    tabPedForPagtoIDFilial: TIntegerField;
    tabPedForPagtoIDPed: TIntegerField;
    tabPedForPagtoNropag: TSmallintField;
    tabPedForPagtoIDForPag: TSmallintField;
    tabPedForPagtoIndPOS: TWideStringField;
    tabPedForPagtoIDCartao: TSmallintField;
    tabPedForPagtoNroNSU: TWideStringField;
    tabPedForPagtoTipcar: TWideStringField;
    tabPedForPagtoVlrPago: TFloatField;
    TabPedidoNroCesta: TWideStringField;
    edGrupoDescSubs: TLMDDBLabeledEdit;
    TabPedIteRec: TRESTDWClientSQL;
    TabArqPessoa: TRESTDWClientSQL;
    TabPedItePrecoUni: TFloatField;
    TabPedIteIDGrupo: TIntegerField;
    TabPedIteIDGruSub: TIntegerField;
    TabPedIteFormFpgCod: TWideStringField;
    TabPedIteCalcPromDesc: TIntegerField;
    TabPedidoTotPercDescCalc: TCurrencyField;
    TabPedIteIDProm: TIntegerField;
    TabPedIteIDDesc: TIntegerField;
    TabPedIteIDFabr: TIntegerField;
    edGrupoProdDesLoc: TLMDDBLabeledEdit;
    TabPedIteIndBloDes: TWideStringField;
    TabPedIteDesgru: TWideStringField;
    TabPedIteGrupoDescMax: TFloatField;
    TabPedIteDesgruSub: TWideStringField;
    TabPedIteGruSubDescMax: TFloatField;
    TabPedIteDesSubs: TWideStringField;
    TabPedIteDesloc: TWideStringField;
    TabPedIteDescMaxCalc: TFloatField;
    TabPedIteGrupoPerDescPrazo: TBooleanField;
    TabPedIteGruSubPerDescPrazo: TBooleanField;
    TabSngpcVen: TRESTDWClientSQL;
    TabPedIteLot: TRESTDWClientSQL;
    TabPedIteLotIDFilial: TIntegerField;
    TabPedIteLotIDPed: TIntegerField;
    TabPedIteLotNroite: TSmallintField;
    TabPedIteLotIDProd: TIntegerField;
    TabPedIteLotNrolot: TWideStringField;
    TabPedIteLotIDVend: TIntegerField;
    TabPedIteLotIndComi: TBooleanField;
    TabPedIteLotPrecoVen: TFloatField;
    TabPedIteLotPrecoPMC: TFloatField;
    TabPedIteLotPrecoFP: TFloatField;
    TabPedIteLotPrecoFab: TFloatField;
    TabPedIteLotCustoMed: TFloatField;
    TabPedIteLotVlrPIS: TFloatField;
    TabPedIteLotVlrCOF: TFloatField;
    TabPedIteLotQtdped: TFloatField;
    TabPedIteLotQtdConf: TFloatField;
    TabPedIteLotPerDesc: TFloatField;
    TabPedIteLotVlrDesc: TFloatField;
    TabPedIteLotVlrVenda: TFloatField;
    TabPedIteLotDatHorAlt: TDateTimeField;
    TabPedIteLotIDProm: TIntegerField;
    TabPedIteLotIDDesc: TIntegerField;
    TabProdutoLot: TRESTDWClientSQL;
    TabProdutoLotIDFilial: TIntegerField;
    TabProdutoLotIDProd: TIntegerField;
    TabProdutoLotNrolot: TWideStringField;
    TabProdutoLotIDPess: TIntegerField;
    TabProdutoLotcAgreg: TWideStringField;
    TabProdutoLotDatfab: TDateField;
    TabProdutoLotDatven: TDateField;
    TabProdutoLotQtdest: TFloatField;
    TabPedIteLotIDFabr: TIntegerField;
    TabSngpcVenIDFilial: TIntegerField;
    TabSngpcVenIDProd: TIntegerField;
    TabSngpcVenNrolot: TWideStringField;
    TabSngpcVenIDPess: TIntegerField;
    TabSngpcVenIDPed: TIntegerField;
    TabSngpcVenDatVenda: TDateField;
    TabSngpcVenDatpre: TDateField;
    TabSngpcVenDatven: TDateField;
    TabSngpcVenNroRece: TWideStringField;
    TabSngpcVenIDComp: TIntegerField;
    TabSngpcVenIDVend: TIntegerField;
    TabSngpcVenIDPres: TIntegerField;
    TabSngpcVenQtdven: TFloatField;
    TabSngpcVenIndConf: TWideStringField;
    TabSngpcVenIDInvIni: TIntegerField;
    TabSngpcVenTransmitida: TWideStringField;
    TabSngpcVenIDVenda: TIntegerField;
    TabSngpcVenUsoProlong: TWideStringField;
    TabSngpcVenUsoMed: TWideStringField;
    TabSngpcVenNroNot: TIntegerField;
    TabSngpcVenIDPac: TIntegerField;
    TabSngpcVenCom: TRESTDWClientSQL;
    TabSngpcVenComIDVenda: TIntegerField;
    TabSngpcVenComIDComp: TIntegerField;
    TabSngpcVenComEndcomp: TWideStringField;
    TabSngpcVenComNroEndComp: TWideStringField;
    TabSngpcVenComComEndComp: TWideStringField;
    TabSngpcVenComBaiComp: TWideStringField;
    TabSngpcVenComCepComp: TWideStringField;
    TabSngpcVenComDesMunComp: TWideStringField;
    TabSngpcVenComEstComp: TWideStringField;
    TabSngpcVenComTipDocComp: TWideStringField;
    TabSngpcVenComNumDocComp: TWideStringField;
    TabSngpcVenComOrgExpComp: TWideStringField;
    TabSngpcVenComEstEmiComp: TWideStringField;
    TabArqPessoaIDPess: TFDAutoIncField;
    TabArqPessoaTipoPes: TWideStringField;
    TabArqPessoaCpfCnpjPes: TWideStringField;
    TabArqPessoaNompes: TWideStringField;
    TabArqPessoaEndpes: TWideStringField;
    TabArqPessoaNroEnd: TWideStringField;
    TabArqPessoaCompEnd: TWideStringField;
    TabArqPessoaBaipes: TWideStringField;
    TabArqPessoaCeppes: TWideStringField;
    TabArqPessoaFonePes: TWideStringField;
    TabArqPessoaCelularPes: TWideStringField;
    TabArqPessoaSexoPes: TWideStringField;
    TabArqPessoaCodmun: TIntegerField;
    TabArqPessoaNommun: TWideStringField;
    TabArqPessoaEstmun: TWideStringField;
    TabArqPessoaRGEPes: TWideStringField;
    TabArqPessoaRGEOrg: TWideStringField;
    TabArqPessoaRGEEst: TWideStringField;
    TabPedIteRecIDFilial: TIntegerField;
    TabPedIteRecIDPed: TIntegerField;
    TabPedIteRecIDProd: TIntegerField;
    TabPedIteRecNroRec: TWideStringField;
    TabPedIteRecDatVen: TDateTimeField;
    TabPedIteRecUsoMed: TWideStringField;
    TabPedIteRecNompac: TWideStringField;
    TabPedIteRecEndpac: TWideStringField;
    TabPedIteRecCidpac: TWideStringField;
    TabPedIteRecUfpac: TWideStringField;
    TabPedIteRecRgpac: TWideStringField;
    TabPedIteRecSspac: TWideStringField;
    TabPedIteRecTelpac: TWideStringField;
    TabPedIteRecIDPessMed: TIntegerField;
    TabPedIteRecNommed: TWideStringField;
    TabPedIteRecDatHorAlt: TDateTimeField;
    TabPedIteRecDatPresc: TDateTimeField;
    TabPedIteRecSexoPac: TSmallintField;
    TabPedIteRecIdadePac: TSmallintField;
    TabPedIteRecUsoRece: TWideStringField;
    TabPedIteRecNroRegProf: TWideStringField;
    TabPedIteRecConRegProf: TWideStringField;
    TabPedIteRecEstRegProf: TWideStringField;
    TabPedIteRecUniIdadePac: TWideStringField;
    TabPedIteRecIDPac: TIntegerField;
    TabPedIteRecUsoProlong: TWideStringField;
    TabPedIteRecTipDocComp: TWideStringField;
    TabPedIteRecNumDocComp: TWideStringField;
    TabPedIteRecOrgExpComp: TWideStringField;
    TabPedIteRecEstEmiComp: TWideStringField;
    TabSngpcVenPac: TRESTDWClientSQL;
    TabSngpcVenPacIDVenda: TIntegerField;
    TabSngpcVenPacIDPac: TIntegerField;
    TabSngpcVenPacSexoPac: TWideStringField;
    TabSngpcVenPacUniIdadePac: TWideStringField;
    TabSngpcVenPacIdadePac: TIntegerField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit0DataChange(Sender: TObject);
    procedure LMDDBLabeledEdit11KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TabPedidoCalcFields(DataSet: TDataSet);
    procedure edQtdpedCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomproCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomproExit(Sender: TObject);
    procedure edPerDescCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edClieCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btDigReceClick(Sender: TObject);
    procedure dbgItensCellClick(Column: TColumn);
    procedure LMDDBLabeledEdit5CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edVendCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edConvCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edConvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edClieExit(Sender: TObject);
    procedure edVendExit(Sender: TObject);
    procedure edConvEnter(Sender: TObject);
    procedure edClieKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSalvaIteClick(Sender: TObject);
    procedure TabPedIteAfterInsert(DataSet: TDataSet);
    procedure edQtdpedExit(Sender: TObject);
    procedure btLimpaIteClick(Sender: TObject);
    procedure TabPedIteCalcFields(DataSet: TDataSet);
    procedure acVendaNovaExecute(Sender: TObject);
    procedure acVendaBuscarConcluidasExecute(Sender: TObject);
    procedure acVendaBuscarPendentesExecute(Sender: TObject);
    procedure acVendaLimparExecute(Sender: TObject);
    procedure acVendaSalvarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPedido0Click(Sender: TObject);
    procedure btPed3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acGridItemExcluiExecute(Sender: TObject);
    procedure acVendaDevolucaoExecute(Sender: TObject);
    procedure acGridItemInsereExecute(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure acGridItemReceitasExecute(Sender: TObject);
    procedure acGridItemAgendamentoExecute(Sender: TObject);
    procedure acGridItemEstoqueExecute(Sender: TObject);
    procedure acGridItemDescontoExecute(Sender: TObject);
    procedure edPBMKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edVendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgItensEnter(Sender: TObject);
    procedure dbgItensExit(Sender: TObject);
    procedure edClieCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edPerDescExit(Sender: TObject);
    procedure edVlrVendaExit(Sender: TObject);
    procedure edClieCustomButtons3Click(Sender: TObject; index: Integer);
    procedure edClieCustomButtons2Click(Sender: TObject; index: Integer);
    procedure edConvExit(Sender: TObject);
    procedure edVlrVendaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQtdpedKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQtdpedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edVlrVendaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPerDescKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQtdpedEnter(Sender: TObject);
  private
    { Private declarations }
    FIDProd_UltimoClick: Integer;
    FExibirAtalhos: Boolean;
    FParamVendas: TArqParametros;
    retProdBusca: TArqPedidoIte;      // Retorno da Busca dos Produtos
    retConvenio : TArqConvenio;       // Retorno Busca Convênio
    LarInicial,LarClie,LarVend,LarConv,LarPBM:Integer;
    FFormasPagtoDisp: String;
    FIDPessUltPesq: Integer;
    FIDConvUltPesq: Integer;
    FFormasPagtoValidasPromDesc: String; // contém todas formas pagto válidas para Prom/Desc na venda atual
    FTabPromProgr: TTabPromProg;         // Armazena os valores das promoções progressivas
    FTabDescProgr: TTabDescProg;         // Armazena os valores dos descontos progressivos
    FTabConfigRecCtl: TTabConfigRecCtl;  // Armazena a configuração das Receitas Controladas SNGPC
    FControlMsgFormasPagto: String;
    FIDVendaSNGPC: Integer;              // Identificador único da tabela arqsngpcven
    function Salvar:Boolean;
    function SalvarItens:Boolean;
    procedure AbreSQL(const prIDPed: Integer);
    procedure AjustGrid;
    function CloneAdvGlowButton(AOwner: TComponent; Source: TAdvGlowButton): TAdvGlowButton;
    procedure LimpaProdBusca;
    function ValidaAtributos(): Boolean;
    function ItemJaExiste(): Boolean;
    procedure BuscarVenda(TipoBusca: string);
    procedure NotificaEstadoBtPedidos(Sender: TObject; const Item: TarqPedido; Action: TCollectionNotification);
    procedure MostraAtalhos(Exibir: Boolean);
    function VerificaIDPedEmOutroBotao(prIDPed: Integer): Integer;
    function RetornaConvenio(const IDPess: Integer; IDConv: Integer = 0): TArqConvenio;
    function ParamVendas(): TArqParametros;
    function VendaFecharPagto(): Boolean;
    procedure AplicaRegrasDesconto(IDFilial, IDPess, IDConv: Integer; var prod: TArqPedidoIte);
    //
    procedure AplicaRegrasPromocao(IDFilial, IDPess, IDConv: Integer; var prod: TArqPedidoIte);
    procedure PromoDescPorCliente(IDProm, IDPess: Integer; var prod: TArqPedidoIte);
    procedure PromoDescPorConvenio(IDProm, IDConv, IDPess: Integer; var prod: TArqPedidoIte);
    procedure PromoDescPorProduto(IDProm: Integer; var prod: TArqPedidoIte);
    procedure PromoDescPorProdutoProg(IDProm: Integer; var prod: TArqPedidoIte);
    //
    function FormasPagtoValidasPromDesc(): String;
    procedure RecalDescPromDesc(Sender: TObject; const codFormaPagto: string);
    procedure ReaplicaRegrasPromocaoDesconto(const IDPess, IDConv: Integer);
    procedure CarregaDescProgr(IDDesc: Integer);
    procedure RecalculoDescProg(IDProm, IDDesc: Integer);
    //
    function ReceitaItemJaExiste(): Boolean;
    procedure CarregaReceitaItem(frmRec: TFrmReceitaBase; IDInvIni: Integer);
    procedure GravaReceitaItem(frmRec: TFrmReceitaBase);
    function SngpcLoteJaExiste(nrLote: String): Boolean;
    procedure CarregaSNGPCItem(frmRec: TFrmReceitaBase; IDInvIni: Integer);
    procedure GravaSNGPCItem(frmRec: TFrmReceitaBase; IDVenda, IDInvIni: Integer);
    procedure GravaDadosCompSNGPC(frmRec: TFrmReceitaBase; idVenda, idPess: Integer);
    procedure GravaDadosPacSNGPC(frmRec: TFrmReceitaBase; IDVenda, IDPac: Integer);
  public
    { Public declarations }
    listaBtPedidos: TList<TArqPedido>; // Lista dos Botões de Pedidos
    btPedSel: Integer; // Indica qual o botão Selecionado atualmente
  end;

var
   FrmVendas: TFrmVendas;

implementation

{$R *.dfm}

// Cor icones: #3F4550, hot: #FFC300

uses uLibFarm, uBuscaPro, uConEsto, uDevVenda, uBusVenda, uSelPBM,
     uVenProm, uIAVendaCli, uIAVendaPro, uDigReceita, uFecVenda, uVenAgenda, uReceitaA,
     uReceitaB, uReceitaB2, uReceitaC, uReceitaC2, uEdVendedor, uBuscaPes, uPessoasCad,
     uVenUniLevPag;

procedure TFrmVendas.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   LarInicial := Self.Width;
   LarClie := edClie.Width;
   LarVend := edVend.Width;
   LarConv := edConv.Width;
   LarPBM  := edPBM.Width;

   FTabPromProgr   := TTabPromProg.Create();
   FTabDescProgr   := TTabDescProg.Create();
   FTabConfigRecCtl:= TTabConfigRecCtl.Create();

   // Carrega a configuração das Receitas Controladas CNGPC
   FTabConfigRecCtl.Carrega(dm.DWDataBase, FILIAL);
end;

procedure TFrmVendas.FormDestroy(Sender: TObject);
begin
  FTabConfigRecCtl.Free;
  FTabPromProgr.Free;
  FTabDescProgr.Free;

  tabFormaPagto.Close;

  listaBtPedidos.Free;
end;

procedure TFrmVendas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //CTRL + H
  if (Key = 72) and (ssCtrl in Shift) then
  begin
    FExibirAtalhos:= not(FExibirAtalhos);
    MostraAtalhos(FExibirAtalhos);
    key:= 0;
  end;
  //CTRL + N (Nova Venda)
  if (Key = 78) and (ssCtrl in Shift) then
  begin
    acVendaNova.OnExecute(Sender);
    key:= 0;
  end;
  //CTRL + L
  if (Key = 76) and (ssCtrl in Shift) then
  begin
    acVendaLimpar.OnExecute(Sender);
    key:= 0;
  end;
  //CTRL + S
  if (Key = 83) and (ssCtrl in Shift) then
  begin
    acVendaSalvar.OnExecute(Sender);
    key:= 0;
  end;
  //CTRL + B
  if (Key = 80) and (ssCtrl in Shift) then
  begin
    acVendaBuscarPendentes.OnExecute(Sender);
    key:= 0;
  end;
  //CTRL + P
  if (Key = 66) and (ssCtrl in Shift) then
  begin
    acVendaBuscarConcluidas.OnExecute(Sender);
    key:= 0;
  end;
  //CTRL + D
  if (Key = 68) and (ssCtrl in Shift) then
  begin
    acVendaDevolucao.OnExecute(Sender);
    key:= 0;
  end;
  // Grid dos Itens
  {if ActiveControl is TDBGrid then
  begin
    if Key = VK_INSERT then
    begin
      Key := 0; // Impede o comportamento padrão do DBGrid
      acGridItemInsere.OnExecute(Self);
    end
    else if Key = VK_DELETE then
    begin
      Key := 0; // Impede o comportamento padrão do DBGrid
      acGridItemExclui.OnExecute(Self);
    end;
  end;}
end;

procedure TFrmVendas.MostraAtalhos(Exibir: Boolean);
var
  I: Integer;
  Componente: TComponent;
  Botao: TAdvGlowButton;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    Componente := Components[I];
    if Componente is TAdvGlowButton then
    begin
      Botao := TAdvGlowButton(Componente);
      if Botao.ShortCutHint <> '' then
      begin
        if Exibir then
          Botao.ShowShortCutHint
        else
          Botao.HideShortCutHint;
      end;
    end;
  end;
end;

procedure TFrmVendas.FormShow(Sender: TObject);
begin
   tabFormaPagto.Open;
   // Formas de Pagto Disponíveis Na Venda
   // Será utilizado nas funções formas pagto Promoções e Descontos
   FFormasPagtoDisp:= '';
   tabFormaPagto.First;
   while not tabFormaPagto.Eof do
   begin
     if FFormasPagtoDisp = EmptyStr then
       FFormasPagtoDisp:= FormatFloat('00',tabFormaPagtoIDForPag.AsInteger)
     else
       FFormasPagtoDisp:= FFormasPagtoDisp +','+FormatFloat('00',tabFormaPagtoIDForPag.AsInteger);
     //
     tabFormaPagto.Next;
   end;

   // Carrega Parâmetros da Venda (tabela arqparametros)
   FParamVendas:= ParamVendas();

   //Inicializa Lista dos Botões de Pedidos
   listaBtPedidos:= TList<TArqPedido>.Create;
   listaBtPedidos.OnNotify := NotificaEstadoBtPedidos;

   // Cria o primeiro botão de Pedidos na Lista
   // Este primeiro botão nunca será destruído
   listaBtPedidos.Add( TarqPedido.Create(0, 'A', btPedido0) );

   btPedSel:= 0; // Indica o botão selecionado atualmente

   AbreSQL(listaBtPedidos[btPedSel].IDPed);

   // Controla SNGPC
   if FTabConfigRecCtl.ControleSNGPC then
   begin
     // Se inventário SNGPC não esta confirmado desativa controle SNGPC
     if not FTabConfigRecCtl.InventarioConfirmado(dm.DWDataBase, FILIAL) then
     begin
       FTabConfigRecCtl.ControleSNGPC:= False;
       MostraMsg('Atenção','Controle SNGPC DESATIVADO, não encontrado inventário CONFIRMADO!',mtWarning, [mbOk]);
     end;
   end;
   //
   edClie.SetFocus;
end;

procedure TFrmVendas.NotificaEstadoBtPedidos(Sender: TObject; const Item: TarqPedido; Action: TCollectionNotification);
begin
    case Action of
        cnAdded:    Begin
                      // Ao Incluir um Botão Volta a cor Normal do Atual
                      listaBtPedidos[btPedSel].btPedido.Appearance.Color:= $00F4F8FF;
                      listaBtPedidos[btPedSel].btPedido.Appearance.ColorMirror:= $00F4F8FF;

                      // Ao Incluir um Botão de Pedido, muda a cor informando selecionado
                      Item.btPedido.Appearance.Color:= $002B70FF;
                      Item.btPedido.Appearance.ColorMirror:= $002B70FF;

                      btPedSel:= btPedSel + 1;
                    End;

        cnDeleting: begin
                      btPedSel:= btPedSel - 1;
                    end;
    end;
end;

procedure TFrmVendas.timAlphaTimer(Sender: TObject);
var
   Proporcao:Double;
   i,AvailableWidth,StaticWidth,OriginalTotalWidth:Integer;
begin
   timAlpha.Enabled := False;
   AvailableWidth := dbgItens.ClientWidth - 30;
   StaticWidth := 0;
   for i := 7 to dbgItens.Columns.Count - 1 do StaticWidth := StaticWidth + dbgItens.Columns[i].Width;
   AvailableWidth := AvailableWidth - StaticWidth;
   OriginalTotalWidth := 0;
   for i := 0 to 6 do OriginalTotalWidth := OriginalTotalWidth + dbgItens.Columns[i].Width;
   if OriginalTotalWidth > 0 then
      for i := 0 to 6 do dbgItens.Columns[i].Width := Round((dbgItens.Columns[i].Width / OriginalTotalWidth) * AvailableWidth);

   Proporcao    := Self.Width / LarInicial;
   edClie.Width := Round(LarClie * Proporcao);
   edConv.Width := Round(LarConv * Proporcao);
   edVend.Width := Round(LarVend * Proporcao);
   edPBM.Width  := Round(LarPBM  * Proporcao);
   edVend.Left  := edClie.Width + edClie.Left + 7;
   edPBM.Left   := edClie.Width + edClie.Left + 7;
   AjustGrid;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmVendas.AbreSQL(const prIDPed: Integer);
begin
   FTabPromProgr.Limpar;
   FTabDescProgr.Limpar;
   //
   retConvenio.IDConv:= 0;
   retConvenio.Nomcon:= EmptyStr;
   retConvenio.IndVenVis   := False;
   retConvenio.IndVenPra   := False;
   retConvenio.IndDesProg  := False;
   retConvenio.IndPreProm  := False;
   retConvenio.IndDesVenVis:= False;
   retConvenio.IndDesVenPra:= False;
   //
   FIDVendaSNGPC:= 0;
   //
   if TabSngpcVenPac.Active then TabSngpcVenPac.Close;
   if TabSngpcVenCom.Active then TabSngpcVenCom.Close;
   if TabSngpcVen.Active    then TabSngpcVen.Close;
   if TabPedIteRec.Active   then TabPedIteRec.Close;
   if TabPedite.Active      then TabPedite.Close;
   if TabPedido.Active      then TabPedido.Close;

   TabSngpcVenPac.DisableControls;
   TabSngpcVenCom.DisableControls;
   TabSngpcVen.DisableControls;
   TabPedIteRec.DisableControls;
   TabPedite.DisableControls;
   TabPedido.DisableControls;

   var SQL_AUX := 'SELECT PED.*,CLI.Nompes AS NomeCli,PBM.NomPBM,CON.Nomcon,VEN.Nompes AS Nomven FROM arqpedido PED '+
                 'LEFT JOIN arqpbm PBM ON PED.IDPBM = PBM.IDPBM '+
                 'LEFT JOIN arqconvenio CON ON PED.IDConv = CON.IDConv '+
                 'LEFT JOIN arqpessoa CLI ON PED.IDPess = CLI.IDPess '+
                 'LEFT JOIN arqpessoa VEN ON PED.IDVend = VEN.IDPess ';
   TabPedido.SQL.Text := SQL_AUX+iif(listaBtPedidos[btPedSel].IDPed > 0,' WHERE PED.IDPed = '+listaBtPedidos[btPedSel].IDPed.ToString,'')+' LIMIT 1';
   //TabPedido.SQL.SaveToFile('C:\Temp\TabPedido.SQL');
   TabPedido.Open;

   if listaBtPedidos[btPedSel].IDPed <= 0 then
   begin
      TabPedido.Append;
      TabPedidoIDPed.AsInteger:= 0;
      TabPedidoIDFilial.AsInteger:= FILIAL;
   end else
   begin
      //edIDEsppesExit(Self);
      //LMDDBLabeledListComboBox2Exit(Self);
      //SetMaskCPFCNPJ(TabPessCpfCnpjPes.Value);
      //AbreSubForm('Conta',btConta.Tag = 1);
   end;

   SouPedido.DataSet  := TabPedido;

   var SQL_TEMP:= 'SELECT PEI.*,PRO.Despro, FAB.IDPess as IDFabr, FAB.Nompes AS NomeFab, PRO.UsoRece, 0 as EstTotal, PRO.PrecoVen AS PrecoUni, '+
                                'pro.IDGrupo, pro.IDGruSub, 0 as CalcPromDesc, ' +
                                QuotedStr('                                      ') + ' as FormFpgCod, ' +
                                'PRO.IndBloDes,  ' +
                                'pro.IDGrupo, g.Desgru, g.DescMax as GrupoDescMax, g.DescPra as GrupoPerDescPrazo, ' +
                                'pro.IDGruSub, s.DesgruSub, s.DescMax as GruSubDescMax, s.DescPra as GruSubPerDescPrazo, ' +
                                'LOC.Desloc, ';
   //
   //if listaBtPedidos[btPedSel].IDPed > 0 then
  //   SQL_TEMP:= SQL_TEMP + 'CAST(GROUP_CONCAT(DISTINCT SUB.DesSubs SEPARATOR ", ") AS CHAR(255)) AS DesSubs, '
  // else
   SQL_TEMP:= SQL_TEMP + 'CAST("" AS CHAR(255)) AS DesSubs ';
   //
   SQL_TEMP:= SQL_TEMP +        'FROM arqpedidoite PEI '+
                                'LEFT JOIN arqproduto    PRO ON PEI.IDProd = PRO.IDProd '+
                                'LEFT JOIN arqpessoa     FAB ON PRO.IDFabr = FAB.IDPess '+
                                'LEFT JOIN arqgrupo g        ON  g.IDGrupo  = pro.IDGrupo '+
                                'LEFT JOIN arqgruposub s     ON  s.IDGruSub = pro.IDGruSub '+
                                'LEFT JOIN arqlocesto LOC    ON  LOC.IDLoc  = pro.IDLoc ';
   //
   {if listaBtPedidos[btPedSel].IDPed > 0 then
   begin
     SQL_TEMP:= SQL_TEMP +      'LEFT JOIN arqprodutosub PS  ON  PS.IDProd  = pro.IDProd '+
                                'LEFT JOIN arqsubstancia SUB ON  SUB.IDSubs = PS.IDSubs ';
   end;}
   //
   SQL_TEMP:= SQL_TEMP +        'WHERE PEI.IDFilial = %s '+
                                '  AND PEI.IDPed = %s';
   //
   TabPedite.SQL.Text := Format( SQL_TEMP ,
                                [TabPedidoIDFilial.AsString,
                                 listaBtPedidos[btPedSel].IDPed.ToString]);
   //TabPedite.SQL.SaveToFile('C:\Temp\TabPedite.SQL');
   TabPedite.Open;

   // Total de Itens do Pedido
   var totItens: Integer := 0;
   while not TabPedite.Eof do
   begin
     totItens:= totItens + TabPedIteQtdped.AsInteger;

     // Verifica se Tabela de Desconto Progressivo já esta Carregada
     // Carrega apenas no primerio Produto
     //if not FTabDescProgr.ExisteTabIdDesc(IDDesc) then
     //begin
     //  CarregaDescProgr(IDDesc);
     //end;

     TabPedite.Next;
   end;
   edTotIte.AsInteger:= totItens;

   // Receitas Controladas
   if not(TabPedIteRec.Active) then
   begin
     TabPedIteRec.ParamByName('IDFilial').AsInteger:= FILIAL;
     TabPedIteRec.ParamByName('IDPed').AsInteger   := TabPedIteIDPed.AsInteger;
     TabPedIteRec.Open;

     // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
     if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
     begin
       TabSngpcVen.Filtered:= False;
       TabSngpcVen.Filter  := EmptyStr;

       TabSngpcVen.ParamByName('IDFilial').AsInteger:= FILIAL;
       TabSngpcVen.ParamByName('IDPed').AsInteger   := TabPedIteIDPed.AsInteger;
       TabSngpcVen.Open;

       FIDVendaSNGPC:= TabSngpcVenIDVenda.AsInteger;

       TabSngpcVenCom.ParamByName('IDVenda').AsInteger := TabSngpcVenIDVenda.AsInteger;
       TabSngpcVenCom.Open;

       TabSngpcVenPac.ParamByName('IDVenda').AsInteger := TabSngpcVenIDVenda.AsInteger;
       TabSngpcVenPac.Open;
     end;
   end;
   //
   TabSngpcVenPac.EnableControls;
   TabSngpcVenCom.EnableControls;
   TabSngpcVen.EnableControls;
   TabPedIteRec.EnableControls;
   TabPedite.EnableControls;
   TabPedido.EnableControls;
   //
   AjustGrid;
end;

procedure TFrmVendas.LMDDBLabeledEdit0DataChange(Sender: TObject);
begin
   if TabPedidoIDPed.AsInteger > 0 then
        LMDDBLabeledEdit0.DataField := 'IDPed'
   else LMDDBLabeledEdit0.DataField := '';
end;

procedure TFrmVendas.LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
begin
   //btBuscasDB(TabPedido,'arqfilial',TDBEdit(LMDDBLabeledEdit11),'IDFilial','IDFilial','Nomfil','Nomfil','',0);
end;

procedure TFrmVendas.LMDDBLabeledEdit11KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   //if key <> VK_RETURN then
   //   btBuscasDB(TabPedido,'arqfilial',TDBEdit(LMDDBLabeledEdit11),'IDFilial','IDFilial','Nomfil','Nomfil','',Key);
end;

// ---------------- Seleciona PBM ---------------- //
procedure TFrmVendas.LMDDBLabeledEdit5CustomButtons0Click(Sender: TObject; index: Integer);
begin
   FrmSelPBM := TFrmSelPBM.Create(Application);
   try
      FrmSelPBM.ShowModal;
   finally
      if not (TabPedido.State in dsEditModes) then TabPedido.Edit;
      TabPedidoIDPBM.Value  := FrmSelPBM.retIDPBM;
      TabPedidoNomPBM.Value := FrmSelPBM.retNomPBM;
      FrmSelPBM.Free;
   end;
end;

// ---------------- Salvar (Concluir) ---------------- //
function TFrmVendas.Salvar:Boolean;
var
   retID: Integer;
   nrItemVenda: Integer;
   auxSQL: String;
   FocusObject: TWinControl;
begin
   nrItemVenda:=0;
   Result := False;
   //if TabPedido.State in dsEditModes then
   //begin
      Result  := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;

      if ValidaAtributos then
      begin
        Result := True;

        try
           {if (listaBtPedidos[btPedSel].IDPed = 0) and (TabPedido.State = dsInsert) then
           begin
              TabPedidoNext.Open;
              listaBtPedidos[btPedSel].IDPed := TabPedidoNext.FieldByName('Next_IDPed').AsInteger;
              TabPedidoNext.Close;

              TabPedido.FieldByName('IDPed').AsInteger:= listaBtPedidos[btPedSel].IDPed
           end else
           begin
             if (listaBtPedidos[btPedSel].IDPed > 0) and (TabPedido.State = dsBrowse) then
               TabPedido.Edit;
           end;}

           if (listaBtPedidos[btPedSel].IDPed > 0) and (TabPedido.State = dsBrowse) then
               TabPedido.Edit;

           TabPedidoIDFilial.Value := FILIAL;
           TabPedidoStatus.Value   := listaBtPedidos[btPedSel].Status;
           TabPedidoDatped.Value   := DataServer;

           retID := MyApplayUpdates(TabPedido, 'IDPed', 'IDPed = '+listaBtPedidos[btPedSel].IDPed.ToString, TabPedido.State, True);


            if listaBtPedidos[btPedSel].ItensAlterados then
              SalvarItens();
        except
           on E:Exception do
           begin
              SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Pedido -> '+E.Message);
              MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
              Exit;
           end;
        end;
      end;
      PanelCadastro.Visible := False;
      Sleep(10);
      PanelCadastro.Visible := True;
   //end; //if
end;

function TFrmVendas.SalvarItens:Boolean;
var
  retID: Integer;
  CamposParaIgnorar: TArray<string>;
  listaIDProd: String;
  numItem: Integer;

  procedure InserePedIteLot(Qtdped: Double; NroLot: String);
  begin
    Inc(numItem);

    TabPedIteLot.Append;
    TabPedIteLotIDFilial.AsInteger    := TabPedIteIDFilial.AsInteger;
    TabPedIteLotIDPed.AsInteger       := TabPedIteIDPed.AsInteger;
    TabPedIteLotNroite.AsInteger      := numItem;
    TabPedIteLotIDProd.AsInteger      := TabPedIteIDProd.AsInteger;
    TabPedIteLotNrolot.AsString       := NroLot;
    TabPedIteLotIDVend.AsInteger      := TabPedIteIDVend.AsInteger;
    TabPedIteLotIndComi.AsBoolean     := True;
    TabPedIteLotPrecoVen.AsFloat      := TabPedItePrecoVen.AsFloat;
    TabPedIteLotPrecoPMC.AsFloat      := TabPedItePrecoPMC.AsFloat;
    TabPedIteLotPrecoFP.AsFloat       := TabPedItePrecoFP.AsFloat;
    TabPedIteLotPrecoFab.AsFloat      := TabPedItePrecoFab.AsFloat;
    TabPedIteLotCustoMed.AsFloat      := TabPedIteCustoMed.AsFloat;
    TabPedIteLotVlrPIS.AsFloat        := TabPedIteVlrPIS.AsFloat;
    TabPedIteLotVlrCOF.AsFloat        := TabPedIteVlrCOF.AsFloat;
    TabPedIteLotQtdped.AsFloat        := Qtdped;
    TabPedIteLotQtdConf.AsFloat       := 0;
    TabPedIteLotPerDesc.AsFloat       := TabPedItePerDesc.AsFloat;
    TabPedIteLotVlrDesc.AsFloat       := TabPedIteVlrDesc.AsFloat;
    TabPedIteLotVlrVenda.AsFloat      := TabPedIteVlrVenda.AsFloat;
    TabPedIteLotDatHorAlt.AsDateTime  := TabPedIteDatHorAlt.AsDateTime;
    TabPedIteLotIDProm.AsInteger      := TabPedIteIDProm.AsInteger;
    TabPedIteLotIDDesc.AsInteger      := TabPedIteIDDesc.AsInteger;
    TabPedIteLotIDFabr.AsInteger      := TabPedIteIDFabr.AsInteger;
    TabPedIteLot.Post;
  end;

  procedure AlteraPedIteLot(Qtdped: Double; NroLot: String);
  begin
    TabPedIteLot.Edit;
    TabPedIteLotQtdped.AsFloat        := TabPedIteLotQtdped.AsFloat + Qtdped;
    TabPedIteLotQtdConf.AsFloat       := 0;
    TabPedIteLot.Post;
  end;

begin
  Result:= False;
  numItem:= 0;

  TabPedIte.DisableControls;
  TabPedIteLot.DisableControls;

  TabPedIteLot.Close;
  TabPedIteLot.Open;

  // Identifica e Separa em Lotes para Salvar
  listaIDProd:= EmptyStr;
  TabPedIte.First;
  while not(TabPedIte.Eof) do
  begin
    if listaIDProd = EmptyStr then
      listaIDProd:= TabPedIteIDProd.AsString
    else
      listaIDProd:= listaIDProd + ',' + TabPedIteIDProd.AsString;
    //
    TabPedIte.Next;
  end;

  if listaIDProd = EmptyStr then
    Exit;

  TabProdutoLot.Close;
  TabProdutoLot.SQL.Text:= Format('select IDFilial, IDProd, Nrolot, IDPess, cAgreg, Datfab, Datven, Qtdest ' +
                           'from arqprodutolot ' +
                           'where (Datven is null or Datven >= curdate()) ' +
                           '  and IDFilial = %s ' +
                           '  and IDProd in (%s) ' +
                           '  order by IDFilial, IDProd, Datven ',
                           [FILIAL.ToString,
                           listaIDProd] );
  TabProdutoLot.Open;

  if not(TabProdutoLot.IsEmpty) then
  begin
    TabPedIte.First;

    while not(TabPedIte.Eof) do
    begin
      TabProdutoLot.Filtered:= False;
      TabProdutoLot.Filter  := 'IDPess = ' + TabPedIteIDFabr.AsString + ' and ' +
                               'IDProd = ' + TabPedIteIDProd.AsString;
      TabProdutoLot.Filtered:= True;

      if TabProdutoLot.IsEmpty then  // 1-Vazio fica Vazio
      begin
        InserePedIteLot(TabPedIteQtdped.AsCurrency, '');

      end else
      begin
        TabProdutoLot.First;

        if AnsiLowerCase(TabProdutoLotNrolot.AsString) = AnsiLowerCase('UNICO') then  // 2-Um Lote UNICO -> fica Unico
        begin
          InserePedIteLot(TabPedIteQtdped.AsCurrency, TabProdutoLotNrolot.AsString);

        end else if (TabProdutoLot.RecordCount = 1) and (TabProdutoLotQtdest.AsCurrency <= 0) then // 3-1 Lote Negativo -> Fica Negativo
        begin
          InserePedIteLot(TabPedIteQtdped.AsCurrency, TabProdutoLotNrolot.AsString);

        end else if (TabProdutoLot.RecordCount >= 1) then // 4- + Lote Negativo -> Próximo
        begin
          var numLot: String := EmptyStr;
          var qtdPed: Currency := 0.0;

          qtdPed:= TabPedIteQtdped.AsCurrency;

          while not(TabProdutoLot.Eof) do
          begin

            if (qtdPed > 0) and (TabProdutoLotQtdest.AsCurrency > 0) then
            begin
              if (qtdPed > TabProdutoLotQtdest.AsCurrency) then
              begin
                //qtdPed:= TabPedIteQtdped.AsCurrency;
                numLot:= TabProdutoLotNrolot.AsString;
                InserePedIteLot(TabProdutoLotQtdest.AsCurrency, numLot);

                qtdPed:= qtdPed - TabProdutoLotQtdest.AsCurrency;
              end else if (qtdPed <= TabProdutoLotQtdest.AsCurrency) then
              begin
                //
                numLot:= TabProdutoLotNrolot.AsString;
                InserePedIteLot(qtdPed, numLot);

                qtdPed:= qtdPed - qtdPed;
              end;
            end;
            //
            TabProdutoLot.Next;
          end;
          //
          if (qtdPed > 0) and (numLot <> TabProdutoLotNrolot.AsString) then
          begin
            numLot:= TabProdutoLotNrolot.AsString;

            InserePedIteLot(qtdPed, numLot);

          end else if (qtdPed > 0) and (numLot = TabProdutoLotNrolot.AsString) then
          begin

            AlteraPedIteLot(qtdPed, numLot);

          end else if (numlot = EmptyStr) then
          begin
            qtdPed:= TabPedIteQtdped.AsCurrency;
            numLot:= TabProdutoLotNrolot.AsString;

            InserePedIteLot(qtdPed, numLot);
          end;
          // -->>
        end;

      end;
      //
      TabPedIte.Next;
    end;
  end;
  TabProdutoLot.Close;
  // //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  try
    {CamposParaIgnorar := ['TabPedIteEstTotal', 'TabPedItePrecoUni', 'TabPedIteIDGrupo',
                          'TabPedIteIDGruSub', 'TabPedIteIDFabr', 'TabPedIteIndBloDes',
                          'TabPedIteFormFpgCod', 'TabPedIteCalcPromDesc',
                          'TabPedIteIndBloDes', 'TabPedIteIDGrupo', 'TabPedIteDesgru',
                          'TabPedIteGrupoDescMax', 'TabPedIteDesgruSub', 'TabPedIteIDGruSub',
                          'TabPedIteGruSubDescMax', 'TabPedIteDesSubs', 'TabPedIteDesloc',
                          'TabPedIteDescMaxCalc', 'TabPedIteGrupoPerDescPrazo', 'TabPedIteGruSubPerDescPrazo'
                         ];
    }
    var UpdateList: TArray<TUpdateParams>;
    SetLength(UpdateList, 5);

    // Configuração para TabPedIteLot
    UpdateList[0] := TUpdateParams.Create(TabPedIteLot, 'IDPed', 'IDPed = 0', True);

    // Configuração para TabPedIteRec (só se necessário)
    if listaBtPedidos[btPedSel].ReceitasAlteradas and TabPedIteRec.Active and not(TabPedIteRec.IsEmpty) then
    begin
      UpdateList[1] := TUpdateParams.Create(TabPedIteRec, 'IDPed', 'IDPed = 0', True);

      // Configuração para TabSngpcVen (só se necessário)
      TabSngpcVen.Filtered:= False;
      TabSngpcVen.Filter  := EmptyStr;
      if TabSngpcVen.Active and not(TabSngpcVen.IsEmpty) then
      begin
        UpdateList[2] := TUpdateParams.Create(TabSngpcVen   , 'IDPed'  , 'IDPed = 0'  , True);
        UpdateList[3] := TUpdateParams.Create(TabSngpcVenCom, 'IDVenda', 'IDVenda = 0', True);
        UpdateList[4] := TUpdateParams.Create(TabSngpcVenPac, 'IDVenda', 'IDVenda = 0', True);
      end else
      begin
        UpdateList[2] := TUpdateParams.Create(nil, '', '', False); // Dataset vazio
        UpdateList[3] := TUpdateParams.Create(nil, '', '', False); // Dataset vazio
        UpdateList[4] := TUpdateParams.Create(nil, '', '', False); // Dataset vazio
      end;
    end
    else
    begin
      UpdateList[1] := TUpdateParams.Create(nil, '', '', False); // Dataset vazio
      UpdateList[2] := TUpdateParams.Create(nil, '', '', False); // Dataset vazio
      UpdateList[3] := TUpdateParams.Create(nil, '', '', False); // Dataset vazio
      UpdateList[4] := TUpdateParams.Create(nil, '', '', False); // Dataset vazio
    end;

    // Chamada única para todos os datasets
    var msgErro:= '';
    retID := MyApplayUpdatesAllMultiple(UpdateList, msgErro);
    if retID <= -1 then
      ShowMessage(msgErro);

  finally
    TabPedIteLot.EnableControls;
    TabPedIte.EnableControls;

    TabPedIteLot.Close;
  end;
end;

function TFrmVendas.ValidaAtributos(): Boolean;
var
  DBEditErro: TLMDDBLabeledEdit;
begin
  Result:= True;
  DBEditErro:= nil;
  //if TabPedidoIDVend.AsInteger <= 0 then
  //  DBEditErro := edVend;
  // if TabPedidoIDPess.AsInteger <= 0 then DBEditErro := edClie;

  if DBEditErro <> nil then
  begin
     Result:= False;
     MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
     DBEditErro.SetFocus;
     Exit;
  end;

  if TabPedIte.RecordCount = 0 then
  begin
    Result:= False;
     MostraMsg('Produto(s) não informado(s)','Favor informar os produtos!',mtWarning, [mbOk]);
     edNompro.SetFocus;
     Exit;
  end;

  // '0-Permite Venda de Produtos sem estoque / 1-Bloqueio de venda Produto sem estoque'
  if FParamVendas.VenProdBloqSemEst = 1 then
  begin
    TabPedIte.DisableControls;
    TabPedIte.First;
    while not TabPedIte.Eof do
    begin
      if TabPedIteEstTotal.AsInteger = 0 then
        Result:= False;
      //
      TabPedIte.Next;
    end;
    TabPedIte.EnableControls;

    if Not(Result) then
    begin
      MostraMsg('Produto(s) sem Estoque','Venda Bloqueada!',mtWarning, [mbOk]);
      edNompro.SetFocus;
      exit;
    end;
  end;

  // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
  if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
  begin
    var ctNumeroRec:= 0;
    // Verifica Produtos Controlados Precisam preencher receita
    TabPedIte.DisableControls;
    TabPedIte.First;
    while not TabPedIte.Eof do
    begin
      if TabPedIteUsoRece.AsString <> EmptyStr then
        Inc(ctNumeroRec);
      //
      TabPedIte.Next;
    end;
    TabPedIte.EnableControls;

    if (ctNumeroRec > 0) then // Número de Receitas não preenchidas
    begin
      if ctNumeroRec <> TabPedIteRec.RecordCount then
      begin
        MostraMsg('Dado não informado','Favor Preencher Receita(s) Remédio(s) Controlado(s)',mtWarning, [mbOk]);
        Result:= False;
        edNompro.SetFocus;
        exit;
      end;
    end else
      Result:= True;
  end;

end;

procedure TFrmVendas.TabPedidoCalcFields(DataSet: TDataSet);
begin
   TabPedidoTotBruCalc.AsFloat := TabPedidoTotPedido.AsFloat + TabPedidoTotDesc.AsFloat;
   // Calcula Percentual Desconto
   TabPedidoTotPercDescCalc.AsFloat:= (TabPedidoTotDesc.AsFloat / TabPedidoTotBruCalc.AsFloat) * 100;
end;

procedure TFrmVendas.TabPedIteAfterInsert(DataSet: TDataSet);
begin
   TabPedIteIDFilial.Value := FILIAL;
   TabPedIteDatHorAlt.Value := DataServer;
end;

procedure TFrmVendas.TabPedIteCalcFields(DataSet: TDataSet);
begin
  if (TabPedIteCalcPromDesc.AsInteger = 0) then // Desativa, não entra no cálculo promoção/desconto/Manual (Grupo/SubGrupo)
    TabPedIteTotItemCalc.AsFloat:= (TabPedIteQtdped.AsCurrency * TabPedItePrecoVen.AsCurrency);

  if (TabPedIteCalcPromDesc.AsInteger = 1) then // Ativa, entra no cálculo de promoção/desconto/Manual (Grupo/SubGrupo)
    TabPedIteTotItemCalc.AsFloat:= (TabPedIteQtdped.AsCurrency * TabPedIteVlrVenda.AsCurrency);

  // Desconto Manual para produtos (Desconto Max Grupo/SubGrupo)
  // Se produto não possui desconto Promoções/Descontos
  if (TabPedIteIDProm.AsInteger = 0) and (TabPedIteIDDesc.AsInteger = 0) then
  begin
    // Indica se Bloqueia descontos Manual do Grupo/SubGrupo
    // para este produto (Parâmetro do Cadastro de Produtos)
    // "bloquear descontos” ('0' = Não/'1' = Sim) Produto não pode conceder desconto Máximo digitado,definido Grupo/Subgrupo
    if (TabPedIteIndBloDes.AsString = '0') then
    begin
      if (TabPedIteGrupoDescMax.AsCurrency > 0) and
          (TabPedIteGruSubDescMax.AsCurrency = 0) then
        TabPedIteDescMaxCalc.AsCurrency := TabPedIteGrupoDescMax.AsCurrency;

      if (TabPedIteGrupoDescMax.AsCurrency >= 0) and
          (TabPedIteGruSubDescMax.AsCurrency > 0) then
        TabPedIteDescMaxCalc.AsCurrency:= TabPedIteGruSubDescMax.AsCurrency;
    end;

  end;
end;

// ------------- Efetua a Busca do Produto à Vender ------------- //
procedure TFrmVendas.edNomproCustomButtons1Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   //if not(TabelaRet.State in dsEditModes) then TabelaRet.Edit;

   {if Carc = 27 then  //-- Tecla ESC -> Limpa Campo -- //
   begin
      EditBase.Tag  := 0;
      EditBase.Text := '';
      TabelaRet.FieldByName(CampoRet).AsInteger := 0;
      TabelaRet.FieldByName(recCampoShow).AsString := '';
      Exit;
   end;}

   try
      var recWidth:= 0;

      //_DESPRO := '';
      //_NOMFAB := '';
      edFabr.Clear;
      //edNompro.Tag := 0; // IDProd
      FrmBuscaPro  := TFrmBuscaPro.Create(Application);
      with FrmBuscaPro do
      begin
         lPoint := Self.edNompro.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         //CampoRetor  := CampoRet;
         //CampoOrigem := CampoOri;
         //CampoBusca  := CampoBus;
         //ArqBusca    := TabelaBus;
         //ArqRetorno  := TabelaRet;
         //Filtro      := FiltroRec;
         //recCarc     := Carc;
         //CampoShow   := recCampoShow;
         //WidthColuna := recWidth;
         Width:= iif(recWidth > 0, recWidth, Self.edNompro.Width);
         //if (Char(Carc) in ['0'..'9']) or (Char(Carc) in ['A'..'Z']) or (Char(Carc) in ['a'..'z']) then
         //  FrmBuscaPro.edBusca.Text := Char(Carc);

         edRetorno    := TEdit(Self.edNompro);
         edBusca.Text := TrataTecNum(Index); // Tecla precionada que esta vindo do edit edNompro (Busca produto)

         VenProdExibComEst := Self.FParamVendas.VenProdExibComEst;

         ShowModal;
      end; // with
   finally
      Self.retProdBusca:= FrmBuscaPro.prodBusca;
      FrmBuscaPro.Free;
   end;
   //
   retProdBusca.FormFpgCod:= FFormasPagtoDisp;
   //
   edVlrVenda.ReadOnly:= False;
   edPerDesc.ReadOnly := False;
   if retProdBusca.IDProd > 0 then
   begin

     // Cliente Possui Convênio
     if retConvenio.IDConv > 0 then
     begin
       // Convênio do Cliente Permite Preços Promocionais
       if retConvenio.IndPreProm then
         // 1-Aplica Regras de Promoções
         AplicaRegrasPromocao(FILIAL,
                               TabPedidoIDPess.AsInteger, // IDPess Cliente
                               TabPedidoIDConv.AsInteger, // IDConv Convênio
                               retProdBusca // Dados do produto Pesquisado
                              );
     end else
     begin
       // 1-Aplica Regras de Promoções
       AplicaRegrasPromocao(FILIAL,
                               TabPedidoIDPess.AsInteger, // IDPess Cliente
                               TabPedidoIDConv.AsInteger, // IDConv Convênio
                               retProdBusca // Dados do produto Pesquisado
                              );
     end;

     if retProdBusca.IDProm = 0 then // Se não tem promoção Pega Desconto se tiver
     begin
       // 2-Aplica Regras de Descontos
       AplicaRegrasDesconto(FILIAL,
                               TabPedidoIDPess.AsInteger, // IDPess Cliente
                               TabPedidoIDConv.AsInteger, // IDConv Convênio
                               retProdBusca // Dados do produto Pesquisado
                              );

       // Calculo Desconto Progressivo
       var percDescProg: Currency := 0;
       if (retProdBusca.IDDesc > 0) and FTabDescProgr.ExisteTabIdDesc(retProdBusca.IDDesc) then
       begin
         percDescProg:= FTabDescProgr.AddVlr(retProdBusca.IDDesc, retProdBusca.PrecoVen);

         retProdBusca.PerDesc:= percDescProg;

         retProdBusca.VlrDesc:= Roundx((retProdBusca.PrecoVen*retProdBusca.PerDesc)/100, 2);
         retProdBusca.VlrVenda:= retProdBusca.PrecoVen-retProdBusca.VlrDesc;
         //edVlrVenda.SetValue(retProdBusca.VlrVenda);
       end;
     end else
     begin
       // Verifica se Promoção é Progressiva
       if FTabPromProgr.ExisteTabIdProd(retProdBusca.IDProm, retProdBusca.IDProd) then
       begin
         edVlrVenda.ReadOnly:= True;
         edPerDesc.ReadOnly:= True;
       end;
     end;

     // Desconto Manual para produtos (Desconto Max Grupo/SubGrupo)
     // Se produto não possui desconto Promoções/Descontos
     retProdBusca.DescMaxCalc   := 0;

     if (retProdBusca.IDProm = 0) and (retProdBusca.IDDesc = 0) then
     begin
       // Indica se Bloqueia descontos Manual do Grupo/SubGrupo
       // para este produto (Parâmetro do Cadastro de Produtos)
       if not retProdBusca.IndBloDes then
       begin
         if (retProdBusca.GrupoDescMax > 0) and
              (retProdBusca.GruSubDescMax = 0) then
           retProdBusca.DescMaxCalc := retProdBusca.GrupoDescMax;

         if (retProdBusca.GrupoDescMax >= 0) and
              (retProdBusca.GruSubDescMax > 0) then
           retProdBusca.DescMaxCalc:= retProdBusca.GruSubDescMax;
       end;
     end;
     //
     edNompro.Text := retProdBusca.Despro;
     edNompro.Tag  := retProdBusca.IDProd;
     edFabr.Text   := retProdBusca.Nomefab;
     edQtdped.AsFloat:= 1;
     edVlrVenda.AsFloat:= retProdBusca.PrecoVen;
     edQtdpedExit(edQtdped);
     //
     edQtdped.SetFocus;
   end;

end;

procedure TFrmVendas.AplicaRegrasDesconto(IDFilial, IDPess, IDConv: Integer; var prod: TArqPedidoIte);
var
  Query: TRESTDWClientSQL;
  dataDeHoje, filtroDia: String;
  DiaSemana: Integer;
  // Variáveis para encontrar a regra com maior prioridade
  MelhorPrioridade: Integer;
  MelhorIDDesc: Integer;
  PrioridadeAtual: Integer;
  RegraEncontrada: Boolean;

  // Função para validar e aplicar uma regra específica
  function ValidaEAplicaRegra(IDDesconto: Integer; Prioridade: Integer): Boolean;
  var
    QueryAux: TRESTDWClientSQL;
    sql: String;
  begin
    Result := False;

    QueryAux := TRESTDWClientSQL.Create(nil);
    try
      //QueryAux.BinaryRequest:= True;
      QueryAux.DataBase := DM.DWDataBase;

      // Constrói SQL para validar a regra específica
      sql := 'SELECT des.IDDesc, des.PerDesc as TabDesc, des.DesDesc, ' +
             '  (SELECT COUNT(*) FROM arqdesccli WHERE IDDesc = des.IDDesc) as PossuiCliente, ' +
             '  (SELECT COUNT(*) FROM arqdesccon WHERE IDDesc = des.IDDesc) as PossuiConvenio, ' +
             '  (SELECT COUNT(*) FROM arqdescgru WHERE IDDesc = des.IDDesc) as PossuiGrupo, ' +
             '  (SELECT COUNT(*) FROM arqdescsub WHERE IDDesc = des.IDDesc) as PossuiSubGrupo, ' +
             '  (SELECT COUNT(*) FROM arqdescfab WHERE IDDesc = des.IDDesc) as PossuiFabricante, ' +
             '  (SELECT COUNT(*) FROM arqdescpro WHERE IDDesc = des.IDDesc) as PossuiProdutos ';

      // Se tem produtos específicos, busca as informações do produto
      if Query.FieldByName('PossuiProdutos').AsInteger >= 1 then
        sql := sql + ', pro.IDProd, pro.PerDesc, pro.PrecoEsp '
      else
        sql := sql + ', 0 as IDProd, 0 as PerDesc, 0 as PrecoEsp ';

      sql := sql + 'FROM arqdesconto des ';

      // Adiciona JOINs necessários baseado no que a regra possui
      if Query.FieldByName('PossuiProdutos').AsInteger >= 1 then
        sql := sql + 'LEFT JOIN arqdescpro pro ON pro.IDDesc = des.IDDesc AND pro.IDProd = ' + prod.IDProd.ToString + ' ';

      sql := sql + 'WHERE des.IDDesc = ' + IDDesconto.ToString;

      // Valida se a regra se aplica aos parâmetros
      sql := sql + ' AND EXISTS (SELECT 1 FROM arqdesconto d WHERE d.IDDesc = des.IDDesc ';

      // Validações de Cliente
      if Query.FieldByName('PossuiCliente').AsInteger >= 1 then
      begin
        if IDPess > 0 then
          sql := sql + ' AND EXISTS (SELECT 1 FROM arqdesccli WHERE IDDesc = d.IDDesc AND IDPess = ' + IDPess.ToString + ') '
        else
        begin
          QueryAux.Close;
          FreeAndNil(QueryAux);
          Exit(False); // Cliente requerido mas não informado
        end;
      end;

      // Validações de Convênio
      if Query.FieldByName('PossuiConvenio').AsInteger >= 1 then
      begin
        if IDConv > 0 then
          sql := sql + ' AND EXISTS (SELECT 1 FROM arqdesccon WHERE IDDesc = d.IDDesc AND IDConv = ' + IDConv.ToString + ') '
        else
        begin
          QueryAux.Close;
          FreeAndNil(QueryAux);
          Exit(False); // Convênio requerido mas não informado
        end;
      end;

      // Validações de Grupo
      if Query.FieldByName('PossuiGrupo').AsInteger >= 1 then
        sql := sql + ' AND EXISTS (SELECT 1 FROM arqdescgru WHERE IDDesc = d.IDDesc AND IDGrupo = ' + prod.IDGrupo.ToString + ') ';

      // Validações de SubGrupo
      if Query.FieldByName('PossuiSubGrupo').AsInteger >= 1 then
        sql := sql + ' AND EXISTS (SELECT 1 FROM arqdescsub WHERE IDDesc = d.IDDesc AND IDGruSub = ' + prod.IDGruSub.ToString + ') ';

      // Validações de Fabricante
      if Query.FieldByName('PossuiFabricante').AsInteger >= 1 then
        sql := sql + ' AND EXISTS (SELECT 1 FROM arqdescfab WHERE IDDesc = d.IDDesc AND IDPess = ' + prod.IDFabr.ToString + ') ';

      // Validações de Produto
      if Query.FieldByName('PossuiProdutos').AsInteger >= 1 then
        sql := sql + ' AND EXISTS (SELECT 1 FROM arqdescpro WHERE IDDesc = d.IDDesc AND IDProd = ' + prod.IDProd.ToString + ') ';

      sql := sql + ')';

      QueryAux.SQL.Text := sql;
      QueryAux.Open;

      if not QueryAux.Eof then
      begin
        Result := True;
        prod.IDDesc := QueryAux.FieldByName('IDDesc').AsInteger;

        // Aplica o desconto
        if QueryAux.FieldByName('PossuiProdutos').AsInteger >= 1 then
        begin
          if QueryAux.FieldByName('PerDesc').AsFloat > 0 then
          begin
            // Percentual específico do produto
            prod.PerDesc := QueryAux.FieldByName('PerDesc').AsFloat;
            prod.VlrDesc := Roundx((prod.PrecoVen * prod.PerDesc) / 100, 2);
            prod.VlrVenda := prod.PrecoVen - prod.VlrDesc;
          end
          else if QueryAux.FieldByName('PrecoEsp').AsFloat > 0 then
          begin
            // Preço especial definido
            prod.VlrVenda := QueryAux.FieldByName('PrecoEsp').AsFloat;
            prod.VlrDesc := prod.PrecoVen - prod.VlrVenda;
            prod.PerDesc := Roundx((prod.VlrDesc * 100) / prod.PrecoVen, 2);
          end
          else if QueryAux.FieldByName('TabDesc').AsFloat > 0 then
          begin
            // Usa o desconto geral da tabela
            prod.PerDesc := QueryAux.FieldByName('TabDesc').AsFloat;
            prod.VlrDesc := Roundx((prod.PrecoVen * prod.PerDesc) / 100, 2);
            prod.VlrVenda := prod.PrecoVen - prod.VlrDesc;
          end;
        end
        else if QueryAux.FieldByName('TabDesc').AsFloat > 0 then
        begin
          // Desconto geral da regra
          prod.PerDesc := QueryAux.FieldByName('TabDesc').AsFloat;
          prod.VlrDesc := Roundx((prod.PrecoVen * prod.PerDesc) / 100, 2);
          prod.VlrVenda := prod.PrecoVen - prod.VlrDesc;
        end;
      end;

      QueryAux.Close;
    finally
      FreeAndNil(QueryAux);
    end;
  end;

begin
  // Inicializa os campos de desconto
  prod.IDProm := 0;
  prod.IDDesc := 0;
  prod.PerDesc := 0;
  prod.VlrDesc := 0;
  prod.VlrVenda := prod.PrecoVen;
  prod.FormFpgCod := '';

  Query := TRESTDWClientSQL.Create(nil);
  try
    //Query.BinaryRequest:= True;
    Query.DataBase := DM.DWDataBase;

    dataDeHoje := FormatDateTime('yyyy-mm-dd hh:mm:ss', DataServer);
    DiaSemana := DayOfWeek(DataServer);

    // Busca TODAS as regras de desconto ativas no período
    Query.SQL.Text :=
      'SELECT DISTINCT des.IDDesc, des.DesDesc, des.DataON, des.DataOFF, des.PerDesc as TabDesc, ' +
      '  IndSeg, IndTer, IndQua, IndQui, IndSex, IndSab, IndDom, ' +
      '  IndVenDin, IndVenPix, IndVenDeb, IndVenCre, IndVenPra, IndVenChe, IndVenCon, IndVenVou, ' +
      '  Prioridade, ' +
      '  (SELECT COUNT(*) FROM arqdescontopgr WHERE IDDesc = des.IDDesc) as PossuiProgressivo, ' +
      '  (SELECT COUNT(*) FROM arqdesccli WHERE IDDesc = des.IDDesc) as PossuiCliente, ' +
      '  (SELECT COUNT(*) FROM arqdesccon WHERE IDDesc = des.IDDesc) as PossuiConvenio, ' +
      '  (SELECT COUNT(*) FROM arqdescgru WHERE IDDesc = des.IDDesc) as PossuiGrupo, ' +
      '  (SELECT COUNT(*) FROM arqdescsub WHERE IDDesc = des.IDDesc) as PossuiSubGrupo, ' +
      '  (SELECT COUNT(*) FROM arqdescfab WHERE IDDesc = des.IDDesc) as PossuiFabricante, ' +
      '  (SELECT COUNT(*) FROM arqdescpro WHERE IDDesc = des.IDDesc) as PossuiProdutos ' +
      'FROM arqdesconto des ' +
      'WHERE ' + QuotedStr(dataDeHoje) + ' BETWEEN des.DataON AND IFNULL(des.DataOFF, ' +
      QuotedStr('9999-12-31 23:59:59') + ') ' +
      'order by Prioridade';
    Query.Open;

    // Aplica filtro do dia da semana
    case DiaSemana of
      1: filtroDia := 'IndDom=' + QuotedStr('1');
      2: filtroDia := 'IndSeg=' + QuotedStr('1');
      3: filtroDia := 'IndTer=' + QuotedStr('1');
      4: filtroDia := 'IndQua=' + QuotedStr('1');
      5: filtroDia := 'IndQui=' + QuotedStr('1');
      6: filtroDia := 'IndSex=' + QuotedStr('1');
      7: filtroDia := 'IndSab=' + QuotedStr('1');
    end;

    Query.Filtered := False;
    Query.Filter := filtroDia;
    Query.Filtered := True;

    PrioridadeAtual := 0;
    MelhorPrioridade := 0;
    MelhorIDDesc := 0;
    RegraEncontrada := False;

    while not Query.Eof do
    begin
      // Prioridade desta regra vem do Cadastro de Descontos
      PrioridadeAtual := Query.FieldByName('Prioridade').AsInteger;

      // Se tem prioridade válida e é maior que a melhor encontrada
      if (PrioridadeAtual > 0) and (PrioridadeAtual > MelhorPrioridade) then
      begin
        // Valida se a regra realmente se aplica
        if ValidaEAplicaRegra(Query.FieldByName('IDDesc').AsInteger, PrioridadeAtual) then
        begin
          MelhorPrioridade := PrioridadeAtual;
          MelhorIDDesc := Query.FieldByName('IDDesc').AsInteger;
          RegraEncontrada := True;

          // Salva as formas de pagamento aceitas
          prod.FormFpgCod := '';
          if Query.FieldByName('IndVenDin').AsString = '1' then prod.FormFpgCod := prod.FormFpgCod + iif(prod.FormFpgCod = EmptyStr, '01', ',01');
          if Query.FieldByName('IndVenDeb').AsString = '1' then prod.FormFpgCod := prod.FormFpgCod + iif(prod.FormFpgCod = EmptyStr, '02', ',02');
          if Query.FieldByName('IndVenCre').AsString = '1' then prod.FormFpgCod := prod.FormFpgCod + iif(prod.FormFpgCod = EmptyStr, '03', ',03');
          if Query.FieldByName('IndVenChe').AsString = '1' then prod.FormFpgCod := prod.FormFpgCod + iif(prod.FormFpgCod = EmptyStr, '04', ',04');
          if Query.FieldByName('IndVenPra').AsString = '1' then prod.FormFpgCod := prod.FormFpgCod + iif(prod.FormFpgCod = EmptyStr, '05', ',05');
          if Query.FieldByName('IndVenPix').AsString = '1' then prod.FormFpgCod := prod.FormFpgCod + iif(prod.FormFpgCod = EmptyStr, '07', ',07');
          if Query.FieldByName('IndVenVou').AsString = '1' then prod.FormFpgCod := prod.FormFpgCod + iif(prod.FormFpgCod = EmptyStr, '09', ',09');

          // Verifica se é desconto progressivo
          if Query.FieldByName('PossuiProgressivo').AsInteger > 0 then
          begin
            if not FTabDescProgr.ExisteTabIdDesc(prod.IDDesc) then
              CarregaDescProgr(prod.IDDesc);
          end;
        end;
      end;

      Query.Next;
    end;

    Query.Close;
  finally
    FreeAndNil(Query);
  end;
end;

procedure TFrmVendas.CarregaDescProgr(IDDesc: Integer);
var
  QueryPgr: TRESTDWClientSQL;
begin
   QueryPgr := TRESTDWClientSQL.Create(nil);
   //QueryPgr.BinaryRequest:= True;
   QueryPgr.DataBase := DM.DWDataBase;

   QueryPgr.SQL.Text := Format('select IDDesc, Vlrlim, PerDesc from arqdescontopgr ' +
                               ' where IDDesc = %s ' +
                               ' order by Vlrlim ',
                         [IDDesc.ToString]);
   QueryPgr.Open;
   while not QueryPgr.Eof do
   begin
     FTabDescProgr.AddLimDescProg(QueryPgr.FieldByName('IDDesc').AsInteger,
                                     QueryPgr.FieldByName('Vlrlim').AsCurrency,
                                       QueryPgr.FieldByName('PerDesc').AsCurrency);
     //
     QueryPgr.Next;
   end;
   QueryPgr.Close;
   QueryPgr.Free;
end;

procedure TFrmVendas.AplicaRegrasPromocao(IDFilial, IDPess, IDConv: Integer; var prod: TArqPedidoIte);
var
  Query: TRESTDWClientSQL;
  dataDeHoje: String;
  DiaSemana: Integer;
  bValidaPossuiProgr, bValidaCliente, bValidaConvenio, bValidaFormasPagto, bValidaFilial, bValidaProduto: Boolean;
  PromocaoValida: Boolean;
  idProm: Integer;
  tmpFormasPagto: String;

  function ValidaFormasFpgCod(idProm: Integer): String;
  var
    qry: TRESTDWClientSQL;
  begin
    Result:= EmptyStr;

    try
      qry:= CreateSQL(DM.DWDataBase,
                   'select IDForPag from arqpromofpg where IDProm = :IDProm',
                   [idProm.ToString]);
      qry.Open;
      while not qry.Eof do
      begin
        if Result = EmptyStr then
          Result:= FormatFloat('00', qry.FieldByName('IDForPag').AsInteger)
        else
          Result:= Result+','+FormatFloat('00', qry.FieldByName('IDForPag').AsInteger);
        //
        qry.Next;
      end;

    finally
      qry.Free;
    end;

  end;

  function ValidaFilial(idProm, idFilial: Integer): Boolean;
  var
    qry: TRESTDWClientSQL;
  begin
    Result:= True;

    try
      qry:= CreateSQL(DM.DWDataBase,
                   'select 1 from arqpromofil where IDProm = :IDProm and  IDFilial = :IDFilial LIMIT 1',
                   [idProm.ToString, idFilial.ToString]);
      qry.Open;
      if qry.IsEmpty then
        Result:= False;
    finally
      qry.Free;
    end;
  end;

  function ValidaCliente(idProm, idPess: Integer): Boolean;
  var
    qry: TRESTDWClientSQL;
  begin
    Result:= True;

    try
      qry:= CreateSQL(DM.DWDataBase,
                   'select 1 from arqpromocli where IDProm = :IDProm and  IDPess = :IDPess LIMIT 1',
                   [idProm.ToString, idPess.ToString]);
      qry.Open;
      if qry.IsEmpty then
        Result:= False;
    finally
      qry.Free;
    end;
  end;

  function ValidaConvenio(idProm, idConv, idPess: Integer): Boolean;
  var
    qry: TRESTDWClientSQL;
  begin
    Result:= True;

    try
      qry:= CreateSQL(DM.DWDataBase,
                   'select 1 from arqpromocon con ' +
                   'left join arqpessconv pes on pes.IDConv = con.IDConv ' +
                   'where con.IDProm = :IDProm and con.IDConv = :IDConv and pes.IDPess = :IDPess LIMIT 1',
                   [idProm.ToString, idConv.ToString, idPess.ToString]);
      qry.Open;
      if qry.IsEmpty then
        Result:= False;
    finally
      qry.Free;
    end;
  end;

  function ValidaProduto(idProm, idProd: Integer): Boolean;
  var
    qry: TRESTDWClientSQL;
  begin
    Result:= True;

    try
      qry:= CreateSQL(DM.DWDataBase,
                   'select 1 from arqpromopro where IDProm = :idProm and IDProd = :idProd LIMIT 1',
                   [idProm.ToString, idProd.ToString]);
      qry.Open;
      if qry.IsEmpty then
        Result:= False;
    finally
      qry.Free;
    end;
  end;

  function ValidaProdutoProgr(idProm, idProd: Integer): Boolean;
  var
    qry: TRESTDWClientSQL;
  begin
    Result:= True;

    try
      qry:= CreateSQL(DM.DWDataBase,
                   'select 1 from arqpromopgr where IDProm = :idProm and IDProd = :idProd LIMIT 1',
                   [idProm.ToString, idProd.ToString]);
      qry.Open;
      if qry.IsEmpty then
        Result:= False;
    finally
      qry.Free;
    end;
  end;

begin
  bValidaPossuiProgr:= False;
  bValidaFilial:= False;
  bValidaFormasPagto:= False;
  bValidaCliente:= False;
  bValidaConvenio:= False;
  bValidaProduto:= False;
  //
  Query := TRESTDWClientSQL.Create(nil);
  //Query.BinaryRequest:= True;
  Query.DataBase := DM.DWDataBase;
  try
    dataDeHoje := FormatDateTime('yyyy-mm-dd hh:mm:ss', DataServer); // Pega data atualizada do Servidor

    // Pega dia da Semana
    // 1-Domingo, 2-Segunda, 3-Terça, 4-Quarta, 5-Quinta, 6-Sexta, 7-Sábado
    DiaSemana := DayOfWeek(DataServer);

    // #1 – Promoção prevalece sobre todas as regras (desde que esteja liberado no convênio/cliente)
    // # Fazendo o desconto normal
    // # Tiver convênio deve ser apenas os clientes destes convênios
    // # Se Não tiver é tudo

    Query.SQL.Text :=
    Format('SELECT prm.IDProm, prm.Desprom, prm.DataON, prm.DataOFF, prm.DiaSema, prm.ManPre, prm.TipoProm, prm.DatVenLot, prm.IndAtivo, '+
    '  (select count(*) from arqpromopgr pgr where pgr.idprom = prm.idprom) as PossuiProgr, '+
    '  (select count(*) from arqpromocli cli where cli.idprom = prm.idprom) as PossuiCliente, '+
    '  (select count(*) from arqpromocon con where con.idprom = prm.idprom) as PossuiConvenio, '+
    '  (select count(*) from arqpromofpg fpg where fpg.idprom = prm.idprom) as PossuiFormasPagto, '+
    '  (select count(*) from arqpromofil fil where fil.idprom = prm.idprom) as PossuiFiliais, '+
    '  (select count(*) from arqpromopro pro where pro.idprom = prm.idprom) as PossuiProdutos '+
    ' FROM arqpromocao prm '+
    ' WHERE %s BETWEEN prm.DataON AND IFNULL(prm.DataOFF, '+QuotedStr('9999-12-31 23:59:59')+' ) ' +  // Caso Data Final da promoção seja NULL
    ' AND prm.IndAtivo = 1 '+                                                                         // Traz Maior data válida do banco
    ' AND FIND_IN_SET( %s , prm.DiaSema) > 0 '+
    'order by PossuiCliente desc, PossuiConvenio desc, PossuiFiliais, PossuiProdutos',
    [QuotedStr(dataDeHoje), DiaSemana.ToString] );

    //Query.SQL.SaveToFile('C:\Temp\QueryPromo.SQL');
    Query.Open;
    //
    while not Query.Eof do
    begin
      if not(Query.IsEmpty) then
      begin
        idProm:= Query.FieldByName('IDProm').AsInteger;

        bValidaPossuiProgr:= False;
        bValidaFilial     := False;
        bValidaCliente    := False;
        bValidaConvenio   := False;
        bValidaProduto    := False;
        bValidaFormasPagto:= False;

        if Query.FieldByName('PossuiProgr').AsInteger >= 1 then
          bValidaPossuiProgr:= True;
        if Query.FieldByName('PossuiFiliais').AsInteger >= 1 then
          bValidaFilial:= True;
        if Query.FieldByName('PossuiCliente').AsInteger >= 1 then
          bValidaCliente:= True;
        if Query.FieldByName('PossuiConvenio').AsInteger >= 1 then
          bValidaConvenio:= True;
        if Query.FieldByName('PossuiProdutos').AsInteger >= 1 then
          bValidaProduto:= True;
        if Query.FieldByName('PossuiFormasPagto').AsInteger >= 1 then
          bValidaFormasPagto:= True;
      end;
      //
      PromocaoValida:= True;

      tmpFormasPagto:= FFormasPagtoDisp;
      if bValidaFormasPagto then
        tmpFormasPagto:= ValidaFormasFpgCod(idProm);

      if PromocaoValida and bValidaFilial then
        PromocaoValida:= ValidaFilial(idProm, FILIAL);

      if PromocaoValida and bValidaCliente then
        if (IDPess > 0) then
          PromocaoValida:= ValidaCliente(idProm, IDPess)
        else
          PromocaoValida:= False;

      if PromocaoValida and bValidaConvenio then
        if (IDPess > 0) and (IDConv > 0) then
          PromocaoValida:= ValidaConvenio(idProm, IDConv, IDPess)
        else
          PromocaoValida:= False;

      if PromocaoValida then
      begin
        if bValidaProduto then
        begin
          if (prod.IDProd > 0) then
          begin
            if bValidaPossuiProgr then
              PromocaoValida:= ValidaProdutoProgr(idProm, prod.IDProd)
            else
              PromocaoValida:= ValidaProduto(idProm, prod.IDProd);
          end else
          begin
            PromocaoValida:= False;
          end;
        end;
      end;

      if PromocaoValida then
      begin
        prod.FormFpgCod:= tmpFormasPagto;
        //
        if bValidaProduto and bValidaCliente then                            // #PRODUTOS CLIENTE
          PromoDescPorCliente(idProm, IDPess, prod)
        else if bValidaProduto and bValidaConvenio and bValidaCliente then   // #PRODUTOS CONVÊNIO CLIENTE
          PromoDescPorConvenio(idProm, IDPess, IDConv, prod)
        else if bValidaProduto then                                          // #PRODUTOS
        begin
          PromoDescPorProduto(idProm, prod);
        end else
        begin
          PromoDescPorProdutoProg(idProm, prod);
        end;
      end;

      if prod.IDProm > 0 then
        break;
      //
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;

end;

procedure TFrmVendas.PromoDescPorCliente(IDProm, IDPess: Integer; var prod: TArqPedidoIte);
var
  qry: TRESTDWClientSQL;
begin
  try
    qry:= CreateSQL(DM.DWDataBase,
                 'SELECT pro.IDProm, pro.IDProd, pro.Nrolot, pro.Qtdest, pro.PrecoVen, pro.Cusmed, pro.UltPreCom, pro.PerDesIA, pro.PerDesMan, pro.PrePromo, pro.IndSel '+
                 'FROM arqpromocao prm '+
                 'inner join arqpromopro pro on pro.idprom = prm.idprom '+
                 'inner join arqpromocli cli on cli.idprom = prm.idprom '+
                 'where prm.IDProm = :IDProm '+
                 '  and cli.IDpess = :IDpess '+
                 '  and pro.IDProd = :IDProd',
                 [idProm.ToString, IDPess.ToString, prod.IDProd.ToString]);
    qry.Open;
    if not(qry.IsEmpty) then
    begin
       prod.IDProm:= idProm;
       prod.IDDesc:= 0;
       //
       prod.PrecoUni:= qry.FieldByName('PrecoVen').AsFloat;
       prod.CustoMed:= qry.FieldByName('Cusmed').AsFloat;
       if qry.FieldByName('PerDesMan').AsCurrency <> 0 then
       begin
         prod.PrecoVen:= qry.FieldByName('PrecoVen').AsFloat;
         prod.PerDesc:= qry.FieldByName('PerDesMan').AsFloat;
         prod.VlrDesc:= qry.FieldByName('PrecoVen').AsFloat - qry.FieldByName('PerDesMan').AsFloat;
         prod.VlrVenda:= qry.FieldByName('PrePromo').AsFloat;
       end else
       begin
         prod.PrecoVen:= qry.FieldByName('PrecoVen').AsFloat;
         prod.PerDesc:= qry.FieldByName('PerDesIA').AsFloat;
         prod.VlrDesc:= qry.FieldByName('PrecoVen').AsFloat - qry.FieldByName('PrePromo').AsFloat;
         prod.VlrVenda:= qry.FieldByName('PrePromo').AsFloat;
       end;
       // pro.PerDesIA, pro.PerDesMan, pro.PrePromo
    end;
    qry.Close;
  finally
    qry.Free;
  end;
end;

procedure TFrmVendas.PromoDescPorConvenio(IDProm, IDConv, IDPess: Integer; var prod: TArqPedidoIte);
var
  qry: TRESTDWClientSQL;
begin
  try
    qry:= CreateSQL(DM.DWDataBase,
                 'SELECT pro.IDProm, pro.IDProd, pro.Nrolot, pro.Qtdest, pro.PrecoVen, pro.Cusmed, pro.UltPreCom, pro.PerDesIA, pro.PerDesMan, pro.PrePromo, pro.IndSel '+
                 'FROM arqpromocao prm '+
                 'inner join arqpromopro pro on pro.idprom = prm.idprom '+
                 'inner join arqpromocon con on con.idprom = prm.idprom '+
                 'inner join arqpessconv pes on pes.IDConv = con.IDConv '+
                 'where prm.IDProm = :IDProm '+
                 '  and con.IDConv = :IDConv '+
                 '  and pes.IDpess = :IDpess '+
                 '  and pro.IDProd = :IDProd',
                 [IDProm.ToString, IDConv.ToString, IDPess.ToString, prod.IDProd.ToString]);
    qry.Open;
    if not(qry.IsEmpty) then
    begin
       prod.IDProm:= idProm;
       prod.IDDesc:= 0;
       //
       prod.PrecoUni:= qry.FieldByName('PrecoVen').AsFloat;
       prod.CustoMed:= qry.FieldByName('Cusmed').AsFloat;
       if qry.FieldByName('PerDesMan').AsCurrency <> 0 then
       begin
         prod.PrecoVen:= qry.FieldByName('PrecoVen').AsFloat;
         prod.PerDesc:= qry.FieldByName('PerDesMan').AsFloat;
         prod.VlrDesc:= qry.FieldByName('PrecoVen').AsFloat - qry.FieldByName('PerDesMan').AsFloat;
         prod.VlrVenda:= qry.FieldByName('PrePromo').AsFloat;
       end else
       begin
         prod.PrecoVen:= qry.FieldByName('PrecoVen').AsFloat;
         prod.PerDesc:= qry.FieldByName('PerDesIA').AsFloat;
         prod.VlrDesc:= qry.FieldByName('PrecoVen').AsFloat - qry.FieldByName('PrePromo').AsFloat;
         prod.VlrVenda:= qry.FieldByName('PrePromo').AsFloat;
       end;
       // pro.PerDesIA, pro.PerDesMan, pro.PrePromo
    end;
    qry.Close;
  finally
    qry.Free;
  end;
end;

procedure TFrmVendas.PromoDescPorProduto(IDProm: Integer; var prod: TArqPedidoIte);
var
  qry: TRESTDWClientSQL;
begin
  try
    qry:= CreateSQL(DM.DWDataBase,
                 'SELECT pro.IDProm, pro.IDProd, pro.Nrolot, pro.Qtdest, pro.PrecoVen, pro.Cusmed, pro.UltPreCom, pro.PerDesIA, pro.PerDesMan, pro.PrePromo, pro.IndSel ' +
                 'FROM arqpromocao prm ' +
                 'inner join arqpromopro pro on pro.idprom = prm.idprom ' +
                 'where prm.IDProm = :IDProm ' +
                 '  and pro.IDProd = :IDProd',
                 [IDProm.ToString, prod.IDProd.ToString]);
    qry.Open;
    if not(qry.IsEmpty) then
    begin
       prod.IDProm:= idProm;
       prod.IDDesc:= 0;
       //
       prod.PrecoUni:= qry.FieldByName('PrecoVen').AsFloat;
       prod.CustoMed:= qry.FieldByName('Cusmed').AsFloat;
       if qry.FieldByName('PerDesMan').AsCurrency <> 0 then
       begin
         prod.PrecoVen:= qry.FieldByName('PrecoVen').AsFloat;
         prod.PerDesc:= qry.FieldByName('PerDesMan').AsFloat;
         prod.VlrDesc:= qry.FieldByName('PrecoVen').AsFloat - qry.FieldByName('PerDesMan').AsFloat;
         prod.VlrVenda:= qry.FieldByName('PrePromo').AsFloat;
       end else
       begin
         prod.PrecoVen:= qry.FieldByName('PrecoVen').AsFloat;
         prod.PerDesc:= qry.FieldByName('PerDesIA').AsFloat;
         prod.VlrDesc:= qry.FieldByName('PrecoVen').AsFloat - qry.FieldByName('PrePromo').AsFloat;
         prod.VlrVenda:= qry.FieldByName('PrePromo').AsFloat;
       end;
       // pro.PerDesIA, pro.PerDesMan, pro.PrePromo
    end;
    qry.Close;
  finally
    qry.Free;
  end;
end;

procedure TFrmVendas.PromoDescPorProdutoProg(IDProm: Integer; var prod: TArqPedidoIte);
var
  qry: TRESTDWClientSQL;
begin

  if not FTabPromProgr.ExisteTabIdProd(IDProm, prod.IDProd) then
  begin
    try
      qry:= CreateSQL(DM.DWDataBase,
                   'SELECT g.IDProm, g.IDProd, g.Qtdven, g.PreVenda, p.PrecoVen, ' +
                   '       ROUND(((p.PrecoVen - g.PreVenda) * 100) / p.PrecoVen, 2) AS PerDesc ' +
                   'FROM arqpromopgr g ' +
                   'LEFT JOIN arqproduto p ON p.IDProd = g.IDProd ' +
                   'WHERE g.IDProm = :IDProm ' +
                   '  AND g.IDProd = :IDProd ' +
                   'ORDER BY g.IDProm, g.IDProd, g.Qtdven ',
                   [IDProm.ToString, prod.IDProd.ToString]);

      qry.Open;
      if not(qry.IsEmpty) then
      begin
        prod.IDProm:= IDProm;
        prod.IDDesc:= 0;

        while not qry.Eof do
        begin
           FTabPromProgr.AddPromProg(qry.FieldByName('IDProm').AsInteger,
                                      qry.FieldByName('IDProd').AsInteger,
                                        qry.FieldByName('Qtdven').AsCurrency,
                                          qry.FieldByName('PreVenda').AsCurrency,
                                            qry.FieldByName('PrecoVen').AsCurrency,
                                              qry.FieldByName('PerDesc').AsCurrency);
           //
           qry.Next;
        end;
        /////////////////////////////////////////////////
        //prod.PrecoUni:= qry.FieldByName('PrecoVen').AsFloat;
        //prod.CustoMed:= qry.FieldByName('Cusmed').AsFloat;

        //prod.PrecoVen:= qry.FieldByName('PrecoVen').AsFloat;
        //prod.PerDesc := qry.FieldByName('PerDesIA').AsFloat;
        //prod.VlrDesc := qry.FieldByName('PrecoVen').AsFloat - qry.FieldByName('PrePromo').AsFloat;
        //prod.VlrVenda:= FTabPromProgr.PegaVlrVen(IDProm, prod.IDProd, 1);
        /////////////////////////////////////////////////
      end;
      qry.Close;
    finally
      qry.Free;
    end;
  end else
  begin
    prod.IDProm:= IDProm;
    prod.IDDesc:= 0;
  end;

  if FTabPromProgr.ExisteTabIdProd(IDProm, prod.IDProd) then
  begin
    retProdBusca.VlrVenda:= FTabPromProgr.PegaVlrVen(retProdBusca.IDProm, retProdBusca.IDProd, retProdBusca.Qtdped);
    retProdBusca.PerDesc := FTabPromProgr.PegaPerDesc(retProdBusca.IDProm, retProdBusca.IDProd, retProdBusca.Qtdped);
  end;

end;

procedure TFrmVendas.edNomproExit(Sender: TObject);
var
   soInteger:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if ExisteStr(Trim(edNompro.Text)) or (Trim(edNompro.Text) = '') then Exit;
   soInteger := OnlyNumbers(edNompro.Text);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         //BinaryRequest:= True;
         DataBase := DM.DWDataBase;
         QueAuxi.Close;
         SQL.Clear;
         SQL.Text := 'SELECT p.IDProd,p.IDFabr,p.Despro,pe.Nompes, SUM(1) AS EstTotal, '+
                     'IF(p.QtdFrac > 0, TRUNCATE(p.PrecoVen / p.QtdFrac, 2), p.PrecoVen) AS PrecoVen, ' +
                     'IF(p.QtdFrac > 0, TRUNCATE(p.PrecoPMC / p.QtdFrac, 2), p.PrecoPMC) AS PrecoPMC, ' +
                     'IF(p.QtdFrac > 0, TRUNCATE(p.PrecoFP / p.QtdFrac, 2), p.PrecoFP) AS PrecoFP, ' +
                     'IF(p.QtdFrac > 0, TRUNCATE(p.PrecoFab / p.QtdFrac, 2), p.PrecoFab) AS PrecoFab, ' +
                     'IF(p.QtdFrac > 0, TRUNCATE(p.CustoMed / p.QtdFrac, 2), p.CustoMed) AS CustoMed, ' +
                     'p.IndBloDes, p.UsoRece, p.QtdFrac, GROUP_CONCAT(DISTINCT ss.DesSubs SEPARATOR ", ") AS DesSubs, ' +
                     'p.IDGrupo, g.Desgru, g.DescMax as GrupoDescMax, ' +
                     'p.IDGruSub, s.DesgruSub, s.DescMax as GruSubDescMax, LOC.Desloc ' +
                     'FROM arqproduto p ' +
                     'left join arqpessoa pe      on p.IDFabr    = pe.IDPess ' +
                     'left join arqprodutosub ps  ON ps.IDProd   = p.IDProd ' +
                     'left join arqsubstancia ss  ON ss.IDSubs   = ps.IDSubs ' +
                     'left join arqgrupo g        on  g.IDGrupo  = p.IDGrupo ' +
                     'left join arqgruposub s     on  s.IDGruSub = p.IDGruSub ' +
                     'left join arqlocesto LOC    on  LOC.IDLoc  = p.IDLoc ';

         if soInteger <> '' then
         begin
            if soInteger.Length > 11 then
              SQL.Add('LEFT JOIN arqprodutoean EAN ON p.IDProd = EAN.IDProd WHERE p.CodEANpri = '+Aspas(soInteger)+' OR EAN.CodEAN = '+Aspas(soInteger))
            else
              SQL.Add('WHERE P.IDProd = '+soInteger);
         end; //if
         SQL.Add(' GROUP BY p.IDProd,p.Despro,pe.Nompes ORDER BY p.Despro LIMIT 200');
         //QueAuxi.SQL.SaveToFile('C:\Temp\QueAuxi.SQL');
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            retProdBusca.IDFilial:= FILIAL;
            retProdBusca.IDPed:= 0;
            retProdBusca.Nroite:= 0;
            retProdBusca.IDProd:= FieldByName('IDProd').AsInteger;
            retProdBusca.Nrolot:= '';
            retProdBusca.IDVend:= 0;
            retProdBusca.IndComi:= 1;

            retProdBusca.PrecoVen:= FieldByName('PrecoVen').AsFloat;
            retProdBusca.PrecoUni:= FieldByName('PrecoVen').AsFloat;

            retProdBusca.PrecoPMC:= FieldByName('PrecoPMC').AsFloat;
            retProdBusca.PrecoFP := FieldByName('PrecoFP').AsFloat;
            retProdBusca.PrecoFab:= FieldByName('PrecoFab').AsFloat;
            retProdBusca.CustoMed:= FieldByName('CustoMed').AsFloat;
            retProdBusca.VlrPIS  := 0;
            retProdBusca.VlrCOF  := 0;
            retProdBusca.Qtdped  := 1;
            retProdBusca.PerDesc := 0;
            retProdBusca.VlrDesc := 0;
            retProdBusca.VlrVenda:= 0;
            retProdBusca.IndConf := '0';
            retProdBusca.UsoRece := FieldByName('UsoRece').AsString;
            retProdBusca.Despro  := FieldByName('Despro').AsString;
            retProdBusca.IDFabr  := FieldByName('IDFabr').AsInteger;
            retProdBusca.Nomefab := FieldByName('Nompes').AsString;
            retProdBusca.EstTotal:= FieldByName('EstTotal').AsFloat;
            //
            retProdBusca.IndBloDes     := (FieldByName('IndBloDes').AsString='1');
            retProdBusca.IDGrupo       := FieldByName('IDGrupo').AsInteger;
            retProdBusca.Desgru        := FieldByName('Desgru').AsString;
            retProdBusca.GrupoDescMax  := FieldByName('GrupoDescMax').AsFloat;
            retProdBusca.DesgruSub     := FieldByName('DesgruSub').AsString;
            retProdBusca.IDGruSub      := FieldByName('IDGruSub').AsInteger;
            retProdBusca.GruSubDescMax := FieldByName('GruSubDescMax').AsFloat;

            retProdBusca.DesSubs       := FieldByName('DesSubs').AsString;
            retProdBusca.Desloc        := FieldByName('Desloc').AsString;
            //
            retProdBusca.IDProm  := 0;
            retProdBusca.IDDesc  := 0;
            //
            if retProdBusca.IDProd > 0 then
            begin
              // Cliente Possui Convênio
              if retConvenio.IDConv > 0 then
              begin
                // Convênio do Cliente Permite Preços Promocionais
                if retConvenio.IndPreProm then
                  // 1-Aplica Regras de Promoções
                  AplicaRegrasPromocao(FILIAL,
                                        TabPedidoIDPess.AsInteger, // IDPess Cliente
                                        TabPedidoIDConv.AsInteger, // IDConv Convênio
                                        retProdBusca // Dados do produto Pesquisado
                                       );
              end else
              begin
                // 1-Aplica Regras de Promoções
                AplicaRegrasPromocao(FILIAL,
                                        TabPedidoIDPess.AsInteger, // IDPess Cliente
                                        TabPedidoIDConv.AsInteger, // IDConv Convênio
                                        retProdBusca // Dados do produto Pesquisado
                                       );
              end;

              if retProdBusca.IDProm = 0 then // Se não tem promoção Pega Desconto se tiver
              begin
                // 2-Aplica Regras de Descontos
                AplicaRegrasDesconto(FILIAL,
                                 TabPedidoIDPess.AsInteger, // IDPess Cliente
                                 TabPedidoIDConv.AsInteger, // IDConv Convênio
                                 retProdBusca // Dados do produto Pesquisado
                                );

                // Calculo Desconto Progressivo
                var percDescProg: Currency := 0;
                if (retProdBusca.IDDesc > 0) and FTabDescProgr.ExisteTabIdDesc(retProdBusca.IDDesc) then
                begin
                  percDescProg:= FTabDescProgr.AddVlr(retProdBusca.IDDesc, retProdBusca.PrecoVen);

                  retProdBusca.PerDesc:= percDescProg;

                  retProdBusca.VlrDesc:= (retProdBusca.PrecoVen*retProdBusca.PerDesc)/100;
                  retProdBusca.VlrVenda:= retProdBusca.PrecoVen-retProdBusca.VlrDesc;
                  //edVlrVenda.SetValue(retProdBusca.VlrVenda);
                end;
              end;

            end;
            //
            edNompro.Tag  := FieldByName('IDProd').AsInteger;
            edNompro.Text := FieldByName('Despro').AsString;
            edFabr.Text   := FieldByName('Nompes').AsString;
            edQtdped.AsFloat:= 1;
            edVlrVenda.AsFloat:= retProdBusca.PrecoVen;
         end else
         begin
            edNompro.Text := '';
            edFabr.Text   := '';
            edNompro.Tag  := 0;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmVendas.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
  if not(ssCtrl in Shift) then
  begin
     if (Key = VK_RETURN) or (Key = VK_TAB) then
     begin
        if (Key = VK_RETURN) and (Trim(edNompro.Text) = EmptyStr) then
        begin
          edFabr.Text   := '';
          edNompro.Text := '';
          edNompro.Tag  := 0;
          Key:= 0;

          Exit;
        end;

        if Trim(edNompro.Text) = '' then Exit;
        soInteger := iif(ExisteStr(Trim(edNompro.Text)), '', OnlyNumbers(edNompro.Text));
        if soInteger = '' then
        begin
          key := 0;
          edNomproCustomButtons1Click(Self, Key);
        end else
        begin
          key := 0;
          edQtdped.SetFocus;
          edQtdpedExit(Sender);
          //if soInteger.Length > 11 then
          //  btSalvaIteClick(Sender);
        end;
     end
     else if Key = VK_ESCAPE then
     begin
        edFabr.Text   := '';
        edNompro.Text := '';
        edNompro.Tag  := 0;
     end else
     begin
       //if Trim(edNompro.Text) = '' then Exit;
       //soInteger := iif(ExisteStr(Trim(edNompro.Text)), '', OnlyNumbers(edNompro.Text));
       //if soInteger = '' then
       //begin
         edNomproCustomButtons1Click(Self, key);
         key := 0;
       //end;
     end;
  end;
end;

procedure TFrmVendas.edClieExit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if IsNumeric(edClie.Text) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         with QueAuxi do
         begin
            //BinaryRequest:= True;
            DataBase := DM.DWDataBase;

            SQL.Text := 'SELECT p.IDPess, p.Nompes FROM arqpessoa p LEFT JOIN arqpessconv C ON p.IDPess = c.IDPess '+
            'WHERE (p.IDPess = '+Aspas(edClie.Text)+' OR p.FonePes = '+Aspas(edClie.Text)+' OR CelularPes = '+Aspas(edClie.Text)+' OR '+
            'p.Nompes LIKE CONCAT("%", '+Aspas(edClie.Text)+', "%") OR p.NomfanPes LIKE CONCAT("%", '+Aspas(edClie.Text)+', "%") '+
            'OR p.CpfCnpjPes = '+Aspas(edClie.Text)+' OR c.NroMatric = '+Aspas(edClie.Text)+' OR c.NroCartao = '+Aspas(edClie.Text)+' '+
            'OR p.RGEPes = '+Aspas(edClie.Text)+') '+
            ' GROUP BY p.IDPess ORDER BY p.Nompes ';
            QueAuxi.Open;
            Application.ProcessMessages;
            if not QueAuxi.IsEmpty then
            begin
               TabPedidoIDPess.Value  := FieldByName('IDPess').AsInteger;
               TabPedidoNomeCli.Value := FieldByName('Nompes').AsString;
               edClie.Text := FieldByName('Nompes').AsString;
               edClie.Tag  := FieldByName('IDPess').AsInteger;
            end else
            begin
               MostraMsg('Aviso', 'Pessoa não encontrada!',mtWarning, [mbOk]);
               TabPedidoIDPess.Value  := 0;
               TabPedidoNomeCli.Value := '';
               edClie.Text := '';
               edClie.Tag  := 0;
               edClie.SetFocus;
            end;
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;
   //
   // Se Cliente possui apenas um convênio já seleciona o convênio
   if (TabPedidoIDPess.AsInteger > 0) and
        (TabPedidoIDConv.AsInteger = 0) then
   begin
     //retConvenio:= RetornaConvenioUnicoDoCliente(TabPedidoIDPess.AsInteger);
     retConvenio:= RetornaConvenio(TabPedidoIDPess.AsInteger);

     if retConvenio.IDConv > 0 then
     begin
       TabPedidoIDConv.AsInteger:= retConvenio.IDConv;
       TabPedidoNomcon.AsString := retConvenio.Nomcon;
       edConv.Text := retConvenio.Nomcon;
       edConv.Tag  := retConvenio.IDConv;
     end;
   end;
   //
   ReaplicaRegrasPromocaoDesconto(TabPedidoIDPess.AsInteger, TabPedidoIDConv.AsInteger);
end;

procedure TFrmVendas.edClieKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if not(ssCtrl in Shift) and not(ssShift in Shift) then
   begin
      if (key <> VK_RETURN) and (Key <> VK_ESCAPE) and (Key <> VK_INSERT) then
     begin
       edClieCustomButtons3Click(Sender, key);
       key:= 0;
     end;
     // Tecla [INS, INSERT] Incluiu Novo Cliente, Referente Botão +
     if Key = VK_INSERT then
     begin
       edClieCustomButtons1Click(Sender, 1);
     end;
     // Tecla [ESC] Zera tudo
     if Key = VK_ESCAPE then
     begin
        TLMDDBLabeledEdit(Sender).Text:= '';
        TLMDDBLabeledEdit(Sender).Tag:= 0;

        TabPedidoIDPess.AsInteger:= 0;
        TabPedidoNomeCli.AsString:= '';

        // Limpa Convênio tbm
        retConvenio.IDConv:= 0;
        retConvenio.Nomcon:= '';

        TabPedidoIDConv.AsInteger:= retConvenio.IDConv;
        TabPedidoNomcon.AsString := retConvenio.Nomcon;
        edConv.Text := retConvenio.Nomcon;
        edConv.Tag  := retConvenio.IDConv;
     end;
   end else
   begin
     //CTRL + A -> Altera dados cadastrais do cliente já selecionado
     if (Key = 65) and (ssCtrl in Shift) then
     begin
       edClieCustomButtons2Click(Sender, 2);
       key:= 0;
     end;
   end;
end;

procedure TFrmVendas.edConvCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if TabPedidoIDPess.AsInteger > 0 then
      btBuscasDB(TabPedido,'arqconvenio',TDBEdit(edConv),
        'IDConv','IDConv','Nomcon','Nomcon','COP.IndAtivo = 1 and CON.IndAtivo = 1 and COP.IDPess = '+TabPedidoIDPess.AsString,0);
end;

procedure TFrmVendas.edConvEnter(Sender: TObject);
begin
   {if TabPedidoIDPess.Value <= 0 then
   begin
      MostraMsg('Aviso', 'Favor entrar com o cliente antes!',mtWarning, [mbOk]);
      edClie.SetFocus;
      Exit;
   end;}
end;

procedure TFrmVendas.edConvExit(Sender: TObject);
begin
   // Configuração do Convênio
   if (TabPedidoIDPess.AsInteger > 0) and
        (TabPedidoIDConv.AsInteger > 0) then
   begin
     if (TabPedidoIDConv.AsInteger <> retConvenio.IDConv) and
          (TabPedidoNomcon.AsString <> retConvenio.Nomcon) then
     begin
       retConvenio:= RetornaConvenio(TabPedidoIDPess.AsInteger, TabPedidoIDConv.AsInteger);
     end;
   end;
   //
   ReaplicaRegrasPromocaoDesconto(TabPedidoIDPess.AsInteger, TabPedidoIDConv.AsInteger);
end;

procedure TFrmVendas.edConvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not(ssCtrl in Shift) and not(ssShift in Shift) then
  begin
    if (key <> VK_RETURN) and (Key <> VK_ESCAPE)  then
    begin
      if TabPedidoIDPess.AsInteger > 0 then
        btBuscasDB(TabPedido,'arqconvenio',TDBEdit(edConv),
          'IDConv','IDConv','Nomcon','Nomcon','COP.IndAtivo = 1 and CON.IndAtivo = 1 and COP.IDPess = '+TabPedidoIDPess.AsString,Key);
    end;

     if Key = VK_ESCAPE then
     begin
        retConvenio.IDConv:= 0;
        retConvenio.Nomcon:= '';

        TLMDDBLabeledEdit(Sender).Tag:= retConvenio.IDConv;
        TLMDDBLabeledEdit(Sender).Text:= retConvenio.Nomcon;

        TabPedidoIDConv.AsInteger:= retConvenio.IDConv;
        TabPedidoNomcon.AsString := retConvenio.Nomcon;
     end;
  end;
end;

// ------------- Abre Janela Análise IA de Clientes ------------- //
procedure TFrmVendas.edClieCustomButtons0Click(Sender: TObject; index: Integer);
begin
   FrmIAVenCli := TFrmIAVenCli.Create(Application);
   try
      FrmIAVenCli.ShowModal;
   finally
      FrmIAVenCli.Free;
   end;
end;

procedure TFrmVendas.edClieCustomButtons1Click(Sender: TObject; index: Integer);
var
  auxIDPess: Integer;
  auxNomeCli: String;
begin
  auxIDPess:= 0;
  auxNomeCli:= '';
  try
     FrmPesCad := TFrmPesCad.Create(Application);
     CentralizarControl(FrmPesCad, FrmVendas);
     FrmPesCad.recIDPess := -1;
     FrmPesCad.recEsppes := 1; // Cliente
     FrmPesCad.recOrigem := 'VENDA';
     FrmPesCad.recCampo  := '';
     FrmPesCad.recValor  := '';
     FrmPesCad.ShowModal;
  finally
     auxIDPess := FrmPesCad.recIDPess;
     auxNomeCli:= FrmPesCad.recNompes;
     FreeAndNil(FrmPesCad);
  end; //try
  if auxIDPess > 0 then
  begin
     TabPedidoIDPess.AsInteger:= auxIDPess;
     TabPedidoNomeCli.AsString := auxNomeCli;
  end;
end;

procedure TFrmVendas.edClieCustomButtons2Click(Sender: TObject; index: Integer);
var
   auxIDPess: Integer;
   auxNomeCli: String;
begin
   auxIDPess:= 0;
   auxNomeCli:= '';
   try
      FrmPesCad := TFrmPesCad.Create(Application);
      CentralizarControl(FrmPesCad, FrmVendas);

      if TabPedidoIDPess.AsInteger > 0 then
        FrmPesCad.recIDPess := TabPedidoIDPess.AsInteger
      else
        FrmPesCad.recIDPess := 0;

      FrmPesCad.ShowModal;
   finally
      auxIDPess := FrmPesCad.recIDPess;
      auxNomeCli:= FrmPesCad.recNompes;
      FrmPesCad := nil;
   end;

   if auxIDPess > 0 then
   begin
     // TabPedidoIDPess.AsInteger:= auxIDPess;  --> Alteração de dados cadastrais não altera IDPess
     if TabPedidoNomeCli.AsString <> auxNomeCli then // Caso tenha alterado nome
       TabPedidoNomeCli.AsString:= auxNomeCli;
   end;
end;

procedure TFrmVendas.edClieCustomButtons3Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   //btBuscasDB(TabPedido,'arqpessoa',TDBEdit(edClie),'IDPess','IDPess','Nompes','NomeCli','',0);
   try
      edClie.Tag := 0;
      FrmBuscaPes := TFrmBuscaPes.Create(Application);
      with FrmBuscaPes do
      begin
         lPoint := Self.edClie.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edClie.Width;
         edRetorno := TLMDEdit(Self.edClie);

         if index > 2 then
           edBusca.Text := char(index)
         else
           edBusca.Text := Self.edClie.Text;
         ShowModal;
      end; // with
   finally
      if edClie.Tag > 0 then
      begin
         TabPedidoIDPess.AsString := edClie.Tag.ToString;
         edClie.Text := FrmBuscaPes.edRetorno.Text;
         //

      end;
      FrmBuscaPes.Free;
   end;
end;

// ------------- Abre Janela Análise IA de Produtos ------------- //
procedure TFrmVendas.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   FrmIAVenPro := TFrmIAVenPro.Create(Application);
   try
      FrmIAVenPro.ShowModal;
   finally
      FrmIAVenPro.Free;
   end;
end;

// ------------- Abre Janela Para Consulta de Estoque ------------- //
procedure TFrmVendas.edQtdpedCustomButtons0Click(Sender: TObject; index: Integer);
begin
  if (retProdBusca.IDProm > 0) and
       FTabPromProgr.ExisteTabIdProd(retProdBusca.IDProm, retProdBusca.IDProd) then
  begin
     FrmVenUniLevPag := TFrmVenUniLevPag.Create(Application);
     try
        FrmVenUniLevPag.recIDProm := retProdBusca.IDProm;
        FrmVenUniLevPag.recIDProd := retProdBusca.IDProd;

        FrmVenUniLevPag.ShowModal;

        if FrmVenUniLevPag.recQtdConf > 0 then
        begin
          edQtdped.SetValue(FrmVenUniLevPag.recQtdSel);
          edQtdpedExit(Sender);
        end;

     finally
        FrmVenUniLevPag.Free;
     end;
  end; {else
  begin
    acGridItemEstoque.OnExecute(Sender);
  end;}
end;

procedure TFrmVendas.edQtdpedEnter(Sender: TObject);
begin
  edQtdpedCustomButtons0Click(edQtdped, 0);
end;

procedure TFrmVendas.edQtdpedExit(Sender: TObject);
begin

  retProdBusca.Qtdped:= edQtdped.AsFloat;

  // Verifica se existe tabela promoção progressiva
  if (retProdBusca.IDProm > 0) and
       FTabPromProgr.ExisteTabIdProd(retProdBusca.IDProm, retProdBusca.IDProd) then
  begin
    retProdBusca.VlrVenda:= FTabPromProgr.PegaVlrVen(retProdBusca.IDProm, retProdBusca.IDProd, retProdBusca.Qtdped);
    retProdBusca.PerDesc := FTabPromProgr.PegaPerDesc(retProdBusca.IDProm, retProdBusca.IDProd, retProdBusca.Qtdped);

    retProdBusca.VlrDesc := retProdBusca.PrecoVen-retProdBusca.VlrVenda;
  end;

  edPerDesc.SetValue(retProdBusca.PerDesc);

  retProdBusca.VlrVenda:= retProdBusca.PrecoVen-retProdBusca.VlrDesc;
  edTotalpedIte.AsFloat:= retProdBusca.Qtdped*retProdBusca.VlrVenda;

end;

procedure TFrmVendas.edQtdpedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Enter
  if (Key = 13) then
  begin
    Key:= 0;
    edVlrVenda.SetFocus;
  end;
end;

procedure TFrmVendas.edQtdpedKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Enter
  {if (Key = 13) then
  begin
    Key:= 0;
    edVlrVenda.SetFocus;
  end;}
end;

procedure TFrmVendas.edVlrVendaExit(Sender: TObject);
var
  vlrVendaTmp, precoVenTmp: Currency;
begin

  // Necessário jogar em variável para comparação
  // caso contrário a comparação não fica correta devido as casas decimais
  vlrVendaTmp:= edVlrVenda.AsCurrency;
  precoVenTmp:= retProdBusca.PrecoVen;
  if (vlrVendaTmp > precoVenTmp) then
  begin
    MostraMsg('Atenção','Valor de Venda não pode ser maior que o Preço de Venda!',mtWarning, [mbOk]);
    Exit;
  end;

    if (vlrVendaTmp = precoVenTmp) then
      retProdBusca.PrecoVen:= edVlrVenda.AsCurrency
    else
      retProdBusca.VlrVenda:= edVlrVenda.AsCurrency;

    retProdBusca.VlrDesc:= retProdBusca.PrecoVen-retProdBusca.VlrVenda;

    retProdBusca.PerDesc:= (retProdBusca.VlrDesc*100)/retProdBusca.PrecoVen;
    edPerDesc.SetValue(retProdBusca.PerDesc);

    edTotalpedIte.AsFloat:= retProdBusca.Qtdped*retProdBusca.VlrVenda;
end;

procedure TFrmVendas.edVlrVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Enter
  if (Key = 13) then
  begin
    Key:= 0;
    edPerDesc.SetFocus;
  end;
end;

procedure TFrmVendas.edVlrVendaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Enter
  {if (Key = 13) then
  begin
    Key:= 0;
    edPerDesc.SetFocus;
  end;}
end;

procedure TFrmVendas.edPerDescExit(Sender: TObject);
begin
  if (edPerDesc.AsCurrency < 0.00) then
  begin
    MostraMsg('Atenção','Percentual de desconto não pode ser negativo!',mtWarning, [mbOk]);
    edPerDesc.SetValue(0);
    edPerDesc.SetFocus;
    Exit;
  end;

  // Desconto Manual Máximo
  if (retProdBusca.IDProm = 0) and (retProdBusca.IDDesc = 0) then
  begin
    if (edPerDesc.AsCurrency > 0) and retProdBusca.IndBloDes then // Bloqueia desconto do Produto via Cadastro do Produto
    begin
        MostraMsg('Atenção','Desconto Manual Bloqueado para Este Produto' ,mtWarning, [mbOk]);
        edPerDesc.SetValue(0);
        edPerDesc.SetFocus;
        Exit;
    end else if retProdBusca.DescMaxCalc = 0 then // Caso seja vazio, não permite desconto Manual
    begin
      if (edPerDesc.AsCurrency > 0) then
      begin
        MostraMsg('Atenção','Desconto Manual Não permitido para este Grupo/SubGrupo ', mtWarning, [mbOk]);
        edPerDesc.SetValue(0);
        edPerDesc.SetFocus;
        Exit;
      end;
    end else if retProdBusca.DescMaxCalc > 0 then
    begin
      if (edPerDesc.AsCurrency > retProdBusca.DescMaxCalc) then
      begin
        MostraMsg('Atenção','Desconto Manual Máximo do Grupo/SubGrupo permitido é '+
                  FormatFloat('##0.00%', retProdBusca.DescMaxCalc) ,mtWarning, [mbOk]);
        //
        retProdBusca.VlrVenda:= retProdBusca.PrecoUni;
        edVlrVenda.SetValue(retProdBusca.VlrVenda);
        //
        edPerDesc.SetValue(0);
        edPerDesc.SetFocus;
        Exit;
      end;
    end;
  end;

  retProdBusca.PerDesc:= edPerDesc.AsCurrency;

  retProdBusca.VlrDesc:= (retProdBusca.PrecoVen*retProdBusca.PerDesc)/100;
  retProdBusca.VlrVenda:= retProdBusca.PrecoVen-retProdBusca.VlrDesc;
  edVlrVenda.SetValue(retProdBusca.PrecoVen);
  //
  edTotalpedIte.AsFloat:= retProdBusca.Qtdped*retProdBusca.VlrVenda;

  //
  // Qtdped: Double;              // Quantidade vendida
  // PerDesc: Double;             // Percentual do Desconto
  // VlrDesc: Double;             // Valor unitário do Desconto
  // VlrVenda: Double;            // Valor unitário da venda do Item (com desconto)
end;

procedure TFrmVendas.edPerDescKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Enter
  if (Key = 13) then
  begin
    Key:= 0;
    btSalvaIte.SetFocus;
  end;
end;

procedure TFrmVendas.edVendCustomButtons0Click(Sender: TObject; index: Integer);
begin
   {//btBuscas('arqpessoa',TLMDEdit(edVend),'IDPess','Nompes','(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,0);
   btBuscasDB(TabPedido,'arqpessoa',TDBEdit(edVend),'IDVend','IDPess','Nompes','Nomven','(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,0);}

   btBuscas('arqpessoa',TLMDEdit(edVend),'IDPess','Nompes','(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,0,True);
   TabPedidoIDVend.AsInteger:= edVend.Tag;
end;

procedure TFrmVendas.edVendExit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if IsNumeric(edVend.Text) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         with QueAuxi do
         begin
            //BinaryRequest:= True;
            DataBase := DM.DWDataBase;
            QueAuxi.Close;
            SQL.Clear;
            SQL.Text := 'SELECT IDPess,Nompes,IDEsppes FROM arqpessoa WHERE '+
            iif(edVend.Text.Length < 11, 'IDPess = '+edVend.Text.Trim, 'CpfCnpjPes = '+Aspas(edVend.Text.Trim));
            QueAuxi.Open;
            Application.ProcessMessages;
            if not QueAuxi.IsEmpty then
            begin
               if (FieldByName('IDEsppes').AsInteger <> 9) and (FieldByName('IDEsppes').AsInteger <> 12) then
               begin
                  TabPedidoIDVend.Value := 0;
                  TabPedidoNomven.Value := '';
                  edVend.Text := '';
                  MostraMsg('Aviso', 'Essa pessoa não pode realizar vendas!',mtWarning, [mbOk]);
                  edVend.SetFocus;
                  Exit;
               end; //if
               TabPedidoIDVend.Value := FieldByName('IDPess').AsInteger;
               TabPedidoNomven.Value := FieldByName('Nompes').AsString;
               edVend.Text := FieldByName('Nompes').AsString;
            end else
            begin
               TabPedidoIDVend.Value := 0;
               TabPedidoNomven.Value := '';
               edVend.Text := '';
               MostraMsg('Aviso', 'Vendedor não encontrado!',mtWarning, [mbOk]);
            end;
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;
end;

procedure TFrmVendas.edVendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if not(ssCtrl in Shift) and not(ssShift in Shift) then
   begin
     if (key <> VK_RETURN) and (Key <> VK_ESCAPE)  then
     begin
        btBuscas('arqpessoa',TLMDEdit(edVend),'IDPess','Nompes',
           '(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,Key,True);
        TabPedidoIDVend.AsInteger:= edVend.Tag;
     end;

     if Key = VK_ESCAPE then
     begin
        TLMDDBLabeledEdit(Sender).Text:= '';
        TLMDDBLabeledEdit(Sender).Tag:= 0;

        TabPedidoIDVend.Value := 0;
        TabPedidoNomven.Value := '';
     end;
   end;
end;

// -------- Abre Janela Digitalização de Receitas ------------ //
procedure TFrmVendas.btDigReceClick(Sender: TObject);
begin
   FrmDigRecei := TFrmDigRecei.Create(Application);
   try
      FrmDigRecei.ShowModal;
   finally
      FrmDigRecei.Free;
   end;
end;

// ------------- Tela C/ Promoções Diponíveis ao Produto ------------ //
procedure TFrmVendas.edPBMKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not(ssCtrl in Shift) and not(ssShift in Shift) then
  begin
    if (key = VK_RETURN) and (Key <> VK_ESCAPE) then
    begin
      key:= 0;
      edNompro.SetFocus;
    end;

    if Key = VK_ESCAPE then
    begin
      TLMDDBLabeledEdit(Sender).Text:= '';
      TLMDDBLabeledEdit(Sender).Tag:= 0;
    end;
  end;
end;

procedure TFrmVendas.edPerDescCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if edNompro.Tag <= 0 then
   begin
       MostraMsg('Aviso', 'Favor escolher um produto!',mtWarning, [mbOk]);
       edNompro.SetFocus;
       Exit;
   end;

   // Promoções ou Descontos
   if (retProdBusca.IDProm > 0) or (retProdBusca.IDDesc > 0) then
   begin
     FrmVenProm := TFrmVenProm.Create(Application);
     try
        FrmVenProm.recIDPromSel := 0;
        FrmVenProm.recIDDescSel := 0;
        //
        FrmVenProm.recData      := DataServer;
        FrmVenProm.recIDProd    := edNompro.Tag;

        if retProdBusca.IDProm > 0 then
        begin
          FrmVenProm.recIDPromSel := retProdBusca.IDProm;
        end else
        begin
          FrmVenProm.recIDDescSel := retProdBusca.IDDesc;

          FrmVenProm.recIDPess  := TabPedidoIDPess.AsInteger;
          FrmVenProm.recIDConv  := TabPedidoIDConv.AsInteger;
          FrmVenProm.recIDGrupo := retProdBusca.IDGrupo;
          FrmVenProm.recIDGruSub:= retProdBusca.IDGruSub;
          FrmVenProm.recIDFabr  := retProdBusca.IDFabr;
        end;

        FrmVenProm.ShowModal;
     finally
        FrmVenProm.Free;
     end;
   end else // Não tem Promoção nem Desconto, Se tem desconto no Grupo/SubGrupo
   begin
       // Indica se Bloqueia descontos Manual do Grupo/SubGrupo
       // para este produto (Parâmetro do Cadastro de Produtos)
       if not retProdBusca.IndBloDes then
       begin
         if (retProdBusca.GrupoDescMax > 0) and
              (retProdBusca.GruSubDescMax = 0) then
           MostraMsg('Informação','Desconto Manual Máximo do Grupo permitido é '+
                  FormatFloat('##0.00%', retProdBusca.DescMaxCalc) , mtInformation, [mbOk]);

         if (retProdBusca.GrupoDescMax >= 0) and
              (retProdBusca.GruSubDescMax > 0) then
           MostraMsg('Informação','Desconto Manual Máximo do Grupo permitido é '+
                  FormatFloat('##0.00%', retProdBusca.DescMaxCalc) , mtInformation, [mbOk]);
       end;

   end;
end;

procedure TFrmVendas.dbgItensCellClick(Column: TColumn);
begin
   if FIDProd_UltimoClick <> TabPedIteIDProd.AsInteger then
   begin
     FIDProd_UltimoClick:= TabPedidoIDPed.AsInteger;

     // Reinicia o timer a cada Click se o IDProd mudou
     //timProdGupoSub.Enabled := False;
     //timProdGupoSub.Enabled := True;
   end;
   // ----- Tela C/ Dados P/ Agendamento Próxima Venda ---- //
   if Column.ID = 3 then
   begin
      if TabPedIte.IsEmpty then Exit;
      try
         FrmEdtVend := TFrmEdtVend.Create(Application);
         FrmEdtVend.ShowModal;
         FrmEdtVend.recIDVend := TabPedIteIDVend.AsInteger;
      finally
         FrmEdtVend.Free;
      end; //try
   end;

   // ----- Exclusão Item -----
   if Column.ID = 8 then
   begin
     acGridItemExclui.OnExecute(Self);
   end;

   // ----- Agendamento -----
   if Column.ID = 9 then
   begin
     acGridItemAgendamento.OnExecute(Self);
   end;

   // ----- Descontos -----
   if Column.ID = 10 then
   begin
     acGridItemDesconto.OnExecute(Self);
   end;

   // ----- Estoque -----
   if Column.ID = 11 then
   begin
     acGridItemEstoque.OnExecute(Self);
   end;

   // ----- Tela C/ Dados de Receitas ---- //
   // JOGAR DADOS DO COMPRADOR NA RECEITA.
   // SOMENTE OS ANTIMICROBIANOS DEVE SER DADOS DO PACIENTE E NÃO DO COMPRADOR
   // NUMERO DA RECEITA NO MINIMO COM 20 POSIÇÕES
   // VALIDAR A DATA DE VENCIMENTO DE CADA RECEITA COM A DATA ENTRADA PELO VENDEDOR.
   if Column.ID = 12 then
   begin
     acGridItemReceitas.OnExecute(Self);
   end;

end;

procedure TFrmVendas.BuscarVenda(TipoBusca: string);
begin
   FrmBusVenda := TFrmBusVenda.Create(Application);
   try
     FrmBusVenda.recTipBusca := TipoBusca;
     FrmBusVenda.ShowModal;

     if FrmBusVenda.retIDPed > 0 then
     begin
       // Pedido Aberto
       if (listaBtPedidos[btPedSel].IDPed > 0) and (listaBtPedidos[btPedSel].Status = 'A') then
       begin
         if listaBtPedidos[btPedSel].IDPed <> FrmBusVenda.retIDPed then
         begin
           if (VerificaIDPedEmOutroBotao(FrmBusVenda.retIDPed) > -1) then
           begin

             listaBtPedidos[btPedSel].btPedido.Appearance.Color:= $00F4F8FF;
             listaBtPedidos[btPedSel].btPedido.Appearance.ColorMirror:= $00F4F8FF;

             btPedSel:= VerificaIDPedEmOutroBotao(FrmBusVenda.retIDPed);

             listaBtPedidos[btPedSel].btPedido.Appearance.Color:= $002B70FF;
             listaBtPedidos[btPedSel].btPedido.Appearance.ColorMirror:= $002B70FF;

           end else
           begin
             // Salva Atual
             if Salvar then
             begin
               for var i := 0 to listaBtPedidos.Count - 1 do
                 listaBtPedidos[i].btPedido.Align := alNone;

               listaBtPedidos.Add( TarqPedido.Create(FrmBusVenda.retIDPed, FrmBusVenda.retStatusPed, CloneAdvGlowButton(Self, btPedido0)) );

               // Inclui Novo Botão de Pedido
               //btPedSel:= btPedSel + 1;

               listaBtPedidos[btPedSel].btPedido.Name:= 'btPedido'+btPedSel.ToString;
               listaBtPedidos[btPedSel].btPedido.Caption:= 'PEDIDO '+(btPedSel+1).ToString;
               listaBtPedidos[btPedSel].btPedido.ShortCutHint := ' Ctrl+'+(btPedSel+1).ToString+' ';
               listaBtPedidos[btPedSel].btPedido.ShortCutHintPos := shpTop;

               listaBtPedidos[btPedSel].btPedido.Tag:= btPedSel;

               for var i := listaBtPedidos.Count - 1 downto 0 do
                 listaBtPedidos[i].btPedido.Align := alRight;
             end;
           end;

           AbreSQL(listaBtPedidos[btPedSel].IDPed);
           edClie.SetFocus;

         end;
       end else
       begin     // if (Self.recIDPed > 0) and (Self.recStatusPed = 'F')
         listaBtPedidos[btPedSel].IDPed:= FrmBusVenda.retIDPed;
         listaBtPedidos[btPedSel].Status:= FrmBusVenda.retStatusPed;
         listaBtPedidos[btPedSel].ItensAlterados:= False;
         listaBtPedidos[btPedSel].ReceitasAlteradas:= False;
         //
         AbreSQL(listaBtPedidos[btPedSel].IDPed);
         edClie.SetFocus;
       end;
     end;
   finally
      FrmBusVenda.Free;
   end;
end;

function TFrmVendas.VerificaIDPedEmOutroBotao(prIDPed: Integer): Integer;
var
  i: Integer;
begin
  Result:= -1;

  for i := 0 to listaBtPedidos.Count - 1 do
  begin
    if listaBtPedidos[i].IDPed = prIDPed then
      Result:= i;
  end;

end;

procedure TFrmVendas.acGridItemAgendamentoExecute(Sender: TObject);
begin
  if TabPedIte.IsEmpty then Exit;
  try
     FrmAgeVenda := TFrmAgeVenda.Create(Application);
     FrmAgeVenda.ShowModal;
     FrmAgeVenda.recIDProd := TabPedIteIDProd.AsInteger;
  finally
     FrmAgeVenda.Free;
  end; //try
end;

procedure TFrmVendas.acGridItemDescontoExecute(Sender: TObject);
begin
   // Promoções ou Descontos
   if (TabPedIteIDProm.AsInteger > 0) or (TabPedIteIDDesc.AsInteger > 0) then
   begin
     FrmVenProm := TFrmVenProm.Create(Application);
     try
        FrmVenProm.recIDPromSel := 0;
        FrmVenProm.recIDDescSel := 0;
        //
        FrmVenProm.recData      := DataServer;
        FrmVenProm.recIDProd    := TabPedIteIDProd.AsInteger;

        if TabPedIteIDProm.AsInteger > 0 then
        begin
          FrmVenProm.recIDPromSel := TabPedIteIDProm.AsInteger;
        end else
        begin
          FrmVenProm.recIDDescSel := TabPedIteIDDesc.AsInteger;

          FrmVenProm.recIDPess  := TabPedidoIDPess.AsInteger;
          FrmVenProm.recIDConv  := TabPedidoIDConv.AsInteger;
          FrmVenProm.recIDGrupo := TabPedIteIDGrupo.AsInteger;     
          FrmVenProm.recIDGruSub:= TabPedIteIDGruSub.AsInteger;
          FrmVenProm.recIDFabr  := TabPedIteIDFabr.AsInteger;
        end;

        FrmVenProm.ShowModal;
     finally
        FrmVenProm.Free;
     end;
   end else
   begin
     MostraMsg('Promoções/Descontos','Não encontrado para o produto!',mtWarning, [mbOk]);
   end;
end;

procedure TFrmVendas.acGridItemEstoqueExecute(Sender: TObject);
var
  prodID: Integer;
begin
   prodID:= 0;
   if retProdBusca.IDProd > 0 then
   begin
     prodID:= retProdBusca.IDProd;
   end else if TabPedIteIDProd.AsInteger > 0 then
   begin
     prodID:= TabPedIteIDProd.AsInteger;
   end else
   begin
     MostraMsg('Aviso', 'Favor escolher um produto!',mtWarning, [mbOk]);
     edNompro.SetFocus;
     Exit;
   end;
   //
   FrmConEsto := TFrmConEsto.Create(Application);
   try
      FrmConEsto.recIDProd := prodID;
      FrmConEsto.ShowModal;
   finally
      FrmConEsto.Free;
   end;
end;

procedure TFrmVendas.acGridItemExcluiExecute(Sender: TObject);
var
  IDProm, IDDesc: Integer;
  precoVen: Double;
begin
  IDProm:= 0;
  IDDesc:= 0;

  edTotIte.AsInteger := edTotIte.AsInteger - Trunc(TabPedIteQtdped.AsCurrency);

  IDProm:=   TabPedIteIDProm.AsInteger;
  IDDesc:=   TabPedIteIDDesc.AsInteger;
  precoVen:= TabPedItePrecoVen.AsFloat;

  TabPedIte.DisableControls;
  TabPedidoTotDesc.AsCurrency   := TabPedidoTotDesc.AsCurrency   - TabPedIteVlrDesc.AsCurrency;
  TabPedidoTotPedido.AsCurrency := TabPedidoTotPedido.AsCurrency - TabPedIteTotItemCalc.AsCurrency;
  TabPedIte.Delete;
  TabPedIte.EnableControls;

  if TabPedIte.RecordCount = 0 then
  begin
   edTotIte.AsInteger:= 0;
   TabPedidoTotDesc.AsCurrency   := 0;
   TabPedidoTotPedido.AsCurrency := 0;
  end;

  RecalculoDescProg(IDProm, IDDesc);

  LimpaProdBusca();
  edNompro.SetFocus;
end;

procedure TFrmVendas.acGridItemInsereExecute(Sender: TObject);
begin
  edNompro.Clear;
  edNompro.SetFocus;
end;

function TFrmVendas.ReceitaItemJaExiste(): Boolean;
begin
  Result:= False;
  TabPedIteRec.DisableControls;
  Result := TabPedIteRec.Locate('IDFilial;IDPed;IDProd',
                              VarArrayOf([FILIAL, TabPedIteIDPed.AsInteger, TabPedIteIDProd.AsInteger]),
                              []);
  TabPedIteRec.EnableControls;
end;

procedure TFrmVendas.CarregaReceitaItem(frmRec: TFrmReceitaBase; IDInvIni: Integer);
begin
  frmRec.recIDInvIni:= IDInvIni; // Código do Inventário SNGPC

  frmRec.recIDFilial:= TabPedIteIDFilial.AsInteger;
  frmRec.recIDProd  := TabPedIteIDProd.AsInteger;
  frmRec.recDespro  := TabPedIteDespro.AsString;
  frmRec.recDesSubs := TabPedIteDesSubs.AsString;
  frmRec.recQtdped  := TabPedIteQtdped.AsFloat;

  frmRec.recIncluindo    := True;  // Indica que é uma inclusão
  if ReceitaItemJaExiste() then // Recupera Receita já incluída
  begin
    frmRec.recIncluindo  := False; // Indica que é uma alteração
    frmRec.recNroRec     := TabPedIteRecNroRec.AsString;
    frmRec.recDatVen     := TabPedIteRecDatVen.AsDateTime;
    frmRec.recDatPresc   := TabPedIteRecDatPresc.AsDateTime;
    frmRec.recUsoMed     := TabPedIteRecUsoMed.AsString;
    frmRec.recNomepac    := TabPedIteRecNompac.AsString;
    frmRec.recEndpac     := TabPedIteRecEndpac.AsString;
    frmRec.recCidpac     := TabPedIteRecCidpac.AsString;
    frmRec.recUfpac      := TabPedIteRecUfpac.AsString;
    frmRec.recRgpac      := TabPedIteRecRgpac.AsString;
    frmRec.recSspac      := TabPedIteRecSspac.AsString;
    frmRec.recTelpac     := TabPedIteRecTelpac.AsString;
    // Dados do Médico
    frmRec.recNommed     := TabPedIteRecNommed.AsString;
    frmRec.recIDPessMed  := TabPedIteRecIDPessMed.AsInteger;
    frmRec.recNroRegProf := TabPedIteRecNroRegProf.AsString;
    frmRec.recConRegProf := TabPedIteRecConRegProf.AsString;
    frmRec.recEstRegProf := TabPedIteRecEstRegProf.AsString;
    //
    frmRec.recSexo       := TabPedIteRecSexoPac.AsString;
    frmRec.recIdade      := TabPedIteRecIdadePac.AsInteger;
    //
    frmRec.recIDPac        := TabPedIteRecIDPac.AsInteger;
    frmRec.recUnidadeIdade := TabPedIteRecUniIdadePac.AsString;  // '1'-Anos  '2'-Meses
    frmRec.recIdadePac     := TabPedIteRecIdadePac.AsInteger;    // Idade do Paciente
    frmRec.recUsoProlog    := TabPedIteRecUsoProlong.AsString;   // '0'-Sim '1'-Não

    frmRec.recTipDocComp   := TabPedIteRecTipDocComp.AsString;
    frmRec.recNumDocComp   := TabPedIteRecNumDocComp.AsString;
    frmRec.recOrgExpComp   := TabPedIteRecOrgExpComp.AsString;
    frmRec.recUFEmiComp    := TabPedIteRecEstEmiComp.AsString;
  end else
  begin
    frmRec.recDatVen     := DataServer;
    frmRec.recDatPresc   := DataServer;
    frmRec.recNommed     := '';
    frmRec.recNroRegProf := '';
    frmRec.recConRegProf := '';
    frmRec.recEstRegProf := '';
    frmRec.recNroRec     := '';
    frmRec.recUsoMed     := 'H';
    frmRec.recUfpac      := '';
    //
    frmRec.recSexo       := '0';
    //
    frmRec.recIDPac        := 0;
    frmRec.recUnidadeIdade := '1';  // '1'-Anos  '2'-Meses
    frmRec.recIdadePac     := 1;    // Idade do Paciente
    frmRec.recUsoProlog    := '1';  // '0'-Sim '1'-Não

    if TabPedidoIDPess.AsInteger > 0 then
    begin
      TabArqPessoa.Close;
      TabArqPessoa.ParamByName('IDPess').AsInteger:= TabPedidoIDPess.AsInteger;
      TabArqPessoa.Open;
      //
      frmRec.recIDPac  := TabPedidoIDPess.AsInteger;
      frmRec.recNomepac:= TabArqPessoaNompes.AsString;

      frmRec.recTipDocComp := '1';
      frmRec.recNumDocComp := TabArqPessoaRGEPes.AsString;
      frmRec.recOrgExpComp := TabArqPessoaRGEOrg.AsString.Trim;
      frmRec.recUFEmiComp  := TabArqPessoaRGEEst.AsString.Trim;

      if TabArqPessoaCelularPes.AsString = EmptyStr then
        frmRec.recTelpac := TabArqPessoaFonePes.AsString
      else
        frmRec.recTelpac := TabArqPessoaCelularPes.AsString;
      //
      TabArqPessoa.Close;
    end else
    begin
      frmRec.recNomepac    := '';
      frmRec.recTipDocComp := '1';
      frmRec.recNumDocComp := '';
      frmRec.recOrgExpComp := '';
      frmRec.recUFEmiComp  := '';
    end;
  end;
end;

procedure TFrmVendas.GravaReceitaItem(frmRec: TFrmReceitaBase);
begin
  if ReceitaItemJaExiste() then
  begin
    TabPedIteRec.Edit;
  end else
  begin
    TabPedIteRec.Append;
  end;
  //
  TabPedIteRecIDFilial.AsInteger:= TabPedIteIDFilial.AsInteger;
  TabPedIteRecIDPed.AsInteger   := TabPedIteIDPed.AsInteger;
  TabPedIteRecIDProd.AsInteger  := TabPedIteIDProd.AsInteger;
  TabPedIteRecUsoRece.AsString  := TabPedIteUsoRece.AsString;

  TabPedIteRecNroRec.AsString := frmRec.recNroRec;
  TabPedIteRecDatVen.AsDateTime:= frmRec.recDatVen;
  TabPedIteRecDatPresc.AsDateTime:= frmRec.recDatPresc;
  TabPedIteRecUsoMed.AsString  := frmRec.recUsoMed;

  // Pasciente
  TabPedIteRecIDPac.AsInteger     := frmRec.recIDPac;
  TabPedIteRecNompac.AsString     := frmRec.recNomepac;
  TabPedIteRecEndpac.AsString     := frmRec.recEndpac;
  TabPedIteRecCidpac.AsString     := frmRec.recCidpac;
  TabPedIteRecUfpac.AsString      := frmRec.recUfpac;
  TabPedIteRecTelpac.AsString     := frmRec.recTelpac;
  TabPedIteRecSexoPac.AsString    := frmRec.recSexo;
  TabPedIteRecIdadePac.AsInteger  := frmRec.recIdade;
  TabPedIteRecUniIdadePac.AsString:= frmRec.recUnidadeIdade;

  TabPedIteRecUsoProlong.AsString := frmRec.recUsoProlog;
  TabPedIteRecTipDocComp.AsString := frmRec.recTipDocComp;
  TabPedIteRecNumDocComp.AsString := frmRec.recNumDocComp;
  TabPedIteRecOrgExpComp.AsString := frmRec.recOrgExpComp;
  TabPedIteRecEstEmiComp.AsString := frmRec.recUFEmiComp;

  // Dados Médico
  TabPedIteRecIDPessMed.AsInteger := frmRec.recIDPessMed;
  TabPedIteRecNommed.AsString     := frmRec.recNommed;
  TabPedIteRecNroRegProf.AsString := frmRec.recNroRegProf;
  TabPedIteRecConRegProf.AsString := frmRec.recConRegProf;
  TabPedIteRecEstRegProf.AsString := frmRec.recEstRegProf;

  TabPedIteRec.Post;
end;

function TFrmVendas.SngpcLoteJaExiste(nrLote: String): Boolean;
begin
  Result:= False;
  TabSngpcVen.DisableControls;
  Result := TabSngpcVen.Locate('IDFilial;IDPed;IDProd;Nrolot',
                              VarArrayOf([TabPedIteIDFilial.AsInteger,
                                          TabPedIteIDPed.AsInteger,
                                          TabPedIteIDProd.AsInteger,
                                          nrLote]),
                              []);
  TabSngpcVen.EnableControls;
end;

procedure TFrmVendas.CarregaSNGPCItem(frmRec: TFrmReceitaBase; IDInvIni: Integer);
begin

  if not(TabSngpcVen.Active) then
  begin
    TabSngpcVen.Filtered:= false;
    TabSngpcVen.Filter  := EmptyStr;
    TabSngpcVen.ParamByName('IDFilial').AsInteger:= TabPedIteIDFilial.AsInteger;
    TabSngpcVen.ParamByName('IDPed').AsInteger   := TabPedIteIDPed.AsInteger;
    TabSngpcVen.Open;
  end;

  TabSngpcVen.Filtered:= false;
  TabSngpcVen.Filter  := 'IDProd = ' + TabPedIteIDProd.AsString +
                         ' AND IDPess = ' + TabPedIteIDFabr.AsString;
  TabSngpcVen.Filtered:= true;
  TabSngpcVen.First;

  while not(TabSngpcVen.Eof) do
  begin
    frmRec.cdArqSngpcLot.Append;

    frmRec.cdArqSngpcLotIDInvIni.AsInteger := IDInvIni; // Código do Inventário SNGPC
    frmRec.cdArqSngpcLotIDProd.AsInteger   := TabSngpcVenIDProd.AsInteger;
    frmRec.cdArqSngpcLotIDPess.AsInteger   := TabSngpcVenIDPess.AsInteger;

    frmRec.cdArqSngpcLotNrolot.AsString    := TabSngpcVenNrolot.AsString;
    frmRec.cdArqSngpcLotDatven.AsDateTime  := TabSngpcVenDatven.AsDateTime;
    frmRec.cdArqSngpcLotQtdest.AsCurrency  := 0;
    frmRec.cdArqSngpcLotQtdSel.AsCurrency  := TabSngpcVenQtdven.AsFloat;

    frmRec.cdArqSngpcLot.Post;
    //
    TabSngpcVen.Next;
  end;

end;

procedure TFrmVendas.GravaSNGPCItem(frmRec: TFrmReceitaBase; IDVenda, IDInvIni: Integer);
begin

  frmRec.cdArqSngpcLot.First;
  while not(frmRec.cdArqSngpcLot.Eof) do
  begin
    if frmRec.cdArqSngpcLotQtdSel.AsCurrency > 0 then
    begin
      if SngpcLoteJaExiste(frmRec.cdArqSngpcLotNrolot.AsString) then
      begin
        TabSngpcVen.Edit;
      end else
      begin
        TabSngpcVen.Append;
      end;

      // TabPedido
      TabSngpcVenIDComp.AsInteger    := TabPedidoIDPess.AsInteger;              // 'ID do Comprador'
      TabSngpcVenIDVend.AsInteger    := TabPedidoIDVend.AsInteger;              // 'ID do Vendedor'
      TabSngpcVenIDPac.AsInteger     := 0;                                      // 'ID do paciente'

      // Dados do Médico
      TabSngpcVenIDPres.AsInteger    := TabPedIteRecIDPessMed.AsInteger;        // 'ID do Prescritor (médico)'

      // TabPedIte
      TabSngpcVenIDFilial.AsInteger  := TabPedIteIDFilial.AsInteger;            // 'ID da Filial'
      TabSngpcVenIDProd.AsInteger    := TabPedIteIDProd.AsInteger;              // 'ID do Produto'
      TabSngpcVenIDPed.AsInteger     := TabPedIteIDPed.AsInteger;               // 'ID do Pedido de Venda'
      TabSngpcVenIDInvIni.AsInteger  := IDInvIni;                               // 'ID do inventário ativo'
      TabSngpcVenIDVenda.AsInteger   := idVenda;                                // 'ID da tabela arqsngpcven'

      TabSngpcVenDatVenda.AsDateTime := TabPedIteRecDatVen.AsDateTime;          // 'Data da Venda'
      TabSngpcVenDatpre.AsDateTime   := TabPedIteRecDatPresc.AsDateTime;        // 'Data da prescrição'
      TabSngpcVenNroRece.AsString    := TabPedIteRecNroRec.AsString;            // 'Número da Receita'

      // Form Receita
      TabSngpcVenNrolot.AsString     := frmRec.cdArqSngpcLotNrolot.AsString;    // 'Número do Lote'
      TabSngpcVenDatven.AsDateTime   := frmRec.cdArqSngpcLotDatven.AsDateTime;  // 'Data de Vencimento do Lote'
      TabSngpcVenIDPess.AsInteger    := frmRec.cdArqSngpcLotIDPess.AsInteger;   // 'ID do Fornecedor deste lote'
      TabSngpcVenQtdven.AsFloat      := frmRec.cdArqSngpcLotQtdSel.AsFloat;     // 'Quantidade Vendida'

      // 'Uso do medicamento  1-Humano  2-Veterinário'
      TabSngpcVenUsoMed.AsString := '0';
      if frmRec.recUsoMed = 'H' then TabSngpcVenUsoMed.AsString := '1';
      if frmRec.recUsoMed = 'V' then TabSngpcVenUsoMed.AsString := '2';

      TabSngpcVenUsoProlong.AsString := frmRec.recUsoProlog;                    // 'Uso prolongado  0-Não  1-Sim'
      TabSngpcVenIDPac.AsInteger     := frmRec.recIDPac;                        // 'ID do paciente'
      //
      TabSngpcVenNroNot.AsInteger     := 0;     // 'Número da nota fiscal',
      TabSngpcVenIndConf.AsString     := '0';   // 'Indicação de conferido  0-Não   1-Sim   2-Falta receita'
      TabSngpcVenTransmitida.AsString := '0';   // 'Indicação de Transmitida 0 - Não / 1 -Sim'

      TabSngpcVen.Post;
    end;
    //
    frmRec.cdArqSngpcLot.Next;
  end;

end;

// Grava Tabela arqsngpcvencom (Tabela duplicada com os dados do comprador)
procedure TFrmVendas.GravaDadosCompSNGPC(frmRec: TFrmReceitaBase; idVenda, idPess: Integer);

  function JaExisteVenCom(): Boolean;
  begin
    Result:= False;
    TabSngpcVenPac.DisableControls;

    Result:= TabSngpcVenCom.Locate('IDComp', idPess, []);

    TabSngpcVenPac.EnableControls;
  end;

begin

  if idPess > 0 then  // Venda com Cliente/Comprador
  begin

    TabArqPessoa.Close;
    TabArqPessoa.ParamByName('IDPess').AsInteger:= idPess;
    TabArqPessoa.Open;

    if not TabArqPessoa.IsEmpty then
    begin
      if JaExisteVenCom() then
        TabSngpcVenCom.Edit
      else
        TabSngpcVenCom.Append;
      //
      TabSngpcVenComIDVenda.AsInteger   := idVenda;
      TabSngpcVenComIDComp.AsInteger    := idPess;
      TabSngpcVenComEndcomp.AsString    := TabArqPessoaEndpes.AsString;
      TabSngpcVenComNroEndComp.AsString := TabArqPessoaNroEnd.AsString;
      TabSngpcVenComComEndComp.AsString := TabArqPessoaCompEnd.AsString;
      TabSngpcVenComBaiComp.AsString    := TabArqPessoaBaipes.AsString;
      TabSngpcVenComCepComp.AsString    := TabArqPessoaCeppes.AsString;
      TabSngpcVenComDesMunComp.AsString := TabArqPessoaNommun.AsString;
      TabSngpcVenComEstComp.AsString    := TabArqPessoaEstmun.AsString;
      TabSngpcVenComTipDocComp.AsString := frmRec.recTipDocComp;
      TabSngpcVenComNumDocComp.AsString := frmRec.recNumDocComp;
      TabSngpcVenComOrgExpComp.AsString := frmRec.recOrgExpComp;
      TabSngpcVenComEstEmiComp.AsString := frmRec.recUFEmiComp;
      TabSngpcVenCom.Post;
    end;
    TabArqPessoa.Close;
  end;
end;

procedure TFrmVendas.GravaDadosPacSNGPC(frmRec: TFrmReceitaBase; IDVenda, IDPac: Integer);

  function JaExisteVenPac(): Boolean;
  begin
    Result:= False;
    TabSngpcVenPac.DisableControls;

    Result:= TabSngpcVenPac.Locate('IDPac', IDPac, []);

    TabSngpcVenPac.EnableControls;
  end;

begin

  if JaExisteVenPac() then
    TabSngpcVenPac.Edit
  else
    TabSngpcVenPac.Append;
  //
  TabSngpcVenPacIDVenda.AsInteger    := IDVenda;
  TabSngpcVenPacIDPac.AsInteger      := IDPac;
  TabSngpcVenPacSexoPac.AsString     := frmRec.recSexo;
  TabSngpcVenPacUniIdadePac.AsString := frmRec.recUnidadeIdade;
  TabSngpcVenPacIdadePac.AsInteger   := frmRec.recIdade;
  TabSngpcVenPac.Post;

end;

procedure TFrmVendas.acGridItemReceitasExecute(Sender: TObject);
var
  vError: String;

  function ProdRecJaExiste(): Boolean;
  begin
    Result:= False;
    TabPedIteRec.DisableControls;
    Result := TabPedIteRec.Locate('IDFilial;IDPed;IDProd',
                                VarArrayOf([FILIAL, TabPedIteIDPed.AsInteger, TabPedIteIDProd.AsInteger]),
                                []);
    TabPedIteRec.EnableControls;
  end;

begin
   vError:= EmptyStr;

   // ----- Tela C/ Dados de Receitas ---- //
   // JOGAR DADOS DO COMPRADOR NA RECEITA.
   // SOMENTE OS ANTIMICROBIANOS DEVE SER DADOS DO PACIENTE E NÃO DO COMPRADOR
   // NUMERO DA RECEITA NO MINIMO COM 20 POSIÇÕES
   // VALIDAR A DATA DE VENCIMENTO DE CADA RECEITA COM A DATA ENTRADA PELO VENDEDOR.
    if TabPedIte.IsEmpty or (TabPedIteUsoRece.AsString = '') then Exit;
    try
       if (AnsiPos('AM',TabPedIteUsoRece.AsString) > 0) or
            ((AnsiPos('C',TabPedIteUsoRece.AsString) > 0) and (AnsiPos('C2',TabPedIteUsoRece.AsString) <= 0)) then
       begin
          FrmReceitaC := TFrmReceitaC.Create(Application);

          // Configuração - Validade Dias do Tipo da Receita
          FrmReceitaC.recValDias:= FTabConfigRecCtl.ValDias(TabPedIteUsoRece.AsString);

          FrmReceitaC.edANum.Text := '';
          if TabPedIteUsoRece.AsString.Length >= 2 then
            FrmReceitaC.edANum.Text   := TabPedIteUsoRece.AsString;

          // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
          FrmReceitaC.recSNGPCObrVenda:= FTabConfigRecCtl.SNGPCObrVenda;
          if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
          begin
            FrmReceitaC.pnReceita.Left:= 4;
            FrmReceitaC.pnLoteSNGPC.Visible:= True;

            FrmReceitaC.btSalvar.Left:= 757;
            FrmReceitaC.btSalvar.Top := 463;
          end else
          begin

            FrmReceitaC.btSalvar.Left:= 805;
            FrmReceitaC.btSalvar.Top := 131;
          end;

          CarregaReceitaItem(FrmReceitaC, FTabConfigRecCtl.IDInvIni);

          if FrmReceitaC.pnLoteSNGPC.Visible then
              CarregaSNGPCItem(FrmReceitaC, FTabConfigRecCtl.IDInvIni);

          FrmReceitaC.ShowModal;

          if FrmReceitaC.btSalvar.ModalResult = mrOK then
          begin
            listaBtPedidos[btPedSel].ReceitasAlteradas:= True;

            GravaReceitaItem(FrmReceitaC);

            if FrmReceitaC.pnLoteSNGPC.Visible then
            begin
              if FIDVendaSNGPC = 0 then
                FIDVendaSNGPC:= NextSequenceID('arqsngpcven_sequence', vError);

              // Grava Prod Item Lote SNGPC tabela arqsngpcven
              GravaSNGPCItem(FrmReceitaC, FIDVendaSNGPC, FTabConfigRecCtl.IDInvIni);

              // Grava Dados do Comprador SNGPC tabela arqsngpcvencom
              GravaDadosCompSNGPC(FrmReceitaC, FIDVendaSNGPC, TabPedidoIDPess.AsInteger);

              // Grava Dados do Paciente SNGPC tabela arqsngpcvenpac
              GravaDadosPacSNGPC(FrmReceitaC, FIDVendaSNGPC, FrmReceitaC.recIDPac);
            end;
          end;
          //
          FrmReceitaC.Free;
       end else
       if AnsiPos('A',TabPedIteUsoRece.AsString) > 0 then
       begin
          FrmReceitaA := TFrmReceitaA.Create(Application);

          // Configuração - Validade Dias do Tipo da Receita
          FrmReceitaA.recValDias:= FTabConfigRecCtl.ValDias(TabPedIteUsoRece.AsString);

          FrmReceitaA.edANum.Text := '';
          if TabPedIteUsoRece.AsString.Length >= 2 then
            FrmReceitaA.edANum.Text   := TabPedIteUsoRece.AsString;

          // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
          FrmReceitaA.recSNGPCObrVenda:= FTabConfigRecCtl.SNGPCObrVenda;
          if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
          begin
            FrmReceitaA.pnReceita.Left:= 4;
            FrmReceitaA.pnLoteSNGPC.Visible:= True;

            FrmReceitaA.btSalvar.Top:= 463
          end else
          begin

            FrmReceitaA.btSalvar.Top:= 131;
          end;

          CarregaReceitaItem(FrmReceitaA, FTabConfigRecCtl.IDInvIni);

          if FrmReceitaA.pnLoteSNGPC.Visible then
              CarregaSNGPCItem(FrmReceitaA, FTabConfigRecCtl.IDInvIni);

          FrmReceitaA.ShowModal;

          if FrmReceitaA.btSalvar.ModalResult = mrOK then
          begin
            listaBtPedidos[btPedSel].ReceitasAlteradas:= True;

            GravaReceitaItem(FrmReceitaA);

            if FrmReceitaA.pnLoteSNGPC.Visible then
            begin
              if FIDVendaSNGPC = 0 then
                FIDVendaSNGPC:= NextSequenceID('arqsngpcven_sequence', vError);

              // Grava Prod Item Lote SNGPC tabela arqsngpcven
              GravaSNGPCItem(FrmReceitaA, FIDVendaSNGPC, FTabConfigRecCtl.IDInvIni);

              // Grava Dados do Comprador SNGPC tabela arqsngpcvencom
              GravaDadosCompSNGPC(FrmReceitaA, FIDVendaSNGPC, TabPedidoIDPess.AsInteger);

              // Grava Dados do Paciente SNGPC tabela arqsngpcvenpac
              GravaDadosPacSNGPC(FrmReceitaA, FIDVendaSNGPC, FrmReceitaA.recIDPac);
            end;
          end;
          //
          FrmReceitaA.Free;
       end else
       if (AnsiPos('B',TabPedIteUsoRece.AsString) > 0) and (AnsiPos('B2',TabPedIteUsoRece.AsString) <= 0) then
       begin
		      FrmReceitaB := TFrmReceitaB.Create(Application);

          // Configuração - Validade Dias do Tipo da Receita
          FrmReceitaB.recValDias:= FTabConfigRecCtl.ValDias(TabPedIteUsoRece.AsString);

          FrmReceitaB.edANum.Text := '';
          if TabPedIteUsoRece.AsString.Length >= 2 then
            FrmReceitaB.edANum.Text   := TabPedIteUsoRece.AsString;

          // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
          FrmReceitaB.recSNGPCObrVenda:= FTabConfigRecCtl.SNGPCObrVenda;
          if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
          begin
            FrmReceitaB.pnReceita.Left:= 4;
            FrmReceitaB.pnLoteSNGPC.Visible:= True;

            FrmReceitaB.btSalvar.Top:= 435;
          end else
          begin

            FrmReceitaB.btSalvar.Top:= 131;
          end;

          CarregaReceitaItem(FrmReceitaB, FTabConfigRecCtl.IDInvIni);

          if FrmReceitaB.pnLoteSNGPC.Visible then
              CarregaSNGPCItem(FrmReceitaB, FTabConfigRecCtl.IDInvIni);

          FrmReceitaB.ShowModal;

          if FrmReceitaB.btSalvar.ModalResult = mrOK then
          begin
            listaBtPedidos[btPedSel].ReceitasAlteradas:= True;

            GravaReceitaItem(FrmReceitaB);

            if FrmReceitaB.pnLoteSNGPC.Visible then
            begin
              if FIDVendaSNGPC = 0 then
                FIDVendaSNGPC:= NextSequenceID('arqsngpcven_sequence', vError);

              // Grava Prod Item Lote SNGPC tabela arqsngpcven
              GravaSNGPCItem(FrmReceitaB, FIDVendaSNGPC, FTabConfigRecCtl.IDInvIni);

              // Grava Dados do Comprador SNGPC tabela arqsngpcvencom
              GravaDadosCompSNGPC(FrmReceitaB, FIDVendaSNGPC, TabPedidoIDPess.AsInteger);

              // Grava Dados do Paciente SNGPC tabela arqsngpcvenpac
              GravaDadosPacSNGPC(FrmReceitaB, FIDVendaSNGPC, FrmReceitaB.recIDPac);
            end;
          end;
          //
          FrmReceitaB.Free;
       end else
       if AnsiPos('B2',TabPedIteUsoRece.AsString) > 0  then
       begin
		      FrmReceitaB2 := TFrmReceitaB2.Create(Application);

          // Configuração - Validade Dias do Tipo da Receita
          FrmReceitaB2.recValDias:= FTabConfigRecCtl.ValDias(TabPedIteUsoRece.AsString);

          //FrmReceitaB2.edANum.Text := '';
          //if TabPedIteUsoRece.AsString.Length >= 2 then
          //  FrmReceitaB2.edANum.Text   := TabPedIteUsoRece.AsString;

          // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
          FrmReceitaB2.recSNGPCObrVenda:= FTabConfigRecCtl.SNGPCObrVenda;
          if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
          begin
            FrmReceitaB2.pnReceita.Left:= 4;
            FrmReceitaB2.pnLoteSNGPC.Visible:= True;

            FrmReceitaB2.btSalvar.Top:= 452;
          end else
          begin

            FrmReceitaB2.btSalvar.Top:= 131;
          end;

          CarregaReceitaItem(FrmReceitaB2, FTabConfigRecCtl.IDInvIni);

          if FrmReceitaB2.pnLoteSNGPC.Visible then
              CarregaSNGPCItem(FrmReceitaB2, FTabConfigRecCtl.IDInvIni);

          FrmReceitaB2.ShowModal;

          if FrmReceitaB2.btSalvar.ModalResult = mrOK then
          begin
            listaBtPedidos[btPedSel].ReceitasAlteradas:= True;

            GravaReceitaItem(FrmReceitaB2);

            if FrmReceitaB2.pnLoteSNGPC.Visible then
            begin
              if FIDVendaSNGPC = 0 then
                FIDVendaSNGPC:= NextSequenceID('arqsngpcven_sequence', vError);

              // Grava Prod Item Lote SNGPC tabela arqsngpcven
              GravaSNGPCItem(FrmReceitaB2, FIDVendaSNGPC, FTabConfigRecCtl.IDInvIni);

              // Grava Dados do Comprador SNGPC tabela arqsngpcvencom
              GravaDadosCompSNGPC(FrmReceitaB2, FIDVendaSNGPC, TabPedidoIDPess.AsInteger);

              // Grava Dados do Paciente SNGPC tabela arqsngpcvenpac
              GravaDadosPacSNGPC(FrmReceitaB2, FIDVendaSNGPC, FrmReceitaB2.recIDPac);
            end;
          end;
          //
          FrmReceitaB2.Free;
       end else
       if AnsiPos('C2',TabPedIteUsoRece.AsString) > 0 then
       begin
		      FrmReceitaC2 := TFrmReceitaC2.Create(Application);

          // Configuração - Validade Dias do Tipo da Receita
          FrmReceitaC2.recValDias:= FTabConfigRecCtl.ValDias(TabPedIteUsoRece.AsString);

          //FrmReceitaC2.edANum.Text := '';
          //if TabPedIteUsoRece.AsString.Length >= 2 then
          //  FrmReceitaC2.edANum.Text   := TabPedIteUsoRece.AsString;

          // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
          FrmReceitaC2.recSNGPCObrVenda:= FTabConfigRecCtl.SNGPCObrVenda;
          if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
          begin
            FrmReceitaC2.pnReceita.Left:= 4;
            FrmReceitaC2.pnLoteSNGPC.Visible:= True;

            FrmReceitaC2.btSalvar.Top:= 463;
          end else
          begin

            FrmReceitaC2.btSalvar.Top:= 131;
          end;

          CarregaReceitaItem(FrmReceitaC2, FTabConfigRecCtl.IDInvIni);

          if FrmReceitaC2.pnLoteSNGPC.Visible then
              CarregaSNGPCItem(FrmReceitaC2, FTabConfigRecCtl.IDInvIni);

          FrmReceitaC2.ShowModal;

          if FrmReceitaC2.btSalvar.ModalResult = mrOK then
          begin
            listaBtPedidos[btPedSel].ReceitasAlteradas:= True;

            GravaReceitaItem(FrmReceitaC2);

            if FrmReceitaC2.pnLoteSNGPC.Visible then
            begin
              if FIDVendaSNGPC = 0 then
                FIDVendaSNGPC:= NextSequenceID('arqsngpcven_sequence', vError);

              // Grava Prod Item Lote SNGPC tabela arqsngpcven
              GravaSNGPCItem(FrmReceitaC2, FIDVendaSNGPC, FTabConfigRecCtl.IDInvIni);

              // Grava Dados do Comprador SNGPC tabela arqsngpcvencom
              GravaDadosCompSNGPC(FrmReceitaC2, FIDVendaSNGPC, TabPedidoIDPess.AsInteger);

              // Grava Dados do Paciente SNGPC tabela arqsngpcvenpac
              GravaDadosPacSNGPC(FrmReceitaC2, FIDVendaSNGPC, FrmReceitaC2.recIDPac);
            end;
          end;
          //
          FrmReceitaC2.Free;
       end; //if
    finally
      //
    end; //try
end;

procedure TFrmVendas.acVendaBuscarConcluidasExecute(Sender: TObject);
begin
   // Buscar Vendas Concluídas  Status = F
   BuscarVenda('F');
end;

procedure TFrmVendas.acVendaBuscarPendentesExecute(Sender: TObject);
begin
   // Buscar Vendas Pendentes Status = A
   BuscarVenda('A');

   //acVendaNova.OnExecute(Sender);
end;

procedure TFrmVendas.acVendaDevolucaoExecute(Sender: TObject);
begin
   FrmDevVenda := TFrmDevVenda.Create(Application);
   try
      FrmDevVenda.ShowModal;
   finally
      FrmDevVenda.Free;
   end;
end;

procedure TFrmVendas.acVendaLimparExecute(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   sqlDelSN, sqlDel: String;
begin
   sqlDelSN:= EmptyStr;

   if (TabPedido.State <> dsInsert) and (TabPedidoIDPed.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            //BinaryRequest:= True;
            DataBase := DM.DWDataBase;
            if MostraMsg('Confirmação','Confirma exclusão do Pedido?', mtConfirmation,[mbYes, mbNo]) = mrYes then
            begin
               try
                  // 01-Controle de SNGPC e 04-SNGPC Obrigatorio Na Venda
                  if FTabConfigRecCtl.ControleSNGPC and FTabConfigRecCtl.SNGPCObrVenda then
                  begin
                    sqlDelSN := 'DELETE FROM arqsngpcvenpac  WHERE IDVenda = ' + FIDVendaSNGPC.ToString +'; ' +
                                'DELETE FROM arqsngpcvencom  WHERE IDVenda = ' + FIDVendaSNGPC.ToString +'; ' +
                                'DELETE FROM arqsngpcven     WHERE IDFilial = '+FILIAL.ToString+' and IDPed = '+TabPedidoIDPed.AsString+'; ';
                  end;

                  SQL.Text := sqlDelSN +
                              'DELETE FROM arqpedidoiterec WHERE IDFilial = '+FILIAL.ToString+' and IDPed = '+TabPedidoIDPed.AsString+'; ' +
                              'DELETE FROM arqpedidoite    WHERE IDFilial = '+FILIAL.ToString+' and IDPed = '+TabPedidoIDPed.AsString+'; ' +
                              'DELETE FROM arqpedido       WHERE IDFilial = '+FILIAL.ToString+' and IDPed = '+TabPedidoIDPed.AsString+'; ';
                  ExecSQL;
               except
                  on E: Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqpedido, IDPed = '+TabPedidoIDPed.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQPEDIDO IDPed = '+TabPedidoIDPed.AsString);
            end; // if
         end; // with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end else
   begin
      if TabPedido.State in dsEditModes then TabPedido.Cancel;

      TabPedIte.DisableControls;
      TabPedIte.First;
      while not(TabPedIte.Eof) do
      begin
        TabPedIte.Delete;
      end;
      TabPedIte.EnableControls;
   end;

   // APagar Botão e voltar
   if btPedSel > 0 then
   begin
     listaBtPedidos[btPedSel].Free;   // Libera o objeto explicitamente
     listaBtPedidos.Delete(btPedSel); // Agora remove a referência da lista
     // Volta para o Primeiro
     btPedSel:= 0;
   end else
   begin
     listaBtPedidos[btPedSel].IDPed  := 0;
     listaBtPedidos[btPedSel].Status := 'A';
   end;
   //
   AbreSQL(listaBtPedidos[btPedSel].IDPed);
   btLimpaIteClick(Sender);
   edClie.SetFocus;
end;

procedure TFrmVendas.acVendaNovaExecute(Sender: TObject);
var
  CloneBtn: TAdvGlowButton;
begin

   // Pedido Aberto
   if (listaBtPedidos[btPedSel].IDPed > 0) and (listaBtPedidos[btPedSel].Status = 'A') then
   begin
     // Salva Atual
     if Salvar then
     begin
       // Inclui Novo Botão de Pedido
       //btPedSel:= btPedSel + 1;
       for var i := 0 to listaBtPedidos.Count - 1 do
         listaBtPedidos[i].btPedido.Align := alNone;

       listaBtPedidos.Add( TarqPedido.Create(0, 'A', CloneAdvGlowButton(Self, btPedido0)) );

       listaBtPedidos[btPedSel].btPedido.Name:= 'btPedido'+btPedSel.ToString;
       listaBtPedidos[btPedSel].btPedido.Caption:= 'PEDIDO '+(btPedSel+1).ToString;
       listaBtPedidos[btPedSel].btPedido.ShortCutHint := ' Ctrl+'+(btPedSel+1).ToString+' ';
       listaBtPedidos[btPedSel].btPedido.ShortCutHintPos := shpTop;

       // Tag do botão é o Nr do Botão
       listaBtPedidos[btPedSel].btPedido.Tag := btPedSel;

       for var i := listaBtPedidos.Count - 1 downto 0 do
         listaBtPedidos[i].btPedido.Align := alRight;
     end;
   end else
   begin     // if (Self.recIDPed > 0) and (Self.recStatusPed = 'F')
     listaBtPedidos[btPedSel].IDPed:= 0;
     listaBtPedidos[btPedSel].Status:= 'A';
     listaBtPedidos[btPedSel].ItensAlterados:= False;
     listaBtPedidos[btPedSel].ReceitasAlteradas:= False;
   end;

   AbreSQL(listaBtPedidos[btPedSel].IDPed);
   edClie.SetFocus;
end;

procedure TFrmVendas.acVendaSalvarExecute(Sender: TObject);
var
  DBEditErro: TLMDDBLabeledEdit;
begin
  DBEditErro:= nil;

  if Salvar then
  begin
    // Precisa do Vendedor informado para fechamento da venda
    if TabPedidoIDVend.AsInteger <= 0 then
      DBEditErro := edVend;

    if DBEditErro <> nil then
    begin
       MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
       DBEditErro.SetFocus;
       Exit;
    end;

    if VendaFecharPagto() then
    begin
      //TabPedIteGrupoSub.Close;

      // APagar Botão e voltar
      if btPedSel > 0 then
      begin
        listaBtPedidos[btPedSel].Free;   // Libera o objeto explicitamente
        listaBtPedidos.Delete(btPedSel); // Agora remove a referência da lista

        // Precisa mudar As Tags
        for var i := 0 to listaBtPedidos.Count - 1 do
        begin
          listaBtPedidos[i].btPedido.Caption:= 'PEDIDO '+(i+1).ToString;
          listaBtPedidos[i].btPedido.ShortCutHint := ' Ctrl+'+(i+1).ToString+' ';
          listaBtPedidos[i].btPedido.ShortCutHintPos := shpTop;
          listaBtPedidos[i].btPedido.Tag := i;
        end;

        // Seta o Último como selecionado
        btPedSel:= listaBtPedidos.Count - 1;
      end else
      begin
        listaBtPedidos[btPedSel].IDPed  := 0;
        listaBtPedidos[btPedSel].Status := 'A';
      end;
      listaBtPedidos[btPedSel].btPedido.Appearance.Color:= $002B70FF;
      listaBtPedidos[btPedSel].btPedido.Appearance.ColorMirror:= $002B70FF;
      //
      AbreSQL(listaBtPedidos[btPedSel].IDPed);

    end else  // Fechamento da Venda não concluída, volta pra venda
    begin     // Neste caso ativa todos promoções/descontos se tiver
      TabPedidoTotDesc.AsFloat   := 0;
      TabPedidoTotPedido.AsFloat := 0;
      //
      TabPedIte.DisableControls;
      TabPedIte.First;
      while not TabPedIte.Eof do
      begin
        TabPedIte.Edit;

        TabPedIteCalcPromDesc.AsInteger:= 1; // Ativa, entra no cálculo de promoção/desconto se tiver
        //TabPedido Totais
        TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * TabPedIteVlrDesc.AsCurrency);
        TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedIteVlrVenda.AsCurrency);

        TabPedIte.Post;
        //
        TabPedIte.Next;
      end;
      TabPedIte.EnableControls;
    end;

    edClie.SetFocus;
  end;

end;

function TFrmVendas.VendaFecharPagto(): Boolean;

  function SalvarFormaPagto(IDFilial, IDPed, IDForPag: Integer; Valor: Currency; Tipo: String): Boolean;
  begin
    Result := False;
    if Valor > 0 then
    begin
      try
        tabPedForPagto.Append;
        tabPedForPagtoIDFilial.AsInteger := IDFilial;
        tabPedForPagtoIDPed.AsInteger := IDPed;
        tabPedForPagtoNropag.AsInteger := 1;
        tabPedForPagtoIDForPag.AsInteger := IDForPag;
        tabPedForPagtoVlrPago.AsCurrency := Valor;
        // 1-Débito 2-Crédito 3-Parcelado
        if (Tipo = 'edDebito') then
          tabPedForPagtoTipcar.AsInteger := 1
        else if (Tipo = 'edCredito') then
          tabPedForPagtoTipcar.AsInteger := 2
        else if (Tipo = 'edAprazo') then
          tabPedForPagtoTipcar.AsInteger := 3
        else
          tabPedForPagtoTipcar.AsInteger := 0;
        //
        tabPedForPagto.Post;
        Result := True;
      except
        tabPedForPagto.Cancel;
        raise; // Re-raise the exception
      end;
    end;
  end;

begin
   Result:= False;

   FrmFecVenda := TFrmFecVenda.Create(Application);
   try
      if FParamVendas.VenFecha = 0 then // 0-Fechamento Obrigatório
      begin
        FrmFecVenda.parFechaObg:= True;
        FrmFecVenda.pnFormasPagto.Visible:= True;
        FrmFecVenda.btFinalizar.Enabled:= False;
      end else                          // 1-Fechamento Rápido
      begin
        FrmFecVenda.parFechaObg:= False;
        FrmFecVenda.pnFormasPagto.Visible:= False;
        FrmFecVenda.Height:= FrmFecVenda.Height-FrmFecVenda.pnFormasPagto.Height;
        FrmFecVenda.btFinalizar.Enabled:= True;
      end;

      FrmFecVenda.parCestaObg:= (FParamVendas.VenCesta = 0);  // 0-Obrigatório / 1-Opcional - Nr. Cesta no Fechamento da Venda
      FrmFecVenda.edNrCesta.Text:= '';

      // Código das Formas de Pagto onde Cliente é obrigatório
      FrmFecVenda.parVenFormaPagto:= FParamVendas.VenFormaPagtoClienteObg;
      // Código do Cliente Obrigatório para Formas de Pagto
      FrmFecVenda.parIDPess:= TabPedidoIDPess.AsInteger;

      // Formas de Pagto Válidas para Promoções/Descontos
      // Pega todas as Formas de Pagto de Cada Item com Promoção/Desconto
      // E agrupa todas as Formas Comuns a todos os Itens/Produtos
      // Ou seja contém todas formas pagto válidas para obter 100% dos descontos
      FFormasPagtoValidasPromDesc:= FormasPagtoValidasPromDesc();
      FrmFecVenda.OnRecalcPromDesc:= RecalDescPromDesc;
      FControlMsgFormasPagto:= EmptyStr; // Controla para mostrar a Mensagem das Formas Pagto apenas uma vez

      // Formas de Pagto Disponíveis Na Venda
      tabFormaPagto.last;
      while not tabFormaPagto.Bof do
      begin
        FrmFecVenda.FormaPagtoInclui(tabFormaPagtoIDForPag.AsInteger,
                                      tabFormaPagtoIndAtivo.AsBoolean );
        tabFormaPagto.Prior;
      end;

      // Ordena Formas de Pagto Válidas para Promoções/Descontos
      // colocando as Válidas antes e deixando as não válidas por último
      tabFormaPagto.First;
      while not tabFormaPagto.Eof do
      begin
        FrmFecVenda.FormaPagtoOrdem(tabFormaPagtoIDForPag.AsInteger,
                                      FFormasPagtoValidasPromDesc );
        tabFormaPagto.Next;
      end;

      FrmFecVenda.retLimCreCli:= 0;
      FrmFecVenda.edAprazoParc.MaxValue:= 100;
      // Formas de Pagto permitidas para o Convênio do Cliente (se tiver)
      if retConvenio.IDConv > 0 then
      begin
        // Não Permite venda a prazo - 05 Venda a Prazo
        if not retConvenio.IndVenPra then
        begin
          FrmFecVenda.FormaPagtoInclui(04, False); // Cheque
          FrmFecVenda.FormaPagtoInclui(05, False); // Desativa Venda a Prazo
        end;

        // Não Permite venda a vista
        if not retConvenio.IndVenVis then
        begin
          // Desativa Todas Formas Pagto a Vista
          FrmFecVenda.FormaPagtoInclui(01, False);  // Dinheiro
          FrmFecVenda.FormaPagtoInclui(02, False);  // Débito
          FrmFecVenda.FormaPagtoInclui(03, False);  // Crédito
          FrmFecVenda.FormaPagtoInclui(06, False);  // Carteira Digital
          FrmFecVenda.FormaPagtoInclui(07, False);  // Pix
          FrmFecVenda.FormaPagtoInclui(09, False);  // Cupom/Voucher
        end;

        // Limite de parcelas Conforme Cadastro do Convênio
        if retConvenio.NroMaxPar > 0 then
          FrmFecVenda.edAprazoParc.MaxValue:= retConvenio.NroMaxPar;

        // Limite de Crédito do Cliente (Convênio ou do Cadastro do Cliente o que for maior)
        if retConvenio.LimCreCli > 0 then
          FrmFecVenda.retLimCreCli:= retConvenio.LimCreCli;
      end;
      
      FrmFecVenda.ShowModal;  // Mostra Tela de Fechamento

      if (FrmFecVenda.retIDForPag_Principal > 0) then
      begin
        Result:= True;

        // Salva Pedido no Caixa
        if not(TabPedido.State in dsEditModes) then
          TabPedido.Edit;
        TabPedidoStatus.AsString   := 'C'; // No Caixa
        TabPedidoIDForPag.AsInteger:= FrmFecVenda.retIDForPag_Principal;
        TabPedidoNroCesta.AsString := FrmFecVenda.retNroCesta;

        var recID:= MyApplayUpdates(TabPedido, 'IDPed', 'IDPed = '+listaBtPedidos[btPedSel].IDPed.ToString, TabPedido.State, True);
        //
        tabPedForPagto.Close;
        tabPedForPagto.ParamByName('IDFilial').AsInteger:= TabPedidoIDFilial.AsInteger;
        tabPedForPagto.ParamByName('IDPed').AsInteger:= TabPedidoIDPed.AsInteger;
        tabPedForPagto.Open;

        for var I := 0 to High(FrmFecVenda.retFormasPagto) do
        begin
          if TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).AsCurrency > 0 then
            SalvarFormaPagto(TabPedidoIDFilial.AsInteger,
                               TabPedidoIDPed.AsInteger,
                                 TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).Tag,
                                   TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).AsCurrency,
                                     TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).Name);
        end;

        MyApplayUpdatesAll(tabPedForPagto, 'IDPed', 'IDPed = 0', True);

        tabPedForPagto.Close;
      end;

   finally
      FrmFecVenda.Free;
   end;

end;

// Recalcula o desconto para Itens com Promoção/Desconto
// Caso forma de Pagto escolhida no fechamento não for aceita para a Promoção ou desconto
procedure TFrmVendas.RecalDescPromDesc(Sender: TObject; const codFormaPagto: string);
var
  msgProm, msgConvenio, msgDescManual: String;

  function DescrFormasPagto(formPagto: String): String;
  begin
    Result:= formPagto;
    Result:= StringReplace(Result, '01', 'DINHEIRO', []);
    Result:= StringReplace(Result, '02', 'DÉBITO', []);
    Result:= StringReplace(Result, '03', 'CRÉDITO', []);
    Result:= StringReplace(Result, '04', 'CHEQUE', []);
    Result:= StringReplace(Result, '05', 'PRAZO', []);
    Result:= StringReplace(Result, '06', 'CART.DIGITAL', []);
    Result:= StringReplace(Result, '07', 'PIX', []);
    Result:= StringReplace(Result, '08', 'CONVÊNIO', []);
    Result:= StringReplace(Result, '09', 'CUPOM/VOUCHER', []);
  end;
begin
  msgProm:= EmptyStr;
  msgConvenio:= EmptyStr;
  msgDescManual:= EmptyStr;
  //TabPedido Totais
  TabPedidoTotDesc.AsFloat   := 0;
  TabPedidoTotPedido.AsFloat := 0;
  //
  TabPedIte.DisableControls;
  TabPedIte.First;
  while not TabPedIte.Eof do
  begin
    TabPedIte.Edit;

    // Regra Convênio A Vista
    // Forma Pagto Desconto deve Existir + Forma Pagto Atual à Vista ('01,02,03,06,07') 
    // Tabela de desconto existir + Cliente Possui Convenio + Convênio NÃO permite desconto à Vista
    if (AnsiPos(codFormaPagto, TabPedIteFormFpgCod.AsString) > 0) and (AnsiPos(codFormaPagto, '01,02,03,06,07') > 0) and
         (TabPedIteIDDesc.AsInteger > 0) and (retConvenio.IDConv > 0) and not(retConvenio.IndDesVenVis) then
    begin
      TabPedIteCalcPromDesc.AsInteger:= 0; // Desativa  

      msgConvenio:= msgConvenio + 'Convênio ' + retConvenio.Nomcon + ' NÃO permite Desconto à Vista' + #13+#10;

      //TabPedido Totais
      TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * 0); // Zera desconto
      TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedItePrecoVen.AsCurrency);
    end
    else // Regra Convênio A Prazo
         // Forma Pagto Desconto A Prazo (05) deve Existir + Forma Pagto A Prazo (05)
         // Tabela de desconto existir + Cliente Possui Convenio + Convênio NÃO permite desconto À Prazo
    if (AnsiPos(codFormaPagto, TabPedIteFormFpgCod.AsString) > 0) and (codFormaPagto = '05') and
         (TabPedIteIDDesc.AsInteger > 0) and (retConvenio.IDConv > 0) and not(retConvenio.IndDesVenPra) then
    begin
      TabPedIteCalcPromDesc.AsInteger:= 0; // Desativa

      msgConvenio:= msgConvenio + 'Convênio ' + retConvenio.Nomcon + ' NÃO permite Desconto à Prazo' + #13+#10;

      //TabPedido Totais
      TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * 0); // Zera desconto
      TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedItePrecoVen.AsCurrency);
    end
    else // Regra das Promoções e Descontos
    if (AnsiPos(codFormaPagto, TabPedIteFormFpgCod.AsString) = 0) and
        ((TabPedIteIDProm.AsInteger > 0) or (TabPedIteIDDesc.AsInteger > 0)) then
    begin
      TabPedIteCalcPromDesc.AsInteger:= 0; // Desativa, não entra no cálculo promoção/desconto

      msgProm:= msgProm + TabPedIteDespro.AsString + #13+#10;

      //TabPedido Totais
      TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * 0); // Zera desconto
      TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedItePrecoVen.AsCurrency);
    end
    else // Regra % Desconto Manual pelo Grupo/SubGrupo
    if (codFormaPagto = '05') and ((TabPedIteIDProm.AsInteger = 0) and (TabPedIteIDDesc.AsInteger = 0)) and
         (TabPedIteDescMaxCalc.AsCurrency > 0) and (TabPedItePerDesc.AsCurrency > 0) then
    begin

      // Indica se Bloqueia descontos Manual do Grupo/SubGrupo
      // para este produto (Parâmetro do Cadastro de Produtos)
      // "bloquear descontos” ('0' = Não/'1' = Sim) Produto não pode conceder desconto Máximo digitado,definido Grupo/Subgrupo
      if (TabPedIteIndBloDes.AsString = '0') then
      begin
        if not(TabPedIteGrupoPerDescPrazo.AsBoolean) and  // Indica se permite descontos à prazo (0=Não/1=Sim)
            (TabPedIteGrupoDescMax.AsCurrency > 0) and (TabPedIteGruSubDescMax.AsCurrency = 0) then
        begin
          TabPedIteCalcPromDesc.AsInteger:= 0; // Desativa, Manual (Grupo)

          msgDescManual:= msgDescManual + 'Desconto Manual do Grupo NÃO permite Desconto à Prazo' + #13+#10;
        end;

        if not(TabPedIteGruSubPerDescPrazo.AsBoolean) and  // Indica se permite descontos à prazo (0=Não/1=Sim)
            (TabPedIteGrupoDescMax.AsCurrency >= 0) and (TabPedIteGruSubDescMax.AsCurrency > 0) then
        begin
          TabPedIteCalcPromDesc.AsInteger:= 0; // Desativa, Manual (SubGrupo)

          msgDescManual:= msgDescManual + 'Desconto Manual do SubGrupo NÃO permite Desconto à Prazo' + #13+#10;
        end;

        if (TabPedIteCalcPromDesc.AsInteger = 0) then
        begin
          //TabPedido Totais
          TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * 0); // Zera desconto
          TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedItePrecoVen.AsCurrency);
        end else
        begin
          //TabPedido Totais
          TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * TabPedIteVlrDesc.AsCurrency);
          TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedIteVlrVenda.AsCurrency);
        end;
      end;

    end
    else
    begin
      TabPedIteCalcPromDesc.AsInteger:= 1; // Ativa, entra no cálculo de promoção/desconto

      //TabPedido Totais
      TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * TabPedIteVlrDesc.AsCurrency);
      TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedIteVlrVenda.AsCurrency);
    end;
    TabPedIte.Post;
    //
    TabPedIte.Next;
  end;
  TabPedIte.EnableControls;

  if (msgProm <> EmptyStr) or (msgConvenio <> EmptyStr) or (msgDescManual <> EmptyStr) then
  begin
    var mensagem:= '';

    if msgDescManual <> EmptyStr then
      mensagem:= msgDescManual;

    if msgConvenio <> EmptyStr then
    begin
      if mensagem = EmptyStr then
        mensagem:= msgConvenio
      else
        mensagem:= mensagem + #13#10 + msgConvenio;
    end;

    if msgProm <> EmptyStr then
    begin
      var descrFormPagtoValidas:= DescrFormasPagto(FFormasPagtoValidasPromDesc);

      if mensagem <> EmptyStr then
        mensagem:= mensagem + #13+#10 + msgProm +
                   ' Para 100% Descontos/Promoções, usar: ' + #13#10 +
                     descrFormPagtoValidas
      else
        mensagem:= msgProm + #13#10 + ' Para 100% Descontos/Promoções, usar: '+#13#10+
                     descrFormPagtoValidas
    end;

    // Mostra a Mensagem Apenas uma vez
    if (FControlMsgFormasPagto <> mensagem) then
    begin
      FControlMsgFormasPagto:= mensagem;

      MostraMsg('Promoção/Desconto',FControlMsgFormasPagto , mtWarning, [mbOk], 320, 780);
    end;

  end;
end;


function TFrmVendas.FormasPagtoValidasPromDesc(): String;
var
  SLIntersect, SLCurrent: TStringList;
  i: Integer;
begin
  Result:='';
  SLIntersect := TStringList.Create;
  SLCurrent := TStringList.Create;
  try
    SLIntersect.Delimiter := ',';
    SLIntersect.StrictDelimiter := True;

    TabPedIte.DisableControls;
    try
      TabPedIte.First;
      if not TabPedIte.Eof then
      begin
        // Inicializa com os valores da primeira linha
        SLIntersect.DelimitedText := TabPedIteFormFpgCod.AsString;
        TabPedIte.Next;

        while not TabPedIte.Eof do
        begin
          SLCurrent.Clear;
          SLCurrent.Delimiter := ',';
          SLCurrent.StrictDelimiter := True;
          SLCurrent.DelimitedText := TabPedIteFormFpgCod.AsString;

          // Remove os itens que não estão na linha atual
          for i := SLIntersect.Count - 1 downto 0 do
          begin
            if SLCurrent.IndexOf(SLIntersect[i]) = -1 then
              SLIntersect.Delete(i);
          end;

          TabPedIte.Next;
        end;
      end;
    finally
      TabPedIte.EnableControls;
    end;

    // Monta a string final com os valores comuns
    Result := SLIntersect.DelimitedText;
  finally
    SLIntersect.Free;
    SLCurrent.Free;
  end;
end;

procedure TFrmVendas.AjustGrid;
begin
   TStringGrid(dbgItens).DefaultRowHeight := BaseRowHeight - 3;
   dbgItens.Width := dbgItens.Width - 10;
   dbgItens.Width := dbgItens.Width + 10;
end;

procedure TFrmVendas.dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

   if Column.ID = 8  then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3,Rect.Top+4, 0); // Delete
   if Column.ID = 9  then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3,Rect.Top+4,11); // Agenda Venda
   if Column.ID = 10 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3,Rect.Top+4, 8); // Descontos
   if Column.ID = 11 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3,Rect.Top+4,10); // Estoque
   if Column.ID = 12 then  // Receitas
   begin
      if TabPedIteUsoRece.AsString <> '' then
           DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4,Rect.Top+4,12)
      else DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4,Rect.Top+4,13);
   end;
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmVendas.dbgItensEnter(Sender: TObject);
begin
    //timProdGupoSub.Enabled:= True;

    //edGrupo.Visible:= True;
    //edGrupoSub.Visible:= True;
    //edGrupoDescMax.Visible:= True;
    //edGrupoDescSubs.Visible:= True;
end;

procedure TFrmVendas.dbgItensExit(Sender: TObject);
begin
    //edGrupo.Visible:= False;
    //edGrupoSub.Visible:= False;
    //edGrupoDescMax.Visible:= False;
    //edGrupoDescSubs.Visible:= False;

    //timProdGupoSub.Enabled:= False;
end;

procedure TFrmVendas.dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE)  {and (ssCtrl in Shift)} then
  begin
    acGridItemExclui.OnExecute(Self);
    Key := 0;
  end
  else if (Key = VK_INSERT)  {and (ssCtrl in Shift)} then
  begin
    acGridItemInsere.OnExecute(Self);
    Key := 0;
  end;
  //
  if (Key = VK_UP) or (Key = VK_DOWN) then
  begin
    //if edGrupo.Visible then
    //begin
      // Reinicia o timer a cada tecla pressionada
      //timProdGupoSub.Enabled := False;
      //timProdGupoSub.Enabled := True;
    //end;
  end;
end;

function TFrmVendas.CloneAdvGlowButton(AOwner: TComponent; Source: TAdvGlowButton): TAdvGlowButton;
var
  Clone: TAdvGlowButton;
begin
  Clone := TAdvGlowButton.Create(AOwner);
  Clone.Parent := Source.Parent;
  Clone.Name := ''; // evitar conflitos
  //
  Clone.Align := Source.Align;
  Clone.AlignWithMargins := Source.AlignWithMargins;
  Clone.ParentFont := Source.ParentFont;
  Clone.Rounded := Source.Rounded;
  Clone.Appearance.Assign(Source.Appearance);
  Clone.Picture.Assign(Source.Picture);

  Clone.Left := Source.Left;
  Clone.Top := Source.Top;
  Clone.Width := Source.Width;
  Clone.Height := Source.Height;
  Clone.Caption := Source.Caption;
  Clone.Font.Assign(Source.Font);
  Clone.OnClick := Source.OnClick; // Copia o evento de clique
  //
  Result := Clone;
end;

procedure TFrmVendas.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmVendas.btLimpaIteClick(Sender: TObject);
begin
  edNompro.Clear;
  edFabr.Text:= '';
  edQtdped.AsFloat:= 0;
  edVlrVenda.AsFloat:= 0;
  edPerDesc.AsFloat:= 0;
  edTotalpedIte.AsFloat:= 0;

  edVlrVenda.ReadOnly:= False;
  edPerDesc.ReadOnly:= False;
  //
  LimpaProdBusca();
  edNompro.SetFocus;
end;

procedure TFrmVendas.btPedido0Click(Sender: TObject);
begin
  if TAdvGlowButton(Sender).Tag <> btPedSel then
  begin
    // Salva Atual
    if listaBtPedidos[btPedSel].ItensAlterados or
         listaBtPedidos[btPedSel].ReceitasAlteradas then
      Salvar;

    listaBtPedidos[btPedSel].btPedido.Appearance.Color:= $00F4F8FF;
    listaBtPedidos[btPedSel].btPedido.Appearance.ColorMirror:= $00F4F8FF;

    // Armazena ID na Tag
    btPedSel:= TAdvGlowButton(Sender).Tag;

    listaBtPedidos[btPedSel].btPedido.Appearance.Color:= $002B70FF;
    listaBtPedidos[btPedSel].btPedido.Appearance.ColorMirror:= $002B70FF;

    AbreSQL(listaBtPedidos[btPedSel].IDPed);
  end;
end;

procedure TFrmVendas.btPed3Click(Sender: TObject);
var
  CloneBtn: TAdvGlowButton;
begin
  CloneBtn := CloneAdvGlowButton(Self, btPedido0);
  CloneBtn.Parent := PanelPedAbe;
  CloneBtn.Caption:= 'Clonado';
end;

function TFrmVendas.ItemJaExiste(): Boolean;
begin
  Result:= False;
  TabPedIte.DisableControls;

  Result:= TabPedIte.Locate('IDProd', retProdBusca.IDProd, []);

  TabPedIte.EnableControls;
end;

procedure TFrmVendas.btSalvaIteClick(Sender: TObject);
var
  recID: Integer;
  vlrUnitario: String;
  percDescProg: Double;
begin
  // Regra - Valor de Venda Zerado
  vlrUnitario:= FormatFloat('#,##0.00',retProdBusca.PrecoVen);
  if SameText(vlrUnitario, '0,00') then
  begin
    MostraMsg('Atenção','Valor de Venda ZERADO, não é possível inserir o item!',mtWarning, [mbOk]);
    exit;
  end;

  // Qtdped: Double;              // Quantidade vendida
  // PerDesc: Double;             // Percentual do Desconto
  // VlrDesc: Double;             // Valor unitário do Desconto
  // VlrVenda: Double;            // Valor unitário da venda do Item (com desconto)

  // Regra - 0-Permite / 1-Não permite - venda com preço de venda abaixo do custo médio
  if (ParamVendas.VenCustoMed = 1) then
  begin
    if (retProdBusca.CustoMed > 0) then
    begin
      if (retProdBusca.VlrVenda < retProdBusca.CustoMed) then
      begin
        MostraMsg('Atenção','Valor de Venda abaixo do custo médio, não é possível inserir o item!',mtWarning, [mbOk]);
        exit;
      end;
    end;
  end;

  if (retProdBusca.IDProd > 0) and (edNompro.Text <> EmptyStr) then
  begin
    if (listaBtPedidos[btPedSel].IDPed = 0) and (TabPedido.State = dsInsert) then
    begin
      TabPedidoNext.Open;
      listaBtPedidos[btPedSel].IDPed := TabPedidoNext.FieldByName('Next_IDPed').AsInteger;
      TabPedidoNext.Close;

      TabPedido.FieldByName('IDPed').AsInteger:= listaBtPedidos[btPedSel].IDPed;

      TabPedidoIDFilial.Value := FILIAL;
      TabPedidoStatus.Value   := listaBtPedidos[btPedSel].Status;
      TabPedidoDatped.Value   := DataServer;

      recID:= MyApplayUpdates(TabPedido, 'IDPed', 'IDPed = '+listaBtPedidos[btPedSel].IDPed.ToString, TabPedido.State, True);
      //
      TabPedido.DisableControls;
      TabPedido.Close;
         var auxSQL := 'SELECT PED.*,CLI.Nompes AS NomeCli,PBM.NomPBM,CON.Nomcon,VEN.Nompes AS Nomven FROM arqpedido PED '+
                   'LEFT JOIN arqpbm PBM ON PED.IDPBM = PBM.IDPBM '+
                   'LEFT JOIN arqconvenio CON ON PED.IDConv = CON.IDConv '+
                   'LEFT JOIN arqpessoa CLI ON PED.IDPess = CLI.IDPess '+
                   'LEFT JOIN arqpessoa VEN ON PED.IDVend = VEN.IDPess ';
     TabPedido.SQL.Text := auxSQL+iif(listaBtPedidos[btPedSel].IDPed > 0,' WHERE PED.IDPed = '+listaBtPedidos[btPedSel].IDPed.ToString,'')+' LIMIT 1';
     TabPedido.Open;
     TabPedido.EnableControls;

     TabPedido.Edit;
    end else
    begin
      if (listaBtPedidos[btPedSel].IDPed > 0) and (TabPedido.State = dsBrowse) then
        TabPedido.Edit;

     TabPedidoIDFilial.Value := FILIAL;
     TabPedidoStatus.Value   := listaBtPedidos[btPedSel].Status;
     TabPedidoDatped.Value   := DataServer;
    end;

    // Qtd Itens
    edTotIte.AsInteger:= edTotIte.AsInteger + Trunc(retProdBusca.Qtdped);
    if ItemJaExiste() then
    begin
      TabPedIte.Edit;
      // Valores
      TabPedIteQtdped.AsCurrency  := TabPedIteQtdped.AsCurrency + retProdBusca.Qtdped;

      if (retProdBusca.IDProm > 0) and
      FTabPromProgr.ExisteTabIdProd(retProdBusca.IDProm, retProdBusca.IDProd) then
      begin
        retProdBusca.VlrVenda:= FTabPromProgr.PegaVlrVen(retProdBusca.IDProm, retProdBusca.IDProd, TabPedIteQtdped.AsCurrency);
        retProdBusca.PerDesc := FTabPromProgr.PegaPerDesc(retProdBusca.IDProm, retProdBusca.IDProd, TabPedIteQtdped.AsCurrency);
      end;
      //
      TabPedIte.Post;
    end else
    begin
      TabPedIte.Append;
      TabPedIteIDFilial.AsInteger:= FILIAL;
      TabPedIteIDPed.AsInteger := listaBtPedidos[btPedSel].IDPed;
      TabPedIteIDVend.AsInteger:= TabPedidoIDVend.AsInteger; // Nr. do Vendedor
      TabPedIteNroite.AsInteger:= edTotIte.AsInteger;        // Nr. do Item na venda
      TabPedIteIDProd.AsInteger:= retProdBusca.IDProd;
      // Valores
      TabPedIteQtdped.AsCurrency  := retProdBusca.Qtdped;

      TabPedItePrecoVen.AsCurrency:= retProdBusca.PrecoVen;
      TabPedItePrecoUni.AsCurrency:= retProdBusca.PrecoUni;

      TabPedIteVlrDesc.AsCurrency := retProdBusca.VlrDesc;
      TabPedIteVlrVenda.AsCurrency:= retProdBusca.VlrVenda;
      //
      TabPedItePerDesc.AsCurrency := retProdBusca.PerDesc;
      TabPedItePrecoPMC.AsCurrency:= retProdBusca.PrecoPMC;
      TabPedItePrecoFP.AsCurrency := retProdBusca.PrecoFP;
      TabPedItePrecoFab.AsCurrency:= retProdBusca.PrecoFab;
      TabPedIteCustoMed.AsCurrency:= retProdBusca.CustoMed;
      TabPedIteVlrPIS.AsCurrency  := retProdBusca.VlrPIS;
      TabPedIteVlrCOF.AsCurrency  := retProdBusca.VlrCOF;
      TabPedIteUsoRece.AsString   := retProdBusca.UsoRece;

      TabPedIteEstTotal.AsInteger := Trunc(retProdBusca.EstTotal);
      //
      //TabPedIteIndComi.AsString:= '0';
      TabPedIteDespro.AsString := retProdBusca.Despro;
      TabPedIteIDFabr.AsInteger:= retProdBusca.IDFabr;
      TabPedIteNomeFab.AsString:= retProdBusca.Nomefab;
      //

      TabPedIteIndBloDes.AsString         := iif(retProdBusca.IndBloDes, '1', '0');
      TabPedIteIDGrupo.AsInteger          := retProdBusca.IDGrupo;
      TabPedIteDesgru.AsString            := retProdBusca.Desgru;
      TabPedIteGrupoDescMax.AsFloat       := retProdBusca.GrupoDescMax;
      TabPedIteGrupoPerDescPrazo.AsBoolean:= retProdBusca.GrupoPerDescPrazo;

      TabPedIteIDGruSub.AsInteger          := retProdBusca.IDGruSub;
      TabPedIteDesgruSub.AsString          := retProdBusca.DesgruSub;
      TabPedIteGruSubDescMax.AsFloat       := retProdBusca.GruSubDescMax;
      TabPedIteGruSubPerDescPrazo.AsBoolean:= retProdBusca.GruSubPerDescPrazo;

      TabPedIteDesSubs.AsString := retProdBusca.DesSubs;
      TabPedIteDesloc.AsString  := retProdBusca.Desloc;
      //
      TabPedIteIDProm.AsInteger:= retProdBusca.IDProm;         // Cod. Tabela Promoções se tiver
      TabPedIteIDDesc.AsInteger:= retProdBusca.IDDesc;         // Cod. Tabela Descontos se tiver
      TabPedIteFormFpgCod.AsString:= retProdBusca.FormFpgCod;  // Formas Pagto Aceitas Promoções/Descontos

      TabPedIteCalcPromDesc.AsInteger:= 1; // Se tiver promoção/desconto (1=Verdadeiro=Ativo, 0=Falso=Desativado)

      TabPedIte.Post;
    end;

    listaBtPedidos[btPedSel].ItensAlterados:= True;

    //TabPedido
    TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * TabPedIteVlrDesc.AsCurrency);
    TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedIteVlrVenda.AsCurrency);

    RecalculoDescProg(retProdBusca.IDProm, retProdBusca.IDDesc);
  end;
  //
  if FIDProd_UltimoClick <> TabPedIteIDProd.AsInteger then
  begin
    FIDProd_UltimoClick:= TabPedidoIDPed.AsInteger;

    //timProdGupoSub.Enabled := False;
    //timProdGupoSub.Enabled := True;
  end;
  //
  edNompro.Clear;
  edFabr.Text:= '';
  edQtdped.AsFloat:= 0;
  edVlrVenda.AsFloat:= 0;
  edPerDesc.AsFloat:= 0;
  edTotalpedIte.AsFloat:= 0;

  edVlrVenda.ReadOnly:= False;
  edPerDesc.ReadOnly:= False;
  //
  LimpaProdBusca();
  edNompro.SetFocus;
end;

procedure TFrmVendas.RecalculoDescProg(IDProm, IDDesc: Integer);
var
  percDescProg: Currency;

  // Determina Campo do Tipo do Desconto Promoção ('IDProm') ou Desconto ('IDDesc')
  // IDTipo = 'IDProm' ou IDTipo = 'IDDesc'
  procedure Recalcula(IDTipo: String; ID: Integer; percDesc: Currency);
  begin
     TabPedidoTotDesc.AsFloat   := 0;
     TabPedidoTotPedido.AsFloat := 0;
     //
     TabPedIte.DisableControls;
     TabPedIte.First;
     while not TabPedIte.Eof do
     begin
       if (TabPedIte.FieldByName(IDTipo).AsInteger = ID) and
            (TabPedItePerDesc.AsCurrency <> percDesc) then
       begin
         TabPedIte.Edit;
         TabPedIteCalcPromDesc.AsInteger:= 1; // Ativa, entra no cálculo de promoção/desconto se tiver

         if IDTipo = 'IDDesc' then
         begin
           TabPedItePerDesc.AsCurrency := percDesc;
           TabPedIteVlrDesc.AsCurrency := (TabPedItePrecoVen.AsCurrency * TabPedItePerDesc.AsCurrency)/100;
           TabPedIteVlrVenda.AsCurrency:= TabPedItePrecoVen.AsCurrency - TabPedIteVlrDesc.AsCurrency;
         end;

         if IDTipo = 'IDProm' then
         begin
           TabPedItePerDesc.AsCurrency := FTabPromProgr.PegaPerDesc(TabPedIteIDProm.AsInteger,
                                                                      TabPedIteIDProd.AsInteger,
                                                                        TabPedIteQtdped.AsCurrency);
           TabPedIteVlrDesc.AsCurrency := (TabPedItePrecoVen.AsCurrency * TabPedItePerDesc.AsCurrency)/100;
           TabPedIteVlrVenda.AsCurrency:= TabPedItePrecoVen.AsCurrency - TabPedIteVlrDesc.AsCurrency;
         end;

         TabPedIte.Post;


         {
    retProdBusca.VlrVenda:= FTabPromProgr.PegaVlrVen(retProdBusca.IDProm, retProdBusca.IDProd, retProdBusca.Qtdped);
    retProdBusca.PerDesc := FTabPromProgr.PegaPerDesc(retProdBusca.IDProm, retProdBusca.IDProd, retProdBusca.Qtdped);

    retProdBusca.VlrDesc := retProdBusca.PrecoVen-retProdBusca.VlrVenda;
         }
       end;
       //TabPedido Totais
       TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * TabPedIteVlrDesc.AsCurrency);
       TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedIteVlrVenda.AsCurrency);
       //
       TabPedIte.Next;
     end;
     TabPedIte.EnableControls;
  end;

begin
    percDescProg:= 0;

    // Calculo Desconto Progressivo
    {if (IDDesc > 0) and FTabDescProgr.ExisteTabIdDesc(IDDesc) then
    begin
      if FTabDescProgr.MudouUltPercDesc(IDDesc) then
      begin
        percDescProg:= FTabDescProgr.PercDesc(IDDesc);

        Recalcula('IDDesc', IDDesc, percDescProg);
      end;
    end;}

    // Calculo Promoção Progressiva
    if (IDProm > 0) and FTabPromProgr.ExisteTabIdProm(IDProm) then
    begin
      Recalcula('IDProm', IDProm, 0);
    end;
end;

procedure TFrmVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabPedite.Active then TabPedite.Close;
   if TabPedido.Active then TabPedido.Close;

   FadeInOut(Self,'Out',10);
   Action := caFree;
end;

function TFrmVendas.RetornaConvenio(const IDPess: Integer; IDConv: Integer = 0): TArqConvenio;
var
  Query: TRESTDWClientSQL;

  function MontaSQLConvenio: string;
  begin
    Result :=
      'SELECT CON.IDConv, CON.Nomcon, ' +
      'CON.IndVenVis, CON.IndVenPra, CON.IndDesProg, CON.IndPreProm, CON.IndDesVenVis, ' +
      'CON.IndDesVenPra, CON.NroMaxPar, CON.LimCreCli, CON.DiaFecha, CON.DiaVence, COP.VlrLimite ' +
      'FROM arqpessconv COP ' +
      'LEFT JOIN arqconvenio CON ON CON.IDConv = COP.IDConv ' +
      'WHERE COP.IndAtivo = 1 AND CON.IndAtivo = 1 ';

    if IDPess > 0 then
    begin
      Result := Result + Format('AND COP.IDPess = %d ', [IDPess]);
      if IDConv > 0 then
        Result := Result + Format('AND CON.IDConv = %d ', [IDConv]);
    end
    else
      Result := Result + 'AND COP.IDPess = 0 ';

    Result := Result + 'GROUP BY CON.IDConv ORDER BY CON.Nomcon';
  end;

  procedure PreencheConvenio(var Convenio: TArqConvenio);

    function BoolField(const FieldName: string): Boolean;
    begin
      Result := Query.FieldByName(FieldName).AsString = '1';
    end;

  begin
    with Convenio do
    begin
      IDConv       := Query.FieldByName('IDConv').AsInteger;
      Nomcon       := Query.FieldByName('Nomcon').AsString;
      IndVenVis    := BoolField('IndVenVis');
      IndVenPra    := BoolField('IndVenPra');
      IndDesProg   := BoolField('IndDesProg');
      IndPreProm   := BoolField('IndPreProm');
      IndDesVenVis := BoolField('IndDesVenVis');
      IndDesVenPra := BoolField('IndDesVenPra');
      DiaVence     := Query.FieldByName('DiaVence').AsInteger;
      DiaFecha     := Query.FieldByName('DiaFecha').AsInteger;
      NroMaxPar    := Query.FieldByName('NroMaxPar').AsInteger;

      // Se Limite de Crédito do Cliente for maior que do Convênio, usa o do Cliente
      if (Query.FieldByName('VlrLimite').AsCurrency >  Query.FieldByName('LimCreCli').AsCurrency) then
        LimCreCli:= Query.FieldByName('VlrLimite').AsCurrency
      else
        LimCreCli:= Query.FieldByName('LimCreCli').AsCurrency;
    end;
  end;

begin
  Result := Default(TArqConvenio);

  Query := TRESTDWClientSQL.Create(nil);
  try
    //Query.BinaryRequest:= True;
    Query.DataBase := DM.DWDataBase;
    Query.SQL.Text := MontaSQLConvenio;
    Query.Open;

    if not Query.IsEmpty then
    begin
      if (IDConv > 0) or (Query.RecordCount = 1) then
        PreencheConvenio(Result);
    end;
  finally
    Query.Free;
  end;
end;

procedure TFrmVendas.LimpaProdBusca();
begin
  retProdBusca.IDFilial:= 0;           // ID da Filial da Farmácia
  retProdBusca.IDPed   := 0;           // ID do Pedido de Vendas
  retProdBusca.Nroite  := 0;           // Número Item (AutoInc via trigger)
  retProdBusca.IDProd  := 0;           // ID do Produto
  retProdBusca.Nrolot  := '';          // Número do Lote do Produto
  retProdBusca.IDVend  := 0;           // ID do Vendedor do Item
  retProdBusca.IndComi := 0;           // Incide comissão Default(1) Sim
  retProdBusca.PrecoVen:= 0;           // Preço de Venda tabela na data da venda
  retProdBusca.PrecoPMC:= 0;           // Preço Máximo ao Consumidor na data da venda
  retProdBusca.PrecoFP := 0;           // Preço Fármacia Popular na data da venda
  retProdBusca.PrecoFab:= 0;           // Preço unitário de Fábrica na data da venda
  retProdBusca.CustoMed:= 0;           // Custo Médio na Data da Venda
  retProdBusca.VlrPIS  := 0;           // Valor do PIS
  retProdBusca.VlrCOF  := 0;           // Valor do COFINS
  retProdBusca.Qtdped  := 0;           // Quantidade vendida
  retProdBusca.PerDesc := 0;           // Percentual do Desconto
  retProdBusca.VlrDesc := 0;           // Valor unitário do Desconto
  retProdBusca.VlrVenda:= 0;           // Valor unitário da venda do Item (com desconto)
  retProdBusca.IndConf := '0';         // Indicador se Conferido pelo Caixa ('0' = Não / '1' = Sim)
  retProdBusca.Despro  := '';          // Descrição do Produto
  retProdBusca.Nomefab := '';          // Nome Fabricante (tabela arqpessoa)
  retProdBusca.EstTotal:= 0;           // Estoque Total
  retProdBusca.PrecoUni:= 0;
end;

function TFrmVendas.ParamVendas(): TArqParametros;
var
  Query: TRESTDWClientSQL;
begin
  Result.CNPJFar:= EmptyStr;
  Result.IDFilial:= FILIAL;
  Result.VenFecha:= 0;
  Result.VenCesta:= 0;
  Result.VenCustoMed:= 0;
  Result.VenProdExibComEst:= 0;
  Result.VenProdBloqSemEst:= 0;
  //
  Query := TRESTDWClientSQL.Create(nil);
  try
    //Query.BinaryRequest:= True;
    Query.DataBase:= DM.DWDataBase;
    Query.SQL.Text := Format('select CNPJFar, IDFilial, VenFecha, VenCesta, VenCustoMed, VenProdExibComEst, VenProdBloqSemEst, VenFormaPagto '+
                             'from arqparametros '+
                             'where IDFilial = %s',
                      [FILIAL.ToString]);
    Query.Open;

    if not(Query.IsEmpty) then
    begin
      Result.CNPJFar:= Query.FieldByname('CNPJFar').AsString;
      Result.IDFilial:= Query.FieldByname('IDFilial').AsInteger;
      Result.VenFecha:= Query.FieldByname('VenFecha').AsInteger;
      Result.VenCesta:= Query.FieldByname('VenCesta').AsInteger;
      Result.VenCustoMed:= Query.FieldByname('VenCustoMed').AsInteger;
      Result.VenProdExibComEst:= Query.FieldByname('VenProdExibComEst').AsInteger;
      Result.VenProdBloqSemEst:= Query.FieldByname('VenProdBloqSemEst').AsInteger;
      Result.VenFormaPagtoClienteObg:= Query.FieldByname('VenFormaPagto').AsString;
    end;

  finally
    Query.Free;
  end;

end;

procedure TFrmVendas.ReaplicaRegrasPromocaoDesconto(const IDPess, IDConv: Integer);
begin
  // Guarda o Cliente (IDPess) e Convênio do Cliente (IDConv)
  // Se mudar atualiza Promoções e Descontos dos produtos já selecionados
  if (FIDPessUltPesq <> IDPess) or (FIDConvUltPesq <> IDConv) then
  begin
    FIDPessUltPesq:= IDPess;
    FIDConvUltPesq:= IDConv;

    // Se tiver produtos selecionados e houve alteração de Cliente e/ou Convênio
    // precisa verificar se possui Promoções/Descontos disponíveis
    // e aplicar aos produtos que já estão selecionados
    if not TabPedIte.IsEmpty then
    begin
      TabPedidoTotDesc.AsFloat   := 0;
      TabPedidoTotPedido.AsFloat := 0;
      //
      TabPedIte.DisableControls;
      TabPedIte.First;
      while not TabPedIte.Eof do
      begin
        retProdBusca.IDProd    := TabPedIteIDProd.AsInteger;
        retProdBusca.Qtdped    := TabPedIteQtdped.AsCurrency;
        retProdBusca.PrecoVen  := TabPedItePrecoVen.AsCurrency;
        retProdBusca.PrecoUni  := TabPedItePrecoUni.AsCurrency;
        retProdBusca.VlrDesc   := 0;
        retProdBusca.VlrVenda  := TabPedItePrecoVen.AsCurrency;
        retProdBusca.PerDesc   := 0;
        retProdBusca.PrecoPMC  := TabPedItePrecoPMC.AsCurrency;
        retProdBusca.PrecoFP   := TabPedItePrecoFP.AsCurrency;
        retProdBusca.PrecoFab  := TabPedItePrecoFab.AsCurrency;
        retProdBusca.CustoMed  := TabPedIteCustoMed.AsCurrency;
        retProdBusca.VlrPIS    := TabPedIteVlrPIS.AsCurrency;
        retProdBusca.VlrCOF    := TabPedIteVlrCOF.AsCurrency;
        retProdBusca.UsoRece   := TabPedIteUsoRece.AsString;
        retProdBusca.EstTotal  := TabPedIteEstTotal.AsInteger;
        retProdBusca.Despro    := TabPedIteDespro.AsString;
        retProdBusca.Nomefab   := TabPedIteNomeFab.AsString;
        retProdBusca.IDProm    := 0;
        retProdBusca.IDDesc    := 0;
        retProdBusca.FormFpgCod:= EmptyStr;
        // 
        if retProdBusca.IDProd > 0 then
        begin
          // Cliente Possui Convênio
          if retConvenio.IDConv > 0 then
          begin
            // Convênio do Cliente Permite Preços Promocionais
            if retConvenio.IndPreProm then
              // 1-Aplica Regras de Promoções
              AplicaRegrasPromocao(FILIAL,
                                    TabPedidoIDPess.AsInteger, // IDPess Cliente
                                    TabPedidoIDConv.AsInteger, // IDConv Convênio
                                    retProdBusca // Dados do produto Pesquisado
                                   );
          end else
          begin
            // 1-Aplica Regras de Promoções
            AplicaRegrasPromocao(FILIAL,
                                    TabPedidoIDPess.AsInteger, // IDPess Cliente
                                    TabPedidoIDConv.AsInteger, // IDConv Convênio
                                    retProdBusca // Dados do produto Pesquisado
                                   );
          end;
                        
          if retProdBusca.IDProm = 0 then // Se não tem promoção Pega Desconto se tiver
          begin
            // 2-Aplica Regras de Descontos
            AplicaRegrasDesconto(FILIAL,
                             TabPedidoIDPess.AsInteger, // IDPess Cliente
                             TabPedidoIDConv.AsInteger, // IDConv Convênio
                             retProdBusca // Dados do produto Pesquisado
                            );
          end;
        end;
        //
        TabPedIte.Edit;

        TabPedIteIDProm.AsInteger      := retProdBusca.IDProm;
        TabPedIteIDDesc.AsInteger      := retProdBusca.IDDesc;
        TabPedIteFormFpgCod.AsString   := retProdBusca.FormFpgCod;
        TabPedIteCalcPromDesc.AsInteger:= 1; // Ativa, entra no cálculo de promoção/desconto se tiver
      
        TabPedItePrecoVen.AsCurrency   := retProdBusca.PrecoVen;
        TabPedItePrecoUni.AsCurrency   := retProdBusca.PrecoUni;
        TabPedIteVlrDesc.AsCurrency    := retProdBusca.VlrDesc;
        TabPedIteVlrVenda.AsCurrency   := retProdBusca.VlrVenda;
        TabPedItePerDesc.AsCurrency    := retProdBusca.PerDesc;

        TabPedIte.Post;
        //
        //TabPedido Totais
        TabPedidoTotDesc.AsFloat   := TabPedidoTotDesc.AsFloat   + (TabPedIteQtdped.AsInteger   * TabPedIteVlrDesc.AsCurrency);
        TabPedidoTotPedido.AsFloat := TabPedidoTotPedido.AsFloat + (TabPedIteQtdped.AsCurrency  * TabPedIteVlrVenda.AsCurrency);
        //
        TabPedIte.Next;
      end;
      TabPedIte.EnableControls;  
    end;
  end;
end;

end.
