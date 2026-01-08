program PBM_TestVCL;

{******************************************************************************
  PBM Test VCL - Aplicação de Teste Visual
  
  Aplicação VCL para testar individualmente cada uma das 12 operadoras PBM.
  
  Funcionalidades:
  - Lista visual das 12 operadoras com status
  - Teste individual de Elegibilidade, Autorização, Cancelamento, Consulta
  - Teste em lote de todas as operadoras
  - Log detalhado de execução
  - Suporte a homologação e produção
  
  Dependências:
  - FireDAC para MySQL
  - MarcLib.pas (função iif)
  - Units uPBM.* (Interfaces, Factory, Persistence, cada operadora)

******************************************************************************}

uses
  Vcl.Forms,
  uPBM.TestForm in 'uPBM.TestForm.pas' {frmPBM_Test},
  uPBM.Factory in '..\uPBM.Factory.pas',
  uPBM.Persistence in '..\uPBM.Persistence.pas',
  uPBM.Epharma in '..\Epharma\uPBM.Epharma.pas',
  uPBM.FuncionalCard in '..\FuncionalCard\uPBM.FuncionalCard.pas',
  uPBM.Orizon in '..\Orizon\uPBM.Orizon.pas',
  uPBM.Vidalink in '..\Vidalink\uPBM.Vidalink.pas',
  uPBM.FarmaciaPopular in '..\FarmaciaPopular\uPBM.FarmaciaPopular.pas',
  uPBM.Pharmalink in '..\Pharmalink\uPBM.Pharmalink.pas',
  uPBM.TRNCentre in '..\TRNCentre\uPBM.TRNCentre.pas',
  uPBM.PECFebrafar in '..\PECFebrafar\uPBM.PECFebrafar.pas',
  uPBM.Linkedfarma in '..\Linkedfarma\uPBM.Linkedfarma.pas',
  uPBM.Ellomais in '..\Ellomais\uPBM.Ellomais.pas',
  uPBM.NossoClube in '..\NossoClube\uPBM.NossoClube.pas',
  uPBM.ObjectPro in '..\ObjectPro\uPBM.ObjectPro.pas',
  uPBM.Base in '..\uPBM.Base.pas',
  uPBM.Interfaces in '..\uPBM.Interfaces.pas',
  uPBM.Results in '..\uPBM.Results.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'PBM Test Suite';
  Application.CreateForm(TfrmPBM_Test, frmPBM_Test);
  Application.Run;
end.
