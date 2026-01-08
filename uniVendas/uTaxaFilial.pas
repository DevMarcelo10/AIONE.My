unit uTaxaFilial;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmTaxaFilial = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    TabTaxaFil: TRESTDWClientSQL;
    SouTaxaFil: TDataSource;
    DBGrid1: TDBGrid;
    TabTaxaFilIDTaxEnt: TIntegerField;
    TabTaxaFilIDFilial: TIntegerField;
    TabTaxaFilIndAtivo: TWideStringField;
    TabTaxaFilNomfil: TWideStringField;
    AdvGlowButton1: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
 private
    { Private declarations }
    procedure AjustGrid;
 public
    { Public declarations }
    recIDTaxEnt:Integer;
 end;

var
   FrmTaxaFilial: TFrmTaxaFilial;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmTaxaFilial.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTaxaFilial.FormShow(Sender: TObject);
var
   vErro:String;
   QueAuxi,QueIncl:TRESTDWClientSQL;
begin
   Screen.Cursor := crHourGlass;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueIncl.DataBase := DM.DWDataBase;
   QueIncl.SQL.Clear;
   TabTaxaFil.DisableControls;
   try
      TabTaxaFil.SQL.Text := 'SELECT TAX.*,FIL.Nomfil FROM arqtaxafil TAX LEFT JOIN '+
      'arqfilial FIL ON TAX.IDFilial = FIL.IDFilial WHERE IDTaxEnt = '+recIDTaxEnt.ToString;
      TabTaxaFil.Open;
      try
         QueAuxi.SQL.Text := 'SELECT * FROM arqfilial';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            while not QueAuxi.Eof do
            begin
               if not TabTaxaFil.Locate('IDTaxEnt;IDFilial',VarArrayOf([recIDTaxEnt,QueAuxi.FieldByName('IDFilial').AsInteger]),[]) then
                  QueIncl.SQL.Add('INSERT INTO arqtaxafil (IDTaxEnt,IDFilial) VALUES ('+recIDTaxEnt.ToString+','+QueAuxi.FieldByName('IDFilial').AsString+');');
               QueAuxi.Next;
            end; //if
            if QueIncl.SQL.Text <> '' then
            begin
               QueIncl.ExecSQL(vErro);
               if vErro <> '' then raise Exception.Create('Não foi possivel continuar. '+vErro);
            end;
         end; //if
      except
         on E:Exception do
         begin
            Screen.Cursor := crDefault;
            MostraMsg('Erro', 'Não foi possível continuar. '+E.Message,mtError, [mbOk]);
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
         end;
      end;
   finally
      Screen.Cursor := crDefault;
      QueAuxi.Close;
      QueIncl.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueIncl);
      TabTaxaFil.Close;
      TabTaxaFil.Open;
      TabTaxaFil.EnableControls;
      AjustGrid;
   end;
end;

procedure TFrmTaxaFilial.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 4;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmTaxaFilial.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTaxaFilial.DBGrid1CellClick(Column: TColumn);
begin
   if Column.FieldName = 'IndAtivo' then
   begin
      if not (TabTaxaFil.State in dsEditModes) then TabTaxaFil.Edit;
      TabTaxaFilIndAtivo.AsString := iif(TabTaxaFilIndAtivo.AsString = '0','1','0');
      TabTaxaFil.Post;
      DBGrid1.SelectedField := TabTaxaFilNomfil;
   end; //if
end;

procedure TFrmTaxaFilial.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;
   if Column.FieldName = 'IndAtivo' then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabTaxaFilIndAtivo.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if
end;

procedure TFrmTaxaFilial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabTaxaFil.Cancel;
   TabTaxaFil.Close;
   Action := caFree;
end;

end.
