unit uBuscaPlc;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, StdCtrls, LMDControl, LMDCustomPanel,uRESTDWBasicTypes,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TFrmBuscaPlc = class(TForm)
    PanelBusca: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TEdit;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    Timer: TTimer;
    QueryAuxCodcon: TWideStringField;
    QueryAuxNomcon: TWideStringField;
    QueryAuxIDCon: TFDAutoIncField;
    QueryAuxDevCre: TWideStringField;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure AbreSQL;
    procedure ExecuteBusca;
    { Private declarations }
  public
    { Public declarations }
    recCarc:Word;
    edRetorno: TEdit;
  end;

var
   FrmBuscaPlc: TFrmBuscaPlc;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBuscaPlc.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaPlc.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   AbreSQL;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaPlc.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   ExecuteBusca;
end;

procedure TFrmBuscaPlc.edBuscaChange(Sender: TObject);
begin
   Timer.Enabled := False;
   Timer.Enabled := True;
end;

procedure TFrmBuscaPlc.ExecuteBusca;
begin
   AbreSQL;
end;

procedure TFrmBuscaPlc.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmBuscaPlc.AbreSQL;
begin
   with QueryAux do
   begin
      QueryAux.Close;
      SQL.Clear;
      SQL.Text := 'SELECT IDCon,Codcon,Nomcon,DevCre FROM arqplacon ';
      if Trim(edBusca.Text) <> '' then
      begin
         if OnlyNumbers(edBusca.Text) = '' then
              SQL.Add('WHERE Nomcon LIKE '+Aspas('%'+Trim(edBusca.Text)+'%')+' ORDER BY Nomcon')
         else SQL.Add('WHERE Codcon LIKE '+Aspas(OnlyNumbers(edBusca.Text)+'%')+' ORDER BY Codcon');
      end
      else SQL.Add('ORDER BY Nomcon');
      QueryAux.Open;
   end; // with
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaPlc.DBGrid1DblClick(Sender:TObject);
begin
   if (QueryAux.RecordCount = 0) or (QueryAux.FieldByName('Nomcon').AsString.Trim = '') then Exit;
   edRetorno.Tag  := QueryAux.FieldByName('IDCon').AsInteger;
   edRetorno.Text := QueryAux.FieldByName('Nomcon').AsString;
   Close;
end;

procedure TFrmBuscaPlc.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaPlc.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmBuscaPlc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if edRetorno.Tag = 0 then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.
