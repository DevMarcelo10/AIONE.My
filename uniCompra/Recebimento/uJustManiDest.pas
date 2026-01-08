unit uJustManiDest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  LMDControl, LMDCustomControl, LMDCustomPanel, LMDButtonControl,
  LMDCustomCheckBox, LMDCheckBox, AdvGlowButton, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, MarcLib, LMDCustomLabel, ACBrNFe,
  LMDLabel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.StdCtrls, Vcl.Mask,
  LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDCustomMaskEdit, LMDMaskEdit,
  Vcl.ExtCtrls, uRESTDWBasicDB, uLibFarm, pcnConversao, RxToolEdit,
  uWaitForm;

type
  TFrmJustManiDest = class(TForm)
    PanelPri: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel8: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCabe: TLMDSimplePanel;
    edNomPes: TLMDLabeledEdit;
    edNotfis: TLMDLabeledMaskEdit;
    edNroSerie: TLMDLabeledMaskEdit;
    edVlrNotFis: TLMDLabeledMaskEdit;
    edDatainicio: TLMDSimplePanel;
    edDatEmi: TDateEdit;
    Label22: TLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    ckCienOper: TLMDCheckBox;
    ckConfOper: TLMDCheckBox;
    ckOperNaoReal: TLMDCheckBox;
    ckDescOper: TLMDCheckBox;
    edJust: TLMDLabeledEdit;
    PanelRodape: TLMDSimplePanel;
    btManifestar: TAdvGlowButton;
    procedure ckConfOperClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ckCienOperClick(Sender: TObject);
    procedure ckOperNaoRealClick(Sender: TObject);
    procedure ckDescOperClick(Sender: TObject);
    procedure btManifestarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    auxEveNFe: TpcnTpEvento;
  public
    { Public declarations }
    recNomPess,recIDChaAce,recCNPJFil,recCNPJCPFFor:String;
    recNotFis,recNroSerie,recIDFilial:Integer;
    recDatEmi:Tdatetime;
    recVlrNotFis:Double;
    recACBrNFe:TACBrNFe;
  end;

var
  FrmJustManiDest: TFrmJustManiDest;

implementation

uses uDM, uConst;

{$R *.dfm}

procedure TFrmJustManiDest.btManifestarClick(Sender: TObject);
var
   QueParam:TRESTDWClientSQL;
   auxRetManifesto,vErro:String;
begin
   if not IsNumeric(recCNPJFil) then
   begin
      MostraMsg('Aviso','CNPJ não está correto!',mtWarning, [mbOk]);
      Exit;
   end;
   if recIDChaAce = '' then
   begin
      MostraMsg('Aviso','Chave de acesso da NFe não está correta!',mtWarning, [mbOk]);
      Exit;
   end;
   if (auxEveNFe <> teManifDestCiencia) and (auxEveNFe <> teManifDestConfirmacao) and
      (auxEveNFe <> teManifDestOperNaoRealizada) and (auxEveNFe <> teManifDestDesconhecimento) then
   begin
      MostraMsg('Aviso','Evento para manifestação da NFe não está correto, favor escolher um deles!',mtWarning, [mbOk]);
      Exit;
   end;
   if (ckOperNaoReal.Checked) and (auxEveNFe = teManifDestOperNaoRealizada) then
   begin
      if (Length(edJust.Text) < 15) and (Trim(edJust.Text).IsEmpty) then
      begin
         MostraMsg('Aviso','Justificativa informada não está correta!',mtWarning, [mbOk]);
         Exit;
      end;
   end;

   // Como os Eventos de Manifestação do Destinatário são enviados para o //
   // Ambiente Nacional, o código informado no Orgao deve ser sempre 91  //
   auxRetManifesto := Manifestar(recACBrNFe,recCNPJFil,recIDChaAce,edJust.Text,91,auxEveNFe);
   QueParam := TRESTDWClientSQL.Create(nil);
   ShowWait('Aguarde...', Self);
   try
      QueParam.DataBase := DM.DWDataBase;
      try
         QueParam.Close;
         QueParam.SQL.Text := 'UPDATE arqmandest SET '+
         'RetManifesto = '+Aspas(auxRetManifesto)+
         ' WHERE CNPJCPFFor = '+Aspas(recCNPJCPFFor)+
         ' AND IDFilial = '+recIDFilial.ToString+
         ' AND NotFis = '+recNotFis.ToString+
         ' AND NroSerie = '+recNroSerie.ToString;
         QueParam.ExecSQL(vErro);
      except // try
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível alterar o retorno do manifesto da NFe em uJustManiDest -> '+E.Message);
            MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtWarning, [mbOk]);
            Exit;
         end;
      end;
   finally
      QueParam.Close;
      FreeAndNil(QueParam);
      HideWait;
   end;
   btFecharClick(Sender);
end;

procedure TFrmJustManiDest.ckCienOperClick(Sender: TObject);
begin
   ckConfOper.Checked    := False;
   ckOperNaoReal.Checked := False;
   ckDescOper.Checked    := False;
   auxEveNFe             := teManifDestCiencia;
end;

procedure TFrmJustManiDest.ckConfOperClick(Sender: TObject);
begin
   ckCienOper.Checked    := False;
   ckOperNaoReal.Checked := False;
   ckDescOper.Checked    := False;
   auxEveNFe             := teManifDestConfirmacao;
end;

procedure TFrmJustManiDest.ckOperNaoRealClick(Sender: TObject);
begin
   ckCienOper.Checked := False;
   ckConfOper.Checked := False;
   ckDescOper.Checked := False;
   auxEveNFe          := teManifDestOperNaoRealizada;
end;

procedure TFrmJustManiDest.ckDescOperClick(Sender: TObject);
begin
   ckCienOper.Checked    := False;
   ckConfOper.Checked    := False;
   ckOperNaoReal.Checked := False;
   auxEveNFe             := teManifDestDesconhecimento;
end;

procedure TFrmJustManiDest.FormShow(Sender: TObject);
begin
   edNomPes.Text        := recNomPess;
   edNotfis.AsInteger   := recNotFis;
   edNroSerie.AsInteger := recNroSerie;
   edDatEmi.Date        := recDatEmi;
   edVlrNotFis.AsFloat  := recVlrNotFis;
end;

procedure TFrmJustManiDest.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmJustManiDest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
