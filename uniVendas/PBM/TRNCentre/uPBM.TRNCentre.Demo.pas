unit uPBM.TRNCentre.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração TRN Centre / Portal da Drogaria
  
  Este arquivo demonstra como usar o módulo de integração TRN Centre.
  
  Características do TRN Centre:
  
  1. REST API com autenticação OAuth (Client ID + Password)
  2. Maior plataforma de PBMs do Brasil
  3. Presente em 33 mil farmácias / 3.800 municípios
  4. Grupo InterPlayers (SevenPDV)
  5. Mais de 1.500 produtos com desconto
  6. Cobre ~80% dos programas da indústria farmacêutica
  7. Suporte a LoadTables (carga diária de produtos)
  8. Validação de NSU do Portal Web
  
  Programas/Laboratórios vinculados:
  - Abbott, AstraZeneca, Bayer, Boehringer
  - Eli Lilly, GSK, Janssen, Merck
  - Novartis, Pfizer, Roche, Sanofi
  - E muitos outros...
  
  Estrutura do módulo:
  - uPBM.TRNCentre.Types.pas : Tipos, records, constantes, caches
  - uPBM.TRNCentre.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.TRNCentre.Types, uPBM.TRNCentre;

type
   TDemoTRNCentre = class
   private
      FClient: TTRNCentreClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, AClientID, APassword, ACodigoTerminal,
         ARazaoSocial, AUF: string; AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploCarregarProgramas;
      procedure ExemploCarregarProdutos;
      procedure ExemploConsultaElegibilidade;
      procedure ExemploConsultaElegibilidadeCartao;
      procedure ExemploConsultaProduto;
      procedure ExemploPreAutorizacao;
      procedure ExemploVendaCompleta;
      procedure ExemploVendaComReceita;
      procedure ExemploValidarNSUPortal;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoTRNCentre }

constructor TDemoTRNCentre.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateTRNCentreClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoTRNCentre.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoTRNCentre.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoTRNCentre.Configurar(const ACNPJ, AClientID, APassword,
   ACodigoTerminal, ARazaoSocial, AUF: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, AClientID, APassword,
      ACodigoTerminal, ARazaoSocial, AUF);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('Configuração concluída', 'INFO');
   
   // Testa conexão
   if FClient.TestarConexao then
      LogCallback('Conexão com TRN Centre OK', 'INFO')
   else
      LogCallback('Falha na conexão: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploCarregarProgramas;
var
   LProgramas: TTRNCentreProgramas;
   I: Integer;
begin
   LogCallback('=== Carregar Programas Disponíveis ===', 'INFO');
   
   if FClient.CarregarProgramas then
   begin
      LProgramas := FClient.Programas.GetAll;
      
      LogCallback('Total de programas: ' + IntToStr(Length(LProgramas)), 'INFO');
      LogCallback('', 'INFO');
      
      for I := Low(LProgramas) to High(LProgramas) do
      begin
         LogCallback(Format('%s - %s', [LProgramas[I].Codigo, LProgramas[I].Nome]), 'INFO');
         LogCallback(Format('  Operadora: %s (%s)', [
            LProgramas[I].Operadora.Nome,
            LProgramas[I].Operadora.Laboratorio
         ]), 'INFO');
         
         if LProgramas[I].RequerCadastro then
            LogCallback('  * Requer cadastro prévio do paciente', 'WARN');
         if LProgramas[I].RequerReceita then
            LogCallback('  * Requer receita médica', 'WARN');
      end;
   end
   else
      LogCallback('Erro ao carregar programas: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploCarregarProdutos;
begin
   LogCallback('=== Carregar Produtos (LoadTables) ===', 'INFO');
   LogCallback('Esta carga normalmente é feita 1x por dia (entre 5h-7h)', 'INFO');
   LogCallback('', 'INFO');
   
   if FClient.CarregarProdutos then
   begin
      LogCallback('Produtos carregados: ' + IntToStr(FClient.ProdutosCache.Count), 'INFO');
      LogCallback('', 'INFO');
      
      // Exemplo: verificar se produto tem desconto
      if FClient.ProdutoTemDesconto('7896181911999') then
         LogCallback('EAN 7896181911999 TEM desconto no Portal', 'INFO')
      else
         LogCallback('EAN 7896181911999 NÃO tem desconto', 'WARN');
   end
   else
      LogCallback('Erro ao carregar produtos: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploConsultaElegibilidade;
var
   LResponse: TTRNCentreElegibilidadeResponse;
   I: Integer;
begin
   LogCallback('=== Consulta de Elegibilidade por CPF ===', 'INFO');
   
   // Consulta por CPF
   LResponse := FClient.ConsultarElegibilidade('12345678901');
   
   if LResponse.Sucesso then
   begin
      LogCallback('Beneficiário encontrado!', 'INFO');
      LogCallback('Nome: ' + LResponse.Beneficiario.Nome, 'INFO');
      LogCallback('CPF: ' + LResponse.Beneficiario.CPF, 'INFO');
      LogCallback('Código: ' + LResponse.Beneficiario.CodigoCadastro, 'INFO');
      LogCallback('Elegível: ' + BoolToStr(LResponse.Elegivel, True), 'INFO');
      LogCallback('', 'INFO');
      
      if Length(LResponse.ProgramasDisponiveis) > 0 then
      begin
         LogCallback('Programas disponíveis:', 'INFO');
         for I := Low(LResponse.ProgramasDisponiveis) to High(LResponse.ProgramasDisponiveis) do
         begin
            LogCallback(Format('  %s - %s (%s)', [
               LResponse.ProgramasDisponiveis[I].Codigo,
               LResponse.ProgramasDisponiveis[I].Nome,
               LResponse.ProgramasDisponiveis[I].Operadora.Nome
            ]), 'INFO');
         end;
      end
      else
         LogCallback('Elegível para todos os programas abertos', 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploConsultaElegibilidadeCartao;
var
   LResponse: TTRNCentreElegibilidadeResponse;
begin
   LogCallback('=== Consulta de Elegibilidade por Cartão/Cupom ===', 'INFO');
   
   // Consulta por Cartão de Desconto
   LResponse := FClient.ConsultarElegibilidade('', 'CUPOM123456');
   
   if LResponse.Sucesso then
   begin
      LogCallback('Cartão válido!', 'INFO');
      LogCallback('Beneficiário: ' + LResponse.Beneficiario.Nome, 'INFO');
      LogCallback('Programas vinculados: ' + IntToStr(Length(LResponse.ProgramasDisponiveis)), 'INFO');
   end
   else
      LogCallback('Cartão inválido: ' + LResponse.MensagemRetorno, 'WARN');
end;

procedure TDemoTRNCentre.ExemploConsultaProduto;
var
   LProdutos: TTRNCentreProdutos;
   LEan: string;
   I: Integer;
begin
   LogCallback('=== Consulta de Produto ===', 'INFO');
   
   LEan := '7896181911999';
   
   // Consulta descontos disponíveis para o produto
   LProdutos := FClient.ConsultarProduto(LEan);
   
   if Length(LProdutos) > 0 then
   begin
      LogCallback('Produto ' + LEan + ' encontrado em ' + IntToStr(Length(LProdutos)) + ' programa(s):', 'INFO');
      
      for I := Low(LProdutos) to High(LProdutos) do
      begin
         LogCallback(Format('  %s - %s', [
            LProdutos[I].NomePrograma,
            LProdutos[I].NomeOperadora
         ]), 'INFO');
         LogCallback(Format('    Desconto: %.0f%% | Qtd: %d-%d', [
            LProdutos[I].PercentualDesconto,
            LProdutos[I].QuantidadeMinima,
            LProdutos[I].QuantidadeMaxima
         ]), 'INFO');
         
         if LProdutos[I].RequerReceita then
            LogCallback('    * Requer receita médica', 'WARN');
      end;
   end
   else
      LogCallback('Produto ' + LEan + ' NÃO está em nenhum programa', 'WARN');
   
   // Consulta com CPF específico
   LogCallback('', 'INFO');
   LogCallback('Verificando para paciente específico...', 'INFO');
   LProdutos := FClient.ConsultarProduto(LEan, '12345678901');
   
   if Length(LProdutos) > 0 then
      LogCallback('Paciente elegível para ' + IntToStr(Length(LProdutos)) + ' programa(s) deste produto', 'INFO')
   else
      LogCallback('Paciente não elegível para programas deste produto', 'WARN');
end;

procedure TDemoTRNCentre.ExemploPreAutorizacao;
var
   LRequest: TTRNCentrePreAutorizacaoRequest;
   LResponse: TTRNCentrePreAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Pré-Autorização (Cotação) ===', 'INFO');
   LogCallback('Simula a venda e retorna descontos sem efetivar', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.CPF := '12345678901';
   LRequest.Beneficiario.Nome := 'JOSE DA SILVA';
   
   // Operador
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'ATENDENTE MARIA';
   LRequest.Operador.Matricula := '001';
   
   // Produtos
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TTRNCentreProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TTRNCentreProduto.Create('7896261013483', 2, 35.00);
   
   // Dados da venda
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := 'TRN-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.InformarReceita := False;
   
   LResponse := FClient.PreAutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** PRÉ-AUTORIZAÇÃO OK ***', 'INFO');
      LogCallback('Número: ' + LResponse.NumeroPreAutorizacao, 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Válida por: ' + IntToStr(LResponse.ValidadeMinutos) + ' minutos', 'INFO');
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
            
         LogCallback(Format('     Valor: R$ %.2f → Desconto: %.0f%% → Final: R$ %.2f', [
            LResponse.Produtos[I].ValorTotal,
            LResponse.Produtos[I].PercentualDesconto,
            LResponse.Produtos[I].ValorFinal
         ]), 'INFO');
         
         if LResponse.Produtos[I].NomePrograma <> '' then
            LogCallback('     Programa: ' + LResponse.Produtos[I].NomePrograma +
               ' (' + LResponse.Produtos[I].NomeOperadora + ')', 'INFO');
      end;
      
      LogCallback('', 'INFO');
      LogCallback('TOTAL DESCONTO: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('TOTAL A PAGAR:  ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      LogCallback('', 'INFO');
      LogCallback('*** Use AutorizarVenda() para confirmar ***', 'WARN');
   end
   else
      LogCallback('PRÉ-AUTORIZAÇÃO NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploVendaCompleta;
var
   LRequest: TTRNCentrePreAutorizacaoRequest;
   LResponse: TTRNCentreAutorizacaoResponse;
begin
   LogCallback('=== Venda Completa (PreAuth + Auth) ===', 'INFO');
   LogCallback('Executa os dois passos automaticamente', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.CPF := '12345678901';
   LRequest.Beneficiario.Nome := 'JOSE DA SILVA';
   
   // Operador
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   // Produtos
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TTRNCentreProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'TRNC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // Executa pré-autorização + autorização
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA AUTORIZADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('Desconto: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('Total pago: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
   end
   else
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploVendaComReceita;
var
   LRequest: TTRNCentrePreAutorizacaoRequest;
   LResponse: TTRNCentreAutorizacaoResponse;
begin
   LogCallback('=== Venda com Receita Médica ===', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.CPF := '44455566677';
   LRequest.Beneficiario.Nome := 'PEDRO OLIVEIRA';
   
   // Operador
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'FARMACEUTICO JOAO';
   
   // Produto que requer receita
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TTRNCentreProduto.Create('7891000000002', 1, 180.00);
   LRequest.Produtos[0].RequerReceita := True;
   
   // Receita médica
   LRequest.InformarReceita := True;
   LRequest.Receita.CRM := '54321';
   LRequest.Receita.UFMedico := 'SP';
   LRequest.Receita.NomeMedico := 'DRA. ANA COSTA';
   LRequest.Receita.DataReceita := Date - 10;
   LRequest.Receita.NumeroReceita := 'REC2024001';
   
   LRequest.ValorTotal := 180.00;
   LRequest.NumeroVenda := 'TRNR-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA COM RECEITA AUTORIZADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
   end
   else
   begin
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'WARN');
      
      if LResponse.CodigoRetorno = TTRNCentreCodigosRetorno.RECEITA_OBRIGATORIA then
         LogCallback('Motivo: Receita médica obrigatória', 'WARN');
   end;
end;

procedure TDemoTRNCentre.ExemploValidarNSUPortal;
var
   LRequest: TTRNCentrePreAutorizacaoRequest;
   LResponse: TTRNCentreAutorizacaoResponse;
begin
   LogCallback('=== Validar NSU do Portal da Drogaria ===', 'INFO');
   LogCallback('Quando a autorização foi feita no Portal Web', 'INFO');
   LogCallback('e precisa ser validada no sistema PDV', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário (mesmo que foi informado no Portal)
   LRequest.Beneficiario.CPF := '12345678901';
   
   // Operador
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   // Produtos (devem ser os mesmos e quantidades do Portal)
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TTRNCentreProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'TRNP-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // NSU que foi gerada no Portal da Drogaria
   LResponse := FClient.ValidarNSUPortal('NSU123456789', LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** NSU DO PORTAL VALIDADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Desconto: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
   end
   else
      LogCallback('VALIDAÇÃO NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploCancelamento;
var
   LRequest: TTRNCentreCancelamentoRequest;
   LResponse: TTRNCentreCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456789';
   LRequest.NumeroVenda := 'TRN-20241215120000';
   LRequest.Motivo := 'Desistência do cliente';
   
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'ATENDENTE MARIA';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('Cancelamento confirmado', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoTRNCentre.ExemploFluxoCompleto;
var
   LElegibilidade: TTRNCentreElegibilidadeResponse;
   LPreAuth: TTRNCentrePreAutorizacaoResponse;
   LAuthRequest: TTRNCentreAutorizacaoRequest;
   LAuthResponse: TTRNCentreAutorizacaoResponse;
   LRequest: TTRNCentrePreAutorizacaoRequest;
   I: Integer;
begin
   LogCallback('=== Fluxo Completo de Venda TRN Centre ===', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Conexão e carga de produtos
   LogCallback('1. Verificando conexão...', 'INFO');
   if not FClient.TestarConexao then
   begin
      LogCallback('Sem conexão com TRN Centre', 'ERROR');
      Exit;
   end;
   LogCallback('Conexão OK', 'INFO');
   
   // 2. Verificar produto no cache (LoadTables)
   LogCallback('', 'INFO');
   LogCallback('2. Verificando produto no cache...', 'INFO');
   if FClient.ProdutosCache.NeedRefresh then
   begin
      LogCallback('Cache desatualizado, carregando produtos...', 'WARN');
      FClient.CarregarProdutos;
   end;
   
   if FClient.ProdutoTemDesconto('7896181911999') then
      LogCallback('Produto encontrado no cache de descontos', 'INFO')
   else
      LogCallback('Produto não está no cache (pode não ter desconto)', 'WARN');
   
   // 3. Elegibilidade
   LogCallback('', 'INFO');
   LogCallback('3. Consultando elegibilidade do beneficiário...', 'INFO');
   LElegibilidade := FClient.ConsultarElegibilidade('12345678901');
   
   if not LElegibilidade.Sucesso then
   begin
      LogCallback('Beneficiário não encontrado: ' + LElegibilidade.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   if not LElegibilidade.Elegivel then
   begin
      LogCallback('Beneficiário não elegível para nenhum programa', 'WARN');
      Exit;
   end;
   
   LogCallback('Beneficiário: ' + LElegibilidade.Beneficiario.Nome, 'INFO');
   LogCallback('Programas: ' + IntToStr(Length(LElegibilidade.ProgramasDisponiveis)), 'INFO');
   
   // 4. Pré-Autorização
   LogCallback('', 'INFO');
   LogCallback('4. Pré-autorizando venda...', 'INFO');
   
   LRequest.Clear;
   LRequest.Beneficiario := LElegibilidade.Beneficiario;
   
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA PDV01';
   LRequest.Operador.Matricula := '001';
   
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TTRNCentreProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TTRNCentreProduto.Create('7896261013483', 2, 35.00);
   
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LRequest.DataHoraVenda := Now;
   
   LPreAuth := FClient.PreAutorizarVenda(LRequest);
   
   if not LPreAuth.Sucesso then
   begin
      LogCallback('Pré-autorização negada: ' + LPreAuth.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   LogCallback('Pré-autorização: ' + LPreAuth.NumeroPreAutorizacao, 'INFO');
   LogCallback('NSU: ' + LPreAuth.NSU, 'INFO');
   LogCallback('', 'INFO');
   
   // Mostra detalhamento
   for I := Low(LPreAuth.Produtos) to High(LPreAuth.Produtos) do
   begin
      if LPreAuth.Produtos[I].Autorizado then
         LogCallback(Format('  [OK] %s: R$ %.2f → %.0f%% → R$ %.2f', [
            LPreAuth.Produtos[I].CodigoBarras,
            LPreAuth.Produtos[I].ValorTotal,
            LPreAuth.Produtos[I].PercentualDesconto,
            LPreAuth.Produtos[I].ValorFinal
         ]), 'INFO')
      else
         LogCallback(Format('  [X] %s: %s', [
            LPreAuth.Produtos[I].CodigoBarras,
            LPreAuth.Produtos[I].MensagemRejeicao
         ]), 'WARN');
         
      if LPreAuth.Produtos[I].NomePrograma <> '' then
         LogCallback('      ' + LPreAuth.Produtos[I].NomePrograma, 'INFO');
   end;
   
   LogCallback('', 'INFO');
   LogCallback('DESCONTO TOTAL: ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalDesconto), 'INFO');
   LogCallback('VALOR A PAGAR:  ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalFinal), 'INFO');
   
   // 5. Confirmação
   LogCallback('', 'INFO');
   LogCallback('5. Confirmando venda...', 'INFO');
   
   LAuthRequest.Clear;
   LAuthRequest.NumeroPreAutorizacao := LPreAuth.NumeroPreAutorizacao;
   LAuthRequest.NSU := LPreAuth.NSU;
   LAuthRequest.NumeroVenda := LRequest.NumeroVenda;
   LAuthRequest.Operador := LRequest.Operador;
   
   LAuthResponse := FClient.AutorizarVenda(LAuthRequest);
   
   if not LAuthResponse.Sucesso then
   begin
      LogCallback('AUTORIZAÇÃO NEGADA: ' + LAuthResponse.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   // 6. Sucesso!
   LogCallback('', 'INFO');
   LogCallback('*** VENDA CONCLUÍDA COM SUCESSO ***', 'INFO');
   LogCallback('NSU: ' + LAuthResponse.NSU, 'INFO');
   LogCallback('Autorização: ' + LAuthResponse.NumeroAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   
   // 7. Gravar no banco
   LogCallback('6. Gravando no banco de dados...', 'INFO');
   LogCallback('   venda_id: ' + LRequest.NumeroVenda, 'INFO');
   LogCallback('   trncentre_nsu: ' + LAuthResponse.NSU, 'INFO');
   LogCallback('   trncentre_autorizacao: ' + LAuthResponse.NumeroAutorizacao, 'INFO');
   LogCallback('   trncentre_desconto: ' + FormatFloat('0.00', LAuthResponse.ValorTotalDesconto), 'INFO');
   LogCallback('   trncentre_valor_final: ' + FormatFloat('0.00', LAuthResponse.ValorTotalFinal), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('REPOSIÇÃO:', 'WARN');
   LogCallback('- TRN Centre/Portal da Drogaria utiliza reposição via distribuidoras', 'INFO');
   LogCallback('- Selecione os distribuidores conveniados no Portal', 'INFO');
   LogCallback('- Acompanhe pelo Portal: www.portaldadrogaria.com.br', 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
