unit uPBM.Ellomais.Types;

{------------------------------------------------------------------------------
  Ellomais / Facillite - Redes Associativistas de Drogarias
  
  Ellomais: Grupo formado em 2009 pela união de 6 bandeiras de drogarias
  Facillite: Rede focada em fidelização, originada no Espírito Santo
  
  Ambas compartilham a mesma estrutura de API, diferenciadas pelo endpoint.
  Descontos em mais de 3.000 medicamentos.
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Identificador da rede (Ellomais ou Facillite)</summary>
   TEllomaisRede = (
      erEllomais,
      erFacillite
   );

   /// <summary>Endpoints da API Ellomais/Facillite</summary>
   TEllomaisEndpoints = record
   const
      // Ellomais - Produção
      ELLOMAIS_PRODUCAO_URL = 'https://api.ellomais.com.br/v1';
      ELLOMAIS_PORTAL = 'https://portal.ellomais.com.br';
      
      // Ellomais - Homologação
      ELLOMAIS_HOMOLOGACAO_URL = 'https://api-hml.ellomais.com.br/v1';
      
      // Facillite - Produção
      FACILLITE_PRODUCAO_URL = 'https://api.facillite.com.br/v1';
      FACILLITE_PORTAL = 'https://portal.facillite.com.br';
      
      // Facillite - Homologação
      FACILLITE_HOMOLOGACAO_URL = 'https://api-hml.facillite.com.br/v1';
      
      // Endpoints REST (comuns a ambas)
      AUTH = '/auth/token';
      CLIENTE_CONSULTA = '/cliente/consultar';
      CLIENTE_CADASTRO = '/cliente/cadastrar';
      CLIENTE_ATUALIZAR = '/cliente/atualizar';
      PRODUTO_CONSULTA = '/produto/consultar';
      PRODUTO_DESCONTO = '/produto/desconto';
      VENDA_AUTORIZAR = '/venda/autorizar';
      VENDA_CONFIRMAR = '/venda/confirmar';
      VENDA_CANCELAR = '/venda/cancelar';
      CAMPANHA_LISTAR = '/campanha/listar';
      SALDO_CONSULTAR = '/saldo/consultar';
   end;

   /// <summary>Status de retorno</summary>
   TEllomaisStatus = (
      emsAutorizado,       // Transação autorizada
      emsNegado,           // Transação negada
      emsCancelado,        // Transação cancelada
      emsPendente,         // Aguardando confirmação
      emsErroConexao,      // Erro de conexão
      emsErroAutenticacao, // Erro de autenticação
      emsErroValidacao,    // Erro de validação de dados
      emsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de desconto</summary>
   TEllomaisTipoDesconto = (
      etdPercentual,       // Desconto em percentual
      etdValorFixo,        // Desconto em valor fixo
      etdPrecoFixo,        // Preço fixo promocional
      etdPontos            // Desconto via pontos
   );

   /// <summary>Tipo de campanha</summary>
   TEllomaisTipoCampanha = (
      etcDesconto,         // Desconto direto
      etcPontos,           // Acúmulo de pontos
      etcCashback,         // Cashback
      etcBrinde,           // Brinde na compra
      etcLeveXPagueY       // Leve X pague Y
   );

   /// <summary>Dados da campanha promocional</summary>
   TEllomaisCampanha = record
      Codigo: string;
      Nome: string;
      Descricao: string;
      TipoCampanha: TEllomaisTipoCampanha;
      TipoDesconto: TEllomaisTipoDesconto;
      ValorDesconto: Currency;
      PercentualDesconto: Double;
      PontosNecessarios: Integer;  // Para resgate
      PontosGerados: Integer;      // Por compra
      DataInicio: TDateTime;
      DataFim: TDateTime;
      Ativo: Boolean;
      procedure Clear;
   end;

   TEllomaisCampanhas = TArray<TEllomaisCampanha>;

   /// <summary>Produto com desconto</summary>
   TEllomaisProduto = record
      CodigoBarras: string;        // EAN 13
      CodigoInterno: string;       // Código interno da farmácia
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;
      PercentualDesconto: Double;
      TipoDesconto: TEllomaisTipoDesconto;
      Autorizado: Boolean;
      CodigoCampanha: string;
      NomeCampanha: string;
      PontosGerados: Integer;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TEllomaisProduto; static;
   end;

   TEllomaisProdutos = TArray<TEllomaisProduto>;

   /// <summary>Dados do cliente fidelizado</summary>
   TEllomaisCliente = record
      Codigo: string;              // Código na rede
      NumeroCartao: string;        // Número do cartão fidelidade
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
      SaldoPontos: Integer;        // Pontos acumulados
      SaldoCashback: Currency;     // Saldo de cashback
      TotalCompras: Currency;      // Total histórico
      UltimaCompra: TDateTime;
      DataCadastro: TDateTime;
      Ativo: Boolean;
      AceitaPromocoes: Boolean;
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TEllomaisEstabelecimento = record
      CNPJ: string;
      CodigoLoja: string;          // Código na rede
      ChaveAPI: string;            // API Key
      SecretKey: string;           // Secret Key
      RazaoSocial: string;
      NomeFantasia: string;
      Rede: TEllomaisRede;         // Ellomais ou Facillite
      UF: string;
      procedure Clear;
   end;

   /// <summary>Dados do operador/atendente</summary>
   TEllomaisOperador = record
      CPF: string;
      Nome: string;
      Matricula: string;
      CodigoTerminal: string;
      procedure Clear;
   end;

   /// <summary>Token de autenticação</summary>
   TEllomaisToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de consulta de cliente</summary>
   TEllomaisClienteRequest = record
      CPF: string;
      NumeroCartao: string;
      Telefone: string;
      procedure Clear;
   end;

   /// <summary>Response de consulta de cliente</summary>
   TEllomaisClienteResponse = record
      Sucesso: Boolean;
      Status: TEllomaisStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Cliente: TEllomaisCliente;
      Encontrado: Boolean;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cadastro de cliente</summary>
   TEllomaisCadastroClienteRequest = record
      Cliente: TEllomaisCliente;
      AceitaTermos: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de autorização de venda</summary>
   TEllomaisAutorizacaoRequest = record
      Cliente: TEllomaisCliente;
      Operador: TEllomaisOperador;
      Produtos: TEllomaisProdutos;
      ValorTotal: Currency;
      NumeroVenda: string;
      NumeroCupom: string;
      DataHoraVenda: TDateTime;
      UsarPontos: Boolean;         // Usar saldo de pontos
      PontosUsar: Integer;         // Quantos pontos usar
      UsarCashback: Boolean;       // Usar saldo de cashback
      ValorCashbackUsar: Currency; // Quanto usar
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TEllomaisAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TEllomaisStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TEllomaisProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      PontosGerados: Integer;
      PontosUtilizados: Integer;
      CashbackGerado: Currency;
      CashbackUtilizado: Currency;
      SaldoPontos: Integer;
      SaldoCashback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de confirmação</summary>
   TEllomaisConfirmacaoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      NumeroCupom: string;
      Operador: TEllomaisOperador;
      procedure Clear;
   end;

   /// <summary>Response de confirmação</summary>
   TEllomaisConfirmacaoResponse = record
      Sucesso: Boolean;
      Status: TEllomaisStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraConfirmacao: TDateTime;
      PontosCreditados: Integer;
      CashbackCreditado: Currency;
      SaldoPontos: Integer;
      SaldoCashback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TEllomaisCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Operador: TEllomaisOperador;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TEllomaisCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TEllomaisStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      PontosEstornados: Integer;
      CashbackEstornado: Currency;
      SaldoPontos: Integer;
      SaldoCashback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns</summary>
   TEllomaisCodigosRetorno = record
   const
      SUCESSO = '00';
      AUTORIZADO = '01';
      CLIENTE_NAO_ENCONTRADO = '10';
      CLIENTE_INATIVO = '11';
      CPF_INVALIDO = '12';
      CARTAO_INVALIDO = '13';
      CLIENTE_JA_CADASTRADO = '14';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_DESCONTO = '21';
      QUANTIDADE_INVALIDA = '22';
      CAMPANHA_INATIVA = '30';
      CAMPANHA_EXPIRADA = '31';
      PONTOS_INSUFICIENTES = '40';
      CASHBACK_INSUFICIENTE = '41';
      TRANSACAO_JA_CANCELADA = '50';
      TRANSACAO_NAO_ENCONTRADA = '51';
      TRANSACAO_JA_CONFIRMADA = '52';
      ESTABELECIMENTO_INVALIDO = '60';
      CREDENCIAIS_INVALIDAS = '61';
      TOKEN_EXPIRADO = '62';
      REDE_NAO_AUTORIZADA = '63';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Cache de clientes consultados</summary>
   TEllomaisClienteCache = class
   private
      FClientes: TDictionary<string, TEllomaisCliente>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ACliente: TEllomaisCliente);
      function Get(const ACPF: string): TEllomaisCliente;
      function GetByCartao(const ANumeroCartao: string): TEllomaisCliente;
      function Exists(const ACPF: string): Boolean;
      procedure Clear;
      function Count: Integer;
   end;

   /// <summary>Cache de campanhas</summary>
   TEllomaisCampanhaCache = class
   private
      FCampanhas: TDictionary<string, TEllomaisCampanha>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ACampanha: TEllomaisCampanha);
      function Get(const ACodigo: string): TEllomaisCampanha;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
      function GetAll: TEllomaisCampanhas;
   end;

implementation

{ TEllomaisCampanha }

procedure TEllomaisCampanha.Clear;
begin
   Self := Default(TEllomaisCampanha);
end;

{ TEllomaisProduto }

class function TEllomaisProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TEllomaisProduto;
begin
   Result := Default(TEllomaisProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
end;

{ TEllomaisCliente }

procedure TEllomaisCliente.Clear;
begin
   Codigo := '';
   NumeroCartao := '';
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
   SaldoPontos := 0;
   SaldoCashback := 0;
   TotalCompras := 0;
   UltimaCompra := 0;
   DataCadastro := 0;
   Ativo := False;
   AceitaPromocoes := False;
end;

{ TEllomaisEstabelecimento }

procedure TEllomaisEstabelecimento.Clear;
begin
   Self := Default(TEllomaisEstabelecimento);
end;

{ TEllomaisOperador }

procedure TEllomaisOperador.Clear;
begin
   Self := Default(TEllomaisOperador);
end;

{ TEllomaisToken }

function TEllomaisToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TEllomaisToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TEllomaisClienteRequest }

procedure TEllomaisClienteRequest.Clear;
begin
   CPF := '';
   NumeroCartao := '';
   Telefone := '';
end;

{ TEllomaisClienteResponse }

procedure TEllomaisClienteResponse.Clear;
begin
   Sucesso := False;
   Status := emsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Cliente.Clear;
   Encontrado := False;
   RawJSON := '';
end;

{ TEllomaisCadastroClienteRequest }

procedure TEllomaisCadastroClienteRequest.Clear;
begin
   Cliente.Clear;
   AceitaTermos := False;
end;

{ TEllomaisAutorizacaoRequest }

procedure TEllomaisAutorizacaoRequest.Clear;
begin
   Cliente.Clear;
   Operador.Clear;
   SetLength(Produtos, 0);
   ValorTotal := 0;
   NumeroVenda := '';
   NumeroCupom := '';
   DataHoraVenda := 0;
   UsarPontos := False;
   PontosUsar := 0;
   UsarCashback := False;
   ValorCashbackUsar := 0;
end;

{ TEllomaisAutorizacaoResponse }

procedure TEllomaisAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := emsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   PontosGerados := 0;
   PontosUtilizados := 0;
   CashbackGerado := 0;
   CashbackUtilizado := 0;
   SaldoPontos := 0;
   SaldoCashback := 0;
   RawJSON := '';
end;

{ TEllomaisConfirmacaoRequest }

procedure TEllomaisConfirmacaoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   NumeroCupom := '';
   Operador.Clear;
end;

{ TEllomaisConfirmacaoResponse }

procedure TEllomaisConfirmacaoResponse.Clear;
begin
   Sucesso := False;
   Status := emsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraConfirmacao := 0;
   PontosCreditados := 0;
   CashbackCreditado := 0;
   SaldoPontos := 0;
   SaldoCashback := 0;
   RawJSON := '';
end;

{ TEllomaisCancelamentoRequest }

procedure TEllomaisCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Operador.Clear;
end;

{ TEllomaisCancelamentoResponse }

procedure TEllomaisCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := emsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   PontosEstornados := 0;
   CashbackEstornado := 0;
   SaldoPontos := 0;
   SaldoCashback := 0;
   RawJSON := '';
end;

{ TEllomaisClienteCache }

constructor TEllomaisClienteCache.Create;
begin
   inherited;
   FClientes := TDictionary<string, TEllomaisCliente>.Create;
end;

destructor TEllomaisClienteCache.Destroy;
begin
   FClientes.Free;
   inherited;
end;

procedure TEllomaisClienteCache.Add(const ACliente: TEllomaisCliente);
begin
   if ACliente.CPF <> '' then
      FClientes.AddOrSetValue(ACliente.CPF, ACliente);
   if ACliente.NumeroCartao <> '' then
      FClientes.AddOrSetValue('CARTAO:' + ACliente.NumeroCartao, ACliente);
end;

function TEllomaisClienteCache.Get(const ACPF: string): TEllomaisCliente;
begin
   if not FClientes.TryGetValue(ACPF, Result) then
      Result.Clear;
end;

function TEllomaisClienteCache.GetByCartao(const ANumeroCartao: string): TEllomaisCliente;
begin
   if not FClientes.TryGetValue('CARTAO:' + ANumeroCartao, Result) then
      Result.Clear;
end;

function TEllomaisClienteCache.Exists(const ACPF: string): Boolean;
begin
   Result := FClientes.ContainsKey(ACPF);
end;

procedure TEllomaisClienteCache.Clear;
begin
   FClientes.Clear;
end;

function TEllomaisClienteCache.Count: Integer;
begin
   Result := FClientes.Count;
end;

{ TEllomaisCampanhaCache }

constructor TEllomaisCampanhaCache.Create;
begin
   inherited;
   FCampanhas := TDictionary<string, TEllomaisCampanha>.Create;
   FDataAtualizacao := 0;
end;

destructor TEllomaisCampanhaCache.Destroy;
begin
   FCampanhas.Free;
   inherited;
end;

procedure TEllomaisCampanhaCache.Add(const ACampanha: TEllomaisCampanha);
begin
   FCampanhas.AddOrSetValue(ACampanha.Codigo, ACampanha);
end;

function TEllomaisCampanhaCache.Get(const ACodigo: string): TEllomaisCampanha;
begin
   if not FCampanhas.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TEllomaisCampanhaCache.Exists(const ACodigo: string): Boolean;
begin
   Result := FCampanhas.ContainsKey(ACodigo);
end;

procedure TEllomaisCampanhaCache.Clear;
begin
   FCampanhas.Clear;
   FDataAtualizacao := 0;
end;

function TEllomaisCampanhaCache.Count: Integer;
begin
   Result := FCampanhas.Count;
end;

function TEllomaisCampanhaCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TEllomaisCampanhaCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

function TEllomaisCampanhaCache.GetAll: TEllomaisCampanhas;
var
   I: Integer;
   LPair: TPair<string, TEllomaisCampanha>;
begin
   SetLength(Result, FCampanhas.Count);
   I := 0;
   for LPair in FCampanhas do
   begin
      Result[I] := LPair.Value;
      Inc(I);
   end;
end;

end.
