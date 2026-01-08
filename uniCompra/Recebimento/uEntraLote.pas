unit uEntraLote;

interface

uses
   Winapi.Windows, System.SysUtils, System.Variants, Vcl.Dialogs,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Data.DB,
   Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, LMDBaseControl, LMDLabel,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, Vcl.Mask,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDCustomBevelPanel, AdvGlowButton, MarcLib, uRESTDWBasicDB,
   uRESTDWBasicTypes, Vcl.StdCtrls, RxToolEdit, RxDBCtrl, MemDS,
   VirtualTable, Winapi.Messages;

type
 TFrmEntLotes = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    DBGrid1: TDBGrid;
    SouEntraLot: TDataSource;
    MemEntraLot: TVirtualTable;
    MemEntraLotNrolot: TWideStringField;
    MemEntraLotDatfab: TDateField;
    MemEntraLotDatven: TDateField;
    MemEntraLotQtdrec: TFloatField;
    MemEntraLotIndDel: TBooleanField;
    LMDLabel2: TLMDLabel;
    MemEntraLotQtdrecOld: TFloatField;
    MemEntraLotcAgreg: TWideStringField;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    MemEntraLotIndNew: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabTipProSerAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure MemEntraLotAfterInsert(DataSet: TDataSet);
    procedure MemEntraLotBeforePost(DataSet: TDataSet);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBDateEdit1Exit(Sender: TObject);
    procedure DBDateEdit2Exit(Sender: TObject);
    procedure MemEntraLotAfterPost(DataSet: TDataSet);
 private
    { Private declarations }
    Salvou:Boolean;
 public
    { Public declarations }
    recMemTable:TVirtualTable;
    recIDRec,recNroite,recIDProd,recIDFilial,recIDPess:Integer;
 end;

var
   FrmEntLotes: TFrmEntLotes;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmEntLotes.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmEntLotes.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   Top := Top - 20;
   Salvou := True;
   MemEntraLot.BeforePost := nil;
   SouEntraLot.Enabled    := False;
   if not recMemTable.IsEmpty then MemEntraLot.Assign(recMemTable);
   MemEntraLot.Open;
   if (recNroite > 0) and recMemTable.IsEmpty then
   begin
      QueAuxi := TRESTDWClientSQL.Create(nil);
      QueAuxi.DataBase := DM.DWDataBase;
      try
         try
            QueAuxi.SQL.Text :=
            'SELECT * FROM arqcomprareclot WHERE IDRec = '+recIDRec.ToString+' AND Nroite = '+recNroite.ToString+' ORDER BY Nrolot';
            QueAuxi.Open;
            with QueAuxi do
            begin
               while not Eof do
               begin
                  MemEntraLot.Append;
                  MemEntraLotNrolot.Value := FieldByName('Nrolot').AsString;
                  MemEntraLotDatfab.Value := FieldByName('Datfab').AsDateTime;
                  MemEntraLotDatven.Value := FieldByName('Datven').AsDateTime;
                  MemEntraLotcAgreg.Value := FieldByName('cAgreg').AsString;
                  MemEntraLotQtdrec.Value := FieldByName('Qtdrec').AsFloat;
                  MemEntraLotIndNew.Value := 'N';
                  MemEntraLotQtdrecOld.Value := FieldByName('Qtdrec').AsFloat;
                  MemEntraLot.Post;
                  Next;
               end; //while
            end; //with
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar abrir arqcomprarecites -> '+E.Message);
               MostraMsg('Erro', 'Não foi possível conectar ao servidor!', mtError, [mbOk]);
               PostMessage(Self.Handle, WM_CLOSE, 0, 0);
               Exit;
            end;
         end;
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end;
   MemEntraLot.BeforePost := MemEntraLotBeforePost;
   if MemEntraLot.IsEmpty then MemEntraLot.Append;
   SouEntraLot.Enabled := True;
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 5;
   DBGrid1.Width := DBGrid1.Width - 5;
   DBGrid1.Width := DBGrid1.Width + 5;
   DBGrid1.SetFocus;
end;

procedure TFrmEntLotes.MemEntraLotAfterInsert(DataSet: TDataSet);
begin
   MemEntraLotIndNew.Value    := 'S';
   MemEntraLotIndDel.Value    := False;
   MemEntraLotQtdRecOld.Value := 0.00;
end;

procedure TFrmEntLotes.MemEntraLotAfterPost(DataSet: TDataSet);
var
   TempTable:TVirtualTable;
begin
   TempTable := TVirtualTable.Create(nil);
   try
      TempTable.Assign(MemEntraLot);
      TempTable.Open;
      TempTable.First;
      while not TempTable.Eof do
      begin
         if (TempTable.FieldByName('Nrolot').AsString = MemEntraLotNrolot.AsString) and (TempTable.RecNo <> MemEntraLot.RecNo) then
         begin
            MostraMsg('Aviso','Número de Lote já usado nessa entrada.', mtWarning, [mbOk]);
            MemEntraLot.Delete;
            DBGrid1.SelectedField := MemEntraLotNrolot;
            Exit;
         end;
         TempTable.Next;
      end; //while
      Salvou := True;
   finally
      TempTable.Close;
      FreeAndNil(TempTable);
   end;
end;

procedure TFrmEntLotes.MemEntraLotBeforePost(DataSet: TDataSet);
var
   auxNrolot:String;
begin
   Salvou := False;
   auxNrolot := MemEntraLotNrolot.AsString.Trim;
   if auxNrolot.IsEmpty then
   begin
      Salvou := True;
      Abort;
      Exit;
   end;
   if (MemEntraLotIndNew.Value = 'N') and (MemEntraLotNrolot.Value <> MemEntraLotNrolot.OldValue) then
   begin
      MostraMsg('Aviso','Não pode alterar número de Lote após salvamento.', mtWarning, [mbOk]);
      MemEntraLotNrolot.Value := MemEntraLotNrolot.OldValue;
      DBGrid1.SelectedField   := MemEntraLotNrolot;
      Abort;
      Exit;
   end; //if

   if MemEntraLotNrolot.AsString.Trim = '' then
      MemEntraLotNrolot.AsString := 'S/L';

   if MemEntraLotNrolot.AsString.ToUpper <> 'S/L' then
   begin
      if MemEntraLotDatfab.Value <= 0 then
      begin
         MostraMsg('Aviso','Favor entrar com a Data de Fabricação.', mtWarning, [mbOk]);
         DBGrid1.SelectedField := MemEntraLotDatfab;
         Abort;
         Exit;
      end;
      if MemEntraLotDatven.Value <= 0 then
      begin
         MostraMsg('Aviso','Favor entrar com a Data de Vencimento.', mtWarning, [mbOk]);
         DBGrid1.SelectedField := MemEntraLotDatven;
         Exit;
      end;
   end; //if

   if MemEntraLotQtdrec.Value <= 0.00 then
   begin
      MostraMsg('Aviso', 'Favor entrar com a Quantidade.', mtWarning, [mbOk]);
      DBGrid1.SelectedField := MemEntraLotQtdrec;
      Abort;
      Exit;
   end;

   Salvou := True;
end;

procedure TFrmEntLotes.TabTipProSerAfterPost(DataSet: TDataSet);
begin
   if Trim(MemEntraLotNrolot.Value) = '' then MemEntraLot.Delete;
end;

procedure TFrmEntLotes.DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
   if (gdFocused in State) or (gdSelected in State) then
   begin
      (Sender as TDBGrid).Canvas.Font.Color := clBlack;
      if Column.ID = 1 then
      begin
         if gdFocused in State then
         begin
            with DBDateEdit1 do
            begin
               Left   := Rect.Left   + DBGrid1.Left + 4;
               Top    := Rect.Top    + DBGrid1.Top + 3;
               Width  := Rect.Right  - Rect.Left - 4;
               Height := Rect.Bottom - Rect.Top - 15;
               ButtonWidth := 19;
               Visible := True;
               DBDateEdit1.SetFocus;
            end; // with
            if DBDateEdit2.Visible then DBDateEdit2.Visible := False;
            (Sender as TDBGrid).Canvas.Brush.Color := clWhite;
         end; // if
      end else
      if Column.ID = 2 then
      begin
         if gdFocused in State then
         begin
            with DBDateEdit2 do
            begin
               Left    := Rect.Left + DBGrid1.Left + 4;
               Top     := Rect.Top  + DBGrid1.Top  + 3;
               Width   := Rect.Right  - Rect.Left  - 4;
               Height  := Rect.Bottom - Rect.Top   - 15;
               Visible := True;
               ButtonWidth := 19;
               DBDateEdit2.SetFocus;
            end; //with
            if DBDateEdit1.Visible then DBDateEdit1.Visible := False;
            (Sender as TDBGrid).Canvas.Brush.Color := clWhite;
         end; //if
      end else
      begin
         (Sender as TDBGrid).Canvas.Brush.Color := $00ECF2FF;
         if DBDateEdit1.Visible then DBDateEdit1.Visible := False;
         if DBDateEdit2.Visible then DBDateEdit2.Visible := False;
      end;
   end; // if
   (Sender as TDBGrid).Canvas.FillRect(Rect);
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID < 5 then DBGrid1.Canvas.TextRect(Rect, Rect.Left + 3, Rect.Top + 5, Column.Field.DisplayText)
   else if Column.ID = 5 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left + 3, Rect.Top + 3, 0);
end;

procedure TFrmEntLotes.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F2 then btFechar.Click
end;

procedure TFrmEntLotes.DBDateEdit1Exit(Sender: TObject);
begin
   DBGrid1.SelectedField := MemEntraLotDatven;
   DBGrid1.SetFocus;
end;

procedure TFrmEntLotes.DBDateEdit2Exit(Sender: TObject);
begin
   DBGrid1.SelectedField := MemEntraLotQtdrec;
   DBGrid1.SetFocus;
end;

procedure TFrmEntLotes.DBGrid1CellClick(Column: TColumn);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if MemEntraLot.RecordCount > 0 then
   begin
      if Column.ID = 5 then
      begin
         if MemEntraLot.State <> dsInsert then
         begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            QueAuxi.DataBase := DM.DWDataBase;
            try
               try
                  QueAuxi.SQL.Text := 'SELECT 1 FROM arqpedidoite WHERE IDProd = '+recIDProd.ToString+' AND Nrolot = '+Aspas(MemEntraLotNrolot.AsString);
                  QueAuxi.Open;
                  if not QueAuxi.IsEmpty then
                  begin
                     MostraMsg('Não pode excluir', 'Este Produto/Lote já possui saídas.', mtInformation, [mbOk]);
                     Exit;
                  end;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir, não foi possível abrir arqpedidoite -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível excluir o lote!', mtError, [mbOk]);
                     Exit;
                  end;
               end; //try
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end; //if
         if MostraMsg('Confirmação', 'Confirma eliminação deste Lote?',mtConfirmation, [mbYes, mbNo]) = mrYes then
         begin
            if MemEntraLot.State <> dsInsert then
            begin
               MemEntraLot.Edit;
               MemEntraLotIndDel.Value := True;
               MemEntraLot.Post;
            end
            else MemEntraLot.Cancel;
         end; //if
      end; //if
      DBGrid1.SelectedField := MemEntraLotQtdrec;
   end; //if
end;

procedure TFrmEntLotes.btFecharClick(Sender: TObject);
begin
   if MemEntraLot.State in dsEditModes then
   begin
      if MemEntraLotQtdrec.AsFloat > 0.00 then
      begin
         MemEntraLot.Post;
         if not Salvou then Exit;
      end
      else MemEntraLot.Cancel;
   end;
   Close;
end;

procedure TFrmEntLotes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ModalResult := mrCancel;
   //MemEntraLot.Close;
end;

end.

