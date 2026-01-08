unit uCxConf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit,
  LMDEdit, LMDButtonControl, LMDRadioButton, Vcl.StdCtrls, AdvGlowButton, Vcl.Mask,
  RxToolEdit, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  MarcLib,
  FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, LMDCustomMaskEdit,LMDLabel,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, LMDMaskEdit, Vcl.ExtCtrls, LMDBaseControl,
  LMDBaseLabel, LMDCustomLabel, LMDBaseGraphicControl;

type
  THackDBGrid = class(TDBGrid);

  TFrmCxConf = class(TForm)
    PanelBack: TLMDSimplePanel;
    PanelFiltros: TLMDSimplePanel;
    Label22: TLabel;
    edFilial: TLMDLabeledEdit;
    edLocRece: TLMDLabeledEdit;
    btBuscar: TAdvGlowButton;
    LMDSimplePanel11: TLMDSimplePanel;
    Label37: TLabel;
    Label39: TLabel;
    Radio55: TLMDRadioButton;
    Radio65: TLMDRadioButton;
    PanelBotton: TLMDSimplePanel;
    btConfere: TAdvGlowButton;
    Label1: TLabel;
    LMDRadioButton1: TLMDRadioButton;
    LMDLabel1: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    Shape4: TShape;
    edDateON: TDateEdit;
    edTimeON: TLMDMaskEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel6: TLMDLabel;
    Shape5: TShape;
    edDateOFF: TDateEdit;
    edTimeOFF: TLMDMaskEdit;
    btEstorno: TAdvGlowButton;
    Shape1: TShape;
    PanelBackConf: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btConfereClick(Sender: TObject);
  private
    procedure AjustGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCxConf: TFrmCxConf;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uConst, uCxConfIte;

procedure TFrmCxConf.FormShow(Sender: TObject);
begin
   PanelFiltros.Enabled := True;

   AjustGrid;
   edFilial.SetFocus;
end;

procedure TFrmCxConf.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmCxConf.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0);
end;

procedure TFrmCxConf.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',Key);
end;

procedure TFrmCxConf.btConfereClick(Sender: TObject);
begin
   PanelBotton.Visible  := False;
   PanelFiltros.Enabled := False;
   FrmCxConfIte := TFrmCxConfIte.Create(Application);
   FrmCxConfIte.Parent := PanelBackConf;
   FrmCxConfIte.Caller := Self;

   FrmCxConfIte.Show;
end;

procedure TFrmCxConf.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   with TDBGrid(Sender) do
   begin
      if (THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) then
      begin
         if gdSelected in State then
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
      if Column.ID = 6 then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         //if TabelaIndSel.AsString = '1' then
         //     Check := DFCS_CHECKED
         //else Check := 0;
         R := Rect;
         InflateRect(R,-3,-3);
         DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
      end else
      if Column.ID = 7 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3, Rect.Top+3, 23); // icon sinal "+"
   end; //with
end;

procedure TFrmCxConf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
