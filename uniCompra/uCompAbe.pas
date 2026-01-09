unit uCompAbe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDControl, Data.DB,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, MarcLib,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TFrmCompAbe = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    TabAuxi: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    TabAuxiDatped: TDateTimeField;
    TabAuxiIDComp: TIntegerField;
    TabAuxiTotIte: TLargeintField;
    TabAuxistrStatus: TWideStringField;
    btFechar: TAdvGlowButton;
    DBGrid1: TDBGrid;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    TabAuxiStatus: TWideStringField;
    TabAuxiNomusu: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabAuxiCalcFields(DataSet: TDataSet);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retIDComp:Integer;
    posTop,posLeft:Integer;
  end;

var
  FrmCompAbe: TFrmCompAbe;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uMenComp, uCompraCad, uCompras;

procedure TFrmCompAbe.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCompAbe.FormShow(Sender: TObject);
begin
   FrmCompAbe := Self;
   Top  := posTop;
   Left := posLeft;
   retIDComp := 0;
   TabAuxi.SQL.Clear;
   {try
      TabAuxi.SQL.Text := 'SELECT COM.IDComp, COM.Datped, COM.Status, USU.Nomusu, '+
      '(SELECT COUNT(*) FROM arqcompraite ITE WHERE ITE.IDComp = COM.IDComp) AS TotIte FROM arqcompra '+
      'COM LEFT JOIN arqusuario USU ON USU.IDUsu = COM.IDUsu WHERE FIND_IN_SET(Status,'+Aspas('0,1')+') '+
      'ORDER BY COM.Datped';
      TabAuxi.Open;
   except
      MessageDlg('Não foi possível abrir.'+#10+'Provável perda de conexão com servidor!', mtError, [mbOk], 0);
      PostMessage(Handle, WM_CLOSE, 0, 0);
   end; }
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmCompAbe.TabAuxiCalcFields(DataSet: TDataSet);
begin
   case TabAuxiStatus.AsInteger of
      0: TabAuxistrStatus.Value := 'EM ANÁLISE';
      1: TabAuxistrStatus.Value := 'EM COTAÇÃO';
      2: TabAuxistrStatus.Value := 'ENVIADO';
   end;
end;

procedure TFrmCompAbe.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   with DBGrid1 do
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
         Canvas.Brush.Color := $00D7E4FF;
         Canvas.Font.Color  := clBlack;
      end;
      Canvas.FillRect(Rect);
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
      if Column.FieldName <> '' then
      begin
         if Column.Alignment = taCenter then Canvas.TextRect(Rect,Rect.Left + (Rect.Width - Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then Canvas.TextRect(Rect,Rect.Left + Rect.Width - Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify  then Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText);
      end;
   end; //with
end;

procedure TFrmCompAbe.DBGrid1DblClick(Sender: TObject);
begin
   FrmMenComp.FechaForms;
   FrmCompraCad := TFrmCompraCad.Create(Application);
   FrmCompraCad.Parent := FrmMenComp.PanelShow;
   CentralizarControl(FrmCompraCad, FrmMenComp.PanelShow);
   FrmCompraCad.recIDComp := TabAuxiIDComp.AsInteger;
   FrmCompraCad.Show;
   Self.Close;
end;

procedure TFrmCompAbe.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompAbe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabAuxi.Close;
   Self := nil;
end;

end.
