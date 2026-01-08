unit uPBM.FuncionalCard.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API Funcional Card</summary>
   TFuncionalEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://gateway.funcionalcard.com.br/api/v1';
      PORTAL_PRODUCAO = 'https://autorizador.funcionalcard.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://gateway-hml.funcionalcard.com.br/api/v1';
      PORTAL_HOMOLOGACAO = 'https://autorizador-hml.funcionalcard.com.br';
      
      // Endpoints
      AUTH = '/auth/login';
      ELEGIBILIDADE = '/beneficiario/elegibilidade';
      PRE_AUTORIZACAO = '/transacao/pre-autorizar';
      AUTORIZACAO = '/transacao/autorizar';
      CONFIRMACAO = '/transacao/confirmar';
      CANCELAMENTO = '/transacao/cancelar';
      CONSULTA_PRODUTO = '/produto/consultar';
      CONSULTA_TRANSACAO = '/transacao/consultar';
      ANEXAR_RECEITA = '/transacao/receita';
   end;

   /// <summary>Status de retorno Funcional Card</summary>
   TFuncionalStatus = (
      fsAutorizado,       // Transação autorizada
      fsPreAutorizado,    // Pré-autorização concedida (aguarda confirmação)
      fsNegado,           // Transação negada
      fsCancelado,        // Transação cancelada
      fsPendente,         // Aguardando processamento
      fsErroConexao,      // Erro de conexão
      fsErroAutenticacao, // Erro de autenticação
      fsErroValidacao,    // Erro de validação de dados
      fsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de convênio/programa</summary>
   TFuncionalTipoConvenio = (
      tcCorporativo,      // Convênio empresa (desconto em folha)
      tcIndustria,        // Programa de indústria (desconto PBM)
      tcMisto             // Ambos os tipos
   );

   /// <summary>Tipo de pagamento</summary>
   TFuncionalTipoPagamento = (
      tpAVista,           // Pagamento à vista na farmácia
      tpFolha,            // Desconto em folha de pagamento
      tpMisto             // Parte à vista, parte em folha
   );

   /// <summary>Dados do convênio/programa</summary>
   TFuncionalConvenio = record
      Codigo: string;
      Nome: string;
      Tipo: TFuncionalTipoConvenio;
      EmpresaPagadora: string;
      CNPJ: string;
      class function Create(const ACodigo, ANome: string; ATipo: TFuncionalTipoConvenio): TFuncionalConvenio; static;
      procedure Clear;
   end;

   /// <summary>Produto para autorização</summary>
   TFuncionalProduto = record
      CodigoBarras: string;     // EAN 13
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorSubsidio: Currency;  // Valor pago pela empresa/indústria
      ValorBeneficiario: Currency; // Valor pago pelo beneficiário
      PercentualDesconto: Double;
      Autorizado: Boolean;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      RequerReceita: Boolean;   // Se exige receita médica
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TFuncionalProduto; static;
   end;

   TFuncionalProdutos = TArray<TFuncionalProduto>;

   /// <summary>Dados do beneficiário/titular</summary>
   TFuncionalBeneficiario = record
      NumeroCartao: string;     // Número do cartão Funcional
      CPF: string;
      Nome: string;
      DataNascimento: TDateTime;
      Matricula: string;        // Matrícula na empresa
      Convenio: TFuncionalConvenio;
      Ativo: Boolean;
      TipoPagamento: TFuncionalTipoPagamento;
      LimiteDisponivel: Currency;
      procedure Clear;
   end;

   /// <summary>Dados da receita médica</summary>
   TFuncionalReceita = record
      CRM: string;
      UFMedico: string;
      NomeMedico: string;
      DataReceita: TDateTime;
      NumeroReceita: string;
      ArquivoBase64: string;    // Imagem da receita em Base64
      NomeArquivo: string;
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TFuncionalEstabelecimento = record
      CNPJ: string;
      CodigoLoja: string;       // Código no Funcional Card
      RazaoSocial: string;
      Usuario: string;          // Login Gateway/Autorizador Web
      Senha: string;            // Senha Gateway/Autorizador Web
      procedure Clear;
   end;

   /// <summary>Dados do vendedor/atendente</summary>
   TFuncionalVendedor = record
      CPF: string;
      Nome: string;
      Matricula: string;
      procedure Clear;
   end;

   /// <summary>Token de sessão</summary>
   TFuncionalToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;       // Segundos
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de elegibilidade</summary>
   TFuncionalElegibilidadeRequest = record
      NumeroCartao: string;
      CPF: string;
      procedure Clear;
   end;

   /// <summary>Response de elegibilidade</summary>
   TFuncionalElegibilidadeResponse = record
      Sucesso: Boolean;
      Status: TFuncionalStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Beneficiario: TFuncionalBeneficiario;
      Elegivel: Boolean;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de pré-autorização</summary>
   TFuncionalPreAutorizacaoRequest = record
      Beneficiario: TFuncionalBeneficiario;
      Vendedor: TFuncionalVendedor;
      Produtos: TFuncionalProdutos;
      Receita: TFuncionalReceita;
      ValorTotal: Currency;
      NumeroVenda: string;
      DataHoraVenda: TDateTime;
      InformarReceita: Boolean;
      procedure Clear;
   end;

   /// <summary>Response de pré-autorização</summary>
   TFuncionalPreAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TFuncionalStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NumeroAutorizacao: string;   // Número para confirmar/concluir
      CodigoTransacao: string;
      DataHoraPreAutorizacao: TDateTime;
      Produtos: TFuncionalProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalSubsidio: Currency;
      ValorTotalBeneficiario: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de confirmação (após pré-autorização)</summary>
   TFuncionalConfirmacaoRequest = record
      NumeroAutorizacao: string;
      CodigoTransacao: string;
      NumeroVenda: string;
      Vendedor: TFuncionalVendedor;
      procedure Clear;
   end;

   /// <summary>Response de confirmação</summary>
   TFuncionalConfirmacaoResponse = record
      Sucesso: Boolean;
      Status: TFuncionalStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;                  // NSU definitivo
      CodigoAutorizacao: string;
      DataHoraConfirmacao: TDateTime;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TFuncionalCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Vendedor: TFuncionalVendedor;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TFuncionalCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TFuncionalStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns do Funcional Card</summary>
   TFuncionalCodigosRetorno = record
   const
      SUCESSO = '00';
      PRE_AUTORIZADO = '01';
      BENEFICIARIO_NAO_ENCONTRADO = '10';
      BENEFICIARIO_INATIVO = '11';
      CARTAO_BLOQUEADO = '12';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_COBERTURA = '21';
      LIMITE_EXCEDIDO = '30';
      RECEITA_OBRIGATORIA = '40';
      RECEITA_VENCIDA = '41';
      TRANSACAO_JA_CONFIRMADA = '50';
      TRANSACAO_JA_CANCELADA = '51';
      TRANSACAO_NAO_ENCONTRADA = '52';
      TRANSACAO_EXPIRADA = '53';
      ERRO_AUTENTICACAO = '90';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

implementation

{ TFuncionalConvenio }

class function TFuncionalConvenio.Create(const ACodigo, ANome: string;
   ATipo: TFuncionalTipoConvenio): TFuncionalConvenio;
begin
   Result.Codigo := ACodigo;
   Result.Nome := ANome;
   Result.Tipo := ATipo;
   Result.EmpresaPagadora := '';
   Result.CNPJ := '';
end;

procedure TFuncionalConvenio.Clear;
begin
   Self := Default(TFuncionalConvenio);
end;

{ TFuncionalProduto }

class function TFuncionalProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TFuncionalProduto;
begin
   Result := Default(TFuncionalProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
   Result.RequerReceita := False;
end;

{ TFuncionalBeneficiario }

procedure TFuncionalBeneficiario.Clear;
begin
   NumeroCartao := '';
   CPF := '';
   Nome := '';
   DataNascimento := 0;
   Matricula := '';
   Convenio.Clear;
   Ativo := False;
   TipoPagamento := tpFolha;
   LimiteDisponivel := 0;
end;

{ TFuncionalReceita }

procedure TFuncionalReceita.Clear;
begin
   Self := Default(TFuncionalReceita);
end;

{ TFuncionalEstabelecimento }

procedure TFuncionalEstabelecimento.Clear;
begin
   Self := Default(TFuncionalEstabelecimento);
end;

{ TFuncionalVendedor }

procedure TFuncionalVendedor.Clear;
begin
   Self := Default(TFuncionalVendedor);
end;

{ TFuncionalToken }

function TFuncionalToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TFuncionalToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TFuncionalElegibilidadeRequest }

procedure TFuncionalElegibilidadeRequest.Clear;
begin
   NumeroCartao := '';
   CPF := '';
end;

{ TFuncionalElegibilidadeResponse }

procedure TFuncionalElegibilidadeResponse.Clear;
begin
   Sucesso := False;
   Status := fsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Beneficiario.Clear;
   Elegivel := False;
   RawJSON := '';
end;

{ TFuncionalPreAutorizacaoRequest }

procedure TFuncionalPreAutorizacaoRequest.Clear;
begin
   Beneficiario.Clear;
   Vendedor.Clear;
   SetLength(Produtos, 0);
   Receita.Clear;
   ValorTotal := 0;
   NumeroVenda := '';
   DataHoraVenda := 0;
   InformarReceita := False;
end;

{ TFuncionalPreAutorizacaoResponse }

procedure TFuncionalPreAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := fsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NumeroAutorizacao := '';
   CodigoTransacao := '';
   DataHoraPreAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalSubsidio := 0;
   ValorTotalBeneficiario := 0;
   RawJSON := '';
end;

{ TFuncionalConfirmacaoRequest }

procedure TFuncionalConfirmacaoRequest.Clear;
begin
   NumeroAutorizacao := '';
   CodigoTransacao := '';
   NumeroVenda := '';
   Vendedor.Clear;
end;

{ TFuncionalConfirmacaoResponse }

procedure TFuncionalConfirmacaoResponse.Clear;
begin
   Sucesso := False;
   Status := fsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   CodigoAutorizacao := '';
   DataHoraConfirmacao := 0;
   RawJSON := '';
end;

{ TFuncionalCancelamentoRequest }

procedure TFuncionalCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Vendedor.Clear;
end;

{ TFuncionalCancelamentoResponse }

procedure TFuncionalCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := fsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   RawJSON := '';
end;

end.
