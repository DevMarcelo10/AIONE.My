unit uPBM.Linkedfarma.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API Linkedfarma</summary>
   TLinkedfarmaEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://api.linkedfarma.com.br/v1';
      PORTAL_PRODUCAO = 'https://portal.linkedfarma.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://api-hml.linkedfarma.com.br/v1';
      PORTAL_HOMOLOGACAO = 'https://portal-hml.linkedfarma.com.br';
      
      // Endpoints REST
      AUTH = '/auth/token';
      CLIENTE_CONSULTA = '/cliente/consultar';
      CLIENTE_CADASTRO = '/cliente/cadastrar';
      PRODUTO_CONSULTA = '/produto/consultar';
      PRODUTO_DESCONTO = '/produto/desconto';
      VENDA_AUTORIZAR = '/venda/autorizar';
      VENDA_CONFIRMAR = '/venda/confirmar';
      VENDA_CANCELAR = '/venda/cancelar';
      VENDA_ESTORNAR = '/venda/estornar';
      PROMOCAO_LISTAR = '/promocao/listar';
      CAMPANHA_LISTAR = '/campanha/listar';
   end;

   /// <summary>Status de retorno Linkedfarma</summary>
   TLinkedfarmaStatus = (
      lfsAutorizado,       // Transação autorizada
      lfsNegado,           // Transação negada
      lfsCancelado,        // Transação cancelada
      lfsEstornado,        // Transação estornada (parcial)
      lfsPendente,         // Aguardando confirmação
      lfsErroConexao,      // Erro de conexão
      lfsErroAutenticacao, // Erro de autenticação
      lfsErroValidacao,    // Erro de validação de dados
      lfsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de desconto</summary>
   TLinkedfarmaTipoDesconto = (
      ltdPercentual,       // Desconto em percentual
      ltdValorFixo,        // Desconto em valor fixo
      ltdPrecoFixo,        // Preço fixo promocional
      ltdCashback          // Cashback para próxima compra
   );

   /// <summary>Tipo de promoção</summary>
   TLinkedfarmaTipoPromocao = (
      ltpDesconto,         // Desconto direto
      ltpLeveXPagueY,      // Leve X pague Y
      ltpBrinde,           // Brinde na compra
      ltpCashback,         // Cashback
      ltpCombo             // Combo de produtos
   );

   /// <summary>Dados da promoção/campanha</summary>
   TLinkedfarmaPromocao = record
      Codigo: string;
      Nome: string;
      Descricao: string;
      TipoPromocao: TLinkedfarmaTipoPromocao;
      TipoDesconto: TLinkedfarmaTipoDesconto;
      ValorDesconto: Currency;
      PercentualDesconto: Double;
      QuantidadeMinima: Integer;
      QuantidadePague: Integer;    // Para LeveXPagueY
      CodigoBarrasBrinde: string;  // EAN do brinde
      DataInicio: TDateTime;
      DataFim: TDateTime;
      Ativo: Boolean;
      procedure Clear;
   end;

   TLinkedfarmaPromocoes = TArray<TLinkedfarmaPromocao>;

   /// <summary>Produto com desconto</summary>
   TLinkedfarmaProduto = record
      CodigoBarras: string;        // EAN 13
      CodigoInterno: string;       // Código interno da farmácia
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;
      PercentualDesconto: Double;
      TipoDesconto: TLinkedfarmaTipoDesconto;
      Autorizado: Boolean;
      CodigoPromocao: string;
      NomePromocao: string;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      Cashback: Currency;          // Cashback gerado
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TLinkedfarmaProduto; static;
   end;

   TLinkedfarmaProdutos = TArray<TLinkedfarmaProduto>;

   /// <summary>Dados do cliente fidelizado</summary>
   TLinkedfarmaCliente = record
      Codigo: string;              // Código no Linkedfarma
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
      SaldoCashback: Currency;     // Saldo disponível
      TotalCompras: Currency;      // Total histórico
      UltimaCompra: TDateTime;
      DataCadastro: TDateTime;
      Ativo: Boolean;
      AceitaNotificacao: Boolean;
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TLinkedfarmaEstabelecimento = record
      CNPJ: string;
      CodigoLoja: string;          // Código no Linkedfarma
      ChaveAPI: string;            // API Key
      SecretKey: string;           // Secret Key
      RazaoSocial: string;
      NomeFantasia: string;
      UF: string;
      procedure Clear;
   end;

   /// <summary>Dados do operador/atendente</summary>
   TLinkedfarmaOperador = record
      CPF: string;
      Nome: string;
      Matricula: string;
      CodigoTerminal: string;
      procedure Clear;
   end;

   /// <summary>Token de autenticação</summary>
   TLinkedfarmaToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de consulta de cliente</summary>
   TLinkedfarmaClienteRequest = record
      CPF: string;
      Telefone: string;
      Codigo: string;
      procedure Clear;
   end;

   /// <summary>Response de consulta de cliente</summary>
   TLinkedfarmaClienteResponse = record
      Sucesso: Boolean;
      Status: TLinkedfarmaStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Cliente: TLinkedfarmaCliente;
      Encontrado: Boolean;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cadastro de cliente</summary>
   TLinkedfarmaCadastroClienteRequest = record
      Cliente: TLinkedfarmaCliente;
      AceitaTermos: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de autorização de venda</summary>
   TLinkedfarmaAutorizacaoRequest = record
      Cliente: TLinkedfarmaCliente;
      Operador: TLinkedfarmaOperador;
      Produtos: TLinkedfarmaProdutos;
      ValorTotal: Currency;
      NumeroVenda: string;
      NumeroCupom: string;
      DataHoraVenda: TDateTime;
      UsarCashback: Boolean;       // Usar saldo de cashback
      ValorCashbackUsar: Currency; // Quanto usar do cashback
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TLinkedfarmaAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TLinkedfarmaStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TLinkedfarmaProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalCashback: Currency;   // Cashback gerado nesta venda
      ValorCashbackUtilizado: Currency; // Cashback usado nesta venda
      ValorTotalFinal: Currency;
      SaldoCashback: Currency;        // Saldo após a venda
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de confirmação</summary>
   TLinkedfarmaConfirmacaoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      NumeroCupom: string;
      Operador: TLinkedfarmaOperador;
      procedure Clear;
   end;

   /// <summary>Response de confirmação</summary>
   TLinkedfarmaConfirmacaoResponse = record
      Sucesso: Boolean;
      Status: TLinkedfarmaStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraConfirmacao: TDateTime;
      CashbackCreditado: Currency;
      SaldoCashback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TLinkedfarmaCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Operador: TLinkedfarmaOperador;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TLinkedfarmaCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TLinkedfarmaStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      CashbackEstornado: Currency;
      SaldoCashback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de estorno parcial</summary>
   TLinkedfarmaEstornoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Produtos: TLinkedfarmaProdutos;  // Produtos a estornar
      Motivo: string;
      Operador: TLinkedfarmaOperador;
      procedure Clear;
   end;

   /// <summary>Response de estorno</summary>
   TLinkedfarmaEstornoResponse = record
      Sucesso: Boolean;
      Status: TLinkedfarmaStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUEstorno: string;
      DataHoraEstorno: TDateTime;
      ValorEstornado: Currency;
      CashbackEstornado: Currency;
      SaldoCashback: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns do Linkedfarma</summary>
   TLinkedfarmaCodigosRetorno = record
   const
      SUCESSO = '00';
      AUTORIZADO = '01';
      CLIENTE_NAO_ENCONTRADO = '10';
      CLIENTE_INATIVO = '11';
      CPF_INVALIDO = '12';
      CLIENTE_JA_CADASTRADO = '13';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_DESCONTO = '21';
      QUANTIDADE_INVALIDA = '22';
      PROMOCAO_INATIVA = '30';
      PROMOCAO_EXPIRADA = '31';
      CASHBACK_INSUFICIENTE = '40';
      VALOR_CASHBACK_INVALIDO = '41';
      TRANSACAO_JA_CANCELADA = '50';
      TRANSACAO_NAO_ENCONTRADA = '51';
      TRANSACAO_JA_CONFIRMADA = '52';
      ESTABELECIMENTO_INVALIDO = '60';
      CREDENCIAIS_INVALIDAS = '61';
      TOKEN_EXPIRADO = '62';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Cache de clientes consultados</summary>
   TLinkedfarmaClienteCache = class
   private
      FClientes: TDictionary<string, TLinkedfarmaCliente>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ACliente: TLinkedfarmaCliente);
      function Get(const ACPF: string): TLinkedfarmaCliente;
      function Exists(const ACPF: string): Boolean;
      procedure Clear;
      function Count: Integer;
   end;

   /// <summary>Cache de promoções</summary>
   TLinkedfarmaProdutoCache = class
   private
      FProdutos: TDictionary<string, TLinkedfarmaPromocao>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ACodigoBarras: string; const APromocao: TLinkedfarmaPromocao);
      function Get(const ACodigoBarras: string): TLinkedfarmaPromocao;
      function TemPromocao(const ACodigoBarras: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
   end;

implementation

{ TLinkedfarmaPromocao }

procedure TLinkedfarmaPromocao.Clear;
begin
   Self := Default(TLinkedfarmaPromocao);
end;

{ TLinkedfarmaProduto }

class function TLinkedfarmaProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TLinkedfarmaProduto;
begin
   Result := Default(TLinkedfarmaProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
end;

{ TLinkedfarmaCliente }

procedure TLinkedfarmaCliente.Clear;
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
   SaldoCashback := 0;
   TotalCompras := 0;
   UltimaCompra := 0;
   DataCadastro := 0;
   Ativo := False;
   AceitaNotificacao := False;
end;

{ TLinkedfarmaEstabelecimento }

procedure TLinkedfarmaEstabelecimento.Clear;
begin
   Self := Default(TLinkedfarmaEstabelecimento);
end;

{ TLinkedfarmaOperador }

procedure TLinkedfarmaOperador.Clear;
begin
   Self := Default(TLinkedfarmaOperador);
end;

{ TLinkedfarmaToken }

function TLinkedfarmaToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TLinkedfarmaToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TLinkedfarmaClienteRequest }

procedure TLinkedfarmaClienteRequest.Clear;
begin
   CPF := '';
   Telefone := '';
   Codigo := '';
end;

{ TLinkedfarmaClienteResponse }

procedure TLinkedfarmaClienteResponse.Clear;
begin
   Sucesso := False;
   Status := lfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Cliente.Clear;
   Encontrado := False;
   RawJSON := '';
end;

{ TLinkedfarmaCadastroClienteRequest }

procedure TLinkedfarmaCadastroClienteRequest.Clear;
begin
   Cliente.Clear;
   AceitaTermos := False;
end;

{ TLinkedfarmaAutorizacaoRequest }

procedure TLinkedfarmaAutorizacaoRequest.Clear;
begin
   Cliente.Clear;
   Operador.Clear;
   SetLength(Produtos, 0);
   ValorTotal := 0;
   NumeroVenda := '';
   NumeroCupom := '';
   DataHoraVenda := 0;
   UsarCashback := False;
   ValorCashbackUsar := 0;
end;

{ TLinkedfarmaAutorizacaoResponse }

procedure TLinkedfarmaAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := lfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalCashback := 0;
   ValorCashbackUtilizado := 0;
   ValorTotalFinal := 0;
   SaldoCashback := 0;
   RawJSON := '';
end;

{ TLinkedfarmaConfirmacaoRequest }

procedure TLinkedfarmaConfirmacaoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   NumeroCupom := '';
   Operador.Clear;
end;

{ TLinkedfarmaConfirmacaoResponse }

procedure TLinkedfarmaConfirmacaoResponse.Clear;
begin
   Sucesso := False;
   Status := lfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraConfirmacao := 0;
   CashbackCreditado := 0;
   SaldoCashback := 0;
   RawJSON := '';
end;

{ TLinkedfarmaCancelamentoRequest }

procedure TLinkedfarmaCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Operador.Clear;
end;

{ TLinkedfarmaCancelamentoResponse }

procedure TLinkedfarmaCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := lfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   CashbackEstornado := 0;
   SaldoCashback := 0;
   RawJSON := '';
end;

{ TLinkedfarmaEstornoRequest }

procedure TLinkedfarmaEstornoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   SetLength(Produtos, 0);
   Motivo := '';
   Operador.Clear;
end;

{ TLinkedfarmaEstornoResponse }

procedure TLinkedfarmaEstornoResponse.Clear;
begin
   Sucesso := False;
   Status := lfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUEstorno := '';
   DataHoraEstorno := 0;
   ValorEstornado := 0;
   CashbackEstornado := 0;
   SaldoCashback := 0;
   RawJSON := '';
end;

{ TLinkedfarmaClienteCache }

constructor TLinkedfarmaClienteCache.Create;
begin
   inherited;
   FClientes := TDictionary<string, TLinkedfarmaCliente>.Create;
end;

destructor TLinkedfarmaClienteCache.Destroy;
begin
   FClientes.Free;
   inherited;
end;

procedure TLinkedfarmaClienteCache.Add(const ACliente: TLinkedfarmaCliente);
begin
   if ACliente.CPF <> '' then
      FClientes.AddOrSetValue(ACliente.CPF, ACliente);
end;

function TLinkedfarmaClienteCache.Get(const ACPF: string): TLinkedfarmaCliente;
begin
   if not FClientes.TryGetValue(ACPF, Result) then
      Result.Clear;
end;

function TLinkedfarmaClienteCache.Exists(const ACPF: string): Boolean;
begin
   Result := FClientes.ContainsKey(ACPF);
end;

procedure TLinkedfarmaClienteCache.Clear;
begin
   FClientes.Clear;
end;

function TLinkedfarmaClienteCache.Count: Integer;
begin
   Result := FClientes.Count;
end;

{ TLinkedfarmaProdutoCache }

constructor TLinkedfarmaProdutoCache.Create;
begin
   inherited;
   FProdutos := TDictionary<string, TLinkedfarmaPromocao>.Create;
   FDataAtualizacao := 0;
end;

destructor TLinkedfarmaProdutoCache.Destroy;
begin
   FProdutos.Free;
   inherited;
end;

procedure TLinkedfarmaProdutoCache.Add(const ACodigoBarras: string;
   const APromocao: TLinkedfarmaPromocao);
begin
   FProdutos.AddOrSetValue(ACodigoBarras, APromocao);
end;

function TLinkedfarmaProdutoCache.Get(const ACodigoBarras: string): TLinkedfarmaPromocao;
begin
   if not FProdutos.TryGetValue(ACodigoBarras, Result) then
      Result.Clear;
end;

function TLinkedfarmaProdutoCache.TemPromocao(const ACodigoBarras: string): Boolean;
begin
   Result := FProdutos.ContainsKey(ACodigoBarras);
end;

procedure TLinkedfarmaProdutoCache.Clear;
begin
   FProdutos.Clear;
   FDataAtualizacao := 0;
end;

function TLinkedfarmaProdutoCache.Count: Integer;
begin
   Result := FProdutos.Count;
end;

function TLinkedfarmaProdutoCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TLinkedfarmaProdutoCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

end.
