unit uPBM.PECFebrafar.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração PEC Febrafar
  
  PEC = Programa de Estratégias Competitivas
  Febrafar = Federação Brasileira das Redes Associativistas e Independentes
  
  Características do PEC Febrafar:
  
  1. REST API com autenticação (CodigoAcesso + Senha + CodigoEmpresa)
  2. Maior federação de farmácias independentes do Brasil
  3. 57 redes associadas em todos os estados + DF
  4. 10+ mil lojas em 2.900 cidades
  5. Sistema de fidelização com pontos
  6. Aplicativo PWA para clientes com ofertas personalizadas
  7. Integração com sistema Orion (consulta de PBMs)
  8. Suporte a grupos preferenciais de clientes
  
  Diferenciais:
  - Ofertas exclusivas via app (cliente ativa ofertas)
  - Sistema de pontos por compra
  - Clientes preferenciais/VIP
  - Integração WhatsApp para relacionamento
  
  Estrutura do módulo:
  - uPBM.PECFebrafar.Types.pas : Tipos, records, constantes
  - uPBM.PECFebrafar.pas       : Cliente REST, JSONBuilder, JSONParser
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.PECFebrafar.Types, uPBM.PECFebrafar;

type
   TDemoPECFebrafar = class
   private
      FClient: TPECFebrafarClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      destructor Destroy; override;
      
      /// Configuração inicial
      procedure Configurar(const ACNPJ, ACodigoAcesso, ASenha, ACodigoEmpresa,
         AEnderecoServidor, ARazaoSocial, ACodigoRede, AUF: string;
         AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploCarregarProgramas;
      procedure ExemploConsultaCliente;
      procedure ExemploCadastroCliente;
      procedure ExemploListarOfertas;
      procedure ExemploAtivarOferta;
      procedure ExemploPreAutorizacao;
      procedure ExemploVendaCompleta;
      procedure ExemploVendaComOfertas;
      procedure ExemploCancelamento;
      procedure ExemploConsultaPontos;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoPECFebrafar }

constructor TDemoPECFebrafar.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
   FClient := CreatePECFebrafarClient;
   FClient.OnLog := LogCallback;
end;

destructor TDemoPECFebrafar.Destroy;
begin
   FClient.Free;
   inherited;
end;

procedure TDemoPECFebrafar.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoPECFebrafar.Configurar(const ACNPJ, ACodigoAcesso, ASenha,
   ACodigoEmpresa, AEnderecoServidor, ARazaoSocial, ACodigoRede, AUF: string;
   AHomologacao: Boolean);
begin
   FClient.SetAmbiente(AHomologacao);
   FClient.ConfigurarEstabelecimento(ACNPJ, ACodigoAcesso, ASenha, ACodigoEmpresa,
      AEnderecoServidor, ARazaoSocial, ACodigoRede, AUF);
   FClient.Timeout := 30000;
   FClient.MaxRetries := 3;
   
   LogCallback('Configuração PEC Febrafar concluída', 'INFO');
   LogCallback('Rede: ' + ACodigoRede, 'INFO');
   
   if FClient.TestarConexao then
      LogCallback('Conexão OK', 'INFO')
   else
      LogCallback('Falha: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoPECFebrafar.ExemploCarregarProgramas;
var
   LProgramas: TPECFebrafarProgramas;
   I: Integer;
begin
   LogCallback('=== Carregar Programas ===', 'INFO');
   
   if FClient.CarregarProgramas then
   begin
      LProgramas := FClient.Programas.GetAll;
      LogCallback('Total: ' + IntToStr(Length(LProgramas)), 'INFO');
      
      for I := Low(LProgramas) to High(LProgramas) do
      begin
         LogCallback(Format('%s - %s', [LProgramas[I].Codigo, LProgramas[I].Nome]), 'INFO');
         if LProgramas[I].Laboratorio <> '' then
            LogCallback('  Laboratório: ' + LProgramas[I].Laboratorio, 'INFO');
         LogCallback(Format('  Desconto: %.0f%%', [LProgramas[I].PercentualDesconto]), 'INFO');
      end;
   end;
end;

procedure TDemoPECFebrafar.ExemploConsultaCliente;
var
   LResponse: TPECFebrafarClienteResponse;
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
      
      case LResponse.Cliente.TipoCliente of
         tcNormal: LogCallback('Tipo: Cliente Normal', 'INFO');
         tcPreferencial: LogCallback('Tipo: Cliente PREFERENCIAL/VIP', 'INFO');
         tcFuncionario: LogCallback('Tipo: Funcionário', 'INFO');
         tcConveniado: LogCallback('Tipo: Conveniado', 'INFO');
      end;
      
      if LResponse.Cliente.GrupoCliente <> '' then
         LogCallback('Grupo: ' + LResponse.Cliente.GrupoCliente, 'INFO');
         
      LogCallback('', 'INFO');
      LogCallback('*** PONTOS: ' + IntToStr(LResponse.Cliente.Pontos) + ' ***', 'INFO');
      
      if LResponse.Cliente.UltimaCompra > 0 then
         LogCallback('Última compra: ' + FormatDateTime('dd/mm/yyyy', LResponse.Cliente.UltimaCompra), 'INFO');
         
      LogCallback('', 'INFO');
      LogCallback('Aceita WhatsApp: ' + BoolToStr(LResponse.Cliente.AceitaWhatsApp, True), 'INFO');
      LogCallback('Aceita Email: ' + BoolToStr(LResponse.Cliente.AceitaEmail, True), 'INFO');
      LogCallback('Aceita SMS: ' + BoolToStr(LResponse.Cliente.AceitaSMS, True), 'INFO');
   end
   else if LResponse.Sucesso and not LResponse.Encontrado then
      LogCallback('Cliente NÃO cadastrado - ofereça o cadastro!', 'WARN')
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoPECFebrafar.ExemploCadastroCliente;
var
   LRequest: TPECFebrafarCadastroClienteRequest;
   LResponse: TPECFebrafarClienteResponse;
begin
   LogCallback('=== Cadastro de Novo Cliente ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '98765432100';
   LRequest.Cliente.Nome := 'MARIA SANTOS';
   LRequest.Cliente.DataNascimento := EncodeDate(1985, 5, 15);
   LRequest.Cliente.Celular := '11999887766';
   LRequest.Cliente.Email := 'maria@email.com';
   LRequest.Cliente.CEP := '01310100';
   LRequest.Cliente.Endereco := 'AV PAULISTA';
   LRequest.Cliente.Numero := '1000';
   LRequest.Cliente.Bairro := 'BELA VISTA';
   LRequest.Cliente.Cidade := 'SAO PAULO';
   LRequest.Cliente.UF := 'SP';
   LRequest.Cliente.AceitaWhatsApp := True;
   LRequest.Cliente.AceitaEmail := True;
   LRequest.Cliente.AceitaSMS := False;
   LRequest.AceitaTermos := True;
   
   LResponse := FClient.CadastrarCliente(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CLIENTE CADASTRADO COM SUCESSO ***', 'INFO');
      LogCallback('Código: ' + LResponse.Cliente.Codigo, 'INFO');
      LogCallback('Nome: ' + LResponse.Cliente.Nome, 'INFO');
      LogCallback('Pontos iniciais: ' + IntToStr(LResponse.Cliente.Pontos), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoPECFebrafar.ExemploListarOfertas;
var
   LOfertas: TPECFebrafarOfertas;
   I: Integer;
begin
   LogCallback('=== Ofertas Disponíveis para Cliente ===', 'INFO');
   
   LOfertas := FClient.ListarOfertas('12345678901');
   
   if Length(LOfertas) > 0 then
   begin
      LogCallback('Total de ofertas: ' + IntToStr(Length(LOfertas)), 'INFO');
      LogCallback('', 'INFO');
      
      for I := Low(LOfertas) to High(LOfertas) do
      begin
         LogCallback(Format('[%s] %s', [LOfertas[I].Codigo, LOfertas[I].Descricao]), 'INFO');
         
         if LOfertas[I].CodigoBarras <> '' then
            LogCallback('  Produto: ' + LOfertas[I].CodigoBarras, 'INFO');
            
         case LOfertas[I].TipoDesconto of
            tfdPercentual: LogCallback(Format('  Desconto: %.0f%%', [LOfertas[I].PercentualDesconto]), 'INFO');
            tfdValorFixo: LogCallback(Format('  Desconto: R$ %.2f', [LOfertas[I].ValorDesconto]), 'INFO');
            tfdPrecoFixo: LogCallback(Format('  Preço fixo: R$ %.2f', [LOfertas[I].ValorDesconto]), 'INFO');
         end;
         
         LogCallback(Format('  Válida: %s a %s', [
            FormatDateTime('dd/mm/yyyy', LOfertas[I].DataInicio),
            FormatDateTime('dd/mm/yyyy', LOfertas[I].DataFim)
         ]), 'INFO');
         
         if LOfertas[I].Ativada then
            LogCallback('  Status: ATIVADA', 'INFO')
         else
            LogCallback('  Status: Disponível (cliente pode ativar no app)', 'WARN');
            
         LogCallback('', 'INFO');
      end;
   end
   else
      LogCallback('Nenhuma oferta disponível para este cliente', 'WARN');
end;

procedure TDemoPECFebrafar.ExemploAtivarOferta;
begin
   LogCallback('=== Ativar Oferta para Cliente ===', 'INFO');
   
   if FClient.AtivarOferta('12345678901', 'OFERTA001') then
      LogCallback('Oferta OFERTA001 ativada com sucesso!', 'INFO')
   else
      LogCallback('Erro ao ativar oferta: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoPECFebrafar.ExemploPreAutorizacao;
var
   LRequest: TPECFebrafarPreAutorizacaoRequest;
   LResponse: TPECFebrafarPreAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Pré-Autorização (Cotação) ===', 'INFO');
   
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
   LRequest.Produtos[0] := TPECFebrafarProduto.Create('7896181911999', 1, 85.90);
   LRequest.Produtos[1] := TPECFebrafarProduto.Create('7896261013483', 2, 35.00);
   
   LRequest.ValorTotal := 155.90;
   LRequest.NumeroVenda := 'PEC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.AplicarOfertas := True; // Aplica ofertas ativadas pelo cliente
   
   LResponse := FClient.PreAutorizarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** PRÉ-AUTORIZAÇÃO OK ***', 'INFO');
      LogCallback('Número: ' + LResponse.NumeroPreAutorizacao, 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Válida por: ' + IntToStr(LResponse.ValidadeMinutos) + ' min', 'INFO');
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
         
         if LResponse.Produtos[I].CodigoOferta <> '' then
            LogCallback('     Oferta aplicada: ' + LResponse.Produtos[I].CodigoOferta, 'INFO');
      end;
      
      LogCallback('', 'INFO');
      LogCallback('DESCONTO: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('A PAGAR:  ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      LogCallback('PONTOS:   ' + IntToStr(LResponse.PontosGerados) + ' pts a creditar', 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoPECFebrafar.ExemploVendaCompleta;
var
   LRequest: TPECFebrafarPreAutorizacaoRequest;
   LResponse: TPECFebrafarAutorizacaoResponse;
begin
   LogCallback('=== Venda Completa ===', 'INFO');
   
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TPECFebrafarProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'PECC-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.AplicarOfertas := True;
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA AUTORIZADA ***', 'INFO');
      LogCallback('NSU: ' + LResponse.NSU, 'INFO');
      LogCallback('Autorização: ' + LResponse.NumeroAutorizacao, 'INFO');
      LogCallback('Desconto: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
      LogCallback('Pago: ' + FormatCurr('R$ #,##0.00', LResponse.ValorTotalFinal), 'INFO');
      LogCallback('', 'INFO');
      LogCallback('*** PONTOS CREDITADOS: ' + IntToStr(LResponse.PontosCreditados) + ' ***', 'INFO');
      LogCallback('*** SALDO TOTAL: ' + IntToStr(LResponse.SaldoPontos) + ' pontos ***', 'INFO');
   end
   else
      LogCallback('NEGADA: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoPECFebrafar.ExemploVendaComOfertas;
var
   LOfertas: TPECFebrafarOfertas;
   LRequest: TPECFebrafarPreAutorizacaoRequest;
   LResponse: TPECFebrafarAutorizacaoResponse;
   I: Integer;
begin
   LogCallback('=== Venda com Ofertas do App ===', 'INFO');
   LogCallback('Demonstra ofertas que o cliente ativou no aplicativo', 'INFO');
   LogCallback('', 'INFO');
   
   // 1. Listar ofertas ativas do cliente
   LOfertas := FClient.ListarOfertas('12345678901');
   
   LogCallback('Ofertas ativas do cliente:', 'INFO');
   for I := Low(LOfertas) to High(LOfertas) do
      if LOfertas[I].Ativada then
         LogCallback(Format('  [ATIVA] %s: %s', [LOfertas[I].Codigo, LOfertas[I].Descricao]), 'INFO');
   
   LogCallback('', 'INFO');
   
   // 2. Processar venda (ofertas são aplicadas automaticamente)
   LRequest.Clear;
   LRequest.Cliente.CPF := '12345678901';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'CAIXA 01';
   
   SetLength(LRequest.Produtos, 1);
   LRequest.Produtos[0] := TPECFebrafarProduto.Create('7896181911999', 1, 85.90);
   
   LRequest.ValorTotal := 85.90;
   LRequest.NumeroVenda := 'PECO-' + FormatDateTime('yyyymmddhhnnss', Now);
   LRequest.DataHoraVenda := Now;
   LRequest.AplicarOfertas := True; // IMPORTANTE: Aplica ofertas do app
   
   LResponse := FClient.VendaCompleta(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** VENDA COM OFERTAS AUTORIZADA ***', 'INFO');
      LogCallback('Desconto total (programas + ofertas): ' + 
         FormatCurr('R$ #,##0.00', LResponse.ValorTotalDesconto), 'INFO');
   end;
end;

procedure TDemoPECFebrafar.ExemploCancelamento;
var
   LRequest: TPECFebrafarCancelamentoRequest;
   LResponse: TPECFebrafarCancelamentoResponse;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LRequest.Clear;
   LRequest.NSU := 'NSU123456';
   LRequest.NumeroVenda := 'PEC-20241215120000';
   LRequest.Motivo := 'Desistência do cliente';
   LRequest.Operador.CPF := '11122233344';
   LRequest.Operador.Nome := 'SUPERVISOR';
   
   LResponse := FClient.CancelarVenda(LRequest);
   
   if LResponse.Sucesso then
   begin
      LogCallback('*** CANCELAMENTO CONFIRMADO ***', 'INFO');
      LogCallback('NSU Cancelamento: ' + LResponse.NSUCancelamento, 'INFO');
      LogCallback('Pontos estornados: ' + IntToStr(LResponse.PontosEstornados), 'INFO');
   end
   else
      LogCallback('Erro: ' + LResponse.MensagemRetorno, 'ERROR');
end;

procedure TDemoPECFebrafar.ExemploConsultaPontos;
var
   LPontos: Integer;
begin
   LogCallback('=== Consulta Rápida de Pontos ===', 'INFO');
   
   LPontos := FClient.ConsultarPontos('12345678901');
   
   LogCallback('Saldo de pontos: ' + IntToStr(LPontos), 'INFO');
end;

procedure TDemoPECFebrafar.ExemploFluxoCompleto;
var
   LClienteResp: TPECFebrafarClienteResponse;
   LCadastroReq: TPECFebrafarCadastroClienteRequest;
   LOfertas: TPECFebrafarOfertas;
   LVendaReq: TPECFebrafarPreAutorizacaoRequest;
   LVendaResp: TPECFebrafarAutorizacaoResponse;
   LCPF: string;
   I: Integer;
begin
   LogCallback('=== Fluxo Completo PEC Febrafar ===', 'INFO');
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
      LCadastroReq.Cliente.AceitaWhatsApp := True;
      LCadastroReq.AceitaTermos := True;
      
      LClienteResp := FClient.CadastrarCliente(LCadastroReq);
      
      if not LClienteResp.Sucesso then
      begin
         LogCallback('Erro ao cadastrar: ' + LClienteResp.MensagemRetorno, 'ERROR');
         Exit;
      end;
   end;
   
   LogCallback('Cliente: ' + LClienteResp.Cliente.Nome, 'INFO');
   LogCallback('Pontos: ' + IntToStr(LClienteResp.Cliente.Pontos), 'INFO');
   
   // 3. Verificar ofertas
   LogCallback('', 'INFO');
   LogCallback('3. Verificando ofertas do cliente...', 'INFO');
   LOfertas := FClient.ListarOfertas(LCPF);
   
   for I := Low(LOfertas) to High(LOfertas) do
      if LOfertas[I].Ativada then
         LogCallback('  [ATIVA] ' + LOfertas[I].Descricao, 'INFO');
   
   // 4. Processar venda
   LogCallback('', 'INFO');
   LogCallback('4. Processando venda...', 'INFO');
   
   LVendaReq.Clear;
   LVendaReq.Cliente.CPF := LCPF;
   LVendaReq.Cliente.Nome := LClienteResp.Cliente.Nome;
   LVendaReq.Operador.CPF := '11122233344';
   LVendaReq.Operador.Nome := 'CAIXA PDV01';
   LVendaReq.Operador.CodigoTerminal := 'PDV01';
   
   SetLength(LVendaReq.Produtos, 2);
   LVendaReq.Produtos[0] := TPECFebrafarProduto.Create('7896181911999', 1, 85.90);
   LVendaReq.Produtos[1] := TPECFebrafarProduto.Create('7896261013483', 2, 35.00);
   
   LVendaReq.ValorTotal := 155.90;
   LVendaReq.NumeroVenda := Format('PDV01-%s', [FormatDateTime('yyyymmddhhnnsszzz', Now)]);
   LVendaReq.DataHoraVenda := Now;
   LVendaReq.AplicarOfertas := True;
   
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
   LogCallback('Desconto: ' + FormatCurr('R$ #,##0.00', LVendaResp.ValorTotalDesconto), 'INFO');
   LogCallback('Pago: ' + FormatCurr('R$ #,##0.00', LVendaResp.ValorTotalFinal), 'INFO');
   LogCallback('', 'INFO');
   LogCallback('*** PONTOS ***', 'INFO');
   LogCallback('Creditados: +' + IntToStr(LVendaResp.PontosCreditados), 'INFO');
   LogCallback('Saldo total: ' + IntToStr(LVendaResp.SaldoPontos), 'INFO');
   
   // 6. Gravar no banco
   LogCallback('', 'INFO');
   LogCallback('5. Gravando no banco...', 'INFO');
   LogCallback('   venda_id: ' + LVendaReq.NumeroVenda, 'INFO');
   LogCallback('   pec_nsu: ' + LVendaResp.NSU, 'INFO');
   LogCallback('   pec_autorizacao: ' + LVendaResp.NumeroAutorizacao, 'INFO');
   LogCallback('   pec_desconto: ' + FormatFloat('0.00', LVendaResp.ValorTotalDesconto), 'INFO');
   LogCallback('   pec_pontos: ' + IntToStr(LVendaResp.PontosCreditados), 'INFO');
   
   LogCallback('', 'INFO');
   LogCallback('=== FIM DO FLUXO ===', 'INFO');
end;

end.
