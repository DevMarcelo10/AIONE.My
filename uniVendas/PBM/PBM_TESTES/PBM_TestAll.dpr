program PBM_TestAll;

{$APPTYPE CONSOLE}

{******************************************************************************
  PBM Test Suite - Teste de Todas as 12 Operadoras
  
  Projeto para testar integração com todos os PBMs em ambiente de homologação.
  
  Operadoras testadas:
  ✓ 1. Epharma
  ✓ 2. Funcional Card
  ✓ 3. Orizon
  ✓ 4. Vidalink
  ✓ 5. Farmácia Popular
  ✓ 6. Pharmalink
  ✓ 7. TRN Centre
  ✓ 8. PEC Febrafar
  ✓ 9. LinkedFarma
  ✓ 10. Ellomais / Facillite
  ✓ 11. Nosso Clube / Cosmos
  ✓ 12. Object Pro
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

uses
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Phys.MySQL,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  MarcLib,  // iif() function
  uPBM.Interfaces,
  uPBM.Factory,
  uPBM.Persistence;

type
  /// <summary>Resultado de um teste</summary>
  TTestResult = record
    Operadora: string;
    Teste: string;
    Sucesso: Boolean;
    Mensagem: string;
    TempoMS: Integer;
  end;

  /// <summary>Classe de testes PBM</summary>
  TPBMTestSuite = class
  private
    FConnection: TFDConnection;
    FPersistence: IPBMPersistence;
    FResults: TList<TTestResult>;
    FHomologacao: Boolean;
    
    procedure Log(const AMsg: string);
    procedure LogResult(const AOperadora, ATeste: string; ASucesso: Boolean; 
      const AMensagem: string; ATempoMS: Integer);
    
    // Helpers
    function CreateTestProdutos: TArray<TPBMProduto>;
    function GetTestCPF: string;
    function GetTestCarteirinha(ATipo: TPBMType): string;
    function GetTestDataNasc: TDate;
    
    // Testes por operadora
    procedure TestEpharma;
    procedure TestFuncionalCard;
    procedure TestOrizon;
    procedure TestVidalink;
    procedure TestFarmaciaPopular;
    procedure TestPharmalink;
    procedure TestTRNCentre;
    procedure TestPECFebrafar;
    procedure TestLinkedfarma;
    procedure TestEllomais;
    procedure TestNossoClube;
    procedure TestObjectPro;
    
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    
    procedure RunAllTests;
    procedure PrintSummary;
    
    property Homologacao: Boolean read FHomologacao write FHomologacao;
  end;

{ TPBMTestSuite }

constructor TPBMTestSuite.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
  FPersistence := TPBMPersistence.Create(AConnection);
  FResults := TList<TTestResult>.Create;
  FHomologacao := True; // Default: homologação
end;

destructor TPBMTestSuite.Destroy;
begin
  FResults.Free;
  inherited;
end;

procedure TPBMTestSuite.Log(const AMsg: string);
begin
  Writeln(FormatDateTime('hh:nn:ss.zzz', Now), ' | ', AMsg);
end;

procedure TPBMTestSuite.LogResult(const AOperadora, ATeste: string; ASucesso: Boolean;
  const AMensagem: string; ATempoMS: Integer);
var
  LResult: TTestResult;
begin
  LResult.Operadora := AOperadora;
  LResult.Teste := ATeste;
  LResult.Sucesso := ASucesso;
  LResult.Mensagem := AMensagem;
  LResult.TempoMS := ATempoMS;
  FResults.Add(LResult);
  
  if ASucesso then
    Log(Format('✓ [%s] %s - OK (%dms)', [AOperadora, ATeste, ATempoMS]))
  else
    Log(Format('✗ [%s] %s - FALHA: %s (%dms)', [AOperadora, ATeste, AMensagem, ATempoMS]));
end;

function TPBMTestSuite.CreateTestProdutos: TArray<TPBMProduto>;
begin
  SetLength(Result, 2);
  
  // Produto 1 - Medicamento genérico comum
  Result[0].EAN := '7891234567890';
  Result[0].Descricao := 'LOSARTANA 50MG C/30 COMP';
  Result[0].Quantidade := 1;
  Result[0].PrecoUnitario := 35.90;
  Result[0].PrecoTotal := 35.90;
  
  // Produto 2 - Medicamento de referência
  Result[1].EAN := '7890123456789';
  Result[1].Descricao := 'GLIFAGE XR 500MG C/30 COMP';
  Result[1].Quantidade := 2;
  Result[1].PrecoUnitario := 45.50;
  Result[1].PrecoTotal := 91.00;
end;

function TPBMTestSuite.GetTestCPF: string;
begin
  // CPF de teste (homologação)
  Result := '12345678909';
end;

function TPBMTestSuite.GetTestCarteirinha(ATipo: TPBMType): string;
begin
  // Carteirinhas de teste por operadora
  case ATipo of
    ptEpharma:        Result := '0000000000001';
    ptFuncionalCard:  Result := 'FC00000000001';
    ptOrizon:         Result := 'OR00000000001';
    ptVidalink:       Result := 'VL00000000001';
    ptFarmaciaPopular: Result := '12345678901234567'; // NIS
    ptPharmalink:     Result := 'PL00000000001';
    ptTRNCentre:      Result := 'TR00000000001';
    ptPECFebrafar:    Result := 'PEC0000000001';
    ptLinkedfarma:    Result := GetTestCPF; // Usa CPF
    ptEllomais:       Result := GetTestCPF;
    ptNossoClube:     Result := GetTestCPF;
    ptObjectPro:      Result := GetTestCPF;
  else
    Result := '0000000000001';
  end;
end;

function TPBMTestSuite.GetTestDataNasc: TDate;
begin
  Result := EncodeDate(1980, 6, 15);
end;

procedure TPBMTestSuite.RunAllTests;
begin
  Log('═══════════════════════════════════════════════════════════════');
  Log('  PBM TEST SUITE - Testando 12 Operadoras');
  Log('  Ambiente: ' + iif(FHomologacao, 'HOMOLOGAÇÃO', 'PRODUÇÃO'));
  Log('═══════════════════════════════════════════════════════════════');
  Writeln;
  
  // Corporativos
  Log('--- CORPORATIVOS ---');
  TestEpharma;
  TestFuncionalCard;
  TestOrizon;
  TestVidalink;
  Writeln;
  
  // Governo
  Log('--- GOVERNO ---');
  TestFarmaciaPopular;
  Writeln;
  
  // Indústria
  Log('--- INDÚSTRIA ---');
  TestPharmalink;
  Writeln;
  
  // Comerciais
  Log('--- COMERCIAIS ---');
  TestTRNCentre;
  Writeln;
  
  // Associativos
  Log('--- ASSOCIATIVOS ---');
  TestPECFebrafar;
  Writeln;
  
  // Fidelização
  Log('--- FIDELIZAÇÃO ---');
  TestLinkedfarma;
  TestEllomais;
  TestNossoClube;
  TestObjectPro;
  Writeln;
  
  PrintSummary;
end;

procedure TPBMTestSuite.TestEpharma;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('EPHARMA');
  if LOp.ID = 0 then
  begin
    LogResult('EPHARMA', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptEpharma),
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('EPHARMA', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('EPHARMA', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptEpharma),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('EPHARMA', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
        
      // Teste 3: Cancelamento (se autorizou)
      if LAuth.Sucesso and (LAuth.NSU <> '') then
      begin
        LStart := Now;
        try
          var LCancel := LClient.CancelarVenda(LAuth.NSU, LAuth.CodigoAutorizacao, 'Teste');
          LogResult('EPHARMA', 'Cancelamento', LCancel.Sucesso, LCancel.Mensagem,
            MilliSecondsBetween(Now, LStart));
        except
          on E: Exception do
            LogResult('EPHARMA', 'Cancelamento', False, E.Message,
              MilliSecondsBetween(Now, LStart));
        end;
      end;
    except
      on E: Exception do
        LogResult('EPHARMA', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('EPHARMA', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestFuncionalCard;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('FUNCIONALCARD');
  if LOp.ID = 0 then
  begin
    LogResult('FUNCIONALCARD', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptFuncionalCard),
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('FUNCIONALCARD', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('FUNCIONALCARD', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptFuncionalCard),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('FUNCIONALCARD', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('FUNCIONALCARD', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('FUNCIONALCARD', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestOrizon;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('ORIZON');
  if LOp.ID = 0 then
  begin
    LogResult('ORIZON', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptOrizon),
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('ORIZON', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('ORIZON', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptOrizon),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('ORIZON', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('ORIZON', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('ORIZON', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestVidalink;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('VIDALINK');
  if LOp.ID = 0 then
  begin
    LogResult('VIDALINK', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptVidalink),
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('VIDALINK', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('VIDALINK', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptVidalink),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('VIDALINK', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('VIDALINK', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('VIDALINK', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestFarmaciaPopular;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('FARMACIAPOPULAR');
  if LOp.ID = 0 then
  begin
    LogResult('FARMACIAPOPULAR', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade (usa NIS como carteirinha)
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptFarmaciaPopular), // NIS
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('FARMACIAPOPULAR', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('FARMACIAPOPULAR', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização (Farmácia Popular tem regras específicas)
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptFarmaciaPopular),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('FARMACIAPOPULAR', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('FARMACIAPOPULAR', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('FARMACIAPOPULAR', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestPharmalink;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('PHARMALINK');
  if LOp.ID = 0 then
  begin
    LogResult('PHARMALINK', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptPharmalink),
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('PHARMALINK', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('PHARMALINK', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptPharmalink),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('PHARMALINK', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('PHARMALINK', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('PHARMALINK', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestTRNCentre;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('TRNCENTRE');
  if LOp.ID = 0 then
  begin
    LogResult('TRNCENTRE', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptTRNCentre),
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('TRNCENTRE', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('TRNCENTRE', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptTRNCentre),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('TRNCENTRE', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('TRNCENTRE', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('TRNCENTRE', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestPECFebrafar;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('PECFEBRAFAR');
  if LOp.ID = 0 then
  begin
    LogResult('PECFEBRAFAR', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        GetTestCarteirinha(ptPECFebrafar),
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('PECFEBRAFAR', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('PECFEBRAFAR', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        GetTestCarteirinha(ptPECFebrafar),
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('PECFEBRAFAR', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('PECFEBRAFAR', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('PECFEBRAFAR', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestLinkedfarma;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('LINKEDFARMA');
  if LOp.ID = 0 then
  begin
    LogResult('LINKEDFARMA', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade (Fidelidade usa CPF)
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        '', // Sem carteirinha
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('LINKEDFARMA', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('LINKEDFARMA', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        '',
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('LINKEDFARMA', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('LINKEDFARMA', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('LINKEDFARMA', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestEllomais;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('ELLOMAIS');
  if LOp.ID = 0 then
  begin
    LogResult('ELLOMAIS', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        '',
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('ELLOMAIS', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('ELLOMAIS', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        '',
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('ELLOMAIS', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('ELLOMAIS', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('ELLOMAIS', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestNossoClube;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('NOSSOCLUBE');
  if LOp.ID = 0 then
  begin
    LogResult('NOSSOCLUBE', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        '',
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('NOSSOCLUBE', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('NOSSOCLUBE', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        '',
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('NOSSOCLUBE', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('NOSSOCLUBE', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('NOSSOCLUBE', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.TestObjectPro;
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LAuth: IPBMAutorizacao;
  LStart: TDateTime;
  LOp: RPBMOperadora;
begin
  LOp := FPersistence.GetOperadora('OBJECTPRO');
  if LOp.ID = 0 then
  begin
    LogResult('OBJECTPRO', 'Config', False, 'Operadora não configurada no banco', 0);
    Exit;
  end;
  
  try
    LClient := TPBMFactory.CreateClientFromOperadora(LOp, FHomologacao);
    
    // Teste 1: Elegibilidade
    LStart := Now;
    try
      LEleg := LClient.ConsultarElegibilidade(
        '',
        GetTestCPF,
        GetTestDataNasc
      );
      LogResult('OBJECTPRO', 'Elegibilidade', LEleg.Sucesso, LEleg.Mensagem, 
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('OBJECTPRO', 'Elegibilidade', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
    // Teste 2: Autorização
    LStart := Now;
    try
      LAuth := LClient.AutorizarVenda(
        '',
        GetTestCPF,
        GetTestDataNasc,
        CreateTestProdutos,
        126.90,
        'TEST_' + FormatDateTime('yyyymmddhhnnss', Now)
      );
      LogResult('OBJECTPRO', 'Autorizacao', LAuth.Sucesso, 
        iif(LAuth.Sucesso, 'NSU: ' + LAuth.NSU, LAuth.Mensagem),
        MilliSecondsBetween(Now, LStart));
    except
      on E: Exception do
        LogResult('OBJECTPRO', 'Autorizacao', False, E.Message, 
          MilliSecondsBetween(Now, LStart));
    end;
    
  except
    on E: Exception do
      LogResult('OBJECTPRO', 'Conexao', False, E.Message, 0);
  end;
end;

procedure TPBMTestSuite.PrintSummary;
var
  LTotal, LSucesso, LFalha: Integer;
  LResult: TTestResult;
  LOperadoras: TDictionary<string, Integer>;
  LPair: TPair<string, Integer>;
begin
  Writeln;
  Log('═══════════════════════════════════════════════════════════════');
  Log('  RESUMO DOS TESTES');
  Log('═══════════════════════════════════════════════════════════════');
  
  LTotal := FResults.Count;
  LSucesso := 0;
  LFalha := 0;
  LOperadoras := TDictionary<string, Integer>.Create;
  
  try
    for LResult in FResults do
    begin
      if LResult.Sucesso then
        Inc(LSucesso)
      else
        Inc(LFalha);
        
      if not LOperadoras.ContainsKey(LResult.Operadora) then
        LOperadoras.Add(LResult.Operadora, 0);
      if LResult.Sucesso then
        LOperadoras[LResult.Operadora] := LOperadoras[LResult.Operadora] + 1;
    end;
    
    Writeln;
    Log(Format('Total de testes: %d', [LTotal]));
    Log(Format('Sucessos: %d (%.1f%%)', [LSucesso, (LSucesso / LTotal) * 100]));
    Log(Format('Falhas: %d (%.1f%%)', [LFalha, (LFalha / LTotal) * 100]));
    
    Writeln;
    Log('Por operadora:');
    for LPair in LOperadoras do
      Log(Format('  %s: %d teste(s) OK', [LPair.Key, LPair.Value]));
      
  finally
    LOperadoras.Free;
  end;
  
  Writeln;
  Log('═══════════════════════════════════════════════════════════════');
end;

// =============================================================================
// PROGRAMA PRINCIPAL
// =============================================================================

var
  Connection: TFDConnection;
  TestSuite: TPBMTestSuite;
  
begin
  try
    Writeln('PBM Test Suite v1.0');
    Writeln('===================');
    Writeln;
    
    // Configura conexão MySQL
    Connection := TFDConnection.Create(nil);
    try
      Connection.DriverName := 'MySQL';
      Connection.Params.Values['Server'] := 'localhost';
      Connection.Params.Values['Database'] := 'aione';
      Connection.Params.Values['User_Name'] := 'root';
      Connection.Params.Values['Password'] := '';
      Connection.Params.Values['CharacterSet'] := 'utf8mb4';
      
      Writeln('Conectando ao banco de dados...');
      try
        Connection.Connected := True;
        Writeln('Conectado!');
        Writeln;
      except
        on E: Exception do
        begin
          Writeln('ERRO ao conectar: ', E.Message);
          Writeln;
          Writeln('Verifique as configurações de conexão no início do programa.');
          Writeln('Pressione ENTER para sair...');
          Readln;
          Exit;
        end;
      end;
      
      // Executa testes
      TestSuite := TPBMTestSuite.Create(Connection);
      try
        TestSuite.Homologacao := True; // Ambiente de homologação
        TestSuite.RunAllTests;
      finally
        TestSuite.Free;
      end;
      
    finally
      Connection.Free;
    end;
    
    Writeln;
    Writeln('Pressione ENTER para sair...');
    Readln;
    
  except
    on E: Exception do
    begin
      Writeln('ERRO FATAL: ', E.Message);
      Readln;
    end;
  end;
end.
