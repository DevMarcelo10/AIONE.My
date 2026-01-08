unit uFecVenda;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, RxToolEdit,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Vcl.Mask,
   FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.StdCtrls, Vcl.DBCtrls, LMDCustomMaskEdit, LMDMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, Math;

type
  TOnMensagemEvent = procedure(Sender: TObject; const Mensagem: string) of object;

  TAprazoParc = record
    QtdParc: Integer;
    ValorParc: array[1..100] of Currency;
  end;

  TFrmFecVenda = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    pnGeral: TLMDSimplePanel;
    pnEntrega: TLMDSimplePanel;
    chEnviarEntrega: TLMDDBCheckBox;
    pnBotaoFinalizar: TLMDSimplePanel;
    btFinalizar: TAdvGlowButton;
    pnCesta: TLMDSimplePanel;
    pnFormasPagto: TLMDSimplePanel;
    pnFormaPagtoTotal: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    pnFormaPagtoCab: TLMDSimplePanel;
    lbFormaPagtoCab: TLMDLabel;
    pnTotalPed: TLMDSimplePanel;
    edTotalPedido: TLMDDBLabeledEdit;
    edDescVlr: TLMDDBLabeledEdit;
    LMDLabel8: TLMDLabel;
    edTotalBruto: TLMDDBLabeledEdit;
    edDescPerc: TLMDDBLabeledEdit;
    pnCupom: TLMDSimplePanel;
    edCupom: TLMDMaskEdit;
    lbDinheiro: TLMDLabel;
    pnPix: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edPix: TLMDMaskEdit;
    pnCartDigital: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    edCartDigital: TLMDMaskEdit;
    pnAprazo: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    edAprazo: TLMDMaskEdit;
    pnCheque: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    edCheque: TLMDMaskEdit;
    pnCredito: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    edCredito: TLMDMaskEdit;
    pnDebito: TLMDSimplePanel;
    LMDLabel6: TLMDLabel;
    edDebito: TLMDMaskEdit;
    pnDinheiro: TLMDSimplePanel;
    LMDLabel7: TLMDLabel;
    edDinheiro: TLMDMaskEdit;
    edTotalApagar: TLMDMaskEdit;
    lbTotalApagar: TLMDLabel;
    edNrCesta: TLMDEdit;
    lbNrCesta: TLMDLabel;
    TimerDebounce: TTimer;
    edAprazoParc: TLMDSpinEdit;
    TimerPromDesc: TTimer;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerDebounceTimer(Sender: TObject);
    procedure edDinheiroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btFinalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edAprazoParcExit(Sender: TObject);
    procedure edDinheiroEnter(Sender: TObject);
    procedure TimerPromDescTimer(Sender: TObject);
    procedure edAprazoCustomButtons0Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
    FExibirAtalhos: Boolean;
    FOnRecalcPromDesc: TOnMensagemEvent;
    FFormPagtoAtual: Integer;
    FParcAprazo: TAprazoParc;
    function GeraParcelas(qtdParc: Integer; LimCreCli: Currency): Currency;
    function SomaParcelas(): Currency;
    procedure ZeraParcelas();
    procedure RecalculaPromDesc();
    procedure SomaTotalApagar();
    procedure MostraAtalhos(Exibir: Boolean);
 public
    { Public declarations }
    parFechaObg: Boolean;     // Fechamento Obrigatório = True / Fechamento Rápido = False
    parCestaObg: Boolean;
    parIDPess: Integer;       // Código do Cliente
    parVenFormaPagto: String; // Código Formas Pagto onde Cliente é obrigatório
    //
    retNroCesta: String;
    retIDForPag_Principal: Integer;
    retFormasPagto: array[0..7] of TLMDMaskEdit;
    //
    retLimCreCli: Currency;
    procedure FormaPagtoInclui(AIDForPag: Integer; Ativo: Boolean);
    procedure FormaPagtoOrdem(AIDForPag: Integer; formasPagtoValidas: String);
    procedure ReorganizarTabOrder();
    property OnRecalcPromDesc: TOnMensagemEvent read FOnRecalcPromDesc write FOnRecalcPromDesc;
 end;

var
   FrmFecVenda: TFrmFecVenda;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uVendas;

procedure TFrmFecVenda.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if btFinalizar.ModalResult <> mrOK then
    retIDForPag_Principal:= 0;
end;

procedure TFrmFecVenda.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   //
   retFormasPagto[0]:= edDinheiro;
   retFormasPagto[1]:= edDebito;
   retFormasPagto[2]:= edCredito;
   retFormasPagto[3]:= edCheque;
   retFormasPagto[4]:= edAprazo;
   retFormasPagto[5]:= edCartDigital;
   retFormasPagto[6]:= edPix;
   retFormasPagto[7]:= edCupom;
end;

procedure TFrmFecVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //CTRL + H
  if (Key = 72) and (ssCtrl in Shift) then
  begin
    FExibirAtalhos:= not(FExibirAtalhos);
    MostraAtalhos(FExibirAtalhos);
    key:= 0;
  end;
  //CTRL + S
  if (Key = 83) and (ssCtrl in Shift) then
  begin
    if btFinalizar.Enabled then
      btFinalizarClick(Sender);
    key:= 0;
  end;
end;

procedure TFrmFecVenda.FormShow(Sender: TObject);
begin
  retIDForPag_Principal:= 0;
end;

procedure TFrmFecVenda.TimerDebounceTimer(Sender: TObject);
begin
  TimerDebounce.Enabled:= False;

  SomaTotalApagar();

  btFinalizar.Enabled:= (edTotalApagar.AsString.Trim = FormatFloat('#,##0.00',FrmVendas.TabPedidoTotPedido.Ascurrency) );
end;

procedure TFrmFecVenda.TimerPromDescTimer(Sender: TObject);
begin
  TimerPromDesc.Enabled:= False;

  if not btFinalizar.Enabled then
    RecalculaPromDesc();
end;

procedure TFrmFecVenda.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmFecVenda.btFinalizarClick(Sender: TObject);
var
  valorPrincipal: Currency;
begin
  // Venda A Prazo sempre valida se Cliente preenchido - Código da Venda A Prazo = 05
  if parVenFormaPagto = EmptyStr then
    parVenFormaPagto:= '05'
  else
    parVenFormaPagto:= parVenFormaPagto + ',05' ;

  // Cliente não preenchido verifica se forma pagto cliente é obrigatório
  if (parIDPess <= 0) and (parVenFormaPagto <> EmptyStr) then
  begin
    for var I := 0 to High(FrmFecVenda.retFormasPagto) do
    begin
      // Só verifica se forma de pagto for maior que zero
      if TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).AsCurrency > 0 then
      begin
        var sIDForPag:= FormatFloat('00', TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).Tag);

        if AnsiPos(sIDForPag, parVenFormaPagto) > 0 then
        begin
          var msg:= TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).ValidationMsgString;
          MostraMsg('Dado não informado','Cliente Obrigatório para vendas '+msg+' !',mtWarning, [mbOk]);
          Exit;
        end;
      end;
    end;
  end;

  if parFechaObg then
  begin
    // Verifica Forma Pagto Principal, ou seja qual foi o maior valor
    valorPrincipal:= 0;
    for var I := 0 to High(FrmFecVenda.retFormasPagto) do
    begin
      if TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).AsCurrency > valorPrincipal then
      begin
        valorPrincipal:= TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).AsCurrency;
        retIDForPag_Principal:= TLMDMaskEdit(FrmFecVenda.retFormasPagto[I]).Tag;
      end;
    end;
  end else
  begin
    retIDForPag_Principal:= 99;  // Fechamento rápido não tem forma pagto, padronizado como 99
  end;

  // Validação Nr. Cesta Obrigatória
  if parCestaObg and (edNrCesta.Text = EmptyStr) then
  begin
    retIDForPag_Principal:= 0;
    MostraMsg('Atenção','Preencha o Número da Cesta!',mtWarning, [mbOk]);
    edNrCesta.SetFocus;
    exit;
  end;

  // Finaliza Venda
  retNroCesta:= edNrCesta.Text;
  btFinalizar.ModalResult:= mrOK;
  Self.Close;
end;

procedure TFrmFecVenda.edAprazoCustomButtons0Click(Sender: TObject; index: Integer);
begin
  ShowMessage('Mostra Valor das Parcelas');
end;

procedure TFrmFecVenda.edAprazoParcExit(Sender: TObject);
begin
  edAprazo.SetValue(0.00);
  ZeraParcelas();
  //
  if edAprazoParc.Value >= 1 then
  begin
    var vlrTotParc:= GeraParcelas(edAprazoParc.Value, retLimCreCli);

    edAprazo.SetValue( vlrTotParc );
  end;
  //
  TimerDebounce.Enabled := False;
  TimerDebounce.Enabled := True;
end;

function TFrmFecVenda.GeraParcelas(qtdParc: Integer; LimCreCli: Currency): Currency;
var
  vlrParc: Currency;
begin
  Result:= 0;
  FParcAprazo.QtdParc:= qtdParc;

  vlrParc:= (FrmVendas.TabPedidoTotPedido.AsCurrency-edTotalApagar.AsCurrency)/qtdParc;

  vlrParc:= Trunc(vlrParc * 100) / 100; // Trunca em duas casas demais

  for var I := 1 to qtdParc do
  begin
    FParcAprazo.ValorParc[I]:= vlrParc;
    Result:= Result + vlrParc;
  end;

  // Ajusta Diferença centavos
  // Diferença fica na primeira parcela
  if FrmVendas.TabPedidoTotPedido.AsCurrency <> Result then
  begin
    var dif:= (FrmVendas.TabPedidoTotPedido.AsCurrency-edTotalApagar.AsCurrency) - Result;

    FParcAprazo.ValorParc[1]:= RoundTo(FParcAprazo.ValorParc[1]  + dif, -2);
  end;

  // Se tem Limite de Crédito e parcelas do convênio
  if (LimCreCli > 0) then
  begin
    // Estourou o Limite de Crédito
    if (FParcAprazo.ValorParc[1] > LimCreCli) then
    begin
      MostraMsg('Atenção','Limite de Crédito do Cliente Excedeu!' + #13+#10 +
                'Limite disponível por parcela é de R$ ' + FormatFloat('###,###,###,##0.00', LimCreCli)
                ,mtWarning, [mbOk]);

      Result:= 0;
      edAprazoParc.SetFocus;
      exit;
    end;
    
  end;
  

  Result:= FParcAprazo.ValorParc[1];  // Retorna o Valor da Primeira Parcela
end;

function TFrmFecVenda.SomaParcelas(): Currency;
begin
  Result:= 0;

  for var I := 1 to FParcAprazo.QtdParc do
    Result:= Result + FParcAprazo.ValorParc[I];
end;

procedure TFrmFecVenda.ZeraParcelas();
begin
  FParcAprazo.QtdParc:= 0;

  for var I := 1 to 100 do
    FParcAprazo.ValorParc[I]:= 0;
end;

procedure TFrmFecVenda.edDinheiroEnter(Sender: TObject);
begin
  TimerPromDesc.Enabled := False;
  TimerPromDesc.Enabled := True;

  FFormPagtoAtual:= TLMDMaskEdit(Sender).Tag;
end;

procedure TFrmFecVenda.edDinheiroKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  TimerDebounce.Enabled := False;
  TimerDebounce.Enabled := True;
end;

procedure TFrmFecVenda.FormaPagtoInclui(AIDForPag: Integer; Ativo: Boolean);
begin
  case AIDForPag of
    1: pnDinheiro.Visible:= Ativo;
    2: pnDebito.Visible:= Ativo;
    3: pnCredito.Visible:= Ativo;
    4: pnCheque.Visible:= Ativo;
    5: pnAprazo.Visible:= Ativo;
    6: pnCartDigital.Visible:= Ativo;
    7: pnPix.Visible:= Ativo;
    9: pnCupom.Visible:= Ativo;
  end;
end;

// Ordena as Formas Pagto Aceitas para Promoção/Desconto
// Formas Aceitas vem antes das formas não aceitas
// Parâmetros  AIDForPag = ID FormaPagto / formasPagtoValidas = Formas Válidas '01,02,03,04,05'
procedure TFrmFecVenda.FormaPagtoOrdem(AIDForPag: Integer; formasPagtoValidas: String);
var
  forPag: String;
  painelMovido: TLMDSimplePanel;
  ultimoTabOrder: Integer;
begin
  forPag := FormatFloat('00', AIDForPag);
  painelMovido := nil;

  // Procura a Forma Pagto dentro da lista das formasPagtoValidas
  // Caso não ache ordena para o Final
  if AnsiPos(forPag, formasPagtoValidas) = 0 then
  begin
    // Identifica qual painel será movido
    case AIDForPag of
      1: painelMovido := pnDinheiro;
      2: painelMovido := pnDebito;
      3: painelMovido := pnCredito;
      4: painelMovido := pnCheque;
      5: painelMovido := pnAprazo;
      6: painelMovido := pnCartDigital;
      7: painelMovido := pnPix;
      9: painelMovido := pnCupom;
    end;

    if Assigned(painelMovido) then
    begin
      // Move o painel para o final
      painelMovido.Align := alBottom;
      painelMovido.Align := alTop;

      // Ajusta o TabOrder para ser o último
      ReorganizarTabOrder();
    end;
  end;
end;

procedure TFrmFecVenda.ReorganizarTabOrder();
var
  paineis: array of TLMDSimplePanel;
  i, j: Integer;
  tempPanel: TLMDSimplePanel;
begin
  // Cria array com todos os painéis de forma de pagamento
  SetLength(paineis, 8);
  paineis[0] := pnDinheiro;
  paineis[1] := pnDebito;
  paineis[2] := pnCredito;
  paineis[3] := pnCheque;
  paineis[4] := pnAprazo;
  paineis[5] := pnCartDigital;
  paineis[6] := pnPix;
  paineis[7] := pnCupom;

  // Ordena os painéis pela posição Top (bubble sort simples)
  for i := 0 to Length(paineis) - 2 do
  begin
    for j := 0 to Length(paineis) - 2 - i do
    begin
      if paineis[j].Top > paineis[j + 1].Top then
      begin
        tempPanel := paineis[j];
        paineis[j] := paineis[j + 1];
        paineis[j + 1] := tempPanel;
      end;
    end;
  end;

  // Atribui o TabOrder baseado na ordem visual
  for i := 0 to Length(paineis) - 1 do
  begin
    paineis[i].TabOrder := i;
  end;
end;

procedure TFrmFecVenda.RecalculaPromDesc();
begin
  if FFormPagtoAtual > 0 then
      if Assigned(FOnRecalcPromDesc) then
        FOnRecalcPromDesc(Self, FormatFloat('00', FFormPagtoAtual));
end;

procedure TFrmFecVenda.SomaTotalApagar();
var
  valor: Currency;
begin
  valor:= edDinheiro.AsCurrency + edDebito.AsCurrency +
            edCredito.AsCurrency + edCheque.AsCurrency +
              SomaParcelas() + edCartDigital.AsCurrency +
                edPix.AsCurrency + edCupom.AsCurrency;

  edTotalApagar.Text:= FormatFloat('#,##0.00',valor);
end;

procedure TFrmFecVenda.MostraAtalhos(Exibir: Boolean);
var
  I: Integer;
  Componente: TComponent;
  Botao: TAdvGlowButton;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    Componente := Components[I];
    if Componente is TAdvGlowButton then
    begin
      Botao := TAdvGlowButton(Componente);
      if Botao.ShortCutHint <> '' then
      begin
        if Exibir then
          Botao.ShowShortCutHint
        else
          Botao.HideShortCutHint;
      end;
    end;
  end;
end;

end.
