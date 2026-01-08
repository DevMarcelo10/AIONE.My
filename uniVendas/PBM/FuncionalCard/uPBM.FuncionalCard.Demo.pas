unit uPBM.FuncionalCard.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Funcional Card PBM
  
  Este arquivo demonstra como usar o módulo de integração Funcional Card.
  
  Características do Funcional Card:
  
  1. REST API com autenticação JWT (login/senha → token)
  2. Fluxo em 2 etapas: Pré-autorização → Confirmação
  3. Convênio corporativo (desconto em folha) ou programa de indústria
  4. Suporte a anexar receita médica (imagem em Base64)
  5. Até 80% de desconto em medicamentos
  6. Pagamento pós-pago (desconto na folha do funcionário)
  
  Estrutura do módulo:
  - uPBM.FuncionalCard.Types.pas : Tipos, records, constantes
  - uPBM.FuncionalCard.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.NetEncoding, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.FuncionalCard.Types, uPBM.FuncionalCard;

type
   TDemoFuncionalCard = class
   private
      FClient: TFuncionalCardClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACodigoLoja, ARazaoSocial,
         AUsuario, ASenha: string; AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploConsultaElegibilidade;
      procedure ExemploVendaSimplificada;
      procedure ExemploVendaDuasEtapas;
      procedure ExemploVendaComReceita;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
      procedure ExemploConsultaProduto;
   end;

implementation

{ TDemoFuncionalCard }

constructor TDemoFuncionalCard.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateFuncionalCardClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoFuncionalCard.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoFuncionalCard.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoFuncionalCard.Configurar(const ACNPJ, ACodigoLoja, ARazaoSocial,
   AUsuario, ASenha: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoLoja, ARazaoSocial, AUsuario, ASenha);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('Configuração concluída', 'INFO');
   
   // Testa conexão (autentica)
   if FClient.TestarConexao then
      LogCallback('Conexão com Funcional Card OK', 'INFO')
   else
      LogCallback('Falha na conexão: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoFuncionalCard.ExemploConsultaElegibilidade;
var
   LResponse: TFuncionalElegibilidadeResponse;
begin
   LogCallback('=== Consulta de Elegibilidade ===', 'INFO');
   
   // Consulta pelo número do cartão (e opcionalmente CPF)
   LResponse := FClient.ConsultarElegibilidade('1234567890123456', '12345678901');
   
   if LResponse.Sucesso then
   begin
      LogCallback('Beneficiário encontrado!', 'INFO');
      LogCallback('Nome: ' + LResponse.Beneficiario.Nome, 'INFO');
      LogCallback('Cartão: ' + LResponse.Beneficiario.NumeroCartao, 'INFO');
      LogCallback('Convênio: ' + LResponse.Beneficiario.Convenio.Nome, 'INFO');
      LogCallback('Empresa: ' + LResponse.Beneficiario.Convenio.EmpresaPagadora, 'INFO');
      LogCallback('Limite disponível: ' + FormatCurr('R$ #,##0.00', LResponse.Beneficiario.LimiteDisponivel), 'INFO');
      LogCallback('Elegível: ' + BoolToStr(LResponse.Elegivel, True), 'INFO');
      
      if not LResponse.Elegivel then
         LogCallback('Beneficiário não elegível para compras neste momento', 'WARN');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoFuncionalCard.ExemploVendaSimplificada;
var
   LRequest: TFuncionalPreAutorizacaoRequest;
   LResponse: TFuncionalConfirmacaoResponse;
begin
   LogCallback('=== Venda Simplificada (1 chamada) ===', 'INFO');
   LogCallback('Pré-autoriza e confirma automaticamente', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.NumeroCartao := '1234567890123456';
   LRequest.Beneficiario.CPF := '12345678901';
   LRequest.Beneficiario.Nome := 'JOSE DA SILVA';
   
   // Vendedor
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'ATENDENTE MARIA';
   LRequest.Vendedor.Matricula := 'V001';
   
   // Produtos
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TFuncionalProduto.Create('7891234567890', 1, 89.90);
   LRequest.Produtos[1] := TFuncionalProduto.Create('7899876543210', 2, 45.00);
   
   // Dados da venda
   LRequest.ValorTotal := 179.90;
   LRequest.NumeroVenda := 'FC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.InformarReceita := False;
   
   // Executa (pré-autoriza + confirma em uma chamada)
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA AUTORIZADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Código Autorização: ' + LResponse.CodigoAutorizacao, 'INFO');
   end
   else
   begin
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'WARN');
      LogCallback('Código: ' + LResponse.CodigoRetorno, 'WARN');
   end;
end;

procedure TDemoFuncionalCard.ExemploVendaDuasEtapas;
var
   LRequest: TFuncionalPreAutorizacaoRequest;
   LPreAuth: TFuncionalPreAutorizacaoResponse;
   LConfirm: TFuncionalConfirmacaoRequest;
   LConfirmResp: TFuncionalConfirmacaoResponse;
   I: Integer;
begin
   LogCallback('=== Venda em 2 Etapas ===', 'INFO');
   LogCallback('Permite revisar antes de confirmar', 'INFO');
   LogCallback('', 'INFO');
   
   // ========== ETAPA 1: PRÉ-AUTORIZAÇÃO ==========
   LogCallback('--- Etapa 1: Pré-Autorização ---', 'INFO');
   
   LRequest.Clear;
   
   LRequest.Beneficiario.NumeroCartao := '9876543210987654';
   LRequest.Beneficiario.CPF := '11122233344';
   LRequest.Beneficiario.Nome := 'MARIA SANTOS';
   
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TFuncionalProduto.Create('7891000000001', 1, 150.00);
   
   LRequest.ValorTotal := 150.00;
   LRequest.NumeroVenda := 'FC2E-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   LPreAuth := FClient.PreAutorizarVenda(LRequest);
   
   if not LPreAuth.Sucesso then
   begin
      LogCallback('Pré-autorização negada: ' + LPreAuth.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   LogCallback('Pré-autorização OK!', 'INFO');
   LogCallback('Número Autorização: ' + LPreAuth.NumeroAutorizacao, 'INFO');
   LogCallback('Código Transação: ' + LPreAuth.CodigoTransacao, 'INFO');
   LogCallback('', 'INFO');
   
   // Mostra detalhamento (permite revisar)
   LogCallback('Detalhamento:', 'INFO');
   for I := Low(LPreAuth.Produtos) to High(LPreAuth.Produtos) do
   begin
      LogCallback(Format('  %s - %s', [
         LPreAuth.Produtos[I].CodigoBarras,
         LPreAuth.Produtos[I].Descricao
      ]), 'INFO');
      LogCallback(Format('    Valor: R$ %.2f | Desconto: %.1f%% | Beneficiário paga: R$ %.2f', [
         LPreAuth.Produtos[I].ValorTotal,
         LPreAuth.Produtos[I].PercentualDesconto,
         LPreAuth.Produtos[I].ValorBeneficiario
      ]), 'INFO');
      
      if LPreAuth.Produtos[I].RequerReceita then
         LogCallback('    *** REQUER RECEITA MÉDICA ***', 'WARN');
   end;
   
   LogCallback('', 'INFO');
   LogCallback('Subsídio (empresa/indústria): ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalSubsidio), 'INFO');
   LogCallback('Beneficiário paga: ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalBeneficiario), 'INFO');
   
   // Aqui o operador pode revisar e decidir se confirma
   // Em produção, pode haver interação com usuário
   
   // ========== ETAPA 2: CONFIRMAÇÃO ==========
   LogCallback('', 'INFO');
   LogCallback('--- Etapa 2: Confirmação ---', 'INFO');
   
   LConfirm.Clear;
   LConfirm.NumeroAutorizacao := LPreAuth.NumeroAutorizacao;
   LConfirm.CodigoTransacao := LPreAuth.CodigoTransacao;
   LConfirm.NumeroVenda := LRequest.NumeroVenda;
   LConfirm.Vendedor := LRequest.Vendedor;
   
   LConfirmResp := FClient.ConfirmarVenda(LConfirm);
   
   if LConfirmResp.Sucesso then
   begin
      LogCallback('*** VENDA CONFIRMADA ***', 'INFO');
      LogCallback('NSU definitivo: ' + LConfirmResp.NSU, 'INFO');
      LogCallback('Código Autorização: ' + LConfirmResp.CodigoAutorizacao, 'INFO');
   end
   else
      LogCallback('Erro na confirmação: ' + LConfirmResp.MensagemRetorno, 'ERROR');
end;

procedure TDemoFuncionalCard.ExemploVendaComReceita;
var
   LRequest: TFuncionalPreAutorizacaoRequest;
   LResponse: TFuncionalConfirmacaoResponse;
begin
   LogCallback('=== Venda com Receita Médica ===', 'INFO');
   LogCallback('Para medicamentos que exigem prescrição', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.NumeroCartao := '5555666677778888';
   LRequest.Beneficiario.CPF := '44455566677';
   LRequest.Beneficiario.Nome := 'PEDRO OLIVEIRA';
   
   // Vendedor
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'FARMACEUTICO JOAO';
   
   // Produto que requer receita
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TFuncionalProduto.Create('7891000000002', 1, 220.00);
   LRequest.Produtos[0].RequerReceita := True;
   
   // Receita médica
   LRequest.InformarReceita := True;
   LRequest.Receita.CRM := '12345';
   LRequest.Receita.UFMedico := 'SP';
   LRequest.Receita.NomeMedico := 'DR. ANTONIO MEDICO';
   LRequest.Receita.DataReceita := Date - 5; // 5 dias atrás
   LRequest.Receita.NumeroReceita := 'REC-2024-001';
   
   // Para anexar imagem da receita, usar:
   // LRequest.Receita.ArquivoBase64 := TNetEncoding.Base64.Encode(LBytesImagem);
   // LRequest.Receita.NomeArquivo := 'receita.jpg';
   
   LRequest.ValorTotal := 220.00;
   LRequest.NumeroVenda := 'FCR-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA AUTORIZADA (COM RECEITA) ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
   end
   else
   begin
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'WARN');
      
      // Verifica se foi por falta de receita
      if LResponse.CodigoRetorno = TFuncionalCodigosRetorno.RECEITA_OBRIGATORIA then
         LogCallback('Motivo: Este medicamento exige receita médica', 'WARN')
      else if LResponse.CodigoRetorno = TFuncionalCodigosRetorno.RECEITA_VENCIDA then
         LogCallback('Motivo: Receita médica vencida', 'WARN');
   end;
end;

procedure TDemoFuncionalCard.ExemploCancelamento;
var
   LRequest: TFuncionalCancelamentoRequest;
   LResponse: TFuncionalCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456789';           // NSU da venda original
   LRequest.NumeroVenda := 'FC-20241215120000'; // ID original
   LRequest.Motivo := 'Desistência do cliente';
   
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'ATENDENTE MARIA';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('Cancelamento confirmado', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
   end
   else
   begin
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
      
      // Verifica motivos comuns
      if LResponse.CodigoRetorno = TFuncionalCodigosRetorno.TRANSACAO_JA_CANCELADA then
         LogCallback('Esta venda já foi cancelada anteriormente', 'WARN')
      else if LResponse.CodigoRetorno = TFuncionalCodigosRetorno.TRANSACAO_NAO_ENCONTRADA then
         LogCallback('Venda não encontrada', 'WARN');
   end;
end;

procedure TDemoFuncionalCard.ExemploConsultaProduto;
var
   LEan: string;
   LDesconto: Double;
   LRequerReceita: Boolean;
begin
   LogCallback('=== Consulta de Produto ===', 'INFO');
   
   LEan := '7891234567890';
   
   if FClient.ConsultarProduto(LEan, LDesconto, LRequerReceita) then
   begin
      LogCallback('Produto ' + LEan + ' cadastrado no Funcional Card', 'INFO');
      LogCallback('Desconto: ' + FormatFloat('0.00', LDesconto) + '%', 'INFO');
      if LRequerReceita then
         LogCallback('*** REQUER RECEITA MÉDICA ***', 'WARN')
      else
         LogCallback('Não requer receita', 'INFO');
   end
   else
      LogCallback('Produto ' + LEan + ' NÃO está no programa', 'WARN');
end;

procedure TDemoFuncionalCard.ExemploFluxoCompleto;
var
   LElegibilidade: TFuncionalElegibilidadeResponse;
   LRequest: TFuncionalPreAutorizacaoRequest;
   LPreAuth: TFuncionalPreAutorizacaoResponse;
   LConfirm: TFuncionalConfirmacaoRequest;
   LConfirmResp: TFuncionalConfirmacaoResponse;
   I: Integer;
begin
   LogCallback('=== Fluxo Completo de Venda Funcional Card ===', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Verifica conexão
   LogCallback('1. Verificando conexão...', 'INFO');
   if not FClient.TestarConexao then
   begin
      LogCallback('Sem conexão com Funcional Card', 'ERROR');
      Exit;
   end;
   
   // 2. Consulta elegibilidade
   LogCallback('2. Consultando elegibilidade do cartão...', 'INFO');
   LElegibilidade := FClient.ConsultarElegibilidade('1234567890123456');
   
   if not LElegibilidade.Sucesso then
   begin
      LogCallback('Cartão não encontrado: ' + LElegibilidade.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   if not LElegibilidade.Elegivel then
   begin
      LogCallback('Beneficiário não elegível para compras', 'WARN');
      Exit;
   end;
   
   LogCallback('Beneficiário: ' + LElegibilidade.Beneficiario.Nome, 'INFO');
   LogCallback('Convênio: ' + LElegibilidade.Beneficiario.Convenio.Nome, 'INFO');
   LogCallback('Empresa: ' + LElegibilidade.Beneficiario.Convenio.EmpresaPagadora, 'INFO');
   LogCallback('Limite: ' + FormatCurr('R$ #,##0.00', LElegibilidade.Beneficiario.LimiteDisponivel), 'INFO');
   
   // 3. Pré-autoriza
   LogCallback('', 'INFO');
   LogCallback('3. Enviando pré-autorização...', 'INFO');
   
   LRequest.Clear;
   LRequest.Beneficiario := LElegibilidade.Beneficiario;
   
   LRequest.Vendedor.CPF := '11122233344';
   LRequest.Vendedor.Nome := 'CAIXA PDV01';
   LRequest.Vendedor.Matricula := 'C001';
   
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TFuncionalProduto.Create('7891000100001', 1, 75.90);
   LRequest.Produtos[1] := TFuncionalProduto.Create('7891000100002', 2, 42.00);
   
   LRequest.ValorTotal := 159.90;
   LRequest.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LRequest.DataHoraVenda := Now;
   
   LPreAuth := FClient.PreAutorizarVenda(LRequest);
   
   if not LPreAuth.Sucesso then
   begin
      LogCallback('Pré-autorização negada: ' + LPreAuth.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   LogCallback('Pré-autorização OK: ' + LPreAuth.NumeroAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   
   // Mostra resumo
   LogCallback('Resumo da venda:', 'INFO');
   for I := Low(LPreAuth.Produtos) to High(LPreAuth.Produtos) do
   begin
      if LPreAuth.Produtos[I].Autorizado then
         LogCallback(Format('  [OK] %s: R$ %.2f → R$ %.2f (%.0f%% desc)', [
            LPreAuth.Produtos[I].CodigoBarras,
            LPreAuth.Produtos[I].ValorTotal,
            LPreAuth.Produtos[I].ValorBeneficiario,
            LPreAuth.Produtos[I].PercentualDesconto
         ]), 'INFO')
      else
         LogCallback(Format('  [X] %s: %s', [
            LPreAuth.Produtos[I].CodigoBarras,
            LPreAuth.Produtos[I].MensagemRejeicao
         ]), 'WARN');
   end;
   
   LogCallback('', 'INFO');
   LogCallback('SUBSÍDIO (empresa paga): ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalSubsidio), 'INFO');
   LogCallback('BENEFICIÁRIO PAGA:       ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalBeneficiario), 'INFO');
   LogCallback('(Será descontado na folha de pagamento)', 'INFO');
   
   // 4. Confirma
   LogCallback('', 'INFO');
   LogCallback('4. Confirmando venda...', 'INFO');
   
   LConfirm.Clear;
   LConfirm.NumeroAutorizacao := LPreAuth.NumeroAutorizacao;
   LConfirm.CodigoTransacao := LPreAuth.CodigoTransacao;
   LConfirm.NumeroVenda := LRequest.NumeroVenda;
   LConfirm.Vendedor := LRequest.Vendedor;
   
   LConfirmResp := FClient.ConfirmarVenda(LConfirm);
   
   if not LConfirmResp.Sucesso then
   begin
      LogCallback('Erro na confirmação: ' + LConfirmResp.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   // 5. Sucesso!
   LogCallback('', 'INFO');
   LogCallback('*** VENDA CONCLUÍDA COM SUCESSO ***', 'INFO');
   LogCallback('NSU: ' + LConfirmResp.NSU, 'INFO');
   LogCallback('Autorização: ' + LConfirmResp.CodigoAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   
   // 6. Gravar no banco
   LogCallback('5. Gravando no banco de dados...', 'INFO');
   LogCallback('   venda_id: ' + LRequest.NumeroVenda, 'INFO');
   LogCallback('   funcional_nsu: ' + LConfirmResp.NSU, 'INFO');
   LogCallback('   funcional_autorizacao: ' + LConfirmResp.CodigoAutorizacao, 'INFO');
   LogCallback('   funcional_subsidio: ' + FormatFloat('0.00', LPreAuth.ValorTotalSubsidio), 'INFO');
   LogCallback('   funcional_beneficiario: ' + FormatFloat('0.00', LPreAuth.ValorTotalBeneficiario), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
