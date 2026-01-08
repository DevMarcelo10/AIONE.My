unit uPerdas;

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
  VirtualTable, LMDCustomParentPanel, LMDCustomPanelFill, LMDComboBoxExt;

type
  TFrmPerdas = class(TForm)
    SouPerda: TDataSource;
    PanelPri: TLMDSimplePanel;
    PanelProd: TLMDSimplePanel;
    TabPerda: TRESTDWClientSQL;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    TabPerdaIDFilial: TIntegerField;
    TabPerdaIDProd: TIntegerField;
    TabPerdaNroLot: TWideStringField;
    TabPerdaMotivo: TWideStringField;
    TabPerdaQtdPer: TFloatField;
    TabPerdaNroNot: TIntegerField;
    TabPerdaDespro: TWideStringField;
    TabPerdaRegistoMS: TWideStringField;
    TabPerdaStatus: TWideStringField;
    Shape5: TShape;
    PanelRodape: TLMDSimplePanel;
    btImprimir: TAdvGlowButton;
    btIncluir: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    btAlterar: TAdvGlowButton;
    PanelCabecalho: TLMDSimplePanel;
    AdvGlowButton1: TAdvGlowButton;
    Label22: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    edNomfab: TLMDLabeledEdit;
    edNomgru: TLMDLabeledEdit;
    edNomsub: TLMDLabeledEdit;
    ComboLista: TLMDComboBox;
    btLimpaDados: TAdvGlowButton;
    btBuscar: TAdvGlowButton;
    TabPerdaIDPerda: TFDAutoIncField;
    TabPerdaIDInvIni: TIntegerField;
    TabPerdaUsoRece: TWideStringField;
    TabPerdaDatPer: TDateField;
    TabPerdaDatVen: TDateField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabPerdaAfterOpen(DataSet: TDataSet);
    procedure btIncluirClick(Sender: TObject);
    procedure btLimpaDadosClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure edNomfabKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomfabCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomsubCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomsubKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    auxIDInvIni,auxIDFilial:Integer;
    procedure AjustGrid;
    procedure AtuaTabTemp;
  public
    { Public declarations }
  end;

var
  FrmPerdas: TFrmPerdas;

implementation

uses uDM, uConst, uLibFarm, uPerdasInc;

{$R *.dfm}

procedure TFrmPerdas.FormShow(Sender: TObject);
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
      TabPerda.SQL.Text :=
      'SELECT PER.*,PRO.Despro,PRO.RegistoMS FROM arqsngpcper PER '+
      'LEFT JOIN arqproduto PRO ON PER.IDProd = PRO.IDProd '+
      'WHERE PER.IDFilial = '+auxIDFilial.ToString+' AND PER.IDInvIni = '+auxIDInvIni.ToString;
      TabPerda.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   AjustGrid;
end;

procedure TFrmPerdas.TabPerdaAfterOpen(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmPerdas.btAlterarClick(Sender: TObject);
var
   Index:Integer;
begin
   if TabPerda.IsEmpty then
   begin
      MostraMsg('Perda de produto','Nenhum produto selecionado para alterar!',mtWarning, [mbOk]);
      btAlterar.SetFocus;
      Exit;
   end;
   if TabPerdaStatus.AsString = '1' then
   begin
      MostraMsg('Alteração de produto','Produto selecionado já enviado, portanto não pode ser alterado!',mtWarning, [mbOk]);
      btAlterar.SetFocus;
      Exit;
   end;
   try
      FrmPerdasInc := TFrmPerdasInc.Create(Application);
      FrmPerdasInc.recOrigem   := 'ALTERAR';
      FrmPerdasInc.recIDFilial := auxIDFilial;
      FrmPerdasInc.recIDInvIni := auxIDInvIni;
      FrmPerdasInc.cdsPerdas.CreateDataSet;
      FrmPerdasInc.cdsLote.CreateDataSet;
      AtuaTabTemp;
      FrmPerdasInc.ShowModal;
   finally
      FrmPerdasInc.Free;
   end;// try
   Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
   TabPerda.Close;
   TabPerda.Open;
   DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   DBGrid1.Refresh; // Refresca o DBGrid para mostrar a nova posição
end;

procedure TFrmPerdas.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmPerdas.AtuaTabTemp;
begin
   FrmPerdasInc.cdsPerdas.Append;
   FrmPerdasInc.cdsPerdasIDFilial.AsInteger   := TabPerdaIDFilial.AsInteger;
   FrmPerdasInc.cdsPerdasIDPerda.AsInteger    := TabPerdaIDPerda.AsInteger;
   FrmPerdasInc.cdsPerdasIDProd.AsInteger     := TabPerdaIDProd.AsInteger;
   FrmPerdasInc.cdsPerdasNroLot.AsString      := TabPerdaNroLot.AsString;
   FrmPerdasInc.cdsPerdasDesPro.AsString      := TabPerdaDespro.AsString;
   FrmPerdasInc.cdsPerdasRegistroMS.AsString  := TabPerdaRegistoMS.AsString;
   FrmPerdasInc.cdsPerdasQtdPer.AsFloat       := TabPerdaQtdPer.AsFloat;
   FrmPerdasInc.cdsPerdasDataPerda.AsDateTime := TabPerdaDatPer.AsDateTime;
   FrmPerdasInc.cdsPerdasDataVenc.AsDateTime  := TabPerdaDatVen.AsDateTime;
   FrmPerdasInc.cdsPerdasMotivo.AsString      := TabPerdaMotivo.AsString;
   FrmPerdasInc.cdsPerdasStatus.AsString      := TabPerdaStatus.AsString;
   FrmPerdasInc.cdsPerdasIDInvIni.AsInteger   := TabPerdaIDInvIni.AsInteger;
   FrmPerdasInc.cdsPerdasUsoRece.AsString     := TabPerdaUsoRece.AsString;
   FrmPerdasInc.cdsPerdasNroNot.AsInteger     := TabPerdaNroNot.AsInteger;
   FrmPerdasInc.cdsPerdas.Post;
end;

procedure TFrmPerdas.btLimpaDadosClick(Sender: TObject);
begin
   edDataIni.Text := '';
   edDataFin.Text := '';
   edNomfab.Tag   := 0;
   edNomfab.Text  := '';
   edNomgru.Tag   := 0;
   edNomgru.Text  := '';
   edNomsub.Tag   := 0;
   edNomsub.Text  := '';
   ComboLista.ItemIndex := -1;
end;

procedure TFrmPerdas.btIncluirClick(Sender: TObject);
var
   Index:Integer;
begin
   try
      FrmPerdasInc := TFrmPerdasInc.Create(Application);
      FrmPerdasInc.recOrigem   := 'INCLUIR';
      FrmPerdasInc.recIDFilial := auxIDFilial;
      FrmPerdasInc.recIDInvIni := auxIDInvIni;
      FrmPerdasInc.cdsPerdas.CreateDataSet;
      FrmPerdasInc.cdsLote.CreateDataSet;
      FrmPerdasInc.ShowModal;
   finally
      FrmPerdasInc.Free;
   end;// try
   Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
   TabPerda.Close;
   TabPerda.Open;
   DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   DBGrid1.Refresh; // Refresca o DBGrid para mostrar a nova posição
end;

procedure TFrmPerdas.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 9 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+2, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end; //if
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

procedure TFrmPerdas.edNomfabCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNomfab),'IDPess','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',0,True);
end;

procedure TFrmPerdas.edNomfabKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscas('arqpessoa',TLMDEdit(edNomfab),'IDPess','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',0,True);
end;

procedure TFrmPerdas.edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgrupo',TLMDEdit(edNomgru),'IDGrupo','Desgru','',0,True);
end;

procedure TFrmPerdas.edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscas('arqgrupo',TLMDEdit(edNomgru),'IDGrupo','Desgru','',0,True);
end;

procedure TFrmPerdas.edNomsubCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if edNomgru.Tag > 0 then
      btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','IDGrupo = '+edNomgru.Tag.ToString,0,True)
   else
      btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','',0,True);
end;

procedure TFrmPerdas.edNomsubKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      if edNomgru.Tag > 0 then
         btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','IDGrupo = '+edNomgru.Tag.ToString,0,True)
      else
         btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','',0,True);
   end;// if
end;

procedure TFrmPerdas.btBuscarClick(Sender: TObject);
begin
   TabPerda.Close;
   TabPerda.SQL.Clear;
   TabPerda.SQL.Add('SELECT PER.*, PRO.Despro,PRO.RegistoMS FROM arqsngpcper PER '+
                    'LEFT JOIN arqproduto PRO ON PER.IDProd = PRO.IDProd '+
                    'LEFT JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess'+
                     ' WHERE PER.IDFilial = '+auxIDFilial.ToString+
                     ' AND PER.IDInvIni = '+auxIDInvIni.ToString);
   if (edDataIni.Date > 0) and (edDataFin.Date > 0) then
      TabPerda.SQL.Add(' AND DatPer BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDataIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDataFin.Date)));
   if (edNomfab.Tag > 0) and (edNomfab.Text <> '') then
      TabPerda.SQL.Add(' AND PRO.IDFabr = '+edNomfab.Tag.ToString);
   if (edNomgru.Tag > 0) and (edNomgru.Text <> '') then
      TabPerda.SQL.Add(' AND PRO.IDGrupo = '+edNomgru.Tag.ToString);
   if (edNomsub.Tag > 0) and (edNomsub.Text <> '') then
      TabPerda.SQL.Add(' AND PRO.IDGruSub = '+edNomsub.Tag.ToString);
   if ComboLista.ItemIndex > 0 then
      TabPerda.SQL.Add(' AND PRO.UsoRece = '+Aspas(ComboLista.Items[ComboLista.ItemIndex]));
   TabPerda.Open;
end;

procedure TFrmPerdas.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   Index:Integer;
begin
   if TabPerda.IsEmpty then
   begin
      MostraMsg('Exclusão de produto','Nenhum produto selecionado para excluir!',mtWarning, [mbOk]);
      btExcluir.SetFocus;
      Exit;
   end;// if
   if TabPerdaStatus.AsString = '1' then
   begin
      MostraMsg('Exclusão de produto','Produto selecionado já enviado, portanto não pode ser excluído!',mtWarning, [mbOk]);
      btExcluir.SetFocus;
      Exit;
   end;

   if MostraMsg('Confirmação','Deseja excluir produto '+TabPerdaDespro.AsString+' ?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'DELETE FROM arqsngpcper'+
                             ' WHERE IDPerda = '+TabPerdaIDPerda.AsString;
         QueAuxi.ExecSQL;
      except // try
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir a nota fiscal de arqsngpcper em uPerdas -> '+E.Message);
            MostraMsg('Erro','Não foi possível excluir o produto.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
   TabPerda.Close;
   TabPerda.Open;
   DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   DBGrid1.Refresh; // Refresca o DBGrid para mostrar a nova posição
end;

procedure TFrmPerdas.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPerdas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPerda.Close;
end;

end.

