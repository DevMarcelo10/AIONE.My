unit uTabPromProg;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
   TLimPromProg = record   // Estrutura par armazenar tabela de Promoções progressivas
     IDProm: Integer;
     IDProd: Integer;
     QtdVen: Double;
     VlrVen: Double;
     PrecoVen: Double;
     PerDesc: Double;
   end;

  TTabPromProg = class
  private
    FListaPromProgressivo: TList<TLimPromProg>;

  public
    constructor Create();
    destructor Destroy; override;

    function ExisteTabIdProm(IDProm: Integer): Boolean;
    function ExisteTabIdProd(IDProm, IDProd: Integer): Boolean;

    function PegaVlrVen(IDProm, IDProd: Integer; QtdVen: Currency): Currency;
    function PegaPerDesc(IDProm, IDProd: Integer; QtdVen: Currency): Currency;

    procedure Limpar;
    procedure AddPromProg(IDProm, IDProd: Integer; QtdVen, VlrVen, PrecoVen, PerDesc: Currency);
  end;

implementation

constructor TTabPromProg.Create();
begin
  FListaPromProgressivo := TList<TLimPromProg>.Create;

end;

destructor TTabPromProg.Destroy;
begin
  inherited;
  FreeAndNil(FListaPromProgressivo);
end;

function TTabPromProg.ExisteTabIdProm(IDProm: Integer): Boolean;
var
  Item: TLimPromProg;
begin
  Result := False;
  for Item in FListaPromProgressivo do
  begin
    if Item.IDProm = IDProm then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TTabPromProg.ExisteTabIdProd(IDProm, IDProd: Integer): Boolean;
var
  Item: TLimPromProg;
begin
  Result := False;
  for Item in FListaPromProgressivo do
  begin
    if (Item.IDProm = IDProm) and (Item.IDProd = IDProd) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TTabPromProg.PegaVlrVen(IDProm, IDProd: Integer; QtdVen: Currency): Currency;
var
  Item: TLimPromProg;
  ultimoVlrVen: Currency;
begin
  Result := 0;
  ultimoVlrVen:= 0;

  for Item in FListaPromProgressivo do
  begin
    if (Item.IDProm = IDProm) and (Item.IDProd = IDProd) then
    begin
      ultimoVlrVen:= Item.VlrVen;

      if (Item.QtdVen = QtdVen) then
        Result := Item.VlrVen;
    end;
  end;

  if Result = 0 then
    Result:= ultimoVlrVen;
end;

function TTabPromProg.PegaPerDesc(IDProm, IDProd: Integer; QtdVen: Currency): Currency;
var
  Item: TLimPromProg;
  ultimoVlrVen: Currency;
begin
  Result := 0;
  ultimoVlrVen:= 0;

  for Item in FListaPromProgressivo do
  begin
    if (Item.IDProm = IDProm) and (Item.IDProd = IDProd) then
    begin
      ultimoVlrVen:= Item.PerDesc;

      if (Item.QtdVen = QtdVen) then
        Result := Item.PerDesc;
    end;
  end;

  if Result = 0 then
    Result:= ultimoVlrVen;
end;

procedure TTabPromProg.Limpar;
begin
  FListaPromProgressivo.Clear;
end;

procedure TTabPromProg.AddPromProg(IDProm, IDProd: Integer; QtdVen, VlrVen, PrecoVen, PerDesc: Currency);
var
  PromPgr: TLimPromProg;
begin
  PromPgr.IDProm   := IDProm;
  PromPgr.IDProd   := IDProd;
  PromPgr.QtdVen   := QtdVen;
  PromPgr.VlrVen   := VlrVen;
  PromPgr.PrecoVen := PrecoVen;
  PromPgr.PerDesc  := PerDesc;

  FListaPromProgressivo.Add(PromPgr);
end;

end.
