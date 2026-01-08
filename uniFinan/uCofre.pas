unit uCofre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit,
  LMDEdit, Vcl.StdCtrls, AdvGlowButton, Vcl.Mask, RxToolEdit, Data.DB, Vcl.Grids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uRESTDWBasicTypes, RxCurrEdit, LMDBaseControl, Vcl.DBGrids,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel;

type
  THackDBGrid = class(TDBGrid);

  TFrmCofre = class(TForm)
    PanelBack: TLMDSimplePanel;
    PanelFiltros: TLMDSimplePanel;
    Label22: TLabel;
    Label6: TLabel;
    edFilial: TLMDLabeledEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    edDataIni: TDateEdit;
    edDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    DBGrid1: TDBGrid;
    btBuscar: TAdvGlowButton;
    V: TLMDSimplePanel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    PanelSaldoIni: TLMDSimplePanel;
    Label35: TLabel;
    edSaldoIni: TCurrencyEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel4: TLMDSimplePanel;
    Label3: TLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    Label1: TLabel;
    LMDSimplePanel5: TLMDSimplePanel;
    Label2: TLabel;
    LMDSimplePanel6: TLMDSimplePanel;
    Label4: TLabel;
    LMDSimplePanel7: TLMDSimplePanel;
    Label5: TLabel;
    LMDSimplePanel8: TLMDSimplePanel;
    Label7: TLabel;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDLabel5: TLMDLabel;
    LMDLabel6: TLMDLabel;
    procedure FormShow(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNotFisKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure AjustGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCofre: TFrmCofre;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uConst;

procedure TFrmCofre.FormShow(Sender: TObject);
begin
   AjustGrid;
   edFilial.SetFocus;
end;

procedure TFrmCofre.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmCofre.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0);
end;

procedure TFrmCofre.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',Key);
end;

procedure TFrmCofre.edNotFisKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key = #8) and not (Key in ['0'..'9']) then Key := #0;
end;

procedure TFrmCofre.btBuscarClick(Sender: TObject);
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

procedure TFrmCofre.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmCofre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // if Tabela.Active then Tabela.Close;
   Action := caFree;
end;

end.
