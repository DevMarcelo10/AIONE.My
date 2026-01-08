unit uPBM.PECFebrafar;

interface

uses
   System.SysUtils, System.Classes, System.JSON, System.DateUtils,
   System.NetEncoding, System.Net.HttpClient, System.Net.URLClient,
   System.SyncObjs, System.Generics.Collections,
   uPBM.Interfaces, uPBM.Base, uPBM.PECFebrafar.Types;

type
   /// <summary>Builder de requisições JSON para PEC Febrafar</summary>
   TPECFebrafarJSONBuilder = class
   private
      class function FormatDateTime(AValue: TDateTime): string;
      class function FormatDate(AValue: TDateTime): string;
   public
      class function BuildAuth(const ACodigoAcesso, ASenha, ACodigoEmpresa: string): string;
      class function BuildConsultaCliente(const AEstab: TPECFebrafarEstabelecimento;
         const ARequest: TPECFebrafarClienteRequest): string;
      class function BuildCadastroCliente(const AEstab: TPECFebrafarEstabelecimento;
         const ARequest: TPECFebrafarCadastroClienteRequest): string;
      class function BuildPreAutorizacao(const AEstab: TPECFebrafarEstabelecimento;
         const ARequest: TPECFebrafarPreAutorizacaoRequest): string;
      class function BuildAutorizacao(const AEstab: TPECFebrafarEstabelecimento;
         const ARequest: TPECFebrafarAutorizacaoRequest): string;
      class function BuildCancelamento(const AEstab: TPECFebrafarEstabelecimento;
         const ARequest: TPECFebrafarCancelamentoRequest): string;
   end;

   /// <summary>Parser de respostas JSON do PEC Febrafar</summary>
   TPECFebrafarJSONParser = class
   private
      class function GetString(AObj: TJSONObject; const APath: string; const ADefault: string = ''): string;
      class function GetDouble(AObj: TJSONObject; const APath: string; ADefault: Double = 0): Double;
      class function GetBool(AObj: TJSONObject; const APath: string; ADefault: Boolean = False): Boolean;
      class function GetDateTime(AObj: TJSONObject; const APath: string): TDateTime;
      class function GetInt(AObj: TJSONObject; const APath: string; ADefault: Integer = 0): Integer;
      class function ParseTipoDesconto(const AValue: string): TPECFebrafarTipoDesconto;
      class function ParseTipoCliente(const AValue: string): TPECFebrafarTipoCliente;
   public
      class function ParseToken(const AJSON: string): TPECFebrafarToken;
      class function ParseCliente(const AJSON: string): TPECFebrafarClienteResponse;
      class function ParsePreAutorizacao(const AJSON: string): TPECFebrafarPreAutorizacaoResponse;
      class function ParseAutorizacao(const AJSON: string): TPECFebrafarAutorizacaoResponse;
      class function ParseCancelamento(const AJSON: string): TPECFebrafarCancelamentoResponse;
      class function ParseProgramas(const AJSON: string): TPECFebrafarProgramas;
      class function ParseOfertas(const AJSON: string): TPECFebrafarOfertas;
      class function ParseErro(const AJSON: string): string;
   end;

   /// <summary>Cliente REST thread-safe para PEC Febrafar</summary>
   TPECFebrafarClient = class(TInterfacedObject)
   private
      FEstabelecimento: TPECFebrafarEstabelecimento;
      FHomologacao: Boolean;
      FTimeout: Integer;
      FMaxRetries: Integer;
      FUltimoErro: string;
      FOnLog: TPBMLogEvent;
      FLock: TCriticalSection;
      FHTTPClient: THTTPClient;
      FToken: TPECFebrafarToken;
      FProgramas: TPECFebrafarProgramaCache;
      FClientes: TPECFebrafarClienteCache;
      
      procedure Log(const AMsg: string; const ATipo: string = 'INFO');
      function GetBaseURL: string;
      function GetHeaders(AComAuth: Boolean = True): TArray<TPair<string, string>>;
      function Autenticar: Boolean;
      function ExecutarRequest(const AEndpoint, AMetodo, ABody: string;
         out AResponse: string; out AStatusCode: Integer; AComAuth: Boolean = True): Boolean;
      function ValidarEstabelecimento: Boolean;
   public
      constructor Create;
      destructor Destroy; override;
      
      /// Configura dados do estabelecimento
      procedure ConfigurarEstabelecimento(const ACNPJ, ACodigoAcesso, ASenha,
         ACodigoEmpresa, AEnderecoServidor, ARazaoSocial, ACodigoRede, AUF: string);
      
      /// Define ambiente (homologação/produção)
      procedure SetAmbiente(AHomologacao: Boolean);
      
      /// Testa conectividade
      function TestarConexao: Boolean;
      
      /// Carrega lista de programas disponíveis
      function CarregarProgramas: Boolean;
      
      /// Consulta cliente por CPF, telefone ou código
      function ConsultarCliente(const ACPF: string; const ATelefone: string = '';
         const ACodigo: string = ''): TPECFebrafarClienteResponse;
      
      /// Cadastra novo cliente
      function CadastrarCliente(const ARequest: TPECFebrafarCadastroClienteRequest): TPECFebrafarClienteResponse;
      
      /// Lista ofertas disponíveis para o cliente
      function ListarOfertas(const ACPF: string): TPECFebrafarOfertas;
      
      /// Ativa oferta para o cliente
      function AtivarOferta(const ACPF, ACodigoOferta: string): Boolean;
      
      /// Pré-autoriza venda (primeiro passo)
      function PreAutorizarVenda(const ARequest: TPECFebrafarPreAutorizacaoRequest): TPECFebrafarPreAutorizacaoResponse;
      
      /// Autoriza venda (confirma pré-autorização)
      function AutorizarVenda(const ARequest: TPECFebrafarAutorizacaoRequest): TPECFebrafarAutorizacaoResponse;
      
      /// Fluxo completo: pré-autoriza + autoriza
      function VendaCompleta(const ARequest: TPECFebrafarPreAutorizacaoRequest): TPECFebrafarAutorizacaoResponse;
      
      /// Cancela venda
      function CancelarVenda(const ARequest: TPECFebrafarCancelamentoRequest): TPECFebrafarCancelamentoResponse;
      
      /// Consulta saldo de pontos do cliente
      function ConsultarPontos(const ACPF: string): Integer;
      
      property Homologacao: Boolean read FHomologacao write FHomologacao;
      property Timeout: Integer read FTimeout write FTimeout;
      property MaxRetries: Integer read FMaxRetries write FMaxRetries;
      property UltimoErro: string read FUltimoErro;
      property OnLog: TPBMLogEvent read FOnLog write FOnLog;
      property Programas: TPECFebrafarProgramaCache read FProgramas;
      property Clientes: TPECFebrafarClienteCache read FClientes;
   end;

/// <summary>Factory function para criar cliente PEC Febrafar</summary>
function CreatePECFebrafarClient: TPECFebrafarClient;

implementation

function CreatePECFebrafarClient: TPECFebrafarClient;
begin
   Result := TPECFebrafarClient.Create;
end;

{ TPECFebrafarJSONBuilder }

class function TPECFebrafarJSONBuilder.FormatDateTime(AValue: TDateTime): string;
begin
   Result := System.SysUtils.FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', AValue);
end;

class function TPECFebrafarJSONBuilder.FormatDate(AValue: TDateTime): string;
begin
   Result := System.SysUtils.FormatDateTime('yyyy-mm-dd', AValue);
end;

class function TPECFebrafarJSONBuilder.BuildAuth(const ACodigoAcesso, ASenha,
   ACodigoEmpresa: string): string;
var
   LObj: TJSONObject;
begin
   LObj := TJSONObject.Create;
   try
      LObj.AddPair('codigoAcesso', ACodigoAcesso);
      LObj.AddPair('senha', ASenha);
      LObj.AddPair('codigoEmpresa', ACodigoEmpresa);
      LObj.AddPair('grant_type', 'client_credentials');
      Result := LObj.ToString;
   finally
      LObj.Free;
   end;
end;

class function TPECFebrafarJSONBuilder.BuildConsultaCliente(
   const AEstab: TPECFebrafarEstabelecimento;
   const ARequest: TPECFebrafarClienteRequest): string;
var
   LObj: TJSONObject;
begin
   LObj := TJSONObject.Create;
   try
      LObj.AddPair('cnpj', AEstab.CNPJ);
      LObj.AddPair('codigoRede', AEstab.CodigoRede);
      
      if ARequest.CPF <> '' then
         LObj.AddPair('cpf', ARequest.CPF);
      if ARequest.Telefone <> '' then
         LObj.AddPair('telefone', ARequest.Telefone);
      if ARequest.Codigo <> '' then
         LObj.AddPair('codigo', ARequest.Codigo);
         
      Result := LObj.ToString;
   finally
      LObj.Free;
   end;
end;

class function TPECFebrafarJSONBuilder.BuildCadastroCliente(
   const AEstab: TPECFebrafarEstabelecimento;
   const ARequest: TPECFebrafarCadastroClienteRequest): string;
var
   LObj, LCliente: TJSONObject;
begin
   LObj := TJSONObject.Create;
   try
      LObj.AddPair('cnpj', AEstab.CNPJ);
      LObj.AddPair('codigoRede', AEstab.CodigoRede);
      
      LCliente := TJSONObject.Create;
      LCliente.AddPair('cpf', ARequest.Cliente.CPF);
      LCliente.AddPair('nome', ARequest.Cliente.Nome);
      if ARequest.Cliente.DataNascimento > 0 then
         LCliente.AddPair('dataNascimento', FormatDate(ARequest.Cliente.DataNascimento));
      if ARequest.Cliente.Telefone <> '' then
         LCliente.AddPair('telefone', ARequest.Cliente.Telefone);
      if ARequest.Cliente.Celular <> '' then
         LCliente.AddPair('celular', ARequest.Cliente.Celular);
      if ARequest.Cliente.Email <> '' then
         LCliente.AddPair('email', ARequest.Cliente.Email);
      if ARequest.Cliente.CEP <> '' then
         LCliente.AddPair('cep', ARequest.Cliente.CEP);
      if ARequest.Cliente.Endereco <> '' then
         LCliente.AddPair('endereco', ARequest.Cliente.Endereco);
      if ARequest.Cliente.Numero <> '' then
         LCliente.AddPair('numero', ARequest.Cliente.Numero);
      if ARequest.Cliente.Bairro <> '' then
         LCliente.AddPair('bairro', ARequest.Cliente.Bairro);
      if ARequest.Cliente.Cidade <> '' then
         LCliente.AddPair('cidade', ARequest.Cliente.Cidade);
      if ARequest.Cliente.UF <> '' then
         LCliente.AddPair('uf', ARequest.Cliente.UF);
      if ARequest.Cliente.GrupoCliente <> '' then
         LCliente.AddPair('grupoCliente', ARequest.Cliente.GrupoCliente);
         
      LCliente.AddPair('aceitaWhatsApp', TJSONBool.Create(ARequest.Cliente.AceitaWhatsApp));
      LCliente.AddPair('aceitaEmail', TJSONBool.Create(ARequest.Cliente.AceitaEmail));
      LCliente.AddPair('aceitaSMS', TJSONBool.Create(ARequest.Cliente.AceitaSMS));
      
      LObj.AddPair('cliente', LCliente);
      LObj.AddPair('aceitaTermos', TJSONBool.Create(ARequest.AceitaTermos));
      
      Result := LObj.ToString;
   finally
      LObj.Free;
   end;
end;

class function TPECFebrafarJSONBuilder.BuildPreAutorizacao(
   const AEstab: TPECFebrafarEstabelecimento;
   const ARequest: TPECFebrafarPreAutorizacaoRequest): string;
var
   LObj, LCliente, LOper, LProd: TJSONObject;
   LProdutos: TJSONArray;
   I: Integer;
begin
   LObj := TJSONObject.Create;
   try
      LObj.AddPair('cnpj', AEstab.CNPJ);
      LObj.AddPair('codigoRede', AEstab.CodigoRede);
      
      // Cliente
      LCliente := TJSONObject.Create;
      LCliente.AddPair('cpf', ARequest.Cliente.CPF);
      if ARequest.Cliente.Nome <> '' then
         LCliente.AddPair('nome', ARequest.Cliente.Nome);
      LObj.AddPair('cliente', LCliente);
      
      // Operador
      LOper := TJSONObject.Create;
      LOper.AddPair('cpf', ARequest.Operador.CPF);
      LOper.AddPair('nome', ARequest.Operador.Nome);
      if ARequest.Operador.Matricula <> '' then
         LOper.AddPair('matricula', ARequest.Operador.Matricula);
      if ARequest.Operador.CodigoTerminal <> '' then
         LOper.AddPair('terminal', ARequest.Operador.CodigoTerminal);
      LObj.AddPair('operador', LOper);
      
      // Produtos
      LProdutos := TJSONArray.Create;
      for I := Low(ARequest.Produtos) to High(ARequest.Produtos) do
      begin
         LProd := TJSONObject.Create;
         LProd.AddPair('codigoBarras', ARequest.Produtos[I].CodigoBarras);
         if ARequest.Produtos[I].CodigoInterno <> '' then
            LProd.AddPair('codigoInterno', ARequest.Produtos[I].CodigoInterno);
         LProd.AddPair('quantidade', TJSONNumber.Create(ARequest.Produtos[I].Quantidade));
         LProd.AddPair('valorUnitario', TJSONNumber.Create(Double(ARequest.Produtos[I].ValorUnitario)));
         LProd.AddPair('valorTotal', TJSONNumber.Create(Double(ARequest.Produtos[I].ValorTotal)));
         LProdutos.Add(LProd);
      end;
      LObj.AddPair('produtos', LProdutos);
      
      // Venda
      LObj.AddPair('numeroVenda', ARequest.NumeroVenda);
      LObj.AddPair('dataHoraVenda', FormatDateTime(ARequest.DataHoraVenda));
      LObj.AddPair('valorTotal', TJSONNumber.Create(Double(ARequest.ValorTotal)));
      LObj.AddPair('aplicarOfertas', TJSONBool.Create(ARequest.AplicarOfertas));
      
      Result := LObj.ToString;
   finally
      LObj.Free;
   end;
end;

class function TPECFebrafarJSONBuilder.BuildAutorizacao(
   const AEstab: TPECFebrafarEstabelecimento;
   const ARequest: TPECFebrafarAutorizacaoRequest): string;
var
   LObj, LOper: TJSONObject;
begin
   LObj := TJSONObject.Create;
   try
      LObj.AddPair('cnpj', AEstab.CNPJ);
      LObj.AddPair('codigoRede', AEstab.CodigoRede);
      
      LObj.AddPair('numeroPreAutorizacao', ARequest.NumeroPreAutorizacao);
      if ARequest.NSU <> '' then
         LObj.AddPair('nsu', ARequest.NSU);
      LObj.AddPair('numeroVenda', ARequest.NumeroVenda);
      
      LOper := TJSONObject.Create;
      LOper.AddPair('cpf', ARequest.Operador.CPF);
      LOper.AddPair('nome', ARequest.Operador.Nome);
      LObj.AddPair('operador', LOper);
      
      Result := LObj.ToString;
   finally
      LObj.Free;
   end;
end;

class function TPECFebrafarJSONBuilder.BuildCancelamento(
   const AEstab: TPECFebrafarEstabelecimento;
   const ARequest: TPECFebrafarCancelamentoRequest): string;
var
   LObj, LOper: TJSONObject;
begin
   LObj := TJSONObject.Create;
   try
      LObj.AddPair('cnpj', AEstab.CNPJ);
      LObj.AddPair('codigoRede', AEstab.CodigoRede);
      
      if ARequest.NSU <> '' then
         LObj.AddPair('nsu', ARequest.NSU);
      if ARequest.NumeroAutorizacao <> '' then
         LObj.AddPair('numeroAutorizacao', ARequest.NumeroAutorizacao);
      LObj.AddPair('numeroVenda', ARequest.NumeroVenda);
      LObj.AddPair('motivo', ARequest.Motivo);
      
      LOper := TJSONObject.Create;
      LOper.AddPair('cpf', ARequest.Operador.CPF);
      LOper.AddPair('nome', ARequest.Operador.Nome);
      LObj.AddPair('operador', LOper);
      
      Result := LObj.ToString;
   finally
      LObj.Free;
   end;
end;

{ TPECFebrafarJSONParser }

class function TPECFebrafarJSONParser.GetString(AObj: TJSONObject; const APath: string;
   const ADefault: string): string;
var
   LParts: TArray<string>;
   LCurrent: TJSONValue;
   I: Integer;
begin
   Result := ADefault;
   if not Assigned(AObj) then Exit;
   
   LParts := APath.Split(['.']);
   LCurrent := AObj;
   
   for I := Low(LParts) to High(LParts) do
   begin
      if not (LCurrent is TJSONObject) then Exit;
      LCurrent := TJSONObject(LCurrent).GetValue(LParts[I]);
      if not Assigned(LCurrent) then Exit;
   end;
   
   if LCurrent is TJSONString then
      Result := TJSONString(LCurrent).Value
   else if not (LCurrent is TJSONNull) then
      Result := LCurrent.Value;
end;

class function TPECFebrafarJSONParser.GetDouble(AObj: TJSONObject; const APath: string;
   ADefault: Double): Double;
var
   LValue: string;
begin
   LValue := GetString(AObj, APath, '');
   if not TryStrToFloat(StringReplace(LValue, '.', FormatSettings.DecimalSeparator, []), Result) then
      Result := ADefault;
end;

class function TPECFebrafarJSONParser.GetBool(AObj: TJSONObject; const APath: string;
   ADefault: Boolean): Boolean;
var
   LValue: string;
begin
   LValue := LowerCase(GetString(AObj, APath, ''));
   if LValue = 'true' then Result := True
   else if LValue = 'false' then Result := False
   else Result := ADefault;
end;

class function TPECFebrafarJSONParser.GetDateTime(AObj: TJSONObject; const APath: string): TDateTime;
var
   LValue: string;
begin
   LValue := GetString(AObj, APath, '');
   if LValue <> '' then
      Result := ISO8601ToDate(LValue)
   else
      Result := 0;
end;

class function TPECFebrafarJSONParser.GetInt(AObj: TJSONObject; const APath: string;
   ADefault: Integer): Integer;
var
   LValue: string;
begin
   LValue := GetString(AObj, APath, '');
   if not TryStrToInt(LValue, Result) then
      Result := ADefault;
end;

class function TPECFebrafarJSONParser.ParseTipoDesconto(const AValue: string): TPECFebrafarTipoDesconto;
var
   LValue: string;
begin
   LValue := LowerCase(AValue);
   if (LValue = 'percentual') or (LValue = 'p') then Result := tfdPercentual
   else if (LValue = 'valorfixo') or (LValue = 'v') then Result := tfdValorFixo
   else if (LValue = 'precofixo') or (LValue = 'pf') then Result := tfdPrecoFixo
   else if (LValue = 'ofertaapp') or (LValue = 'app') then Result := tfdOfertaApp
   else Result := tfdPercentual;
end;

class function TPECFebrafarJSONParser.ParseTipoCliente(const AValue: string): TPECFebrafarTipoCliente;
var
   LValue: string;
begin
   LValue := LowerCase(AValue);
   if (LValue = 'preferencial') or (LValue = 'vip') then Result := tcPreferencial
   else if LValue = 'funcionario' then Result := tcFuncionario
   else if LValue = 'conveniado' then Result := tcConveniado
   else Result := tcNormal;
end;

class function TPECFebrafarJSONParser.ParseToken(const AJSON: string): TPECFebrafarToken;
var
   LObj: TJSONObject;
begin
   Result.Clear;
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if Assigned(LObj) then
      try
         Result.AccessToken := GetString(LObj, 'access_token', GetString(LObj, 'accessToken'));
         Result.TokenType := GetString(LObj, 'token_type', 'Bearer');
         Result.ExpiresIn := GetInt(LObj, 'expires_in', 3600);
         Result.DataExpiracao := IncSecond(Now, Result.ExpiresIn - 60);
      finally
         LObj.Free;
      end;
   except
      Result.Clear;
   end;
end;

class function TPECFebrafarJSONParser.ParseCliente(const AJSON: string): TPECFebrafarClienteResponse;
var
   LObj, LCli: TJSONObject;
begin
   Result.Clear;
   Result.RawJSON := AJSON;
   
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if not Assigned(LObj) then
      begin
         Result.MensagemRetorno := 'Resposta inválida';
         Exit;
      end;
      
      try
         Result.CodigoRetorno := GetString(LObj, 'codigoRetorno');
         Result.MensagemRetorno := GetString(LObj, 'mensagem');
         Result.Sucesso := Result.CodigoRetorno = TPECFebrafarCodigosRetorno.SUCESSO;
         
         if Result.Sucesso then
         begin
            Result.Status := pfsAutorizado;
            Result.Encontrado := GetBool(LObj, 'encontrado', True);
            
            if LObj.TryGetValue<TJSONObject>('cliente', LCli) then
            begin
               Result.Cliente.Codigo := GetString(LCli, 'codigo');
               Result.Cliente.CPF := GetString(LCli, 'cpf');
               Result.Cliente.Nome := GetString(LCli, 'nome');
               Result.Cliente.DataNascimento := GetDateTime(LCli, 'dataNascimento');
               Result.Cliente.Telefone := GetString(LCli, 'telefone');
               Result.Cliente.Celular := GetString(LCli, 'celular');
               Result.Cliente.Email := GetString(LCli, 'email');
               Result.Cliente.CEP := GetString(LCli, 'cep');
               Result.Cliente.Endereco := GetString(LCli, 'endereco');
               Result.Cliente.Numero := GetString(LCli, 'numero');
               Result.Cliente.Bairro := GetString(LCli, 'bairro');
               Result.Cliente.Cidade := GetString(LCli, 'cidade');
               Result.Cliente.UF := GetString(LCli, 'uf');
               Result.Cliente.TipoCliente := ParseTipoCliente(GetString(LCli, 'tipoCliente'));
               Result.Cliente.GrupoCliente := GetString(LCli, 'grupoCliente');
               Result.Cliente.Pontos := GetInt(LCli, 'pontos');
               Result.Cliente.DataCadastro := GetDateTime(LCli, 'dataCadastro');
               Result.Cliente.UltimaCompra := GetDateTime(LCli, 'ultimaCompra');
               Result.Cliente.Ativo := GetBool(LCli, 'ativo', True);
               Result.Cliente.AceitaWhatsApp := GetBool(LCli, 'aceitaWhatsApp');
               Result.Cliente.AceitaEmail := GetBool(LCli, 'aceitaEmail');
               Result.Cliente.AceitaSMS := GetBool(LCli, 'aceitaSMS');
            end;
         end
         else
            Result.Status := pfsNegado;
      finally
         LObj.Free;
      end;
   except
      on E: Exception do
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := 'Erro: ' + E.Message;
      end;
   end;
end;

class function TPECFebrafarJSONParser.ParsePreAutorizacao(const AJSON: string): TPECFebrafarPreAutorizacaoResponse;
var
   LObj, LProd: TJSONObject;
   LProdutos: TJSONArray;
   I: Integer;
begin
   Result.Clear;
   Result.RawJSON := AJSON;
   
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if not Assigned(LObj) then
      begin
         Result.MensagemRetorno := 'Resposta inválida';
         Exit;
      end;
      
      try
         Result.CodigoRetorno := GetString(LObj, 'codigoRetorno');
         Result.MensagemRetorno := GetString(LObj, 'mensagem');
         Result.Sucesso := (Result.CodigoRetorno = TPECFebrafarCodigosRetorno.SUCESSO) or
                          (Result.CodigoRetorno = TPECFebrafarCodigosRetorno.PRE_AUTORIZADO);
         
         if Result.Sucesso then
         begin
            Result.Status := pfsPreAutorizado;
            Result.NumeroPreAutorizacao := GetString(LObj, 'numeroPreAutorizacao');
            Result.NSU := GetString(LObj, 'nsu');
            Result.DataHoraPreAutorizacao := GetDateTime(LObj, 'dataHoraPreAutorizacao');
            Result.ValidadeMinutos := GetInt(LObj, 'validadeMinutos', 30);
            Result.ValorTotalDesconto := GetDouble(LObj, 'valorTotalDesconto');
            Result.ValorTotalFinal := GetDouble(LObj, 'valorTotalFinal');
            Result.PontosGerados := GetInt(LObj, 'pontosGerados');
            
            if LObj.TryGetValue<TJSONArray>('produtos', LProdutos) then
            begin
               SetLength(Result.Produtos, LProdutos.Count);
               for I := 0 to LProdutos.Count - 1 do
               begin
                  LProd := LProdutos.Items[I] as TJSONObject;
                  Result.Produtos[I].CodigoBarras := GetString(LProd, 'codigoBarras');
                  Result.Produtos[I].Descricao := GetString(LProd, 'descricao');
                  Result.Produtos[I].Quantidade := GetDouble(LProd, 'quantidade');
                  Result.Produtos[I].ValorUnitario := GetDouble(LProd, 'valorUnitario');
                  Result.Produtos[I].ValorTotal := GetDouble(LProd, 'valorTotal');
                  Result.Produtos[I].ValorDesconto := GetDouble(LProd, 'valorDesconto');
                  Result.Produtos[I].ValorFinal := GetDouble(LProd, 'valorFinal');
                  Result.Produtos[I].PercentualDesconto := GetDouble(LProd, 'percentualDesconto');
                  Result.Produtos[I].TipoDesconto := ParseTipoDesconto(GetString(LProd, 'tipoDesconto'));
                  Result.Produtos[I].Autorizado := GetBool(LProd, 'autorizado');
                  Result.Produtos[I].CodigoPrograma := GetString(LProd, 'codigoPrograma');
                  Result.Produtos[I].NomePrograma := GetString(LProd, 'nomePrograma');
                  Result.Produtos[I].CodigoOferta := GetString(LProd, 'codigoOferta');
                  Result.Produtos[I].CodigoRejeicao := GetString(LProd, 'codigoRejeicao');
                  Result.Produtos[I].MensagemRejeicao := GetString(LProd, 'mensagemRejeicao');
               end;
            end;
         end
         else
            Result.Status := pfsNegado;
      finally
         LObj.Free;
      end;
   except
      on E: Exception do
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := 'Erro: ' + E.Message;
      end;
   end;
end;

class function TPECFebrafarJSONParser.ParseAutorizacao(const AJSON: string): TPECFebrafarAutorizacaoResponse;
var
   LObj: TJSONObject;
begin
   Result.Clear;
   Result.RawJSON := AJSON;
   
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if not Assigned(LObj) then
      begin
         Result.MensagemRetorno := 'Resposta inválida';
         Exit;
      end;
      
      try
         Result.CodigoRetorno := GetString(LObj, 'codigoRetorno');
         Result.MensagemRetorno := GetString(LObj, 'mensagem');
         Result.Sucesso := Result.CodigoRetorno = TPECFebrafarCodigosRetorno.SUCESSO;
         
         if Result.Sucesso then
         begin
            Result.Status := pfsAutorizado;
            Result.NSU := GetString(LObj, 'nsu');
            Result.NumeroAutorizacao := GetString(LObj, 'numeroAutorizacao');
            Result.DataHoraAutorizacao := GetDateTime(LObj, 'dataHoraAutorizacao');
            Result.ValorTotalDesconto := GetDouble(LObj, 'valorTotalDesconto');
            Result.ValorTotalFinal := GetDouble(LObj, 'valorTotalFinal');
            Result.PontosCreditados := GetInt(LObj, 'pontosCreditados');
            Result.SaldoPontos := GetInt(LObj, 'saldoPontos');
         end
         else
            Result.Status := pfsNegado;
      finally
         LObj.Free;
      end;
   except
      on E: Exception do
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := 'Erro: ' + E.Message;
      end;
   end;
end;

class function TPECFebrafarJSONParser.ParseCancelamento(const AJSON: string): TPECFebrafarCancelamentoResponse;
var
   LObj: TJSONObject;
begin
   Result.Clear;
   Result.RawJSON := AJSON;
   
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if not Assigned(LObj) then Exit;
      
      try
         Result.CodigoRetorno := GetString(LObj, 'codigoRetorno');
         Result.MensagemRetorno := GetString(LObj, 'mensagem');
         Result.Sucesso := Result.CodigoRetorno = TPECFebrafarCodigosRetorno.SUCESSO;
         
         if Result.Sucesso then
         begin
            Result.Status := pfsCancelado;
            Result.NSUCancelamento := GetString(LObj, 'nsuCancelamento');
            Result.DataHoraCancelamento := GetDateTime(LObj, 'dataHoraCancelamento');
            Result.PontosEstornados := GetInt(LObj, 'pontosEstornados');
         end
         else
            Result.Status := pfsNegado;
      finally
         LObj.Free;
      end;
   except
   end;
end;

class function TPECFebrafarJSONParser.ParseProgramas(const AJSON: string): TPECFebrafarProgramas;
var
   LObj, LProg: TJSONObject;
   LArray: TJSONArray;
   I: Integer;
begin
   SetLength(Result, 0);
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if not Assigned(LObj) then Exit;
      
      try
         if LObj.TryGetValue<TJSONArray>('programas', LArray) then
         begin
            SetLength(Result, LArray.Count);
            for I := 0 to LArray.Count - 1 do
            begin
               LProg := LArray.Items[I] as TJSONObject;
               Result[I].Codigo := GetString(LProg, 'codigo');
               Result[I].Nome := GetString(LProg, 'nome');
               Result[I].Descricao := GetString(LProg, 'descricao');
               Result[I].Laboratorio := GetString(LProg, 'laboratorio');
               Result[I].TipoDesconto := ParseTipoDesconto(GetString(LProg, 'tipoDesconto'));
               Result[I].PercentualDesconto := GetDouble(LProg, 'percentualDesconto');
               Result[I].Ativo := GetBool(LProg, 'ativo', True);
               Result[I].DataInicio := GetDateTime(LProg, 'dataInicio');
               Result[I].DataFim := GetDateTime(LProg, 'dataFim');
            end;
         end;
      finally
         LObj.Free;
      end;
   except
   end;
end;

class function TPECFebrafarJSONParser.ParseOfertas(const AJSON: string): TPECFebrafarOfertas;
var
   LObj, LOfer: TJSONObject;
   LArray: TJSONArray;
   I: Integer;
begin
   SetLength(Result, 0);
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if not Assigned(LObj) then Exit;
      
      try
         if LObj.TryGetValue<TJSONArray>('ofertas', LArray) then
         begin
            SetLength(Result, LArray.Count);
            for I := 0 to LArray.Count - 1 do
            begin
               LOfer := LArray.Items[I] as TJSONObject;
               Result[I].Codigo := GetString(LOfer, 'codigo');
               Result[I].Descricao := GetString(LOfer, 'descricao');
               Result[I].TipoDesconto := ParseTipoDesconto(GetString(LOfer, 'tipoDesconto'));
               Result[I].ValorDesconto := GetDouble(LOfer, 'valorDesconto');
               Result[I].PercentualDesconto := GetDouble(LOfer, 'percentualDesconto');
               Result[I].CodigoBarras := GetString(LOfer, 'codigoBarras');
               Result[I].QuantidadeMinima := GetInt(LOfer, 'quantidadeMinima', 1);
               Result[I].DataInicio := GetDateTime(LOfer, 'dataInicio');
               Result[I].DataFim := GetDateTime(LOfer, 'dataFim');
               Result[I].Ativada := GetBool(LOfer, 'ativada');
            end;
         end;
      finally
         LObj.Free;
      end;
   except
   end;
end;

class function TPECFebrafarJSONParser.ParseErro(const AJSON: string): string;
var
   LObj: TJSONObject;
begin
   Result := AJSON;
   try
      LObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
      if Assigned(LObj) then
      try
         Result := GetString(LObj, 'mensagem', GetString(LObj, 'error', AJSON));
      finally
         LObj.Free;
      end;
   except
   end;
end;

{ TPECFebrafarClient }

constructor TPECFebrafarClient.Create;
begin
   inherited;
   FLock := TCriticalSection.Create;
   FHTTPClient := THTTPClient.Create;
   FProgramas := TPECFebrafarProgramaCache.Create;
   FClientes := TPECFebrafarClienteCache.Create;
   FHomologacao := True;
   FTimeout := 30000;
   FMaxRetries := 3;
   FEstabelecimento.Clear;
   FToken.Clear;
end;

destructor TPECFebrafarClient.Destroy;
begin
   FClientes.Free;
   FProgramas.Free;
   FHTTPClient.Free;
   FLock.Free;
   inherited;
end;

procedure TPECFebrafarClient.Log(const AMsg: string; const ATipo: string);
begin
   if Assigned(FOnLog) then
      FOnLog('[PEC] ' + AMsg, ATipo);
end;

function TPECFebrafarClient.GetBaseURL: string;
begin
   if FEstabelecimento.EnderecoServidor <> '' then
      Result := FEstabelecimento.EnderecoServidor
   else if FHomologacao then
      Result := TPECFebrafarEndpoints.HOMOLOGACAO_URL
   else
      Result := TPECFebrafarEndpoints.PRODUCAO_URL;
end;

function TPECFebrafarClient.GetHeaders(AComAuth: Boolean): TArray<TPair<string, string>>;
begin
   if AComAuth and FToken.Valido then
      Result := [
         TPair<string, string>.Create('Content-Type', 'application/json'),
         TPair<string, string>.Create('Accept', 'application/json'),
         TPair<string, string>.Create('Authorization', FToken.TokenType + ' ' + FToken.AccessToken)
      ]
   else
      Result := [
         TPair<string, string>.Create('Content-Type', 'application/json'),
         TPair<string, string>.Create('Accept', 'application/json')
      ];
end;

procedure TPECFebrafarClient.ConfigurarEstabelecimento(const ACNPJ, ACodigoAcesso,
   ASenha, ACodigoEmpresa, AEnderecoServidor, ARazaoSocial, ACodigoRede, AUF: string);
begin
   FLock.Enter;
   try
      FEstabelecimento.CNPJ := ACNPJ;
      FEstabelecimento.CodigoAcesso := ACodigoAcesso;
      FEstabelecimento.Senha := ASenha;
      FEstabelecimento.CodigoEmpresa := ACodigoEmpresa;
      FEstabelecimento.EnderecoServidor := AEnderecoServidor;
      FEstabelecimento.RazaoSocial := ARazaoSocial;
      FEstabelecimento.CodigoRede := ACodigoRede;
      FEstabelecimento.UF := AUF;
      FToken.Clear;
      Log('Estabelecimento configurado: ' + ACNPJ + ' Rede: ' + ACodigoRede, 'INFO');
   finally
      FLock.Leave;
   end;
end;

procedure TPECFebrafarClient.SetAmbiente(AHomologacao: Boolean);
begin
   FHomologacao := AHomologacao;
   FToken.Clear;
   FProgramas.Clear;
   FClientes.Clear;
   Log('Ambiente: ' + IfThen(AHomologacao, 'HOMOLOGAÇÃO', 'PRODUÇÃO'), 'INFO');
end;

function TPECFebrafarClient.ValidarEstabelecimento: Boolean;
begin
   Result := (FEstabelecimento.CNPJ <> '') and
             (FEstabelecimento.CodigoAcesso <> '') and
             (FEstabelecimento.Senha <> '');
   if not Result then
      FUltimoErro := 'Estabelecimento não configurado';
end;

function TPECFebrafarClient.Autenticar: Boolean;
var
   LBody, LResponse: string;
   LStatusCode: Integer;
begin
   Result := False;
   
   if FToken.Valido then
   begin
      Result := True;
      Exit;
   end;
   
   Log('Autenticando no PEC Febrafar...', 'DEBUG');
   
   LBody := TPECFebrafarJSONBuilder.BuildAuth(FEstabelecimento.CodigoAcesso,
      FEstabelecimento.Senha, FEstabelecimento.CodigoEmpresa);
   
   if ExecutarRequest(TPECFebrafarEndpoints.AUTH, 'POST', LBody, LResponse, LStatusCode, False) then
   begin
      FToken := TPECFebrafarJSONParser.ParseToken(LResponse);
      Result := FToken.Valido;
      
      if Result then
         Log('Autenticação OK', 'DEBUG')
      else
      begin
         FUltimoErro := 'Token inválido';
         Log(FUltimoErro, 'ERROR');
      end;
   end;
end;

function TPECFebrafarClient.ExecutarRequest(const AEndpoint, AMetodo, ABody: string;
   out AResponse: string; out AStatusCode: Integer; AComAuth: Boolean): Boolean;
var
   LContent: TStringStream;
   LHTTPResponse: IHTTPResponse;
   LRetry, LDelay: Integer;
   LHeaders: TArray<TPair<string, string>>;
   LHeader: TPair<string, string>;
   LURL: string;
begin
   Result := False;
   AResponse := '';
   AStatusCode := 0;
   LDelay := 500;
   LURL := GetBaseURL + AEndpoint;
   
   if AComAuth and not FToken.Valido then
      if not Autenticar then Exit;
   
   LHeaders := GetHeaders(AComAuth);
   
   for LRetry := 0 to FMaxRetries - 1 do
   begin
      try
         FHTTPClient.ConnectionTimeout := FTimeout;
         FHTTPClient.ResponseTimeout := FTimeout;
         
         for LHeader in LHeaders do
            FHTTPClient.CustomHeaders[LHeader.Key] := LHeader.Value;
         
         Log('Request: ' + AMetodo + ' ' + AEndpoint, 'DEBUG');
         
         if AMetodo = 'GET' then
            LHTTPResponse := FHTTPClient.Get(LURL)
         else
         begin
            LContent := TStringStream.Create(ABody, TEncoding.UTF8);
            try
               LHTTPResponse := FHTTPClient.Post(LURL, LContent);
            finally
               LContent.Free;
            end;
         end;
         
         AStatusCode := LHTTPResponse.StatusCode;
         AResponse := LHTTPResponse.ContentAsString;
         
         if AStatusCode in [200..299] then
         begin
            Result := True;
            Exit;
         end
         else if AStatusCode = 401 then
         begin
            FToken.Clear;
            if AComAuth and (LRetry = 0) and Autenticar then Continue;
            FUltimoErro := 'Erro de autenticação';
            Exit;
         end
         else if AStatusCode >= 500 then
         begin
            Log(Format('HTTP %d - Retry %d', [AStatusCode, LRetry + 1]), 'WARN');
            Sleep(LDelay);
            LDelay := LDelay * 2;
         end
         else
         begin
            FUltimoErro := Format('HTTP %d: %s', [AStatusCode, TPECFebrafarJSONParser.ParseErro(AResponse)]);
            Exit;
         end;
      except
         on E: Exception do
         begin
            FUltimoErro := E.Message;
            if LRetry = FMaxRetries - 1 then Exit;
            Sleep(LDelay);
            LDelay := LDelay * 2;
         end;
      end;
   end;
end;

function TPECFebrafarClient.TestarConexao: Boolean;
begin
   FLock.Enter;
   try
      if not ValidarEstabelecimento then
      begin
         Result := False;
         Exit;
      end;
      Result := Autenticar;
      if Result then
         Log('Conexão OK com PEC Febrafar', 'INFO')
      else
         Log('Falha: ' + FUltimoErro, 'ERROR');
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.CarregarProgramas: Boolean;
var
   LResponse: string;
   LStatusCode: Integer;
   LProgramas: TPECFebrafarProgramas;
   I: Integer;
begin
   Result := False;
   FLock.Enter;
   try
      if not ValidarEstabelecimento then Exit;
      
      if ExecutarRequest(TPECFebrafarEndpoints.PROGRAMA_LISTAR, 'GET', '', LResponse, LStatusCode) then
      begin
         LProgramas := TPECFebrafarJSONParser.ParseProgramas(LResponse);
         FProgramas.Clear;
         for I := Low(LProgramas) to High(LProgramas) do
            FProgramas.Add(LProgramas[I]);
         FProgramas.SetUpdated;
         Result := True;
         Log('Programas carregados: ' + IntToStr(FProgramas.Count), 'INFO');
      end;
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.ConsultarCliente(const ACPF: string;
   const ATelefone: string; const ACodigo: string): TPECFebrafarClienteResponse;
var
   LRequest: TPECFebrafarClienteRequest;
   LBody, LResponse: string;
   LStatusCode: Integer;
begin
   Result.Clear;
   FLock.Enter;
   try
      if not ValidarEstabelecimento then
      begin
         Result.Status := pfsErroValidacao;
         Result.MensagemRetorno := FUltimoErro;
         Exit;
      end;
      
      LRequest.Clear;
      LRequest.CPF := ACPF;
      LRequest.Telefone := ATelefone;
      LRequest.Codigo := ACodigo;
      
      Log('Consultando cliente: ' + ACPF, 'INFO');
      LBody := TPECFebrafarJSONBuilder.BuildConsultaCliente(FEstabelecimento, LRequest);
      
      if ExecutarRequest(TPECFebrafarEndpoints.CLIENTE_CONSULTA, 'POST', LBody, LResponse, LStatusCode) then
      begin
         Result := TPECFebrafarJSONParser.ParseCliente(LResponse);
         if Result.Sucesso and Result.Encontrado then
         begin
            FClientes.Add(Result.Cliente);
            Log('Cliente: ' + Result.Cliente.Nome + ' | Pontos: ' + IntToStr(Result.Cliente.Pontos), 'INFO');
         end
         else
            Log('Cliente não encontrado: ' + Result.MensagemRetorno, 'WARN');
      end
      else
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := FUltimoErro;
      end;
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.CadastrarCliente(
   const ARequest: TPECFebrafarCadastroClienteRequest): TPECFebrafarClienteResponse;
var
   LBody, LResponse: string;
   LStatusCode: Integer;
begin
   Result.Clear;
   FLock.Enter;
   try
      if not ValidarEstabelecimento then
      begin
         Result.Status := pfsErroValidacao;
         Result.MensagemRetorno := FUltimoErro;
         Exit;
      end;
      
      Log('Cadastrando cliente: ' + ARequest.Cliente.CPF, 'INFO');
      LBody := TPECFebrafarJSONBuilder.BuildCadastroCliente(FEstabelecimento, ARequest);
      
      if ExecutarRequest(TPECFebrafarEndpoints.CLIENTE_CADASTRO, 'POST', LBody, LResponse, LStatusCode) then
      begin
         Result := TPECFebrafarJSONParser.ParseCliente(LResponse);
         if Result.Sucesso then
         begin
            FClientes.Add(Result.Cliente);
            Log('Cliente cadastrado: ' + Result.Cliente.Codigo, 'INFO');
         end;
      end
      else
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := FUltimoErro;
      end;
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.ListarOfertas(const ACPF: string): TPECFebrafarOfertas;
var
   LResponse: string;
   LStatusCode: Integer;
begin
   SetLength(Result, 0);
   FLock.Enter;
   try
      if not ValidarEstabelecimento then Exit;
      
      if ExecutarRequest(TPECFebrafarEndpoints.OFERTA_LISTAR + '?cpf=' + ACPF, 'GET', '', LResponse, LStatusCode) then
         Result := TPECFebrafarJSONParser.ParseOfertas(LResponse);
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.AtivarOferta(const ACPF, ACodigoOferta: string): Boolean;
var
   LBody, LResponse: string;
   LStatusCode: Integer;
   LObj: TJSONObject;
begin
   Result := False;
   FLock.Enter;
   try
      if not ValidarEstabelecimento then Exit;
      
      LObj := TJSONObject.Create;
      try
         LObj.AddPair('cpf', ACPF);
         LObj.AddPair('codigoOferta', ACodigoOferta);
         LBody := LObj.ToString;
      finally
         LObj.Free;
      end;
      
      Result := ExecutarRequest(TPECFebrafarEndpoints.OFERTA_ATIVAR, 'POST', LBody, LResponse, LStatusCode);
      if Result then
         Log('Oferta ' + ACodigoOferta + ' ativada para ' + ACPF, 'INFO');
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.PreAutorizarVenda(
   const ARequest: TPECFebrafarPreAutorizacaoRequest): TPECFebrafarPreAutorizacaoResponse;
var
   LBody, LResponse: string;
   LStatusCode: Integer;
begin
   Result.Clear;
   FLock.Enter;
   try
      if not ValidarEstabelecimento then
      begin
         Result.Status := pfsErroValidacao;
         Result.MensagemRetorno := FUltimoErro;
         Exit;
      end;
      
      if ARequest.Cliente.CPF = '' then
      begin
         Result.Status := pfsErroValidacao;
         Result.MensagemRetorno := 'CPF do cliente não informado';
         Exit;
      end;
      
      Log('Pré-autorizando venda: ' + ARequest.NumeroVenda, 'INFO');
      LBody := TPECFebrafarJSONBuilder.BuildPreAutorizacao(FEstabelecimento, ARequest);
      
      if ExecutarRequest(TPECFebrafarEndpoints.VENDA_PRE_AUTORIZAR, 'POST', LBody, LResponse, LStatusCode) then
      begin
         Result := TPECFebrafarJSONParser.ParsePreAutorizacao(LResponse);
         if Result.Sucesso then
            Log('Pré-autorização: ' + Result.NumeroPreAutorizacao + ' | Pontos: ' + IntToStr(Result.PontosGerados), 'INFO')
         else
            Log('Negada: ' + Result.MensagemRetorno, 'WARN');
      end
      else
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := FUltimoErro;
      end;
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.AutorizarVenda(
   const ARequest: TPECFebrafarAutorizacaoRequest): TPECFebrafarAutorizacaoResponse;
var
   LBody, LResponse: string;
   LStatusCode: Integer;
begin
   Result.Clear;
   FLock.Enter;
   try
      if not ValidarEstabelecimento then
      begin
         Result.Status := pfsErroValidacao;
         Result.MensagemRetorno := FUltimoErro;
         Exit;
      end;
      
      Log('Autorizando venda: ' + ARequest.NumeroPreAutorizacao, 'INFO');
      LBody := TPECFebrafarJSONBuilder.BuildAutorizacao(FEstabelecimento, ARequest);
      
      if ExecutarRequest(TPECFebrafarEndpoints.VENDA_AUTORIZAR, 'POST', LBody, LResponse, LStatusCode) then
      begin
         Result := TPECFebrafarJSONParser.ParseAutorizacao(LResponse);
         if Result.Sucesso then
            Log('Autorizada NSU: ' + Result.NSU + ' | Pontos: ' + IntToStr(Result.PontosCreditados), 'INFO')
         else
            Log('Negada: ' + Result.MensagemRetorno, 'WARN');
      end
      else
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := FUltimoErro;
      end;
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.VendaCompleta(
   const ARequest: TPECFebrafarPreAutorizacaoRequest): TPECFebrafarAutorizacaoResponse;
var
   LPreAuth: TPECFebrafarPreAutorizacaoResponse;
   LAuthRequest: TPECFebrafarAutorizacaoRequest;
begin
   Result.Clear;
   
   LPreAuth := PreAutorizarVenda(ARequest);
   if not LPreAuth.Sucesso then
   begin
      Result.Status := LPreAuth.Status;
      Result.CodigoRetorno := LPreAuth.CodigoRetorno;
      Result.MensagemRetorno := LPreAuth.MensagemRetorno;
      Exit;
   end;
   
   LAuthRequest.Clear;
   LAuthRequest.NumeroPreAutorizacao := LPreAuth.NumeroPreAutorizacao;
   LAuthRequest.NSU := LPreAuth.NSU;
   LAuthRequest.NumeroVenda := ARequest.NumeroVenda;
   LAuthRequest.Operador := ARequest.Operador;
   
   Result := AutorizarVenda(LAuthRequest);
end;

function TPECFebrafarClient.CancelarVenda(
   const ARequest: TPECFebrafarCancelamentoRequest): TPECFebrafarCancelamentoResponse;
var
   LBody, LResponse: string;
   LStatusCode: Integer;
begin
   Result.Clear;
   FLock.Enter;
   try
      if not ValidarEstabelecimento then
      begin
         Result.Status := pfsErroValidacao;
         Result.MensagemRetorno := FUltimoErro;
         Exit;
      end;
      
      Log('Cancelando NSU: ' + ARequest.NSU, 'INFO');
      LBody := TPECFebrafarJSONBuilder.BuildCancelamento(FEstabelecimento, ARequest);
      
      if ExecutarRequest(TPECFebrafarEndpoints.VENDA_CANCELAR, 'POST', LBody, LResponse, LStatusCode) then
      begin
         Result := TPECFebrafarJSONParser.ParseCancelamento(LResponse);
         if Result.Sucesso then
            Log('Cancelada | Pontos estornados: ' + IntToStr(Result.PontosEstornados), 'INFO');
      end
      else
      begin
         Result.Status := pfsErroConexao;
         Result.MensagemRetorno := FUltimoErro;
      end;
   finally
      FLock.Leave;
   end;
end;

function TPECFebrafarClient.ConsultarPontos(const ACPF: string): Integer;
var
   LResponse: TPECFebrafarClienteResponse;
begin
   LResponse := ConsultarCliente(ACPF);
   if LResponse.Sucesso and LResponse.Encontrado then
      Result := LResponse.Cliente.Pontos
   else
      Result := 0;
end;

end.
