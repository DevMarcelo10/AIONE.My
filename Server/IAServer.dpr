program IAServer;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  uDWServer in 'uDWServer.pas' {FrmServer},
  uDM in 'uDM.pas' {DMServer: TServerMethodDataModule},
  UnitTypes in 'UnitTypes.pas',
  DownloadCMED in 'DownloadCMED.pas',
  uIBPTUpdater in 'uIBPTUpdater.pas',
  uIBPTCapa in 'uIBPTCapa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmServer, FrmServer);
  Application.Run;
end.
