unit uRatValorTemp;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, uRESTDWBasicDB,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, Vcl.StdCtrls,
   Vcl.Mask, RxToolEdit, RxCurrEdit;

type
 TFrmRatVlrTemp = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    TabTitRate: TRESTDWClientSQL;
    SouTitRate: TDataSource;
    Label35: TLabel;
    TabTitRateIDTitu: TIntegerField;
    TabTitRateIDNatFin: TIntegerField;
    TabTitRateValorRat: TFloatField;
    TabNatFin: TRESTDWClientSQL;
    SouNatFin: TDataSource;
    TabNatFinIDNatFin: TFDAutoIncField;
    TabNatFinDesnat: TWideStringField;
    TabTitRateDesNatLook: TWideStringField;
    edTotPer: TCurrencyEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabTitRateAfterPost(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure TabTitRateBeforePost(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabTitRatePostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure TabTitRateAfterInsert(DataSet: TDataSet);
 private
    { Private declarations }
    function CalcSaldo:Boolean;
 public
    { Public declarations }
    recSaltit:Double;
    recIDTitu:Integer;
 end;

var
   FrmRatVlrTemp: TFrmRatVlrTemp;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmRatVlrTemp.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmRatVlrTemp.FormShow(Sender: TObject);
begin
   TabNatFin.Open;
   TabTitRate.SQL.Text := 'SELECT * FROM arqtitulorat WHERE IDTitu = '+recIDTitu.ToString;
   TabTitRate.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 4;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   CalcSaldo;
   DBGrid1.SetFocus;
end;

procedure TFrmRatVlrTemp.TabTitRateAfterInsert(DataSet: TDataSet);
begin
   TabTitRateIDTitu.Value := recIDTitu;
end;

procedure TFrmRatVlrTemp.TabTitRateAfterPost(DataSet: TDataSet);
begin
   CalcSaldo;
end;

procedure TFrmRatVlrTemp.TabTitRateBeforePost(DataSet: TDataSet);
begin
   if TabTitRateIDNatFin.AsInteger <= 0 then
   begin
      tabTitRate.Cancel;
      Abort;
      Exit;
   end;
end;

procedure TFrmRatVlrTemp.TabTitRatePostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
   if (E is EFDDBEngineException) and (EFDDBEngineException(E).Kind = ekUKViolated) then
   begin
      MostraMsg('Erro', 'Essa natureza já foi usando na divisão de valor', mtError, [mbOk]);
      Action := daAbort;
      Exit;
   end;
end;

function TFrmRatVlrTemp.CalcSaldo:Boolean;
var
   auxSaldo:Double;
   auxIDNatFin:Integer;
begin
   Result   := True;
   auxSaldo := 0.00;
   auxIDNatFin := TabTitRateIDNatFin.AsInteger;
   TabTitRate.DisableControls;
   try
      TabTitRate.First;
      while not TabTitRate.Eof do
      begin
         auxSaldo := auxSaldo + TabTitRateValorRat.AsFloat;
         TabTitRate.Next;
      end;
      edTotPer.Value := recSaltit - auxSaldo;
      Application.ProcessMessages;
      if auxSaldo > recSaltit then
      begin
         MostraMsg('Aviso', 'O Total dividido entre as Naturezas está maior que o Valor do Título!',mtWarning, [mbOk]);
         Result := False;
         Exit;
      end;
   finally
      TabTitRate.Locate('IDNatFin',auxIDNatFin,[]);
      TabTitRate.EnableControls;
   end;
end;

procedure TFrmRatVlrTemp.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00BFD5FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
   if Column.ID < 2 then
       DBGrid1.Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText)
   else if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0);
end;

procedure TFrmRatVlrTemp.DBGrid1CellClick(Column: TColumn);
begin
   if TabTitRate.RecordCount > 0 then
   begin
      if Column.ID = 2 then
      begin
         if MostraMsg('Confirmação', 'Confirma exclusão deste Valor?', mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabTitRate.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqtitrate -> '+E.Message);
                  MostraMsg('Erro','Não foi possível excluir!', mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
      end; //if
      DBGrid1.SelectedField := TabTitRateValorRat;
   end; //if
end;

procedure TFrmRatVlrTemp.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmRatVlrTemp.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := CalcSaldo;
end;

procedure TFrmRatVlrTemp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabTitRate.State in dsEditModes then
   begin
      if TabTitRateIDNatFin.AsInteger <= 0 then
           TabTitRate.Post
      else TabTitRate.Cancel;
   end; //if
   TabTitRate.Close;
   TabNatFin.Close;
   Self := nil;
end;

end.
