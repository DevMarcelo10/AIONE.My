unit uConvCli;

interface

uses
   Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, MarcLib,
   LMDBaseControl, Vcl.DBGrids, LMDBaseGraphicControl, LMDBaseLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   LMDCustomLabel, System.Types, LMDBaseEdit, LMDCustomEdit, Vcl.StdCtrls, uRESTDWBasicDB,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, AdvGlowButton,
   FireDAC.Stan.Intf, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   uRESTDWBasicTypes, FireDAC.Comp.Client, Messages, Vcl.ExtCtrls;

type
  TFrmConPesAti = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCadastro: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    SouPess: TDataSource;
    TabPess: TRESTDWClientSQL;
    TabPessNompes: TWideStringField;
    TabPessCpfCnpjPes: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDConv:Integer;
  end;

var
   FrmConPesAti: TFrmConPesAti;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmConPesAti.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmConPesAti.FormShow(Sender: TObject);
begin
   try
      TabPess.SQL.Text := 'SELECT PES.Nompes,PES.CpfCnpjPes FROM arqpessconv PEC LEFT JOIN arqpessoa PES '+
      'ON PEC.IDPess = PES.IDPess WHERE PEC.IDConv = '+recIDConv.ToString+' AND PES.IndAtivo = "1"';
      TabPess.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmConPesAti.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmConPesAti.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmConPesAti.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPess.Close;
   Self := nil;
end;

end.
