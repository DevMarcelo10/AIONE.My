unit uMetaFab;

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
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmMetaFab = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNompes: TLMDLabeledEdit;
    TabFabr: TRESTDWClientSQL;
    SouFabr: TDataSource;
    TabFabrIDMetVen: TIntegerField;
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
    TabFabrVlrMeta: TFloatField;
    TabFabrSupMeta: TFloatField;
    TabFabrHipMeta: TFloatField;
    TabFabrTicMeta: TFloatField;
    TabFabrVlrDesc: TFloatField;
    TabFabrUniMeta: TFloatField;
    LMDSimplePanel1: TLMDSimplePanel;
    lbFilVen: TLMDLabel;
    edBase: TLMDLabeledEdit;
    TabFabrIDBase: TIntegerField;
    TabFabrIDPess: TIntegerField;
    TabFabrNompes: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btLimpaIteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edUnidadeExit(Sender: TObject);
    procedure edBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBaseCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNompesEnter(Sender: TObject);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
    Filtro:String;
    procedure AjustGrid;
 public
    { Public declarations }
    recIDMeta,recFilVen:Integer;
    recDataIni,recDataFin:TDateTime;
 end;

var
   FrmMetaFab: TFrmMetaFab;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromocao;

procedure TFrmMetaFab.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmMetaFab.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Filtro  := '';
   QueAuxi := TRESTDWClientSQL.Create(nil);
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

procedure TFrmMetaFab.edBaseCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil',Filtro, 0,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess',  'Nompes','IDEsppes = 9 AND '+Filtro, 0,True);
   if edBase.Tag > 0 then
   begin
      TabFabr.Close;
      TabFabr.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabFabr.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabFabr.Open;
   end
   else TabFabr.Close;
end;

procedure TFrmMetaFab.edBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil','', Key,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess',  'Nompes','IDEsppes = 9', Key,True);
   if edBase.Tag > 0 then
   begin
      TabFabr.Close;
      TabFabr.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabFabr.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabFabr.Open;
   end
   else TabFabr.Close;
   AjustGrid;
end;

procedure TFrmMetaFab.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmMetaFab.edNompesEnter(Sender: TObject);
begin
   if edBase.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher '+iif(recFilVen = 0,'uma Filial','um Vendedor'), mtWarning, [mbOk]);
      edBase.SetFocus;
      Exit;
   end;
end;

procedure TFrmMetaFab.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 2 OR IDEsppes = 3', 0, True);
end;

procedure TFrmMetaFab.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 2 OR IDEsppes = 3', Key);
end;

procedure TFrmMetaFab.edUnidadeExit(Sender: TObject);
begin
   if edNompes.Tag > 0 then btIncluir.Click;
end;

procedure TFrmMetaFab.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edNompes.Tag <= 0 then Erro := 1;
   if edBase.Tag   <= 0 then Erro := 2;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um Fabricante!', mtWarning, [mbOk]);
         edNompes.SetFocus;
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
        if not TabFabr.Locate('IDMetVen;IDBase;IDPess',VarArrayOf([recIDMeta,edBase.Tag,edNompes.Tag]),[]) then
        begin
           QueAuxi := TRESTDWClientSQL.Create(nil);
           QueAuxi.DataBase := DM.DWDataBase;
           try
              QueAuxi.SQL.Text :=
              'SELECT M1.IDMetVen FROM arqmetas M1 JOIN arqmetafab V1 ON V1.IDMetVen = M1.IDMetVen '+
              'WHERE V1.IDPess = '+edNompes.Tag.ToString+' AND M1.IDMetVen <> '+recIDMeta.ToString+' AND '+
              'NOT (M1.DatHorIniMet > '+Aspas(DataMySQL(recDataFin))+' OR M1.DatHorFinMet < '+Aspas(DataMySQL(recDataIni))+')';
              QueAuxi.Open;
              if not QueAuxi.IsEmpty then
              begin
                 MostraMsg('Aviso','Essa fábrica já está em outra meta em outro período!', mtWarning, [mbOk]);
                 edNompes.SetFocus;
                 Exit;
              end; //if
           finally
              QueAuxi.Close;
              FreeAndNil(QueAuxi);
           end;
           TabFabr.Append;
           TabFabrIDMetVen.Value := recIDMeta;
           TabFabrIDPess.Value   := edNompes.Tag;
           TabFabrNompes.Value   := edNompes.Text;
           TabFabrIDBase.Value   := edBase.Tag;
        end
        else TabFabr.Edit;
        TabFabrVlrMeta.Value := edVlrMeta.AsFloat;
        TabFabrSupMeta.Value := edSupMeta.AsFloat;
        TabFabrHipMeta.Value := edHipMeta.AsFloat;
        TabFabrTicMeta.Value := edTicMed.AsFloat;
        TabFabrVlrDesc.Value := edDesco.AsFloat;
        TabFabrUniMeta.Value := edUnidade.AsFloat;
        TabFabr.Post;
      except
         on E:Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Fabricante já associado à esta Meta!', mtWarning, [mbOk]);
               TabFabr.Delete;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação do Fabricante à Meta de Vendas -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edNompes.SetFocus;
   end;
   btLimpaIte.Click;
end;

procedure TFrmMetaFab.btLimpaIteClick(Sender: TObject);
begin
   edNompes.Tag  := 0;
   edNompes.Text := '';
   edVlrMeta.AsFloat := 0.00;
   edSupMeta.AsFloat := 0.00;
   edHipMeta.AsFloat := 0.00;
   edTicMed.AsFloat  := 0.00;
   edDesco.AsFloat   := 0.00;
   edDesco.AsFloat   := 0.00;
   edUnidade.AsFloat := 0.00;
   edNompes.SetFocus;
   AjustGrid;
end;

procedure TFrmMetaFab.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 7 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Fabricante?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabFabr.Delete;
            AjustGrid;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqmetafab -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabFabrNompes;
   end; //if
end;

procedure TFrmMetaFab.DBGrid1DblClick(Sender: TObject);
begin
   if TabFabr.IsEmpty then Exit;
   edNompes.Tag      := TabFabrIDPess.Value;
   edNompes.Text     := TabFabrNompes.Value;
   edVlrMeta.AsFloat := TabFabrVlrMeta.Value;
   edSupMeta.AsFloat := TabFabrSupMeta.Value;
   edHipMeta.AsFloat := TabFabrHipMeta.Value;
   edTicMed.AsFloat  := TabFabrTicMeta.Value;
   edDesco.AsFloat   := TabFabrVlrDesc.Value;
   edDesco.AsFloat   := TabFabrVlrDesc.Value;
   edUnidade.AsFloat := TabFabrUniMeta.Value;
   edNompes.SetFocus;
end;

procedure TFrmMetaFab.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 7 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmMetaFab.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabFabr.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
