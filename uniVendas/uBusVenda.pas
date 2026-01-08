unit uBusVenda;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, RxToolEdit,
   System.Actions, Vcl.ActnList, Vcl.Menus, System.Math;

type
  TFrmBusVenda = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    TabPedido: TRESTDWClientSQL;
    SouPedido: TDataSource;
    pnPrincipal: TLMDSimplePanel;
    Label21: TLabel;
    edNompes: TLMDLabeledEdit;
    Label1: TLabel;
    edNompro: TLMDLabeledEdit;
    Label22: TLabel;
    Label2: TLabel;
    edDatIni: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btBuscar: TAdvGlowButton;
    lbNotaFiscal: TLabel;
    edNotaFiscal: TLMDLabeledEdit;
    Label3: TLabel;
    edIDPed: TLMDLabeledEdit;
    TabPedidoIte: TRESTDWClientSQL;
    SouPedidoIte: TDataSource;
    Label5: TLabel;
    edNomven: TLMDLabeledEdit;
    TabPedidoIDFilial: TIntegerField;
    TabPedidoIDPed: TIntegerField;
    TabPedidoDatped: TDateTimeField;
    TabPedidoIDPess: TIntegerField;
    TabPedidoIDDesc: TIntegerField;
    TabPedidoIDConv: TIntegerField;
    TabPedidoIDCaixa: TIntegerField;
    TabPedidoIDVend: TIntegerField;
    TabPedidoIDPBM: TIntegerField;
    TabPedidoIDEntre: TIntegerField;
    TabPedidoIDForPag: TSmallintField;
    TabPedidoTotDesc: TFloatField;
    TabPedidoTotPedido: TFloatField;
    TabPedidoNroNFC: TIntegerField;
    TabPedidoEmiNF: TDateTimeField;
    TabPedidoChaveNFC: TWideStringField;
    TabPedidoProtoNFC: TWideStringField;
    TabPedidoResulNFC: TWideStringField;
    TabPedidoIndEntr: TWideStringField;
    TabPedidoStatus: TWideStringField;
    TabPedidoDatHorAlt: TDateTimeField;
    TabPedidoIndDelete: TWideStringField;
    TabPedidoNomeCli: TWideStringField;
    TabPedidoNomPBM: TWideStringField;
    TabPedidoNomcon: TWideStringField;
    TabPedidoNomven: TWideStringField;
    TabPedidoIteIDFilial: TIntegerField;
    TabPedidoIteIDPed: TIntegerField;
    TabPedidoIteNroite: TSmallintField;
    TabPedidoIteIDProd: TIntegerField;
    TabPedidoIteNrolot: TWideStringField;
    TabPedidoIteIDVend: TIntegerField;
    TabPedidoIteIndComi: TBooleanField;
    TabPedidoItePrecoVen: TFloatField;
    TabPedidoItePrecoPMC: TFloatField;
    TabPedidoItePrecoFP: TFloatField;
    TabPedidoItePrecoFab: TFloatField;
    TabPedidoIteCustoMed: TFloatField;
    TabPedidoIteVlrPIS: TFloatField;
    TabPedidoIteVlrCOF: TFloatField;
    TabPedidoIteQtdped: TFloatField;
    TabPedidoItePerDesc: TFloatField;
    TabPedidoIteVlrDesc: TFloatField;
    TabPedidoIteVlrVenda: TFloatField;
    TabPedidoIteDatHorAlt: TDateTimeField;
    TabPedidoIteDespro: TWideStringField;
    TabPedidoIteNomeFab: TWideStringField;
    TabPedidoIteUsoRece: TWideStringField;
    TimerDebounce: TTimer;
    ActionList1: TActionList;
    acBuscaFechar: TAction;
    pnGeralVenda: TLMDSimplePanel;
    pnGridVenda: TLMDSimplePanel;
    pnCabPedido: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    dbgPedido: TDBGrid;
    pnCabItens: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    dbgItens: TDBGrid;
    LMDSimplePanel1: TLMDSimplePanel;
    btImprimir: TAdvGlowButton;
    btGeraNotaFiscal: TAdvGlowButton;
    btDigitalizar: TAdvGlowButton;
    btInformações: TAdvGlowButton;
    pmImprimir: TPopupMenu;
    Cupom1: TMenuItem;
    Pedido1: TMenuItem;
    pmDigitalizar: TPopupMenu;
    Cupom2: TMenuItem;
    Receita1: TMenuItem;
    acBuscaSair: TAction;
    TabPedidoNroCesta: TWideStringField;
    TabPedidoForPagto: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbgPedidoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensCellClick(Column: TColumn);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btBuscarClick(Sender: TObject);
    procedure edNomvenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edNomvenCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomproKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure dbgPedidoDblClick(Sender: TObject);
    procedure edNompesCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edNomvenCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edNomproCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edNotFisCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edIDPedCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDataIniKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerDebounceTimer(Sender: TObject);
    procedure dbgPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure acBuscaFecharExecute(Sender: TObject);
    procedure btImprimirClick(Sender: TObject);
    procedure acBuscaSairExecute(Sender: TObject);
    procedure dbgPedidoCellClick(Column: TColumn);
 private
    { Private declarations }
    FExibirAtalhos: Boolean;
    FIDPed_UltimoClick: Integer;
    procedure AjustGrid(dbGrid: TDBGrid);
    procedure MostraAtalhos(Exibir: Boolean);
 public
    { Public declarations }
    recTipBusca:String;
    retIDPed: Integer;
    retStatusPed: String;
 end;

var
   FrmBusVenda: TFrmBusVenda;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaPro;

procedure TFrmBusVenda.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBusVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    acBuscaSair.OnExecute(Sender);
  end;
  //CTRL + H
  if (Key = 72) and (ssCtrl in Shift) then
  begin
    FExibirAtalhos:= not(FExibirAtalhos);
    //
    MostraAtalhos(FExibirAtalhos);
    //
    key:= 0;
  end;
end;

procedure TFrmBusVenda.MostraAtalhos(Exibir: Boolean);
var
  I: Integer;
  Componente: TComponent;
  Botao: TAdvGlowButton;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    Componente := Components[I];
    if Componente is TAdvGlowButton then
    begin
      Botao := TAdvGlowButton(Componente);
      if Botao.ShortCutHint <> '' then
      begin
        if Exibir then
          Botao.ShowShortCutHint
        else
          Botao.HideShortCutHint;
      end;
    end;
  end;
end;

procedure TFrmBusVenda.FormShow(Sender: TObject);
begin
   if recTipBusca = 'F' then // Status = F (Venda Finalizada)
   begin
     lbTitulo.Caption:= 'BUSCA VENDAS';

     lbNotaFiscal.Visible:= True;
     edNotaFiscal.Visible:= True;

     btImprimir.Visible:= True;
     btGeraNotaFiscal.Visible:= True;
     btDigitalizar.Visible:= True;
     btInformações.Visible:= True;
   end else                  // Status = A (Venda em Aberto)
   begin
     lbTitulo.Caption:= 'PEDIDOS PENDENTES';

     lbNotaFiscal.Visible:= False;
     edNotaFiscal.Visible:= False;

     btImprimir.Visible:= True;
     btGeraNotaFiscal.Visible:= False;
     btDigitalizar.Visible:= False;
     btInformações.Visible:= True;
   end;


   // Mostrar o dial atual
   edDataIni.date:= DataServer;
   edDataFin.date:= DataServer;
   //
   FrmBusVenda.retIDPed:= 0;
   //
   AjustGrid(dbgPedido);
end;

procedure TFrmBusVenda.TimerDebounceTimer(Sender: TObject);
begin
  TabPedidoIte.DisableControls;
  TabPedidoIte.Close;
  TabPedidoIte.ParamByName('IDFilial').AsInteger:= TabPedidoIDFilial.AsInteger;
  TabPedidoIte.ParamByName('IDPed').AsInteger:= TabPedidoIDPed.AsInteger;
  TabPedidoIte.Open;
  TabPedidoIte.EnableControls;
  TimerDebounce.Enabled:= False;
end;

procedure TFrmBusVenda.acBuscaFecharExecute(Sender: TObject);
begin
  // Vendas Finalizadas é apenas para consulta, não retornam IDPedido para Vendas
  if recTipBusca = 'A' then // Status = A (Venda em Aberto)
  begin
    retIDPed:= TabPedido.FieldByName('IDPed').AsInteger;
    retStatusPed:=  TabPedido.FieldByName('Status').AsString;
    FrmBusVenda.Close;
  end;
end;

procedure TFrmBusVenda.acBuscaSairExecute(Sender: TObject);
begin
  retIDPed:= 0;
  retStatusPed:=  '';
  FrmBusVenda.Close;
end;

procedure TFrmBusVenda.AjustGrid(dbGrid: TDBGrid);
begin
   TStringGrid(dbGrid).DefaultRowHeight := BaseRowHeight - 5;
   dbGrid.Width := dbGrid.Width - 10;
   dbGrid.Width := dbGrid.Width + 10;
end;

procedure TFrmBusVenda.dbgPedidoCellClick(Column: TColumn);
begin
  if FIDPed_UltimoClick <> TabPedidoIDPed.AsInteger then
  begin
    FIDPed_UltimoClick:= TabPedidoIDPed.AsInteger;

    // Reinicia o timer a cada Click se o IDPed mudou
    TimerDebounce.Enabled := False;
    TimerDebounce.Enabled := True;
  end;
end;

procedure TFrmBusVenda.dbgPedidoDblClick(Sender: TObject);
begin
  acBuscaFechar.OnExecute(Sender);
end;

procedure TFrmBusVenda.dbgPedidoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   if Column.FieldName = 'IndSel' then
   begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmBusVenda.dbgPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then
  begin
    // Reinicia o timer a cada tecla pressionada
    TimerDebounce.Enabled := False;
    TimerDebounce.Enabled := True;
  end;
end;

procedure TFrmBusVenda.dbgPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    acBuscaFechar.OnExecute(Sender);
  end;
end;

procedure TFrmBusVenda.dbgItensCellClick(Column: TColumn);
begin
   {if Column.FieldName = 'IndSel' then
   begin
      if not (TabPedidoIte.State in dsEditModes) then TabPedidoIte.Edit;
      TabPedidoIteIndSel.AsString := iif(TabPedidoIteIndSel.AsString = '0','1','0');
      TabPedidoIte.Post;
      DBGrid2.SelectedField := TabPedidoIteVlrVenda;
   end; //if }
end;

procedure TFrmBusVenda.edDataIniKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(Sender as TWinControl, True, True);
  end;
end;

procedure TFrmBusVenda.edIDPedCustomButtons0Click(Sender: TObject; index: Integer);
begin
  edIDPed.Text:= '';
end;

procedure TFrmBusVenda.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',0,True);
end;

procedure TFrmBusVenda.edNompesCustomButtons1Click(Sender: TObject; index: Integer);
begin
  edNompes.Tag:= 0;
  edNompes.Text:= '';
end;

procedure TFrmBusVenda.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',Key,False);
   end;
end;

procedure TFrmBusVenda.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   //if not(TabelaRet.State in dsEditModes) then TabelaRet.Edit;

   {if Carc = 27 then  //-- Tecla ESC -> Limpa Campo -- //
   begin
      EditBase.Tag  := 0;
      EditBase.Text := '';
      TabelaRet.FieldByName(CampoRet).AsInteger := 0;
      TabelaRet.FieldByName(recCampoShow).AsString := '';
      Exit;
   end;}

   try
      var recWidth:= 0;

      //_DESPRO := '';
      //_NOMFAB := '';
      //edFabr.Clear;
      //edNompro.Tag := 0; // IDProd
      FrmBuscaPro  := TFrmBuscaPro.Create(Application);
      with FrmBuscaPro do
      begin
         lPoint := Self.edNompro.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         //CampoRetor  := CampoRet;
         //CampoOrigem := CampoOri;
         //CampoBusca  := CampoBus;
         //ArqBusca    := TabelaBus;
         //ArqRetorno  := TabelaRet;
         //Filtro      := FiltroRec;
         //recCarc     := Carc;
         //CampoShow   := recCampoShow;
         //WidthColuna := recWidth;
         Width:= iif(recWidth > 0, recWidth, Self.edNompro.Width);
         //if (Char(Carc) in ['0'..'9']) or (Char(Carc) in ['A'..'Z']) or (Char(Carc) in ['a'..'z']) then edBusca.Text := Char(Carc);
         edRetorno    := TEdit(Self.edNompro);
         edBusca.Text := Self.edNompro.Text;
         ShowModal;
      end; // with
   finally
      //Self.retProdBusca:= FrmBuscaPro.prodBusca;
      FrmBuscaPro.Free;
   end;
   //edNompro.Text := _DESPRO;
   //edFabr.Text   := _NOMFAB;
   //
   {if retProdBusca.IDProd > 0 then
   begin
     edNompro.Text := retProdBusca.Despro;
     edNompro.Tag  := retProdBusca.IDProd;
     edFabr.Text   := retProdBusca.Nomefab;
     edQtdped.AsFloat:= 1;
     edVlrVenda.AsFloat:= retProdBusca.PrecoVen;

     edQtdpedExit(edQtdped);

     //if edNompro.Tag > 0 then edQtdped.SetFocus;
     edQtdped.SetFocus;
   end;}
end;

procedure TFrmBusVenda.edNomproCustomButtons1Click(Sender: TObject; index: Integer);
begin
  edNompro.Tag:= 0;
  edNompro.Text:= '';
end;

procedure TFrmBusVenda.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if (Key = VK_RETURN) or (Key = VK_TAB) then
   begin
      if Trim(edNompro.Text) = '' then Exit;
      soInteger := iif(ExisteStr(Trim(edNompro.Text)), '', OnlyNumbers(edNompro.Text));
      if soInteger = '' then edNomproCustomButtons0Click(Self,0);
      key := 0;
      //edQtdped.SetFocus;
   end
   else if Key = VK_ESCAPE then
   begin
      //edFabr.Text   := '';
      //edNompro.Text := '';
      //edNompro.Tag  := 0;
   end;
end;

procedure TFrmBusVenda.edNomvenCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNomven),'IDPess','Nompes',
      '(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,0,True);
end;

procedure TFrmBusVenda.edNomvenCustomButtons1Click(Sender: TObject; index: Integer);
begin
  edNomven.Tag:= 0;
  edNomven.Text:= '';
end;

procedure TFrmBusVenda.edNomvenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      btBuscas('arqpessoa',TLMDEdit(edNomven),'IDPess','Nompes',
         '(IDEsppes = 9 OR IDEsppes = 12) AND IDFilial = '+FILIAL.ToString,Key,True);
   end;
end;

procedure TFrmBusVenda.edNotFisCustomButtons0Click(Sender: TObject; index: Integer);
begin
  edNotaFiscal.Text:= '';
end;

procedure TFrmBusVenda.btBuscarClick(Sender: TObject);
var
  prDataInicial, prDataFinal, prStatus, prFilial, prCliente, prVendedor, prProduto: String;
begin
  TabPedidoIte.Close;
  TabPedido.Close;
  // Itens Pedido
  TabPedidoIte.SQL.Text:= 'SELECT PEI.*,PRO.Despro, FAB.Nompes AS NomeFab,UsoRece FROM arqpedidoite PEI '+
                          'LEFT JOIN arqproduto PRO ON PEI.IDProd = PRO.IDProd '+
                          'LEFT JOIN arqpessoa  FAB ON PRO.IDFabr = FAB.IDPess '+
                          'WHERE PEI.IDFilial = :IDFilial AND PEI.IDPed = :IDPed ';
  //
  prCliente := '';
  prVendedor:= '';
  prProduto := '';
  //
  prStatus     := ' PED.Status = '+QuotedStr(FrmBusVenda.recTipBusca);
  prFilial     := 'AND PED.IDFilial = '+FILIAL.ToString;
  prDataInicial:= 'AND PED.Datped >= '+QuotedStr(FormatDateTime('yyyy-mm-dd 00:00:00', edDataIni.date));
  prDataFinal  := 'AND PED.Datped <= '+QuotedStr(FormatDateTime('yyyy-mm-dd 23:59:59', edDataFin.date));

  if edNompes.Tag > 0 then
    prCliente:= 'AND PED.IDPess = '+edNompes.Tag.ToString;

  if edNomven.Tag > 0 then
    prVendedor:= 'AND PED.IDVend = '+edNomven.Tag.ToString;

  if edNompro.Tag > 0 then
    prProduto:= 'AND ITE.IDProd = '+edNompro.Tag.ToString;

  TabPedido.SQL.Text:= Format('SELECT PED.*,CLI.Nompes AS NomeCli,PBM.NomPBM,CON.Nomcon,VEN.Nompes AS Nomven, fpa.DesForPag as ForPagto '+
                              'FROM arqpedido PED '+
                              'LEFT JOIN arqpbm PBM ON PED.IDPBM = PBM.IDPBM '+
                              'LEFT JOIN arqconvenio CON ON PED.IDConv = CON.IDConv '+
                              'LEFT JOIN arqpessoa CLI ON PED.IDPess = CLI.IDPess '+
                              'LEFT JOIN arqpessoa VEN ON PED.IDVend = VEN.IDPess '+
                              'LEFT JOIN arqpedidoite ITE on ITE.IDFilial = PED.IDFilial '+
                              '                                  and ITE.IDPed    = PED.IDPed '+
                              'LEFT JOIN arqforpagto fpa on fpa.IDForPag = ped.IDForPag '+
                              'WHERE %s '+
                              ' %s '+
                              ' %s '+
                              ' %s '+
                              ' %s '+
                              ' %s '+
                              ' %s '+
                              ' %s ',
                              [prStatus,
                               prFilial,
                               prDataInicial,
                               prDataFinal,
                               prCliente,
                               prVendedor,
                               prProduto,
                               ' GROUP BY PED.IDFIlial,PED.IDPed LIMIT 100']);

  TabPedido.Open;
  //
  AjustGrid(dbgPedido);
  //
  TimerDebounce.Enabled := False;
  TimerDebounce.Enabled := True;
  //
  dbgPedido.SetFocus;
end;

procedure TFrmBusVenda.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmBusVenda.btImprimirClick(Sender: TObject);
begin
  //btImprimir.Picture.SaveToFile('c:\temp\btimprimir.png');
end;

procedure TFrmBusVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPedidoIte.Close;
   TabPedido.Close;
   Action := caFree;
end;

end.
