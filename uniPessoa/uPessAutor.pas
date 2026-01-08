unit uPessAutor;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Data.DB,
   Vcl.Grids, Vcl.DBGrids, LMDBaseControl, LMDBaseGraphicControl,
   Vcl.Dialogs, LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, Vcl.StdCtrls,
   Vcl.Mask, RxToolEdit, MarcLib, LMDSimplePanel, RxDBCtrl, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes,
   FireDAC.Comp.Client, uRESTDWBasicDB;

type
 TFrmPesAutor = class(TForm)
    DBGrid1: TDBGrid;
    DBDateEdit1: TDBDateEdit;
    TabPesAutor: TRESTDWClientSQL;
    SouPesAutor: TDataSource;
    TabPesAutorIDPess: TIntegerField;
    TabPesAutorIDAuto: TIntegerField;
    TabPesAutorDatnasAut: TDateField;
    TabPesAutorNomaut: TWideStringField;
    TabPesAutorCelularAut: TWideStringField;
    TabPesAutorCPFaut: TWideStringField;
    TabPesAutorRGEaut: TWideStringField;
    TabPesAutorGraParAut: TWideStringField;
    TabPesAutorSitAutor: TWideStringField;
    TabPesAutorObsautor: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure TabPesAutorAfterInsert(DataSet: TDataSet);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBDateEdit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure TabPesAutorBeforePost(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabPesAutorAfterPost(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    function ValidaCampos: Boolean;
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmPesAutor: TFrmPesAutor;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoasCad;

procedure TFrmPesAutor.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesAutor.FormShow(Sender: TObject);
begin
   TabPesAutor.Close;
   TabPesAutor.SQL.Text := 'SELECT * FROM arqpessauto WHERE IDPess = '+basIDPess.ToString;
   TabPesAutor.Open;
   TabAtual := TabPesAutor;
   TStringGrid(DBGrid1).DefaultRowHeight := 21; // BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmPesAutor.TabPesAutorAfterInsert(DataSet: TDataSet);
begin
   TabPesAutorIDPess.Value := basIDPess;
   TabPesAutorSitAutor.Value := 'AUTORIZADO';
end;

procedure TFrmPesAutor.TabPesAutorAfterPost(DataSet: TDataSet);
begin
   TabPesAutor.Refresh;
end;

procedure TFrmPesAutor.TabPesAutorBeforePost(DataSet: TDataSet);
begin
   if not ValidaCampos then Abort;
end;

procedure TFrmPesAutor.DBDateEdit1Exit(Sender: TObject);
begin
   DBGrid1.SelectedField := TabPesAutor.FieldByName('SitAutor');
   DBGrid1.SetFocus;
end;

procedure TFrmPesAutor.DBGrid1CellClick(Column: TColumn);
begin
   if TabPesAutor.IsEmpty then Exit;
   if Column.ID = 8 then
   begin
      DBGrid1.SelectedField := TabPesAutor.FieldByName('Nomaut');
      if MostraMsg('Confirmação','Confirma exclusão deste autorizado?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabPesAutor.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqpesautor -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir!', mtError, [mbOK]);
               Exit;
            end;
         end; //try
      end; //if
   end; //if
end;

procedure TFrmPesAutor.DBGrid1ColExit(Sender: TObject);
begin
   if DBGrid1.SelectedField = TabPesAutor.FieldByName('CPFaut') then
   begin
      if (Trim(TabPesAutorCPFaut.Value) <> '') and (not CPF(TabPesAutorCPFaut.Value)) then
      begin
         MostraMsg('Erro','Número de CPF inválido!', mtError, [mbOK]);
         DBGrid1.SelectedField := TabPesAutor.FieldByName('CPFaut');
         DBGrid1.SetFocus;
         Exit;
      end; //if
   end; //if
end;

procedure TFrmPesAutor.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Font.Color := clBlack;
      if Column.ID = 5 then
      begin
         if gdFocused in State then
         begin
            with DBDateEdit1 do
            begin
               Left   := Rect.Left + DBGrid1.Left + 4;
               Top    := Rect.Top  + DBGrid1.Top  + 3;
               Width  := Rect.Right  - Rect.Left  - 4;
               Height := Rect.Bottom - Rect.Top   - 15;
               ButtonWidth := 19;
               Visible := True;
               DBDateEdit1.SetFocus;
            end; // with
            (Sender as TDBGrid).Canvas.Brush.Color := clWhite;
         end; //if
      end else
      begin
         (Sender as TDBGrid).Canvas.Brush.Color := $00ECF2FF;
         if DBDateEdit1.Visible then DBDateEdit1.Visible := False;
      end;
   end; // if
   (Sender as TDBGrid).Canvas.FillRect(Rect);
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 8 then  DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left + 2,Rect.Top + 3, 0);
   if Column.FieldName <> '' then
   begin
      if Column.Alignment = taCenter then Canvas.TextRect(Rect,Rect.Left + (Rect.Width - Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then Canvas.TextRect(Rect,Rect.Left + Rect.Width - Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

function TFrmPesAutor.ValidaCampos: Boolean;
begin
   Result := False;
   if Length(AllTrim(TabPesAutorNomaut.Value)) < 3 then
   begin
      TabPesAutor.Cancel;
      Exit;
   end;
   if (Trim(TabPesAutorCelularAut.Value) <> '') and (not ValidaCelular(AllTrim(TabPesAutorCelularAut.Value))) then
   begin
      MostraMsg('Erro','Número de celular inválido!',mtError, [mbOK]);
      DBGrid1.SelectedField := TabPesAutor.FieldByName('CelularAut');
      Exit;
   end
   else if (Trim(TabPesAutorCPFaut.Value) <> '') and (not CPF(TabPesAutorCPFaut.Value)) then
   begin
      MostraMsg('Erro','Número de CPF inválido!',mtError, [mbOK]);
      DBGrid1.SelectedField := TabPesAutor.FieldByName('CPFaut');
      Exit;
   end
   else if (TabPesAutorDatnasAut.Value > 1) and (TabPesAutorDatnasAut.Value > DataServer) then
   begin
      MostraMsg('Erro','Data de nascimento maior que HOJE.',mtError, [mbOK]);
      DBGrid1.SelectedField := TabPesAutor.FieldByName('DatnasAut');
      Exit;
   end
   else if Trim(TabPesAutorGraParAut.Value) = '' then
   begin
      MostraMsg('Aviso', 'Favor entrar com o Grau de Parentesco!',mtWarning, [mbOK]);
      DBGrid1.SelectedField := TabPesAutor.FieldByName('GraParAut');
      Exit;
   end; // if
   Result := True;
end;

procedure TFrmPesAutor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if TabPesAutor.State in dsEditModes then
   begin
      if not ValidaCampos then
      begin
         CanClose := False;
         Exit;
      end;
      if TabPesAutor.State in dsEditModes then TabPesAutor.Post;
   end; // if
end;

procedure TFrmPesAutor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPesAutor.Close;
end;

end.
