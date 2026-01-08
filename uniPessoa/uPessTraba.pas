unit uPessTraba;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxDBCtrl, LMDBaseEdit,
   LMDCustomEdit, LMDDBEdit, LMDBaseControl, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDLabel, MarcLib, LMDControl, LMDCustomControl,
   LMDCustomPanel, LMDCustomBevelPanel, FireDAC.Comp.Client, uRESTDWBasicTypes,
   LMDSimplePanel, ACBrBase, ACBrSocket, ACBrCEP, Vcl.DBCtrls, FireDAC.DatS,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type

 TFrmPesTraba = class(TForm)
    ACBrCEP: TACBrCEP;
    LMDSimplePanel2: TLMDSimplePanel;
    DBDateEdit1: TDBDateEdit;
    PanelTrabalho: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    LMDDBLabeledEdit10: TLMDDBLabeledEdit;
    LMDDBLabeledEdit11: TLMDDBLabeledEdit;
    LMDDBLabeledEdit12: TLMDDBLabeledEdit;
    LMDDBLabeledEdit16: TLMDDBLabeledEdit;
    LMDDBLabeledEdit17: TLMDDBLabeledEdit;
    LMDDBLabeledEdit18: TLMDDBLabeledEdit;
    LMDDBLabeledEdit19: TLMDDBLabeledEdit;
    TabPesTrab: TRESTDWClientSQL;
    SouPesTrab: TDataSource;
    TabPesTrabIDPess: TIntegerField;
    TabPesTrabCodmun: TIntegerField;
    TabPesTrabDatAdmTra: TDateField;
    TabPesTrabSalarioTra: TFloatField;
    TabPesTrabNomLoctra: TWideStringField;
    TabPesTrabEndLoctra: TWideStringField;
    TabPesTrabBaiLoctra: TWideStringField;
    TabPesTrabCepLoctra: TWideStringField;
    TabPesTrabFonLoctra: TWideStringField;
    TabPesTrabCargoTra: TWideStringField;
    TabPesTrabNommun: TWideStringField;
    TabPesTrabEstmun: TWideStringField;
    procedure LMDDBLabeledEdit11KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
    procedure LMDDBLabeledEdit10Exit(Sender: TObject);
    procedure ACBrCEPBuscaEfetuada(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmPesTraba: TFrmPesTraba;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uPessoasCad;

procedure TFrmPesTraba.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesTraba.FormShow(Sender: TObject);
begin
   TabPesTrab.Close;
   TabPesTrab.SQL.Text := 'SELECT TRA.*,MUN.Nommun,MUN.Estmun FROM arqpesstrab TRA';
   TabPesTrab.SQL.Add('LEFT JOIN arqmuni MUN ON TRA.Codmun = MUN.Codmun WHERE IDPess = '+basIDPess.ToString);
   TabPesTrab.Open;
   if TabPesTrab.IsEmpty then
   begin
      TabPesTrab.Append;
      TabPesTrabIDPess.Value := basIDPess;
      TabPesTrabSalarioTra.Value := 0.00;
   end
   else TabPesTrab.Edit;
end;

procedure TFrmPesTraba.LMDDBLabeledEdit11CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabPesTrab,'arqmuni',TDBEdit(LMDDBLabeledEdit11),'Codmun','Codmun','Nommun','Nommun','',1);
end;

procedure TFrmPesTraba.LMDDBLabeledEdit11KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabPesTrab,'arqmuni',TDBEdit(LMDDBLabeledEdit11),'Codmun','Codmun','Nommun','Nommun','',Key);
end;

procedure TFrmPesTraba.LMDDBLabeledEdit10Exit(Sender: TObject);
begin
   if (TabPesTrabCepLoctra.AsString <> TabPesTrabCepLoctra.OldValue) and
     (Trim(TabPesTrabCepLoctra.AsString) <> '') then ACBrCEP.BuscarPorCEP(TabPesTrabCepLoctra.AsString);
end;

procedure TFrmPesTraba.ACBrCEPBuscaEfetuada(Sender: TObject);
begin
   with ACBrCEP do
   begin
      if Enderecos.Count > 0 then
      begin
         if not(TabPesTrab.State in dsEditModes) then TabPesTrab.Edit;
         TabPesTrabEndLoctra.Value := AnsiUpperCase(iif(Trim(Enderecos[0].Logradouro) <> '', Enderecos[0].Logradouro, TabPesTrabEndLoctra.Value));
         TabPesTrabBaiLoctra.Value := AnsiUpperCase(iif(Trim(Enderecos[0].Bairro)     <> '', Enderecos[0].Bairro, TabPesTrabBaiLoctra.Value));
         TabPesTrabCodmun.Value := StrToInt(Enderecos[0].IBGE_Municipio);
         TabPesTrabNommun.Value := UpperCase(Enderecos[0].Municipio);
         TabPesTrabEstmun.Value := Enderecos[0].UF;
      end
      else MostraMsg('Aviso','CEP não encontrado!', mtWarning, [mbOK]);
   end; //with
end;

procedure TFrmPesTraba.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabPesTrab.State in dsEditModes then TabPesTrab.Post;
end;

end.
