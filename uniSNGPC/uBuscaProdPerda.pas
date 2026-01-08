unit uBuscaProdPerda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, MarcLib, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, uDM, uConst, uLibFarm;

type
  TFrmBuscaProdPerda = class(TForm)
    edBusca: TEdit;
    DBGrid1: TDBGrid;
    QueryAux: TRESTDWClientSQL;
    QueryAuxIDProd: TIntegerField;
    QueryAuxDespro: TWideStringField;
    QueryAuxCodEANpri: TWideStringField;
    QueryAuxCodEAN: TWideStringField;
    SouAuxi: TDataSource;
    Timer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure AbreSQL(recLimt:String);
  public
    { Public declarations }
    recCarc:Word;
    recIndAll:Boolean;
    edRetorno:TEdit;
    auxDespro:String;
    WidthColuna:Integer;
    ArqBusca,CampoOrigem,CampoRetor,CampoBusca,CamposFiltro,Filtro,CampoShow:String;
  end;

var
  FrmBuscaProdPerda: TFrmBuscaProdPerda;

implementation

{$R *.dfm}

procedure TFrmBuscaProdPerda.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaProdPerda.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   AbreSQL('500');
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaProdPerda.TimerTimer(Sender: TObject);
var
   Tam:Integer;
   filtroBusca: String;
begin
   Timer.Enabled:= False;

   filtroBusca:= EmptyStr;
   Tam := Length(edBusca.Text);
   if (Tam <= 2) and (not RecIndAll) then
   begin
      if QueryAux.Active then QueryAux.Close;
      Exit;
   end else
   if (Tam = 3) and (not RecIndAll) then
   begin
      QueryAux.Close;
      QueryAux.Filtered := False;
      AbreSQL('');
      Exit;
   end else
   if ((Tam = 4) or RecIndAll) and (QueryAux.SQL.Text.Trim <> '') then
   begin
      if Trim(edBusca.Text) <> '' then
      begin
         filtroBusca:= CampoBusca+' LIKE '+Aspas('%'+edBusca.Text+'%');
      end;
      TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
      DBGrid1.Width := DBGrid1.Width - 10;
      DBGrid1.Width := DBGrid1.Width + 10;
   end; // if
   AbreSQL('100');
end;

procedure TFrmBuscaProdPerda.AbreSQL(recLimt: String);
var
   soInteger:String;
begin
   with QueryAux do
   begin
      QueryAux.Close;
      SQL.Clear;
      SQL.Text := 'SELECT LOT.IDProd, PRO.Despro, PRO.CodEANpri, EAN.CodEAN FROM arqsngpclot LOT '+
                  'LEFT JOIN arqproduto PRO ON LOT.IDProd = PRO.IDProd '+
                  'LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd ';
      soInteger := iif(ExisteStr(Trim(edBusca.Text)),  '', OnlyNumbers(edBusca.Text));
      if soInteger <> '' then
      begin
         if soInteger.Length > 11 then
              SQL.Add('LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd WHERE PRO.CodEANpri = '+Aspas(soInteger)+' OR EAN.CodEAN = '+Aspas(soInteger))
         else
         begin
            if CamposFiltro = '' then
               SQL.Add(' WHERE LOT.IDProd = '+soInteger)
            else
               SQL.Add(' WHERE '+CamposFiltro+' AND PRO.IDProd = '+soInteger);
         end;
      end
      else
      begin
         if CamposFiltro = '' then
            SQL.Add('WHERE PRO.Despro LIKE CONCAT("%", '+Aspas(edBusca.Text)+', "%") ')
         else
            SQL.Add('WHERE '+CamposFiltro+' AND PRO.Despro LIKE CONCAT("%", '+Aspas(edBusca.Text)+', "%") ');
      end;
      SQL.Add(' GROUP BY LOT.IDProd,PRO.Despro ORDER BY PRO.Despro '+iif(recLimt <> '',' LIMIT '+recLimt,''));
      QueryAux.Open;
   end; // with
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaProdPerda.DBGrid1DblClick(Sender: TObject);
begin
   if (QueryAux.RecordCount = 0) or (QueryAuxDespro.AsString.Trim = '') then Exit;
   auxDespro     := QueryAuxDespro.AsString;
   edRetorno.Tag := QueryAuxIDProd.AsInteger;
   Close;
end;

procedure TFrmBuscaProdPerda.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
   end;
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmBuscaProdPerda.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaProdPerda.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_DOWN then
   begin
      Key := 0;
      if QueryAux.Active then QueryAux.Next
   end else
   if Key = VK_UP then
   begin
      Key := 0;
      if QueryAux.Active then QueryAux.Prior;
   end else
   if Key = VK_ESCAPE then
   begin
      edBusca.Text := '';
      Close;
   end else
   if Key = VK_RETURN then
   begin
      DBGrid1DblClick(Self);
   end else
   begin
     Timer.Enabled:= False;
     Timer.Enabled:= True;
   end;
end;

procedure TFrmBuscaProdPerda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if edRetorno.Tag = 0 then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.
