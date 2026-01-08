unit uTaxCidBai;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, LMDBaseControl,LMDEdit, Vcl.ExtCtrls,
   LMDBaseGraphicControl, LMDBaseLabel, Vcl.DBGrids, LMDLabel, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomLabel, System.Types, LMDBaseEdit, LMDCustomEdit,
   Vcl.StdCtrls, FireDAC.Stan.Intf, uRESTDWBasicDB, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes, FireDAC.Comp.Client;

type
  TFrmTaxCidBai = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCadastro: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    SouTaxaMun: TDataSource;
    TabTaxaMun: TRESTDWClientSQL;
    edNommun: TLMDEdit;
    btSalvar: TAdvGlowButton;
    TabTaxaMunIDTaxEnt: TIntegerField;
    TabTaxaMunCodmun: TIntegerField;
    TabTaxaMunNommun: TWideStringField;
    TabTaxaMunNombai: TWideStringField;
    TabTaxaMunCodbai: TIntegerField;
    edNombai: TLMDLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNommunKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure edNombaiEnter(Sender: TObject);
    procedure edNombaiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSalvarClick(Sender: TObject);
    procedure edNombaiCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edNombaiCustomButtons0Click(Sender: TObject; index: Integer);
  private
    procedure AjustGrid;
    procedure TabTaxaMunAfterPost(DataSet: TDataSet);
    { Private declarations }
  public
    { Public declarations }
    recIDTaxEnt:Integer;
  end;

var
   FrmTaxCidBai: TFrmTaxCidBai;

implementation

{$R *.dfm}

uses uDM, uLibFarm, uCidBairro;

// >>>>>>> NESSE PONTO: TESTAR GERAL

procedure TFrmTaxCidBai.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTaxCidBai.FormShow(Sender: TObject);
begin
   try
      TabTaxaMun.SQL.Text := 'SELECT TMU.*,MUN.Nommun,BAI.Nombai FROM arqtaxaentmun TMU '+
      'LEFT JOIN arqmuni MUN ON TMU.Codmun = MUN.Codmun '+
      'LEFT JOIN arqbairro BAI ON TMU.Codmun = BAI.Codmun AND TMU.Codbai = BAI.Codbai '+
      'WHERE TMU.IDTaxEnt = '+recIDTaxEnt.ToString;
      TabTaxaMun.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   AjustGrid;
   edNommun.SetFocus;
end;

procedure TFrmTaxCidBai.AjustGrid;
begin
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmTaxCidBai.TabTaxaMunAfterPost(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmTaxCidBai.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 2 then
   begin
      if TabTaxaMun.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação da Cidaded/Bairro?',mtConfirmation, [mbYes, mbNo]) = mrYes then
            TabTaxaMun.Delete;
      end;
   end
   else TabTaxaMun.Cancel;
   DBGrid1.SelectedField := TabTaxaMunNombai;
end;

procedure TFrmTaxCidBai.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 2 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+2, 3);
end;

procedure TFrmTaxCidBai.edNombaiCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if edNommun.Tag <= 0 then
   begin
      MostraMsg('Aviso', 'Favor selecionar uma cidade antes!', mtWarning, [mbOk]);
      edNommun.SetFocus;
      Exit;
   end;
   FrmCidBairro := TFrmCidBairro.Create(Application);
   try
      FrmCidBairro.recCodmun := edNommun.Tag;
      FrmCidBairro.recNommun := edNommun.Text.Trim;
      FrmCidBairro.ShowModal;
   finally
      FrmCidBairro.Free;
   end;
end;

procedure TFrmTaxCidBai.edNombaiCustomButtons1Click(Sender: TObject; index: Integer);
begin
   if edNommun.Tag > 0 then
      btBuscas('arqbairro',edNombai,'Codbai','Nombai','Codmun = '+edNommun.Tag.ToString,0,True);
end;

procedure TFrmTaxCidBai.edNombaiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if edNommun.Tag > 0 then
      btBuscas('arqbairro',edNombai,'Codbai','Nombai','Codmun = '+edNommun.Tag.ToString,Key,True);
end;

procedure TFrmTaxCidBai.edNombaiEnter(Sender: TObject);
begin
   if edNommun.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher uma Cidade antes.', mtWarning, [mbOk]);
      edNommun.SetFocus;
      Exit;
   end;
end;

procedure TFrmTaxCidBai.edNommunKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqmuni',edNommun,'Codmun','Nommun','',Key);
end;

procedure TFrmTaxCidBai.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTaxCidBai.btSalvarClick(Sender: TObject);
begin
   if edNommun.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolhe uma Cidade.', mtWarning, [mbOk]);
      edNommun.SetFocus;
      Exit;
   end;

   if TabTaxaMun.Locate('IDTaxEnt;Codmun;Codbai',VarArrayOf([recIDTaxEnt,edNommun.Tag,edNombai.Tag]),[]) then
   begin
      MostraMsg('Aviso','Cidade / Bairro já associado à Taxa.', mtWarning, [mbOk]);
      Exit;
   end;
   TabTaxaMun.Append;
   TabTaxaMunIDTaxEnt.Value := recIDTaxEnt;
   TabTaxaMunCodmun.Value   := edNommun.Tag;
   TabTaxaMunNommun.Value   := Trim(edNommun.Text);
   TabTaxaMunCodbai.Value   := edNombai.Tag;
   TabTaxaMunNombai.Value   := Trim(edNombai.Text);
   TabTaxaMun.Post;
   edNommun.Text := '';
   edNombai.Text := '';
   edNommun.Tag  := 0;
   edNombai.Tag  := 0;
   edNommun.SetFocus;
end;

procedure TFrmTaxCidBai.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabTaxaMun.Close;
   Action := caFree;
end;

end.
