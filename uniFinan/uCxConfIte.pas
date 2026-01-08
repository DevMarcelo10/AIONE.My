unit uCxConfIte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit,
  LMDEdit, LMDButtonControl, LMDRadioButton, Vcl.StdCtrls, AdvGlowButton, Vcl.Mask,
  RxToolEdit, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  MarcLib,
  FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, LMDCustomMaskEdit,LMDLabel,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, LMDMaskEdit, Vcl.ExtCtrls, LMDBaseControl,
  LMDBaseLabel, LMDCustomLabel, LMDBaseGraphicControl, uCxConf;

type
  TFrmCxConfIte = class(TForm)
    PanelBack: TLMDSimplePanel;
    PanelBackConf: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    edDinheiro: TLMDLabeledEdit;
    LMDLabel1: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edCartao: TLMDLabeledEdit;
    LMDSimplePanel4: TLMDSimplePanel;
    edPrazo: TLMDLabeledEdit;
    LMDSimplePanel5: TLMDSimplePanel;
    edPix: TLMDLabeledEdit;
    LMDSimplePanel6: TLMDSimplePanel;
    edOutros: TLMDLabeledEdit;
    LMDSimplePanel7: TLMDSimplePanel;
    edTotalDif: TLMDLabeledEdit;
    Shape1: TShape;
    btConfirma: TAdvGlowButton;
    btLancaDif: TAdvGlowButton;
    Shape2: TShape;
    SouTabela: TDataSource;
    Tabela: TRESTDWClientSQL;
    TabelaNompes: TWideStringField;
    TabelaEndpes: TWideStringField;
    TabelaNroEnd: TWideStringField;
    TabelaBaipes: TWideStringField;
    TabelaCeppes: TWideStringField;
    TabelaFonePes: TWideStringField;
    TabelaCelularPes: TWideStringField;
    TabelaEmailPes: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btConfirmaClick(Sender: TObject);
  private
    FCaller: TFrmCxConf;
    procedure AjustGrid;
    { Private declarations }
  public
    { Public declarations }
    property Caller: TFrmCxConf read FCaller write FCaller;
  end;

var
  FrmCxConfIte: TFrmCxConfIte;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uConst;

procedure TFrmCxConfIte.FormShow(Sender: TObject);
begin
   Tabela.Open; // Usei o arqpessoa somente para testes do dgrid...
   AjustGrid;
   DBGrid1.SetFocus;
end;

procedure TFrmCxConfIte.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmCxConfIte.btConfirmaClick(Sender: TObject);
begin

   Self.Close;
end;

procedure TFrmCxConfIte.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   with TDBGrid(Sender) do
   begin
         if gdSelected in State then
         begin
            (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
            (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
            (Sender as TDBGrid).Canvas.FillRect(Rect);
         end else
         if not odd(Tabela.RecNo) then
         begin
            (Sender as TDBGrid).Canvas.Brush.Color := $00F4F8FF;
            (Sender as TDBGrid).Canvas.FillRect(Rect);
            (Sender as TDBGrid).DefaultDrawDataCell(rect,Column.Field,state);
         end;
      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter then
            Canvas.TextRect(Rect,Rect.Left + (Rect.Width - Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taRightJustify then
            Canvas.TextRect(Rect,Rect.Left + Rect.Width - Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
         if Column.Alignment = taLeftJustify then
            Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
      end; //if
      {if Column.ID = 6 then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         if TabelaIndSel.AsString = '1' then
              Check := DFCS_CHECKED
         else Check := 0;
         R := Rect;
         InflateRect(R,-3,-3);
         DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
      end; }
      // if Column.ID = 7 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+3, Rect.Top+3, 0);
   end; //with
end;

procedure TFrmCxConfIte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FCaller.PanelFiltros.Enabled := True;
   FCaller.PanelBotton.Visible  := True;
   Tabela.Close;
   Action := caFree;
   Self   := nil;
end;

end.
