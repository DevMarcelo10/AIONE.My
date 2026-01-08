unit uDescPro;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls,
   Vcl.Grids, Vcl.DBGrids, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
   LMDCustomLabel, LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDEdit,
   LMDSimplePanel, LMDCustomBevelPanel, AdvGlowButton, LMDBaseEdit, LMDCustomEdit,
   MarcLib, LMDCustomMaskEdit, LMDMaskEdit, Vcl.StdCtrls, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uRESTDWBasicTypes, uRESTDWBasicDB;

type
   TFrmDescPro = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel3: TLMDSimplePanel;
    edCodpro: TLMDEdit;
    edNompro: TLMDLabeledEdit;
    LMDLabel6: TLMDLabel;
    btIncluir: TAdvGlowButton;
    LMDLabel1: TLMDLabel;
    edPerDesc: TLMDMaskEdit;
    LMDLabel2: TLMDLabel;
    edPreEsp: TLMDMaskEdit;
    LMDLabel3: TLMDLabel;
    edPreco: TLMDMaskEdit;
    TabDescPro: TRESTDWClientSQL;
    SouDescPro: TDataSource;
    TabDescProIDDesc: TIntegerField;
    TabDescProIDProd: TIntegerField;
    TabDescProPerDesc: TFloatField;
    TabDescProPrecoEsp: TFloatField;
    TabDescProDespro: TWideStringField;
    TabDescProNompes: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure edCodproExit(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure edPerDescExit(Sender: TObject);
    procedure edPreEspExit(Sender: TObject);
    procedure TabConvDescoAfterInsert(DataSet: TDataSet);
    procedure edCodproKeyPress(Sender: TObject; var Key: Char);
    procedure edPerDescKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    auxFiltro:String;
    procedure AjustaGrid;
  public
    { Public declarations }
    recIDDesc,recIDGrupo,recIDGruSub,recIDFabr:Integer;
  end;

var
   FrmDescPro: TFrmDescPro;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmDescPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmDescPro.FormShow(Sender: TObject);
begin
   TabDescPro.ParamByName('IDDesc').AsInteger := recIDDesc;
   TabDescPro.Open;
   AjustaGrid;
   edCodpro.SetFocus;
end;

procedure TFrmDescPro.TabConvDescoAfterInsert(DataSet: TDataSet);
begin
   TabDescPro.Delete;
end;

procedure TFrmDescPro.edCodproExit(Sender: TObject);
var
   auxProd:String;
   QueAuxi:TRESTDWClientSQL;
begin
   edNompro.Clear;
   edNompro.Tag      := 0;
   _PrecoVen         := 0.00;
   edPreco.AsFloat   := 0.00;
   edPerDesc.AsFloat := 0.00;
   edPreEsp.AsFloat  := 0.00;
   auxProd := AllTrim(edCodpro.Text);
   if auxProd = '' then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT IDProd,Despro,PrecoVen FROM arqproduto WHERE '+iif(Length(auxProd) < 13, 'IDProd'+' = '+auxProd,'CodEANPri'+' = '+Aspas(auxProd));
         Open;
         if IsEmpty then
         begin
            MostraMsg('Aviso','Produto não encontrado!', mtWarning, [mbOK]);
            edCodpro.SetFocus;
            Exit;
         end else
         begin
            edNompro.Tag     := FieldByName('IDProd').AsInteger;
            edNompro.Text    := FieldByName('Despro').AsString;
            edPreEsp.AsFloat := FieldByName('PrecoVen').AsFloat;
            edPreco.AsFloat  := FieldByName('PrecoVen').AsFloat;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmDescPro.edCodproKeyPress(Sender: TObject; var Key: Char);
begin
   if ExisteStr(Key) then Key := #0;
end;

procedure TFrmDescPro.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro',auxFiltro,0,True);
   edPreco.AsFloat   := 0.00;
   edPerDesc.AsFloat := 0.00;
   edPreEsp.AsFloat  := 0.00;
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      edPreEsp.AsFloat := _PrecoVen;
      edPreco.AsFloat  := _PrecoVen;
      edPerDesc.SetFocus;
   end
   else edCodpro.Text := '';
end;

procedure TFrmDescPro.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro',auxFiltro,Key);
   edPreco.AsFloat   := 0.00;
   edPerDesc.AsFloat := 0.00;
   edPreEsp.AsFloat  := 0.00;
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      edPreEsp.AsFloat := _PrecoVen;
      edPreco.AsFloat  := _PrecoVen;
      edPerDesc.SetFocus;
   end
   else edCodpro.Text := '';
end;

procedure TFrmDescPro.edPerDescExit(Sender: TObject);
begin
   if (edPerDesc.AsFloat < 0) then
   begin
     MostraMsg('Aviso','Valor do desconto não pode negativo!',mtWarning, [mbOK]);
     edPerDesc.SelectAll;
     edPerDesc.SetFocus;
     exit;
   end;

   if (edPerDesc.AsFloat >= 0) and (edPreco.AsFloat > 0.00) then
   begin
      if edPerDesc.AsFloat > 100.00 then
      begin
         MostraMsg('Aviso', 'Percentual do desconto não pode ser maior 100%', mtWarning, [mbOK]);
         edPerDesc.SetFocus;
      end
      else edPreEsp.AsFloat := Roundx(edPreco.AsFloat - (edPreco.AsFloat * (edPerDesc.AsFloat/100)), 2);
   end; //if
end;

procedure TFrmDescPro.edPreEspExit(Sender: TObject);
begin
   if edPreEsp.AsFloat > edPreco.AsFloat then
   begin
      MostraMsg('Aviso','Valor do desconto não pode ser maior que o valor do produto!',mtWarning, [mbOK]);
      edPreEsp.SetFocus;
   end else
   begin
      if edPreEsp.AsFloat > 0 then
      begin
         edPerDesc.AsFloat := Roundx(((edPreco.AsFloat - edPreEsp.AsFloat) / edPreco.AsFloat) * 100, 2);
      end else
      begin
         edPerDesc.AsFloat := 0.00;
      end;
   end; // if
end;

procedure TFrmDescPro.edPerDescKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then btIncluir.Click;
end;

procedure TFrmDescPro.btIncluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if edNompro.Tag <= 0 then
   begin
      MostraMsg('Produto não informado', 'Favor escolher um produto!',mtWarning, [mbOK]);
      edCodpro.SetFocus;
      Exit;
   end;
   if (edPerDesc.AsFloat <= 0.00) or (edPerDesc.AsFloat > 100.00) then
   begin
      MostraMsg('Erro', 'Percentual de desconto inválido!', mtError, [mbOK]);
      edPerDesc.SetFocus;
      Exit;
   end;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'INSERT INTO arqdescpro (IDDesc,IDProd,PerDesc,PrecoEsp) VALUES ('+
         recIDDesc.ToString+','+edNompro.Tag.ToString+','+
         FormatDouble(edPerDesc.AsFloat,8,2)+','+FormatDouble(edPreEsp.AsFloat,10,2)+') '+
         'ON DUPLICATE KEY UPDATE PerDesc = VALUES(PerDesc), PrecoEsp = VALUES(PrecoEsp)';
         QueAuxi.ExecSQL;
         TabDescPro.Close;
         TabDescPro.Open;
         AjustaGrid;
         TabDescPro.Locate('IDProd',edNompro.Tag,[]);
         edCodpro.Clear;
         edNompro.Clear;
         edNompro.Tag      := 0;
         edPreco.AsFloat   := 0.00;
         edPerDesc.AsFloat := 0.00;
         edPreEsp.AsFloat  := 0.00;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível salvar registro no arqdescpro -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível salvar!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end;
   finally
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmDescPro.AjustaGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmDescPro.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabDescPro.IsEmpty then Exit;
   if Column.ID = 5 then
   begin
      if MostraMsg('Confirmação', 'Confirma exclusão deste desconto?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            try
               QueAuxi.SQL.Text := 'DELETE FROM arqdescpro WHERE IDDesc = '+TabDescProIDDesc.AsString+' AND IDProd = '+TabDescProIDProd.AsString;
               QueAuxi.ExecSQL;
               TabDescPro.Close;
               TabDescPro.Open;
               AjustaGrid;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqdescpro -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!'+#10+E.Message, mtError, [mbOK]);
                  Exit;
               end;
            end; //try
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
      DBGrid1.SelectedField := TabDescProPerDesc;
   end; //if
end;

procedure TFrmDescPro.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   //if Odd(DBGrid1.DataSource.DataSet.RecNo) then
   //     DBGrid1.Canvas.Brush.Color := clWhite
   //else DBGrid1.Canvas.Brush.Color := $00E1EBFF;
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00CCDDFF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 5 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+ 6,0);
   if Column.FieldName <> '' then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+2, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+2, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmDescPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabDescPro.State in dsEditModes then TabDescPro.Post;
   TabDescPro.Close;
   Action := caFree;
end;

end.
