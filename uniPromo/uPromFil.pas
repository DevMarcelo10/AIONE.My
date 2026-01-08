unit uPromFil;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, MemDS,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit,  VirtualTable, uRESTDWBasicTypes, uRESTDWBasicDB,
   Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmPromFil = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelGrid: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomRed: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    SouMPromFil: TDataSource;
    MemPromFil: TVirtualTable;
    MemPromFilIDFilial: TIntegerField;
    MemPromFilNomRed: TWideStringField;
    MemPromFilEndfil: TWideStringField;
    btTodos: TAdvGlowButton;
    TabPromFil: TRESTDWClientSQL;
    SouPromFil: TDataSource;
    TabPromFilIDProm: TIntegerField;
    TabPromFilIDFilial: TIntegerField;
    TabPromFilNomRed: TWideStringField;
    TabPromFilEndfil: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btTodosClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomRedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomRedCustomButtons0Click(Sender: TObject; index: Integer);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
    indAdd:Boolean;
 public
    { Public declarations }
    recIDProm:Integer;
    recIndNew,recMostop:Boolean;
 end;

var
   FrmPromFil: TFrmPromFil;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmPromFil.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromFil.FormShow(Sender: TObject);
begin
   indAdd := False;
   PanelTop.Visible := recMostop;
   if not recIndNew then
   begin
      TabPromFil.SQL.Text := 'SELECT PFI.IDProm,PFI.IDFilial,FIL.NomRed,FIL.Endfil FROM arqpromofil PFI  ';
      TabPromFil.SQL.Add('LEFT JOIN arqfilial FIL ON PFI.IDFilial = FIL.IDFilial WHERE IDProm = '+recIDProm.ToString);
      TabPromFil.Open;
      DBGrid1.DataSource := SouPromFil;
   end else
   begin
      DBGrid1.DataSource := SouMPromFil;
      if not MemPromFil.Active then MemPromFil.Open;
   end;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edNomRed.SetFocus;
end;

procedure TFrmPromFil.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID <= 1 then
      DBGrid1.Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+6, Column.Field.DisplayText) else
   if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+6, 0);
end;

procedure TFrmPromFil.edNomRedCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edNomRed),'IDFilial','NomRed','IndAtivo = True', 0, True);
   if edNomRed.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromFil.edNomRedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edNomRed),'IDFilial','NomRed','IndAtivo = True', Key);
   if edNomRed.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromFil.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
   auxEndfil:String;
   QueAuxi:TRESTDWClientSQL;
begin
   Erro := 0;
   PanelGrid.SetFocus;
   if edNomRed.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher uma Filial!', mtWarning, [mbOk]);
         edNomRed.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
         indAdd := True;
         if not recIndNew then
         begin
            TabPromFil.Append;
            TabPromFilIDProm.Value   := recIDProm;
            TabPromFilIDFilial.Value := edNomRed.Tag;
            TabPromFilNomRed.Value   := edNomRed.Text;
            TabPromFil.Post;
            TabPromFil.Refresh;
         end else
         begin
            if not MemPromFil.Locate('IDFilial',edNomRed.Tag,[]) then
            begin
               QueAuxi := TRESTDWClientSQL.Create(nil);
               try
                  QueAuxi.DataBase := DM.DWDataBase;
                  QueAuxi.SQL.Text := 'SELECT Endfil FROM arqfilial WHERE IDFilial = '+edNomRed.Tag.ToString;
                  QueAuxi.Open;
                  if not QueAuxi.IsEmpty then
                       auxEndfil := QueAuxi.FieldByName('Endfil').AsString
                  else auxEndfil := '';  
               finally
                  QueAuxi.Close;
                  QueAuxi.Free;
               end;
               MemPromFil.Append;
               MemPromFilIDFilial.Value := edNomRed.Tag;
               MemPromFilNomRed.Value   := edNomRed.Text;
               MemPromFilEndfil.Value   := auxEndfil;
               MemPromFil.Post;
            end
            else raise Exception.Create('Duplicate ID');
         end; //if
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Filial já associada à esta promoção!', mtWarning, [mbOk]);
               TabPromFil.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Filial à Promoção -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end;
      end;
   finally
      indAdd := False;
      edNomRed.SetFocus;
   end;
   edNomRed.Text := '';
   edNomRed.Tag  := 0;
end;

// ---------------- Entra com Filiais --------------- //
procedure TFrmPromFil.btTodosClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   TabAtiva:TDataSet;
begin
   if MostraMsg('Confirmação', 'Deseja realmente incluir TODAS Filiais?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      if recIndNew then
           TabAtiva := MemPromFil
      else TabAtiva := TabPromFil;
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT IDFilial,NomRed,Endfil FROM arqfilial WHERE IndAtivo';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not TabAtiva.Locate('IDFilial',QueAuxi.FieldByName('IDFilial').AsInteger,[]) then
         begin
            TabAtiva.Append;
            if not recIndNew then TabAtiva.FieldByName('IDProm').AsInteger := recIDProm;
            TabAtiva.FieldByName('IDFilial').AsInteger := QueAuxi.FieldByName('IDFilial').AsInteger;
            TabAtiva.FieldByName('NomRed').AsString    := QueAuxi.FieldByName('NomRed').AsString;
            TabAtiva.FieldByName('Endfil').AsString    := QueAuxi.FieldByName('Endfil').AsString;
            TabAtiva.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmPromFil.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 2 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação desta Filial?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            if not recIndNew then
                 TabPromFil.Delete
            else MemPromFil.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqpromofil -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      if not recIndNew then
           DBGrid1.SelectedField := TabPromFilEndfil
      else DBGrid1.SelectedField := MemPromFilEndfil;   
   end; //if
end;

procedure TFrmPromFil.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromFil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if not recIndNew then
        TabPromFil.Close
   else MemPromFil.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
