unit uVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDLabel, DB,
  LMDBaseGraphicControl, LMDBaseLabel, LMDEdit, LMDCustomLabel, LMDControl, Vcl.Mask,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDCustomMemo,
  LMDDBMemo, RxLookup, Vcl.StdCtrls, RxToolEdit, RxDBCtrl, LMDBaseEdit, LMDCustomEdit,
  LMDDBEdit, LMDCustomMaskEdit, LMDCustomExtCombo, LMDCustomListComboBox, MarcLib,
  LMDListComboBox, LMDDBListComboBox, AdvGlowButton, Vcl.ExtCtrls, AdvSmoothPanel,
  AdvScrollBox, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, LMDMaskEdit, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, LMDThemedComboBox,
  LMDComboBox, LMDCustomComboBox, Vcl.ImgList, LMDButtonControl, LMDCustomCheckBox,
  LMDDBCheckBox, System.ImageList, uRESTDWBasicTypes, uRESTDWBasicDB, AdvOfficeButtons,
  VirtualTable, LMDCustomParentPanel, LMDCustomPanelFill;

type
  TFrmSNVen = class(TForm)
    SouVenda: TDataSource;
    PanelPri: TLMDSimplePanel;
    PanelIte: TLMDSimplePanel;
    PanelCabecalho: TLMDSimplePanel;
    TabVenda: TRESTDWClientSQL;
    btFechar: TAdvGlowButton;
    edFilial: TLMDLabeledEdit;
    Label22: TLabel;
    Label1: TLabel;
    PanelDataIni: TLMDSimplePanel;
    edDataIni: TDateEdit;
    PanelDatfin: TLMDSimplePanel;
    edDataFin: TDateEdit;
    btBuscar: TAdvGlowButton;
    TabVendaIDFilial: TIntegerField;
    TabVendaIDProd: TIntegerField;
    TabVendaNrolot: TWideStringField;
    TabVendaIDPess: TIntegerField;
    TabVendaIDPed: TIntegerField;
    TabVendaDatVenda: TDateField;
    TabVendaDatpre: TDateField;
    TabVendaDatven: TDateField;
    TabVendaNroRece: TWideStringField;
    TabVendaIDComp: TIntegerField;
    TabVendaIDVend: TIntegerField;
    TabVendaIDPres: TIntegerField;
    TabVendaQtdven: TFloatField;
    TabVendaIndConf: TWideStringField;
    TabVendaDespro: TWideStringField;
    TabVendaRegistoMS: TWideStringField;
    TabVendaNomfab: TWideStringField;
    TabVendaNomcom: TWideStringField;
    TabVendaNompre: TWideStringField;
    TabVendaNomven: TWideStringField;
    edInv: TLMDLabeledEdit;
    ComboClaTer: TLMDLabeledListComboBox;
    ComboRece: TLMDLabeledListComboBox;
    ComboSitu: TLMDLabeledListComboBox;
    ComboFiltro: TLMDLabeledListComboBox;
    DBGrid1: TDBGrid;
    AdvGlowButton1: TAdvGlowButton;
    TabVendaIDInvIni: TIntegerField;
    TabVendaTransmitida: TWideStringField;
    PanelRodape: TLMDSimplePanel;
    btImprimir: TAdvGlowButton;
    btEtiqueta: TAdvGlowButton;
    TabVendaIDVenda: TIntegerField;
    TabVendaUsoProlong: TWideStringField;
    TabVendaUsoMed: TWideStringField;
    TabVendaNroNot: TIntegerField;
    TabVendaClasTera: TWideStringField;
    TabVendaIDPac: TIntegerField;
    TabVendaNompac: TWideStringField;
    TabVendaNroRegProf: TWideStringField;
    TabVendaConRegProf: TWideStringField;
    TabVendaEstRegProf: TWideStringField;
    btIncluir: TAdvGlowButton;
    btAlterar: TAdvGlowButton;
    btExcluir: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edFilialCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edInvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edInvCustomButtons0Click(Sender: TObject; index: Integer);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure TabVendaAfterOpen(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    Frm:TForm;
    auxIDInvIni,auxIDFilial:Integer;
    procedure AjustGrid;
    procedure ShowFrmAguarde;
    procedure AtualizaTabTemp;
  public
    { Public declarations }
  end;

var
  FrmSNVen: TFrmSNVen;

implementation

uses uDM, uConst, uLibFarm, uBuscaInv, uVendasInc;

{$R *.dfm}

procedure TFrmSNVen.FormShow(Sender: TObject);
var
   QueInvi:TRESTDWClientSQL;
begin
   auxIDFilial := FILIAL;
   QueInvi := TRESTDWClientSQL.Create(nil);
   QueInvi.DataBase := DM.DWDataBase;
   try
      QueInvi.Close;
      QueInvi.SQL.Text := 'SELECT IDInvIni FROM arqsngpcinve WHERE IndFecha = 1';
      QueInvi.Open;
      auxIDInvIni := QueInvi.FieldByName('IDInvIni').AsInteger;
   finally
      QueInvi.Close;
      FreeAndNil(QueInvi);
   end;

   try
      TabVenda.SQL.Text := 'SELECT VEN.*, PRO.Despro, PRO.RegistoMS, PRO.ClasTera, PEF.Nompes AS Nomfab, COM.Nompes AS Nomcom,'+
      'PRE.Nompes AS Nompre, PRE.NroRegProf, PRE.ConRegProf, PRE.EstRegProf, VEE.Nompes AS Nomven, PAC.Nompes AS Nompac FROM arqsngpcven VEN '+
      'LEFT JOIN arqproduto PRO ON VEN.IDProd = PRO.IDProd LEFT JOIN arqpessoa PEF ON VEN.IDPess = PEF.IDPess '+
      'LEFT JOIN arqpessoa COM ON VEN.IDComp = COM.IDPess LEFT JOIN arqpessoa PRE ON VEN.IDPres = PRE.IDPess ' +
      'LEFT JOIN arqpessoa VEE ON VEN.IDVend = VEE.IDPess LEFT JOIN arqpessoa PAC ON VEN.IDPac = PAC.IDPess ' +
      'WHERE VEN.IDFilial = '+auxIDFilial.ToString+' AND VEN.IDInvIni = '+auxIDInvIni.ToString+' ORDER BY IDVenda ASC';
      TabVenda.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   AjustGrid;
end;

procedure TFrmSNVen.TabVendaAfterOpen(DataSet: TDataSet);
begin
   AjustGrid;
end;

procedure TFrmSNVen.AdvGlowButton1Click(Sender: TObject);
begin
   edFilial.Tag   := 0;
   edFilial.Text  := '';
   edInv.Tag      := 0;
   edInv.Text     := '';
   edDataIni.Text := '';
   edDataFin.Text := '';
   ComboClaTer.ItemIndex := -1;
   ComboRece.ItemIndex   := -1;
   ComboSitu.ItemIndex   := -1;
   ComboFiltro.ItemIndex := -1;
end;

procedure TFrmSNVen.AjustGrid;
begin
   TStringGrid(DBGrid1).DefaultRowHeight := BaseRowHeight - 3;
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmSNVen.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   R:TRect;
   Check:Integer;
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if not Column.FieldName.IsEmpty then
   begin
      if Column.Alignment = taCenter       then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + (Rect.Width - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText)) div 2, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taRightJustify then (Sender as TDBGrid).Canvas.TextRect(Rect,Rect.Left + Rect.Width  - (Sender as TDBGrid).Canvas.TextWidth(Column.Field.DisplayText) -3, Rect.Top+4, Column.Field.DisplayText) else
      if Column.Alignment = taLeftJustify  then (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left+5, Rect.Top+4, Column.Field.DisplayText);
   end;

   if not TabVenda.IsEmpty then
   begin
      if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('IndConf') then
      begin
         if Column.Field.Asstring = '0' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+10, Rect.Top+4, 16);
         end else if Column.Field.Asstring = '1' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+10, Rect.Top+4, 15);
         end;// if
      end;// if

      if Column.Field = DBGrid1.DataSource.DataSet.FieldByName('Transmitida') then
      begin
         if Column.Field.Asstring = '0' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+10, Rect.Top+4, 16);
         end else if Column.Field.Asstring = '1' then
         begin
            DBGrid1.Canvas.FillRect(Rect);
            DBGrid1.Canvas.TextOut(Rect.Left+3,Rect.Top+3,'');
            DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+10, Rect.Top+4, 15);
         end;// if
      end;// if
   end;
end;

procedure TFrmSNVen.edFilialCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmSNVen.edFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscas('arqfilial',TLMDEdit(edFilial),'IDFilial','Nomfil','',0,True);
end;

procedure TFrmSNVen.edInvCustomButtons0Click(Sender: TObject; index: Integer);
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
end;

procedure TFrmSNVen.edInvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmSNVen.AtualizaTabTemp;
var
   QueLote,QueComp:TRESTDWClientSQL;
   auxIDVenda,auxIDFilial,auxIDInvIni,auxIDProd,auxProd:Integer;
begin
   QueLote          := TRESTDWClientSQL.Create(nil);
   QueComp          := TRESTDWClientSQL.Create(nil);
   QueLote.DataBase := DM.DWDataBase;
   QueComp.DataBase := DM.DWDataBase;
   auxIDVenda  := TabVendaIDVenda.AsInteger;
   auxIDFilial := TabVendaIDFilial.AsInteger;
   auxIDInvIni := TabVendaIDInvIni.AsInteger;
   TabVenda.DisableControls;
   ShowFrmAguarde;
   try
      auxIDProd := 0;
      auxProd   := 0;
      TabVenda.Filtered := False;
      TabVenda.Filter   := 'IDVenda = '+auxIDVenda.ToString;
      TabVenda.Filtered := True;
      TabVenda.First;
      while not TabVenda.Eof do
      begin
         FrmVendasInc.cdsVenda.Append;
         FrmVendasInc.cdsVendaIDFilial.AsInteger   := TabVendaIDFilial.AsInteger;
         FrmVendasInc.cdsVendaIDProd.AsInteger     := TabVendaIDProd.AsInteger;
         FrmVendasInc.cdsVendaNrolot.AsString      := TabVendaNrolot.AsString;
         FrmVendasInc.cdsVendaIDPess.AsInteger     := TabVendaIDPess.AsInteger;
         FrmVendasInc.cdsVendaIDPed.AsInteger      := TabVendaIDPed.AsInteger;
         FrmVendasInc.cdsVendaDatVenda.AsDateTime  := TabVendaDatVenda.AsDateTime;
         FrmVendasInc.cdsVendaDatpre.AsDateTime    := TabVendaDatpre.AsDateTime;
         FrmVendasInc.cdsVendaDatven.AsDateTime    := TabVendaDatven.AsDateTime;
         FrmVendasInc.cdsVendaNroRece.AsString     := TabVendaNroRece.AsString;
         FrmVendasInc.cdsVendaIDComp.AsInteger     := TabVendaIDComp.AsInteger;
         FrmVendasInc.cdsVendaIDVend.AsInteger     := TabVendaIDVend.AsInteger;
         FrmVendasInc.cdsVendaIDPres.AsInteger     := TabVendaIDPres.AsInteger;
         FrmVendasInc.cdsVendaNroReg.AsString      := TabVendaNroRegProf.AsString;
         FrmVendasInc.cdsVendaUFReg.AsString       := TabVendaEstRegProf.AsString;
         FrmVendasInc.cdsVendaQtdven.AsFloat       := TabVendaQtdven.AsFloat;
         FrmVendasInc.cdsVendaIndConf.AsString     := TabVendaIndConf.AsString;
         FrmVendasInc.cdsVendaConReg.AsString      := TabVendaConRegProf.AsString;
         FrmVendasInc.cdsVendaIDInvIni.AsInteger   := TabVendaIDInvIni.AsInteger;
         FrmVendasInc.cdsVendaTransmitida.AsString := TabVendaTransmitida.AsString;
         FrmVendasInc.cdsVendaDespro.AsString      := TabVendaDespro.AsString;
         FrmVendasInc.cdsVendaRegistoMS.AsString   := TabVendaRegistoMS.AsString;
         FrmVendasInc.cdsVendaNomfab.AsString      := TabVendaNomfab.AsString;
         FrmVendasInc.cdsVendaNomcom.AsString      := TabVendaNomcom.AsString;
         FrmVendasInc.cdsVendaNompre.AsString      := TabVendaNompre.AsString;
         FrmVendasInc.cdsVendaNomven.AsString      := TabVendaNomven.AsString;
         FrmVendasInc.cdsVendaNroNot.AsInteger     := TabVendaNroNot.AsInteger;
         FrmVendasInc.cdsVendaUsoProlong.AsString  := TabVendaUsoProlong.AsString;
         FrmVendasInc.cdsVendaUsoMed.AsString      := TabVendaUsoMed.AsString;
         FrmVendasInc.cdsVendaIDPac.AsInteger      := TabVendaIDPac.AsInteger;
         FrmVendasInc.cdsVendaNomPac.AsString      := TabVendaNompac.AsString;
         FrmVendasInc.cdsVendaClasTera.AsString    := TabVendaClasTera.AsString;
         FrmVendasInc.cdsVendaIDVenda.AsInteger    := TabVendaIDVenda.AsInteger;

         // Informa comprador ou paciente por produto
         if auxProd <> TabVendaIDProd.AsInteger then
         begin
            auxProd := TabVendaIDProd.AsInteger;
            if TabVendaClasTera.AsString = '1' then
            begin
               QueComp.Close;
               QueComp.SQL.Text := 'SELECT * FROM arqsngpcvenpac WHERE IDVenda ='+auxIDVenda.ToString;
               QueComp.Open;
            end else
            begin
               QueComp.Close;
               QueComp.SQL.Text := 'SELECT * FROM arqsngpcvencom WHERE IDVenda ='+auxIDVenda.ToString;
               QueComp.Open;
            end;// if
         end;// if

         // Informa comprador ou paciente para tabela temporária
         if TabVendaClasTera.AsString = '1' then
         begin
            if not QueComp.IsEmpty then
            begin
               FrmVendasInc.cdsVendaSexo.AsString        := QueComp.FieldByName('SexoPac').AsString;
               FrmVendasInc.cdsVendaIdade.AsInteger      := QueComp.FieldByName('IdadePac').AsInteger;
               FrmVendasInc.cdsVendaUniIdadePac.AsString := QueComp.FieldByName('UniIdadePac').AsString;
            end;// if
         end// if
         else
         begin
            if not QueComp.IsEmpty then
            begin
               FrmVendasInc.cdsVendaEndereco.AsString := QueComp.FieldByName('Endcomp').AsString;
               FrmVendasInc.cdsVendaNumero.AsString   := QueComp.FieldByName('NroEndComp').AsString;
               FrmVendasInc.cdsVendaBairro.AsString   := QueComp.FieldByName('BaiComp').AsString;
               FrmVendasInc.cdsVendaCidade.AsString   := QueComp.FieldByName('DesMunComp').AsString;
               FrmVendasInc.cdsVendaUF.AsString       := QueComp.FieldByName('EstComp').AsString;
               FrmVendasInc.cdsVendaCep.AsString      := QueComp.FieldByName('CepComp').AsString;
               FrmVendasInc.cdsVendaTipoDoc.AsString  := QueComp.FieldByName('TipDocComp').AsString;
               FrmVendasInc.cdsVendaNumDoc.AsString   := QueComp.FieldByName('NumDocComp').AsString;
               FrmVendasInc.cdsVendaOrgExp.AsString   := QueComp.FieldByName('OrgExpComp').AsString;
               FrmVendasInc.cdsVendaUFEmis.AsString   := QueComp.FieldByName('EstEmiComp').AsString;
            end;// if
         end;// if
         FrmVendasInc.cdsVenda.Post;

         /// insere os lotes do produto que vai ser alterado
         if auxIDProd <> TabVendaIDProd.AsInteger then
         begin
            auxIDProd := TabVendaIDProd.AsInteger;
            QueLote.Close;
            QueLote.SQL.Text := 'SELECT IDProd,Nrolot,Qtdest,Datven FROM arqsngpclot' +
            ' WHERE IDFilial = '+auxIDFilial.ToString+ ' AND IDInvIni = '+auxIDInvIni.ToString+
            ' AND IDProd = '+auxIDProd.ToString+' AND Qtdest >= 0 ORDER BY Datven ASC';
            QueLote.Open;
            QueLote.First;
            while not QueLote.Eof do
            begin
               FrmVendasInc.cdsLote.Append;
               FrmVendasInc.cdsLoteIDProd.AsInteger  := QueLote.FieldByName('IDProd').AsInteger;
               FrmVendasInc.cdsLoteDatVen.AsDateTime := QueLote.FieldByName('Datven').AsDateTime;
               FrmVendasInc.cdsLoteNroLot.AsString   := QueLote.FieldByName('Nrolot').AsString;
               FrmVendasInc.cdsLoteQtdLote.AsFloat   := QueLote.FieldByName('Qtdest').AsFloat;
               FrmVendasInc.cdsLote.Post;
               QueLote.Next;
            end; //while
         end;

         // Procura lote com venda
         FrmVendasInc.cdsLote.Filtered := False;
         FrmVendasInc.cdsLote.Filter   := 'NroLot = '+TabVendaNrolot.AsString;
         FrmVendasInc.cdsLote.Filtered := True;
         if not FrmVendasInc.cdsLote.IsEmpty then
         begin
            FrmVendasInc.cdsLote.Edit;
            FrmVendasInc.cdsLoteQtdVenda.AsFloat := TabVendaQtdven.AsFloat;
            FrmVendasInc.cdsLote.Post;
         end;
         FrmVendasInc.cdsLote.Filtered := False;
         TabVenda.Next;
      end;// while
      TabVenda.Filtered := False;
      FrmVendasInc.cdsLote.Filtered := False;
   finally
      QueLote.Close;
      QueComp.Close;
      FreeAndNil(QueLote);
      FreeAndNil(QueComp);
      TabVenda.EnableControls;
      Frm.Free;
   end;// try
end;

procedure TFrmSNVen.btAlterarClick(Sender: TObject);
var
   Index:Integer;
begin
   if TabVenda.IsEmpty then
   begin
      MostraMsg('Venda de produto','Nenhum produto selecionado para alterar!',mtWarning, [mbOk]);
      btAlterar.SetFocus;
      Exit;
   end;
   if TabVendaTransmitida.AsString = '1' then
   begin
      MostraMsg('Alteração de produto','Produto selecionado já enviado, não pode ser alterado!',mtWarning, [mbOk]);
      btAlterar.SetFocus;
      Exit;
   end;
   try
      FrmVendasInc := TFrmVendasInc.Create(Application);
      FrmVendasInc.recOrigem   := 'ALTERAR';
      FrmVendasInc.recIDFilial := auxIDFilial;
      FrmVendasInc.recIDInvIni := auxIDInvIni;
      FrmVendasInc.recIDVenda  := TabVendaIDVenda.AsInteger;
      FrmVendasInc.cdsVenda.CreateDataSet;
      FrmVendasInc.cdsLote.CreateDataSet;
      FrmVendasInc.cdsCloneVenda.CreateDataSet;
      FrmVendasInc.cdsCloneLote.CreateDataSet;
      FrmVendasInc.tabVenda:= TabVenda;
      AtualizaTabTemp;
      FrmVendasInc.ShowModal;
   finally
      FrmVendasInc.Free;
   end;// try
   Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
   TabVenda.Close;
   TabVenda.Open;
   DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   DBGrid1.Refresh; // Refresca o DBGrid para mostrar a nova posição
end;

procedure TFrmSNVen.btBuscarClick(Sender: TObject);
begin
   TabVenda.Close;
   TabVenda.SQL.Clear;
   TabVenda.SQL.Add('SELECT VEN.*,PRO.Despro,PRO.RegistoMS,PRO.ClasTera,PEF.Nompes AS Nomfab,COM.Nompes AS Nomcom,'+
   'PRE.Nompes AS Nompre, VEE.Nompes AS Nomven, PAC.Nompes AS Nompac FROM arqsngpcven VEN '+
   'LEFT JOIN arqproduto PRO ON VEN.IDProd = PRO.IDProd  LEFT JOIN arqpessoa PEF ON VEN.IDPess = PEF.IDPess '+
   'LEFT JOIN arqpessoa COM ON VEN.IDComp = COM.IDPess LEFT JOIN arqpessoa PRE ON VEN.IDPres = PRE.IDPess '+
   'LEFT JOIN arqpessoa VEE ON VEN.IDVend = VEE.IDPess LEFT JOIN arqpessoa PAC ON VEN.IDPac = PAC.IDPess');
   if (edFilial.Tag > 0) and (edFilial.Text <> '') then
        TabVenda.SQL.Add(' WHERE VEN.IDFilial = '+edFilial.Tag.ToString)
   else TabVenda.SQL.Add(' WHERE VEN.IDFilial = '+auxIDFilial.ToString);
   if (edInv.Tag > 0) and (edInv.Text <> '') then
        TabVenda.SQL.Add(' AND VEN.IDInvIni = '+edInv.Tag.ToString)
   else TabVenda.SQL.Add(' AND VEN.IDInvIni = '+auxIDInvIni.ToString);
   if (edDataIni.Date > 0) and (edDataFin.Date > 0) then
      TabVenda.SQL.Add(' AND VEN.DatVenda BETWEEN '+Aspas(FormatDateTime('yyyy-mm-dd',edDataIni.Date))+' AND '+Aspas(FormatDateTime('yyyy-mm-dd',edDataFin.Date)));
   if ComboClaTer.ItemIndex > 0 then TabVenda.SQL.Add(' AND PRO.ClasTera = '+Aspas(IntToStr(ComboClaTer.ItemIndex)));
   if ComboRece.ItemIndex   > 0 then TabVenda.SQL.Add(' AND PRO.UsoRece = '+Aspas(ComboRece.Items[ComboRece.ItemIndex]));
   if ComboSitu.ItemIndex   > 0 then
   begin
      if ComboSitu.ItemIndex = 1 then
         TabVenda.SQL.Add(' AND VEN.Transmitida = 1')
      else if ComboSitu.ItemIndex = 2 then
         TabVenda.SQL.Add(' AND VEN.Transmitida = 0');
   end; //if
   if ComboFiltro.ItemIndex > 0 then
   begin
      if ComboFiltro.ItemIndex = 1 then
         TabVenda.SQL.Add(' AND VEN.IndConf = 1')
      else if ComboFiltro.ItemIndex = 2 then
         TabVenda.SQL.Add(' AND VEN.IndConf = 0');
   end; //if
   TabVenda.Open;
end;

procedure TFrmSNVen.btExcluirClick(Sender: TObject);
var
   QueAuxi,QueExclui:TRESTDWClientSQL;
   Index:Integer;
begin
   if TabVenda.IsEmpty then
   begin
      MostraMsg('Exclusão de produto','Nenhum produto selecionado para excluir!',mtWarning, [mbOk]);
      btExcluir.SetFocus;
      Exit;
   end;// if
   if TabVendaTransmitida.AsString = '1' then
   begin
      MostraMsg('Exclusão de produto','Produto selecionado já enviado, portanto não pode ser excluído!',mtWarning, [mbOk]);
      btExcluir.SetFocus;
      Exit;
   end;

   if MostraMsg('Confirmação','Deseja excluir produto '+TabVendaDespro.AsString+' ?', mtConfirmation, [mbYes,mbNo]) = mrNo then Exit;
   ShowFrmAguarde;
   QueAuxi   := TRESTDWClientSQL.Create(nil);
   QueExclui := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase   := DM.DWDataBase;
   QueExclui.DataBase := DM.DWDataBase;
   try
      try
         QueExclui.Close;
         QueExclui.SQL.Text := 'DELETE FROM arqsngpcven WHERE IDVenda = '+TabVendaIDVenda.AsString;
         QueExclui.ExecSQL;
      except // try
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir o produto de arqsngpcven em uVenda -> '+E.Message);
            MostraMsg('Erro','Não foi possível excluir o produto.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;// try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT IDVenda FROM arqsngpcvenpac WHERE IDVenda = '+TabVendaIDVenda.AsString;
      QueAuxi.Open;
      if QueAuxi.IsEmpty then
      begin
         try
            QueExclui.Close;
            QueExclui.SQL.Text := 'DELETE FROM arqsngpcvencom WHERE IDVenda = '+TabVendaIDVenda.AsString;
            QueExclui.ExecSQL;
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir comprador de arqsngpcvencom em uVenda -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir o comprador.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
      end// if
      else
      begin
         try
            QueExclui.Close;
            QueExclui.SQL.Text := 'DELETE FROM arqsngpcvenpac WHERE IDVenda = '+TabVendaIDVenda.AsString;
            QueExclui.ExecSQL;
         except // try
            on E:Exception do
            begin
               SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível excluir o paciente de arqsngpcvenpac em uVenda -> '+E.Message);
               MostraMsg('Erro','Não foi possível excluir o paciente.'+#10+E.Message, mtWarning, [mbOk]);
               Exit;
            end;
         end;// try
      end;
   finally
      QueAuxi.Close;
      QueExclui.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueExclui);
      Frm.Free;
   end;
   Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
   TabVenda.Close;
   TabVenda.Open;
   DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   DBGrid1.Refresh; // Refresca o DBGrid para mostrar a nova posição
end;

procedure TFrmSNVen.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmSNVen.btIncluirClick(Sender: TObject);
var
   Index:Integer;
begin
   try
      FrmVendasInc := TFrmVendasInc.Create(Application);
      FrmVendasInc.recOrigem   := 'INCLUIR';
      FrmVendasInc.recIDFilial := auxIDFilial;
      FrmVendasInc.recIDInvIni := auxIDInvIni;
      FrmVendasInc.cdsVenda.CreateDataSet;
      FrmVendasInc.cdsLote.CreateDataSet;
      FrmVendasInc.ShowModal;
   finally
      FrmVendasInc.Free;
   end; // try
   Index := DBGrid1.DataSource.DataSet.RecNo; //Salva o índice
   TabVenda.Close;
   TabVenda.Open;
   DBGrid1.DataSource.DataSet.RecNo := Index; // Ajusta para índice salvo
   DBGrid1.Refresh;
end;

procedure TFrmSNVen.ShowFrmAguarde;
var
   Msg:TLabel;
   Borda:TShape;
begin
   Frm := TForm.Create(Application);
   Frm.BorderStyle := bsNone;
   Frm.Position    := poDesktopCenter;
   Frm.Width       := 300;
   Frm.Height      := 130;

   Borda             := TShape.Create(Application);
   Borda.Parent      := Frm;
   Borda.Align       := alClient;
   Borda.Pen.Color   := $000099FF;
   Borda.Brush.Color := $00B9CFFF;

   Msg             := TLabel.Create(Application);
   Msg.Parent      := Frm;
   Msg.Transparent := True;
   Msg.AutoSize    := False;
   Msg.Font.Size   := 22;
   Msg.Width       := Frm.Width;
   Msg.Height      := Frm.Height - 2;
   Msg.Caption     := #13+'Aguarde...';
   msg.Align       := TAlign(5);
   Msg.Alignment   := taCenter;
   Frm.Show;
   Frm.Update;
end;

procedure TFrmSNVen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabVenda.Close;
end;

end.

