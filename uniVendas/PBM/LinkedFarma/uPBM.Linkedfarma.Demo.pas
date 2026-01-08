unit uPBM.Linkedfarma.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Linkedfarma Fidelidade
  
  Linkedfarma = Programa de fidelização para farmácias e drogarias
  
  Características:
  
  1. REST API com autenticação (ChaveAPI + SecretKey)
  2. Sistema de fidelização com CASHBACK
  3. Promoções: desconto, leve X pague Y, brindes, combos
  4. Fluxo dois passos: Autorizar → Confirmar
  5. Suporte a devolução parcial (estorno de produtos)
  6. Gestão completa de clientes
  
  Diferenciais:
  - Cashback acumulativo que pode ser usado nas compras
  - Cliente pode escolher quanto do cashback usar
  - Histórico de compras do cliente
  - Promoções tipo Leve X Pague Y
  - Estorno parcial por produto
  
  Estrutura do módulo:
  - uPBM.Linkedfarma.Types.pas : Tipos, records, constantes
  - uPBM.Linkedfarma.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.Linkedfarma.Types, uPBM.Linkedfarma;

type
   TDemoLinkedfarma = class
   private
      FClient: TLinkedfarmaClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
         ARazaoSocial, ANomeFantasia, AUF: string; AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploCarregarPromocoes;
      procedure ExemploConsultaCliente;
      procedure ExemploCadastroCliente;
      procedure ExemploConsultaCashback;
      procedure ExemploAutorizacao;
      procedure ExemploVendaCompleta;
      procedure ExemploVendaComCashback;
      procedure ExemploCancelamento;
      procedure ExemploEstornoParcial;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoLinkedfarma }

constructor TDemoLinkedfarma.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateLinkedfarmaClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoLinkedfarma.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoLinkedfarma.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoLinkedfarma.Configurar(const ACNPJ, ACodigoLoja, AChaveAPI,
   ASecretKey, ARazaoSocial, ANomeFantasia, AUF: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
      ARazaoSocial, ANomeFantasia, AUF);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('Configuração Linkedfarma concluída', 'INFO');
   LogCallback('Loja: ' + ACodigoLoja, 'INFO');
   
   if FClient.TestarConexao then
      LogCallback('Conexão OK', 'INFO')
   else
      LogCallback('Falha: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploCarregarPromocoes;
begin
   LogCallback('=== Carregar Promoções ===', 'INFO');
   
   if FClient.CarregarPromocoes then
      LogCallback('Promoções carregadas com sucesso', 'INFO')
   else
      LogCallback('Erro ao carregar promoções', 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploConsultaCliente;
var
   LResponse: TLinkedfarmaClienteResponse;
begin
   LogCallback('=== Consulta Cliente por CPF ===', 'INFO');
   
   LResponse := FClient.ConsultarCliente('12345678901');
   
   if LResponse.Sucesso and LResponse.Encontrado then
   begin
      LogCallback('Cliente encontrado!', 'INFO');
      LogCallback('Código: ' + LResponse.Cliente.Codigo, 'INFO');
      LogCallback('Nome: ' + LResponse.Cliente.Nome, 'INFO');
      LogCallback('CPF: ' + LResponse.Cliente.CPF, 'INFO');
      LogCallback('Celular: ' + LResponse.Cliente.Celular, 'INFO');
      LogCallback('Email: ' + LResponse.Cliente.Email, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('*** CASHBACK DISPONÍVEL: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.SaldoCashback) + ' ***', 'INFO');
      LogCallback('Total em compras: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.TotalCompras), 'INFO');
      
      if LResponse.Cliente.UltimaCompra > 0 then
         LogCallback('Última compra: ' + FormatDateTime('dd/mm/yyyy', LResponse.Cliente.UltimaCompra), 'INFO');
   end
   else if LResponse.Sucesso and not LResponse.Encontrado then
      LogCallback('Cliente NÃO cadastrado - ofereça o cadastro!', 'WARN')
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploCadastroCliente;
var
   LRequest: TLinkedfarmaCadastroClienteRequest;
   LResponse: TLinkedfarmaClienteResponse;
begin
   LogCallback('=== Cadastro de Novo Cliente ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '98765432100';
   LRequest.Cliente.Nome := 'MARIA SANTOS';
   LRequest.Cliente.DataNascimento := EncodeDate(1985, 5, 15);
   LRequest.Cliente.Sexo := 'F';
   LRequest.Cliente.Celular := '11999887766';
   LRequest.Cliente.Email := 'maria@email.com';
   LRequest.Cliente.CEP := '01310100';
   LRequest.Cliente.Endereco := 'AV PAULISTA';
   LRequest.Cliente.Numero := '1000';
   LRequest.Cliente.Bairro := 'BELA VISTA';
   LRequest.Cliente.Cidade := 'SAO PAULO';
   LRequest.Cliente.UF := 'SP';
   LRequest.Cliente.AceitaNotificacao := True;
   LRequest.AceitaTermos := True;
   
   LResponse := FClient.CadastrarCliente(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CLIENTE CADASTRADO COM SUCESSO ***', 'INFO');
      LogCallback('Código: ' + LResponse.Cliente.Codigo, 'INFO');
      LogCallback('Nome: ' + LResponse.Cliente.Nome, 'INFO');
      LogCallback('Cashback inicial: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.SaldoCashback), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploConsultaCashback;
var
   LSaldo: Currency;
begin
   LogCallback('=== Consulta Rápida de Cashback ===', 'INFO');
   
   LSaldo := FClient.ConsultarCashback('12345678901');
   
   LogCallback('Saldo de Cashback: ' + FormatCurr('R$ #,##0.00', LSaldo), 'INFO');
end;

procedure TDemoLinkedfarma.ExemploAutorizacao;
var
   LRequest: TLinkedfarmaAutorizacaoRequest;
   LResponse: TLinkedfarmaAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Autorização de Venda ===', 'INFO');
   
   LRequest.Clear;
   
   // Cliente
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Cliente.Nome := 'JOSE SILVA';
   
   // Operador
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'ATENDENTE JOAO';
   LRequest.Operador.CodigoTerminal := 'PDV01';
   
   // Produtos
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TLinkedfarmaProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TLinkedfarmaProduto.Create('7896261013483', 2, 35.00);
   
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := 'LF-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.UsarCashback := False; // Não usar cashback neste exemplo
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** AUTORIZAÇÃO OK ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('', 'INFO');
      
      for I := Low(LResponse.Produtos) to High(LResponse.Produtos) do
      begin
         if LResponse.Produtos[I].Autorizado then
            LogCallback(Format('[OK] %s - %s', [
               LResponse.Produtos[I].CodigoBarras,
               LResponse.Produtos[I].Descricao
            ]), 'INFO')
         else
            LogCallback(Format('[X] %s - %s', [
               LResponse.Produtos[I].CodigoBarras,
               LResponse.Produtos[I].MensagemRejeicao
            ]), 'WARN');
            
         LogCallback(Format('     R$ %.2f → %.0f%% → R$ %.2f', [
            LResponse.Produtos[I].ValorTotal,
            LResponse.Produtos[I].PercentualDesconto,
            LResponse.Produtos[I].ValorFinal
         ]), 'INFO');
         
         if LResponse.Produtos[I].Cashback > 0 then
            LogCallback('     Cashback: +' + FormatCurr('R$ #,##0.00', LResponse.Produtos[I].Cashback), 'INFO');
      end;
      
      LogCallback('', 'INFO');
      LogCallback('DESCONTO TOTAL: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('CASHBACK GERADO: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalCashback), 'INFO');
      LogCallback('A PAGAR: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      
      LogCallback('', 'INFO');
      LogCallback('>>> AGUARDANDO CONFIRMAÇÃO após pagamento <<<', 'WARN');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploVendaCompleta;
var
   LRequest: TLinkedfarmaAutorizacaoRequest;
   LResponse: TLinkedfarmaConfirmacaoResponse;
begin
   LogCallback('=== Venda Completa (Autoriza + Confirma) ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TLinkedfarmaProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'LFC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.UsarCashback := False;
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('CASHBACK CREDITADO: +' + FormatCurr('R$ #,##0.00', LResponse.CashbackCreditado), 'INFO');
      LogCallback('SALDO CASHBACK: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploVendaComCashback;
var
   LSaldo: Currency;
   LRequest: TLinkedfarmaAutorizacaoRequest;
   LResponse: TLinkedfarmaConfirmacaoResponse;
begin
   LogCallback('=== Venda Usando Cashback ===', 'INFO');
   LogCallback('Cliente pode usar saldo de cashback como desconto!', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Consultar saldo disponível
   LSaldo := FClient.ConsultarCashback('12345678901');
   LogCallback('Saldo disponível: ' + FormatCurr('R$ #,##0.00', LSaldo), 'INFO');
   
   if LSaldo <= 0 then
   begin
      LogCallback('Cliente não tem cashback disponível', 'WARN');
      Exit;
   end;
   
   // 2. Processar venda usando cashback
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TLinkedfarmaProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'LFCB-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // USAR CASHBACK!
   LRequest.UsarCashback := True;
   LRequest.ValorCashbackUsar := Min(LSaldo, 20.00); // Usar até R$ 20 do cashback
   
   LogCallback('Usando cashback: ' + FormatCurr('R$ #,##0.00', LRequest.ValorCashbackUsar), 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA COM CASHBACK CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('Cashback usado: -' + FormatCurr('R$ #,##0.00', LRequest.ValorCashbackUsar), 'INFO');
      LogCallback('Cashback gerado: +' + FormatCurr('R$ #,##0.00', LResponse.CashbackCreditado), 'INFO');
      LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploCancelamento;
var
   LRequest: TLinkedfarmaCancelamentoRequest;
   LResponse: TLinkedfarmaCancelamentoResponse;
begin
   LogCallback('=== Cancelamento Total de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456';
   LRequest.NumeroVenda := 'LF-20241215120000';
   LRequest.Motivo := 'Desistência do cliente';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'SUPERVISOR';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CANCELAMENTO CONFIRMADO ***', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
      LogCallback('Cashback estornado: -' + FormatCurr('R$ #,##0.00', LResponse.CashbackEstornado), 'INFO');
      LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploEstornoParcial;
var
   LRequest: TLinkedfarmaEstornoRequest;
   LResponse: TLinkedfarmaEstornoResponse;
begin
   LogCallback('=== Estorno Parcial (Devolução de Produtos) ===', 'INFO');
   LogCallback('Cliente devolveu apenas 1 produto da venda', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456';
   LRequest.NumeroVenda := 'LF-20241215120000';
   LRequest.Motivo := 'Produto com defeito';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   // Apenas o produto devolvido
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0].CodigoBarras := '7896181911999';
   LRequest.Produtos[0].Quantidade := 1;
   
   LResponse := FClient.EstornarProdutos(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** ESTORNO PARCIAL OK ***', 'INFO');
      LogCallback('NSU Estorno: ' + LResponse.NSUEstorno, 'INFO');
      LogCallback('Valor estornado: ' + FormatCurr('R$ #,##0.00', LResponse.ValorEstornado), 'INFO');
      LogCallback('Cashback estornado: -' + FormatCurr('R$ #,##0.00', LResponse.CashbackEstornado), 'INFO');
      LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoLinkedfarma.ExemploFluxoCompleto;
var
   LClienteResp: TLinkedfarmaClienteResponse;
   LCadastroReq: TLinkedfarmaCadastroClienteRequest;
   LVendaReq: TLinkedfarmaAutorizacaoRequest;
   LVendaResp: TLinkedfarmaConfirmacaoResponse;
   LCPF: string;
   LSaldoCashback: Currency;
begin
   LogCallback('=== Fluxo Completo Linkedfarma ===', 'INFO');
   LogCallback('', 'INFO');
   
   LCPF := '12345678901';
   
   // 1. Testar conexão
   LogCallback('1. Verificando conexão...', 'INFO');
   if not FClient.TestarConexao then
   begin
      LogCallback('Sem conexão', 'ERROR');
      Exit;
   end;
   
   // 2. Consultar/Cadastrar cliente
   LogCallback('', 'INFO');
   LogCallback('2. Consultando cliente...', 'INFO');
   LClienteResp := FClient.ConsultarCliente(LCPF);
   
   if not LClienteResp.Encontrado then
   begin
      LogCallback('Cliente não cadastrado - cadastrando...', 'WARN');
      
      LCadastroReq.Clear;
      LCadastroReq.Cliente.CPF := LCPF;
      LCadastroReq.Cliente.Nome := 'CLIENTE NOVO';
      LCadastroReq.Cliente.Celular := '11999998888';
      LCadastroReq.Cliente.AceitaNotificacao := True;
      LCadastroReq.AceitaTermos := True;
      
      LClienteResp := FClient.CadastrarCliente(LCadastroReq);
      
      if not LClienteResp.Sucesso then
      begin
         LogCallback('Erro ao cadastrar: ' + LClienteResp.MensagemRetorno, 'ERROR');
         Exit;
      end;
   end;
   
   LogCallback('Cliente: ' + LClienteResp.Cliente.Nome, 'INFO');
   LSaldoCashback := LClienteResp.Cliente.SaldoCashback;
   LogCallback('Cashback disponível: ' + FormatCurr('R$ #,##0.00', LSaldoCashback), 'INFO');
   
   // 3. Processar venda
   LogCallback('', 'INFO');
   LogCallback('3. Processando venda...', 'INFO');
   
   LVendaReq.Clear;
   LVendaReq.Cliente.CPF := LCPF;
   LVendaReq.Cliente.Nome := LClienteResp.Cliente.Nome;
   LVendaReq.Operador.CPF := '11122233344';
   LVendaReq.Operador.Nome := 'CAIXA PDV01';
   LVendaReq.Operador.CodigoTerminal := 'PDV01';
   
   SetLength(LVendaReq.Produtos, 2);
   LVendaReq.Produtos[0] := TLinkedfarmaProduto.Create('7896181911999', 1, 85.90);
   LVendaReq.Produtos[1] := TLinkedfarmaProduto.Create('7896261013483', 2, 35.00);
   
   LVendaReq.ValorTotal := 155.90;
   LVendaReq.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LVendaReq.NumeroCupom := '000123';
   LVendaReq.DataHoraVenda := Now;
   
   // Usar cashback se tiver saldo
   if LSaldoCashback >= 10 then
   begin
      LVendaReq.UsarCashback := True;
      LVendaReq.ValorCashbackUsar := Min(LSaldoCashback, 20.00);
      LogCallback('Usando cashback: ' + FormatCurr('R$ #,##0.00', LVendaReq.ValorCashbackUsar), 'INFO');
   end
   else
   begin
      LVendaReq.UsarCashback := False;
      LogCallback('Cashback insuficiente para uso', 'INFO');
   end;
   
   LVendaResp := FClient.VendaCompleta(LVendaReq);
   
   if not LVendaResp.Sucesso then
   begin
      LogCallback('VENDA NEGADA: ' + LVendaResp.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   // 4. Sucesso
   LogCallback('', 'INFO');
   LogCallback('*** VENDA CONCLUÍDA ***', 'INFO');
   LogCallback('NSU: ' + LVendaResp.NSU, 'INFO');
   LogCallback('Autorização: ' + LVendaResp.NumeroAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   LogCallback('*** CASHBACK ***', 'INFO');
   LogCallback('Creditado nesta venda: +' + FormatCurr('R$ #,##0.00', LVendaResp.CashbackCreditado), 'INFO');
   LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LVendaResp.SaldoCashback), 'INFO');
   
   // 5. Gravar no banco
   LogCallback('', 'INFO');
   LogCallback('4. Gravando no banco...', 'INFO');
   LogCallback('   venda_id: ' + LVendaReq.NumeroVenda, 'INFO');
   LogCallback('   linked_nsu: ' + LVendaResp.NSU, 'INFO');
   LogCallback('   linked_autorizacao: ' + LVendaResp.NumeroAutorizacao, 'INFO');
   LogCallback('   linked_cashback_usado: ' + FormatFloat('0.00', LVendaReq.ValorCashbackUsar), 'INFO');
   LogCallback('   linked_cashback_gerado: ' + FormatFloat('0.00', LVendaResp.CashbackCreditado), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
