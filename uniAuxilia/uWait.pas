unit uWait;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomLabel, LMDLabel, Vcl.Imaging.pngimage, Vcl.ExtCtrls, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, AdvReflectionImage, AdvSmoothPanel;

type
  TFrmWait = class(TForm)
    lbMens: TLMDLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmWait: TFrmWait;

implementation

{$R *.dfm}

procedure TFrmWait.FormCreate(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
end;

procedure TFrmWait.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Screen.Cursor := crDefault;
end;

end.
