unit uSupSanBus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, LMDControl, MarcFMX, Data.DB, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, AdvGlowButton, Vcl.Grids,
  Vcl.DBGrids, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uRESTDWBasicTypes, uRESTDWBasicDB;

type
  TFrmSupSanBus = class(TForm)
    PanelTop: TLMDSimplePanel;
    PanelBas: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    DBGrid1: TDBGrid;
    LMDLabel1: TLMDLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    TabSupSan: TRESTDWClientSQL;
    TabSupSanIDFilial: TIntegerField;
    TabSupSanIDCaixa: TIntegerField;
    TabSupSanDataMov: TDateTimeField;
    TabSupSanValorMov: TFloatField;
    TabSupSanSupSan: TWideStringField;
    SouSupSan: TDataSource;
    LMDLabel4: TLMDLabel;
    LMDLabel3: TLMDLabel;
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDCaixa:Integer;
    recSupSan:String;
    retDataMov:TDateTime;
  end;

var
  FrmSupSanBus: TFrmSupSanBus;

implementation

{$R *.dfm}

uses uDM, uConst;

procedure TFrmSupSanBus.FormShow(Sender: TObject);
begin
   retDataMov := 0;
   LMDLabel1.Caption := 'BUSCA '+iif(recSupSan = 'S','SUPRIMENTOS','SANGRIAS');
   Application.ProcessMessages;
   TabSupSan.ParamByName('IDFilial').AsInteger := FILIAL;
   TabSupSan.ParamByName('IDCaixa').AsInteger  := recIDCaixa;
   TabSupSan.ParamByName('SupSan').AsString    := recSupSan;
   TabSupSan.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmSupSanBus.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmSupSanBus.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
      Key := 0;
      retDataMov := TabSupSanDataMov.AsDateTime;
      Close;
   end;
end;

procedure TFrmSupSanBus.DBGrid1DblClick(Sender: TObject);
begin
   retDataMov := TabSupSanDataMov.AsDateTime;
   Close;
end;

procedure TFrmSupSanBus.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
      Key := 0;
      retDataMov := 0;
      Close;
   end;
end;

procedure TFrmSupSanBus.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmSupSanBus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabSupSan.Close;
   Self := nil;
end;

end.
