unit uReceitaB;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, Vcl.ExtCtrls, LMDCustomMaskEdit,
   LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox, LMDBackPanel,
   LMDCustomMemo, LMDCustomGroupBox, LMDCustomButtonGroup, RxToolEdit,
   RxDBCtrl, LMDCustomRadioGroup, Vcl.StdCtrls, uRESTDWBasicTypes, Data.DB,
   LMDRadioGroup, LMDCustomDateTimePicker, LMDDateTimePicker, LMDMemo,
   uRESTDWBasicDB, Vcl.Grids, Vcl.DBGrids, uReceitaBase, LMDCustomParentPanel;

type
  TFrmReceitaB = class(TFrmReceitaBase)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    pnReceita: TLMDBackPanel;
    btSalvar: TAdvGlowButton;
    LMDLabel3: TLMDLabel;
    edDatVen: TLMDDateTimePicker;
    edEndpac: TLMDLabeledEdit;
    edNompac: TLMDLabeledEdit;
    edNommed: TLMDLabeledEdit;
    edNroRec: TLMDLabeledEdit;
    edUfpac: TLMDLabeledListComboBox;
    rgUsomed: TLMDRadioGroup;
    edTelpac: TLMDLabeledEdit;
    edSspac: TLMDLabeledEdit;
    edRgpac: TLMDLabeledEdit;
    edNroRec2: TLMDLabeledEdit;
    edUfpac2: TLMDLabeledEdit;
    edNompac1: TLMDLabeledEdit;
    edEndpac1: TLMDMemo;
    edNompac2: TLMDLabeledEdit;
    edEndpac2: TLMDMemo;
    edRgpac2: TLMDLabeledEdit;
    edSspac2: TLMDLabeledEdit;
    edTelpac2: TLMDLabeledEdit;
    edANum: TLMDLabeledEdit;
    edNommed_Nome: TLMDLabeledEdit;
    edNommed_CRM: TLMDLabeledEdit;
    edNommed_UF: TLMDLabeledEdit;
    edDespro: TLMDMemo;
    edDatVenda: TLMDLabeledEdit;
    edDatVen_Dia: TLMDLabeledEdit;
    edDatVen_Mes: TLMDLabeledEdit;
    edDatVen_Ano: TLMDLabeledEdit;
    pnLoteSNGPC: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    dbgLoteSNGPC: TDBGrid;
    LMDLabel2: TLMDLabel;
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure edNompacExit(Sender: TObject);
    procedure edEndpacExit(Sender: TObject);
    procedure edNommedExit(Sender: TObject);
    procedure edNommedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNommedCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edNroRecExit(Sender: TObject);
    procedure edNroRecKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edUfpacExit(Sender: TObject);
    procedure edUfpacKeyPress(Sender: TObject; var Key: Char);
    procedure rgUsomedExit(Sender: TObject);
    procedure rgUsomedKeyPress(Sender: TObject; var Key: Char);
    procedure edRgpacExit(Sender: TObject);
    procedure edSspacExit(Sender: TObject);
    procedure edTelpacExit(Sender: TObject);
    procedure edDatVenKeyPress(Sender: TObject; var Key: Char);
    procedure edDatVenExit(Sender: TObject);
    procedure dbgLoteSNGPCDblClick(Sender: TObject);
    procedure dbgLoteSNGPCKeyPress(Sender: TObject; var Key: Char);
    procedure edNompacCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNompacCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edNompacCustomButtons2Click(Sender: TObject; index: Integer);
    procedure edNompacKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgLoteSNGPCDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
 private
    { Private declarations }
    FDataHoje: TDateTime;
    function ValidaAtributos: Boolean;
    procedure CarregaLotesSNGPC(IDFilial, IDInvIni, IDProd: Integer);
    function DataPrescricaoInvalida(): Boolean;
    procedure AlteraQtdLoteSngpc(Sender: TObject);
    procedure PegaDadosRGPessoa(IDPess: Integer);
 public
    { Public declarations }
 end;

var
   FrmReceitaB: TFrmReceitaB;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uReceitaAltLotEstoq, uPessoasCad, uBuscaPes;

procedure TFrmReceitaB.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   cdArqSngpcLot.CreateDataSet;
end;

procedure TFrmReceitaB.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;

  //CTRL + S
  if (Key = 83) and (ssCtrl in Shift) then
  begin
    btSalvarClick(Sender);
    key:= 0;
  end;
end;

procedure TFrmReceitaB.FormShow(Sender: TObject);
begin
   FDataHoje := DataServer;
   edNomPac.Tag  := recIDPac;
   edNomPac.Text := recNomePac;
   edNompac1.Text:= recNomepac;
   edNompac2.Text:= recNomepac;
   //edNompacExit(edNomPac);

   if recIncluindo then
     PegaDadosRGPessoa(recIDPac);

   edEndPac.Text := recEndPac;
   edEndpac1.Text:= recEndpac;
   edEndpac2.Text:= recEndpac;
   edEndpacExit(edEndPac);

   // Data da Prescri??o da Receita
   edDatVen.SetValue(recDatPresc);
   edDatVen_Dia.Text:= FormatDateTime('dd', recDatPresc);
   edDatVen_Mes.Text:= FormatDateTime('mmmm', recDatPresc);
   edDatVen_Ano.Text:= FormatDateTime('yyyy', recDatPresc);
   edDatVenExit(edDatVen);
   // Data da Venda
   edDatVenda.Text:= FormatDateTime('dd/mm/yyyy', recDatVen);

   edNommed.Tag:= recIDPessMed;
   edNommed.Text:= recNommed;
   edNommedExit(edNommed);
   edNroRec.Text:= recNroRec;
   edNroRec2.Text:= recNroRec;
   edNroRecExit(edNroRec2);
   edUfpac.Text := recUfpac;
   edUfpac2.Text := recUfpac;
   edUfpacExit(edUfpac);
   rgUsomed.ItemIndex:= iif(recUsoMed = 'H', 0, 1);
   rgUsomedExit(rgUsomed);
   edRgpac.Text:= recRgpac;
   edRgpac2.Text:= recRgpac;
   edRgpacExit(edRgpac2);
   edSspac.Text:= recSspac;
   edSspac2.Text:= recSspac;
   edSspacExit(edSspac);
   edTelpac.Text:= recTelpac;
   edTelpac2.Text:= recTelpac;
   edTelpacExit(edTelpac);
   edDespro.Text:= recDespro;

   if pnLoteSNGPC.Visible then
   begin
     dbgLoteSNGPC.DataSource:= dsArqSngpcLot;
     CarregaLotesSNGPC(recIDFilial, recIDInvIni, recIDProd);
   end;
end;

procedure TFrmReceitaB.rgUsomedExit(Sender: TObject);
begin
  if rgUsomed.ItemIndex = 0 then
    recUsoMed:= 'H'
  else
    recUsoMed:= 'V';
end;

procedure TFrmReceitaB.rgUsomedKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(Sender as TWinControl, True, True);
  end;
end;

procedure TFrmReceitaB.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmReceitaB.btSalvarClick(Sender: TObject);
begin
  if ValidaAtributos() then
  begin
    recDatPresc  := StrToDate(Copy(edDatVen.Text,1,10));
    recNommed    := edNommed.Text;
    recIDPessMed := edNommed.Tag;
    recNroRec  := edNroRec.Text;
    recUfpac   := edUfpac.Text;
    recIdade   := 0;
    recSexo    := '0';
    recUsoMed  := iif(rgUsomed.ItemIndex = 0, 'H', 'A');
    recNomepac := edNompac.Text;
    recEndpac  := edEndpac.Text;
    recRgpac   := edRgpac.Text;
    recSspac   := edSspac.Text;
    recTelpac  := edTelpac.Text;
    btSalvar.ModalResult:= mrOK;
    self.Close;
  end;
end;

procedure TFrmReceitaB.edDatVenExit(Sender: TObject);
begin
  // Data da Prescrição da Receita
  recDatPresc:= edDatVen.AsDate;
  edDatVen_Dia.Text:= FormatDateTime('dd', recDatPresc);
  edDatVen_Mes.Text:= FormatDateTime('mmmm', recDatPresc);
  edDatVen_Ano.Text:= FormatDateTime('yyyy', recDatPresc);
  if DataPrescricaoInvalida() then edDatVen.SetFocus;
end;

procedure TFrmReceitaB.edDatVenKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(Sender as TWinControl, True, True);
  end;
end;

procedure TFrmReceitaB.edEndpacExit(Sender: TObject);
begin
  if edEndpac.Text <> EmptyStr then
  begin
    recEndPac:= edEndpac.Text;

    edEndpac1.Text:= recEndPac;
    edEndpac2.Text:= recEndPac;
  end;
end;

procedure TFrmReceitaB.edNommedCustomButtons1Click(Sender: TObject; index: Integer);
begin
  btBuscas('arqpessoa',TLMDEdit(edNommed),'IDPess','Nompes','IDEsppes = 4',index,True);
  recIDPessMed:= edNommed.Tag;
  recNommed   := edNommed.Text;
end;

procedure TFrmReceitaB.edNommedExit(Sender: TObject);
   procedure PegaDadosMedico(prIDPess, prCpfCnpjPes: String);
   var
     QueAuxi: TRESTDWClientSQL;
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            QueAuxi.Close;
            SQL.Clear;
            SQL.Text := 'SELECT IDPess,Nompes,IDEsppes, ConRegProf, NroRegProf, EstRegProf FROM arqpessoa WHERE '+
            iif(prIDPess.Length < 11, 'IDPess = '+prIDPess, 'CpfCnpjPes = '+Aspas(prCpfCnpjPes));
            QueAuxi.Open;
            Application.ProcessMessages;
            if not QueAuxi.IsEmpty then
            begin
               if QueAuxi.FieldByName('IDEsppes').AsInteger <> 4 then
               begin
                  edNommed.Tag := 0;
                  edNommed.Text:= '';
                  MostraMsg('Aviso', 'Essa pessoa n?o ? Medico(a)!',mtWarning, [mbOk]);
                  edNommed.SetFocus;
                  Exit;
               end; //if
               edNommed.Tag       := FieldByName('IDPess').AsInteger;
               recIDPessMed       := FieldByName('IDPess').AsInteger;
               edNommed.Text      := FieldByName('Nompes').AsString;
               edNommed_Nome.Text := FieldByName('Nompes').AsString;
               edNommed_CRM.Text  := FieldByName('ConRegProf').AsString+': '+FieldByName('NroRegProf').AsString;
               edNommed_UF.Text   := 'UF: '+FieldByName('EstRegProf').AsString;
            end else
            begin
               edNommed.Tag := 0;
               edNommed.Text:= '';
               MostraMsg('Aviso', 'M?dico(a) n?o encontrado!',mtWarning, [mbOk]);
            end;
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;
begin
   if IsNumeric(edNommed.Text) then
   begin
      PegaDadosMedico(edNommed.Text.Trim, edNommed.Text.Trim);
   end else
   begin
     if edNommed.Tag > 0 then
     begin
       PegaDadosMedico(edNommed.Tag.ToString, edNommed.Tag.ToString);
     end;
   end;
end;

procedure TFrmReceitaB.edNommedKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if not(ssCtrl in Shift) then
   begin
     if (key <> VK_RETURN) and (Key <> VK_ESCAPE)  then
     begin
        edNommedCustomButtons1Click(Self, Key);
     end;

     if Key = VK_ESCAPE then
     begin
        TLMDDBLabeledEdit(Sender).Text:= '';
        TLMDDBLabeledEdit(Sender).Tag:= 0;
     end;
   end;
end;

procedure TFrmReceitaB.edNompacExit(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if IsNumeric(edNompac.Text) then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            SQL.Text := 'SELECT p.IDPess, p.Nompes FROM arqpessoa p LEFT JOIN arqpessconv C ON p.IDPess = c.IDPess '+
            'WHERE (p.IDPess = '+Aspas(edNompac.Text)+' OR p.FonePes = '+Aspas(edNompac.Text)+' OR CelularPes = '+Aspas(edNompac.Text)+' OR '+
            'p.Nompes LIKE CONCAT("%", '+Aspas(edNompac.Text)+', "%") OR p.NomfanPes LIKE CONCAT("%", '+Aspas(edNompac.Text)+', "%") '+
            'OR p.CpfCnpjPes = '+Aspas(edNompac.Text)+' OR c.NroMatric = '+Aspas(edNompac.Text)+' OR c.NroCartao = '+Aspas(edNompac.Text)+' '+
            'OR p.RGEPes = '+Aspas(edNompac.Text)+') '+
            ' GROUP BY p.IDPess ORDER BY p.Nompes ';
            QueAuxi.Open;
            Application.ProcessMessages;
            if not QueAuxi.IsEmpty then
            begin
               edNompac.Text := FieldByName('Nompes').AsString;
               edNompac.Tag  := FieldByName('IDPess').AsInteger;
            end else
            begin
               MostraMsg('Aviso', 'Pessoa não encontrada!',mtWarning, [mbOk]);
               edNompac.Text := '';
               edNompac.Tag  := 0;
               edNompac.SetFocus;
            end;
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;

   recIDPac   := edNompac.Tag;
   recNomePac := edNompac.Text;
   edNompac1.Text := recNomePac;
   edNompac2.Text := recNomePac;
   if recIncluindo then PegaDadosRGPessoa(recIDPac);
end;

procedure TFrmReceitaB.edNroRecExit(Sender: TObject);
begin
  if edNroRec.Text <> EmptyStr then
  begin
    recNroRec:= edNroRec.Text;
    edNroRec2.Text:= recNroRec;
  end;
end;

procedure TFrmReceitaB.edNroRecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Permitir teclas de números (teclado principal e num?rico)
  if Key in [65..90] then Key := 0;
end;

procedure TFrmReceitaB.edRgpacExit(Sender: TObject);
begin
  if edRgpac.Text <> EmptyStr then
  begin
    recRgpac:= edRgpac.Text;
    edRgpac2.Text:= recRgpac;
  end;
end;

procedure TFrmReceitaB.edSspacExit(Sender: TObject);
begin
  if edSspac.Text <> EmptyStr then
  begin
    recSspac:= edSspac.Text;
    edSspac2.Text:= recSspac;
  end;
end;

procedure TFrmReceitaB.edTelpacExit(Sender: TObject);
begin
  if edTelpac.Text <> EmptyStr then
  begin
    recTelpac:= edTelpac.Text;
    edTelpac2.Text:= recTelpac;
  end;
end;

procedure TFrmReceitaB.edUfpacExit(Sender: TObject);
begin
  if edUfpac.Text <> EmptyStr then
  begin
    // Valida UF
    if edUfpac.Items.IndexOf(edUfpac.Text) > -1 then
    begin
      recUfpac:= edUfpac.Text;
      edUfpac2.Text:= recUfpac;
    end else
    begin
      MostraMsg('Aten??o','UF Inv?lida!',mtWarning, [mbOk]);
      edUfpac.SetFocus;
    end;
  end;
end;

procedure TFrmReceitaB.edUfpacKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(Sender as TWinControl, True, True);
  end;
end;

function TFrmReceitaB.ValidaAtributos(): Boolean;
var
  DBEditErro: TLMDLabeledEdit;
  qtdTotal: Currency;
begin
  Result:= True;
  DBEditErro:= nil;

  // 04-SNGPC Obrigatorio Na Venda (Desmarcado) n?o valida nada
  if not(recSNGPCObrVenda) then Exit;

  // Valida Qtd Lote SNGPC Selecionada
  if pnLoteSNGPC.Visible then
  begin
    qtdTotal:= 0;
    cdArqSngpcLot.DisableControls;
    cdArqSngpcLot.First;
    while not(cdArqSngpcLot.Eof) do
    begin
      qtdTotal:= qtdTotal + cdArqSngpcLotQtdSel.AsCurrency;
      cdArqSngpcLot.Next;
    end;
    cdArqSngpcLot.First;
    cdArqSngpcLot.EnableControls;

    if recQtdped <> qtdTotal then
    begin
      Result:= False;
      MostraMsg('Lote SNGPC','Quantidade Informada diferente da quantidade da Venda!',mtWarning, [mbOk]);
      dbgLoteSNGPC.SetFocus;
      Exit;
    end;
  end;

  if DataPrescricaoInvalida() then
  begin
    Result:= False;
    edDatVen.SetFocus;
    Exit;
  end;

  if edNompac.Text.Trim = EmptyStr then DBEditErro := edNompac else
  if edEndpac.Text.Trim = EmptyStr then DBEditErro := edEndpac else
  if edNommed.Text.Trim = EmptyStr then DBEditErro := edNommed else
  if edNroRec.Text.Trim = EmptyStr then DBEditErro := edNroRec else
  if edRgpac.Text.Trim  = EmptyStr then DBEditErro := edRgpac else
  if edSspac.Text.Trim  = EmptyStr then DBEditErro := edSspac else
  if edTelpac.Text.Trim = EmptyStr then DBEditErro := edTelpac;

  if DBEditErro <> nil then
  begin
     Result:= False;
     MostraMsg('Dado n?o informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
     DBEditErro.SetFocus;
     Exit;
  end;

  if edUfpac.Text.Trim = EmptyStr  then
  begin
     Result:= False;
     MostraMsg('Dado n?o informado','Favor preencher '+edUfpac.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
     edUfpac.SetFocus;
  end;
end;

procedure TFrmReceitaB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFrmReceitaB.CarregaLotesSNGPC(IDFilial, IDInvIni, IDProd: Integer);
var
  qry: TRESTDWClientSQL;

  function LoteJaExiste(prIDInvIni: Integer; prNrolot: String): Boolean;
  begin
    Result:= False;

    cdArqSngpcLot.First;
    while not(cdArqSngpcLot.Eof) do
    begin
      if (cdArqSngpcLotIDInvIni.AsInteger = prIDInvIni) and (cdArqSngpcLotNrolot.AsString = prNrolot) then
      begin
        Result:= True;
        Break;
      end;
      cdArqSngpcLot.Next;
    end;

  end;
begin

  try
    cdArqSngpcLot.Open;
    qry:= CreateSQL(dm.DWDataBase,
    'select IDFilial, IDInvIni, IDProd, Nrolot, IDPess, Datfab, Datven, UsoRece, Qtdest ' +
    'from arqsngpclot ' +
    'where IDFilial = :idFilial ' +
    '  and IDInvIni = :idInvIni ' +  // Invent?rio Ativo
    '  and IDProd   = :IdProd ' +
    'order by Datven desc ',
    [IDFilial.ToString, IDInvIni.ToString, IDProd.ToString]);
    qry.Open;
    while not(qry.Eof) do
    begin
      if LoteJaExiste(qry.FieldByname('IDInvIni').AsInteger, qry.FieldByname('Nrolot').AsString) then
           cdArqSngpcLot.Edit
      else cdArqSngpcLot.Append;

      cdArqSngpcLotIDInvIni.AsInteger := qry.FieldByname('IDInvIni').AsInteger;
      cdArqSngpcLotIDProd.AsInteger   := qry.FieldByname('IDProd').AsInteger;
      cdArqSngpcLotIDPess.AsInteger   := qry.FieldByname('IDPess').AsInteger;
      cdArqSngpcLotNrolot.AsString    := qry.FieldByname('Nrolot').AsString;
      cdArqSngpcLotDatven.AsDateTime  := qry.FieldByname('Datven').AsDateTime;
      cdArqSngpcLotQtdest.AsCurrency  := qry.FieldByname('Qtdest').AsCurrency;
      cdArqSngpcLot.Post;
      qry.Next;
    end;
    qry.Close;
    cdArqSngpcLot.First;
  finally
    qry.Free;
  end;

end;

// Valida data da Prescri??o da Receita
function TFrmReceitaB.DataPrescricaoInvalida(): Boolean;
begin
  Result:= False;

  // Data da Prescriçao não pode ser maior que a data de Hoje
  if recDatPresc > FDataHoje then
  begin
    Result:= True;
    MostraMsg('Aviso', 'Data da Prescri??o n?o pode ser maior que data de HOJE, Receita Inv?lida!',mtWarning, [mbOk]);
    Exit;
  end;

  // Dia da Prescrição da Receita conta como primeiro dia por isso deve diminuir um dia
  var DataValidade:= recDatPresc + (recValDias - 1);
  if FDataHoje > DataValidade then
  begin
    Result:= True;
    MostraMsg('Aviso', 'Data da Prescri??o Inv?lida, Receita Vencida!',mtWarning, [mbOk]);
    Exit;
  end;
end;

procedure TFrmReceitaB.dbgLoteSNGPCDblClick(Sender: TObject);
begin
  AlteraQtdLoteSngpc(Sender);
end;

procedure TFrmReceitaB.dbgLoteSNGPCDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if TDBGrid(Sender).DataSource.DataSet.FieldByName('Datven').AsDateTime < FDataHoje then
  begin
    TDBGrid(Sender).Canvas.Brush.Color := clWebOrange;
    TDBGrid(Sender).Canvas.Font.Color  := clBlack;
    TDBGrid(Sender).Canvas.FillRect(Rect);
  end;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmReceitaB.dbgLoteSNGPCKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    AlteraQtdLoteSngpc(Sender);
end;

procedure TFrmReceitaB.AlteraQtdLoteSngpc(Sender: TObject);
var
  lPoint: TPoint;
  lNrolot: String;
  lQtdest, lQtdSel: Currency;
begin
  inherited;
  lNrolot := TDBGrid(Sender).DataSource.DataSet.FieldByName('Nrolot').AsString;
  lQtdest := TDBGrid(Sender).DataSource.DataSet.FieldByName('Qtdest').AsFloat;
  lQtdSel := TDBGrid(Sender).DataSource.DataSet.FieldByName('QtdSel').AsFloat;

  if TDBGrid(Sender).DataSource.DataSet.FieldByName('Datven').AsDateTime < FDataHoje then
  begin
     MostraMsg('Atenção', 'Lote SNGPC ' +lNrolot+ ' Vencido em ' +
     FormatDateTime('dd/mm/yyyy', TDBGrid(Sender).DataSource.DataSet.FieldByName('Datven').AsDateTime)+'!',mtWarning, [mbOk]);
     Exit;
  end;

  var FrmReceitaAltLotEstoq := TFrmReceitaAltLotEstoq.Create(Application);
  try
    lPoint := Self.dbgLoteSNGPC.ClientToScreen(Point(0,0));
    FrmReceitaAltLotEstoq.Left   := lPoint.X;
    FrmReceitaAltLotEstoq.Top    := (lPoint.Y - FrmReceitaAltLotEstoq.Height) + 80;
    FrmReceitaAltLotEstoq.recNroLote    := lNrolot;
    FrmReceitaAltLotEstoq.recQtdLoteDisp:= lQtdest;
    FrmReceitaAltLotEstoq.recQtdSel     := lQtdSel;
    FrmReceitaAltLotEstoq.ShowModal;
    if FrmReceitaAltLotEstoq.recQtdSel > 0 then
    begin
      TDBGrid(Sender).DataSource.DataSet.Edit;
      TDBGrid(Sender).DataSource.DataSet.FieldByName('QtdSel').AsFloat:= FrmReceitaAltLotEstoq.recQtdSel;
      TDBGrid(Sender).DataSource.DataSet.Post;
    end;
  finally
    FrmReceitaAltLotEstoq.Free;
  end;
end;

procedure TFrmReceitaB.edNompacCustomButtons0Click(Sender: TObject; index: Integer);
var
  auxIDPess: Integer;
  auxNomeCli: String;
begin
  auxIDPess:= 0;
  auxNomeCli:= '';
  try
     FrmPesCad := TFrmPesCad.Create(Application);
     CentralizarControl(FrmPesCad, FrmReceitaB);
     FrmPesCad.recIDPess := -1;
     FrmPesCad.recEsppes := 1; // Cliente
     FrmPesCad.recOrigem := 'RECEITA';
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
     recIDPac:= auxIDPess;
     recNomepac:= auxNomeCli;

     if recIncluindo then
       PegaDadosRGPessoa(recIDPac);
  end;
end;

procedure TFrmReceitaB.edNompacCustomButtons1Click(Sender: TObject; index: Integer);
var
   auxIDPess: Integer;
   auxNomeCli: String;
begin
   auxIDPess:= 0;
   auxNomeCli:= '';
   try
      FrmPesCad := TFrmPesCad.Create(Application);
      CentralizarControl(FrmPesCad, FrmReceitaB);
      if recIDPac > 0 then
           FrmPesCad.recIDPess := recIDPac
      else FrmPesCad.recIDPess := 0;
      FrmPesCad.ShowModal;
   finally
      auxIDPess := FrmPesCad.recIDPess;
      auxNomeCli:= FrmPesCad.recNompes;
      FreeAndNil(FrmPesCad);
   end;

   if auxIDPess > 0 then
   begin
     recIDPac := auxIDPess;
     if recNomepac <> auxNomeCli then recNomepac := auxNomeCli;
     if recIncluindo then PegaDadosRGPessoa(recIDPac);
   end else
   begin
     recIDPac := 0;
     edNompac.Text := '';
   end;
end;

procedure TFrmReceitaB.edNompacCustomButtons2Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      edNompac.Tag := 0;
      FrmBuscaPes := TFrmBuscaPes.Create(Application);
      with FrmBuscaPes do
      begin
         lPoint := Self.edNompac.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edNompac.Width;
         edRetorno := TLMDEdit(Self.edNompac);

         if index > 2 then
           edBusca.Text := char(index)
         else
           edBusca.Text := Self.edNompac.Text;
         ShowModal;
      end; // with
   finally
      if edNompac.Tag > 0 then
      begin
         recIDPac := edNompac.Tag;
         edNompac.Text := FrmBuscaPes.edRetorno.Text;

         if recIncluindo then
           PegaDadosRGPessoa(recIDPac);
      end;
      FrmBuscaPes.Free;
   end;
end;

procedure TFrmReceitaB.edNompacKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if not(ssCtrl in Shift) and not(ssShift in Shift) then
   begin
      if (key <> VK_RETURN) and (Key <> VK_ESCAPE) and (Key <> VK_INSERT) then
     begin
       edNompacCustomButtons2Click(Sender, key);
       key:= 0;
     end;
     // Tecla [INS, INSERT] Incluiu Novo Cliente, Referente Botão +
     if Key = VK_INSERT then
     begin
       edNompacCustomButtons0Click(Sender, 1);
     end;
     // Tecla [ESC] Zera tudo
     if Key = VK_ESCAPE then
     begin
        edNompac.Text:= '';
        edNompac.Tag:= 0;

        recIDPac:= 0;
        recNomepac:= EmptyStr;
     end;
   end else
   begin
     //CTRL + A -> Altera dados cadastrais do cliente já selecionado
     if (Key = 65) and (ssCtrl in Shift) then
     begin
       edNompacCustomButtons1Click(Sender, 2);
       key:= 0;
     end;
   end;
end;

procedure TFrmReceitaB.PegaDadosRGPessoa(IDPess: Integer);
var
  Query: TRESTDWClientSQL;
begin
  recNumDocComp := '';
  recOrgExpComp := '';
  recUFEmiComp  := '';
  //
  Query := TRESTDWClientSQL.Create(nil);
  try
    Query.DataBase := DM.DWDataBase;
    Query.SQL.Text := Format('SELECT a.IDPess, a.TipoPes, a.CpfCnpjPes, a.Nompes, a.Endpes, a.NroEnd, a.CompEnd, a.Baipes, a.Ceppes, a.FonePes, a.CelularPes, ' +
    'a.SexoPes, a.Codmun, m.Nommun, m.Estmun, a.RGEPes, a.RGEOrg, a.RGEEst FROM arqpessoa a ' +
    'left join arqmuni m on m.Codmun = a.Codmun where IDPess = %s ', [IDPess.ToString]);
    Query.Open;

    if not Query.IsEmpty then
    begin
      recNumDocComp := Query.FieldByName('RGEPes').AsString;
      recOrgExpComp := Query.FieldByName('RGEOrg').AsString.Trim;
      recUFEmiComp  := Query.FieldByName('RGEEst').AsString.Trim;

      recSexo   := Query.FieldByName('SexoPes').AsString;

      recEndpac := Query.FieldByName('Endpes').AsString;
      if Query.FieldByName('NroEnd').AsString.Trim <> EmptyStr then
        recEndpac := recEndpac + ' ' + Query.FieldByName('NroEnd').AsString.Trim;

      if Query.FieldByName('Baipes').AsString.Trim <> EmptyStr then
        recEndpac := recEndpac + ', bairro: ' + Query.FieldByName('Baipes').AsString.Trim;

    end;
  finally
    Query.Close;
    Query.Free;
  end;
  // Endereço
  edEndpac1.Text:= recEndpac;
  edEndpac2.Text:= recEndpac;
  // Documento
  edRgpac.Text:= recNumDocComp;
  edRgpac2.Text:= recNumDocComp;
  edSspac.Text:= recOrgExpComp;
  edSspac2.Text:= recOrgExpComp;
end;

end.
