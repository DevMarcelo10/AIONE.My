unit uNotasPendEnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls,  Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Marclib,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
  LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel,
  Vcl.ExtCtrls, LMDBaseEdit, LMDCustomEdit, LMDEdit, Vcl.StdCtrls, FireDAC.DApt.Intf,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, Vcl.Mask, RxToolEdit, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, LMDMaskEdit, FireDAC.Comp.DataSet, uWaitForm,
  FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, LMDCustomMaskEdit,
  FireDAC.Phys.Intf;

type
  TFrmNotasPendEnt = class(TForm)
    PanelPri: TLMDSimplePanel;
    Shape5: TShape;
    PanelTop: TLMDSimplePanel;
    LMDLabel8: TLMDLabel;
    PanelCabe: TLMDSimplePanel;
    edNomfil: TLMDLabeledEdit;
    edNomcol: TLMDLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    btBuscar: TAdvGlowButton;
    edNotfis: TLMDLabeledMaskEdit;
    TabPend: TRESTDWClientSQL;
    SouTabPend: TDataSource;
    TabPendIDRec: TFDAutoIncField;
    TabPendIDPess: TIntegerField;
    TabPendIDFilial: TIntegerField;
    TabPendTipRece: TWideStringField;
    TabPendDatRece: TDateTimeField;
    TabPendTotRece: TFloatField;
    TabPendTotProd: TFloatField;
    TabPendNroPedFor: TWideStringField;
    TabPendNotFis: TIntegerField;
    TabPendNroSerie: TIntegerField;
    TabPendDatEmi: TDateTimeField;
    TabPendNrotit: TWideStringField;
    TabPendTipEnt: TWideStringField;
    TabPendObsped: TMemoField;
    TabPendIndSel: TWideStringField;
    TabPendNompes: TWideStringField;
    TabPendNomfil: TWideStringField;
    TabPendCalcChaAce: TWideStringField;
    TabPendCalcNomCol: TWideStringField;
    edNomPes: TLMDLabeledEdit;
    TabPendCpfCnpjPes: TWideStringField;
    btExcluir: TAdvGlowButton;
    btConfirma: TAdvGlowButton;
    ckEmissao: TLMDCheckBox;
    ckLancamento: TLMDCheckBox;
    Label16: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btFechar: TAdvGlowButton;
    LMDSimplePanel3: TLMDSimplePanel;
    dgDados: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure dgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btBuscarClick(Sender: TObject);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure ckLancamentoChange(Sender: TObject);
    procedure ckEmissaoChange(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure dgDadosCellClick(Column: TColumn);
    procedure btExcluirClick(Sender: TObject);
    procedure LMDLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure dgDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure AjustaGrid;
  public
    { Public declarations }
    recIDRec:Integer;
  end;

var
  FrmNotasPendEnt: TFrmNotasPendEnt;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmNotasPendEnt.FormShow(Sender: TObject);
begin
   edNomPes.SetFocus;
   dgDados.SelectedField := TabPendNompes;
   AjustaGrid;
end;

procedure TFrmNotasPendEnt.AjustaGrid;
begin
   TStringGrid(dgDados).DefaultRowHeight := BaseRowHeight - 5;
   dgDados.Width := dgDados.Width - 10;
   dgDados.Width := dgDados.Width + 10;
end;

procedure TFrmNotasPendEnt.btConfirmaClick(Sender: TObject);
var
   Index:Integer;
begin
   if TabPend.IsEmpty then Exit;
   Index := dgDados.DataSource.DataSet.RecNo;
   TabPend.Filtered := False;
   TabPend.Filter   := 'IndSel = 1';
   TabPend.Filtered := True;
   if TabPend.RecordCount = 1 then
       recIDRec := TabPendIDRec.AsInteger
   else if TabPend.RecordCount > 1 then
   begin
      MostraMsg('Aviso','Selecione apenas uma nota!', mtWarning, [mbOk]);
      TabPend.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end else
   begin
      MostraMsg('Aviso','Nenhuma nota selecionada!', mtWarning, [mbOk]);
      TabPend.Filtered := False;
      dgDados.DataSource.DataSet.RecNo := Index;
      dgDados.Refresh;
      Exit;
   end;
   TabPend.Filtered := False;
   dgDados.DataSource.DataSet.RecNo := Index;
   dgDados.Refresh;
   Close;
end;

procedure TFrmNotasPendEnt.btExcluirClick(Sender: TObject);
var
   vErro:String;
   auxConta:Integer;
   QueAuxi,QueTitu:TRESTDWClientSQL;
begin
   if TabPend.IsEmpty then Exit;
   auxConta := 0;
   TabPend.First;
   TabPend.Filtered := False;
   TabPend.Filter   := 'IndSel = 1';
   TabPend.Filtered := True;
   if TabPend.RecordCount < 1 then
   begin
      MostraMsg('Aviso','Nenhuma nota selecionada para excluir!',mtWarning, [mbOk]);
      Exit;
   end; //if
   if MostraMsg('Confirmação','Confirma exclusão das notas fiscais selecionadas?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueTitu := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueTitu.DataBase := DM.DWDataBase;
   try
      ShowWait('Aguarde...', Self);
      TabPend.First;
      while not TabPend.Eof do
      begin
         if TabPendIndSel.AsString = '1' then // se for 1 está marcado vai excluir
         begin
            // Exclusão dos rateios da natureza financeira liga aos titulos da nota fiscal selecionada
            QueTitu.SQL.Clear;
            QueTitu.SQL.Text := 'SELECT * FROM arqtitulotemp WHERE IDPess = '+TabPendIDPess.AsString+
            ' AND NotFis = '+TabPendNotFis.AsString+' AND NroSerie = '+TabPendNroSerie.AsString+
            ' AND Nrotit = '+TabPendNrotit.AsString;
            QueTitu.Open;
            QueTitu.First;
            while not QueTitu.Eof do
            begin
               try
                  QueAuxi.SQL.Clear;
                  QueAuxi.SQL.Text := 'DELETE FROM arqtitulorattemp WHERE IDTitu = '+QueTitu.FieldByName('IDTitu').AsString+' AND OrigTitu = 1';
                  QueAuxi.ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir arqtitulorattemp em uNotasPendEnt -> '+E.Message);
                     MostraMsg('Erro','Não foi possível Excluir os rateios do título da nota selecionada.'+#10+E.Message, mtError, [mbOk]);
                  end;
               end; //try
               QueTitu.Next;
            end; //while

            // Exclusão dos títulos ligados a nota fiscal selecionada
            try
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Text := 'DELETE FROM arqtitulotemp WHERE IDPess = '+TabPendIDPess.AsString+
               ' AND NotFis = '+TabPendNotFis.AsString+' AND NroSerie = '+TabPendNroSerie.AsString+
               ' AND Nrotit = '+TabPendNrotit.AsString;
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir arqtitulotemp em uNotasPendEnt -> '+E.Message);
                  MostraMsg('Erro','Não foi possível Excluir os título da nota selecionada.'+#10+E.Message, mtWarning, [mbOk]);
               end;
            end;

            // Exclusão dos lotes ligados aos itens da nota fiscal selecionada
            try
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Text := 'DELETE FROM arqcomprareclot WHERE IDRec = '+TabPendIDRec.AsString;
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir arqcomprareclot em uNotasPendEnt -> '+E.Message);
                  MostraMsg('Erro','Não foi possível Excluir os lotes dos itens da nota selecionada.'+#10+E.Message, mtWarning, [mbOk]);
               end;
            end;

            // Exclusão dos itens da nota fiscal selecionada
            try
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Text := 'DELETE FROM arqcomprarecite WHERE IDRec = '+TabPendIDRec.AsString;
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir arqcomprarecite em uNotasPendEnt -> '+E.Message);
                  MostraMsg('Erro','Não foi possível Excluir os itens da nota selecionada.'+#10+E.Message, mtError, [mbOk]);
               end;
            end;

            // Exclusão da nota fiscal selecionada
            try
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Text := 'DELETE FROM arqcomprarec WHERE IDRec = '+TabPendIDRec.AsString;
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir arqcomprarec em uNotasPendEnt -> '+E.Message);
                  MostraMsg('Erro','Não foi possível Excluir a nota fiscal selecionada.'+#10+E.Message, mtError, [mbOk]);
               end;
            end;

            // Muda o status da NFe na tabela de manifestação
            try
               QueAuxi.Close;
               QueAuxi.SQL.Text := 'UPDATE arqmandest SET StatusNFE = '+Aspas('1')+
               ' WHERE IDFilial = '+TabPendIDFilial.AsString+' AND CNPJCPFFor = '+Aspas(TabPendCpfCnpjPes.AsString)+
               ' AND NotFis = '+TabPendNotFis.AsString+' AND NroSerie = '+TabPendNroSerie.AsString;
               QueAuxi.ExecSQL(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível gravar as alterações na tabela arqmandest do status da NFe em uNotasPendEnt -> '+E.Message);
                  MostraMsg('Erro','Não foi possível gravar as alterações.'+#10+E.Message, mtError, [mbOk]);
                  Exit;
               end;
            end;
         end; //if
         TabPend.Next;
      end; //while

      TabPend.Filtered := False;
      TabPend.Close;
      TabPend.Open;
      AjustaGrid;
   finally
      QueAuxi.Close;
      QueTitu.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueTitu);
      HideWait;
   end;
end;

procedure TFrmNotasPendEnt.btBuscarClick(Sender: TObject);
begin
   TabPend.Close;
   TabPend.SQL.Clear;
   TabPend.SQL.Text := 'SELECT REC.*,PES.Nompes,PES.CpfCnpjPes,FIL.Nomfil FROM arqcomprarec REC'+
   ' LEFT JOIN arqpessoa PES  ON REC.IDPess = PES.IDPess'+
   ' LEFT JOIN arqfilial FIL ON REC.IDFilial = FIL.IDFilial'+
   ' WHERE REC.TipEnt <> 0';
   if (edDataIni.Date <> 0)  and (edDataFin.Date <> 0) then
   begin
      if ckLancamento.Checked then
         TabPend.SQL.Add(' AND REC.DatRece BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDataIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDataFin.Date)));
      if ckEmissao.Checked then
         TabPend.SQL.Add(' AND REC.Datemi BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDataIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDataFin.Date)));
   end;
   if edNomPes.Tag > 0 then TabPend.SQL.Add(' AND REC.IDPess = '+  edNomPes.Tag.ToString);
   if edNomfil.Tag > 0 then TabPend.SQL.Add(' AND REC.IDFilial = '+edNomfil.Tag.ToString);
   if edNotfis.AsInteger > 0 then TabPend.SQL.Add(' AND REC.NotFis = '+edNotfis.AsString);
   if ckEmissao.Checked then TabPend.SQL.Add(' ORDER BY REC.IDPess,REC.DatEmi') else
   if ckLancamento.Checked then TabPend.SQL.Add(' ORDER BY REC.IDPess,REC.DatRece');
   TabPend.Open;
   AjustaGrid;
end;

procedure TFrmNotasPendEnt.ckLancamentoChange(Sender: TObject);
begin
   if ckLancamento.Checked then
   begin
      ckEmissao.Checked := False;
      ckLancamento.Checked := True;
   end
   else ckLancamento.Checked := False;
end;

procedure TFrmNotasPendEnt.ckEmissaoChange(Sender: TObject);
begin
   if ckEmissao.Checked then
   begin
      ckLancamento.Checked := False;
      ckEmissao.Checked    := True;
   end
   else ckEmissao.Checked := False;
end;

procedure TFrmNotasPendEnt.dgDadosCellClick(Column: TColumn);
begin
   if TabPend.RecordCount > 0 then
   begin
      if Column.FieldName = 'IndSel' then
      begin
         if not (TabPend.State in dsEditModes) then TabPend.Edit;
         TabPendIndSel.AsString := iif(TabPendIndSel.AsString = '0','1','0');
         TabPend.Post;
         dgDados.SelectedField := TabPendNompes;
      end; //if
   end; //if
end;

procedure TFrmNotasPendEnt.dgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
   if Column.Alignment = taCenter       then
      (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText)
   else
   if Column.Alignment = taRightJustify then
   (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText)
   else
   if Column.Alignment = taLeftJustify  then
   (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   if (Column.FieldName = 'IndSel') and (TabPend.RecordCount > 0) then
   begin
      dgDados.Canvas.FillRect(Rect);
      if TabPendIndSel.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; // if
end;

procedure TFrmNotasPendEnt.dgDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (dgDados.DataSource.DataSet.RecNo = dgDados.DataSource.DataSet.RecordCount ) then abort;
end;

procedure TFrmNotasPendEnt.LMDLabeledEdit1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNomPes),'IDPess','Nompes','',0,True);
end;

procedure TFrmNotasPendEnt.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edNomfil),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmNotasPendEnt.btFecharClick(Sender: TObject);
begin
   recIDRec := 0;
   Close;
end;

procedure TFrmNotasPendEnt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
