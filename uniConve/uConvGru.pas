unit uConvGru;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, MarcLib, LMDBaseControl,LMDEdit,
   LMDBaseGraphicControl, LMDBaseLabel, Vcl.DBGrids, LMDLabel, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomLabel, VirtualTable, System.Types, System.StrUtils,
   LMDBaseEdit, LMDCustomEdit, Vcl.StdCtrls, FireDAC.Stan.Intf, uRESTDWBasicDB,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes,
   FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TFrmConLimGru = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCadastro: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    SouGrupLim: TDataSource;
    LMDSimplePanel1: TLMDSimplePanel;
    DBGrid2: TDBGrid;
    LMDLabel1: TLMDLabel;
    SouSubgLim: TDataSource;
    TabGrupLim: TRESTDWClientSQL;
    TabGrupLimIDConv: TIntegerField;
    TabGrupLimIDGrupo: TIntegerField;
    TabGrupLimDesgru: TWideStringField;
    TabSubgLim: TRESTDWClientSQL;
    TabSubgLimIDConv: TIntegerField;
    TabSubgLimIDGruSub: TIntegerField;
    TabSubgLimIDGrupo: TIntegerField;
    TabSubgLimDesgruSub: TWideStringField;
    edNomgru: TLMDEdit;
    edSubg: TLMDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabGrupLimAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure edSubgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSubgEnter(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure TabSubgLimLimAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDConv:Integer;
  end;

var
   FrmConLimGru: TFrmConLimGru;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uSubstancia;

procedure TFrmConLimGru.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmConLimGru.FormShow(Sender: TObject);
begin
   try
      TabGrupLim.SQL.Text := 'SELECT GRL.*,GRU.Desgru FROM arqconvglim GRL LEFT JOIN '+
      'arqgrupo GRU ON GRL.IDGrupo = GRU.IDGrupo WHERE GRL.IDConv = '+recIDConv.ToString;
      TabGrupLim.Open;
      TabSubgLim.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
   DBGrid2.Width := DBGrid2.Width - 10;
   DBGrid2.Width := DBGrid2.Width + 10;
   edNomgru.SetFocus;
end;

procedure TFrmConLimGru.TabGrupLimAfterPost(DataSet: TDataSet);
begin
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmConLimGru.TabSubgLimLimAfterPost(DataSet: TDataSet);
begin
   DBGrid2.Width := DBGrid2.Width - 10;
   DBGrid2.Width := DBGrid2.Width + 10;
end;

procedure TFrmConLimGru.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if TabGrupLim.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação da restrição do grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
            TabGrupLim.Delete;
      end;
   end
   else TabGrupLim.Cancel;
   DBGrid1.SelectedField := TabGrupLimDesgru;
end;

procedure TFrmConLimGru.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+2, 3);
end;

procedure TFrmConLimGru.DBGrid2CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if TabSubgLim.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação da restrição do sub grupo?',mtConfirmation, [mbYes, mbNo]) = mrYes then
            TabSubgLim.Delete;
      end;
   end
   else TabSubgLim.Cancel;
   DBGrid2.SelectedField := TabSubgLimDesgruSub;
end;

procedure TFrmConLimGru.edNomgruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_RETURN) and (edNomgru.Tag > 0) then
   begin
      if TabGrupLim.Locate('IDGrupo',edNomgru.Tag,[]) then
      begin
         MostraMsg('Aviso','Grupo já restringido ao convênio.', mtWarning, [mbOk]);
         Exit;
      end;
      TabGrupLim.Append;
      TabGrupLimIDConv.Value  := recIDConv;
      TabGrupLimIDGrupo.Value := edNomgru.Tag;
      TabGrupLimDesgru.Value  := Trim(edNomgru.Text);
      TabGrupLim.Post;
      edNomgru.Tag  := 0;
      edNomgru.Text := '';
      edNomgru.SetFocus;
   end
   else btBuscas('arqgrupo',edNomgru,'IDGrupo','Desgru','',Key);
end;

procedure TFrmConLimGru.edSubgEnter(Sender: TObject);
begin
   if TabGrupLim.IsEmpty then
   begin
      MostraMsg('Aviso','Favor escolher um Grupo antes.', mtWarning, [mbOk]);
      edNomgru.SetFocus;
      Exit;
   end;
end;

procedure TFrmConLimGru.edSubgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_RETURN) and (edSubg.Tag > 0) then
   begin
      if TabSubgLim.Locate('IDGruSub',edSubg.Tag,[]) then
      begin
         MostraMsg('Aviso','Sub Grupo já restringido ao convênio.', mtWarning, [mbOk]);
         Exit;
      end;
      TabSubgLim.Append;
      TabSubgLimIDConv.Value    := recIDConv;
      TabSubgLimIDGrupo.Value   := TabGrupLimIDGrupo.Value;
      TabSubgLimIDGruSub.Value  := edSubg.Tag;
      TabSubgLimDesgruSub.Value := Trim(edSubg.Text);
      TabSubgLim.Post;
      edSubg.Tag  := 0;
      edSubg.Text := '';
      edSubg.SetFocus;
   end
   else btBuscas('arqgruposub',edSubg,'IDGruSub','DesgruSub','IDGrupo = '+TabGrupLimIDGrupo.AsString,Key);
end;

procedure TFrmConLimGru.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmConLimGru.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabSubgLim.Close;
   TabGrupLim.Close;
   Self := nil;
end;

end.
