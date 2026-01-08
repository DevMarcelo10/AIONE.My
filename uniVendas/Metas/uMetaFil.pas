unit uMetaFil;

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
  TFrmMetaFil = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelEdit: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomfil: TLMDLabeledEdit;
    TabFilial: TRESTDWClientSQL;
    SouFilial: TDataSource;
    btLimpaIte: TAdvGlowButton;
    btIncluir: TAdvGlowButton;
    edVlrMeta: TLMDMaskEdit;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    edSupMeta: TLMDMaskEdit;
    LMDLabel4: TLMDLabel;
    edHipMeta: TLMDMaskEdit;
    LMDLabel5: TLMDLabel;
    edTicMed: TLMDMaskEdit;
    edDesco: TLMDMaskEdit;
    LMDLabel6: TLMDLabel;
    LMDLabel7: TLMDLabel;
    edUnidade: TLMDMaskEdit;
    TabFilialIDMetVen: TIntegerField;
    TabFilialIDFilial: TIntegerField;
    TabFilialVlrMeta: TFloatField;
    TabFilialHipMeta: TFloatField;
    TabFilialTicMeta: TFloatField;
    TabFilialVlrDesc: TFloatField;
    TabFilialUniMeta: TFloatField;
    TabFilialNomfil: TWideStringField;
    TabFilialSupMeta: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomfilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomfilCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btLimpaIteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edUnidadeExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
 private
    procedure AjustGrid;
    { Private declarations }
 public
    { Public declarations }
    recIDMeta:Integer;
    recDataIni,recDataFin:TDateTime;
 end;

var
   FrmMetaFil: TFrmMetaFil;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmMetaFil.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmMetaFil.FormShow(Sender: TObject);
begin
   TabFilial.ParamByName('IDMetVen').AsInteger := recIDMeta;
   TabFilial.Open;
   AjustGrid;
   edNomfil.SetFocus;
end;

procedure TFrmMetaFil.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmMetaFil.edNomfilCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edNomfil),'IDFilial','Nomfil','', 0, True);
end;

procedure TFrmMetaFil.edNomfilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edNomfil),'IDGrupo','Desgru','', Key);
end;

procedure TFrmMetaFil.edUnidadeExit(Sender: TObject);
begin
   if edNomfil.Tag > 0 then btIncluir.Click;
end;

procedure TFrmMetaFil.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edNomfil.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher uma Filial.', mtWarning, [mbOk]);
         edNomfil.SetFocus;
      end; //if
      Exit;
   end; //if

   if (edVlrMeta.AsFloat <= 0.00) and (edUnidade.AsFloat <= 0.00) then
   begin
      MostraMsg('Aviso','É necessário entrar com Valor de Meta ou Unidades.', mtWarning, [mbOk]);
      edVlrMeta.SetFocus;
      Exit;
   end; //if

   try
     if not TabFilial.Locate('IDFilial',edNomfil.Tag,[]) then
     begin
        QueAuxi := TRESTDWClientSQL.Create(nil);
        QueAuxi.DataBase := DM.DWDataBase;
        try
           QueAuxi.SQL.Text :=
           'SELECT M1.IDMetVen FROM arqmetas M1 JOIN arqmetafil V1 ON V1.IDMetVen = M1.IDMetVen '+
           'WHERE V1.IDFilial = '+edNomfil.Tag.ToString+' AND M1.IDMetVen <> '+recIDMeta.ToString+' AND '+
           'NOT (M1.DatHorIniMet > '+Aspas(DataMySQL(recDataFin))+' OR M1.DatHorFinMet < '+Aspas(DataMySQL(recDataIni))+')';
           QueAuxi.Open;
           if not QueAuxi.IsEmpty then
           begin
              MostraMsg('Aviso','Essa filial já está em outra meta em outro período!', mtWarning, [mbOk]);
              edNomfil.SetFocus;
              Exit;
           end; //if
        finally
           QueAuxi.Close;
           FreeAndNil(QueAuxi);
        end;
        TabFilial.Append;
        TabFilialIDMetVen.Value := recIDMeta;
        TabFilialIDFilial.Value := edNomfil.Tag;
        TabFilialNomfil.Value   := edNomfil.Text;
     end
     else TabFilial.Edit;
     TabFilialVlrMeta.Value := edVlrMeta.AsFloat;
     TabFilialSupMeta.Value := edSupMeta.AsFloat;
     TabFilialHipMeta.Value := edHipMeta.AsFloat;
     TabFilialTicMeta.Value := edTicMed.AsFloat;
     TabFilialVlrDesc.Value := edDesco.AsFloat;
     TabFilialVlrDesc.Value := edDesco.AsFloat;
     TabFilialUniMeta.Value := edUnidade.AsFloat;
     TabFilial.Post;
   except
      on E:Exception do
      begin
         if AnsiPos('Duplicate', E.Message) > 0 then
         begin
            MostraMsg('Aviso','Filial já associada à esta Meta!', mtWarning, [mbOk]);
            TabFilial.Cancel;
         end else
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Filial à Meta de Vendas -> '+E.Message);
            MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
         end;
         Exit;
      end; //on
   end;
   btLimpaIte.Click;
end;

procedure TFrmMetaFil.DBGrid1DblClick(Sender: TObject);
begin
   if TabFilial.IsEmpty then Exit;
   edNomfil.Tag      := TabFilialIDFilial.Value;
   edNomfil.Text     := TabFilialNomfil.Value;
   edVlrMeta.AsFloat := TabFilialVlrMeta.Value;
   edSupMeta.AsFloat := TabFilialSupMeta.Value;
   edHipMeta.AsFloat := TabFilialHipMeta.Value;
   edTicMed.AsFloat  := TabFilialTicMeta.Value;
   edDesco.AsFloat   := TabFilialVlrDesc.Value;
   edDesco.AsFloat   := TabFilialVlrDesc.Value;
   edUnidade.AsFloat := TabFilialUniMeta.Value;
   edNomfil.SetFocus;
end;

procedure TFrmMetaFil.btLimpaIteClick(Sender: TObject);
begin
   edNomfil.Tag  := 0;
   edNomfil.Text := '';
   edVlrMeta.AsFloat := 0.00;
   edSupMeta.AsFloat := 0.00;
   edHipMeta.AsFloat := 0.00;
   edTicMed.AsFloat  := 0.00;
   edDesco.AsFloat   := 0.00;
   edDesco.AsFloat   := 0.00;
   edUnidade.AsFloat := 0.00;
   AjustGrid;
   edNomfil.SetFocus;
end;

procedure TFrmMetaFil.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 7 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3, Rect.Top+3, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmMetaFil.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if Column.ID = 7 then
   begin
      if TabFilialIDFilial.Value <= 0 then Exit;
      if MostraMsg('Confirmação','Confirma exclusão de Metas para essa Filial?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            try
               QueAuxi.Close;
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Add('DELETE FROM arqmetapro WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabFilialIDFilial.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetafab WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabFilialIDFilial.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetasub WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabFilialIDFilial.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetagru WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabFilialIDFilial.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetafil WHERE IDMetVen = '+recIDMeta.ToString+' AND IDFilial = '+TabFilialIDFilial.AsString+';');
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqmetasfil, IDMetVen = '+recIDMeta.ToString+', IDFilial '+TabFilialIDFilial.AsString+' -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                  Exit;
               end;
            end;
            SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQMETASFIL IDMetVen = '+recIDMeta.ToString+', IDFilial '+TabFilialIDFilial.AsString);
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
         TabFilial.Refresh;
         AjustGrid;
         DBGrid1.SelectedField := TabFilialNomfil;
      end; //if
   end; //if
end;

procedure TFrmMetaFil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabFilial.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
