unit uPromPgrPro;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, MarcLib,
   Vcl.Grids, Vcl.DBGrids, LMDControl, LMDCustomControl, LMDCustomPanel, uRESTDWBasicTypes,
   LMDSimplePanel, LMDCustomBevelPanel, AdvGlowButton, FireDAC.Stan.Intf, FireDAC.Phys.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, uRESTDWBasicDB,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TFrmPromPgrPro = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    btNovoItem: TAdvGlowButton;
    TabPromPgr: TRESTDWClientSQL;
    SouPromPgr: TDataSource;
    TabPromPgrIDProm: TIntegerField;
    TabPromPgrIDProd: TIntegerField;
    TabPromPgrDespro: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btNovoItemClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDProm:Integer;
  end;

var
   FrmPromPgrPro: TFrmPromPgrPro;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromocaoCad, uPromPgr;

procedure TFrmPromPgrPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromPgrPro.FormShow(Sender: TObject);
begin
   TabPromPgr.SQL.Text := 'SELECT PGR.*,PRO.Despro FROM arqpromopgr PGR LEFT JOIN arqproduto PRO ON '+
   'PGR.IDProd = PRO.IDProd WHERE IDProm = '+recIDProm.ToString+' GROUP BY PGR.IDProm,PGR.IDProd ORDER BY PRO.Despro ';
   TabPromPgr.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmPromPgrPro.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00CCDDFF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4,4) else
   if Column.ID = 3 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4,0) else
   if Column.ID = 0 then
        DBGrid1.Canvas.TextRect(Rect,Rect.Left + (Rect.Width - DBGrid1.Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText)
   else DBGrid1.Canvas.TextRect(Rect, Rect.Left + 3, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmPromPgrPro.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabPromPgr.IsEmpty then Exit;
   if Column.ID = 3 then
   begin
      if MostraMsg('Confirmação', 'Confirma exclusão deste item promocional?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            try
               QueAuxi.SQL.Text := 'DELETE FROM arqpromopgr WHERE IDProm = '+TabPromPgrIDProm.ToString;
               QueAuxi.ExecSQL;
               TabPromPgr.Refresh;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqpromopgr -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!', mtError, [mbOK]);
                  Exit;
               end;
            end; //try
         finally
            FreeAndNil(QueAuxi);
         end;
      end; //if
      DBGrid1.SelectedField := TabPromPgrDespro;
   end else
   if Column.ID = 2 then
   begin
      FrmPromPgr := TFrmPromPgr.Create(nil);
      FrmPromCad.AtiForm   := FrmPromPgr;
      FrmPromPgr.Parent    := FrmPromCad.PanelBas;
      FrmPromPgr.recIDProm := recIDProm;
      FrmPromPgr.recIDProd := TabPromPgrIDProd.AsInteger;
      FrmPromCad.AtiForm.Show;
   end; //if
   if Column.ID >= 2 then DBGrid1.SelectedField := TabPromPgrDespro;
end;

procedure TFrmPromPgrPro.btNovoItemClick(Sender: TObject);
begin
   FrmPromPgr := TFrmPromPgr.Create(nil);
   FrmPromCad.AtiForm   := FrmPromPgr;
   FrmPromPgr.Parent    := FrmPromCad.PanelBas;
   FrmPromPgr.recIDProm := recIDProm;
   FrmPromPgr.recIDProd := 0;
   FrmPromCad.AtiForm.Show;
end;

procedure TFrmPromPgrPro.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromPgrPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPromPgr.Close;
   FreeAndNil(Self);
end;

end.
