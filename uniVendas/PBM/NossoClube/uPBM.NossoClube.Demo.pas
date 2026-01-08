unit uPBM.NossoClube.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Nosso Clube / Cosmos PRO
  
  PBM da Rede Nossa Farma com sistema de fidelização via MONEYBACK
  
  Características:
  
  1. REST API com autenticação (ChaveAPI + SecretKey)
  2. Sistema MONEYBACK (cashback) com percentual de resgate
  3. Múltiplos programas de benefícios por cliente
  4. Convênio onde Cosmos arca com parte do valor
  5. Suporte a DEVOLUÇÃO de produtos (diferencial!)
  6. Fluxo dois passos: Autorizar → Confirmar
  
  Diferenciais:
  - MONEYBACK: Cliente acumula R$ e pode resgatar até X% por compra
  - CONVÊNIO: Cosmos pode pagar parte do valor da venda
  - DEVOLUÇÃO: Único PBM que permite devolução parcial de produtos
  - Múltiplos programas: Cliente pode ter vários programas ativos
  
  Estrutura do módulo:
  - uPBM.NossoClube.Types.pas : Tipos, records, constantes
  - uPBM.NossoClube.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.Math, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.NossoClube.Types, uPBM.NossoClube;

type
   TDemoNossoClube = class
   private
      FClient: TNossoClubeClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
         ARazaoSocial, ANomeFantasia, ACodigoRede, AUF: string;
         AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploCarregarProgramas;
      procedure ExemploConsultaCliente;
      procedure ExemploCadastroCliente;
      procedure ExemploConsultaMoneyback;
      procedure ExemploConsultaBeneficios;
      procedure ExemploAutorizacao;
      procedure ExemploVendaCompleta;
      procedure ExemploVendaComMoneyback;
      procedure ExemploVendaComConvenio;
      procedure ExemploCancelamento;
      procedure ExemploDevolucaoParcial;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoNossoClube }

constructor TDemoNossoClube.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateNossoClubeClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoNossoClube.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoNossoClube.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoNossoClube.Configurar(const ACNPJ, ACodigoLoja, AChaveAPI,
   ASecretKey, ARazaoSocial, ANomeFantasia, ACodigoRede, AUF: string;
   AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
      ARazaoSocial, ANomeFantasia, ACodigoRede, AUF);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('=== Configuração NOSSO CLUBE / COSMOS concluída ===', 'INFO');
   LogCallback('Loja: ' + ACodigoLoja + ' | Rede: ' + ACodigoRede, 'INFO');
   
   if FClient.TestarConexao then
      LogCallback('Conexão OK', 'INFO')
   else
      LogCallback('Falha: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoNossoClube.ExemploCarregarProgramas;
var
   LProgramas: TNossoClubeProgramas;
   I: Integer;
begin
   LogCallback('=== Carregar Programas de Benefícios ===', 'INFO');
   
   if FClient.CarregarProgramas then
   begin
      LProgramas := FClient.Programas.GetAll;
      LogCallback('Total: ' + IntToStr(Length(LProgramas)) + ' programas', 'INFO');
      
      for I := Low(LProgramas) to High(LProgramas) do
      begin
         LogCallback('', 'INFO');
         LogCallback('Programa: ' + LProgramas[I].Nome, 'INFO');
         LogCallback('  Código: ' + LProgramas[I].Codigo, 'INFO');
         LogCallback('  Descrição: ' + LProgramas[I].Descricao, 'INFO');
         
         case LProgramas[I].TipoPrograma of
            ntpDesconto: LogCallback('  Tipo: Desconto direto', 'INFO');
            ntpMoneyback: LogCallback('  Tipo: Gera Moneyback', 'INFO');
            ntpConvenio: LogCallback('  Tipo: Convênio empresa', 'INFO');
            ntpFidelidade: LogCallback('  Tipo: Programa fidelidade', 'INFO');
            ntpLaboratorio: LogCallback('  Tipo: Programa do laboratório', 'INFO');
         end;
         
         if LProgramas[I].PercentualDesconto > 0 then
            LogCallback('  Desconto: ' + FormatFloat('0.0', LProgramas[I].PercentualDesconto) + '%', 'INFO');
         if LProgramas[I].PercentualMoneyback > 0 then
            LogCallback('  Moneyback: ' + FormatFloat('0.0', LProgramas[I].PercentualMoneyback) + '%', 'INFO');
         if LProgramas[I].Laboratorio <> '' then
            LogCallback('  Laboratório: ' + LProgramas[I].Laboratorio, 'INFO');
      end;
   end
   else
      LogCallback('Erro ao carregar programas', 'ERROR');
end;

procedure TDemoNossoClube.ExemploConsultaCliente;
var
   LResponse: TNossoClubeClienteResponse;
   I: Integer;
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
      LogCallback('', 'INFO');
      LogCallback('*** SALDO MONEYBACK: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.SaldoMoneyback) + ' ***', 'INFO');
      LogCallback('*** PERCENTUAL RESGATE: ' + FormatFloat('0', LResponse.Cliente.PercentualResgate) + '% ***', 'INFO');
      LogCallback('', 'INFO');
      LogCallback('Valor máximo resgate: ' + FormatCurr('R$ #,##0.00', 
         LResponse.Cliente.SaldoMoneyback * LResponse.Cliente.PercentualResgate / 100), 'INFO');
      LogCallback('Total em compras: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.TotalCompras), 'INFO');
      
      if LResponse.Cliente.UltimaCompra > 0 then
         LogCallback('Última compra: ' + FormatDateTime('dd/mm/yyyy', LResponse.Cliente.UltimaCompra), 'INFO');
      
      // Programas do cliente
      if Length(LResponse.Cliente.Programas) > 0 then
      begin
         LogCallback('', 'INFO');
         LogCallback('Programas disponíveis:', 'INFO');
         for I := Low(LResponse.Cliente.Programas) to High(LResponse.Cliente.Programas) do
            LogCallback('  - ' + LResponse.Cliente.Programas[I].Nome + 
               ' (' + FormatFloat('0', LResponse.Cliente.Programas[I].PercentualDesconto) + '% desc)', 'INFO');
      end;
   end
   else if LResponse.Sucesso and not LResponse.Encontrado then
      LogCallback('Cliente NÃO cadastrado - ofereça o cadastro!', 'WARN')
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploCadastroCliente;
var
   LRequest: TNossoClubeCadastroClienteRequest;
   LResponse: TNossoClubeClienteResponse;
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
   LRequest.Cliente.Endereco := 'AV NOSSA SENHORA DA PENHA';
   LRequest.Cliente.Numero := '1500';
   LRequest.Cliente.Bairro := 'SANTA LUCIA';
   LRequest.Cliente.Cidade := 'VITORIA';
   LRequest.Cliente.UF := 'ES';
   LRequest.AceitaTermos := True;
   
   LResponse := FClient.CadastrarCliente(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CLIENTE CADASTRADO COM SUCESSO ***', 'INFO');
      LogCallback('Código: ' + LResponse.Cliente.Codigo, 'INFO');
      LogCallback('Nome: ' + LResponse.Cliente.Nome, 'INFO');
      LogCallback('Moneyback inicial: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.SaldoMoneyback), 'INFO');
      LogCallback('Percentual resgate: ' + FormatFloat('0', LResponse.Cliente.PercentualResgate) + '%', 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploConsultaMoneyback;
var
   LSaldo: Currency;
   LPercentual: Double;
begin
   LogCallback('=== Consulta Rápida de Moneyback ===', 'INFO');
   
   LSaldo := FClient.ConsultarMoneyback('12345678901');
   LPercentual := FClient.ConsultarPercentualResgate('12345678901');
   
   LogCallback('Saldo Moneyback: ' + FormatCurr('R$ #,##0.00', LSaldo), 'INFO');
   LogCallback('Percentual máximo resgate: ' + FormatFloat('0', LPercentual) + '%', 'INFO');
   LogCallback('', 'INFO');
   LogCallback('Exemplo: Compra de R$ 100,00', 'INFO');
   LogCallback('  Pode resgatar até: ' + FormatCurr('R$ #,##0.00', 100 * LPercentual / 100), 'INFO');
   LogCallback('  Resgate efetivo: ' + FormatCurr('R$ #,##0.00', Min(LSaldo, 100 * LPercentual / 100)), 'INFO');
end;

procedure TDemoNossoClube.ExemploConsultaBeneficios;
var
   LBeneficios: TNossoClubeBeneficios;
   I: Integer;
begin
   LogCallback('=== Consulta Benefícios do Cliente ===', 'INFO');
   
   LBeneficios := FClient.ConsultarBeneficios('12345678901');
   
   if Length(LBeneficios) > 0 then
   begin
      LogCallback('Total: ' + IntToStr(Length(LBeneficios)) + ' benefícios', 'INFO');
      
      for I := Low(LBeneficios) to High(LBeneficios) do
      begin
         LogCallback('', 'INFO');
         LogCallback('Produto: ' + LBeneficios[I].DescricaoProduto, 'INFO');
         LogCallback('  EAN: ' + LBeneficios[I].CodigoBarras, 'INFO');
         LogCallback('  Programa: ' + LBeneficios[I].NomePrograma, 'INFO');
         LogCallback('  Desconto: ' + FormatFloat('0.0', LBeneficios[I].PercentualDesconto) + '%', 'INFO');
         if LBeneficios[I].PercentualMoneyback > 0 then
            LogCallback('  Moneyback: ' + FormatFloat('0.0', LBeneficios[I].PercentualMoneyback) + '%', 'INFO');
         if LBeneficios[I].ValorConvenio > 0 then
            LogCallback('  Convênio paga: ' + FormatCurr('R$ #,##0.00', LBeneficios[I].ValorConvenio), 'INFO');
      end;
   end
   else
      LogCallback('Nenhum benefício disponível', 'WARN');
end;

procedure TDemoNossoClube.ExemploAutorizacao;
var
   LRequest: TNossoClubeAutorizacaoRequest;
   LResponse: TNossoClubeAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Autorização de Venda (sem usar Moneyback) ===', 'INFO');
   
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
   LRequest.Produtos[0] := TNossoClubeProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TNossoClubeProduto.Create('7896261013483', 2, 35.00);
   
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := 'NC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.UsarMoneyback := False;
   LRequest.ManterDescontosFarmacia := False;
   
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
         
         if LResponse.Produtos[I].ValorMoneyback > 0 then
            LogCallback('     Gera Moneyback: +' + FormatCurr('R$ #,##0.00', LResponse.Produtos[I].ValorMoneyback), 'INFO');
      end;
      
      LogCallback('', 'INFO');
      LogCallback('DESCONTO TOTAL: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('MONEYBACK A GERAR: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalMoneyback), 'INFO');
      if LResponse.ValorConvenioPago > 0 then
         LogCallback('CONVÊNIO PAGA: ' + FormatCurr('R$ #,##0.00', LResponse.ValorConvenioPago), 'INFO');
      LogCallback('CLIENTE PAGA: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      
      LogCallback('', 'INFO');
      LogCallback('>>> AGUARDANDO CONFIRMAÇÃO após pagamento <<<', 'WARN');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploVendaCompleta;
var
   LRequest: TNossoClubeAutorizacaoRequest;
   LResponse: TNossoClubeConfirmacaoResponse;
begin
   LogCallback('=== Venda Completa (Autoriza + Confirma) ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TNossoClubeProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'NCC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.UsarMoneyback := False;
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('MONEYBACK CREDITADO: +' + FormatCurr('R$ #,##0.00', LResponse.MoneybackCreditado), 'INFO');
      LogCallback('SALDO MONEYBACK: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoMoneyback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploVendaComMoneyback;
var
   LSaldo: Currency;
   LPercentual: Double;
   LRequest: TNossoClubeAutorizacaoRequest;
   LResponse: TNossoClubeConfirmacaoResponse;
   LValorCompra, LMaxResgate, LResgate: Currency;
begin
   LogCallback('=== Venda Usando MONEYBACK ===', 'INFO');
   LogCallback('Cliente pode usar saldo de Moneyback como desconto!', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Consultar saldo de moneyback
   LSaldo := FClient.ConsultarMoneyback('12345678901');
   LPercentual := FClient.ConsultarPercentualResgate('12345678901');
   
   LogCallback('Saldo Moneyback: ' + FormatCurr('R$ #,##0.00', LSaldo), 'INFO');
   LogCallback('Percentual máximo resgate: ' + FormatFloat('0', LPercentual) + '%', 'INFO');
   
   if LSaldo < 5 then
   begin
      LogCallback('Cliente não tem Moneyback suficiente (mínimo R$ 5,00)', 'WARN');
      Exit;
   end;
   
   // 2. Calcular quanto pode usar
   LValorCompra := 155.90;
   LMaxResgate := LValorCompra * LPercentual / 100;  // Ex: 50% de R$ 155,90 = R$ 77,95
   LResgate := Min(LSaldo, LMaxResgate);             // Usar o menor entre saldo e máximo
   
   LogCallback('', 'INFO');
   LogCallback('Valor da compra: ' + FormatCurr('R$ #,##0.00', LValorCompra), 'INFO');
   LogCallback('Máximo resgate (' + FormatFloat('0', LPercentual) + '%): ' + FormatCurr('R$ #,##0.00', LMaxResgate), 'INFO');
   LogCallback('Resgate efetivo: ' + FormatCurr('R$ #,##0.00', LResgate), 'INFO');
   LogCallback('', 'INFO');
   
   // 3. Processar venda usando moneyback
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TNossoClubeProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TNossoClubeProduto.Create('7896261013483', 2, 35.00);
   
   LRequest.ValorTotal := LValorCompra;
   LRequest.NumeroVenda := 'NCMB-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // USAR MONEYBACK!
   LRequest.UsarMoneyback := True;
   LRequest.ValorMoneybackUsar := LResgate;
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA COM MONEYBACK CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('Moneyback usado: -' + FormatCurr('R$ #,##0.00', LResgate), 'INFO');
      LogCallback('Novo moneyback gerado: +' + FormatCurr('R$ #,##0.00', LResponse.MoneybackCreditado), 'INFO');
      LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoMoneyback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploVendaComConvenio;
var
   LRequest: TNossoClubeAutorizacaoRequest;
   LResponse: TNossoClubeConfirmacaoResponse;
begin
   LogCallback('=== Venda com CONVÊNIO (Cosmos paga parte) ===', 'INFO');
   LogCallback('Em alguns programas, a Cosmos arca com parte do valor!', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TNossoClubeProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'NCCV-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.UsarMoneyback := False;
   
   // Valor que será pago pelo convênio (se autorizado)
   LRequest.ValorConvenio := 20.00;
   
   LogCallback('Valor total: ' + FormatCurr('R$ #,##0.00', LRequest.ValorTotal), 'INFO');
   LogCallback('Convênio solicitado: ' + FormatCurr('R$ #,##0.00', LRequest.ValorConvenio), 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA COM CONVÊNIO CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('CONVÊNIO PAGOU: ' + FormatCurr('R$ #,##0.00', LResponse.ValorConvenioPago), 'INFO');
      LogCallback('Moneyback creditado: +' + FormatCurr('R$ #,##0.00', LResponse.MoneybackCreditado), 'INFO');
      LogCallback('Saldo Moneyback: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoMoneyback), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploCancelamento;
var
   LRequest: TNossoClubeCancelamentoRequest;
   LResponse: TNossoClubeCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456';
   LRequest.NumeroVenda := 'NC-20241215120000';
   LRequest.Motivo := 'Desistência do cliente';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'SUPERVISOR';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CANCELAMENTO CONFIRMADO ***', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
      LogCallback('Moneyback estornado: -' + FormatCurr('R$ #,##0.00', LResponse.MoneybackEstornado), 'INFO');
      LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoMoneyback), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploDevolucaoParcial;
var
   LRequest: TNossoClubeDevolucaoRequest;
   LResponse: TNossoClubeDevolucaoResponse;
begin
   LogCallback('=== DEVOLUÇÃO PARCIAL de Produtos ===', 'INFO');
   LogCallback('Diferencial do Nosso Clube: permite devolução parcial!', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456';
   LRequest.NumeroAutorizacao := 'AUTH789';
   LRequest.NumeroVenda := 'NC-20241215120000';
   LRequest.Motivo := 'Cliente devolveu 1 item';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   // Apenas os produtos devolvidos
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TNossoClubeProduto.Create('7896181911999', 1, 0); // Qtd devolvida
   
   LogCallback('Devolvendo 1x ' + LRequest.Produtos[0].CodigoBarras, 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.DevolverProdutos(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** DEVOLUÇÃO CONFIRMADA ***', 'INFO');
      LogCallback('NSU Devolução: ' + LResponse.NSUDevolucao, 'INFO');
      LogCallback('Valor devolvido: ' + FormatCurr('R$ #,##0.00', LResponse.ValorDevolvido), 'INFO');
      LogCallback('Moneyback estornado: -' + FormatCurr('R$ #,##0.00', LResponse.MoneybackEstornado), 'INFO');
      LogCallback('Novo saldo: ' + FormatCurr('R$ #,##0.00', LResponse.SaldoMoneyback), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoNossoClube.ExemploFluxoCompleto;
var
   LClienteResp: TNossoClubeClienteResponse;
   LCadastroReq: TNossoClubeCadastroClienteRequest;
   LVendaReq: TNossoClubeAutorizacaoRequest;
   LVendaResp: TNossoClubeConfirmacaoResponse;
   LCPF: string;
   LMaxResgate: Currency;
begin
   LogCallback('=== Fluxo Completo NOSSO CLUBE / COSMOS ===', 'INFO');
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
      LCadastroReq.AceitaTermos := True;
      
      LClienteResp := FClient.CadastrarCliente(LCadastroReq);
      
      if not LClienteResp.Sucesso then
      begin
         LogCallback('Erro ao cadastrar: ' + LClienteResp.MensagemRetorno, 'ERROR');
         Exit;
      end;
   end;
   
   LogCallback('Cliente: ' + LClienteResp.Cliente.Nome, 'INFO');
   LogCallback('Moneyback: ' + FormatCurr('R$ #,##0.00', LClienteResp.Cliente.SaldoMoneyback), 'INFO');
   LogCallback('Percentual resgate: ' + FormatFloat('0', LClienteResp.Cliente.PercentualResgate) + '%', 'INFO');
   LogCallback('Programas: ' + IntToStr(Length(LClienteResp.Cliente.Programas)), 'INFO');
   
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
   LVendaReq.Produtos[0] := TNossoClubeProduto.Create('7896181911999', 1, 85.90);
   LVendaReq.Produtos[1] := TNossoClubeProduto.Create('7896261013483', 2, 35.00);
   
   LVendaReq.ValorTotal := 155.90;
   LVendaReq.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LVendaReq.NumeroCupom := '000123';
   LVendaReq.DataHoraVenda := Now;
   
   // Usar moneyback se tiver saldo
   if LClienteResp.Cliente.SaldoMoneyback >= 5 then
   begin
      LMaxResgate := LVendaReq.ValorTotal * LClienteResp.Cliente.PercentualResgate / 100;
      LVendaReq.UsarMoneyback := True;
      LVendaReq.ValorMoneybackUsar := Min(LClienteResp.Cliente.SaldoMoneyback, LMaxResgate);
      LogCallback('Usando Moneyback: ' + FormatCurr('R$ #,##0.00', LVendaReq.ValorMoneybackUsar), 'INFO');
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
   LogCallback('*** MONEYBACK ***', 'INFO');
   LogCallback('Creditado: +' + FormatCurr('R$ #,##0.00', LVendaResp.MoneybackCreditado), 'INFO');
   LogCallback('Saldo atual: ' + FormatCurr('R$ #,##0.00', LVendaResp.SaldoMoneyback), 'INFO');
   if LVendaResp.ValorConvenioPago > 0 then
      LogCallback('Convênio pagou: ' + FormatCurr('R$ #,##0.00', LVendaResp.ValorConvenioPago), 'INFO');
   
   // 5. Gravar no banco
   LogCallback('', 'INFO');
   LogCallback('4. Gravando no banco...', 'INFO');
   LogCallback('   venda_id: ' + LVendaReq.NumeroVenda, 'INFO');
   LogCallback('   nc_nsu: ' + LVendaResp.NSU, 'INFO');
   LogCallback('   nc_autorizacao: ' + LVendaResp.NumeroAutorizacao, 'INFO');
   LogCallback('   nc_moneyback_usado: ' + FormatFloat('0.00', LVendaReq.ValorMoneybackUsar), 'INFO');
   LogCallback('   nc_moneyback_gerado: ' + FormatFloat('0.00', LVendaResp.MoneybackCreditado), 'INFO');
   LogCallback('   nc_convenio_pago: ' + FormatFloat('0.00', LVendaResp.ValorConvenioPago), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
