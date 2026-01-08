unit uDescConv;

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
  TFrmDescCon = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNomcon: TLMDLabeledEdit;
    TabConv: TRESTDWClientSQL;
    SouConv: TDataSource;
    btIncluir: TAdvGlowButton;
    TabConvIDDesc: TIntegerField;
    TabConvIDConv: TIntegerField;
    TabConvNomcon: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomconKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure edNomconCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDDesc:Integer;
 end;

var
   FrmDescCon: TFrmDescCon;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmDescCon.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmDescCon.FormShow(Sender: TObject);
begin
   TabConv.ParamByName('IDDesc').AsInteger := recIDDesc;
   TabConv.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edNomcon.SetFocus;
end;

procedure TFrmDescCon.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID <= 0 then
      DBGrid1.Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText) else
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0);
end;

procedure TFrmDescCon.edNomconCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqconvenio',TLMDEdit(edNomcon),'IDConv','Nomcon','', 0,True);
   if edNomcon.Tag > 0 then btIncluir.Click;
end;

procedure TFrmDescCon.edNomconKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqconvenio',TLMDEdit(edNomcon),'IDConv','Nomcon','', Key);
   if edNomcon.Tag > 0 then btIncluir.Click;
end;

procedure TFrmDescCon.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edNomcon.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um Convênio!', mtWarning, [mbOk]);
         edNomcon.SetFocus;
      end; //if
      Exit;
   end; //if
   try
      try
        if not TabConv.Locate('IDConv',edNomcon.Tag,[]) then
        begin
           TabConv.Append;
           TabConvIDDesc.Value := recIDDesc;
           TabConvIDConv.Value := edNomcon.Tag;
           TabConvNomcon.Value := edNomcon.Text;
           TabConv.Post;
        end
        else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Convênio já associado à esta Regra!', mtWarning, [mbOk]);
               TabConv.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Convênio à Regra de Desconto -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edNomcon.SetFocus;
   end;
   edNomcon.Text := '';
   edNomcon.Tag  := 0;
end;

procedure TFrmDescCon.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Convênio?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabConv.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqdesccon -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabConvNomcon;
   end; //if
end;

procedure TFrmDescCon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabConv.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
