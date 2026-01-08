unit uCaixaLan;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseEdit, LMDCustomEdit,
   LMDLabel, Data.DB, LMDBaseControl, LMDBaseLabel, Vcl.DBGrids, LMDBaseGraphicControl,
   LMDCustomLabel, LMDCustomBevelPanel, MarcLib, AdvEdBtn, AdvGlowButton, Vcl.StdCtrls,
   LMDSimplePanel, LMDDBEdit, LMDControl, Vcl.Grids, Vcl.ExtCtrls, LMDCustomControl,
   LMDCustomPanel,LMDCustomScrollBox, uRESTDWBasicTypes, FireDAC.Stan.Intf, AdvEdit,
   FireDAC.Stan.Error, FireDAC.Phys.Intf, uRESTDWBasicDB, FireDAC.DApt.Intf, LMDEdit,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.DatS, FireDAC.Stan.Option,
   FireDAC.Stan.Param;

type
  THackDBGrid = class(TDBGrid);

  TFrmCaixaLan = class(TForm)
    TabMovto: TRESTDWClientSQL;
    SouMovto: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabMovtoBeforeInsert(DataSet: TDataSet);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    procedure AjustGrid;
    { Private declarations }
   public
    { Public declarations }
  end;

var
   FrmCaixaLan: TFrmCaixaLan;

implementation

{$R *.dfm}

uses uDM, uConst, uMenComp, uLibFarm, uCompIte, uCompCriIA, uCompIteFil, uCompAddIt;

procedure TFrmCaixaLan.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCaixaLan.FormShow(Sender: TObject);
begin
   try
      //--> TabMovto.SQL.Text := '';
      TabMovto.Open;
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar abrir tabelas uCauxaLan -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível conectar ao servidor!', mtError, [mbOk]);
         PostMessage(Self.Handle, WM_CLOSE, 0, 0);
         Exit;
      end;
   end;
   AjustGrid;
end;

procedure TFrmCaixaLan.TabMovtoBeforeInsert(DataSet: TDataSet);
begin
   Abort;
end;

procedure TFrmCaixaLan.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmCaixaLan.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabMovto.IsEmpty then Exit;

   if Column.ID = 11 then
   begin
      if MostraMsg('Confirmação','Confirma exclusão deste item do pedido?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            try
               QueAuxi.DataBase := DM.DWDataBase;
               //QueAuxi.SQL.Text := 'DELETE FROM arqcompraite WHERE IDComp = '+recIDComp.ToString+' AND IDProd = '+TabCompraIteIDProd.AsString;
               //QueAuxi.ExecSQL;
            except
               on E:Exception do
               begin
                  //SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir registro do aquivo: arqcompraite: IDComp = '+recIDComp.ToString+', IDProd = '+TabCompraIteIDProd.AsString+' -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                  Exit;
               end;
            end;
         finally
            FreeAndNil(QueAuxi);
         end;
         TabMovto.Refresh;
      end; //if
     //--> DBGrid1.SelectedField := TabMovtoVlrult;
   end;
end;

procedure TFrmCaixaLan.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if ((THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) and (not (TabMovto.State in dsEditModes))) or (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00E1EBFF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      (Sender as TDBGrid).Canvas.FillRect(Rect);
   end;
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID =  8 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+7, Rect.Top+6,  4) else // Edit
   if Column.ID =  9 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+7, Rect.Top+6, 15) else // NF
   if Column.ID = 10 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+7, Rect.Top+6, 16) else // Imprimir
   if Column.ID = 11 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+7, Rect.Top+6, 17) else // Excluir
   if Column.FieldName <> '' then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmCaixaLan.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Shift = [SsCtrl]) and (Key = 46) then Key := 0;
end;

procedure TFrmCaixaLan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabMovto.Active  then TabMovto.Close;
   FadeInOut(Self,'Out',10);
   Self := nil;
end;

end.
