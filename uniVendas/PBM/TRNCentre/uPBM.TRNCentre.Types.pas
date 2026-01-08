unit uPBM.TRNCentre.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API TRN Centre / Portal da Drogaria</summary>
   TTRNCentreEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://api.trncentre.com.br/v1';
      PORTAL_PRODUCAO = 'https://www.portaldadrogaria.com.br';
      WEB_PRODUCAO = 'https://www.trncentre.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://api-hml.trncentre.com.br/v1';
      PORTAL_HOMOLOGACAO = 'https://hml.portaldadrogaria.com.br';
      WEB_HOMOLOGACAO = 'https://hml.trncentre.com.br';
      
      // Endpoints
      AUTH = '/auth/token';
      LOAD_TABLES = '/produtos/loadtables';
      CONSULTA_PRODUTO = '/produtos/consultar';
      CONSULTA_DESCONTO = '/produtos/desconto';
      ELEGIBILIDADE = '/beneficiario/elegibilidade';
      PRE_AUTORIZAR = '/transacao/preautorizar';
      AUTORIZAR = '/transacao/autorizar';
      CANCELAR = '/transacao/cancelar';
      CONSULTAR_TRANSACAO = '/transacao/consultar';
      LISTAR_PROGRAMAS = '/programas/listar';
      LISTAR_OPERADORAS = '/operadoras/listar';
   end;

   /// <summary>Status de retorno TRN Centre</summary>
   TTRNCentreStatus = (
      tsAutorizado,       // Transação autorizada
      tsPreAutorizado,    // Pré-autorização concedida
      tsNegado,           // Transação negada
      tsCancelado,        // Transação cancelada
      tsPendente,         // Aguardando processamento
      tsErroConexao,      // Erro de conexão
      tsErroAutenticacao, // Erro de autenticação
      tsErroValidacao,    // Erro de validação de dados
      tsTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de desconto</summary>
   TTRNCentreTipoDesconto = (
      tdPercentual,       // Desconto em percentual
      tdValorFixo,        // Desconto em valor fixo
      tdPrecoPromocional  // Preço promocional
   );

   /// <summary>Dados da operadora/laboratório</summary>
   TTRNCentreOperadora = record
      Codigo: string;
      Nome: string;
      Laboratorio: string;
      Ativo: Boolean;
      class function Create(const ACodigo, ANome: string): TTRNCentreOperadora; static;
      procedure Clear;
   end;

   TTRNCentreOperadoras = TArray<TTRNCentreOperadora>;

   /// <summary>Dados do programa de desconto</summary>
   TTRNCentrePrograma = record
      Codigo: string;
      Nome: string;
      Operadora: TTRNCentreOperadora;
      TipoDesconto: TTRNCentreTipoDesconto;
      Ativo: Boolean;
      DataInicio: TDateTime;
      DataFim: TDateTime;
      RequerCadastro: Boolean;      // Paciente precisa estar cadastrado
      RequerReceita: Boolean;       // Exige receita médica
      class function Create(const ACodigo, ANome: string): TTRNCentrePrograma; static;
      procedure Clear;
   end;

   TTRNCentreProgramas = TArray<TTRNCentrePrograma>;

   /// <summary>Produto com desconto</summary>
   TTRNCentreProduto = record
      CodigoBarras: string;        // EAN 13
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;
      PercentualDesconto: Double;
      TipoDesconto: TTRNCentreTipoDesconto;
      Autorizado: Boolean;
      CodigoPrograma: string;
      NomePrograma: string;
      CodigoOperadora: string;
      NomeOperadora: string;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      RequerReceita: Boolean;
      QuantidadeMinima: Integer;   // Qtd mínima para desconto
      QuantidadeMaxima: Integer;   // Qtd máxima permitida
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TTRNCentreProduto; static;
   end;

   TTRNCentreProdutos = TArray<TTRNCentreProduto>;

   /// <summary>Dados do beneficiário/cliente</summary>
   TTRNCentreBeneficiario = record
      CPF: string;
      CartaoDesconto: string;      // Cupom/Cartão de desconto
      Nome: string;
      DataNascimento: TDateTime;
      Telefone: string;
      Email: string;
      CodigoCadastro: string;
      ProgramasVinculados: TTRNCentreProgramas;
      Ativo: Boolean;
      procedure Clear;
   end;

   /// <summary>Dados da receita médica</summary>
   TTRNCentreReceita = record
      CRM: string;
      UFMedico: string;
      NomeMedico: string;
      DataReceita: TDateTime;
      NumeroReceita: string;
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TTRNCentreEstabelecimento = record
      CNPJ: string;
      ClientID: string;            // Client ID para API
      Password: string;            // Password para API
      CodigoTerminal: string;
      RazaoSocial: string;
      UF: string;
      procedure Clear;
   end;

   /// <summary>Dados do operador/atendente</summary>
   TTRNCentreOperador = record
      CPF: string;
      Nome: string;
      Matricula: string;
      procedure Clear;
   end;

   /// <summary>Token de autenticação</summary>
   TTRNCentreToken = record
      AccessToken: string;
      TokenType: string;
      ExpiresIn: Integer;
      DataExpiracao: TDateTime;
      function Valido: Boolean;
      procedure Clear;
   end;

   /// <summary>Request de elegibilidade</summary>
   TTRNCentreElegibilidadeRequest = record
      CPF: string;
      CartaoDesconto: string;
      CodigoPrograma: string;
      CodigoBarras: string;        // Verificar elegibilidade para produto específico
      procedure Clear;
   end;

   /// <summary>Response de elegibilidade</summary>
   TTRNCentreElegibilidadeResponse = record
      Sucesso: Boolean;
      Status: TTRNCentreStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Beneficiario: TTRNCentreBeneficiario;
      Elegivel: Boolean;
      ProgramasDisponiveis: TTRNCentreProgramas;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de pré-autorização</summary>
   TTRNCentrePreAutorizacaoRequest = record
      Beneficiario: TTRNCentreBeneficiario;
      Operador: TTRNCentreOperador;
      Produtos: TTRNCentreProdutos;
      Receita: TTRNCentreReceita;
      ValorTotal: Currency;
      NumeroVenda: string;
      DataHoraVenda: TDateTime;
      NSUPortal: string;           // NSU gerada no Portal (se autorização foi feita lá)
      InformarReceita: Boolean;
      procedure Clear;
   end;

   /// <summary>Response de pré-autorização</summary>
   TTRNCentrePreAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TTRNCentreStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NumeroPreAutorizacao: string;
      NSU: string;
      DataHoraPreAutorizacao: TDateTime;
      ValidadeMinutos: Integer;
      Produtos: TTRNCentreProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de autorização (confirmação)</summary>
   TTRNCentreAutorizacaoRequest = record
      NumeroPreAutorizacao: string;
      NSU: string;
      NumeroVenda: string;
      Operador: TTRNCentreOperador;
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TTRNCentreAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TTRNCentreStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TTRNCentreProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TTRNCentreCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Operador: TTRNCentreOperador;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TTRNCentreCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TTRNCentreStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns do TRN Centre</summary>
   TTRNCentreCodigosRetorno = record
   const
      SUCESSO = '00';
      PRE_AUTORIZADO = '01';
      BENEFICIARIO_NAO_ENCONTRADO = '10';
      BENEFICIARIO_NAO_CADASTRADO = '11';
      CARTAO_INVALIDO = '12';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_DESCONTO = '21';
      QUANTIDADE_INVALIDA = '22';
      QUANTIDADE_EXCEDIDA = '23';
      PROGRAMA_INATIVO = '30';
      PROGRAMA_EXPIRADO = '31';
      OPERADORA_INATIVA = '32';
      RECEITA_OBRIGATORIA = '40';
      RECEITA_VENCIDA = '41';
      PRE_AUTORIZACAO_EXPIRADA = '50';
      TRANSACAO_JA_CANCELADA = '51';
      TRANSACAO_NAO_ENCONTRADA = '52';
      NSU_INVALIDA = '53';
      TERMINAL_INVALIDO = '60';
      CREDENCIAIS_INVALIDAS = '61';
      TOKEN_EXPIRADO = '62';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Cache de produtos com desconto</summary>
   TTRNCentreProdutoCache = class
   private
      FProdutos: TDictionary<string, TTRNCentreProduto>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const AProduto: TTRNCentreProduto);
      function Get(const ACodigoBarras: string): TTRNCentreProduto;
      function Exists(const ACodigoBarras: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AHoras: Integer = 24): Boolean;
      procedure SetUpdated;
   end;

   /// <summary>Cache de programas</summary>
   TTRNCentreProgramaCache = class
   private
      FProgramas: TDictionary<string, TTRNCentrePrograma>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const APrograma: TTRNCentrePrograma);
      function Get(const ACodigo: string): TTRNCentrePrograma;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
      function GetAll: TTRNCentreProgramas;
   end;

implementation

{ TTRNCentreOperadora }

class function TTRNCentreOperadora.Create(const ACodigo, ANome: string): TTRNCentreOperadora;
begin
   Result := Default(TTRNCentreOperadora);
   Result.Codigo := ACodigo;
   Result.Nome := ANome;
   Result.Ativo := True;
end;

procedure TTRNCentreOperadora.Clear;
begin
   Self := Default(TTRNCentreOperadora);
end;

{ TTRNCentrePrograma }

class function TTRNCentrePrograma.Create(const ACodigo, ANome: string): TTRNCentrePrograma;
begin
   Result := Default(TTRNCentrePrograma);
   Result.Codigo := ACodigo;
   Result.Nome := ANome;
   Result.Ativo := True;
end;

procedure TTRNCentrePrograma.Clear;
begin
   Self := Default(TTRNCentrePrograma);
end;

{ TTRNCentreProduto }

class function TTRNCentreProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TTRNCentreProduto;
begin
   Result := Default(TTRNCentreProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
   Result.RequerReceita := False;
   Result.QuantidadeMinima := 1;
   Result.QuantidadeMaxima := 999;
end;

{ TTRNCentreBeneficiario }

procedure TTRNCentreBeneficiario.Clear;
begin
   CPF := '';
   CartaoDesconto := '';
   Nome := '';
   DataNascimento := 0;
   Telefone := '';
   Email := '';
   CodigoCadastro := '';
   SetLength(ProgramasVinculados, 0);
   Ativo := False;
end;

{ TTRNCentreReceita }

procedure TTRNCentreReceita.Clear;
begin
   Self := Default(TTRNCentreReceita);
end;

{ TTRNCentreEstabelecimento }

procedure TTRNCentreEstabelecimento.Clear;
begin
   Self := Default(TTRNCentreEstabelecimento);
end;

{ TTRNCentreOperador }

procedure TTRNCentreOperador.Clear;
begin
   Self := Default(TTRNCentreOperador);
end;

{ TTRNCentreToken }

function TTRNCentreToken.Valido: Boolean;
begin
   Result := (AccessToken <> '') and (Now < DataExpiracao);
end;

procedure TTRNCentreToken.Clear;
begin
   AccessToken := '';
   TokenType := '';
   ExpiresIn := 0;
   DataExpiracao := 0;
end;

{ TTRNCentreElegibilidadeRequest }

procedure TTRNCentreElegibilidadeRequest.Clear;
begin
   CPF := '';
   CartaoDesconto := '';
   CodigoPrograma := '';
   CodigoBarras := '';
end;

{ TTRNCentreElegibilidadeResponse }

procedure TTRNCentreElegibilidadeResponse.Clear;
begin
   Sucesso := False;
   Status := tsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Beneficiario.Clear;
   Elegivel := False;
   SetLength(ProgramasDisponiveis, 0);
   RawJSON := '';
end;

{ TTRNCentrePreAutorizacaoRequest }

procedure TTRNCentrePreAutorizacaoRequest.Clear;
begin
   Beneficiario.Clear;
   Operador.Clear;
   SetLength(Produtos, 0);
   Receita.Clear;
   ValorTotal := 0;
   NumeroVenda := '';
   DataHoraVenda := 0;
   NSUPortal := '';
   InformarReceita := False;
end;

{ TTRNCentrePreAutorizacaoResponse }

procedure TTRNCentrePreAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := tsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NumeroPreAutorizacao := '';
   NSU := '';
   DataHoraPreAutorizacao := 0;
   ValidadeMinutos := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   RawJSON := '';
end;

{ TTRNCentreAutorizacaoRequest }

procedure TTRNCentreAutorizacaoRequest.Clear;
begin
   NumeroPreAutorizacao := '';
   NSU := '';
   NumeroVenda := '';
   Operador.Clear;
end;

{ TTRNCentreAutorizacaoResponse }

procedure TTRNCentreAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := tsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   RawJSON := '';
end;

{ TTRNCentreCancelamentoRequest }

procedure TTRNCentreCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Operador.Clear;
end;

{ TTRNCentreCancelamentoResponse }

procedure TTRNCentreCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := tsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   RawJSON := '';
end;

{ TTRNCentreProdutoCache }

constructor TTRNCentreProdutoCache.Create;
begin
   inherited;
   FProdutos := TDictionary<string, TTRNCentreProduto>.Create;
   FDataAtualizacao := 0;
end;

destructor TTRNCentreProdutoCache.Destroy;
begin
   FProdutos.Free;
   inherited;
end;

procedure TTRNCentreProdutoCache.Add(const AProduto: TTRNCentreProduto);
begin
   FProdutos.AddOrSetValue(AProduto.CodigoBarras, AProduto);
end;

function TTRNCentreProdutoCache.Get(const ACodigoBarras: string): TTRNCentreProduto;
begin
   if not FProdutos.TryGetValue(ACodigoBarras, Result) then
      Result := Default(TTRNCentreProduto);
end;

function TTRNCentreProdutoCache.Exists(const ACodigoBarras: string): Boolean;
begin
   Result := FProdutos.ContainsKey(ACodigoBarras);
end;

procedure TTRNCentreProdutoCache.Clear;
begin
   FProdutos.Clear;
   FDataAtualizacao := 0;
end;

function TTRNCentreProdutoCache.Count: Integer;
begin
   Result := FProdutos.Count;
end;

function TTRNCentreProdutoCache.NeedRefresh(AHoras: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (HoursBetween(Now, FDataAtualizacao) > AHoras);
end;

procedure TTRNCentreProdutoCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

{ TTRNCentreProgramaCache }

constructor TTRNCentreProgramaCache.Create;
begin
   inherited;
   FProgramas := TDictionary<string, TTRNCentrePrograma>.Create;
   FDataAtualizacao := 0;
end;

destructor TTRNCentreProgramaCache.Destroy;
begin
   FProgramas.Free;
   inherited;
end;

procedure TTRNCentreProgramaCache.Add(const APrograma: TTRNCentrePrograma);
begin
   FProgramas.AddOrSetValue(APrograma.Codigo, APrograma);
end;

function TTRNCentreProgramaCache.Get(const ACodigo: string): TTRNCentrePrograma;
begin
   if not FProgramas.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TTRNCentreProgramaCache.Exists(const ACodigo: string): Boolean;
begin
   Result := FProgramas.ContainsKey(ACodigo);
end;

procedure TTRNCentreProgramaCache.Clear;
begin
   FProgramas.Clear;
   FDataAtualizacao := 0;
end;

function TTRNCentreProgramaCache.Count: Integer;
begin
   Result := FProgramas.Count;
end;

function TTRNCentreProgramaCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TTRNCentreProgramaCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

function TTRNCentreProgramaCache.GetAll: TTRNCentreProgramas;
var
   I: Integer;
   LPair: TPair<string, TTRNCentrePrograma>;
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
