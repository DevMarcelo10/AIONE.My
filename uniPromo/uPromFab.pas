unit uPromFab;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, MemDS, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, VirtualTable,
   LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
   LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit, Vcl.StdCtrls;

type
  TFrmPromFab = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNompes: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    SouMPromFab: TDataSource;
    MemPromFab: TVirtualTable;
    MemPromFabIDPess: TIntegerField;
    MemPromFabNompes: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
 private
    { Private declarations }
 public
    { Public declarations }
    recMostop:Boolean;
 end;

var
   FrmPromFab: TFrmPromFab;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromocao;

procedure TFrmPromFab.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromFab.FormShow(Sender: TObject);
begin
   PanelTop.Visible := recMostop;
   if not MemPromFab.Active then MemPromFab.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edNompes.SetFocus;
end;

procedure TFrmPromFab.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPromFab.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 3', 0);
   if edNompes.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromFab.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 3', Key);
   if edNompes.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromFab.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelTop.SetFocus;
   if edNompes.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um Fabricante!', mtWarning, [mbOk]);
         edNompes.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
         if not MemPromFab.Locate('IDPess',edNompes.Tag,[]) then
         begin
            MemPromFab.Append;
            MemPromFabIDPess.Value := edNompes.Tag;
            MemPromFabNompes.Value := edNompes.Text;
            MemPromFab.Post;
         end
         else raise Exception.Create('Duplicate ID');
      except
         on E:Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Fabricante já associado à esta promoção!', mtWarning, [mbOk]);
               MemPromFab.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Fabricante à Promoção -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edNompes.SetFocus;
   end;
   edNompes.Text := '';
   edNompes.Tag  := 0;
end;

procedure TFrmPromFab.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Fabricante?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            MemPromFab.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir MemPromFab -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := MemPromFabNompes;
   end; //if
end;

procedure TFrmPromFab.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromFab.FormClose(Sender: TObject; var Action: TCloseAction);
var
   I:Integer;
begin
   SetLength(promoaFabrica, 0);
   if MemPromFab.RecordCount > 0 then
   begin
      MemPromFab.DisableControls;
      SetLength(promoaFabrica, MemPromFab.RecordCount);
      MemPromFab.First;
      while not MemPromFab.Eof do
      begin
         promoaFabrica[I] := MemPromFab.FieldByName('IDPess').AsInteger;
         Inc(I);
         MemPromFab.Next;
      end;
      MemPromFab.EnableControls;
   end; //if
   MemPromFab.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
