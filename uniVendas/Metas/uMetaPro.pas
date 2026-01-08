unit uMetaPro;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, MemDS,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit, LMDMaskEdit, LMDCustomMaskEdit,  Vcl.StdCtrls,
   uRESTDWBasicDB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uDM, uConst;

type
  TFrmMetaPro = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    TabProd: TRESTDWClientSQL;
    SouProd: TDataSource;
    TabProdIDMetVen: TIntegerField;
    DBGrid1: TDBGrid;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDLabel5: TLMDLabel;
    LMDLabel6: TLMDLabel;
    LMDLabel7: TLMDLabel;
    btLimpaIte: TAdvGlowButton;
    btIncluir: TAdvGlowButton;
    edVlrMeta: TLMDMaskEdit;
    edSupMeta: TLMDMaskEdit;
    edHipMeta: TLMDMaskEdit;
    edTicMed: TLMDMaskEdit;
    edDesco: TLMDMaskEdit;
    edUnidade: TLMDMaskEdit;
    TabProdVlrMeta: TFloatField;
    TabProdSupMeta: TFloatField;
    TabProdHipMeta: TFloatField;
    TabProdTicMeta: TFloatField;
    TabProdVlrDesc: TFloatField;
    TabProdUniMeta: TFloatField;
    LMDSimplePanel1: TLMDSimplePanel;
    lbFilVen: TLMDLabel;
    edBase: TLMDLabeledEdit;
    TabProdIDBase: TIntegerField;
    TabProdIDProd: TIntegerField;
    TabProdDespro: TWideStringField;
    edDespro: TLMDLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btLimpaIteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edUnidadeExit(Sender: TObject);
    procedure edBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBaseCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesproEnter(Sender: TObject);
    procedure edDesproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesproExit(Sender: TObject);
 private
    { Private declarations }
    Filtro:String;
    retProdBusca:TArqPedidoIte;
    procedure AjustGrid;
 public
    { Public declarations }
    recIDMeta,recFilVen:Integer;
    recDataIni,recDataFin:TDateTime;
 end;

var
   FrmMetaPro: TFrmMetaPro;

implementation

{$R *.dfm}

uses uBuscaPro, uLibFarm;

procedure TFrmMetaPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmMetaPro.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Filtro    := '';
   QueAuxi   := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT '+iif(recFilVen = 0,'IDFilial','IDVend')+' FROM '+iif(recFilVen = 0,'arqmetafil','arqmetavnd')+' WHERE IDMetVen = '+recIDMeta.ToString;
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if recFilVen = 0 then
              Filtro := Filtro + iif(Filtro = '','IDFilial IN (',',')+QueAuxi.FieldByName('IDFilial').AsString
         else Filtro := Filtro + iif(Filtro = '',  'IDPess IN (',',')+QueAuxi.FieldByName('IDVend').AsString;
         QueAuxi.Next;
      end;
      Filtro := Filtro +')';
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   lbFilVen.Caption := iif(recFilVen = 0,'FILIAL','VENDEDOR');
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   edBase.SetFocus;
end;

procedure TFrmMetaPro.edBaseCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil',Filtro, 0,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess',  'Nompes','IDEsppes = 9 AND '+Filtro, 0,True);
   if edBase.Tag > 0 then
   begin
      TabProd.Close;
      TabProd.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabProd.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabProd.Open;
   end
   else TabProd.Close;
   AjustGrid;
end;

procedure TFrmMetaPro.edBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil',Filtro, Key,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess','Nompes','IDEsppes = 9 AND '+Filtro, Key,True);
   if edBase.Tag > 0 then
   begin
      TabProd.Close;
      TabProd.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabProd.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabProd.Open;
   end
   else TabProd.Close;
   AjustGrid;
end;

procedure TFrmMetaPro.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmMetaPro.edDesproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
  if not(ssCtrl in Shift) then
  begin
     if (Key = VK_RETURN) or (Key = VK_TAB) then
     begin
        if Trim(edDespro.Text) = '' then Exit;
        soInteger := iif(ExisteStr(Trim(edDespro.Text)), '', OnlyNumbers(edDespro.Text));
        if soInteger <> '' then edDesproCustomButtons0Click(Self,0);
        key := 0;
     end
     else if Key = VK_ESCAPE then
     begin
        edDespro.Text := '';
        edDespro.Tag  := 0;
     end;
  end;
end;

procedure TFrmMetaPro.edDesproCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      FrmBuscaPro  := TFrmBuscaPro.Create(Application);
      with FrmBuscaPro do
      begin
         lPoint := Self.edDespro.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edDespro.Width;
         edRetorno    := TEdit(Self.edDespro);
         edBusca.Text := Self.edDespro.Text;
         VenProdExibComEst := 0;
         ShowModal;
      end; // with
   finally
      retProdBusca := FrmBuscaPro.prodBusca;
      FrmBuscaPro.Free;
   end;
   if retProdBusca.IDProd > 0 then
   begin
      edDespro.Text := retProdBusca.Despro;
      edDespro.Tag  := retProdBusca.IDProd;
   end;
end;

procedure TFrmMetaPro.edDesproEnter(Sender: TObject);
begin
   if edBase.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher '+iif(recFilVen = 0,'uma Filial','um Vendedor'), mtWarning, [mbOk]);
      edBase.SetFocus;
      Exit;
   end;
end;

procedure TFrmMetaPro.edDesproExit(Sender: TObject);
var
   soInteger:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if ExisteStr(Trim(edDespro.Text)) or (Trim(edDespro.Text) = '') then Exit;
   soInteger := OnlyNumbers(edDespro.Text);
   QueAuxi   := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         QueAuxi.Close;
         SQL.Clear;
         SQL.Text := 'SELECT p.IDProd,p.Despro,pe.Nompes, SUM(1) AS EstTotal, P.PrecoVen, P.PrecoPMC, P.PrecoFP, P.PrecoFab, P.CustoMed '+
                     'FROM arqproduto p LEFT JOIN arqpessoa pe ON p.IDFabr = pe.IDPess ';
         if soInteger <> '' then
         begin
            if soInteger.Length > 11 then
                 SQL.Add('LEFT JOIN arqprodutoean EAN ON p.IDProd = EAN.IDProd WHERE p.CodEANpri = '+Aspas(soInteger)+' OR EAN.CodEAN = '+Aspas(soInteger))
            else SQL.Add('WHERE P.IDProd = '+soInteger);
         end; //if
         SQL.Add(' GROUP BY p.IDProd,p.Despro,pe.Nompes ORDER BY p.Despro LIMIT 500');
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            edDespro.Tag  := FieldByName('IDProd').AsInteger;
            edDespro.Text := FieldByName('Despro').AsString;
         end else
         begin
            edDespro.Text := '';
            edDespro.Tag  := 0;
         end; //if
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmMetaPro.edUnidadeExit(Sender: TObject);
begin
   if edDespro.Tag > 0 then btIncluir.Click;
end;

procedure TFrmMetaPro.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edDespro.Tag <= 0 then Erro := 1;
   if edBase.Tag   <= 0 then Erro := 2;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um Produto!', mtWarning, [mbOk]);
         edDespro.SetFocus;
      end else
      if Erro = 2 then
      begin
         MostraMsg('Aviso','Favor escolher '+iif(recFilVen = 0,'uma Filial','um Vendedor'), mtWarning, [mbOk]);
         edBase.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
        if not TabProd.Locate('IDMetVen;IDBase;IDProd',VarArrayOf([recIDMeta,edBase.Tag,edDespro.Tag]),[]) then
        begin
           QueAuxi := TRESTDWClientSQL.Create(nil);
           QueAuxi.DataBase := DM.DWDataBase;
           try
              QueAuxi.SQL.Text :=
              'SELECT M1.IDMetVen FROM arqmetas M1 JOIN arqmetapro V1 ON V1.IDMetVen = M1.IDMetVen '+
              'WHERE V1.IDProd = '+edDespro.Tag.ToString+' AND M1.IDMetVen <> '+recIDMeta.ToString+' AND '+
              'NOT (M1.DatHorIniMet > '+Aspas(DataMySQL(recDataFin))+' OR M1.DatHorFinMet < '+Aspas(DataMySQL(recDataIni))+')';
              QueAuxi.Open;
              if not QueAuxi.IsEmpty then
              begin
                 MostraMsg('Aviso','Esse produto já está em outra meta em outro período!', mtWarning, [mbOk]);
                 edDespro.SetFocus;
                 Exit;
              end; //if
           finally
              QueAuxi.Close;
              FreeAndNil(QueAuxi);
           end;
           TabProd.Append;
           TabProdIDMetVen.Value := recIDMeta;
           TabProdIDProd.Value   := edDespro.Tag;
           TabProdDespro.Value   := edDespro.Text;
           TabProdIDBase.Value   := edBase.Tag;
        end
        else TabProd.Edit;
        TabProdVlrMeta.Value := edVlrMeta.AsFloat;
        TabProdSupMeta.Value := edSupMeta.AsFloat;
        TabProdHipMeta.Value := edHipMeta.AsFloat;
        TabProdTicMeta.Value := edTicMed.AsFloat;
        TabProdVlrDesc.Value := edDesco.AsFloat;
        TabProdUniMeta.Value := edUnidade.AsFloat;
        TabProd.Post;
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Produto já associado à esta Meta!', mtWarning, [mbOk]);
               TabProd.Delete;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação do Produto à Meta de Vendas -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edDespro.SetFocus;
   end;
   btLimpaIte.Click;
end;

procedure TFrmMetaPro.btLimpaIteClick(Sender: TObject);
begin
   edDespro.Tag  := 0;
   edDespro.Text := '';
   edVlrMeta.AsFloat := 0.00;
   edSupMeta.AsFloat := 0.00;
   edHipMeta.AsFloat := 0.00;
   edTicMed.AsFloat  := 0.00;
   edDesco.AsFloat   := 0.00;
   edDesco.AsFloat   := 0.00;
   edUnidade.AsFloat := 0.00;
   edDespro.SetFocus;
   AjustGrid;
end;

procedure TFrmMetaPro.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 7 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Produtor?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabProd.Delete;
            AjustGrid;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqmetapro -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabProdDespro;
   end; //if
end;

procedure TFrmMetaPro.DBGrid1DblClick(Sender: TObject);
begin
   if TabProd.IsEmpty then Exit;
   edDespro.Tag      := TabProdIDProd.Value;
   edDespro.Text     := TabProdDespro.Value;
   edVlrMeta.AsFloat := TabProdVlrMeta.Value;
   edSupMeta.AsFloat := TabProdSupMeta.Value;
   edHipMeta.AsFloat := TabProdHipMeta.Value;
   edTicMed.AsFloat  := TabProdTicMeta.Value;
   edDesco.AsFloat   := TabProdVlrDesc.Value;
   edDesco.AsFloat   := TabProdVlrDesc.Value;
   edUnidade.AsFloat := TabProdUniMeta.Value;
   edDespro.SetFocus;
end;

procedure TFrmMetaPro.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 7 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3, Rect.Top+4, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmMetaPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabProd.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
