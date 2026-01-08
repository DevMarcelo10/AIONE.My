unit uPBM.Orizon.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Orizon PBM
  
  Este arquivo demonstra como usar o módulo de integração Orizon no ERP AIONE.
  
  Características da Orizon:
  
  1. REST API com autenticação X-API-KEY + Login/Senha
  2. Suporta múltiplos planos/operadoras
  3. Desconto padrão PBM ou desconto em folha
  4. Opção de uso contínuo (requer receita)
  5. Até 85% de desconto em mais de 1.900 medicamentos
  
  Estrutura do módulo:
  - uPBM.Orizon.Types.pas : Tipos, records, constantes
  - uPBM.Orizon.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.Orizon.Types, uPBM.Orizon;

type
   TDemoOrizon = class
   private
      FClient: TOrizonClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACodigoRede, ACodigoFilial,
         ALogin, ASenha, AAPIKey: string; AHomologacao: Boolean = True);
      
      /// Cadastra planos conhecidos
      procedure CadastrarPlanos;
      
      /// Exemplos de operações
      procedure ExemploConsultaElegibilidade;
      procedure ExemploAutorizacaoSimples;
      procedure ExemploAutorizacaoUsoContinuo;
      procedure ExemploAutorizacaoDescontoFolha;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
      procedure ExemploConsultaProduto;
   end;

implementation

{ TDemoOrizon }

constructor TDemoOrizon.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateOrizonClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoOrizon.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoOrizon.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoOrizon.Configurar(const ACNPJ, ACodigoRede, ACodigoFilial,
   ALogin, ASenha, AAPIKey: string; AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoRede, ACodigoFilial, ALogin, ASenha, AAPIKey);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   // Cadastra planos conhecidos
   CadastrarPlanos;
   
   LogCallback('Configuração concluída', 'INFO');
   
   // Testa conexão
   if FClient.TestarConexao then
      LogCallback('Conexão com Orizon OK', 'INFO')
   else
      LogCallback('Falha na conexão: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoOrizon.CadastrarPlanos;
begin
   // Exemplos de planos - você deve cadastrar os planos reais do seu contrato
   FClient.AdicionarPlano('001', 'PREVSAUDE VIP', 'PREVSAUDE');
   FClient.AdicionarPlano('002', 'UNIMED NACIONAL', 'UNIMED');
   FClient.AdicionarPlano('003', 'BRADESCO SAUDE', 'BRADESCO');
   FClient.AdicionarPlano('004', 'AMIL TOTAL', 'AMIL');
   FClient.AdicionarPlano('005', 'SULAMERICA EXECUTIVO', 'SULAMERICA');
   FClient.AdicionarPlano('006', 'NOTRE DAME', 'NOTRE DAME');
   FClient.AdicionarPlano('007', 'HAPVIDA', 'HAPVIDA');
   
   LogCallback('Planos cadastrados: ' + IntToStr(FClient.Planos.Count), 'INFO');
end;

procedure TDemoOrizon.ExemploConsultaElegibilidade;
var
   LResponse: TOrizonElegibilidadeResponse;
begin
   LogCallback('=== Consulta de Elegibilidade ===', 'INFO');
   
   // Consulta se o beneficiário está ativo e pode usar o PBM
   LResponse := FClient.ConsultarElegibilidade('123456789', '001');
   
   if LResponse.Sucesso then
   begin
      LogCallback('Beneficiário encontrado!', 'INFO');
      LogCallback('Nome: ' + LResponse.Beneficiario.Nome, 'INFO');
      LogCallback('Plano: ' + LResponse.Beneficiario.Plano.Nome, 'INFO');
      LogCallback('Operadora: ' + LResponse.Beneficiario.Plano.Operadora, 'INFO');
      LogCallback('Elegível: ' + BoolToStr(LResponse.Elegivel, True), 'INFO');
      LogCallback('Limite disponível: ' + FormatCurr('R$ #,##0.00', LResponse.LimiteDisponivel), 'INFO');
      
      if not LResponse.Elegivel then
         LogCallback('Beneficiário não elegível para descontos neste momento', 'WARN');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoOrizon.ExemploAutorizacaoSimples;
var
   LRequest: TOrizonAutorizacaoRequest;
   LResponse: TOrizonAutorizacaoResponse;
begin
   LogCallback('=== Autorização Simples (Desconto PBM Padrão) ===', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.Matricula := '123456789';
   LRequest.Beneficiario.CPF := '12345678901';
   LRequest.Beneficiario.Nome := 'JOSE DA SILVA';
   LRequest.Beneficiario.Plano := FClient.Planos.Get('001');
   LRequest.DescontoEmFolha := False;
   
   // Vendedor
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'ATENDENTE FULANO';
   LRequest.Vendedor.Matricula := 'V001';
   
   // Produtos
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TOrizonProduto.Create('7891234567890', 1, 45.90);
   LRequest.Produtos[1] := TOrizonProduto.Create('7899876543210', 2, 22.50);
   
   // Dados da venda
   LRequest.ValorTotal := 90.90;
   LRequest.NumeroVenda := 'ORI-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.InformarReceita := False;
   
   // Executa autorização
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** AUTORIZADO ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Código Autorização: ' + LResponse.CodigoAutorizacao, 'INFO');
      LogCallback('Desconto Total: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('Cliente Paga: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
   end
   else
   begin
      LogCallback('NEGADO: ' + LResponse.MensagemRetorno, 'WARN');
      LogCallback('Código: ' + LResponse.CodigoRetorno, 'WARN');
   end;
end;

procedure TDemoOrizon.ExemploAutorizacaoUsoContinuo;
var
   LRequest: TOrizonAutorizacaoRequest;
   LResponse: TOrizonAutorizacaoResponse;
begin
   LogCallback('=== Autorização Uso Contínuo (Com Receita) ===', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário
   LRequest.Beneficiario.Matricula := '987654321';
   LRequest.Beneficiario.CPF := '11122233344';
   LRequest.Beneficiario.Nome := 'MARIA SANTOS';
   LRequest.Beneficiario.Plano := FClient.Planos.Get('002');
   LRequest.DescontoEmFolha := False;
   
   // Vendedor
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'ATENDENTE FULANO';
   LRequest.Vendedor.Matricula := 'V001';
   
   // Produto de uso contínuo
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TOrizonProduto.Create('7891000000001', 1, 89.90);
   LRequest.Produtos[0].TipoUso := tuContinuo; // Marca como uso contínuo
   
   // Receita médica (obrigatória para uso contínuo)
   LRequest.InformarReceita := True;
   LRequest.Receita.CRM := '12345';
   LRequest.Receita.UFMedico := 'SP';
   LRequest.Receita.NomeMedico := 'DR. FULANO DE TAL';
   LRequest.Receita.DataReceita := Date - 15; // Receita de 15 dias atrás
   
   // Dados da venda
   LRequest.ValorTotal := 89.90;
   LRequest.NumeroVenda := 'ORI-UC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** AUTORIZADO (USO CONTÍNUO) ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Desconto: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('Cliente Paga: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
   end
   else
      LogCallback('NEGADO: ' + LResponse.MensagemRetorno, 'WARN');
end;

procedure TDemoOrizon.ExemploAutorizacaoDescontoFolha;
var
   LRequest: TOrizonAutorizacaoRequest;
   LResponse: TOrizonAutorizacaoResponse;
begin
   LogCallback('=== Autorização com Desconto em Folha ===', 'INFO');
   LogCallback('(Valor descontado do salário do beneficiário)', 'INFO');
   
   LRequest.Clear;
   
   // Beneficiário com desconto em folha habilitado
   LRequest.Beneficiario.Matricula := '555666777';
   LRequest.Beneficiario.CPF := '44455566677';
   LRequest.Beneficiario.Nome := 'PEDRO OLIVEIRA';
   LRequest.Beneficiario.Plano := FClient.Planos.Get('003');
   LRequest.Beneficiario.TipoDesconto := tdFolha;
   LRequest.DescontoEmFolha := True; // Desconto em folha de pagamento
   
   // Vendedor
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'ATENDENTE FULANO';
   LRequest.Vendedor.Matricula := 'V001';
   
   // Produtos
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TOrizonProduto.Create('7891234567890', 1, 120.00);
   
   LRequest.ValorTotal := 120.00;
   LRequest.NumeroVenda := 'ORI-DF-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.InformarReceita := False;
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** AUTORIZADO (DESCONTO EM FOLHA) ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Valor será descontado na folha: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      LogCallback('O cliente NÃO paga agora, será descontado no salário', 'INFO');
   end
   else
      LogCallback('NEGADO: ' + LResponse.MensagemRetorno, 'WARN');
end;

procedure TDemoOrizon.ExemploCancelamento;
var
   LRequest: TOrizonCancelamentoRequest;
   LResponse: TOrizonCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456789';           // NSU da venda original
   LRequest.NumeroVenda := 'ORI-20241215120000'; // ID original
   LRequest.Motivo := 'Desistência do cliente';
   
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Nome := 'ATENDENTE FULANO';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('Cancelamento confirmado', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoOrizon.ExemploConsultaProduto;
var
   LEan: string;
   LDesconto: Double;
begin
   LogCallback('=== Consulta de Produto no PBM ===', 'INFO');
   
   LEan := '7891234567890';
   
   if FClient.ConsultarProduto(LEan, LDesconto) then
   begin
      LogCallback('Produto ' + LEan + ' cadastrado no Orizon', 'INFO');
      LogCallback('Percentual de desconto: ' + FormatFloat('0.00', LDesconto) + '%', 'INFO');
   end
   else
      LogCallback('Produto ' + LEan + ' NÃO está no programa', 'WARN');
end;

procedure TDemoOrizon.ExemploFluxoCompleto;
var
   LElegibilidade: TOrizonElegibilidadeResponse;
   LRequest: TOrizonAutorizacaoRequest;
   LResponse: TOrizonAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Fluxo Completo de Venda Orizon PBM ===', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Verifica conexão
   LogCallback('1. Verificando conexão com Orizon...', 'INFO');
   if not FClient.TestarConexao then
   begin
      LogCallback('Sem conexão com Orizon. Venda PBM indisponível.', 'ERROR');
      Exit;
   end;
   
   // 2. Consulta elegibilidade do beneficiário
   LogCallback('2. Consultando elegibilidade do beneficiário...', 'INFO');
   LElegibilidade := FClient.ConsultarElegibilidade('123456789', '001');
   
   if not LElegibilidade.Sucesso then
   begin
      LogCallback('Beneficiário não encontrado: ' + LElegibilidade.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   if not LElegibilidade.Elegivel then
   begin
      LogCallback('Beneficiário não elegível para descontos', 'WARN');
      Exit;
   end;
   
   LogCallback('Beneficiário: ' + LElegibilidade.Beneficiario.Nome, 'INFO');
   LogCallback('Plano: ' + LElegibilidade.Beneficiario.Plano.Nome, 'INFO');
   LogCallback('Limite disponível: ' + FormatCurr('R$ #,##0.00', LElegibilidade.LimiteDisponivel), 'INFO');
   
   // 3. Monta request de autorização
   LogCallback('', 'INFO');
   LogCallback('3. Montando dados da venda...', 'INFO');
   
   LRequest.Clear;
   LRequest.Beneficiario := LElegibilidade.Beneficiario;
   LRequest.DescontoEmFolha := False;
   
   // Vendedor logado
   LRequest.Vendedor.CPF := '11122233344';
   LRequest.Vendedor.Nome := 'CAIXA 01';
   LRequest.Vendedor.Matricula := 'C001';
   
   // Produtos do carrinho
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TOrizonProduto.Create('7891000100001', 1, 45.90);
   LRequest.Produtos[1] := TOrizonProduto.Create('7891000100002', 2, 32.50);
   
   LRequest.ValorTotal := 110.90;
   LRequest.NumeroVenda := Format('PDV001-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LRequest.DataHoraVenda := Now;
   LRequest.InformarReceita := False;
   
   // 4. Autoriza no Orizon
   LogCallback('4. Enviando para autorização Orizon...', 'INFO');
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if not LResponse.Sucesso then
   begin
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
      Exit;
   end;
   
   // 5. Processa resposta
   LogCallback('', 'INFO');
   LogCallback('*** VENDA AUTORIZADA ***', 'INFO');
   LogCallback('NSU Orizon: ' + LResponse.NSU, 'INFO');
   LogCallback('Código Autorização: ' + LResponse.CodigoAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   
   // Mostra detalhamento por produto
   LogCallback('Detalhamento:', 'INFO');
   for I := Low(LResponse.Produtos) to High(LResponse.Produtos) do
   begin
      if LResponse.Produtos[I].Autorizado then
      begin
         LogCallback(Format('  %s: %s', [
            LResponse.Produtos[I].CodigoBarras,
            LResponse.Produtos[I].Descricao
         ]), 'INFO');
         LogCallback(Format('    Valor: R$ %.2f | Desconto: %.1f%% (R$ %.2f) | Final: R$ %.2f', [
            LResponse.Produtos[I].ValorTotal,
            LResponse.Produtos[I].PercentualDesconto,
            LResponse.Produtos[I].ValorDesconto,
            LResponse.Produtos[I].ValorFinal
         ]), 'INFO');
      end
      else
         LogCallback(Format('  %s: REJEITADO - %s', [
            LResponse.Produtos[I].CodigoBarras,
            LResponse.Produtos[I].MensagemRejeicao
         ]), 'WARN');
   end;
   
   LogCallback('', 'INFO');
   LogCallback('DESCONTO TOTAL: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
   LogCallback('CLIENTE PAGA:   ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
   LogCallback('', 'INFO');
   
   // 6. Grava no banco de dados
   LogCallback('5. Gravando no banco de dados...', 'INFO');
   LogCallback('   venda_id: ' + LRequest.NumeroVenda, 'INFO');
   LogCallback('   orizon_nsu: ' + LResponse.NSU, 'INFO');
   LogCallback('   orizon_autorizacao: ' + LResponse.CodigoAutorizacao, 'INFO');
   LogCallback('   orizon_desconto: ' + FormatFloat('0.00', LResponse.ValorTotalDesconto), 'INFO');
   LogCallback('   orizon_valor_final: ' + FormatFloat('0.00', LResponse.ValorTotalFinal), 'INFO');
   LogCallback('   orizon_json: [JSON salvo]', 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== VENDA CONCLUÍDA COM SUCESSO ===', 'INFO');
end;

end.
