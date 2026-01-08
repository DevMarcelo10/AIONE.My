unit uPBM.ObjectPro.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Object Pro
  
  Programa de Relacionamento Contínuo para fidelização de clientes
  
  Características:
  
  1. REST API com autenticação (ChaveAPI + SecretKey)
  2. Descontos contínuos em medicamentos
  3. Sistema TOP Venda / Vendedor Show (GAMIFICAÇÃO)
  4. Ranking de vendedores com metas mensais
  5. Canal exclusivo de relacionamento com pacientes
  6. Fluxo dois passos: Autorizar → Confirmar
  
  Diferenciais:
  - TOP VENDA: Sistema de pontuação para vendedores
  - RANKING: Competição entre vendedores e lojas
  - METAS: Acompanhamento de metas mensais
  - RELACIONAMENTO: Canal direto com pacientes
  - GAMIFICAÇÃO: Motivação da equipe de vendas
  
  Estrutura do módulo:
  - uPBM.ObjectPro.Types.pas : Tipos, records, constantes
  - uPBM.ObjectPro.pas       : Cliente REST, JSONBuilder, JSONParser
  
  Contato para credenciamento: (31) 99114-3312
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.Math, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.ObjectPro.Types, uPBM.ObjectPro;

type
   TDemoObjectPro = class
   private
      FClient: TObjectProClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
         ARazaoSocial, ANomeFantasia, AUF: string;
         AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploCarregarProgramas;
      procedure ExemploConsultaCliente;
      procedure ExemploCadastroCliente;
      procedure ExemploAutorizacao;
      procedure ExemploVendaCompleta;
      procedure ExemploCancelamento;
      procedure ExemploRankingVendedores;
      procedure ExemploRankingLojas;
      procedure ExemploMetaVendedor;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoObjectPro }

constructor TDemoObjectPro.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateObjectProClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoObjectPro.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoObjectPro.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoObjectPro.Configurar(const ACNPJ, ACodigoLoja, AChaveAPI,
   ASecretKey, ARazaoSocial, ANomeFantasia, AUF: string;
   AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoLoja, AChaveAPI, ASecretKey,
      ARazaoSocial, ANomeFantasia, AUF);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('=== Configuração OBJECT PRO concluída ===', 'INFO');
   LogCallback('Loja: ' + ACodigoLoja, 'INFO');
   
   if FClient.TestarConexao then
      LogCallback('Conexão OK', 'INFO')
   else
      LogCallback('Falha: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoObjectPro.ExemploCarregarProgramas;
var
   LProgramas: TObjectProProgramas;
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
            otpDesconto: LogCallback('  Tipo: Desconto direto', 'INFO');
            otpFidelidade: LogCallback('  Tipo: Programa fidelidade', 'INFO');
            otpLaboratorio: LogCallback('  Tipo: Programa do laboratório', 'INFO');
            otpTopVenda: LogCallback('  Tipo: TOP Venda (gamificação)', 'INFO');
            otpRelacionamento: LogCallback('  Tipo: Relacionamento contínuo', 'INFO');
         end;
         
         if LProgramas[I].PercentualDesconto > 0 then
            LogCallback('  Desconto: ' + FormatFloat('0.0', LProgramas[I].PercentualDesconto) + '%', 'INFO');
         if LProgramas[I].PontosVenda > 0 then
            LogCallback('  Pontos TOP Venda: ' + IntToStr(LProgramas[I].PontosVenda), 'INFO');
         if LProgramas[I].Laboratorio <> '' then
            LogCallback('  Laboratório: ' + LProgramas[I].Laboratorio, 'INFO');
      end;
   end
   else
      LogCallback('Erro ao carregar programas', 'ERROR');
end;

procedure TDemoObjectPro.ExemploConsultaCliente;
var
   LResponse: TObjectProClienteResponse;
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
      LogCallback('*** HISTÓRICO ***', 'INFO');
      LogCallback('Total compras: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.TotalCompras), 'INFO');
      LogCallback('Total descontos: ' + FormatCurr('R$ #,##0.00', LResponse.Cliente.TotalDescontos), 'INFO');
      LogCallback('Compras no mês: ' + IntToStr(LResponse.Cliente.ComprasNoMes), 'INFO');
      
      if LResponse.Cliente.UltimaCompra > 0 then
         LogCallback('Última compra: ' + FormatDateTime('dd/mm/yyyy', LResponse.Cliente.UltimaCompra), 'INFO');
      
      LogCallback('Aceita contato: ' + IfThen(LResponse.Cliente.AceitaContato, 'SIM', 'NÃO'), 'INFO');
      
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

procedure TDemoObjectPro.ExemploCadastroCliente;
var
   LRequest: TObjectProCadastroClienteRequest;
   LResponse: TObjectProClienteResponse;
begin
   LogCallback('=== Cadastro de Novo Cliente ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '98765432100';
   LRequest.Cliente.Nome := 'MARIA SANTOS';
   LRequest.Cliente.DataNascimento := EncodeDate(1985, 5, 15);
   LRequest.Cliente.Sexo := 'F';
   LRequest.Cliente.Celular := '31999887766';
   LRequest.Cliente.Email := 'maria@email.com';
   LRequest.Cliente.CEP := '30130000';
   LRequest.Cliente.Endereco := 'AV AFONSO PENA';
   LRequest.Cliente.Numero := '1500';
   LRequest.Cliente.Bairro := 'CENTRO';
   LRequest.Cliente.Cidade := 'BELO HORIZONTE';
   LRequest.Cliente.UF := 'MG';
   LRequest.Cliente.AceitaContato := True;  // Importante para relacionamento!
   LRequest.AceitaTermos := True;
   
   LResponse := FClient.CadastrarCliente(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CLIENTE CADASTRADO COM SUCESSO ***', 'INFO');
      LogCallback('Código: ' + LResponse.Cliente.Codigo, 'INFO');
      LogCallback('Nome: ' + LResponse.Cliente.Nome, 'INFO');
      LogCallback('Aceita contato: SIM (pode receber dicas de saúde)', 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoObjectPro.ExemploAutorizacao;
var
   LRequest: TObjectProAutorizacaoRequest;
   LResponse: TObjectProAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Autorização de Venda ===', 'INFO');
   
   LRequest.Clear;
   
   // Cliente
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Cliente.Nome := 'JOSE SILVA';
   
   // Vendedor (importante para TOP Venda!)
   LRequest.Vendedor.CPF := '11122233344';
   LRequest.Vendedor.Nome := 'VENDEDOR JOAO';
   LRequest.Vendedor.Matricula := 'V001';
   LRequest.Vendedor.CodigoTerminal := 'PDV01';
   
   // Produtos
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TObjectProProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TObjectProProduto.Create('7896261013483', 2, 35.00);
   
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := 'OP-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
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
            LogCallback('     Pontos TOP Venda: +' + IntToStr(LResponse.Produtos[I].PontosGerados), 'INFO');
      end;
      
      LogCallback('', 'INFO');
      LogCallback('DESCONTO TOTAL: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('PONTOS VENDEDOR: +' + IntToStr(LResponse.PontosVendedor), 'INFO');
      LogCallback('A PAGAR: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      
      LogCallback('', 'INFO');
      LogCallback('>>> AGUARDANDO CONFIRMAÇÃO após pagamento <<<', 'WARN');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoObjectPro.ExemploVendaCompleta;
var
   LRequest: TObjectProAutorizacaoRequest;
   LResponse: TObjectProConfirmacaoResponse;
begin
   LogCallback('=== Venda Completa (Autoriza + Confirma) ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Vendedor.CPF := '11122233344';
   LRequest.Vendedor.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TObjectProProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'OPC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA CONFIRMADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('*** TOP VENDA ***', 'INFO');
      LogCallback('Pontos creditados: +' + IntToStr(LResponse.PontosCreditados), 'INFO');
      LogCallback('Total pontos: ' + IntToStr(LResponse.TotalPontosVendedor), 'INFO');
      LogCallback('Ranking atual: #' + IntToStr(LResponse.RankingAtual), 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoObjectPro.ExemploCancelamento;
var
   LRequest: TObjectProCancelamentoRequest;
   LResponse: TObjectProCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456';
   LRequest.NumeroVenda := 'OP-20241215120000';
   LRequest.Motivo := 'Desistência do cliente';
   LRequest.Vendedor.CPF := '11122233344';
   LRequest.Vendedor.Nome := 'SUPERVISOR';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CANCELAMENTO CONFIRMADO ***', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
      LogCallback('Pontos estornados: -' + IntToStr(LResponse.PontosEstornados), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoObjectPro.ExemploRankingVendedores;
var
   LResponse: TObjectProRankingResponse;
   I: Integer;
begin
   LogCallback('=== Ranking TOP VENDA - Vendedores ===', 'INFO');
   LogCallback('Sistema de gamificação para motivar a equipe!', 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.ConsultarRankingVendedores;
   
   if LResponse.Sucesso then
   begin
      LogCallback('Período: ' + LResponse.Periodo, 'INFO');
      LogCallback('', 'INFO');
      
      for I := Low(LResponse.Ranking) to High(LResponse.Ranking) do
      begin
         LogCallback(Format('#%d - %s', [
            LResponse.Ranking[I].Posicao,
            LResponse.Ranking[I].Nome
         ]), 'INFO');
         LogCallback(Format('     Loja: %s', [LResponse.Ranking[I].Loja]), 'INFO');
         LogCallback(Format('     Pontos: %d', [LResponse.Ranking[I].Pontos]), 'INFO');
         LogCallback(Format('     Vendas: %s', [FormatCurr('R$ #,##0.00', LResponse.Ranking[I].Vendas)]), 'INFO');
         LogCallback(Format('     Meta: %.1f%%', [LResponse.Ranking[I].PercentualMeta]), 'INFO');
         LogCallback('', 'INFO');
      end;
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoObjectPro.ExemploRankingLojas;
var
   LResponse: TObjectProRankingResponse;
   I: Integer;
begin
   LogCallback('=== Ranking TOP VENDA - Lojas ===', 'INFO');
   LogCallback('Competição entre lojas da rede!', 'INFO');
   LogCallback('', 'INFO');
   
   LResponse := FClient.ConsultarRankingLojas;
   
   if LResponse.Sucesso then
   begin
      LogCallback('Período: ' + LResponse.Periodo, 'INFO');
      LogCallback('', 'INFO');
      
      for I := Low(LResponse.Ranking) to High(LResponse.Ranking) do
      begin
         LogCallback(Format('#%d - %s', [
            LResponse.Ranking[I].Posicao,
            LResponse.Ranking[I].Nome
         ]), 'INFO');
         LogCallback(Format('     Pontos: %d', [LResponse.Ranking[I].Pontos]), 'INFO');
         LogCallback(Format('     Vendas: %s', [FormatCurr('R$ #,##0.00', LResponse.Ranking[I].Vendas)]), 'INFO');
         LogCallback(Format('     Meta: %.1f%%', [LResponse.Ranking[I].PercentualMeta]), 'INFO');
         LogCallback('', 'INFO');
      end;
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoObjectPro.ExemploMetaVendedor;
var
   LVendedor: TObjectProVendedor;
begin
   LogCallback('=== Consulta Meta do Vendedor ===', 'INFO');
   LogCallback('Acompanhe o atingimento de metas!', 'INFO');
   LogCallback('', 'INFO');
   
   LVendedor := FClient.ConsultarMetaVendedor('11122233344');
   
   if LVendedor.CPF <> '' then
   begin
      LogCallback('Vendedor: ' + LVendedor.Nome, 'INFO');
      LogCallback('Matrícula: ' + LVendedor.Matricula, 'INFO');
      LogCallback('', 'INFO');
      LogCallback('*** DESEMPENHO DO MÊS ***', 'INFO');
      LogCallback('Meta: ' + FormatCurr('R$ #,##0.00', LVendedor.MetaMes), 'INFO');
      LogCallback('Vendas: ' + FormatCurr('R$ #,##0.00', LVendedor.VendasMes), 'INFO');
      LogCallback('Atingimento: ' + FormatFloat('0.1', LVendedor.PercentualMeta) + '%', 'INFO');
      LogCallback('', 'INFO');
      LogCallback('*** TOP VENDA ***', 'INFO');
      LogCallback('Pontos no mês: ' + IntToStr(LVendedor.PontosMes), 'INFO');
      LogCallback('Total pontos: ' + IntToStr(LVendedor.PontosAcumulados), 'INFO');
      LogCallback('Ranking: #' + IntToStr(LVendedor.RankingMes), 'INFO');
      
      // Feedback motivacional
      LogCallback('', 'INFO');
      if LVendedor.PercentualMeta >= 100 then
         LogCallback('*** PARABÉNS! META BATIDA! ***', 'INFO')
      else if LVendedor.PercentualMeta >= 80 then
         LogCallback('>>> Quase lá! Falta pouco para a meta! <<<', 'INFO')
      else if LVendedor.PercentualMeta >= 50 then
         LogCallback('>>> Bom progresso! Continue assim! <<<', 'INFO')
      else
         LogCallback('>>> Vamos acelerar as vendas! <<<', 'WARN');
   end
   else
      LogCallback('Vendedor não encontrado', 'ERROR');
end;

procedure TDemoObjectPro.ExemploFluxoCompleto;
var
   LClienteResp: TObjectProClienteResponse;
   LCadastroReq: TObjectProCadastroClienteRequest;
   LVendaReq: TObjectProAutorizacaoRequest;
   LVendaResp: TObjectProConfirmacaoResponse;
   LVendedor: TObjectProVendedor;
   LCPF: string;
begin
   LogCallback('=== Fluxo Completo OBJECT PRO ===', 'INFO');
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
      LCadastroReq.Cliente.Celular := '31999998888';
      LCadastroReq.Cliente.UF := 'MG';
      LCadastroReq.Cliente.AceitaContato := True;
      LCadastroReq.AceitaTermos := True;
      
      LClienteResp := FClient.CadastrarCliente(LCadastroReq);
      
      if not LClienteResp.Sucesso then
      begin
         LogCallback('Erro ao cadastrar: ' + LClienteResp.MensagemRetorno, 'ERROR');
         Exit;
      end;
   end;
   
   LogCallback('Cliente: ' + LClienteResp.Cliente.Nome, 'INFO');
   LogCallback('Total compras: ' + FormatCurr('R$ #,##0.00', LClienteResp.Cliente.TotalCompras), 'INFO');
   LogCallback('Total descontos: ' + FormatCurr('R$ #,##0.00', LClienteResp.Cliente.TotalDescontos), 'INFO');
   
   // 3. Verificar meta do vendedor antes da venda
   LogCallback('', 'INFO');
   LogCallback('3. Consultando meta do vendedor...', 'INFO');
   LVendedor := FClient.ConsultarMetaVendedor('11122233344');
   if LVendedor.CPF <> '' then
   begin
      LogCallback('Vendedor: ' + LVendedor.Nome, 'INFO');
      LogCallback('Meta: ' + FormatFloat('0.1', LVendedor.PercentualMeta) + '%', 'INFO');
      LogCallback('Ranking: #' + IntToStr(LVendedor.RankingMes), 'INFO');
   end;
   
   // 4. Processar venda
   LogCallback('', 'INFO');
   LogCallback('4. Processando venda...', 'INFO');
   
   LVendaReq.Clear;
   LVendaReq.Cliente.CPF := LCPF;
   LVendaReq.Cliente.Nome := LClienteResp.Cliente.Nome;
   LVendaReq.Vendedor.CPF := '11122233344';
   LVendaReq.Vendedor.Nome := 'CAIXA PDV01';
   LVendaReq.Vendedor.Matricula := 'V001';
   LVendaReq.Vendedor.CodigoTerminal := 'PDV01';
   
   SetLength(LVendaReq.Produtos, 2);
   LVendaReq.Produtos[0] := TObjectProProduto.Create('7896181911999', 1, 85.90);
   LVendaReq.Produtos[1] := TObjectProProduto.Create('7896261013483', 2, 35.00);
   
   LVendaReq.ValorTotal := 155.90;
   LVendaReq.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LVendaReq.NumeroCupom := '000123';
   LVendaReq.DataHoraVenda := Now;
   
   LVendaResp := FClient.VendaCompleta(LVendaReq);
   
   if not LVendaResp.Sucesso then
   begin
      LogCallback('VENDA NEGADA: ' + LVendaResp.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   // 5. Sucesso
   LogCallback('', 'INFO');
   LogCallback('*** VENDA CONCLUÍDA ***', 'INFO');
   LogCallback('NSU: ' + LVendaResp.NSU, 'INFO');
   LogCallback('Autorização: ' + LVendaResp.NumeroAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   LogCallback('*** TOP VENDA - VENDEDOR ***', 'INFO');
   LogCallback('Pontos creditados: +' + IntToStr(LVendaResp.PontosCreditados), 'INFO');
   LogCallback('Total pontos: ' + IntToStr(LVendaResp.TotalPontosVendedor), 'INFO');
   LogCallback('Novo ranking: #' + IntToStr(LVendaResp.RankingAtual), 'INFO');
   
   // 6. Gravar no banco
   LogCallback('', 'INFO');
   LogCallback('5. Gravando no banco...', 'INFO');
   LogCallback('   venda_id: ' + LVendaReq.NumeroVenda, 'INFO');
   LogCallback('   op_nsu: ' + LVendaResp.NSU, 'INFO');
   LogCallback('   op_autorizacao: ' + LVendaResp.NumeroAutorizacao, 'INFO');
   LogCallback('   op_pontos_vendedor: ' + IntToStr(LVendaResp.PontosCreditados), 'INFO');
   LogCallback('   vendedor_cpf: ' + LVendaReq.Vendedor.CPF, 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
