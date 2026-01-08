unit uPBM.FarmaciaPopular.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Farmácia Popular (DATASUS)
  
  Este arquivo demonstra como usar o módulo de integração Farmácia Popular.
  
  Diferenças principais em relação a PBMs comerciais (Epharma, Funcional Card):
  
  1. SOAP/XML ao invés de REST/JSON
  2. Autenticação por usuário/senha do DATASUS (não OAuth)
  3. Requer dados da receita médica (CRM, data)
  4. Produtos têm subsídio governamental (gratuidade ou desconto)
  5. Limites mensais por paciente/medicamento
  
  Estrutura do módulo:
  - uPBM.FarmaciaPopular.Types.pas : Tipos, records, constantes
  - uPBM.FarmaciaPopular.pas       : Cliente SOAP, XMLBuilder, XMLParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.FarmaciaPopular.Types, uPBM.FarmaciaPopular;

type
   TDemoFarmaciaPopular = class
   private
      FClient: TFarmaciaPopularClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACNES, AUsuario, ASenha: string;
         AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploAutorizacaoVenda;
      procedure ExemploAutorizacaoGratuidade;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
      procedure ExemploConsultaProduto;
   end;

implementation

{ TDemoFarmaciaPopular }

constructor TDemoFarmaciaPopular.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreateFarmaciaPopularClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoFarmaciaPopular.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoFarmaciaPopular.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoFarmaciaPopular.Configurar(const ACNPJ, ACNES, AUsuario, ASenha: string;
   AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACNES, AUsuario, ASenha);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('Configuração concluída', 'INFO');
   
   // Testa conexão
   if FClient.TestarConexao then
      LogCallback('Conexão com DATASUS OK', 'INFO')
   else
      LogCallback('Falha na conexão: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoFarmaciaPopular.ExemploAutorizacaoVenda;
var
   LRequest: TFPAutorizacaoRequest;
   LResponse: TFPAutorizacaoResponse;
begin
   LogCallback('=== Autorização de Venda (Medicamento Subsidiado) ===', 'INFO');
   
   LRequest.Clear;
   
   // Dados do paciente
   LRequest.Paciente.CPF := '12345678901';
   LRequest.Paciente.Nome := 'JOSE DA SILVA';
   LRequest.Paciente.DataNascimento := EncodeDate(1970, 5, 15);
   LRequest.Paciente.NomeMae := 'MARIA DA SILVA';
   LRequest.Paciente.Sexo := 'M';
   
   // Dados da receita
   LRequest.Receita.CRM := '12345';
   LRequest.Receita.UFMedico := 'SP';
   LRequest.Receita.DataReceita := Date - 10; // Receita de 10 dias atrás
   
   // Dados do vendedor
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Login := 'VENDEDOR1'; // 9 caracteres max
   
   // Produtos (medicamento subsidiado - paciente paga parte)
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TFPProduto.Create('7891234567890', 1, 45.90);
   
   // Dados da venda
   LRequest.ValorTotal := 45.90;
   LRequest.NumeroVenda := 'FP-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   // Executa autorização
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('AUTORIZADO!', 'INFO');
      LogCallback('NSU: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('Subsídio Governo: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalSubsidio), 'INFO');
      LogCallback('Paciente Paga: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalPaciente), 'INFO');
   end
   else
   begin
      LogCallback('NEGADO: ' + LResponse.MensagemRetorno, 'WARN');
      LogCallback('Código: ' + LResponse.CodigoRetorno, 'WARN');
   end;
end;

procedure TDemoFarmaciaPopular.ExemploAutorizacaoGratuidade;
var
   LRequest: TFPAutorizacaoRequest;
   LResponse: TFPAutorizacaoResponse;
begin
   LogCallback('=== Autorização Gratuidade (Saúde Não Tem Preço) ===', 'INFO');
   LogCallback('Medicamentos para Hipertensão, Diabetes ou Asma', 'INFO');
   
   LRequest.Clear;
   
   // Dados do paciente hipertenso
   LRequest.Paciente.CPF := '12345678901';
   LRequest.Paciente.Nome := 'MARIA SANTOS';
   LRequest.Paciente.DataNascimento := EncodeDate(1955, 3, 20);
   LRequest.Paciente.NomeMae := 'ANA SANTOS';
   LRequest.Paciente.Sexo := 'F';
   
   // Receita válida (máximo 180 dias para gratuidade)
   LRequest.Receita.CRM := '54321';
   LRequest.Receita.UFMedico := 'RJ';
   LRequest.Receita.DataReceita := Date - 30;
   
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Login := 'ATENDENTE';
   
   // Medicamento para hipertensão (100% gratuito)
   // Exemplo: Losartana, Captopril, Atenolol, etc.
   SetLength(LRequest.Produtos, 2);
   LRequest.Produtos[0] := TFPProduto.Create('7891000000001', 1, 25.00); // Losartana
   LRequest.Produtos[1] := TFPProduto.Create('7891000000002', 1, 18.50); // Hidroclorotiazida
   
   LRequest.ValorTotal := 43.50;
   LRequest.NumeroVenda := 'GRAT-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('GRATUIDADE AUTORIZADA!', 'INFO');
      LogCallback('NSU: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('Valor Subsidiado: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalSubsidio), 'INFO');
      LogCallback('Paciente Paga: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalPaciente), 'INFO');
      
      // Para gratuidade, ValorTotalPaciente deve ser 0
      if LResponse.ValorTotalPaciente = 0 then
         LogCallback('*** MEDICAMENTO 100% GRATUITO ***', 'INFO');
   end
   else
   begin
      LogCallback('NEGADO: ' + LResponse.MensagemRetorno, 'WARN');
      
      // Códigos comuns de erro em gratuidade
      case StrToIntDef(LResponse.CodigoRetorno, -1) of
         5: LogCallback('Limite mensal atingido para este medicamento', 'WARN');
         4: LogCallback('Receita vencida (máx 180 dias para gratuidade)', 'WARN');
      end;
   end;
end;

procedure TDemoFarmaciaPopular.ExemploCancelamento;
var
   LRequest: TFPCancelamentoRequest;
   LResponse: TFPCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NumeroAutorizacao := 'NSU123456789'; // NSU da venda original
   LRequest.NumeroVenda := 'FP-20241215120000';  // ID original
   LRequest.Motivo := 'Desistência do cliente';
   
   LRequest.Vendedor.CPF := '98765432100';
   LRequest.Vendedor.Login := 'VENDEDOR1';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
      LogCallback('Cancelamento confirmado', 'INFO')
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoFarmaciaPopular.ExemploConsultaProduto;
var
   LEan: string;
begin
   LogCallback('=== Consulta de Produto no Programa ===', 'INFO');
   
   LEan := '7891234567890';
   
   if FClient.ConsultarProduto(LEan) then
      LogCallback('Produto ' + LEan + ' está no Farmácia Popular', 'INFO')
   else
      LogCallback('Produto ' + LEan + ' NÃO está no programa', 'WARN');
end;

procedure TDemoFarmaciaPopular.ExemploFluxoCompleto;
var
   LRequest: TFPAutorizacaoRequest;
   LResponse: TFPAutorizacaoResponse;
   LCancelReq: TFPCancelamentoRequest;
   LCancelResp: TFPCancelamentoResponse;
   I: Integer;
begin
   LogCallback('=== Fluxo Completo PDV Farmácia Popular ===', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Verifica conexão
   LogCallback('1. Verificando conexão com DATASUS...', 'INFO');
   if not FClient.TestarConexao then
   begin
      LogCallback('Sem conexão com DATASUS. Venda FP indisponível.', 'ERROR');
      Exit;
   end;
   
   // 2. Monta request com dados do PDV
   LogCallback('2. Montando dados da venda...', 'INFO');
   
   LRequest.Clear;
   
   // Dados viriam do cadastro de cliente
   LRequest.Paciente.CPF := '12345678901';
   LRequest.Paciente.Nome := 'JOAO PEREIRA';
   LRequest.Paciente.DataNascimento := EncodeDate(1960, 8, 10);
   LRequest.Paciente.NomeMae := 'ANTONIA PEREIRA';
   LRequest.Paciente.Sexo := 'M';
   
   // Dados da receita (digitados no PDV)
   LRequest.Receita.CRM := '98765';
   LRequest.Receita.UFMedico := 'SP';
   LRequest.Receita.DataReceita := Date - 5;
   
   // Vendedor logado
   LRequest.Vendedor.CPF := '11122233344';
   LRequest.Vendedor.Login := 'CAIXA01';
   
   // Produtos do carrinho
   SetLength(LRequest.Produtos, 3);
   LRequest.Produtos[0] := TFPProduto.Create('7891000100001', 2, 15.90); // Captopril
   LRequest.Produtos[1] := TFPProduto.Create('7891000100002', 1, 22.50); // Metformina  
   LRequest.Produtos[2] := TFPProduto.Create('7891000100003', 1, 35.00); // Sinvastatina
   
   LRequest.ValorTotal := 89.30;
   LRequest.NumeroVenda := Format('PDV001-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LRequest.DataHoraVenda := Now;
   
   // 3. Autoriza no DATASUS
   LogCallback('3. Enviando para autorização DATASUS...', 'INFO');
   LResponse := FClient.AutorizarVenda(LRequest);
   
   if not LResponse.Sucesso then
   begin
      LogCallback('VENDA NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
      LogCallback('Informar cliente e verificar dados.', 'WARN');
      Exit;
   end;
   
   // 4. Processa resposta
   LogCallback('', 'INFO');
   LogCallback('*** VENDA AUTORIZADA ***', 'INFO');
   LogCallback('NSU DATASUS: ' + LResponse.NumeroAutorizacao, 'INFO');
   LogCallback('', 'INFO');
   
   // Mostra detalhamento por produto
   LogCallback('Detalhamento:', 'INFO');
   for I := Low(LResponse.Produtos) to High(LResponse.Produtos) do
   begin
      if LResponse.Produtos[I].Autorizado then
      begin
         LogCallback(Format('  %s: Subsídio R$ %.2f / Paciente R$ %.2f', [
            LResponse.Produtos[I].CodigoBarras,
            LResponse.Produtos[I].ValorSubsidio,
            LResponse.Produtos[I].ValorPaciente
         ]), 'INFO');
      end
      else
         LogCallback(Format('  %s: REJEITADO - %s', [
            LResponse.Produtos[I].CodigoBarras,
            LResponse.Produtos[I].MensagemRejeicao
         ]), 'WARN');
   end;
   
   LogCallback('', 'INFO');
   LogCallback('TOTAL SUBSÍDIO: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalSubsidio), 'INFO');
   LogCallback('CLIENTE PAGA:   ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalPaciente), 'INFO');
   LogCallback('', 'INFO');
   
   // 5. Grava no banco de dados
   LogCallback('4. Gravando no banco de dados...', 'INFO');
   LogCallback('   venda_id: ' + LRequest.NumeroVenda, 'INFO');
   LogCallback('   fp_nsu: ' + LResponse.NumeroAutorizacao, 'INFO');
   LogCallback('   fp_valor_subsidio: ' + FormatFloat('0.00', LResponse.ValorTotalSubsidio), 'INFO');
   LogCallback('   fp_valor_paciente: ' + FormatFloat('0.00', LResponse.ValorTotalPaciente), 'INFO');
   LogCallback('   fp_xml_envio: [XML salvo]', 'INFO');
   LogCallback('   fp_xml_retorno: [XML salvo]', 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== VENDA CONCLUÍDA COM SUCESSO ===', 'INFO');
   
   // Demonstração de cancelamento (comentado - só descomentar para testar)
   {
   LogCallback('', 'INFO');
   LogCallback('5. Simulando cancelamento...', 'INFO');
   
   LCancelReq.Clear;
   LCancelReq.NumeroAutorizacao := LResponse.NumeroAutorizacao;
   LCancelReq.NumeroVenda := LRequest.NumeroVenda;
   LCancelReq.Motivo := 'Teste de cancelamento';
   LCancelReq.Vendedor := LRequest.Vendedor;
   
   LCancelResp := FClient.CancelarVenda(LCancelReq);
   
   if LCancelResp.Sucesso then
      LogCallback('Cancelamento OK', 'INFO')
   else
      LogCallback('Erro no cancelamento: ' + LCancelResp.MensagemRetorno, 'ERROR');
   }
end;

end.
