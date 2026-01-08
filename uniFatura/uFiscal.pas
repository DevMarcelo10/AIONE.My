unit uFiscal;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, LMDListComboBox, LMDDBListComboBox,
   Vcl.StdCtrls, LMDBaseControl, LMDBaseGraphicControl,LMDBaseLabel, Data.DB,
   LMDCustomListComboBox, Vcl.ExtCtrls, LMDCustomLabel, MarcLib, Vcl.DBCtrls,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, LMDEdit, LMDMaskEdit,
   LMDCustomMaskEdit, LMDCustomBevelPanel, AdvGlowButton, uRESTDWParams;

type
   TFrmFiscal = class(TForm)
    PanelForm: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    PanelBack: TLMDSimplePanel;
    timAlpha: TTimer;
    PnaelBasMenus: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    btSpeed: TAdvGlowButton;
    bNatoPE: TAdvGlowButton;
    btNFEven: TAdvGlowButton;
    btAjuste: TAdvGlowButton;
    PanelMenFor: TLMDSimplePanel;
    btConFor: TAdvGlowButton;
    btPedEle: TAdvGlowButton;
    btNegoci: TAdvGlowButton;
    btBanFor: TAdvGlowButton;
    Shape2: TShape;
    btObsFor: TAdvGlowButton;
    btNFEmitida: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    barselBut: TShape;
    PanelBase: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    TesteNFC: TButton;
    edPedido: TLMDLabeledEdit;
    Button4: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btAbreFormsClick(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TesteNFCClick(Sender: TObject);
  private
    { Private declarations }
    FormAtivo:TForm;
    procedure FechaSubForm;
    procedure AbreSubForm(NomeForm:String);
  public
    { Public declarations }
  end;

var
   FrmFiscal: TFrmFiscal;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uNFEmitida, uCertificados, uNFEven;

procedure TFrmFiscal.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   btNFEmitida.Click;
end;

procedure TFrmFiscal.TesteNFCClick(Sender: TObject);
var
   vErrorMsg,vResult,Modelo:String;
   DWParams:TRESTDWParams;
begin
   Modelo := TButton(Sender).Tag.ToString;
   try
      try
         DM.DWClientEvents.CreateDWParams('EmiteNF', DWParams);
         DWParams.ItemsString['FILIAL'].AsString   := FILIAL.ToString;
         DWParams.ItemsString['Tabela'].AsString   := 'arqpedido';
         DWParams.ItemsString['NroDocto'].AsString := edPedido.Text;
         DWParams.ItemsString['Modelo'].AsString   := Modelo;
         DWParams.ItemsString['CPFnf'].AsString    := '0';
         DWParams.ItemsString['Mailnf'].AsString   := '0';
         DM.DWClientEvents.SendEvent('EmiteNF', DWParams, vErrorMsg);
         if vErrorMsg <> '' then raise Exception.Create(vErrorMsg);
         vResult := DWParams.ItemsString['Result'].AsString;
         if vResult <> '100' then raise Exception.Create(vResult);
         ShowMessage('NF emitida com sucesso!');
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível enviar NF -> '+E.Message);
            MostraMsg('Erro','Não foi possível enviar NF -> '+E.Message, mtError, [mbOk]);
         end;
      end;
   finally
      DWParams.Free;
   end;
end;

procedure TFrmFiscal.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmFiscal.btAbreFormsClick(Sender: TObject);
begin
   AbreSubForm(Trim(Copy(TAdvGlowButton(Sender).Name,3,6)));
   barselBut.Left  := TAdvGlowButton(Sender).Left;
   barselBut.Width := TAdvGlowButton(Sender).Width;
end;

// ----------- Abre Sub Formulários ----------- //
procedure TFrmFiscal.AbreSubForm(NomeForm:String);
var
   PanelPos:TPoint;
   TFormAtivo:TFormClass;
begin
   FechaSubForm;
   if NomeForm = 'NFEmit' then TFormAtivo := TFrmNFEmit else
   if NomeForm = 'NFEven' then TFormAtivo := TFrmNFEven else
   begin
      MostraMsg('Aviso', 'Em desenvolvimento !!!', mtWarning, [mbOk]);
      Exit;
   end;
   FormAtivo := TFormAtivo.Create(Application);
   FormAtivo.Parent := PanelBase;
   FormAtivo.Show;
end;

// ----------- Fecha Formulários ----------- //
procedure TFrmFiscal.FechaSubForm;
begin
   if Assigned(FormAtivo) then
   begin
      FormAtivo.Close;
      FreeAndNil(FormAtivo);
   end;
end;

procedure TFrmFiscal.btFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmFiscal.Button2Click(Sender: TObject);
begin
   ListarCertificadosPessoais(Memo1.Lines, False, True);
   DM.ACBrNFe.SSL.LerCertificadosStore;
   for var I := 0 to DM.ACBrNFe.SSL.ListaCertificados.Count-1 do
   begin
      with DM.ACBrNFe.SSL.ListaCertificados.Items[I] do
      begin
         Memo1.Lines.Add('');
         Memo1.Lines.Add(
         'CNPJ: ' +CNPJ+sLineBreak+
         'Razao: '+RazaoSocial+sLineBreak+
         'SubjectName: '+SubjectName+sLineBreak+
         'ThumbPrint : '+ThumbPrint+sLineBreak+
         'NumeroSerie: '+NumeroSerie+sLineBreak+
         'DataVencime: '+DateToStr(DataVenc)+sLineBreak+
         'Base FInal : '+FormatDNOrdered(SubjectName,NumeroSerie)+sLineBreak);
      end;  //with
   end; // for
end;

procedure TFrmFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaSubForm;
   Action := caFree;
end;

end.


