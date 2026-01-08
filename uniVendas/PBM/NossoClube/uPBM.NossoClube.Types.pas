unit uPBM.NossoClube.Types;

{------------------------------------------------------------------------------
  Nosso Clube / Cosmos PRO - Rede Nossa Farma
  
  PBM com sistema de fidelização via MONEYBACK (cashback)
  
  Características:
  - Múltiplos programas de benefícios por cliente
  - Sistema Moneyback com percentual de resgate
  - Convênio onde Cosmos arca com parte do valor
  - Suporte a devolução de produtos
  - Integração com Cosmos PRO
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API Nosso Clube / Cosmos</summary>
   TNossoClubeEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://api.cosmospro.com.br/v1';
      PORTAL_PRODUCAO = 'https://portal.nossafarma.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://api-hml.cosmospro.com.br/v1';
      PORTAL_HOMOLOGACAO = 'https://portal-hml.nossafarma.com.br';
      
      // Endpoints REST
      AUTH = '/auth/token';
      CLIENTE_CONSULTA = '/cliente/consultar';
      CLIENTE_CADASTRO = '/cliente/cadastrar';
      CLIENTE_ATUALIZAR = '/cliente/atualizar';
      PROGRAMA_LISTAR = '/programa/listar';
      BENEFICIO_CONSULTAR = '/beneficio/consultar';
      PRODUTO_CONSULTA = '/produto/consultar';
      VENDA_AUTORIZAR = '/venda/autorizar';
      VENDA_CONFIRMAR = '/venda/confirmar';
      VENDA_CANCELAR = '/venda/cancelar';
      VENDA_DEVOLVER = '/venda/devolver';
      MONEYBACK_CONSULTAR = '/moneyback/consultar';
      MONEYBACK_RESGATAR = '/moneyback/resgatar';
   end;

   /// <summary>Status de retorno</summary>
   TNossoClubeStatus = (
      ncsAutorizado,       // Transação autorizada
      ncsNegado,           // Transação negada
      ncsCancelado,        // Transação cancelada
      ncsDevolvido,        // Produto devolvido
      ncsPendente,         // Aguardando confirmação
      ncsErroConexao,      // Erro de conexão
      ncsErroAutenticacao, // Erro de autenticação
      ncsErroValidacao,    // Erro de validação de dados
      ncsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de desconto</summary>
   TNossoClubeTipoDesconto = (
      ntdPercentual,       // Desconto em percentual
      ntdValorFixo,        // Desconto em valor fixo
      ntdPrecoFixo,        // Preço fixo promocional
      ntdMoneyback,        // Desconto via moneyback
      ntdConvenio          // Pago pelo convênio Cosmos
   );

   /// <summary>Tipo de programa de benefício</summary>
   TNossoClubeTipoPrograma = (
      ntpDesconto,         // Desconto direto
      ntpMoneyback,        // Gera moneyback
      ntpConvenio,         // Convênio empresa
      ntpFidelidade,       // Programa fidelidade
      ntpLaboratorio       // Programa do laboratório
   );

   /// <summary>Dados do programa de benefício</summary>
   TNossoClubePrograma = record
      Codigo: string;
      Nome: string;
      Descricao: string;
      TipoPrograma: TNossoClubeTipoPrograma;
      TipoDesconto: TNossoClubeTipoDesconto;
      PercentualDesconto: Double;
      PercentualMoneyback: Double;  // % que vira moneyback
      Laboratorio: string;
      DataInicio: TDateTime;
      DataFim: TDateTime;
      Ativo: Boolean;
      procedure Clear;
   end;

   TNossoClubeProgramas = TArray<TNossoClubePrograma>;

   /// <summary>Benefício disponível para o cliente</summary>
   TNossoClubeBeneficio = record
      CodigoPrograma: string;
      NomePrograma: string;
      CodigoBarras: string;        // EAN do produto
      DescricaoProduto: string;
      PercentualDesconto: Double;
      ValorDesconto: Currency;
      PercentualMoneyback: Double;
      ValorConvenio: Currency;     // Valor pago pelo convênio
      Disponivel: Boolean;
      procedure Clear;
   end;

   TNossoClubeBeneficios = TArray<TNossoClubeBeneficio>;

   /// <summary>Produto com desconto</summary>
   TNossoClubeProduto = record
      CodigoBarras: string;        // EAN 13
      CodigoInterno: string;       // Código interno da farmácia
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;
      ValorMoneyback: Currency;    // Moneyback gerado
      ValorConvenio: Currency;     // Valor pago pelo convênio
      PercentualDesconto: Double;
      TipoDesconto: TNossoClubeTipoDesconto;
      Autorizado: Boolean;
      CodigoPrograma: string;
      NomePrograma: string;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TNossoClubeProduto; static;
   end;

   TNossoClubeProdutos = TArray<TNossoClubeProduto>;

   /// <summary>Dados do cliente fidelizado</summary>
   TNossoClubeCliente = record
      Codigo: string;              // Código na rede
      CPF: string;
      Nome: string;
      DataNascimento: TDateTime;
      Sexo: string;                // M/F
      Telefone: string;
      Celular: string;
      Email: string;
      CEP: string;
      Endereco: string;
      Numero: string;
      Complemento: string;
      Bairro: string;
      Cidade: string;
      UF: string;
      SaldoMoneyback: Currency;    // Saldo disponível em R$
      PercentualResgate: Double;   // % máximo de resgate por compra
      TotalCompras: Currency;      // Total histórico
      UltimaCompra: TDateTime;
      DataCadastro: TDateTime;
      Ativo: Boolean;
      Programas: TNossoClubeProgramas;  // Programas disponíveis
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TNossoClubeEstabelecimento = record
      CNPJ: string;
      CodigoLoja: string;          // Código na rede
      ChaveAPI: string;            // API Key
      SecretKey: string;           // Secret Key
      RazaoSocial: string;
      NomeFantasia: string;
      CodigoRede: string;          // Código da rede Nossa Farma
      UF: string;
      procedure Clear;
   end;

   /// <summary>Dados do operador/atendente</summary>
   TNossoClubeOperador = record
      CPF: string;
      Nome: string;
      Matricula: string;
      CodigoTerminal: string;
      procedure Clear;
   end;

   /// <summary>Token de autenticação</summary>
   TNossoClubeToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de consulta de cliente</summary>
   TNossoClubeClienteRequest = record
      CPF: string;
      Telefone: string;
      Codigo: string;
      procedure Clear;
   end;

   /// <summary>Response de consulta de cliente</summary>
   TNossoClubeClienteResponse = record
      Sucesso: Boolean;
      Status: TNossoClubeStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Cliente: TNossoClubeCliente;
      Beneficios: TNossoClubeBeneficios;
      Encontrado: Boolean;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cadastro de cliente</summary>
   TNossoClubeCadastroClienteRequest = record
      Cliente: TNossoClubeCliente;
      AceitaTermos: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de autorização de venda</summary>
   TNossoClubeAutorizacaoRequest = record
      Cliente: TNossoClubeCliente;
      Operador: TNossoClubeOperador;
      Produtos: TNossoClubeProdutos;
      ValorTotal: Currency;
      NumeroVenda: string;
      NumeroCupom: string;
      DataHoraVenda: TDateTime;
      UsarMoneyback: Boolean;        // Resgatar moneyback
      ValorMoneybackUsar: Currency;  // Quanto usar do moneyback
      ManterDescontosFarmacia: Boolean; // Manter descontos próprios
      ValorConvenio: Currency;       // Valor a cobrar do convênio
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TNossoClubeAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TNossoClubeStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TNossoClubeProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalMoneyback: Currency;   // Moneyback gerado nesta venda
      ValorMoneybackUtilizado: Currency;
      ValorConvenioPago: Currency;     // Valor que Cosmos paga
      ValorTotalFinal: Currency;       // Valor que cliente paga
      SaldoMoneyback: Currency;        // Saldo após a venda
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de confirmação</summary>
   TNossoClubeConfirmacaoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      NumeroCupom: string;
      Operador: TNossoClubeOperador;
      procedure Clear;
   end;

   /// <summary>Response de confirmação</summary>
   TNossoClubeConfirmacaoResponse = record
      Sucesso: Boolean;
      Status: TNossoClubeStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraConfirmacao: TDateTime;
      MoneybackCreditado: Currency;
      SaldoMoneyback: Currency;
      ValorConvenioPago: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TNossoClubeCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Operador: TNossoClubeOperador;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TNossoClubeCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TNossoClubeStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      MoneybackEstornado: Currency;
      SaldoMoneyback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de devolução de produtos</summary>
   TNossoClubeDevolucaoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Produtos: TNossoClubeProdutos;  // Produtos a devolver
      Motivo: string;
      Operador: TNossoClubeOperador;
      procedure Clear;
   end;

   /// <summary>Response de devolução</summary>
   TNossoClubeDevolucaoResponse = record
      Sucesso: Boolean;
      Status: TNossoClubeStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUDevolucao: string;
      DataHoraDevolucao: TDateTime;
      ValorDevolvido: Currency;
      MoneybackEstornado: Currency;
      SaldoMoneyback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns</summary>
   TNossoClubeCodigosRetorno = record
   const
      SUCESSO = '00';
      AUTORIZADO = '01';
      CLIENTE_NAO_ENCONTRADO = '10';
      CLIENTE_INATIVO = '11';
      CPF_INVALIDO = '12';
      CLIENTE_JA_CADASTRADO = '13';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_BENEFICIO = '21';
      QUANTIDADE_INVALIDA = '22';
      PROGRAMA_INATIVO = '30';
      PROGRAMA_EXPIRADO = '31';
      MONEYBACK_INSUFICIENTE = '40';
      PERCENTUAL_RESGATE_EXCEDIDO = '41';
      CONVENIO_NAO_AUTORIZADO = '42';
      TRANSACAO_JA_CANCELADA = '50';
      TRANSACAO_NAO_ENCONTRADA = '51';
      TRANSACAO_JA_CONFIRMADA = '52';
      DEVOLUCAO_NAO_PERMITIDA = '53';
      ESTABELECIMENTO_INVALIDO = '60';
      CREDENCIAIS_INVALIDAS = '61';
      TOKEN_EXPIRADO = '62';
      REDE_NAO_AUTORIZADA = '63';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Cache de clientes consultados</summary>
   TNossoClubeClienteCache = class
   private
      FClientes: TDictionary<string, TNossoClubeCliente>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ACliente: TNossoClubeCliente);
      function Get(const ACPF: string): TNossoClubeCliente;
      function Exists(const ACPF: string): Boolean;
      procedure Clear;
      function Count: Integer;
   end;

   /// <summary>Cache de programas</summary>
   TNossoClubeProgramaCache = class
   private
      FProgramas: TDictionary<string, TNossoClubePrograma>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const APrograma: TNossoClubePrograma);
      function Get(const ACodigo: string): TNossoClubePrograma;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
      function GetAll: TNossoClubeProgramas;
   end;

implementation

{ TNossoClubePrograma }

procedure TNossoClubePrograma.Clear;
begin
   Self := Default(TNossoClubePrograma);
end;

{ TNossoClubeBeneficio }

procedure TNossoClubeBeneficio.Clear;
begin
   Self := Default(TNossoClubeBeneficio);
end;

{ TNossoClubeProduto }

class function TNossoClubeProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TNossoClubeProduto;
begin
   Result := Default(TNossoClubeProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
end;

{ TNossoClubeCliente }

procedure TNossoClubeCliente.Clear;
begin
   Codigo := '';
   CPF := '';
   Nome := '';
   DataNascimento := 0;
   Sexo := '';
   Telefone := '';
   Celular := '';
   Email := '';
   CEP := '';
   Endereco := '';
   Numero := '';
   Complemento := '';
   Bairro := '';
   Cidade := '';
   UF := '';
   SaldoMoneyback := 0;
   PercentualResgate := 0;
   TotalCompras := 0;
   UltimaCompra := 0;
   DataCadastro := 0;
   Ativo := False;
   SetLength(Programas, 0);
end;

{ TNossoClubeEstabelecimento }

procedure TNossoClubeEstabelecimento.Clear;
begin
   Self := Default(TNossoClubeEstabelecimento);
end;

{ TNossoClubeOperador }

procedure TNossoClubeOperador.Clear;
begin
   Self := Default(TNossoClubeOperador);
end;

{ TNossoClubeToken }

function TNossoClubeToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TNossoClubeToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TNossoClubeClienteRequest }

procedure TNossoClubeClienteRequest.Clear;
begin
   CPF := '';
   Telefone := '';
   Codigo := '';
end;

{ TNossoClubeClienteResponse }

procedure TNossoClubeClienteResponse.Clear;
begin
   Sucesso := False;
   Status := ncsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Cliente.Clear;
   SetLength(Beneficios, 0);
   Encontrado := False;
   RawJSON := '';
end;

{ TNossoClubeCadastroClienteRequest }

procedure TNossoClubeCadastroClienteRequest.Clear;
begin
   Cliente.Clear;
   AceitaTermos := False;
end;

{ TNossoClubeAutorizacaoRequest }

procedure TNossoClubeAutorizacaoRequest.Clear;
begin
   Cliente.Clear;
   Operador.Clear;
   SetLength(Produtos, 0);
   ValorTotal := 0;
   NumeroVenda := '';
   NumeroCupom := '';
   DataHoraVenda := 0;
   UsarMoneyback := False;
   ValorMoneybackUsar := 0;
   ManterDescontosFarmacia := False;
   ValorConvenio := 0;
end;

{ TNossoClubeAutorizacaoResponse }

procedure TNossoClubeAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := ncsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalMoneyback := 0;
   ValorMoneybackUtilizado := 0;
   ValorConvenioPago := 0;
   ValorTotalFinal := 0;
   SaldoMoneyback := 0;
   RawJSON := '';
end;

{ TNossoClubeConfirmacaoRequest }

procedure TNossoClubeConfirmacaoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   NumeroCupom := '';
   Operador.Clear;
end;

{ TNossoClubeConfirmacaoResponse }

procedure TNossoClubeConfirmacaoResponse.Clear;
begin
   Sucesso := False;
   Status := ncsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraConfirmacao := 0;
   MoneybackCreditado := 0;
   SaldoMoneyback := 0;
   ValorConvenioPago := 0;
   RawJSON := '';
end;

{ TNossoClubeCancelamentoRequest }

procedure TNossoClubeCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Operador.Clear;
end;

{ TNossoClubeCancelamentoResponse }

procedure TNossoClubeCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := ncsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   MoneybackEstornado := 0;
   SaldoMoneyback := 0;
   RawJSON := '';
end;

{ TNossoClubeDevolucaoRequest }

procedure TNossoClubeDevolucaoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   SetLength(Produtos, 0);
   Motivo := '';
   Operador.Clear;
end;

{ TNossoClubeDevolucaoResponse }

procedure TNossoClubeDevolucaoResponse.Clear;
begin
   Sucesso := False;
   Status := ncsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUDevolucao := '';
   DataHoraDevolucao := 0;
   ValorDevolvido := 0;
   MoneybackEstornado := 0;
   SaldoMoneyback := 0;
   RawJSON := '';
end;

{ TNossoClubeClienteCache }

constructor TNossoClubeClienteCache.Create;
begin
   inherited;
   FClientes := TDictionary<string, TNossoClubeCliente>.Create;
end;

destructor TNossoClubeClienteCache.Destroy;
begin
   FClientes.Free;
   inherited;
end;

procedure TNossoClubeClienteCache.Add(const ACliente: TNossoClubeCliente);
begin
   if ACliente.CPF <> '' then
      FClientes.AddOrSetValue(ACliente.CPF, ACliente);
end;

function TNossoClubeClienteCache.Get(const ACPF: string): TNossoClubeCliente;
begin
   if not FClientes.TryGetValue(ACPF, Result) then
      Result.Clear;
end;

function TNossoClubeClienteCache.Exists(const ACPF: string): Boolean;
begin
   Result := FClientes.ContainsKey(ACPF);
end;

procedure TNossoClubeClienteCache.Clear;
begin
   FClientes.Clear;
end;

function TNossoClubeClienteCache.Count: Integer;
begin
   Result := FClientes.Count;
end;

{ TNossoClubeProgramaCache }

constructor TNossoClubeProgramaCache.Create;
begin
   inherited;
   FProgramas := TDictionary<string, TNossoClubePrograma>.Create;
   FDataAtualizacao := 0;
end;

destructor TNossoClubeProgramaCache.Destroy;
begin
   FProgramas.Free;
   inherited;
end;

procedure TNossoClubeProgramaCache.Add(const APrograma: TNossoClubePrograma);
begin
   FProgramas.AddOrSetValue(APrograma.Codigo, APrograma);
end;

function TNossoClubeProgramaCache.Get(const ACodigo: string): TNossoClubePrograma;
begin
   if not FProgramas.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TNossoClubeProgramaCache.Exists(const ACodigo: string): Boolean;
begin
   Result := FProgramas.ContainsKey(ACodigo);
end;

procedure TNossoClubeProgramaCache.Clear;
begin
   FProgramas.Clear;
   FDataAtualizacao := 0;
end;

function TNossoClubeProgramaCache.Count: Integer;
begin
   Result := FProgramas.Count;
end;

function TNossoClubeProgramaCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TNossoClubeProgramaCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

function TNossoClubeProgramaCache.GetAll: TNossoClubeProgramas;
var
   I: Integer;
   LPair: TPair<string, TNossoClubePrograma>;
begin
   SetLength(Result, FProgramas.Count);
   I := 0;
   for LPair in FProgramas do
   begin
      Result[I] := LPair.Value;
      Inc(I);
   end;
end;

end.
