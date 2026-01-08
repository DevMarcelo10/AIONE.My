unit uCompraCad;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDLabel, RxToolEdit, RxDBCtrl,
   Data.DB, LMDBaseControl, LMDBaseLabel, Vcl.DBGrids, LMDBaseGraphicControl, Vcl.Grids,
   LMDCustomLabel, LMDCustomBevelPanel, AdvGlowButton, MarcLib, Vcl.StdCtrls, LMDSimplePanel,
   LMDControl, LMDCustomControl, LMDCustomPanel, AdvSmoothPanel, Vcl.ExtCtrls, LMDEdit,
   uRESTDWBasicTypes, Vcl.Imaging.PngImage, FireDAC.Stan.Intf, FireDAC.Stan.Option, AdvEdit,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, uRESTDWBasicDB, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, AdvEdBtn, Vcl.Clipbrd, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  THackDBGrid = class(TDBGrid);

  TFrmCompraCad = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelPromo: TLMDSimplePanel;
    PanelBas: TAdvSmoothPanel;
    PanelGrid: TAdvSmoothPanel;
    LMDLabel17: TLMDLabel;
    TabCompraIte: TRESTDWClientSQL;
    SouCompraIte: TDataSource;

    btFechar: TAdvGlowButton;
    TabCompraSub: TRESTDWClientSQL;
    SouCompraMol: TDataSource;
    PanelBack: TAdvSmoothPanel;
    PanelGrids: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    LMDSimplePanel2: TLMDSimplePanel;
    edBusFilial: TAdvEditBtn;
    edBusFor: TAdvEditBtn;
    edGrupo: TAdvEditBtn;
    btAnaIA: TAdvGlowButton;
    btAgruSubs: TAdvGlowButton;
    edBusca: TAdvEditBtn;
    edSubGru: TAdvEditBtn;
    btFiltrar: TAdvGlowButton;
    btAddItns: TAdvGlowButton;
    TabCompraIteIDComp: TIntegerField;
    TabCompraIteNroite: TSmallintField;
    TabCompraIteIDProd: TIntegerField;
    TabCompraIteIDFilial: TIntegerField;
    TabCompraIteQtddemIA: TFloatField;
    TabCompraIteQtdped: TFloatField;
    TabCompraIteQtdpedRec: TFloatField;
    TabCompraIteVlrult: TFloatField;
    TabCompraIteQtdest: TFloatField;
    TabCompraIteIndPed: TBooleanField;
    TabCompraIteDespro: TWideStringField;
    TabCompraIteIDFabr: TIntegerField;
    TabCompraIteIDGruSub: TIntegerField;
    TabCompraIteCodEAN: TWideStringField;
    TabCompraIteDesgru: TWideStringField;
    TabCompraIteNompes: TWideStringField;
    TabCompraSubIDComp: TIntegerField;
    TabCompraSubIDFilial: TIntegerField;
    TabCompraSubIDSubs: TIntegerField;
    TabCompraSubQtddemIA: TFloatField;
    TabCompraSubQtdped: TFloatField;
    TabCompraSubVlrult: TFloatField;
    TabCompraSubQtdest: TFloatField;
    TabCompraSubDesSubs: TWideStringField;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure TabCompraIteBeforeInsert(DataSet: TDataSet);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btFecharClick(Sender: TObject);
    procedure edBusFilialClickBtn(Sender: TObject);
    procedure edBusFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBusForClickBtn(Sender: TObject);
    procedure edBusForKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edGrupoClickBtn(Sender: TObject);
    procedure edGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSubGruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSubGruClickBtn(Sender: TObject);
    procedure btAnaIAClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edBuscaChange(Sender: TObject);
    procedure btFiltrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btAddItnsClick(Sender: TObject);
  private
    { Private declarations }
    SQLBase:String;
    procedure AtuDBGrid;
    procedure EditItem;
   public
    { Public declarations }
    recIDComp:Integer;
  end;

var
   FrmCompraCad: TFrmCompraCad;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uCompIte, uCompCriIA, uCompIteFil, uCompAddIt;

procedure TFrmCompraCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCompraCad.FormShow(Sender: TObject);
var
   I:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         SQLBase :=
         'SELECT ITE.IDComp,ITE.IDFilial,ITE.Nroite,ITE.IDProd,ITE.Indped,SUM(ITE.QtddemIA) AS QtddemIA,SUM(ITE.Qtdped) AS Qtdped,'+
         'SUM(ITE.QtdpedRec) AS QtdpedRec,SUM(ITE.Qtdest) AS Qtdest,ITE.Vlrult,PRO.Despro,PRO.IDFabr,PRO.IDGruSub,EAN.CodEAN,GRU.Desgru,'+
         'PES.Nompes FROM arqcompraite ITE LEFT JOIN arqproduto PRO ON ITE.IDProd = PRO.IDProd LEFT JOIN arqgrupo GRU ON '+
         'PRO.IDGrupo = GRU.IDGrupo LEFT JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess LEFT JOIN (SELECT IDProd,MIN(CodEAN) AS CodEAN '+
         'FROM arqprodutoean GROUP BY IDProd) EAN ON PRO.IDProd = EAN.IDProd WHERE IDComp = '+recIDComp.ToString+' ';
         TabCompraIte.SQL.Text := SQLBase + ' GROUP BY IDProd ORDER BY PRO.Despro';
         TabCompraIte.Open;
         //TabCompraSub.SQL.Text := 'SELECT arqcomprasub.*,arqsubstancia.DesSubs FROM arqcomprasub '+
         //'LEFT JOIN arqsubstancia ON arqcomprasub.IDSubs = arqsubstancia.IDSubs WHERE IDComp = '+recIDComp.ToString;
         //TabCompraSub.Open;
      except
         on E:Exception do
         begin
            if TabCompraIte.Active  then TabCompraIte.Close;
            if DM.DWDataBase.Active then DM.DWDataBase.Close;
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar abrir TabCompras -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível conectar ao servidor!', mtError, [mbOk]);
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   AtuDBGrid;
end;

procedure TFrmCompraCad.TabCompraIteBeforeInsert(DataSet: TDataSet);
begin
   Abort;
end;

procedure TFrmCompraCad.AtuDBGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
end;

procedure TFrmCompraCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self,'In', 8);
end;

procedure TFrmCompraCad.btFiltrarClick(Sender: TObject);
var
   auxFiltro:String;
begin
   auxFiltro := '';
   if edBusFilial.Text.Trim = '' then edBusFilial.Tag := 0;
   if edBusFor.Text.Trim = ''    then edBusFor.Tag    := 0;
   if edGrupo.Text.Trim = ''     then edGrupo.Tag     := 0;
   if edSubGru.Text.Trim = ''    then edSubGru.Tag    := 0;
   if edBusFilial.Tag > 0 then auxFiltro := auxFiltro + ' AND IDFilial = '+edBusFilial.Tag.ToString;
   if edBusFor.Tag    > 0 then auxFiltro := auxFiltro + ' AND IDFabr = '  +edBusFor.Tag.ToString;
   if edGrupo.Tag     > 0 then auxFiltro := auxFiltro + ' AND IDGrupo = ' +edGrupo.Tag.ToString;
   if edSubGru.Tag    > 0 then auxFiltro := auxFiltro + ' AND IDGruSub = '+edSubGru.Tag.ToString;
   TabCompraIte.Close;
   TabCompraIte.SQL.Text := SQLBase + auxFiltro + ' GROUP BY IDProd ORDER BY PRO.Despro';
   TabCompraIte.Open;
   AtuDBGrid;
end;

procedure TFrmCompraCad.btAddItnsClick(Sender: TObject);
begin
   try
      FrmCompAdd := TFrmCompAdd.Create(PanelBack);
      FrmCompAdd.recIDComp := TabCompraIteIDComp.Value;
      FrmCompAdd.ShowModal;
   finally
      if FrmCompAdd.edBusca.Tag > 0 then
      begin
         TabCompraIte.DisableControls;
         TabCompraIte.Refresh;
         TabCompraIte.Locate('IDProd',FrmCompAdd.edBusca.Tag,[]);
         TabCompraIte.EnableControls;
      end; //if
      AtuDBGrid;
      FrmCompAdd := nil;
   end;
end;

procedure TFrmCompraCad.btAnaIAClick(Sender: TObject);
begin
   try
      FrmCompCIA := TFrmCompCIA.Create(PanelBas);
      FrmCompCIA.recIDComp := recIDComp;
      FrmCompCIA.ShowModal;
   finally
      FrmCompCIA := nil;
   end;
end;

// --------------- Exclusão de Todo Pedido de Compra ------------ //
procedure TFrmCompraCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   try
      QueAuxi := TRESTDWClientSQL.Create(nil);
      with QueAuxi do
      begin
         DataBase := DM.DWDataBase;
         if MostraMsg('Confirmação', 'Deseja realmente excluir esta compra?', mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            try
               SQL.Clear;
               SQL.Add('DELETE FROM arqcompra WHERE IDComp = '   +recIDComp.ToString+';');
               SQL.Add('DELETE FROM arqcompraite WHERE IDComp = '+recIDComp.ToString+';');
               SQL.Add('DELETE FROM arqcomprasub WHERE IDComp = '+recIDComp.ToString+';');
               ExecSQL;
               Self.Close;
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir registro do aquivo: arqcompra, IDComp = '+recIDComp.ToString+' -> '+E.Message);
                  MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                  Exit;
               end;
            end;
            SalvaLog(USUARIO, PastaLog, 'EXCLUSAO arqcompra, IDComp = '+recIDComp.ToString);
         end; //if
      end; //with
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmCompraCad.DBGrid1CellClick(Column: TColumn);
var
   auxNroIte:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabCompraIte.IsEmpty then Exit;

   if (Column.ID = 7) or (Column.ID >= 9) then
   begin
      if Column.ID = 11 then
      begin
         if MostraMsg('Confirmação','Confirma exclusão deste item do pedido?', mtConfirmation,[mbYes, mbNo]) = mrYes then
         begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            try
               try
                  QueAuxi.DataBase := DM.DWDataBase;
                  QueAuxi.SQL.Text := 'DELETE FROM arqcompraite WHERE IDComp = '+recIDComp.ToString+' AND IDProd = '+TabCompraIteIDProd.AsString;
                  QueAuxi.ExecSQL;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir registro do aquivo: arqcompraite: IDComp = '+recIDComp.ToString+', IDProd = '+TabCompraIteIDProd.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
            finally
               FreeAndNil(QueAuxi);
            end;
            TabCompraIte.Refresh;
         end; //if
      end else
      if Column.ID = 9 then
      begin
         try
            FrmCompIte := TFrmCompIte.Create(Application);
            FrmCompIte.recIDComp := TabCompraIteIDComp.AsString;
            FrmCompIte.recNroIte := TabCompraIteNroite.AsString;
            FrmCompIte.recIDProd := TabCompraIteIDProd.AsString;
            FrmCompIte.recQtdped := TabCompraIteQtdped.AsFloat;
            FrmCompIte.ShowModal;
         finally
            FrmCompIte := nil;
            TabCompraIte.DisableControls;
            auxNroIte := TabCompraIteNroite.AsInteger;
            TabCompraIte.Refresh;
            TabCompraIte.Locate('NroIte',auxNroIte,[]);
            TabCompraIte.EnableControls;
            AtuDBGrid;
         end; //try
      end else
      if (Column.ID = 7) or (Column.ID = 10) then EditItem;
      DBGrid1.SelectedField := TabCompraIteVlrult;
   end; //if
end;

procedure TFrmCompraCad.EditItem;
var
   antIDProd:Integer;
begin
   try
      FrmCompFil := TFrmCompFil.Create(PanelBas);
      FrmCompFil.recIDComp := recIDComp;
      FrmCompFil.recIDProd := TabCompraIteIDProd.AsInteger;
      FrmCompFil.ShowModal;
   finally
      antIDProd := TabCompraIteIDProd.AsInteger;
      TabCompraIte.Refresh;
      TabCompraIte.Locate('IDProd',antIDProd,[]);
      FrmCompFil := nil;
   end;
end;

procedure TFrmCompraCad.DBGrid1DblClick(Sender: TObject);
var
   Grid:TDBGrid;
   CurrentValue:String;
begin
   Grid := Sender as TDBGrid;
   if Assigned(Grid.SelectedField) and (Grid.DataSource.DataSet.Active) then
   begin
      if (Grid.SelectedField.Name = 'TabCompraIteIDProd') or (Grid.SelectedField.Name = 'TabCompraIteCodEAN') then
      begin
         CurrentValue     := Grid.SelectedField.AsString;
         Clipboard.AsText := CurrentValue;
      end;
   end; //if
end;

procedure TFrmCompraCad.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Column.FieldName = 'Qtdped' then (Sender as TDBGrid).Canvas.Brush.Color := $00F4F8FF;
   if ((THackDBGrid(DBGrid1).DataLink.ActiveRecord + 1 = THackDBGrid(DBGrid1).Row) and (not (TabCompraIte.State in dsEditModes))) or (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Brush.Color := $00CCDDFF;
      (Sender as TDBGrid).Canvas.Font.Color  := clBlack;
      (Sender as TDBGrid).Canvas.FillRect(Rect);
   end;
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID =  9 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+5, 1) else
   if Column.ID = 10 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+5, Rect.Top+4, 6) else
   if Column.ID = 11 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+4, Rect.Top+4, 0) else
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);
end;

procedure TFrmCompraCad.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = 13 then EditItem;
   if (Shift = [SsCtrl]) and (Key = 46) then Key := 0;
end;

procedure TFrmCompraCad.DBGrid1TitleClick(Column: TColumn);
begin
   TabCompraIte.IndexFieldNames := Column.FieldName;
end;

procedure TFrmCompraCad.edBuscaChange(Sender: TObject);
var
   NumeroInt:Integer;
   CampoBusca,ValorBusca:String;
begin
   ValorBusca := Trim(TEdit(Sender).Text);
   if TryStrToInt(ValorBusca, NumeroInt) then
        CampoBusca := iif(Length(valorBusca) <= 8,'IDProd','CodEAN')
   else CampoBusca := 'Despro';
   if not ValorBusca.IsEmpty then TabCompraIte.Locate(CampoBusca, ValorBusca, [loPartialKey]);
end;

procedure TFrmCompraCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = 107) and (ssAlt in Shift) then
   begin
      ShowMessage('"Alt" com "+" foi pressionado');
   end;
end;

procedure TFrmCompraCad.edBusFilialClickBtn(Sender: TObject);
begin
   btBuscas('arqfilial',TLMDEdit(edBusFilial), 'IDFilial','Nomfil','',0);
end;

procedure TFrmCompraCad.edBusFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edBusFilial), 'IDFilial','Nomfil','',Key);
end;

procedure TFrmCompraCad.edBusForClickBtn(Sender: TObject);
begin
   btBuscas('arqpessoa',TLMDEdit(edBusFor), 'IDPess','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',0);
end;

procedure TFrmCompraCad.edBusForKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(edBusFor), 'IDPess','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',Key);
end;

procedure TFrmCompraCad.edGrupoClickBtn(Sender: TObject);
begin
   btBuscas('arqgrupo',TLMDEdit(edGrupo), 'IDGrupo','Desgru','',0);
end;

procedure TFrmCompraCad.edGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgrupo',TLMDEdit(edGrupo), 'IDGrupo','Desgru','',Key);
end;

procedure TFrmCompraCad.edSubGruClickBtn(Sender: TObject);
begin
   btBuscas('arqgruposub',TLMDEdit(edSubGru), 'IDGruSub','DesgruSub','',0);
end;

procedure TFrmCompraCad.edSubGruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgruposub',TLMDEdit(edSubGru), 'IDGruSub','DesgruSub','',Key);
end;

procedure TFrmCompraCad.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompraCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabCompraIte.Active  then TabCompraIte.Close;
   if DM.DWDataBase.Active then DM.DWDataBase.Close;
   FadeInOut(Self,'Out',10);
   Self := nil;
end;

end.
