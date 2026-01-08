unit uBuscaSemDB;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, LMDBaseEdit, LMDEdit, StdCtrls, LMDControl, LMDCustomPanel,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmBuscaSemDB = class(TForm)
    PanelBusca: TLMDSimplePanel;
    edBusca: TEdit;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaChange(Sender: TObject);
  private
    procedure AtribuiDados;
    { Private declarations }
  public
    { Public declarations }
    recCarc:Word;
    recIndAll:Boolean;
    WidthColuna:Integer;
    TituloColuna:String;
  end;

var
   FrmBuscaSemDB: TFrmBuscaSemDB;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessBanc;

procedure TFrmBuscaSemDB.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaSemDB.FormShow(Sender: TObject);
begin
   TStringGrid(StringGrid1).DefaultRowHeight := BaseRowHeight - 10;
   StringGrid1.ColWidths[0] := WidthColuna;
   AtribuiDados;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaSemDB.StringGrid1DblClick(Sender: TObject);
begin
   CodChaPix := StringGrid1.Row;
   Close;
end;

procedure TFrmBuscaSemDB.StringGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then StringGrid1DblClick(Self);
end;

procedure TFrmBuscaSemDB.AtribuiDados;
begin
   StringGrid1.RowCount := 5;
   StringGrid1.Cells[0, 0] := TituloColuna;
   StringGrid1.Cells[0, 1] := '1 - Telefone';
   StringGrid1.Cells[0, 2] := '2 - E-Mail';
   StringGrid1.Cells[0, 3] := '3 - CPF/CNPJ';
   StringGrid1.Cells[0, 4] := '4 - Chave aleatória';
end;

procedure TFrmBuscaSemDB.edBuscaChange(Sender: TObject);
var
   I,CodBusca: Integer;
begin
   if Length(edBusca.Text) > 0 then
   begin
      for I := 1 to stringGrid1.Rowcount -1 do
      begin
         if edBusca.Text = Copy(stringGrid1.Cells[0,I], 5, Length(edBusca.Text)) then
         begin
            StringGrid1.Row := I;
            CodBusca := I;
            Break;
         end;
      end;
   end;
end;

procedure TFrmBuscaSemDB.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_UP then
   begin
      if StringGrid1.Row > 1 then
         StringGrid1.Row := StringGrid1.Row - 1;
   end;
   if Key = VK_DOWN then
   begin
      if StringGrid1.Row < 4 then
      StringGrid1.Row := StringGrid1.Row + 1;
   end;

   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then StringGrid1DblClick(Self);
end;

procedure TFrmBuscaSemDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   edBusca.Clear;
end;

end.
