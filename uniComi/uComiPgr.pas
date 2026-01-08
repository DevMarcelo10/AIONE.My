unit uComiPgr;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDControl,
   LMDLabel, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit,LMDCustomEdit,
   LMDMaskEdit, LMDCustomMaskEdit, Vcl.ExtCtrls, LMDEdit, Vcl.StdCtrls,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB,
   LMDRadioButton, LMDButtonControl;

type
 TFrmComiPgr = class(TForm)
    PanelEdits: TLMDSimplePanel;
   LMDLabel1: TLMDLabel;
   btIncluir: TAdvGlowButton;
   LMDLabel2: TLMDLabel;
    edLimi: TLMDMaskEdit;
    edFixo: TLMDMaskEdit;
   LMDSimplePanel2: TLMDSimplePanel;
   LMDSimplePanel1: TLMDSimplePanel;
   DBGrid1: TDBGrid;
   TabComiPgr: TRESTDWClientSQL;
   SouComiPgr: TDataSource;
    TabComiPgrIDComi: TIntegerField;
    TabComiPgrVlrlim: TFloatField;
    TabComiPgrVlrfix: TFloatField;
    btFechar: TAdvGlowButton;
   procedure FormCreate(Sender: TObject);
   procedure FormShow(Sender: TObject);
   procedure btIncluirClick(Sender: TObject);
   procedure DBGrid1CellClick(Column: TColumn);
   procedure TabComiPgrAfterInsert(DataSet: TDataSet);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure TabComiPgrAfterOpen(DataSet: TDataSet);
   procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure btFecharClick(Sender: TObject);
    procedure edFixoExit(Sender: TObject);
   private
   { Private declarations }
     indAdd:Boolean;
    procedure AjustGrid;
   public
   { Public declarations }
     recIDComi:Integer;
     recValCom,recDesQtd:String;
   end;

var
   FrmComiPgr: TFrmComiPgr;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmComiPgr.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmComiPgr.FormShow(Sender: TObject);
begin
   indAdd := False;
   if recDesQtd = 'Q' then
   begin
      LMDLabel1.Caption := 'ATÉ A QUANTIDADE';
      DBGrid1.Columns[0].Title.Caption := 'ATÉ QTD.';
   end else
   begin
      LMDLabel1.Caption := 'ATÉ % DESCONTO';
      DBGrid1.Columns[0].Title.Caption := 'ATÉ % DESC.';
   end;

   if recValCom = 'V' then
   begin
      LMDLabel2.Caption := 'VALOR R$';
      DBGrid1.Columns[1].Title.Caption := 'VALOR R$';
   end else
   begin
      LMDLabel2.Caption := '% COMIS.';
      DBGrid1.Columns[1].Title.Caption := '% COM.';
   end;
   TabComiPgr.ParamByName('IDComi').AsInteger := recIDComi;
   TabComiPgr.Open;
   AjustGrid;
   edLimi.SetFocus;
end;

procedure TFrmComiPgr.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;
procedure TFrmComiPgr.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edLimi.AsFloat <= 0.00 then
   begin
      MostraMsg('Aviso', 'Favor entrar com '+iif(recValCom = 'Q','a quantidade','o % desconto'), mtWarning, [mbOk]);
      edFixo.SetFocus;
      Exit;
   end;
   if edFixo.AsFloat <= 0.00 then
   begin
      MostraMsg('Aviso', 'Favor entrar com '+iif(recDesQtd = 'V','o valor','o % comissão'), mtWarning, [mbOk]);
      edFixo.SetFocus;
      Exit;
   end;

   try
      try
         indAdd := True;
         TabComiPgr.Append;
         TabComiPgrIDComi.Value := recIDComi;
         TabComiPgrVlrlim.Value := edLimi.AsFloat;
         TabComiPgrVlrfix.Value := edFixo.AsFloat;
         TabComiPgr.Post;
         TabComiPgr.Refresh;
         AjustGrid;
      except
         on E:Exception do
         begin
            begin
               SalvaLog(USUARIO,PastaLog,'ERRO ao tentar salvar arqcomipgr (comissões progressivas) -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar',mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      indAdd := False;
   end;
   edLimi.AsFloat := 0.00;
   edFixo.AsFloat := 0.00;
   edLimi.SetFocus;
end;

procedure TFrmComiPgr.TabComiPgrAfterInsert(DataSet: TDataSet);
begin
   if not indAdd then TabComiPgr.Delete;
end;

procedure TFrmComiPgr.TabComiPgrAfterOpen(DataSet: TDataSet);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmComiPgr.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00BFD5FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID <= 1 then
      DBGrid1.Canvas.TextRect(Rect,Rect.Left + Rect.Width - DBGrid1.Canvas.TextWidth(Column.Field.DisplayText)-3, Rect.Top+5, Column.Field.DisplayText)
   else if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+4, 0);
end;

procedure TFrmComiPgr.edFixoExit(Sender: TObject);
begin
   if (edLimi.AsFloat > 0.00) and (edFixo.AsFloat > 0.00) then btIncluir.Click;
end;

procedure TFrmComiPgr.DBGrid1CellClick(Column: TColumn);
begin
   if TabComiPgr.RecordCount > 0 then
   begin
      if Column.ID = 2 then
      begin
         if MostraMsg('Confirmação', 'Confirma eliminação deste item?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               TabComiPgr.Delete;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqcomipgr -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
                  Exit;
               end;
            end; //try
         end; //if
         DBGrid1.SelectedField := TabComiPgrVlrfix;
      end; //if
   end; //if
end;

procedure TFrmComiPgr.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmComiPgr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabComiPgr.Close;
end;

end.
