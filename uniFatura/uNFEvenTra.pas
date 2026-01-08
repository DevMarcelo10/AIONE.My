unit uNFEvenTra;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, Vcl.Dialogs,
     System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
     Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseLabel,
     LMDCustomLabel, LMDControl, LMDCustomControl, LMDCustomPanel,
     LMDSimplePanel, AdvGlowButton, LMDCustomBevelPanel, Vcl.ExtCtrls,
     LMDBaseGraphicControl, LMDBaseEdit, LMDCustomMemo, LMDDBEdit,
     LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtCombo, MarcLib,
     LMDCustomListComboBox, LMDListComboBox, LMDDBListComboBox,
     uRESTDWBasicTypes, uRESTDWBasicDB;

type
  TFrmNFEvenTra = class(TForm)
    PanelTop: TLMDSimplePanel;
    OBSER: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    btSalvaIte: TAdvGlowButton;
    btLimpar: TAdvGlowButton;
    LMDDBLabeledEdit0: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledListComboBox1: TLMDDBLabeledListComboBox;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    LMDDBLabeledListComboBox2: TLMDDBLabeledListComboBox;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit6: TLMDDBLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvaIteClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure LMDDBLabeledEdit0Exit(Sender: TObject);
 private
    { Private declarations }
    procedure SetMaskCPFCNPJ(recCampo: String);
    function  VerificaCPFCNPJ: Boolean;
 public
    { Public declarations }
    recNFEven:TRESTDWClientSQL;
    recFieldCpfCnpj:TWideStringField;
 end;

var
   FrmNFEvenTra: TFrmNFEvenTra;

implementation

{$R *.dfm}

uses uDM, uNFEven, uLibFarm;

procedure TFrmNFEvenTra.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmNFEvenTra.FormShow(Sender: TObject);
begin
   LMDDBLabeledEdit0.SetFocus;
end;

procedure TFrmNFEvenTra.SetMaskCPFCNPJ(recCampo: String);
begin
   if Length(recCampo)      = 11 then recFieldCpfCnpj.EditMask := '###.###.###-##;0;_'
   else if Length(recCampo) = 14 then recFieldCpfCnpj.EditMask := '##.###.###/####-##;0;_'
   else recFieldCpfCnpj.EditMask := '';
end;

// ------------ Valida CPF / CNPJ do Cadastro ------------ //
function TFrmNFEvenTra.VerificaCPFCNPJ: Boolean;
var
   Resultado:Boolean;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if recFieldCpfCnpj.AsString.Trim <> '' then
   begin
      if Length(recFieldCpfCnpj.Value) >= 14 then
           Resultado := CNPJ(recFieldCpfCnpj.Value)
      else Resultado := CPF (recFieldCpfCnpj.Value);
      if not Resultado then
      begin
         MostraMsg('Verifique', iif(Length(recFieldCpfCnpj.Value) = 14, 'CNPJ','CPF')+' não é válido!', mtWarning, [mbOk]);
         LMDDBLabeledEdit1.SetFocus;
         Exit;
      end;
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text := 'SELECT PES.Nompes,PES.Endpes,PES.NroEnd,PES.CompEnd,PES.InsEstPes,MUN.Nommun,MUN.Estmun FROM arqpessoa PES '+
         'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun WHERE CpfCnpjPes = '+Aspas(recFieldCpfCnpj.Value);
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            recNFEven.FieldByName('NomeTran').AsString := QueAuxi.FieldByName('Nompes').AsString;
            recNFEven.FieldByName('EndTran').AsString  := Copy(QueAuxi.FieldByName('Endpes').AsString.Trim+','+QueAuxi.FieldByName('NroEnd').AsString.Trim+', '+QueAuxi.FieldByName('CompEnd').AsString.Trim, 1,60);
            recNFEven.FieldByName('CidTran').AsString  := QueAuxi.FieldByName('Nommun').AsString;
            recNFEven.FieldByName('EstTran').AsString  := QueAuxi.FieldByName('Estmun').AsString;
            recNFEven.FieldByName('IETran').AsString   := QueAuxi.FieldByName('InsEstPes').AsString;
         end; //if
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; // if
   Result := True;
end;

procedure TFrmNFEvenTra.LMDDBLabeledEdit0Exit(Sender: TObject);
begin
   SetMaskCPFCNPJ(recFieldCpfCnpj.Value);
   if (recFieldCpfCnpj.AsString.Trim = '') or (EliminaCaracteres(recFieldCpfCnpj.AsString, ' 0') = '') then
   begin
      recFieldCpfCnpj.Clear;
      Exit;
   end;
   VerificaCPFCNPJ;
end;

procedure TFrmNFEvenTra.btLimparClick(Sender: TObject);
begin
   LMDDBLabeledEdit0.Clear;
   LMDDBLabeledEdit1.Clear;
   LMDDBLabeledEdit2.Clear;
   LMDDBLabeledEdit3.Clear;
   LMDDBLabeledEdit4.Clear;
   LMDDBLabeledEdit5.Clear;
   LMDDBLabeledEdit6.Clear;
   LMDDBLabeledListComboBox1.ItemIndex := -1;
   LMDDBLabeledListComboBox2.ItemIndex := -1;
   LMDDBLabeledEdit0.SetFocus;
end;

procedure TFrmNFEvenTra.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmNFEvenTra.btSalvaIteClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmNFEvenTra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.

