unit uSelPBM;

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
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, LMDCustomMaskEdit,
   LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox;

type
  TFrmSelPBM = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    TabPBM: TRESTDWClientSQL;
    SouPBM: TDataSource;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    TabPBMIDPBM: TSmallintField;
    TabPBMNomPBM: TWideStringField;
    LMDSimplePanel2: TLMDSimplePanel;
    edCpfCar: TLMDLabeledEdit;
    edCRM: TLMDLabeledEdit;
    edTipoPes: TLMDLabeledListComboBox;
    edUFCRM: TLMDLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
 private
    { Private declarations }
 public
    { Public declarations }
    retIDPBM:Integer;
    retNomPBM:String;
 end;

var
   FrmSelPBM: TFrmSelPBM;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmSelPBM.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   retIDPBM := 0;
end;

procedure TFrmSelPBM.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   retIDPBM  := 0;
   retNomPBM := '';
   if Key = VK_ESCAPE then Close;
end;

procedure TFrmSelPBM.FormShow(Sender: TObject);
begin
   TabPBM.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := 40;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmSelPBM.DBGrid1DblClick(Sender: TObject);
begin
   retIDPBM  := TabPBMIDPBM.Value;
   retNomPBM := TabPBMNomPBM.Value;
   Close;
end;

procedure TFrmSelPBM.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
   if Key = Char(#13) then
   begin
      retIDPBM  := TabPBMIDPBM.Value;
      retNomPBM := TabPBMNomPBM.Value;
      Close;
   end;
end;

procedure TFrmSelPBM.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if TabPBM.Active then
      if Column.ID = 0 then DM.ImagePBM.Draw((Sender as TDBGrid).Canvas, Rect.Left+5,Rect.Top+2, TabPBMIDPBM.Value);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+8, Rect.Top+12, Column.Field.DisplayText);
   end;
end;

procedure TFrmSelPBM.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmSelPBM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPBM.Close;
   Action := caFree;
end;

end.
