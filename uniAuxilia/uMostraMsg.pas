unit uMostraMsg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
  LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDSimplePanel, Vcl.ExtCtrls, Vcl.Imaging.pngimage, AdvGlowButton, Math;

type
  TFrmMostraMsg = class(TForm)
    PanelBase: TLMDSimplePanel;
    PanelMsg: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    Label2: TLMDLabel;
    Label1: TLMDLabel;
    PanelImgs: TLMDSimplePanel;
    ImgError: TImage;
    ImgInformation: TImage;
    ImgQuestion: TImage;
    ImgWarning: TImage;
    PanelButtons: TLMDSimplePanel;
    Button1: TAdvGlowButton;
    Button2: TAdvGlowButton;
    Button3: TAdvGlowButton;
    timAlpha: TTimer;
    procedure ButtonClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure timAlphaTimer(Sender: TObject);
  private
    { Private declarations }
    procedure CentralizarTextoVerticalmente(recLabel:TLMDLabel);
  public
    { Public declarations }
    Click:Integer;
    btPadrao:Integer;
  end;

var
  FrmMostraMsg: TFrmMostraMsg;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmMostraMsg.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   if not Button1.Visible then
   begin
      if Button2.Visible and Button3.Visible then
      begin
         Button2.Left := Button2.Left - 81;
         Button3.Left := Button3.Left - 81;
      end;
   end; //if
   CentralizarTextoVerticalmente(Label2);
   FadeInOut(Self, 'In', 10);
end;

procedure TFrmMostraMsg.ButtonClick(Sender: TObject);
begin
   Click := (Sender as TAdvGlowButton).Tag;
   Self.Close;
end;

procedure TFrmMostraMsg.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (btPadrao = 2) and (key = 13) then ButtonClick(Button1);
end;

function RepeteString(const AString: string; ACount: Integer): string;
var
   I:Integer;
begin
   Result := '';
   for I := 1 to ACount do Result := Result + AString;
end;
procedure TFrmMostraMsg.CentralizarTextoVerticalmente(recLabel:TLMDLabel);
var
   Bitmap: TBitmap;
   AlturaTexto: Integer;
   NumeroLinhasBranco: Integer;
   EspacoDisponivel: Integer;
   TextoOriginal: string;
   TextoComEspacos: string;
begin
   Bitmap := TBitmap.Create;
   try
      Bitmap.Canvas.Font.Assign(recLabel.Font);
      AlturaTexto        := Bitmap.Canvas.TextHeight(recLabel.Caption);
      EspacoDisponivel   := recLabel.Height - AlturaTexto;
      NumeroLinhasBranco := EspacoDisponivel div Bitmap.Canvas.TextHeight('A');
      TextoOriginal      := recLabel.Caption;
      TextoComEspacos    := RepeteString(sLineBreak, Max(0, NumeroLinhasBranco div 2)) + TextoOriginal;
      recLabel.Caption   := TextoComEspacos;
   finally
      Bitmap.Free;
   end;
end;

end.
