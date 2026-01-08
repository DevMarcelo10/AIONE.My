unit uMetaVnd;

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
  TFrmMetaVnd = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNompes: TLMDLabeledEdit;
    TabVend: TRESTDWClientSQL;
    SouVend: TDataSource;
    TabVendIDMetVen: TIntegerField;
    TabVendIDVend: TIntegerField;
    TabVendNompes: TWideStringField;
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
    TabVendVlrMeta: TFloatField;
    TabVendSupMeta: TFloatField;
    TabVendHipMeta: TFloatField;
    TabVendTicMeta: TFloatField;
    TabVendVlrDesc: TFloatField;
    TabVendUniMeta: TFloatField;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btLimpaIteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edUnidadeExit(Sender: TObject);
 private
    Filtro:String;
    procedure AjustGrid;
    { Private declarations }
 public
    { Public declarations }
    recIDMeta:Integer;
    recDataIni,recDataFin:TDateTime;
 end;

var
   FrmMetaVnd: TFrmMetaVnd;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmMetaVnd.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmMetaVnd.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Filtro  := '';
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT IDFilial FROM arqmetafil WHERE IDMetVen = '+recIDMeta.ToString;
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         Filtro := Filtro + iif(Filtro = '','IDFilial IN (',',')+QueAuxi.FieldByName('IDFilial').AsString;
         QueAuxi.Next;
      end;
      Filtro := Filtro +')';
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   TabVend.ParamByName('IDMetVen').AsInteger := recIDMeta;
   TabVend.Open;
   AjustGrid;
end;

procedure TFrmMetaVnd.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edNompes.SetFocus;
end;

procedure TFrmMetaVnd.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 9', 0, True);
end;

procedure TFrmMetaVnd.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 9', Key);
end;

procedure TFrmMetaVnd.edUnidadeExit(Sender: TObject);
begin
   if edNompes.Tag > 0 then btIncluir.Click;
end;

procedure TFrmMetaVnd.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edNompes.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um vendedor!', mtWarning, [mbOk]);
         edNompes.SetFocus;
         Exit;
      end; //if
   end; //if

   if (edVlrMeta.AsFloat <= 0.00) and (edUnidade.AsFloat <= 0.00) then
   begin
      MostraMsg('Aviso','É necessário entrar com Valor de Meta ou Unidades.', mtWarning, [mbOk]);
      edVlrMeta.SetFocus;
      Exit;
   end; //if

   try
      try
        if not TabVend.Locate('IDMetVen;IDVend',VarArrayOf([recIDMeta,edNompes.Tag]),[]) then
        begin
           QueAuxi := TRESTDWClientSQL.Create(nil);
           QueAuxi.DataBase := DM.DWDataBase;
           try
              QueAuxi.SQL.Text :=
              'SELECT M1.IDMetVen FROM arqmetas M1 JOIN arqmetaven V1 ON V1.IDMetVen = M1.IDMetVen '+
              'WHERE V1.IDVend = '+edNompes.Tag.ToString+' AND M1.IDMetVen <> '+recIDMeta.ToString+' AND '+
              'NOT (M1.DatHorIniMet > '+Aspas(DataMySQL(recDataFin))+' OR M1.DatHorFinMet < '+Aspas(DataMySQL(recDataIni))+')';
              QueAuxi.Open;
              if not QueAuxi.IsEmpty then
              begin
                 MostraMsg('Aviso','Esse vendedor já está em outra meta em outro período!', mtWarning, [mbOk]);
                 edNompes.SetFocus;
                 Exit;
              end; //if
           finally
              QueAuxi.Close;
              FreeAndNil(QueAuxi);
           end;
           TabVend.Append;
           TabVendIDMetVen.Value := recIDMeta;
           TabVendIDVend.Value   := edNompes.Tag;
           TabVendNompes.Value   := edNompes.Text;
        end
        else TabVend.Edit;
        TabVendVlrMeta.Value := edVlrMeta.AsFloat;
        TabVendSupMeta.Value := edSupMeta.AsFloat;
        TabVendHipMeta.Value := edHipMeta.AsFloat;
        TabVendTicMeta.Value := edTicMed.AsFloat;
        TabVendVlrDesc.Value := edDesco.AsFloat;
        TabVendVlrDesc.Value := edDesco.AsFloat;
        TabVendUniMeta.Value := edUnidade.AsFloat;
        TabVend.Post;
      except
         on E:Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Vendedor já associado à esta Meta!', mtWarning, [mbOk]);
               TabVend.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Vendedor à Meta de Vendas -> '+E.Message);
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

procedure TFrmMetaVnd.btLimpaIteClick(Sender: TObject);
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

procedure TFrmMetaVnd.DBGrid1DblClick(Sender: TObject);
begin
   if TabVend.IsEmpty then Exit;
   edNompes.Tag      := TabVendIDVend.Value;
   edNompes.Text     := TabVendNompes.Value;
   edVlrMeta.AsFloat := TabVendVlrMeta.Value;
   edSupMeta.AsFloat := TabVendSupMeta.Value;
   edHipMeta.AsFloat := TabVendHipMeta.Value;
   edTicMed.AsFloat  := TabVendTicMeta.Value;
   edDesco.AsFloat   := TabVendVlrDesc.Value;
   edDesco.AsFloat   := TabVendVlrDesc.Value;
   edUnidade.AsFloat := TabVendUniMeta.Value;
end;

procedure TFrmMetaVnd.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabVendIDVend.Value <= 0 then Exit;
   if Column.ID = 7 then
   begin
      if TabVendIDVend.Value <= 0 then Exit;
      if MostraMsg('Confirmação','Confirma exclusão de Metas para esse Vendedor?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            try
               QueAuxi.Close;
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Add('DELETE FROM arqmetapro WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabVendIDVend.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetafab WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabVendIDVend.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetasub WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabVendIDVend.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetagru WHERE IDMetVen = '+recIDMeta.ToString+' AND IDBase = '+TabVendIDVend.AsString+';');
               QueAuxi.SQL.Add('DELETE FROM arqmetavnd WHERE IDMetVen = '+recIDMeta.ToString+' AND IDVend = '+TabVendIDVend.AsString+';');
               QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog,'ERRO ao tentar excluir registro do aquivo: arqmetasvnd, IDMetVen = '+recIDMeta.ToString+', IDVend '+TabVendIDVend.AsString+' -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                  Exit;
               end;
            end;
            SalvaLog(USUARIO, PastaLog, 'EXCLUSAO ARQMETASVND IDMetVen = '+recIDMeta.ToString+', IDVend '+TabVendIDVend.AsString);
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
      TabVend.Refresh;
      AjustGrid;
      DBGrid1.SelectedField := TabVendNompes;
   end; //if
end;

procedure TFrmMetaVnd.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+4, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmMetaVnd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabVend.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
