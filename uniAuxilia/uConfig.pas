unit uConfig;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothPanel, Vcl.ExtCtrls, Vcl.Imaging.PNGimage, Vcl.StdCtrls,
   LMDBaseControl, LMDBaseGraphicControl, LMDLabel, LMDBaseLabel, LMDCustomLabel, MarcLib, uRESTDWParams,
   AdvGlowButton, LMDEdit, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit,
   uRESTDWBasicDB,  LMDCustomEdit, Data.DB, LMDListComboBox, Vcl.Grids, Vcl.DBGrids, LMDCustomMaskEdit,
   LMDCustomExtCombo, LMDDBEdit, LMDCustomListComboBox, LMDDBListComboBox, LMDButtonControl, ACBrBase,
   LMDCustomCheckBox, LMDDBCheckBox, LMDSimplePanel, FireDAC.Stan.Intf, FireDAC.Stan.Option, ACBrMail,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   Vcl.DBCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, LMDCustomExtSpinEdit,
   LMDSpinEdit, LMDDBSpinEdit, LMDCustomParentPanel, LMDCustomGroupBox, LMDComboBoxExt, Printers,
   LMDCustomButtonGroup, LMDCustomCheckGroup, LMDCheckGroup, LMDVistaDialogs, LMDDBMaskEdit, ModernDateEdit;

type
   TFrmConfig = class(TForm)
    PanelBas: TAdvSmoothPanel;
    timAlpha: TTimer;
    PanelCenter: TLMDSimplePanel;
    PanelContas: TLMDSimplePanel;
    PanelFarma: TLMDSimplePanel;
    PanelParam: TLMDSimplePanel;
    LMDDBLabeledListComboBox6: TLMDDBLabeledListComboBox;
    PanelBasMenus: TLMDSimplePanel;
    PanelMenu: TLMDSimplePanel;
    btFarma: TAdvGlowButton;
    btContas: TAdvGlowButton;
    btParam: TAdvGlowButton;
    edRazaoSocial: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit14: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    LMDDBLabeledEdit16: TLMDDBLabeledEdit;
    LMDDBLabeledEdit20: TLMDDBLabeledEdit;
    LMDDBLabeledEdit21: TLMDDBLabeledEdit;
    LMDDBLabeledEdit12: TLMDDBLabeledEdit;
    LMDDBLabeledEdit22: TLMDDBLabeledEdit;
    LMDDBLabeledEdit23: TLMDDBLabeledEdit;
    LMDDBLabeledEdit24: TLMDDBLabeledEdit;
    LMDDBLabeledEdit25: TLMDDBLabeledEdit;
    LMDDBLabeledEdit26: TLMDDBLabeledEdit;
    LMDDBLabeledEdit27: TLMDDBLabeledEdit;
    TabParam: TRESTDWClientSQL;
    SouParam: TDataSource;
    LMDDBLabeledEdit28: TLMDDBLabeledEdit;
    btNotFis: TAdvGlowButton;
    PanelNotas: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    LMDLabel6: TLMDLabel;
    LMDLabel7: TLMDLabel;
    LMDLabel10: TLMDLabel;
    LMDLabel8: TLMDLabel;
    LMDLabel9: TLMDLabel;
    LMDLabel11: TLMDLabel;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBEdit2: TLMDDBEdit;
    edSenDigital: TLMDEdit;
    LMDDBLabeledSpinEdit2: TLMDDBLabeledSpinEdit;
    LMDDBEdit1: TLMDDBEdit;
    LMDDBEdit3: TLMDDBEdit;
    edEMail: TLMDDBEdit;
    edMailPorta: TLMDDBEdit;
    edSenMail: TLMDEdit;
    edSMTP: TLMDDBEdit;
    ckAutentica: TLMDDBCheckBox;
    LMDLabel13: TLMDLabel;
    LMDLabel12: TLMDLabel;
    edNatFinVlrDevo: TLMDDBLabeledEdit;
    edCodNatFinVlrDevo: TLMDDBLabeledEdit;
    edNatFinDesAce: TLMDDBLabeledEdit;
    edCodNatFinDesAce: TLMDDBLabeledEdit;
    edNatFinDesAsso: TLMDDBLabeledEdit;
    edCodNatFinDesAsso: TLMDDBLabeledEdit;
    edNatFinVlrJur: TLMDDBLabeledEdit;
    edCodNatFinVlrJur: TLMDDBLabeledEdit;
    edNatFinPerJur: TLMDDBLabeledEdit;
    edCodNatFinPerJur: TLMDDBLabeledEdit;
    edNatFinVlrMul: TLMDDBLabeledEdit;
    edCodNatFinVlrMul: TLMDDBLabeledEdit;
    edNatFinPerMul: TLMDDBLabeledEdit;
    edCodNatFinPerMul: TLMDDBLabeledEdit;
    SouForPagto: TDataSource;
    TabFormasPagtos: TRESTDWClientSQL;
    TabFormasPagtosIDForPag: TIntegerField;
    TabFormasPagtosIndAtivo: TIntegerField;
    btSNGPC: TAdvGlowButton;
    PanelSNGPC: TLMDSimplePanel;
    ckContSNGPC: TLMDDBCheckBox;
    ckCadCompCom: TLMDDBCheckBox;
    ckSNGPCObrCom: TLMDDBCheckBox;
    ckSNGPCObrVen: TLMDDBCheckBox;
    ckQuantPresRec: TLMDDBCheckBox;
    ckConInsMan: TLMDDBCheckBox;
    lbCamGerArq: TLMDLabel;
    lbTipEnv: TLMDLabel;
    ckCadObrVenSNGPC: TLMDDBCheckBox;
    ckSNGPCObrPerProd: TLMDDBCheckBox;
    ckSolConFar: TLMDDBCheckBox;
    ckImpEtiRecSNGPC: TLMDDBCheckBox;
    lbBloVenConVenDia: TLMDLabel;
    edCaminho: TLMDDBLabeledEdit;
    btBuscar: TAdvGlowButton;
    FileOpenDialog1: TFileOpenDialog;
    cbTipoEnvio: TLMDLabeledListComboBox;
    LMDDBMaskEdit1: TLMDDBMaskEdit;
    Shape18: TShape;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    Shape15: TShape;
    cbVenFecha: TLMDLabeledListComboBox;
    cbVenCesta: TLMDLabeledListComboBox;
    cbVenProdExibComEst: TLMDLabeledListComboBox;
    cbVenProdBloqSemEst: TLMDLabeledListComboBox;
    cbVenCustoMed: TLMDLabeledListComboBox;
    Shape19: TShape;
    gpVendaClieObg: TLMDCheckGroup;
    lbTitulo: TLMDLabel;
    ckAltMarProRec: TLMDDBCheckBox;
    ckAltMarProCadProd: TLMDDBCheckBox;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    Shape1: TShape;
    lbDefTipRecLis: TLMDLabel;
    AdvGlowButton1: TAdvGlowButton;
    LMDLabel1: TLMDLabel;
    Shape2: TShape;
    LMDLabel14: TLMDLabel;
    LMDDBMaskEdit2: TLMDDBMaskEdit;
    LMDLabel15: TLMDLabel;
    LMDLabel16: TLMDLabel;
    LMDDBMaskEdit3: TLMDDBMaskEdit;
    LMDLabel17: TLMDLabel;
    LMDDBCheckBox1: TLMDDBCheckBox;
    LMDDBCheckBox2: TLMDDBCheckBox;
    LMDDBCheckBox3: TLMDDBCheckBox;
    LMDDBCheckBox4: TLMDDBCheckBox;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBCheckBox6: TLMDDBCheckBox;
    Shape3: TShape;
    LMDDBCheckBox7: TLMDDBCheckBox;
    LMDLabel18: TLMDLabel;
    LMDDBMaskEdit4: TLMDDBMaskEdit;
    LMDLabel19: TLMDLabel;
    LMDDBCheckBox8: TLMDDBCheckBox;
    LMDDBCheckBox9: TLMDDBCheckBox;
    LMDDBCheckBox10: TLMDDBCheckBox;
    LMDDBCheckBox11: TLMDDBCheckBox;
    LMDLabel20: TLMDLabel;
    LMDDBMaskEdit6: TLMDDBMaskEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    btEntregas: TAdvGlowButton;
    PanelCaixa: TLMDSimplePanel;
    btCaixa: TAdvGlowButton;
    TabForPagto: TRESTDWClientSQL;
    TabForPagtoIDForPag: TSmallintField;
    TabForPagtoDesForPag: TWideStringField;
    TabForPagtoIndAtivo: TBooleanField;
    PanelEntre: TLMDSimplePanel;
    Shape4: TShape;
    PrintDialog1: TPrintDialog;
    LMDDBEdit5: TLMDDBEdit;
    LMDLabel5: TLMDLabel;
    LMDDBEdit4: TLMDDBEdit;
    FileOpenDialog2: TFileOpenDialog;
    ComboRegime: TLMDLabeledListComboBox;
    LMDLabel21: TLMDLabel;
    LMDDBLabeledSpinEdit1: TLMDDBLabeledSpinEdit;
    LMDDBEdit6: TLMDDBEdit;
    LMDLabel22: TLMDLabel;
    LMDDBEdit7: TLMDDBEdit;
    LMDLabel23: TLMDLabel;
    LMDDBEdit8: TLMDDBEdit;
    LMDDBEdit9: TLMDDBEdit;
    LMDLabel24: TLMDLabel;
    LMDDBEdit10: TLMDDBEdit;
    LMDLabel25: TLMDLabel;
    TabICMS: TRESTDWClientSQL;
    SouICMS: TDataSource;
    TabICMSUFICMS: TWideStringField;
    TabICMSIndGEN: TWideStringField;
    TabICMSPerICMS: TFloatField;
    btImposto: TAdvGlowButton;
    PanelImpos: TLMDSimplePanel;
    LMDSimplePanel4: TLMDSimplePanel;
    TabICMSPerFCP: TFloatField;
    TabForPagtoIDForPagNF: TWideStringField;
    TabForPagtoIndPagVis: TWideStringField;
    TabForPagNF: TRESTDWClientSQL;
    TabForPagNFIDForPagNF: TWideStringField;
    TabForPagNFDesForPagNF: TWideStringField;
    TabForPagtoDesForPagNFLook: TWideStringField;
    LMDLabel26: TLMDLabel;
    LMDDBEdit11: TLMDDBEdit;
    LMDLabel27: TLMDLabel;
    LMDDBEdit12: TLMDDBEdit;
    LMDLabel28: TLMDLabel;
    LMDDBEdit16: TLMDDBEdit;
    LMDLabel29: TLMDLabel;
    LMDDBEdit17: TLMDDBEdit;
    LMDLabel30: TLMDLabel;
    LMDDBEdit18: TLMDDBEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDSimplePanel5: TLMDSimplePanel;
    LMDDBLabeledEdit13: TLMDDBLabeledEdit;
    LMDDBLabeledEdit15: TLMDDBLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid2: TDBGrid;
    LMDSimplePanel6: TLMDSimplePanel;
    LMDDBLabeledEdit17: TLMDDBLabeledEdit;
    LMDDBLabeledEdit18: TLMDDBLabeledEdit;
    LMDSimplePanel7: TLMDSimplePanel;
    DBGrid3: TDBGrid;
    TabClaTribIte: TRESTDWClientSQL;
    SouClaTribIte: TDataSource;
    TabClaTribItePerRedCBS: TFloatField;
    TabClaTribItePerRedIBS: TFloatField;
    LMDDBLabeledEdit19: TLMDDBLabeledEdit;
    TabClaTribIteCodClasIte: TWideStringField;
    TabClaTribIteDesClaIte: TWideStringField;
    Shape5: TShape;
    LMDDBEdit19: TLMDDBEdit;
    LMDLabel31: TLMDLabel;
    LMDDBEdit20: TLMDDBEdit;
    LMDLabel32: TLMDLabel;
    FileOpenDialog3: TFileOpenDialog;
    LMDLabel33: TLMDLabel;
    edCertSenPar: TLMDEdit;
    LMDDBLabeledEdit29: TLMDDBLabeledEdit;
    pnFormasPagto: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel34: TLMDLabel;
    LMDLabel35: TLMDLabel;
    LMDLabel39: TLMDLabel;
    Shape6: TShape;
    cbIndCxEfetiva: TLMDLabeledListComboBox;
    LMDDBCheckBox12: TLMDDBCheckBox;
    LMDDBCheckBox13: TLMDDBCheckBox;
    LMDDBCheckBox14: TLMDDBCheckBox;
    LMDDBCheckBox15: TLMDDBCheckBox;
    LMDDBCheckBox16: TLMDDBCheckBox;
    LMDDBCheckBox17: TLMDDBCheckBox;
    LMDDBLabeledEdit30: TLMDDBLabeledEdit;
    LMDDBLabeledEdit31: TLMDDBLabeledEdit;
    btTesteMail: TAdvGlowButton;
    ACBrMail: TACBrMail;
    ckUseTLS: TLMDDBCheckBox;
    LMDDBEdit13: TLMDDBEdit;
    LMDLabel2: TLMDLabel;
    edDBBanco: TLMDDBLabeledEdit;
    btTEF: TAdvGlowButton;
    PanelTEF: TLMDSimplePanel;
    LMDLabel36: TLMDLabel;
    cbCertificado: TLMDLabeledListComboBox;
    LMDLabeledListComboBox1: TLMDLabeledListComboBox;
    TabParamCNPJFar: TWideStringField;
    TabParamIDFilial: TWideStringField;
    TabParamNomefar: TWideStringField;
    TabParamNomefan: TWideStringField;
    TabParamApelidoFar: TWideStringField;
    TabParamEndfar: TWideStringField;
    TabParamNroEnt: TWideStringField;
    TabParamCompEnd: TWideStringField;
    TabParamBaifar: TWideStringField;
    TabParamNommun: TWideStringField;
    TabParamEstmun: TWideStringField;
    TabParamCodmun: TIntegerField;
    TabParamCepfar: TWideStringField;
    TabParamInsEstFar: TWideStringField;
    TabParamFoneFar: TWideStringField;
    TabParamValDigital: TDateField;
    TabParamCelularFar: TWideStringField;
    TabParamEmailFar: TWideStringField;
    TabParamNomger: TWideStringField;
    TabParamFoneger: TWideStringField;
    TabParamMailUsuario: TWideStringField;
    TabParamMailPorta: TWideStringField;
    TabParamMailSenha: TWideStringField;
    TabParamServidorSMTP: TWideStringField;
    TabParamMailAssunto: TWideStringField;
    TabParamMailAutentica: TBooleanField;
    TabParamCerDigital: TWideStringField;
    TabParamSenDigital: TWideStringField;
    TabParamSerDigital: TWideStringField;
    TabParamModDANFE: TWideStringField;
    TabParamCSCNFCe: TWideStringField;
    TabParamTokenNFCe: TWideStringField;
    TabParamHomolNFCe: TBooleanField;
    TabParamPrinterNFC: TWideStringField;
    TabParamNroUltNFC: TIntegerField;
    TabParamIndContNFC: TBooleanField;
    TabParamDatContNFC: TDateTimeField;
    TabParamUltPedCom: TDateTimeField;
    TabParamUsuIntFIscal: TWideStringField;
    TabParamPassIntFiscal: TWideStringField;
    TabParamRTRIBFiscal: TWideStringField;
    TabParamFAT12M: TWideStringField;
    TabParamIDNatFinVlrDevo: TIntegerField;
    TabParamIDNatFinDesAce: TIntegerField;
    TabParamIDNatFinDesAsso: TIntegerField;
    TabParamIDNatFinVlrJur: TIntegerField;
    TabParamIDNatFinPerJur: TIntegerField;
    TabParamIDNatFinVlrMul: TIntegerField;
    TabParamIDNatFinPerMul: TIntegerField;
    TabParamConDebSan: TIntegerField;
    TabParamConCreSan: TIntegerField;
    TabParamConDebSup: TIntegerField;
    TabParamConCreSup: TIntegerField;
    TabParamAlteraMargProdEnt: TBooleanField;
    TabParamAlteraMargProdCad: TBooleanField;
    TabParamTipoCerDig: TWideStringField;
    TabParamNroViasNF: TSmallintField;
    TabParamPinCerDig: TWideStringField;
    TabParamDesnatDEV: TWideStringField;
    TabParamDesnatACE: TWideStringField;
    TabParamDesnatASS: TWideStringField;
    TabParamDesnatVLJ: TWideStringField;
    TabParamDesnatPEJ: TWideStringField;
    TabParamDesnatVLM: TWideStringField;
    TabParamDesnatPEM: TWideStringField;
    TabParamVenFecha: TIntegerField;
    TabParamVenProdExibComEst: TIntegerField;
    TabParamMailUseTLS: TBooleanField;
    TabParamVenCesta: TIntegerField;
    TabParamVenProdBloqSemEst: TIntegerField;
    TabParamVenCustoMed: TIntegerField;
    TabParamVenFormaPagto: TWideStringField;
    TabParamUltNSUNFe: TWideStringField;
    TabParamMaxNSUNFe: TWideStringField;
    TabParamDataHoraUltAcesso: TDateTimeField;
    TabParamIDNatFinEntMerRec: TIntegerField;
    TabParamControleSNGPC: TBooleanField;
    TabParamCadComCom: TBooleanField;
    TabParamInfQuanPreRec: TBooleanField;
    TabParamCamGerArqXML: TWideStringField;
    TabParamTipoEnvio: TWideStringField;
    TabParamConInsMan: TBooleanField;
    TabParamCadObrVenSNGPC: TBooleanField;
    TabParamSNGPCObrPerPro: TBooleanField;
    TabParamSolConFar: TBooleanField;
    TabParamBloVenConVenDia: TIntegerField;
    TabParamDefTipRecLista: TIntegerField;
    TabParamImpEtiRecSNGPC: TBooleanField;
    TabParamSNGPCObrCompra: TBooleanField;
    TabParamSNGPCObrVenda: TBooleanField;
    TabParamReceitaA1: TIntegerField;
    TabParamReceitaA2: TIntegerField;
    TabParamReceitaA3: TIntegerField;
    TabParamReceitaAM: TIntegerField;
    TabParamReceitaB1: TIntegerField;
    TabParamReceitaB2: TIntegerField;
    TabParamReceitaC1: TIntegerField;
    TabParamReceitaC2: TIntegerField;
    TabParamReceitaC3: TIntegerField;
    TabParamReceitaC4: TIntegerField;
    TabParamReceitaC5: TIntegerField;
    TabParamReceitaD1: TIntegerField;
    TabParamValDiaA1: TIntegerField;
    TabParamValDiaA2: TIntegerField;
    TabParamValDiaA3: TIntegerField;
    TabParamValDiaAM: TIntegerField;
    TabParamValDiaB1: TIntegerField;
    TabParamValDiaB2: TIntegerField;
    TabParamValDiaC1: TIntegerField;
    TabParamValDiaC2: TIntegerField;
    TabParamValDiaC3: TIntegerField;
    TabParamValDiaC4: TIntegerField;
    TabParamValDiaC5: TIntegerField;
    TabParamValDiaD1: TIntegerField;
    TabParamArrVenPer: TFloatField;
    TabParamDescAdGru: TFloatField;
    TabParamIDFilialEntr: TIntegerField;
    TabParamQtdViaTel: TSmallintField;
    TabParamPerVenAdd: TBooleanField;
    TabParamPerAddPerf: TBooleanField;
    TabParamPerVisEst: TBooleanField;
    TabParamPerPIXTA: TBooleanField;
    TabParamPerAltProm: TBooleanField;
    TabParamPerAltRegu: TBooleanField;
    TabParamPerEnvFilial: TBooleanField;
    TabParamObrConfRec: TBooleanField;
    TabParamIndPreEntra: TBooleanField;
    TabParamIndDIFAL: TBooleanField;
    TabParamSerNFC: TSmallintField;
    TabParamSerNFe: TSmallintField;
    TabParamPerRecPedVin: TBooleanField;
    TabParamUltNSUMani: TIntegerField;
    TabParamPastaConfNFe: TWideStringField;
    TabParamPastaConfNFCe: TWideStringField;
    TabParamHomolNFe: TBooleanField;
    TabParamIndContNFe: TBooleanField;
    TabParamImagemNF: TWideStringField;
    TabParamRegTributa: TWideStringField;
    TabParamPrinterNFe: TWideStringField;
    TabParamMailContabil: TWideStringField;
    TabParamNroViasNFC: TSmallintField;
    TabParamNroUltNFE: TIntegerField;
    TabParamPercPIS: TFloatField;
    TabParamPerCOFINS: TFloatField;
    TabParamAliqIBSMun: TFloatField;
    TabParamAliqIBSEst: TFloatField;
    TabParamAliqCBS: TFloatField;
    TabParamPerCreICMSSN: TFloatField;
    TabParamMenEnvMailNF: TWideStringField;
    TabParamSiteConsNFC: TWideStringField;
    TabParamSiteConsNFe: TWideStringField;
    TabParamCodban: TIntegerField;
    TabParamPastaBoletos: TWideStringField;
    TabParamPastaManifesto: TWideStringField;
    TabParamPastaCertDigital: TWideStringField;
    TabParamSenhaCertMan: TWideStringField;
    TabParamIndCxEfetiva: TSmallintField;
    TabParamIndCxCega: TBooleanField;
    TabParamIndCxConfereIte: TBooleanField;
    TabParamIndCxDigQtdConfMan: TBooleanField;
    TabParamIndCxBusIteNomeConf: TBooleanField;
    TabParamIndCxBloqSangria: TBooleanField;
    TabParamIndCxImpAudiFecha: TBooleanField;
    TabParamIndCxLimVlrBloqueio: TFloatField;
    TabParamIndCxLimArrenCaixa: TFloatField;
    TabParamNomConCreSup: TWideStringField;
    TabParamNomConDebSup: TWideStringField;
    TabParamNomConCreSan: TWideStringField;
    TabParamNomConDebSan: TWideStringField;
    TabParamNomfil: TWideStringField;
    TabParamNomban: TWideStringField;
    TabFormasPagtosDesForPag: TWideStringField;
    ModernDBDateEdit1: TModernDBDateEdit;
    LMDLabel3: TLMDLabel;
    TabParamDataIniOpe: TDateTimeField;
    procedure FormResize(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MudaAba(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ckAltMarProRecClick(Sender: TObject);
    procedure ckAltMarProCadProdClick(Sender: TObject);
    procedure edNatFinVlrDevoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinDesAceCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinDesAssoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinVlrJurCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinPerJurCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinVlrMulCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinPerMulCustomButtons0Click(Sender: TObject; index: Integer);
    procedure cbVenFechaExit(Sender: TObject);
    procedure cbVenFechaKeyPress(Sender: TObject; var Key: Char);
    procedure cbVenFechaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure gpVendaClieObgChange(Sender: TObject; ButtonIndex: Integer);
    procedure edDesNatEntCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNatFinVlrDevoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinDesAceKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinDesAssoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinVlrJurKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinPerJurKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinVlrMulKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinPerMulKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCodNatFinVlrDevoExit(Sender: TObject);
    procedure edCodNatFinDesAceExit(Sender: TObject);
    procedure edCodNatFinDesAssoExit(Sender: TObject);
    procedure edCodNatFinVlrJurExit(Sender: TObject);
    procedure edCodNatFinPerJurExit(Sender: TObject);
    procedure edCodNatFinVlrMulExit(Sender: TObject);
    procedure edCodNatFinPerMulExit(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure edCaminhoExit(Sender: TObject);
    procedure ckImpEtiRecSNGPCClick(Sender: TObject);
    procedure ckSolConFarClick(Sender: TObject);
    procedure ckSNGPCObrPerProdClick(Sender: TObject);
    procedure ckCadObrVenSNGPCClick(Sender: TObject);
    procedure ckConInsManClick(Sender: TObject);
    procedure ckQuantPresRecClick(Sender: TObject);
    procedure ckSNGPCObrVenClick(Sender: TObject);
    procedure ckSNGPCObrComClick(Sender: TObject);
    procedure ckCadCompComClick(Sender: TObject);
    procedure ckContSNGPCClick(Sender: TObject);
    procedure cbTipoEnvioChange(Sender: TObject);
    procedure LMDDBLabeledEdit8KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit8CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit10KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit10CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit9KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit9CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit7KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit7CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure LMDDBEdit5CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBEdit2CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBEdit4CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBEdit6CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edEMailExit(Sender: TObject);
    procedure LMDDBEdit7Exit(Sender: TObject);
    procedure edSenDigitalExit(Sender: TObject);
    procedure LMDDBEdit19CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBEdit20CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBEdit8CustomButtons0Click(Sender: TObject; index: Integer);
    procedure cbCertificadoChange(Sender: TObject);
    procedure btTesteMailClick(Sender: TObject);
    procedure edDBBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDBBancoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBEdit13CustomButtons0Click(Sender: TObject; index: Integer);
   private
    { Private declarations }
    iteVenc:TStringList;
    iteCert:TStringList;
    iteSeri:TStringList;
    codigoFormasPagtos:Array[0..20] of integer;
    function BuscaCod(recTabela,recCampo,recRetorno,recCodigo:String):String;
   public
      { Public declarations }
   end;
var
   FrmConfig: TFrmConfig;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uTipoReceita, uTaxaEntr;

procedure TFrmConfig.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   PanelFarma.BringToFront;
end;

procedure TFrmConfig.FormDeactivate(Sender: TObject);
begin
  SelectNext(TWinControl(Sender), True, True);
end;

procedure TFrmConfig.FormShow(Sender: TObject);
var
   I:Integer;
   DWParams:TRESTDWParams;
   iteRaza,iteCNPJ:TStringList;
   vErrorMsg,txtRaza,txtCNPJ,txtSeri,txtCert,txtVenc:String;
begin
   TabParam.Open;
   TabICMS.Open;
   TabClaTribIte.Open;
   AjustaDBGrid(DBGrid2);
   cbVenFecha.ItemIndex    := TabParamVenFecha.AsInteger;
   cbVenCesta.ItemIndex    := TabParamVenCesta.AsInteger;
   cbVenCustoMed.ItemIndex := TabParamVenCustoMed.AsInteger;
   ComboRegime.ItemIndex   := TabParamRegTributa.AsInteger -1;

   edSenDigital.Text := TabParamSenDigital.AsString;
   cbVenProdExibComEst.ItemIndex := TabParamVenProdExibComEst.AsInteger;
   cbVenProdBloqSemEst.ItemIndex := TabParamVenProdBloqSemEst.AsInteger;

   edSenMail.Text    := TabParamMailSenha.AsString;
   edCertSenPar.Text := TabParamSenhaCertMan.AsString;

   iteCert  := TStringList.Create;
   iteVenc  := TStringList.Create;
   iteRaza  := TStringList.Create;
   iteCNPJ  := TStringList.Create;
   iteSeri  := TStringList.Create;
   DWParams := TRESTDWParams.Create;
   try
      try
         DM.DWClientEvents.CreateDWParams('GetCertificados', DWParams);
         DM.DWClientEvents.SendEvent('GetCertificados', DWParams, vErrorMsg);
         if vErrorMsg <> '' then raise Exception.Create(vErrorMsg);
         txtRaza := DWParams.ItemsString['Razao'].AsString;
         txtCNPJ := DWParams.ItemsString['CNPJ'].AsString;
         txtSeri := DWParams.ItemsString['Serie'].AsString;
         txtCert := DWParams.ItemsString['Certificados'].AsString;
         txtVenc := DWParams.ItemsString['Vencimentos'].AsString;
         ExtractStrings(['|'], [], PChar(txtRaza), iteRaza);
         ExtractStrings(['|'], [], PChar(txtCNPJ), iteCNPJ);
         ExtractStrings(['|'], [], PChar(txtSeri), iteSeri);
         ExtractStrings(['|'], [], PChar(txtCert), iteCert);
         ExtractStrings(['|'], [], PChar(txtVenc), iteVenc);
         cbCertificado.Items.Clear;
         for var Ii := 0 to iteRaza.Count-1 do
         begin
            cbCertificado.Items.Add(iteRaza[Ii]+' - '+iteCNPJ[Ii]+' - '+iteVenc[Ii]);
            if TabParamSerDigital.AsString = iteSeri[Ii] then
               cbCertificado.ItemIndex := Ii;
         end;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] TNão foi possível localizar os Certificados Digitais (uConfig) -> '+E.Message);
            MostraMsg('Erro','Não foi possível localizar os Certificados Digitais!', mtError, [mbOk]);
         end;
      end;
   finally
      iteRaza.Free;
      iteCNPJ.Free;
      DWParams.Free;
   end;

   // Carrega as Formas de Pagtos
   gpVendaClieObg.OnChange := nil;
   gpVendaClieObg.Items.Clear;
   TabForPagNF.Open;
   TabFormasPagtos.Open;
   while not TabFormasPagtos.Eof do
   begin
      I := gpVendaClieObg.Items.Add(TitleCase(TabFormasPagtosDesForPag.AsString) );
      codigoFormasPagtos[I] := TabFormasPagtosIDForPag.AsInteger;
      TabFormasPagtos.Next;
   end;
   // Check as Formas de Pagtos Marcadas como Obrigatórias
   for I := 0 to gpVendaClieObg.Items.Count-1 do
   begin
      var codStr:= FormatFloat('00', codigoFormasPagtos[I]);
      gpVendaClieObg.Checked[I] := (AnsiPos(codStr, TabParamVenFormaPagto.AsString) > 0);
   end;
   gpVendaClieObg.OnChange:= gpVendaClieObgChange;
   TabFormasPagtos.Close;

   // Aba Caixa
   cbIndCxEfetiva.ItemIndex := TabParam.FieldByName('IndCxEfetiva').AsInteger;

   // Carrega tipo envio SNGPC //
   cbTipoEnvio.ItemIndex := TabParamTipoEnvio.AsInteger;

   MudaAba(btFarma);
   edRazaoSocial.SetFocus;
end;

procedure TFrmConfig.gpVendaClieObgChange(Sender: TObject; ButtonIndex: Integer);
   function PersisteFormasPagto():String;
   begin
      Result := '';
      for var I := 0 to gpVendaClieObg.Items.Count-1 do
         if gpVendaClieObg.Checked[I] then
            if   Result = EmptyStr then Result := FormatFloat('00',codigoFormasPagtos[I])
            else Result := Result + ',' + FormatFloat('00',codigoFormasPagtos[I]);
   end;
begin
  if TabParam.Active then
  begin
    if not (TabParam.State in dsEditModes) then TabParam.Edit;
    TabParamVenFormaPagto.AsString:= PersisteFormasPagto();
  end;
end;

procedure TFrmConfig.AdvGlowButton1Click(Sender: TObject);
begin
   try
      Application.CreateForm(TFrmTipoReceita, FrmTipoReceita);
      FrmTipoReceita.ShowModal;
   finally
      FrmTipoReceita.Free;
   end; //try
end;

procedure TFrmConfig.btBuscarClick(Sender: TObject);
begin
   FileOpenDialog1.Title := 'Selecione uma pasta';
   if FileOpenDialog1.Execute then edCaminho.text := FileOpenDialog1.FileName
end;

function TFrmConfig.BuscaCod(recTabela,recCampo,recRetorno,recCodigo:String):String;
var
   QueAuxi:TRESTDWClientSQL;
begin
   if recCodigo = '' then Exit;
   Result := '-1';
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
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmConfig.edNatFinVlrDevoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinVlrDevo),'IDNatFinVlrDevo','IDNatFin','Desnat','DesnatDEV','',0);
end;

procedure TFrmConfig.edNatFinVlrDevoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinVlrDevo),'IDNatFinVlrDevo','IDNatFin','Desnat','DesnatDEV','',Key);
end;

procedure TFrmConfig.edCodNatFinVlrDevoExit(Sender: TObject);
var
   strRetorno:String;
begin
   if TabParamIDNatFinVlrDevo.Value > 0 then
   begin
      strRetorno := BuscaCod('arqnatfin','IDNatFin','Desnat',TabParamIDNatFinVlrDevo.AsString);
      if strRetorno = '-1' then
      begin
         edCodNatFinVlrDevo.SetFocus;
         Exit;
      end
      else TabParamDesnatDEV.AsString := strRetorno;
   end; //if /
end;

procedure TFrmConfig.edCaminhoExit(Sender: TObject);
begin
   ShowMessage(TabParamCamGerArqXML.AsString);
end;

procedure TFrmConfig.edCodNatFinDesAceExit(Sender: TObject);
var
   strRetorno:String;
begin
   if TabParamIDNatFinDesAce.Value > 0 then
   begin
      strRetorno := BuscaCod('arqnatfin','IDNatFin','Desnat',TabParamIDNatFinDesAce.AsString);
      if strRetorno = '-1' then
      begin
         edCodNatFinDesAce.SetFocus;
         Exit;
      end
      else TabParamDesnatACE.AsString := strRetorno;
   end; //if
end;

procedure TFrmConfig.edCodNatFinDesAssoExit(Sender: TObject);
var
   strRetorno:String;
begin
   if TabParamIDNatFinDesAsso.Value > 0 then
   begin
      strRetorno := BuscaCod('arqnatfin','IDNatFin','Desnat',TabParamIDNatFinDesAsso.AsString);
      if strRetorno = '-1' then
      begin
         edCodNatFinDesAsso.SetFocus;
         Exit;
      end
      else TabParamDesnatASS.AsString := strRetorno;
   end; //if
end;

procedure TFrmConfig.edCodNatFinVlrJurExit(Sender: TObject);
var
   strRetorno:String;
begin
   if TabParamIDNatFinVlrJur.Value > 0 then
   begin
      strRetorno := BuscaCod('arqnatfin','IDNatFin','Desnat',TabParamIDNatFinVlrJur.AsString);
      if strRetorno = '-1' then
      begin
         edCodNatFinVlrJur.SetFocus;
         Exit;
      end
      else TabParamDesnatVLJ.AsString := strRetorno;
   end; //if
end;

procedure TFrmConfig.edCodNatFinPerJurExit(Sender: TObject);
var
   strRetorno:String;
begin
   if TabParamIDNatFinPerJur.Value > 0 then
   begin
      strRetorno := BuscaCod('arqnatfin','IDNatFin','Desnat',TabParamIDNatFinPerJur.AsString);
      if strRetorno = '-1' then
      begin
         edCodNatFinPerJur.SetFocus;
         Exit;
      end
      else TabParamDesnatPEJ.AsString := strRetorno;
   end; //if
end;

procedure TFrmConfig.edCodNatFinVlrMulExit(Sender: TObject);
var
   strRetorno:String;
begin
   if TabParamIDNatFinVlrMul.Value > 0 then
   begin
      strRetorno := BuscaCod('arqnatfin','IDNatFin','Desnat',TabParamIDNatFinVlrMul.AsString);
      if strRetorno = '-1' then
      begin
         edCodNatFinVlrMul.SetFocus;
         Exit;
      end
      else TabParamDesnatVLM.AsString := strRetorno;
   end; //if
end;

procedure TFrmConfig.edCodNatFinPerMulExit(Sender: TObject);
var
   strRetorno:String;
begin
   if TabParamIDNatFinPerMul.Value > 0 then
   begin
      strRetorno := BuscaCod('arqnatfin','IDNatFin','Desnat',TabParamIDNatFinPerMul.AsString);
      if strRetorno = '-1' then
      begin
         edCodNatFinPerMul.SetFocus;
         Exit;
      end
      else TabParamDesnatPEM.AsString := strRetorno;
   end; //if
end;

procedure TFrmConfig.edDBBancoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqbanco',TDBEdit(edDBBanco),'Codban','Codban','Nomban','Nomban','IDFilial = '+FILIAL.ToString,0);
end;

procedure TFrmConfig.edDBBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqbanco',TDBEdit(edDBBanco),'Codban','Codban','Nomban','Nomban','IDFilial = '+FILIAL.ToString,Key);
end;

procedure TFrmConfig.edDesNatEntCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinVlrDevo),'IDNatFinVlrDevo','IDNatFin','Desnat','DesnatDEV','',0);
end;

procedure TFrmConfig.edNatFinDesAceCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinDesAce),'IDNatFinDesAce','IDNatFin','Desnat','DesnatACE','',0);
end;

procedure TFrmConfig.edNatFinDesAceKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinDesAce),'IDNatFinDesAce','IDNatFin','Desnat','DesnatACE','',Key);
end;

procedure TFrmConfig.edNatFinDesAssoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinDesAsso),'IDNatFinDesAsso','IDNatFin','Desnat','DesnatASS','',0);
end;

procedure TFrmConfig.edNatFinDesAssoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinDesAsso),'IDNatFinDesAsso','IDNatFin','Desnat','DesnatASS','',Key);
end;

procedure TFrmConfig.edNatFinVlrJurCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinVlrJur),'IDNatFinVlrJur','IDNatFin','Desnat','DesnatVLJ','',0);
end;

procedure TFrmConfig.edNatFinVlrJurKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinVlrJur),'IDNatFinVlrJur','IDNatFin','Desnat','DesnatVLJ','',Key);
end;

procedure TFrmConfig.edNatFinPerJurCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinPerJur),'IDNatFinPerJur','IDNatFin','Desnat','DesnatPEJ','',0);
end;

procedure TFrmConfig.edNatFinPerJurKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinPerJur),'IDNatFinPerJur','IDNatFin','Desnat','DesnatPEJ','',Key);
end;

procedure TFrmConfig.edNatFinVlrMulCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinVlrMul),'IDNatFinVlrMul','IDNatFin','Desnat','DesnatVLM','',0);
end;

procedure TFrmConfig.edNatFinVlrMulKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinVlrMul),'IDNatFinVlrMul','IDNatFin','Desnat','DesnatVLM','',Key);
end;
procedure TFrmConfig.edSenDigitalExit(Sender: TObject);
begin
   if not (TabParam.State in dsEditModes) then TabParam.Edit;
   TabParamSenDigital.Value   := edSenDigital.Text;
   TabParamMailSenha.AsString := edSenMail.Text;
   TabParam.Post;
end;

procedure TFrmConfig.edNatFinPerMulCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinPerMul),'IDNatFinPerMul','IDNatFin','Desnat','DesnatPEM','',0);
end;

procedure TFrmConfig.edNatFinPerMulKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqnatfin',TDBEdit(edNatFinPerMul),'IDNatFinPerMul','IDNatFin','Desnat','DesnatPEM','',Key);
end;

procedure TFrmConfig.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmConfig.MudaAba(Sender: TObject);
begin
   if TAdvGlowButton(Sender).Tag = 1 then PanelFarma.BringToFront  else // Farmácia
   if TAdvGlowButton(Sender).Tag = 2 then PanelContas.BringToFront else // Contas
   if TAdvGlowButton(Sender).Tag = 3 then PanelNotas.BringToFront  else // Notas
   if TAdvGlowButton(Sender).Tag = 4 then PanelParam.BringToFront  else // Parâmetros
   if TAdvGlowButton(Sender).Tag = 5 then PanelSNGPC.BringToFront  else // SNGPC
   if TAdvGlowButton(Sender).Tag = 6 then // Taxas Entregas
   begin
      PanelEntre.BringToFront;
      if FrmTaxaEntr = nil then
      begin
         FrmTaxaEntr := TFrmTaxaEntr.Create(Application);
         FrmTaxaEntr.Parent := PanelEntre;
         CentralizarControl(FrmTaxaEntr,PanelEntre);
      end;
      FrmTaxaEntr.Show
   end else
   if TAdvGlowButton(Sender).Tag = 7 then // Caixa
   begin
      TabForPagto.Open;
      PanelCaixa.BringToFront;
      AjustaDBGrid(DBGrid1);
      DBGrid1.SetFocus;
   end else
   if TAdvGlowButton(Sender).Tag = 8 then PanelImpos.BringToFront else  // Impostos
   if TAdvGlowButton(Sender).Tag = 9 then PanelTEF.BringToFront;        // TEF
end;

procedure TFrmConfig.FormResize(Sender: TObject);
begin
   PanelCenter.Top  := ((Self.Height - PanelCenter.Height) div 2) - 55;
   PanelCenter.Left := ((Self.Width  - PanelCenter.Width)  div 2);
end;

procedure TFrmConfig.cbCertificadoChange(Sender: TObject);
begin
   if not (TabParam.State in dsEditModes) then TabParam.Edit;
   if cbCertificado.ItemIndex >= 0 then
   begin
      TabParamSerDigital.Value := iteSeri[cbCertificado.ItemIndex];
      TabParamCerDigital.Value := iteCert[cbCertificado.ItemIndex];
      TabParamValDigital.Value := StrToDate(iteVenc[cbCertificado.ItemIndex]);
   end else
   begin
      TabParamSerDigital.Clear;
      TabParamCerDigital.Clear;
      TabParamValDigital.Clear;
   end;
   TabParam.Post;
   TabParam.Edit;
end;

procedure TFrmConfig.cbTipoEnvioChange(Sender: TObject);
begin
   cbVenFechaExit(Sender);
end;

procedure TFrmConfig.cbVenFechaExit(Sender: TObject);
begin
  if TabParam.Active then
  begin
    if TLMDLabeledListComboBox(Sender).ItemIndex = -1 then
    begin
      TLMDLabeledListComboBox(Sender).ItemIndex:= 0;
      TLMDLabeledListComboBox(Sender).SetFocus;
      MostraMsg('Atenção','Opção inválida!',mtWarning, [mbOk]);
      exit;
    end;
    if not(TabParam.State in dsEditModes) then TabParam.Edit;
    var fieldNameTemp := StringReplace(TLMDLabeledListComboBox(Sender).Name, 'cb', '', [rfReplaceAll, rfIgnoreCase]);
    TabParam.FieldByName(fieldNameTemp).AsInteger:= TLMDLabeledListComboBox(Sender).ItemIndex;
  end;
end;

procedure TFrmConfig.cbVenFechaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key <> 13 then Key := 0;
end;

procedure TFrmConfig.cbVenFechaKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
        SelectNext(TWinControl(Sender), True, True)
   else Key := #0;
end;

procedure TFrmConfig.ckAltMarProCadProdClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamAlteraMargProdCad.AsBoolean := ckAltMarProCadProd.Checked;
   end;
end;

procedure TFrmConfig.ckAltMarProRecClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamAlteraMargProdEnt.AsBoolean := ckAltMarProRec.Checked;
   end;
end;

procedure TFrmConfig.ckCadCompComClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamCadComCom.AsBoolean := ckCadCompCom.Checked;
   end;
end;

procedure TFrmConfig.ckCadObrVenSNGPCClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamCadObrVenSNGPC.AsBoolean := ckCadObrVenSNGPC.Checked;
   end;
end;

procedure TFrmConfig.ckConInsManClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamConInsMan.AsBoolean := ckConInsMan.Checked;
   end;
end;

procedure TFrmConfig.ckContSNGPCClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not(TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamControleSNGPC.AsBoolean := ckContSNGPC.Checked;
   end;
end;

procedure TFrmConfig.ckImpEtiRecSNGPCClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamImpEtiRecSNGPC.AsBoolean := ckImpEtiRecSNGPC.Checked;
   end;
end;

procedure TFrmConfig.ckQuantPresRecClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not(TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamInfQuanPreRec.AsBoolean := ckQuantPresRec.Checked;
   end;
end;

procedure TFrmConfig.ckSNGPCObrComClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamSNGPCObrCompra.AsBoolean := ckSNGPCObrCom.Checked;
   end;
end;

procedure TFrmConfig.ckSNGPCObrPerProdClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamSNGPCObrPerPro.AsBoolean := ckSNGPCObrPerProd.Checked;
   end;
end;

procedure TFrmConfig.ckSNGPCObrVenClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamSNGPCObrVenda.AsBoolean := ckSNGPCObrVen.Checked;
   end;
end;

procedure TFrmConfig.ckSolConFarClick(Sender: TObject);
begin
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      TabParamTipoCerDig.AsBoolean := ckSolConFar.Checked;
   end;
end;

procedure TFrmConfig.LMDDBLabeledEdit8CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit8),'ConCreSup','IDCon','Nomcon','NomConCreSup','Nivcon = 5',0);
end;

procedure TFrmConfig.LMDDBLabeledEdit8KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit8),'ConCreSup','IDCon','Nomcon','NomConCreSup','Nivcon = 5',Key);
end;

procedure TFrmConfig.LMDDBLabeledEdit9CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit10),'ConDebSup','IDCon','Nomcon','NomConDebSup','Nivcon = 5',0);
end;

procedure TFrmConfig.LMDDBLabeledEdit9KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit10),'ConDebSup','IDCon','Nomcon','NomConDebSup','Nivcon = 5',Key);
end;

procedure TFrmConfig.edEMailExit(Sender: TObject);
begin
   if edEMail.Text.Trim <> '' then
   begin
      if not ValidarEmail(edEMail.Text) then
      begin
         MostraMsg('Erro','Email inválido!', mtError, [mbOk]);
         edEMail.SetFocus;
      end;
   end;
end;

procedure TFrmConfig.LMDDBEdit13CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if FileOpenDialog1.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
         TabParamPastaBoletos.Value := FileOpenDialog1.FileName;
   end; //if

end;

procedure TFrmConfig.LMDDBEdit19CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if FileOpenDialog1.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
         TabParamPastaManifesto.Value := FileOpenDialog1.FileName;
   end; //if
end;

procedure TFrmConfig.LMDDBEdit20CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if FileOpenDialog3.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
         TabParamPastaCertDigital.Value := FileOpenDialog3.FileName;
   end; //if

end;

procedure TFrmConfig.LMDDBEdit2CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if FileOpenDialog1.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
         TabParamPastaConfNFCe.Value := FileOpenDialog1.FileName;
   end; //if
end;

procedure TFrmConfig.LMDDBEdit4CustomButtons0Click(Sender: TObject; index: Integer);
begin
   FileOpenDialog2.FileTypes.Clear;
   with FileOpenDialog2.FileTypes.Add do
   begin
      DisplayName := 'Imagens';
      FileMask    := '*.png;*.jpg;*.jpeg';
   end;
   if not (TabParam.State in dsEditModes) then TabParam.Edit;
   if FileOpenDialog2.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
         TabParamImagemNF.Value := FileOpenDialog2.FileName;
   end; //if
end;

procedure TFrmConfig.LMDDBEdit5CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if PrintDialog1.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      if (Printer.Printers <> nil) and (Printer.Printers.Count > 0) then
           TabParamPrinterNFC.Value := Printer.Printers[Printer.PrinterIndex]
      else TabParamPrinterNFC.Value := '';
   end;
end;

procedure TFrmConfig.LMDDBEdit6CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if PrintDialog1.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      if (Printer.Printers <> nil) and (Printer.Printers.Count > 0) then
           TabParamPrinterNFe.Value := Printer.Printers[Printer.PrinterIndex]
      else TabParamPrinterNFe.Value := '';
   end;
end;

procedure TFrmConfig.LMDDBEdit7Exit(Sender: TObject);
begin
   if LMDDBEdit7.Text.Trim <> '' then
   begin
      if not ValidarEmail(LMDDBEdit7.Text) then
      begin
         MostraMsg('Erro','Email inválido!', mtError, [mbOk]);
         LMDDBEdit7.SetFocus;
      end;
   end;
end;

procedure TFrmConfig.LMDDBEdit8CustomButtons0Click(Sender: TObject; index: Integer);
begin
   if FileOpenDialog1.Execute then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
         TabParamPastaConfNFe.Value := FileOpenDialog1.FileName;
   end; //if
end;

procedure TFrmConfig.LMDDBLabeledEdit10CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit10),'ConCreSan','IDCon','Nomcon','NomConCreSan','Nivcon = 5',0);
end;

procedure TFrmConfig.LMDDBLabeledEdit10KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit10),'ConCreSan','IDCon','Nomcon','NomConCreSan','Nivcon = 5',Key);
end;

procedure TFrmConfig.LMDDBLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqfilial',TDBEdit(LMDDBLabeledEdit1),'IDFilialEntr','IDFilial','Nomfil','Nomfil','',0);
end;

procedure TFrmConfig.LMDDBLabeledEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqfilial',TDBEdit(LMDDBLabeledEdit1),'IDFilialEntr','IDFilial','Nomfil','Nomfil','',Key);
end;

procedure TFrmConfig.LMDDBLabeledEdit7CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit7),'ConDebSan','IDCon','Nomcon','NomConDebSan','Nivcon = 5',0);
end;

procedure TFrmConfig.LMDDBLabeledEdit7KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqplacon',TDBEdit(LMDDBLabeledEdit7),'ConDebSan','IDCon','Nomcon','NomConDebSan','Nivcon = 5',Key);
end;

procedure TFrmConfig.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
   if Column.FieldName = 'IndAtivo' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabForPagtoIndAtivo.AsBoolean then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
   if Column.FieldName = 'IndPagVis' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabForPagtoIndPagVis.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmConfig.DBGrid1CellClick(Column: TColumn);
begin
   if Column.FieldName = 'IndAtivo' then
   begin
      if not (TabForPagto.State in dsEditModes) then TabForPagto.Edit;
      TabForPagtoIndAtivo.AsBoolean := not TabForPagtoIndAtivo.AsBoolean;
      TabForPagto.Post;
      DBGrid1.SelectedField := TabForPagtoDesForPag;
   end; //if
   if Column.FieldName = 'IndPagVis' then
   begin
      if not (TabForPagto.State in dsEditModes) then TabForPagto.Edit;
      TabForPagtoIndPagVis.AsString := iif(TabForPagtoIndPagVis.AsString = '1','0','1');
      TabForPagto.Post;
      DBGrid1.SelectedField := TabForPagtoDesForPag;
   end; //if
end;

procedure TFrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   PanelMenu.SetFocus;
   if TabParam.Active then
   begin
      if not (TabParam.State in dsEditModes) then TabParam.Edit;
      case ComboRegime.ItemIndex of
         0: TabParamRegTributa.Value := '1';
         1: TabParamRegTributa.Value := '2';
         2: TabParamRegTributa.Value := '3';
      end;
      TabParamPastaConfNFCe.Value    := StringReplace(TabParamPastaConfNFCe.Value,   '\', '\\', [rfReplaceAll]);
      TabParamPastaConfNFe.Value     := StringReplace(TabParamPastaConfNFe.Value,    '\', '\\', [rfReplaceAll]);
      TabParamImagemNF.Value         := StringReplace(TabParamImagemNF.Value,        '\', '\\', [rfReplaceAll]);
      TabParamPastaManifesto.Value   := StringReplace(TabParamPastaManifesto.Value,  '\', '\\', [rfReplaceAll]);
      TabParamPastaCertDigital.Value := StringReplace(TabParamPastaCertDigital.Value,'\', '\\', [rfReplaceAll]);
      TabParamPastaBoletos.Value     := StringReplace(TabParamPastaBoletos.Value,    '\', '\\', [rfReplaceAll]);
      TabParamSenDigital.Value       := edSenDigital.Text.Trim;
      TabParamSenhaCertMan.Value     := edCertSenPar.Text.Trim;
      TabParamIndCxEfetiva.Value     := cbIndCxEfetiva.ItemIndex;
      TabParamMailSenha.AsString     := edSenMail.Text;
      MyApplayUpdates(TabParam, 'IDFilial', 'IDFilial = '+FILIAL.ToString, dsEdit, True);

      with EMPRESA,TabParam do
      begin
         CNPJ     := FieldByName('CNPJFar').AsString.Trim;
         RAZAO    := FieldByName('Nomefar').AsString.Trim;
         INSEST   := FieldByName('InsEstFar').AsString.Trim;
         ENDERECO := FieldByName('Endfar').AsString.Trim;
         NROEND   := FieldByName('NroEnt').AsString.Trim;
         COMPEND  := FieldByName('CompEnd').AsString.Trim;
         BAIRRO   := FieldByName('Baifar').AsString.Trim;
         CODMUN   := FieldByName('Codmun').AsString.Trim;
         CIDADE   := FieldByName('Nommun').AsString.Trim;
         UF       := FieldByName('Estmun').AsString.Trim;
         CEP      := FieldByName('Cepfar').AsString.Trim;
      end; //with
      FILIAL := TabParam.FieldByName('IDFilial').AsInteger;
      TabParam.Close;
   end; //if
   TabICMS.Close;
   TabClaTribIte.Close;
   TabForPagNF.Close;
   TabFormasPagtos.Close;
   TabForPagto.Close;
   if Assigned(FrmTaxaEntr)then
   begin
      try
         FrmTaxaEntr.Close;
         FrmTaxaEntr := nil;
      except
      end;
   end;
   iteVenc.Free;
   iteCert.Free;
   iteSeri.Free;
   Action := caFree;
end;

procedure TFrmConfig.btTesteMailClick(Sender: TObject);
var
   vErro:String;
begin
   with ACBrMail do
   begin
      Host     := edSMTP.Text;
      From     := edEMail.Text;
      Username := edEMail.Text;
      Password := edSenMail.Text;
      Port     := edMailPorta.Text;
      SetSSL   := ckAutentica.Checked;
      SetTLS   := ckUseTLS.Checked;
      FromName := 'Teste';
      Subject  := 'Teste de envio';
      ACBrMail.AddAddress('arantes.marcelo@gmail.com','arantes.marcelo@gmail.com');
   end;
   ACBrMail.Send;
   MostraMsg('Aviso','E-mail operando normalmente!', mtInformation, [mbOk]);
end;


end.

