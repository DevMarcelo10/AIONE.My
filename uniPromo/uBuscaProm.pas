unit uBuscaProm;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, LMDBaseEdit, LMDEdit, StdCtrls, LMDControl, LMDCustomPanel,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, Vcl.ExtCtrls;

type
  TFrmBuscaProm = class(TForm)
    PanelBusca: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TEdit;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    Timer: TTimer;
    QueryAuxIDProm: TFDAutoIncField;
    QueryAuxDesprom: TWideStringField;
    QueryAuxTipoProm: TSmallintField;
    QueryAuxTipPromCalc: TWideStringField;
    QueryAuxDataOFF: TDateTimeField;
    QueryAuxIndAtivo: TWideStringField;
    QueryAuxCalcAtivo: TWideStringField;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure QueryAuxCalcFields(DataSet: TDataSet);
  private
    procedure AbreSQL;
    procedure ExecuteBusca;
    { Private declarations }
  public
    { Public declarations }
    recCarc:Word;
    edRetorno: TEdit;
    WidthColuna:Integer;
  end;

var
   FrmBuscaProm: TFrmBuscaProm;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBuscaProm.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaProm.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   AbreSQL;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaProm.QueryAuxCalcFields(DataSet: TDataSet);
begin
   QueryAuxTipPromCalc.Value := iif(QueryAuxTipoProm.AsInteger = 0,'NORMAL','PROGRESSIVA');
   QueryAuxCalcAtivo.Value   := iif(QueryAuxIndAtivo.AsInteger = 0,'NÃO','SIM');
end;

procedure TFrmBuscaProm.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   ExecuteBusca;
end;

procedure TFrmBuscaProm.edBuscaChange(Sender: TObject);
begin
   Timer.Enabled := False;
   Timer.Enabled := True;
end;

procedure TFrmBuscaProm.ExecuteBusca;
begin
   AbreSQL;
end;

procedure TFrmBuscaProm.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmBuscaProm.AbreSQL;
begin
   with QueryAux do
   begin
      QueryAux.Close;
      SQL.Clear;
      SQL.Text :=
      'SELECT IDProm,Desprom,TipoProm,DataOFF,IndAtivo FROM arqpromocao '+iif(Trim(edBusca.Text) <> '','WHERE Desprom LIKE '+Aspas('%'+Trim(edBusca.Text)+'%'),'')+
      ' ORDER BY Desprom';
      QueryAux.Open;
   end; // with
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaProm.DBGrid1DblClick(Sender:TObject);
begin
   if (QueryAux.RecordCount = 0) or (QueryAux.FieldByName('Desprom').AsString.Trim = '') then Exit;
   edRetorno.Tag  := QueryAux.FieldByName('IDProm').AsInteger;
   edRetorno.Text := QueryAux.FieldByName('Desprom').AsString;
   Close;
end;

procedure TFrmBuscaProm.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaProm.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmBuscaProm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if edRetorno.Tag = 0 then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.
