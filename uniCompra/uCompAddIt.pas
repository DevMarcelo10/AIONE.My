unit uCompAddIt;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.StdCtrls, LMDSimplePanel, LMDControl, Data.DB,
   LMDCustomControl, LMDCustomPanel, AdvSmoothPanel, Vcl.ExtCtrls,
   uRESTDWBasicTypes, AdvEdBtn, uRESTDWBasicDB, AdvGlowButton, Vcl.Grids,
   LMDBaseGraphicControl, LMDCustomLabel, LMDCustomBevelPanel, VCL.Forms,
   Vcl.Controls, LMDBaseLabel, LMDLabel, LMDBaseControl, Vcl.DBGrids,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, MarcLib,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Vcl.Graphics,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, AdvEdit,
   Vcl.Dialogs, LMDBaseEdit, LMDCustomEdit, LMDEdit, MemDS, VirtualTable;

type
  THackDBGrid = class(TDBGrid);

  TFrmCompAdd = class(TForm)
    PanelBas: TAdvSmoothPanel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    btFechar: TAdvGlowButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    PanelGrids: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    edBusca: TAdvEditBtn;
    MemPedFilial: TVirtualTable;
    SouPedFilial: TDataSource;
    MemPedFilialIDFilial: TIntegerField;
    MemPedFilialQtdped: TFloatField;
    MemPedFilialQtdest: TFloatField;
    MemPedFilialVlrult: TFloatField;
    MemPedFilialNomfil: TWideStringField;
    btGerFilial: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btGerFilialClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function  VeSeExiste:Boolean;
    procedure MemPedFilialAfterInsert(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    AtivaAfterInsert:Boolean;  
    function BuscaProd:Boolean;
    { Private declarations }
  public
    { Public declarations }
    recIDComp:Integer;
  end;

var
   FrmCompAdd: TFrmCompAdd;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmCompAdd.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   AtivaAfterInsert := False;
end;

procedure TFrmCompAdd.FormShow(Sender: TObject);
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   edBusca.Clear;
   edBusca.SetFocus;
end;

procedure TFrmCompAdd.MemPedFilialAfterInsert(DataSet: TDataSet);
begin
   if AtivaAfterInsert then 
      MemPedFilial.Cancel;
end;

procedure TFrmCompAdd.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Column.FieldName = 'Qtdped' then (Sender as TDBGrid).Canvas.Brush.Color := $00F4F8FF;
   if ((THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) and (not (MemPedFilial.State in dsEditModes))) or (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      (Sender as TDBGrid).Canvas.FillRect(Rect);
   end;
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmCompAdd.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Shift = [SsCtrl]) and (Key = 46) then Key := 0;
end;

procedure TFrmCompAdd.edBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if edBusca.Text.Trim <> '' then
   begin
      if ((Key = VK_RETURN) or (Key = VK_TAB)) and (edBusca.Tag > 0) then btGerFilial.Click;

      if not CharInSet(TEdit(Sender).Text[1], ['0'..'9']) then
      begin
         if Length(TEdit(Sender).Text) = 1 then
            btBuscas('arqproduto',TLMDEdit(edBusca), 'IDProd','Despro','',Key);
      end else
      if (Key = VK_RETURN) or (Key = VK_TAB) then BuscaProd;
   end;
end;

procedure TFrmCompAdd.btGerFilialClick(Sender: TObject);
var
   auxVlrult,auxQtdest:Double;
   QueAuxi:TRESTDWClientSQL;
   QueEsto:TRESTDWClientSQL;
begin
   if AtivaAfterInsert then Exit;
   if (edBusca.Tag <= 0) and (not CharInSet(edBusca.Text[1], ['0'..'9'])) then Exit;
   if edBusca.Tag <= 0 then
      if not BuscaProd  then Exit;
   if not VeSeExiste then Exit;
   QueEsto := TRESTDWClientSQL.Create(nil);
   QueEsto.DataBase := DM.DWDataBase;
   QueEsto.SQL.Text := 'SELECT LOT.IDFilial,LOT.IDProd,SUM(LOT.Qtdest) AS Qtdest,PRO.PrecoFab FROM arqprodutolot LOT '+
   'LEFT JOIN arqproduto PRO ON LOT.IDProd = PRO.IDProd WHERE LOT.Qtdest > 0 AND LOT.IDProd = '+edBusca.Tag.ToString+' '+
   'GROUP BY LOT.IDProd,LOT.IDFilial ORDER BY LOT.IDFIlial';
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   MemPedFilial.Open;
   try
      QueEsto.Open;
      QueAuxi.SQL.Text := 'SELECT IDFilial,Nomfil FROM arqfilial WHERE IndAtivo';
      QueAuxi.Open;
      while not QueAuxi.Eof do
      begin
         if QueEsto.Locate('IDFilial',QueAuxi.FieldByName('IDFilial').AsInteger,[]) then
         begin
            auxVlrult := QueEsto.FieldByName('PrecoFab').AsFloat;
            auxQtdest := QueEsto.FieldByName('Qtdest').AsFloat;
         end else
         begin
            auxVlrult := 0.00;
            auxQtdest := 0.00;
         end; //if

         MemPedFilial.Append;
         MemPedFilialIDFilial.Value := QueAuxi.FieldByName('IDFilial').AsInteger;
         MemPedFilialNomfil.Value   := QueAuxi.FieldByName('Nomfil').AsString;
         MemPedFilialQtdest.Value   := auxQtdest;
         MemPedFilialVlrult.Value   := auxVlrult;
         MemPedFilialQtdped.Value   := 0.00;
         MemPedFilial.Post;
         QueAuxi.Next;
      end; //while
      MemPedFilial.First;
      AtivaAfterInsert := True;
      DBGrid1.SelectedField := MemPedFilialQtdped;
   finally
      QueEsto.Close;
      FreeAndNil(QueEsto);
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmCompAdd.btSalvarClick(Sender: TObject);
var
   acReg:Integer;
   QueIncl:TRESTDWClientSQL;
begin
   if MemPedFilial.IsEmpty then Exit;
   if MemPedFilial.State in dsEditModes then MemPedFilial.Post;
   if MostraMsg('Confirmação','Confirma geração dos itens de compras para este produto?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueIncl.DataBase := DM.DWDataBase;
   QueIncl.SQL.Text := 'INSERT INTO arqcompraite (IDComp,IDProd,IDFilial,Qtdped,Qtdest,Vlrult) VALUES ';
  
   MemPedFilial.DisableControls;
   try
      try
         acReg := 0;
         MemPedFilial.First;      
         while not MemPedFilial.Eof do
         begin
            if MemPedFilialQtdped.AsFloat > 0.00 then
            begin
               QueIncl.SQL.Add('('+
               recIDComp.ToString+','+
               edBusca.Tag.ToString+','+
               MemPedFilialIDFilial.AsString+','+
               FormatDouble(MemPedFilialQtdped.AsFloat,11,2)+','+
               FormatDouble(MemPedFilialQtdest.AsFloat,11,2)+','+
               FormatDouble(MemPedFilialVlrult.AsFloat,11,2)+'),');
               Inc(acReg);
            end; //if
            MemPedFilial.Next;
         end; //while
            
         if acReg > 0 then
         begin
            QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+';';
            QueIncl.ExecSQL;
         end;
         MemPedFilial.Close;
         Self.Close;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar gerar itens manuais no pedido de compras uCompAddIt -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível gerar esse novo item!', mtError, [mbOk]);
         end;
      end;
   finally
      MemPedFilial.EnableControls;
      FreeAndNil(QueIncl);
   end;
  
end;

function TFrmCompAdd.VeSeExiste:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result := False;
   if edBusca.Tag <= 0 then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT IDProd FROM arqcompraite WHERE IDComp = '+recIDComp.ToString+' AND IDProd = '+edBusca.Tag.ToString;
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         MostraMsg('Aviso', 'Produto já consta no pedido!', mtWarning, [mbOk]);
         Exit;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   Result := True;
end;

function TFrmCompAdd.BuscaProd:Boolean;
var
   QueAuxi:TRESTDWClientSQL;
begin
   Result  := False;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      if Length(edBusca.Text.Trim) <= 10 then
           QueAuxi.SQL.Text := 'SELECT IDProd,Despro FROM arqproduto WHERE IDProd = '+OnlyNumbers(edBusca.Text)
      else QueAuxi.SQL.Text := 'SELECT EAN.IDProd,PRO.Despro FROM arqprodutoean EAN LEFT JOIN arqproduto PRO ON EAN.IDProd = PRO.IDProd WHERE EAN.CodEAN = '+Aspas(OnlyNumbers(edBusca.Text));
      QueAuxi.Open;
      if QueAuxi.IsEmpty then
      begin
         MostraMsg('Aviso', 'Produto não encontrado!', mtWarning, [mbOk]);
         edBusca.Tag  := 0;
         edBusca.Text := '';
         Exit;
      end else
      begin
         edBusca.Tag  := QueAuxi.FieldByName('IDProd').AsInteger;
         edBusca.Text := QueAuxi.FieldByName('Despro').AsString;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   Result := True;
end;

procedure TFrmCompAdd.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompAdd.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if MemPedFilial.Active then
   begin
      if MemPedFilial.IsEmpty then Exit;
      if MostraMsg('Confirmação','Desconsiderar a geração de compras para esse produto ?', mtConfirmation,[mbYes, mbNo]) = mrYes then 
           CanClose := True
      else CanClose := False;
   end; //if
end;

procedure TFrmCompAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if MemPedFilial.Active then MemPedFilial.Close;
   Action := TCloseAction.caFree;
end;

end.
