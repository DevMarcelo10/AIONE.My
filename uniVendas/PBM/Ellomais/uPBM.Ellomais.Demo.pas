unit uPBM.Ellomais.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Ellomais / Facillite
  
  Ellomais = Grupo de 6+ bandeiras de drogarias (formado em 2009)
  Facillite = Rede de fidelização do Espírito Santo
  
  Ambas usam a mesma API, diferenciadas apenas pelo endpoint.
  
  Características:
  
  1. REST API com autenticação (ChaveAPI + SecretKey)
  2. Sistema de fidelização com PONTOS + CASHBACK
  3. Campanhas: desconto, pontos, cashback, brindes, leve X pague Y
  4. Fluxo dois passos: Autorizar → Confirmar
  5. Cartão de fidelidade numerado
  6. Descontos em mais de 3.000 medicamentos
  
  Diferenciais:
  - Sistema DUAL: Pontos E Cashback simultaneamente
  - Cartão fidelidade com número único
  - Cliente pode usar pontos OU cashback OU ambos
  - Campanhas promocionais por período
  
  Estrutura do módulo:
  - uPBM.Ellomais.Types.pas : Tipos, records, constantes
  - uPBM.Ellomais.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.Math, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.Ellomais.Types, uPBM.Ellomais;

type
   TDemoEllomais = class
   private
      FClient: TEllomaisClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial (Ellomais ou Facillite)
      procedure ConfigurarEllomais(const ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
         ARazaoSocial, ANomeFantasia, AUF: string; AHomologacao: Boolean = True);
      procedure ConfigurarFacillite(const ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
         ARazaoSocial, ANomeFantasia, AUF: string; AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploCarregarCampanhas;
      procedure ExemploConsultaCliente;
      procedure ExemploCadastroCliente;
      procedure ExemploConsultaSaldos;
      procedure ExemploAutorizacao;
      procedure ExemploVendaCompleta;
      procedure ExemploVendaComPontos;
      procedure ExemploVendaComCashback;
      procedure ExemploVendaComAmbos;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoEllomais }

constructor TDemoEllomais.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateEllomaisClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoEllomais.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoEllomais.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoEllomais.ConfigurarEllomais(const ACNPJ, ACodigoLoja, AChaveAPI,
   ASecretKey, ARazaoSocial, ANomeFantasia, AUF: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
      ARazaoSocial, ANomeFantasia, AUF, erEllomais);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('=== Configuração ELLOMAIS concluída ===', 'INFO');
   LogCallback('Loja: ' + ACodigoLoja, 'INFO');
   
   if FClient.TestarConexao then
      LogCallback('Conexão OK', 'INFO')
   else
      LogCallback('Falha: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoEllomais.ConfigurarFacillite(const ACNPJ, ACodigoLoja, AChaveAPI,
   ASecretKey, ARazaoSocial, ANomeFantasia, AUF: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
      ARazaoSocial, ANomeFantasia, AUF, erFacillite);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('=== Configuração FACILLITE concluída ===', 'INFO');
   LogCallback('Loja: ' + ACodigoLoja, 'INFO');
   
   if FClient.TestarConexao then
      LogCallback('Conexão OK', 'INFO')
   else
      LogCallback('Falha: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoEllomais.ExemploCarregarCampanhas;
var
   LCampanhas: TEllomaisCampanhas;
   I: Integer;
begin
   LogCallback('=== Carregar Campanhas Ativas ===', 'INFO');
   
   if FClient.CarregarCampanhas then
   begin
      LCampanhas := FClient.Campanhas.GetAll;
      LogCallback('Total: ' + IntToStr(Length(LCampanhas)) + ' campanhas', 'INFO');
      
      for I := Low(LCampanhas) to High(LCampanhas) do
      begin
         LogCallback('', 'INFO');
         LogCallback('Campanha: ' + LCampanhas[I].Nome, 'INFO');
         LogCallback('  Código: ' + LCampanhas[I].Codigo, 'INFO');
         LogCallback('  Descrição: ' + LCampanhas[I].Descricao, 'INFO');
         
         case LCampanhas[I].TipoCampanha of
            etcDesconto: LogCallback('  Tipo: Desconto direto', 'INFO');
            etcPontos: LogCallback('  Tipo: Acúmulo de pontos', 'INFO');
            etcCashback: LogCallback('  Tipo: Cashback', 'INFO');
            etcBrinde: LogCallback('  Tipo: Brinde', 'INFO');
            etcLeveXPagueY: LogCallback('  Tipo: Leve X Pague Y', 'INFO');
         end;
         
         if LCampanhas[I].PercentualDesconto > 0 then
            LogCallback('  Desconto: ' + FormatFloat('0.0', LCampanhas[I].PercentualDesconto) + '%', 'INFO');
         if LCampanhas[I].PontosGerados > 0 then
            LogCallback('  Pontos por compra: ' + IntToStr(LCampanhas[I].PontosGerados), 'INFO');
      end;
   end
   else
      LogCallback('Erro ao carregar campanhas', 'ERROR');
end;

procedure TDemoEllomais.ExemploConsultaCliente;
var
   LResponse: TEllomaisClienteResponse;
begin
   LogCallback('=== Consulta Cliente por CPF ===', 'INFO');
   
   LResponse := FClient.ConsultarCliente('12345678901');
   
   if LResponse.Sucesso and LResponse.Encontrado then
   begin
      LogCallback('Cliente encontrado!', 'INFO');
      LogCallback('Código: ' + LResponse.Cliente.Codigo, 'INFO');
      LogCallback('Cartão: ' + LResponse.Cliente.NumeroCartao, 'INFO');
      LogCallback('Nome: ' + LResponse.Cliente.Nome, 'INFO');
      LogCallback('CPF: ' + LResponse.Cliente.CPF, 'INFO');
      LogCallback('Celular: ' + LResponse.Cliente.Celular, 'INFO');
      LogCallback('Email: ' + LResponse.Cliente.Email, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('*** SALDO DE PONTOS: ' + IntToStr(LResponse.Cliente.SaldoPontos) + ' pts ***', 'INFO');
      LogCallback('*** SALDO CASHBACK: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.SaldoCashback) + ' ***', 'INFO');
      LogCallback('Total em compras: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.TotalCompras), 'INFO');
      
      if LResponse.Cliente.UltimaCompra > 0 then
         LogCallback('Última compra: ' + FormatDateTime('dd/mm/yyyy', LResponse.Cliente.UltimaCompra), 'INFO');
   end
   else if LResponse.Sucesso and not LResponse.Encontrado then
      LogCallback('Cliente NÃO cadastrado - ofereça o cadastro!', 'WARN')
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploCadastroCliente;
var
   LRequest: TEllomaisCadastroClienteRequest;
   LResponse: TEllomaisClienteResponse;
begin
   LogCallback('=== Cadastro de Novo Cliente ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '98765432100';
   LRequest.Cliente.Nome := 'MARIA SANTOS';
   LRequest.Cliente.DataNascimento := EncodeDate(1985, 5, 15);
   LRequest.Cliente.Sexo := 'F';
   LRequest.Cliente.Celular := '27999887766';
   LRequest.Cliente.Email := 'maria@email.com';
   LRequest.Cliente.CEP := '29010000';
   LRequest.Cliente.Endereco := 'AV PRINCESA ISABEL';
   LRequest.Cliente.Numero := '100';
   LRequest.Cliente.Bairro := 'CENTRO';
   LRequest.Cliente.Cidade := 'VITORIA';
   LRequest.Cliente.UF := 'ES';
   LRequest.Cliente.AceitaPromocoes := True;
   LRequest.AceitaTermos := True;
   
   LResponse := FClient.CadastrarCliente(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CLIENTE CADASTRADO COM SUCESSO ***', 'INFO');
      LogCallback('Código: ' + LResponse.Cliente.Codigo, 'INFO');
      LogCallback('Cartão Fidelidade: ' + LResponse.Cliente.NumeroCartao, 'INFO');
      LogCallback('Nome: ' + LResponse.Cliente.Nome, 'INFO');
      LogCallback('Pontos iniciais: ' + IntToStr(LResponse.Cliente.SaldoPontos), 'INFO');
      LogCallback('Cashback inicial: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.SaldoCashback), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploConsultaSaldos;
var
   LPontos: Integer;
   LCashback: Currency;
begin
   LogCallback('=== Consulta Rápida de Saldos ===', 'INFO');
   
   LPontos := FClient.ConsultarPontos('12345678901');
   LCashback := FClient.ConsultarCashback('12345678901');
   
   LogCallback('Saldo de Pontos: ' + IntToStr(LPontos) + ' pts', 'INFO');
   LogCallback('Saldo de Cashback: ' + FormatCurr('R$ #,##0.00', LCashback), 'INFO');
end;

procedure TDemoEllomais.ExemploAutorizacao;
var
   LRequest: TEllomaisAutorizacaoRequest;
   LResponse: TEllomaisAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Autorização de Venda (sem usar saldo) ===', 'INFO');
   
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
   LRequest.Produtos[0] := TEllomaisProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TEllomaisProduto.Create('7896261013483', 2, 35.00);
   
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := 'ELLO-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.UsarPontos := False;
   LRequest.UsarCashback := False;
   
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
         
         if LResponse.Produtos[I].PontosGerados > 0 then
            LogCallback('     Pontos: +' + IntToStr(LResponse.Produtos[I].PontosGerados), 'INFO');
      end;
      
      LogCallback('', 'INFO');
      LogCallback('DESCONTO TOTAL: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('PONTOS A GERAR: ' + IntToStr(LResponse.PontosGerados), 'INFO');
      LogCallback('CASHBACK A GERAR: ' + FormatCurr('R$ #,##0.00', LResponse.CashbackGerado), 'INFO');
      LogCallback('A PAGAR: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      
      LogCallback('', 'INFO');
      LogCallback('>>> AGUARDANDO CONFIRMAÇÃO após pagamento <<<', 'WARN');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploVendaCompleta;
var
   LRequest: TEllomaisAutorizacaoRequest;
   LResponse: TEllomaisConfirmacaoResponse;
begin
   LogCallback('=== Venda Completa (Autoriza + Confirma) ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TEllomaisProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'ELLOC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.UsarPontos := False;
   LRequest.UsarCashback := False;
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('PONTOS CREDITADOS: +' + IntToStr(LResponse.PontosCreditados), 'INFO');
      LogCallback('CASHBACK CREDITADO: +' + FormatCurr('R$ #,##0.00', LResponse.CashbackCreditado), 'INFO');
      LogCallback('', 'INFO');
      LogCallback('SALDO PONTOS: ' + IntToStr(LResponse.SaldoPontos), 'INFO');
      LogCallback('SALDO CASHBACK: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploVendaComPontos;
var
   LSaldoPontos: Integer;
   LRequest: TEllomaisAutorizacaoRequest;
   LResponse: TEllomaisConfirmacaoResponse;
begin
   LogCallback('=== Venda Usando PONTOS ===', 'INFO');
   LogCallback('Cliente pode trocar pontos por desconto!', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Consultar saldo de pontos
   LSaldoPontos := FClient.ConsultarPontos('12345678901');
   LogCallback('Saldo de pontos: ' + IntToStr(LSaldoPontos), 'INFO');
   
   if LSaldoPontos < 100 then
   begin
      LogCallback('Cliente não tem pontos suficientes (mínimo 100)', 'WARN');
      Exit;
   end;
   
   // 2. Processar venda usando pontos
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TEllomaisProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'ELLOPT-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // USAR PONTOS!
   LRequest.UsarPontos := True;
   LRequest.PontosUsar := Min(LSaldoPontos, 500); // Usar até 500 pontos
   LRequest.UsarCashback := False;
   
   LogCallback('Usando pontos: ' + IntToStr(LRequest.PontosUsar), 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA COM PONTOS CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('Pontos usados: -' + IntToStr(LRequest.PontosUsar), 'INFO');
      LogCallback('Novos pontos gerados: +' + IntToStr(LResponse.PontosCreditados), 'INFO');
      LogCallback('Novo saldo: ' + IntToStr(LResponse.SaldoPontos), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploVendaComCashback;
var
   LSaldoCashback: Currency;
   LRequest: TEllomaisAutorizacaoRequest;
   LResponse: TEllomaisConfirmacaoResponse;
begin
   LogCallback('=== Venda Usando CASHBACK ===', 'INFO');
   LogCallback('Cliente pode usar saldo de cashback como desconto!', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Consultar saldo de cashback
   LSaldoCashback := FClient.ConsultarCashback('12345678901');
   LogCallback('Saldo de cashback: ' + FormatCurr('R$ #,##0.00', LSaldoCashback), 'INFO');
   
   if LSaldoCashback < 5 then
   begin
      LogCallback('Cliente não tem cashback suficiente (mínimo R$ 5,00)', 'WARN');
      Exit;
   end;
   
   // 2. Processar venda usando cashback
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TEllomaisProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'ELLOCB-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // USAR CASHBACK!
   LRequest.UsarPontos := False;
   LRequest.UsarCashback := True;
   LRequest.ValorCashbackUsar := Min(LSaldoCashback, 20.00); // Usar até R$ 20
   
   LogCallback('Usando cashback: ' + FormatCurr('R$ #,##0.00', LRequest.ValorCashbackUsar), 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA COM CASHBACK CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('Cashback usado: -' + FormatCurr('R$ #,##0.00', LRequest.ValorCashbackUsar), 'INFO');
      LogCallback('Novo cashback gerado: +' + FormatCurr('R$ #,##0.00', LResponse.CashbackCreditado), 'INFO');
      LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploVendaComAmbos;
var
   LSaldoPontos: Integer;
   LSaldoCashback: Currency;
   LRequest: TEllomaisAutorizacaoRequest;
   LResponse: TEllomaisConfirmacaoResponse;
begin
   LogCallback('=== Venda Usando PONTOS + CASHBACK ===', 'INFO');
   LogCallback('Cliente pode usar ambos simultaneamente!', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Consultar saldos
   LSaldoPontos := FClient.ConsultarPontos('12345678901');
   LSaldoCashback := FClient.ConsultarCashback('12345678901');
   LogCallback('Saldo de pontos: ' + IntToStr(LSaldoPontos), 'INFO');
   LogCallback('Saldo de cashback: ' + FormatCurr('R$ #,##0.00', LSaldoCashback), 'INFO');
   
   // 2. Processar venda usando ambos
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TEllomaisProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'ELLODUAL-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // USAR AMBOS!
   LRequest.UsarPontos := LSaldoPontos >= 100;
   LRequest.PontosUsar := Min(LSaldoPontos, 200);
   LRequest.UsarCashback := LSaldoCashback >= 5;
   LRequest.ValorCashbackUsar := Min(LSaldoCashback, 10.00);
   
   LogCallback('Usando pontos: ' + IntToStr(LRequest.PontosUsar), 'INFO');
   LogCallback('Usando cashback: ' + FormatCurr('R$ #,##0.00', LRequest.ValorCashbackUsar), 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA DUAL CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('Novo saldo pontos: ' + IntToStr(LResponse.SaldoPontos), 'INFO');
      LogCallback('Novo saldo cashback: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploCancelamento;
var
   LRequest: TEllomaisCancelamentoRequest;
   LResponse: TEllomaisCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456';
   LRequest.NumeroVenda := 'ELLO-20241215120000';
   LRequest.Motivo := 'Desistência do cliente';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'SUPERVISOR';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CANCELAMENTO CONFIRMADO ***', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
      LogCallback('Pontos estornados: -' + IntToStr(LResponse.PontosEstornados), 'INFO');
      LogCallback('Cashback estornado: -' + FormatCurr('R$ #,##0.00', LResponse.CashbackEstornado), 'INFO');
      LogCallback('', 'INFO');
      LogCallback('Novo saldo pontos: ' + IntToStr(LResponse.SaldoPontos), 'INFO');
      LogCallback('Novo saldo cashback: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoCashback), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoEllomais.ExemploFluxoCompleto;
var
   LClienteResp: TEllomaisClienteResponse;
   LCadastroReq: TEllomaisCadastroClienteRequest;
   LVendaReq: TEllomaisAutorizacaoRequest;
   LVendaResp: TEllomaisConfirmacaoResponse;
   LCPF: string;
begin
   LogCallback('=== Fluxo Completo ' + FClient.RedeNome + ' ===', 'INFO');
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
      LCadastroReq.Cliente.Celular := '27999998888';
      LCadastroReq.Cliente.UF := 'ES';
      LCadastroReq.Cliente.AceitaPromocoes := True;
      LCadastroReq.AceitaTermos := True;
      
      LClienteResp := FClient.CadastrarCliente(LCadastroReq);
      
      if not LClienteResp.Sucesso then
      begin
         LogCallback('Erro ao cadastrar: ' + LClienteResp.MensagemRetorno, 'ERROR');
         Exit;
      end;
   end;
   
   LogCallback('Cliente: ' + LClienteResp.Cliente.Nome, 'INFO');
   LogCallback('Cartão: ' + LClienteResp.Cliente.NumeroCartao, 'INFO');
   LogCallback('Pontos: ' + IntToStr(LClienteResp.Cliente.SaldoPontos), 'INFO');
   LogCallback('Cashback: ' + FormatCurr('R$ #,##0.00', LClienteResp.Cliente.SaldoCashback), 'INFO');
   
   // 3. Processar venda
   LogCallback('', 'INFO');
   LogCallback('3. Processando venda...', 'INFO');
   
   LVendaReq.Clear;
   LVendaReq.Cliente.CPF := LCPF;
   LVendaReq.Cliente.NumeroCartao := LClienteResp.Cliente.NumeroCartao;
   LVendaReq.Cliente.Nome := LClienteResp.Cliente.Nome;
   LVendaReq.Operador.CPF := '11122233344';
   LVendaReq.Operador.Nome := 'CAIXA PDV01';
   LVendaReq.Operador.CodigoTerminal := 'PDV01';
   
   SetLength(LVendaReq.Produtos, 2);
   LVendaReq.Produtos[0] := TEllomaisProduto.Create('7896181911999', 1, 85.90);
   LVendaReq.Produtos[1] := TEllomaisProduto.Create('7896261013483', 2, 35.00);
   
   LVendaReq.ValorTotal := 155.90;
   LVendaReq.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LVendaReq.NumeroCupom := '000123';
   LVendaReq.DataHoraVenda := Now;
   
   // Usar pontos se tiver saldo
   if LClienteResp.Cliente.SaldoPontos >= 100 then
   begin
      LVendaReq.UsarPontos := True;
      LVendaReq.PontosUsar := Min(LClienteResp.Cliente.SaldoPontos, 300);
      LogCallback('Usando pontos: ' + IntToStr(LVendaReq.PontosUsar), 'INFO');
   end;
   
   // Usar cashback se tiver saldo
   if LClienteResp.Cliente.SaldoCashback >= 5 then
   begin
      LVendaReq.UsarCashback := True;
      LVendaReq.ValorCashbackUsar := Min(LClienteResp.Cliente.SaldoCashback, 15.00);
      LogCallback('Usando cashback: ' + FormatCurr('R$ #,##0.00', LVendaReq.ValorCashbackUsar), 'INFO');
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
   LogCallback('*** BENEFÍCIOS CREDITADOS ***', 'INFO');
   LogCallback('Pontos: +' + IntToStr(LVendaResp.PontosCreditados), 'INFO');
   LogCallback('Cashback: +' + FormatCurr('R$ #,##0.00', LVendaResp.CashbackCreditado), 'INFO');
   LogCallback('', 'INFO');
   LogCallback('*** SALDOS ATUALIZADOS ***', 'INFO');
   LogCallback('Pontos: ' + IntToStr(LVendaResp.SaldoPontos), 'INFO');
   LogCallback('Cashback: ' + FormatCurr('R$ #,##0.00', LVendaResp.SaldoCashback), 'INFO');
   
   // 5. Gravar no banco
   LogCallback('', 'INFO');
   LogCallback('4. Gravando no banco...', 'INFO');
   LogCallback('   venda_id: ' + LVendaReq.NumeroVenda, 'INFO');
   LogCallback('   ello_nsu: ' + LVendaResp.NSU, 'INFO');
   LogCallback('   ello_autorizacao: ' + LVendaResp.NumeroAutorizacao, 'INFO');
   LogCallback('   ello_pontos_usados: ' + IntToStr(LVendaReq.PontosUsar), 'INFO');
   LogCallback('   ello_cashback_usado: ' + FormatFloat('0.00', LVendaReq.ValorCashbackUsar), 'INFO');
   LogCallback('   ello_pontos_gerados: ' + IntToStr(LVendaResp.PontosCreditados), 'INFO');
   LogCallback('   ello_cashback_gerado: ' + FormatFloat('0.00', LVendaResp.CashbackCreditado), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
