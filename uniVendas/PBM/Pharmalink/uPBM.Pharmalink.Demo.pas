unit uPBM.Pharmalink.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Pharmalink PBM (Grupo InterPlayers)
  
  Este arquivo demonstra como usar o módulo de integração Pharmalink.
  
  Características do Pharmalink:
  
  1. SOAP/XML via WSDL (comunicação direta)
  2. Presente em 90% das cidades brasileiras
  3. Mais de 60 mil farmácias credenciadas
  4. Foco em programas da indústria farmacêutica
  5. Autenticação via NumeroAutenticacao + CodigoTerminal
  6. Fluxo em 2 etapas: PreAutorizar → Autorizar
  7. Suporte a múltiplos programas por produto
  8. Reposição de produtos via distribuidoras
  
  Grupo InterPlayers também opera:
  - Transaction Centre / Portal da Drogaria (SevenPDV)
  - Entire, Ponto Extra, ECS, OLOGY
  
  Estrutura do módulo:
  - uPBM.Pharmalink.Types.pas : Tipos, records, constantes
  - uPBM.Pharmalink.pas       : Cliente SOAP, XMLBuilder, XMLParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.Pharmalink.Types, uPBM.Pharmalink;

type
   TDemoPharmalink = class
   private
      FClient: TPharmalinkClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ANumeroAutenticacao, ACodigoTerminal,
         ARazaoSocial, AUF: string; AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploListarProgramas;
      procedure ExemploConsultaElegibilidade;
      procedure ExemploConsultaProduto;
      procedure ExemploPreAutorizacao;
      procedure ExemploVendaCompleta;
      procedure ExemploVendaComReceita;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoPharmalink }

constructor TDemoPharmalink.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreatePharmalinkClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoPharmalink.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoPharmalink.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoPharmalink.Configurar(const ACNPJ, ANumeroAutenticacao,
   ACodigoTerminal, ARazaoSocial, AUF: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ANumeroAutenticacao, 
      ACodigoTerminal, ARazaoSocial, AUF);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('Configuração concluída', 'INFO');
   
   // Testa conexão e carrega programas
   if FClient.TestarConexao then
   begin
      LogCallback('Conexão com Pharmalink OK', 'INFO');
      LogCallback('Programas disponíveis: ' + IntToStr(FClient.Programas.Count), 'INFO');
   end
   else
      LogCallback('Falha na conexão: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoPharmalink.ExemploListarProgramas;
var
   LProgramas: TPharmalinkProgramas;
   I: Integer;
begin
   LogCallback('=== Listar Programas Disponíveis ===', 'INFO');
   
   if FClient.CarregarProgramas then
   begin
      LProgramas := FClient.Programas.GetAll;
      
      LogCallback('Total de programas: ' + IntToStr(Length(LProgramas)), 'INFO');
      LogCallback('', 'INFO');
      
      for I := Low(LProgramas) to High(LProgramas) do
      begin
         LogCallback(Format('%s - %s', [LProgramas[I].Codigo, LProgramas[I].Nome]), 'INFO');
         LogCallback(Format('  Laboratório: %s | Desconto: %.0f%%', [
            LProgramas[I].Laboratorio,
            LProgramas[I].PercentualDesconto
         ]), 'INFO');
         if LProgramas[I].DataFim > 0 then
            LogCallback(Format('  Validade: até %s', [
               FormatDateTime('dd/mm/yyyy', LProgramas[I].DataFim)
            ]), 'INFO');
      end;
   end
   else
      LogCallback('Erro ao carregar programas', 'ERROR');
end;

procedure TDemoPharmalink.ExemploConsultaElegibilidade;
var
   LResponse: TPharmalinkElegibilidadeResponse;
   I: Integer;
begin
   LogCallback('=== Consulta de Elegibilidade ===', 'INFO');
   
   // Consulta por CPF
   LResponse := FClient.ConsultarElegibilidade('12345678901');
   
   if LResponse.Sucesso then
   begin
      LogCallback('Paciente encontrado!', 'INFO');
      LogCallback('Nome: ' + LResponse.Paciente.Nome, 'INFO');
      LogCallback('CPF: ' + LResponse.Paciente.CPF, 'INFO');
      LogCallback('Código cadastro: ' + LResponse.Paciente.CodigoCadastro, 'INFO');
      LogCallback('Elegível: ' + BoolToStr(LResponse.Elegivel, True), 'INFO');
      LogCallback('', 'INFO');
      
      if Length(LResponse.ProgramasDisponiveis) > 0 then
      begin
         LogCallback('Programas disponíveis para este paciente:', 'INFO');
         for I := Low(LResponse.ProgramasDisponiveis) to High(LResponse.ProgramasDisponiveis) do
         begin
            LogCallback(Format('  %s - %s (Desconto: %.0f%%)', [
               LResponse.ProgramasDisponiveis[I].Codigo,
               LResponse.ProgramasDisponiveis[I].Nome,
               LResponse.ProgramasDisponiveis[I].PercentualDesconto
            ]), 'INFO');
         end;
      end
      else
         LogCallback('Nenhum programa específico vinculado', 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoPharmalink.ExemploConsultaProduto;
var
   LProgramas: TPharmalinkProgramas;
   LEan: string;
   I: Integer;
begin
   LogCallback('=== Consulta de Produto ===', 'INFO');
   
   LEan := '7896181911999'; // Alenia
   
   // Consulta sem CPF (verifica se produto está em algum programa)
   LProgramas := FClient.ConsultarProduto(LEan);
   
   if Length(LProgramas) > 0 then
   begin
      LogCallback('Produto ' + LEan + ' encontrado em ' + IntToStr(Length(LProgramas)) + ' programa(s):', 'INFO');
      
      for I := Low(LProgramas) to High(LProgramas) do
      begin
         LogCallback(Format('  %s - %s', [LProgramas[I].Codigo, LProgramas[I].Nome]), 'INFO');
         LogCallback(Format('    Laboratório: %s | Desconto: %.0f%%', [
            LProgramas[I].Laboratorio,
            LProgramas[I].PercentualDesconto
         ]), 'INFO');
      end;
   end
   else
      LogCallback('Produto ' + LEan + ' NÃO está em nenhum programa', 'WARN');
   
   // Consulta COM CPF (verifica elegibilidade específica)
   LogCallback('', 'INFO');
   LogCallback('Verificando para paciente específico...', 'INFO');
   LProgramas := FClient.ConsultarProduto(LEan, '12345678901');
   
   if Length(LProgramas) > 0 then
      LogCallback('Paciente elegível para ' + IntToStr(Length(LProgramas)) + ' programa(s) deste produto', 'INFO')
   else
      LogCallback('Paciente não elegível para programas deste produto', 'WARN');
end;

procedure TDemoPharmalink.ExemploPreAutorizacao;
var
   LRequest: TPharmalinkPreAutorizacaoRequest;
   LResponse: TPharmalinkPreAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Pré-Autorização (Cotação) ===', 'INFO');
   LogCallback('Simula a venda e retorna descontos sem efetivar', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   
   // Paciente
   LRequest.Paciente.CPF := '12345678901';
   LRequest.Paciente.Nome := 'JOSE DA SILVA';
   
   // Operador
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'ATENDENTE MARIA';
   
   // Produtos
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TPharmalinkProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TPharmalinkProduto.Create('7896261013483', 2, 35.00);
   
   // Dados da venda
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := 'PHL-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.InformarReceita := False;
   
   LResponse := FClient.PreAutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** PRÉ-AUTORIZAÇÃO OK ***', 'INFO');
      LogCallback('Número: ' + LResponse.NumeroPreAutorizacao, 'INFO');
      LogCallback('Código Transação: ' + LResponse.CodigoTransacao, 'INFO');
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
            LogCallback('     Programa: ' + LResponse.Produtos[I].NomePrograma, 'INFO');
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

procedure TDemoPharmalink.ExemploVendaCompleta;
var
   LRequest: TPharmalinkPreAutorizacaoRequest;
   LResponse: TPharmalinkAutorizacaoResponse;
begin
   LogCallback('=== Venda Completa (PreAuth + Auth) ===', 'INFO');
   LogCallback('Executa os dois passos automaticamente', 'INFO');
   LogCallback('', 'INFO');
   
   LRequest.Clear;
   
   // Paciente
   LRequest.Paciente.CPF := '12345678901';
   LRequest.Paciente.Nome := 'JOSE DA SILVA';
   
   // Operador
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   // Produtos
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TPharmalinkProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'PHLC-' + FormatDateTime('yyyymmddhhnnss', Now);
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

procedure TDemoPharmalink.ExemploVendaComReceita;
var
   LRequest: TPharmalinkPreAutorizacaoRequest;
   LResponse: TPharmalinkAutorizacaoResponse;
begin
   LogCallback('=== Venda com Receita Médica ===', 'INFO');
   
   LRequest.Clear;
   
   // Paciente
   LRequest.Paciente.CPF := '44455566677';
   LRequest.Paciente.Nome := 'PEDRO OLIVEIRA';
   
   // Operador
   LRequest.Operador.CPF := '98765432100';
   LRequest.Operador.Nome := 'FARMACEUTICO JOAO';
   
   // Produto controlado
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TPharmalinkProduto.Create('7891000000002', 1, 180.00);
   LRequest.Produtos[0].RequerReceita := True;
   
   // Receita médica
   LRequest.InformarReceita := True;
   LRequest.Receita.CRM := '54321';
   LRequest.Receita.UFMedico := 'SP';
   LRequest.Receita.NomeMedico := 'DRA. ANA COSTA';
   LRequest.Receita.DataReceita := Date - 10;
   LRequest.Receita.TipoReceita := 'BRANCA';
   
   LRequest.ValorTotal := 180.00;
   LRequest.NumeroVenda := 'PHLR-' + FormatDateTime('yyyymmddhhnnss', Now);
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
      
      if LResponse.CodigoRetorno = TPharmalinkCodigosRetorno.RECEITA_OBRIGATORIA then
         LogCallback('Motivo: Receita médica obrigatória', 'WARN')
      else if LResponse.CodigoRetorno = TPharmalinkCodigosRetorno.CRM_INVALIDO then
         LogCallback('Motivo: CRM inválido', 'WARN');
   end;
end;

procedure TDemoPharmalink.ExemploCancelamento;
var
   LRequest: TPharmalinkCancelamentoRequest;
   LResponse: TPharmalinkCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456789';
   LRequest.NumeroVenda := 'PHL-20241215120000';
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

procedure TDemoPharmalink.ExemploFluxoCompleto;
var
   LElegibilidade: TPharmalinkElegibilidadeResponse;
   LPreAuth: TPharmalinkPreAutorizacaoResponse;
   LAuthRequest: TPharmalinkAutorizacaoRequest;
   LAuthResponse: TPharmalinkAutorizacaoResponse;
   LRequest: TPharmalinkPreAutorizacaoRequest;
   I: Integer;
begin
   LogCallback('=== Fluxo Completo de Venda Pharmalink ===', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Conexão
   LogCallback('1. Verificando conexão...', 'INFO');
   if not FClient.TestarConexao then
   begin
      LogCallback('Sem conexão com Pharmalink', 'ERROR');
      Exit;
   end;
   LogCallback('Conexão OK - ' + IntToStr(FClient.Programas.Count) + ' programas disponíveis', 'INFO');
   
   // 2. Elegibilidade
   LogCallback('', 'INFO');
   LogCallback('2. Consultando elegibilidade do paciente...', 'INFO');
   LElegibilidade := FClient.ConsultarElegibilidade('12345678901');
   
   if not LElegibilidade.Sucesso then
   begin
      LogCallback('Paciente não encontrado: ' + LElegibilidade.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   if not LElegibilidade.Elegivel then
   begin
      LogCallback('Paciente não elegível para nenhum programa', 'WARN');
      Exit;
   end;
   
   LogCallback('Paciente: ' + LElegibilidade.Paciente.Nome, 'INFO');
   LogCallback('Programas: ' + IntToStr(Length(LElegibilidade.ProgramasDisponiveis)), 'INFO');
   
   // 3. Pré-Autorização
   LogCallback('', 'INFO');
   LogCallback('3. Pré-autorizando venda...', 'INFO');
   
   LRequest.Clear;
   LRequest.Paciente := LElegibilidade.Paciente;
   
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA PDV01';
   
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TPharmalinkProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TPharmalinkProduto.Create('7896261013483', 2, 35.00);
   
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
   LogCallback('', 'INFO');
   
   // Mostra detalhamento
   for I := Low(LPreAuth.Produtos) to High(LPreAuth.Produtos) do
   begin
      if LPreAuth.Produtos[I].Autorizado then
         LogCallback(Format('  [OK] %s: R$ %.2f → Desconto: %.0f%% → R$ %.2f (%s)', [
            LPreAuth.Produtos[I].CodigoBarras,
            LPreAuth.Produtos[I].ValorTotal,
            LPreAuth.Produtos[I].PercentualDesconto,
            LPreAuth.Produtos[I].ValorFinal,
            LPreAuth.Produtos[I].NomePrograma
         ]), 'INFO')
      else
         LogCallback(Format('  [X] %s: %s', [
            LPreAuth.Produtos[I].CodigoBarras,
            LPreAuth.Produtos[I].MensagemRejeicao
         ]), 'WARN');
   end;
   
   LogCallback('', 'INFO');
   LogCallback('DESCONTO TOTAL: ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalDesconto), 'INFO');
   LogCallback('VALOR A PAGAR:  ' + FormatCurr('R$ #,##0.00', LPreAuth.ValorTotalFinal), 'INFO');
   
   // 4. Confirmação
   LogCallback('', 'INFO');
   LogCallback('4. Confirmando venda...', 'INFO');
   
   LAuthRequest.Clear;
   LAuthRequest.NumeroPreAutorizacao := LPreAuth.NumeroPreAutorizacao;
   LAuthRequest.CodigoTransacao := LPreAuth.CodigoTransacao;
   LAuthRequest.NumeroVenda := LRequest.NumeroVenda;
   LAuthRequest.Operador := LRequest.Operador;
   
   LAuthResponse := FClient.AutorizarVenda(LAuthRequest);
   
   if not LAuthResponse.Sucesso then
   begin
      LogCallback('AUTORIZAÇÃO NEGADA: ' + LAuthResponse.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   // 5. Sucesso!
   LogCallback('', 'INFO');
   LogCallback('*** VENDA CONCLUÍDA COM SUCESSO ***', 'INFO');
   LogCallback('NSU: ' + LAuthResponse.NSU, 'INFO');
   LogCallback('Autorização: ' + LAuthResponse.NumeroAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   
   // 6. Gravar no banco
   LogCallback('5. Gravando no banco de dados...', 'INFO');
   LogCallback('   venda_id: ' + LRequest.NumeroVenda, 'INFO');
   LogCallback('   pharmalink_nsu: ' + LAuthResponse.NSU, 'INFO');
   LogCallback('   pharmalink_autorizacao: ' + LAuthResponse.NumeroAutorizacao, 'INFO');
   LogCallback('   pharmalink_desconto: ' + FormatFloat('0.00', LAuthResponse.ValorTotalDesconto), 'INFO');
   LogCallback('   pharmalink_valor_final: ' + FormatFloat('0.00', LAuthResponse.ValorTotalFinal), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('REPOSIÇÃO:', 'WARN');
   LogCallback('- Pharmalink utiliza reposição via distribuidoras', 'INFO');
   LogCallback('- Produtos serão repostos em até 2 dias úteis', 'INFO');
   LogCallback('- Verifique no Portal Pharmalink o status da reposição', 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
