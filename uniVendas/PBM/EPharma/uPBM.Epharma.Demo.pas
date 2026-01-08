unit uPBM.Epharma.Demo;

{------------------------------------------------------------------------------
  EXEMPLO DE USO - Integração Epharma
  
  Este arquivo demonstra como usar o módulo de integração Epharma no ERP AIONE.
  
  Estrutura do módulo:
  - uPBM.Interfaces.pas : Interfaces e tipos base (desacoplamento total)
  - uPBM.Base.pas       : Classes base, TokenManager, HTTPClientEx
  - uPBM.Epharma.pas    : Implementação específica Epharma
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, Vcl.StdCtrls, Vcl.Forms,
   uPBM.Interfaces, uPBM.Epharma;

type
   TDemoEpharma = class
   private
      FClient: IPBMClient;
      FMemo: TMemo;
      procedure LogCallback(const AMsg: string; const ATipo: string = 'INFO');
   public
      constructor Create(AMemo: TMemo);
      
      /// Inicializa conexão com Epharma
      procedure Conectar(const AClientID, AClientSecret: string; AHomologacao: Boolean = True);
      
      /// Exemplos de operações
      procedure ExemploConsultaBeneficiario;
      procedure ExemploAutorizacaoVenda;
      procedure ExemploCancelamento;
      procedure ExemploFluxoCompleto;
   end;

implementation

{ TDemoEpharma }

constructor TDemoEpharma.Create(AMemo: TMemo);
begin
   inherited Create;
   FMemo := AMemo;
end;

procedure TDemoEpharma.LogCallback(const AMsg: string; const ATipo: string);
begin
   if Assigned(FMemo) then
      FMemo.Lines.Add(Format('[%s] %s: %s', [FormatDateTime('hh:nn:ss', Now), ATipo, AMsg]));
end;

procedure TDemoEpharma.Conectar(const AClientID, AClientSecret: string; AHomologacao: Boolean);
begin
   // Criação elegante via função factory
   FClient := CreateEpharmaClient(AClientID, AClientSecret, AHomologacao);
   FClient.OnLog := LogCallback;
   
   // Configura timeout e retries se necessário
   FClient.Config.Timeout := 30000;
   FClient.Config.MaxRetries := 3;
   
   LogCallback('Cliente Epharma inicializado', 'INFO');
   
   // Testa conectividade
   if FClient.Ping then
      LogCallback('Conexão OK', 'INFO')
   else
      LogCallback('Falha na conexão: ' + FClient.UltimoErro, 'ERROR');
end;

procedure TDemoEpharma.ExemploConsultaBeneficiario;
var
   LBenef: IPBMBeneficiario;
begin
   LogCallback('=== Consulta de Beneficiário ===', 'INFO');
   
   LBenef := FClient.ConsultarBeneficiario('1234567890', '12345678901');
   
   if LBenef.Sucesso then
   begin
      LogCallback('Nome: ' + LBenef.Nome, 'INFO');
      LogCallback('Plano: ' + LBenef.Plano, 'INFO');
      LogCallback('Ativo: ' + BoolToStr(LBenef.Ativo, True), 'INFO');
   end
   else
      LogCallback('Erro: ' + LBenef.Mensagem, 'ERROR');
end;

procedure TDemoEpharma.ExemploAutorizacaoVenda;
var
   LAuth: IPBMAutorizacao;
   LProdutos: TPBMProdutos;
begin
   LogCallback('=== Autorização de Venda ===', 'INFO');
   
   // Monta lista de produtos
   SetLength(LProdutos, 2);
   LProdutos[0] := TPBMProduto.Create('7891234567890', 1, 45.90);
   LProdutos[1] := TPBMProduto.Create('7899876543210', 2, 22.50);
   
   LAuth := FClient.AutorizarVenda(
      '1234567890',           // Carteirinha
      '12345678901',          // CPF
      EncodeDate(1985, 6, 15), // Data nascimento
      LProdutos,              // Produtos
      90.90,                  // Valor total
      'VENDA-' + FormatDateTime('yyyymmddhhnnss', Now) // ID transação
   );
   
   if LAuth.Sucesso then
   begin
      LogCallback('AUTORIZADO!', 'INFO');
      LogCallback('NSU: ' + LAuth.NSU, 'INFO');
      LogCallback('Cód. Autorização: ' + LAuth.CodigoAutorizacao, 'INFO');
      LogCallback('Desconto: ' + FormatCurr('R$ #,##0.00', LAuth.ValorDesconto), 'INFO');
      LogCallback('A Pagar: ' + FormatCurr('R$ #,##0.00', LAuth.ValorAPagar), 'INFO');
   end
   else
      LogCallback('NEGADO: ' + LAuth.Mensagem, 'WARN');
end;

procedure TDemoEpharma.ExemploCancelamento;
var
   LCancel: IPBMCancelamento;
begin
   LogCallback('=== Cancelamento de Venda ===', 'INFO');
   
   LCancel := FClient.CancelarVenda(
      'NSU123456',            // NSU da venda original
      'VENDA-20241215120000', // ID transação original
      'Desistência do cliente' // Motivo
   );
   
   if LCancel.Sucesso then
      LogCallback('Cancelamento confirmado', 'INFO')
   else
      LogCallback('Erro: ' + LCancel.Mensagem, 'ERROR');
end;

procedure TDemoEpharma.ExemploFluxoCompleto;
var
   LBenef: IPBMBeneficiario;
   LAuth: IPBMAutorizacao;
   LProdutos: TPBMProdutos;
   LTransacao: string;
begin
   LogCallback('=== Fluxo Completo de Venda PBM ===', 'INFO');
   
   // 1. Consulta beneficiário
   LBenef := FClient.ConsultarBeneficiario('1234567890');
   
   if not LBenef.Sucesso then
   begin
      LogCallback('Beneficiário não encontrado: ' + LBenef.Mensagem, 'ERROR');
      Exit;
   end;
   
   if not LBenef.Ativo then
   begin
      LogCallback('Beneficiário inativo', 'WARN');
      Exit;
   end;
   
   LogCallback('Beneficiário: ' + LBenef.Nome, 'INFO');
   
   // 2. Monta produtos (seria do PDV real)
   SetLength(LProdutos, 1);
   LProdutos[0] := TPBMProduto.Create('7891234567890', 1, 89.90);
   
   // 3. Autoriza venda
   LTransacao := Format('AIONE-%s-%d', [FormatDateTime('yyyymmdd', Now), Random(999999)]);
   
   LAuth := FClient.AutorizarVenda(
      LBenef.Carteirinha,
      LBenef.CPF,
      EncodeDate(1985, 6, 15), // Pegar do cadastro real
      LProdutos,
      89.90,
      LTransacao
   );
   
   if LAuth.Sucesso then
   begin
      LogCallback('=== VENDA AUTORIZADA ===', 'INFO');
      LogCallback('Guardar no banco:', 'INFO');
      LogCallback('  NSU: ' + LAuth.NSU, 'INFO');
      LogCallback('  Autorização: ' + LAuth.CodigoAutorizacao, 'INFO');
      LogCallback('  Desconto: ' + FormatCurr('R$ #,##0.00', LAuth.ValorDesconto), 'INFO');
      LogCallback('  Cliente paga: ' + FormatCurr('R$ #,##0.00', LAuth.ValorAPagar), 'INFO');
   end
   else
   begin
      LogCallback('VENDA NEGADA: ' + LAuth.Mensagem, 'WARN');
      LogCallback('Código: ' + LAuth.Codigo, 'WARN');
   end;
end;

end.
