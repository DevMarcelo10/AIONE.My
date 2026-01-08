unit uKitBus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, LMDControl, MarcFMX, Data.DB, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, AdvGlowButton, Vcl.Grids,
  Vcl.DBGrids, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uRESTDWBasicTypes, uRESTDWBasicDB, LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDButtonControl,
  LMDCustomCheckBox, LMDCheckBox;

type
  TFrmKitBus = class(TForm)
    PanelTop: TLMDSimplePanel;
    PanelBas: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    LMDLabel1: TLMDLabel;
    TabKits: TRESTDWClientSQL;
    SouMetas: TDataSource;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    TabKitsIDKit: TFDAutoIncField;
    TabKitsDeskit: TWideStringField;
    TabKitsDataIni: TDateTimeField;
    TabKitsDataFin: TDateTimeField;
    TabKitsDiaSema: TWideStringField;
    TabKitsTipoKit: TWideStringField;
    TabKitsIndAtivo: TWideStringField;
    TabKitsVlrTotKit: TFloatField;
    DBGrid1: TDBGrid;
    TabKitsCalcAti: TWideStringField;
    TabKitsCalcTip: TWideStringField;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDeskit: TLMDLabeledEdit;
    CheckAtivos: TCheckBox;
    btBuscar: TAdvGlowButton;
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabKitsCalcFields(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDeskitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDeskitCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btBuscarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retIDKit:Integer;
  end;

var
  FrmKitBus: TFrmKitBus;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmKitBus.FormShow(Sender: TObject);
begin
   retIDKit := 0;
   TabKits.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmKitBus.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmKitBus.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
      Key := 0;
      retIDKit := TabKitsIDKit.AsInteger;
      Close;
   end;
end;

procedure TFrmKitBus.edDeskitCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqkitprod',TLMDEdit(Sender),'IDKit','Deskit','',0);
end;

procedure TFrmKitBus.edDeskitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqkitprod',TLMDEdit(Sender),'IDKit','Deskit','',Key);
end;

procedure TFrmKitBus.TabKitsCalcFields(DataSet: TDataSet);
begin
   TabKitsCalcTip.Value := iif(TabKitsTipoKit.AsString  = 'K','KIT','AGREGADO');
   TabKitsCalcAti.Value := iif(TabKitsIndAtivo.AsString = '1','SIM','NÃO');
end;

procedure TFrmKitBus.DBGrid1DblClick(Sender: TObject);
begin
   retIDKit := TabKitsIDKit.AsInteger;
   Close;
end;

procedure TFrmKitBus.btBuscarClick(Sender: TObject);
begin
   TabKits.Close;
   try
      try
         TabKits.SQL.Text := 'SELECT * FROM arqkitprod WHERE IDKit = IDKit'+
         iif(CheckAtivos.Checked,' AND IndAtivo = "1" ','')+
         iif(edDeskit.Tag > 0,   ' AND IDKit = '+ edDeskit.Tag.ToString,'')+' ORDER BY Deskit';
         TabKits.Open;
      except
         on E:Exception do
         begin
            MostraMsg('Erro', 'Não foi possível selecionar Kits!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end; //try
   finally
      TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -5;
      DBGrid1.Width := DBGrid1.Width - 5;
      DBGrid1.Width := DBGrid1.Width + 5;
   end;
end;

procedure TFrmKitBus.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmKitBus.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
      Key := 0;
      retIDKit := 0;
      Close;
   end;
end;

procedure TFrmKitBus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabKits.Close;
   Self := nil;
end;

end.

