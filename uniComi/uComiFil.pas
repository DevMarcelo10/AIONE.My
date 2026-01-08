unit uComiFil;

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
  TFrmComiFil = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomfil: TLMDLabeledEdit;
    btTodos: TAdvGlowButton;
    TabFilial: TRESTDWClientSQL;
    SouFilial: TDataSource;
    btIncluir: TAdvGlowButton;
    TabFilialIDComi: TIntegerField;
    TabFilialIDFilial: TIntegerField;
    TabFilialNomfil: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btTodosClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomfilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure edNomfilCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDComi:Integer;
 end;

var
   FrmComiFil: TFrmComiFil;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromocao;

procedure TFrmComiFil.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmComiFil.FormShow(Sender: TObject);
begin
   TabFilial.ParamByName('IDComi').AsInteger := recIDComi;
   TabFilial.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edNomfil.SetFocus;
end;

procedure TFrmComiFil.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID <= 0 then
      DBGrid1.Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText) else
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0);
end;

procedure TFrmComiFil.edNomfilCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edNomfil),'IDFilial','Nomfil','', 0, True);
   if edNomfil.Tag > 0 then btIncluir.Click;
end;

procedure TFrmComiFil.edNomfilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edNomfil),'IDGrupo','Desgru','', Key);
   if edNomfil.Tag > 0 then btIncluir.Click;
end;

procedure TFrmComiFil.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edNomfil.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher uma Filial!', mtWarning, [mbOk]);
         edNomfil.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
        if not TabFilial.Locate('IDFilial',edNomfil.Tag,[]) then
        begin
           TabFilial.Append;
           TabFilialIDComi.Value   := recIDComi;
           TabFilialIDFilial.Value := edNomfil.Tag;
           TabFilialNomfil.Value   := edNomfil.Text;
           TabFilial.Post;
        end
        else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Filial já associada à esta Regra!', mtWarning, [mbOk]);
               TabFilial.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Filial à Regra de Comissões -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edNomfil.SetFocus;
   end;
   edNomfil.Text := '';
   edNomfil.Tag  := 0;
end;

// ----------- Entra com Todos Grupos ---------- //
procedure TFrmComiFil.btTodosClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação', 'Deseja realmente incluir TODAS Filiais?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT * FROM arqfilial ORDER BY Nomfil';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not TabFilial.Locate('IDFilial',QueAuxi.FieldByName('IDFilial').AsInteger,[]) then
         begin
            TabFilial.Append;
            TabFilialIDComi.Value   := recIDComi;
            TabFilialIDFilial.Value := QueAuxi.FieldByName('IDFilial').AsInteger;
            TabFilialNomfil.Value   := QueAuxi.FieldByName('Nomfil').AsString;
            TabFilial.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmComiFil.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação da Filial?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabFilial.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqcomigru -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabFilialNomfil;
   end; //if
end;

procedure TFrmComiFil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabFilial.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
