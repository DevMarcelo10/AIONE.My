unit uPBM.Factory;

{******************************************************************************
  PBM Factory - Criação Unificada de Clients
  
  Fábrica para instanciar qualquer um dos 12 PBMs suportados:
  
  CORPORATIVOS:
    - Epharma
    - Funcional Card
    - Orizon
    - Vidalink
    
  GOVERNO:
    - Farmácia Popular (DATASUS)
    
  INDÚSTRIA:
    - Pharmalink
    
  COMERCIAIS/AGREGADORES:
    - TRN Centre
    
  ASSOCIATIVOS:
    - PEC Febrafar
    
  FIDELIZAÇÃO:
    - LinkedFarma
    - Ellomais / Facillite
    - Nosso Clube / Cosmos
    - Object Pro
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

interface

uses
  System.SysUtils, System.Classes,
  uPBM.Interfaces, uPBM.Persistence;

type
  /// <summary>Tipos de PBM suportados</summary>
  TPBMType = (
    // Corporativos
    ptEpharma,
    ptFuncionalCard,
    ptOrizon,
    ptVidalink,
    // Governo
    ptFarmaciaPopular,
    // Indústria
    ptPharmalink,
    // Comerciais
    ptTRNCentre,
    // Associativos
    ptPECFebrafar,
    // Fidelização
    ptLinkedfarma,
    ptEllomais,
    ptNossoClube,
    ptObjectPro
  );

  /// <summary>Factory para criação de clients PBM</summary>
  TPBMFactory = class
  public
    /// <summary>Cria um client PBM pelo tipo</summary>
    /// <param name="ATipo">Tipo do PBM</param>
    /// <param name="AClientID">Client ID / Usuário</param>
    /// <param name="AClientSecret">Client Secret / Senha</param>
    /// <param name="ACodEstabelecimento">Código do estabelecimento</param>
    /// <param name="AHomologacao">True para ambiente de homologação</param>
    class function CreateClient(
      ATipo: TPBMType;
      const AClientID, AClientSecret, ACodEstabelecimento: string;
      AHomologacao: Boolean = True
    ): IPBMClient;
    
    /// <summary>Cria client a partir de registro de operadora do banco</summary>
    class function CreateClientFromOperadora(
      const AOperadora: RPBMOperadora;
      AHomologacao: Boolean = True
    ): IPBMClient;
    
    /// <summary>Retorna o código da operadora pelo tipo</summary>
    class function TipoToCodigo(ATipo: TPBMType): string;
    
    /// <summary>Retorna o tipo pelo código da operadora</summary>
    class function CodigoToTipo(const ACodigo: string): TPBMType;
    
    /// <summary>Retorna nome amigável do tipo</summary>
    class function TipoToNome(ATipo: TPBMType): string;
    
    /// <summary>Verifica se o tipo é de programa de fidelidade</summary>
    class function IsFidelidade(ATipo: TPBMType): Boolean;
    
    /// <summary>Verifica se o tipo usa autenticação OAuth/JWT</summary>
    class function UsaToken(ATipo: TPBMType): Boolean;
  end;

  /// <summary>Interface estendida para configuração adicional</summary>
  IPBMClientEx = interface(IPBMClient)
    ['{B2C3D4E5-F6A7-8901-BCDE-F23456789012}']
    procedure SetCredenciais(const AUsuario, ASenha, AAPIKey: string);
    procedure SetCNPJ(const ACNPJ: string);
    procedure SetCodigoTerminal(const ACodigo: string);
  end;

implementation

uses
  // Units dos PBMs - descomente conforme implementar
  uPBM.Epharma,
  uPBM.FuncionalCard,
  uPBM.Orizon,
  uPBM.Vidalink,
  uPBM.FarmaciaPopular,
  uPBM.Pharmalink,
  uPBM.TRNCentre,
  uPBM.PECFebrafar,
  uPBM.Linkedfarma,
  uPBM.Ellomais,
  uPBM.NossoClube,
  uPBM.ObjectPro;

{ TPBMFactory }

class function TPBMFactory.CreateClient(ATipo: TPBMType;
  const AClientID, AClientSecret, ACodEstabelecimento: string;
  AHomologacao: Boolean): IPBMClient;
begin
  case ATipo of
    // === CORPORATIVOS ===
    ptEpharma:
      Result := TEpharmaClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    ptFuncionalCard:
      Result := TFuncionalCardClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    ptOrizon:
      Result := TOrizonClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    ptVidalink:
      Result := TVidalinkClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    // === GOVERNO ===
    ptFarmaciaPopular:
      Result := TFarmaciaPopularClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    // === INDÚSTRIA ===
    ptPharmalink:
      Result := TPharmalinkClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    // === COMERCIAIS ===
    ptTRNCentre:
      Result := TTRNCentreClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    // === ASSOCIATIVOS ===
    ptPECFebrafar:
      Result := TPECFebrafar.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    // === FIDELIZAÇÃO ===
    ptLinkedfarma:
      Result := TLinkedfarmaClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    ptEllomais:
      Result := TEllomaisClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    ptNossoClube:
      Result := TNossoClubeClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
      
    ptObjectPro:
      Result := TObjectProClient.Create(AClientID, AClientSecret, ACodEstabelecimento, AHomologacao);
  else
    raise Exception.CreateFmt('Tipo de PBM não suportado: %d', [Ord(ATipo)]);
  end;
end;

class function TPBMFactory.CreateClientFromOperadora(const AOperadora: RPBMOperadora;
  AHomologacao: Boolean): IPBMClient;
var
  LTipo: TPBMType;
begin
  LTipo := CodigoToTipo(AOperadora.Codigo);
  
  Result := CreateClient(
    LTipo,
    AOperadora.ClientID,
    AOperadora.ClientSecret,
    AOperadora.CodEstabelecimento,
    AHomologacao
  );
  
  // Configura credenciais extras se suportado
  if Supports(Result, IPBMClientEx) then
  begin
    (Result as IPBMClientEx).SetCredenciais(
      AOperadora.Usuario,
      AOperadora.Senha,
      AOperadora.APIKey
    );
  end;
end;

class function TPBMFactory.TipoToCodigo(ATipo: TPBMType): string;
begin
  case ATipo of
    ptEpharma:        Result := 'EPHARMA';
    ptFuncionalCard:  Result := 'FUNCIONALCARD';
    ptOrizon:         Result := 'ORIZON';
    ptVidalink:       Result := 'VIDALINK';
    ptFarmaciaPopular: Result := 'FARMACIAPOPULAR';
    ptPharmalink:     Result := 'PHARMALINK';
    ptTRNCentre:      Result := 'TRNCENTRE';
    ptPECFebrafar:    Result := 'PECFEBRAFAR';
    ptLinkedfarma:    Result := 'LINKEDFARMA';
    ptEllomais:       Result := 'ELLOMAIS';
    ptNossoClube:     Result := 'NOSSOCLUBE';
    ptObjectPro:      Result := 'OBJECTPRO';
  else
    Result := '';
  end;
end;

class function TPBMFactory.CodigoToTipo(const ACodigo: string): TPBMType;
begin
  if SameText(ACodigo, 'EPHARMA') then
    Result := ptEpharma
  else if SameText(ACodigo, 'FUNCIONALCARD') then
    Result := ptFuncionalCard
  else if SameText(ACodigo, 'ORIZON') then
    Result := ptOrizon
  else if SameText(ACodigo, 'VIDALINK') then
    Result := ptVidalink
  else if SameText(ACodigo, 'FARMACIAPOPULAR') then
    Result := ptFarmaciaPopular
  else if SameText(ACodigo, 'PHARMALINK') then
    Result := ptPharmalink
  else if SameText(ACodigo, 'TRNCENTRE') then
    Result := ptTRNCentre
  else if SameText(ACodigo, 'PECFEBRAFAR') then
    Result := ptPECFebrafar
  else if SameText(ACodigo, 'LINKEDFARMA') then
    Result := ptLinkedfarma
  else if SameText(ACodigo, 'ELLOMAIS') or SameText(ACodigo, 'FACILLITE') then
    Result := ptEllomais
  else if SameText(ACodigo, 'NOSSOCLUBE') or SameText(ACodigo, 'COSMOS') then
    Result := ptNossoClube
  else if SameText(ACodigo, 'OBJECTPRO') then
    Result := ptObjectPro
  else
    raise Exception.CreateFmt('Código de PBM desconhecido: %s', [ACodigo]);
end;

class function TPBMFactory.TipoToNome(ATipo: TPBMType): string;
begin
  case ATipo of
    ptEpharma:        Result := 'Epharma';
    ptFuncionalCard:  Result := 'Funcional Card';
    ptOrizon:         Result := 'Orizon';
    ptVidalink:       Result := 'Vidalink';
    ptFarmaciaPopular: Result := 'Farmácia Popular';
    ptPharmalink:     Result := 'Pharmalink';
    ptTRNCentre:      Result := 'TRN Centre';
    ptPECFebrafar:    Result := 'PEC Febrafar';
    ptLinkedfarma:    Result := 'LinkedFarma';
    ptEllomais:       Result := 'Ello+ / Facillite';
    ptNossoClube:     Result := 'Nosso Clube / Cosmos';
    ptObjectPro:      Result := 'Object Pro';
  else
    Result := 'Desconhecido';
  end;
end;

class function TPBMFactory.IsFidelidade(ATipo: TPBMType): Boolean;
begin
  Result := ATipo in [ptLinkedfarma, ptEllomais, ptNossoClube, ptObjectPro];
end;

class function TPBMFactory.UsaToken(ATipo: TPBMType): Boolean;
begin
  // Pharmalink e Farmácia Popular não usam OAuth/JWT
  Result := not (ATipo in [ptPharmalink, ptFarmaciaPopular]);
end;

end.
