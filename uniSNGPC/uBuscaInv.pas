unit uBuscaInv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, MarcLib, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Vcl.ExtCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
  uRESTDWBasicDB, uDM, uConst, uLibFarm;

type
  TFrmBuscaInv = class(TForm)
    edBusca: TEdit;
    DBGrid1: TDBGrid;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    QueryAuxIDInvIni: TIntegerField;
    QueryAuxDataAbe: TDateField;
    QueryAuxNompes: TWideStringField;
    QueryAuxIndFecha: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edBuscaChange(Sender: TObject);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure AbreSQL;
    procedure ExecuteBusca;
  public
    { Public declarations }
    recCarc:Word;
    edRetorno:TEdit;
    auxNompes:String;
    WidthColuna:Integer;
    ArqBusca,CampoOrigem,CampoRetor,CampoBusca,CamposFiltro,Filtro,CampoShow:String;
  end;

var
  FrmBuscaInv: TFrmBuscaInv;

implementation

{$R *.dfm}

procedure TFrmBuscaInv.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaInv.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   AbreSQL;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaInv.AbreSQL;
var
   soInteger:String;
begin
   QueryAux.Close;
   QueryAux.SQL.Clear;
   QueryAux.SQL.Text := 'SELECT INV.IDInvIni, INV.DataAbe, PES.Nompes, IndFecha FROM arqsngpcinve INV '+
                        'LEFT JOIN arqpessoa PES ON INV.IDPess = PES.IDPess';

   soInteger := iif(ExisteStr(Trim(edBusca.Text)),  '', OnlyNumbers(edBusca.Text));
   if soInteger <> '' then
   begin
      QueryAux.SQL.Add('WHERE INV.IDInvIni = '+soInteger);
   end
   else QueryAux.SQL.Add('WHERE PES.Nompes LIKE CONCAT("%", '+Aspas(edBusca.Text)+', "%") ');
   QueryAux.SQL.Add(' ORDER BY INV.IDInvIni DESC LIMIT 100');

   QueryAux.Open;

   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaInv.DBGrid1DblClick(Sender: TObject);
begin
   if (QueryAux.RecordCount = 0) or (QueryAuxNompes.AsString.Trim = '') then Exit;
   auxNompes     := QueryAuxNompes.AsString;
//   edRetorno.Text := QueryAux.FieldByName('Nompes').AsString;
   edRetorno.Tag := QueryAuxIDInvIni.AsInteger;
   Close;
end;

procedure TFrmBuscaInv.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
{   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
   end;
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   ShowMessage(Column.FieldName);
}
   if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('IndFecha') then
   begin
      if Column.Field.Asstring = '0' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'ABERTO');
      end else if Column.Field.Asstring = '1' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'CONFIRMADO');
      end else if Column.Field.Asstring = '2' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'ENCERRADO');
      end;
   end;
end;

procedure TFrmBuscaInv.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaInv.edBuscaChange(Sender: TObject);
var
   Tam:Integer;
begin
   Tam := Length(edBusca.Text);
   if Tam <= 2 then
   begin
      if QueryAux.Active then QueryAux.Close;
   end
   else AbreSQL;
end;

procedure TFrmBuscaInv.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaInv.ExecuteBusca;
var
   Tam:Integer;
begin
   Tam := Length(edBusca.Text);
   if Tam <= 2 then
   begin
      if QueryAux.Active then QueryAux.Close;
   end
   else AbreSQL;
end;

procedure TFrmBuscaInv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if edRetorno.Tag = 0 then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.
