unit uBuscaVT;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, LMDBaseEdit, LMDEdit, StdCtrls, LMDControl, LMDCustomPanel,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uLibFarm,
   VirtualTable;

type
  TFrmBuscaVT = class(TForm)
    PanelBusca: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TEdit;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    procedure AbreSQL(recLimt:String);
    { Private declarations }
  public
    { Public declarations }
    recCarc:Word;
    recIndAll:Boolean;
    edRetorno:TLMDEdit;
    WidthColuna:Integer;
    ArqRetorno:TVirtualTable;
    ArqBusca,CampoOrigem,CampoRetor,CampoBusca,CamposFiltro,Filtro,CampoShow:String;
  end;

var
  FrmBuscaVT: TFrmBuscaVT;

implementation

{$R *.dfm}

uses uDM, uConst;

procedure TFrmBuscaVT.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaVT.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   if UpperCase(ArqBusca) = 'ARQPLACON' then DBGrid1.Columns[1].FieldName := 'DevCre';
   DBGrid1.Columns[1].Visible := UpperCase(ArqBusca) = 'ARQPLACON';
   DBGrid1.Columns[0].FieldName := iif(UpperCase(ArqBusca) = 'ARQMUNI','NomCidEstCid',CampoBusca);
   DBGrid1.Columns[0].Width     := iif(WidthColuna > 0, WidthColuna, Self.Width - iif(UpperCase(ArqBusca) = 'ARQPLACON',28,0)) - 23;
   AbreSQL('200');
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBuscaVT.edBuscaChange(Sender: TObject);
var
   Tam:Integer;
begin
   Tam := Length(edBusca.Text);
   if (Tam <= 2) and (not RecIndAll) then
   begin
      if Active then Close;
      Exit;
   end else
   if (Tam = 3) and (not RecIndAll) then
   begin
      Close;
      QueryAux.Filtered := False;
      AbreSQL('');
      Exit;
   end else
   if ((Tam = 4) or RecIndAll) and (QueryAux.SQL.Text.Trim <> '') then
   begin
      if Trim(edBusca.Text) <> '' then
      begin
         Close;
         QueryAux.Filter   := CampoBusca+' LIKE '+Aspas('%'+edBusca.Text+'%');
         QueryAux.Filtered := True;
         QueryAux.Open;
      end;
      TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
      DBGrid1.Width := DBGrid1.Width - 10;
      DBGrid1.Width := DBGrid1.Width + 10;
   end; // if
   if (Trim(edBusca.Text) <> '') and (QueryAux.SQL.Text.Trim <> '') then
      QueryAux.Locate(CampoBusca, edBusca.Text, [lopartialkey]);
end;

procedure TFrmBuscaVT.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_DOWN then
   begin
      Key := 0;
      if QueryAux.Active then QueryAux.Next
   end else
   if Key = VK_UP then
   begin
      Key := 0;
      if QueryAux.Active then QueryAux.Prior;
   end else
   if Key = VK_ESCAPE then
   begin
      edBusca.Text := '';
      Close;
   end else
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaVT.AbreSQL(recLimt: String);
begin
   QueryAux.Close;
   QueryAux.SQL.Clear;
   QueryAux.SQL.Text := 'SELECT '+
      iif(UpperCase(ArqBusca) <> 'ARQPLACON', CampoOrigem+','+CampoBusca, 'IDCon,Codcon,Nomcon AS NomconShow,DevCre,'+
      'CONCAT(SUBSTRING(Codcon,1,1),".",SUBSTRING(Codcon,2,1),".",SUBSTRING(Codcon,3,1),".",SUBSTRING(Codcon,4,2),".",SUBSTRING(Codcon,6),"  ",Nomcon) AS Nomcon');
   if UpperCase(ArqBusca) = 'ARQPRODUTO' then
      QueryAux.SQL.Add(',PrecoVen,QtdFrac') else
   if (UpperCase(ArqBusca) = 'ARQGRUPO') or (UpperCase(ArqBusca) = 'ARQGRUPOSUB') then
      QueryAux.SQL.Add(',Markup') else
   if UpperCase(ArqBusca) = 'ARQMUNI'   then
      QueryAux.SQL.Add(',Estmun,CONCAT(Nommun,'+Aspas(' - ')+',Estmun) AS NomCidEstCid');
   QueryAux.SQL.Add(iif(CamposFiltro <> '',','+CamposFiltro,'')+' FROM '+ArqBusca);
   if Trim(edBusca.Text) <> '' then
   begin
      QueryAux.SQL.Add(' WHERE UPPER('+CampoBusca+') LIKE :pBusca ');
      QueryAux.ParamByName('pBusca').AsString := '%'+edBusca.Text+'%';
   end;
   if Filtro <> '' then
      QueryAux.SQL.Add(iif(AnsiPos('WHERE',QueryAux.SQL.Text) = 0,' WHERE ', ' AND ')+Filtro);
   QueryAux.SQL.Add(' ORDER BY '+CampoBusca+iif(recLimt <> '',' LIMIT '+recLimt,''));
   QueryAux.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaVT.DBGrid1DblClick(Sender: TObject);
begin
   if not QueryAux.Active then Exit;
   if (QueryAux.RecordCount = 0) or (QueryAux.FieldByName(CampoOrigem).AsString.Trim = '') then Exit;
   if ArqRetorno = nil then
   begin
      edRetorno.Tag  := QueryAux.FieldByName(CampoOrigem).AsInteger;
      edRetorno.Text := QueryAux.FieldByName(CampoBusca).AsString;
   end else
   begin
      if not(ArqRetorno.State in dsEditModes) then ArqRetorno.Edit;
      if UpperCase(ArqBusca) = 'ARQMUNI' then
      begin
         ArqRetorno['Nommun'] := QueryAux.FieldByName('Nommun').Value;
         ArqRetorno['Estmun'] := QueryAux.FieldByName('Estmun').Value;
      end
      else ArqRetorno[CampoRetor] := QueryAux.FieldByName(CampoOrigem).Value;
   end;
   if UpperCase(ArqBusca) = 'ARQPRODUTO'  then
   begin
      _PrecoVen := QueryAux.FieldByName('PrecoVen').AsFloat;
      _Fracao   := QueryAux.FieldByName('QtdFrac').AsFloat;
   end;
   if UpperCase(ArqBusca) = 'ARQGRUPO'    then
      _MarkupGru := QueryAux.FieldByName('Markup').AsFloat;
   if UpperCase(ArqBusca) = 'ARQGRUPOSUB' then
      _MarkupSub := QueryAux.FieldByName('Markup').AsFloat;
   if UpperCase(ArqBusca) = 'ARQPLACON'   then
   begin
      _CodConta := QueryAux.FieldByName('Codcon').AsString;
      _IDConta  := QueryAux.FieldByName('IDCon').AsInteger;
   end;
   if CampoShow <> '' then
   begin
      if UpperCase(ArqBusca) = 'ARQPLACON' then
           ArqRetorno[CampoShow] := QueryAux.FieldByName('NomconShow').Value
      else ArqRetorno[CampoShow] := QueryAux.FieldByName(CampoBusca).Value;
   end;
   Close;
end;

procedure TFrmBuscaVT.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaVT.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmBuscaVT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if (ArqRetorno = nil) and (edRetorno.Tag = 0) then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.

