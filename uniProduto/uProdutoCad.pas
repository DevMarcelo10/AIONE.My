unit uProdutoCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDDBEdit, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit, Vcl.ExtCtrls,
  LMDCustomMaskEdit, LMDLabel, RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseLabel,
  LMDBaseGraphicControl, LMDCustomLabel, LMDCustomBevelPanel, Data.DB, AdvEdit,
  AdvGlowButton, MarcLib, LMDCustomExtCombo, LMDCustomListComboBox, Vcl.DBCtrls,
  LMDListComboBox, Vcl.Grids, Vcl.DBGrids, LMDDBListComboBox, Vcl.StdCtrls,
  LMDButtonControl, LMDCustomCheckBox, LMDDBCheckBox, System.StrUtils, System.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, LMDEdit, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
  uRESTDWBasicDB, AdvSmoothPanel, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TFrmProdCad = class(TForm)
    timAlpha: TTimer;
    SouProd: TDataSource;
    TabLotes: TRESTDWClientSQL;
    TabLotesIDProd: TIntegerField;
    TabLotesNrolot: TWideStringField;
    TabLotesDatfab: TDateField;
    TabLotesDatven: TDateField;
    TabLotesQtdest: TFloatField;
    SouLotes: TDataSource;
    TabReceitas: TRESTDWClientSQL;
    TabReceitasIDRece: TSmallintField;
    TabReceitasDesRece: TWideStringField;
    TabReceitasCorRece: TWideStringField;
    TabReceitasDetRece: TWideStringField;
    TabReceitasUsoRece: TWideStringField;
    TabProd: TRESTDWClientSQL;
    TabProdIDProd: TFDAutoIncField;
    TabProdDespro: TWideStringField;
    TabProdIDFabr: TIntegerField;
    TabProdIDGrupo: TIntegerField;
    TabProdIDGruSub: TIntegerField;
    TabProdCodNCM: TWideStringField;
    TabProdCodCEST: TWideStringField;
    TabProdCodBenFis: TWideStringField;
    TabProdRegistoMS: TWideStringField;
    TabProdPrecoVen: TFloatField;
    TabProdPrecoPMC: TFloatField;
    TabProdPrecoFP: TFloatField;
    TabProdPrecoBF: TFloatField;
    TabProdPrecoFab: TFloatField;
    TabProdCustoMed: TFloatField;
    TabProdMarkup: TFloatField;
    TabProdEstmin: TFloatField;
    TabProdEstmax: TFloatField;
    TabProdUniEmb: TWideStringField;
    TabProdUniVen: TWideStringField;
    TabProdUniCom: TWideStringField;
    TabProdQtdEmb: TFloatField;
    TabProdQtdFrac: TFloatField;
    TabProdDatcad: TDateField;
    TabProdClasTera: TWideStringField;
    TabProdTipoPro: TWideStringField;
    TabProdTipoPre: TWideStringField;
    TabProdIDPBM: TSmallintField;
    TabProdIDGruPre: TSmallintField;
    TabProdIDUniEmb: TIntegerField;
    TabProdIDUniVen: TIntegerField;
    TabProdIDUniCom: TIntegerField;
    TabProdIndPedCom: TWideStringField;
    TabProdIndGerCom: TWideStringField;
    TabProdIndCobOfe: TWideStringField;
    TabProdIndUsoCon: TWideStringField;
    TabProdIndAtuExt: TWideStringField;
    TabProdIndBloDes: TWideStringField;
    TabProdMsgVenda: TWideStringField;
    TabProdAliqICMS: TFloatField;
    TabProdAliPisCof: TFloatField;
    TabProdAliqIPI: TFloatField;
    TabProdAliqFCP: TFloatField;
    TabProdAliqIMP: TFloatField;
    TabProdAliqIcmDif: TFloatField;
    TabProdAliqRedICM: TFloatField;
    TabProdAliqRedIPI: TFloatField;
    TabProdValorST: TFloatField;
    TabProdMarkupCim: TFloatField;
    TabProdCodOrig: TSmallintField;
    TabProdCodnatEnt: TSmallintField;
    TabProdCodnatSai: TSmallintField;
    TabProdCSTPisCofEnt: TSmallintField;
    TabProdCSTPisCofSai: TSmallintField;
    TabProdCSTICMS: TWideStringField;
    TabProdCSTIPI: TWideStringField;
    TabProdCSOSN: TWideStringField;
    TabProdTipLista: TWideStringField;
    TabProdTipoTriICMS: TWideStringField;
    TabProdCodEANpri: TWideStringField;
    TabProdIDRece: TIntegerField;
    TabProdUsoRece: TWideStringField;
    TabProdIndControle: TWideStringField;
    TabProdIndUsoCont: TWideStringField;
    TabProdAtivo: TWideStringField;
    TabProdQtdest: TFloatField;
    TabProdNompes: TWideStringField;
    TabProdDesgru: TWideStringField;
    TabProdDesgruSub: TWideStringField;
    TabProdNomPBM: TWideStringField;
    TabProdDesRece: TWideStringField;
    TabProdDesOrig: TWideStringField;
    TabProdDesPisCofE: TWideStringField;
    TabProdDesPisCofS: TWideStringField;
    TabProdDesGruPre: TWideStringField;
    TabProdDesEmb: TWideStringField;
    TabProdDesVen: TWideStringField;
    TabProdDesCom: TWideStringField;
    TabProdDesNatProE: TWideStringField;
    TabProdDesNatProS: TWideStringField;
    TabProdIndUsoInt: TWideStringField;
    TabLotescAgreg: TWideStringField;
    TabProdCustoMedCalc: TFloatField;
    TabProdPrecoFabCalc: TFloatField;
    TabProdPrecoVenCalc: TFloatField;
    TabProdPrecoPMCCalc: TFloatField;
    TabProdIDLoc: TIntegerField;
    TabProdDesloc: TWideStringField;
    TabProdCustoReal: TFloatField;
    TabProdUltPreComCalc: TFloatField;
    TabLotesSNG: TRESTDWClientSQL;
    IntegerField1: TIntegerField;
    StringField1: TWideStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    FloatField1: TFloatField;
    SouLotesSNG: TDataSource;
    TabProdCodClasIte: TWideStringField;
    TabProdPerRedCBS: TFloatField;
    TabProdPerRedIBS: TFloatField;
    TabProdAliqIS: TFloatField;
    TabProdDesClaIte: TWideStringField;
    TabProdCodClas: TWideStringField;
    TabProdDesClas: TWideStringField;
    TabProdAliqMVA: TFloatField;
    PanelCadastro: TAdvSmoothPanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btVoltar: TAdvGlowButton;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    btAtuCMED: TAdvGlowButton;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    edGrupo: TLMDDBLabeledEdit;
    edSubGru: TLMDDBLabeledEdit;
    edPMB: TLMDDBLabeledEdit;
    edGruPreco: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    edFabrica: TLMDDBLabeledEdit;
    edMolecula: TLMDLabeledEdit;
    ComboTipoPre: TLMDLabeledListComboBox;
    ComboClasTera: TLMDLabeledListComboBox;
    edNomfor: TLMDLabeledListComboBox;
    LMDSimplePanel6: TLMDSimplePanel;
    btNovo: TAdvGlowButton;
    btClonar: TAdvGlowButton;
    btCancela: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    LMDSimplePanel7: TLMDSimplePanel;
    btValidaFisco: TAdvGlowButton;
    btKitProd: TAdvGlowButton;
    PanelDadCom: TLMDSimplePanel;
    PanelIBSCBS: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    LMDDBLabeledEdit48: TLMDDBLabeledEdit;
    LMDDBLabeledEdit39: TLMDDBLabeledEdit;
    LMDDBLabeledEdit38: TLMDDBLabeledEdit;
    LMDDBLabeledEdit21: TLMDDBLabeledEdit;
    LMDDBLabeledEdit42: TLMDDBLabeledEdit;
    LMDDBLabeledEdit44: TLMDDBLabeledEdit;
    LMDDBLabeledEdit45: TLMDDBLabeledEdit;
    LMDDBLabeledEdit40: TLMDDBLabeledEdit;
    LMDDBLabeledEdit41: TLMDDBLabeledEdit;
    PanelParam: TLMDSimplePanel;
    Shape2: TShape;
    LMDDBCheckBox1: TLMDDBCheckBox;
    LMDDBCheckBox2: TLMDDBCheckBox;
    LMDDBCheckBox3: TLMDDBCheckBox;
    LMDDBCheckBox4: TLMDDBCheckBox;
    LMDDBLabeledEdit43: TLMDDBLabeledEdit;
    LMDDBMargem: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBCheckBox6: TLMDDBCheckBox;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBCheckBox7: TLMDDBCheckBox;
    LMDDBLabeledEdit17: TLMDDBLabeledEdit;
    ComboCorTip: TLMDDBLabeledListComboBox;
    LMDDBCheckBox8: TLMDDBCheckBox;
    LMDDBLabeledEdit36: TLMDDBLabeledEdit;
    LMDDBLabeledEdit13: TLMDDBLabeledEdit;
    LMDDBLabeledEdit37: TLMDDBLabeledEdit;
    PanelEsto: TLMDSimplePanel;
    edUniEmb: TLMDDBLabeledEdit;
    edUniVen: TLMDDBLabeledEdit;
    edUniCom: TLMDDBLabeledEdit;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBLabeledEdit35: TLMDDBLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    DBGrid1: TDBGrid;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit15: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    LMDDBLabeledEdit19: TLMDDBLabeledEdit;
    LMDDBLabeledEdit18: TLMDDBLabeledEdit;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDSimplePanel5: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    DBGrid2: TDBGrid;
    PanelFisco: TLMDSimplePanel;
    Shape1: TShape;
    LMDLabel3: TLMDLabel;
    edCSTPisSai: TLMDDBLabeledEdit;
    edDesNatEnt: TLMDDBLabeledEdit;
    edCSTPisEnt: TLMDDBLabeledEdit;
    edDesNatSai: TLMDDBLabeledEdit;
    LMDDBLabeledEdit24: TLMDDBLabeledEdit;
    LMDDBLabeledEdit25: TLMDDBLabeledEdit;
    LMDDBLabeledEdit26: TLMDDBLabeledEdit;
    LMDDBLabeledEdit27: TLMDDBLabeledEdit;
    LMDDBLabeledEdit28: TLMDDBLabeledEdit;
    LMDDBLabeledEdit29: TLMDDBLabeledEdit;
    LMDDBLabeledEdit30: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    LMDDBLabeledEdit12: TLMDDBLabeledEdit;
    LMDDBLabeledEdit14: TLMDDBLabeledEdit;
    LMDDBLabeledEdit16: TLMDDBLabeledEdit;
    LMDDBLabeledEdit22: TLMDDBLabeledEdit;
    LMDDBLabeledEdit23: TLMDDBLabeledEdit;
    LMDDBLabeledEdit31: TLMDDBLabeledEdit;
    LMDDBLabeledEdit32: TLMDDBLabeledEdit;
    LMDDBLabeledEdit33: TLMDDBLabeledEdit;
    LMDDBLabeledEdit34: TLMDDBLabeledEdit;
    edOriProd: TLMDLabeledEdit;
    ComboTipoTri: TLMDLabeledListComboBox;
    ComboTipoLis: TLMDLabeledListComboBox;
    LMDDBLabeledEdit46: TLMDDBLabeledEdit;
    PnaelBasMenus: TLMDSimplePanel;
    btFiscal: TAdvGlowButton;
    btIBSCBS: TAdvGlowButton;
    btEstoq: TAdvGlowButton;
    btParam: TAdvGlowButton;
    procedure MudaAba(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btVoltarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edMoleculaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edGrupoCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edSubGruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSubGruCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edPMBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPMBCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edGruPrecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edGruPrecoCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edUniEmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edUniEmbCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edUniVenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edUniVenCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edUniComKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edUniComCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edGrupoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edSubGruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edTipproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edGruPrecoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edUniEmbCustomButtons0Click(Sender: TObject; index: Integer);
    procedure TabProdAfterInsert(DataSet: TDataSet);
    procedure edCSTPisEntKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCSTPisEntCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edCSTPisSaiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCSTPisSaiCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesNatEntKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesNatEntCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesNatSaiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesNatSaiCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btCancelaClick(Sender: TObject);
    procedure btClonarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure LMDDBLabeledEdit2Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit0Exit(Sender: TObject);
    procedure LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edFabricaCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edFabricaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit11Exit(Sender: TObject);
    procedure LMDDBLabeledEdit14Exit(Sender: TObject);
    procedure LMDDBLabeledEdit12Exit(Sender: TObject);
    procedure LMDDBLabeledEdit16Exit(Sender: TObject);
    procedure LMDDBLabeledEdit17Exit(Sender: TObject);
    procedure LMDDBLabeledEdit1Exit(Sender: TObject);
    procedure LMDDBLabeledEdit7Exit(Sender: TObject);
    procedure LMDDBLabeledListComboBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledListComboBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btValidaFiscoClick(Sender: TObject);
    procedure LMDDBLabeledEdit32Exit(Sender: TObject);
    procedure LMDDBLabeledEdit34Exit(Sender: TObject);
    procedure TabProdCalcFields(DataSet: TDataSet);
    procedure ComboCorTipEnter(Sender: TObject);
    procedure LMDDBLabeledEdit17KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit17CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit1Enter(Sender: TObject);
    procedure ComboTipoPreEnter(Sender: TObject);
    procedure ComboTipoPreChange(Sender: TObject);
    procedure LMDDBMargemExit(Sender: TObject);
    procedure LMDDBMargemEnter(Sender: TObject);
    procedure LMDDBLabeledEdit18KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit18CustomButtons1Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit18CustomButtons0Click(Sender: TObject; index: Integer);
    procedure btAtuCMEDClick(Sender: TObject);
    procedure edFabricaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btKitProdClick(Sender: TObject);
    procedure edCSTPisEntExit(Sender: TObject);
    procedure LMDDBLabeledEdit12Enter(Sender: TObject);
    procedure edDesNatEntEnter(Sender: TObject);
    procedure edCSTPisSaiExit(Sender: TObject);
    procedure LMDDBLabeledEdit16Enter(Sender: TObject);
    procedure edDesNatSaiEnter(Sender: TObject);
    procedure LMDDBLabeledEdit38Exit(Sender: TObject);
    procedure LMDDBLabeledEdit39KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit39CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit40Exit(Sender: TObject);
    procedure LMDDBLabeledEdit41KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit41CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit38Enter(Sender: TObject);
    procedure ComboClasTeraChange(Sender: TObject);
    procedure ComboTipoTriChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    FNextControl: TWinControl;
    antMarkup,auxUltPreCom:Double;
    strRetorno,oldCodEanpri:String;
    saiViaDel,newCMED,priEAN,vaiFechar,newProd:Boolean;
    procedure ShowSubstancias;
    procedure ShowDesOrigem;
    function  Salvar:Boolean;
    function  Deletar:Boolean;
    function  AbreTabProd: Boolean;
    function  BuscaCod(recTabela,recCampo,recRetorno,recCodigo:String):String;
    function  ExisteEANCad(recCodEAN:String):Boolean;
    function  RemoveZerosDireita(const Value: String): String;
    function  AtuCMED(recIndAtu:Boolean):Boolean;
  public
    { Public declarations }
    recIDProd:Integer;
    FPainelOrigem: TAdvSmoothPanel;
    recCampo,recValor,recCodEAN,recOrigem,recDespro:String;
    procedure AtuCombosFiscal;
  end;
var
  FrmProdCad: TFrmProdCad;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uProdEAN,  uProSubs,  uGrupos, uGruposSub,
     uKitProd, uTipoProSer, uGrupoPre, uUnidades, uPessoasCad, uValidaFis, uLocEsto;

procedure TFrmProdCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmProdCad.FormShow(Sender:TObject);
var
   auxDesSubs:String;
begin
   newCMED := False;
   priEAN  := False;
   saiViaDel := False;
   vaiFechar := False;
   antMarkup := 0.00;
   Screen.Cursor := crHourGlass;
   try
      SouProd.DataSet := nil;
      if AbreTabProd then
      begin
         if recIDProd <= 0 then
         begin
            newProd := True;
            TabProd.Append;
            TabProdDespro.Value := recDespro;
            if IsValidEANCode(recValor) then
            begin
               priEAN := True;
               TabProdCodEANPri.Value := recValor;
            end
            else newProd := False;
            recIDProd := MyApplayUpdates(TabProd, 'IDProd', 'IDProd = IDProd', TabProd.State);
            if recIDProd <= 0 then
            begin
               MostraMsg('Erro','Não foi possível abrir Produtos!',mtWarning, [mbOK]);
               PostMessage(Self.Handle, WM_CLOSE, 0, 0);
               Exit;
            end
            else AbreTabProd;
         end else
         begin
            ShowDesOrigem;
            ShowSubstancias;
         end; //if
         TabLotes.Open;
         TabReceitas.Open;
         SouProd.DataSet := TabProd;
         if not (TabProd.State in dsEditModes) then TabProd.Edit;
      end else
      begin
         PostMessage(Self.Handle, WM_CLOSE, 0, 0);
         Exit;
      end;
   finally
      Screen.Cursor := crDefault;
   end;

   PanelFisco.BringToFront;
   ComboTipoLis.ItemIndex := -1;
   if TabProdTipLista.Value = 'P' then ComboTipoLis.ItemIndex := 0 else
   if TabProdTipLista.Value = 'N' then ComboTipoLis.ItemIndex := 1 else
   if TabProdTipLista.Value = 'E' then ComboTipoLis.ItemIndex := 2 else
   ComboClasTera.ItemIndex := TabProdClasTera.AsInteger;
   ComboTipoPre.ItemIndex  := TabProdTipoPre.AsInteger;
   ComboTipoTri.ItemIndex  := TabProdTipoTriICMS.AsInteger;
   ComboTipoPre.ReadOnly   := TabProdTipoPre.AsString = '1';
   LMDDBMargem.ReadOnly    := TabProdTipoPre.AsString = '1';
   LMDDBLabeledEdit2.SetFocus;
end;

function TFrmProdCad.AbreTabProd:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProd.Active then TabProd.Close;
   TabProd.SQL.Text :=
   'SELECT PRO.*,COALESCE(SUM(LOT.Qtdest),0) AS Qtdest,FAB.Nompes,GRU.Desgru,SUB.DesgruSub,PBM.NomPBM,REC.DesRece,'+
   'ORI.DesOrig,CSE.DesPisCof AS DesPisCofE,CSS.DesPisCof AS DesPisCofS,GRP.DesGruPre,UNE.DesUN AS DesEmb,LOC.Desloc, '+
   'UNV.DesUN AS DesVen,UNC.DesUN AS DesCom,NAE.DesNatPro AS DesNatProE,NAS.DesNatPro AS DesNatProS, '+
   'CLA.DesClas, IVA.DesClaIte, IVA.PerRedCBS, IVA.PerRedIBS FROM arqproduto PRO '+
   'LEFT JOIN arqprodutolot LOT ON PRO.IDProd = LOT.IDProd '+
   'LEFT JOIN arqpbm PBM ON PRO.IDPBM = PBM.IDPBM '+
   'LEFT JOIN arqoriprod ORI ON PRO.CodOrig = ORI.CodOrig '+
   'LEFT JOIN arqunidades UNE ON PRO.IDUniEmb = UNE.IDUni '+
   'LEFT JOIN arqunidades UNV ON PRO.IDUniVen = UNV.IDUni '+
   'LEFT JOIN arqunidades UNC ON PRO.IDUniCom = UNC.IDUni '+
   'LEFT JOIN arqprodutogpr GRP ON PRO.IDGruPre = GRP.IDGruPre '+
   'LEFT JOIN arqgrupo GRU ON PRO.IDGrupo = GRU.IDGrupo '+
   'LEFT JOIN arqgruposub SUB ON PRO.IDGruSub = SUB.IDGruSub '+
   'LEFT JOIN tabnatpiscof NAE ON PRO.CodnatEnt = NAE.Codnat '+
   'LEFT JOIN tabnatpiscof NAS ON PRO.CodnatSai = NAS.Codnat '+
   'LEFT JOIN arqtabpiscof CSE ON PRO.CSTPisCofEnt = CSE.CSTPisCof '+
   'LEFT JOIN arqtabpiscof CSS ON PRO.CSTPisCofSai = CSS.CSTPisCof '+
   'LEFT JOIN arqreceitas REC ON PRO.IDRece = REC.IDRece '+
   'LEFT JOIN arqlocesto LOC ON PRO.IDLoc = LOC.IDLoc '+
   'LEFT JOIN arqpessoa FAB ON PRO.IDFabr = FAB.IDPess AND (FAB.IDEsppes = 2 OR FAB.IDEsppes = 3) '+
   'LEFT JOIN arqclatrib CLA ON PRO.CodClas = CLA.CodClas '+
   'LEFT JOIN arqclatribite IVA ON PRO.CodClasIte = IVA.CodClasIte '+
   'WHERE PRO.IDProd = '+iif(recIDProd > 0,recIDProd.ToString,'-1')+' ';
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         auxUltPreCom := 0.00;
         TabProd.Open;
         edNomfor.Items.Clear;
         if recIDProd > 0 then
         begin
            QueAuxi.SQL.Text := 'SELECT PES.Nompes FROM arqcomprarec REC LEFT JOIN arqpessoa PES ON REC.IDPess = PES.IDPess '+
            'LEFT JOIN arqcomprarecite ITE ON REC.IDRec = ITE.IDRec WHERE ITE.IDProd = '+recIDProd.ToString+' '+
            'GROUP BY PES.IDPess ORDER BY REC.DatRece DESC';
            QueAuxi.Open;
            while not QueAuxi.Eof do
            begin
               edNomfor.Items.Add(QueAuxi.FieldByName('Nompes').AsString);
               QueAuxi.Next;
            end;
            if QueAuxi.RecordCount > 0 then edNomfor.ItemIndex := 0;
         end; //if
         // ------ Busca o Último Preço de Compra ------ //
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT ITE.VlrPreComp FROM arqcomprarecite ITE LEFT JOIN arqcomprarec '+
         'REC ON ITE.IDRec = REC.IDRec WHERE ITE.IDProd = '+recIDProd.ToString+' AND REC.TipEnt = 0 '+
         'ORDER BY REC.DatRece DESC LIMIT 1';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then auxUltPreCom := QueAuxi.FieldByName('VlrPreComp').AsFloat;
         Result := True;
      except
         on E:Exception do
         begin
            MostraMsg('Erro','Não foi possível abrir tabela de produtos.'+#10+E.Message, mtError, [mbOK]);
            Result := False;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;
procedure TFrmProdCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   i,prevIndex:Integer;
begin
   if (Key = VK_TAB) and (ssShift in Shift) then
   begin
      prevIndex := -1;
      for i := 0 to Self.ControlCount - 1 do
      begin
         if Self.Controls[i] = ActiveControl then
         begin
            if prevIndex >= 0 then
            begin
               TWinControl(Self.Controls[prevIndex]).SetFocus;
               Break;
            end;
         end
         else if TWinControl(Self.Controls[i]).CanFocus then prevIndex := i;
      end; //for
      Key := 0;
   end; //if
end;

procedure TFrmProdCad.LMDDBLabeledEdit0Exit(Sender: TObject);
begin
   if (TabProdCodEANPri.AsString.Trim <> '') and (not IsValidEANCode(TabProdCodEANPri.AsString.Trim)) then
   begin
      MostraMsg('Erro','Verifique o Código de Barras.',mtWarning, [mbOK]);
      LMDDBLabeledEdit1.SetFocus;
      Exit;
   end;
end;
procedure TFrmProdCad.LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   Application.CreateForm(TFrmProdEAN, FrmProdEAN);
   try
      lPoint := LMDDBLabeledEdit1.ClientToScreen(Point(0,0));
      FrmProdEAN.Left := lPoint.X;
      FrmProdEAN.Top  := lPoint.Y;
      FrmProdEAN.recIDProd := TabProdIDProd.AsInteger;
      FrmProdEAN.ShowModal;
   finally
      FrmProdEAN := nil;
   end;
end;
procedure TFrmProdCad.LMDDBLabeledEdit1Enter(Sender: TObject);
begin
   oldCodEanpri := Trim(LMDDBLabeledEdit1.Text);
end;
procedure TFrmProdCad.LMDDBLabeledEdit1Exit(Sender: TObject);
const
   ANTI = 'G04A9,J1A,J1B,J1C1,J1C2,J1D1,J1D2,J1E,J1F,J1G1,J1G2,J1H1,J3A,J4A1,J4A5,J8B,P1A,S1A';
   PSIC = 'A14A1,D10B,G3B,H4C,H4X,M1A3,N1B2,N1A2,N1A2,N2A,N3A,N4A,N5A1,N5A9,N5B1,N5C,N6A1,N6A3,N6A4,N6A5,N6A9,N6B,N6C,N7B,N7D1,N7D9,N7E';
var
   I,acReg,retID:Integer;
   LisSubs:TStringDynArray;
   auxPrecoPMC,auxPrecoPF:Double;
   QueCMED,QueAuxi,QueIncl,QueICMS,QueFabr:TRESTDWClientSQL;
   auxCodEAN,strPerICM,strPerALC,strPerGEN,auxClasTera,basClasTera:String;
begin
   if vaiFechar or NewCMED then Exit;
   auxCodEAN := OnlyNumbers(LMDDBLabeledEdit1.Text);
   if (TabProd.State in dsEditModes) then
   begin
      retID := MyApplayUpdates(TabProd, 'IDProd', 'IDProd = '+recIDProd.ToString, TabProd.State);
      if retID < 0 then
      begin
         MostraMsg('Erro','Não foi possível continuar.',mtError, [mbOK]);
         LMDDBLabeledEdit1.SetFocus;
         Exit;
      end; //if
   end; //if
   TabProd.Edit;
   TabProdCodEANpri.Value := auxCodEAN;
   if TabProdCodEANpri.AsString.Trim <> '' then
   begin
      if not IsValidEANCode(TabProdCodEANpri.Value) then
      begin
         MostraMsg('Erro','Verifique o Código de Barras.',mtError, [mbOK]);
         LMDDBLabeledEdit1.Clear;
         LMDDBLabeledEdit1.SetFocus;
         Exit;
      end; //if
      // ....... Se não Existir, Busca na Tabela CMED ....... //
      if TabProdCodEanpri.AsString.Trim <> oldCodEanpri then PriEAN := True;
      if not ExisteEANCad(TabProdCodEANpri.AsString.Trim) and priEAN then AtuCMED(False);
   end; //if
end;

// ------------ Atualiza Dados do Produto Via CMED ------------ //
function TFrmProdCad.AtuCMED(recIndAtu:Boolean):Boolean;
const
   ANTI = 'G04A9,J1A,J1B,J1C1,J1C2,J1D1,J1D2,J1E,J1F,J1G1,J1G2,J1H1,J3A,J4A1,J4A5,J8B,P1A,S1A';
   PSIC = 'A14A1,D10B,G3B,H4C,H4X,M1A3,N1B2,N1A2,N1A2,N2A,N3A,N4A,N5A1,N5A9,N5B1,N5C,N6A1,N6A3,N6A4,N6A5,N6A9,N6B,N6C,N7B,N7D1,N7D9,N7E';
var
   I,acReg,retID:Integer;
   LisSubs:TStringDynArray;
   auxPrecoPMC,auxPrecoPF:Double;
   QueCMED,QueAuxi,QueIncl,QueICMS,QueFabr:TRESTDWClientSQL;
   auxCodEAN,strPerICM,strPerALC,strPerGEN,auxClasTera,basClasTera:String;
begin
   Result  := True;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueICMS := TRESTDWClientSQL.Create(nil);
   QueCMED := TRESTDWClientSQL.Create(nil);
   QueFabr := TRESTDWClientSQL.Create(nil);
   try
      try
         QueAuxi.DataBase := DM.DWDataBase;
         QueIncl.DataBase := DM.DWDataBase;
         QueICMS.DataBase := DM.DWDataBase;
         QueFabr.DataBase := DM.DWDataBase;
         QueCMED.DataBase := DM.DWDataBase;
         QueCMED.SQL.Text := 'SELECT * FROM arqcmed WHERE CodEAN = '+Aspas(TabProdCodEANpri.AsString)+' OR '+
         'CodEAN2 = '+Aspas(TabProdCodEANpri.AsString)+' OR CodEAN3 = '+Aspas(TabProdCodEANpri.AsString)+' LIMIT 1';
         QueCMED.Open;
         if not QueCMED.IsEmpty then
         begin
            if not recIndAtu then
            begin
               if MostraMsg('Confirmação','Novo produto disponível na CMED, deseja incluir?', mtConfirmation, [mbYes,mbNo]) = mrNo then
               begin
                  NewCMED := False;
                  Exit;
               end;
            end; //if
            //--> MsgWait('Atualizando via CMED, por favor aguarde...',FrmPrincipal);
            try
               //..... Associa Produto à Substância (arqprodutoean) .....//
               acReg := 0;
               LisSubs := SplitString(QueCMED.FieldByName('DesSubs').AsString.Trim,';');
               QueAuxi.SQL.Text := 'SELECT IDSubs,TipReceita FROM arqsubstancia WHERE DesSubs IN (';
               if Length(LisSubs) > 0 then
               begin
                  for I := 0 to Length(LisSubs)-1 do
                  begin
                     QueAuxi.SQL.Add(Aspas(LisSubs[I]));
                     if I < Length(LisSubs)-1 then QueAuxi.SQL.Add(', ');
                  end; //for
                  QueAuxi.SQL.Add(')');
                  QueAuxi.Open;
               end; //if
               if not QueAuxi.IsEmpty then
               begin
                  TabReceitas.First;
                  while (not TabReceitas.Eof ) and (TabProdIDRece.Value <= 0) do
                  begin
                     if AnsiPos(QueAuxi.FieldByName('TipReceita').AsString,TabReceitasUsoRece.AsString) > 0 then
                     begin
                        TabProdIDRece.Value  := TabReceitasIDRece.Value;
                        TabProdDesRece.Value := TabReceitasDesrece.Value;
                        TabProdUsoRece.Value := QueAuxi.FieldByName('TipReceita').AsString;
                        Break;
                     end;
                     TabReceitas.Next;
                  end; //while
                  QueIncl.SQL.Text := 'INSERT INTO arqprodutosub (IDProd,IDSubs) VALUES ';
                  while not QueAuxi.Eof do
                  begin
                     QueIncl.SQL.Add('('+TabProdIDProd.AsString+','+QueAuxi.FieldByName('IDSubs').AsString+'), ');
                     QueAuxi.Next;
                     Inc(acReg);
                  end; //while
                  if acReg > 0 then
                  begin
                     QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1);
                     QueIncl.SQL.Add(' ON DUPLICATE KEY UPDATE IDSubs = VALUES(IDSubs);');
                     QueIncl.ExecSQL;
                  end; //if
               end; //if
               //..... Cria Registros no arqprodutoean Associados ao arqproduto .....//
               QueIncl.SQL.Clear;
               if QueCMED.FieldByName('CodEAN').AsString.Trim = '' then
               begin
                  TabProdCodEANPri.AsString := QueCMED.FieldByName('CodEAN2').AsString;
                  if QueCMED.FieldByName('CodEAN3').AsString.Trim <> '' then
                     QueIncl.SQL.Add('INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ('+TabProdIDProd.AsString+','+Aspas(QueCMED.FieldByName('CodEAN3').AsString)+');');
               end else
               begin
                  TabProdCodEANPri.AsString := QueCMED.FieldByName('CodEAN').AsString;
                  if QueCMED.FieldByName('CodEAN2').AsString.Trim <> '' then
                     QueIncl.SQL.Add('INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ('+TabProdIDProd.AsString+','+Aspas(QueCMED.FieldByName('CodEAN2').AsString)+');');
                  if QueCMED.FieldByName('CodEAN3').AsString.Trim <> '' then
                     QueIncl.SQL.Add('INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ('+TabProdIDProd.AsString+','+Aspas(QueCMED.FieldByName('CodEAN3').AsString)+');');
               end; //if
               if QueIncl.SQL.Text <> '' then QueIncl.ExecSQL;

               // ------ Pega o Estado (UF) e Verifica Cidade é Área de Livre Comércio ALC ------ //
               strPerICM := '';
               strPerALC := '';
               strPerGEN := '';
               QueICMS.SQL.Text := 'SELECT ICM.*,MUN.IndALC FROM arqparametros PAR LEFT JOIN '+
               'arqmuni MUN ON PAR.Codmun = MUN.Codmun LEFT JOIN arqicmsuf ICM ON MUN.Estmun = ICM.UFICMS';
               QueICMS.Open;
               while not QueICMS.Eof do
               begin
                  if QueICMS.FieldByName('IndGEN').AsString = '1' then
                     strPerGEN := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)))
                  else
                  if QueICMS.FieldByName('IndALC').AsBoolean then
                       strPerALC := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)))
                  else strPerICM := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)));
                  QueICMS.Next;
               end; //while

               // ..... Coleta Preços de Acordo com o ICMS da Farmácia ..... //
               if not QueCMED.FieldByName('IndICMS0').AsBoolean then
               begin
                  if QueCMED.FieldByName('TipoPro').AsString = 'G' then
                  begin
                     auxPrecoPMC := QueCMED.FieldByName('PrePMC'+strPerGEN).AsFloat;
                     auxPrecoPF  := QueCMED.FieldByName('PreFab'+strPerGEN).AsFloat;
                  end else
                  begin
                     auxPrecoPMC := QueCMED.FieldByName('PrePMC'+strPerICM).AsFloat;
                     auxPrecoPF  := QueCMED.FieldByName('PreFab'+strPerICM).AsFloat;
                  end;
               end else
               begin
                  auxPrecoPMC := QueCMED.FieldByName('PrePMC00').AsFloat;
                  auxPrecoPF  := QueCMED.FieldByName('PreFab00').AsFloat;
               end; //if

               // ..... Inclui / Veririfca se Existe Fabricante ..... //
               QueFabr.Close;
               QueFabr.SQL.Text := 'SELECT IDPess,Nompes FROM arqpessoa WHERE CpfCnpjPes = '+Aspas(QueCMED.FieldByName('CNPJlab').AsString);
               QueFabr.Open;
               if QueFabr.IsEmpty then
               begin
                  QueFabr.Close;
                  QueFabr.SQL.Text := 'INSERT INTO arqpessoa (CpfCnpjPes,Nompes,IDEsppes,TipoPes) VALUES ('+
                  Aspas(QueCMED.FieldByName('CNPJlab').AsString)+','+Aspas(Copy(QueCMED.FieldByName('NomLab').AsString,1,80))+
                  ',3,'+Aspas('CONSUMIDOR')+')';
                  QueFabr.ExecSQL;
                  QueFabr.Close;
                  QueFabr.SQL.Text := 'SELECT IDPess,Nompes FROM arqpessoa WHERE CpfCnpjPes = '+Aspas(QueCMED.FieldByName('CNPJlab').AsString);
                  QueFabr.Open;
               end; //if
               auxClasTera := '0';
               basClasTera := Trim(Copy(QueCMED.FieldByName('ClasTerap').AsString,1,AnsiPos('-',QueCMED.FieldByName('ClasTerap').AsString)-1));
               if AnsiPos(basClasTera, ANTI) > 0 then auxClasTera := '1' else
               if AnsiPos(basClasTera, PSIC) > 0 then auxClasTera := '2';
               TabProdIDFabr.AsInteger   := QueFabr.FieldByName('IDPess').AsInteger;
               TabProdNompes.AsString    := QueFabr.FieldByName('Nompes').AsString;
               TabProdTipLista.AsString  := QueCMED.FieldByName('TipoLista').AsString;
               TabProdDespro.AsString    := QueCMED.FieldByName('Despro').AsString+' '+QueCMED.FieldByName('Aprpro').AsString;
               TabProdTipoPro.AsString   := QueCMED.FieldByName('TipoPro').AsString;
               TabProdRegistoMS.AsString := QueCMED.FieldByName('RegistoMS').AsString;
               TabProdClasTera.AsString  := auxClasTera;
               TabProdTipoPre.AsString   := '1';
               TabProdPrecoFab.AsFloat   := auxPrecoPF;
               TabProdPrecoPMC.AsFloat   := auxPrecoPMC;
               TabProdPrecoVen.AsFloat   := auxPrecoPMC;
               if TabProdPrecoFab.AsFloat > 0.00 then
               begin
                  TabProdMarkupCim.AsFloat := RoundX(((TabProdPrecoPMC.AsFloat - TabProdPrecoFab.AsFloat) / TabProdPrecoFab.AsFloat) * 100,2);
                  TabProdMarkup.AsFloat    := TabProdMarkupCim.AsFloat;
               end;
               ComboTipoLis.ItemIndex := -1;
               if TabProdTipLista.Value = 'P' then ComboTipoLis.ItemIndex := 0 else
               if TabProdTipLista.Value = 'N' then ComboTipoLis.ItemIndex := 1 else
               if TabProdTipLista.Value = 'E' then ComboTipoLis.ItemIndex := 2;
               ComboTipoPre.ItemIndex := 1;
               ComboTipoPre.ReadOnly  := True;
               LMDDBMargem.ReadOnly   := True;
               if not recIndAtu then
                    newCMED := True
               else newCMED := False;
            finally
               //
            end;
            btValidaFisco.Click;
         end
         else Result := False;
         ShowSubstancias;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO,PastaLog,'ERRO ao tentar atualizar CMED en uProdutoCad -> '+E.Message);
            MostraMsg('Erro','Não foi possível atualizar com CMED', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueCMED.Close;   FreeAndNil(QueCMED);
      QueIncl.Close;   FreeAndNil(QueIncl);
      QueAuxi.Close;   FreeAndNil(QueAuxi);
      QueICMS.Close;   FreeAndNil(QueICMS);
      QueFabr.Close;   FreeAndNil(QueFabr);
   end; //try
end;

function TFrmProdCad.RemoveZerosDireita(const Value:String):String;
var
   I:Integer;
begin
   I := Length(Value);
   while (I > 0) and (Value[I] = '0') do Dec(I);
   Result := Copy(Value, 1, I);
end;

procedure TFrmProdCad.LMDDBLabeledEdit2Change(Sender: TObject);
begin
   if LMDDBLabeledEdit2.Field <> nil then
   begin
      if LMDDBLabeledEdit2.Field.FieldName = 'IDProd' then
      begin
         if TabProdIDProd.AsInteger > 0 then
              LMDDBLabeledEdit2.DataField := 'IDProd'
         else LMDDBLabeledEdit2.DataField := '';
      end;
   end; //if
end;

procedure TFrmProdCad.LMDDBLabeledEdit32Exit(Sender: TObject);
begin
   if TabProd.State in dsEditModes then
   begin
      if TabProdCSTICMS.AsString.Trim <> '' then
      begin
         TabProdCSTICMS.Value := StrZero(TabProdCSTICMS.Value,3);
         TabProdCodOrig.Value := StrToInt(Copy(TabProdCSTICMS.AsString,1,1));
      end
      else TabProdCodOrig.Value := 0;
      ShowDesOrigem;
   end;
end;

procedure TFrmProdCad.LMDDBLabeledEdit34Exit(Sender: TObject);
begin
   if (TabProd.State in dsEditModes) and (TabProdCSTIPI.AsString.Trim <> '') then
      TabProdCSTIPI.Value := StrZero(TabProdCSTIPI.Value,2);
end;

procedure TFrmProdCad.LMDDBLabeledEdit40Exit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProdCodClas.Value <> '' then
   begin
      TabProdCodClas.Value := StrZero(TabProdCodClas.Value,3);
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT DesClas FROM arqclatrib WHERE CodClas = '+TabProdCodClas.AsString+' LIMIT 1';
            Open;
            if IsEmpty then
            begin
               MostraMsg('Aviso','Codigo não encontrado!', mtWarning, [mbOk]);
               TabProdDesClas.AsString := '';
               LMDDBLabeledEdit40.SetFocus;
            end
            else TabProdDesClas.AsString := FieldByName('DesClas').AsString;
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;
end;

procedure TFrmProdCad.LMDDBLabeledEdit41CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqclatrib',TDBEdit(LMDDBLabeledEdit41),'CodClas','CodClas','DesClas','DesClas','', 0);
end;

procedure TFrmProdCad.LMDDBLabeledEdit41KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqclatrib',TDBEdit(LMDDBLabeledEdit41),'CodClas','CodClas','DesClas','DesClas','', Key);
end;

procedure TFrmProdCad.LMDDBLabeledEdit38Enter(Sender: TObject);
begin
   if TabProdCodClas.AsString.Trim = '' then
   begin
      MostraMsg('Aviso','É necessário escolhe a classificação principal primeiro!', mtWarning, [mbOk]);
      LMDDBLabeledEdit40.SetFocus;
      Exit;
   end;
end;

procedure TFrmProdCad.LMDDBLabeledEdit38Exit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProdCodClasIte.Value <> '' then
   begin
      TabProdCodClasIte.Value := StrZero(TabProdCodClasIte.Value,6);
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT DesClaIte,PerRedIBS,PerRedCBS FROM arqclatribite WHERE CodClas = '+Aspas(Copy(TabProdCodClasIte.AsString,1,3))+
            ' AND CodClasIte = '+Aspas(TabProdCodClasIte.AsString)+' LIMIT 1';
            Open;
            if not IsEmpty then
            begin
               TabProdDesClaIte.AsString := FieldByName('DesClaIte').AsString;
               TabProdPerRedIBS.AsFloat  := FieldByName('PerRedIBS').AsFloat;
               TabProdPerRedCBS.AsFloat  := FieldByName('PerRedCBS').AsFloat;
            end else
            begin
               MostraMsg('Aviso','Codigo não encontrado!', mtWarning, [mbOk]);
               TabProdDesClaIte.AsString := '';
               TabProdPerRedIBS.AsFloat  := 0.00;
               TabProdPerRedCBS.AsFloat  := 0.00;
               LMDDBLabeledEdit38.SetFocus;
            end;
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;
end;

procedure TFrmProdCad.LMDDBLabeledEdit39CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if TabProdCodClas.AsString.Trim = '' then
   begin
      MostraMsg('Aviso','É necessário escolhe a classificação principal primeiro!', mtWarning, [mbOk]);
      LMDDBLabeledEdit40.SetFocus;
      Exit;
   end;
   _PerRedIBS := 0.00;
   _PerRedCBS := 0.00;
   btBuscasDB(TabProd,'arqclatribite',TDBEdit(LMDDBLabeledEdit39),'CodClasIte','CodClasIte','DesClaIte','DesClaIte','CodClas = '+Aspas(TabProdCodClas.AsString), 0);
   TabProdPerRedIBS.Value := _PerRedIBS;
   TabProdPerRedCBS.Value := _PerRedCBS;
end;

procedure TFrmProdCad.LMDDBLabeledEdit39KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      _PerRedIBS := 0.00;
      _PerRedCBS := 0.00;
      btBuscasDB(TabProd,'arqclatribite',TDBEdit(LMDDBLabeledEdit39),'CodClasIte','CodClasIte','DesClaIte','DesClaIte','CodClas = '+Aspas(TabProdCodClas.AsString), Key);
      TabProdPerRedIBS.Value := _PerRedIBS;
      TabProdPerRedCBS.Value := _PerRedCBS;
   end;
end;

procedure TFrmProdCad.LMDDBLabeledEdit7Exit(Sender: TObject);
begin
   {if TabProdQtdFrac.AsInteger > 1 then
   begin
      if not (TabProd.State in dsEditModes) then TabProd.Edit;
      TabProdPrecoFab.AsFloat := TabProdPrecoFabBas.AsFloat / TabProdQtdFrac.AsInteger;
      TabProdPrecoPMC.AsFloat := TabProdPrecoPMCBas.AsFloat / TabProdQtdFrac.AsInteger;
   end;}
end;

procedure TFrmProdCad.LMDDBLabeledListComboBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
      Key := 0 ;
      ComboTipoPre.SetFocus;
   end;
end;

procedure TFrmProdCad.LMDDBMargemEnter(Sender: TObject);
begin
   antMarkup := TabProdMarkup.AsFloat;
end;

procedure TFrmProdCad.LMDDBMargemExit(Sender: TObject);
begin
   if (TabProdMarkup.Value <> antMarkup) or (TabProd.State = dsInsert) then
   begin
      if TabProdMarkup.Value < 0.00 then
      begin
         MostraMsg('Erro','Margem não pode ser negativa.',mtError, [mbOK]);
         LMDDBMargem.SetFocus;
         Exit;
      end;
      if not (TabProd.State in dsEditModes) then TabProd.Edit;
      if TabProdMarkup.Value > 0.00 then
           TabProdPrecoVen.Value := TabProdPrecoFab.AsFloat + RoundX(TabProdPrecoFab.AsFloat * (TabProdMarkup.AsFloat/100),2)
      else TabProdPrecoVen.Value := TabProdPrecoFab.AsFloat;
   end; //if
end;

procedure TFrmProdCad.LMDDBLabeledListComboBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
      Key := 0;
      PanelParam.BringToFront;
      LMDDBCheckBox6.SetFocus;
   end;
end;

procedure TFrmProdCad.timAlphaTimer(Sender: TObject);
begin
   CentralizarControl(PanelCadastro, Self);
   timAlpha.Enabled := False;
   FadeInOut(Self,'In',8);
end;

procedure TFrmProdCad.edGrupoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmGrupos, TFrmGrupos, PanelCadastro);
end;

procedure TFrmProdCad.edSubGruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmGruposSub, TFrmGruposSub, PanelCadastro);
end;

procedure TFrmProdCad.edFabricaCustomButtons0Click(Sender: TObject; index: Integer);
begin
   FrmPesCad := TFrmPesCad.Create(Application);
   FrmPesCad.Parent := Self;
   CentralizarControl(FrmPesCad, Self);
   FrmPesCad.recCampo  := '';
   FrmPesCad.recIDPess := -1;
   FrmPesCad.recValor  := '';
   FrmPesCad.recOrigem := 'PROD';
   FrmPesCad.Show;
end;

procedure TFrmProdCad.edFabricaCustomButtons1Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqpessoa',TDBEdit(edFabrica),'IDFabr','IDPess','Nompes','Nompes','(IDEsppes = 2 OR IDEsppes = 3)', 0);
end;

procedure TFrmProdCad.edFabricaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqpessoa',TDBEdit(edFabrica),'IDFabr','IDPess','Nompes','Nompes','(IDEsppes = 2 OR IDEsppes = 3)', Key);
end;

procedure TFrmProdCad.edGruPrecoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmGrupoPre, TFrmGrupoPre, PanelCadastro);
end;

procedure TFrmProdCad.edGruPrecoCustomButtons1Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqprodutogpr',TDBEdit(edGruPreco),'IDGruPre','IDGruPre','DesGruPre','DesGruPre','',0);
end;

procedure TFrmProdCad.edGruPrecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqprodutogpr',TDBEdit(edGruPreco),'IDGruPre','IDGruPre','DesGruPre','DesGruPre','',Key);
end;

procedure TFrmProdCad.edPMBCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqpbm',TDBEdit(edPMB), 'IDPBM','IDPBM','NomPBM','NomPBM','',0);
end;

procedure TFrmProdCad.edPMBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqpbm',TDBEdit(edPMB), 'IDPBM','IDPBM','NomPBM','NomPBM','',Key);
end;

procedure TFrmProdCad.edGrupoCustomButtons1Click(Sender: TObject; index: Integer);
begin
   _MarkupGru := 0.00;
   btBuscasDB(TabProd,'arqgrupo',TDBEdit(edGrupo),'IDGrupo','IDGrupo','Desgru','Desgru','', 0);
   if TabProdIDGrupo.Value <> TabProdIDGrupo.oldValue then
   begin
      TabProdIDGruSub.Clear;
      TabProdDesgruSub.Value := '';
   end;
   if TabProdMarkup.AsFloat <= 0.00 then
   begin
      if TabProd.State <> dsEdit then TabProd.Edit;
      TabProdMarkup.AsFloat := _MarkupGru;
   end;
end;

procedure TFrmProdCad.edGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      _MarkupGru := 0.00;
      btBuscasDB(TabProd,'arqgrupo',TDBEdit(edGrupo),'IDGrupo','IDGrupo','Desgru','Desgru','', Key);
      if TabProdIDGrupo.Value <> TabProdIDGrupo.oldValue then
      begin
         TabProdIDGruSub.Clear;
         TabProdDesgruSub.Value := '';
      end;
      if TabProdMarkup.AsFloat <= 0.00 then
      begin
         if TabProd.State <> dsEdit then TabProd.Edit;
         TabProdMarkup.AsFloat := _MarkupGru;
      end;
   end; //if
end;

procedure TFrmProdCad.edSubGruCustomButtons1Click(Sender: TObject; index: Integer);
begin
   if TabProdIDGrupo.Value = 0 then
   begin
      MostraMsg('Aviso','Favor escolher um GRUPO antes', mtWarning, [mbOk]);
      Exit;
   end;
   _MarkupSub := 0.00;
   btBuscasDB(TabProd,'arqgruposub',TDBEdit(edSubGru), 'IDGruSub','IDGruSub','DesgruSub','DesgruSub','IDGrupo = '+TabProdIDGrupo.AsString, 0);
   if (_MarkupGru > 0.00) or (_MarkupSub > 0.00) then
   begin
      if TabProd.State <> dsEdit then TabProd.Edit;
      TabProdMarkup.AsFloat := _MarkupSub;
   end; //if
end;

procedure TFrmProdCad.edSubGruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      if TabProdIDGrupo.Value = 0 then
      begin
         MostraMsg('Aviso','Favor escolher um GRUPO antes', mtWarning, [mbOk]);
         Exit;
      end;
      _MarkupSub := 0.00;
      btBuscasDB(TabProd,'arqgruposub',TDBEdit(edSubGru),'IDGruSub','IDGruSub','DesgruSub','DesgruSub','IDGrupo = '+TabProdIDGrupo.AsString,Key);
      if (_MarkupGru > 0.00) or (_MarkupSub > 0.00) then
      begin
         if TabProd.State <> dsEdit then TabProd.Edit;
         TabProdMarkup.AsFloat := _MarkupSub;
      end; //if
   end; //if
end;

procedure TFrmProdCad.LMDDBLabeledEdit11Exit(Sender: TObject);
begin
   if TabProdCSTPisCofEnt.Value > 0 then
   begin
      strRetorno := BuscaCod('arqtabpiscof','CSTPisCof','DesPisCof',TabProdCSTPisCofEnt.AsString);
      if strRetorno = '-1' then
      begin
         LMDDBLabeledEdit11.SetFocus;
         Exit;
      end
      else TabProdDesPisCofE.AsString := strRetorno;
      if TabProdCSTPisCofEnt.Value = 50 then
      begin
         if not (TabProd.State in dsEditModes) then TabProd.Edit;
         TabProdCodnatEnt.Value  := 0;
         TabProdDesNatProE.Value := '';
      end;
   end; //if
end;

procedure TFrmProdCad.LMDDBLabeledEdit12Enter(Sender: TObject);
begin
   if TabProdCSTPisCofEnt.Value = 50 then LMDDBLabeledEdit31.SetFocus;
end;

procedure TFrmProdCad.LMDDBLabeledEdit12Exit(Sender: TObject);
begin
   if TabProdCodnatEnt.Value > 0 then
   begin
      strRetorno := BuscaCod('tabnatpiscof','Codnat','DesNatPro',TabProdCodnatEnt.AsString);
      if strRetorno = '-1' then
      begin
         LMDDBLabeledEdit12.SetFocus;
         Exit;
      end
      else TabProdDesNatProE.AsString := strRetorno;
   end; //if
end;

procedure TFrmProdCad.LMDDBLabeledEdit14Exit(Sender: TObject);
begin
   if TabProdCSTPisCofSai.Value > 0 then
   begin
      strRetorno := BuscaCod('arqtabpiscof','CSTPisCof','DesPisCof',TabProdCSTPisCofSai.AsString);
      if strRetorno = '-1' then
      begin
         LMDDBLabeledEdit14.SetFocus;
         Exit;
      end
      else TabProdDesPisCofS.AsString := strRetorno;
      if TabProdCSTPisCofSai.Value = 1 then
      begin
         if not (TabProd.State in dsEditModes) then TabProd.Edit;
         TabProdCodnatSai.Value  := 0;
         TabProdDesNatProS.Value := '';
      end;
   end; //if
end;
procedure TFrmProdCad.LMDDBLabeledEdit16Enter(Sender: TObject);
begin
   if TabProdCSTPisCofSai.Value = 1 then LMDDBLabeledEdit31.SetFocus;
end;

procedure TFrmProdCad.LMDDBLabeledEdit16Exit(Sender: TObject);
begin
   if TabProdCodnatSai.Value > 0 then
   begin
      strRetorno := BuscaCod('tabnatpiscof','Codnat','DesNatPro',TabProdCodnatSai.AsString);
      if strRetorno = '-1' then
      begin
         LMDDBLabeledEdit16.SetFocus;
         Exit;
      end
      else TabProdDesNatProS.AsString := strRetorno;
   end; //if
end;

procedure TFrmProdCad.LMDDBLabeledEdit17Exit(Sender: TObject);
begin
   {  VOLTAR  if TabProdCodOrig.Value >= 0 then
   begin
      strRetorno := BuscaCod('arqoriprod','CodOrig','DesOrig',TabProdCodOrig.AsString);
      if strRetorno = '-1' then
      begin
         LMDDBLabeledEdit17.SetFocus;
         Exit;
      end
      else TabProdDesOrig.AsString := strRetorno;
   end; //if }
end;

procedure TFrmProdCad.LMDDBLabeledEdit17KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqreceitas',TDBEdit(LMDDBLabeledEdit17), 'IDRece','IDRece','DesRece','DesRece','',Key);
end;

procedure TFrmProdCad.LMDDBLabeledEdit18CustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmLocEsto, TFrmLocEsto, PanelCadastro);
end;

procedure TFrmProdCad.LMDDBLabeledEdit18CustomButtons1Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqlocEsto',TDBEdit(LMDDBLabeledEdit18),'IDLoc','IDLoc','Desloc','Desloc','',0);
end;

procedure TFrmProdCad.LMDDBLabeledEdit18KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqlocEsto',TDBEdit(LMDDBLabeledEdit18),'IDLoc','IDLoc','Desloc','Desloc','',Key);
end;

procedure TFrmProdCad.LMDDBLabeledEdit17CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqreceitas',TDBEdit(LMDDBLabeledEdit17), 'IDRece','IDRece','DesRece','DesRece','',0);
end;

procedure TFrmProdCad.edTipproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmTipProSer, TFrmTipProSer, PanelCadastro);
end;

procedure TFrmProdCad.edUniEmbCustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmUnidades, TFrmUnidades, PanelCadastro);
end;

procedure TFrmProdCad.edUniEmbCustomButtons1Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqunidades',TDBEdit(edUniEmb),'IDUniEmb','IDUni','DesUN','DesEmb','',0);
end;

procedure TFrmProdCad.edUniEmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqunidades',TDBEdit(edUniEmb),'IDUniEmb','IDUni','DesUN','DesEmb','',Key);
end;

procedure TFrmProdCad.edUniVenCustomButtons1Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqunidades',TDBEdit(edUniVen),'IDUniVen','IDUni','DesUN','DesVen','',0);
end;

procedure TFrmProdCad.edUniVenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqunidades',TDBEdit(edUniVen),'IDUniVen','IDUni','DesUN','DesVen','',Key);
end;

procedure TFrmProdCad.edUniComCustomButtons1Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqunidades',TDBEdit(edUniCom),'IDUniCom','IDUni','DesUN','DesCom','',0);
end;

procedure TFrmProdCad.edUniComKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqunidades',TDBEdit(edUniCom),'IDUniCom','IDUni','DesUN','DesCom','',Key);
end;

procedure TFrmProdCad.edCSTPisEntCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqtabpiscof',TDBEdit(edCSTPisEnt),'CSTPisCofEnt','CSTPisCof','DesPisCof','DesPisCofE','', 0, 641);
end;

procedure TFrmProdCad.edCSTPisEntExit(Sender: TObject);
begin
   if TabProdCSTPisCofEnt.Value = 50 then
   begin
      if not (TabProd.State in dsEditModes) then TabProd.Edit;
      TabProdCodnatEnt.Value  := 0;
      TabProdDesNatProE.Value := '';
   end;
end;

procedure TFrmProdCad.edCSTPisEntKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqtabpiscof',TDBEdit(edCSTPisEnt),'CSTPisCofEnt','CSTPisCof','DesPisCof','DesPisCofE','', Key, 641);
end;

procedure TFrmProdCad.edCSTPisSaiCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'arqtabpiscof',TDBEdit(edCSTPisSai),'CSTPisCofSai','CSTPisCof','DesPisCof','DesPisCofS','', 0, 641);
end;
procedure TFrmProdCad.edCSTPisSaiExit(Sender: TObject);
begin
   if TabProdCSTPisCofSai.Value = 1 then
   begin
      if not (TabProd.State in dsEditModes) then TabProd.Edit;
      TabProdCodnatSai.Value  := 0;
      TabProdDesNatProS.Value := '';
   end;
end;

procedure TFrmProdCad.edCSTPisSaiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'arqtabpiscof',TDBEdit(edCSTPisSai),'CSTPisCofSai','CSTPisCof','DesPisCof','DesPisCofS','', Key, 641);
end;

procedure TFrmProdCad.edDesNatEntCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'tabnatpiscof',TDBEdit(edDesNatEnt),'CodnatEnt','Codnat','DesNatPro','DesNatProE','', 0, 582);
end;

procedure TFrmProdCad.edDesNatEntEnter(Sender: TObject);
begin
   if TabProdCSTPisCofEnt.Value = 50 then LMDDBLabeledEdit31.SetFocus;
end;

procedure TFrmProdCad.edDesNatEntKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'tabnatpiscof',TDBEdit(edDesNatEnt),'CodnatEnt','Codnat','DesNatPro','DesNatProE','', Key, 582);
end;

procedure TFrmProdCad.edDesNatSaiCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabProd,'tabnatpiscof',TDBEdit(edDesNatSai),'CodnatSai','Codnat','DesNatPro','DesNatProS','', 0, 582);
end;

procedure TFrmProdCad.edDesNatSaiEnter(Sender: TObject);
begin
   if TabProdCSTPisCofSai.Value = 1 then LMDDBLabeledEdit31.SetFocus;
end;

procedure TFrmProdCad.edDesNatSaiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabProd,'tabnatpiscof',TDBEdit(edDesNatSai),'CodnatSai','Codnat','DesNatPro','DesNatProS','', Key, 582);
end;

procedure TFrmProdCad.edMoleculaCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
   QueSubs:TRESTDWClientSQL;
begin
   Application.CreateForm(TFrmProSubs, FrmProSubs);
   try
      lPoint := edMolecula.ClientToScreen(Point(0,0));
      FrmProSubs.Left := lPoint.X;
      FrmProSubs.Top  := lPoint.Y;
      FrmProSubs.recIDProd := TabProdIDProd.AsInteger;
      FrmProSubs.ShowModal;
   finally
      if not (TabProd.State in dsEditModes) then TabProd.Append;
      edMolecula.Text := FrmProSubs.retDesSubs;
      FrmProSubs := nil;
      if TabProdIDRece.Value <= 0 then
      begin
         QueSubs := TRESTDWClientSQL.Create(nil);
         try
            QueSubs.DataBase := DM.DWDataBase;
            QueSubs.SQL.Text := 'SELECT SUP.*,SUB.TipReceita FROM arqprodutosub SUP LEFT JOIN '+
            'arqsubstancia SUB ON SUP.IDSubs = SUB.IDSubs WHERE IDProd = '+TabProdIDProd.AsString;
            QueSubs.Open;
            while (not QueSubs.Eof) and (TabProdIDRece.Value <= 0) do
            begin
               TabReceitas.First;
               while (not TabReceitas.Eof ) and (TabProdIDRece.Value <= 0) do
               begin
                  if AnsiPos(QueSubs.FieldByName('TipReceita').AsString,TabReceitasUsoRece.AsString) > 0 then
                  begin
                     TabProdIDRece.Value  := TabReceitasIDRece.Value;
                     TabProdDesRece.Value := TabReceitasDesrece.Value;
                     TabProdUsoRece.Value := QueSubs.FieldByName('TipReceita').AsString;
                     Break;
                  end; //if
                  TabReceitas.Next;
               end; //while
               QueSubs.Next;
            end; //while
         finally
            QueSubs.Close;
            FreeAndNil(QueSubs);
         end;
      end; //if
   end; //try
end;

procedure TFrmProdCad.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ------------------- //
function TFrmProdCad.Salvar:Boolean;
var
   retID:Integer;
   FocusObject:TWinControl;
   temEAN,auxAltGrp:Boolean;
   vErro,auxPrecoVen:String;
   DBEditErro:TLMDDBLabeledEdit;
   QueAuxi,QueIncl:TRESTDWClientSQL;
begin
   if TabProd.State in dsEditModes then
   begin
      Result := False;
      FocusObject := Screen.ActiveControl;
      PanelTop.SetFocus;
      FocusObject.SetFocus;
      DBEditErro := nil;
      if TabProdDespro.AsString.Trim.Length < 3 then DBEditErro := LMDDBLabeledEdit6;
      if TabProdIDGrupo.Value  <= 0 then DBEditErro := edGrupo;
      if TabProdIDGruSub.Value <= 0 then DBEditErro := edSubGru;
      if TabProdIDFabr.Value   <= 0 then DBEditErro := edFabrica;
      if DBEditErro <> nil then
      begin
         MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!', mtWarning, [mbOk]);
         DBEditErro.SetFocus;
         Exit;
      end;
      if TabProdCSTPisCofEnt.Value <= 0 then
      begin
         MostraMsg('Dado não informado','Favor preencher CST PIS/COFINS ENTRADAS, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdCSTPisCofSai.Value <= 0 then
      begin
         MostraMsg('Dado não informado','Favor preencher CST PIS/COFINS SAÍDAS, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if (TabProdCodnatEnt.Value <= 0) and (TabProdCSTPisCofEnt.Value <> 50) then
      begin
         MostraMsg('Dado não informado','Favor preencher NATUREZA PIS/COFINS ENTRADAS, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if (TabProdCodnatSai.Value <= 0) and (TabProdCSTPisCofSai.Value <> 1) then
      begin
         MostraMsg('Dado não informado','Favor preencher NATUREZA PIS/COFINS SAÍDAS, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdCodOrig.Value < 0 then
      begin
         MostraMsg('Dado não informado','Favor preencher ORIGEM DO PRODUTO, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdTipoTriICMS.AsString.Trim = '' then
      begin
         MostraMsg('Dado não informado','Favor preencher Tributação ICMS, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdCodNCM.AsString.Length <> 8 then
      begin
         MostraMsg('Dado não informado','Favor preencher Código NCM corretamente, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdCodOrig.AsString.Trim = '' then
      begin
         MostraMsg('Dado não informado','Favor preencher Origem do Produto, na aba Fiscal!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdIDUniEmb.AsInteger <= 0 then
      begin
         MostraMsg('Dado não informado','Unidade Embalagem, na aba Estoque!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdIDUniVen.AsInteger <= 0 then
      begin
         MostraMsg('Dado não informado','Unidade Vendas, na aba Estoque!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdIDUniCom.AsInteger <= 0 then
      begin
         MostraMsg('Dado não informado','Unidade Compras, na aba Estoque!', mtWarning, [mbOk]);
         Exit;
      end;
      if TabProdQtdFrac.AsInteger <= 0.00 then
      begin
         MostraMsg('Dado não informado','Fração Venda, na aba Estoque, tem que ser no mínimo 1.', mtWarning, [mbOk]);
         Exit;
      end;
      auxAltGrp := False;
      if (antMarkup <> TabProdMarkup.Value) and (TabProdIDGruPre.Value > 0) then
      begin
         if MostraMsg('Confirmação','Produto em Grupo de Preços, com % Margem alterado alterada, todos serão, confirma?', mtConfirmation, [mbYes,mbNo]) = mrYes then
              auxAltGrp := True
         else Exit;
      end; //if
      if ((ComboClasTera.ItemIndex = 1) and (TabProdIDRece.Value <> 1)) or
         ((ComboClasTera.ItemIndex = 2) and (TabProdIDRece.Value  = 1)) then
      begin
         MostraMsg('Erro','Classe terapêutica incompativel com a Receita selecionada.', mtWarning, [mbOk]);
         Exit;
      end;
      if (ComboClasTera.ItemIndex > 0) and (TabProdUsoRece.AsString.Trim = '') then
      begin
         MostraMsg('Erro','É necessário escolher o tipo da receita.', mtWarning, [mbOk]);
         Exit;
      end;
      if ComboClasTera.ItemIndex <= 0 then
      begin
         ComboTipoLis.ItemIndex  := 0;
         TabProdTipLista.Value   := '';
         TabProdUsoRece.AsString := '';
         TabProdIDRece.Value     := 0;
         TabProdIDRece.Value     := 0;
         TabProdDesRece.Value    := '';
      end; //if

      if not (TabProd.State in dsEditModes) then TabProd.Edit;
      if ComboTipoLis.ItemIndex = 0 then TabProdTipLista.Value := 'P' else
      if ComboTipoLis.ItemIndex = 1 then TabProdTipLista.Value := 'N' else
      if ComboTipoLis.ItemIndex = 2 then TabProdTipLista.Value := 'E' else TabProdTipLista.Value := '';
      TabProdTipoPre.AsString     := ComboTipoPre.ItemIndex.ToString;
      TabProdClasTera.AsString    := ComboClasTera.ItemIndex.ToString;
      TabProdTipoTriICMS.AsString := ComboTipoTri.ItemIndex.ToString;
      ComboTipoPre.ReadOnly := TabProdTipoPre.AsString = '1';
      LMDDBMargem.ReadOnly  := TabProdTipoPre.AsString = '1';
      QueIncl := TRESTDWClientSQL.Create(nil);
      QueIncl.DataBase := DM.DWDataBase;
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      Screen.Cursor := crHourGlass;
      try
         // ---------- Consistência do Código de Barras ---------- //
         temEAN  := False;
         if Trim(LMDDBLabeledEdit1.Text) <> '' then
         begin
            if ExisteEANCad(TabProdCodEANpri.AsString.Trim) then Exit;
         end;
         try
            if TabProd.State in dsEditModes then
            begin
               retID := MyApplayUpdates(TabProd, 'IDProd', 'IDProd = '+recIDProd.ToString, TabProd.State);
               if retID < 0 then raise Exception.Create('ERRO MyApplayUpdates');
               if retID > 0 then
                    recIDProd := retID
               else recIDProd := TabProdIDProd.AsInteger;
               AbreTabProd;

               // --------- Atualiza Preço em Promoção no Caso de Alteração do Markup -------- //
               if (antMarkup <> TabProdMarkup.Value) and (TabProd.State <> dsInsert) then
               begin
                  QueIncl.SQL.Clear;
                  QueAuxi.SQL.Text := 'SELECT PRP.IDProm,PRP.IDProd,PRO.PrecoVen FROM arqpromocao PRM LEFT JOIN '+
                  'arqpromopro PRP ON PRM.IDProm = PRP.IDProm LEFT JOIN arqproduto PRO ON PRP.IDProd = PRO.IDProd '+
                  'WHERE Date(NOW()) BETWEEN PRM.DataON AND PRM.DataOFF AND PRM.IndAtivo = "1" AND NOT PRM.ManPre';
                  QueAuxi.Open;
                  while not QueAuxi.Eof do
                  begin
                     auxPrecoVen := FormatDouble(QueAuxi.FieldByName('PrecoVen').AsFloat,9,2);
                     QueIncl.SQL.Add(
                     'UPDATE arqpromopro PRP SET PrePromo = '+auxPrecoVen+' - ('+auxPrecoVen+' * (IF(PerDesIA > 0.00,PerDesIA,PerDesMan) / 100)) '+
                     'WHERE PRP.IDProm = '+QueAuxi.FieldByName('IDProm').AsString+' AND IDProd = '+QueAuxi.FieldByName('IDProd').AsString+';');
                     QueAuxi.Next;
                  end; //while
                  if QueIncl.SQL.Text.Trim <> '' then
                  begin
                     QueIncl.ExecSQL(vErro);
                     if vErro <> '' then raise Exception.Create(vErro);
                  end;
               end; //if
            end;
            ShowSubstancias;
            recIDProd := TabProdIDProd.Value;

            // ----- Caso haja alteração de preços em Produtos em um Gupo de Preços ------- //
            if TabProdIDGruPre.Value > 0 then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'UPDATE arqproduto SET Markup = '+FormatDouble(TabProdMarkup.AsFloat,9,2)+','+
               'PrecoVen = '+FormatDouble(TabProdPrecoVen.AsFloat,11,2)+' WHERE IDGruPre = '+TabProdIDGruPre.AsString;
               QueAuxi.ExecSQL;
            end; //if
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO,PastaLog,'ERRO ao tentar salvar Produto -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
               Exit;
            end;
         end;
      finally
        Screen.Cursor := crDefault;
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
         FreeAndNil(QueIncl);
      end;
   end; //if
   recDespro := '';
   PanelCadastro.Visible := False;
   Sleep(10);
   PanelCadastro.Visible := True;
   Result := True;
end;

// ---------- Consistência do Código de Barras ---------- //
function TFrmProdCad.ExisteEANCad(recCodEAN:String):Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result  := False;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT 1 FROM arqproduto PRO LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd WHERE '+
         '(PRO.CodEANpri = '+Aspas(recCodEAN)+' OR EAN.CodEAN = '+Aspas(recCodEAN)+') AND PRO.IDProd != '+recIDProd.ToString;
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            Result := True;
            MostraMsg('Barras Duplicadas','Já existe produto com esse código de barras.', mtWarning, [mbOk]);
            LMDDBLabeledEdit1.SetFocus;
            Exit;
         end; //if
      except
      end; //try
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmProdCad.btNovoClick(Sender: TObject);
begin
   if not Salvar then Exit;
   TabProd.Append;
   recIDProd := MyApplayUpdates(TabProd, 'IDProd', '', TabProd.State);
   if recIDProd < 0 then
   begin
      MostraMsg('Erro','Não foi possível gerar novo produto.', mtError, [mbOk]);
      Exit;
   end;
   AbreTabProd;
   TabProd.Edit;
   antMarkup := 0.00;
   edMolecula.Text := '';
   edOriProd.Text  := '';
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmProdCad.btAtuCMEDClick(Sender: TObject);
begin
   if TabProdCodEANpri.AsString.Trim <> '' then
   begin
      if not AtuCMED(True) then
         MostraMsg('Aviso','Não encontrado na CMED com esse código de barras!', mtWarning, [mbOk]);
   end;
end;

procedure TFrmProdCad.btCancelaClick(Sender: TObject);
begin
   PanelTop.SetFocus;
   if not TabProd.Modified then Exit;
   if MostraMsg('Confirmação','Deseja realmente cancelar as modificações feitas?', mtConfirmation, [mbYes,mbNo]) = mrYes then
   begin
      if NewProd then
      begin
         TabProd.Delete;
         vaiFechar := True;
         Close;
      end
      else TabProd.Cancel;
      recDespro := '';
   end;  //if
end;

procedure TFrmProdCad.btClonarClick(Sender: TObject);
var
   newIDProd:Integer;
   delCampo:TStringList;
begin
   PanelTop.SetFocus;
   if not Salvar then Exit;
   delCampo := TStringList.Create;
   try
      delCampo.Add('IDProd');
      if MostraMsg('Confirmação','Deseja realmente duplicar esse registro?', mtConfirmation, [mbYes,mbNo]) = mrYes then
      begin
         newIDProd := ClonarRegistro('arqproduto','arqproduto','IDProd', TabProdIDProd.Value,delCampo);
         if newIDProd > 0  then
         begin
            recIDProd := newIDProd;
            FormShow(Self);
         end;
      end; //if
   finally
      delCampo.Free;
   end;
end;

procedure TFrmProdCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProdIDProd.Value > 0 then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT (EXISTS (SELECT 1 FROM arqpedidoite WHERE IDProd = '+TabProdIDProd.AsString+')) AS FoundPVI,'+
            '(EXISTS (SELECT 1 FROM arqcomprarecite WHERE IDProd = '+TabProdIDProd.AsString+')) AS FoundRCI';
            Open;
            if (FieldByName('FoundPVI').AsInteger = 1) or (FieldByName('FoundRCI').AsInteger = 1) then
            begin
               MostraMsg('Não pode ser excluído','Já existem movimentos deste produto!', mtInformation, [mbOk]);
               Exit;
            end;
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
      if MostraMsg('Confirmação','Deseja realmente excluir este produto?', mtConfirmation, [mbYes,mbNo]) = mrYes then
         if Deletar then Self.Close;
      recDespro := '';
   end; //if
end;

// ------------- Deletar (Excluir) Produto ------------ //
function TFrmProdCad.Deletar:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result  := False;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      try
         QueAuxi.DataBase := DM.DWDataBase;
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Add('DELETE FROM arqprodutoean WHERE IDProd = '+TabProdIDProd.AsString+';');
         QueAuxi.SQL.Add('DELETE FROM arqprodutolot WHERE IDProd = '+TabProdIDProd.AsString+';');
         QueAuxi.SQL.Add('DELETE FROM arqprodutosub WHERE IDProd = '+TabProdIDProd.AsString+';');
         QueAuxi.SQL.Add('DELETE FROM arqproduto WHERE IDProd = '+   TabProdIDProd.AsString+';');
         QueAuxi.ExecSQL;
         SalvaLog(USUARIO,PastaLog,'EXCLUSAO ARQPRODUTOS IDProd = '+TabProdIDProd.AsString+' - Produto: '+TabProdDespro.AsString);
         Result := True;
         saiViaDel := True;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO,PastaLog,'ERRO ao tentar excluir registro do aquivo: arqproduto, IDProd = '+TabProdIDProd.AsString+' -> '+E.Message);
            MostraMsg('Erro','Não foi possível efetivar a exclusão!', mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmProdCad.MudaAba(Sender: TObject);
begin
   if TAdvGlowButton(Sender).Tag = 1 then PanelEsto.BringToFront  else
   if TAdvGlowButton(Sender).Tag = 2 then PanelFisco.BringToFront else
   if TAdvGlowButton(Sender).Tag = 3 then PanelParam.BringToFront else
   if TAdvGlowButton(Sender).Tag = 4 then PanelIBSCBS.BringToFront;
end;

procedure TFrmProdCad.TabProdAfterInsert(DataSet: TDataSet);
begin
   edMolecula.Text := '';
   edMolecula.Tag  := 0;
   edNomfor.Items.Clear;
   edNomfor.ItemIndex      := -1;
   ComboClasTera.ItemIndex := 0;
   ComboTipoLis.ItemIndex  := -1;
   ComboTipoPre.ItemIndex  := 0;
   ComboTipoTri.ItemIndex  := 0;
   TabProdQtdFrac.Value   := 1;
   TabProdAtivo.Value     := '1';
   TabProdIndPedCom.Value := '1';
   TabProdIndGerCom.Value := '1';
   TabProdIndCobOfe.Value := '1';
   TabProdIndAtuExt.Value := '1';
   TabProdIndUsoCon.Value := '0';
   TabProdIndBloDes.Value := '0';
   TabProdIndUsoInt.Value := '0';
   TabProdTipoPre.Value   := '1';
   TabProdTipoPre.Value   := '0';
   TabProdClasTera.Value  := '0';
   TabProdTipoTriICMS.Value := '1';
end;

procedure TFrmProdCad.TabProdCalcFields(DataSet: TDataSet);
begin
   if TabProdQtdFrac.AsFloat > 0.00 then
   begin
      TabProdCustoMedCalc.Value := TabProdCustoMed.Value / TabProdQtdFrac.AsFloat;
      TabProdPrecoFabCalc.Value := TabProdPrecoFab.Value / TabProdQtdFrac.AsFloat;
      TabProdPrecoVenCalc.Value := TabProdPrecoVen.Value / TabProdQtdFrac.AsFloat;
      TabProdPrecoPMCCalc.Value := TabProdPrecoPMC.Value / TabProdQtdFrac.AsFloat;
   end else
   begin
      TabProdCustoMedCalc.Value := TabProdCustoMed.Value;
      TabProdPrecoFabCalc.Value := TabProdPrecoFab.Value;
      TabProdPrecoVenCalc.Value := TabProdPrecoVen.Value;
      TabProdPrecoPMCCalc.Value := TabProdPrecoPMC.Value;
   end;
   TabProdUltPreComCalc.Value := auxUltPreCom;
end;

// ----------- Mostra as substâncias em edMolecula ----------- //
procedure TFrmProdCad.ShowSubstancias;
var
   TabSubs:TRESTDWClientSQL;
   auxDesSubs:String;
begin
   if TabProdIDProd.Value > 0 then
   begin
      TabSubs := TRESTDWClientSQL.Create(nil);
      TabSubs.DataBase := DM.DWDataBase;
      try
         TabSubs.SQL.Text := 'SELECT PSUB.*,SUB.DesSubs FROM arqprodutosub PSUB LEFT JOIN arqsubstancia ';
         TabSubs.SQL.Add('SUB ON PSUB.IDSubs = SUB.IDSubs WHERE IDProd = '+TabProdIDProd.AsString);
         TabSubs.Open;
         while not TabSubs.Eof do
         begin
            auxDesSubs := auxDesSubs + TabSubs.FieldByName('DesSubs').AsString+' + ';
            TabSubs.Next;
         end;
         TabSubs.Close;
         if auxDesSubs <> '' then auxDesSubs := Copy(auxDesSubs, 1, Length(auxDesSubs) -3);
         edMolecula.Text := auxDesSubs;
         Application.ProcessMessages;
      finally
         TabSubs.Close;
         FreeAndNil(TabSubs);
      end;
   end; //if
end;

// --------- Mostra a Descrição Origem Fiscal --------- //
procedure TFrmProdCad.ShowDesOrigem;
var
   QueAuxi:TRESTDWClientSQL;
begin
   if not TabProdCodOrig.IsNull then
   begin
      QueAUxi := TRESTDWClientSQL.Create(nil);
      try
         QueAuxi.DataBase := DM.DWDataBase;
         QueAuxi.SQL.Text := 'SELECT DesOrig FROM arqoriprod WHERE CodOrig = '+TabProdCodOrig.AsString+' LIMIT 1';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
              edOriProd.Text := QueAuxi.FieldByName('DesOrig').AsString
         else edOriProd.Text := '';
         Application.ProcessMessages;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end
   else edOriProd.Text := '';
end;

// --------- Mostra a Cor e Tipo da Receita --------- //
procedure TFrmProdCad.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

function TFrmProdCad.BuscaCod(recTabela,recCampo,recRetorno,recCodigo:String):String;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := '-1';
   if recCodigo = '' then Exit;
   try
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT '+recCampo+','+recRetorno+' FROM '+recTabela+' WHERE '+recCampo+' = '+recCodigo+' LIMIT 1';
            Open;
            if not IsEmpty then
                 Result := FieldByName(recRetorno).AsString
            else MostraMsg('Aviso','Codigo não encontrado!', mtWarning, [mbOk]);
         end; //with
         strRetorno := Result;
      except
         on E:Exception do
         begin
            MostraMsg('Erro','Não foi possível efetuar busca.'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmProdCad.ComboClasTeraChange(Sender: TObject);
begin
   if not (TabProd.State in dsEditModes) then TabProd.Edit;
end;

procedure TFrmProdCad.ComboCorTipEnter(Sender: TObject);
var
   I:Integer;
   LisTipos:TStringDynArray;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabProdIDRece.AsInteger < 0 then
   begin
      MostraMsg('Aviso','É necessário escolher a Cor da Receita antes!', mtWarning, [mbOk]);
      LMDDBLabeledEdit17.SetFocus;
      Exit;
   end;
   if TabProdIDRece.AsInteger > 0 then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         ComboCorTip.Items.Clear;
         QueAuxi.DataBase := DM.DWDataBase;
         QueAuxi.SQL.Text := 'SELECT UsoRece FROM arqreceitas WHERE IDRece = '+TabProdIDRece.AsString;
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            LisTipos := SplitString(QueAuxi.FieldByName('UsoRece').AsString,';');
            if Length(LisTipos) > 0 then
            begin
               for I := 0 to Length(LisTipos)-1 do
                  ComboCorTip.Items.Add(Copy(LisTipos[I],1,2));
            end; //if
         end; //if
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
end;

procedure TFrmProdCad.ComboTipoPreChange(Sender: TObject);
begin
   ComboTipoPre.Text := ComboTipoPre.Items[ComboTipoPre.ItemIndex];
   if not (TabProd.State in dsEditModes) then TabProd.Edit;
end;

procedure TFrmProdCad.ComboTipoPreEnter(Sender: TObject);
begin
   if ComboTipoPre.ReadOnly then LMDDBLabeledEdit6.SetFocus;
end;

procedure TFrmProdCad.ComboTipoTriChange(Sender: TObject);
begin
   if not (TabProd.State in dsEditModes) then TabProd.Edit;
end;

// ------------- Validador Fiscal de Tributos ------------- //
procedure TFrmProdCad.btValidaFiscoClick(Sender: TObject);
begin
   if (TabProdCodEANPri.AsString.Trim = '') then
   begin
      MostraMsg('Aviso','Não foi informado código de barras para análise!', mtWarning, [mbOk]);
      Exit;
   end;
   MudaAba(btFiscal);
   Application.ProcessMessages;
   FrmValidaFis := TFrmValidaFis.Create(Application);
   FrmValidaFis.recIDProd   := TabProdIDProd.AsInteger;
   FrmValidaFis.recDespro   := iif(TabProdDespro.AsString.Trim <> '',TabProdDespro.AsString,'PRODUTO NOVO');
   FrmValidaFis.recCodEAN   := TabProdCodEANPri.AsString;
   FrmValidaFis.recEdDesori := edOriProd;
   FrmValidaFis.TabProdRec  := TabProd;
   Self.AlphaBlendValue := 185;
   try
      FrmValidaFis.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmValidaFis.Free;
   end;
end;

procedure TFrmProdCad.AtuCombosFiscal;
begin
   ComboTipoTri.ItemIndex := TabProdTipoTriICMS.AsInteger;
end;
procedure TFrmProdCad.btKitProdClick(Sender: TObject);
var
   ParentPos:TPoint;
begin
   Self.AlphaBlendValue := 110;
   FrmKitProduto := TFrmKitProduto.Create(Application);
   try
      ParentPos := Self.ClientToScreen(Point(0, 0));
      FrmKitProduto.Left := ParentPos.X + (Self.Width  - FrmKitProduto.Width) div 2;
      FrmKitProduto.Top  := ParentPos.Y + (Self.Height - FrmKitProduto.Height) div 2;
      FrmKitProduto.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      FrmKitProduto.Free;
   end;
end;

procedure TFrmProdCad.FormPaint(Sender: TObject);
begin
   DrawGradientBackground(Canvas, ClientRect);
end;

procedure TFrmProdCad.btVoltarClick(Sender: TObject);
begin
   vaiFechar := True;
   Close;
end;

procedure TFrmProdCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   vaiFechar := True;
   PanelTop.SetFocus;
   if (TabProd.State in dsEditModes) and TabProd.Modified and (TabProdDespro.AsString.Trim <> '') and (not saiViaDel) then
   begin
      if MostraMsg('Confirmação','Deseja sair sem salvar as modificações?', mtConfirmation, [mbYes,mbNo]) = mrYes then
      begin
         if not newCMED then
            TabProd.Cancel
         else Deletar;
         CanClose  := True;
         vaiFechar := False;
      end
      else CanClose := False;
  end; //if
end;

procedure TFrmProdCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabLotes.Close;
   TabReceitas.Close;
   if (TabProdIDGrupo.AsInteger = 0) and (TabProdIDGruSub.AsInteger = 0) and (TabProdIDFabr.AsInteger = 0) and (TabProdIDProd.Value > 0) then Deletar;
   TabProd.Close;
   FadeInOut(Self,'Out',10);
   if recOrigem = 'PRO' then
   begin
      FPainelOrigem.Visible := True;
      SimularCliqueControlePorNome('FrmProdutos','edbusca');
   end;
   Action := caFree;
end;

end.
