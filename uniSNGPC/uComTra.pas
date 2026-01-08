unit uComTra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDLabel, DB,
  LMDBaseGraphicControl, LMDBaseLabel, LMDEdit, LMDCustomLabel, LMDControl, Vcl.Mask,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDCustomMemo,
  LMDDBMemo, RxLookup, Vcl.StdCtrls, RxToolEdit, RxDBCtrl, LMDBaseEdit, LMDCustomEdit,
  LMDDBEdit, LMDCustomMaskEdit, LMDCustomExtCombo, LMDCustomListComboBox, MarcLib,
  LMDListComboBox, LMDDBListComboBox, AdvGlowButton, Vcl.ExtCtrls, AdvSmoothPanel,
  AdvScrollBox, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, LMDMaskEdit, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, LMDThemedComboBox,
  LMDComboBox, LMDCustomComboBox, Vcl.ImgList, LMDButtonControl, LMDCustomCheckBox,
  LMDDBCheckBox, System.ImageList, uRESTDWBasicTypes, uRESTDWBasicDB, AdvOfficeButtons,
  VirtualTable, LMDCustomParentPanel, LMDCustomPanelFill, LMDRadioButton, LMDCustomGroupBox,
  LMDCustomButtonGroup, LMDCustomRadioGroup, LMDDBRadioGroup, uWaitForm;

type
  TFrmComTra = class(TForm)
    SouComTra: TDataSource;
    PanelPri: TLMDSimplePanel;
    Shape1: TShape;
    PanelCabecalho: TLMDSimplePanel;
    TabComTra: TRESTDWClientSQL;
    btFechar: TAdvGlowButton;
    Label22: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    ComboOper: TLMDComboBox;
    btBuscar: TAdvGlowButton;
    TabComTraIDFilial: TIntegerField;
    TabComTraIDPess: TIntegerField;
    TabComTraNronot: TIntegerField;
    TabComTraDatlan: TDateField;
    TabComTraTipope: TWideStringField;
    TabComTraIndConf: TWideStringField;
    TabComTraNompes: TWideStringField;
    TabComTraIte: TRESTDWClientSQL;
    SouComTraIte: TDataSource;
    TabComTraIteIDProd: TIntegerField;
    TabComTraIteNrolot: TWideStringField;
    TabComTraIteQtdmov: TFloatField;
    TabComTraIteDespro: TWideStringField;
    TabComTraIteRegistoMS: TWideStringField;
    TabComTraIteNomfab: TWideStringField;
    TabComTraIteDatven: TDateField;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    PanelNota: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelRodape: TLMDSimplePanel;
    btExcluirNotaFiscal: TAdvGlowButton;
    btImpressao: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    Label4: TLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    Label6: TLabel;
    TabComTraTransmitida: TWideStringField;
    TabComTraIDSngpcCom: TFDAutoIncField;
    rbConSim: TLMDRadioButton;
    rbConNao: TLMDRadioButton;
    rbTraSim: TLMDRadioButton;
    rbTraNao: TLMDRadioButton;
    btNotaFiscal: TAdvGlowButton;
    TabComTraIteIDSngpcCom: TIntegerField;
    TabComTraIteIDSngpcComIte: TFDAutoIncField;
    TabComTraIteUsoRece: TWideStringField;
    AdvGlowButton1: TAdvGlowButton;
    TabComTraIDInvIni: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btBuscarClick(Sender: TObject);
    procedure TabComTraAfterOpen(DataSet: TDataSet);
    procedure btNotaFiscalClick(Sender: TObject);
    procedure btExcluirNotaFiscalClick(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
  private
    { Private declarations }
    auxIDFilial,auxIDInvIni:Integer;
    procedure AjustGrid;
    procedure AtuaTabTemp;
  public
    { Public declarations }
  end;

var
  FrmComTra: TFrmComTra;

implementation

uses uDM, uConst, uLibFarm, uComTraInc;

{$R *.dfm}

procedure TFrmComTra.FormShow(Sender: TObject);
var
   QueInvi:TRESTDWClientSQL;
begin
   auxIDFilial := FILIAL;
   Left := (Parent.Width  - Width)  div 2;
   Top  := (Parent.Height - Height) div 2;
   QueInvi          := TRESTDWClientSQL.Create(nil);
   QueInvi.DataBase := DM.DWDataBase;
   Try
      QueInvi.Close;
      QueInvi.SQL.Text := 'SELECT IDInvIni FROM arqsngpcinve WHERE IndFecha = 1';
      QueInvi.Open;
      auxIDInvIni := QueInvi.FieldByName('IDInvIni').AsInteger;
   Finally
      QueInvi.Close;
      FreeAndNil(QueInvi);
   End;

   try
      TabComTra.SQL.Text := 'SELECT COM.*,PES.Nompes FROM arqsngpccom COM '+
      'LEFT JOIN arqpessoa PES ON COM.IDPess = PES.IDPess '+
      'WHERE COM.IDFilial = '+auxIDFilial.ToString+' AND COM.IDInvIni = '+auxIDInvIni.ToString;
      TabComTra.Open;
      TabComTraIte.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;// try
   AjustGrid;
   edDataIni.SetFocus;
end;

procedure TFrmComTra.TabComTraAfterOpen(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmComTra.AdvGlowButton1Click(Sender: TObject);
begin
   edDataIni.Text      := '';
   edDataFin.Text      := '';
   ComboOper.ItemIndex := -1;
   rbConSim.Checked    := False;
   rbConNao.Checked    := False;
   rbTraSim.Checked    := False;
   rbTraNao.Checked    := False;
end;

procedure TFrmComTra.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmComTra.DBGrid1CellClick(Column: TColumn);
var
   Index:Integer;
begin
   if TabComTra.IsEmpty then Exit;

   if Column.ID = 5 then
   begin
      try
         Application.CreateForm(TFrmComTraInc, FrmComTraInc);
         FrmComTraInc.recIDSngpcCom := TabComTraIDSngpcCom.AsInteger;
         FrmComTraInc.recOrigem     := 'CONSULTAR';
         FrmComTraInc.recIDFilial := auxIDFilial;
         FrmComTraInc.recIDInvIni := auxIDInvIni;
         FrmComTraInc.cdsTepComTra.CreateDataSet;
         FrmComTraInc.cdsTepComTraIte.CreateDataSet;
         AtuaTabTemp;
         FrmComTraInc.ShowModal;
      finally
         FreeAndNil(FrmComTraInc);
         DBGrid1.SelectedField := TabComTraTipope;
      end;// try
      Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
      TabComTra.Close;
      TabComTra.Open;
      DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice baseado em um
      DBGrid1.Refresh; // Refresh no DBGrid para mostrar a nova posição
   end;// if
end;

procedure TFrmComTra.AtuaTabTemp;
var
   QueAuxi:TRESTDWClientSQL;
begin
   FrmComTraInc.cdsTepComTra.Append;
   FrmComTraInc.cdsTepComTraIDSngpcCom.AsInteger := TabComTraIDSngpcCom.AsInteger;
   FrmComTraInc.cdsTepComTraIDFilial.AsInteger   := TabComTraIDFilial.AsInteger;
   FrmComTraInc.cdsTepComTraIDPess.AsInteger     := TabComTraIDPess.AsInteger;
   FrmComTraInc.cdsTepComTraNronot.AsInteger     := TabComTraNronot.AsInteger;
   FrmComTraInc.cdsTepComTraDatlan.AsDateTime    := TabComTraDatlan.AsDateTime;
   FrmComTraInc.cdsTepComTraTipope.AsString      := TabComTraTipope.AsString;
   FrmComTraInc.cdsTepComTraIndConf.AsString     := TabComTraIndConf.AsString;
   FrmComTraInc.cdsTepComTraNompes.AsString      := TabComTraNompes.AsString;
   FrmComTraInc.cdsTepComTraTransmitida.AsString := TabComTraTransmitida.AsString;
   FrmComTraInc.cdsTepComTra.Post;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT ITE.*, PRO.Despro, PRO.RegistoMS, PES.Nompes AS Nomfab FROM arqsngpccomite ITE '+
      'LEFT JOIN arqproduto PRO ON ITE.IDProd = PRO.IDProd LEFT JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
      'WHERE ITE.IDSngpcCom = '+TabComTraIDSngpcCom.AsString;
      QueAuxi.Open;
      QueAuxi.First;
      while not QueAuxi.Eof do
      begin
         FrmComTraInc.cdsTepComTraIte.Append;
         FrmComTraInc.cdsTepComTraIteIDSngpcComIte.AsInteger := QueAuxi.FieldByName('IDSngpcComIte').AsInteger;
         FrmComTraInc.cdsTepComTraIteIDSngpcCom.AsInteger    := QueAuxi.FieldByName('IDSngpcCom').AsInteger;
         FrmComTraInc.cdsTepComTraIteIDProd.AsInteger        := QueAuxi.FieldByName('IDProd').AsInteger;
         FrmComTraInc.cdsTepComTraIteNrolot.AsString         := QueAuxi.FieldByName('Nrolot').AsString;
         FrmComTraInc.cdsTepComTraIteQtdmov.AsFloat          := QueAuxi.FieldByName('Qtdmov').AsFloat;
         FrmComTraInc.cdsTepComTraIteDespro.AsString         := QueAuxi.FieldByName('Despro').AsString;
         FrmComTraInc.cdsTepComTraIteRegistoMS.AsString      := QueAuxi.FieldByName('RegistoMS').AsString;
         FrmComTraInc.cdsTepComTraIteNomfab.AsString         := QueAuxi.FieldByName('Nomfab').AsString;
         FrmComTraInc.cdsTepComTraIteDatven.AsDateTime       := QueAuxi.FieldByName('Datven').AsDateTime;
         FrmComTraInc.cdsTepComTraIteUsoRece.AsString        := QueAuxi.FieldByName('UsoRece').AsString;
         FrmComTraInc.cdsTepComTraIte.Post;
         QueAuxi.Next
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmComTra.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
   if not TabComTra.IsEmpty then
   begin
      if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('Tipope') then
      begin
         if Column.Field.Asstring = '0' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'COMPRA');
         end else if Column.Field.Asstring = '1' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'TRANSFERÊNCIA ENTRADA');
         end else if Column.Field.Asstring = '2' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'TRANSFERÊNCIA SAÍDA');
         end;// if
      end;// if
      if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('IndConf') then
      begin
         if Column.Field.Asstring = '0' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+30, Rect.Top+4, 16);
         end else if Column.Field.Asstring = '1' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+30, Rect.Top+4, 15);
         end;// if
      end;// if
      if Column.ID = 5 then
         DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+30, Rect.Top+4, 20);

      if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('Transmitida') then
      begin
         if Column.Field.Asstring = '0' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+30, Rect.Top+4, 16);
         end else if Column.Field.Asstring = '1' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+30, Rect.Top+4, 15);
         end;// if
      end;// if
   end;
end;

procedure TFrmComTra.btBuscarClick(Sender: TObject);
begin
   TabComTra.Close;
   TabComTra.SQL.Clear;
   TabComTra.SQL.Add('SELECT COM.*,PES.Nompes FROM arqsngpccom COM LEFT JOIN arqpessoa PES ON COM.IDPess = PES.IDPess '+
   'WHERE COM.IDFilial = '+FILIAL.ToString);
   if (edDataIni.Date > 0) and (edDataFin.Date > 0) then
      TabComTra.SQL.Add(' AND Datlan BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDataIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDataFin.Date)));
   if ComboOper.ItemIndex > 0 then
      TabComTra.SQL.Add(' AND COM.Tipope = '+iif(ComboOper.ItemIndex = 1, Aspas('0'), Aspas('1')));
   if (rbConSim.Checked) or (rbConNao.Checked) then
      TabComTra.SQL.Add(' AND COM.IndConf = '+iif(rbConSim.Checked, Aspas('1'), Aspas('0')));
   if (rbTraSim.Checked) or (rbTraNao.Checked) then
      TabComTra.SQL.Add(' AND COM.Transmitida = '+iif(rbTraSim.Checked, Aspas('1'), Aspas('0')));
   TabComTra.Open;
end;

procedure TFrmComTra.btNotaFiscalClick(Sender: TObject);
var
   Index:Integer;
begin
   try
      FrmComTraInc := TFrmComTraInc.Create(Application);
      FrmComTraInc.recOrigem := 'INCLUIR';
      FrmComTraInc.recIDFilial := auxIDFilial;
      FrmComTraInc.recIDInvIni := auxIDInvIni;
      FrmComTraInc.cdsTepComTra.CreateDataSet;
      FrmComTraInc.cdsTepComTraIte.CreateDataSet;
      FrmComTraInc.ShowModal;
   finally
      FrmComTraInc.Free;
   end; //try
   Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
   TabComTra.Close;
   TabComTra.Open;
   DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   DBGrid1.Refresh; // Refresca o DBGrid para mostrar a nova posição
   TabComTraIte.Close;
   TabComTraIte.Open;
end;

procedure TFrmComTra.btExcluirNotaFiscalClick(Sender: TObject);
var
   QueAuxi,QueLote:TRESTDWClientSQL;
   Index:Integer;
   Controle:Boolean;
begin
   if TabComTra.IsEmpty then
   begin
      MostraMsg('Exclusão de nota fiscal','Nenhuma nota fiscal selecionada para excluir!',mtWarning, [mbOk]);
      btExcluirNotaFiscal.SetFocus;
      Exit;
   end;// if

   if MostraMsg('Confirmação','Deseja excluir nota fiscal número '+TabComTraNronot.AsString+' e todos os produtos ligados a ela?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   Controle := True;

   ShowWait('Aguarde...', Self);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueLote := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueLote.DataBase := DM.DWDataBase;
   try
      TabComTraIte.Close;
      TabComTraIte.SQL.Text := 'SELECT ITE.*, PRO.Despro,PRO.RegistoMS, PES.Nompes AS Nomfab FROM arqsngpccomite ITE ' +
      'LEFT JOIN arqproduto PRO ON ITE.IDProd = PRO.IDProd LEFT JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
      'WHERE ITE.IDSngpcCom = '+ TabComTraIDSngpcCom.AsString;
      TabComTraIte.Open;
      TabComTraIte.First;
      while not TabComTraIte.Eof do
      begin
         QueLote.Close;
         QueLote.SQL.Text := 'SELECT * FROM arqsngpclot LOT'+
         ' WHERE IDFilial = '+TabComTraIDFilial.AsString+ ' AND IDInvIni = '+TabComTraIDInvIni.AsString+
         ' AND IDProd = '+TabComTraIteIDProd.AsString+' AND Nrolot = '+TabComTraIteNrolot.AsString;
         QueLote.Open;
         // aqui deleta o produto que está no lote do SNGPC, mas não vai deixar o saldo negativo
         if (QueLote.FieldByName('Qtdest').AsFloat - TabComTraIteQtdmov.AsFloat >= 0) or (TabComTraTipope.AsString = '2') then
         begin
            try
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'DELETE FROM arqsngpccomite WHERE IDSngpcComIte = '+TabComTraIteIDSngpcComIte.AsString;
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir os produtos da nota fiscal de arqsngpccomite em uCompTraInc -> '+E.Message);
                  MostraMsg('Erro','Não foi possível excluir o produto da nota fiscal e incluir as alterações.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end;// try
         end else
         begin
            MostraMsg('Exclusão','Produto '+TabComTraIteDespro.AsString+' não pode ser excluido, pois tem movimentação no lote.', mtWarning, [mbOk]);
            Controle := False;
         end;
         TabComTraIte.Next;
      end;

      if Controle then
      begin
         try
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'DELETE FROM arqsngpccom'+
            ' WHERE IDSngpcCom = '+TabComTraIDSngpcCom.AsString+' AND IDFilial = '+TabComTraIDFilial.AsString+
            ' AND IDPess = '+TabComTraIDPess.AsString+' AND Nronot = '+TabComTraNronot.AsString;
            QueAuxi.ExecSQL;
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir a nota fiscal de arqsngpccom em uCompTra -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir a nota fiscal.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
      end;// if
      Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
      TabComTra.Close;
      TabComTra.Open;
      DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
      DBGrid1.Refresh; // Refresca o DBGrid para mostrar a nova posição
   finally
      QueAuxi.Close;
      QueLote.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueLote);
      HideWait;
   end;// try
end;

procedure TFrmComTra.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmComTra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabComTraIte.Close;
   TabComTra.Close;
end;

end.

