unit uPromFpg;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, MemDS,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit,  VirtualTable, Vcl.StdCtrls, uRESTDWBasicDB,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmPromFpg = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    PanelGrid: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomFpg: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    SouMPromFpg: TDataSource;
    MemPromFpg: TVirtualTable;
    MemPromFpgIDForPag: TIntegerField;
    MemPromFpgDesForPag: TWideStringField;
    btTodos: TAdvGlowButton;
    TabPromFpg: TRESTDWClientSQL;
    SouPromFpg: TDataSource;
    TabPromFpgIDProm: TIntegerField;
    TabPromFpgIDForPag: TSmallintField;
    TabPromFpgDesForPag: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btTodosClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomFpgCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomFpgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
    indAdd:Boolean;
    procedure AjustGrid;
 public
    { Public declarations }
    recIDProm:Integer;
    recIndNew,recMostop:Boolean;
 end;

var
   FrmPromFpg: TFrmPromFpg;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmPromFpg.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromFpg.FormShow(Sender: TObject);
begin
   indAdd := False;
   PanelTop.Visible := recMostop;
   if not recIndNew then
   begin
      TabPromFpg.SQL.Text := 'SELECT PPG.*,FPG.DesForPag FROM arqpromofpg PPG LEFT JOIN ';
      TabPromFpg.SQL.Add('arqforpagto FPG ON PPG.IDForPag = FPG.IDForPag WHERE IDProm = '+recIDProm.ToString);
      TabPromFpg.Open;
      DBGrid1.DataSource := SouPromFpg;
   end else
   begin
      DBGrid1.DataSource := SouMPromFpg;
      if not MemPromFpg.Active then MemPromFpg.Open;
   end;
   AjustGrid;
   edNomFpg.SetFocus;
end;

procedure TFrmPromFpg.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmPromFpg.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPromFpg.edNomFpgCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqforpagto',TLMDEdit(edNomFpg),'IDForPag','DesForPag','IndAtivo = True', 0, True);
   if edNomFpg.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromFpg.edNomFpgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqforpagto',TLMDEdit(edNomFpg),'IDForPag','DesForPag','IndAtivo = True', kEY);
   if edNomFpg.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromFpg.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelGrid.SetFocus;
   if edNomFpg.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher uma Forma de Pagamento!', mtWarning, [mbOk]);
         edNomFpg.SetFocus;
      end;
      Exit;
   end; //if
   try
      try
         indAdd := True;
         if not recIndNew then
         begin
            TabPromFpg.Append;
            TabPromFpgIDProm.Value    := recIDProm;
            TabPromFpgIDForPag.Value  := edNomFpg.Tag;
            TabPromFpgDesForPag.Value := edNomFpg.Text;
            TabPromFpg.Post;
            TabPromFpg.Refresh;
            AjustGrid;
         end else
         begin
            if not MemPromFpg.Locate('IDForPag',edNomFpg.Tag,[]) then
            begin
               MemPromFpg.Append;
               MemPromFpgIDForPag.Value  := edNomFpg.Tag;
               MemPromFpgDesForPag.Value := edNomFpg.Text;
               MemPromFpg.Post;
            end
            else raise Exception.Create('Duplicate ID');
         end; //if
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Forma já associada à esta promoção!', mtWarning, [mbOk]);
               if not recIndNew then
                    TabPromFpg.Cancel
               else MemPromFpg.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Forma Pagto à Promoção -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      indAdd := False;
      edNomFpg.SetFocus;
   end;
   edNomFpg.Text := '';
   edNomFpg.Tag  := 0;
end;

// ----------- Entra com Todas Formas de Pagto ---------- //
procedure TFrmPromFpg.btTodosClick(Sender: TObject);
var
   TabAtiva:TDataSet;
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação','Deseja realmente incluir TODAS Formas?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      if recIndNew then
           TabAtiva := MemPromFpg
      else TabAtiva := TabPromFpg;
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT * FROM arqforpagto WHERE IndAtivo';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not TabAtiva.Locate('IDForPag',QueAuxi.FieldByName('IDForPag').AsInteger,[]) then
         begin
            TabAtiva.Append;
            if not recIndNew then TabAtiva.FieldByName('IDProm').AsInteger := recIDProm;
            TabAtiva.FieldByName('IDForPag').AsInteger := QueAuxi.FieldByName('IDForPag').AsInteger;
            TabAtiva.FieldByName('DesForPag').AsString := QueAuxi.FieldByName('DesForPag').AsString;
            TabAtiva.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmPromFpg.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação','Confirma eliminação da Forma de Pagto?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            if not recIndNew then
                 TabPromFpg.Delete
            else MemPromFpg.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO,PastaLog, 'ERRO: Não foi possível excluir arqpromofpg -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      if not recIndNew then
           DBGrid1.SelectedField := TabPromFpgDesForPag
      else DBGrid1.SelectedField := MemPromFpgDesForPag;
   end; //if
end;

procedure TFrmPromFpg.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromFpg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if not recIndNew then
        TabPromFpg.Close
   else MemPromFpg.Close;
   MemPromFpg.Clear;
   Self := nil;
   FreeAndNil(Self);
end;

end.
