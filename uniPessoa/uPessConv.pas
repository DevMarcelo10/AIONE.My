unit uPessConv;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.Grids, Vcl.DBGrids, RxToolEdit, MarcLib, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   uRESTDWBasicTypes, FireDAC.Comp.Client, uRESTDWBasicDB, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, DBGridEx, Vcl.Imaging.pngimage;

type
 TFrmPesConv = class(TForm)
    TabPessConv: TRESTDWClientSQL;
    SouPessConv: TDataSource;
    TabPessConvIDPess: TIntegerField;
    TabPessConvIDConv: TIntegerField;
    TabPessConvVlrLimite: TFloatField;
    SouConv: TDataSource;
    TabConv: TRESTDWClientSQL;
    TabConvIDConv: TIntegerField;
    TabConvNomcon: TWideStringField;
    TabPessConvNomcon: TWideStringField;
    TabPessConvNroMatric: TWideStringField;
    TabPessConvNroCartao: TWideStringField;
    TabPessConvIndAtivo: TWideStringField;
    TabConvCli: TRESTDWClientSQL;
    SouConvCli: TDataSource;
    TabConvCliIDConv: TIntegerField;
    TabConvCliCNPJFil: TWideStringField;
    TabConvCliNomfil: TWideStringField;
    TabPessConvCNPJFil: TWideStringField;
    TabPessConvDatcadCon: TDateField;
    TabPessConvNomFilCli: TWideStringField;
    DBGridEx1: TDBGridEx;
    procedure FormShow(Sender: TObject);
    procedure TabPessConvBeforePost(DataSet: TDataSet);
    procedure TabPessConvAfterInsert(DataSet: TDataSet);
    procedure DBDateEdit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure TabPessConvAfterScroll(DataSet: TDataSet);
    procedure DBGridEx1ColEnter(Sender: TObject);
    procedure DBGridEx1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridEx1CellClick(Column: TColumn);
 private
    function ValidaCampos: Boolean;
    { Private declarations }
 public
    { Public declarations }
 end;

var
  FrmPesConv: TFrmPesConv;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoasCad;

procedure TFrmPesConv.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesConv.FormShow(Sender: TObject);
begin
   TabConv.Open;
   TabPessConv.Close;
   TabPessConv.SQL.Text := 'SELECT * FROM arqpessconv WHERE IDPess = '+basIDPess.ToString;
   TabPessConv.Open;
   TabAtual := TabPessConv;
end;

procedure TFrmPesConv.TabPessConvAfterInsert(DataSet: TDataSet);
begin
   TabPessConvIDPess.Value   := basIDPess;
   TabPessConvIndAtivo.Value := '1';
end;

procedure TFrmPesConv.TabPessConvAfterScroll(DataSet: TDataSet);
begin
   TabConvCli.Close;
   TabConvCli.SQL.Text := 'SELECT IDConv,CNPJFil,Nomfil FROM arqconvfilcli WHERE IDConv = '+iif(TabPessConvIDConv.AsInteger > 0, TabPessConvIDConv.AsString,'0');
   TabConvCli.Open;
end;

procedure TFrmPesConv.DBDateEdit1Exit(Sender: TObject);
begin
   DBGridEx1.SelectedField := TabPessConv.FieldByName('NroMatric');
   DBGridEx1.SetFocus;
end;

procedure TFrmPesConv.TabPessConvBeforePost(DataSet: TDataSet);
begin
   if not ValidaCampos then
   begin
      TabPessConv.Cancel;
      Abort;
   end;
end;

function TFrmPesConv.ValidaCampos: Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if TabPessConvIDConv.Value <= 0 then Exit;

   if TabPessConv.State = dsInsert then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         try
            with QueAuxi do
            begin
               DataBase := DM.DWDataBase;
               SQL.Text := 'SELECT 1 FROM arqpessconv WHERE IDPess = '+TabPessConvIDPess.AsString+' AND IDConv = '+TabPessConvIDConv.AsString;
               QueAuxi.Open;
               if not IsEmpty then
               begin
                  MostraMsg('Aviso', 'Convênio já cadastrado para essa pessoa!', mtWarning, [mbOK]);
                  Exit;
               end;
            end;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO,PastaLog,'ERRO: Não foi possível validar campos arqpesconv -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível validar campos!', mtError, [mbOK]);
               Exit;
            end;
         end; //try
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end; //if
   Result := True;
end;

procedure TFrmPesConv.DBGridEx1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabPessConv.IsEmpty then Exit;
   if Column.Index = 7 then
   begin
      if MostraMsg('Confirmação','Confirma exclusão deste convênio para esta pessoa?', mtConfirmation,[mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            try
               with QueAuxi do
               begin
                  DataBase := DM.DWDataBase;
                  SQL.Text := 'DELETE FROM arqpessconv WHERE IDPess = '+TabPessConvIDPess.AsString+' AND IDConv = '+TabPessConvIDConv.AsString;
                  ExecSQL;
                  TabPessConv.Close;
                  TabPessConv.Open;
               end;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO,PastaLog,'ERRO: Não foi possível excluir arqpesconv -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!', mtError, [mbOK]);
                  Exit;
               end;
            end; //try
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
   end; //if
end;

procedure TFrmPesConv.DBGridEx1ColEnter(Sender: TObject);
var
   EnteredColumn:TColumn;
begin
   EnteredColumn := DBGridEx1.Columns[DBGridEx1.SelectedIndex];
   if Assigned(EnteredColumn.Field) then
   begin
      if EnteredColumn.Field.FieldName = 'NomFilCli' then
      begin
         TabConvCli.Close;
         TabConvCli.SQL.Text := 'SELECT IDConv,CNPJFil,Nomfil FROM arqconvfilcli WHERE IDConv = '+iif(TabPessConvIDConv.AsInteger > 0, TabPessConvIDConv.AsString,'0');
         TabConvCli.Open;
      end;
   end;
end;

procedure TFrmPesConv.DBGridEx1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Shift = [ssCtrl]) and (Key = 46) then Key := 0;
end;

procedure TFrmPesConv.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if TabPessConv.State in dsEditModes then
   begin
      if not ValidaCampos then
      begin
         CanClose := False;
         Exit;
      end;
      if TabPessConv.State in dsEditModes then TabPessConv.Post;
   end; //if
end;

procedure TFrmPesConv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabConv.Close;
   TabConvCli.Close;
   TabPessConv.Close;
end;

end.
