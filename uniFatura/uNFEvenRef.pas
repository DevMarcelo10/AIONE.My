unit uNFEvenRef;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, Vcl.Dialogs,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, LMDEdit,
  Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseLabel,
  LMDCustomLabel, LMDControl, LMDCustomControl, LMDCustomPanel,
  LMDSimplePanel, AdvGlowButton, LMDCustomBevelPanel, Vcl.ExtCtrls,
  LMDBaseGraphicControl, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, MarcLib,
  LMDBaseEdit, LMDCustomEdit;

type
  TFrmNFEvenRef = class(TForm)
    PanelTop: TLMDSimplePanel;
    OBSER: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    TabNFEvenRef: TRESTDWClientSQL;
    SouNFEvenRef: TDataSource;
    LMDSimplePanel3: TLMDSimplePanel;
    edNFRef: TLMDLabeledEdit;
    btLimpaIte: TAdvGlowButton;
    btIncluir: TAdvGlowButton;
    TabNFEvenRefIDFilial: TIntegerField;
    TabNFEvenRefIDPed: TIntegerField;
    TabNFEvenRefChaveNF: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btLimpaIteClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure edNFRefKeyPress(Sender: TObject; var Key: Char);
    procedure edNFRefExit(Sender: TObject);
 private
    procedure AjustGrid;
    { Private declarations }
 public
    { Public declarations }
    recIDPed:Integer;
 end;

var
   FrmNFEvenRef: TFrmNFEvenRef;

implementation

{$R *.dfm}

uses uDM, uConst, uNFEven, uLibFarm;

procedure TFrmNFEvenRef.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmNFEvenRef.FormShow(Sender: TObject);
begin
   TabNFEvenRef.ParamByName('IDFilial').AsInteger := FILIAL;
   TabNFEvenRef.ParamByName('IDPed').AsInteger    := recIDPed;
   TabNFEvenRef.Open;
   AjustGrid;
end;

procedure TFrmNFEvenRef.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   if OnlyNumbers(edNFRef.Text) = '' then Exit;
   Erro := 0;
   DBGrid1.SetFocus;
   if OnlyNumbers(edNFRef.Text).Length <> 44 then
   begin
      MostraMsg('Aviso','Número de chave de NF inválido!', mtWarning, [mbOk]);
      edNFRef.SetFocus;
      Exit;
   end;
   try
     QueAuxi := TRESTDWClientSQL.Create(nil);
     QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text := 'SELECT 1 FROM arqnfevenref WHERE IDFilial = '+FILIAL.ToString+' AND IDPed = '+recIDPed.ToString+' AND ChaveNF = '+Aspas(OnlyNumbers(edNFRef.Text));
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            MostraMsg('Aviso','NF Referenciada já associada à essa NF.', mtWarning, [mbOk]);
            edNFRef.SetFocus;
            Exit;
         end; //if
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
      TabNFEvenRef.Append;
      TabNFEvenRefIDFilial.Value := FILIAL;
      TabNFEvenRefIDPed.Value    := recIDPed;
      TabNFEvenRefChaveNF.Value  := OnlyNumbers(edNFRef.Text);
      TabNFEvenRef.Post;
      AjustGrid;
   except
      on E: Exception do
      begin
         SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar em arqnfevenref (uNFEvenRef), IDPed: '+recIDPed.ToString+' -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível salvar NF Referenciada"', mtError, [mbOk]);
         Exit;
      end; //on
   end;
   btLimpaIte.Click;
end;

procedure TFrmNFEvenRef.btLimpaIteClick(Sender: TObject);
begin
   edNFRef.Text := '';
   edNFRef.SetFocus;
end;

procedure TFrmNFEvenRef.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação dessa referenciada?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabNFEvenRef.Delete;
            AjustGrid;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqmetasub -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabNFEvenRefChaveNF;
   end; //if

end;

procedure TFrmNFEvenRef.edNFRefExit(Sender: TObject);
begin
   btIncluir.Click;
end;

procedure TFrmNFEvenRef.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmNFEvenRef.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
   end;
end;

procedure TFrmNFEvenRef.edNFRefKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key = #8) and not (Key in ['0'..'9']) then Key := #0;
end;

procedure TFrmNFEvenRef.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmNFEvenRef.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabNFEvenRef.Close;
   Action := caFree;
end;

end.
