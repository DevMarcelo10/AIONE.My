unit uArqPedido;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, AdvGlowButton;

type
  TArqPedido = class
  private
    FIDPed: Integer;
    FStatus: String;
    FItensAlterados: Boolean;
    FReceitasAlteradas: Boolean;
    FbtPedido: TAdvGlowButton;
  public
    property IDPed: Integer read FIDPed write FIDPed;
    property Status: String read FStatus write FStatus;
    property ItensAlterados: Boolean read FItensAlterados write FItensAlterados;
    property ReceitasAlteradas: Boolean read FReceitasAlteradas write FReceitasAlteradas;
    property btPedido: TAdvGlowButton read FbtPedido write FbtPedido;

    constructor Create(AIDPed: Integer; AStatus: String; AbtPedido: TAdvGlowButton);
    destructor Destroy; override;
  end;

implementation

constructor TArqPedido.Create(AIDPed: Integer; AStatus: String; AbtPedido: TAdvGlowButton);
begin
  FIDPed := AIDPed;
  FStatus := AStatus;
  FItensAlterados:= False;
  FbtPedido:= AbtPedido;

end;

destructor TArqPedido.Destroy;
begin

  if Assigned(FbtPedido) then
    FreeAndNil(FbtPedido);

  inherited;
end;

end.
