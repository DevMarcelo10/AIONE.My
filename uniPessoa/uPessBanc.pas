unit uPessBanc;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, RxToolEdit, RxDBCtrl, LMDBaseEdit, LMDCustomEdit, LMDDBEdit,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDSimplePanel, Vcl.ExtCtrls, Vcl.StdCtrls, FireDAC.Stan.Intf, MarcLib,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes,
   FireDAC.Comp.Client, uRESTDWBasicDB, Vcl.DBCtrls;

type
 TFrmPesBanc = class(TForm)
    PanelTrabalho: TLMDSimplePanel;
    edDBCodban: TLMDDBLabeledEdit;
    edIDNomban: TLMDDBLabeledEdit;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit3: TLMDDBLabeledEdit;
    LMDDBLabeledEdit4: TLMDDBLabeledEdit;
    edDBDEsTipCon: TLMDDBLabeledEdit;
    LMDDBLabeledEdit5: TLMDDBLabeledEdit;
    LMDDBLabeledEdit7: TLMDDBLabeledEdit;
    LMDDBLabeledEdit8: TLMDDBLabeledEdit;
    SouPesBanc: TDataSource;
    TabBanc: TRESTDWClientSQL;
    TabBancCodban: TIntegerField;
    TabBancNomban: TWideStringField;
    TabPesBanc: TRESTDWClientSQL;
    TabPesBancIDPess: TIntegerField;
    TabPesBancCodban: TIntegerField;
    TabPesBancAgencia: TWideStringField;
    TabPesBancNroConta: TWideStringField;
    TabPesBancIDTipCon: TWideStringField;
    TabPesBancIDPix: TWideStringField;
    TabPesBancCPFCNPJ: TWideStringField;
    TabPesBancIBAN: TWideStringField;
    TabPesBancIDSWIFT: TWideStringField;
    TabPesBancNomban: TWideStringField;
    TabPesBancDesTipCon: TWideStringField;
    TabPesBancIDNatfin: TIntegerField;
    TabPesBancDesnat: TWideStringField;
    edDesnat: TLMDDBLabeledEdit;
    edTipChaPix: TLMDDBLabeledEdit;
    TabPesBancCodChaPix: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edDBCodbanExit(Sender: TObject);
    procedure edIDNombanKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edIDNombanCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edDBDEsTipConKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDBDEsTipConCustomButtons0Click(Sender: TObject; index: Integer);
    procedure TabPesBancAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure edDesnatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDesnatCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edTipChaPixCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmPesBanc: TFrmPesBanc;
   CodChaPix: Integer;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoasCad, uBuscaSemDB;

procedure TFrmPesBanc.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesBanc.FormShow(Sender: TObject);
begin
   try
      TabBanc.Open;
      TabPesBanc.Close;
      TabPesBanc.SQL.Text := 'SELECT BAC.*,BAN.Nomban,TIP.DesTipCon,NAT.Desnat FROM arqpessbanc BAC '+
      'LEFT JOIN arqbanco BAN ON BAC.Codban = BAN.Codban LEFT JOIN arqnatfin NAT ON BAC.IDNatfin = NAT.IDNatfin '+
      'LEFT JOIN arqbancotip TIP ON BAC.IDTipCon = TIP.IDTipCon WHERE IDPess = '+basIDPess.ToString;
      TabPesBanc.Open;
      if TabPesBanc.IsEmpty then
           TabPesBanc.Append
      else TabPesBanc.Edit;
   except
      on E: Exception do
      begin
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar abrir arquivos (uPessBanc) -> '+E.Message);
         MostraMsg('Erro','Não foi possível abrir arquivos!'+#10+E.Message, mtError, [mbOk]);
         PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      end;
   end;
end;

procedure TFrmPesBanc.edDesnatCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabPesBanc, 'arqnatfin',TDBEdit(edDesnat), 'IDNatfin', 'IDNatfin','Desnat', 'Desnat', '', 0);
end;

procedure TFrmPesBanc.edDesnatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabPesBanc, 'arqnatfin',TDBEdit(edDesnat), 'IDNatfin', 'IDNatfin','Desnat', 'Desnat', '', Key);
end;

procedure TFrmPesBanc.TabPesBancAfterInsert(DataSet: TDataSet);
begin
   TabPesBancIDPess.Value := basIDPess;
end;

procedure TFrmPesBanc.edDBCodbanExit(Sender: TObject);
begin
   if Trim(edDBCodban.Text) <> '' then
   begin
      if not(TabPesBanc.State in dsEditModes) then TabPesBanc.Edit;
      if not TabBanc.Locate('Codban', TabPesBancCodban.Value, []) then
      begin
         MostraMsg('Aviso','Não encontrado banco com esse código!',mtWarning, [mbOk]);
         TabPesBancCodban.Clear;
         TabPesBancNomban.Value := '';
         edDBCodban.Text := '';
         edDBCodban.SetFocus;
         Exit;
      end; //if
      TabPesBancNomban.Value := TabBancNomban.Value;
   end; // if
end;

procedure TFrmPesBanc.edDBDEsTipConCustomButtons0Click(Sender: TObject;index: Integer);
begin
   btBuscasDB(TabPesBanc,'arqbancotip', TDBEdit(edDBDEsTipCon),'IDTipCon','IDTipCon', 'DesTipCon', 'DesTipCon', '', 0);
end;

procedure TFrmPesBanc.edDBDEsTipConKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscasDB(TabPesBanc,'arqbancotip', TDBEdit(edDBDEsTipCon),'IDTipCon','IDTipCon', 'DesTipCon', 'DesTipCon', '', Key);
end;

procedure TFrmPesBanc.edIDNombanCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabPesBanc,'arqbanco',TDBEdit(edIDNomban), 'Codban', 'Codban','Nomban', 'Nomban', '', 0);
end;

procedure TFrmPesBanc.edIDNombanKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
   btBuscasDB(TabPesBanc, 'arqbanco',TDBEdit(edIDNomban), 'Codban', 'Codban','Nomban', 'Nomban', '', Key);
end;

procedure TFrmPesBanc.edTipChaPixCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint: TPoint;
begin
   try
      FrmBuscaSemDB := TFrmBuscaSemDB.Create(Application);
      with FrmBuscaSemDB do
      begin
         lPoint       := edTipChaPix.ClientToScreen(Point(0, 0));
         Left         := lPoint.X;
         Top          := lPoint.Y;
         TituloColuna := 'TIPO PIX';
         WidthColuna  := 150;
         Width        := 155;
         ShowModal;
      end; // with
   finally
      FrmBuscaSemDB.Free;
   end;
   if CodChaPix > 0 then
      TabPesBancCodChaPix.AsInteger := CodChaPix;
end;

procedure TFrmPesBanc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabPesBanc.State in dsEditModes then TabPesBanc.Post;
   TabBanc.Close;
   TabPesBanc.Close;
end;

end.
