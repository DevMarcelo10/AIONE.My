unit uUnidades;

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
 TFrmUnidades = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    DBGrid1: TDBGrid;
    TabUnidades: TRESTDWClientSQL;
    SouUnidades: TDataSource;
    TabUnidadesIDUni: TIntegerField;
    TabUnidadesDesUN: TWideStringField;
    TabUnidadesSiglaUN: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabUnidadesAfterPost(DataSet: TDataSet);
    procedure TabUnidadesBeforePost(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmUnidades: TFrmUnidades;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmUnidades.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmUnidades.FormShow(Sender: TObject);
begin
   TabUnidades.SQL.Text := 'SELECT * FROM arqunidades ORDER BY DesUN';
   TabUnidades.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmUnidades.TabUnidadesAfterPost(DataSet: TDataSet);
begin
   if Trim(TabUnidadesDesUN.Value) = '' then TabUnidades.Delete;
end;

procedure TFrmUnidades.TabUnidadesBeforePost(DataSet: TDataSet);
begin
   if Trim(TabUnidadesDesUN.Value)   = '' then Abort;
   if Trim(TabUnidadesSiglaUN.Value) = '' then
   begin
      MostraMsg('Aviso', 'Favor entrar com a Sigla da unidade!',mtWarning, [mbOk]);
      Abort;
   end;
end;

procedure TFrmUnidades.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00BFD5FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
   if Column.ID < 2 then
       DBGrid1.Canvas.TextRect(Rect, Rect.Left + 3, Rect.Top + 5, Column.Field.DisplayText)
   else if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+4, 0);
end;

procedure TFrmUnidades.DBGrid1CellClick(Column: TColumn);
begin
   if TabUnidades.RecordCount > 0 then
   begin
      if Column.ID = 2 then
      begin
         if MostraMsg('Confirmação', 'Confirma eliminação desta Unidade?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabUnidades.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqunidades-> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
         DBGrid1.SelectedField := TabUnidadesSiglaUN;
      end; //if
   end; //if
end;

procedure TFrmUnidades.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmUnidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabUnidades.State in dsEditModes then TabUnidades.Post;
   TabUnidades.Close;
   Action := caFree;
end;

end.
