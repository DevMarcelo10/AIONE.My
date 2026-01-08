unit uPromEco;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDEdit,
   LMDCustomEdit, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicDB,
   uRESTDWBasicTypes;

type
  TFrmPromEco = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelGrid: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomeco: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    btTodos: TAdvGlowButton;
    TabPromEco: TRESTDWClientSQL;
    SouPromEco: TDataSource;
    TabPromEcoIDProm: TIntegerField;
    TabPromEcoIDECom: TSmallintField;
    TabPromEcoNomECom: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomecoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btTodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDProm:Integer;
 end;

var
   FrmPromEco: TFrmPromEco;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmPromEco.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromEco.FormShow(Sender: TObject);
begin
   TabPromEco.SQL.Text := 'SELECT PEC.*,ECO.NomECom FROM arqpromoeco PEC LEFT JOIN arqecommerce ';
   TabPromEco.SQL.Add('ECO ON PEC.IDECom = ECO.IDECom WHERE IDProm = '+recIDProm.ToString);
   TabPromEco.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edNomeco.SetFocus;
end;

procedure TFrmPromEco.edNomecoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqecommerce',TLMDEdit(edNomeco),'IDECom','NomECom','IndAtivo = True', 0);
   if edNomeco.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromEco.edNomecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqecommerce',TLMDEdit(edNomeco),'IDECom','NomECom','IndAtivo = True', Key);
   if edNomeco.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromEco.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelGrid.SetFocus;
   if edNomeco.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um e-commerce!', mtWarning, [mbOk]);
         edNomeco.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
         TabPromEco.Append;
         TabPromEcoIDProm.Value  := recIDProm;
         TabPromEcoIDECom.Value  := edNomeco.Tag;
         TabPromEcoNomECom.Value := edNomeco.Text;
         TabPromEco.Post;
         TabPromEco.Refresh;
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','E-Commerce já associado à esta promoção!', mtWarning, [mbOk]);
               TabPromEco.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de E-Commerce à Promoção -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edNomeco.SetFocus;
   end;
   edNomeco.Text := '';
   edNomeco.Tag  := 0;
end;

procedure TFrmPromEco.btTodosClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação', 'Deseja realmente incluir TODOS E-Commerces?',mtConfirmation, [mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT IDECom,NomECom FROM arqecommerce WHERE IndAtivo';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if not TabPromEco.Locate('IDECom',QueAuxi.FieldByName('IDECom').AsInteger,[]) then
         begin
            TabPromEco.Append;
            TabPromEcoIDProm.AsInteger := recIDProm;
            TabPromEcoIDECom.AsInteger := QueAuxi.FieldByName('IDECom').AsInteger;
            TabPromEcoNomECom.AsString := QueAuxi.FieldByName('NomECom').AsString;
            TabPromEco.Post;
         end; //if
         QueAuxi.Next;
      end; //while
   finally
      QueAuxi.Close;
      QueAuxi.Free;
   end;
end;

procedure TFrmPromEco.DBGrid1CellClick(Column: TColumn);
begin
   if TabPromEco.RecordCount > 0 then
   begin
      if Column.ID = 1 then
      begin
         if MostraMsg('Confirmação', 'Confirma eliminação deste E-Commerce?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabPromEco.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqpromoeco -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
         DBGrid1.SelectedField := TabPromEcoNomECom;
      end; //if
   end; //if
end;

procedure TFrmPromEco.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
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

procedure TFrmPromEco.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromEco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPromEco.Close;
   FreeAndNil(Self);
end;

end.
