unit uShadowForm;

interface

uses
  System.Classes,Winapi.Windows,Vcl.Forms,Vcl.Graphics,Vcl.Controls;

// Centraliza AChild (por ex. um TForm) em relação à área cliente de AParent.
// Funciona tanto para forms top-level quanto para controles com Parent.
procedure CentralizarControl(AChild: TControl; AParent: TWinControl);

type
  TShadowHelper = class
  public
    class function ShowModalWithShadow(ABaseForm, ADialog: TForm): Integer; overload;
    class function ShowModalWithShadow(ABaseForm, ADialog: TForm; ARelativeTo: TWinControl): Integer; overload;
  end;

implementation

procedure CentralizarControl(AChild: TControl; AParent: TWinControl);
var
  pt: TPoint;
  isTopLevelForm: Boolean;
  targetLeft, targetTop: Integer;
begin
  if (AChild = nil) or (AParent = nil) then Exit;
  targetLeft := (AParent.ClientWidth  - AChild.Width) div 2;
  targetTop  := (AParent.ClientHeight - AChild.Height) div 2;
  isTopLevelForm := (AChild is TCustomForm) and (TCustomForm(AChild).Parent = nil);
  if isTopLevelForm then
  begin
    pt := AParent.ClientToScreen(Point(targetLeft, targetTop));
    AChild.Left := pt.X;
    AChild.Top  := pt.Y;
    Exit;
  end;
  if AChild.Parent = AParent then
  begin
    AChild.Left := targetLeft;
    AChild.Top  := targetTop;
    Exit;
  end;
  if AChild.Parent <> nil then
  begin
    pt := AParent.ClientToScreen(Point(targetLeft, targetTop));
    pt := AChild.Parent.ScreenToClient(pt);
    AChild.Left := pt.X;
    AChild.Top  := pt.Y;
    Exit;
  end;
  pt := AParent.ClientToScreen(Point(targetLeft, targetTop));
  AChild.Left := pt.X;
  AChild.Top  := pt.Y;
end;

{ TShadowHelper }

class function TShadowHelper.ShowModalWithShadow(ABaseForm, ADialog: TForm): Integer;
begin
   Result := ShowModalWithShadow(ABaseForm, ADialog, nil);
end;

class function TShadowHelper.ShowModalWithShadow(ABaseForm, ADialog: TForm; ARelativeTo: TWinControl): Integer;
const
  SHADOW_OPACITY = 110; // opacidade fixa
var
  Shadow: TForm;
  CenterParent: TWinControl;
begin
  if (ABaseForm = nil) or (ADialog = nil) then Exit(mrNone);

  Shadow := TForm.Create(nil);
  try
    Shadow.BorderStyle      := bsNone;
    Shadow.Position         := poDesigned;
    Shadow.Color            := clBlack;
    Shadow.AlphaBlend       := True;
    Shadow.AlphaBlendValue  := SHADOW_OPACITY;
    Shadow.FormStyle        := fsStayOnTop;
    Shadow.Enabled          := False;
    Shadow.SetBounds(ABaseForm.Left, ABaseForm.Top, ABaseForm.Width, ABaseForm.Height);
    Shadow.Show;
    Shadow.Update;
    ADialog.Position := poDesigned;
    if Assigned(ARelativeTo) then
         CenterParent := ARelativeTo
    else CenterParent := ABaseForm;
    CentralizarControl(ADialog, CenterParent);
    ADialog.PopupParent := Shadow;
    Result := ADialog.ShowModal;
  finally
    Shadow.Free;
  end;
end;

end.

