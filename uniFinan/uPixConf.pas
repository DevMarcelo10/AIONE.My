unit uPixConf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit,
  LMDEdit, LMDButtonControl, LMDRadioButton, Vcl.StdCtrls, AdvGlowButton, Vcl.Mask,
  RxToolEdit, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, uRESTDWBasicTypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, MarcLib;

type
  THackDBGrid = class(TDBGrid);

  TFrmPixConf = class(TForm)
    PanelBack: TLMDSimplePanel;
    PanelFiltros: TLMDSimplePanel;
    Label22: TLabel;
    Label6: TLabel;
    edFilial: TLMDLabeledEdit;
    edNompes: TLMDLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    Label1: TLabel;
    Label2: TLabel;
    RadioNor: TLMDRadioButton;
    RadioCon: TLMDRadioButton;
    LMDSimplePanel2: TLMDSimplePanel;
    Label3: TLabel;
    Label4: TLabel;
    RadioReg: TLMDRadioButton;
    RadioCan: TLMDRadioButton;
    edNotFis: TLMDLabeledEdit;
    edLocRece: TLMDLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    DBGrid1: TDBGrid;
    btBuscar: TAdvGlowButton;
    Label7: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    LMDSimplePanel11: TLMDSimplePanel;
    Label37: TLabel;
    Label39: TLabel;
    Radio55: TLMDRadioButton;
    Radio65: TLMDRadioButton;
    V: TLMDSimplePanel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNotFisKeyPress(Sender: TObject; var Key: Char);
  private
    procedure AjustGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPixConf: TFrmPixConf;

implementation

{$R *.dfm}

uses uLibFarm, uConst;

procedure TFrmPixConf.FormShow(Sender: TObject);
begin
   AjustGrid;
   edNompes.SetFocus;
end;

procedure TFrmPixConf.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmPixConf.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0);
end;

procedure TFrmPixConf.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',Key);
end;

procedure TFrmPixConf.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',0);
end;

procedure TFrmPixConf.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','',Key);
end;

procedure TFrmPixConf.edNotFisKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key = #8) and not (Key in ['0'..'9']) then Key := #0;
end;

procedure TFrmPixConf.btBuscarClick(Sender: TObject);
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
   //Tabela.Close;
   //Tabelab.SQL.Text := '';
   //if RadioReg.Checked then Tabela.SQL.Add(' AND (p.SituNF = '+Aspas('')+' OR ISNULL(p.SituNF))')  else
   //if RadioCan.Checked then Tabela.SQL.Add(' AND p.SituNF = '+Aspas('C')) else
   //Tabela.Open;
   AjustGrid;
end;

procedure TFrmPixConf.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   with TDBGrid(Sender) do
   begin
      if (THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) then
      begin
         if (Column.ID < 9) or ((Column.ID >= 9) and (gdSelected in State)) then
         begin
            (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
            (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
            (Sender as TDBGrid).Canvas.FillRect(Rect);
         end;
      end; //if
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

procedure TFrmPixConf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // if Tabela.Active then Tabela.Close;
   Action := caFree;
end;

end.
