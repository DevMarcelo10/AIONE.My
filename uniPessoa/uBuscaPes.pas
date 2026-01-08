unit uBuscaPes;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, LMDBaseEdit, LMDEdit, StdCtrls, LMDControl, LMDCustomPanel,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, Vcl.ExtCtrls;

type
  TFrmBuscaPes = class(TForm)
    PanelBusca: TLMDSimplePanel;
    edBusca: TEdit;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    Timer: TTimer;
    DBGrid1: TDBGrid;
    QueryAuxIDPess: TIntegerField;
    QueryAuxNompes: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerTimer(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure AbreSQL;
    procedure ExecuteBusca;
    { Private declarations }
  public
    { Public declarations }
    recFiltro:String;
    recCarc:Word;
    edRetorno: TLMDEdit;
    WidthColuna:Integer;
  end;

var
   FrmBuscaPes: TFrmBuscaPes;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBuscaPes.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaPes.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Columns[0].Width := iif(WidthColuna > 0, WidthColuna, Self.Width) - 23;
   AbreSQL;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaPes.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   ExecuteBusca;
end;

procedure TFrmBuscaPes.edBuscaChange(Sender: TObject);
begin
   Timer.Enabled := False;
   Timer.Enabled := True;
end;

procedure TFrmBuscaPes.ExecuteBusca;
begin
   AbreSQL;
end;

procedure TFrmBuscaPes.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmBuscaPes.AbreSQL;
begin
   with QueryAux do
   begin
      QueryAux.Close;
      SQL.Clear;
      SQL.Text := 'SELECT p.IDPess, p.Nompes FROM arqpessoa p LEFT JOIN arqpessconv C ON p.IDPess = c.IDPess '+
      'WHERE (p.IDPess = '+Aspas(edBusca.Text)+' OR p.FonePes = '+Aspas(edBusca.Text)+' OR CelularPes = '+Aspas(edBusca.Text)+' OR '+
      'p.Nompes LIKE CONCAT("%", '+Aspas(edBusca.Text)+', "%") OR p.NomfanPes LIKE CONCAT("%", '+Aspas(edBusca.Text)+', "%") '+
      'OR p.CpfCnpjPes = '+Aspas(edBusca.Text)+' OR c.NroMatric = '+Aspas(edBusca.Text)+' OR c.NroCartao = '+Aspas(edBusca.Text)+') '+
      iif(recFiltro.Trim <> '','AND '+recFiltro,'')+' GROUP BY p.IDPess ORDER BY p.Nompes ';
      QueryAux.Open;
   end; // with
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaPes.DBGrid1DblClick(Sender:TObject);
begin
   if (QueryAux.RecordCount = 0) or (QueryAux.FieldByName('Nompes').AsString.Trim = '') then Exit;
   edRetorno.Tag  := QueryAux.FieldByName('IDPess').AsInteger;
   edRetorno.Text := QueryAux.FieldByName('Nompes').AsString;
   Close;
end;

procedure TFrmBuscaPes.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaPes.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmBuscaPes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if edRetorno.Tag = 0 then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.
