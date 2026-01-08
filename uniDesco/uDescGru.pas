unit uDescGru;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, MemDS,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit, LMDMaskEdit, LMDCustomMaskEdit,  Vcl.StdCtrls, uRESTDWBasicDB,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmDescGru = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edDesgru: TLMDLabeledEdit;
    btTodos: TAdvGlowButton;
    TabGrupo: TRESTDWClientSQL;
    SouGrupo: TDataSource;
    TabGrupoIDGrupo: TIntegerField;
    TabGrupoDesgru: TWideStringField;
    btIncluir: TAdvGlowButton;
    TabGrupoIDDesc: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btTodosClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDDesc:Integer;
 end;

var
   FrmDescGru: TFrmDescGru;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmDescGru.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmDescGru.FormShow(Sender: TObject);
begin
   TabGrupo.ParamByName('IDDesc').AsInteger := recIDDesc;
   TabGrupo.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edDesgru.SetFocus;
end;

procedure TFrmDescGru.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmDescGru.edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgrupo',TLMDEdit(edDesgru),'IDGrupo','Desgru','', 0, True);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmDescGru.edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgrupo',TLMDEdit(edDesgru),'IDGrupo','Desgru','', Key);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmDescGru.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   DBGrid1.SetFocus;
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
        if not TabGrupo.Locate('IDGrupo',edDesgru.Tag,[]) then
        begin
           TabGrupo.Append;
           TabGrupoIDDesc.Value  := recIDDesc;
           TabGrupoIDGrupo.Value := edDesgru.Tag;
           TabGrupoDesgru.Value  := edDesgru.Text;
           TabGrupo.Post;
        end
        else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Grupo já associado à esta Regra!', mtWarning, [mbOk]);
               TabGrupo.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Grupo à Regra de Desconto -> '+E.Message);
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
procedure TFrmDescGru.btTodosClick(Sender: TObject);
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
         if not TabGrupo.Locate('IDGrupo',QueAuxi.FieldByName('IDGrupo').AsInteger,[]) then
         begin
            TabGrupo.Append;
            TabGrupoIDDesc.Value  := recIDDesc;
            TabGrupoIDGrupo.Value := QueAuxi.FieldByName('IDGrupo').AsInteger;
            TabGrupoDesgru.Value  := QueAuxi.FieldByName('Desgru').AsString;
            TabGrupo.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmDescGru.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabGrupo.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqdescgru -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabGrupoDesgru;
   end; //if
end;

procedure TFrmDescGru.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabGrupo.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.

