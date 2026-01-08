unit uPBM.Pharmalink.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API Pharmalink / PharmaSystem</summary>
   TPharmalinkEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://ws.pharmalinkonline.com.br/PharmaSystem/services';
      WSDL_PRODUCAO = 'https://ws.pharmalinkonline.com.br/PharmaSystem/services?wsdl';
      PORTAL_PRODUCAO = 'https://portal.pharmalinkonline.com.br';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://ws-hml.pharmalinkonline.com.br/PharmaSystem/services';
      WSDL_HOMOLOGACAO = 'https://ws-hml.pharmalinkonline.com.br/PharmaSystem/services?wsdl';
      PORTAL_HOMOLOGACAO = 'https://portal-hml.pharmalinkonline.com.br';
      
      // REST API (alternativo)
      REST_PRODUCAO = 'https://api.pharmalinkonline.com.br/v1';
      REST_HOMOLOGACAO = 'https://api-hml.pharmalinkonline.com.br/v1';
      
      // Operações SOAP
      OP_CONSULTA_ELEGIBILIDADE = 'consultarElegibilidade';
      OP_CONSULTA_PRODUTO = 'consultarProduto';
      OP_PRE_AUTORIZAR = 'preAutorizar';
      OP_AUTORIZAR = 'autorizar';
      OP_CANCELAR = 'cancelar';
      OP_CONSULTAR_TRANSACAO = 'consultarTransacao';
      OP_LISTAR_PROGRAMAS = 'listarProgramas';
   end;

   /// <summary>Status de retorno Pharmalink</summary>
   TPharmalinkStatus = (
      psAutorizado,       // Transação autorizada
      psPreAutorizado,    // Pré-autorização concedida
      psNegado,           // Transação negada
      psCancelado,        // Transação cancelada
      psPendente,         // Aguardando processamento
      psErroConexao,      // Erro de conexão
      psErroAutenticacao, // Erro de autenticação
      psErroValidacao,    // Erro de validação de dados
      psTimeout           // Timeout na comunicação
   );

   /// <summary>Tipo de programa/convênio</summary>
   TPharmalinkTipoPrograma = (
      tpProgramaIndustria,  // Programa de desconto da indústria
      tpConvenioEmpresa,    // Convênio corporativo
      tpFidelidade,         // Programa de fidelidade
      tpCampanha            // Campanha promocional
   );

   /// <summary>Dados do programa/convênio</summary>
   TPharmalinkPrograma = record
      Codigo: string;
      Nome: string;
      Tipo: TPharmalinkTipoPrograma;
      Laboratorio: string;
      Ativo: Boolean;
      DataInicio: TDateTime;
      DataFim: TDateTime;
      PercentualDesconto: Double;
      class function Create(const ACodigo, ANome: string): TPharmalinkPrograma; static;
      procedure Clear;
   end;

   TPharmalinkProgramas = TArray<TPharmalinkPrograma>;

   /// <summary>Produto para autorização</summary>
   TPharmalinkProduto = record
      CodigoBarras: string;     // EAN 13
      Descricao: string;
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;     // Valor que o cliente paga
      PercentualDesconto: Double;
      Autorizado: Boolean;
      CodigoPrograma: string;
      NomePrograma: string;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      RequerReceita: Boolean;
      TipoReceita: string;      // BRANCA, AZUL, AMARELA, etc.
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TPharmalinkProduto; static;
   end;

   TPharmalinkProdutos = TArray<TPharmalinkProduto>;

   /// <summary>Dados do paciente/beneficiário</summary>
   TPharmalinkPaciente = record
      CPF: string;
      Nome: string;
      DataNascimento: TDateTime;
      Telefone: string;
      Email: string;
      CodigoCadastro: string;   // ID no programa
      Programa: TPharmalinkPrograma;
      Ativo: Boolean;
      procedure Clear;
   end;

   /// <summary>Dados da receita médica</summary>
   TPharmalinkReceita = record
      CRM: string;
      UFMedico: string;
      NomeMedico: string;
      DataReceita: TDateTime;
      NumeroReceita: string;
      TipoReceita: string;      // BRANCA, AZUL, AMARELA
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TPharmalinkEstabelecimento = record
      CNPJ: string;
      NumeroAutenticacao: string;   // Número fornecido pela Pharmalink
      CodigoTerminal: string;       // Código do terminal (ex: 000001)
      RazaoSocial: string;
      UF: string;
      procedure Clear;
   end;

   /// <summary>Dados do operador/atendente</summary>
   TPharmalinkOperador = record
      CPF: string;
      Nome: string;
      Matricula: string;
      procedure Clear;
   end;

   /// <summary>Request de elegibilidade</summary>
   TPharmalinkElegibilidadeRequest = record
      CPF: string;
      CodigoPrograma: string;      // Opcional, filtra por programa
      CodigoBarras: string;        // Opcional, verifica elegibilidade para produto específico
      procedure Clear;
   end;

   /// <summary>Response de elegibilidade</summary>
   TPharmalinkElegibilidadeResponse = record
      Sucesso: Boolean;
      Status: TPharmalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Paciente: TPharmalinkPaciente;
      Elegivel: Boolean;
      ProgramasDisponiveis: TPharmalinkProgramas;
      RawResponse: string;
      procedure Clear;
   end;

   /// <summary>Request de pré-autorização</summary>
   TPharmalinkPreAutorizacaoRequest = record
      Paciente: TPharmalinkPaciente;
      Operador: TPharmalinkOperador;
      Produtos: TPharmalinkProdutos;
      Receita: TPharmalinkReceita;
      ValorTotal: Currency;
      NumeroVenda: string;
      DataHoraVenda: TDateTime;
      InformarReceita: Boolean;
      procedure Clear;
   end;

   /// <summary>Response de pré-autorização</summary>
   TPharmalinkPreAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TPharmalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NumeroPreAutorizacao: string;
      CodigoTransacao: string;
      DataHoraPreAutorizacao: TDateTime;
      ValidadeMinutos: Integer;
      Produtos: TPharmalinkProdutos;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      RawResponse: string;
      procedure Clear;
   end;

   /// <summary>Request de autorização (confirmação)</summary>
   TPharmalinkAutorizacaoRequest = record
      NumeroPreAutorizacao: string;
      CodigoTransacao: string;
      NumeroVenda: string;
      Operador: TPharmalinkOperador;
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TPharmalinkAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TPharmalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;
      NumeroAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;
      RawResponse: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TPharmalinkCancelamentoRequest = record
      NSU: string;
      NumeroAutorizacao: string;
      NumeroVenda: string;
      Motivo: string;
      Operador: TPharmalinkOperador;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TPharmalinkCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TPharmalinkStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      RawResponse: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns do Pharmalink</summary>
   TPharmalinkCodigosRetorno = record
   const
      SUCESSO = '00';
      PRE_AUTORIZADO = '01';
      PACIENTE_NAO_ENCONTRADO = '10';
      PACIENTE_INATIVO = '11';
      PRODUTO_NAO_CADASTRADO = '20';
      PRODUTO_SEM_PROGRAMA = '21';
      QUANTIDADE_EXCEDIDA = '22';
      PROGRAMA_INATIVO = '30';
      PROGRAMA_EXPIRADO = '31';
      RECEITA_OBRIGATORIA = '40';
      RECEITA_VENCIDA = '41';
      CRM_INVALIDO = '42';
      PRE_AUTORIZACAO_EXPIRADA = '50';
      TRANSACAO_JA_CANCELADA = '51';
      TRANSACAO_NAO_ENCONTRADA = '52';
      TERMINAL_INVALIDO = '60';
      AUTENTICACAO_INVALIDA = '61';
      ERRO_VALIDACAO = '91';
      TIMEOUT = '98';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Cache de programas disponíveis</summary>
   TPharmalinkProgramaCache = class
   private
      FProgramas: TDictionary<string, TPharmalinkPrograma>;
      FDataAtualizacao: TDateTime;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const APrograma: TPharmalinkPrograma);
      function Get(const ACodigo: string): TPharmalinkPrograma;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
      function NeedRefresh(AMinutos: Integer = 60): Boolean;
      procedure SetUpdated;
      function GetAll: TPharmalinkProgramas;
   end;

implementation

{ TPharmalinkPrograma }

class function TPharmalinkPrograma.Create(const ACodigo, ANome: string): TPharmalinkPrograma;
begin
   Result := Default(TPharmalinkPrograma);
   Result.Codigo := ACodigo;
   Result.Nome := ANome;
   Result.Ativo := True;
end;

procedure TPharmalinkPrograma.Clear;
begin
   Self := Default(TPharmalinkPrograma);
end;

{ TPharmalinkProduto }

class function TPharmalinkProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TPharmalinkProduto;
begin
   Result := Default(TPharmalinkProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
   Result.RequerReceita := False;
end;

{ TPharmalinkPaciente }

procedure TPharmalinkPaciente.Clear;
begin
   CPF := '';
   Nome := '';
   DataNascimento := 0;
   Telefone := '';
   Email := '';
   CodigoCadastro := '';
   Programa.Clear;
   Ativo := False;
end;

{ TPharmalinkReceita }

procedure TPharmalinkReceita.Clear;
begin
   Self := Default(TPharmalinkReceita);
end;

{ TPharmalinkEstabelecimento }

procedure TPharmalinkEstabelecimento.Clear;
begin
   Self := Default(TPharmalinkEstabelecimento);
end;

{ TPharmalinkOperador }

procedure TPharmalinkOperador.Clear;
begin
   Self := Default(TPharmalinkOperador);
end;

{ TPharmalinkElegibilidadeRequest }

procedure TPharmalinkElegibilidadeRequest.Clear;
begin
   CPF := '';
   CodigoPrograma := '';
   CodigoBarras := '';
end;

{ TPharmalinkElegibilidadeResponse }

procedure TPharmalinkElegibilidadeResponse.Clear;
begin
   Sucesso := False;
   Status := psNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Paciente.Clear;
   Elegivel := False;
   SetLength(ProgramasDisponiveis, 0);
   RawResponse := '';
end;

{ TPharmalinkPreAutorizacaoRequest }

procedure TPharmalinkPreAutorizacaoRequest.Clear;
begin
   Paciente.Clear;
   Operador.Clear;
   SetLength(Produtos, 0);
   Receita.Clear;
   ValorTotal := 0;
   NumeroVenda := '';
   DataHoraVenda := 0;
   InformarReceita := False;
end;

{ TPharmalinkPreAutorizacaoResponse }

procedure TPharmalinkPreAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := psNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NumeroPreAutorizacao := '';
   CodigoTransacao := '';
   DataHoraPreAutorizacao := 0;
   ValidadeMinutos := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   RawResponse := '';
end;

{ TPharmalinkAutorizacaoRequest }

procedure TPharmalinkAutorizacaoRequest.Clear;
begin
   NumeroPreAutorizacao := '';
   CodigoTransacao := '';
   NumeroVenda := '';
   Operador.Clear;
end;

{ TPharmalinkAutorizacaoResponse }

procedure TPharmalinkAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := psNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   RawResponse := '';
end;

{ TPharmalinkCancelamentoRequest }

procedure TPharmalinkCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Operador.Clear;
end;

{ TPharmalinkCancelamentoResponse }

procedure TPharmalinkCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := psNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   RawResponse := '';
end;

{ TPharmalinkProgramaCache }

constructor TPharmalinkProgramaCache.Create;
begin
   inherited;
   FProgramas := TDictionary<string, TPharmalinkPrograma>.Create;
   FDataAtualizacao := 0;
end;

destructor TPharmalinkProgramaCache.Destroy;
begin
   FProgramas.Free;
   inherited;
end;

procedure TPharmalinkProgramaCache.Add(const APrograma: TPharmalinkPrograma);
begin
   FProgramas.AddOrSetValue(APrograma.Codigo, APrograma);
end;

function TPharmalinkProgramaCache.Get(const ACodigo: string): TPharmalinkPrograma;
begin
   if not FProgramas.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TPharmalinkProgramaCache.Exists(const ACodigo: string): Boolean;
begin
   Result := FProgramas.ContainsKey(ACodigo);
end;

procedure TPharmalinkProgramaCache.Clear;
begin
   FProgramas.Clear;
   FDataAtualizacao := 0;
end;

function TPharmalinkProgramaCache.Count: Integer;
begin
   Result := FProgramas.Count;
end;

function TPharmalinkProgramaCache.NeedRefresh(AMinutos: Integer): Boolean;
begin
   Result := (FDataAtualizacao = 0) or (MinutesBetween(Now, FDataAtualizacao) > AMinutos);
end;

procedure TPharmalinkProgramaCache.SetUpdated;
begin
   FDataAtualizacao := Now;
end;

function TPharmalinkProgramaCache.GetAll: TPharmalinkProgramas;
var
   I: Integer;
   LPair: TPair<string, TPharmalinkPrograma>;
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
