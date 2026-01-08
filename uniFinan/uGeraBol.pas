unit uGeraBol;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  AdvGlowButton, LMDControl, LMDCustomControl, LMDCustomPanel, Marclib,
  LMDCustomBevelPanel, LMDSimplePanel, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDButtonControl, LMDCustomCheckBox,
  LMDCheckBox, uRESTDWBasicDB, ACBrBoleto, ACBrBoletoFCFortesFr, ACBrBase;
type
  TFrmGeraBol = class(TForm)
    PanelCabecalho: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    PanelInventario: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    btGeraBoleto: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    ckPessoa: TLMDCheckBox;
    ckConvenio: TLMDCheckBox;
    chbPdfBol: TLMDCheckBox;
    chbEmailBol: TLMDCheckBox;
    chbGeraRem: TLMDCheckBox;
    chbRegOnLine: TLMDCheckBox;
    procedure btFecharClick(Sender: TObject);
    procedure chbPdfBolClick(Sender: TObject);
    procedure chbEmailBolClick(Sender: TObject);
    procedure btGeraBoletoClick(Sender: TObject);
    procedure ckPessoaClick(Sender: TObject);
    procedure ckConvenioClick(Sender: TObject);
    procedure chbGeraRemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    TabTitu:TRESTDWClientSQL;
    recBol:Boolean; // Se gerou certo o boleto retorna TRUE
  end;
var
  FrmGeraBol: TFrmGeraBol;
implementation
{$R *.dfm}
uses uBoletos, uDM, uConst, uLibFarm;
procedure TFrmGeraBol.btFecharClick(Sender: TObject);
begin
   TabTitu.Filtered := False;
   Close;
end;
procedure TFrmGeraBol.btGeraBoletoClick(Sender: TObject);
var
   QueParam,QueConv:TRESTDWClientSQL;
   Forma:Integer;
   auxValor:Double;
   auxIDConv,auxBanco:Integer;
begin
   auxValor := 0;
   TabTitu.Filtered := False;
   TabTitu.Filter   := 'GeraBol = '+Aspas('1');
   TabTitu.Filtered := True;
   TabTitu.First;
   auxIDConv := TabTitu.FieldByName('IDConv').AsInteger;
   QueParam := TRESTDWClientSQL.Create(nil);
   QueConv  := TRESTDWClientSQL.Create(nil);
   QueConv.DataBase  := DM.DWDataBase;
   QueParam.DataBase := DM.DWDataBase;
   try
      try
         while not TabTitu.Eof do
         begin
            if ckConvenio.Checked then
            begin
               if auxIDConv <> TabTitu.FieldByName('IDConv').AsInteger then
               begin
                  MostraMsg('Avisoo','Só pode ser gerado um boleto por convênio!',mtWarning, [mbOk]);
                  TabTitu.Filtered := False;
                  Close;
                  Exit;
               end;
               auxValor := auxValor + TabTitu.FieldByName('Vlrtit').AsFloat;
            end else
            begin
               if TabTitu.FieldByName('Nompes').AsString = ''     then raise Exception.Create('Boleto não tem nome do cliente!');
               if TabTitu.FieldByName('CpfCnpjPes').AsString = '' then raise Exception.Create('Cliente'+TabTitu.FieldByName('Nompes').AsString+' sem CPF ou CNPJ válido!');
               if TabTitu.FieldByName('Endpes').AsString = ''     then raise Exception.Create('Cliente'+TabTitu.FieldByName('Nompes').AsString+' sem endereço válido!');
               if TabTitu.FieldByName('NroEnd').AsString = ''     then raise Exception.Create('Cliente'+TabTitu.FieldByName('Nompes').AsString+' sem número do endereço válido!');
               if TabTitu.FieldByName('Baipes').AsString = ''     then raise Exception.Create('Cliente'+TabTitu.FieldByName('Nompes').AsString+' sem bairro válido!');
               if TabTitu.FieldByName('Nommun').AsString = ''     then raise Exception.Create('Cliente'+TabTitu.FieldByName('Nompes').AsString+' sem cidade válida!');
               if TabTitu.FieldByName('Estmun').AsString = ''     then raise Exception.Create('Cliente'+TabTitu.FieldByName('Nompes').AsString+' sem estado válido!');
               if TabTitu.FieldByName('Ceppes').AsString = ''     then raise Exception.Create('Cliente'+TabTitu.FieldByName('Nompes').AsString+' sem CEP válido!');
            end; //if
            TabTitu.Next;
         end; //while
         QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+TabTitu.FieldByName('IDFilial').AsString;
         QueParam.Open;
         auxBanco := QueParam.FieldByName('Codban').AsInteger;
         if ckConvenio.Checked then
         begin
            QueConv.SQL.Text := 'SELECT PES.*, MUN.Nommun, MUN.Estmun FROM arqpessoa PES '+
            'LEFT JOIN arqconvenio CON ON CON.IDPessPri = PES.IDpess '+
            'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
            'WHERE CON.IDConv = '+ auxIDConv.ToString;
            QueConv.Open;
            if QueConv.FieldByName('Nompes').AsString = ''     then raise Exception.Create('Não tem nome do cliente!');
            if QueConv.FieldByName('CpfCnpjPes').AsString = '' then raise Exception.Create('Responsável do convênio: '+QueConv.FieldByName('Nompes').AsString+' sem CPF ou CNPJ válido!');
            if QueConv.FieldByName('Endpes').AsString = ''     then raise Exception.Create('Responsável do convênio: '+QueConv.FieldByName('Nompes').AsString+' sem endereço válido!');
            if QueConv.FieldByName('NroEnd').AsString = ''     then raise Exception.Create('Responsável do convênio: '+QueConv.FieldByName('Nompes').AsString+' sem número do endereço válido!');
            if QueConv.FieldByName('Baipes').AsString = ''     then raise Exception.Create('Responsável do convênio: '+QueConv.FieldByName('Nompes').AsString+' sem bairro válido!');
            if QueConv.FieldByName('Nommun').AsString = ''     then raise Exception.Create('Responsável do convênio: '+QueConv.FieldByName('Nompes').AsString+' sem cidade válida!');
            if QueConv.FieldByName('Estmun').AsString = ''     then raise Exception.Create('Responsável do convênio: '+QueConv.FieldByName('Nompes').AsString+' sem estado válido!');
            if QueConv.FieldByName('Ceppes').AsString = ''     then raise Exception.Create('Responsável do convênio: '+QueConv.FieldByName('Nompes').AsString+' sem CEP válido!');
         end; //if
      except
         on E:Exception do
         begin
            MostraMsg('Aviso',E.Message, mtWarning, [mbOk]);
            Exit;
            Close
         end;
      end;
   finally
      QueConv.Close;
      QueParam.Close;
      FreeAndNil(QueConv);
      FreeAndNil(QueParam);
   end;
   if chbPdfBol.Checked   then Forma := 1;
   if chbEmailBol.Checked then Forma := 2;
   if GeraBoleto(TabTitu.FieldByName('IDTitu').AsInteger, TabTitu.FieldByName('IDFilial').AsInteger, auxBanco, Forma, TabTitu, auxValor,ckConvenio.Checked,chbGeraRem.Checked) = '1' then
        recBol := True
   else recBol := False;
   Close;
end;
procedure TFrmGeraBol.chbEmailBolClick(Sender: TObject);
begin
   if chbEmailBol.Checked then
        chbPdfBol.Checked   := False
   else chbEmailBol.Checked := True;
end;
procedure TFrmGeraBol.chbGeraRemClick(Sender: TObject);
begin
   if chbPdfBol.Checked then
        chbEmailBol.Checked := False
   else chbPdfBol.Checked   := True;
end;
procedure TFrmGeraBol.chbPdfBolClick(Sender: TObject);
begin
   if chbPdfBol.Checked then
        chbEmailBol.Checked := False
   else chbPdfBol.Checked   := True;
end;
procedure TFrmGeraBol.ckConvenioClick(Sender: TObject);
begin
   if ckConvenio.Checked then
        ckPessoa.Checked   := False
   else ckConvenio.Checked := True;
end;
procedure TFrmGeraBol.ckPessoaClick(Sender: TObject);
begin
   if ckPessoa.Checked then
        ckConvenio.Checked := False
   else ckPessoa.Checked   := True;
end;
procedure TFrmGeraBol.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
