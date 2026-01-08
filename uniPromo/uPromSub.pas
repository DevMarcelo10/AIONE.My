unit uPromSub;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit, LMDMaskEdit, LMDCustomMaskEdit,  VirtualTable,
   Vcl.StdCtrls, uRESTDWBasicDB, MemDS;

type
  TFrmPromSub = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edDesgru: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    SouMPromSub: TDataSource;
    MemPromSub: TVirtualTable;
    btTodos: TAdvGlowButton;
    MemPromSubIDGruSub: TIntegerField;
    MemPromSubDesgruSub: TWideStringField;
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
   FrmPromSub: TFrmPromSub;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromocao;

procedure TFrmPromSub.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromSub.FormShow(Sender: TObject);
begin
   PanelTop.Visible := recMostop;
   if not MemPromSub.Active then MemPromSub.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edDesgru.SetFocus;
end;

procedure TFrmPromSub.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPromSub.edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgruposub',TLMDEdit(edDesgru),'IDGruSub','DesgruSub','', 0, True);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromSub.edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgruposub',TLMDEdit(edDesgru),'IDGruSub','DesgruSub','', Key);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromSub.btIncluirClick(Sender: TObject);
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
         MostraMsg('Aviso','Favor escolher uma Sub Grupo!', mtWarning, [mbOk]);
         edDesgru.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
         if not MemPromSub.Locate('IDGruSub',edDesgru.Tag,[]) then
         begin
            MemPromSub.Append;
            MemPromSubIDGruSub.Value  := edDesgru.Tag;
            MemPromSubDesgruSub.Value := edDesgru.Text;
            MemPromSub.Post;
         end
         else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Sub Grupo já associado à esta promoção!', mtWarning, [mbOk]);
               MemPromSub.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Sub Grupos à Promoção -> '+E.Message);
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

// ----------- Entra com Todas Sub Grupos ---------- //
procedure TFrmPromSub.btTodosClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação', 'Deseja realmente incluir TODOS Sub Grupos?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT * FROM arqgruposub ORDER BY DesgruSub';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not MemPromSub.Locate('IDGruSub',QueAuxi.FieldByName('IDGruSub').AsInteger,[]) then
         begin
            MemPromSub.Append;
            MemPromSubIDGruSub.Value  := QueAuxi.FieldByName('IDGruSub').AsInteger;
            MemPromSubDesgruSub.Value := QueAuxi.FieldByName('DesgruSub').AsString;
            MemPromSub.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmPromSub.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Sub Grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            MemPromSub.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir MemPromSub -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := MemPromSubDesgruSub;
   end; //if
end;

procedure TFrmPromSub.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromSub.FormClose(Sender: TObject; var Action: TCloseAction);
var
   I:Integer;
begin
   SetLength(promoaIDGruSub, 0);
   if MemPromSub.RecordCount > 0 then
   begin
      I := 0;
      MemPromSub.DisableControls;
      SetLength(promoaIDGruSub, MemPromSub.RecordCount);
      MemPromSub.First;
      while not MemPromSub.Eof do
      begin
         promoaIDGruSub[I] := MemPromSub.FieldByName('IDGruSub').AsInteger;
         Inc(I);
         MemPromSub.Next;
      end;
      MemPromSub.EnableControls;
   end; //if
   MemPromSub.Clear;
   MemPromSub.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
