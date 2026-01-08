unit uComTraInc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, Marclib, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.DBCtrls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, RxDBCtrl, LMDDBEdit, LMDButtonControl,
  LMDRadioButton, LMDThemedComboBox, LMDCustomComboBox, LMDComboBox, Vcl.Mask, RxToolEdit, AdvGlowButton, LMDCustomMaskEdit,
  LMDMaskEdit, LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDSimplePanel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB,
  Datasnap.DBClient, LMDCustomExtCombo, LMDCustomListComboBox, LMDListComboBox;

type
  TFrmComTraInc = class(TForm)
    PanelPri: TLMDSimplePanel;
    PanelCabecalho: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    PanelNota: TLMDSimplePanel;
    LMDLabel15: TLMDLabel;
    pnDatDoc: TLMDSimplePanel;
    edDatLan: TDBDateEdit;
    LabelCab: TLMDLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    PanelPdrIte: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    PanelProduto: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    SouComTra: TDataSource;
    SouComTraIte: TDataSource;
    PanelRodape: TLMDSimplePanel;
    Shape5: TShape;
    PanelConf: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    rbConSim: TLMDRadioButton;
    rbConNao: TLMDRadioButton;
    PanelTrans: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    rbTraSim: TLMDRadioButton;
    rbTraNao: TLMDRadioButton;
    btConfirma: TAdvGlowButton;
    btProdutos: TAdvGlowButton;
    edNroNota: TLMDDBLabeledEdit;
    edFornec: TLMDDBLabeledEdit;
    btAltNota: TAdvGlowButton;
    btSalNota: TAdvGlowButton;
    btCanNota: TAdvGlowButton;
    btIncNota: TAdvGlowButton;
    btExcNota: TAdvGlowButton;
    btIncPro: TAdvGlowButton;
    btAltPro: TAdvGlowButton;
    btSalPro: TAdvGlowButton;
    btCanPro: TAdvGlowButton;
    btExcPro: TAdvGlowButton;
    edIDProd: TLMDDBLabeledEdit;
    edDesPro: TLMDDBLabeledEdit;
    edRegMS: TLMDDBLabeledEdit;
    edNrolot: TLMDDBLabeledEdit;
    edQuant: TLMDDBLabeledEdit;
    edNomFab: TLMDDBLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    edDataVen: TDBDateEdit;
    cdsTepComTra: TClientDataSet;
    cdsTepComTraIDSngpcCom: TIntegerField;
    cdsTepComTraIDFilial: TIntegerField;
    cdsTepComTraIDPess: TIntegerField;
    cdsTepComTraNronot: TIntegerField;
    cdsTepComTraDatlan: TDateField;
    cdsTepComTraTipope: TWideStringField;
    cdsTepComTraIndConf: TWideStringField;
    cdsTepComTraNompes: TWideStringField;
    cdsTepComTraTransmitida: TWideStringField;
    edReceita: TLMDDBLabeledEdit;
    cdsTepComTraIte: TClientDataSet;
    cdsTepComTraIteIDSngpcComIte: TIntegerField;
    cdsTepComTraIteIDSngpcCom: TIntegerField;
    cdsTepComTraIteIDProd: TIntegerField;
    cdsTepComTraIteNrolot: TWideStringField;
    cdsTepComTraIteQtdmov: TFloatField;
    cdsTepComTraIteDespro: TWideStringField;
    cdsTepComTraIteRegistoMS: TWideStringField;
    cdsTepComTraIteNomfab: TWideStringField;
    cdsTepComTraIteDatven: TDateField;
    cdsTepComTraIteUsoRece: TWideStringField;
    cdsTepComTraIDInvIni: TIntegerField;
    ComboTipOpe: TLMDLabeledListComboBox;
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edFornecCustomButtons0Click(Sender: TObject; index: Integer);
    procedure TabComTraIteAfterOpen(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edDesProCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesPro01KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFornecKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSalNotaClick(Sender: TObject);
    procedure btCanNotaClick(Sender: TObject);
    procedure btAltNotaClick(Sender: TObject);
    procedure btIncNotaClick(Sender: TObject);
    procedure btExcNotaClick(Sender: TObject);
    procedure btIncProClick(Sender: TObject);
    procedure btSalProClick(Sender: TObject);
    procedure btCanProClick(Sender: TObject);
    procedure btExcProClick(Sender: TObject);
    procedure btAltProClick(Sender: TObject);
    procedure edDesProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQuantExit(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure btProdutosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Frm:TForm;
    auxIDFilial:Integer;
    procedure AjustaGrid;
    procedure HabBotNota(Acao:Boolean);
    procedure BuscaInfPro;
    procedure habilBotNota(Acao: Boolean);
    procedure habilBotProd(Acao: Boolean);
    Function  GravaProduto:Boolean;
    function  GravaAlteracao:Boolean;
    function  GravaInclusao:boolean;
  public
    { Public declarations }
    recIDSngpcCom,recIDFilial,recIDInvIni:Integer;
    recOrigem:String;
    recAlteracaoNota,recAlteracaoProd:Integer;
    recNroLot:String;
    recDatven:TDateTime;
    recQuant:Double;
  end;

var
  FrmComTraInc: TFrmComTraInc;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uBuscaProd, uProdutoCad;

procedure TFrmComTraInc.AjustaGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmComTraInc.FormShow(Sender: TObject);
begin
   AjustaGrid;

   recAlteracaoNota := 0;
   recAlteracaoProd := 0;
   if recOrigem = 'CONSULTAR' then
   begin
      ComboTipOpe.ItemIndex := cdsTepComTraTipope.AsInteger;
      if cdsTepComTraIndConf.AsString = '0' then
         rbConNao.Checked := True
      else
         rbConSim.Checked := True;
      if cdsTepComTraTransmitida.AsString = '0' then
      begin
         rbTraNao.Checked := True;
         btIncPro.Enabled := True;
         btExcPro.Enabled := True;
         btAltPro.Enabled := True;
      end else
      begin
         rbTraSim.Checked     := True;
         PanelProduto.Visible := False;
      end;

      btIncNota.Visible  := False;
      btExcNota.Visible  := False;
      btAltNota.Visible  := True;
      btAltNota.Top      := btIncNota.Top;
      btAltNota.Left     := btIncNota.Left;
      btAltNota.Enabled  := True;
      PanelTrans.Visible := True;
      LabelCab.Caption := 'SNGPC - Manipulação dos produtos ligados a nota fiscal selecionada';
      ComboTipOpe.Enabled := False;
   end else
   begin
      btIncNota.Enabled   := True;
      btExcNota.Enabled   := True;
   end;
end;

procedure TFrmComTraInc.HabBotNota(Acao: Boolean);
var
   QueAuxi: TRESTDWClientSQL;
begin
   if edDespro.Text = '' then Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text :=
      'SELECT PRO.IDProd,PRO.RegistoMS,PRO.ClasTera,PRO.UsoRece,PES.IDPess,PES.Nompes FROM arqproduto PRO '+
      'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
      'WHERE PRO.IDProd = '+Aspas(IntToStr(edDespro.Tag));
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         edIDProd.Text := QueAuxi.FieldByName('IDProd').AsString;
         edRegMS.Text  := QueAuxi.FieldByName('RegistoMS').AsString;
      end;// if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmComTraInc.habilBotNota(Acao: Boolean);
begin
   if Acao then
   begin
      edNroNota.Color       := $00EFEFEF;
      edFornec.Color        := $00EFEFEF;
      edDatLan.Color        := $00EFEFEF;
      ComboTipOpe.Color     := $00EFEFEF;
      edNroNota.Enabled     := False;
      edFornec.Enabled      := False;
      edDatLan.Enabled      := False;
      ComboTipOpe.Enabled   := False;
   end
   else
   begin
      edNroNota.Color     := clWhite;
      edFornec.Color      := clWhite;
      edDatLan.Color      := clWhite;
      ComboTipOpe.Color   := clWhite;
      edNroNota.Enabled   := True;
      edFornec.Enabled    := True;
      edDatLan.Enabled    := True;
      ComboTipOpe.Enabled := True;
   end;
   btExcNota.Enabled   := Acao;
   btIncPro.Enabled    := Acao;
   btExcPro.Enabled    := Acao;
   PanelRodape.Enabled := Acao;
   btSalNota.Enabled   := not (Acao);
   btCanNota.Enabled   := not (Acao);
   PanelConf.Enabled   := not (Acao);
   if cdsTepComTra.RecordCount > 0 then
   begin
      btAltNota.Enabled    := Acao;
      btIncPro.Enabled     := Acao;
      btExcPro.Enabled     := Acao;
      btAltPro.Enabled     := Acao;
      PanelProduto.Enabled := Acao;
   end;
end;

procedure TFrmComTraInc.TabComTraIteAfterOpen(DataSet: TDataSet);
begin
   AjustaGrid;
end;

procedure TFrmComTraInc.btIncNotaClick(Sender: TObject);
begin
   recAlteracaoNota := 1;
   habilBotNota(False);
   btIncNota.Enabled := False;
   cdsTepComTra.Append;
end;

procedure TFrmComTraInc.btAltNotaClick(Sender: TObject);
begin
   if cdsTepComTra.IsEmpty then
   begin
      MostraMsg('Alteração de nota fiscal','Nenhuma nota fiscal selecionada para fazer a alteração!',mtWarning, [mbOk]);
      edNrolot.SetFocus;
      Exit;
   end;// if
   recAlteracaoNota := 2;
   habilBotNota(False);
   btIncNota.Enabled := False;
   cdsTepComTra.Edit;
end;

procedure TFrmComTraInc.btAltProClick(Sender: TObject);
var
   QueGrava:TRESTDWClientSQL;
   vErro:String;
begin
   if cdsTepComTraIte.IsEmpty then
   begin
      MostraMsg('Alteração do produto','Nenhum produto selecionado para fazer a alteração!',mtWarning, [mbOk]);
      edNrolot.SetFocus;
      Exit;
   end;
   habilBotProd(False);
   recAlteracaoProd := 2;
   edDesPro.Enabled := False;
   edRegMS.Enabled  := False;
   edDesPro.Color   := $00EFEFEF;
   edRegMS.Color    := $00EFEFEF;
   recNroLot        := cdsTepComTraIteNrolot.AsString;
   recDatven        := cdsTepComTraIteDatven.AsDateTime;
   recQuant         := cdsTepComTraIteQtdmov.AsFloat;
   edNrolot.SetFocus;
   cdsTepComTraIte.Edit;
end;

procedure TFrmComTraInc.btCanNotaClick(Sender: TObject);
begin
   habilBotNota(True);
   cdsTepComTra.Cancel;
end;

procedure TFrmComTraInc.btSalNotaClick(Sender: TObject);
var
   DBEditErro:TLMDDBLabeledEdit;
begin
   btSalNota.SetFocus;
   if cdsTepComTraNronot.AsInteger <= 0 then DBEditErro := edNroNota else
   if cdsTepComTraIDPess.AsInteger <= 0 then DBEditErro := edFornec;
   if DBEditErro <> nil then
   begin
      MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
      DBEditErro.SetFocus;
      Exit;
   end; //if
   if cdsTepComTraDatlan.AsDateTime = 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a Data de lançamento!',mtWarning, [mbOk]);
      edDatLan.SetFocus;
      Exit;
   end;// if
   if ComboTipOpe.ItemIndex < 0 then
   begin
      MostraMsg('Tipo operação inválida','Favor verificar o tipo das operação da nota fiscal!',mtWarning, [mbOk]);
      ComboTipOpe.SetFocus;
      Exit;
   end;// if

   cdsTepComTraIDFilial.AsInteger   := recIDFilial;
   cdsTepComTraIDInvIni.AsInteger   := recIDInvIni;
   cdsTepComTraTipope.AsString      := IntToStr(ComboTipOpe.ItemIndex);
   cdsTepComTraIndConf.AsString     := iif(rbConSim.Checked,Aspas('1'),Aspas('0'));
   cdsTepComTraTransmitida.AsString := '0';
   cdsTepComTra.Post;

   habilBotNota(True);
   btIncNota.Enabled := False;
end;

procedure TFrmComTraInc.edQuantExit(Sender: TObject);
begin
   if GravaProduto then
      btIncPro.Click;
end;

procedure TFrmComTraInc.btSalProClick(Sender: TObject);
begin
   if edQuant.Focused then // Se o focu está na quantidade.
      DBGrid1.SetFocus     // Tira o foco da quantidade para executar a gravação.
   else
   begin
      if recAlteracaoProd = 1 then
      begin
         if GravaProduto then
            btIncPro.Click
         else
            edDesPro.SetFocus;
      end;// if
      if recAlteracaoProd = 2 then
      begin
         if GravaProduto then
         begin
            btIncPro.Enabled    := True;
            btAltPro.Enabled    := True;
            btExcPro.Enabled    := True;
            btSalPro.Enabled    := False;
            btCanPro.Enabled    := False;
            btAltNota.Enabled   := True;
            edNrolot.Enabled    := False;
            edDataVen.Enabled   := False;
            edQuant.Enabled     := False;
            edNrolot.Color      := $00EFEFEF;
            edDataVen.Color     := $00EFEFEF;
            edQuant.Color       := $00EFEFEF;
            PanelRodape.Enabled := True;
            DBGrid1.SetFocus;
         end
         else
            edNrolot.SetFocus;
      end;// if
   end;// if
end;

procedure TFrmComTraInc.btConfirmaClick(Sender: TObject);
begin
   if recOrigem = 'CONSULTAR' then
   begin
      if cdsTepComTra.IsEmpty then
      begin
         MostraMsg('Confirmação de alteração','Nenhuma nota fiscal selecionada para confirmar as alterações!',mtWarning, [mbOk]);
         Exit;
      end;// if
      if GravaAlteracao then
         Close;
   end;// if
   if recOrigem = 'INCLUIR' then
      if GravaInclusao then
         Close;
end;

function TFrmComTraInc.GravaInclusao;
var
   QueGrava,QueLote:TRESTDWClientSQL;
   auxIDSngpcCom:Integer;
   vErro:String;
begin
   Result := False;
   if MostraMsg('Confirmação','Deseja incluir a nota fiscal número '+cdsTepComTraNronot.AsString+' e todos os produtos ligados a ela?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;

   QueGrava          := TRESTDWClientSQL.Create(nil);
   QueLote           := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;
   QueLote.DataBase  := DM.DWDataBase;
   cdsTepComTraIte.DisableControls;

   try
      try
         QueGrava.SQL.Clear;
         QueGrava.Close;
         QueGrava.SQL.Text := 'INSERT INTO arqsngpccom (IDFilial,IDInvIni,IDPess,Nronot,Datlan,Tipope,IndConf) VALUES ('+
         cdsTepComTraIDFilial.AsString+','+
         cdsTepComTraIDInvIni.AsString+','+
         cdsTepComTraIDPess.AsString+','+
         cdsTepComTraNronot.AsString+','+
         Aspas(FormatDateTime('yyyy-mm-dd',cdsTepComTraDatlan.AsDateTime))+','+
         cdsTepComTraTipope.AsString+','+
         cdsTepComTraIndConf.AsString+');';
         QueGrava.SQL.Add('SELECT LAST_INSERT_ID() AS ULT_ID;');
         QueGrava.Open;
         auxIDSngpcCom :=  QueGrava.FieldByName('ULT_ID').AsInteger;
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar na tabela virtual cdsTepComTra em uComTraInc');
            MostraMsg('Erro','Não foi possível incluir o Nota fiscal.', mtWarning, [mbOk]);
           Exit;
         end;
      end; //try
      cdsTepComTraIte.First;
      while not cdsTepComTraIte.Eof do
      begin
         try
            QueGrava.Close;
            QueGrava.SQL.Text := 'INSERT INTO arqsngpccomite (IDSngpcCom,IDProd,Nrolot,Qtdmov,DatVen,UsoRece) VALUES ('+
            auxIDSngpcCom.ToString+','+
            cdsTepComTraIteIDProd.AsString+','+
            Aspas(cdsTepComTraIteNrolot.AsString)+','+
            FormatDouble(cdsTepComTraIteQtdmov.AsFloat,11,2)+','+
            Aspas(FormatDateTime('yyyy-mm-dd',cdsTepComTraIteDatven.AsDateTime))+','+
            Aspas(cdsTepComTraIteUsoRece.AsString)+')';
            QueGrava.ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpccomite em uComTraInc -> '+E.Message);
               MostraMsg('Erro','Não foi possível incluir o produto.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
         cdsTepComTraIte.Next;
      end;// while
   finally
      cdsTepComTraIte.EnableControls;
      QueGrava.Close;
      QueLote.Close;
      FreeAndNil(QueGrava);
      FreeAndNil(QueLote);
   end;// try
   Result := True;
end;

function TFrmComTraInc.GravaAlteracao;
var
   QueGrava,QueAuxi,QueLote:TRESTDWClientSQL;
   vErro:String;
begin
   Result := False;
   if MostraMsg('Confirmação','Deseja salvar as alterações feitas?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;

   QueGrava          := TRESTDWClientSQL.Create(nil);
   QueAuxi           := TRESTDWClientSQL.Create(nil);
   QueLote           := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;
   QueAuxi.DataBase  := DM.DWDataBase;
   QueLote.DataBase  := DM.DWDataBase;
   try  // grava as alterações da nota fiscal
      if recAlteracaoNota > 0 then
      begin
         try
            QueGrava.Close;
            QueGrava.SQL.Text := 'UPDATE arqsngpccom SET '+
                                 'IDPess = '+cdsTepComTraIDPess.AsString+','+
                                 'Nronot = '+cdsTepComTraNronot.AsString+','+
                                 'Datlan = '+Aspas(FormatDateTime('yyyy-mm-dd',cdsTepComTraDatlan.AsDateTime))+','+
                                 'Tipope = '+Aspas(cdsTepComTraTipope.AsString)+','+
                                 'IndConf = '+cdsTepComTraIndConf.AsString+
                                 ' WHERE IDSngpcCom = '+cdsTepComTraIDSngpcCom.AsString;
            QueGrava.ExecSQL(vErro);
         except
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar a alteração da nota fiscal em arqsngpccom na uComTraInc -> '+E.Message);
               MostraMsg('Erro','Não foi possível gravar a alteração da nota fiscal.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
      end;// try
      // grava as alterações dos produtos da nota fiscal
      if recAlteracaoProd > 0 then
      begin
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT ITE.*, PRO.Despro FROM arqsngpccomite ITE ' +
                             'LEFT JOIN arqproduto PRO ON ITE.IDProd = PRO.IDProd'+
                             ' WHERE ITE.IDSngpcCom = '+ cdsTepComTraIDSngpcCom.AsString;
         Queauxi.Open;
         QueAuxi.First;
         while not QueAuxi.Eof do
         begin
            if cdsTepComTraIte.Locate('IDSngpcComIte',QueAuxi.FieldByName('IDSngpcComIte').AsInteger, []) then
            begin
               if not (QueAuxi.FieldByName('Nrolot').AsString = cdsTepComTraIteNrolot.AsString) or
                  not (QueAuxi.FieldByName('DatVen').AsDateTime = cdsTepComTraIteDatVen.AsDateTime) or
                  not (QueAuxi.FieldByName('Qtdmov').AsFloat = cdsTepComTraIteQtdmov.AsFloat) then
               begin
                  try
                     QueGrava.Close;
                     QueGrava.SQL.Text := 'UPDATE arqsngpccomite SET '+
                                          'Nrolot = '+cdsTepComTraIteNrolot.AsString+','+
                                          'DatVen = '+Aspas(FormatDateTime('yyyy-mm-dd',cdsTepComTraIteDatven.AsDateTime))+','+
                                          'Qtdmov = '+FormatDouble(cdsTepComTraIteQtdmov.AsFloat,11,2)+
                                          ' WHERE IDSngpcComIte = '+cdsTepComTraIteIDSngpcComIte.AsString;
                     QueGrava.ExecSQL(vErro);
                  except
                     on E:Exception do
                     begin
                        SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar a alteração do produto em arqsngpccomite na uComTraInc -> '+E.Message);
                        MostraMsg('Erro','Não foi possível gravar a alteração do produto.'+#10+E.Message, mtWarning, [mbOk]);
                        Exit;
                     end;
                  end;// try
               end;// if
               cdsTepComTraIte.Delete;
            end// if
            else
            begin
               QueLote.Close;
               QueLote.SQL.Text := 'SELECT * FROM arqsngpclot'+
                                   ' WHERE IDFilial = '+cdsTepComTraIDFilial.AsString+
                                   ' AND IDInvIni = '+cdsTepComTraIDInvIni.AsString+
                                   ' AND IDProd = '+cdsTepComTraIteIDProd.AsString+
                                   ' AND Nrolot = '+cdsTepComTraIteNrolot.AsString;
               QueLote.Open;
               if QueLote.RecordCount > 0 then
               begin  // aqui deleta o produto que está no lote do SNGPC, mas não vai deixar o saldo negativo
                  if QueLote.FieldByName('Qtdest').AsFloat - QueAuxi.FieldByName('Qtdmov').AsFloat > 0 then
                  begin
                     try
                        QueGrava.Close;
                        QueGrava.SQL.Text := 'DELETE FROM arqsngpccomite'+
                                            ' WHERE IDSngpcComIte = '+QueAuxi.FieldByName('IDSngpcComIte').AsString;
                        QueGrava.ExecSQL;
                     except
                        on E:Exception do
                        begin
                           SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir os produtos da nota fiscal de arqsngpccomite em uCompTraInc -> '+E.Message);
                           MostraMsg('Erro','Não foi possível excluir o produto da nota fiscal e incluir as alterações.'+#10+E.Message, mtWarning, [mbOk]);
                           Exit;
                        end;
                     end;// try
                  end// if
                  else
                  begin
                     MostraMsg('Exclusão','Produto '+QueAuxi.FieldByName('Despro').AsString+' não pode ser excluido, pois tem movimentação no lote.', mtWarning, [mbOk]);
                  end;
                  cdsTepComTraIte.Delete;
               end// if
               else
               begin
                  try // aqui deleta o produto que não esta no estoque do SNGPC
                     QueGrava.Close;
                     QueGrava.SQL.Text := 'DELETE FROM arqsngpccomite'+
                                         ' WHERE IDSngpcComIte = '+QueAuxi.FieldByName('IDSngpcComIte').AsString;
                     QueGrava.ExecSQL;
                  except
                     on E:Exception do
                     begin
                        SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir os produtos da nota fiscal de arqsngpccomite em uCompTraInc -> '+E.Message);
                        MostraMsg('Erro','Não foi possível excluir os produtos da nota fiscal e incluir as alterações.'+#10+E.Message, mtWarning, [mbOk]);
                        Exit;
                     end;
                  end;// try
                  cdsTepComTraIte.Delete;
               end;// if
            end;// if
            QueAuxi.Next;
         end;// while
         if cdsTepComTraIte.RecordCount > 0 then
         begin
            cdsTepComTraIte.First;
            while not cdsTepComTraIte.Eof do
            begin
               try
                  QueGrava.Close;
                  QueGrava.SQL.Text := 'INSERT INTO arqsngpccomite (IDSngpcCom,IDProd,Nrolot,Qtdmov,DatVen,UsoRece) VALUES ('+
                  cdsTepComTraIteIDSngpcCom.AsString+','+
                  cdsTepComTraIteIDProd.AsString+','+
                  Aspas(cdsTepComTraIteNrolot.AsString)+','+
                  FormatDouble(cdsTepComTraIteQtdmov.AsFloat,11,2)+','+
                  Aspas(FormatDateTime('yyyy-mm-dd',cdsTepComTraIteDatven.AsDateTime))+','+
                  Aspas(cdsTepComTraIteUsoRece.AsString)+')';
                  QueGrava.ExecSQL(vErro);
                  if vErro <> '' then Raise Exception.Create(vErro);
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpccomite em uComTraInc -> '+E.Message);
                     MostraMsg('Erro','Não foi possível incluir o produto.'+#10+E.Message, mtWarning, [mbOk]);
                     Exit;
                  end;
               end;// try
               cdsTepComTraIte.Next;
            end;// while
         end;// if
      end;// if
   finally
      QueGrava.Close;
      QueAuxi.Close;
      QueLote.Close;
      FreeAndNil(QueGrava);
      FreeAndNil(QueAuxi);
      FreeAndNil(QueLote);
   end;// try
   Result := True;
end;

Function TFrmComTraInc.GravaProduto:Boolean;
var
   EditErro:TLMDDBLabeledEdit;
   auxIDSngpcCom,auxIDProd:Integer;
   auxRegMS,auxNrolot,auxDespro,auxRegistoMS,auxNomfab,auxUsoRece:String;
   auxQtdmov:Double;
   auxDatVen:TDatetime;
   Achou:Integer;
begin
   Result := False;
   if cdsTepComTra.IsEmpty then
   begin
      MostraMsg('Nota fiscal inválida','Nenhuma nota fiscal lançada para incluir produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if

   if cdsTepComTraIteIDProd.AsInteger <= 0 then EditErro := edDesPro else
   if cdsTepComTraIteNrolot.AsString = '' then EditErro := edNrolot else
   if cdsTepComTraIteQtdmov.AsFloat <= 0 then EditErro := edQuant;
   if EditErro <> nil then
   begin
      MostraMsg('Dado não informado','Favor preencher '+EditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
      EditErro.SetFocus;
      Exit;
   end; //if

   auxRegMS := cdsTepComTraIteRegistoMS.AsString.Trim;
   if (not(Length(auxRegMS) = 13)) or (not(IsNumeric(auxRegMS))) or (not(Copy(auxRegMS,1,1) = '1')) then
   begin
      MostraMsg('Registro MS inválido','Favor verificar o registro MS do produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if

   if edDataVen.Date <= 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a data de vencimento!',mtWarning, [mbOk]);
      edDataVen.SetFocus;
      Exit;
   end;// if
   if recAlteracaoProd = 2 then
   begin
      auxIDSngpcCom := cdsTepComTraIteIDSngpcCom.AsInteger;
      auxIDProd     := cdsTepComTraIteIDProd.AsInteger;
      auxNrolot     := cdsTepComTraIteNrolot.AsString;
      auxDespro     := cdsTepComTraIteDespro.AsString;
      auxRegistoMS  := cdsTepComTraIteRegistoMS.AsString;
      auxNomfab     := cdsTepComTraIteNomfab.AsString;
      auxQtdmov     := cdsTepComTraIteQtdmov.AsFloat;
      auxDatVen     := cdsTepComTraIteDatven.AsDateTime;
      auxUsoRece    := cdsTepComTraIteUsoRece.AsString;

      cdsTepComTraIteIDSngpcCom.AsInteger := auxIDSngpcCom;
      cdsTepComTraIteIDProd.AsInteger     := auxIDProd;
      cdsTepComTraIteNrolot.AsString      := edNrolot.Text;
      cdsTepComTraIteDespro.AsString      := auxDespro;
      cdsTepComTraIteRegistoMS.AsString   := auxRegistoMS;
      cdsTepComTraIteNomfab.AsString      := auxNomfab;
      cdsTepComTraIteQtdmov.AsFloat       := StrToFloat(edQuant.Text);
      cdsTepComTraIteDatven.AsDateTime    := edDataVen.Date;
      cdsTepComTraIteUsoRece.AsString     := auxUsoRece;
      cdsTepComTraIte.Post;
   end
   else
   begin
      cdsTepComTraIteIDSngpcCom.AsInteger := cdsTepComTraIDSngpcCom.AsInteger;
      cdsTepComTraIteIDProd.AsInteger     := edDesPro.Tag;
      cdsTepComTraIte.Post;
   end;// if

   auxIDSngpcCom := cdsTepComTraIteIDSngpcCom.AsInteger;
   auxIDProd     := cdsTepComTraIteIDProd.AsInteger;
   auxNrolot     := cdsTepComTraIteNrolot.AsString;
   auxDespro     := cdsTepComTraIteDespro.AsString;
   auxRegistoMS  := cdsTepComTraIteRegistoMS.AsString;
   auxNomfab     := cdsTepComTraIteNomfab.AsString;
   auxQtdmov     := cdsTepComTraIteQtdmov.AsFloat;
   auxDatVen     := cdsTepComTraIteDatven.AsDateTime;
   auxUsoRece    := cdsTepComTraIteUsoRece.AsString;


   cdsTepComTraIte.DisableControls;
   Achou := 0;
   cdsTepComTraIte.First;
   while not cdsTepComTraIte.Eof do
   begin
      if (cdsTepComTraIteIDSngpcCom.AsInteger = auxIDSngpcCom) and (cdsTepComTraIteIDProd.AsInteger = auxIDProd) and
         (cdsTepComTraIteNrolot.AsString = auxNrolot) then
         Inc(Achou);
      cdsTepComTraIte.Next;
   end;// while
   cdsTepComTraIte.EnableControls;
   if Achou = 2 then
   begin
      if (cdsTepComTraIteIDSngpcCom.AsInteger = auxIDSngpcCom) and (cdsTepComTraIteIDProd.AsInteger = auxIDProd) and
         (cdsTepComTraIteNrolot.AsString = auxNrolot) then
      begin
         cdsTepComTraIte.Delete;
         MostraMsg('Duplicação de produto','Favor verificar o produto e o número do lote!',mtWarning, [mbOk]);
         cdsTepComTraIte.Append;
         cdsTepComTraIteIDSngpcCom.AsInteger := auxIDSngpcCom;
         cdsTepComTraIteIDProd.AsInteger     := auxIDProd;
         cdsTepComTraIteNrolot.AsString      := auxNrolot;
         cdsTepComTraIteDespro.AsString      := auxDespro;
         cdsTepComTraIteRegistoMS.AsString   := auxRegistoMS;
         cdsTepComTraIteNomfab.AsString      := auxNomfab;
         cdsTepComTraIteQtdmov.AsFloat       := auxQtdmov;
         cdsTepComTraIteDatven.AsDateTime    := auxDatVen;
         cdsTepComTraIteUsoRece.AsString     := auxUsoRece;
         exit;
      end;// if
   end;// if
   Result := True;
end;

procedure TFrmComTraInc.BuscaInfPro;
var
   QueAuxi: TRESTDWClientSQL;
begin
   if edDespro.Text = '' then
      Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT PRO.IDProd,PRO.RegistoMS,PRO.ClasTera,PRO.UsoRece,PRO.CodEANpri,PES.IDPess,PES.Nompes FROM arqproduto PRO '+
                          'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
                          'WHERE PRO.IDProd = '+Aspas(IntToStr(edDespro.Tag));
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         cdsTepComTraIteIDProd.AsInteger   := QueAuxi.FieldByName('IDProd').AsInteger;
         cdsTepComTraIteRegistoMS.AsString := QueAuxi.FieldByName('RegistoMS').AsString;
         cdsTepComTraIteNomfab.AsString    := QueAuxi.FieldByName('Nompes').AsString;
         cdsTepComTraIteUsoRece.AsString   := QueAuxi.FieldByName('UsoRece').AsString;
      end;// if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmComTraInc.habilBotProd(Acao: Boolean);
begin
   btExcNota.Enabled   := Acao;
   btAltNota.Enabled   := Acao;
   btIncPro.Enabled    := Acao;
   btExcPro.Enabled    := Acao;
   btAltPro.Enabled    := Acao;
   PanelRodape.Enabled := Acao;
   btSalPro.Enabled    := not (Acao);
   btCanPro.Enabled    := not (Acao);
   edDesPro.Enabled    := not (Acao);
   edRegMS.Enabled     := not (Acao);
   edNrolot.Enabled    := not (Acao);
   edDataVen.Enabled   := not (Acao);
   edQuant.Enabled     := not (Acao);
   if Acao then
   begin
      edDesPro.Color  := $00EFEFEF;
      edRegMS.Color   := $00EFEFEF;
      edNrolot.Color  := $00EFEFEF;
      edDataVen.Color := $00EFEFEF;
      edQuant.Color   := $00EFEFEF;
   end
   else
   begin
      edDesPro.Color  := clWhite;
      edRegMS.Color   := clWhite;
      edNrolot.Color  := clWhite;
      edDataVen.Color := clWhite;
      edQuant.Color   := clWhite;
   end;// if
end;

procedure TFrmComTraInc.btIncProClick(Sender: TObject);
begin
   if cdsTepComTra.IsEmpty then
   begin
      MostraMsg('Nota Fiscal','Nenhuma nota fiscal selecionada para inclusão de produtos!',mtWarning, [mbOk]);
      Exit;
   end;// if
   recAlteracaoProd := 1;
   habilBotProd(False);
   edDesPro.SetFocus;
   cdsTepComTraIte.Append;
end;

procedure TFrmComTraInc.btProdutosClick(Sender: TObject);
var
   auxIDProd:Integer;
begin
   try
      Application.CreateForm(TFrmProdCad, FrmProdCad);
      if cdsTepComTraIteIDProd.AsInteger > 0 then
      begin
         FrmProdCad.recIDProd := cdsTepComTraIteIDProd.AsInteger;
         FrmProdCad.recDespro := cdsTepComTraIteDespro.AsString;
      end
      else
      begin
         FrmProdCad.recIDProd := 0;
         FrmProdCad.recDespro := '';
      end;// if
      FrmProdCad.recOrigem := 'REC';
      CentralizarControl(FrmProdCad, FrmComTraInc);
      Self.AlphaBlendValue := 155;
      FrmProdCad.ShowModal;
   finally
      Self.AlphaBlendValue := 255;
      auxIDProd := FrmProdCad.recIDProd;
      FrmProdCad   := nil;
   end; // try
end;

procedure TFrmComTraInc.btCanProClick(Sender: TObject);
begin
   habilBotProd(True);
   btIncPro.SetFocus;
   if recAlteracaoProd = 1 then
      cdsTepComTraIte.Cancel;
   if recAlteracaoProd = 2 then
   begin
      cdsTepComTraIteNrolot.AsString   := recNroLot;
      cdsTepComTraIteDatven.AsDateTime := recDatven;
      cdsTepComTraIteQtdmov.AsFloat    := recQuant;
      cdsTepComTraIte.Post;
   end;// if
end;

procedure TFrmComTraInc.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;// if
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+3, Rect.Top+2, Column.Field.DisplayText);
   end;// if
end;

procedure TFrmComTraInc.edDesProCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      FrmBuscaProd  := TFrmBuscaProd.Create(Application);
      lPoint := Self.edDespro.ClientToScreen(Point(0,0));
      FrmBuscaProd.Left   := lPoint.X;
      FrmBuscaProd.Top    := lPoint.Y;
      FrmBuscaProd.Width  := Self.edDespro.Width;
      FrmBuscaProd.edRetorno    := TEdit(Self.edDespro);
      FrmBuscaProd.edBusca.Text := TrataTecNum(Index); // Tecla precionada que esta vindo do edit edNompro (Busca produto)
      FrmBuscaProd.CamposFiltro := 'ClasTera != 0';
      FrmBuscaProd.ShowModal;
   finally
      edDespro.Text := FrmBuscaProd.auxDespro;
      edDespro.Tag  := FrmBuscaProd.edRetorno.Tag;
      FrmBuscaProd.Free;
   end;// try
   BuscaInfPro;
end;

procedure TFrmComTraInc.edDesProKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if not(ssCtrl in Shift) then
   begin
      if (Key = VK_RETURN) or (Key = VK_TAB) then
      begin
         if (Key = VK_RETURN) and (Trim(edDespro.Text) = EmptyStr) then
         begin
            edDespro.Text := '';
            edDespro.Tag  := 0;
            Key:= 0;
            Exit;
         end;// if

         if Trim(edDespro.Text) = '' then Exit;
         soInteger := iif(ExisteStr(Trim(edDespro.Text)), '', OnlyNumbers(edDespro.Text));
         if soInteger = '' then
         begin
            key := 0;
            edDesproCustomButtons0Click(Self, Key);
         end;// if
      end
      else if Key = VK_ESCAPE then
      begin
         edDespro.Text := '';
         edDespro.Tag  := 0;
      end else
      begin
         edDesproCustomButtons0Click(Self, key);
         key := 0;
      end;// if
   end;// if
end;

procedure TFrmComTraInc.edDesPro01KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if not(ssCtrl in Shift) then
   begin
      if (Key = VK_RETURN) or (Key = VK_TAB) then
      begin
         if (Key = VK_RETURN) and (Trim(edDespro.Text) = EmptyStr) then
         begin
            edDespro.Text := '';
            edDespro.Tag  := 0;
            Key:= 0;
            Exit;
         end;// if

         if Trim(edDespro.Text) = '' then Exit;
         soInteger := iif(ExisteStr(Trim(edDespro.Text)), '', OnlyNumbers(edDespro.Text));
         if soInteger = '' then
         begin
            key := 0;
            edDesproCustomButtons0Click(Self, Key);
         end;// if
      end
      else if Key = VK_ESCAPE then
      begin
         edDespro.Text := '';
         edDespro.Tag  := 0;
      end else
      begin
         edDesproCustomButtons0Click(Self, key);
         key := 0;
      end;// if
   end;// if
end;

procedure TFrmComTraInc.edFornecCustomButtons0Click(Sender: TObject; index: Integer);
begin
   edFornec.SetFocus;
   btBuscasCDS(cdsTepComTra,'arqpessoa',TDBEdit(edFornec),'IDPess','IDPess','Nompes','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',0);
end;

procedure TFrmComTraInc.edFornecKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasCDS(cdsTepComTra,'arqpessoa',TDBEdit(edFornec),'IDPess','IDPess','Nompes','Nompes','(IDEsppes = 2 OR IDEsppes = 3)',Key);
end;

procedure TFrmComTraInc.btExcNotaClick(Sender: TObject);
begin
   if cdsTepComTra.IsEmpty then
   begin
      MostraMsg('Exclusão de nota fiscal','Nenhuma nota fiscal selecionada para excluir!',mtWarning, [mbOk]);
      btExcNota.SetFocus;
      Exit;
   end;// if

   if MostraMsg('Confirmação','Deseja excluir a nota fiscal e todos os produtos ligados a ela?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   recAlteracaoNota := 3;
   // elemina todos os registro das tabelas temporárias
   cdsTepComTra.EmptyDataSet;
   cdsTepComTraIte.EmptyDataSet;

   ComboTipOpe.ItemIndex := -1;
   rbConSim.Checked      := True;
   btIncNota.Enabled     := True;
   btAltNota.Enabled     := False;
   btIncPro.Enabled      := False;
   btExcPro.Enabled      := False;
end;

procedure TFrmComTraInc.btExcProClick(Sender: TObject);
begin
   if cdsTepComTraIte.IsEmpty then
   begin
      MostraMsg('Exclusão de produto','Nenhum produto selecionado para excluir!',mtWarning, [mbOk]);
      btExcNota.SetFocus;
      Exit;
   end;// if

   if MostraMsg('Confirmação','Deseja excluir este produto '+cdsTepComTraIteDespro.AsString+' da nota fiscal?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   recAlteracaoProd := 3;
   cdsTepComTraIte.Delete;
end;

procedure TFrmComTraInc.btFecharClick(Sender: TObject);
begin
   if (recAlteracaoNota > 0) or (recAlteracaoProd > 0) then
   begin
      if MostraMsg('Confirmação','Deseja salvar as alterações feitas antes de sair?', mtConfirmation, [mbYes,mbNo]) = mrNo then
      begin
         close;
         Exit;
      end;
      if recOrigem = 'CONSULTAR' then
      begin
         if cdsTepComTra.IsEmpty then
         begin
            MostraMsg('Confirmação de alteração','Nenhuma nota fiscal selecionada para confirmar as alterações!',mtWarning, [mbOk]);
            Exit;
         end;
         GravaAlteracao;
      end;
      if recOrigem = 'INCLUIR' then
         GravaInclusao;
   end;
   Close;
end;

procedure TFrmComTraInc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // Aqui tira da memória os dados dos clientdataset
   cdsTepComTra.Close;
   cdsTepComTraIte.Close;
end;

end.
