unit uBuscaCDS;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Grids, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
   Vcl.DBGrids, MarcLib, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, LMDControl, LMDEdit,
   LMDCustomPanel, LMDSimplePanel, LMDCustomControl, LMDCustomBevelPanel, Datasnap.DBClient;

type
  TFrmBuscaCDS = class(TForm)
    QueryAux: TRESTDWClientSQL;
    SouAuxi: TDataSource;
    Timer: TTimer;
    PanelBusca: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TEdit;
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    procedure AbreSQL(recLimt:String; filtroBusca: String = '');
  public
    { Public declarations }
    recCarc:Word;
    recIndAll:Boolean;
    edRetorno:TLMDEdit;
    WidthColuna:Integer;
    ArqRetorno:TClientDataSet;
    ArqBusca,CampoOrigem,CampoRetor,CampoBusca,CamposFiltro,Filtro,CampoShow:String;
  end;

var
  FrmBuscaCDS: TFrmBuscaCDS;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmBuscaCDS.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBuscaCDS.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   if UpperCase(ArqBusca) = 'ARQPLACON' then DBGrid1.Columns[1].FieldName := 'DevCre';
   DBGrid1.Columns[1].Visible   := UpperCase(ArqBusca) = 'ARQPLACON';
   DBGrid1.Columns[0].FieldName := iif(UpperCase(ArqBusca) = 'ARQMUNI','NomCidEstCid',CampoBusca);
   DBGrid1.Columns[0].Width     := edBusca.Width-25; //iif(WidthColuna > 0, WidthColuna, Self.Width - iif(UpperCase(ArqBusca) = 'ARQPLACON',28,0)) - 23;
   edBusca.SelStart  := Length(edBusca.Text);
   edBusca.SelLength := Length(edBusca.Text);
   edBusca.SetFocus;
   AbreSQL('100');
end;

procedure TFrmBuscaCDS.TimerTimer(Sender: TObject);
var
   Tam:Integer;
   filtroBusca: String;
begin
   Timer.Enabled:= False;

   filtroBusca:= EmptyStr;
   Tam := Length(edBusca.Text);
   if (Tam <= 2) and (not RecIndAll) then
   begin
      if QueryAux.Active then QueryAux.Close;
      Exit;
   end else
   if (Tam = 3) and (not RecIndAll) then
   begin
      QueryAux.Close;
      QueryAux.Filtered := False;
      AbreSQL('');
      Exit;
   end else
   if ((Tam = 4) or RecIndAll) and (QueryAux.SQL.Text.Trim <> '') then
   begin
      if Trim(edBusca.Text) <> '' then
      begin
         filtroBusca:= CampoBusca+' LIKE '+Aspas('%'+edBusca.Text+'%');
      end;
      TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
      DBGrid1.Width := DBGrid1.Width - 10;
      DBGrid1.Width := DBGrid1.Width + 10;
   end; // if
   AbreSQL('100', filtroBusca);
end;

procedure TFrmBuscaCDS.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
   if Key = VK_RETURN then
   begin
      DBGrid1DblClick(Self);
   end else
   begin
     Timer.Enabled:= False;
     Timer.Enabled:= True;
   end;
end;

procedure TFrmBuscaCDS.AbreSQL(recLimt, filtroBusca: String);
begin
   QueryAux.Close;
   QueryAux.SQL.Clear;
   if (UpperCase(ArqBusca) = 'ARQCONVENIO') and (AnsiPos('COP.IDPess',Filtro) > 0) then
   begin
      QueryAux.SQL.Text :=
      'SELECT CON.IDConv,CON.Nomcon FROM arqpessconv COP LEFT JOIN arqconvenio CON ON '+
      'CON.IDConv = COP.IDConv WHERE '+Filtro+' GROUP BY CON.IDConv ORDER BY CON.Nomcon';
   end else
   begin
      QueryAux.SQL.Clear;
      QueryAux.SQL.Text := 'SELECT '+
      iif(UpperCase(ArqBusca) <> 'ARQPLACON', CampoOrigem+','+CampoBusca, 'IDCon,Codcon,Nomcon AS NomconShow,DevCre,'+
      'CONCAT(SUBSTRING(Codcon,1,1),".",SUBSTRING(Codcon,2,1),".",SUBSTRING(Codcon,3,1),".",SUBSTRING(Codcon,4,2),".",SUBSTRING(Codcon,6),"  ",Nomcon) AS Nomcon');
      if  UpperCase(ArqBusca) = 'ARQPRODUTO' then QueryAux.SQL.Add(',PrecoVen,QtdFrac') else
      if (UpperCase(ArqBusca) = 'ARQGRUPO') or (UpperCase(ArqBusca) = 'ARQGRUPOSUB') then QueryAux.SQL.Add(',Markup') else
      if  UpperCase(ArqBusca) = 'ARQMUNI'   then QueryAux.SQL.Add(',Estmun,CONCAT(Nommun,'+Aspas(' - ')+',Estmun) AS NomCidEstCid');
      QueryAux.SQL.Add(iif(CamposFiltro <> '',','+CamposFiltro,'')+' FROM '+ArqBusca);
      if Trim(edBusca.Text) <> '' then
      begin
         QueryAux.SQL.Add(' WHERE UPPER('+CampoBusca+') LIKE '+Aspas('%'+edBusca.Text+'%'));
//         QueryAux.ParamByName('pBusca').AsString := '%'+edBusca.Text+'%';
      end;
      if Filtro <> '' then QueryAux.SQL.Add(iif(AnsiPos('WHERE',QueryAux.SQL.Text) = 0,' WHERE ', ' AND ')+Filtro);
      if filtroBusca <> '' then QueryAux.SQL.Add(iif(AnsiPos('WHERE',QueryAux.SQL.Text) = 0,' WHERE ', ' AND ')+filtroBusca);

      QueryAux.SQL.Add(' ORDER BY '+CampoBusca+iif(recLimt <> '',' LIMIT '+recLimt,''));
   end; //if
   QueryAux.SQL.SaveToFile('C:\Temp\QueryAux.sql');
   QueryAux.Open;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 10;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmBuscaCDS.DBGrid1DblClick(Sender: TObject);
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
      if UpperCase(ArqBusca) = 'ARQPRODUTO'  then
      begin
         _PrecoVen := FieldByName('PrecoVen').AsFloat;
         _Fracao   := FieldByName('QtdFrac').AsFloat;
      end;
      if UpperCase(ArqBusca) = 'ARQGRUPO'    then _MarkupGru := FieldByName('Markup').AsFloat;
      if UpperCase(ArqBusca) = 'ARQGRUPOSUB' then _MarkupSub := FieldByName('Markup').AsFloat;
      if UpperCase(ArqBusca) = 'ARQPLACON'   then
      begin
         _CodConta := FieldByName('Codcon').AsString;
         _IDConta  := FieldByName('IDCon').AsInteger;
      end;
      if CampoShow <> '' then
      begin
         if UpperCase(ArqBusca) = 'ARQPLACON' then
              ArqRetorno[CampoShow] := FieldByName('NomconShow').Value
         else
            ArqRetorno[CampoShow] := FieldByName(CampoBusca).Value;
      end;
   end; //with
   Close;
end;

procedure TFrmBuscaCDS.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
   if Key = VK_RETURN then DBGrid1DblClick(Self);
end;

procedure TFrmBuscaCDS.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      DBGrid1.Canvas.Brush.Color := $00E1EBFF;
      DBGrid1.Canvas.Font.Color := clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmBuscaCDS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QueryAux.Close;
   if (ArqRetorno = nil) and (edRetorno.Tag = 0) then edRetorno.Text := edBusca.Text;
   edBusca.Clear;
end;

end.

