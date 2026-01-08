unit uTipoProSer;

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
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
 TFrmTipProSer = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    DBGrid1: TDBGrid;
    TabTipProSer: TRESTDWClientSQL;
    SouTipProSer: TDataSource;
    TabTipProSerIDTippro: TSmallintField;
    TabTipProSerDesTippro: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabTipProSerAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmTipProSer: TFrmTipProSer;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmTipProSer.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTipProSer.FormShow(Sender: TObject);
begin
   TabTipProSer.SQL.Text := 'SELECT * FROM arqprodutotip ORDER BY DesTippro';
   TabTipProSer.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmTipProSer.TabTipProSerAfterPost(DataSet: TDataSet);
begin
   if Trim(TabTipProSerDesTippro.Value) = '' then TabTipProSer.Delete;
end;

procedure TFrmTipProSer.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00BFD5FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
   if Column.ID < 1 then
       DBGrid1.Canvas.TextRect(Rect, Rect.Left + 3, Rect.Top + 5, Column.Field.DisplayText)
   else if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left + 5, Rect.Top + 4, 0);
end;

procedure TFrmTipProSer.DBGrid1CellClick(Column: TColumn);
begin
   if TabTipProSer.RecordCount > 0 then
   begin
      if Column.ID = 1 then
      begin
         if MostraMsg('Confirmação', 'Confirma eliminação deste Tipo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabTipProSer.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqprodutotip -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
      end; //if
      DBGrid1.SelectedField := TabTipProSerDesTippro;
   end; //if
end;

procedure TFrmTipProSer.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTipProSer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabTipProSer.State in dsEditModes then TabTipProSer.Post;
   TabTipProSer.Close;
   Action := caFree;
end;

end.
