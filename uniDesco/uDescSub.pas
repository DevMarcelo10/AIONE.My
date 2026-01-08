unit uDescSub;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit, LMDMaskEdit, LMDCustomMaskEdit,  Vcl.StdCtrls,
   uRESTDWBasicDB, MemDS, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmDescSub = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edDesgru: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    SoubSubGru: TDataSource;
    btTodos: TAdvGlowButton;
    TabSubGru: TRESTDWClientSQL;
    TabSubGruIDGruSub: TIntegerField;
    TabSubGruDesgruSub: TWideStringField;
    TabSubGruIDDesc: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btTodosClick(Sender: TObject);
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
    recIDDesc:Integer;
    Filtro:String;
 end;

var
   FrmDescSub: TFrmDescSub;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmDescSub.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmDescSub.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Filtro  := '';
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT IDGrupo FROM arqdescgru WHERE IDDesc = '+recIDDesc.ToString;
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
   TabSubGru.ParamByName('IDDesc').AsInteger := recIDDesc;
   TabSubGru.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edDesgru.SetFocus;
end;

procedure TFrmDescSub.edDesgruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgruposub',TLMDEdit(edDesgru),'IDGruSub','DesgruSub',Filtro, 0, True);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmDescSub.edDesgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgruposub',TLMDEdit(edDesgru),'IDGruSub','DesgruSub',Filtro, Key);
   if edDesgru.Tag > 0 then btIncluir.Click;
end;

procedure TFrmDescSub.btIncluirClick(Sender: TObject);
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
         MostraMsg('Aviso','Favor escolher uma Sub Grupo!', mtWarning, [mbOk]);
         edDesgru.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
         if not TabSubGru.Locate('IDGruSub',edDesgru.Tag,[]) then
         begin
            TabSubGru.Append;
            TabSubGruIDDesc.Value    := recIDDesc;
            TabSubGruIDGruSub.Value  := edDesgru.Tag;
            TabSubGruDesgruSub.Value := edDesgru.Text;
            TabSubGru.Post;
         end
         else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Sub Grupo já associado à esta regra!', mtWarning, [mbOk]);
               TabSubGru.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Sub Grupos à Regra de Desconto -> '+E.Message);
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
procedure TFrmDescSub.btTodosClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação', 'Deseja realmente incluir TODOS Sub Grupos?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT * FROM arqgruposub WHERE '+Filtro+' ORDER BY DesgruSub';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not TabSubGru.Locate('IDGruSub',QueAuxi.FieldByName('IDGruSub').AsInteger,[]) then
         begin
            TabSubGru.Append;
            TabSubGruIDDesc.Value    := recIDDesc;
            TabSubGruIDGruSub.Value  := QueAuxi.FieldByName('IDGruSub').AsInteger;
            TabSubGruDesgruSub.Value := QueAuxi.FieldByName('DesgruSub').AsString;
            TabSubGru.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmDescSub.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Sub Grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabSubGru.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqdescsub -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabSubGruDesgruSub;
   end; //if
end;

procedure TFrmDescSub.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmDescSub.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabSubGru.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
