unit uVenUniLevPag;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmVenUniLevPag = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    TabPromProg: TRESTDWClientSQL;
    SouPromProg: TDataSource;
    pnPromocoes: TLMDSimplePanel;
    DBGridProm: TDBGrid;
    TabPromProgIDProm: TIntegerField;
    TabPromProgIDProd: TIntegerField;
    TabPromProgQtdven: TFloatField;
    TabPromProgPreVenda: TFloatField;
    PanelBottom: TLMDSimplePanel;
    lbBottom: TLMDLabel;
    btConfirmar: TAdvGlowButton;
    lbMsg: TLMDLabel;
    lbProdutoDesc: TLMDLabel;
    TabPromProgseleciona: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabPromProgQtdvenGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure TabPromProgPreVendaGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DBGridPromDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridPromCellClick(Column: TColumn);
    procedure btConfirmarClick(Sender: TObject);
    procedure TabPromProgselecionaGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DBGridPromKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
 private
    { Private declarations }
    procedure MarcaSelecionado();
 public
    { Public declarations }
    recIDProm:Integer;
    recIDProd:Integer;
    recDescProd: String;
    recQtdSel: Currency; // Selecionado na Grid, se for zero nenhum selecionado
    recQtdConf: Currency; // Quantidade Confirmada, apenas quando Clicar no botão Confirmar
 end;

var
   FrmVenUniLevPag: TFrmVenUniLevPag;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmVenUniLevPag.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmVenUniLevPag.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
end;

procedure TFrmVenUniLevPag.FormShow(Sender: TObject);
begin
   recQtdConf:= 0;
   recQtdSel:= 0;

   TabPromProg.Close;
   TabPromProg.SQL.Text:=
   Format('select IDProm, IDProd, Qtdven, PreVenda, 0 AS seleciona ' +
          'FROM arqpromopgr WHERE IDProm = %s and IDProd = %s ' +
          'order by IDProm, IDProd, Qtdven ',
    [ recIDProm.ToString,
      recIDProd.ToString ]);

   //TabPromProg.SQL.SaveToFile('C:\Temp\QueryDesc.SQL');
   TabPromProg.Open;

   TStringGrid(DBGridProm).DefaultRowHeight := BaseRowHeight - 5;
   DBGridProm.Width := DBGridProm.Width - 10;
   DBGridProm.Width := DBGridProm.Width + 10;
end;

procedure TFrmVenUniLevPag.TabPromProgPreVendaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text:= 'R$ '+#13#10+FormatFloat('#,##0.00', TField(Sender).AsCurrency)+' cada';
end;

procedure TFrmVenUniLevPag.TabPromProgQtdvenGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if StrToInt(TField(Sender).AsString) = 1 then
    Text:= '1 Unidade'
  else
    Text:= TField(Sender).AsString+' Unidades';
end;

procedure TFrmVenUniLevPag.TabPromProgselecionaGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text:= ' ';
end;

procedure TFrmVenUniLevPag.btConfirmarClick(Sender: TObject);
begin
  recQtdConf:= recQtdSel;
end;

procedure TFrmVenUniLevPag.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmVenUniLevPag.DBGridPromCellClick(Column: TColumn);
begin
  if Column.FieldName = 'seleciona' then
    MarcaSelecionado();
end;

procedure TFrmVenUniLevPag.MarcaSelecionado();
var
  bmSel: TBookmark;

  procedure desmarcaTodos();
  begin
    TabPromProg.First;
    while not(TabPromProg.Eof) do
    begin
      if TabPromProgQtdven.AsCurrency <> self.recQtdSel then
      begin
        TabPromProg.Edit;
        TabPromProgseleciona.AsInteger:= 0;
        TabPromProg.Post;
      end;
      //
      TabPromProg.Next;
    end;
  end;

  procedure marcaSelecionado();
  begin
    TabPromProg.Edit;
    if TabPromProgseleciona.AsInteger = 0 then
      TabPromProgseleciona.AsInteger:= 1
    else
      TabPromProgseleciona.AsInteger:= 0;
    TabPromProg.Post;
  end;

begin
  //if Column.FieldName = 'seleciona' then
  //begin
    bmSel := TabPromProg.GetBookmark;

    TabPromProg.DisableControls;
    marcaSelecionado();

    Self.recQtdSel:= 0;
    if TabPromProgseleciona.AsInteger = 1 then
      Self.recQtdSel:= TabPromProgQtdven.AsCurrency;

    desmarcaTodos();

    TabPromProg.GotoBookmark(bmSel);

    TabPromProg.EnableControls;

    TabPromProg.FreeBookmark(bmSel);
  //end;

end;

procedure TFrmVenUniLevPag.DBGridPromDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
  if Column.FieldName = 'seleciona' then
  begin
     DBGridProm.Canvas.FillRect(Rect);
     if TabPromProgseleciona.AsInteger = 1 then
          Check := DFCS_CHECKED
     else
          Check := 0;

     R := Rect;
     InflateRect(R,-3,-3);
     DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
  end;
  //
  // Prepara o fundo da célula
  DBGridProm.Canvas.FillRect(Rect);

  // Verifica o nome da coluna e aplica a fonte correspondente
  if Column.FieldName = 'Qtdven' then
  begin
    DBGridProm.Canvas.Font.Name := 'Roboto';
    DBGridProm.Canvas.Font.Size := -12;
    DBGridProm.Canvas.Font.Style := [fsBold];
  end
  else if Column.FieldName = 'PreVenda' then
  begin
    DBGridProm.Canvas.Font.Name  := 'Roboto';
    DBGridProm.Canvas.Font.Size  := -12;
    DBGridProm.Canvas.Font.Style := [fsBold];
    //DBGridProm.Canvas.Font.Color := $00E1EBFF;
  end;

  // Desenha o conteúdo da célula com a fonte definida
  DBGridProm.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFrmVenUniLevPag.DBGridPromKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
    MarcaSelecionado();
end;

procedure TFrmVenUniLevPag.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPromProg.Close;
   //Action := caFree;
end;

end.
