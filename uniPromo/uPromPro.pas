unit uPromPro;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Grids,
   Vcl.DBGrids, LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, Data.DB, System.StrUtils,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit,
   LMDButtonControl, LMDRadioButton, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
   TFrmPromPro = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    btNovoItem: TAdvGlowButton;
    TabPromPro: TRESTDWClientSQL;
    SouPromPro: TDataSource;
    TabPromProIDProm: TIntegerField;
    TabPromProIDProd: TIntegerField;
    TabPromProQtdest: TFloatField;
    TabPromProPrecoVen: TFloatField;
    TabPromProCusmed: TFloatField;
    TabPromProUltPreCom: TFloatField;
    TabPromProPrePromo: TFloatField;
    TabPromProPerDesMan: TFloatField;
    TabPromProPerDesIA: TFloatField;
    TabPromProCalcNrolot: TWideStringField;
    TabPromProCalcDescIA: TWideStringField;
    TabPromProCalcDescM: TWideStringField;
    TabPromProCalcMarkup: TWideStringField;
    TabPromProNrolot: TWideStringField;
    TabPromProDespro: TWideStringField;
    TabPromProIndSel: TWideStringField;
    LMDSimplePanel1: TLMDSimplePanel;
    btExcluir: TAdvGlowButton;
    edPerDesc: TCurrencyEdit;
    Label4: TLabel;
    btDescExe: TAdvGlowButton;
    LMDSimplePanel11: TLMDSimplePanel;
    Label37: TLabel;
    Label39: TLabel;
    RadioPerc: TLMDRadioButton;
    RadioValor: TLMDRadioButton;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabConvDescoAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabPromProCalcFields(DataSet: TDataSet);
    procedure btNovoItemClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btExcluirClick(Sender: TObject);
    procedure btDescExeClick(Sender: TObject);
    procedure edPerDescExit(Sender: TObject);
  private
    procedure EditItem(recIDProd:Integer; recDescIA,recDescMA:Double);
    procedure AjustaGrid;
    { Private declarations }
  public
    { Public declarations }
    recIDProm:Integer;
  end;

var
   FrmPromPro: TFrmPromPro;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPromProCad, uPrincipal, uShadowForm;

procedure TFrmPromPro.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromPro.FormShow(Sender: TObject);
begin
   TabPromPro.SQL.Text := 'SELECT PRM.*,PRO.Despro FROM arqpromopro PRM LEFT JOIN arqproduto ';
   TabPromPro.SQL.Add('PRO ON PRM.IDProd = PRO.IDProd WHERE PRM.IDProm = '+recIDProm.ToString);
   TabPromPro.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmPromPro.TabConvDescoAfterInsert(DataSet: TDataSet);
begin
   TabPromPro.Delete;
end;

procedure TFrmPromPro.btNovoItemClick(Sender: TObject);
begin
   EditItem(0, 0.00, 0.00);
end;

procedure TFrmPromPro.EditItem(recIDProd:Integer; recDescIA,recDescMA:DOuble);
begin
   try
      if FrmPromoCadPro = nil then FrmPromoCadPro := TFrmPromoCadPro.Create(Application);
      FrmPromoCadPro.recIDProm := recIDProm;
      FrmPromoCadPro.recIDProd := recIDProd;
      FrmPromoCadPro.recDescIA := recDescIA;
      FrmPromoCadPro.recDescMA := recDescMA;
      TShadowHelper.ShowModalWithShadow(FrmPrincipal, FrmPromoCadPro, FrmPrincipal.PanelBas);
   finally
      FrmPromoCadPro := nil;
      TabPromPro.Refresh;
      TabPromPro.First;
      AjustaGrid;
   end;
end;

procedure TFrmPromPro.edPerDescExit(Sender: TObject);
begin
   if RadioPerc.Checked then
   begin
      if (edPerDesc.Value < 0.00) or (edPerDesc.Value >= 100.00) then
      begin
         MostraMsg('Aviso', 'Percentual inválido!', mtWarning, [mbOK]);
         edPerDesc.Value := 0.00;
         edPerDesc.SetFocus;
      end;
   end; //if
end;

procedure TFrmPromPro.AjustaGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmPromPro.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if TabPromPro.IsEmpty then Exit;
   if Column.ID = 11 then EditItem(TabPromProIDProd.Value, TabPromProPerDesIA.Value, TabPromProPerDesMan.Value) else
   if Column.ID = 12 then
   begin
      if MostraMsg('Confirmação', 'Confirma exclusão deste item promocional?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         QueAuxi := TRESTDWClientSQL.Create(nil);
         QueAuxi.DataBase := DM.DWDataBase;
         try
            try
               QueAuxi.SQL.Text := 'DELETE FROM arqpromopro WHERE IDProm = '+TabPromProIDProm.AsString+' AND IDProd = '+TabPromProIDProd.AsString+' AND Nrolot = '+Aspas(TabPromProNrolot.AsString);
               QueAuxi.ExecSQL;
               TabPromPro.Close;
               TabPromPro.Open;
               AjustaGrid;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir arqpromopro -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!'+#10+E.Message, mtError, [mbOK]);
                  Exit;
               end;
            end; //try
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
   end; //if
   if Column.ID >= 11 then DBGrid1.SelectedField := TabPromProPrePromo;
   if Column.FieldName = 'IndSel' then
   begin
      if not (TabPromPro.State in dsEditModes) then TabPromPro.Edit;
      TabPromProIndSel.AsString := iif(TabPromProIndSel.AsString = '0','1','0');
      TabPromPro.Post;
      DBGrid1.SelectedField := TabPromProPrePromo;
   end; //if
end;

procedure TFrmPromPro.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00CCDDFF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;

   if Column.FieldName = 'CalcDescIA' then
   begin
      if TabPromProPerDesMan.Value > 0.00 then
           DBGrid1.Canvas.Font.Color := $009B9B9B
      else DBGrid1.Canvas.Font.Color := clBlack;
   end; //if

   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 11 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+4,4) else
   if Column.ID = 12 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4,0) else
   if MatchStr(Column.FieldName, ['IDProd','CalcDescM','CalcDescIA','CalcPerLuc']) then
      DBGrid1.Canvas.TextRect(Rect,Rect.Left + (Rect.Width - DBGrid1.Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText)
   else
   if MatchStr(Column.FieldName, ['PrecoEsp','PrecoVen','UltPreCom','PrePromo','Qtdest','Cusmed']) then
        DBGrid1.Canvas.TextRect(Rect, Rect.Left + Rect.Width - DBGrid1.Canvas.TextWidth(Column.Field.DisplayText)-3, Rect.Top+5, Column.Field.DisplayText)
   else DBGrid1.Canvas.TextRect(Rect, Rect.Left + 3, Rect.Top+5, Column.Field.DisplayText);
   if Column.FieldName = 'IndSel' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabPromProIndSel.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmPromPro.DBGrid1TitleClick(Column: TColumn);
begin
   TabPromPro.IndexFieldNames := Column.FieldName;
end;

procedure TFrmPromPro.TabPromProCalcFields(DataSet: TDataSet);
begin
   TabPromProCalcNrolot.Value := iif(TabPromProNrolot.AsString.Trim = '',' TODOS',TabPromProNrolot.AsString);
   TabPromProCalcDescIA.Value := MascNro(TabPromProPerDesIA.Value, 7,2)+' %';
   TabPromProCalcDescM.Value  := MascNro(TabPromProPerDesMan.Value,7,2)+' %';
   if TabPromProCusmed.Value > 0.00 then
      TabPromProCalcMarkup.Value := MascNro(((TabPromProPrePromo.Value - TabPromProCusmed.Value) / TabPromProCusmed.Value) * 100,7,2)+' %';
end;

procedure TFrmPromPro.btDescExeClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   auxCalc,auxPerDesMan:String;
begin
   if MostraMsg('Confirmação','Confirma '+iif(RadioPerc.Checked,'aplicação do % de desconto','unificação de valores')+' na seleção?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      if RadioPerc.Checked then
      begin
         auxCalc := 'ROUND(PrecoVen - (PrecoVen * ('+FormatDouble(edPerDesc.Value,8,2)+'/100)),2)';
         auxPerDesMan := FormatDouble(edPerDesc.Value,8,2);
      end else
      begin
         auxCalc := FormatDouble(edPerDesc.Value,8,2);
         auxPerDesMan := '((1 - PrePromo / PrecoVen) * 100)';
      end; //if
      QueAuxi.SQL.Clear;
      if TabPromPro.State in dsEditModes then TabPromPro.Post;
      TabPromPro.DisableControls;
      TabPromPro.First;
      while not TabPromPro.Eof do
      begin
         if TabPromProIndSel.AsString = '1' then
         begin
          QueAuxi.SQL.Add(
          'UPDATE arqpromopro SET PrePromo = '+auxCalc+', PerDesMan = '+auxPerDesMan+', IndSel = "0" '+
          'WHERE IDProm = '+TabPromProIDProm.AsString+' AND IDProd = '+TabPromProIDProd.AsString+
          iif(TabPromProNrolot.AsString.Trim <> '',' AND Nrolot = '+Aspas(TabPromProNrolot.AsString),'')+
          iif(RadioValor.Checked,' AND '+auxPerDesMan+' < PrecoVen','')+';');
         end;
         TabPromPro.Next;
      end; //while
      if QueAuxi.SQL.Text <> '' then QueAuxi.ExecSQL;
   finally
      FreeAndNil(QueAuxi);
      TabPromPro.Close;
      TabPromPro.Open;
      TabPromPro.EnableControls;
      AjustaGrid;
   end;
end;

procedure TFrmPromPro.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MostraMsg('Confirmação','Confirma retirada da promoção destes produtos?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
   try
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         QueAuxi.SQL.Text := 'DELETE FROM arqpromopro WHERE IDProm = '+TabPromProIDProm.AsString+' AND IDProd = '+
         TabPromProIDProd.AsString+' AND Nrolot = '+Aspas(TabPromProNrolot.AsString)+' AND IndSel = '+Aspas('1');
         QueAuxi.ExecSQL;
         TabPromPro.Close;
         TabPromPro.Open;
         AjustaGrid;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível excluir todos itens selecionados: arqpromopro -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível excluir!'+#10+E.Message, mtError, [mbOK]);
            Exit;
         end;
      end; //try
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmPromPro.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabPromPro.State in dsEditModes then TabPromPro.Post;
   TabPromPro.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
