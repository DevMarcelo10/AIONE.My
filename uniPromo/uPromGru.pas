unit uPromGru;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, MemDS,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit,  VirtualTable, Vcl.StdCtrls, uRESTDWBasicDB;

type
  TFrmPromGru = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edDesgru: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    SouMPromGru: TDataSource;
    MemPromGru: TVirtualTable;
    btTodos: TAdvGlowButton;
    MemPromGruIDGrupo: TIntegerField;
    MemPromGruDesgru: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btTodosClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
    recMostop:Boolean;
 end;

var
   FrmPromGru: TFrmPromGru;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromocao;

procedure TFrmPromGru.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromGru.FormShow(Sender: TObject);
begin
   PanelTop.Visible := recMostop;
   if not MemPromGru.Active then MemPromGru.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edDesgru.SetFocus;
end;

procedure TFrmPromGru.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPromGru.edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgrupo',TLMDEdit(edDesgru),'IDGrupo','Desgru','', 0, True);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromGru.edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgrupo',TLMDEdit(edDesgru),'IDGrupo','Desgru','', Key);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromGru.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelTop.SetFocus;
   if edDesgru.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um Grupo!', mtWarning, [mbOk]);
         edDesgru.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
        if not MemPromGru.Locate('IDGrupo',edDesgru.Tag,[]) then
        begin
           MemPromGru.Append;
           MemPromGruIDGrupo.Value := edDesgru.Tag;
           MemPromGruDesgru.Value  := edDesgru.Text;
           MemPromGru.Post;
        end
        else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Grupo já associado à esta promoção!', mtWarning, [mbOk]);
               MemPromGru.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Grupo à Promoção -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edDesgru.SetFocus;
   end;
   edDesgru.Text := '';
   edDesgru.Tag  := 0;
end;

// ----------- Entra com Todos Grupos ---------- //
procedure TFrmPromGru.btTodosClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação', 'Deseja realmente incluir TODOS Grupos?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT * FROM arqgrupo ORDER BY Desgru';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not MemPromGru.Locate('IDGrupo',QueAuxi.FieldByName('IDGrupo').AsInteger,[]) then
         begin
            MemPromGru.Append;
            MemPromGruIDGrupo.Value := QueAuxi.FieldByName('IDGrupo').AsInteger;
            MemPromGruDesgru.Value  := QueAuxi.FieldByName('Desgru').AsString;
            MemPromGru.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmPromGru.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            MemPromGru.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir MemPromGru -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := MemPromGruDesgru;
   end; //if
end;

procedure TFrmPromGru.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromGru.FormClose(Sender: TObject; var Action: TCloseAction);
var
   I:Integer;
begin
   SetLength(promoaIDGrupo, 0);
   if MemPromGru.RecordCount > 0 then
   begin
      I := 0;
      MemPromGru.DisableControls;
      SetLength(promoaIDGrupo,MemPromGru.RecordCount);
      MemPromGru.First;
      while not MemPromGru.Eof do
      begin
         promoaIDGrupo[I] := MemPromGru.FieldByName('IDGrupo').AsInteger;
         Inc(I);
         MemPromGru.Next;
      end;
      MemPromGru.EnableControls;
   end; //if
   MemPromGru.Clear;
   MemPromGru.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
