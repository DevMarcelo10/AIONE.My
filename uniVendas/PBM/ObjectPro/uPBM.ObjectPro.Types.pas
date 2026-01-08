unit uPBM.ObjectPro.Types;

{------------------------------------------------------------------------------
  Object Pro - Programa de Relacionamento Contínuo
  
  Sistema de fidelização para farmácias com foco em:
  - Descontos contínuos em medicamentos
  - Programa de relacionamento com pacientes
  - TOP Venda / Vendedor Show (gamificação)
  - Canal exclusivo com dicas de saúde
  
  Portal criado em 2016 para descomplicar o trabalho das farmácias
  Contato para credenciamento: (31) 99114-3312
------------------------------------------------------------------------------}

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API Object Pro</summary>
   TObjectProEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://api.objectpro.com.br/v1';
      PORTAL_PRODUCAO = 'https://portal.objectpro.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://api-hml.objectpro.com.br/v1';
      PORTAL_HOMOLOGACAO = 'https://portal-hml.objectpro.com.br';
      
      // Endpoints REST
      AUTH = '/auth/token';
      CLIENTE_CONSULTA = '/cliente/consultar';
      CLIENTE_CADASTRO = '/cliente/cadastrar';
      CLIENTE_ATUALIZAR = '/cliente/atualizar';
      PRODUTO_CONSULTA = '/produto/consultar';
      PRODUTO_DESCONTO = '/produto/desconto';
      PROGRAMA_LISTAR = '/programa/listar';
      VENDA_AUTORIZAR = '/venda/autorizar';
      VENDA_CONFIRMAR = '/venda/confirmar';
      VENDA_CANCELAR = '/venda/cancelar';
      RANKING_VENDEDOR = '/ranking/vendedor';
      RANKING_LOJA = '/ranking/loja';
      META_CONSULTAR = '/meta/consultar';
   end;

   /// <summary>Status de retorno</summary>
   TObjectProStatus = (
      opsAutorizado,       // Transação autorizada
      opsNegado,           // Transação negada
      opsCancelado,        // Transação cancelada
      opsPendente,         // Aguardando confirmação
      opsErroConexao,      // Erro de conexão
      opsErroAutenticacao, // Erro de autenticação
      opsErroValidacao,    // Erro de validação de dados
      opsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de desconto</summary>
   TObjectProTipoDesconto = (
      otdPercentual,       // Desconto em percentual
      otdValorFixo,        // Desconto em valor fixo
      otdPrecoFixo,        // Preço fixo promocional
      otdProgressivo       // Desconto progressivo por quantidade
   );

   /// <summary>Tipo de programa</summary>
   TObjectProTipoPrograma = (
      otpDesconto,         // Desconto direto
      otpFidelidade,       // Programa fidelidade
      otpLaboratorio,      // Programa do laboratório
      otpTopVenda,         // TOP Venda (gamificação)
      otpRelacionamento    // Relacionamento contínuo
   );

   /// <summary>Dados do programa de benefício</summary>
   TObjectProPrograma = record
      Codigo: string;
      Nome: string;
      Descricao: string;
      TipoPrograma: TObjectProTipoPrograma;
      TipoDesconto: TObjectProTipoDesconto;
      PercentualDesconto: Double;
      PercentualDescontoMax: Double;  // Desconto máximo progressivo
      Laboratorio: string;
      DataInicio: TDateTime;
      DataFim: TDateTime;
      Ativo: Boolean;
      PontosVenda: Integer;           // Pontos para ranking TOP Venda
      procedure Clear;
   end;

   TObjectProProgramas = TArray<TObjectProPrograma>;

   /// <summary>Produto com desconto</summary>
   TObjectProProduto = record
      CodigoBarras: string;        // EAN 13
      CodigoInterno: string;       // Código interno da farmácia
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;
      PercentualDesconto: Double;
      TipoDesconto: TObjectProTipoDesconto;
      Autorizado: Boolean;
      CodigoPrograma: string;
      NomePrograma: string;
      PontosGerados: Integer;      // Pontos TOP Venda
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TObjectProProduto; static;
   end;

   TObjectProProdutos = TArray<TObjectProProduto>;

   /// <summary>Dados do cliente fidelizado</summary>
   TObjectProCliente = record
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
      TotalCompras: Currency;      // Total histórico
      TotalDescontos: Currency;    // Total de descontos obtidos
      ComprasNoMes: Integer;       // Qtd compras no mês
      UltimaCompra: TDateTime;
      DataCadastro: TDateTime;
      Ativo: Boolean;
      AceitaContato: Boolean;      // Aceita contato para relacionamento
      Programas: TObjectProProgramas;
      procedure Clear;
   end;

   /// <summary>Dados do vendedor para ranking</summary>
   TObjectProVendedor = record
      CPF: string;
      Nome: string;
      Matricula: string;
      CodigoTerminal: string;
      PontosAcumulados: Integer;
      PontosMes: Integer;
      RankingMes: Integer;
      MetaMes: Currency;
      VendasMes: Currency;
      PercentualMeta: Double;
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TObjectProEstabelecimento = record
      CNPJ: string;
      CodigoLoja: string;          // Código na rede
      ChaveAPI: string;            // API Key
      SecretKey: string;           // Secret Key
      RazaoSocial: string;
      NomeFantasia: string;
      UF: string;
      procedure Clear;
   end;

   /// <summary>Token de autenticação</summary>
   TObjectProToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de consulta de cliente</summary>
   TObjectProClienteRequest = record
      CPF: string;
      Telefone: string;
      Codigo: string;
      procedure Clear;
   end;

   /// <summary>Response de consulta de cliente</summary>
   TObjectProClienteResponse = record
      Sucesso: Boolean;
      Status: TObjectProStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Cliente: TObjectProCliente;
      Encontrado: Boolean;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cadastro de cliente</summary>
   TObjectProCadastroClienteRequest = record
      Cliente: TObjectProCliente;
      AceitaTermos: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de autorização de venda</summary>
   TObjectProAutorizacaoRequest = record
      Cliente: TObjectProCliente;
      Vendedor: TObjectProVendedor;
      Produtos: TObjectProProdutos;
      ValorTotal: Currency;
      NumeroVenda: string;
      NumeroCupom: string;
      DataHoraVenda: TDateTime;
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TObjectProAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TObjectProStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TObjectProProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      PontosVendedor: Integer;     // Pontos TOP Venda gerados
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de confirmação</summary>
   TObjectProConfirmacaoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      NumeroCupom: string;
      Vendedor: TObjectProVendedor;
      procedure Clear;
   end;

   /// <summary>Response de confirmação</summary>
   TObjectProConfirmacaoResponse = record
      Sucesso: Boolean;
      Status: TObjectProStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraConfirmacao: TDateTime;
      PontosCreditados: Integer;
      TotalPontosVendedor: Integer;
      RankingAtual: Integer;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TObjectProCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Vendedor: TObjectProVendedor;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TObjectProCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TObjectProStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      PontosEstornados: Integer;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Ranking de vendedores</summary>
   TObjectProRankingItem = record
      Posicao: Integer;
      CPF: string;
      Nome: string;
      Loja: string;
      Pontos: Integer;
      Vendas: Currency;
      PercentualMeta: Double;
      procedure Clear;
   end;

   TObjectProRanking = TArray<TObjectProRankingItem>;

   /// <summary>Response de ranking</summary>
   TObjectProRankingResponse = record
      Sucesso: Boolean;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Periodo: string;
      Ranking: TObjectProRanking;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns</summary>
   TObjectProCodigosRetorno = record
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
      PROGRAMA_INATIVO = '30';
      PROGRAMA_EXPIRADO = '31';
      VENDEDOR_NAO_CADASTRADO = '40';
      META_NAO_DEFINIDA = '41';
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
   TObjectProClienteCache = class
   private
      FClientes: TDictionary<string, TObjectProCliente>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ACliente: TObjectProCliente);
      function Get(const ACPF: string): TObjectProCliente;
      function Exists(const ACPF: string): Boolean;
      procedure Clear;
      function Count: Integer;
   end;

   /// <summary>Cache de programas</summary>
   TObjectProProgramaCache = class
   private
      FProgramas: TDictionary<string, TObjectProPrograma>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const APrograma: TObjectProPrograma);
      function Get(const ACodigo: string): TObjectProPrograma;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
      function GetAll: TObjectProProgramas;
   end;

implementation

{ TObjectProPrograma }

procedure TObjectProPrograma.Clear;
begin
   Self := Default(TObjectProPrograma);
end;

{ TObjectProProduto }

class function TObjectProProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TObjectProProduto;
begin
   Result := Default(TObjectProProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
end;

{ TObjectProCliente }

procedure TObjectProCliente.Clear;
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
   TotalCompras := 0;
   TotalDescontos := 0;
   ComprasNoMes := 0;
   UltimaCompra := 0;
   DataCadastro := 0;
   Ativo := False;
   AceitaContato := False;
   SetLength(Programas, 0);
end;

{ TObjectProVendedor }

procedure TObjectProVendedor.Clear;
begin
   Self := Default(TObjectProVendedor);
end;

{ TObjectProEstabelecimento }

procedure TObjectProEstabelecimento.Clear;
begin
   Self := Default(TObjectProEstabelecimento);
end;

{ TObjectProToken }

function TObjectProToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TObjectProToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TObjectProClienteRequest }

procedure TObjectProClienteRequest.Clear;
begin
   CPF := '';
   Telefone := '';
   Codigo := '';
end;

{ TObjectProClienteResponse }

procedure TObjectProClienteResponse.Clear;
begin
   Sucesso := False;
   Status := opsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Cliente.Clear;
   Encontrado := False;
   RawJSON := '';
end;

{ TObjectProCadastroClienteRequest }

procedure TObjectProCadastroClienteRequest.Clear;
begin
   Cliente.Clear;
   AceitaTermos := False;
end;

{ TObjectProAutorizacaoRequest }

procedure TObjectProAutorizacaoRequest.Clear;
begin
   Cliente.Clear;
   Vendedor.Clear;
   SetLength(Produtos, 0);
   ValorTotal := 0;
   NumeroVenda := '';
   NumeroCupom := '';
   DataHoraVenda := 0;
end;

{ TObjectProAutorizacaoResponse }

procedure TObjectProAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := opsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   PontosVendedor := 0;
   RawJSON := '';
end;

{ TObjectProConfirmacaoRequest }

procedure TObjectProConfirmacaoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   NumeroCupom := '';
   Vendedor.Clear;
end;

{ TObjectProConfirmacaoResponse }

procedure TObjectProConfirmacaoResponse.Clear;
begin
   Sucesso := False;
   Status := opsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraConfirmacao := 0;
   PontosCreditados := 0;
   TotalPontosVendedor := 0;
   RankingAtual := 0;
   RawJSON := '';
end;

{ TObjectProCancelamentoRequest }

procedure TObjectProCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Vendedor.Clear;
end;

{ TObjectProCancelamentoResponse }

procedure TObjectProCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := opsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   PontosEstornados := 0;
   RawJSON := '';
end;

{ TObjectProRankingItem }

procedure TObjectProRankingItem.Clear;
begin
   Self := Default(TObjectProRankingItem);
end;

{ TObjectProRankingResponse }

procedure TObjectProRankingResponse.Clear;
begin
   Sucesso := False;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Periodo := '';
   SetLength(Ranking, 0);
   RawJSON := '';
end;

{ TObjectProClienteCache }

constructor TObjectProClienteCache.Create;
begin
   inherited;
   FClientes := TDictionary<string, TObjectProCliente>.Create;
end;

destructor TObjectProClienteCache.Destroy;
begin
   FClientes.Free;
   inherited;
end;

procedure TObjectProClienteCache.Add(const ACliente: TObjectProCliente);
begin
   if ACliente.CPF <> '' then
      FClientes.AddOrSetValue(ACliente.CPF, ACliente);
end;

function TObjectProClienteCache.Get(const ACPF: string): TObjectProCliente;
begin
   if not FClientes.TryGetValue(ACPF, Result) then
      Result.Clear;
end;

function TObjectProClienteCache.Exists(const ACPF: string): Boolean;
begin
   Result := FClientes.ContainsKey(ACPF);
end;

procedure TObjectProClienteCache.Clear;
begin
   FClientes.Clear;
end;

function TObjectProClienteCache.Count: Integer;
begin
   Result := FClientes.Count;
end;

{ TObjectProProgramaCache }

constructor TObjectProProgramaCache.Create;
begin
   inherited;
   FProgramas := TDictionary<string, TObjectProPrograma>.Create;
   FDataAtualizacao := 0;
end;

destructor TObjectProProgramaCache.Destroy;
begin
   FProgramas.Free;
   inherited;
end;

procedure TObjectProProgramaCache.Add(const APrograma: TObjectProPrograma);
begin
   FProgramas.AddOrSetValue(APrograma.Codigo, APrograma);
end;

function TObjectProProgramaCache.Get(const ACodigo: string): TObjectProPrograma;
begin
   if not FProgramas.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TObjectProProgramaCache.Exists(const ACodigo: string): Boolean;
begin
   Result := FProgramas.ContainsKey(ACodigo);
end;

procedure TObjectProProgramaCache.Clear;
begin
   FProgramas.Clear;
   FDataAtualizacao := 0;
end;

function TObjectProProgramaCache.Count: Integer;
begin
   Result := FProgramas.Count;
end;

function TObjectProProgramaCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TObjectProProgramaCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

function TObjectProProgramaCache.GetAll: TObjectProProgramas;
var
   I: Integer;
   LPair: TPair<string, TObjectProPrograma>;
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
