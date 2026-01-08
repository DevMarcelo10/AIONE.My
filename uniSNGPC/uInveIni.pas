unit uInveIni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDLabel, DB,
  LMDBaseGraphicControl, LMDBaseLabel, LMDEdit, LMDCustomLabel, LMDControl, Vcl.Mask,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, MarcLib,
  Vcl.StdCtrls, RxToolEdit, RxDBCtrl, LMDBaseEdit, LMDCustomEdit, LMDDBEdit,
  LMDCustomMaskEdit, LMDCustomExtCombo, LMDCustomListComboBox, LMDMaskEdit,
  LMDListComboBox, AdvGlowButton, Vcl.ExtCtrls, AdvSmoothPanel, Vcl.Grids,
  Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBGrids, uRESTDWBasicTypes, uRESTDWBasicDB, Vcl.ComCtrls, uWaitForm,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TFrmInveIni = class(TForm)
    SouInveIni: TDataSource;
    PanelPri: TLMDSimplePanel;
    PanelProduto: TLMDSimplePanel;
    SouInveLot: TDataSource;
    PanelInventario: TLMDSimplePanel;
    LMDLabel15: TLMDLabel;
    Shape5: TShape;
    TabInveIni: TRESTDWClientSQL;
    TabInveLot: TRESTDWClientSQL;
    edResTec: TLMDDBLabeledEdit;
    panelDataAbert: TLMDSimplePanel;
    edDataAbert: TDBDateEdit;
    TabInveIniIDFilial: TIntegerField;
    TabInveIniIDInvIni: TIntegerField;
    TabInveIniIDPess: TIntegerField;
    TabInveIniDataAbe: TDateField;
    TabInveIniMailSNGPC: TWideStringField;
    TabInveIniSenhaSNGPC: TWideStringField;
    TabInveIniNompes: TWideStringField;
    TabInveLotIDFilial: TIntegerField;
    TabInveLotIDInvIni: TIntegerField;
    TabInveLotIDProd: TIntegerField;
    TabInveLotIDPess: TIntegerField;
    TabInveLotNrolot: TWideStringField;
    TabInveLotQtdest: TFloatField;
    TabInveLotDespro: TWideStringField;
    TabInveLotClasTera: TWideStringField;
    TabInveLotDatven: TDateField;
    edCPFRestec: TLMDDBLabeledEdit;
    PanelCabecalho: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    panelDataEncer: TLMDSimplePanel;
    edDataEncer: TDBDateEdit;
    LMDLabel1: TLMDLabel;
    edNumInv: TLMDDBLabeledEdit;
    edConselho: TLMDDBLabeledEdit;
    edReg: TLMDDBLabeledEdit;
    edUF: TLMDDBLabeledEdit;
    edNumLicSan: TLMDDBLabeledEdit;
    edEmailSiteSNGPC: TLMDDBLabeledEdit;
    edSenhaSNGPC: TLMDDBLabeledEdit;
    TabInveIniIndFecha: TWideStringField;
    TabInveIniDataEnc: TDateField;
    TabInveIniNumLicenSanita: TWideStringField;
    edStatusInv: TLMDDBLabeledEdit;
    TabInveLotDatFab: TDateField;
    TabInveLotRegistroMS: TWideStringField;
    TabInveIniCPFResTec: TWideStringField;
    TabInveIniNroRegProf: TWideStringField;
    TabInveIniConRegProf: TWideStringField;
    TabInveIniEstRegProf: TWideStringField;
    TabInveLotNompes: TWideStringField;
    edInv: TLMDLabeledEdit;
    TabInveLotUsoRece: TWideStringField;
    PanelIncProd: TAdvSmoothPanel;
    Shape4: TShape;
    LMDLabel4: TLMDLabel;
    LMDLabel5: TLMDLabel;
    ComboClasTera: TLMDLabeledListComboBox;
    edDespro: TLMDLabeledEdit;
    edIDProd: TLMDLabeledEdit;
    edNrolot: TLMDLabeledEdit;
    edQtdest: TLMDLabeledMaskEdit;
    edRegMS: TLMDLabeledEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    edDataFab: TDateEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataVen: TDateEdit;
    DBGrid1: TDBGrid;
    btNovoInv: TAdvGlowButton;
    btCancelaInv: TAdvGlowButton;
    btSalvarInv: TAdvGlowButton;
    btAlteraInv: TAdvGlowButton;
    btIncPro: TAdvGlowButton;
    btSalPro: TAdvGlowButton;
    btCancelaPro: TAdvGlowButton;
    btExcPro: TAdvGlowButton;
    LMDSimplePanel3: TLMDSimplePanel;
    btConfInv: TAdvGlowButton;
    btEnceInv: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure btLimpaIteClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edInvCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edResTecCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edResTecKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edStatusInvChange(Sender: TObject);
    procedure edDesproCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDesproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edInvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNumLicSanClick(Sender: TObject);
    procedure TabInveLotAfterOpen(DataSet: TDataSet);
    procedure edDataVenExit(Sender: TObject);
    procedure btNovoInvClick(Sender: TObject);
    procedure btSalvarInvClick(Sender: TObject);
    procedure btCancelaInvClick(Sender: TObject);
    procedure btAlteraInvClick(Sender: TObject);
    procedure btConfInvClick(Sender: TObject);
    procedure btEnceInvClick(Sender: TObject);
    procedure btIncProClick(Sender: TObject);
    procedure btSalProClick(Sender: TObject);
    procedure btCancelaProClick(Sender: TObject);
    procedure btExcProClick(Sender: TObject);
  private
    { Private declarations }
    Editar,emBusca:Boolean;
    auxIDFil,auxIDFabr:Integer;
    auxNomeFabr,auxUsoRece:String;
    procedure AjustGrid;
    procedure BuscaInfResTec;
    procedure CarregaInvent;
    procedure BuscaInfPro;
    procedure HabBotoes(AuxCod:Integer);
    procedure RetorConsInv;
    procedure LimpaCampos;
    procedure GravaProduto;
  public
    { Public declarations }
  end;

var
  FrmInveIni: TFrmInveIni;

implementation

uses uDM, uConst, uLibFarm, uBuscaInv, uBuscaProd;

{$R *.dfm}

procedure TFrmInveIni.FormShow(Sender: TObject);
begin
   Left := (Parent.Width  - Width)  div 2;
   Top  := (Parent.Height - Height) div 2;
   CarregaInvent;
   AjustGrid;
   Editar   := False;
   emBusca  := False;
   auxIDFil := FILIAL;
   edInv.SetFocus;
   edDataFab.Text := '';
   edDataVen.Text := '';
end;

procedure TFrmInveIni.CarregaInvent;
begin
   try
      TabInveIni.Close;
      TabInveIni.SQL.Text := 'SELECT INV.*,PES.Nompes FROM arqsngpcinve INV LEFT JOIN arqpessoa PES '+
      'ON INV.IDPess = PES.IDPess  WHERE INV.IDFilial = '+FILIAL.ToString+' ORDER BY INV.IDInvIni DESC LIMIT 1';
      TabInveIni.Open;
      if not TabInveIni.IsEmpty then
      begin
         btConfInv.Enabled := True;
         TabInveLot.Close;
         TabInveLot.SQL.Text := 'SELECT INV.*, PRO.Despro, PES.Nompes FROM arqsngpcinvelot INV '+
         'INNER JOIN arqproduto PRO ON INV.IDProd = PRO.IDProd '+
         'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
         ' WHERE INV.IDFilial = '+TabInveIniIDFilial.AsString+' AND IDInvIni = '+TabInveIniIDInvIni.AsString;
         TabInveLot.Open;
      end;// if
      if TabInveIniIndFecha.AsString = '0' then
      begin
         edNumLicSan.Enabled := True;
         edNumLicSan.Color   := clWhite;
         btExcPro.Enabled    := True;
      end
      else if TabInveIniIndFecha.AsString = '1' then
      begin
         btNovoInv.Enabled   := False;
         btIncPro.Enabled    := False;
         btConfInv.Enabled   := False;
         btEnceInv.Enabled   := True;
         edNumLicSan.Enabled := True;
         edNumLicSan.Color   := clWhite;
      end
      else if TabInveIniIndFecha.AsString = '2' then
      begin
         btNovoInv.Enabled := True;
         btIncPro.Enabled  := False;
         btConfInv.Enabled := False;
      end;// if
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;// try
end;

procedure TFrmInveIni.btCancelaInvClick(Sender: TObject);
begin
   HabBotoes(5);
   CarregaInvent;
end;

procedure TFrmInveIni.btConfInvClick(Sender: TObject);
var
   QueGrava:TRESTDWClientSQL;
   vErro:String;
   Frm: Tform;
   Msg: Tlabel;
   Borda: TShape;
begin
   if MostraMsg('Confirmação','Deseja confirmar este inventário?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;

   ShowWait('Aguarde...', Self);
   QueGrava := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;
   try
      try
         QueGrava.Close;
         QueGrava.SQL.Text := 'UPDATE arqsngpcinve SET IndFecha = 1 WHERE IDInvIni = '+TabInveIniIDInvIni.AsString;
         QueGrava.ExecSQL(vErro);
      except // try
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar a confirmação do inventário em arqsngpcinve na uInveIni -> '+E.Message);
            MostraMsg('Erro','Não foi possível gravar as alterações.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try

      TabInveLot.First;
      while not TabInveLot.Eof do
      begin
         try
            QueGrava.Close;
            QueGrava.SQL.Text := 'INSERT INTO arqsngpclot (IDFilial,IDInvIni,IDProd,Nrolot,IDPess,Datfab,Datven,UsoRece,Qtdest) VALUES ('+
            TabInveLotIDFilial.AsString+','+
            TabInveLotIDInvIni.AsString+','+
            TabInveLotIDProd.AsString+','+
            TabInveLotNrolot.AsString+','+
            TabInveLotIDPess.AsString+','+
            Aspas(FormatDateTime('yyyy-mm-dd',TabInveLotDatFab.AsDateTime))+','+
            Aspas(FormatDateTime('yyyy-mm-dd',TabInveLotDatven.AsDateTime))+','+
            Aspas(TabInveLotUsoRece.AsString)+','+
            FormatDouble(TabInveLotQtdest.AsFloat,11,2)+')';
            QueGrava.ExecSQL(vErro);
            if vErro <> '' then Raise Exception.Create(vErro);
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível gravar a confirmação do inventário em arqsngpcinve na uInveIni -> '+E.Message);
               MostraMsg('Erro','Não foi possível salvar alterações.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try4
         TabInveLot.Next;
      end;// while
   finally
      QueGrava.Close;
      FreeAndNil(QueGrava);
      HideWait;
   end;// try
   HabBotoes(6);
   TabInveIni.Close;
   TabInveIni.Open;
end;

procedure TFrmInveIni.btEnceInvClick(Sender: TObject);
var
   QueGrava:TRESTDWClientSQL;
   vErro:String;
begin
   if MostraMsg('Confirmação','Deseja encerrar este inventário?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;

   QueGrava := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;
   try
      try
         QueGrava.Close;
         QueGrava.SQL.Text := 'UPDATE arqsngpcinve SET IndFecha = 2, DataEnc = '+Aspas(FormatDateTime('yyyy-mm-dd',Now))+
         ' WHERE IDInvIni = '+TabInveIniIDInvIni.AsString;
         QueGrava.ExecSQL(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar o encerramento do inventário em arqsngpcinve na uInveIni -> '+E.Message);
            MostraMsg('Erro','Não foi possível gravar as alterações.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
   finally
      QueGrava.Close;
      FreeAndNil(QueGrava);
   end;// try
   TabInveIni.Close;
   TabInveIni.Open;
   HabBotoes(7);
end;

procedure TFrmInveIni.btIncProClick(Sender: TObject);
begin
   if not (TabInveIniIndFecha.AsString = '0') then
   begin
      MostraMsg('Aviso','Inventário já fechado!',mtWarning, [mbOk]);
      edInv.SetFocus;
      Exit;
   end;// if
   HabBotoes(8);
   edDespro.SetFocus;
end;

procedure TFrmInveIni.btSalProClick(Sender: TObject);
begin
   if edDataVen.Focused then // Se o focu está na data de vencimento.
      DBGrid1.SetFocus // Tira o foco da Data de vencimento para executar a gravação.
   else
   begin
      GravaProduto;
      btIncPro.Click;
   end;
end;

procedure TFrmInveIni.btCancelaProClick(Sender: TObject);
begin
   LimpaCampos;
   TabInveLot.Close;
   TabInveLot.Open;
end;

procedure TFrmInveIni.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmInveIni.edInvCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
   recWidth:Integer;
begin
   try
      recWidth:= 0;
      FrmBuscaInv  := TFrmBuscaInv.Create(Application);
      lPoint := Self.edInv.ClientToScreen(Point(0,0));
      FrmBuscaInv.Left   := lPoint.X;
      FrmBuscaInv.Top    := lPoint.Y;
      FrmBuscaInv.Width:= iif(recWidth > 0, recWidth, Self.edInv.Width);
      FrmBuscaInv.edRetorno    := TEdit(Self.edInv);
      FrmBuscaInv.edBusca.Text := TrataTecNum(Index); // Tecla precionada que esta vindo do edit edNompro (Busca produto)
      FrmBuscaInv.ShowModal;
   finally
      edInv.Text := FrmBuscaInv.auxNompes;
      edInv.Tag  := FrmBuscaInv.edRetorno.Tag;
      FrmBuscaInv.Free;
   end;// try
   if edInv.Tag > 0 then RetorConsInv;
end;

procedure TFrmInveIni.edInvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   soInteger:String;
begin
   if not(ssCtrl in Shift) then
   begin
      if (Key = VK_RETURN) or (Key = VK_TAB) then
      begin
         if (Key = VK_RETURN) and (Trim(edInv.Text) = EmptyStr) then
         begin
            edInv.Text := '';
            edInv.Tag  := 0;
            Key:= 0;
            Exit;
         end;// if

         if Trim(edInv.Text) = '' then Exit;
         soInteger := iif(ExisteStr(Trim(edInv.Text)), '', OnlyNumbers(edInv.Text));
         if soInteger = '' then
         begin
            key := 0;
            edInvCustomButtons0Click(Self, Key);
         end;// if
      end
      else if Key = VK_ESCAPE then
      begin
         edInv.Text := '';
         edInv.Tag  := 0;
      end else
      begin
         edInvCustomButtons0Click(Self, key);
         key := 0;
      end;// if
   end;// if
end;

procedure TFrmInveIni.BuscaInfPro;
var
   QueAuxi: TRESTDWClientSQL;
begin
   if edDespro.Text = '' then
      Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT PRO.IDProd,PRO.RegistoMS,PRO.ClasTera,PRO.UsoRece,PES.IDPess,PES.Nompes FROM arqproduto PRO '+
                          'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
                          'WHERE PRO.IDProd = '+Aspas(IntToStr(edDespro.Tag));
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         edIDProd.Text           := QueAuxi.FieldByName('IDProd').AsString;
         edRegMS.Text            := QueAuxi.FieldByName('RegistoMS').AsString;
         ComboClasTera.ItemIndex := QueAuxi.FieldByName('ClasTera').AsInteger;
         auxUsoRece              := QueAuxi.FieldByName('UsoRece').AsString;
         auxIDFabr               := QueAuxi.FieldByName('IDPess').AsInteger;
         auxNomeFabr             := QueAuxi.FieldByName('Nompes').AsString;
      end;// if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmInveIni.edNumLicSanClick(Sender: TObject);
begin
   if (TabInveIniIndFecha.AsString = '0') or (TabInveIniIndFecha.AsString = '1') then
      btAlteraInv.Enabled := True;
   if not(TabInveIni.State in dsEditModes) then TabInveIni.Edit;
end;

procedure TFrmInveIni.edDesproKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

   BuscaInfPro;
end;

procedure TFrmInveIni.edDesproCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
   recWidth:Integer;
begin
   try
      recWidth:= 0;
      FrmBuscaProd  := TFrmBuscaProd.Create(Application);
      lPoint := Self.edDespro.ClientToScreen(Point(0,0));
      FrmBuscaProd.Left   := lPoint.X;
      FrmBuscaProd.Top    := lPoint.Y;
      FrmBuscaProd.Width:= iif(recWidth > 0, recWidth, Self.edDespro.Width);
      FrmBuscaProd.edRetorno   := TEdit(Self.edDespro);
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

procedure TFrmInveIni.BuscaInfResTec;
var
   QueAuxi: TRESTDWClientSQL;
begin
   if edResTec.Text = '' then
      Exit;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT CpfCnpjPes,ConRegProf,NroRegProf,EstRegProf FROM arqpessoa '+
                          'WHERE IDPess = '+ TabInveIniIDPess.AsString;
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         TabInveIniCPFResTec.AsString  := QueAuxi.FieldByName('CpfCnpjPes').AsString;
         TabInveIniConRegProf.AsString := QueAuxi.FieldByName('ConRegProf').AsString;
         TabInveIniNroRegProf.AsString := QueAuxi.FieldByName('NroRegProf').AsString;
         TabInveIniEstRegProf.AsString := QueAuxi.FieldByName('EstRegProf').AsString;
      end;// if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmInveIni.edResTecCustomButtons0Click(Sender: TObject; index: Integer);
begin
   edResTec.SetFocus;
   btBuscasDB(TabInveIni,'arqpessoa',TDBEdit(edResTec),'IDPess','IDPess','Nompes','Nompes','IDEsppes = 10',0);
   BuscaInfResTec;
end;

procedure TFrmInveIni.edResTecKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabInveIni,'arqpessoa',TDBEdit(edResTec),'IDPess','IDPess','Nompes','Nompes','IDEsppes = 10',Key);
   BuscaInfResTec;
end;

procedure TFrmInveIni.edStatusInvChange(Sender: TObject);
begin
   if TabInveIniIndFecha.AsString = '0' then
      edStatusInv.Text := 'ABERTO'
   else if TabInveIniIndFecha.AsString = '1' then
      edStatusInv.Text := 'CONFIRMADO'
   else if TabInveIniIndFecha.AsString = '2' then
      edStatusInv.Text := 'ENCERRADO'
end;

procedure TFrmInveIni.btAlteraInvClick(Sender: TObject);
var
   QueGrava:TRESTDWClientSQL;
   vErro:String;
begin
   if MostraMsg('Confirmação','Deseja alterar o número da licença sanitária?', mtConfirmation, [mbYes,mbNo]) = mrNo then
   begin
      TabInveIni.Close;
      TabInveIni.Open;
      edInv.SetFocus;
      btAlteraInv.Enabled := False;
      Exit;
   end;// if

   if TabInveIniNumLicenSanita.AsString = '' then
   begin
      MostraMsg('Dado não informado','Favor preencher o número da licença sanitária corretamente!',mtWarning, [mbOk]);
      edNumLicSan.SetFocus;
      Exit;
   end; //if

   QueGrava := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;
   try
      try
         QueGrava.Close;
         QueGrava.SQL.Text := 'UPDATE arqsngpcinve SET '+
                              'NumLicenSanita = '+Aspas(edNumLicSan.Text) +
                              'WHERE IDInvIni = '+TabInveIniIDInvIni.AsString;
         QueGrava.ExecSQL(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar a alteração do número da licença sanitária em arqsngpcinve na uInveIni -> '+E.Message);
            MostraMsg('Erro','Não foi possível gravar a alteração do número da licença sanitária.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
   finally
      QueGrava.Close;
      FreeAndNil(QueGrava);
   end;// try
   TabInveIni.Close;
   TabInveIni.Open;
   btAlteraInv.Enabled := False;
   edInv.SetFocus;
end;

procedure TFrmInveIni.btSalvarInvClick(Sender: TObject);
var
   QueGrava:TRESTDWClientSQL;
   DBEditErro:TLMDDBLabeledEdit;
   vErro:String;
begin
   btSalvarInv.SetFocus;
   if TabInveIniIDPess.AsInteger <= 0 then DBEditErro := edResTec else
   if TabInveIniCPFResTec.AsString = '' then DBEditErro := edCPFRestec else
   if TabInveIniConRegProf.AsString = ''  then DBEditErro := edConselho else
   if TabInveIniNroRegProf.AsString = '' then DBEditErro := edReg else
   if TabInveIniEstRegProf.AsString = '' then DBEditErro := edUF else
   if TabInveIniNumLicenSanita.AsString = '' then DBEditErro := edNumLicSan else
   if TabInveIniMailSNGPC.AsString = '' then DBEditErro := edEmailSiteSNGPC else
   if TabInveIniSenhaSNGPC.AsString = '' then DBEditErro := edSenhaSNGPC;

   if DBEditErro <> nil then
   begin
      MostraMsg('Dado não informado','Favor preencher '+DBEditErro.ValidationMsgString+' corretamente!',mtWarning, [mbOk]);
      DBEditErro.SetFocus;
      Exit;
   end; //if

   if TabInveIniDataAbe.AsDateTime = 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a Data de abertura!',mtWarning, [mbOk]);
      edDataAbert.SetFocus;
      Exit;
   end;// if

   QueGrava := TRESTDWClientSQL.Create(nil);
   try
      QueGrava.DataBase := DM.DWDataBase;
      try
         QueGrava.SQL.Text := 'INSERT INTO arqsngpcinve (IDFilial,IDPess,DataAbe,MailSNGPC,SenhaSNGPC,IndFecha,'+
                              'NumLicenSanita,CPFResTec,NroRegProf,ConRegProf,EstRegProf) VALUES ('+
         auxIDFil.ToString+','+
         TabInveIniIDPess.AsString+','+
         Aspas(FormatDateTime('yyyy-mm-dd',TabInveIniDataAbe.AsDateTime))+','+
         Aspas(TabInveIniMailSNGPC.AsString)+','+
         Aspas(TabInveIniSenhaSNGPC.AsString)+','+
         Aspas('0')+','+
         Aspas(TabInveIniNumLicenSanita.AsString)+','+
         Aspas(TabInveIniCPFResTec.AsString)+','+
         Aspas(TabInveIniNroRegProf.AsString)+','+
         Aspas(TabInveIniConRegProf.AsString)+','+
         Aspas(TabInveIniEstRegProf.AsString)+')';
         QueGrava.ExecSQL(vErro);
         if vErro <> '' then Raise Exception.Create(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpcinve em uInveIni -> '+E.Message);
            MostraMsg('Erro','Não foi possível incluir o inventário.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
      TabInveIni.Close;
      TabInveIni.SQL.Text := 'SELECT INV.*,PES.Nompes FROM arqsngpcinve INV '+
                             'LEFT JOIN arqpessoa PES ON INV.IDPess = PES.IDPess'+
                             ' WHERE INV.IDFilial = '+FILIAL.ToString+
                             ' ORDER BY INV.IDInvIni DESC LIMIT 1';
      TabInveIni.Open;
      if not TabInveIni.IsEmpty then
      begin
         TabInveLot.Close;
         TabInveLot.SQL.Text := 'SELECT INV.*, PRO.Despro, PES.Nompes FROM arqsngpcinvelot INV '+
                                'INNER JOIN arqproduto PRO ON INV.IDProd = PRO.IDProd '+
                                'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
                                ' WHERE INV.IDFilial = '+TabInveIniIDFilial.AsString+
                                ' AND IDInvIni = '+TabInveIniIDInvIni.AsString;
         TabInveLot.Open;
      end;// if
   finally
      QueGrava.Close;
      FreeAndNil(QueGrava);
   end;// try
   HabBotoes(4);
end;

procedure TFrmInveIni.btLimpaIteClick(Sender: TObject);
begin
   if MostraMsg('Confirmação','Deseja excluir este produto do inventário?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;

   LimpaCampos;
end;

procedure TFrmInveIni.btNovoInvClick(Sender: TObject);
var
   QueAuxi,QueExcl:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueExcl := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueExcl.DataBase := DM.DWDataBase;
   try
      QueAuxi.SQL.Text := 'SELECT * FROM arqsngpcinve WHERE IndFecha = 0';
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         if MostraMsg('Confirmação','Deseja apagar todas informações do inventário atual e criar outro?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
         if MostraMsg('Confirmação','Tem certeza que deseja apagar todas informações do inventário atual e criar outro?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;

         QueExcl.Close;
         QueExcl.SQL.Text := 'DELETE FROM arqsngpcinve'+
                             ' WHERE IDFilial = '+QueAuxi.FieldByName('IDFilial').AsString+
                             ' AND IDInvIni = '+QueAuxi.FieldByName('IDInvIni').AsString+'; '+
                             'DELETE FROM arqsngpcinvelot'+
                             ' WHERE IDFilial = '+QueAuxi.FieldByName('IDFilial').AsString+
                             ' AND IDInvIni = '+QueAuxi.FieldByName('IDInvIni').AsString+';';
         QueExcl.ExecSQL;
      end
      else
      begin
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT * FROM arqsngpcinve WHERE IndFecha = 1';
         QueAuxi.Open;
         if not QueAuxi.IsEmpty then
         begin
            MostraMsg('Inventário','Já consta um inventário confirmado, por tanto não é possivel criar outro inventário!',mtWarning, [mbOk]);
            Exit;
         end;// if
      end;// if
   finally
      QueAuxi.Close;
      QueExcl.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueExcl);
   end;// try
   TabInveIni.Append;
   TabInveLot.Close;
   HabBotoes(3);
   edResTec.SetFocus
end;

procedure TFrmInveIni.edDataVenExit(Sender: TObject);
begin
   GravaProduto;
   btIncPro.Click;
end;

procedure TFrmInveIni.GravaProduto;
var
   QueGrava,Queauxi:TRESTDWClientSQL;
   vErro,auxRegMS:String;
   Frm: Tform;
   Msg: Tlabel;
   Borda: TShape;
begin
   Queauxi := TRESTDWClientSQL.Create(nil);
   Queauxi.DataBase := DM.DWDataBase;
   Queauxi.SQL.Text := 'SELECT IDFilial,IDInvIni,IDPess FROM arqsngpcinve '+
                       'WHERE IndFecha = 0'+
                       ' AND IDFilial = '+TabInveIniIDFilial.AsString+
                       ' AND IDInvIni = '+TabInveIniIDInvIni.AsString+
                       ' AND IDPess = '+TabInveIniIDPess.AsString;
   Queauxi.Open;
   if Queauxi.IsEmpty then
   begin
      MostraMsg('Inventário inválido','Nenhum inventário em aberto para incluir produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if

   if StrToInt(edIDProd.Text) <= 0 then
   begin
      MostraMsg('Código do produto inválido','Favor verificar o código do produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if

   if edNrolot.Text.Trim = '' then
   begin
      MostraMsg('Número do lote inválido','Favor verificar o número do lote!',mtWarning, [mbOk]);
      edNrolot.SetFocus;
      Exit;
   end;// if

   auxRegMS := edRegMS.Text.Trim;
   if (not(Length(auxRegMS) = 13)) and (not(IsNumeric(auxRegMS))) and (Copy(auxRegMS,1,1) = '1') then
   begin
      MostraMsg('Registro MS inválido','Favor verificar o registro MS do produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if

   if auxIDFabr <= 0 then
   begin
      MostraMsg('Fabricante inválido','Favor verificar o fabricante do produto!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if

   if edQtdest.AsFloat < 0  then
   begin
      MostraMsg('Quantidade inválida','Favor verificar a quantidade do produto!',mtWarning, [mbOk]);
      edQtdest.SetFocus;
      Exit;
   end;// if

   if ComboClasTera.itemindex = 0 then
   begin
      MostraMsg('Classe terapêutica inválida','Favor verificar a classe terapêutica do produto!',mtWarning, [mbOk]);
      ComboClasTera.SetFocus;
      Exit;
   end;// if

   if edDataFab.Date = 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a data de Fabricação!',mtWarning, [mbOk]);
      edDataFab.SetFocus;
      Exit;
   end;// if

   if edDataVen.Date = 0 then
   begin
      MostraMsg('Data inválida','Favor verificar a data de vencimento!',mtWarning, [mbOk]);
      edDataVen.SetFocus;
      Exit;
   end;// if
   QueGrava := TRESTDWClientSQL.Create(nil);
   QueGrava.DataBase := DM.DWDataBase;

   QueGrava.SQL.Text := 'SELECT IDFilial,IDInvIni,IDPess,IDProd,Nrolot FROM arqsngpcinvelot '+
                        'WHERE IDFilial = '+TabInveIniIDFilial.AsString+
                        ' AND IDInvIni = '+TabInveIniIDInvIni.AsString+
                        ' AND IDPess = '+auxIDFabr.ToString+
                        ' AND IDProd = '+Aspas(edIDProd.Text)+
                        ' AND Nrolot = '+Aspas(edNrolot.Text);
   QueGrava.Open;
   if not QueGrava.IsEmpty then
   begin
      MostraMsg('Duplicação de produto','Favor verificar o produto e o número do lote!',mtWarning, [mbOk]);
      edDespro.SetFocus;
      Exit;
   end;// if
   //////////////////////////////////////////////////////////////////////////////////
   ///Mensagem de "Aguarde" enquanto executa o procedimento de carregamento do XML///
   Frm             :=  TForm.Create(Application);
   Frm.BorderStyle := bsNone;
   Frm.Position    := poDesktopCenter;
   Frm.Width       := 300;
   Frm.Height      := 170; //até aqui criamos o form

   Borda        := TShape.Create(Application);
   Borda.Parent := Frm;
   Borda.Align  := alClient; // uma borda envolta do form

   Msg             :=TLabel.Create(Application);
   Msg.Parent      :=Frm;
   Msg.Transparent := true;
   Msg.AutoSize    := false;
   Msg.Font.Size   := 28;
   Msg.Width       := 300;
   Msg.Height      := 168;
   Msg.Caption     :=#13 + 'Aguarde...';
   msg.Align       := TAlign(5);
   Msg.Alignment   := taCenter;//label com a mensagem "Aguarde"
   Frm.Show;
   Frm.Update;
   //////////////////////////////////////////////////
   try
      try
         QueGrava.Close;
         QueGrava.SQL.Text := 'INSERT INTO arqsngpcinvelot (IDFilial,IDInvIni,IDProd,IDPess,Nrolot,Qtdest,DatFab,DatVen,'+
                              'RegistroMS,ClasTera,UsoRece) VALUES ('+
         auxIDFil.ToString+','+
         TabInveIniIDInvIni.AsString+','+
         Aspas(edIDProd.Text)+','+
         auxIDFabr.ToString+','+
         Aspas(edNrolot.Text)+','+
         FormatDouble(edQtdest.AsFloat,11,2)+','+
         Aspas(FormatDateTime('yyyy-mm-dd',edDataFab.Date))+','+
         Aspas(FormatDateTime('yyyy-mm-dd',edDataVen.Date))+','+
         Aspas(auxRegMS)+','+
         Aspas(IntToStr(ComboClasTera.ItemIndex))+','+
         Aspas(auxUsoRece)+')';
         QueGrava.ExecSQL(vErro);
         if vErro <> '' then Raise Exception.Create(vErro);
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível gravar em arqsngpcinvelot em uInveIni -> '+E.Message);
            MostraMsg('Erro','Não foi possível incluir o produto no inventário.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
      TabInveLot.Close;
      TabInveLot.Open;
   finally
      QueGrava.Close;
      Queauxi.Close;
      FreeAndNil(QueGrava);
      FreeAndNil(Queauxi);
      Frm.Free; //E finalmente libera a janela da mensagem de aguarde.
   end;// try
   LimpaCampos;
end;

procedure TFrmInveIni.DBGrid1CellClick(Column: TColumn);
begin
// VERIFICAR ANTES SE NÃO HOUVE MOVIMENTAÇÃO DE COMPRAS OU VENDAS ANTES DE EXCLUIR ESTE.
   if Column.ID = 8 then
   begin
      if TabInveLot.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação deste Lote?',mtConfirmation, [mbYes, mbNo]) = mrYes then
            TabInveLot.Delete;
      end; //if
      DBGrid1.SelectedField := TabInveLotDatven;
   end;// if
end;

procedure TFrmInveIni.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;// if
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
//   if Column.ID = 8 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+2, 0);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;// if
   if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('ClasTera') then
   begin
      if Column.Field.Asstring = '0' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
      end else if Column.Field.Asstring = '1' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'ANTIMICROBIANO');
      end else if Column.Field.Asstring = '2' then
      begin
         DBGrid1.Canvas.FillRect(Rect);
         DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'PSICOTRÓPICO');
      end;// if
   end;// if
end;

procedure TFrmInveIni.LimpaCampos;
begin
   edIDProd.Text     := '';
   edDespro.Text     := '';
   edDespro.Tag      := 0;
   edNrolot.Text     := '';
   edQtdest.AsFloat  := 0;
   edDataFab.Text    := '';
   edDataVen.Text    := '';
   edRegMS.Text      := '';
   ComboClasTera.ItemIndex := 0;
   HabBotoes(9);
   btIncPro.SetFocus;
end;

procedure TFrmInveIni.TabInveLotAfterOpen(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmInveIni.btExcProClick(Sender: TObject);
var
   QueAuxi: TRESTDWClientSQL;
   Index:Integer;
begin
   if TabInveLot.IsEmpty then
   begin
      MostraMsg('Exclusão de produto','Não consta mais nenhum produto neste inventário para excluir!',mtWarning, [mbOk]);
      edInv.SetFocus;
      Exit;
   end;// if

   if MostraMsg('Confirmação','Deseja excluir este produto '+TabInveLotDespro.AsString+' do inventário?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;

   if TabInveIniIndFecha.AsString <> '0' then
   begin
      MostraMsg('Exclusão de produto','Favor verificar o Inventário, ele deve estar em aberto para poder excluir produto!',mtWarning, [mbOk]);
      edInv.SetFocus;
      Exit;
   end;// if

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'DELETE FROM arqsngpcinvelot'+
                          ' WHERE IDFilial = '+TabInveLotIDFilial.AsString+
                          ' AND IDInvIni = '+TabInveLotIDInvIni.AsString+
                          ' AND IDPess = '+TabInveLotIDPess.AsString+
                          ' AND IDProd = '+TabInveLotIDProd.AsString+
                          ' AND Nrolot = '+Aspas(TabInveLotNrolot.AsString);
      QueAuxi.ExecSQL;
      TabInveLot.Close;
      TabInveLot.Open;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;// try
end;

procedure TFrmInveIni.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmInveIni.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Editar then
      if MostraMsg('Confirmação','Não será salva nenhuma modificação. Deseja sair?', mtConfirmation, [mbYes,mbNo]) = mrNo then
         CanClose := False;
end;

procedure TFrmInveIni.RetorConsInv;
begin
   try
      TabInveIni.Close;
      TabInveIni.SQL.Text := 'SELECT INV.*,PES.Nompes FROM arqsngpcinve INV '+
                             'LEFT JOIN arqpessoa PES ON INV.IDPess = PES.IDPess'+
                             ' WHERE INV.IDFilial = '+FILIAL.ToString+
                             ' AND INV.IDInvIni = '+Aspas(IntToStr(edInv.Tag))+
                             ' ORDER BY INV.IDInvIni DESC LIMIT 1';
      TabInveIni.Open;
      if not TabInveIni.IsEmpty then
      begin
         TabInveLot.Close;
         TabInveLot.SQL.Text := 'SELECT INV.*, PRO.Despro, PES.Nompes FROM arqsngpcinvelot INV '+
                                'INNER JOIN arqproduto PRO ON INV.IDProd = PRO.IDProd '+
                                'INNER JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess '+
                                ' WHERE INV.IDFilial = '+TabInveIniIDFilial.AsString+
                                ' AND INV.IDInvIni = '+TabInveIniIDInvIni.AsString;
         TabInveLot.Open;
      end;// if
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;// try
//   HabBotoes(StrToInt(TabInveIniIndFecha.AsString));
end;

procedure TFrmInveIni.HabBotoes(AuxCod:Integer);
begin
   if AuxCod = 0 then
   begin
      btNovoInv.Enabled    := True;
      btConfInv.Enabled    := True;
      btIncPro.Enabled     := True;
      btSalvarInv.Enabled  := False;
      btCancelaInv.Enabled := False;
      btEnceInv.Enabled    := False;
      btCancelaPro.Enabled := False;
      btSalPro.Enabled     := False;
      btExcPro.Enabled     := False;
   end
   else if AuxCod = 1 then
   begin
      btEnceInv.Enabled    := True;
      btNovoInv.Enabled    := False;
      btConfInv.Enabled    := False;
      btIncPro.Enabled     := False;
      btSalvarInv.Enabled  := False;
      btCancelaInv.Enabled := False;
      btCancelaPro.Enabled := False;
      btSalPro.Enabled     := False;
      btExcPro.Enabled     := False;
   end
   else if AuxCod = 2 then
   begin
      btNovoInv.Enabled    := True;
      btEnceInv.Enabled    := False;
      btConfInv.Enabled    := False;
      btIncPro.Enabled     := False;
      btSalvarInv.Enabled  := False;
      btCancelaInv.Enabled := False;
      btCancelaPro.Enabled := False;
      btSalPro.Enabled     := False;
      btExcPro.Enabled     := False;
   end
   else if AuxCod = 3 then //Botão novo inventário.
   begin
      edResTec.Enabled         := True;
      edDataAbert.Enabled      := True;
      edNumLicSan.Enabled      := True;
      edEmailSiteSNGPC.Enabled := True;
      edSenhaSNGPC.Enabled     := True;
      edResTec.Color           := clWhite;
      edDataAbert.Color        := clWhite;
      edNumLicSan.Color        := clWhite;
      edEmailSiteSNGPC.Color   := clWhite;
      edSenhaSNGPC.Color       := clWhite;
      edInv.Enabled            := False;
      edinv.Color              := $00EFEFEF;
      btSalvarInv.Enabled      := True;
      btCancelaInv.Enabled     := True;
      btNovoInv.Enabled        := False;
      btConfInv.Enabled        := False;
      btIncPro.Enabled         := False;
      btExcPro.Enabled         := False;
      PanelCabecalho.Enabled   := False;
      PanelInventario.Enabled  := True;
   end
   else if AuxCod = 4 then //Botão confirma novo inventário.
   begin
      edResTec.Enabled         := False;
      edDataAbert.Enabled      := False;
      edEmailSiteSNGPC.Enabled := False;
      edSenhaSNGPC.Enabled     := False;
      edResTec.Color           := $00EFEFEF;
      edDataAbert.Color        := $00EFEFEF;
      edEmailSiteSNGPC.Color   := $00EFEFEF;
      edSenhaSNGPC.Color       := $00EFEFEF;
      edInv.Enabled            := True;
      edinv.Color              := clWhite;
      btNovoInv.Enabled        := True;
      btSalvarInv.Enabled      := False;
      btCancelaInv.Enabled     := False;
      btConfInv.Enabled        := True;
      btIncPro.Enabled         := True;
      btExcPro.Enabled         := True;
      PanelCabecalho.Enabled   := True;
      PanelInventario.Enabled  := True;
   end
   else if AuxCod = 5 then //Botão cancela novo inventário.
   begin
      edResTec.Enabled         := False;
      edDataAbert.Enabled      := False;
      edNumLicSan.Enabled      := False;
      edEmailSiteSNGPC.Enabled := False;
      edSenhaSNGPC.Enabled     := False;
      edResTec.Color           := $00EFEFEF;
      edDataAbert.Color        := $00EFEFEF;
      edNumLicSan.Color        := $00EFEFEF;
      edEmailSiteSNGPC.Color   := $00EFEFEF;
      edSenhaSNGPC.Color       := $00EFEFEF;
      edInv.Enabled            := True;
      edinv.Color              := clWhite;
      btNovoInv.Enabled        := True;
      btSalvarInv.Enabled      := False;
      btCancelaInv.Enabled     := False;
      btIncPro.Enabled         := False;
      btExcPro.Enabled         := False;
      PanelCabecalho.Enabled   := True;
      PanelInventario.Enabled  := True;
   end
   else if AuxCod = 6 then //Botão confirma inventário.
   begin
      btNovoInv.Enabled     := False;
      btSalvarInv.Enabled   := False;
      btCancelaInv.Enabled  := False;
      btConfInv.Enabled     := False;
      btIncPro.Enabled      := False;
      btSalPro.Enabled      := False;
      btCancelaPro.Enabled  := False;
      btExcPro.Enabled      := False;
      btEnceInv.Enabled     := True;
      edNumLicSan.Enabled   := True;
      edNumLicSan.Color     := clWhite;
      edDespro.Enabled      := False;
      edRegMS.Enabled       := False;
      ComboClasTera.Enabled := False;
      edQtdest.Enabled      := False;
      edNrolot.Enabled      := False;
      edDataFab.Enabled     := False;
      edDataVen.Enabled     := False;
      edDespro.Color        := $00EFEFEF;
      edRegMS.Color         := $00EFEFEF;
      ComboClasTera.Color   := $00EFEFEF;
      edQtdest.Color        := $00EFEFEF;
      edNrolot.Color        := $00EFEFEF;
      edDataFab.Color       := $00EFEFEF;
      edDataVen.Color       := $00EFEFEF;
   end
   else if AuxCod = 7 then //Botão encerrar inventário.
   begin
      btNovoInv.Enabled   := True;
      btEnceInv.Enabled   := False;
      edNumLicSan.Enabled := False;
      edNumLicSan.Color   := $00EFEFEF;
   end
   else if AuxCod = 8 then //Botão incluir produto no inventário.
   begin
      edDespro.Enabled       := True;
      edNrolot.Enabled       := True;
      edQtdest.Enabled       := True;
      edDataFab.Enabled      := True;
      edDataVen.Enabled      := True;
      edRegMS.Enabled        := True;
      ComboClasTera.Enabled  := True;
      edDespro.Color         := clWhite;
      edNrolot.Color         := clWhite;
      edQtdest.Color         := clWhite;
      edDataFab.Color        := clWhite;
      edDataVen.Color        := clWhite;
      edRegMS.Color          := clWhite;
      ComboClasTera.Color    := clWhite;
      btSalPro.Enabled       := True;
      btCancelaPro.Enabled   := True;
      btIncPro.Enabled       := False;
      btExcPro.Enabled       := False;
      PanelCabecalho.Enabled  := False;
      PanelInventario.Enabled := False;
   end
   else if AuxCod = 9 then //Botão confirma produto no inventário.
   begin
      btSalPro.Enabled    := False;
      btCancelaPro.Enabled := False;
      btIncPro.Enabled    := True;
      edDespro.Enabled    := False;
      edNrolot.Enabled    := False;
      edQtdest.Enabled    := False;
      edDataFab.Enabled   := False;
      edDataVen.Enabled   := False;
      edDespro.Color      := $00EFEFEF;
      edNrolot.Color      := $00EFEFEF;
      edQtdest.Color      := $00EFEFEF;
      edDataFab.Color     := $00EFEFEF;
      edDataVen.Color     := $00EFEFEF;
      edRegMS.Color       := $00EFEFEF;
      ComboClasTera.Color := $00EFEFEF;
      btExcPro.Enabled    := True;
      PanelCabecalho.Enabled  := True;
      PanelInventario.Enabled := True;
   end;// if
end;

procedure TFrmInveIni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabInveLot.Close;
   TabInveIni.Close;
end;

end.

