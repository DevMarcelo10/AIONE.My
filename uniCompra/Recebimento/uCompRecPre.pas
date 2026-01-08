unit uCompRecPre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDControl, Data.DB,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.Grids,
  Vcl.DBGrids, LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,FireDAC.Stan.Error, FireDAC.DatS, MarcLib,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uRESTDWBasicTypes, uRESTDWBasicDB, uWaitForm;

type
  TFrmCompRecPre = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    btFechar: TAdvGlowButton;
    dgPrecificacao: TDBGrid;
    PanelSelecao: TLMDSimplePanel;
    ckTodos: TLMDCheckBox;
    ckAlta: TLMDCheckBox;
    ckBaixa: TLMDCheckBox;
    ckItePMC: TLMDCheckBox;
    btSeleciona: TAdvGlowButton;
    TabPrec: TRESTDWClientSQL;
    TabPrecIDRec: TIntegerField;
    TabPrecNroite: TSmallintField;
    TabPrecIDProd: TIntegerField;
    TabPrecDespro: TWideStringField;
    TabPrecVlruni: TFloatField;
    TabPrecQuantProdConf: TFloatField;
    TabPrecVlrVendaAtual: TFloatField;
    TabPrecVlrPerMargem: TFloatField;
    TabPrecVlrVendaSuger: TFloatField;
    TabPrecVlrPerVariacao: TFloatField;
    TabPrecVlrPMC: TFloatField;
    TabPrecPerICMS: TFloatField;
    TabPrecIndSel: TWideStringField;
    TabPrecVlrUniFinCalc: TFloatField;
    TabPrecVlrDesc: TFloatField;
    TabPrecVlrST: TFloatField;
    TabPrecIDFabr: TIntegerField;
    TabPrecNompes: TWideStringField;
    TabPrecVlrPreComp: TFloatField;
    TabPrecPrecoFab: TFloatField;
    TabPrecConfAltPre: TWideStringField;
    TabPrecVlrIPI: TFloatField;
    TabPrecVlrOut: TFloatField;
    TabPrecVlrCustoMed: TFloatField;
    TabPrecQtdFrac: TFloatField;
    TabPrecVlrVendaSugerOrig: TFloatField;
    TabPrecPrecoFabOrig: TFloatField;
    SouPrecificacao: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TabPrecAfterPost(DataSet: TDataSet);
    procedure TabPrecCalcFields(DataSet: TDataSet);
    procedure dgPrecificacaoCellClick(Column: TColumn);
    procedure dgPrecificacaoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dgPrecificacaoExit(Sender: TObject);
    procedure dgPrecificacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ckTodosClick(Sender: TObject);
    procedure ckAltaClick(Sender: TObject);
    procedure ckItePMCClick(Sender: TObject);
    procedure btSelecionaClick(Sender: TObject);
    procedure ckBaixaClick(Sender: TObject);
  private
    { Private declarations }
    auxControlPre:Boolean;
    procedure GravaMargem(Origem: Integer);
    procedure SelecionaPro(Opcao: Integer);
  public
    { Public declarations }
    recItIDRec:Integer;
  end;

var
  FrmCompRecPre: TFrmCompRecPre;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmCompRecPre.FormShow(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      QueAuxi.SQL.Text := 'SELECT ProdExist FROM arqcomprarecite WHERE IDRec = '+recItIDRec.ToString+' AND ProdExist = 0';
      QueAuxi.Open;
      if QueAuxi.RecordCount > 0 then
      begin
         MostraMsg('Aviso','Existem produtos que não foram cadastrados. Favor cadastrar todos os produtos primeiramente', mtWarning, [mbOk]);
         Exit;
      end;// if
      TabPrec.Open;
      dgPrecificacao.SelectedField := TabPrecIDProd;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
   auxControlPre := True;
   TStringGrid(dgPrecificacao).DefaultRowHeight := BaseRowHeight - 3;
   AjustaDBGrid(dgPrecificacao);
   dgPrecificacao.SetFocus;
end;

procedure TFrmCompRecPre.TabPrecAfterPost(DataSet: TDataSet);
begin
   if auxControlPre then GravaMargem(1);
   auxControlPre := True;
end;

procedure TFrmCompRecPre.GravaMargem(Origem:Integer);
var
   vErro:String;
   auxPos:TBookmark;
   QueAuxi,QueItem,QuePara:TRESTDWClientSQL;
   auxMarge,auxVlrVenda,auxVlrUni,auxPrecoFab:Double;
begin
   ShowWait('Aguarde...', Self);
   auxPrecoFab := 0;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueItem := TRESTDWClientSQL.Create(nil);
   QuePara := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueItem.DataBase := DM.DWDataBase;
   QuePara.DataBase := DM.DWDataBase;
   try
      QueItem.SQL.Text := 'SELECT VlrPerMargem,VlrVendaSuger FROM arqcomprarecite WHERE '+
      'IDRec = '+TabPrecIDRec.AsString+' AND Nroite = '+TabPrecNroite.AsString+' AND IDProd = '+TabPrecIDProd.AsString;
      QueItem.Open;
      if origem = 1 then
      begin
         if (QueItem.FieldByName('VlrPerMargem').AsFloat = TabPrecVlrPerMargem.AsFloat) and
            (QueItem.FieldByName('VlrVendaSuger').AsFloat = TabPrecVlrVendaSuger.AsFloat) then Exit;
      end;

      if QueItem.FieldByName('VlrPerMargem').AsFloat <> TabPrecVlrPerMargem.AsFloat then
      begin
         if origem = 0 then
              auxMarge := QueItem.FieldByName('VlrPerMargem').AsFloat
         else auxMarge := TabPrecVlrPerMargem.AsFloat;
         auxVlrUni     := TabPrecVlrUniFinCalc.AsFloat;
         auxVlrVenda   := ((auxVlrUni * auxMarge) / 100) + auxVlrUni;
         try
            QueAuxi.SQL.Clear;
            QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET '+
            'VlrPerMargem = '+FormatDouble(auxMarge,11,4)+','+
            'VlrVendaSuger = '+FormatDouble(auxVlrVenda,11,4)+','+
            'PrecoFab = '+FormatDouble(auxPrecoFab,11,4)+
            ' WHERE IDRec = '+Aspas(IntToStr(TabPrecIDRec.AsInteger))+
            ' AND Nroite = '+Aspas(IntToStr(TabPrecNroite.AsInteger))+
            ' AND IDProd = '+Aspas(IntToStr(TabPrecIDProd.AsInteger));
            QueAuxi.ExecSQL(vErro);
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível alterar a margem de venda do produto na entrada da nota TabCompRecIt em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtError, [mbOk]);
               Exit;
            end;
         end;
      end; //if

      QuePara.Close;
      QuePara.SQL.Text := 'SELECT AlteraMargProdEnt FROM arqparametros';
      QuePara.Open;
      if QueItem.FieldByName('VlrVendaSuger').AsFloat <> TabPrecVlrVendaSuger.AsFloat then
      begin
         if origem = 0 then
              auxVlrVenda := QueItem.FieldByName('VlrVendaSuger').AsFloat
         else auxVlrVenda := TabPrecVlrVendaSuger.AsFloat;
         auxMarge  := TabPrecVlrPerMargem.AsFloat;
         auxVlrUni := TabPrecVlrUniFinCalc.AsFloat;
         if not (QuePara.FieldByName('AlteraMargProdEnt').AsBoolean) then
         begin
            auxPrecoFab := auxVlrVenda / (auxMarge / 100 + 1);
            try
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET '+
               'VlrVendaSuger = '+FormatDouble(auxVlrVenda,11,4)+','+
               'PrecoFab = '+FormatDouble(auxPrecoFab,11,4)+
               ' WHERE IDRec = '+Aspas(IntToStr(TabPrecIDRec.AsInteger))+
               ' AND Nroite = '+Aspas(IntToStr(TabPrecNroite.AsInteger))+
               ' AND IDProd = '+Aspas(IntToStr(TabPrecIDProd.AsInteger));
               QueAuxi.ExecSQL(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a margem de venda do produto na entrada da nota TabCompRecIt em uCompRec -> '+E.Message);
                  MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end;
         end else
         begin
            auxMarge := ((auxVlrVenda-auxVlrUni)/auxVlrUni)*100;
            try
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET '+
               'VlrPerMargem = '+FormatDouble(auxMarge,11,4)+','+
               'VlrVendaSuger = '+FormatDouble(auxVlrVenda,11,4)+
               ' WHERE IDRec = '+Aspas(IntToStr(TabPrecIDRec.AsInteger))+
               ' AND Nroite = '+Aspas(IntToStr(TabPrecNroite.AsInteger))+
               ' AND IDProd = '+Aspas(IntToStr(TabPrecIDProd.AsInteger));
               QueAuxi.ExecSQL(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a margem de venda do produto na entrada da nota TabCompRecIt em uCompRec -> '+E.Message);
                  MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end;
         end; //if
      end; //if

      if Origem = 1 then  // Margem alterada no Grid da Precificação. Grava a alteração no cadastro de produto
      begin
         try
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'UPDATE arqproduto SET Markup = '+FormatDouble(TabPrecVlrPerMargem.AsFloat,11,2)+
            ' WHERE IDProd = '+Aspas(IntToStr(TabPrecIDProd.AsInteger));
            QueAuxi.ExecSQL(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a margem de venda no produto na tabela de arqproduto em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;
      end; //if

      auxPos := TabPrec.GetBookmark;
      TabPrec.Close;
      TabPrec.Open;
      TabPrec.GotoBookmark(auxPos);
      TabPrec.FreeBookmark(auxPos);
   finally
      QueAuxi.Close;
      QueItem.Close;
      QuePara.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueItem);
      FreeAndNil(QuePara);
      HideWait;
   end;
end;

procedure TFrmCompRecPre.TabPrecCalcFields(DataSet: TDataSet);
begin
   TabPrecVlrUniFinCalc.AsFloat := (TabPrecVlruni.AsFloat - TabPrecVlrDesc.AsFloat)+TabPrecVlrST.AsFloat+TabPrecVlrIPI.AsFloat+TabPrecVlrOut.AsFloat;
end;

procedure TFrmCompRecPre.btSelecionaClick(Sender: TObject);
var
   vErro:sTRING;
   Index:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabPrec.IsEmpty then Exit;

   Index := dgPrecificacao.DataSource.DataSet.RecNo;
   TabPrec.Filtered := False;
   TabPrec.Filter   := 'IndSel = 1';
   TabPrec.Filtered := True;
   if TabPrec.RecordCount < 1 then
   begin
      MostraMsg('Aviso','Nenhm produto selecionado!',mtWarning, [mbOk]);
      TabPrec.Filtered := False;
      dgPrecificacao.DataSource.DataSet.RecNo := Index;
      dgPrecificacao.Refresh;
      Exit;
   end; //if

   if MostraMsg('Confirmação','Deseja confirmar as alterações feitas?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      try
         TabPrec.First;
         while not (TabPrec.Eof) do
         begin
            QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET ConfAltPre = '+Aspas('1')+
            ' WHERE IDRec = '+Aspas(IntToStr(TabPrecIDRec.AsInteger))+
            ' AND Nroite = '+Aspas(IntToStr(TabPrecNroite.AsInteger))+
            ' AND IDProd = '+Aspas(IntToStr(TabPrecIDProd.AsInteger));
            QueAuxi.ExecSQL(vErro);
            TabPrec.Next;
         end;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a opção de confirmar na precificação em TabPrec em uCompRec -> '+E.Message);
            MostraMsg('Erro','Não foi possível confirmar a gravação das alterações.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      TabPrec.Filtered := False;
      TabPrec.Close;
      TabPrec.Open;
      dgPrecificacao.DataSource.DataSet.RecNo := Index;
      dgPrecificacao.Refresh;
   end;
end;

procedure TFrmCompRecPre.ckTodosClick(Sender: TObject);
begin
   ckBaixa.Checked  := False;
   ckAlta.Checked   := False;
   ckItePMC.Checked := False;
   SelecionaPro(0);
end;

procedure TFrmCompRecPre.ckAltaClick(Sender: TObject);
begin
   ckTodos.Checked  := False;
   ckBaixa.Checked  := False;
   ckItePMC.Checked := False;
   SelecionaPro(1);
end;

procedure TFrmCompRecPre.ckBaixaClick(Sender: TObject);
begin
   ckTodos.Checked  := False;
   ckAlta.Checked   := False;
   ckItePMC.Checked := False;
   SelecionaPro(2);
end;

procedure TFrmCompRecPre.ckItePMCClick(Sender: TObject);
begin
   ckTodos.Checked := False;
   ckBaixa.Checked := False;
   ckAlta.Checked  := False;
   SelecionaPro(3);
end;

procedure TFrmCompRecPre.dgPrecificacaoCellClick(Column: TColumn);
var
   vErro:String;
   QueAuxi:TRESTDWClientSQL;
begin
   if TabPrec.RecordCount > 0 then
   begin
      if Column.FieldName = 'IndSel' then
      begin
         auxControlPre := False;
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            QueAuxi.DataBase := DM.DWDataBase;
            try
               QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET IndSel = '+Aspas(iif(TabPrecIndSel.AsString = '0','1','0'))+' '+
               'WHERE IDRec = '+TabPrecIDRec.AsString+' AND Nroite = '+TabPrecNroite.AsString+' AND IDProd = '+TabPrecIDProd.AsString;
               QueAuxi.ExecSQL(vErro);
            except
               on E:Exception do
               begin
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a coluna IndSel na precificação em TabPrec em uCompRec -> '+E.Message);
                  MostraMsg('Erro','Não foi possível gravar a alteração.'+#10+E.Message, mtWarning, [mbOk]);
                  Exit;
               end;
            end;
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
         TabPrec.Close;
         TabPrec.Open;
         dgPrecificacao.SelectedField := TabPrecIDProd;
      end; //if
   end; //if
   TabPrec.ApplyUpdates;
end;

procedure TFrmCompRecPre.dgPrecificacaoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if not (TabPrec.IsEmpty) then
   begin
      if (gdSelected in State) or (gdFocused in State) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
         TDBGrid(Sender).Canvas.Font.Color  := clBlack;
      end;
      if TabPrecVlrPerVariacao.AsFloat >= 0 then
         dgPrecificacao.Canvas.Brush.Color:= $00CBE1C6
      else dgPrecificacao.Canvas.Brush.Color:= $00CED8FF;
      TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

      if not Column.FieldName.IsEmpty then
      begin
         if Column.Alignment = taCenter       then
            (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+5, Column.Field.DisplayText)
         else
         if Column.Alignment = taRightJustify then
            (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+5, Column.Field.DisplayText)
         else
         if Column.Alignment = taLeftJustify  then
         (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+5, Column.Field.DisplayText);
      end;

      if (Column.FieldName = 'IndSel') and (TabPrec.RecordCount > 0) then
      begin
         dgPrecificacao.Canvas.FillRect(Rect);
         if TabPrecIndSel.AsString = '1' then
              Check := DFCS_CHECKED
         else Check := 0;
         R := Rect;
         InflateRect(R,-3,-3);
         DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
      end; //if

      if Column.ID = 7 then
      begin
         if TabPrecVlrPerVariacao.AsFloat >= 0 then
              DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+5, 18)
         else DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+5, 19);
      end; //if

      if (Column.FieldName = 'ConfAltPre') and (TabPrec.RecordCount > 0) then
      begin
         if TabPrecConfAltPre.AsString = '1' then
         begin
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+1, 15);
            dgPrecificacao.Canvas.Brush.Color:= clAqua;
         end
         else dgPrecificacao.Canvas.FillRect(Rect);
      end; //if
   end; //if
end;

procedure TFrmCompRecPre.SelecionaPro(Opcao: Integer);
var
   QueAuxi:TRESTDWClientSQL;
   auxIndSel,vErro:String;
begin
   ShowWait('Aguarde...', Self);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QueAuxi.DataBase := DM.DWDataBase;
      TabPrec.DisableControls;
      if Opcao = 0  then
      begin
         if ckTodos.Checked then
              auxIndSel := '1'
         else auxIndSel := '0';
         try
            QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET IndSel = '+Aspas(auxIndSel)+' WHERE IDRec = '+TabPrecIDRec.AsString;
            QueAuxi.ExecSQL(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a coluna IndSel na precificação em TabPrec em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível gravar a alteração.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;
      end //if
      else if Opcao = 1 then
      begin
         if ckAlta.Checked then
              auxIndSel := '1'
         else auxIndSel := '0';
         try
            QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET IndSel = '+Aspas(auxIndSel)+
            ' WHERE IDRec = '+TabPrecIDRec.AsString+' AND VlrPerVariacao > 0';
            QueAuxi.ExecSQL(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a coluna IndSel na precificação em TabPrec em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível gravar a alteração.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;
      end //if
      else if Opcao = 2 then
      begin
         auxIndSel := iif(ckBaixa.Checked, '1', '0');
         try
            QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET IndSel = '+Aspas(auxIndSel)+' '+
            'WHERE IDRec = '+Aspas(IntToStr(TabPrecIDRec.AsInteger))+' AND VlrPerVariacao < 0';
            QueAuxi.ExecSQL(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a coluna IndSel na precificação em TabPrec em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível gravar a alteração.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end; //if
         end;
      end //if
      else if Opcao = 3 then
      begin
         auxIndSel := iif(ckItePMC.Checked, '1', '0');
         try
            QueAuxi.SQL.Text := 'UPDATE arqcomprarecite SET IndSel = '+Aspas(auxIndSel)+' '+
            'WHERE IDRec = '+Aspas(IntToStr(TabPrecIDRec.AsInteger))+' AND VlrPMC > 0 ';
            QueAuxi.ExecSQL(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar a coluna IndSel na precificação em TabPrec em uCompRec -> '+E.Message);
               MostraMsg('Erro','Não foi possível gravar a alteração.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end; //if
         end;
      end; //if
      TabPrec.Close;
      TabPrec.Open;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      TabPrec.EnableControls;
      HideWait;
      AjustaDBGrid(dgPrecificacao);
   end;
end;

procedure TFrmCompRecPre.dgPrecificacaoExit(Sender: TObject);
begin
   if TabPrec.Active then TabPrec.ApplyUpdates;
end;

procedure TFrmCompRecPre.dgPrecificacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY in [VK_DOWN]) and (dgPrecificacao.DataSource.DataSet.RecNo = dgPrecificacao.DataSource.DataSet.RecordCount ) then Abort;
   if  Key in [VK_RETURN,VK_TAB] then TabPrec.ApplyUpdates;
end;

procedure TFrmCompRecPre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPrec.Close;
   Action := caFree;
end;

end.
