unit uPBM.FarmaciaPopular.Types;

interface

uses
   System.SysUtils, System.Classes, System.Generics.Collections;

type
   /// <summary>Endpoints do Farmácia Popular DATASUS</summary>
   TFPEndpoints = record
   const
      // Produção
      PRODUCAO_WSDL = 'https://servicos.saude.gov.br/fpopular/services/ServicoSolicitacaoWS?wsdl';
      PRODUCAO_URL = 'https://servicos.saude.gov.br/fpopular/services/ServicoSolicitacaoWS';
      PORTAL_PRODUCAO = 'https://aplicacao.saude.gov.br/portalfarmacia/';
      
      // Homologação
      HOMOLOGACAO_WSDL = 'https://servicos-datasus.saude.gov.br/fpopular-homologa/services/ServicoSolicitacaoWS?wsdl';
      HOMOLOGACAO_URL = 'https://servicos-datasus.saude.gov.br/fpopular-homologa/services/ServicoSolicitacaoWS';
      PORTAL_HOMOLOGACAO = 'https://farmaciapopular-portal-homologacao.saude.gov.br/';
   end;

   /// <summary>Tipo de operação SOAP</summary>
   TFPOperacao = (
      fpAutorizarVenda,
      fpCancelarVenda,
      fpConsultarVenda,
      fpConsultarProduto,
      fpConsultarPaciente
   );

   /// <summary>Status do retorno DATASUS</summary>
   TFPStatus = (
      fpsAutorizado,       // 0 - Autorizado
      fpsNegado,           // 1 - Negado
      fpsCancelado,        // 2 - Cancelado
      fpsErroConexao,      // 3 - Erro de conexão
      fpsErroAutenticacao, // 4 - Erro de autenticação
      fpsErroValidacao,    // 5 - Erro de validação de dados
      fpsTimeout           // 6 - Timeout
   );

   /// <summary>Tipo de gratuidade</summary>
   TFPTipoGratuidade = (
      tgNenhuma,           // Sem gratuidade
      tgHipertensao,       // Saúde Não Tem Preço - Hipertensão
      tgDiabetes,          // Saúde Não Tem Preço - Diabetes
      tgAsma,              // Saúde Não Tem Preço - Asma
      tgSubsidiado         // Medicamento subsidiado (até 90% desconto)
   );

   /// <summary>Produto para autorização FP</summary>
   TFPProduto = record
      CodigoBarras: string;        // EAN 13
      CodigoMS: string;            // Código Ministério da Saúde
      Quantidade: Double;
      ValorUnitario: Currency;
      ValorTotal: Currency;
      ValorDesconto: Currency;
      ValorSubsidio: Currency;     // Valor pago pelo governo
      ValorPaciente: Currency;     // Valor pago pelo paciente
      TipoGratuidade: TFPTipoGratuidade;
      Autorizado: Boolean;
      MensagemRejeicao: string;
      class function Create(const ACodigoBarras: string; AQtd: Double; AValorUnit: Currency): TFPProduto; static;
   end;

   TFPProdutos = TArray<TFPProduto>;

   /// <summary>Dados do paciente/beneficiário</summary>
   TFPPaciente = record
      CPF: string;
      Nome: string;
      DataNascimento: TDateTime;
      NomeMae: string;
      Sexo: string;               // M ou F
      CNS: string;                // Cartão Nacional de Saúde (opcional)
      Telefone: string;
      procedure Clear;
   end;

   /// <summary>Dados da receita médica</summary>
   TFPReceita = record
      CRM: string;                 // CRM do médico
      UFMedico: string;            // UF do CRM
      DataReceita: TDateTime;
      NumeroReceita: string;       // Opcional
      procedure Clear;
   end;

   /// <summary>Dados do estabelecimento</summary>
   TFPEstabelecimento = record
      CNPJ: string;
      CNES: string;               // Código Nacional Estabelecimento Saúde
      Usuario: string;            // Login DATASUS
      Senha: string;              // Senha DATASUS
      CodigoIBGE: string;         // Município
      procedure Clear;
   end;

   /// <summary>Dados do vendedor/atendente</summary>
   TFPVendedor = record
      CPF: string;
      Nome: string;
      Login: string;              // Login no DATASUS (9 caracteres)
      procedure Clear;
   end;

   /// <summary>Request de autorização</summary>
   TFPAutorizacaoRequest = record
      Paciente: TFPPaciente;
      Receita: TFPReceita;
      Vendedor: TFPVendedor;
      Produtos: TFPProdutos;
      ValorTotal: Currency;
      NumeroVenda: string;        // ID único da venda no seu sistema
      DataHoraVenda: TDateTime;
      procedure Clear;
   end;

   /// <summary>Response de autorização</summary>
   TFPAutorizacaoResponse = record
      Sucesso: Boolean;
      Status: TFPStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      NumeroAutorizacao: string;   // NSU do DATASUS
      DataHoraAutorizacao: TDateTime;
      Produtos: TFPProdutos;       // Produtos com status individual
      ValorTotalSubsidio: Currency;
      ValorTotalPaciente: Currency;
      XMLEnvio: string;
      XMLRetorno: string;
      procedure Clear;
   end;

   /// <summary>Request de cancelamento</summary>
   TFPCancelamentoRequest = record
      NumeroAutorizacao: string;   // NSU original
      NumeroVenda: string;         // ID da venda original
      Motivo: string;
      Vendedor: TFPVendedor;
      procedure Clear;
   end;

   /// <summary>Response de cancelamento</summary>
   TFPCancelamentoResponse = record
      Sucesso: Boolean;
      Status: TFPStatus;
      CodigoRetorno: string;
      MensagemRetorno: string;
      DataHoraCancelamento: TDateTime;
      XMLEnvio: string;
      XMLRetorno: string;
      procedure Clear;
   end;

   /// <summary>Códigos de retorno comuns do DATASUS</summary>
   TFPCodigosRetorno = record
   const
      AUTORIZADO = '0';
      PACIENTE_NAO_ENCONTRADO = '1';
      PRODUTO_NAO_CADASTRADO = '2';
      PRODUTO_SEM_ESTOQUE = '3';
      RECEITA_VENCIDA = '4';
      LIMITE_MENSAL_ATINGIDO = '5';
      CRM_INVALIDO = '6';
      CPF_INVALIDO = '7';
      ERRO_AUTENTICACAO = '8';
      ERRO_CONEXAO = '9';
      VENDA_JA_CANCELADA = '10';
      VENDA_NAO_ENCONTRADA = '11';
   end;

implementation

{ TFPProduto }

class function TFPProduto.Create(const ACodigoBarras: string; AQtd: Double;
   AValorUnit: Currency): TFPProduto;
begin
   Result := Default(TFPProduto);
   Result.CodigoBarras := ACodigoBarras;
   Result.Quantidade := AQtd;
   Result.ValorUnitario := AValorUnit;
   Result.ValorTotal := AValorUnit * AQtd;
   Result.Autorizado := False;
end;

{ TFPPaciente }

procedure TFPPaciente.Clear;
begin
   Self := Default(TFPPaciente);
end;

{ TFPReceita }

procedure TFPReceita.Clear;
begin
   Self := Default(TFPReceita);
end;

{ TFPEstabelecimento }

procedure TFPEstabelecimento.Clear;
begin
   Self := Default(TFPEstabelecimento);
end;

{ TFPVendedor }

procedure TFPVendedor.Clear;
begin
   Self := Default(TFPVendedor);
end;

{ TFPAutorizacaoRequest }

procedure TFPAutorizacaoRequest.Clear;
begin
   Paciente.Clear;
   Receita.Clear;
   Vendedor.Clear;
   SetLength(Produtos, 0);
   ValorTotal := 0;
   NumeroVenda := '';
   DataHoraVenda := 0;
end;

{ TFPAutorizacaoResponse }

procedure TFPAutorizacaoResponse.Clear;
begin
   Sucesso := False;
   Status := fpsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   NumeroAutorizacao := '';
   DataHoraAutorizacao := 0;
   SetLength(Produtos, 0);
   ValorTotalSubsidio := 0;
   ValorTotalPaciente := 0;
   XMLEnvio := '';
   XMLRetorno := '';
end;

{ TFPCancelamentoRequest }

procedure TFPCancelamentoRequest.Clear;
begin
   NumeroAutorizacao := '';
   NumeroVenda := '';
   Motivo := '';
   Vendedor.Clear;
end;

{ TFPCancelamentoResponse }

procedure TFPCancelamentoResponse.Clear;
begin
   Sucesso := False;
   Status := fpsNegado;
   CodigoRetorno := '';
   MensagemRetorno := '';
   DataHoraCancelamento := 0;
   XMLEnvio := '';
   XMLRetorno := '';
end;

end.
