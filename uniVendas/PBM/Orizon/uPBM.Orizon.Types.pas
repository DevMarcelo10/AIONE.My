unit uPBM.Orizon.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints da API Orizon</summary>
   TOrizonEndpoints = record
   const
      // Produção
      PRODUCAO_URL = 'https://api.orizonbrasil.com.br/pbm/v1';
      
      // Homologação
      HOMOLOGACAO_URL = 'https://api-hml.orizonbrasil.com.br/pbm/v1';
      
      // Endpoints
      AUTH = '/auth/token';
      ELEGIBILIDADE = '/elegibilidade';
      AUTORIZACAO = '/autorizacao';
      CANCELAMENTO = '/cancelamento';
      CONSULTA_PRODUTO = '/produto';
      CONSULTA_TRANSACAO = '/transacao';
   end;

   /// <summary>Status de retorno Orizon</summary>
   TOrizonStatus = (
      osAutorizado,      // Transação autorizada
      osNegado,          // Transação negada
      osCancelado,       // Transação cancelada
      osPendente,        // Aguardando processamento
      osErroConexao,     // Erro de conexão
      osErroAutenticacao,// Erro de autenticação (API Key/Login inválido)
      osErroValidacao,   // Erro de validação de dados
      osTimeout          // Timeout na comunicação
   );

   /// <summary>Tipo de desconto Orizon</summary>
   TOrizonTipoDesconto = (
      tdPBM,             // Desconto padrão PBM
      tdFolha,           // Desconto em folha de pagamento
      tdEmpresa          // Desconto empresa/convênio
   );

   /// <summary>Tipo de uso do medicamento</summary>
   TOrizonTipoUso = (
      tuNormal,          // Uso normal/eventual
      tuContinuo         // Uso contínuo (requer receita)
   );

   /// <summary>Dados do plano/convênio</summary>
   TOrizonPlano = record
      Codigo: string;           // Código do plano
      Nome: string;             // Nome do plano
      Operadora: string;        // Nome da operadora
      CodigoANS: string;        // Registro ANS da operadora
      class function Create(const ACodigo, ANome: string): TOrizonPlano; static;
      procedure Clear;
   end;

   /// <summary>Produto para autorização</summary>
   TOrizonProduto = record
      CodigoBarras: string;     // EAN 13
      Descricao: string;        // Descrição do produto
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorFinal: Currency;     // Valor que o cliente paga
      PercentualDesconto: Double;
      TipoUso: TOrizonTipoUso;
      Autorizado: Boolean;
      CodigoRejeicao: string;
      MensagemRejeicao: string;
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TOrizonProduto; static;
   end;

   TOrizonProdutos = TArray<TOrizonProduto>;

   /// <summary>Dados do beneficiário</summary>
   TOrizonBeneficiario = record
      Matricula: string;        // Número do cartão/matrícula
      CPF: string;
      Nome: string;
      DataNascimento: TDateTime;
      Plano: TOrizonPlano;
      Ativo: Boolean;
      TipoDesconto: TOrizonTipoDesconto;
      procedure Clear;
   end;

   /// <summary>Dados da receita (para uso contínuo)</summary>
   TOrizonReceita = record
      CRM: string;
      UFMedico: string;
      NomeMedico: string;
      DataReceita: TDateTime;
      NumeroReceita: string;
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TOrizonEstabelecimento = record
      CNPJ: string;
      CodigoRede: string;       // Código da rede (6 dígitos)
      CodigoFilial: string;     // Código da filial (9 dígitos)
      Login: string;            // Login no portal Orizon
      Senha: string;            // Senha do portal
      APIKey: string;           // X-API-KEY fornecida pela Orizon
      procedure Clear;
      function GetContrato: string; // Retorna código completo (15 dígitos)
   end;

   /// <summary>Dados do vendedor/atendente</summary>
   TOrizonVendedor = record
      CPF: string;
      Nome: string;
      Matricula: string;
      procedure Clear;
   end;

   /// <summary>Request de elegibilidade (consulta beneficiário)</summary>
   TOrizonElegibilidadeRequest = record
      Matricula: string;
      CodigoPlano: string;
      procedure Clear;
   end;

   /// <summary>Response de elegibilidade</summary>
   TOrizonElegibilidadeResponse = record
      Sucesso: Boolean;
      Status: TOrizonStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      Beneficiario: TOrizonBeneficiario;
      Elegivel: Boolean;
      DataValidade: TDateTime;
      LimiteDisponivel: Currency;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de autorização</summary>
   TOrizonAutorizacaoRequest = record
      Beneficiario: TOrizonBeneficiario;
      Vendedor: TOrizonVendedor;
      Produtos: TOrizonProdutos;
      Receita: TOrizonReceita;      // Opcional, para uso contínuo
      ValorTotal: Currency;
      NumeroVenda: string;          // ID único da venda no seu sistema
      DataHoraVenda: TDateTime;
      InformarReceita: Boolean;     // Se deve enviar dados da receita
      DescontoEmFolha: Boolean;     // Se o desconto é em folha
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TOrizonAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TOrizonStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSU: string;                  // Número Sequencial Único da Orizon
      CodigoAutorizacao: string;
      DataHoraAutorizacao: TDateTime;
      Produtos: TOrizonProdutos;    // Produtos com status individual
      ValorTotalDesconto: Currency;
      ValorTotalFinal: Currency;    // Valor que o cliente paga
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TOrizonCancelamentoRequest = record
      NSU: string;                  // NSU da transação original
      NumeroVenda: string;          // ID da venda original
      Motivo: string;
      Vendedor: TOrizonVendedor;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TOrizonCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TOrizonStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NSUCancelamento: string;
      DataHoraCancelamento: TDateTime;
      RawJSON: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns da Orizon</summary>
   TOrizonCodigosRetorno = record
   const
      SUCESSO = '00';
      BENEFICIARIO_NAO_ENCONTRADO = '01';
      BENEFICIARIO_INATIVO = '02';
      PRODUTO_NAO_CADASTRADO = '03';
      LIMITE_EXCEDIDO = '04';
      TRANSACAO_JA_CANCELADA = '05';
      TRANSACAO_NAO_ENCONTRADA = '06';
      ERRO_AUTENTICACAO = '07';
      ERRO_VALIDACAO = '08';
      TIMEOUT = '09';
      ERRO_INTERNO = '99';
   end;

   /// <summary>Lista de planos disponíveis (cache)</summary>
   TOrizonPlanosList = class
   private
      FPlanos: TDictionary<string, TOrizonPlano>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const APlano: TOrizonPlano);
      function Get(const ACodigo: string): TOrizonPlano;
      function Exists(const ACodigo: string): Boolean;
      procedure Clear;
      function Count: Integer;
   end;

implementation

{ TOrizonPlano }

class function TOrizonPlano.Create(const ACodigo, ANome: string): TOrizonPlano;
begin
   Result.Codigo := ACodigo;
   Result.Nome := ANome;
   Result.Operadora := '';
   Result.CodigoANS := '';
end;

procedure TOrizonPlano.Clear;
begin
   Self := Default(TOrizonPlano);
end;

{ TOrizonProduto }

class function TOrizonProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TOrizonProduto;
begin
   Result := Default(TOrizonProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.TipoUso := tuNormal;
   Result.Autorizado := False;
end;

{ TOrizonBeneficiario }

procedure TOrizonBeneficiario.Clear;
begin
   Matricula := '';
   CPF := '';
   Nome := '';
   DataNascimento := 0;
   Plano.Clear;
   Ativo := False;
   TipoDesconto := tdPBM;
end;

{ TOrizonReceita }

procedure TOrizonReceita.Clear;
begin
   Self := Default(TOrizonReceita);
end;

{ TOrizonEstabelecimento }

procedure TOrizonEstabelecimento.Clear;
begin
   Self := Default(TOrizonEstabelecimento);
end;

function TOrizonEstabelecimento.GetContrato: string;
begin
   // Formato: 6 dígitos rede + 9 dígitos filial = 15 dígitos
   Result := CodigoRede.PadLeft(6, '0') + CodigoFilial.PadLeft(9, '0');
end;

{ TOrizonVendedor }

procedure TOrizonVendedor.Clear;
begin
   Self := Default(TOrizonVendedor);
end;

{ TOrizonElegibilidadeRequest }

procedure TOrizonElegibilidadeRequest.Clear;
begin
   Matricula := '';
   CodigoPlano := '';
end;

{ TOrizonElegibilidadeResponse }

procedure TOrizonElegibilidadeResponse.Clear;
begin
   Sucesso := False;
   Status := osNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   Beneficiario.Clear;
   Elegivel := False;
   DataValidade := 0;
   LimiteDisponivel := 0;
   RawJSON := '';
end;

{ TOrizonAutorizacaoRequest }

procedure TOrizonAutorizacaoRequest.Clear;
begin
   Beneficiario.Clear;
   Vendedor.Clear;
   SetLength(Produtos, 0);
   Receita.Clear;
   ValorTotal := 0;
   NumeroVenda := '';
   DataHoraVenda := 0;
   InformarReceita := False;
   DescontoEmFolha := False;
end;

{ TOrizonAutorizacaoResponse }

procedure TOrizonAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := osNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSU := '';
   CodigoAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalDesconto := 0;
   ValorTotalFinal := 0;
   RawJSON := '';
end;

{ TOrizonCancelamentoRequest }

procedure TOrizonCancelamentoRequest.Clear;
begin
   NSU := '';
   NumeroVenda := '';
   Motivo := '';
   Vendedor.Clear;
end;

{ TOrizonCancelamentoResponse }

procedure TOrizonCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := osNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NSUCancelamento := '';
   DataHoraCancelamento := 0;
   RawJSON := '';
end;

{ TOrizonPlanosList }

constructor TOrizonPlanosList.Create;
begin
   inherited;
   FPlanos := TDictionary<string, TOrizonPlano>.Create;
end;

destructor TOrizonPlanosList.Destroy;
begin
   FPlanos.Free;
   inherited;
end;

procedure TOrizonPlanosList.Add(const APlano: TOrizonPlano);
begin
   FPlanos.AddOrSetValue(APlano.Codigo, APlano);
end;

function TOrizonPlanosList.Get(const ACodigo: string): TOrizonPlano;
begin
   if not FPlanos.TryGetValue(ACodigo, Result) then
      Result.Clear;
end;

function TOrizonPlanosList.Exists(const ACodigo: string): Boolean;
begin
   Result := FPlanos.ContainsKey(ACodigo);
end;

procedure TOrizonPlanosList.Clear;
begin
   FPlanos.Clear;
end;

function TOrizonPlanosList.Count: Integer;
begin
   Result := FPlanos.Count;
end;

end.
