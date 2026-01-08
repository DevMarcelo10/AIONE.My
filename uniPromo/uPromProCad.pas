unit uPromProCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDBaseControl, LMDBaseLabel,
  LMDCustomLabel, LMDLabel, LMDControl, LMDBaseGraphicControl, MarcLib,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel,
  LMDCustomMaskEdit, LMDMaskEdit, AdvGlowButton, Vcl.ExtCtrls, Vcl.StdCtrls,
  LMDCustomExtCombo, uRESTDWBasicDB, LMDCustomListComboBox, LMDListComboBox;

type
  TFrmPromoCadPro = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel6: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    Label15: TLMDLabel;
    edCodpro: TLMDEdit;
    edNompro: TLMDLabeledEdit;
    edEstoque: TLMDMaskEdit;
    LMDLabel7: TLMDLabel;
    LMDLabel8: TLMDLabel;
    btSalvar: TAdvGlowButton;
    btFechar: TAdvGlowButton;
    Shape1: TShape;
    edPerDesc: TLMDMaskEdit;
    LMDLabel10: TLMDLabel;
    edUltcus: TLMDMaskEdit;
    edCusmed: TLMDMaskEdit;
    edPVenda: TLMDMaskEdit;
    LMDLabel9: TLMDLabel;
    edPreProm: TLMDMaskEdit;
    LMDLabel11: TLMDLabel;
    edDescIA: TLMDMaskEdit;
    btExcluir: TAdvGlowButton;
    edLote: TLMDLabeledListComboBox;
    procedure btFecharClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure edCodproKeyPress(Sender: TObject; var Key: Char);
    procedure edCodproExit(Sender: TObject);
    procedure edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edLoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPerDescKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPerDescExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function BuscaProd(recAuxProd: String): Boolean;
  public
    { Public declarations }
    recDescIA,recDescMA:Double;
    recIDProm,recIDProd:Integer;
  end;

var
  FrmPromoCadPro: TFrmPromoCadPro;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmPromoCadPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromoCadPro.FormShow(Sender: TObject);
begin
   if recIDProd > 0 then
   begin
      edCodpro.Text := recIDProd.ToString;
      edCodproExit(Self);
      edPerDesc.SetFocus;
   end
   else edCodpro.SetFocus;
end;

procedure TFrmPromoCadPro.edCodproExit(Sender: TObject);
var
   auxProd:String;
begin
   edNompro.Clear;
   edNompro.Tag := 0;
   edLote.Text  := '';
   auxProd      := Trim(edCodpro.Text);
   if auxProd = '' then Exit;
   BuscaProd(auxProd);
end;

procedure TFrmPromoCadPro.edCodproKeyPress(Sender: TObject; var Key: Char);
begin
   if ExisteStr(Key) then Key := #0;
end;

procedure TFrmPromoCadPro.edLoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then edLote.ItemIndex := -1;
   edLote.SetFocus;
end;

procedure TFrmPromoCadPro.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','',0);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      BuscaProd(edCodpro.Text);
   end
   else edCodpro.Text := '';
end;

procedure TFrmPromoCadPro.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','',Key);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      BuscaProd(edCodpro.Text);
   end
   else edCodpro.Text := '';
end;

procedure TFrmPromoCadPro.edPerDescExit(Sender: TObject);
begin
   if (edPerDesc.AsFloat <> 0.00) and (edPVenda.AsFloat > 0.00) then
   begin
      if (edPerDesc.AsFloat < 0.00) or (edPerDesc.AsFloat >= 100.00) then
      begin
         MostraMsg('Aviso','Percentual inválido!', mtWarning, [mbOK]);
         edPerDesc.SetFocus;
         Exit;
      end;
      edPreProm.AsFloat := RoundX(edPVenda.AsFloat - (edPVenda.AsFloat * (edPerDesc.AsFloat/100)),2);
   end;
end;

procedure TFrmPromoCadPro.edPerDescKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = 13 then btSalvar.Click;
end;

function TFrmPromoCadPro.BuscaProd(recAuxProd:String):Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := True;
   edDescIA.AsFloat  := 0.00;
   edPVenda.AsFloat  := 0.00;  edUltcus.AsFloat  := 0.00;
   edCusmed.AsFloat  := 0.00;  edPerDesc.AsFloat := 0.00;
   edEstoque.AsFloat := 0.00;  edPreProm.AsFloat := 0.00;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT PRO.IDProd,PRO.Despro,PRO.PrecoVen,PRO.CustoMed,COALESCE(SUM(LOT.Qtdest), 0) AS Qtdest FROM arqproduto PRO ';
         SQL.Add('LEFT JOIN arqprodutolot LOT ON PRO.IDProd = LOT.IDProd WHERE ');
         SQL.Add(iif(recAuxProd.Length < 13, 'PRO.IDProd'+' = '+recAuxProd,'PRO.CodEAN'+' = '+Aspas(recAuxProd)));
         SQL.Add(iif(edLote.Text.Trim <> '',' AND '+edLote.Text.Trim,'')+' GROUP BY PRO.IDProd');
         QueAuxi.Open;

         if IsEmpty then
         begin
            MostraMsg('Aviso','Produto não encontrado!', mtWarning, [mbOK]);
            edCodpro.SetFocus;
            Result := False;
            Exit;
         end else
         begin
            edNompro.Tag      := FieldByName('IDProd').AsInteger;
            edNompro.Text     := FieldByName('Despro').AsString;
            edPVenda.AsFloat  := FieldByName('PrecoVen').AsFloat;
            edCusmed.AsFloat  := FieldByName('CustoMed').AsFloat;
            edEstoque.AsFloat := FieldByName('Qtdest').AsFloat;
            edUltcus.AsFloat  := 0.00;
         end; //if

         edDescIA.AsFloat  := recDescIA;
         edPerDesc.AsFloat := recDescMA;

         QueAuxi.Close;
         SQL.Text := 'SELECT COALESCE(ITE.Vlruni,0) AS Vlruni FROM arqcomprarecite ITE JOIN arqcomprarec REC '+
         'ON ITE.IDRec = REC.IDRec WHERE ITE.IDProd = '+edNompro.Tag.ToString+' ORDER BY REC.DatRece DESC LIMIT 1';
         QueAuxi.Open;
         if not IsEmpty then
         begin
            if FieldByName('Vlruni').AsString <> '' then
               edUltcus.AsFloat := FieldByName('Vlruni').AsFloat;
         end; //if

         edLote.ItemIndex := -1;
         edLote.Clear;
         QueAuxi.Close;
         SQL.Text := 'SELECT Nrolot,Qtdest FROM arqprodutolot WHERE IDProd = '+edNompro.Tag.ToString;
         QueAuxi.Open;
         while not Eof do
         begin
            edLote.Items.Add(FieldByName('Nrolot').AsString.Trim+'  |  '+Trim(FieldByName('Qtdest').AsString));
            Next;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmPromoCadPro.btSalvarClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   auxNrolot,auxQtdest:String;
begin
   PanelTop.SetFocus;
   if edNompro.Tag <= 0 then
   begin
      MostraMsg('Produto não informado', 'Favor escolher um produto!',mtWarning, [mbOK]);
      edCodpro.SetFocus;
      Exit;
   end;
   if (edPerDesc.AsFloat <= 0.00) and (recDescIA <= 0.00) then
   begin
      MostraMsg('Valor não informado', 'Favor entar com % desconto!',mtWarning, [mbOK]);
      edPerDesc.SetFocus;
      Exit;
   end;
   if edPerDesc.AsFloat >= 100.00 then
   begin
      MostraMsg('Aviso','Percentual inválido!', mtWarning, [mbOK]);
      edPerDesc.SetFocus;
      Exit;
   end;
   if edPerDesc.AsFloat = recDescIA then
   begin
      MostraMsg('Erro no Desconto', 'Desconto está igual ao Desconto da IA.',mtWarning, [mbOK]);
      edPerDesc.AsFloat := 0.00;
      edPerDesc.SetFocus;
      Exit;
   end; //if
   if (edPerDesc.AsFloat <> 0.00) and (edPVenda.AsFloat > 0.00) then
   begin
      if (edPerDesc.AsFloat < 0.00) or (edPerDesc.AsFloat >= 100.00) then
      begin
         MostraMsg('Aviso','Percentual inválido!', mtWarning, [mbOK]);
         edPerDesc.SetFocus;
         Exit;
      end;
      edPreProm.AsFloat := RoundX(edPVenda.AsFloat - (edPVenda.AsFloat * (edPerDesc.AsFloat/100)),2);
   end;

   edPreProm.AsFloat := RoundX(edPVenda.AsFloat - (edPVenda.AsFloat * (edPerDesc.AsFloat/100)),2);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      try
         if Trim(edLote.Text) <> '' then
         begin
            auxNrolot := Trim(Copy(edLote.Text,1,AnsiPos('|',edLote.Text)-1));
            auxQtdest := Trim(Copy(edLote.Text,AnsiPos('|',edLote.Text)+1,8));
            if auxQtdest = '' then auxQtdest := '0.00';
         end else
         begin
            auxNrolot := '';
            auxQtdest := FloatToStr(edEstoque.AsFloat);
         end;
         auxQtdest := StringReplace(auxQtdest,',','.',[rfReplaceAll]);
         QueAuxi.DataBase := DM.DWDataBase;
         QueAuxi.SQL.Text := 'INSERT INTO arqpromopro (IDProm,IDProd,Nrolot,PrecoVen,Cusmed,UltPreCom,PerDesMan,PrePromo,Qtdest,IndSel) VALUES ('+
         recIDProm.ToString+','+edNompro.Tag.ToString+','+Aspas(auxNrolot)+','+FormatDouble(edPVenda.AsFloat,10,2)+','+
         FormatDouble(edCusmed.AsFloat, 10,2)+','+FormatDouble(edUltcus.AsFloat, 10,2)+','+
         FormatDouble(edPerDesc.AsFloat,10,2)+','+FormatDouble(edPreProm.AsFloat,10,2)+','+auxQtdest+','+Aspas('0')+')';
         QueAuxi.SQL.Add('ON DUPLICATE KEY UPDATE PrecoVen = VALUES(PrecoVen), Cusmed = VALUES(Cusmed), ');
         QueAuxi.SQL.Add('UltPreCom = VALUES(UltPreCom), PerDesMan = VALUES(PerDesMan), PrePromo = VALUES(PrePromo);');
         QueAuxi.ExecSQL;
         if recIDProd <= 0 then
         begin
            edCodpro.Clear;
            edNompro.Clear;              edLote.ItemIndex  := -1;
            edNompro.Tag      := 0;      edPreProm.AsFloat := 0.00;
            edPVenda.AsFloat  := 0.00;   edEstoque.AsFloat := 0.00;
            edCusmed.AsFloat  := 0.00;   edUltcus.AsFloat  := 0.00;
            edDescIA.AsFloat  := 0.00;   edPerDesc.AsFloat := 0.00;
            edCodpro.SetFocus;
         end; //if
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível salvar arqpromopro em uPromProCad -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end;
   finally
      FreeAndNil(QueAuxi);
      if recIDProd > 0 then Self.Close;
   end;
end;

procedure TFrmPromoCadPro.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromoCadPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
