unit uPessCred;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxDBCtrl, LMDBaseEdit,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel, Vcl.ExtCtrls,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDSimplePanel, Vcl.DBCtrls, FireDAC.DatS, LMDCustomEdit, LMDDBEdit,
   LMDBaseControl, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   uRESTDWBasicDB, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, LMDEdit,
   LMDButtonControl, LMDCustomCheckBox, LMDDBCheckBox, LMDCustomMaskEdit,
   LMDCustomListComboBox, LMDListComboBox, LMDDBListComboBox, LMDCustomExtCombo;

type
  TFrmPesCred = class(TForm)
    PanelTrabalho: TLMDSimplePanel;
    Shape1: TShape;
    LMDLabel1: TLMDLabel;
    DBDateEdit1: TDBDateEdit;
    LMDDBCheckBox2: TLMDDBCheckBox;
    LMDDBCheckBox3: TLMDDBCheckBox;
    LMDDBCheckBox4: TLMDDBCheckBox;
    LMDDBCheckBox5: TLMDDBCheckBox;
    LMDDBCheckBox6: TLMDDBCheckBox;
    LMDDBCheckBox7: TLMDDBCheckBox;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit17: TLMDDBLabeledEdit;
    LMDDBLabeledEdit19: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDDBLabeledListComboBox1: TLMDDBLabeledListComboBox;
    LMDDBLabeledListComboBox2: TLMDDBLabeledListComboBox;
    edSenha: TLMDEdit;
    LMDLabel2: TLMDLabel;
    TabPesCred: TRESTDWClientSQL;
    SouPesCred: TDataSource;
    TabPesCredIDPess: TIntegerField;
    TabPesCredLimCredito: TFloatField;
    TabPesCredPrazoPag: TSmallintField;
    TabPesCredDiasCaren: TSmallintField;
    TabPesCredNroMaxPar: TSmallintField;
    TabPesCredPerDesc: TFloatField;
    TabPesCredPerJuro: TFloatField;
    TabPesCredDatBloq: TDateField;
    TabPesCredTipResid: TWideStringField;
    TabPesCredRefPess: TWideStringField;
    TabPesCredRefCome: TWideStringField;
    TabPesCredNroCarFid: TIntegerField;
    TabPesCredSenVenPra: TWideStringField;
    TabPesCredFormaVenc: TWideStringField;
    TabPesCredCalJurAtr: TBooleanField;
    TabPesCredPerPrePro: TBooleanField;
    TabPesCredNaoGerCom: TBooleanField;
    TabPesCredNaoVenPra: TBooleanField;
    TabPesCredNaoBloVen: TBooleanField;
    TabPesCredCliNegSPC: TBooleanField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LMDDBLabeledEdit19Exit(Sender: TObject);
   private
     { Private declarations }
   public
     { Public declarations }
   end;

var
  FrmPesCred: TFrmPesCred;

implementation

{$R *.dfm}

uses uDM, uPessoasCad, uLibFarm;

procedure TFrmPesCred.FormShow(Sender: TObject);
begin
   TabPesCred.Close;
   TabPesCred.SQL.Text := 'SELECT * FROM arqpesscred WHERE IDPess = '+basIDPess.ToString;
   TabPesCred.Open;
   if TabPesCred.IsEmpty then
   begin
      TabPesCred.Append;
      TabPesCredIDPess.Value    := basIDPess;
      TabPesCredPrazoPag.Value  := 0;
      TabPesCredDiasCaren.Value := 0;
      TabPesCredNroMaxPar.Value := 0;
      TabPesCredPerDesc.Value   := 0.00;
      TabPesCredPerJuro.Value   := 0.00;
      TabPesCredCalJurAtr.Value := True;
      TabPesCredPerPrePro.Value := True;
      TabPesCredNaoGerCom.Value := False;
      TabPesCredNaoVenPra.Value := False;
      TabPesCredNaoBloVen.Value := False;
      TabPesCredCliNegSPC.Value := False;
      TabPesCredLimCredito.Value := 0.00;
   end else
   begin
      TabPesCred.Edit;
      edSenha.Text := TabPesCredSenVenPra.Value;
   end;
end;

procedure TFrmPesCred.LMDDBLabeledEdit19Exit(Sender: TObject);
begin
   if TabPesCredPerDesc.AsFloat > 100.00 then
   begin
      MostraMsg('Aviso','Não é permitdo descontos acima de 100%', mtWarning, [mbOk]);
      TabPesCredPerDesc.AsFloat := 0.00;
      LMDDBLabeledEdit19.SetFocus;
   end;
end;

procedure TFrmPesCred.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if edSenha.Text.Trim <> TabPesCredSenVenPra.Value then
   begin
      if not(TabPesCred.State in dsEditModes) then TabPesCred.Edit;
      TabPesCredSenVenPra.Value := edSenha.Text.Trim;
   end;
   if TabPesCred.State in dsEditModes then TabPesCred.Post;
end;

end.
