unit uMetaSub;

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
  TFrmMetaSub = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edDesgru: TLMDLabeledEdit;
    TabSubgru: TRESTDWClientSQL;
    SouGrupo: TDataSource;
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
    TabSubgruVlrMeta: TFloatField;
    TabSubgruSupMeta: TFloatField;
    TabSubgruHipMeta: TFloatField;
    TabSubgruTicMeta: TFloatField;
    TabSubgruVlrDesc: TFloatField;
    TabSubgruUniMeta: TFloatField;
    TabSubgruIDMetVen: TIntegerField;
    TabSubgruIDGruSub: TIntegerField;
    TabSubgruDesgruSub: TWideStringField;
    LMDSimplePanel1: TLMDSimplePanel;
    lbFilVen: TLMDLabel;
    edBase: TLMDLabeledEdit;
    TabSubgruIDBase: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btLimpaIteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edUnidadeExit(Sender: TObject);
    procedure edBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBaseCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
    Filtro,FiltroB:String;
    procedure AjustGrid;
 public
    { Public declarations }
    recIDMeta,recFilVen:Integer;
    recDataIni,recDataFin:TDateTime;
 end;

var
   FrmMetaSub: TFrmMetaSub;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmMetaSub.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmMetaSub.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Filtro  := '';
   FiltroB := '';
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT IDGrupo FROM arqmetagru WHERE IDMetVen = '+recIDMeta.ToString;
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         Filtro := Filtro + iif(Filtro = '','IDGrupo IN (',',')+QueAuxi.FieldByName('IDGrupo').AsString;
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
   TabSubgru.ParamByName('IDMetVen').AsInteger := recIDMeta;
   TabSubgru.Open;
end;

procedure TFrmMetaSub.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmMetaSub.edBaseCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil','', 0,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess',  'Nompes','IDEsppes = 9', 0,True);
   if edBase.Tag > 0 then
   begin
      TabSubgru.Close;
      TabSubgru.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabSubgru.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabSubgru.Open;
   end
   else TabSubgru.Close;
   AjustGrid;
end;

procedure TFrmMetaSub.edBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil','', Key,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess',  'Nompes','IDEsppes = 9', Key,True);
   if edBase.Tag > 0 then
   begin
      TabSubgru.Close;
      TabSubgru.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabSubgru.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabSubgru.Open;
   end
   else TabSubgru.Close;
   AjustGrid;
end;

procedure TFrmMetaSub.edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgruposub',TLMDEdit(edDesgru),'IDGruSub','DesgruSub',Filtro, 0, True);
end;

procedure TFrmMetaSub.edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgruposub',TLMDEdit(edDesgru),'IDGruSub','DesgruSub',Filtro, Key);
end;

procedure TFrmMetaSub.edUnidadeExit(Sender: TObject);
begin
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmMetaSub.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edDesgru.Tag <= 0 then Erro := 1;
   if edBase.Tag   <= 0 then Erro := 2;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um Sub Grupo!', mtWarning, [mbOk]);
         edDesgru.SetFocus;
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
        if not TabSubgru.Locate('IDMetVen;IDBase;IDGruSub',VarArrayOf([recIDMeta,edBase.Tag,edDesgru.Tag]),[]) then
        begin
           QueAuxi := TRESTDWClientSQL.Create(nil);
           QueAuxi.DataBase := DM.DWDataBase;
           try
              QueAuxi.SQL.Text :=
              'SELECT M1.IDMetVen FROM arqmetas M1 JOIN arqmetasub V1 ON V1.IDMetVen = M1.IDMetVen '+
              'WHERE V1.IDGruSub= '+edDesgru.Tag.ToString+' AND M1.IDMetVen <> '+recIDMeta.ToString+' AND '+
              'NOT (M1.DatHorIniMet > '+Aspas(DataMySQL(recDataFin))+' OR M1.DatHorFinMet < '+Aspas(DataMySQL(recDataIni))+')';
              QueAuxi.Open;
              if not QueAuxi.IsEmpty then
              begin
                 MostraMsg('Aviso','Esse Sub Grupo já está em outra meta em outro período!', mtWarning, [mbOk]);
                 edDesgru.SetFocus;
                 Exit;
              end; //if
           finally
              QueAuxi.Close;
              FreeAndNil(QueAuxi);
           end;
           TabSubgru.Append;
           TabSubgruIDMetVen.Value  := recIDMeta;
           TabSubgruIDGruSub.Value  := edDesgru.Tag;
           TabSubgruDesgruSub.Value := edDesgru.Text;
           TabSubgruIDBase.Value    := edBase.Tag;
        end
        else TabSubgru.Edit;
        TabSubgruVlrMeta.Value := edVlrMeta.AsFloat;
        TabSubgruSupMeta.Value := edSupMeta.AsFloat;
        TabSubgruHipMeta.Value := edHipMeta.AsFloat;
        TabSubgruTicMeta.Value := edTicMed.AsFloat;
        TabSubgruVlrDesc.Value := edDesco.AsFloat;
        TabSubgruUniMeta.Value := edUnidade.AsFloat;
        TabSubgru.Post;
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Sub Grupo já associado à esta Meta!', mtWarning, [mbOk]);
               TabSubgru.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Sub Grupo à Meta de Vendas -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edDesgru.SetFocus;
   end;
   btLimpaIte.Click;
end;

procedure TFrmMetaSub.btLimpaIteClick(Sender: TObject);
begin
   edDesgru.Tag  := 0;
   edDesgru.Text := '';
   edVlrMeta.AsFloat := 0.00;
   edSupMeta.AsFloat := 0.00;
   edHipMeta.AsFloat := 0.00;
   edTicMed.AsFloat  := 0.00;
   edDesco.AsFloat   := 0.00;
   edDesco.AsFloat   := 0.00;
   edUnidade.AsFloat := 0.00;
   edDesgru.SetFocus;
end;

procedure TFrmMetaSub.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 7 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Sub Grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabSubgru.Delete;
            AjustGrid;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqmetasub -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabSubgruDesgruSub;
   end; //if
end;

procedure TFrmMetaSub.DBGrid1DblClick(Sender: TObject);
begin
   if TabSubgru.IsEmpty then Exit;
   edDesgru.Tag      := TabSubgruIDGruSub.Value;
   edDesgru.Text     := TabSubgruDesgruSub.Value;
   edVlrMeta.AsFloat := TabSubgruVlrMeta.Value;
   edSupMeta.AsFloat := TabSubgruSupMeta.Value;
   edHipMeta.AsFloat := TabSubgruHipMeta.Value;
   edTicMed.AsFloat  := TabSubgruTicMeta.Value;
   edDesco.AsFloat   := TabSubgruVlrDesc.Value;
   edDesco.AsFloat   := TabSubgruVlrDesc.Value;
   edUnidade.AsFloat := TabSubgruUniMeta.Value;
   edDesgru.SetFocus;
end;

procedure TFrmMetaSub.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmMetaSub.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabSubgru.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
