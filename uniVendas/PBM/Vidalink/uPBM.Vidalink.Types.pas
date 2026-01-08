unit uPBM.Vidalink.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API Vidalink</summary>
   TVidalinkEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://api.vidalink.com.br/pbm/v1';
      PORTAL_PRODUCAO = 'https://portal.vidalink.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://api-hml.vidalink.com.br/pbm/v1';
      PORTAL_HOMOLOGACAO = 'https://portal-hml.vidalink.com.br';
      
      // Endpoints
      AUTH = '/auth/token';
      ELEGIBILIDADE = '/beneficiario/elegibilidade';
      CONVENIOS = '/convenio/listar';
      COTACAO = '/transacao/cotar';
      AUTORIZACAO = '/transacao/autorizar';
      CANCELAMENTO = '/transacao/cancelar';
      CONSULTA_PRODUTO = '/produto/consultar';
      CONSULTA_TRANSACAO = '/transacao/consultar';
      UPLOAD_RECEITA = '/receita/upload';
   end;

   /// <summary>Status de retorno Vidalink</summary>
   TVidalinkStatus = (
      vsAutorizado,       // Transação autorizada
      vsCotado,           // Cotação realizada (aguarda autorização)
      vsNegado,           // Transação negada
      vsCancelado,        // Transação cancelada
      vsPendente,         // Aguardando processamento
      vsErroConexao,      // Erro de conexão
      vsErroAutenticacao, // Erro de autenticação
      vsErroValidacao,    // Erro de validação de dados
      vsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de pagamento do beneficiário</summary>
   TVidalinkTipoPagamento = (
      tpFolha,            // 100% desconto em folha
      tpAVista,           // 100% à vista na farmácia
      tpMisto             // Parte folha, parte à vista
   );

   /// <summary>Dados do convênio/empresa</summary>
   TVidalinkConvenio = record
      Codigo: string;           // Código do convênio
      Nome: string;             // Nome do convênio/empresa
      EmpresaCNPJ: string;      // CNPJ da empresa conveniada
      PercentualSubsidio: Double; // % subsidiado pela empresa
      TipoPagamento: TVidalinkTipoPagamento;
      Ativo: Boolean;
      class function Create(const ACodigo, ANome: string): TVidalinkConvenio; static;
      procedure Clear;
   end;

   /// <summary>Lista de convênios disponíveis</summary>
   TVidalinkConvenios = TArray<TVidalinkConvenio>;

   /// <summary>Produto para autorização</summary>
   TVidalinkProduto = record
      CodigoBarras: string;     // EAN 13
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorSubsidio: Currency;  // Valor pago pela empresa
      ValorFolha: Currency;     // Valor descontado em folha
      ValorAVista: Currency;    // Valor pago à vista na farmácia
      PercentualSubsidio: Double;
      Autorizado: Boolean;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      RequerReceita: Boolean;
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TVidalinkProduto; static;
   end;

   TVidalinkProdutos = TArray<TVidalinkProduto>;

   /// <summary>Dados do beneficiário/colaborador</summary>
   TVidalinkBeneficiario = record
      NumeroCartao: string;     // Número do cartão virtual Vidalink
      CPF: string;
      Nome: string;
      DataNascimento: TDateTime;
      Matricula: string;        // Matrícula na empresa
      Convenio: TVidalinkConvenio;
      Ativo: Boolean;
      TipoPagamento: TVidalinkTipoPagamento;
      LimiteDisponivel: Currency;
      LimiteMensal: Currency;
      procedure Clear;
   end;

   /// <summary>Dados da receita médica</summary>
   TVidalinkReceita = record
      CRM: string;
      UFMedico: string;
      NomeMedico: string;
      DataReceita: TDateTime;
      NumeroReceita: string;
      ArquivoBase64: string;    // Imagem da receita em Base64
      NomeArquivo: string;
      TipoArquivo: string;      // jpg, png, pdf
      IdReceitaCadastrada: string; // ID se receita foi pré-cadastrada no app
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TVidalinkEstabelecimento = record
      CNPJ: string;
      CodigoLoja: string;       // Código no Vidalink
      RazaoSocial: string;
      Usuario: string;          // Login
      Senha: string;            // Senha
      ChaveAPI: string;         // API Key
      procedure Clear;
   end;

   /// <summary>Dados do atendente</summary>
   TVidalinkAtendente = record
      CPF: string;
      Nome: string;
      Matricula: string;
      procedure Clear;
   end;

   /// <summary>Token de sessão</summary>
   TVidalinkToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de elegibilidade</summary>
   TVidalinkElegibilidadeRequest = record
      NumeroCartao: string;     // Pode ser cartão ou CPF
      CPF: string;
      CodigoConvenio: string;   // Opcional, filtra por convênio
      procedure Clear;
   end;

   /// <summary>Response de elegibilidade</summary>
   TVidalinkElegibilidadeResponse = record
      Sucesso: Boolean;
      Status: TVidalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Beneficiario: TVidalinkBeneficiario;
      Elegivel: Boolean;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cotação (simula venda sem efetivar)</summary>
   TVidalinkCotacaoRequest = record
      Beneficiario: TVidalinkBeneficiario;
      Produtos: TVidalinkProdutos;
      ValorTotal: Currency;
      procedure Clear;
   end;

   /// <summary>Response de cotação</summary>
   TVidalinkCotacaoResponse = record
      Sucesso: Boolean;
      Status: TVidalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      CodigoCotacao: string;
      DataHoraCotacao: TDateTime;
      ValidadeMinutos: Integer;
      Produtos: TVidalinkProdutos;
      ValorTotalSubsidio: Currency;
      ValorTotalFolha: Currency;
      ValorTotalAVista: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de autorização</summary>
   TVidalinkAutorizacaoRequest = record
      Beneficiario: TVidalinkBeneficiario;
      Atendente: TVidalinkAtendente;
      Produtos: TVidalinkProdutos;
      Receita: TVidalinkReceita;
      ValorTotal: Currency;
      NumeroVenda: string;
      DataHoraVenda: TDateTime;
      CodigoCotacao: string;    // Se veio de cotação prévia
      InformarReceita: Boolean;
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TVidalinkAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TVidalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NumeroAutorizacao: string;
      NSU: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TVidalinkProdutos;
      ValorTotalSubsidio: Currency;
      ValorTotalFolha: Currency;
      ValorTotalAVista: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TVidalinkCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Atendente: TVidalinkAtendente;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TVidalinkCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TVidalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns do Vidalink</summary>
   TVidalinkCodigosRetorno = record
   const
      SUCESSO = '00';
      COTACAO_OK = '01';
      BENEFICIARIO_NAO_ENCONTRADO = '10';
      BENEFICIARIO_INATIVO = '11';
      CARTAO_BLOQUEADO = '12';
      CONVENIO_INATIVO = '13';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_COBERTURA = '21';
      LIMITE_EXCEDIDO = '30';
      LIMITE_MENSAL_EXCEDIDO = '31';
      RECEITA_OBRIGATORIA = '40';
      RECEITA_VENCIDA = '41';
      RECEITA_JA_UTILIZADA = '42';
      COTACAO_EXPIRADA = '50';
      TRANSACAO_JA_CANCELADA = '51';
      TRANSACAO_NAO_ENCONTRADA = '52';
      ERRO_AUTENTICACAO = '90';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Cache de convênios</summary>
   TVidalinkConvenioCache = class
   private
      FConvenios: TDictionary<string, TVidalinkConvenio>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const AConvenio: TVidalinkConvenio);
      function Get(const ACodigo: string): TVidalinkConvenio;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
   end;

implementation

{ TVidalinkConvenio }

class function TVidalinkConvenio.Create(const ACodigo, ANome: string): TVidalinkConvenio;
begin
   Result := Default(TVidalinkConvenio);
   Result.Codigo := ACodigo;
   Result.Nome := ANome;
   Result.Ativo := True;
end;

procedure TVidalinkConvenio.Clear;
begin
   Self := Default(TVidalinkConvenio);
end;

{ TVidalinkProduto }

class function TVidalinkProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TVidalinkProduto;
begin
   Result := Default(TVidalinkProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
   Result.RequerReceita := False;
end;

{ TVidalinkBeneficiario }

procedure TVidalinkBeneficiario.Clear;
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
   LimiteMensal := 0;
end;

{ TVidalinkReceita }

procedure TVidalinkReceita.Clear;
begin
   Self := Default(TVidalinkReceita);
end;

{ TVidalinkEstabelecimento }

procedure TVidalinkEstabelecimento.Clear;
begin
   Self := Default(TVidalinkEstabelecimento);
end;

{ TVidalinkAtendente }

procedure TVidalinkAtendente.Clear;
begin
   Self := Default(TVidalinkAtendente);
end;

{ TVidalinkToken }

function TVidalinkToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TVidalinkToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TVidalinkElegibilidadeRequest }

procedure TVidalinkElegibilidadeRequest.Clear;
begin
   NumeroCartao := '';
   CPF := '';
   CodigoConvenio := '';
end;

{ TVidalinkElegibilidadeResponse }

procedure TVidalinkElegibilidadeResponse.Clear;
begin
   Sucesso := False;
   Status := vsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Beneficiario.Clear;
   Elegivel := False;
   RawJSON := '';
end;

{ TVidalinkCotacaoRequest }

procedure TVidalinkCotacaoRequest.Clear;
begin
   Beneficiario.Clear;
   SetLength(Produtos, 0);
   ValorTotal := 0;
end;

{ TVidalinkCotacaoResponse }

procedure TVidalinkCotacaoResponse.Clear;
begin
   Sucesso := False;
   Status := vsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   CodigoCotacao := '';
   DataHoraCotacao := 0;
   ValidadeMinutos := 0;
   SetLength(Produtos, 0);
   ValorTotalSubsidio := 0;
   ValorTotalFolha := 0;
   ValorTotalAVista := 0;
   RawJSON := '';
end;

{ TVidalinkAutorizacaoRequest }

procedure TVidalinkAutorizacaoRequest.Clear;
begin
   Beneficiario.Clear;
   Atendente.Clear;
   SetLength(Produtos, 0);
   Receita.Clear;
   ValorTotal := 0;
   NumeroVenda := '';
   DataHoraVenda := 0;
   CodigoCotacao := '';
   InformarReceita := False;
end;

{ TVidalinkAutorizacaoResponse }

procedure TVidalinkAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := vsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NumeroAutorizacao := '';
   NSU := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalSubsidio := 0;
   ValorTotalFolha := 0;
   ValorTotalAVista := 0;
   RawJSON := '';
end;

{ TVidalinkCancelamentoRequest }

procedure TVidalinkCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Atendente.Clear;
end;

{ TVidalinkCancelamentoResponse }

procedure TVidalinkCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := vsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   RawJSON := '';
end;

{ TVidalinkConvenioCache }

constructor TVidalinkConvenioCache.Create;
begin
   inherited;
   FConvenios := TDictionary<string, TVidalinkConvenio>.Create;
   FDataAtualizacao := 0;
end;

destructor TVidalinkConvenioCache.Destroy;
begin
   FConvenios.Free;
   inherited;
end;

procedure TVidalinkConvenioCache.Add(const AConvenio: TVidalinkConvenio);
begin
   FConvenios.AddOrSetValue(AConvenio.Codigo, AConvenio);
end;

function TVidalinkConvenioCache.Get(const ACodigo: string): TVidalinkConvenio;
begin
   if not FConvenios.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TVidalinkConvenioCache.Exists(const ACodigo: string): Boolean;
begin
   Result := FConvenios.ContainsKey(ACodigo);
end;

procedure TVidalinkConvenioCache.Clear;
begin
   FConvenios.Clear;
   FDataAtualizacao := 0;
end;

function TVidalinkConvenioCache.Count: Integer;
begin
   Result := FConvenios.Count;
end;

function TVidalinkConvenioCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TVidalinkConvenioCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

end.
