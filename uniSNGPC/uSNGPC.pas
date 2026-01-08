unit uSNGPC;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl,LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtCombo,
   LMDLabel, LMDListComboBox, LMDDBListComboBox, Vcl.StdCtrls, Vcl.Mask,
   RxToolEdit, LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel,  Data.DB,
   LMDCustomListComboBox, LMDCustomLabel, LMDCustomBevelPanel, Vcl.ExtCtrls,
   AdvGlowButton, MarcLib, AdvEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB;

type
   TFrmSNGPC = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelDadCom: TLMDSimplePanel;
    timAlpha: TTimer;
    PnaelBasMenus: TLMDSimplePanel;
    PanelMen: TLMDSimplePanel;
    btMapas: TAdvGlowButton;
    btEnvia: TAdvGlowButton;
    btCompr: TAdvGlowButton;
    btEstoque: TAdvGlowButton;
    btVendas: TAdvGlowButton;
    btPerdas: TAdvGlowButton;
    PanelMenFor: TLMDSimplePanel;
    btConFor: TAdvGlowButton;
    btPedEle: TAdvGlowButton;
    btNegoci: TAdvGlowButton;
    btBanFor: TAdvGlowButton;
    Shape2: TShape;
    btObsFor: TAdvGlowButton;
    btInvent: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    barselBut: TShape;
    PanelSubCad: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btAbreFormsClick(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
    FormAtivo:TForm;
    procedure FechaSubForm;
    procedure AbreSubForm(NomeForm:String);
    procedure VerParam;
  public
    { Public declarations }
  end;

var
   FrmSNGPC: TFrmSNGPC;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uTransmite, uInveIni, uVenda, uPerdas, uSNEstoque, uComTra;

procedure TFrmSNGPC.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   Self.Left := Self.Left - 100;
end;

procedure TFrmSNGPC.FormShow(Sender: TObject);
begin
   VerParam;
end;

procedure TFrmSNGPC.VerParam;
var
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT ControleSNGPC FROM arqparametros';
      QueAuxi.Open;
      if not QueAuxi.FieldByName('ControleSNGPC').AsBoolean then
      begin
         btInvent.Enabled := False;
         btVendas.Enabled := False;
         btCompr.Enabled := False;
         btPerdas.Enabled := False;
         btEstoque.Enabled := False;
         btMapas.Enabled := False;
         btEnvia.Enabled := False;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmSNGPC.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmSNGPC.btAbreFormsClick(Sender: TObject);
begin
   AbreSubForm(Trim(Copy(TAdvGlowButton(Sender).Name,3,6)));
   barselBut.Left  := TAdvGlowButton(Sender).Left;
   barselBut.Width := TAdvGlowButton(Sender).Width;
end;

// ----------- Abre Sub Formulários ----------- //
procedure TFrmSNGPC.AbreSubForm(NomeForm:String);
var
   TFormAtivo:TFormClass;
begin
   FechaSubForm;
   if NomeForm = 'Invent' then TFormAtivo := TFrmInveIni   else
   if NomeForm = 'Vendas' then TFormAtivo := TFrmSNVen     else
   if NomeForm = 'Perdas' then TFormAtivo := TFrmPerdas    else
   if NomeForm = 'Envia'  then TFormAtivo := TFrmTransmite else
   if NomeForm = 'Compr'  then TFormAtivo := TFrmComTra    else
   if NomeForm = 'Estoqu' then TFormAtivo := TFrmSNEstoq   else Exit;
   FormAtivo := TFormAtivo.Create(Application);
   FormAtivo.Parent := PanelSubCad;
   FormAtivo.Show;
end;

// ----------- Fecha Formulários ----------- //
procedure TFrmSNGPC.FechaSubForm;
begin
   if Assigned(FormAtivo) then
   begin
      FormAtivo.Close;
      FreeAndNil(FormAtivo);
   end;
end;

procedure TFrmSNGPC.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmSNGPC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaSubForm;
   Action := caFree;
end;

end.

