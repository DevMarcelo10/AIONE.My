unit uPerdasInc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, LMDBaseEdit, LMDCustomEdit, LMDDBEdit,
  LMDButtonControl, LMDRadioButton, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxDBCtrl, LMDThemedComboBox, LMDCustomComboBox,
  LMDComboBox, AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
  Vcl.ExtCtrls, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDCustomMaskEdit,
  LMDCustomExtCombo, LMDComboBoxExt, Datasnap.DBClient, Marclib, uRESTDWBasicDB, LMDCustomListComboBox, LMDListComboBox;

type
  TFrmPerdasInc = class(TForm)
    PanelPri: TLMDSimplePanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    PanelCabecalho: TLMDSimplePanel;
    LabelCab: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelPdrIte: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelProduto: TLMDSimplePanel;
    PanelRodape: TLMDSimplePanel;
    btConfirma: TAdvGlowButton;
    btProdutos: TAdvGlowButton;
    btIncPro: TAdvGlowButton;
    btAltPro: TAdvGlowButton;
    btExcPro: TAdvGlowButton;
    btCanPro: TAdvGlowButton;
    btSalPro: TAdvGlowButton;
    lbDataPerda: TLMDLabel;
    lbDataVenc: TLMDLabel;
    edNroNota: TLMDDBLabeledEdit;
    edDesPro: TLMDDBLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    edDataPerda: TDBDateEdit;
    edStatus: TLMDDBLabeledEdit;
    edRegMS: TLMDDBLabeledEdit;
    edQuant: TLMDDBLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataVenc: TDBDateEdit;
    edNrolot: TLMDDBLabeledEdit;
    SouPerdas: TDataSource;
    cdsPerdas: TClientDataSet;
    cdsPerdasIDPerda: TIntegerField;
    cdsPerdasIDFilial: TIntegerField;
    cdsPerdasIDProd: TIntegerField;
    cdsPerdasNroLot: TWideStringField;
    cdsPerdasDataPerda: TDateField;
    cdsPerdasMotivo: TWideStringField;
    cdsPerdasQtdPer: TFloatField;
    cdsPerdasNroNot: TIntegerField;
    cdsPerdasStatus: TWideStringField;
    cdsPerdasDesPro: TWideStringField;
    cdsPerdasRegistroMS: TWideStringField;
    cdsLote: TClientDataSet;
    DBGrid2: TDBGrid;
    cdsLoteIDProd: TIntegerField;
    cdsLoteNroLot: TWideStringField;
    cdsLoteQtdLote: TFloatField;
    SouLote: TDataSource;
    cdsLoteQtdPerda: TFloatField;
    cdsLoteDatVenc: TDateField;
    cdsPerdasIDInvIni: TIntegerField;
    cdsPerdasUsoRece: TWideStringField;
    cdsLoteUsoRece: TWideStringField;
    cdsPerdasDataVenc: TDateField;
    ComboMotivo: TLMDLabeledListComboBox;
    procedure btIncProClick(Sender: TObject);
    procedure btSalProClick(Sender: TObject);
    procedure btCanProClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure edDesProCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btAltProClick(Sender: TObject);
    procedure edStatusChange(Sender: TObject);
    procedure edDesProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btProdutosClick(Sender: TObject);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btExcProClick(Sender: TObject);
    procedure SouPerdasDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    recNroNot, auxIDPerda:Integer;
    procedure AjustaGrid;
    procedure AjustBotoes(Acao:Boolean);
    Function  GravaProduto:Boolean;
    procedure BuscaInfPro;
  public
    { Public declarations }
    recIDFilial,recInclProd,recIDInvIni:Integer;
    recOrigem:String;
  end;

var
  FrmPerdasInc: TFrmPerdasInc;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uProdutoCad, uBuscaProdPerda;

procedure TFrmPerdasInc.AjustaGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmPerdasInc.FormShow(Sender: TObject);
begin
   AjustaGrid;
   auxIDPerda  := 0;
   recinclProd := 0;
   if recOrigem = 'ALTERAR' then
   begin
      ComboMotivo.ItemIndex := cdsPerdasMotivo.AsInteger-1;
      btIncPro.Visible  := False;
      btExcPro.Visible  := False;
      btAltPro.Visible  := True;
      btAltPro.Top      := btIncPro.Top;
      btAltPro.Left     := btIncPro.Left;
      btAltPro.Enabled  := True;
      LabelCab.Caption := 'SNGPC - Manipulação dos produtos ligados as perdas';
      ComboMotivo.Enabled := False;
      btAltPro.SetFocus;
   end
   else
      btIncPro.SetFocus;
end;

procedure TFrmPerdasInc.btAltProClick(Sender: TObject);
begin
   if cdsPerdas.IsEmpty then
   begin
      MostraMsg('Alteração de produto','Nenhum produto selecionado para fazer a alteração!',mtWarning, [mbOk]);
      edNroNota.SetFocus;
      Exit;
   end;// if
   edNroNota.Enabled := True;
   edNroNota.Color   := clWhite;
   btAltPro.Enabled  := False;
   btSalPro.Enabled  := True;
   btCanPro.Enabled  := True;
   recNroNot   := cdsPerdasNroNot.AsInteger;
   recinclProd := 2;
   cdsPerdas.Edit;
   PanelRodape.Enabled    := False;
   PanelCabecalho.Enabled := False;
end;

procedure TFrmPerdasInc.btCanProClick(Sender: TObject);
begin
   AjustBotoes(False);
   if recInclProd = 1 then
   begin
      cdsPerdas.Cancel;
      btIncPro.SetFocus;
      cdsLote.EmptyDataSet;
      DBGrid2.Visible := False;
   end;
   if recInclProd = 2 then
   begin
      cdsPerdasNroNot.AsInteger := recNroNot;
      cdsPerdas.Post;
   end;// if
   PanelRodape.Enabled    := True;
   PanelCabecalho.Enabled := True;
end;

procedure TFrmPerdasInc.btConfirmaClick(Sender: TObject);
var
   QueGrava:TRESTDWClientSQL;
   vErro:String;
begin
   cdsPerdas.First;
   while not cdsPerdas.Eof do
   begin
      if recInclProd = 1 then
      begin
         QueGrava          := TRESTDWClientSQL.Create(nil);
         QueGrava.DataBase := DM.DWDataBase;
         try
            try
               QueGrava.Close;
               QueGrava.SQL.Text := 'INSERT INTO arqsngpcper (IDFilial,IDInvIni,IDProd,Nrolot,DatPer,Motivo,QtdPer,DatVen,NroNot,Status) VALUES ('+
               cdsPerdasIDFilial.AsString+','+
               cdsPerdasIDInvIni.AsString+','+
               cdsPerdasIDProd.AsString+','+
               Aspas(cdsPerdasNroLot.AsString)+','+
               Aspas(FormatDateTime('yyyy-mm-dd',cdsPerdasDataPerda.AsDateTime))+','+
               Aspas(cdsPerdasMotivo.AsString)+','+
               FormatDouble(cdsPerdasQtdPer.AsFloat,11,2)+','+
               Aspas(FormatDateTime('yyyy-mm-dd',cdsPerdasDataVenc.AsDateTime))+','+
               cdsPerdasNroNot.AsString+','+
               Aspas(cdsPerdasStatus.AsString)+')';
               QueGrava.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpcper em uPerdasInc -> '+E.Message);
                  MostraMsg('Erro','Não foi possível incluir o produto.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end;// try
         finally
            QueGrava.Close;
            FreeAndNil(QueGrava);
         end;
      end// if
      else
      begin
         QueGrava          := TRESTDWClientSQL.Create(nil);
         QueGrava.DataBase := DM.DWDataBase;
         try
            try
               QueGrava.Close;
               QueGrava.SQL.Text := 'UPDATE arqsngpcper SET '+
                                    'NroNot = '+cdsPerdasNroNot.AsString+
                                    ' WHERE IDPerda = '+cdsPerdasIDPerda.AsString;
               QueGrava.ExecSQL(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar a alteração do número da nota fiscal em arqsngpcper na uPerdasInc -> '+E.Message);
                  MostraMsg('Erro','Não foi possível gravar a alteração do número da nota fiscal.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end;// try
         finally
            QueGrava.Close;
            FreeAndNil(QueGrava);
         end;
      end;// if
      cdsPerdas.Next;
   end;// while
   Close;
end;

procedure TFrmPerdasInc.btExcProClick(Sender: TObject);
begin
   if cdsPerdas.IsEmpty then
   begin
      MostraMsg('Exclusão de produto','Nenhum produto selecionado para excluir!',mtWarning, [mbOk]);
      btExcPro.SetFocus;
      Exit;
   end;// if

   if MostraMsg('Confirmação','Deseja excluir este produto '+cdsPerdasDesPro.AsString+' da nota fiscal?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   cdsPerdas.Delete;
end;

procedure TFrmPerdasInc.btIncProClick(Sender: TObject);
begin
   AjustBotoes(True);
   cdsPerdas.Append;
   DBGrid2.Visible := True;
   recinclProd     := 1;
   cdsPerdasStatus.AsString := '0';
   ComboMotivo.ItemIndex    := -1;
   edDataPerda.SetFocus;
   PanelRodape.Enabled    := False;
   PanelCabecalho.Enabled := False;
end;

procedure TFrmPerdasInc.btProdutosClick(Sender: TObject);
var
   auxIDProd:Integer;
begin
{
   try
      Application.CreateForm(TFrmProdCad, FrmProdCad);
      if cdsVendaIDProd.AsInteger > 0 then
      begin
         FrmProdCad.recIDProd := cdsVendaIDProd.AsInteger;
         FrmProdCad.recDespro := cdsVendaDespro.AsString;
      end
      else
      begin
         FrmProdCad.recIDProd := 0;
         FrmProdCad.recDespro := '';
      end;
      FrmProdCad.recOrigem := 'REC';
      CentralizarControl(FrmProdCad, PanelPri);
      Self.AlphaBlendValue := 155;
      FrmProdCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxIDProd := FrmProdCad.recIDProd;
      FrmProdCad   := nil;
   end; // try

}
   try
      Application.CreateForm(TFrmProdCad, FrmProdCad);
      if cdsPerdasIDProd.AsInteger > 0 then
      begin
         FrmProdCad.recIDProd := cdsPerdasIDProd.AsInteger;
         FrmProdCad.recDespro := cdsPerdasDesPro.AsString;
      end
      else
      begin
         FrmProdCad.recIDProd := 0;
         FrmProdCad.recDespro := '';
      end;// if
      FrmProdCad.recOrigem := 'REC';
      CentralizarControl(FrmProdCad, FrmPerdasInc);
      Self.AlphaBlendValue := 155;
      FrmProdCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxIDProd := FrmProdCad.recIDProd;
      FrmProdCad   := nil;
   end; // try
end;

function TFrmPerdasInc.GravaProduto: Boolean;
var
   auxIDFilial,auxIDProd,auxIDPer,auxNroNot,auxIDInvIni:Integer;
   auxNrolot,auxDespro,auxRegMS,auxMotivo,auxStatus,auxUsoRece:String;
   auxQtdPerda:Double;
   auxDatPerda,auxDatVenc:TDatetime;
   Achou:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
    // Aqui faz a alteração apenas do número da nota fiscal do produto
   if recInclProd = 2 then
   begin
      auxIDFilial := cdsPerdasIDFilial.AsInteger;
      auxIDPer    := cdsPerdasIDPerda.AsInteger;
      auxIDProd   := cdsPerdasIDProd.AsInteger;
      auxNrolot   := cdsPerdasNroLot.AsString;
      auxDespro   := cdsPerdasDesPro.AsString;
      auxRegMS    := cdsPerdasRegistroMS.AsString;
      auxQtdPerda := cdsPerdasQtdPer.AsFloat;
      auxDatPerda := cdsPerdasDataPerda.AsDateTime;
      auxDatVenc  := cdsPerdasDataVenc.AsDateTime;
      auxMotivo   := cdsPerdasMotivo.AsString;
      auxStatus   := cdsPerdasStatus.AsString;
      auxIDInvIni := cdsPerdasIDInvIni.AsInteger;
      auxUsoRece  := cdsPerdasUsoRece.AsString;

      cdsPerdasIDFilial.AsInteger   := auxIDFilial;
      cdsPerdasIDPerda.AsInteger    := auxIDPer;
      cdsPerdasIDProd.AsInteger     := auxIDProd;
      cdsPerdasNroLot.AsString      := edNrolot.Text;
      cdsPerdasDesPro.AsString      := auxDespro;
      cdsPerdasRegistroMS.AsString  := auxRegMS;
      cdsPerdasQtdPer.AsFloat       := auxQtdPerda;
      cdsPerdasDataPerda.AsDateTime := auxDatPerda;
      cdsPerdasDataVenc.AsDateTime  := auxDatVenc;
      cdsPerdasMotivo.AsString      := auxMotivo;
      cdsPerdasStatus.AsString      := auxStatus;
      cdsPerdasIDInvIni.AsInteger   := auxIDInvIni;
      cdsPerdasUsoRece.AsString     := auxUsoRece;
      cdsPerdasNroNot.AsInteger     := StrToInt(edNroNota.Text);
      cdsPerdas.Post;
      Result := True;
      exit;
   end;// if
   // Aqui faz a inclusão do produto
   if cdsPerdasIDProd.AsInteger <= 0 then
   begin
      MostraMsg('Produto não informado','Favor verificar o produto!',mtWarning, [mbOk]);
      edDesPro.SetFocus;
      Exit;
   end; //if

   auxRegMS := cdsPerdasRegistroMS.AsString.Trim;
   if (not(Length(auxRegMS) = 13)) or (not(IsNumeric(auxRegMS))) or (not(Copy(auxRegMS,1,1) = '1')) then
   begin
      MostraMsg('Registro MS inválido','Favor verificar o registro MS do produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if
   auxRegMS := '';

   if edDataPerda.Date <= 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a data da perda!',mtWarning, [mbOk]);
      edDataPerda.SetFocus;
      Exit;
   end;// if

   cdsLote.Filtered := False;
   cdsLote.Filter   := 'QtdPerda > 0';
   cdsLote.Filtered := True;
   if cdsLote.IsEmpty then
   begin
      MostraMsg('Quantidade inválida','Favor verificar a quantidade!',mtWarning, [mbOk]);
      DBGrid2.SetFocus;
      cdsLote.Filtered := False;
      Exit;
   end;// if

   cdsLote.Filtered := False;
   cdsLote.Filter   := 'QtdPerda > QtdLote';
   cdsLote.Filtered := True;
   if not cdsLote.IsEmpty then
   begin
      MostraMsg('Quantidade inválida','Favor verificar a quantidade!',mtWarning, [mbOk]);
      DBGrid2.SetFocus;
      cdsLote.Filtered := False;
      Exit;
   end;// if

   auxIDProd   := edDesPro.Tag;
   auxDespro   := edDesPro.Text;
   auxRegMS    := edRegMS.Text;
   auxDatPerda := edDataPerda.Date;
   auxMotivo   := IntToStr(ComboMotivo.ItemIndex+1);
   if edNroNota.Text <> '' then
      auxNroNot   := StrToInt(edNroNota.Text)
   else
      auxNroNot   := 0;

   cdsLote.Filtered := False;
   cdsLote.Filter   := 'QtdPerda > 0';
   cdsLote.Filtered := True;
   cdsLote.First;

   while not cdsLote.Eof do
   begin
      Inc(auxIDPerda);
      cdsPerdasIDFilial.AsInteger   := recIDFilial;
      cdsPerdasIDInvIni.AsInteger   := recIDInvIni;
      cdsPerdasIDPerda.AsInteger    := auxIDPerda;
      cdsPerdasIDProd.AsInteger     := auxIDProd;
      cdsPerdasNroLot.AsString      := cdsLoteNroLot.AsString;
      cdsPerdasDesPro.AsString      := auxDespro;
      cdsPerdasRegistroMS.AsString  := auxRegMS;
      cdsPerdasQtdPer.AsFloat       := cdsLoteQtdPerda.AsFloat;
      cdsPerdasDataPerda.AsDateTime := auxDatPerda;
      cdsPerdasDataVenc.AsDateTime  := cdsLoteDatVenc.AsDateTime;
      cdsPerdasMotivo.AsString      := auxMotivo;
      cdsPerdasNroNot.AsInteger     := auxNroNot;
      cdsPerdasUsoRece.AsString     := cdsLoteUsoRece.AsString;
      cdsPerdasStatus.AsString      := '0';
      cdsPerdas.Post;
      cdsPerdas.Append;
      cdsLote.Next;
   end;// while
   cdsPerdas.Cancel;
   cdsLote.Filtered := False;
   Result := True;
end;

procedure TFrmPerdasInc.SouPerdasDataChange(Sender: TObject; Field: TField);
begin
   if not (cdsPerdasMotivo.AsString = '') then
      ComboMotivo.ItemIndex := cdsPerdasMotivo.AsInteger-1
end;

procedure TFrmPerdasInc.btSalProClick(Sender: TObject);
begin
   if GravaProduto then
   begin
      AjustBotoes(False);
      cdsLote.First;
      cdsLote.EmptyDataSet;
      DBGrid2.Visible := False;
   end;// if
   PanelRodape.Enabled    := True;
   PanelCabecalho.Enabled := True;
end;

procedure TFrmPerdasInc.BuscaInfPro;
var
   QueAuxi,QueLote: TRESTDWClientSQL;
begin
   if edDespro.Text = '' then
      Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueLote := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueLote.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT PRO.IDProd,PRO.RegistoMS,PRO.ClasTera,PRO.UsoRece,PRO.CodEANpri,PES.IDPess,PES.Nompes FROM arqproduto PRO '+
      'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess WHERE PRO.IDProd = '+Aspas(IntToStr(edDespro.Tag));
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         cdsPerdasIDProd.AsInteger    := QueAuxi.FieldByName('IDProd').AsInteger;
         cdsPerdasRegistroMS.AsString := QueAuxi.FieldByName('RegistoMS').AsString;
         cdsPerdasUsoRece.AsString    := QueAuxi.FieldByName('UsoRece').AsString;

         QueLote.Close;
         QueLote.SQL.Text := 'SELECT IDProd,Nrolot,Qtdest,Datven FROM arqsngpclot' +
         ' WHERE IDFilial = '+recIDFilial.ToString + ' AND IDInvIni = '+recIDInvIni.ToString+
         ' AND IDProd = '+QueAuxi.FieldByName('IDProd').AsString+' AND Qtdest > 0 ORDER BY Datven ASC';
         QueLote.Open;
         QueLote.First;
         while not QueLote.Eof do
         begin
            cdsLote.Append;
            cdsLoteIDProd.AsInteger   := QueLote.FieldByName('IDProd').AsInteger;
            cdsLoteDatVenc.AsDateTime := QueLote.FieldByName('Datven').AsDateTime;
            cdsLoteNroLot.AsString    := QueLote.FieldByName('Nrolot').AsString;
            cdsLoteQtdLote.AsFloat    := QueLote.FieldByName('Qtdest').AsFloat;
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

procedure TFrmPerdasInc.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
   if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('Motivo') then
   begin
      if Column.Field.Asstring = '1' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'FURTO/ROUBO');
      end else if Column.Field.Asstring = '2' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'AVARIA');
      end else if Column.Field.Asstring = '3' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'VENCIMENTO');
      end else if Column.Field.Asstring = '4' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'APREENSÃO/RECOLHIMENTO PELA VISA');
      end else if Column.Field.Asstring = '5' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'PERDA NO PROCESSO');
      end else if Column.Field.Asstring = '6' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'COLETA PARA CONTROLE DE QUALIDADE');
      end else if Column.Field.Asstring = '7' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'PERDA DE EXCLUSÃO DE PORTARIA 344');
      end else if Column.Field.Asstring = '8' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'POR DESVIO DE QUALIDADE');
      end else if Column.Field.Asstring = '9' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'RECOLHIMENTO DO FABRICANTE');
      end else if Column.Field.Asstring = '10' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'DEVOLUÇÃO DE COMPRA');
      end;// if
   end;// if
   if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('Status') then
   begin
      if Column.Field.Asstring = '0' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'A ENVIAR');
      end else if Column.Field.Asstring = '1' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'ENVIADO');
      end;// if
   end;// if
end;

procedure TFrmPerdasInc.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPerdasInc.DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (DBGrid2.DataSource.DataSet.RecNo = DBGrid2.DataSource.DataSet.RecordCount ) then abort;
end;

procedure TFrmPerdasInc.edDesProCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
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
end;

procedure TFrmPerdasInc.edDesProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
         end;// if

         if Trim(edDespro.Text) = '' then Exit;
         soInteger := iif(ExisteStr(Trim(edDespro.Text)), '', OnlyNumbers(edDespro.Text));
         if soInteger = '' then
         begin
            key := 0;
            edDesproCustomButtons0Click(Self, Key);
         end;// if
      end
      else if Key = VK_ESCAPE then
      begin
         edDespro.Text := '';
         edDespro.Tag  := 0;
      end else
      begin
         edDesproCustomButtons0Click(Self, key);
         key := 0;
      end;// if
   end;// if
end;

procedure TFrmPerdasInc.edStatusChange(Sender: TObject);
begin
   if cdsPerdasStatus.AsString = '0' then
      edStatus.Text := 'A Enviar'
   else
      edStatus.Text := 'Enviado';
end;

procedure TFrmPerdasInc.AjustBotoes(Acao: Boolean);
begin
   edDataPerda.Enabled := Acao;
   lbDataPerda.Enabled := Acao;
   ComboMotivo.Enabled := Acao;
   edDesPro.Enabled    := Acao;
   edRegMS.Enabled     := Acao;
   edNroNota.Enabled   := Acao;
   if Acao then
   begin
      edDataPerda.Color := clWhite;
      ComboMotivo.Color := clWhite;
      edDesPro.Color    := clWhite;
      edRegMS.Color     := clWhite;
      edNroNota.Color   := clWhite;
   end
   else
   begin
      edDataPerda.Color := $00EFEFEF;
      ComboMotivo.Color := $00EFEFEF;
      edDesPro.Color    := $00EFEFEF;
      edRegMS.Color     := $00EFEFEF;
      edNroNota.Color   := $00EFEFEF;
   end;

   btIncPro.Enabled := not (Acao);
   btAltPro.Enabled := not (Acao);
   btExcPro.Enabled := not (Acao);
   btSalPro.Enabled := Acao;
   btCanPro.Enabled := Acao;
end;

procedure TFrmPerdasInc.btFecharClick(Sender: TObject);
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

procedure TFrmPerdasInc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   cdsPerdas.Close;
   cdsLote.Close;
end;

end.
