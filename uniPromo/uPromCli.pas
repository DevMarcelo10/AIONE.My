unit uPromCli;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   uRESTDWBasicDB, LMDCustomBevelPanel, AdvGlowButton, MarcLib, LMDBaseEdit,
   LMDCustomEdit, LMDEdit, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.DatS,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, MemDS,
   VirtualTable, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TFrmPromCli = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelGrid: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edNompes: TLMDLabeledEdit;
    btIncluir: TAdvGlowButton;
    DBGrid1: TDBGrid;
    TabPromCli: TRESTDWClientSQL;
    SouPromCli: TDataSource;
    TabPromCliIDProm: TIntegerField;
    TabPromCliIDPess: TIntegerField;
    TabPromCliNompes: TWideStringField;
    MemPromCli: TVirtualTable;
    SouMPromCli: TDataSource;
    MemPromCliIDPess: TIntegerField;
    MemPromCliNompes: TWideStringField;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure FormCreate(Sender: TObject);
 private
    procedure AjustGrid;
    { Private declarations }
 public
    { Public declarations }
    recIDProm:Integer;
    recIndNew:Boolean;
 end;

var
   FrmPromCli: TFrmPromCli;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmPromCli.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromCli.FormShow(Sender: TObject);
begin
   if not recIndNew then
   begin
      //DBGrid1.DataSource  := SouPromCli;
      TabPromCli.SQL.Text :=
      'SELECT PRC.*,PES.Nompes FROM arqpromocli PRC LEFT JOIN arqpessoa PES '+
      'ON PRC.IDPess = PES.IDPess WHERE IDProm = '+recIDProm.ToString;
      TabPromCli.Open;
   end else
   begin
      DBGrid1.DataSource := SouMPromCli;
      if not MemPromCli.Active then MemPromCli.Open;
   end;
   AjustGrid;
   edNompes.SetFocus;
end;

procedure TFrmPromCli.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight -5;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmPromCli.edNompesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edNompes),'IDPess','Nompes','IDEsppes != 3', Key);
   if edNompes.Tag > 0 then btIncluir.Click;
end;

procedure TFrmPromCli.btIncluirClick(Sender: TObject);
var
   Erro:Integer;
begin
   Erro := 0;
   PanelGrid.SetFocus;
   if edNompes.Tag <= 0 then Erro := 1;
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso','Favor escolher um cliente!', mtWarning, [mbOk]);
         edNompes.SetFocus;
      end;
      Exit;
   end; //if
   try
      try
         if not recIndNew then
         begin
            TabPromCli.Append;
            TabPromCliIDProm.Value := recIDProm;
            TabPromCliIDPess.Value := edNompes.Tag;
            TabPromCliNompes.Value := edNompes.Text;
            TabPromCli.Post;
            TabPromCli.Refresh;
         end else
         begin
            if not MemPromCli.Locate('IDPess',edNompes.Tag,[]) then
            begin
               MemPromCli.Append;
               MemPromCliIDPess.Value := edNompes.Tag;
               MemPromCliNompes.Value := edNompes.Text;
               MemPromCli.Post;
            end
            else raise Exception.Create('Duplicate ID');
            AjustGrid;
         end; //if
      except
         on E:Exception do
         begin
            if AnsiPos('Duplicate', E.Message) > 0 then
            begin
               MostraMsg('Aviso','Cliente já associado à esta promoção!', mtWarning, [mbOk]);
               if not recIndNew then
               begin
                  TabPromCli.Cancel;
                  TabPromCli.Refresh;
               end
               else MemPromCli.Cancel;
               AjustGrid;
            end else
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar associação de Cliente à Promoção -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar', mtError, [mbOk]);
            end;
         end; //on
      end;
   finally
      edNompes.SetFocus;
   end;
   edNompes.Text := '';
   edNompes.Tag  := 0;
end;

procedure TFrmPromCli.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if MostraMsg('Confirmação','Confirma eliminação desta asssociação de cliente?',mtConfirmation, [mbYes, mbNo]) = mrYes then
      begin
         try
            if not recIndNew then
                 TabPromCli.Delete
            else MemPromCli.Delete;
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO,PastaLog, 'ERRO: Não foi possível excluir arqpromocli -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir!',mtError, [mbOk]);
               Exit;
            end;
         end; //try
      end; //if
      if not recIndNew then
           DBGrid1.SelectedField := TabPromCliNompes
      else DBGrid1.SelectedField := MemPromCliNompes;
   end; //if
end;

procedure TFrmPromCli.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00D7E4FF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+4, 0);
   if Column.ID = 0 then
      DBGrid1.Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+5, Column.Field.DisplayText) else
end;

procedure TFrmPromCli.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromCli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if not recIndNew then
        TabPromCli.Close
   else MemPromCli.Close;
   Self := nil;
   FreeAndNil(Self);
end;

end.
