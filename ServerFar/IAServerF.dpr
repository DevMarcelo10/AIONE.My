program IAServerF;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  uDWServer in 'uDWServer.pas' {FrmServer},
  uDM in 'uDM.pas' {DMServer: TServerMethodDataModule},
  uSincroniza in 'uSincroniza.pas',
  uVeChaves in '..\uniAuxilia\uVeChaves.pas',
  uIBPTSync in 'uIBPTSync.pas',
  uCMEDUpdater in 'uCMEDUpdater.pas',
  uGeraNFCe in 'uniFatura\uGeraNFCe.pas',
  uGeraNFe in 'uniFatura\uGeraNFe.pas',
  uNFCCancela in 'uniFatura\uNFCCancela.pas',
  uNFCRetorno in 'uniFatura\uNFCRetorno.pas',
  uNFRetorno in 'uniFatura\uNFRetorno.pas',
  uXMLAutorizado in 'uniFatura\uXMLAutorizado.pas',
  uConst in '..\uniAuxilia\uConst.pas',
  uCertificados in '..\uniFatura\uCertificados.pas',
  uCalculaNF in 'uniFatura\uCalculaNF.pas',
  uImpostosRT in 'uniFatura\uImpostosRT.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmServer, FrmServer);
  Application.Run;
end.
