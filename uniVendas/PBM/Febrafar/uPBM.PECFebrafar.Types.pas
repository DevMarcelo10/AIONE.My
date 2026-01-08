unit uPBM.PECFebrafar.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API PEC Febrafar</summary>
   TPECFebrafarEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://ws.febrafar.com.br/pec/api/v1';
      PORTAL_PRODUCAO = 'https://portal.febrafar.com.br';
      ORION_PRODUCAO = 'https://orion.febrafar.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://ws-hml.febrafar.com.br/pec/api/v1';
      PORTAL_HOMOLOGACAO = 'https://portal-hml.febrafar.com.br';
      
      // Endpoints REST
      AUTH = '/auth/token';
      CLIENTE_CONSULTA = '/cliente/consultar';
      CLIENTE_CADASTRO = '/cliente/cadastrar';
      CLIENTE_ATUALIZAR = '/cliente/atualizar';
      PRODUTO_CONSULTA = '/produto/consultar';
      PRODUTO_DESCONTO = '/produto/desconto';
      VENDA_PRE_AUTORIZAR = '/venda/preautorizar';
      VENDA_AUTORIZAR = '/venda/autorizar';
      VENDA_CANCELAR = '/venda/cancelar';
      VENDA_CONSULTAR = '/venda/consultar';
      PROGRAMA_LISTAR = '/programa/listar';
      OFERTA_LISTAR = '/oferta/listar';
      OFERTA_ATIVAR = '/oferta/ativar';
   end;

   /// <summary>Status de retorno PEC Febrafar</summary>
   TPECFebrafarStatus = (
      pfsAutorizado,       // Transação autorizada
      pfsPreAutorizado,    // Pré-autorização concedida
      pfsNegado,           // Transação negada
      pfsCancelado,        // Transação cancelada
      pfsPendente,         // Aguardando processamento
      pfsErroConexao,      // Erro de conexão
      pfsErroAutenticacao, // Erro de autenticação
      pfsErroValidacao,    // Erro de validação de dados
      pfsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de desconto</summary>
   TPECFebrafarTipoDesconto = (
      tfdPercentual,       // Desconto em percentual
      tfdValorFixo,        // Desconto em valor fixo
      tfdPrecoFixo,        // Preço fixo promocional
      tfdOfertaApp         // Desconto via oferta do app
   );

   /// <summary>Tipo de cliente</summary>
   TPECFebrafarTipoCliente = (
      tcNormal,            // Cliente normal
      tcPreferencial,      // Cliente preferencial/VIP
      tcFuncionario,       // Funcionário da rede
      tcConveniado         // Conveniado/parceiro
   );

   /// <summary>Dados do programa de desconto</summary>
   TPECFebrafarPrograma = record
      Codigo: string;
      Nome: string;
      Descricao: string;
      Laboratorio: string;
      TipoDesconto: TPECFebrafarTipoDesconto;
      PercentualDesconto: Double;
      Ativo: Boolean;
      DataInicio: TDateTime;
      DataFim: TDateTime;
      class function Create(const ACodigo, ANome: string): TPECFebrafarPrograma; static;
      procedure Clear;
   end;

   TPECFebrafarProgramas = TArray<TPECFebrafarPrograma>;

   /// <summary>Dados de oferta do aplicativo</summary>
   TPECFebrafarOferta = record
      Codigo: string;
      Descricao: string;
      TipoDesconto: TPECFebrafarTipoDesconto;
      ValorDesconto: Currency;
      PercentualDesconto: Double;
      CodigoBarras: string;        // EAN do produto (se específico)
      QuantidadeMinima: Integer;
      DataInicio: TDateTime;
      DataFim: TDateTime;
      Ativada: Boolean;            // Se cliente ativou a oferta
      procedure Clear;
   end;

   TPECFebrafarOfertas = TArray<TPECFebrafarOferta>;

   /// <summary>Produto com desconto</summary>
   TPECFebrafarProduto = record
      CodigoBarras: string;        // EAN 13
      CodigoInterno: string;       // Código interno da farmácia
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;
      PercentualDesconto: Double;
      TipoDesconto: TPECFebrafarTipoDesconto;
      Autorizado: Boolean;
      CodigoPrograma: string;
      NomePrograma: string;
      CodigoOferta: string;        // Se desconto veio de oferta
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TPECFebrafarProduto; static;
   end;

   TPECFebrafarProdutos = TArray<TPECFebrafarProduto>;

   /// <summary>Dados do cliente fidelizado</summary>
   TPECFebrafarCliente = record
      Codigo: string;              // Código no PEC
      CPF: string;
      Nome: string;
      DataNascimento: TDateTime;
      Telefone: string;
      Celular: string;
      Email: string;
      CEP: string;
      Endereco: string;
      Numero: string;
      Bairro: string;
      Cidade: string;
      UF: string;
      TipoCliente: TPECFebrafarTipoCliente;
      GrupoCliente: string;        // Grupo preferencial
      Pontos: Integer;             // Pontos acumulados
      DataCadastro: TDateTime;
      UltimaCompra: TDateTime;
      Ativo: Boolean;
      AceitaWhatsApp: Boolean;
      AceitaEmail: Boolean;
      AceitaSMS: Boolean;
      OfertasAtivas: TPECFebrafarOfertas;
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TPECFebrafarEstabelecimento = record
      CNPJ: string;
      CodigoAcesso: string;        // Código de acesso fornecido
      Senha: string;
      CodigoEmpresa: string;       // Código empresa programa desconto
      EnderecoServidor: string;    // URL do WebService
      RazaoSocial: string;
      CodigoRede: string;          // Código da rede associada
      NomeRede: string;
      UF: string;
      procedure Clear;
   end;

   /// <summary>Dados do operador/atendente</summary>
   TPECFebrafarOperador = record
      CPF: string;
      Nome: string;
      Matricula: string;
      CodigoTerminal: string;
      procedure Clear;
   end;

   /// <summary>Token de autenticação</summary>
   TPECFebrafarToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de consulta de cliente</summary>
   TPECFebrafarClienteRequest = record
      CPF: string;
      Telefone: string;
      Codigo: string;
      procedure Clear;
   end;

   /// <summary>Response de consulta de cliente</summary>
   TPECFebrafarClienteResponse = record
      Sucesso: Boolean;
      Status: TPECFebrafarStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Cliente: TPECFebrafarCliente;
      Encontrado: Boolean;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cadastro de cliente</summary>
   TPECFebrafarCadastroClienteRequest = record
      Cliente: TPECFebrafarCliente;
      AceitaTermos: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de pré-autorização</summary>
   TPECFebrafarPreAutorizacaoRequest = record
      Cliente: TPECFebrafarCliente;
      Operador: TPECFebrafarOperador;
      Produtos: TPECFebrafarProdutos;
      ValorTotal: Currency;
      NumeroVenda: string;
      DataHoraVenda: TDateTime;
      AplicarOfertas: Boolean;     // Aplicar ofertas ativadas pelo cliente
      procedure Clear;
   end;

   /// <summary>Response de pré-autorização</summary>
   TPECFebrafarPreAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TPECFebrafarStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NumeroPreAutorizacao: string;
      NSU: string;
      DataHoraPreAutorizacao: TDateTime;
      ValidadeMinutos: Integer;
      Produtos: TPECFebrafarProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      PontosGerados: Integer;      // Pontos que serão creditados
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de autorização (confirmação)</summary>
   TPECFebrafarAutorizacaoRequest = record
      NumeroPreAutorizacao: string;
      NSU: string;
      NumeroVenda: string;
      Operador: TPECFebrafarOperador;
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TPECFebrafarAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TPECFebrafarStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TPECFebrafarProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      PontosCreditados: Integer;
      SaldoPontos: Integer;        // Saldo total após a venda
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TPECFebrafarCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Operador: TPECFebrafarOperador;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TPECFebrafarCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TPECFebrafarStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      PontosEstornados: Integer;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns do PEC Febrafar</summary>
   TPECFebrafarCodigosRetorno = record
   const
      SUCESSO = '00';
      PRE_AUTORIZADO = '01';
      CLIENTE_NAO_ENCONTRADO = '10';
      CLIENTE_INATIVO = '11';
      CPF_INVALIDO = '12';
      CLIENTE_JA_CADASTRADO = '13';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_DESCONTO = '21';
      QUANTIDADE_INVALIDA = '22';
      PROGRAMA_INATIVO = '30';
      PROGRAMA_EXPIRADO = '31';
      OFERTA_INVALIDA = '40';
      OFERTA_EXPIRADA = '41';
      OFERTA_NAO_ATIVADA = '42';
      PRE_AUTORIZACAO_EXPIRADA = '50';
      TRANSACAO_JA_CANCELADA = '51';
      TRANSACAO_NAO_ENCONTRADA = '52';
      ESTABELECIMENTO_INVALIDO = '60';
      CREDENCIAIS_INVALIDAS = '61';
      TOKEN_EXPIRADO = '62';
      REDE_NAO_AUTORIZADA = '63';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Cache de clientes consultados</summary>
   TPECFebrafarClienteCache = class
   private
      FClientes: TDictionary<string, TPECFebrafarCliente>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ACliente: TPECFebrafarCliente);
      function Get(const ACPF: string): TPECFebrafarCliente;
      function Exists(const ACPF: string): Boolean;
      procedure Clear;
      function Count: Integer;
   end;

   /// <summary>Cache de programas</summary>
   TPECFebrafarProgramaCache = class
   private
      FProgramas: TDictionary<string, TPECFebrafarPrograma>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const APrograma: TPECFebrafarPrograma);
      function Get(const ACodigo: string): TPECFebrafarPrograma;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
      function GetAll: TPECFebrafarProgramas;
   end;

implementation

{ TPECFebrafarPrograma }

class function TPECFebrafarPrograma.Create(const ACodigo, ANome: string): TPECFebrafarPrograma;
begin
   Result := Default(TPECFebrafarPrograma);
   Result.Codigo := ACodigo;
   Result.Nome := ANome;
   Result.Ativo := True;
end;

procedure TPECFebrafarPrograma.Clear;
begin
   Self := Default(TPECFebrafarPrograma);
end;

{ TPECFebrafarOferta }

procedure TPECFebrafarOferta.Clear;
begin
   Self := Default(TPECFebrafarOferta);
end;

{ TPECFebrafarProduto }

class function TPECFebrafarProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TPECFebrafarProduto;
begin
   Result := Default(TPECFebrafarProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
end;

{ TPECFebrafarCliente }

procedure TPECFebrafarCliente.Clear;
begin
   Codigo := '';
   CPF := '';
   Nome := '';
   DataNascimento := 0;
   Telefone := '';
   Celular := '';
   Email := '';
   CEP := '';
   Endereco := '';
   Numero := '';
   Bairro := '';
   Cidade := '';
   UF := '';
   TipoCliente := tcNormal;
   GrupoCliente := '';
   Pontos := 0;
   DataCadastro := 0;
   UltimaCompra := 0;
   Ativo := False;
   AceitaWhatsApp := False;
   AceitaEmail := False;
   AceitaSMS := False;
   SetLength(OfertasAtivas, 0);
end;

{ TPECFebrafarEstabelecimento }

procedure TPECFebrafarEstabelecimento.Clear;
begin
   Self := Default(TPECFebrafarEstabelecimento);
end;

{ TPECFebrafarOperador }

procedure TPECFebrafarOperador.Clear;
begin
   Self := Default(TPECFebrafarOperador);
end;

{ TPECFebrafarToken }

function TPECFebrafarToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TPECFebrafarToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TPECFebrafarClienteRequest }

procedure TPECFebrafarClienteRequest.Clear;
begin
   CPF := '';
   Telefone := '';
   Codigo := '';
end;

{ TPECFebrafarClienteResponse }

procedure TPECFebrafarClienteResponse.Clear;
begin
   Sucesso := False;
   Status := pfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Cliente.Clear;
   Encontrado := False;
   RawJSON := '';
end;

{ TPECFebrafarCadastroClienteRequest }

procedure TPECFebrafarCadastroClienteRequest.Clear;
begin
   Cliente.Clear;
   AceitaTermos := False;
end;

{ TPECFebrafarPreAutorizacaoRequest }

procedure TPECFebrafarPreAutorizacaoRequest.Clear;
begin
   Cliente.Clear;
   Operador.Clear;
   SetLength(Produtos, 0);
   ValorTotal := 0;
   NumeroVenda := '';
   DataHoraVenda := 0;
   AplicarOfertas := True;
end;

{ TPECFebrafarPreAutorizacaoResponse }

procedure TPECFebrafarPreAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := pfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NumeroPreAutorizacao := '';
   NSU := '';
   DataHoraPreAutorizacao := 0;
   ValidadeMinutos := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   PontosGerados := 0;
   RawJSON := '';
end;

{ TPECFebrafarAutorizacaoRequest }

procedure TPECFebrafarAutorizacaoRequest.Clear;
begin
   NumeroPreAutorizacao := '';
   NSU := '';
   NumeroVenda := '';
   Operador.Clear;
end;

{ TPECFebrafarAutorizacaoResponse }

procedure TPECFebrafarAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := pfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   PontosCreditados := 0;
   SaldoPontos := 0;
   RawJSON := '';
end;

{ TPECFebrafarCancelamentoRequest }

procedure TPECFebrafarCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Operador.Clear;
end;

{ TPECFebrafarCancelamentoResponse }

procedure TPECFebrafarCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := pfsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   PontosEstornados := 0;
   RawJSON := '';
end;

{ TPECFebrafarClienteCache }

constructor TPECFebrafarClienteCache.Create;
begin
   inherited;
   FClientes := TDictionary<string, TPECFebrafarCliente>.Create;
end;

destructor TPECFebrafarClienteCache.Destroy;
begin
   FClientes.Free;
   inherited;
end;

procedure TPECFebrafarClienteCache.Add(const ACliente: TPECFebrafarCliente);
begin
   if ACliente.CPF <> '' then
      FClientes.AddOrSetValue(ACliente.CPF, ACliente);
end;

function TPECFebrafarClienteCache.Get(const ACPF: string): TPECFebrafarCliente;
begin
   if not FClientes.TryGetValue(ACPF, Result) then
      Result.Clear;
end;

function TPECFebrafarClienteCache.Exists(const ACPF: string): Boolean;
begin
   Result := FClientes.ContainsKey(ACPF);
end;

procedure TPECFebrafarClienteCache.Clear;
begin
   FClientes.Clear;
end;

function TPECFebrafarClienteCache.Count: Integer;
begin
   Result := FClientes.Count;
end;

{ TPECFebrafarProgramaCache }

constructor TPECFebrafarProgramaCache.Create;
begin
   inherited;
   FProgramas := TDictionary<string, TPECFebrafarPrograma>.Create;
   FDataAtualizacao := 0;
end;

destructor TPECFebrafarProgramaCache.Destroy;
begin
   FProgramas.Free;
   inherited;
end;

procedure TPECFebrafarProgramaCache.Add(const APrograma: TPECFebrafarPrograma);
begin
   FProgramas.AddOrSetValue(APrograma.Codigo, APrograma);
end;

function TPECFebrafarProgramaCache.Get(const ACodigo: string): TPECFebrafarPrograma;
begin
   if not FProgramas.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TPECFebrafarProgramaCache.Exists(const ACodigo: string): Boolean;
begin
   Result := FProgramas.ContainsKey(ACodigo);
end;

procedure TPECFebrafarProgramaCache.Clear;
begin
   FProgramas.Clear;
   FDataAtualizacao := 0;
end;

function TPECFebrafarProgramaCache.Count: Integer;
begin
   Result := FProgramas.Count;
end;

function TPECFebrafarProgramaCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TPECFebrafarProgramaCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

function TPECFebrafarProgramaCache.GetAll: TPECFebrafarProgramas;
var
   I: Integer;
   LPair: TPair<string, TPECFebrafarPrograma>;
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
