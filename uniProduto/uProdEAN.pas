unit uProdEAN;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, MarcLib, LMDBaseControl, Vcl.DBGrids,
   LMDBaseGraphicControl, LMDBaseLabel, LMDLabel, LMDControl, LMDCustomControl,
   LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel, AdvGlowButton,
   LMDCustomLabel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB;

type
   TFrmProdEAN = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    TabProdEAN: TRESTDWClientSQL;
    SouProdEAN: TDataSource;
    TabProdEANIDProd: TIntegerField;
    TabProdEANCodEAN: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabProdEANBeforePost(DataSet: TDataSet);
    procedure TabProdEANAfterInsert(DataSet: TDataSet);
    procedure TabProdEANAfterPost(DataSet: TDataSet);
    procedure TabProdEANPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
    { Private declarations }
   public
    { Public declarations }
    recIDProd:Integer;
   end;

var
   FrmProdEAN: TFrmProdEAN;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmProdEAN.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmProdEAN.FormShow(Sender: TObject);
begin
   TabProdEAN.SQL.Text := 'SELECT * FROM arqprodutoean WHERE IDProd = '+recIDProd.ToString;
   TabProdEAN.Open;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmProdEAN.TabProdEANAfterInsert(DataSet: TDataSet);
begin
   TabProdEANIDProd.Value := recIDProd;
end;

procedure TFrmProdEAN.TabProdEANAfterPost(DataSet: TDataSet);
begin
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmProdEAN.TabProdEANBeforePost(DataSet: TDataSet);
begin
   if TabProdEANCodEAN.AsString.Trim = '' then
   begin
      Abort;
   end else
   if not IsValidEANCode(TabProdEANCodEAN.AsString.Trim) then
   begin
      MostraMsg('Erro','Verifique o Código de Barras!',mtWarning, [mbOK]);
      Abort;
   end;
   TabProdEANCodEAN.Value := OnlyNumbers(TabProdEANCodEAN.Value);
end;

procedure TFrmProdEAN.TabProdEANPostError(DataSet:TDataSet; E:EDatabaseError; var Action: TDataAction);
begin
   if AnsiPos('Duplicate',E.Message) > 0 then
   begin
      MostraMsg('Erro','Código de Barras já associado à esse produto.',mtWarning, [mbOK]);
      Action := daAbort;
   end;
end;

procedure TFrmProdEAN.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if TabProdEAN.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação deste Código de Barras?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabProdEAN.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqprodutoean -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
      end
      else TabProdEAN.Cancel;
   end; //if
   DBGrid1.SelectedField := TabProdEANCodEAN;
end;

procedure TFrmProdEAN.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then Close;
end;

procedure TFrmProdEAN.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+2, 3);
end;

procedure TFrmProdEAN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabProdEAN.State in dsEditModes then
   begin
      if not IsValidEANCode(TabProdEANCodEAN.Value) then
           TabProdEAN.Delete
      else TabProdEAN.Post;
   end;
   TabProdEAN.Close;
   Action := caFree;
end;

end.
