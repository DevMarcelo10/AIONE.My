unit uVendasInc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomLabel, LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDSimplePanel, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  RxToolEdit, RxDBCtrl, LMDBaseEdit, LMDCustomEdit, LMDDBEdit, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, LMDCustomMaskEdit, LMDButtonControl,
  LMDRadioButton, LMDCustomExtCombo, LMDCustomListComboBox, Marclib,
  uRESTDWBasicDB, Datasnap.DBClient, LMDListComboBox, Vcl.DBCtrls,
  uWaitForm;

type
  TFrmVendasInc = class(TForm)
    PanelPri: TLMDSimplePanel;
    Shape1: TShape;
    PanelCabecalho: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    PanelLisProd: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelRodape: TLMDSimplePanel;
    LabelCab: TLMDLabel;
    PanelCadProd: TLMDSimplePanel;
    lbDataVenda: TLMDLabel;
    lbDataVenc: TLMDLabel;
    edNroNota: TLMDDBLabeledEdit;
    edDesPro: TLMDDBLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataVenda: TDBDateEdit;
    edRegMS: TLMDDBLabeledEdit;
    edQuant: TLMDDBLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    edDataVenc: TDBDateEdit;
    edNrolot: TLMDDBLabeledEdit;
    btProdutos: TAdvGlowButton;
    btConfirma: TAdvGlowButton;
    LMDSimplePanel6: TLMDSimplePanel;
    edDataPresc: TDBDateEdit;
    lbDataPresc: TLMDLabel;
    edNumRec: TLMDDBLabeledEdit;
    edComp: TLMDDBLabeledEdit;
    edPrescritor: TLMDDBLabeledEdit;
    edEndComp: TLMDDBLabeledEdit;
    edNumDocComp: TLMDDBLabeledEdit;
    edCepComp: TLMDDBLabeledEdit;
    edCidComp: TLMDDBLabeledEdit;
    edBairroComp: TLMDDBLabeledEdit;
    PanelConf: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    rbConSim: TLMDRadioButton;
    rbConNao: TLMDRadioButton;
    edOrgExpComp: TLMDDBLabeledEdit;
    ComboUFEmiComp: TLMDLabeledListComboBox;
    PanelUsoProlong: TLMDSimplePanel;
    LMDLabel6: TLMDLabel;
    rbUsoProlSim: TLMDRadioButton;
    rbUsoProlNao: TLMDRadioButton;
    edVend: TLMDDBLabeledEdit;
    ComboTipDocComp: TLMDLabeledListComboBox;
    ComboUsoMed: TLMDLabeledListComboBox;
    edIdade: TLMDDBLabeledEdit;
    ComboSexo: TLMDLabeledListComboBox;
    LMDDBLabeledEdit9: TLMDDBLabeledEdit;
    LMDDBLabeledEdit13: TLMDDBLabeledEdit;
    edNumVenda: TLMDDBLabeledEdit;
    cdsVenda: TClientDataSet;
    cdsVendaIDFilial: TIntegerField;
    cdsVendaIDProd: TIntegerField;
    cdsVendaNrolot: TWideStringField;
    cdsVendaIDPess: TIntegerField;
    cdsVendaIDPed: TIntegerField;
    cdsVendaDatVenda: TDateField;
    cdsVendaDatpre: TDateField;
    cdsVendaDatven: TDateField;
    cdsVendaNroRece: TWideStringField;
    cdsVendaIDComp: TIntegerField;
    cdsVendaIDVend: TIntegerField;
    cdsVendaIDPres: TIntegerField;
    cdsVendaNroReg: TWideStringField;
    cdsVendaUFReg: TWideStringField;
    cdsVendaQtdven: TFloatField;
    cdsVendaIndConf: TWideStringField;
    cdsVendaConReg: TWideStringField;
    cdsVendaIDInvIni: TIntegerField;
    cdsVendaTransmitida: TWideStringField;
    cdsVendaDespro: TWideStringField;
    cdsVendaRegistoMS: TWideStringField;
    cdsVendaNomfab: TWideStringField;
    cdsVendaNomcom: TWideStringField;
    cdsVendaNompre: TWideStringField;
    cdsVendaNomven: TWideStringField;
    SouVenda: TDataSource;
    cdsLote: TClientDataSet;
    cdsLoteIDProd: TIntegerField;
    cdsLoteNroLot: TWideStringField;
    cdsLoteQtdLote: TFloatField;
    cdsLoteDatVen: TDateField;
    cdsLoteUsoRece: TWideStringField;
    SouLote: TDataSource;
    cdsVendaNroNot: TIntegerField;
    edNumComp: TLMDDBLabeledEdit;
    ComboUFComp: TLMDLabeledListComboBox;
    cdsVendaSexo: TWideStringField;
    cdsVendaIdade: TIntegerField;
    cdsVendaEndereco: TWideStringField;
    cdsVendaNumero: TWideStringField;
    cdsVendaBairro: TWideStringField;
    cdsVendaCidade: TWideStringField;
    cdsVendaUF: TWideStringField;
    cdsVendaCep: TWideStringField;
    cdsVendaTipoDoc: TWideStringField;
    cdsVendaNumDoc: TWideStringField;
    cdsVendaOrgExp: TWideStringField;
    cdsVendaUFEmis: TWideStringField;
    cdsVendaUsoProlong: TWideStringField;
    cdsLoteQtdVenda: TFloatField;
    cdsVendaUsoMed: TWideStringField;
    ComboUnidIdade: TLMDLabeledListComboBox;
    edNumReg: TLMDDBLabeledEdit;
    cdsVendaIDPac: TIntegerField;
    cdsVendaNomPac: TWideStringField;
    cdsVendaClasTera: TWideStringField;
    cdsVendaUniIdadePac: TWideStringField;
    cdsVendaIDVenda: TIntegerField;
    cdsVendaUsoRece: TWideStringField;
    btIncPro: TAdvGlowButton;
    btAltPro: TAdvGlowButton;
    btExcPro: TAdvGlowButton;
    btSalPro: TAdvGlowButton;
    btCanPro: TAdvGlowButton;
    cdsCloneVenda: TClientDataSet;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TWideStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    DateField1: TDateField;
    DateField2: TDateField;
    DateField3: TDateField;
    StringField2: TWideStringField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    StringField3: TWideStringField;
    StringField4: TWideStringField;
    FloatField1: TFloatField;
    StringField5: TWideStringField;
    StringField6: TWideStringField;
    IntegerField8: TIntegerField;
    StringField7: TWideStringField;
    StringField8: TWideStringField;
    StringField9: TWideStringField;
    StringField10: TWideStringField;
    StringField11: TWideStringField;
    StringField12: TWideStringField;
    StringField13: TWideStringField;
    IntegerField9: TIntegerField;
    StringField14: TWideStringField;
    IntegerField10: TIntegerField;
    StringField15: TWideStringField;
    StringField16: TWideStringField;
    StringField17: TWideStringField;
    StringField18: TWideStringField;
    StringField19: TWideStringField;
    StringField20: TWideStringField;
    StringField21: TWideStringField;
    StringField22: TWideStringField;
    StringField23: TWideStringField;
    StringField24: TWideStringField;
    StringField25: TWideStringField;
    StringField26: TWideStringField;
    IntegerField11: TIntegerField;
    StringField27: TWideStringField;
    StringField28: TWideStringField;
    StringField29: TWideStringField;
    IntegerField12: TIntegerField;
    StringField30: TWideStringField;
    cdsCloneLote: TClientDataSet;
    IntegerField13: TIntegerField;
    StringField31: TWideStringField;
    FloatField2: TFloatField;
    DateField4: TDateField;
    StringField32: TWideStringField;
    FloatField3: TFloatField;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid2: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btIncProClick(Sender: TObject);
    procedure edDesProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesProCustomButtons0Click(Sender: TObject; index: Integer);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCanProClick(Sender: TObject);
    procedure edVendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edVendCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edCompKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCompCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btSalProClick(Sender: TObject);
    procedure ComboUsoMedChange(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure edNumRegKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNumRegCustomButtons0Click(Sender: TObject; index: Integer);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btAltProClick(Sender: TObject);
    procedure btExcProClick(Sender: TObject);
    procedure SouVendaDataChange(Sender: TObject; Field: TField);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure btProdutosClick(Sender: TObject);
    procedure edPrescritorCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edPrescritorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPrescritorCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edCompCustomButtons1Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
    auxFiltro:Array of String;
    procedure AjustaGrid;
    procedure BuscaInfPro;
    procedure AjustBotoes(Acao:Boolean);
    procedure MostraCampos;
    procedure BuscaInfPresc;
    procedure BuscaInfComp;
    Function  GravaProduto:Boolean;
    procedure BuscaInfPac;
    procedure ConfiTela(auxConfig:Integer);
    procedure AtualizaTabTemp;
    procedure DelProd;
    procedure AjustaDados;
    procedure AlteraQtdLoteSngpc(Sender: TObject);
    procedure CarregDadosAlter(recIDProd:Integer);
    function  Filtrolotes:String;
    function  MontaFiltro:String;
  public
    { Public declarations }
    recIDFilial,recInclProd,recIDInvIni,recIDVenda:Integer;
    recOrigem:String;
    tabVenda: TRESTDWClientSQL;
  end;

var
  FrmVendasInc: TFrmVendasInc;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uProdutoCad, uPessoasCad, uBuscaProdPerda, uQtdEstLote;

procedure TFrmVendasInc.AjustaGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmVendasInc.FormShow(Sender: TObject);
begin
   AjustaGrid;
   recinclProd := 0;
   if recOrigem = 'ALTERAR' then
   begin
      btAltPro.Enabled := True;
      LabelCab.Caption := 'SNGPC - Manipulação dos produtos ligados as vendas';
      btAltPro.SetFocus;
      cdsCloneVenda.Data := cdsVenda.Data;
      cdsCloneLote.Data  := cdsLote.Data;
      if cdsVendaClasTera.AsString = '1' then
           ConfiTela(1)
      else ConfiTela(2);
   end else
   begin
      ComboUsoMed.ItemIndex     := -1;
      ComboUFComp.ItemIndex     := -1;
      ComboTipDocComp.ItemIndex := -1;
      ComboUFEmiComp.ItemIndex  := -1;
      ComboSexo.ItemIndex       := -1;
      btIncPro.SetFocus;
   end;// if
end;

procedure TFrmVendasInc.AtualizaTabTemp;
var
   QueLote,QueComp:TRESTDWClientSQL;
   auxIDVenda,auxIDFilial,auxIDInvIni,auxIDProd,auxProd:Integer;
begin
   QueLote          := TRESTDWClientSQL.Create(nil);
   QueComp          := TRESTDWClientSQL.Create(nil);
   QueLote.DataBase := DM.DWDataBase;
   QueComp.DataBase := DM.DWDataBase;
   auxIDVenda  := TabVenda.FieldByName('IDVenda').AsInteger;
   auxIDFilial := TabVenda.FieldByName('IDFilial').AsInteger;
   auxIDInvIni := TabVenda.FieldByName('IDInvIni').AsInteger;
   auxIDProd   := TabVenda.FieldByName('IDProd').AsInteger;
   try
      auxIDProd := 0;
      auxProd   := 0;
      TabVenda.Filtered := False;
      TabVenda.Filter   := 'IDVenda = '+auxIDVenda.ToString;
      TabVenda.Filtered := True;
      TabVenda.First;
      while not TabVenda.Eof do
      begin
         FrmVendasInc.cdsVenda.Append;
         FrmVendasInc.cdsVendaIDFilial.AsInteger   := TabVenda.FieldByName('IDFilial').AsInteger;
         FrmVendasInc.cdsVendaIDProd.AsInteger     := TabVenda.FieldByName('IDProd').AsInteger;
         FrmVendasInc.cdsVendaNrolot.AsString      := TabVenda.FieldByName('Nrolot').AsString;
         FrmVendasInc.cdsVendaIDPess.AsInteger     := TabVenda.FieldByName('IDPess').AsInteger;
         FrmVendasInc.cdsVendaIDPed.AsInteger      := TabVenda.FieldByName('IDPed').AsInteger;
         FrmVendasInc.cdsVendaDatVenda.AsDateTime  := TabVenda.FieldByName('DatVenda').AsDateTime;
         FrmVendasInc.cdsVendaDatpre.AsDateTime    := TabVenda.FieldByName('Datpre').AsDateTime;
         FrmVendasInc.cdsVendaDatven.AsDateTime    := TabVenda.FieldByName('Datven').AsDateTime;
         FrmVendasInc.cdsVendaNroRece.AsString     := TabVenda.FieldByName('NroRece').AsString;
         FrmVendasInc.cdsVendaIDComp.AsInteger     := TabVenda.FieldByName('IDComp').AsInteger;
         FrmVendasInc.cdsVendaIDVend.AsInteger     := TabVenda.FieldByName('IDVend').AsInteger;
         FrmVendasInc.cdsVendaIDPres.AsInteger     := TabVenda.FieldByName('IDPres').AsInteger;
         FrmVendasInc.cdsVendaNroReg.AsString      := TabVenda.FieldByName('NroRegProf').AsString;
         FrmVendasInc.cdsVendaUFReg.AsString       := TabVenda.FieldByName('EstRegProf').AsString;
         FrmVendasInc.cdsVendaQtdven.AsFloat       := TabVenda.FieldByName('Qtdven').AsFloat;
         FrmVendasInc.cdsVendaIndConf.AsString     := TabVenda.FieldByName('IndConf').AsString;
         FrmVendasInc.cdsVendaConReg.AsString      := TabVenda.FieldByName('ConRegProf').AsString;
         FrmVendasInc.cdsVendaIDInvIni.AsInteger   := TabVenda.FieldByName('IDInvIni').AsInteger;
         FrmVendasInc.cdsVendaTransmitida.AsString := TabVenda.FieldByName('Transmitida').AsString;
         FrmVendasInc.cdsVendaDespro.AsString      := TabVenda.FieldByName('Despro').AsString;
         FrmVendasInc.cdsVendaRegistoMS.AsString   := TabVenda.FieldByName('RegistoMS').AsString;
         FrmVendasInc.cdsVendaNomfab.AsString      := TabVenda.FieldByName('Nomfab').AsString;
         FrmVendasInc.cdsVendaNomcom.AsString      := TabVenda.FieldByName('Nomcom').AsString;
         FrmVendasInc.cdsVendaNompre.AsString      := TabVenda.FieldByName('Nompre').AsString;
         FrmVendasInc.cdsVendaNomven.AsString      := TabVenda.FieldByName('Nomven').AsString;
         FrmVendasInc.cdsVendaNroNot.AsInteger     := TabVenda.FieldByName('NroNot').AsInteger;
         FrmVendasInc.cdsVendaUsoProlong.AsString  := TabVenda.FieldByName('UsoProlong').AsString;
         FrmVendasInc.cdsVendaUsoMed.AsString      := TabVenda.FieldByName('UsoMed').AsString;
         FrmVendasInc.cdsVendaIDPac.AsInteger      := TabVenda.FieldByName('IDPac').AsInteger;
         FrmVendasInc.cdsVendaNomPac.AsString      := TabVenda.FieldByName('Nompac').AsString;
         FrmVendasInc.cdsVendaClasTera.AsString    := TabVenda.FieldByName('ClasTera').AsString;
         FrmVendasInc.cdsVendaIDVenda.AsInteger    := TabVenda.FieldByName('IDVenda').AsInteger;
         ///Pega o comprador ou o paciente por produto
         if auxProd <> TabVenda.FieldByName('IDProd').AsInteger then
         begin
            auxProd := TabVenda.FieldByName('IDProd').AsInteger;
            if TabVenda.FieldByName('ClasTera').AsString = '1' then
            begin
               QueComp.Close;
               QueComp.SQL.Text := 'SELECT * FROM arqsngpcvenpac WHERE IDVenda ='+auxIDVenda.ToString;
               QueComp.Open;
            end else
            begin
               QueComp.Close;
               QueComp.SQL.Text := 'SELECT * FROM arqsngpcvencom WHERE IDVenda ='+auxIDVenda.ToString;
               QueComp.Open;
            end;// if
         end;// if

         // Passa o comprador ou o paciente para a tabela temporária
         if TabVenda.FieldByName('ClasTera').AsString = '1' then
         begin
            if not QueComp.IsEmpty then
            begin
               FrmVendasInc.cdsVendaSexo.AsString        := QueComp.FieldByName('SexoPac').AsString;
               FrmVendasInc.cdsVendaIdade.AsInteger      := QueComp.FieldByName('IdadePac').AsInteger;
               FrmVendasInc.cdsVendaUniIdadePac.AsString := QueComp.FieldByName('UniIdadePac').AsString;
            end;// if
         end else
         begin
            if not QueComp.IsEmpty then
            begin
               FrmVendasInc.cdsVendaEndereco.AsString := QueComp.FieldByName('Endcomp').AsString;
               FrmVendasInc.cdsVendaNumero.AsString   := QueComp.FieldByName('NroEndComp').AsString;
               FrmVendasInc.cdsVendaBairro.AsString   := QueComp.FieldByName('BaiComp').AsString;
               FrmVendasInc.cdsVendaCidade.AsString   := QueComp.FieldByName('DesMunComp').AsString;
               FrmVendasInc.cdsVendaUF.AsString       := QueComp.FieldByName('EstComp').AsString;
               FrmVendasInc.cdsVendaCep.AsString      := QueComp.FieldByName('CepComp').AsString;
               FrmVendasInc.cdsVendaTipoDoc.AsString  := QueComp.FieldByName('TipDocComp').AsString;
               FrmVendasInc.cdsVendaNumDoc.AsString   := QueComp.FieldByName('NumDocComp').AsString;
               FrmVendasInc.cdsVendaOrgExp.AsString   := QueComp.FieldByName('OrgExpComp').AsString;
               FrmVendasInc.cdsVendaUFEmis.AsString   := QueComp.FieldByName('EstEmiComp').AsString;
            end; //if
         end; //if

         FrmVendasInc.cdsVenda.Post;

         // Insere os lotes do produto que vai ser alterado
         if auxIDProd <> TabVenda.FieldByName('IDProd').AsInteger then
         begin
            auxIDProd := TabVenda.FieldByName('IDProd').AsInteger;
            QueLote.Close;
            QueLote.SQL.Text := 'SELECT IDProd,Nrolot,Qtdest,Datven FROM arqsngpclot' +
            ' WHERE IDFilial = '+auxIDFilial.ToString+ ' AND IDInvIni = '+auxIDInvIni.ToString+
            ' AND IDProd = '+auxIDProd.ToString+' AND Qtdest >= 0 ORDER BY Datven ASC';
            QueLote.Open;
            QueLote.First;
            while not QueLote.Eof do
            begin
               FrmVendasInc.cdsLote.Append;
               FrmVendasInc.cdsLoteIDProd.AsInteger  := QueLote.FieldByName('IDProd').AsInteger;
               FrmVendasInc.cdsLoteDatVen.AsDateTime := QueLote.FieldByName('Datven').AsDateTime;
               FrmVendasInc.cdsLoteNroLot.AsString   := QueLote.FieldByName('Nrolot').AsString;
               FrmVendasInc.cdsLoteQtdLote.AsFloat   := QueLote.FieldByName('Qtdest').AsFloat;
               FrmVendasInc.cdsLote.Post;
               QueLote.Next;
            end; // while
         end;

         // Acha o lote que tem venda
         FrmVendasInc.cdsLote.Filtered := False;
         FrmVendasInc.cdsLote.Filter   := 'NroLot = '+TabVenda.FieldByName('Nrolot').AsString;
         FrmVendasInc.cdsLote.Filtered := True;
         if not FrmVendasInc.cdsLote.IsEmpty then
         begin
            FrmVendasInc.cdsLote.Edit;
            FrmVendasInc.cdsLoteQtdVenda.AsFloat := TabVenda.FieldByName('Qtdven').AsFloat;
            FrmVendasInc.cdsLote.Post;
         end;
         FrmVendasInc.cdsLote.Filtered := False;
         TabVenda.Next;
      end;// while
      TabVenda.Filtered := False;
   finally
      QueLote.Close;
      QueComp.Close;
      FreeAndNil(QueLote);
      FreeAndNil(QueComp);
   end;// try
end;

procedure TFrmVendasInc.ConfiTela(auxConfig: Integer);
begin
   if cdsVendaIndConf.AsString = '0' then
        rbConNao.Checked := True
   else rbConSim.Checked := True;

   if cdsVendaUsoProlong.AsString = '0' then
        rbUsoProlNao.Checked := True
   else rbUsoProlSim.Checked := True;

   ComboUsoMed.ItemIndex := cdsVendaUsoMed.AsInteger-1;

   if auxConfig = 1 then
   begin
      ComboSexo.ItemIndex       := cdsVendaSexo.AsInteger-1;
      ComboUnidIdade.ItemIndex  := cdsVendaUniIdadePac.AsInteger-1;
      edComp.EditLabel.Caption  := 'PACIENTE';
      edComp.DataField          := 'NomPac';
      ComboUFComp.ItemIndex     := -1;
      ComboTipDocComp.ItemIndex := -1;
      ComboUFEmiComp.ItemIndex  := -1;
   end;
   if auxConfig = 2 then
   begin
      ComboUFComp.ItemIndex     := ComboUFComp.Items.IndexOf(cdsVendaUF.AsString);
      if cdsVendaTipoDoc.AsString = '99' then
           ComboTipDocComp.ItemIndex := 8
      else ComboTipDocComp.ItemIndex := cdsVendaTipoDoc.AsInteger-1;
      ComboUFEmiComp.ItemIndex  := ComboUFEmiComp.Items.IndexOf(cdsVendaUFEmis.AsString);
      ComboSexo.ItemIndex       := -1;
      ComboUnidIdade.ItemIndex  := -1;
   end;
end;

procedure TFrmVendasInc.AjustaDados;
begin
   // Classe terapêutica for ANTIMICROBIANO
   if cdsVendaClasTera.AsString = '1' then
   begin
      cdsVendaIDComp.AsInteger  := 0;
      cdsVendaEndereco.AsString := '';
      cdsVendaNumero.AsString   := '';
      cdsVendaBairro.AsString   := '';
      cdsVendaCep.AsString      := '';
      cdsVendaCidade.AsString   := '';
      ComboUFComp.ItemIndex     := -1;
      cdsVendaUF.AsString       := '';
      ComboTipDocComp.ItemIndex := -1;
      cdsVendaTipoDoc.AsString  := '';
      cdsVendaNumDoc.AsString   := '';
      cdsVendaOrgExp.AsString   := '';
      ComboUFEmiComp.ItemIndex  := -1;
      cdsVendaUFEmis.AsString   := '';
   end;

   // Classe terapêutica for PSICOTRÓPICO
   if cdsVendaClasTera.AsString = '2' then
   begin
      cdsVendaIDPac.AsInteger := 0;
      ComboSexo.ItemIndex     := -1;
      cdsVendaSexo.AsString   := '';
      cdsVendaIdade.AsString  := '';
   end;// if
end;

function TFrmVendasInc.MontaFiltro: String;
var
   I:Integer;
begin
   Result := ' AND (';
   for I := Low(auxFiltro) to High(auxFiltro) do
   begin
      if auxFiltro[I] <> '' then
      begin
         if I = High(auxFiltro) then
            Result := Result +'(NroLot = '+ auxFiltro[I]+')'
         else
            Result := Result +'(NroLot = '+ auxFiltro[I]+') or ';
      end;// if
   end;// for
   Result := Result +')';
end;

function TFrmVendasInc.GravaProduto: Boolean;
var
   auxIDFilial,auxIDProd,auxIDPess,auxIDPed,auxIDComp,auxIDVend,auxIDPres,auxIDInvIni,auxIdade,auxNroNot,auxIDPac:Integer;
   auxNroRece,auxNrolot,auxNroReg,auxUFReg,auxIndConf,auxConReg,auxTransmitida,auxDespro,auxRegistoMS:String;
   auxNomfab,auxNomcom,auxNompre,auxNomven,auxSexo,auxEndereco,auxNumero,auxBairro,auxCidade,auxNomPac:String;
   auxUF,auxCep,auxTipoDocComp,auxNumDocComp,auxOrgExpComp,auxUFEmisComp,auxUsoProlong,auxUsoMed,auxClasTera,auxUniIdadePac:String;
   auxQtdven:Double;
   auxDatVenda,auxDatpre,auxDatVen:TDatetime;
   Achou:Integer;
   QueAuxi:TRESTDWClientSQL;
   auxFiltro:String;
begin
   Result := False;
   if edDataVenda.Date <= 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a data da venda!',mtWarning, [mbOk]);
      edDataVenda.SetFocus;
      Exit;
   end;// if

   if edDataPresc.Date <= 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a data da prescrição!',mtWarning, [mbOk]);
      edDataPresc.SetFocus;
      Exit;
   end;// if

   if cdsVendaIDProd.AsInteger <= 0 then
   begin
      MostraMsg('Produto não informado','Favor verificar o produto!',mtWarning, [mbOk]);
      edDesPro.SetFocus;
      Exit;
   end; //if

   auxRegistoMS := cdsVendaRegistoMS.AsString.Trim;
   if (not(Length(auxRegistoMS) = 13)) or (not(IsNumeric(auxRegistoMS))) or (not(Copy(auxRegistoMS,1,1) = '1')) then
   begin
      MostraMsg('Registro MS inválido','Favor verificar o registro MS do produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if
   //Testa se tem um lote.
   if cdsLote.IsEmpty then
   begin
      MostraMsg('Qiantidade inválida','Favor verificar a qunatidade no lote do produto!',mtWarning, [mbOk]);
      btSalPro.SetFocus;
      Exit;
   end;

   // Calcula as datas de venda e prescrição --- Antimicrobiano 10 dias de validade ---
   if cdsVendaClasTera.AsString = '1' then // ANTIMICROBIANO
   begin
      if edDataPresc.Date <= edDataVenda.Date then
      begin
         if (edDataVenda.Date - edDataPresc.Date) >= 10 then
         begin
            MostraMsg('Data inválida','Data da venda superior a data de prescrição em 10 dias!',mtWarning, [mbOk]);
            edDataVenda.SetFocus;
            Exit;
         end;
      end else
      begin
         MostraMsg('Data inválida','Favor verificar, a data da venda não pode ser anterior a data da prescrição!',mtWarning, [mbOk]);
         edDataVenda.SetFocus;
         Exit;
      end;
   end;// if

   // Calcula as datas de venda e prescrição --- psicotrópicos 30 dias de validade ---
   if cdsVendaClasTera.AsString = '2' then // PSICOTRÓPICO
   begin
      if edDataPresc.Date <= edDataVenda.Date then
      begin
         if (edDataVenda.Date - edDataPresc.Date) >= 30 then
         begin
            MostraMsg('Data inválida','Data da venda superior a data de prescrição em 30 dias!',mtWarning, [mbOk]);
            edDataVenda.SetFocus;
            Exit;
         end;
      end else
      begin
         MostraMsg('Data inválida','Favor verificar, a data da venda não pode ser anterior a data da prescrição!',mtWarning, [mbOk]);
         edDataVenda.SetFocus;
         Exit;
      end;
   end;// if

   if (cdsVendaUsoRece.AsString = 'A1') or (cdsVendaUsoRece.AsString = 'A2') or (cdsVendaUsoRece.AsString = 'A3') or
      (cdsVendaUsoRece.AsString = 'B1') or (cdsVendaUsoRece.AsString = 'B2') then
   begin
      if cdsVendaNroRece.AsString = '' then
      begin
         MostraMsg('Número receita não informado','Favor verificar o número da receita!',mtWarning, [mbOk]);
         edNumRec.SetFocus;
         Exit;
      end;
   end;

   if cdsVendaIDPres.AsInteger <= 0 then
   begin
      MostraMsg('Prescritor não informado','Favor verificar o prescritor!',mtWarning, [mbOk]);
      edPrescritor.SetFocus;
      Exit;
   end; //if
   if cdsVendaNroReg.AsString <= '' then
   begin
      MostraMsg('Número registro do Prescritor não informado','Favor verificar número registro do prescritor!',mtWarning, [mbOk]);
      edPrescritor.SetFocus;
      Exit;
   end; //if
   if cdsVendaConReg.AsString = '' then
   begin
      MostraMsg('Conselho do Prescritor não informado','Favor verificar o conselho do prescritor!',mtWarning, [mbOk]);
      edPrescritor.SetFocus;
      Exit;
   end; //if
   if cdsVendaUFReg.AsString = '' then
   begin
      MostraMsg('UF do Prescritor não informado','Favor o UF do prescritor!',mtWarning, [mbOk]);
      edPrescritor.SetFocus;
      Exit;
   end; //if

   // Classe terapêutica for PSICOTRÓPICO
   if cdsVendaClasTera.AsString = '2' then
   begin
      if cdsVendaIDComp.AsInteger <= 0 then
      begin
         MostraMsg('Comprador não informado','Favor verificar o comprador!',mtWarning, [mbOk]);
         edComp.SetFocus;
         Exit;
      end; //if
      if cdsVendaEndereco.AsString = '' then
      begin
         MostraMsg('Endereço não informado','Favor verificar o endereço!',mtWarning, [mbOk]);
         edEndComp.SetFocus;
         Exit;
      end; //if
      if cdsVendaNumero.AsString = '' then
      begin
         MostraMsg('Número não informado','Favor verificar o número do endereço!',mtWarning, [mbOk]);
         edNumComp.SetFocus;
         Exit;
      end; //if
      if cdsVendaBairro.AsString = '' then
      begin
         MostraMsg('Bairro não informado','Favor verificar o bairro!',mtWarning, [mbOk]);
         edBairroComp.SetFocus;
         Exit;
      end; //if
      if cdsVendaCep.AsString = '' then
      begin
         MostraMsg('CEP não informado','Favor verificar o CEP!',mtWarning, [mbOk]);
         edCepComp.SetFocus;
         Exit;
      end; //if
      if cdsVendaCidade.AsString = '' then
      begin
         MostraMsg('Cidade não informado','Favor verificar a cidade!',mtWarning, [mbOk]);
         edCidComp.SetFocus;
         Exit;
      end; //if
      if ComboUFComp.ItemIndex = -1 then
      begin
         MostraMsg('UF não informado','Favor verificar o UF do endereço!',mtWarning, [mbOk]);
         ComboUFComp.SetFocus;
         Exit;
      end; //if
      if ComboTipDocComp.ItemIndex = -1 then
      begin
         MostraMsg('Tipo do documento não informado','Favor verificar o tipo do documento!',mtWarning, [mbOk]);
         ComboTipDocComp.SetFocus;
         Exit;
      end; //if
      if cdsVendaNumDoc.AsString = '' then
      begin
         MostraMsg('Número do documento não informado','Favor verificar o número do documento!',mtWarning, [mbOk]);
         edNumDocComp.SetFocus;
         Exit;
      end; //if
      if ComboTipDocComp.ItemIndex = 0 then
      begin
         if not (cdsVendaOrgExp.AsString = '') then
         begin
            MostraMsg('Orgão expedidor não informado','Favor verificar o orgão expedidor!',mtWarning, [mbOk]);
            edOrgExpComp.SetFocus;
            Exit;
         end; //if
         if ComboUFEmiComp.ItemIndex = -1 then
         begin
            MostraMsg('UF Documento não informado','Favor verificar o uf do documento!',mtWarning, [mbOk]);
            ComboUFEmiComp.SetFocus;
            Exit;
         end; //if
      end;// if
   end;

   // Classe terapêutica for ANTIMICROBIANO
   if (cdsVendaClasTera.AsString = '1') and (ComboUsoMed.ItemIndex = 0) then
   begin
      if cdsVendaIDPac.AsInteger <= 0 then
      begin
         MostraMsg('Paciente não informado','Favor verificar o paciente!',mtWarning, [mbOk]);
         edComp.SetFocus;
         Exit;
      end; //if
      if ComboSexo.ItemIndex = -1 then
      begin
         MostraMsg('Sexo do paciente não informado','Favor verificar o sexo do paciente!',mtWarning, [mbOk]);
         ComboSexo.SetFocus;
         Exit;
      end; //if
      if cdsVendaIdade.AsString = '' then
      begin
         MostraMsg('Idade não informada','Favor verificar a idade!',mtWarning, [mbOk]);
         edIdade.SetFocus;
         Exit;
      end; //if
   end;// if

   // Acerta dados para gravação do comprador e do paciente conforme a classe terapêutica na alteração
   if recOrigem = 'ALTERAR' then  AjustaDados;

   auxIDFilial    := cdsVendaIDFilial.AsInteger;
   auxIDInvIni    := cdsVendaIDInvIni.AsInteger;
   auxIDProd      := cdsVendaIDProd.AsInteger;
   auxIDPess      := cdsVendaIDPess.AsInteger;
   auxIDPed       := cdsVendaIDPed.AsInteger;
   auxDatVenda    := cdsVendaDatVenda.AsDateTime;
   auxDatpre      := cdsVendaDatpre.AsDateTime;
   auxNroRece     := cdsVendaNroRece.AsString;
   auxIDComp      := cdsVendaIDComp.AsInteger;
   auxIDVend      := cdsVendaIDVend.AsInteger;
   auxIDPres      := cdsVendaIDPres.AsInteger;
   auxNroReg      := cdsVendaNroReg.AsString;
   auxUFReg       := cdsVendaUFReg.AsString;
   auxConReg      := cdsVendaConReg.AsString;
   auxTransmitida := '0';
   auxDespro      := cdsVendaDespro.AsString;
   auxRegistoMS   := cdsVendaRegistoMS.AsString;
   auxNomfab      := cdsVendaNomfab.AsString;
   auxNomcom      := cdsVendaNomcom.AsString;
   auxNompre      := cdsVendaNompre.AsString;
   auxNomven      := cdsVendaNomven.AsString;
   auxEndereco    := cdsVendaEndereco.AsString;
   auxNumero      := cdsVendaNumero.AsString;
   auxBairro      := cdsVendaBairro.AsString;
   auxCidade      := cdsVendaCidade.AsString;
   auxCep         := cdsVendaCep.AsString;
   auxOrgExpComp  := cdsVendaOrgExp.AsString;
   auxIDPac       := cdsVendaIDPac.AsInteger;
   auxNomPac      := cdsVendaNomPac.AsString;
   auxClasTera    := cdsVendaClasTera.AsString;
   auxIdade       := cdsVendaIdade.AsInteger;
   auxNumDocComp  := cdsVendaNumDoc.AsString;

   if rbConSim.Checked then
        auxIndConf := '1'
   else auxIndConf := '0';

   if ComboUFComp.ItemIndex = -1 then
        auxUF := ''
   else auxUF := ComboUFComp.Items[ComboUFComp.ItemIndex];

   if ComboUFEmiComp.ItemIndex = -1 then
        auxUFEmisComp := ''
   else auxUFEmisComp := ComboUFEmiComp.Items[ComboUFEmiComp.ItemIndex];

   if rbUsoProlSim.Checked then
        auxUsoProlong := '1'
   else auxUsoProlong := '0';

   if ComboUsoMed.ItemIndex = -1 then
        auxUsoMed := ''
   else auxUsoMed := IntToStr(ComboUsoMed.ItemIndex+1);

   if edNroNota.Text <> '' then
        auxNroNot   := StrToInt(edNroNota.Text)
   else auxNroNot   := 0;

   if ComboSexo.ItemIndex = -1 then
        auxSexo := ''
   else auxSexo := IntToStr(ComboSexo.ItemIndex+1);

   if ComboUnidIdade.ItemIndex = -1 then
        auxUniIdadePac := ''
   else auxUniIdadePac := IntToStr(ComboUnidIdade.ItemIndex+1);

   if ComboTipDocComp.ItemIndex = -1 then
      auxTipoDocComp := '0'
   else
   begin
      if ComboTipDocComp.ItemIndex = 8 then
           auxTipoDocComp := '99'
      else auxTipoDocComp := IntToStr(ComboTipDocComp.ItemIndex+1);
   end; //if

   // Faz a alteração do produto na venda no SNGPC
   if recOrigem = 'ALTERAR' then
   begin //Aqui foi incluido um lote novo no produto
      if recInclProd = 1 then
      begin
         auxFiltro := MontaFiltro;
         cdsLote.Filtered := False;
         cdsLote.Filter   := 'QtdVenda > 0'+auxFiltro;
         cdsLote.Filtered := True;
      end else
      if recInclProd = 2 then
      begin
         cdsLote.Filtered := False;
         cdsLote.Filter   := 'NroLot = '+cdsVendaNrolot.AsString;
         cdsLote.Filtered := True;
      end else
      begin
         cdsLote.Filtered := False;
         cdsLote.Filter   := 'QtdVenda > 0';
         cdsLote.Filtered := True;
      end;// if

      cdsLote.First;
      while not cdsLote.Eof do
      begin
         cdsVendaIDFilial.AsInteger   := auxIDFilial;
         cdsVendaIDProd.AsInteger     := auxIDProd;
         cdsVendaNrolot.AsString      := cdsLoteNroLot.AsString;
         cdsVendaIDPess.AsInteger     := auxIDPess;
         cdsVendaIDPed.AsInteger      := auxIDPed;
         cdsVendaDatVenda.AsDateTime  := auxDatVenda;
         cdsVendaDatpre.AsDateTime    := auxDatpre;
         cdsVendaDatven.AsDateTime    := cdsLoteDatVen.AsDateTime;
         cdsVendaNroRece.AsString     := auxNroRece;
         cdsVendaIDComp.AsInteger     := auxIDComp;
         cdsVendaIDVend.AsInteger     := auxIDVend;
         cdsVendaIDPres.AsInteger     := auxIDPres;
         cdsVendaNroReg.AsString      := auxNroReg;
         cdsVendaUFReg.AsString       := auxUFReg;
         cdsVendaQtdven.AsFloat       := cdsLoteQtdVenda.AsFloat;
         cdsVendaIndConf.AsString     := auxIndConf;
         cdsVendaConReg.AsString      := auxConReg;
         cdsVendaIDInvIni.AsInteger   := auxIDInvIni;
         cdsVendaTransmitida.AsString := auxTransmitida;
         cdsVendaDespro.AsString      := auxDespro;
         cdsVendaRegistoMS.AsString   := auxRegistoMS;
         cdsVendaNomfab.AsString      := auxNomfab;
         cdsVendaNomcom.AsString      := auxNomcom;
         cdsVendaNompre.AsString      := auxNompre;
         cdsVendaNomven.AsString      := auxNomven;
         cdsVendaNroNot.AsInteger     := auxNroNot;
         cdsVendaEndereco.AsString    := auxEndereco;
         cdsVendaNumero.AsString      := auxNumero;
         cdsVendaBairro.AsString      := auxBairro;
         cdsVendaCidade.AsString      := auxCidade;
         cdsVendaUF.AsString          := auxUF;
         cdsVendaCep.AsString         := auxCep;
         cdsVendaTipoDoc.AsString     := auxTipoDocComp;
         cdsVendaNumDoc.AsString      := auxNumDocComp;
         cdsVendaOrgExp.AsString      := auxOrgExpComp;
         cdsVendaUFEmis.AsString      := auxUFEmisComp;
         cdsVendaUsoProlong.AsString  := auxUsoProlong;
         cdsVendaUsoMed.AsString      := auxUsoMed;
         cdsVendaIDPac.AsInteger      := auxIDPac;
         cdsVendaNomPac.AsString      := auxNomPac;
         cdsVendaClasTera.AsString    := auxClasTera;
         cdsVendaSexo.AsString        := auxSexo;
         cdsVendaIdade.AsInteger      := auxIdade;
         cdsVendaUniIdadePac.AsString := auxUniIdadePac;
         cdsVenda.Post;
         cdsvenda.Append;
         cdsLote.Next;
      end;
      cdsVenda.Cancel;
      cdsLote.Filtered := False;
      Result := True;
      cdsCloneVenda.EmptyDataSet;
      cdsCloneVenda.Data := cdsVenda.Data;
      cdsCloneLote.EmptyDataSet;
      cdsCloneLote.Data  := cdsLote.Data;
      Exit;
   end;// if

   // Faz a inclusão do produto na venda do SNGPC //
   cdsLote.Filtered := False;
   cdsLote.Filter   := 'QtdVenda > 0';
   cdsLote.Filtered := True;
   cdsLote.First;
   while not cdsLote.Eof do
   begin
      cdsVendaIDFilial.AsInteger   := recIDFilial;
      cdsVendaIDProd.AsInteger     := auxIDProd;
      cdsVendaNrolot.AsString      := cdsLoteNroLot.AsString;
      cdsVendaIDPess.AsInteger     := auxIDPess;
      cdsVendaIDPed.AsInteger      := auxIDPed;
      cdsVendaDatVenda.AsDateTime  := auxDatVenda;
      cdsVendaDatpre.AsDateTime    := auxDatpre;
      cdsVendaDatven.AsDateTime    := cdsLoteDatVen.AsDateTime;
      cdsVendaNroRece.AsString     := auxNroRece;
      cdsVendaIDComp.AsInteger     := auxIDComp;
      cdsVendaIDVend.AsInteger     := auxIDVend;
      cdsVendaIDPres.AsInteger     := auxIDPres;
      cdsVendaNroReg.AsString      := auxNroReg;
      cdsVendaUFReg.AsString       := auxUFReg;
      cdsVendaQtdven.AsFloat       := cdsLoteQtdVenda.AsFloat;
      cdsVendaIndConf.AsString     := auxIndConf;
      cdsVendaConReg.AsString      := auxConReg;
      cdsVendaIDInvIni.AsInteger   := recIDInvIni;
      cdsVendaTransmitida.AsString := auxTransmitida;
      cdsVendaDespro.AsString      := auxDespro;
      cdsVendaRegistoMS.AsString   := auxRegistoMS;
      cdsVendaNomfab.AsString      := auxNomfab;
      cdsVendaNomcom.AsString      := auxNomcom;
      cdsVendaNompre.AsString      := auxNompre;
      cdsVendaNomven.AsString      := auxNomven;
      cdsVendaNroNot.AsInteger     := auxNroNot;
      cdsVendaEndereco.AsString    := auxEndereco;
      cdsVendaNumero.AsString      := auxNumero;
      cdsVendaBairro.AsString      := auxBairro;
      cdsVendaCidade.AsString      := auxCidade;
      cdsVendaUF.AsString          := auxUF;
      cdsVendaCep.AsString         := auxCep;
      cdsVendaTipoDoc.AsString     := auxTipoDocComp;
      cdsVendaNumDoc.AsString      := auxNumDocComp;
      cdsVendaOrgExp.AsString      := auxOrgExpComp;
      cdsVendaUFEmis.AsString      := auxUFEmisComp;
      cdsVendaUsoProlong.AsString  := auxUsoProlong;
      cdsVendaIDPac.AsInteger      := auxIDPac;
      cdsVendaNomPac.AsString      := auxNomPac;
      cdsVendaClasTera.AsString    := auxClasTera;
      cdsVendaUsoMed.AsString      := auxUsoMed;
      cdsVendaSexo.AsString        := auxSexo;
      cdsVendaIdade.AsInteger      := auxIdade;
      cdsVendaUniIdadePac.AsString := auxUniIdadePac;
      cdsVenda.Post;
      cdsVenda.Append;
      cdsLote.Next;
   end;// while
   cdsVenda.Cancel;
   cdsLote.Filtered := False;
   Result := True;
end;

procedure TFrmVendasInc.AjustBotoes(Acao: Boolean);
begin
   edDataVenda.Enabled     := Acao;
   edDataPresc.Enabled     := Acao;
   edDesPro.Enabled        := Acao;
   PanelConf.Enabled       := Acao;
   edNumVenda.Enabled      := Acao;
   edNumRec.Enabled        := Acao;
   PanelUsoProlong.Enabled := Acao;
   edNroNota.Enabled       := Acao;
   edPrescritor.Enabled    := Acao;
   edNumReg.Enabled        := Acao;
   edComp.Enabled          := Acao;
   edEndComp.Enabled       := Acao;
   edBairroComp.Enabled    := Acao;
   edCidComp.Enabled       := Acao;
   edCepComp.Enabled       := Acao;
   ComboTipDocComp.Enabled := Acao;
   edNumDocComp.Enabled    := Acao;
   edOrgExpComp.Enabled    := Acao;
   ComboUFEmiComp.Enabled  := Acao;
   edVend.Enabled          := Acao;
   ComboSexo.Enabled       := Acao;
   ComboUnidIdade.Enabled  := Acao;
   edIdade.Enabled         := Acao;
   ComboUFComp.Enabled     := Acao;
   edNumComp.Enabled       := Acao;

   btIncPro.Enabled        := not(Acao);
   btAltPro.Enabled        := not(Acao);
   btExcPro.Enabled        := not(Acao);
   btSalPro.Enabled        := Acao;
   btCanPro.Enabled        := Acao;
   if Acao then
   begin
      edDataVenda.Color     := clWhite;
      edDataPresc.Color     := clWhite;
      edDesPro.Color        := clWhite;
      PanelConf.Color       := clWhite;
      edNumVenda.Color      := clWhite;
      edNumRec.Color        := clWhite;
      PanelUsoProlong.Color := clWhite;
      edNroNota.Color       := clWhite;
      edPrescritor.Color    := clWhite;
      edNumReg.Color        := clWhite;
      edComp.Color          := clWhite;
      edEndComp.Color       := clWhite;
      edBairroComp.Color    := clWhite;
      edCidComp.Color       := clWhite;
      edCepComp.Color       := clWhite;
      ComboTipDocComp.Color := clWhite;
      edNumDocComp.Color    := clWhite;
      edOrgExpComp.Color    := clWhite;
      ComboUFEmiComp.Color  := clWhite;
      edVend.Color          := clWhite;
      ComboSexo.Color       := clWhite;
      ComboUnidIdade.Color  := clWhite;
      edIdade.Color         := clWhite;
      ComboUFComp.Color     := clWhite;
      edNumComp.Color       := clWhite;
   end else
   begin
      edDataVenda.Color     := $00EFEFEF;
      edDataPresc.Color     := $00EFEFEF;
      edDesPro.Color        := $00EFEFEF;
      PanelConf.Color       := $00EFEFEF;
      edNumVenda.Color      := $00EFEFEF;
      edNumRec.Color        := $00EFEFEF;
      PanelUsoProlong.Color := $00EFEFEF;
      edNroNota.Color       := $00EFEFEF;
      edPrescritor.Color    := $00EFEFEF;
      edNumReg.Color        := $00EFEFEF;
      edComp.Color          := $00EFEFEF;
      edEndComp.Color       := $00EFEFEF;
      edBairroComp.Color    := $00EFEFEF;
      edCidComp.Color       := $00EFEFEF;
      edCepComp.Color       := $00EFEFEF;
      ComboTipDocComp.Color := $00EFEFEF;
      edNumDocComp.Color    := $00EFEFEF;
      edOrgExpComp.Color    := $00EFEFEF;
      ComboUFEmiComp.Color  := $00EFEFEF;
      edVend.Color          := $00EFEFEF;
      ComboSexo.Color       := $00EFEFEF;
      ComboUnidIdade.Color  := $00EFEFEF;
      edIdade.Color         := $00EFEFEF;
      ComboUFComp.Color     := $00EFEFEF;
      edNumComp.Color       := $00EFEFEF;
   end;// if
end;

procedure TFrmVendasInc.AlteraQtdLoteSngpc(Sender: TObject);
var
  lPoint: TPoint;
  lNrolot: String;
  lQtdest, lQtdSel: Currency;
  I:Integer;
begin
   inherited;
   lNrolot:= TDBGrid(Sender).DataSource.DataSet.FieldByName('NroLot').AsString;
   lQtdest:= TDBGrid(Sender).DataSource.DataSet.FieldByName('QtdLote').AsFloat+TDBGrid(Sender).DataSource.DataSet.FieldByName('QtdVenda').AsFloat;
   lQtdSel:= TDBGrid(Sender).DataSource.DataSet.FieldByName('QtdVenda').AsFloat;

   if TDBGrid(Sender).DataSource.DataSet.FieldByName('Datven').AsDateTime < Date then
   begin
    ShowMessage('Atenção: Lote SNGPC ' +lNrolot+ ' Vencido em ' +
    FormatDateTime('dd/mm/yyyy', TDBGrid(Sender).DataSource.DataSet.FieldByName('DatVen').AsDateTime) + '!');
    Exit;
   end;

   var FrmQtdEstLote := TFrmQtdEstLote.Create(Application);
   try
      lPoint := Self.DBGrid2.ClientToScreen(Point(0,0));
      FrmQtdEstLote.Left   := lPoint.X;
      FrmQtdEstLote.Top    := (lPoint.Y - FrmQtdEstLote.Height) + 80;
      FrmQtdEstLote.recNroLote    := lNrolot;
      FrmQtdEstLote.recQtdLoteDisp:= lQtdest;
      FrmQtdEstLote.recQtdSel     := lQtdSel;
      FrmQtdEstLote.ShowModal;

      if FrmQtdEstLote.recQtdSel >= 0 then
      begin
         TDBGrid(Sender).DataSource.DataSet.Edit;
         TDBGrid(Sender).DataSource.DataSet.FieldByName('QtdVenda').AsFloat := FrmQtdEstLote.recQtdSel;
         TDBGrid(Sender).DataSource.DataSet.FieldByName('QtdLote').AsFloat  := lQtdest - FrmQtdEstLote.recQtdSel;
         TDBGrid(Sender).DataSource.DataSet.Post;

         ///Se for alterar e incluir um novo lote no produto.
         if (recOrigem = 'ALTERAR') and (recinclProd = 1) then
         begin
            if FrmQtdEstLote.recQtdSel > 0 then
            begin
               SetLength(auxFiltro, Length(auxFiltro)+1);
               auxFiltro[Length(auxFiltro)-1] := TDBGrid(Sender).DataSource.DataSet.FieldByName('NroLot').AsString;
            end;// if
            if FrmQtdEstLote.recQtdSel = 0 then
            begin
               for I := Low(auxFiltro) to High(auxFiltro) do
               begin
                  if auxFiltro[I] = TDBGrid(Sender).DataSource.DataSet.FieldByName('NroLot').AsString then
                     auxFiltro[I] := '';
               end;// for
            end;// if
         end;
      end;
   finally
      FrmQtdEstLote.Free;
   end;
end;

procedure TFrmVendasInc.CarregDadosAlter(recIDProd:Integer);
var
   auxIDFilial,auxIDProd,auxIDPess,auxIDPed,auxIDComp,auxIDVend,auxIDPres,auxIDInvIni,auxNroNot,auxIdade,auxIDPac:Integer;
   auxNroRece,auxNroReg,auxUFReg,auxIndConf,auxConReg,auxTransmitida,auxDespro,auxRegistoMS:String;
   auxNomfab,auxNomcom,auxNompre,auxNomven,auxEndereco,auxNumero,auxBairro,auxCidade,auxNomPac,auxSexo:String;
   auxUF,auxCep,auxTipoDocComp,auxNumDocComp,auxOrgExpComp,auxUFEmisComp,auxUsoProlong,auxUsoMed,auxClasTera,auxUniIdadePac:String;
   auxDatVenda,auxDatpre:TDatetime;
begin
   auxIDFilial    := cdsVendaIDFilial.AsInteger;
   auxIDProd      := cdsVendaIDProd.AsInteger;
   auxIDPess      := cdsVendaIDPess.AsInteger;
   auxIDPed       := cdsVendaIDPed.AsInteger;
   auxDatVenda    := cdsVendaDatVenda.AsDateTime;
   auxDatpre      := cdsVendaDatpre.AsDateTime;
   auxNroRece     := cdsVendaNroRece.AsString;
   auxIDComp      := cdsVendaIDComp.AsInteger;
   auxIDVend      := cdsVendaIDVend.AsInteger;
   auxIDPres      := cdsVendaIDPres.AsInteger;
   auxNroReg      := cdsVendaNroReg.AsString;
   auxUFReg       := cdsVendaUFReg.AsString;
   auxIndConf     := cdsVendaIndConf.AsString;
   auxConReg      := cdsVendaConReg.AsString;
   auxIDInvIni    := cdsVendaIDInvIni.AsInteger;
   auxTransmitida := cdsVendaTransmitida.AsString;
   auxDespro      := cdsVendaDespro.AsString;
   auxRegistoMS   := cdsVendaRegistoMS.AsString;
   auxNomfab      := cdsVendaNomfab.AsString;
   auxNomcom      := cdsVendaNomcom.AsString;
   auxNompre      := cdsVendaNompre.AsString;
   auxNomven      := cdsVendaNomven.AsString;
   auxNroNot      := cdsVendaNroNot.AsInteger;
   auxEndereco    := cdsVendaEndereco.AsString;
   auxNumero      := cdsVendaNumero.AsString;
   auxBairro      := cdsVendaBairro.AsString;
   auxCidade      := cdsVendaCidade.AsString;
   auxUF          := cdsVendaUF.AsString;
   auxCep         := cdsVendaCep.AsString;
   auxTipoDocComp := cdsVendaTipoDoc.AsString;
   auxNumDocComp  := cdsVendaNumDoc.AsString;
   auxOrgExpComp  := cdsVendaOrgExp.AsString;
   auxUFEmisComp  := cdsVendaUFEmis.AsString;
   auxUsoProlong  := cdsVendaUsoProlong.AsString;
   auxUsoMed      := cdsVendaUsoMed.AsString;
   auxIDPac       := cdsVendaIDPac.AsInteger;
   auxNomPac      := cdsVendaNomPac.AsString;
   auxClasTera    := cdsVendaClasTera.AsString;
   auxSexo        := cdsVendaSexo.AsString;
   auxIdade       := cdsVendaIdade.AsInteger;
   auxUniIdadePac := cdsVendaUniIdadePac.AsString;
   cdsVenda.Append;
   cdsVendaIDFilial.AsInteger   := auxIDFilial;
   cdsVendaIDProd.AsInteger     := auxIDProd;
   cdsVendaNrolot.AsString      := '';
   cdsVendaIDPess.AsInteger     := auxIDPess;
   cdsVendaIDPed.AsInteger      := auxIDPed;
   cdsVendaDatVenda.AsDateTime  := auxDatVenda;
   cdsVendaDatpre.AsDateTime    := auxDatpre;
   cdsVendaDatven.AsDateTime    := 0;
   cdsVendaNroRece.AsString     := auxNroRece;
   cdsVendaIDComp.AsInteger     := auxIDComp;
   cdsVendaIDVend.AsInteger     := auxIDVend;
   cdsVendaIDPres.AsInteger     := auxIDPres;
   cdsVendaNroReg.AsString      := auxNroReg;
   cdsVendaUFReg.AsString       := auxUFReg;
   cdsVendaQtdven.AsFloat       := 0;
   cdsVendaIndConf.AsString     := auxIndConf;
   cdsVendaConReg.AsString      := auxConReg;
   cdsVendaIDInvIni.AsInteger   := auxIDInvIni;
   cdsVendaTransmitida.AsString := auxTransmitida;
   cdsVendaDespro.AsString      := auxDespro;
   cdsVendaRegistoMS.AsString   := auxRegistoMS;
   cdsVendaNomfab.AsString      := auxNomfab;
   cdsVendaNomcom.AsString      := auxNomcom;
   cdsVendaNompre.AsString      := auxNompre;
   cdsVendaNomven.AsString      := auxNomven;
   cdsVendaNroNot.AsInteger     := auxNroNot;
   cdsVendaEndereco.AsString    := auxEndereco;
   cdsVendaNumero.AsString      := auxNumero;
   cdsVendaBairro.AsString      := auxBairro;
   cdsVendaCidade.AsString      := auxCidade;
   cdsVendaUF.AsString          := auxUF;
   cdsVendaCep.AsString         := auxCep;
   cdsVendaTipoDoc.AsString     := auxTipoDocComp;
   cdsVendaNumDoc.AsString      := auxNumDocComp;
   cdsVendaOrgExp.AsString      := auxOrgExpComp;
   cdsVendaUFEmis.AsString      := auxUFEmisComp;
   cdsVendaUsoProlong.AsString  := auxUsoProlong;
   cdsVendaUsoMed.AsString      := auxUsoMed;
   cdsVendaIDPac.AsInteger      := auxIDPac;
   cdsVendaNomPac.AsString      := auxNomPac;
   cdsVendaClasTera.AsString    := auxClasTera;
   cdsVendaSexo.AsString        := auxSexo;
   cdsVendaIdade.AsInteger      := auxIdade;
   cdsVendaUniIdadePac.AsString := auxUniIdadePac;
end;

function TFrmVendasInc.Filtrolotes: String;
var
   i:Integer;
   auxFiltro:String;
begin
   Result := '';
   cdsLote.Filtered := False;
   cdsLote.Filter   := 'IDProd = '+cdsVendaIDProd.AsString+' AND QtdVenda > 0';
   cdsLote.Filtered := True;
   cdsLote.First;
   while not cdslote.Eof do
   begin
      Result := Result + ' AND NroLot <> '+ cdsLoteNroLot.AsString;
      cdslote.Next;
   end;// while
   cdsLote.Filtered := False;
end;

procedure TFrmVendasInc.btIncProClick(Sender: TObject);
var
   auxIDProd:Integer;
   auxFiltroLote:String;
begin
   if recOrigem = 'INCLUIR'  then
   begin
      AjustBotoes(True);
      ComboUsoMed.ItemIndex     := -1;
      ComboSexo.ItemIndex       := -1;
      ComboUFComp.ItemIndex     := -1;
      ComboTipDocComp.ItemIndex := -1;
      ComboUFEmiComp.ItemIndex  := -1;
      cdsLote.EmptyDataSet;
      edDataVenda.SetFocus;
      cdsVenda.Append;
      cdsVendaTransmitida.AsString := '0';
      cdsVendaIndConf.AsString     := '0';
   end;
   if recOrigem = 'ALTERAR'  then
   begin
      auxIDProd := cdsVendaIDProd.AsInteger;
      CarregDadosAlter(auxIDProd);
      btIncPro.Enabled       := False;
      btAltPro.Enabled       := False;
      btExcPro.Enabled       := False;
      btSalPro.Enabled       := True;
      btCanPro.Enabled       := True;
      auxFiltroLote := Filtrolotes;
      cdsLote.Filtered := False;
      cdsLote.Filter   := 'IDProd = '+auxIDProd.ToString+auxFiltroLote;
      cdsLote.Filtered := True;
   end;
   DBGrid2.Visible := True;
   recinclProd     := 1;
   btProdutos.Enabled     := False;
   btConfirma.Enabled     := False;
   PanelCabecalho.Enabled := False;
end;

procedure TFrmVendasInc.btProdutosClick(Sender: TObject);
var
   auxIDProd:Integer;
begin
   try
      Application.CreateForm(TFrmProdCad, FrmProdCad);
      if cdsVendaIDProd.AsInteger > 0 then
      begin
         FrmProdCad.recIDProd := cdsVendaIDProd.AsInteger;
         FrmProdCad.recDespro := cdsVendaDespro.AsString;
      end else
      begin
         FrmProdCad.recIDProd := 0;
         FrmProdCad.recDespro := '';
      end;// if
      FrmProdCad.recOrigem := 'REC';
      CentralizarControl(FrmProdCad, FrmVendasInc);
      Self.AlphaBlendValue := 155;
      FrmProdCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxIDProd := FrmProdCad.recIDProd;
      FrmProdCad   := nil;
   end; // try
end;

procedure TFrmVendasInc.btSalProClick(Sender: TObject);
begin
   btSalPro.SetFocus;
   if GravaProduto then
   begin
      AjustBotoes(False);
      edEndComp.Visible       := True;
      edNumComp.Visible       := True;
      edBairroComp.Visible    := True;
      edCidComp.Visible       := True;
      edCepComp.Visible       := True;
      ComboTipDocComp.Visible := True;
      edNumDocComp.Visible    := True;
      edOrgExpComp.Visible    := True;
      ComboUFEmiComp.Visible  := True;
      ComboSexo.Visible       := True;
      ComboUnidIdade.Visible  := True;
      edIdade.Visible         := True;
      ComboUFComp.Visible     := True;
      DBGrid2.Visible := False;
      btProdutos.Enabled     := True;
      btConfirma.Enabled     := True;
      PanelCabecalho.Enabled := True;
      cdsLote.Filtered := False;
      DBGrid1.Enabled  := True;
      DBGrid1.SetFocus;
   end;// if
end;

procedure TFrmVendasInc.btAltProClick(Sender: TObject);
begin
   if cdsVenda.IsEmpty then Exit;
   AjustBotoes(True);
   btProdutos.Enabled     := False;
   btConfirma.Enabled     := False;
   PanelCabecalho.Enabled := False;
   DBGrid2.Visible := True;
   DBGrid1.Enabled := False;
   recinclProd     := 2;
   cdsLote.Filtered := False;
   cdsLote.Filter   := 'NroLot = '+cdsVendaNrolot.AsString;
   cdsLote.Filtered := True;
   cdsVenda.Edit;
end;

procedure TFrmVendasInc.btCanProClick(Sender: TObject);
begin
   AjustBotoes(False);
   btProdutos.Enabled      := True;
   btConfirma.Enabled      := True;
   PanelCabecalho.Enabled  := True;
   DBGrid2.Visible         := False;
   edComp.Visible          := True;
   ComboSexo.Visible       := True;
   ComboUnidIdade.Visible  := True;
   edIdade.Visible         := True;
   edEndComp.Visible       := True;
   edNumComp.Visible       := True;
   edBairroComp.Visible    := True;
   edCepComp.Visible       := True;
   edCidComp.Visible       := True;
   ComboUFComp.Visible     := True;
   ComboTipDocComp.Visible := True;
   edNumDocComp.Visible    := True;
   edOrgExpComp.Visible    := True;
   ComboUFEmiComp.Visible  := True;
   cdsVenda.Cancel;
   if recOrigem = 'ALTERAR' then
   begin
      cdsLote.Filtered := False;
      cdsvenda.EmptyDataSet;
      cdsLote.EmptyDataSet;
      cdsVenda.Data := cdsCloneVenda.Data;
      cdsLote.Data  := cdsCloneLote.Data;
      AjustaGrid;
      if cdsVendaClasTera.AsString = '1' then
           ConfiTela(1)
      else ConfiTela(2);
      recinclProd := 0;
   end;
   DBGrid1.Enabled := True;
   DBGrid1.SetFocus;
end;

procedure TFrmVendasInc.btConfirmaClick(Sender: TObject);
var
   QueGrava,QueAuxi:TRESTDWClientSQL;
   vErro,auxGrava:String;
   auxIDVenda,auxIDProd,auxGravaCompPac:Integer;
begin
   QueGrava          := TRESTDWClientSQL.Create(nil);
   QueAuxi           := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;
   QueAuxi.DataBase  := DM.DWDataBase;
   ShowWait('Aguarde...', Self);
   try
      if recOrigem = 'INCLUIR' then
      begin
         vErro := '';
         auxIDVenda := NextSequenceID('arqsngpcven_sequence',vErro);
      end;

      if recOrigem = 'ALTERAR' then
      begin
         DelProd;
         auxIDVenda := recIDVenda;
      end;

      auxIDProd  := 0;
      cdsVenda.First;
      while not cdsVenda.Eof do
      begin
         try
            QueGrava.Close;
            QueGrava.SQL.Text := 'INSERT INTO arqsngpcven (IDFilial,IDProd,Nrolot,IDPess,IDPed,DatVenda,Datpre,Datven,NroRece,IDComp,'+
            'IDVend,IDPres,Qtdven,IndConf,IDInvIni,Transmitida,UsoProlong,UsoMed,NroNot,IDPac,IDVenda) VALUES ('+
            cdsVendaIDFilial.AsString+','+
            cdsVendaIDProd.AsString+','+
            Aspas(cdsVendaNrolot.AsString)+','+
            cdsVendaIDPess.AsString+','+
            cdsVendaIDPed.AsString+','+
            Aspas(FormatDateTime('yyyy-mm-dd',cdsVendaDatVenda.AsDateTime))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',cdsVendaDatpre.AsDateTime))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',cdsVendaDatven.AsDateTime))+','+
            Aspas(cdsVendaNroRece.AsString)+','+
            cdsVendaIDComp.AsString+','+
            cdsVendaIDVend.AsString+','+
            cdsVendaIDPres.AsString+','+
            FormatDouble(cdsVendaQtdven.AsFloat,11,2)+','+
            Aspas(cdsVendaIndConf.AsString)+','+
            cdsVendaIDInvIni.AsString+','+
            Aspas(cdsVendaTransmitida.AsString)+','+
            Aspas(cdsVendaUsoProlong.AsString)+','+
            Aspas(cdsVendaUsoMed.AsString)+','+
            cdsVendaNroNot.AsString+','+
            cdsVendaIDPac.AsString+','+
            auxIDVenda.ToString+')';
            QueGrava.ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpcven em uVendasInc -> '+E.Message);
               MostraMsg('Erro','Não foi possível incluir o produto.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try

         if auxIDProd <> cdsVendaIDProd.AsInteger then // grava apenas uma vez o comprador ou o paciente por produto.
         begin
            auxIDProd := cdsVendaIDProd.AsInteger;
            // Classe terapêutica ANTIMICROBIANO
            if cdsVendaClasTera.AsString = '1' then
            begin
               if cdsVendaUsoMed.AsString = '1' then // uso humano
               begin
                  try
                     QueGrava.Close;
                     QueGrava.SQL.Text := 'INSERT INTO arqsngpcvenpac (IDVenda,IDPac,SexoPac,UniIdadePac,IdadePac) VALUES ('+
                     auxIDVenda.ToString+','+
                     cdsVendaIDPac.AsString+','+
                     Aspas(cdsVendaSexo.AsString)+','+
                     Aspas(cdsVendaUniIdadePac.AsString)+','+
                     cdsVendaIdade.AsString+')';
                     QueGrava.ExecSQL(vErro);
                     if vErro <> '' then Raise Exception.Create(vErro);
                  except
                     on E:Exception do
                     begin
                        SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpcvenpac em uVendasInc -> '+E.Message);
                        MostraMsg('Erro','Não foi possível incluir o paciente.'+#10+E.Message, mtWarning, [mbOk]);
                        Exit;
                     end;
                  end;// try
               end;// if
            end else
            begin
               try
                  QueGrava.Close;
                  QueGrava.SQL.Text := 'INSERT INTO arqsngpcvencom (IDVenda,IDComp,Endcomp,NroEndComp,ComEndComp,BaiComp,CepComp,'+
                  'DesMunComp,EstComp,TipDocComp,NumDocComp,OrgExpComp,EstEmiComp) VALUES ('+
                  auxIDVenda.ToString+','+
                  cdsVendaIDComp.AsString+','+
                  Aspas(cdsVendaEndereco.AsString)+','+
                  Aspas(cdsVendaNumero.AsString)+','+
                  Aspas('')+','+
                  Aspas(cdsVendaBairro.AsString)+','+
                  Aspas(cdsVendaCep.AsString)+','+
                  Aspas(cdsVendaCidade.AsString)+','+
                  Aspas(cdsVendaUF.AsString)+','+
                  Aspas(cdsVendaTipoDoc.AsString)+','+
                  Aspas(cdsVendaNumDoc.AsString)+','+
                  Aspas(cdsVendaOrgExp.AsString)+','+
                  Aspas(cdsVendaUFEmis.AsString)+')';
                  QueGrava.ExecSQL(vErro);
                  if vErro <> '' then Raise Exception.Create(vErro);
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpcvencom em uVendasInc -> '+E.Message);
                     MostraMsg('Erro','Não foi possível incluir o comprador.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end;// try
            end; // if
         end; // if
         cdsVenda.Next;
      end;// while
   finally
      QueGrava.Close;
      QueAuxi.Close;
      FreeAndNil(QueGrava);
      FreeAndNil(QueAuxi);
      HideWait;
   end;// try
   Close;
end;

procedure TFrmVendasInc.btExcProClick(Sender: TObject);
begin
   if cdsVenda.IsEmpty then
   begin
      MostraMsg('Exclusão de produto','Nenhum produto selecionado para excluir!',mtWarning, [mbOk]);
      btExcPro.SetFocus;
      Exit;
   end;// if
   recinclProd := 3;
   if MostraMsg('Confirmação','Deseja excluir este produto '+cdsVendaDespro.AsString+' da nota fiscal?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   cdsVenda.Delete;
end;

procedure TFrmVendasInc.edPrescritorCustomButtons0Click(Sender: TObject; index: Integer);
var
   auxRecIDPess:Integer;
begin
   Self.AlphaBlendValue := 165;
   Application.CreateForm(TFrmPesCad, FrmPesCad);
   try
      if cdsVendaIDPres.AsInteger > 0 then
           FrmPesCad.recIDPess := cdsVendaIDPres.AsInteger
      else FrmPesCad.recIDPess := 0;
      FrmPesCad.recEsppes := 10;
      CentralizarControl(FrmPesCad, FrmVendasInc);
      FrmPesCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxRecIDPess := FrmPesCad.recIDPess;
      FrmPesCad := nil;
   end;// try
end;

procedure TFrmVendasInc.edPrescritorCustomButtons1Click(Sender: TObject; index: Integer);
begin
   edPrescritor.SetFocus;
   btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edPrescritor),'IDPres','IDPess','Nompes','Nompre','(IDEsppes = 4 or IDEsppes = 10)',0);
   BuscaInfPresc;
end;

procedure TFrmVendasInc.edPrescritorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edPrescritor),'IDPres','IDPess','Nompes','Nompre','(IDEsppes = 4 or IDEsppes = 10)',Key);
   BuscaInfPresc;
end;

procedure TFrmVendasInc.edNumRegCustomButtons0Click(Sender: TObject; index: Integer);
begin
   edNumReg.SetFocus;
   btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edNumReg),'IDPres','IDPess','NroRegProf','NroReg','(IDEsppes = 4)',0);
   BuscaInfPresc;
end;

procedure TFrmVendasInc.edNumRegKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edNumReg),'IDPres','IDPess','NroRegProf','NroReg','(IDEsppes = 4)',Key);
   BuscaInfPresc;
end;

procedure TFrmVendasInc.edVendCustomButtons0Click(Sender: TObject; index: Integer);
begin
   edVend.SetFocus;
   btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edVend),'IDVend','IDPess','Nompes','Nomven','(IDEsppes = 9)',0);
end;

procedure TFrmVendasInc.edVendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edVend),'IDVend','IDPess','Nompes','Nomven','(IDEsppes = 9)',Key);
end;

procedure TFrmVendasInc.edCompCustomButtons0Click(Sender: TObject; index: Integer);
var
   auxRecIDPess:Integer;
begin
   Self.AlphaBlendValue := 165;
   Application.CreateForm(TFrmPesCad, FrmPesCad);

   try
      if cdsVendaClasTera.AsString = '2' then
      begin
         if cdsVendaIDComp.AsInteger > 0 then
              FrmPesCad.recIDPess := cdsVendaIDComp.AsInteger
         else FrmPesCad.recIDPess := 0;
      end else
      begin
         if cdsVendaIDPac.AsInteger > 0 then
              FrmPesCad.recIDPess := cdsVendaIDPac.AsInteger
         else FrmPesCad.recIDPess := 0;
      end;
      CentralizarControl(FrmPesCad, FrmVendasInc);
      FrmPesCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxRecIDPess := FrmPesCad.recIDPess;
      FrmPesCad := nil;
   end;// try
end;

procedure TFrmVendasInc.edCompCustomButtons1Click(Sender: TObject; index: Integer);
begin
   edComp.SetFocus;
   if cdsVendaClasTera.AsString = '2' then
   begin
      btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edComp),'IDComp','IDPess','Nompes','Nomcom','(IDEsppes = 1)',0);
      BuscaInfComp;
   end  else
   begin
      btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edComp),'IDPac','IDPess','Nompes','NomPac','(IDEsppes = 1)',0);
      BuscaInfPac;
   end;
end;

procedure TFrmVendasInc.edCompKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if cdsVendaClasTera.AsString = '2' then
   begin
      if key <> VK_RETURN then
         btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edComp),'IDComp','IDPess','Nompes','Nomcom','(IDEsppes = 1)',Key);
      BuscaInfComp;
   end  else
   begin
      if key <> VK_RETURN then
         btBuscasCDS(cdsVenda,'arqpessoa',TDBEdit(edComp),'IDPac','IDPess','Nompes','NomPac','(IDEsppes = 1)',Key);
      BuscaInfPac;
   end;
end;

procedure TFrmVendasInc.BuscaInfPac;
var
   QueAuxi: TRESTDWClientSQL;
begin
   if edComp.Text = '' then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT CpfCnpjPes,SexoPes FROM arqpessoa WHERE IDPess = '+ cdsVendaIDPac.AsString;
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         if QueAuxi.FieldByName('SexoPes').AsString = '0' then
            cdsVendaSexo.AsString := '0'
         else
         begin
            cdsVendaSexo.AsString := QueAuxi.FieldByName('SexoPes').AsString;
            if QueAuxi.FieldByName('SexoPes').AsString = '1' then
               ComboSexo.ItemIndex := 0
            else if QueAuxi.FieldByName('SexoPes').AsString = '2' then
               ComboSexo.ItemIndex := 1;
         end;
         cdsVendaIdade.AsInteger   := 0;
      end;// if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmVendasInc.BuscaInfPresc;
var
   QueAuxi: TRESTDWClientSQL;
begin
   if (edPrescritor.Text = '') and (edNumReg.Text = '') then Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT CpfCnpjPes,Nompes,ConRegProf,NroRegProf,EstRegProf FROM arqpessoa WHERE IDPess = '+cdsVendaIDPres.AsString;
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         cdsVendaConReg.AsString := QueAuxi.FieldByName('ConRegProf').AsString;
         cdsVendaNroReg.AsString := QueAuxi.FieldByName('NroRegProf').AsString;
         cdsVendaUFReg.AsString  := QueAuxi.FieldByName('EstRegProf').AsString;
         cdsVendaNompre.AsString := QueAuxi.FieldByName('Nompes').AsString;
         if cdsVendaConReg.AsString = 'CRM'   then ComboUsoMed.ItemIndex := 0;
         if cdsVendaConReg.AsString = 'CRO'   then ComboUsoMed.ItemIndex := 0;
         if cdsVendaConReg.AsString = 'RMS'   then ComboUsoMed.ItemIndex := 0;
         if cdsVendaConReg.AsString = 'COREN' then ComboUsoMed.ItemIndex := 0;
         if cdsVendaConReg.AsString = 'CRF'   then ComboUsoMed.ItemIndex := 0;
         if cdsVendaConReg.AsString = 'CRMV'  then ComboUsoMed.ItemIndex := 1;
      end;// if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmVendasInc.BuscaInfComp;
var
   QueAuxi: TRESTDWClientSQL;
begin
   if edComp.Text = '' then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT PES.CpfCnpjPes, PES.RGEPes, PES.RGEOrg, PES.RGEEst, PES.Endpes, PES.NroEnd, '+
      'PES.CompEnd, PES.Baipes, PES.Ceppes, MUN.Nommun, MUN.Estmun FROM arqpessoa PES '+
      'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
      'WHERE PES.IDPess = '+ cdsVendaIDComp.AsString;
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         cdsVendaEndereco.AsString := QueAuxi.FieldByName('Endpes').AsString;
         cdsVendaNumero.AsString   := QueAuxi.FieldByName('NroEnd').AsString;
         cdsVendaBairro.AsString   := QueAuxi.FieldByName('Baipes').AsString;
         cdsVendaCidade.AsString   := QueAuxi.FieldByName('Nommun').AsString;
         cdsVendaUF.AsString       := QueAuxi.FieldByName('Estmun').AsString;
         ComboUFComp.ItemIndex     := ComboUFComp.Items.IndexOf(QueAuxi.FieldByName('Estmun').AsString);
         cdsVendaCep.AsString      := QueAuxi.FieldByName('Ceppes').AsString;
         if Length(Trim(QueAuxi.FieldByName('CpfCnpjPes').AsString)) = 11 then
         begin
            cdsVendaNumDoc.AsString   := QueAuxi.FieldByName('CpfCnpjPes').AsString;
            cdsVendaTipoDoc.AsString  := '2';
            ComboTipDocComp.ItemIndex := 1;
         end else
         begin
            cdsVendaNumDoc.AsString  := '';
            cdsVendaTipoDoc.AsString := '';
         end;// if
         cdsVendaOrgExp.AsString := '';
         cdsVendaUFEmis.AsString := '';
      end;// if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmVendasInc.BuscaInfPro;
var
   QueAuxi,QueLote: TRESTDWClientSQL;
begin
   if edDespro.Text = '' then Exit;
   cdsLote.EmptyDataSet; // Exclui da tabela temporária os lote do produto.
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueLote := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueLote.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT PRO.IDProd,PRO.Despro,PRO.RegistoMS,PRO.ClasTera,PRO.UsoRece,PRO.CodEANpri,PES.IDPess,PES.Nompes FROM arqproduto PRO '+
      'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess WHERE PRO.IDProd = '+Aspas(IntToStr(edDespro.Tag));
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         cdsVendaIDProd.AsInteger   := QueAuxi.FieldByName('IDProd').AsInteger;
         cdsVendaDespro.AsString    := QueAuxi.FieldByName('Despro').AsString;
         cdsVendaRegistoMS.AsString := QueAuxi.FieldByName('RegistoMS').AsString;
         cdsVendaIDPess.AsInteger   := QueAuxi.FieldByName('IDPess').AsInteger;
         cdsVendaClasTera.AsString  := QueAuxi.FieldByName('ClasTera').AsString;
         cdsVendaUsoRece.AsString   := QueAuxi.FieldByName('UsoRece').AsString;

         QueLote.Close;
         QueLote.SQL.Text := 'SELECT IDProd,Nrolot,Qtdest,Datven FROM arqsngpclot' +
         ' WHERE IDFilial = '+recIDFilial.ToString + ' AND IDInvIni = '+recIDInvIni.ToString+
         ' AND IDProd = '+QueAuxi.FieldByName('IDProd').AsString+' AND Qtdest > 0 ORDER BY Datven ASC';
         QueLote.Open;
         cdsLote.Filtered := False;
         QueLote.First;
         while not QueLote.Eof do
         begin
            cdsLote.Append;
            cdsLoteIDProd.AsInteger  := QueLote.FieldByName('IDProd').AsInteger;
            cdsLoteDatVen.AsDateTime := QueLote.FieldByName('Datven').AsDateTime;
            cdsLoteNroLot.AsString   := QueLote.FieldByName('Nrolot').AsString;
            cdsLoteQtdLote.AsFloat   := QueLote.FieldByName('Qtdest').AsFloat;
            cdsLote.Post;
            QueLote.Next;
         end;// while
      end;// if
   finally
      QueAuxi.Close;
      QueLote.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueLote);
   end;// try
end;

procedure TFrmVendasInc.ComboUsoMedChange(Sender: TObject);
begin
   if cdsVendaClasTera.AsString = '1' then
   begin
      if ComboUsoMed.ItemIndex = 1 then
      begin
         ComboSexo.Visible      := False;
         edIdade.Visible        := False;
         edComp.Visible         := False;
         ComboUnidIdade.Visible := False;

         ComboSexo.ItemIndex      := -1;
         edIdade.Text             := '';
         edComp.Text              := '';
         ComboUnidIdade.ItemIndex := -1;
      end else
      begin
         ComboSexo.Visible      := True;
         edIdade.Visible        := True;
         edComp.Visible         := True;
         ComboUnidIdade.Visible := True;
      end;// if
   end;// if
end;

procedure TFrmVendasInc.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+2, Column.Field.DisplayText);
   end;// if
end;

procedure TFrmVendasInc.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;// if
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+2, Column.Field.DisplayText);
   end;// if
end;

procedure TFrmVendasInc.DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (DBGrid2.DataSource.DataSet.RecNo = DBGrid2.DataSource.DataSet.RecordCount ) then abort;
end;

procedure TFrmVendasInc.DBGrid2KeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then AlteraQtdLoteSngpc(Sender);
end;

procedure TFrmVendasInc.DBGrid2DblClick(Sender: TObject);
begin
   AlteraQtdLoteSngpc(Sender);
end;

procedure TFrmVendasInc.DelProd;
var
   QueAuxi,QueExclui:TRESTDWClientSQL;
begin
   QueAuxi   := TRESTDWClientSQL.Create(nil);
   QueExclui := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase   := DM.DWDataBase;
   QueExclui.DataBase := DM.DWDataBase;
   try
      try
         QueExclui.Close;
         QueExclui.SQL.Text := 'DELETE FROM arqsngpcven WHERE IDVenda = '+TabVenda.FieldByName('IDVenda').AsString;
         QueExclui.ExecSQL;
      except // try
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir o produto de arqsngpcven em uVenda -> '+E.Message);
            MostraMsg('Erro','Não foi possível excluir o produto.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT IDVenda FROM arqsngpcvenpac WHERE IDVenda = '+TabVenda.FieldByName('IDVenda').AsString;
      QueAuxi.Open;
      if QueAuxi.IsEmpty then
      begin
         try
            QueExclui.Close;
            QueExclui.SQL.Text := 'DELETE FROM arqsngpcvencom WHERE IDVenda = '+TabVenda.FieldByName('IDVenda').AsString;
            QueExclui.ExecSQL;
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir comprador de arqsngpcvencom em uVenda -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir o comprador.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
      end else
      begin
         try
            QueExclui.Close;
            QueExclui.SQL.Text := 'DELETE FROM arqsngpcvenpac WHERE IDVenda = '+TabVenda.FieldByName('IDVenda').AsString;
            QueExclui.ExecSQL;
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir o paciente de arqsngpcvenpac em uVenda -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir o paciente.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
      end;
   finally
      QueAuxi.Close;
      QueExclui.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueExclui);
   end;
end;

procedure TFrmVendasInc.MostraCampos;
begin
   if cdsVendaClasTera.AsString = '1' then // ANTIMICROBIANO
   begin
      edEndComp.Visible       := False;
      edNumComp.Visible       := False;
      edBairroComp.Visible    := False;
      edCidComp.Visible       := False;
      edCepComp.Visible       := False;
      ComboTipDocComp.Visible := False;
      edNumDocComp.Visible    := False;
      edOrgExpComp.Visible    := False;
      ComboUFEmiComp.Visible  := False;
      ComboUFComp.Visible     := False;

      edEndComp.Text            := '';
      edNumComp.Text            := '';
      edBairroComp.Text         := '';
      edCidComp.Text            := '';
      edCepComp.Text            := '';
      ComboTipDocComp.ItemIndex := -1;
      edNumDocComp.Text         := '';
      edOrgExpComp.Text         := '';
      ComboUFEmiComp.ItemIndex  := -1;
      ComboUFComp.ItemIndex     := -1;

      ComboSexo.Visible        := True;
      edIdade.Visible          := True;
      edComp.EditLabel.Caption := 'PACIENTE';
      edComp.DataField         := 'NomPac';
      ComboUnidIdade.Visible   := True;
   end// if
   else if cdsVendaClasTera.AsString = '2' then // PSICOTRÓPICO
   begin
      edEndComp.Visible        := True;
      edNumComp.Visible        := True;
      edBairroComp.Visible     := True;
      edCidComp.Visible        := True;
      edCepComp.Visible        := True;
      ComboTipDocComp.Visible  := True;
      edNumDocComp.Visible     := True;
      edOrgExpComp.Visible     := True;
      ComboUFEmiComp.Visible   := True;
      ComboUFComp.Visible      := True;
      ComboSexo.Visible        := False;
      edIdade.Visible          := False;
      edComp.EditLabel.Caption := 'COMPRADOR';
      edComp.DataField         := 'Nomcom';
      ComboUnidIdade.Visible   := False;

      ComboSexo.ItemIndex      := -1;
      edIdade.Text             := '';
      ComboUnidIdade.ItemIndex := -1;
   end;// if
end;

procedure TFrmVendasInc.SouVendaDataChange(Sender: TObject; Field: TField);
begin
   if not (cdsVenda.IsEmpty) then
   begin
      if not (cdsVendaIndConf.AsString = '') then
      begin
         if cdsVendaIndConf.AsString = '0' then
              rbConNao.Checked := True
         else rbConSim.Checked := True;
      end;// if
      if not (cdsVendaUsoProlong.AsString = '') then
      begin
         if cdsVendaUsoProlong.AsString = '0' then
              rbUsoProlNao.Checked := True
         else rbUsoProlSim.Checked := True;
      end; //if
      if not (cdsVendaUsoMed.AsString = '')      then ComboUsoMed.ItemIndex    := cdsVendaUsoMed.AsInteger-1;
      if not (cdsVendaSexo.AsString = '')        then ComboSexo.ItemIndex      := cdsVendaSexo.AsInteger-1;
      if not (cdsVendaUniIdadePac.AsString = '') then ComboUnidIdade.ItemIndex := cdsVendaUniIdadePac.AsInteger-1;
      if not (cdsVendaUF.AsString = '')          then ComboUFComp.ItemIndex    := ComboUFComp.Items.IndexOf(cdsVendaUF.AsString);
      if not (cdsVendaTipoDoc.AsString = '') then
      begin
         if cdsVendaTipoDoc.AsString = '99' then
              ComboTipDocComp.ItemIndex := 8
         else ComboTipDocComp.ItemIndex := cdsVendaTipoDoc.AsInteger-1;
      end;// if
      if not (cdsVendaUFEmis.AsString = '') then
         ComboUFEmiComp.ItemIndex := ComboUFEmiComp.Items.IndexOf(cdsVendaUFEmis.AsString);
      if cdsVendaClasTera.AsString = '1' then // ANTIMICROBIANO
      begin
         edComp.EditLabel.Caption := 'PACIENTE';
         edComp.DataField         := 'NomPac';
         ComboUFComp.ItemIndex    := -1;
         ComboUFEmiComp.ItemIndex := -1;
      end else
      if cdsVendaClasTera.AsString = '2' then // PSICOTRÓPICO
      begin
         edComp.EditLabel.Caption := 'COMPRADOR';
         edComp.DataField         := 'Nomcom';
         ComboSexo.ItemIndex      := -1;
         ComboUnidIdade.ItemIndex := -1;
      end;// if
   end;// if
end;

procedure TFrmVendasInc.edDesProCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      edDesPro.SetFocus;
      FrmBuscaProdPerda  := TFrmBuscaProdPerda.Create(Application);
      lPoint := Self.edDespro.ClientToScreen(Point(0,0));
      FrmBuscaProdPerda.Left   := lPoint.X;
      FrmBuscaProdPerda.Top    := lPoint.Y;
      FrmBuscaProdPerda.Width  := Self.edDespro.Width;
      FrmBuscaProdPerda.edRetorno    := TEdit(Self.edDespro);
      FrmBuscaProdPerda.edBusca.Text := TrataTecNum(Index); // Tecla precionada que esta vindo do edit edNompro (Busca produto)
      FrmBuscaProdPerda.CamposFiltro := 'IDInvIni = '+recIDInvIni.ToString;
      FrmBuscaProdPerda.ShowModal;
   finally
      edDespro.Text := FrmBuscaProdPerda.auxDespro;
      edDespro.Tag  := FrmBuscaProdPerda.edRetorno.Tag;
      FrmBuscaProdPerda.Free;
   end;// try
   BuscaInfPro;
   MostraCampos;
end;

procedure TFrmVendasInc.edDesProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if not(ssCtrl in Shift) then
   begin
      if (Key = VK_RETURN) or (Key = VK_TAB) then
      begin
         if (Key = VK_RETURN) and (Trim(edDespro.Text) = EmptyStr) then
         begin
            edDespro.Text := '';
            edDespro.Tag  := 0;
            Key:= 0;
            Exit;
         end; //if

         if Trim(edDespro.Text) = '' then Exit;
         soInteger := iif(ExisteStr(edDespro.Text.Trim), '', OnlyNumbers(edDespro.Text));
         if soInteger = '' then
         begin
            key := 0;
            edDesproCustomButtons0Click(Self, Key);
         end; //if
      end //if
      else if Key = VK_ESCAPE then
      begin
         edDespro.Text := '';
         edDespro.Tag  := 0;
      end else
      begin
         edDesproCustomButtons0Click(Self, key);
         key := 0;
      end; //if
   end; //if
end;

procedure TFrmVendasInc.btFecharClick(Sender: TObject);
begin
   if recInclProd > 0 then
   begin
      if MostraMsg('Confirmação','Deseja salvar as alterações feitas antes de sair?', mtConfirmation, [mbYes,mbNo]) = mrNo then
      begin
         close;
         Exit;
      end;
      btConfirma.Click;
   end;
   Close;
end;

procedure TFrmVendasInc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if recOrigem = 'ALTERAR' then
   begin
      cdsCloneVenda.Close;
      cdsCloneLote.Close;
   end;
   cdsVenda.Close;
   cdsLote.Close;
   Action := caFree;
end;

end.
