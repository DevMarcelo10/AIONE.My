unit uProSubs;

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
   FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TFrmProSubs = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCadastro: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    TabSubs: TRESTDWClientSQL;
    SouSubs: TDataSource;
    TabSubsIDProd: TIntegerField;
    TabSubsIDSubs: TIntegerField;
    TabSubsDessubs: TWideStringField;
    edNomsub: TLMDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabProdEANAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure edNomsubKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNomsubCustomButtons0Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDProd:Integer;
    retDesSubs:String;
  end;

var
   FrmProSubs: TFrmProSubs;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uSubstancia;

procedure TFrmProSubs.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmProSubs.FormShow(Sender: TObject);
begin
   TabSubs.SQL.Text := 'SELECT PSUB.*,SUB.Dessubs FROM arqprodutosub PSUB LEFT JOIN ';
   TabSubs.SQL.Add('arqsubstancia SUB ON PSUB.IDSubs = SUB.IDSubs WHERE IDProd = '+recIDProd.ToString);
   TabSubs.Open;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
   edNomsub.SetFocus;
end;

procedure TFrmProSubs.TabProdEANAfterPost(DataSet: TDataSet);
begin
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmProSubs.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 1 then
   begin
      if TabSubs.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação desta substância para este produto?',mtConfirmation, [mbYes, mbNo]) = mrYes then
            TabSubs.Delete;
      end; //if
   end
   else TabSubs.Cancel;
   DBGrid1.SelectedField := TabSubsDesSubs;
end;

procedure TFrmProSubs.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color  := clBlack;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 1 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+2, 3);
end;

procedure TFrmProSubs.edNomsubCustomButtons0Click(Sender: TObject; index: Integer);
begin
   AbreSubForm(Self, FrmSubstancia, TFrmSubstancia, PanelCadastro);
end;

procedure TFrmProSubs.edNomsubKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_RETURN) and (edNomsub.Tag > 0) then
   begin
      if TabSubs.Locate('IDSubs',edNomsub.Tag,[]) then
      begin
         MostraMsg('Aviso','Substância já associada ao produto.', mtWarning, [mbOk]);
         Exit;
      end;
      TabSubs.Append;
      TabSubsIDProd.Value  := recIDProd;
      TabSubsIDSubs.Value  := edNomsub.Tag ;
      TabSubsDesSubs.Value := Trim(edNomsub.Text);
      TabSubs.Post;
      edNomsub.Tag  := 0;
      edNomsub.Text := '';
      edNomsub.SetFocus;
   end
   else btBuscas('arqsubstancia',TLMDEdit(edNomsub),'IDSubs','DesSubs','',Key);
end;

procedure TFrmProSubs.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmProSubs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   retDesSubs := '';
   TabSubs.DisableControls;
   TabSubs.First;
   while not TabSubs.Eof do
   begin
      retDesSubs := retDesSubs + TabSubsDesSubs.AsString + ' + ';
      TabSubs.Next;
   end;
   TabSubs.Close;
   if retDesSubs <> '' then retDesSubs := Copy(retDesSubs, 1, Length(retDesSubs) -3);
   Action := caFree;
end;

end.
