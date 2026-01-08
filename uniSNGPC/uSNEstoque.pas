unit uSNEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDLabel, DB,
  LMDBaseGraphicControl, LMDBaseLabel, LMDEdit, LMDCustomLabel, LMDControl, Vcl.Mask,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.StdCtrls,
  RxToolEdit, RxDBCtrl, LMDBaseEdit, LMDCustomEdit, AdvSmoothPanel, LMDDBEdit, MarcLib,
  LMDListComboBox, LMDDBListComboBox, AdvGlowButton, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  LMDButtonControl, LMDCustomParentPanel, uRESTDWBasicTypes, uRESTDWBasicDB, LMDThemedComboBox,
  LMDCustomComboBox, LMDComboBox, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmSNEstoq = class(TForm)
    PanelPri: TLMDSimplePanel;
    LMDSimplePanel6: TLMDSimplePanel;
    Shape5: TShape;
    Label22: TLabel;
    Label1: TLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btBuscar: TAdvGlowButton;
    edNomfab: TLMDLabeledEdit;
    edNomgru: TLMDLabeledEdit;
    edNomsub: TLMDLabeledEdit;
    ComboLista: TLMDComboBox;
    Label2: TLabel;
    TabSNLote: TRESTDWClientSQL;
    SouSNLote: TDataSource;
    TabSNLoteIDFilial: TIntegerField;
    TabSNLoteIDProd: TIntegerField;
    TabSNLoteNrolot: TWideStringField;
    TabSNLoteIDPess: TIntegerField;
    TabSNLoteDatfab: TDateField;
    TabSNLoteDatven: TDateField;
    TabSNLoteQtdest: TFloatField;
    TabSNLoteNompes: TWideStringField;
    TabSNLoteDespro: TWideStringField;
    TabSNLoteRegistoMS: TWideStringField;
    LMDSimplePanel3: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelCabecalho: TLMDSimplePanel;
    LMDLabel15: TLMDLabel;
    LMDLabel1: TLMDLabel;
    edResTec: TLMDDBLabeledEdit;
    panelDataAbert: TLMDSimplePanel;
    edDataAbert: TDBDateEdit;
    edCPFRestec: TLMDDBLabeledEdit;
    panelDataEncer: TLMDSimplePanel;
    edDataEncer: TDBDateEdit;
    edNumInv: TLMDDBLabeledEdit;
    edConselho: TLMDDBLabeledEdit;
    edReg: TLMDDBLabeledEdit;
    edUF: TLMDDBLabeledEdit;
    edNumLicSan: TLMDDBLabeledEdit;
    edEmailSiteSNGPC: TLMDDBLabeledEdit;
    edSenhaSNGPC: TLMDDBLabeledEdit;
    edStatusInv: TLMDDBLabeledEdit;
    btFechar: TAdvGlowButton;
    Shape2: TShape;
    TabInvent: TRESTDWClientSQL;
    SouInvent: TDataSource;
    TabInventIDFilial: TIntegerField;
    TabInventIDInvIni: TIntegerField;
    TabInventIDPess: TIntegerField;
    TabInventDataAbe: TDateField;
    TabInventMailSNGPC: TWideStringField;
    TabInventSenhaSNGPC: TWideStringField;
    TabInventIndFecha: TWideStringField;
    TabInventDataEnc: TDateField;
    TabInventNumLicenSanita: TWideStringField;
    TabInventCPFResTec: TWideStringField;
    TabInventNroRegProf: TWideStringField;
    TabInventConRegProf: TWideStringField;
    TabInventEstRegProf: TWideStringField;
    TabInventNompes: TWideStringField;
    edInv: TLMDLabeledEdit;
    TabSNLoteIDInvIni: TIntegerField;
    TabSNLoteUsoRece: TWideStringField;
    PanelRodape: TLMDSimplePanel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    btAltDataVenc: TAdvGlowButton;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    btLimpaDados: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edInvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edInvCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edStatusInvChange(Sender: TObject);
    procedure edNomfabCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomsubCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btBuscarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btAltDataVencClick(Sender: TObject);
    procedure TabSNLoteAfterOpen(DataSet: TDataSet);
    procedure TabSNLoteAfterPost(DataSet: TDataSet);
    procedure edNomfabKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvGlowButton2Click(Sender: TObject);
    procedure btLimpaDadosClick(Sender: TObject);
    procedure edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomsubKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    auxIDFil:Integer;
    auxDatVen:TDateTime;
    auxIDFilial,auxIDInvIni,auxIDProd,auxPegaPos:Integer;
    auxRectLeft,auxRectTop,auxRectLeftIni,auxRectTopIni:Integer;
    auxNrolot:String;
    vErro: String;
    aPosCelDbgrid: array of integer;
    procedure AjustGrid;
    procedure carregaInventario;
    procedure GravaDatVen;
//    procedure AlteraDataVenctoGrid(Sender: TObject; const dataVencto: string);
    procedure AbreSQL;
  public
    { Public declarations }
    DatVEncimento:TDateTime;
  end;

var
  FrmSNEstoq: TFrmSNEstoq;

implementation

uses uDM, uConst, uLibFarm, uBuscaInv, uAlteraDataVenci, uProdutoCad;

{$R *.dfm}

procedure TFrmSNEstoq.FormShow(Sender: TObject);
begin
   Left := (Parent.Width  - Width)  div 2;
   Top  := (Parent.Height - Height) div 2;
   AbreSQL;
   edDataIni.SetFocus;
   AjustGrid;
   auxDatVen := 1;
   SetLength(aPosCelDbgrid, TabSNLote.RecordCount);
end;

procedure TFrmSNEstoq.AbreSQL;
begin
   TabInvent.Close;
   TabInvent.SQL.Clear;
   TabInvent.SQL.Text := 'SELECT INV.*,PES.Nompes FROM arqsngpcinve INV '+
                         'LEFT JOIN arqpessoa PES ON INV.IDPess = PES.IDPess'+
                         ' WHERE INV.IDFilial = '+FILIAL.ToString+
                         ' AND INV.IndFecha = 1';
   TabInvent.Open;

   TabSNLote.Close;
   TabSNLote.SQL.Text := 'SELECT LOT.*, PES.Nompes,PRO.Despro,PRO.RegistoMS FROM arqsngpclot LOT '+
                         'LEFT JOIN arqproduto PRO ON LOT.IDProd = PRO.IDProd '+
                         'LEFT JOIN arqpessoa PES ON LOT.IDPess = PES.IDPess'+
                         ' WHERE LOT.IDFilial = '+FILIAL.ToString+
                         ' AND LOT.IDInvIni = '+Aspas(TabInventIDInvIni.AsString)+
                         ' AND Qtdest > 0';
   TabSNLote.Open;
end;

procedure TFrmSNEstoq.carregaInventario;
begin
   TabInvent.Close;
   TabInvent.SQL.Clear;
   TabInvent.SQL.Text := 'SELECT INV.*,PES.Nompes FROM arqsngpcinve INV '+
                         'LEFT JOIN arqpessoa PES ON INV.IDPess = PES.IDPess'+
                         ' WHERE INV.IDFilial = '+FILIAL.ToString+
                         ' AND INV.IDInvIni = '+Aspas(IntToStr(edInv.Tag));
   TabInvent.Open;

   TabSNLote.Close;
   TabSNLote.SQL.Text := 'SELECT LOT.*, PES.Nompes,PRO.Despro,PRO.RegistoMS FROM arqsngpclot LOT '+
                         'LEFT JOIN arqproduto PRO ON LOT.IDProd = PRO.IDProd '+
                         'LEFT JOIN arqpessoa PES ON LOT.IDPess = PES.IDPess'+
                         ' WHERE LOT.IDFilial = '+FILIAL.ToString+
                         ' AND LOT.IDInvIni = '+Aspas(TabInventIDInvIni.AsString)+
                         ' AND Qtdest > 0';
   TabSNLote.Open;
end;

procedure TFrmSNEstoq.AdvGlowButton2Click(Sender: TObject);
var
   auxIDProd:Integer;
begin
   try
      Application.CreateForm(TFrmProdCad, FrmProdCad);
      if TabSNLoteIDProd.AsInteger > 0 then
      begin
         FrmProdCad.recIDProd := TabSNLoteIDProd.AsInteger;
         FrmProdCad.recDespro := TabSNLoteDespro.AsString;
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
end;

procedure TFrmSNEstoq.btLimpaDadosClick(Sender: TObject);
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

procedure TFrmSNEstoq.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmSNEstoq.GravaDatVen;
var
   QueAuxi:TRESTDWClientSQL;
   auxPos: TBookmark;
   Frm: Tform;
   Msg: Tlabel;
   Borda: TShape;
begin
   //////////////////////////////////////////////////////////////////////////////////
   ///Mensagem de "Aguarde" enquanto executa o procedimento de carregamento do XML///
   Frm             :=  TForm.Create(Application);
   Frm.BorderStyle := bsNone;
   Frm.Position    := poDesktopCenter;
   Frm.Width       := 300;
   Frm.Height      := 170; //até aqui criamos o form

   Borda        := TShape.Create(Application);
   Borda.Parent := Frm;
   Borda.Align  := alClient; // uma borda envolta do form

   Msg             :=TLabel.Create(Application);
   Msg.Parent      :=Frm;
   Msg.Transparent := true;
   Msg.AutoSize    := false;
   Msg.Font.Size   := 28;
   Msg.Width       := 300;
   Msg.Height      := 168;
   Msg.Caption     :=#13 + 'Aguarde...';
   msg.Align       := TAlign(5);
   Msg.Alignment   := taCenter;//label com a mensagem "Aguarde"
   Frm.Show;
   Frm.Update;
   //////////////////////////////////////////////////
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'UPDATE arqsngpclot SET '+
                             'Datven = '+Aspas(FormatDateTime('yyyy-mm-dd',TabSNLoteDatven.AsDateTime))+
                             ' WHERE IDFilial = '+TabSNLoteIDFilial.AsString+
                             ' AND IDInvIni = '+TabSNLoteIDInvIni.AsString+
                             ' AND IDProd = '+TabSNLoteIDProd.AsString+
                             ' AND Nrolot = '+TabSNLoteNrolot.AsString;

         QueAuxi.ExecSQL(vErro);
      except // try
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível fazer a alteração do número do lote TabCompRecLot em uEntradaLote -> '+E.Message);
            MostraMsg('Erro','Não foi possível alterar o número do lote.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
      auxPos := TabSNLote.GetBookmark;  // Pegamos o registro atual
      TabSNLote.Close;
      TabSNLote.Open;
      TabSNLote.GotoBookmark(auxPos); // Setamos a query para o registro que ela se encontrava
      TabSNLote.FreeBookmark(auxPos);
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      Frm.Free; //E finalmente libera a janela da mensagem de aguarde.
   end;// try
end;

procedure TFrmSNEstoq.TabSNLoteAfterOpen(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmSNEstoq.TabSNLoteAfterPost(DataSet: TDataSet);
begin
   GravaDatVen;
end;

procedure TFrmSNEstoq.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmSNEstoq.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (DBGrid1.DataSource.DataSet.RecNo = DBGrid1.DataSource.DataSet.RecordCount )  then
      abort;
end;

procedure TFrmSNEstoq.edInvCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
   recWidth:Integer;
begin
   try
      recWidth:= 0;
      FrmBuscaInv  := TFrmBuscaInv.Create(Application);
      lPoint := Self.edInv.ClientToScreen(Point(0,0));
      FrmBuscaInv.Left   := lPoint.X;
      FrmBuscaInv.Top    := lPoint.Y;
      FrmBuscaInv.Width:= iif(recWidth > 0, recWidth, Self.edInv.Width);
      FrmBuscaInv.edRetorno    := TEdit(Self.edInv);
      FrmBuscaInv.edBusca.Text := TrataTecNum(Index); // Tecla precionada que esta vindo do edit edNompro (Busca produto)
      FrmBuscaInv.ShowModal;
   finally
      edInv.Text := FrmBuscaInv.auxNompes;
      edInv.Tag  := FrmBuscaInv.edRetorno.Tag;
      FrmBuscaInv.Free;
   end;// try
   if edInv.Tag > 0 then
   begin
      carregaInventario;
      if not (TabInventIndFecha.AsString = '1') then
         PanelRodape.Enabled := False
      else
         PanelRodape.Enabled := True;
   end;// if
end;

procedure TFrmSNEstoq.edInvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if not(ssCtrl in Shift) then
   begin
      if (Key = VK_RETURN) or (Key = VK_TAB) then
      begin
         if (Key = VK_RETURN) and (Trim(edInv.Text) = EmptyStr) then
         begin
            edInv.Text := '';
            edInv.Tag  := 0;
            Key:= 0;
            Exit;
         end;// if

         if Trim(edInv.Text) = '' then Exit;
         soInteger := iif(ExisteStr(Trim(edInv.Text)), '', OnlyNumbers(edInv.Text));
         if soInteger = '' then
         begin
            key := 0;
            edInvCustomButtons0Click(Self, Key);
         end;// if
      end// if
      else if Key = VK_ESCAPE then
      begin
         edInv.Text := '';
         edInv.Tag  := 0;
      end else
      begin
         edInvCustomButtons0Click(Self, key);
         key := 0;
      end;// if
   end;// if
end;

procedure TFrmSNEstoq.edNomfabCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNomfab),'IDPess','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',0,True);
end;

procedure TFrmSNEstoq.edNomfabKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscas('arqpessoa',TLMDEdit(edNomfab),'IDPess','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',0,True);
end;

procedure TFrmSNEstoq.edNomgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgrupo',TLMDEdit(edNomgru),'IDGrupo','Desgru','',0,True);
end;

procedure TFrmSNEstoq.edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscas('arqgrupo',TLMDEdit(edNomgru),'IDGrupo','Desgru','',0,True);
end;

procedure TFrmSNEstoq.edNomsubCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if edNomgru.Tag > 0 then
      btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','IDGrupo = '+edNomgru.Tag.ToString,0,True)
   else
      btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','',0,True);
end;

procedure TFrmSNEstoq.edNomsubKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      if edNomgru.Tag > 0 then
         btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','IDGrupo = '+edNomgru.Tag.ToString,0,True)
      else
         btBuscas('arqgruposub',TLMDEdit(edNomsub),'IDGruSub','DesgruSub','',0,True);
end;

procedure TFrmSNEstoq.edStatusInvChange(Sender: TObject);
begin
   if TabInventIndFecha.AsString = '0' then
      edStatusInv.Text := 'ABERTO'
   else if TabInventIndFecha.AsString = '1' then
      edStatusInv.Text := 'CONFIRMADO'
   else if TabInventIndFecha.AsString = '2' then
      edStatusInv.Text := 'ENCERRADO';
end;

procedure TFrmSNEstoq.btAltDataVencClick(Sender: TObject);
var
   lPoint:TPoint;
   auxDatVenc:TDateTime;
begin
//   DBGrid1.Fields[5].FocusControl;
   DBGrid1.Options := DBGrid1.Options + [dgRowSelect];
   AjustGrid;
   try
      FrmAlteraDataVenci := TFrmAlteraDataVenci.Create(Application);
      lPoint := Self.btAltDataVenc.ClientToScreen(Point(0,0));
      FrmAlteraDataVenci.Left   := lPoint.X;
      FrmAlteraDataVenci.Top    := lPoint.Y - FrmAlteraDataVenci.Height;
      FrmAlteraDataVenci.edDataVenc.Date := TabSNLoteDatven.AsDateTime;
      FrmAlteraDataVenci.ShowModal;
   finally
      auxDatVenc := FrmAlteraDataVenci.edDataVenc.Date;
      FrmAlteraDataVenci.Free;
   end;// try
   DBGrid1.Options := DBGrid1.Options - [dgRowSelect];
   AjustGrid;
   if not (TabSNLoteDatven.AsDateTime = auxDatVenc) then
   begin
      TabSNLote.Edit;
      TabSNLoteDatven.AsDateTime := FrmAlteraDataVenci.edDataVenc.Date;
      TabSNLote.Post;
   end;// if
end;

procedure TFrmSNEstoq.btBuscarClick(Sender: TObject);
begin
   TabSNLote.Close;
   TabSNLote.SQL.Clear;
   TabSNLote.SQL.Add('SELECT LOT.*, PES.Nompes,PRO.Despro,PRO.RegistoMS FROM arqsngpclot LOT '+
                     'LEFT JOIN arqproduto PRO ON LOT.IDProd = PRO.IDProd '+
                     'LEFT JOIN arqpessoa PES ON LOT.IDPess = PES.IDPess'+
                     ' WHERE LOT.IDFilial = '+FILIAL.ToString+
                     ' AND LOT.IDInvIni = '+Aspas(TabInventIDInvIni.AsString));
   if (edDataIni.Date > 0) and (edDataFin.Date > 0) then
      TabSNLote.SQL.Add(' AND Datven BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDataIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDataFin.Date)));
   if (edNomfab.Tag > 0) and (edNomfab.Text <> '') then
      TabSNLote.SQL.Add(' AND LOT.IDPess = '+edNomfab.Tag.ToString);
   if (edNomgru.Tag > 0) and (edNomgru.Text <> '') then
      TabSNLote.SQL.Add(' AND PRO.IDGrupo = '+edNomgru.Tag.ToString);
   if (edNomsub.Tag > 0) and (edNomsub.Text <> '') then
      TabSNLote.SQL.Add(' AND PRO.IDGruSub = '+edNomsub.Tag.ToString);
   if ComboLista.ItemIndex > 0 then
      TabSNLote.SQL.Add(' AND PRO.UsoRece = '+Aspas(ComboLista.Items[ComboLista.ItemIndex]));
   TabSNLote.Open;
end;

procedure TFrmSNEstoq.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmSNEstoq.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabSNLote.Close;
end;

end.

