unit uPessUsoCont;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.Grids, Vcl.DBGrids, MarcLib, Vcl.Mask, Vcl.StdCtrls,
   RxToolEdit, RxDBCtrl, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, uRESTDWBasicDB,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmPesUCon = class(TForm)
    DBGrid1: TDBGrid;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    TabPesUCon: TRESTDWClientSQL;
    SouPesUCon: TDataSource;
    TabProd: TRESTDWClientSQL;
    TabMedico: TRESTDWClientSQL;
    TabPBM: TRESTDWClientSQL;
    TabPBMIDPBM: TSmallintField;
    TabPesUConIDPess: TIntegerField;
    TabPesUConIDProd: TIntegerField;
    TabPesUConIDPBM: TIntegerField;
    TabPesUConQtdDia: TFloatField;
    TabPesUConDatUltCom: TDateField;
    TabPesUConDatProCom: TDateField;
    TabProdIDProd: TFDAutoIncField;
    TabPesUConCpfPBM: TWideStringField;
    TabProdDespro: TWideStringField;
    TabPBMNomPBM: TWideStringField;
    TabPesUConDespro: TWideStringField;
    TabPesUConNommed: TWideStringField;
    TabPesUConNomPBM: TWideStringField;
    TabMedicoNroRegProf: TWideStringField;
    TabMedicoNompes: TWideStringField;
    TabPesUConNroRegProf: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure TabPesUConAfterInsert(DataSet: TDataSet);
    procedure TabPesUConBeforePost(DataSet: TDataSet);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBDateEdit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure DBDateEdit2Exit(Sender: TObject);
 private
    function ValidaCampos: Boolean;
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmPesUCon: TFrmPesUCon;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoasCad;

procedure TFrmPesUCon.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesUCon.FormShow(Sender: TObject);
begin
   TabPBM.Open;
   TabPBM.Open;
   TabMedico.Open;
   TabPesUCon.Close;
   TabPesUCon.SQL.Text := 'SELECT * FROM arqpessucon WHERE IDPess = '+basIDPess.ToString;
   TabPesUCon.Open;
   TabAtual := TabPesUCon;
   TStringGrid(DBGrid1).DefaultRowHeight := 21; //BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmPesUCon.DBDateEdit1Exit(Sender: TObject);
begin
   DBGrid1.SelectedField := TabPesUCon.FieldByName('DatProCom');
   DBGrid1.SetFocus;
end;

procedure TFrmPesUCon.DBDateEdit2Exit(Sender: TObject);
begin
   DBGrid1.SelectedField := TabPesUCon.FieldByName('NomPBM');
   DBGrid1.SetFocus;
end;

procedure TFrmPesUCon.DBGrid1CellClick(Column: TColumn);
begin
   if TabPesUCon.IsEmpty then Exit;
   if Column.ID = 8 then
   begin
      if MostraMsg('Confirmação', 'Confirma exclusão deste Uso Contínuo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabPesUCon.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog,'ERRO: Não foi possível excluir arqpesucon -> ' + E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!', mtError, [mbOK]);
               Exit;
            end;
         end; //try
      end; //if
      if not TabPesUCon.IsEmpty then DBGrid1.SelectedField := TabPesUCon.FieldByName('CpfPBM');
   end; //if
end;

procedure TFrmPesUCon.TabPesUConAfterInsert(DataSet: TDataSet);
begin
   TabPesUConIDPess.Value := basIDPess;
end;

procedure TFrmPesUCon.TabPesUConBeforePost(DataSet: TDataSet);
begin
   if not ValidaCampos then Abort;
end;

function TFrmPesUCon.ValidaCampos: Boolean;
begin
   Result := False;
   if TabPesUConIDProd.Value <= 0 then
   begin
      MostraMsg('Erro', 'Favor entrar com o Produto!', mtError, [mbOK]);
      DBGrid1.SelectedField := TabPesUCon.FieldByName('ConIDProd');
      Exit;
   end;
   if TabPesUConIDPBM.Value > 0 then
   begin
      if (Trim(TabPesUConCpfPBM.Value) = '') or (not CPF(TabPesUConCpfPBM.Value))
      then
      begin
         MostraMsg('Erro', 'Favor entrar com um CPF válido!', mtError, [mbOK]);
         DBGrid1.SelectedField := TabPesUCon.FieldByName('CpfPBM');
         Exit;
      end;
      if Trim(TabPesUConNroRegProf.Value) = '' then
      begin
         MostraMsg('Erro', 'Favor entrar com CRM válido!', mtError, [mbOK]);
         DBGrid1.SelectedField := TabPesUCon.FieldByName('CRMMed.');
         Exit;
      end;
   end; //if
   Result := True;
end;

procedure TFrmPesUCon.DBGrid1ColExit(Sender: TObject);
var
   QueAux:TRESTDWClientSQL;
begin
   if TabPesUCon.IsEmpty then Exit;
   try
      if DBGrid1.SelectedField.FieldName = 'CpfPBM' then
      begin
         if (Trim(TabPesUConCpfPBM.Value) <> '') and (not CPF(TabPesUConCpfPBM.Value)) then
         begin
            MostraMsg('CPF inválido', 'Favor entrar com CPF válido!',mtWarning, [mbOK]);
            TabPesUConCpfPBM.Value := '';
            DBGrid1.SelectedField  := TabPesUCon.FieldByName('CpfPBM');
            Exit;
         end;
      end; //if

      if (DBGrid1.SelectedField.FieldName = 'NroRegProf') and  (Trim(TabPesUConNroRegProf.Value) <> '') then
      begin
         try
            QueAux := TRESTDWClientSQL.Create(nil);
            QueAux.DataBase := DM.DWDataBase;
            QueAux.SQL.Clear;
            QueAux.SQL.Text := 'SELECT Nompes FROM arqpessoa WHERE NroRegProf = '+Aspas(TabPesUConNroRegProf.Value);
            QueAux.Open;
            if not QueAux.IsEmpty then
            begin
               if not(TabPesUCon.State in dsEditModes) then TabPesUCon.Edit;
               TabPesUConNommed.Value := QueAux.FieldByName('Nompes').AsString;
            end else
            begin
               MostraMsg('CRM inválido', 'CRM do Médico(a) não encontrado!',mtWarning, [mbOK]);
               if not(TabPesUCon.State in dsEditModes) then TabPesUCon.Edit;
               TabPesUConNroRegProf.Value := '';
               TabPesUConNommed.Value := '';
            end;
         finally
            QueAux.Close;
            FreeAndNil(QueAux);
         end;
      end; //if
   except
   end;
end;

procedure TFrmPesUCon.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Font.Color := clBlack;
      if Column.ID = 3 then
      begin
         if gdFocused in State then
         begin
            with DBDateEdit1 do
            begin
               Left   := Rect.Left   + DBGrid1.Left + 4;
               Top    := Rect.Top    + DBGrid1.Top + 3;
               Width  := Rect.Right  - Rect.Left - 4;
               Height := Rect.Bottom - Rect.Top - 15;
               ButtonWidth := 19;
               Visible := True;
               DBDateEdit1.SetFocus;
            end; // with
            if DBDateEdit2.Visible then DBDateEdit2.Visible := False;
            (Sender as TDBGrid).Canvas.Brush.Color := clWhite;
         end; // if
      end else
      if Column.ID = 4 then
      begin
         if gdFocused in State then
         begin
            with DBDateEdit2 do
            begin
               Left    := Rect.Left + DBGrid1.Left + 4;
               Top     := Rect.Top  + DBGrid1.Top  + 3;
               Width   := Rect.Right  - Rect.Left  - 4;
               Height  := Rect.Bottom - Rect.Top   - 15;
               Visible := True;
               ButtonWidth := 19;
               DBDateEdit2.SetFocus;
            end; //with
            if DBDateEdit1.Visible then DBDateEdit1.Visible := False;
            (Sender as TDBGrid).Canvas.Brush.Color := clWhite;
         end; //if
      end else
      begin
         (Sender as TDBGrid).Canvas.Brush.Color := $00ECF2FF;
         if DBDateEdit1.Visible then DBDateEdit1.Visible := False;
         if DBDateEdit2.Visible then DBDateEdit2.Visible := False;
      end;
   end; // if
   (Sender as TDBGrid).Canvas.FillRect(Rect);
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 8 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2,Rect.Top+2, 0);
end;

procedure TFrmPesUCon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabPesUCon.State in dsEditModes then TabPesUCon.Post;
   TabPesUCon.Close;
   TabPBM.Close;
   TabProd.Close;
   TabMedico.Close;
end;

end.
