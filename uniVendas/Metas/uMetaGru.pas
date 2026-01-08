unit uMetaGru;

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
  TFrmMetaGru = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edDesgru: TLMDLabeledEdit;
    TabGrupo: TRESTDWClientSQL;
    SouGrupo: TDataSource;
    TabGrupoIDMetVen: TIntegerField;
    TabGrupoIDGrupo: TIntegerField;
    TabGrupoDesgru: TWideStringField;
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
    TabGrupoVlrMeta: TFloatField;
    TabGrupoSupMeta: TFloatField;
    TabGrupoHipMeta: TFloatField;
    TabGrupoTicMeta: TFloatField;
    TabGrupoVlrDesc: TFloatField;
    TabGrupoUniMeta: TFloatField;
    PanelFil: TLMDSimplePanel;
    lbFilVen: TLMDLabel;
    edBase: TLMDLabeledEdit;
    TabGrupoIDBase: TIntegerField;
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
    procedure edDesgruEnter(Sender: TObject);
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
   FrmMetaGru: TFrmMetaGru;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromocao;

procedure TFrmMetaGru.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmMetaGru.FormShow(Sender: TObject);
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

procedure TFrmMetaGru.edBaseCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil',Filtro, 0,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess',  'Nompes','IDEsppes = 9 AND '+Filtro, 0,True);
   if edBase.Tag > 0 then
   begin
      TabGrupo.Close;
      TabGrupo.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabGrupo.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabGrupo.Open;
   end
   else TabGrupo.Close;
end;

procedure TFrmMetaGru.edBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if recFilVen = 0 then
        btBuscas('arqfilial',TLMDEdit(edBase),'IDFilial','Nomfil',Filtro, Key,True)
   else btBuscas('arqpessoa',TLMDEdit(edBase),'IDPess',  'Nompes','IDEsppes = 9 AND '+Filtro, Key,True);
   if edBase.Tag > 0 then
   begin
      TabGrupo.Close;
      TabGrupo.ParamByName('IDMetVen').AsInteger := recIDMeta;
      TabGrupo.ParamByName('IDBase').AsInteger   := edBase.Tag;
      TabGrupo.Open;
   end
   else TabGrupo.Close;
   AjustGrid;
end;

procedure TFrmMetaGru.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmMetaGru.edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgrupo',TLMDEdit(edDesgru),'IDGrupo','Desgru','', 0, True);
end;

procedure TFrmMetaGru.edDesgruEnter(Sender: TObject);
begin
   if edBase.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher '+iif(recFilVen = 0,'uma Filial','um Vendedor'), mtWarning, [mbOk]);
      edBase.SetFocus;
      Exit;
   end;
end;

procedure TFrmMetaGru.edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgrupo',TLMDEdit(edDesgru),'IDGrupo','Desgru','', Key);
end;

procedure TFrmMetaGru.edUnidadeExit(Sender: TObject);
begin
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmMetaGru.btIncluirClick(Sender: TObject);
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
         MostraMsg('Aviso','Favor escolher um Grupo!', mtWarning, [mbOk]);
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
        if not TabGrupo.Locate('IDMetVen;IDBase;IDGrupo',VarArrayOf([recIDMeta,edBase.Tag,edDesgru.Tag]),[]) then
        begin
           QueAuxi := TRESTDWClientSQL.Create(nil);
           QueAuxi.DataBase := DM.DWDataBase;
           try
              QueAuxi.SQL.Text :=
              'SELECT M1.IDMetVen FROM arqmetas M1 JOIN arqmetafab V1 ON V1.IDMetVen = M1.IDMetVen '+
              'WHERE V1.IDPess = '+edDesgru.Tag.ToString+' AND M1.IDMetVen <> '+recIDMeta.ToString+' AND '+
              'NOT (M1.DatHorIniMet > '+Aspas(DataMySQL(recDataFin))+' OR M1.DatHorFinMet < '+Aspas(DataMySQL(recDataIni))+')';
              QueAuxi.Open;
              if not QueAuxi.IsEmpty then
              begin
                 MostraMsg('Aviso','Esse grupo já está em outra meta em outro período!', mtWarning, [mbOk]);
                 edDesgru.SetFocus;
                 Exit;
              end; //if
           finally
              QueAuxi.Close;
              FreeAndNil(QueAuxi);
           end;
           TabGrupo.Append;
           TabGrupoIDMetVen.Value := recIDMeta;
           TabGrupoIDGrupo.Value  := edDesgru.Tag;
           TabGrupoDesgru.Value   := edDesgru.Text;
           TabGrupoIDBase.Value   := edBase.Tag;
        end
        else TabGrupo.Edit;
        TabGrupoVlrMeta.Value := edVlrMeta.AsFloat;
        TabGrupoSupMeta.Value := edSupMeta.AsFloat;
        TabGrupoHipMeta.Value := edHipMeta.AsFloat;
        TabGrupoTicMeta.Value := edTicMed.AsFloat;
        TabGrupoVlrDesc.Value := edDesco.AsFloat;
        TabGrupoUniMeta.Value := edUnidade.AsFloat;
        TabGrupo.Post;
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Grupo já associado à esta Meta!', mtWarning, [mbOk]);
               TabGrupo.Delete;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Grupo à Meta de Vendas -> '+E.Message);
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

procedure TFrmMetaGru.btLimpaIteClick(Sender: TObject);
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
   AjustGrid;
end;

procedure TFrmMetaGru.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 7 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabGrupo.Delete;
            AjustGrid;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqmetagru -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabGrupoDesgru;
   end; //if
end;

procedure TFrmMetaGru.DBGrid1DblClick(Sender: TObject);
begin
   if TabGrupo.IsEmpty then Exit;
   edDesgru.Tag      := TabGrupoIDGrupo.Value;
   edDesgru.Text     := TabGrupoDesgru.Value;
   edVlrMeta.AsFloat := TabGrupoVlrMeta.Value;
   edSupMeta.AsFloat := TabGrupoSupMeta.Value;
   edHipMeta.AsFloat := TabGrupoHipMeta.Value;
   edTicMed.AsFloat  := TabGrupoTicMeta.Value;
   edDesco.AsFloat   := TabGrupoVlrDesc.Value;
   edDesco.AsFloat   := TabGrupoVlrDesc.Value;
   edUnidade.AsFloat := TabGrupoUniMeta.Value;
   edDesgru.SetFocus;
end;

procedure TFrmMetaGru.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmMetaGru.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabGrupo.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
