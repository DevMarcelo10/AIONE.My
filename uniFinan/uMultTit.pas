unit uMultTit;
interface
uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, MarcLib, LMDBaseControl, LMDEdit,
   LMDBaseGraphicControl, LMDBaseLabel, Vcl.DBGrids, LMDLabel, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomLabel, uRESTDWBasicDB, LMDBaseEdit, LMDCustomEdit,
   Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, uRESTDWBasicTypes, FireDAC.Comp.Client, Vcl.ExtCtrls,
   Vcl.Mask, RxToolEdit, LMDButtonControl, LMDCustomCheckBox, LMDCheckBox,
   LMDThemedComboBox, LMDCustomComboBox, LMDComboBox, MemDS, VirtualTable,
   LMDCustomMaskEdit, LMDMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, DateUtils,
   LMDRadioButton, Generics.Collections, LMDDBEdit, uConst;
type
  TFrmMulTit = class(TForm)
    PanelBase: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edFilial: TLMDLabeledEdit;
    LMDLabel2: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDatemi: TDateEdit;
    LMDLabel3: TLMDLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    edDataBase: TDateEdit;
    LMDLabel6: TLMDLabel;
    edNotFis: TLMDEdit;
    dgDados: TDBGrid;
    btFechar: TAdvGlowButton;
    edPessoa: TLMDLabeledEdit;
    MemTitu: TVirtualTable;
    SouTitu: TDataSource;
    MemTituVlrtit: TFloatField;
    MemTituNrotit: TWideStringField;
    MemTituDestit: TWideStringField;
    MemTituNotFis: TIntegerField;
    MemTituVlrAces: TFloatField;
    MemTituDesAsso: TFloatField;
    MemTituDatemi: TDateField;
    MemTituDatven: TDateField;
    PanelBottom: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    LMDLabel5: TLMDLabel;
    edDesAce: TLMDLabeledMaskEdit;
    edVlrtit: TLMDLabeledMaskEdit;
    edDesAsso: TLMDLabeledMaskEdit;
    MemTituSaltit: TFloatField;
    LMDLabel7: TLMDLabel;
    edNatFin: TLMDLabeledEdit;
    edTiptit: TLMDLabeledEdit;
    LMDLabel8: TLMDLabel;
    btGerar: TAdvGlowButton;
    edNroPar: TLMDSpinEdit;
    LMDLabel9: TLMDLabel;
    edDiaVen: TLMDSpinEdit;
    LMDLabel10: TLMDLabel;
    LMDLabel11: TLMDLabel;
    edNrotit: TLMDEdit;
    RadioPag: TLMDRadioButton;
    RadioRec: TLMDRadioButton;
    edVlrJur: TLMDLabeledMaskEdit;
    edPerJur: TLMDLabeledMaskEdit;
    edVlrMul: TLMDLabeledMaskEdit;
    edPerMul: TLMDLabeledMaskEdit;
    edHist: TLMDLabeledEdit;
    LMDLabel12: TLMDLabel;
    MemTituVlrJur: TFloatField;
    MemTituVlrMul: TFloatField;
    MemTituPerJur: TFloatField;
    MemTituPerMul: TFloatField;
    MemTituNosNum: TWideStringField;
    MemTituCodBar: TWideStringField;
    MemTituChavePIXQRCode: TWideStringField;
    MemTituChaPix: TWideStringField;
    edChaPix: TLMDLabeledEdit;
    LMDLabel13: TLMDLabel;
    Shape1: TShape;
    MemTituIDTiptit: TIntegerField;
    procedure AjustaGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgDadosDrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btGerarClick(Sender: TObject);
    procedure edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNotFisKeyPress(Sender: TObject; var Key: Char);
    procedure edNatFinKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edTiptitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edTiptitCustomButtons0Click(Sender: TObject; index: Integer);
    procedure MemTituCalcFields(DataSet: TDataSet);
    procedure MemTituBeforePost(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure edTiptitExit(Sender: TObject);
    procedure edPessoaExit(Sender: TObject);
    procedure edPessoaKeyPress(Sender: TObject; var Key: Char);
    procedure edNatFinKeyPress(Sender: TObject; var Key: Char);
    procedure edFilialKeyPress(Sender: TObject; var Key: Char);
    procedure edTiptitKeyPress(Sender: TObject; var Key: Char);
    procedure edHistKeyPress(Sender: TObject; var Key: Char);
    procedure edDatemiKeyPress(Sender: TObject; var Key: Char);
    procedure edDataBaseKeyPress(Sender: TObject; var Key: Char);
    procedure edDiaVenKeyPress(Sender: TObject; var Key: Char);
    procedure edNroParKeyPress(Sender: TObject; var Key: Char);
    procedure edChaPixKeyPress(Sender: TObject; var Key: Char);
    procedure edDesAceKeyPress(Sender: TObject; var Key: Char);
    procedure edDesAssoKeyPress(Sender: TObject; var Key: Char);
    procedure edVlrJurKeyPress(Sender: TObject; var Key: Char);
    procedure edPerJurKeyPress(Sender: TObject; var Key: Char);
    procedure edVlrMulKeyPress(Sender: TObject; var Key: Char);
    procedure edPerMulKeyPress(Sender: TObject; var Key: Char);
    procedure edVlrtitKeyPress(Sender: TObject; var Key: Char);
    procedure edPessoaCustomButtons1Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
    AuxChaPix: String;
    function CheckForDuplicates(recMemTitu:TVirtualTable):Boolean;
    procedure AcertaCampos;
    procedure AcertaDados;
    procedure BuscaChavePix;
    procedure BuscaFilial;
    procedure AcertaCodBar;
    procedure validaCodBar;
  public
    { Public declarations }
    retIDTitu:Integer;
  end;

var
   FrmMulTit: TFrmMulTit;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uBuscaPes, uPessoasCad;

procedure TFrmMulTit.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmMulTit.FormShow(Sender: TObject);
begin
   retIDTitu := 0;
   edDatemi.Date     := Date;
   edDataBase.Date   := Date;
   edDesAce.AsFloat  := 0.00;
   edDesAsso.AsFloat := 0.00;
   BuscaFilial;
   AcertaCampos;
end;

procedure TFrmMulTit.MemTituBeforePost(DataSet: TDataSet);
begin
   if (MemTituNrotit.AsString.Trim = '') or (MemTituDatven.AsDateTime <= 0) or (MemTituVlrtit.AsFloat <= 0.00) then MemTitu.Cancel;
end;

procedure TFrmMulTit.MemTituCalcFields(DataSet: TDataSet);
begin
   MemTituSaltit.Value := MemTituVlrtit.Value + edDesAce.AsFloat + MemTituDesAsso.AsFloat;
end;

// Acerta os componentes que podem ser editados ou não //
procedure TFrmMulTit.AcertaCampos;
begin
     // A pagar
   if RadioPag.Checked then
   begin
       //  0 = nenhum selecionado, 4 = NOTA FISCAL, 5 = CHEQUE, 6 = NOTA PROMISSÓRIA
       //  7 = DEPÓSITO EM CONTA, 8 = DÉBITO AUTOMÁTICO, 9 = PIX, 10 = PIX QR CODE
       // 11 = CREDITO EM CONTA CORRENTE, 12 = ORDEM PAGAMENTO, 13 = TED
      if edTiptit.Tag in [0,4,5,6,7,8,9,10,11,12,13] then
      begin
         edVlrJur.Color := $00F5F5F5;
         edPerJur.Color := $00F5F5F5;
         edVlrMul.Color := $00F5F5F5;
         edPerMul.Color := $00F5F5F5;
         edVlrJur.Enabled := False;
         edPerJur.Enabled := False;
         edVlrMul.Enabled := False;
         edPerMul.Enabled := False;
         dgDados.Columns[6].ReadOnly := True; // Nosso número
         if edTiptit.Tag = 10 then
         begin
            dgDados.Columns[7].Title.Caption := 'CHAVE PIX QR CODE';
            dgDados.Columns[7].ReadOnly      := False; // Código de barras
            dgDados.Columns[7].FieldName     := 'ChavePIXQRCode';
         end
         else
         begin
            dgDados.Columns[7].Title.Caption := 'CÓDIGO BARRAS';
            dgDados.Columns[7].ReadOnly      := True; // Código de barras
            dgDados.Columns[7].FieldName     := 'CodBar';
         end;
      end; // if
      // 1 = BOLETO BANCARIO PROPRIO BANCO, 2 = BOLETO BANCARIO OUTRO BANCO
      // 3 = BOLETO TRIBUTOS IMPOSTOS, 14 = DARF NORMAL
      // 15 = DARF SIMPLES, 16 = GPS GUIA PREVIDENCIA SOCIAL
      if edTiptit.Tag in [1,2,3,14,15,16] then
      begin
         edVlrJur.Color := clWhite;
         edPerJur.Color := clWhite;
         edVlrMul.Color := clWhite;
         edPerMul.Color := clWhite;
         edVlrJur.Enabled := True;
         edPerJur.Enabled := True;
         edVlrMul.Enabled := True;
         edPerMul.Enabled := True;
         dgDados.Columns[6].ReadOnly := False; // Nosso número
         dgDados.Columns[7].ReadOnly := False; // Código de barras
         dgDados.Columns[7].Title.Caption := 'CÓDIGO BARRAS';
         dgDados.Columns[7].FieldName     := 'CodBar';
      end; // if
   end // if
   else if RadioRec.Checked then
   begin
      // 1 = BOLETO BANCARIO PROPRIO BANCO, 2 = BOLETO BANCARIO OUTRO BANCO
      if (edTiptit.Tag = 1) or (edTiptit.Tag = 2) then
      begin
         edVlrJur.Color := clWhite;
         edPerJur.Color := clWhite;
         edVlrMul.Color := clWhite;
         edPerMul.Color := clWhite;
         edVlrJur.Enabled := True;
         edPerJur.Enabled := True;
         edVlrMul.Enabled := True;
         edPerMul.Enabled := True;
         dgDados.Columns[6].ReadOnly := False; // Nosso número
         dgDados.Columns[7].ReadOnly := False; // Código de barras
         dgDados.Columns[7].Title.Caption := 'CÓDIGO BARRAS';
         dgDados.Columns[7].FieldName     := 'CodBar';
      end // if
      else
      begin
         edVlrJur.Color := $00F5F5F5;
         edPerJur.Color := $00F5F5F5;
         edVlrMul.Color := $00F5F5F5;
         edPerMul.Color := $00F5F5F5;
         edVlrJur.Enabled := False;
         edPerJur.Enabled := False;
         edVlrMul.Enabled := False;
         edPerMul.Enabled := False;
         dgDados.Columns[6].ReadOnly := True; // Nosso número
         dgDados.Columns[7].ReadOnly := True; // Código de barras
         dgDados.Columns[7].Title.Caption := 'CÓDIGO BARRAS';
         dgDados.Columns[7].FieldName     := 'CodBar';
      end; // if
   end; // if
end;

procedure TFrmMulTit.AcertaCodBar;
begin
   if not MemTitu.Active then Exit;
   MemTitu.First;
   while not MemTitu.Eof do
   begin
      MemTitu.Edit;
      MemTituNosNum.AsString := '';
      MemTituCodBar.AsString := '';
      MemTituChavePIXQRCode.AsString := '';
      MemTitu.Post;
      MemTitu.Next;
   end;
end;

procedure TFrmMulTit.AcertaDados;
var
   i,Tam: Integer;
   Texto:String;
begin
   MemTitu.Edit;
     // A pagar
   if RadioPag.Checked then
   begin
       //  0 = nenhum selecionado, 4 = NOTA FISCAL, 5 = CHEQUE, 6 = NOTA PROMISSÓRIA
       //  7 = DEPÓSITO EM CONTA, 8 = DÉBITO AUTOMÁTICO, 9 = PIX
       // 11 = CREDITO EM CONTA CORRENTE, 12 = ORDEM PAGAMENTO, 13 = TED
      if (edTiptit.Tag = 0) or (edTiptit.Tag = 4) or
         (edTiptit.Tag = 5) or (edTiptit.Tag = 6) or
         (edTiptit.Tag = 7) or (edTiptit.Tag = 8) or
         (edTiptit.Tag = 9) or (edTiptit.Tag = 11) or
         (edTiptit.Tag = 12) or (edTiptit.Tag = 13) then
      begin
         MemTituCodBar.AsString := '';
         MemTituNosNum.AsString := '';
         MemTituChavePIXQRCode.AsString := '';
      end;
   end  // if
   else if RadioRec.Checked then
   begin
      // 1 = BOLETO BANCARIO PROPRIO BANCO, 2 = BOLETO BANCARIO OUTRO BANCO
      if not ((edTiptit.Tag = 1) or (edTiptit.Tag = 2)) then
      begin
         MemTituCodBar.AsString := '';
         MemTituNosNum.AsString := '';
      end; // if
      MemTituChavePIXQRCode.AsString := '';
   end; // if
end;

procedure TFrmMulTit.AjustaGrid;
begin
   TStringGrid(dgDados).DefaultRowHeight := 21;
   dgDados.Width := dgDados.Width - 10;
   dgDados.Width := dgDados.Width + 10;
   edPessoa.SetFocus;
end;

procedure TFrmMulTit.dgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmMulTit.edChaPixKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edDataBaseKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edDatemiKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edDesAceKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edDesAssoKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edDiaVenKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmMulTit.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',Key,True);
end;

procedure TFrmMulTit.edFilialKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edHistKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqnatfin',TLMDEdit(edNatFin),'IDNatFin','Desnat','',0,True);
end;

procedure TFrmMulTit.edNatFinKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqnatfin',TLMDEdit(edNatFin),'IDNatFin','Desnat','',Key,True);
end;

procedure TFrmMulTit.edNatFinKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edNotFisKeyPress(Sender: TObject; var Key: Char);
begin
   if (key in ['0'..'9'] = False) and (Word(key) <> VK_BACK) and (Word(key) <> VK_RETURN) and (Word(key) <> VK_TAB) then
      key := #0;
end;

procedure TFrmMulTit.edNroParKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edPerJurKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edPerMulKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
var
   auxRecIDPess:Integer;
begin
   Self.AlphaBlendValue := 165;
   Application.CreateForm(TFrmPesCad, FrmPesCad);
   try
      if edPessoa.Tag > 0 then
           FrmPesCad.recIDPess := edPessoa.Tag
      else FrmPesCad.recIDPess := 0;
      CentralizarControl(FrmPesCad, FrmMulTit);
      FrmPesCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxRecIDPess := FrmPesCad.recIDPess;
      FrmPesCad := nil;
      BuscaChavePix;
   end;// try
end;

procedure TFrmMulTit.edPessoaCustomButtons1Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   edPessoa.SetFocus;
   try
      edPessoa.Tag := 0;
      FrmBuscaPes := TFrmBuscaPes.Create(Application);
      with FrmBuscaPes do
      begin
         lPoint := Self.edPessoa.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edPessoa.Width;
         edRetorno := TLMDEdit(Self.edPessoa);
         edBusca.Text := Self.edPessoa.Text;
         ShowModal;
      end; // with
   finally
      FrmBuscaPes.Free;
   end;
end;

procedure TFrmMulTit.edPessoaExit(Sender: TObject);
begin
   BuscaChavePix;
end;

procedure TFrmMulTit.edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then edPessoaCustomButtons0Click(Sender, 0);
   if (ssCtrl in Shift) or (IsNumeric(Copy(TLMDEdit(Sender).Text.Trim,1,3))) then Exit;
   btBuscas('arqpessoa',TLMDEdit(Sender),'IDPess','Nompes','',Key);
end;

procedure TFrmMulTit.edPessoaKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edTiptitCustomButtons0Click(Sender: TObject; index: Integer);
begin
   edTiptit.SetFocus;
   btBuscas('arqtiptitu',TLMDEdit(edTiptit),'IDTiptit','DesTiptit','',0,True);
   AcertaCampos;
end;

procedure TFrmMulTit.edTiptitExit(Sender: TObject);
begin
   AcertaCampos;
   BuscaChavePix;
   AcertaCodBar;
end;

procedure TFrmMulTit.edTiptitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqtiptitu',TLMDEdit(edTiptit),'IDTiptit','DesTiptit','',Key,True);
end;

procedure TFrmMulTit.edTiptitKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edVlrJurKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edVlrMulKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

procedure TFrmMulTit.edVlrtitKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(Sender as TWinControl, True, True);
   end;
end;

// ------------- Geração dos Títulos ------------ //
procedure TFrmMulTit.btGerarClick(Sender: TObject);
const
   Letras:String = 'ABCDEFGHIJKLMNOPQRTUVWXZ';
var
   VlrParc,VlrJur,PerJur,VlrMul,PerMul:Double;
   DatVenAnt:TDate;
   Ano,Mes,Dia:Word;
   I,Nro,AcLet:Integer;
   Par,LetraAtu:String;
begin
   if edTiptit.Tag = 0 then
   begin
      MostraMsg('Aviso','Favor escolher um tipo de titulo!', mtWarning, [mbOk]);
      edTiptit.SetFocus;
      Exit;
   end;
   if Trim(edNrotit.Text) = '' then
   begin
      MostraMsg('Aviso','Favor entrar com o número do título!', mtWarning, [mbOk]);
      edNrotit.SetFocus;
      Exit;
   end;
   if edPessoa.Tag = 0 then
   begin
      MostraMsg('Aviso','Favor escolher uma pessoa!', mtWarning, [mbOk]);
      edPessoa.SetFocus;
      Exit;
   end;
   if edNatFin.Tag = 0 then
   begin
      MostraMsg('Aviso','Favor escolher uma natureza financeira!', mtWarning, [mbOk]);
      edNatFin.SetFocus;
      Exit;
   end;
   if edFilial.Tag = 0 then
   begin
      MostraMsg('Aviso','Favor escolher uma filial!', mtWarning, [mbOk]);
      edFilial.SetFocus;
      Exit;
   end;
   if edVlrtit.AsFloat <= 0 then
   begin
      MostraMsg('Aviso','Favor entrar com o valor da parcela!', mtWarning, [mbOk]);
      edVlrtit.SetFocus;
      Exit;
   end;
   if edNroPar.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','Favor entrar com a quantidade de parcelas!', mtWarning, [mbOk]);
      edNroPar.SetFocus;
      Exit;
   end;
   if edDiaVen.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','Favor entrar com os dias para vencimento!', mtWarning, [mbOk]);
      edDiaVen.SetFocus;
      Exit;
   end;
   if edDiaVen.AsInteger > 30 then
   begin
      MostraMsg('Aviso','Favor entrar até o dia 30.', mtWarning, [mbOk]);
      edDiaVen.SetFocus;
      Exit;
   end;
   if edDataBase.Date = 0 then
   begin
      MostraMsg('Aviso','Favor entrar com o 1º vencimento!', mtWarning, [mbOk]);
      edDataBase.SetFocus;
      Exit;
   end;
   if (edTiptit.Tag = 9) and (edPessoa.Tag <> 0) and (edChaPix.Text = '') then
   begin
      MostraMsg('Aviso','Não foi encontrada chave PIX para está pessoa!'+#13+
                'Favor informar a chave Pix no Cadastro de Pessoa em Dados Financeiros',mtWarning, [mbOk]);
      edPessoa.SetFocus;
      Exit;
   end;
   AcLet    := 0;
   LetraAtu := '';
   VlrParc  := edVlrtit.AsFloat;
   VlrJur   := edVlrJur.AsFloat;
   PerJur   := edPerJur.AsFloat;
   VlrMul   := edVlrMul.AsFloat;
   PerMul   := edPerMul.AsFloat;
//   if edDiaVen.AsInteger > 0 then
//   begin
//      DecodeDate(edDataBase.Date,Ano,Mes,Dia);
//      if (Mes = 2) and (edDiaVen.AsInteger >= 28) then
//           Dia := Word(28)
//      else Dia := Word(edDiaVen.AsInteger);
//      DatVenAnt := EncodeDate(Ano, Mes, Dia);
//   end
//   else DatVenAnt := edDataBase.Date;
   DatVenAnt := edDataBase.Date;
   MemTitu.Clear;
   MemTitu.Open;
   for I := 1 to edNroPar.AsInteger do
   begin
      if I > 99 then
      begin
         Nro := StrToInt(Copy(I.ToString,3,1));
         if Nro = 0 then
         begin
            Inc(AcLet);
            LetraAtu := Copy(Letras,AcLet,1);
         end;
         Par := LetraAtu+Nro.ToString;
      end
      else Par := StrZero(I.ToString,2);
      MemTitu.Append;
      MemTituIDTiptit.AsInteger := edTiptit.Tag;
      MemTituNrotit.AsString    := Trim(edNrotit.Text);
      MemTituDestit.AsString    := Par;
      MemTituDatemi.AsDateTime  := edDatemi.Date;
      MemTituDatven.AsDateTime  := DatVenAnt;
      MemTituVlrtit.AsFloat     := VlrParc;
      MemTituVlrJur.AsFloat     := VlrJur;
      MemTituPerJur.AsFloat     := PerJur;
      MemTituVlrMul.AsFloat     := VlrMul;
      MemTituPerMul.AsFloat     := PerMul;
      MemTituNosNum.AsString    := '';
      MemTituCodBar.AsString    := '';
      MemTituChaPix.AsString    := AuxChaPix;
      if edDiaVen.AsInteger > 0 then
      begin
         DatVenAnt := IncMonth(DatVenAnt,1);
         DecodeDate(DatVenAnt,Ano,Mes,Dia);
         if (Mes = 2) and (edDiaVen.AsInteger >= 28) then
              Dia := Word(28)
         else Dia := Word(edDiaVen.AsInteger);
         DatVenAnt := EncodeDate(Ano,Mes,Dia);
      end
      else DatVenAnt := IncDay(DatVenAnt,edDiaVen.AsInteger);
   end; //for
   MemTitu.First;
   AjustaGrid;
   dgDados.SetFocus;
end;

procedure TFrmMulTit.validaCodBar;
var
   auxCodBar,auxTexto:String;
   auxCarac:Char;
   I:Integer;
begin
   MemTitu.First;
   while not MemTitu.Eof do
   begin
      // Acerta código de barras
      auxTexto  := MemTituCodBar.AsString.Trim;
      auxCodBar := '';
      for I := 1 to Length(auxTexto) do
      begin
         auxCarac := auxTexto[I];
         if (auxCarac in ['0'..'9']) then
         begin
            auxCodBar := auxCodBar + auxCarac;
         end;
      end;
      MemTitu.Edit;
      MemTituCodBar.AsString := auxCodBar;
      // Acerta PIX QRCODE
      auxTexto  := MemTituChavePIXQRCode.AsString.Trim;
      auxCodBar := '';
      for I := 1 to Length(auxTexto) do
      begin
         auxCarac := auxTexto[I];
         if (auxCarac in ['0'..'9']) then
         begin
            auxCodBar := auxCodBar + auxCarac;
         end;
      end;
      MemTitu.Edit;
      MemTituChavePIXQRCode.AsString := auxCodBar;
      MemTitu.Next;
   end;
end;

procedure TFrmMulTit.btSalvarClick(Sender: TObject);
var
   I:Integer;
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   btSalvar.SetFocus;
   if MemTitu.RecordCount = 0 then
   begin
      MostraMsg('Aviso','Não existem título à gerar!', mtWarning, [mbOk]);
      Exit;
   end; //if

   if (MemTituIDTiptit.AsInteger = 1) or (MemTituIDTiptit.AsInteger = 2) then
   begin
      if MemTituCodBar.AsString = '' then
      begin
         MostraMsg('Código barras informado não está correto','Favor preencher corretamente !',mtWarning, [mbOk]);
         dgDados.SetFocus;
         Exit;
      end;// if
   end;// if

   if MemTituIDTiptit.AsInteger = 9 then
   begin
      if edChaPix.Text = '' then
      begin
         MostraMsg('Código da chave pix informado não está correto','Favor preencher corretamente !',mtWarning, [mbOk]);
         edPessoa.SetFocus;
         Exit;
      end;// if
   end;// if

   if MemTituIDTiptit.AsInteger = 10 then
   begin
      if MemTituChavePIXQRCode.AsString = '' then
      begin
         MostraMsg('Código da chave pix QR CODE informado não está correto','Favor preencher corretamente !',mtWarning, [mbOk]);
         dgDados.SetFocus;
         Exit;
      end;// if
   end;// if
   // Aqui tira os espaços em branco e pontos que tiverem no código de barras ou PIX QRCODE
   validaCodBar;

   if CheckForDuplicates(MemTitu) then
   begin
      MostraMsg('Aviso','Não podem exister título com o mesmo Nro.Docto e parcela!', mtWarning, [mbOk]);
      Exit;
   end; //if
   if MostraMsg('Confirmação','Confirma salvamento?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         MemTitu.First;
         while not MemTitu.Eof do
         begin
            with QueAuxi do
            begin
               QueAuxi.Close;
               SQL.Text := 'SELECT 1 FROM arqtitulo WHERE IDPess = '+edPessoa.Tag.ToString+' AND '+
               'Nrotit = '+Aspas(MemTituNrotit.AsString.Trim)+' AND Destit = '+Aspas(MemTituDestit.AsString.Trim);
               QueAuxi.Open;
               if not IsEmpty then
               begin
                  MostraMsg('Aviso','Já existe título para essa Pessoa com esse Número/Parcela!', mtWarning, [mbOk]);
                  edNrotit.SetFocus;
                  Exit;
               end;
            end; //with
            MemTitu.Next;
         end; //while
         QueAuxi.Close;
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Text := 'INSERT INTO arqtitulo (IDPess,IDFilial,PagRec,Nrotit,Destit,NotFis,Vlrtit,Saltit,DesAsso,VlrAces,Datemi,Datven,'+
                             'IDTiptit,ValorJuros,ValorMulta,PercenJuros,PercenMulta,CodBarra,ChavePIXQRCode,IDNatFin) VALUES ';
         MemTitu.First;
         while not MemTitu.Eof do
         begin
            AcertaDados;
            QueAuxi.SQL.Add('('+
            edPessoa.Tag.ToString+','+
            iif(edFilial.Tag > 0,edFilial.Tag.ToString,'null')+','+
            Aspas(iif(RadioPag.Checked,'P','R'))+','+
            Aspas(MemTituNrotit.AsString)+','+
            Aspas(MemTituDestit.AsString)+','+
            iif(edNotfis.Text.Trim <> '', Aspas(edNotfis.Text.Trim),'null')+','+
            FormatDouble(MemTituVlrtit.AsFloat,11,2)+','+
            FormatDouble(MemTituSaltit.AsFloat,11,2)+','+
            FormatDouble(edDesAsso.AsFloat,11,2)+','+
            FormatDouble(edDesAce.AsFloat, 11,2)+','+
            Aspas(FormatDateTime('yyyy-mm-dd',MemTituDatemi.AsDateTime))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',MemTituDatven.AsDateTime))+','+
            edTiptit.Tag.ToString+','+
            FormatDouble(MemTituVlrJur.AsFloat,11,2)+','+
            FormatDouble(MemTituVlrMul.AsFloat,11,2)+','+
            FormatDouble(MemTituPerJur.AsFloat,11,2)+','+
            FormatDouble(MemTituPerMul.AsFloat,11,2)+','+
            Aspas(MemTituCodBar.AsString)+','+
            Aspas(MemTituChavePIXQRCode.AsString)+','+
            iif(edNatFin.Tag > 0, edNatFin.Tag.ToString,'null')+'),');
            MemTitu.Next;
         end; //while
         QueAuxi.SQL.Text := Copy(QueAuxi.SQL.Text,1,LastDelimiter(',',QueAuxi.SQL.Text)-1)+';';
         QueAuxi.ExecSQL(vErro);
         if vErro <> '' then
         begin
            MostraMsg('Erro','Não foi possível concluir.'+#10+vErro, mtError, [mbOk]);
            Exit;
         end;
      except
         on E:Exception do
         begin
            MostraMsg('Erro','Não foi possível salvar.'+#10+E.Message, mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   MostraMsg('Aviso','Geração concluída com sucesso!', mtInformation,[mbOk]);
   Self.Close;
end;

procedure TFrmMulTit.BuscaChavePix;
var
   QuePess:TRESTDWClientSQL;
begin
   if (edTiptit.Tag = 9) and (edPessoa.Tag <> 0) then
   begin
      QuePess := TRESTDWClientSQL.Create(nil);
      try
         QuePess.DataBase := DM.DWDataBase;
         QuePess.SQL.Text := 'SELECT * FROM arqpessbanc WHERE IDPess = '+edPessoa.Tag.ToString;
         QuePess.Open;
         if QuePess.IsEmpty then
         begin
            MostraMsg('Aviso','Não foi encontrada chave PIX para está pessoa!'+#13+
                      'Favor informar a chave Pix no Cadastro de Pessoa em Dados Financeiros',mtWarning, [mbOk]);
            edChaPix.Text := '';
            Exit;
         end;
         edChaPix.Text := QuePess.FieldByName('IDPix').AsString;
      finally
         QuePess.Close;
         FreeAndNil(QuePess);
      end;
   end
   else
      edChaPix.Text := '';
end;

procedure TFrmMulTit.BuscaFilial;
var
   QueFilial:TRESTDWClientSQL;
begin
   QueFilial := TRESTDWClientSQL.Create(nil);
   try
      QueFilial.DataBase := DM.DWDataBase;
      QueFilial.SQL.Text := 'SELECT * FROM arqfilial WHERE IDFilial = '+FILIAL.ToString;
      QueFilial.Open;
      if QueFilial.IsEmpty then
      begin
         MostraMsg('Aviso','Não foi encontrada Filial',mtWarning, [mbOk]);
         Exit;
      end;
      edFilial.Tag  := FILIAL;
      edFilial.Text := QueFilial.FieldByName('Nomfil').AsString;
   finally
      QueFilial.Close;
      FreeAndNil(QueFilial);
   end;
end;

// ------- Verifica se há Registros Duplicatos (Nrotit,destit) da MemTitu ------- //
function TFrmMulTit.CheckForDuplicates(recMemTitu:TVirtualTable):Boolean;
var
   RecordDictionary: TDictionary<string, Integer>;
   Nrotit,Destit:String;
   RecordKey:String;
begin
   RecordDictionary := TDictionary<string,Integer>.Create;
   try
      Result := False;
      recMemTitu.First;
      while not recMemTitu.Eof do
      begin
         Nrotit := recMemTitu.FieldByName('Nrotit').AsString;
         Destit := recMemTitu.FieldByName('Destit').AsString;
         RecordKey := Nrotit+'|'+Destit;
         if RecordDictionary.ContainsKey(RecordKey) then
         begin
            Result := True;
            Break;
         end
         else RecordDictionary.Add(RecordKey,1);
         recMemTitu.Next;
      end; //while
   finally
      RecordDictionary.Free;
   end;
end;

procedure TFrmMulTit.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmMulTit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if MemTitu.Active then MemTitu.Close;
end;

end.
