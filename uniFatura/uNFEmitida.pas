unit uNFEmitida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit,
  LMDEdit, LMDButtonControl, LMDRadioButton, Vcl.StdCtrls, AdvGlowButton, Vcl.Mask,
  RxToolEdit, Data.DB, Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, MarcLib,
  FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, System.DateUtils;

type
  THackDBGrid = class(TDBGrid);

  TFrmNFEmit = class(TForm)
    PanelBack: TLMDSimplePanel;
    PanelFiltros: TLMDSimplePanel;
    Label22: TLabel;
    Label6: TLabel;
    edFilial: TLMDLabeledEdit;
    edNompes: TLMDLabeledEdit;
    LMDSimplePanel11: TLMDSimplePanel;
    Label37: TLabel;
    Label39: TLabel;
    Radio55: TLMDRadioButton;
    Radio65: TLMDRadioButton;
    LMDSimplePanel1: TLMDSimplePanel;
    Label1: TLabel;
    Label2: TLabel;
    RadioNor: TLMDRadioButton;
    RadioCon: TLMDRadioButton;
    LMDSimplePanel2: TLMDSimplePanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RadioReg: TLMDRadioButton;
    RadioCan: TLMDRadioButton;
    RadioDen: TLMDRadioButton;
    edNotFis: TLMDLabeledEdit;
    edNatope: TLMDLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    DBGrid1: TDBGrid;
    btBuscar: TAdvGlowButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ImagesNF: TImageList;
    SouTabNF: TDataSource;
    TabNF: TRESTDWClientSQL;
    TabNFIDPed: TIntegerField;
    TabNFNroNF: TIntegerField;
    TabNFDateEmiNF: TDateField;
    TabNFChaveNF: TWideStringField;
    TabNFProtoNF: TWideStringField;
    TabNFIDPess: TIntegerField;
    TabNFTotPedido: TFloatField;
    TabNFIDFilial: TIntegerField;
    TabNFContigencia: TShortintField;
    TabNFIDCFOP: TIntegerField;
    TabNFNompes: TWideStringField;
    TabNFNomfil: TWideStringField;
    TabNFOrigem: TWideStringField;
    TabNFEmCont: TWideStringField;
    TabNFCalcIndSitu: TWideStringField;
    TabNFSituNF: TWideStringField;
    TabNFModNF: TWideStringField;
    TabNFDesNatRed: TWideStringField;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNotFisKeyPress(Sender: TObject; var Key: Char);
    procedure edNatopeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatopeCustomButtons0Click(Sender: TObject; index: Integer);
    procedure TabNFCalcFields(DataSet: TDataSet);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    procedure AjustGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNFEmit: TFrmNFEmit;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uConst;

procedure TFrmNFEmit.FormShow(Sender: TObject);
begin
   AjustGrid;
   edNompes.SetFocus;
end;

procedure TFrmNFEmit.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmNFEmit.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0);
end;

procedure TFrmNFEmit.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',Key);
end;

procedure TFrmNFEmit.edNatopeCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqcfop',TLMDEdit(edNatope),'IDCFOP','Desnat','',0,True);
end;

procedure TFrmNFEmit.edNatopeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqcfop',TLMDEdit(edNatope),'IDCFOP','Desnat','',Key);
end;

procedure TFrmNFEmit.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',0);
end;

procedure TFrmNFEmit.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',Key);
end;

procedure TFrmNFEmit.edNotFisKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key = #8) and not (Key in ['0'..'9']) then Key := #0;
end;

procedure TFrmNFEmit.btBuscarClick(Sender: TObject);
var
   auxDatIni,auxDatFin:TDate;
begin
   auxDatIni := edDataIni.Date;
   auxDatFin := edDataFin.Date;
   if auxDatIni = 0 then auxDatIni := Now();
   if auxDatFin = 0 then auxDatFin := StrToDateTime('31/12/2200');
   if auxDatIni > auxDatFin then
   begin
      MostraMsg('Erro','Data Final maior que Data Inicial.',mtError, [mbOk]);
      edDataIni.SetFocus;
      Exit;
   end;
   TabNF.Close;
   TabNF.SQL.Text :=
   'SELECT p.IDFilial, p.IDPed, p.NroNF, DATE(p.EmiNF) AS EmiNF, p.ChaveNF, p.ProtoNF, p.Contigencia, p.IDPess, '+
   'p.ModNF, p.IDCFOP, PES.Nompes, FIL.Nomfil, CFO.DesNatRed, p.SituNF, p.TotPedido, "P" AS Origem FROM arqpedido AS p '+
   'LEFT JOIN arqcfop CFO ON p.IDCFOP = CFO.IDCFOP '+
   'LEFT JOIN arqfilial FIL ON p.IDFilial = FIL.IDFilial '+
   'LEFT JOIN arqpessoa PES ON p.IDPess = PES.IDPess '+
   'WHERE p.EmiNF BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',auxDatIni))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',auxDatFin))+' '+
   'AND p.ModNF > 0 AND p.Status = "F" AND p.IDFilial = '+iif(edFilial.Tag <= 0, FILIAL.ToString, edFilial.Tag.ToString)+' '+
   'AND ModNF = '+Aspas(iif(Radio55.Checked,'55','65'))+' AND p.Contigencia = '+iif(RadioNor.Checked,'0','1');
   if RadioReg.Checked then TabNF.SQL.Add(' AND (p.SituNF = '+Aspas('')+' OR ISNULL(p.SituNF))')  else
   if RadioCan.Checked then TabNF.SQL.Add(' AND p.SituNF = '+Aspas('C')) else
   if RadioDen.Checked then TabNF.SQL.Add(' AND p.SituNF = '+Aspas('D'));
   if edNompes.Tag > 0 then TabNF.SQL.Add(' AND p.IDPess = '+edNompes.Tag.ToString);
   if edNatope.Tag > 0 then TabNF.SQL.Add(' AND p.IDCFOP = '+edNatope.Tag.ToString);
   TabNF.SQL.Add(' UNION ALL '+
   'SELECT e.IDFilial, e.IDPed, e.NroNF, DATE(e.EmiNF) AS EmiNF, e.ChaveNF, e.ProtoNF, e.Contigencia, e.IDPess, '+
   'e.ModNF, e.IDCFOP, PES.Nompes, FIL.Nomfil, CFO.DesNatRed, E.SituNF, e.TotPedido, "E" AS Origem FROM arqnfeven AS e '+
   'LEFT JOIN arqcfop CFO ON e.IDCFOP = CFO.IDCFOP '+
   'LEFT JOIN arqfilial FIL ON e.IDFilial = FIL.IDFilial '+
   'LEFT JOIN arqpessoa PES ON e.IDPess = PES.IDPess '+
   'WHERE e.EmiNF BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',auxDatIni))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',auxDatFin))+' '+
   'AND e.ModNF > 0 AND e.Status = "F" AND e.IDFilial = '+iif(edFilial.Tag <= 0, FILIAL.ToString, edFilial.Tag.ToString)+' '+
   'AND ModNF = '+Aspas(iif(Radio55.Checked,'55','65'))+' AND e.Contigencia = '+iif(RadioNor.Checked,'0','1'));
   if RadioReg.Checked then TabNF.SQL.Add(' AND (e.SituNF = '+Aspas('')+' OR ISNULL(e.SituNF))')  else
   if RadioCan.Checked then TabNF.SQL.Add(' AND e.SituNF = '+Aspas('C')) else
   if RadioDen.Checked then TabNF.SQL.Add(' AND e.SituNF = '+Aspas('D'));
   if edNompes.Tag > 0 then TabNF.SQL.Add(' AND e.IDPess = '+edNompes.Tag.ToString);
   if edNatope.Tag > 0 then TabNF.SQL.Add(' AND e.IDCFOP = '+edNatope.Tag.ToString);
   TabNF.Open;
   AjustGrid;
end;

procedure TFrmNFEmit.TabNFCalcFields(DataSet: TDataSet);
begin
   TabNFEmCont.Value := iif(TabNFContigencia.Value = 0, 'C','N');
   if TabNFSituNF.Value = ''  then TabNFCalcIndSitu.Value := 'NOR' else
   if TabNFSituNF.Value = 'C' then TabNFCalcIndSitu.Value := 'CAN' else
   if TabNFSituNF.Value = 'D' then TabNFCalcIndSitu.Value := 'DEN';
end;

procedure TFrmNFEmit.DBGrid1CellClick(Column: TColumn);
begin
   // ---- Imprime DANFE ---- //
   if Column.ID = 9 then
   begin
      //PrnDANFE(TabNFChaveNF.Value, TabNFModNF.Value, TabNFSituNF.Value, False);
   end;

//--> NESSE PONTO: FAZER CANCELAMENTO DE NOTA

end;

procedure TFrmNFEmit.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   with TDBGrid(Sender) do
   begin
      if (THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) then
      begin
         if (Column.ID < 9) or ((Column.ID >= 9) and (gdSelected in State)) then
         begin
            Canvas.Brush.Color := $00CCDDFF;
            Canvas.Font.Color  := clBlack;
            Canvas.FillRect(Rect);
         end;
      end; //if

      if Column.ID = 9  then ImagesNF.Draw(Canvas, Rect.Left+7,Rect.Top+4, 0) else // Imprime
      if Column.ID = 10 then ImagesNF.Draw(Canvas, Rect.Left+7,Rect.Top+4, 3) else // Baixa XML
      if Column.ID = 11 then ImagesNF.Draw(Canvas, Rect.Left+7,Rect.Top+5, 2) else // Carta Correção
      if Column.ID = 12 then ImagesNF.Draw(Canvas, Rect.Left+7,Rect.Top+4, 1) else // Cancela NF
      if Column.ID = 13 then ImagesNF.Draw(Canvas, Rect.Left+7,Rect.Top+4, 4);     // Envia XML e PDF por Mail

      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter then
            Canvas.TextRect(Rect,Rect.Left + (Rect.Width - Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then
            Canvas.TextRect(Rect,Rect.Left + Rect.Width - Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify then
            Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
      end; //if
   end; //with
end;

procedure TFrmNFEmit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabNF.Active then TabNF.Close;
   Action := caFree;
end;

end.
