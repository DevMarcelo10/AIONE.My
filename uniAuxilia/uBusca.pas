unit uBusca;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Grids,
   Forms, Dialogs, LMDBaseEdit, LMDEdit, StdCtrls, LMDControl, LMDCustomPanel,
   DB, LMDCustomControl, LMDSimplePanel, LMDCustomBevelPanel, MarcLib, DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uRESTDWBasicDB,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmBusca = class(TForm)
    PanelBusca: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TEdit;
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
  private
    procedure AbreSQL(recLimt:String);
    { Private declarations }
  public
    { Public declarations }
    recCarc:Word;
    recIndAll:Boolean;
    edRetorno:TLMDEdit;
    WidthColuna:Integer;
    ArqRetorno:TRESTDWClientSQL;
    ArqBusca,CampoOrigem,CampoRetor,CampoBusca,CamposFiltro,Filtro,CampoShow:String;
  end;

var
   FrmBusca: TFrmBusca;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBusca.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBusca.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   if UpperCase(ArqBusca) = 'ARQPLACON' then DBGrid1.Columns[1].FieldName := 'DevCre';
   DBGrid1.Columns[1].Visible := UpperCase(ArqBusca) = 'ARQPLACON';
   DBGrid1.Columns[0].FieldName := iif(UpperCase(ArqBusca) = 'ARQMUNI','NomCidEstCid',CampoBusca);
   DBGrid1.Columns[0].Width     := iif(WidthColuna > 0, WidthColuna, Self.Width - iif(UpperCase(ArqBusca) = 'ARQPLACON',28,0)) - 23;
   AbreSQL('');
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
end;

procedure TFrmBusca.edBuscaChange(Sender: TObject);
var
   Tam:Integer;
begin
   Tam := Length(edBusca.Text);
   with QueryAux do
   begin
      if (Tam <= 2) and (not RecIndAll) then
      begin
         if Active then Close;
         Exit;
      end else
      if (Tam = 3) and (not RecIndAll) then
      begin
         Close;
         Filtered := False;
         AbreSQL('');
         Exit;
      end else
      if ((Tam = 4) or RecIndAll) and (QueryAux.SQL.Text.Trim <> '') then
      begin
         if Trim(edBusca.Text) <> '' then
         begin
            Close;
            Filter   := CampoBusca+' LIKE '+Aspas('%'+edBusca.Text+'%');
            Filtered := True;
            QueryAux.Open;
         end;
         TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
         DBGrid1.Width := DBGrid1.Width - 10;
         DBGrid1.Width := DBGrid1.Width + 10;
      end; // if
      if (Trim(edBusca.Text) <> '') and (QueryAux.SQL.Text.Trim <> '') then
         Locate(CampoBusca, edBusca.Text, [lopartialkey]);
   end; // with
end;

procedure TFrmBusca.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmBusca.AbreSQL(recLimt:String);
var
   soInteger:String;
begin
   with QueryAux do
   begin
      QueryAux.Close;
      SQL.Clear;
      if (UpperCase(ArqBusca) = 'ARQCONVENIO') and (AnsiPos('COP.IDPess',Filtro) > 0) then
      begin
         SQL.Text :=
         'SELECT CON.IDConv,CON.Nomcon FROM arqpessconv COP LEFT JOIN arqconvenio CON ON '+
         'CON.IDConv = COP.IDConv WHERE '+Filtro+' GROUP BY CON.IDConv ORDER BY CON.Nomcon';
      end else
      begin
         SQL.Clear;
         SQL.Text := 'SELECT '+
         iif(UpperCase(ArqBusca) <> 'ARQPLACON', CampoOrigem+','+CampoBusca, 'IDCon,Codcon,Nomcon AS NomconShow,DevCre,'+
         'CONCAT(SUBSTRING(Codcon,1,1),".",SUBSTRING(Codcon,2,1),".",SUBSTRING(Codcon,3,1),".",SUBSTRING(Codcon,4,2),".",SUBSTRING(Codcon,6),"  ",Nomcon) AS Nomcon');
         if  UpperCase(ArqBusca) = 'ARQPRODUTO' then SQL.Add(',PrecoVen,QtdFrac') else
         if (UpperCase(ArqBusca) = 'ARQGRUPO') or (UpperCase(ArqBusca) = 'ARQGRUPOSUB') then SQL.Add(',Markup') else
         if  UpperCase(ArqBusca) = 'ARQMUNI'       then SQL.Add(',Estmun,CONCAT(Nommun,'+Aspas(' - ')+',Estmun) AS NomCidEstCid');
         if  UpperCase(ArqBusca) = 'ARQCLATRIBITE' then SQL.Add(',PerRedCBS,PerRedIBS');
         SQL.Add(iif(CamposFiltro <> '',','+CamposFiltro,'')+' FROM '+ArqBusca);
         if Trim(edBusca.Text) <> '' then
            SQL.Add(' WHERE UPPER('+CampoBusca+') LIKE '+Aspas('%'+edBusca.Text+'%'));
         if Filtro <> '' then SQL.Add(iif(AnsiPos('WHERE',QueryAux.SQL.Text) = 0,' WHERE ', ' AND ')+Filtro);
         SQL.Add(' ORDER BY '+CampoBusca+iif(recLimt <> '',' LIMIT '+recLimt,''));
      end; //if
      QueryAux.Open;
   end; // with
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBusca.DBGrid1DblClick(Sender:TObject);
begin
   with QueryAux do
   begin
      if not Active then Exit;
      if (RecordCount = 0) or (FieldByName(CampoOrigem).AsString.Trim = '') then Exit;
      if ArqRetorno = nil then
      begin
         edRetorno.Tag  := FieldByName(CampoOrigem).AsInteger;
         edRetorno.Text := FieldByName(CampoBusca).AsString;
      end else
      begin
         if not(ArqRetorno.State in dsEditModes) then ArqRetorno.Edit;
         if UpperCase(ArqBusca) = 'ARQMUNI' then
         begin
            ArqRetorno['Nommun'] := FieldByName('Nommun').Value;
            ArqRetorno['Estmun'] := FieldByName('Estmun').Value;
         end
         else ArqRetorno[CampoRetor] := FieldByName(CampoOrigem).Value;
      end;
      if UpperCase(ArqBusca) = 'ARQPRODUTO'  then _PrecoVen  := Roundx(FieldByName('PrecoVen').AsFloat / iif(FieldByName('QtdFrac').AsFloat > 0, FieldByName('QtdFrac').AsFloat,1) ,2);
      if UpperCase(ArqBusca) = 'ARQGRUPO'    then _MarkupGru := FieldByName('Markup').AsFloat;
      if UpperCase(ArqBusca) = 'ARQGRUPOSUB' then _MarkupSub := FieldByName('Markup').AsFloat;
      if UpperCase(ArqBusca) = 'ARQPLACON'   then
      begin
         _CodConta := FieldByName('Codcon').AsString;
         _IDConta  := FieldByName('IDCon').AsInteger;
      end;
      if UpperCase(ArqBusca) = 'ARQCLATRIBITE'  then
      begin
         _PerRedCBS := FieldByName('PerRedCBS').AsFloat;
         _PerRedIBS := FieldByName('PerRedIBS').AsFloat;
      end;
      if CampoShow <> '' then
      begin
         if UpperCase(ArqBusca) = 'ARQPLACON' then
              ArqRetorno[CampoShow] := FieldByName('NomconShow').Value
         else ArqRetorno[CampoShow] := FieldByName(CampoBusca).Value;
      end;
   end; //with
   Close;
end;

procedure TFrmBusca.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBusca.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmBusca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if (ArqRetorno = nil) and (edRetorno.Tag = 0) then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.

