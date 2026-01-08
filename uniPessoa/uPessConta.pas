unit uPessConta;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.Grids, Vcl.DBGrids, MarcLib, Vcl.StdCtrls, Vcl.Mask,
   RxToolEdit, RxDBCtrl, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB;

type
 TFrmPesConta = class(TForm)
    DBGrid1: TDBGrid;
    DBDateEdit1: TDBDateEdit;
    SouPessAsso: TDataSource;
    TabPessAsso: TRESTDWClientSQL;
    TabPessAssoIDPess: TIntegerField;
    TabPessAssoIDAsso: TIntegerField;
    TabPessAssoDatNasAssoc: TDateField;
    TabPessAssoDatcad: TDateTimeField;
    TabPessAssoNomAsso: TWideStringField;
    TabPessAssoCelularAsso: TWideStringField;
    TabPessAssoEmailAsso: TWideStringField;
    TabPessAssoFaceAsso: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBDateEdit1Exit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabPessAssoAfterInsert(DataSet: TDataSet);
    procedure TabPessAssoAfterPost(DataSet: TDataSet);
    procedure TabPessAssoBeforePost(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    function ValidaCampos: Boolean;
    { Private declarations }
 public
    { Public declarations }
 end;

var
  FrmPesConta: TFrmPesConta;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoasCad;

procedure TFrmPesConta.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesConta.FormShow(Sender: TObject);
begin
   TabPessAsso.Close;
   TabPessAsso.SQL.Text := 'SELECT * FROM arqpessasso WHERE IDPess = '+basIDPess.ToString;
   TabPessAsso.Open;
   TabAtual := TabPessAsso;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmPesConta.TabPessAssoAfterInsert(DataSet: TDataSet);
begin
   TabPessAssoIDPess.Value := basIDPess;
end;

procedure TFrmPesConta.TabPessAssoAfterPost(DataSet: TDataSet);
begin
   TabPessAsso.Refresh;
end;

procedure TFrmPesConta.DBGrid1CellClick(Column: TColumn);
begin
   if TabPessAsso.IsEmpty then Exit;
   if Column.ID = 5 then
   begin
      if MostraMsg('Confirmação','Confirma exclusão deste contato?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabPessAsso.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO,PastaLog,'ERRO: Não foi possível excluir arqpesasso -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir!', mtError, [mbOK]);
               Exit;
            end;
         end; // try
      end; // if
      DBGrid1.SelectedField := TabPessAsso.FieldByName('NomAsso');
   end; //if
end;

procedure TFrmPesConta.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Font.Color := clBlack;
      if Column.ID = 2 then
      begin
         if gdFocused in State then
         begin
            with DBDateEdit1 do
            begin
               Left    := Rect.Left + DBGrid1.Left + 4;
               Top     := Rect.Top + DBGrid1.Top  + 3;
               Width   := Rect.Right  - Rect.Left - 4;
               Height  := Rect.Bottom - Rect.Top - 15;
               Visible := True;
               ButtonWidth := 19;
               DBDateEdit1.SetFocus;
            end; // with
            (Sender as TDBGrid).Canvas.Brush.Color := clWhite;
         end; // if
      end else
      begin
         (Sender as TDBGrid).Canvas.Brush.Color := $00ECF2FF;
         if DBDateEdit1.Visible then DBDateEdit1.Visible := False;
      end;
   end; // if
   (Sender as TDBGrid).Canvas.FillRect(Rect);
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 5 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2,Rect.Top+3, 0);
   if Column.FieldName <> '' then
   begin
      if Column.Alignment = taCenter then Canvas.TextRect(Rect,Rect.Left + (Rect.Width - Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then Canvas.TextRect(Rect,Rect.Left + Rect.Width - Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmPesConta.DBDateEdit1Exit(Sender: TObject);
begin
   DBGrid1.SelectedField := TabPessAsso.FieldByName('EmailAsso');
   DBGrid1.SetFocus;
end;

procedure TFrmPesConta.TabPessAssoBeforePost(DataSet: TDataSet);
begin
   if not ValidaCampos then Abort;
end;

function TFrmPesConta.ValidaCampos:Boolean;
begin
   Result := False;
   if TabPessAssoNomAsso.AsString.Trim.Length < 3 then
   begin
      TabPessAsso.Cancel;
      Exit;
   end;
   if (Trim(TabPessAssoEmailAsso.Value) <> '') and (not ValidarEmail(Trim(TabPessAssoEmailAsso.Value))) then
   begin
      MostraMsg('Erro','Email inválido!',mtError, [mbOK]);
      DBGrid1.SelectedField := TabPessAsso.FieldByName('EmailAsso');
      Exit;
   end else
   if (TabPessAssoDatNasAssoc.Value > 1) and (TabPessAssoDatNasAssoc.Value > DataServer) then
   begin
      MostraMsg('Erro','Data de nascimento maior que HOJE.', mtError, [mbOK]);
      DBGrid1.SelectedField := TabPessAsso.FieldByName('DatnasAut');
      Exit;
   end else
   if (Trim(TabPessAssoCelularAsso.Value) <> '') and (not ValidaCelular(AllTrim(TabPessAssoCelularAsso.Value))) then
   begin
      MostraMsg('Erro', 'Número de celular inválido!', mtError, [mbOK]);
      DBGrid1.SelectedField := TabPessAsso.FieldByName('CelularAsso');
      Exit;
   end; //if
   Result := True;
end;

procedure TFrmPesConta.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if TabPessAsso.State in dsEditModes then
   begin
      if not ValidaCampos then
      begin
         CanClose := False;
         Exit;
      end;
      if TabPessAsso.State in dsEditModes then TabPessAsso.Post;
   end; //if
end;

procedure TFrmPesConta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPessAsso.Close;
end;

end.
