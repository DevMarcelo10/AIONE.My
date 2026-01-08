unit uComiFab;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit, LMDCustomEdit,
   LMDEdit,  Vcl.StdCtrls, uRESTDWBasicDB, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uRESTDWBasicTypes;

type
  TFrmComiFab = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNompes: TLMDLabeledEdit;
    TabFabr: TRESTDWClientSQL;
    SouFabr: TDataSource;
    btIncluir: TAdvGlowButton;
    TabFabrIDComi: TIntegerField;
    TabFabrIDPess: TIntegerField;
    TabFabrNompes: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure edNompesCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
    recIDComi:Integer;
 end;

var
   FrmComiFab: TFrmComiFab;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uComiCad;

procedure TFrmComiFab.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmComiFab.FormShow(Sender: TObject);
begin
   TabFabr.ParamByName('IDComi').AsInteger := recIDComi;
   TabFabr.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edNompes.SetFocus;
end;

procedure TFrmComiFab.edNompesCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 2 OR IDEsppes = 3', 0, True);
   if edNompes.Tag > 0 then btIncluir.Click;
end;

procedure TFrmComiFab.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes = 2 OR IDEsppes = 3', Key);
   if edNompes.Tag > 0 then btIncluir.Click;
end;

procedure TFrmComiFab.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   DBGrid1.SetFocus;
   if edNompes.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um fabricante!', mtWarning, [mbOk]);
         edNompes.SetFocus;
      end; //if
      Exit;
   end; //if

   if FrmComiCad.VerDuplica(recIDComi, edNompes.Tag, 'FAB') then Exit;

   try
      try
        if not TabFabr.Locate('IDPess',edNompes.Tag,[]) then
        begin
           TabFabr.Append;
           TabFabrIDComi.Value  := recIDComi;
           TabFabrIDPess.Value  := edNompes.Tag;
           TabFabrNompes.Value  := edNompes.Text;
           TabFabr.Post;
        end
        else raise Exception.Create('Duplicate ID');
      except
         on E: Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Fabricante já associado à esta Regra!', mtWarning, [mbOk]);
               TabFabr.Cancel;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Fabricante à Regra de Comissões -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
            Exit;
         end; //on
      end;
   finally
      edNompes.SetFocus;
   end;
   edNompes.Text := '';
   edNompes.Tag  := 0;
end;

procedure TFrmComiFab.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação', 'Confirma eliminação do Fabricante?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            TabFabr.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO: Não foi possível excluir arqcomifab -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      DBGrid1.SelectedField := TabFabrNompes;
   end; //if
end;

procedure TFrmComiFab.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmComiFab.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabFabr.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
