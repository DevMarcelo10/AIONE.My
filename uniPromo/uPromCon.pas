unit uPromCon;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   uRESTDWBasicDB, LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit,
   LMDCustomEdit, LMDEdit, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uRESTDWBasicTypes;

type
  TFrmPromCon = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelGrid: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomcon: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    btTodos: TAdvGlowButton;
    TabPromCon: TRESTDWClientSQL;
    SouPromCon: TDataSource;
    TabPromConIDProm: TIntegerField;
    TabPromConIDConv: TIntegerField;
    TabPromConNomcon: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomconKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomconCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btTodosClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDProm:Integer;
 end;

var
   FrmPromCon: TFrmPromCon;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmPromCon.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromCon.FormShow(Sender: TObject);
begin
   TabPromCon.SQL.Text := 'SELECT PRC.*,CON.Nomcon FROM arqpromocon PRC LEFT JOIN arqconvenio ';
   TabPromCon.SQL.Add('CON ON PRC.IDConv = CON.IDConv WHERE IDProm = '+recIDProm.ToString);
   TabPromCon.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 20;
   DBGrid1.Width := DBGrid1.Width + 20;
   edNomcon.SetFocus;
end;

procedure TFrmPromCon.edNomconCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqconvenio',TLMDEdit(edNomcon),'IDConv','Nomcon','', 0);
   if edNomcon.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromCon.edNomconKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqconvenio',TLMDEdit(edNomcon),'IDConv','Nomcon','', Key);
   if edNomcon.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromCon.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelGrid.SetFocus;
   if edNomcon.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um convênio!', mtWarning, [mbOk]);
         edNomcon.SetFocus;
      end;
      Exit;
   end; //if
   try
      try
         TabPromCon.Append;
         TabPromConIDProm.Value := recIDProm;
         TabPromConIDConv.Value := edNomcon.Tag;
         TabPromConNomcon.Value := edNomcon.Text;
         TabPromCon.Post;
         TabPromCon.Refresh;
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Convênio já associado à esta promoção!', mtWarning, [mbOk]);
               TabPromCon.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Convênio à Promoção -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edNomcon.SetFocus;
   end;
   edNomcon.Text := '';
   edNomcon.Tag  := 0;
end;

procedure TFrmPromCon.btTodosClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação', 'Deseja realmente incluir TODOS convênios?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT IDConv,Nomcon FROM arqconvenio WHERE IndAtivo';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not TabPromCon.Locate('IDConv',QueAuxi.FieldByName('IDConv').AsInteger,[]) then
         begin
            TabPromCon.Append;
            TabPromConIDProm.AsInteger := recIDProm;
            TabPromConIDConv.AsInteger := QueAuxi.FieldByName('IDConv').AsInteger;
            TabPromConNomcon.AsString  := QueAuxi.FieldByName('Nomcon').AsString;
            TabPromCon.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmPromCon.DBGrid1CellClick(Column: TColumn);
begin
   if TabPromCon.RecordCount > 0 then
   begin
      if Column.ID = 1 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação deste convênio?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabPromCon.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO,PastaLog, 'ERRO: Não foi possível excluir arqpromocon -> '+E.Message);
                  MostraMsg('Erro','Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
         DBGrid1.SelectedField := TabPromConNomcon;
      end; //if
   end; //if
end;

procedure TFrmPromCon.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 0 then
      DBGrid1.Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText) else
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+4, 0);
end;

procedure TFrmPromCon.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromCon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPromCon.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
