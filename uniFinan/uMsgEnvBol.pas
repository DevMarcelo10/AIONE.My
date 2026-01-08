unit uMsgEnvBol;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDSimplePanel, Vcl.ExtCtrls, Vcl.Imaging.pngimage, AdvGlowButton;

type
  TFrmMsgEnvBol = class(TForm)
    PanelBase: TLMDSimplePanel;
    PanelMsg: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    Label2: TLMDLabel;
    Label1: TLMDLabel;
    PanelImgs: TLMDSimplePanel;
    ImgQuestion: TImage;
    PanelButtons: TLMDSimplePanel;
    Button1: TAdvGlowButton;
    Button2: TAdvGlowButton;
    Button3: TAdvGlowButton;
    timAlpha: TTimer;
    procedure timAlphaTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Click:Integer;
  end;

var
  FrmMsgEnvBol: TFrmMsgEnvBol;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmMsgEnvBol.FormShow(Sender: TObject);
begin
   Click := 1
end;

procedure TFrmMsgEnvBol.Button1Click(Sender: TObject);
begin
   Click := TAdvGlowButton(Sender).Tag;
   Self.Close;
end;

procedure TFrmMsgEnvBol.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 10);
end;

procedure TFrmMsgEnvBol.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
