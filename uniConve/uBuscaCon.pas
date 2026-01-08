unit uBuscaCon;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, LMDBaseEdit, LMDEdit, StdCtrls, LMDControl, LMDCustomPanel,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, Vcl.ExtCtrls;

type
  TFrmBuscaCon = class(TForm)
    PanelBusca: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TEdit;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    Timer: TTimer;
    QueryAuxIDConv: TFDAutoIncField;
    QueryAuxNomcon: TWideStringField;
    QueryAuxNompes: TWideStringField;
    QueryAuxCpfCnpjPes: TWideStringField;
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
    WidthColuna:Integer;
  end;

var
   FrmBuscaCon: TFrmBuscaCon;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBuscaCon.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaCon.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   //DBGrid1.Columns[0].Width := iif(WidthColuna > 0, WidthColuna, Self.Width) - 23;
   AbreSQL;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaCon.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   ExecuteBusca;
end;

procedure TFrmBuscaCon.edBuscaChange(Sender: TObject);
begin
   Timer.Enabled := False;
   Timer.Enabled := True;
end;

procedure TFrmBuscaCon.ExecuteBusca;
begin
   //Tam := Length(edBusca.Text);
   //if Tam <= 2 then
   //begin
   //   if QueryAux.Active then QueryAux.Close;
   //end
   //else
   AbreSQL;
end;

procedure TFrmBuscaCon.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmBuscaCon.AbreSQL;
begin
   with QueryAux do
   begin
      QueryAux.Close;
      SQL.Clear;
      SQL.Text := 'SELECT CON.IDConv,CON.Nomcon,PES.Nompes,PES.CpfCnpjPes ' +
      'FROM arqconvenio CON LEFT JOIN arqpessoa PES ON CON.IDPessPri = PES.IDPess '+
      'WHERE CON.IDConv = :SearchTotal OR CON.Nomcon LIKE :SearchPart '+
      'OR PES.Nompes LIKE :SearchPart OR PES.CpfCnpjPes = :SearchTotal';
      ParamByName('SearchPart').AsString  := '%'+Trim(edBusca.Text)+'%';
      ParamByName('SearchTotal').AsString := Trim(edBusca.Text);
      QueryAux.Open;
   end; // with
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaCon.DBGrid1DblClick(Sender:TObject);
begin
   if (QueryAux.RecordCount = 0) or (QueryAux.FieldByName('Nomcon').AsString.Trim = '') then Exit;
   edRetorno.Tag  := QueryAux.FieldByName('IDConv').AsInteger;
   edRetorno.Text := QueryAux.FieldByName('Nomcon').AsString;
   Close;
end;

procedure TFrmBuscaCon.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaCon.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmBuscaCon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if edRetorno.Tag = 0 then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.
