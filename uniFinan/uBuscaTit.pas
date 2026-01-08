unit uBuscaTit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, System.TypInfo, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
   Vcl.ComCtrls, Vcl.Grids, MarcLib, LMDBaseControl, LMDEdit, LMDBaseGraphicControl,
   LMDBaseLabel, Vcl.DBGrids, LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel,
   LMDSimplePanel, LMDCustomBevelPanel, AdvGlowButton, LMDCustomLabel, uRESTDWBasicDB,
   LMDBaseEdit, LMDCustomEdit, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Vcl.ExtCtrls,
   FireDAC.DApt.Intf,FireDAC.Comp.DataSet, uRESTDWBasicTypes, FireDAC.Comp.Client,
   Vcl.Mask, RxToolEdit, LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, RxCurrEdit,
   ACBrBoleto, Winapi.ShellAPI;

type
  TFrmBusTit = class(TForm)
    PanelBase: TLMDSimplePanel;
    SouTitu: TDataSource;
    TabTitu: TRESTDWClientSQL;
    PanelFiltros: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    PanelCabecalho: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edFilial: TLMDLabeledEdit;
    LMDLabel2: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDatIni: TDateEdit;
    LMDLabel3: TLMDLabel;
    LMDLabel5: TLMDLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    edDatFin: TDateEdit;
    LMDLabel6: TLMDLabel;
    edNotFis: TLMDEdit;
    btBuscar: TAdvGlowButton;
    TabTituNompes: TWideStringField;
    TabTituNrotit: TWideStringField;
    TabTituDestit: TWideStringField;
    TabTituDatemi: TDateField;
    TabTituDatven: TDateField;
    TabTituDatpag: TDateField;
    TabTituVlrtit: TFloatField;
    TabTituSaltit: TFloatField;
    DBGrid1: TDBGrid;
    btFechar: TAdvGlowButton;
    edPessoa: TLMDLabeledEdit;
    TabTituIDTitu: TFDAutoIncField;
    LMDLabel7: TLMDLabel;
    edNatFin: TLMDLabeledEdit;
    TabTituNomfil: TWideStringField;
    PanelRodape: TLMDSimplePanel;
    Label35: TLabel;
    edTotPer: TCurrencyEdit;
    TabTituNomcon: TWideStringField;
    TabTituPagRec: TWideStringField;
    TabTituIDFilial: TIntegerField;
    TabTituIndEnvBco: TWideStringField;
    TabTituGeraBol: TWideStringField;
    TabTituBolGerado: TWideStringField;
    edConv: TLMDLabeledEdit;
    LMDLabel8: TLMDLabel;
    LMDSimplePanel6: TLMDSimplePanel;
    ckVencimento: TLMDCheckBox;
    ckPagamento: TLMDCheckBox;
    ckEmissao: TLMDCheckBox;
    ckEnviados: TLMDCheckBox;
    Label13: TLabel;
    edTotSel: TCurrencyEdit;
    ckNaoEnviados: TLMDCheckBox;
    ckTodos: TLMDCheckBox;
    TabTituIDConv: TIntegerField;
    TabTituNomeArqBol: TWideStringField;
    TabTituCpfCnpjPes: TWideStringField;
    TabTituEndpes: TWideStringField;
    TabTituNroEnd: TWideStringField;
    TabTituBaipes: TWideStringField;
    TabTituCeppes: TWideStringField;
    TabTituNommun: TWideStringField;
    TabTituEstmun: TWideStringField;
    TabTituNossoNro: TWideStringField;
    TabTituRedTiptit: TWideStringField;
    OpenDialog1: TOpenDialog;
    LMDSimplePanel4: TLMDSimplePanel;
    btRetorno: TAdvGlowButton;
    btGeraBoleto: TAdvGlowButton;
    ckBaixados: TLMDCheckBox;
    ckPagar: TLMDCheckBox;
    ckReceber: TLMDCheckBox;
    LMDLabel9: TLMDLabel;
    LMDLabel10: TLMDLabel;
    btSelecTudo: TAdvGlowButton;
    btDesmarTudo: TAdvGlowButton;
    procedure AjustaGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure btBuscarClick(Sender: TObject);
    procedure edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNotFisKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edNatFinKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure ckPagarClick(Sender: TObject);
    procedure ckReceberClick(Sender: TObject);
    procedure btGeraBoletoClick(Sender: TObject);
    procedure ckEmissaoClick(Sender: TObject);
    procedure ckPagamentoClick(Sender: TObject);
    procedure ckVencimentoClick(Sender: TObject);
    procedure edConvCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edConvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edConvExit(Sender: TObject);
    procedure btSelecTudoClick(Sender: TObject);
    procedure btDesmarTudoClick(Sender: TObject);
    procedure ckTodosClick(Sender: TObject);
    procedure ckEnviadosClick(Sender: TObject);
    procedure ckNaoEnviadosClick(Sender: TObject);
    procedure TabTituAfterOpen(DataSet: TDataSet);
    procedure btRetornoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retIDTitu:Integer;
  end;

var
   FrmBusTit: TFrmBusTit;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaPes, uBoletos, uGeraBol;

procedure TFrmBusTit.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmBusTit.FormShow(Sender: TObject);
begin
   retIDTitu := 0;
   edDatIni.Date := Date;
   edDatFin.Date := Date;
   DBGrid1.DataSource := nil;
   AjustaGrid;
end;

procedure TFrmBusTit.TabTituAfterOpen(DataSet: TDataSet);
begin
   AjustaGrid;
end;

procedure TFrmBusTit.AjustaGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := 21;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
   edPessoa.SetFocus;
end;

procedure TFrmBusTit.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
   if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
   if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+4, Column.Field.DisplayText);

   if (Column.FieldName = 'GeraBol') and (TabtituPagRec.Value = 'R') then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabTituGeraBol.AsString = '1' then
           Check := DFCS_CHECKED
      else Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check or DFCS_FLAT);
   end; //if

   if (Column.FieldName = 'BolGerado') and (TabtituPagRec.Value = 'R') then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      if TabTituBolGerado.AsString = '1' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'S');
      end else
      if TabTituBolGerado.AsString = '0' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'N');
      end;
   end; //if

   if (Column.FieldName = 'GeraBol') and (TabtituPagRec.Value = 'P') then
   begin
      DBGrid1.Canvas.FillRect(Rect);
      DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,' ');
   end; //if
end;

procedure TFrmBusTit.edConvCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqconvenio',TLMDEdit(edConv),'IDConv','Nomcon','',0,True);
end;

procedure TFrmBusTit.edConvExit(Sender: TObject);
begin
   if edConv.Text = '' then edConv.Tag := 0;
end;

procedure TFrmBusTit.edConvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqconvenio',TLMDEdit(edConv),'IDConv','Nomcon','',Key);
end;

procedure TFrmBusTit.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmBusTit.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',Key,True);
end;

procedure TFrmBusTit.edNatFinCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqnatfin',TLMDEdit(edNatFin),'IDNatFin','Desnat','',0,True);
end;

procedure TFrmBusTit.edNatFinKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqnatfin',TLMDEdit(edNatFin),'IDNatFin','Desnat','',Key,True);
end;

procedure TFrmBusTit.edNotFisKeyPress(Sender: TObject; var Key: Char);
begin
   if (key in ['0'..'9'] = False) and (Word(key) <> VK_BACK) and (Word(key) <> VK_RETURN) and (Word(key) <> VK_TAB) then key := #0;
end;

procedure TFrmBusTit.edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      edPessoa.Tag := 0;
      FrmBuscaPes := TFrmBuscaPes.Create(Application);
      with FrmBuscaPes do
      begin
         lPoint := Self.edPessoa.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edPessoa.Width;
         edRetorno := TLMDEdit(Self.edPessoa);
         edBusca.Text := Self.edPessoa.Text;
         ShowModal;
      end; // with
   finally
      FrmBuscaPes.Free;
   end;
end;

procedure TFrmBusTit.edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then edPessoaCustomButtons0Click(Sender, 0);
   if (ssCtrl in Shift) or (IsNumeric(Copy(TLMDEdit(Sender).Text.Trim,1,3))) then Exit;
   btBuscas('arqpessoa',TLMDEdit(Sender),'IDPess','Nompes','',Key);
end;

procedure TFrmBusTit.btBuscarClick(Sender: TObject);
var
   auxOrdem:String;
   QueAuxi:TRESTDWClientSQL;
begin
   btBuscar.SetFocus;
   if ckEmissao.Checked    then auxOrdem := 'TIT.Datemi';
   if ckPagamento.Checked  then auxOrdem := 'BAI.Datpag';
   if ckVencimento.Checked then auxOrdem := 'TIT.Datven';

   edTotPer.Value := 0.00;
   DBGrid1.DataSource := nil;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT SUM(TIT.Saltit) AS TotSaldo FROM arqtitulo TIT '+
         'LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '+
         'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '+
         'LEFT JOIN arqtitulobai BAI ON TIT.IDTitu = BAI.IDTitu '+
         'LEFT JOIN arqconvenio CON ON TIT.IDConv = CON.IDConv '+
         'WHERE '+auxOrdem+' BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDatIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDatFin.Date));
         if ckReceber.Checked then
              QueAuxi.SQL.Add(' AND TIT.PagRec = '+Aspas('R'))
         else QueAuxi.SQL.Add(' AND TIT.PagRec = '+Aspas('P'));
         if edPessoa.Tag > 0 then QueAuxi.SQL.Add(' AND TIT.IDPess = '  +edPessoa.Tag.ToString);
         if edFilial.Tag > 0 then QueAuxi.SQL.Add(' AND TIT.IDFilial = '+edFilial.Tag.ToString);
         if edNatFin.Tag > 0 then QueAuxi.SQL.Add(' AND TIT.IDNatFin = '+edNatFin.Tag.ToString);
         if edNotFis.Text.Trim <> '' then QueAuxi.SQL.Add(' AND TIT.NotFis = '+edNotFis.Text.Trim);
         if ckBaixados.Checked then
              QueAuxi.SQL.Add(' AND TIT.Saltit <= 0.00')
         else QueAuxi.SQL.Add(' AND TIT.Saltit > 0.00');
         if ckEnviados.Checked then QueAuxi.SQL.Add(' AND TIT.IndEnvBco = '+Aspas('S'));
         if ckNaoEnviados.Checked then QueAuxi.SQL.Add(' AND TIT.IndEnvBco = '+Aspas('N'));
         if edConv.Tag <> 0 then
            QueAuxi.SQL.Add(' AND CON.IDConv = '+edConv.Tag.ToString);
         QueAuxi.Open;
         if QueAuxi.IsEmpty then
         begin
            MostraMsg('Aviso','Não há títulos com os parâmetros solicitados!',mtWarning, [mbOk]);
            Exit;
         end;
         edTotPer.Value := QueAuxi.FieldByName('TotSaldo').AsFloat;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar totalizar titulos uBuscaTit -> '+E.Message);
            MostraMsg('Erro', 'Não foi possível efetivar a busca dos títulos!'+#10+E.Message, mtError, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

   TabTitu.Close;
   Tabtitu.SQL.Text :='SELECT TIT.IDTitu,TIP.RedTiptit,PES.Nompes,PES.CpfCnpjPes,PES.Endpes,'+
   'PES.NroEnd,PES.Baipes,PES.Ceppes,MUN.Nommun,MUN.Estmun,TIT.IDFilial,FIL.Nomfil,TIT.Nrotit,'+
   'TIT.Destit,TIT.PagRec,TIT.Datemi,TIT.Datven,BAI.Datpag,TIT.Vlrtit,TIT.Saltit,CON.Nomcon,TIT.IndEnvBco,'+
   'TIT.GeraBol,TIT.BolGerado,TIT.IDConv,TIT.NomeArqBol,TIT.NossoNro FROM arqtitulo TIT '+
   'LEFT JOIN arqtiptitu TIP ON TIT.IDTiptit = TIP.IDTiptit '+
   'LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '+
   'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
   'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '+
   'LEFT JOIN arqconvenio CON ON TIT.IDConv = CON.IDConv '+
   'LEFT JOIN arqtitulobai BAI ON TIT.IDTitu = BAI.IDTitu WHERE '+auxOrdem+' BETWEEN '+
   Aspas(FormatDateTime('yyyy-mm-dd',edDatIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDatFin.Date));
   if ckReceber.Checked then
        TabTitu.SQL.Add(' AND TIT.PagRec = '+Aspas('R'))
   else TabTitu.SQL.Add(' AND TIT.PagRec = '+Aspas('P'));
   if edPessoa.Tag > 0 then Tabtitu.SQL.Add(' AND TIT.IDPess = '  +edPessoa.Tag.ToString);
   if edFilial.Tag > 0 then Tabtitu.SQL.Add(' AND TIT.IDFilial = '+edFilial.Tag.ToString);
   if edNatFin.Tag > 0 then Tabtitu.SQL.Add(' AND TIT.IDNatFin = '+edNatFin.Tag.ToString);
   if edNotFis.Text.Trim <> '' then Tabtitu.SQL.Add(' AND TIT.NotFis = '+edNotFis.Text.Trim);
   if ckBaixados.Checked then
        Tabtitu.SQL.Add(' AND TIT.Saltit <= 0.00')
   else Tabtitu.SQL.Add(' AND TIT.Saltit > 0.00');
   if ckEnviados.Checked then Tabtitu.SQL.Add(' AND TIT.IndEnvBco = '+Aspas('S'));
   if ckNaoEnviados.Checked then Tabtitu.SQL.Add(' AND TIT.IndEnvBco = '+Aspas('N'));
   if edConv.Tag <> 0 then Tabtitu.SQL.Add(' AND CON.IDConv = '+edConv.Tag.ToString);
   Tabtitu.SQL.Add(' ORDER BY '+auxOrdem);
   TabTitu.Open;
   if TabTitu.IsEmpty then
        MostraMsg('Aviso','Não há títulos com os parâmetros solicitados!',mtWarning, [mbOk])
   else DBGrid1.DataSource := SouTitu;
   AjustaGrid;
end;

procedure TFrmBusTit.DBGrid1CellClick(Column: TColumn);
var
   QueParam:TRESTDWClientSQL;
   auxDirBol:String;
begin
   if (Column.FieldName = 'GeraBol') and (TabTituPagRec.AsString = 'R') then
   begin
      if not (TabTitu.State in dsEditModes) then TabTitu.Edit;
      TabTituGeraBol.AsString := iif(TabTituGeraBol.AsString = '0','1','0');
      TabTitu.Post;
      if TabTituGeraBol.AsString = '1' then
           edTotSel.Value  := edTotSel.Value + TabTitu.FieldByName('Saltit').AsFloat
      else edTotSel.Value  := edTotSel.Value - TabTitu.FieldByName('Saltit').AsFloat;
      DBGrid1.SelectedField := TabTituNompes;
   end; //if

   if (Column.FieldName = 'BolGerado') and (TabTituPagRec.AsString = 'R') then
   begin
      QueParam := TRESTDWClientSQL.Create(nil);
      QueParam.DataBase := DM.DWDataBase;
      try
         QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+TabTituIDFilial.AsString;
         QueParam.Open;
         auxDirBol := QueParam.FieldByName('PastaBoletos').AsString;
      finally
         QueParam.Close;
         FreeAndNil(QueParam);
      end;
      if not (auxDirBol = '') then
      begin
         auxDirBol := auxDirBol+'\'+TabTituNomeArqBol.AsString;
         if FileExists(auxDirBol) then
            ShellExecute(0, 'open', PChar(auxDirBol), nil, nil, SW_SHOWNORMAL)
         else
         begin
            MostraMsg('Aviso','Boleto já foi gerado, mas não foi encontrado na pasta específicada para ele!',mtWarning, [mbOk]);
            DBGrid1.SetFocus;
            Exit;
         end;
      end;
   end; //if
end;

procedure TFrmBusTit.DBGrid1DblClick(Sender: TObject);
begin
   if not TabTitu.IsEmpty then
        retIDTitu := TabTituIDTitu.Value
   else retIDTitu := 0;
   Self.Close;
end;

procedure TFrmBusTit.btGeraBoletoClick(Sender: TObject);
var
   recBol:Boolean;
   QueAuxi,QueParam:TRESTDWClientSQL;
   auxDirBol:String;
   vErro:String;
   auxData:TDate;
begin
   TabTitu.Filtered := False;
   TabTitu.Filter   := 'PagRec = '+Aspas('R')+' AND GeraBol = '+Aspas('1');
   TabTitu.Filtered := True;
   if TabTitu.IsEmpty then
   begin
      MostraMsg('Aviso','Nenhuma conta a receber selecionada para gerar boleto!',mtWarning, [mbOk]);
      DBGrid1.SetFocus;
      TabTitu.Filtered := False;
      Exit;
   end;

   auxData := Now;
   TabTitu.Filtered := False;
   TabTitu.Filter   := 'PagRec = '+Aspas('R')+' AND GeraBol = '+Aspas('1')+' AND Datven < '+ QuotedStr(DateToStr(auxData));
   TabTitu.Filtered := True;
   if not TabTitu.IsEmpty then
   begin
      MostraMsg('Aviso','Conta a receber com data menor que a data atual!',mtWarning, [mbOk]);
      DBGrid1.SetFocus;
      TabTitu.Filtered := False;
      Exit;
   end;

   TabTitu.Filtered := False;
   TabTitu.Filter   := 'PagRec = '+Aspas('R')+' AND GeraBol = '+Aspas('1');
   TabTitu.Filtered := True;

   if TabTituBolGerado.AsString = '1' then
   begin
      QueParam := TRESTDWClientSQL.Create(nil);
      QueParam.DataBase := DM.DWDataBase;
      try
         QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+TabTituIDFilial.AsString;
         QueParam.Open;
         auxDirBol := QueParam.FieldByName('PastaBoletos').AsString;
      finally
         QueParam.Close;
         FreeAndNil(QueParam);
      end;
      if auxDirBol = '' then
      begin
         MostraMsg('Aviso','Pasta onde vai salvar os boletos não definida nas configurações!',mtWarning, [mbOk]);
         DBGrid1.SetFocus;
         TabTitu.Filtered := False;
         Exit;
      end else
      begin
         auxDirBol := auxDirBol+'\'+TabTituNomeArqBol.AsString;
         if FileExists(auxDirBol) then
         begin
            ShellExecute(0, 'open', PChar(auxDirBol), nil, nil, SW_SHOWNORMAL);
            TabTitu.Filtered := False;
            Exit;
         end else
         begin
            MostraMsg('Aviso','Boleto já foi gerado, mas não foi encontrado na pasta específicada para ele!',mtWarning, [mbOk]);
            DBGrid1.SetFocus;
            TabTitu.Filtered := False;
            Exit;
         end;
      end;
   end; //if

   try
      Self.AlphaBlendValue := 165;
      Application.CreateForm(TFrmGeraBol, FrmGeraBol);
      CentralizarControl(FrmGeraBol, FrmBusTit);
      FrmGeraBol.TabTitu := TabTitu;
      FrmGeraBol.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      recBol := FrmGeraBol.recBol;
      FrmGeraBol := nil;
   end; //try
end;

procedure TFrmBusTit.btRetornoClick(Sender: TObject);
var
   QueParam:TRESTDWClientSQL;
   auxDirBol:String;
   Boleto  : TACBrBoleto;
   Retorno : TListadeBoletos;
   I       : Integer;
   RetText : TStringList;
begin
   QueParam := TRESTDWClientSQL.Create(nil);
   QueParam.DataBase := DM.DWDataBase;
   try
      QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+FILIAL.ToString;
      QueParam.Open;
      auxDirBol := QueParam.FieldByName('PastaBoletos').AsString;
   finally
      QueParam.Close;
      FreeAndNil(QueParam);
   end;
   OpenDialog1.InitialDir := auxDirBol;
   if not OpenDialog1.Execute then Exit;

   Boleto := FACBrBoleto;

   Boleto.DirArqRetorno  := ExtractFilePath(OpenDialog1.FileName);
   Boleto.NomeArqRetorno := ExtractFileName(OpenDialog1.FileName);

   Boleto.ListadeBoletos.Clear;
   Boleto.LerRetorno();

   Retorno := Boleto.ListadeBoletos;
   RetText := TStringList.Create;
   try
      for I := 0 to Pred(Retorno.Count) do
      begin
         RetText.Add('Nosso Número :: '    + Retorno[i].NossoNumero);
         RetText.Add('Valor Documento :: ' + CurrToStr(Retorno[i].ValorDocumento));
         RetText.Add('Valor Pago :: '      + CurrToStr(Retorno[i].ValorPago));
         RetText.Add('Valor Recebido :: '  + CurrToStr(Retorno[i].ValorRecebido));
         RetText.Add('Valor Abatimento :: '  + CurrToStr(Retorno[i].ValorAbatimento));
         RetText.Add('Valor Desconto :: '  + CurrToStr(Retorno[i].ValorDesconto));
         RetText.Add('Valor Mora Juros :: '  + CurrToStr(Retorno[i].ValorMoraJuros));
         RetText.Add('Valor Outros Creditos :: '  + CurrToStr(Retorno[i].ValorOutrosCreditos));
         RetText.Add('Valor Desp. Cobranca :: '  + CurrToStr(Retorno[i].ValorDespesaCobranca));
         RetText.Add('Valor IOF :: '  + CurrToStr(Retorno[i].ValorIOF));
         RetText.Add('Data Ocorrencia :: ' + DateToStr(Retorno[i].DataOcorrencia));
         RetText.Add('Data Vencimento :: ' + DateToStr(Retorno[i].Vencimento));
         RetText.Add('CodTipoOcorrencia :: ' + GetEnumName( TypeInfo(TACBrTipoOcorrencia), Integer(Retorno[i].OcorrenciaOriginal.Tipo)));
         RetText.Add('Descrição Tipo Ocorrencia :: '  + Retorno[i].OcorrenciaOriginal.Descricao);
         RetText.Add('Descriçãoo Comando :: '  + Retorno[i].DescricaoMotivoRejeicaoComando.Text);
         RetText.Add('Motivodo :: '  + Retorno[i].MotivoRejeicaoComando.Text);
         RetText.Add('EMV (QrCode Pix) :: '  + Retorno[i].QrCode.emv);
         RetText.Add('---------------------------');
      end; //for
   finally
      RetText.Free;
   end;
end;

procedure TFrmBusTit.btSelecTudoClick(Sender: TObject);
begin
   if TabTitu.IsEmpty then exit;
   TabTitu.First;
   while not TabTitu.Eof do
   begin
      if TabTituIndEnvBco.AsString = 'N' then
      begin
         TabTitu.Edit;
         TabTituGeraBol.AsString := '1';
         TabTitu.Post;
         edTotSel.Value  := edTotSel.Value + TabTitu.FieldByName('Saltit').AsFloat;
      end;
      TabTitu.Next;
   end;
end;

procedure TFrmBusTit.btDesmarTudoClick(Sender: TObject);
begin
   if TabTitu.IsEmpty then exit;
   TabTitu.First;
   while not TabTitu.Eof do
   begin
      TabTitu.Edit;
      TabTituGeraBol.AsString := '0';
      TabTitu.Post;
      TabTitu.Next;
   end;
   edTotSel.Value  := 0;
end;

procedure TFrmBusTit.ckPagarClick(Sender: TObject);
begin
   if ckPagar.Checked then
   begin
      ckReceber.Checked := False;
      TabTitu.Close;
   end
   else ckPagar.Checked := True;
   btGeraBoleto.Visible := False;
   btSelecTudo.Visible  := False;
   btDesmarTudo.Visible := False;
   btRetorno.Visible    := False;
end;

procedure TFrmBusTit.ckReceberClick(Sender: TObject);
begin
   if ckReceber.Checked then
   begin
      ckPagar.Checked := False;
      TabTitu.Close;
   end
   else ckReceber.Checked := True;
   btGeraBoleto.Visible := True;
   btSelecTudo.Visible  := True;
   btDesmarTudo.Visible := True;
   btRetorno.Visible    := True;
end;

procedure TFrmBusTit.ckEmissaoClick(Sender: TObject);
begin
   if ckEmissao.Checked then
   begin
      ckPagamento.Checked  := False;
      ckVencimento.Checked := False;
   end;
   ckEmissao.Checked := True;
end;

procedure TFrmBusTit.ckPagamentoClick(Sender: TObject);
begin
   if ckPagamento.Checked then
   begin
      ckVencimento.Checked  := False;
      ckEmissao.Checked := False;
   end;
   ckPagamento.Checked := True;
end;

procedure TFrmBusTit.ckVencimentoClick(Sender: TObject);
begin
   if ckVencimento.Checked then
   begin
      ckPagamento.Checked  := False;
      ckEmissao.Checked := False;
   end;
   ckVencimento.Checked := True;
end;

procedure TFrmBusTit.ckTodosClick(Sender: TObject);
begin
   ckEnviados.Checked    := False;
   ckNaoEnviados.Checked := False;
end;

procedure TFrmBusTit.ckEnviadosClick(Sender: TObject);
begin
   ckTodos.Checked       := False;
   ckNaoEnviados.Checked := False;
end;

procedure TFrmBusTit.ckNaoEnviadosClick(Sender: TObject);
begin
   ckTodos.Checked    := False;
   ckEnviados.Checked := False;
end;

procedure TFrmBusTit.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmBusTit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabTitu.Active then TabTitu.Close;
   Self := nil;
end;

end.
