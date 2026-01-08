unit uVenProm;

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
  TFrmVenProm = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    TabProm: TRESTDWClientSQL;
    SouProm: TDataSource;
    pnPromocoes: TLMDSimplePanel;
    DBGridProm: TDBGrid;
    TabPromIDProm: TIntegerField;
    TabPromDesprom: TWideStringField;
    TabPromDataON: TDateTimeField;
    TabPromDataOFF: TDateTimeField;
    TabPromDiaSema: TWideStringField;
    TabPromManPre: TBooleanField;
    TabPromTipoProm: TSmallintField;
    TabPromDatVenLot: TDateField;
    TabPromIndAtivo: TWideStringField;
    TabPromIDProd: TIntegerField;
    TabPromQtdest: TFloatField;
    TabPromPrecoVen: TFloatField;
    TabPromPerDesIA: TFloatField;
    TabPromPerDesMan: TFloatField;
    TabPromPrePromo: TFloatField;
    TabPromIDForPagConcat: TMemoField;
    TabPromPerDes: TCurrencyField;
    TabPromForPagCalc: TWideStringField;
    TabDesc: TRESTDWClientSQL;
    SouDesc: TDataSource;
    TabDescIDDesc: TFDAutoIncField;
    TabDescDesDesc: TWideStringField;
    TabDescDataON: TDateTimeField;
    TabDescDataOFF: TDateTimeField;
    TabDescTabDesc: TFloatField;
    TabDescIndVenDin: TWideStringField;
    TabDescIndVenPix: TWideStringField;
    TabDescIndVenDeb: TWideStringField;
    TabDescIndVenCre: TWideStringField;
    TabDescIndVenPra: TWideStringField;
    TabDescIndVenChe: TWideStringField;
    TabDescIndVenCon: TWideStringField;
    TabDescIndVenVou: TWideStringField;
    TabDescPerDesc: TFloatField;
    TabDescPrecoEsp: TFloatField;
    TabDescForPagCalc: TWideStringField;
    TabDescDiaPagCalc: TWideStringField;
    TabDescPercDesconto: TCurrencyField;
    TabDescIndSeg: TWideStringField;
    TabDescIndTer: TWideStringField;
    TabDescIndQua: TWideStringField;
    TabDescIndQui: TWideStringField;
    TabDescIndSex: TWideStringField;
    TabDescIndSab: TWideStringField;
    TabDescIndDom: TWideStringField;
    pnDescontos: TLMDSimplePanel;
    DBGridDesc: TDBGrid;
    TabPromDiaPagCalc: TWideStringField;
    TabDescPrioridade: TIntegerField;
    TabDescIDProd: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridPromDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TabPromCalcFields(DataSet: TDataSet);
    procedure TabDescCalcFields(DataSet: TDataSet);
    procedure DBGridDescDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
 private
    { Private declarations }
 public
    { Public declarations }
    recData: TDateTime;
    recIDProd:Integer;
    recIDPromSel: Integer; // ID Promoção
    recIDDescSel: Integer; // ID Desconto
    // Desconto
    recIDPess, recIDConv, recIDGrupo, recIDGruSub, recIDFabr: Integer;
 end;

var
   FrmVenProm: TFrmVenProm;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmVenProm.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmVenProm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
end;

procedure TFrmVenProm.FormShow(Sender: TObject);
begin

   pnPromocoes.Visible:= False;
   pnDescontos.Visible:= False;

   if FrmVenProm.recIDPromSel > 0 then
   begin
     pnPromocoes.Visible:= True;
     lbTitulo.Caption:= 'PROMOÇÕES ATIVAS';

     TabProm.paramByName('DataDeHoje').AsDateTime:= recData;
     TabProm.paramByName('IDProd').AsInteger     := recIDProd;
     TabProm.Open;

     TStringGrid(DBGridProm).DefaultRowHeight := BaseRowHeight - 5;
     DBGridProm.Width := DBGridProm.Width - 10;
     DBGridProm.Width := DBGridProm.Width + 10;
   end else if FrmVenProm.recIDDescSel > 0 then
   begin
     pnDescontos.Visible:= True;
     lbTitulo.Caption:= 'DESCONTOS ATIVOS';

     TabDesc.Close;
     TabDesc.SQL.Text:=
     Format('SELECT DISTINCT des.IDDesc, des.DesDesc, des.DataON, des.DataOFF, des.PerDesc as TabDesc, ' +
      '  IndSeg, IndTer, IndQua, IndQui, IndSex, IndSab, IndDom, ' +
      '  IndVenDin, IndVenPix, IndVenDeb, IndVenCre, IndVenPra, IndVenChe, IndVenCon, IndVenVou, ' +
      '  Prioridade, pro.IDProd, pro.PerDesc, pro.PrecoEsp ' +
      'FROM arqdesconto des ' +
      'left join arqdescpro pro on pro.iddesc = des.iddesc ' +
      'WHERE %s BETWEEN des.DataON AND IFNULL(des.DataOFF, ''9999-12-31 23:59:59'') ' +
      'and (IDProd = %s or IDProd is null) ' +
      'order by Prioridade ',
      [ QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:ss', recData)),
        recIDProd.ToString ]);

     // 1-Domingo, 2-Segunda, 3-Terça, 4-Quarta, 5-Quinta, 6-Sexta, 7-Sábado
     var filtroDia: String:= EmptyStr;
     var DiaSemana: Integer := DayOfWeek(DataServer); // Dia da Semana Atual

     // Aplica filtro do dia da semana
     case DiaSemana of
       1: filtroDia := 'IndDom=' + QuotedStr('1');
       2: filtroDia := 'IndSeg=' + QuotedStr('1');
       3: filtroDia := 'IndTer=' + QuotedStr('1');
       4: filtroDia := 'IndQua=' + QuotedStr('1');
       5: filtroDia := 'IndQui=' + QuotedStr('1');
       6: filtroDia := 'IndSex=' + QuotedStr('1');
       7: filtroDia := 'IndSab=' + QuotedStr('1');
     end;

     //TabDesc.SQL.SaveToFile('C:\Temp\QueryDesc.SQL');
     TabDesc.Open;

     TabDesc.Filtered:= False;
     TabDesc.Filter:= filtroDia;
     TabDesc.Filtered:= True;

     TStringGrid(DBGridDesc).DefaultRowHeight := BaseRowHeight - 5;
     DBGridDesc.Width := DBGridDesc.Width - 10;
     DBGridDesc.Width := DBGridDesc.Width + 10;
   end;
end;

procedure TFrmVenProm.TabDescCalcFields(DataSet: TDataSet);
var
  descForPagto, descDiaPag: String;
begin
  // Descrição dos dias do Desconto
  descDiaPag := '';
  if DataSet.FieldByName('IndSeg').AsString = '1' then descDiaPag := descDiaPag + 'SEG,';
  if DataSet.FieldByName('IndTer').AsString = '1' then descDiaPag := descDiaPag + 'TER,';
  if DataSet.FieldByName('IndQua').AsString = '1' then descDiaPag := descDiaPag + 'QUA,';
  if DataSet.FieldByName('IndQui').AsString = '1' then descDiaPag := descDiaPag + 'QUI,';
  if DataSet.FieldByName('IndSex').AsString = '1' then descDiaPag := descDiaPag + 'SEX,';
  if DataSet.FieldByName('IndSab').AsString = '1' then descDiaPag := descDiaPag + 'SAB,';
  if DataSet.FieldByName('IndDom').AsString = '1' then descDiaPag := descDiaPag + 'DOM,';

  if descDiaPag <> '' then
    SetLength(descDiaPag, Length(descDiaPag) - 1);

  DataSet.FieldByName('DiaPagCalc').AsString := descDiaPag;

  // Descrição das Formas de Pagto Aceitas pelo desconto
  descForPagto := '';
  if DataSet.FieldByName('IndVenDin').AsString = '1' then descForPagto := descForPagto + 'DINHEIRO,';
  if DataSet.FieldByName('IndVenDeb').AsString = '1' then descForPagto := descForPagto + 'DÉBITO,';
  if DataSet.FieldByName('IndVenCre').AsString = '1' then descForPagto := descForPagto + 'CRÉDITO,';
  if DataSet.FieldByName('IndVenChe').AsString = '1' then descForPagto := descForPagto + 'CHEQUE,';
  if DataSet.FieldByName('IndVenPra').AsString = '1' then descForPagto := descForPagto + 'PRAZO,';
  if DataSet.FieldByName('IndVenPix').AsString = '1' then descForPagto := descForPagto + 'PIX,';
  if DataSet.FieldByName('IndVenCon').AsString = '1' then descForPagto := descForPagto + 'CONVÊNIO,';
  if DataSet.FieldByName('IndVenVou').AsString = '1' then descForPagto := descForPagto + 'CUPOM/VOUCHER,';
  if descForPagto <> '' then
    SetLength(descForPagto, Length(descForPagto) - 1);
  DataSet.FieldByName('ForPagCalc').AsString := descForPagto;

  // % desconto Pega da Tabela ou do Produto
  if DataSet.FieldByName('TabDesc').AsCurrency > 0 then
    DataSet.FieldByName('PercDesconto').AsCurrency:= DataSet.FieldByName('TabDesc').AsCurrency;

  if DataSet.FieldByName('PerDesc').AsCurrency > 0 then
    DataSet.FieldByName('PercDesconto').AsCurrency:= DataSet.FieldByName('PerDesc').AsCurrency;
end;

procedure TFrmVenProm.TabPromCalcFields(DataSet: TDataSet);
var
  descForPagto, diaPagCalc: String;
begin
  if DataSet.FieldByName('PerDesMan').AsCurrency <> 0 then
  begin
    DataSet.FieldByName('PerDes').AsCurrency:=  DataSet.FieldByName('PerDesMan').AsCurrency;
  end else
  begin
    DataSet.FieldByName('PerDes').AsCurrency:=  DataSet.FieldByName('PerDesIA').AsCurrency;
  end;
  //
  descForPagto:= DataSet.FieldByName('IDForPagConcat').AsString;

  descForPagto:= StringReplace(descForPagto, '1', 'DINHEIRO', []);
  descForPagto:= StringReplace(descForPagto, '2', 'DÉBITO', []);
  descForPagto:= StringReplace(descForPagto, '3', 'CRÉDITO', []);
  descForPagto:= StringReplace(descForPagto, '4', 'CHEQUE', []);
  descForPagto:= StringReplace(descForPagto, '5', 'PRAZO', []);
  descForPagto:= StringReplace(descForPagto, '6', 'CART.DIGITAL', []);
  descForPagto:= StringReplace(descForPagto, '7', 'PIX', []);
  descForPagto:= StringReplace(descForPagto, '8', 'CONVÊNIO', []);
  descForPagto:= StringReplace(descForPagto, '9', 'CUPOM/VOUCHER', []);

  DataSet.FieldByName('ForPagCalc').AsString:= descForPagto;
  //
  diaPagCalc:= DataSet.FieldByName('DiaSema').AsString;

  diaPagCalc:= StringReplace(diaPagCalc, '1', 'SEG', []);
  diaPagCalc:= StringReplace(diaPagCalc, '2', 'TER', []);
  diaPagCalc:= StringReplace(diaPagCalc, '3', 'QUA', []);
  diaPagCalc:= StringReplace(diaPagCalc, '4', 'QUI', []);
  diaPagCalc:= StringReplace(diaPagCalc, '5', 'SEX', []);
  diaPagCalc:= StringReplace(diaPagCalc, '6', 'SAB', []);
  diaPagCalc:= StringReplace(diaPagCalc, '7', 'DOM', []);

  DataSet.FieldByName('DiaPagCalc').AsString:= diaPagCalc;
end;

procedure TFrmVenProm.DBGridDescDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;

   if TabDescIDDesc.AsInteger = recIDDescSel then
      TDBGrid(Sender).Canvas.Brush.Color:= $00CBE1C6 ;

   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmVenProm.DBGridPromDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;

   if TabPromIDProm.AsInteger = recIDPromSel then
      TDBGrid(Sender).Canvas.Brush.Color:= $00CBE1C6 ;

   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmVenProm.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmVenProm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabProm.Close;
   Action := caFree;
end;

end.
