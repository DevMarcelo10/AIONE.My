unit uTabDescProg;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
   TLimDescProg = record   // Estrutura par armazenar tabela de desconto progressivo
     IDDesc: Integer;
     Vlrlim: Currency;
     PerDesc: Currency;
   end;

   TDescSum = record   // Estrutura par armazenar Valor Total, Ultimo Percentual por IDDesc
     IDDesc: Integer;
     VlrTotal: Currency;
     UltPerDesc: Currency;  // Último Percentual de desconto
     UltPercAlt: Boolean; // Último Percentual de desconto Modificado/Alterado
   end;

  TTabDescProg = class
  private
    FListaDescProgressivo: TList<TLimDescProg>;
    FListaDescSum: TList<TDescSum>;

    function AddVlrTot(IDDesc: Integer; valor: Currency): Currency;
    function MinusVlrTot(IDDesc: Integer; valor: Currency): Currency;
    procedure AltPercDesc(IDDesc: Integer; percDesc: Currency);
  public
    constructor Create();
    destructor Destroy; override;

    function ExisteTabIdDesc(IDDesc: Integer): Boolean;
    function MudouUltPercDesc(IDDesc: Integer): Boolean;

    function AddVlr(IDDesc: Integer; valor: Currency): Currency;
    //function DelVlr(IDDesc: Integer; valor: Currency): Currency;

    function PercDesc(IDDesc: Integer): Currency;
    function VlrTotal(IDDesc: Integer): Currency;

    procedure Limpar;
    procedure AddLimDescProg(IDDesc: Integer; Vlrlim: Currency; PerDesc: Currency);
  end;

implementation

constructor TTabDescProg.Create();
begin
  FListaDescProgressivo := TList<TLimDescProg>.Create;
  FListaDescSum:= TList<TDescSum>.Create;
end;

destructor TTabDescProg.Destroy;
begin
  inherited;
  FreeAndNil(FListaDescSum);
  FreeAndNil(FListaDescProgressivo);
end;

function TTabDescProg.ExisteTabIdDesc(IDDesc: Integer): Boolean;
var
  Item: TLimDescProg;
begin
  Result := False;
  for Item in FListaDescProgressivo do
  begin
    if Item.IDDesc = IDDesc then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

// IDDesc = id do desconto progressivo
// valor de venda do produto
// retorno é o percentual encontrado dentro do desconto progressivo
function TTabDescProg.AddVlr(IDDesc: Integer; valor: Currency): Currency;
var
  i: Integer;
  valorTot: Currency;
  percDesc: Currency;
begin
  Result := 0;
  valorTot := valor;  //AddVlrTot(IDDesc, valor);
  percDesc := 0;

  for i := 0 to FListaDescProgressivo.Count - 1 do
  begin
    if FListaDescProgressivo[i].IDDesc = IDDesc then
    begin
      // Se o valor total é menor ou igual ao limite atual
      if valorTot <= FListaDescProgressivo[i].Vlrlim then
      begin
        percDesc := FListaDescProgressivo[i].PerDesc;
        break; // Encontrou a faixa correta, sai do loop
      end
      else
      begin
        // Se o valor é maior que o limite atual, guarda o percentual
        // Isso será usado se o valor for maior que todos os limites
        percDesc := FListaDescProgressivo[i].PerDesc;
      end;
    end;
  end;

  //AltPercDesc(IDDesc, percDesc);
  Result := percDesc;
end;

{function TTabDescProg.DelVlr(IDDesc: Integer; valor: Currency): Currency;
var
  i: Integer;
  valorTot: Currency;
  percDesc: Currency;
begin
  Result:= 0;
  valorTot:= MinusVlrTot(IDDesc, valor);
  percDesc := 0;

  for i := 0 to FListaDescProgressivo.Count - 1 do
  begin
    if FListaDescProgressivo[i].IDDesc = IDDesc then
    begin
      // Se o valor total é menor ou igual ao limite atual
      if valorTot <= FListaDescProgressivo[i].Vlrlim then
      begin
        percDesc := FListaDescProgressivo[i].PerDesc;
        break; // Encontrou a faixa correta, sai do loop
      end
      else
      begin
        // Se o valor é maior que o limite atual, guarda o percentual
        // Isso será usado se o valor for maior que todos os limites
        percDesc := FListaDescProgressivo[i].PerDesc;
      end;
    end;
  end;

  AltPercDesc(IDDesc, percDesc);
  Result := percDesc;
end;}

function TTabDescProg.MinusVlrTot(IDDesc: Integer; valor: Currency): Currency;
var
  i: Integer;
  DescSum: TDescSum;
begin
  Result := 0;
  for i := 0 to FListaDescSum.Count - 1 do
  begin
    if FListaDescSum[i].IDDesc = IDDesc then
    begin
      // Copia o registro, atualiza o campo, e substitui na lista
      DescSum := FListaDescSum[i];
      DescSum.VlrTotal  := DescSum.VlrTotal - valor;
      FListaDescSum[i] := DescSum;
      Result := DescSum.VlrTotal;
      Exit;
    end;
  end;
  // Se não encontrou o IDDesc, adiciona um novo
  DescSum.IDDesc     := IDDesc;
  DescSum.VlrTotal   := valor;
  //DescSum.UltPerDesc := percDesc; // ou algum valor default
  FListaDescSum.Add(DescSum);
  Result := valor;
end;

// Retorna Flag se PercDesc foi alterado
function TTabDescProg.MudouUltPercDesc(IDDesc: Integer): Boolean;
var
  Item: TDescSum;
begin
  Result := False;

  for Item in FListaDescSum do
  begin
    if Item.IDDesc = IDDesc then
    begin
      Result := Item.UltPercAlt;
      Exit;
    end;
  end;
end;

function TTabDescProg.AddVlrTot(IDDesc: Integer; valor: Currency): Currency;
var
  i: Integer;
  DescSum: TDescSum;
begin
  Result := 0;
  for i := 0 to FListaDescSum.Count - 1 do
  begin
    if FListaDescSum[i].IDDesc = IDDesc then
    begin
      // Copia o registro, atualiza o campo, e substitui na lista
      DescSum := FListaDescSum[i];
      DescSum.VlrTotal  := DescSum.VlrTotal + valor;
      //DescSum.UltPerDesc:= percDesc;
      FListaDescSum[i] := DescSum;
      Result := DescSum.VlrTotal;
      Exit;
    end;
  end;
  // Se não encontrou o IDDesc, adiciona um novo
  DescSum.IDDesc     := IDDesc;
  DescSum.VlrTotal   := valor;
  //DescSum.UltPerDesc := percDesc; // ou algum valor default
  FListaDescSum.Add(DescSum);
  Result := valor;
end;

// Altera Percentual de Desconto do IDDesc
// Altera Flag se Ultimo Perc Desconto Alterou
procedure TTabDescProg.AltPercDesc(IDDesc: Integer; percDesc: Currency);
var
  i: Integer;
  DescSum: TDescSum;
begin
  for i := 0 to FListaDescSum.Count - 1 do
  begin
    if FListaDescSum[i].IDDesc = IDDesc then
    begin
      // Copia o registro, atualiza o campo, e substitui na lista
      DescSum := FListaDescSum[i];
      if DescSum.UltPerDesc > 0 then
        DescSum.UltPercAlt:= (DescSum.UltPerDesc <> percDesc);
      DescSum.UltPerDesc:= percDesc;
      FListaDescSum[i] := DescSum;
      Exit;
    end;
  end;
end;

function TTabDescProg.PercDesc(IDDesc: Integer): Currency;
var
  Item: TDescSum;
begin
  Result := 0;
  for Item in FListaDescSum do
  begin
    if Item.IDDesc = IDDesc then
    begin
      Result := Item.UltPerDesc;
      Exit;
    end;
  end;
end;

function TTabDescProg.VlrTotal(IDDesc: Integer): Currency;
var
  Item: TDescSum;
begin
  Result := 0;
  for Item in FListaDescSum do
  begin
    if Item.IDDesc = IDDesc then
    begin
      Result := Item.VlrTotal;
      Exit;
    end;
  end;
end;

procedure TTabDescProg.Limpar;
begin
  FListaDescProgressivo.Clear;
  FListaDescSum.Clear;
end;


procedure TTabDescProg.AddLimDescProg(IDDesc: Integer; Vlrlim: Currency; PerDesc: Currency);
var
  DescPgr: TLimDescProg;
begin
  DescPgr.IDDesc := IDDesc;
  DescPgr.Vlrlim := Vlrlim;
  DescPgr.PerDesc:= PerDesc;

  FListaDescProgressivo.Add(DescPgr);
end;

end.
