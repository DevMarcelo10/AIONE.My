unit uWaitForm;

interface

uses
   System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.ExtCtrls,
   Vcl.StdCtrls, Winapi.Windows, System.Types, System.UITypes, System.SyncObjs,
   Vcl.Graphics;

   procedure ShowWait(const Text: string = 'Aguarde...'; OwnerForm: TCustomForm = nil);
   procedure HideWait;
   function WaitVisible: Boolean;

implementation

type
  TWaitForm = class(TForm)
  private
    FShape: TShape;
    FLabel: TLabel;
    procedure BuildUI(const Text: string);
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    procedure UpdateText(const Text: string);
  end;

var
  GWaitForm: TWaitForm = nil;
  GRefCount: Integer = 0;
  GCS: TCriticalSection; // proteção de acesso

{--- TWaitForm -------------------------------------------------------------}

constructor TWaitForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  BorderStyle := bsNone;
  FormStyle   := fsStayOnTop;
  Position    := poDesigned;
  Width       := 230;
  Height      := 110;
  Color       := clBtnFace;
  DoubleBuffered := True;
  AlphaBlend  := True;       // evita flicker
  AlphaBlendValue := 255;
  BuildUI('Aguarde...');
end;

procedure TWaitForm.BuildUI(const Text: string);
begin
  FShape := TShape.Create(Self);
  FShape.Parent      := Self;
  FShape.Align       := alClient;
  FShape.Pen.Color   := $000099FF;
  FShape.Brush.Color := $00B9CFFF;

  FLabel := TLabel.Create(Self);
  FLabel.Parent      := Self;
  FLabel.Transparent := True;
  FLabel.AutoSize    := False;
  FLabel.Font.Name   := 'Roboto';
  FLabel.Font.Size   := 22;
  FLabel.Align       := alClient;
  FLabel.Alignment   := taCenter;
  FLabel.Layout      := tlCenter;
  UpdateText(Text);
end;

procedure TWaitForm.UpdateText(const Text: string);
begin
  if Text.Trim.IsEmpty then
       FLabel.Caption := 'Aguarde...'
  else FLabel.Caption := Text;
end;

{--- Helpers ---------------------------------------------------------------}

procedure CenterToOwnerOrScreen(AForm: TCustomForm; OwnerForm: TCustomForm);
var
  R: TRect;
  X, Y: Integer;
begin
  if Assigned(OwnerForm) then
  begin
    R := OwnerForm.BoundsRect;
    X := R.Left + ((R.Width - AForm.Width) div 2);
    Y := R.Top  + ((R.Height - AForm.Height) div 2);
  end
  else
  begin
    X := (Screen.WorkAreaWidth  - AForm.Width) div 2 + Screen.WorkAreaLeft;
    Y := (Screen.WorkAreaHeight - AForm.Height) div 2 + Screen.WorkAreaTop;
  end;
  AForm.Left := X;
  AForm.Top  := Y;
end;

procedure DoShowWait(const Text: string; OwnerForm: TCustomForm);
begin
  if not Assigned(GWaitForm) then GWaitForm := TWaitForm.CreateNew(Application);
  Inc(GRefCount);
  GWaitForm.UpdateText(Text);
  CenterToOwnerOrScreen(GWaitForm, OwnerForm);
  if not GWaitForm.Visible then GWaitForm.Show;
  GWaitForm.Update;
  Application.ProcessMessages;
end;

procedure DoHideWait;
begin
  if GRefCount > 0 then Dec(GRefCount);

  if (GRefCount = 0) and Assigned(GWaitForm) then
  begin
    try
      GWaitForm.Hide;
    finally
      FreeAndNil(GWaitForm);
    end;
  end;
  Application.ProcessMessages;
end;

function InMainThread: Boolean;
begin
  Result := GetCurrentThreadId = MainThreadID;
end;

procedure ShowWait(const Text: string; OwnerForm: TCustomForm);
begin
  GCS.Enter; // proteger refcount/criação
  try
    if InMainThread then
      DoShowWait(Text, OwnerForm)
    else
      TThread.Queue(nil,
        procedure
        begin
          DoShowWait(Text, OwnerForm);
        end);
  finally
    Screen.Cursor := crHourGlass;
    GCS.Leave;
  end;
end;

procedure HideWait;
begin
  GCS.Enter;
  try
    if InMainThread then
      DoHideWait
    else
      TThread.Queue(nil,
        procedure
        begin
          DoHideWait;
        end);
  finally
    GCS.Leave;
    Screen.Cursor := crDefault;
  end;
end;

function WaitVisible: Boolean;
begin
  Result := Assigned(GWaitForm) and GWaitForm.Visible;
end;

initialization
  GCS := TCriticalSection.Create;

finalization
  if Assigned(GWaitForm) then FreeAndNil(GWaitForm);
  GCS.Free;

end.

end.

