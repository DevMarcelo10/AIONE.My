unit uPBM.Vidalink.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Vidalink PBM
  
  Este arquivo demonstra como usar o módulo de integração Vidalink.
  
  Características do Vidalink:
  
  1. REST API com autenticação JWT (usuário/senha/chaveAPI → token)
  2. Foco 100% corporativo (empresas parceiras)
  3. Subsídio de até 100% pela empresa
  4. Desconto em folha de pagamento OU à vista
  5. Receita pré-cadastrada pelo app do beneficiário
  6. Repasse financeiro (não há reposição de produtos)
  7. Mais de 23 mil farmácias credenciadas
  8. Mais de 13.900 produtos cobertos
  
  Empresas parceiras incluem: Bosch, Fiat, IFood, Johnson & Johnson,
  Bridgestone, Cacau Show, Caterpillar, Embraer, Nokia, PepsiCo, etc.
  
  Estrutura do módulo:
  - uPBM.Vidalink.Types.pas : Tipos, records, constantes
  - uPBM.Vidalink.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.NetEncoding, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.Vidalink.Types, uPBM.Vidalink;

type
   TDemoVidalink = class
   private
      FClient: TVidalinkClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACodigoLoja, ARazaoSocial,
         AUsuario, ASenha, AChaveAPI: string; AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploListarConvenios;
      procedure ExemploConsultaElegibilidade;
      procedure ExemploCotacaoVenda;
      procedure ExemploVendaSimples;
      procedure ExemploVendaComCotacao;
      procedure ExemploVendaComReceita;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
      procedure ExemploConsultaProduto;
   end;

implementation

{ TDemoVidalink }

constructor TDemoVidalink.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateVidalinkClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoVidalink.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoVidalink.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoVidalink.Configurar(const ACNPJ, ACodigoLoja, ARazaoSocial,
   AUsuario, ASenha, AChaveAPI: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoLoja, ARazaoSocial, 
      AUsuario, ASenha, AChaveAPI);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('Configuração concluída', 'INFO');
   
   // Testa conexão
   if FClient.TestarConexao then
   begin
      LogCallback('Conexão com Vidalink OK', 'INFO');
      
      // Carrega convênios disponíveis
      if FClient.CarregarConvenios then
         LogCallback('Convênios carregados: ' + IntToStr(FClient.Convenios.Count), 'INFO');
   end
   else
      LogCallback('Falha na conexão: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoVidalink.ExemploListarConvenios;
begin
   LogCallback('=== Listar Convênios Disponíveis ===', 'INFO');
   
   if FClient.CarregarConvenios then
   begin
      LogCallback('Total de convênios: ' + IntToStr(FClient.Convenios.Count), 'INFO');
      
      // Exemplo de verificação de convênio específico
      if FClient.Convenios.Exists('BOSCH') then
         LogCallback('Convênio BOSCH disponível', 'INFO');
      if FClient.Convenios.Exists('FIAT') then
         LogCallback('Convênio FIAT disponível', 'INFO');
      if FClient.Convenios.Exists('IFOOD') then
         LogCallback('Convênio IFOOD disponível', 'INFO');
   end
   else
      LogCallback('Erro ao carregar convênios', 'ERROR');
end;

procedure TDemoVidalink.ExemploConsultaElegibilidade;
var
   LResponse: TVidalinkElegibilidadeResponse;
begin
   LogCallback('=== Consulta de Elegibilidade ===', 'INFO');
   
   // Pode consultar pelo número do cartão virtual OU pelo CPF
   LResponse := FClient.ConsultarElegibilidade('1234567890123456', '', '');
   
   if LResponse.Sucesso then
   begin
      LogCallback('Beneficiário encontrado!', 'INFO');
      LogCallback('Nome: ' + LResponse.Beneficiario.Nome, 'INFO');
      LogCallback('Cartão: ' + LResponse.Beneficiario.NumeroCartao, 'INFO');
      LogCallback('CPF: ' + LResponse.Beneficiario.CPF, 'INFO');
      LogCallback('Convênio: ' + LResponse.Beneficiario.Convenio.Nome, 'INFO');
      LogCallback('Empresa: ' + LResponse.Beneficiario.Convenio.EmpresaCNPJ, 'INFO');
      LogCallback('Subsídio: ' + FormatFloat('0.0', LResponse.Beneficiario.Convenio.PercentualSubsidio) + '%', 'INFO');
      LogCallback('Limite disponível: ' + FormatCurr('R$ #,##0.00', LResponse.Beneficiario.LimiteDisponivel), 'INFO');
      LogCallback('Limite mensal: ' + FormatCurr('R$ #,##0.00', LResponse.Beneficiario.LimiteMensal), 'INFO');
      
      case LResponse.Beneficiario.TipoPagamento of
         tpFolha: LogCallback('Tipo: 100% Desconto em Folha', 'INFO');
         tpAVista: LogCallback('Tipo: 100% À Vista', 'INFO');
         tpMisto: LogCallback('Tipo: Misto (Folha + À Vista)', 'INFO');
      end;
      
      LogCallback('Elegível: ' + BoolToStr(LResponse.Elegivel, True), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoVidalink.ExemploCotacaoVenda;
var
   LRequest: TVidalinkCotacaoRequest;
   LResponse: TVidalinkCotacaoResponse;
   I: Integer;
begin
   LogCallback('=== Cotação de Venda (Simulação) ===', 'INFO');
   LogCallback('Permite ver descontos antes de efetivar', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.NumeroCartao := '1234567890123456';
   LRequest.Beneficiario.CPF := '12345678901';
   
   // Produtos
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TVidalinkProduto.Create('7896181911999', 1, 85.90);  // Alenia
   LRequest.Produtos[1] := TVidalinkProduto.Create('7896261013483', 2, 35.00);  // Cataflan
   
   LRequest.ValorTotal := 155.90;
   
   LResponse := FClient.CotarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** COTAÇÃO REALIZADA ***', 'INFO');
      LogCallback('Código: ' + LResponse.CodigoCotacao, 'INFO');
      LogCallback('Válida por: ' + IntToStr(LResponse.ValidadeMinutos) + ' minutos', 'INFO');
      LogCallback('', 'INFO');
      
      for I := Low(LResponse.Produtos) to High(LResponse.Produtos) do
      begin
         LogCallback(Format('%s - %s', [
            LResponse.Produtos[I].CodigoBarras,
            LResponse.Produtos[I].Descricao
         ]), 'INFO');
         LogCallback(Format('  Valor: R$ %.2f | Subsídio: %.0f%% | Folha: R$ %.2f | À Vista: R$ %.2f', [
            LResponse.Produtos[I].ValorTotal,
            LResponse.Produtos[I].PercentualSubsidio,
            LResponse.Produtos[I].ValorFolha,
            LResponse.Produtos[I].ValorAVista
         ]), 'INFO');
      end;
      
      LogCallback('', 'INFO');
      LogCallback('RESUMO:', 'INFO');
      LogCallback('  Empresa paga (subsídio): ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalSubsidio), 'INFO');
      LogCallback('  Desconto em folha:       ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFolha), 'INFO');
      LogCallback('  À vista na farmácia:     ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalAVista), 'INFO');
   end
   else
      LogCallback('Cotação negada: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoVidalink.ExemploVendaSimples;
var
   LRequest: TVidalinkAutorizacaoRequest;
   LResponse: TVidalinkAutorizacaoResponse;
begin
   LogCallback('=== Venda Simples (Direto) ===', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.NumeroCartao := '1234567890123456';
   LRequest.Beneficiario.CPF := '12345678901';
   LRequest.Beneficiario.Nome := 'JOSE DA SILVA';
   
   // Atendente
   LRequest.Atendente.CPF := '98765432100';
   LRequest.Atendente.Nome := 'ATENDENTE MARIA';
   LRequest.Atendente.Matricula := 'A001';
   
   // Produtos
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TVidalinkProduto.Create('7896181911999', 1, 85.90);
   
   // Dados da venda
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'VDL-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.InformarReceita := False;
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA AUTORIZADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('Subsídio: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalSubsidio), 'INFO');
      LogCallback('Folha: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFolha), 'INFO');
      LogCallback('À Vista: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalAVista), 'INFO');
   end
   else
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'WARN');
end;

procedure TDemoVidalink.ExemploVendaComCotacao;
var
   LCotacao: TVidalinkCotacaoRequest;
   LCotacaoResp: TVidalinkCotacaoResponse;
   LRequest: TVidalinkAutorizacaoRequest;
   LResponse: TVidalinkAutorizacaoResponse;
begin
   LogCallback('=== Venda com Cotação Prévia ===', 'INFO');
   LogCallback('Primeiro cota, depois autoriza', 'INFO');
   LogCallback('', 'INFO');
   
   // ===== PASSO 1: COTAÇÃO =====
   LogCallback('--- Passo 1: Cotação ---', 'INFO');
   
   LCotacao.Clear;
   LCotacao.Beneficiario.NumeroCartao := '9876543210987654';
   LCotacao.Beneficiario.CPF := '11122233344';
   
   SetLength(LCotacao.Produtos, 1);
   LCotacao.Produtos[0] := TVidalinkProduto.Create('7896269900105', 2, 45.00);  // Antak
   
   LCotacao.ValorTotal := 90.00;
   
   LCotacaoResp := FClient.CotarVenda(LCotacao);
   
   if not LCotacaoResp.Sucesso then
   begin
      LogCallback('Cotação negada: ' + LCotacaoResp.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   LogCallback('Cotação OK: ' + LCotacaoResp.CodigoCotacao, 'INFO');
   LogCallback('Subsídio: ' + FormatCurr('R$ #,##0.00', LCotacaoResp.ValorTotalSubsidio), 'INFO');
   LogCallback('Folha: ' + FormatCurr('R$ #,##0.00', LCotacaoResp.ValorTotalFolha), 'INFO');
   
   // ===== PASSO 2: AUTORIZAÇÃO =====
   LogCallback('', 'INFO');
   LogCallback('--- Passo 2: Autorização ---', 'INFO');
   
   LRequest.Clear;
   LRequest.Beneficiario.NumeroCartao := LCotacao.Beneficiario.NumeroCartao;
   LRequest.Beneficiario.CPF := LCotacao.Beneficiario.CPF;
   LRequest.Beneficiario.Nome := 'MARIA SANTOS';
   
   LRequest.Atendente.CPF := '98765432100';
   LRequest.Atendente.Nome := 'CAIXA 01';
   
   LRequest.Produtos := LCotacaoResp.Produtos; // Usa produtos da cotação
   
   LRequest.ValorTotal := 90.00;
   LRequest.NumeroVenda := 'VDLC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.CodigoCotacao := LCotacaoResp.CodigoCotacao; // Referencia a cotação
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA AUTORIZADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
   end
   else
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoVidalink.ExemploVendaComReceita;
var
   LRequest: TVidalinkAutorizacaoRequest;
   LResponse: TVidalinkAutorizacaoResponse;
begin
   LogCallback('=== Venda com Receita Médica ===', 'INFO');
   LogCallback('(Receita pode ser pré-cadastrada pelo app)', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.NumeroCartao := '5555666677778888';
   LRequest.Beneficiario.CPF := '44455566677';
   LRequest.Beneficiario.Nome := 'PEDRO OLIVEIRA';
   
   // Atendente
   LRequest.Atendente.CPF := '98765432100';
   LRequest.Atendente.Nome := 'FARMACEUTICO JOAO';
   
   // Produto controlado
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TVidalinkProduto.Create('7891000000002', 1, 180.00);
   LRequest.Produtos[0].RequerReceita := True;
   
   // Receita médica
   // Opção 1: Receita pré-cadastrada pelo app
   // LRequest.Receita.IdReceitaCadastrada := 'REC-123456';
   
   // Opção 2: Informar dados manualmente
   LRequest.InformarReceita := True;
   LRequest.Receita.CRM := '54321';
   LRequest.Receita.UFMedico := 'SP';
   LRequest.Receita.NomeMedico := 'DRA. ANA COSTA';
   LRequest.Receita.DataReceita := Date - 10;
   
   LRequest.ValorTotal := 180.00;
   LRequest.NumeroVenda := 'VDLR-' + FormatDateTime('yyyymmddhhnnss', Now);
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
      
      if LResponse.CodigoRetorno = TVidalinkCodigosRetorno.RECEITA_OBRIGATORIA then
         LogCallback('Motivo: Este medicamento exige receita médica', 'WARN')
      else if LResponse.CodigoRetorno = TVidalinkCodigosRetorno.RECEITA_JA_UTILIZADA then
         LogCallback('Motivo: Esta receita já foi utilizada', 'WARN');
   end;
end;

procedure TDemoVidalink.ExemploCancelamento;
var
   LRequest: TVidalinkCancelamentoRequest;
   LResponse: TVidalinkCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456789';
   LRequest.NumeroVenda := 'VDL-20241215120000';
   LRequest.Motivo := 'Desistência do cliente';
   
   LRequest.Atendente.CPF := '98765432100';
   LRequest.Atendente.Nome := 'ATENDENTE MARIA';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('Cancelamento confirmado', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoVidalink.ExemploConsultaProduto;
var
   LEan: string;
   LDesconto: Double;
   LRequerReceita: Boolean;
begin
   LogCallback('=== Consulta de Produto ===', 'INFO');
   
   LEan := '7896181911999'; // Alenia
   
   if FClient.ConsultarProduto(LEan, LDesconto, LRequerReceita) then
   begin
      LogCallback('Produto ' + LEan + ' cadastrado no Vidalink', 'INFO');
      LogCallback('Desconto médio: ' + FormatFloat('0.0', LDesconto) + '%', 'INFO');
      if LRequerReceita then
         LogCallback('*** REQUER RECEITA MÉDICA ***', 'WARN')
      else
         LogCallback('Não requer receita', 'INFO');
   end
   else
      LogCallback('Produto ' + LEan + ' NÃO está no programa', 'WARN');
end;

procedure TDemoVidalink.ExemploFluxoCompleto;
var
   LElegibilidade: TVidalinkElegibilidadeResponse;
   LCotacao: TVidalinkCotacaoRequest;
   LCotacaoResp: TVidalinkCotacaoResponse;
   LRequest: TVidalinkAutorizacaoRequest;
   LResponse: TVidalinkAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Fluxo Completo de Venda Vidalink ===', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Conexão
   LogCallback('1. Verificando conexão...', 'INFO');
   if not FClient.TestarConexao then
   begin
      LogCallback('Sem conexão com Vidalink', 'ERROR');
      Exit;
   end;
   
   // 2. Elegibilidade
   LogCallback('2. Consultando elegibilidade do cartão...', 'INFO');
   LElegibilidade := FClient.ConsultarElegibilidade('1234567890123456');
   
   if not LElegibilidade.Sucesso then
   begin
      LogCallback('Cartão não encontrado: ' + LElegibilidade.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   if not LElegibilidade.Elegivel then
   begin
      LogCallback('Beneficiário não elegível', 'WARN');
      Exit;
   end;
   
   LogCallback('Beneficiário: ' + LElegibilidade.Beneficiario.Nome, 'INFO');
   LogCallback('Convênio: ' + LElegibilidade.Beneficiario.Convenio.Nome, 'INFO');
   LogCallback('Subsídio empresa: ' + FormatFloat('0', LElegibilidade.Beneficiario.Convenio.PercentualSubsidio) + '%', 'INFO');
   LogCallback('Limite: ' + FormatCurr('R$ #,##0.00', LElegibilidade.Beneficiario.LimiteDisponivel), 'INFO');
   
   // 3. Cotação (opcional, recomendado)
   LogCallback('', 'INFO');
   LogCallback('3. Cotando produtos...', 'INFO');
   
   LCotacao.Clear;
   LCotacao.Beneficiario := LElegibilidade.Beneficiario;
   
   SetLength(LCotacao.Produtos, 2);
   LCotacao.Produtos[0] := TVidalinkProduto.Create('7896181911999', 1, 85.90);
   LCotacao.Produtos[1] := TVidalinkProduto.Create('7896261013483', 2, 35.00);
   
   LCotacao.ValorTotal := 155.90;
   
   LCotacaoResp := FClient.CotarVenda(LCotacao);
   
   if not LCotacaoResp.Sucesso then
   begin
      LogCallback('Cotação negada: ' + LCotacaoResp.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   LogCallback('Cotação: ' + LCotacaoResp.CodigoCotacao, 'INFO');
   LogCallback('', 'INFO');
   
   // Mostra detalhamento
   for I := Low(LCotacaoResp.Produtos) to High(LCotacaoResp.Produtos) do
   begin
      if LCotacaoResp.Produtos[I].Autorizado then
         LogCallback(Format('  [OK] %s: R$ %.2f → Subsídio: R$ %.2f | Folha: R$ %.2f | À Vista: R$ %.2f', [
            LCotacaoResp.Produtos[I].CodigoBarras,
            LCotacaoResp.Produtos[I].ValorTotal,
            LCotacaoResp.Produtos[I].ValorSubsidio,
            LCotacaoResp.Produtos[I].ValorFolha,
            LCotacaoResp.Produtos[I].ValorAVista
         ]), 'INFO')
      else
         LogCallback(Format('  [X] %s: %s', [
            LCotacaoResp.Produtos[I].CodigoBarras,
            LCotacaoResp.Produtos[I].MensagemRejeicao
         ]), 'WARN');
   end;
   
   LogCallback('', 'INFO');
   LogCallback('EMPRESA PAGA (subsídio): ' + FormatCurr('R$ #,##0.00', LCotacaoResp.ValorTotalSubsidio), 'INFO');
   LogCallback('DESCONTO EM FOLHA:       ' + FormatCurr('R$ #,##0.00', LCotacaoResp.ValorTotalFolha), 'INFO');
   LogCallback('À VISTA NA FARMÁCIA:     ' + FormatCurr('R$ #,##0.00', LCotacaoResp.ValorTotalAVista), 'INFO');
   
   // 4. Autorização
   LogCallback('', 'INFO');
   LogCallback('4. Autorizando venda...', 'INFO');
   
   LRequest.Clear;
   LRequest.Beneficiario := LElegibilidade.Beneficiario;
   
   LRequest.Atendente.CPF := '11122233344';
   LRequest.Atendente.Nome := 'CAIXA PDV01';
   LRequest.Atendente.Matricula := 'C001';
   
   LRequest.Produtos := LCotacaoResp.Produtos;
   
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LRequest.DataHoraVenda := Now;
   LRequest.CodigoCotacao := LCotacaoResp.CodigoCotacao;
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if not LResponse.Sucesso then
   begin
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   // 5. Sucesso!
   LogCallback('', 'INFO');
   LogCallback('*** VENDA CONCLUÍDA COM SUCESSO ***', 'INFO');
   LogCallback('NSU: ' + LResponse.NSU, 'INFO');
   LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   
   // 6. Gravar no banco
   LogCallback('5. Gravando no banco de dados...', 'INFO');
   LogCallback('   venda_id: ' + LRequest.NumeroVenda, 'INFO');
   LogCallback('   vidalink_nsu: ' + LResponse.NSU, 'INFO');
   LogCallback('   vidalink_autorizacao: ' + LResponse.NumeroAutorizacao, 'INFO');
   LogCallback('   vidalink_subsidio: ' + FormatFloat('0.00', LResponse.ValorTotalSubsidio), 'INFO');
   LogCallback('   vidalink_folha: ' + FormatFloat('0.00', LResponse.ValorTotalFolha), 'INFO');
   LogCallback('   vidalink_avista: ' + FormatFloat('0.00', LResponse.ValorTotalAVista), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('IMPORTANTE:', 'WARN');
   LogCallback('- Subsídio: pago pela empresa, será repassado à farmácia (~45 dias)', 'INFO');
   LogCallback('- Folha: descontado na folha de pagamento do beneficiário', 'INFO');
   LogCallback('- À Vista: cliente paga agora na farmácia', 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
