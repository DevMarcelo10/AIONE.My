unit uDescPgr;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, MemDS, DBAccess, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Uni,
   LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
   LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Comp.Client,
   MarcLib, FireDAC.Stan.StorageBin, LMDBaseEdit, LMDCustomEdit, LMDMaskEdit,
   LMDCustomMaskEdit, Vcl.ExtCtrls, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, uRESTDWBasicTypes, uRESTDWBasicDB;

type
  TFrmDescPgr = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    btIncluir: TAdvGlowButton;
    LMDLabel2: TLMDLabel;
    edPerDesc: TLMDMaskEdit;
    edVlrlim: TLMDMaskEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    Shape2: TShape;
    btFechar: TAdvGlowButton;
    TabDescPgr: TRESTDWClientSQL;
    SouDescPgr: TDataSource;
    TabDescPgrIDDesc: TIntegerField;
    TabDescPgrVlrlim: TFloatField;
    TabDescPgrPerDesc: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabDescPgrAfterInsert(DataSet: TDataSet);
    procedure edPerDescKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure btFecharClick(Sender: TObject);
    private
      { Private declarations }
      indAdd:Boolean;
    procedure AjustGrid;
    public
      { Public declarations }
      recIDDesc:Integer;
    end;

var
   FrmDescPgr: TFrmDescPgr;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmDescPgr.FormShow(Sender: TObject);
begin
   indAdd := False;
   TabDescPgr.SQL.Text := 'SELECT * FROM arqdescontopgr WHERE IDDesc = '+recIDDesc.ToString+' ORDER BY Vlrlim';
   TabDescPgr.Open;
   AjustGrid;
   edVlrlim.SetFocus;
end;

procedure TFrmDescPgr.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmDescPgr.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   //if Odd(DBGrid1.DataSource.DataSet.RecNo) then
   //     DBGrid1.Canvas.Brush.Color := clWhite
   //else DBGrid1.Canvas.Brush.Color := $00E1EBFF;
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00BFD5FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID < 1 then
   begin
      if Column.FieldName = 'PerDesc' then
           DBGrid1.Canvas.TextRect(Rect,Rect.Left + (Rect.Width - DBGrid1.Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top + 5, Column.Field.DisplayText)
      else DBGrid1.Canvas.TextRect(Rect,Rect.Left + Rect.Width - DBGrid1.Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top + 5, Column.Field.DisplayText)
   end else
   if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left + 5, Rect.Top + 4, 0);
end;

procedure TFrmDescPgr.edPerDescKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then btIncluir.Click;
end;

procedure TFrmDescPgr.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelTop.SetFocus;
   if edVlrlim.AsFloat  <= 0.00 then Erro := 1 else
   if edPerDesc.AsFloat <= 0.00 then Erro := 2;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso', 'Favor preencher o valor limite!', mtWarning, [mbOk]);
         edVlrlim.SetFocus;
      end else
      if Erro = 2 then
      begin
         MostraMsg('Aviso', 'Favor entrar com o percentual de desconto!', mtWarning, [mbOk]);
         edPerDesc.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
         indAdd := True;
         TabDescPgr.Append;
         TabDescPgrIDDesc.Value  := recIDDesc;
         TabDescPgrVlrlim.Value  := edVlrlim.AsFloat;
         TabDescPgrPerDesc.Value := edPerDesc.AsFloat;
         TabDescPgr.Post;
         TabDescPgr.Refresh;
         AjustGrid;
      except
         on E:Exception do
         begin
            if AnsiPos('Duplicate',E.Message) > 0 then
            begin
               MostraMsg('Aviso', 'Valor Limite já associado à este regra!', mtWarning, [mbOk]);
               TabDescPgr.Cancel;
               edPerDesc.SetFocus;
            end else
            begin
               SalvaLog(USUARIO,PastaLog,'ERRO ao tentar salvar Regra de Desconto em Descontos Progressivos -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar',mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      indAdd := False;
      edVlrlim.SetFocus;
   end;
   edVlrlim.AsFloat  := 0.00;
   edPerDesc.AsFloat := 0.00;
   edVlrlim.SetFocus;
end;

procedure TFrmDescPgr.TabDescPgrAfterInsert(DataSet: TDataSet);
begin
   if not indAdd then TabDescPgr.Delete;
end;

procedure TFrmDescPgr.DBGrid1CellClick(Column: TColumn);
begin
   if TabDescPgr.RecordCount > 0 then
   begin
      if Column.ID = 2 then
      begin
         if MostraMsg('Confirmação', 'Confirma eliminação deste desconto?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabDescPgr.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqdescPgr -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
      end; //if
      DBGrid1.SelectedField := TabDescPgrPerDesc;
   end; //if
end;

procedure TFrmDescPgr.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmDescPgr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabDescPgr.State in dsEditModes then TabDescPgr.Post;
   TabDescPgr.Close;
   FrmDescPgr := nil;
end;

end.
