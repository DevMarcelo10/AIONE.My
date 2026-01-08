unit uPessNego;

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
   FireDAC.Comp.Client, uRESTDWBasicDB, AdvGlowButton, Vcl.DBCtrls;

type
 TFrmPesNego = class(TForm)
    DBGrid1: TDBGrid;
    TabNegocio: TRESTDWClientSQL;
    SouNego: TDataSource;
    TabNegocioIDNego: TFDAutoIncField;
    TabNegocioIDPess: TIntegerField;
    TabNegocioDatIniNeg: TDateField;
    TabNegocioDatFinNeg: TDateField;
    TabNegocioIte: TRESTDWClientSQL;
    SouNegoIte: TDataSource;
    TabNegocioIteIDNego: TIntegerField;
    TabNegocioIteIDProd: TIntegerField;
    TabNegocioItePerDesNeg: TFloatField;
    TabNegocioItePerDesRec: TFloatField;
    TabNegocioIteQtdProNeg: TFloatField;
    TabNegocioIteQtdProRec: TFloatField;
    TabNegocioIteVlrProNeg: TFloatField;
    TabNegocioIteVlrProRec: TFloatField;
    TabProduto: TRESTDWClientSQL;
    SouProd: TDataSource;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    DBDateEdit2: TDBDateEdit;
    LMDLabel2: TLMDLabel;
    btPrior: TAdvGlowButton;
    btNext: TAdvGlowButton;
    TabProdutoIdProd: TFDAutoIncField;
    TabNegocioIteDesproLook: TWideStringField;
    LMDSimplePanel4: TLMDSimplePanel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    DBDateEdit1: TDBDateEdit;
    TabNegocioNompes: TWideStringField;
    TabProdutoDespro: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure TabNegocioAfterInsert(DataSet: TDataSet);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabNegocioAfterPost(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabNegocioBeforeDelete(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure TabNegocioIteAfterInsert(DataSet: TDataSet);
    procedure btPriorClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure TabNegocioIteBeforePost(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
    function ValidaCampos: Boolean;
    function Salvar: Boolean;
    procedure AjustaGrid;
 public
    { Public declarations }
 end;

var
   FrmPesNego: TFrmPesNego;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoasCad;

procedure TFrmPesNego.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesNego.FormShow(Sender: TObject);
begin
   TabNegocioIte.Close;
   TabNegocio.Close;
   TabNegocio.SQL.Text := 'SELECT NEG.*,PES.Nompes FROM arqnegocio NEG LEFT JOIN arqpessoa PES ON NEG.IDPess = PES.IDPess '+
   'WHERE NEG.IDPess = '+basIDPess.ToString+' ORDER BY IDNego DESC';
   TabNegocio.Open;
   if TabNegocio.IsEmpty then TabNegocio.Append;
   TabNegocioIte.Open;
   TabProduto.Open;
   AjustaGrid;
   DBDateEdit1.SetFocus;
end;

procedure TFrmPesNego.AjustaGrid;
begin
   //--> TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   TStringGrid(DBGrid1).DefaultRowHeight := 21;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBDateEdit1.SetFocus;
end;

procedure TFrmPesNego.TabNegocioAfterInsert(DataSet: TDataSet);
begin
   TabNegocioIDPess.Value := basIDPess;
end;

procedure TFrmPesNego.TabNegocioAfterPost(DataSet: TDataSet);
begin
   TabNegocio.Refresh;
   TabNegocio.Last;
end;

procedure TFrmPesNego.TabNegocioBeforeDelete(DataSet: TDataSet);
var
   QueAuxi:TRESTDWClientSQL;
begin
    QueAuxi := TRESTDWClientSQL.Create(nil);
    try
       QueAuxi.DataBase := DM.DWDataBase;
       QueAuxi.SQL.Text := 'DELETE FROM arqneogociote WHERE IDNego = '+TabNegocioIDNego.AsString;
       QueAuxi.ExecSQL;
       TabNegocioIte.Refresh;
    finally
       FreeAndNil(QueAuxi);
    end;
end;

procedure TFrmPesNego.TabNegocioIteAfterInsert(DataSet: TDataSet);
begin
   TabNegocioIteIDNego.Value := TabNegocioIDNego.Value
end;

procedure TFrmPesNego.TabNegocioIteBeforePost(DataSet: TDataSet);
begin
   if not ValidaCampos then Abort;
end;

procedure TFrmPesNego.btNextClick(Sender: TObject);
begin
   if not Salvar then Exit;
   TabNegocio.Next;
   AjustaGrid;
end;

procedure TFrmPesNego.btPriorClick(Sender: TObject);
begin
   if not Salvar then Exit;
   TabNegocio.Prior;
   AjustaGrid;
end;

procedure TFrmPesNego.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

function TFrmPesNego.Salvar:Boolean;
begin
   Result := False;
   if not (TabNegocio.State in dsEditModes) then
   begin
      Result := True;
      Exit;
   end;
   if TabNegocioDatIniNeg.AsDateTime <= 0 then
   begin
      MostraMsg('Aviso','Favor entrar com a data inicial.', mtWarning, [mbOK]);
      DBDateEdit1.SetFocus;
      Exit;
   end; //if
   if TabNegocioDatFinNeg.AsDateTime <= 0 then
   begin
      MostraMsg('Aviso','Favor entrar com a data final.', mtWarning, [mbOK]);
      DBDateEdit2.SetFocus;
      Exit;
   end; //if
   try
      TabNegocio.Post;
      Result := True;
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO,PastaLog,'ERRO: Não foi possível salvar arqnegocio -> '+E.Message);
         MostraMsg('Erro','Não foi possível salvar!'+#10+E.Message, mtError, [mbOK]);
         Exit;
      end;
   end; //try
end;

procedure TFrmPesNego.DBGrid1CellClick(Column: TColumn);
begin
   if TabNegocio.IsEmpty then Exit;
   if Column.ID = 8 then
   begin
      DBGrid1.SelectedField := TabNegocioIteVlrProRec;
      if MostraMsg('Confirmação','Confirma exclusão da negociação deste produto?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabNegocioIte.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqgegocioite -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir!', mtError, [mbOK]);
               Exit;
            end;
         end; //try
      end; //if
   end; //if
end;

procedure TFrmPesNego.DBGrid1Enter(Sender: TObject);
begin
   if not Salvar then Exit;
end;

function TFrmPesNego.ValidaCampos:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if (TabNegocioIteIDProd.AsInteger <= 0) and (TabNegocioItePerDesNeg.AsFloat <= 0.00) and (TabNegocioIteQtdProNeg.AsFloat <= 0.00) and (TabNegocioIteVlrProNeg.AsFloat <= 0.00) then
   begin
      TabNegocioIte.Cancel;
      Exit;
   end;
   if TabNegocioIteIDProd.AsInteger <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um produto',mtWarning, [mbOK]);
      DBGrid1.SelectedField := TabNegocioIteIDProd;
      Exit;
   end; //if

   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Clear;
      if TabNegocioIte.State = dsEdit then
      begin
         if (TabNegocioIteIDProd.OldValue > 0) and (TabNegocioIteIDProd.OldValue <> TabNegocioIteIDProd.AsInteger) then
            QueAuxi.SQL.Text := 'SELECT 1 FROM arqnegocioite WHERE IDProd = '+TabNegocioIteIDProd.OldValue.AsString;
      end
      else QueAuxi.SQL.Text := 'SELECT 1 FROM arqnegocioite WHERE IDProd = '+TabNegocioIteIDProd.AsString;
      if QueAuxi.SQL.Text <> '' then
      begin
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            MostraMsg('Aviso','Produto já incluso nessa negociação!', mtWarning, [mbOK]);
            Exit;
         end;
      end; //if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

   if (TabNegocioItePerDesNeg.AsFloat <= 0.00) and (TabNegocioIteQtdProNeg.AsFloat <= 0.00) and (TabNegocioIteVlrProNeg.AsFloat <= 0.00) then
   begin
      MostraMsg('Aviso','É necessário preencher um percentual, quantidade ou valor válido!',mtWarning, [mbOK]);
      DBGrid1.SelectedField := TabNegocioItePerDesRec;
      Exit;
   end else
   if TabNegocioItePerDesNeg.AsFloat > 100.00 then
   begin
      MostraMsg('Aviso','O percentual não pode ser maior que 100%',mtWarning, [mbOK]);
      DBGrid1.SelectedField := TabNegocioItePerDesRec;
      Exit;
   end; //if
   Result := True;
end;

procedure TFrmPesNego.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      (Sender as TDBGrid).Canvas.Brush.Color := $00ECF2FF;
   end;
   (Sender as TDBGrid).Canvas.FillRect(Rect);
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 8 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2,Rect.Top+2, 0);
end;

procedure TFrmPesNego.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if TabNegocioIte.State in dsEditModes then
   begin
      if not ValidaCampos then
      begin
         CanClose := False;
         Exit;
      end;
      if TabNegocioIte.State in dsEditModes then TabNegocioIte.Post;
   end; //if
end;

procedure TFrmPesNego.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabNegocio.Cancel;
   TabProduto.Close;
   TabNegocioIte.Close;
   TabNegocio.Close;
end;

end.
