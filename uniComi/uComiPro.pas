unit uComiPro;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, MemDS,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit, LMDMaskEdit, LMDCustomMaskEdit,  Vcl.StdCtrls,
   uRESTDWBasicDB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmComiPro = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    TabProd: TRESTDWClientSQL;
    SouProd: TDataSource;
    btIncluir: TAdvGlowButton;
    edCodpro: TLMDEdit;
    edNompro: TLMDLabeledEdit;
    TabProdIDComi: TIntegerField;
    TabProdIDProd: TIntegerField;
    TabProdDespro: TWideStringField;
    TabProdNompes: TWideStringField;
    TabProdEstoque: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure edCodproKeyPress(Sender: TObject; var Key: Char);
    procedure edCodproExit(Sender: TObject);
    procedure edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomproCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDComi:Integer;
 end;

var
   FrmComiPro: TFrmComiPro;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uComiCad;

procedure TFrmComiPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmComiPro.FormShow(Sender: TObject);
begin
   TabProd.ParamByName('IDComi').AsInteger := recIDComi;
   TabProd.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edCodpro.SetFocus;
end;

procedure TFrmComiPro.edCodproExit(Sender: TObject);
var
   auxProd:String;
   QueAuxi:TRESTDWClientSQL;
begin
   edNompro.Clear;
   edNompro.Tag := 0;
   auxProd := Trim(edCodpro.Text);
   if auxProd = '' then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         SQL.Text := 'SELECT IDProd,Despro FROM arqproduto WHERE '+iif(Length(auxProd) < 9, 'IDProd'+' = '+auxProd,'CodEANPri'+' = '+Aspas(auxProd));
         Open;
         if IsEmpty then
         begin
            MostraMsg('Aviso','Produto não encontrado!', mtWarning, [mbOK]);
            edCodpro.SetFocus;
            Exit;
         end else
         begin
            edNompro.Tag  := FieldByName('IDProd').AsInteger;
            edNompro.Text := FieldByName('Despro').AsString;
         end;
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmComiPro.edCodproKeyPress(Sender: TObject; var Key: Char);
begin
   if ExisteStr(Key) then Key := #0;
end;

procedure TFrmComiPro.edNomproCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','', 0, True);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      btIncluir.Click;
   end
   else edCodpro.Text := '';
end;

procedure TFrmComiPro.edNomproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqproduto',TLMDEdit(edNompro),'IDProd','Despro','', Key);
   if edNompro.Tag > 0 then
   begin
      edCodpro.Text := edNompro.Tag.ToString;
      btIncluir.Click;
   end
   else edCodpro.Text := '';
end;

procedure TFrmComiPro.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edNompro.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um produto!', mtWarning, [mbOk]);
         edNompro.SetFocus;
      end; //if
      Exit;
   end; //if

   if FrmComiCad.VerDuplica(recIDComi, edNompro.Tag, 'PRO') then Exit;

   try
      try
        if not TabProd.Locate('IDProd',edNompro.Tag,[]) then
        begin
           TabProd.Append;
           TabProdIDComi.Value := recIDComi;
           TabProdIDProd.Value := edNompro.Tag;
           TabProdDespro.Value := edNompro.Text;
           TabProd.Post;
        end
        else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Produto já associado à esta Regra!', mtWarning, [mbOk]);
               TabProd.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Produto à Regra de Comissões -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edCodpro.SetFocus;
   end;
   edCodpro.Text := '';
   edNompro.Text := '';
   edNompro.Tag  := 0;
end;

procedure TFrmComiPro.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 4 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Produto?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabProd.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqcomipro -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabProdDespro;
   end; //if
end;

procedure TFrmComiPro.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 4 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
end;

procedure TFrmComiPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabProd.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
