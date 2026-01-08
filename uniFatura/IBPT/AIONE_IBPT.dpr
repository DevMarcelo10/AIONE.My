program AIONE_IBPT;

uses
  Forms,
  MidasLib,
  ProxyConfig in 'ProxyConfig.pas' {frProxyConfig},
  uPrincipal in 'uPrincipal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
