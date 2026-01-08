unit uNFRetorno;

{-----------------------------------------------------------------------------
  uNFCRetorno (compat 55/65)

    - Detecção automática do modelo (55 ou 65)
    - XPaths genéricos para protocolos/retornos (retEnviNFe, retConsReciNFe,
      retConsSitNFe, protNFe/infProt, retEvento/procEventoNFe)
    - Mantém variáveis de retorno usuais: cStat, xMotivo, chNFe, nProt, dhRecbto

  Observações:
    * Schema de retorno é comum à NFe/NFCe. Diferenças principais ficam no
      conteúdo da própria nota (ide/mod, infNFeSupl, pagamentos etc.).
    * O parser abaixo evita prender-se a nomes exclusivos da NFC-e.
-------------------------------------------------------------------------------}

interface

uses
  System.SysUtils, System.Classes, Xml.XMLDoc, Xml.XMLIntf, System.Variants,
  System.RegularExpressions, System.Generics.Collections, System.StrUtils,
  MarcLib, uConst, uDM, spdNFe;

type
  TModeloDoc = (mdDesconhecido = 0, mdNFe55 = 55, mdNFCe65 = 65);

  TRetornoNFe = record
    Modelo   : TModeloDoc; // 55 ou 65
    cStat    : string;
    xMotivo  : string;
    chNFe    : string;
    nProt    : string;
    dhRecbto : string;
    NrNota   : string;
    XmlBruto : String;
    Sucesso  : Boolean;
    Indisponivel : Boolean;
  end;

   function ParseRetornoXML (const AXML: string; out ARet: TRetornoNFe): Boolean; overload;
   function ParseRetornoXML (const AStream: TStream; out ARet: TRetornoNFe): Boolean; overload;
   function EnviarNFSincrono(const recSpdNFe:TspdNFe; const NumLote, XmlAssinado:String): TRetornoNFe;

implementation

var
  locServer: TDMServer;

const
  // XPaths genéricos sem amarrar a NFCe/NFe
  XPATH_CSTAT    = '/*/*[local-name()="cStat"]';
  XPATH_XMOTIVO  = '/*/*[local-name()="xMotivo"]';

  // Dentro de protNFe/infProt
  XPATH_PROT_INF = '//*[local-name()="protNFe"]/*[local-name()="infProt"]';
  XPATH_CHNFE    = '//*[local-name()="protNFe"]/*[local-name()="infProt"]/*[local-name()="chNFe"]';
  XPATH_NPROT    = '//*[local-name()="protNFe"]/*[local-name()="infProt"]/*[local-name()="nProt"]';
  XPATH_DHRECBTO = '//*[local-name()="protNFe"]/*[local-name()="infProt"]/*[local-name()="dhRecbto"]';

  // Evento
  XPATH_RETEVENTO = '//*[local-name()="retEvento"]/*[local-name()="infEvento"]';
  XPATH_XMOTIVO_EVT = '//*[local-name()="retEvento"]/*[local-name()="infEvento"]/*[local-name()="xMotivo"]';
  XPATH_CSTAT_EVT   = '//*[local-name()="retEvento"]/*[local-name()="infEvento"]/*[local-name()="cStat"]';

  // Modelo dentro da nota (ide/mod)
  XPATH_MOD      = '//*[local-name()="NFe"]/*[local-name()="infNFe"]/*[local-name()="ide"]/*[local-name()="mod"]';

// Helpers --------------------------------------------------------------------

function LocalName(const Node: IXMLNode): string; inline;
begin
  Result := Node.NodeName;
  // remove prefix namespace se houver (ex.: nfe:protNFe)
  if Pos(':', Result) > 0 then
    Result := Copy(Result, Pos(':', Result) + 1, MaxInt);
end;

procedure CollectDescendantsByLocalName(const Start: IXMLNode; const AName: string; AOut: TList<IXMLNode>);
var
  i: Integer;
  ch: IXMLNode;
begin
  if Start = nil then Exit;
  for i := 0 to Start.ChildNodes.Count - 1 do
  begin
    ch := Start.ChildNodes[i];
    if SameText(LocalName(ch), AName) then
      AOut.Add(ch);
    // busca recursiva
    CollectDescendantsByLocalName(ch, AName, AOut);
  end;
end;

function FindFirstByPathLocalName(const Root: IXMLNode; const Names: TArray<string>): IXMLNode;
var
  level, i: Integer;
  curLevel, nextLevel: TList<IXMLNode>;
  n: IXMLNode;
begin
  Result := nil;
  if (Root = nil) or (Length(Names) = 0) then Exit;

  curLevel := TList<IXMLNode>.Create;
  nextLevel := TList<IXMLNode>.Create;
  try
    // nível 0: procurar em toda a árvore pelo primeiro nome (como //*[])
    CollectDescendantsByLocalName(Root, Names[0], curLevel);

    for level := 1 to High(Names) do
    begin
      nextLevel.Clear;
      for i := 0 to curLevel.Count - 1 do
        CollectDescendantsByLocalName(curLevel[i], Names[level], nextLevel);
      curLevel.Clear;
      for i := 0 to nextLevel.Count - 1 do
        curLevel.Add(nextLevel[i]);
      if curLevel.Count = 0 then Exit; // caminho não encontrado
    end;

    if curLevel.Count > 0 then
      Result := curLevel[0];
  finally
    curLevel.Free;
    nextLevel.Free;
  end;
end;

function ParseLocalNamePath(const AXPath: string): TArray<string>;
var
  names: TArray<string>;
  s, token: string;
  p, p2: Integer;
begin
  // Extrai sequências de local-name()="XYZ"
  s := AXPath;
  while True do
  begin
    p := Pos('local-name()="', s);
    if p = 0 then Break;
    p := p + Length('local-name()="');
    p2 := Pos('"', Copy(s, p, MaxInt));
    if p2 = 0 then Break;
    token := Copy(s, p, p2 - 1);
    names := names + [token];
    s := Copy(s, p + p2, MaxInt);
  end;
  Result := names;
end;

function _SelectNode(const ARoot: IXMLNode; const AXPath: string): IXMLNode;
var
  names: TArray<string>;
  rootUse: IXMLNode;
begin
  Result := nil;
  if (ARoot = nil) then Exit;

  // Tenta interpretar nosso XPath "simplificado" baseado em local-name()
  names := ParseLocalNamePath(AXPath);
  if Length(names) > 0 then
  begin
    // Procura a partir do DocumentElement para cobrir '//*'
    if Assigned(ARoot.OwnerDocument) and Assigned(ARoot.OwnerDocument.DocumentElement) then
         rootUse := ARoot.OwnerDocument.DocumentElement
    else rootUse := ARoot;
    Result := FindFirstByPathLocalName(rootUse, names);
    Exit;
  end;

  // Fallback muito simples: tenta achar nó direto por nome (sem namespace)
  if Assigned(ARoot.OwnerDocument) and Assigned(ARoot.OwnerDocument.DocumentElement) then
  begin
    if SameText(AXPath, 'protNFe') then
         Result := FindFirstByPathLocalName(ARoot.OwnerDocument.DocumentElement, ['protNFe'])
    else Result := nil;
  end;
end;

function _GetText(const ARoot: IXMLNode; const AXPath: string): string;
var
  N: IXMLNode;
begin
  Result := '';
  N := _SelectNode(ARoot, AXPath);
  if Assigned(N) then
    Result := Trim(N.Text);
end;

function DetectaModeloPorIDE(const ARoot: IXMLNode): TModeloDoc;
var
  S: string;
begin
  S := _GetText(ARoot, XPATH_MOD);
  if S = '55' then Exit(mdNFe55);
  if S = '65' then Exit(mdNFCe65);
  Result := mdDesconhecido;
end;

function DetectaModeloPorChave(const ACh: string): TModeloDoc;
// Posição 21-22 da chave define o modelo (considerando 44 dígitos)
var
  Sub: string;
begin
  Result := mdDesconhecido;
  if Length(ACh) >= 22 then
  begin
    Sub := Copy(ACh, 21, 2);
    if Sub = '55' then Exit(mdNFe55);
    if Sub = '65' then Exit(mdNFCe65);
  end;
end;

procedure ExtraiBasicosRetorno(const ARoot: IXMLNode; var ARet: TRetornoNFe);
var
  ch: string;
begin
  // tenta cStat/xMotivo gerais (retEnviNFe/retConsReciNFe/retConsSitNFe)
  if ARet.cStat = '' then
    ARet.cStat := _GetText(ARoot, XPATH_CSTAT);
  if ARet.xMotivo = '' then
    ARet.xMotivo := _GetText(ARoot, XPATH_XMOTIVO);

  // tenta em protNFe/infProt
  if ARet.chNFe = '' then
    ARet.chNFe := _GetText(ARoot, XPATH_CHNFE);
  if ARet.nProt = '' then
    ARet.nProt := _GetText(ARoot, XPATH_NPROT);
  if ARet.dhRecbto = '' then
    ARet.dhRecbto := _GetText(ARoot, XPATH_DHRECBTO);

  // tenta em retEvento
  if (ARet.cStat = '') then
    ARet.cStat := _GetText(ARoot, XPATH_CSTAT_EVT);
  if (ARet.xMotivo = '') then
    ARet.xMotivo := _GetText(ARoot, XPATH_XMOTIVO_EVT);

  // se ainda não detectou modelo, tenta por ide/mod
  if (ARet.Modelo = mdDesconhecido) then
    ARet.Modelo := DetectaModeloPorIDE(ARoot);

  // fallback por chave (pos 21-22)
  if (ARet.Modelo = mdDesconhecido) then
  begin
    ch := ARet.chNFe;
    if ch <> '' then
      ARet.Modelo := DetectaModeloPorChave(ch);
  end;
end;

function _ParseDocument(const ADoc: IXMLDocument; out ARet: TRetornoNFe): Boolean;
var
  Root: IXMLNode;
begin
  Result := False;
  FillChar(ARet, SizeOf(ARet), 0);
  ARet.Modelo := mdDesconhecido;

  if not Assigned(ADoc) or not Assigned(ADoc.DocumentElement) then Exit;
  Root := ADoc.DocumentElement;

  // extrai campos fundamentais
  ExtraiBasicosRetorno(Root, ARet);

  // sucesso se pegamos pelo menos cStat ou chNFe/protocolo
  Result := (ARet.cStat <> '') or (ARet.chNFe <> '') or (ARet.nProt <> '');
end;

function ParseRetornoXML(const AXML: string; out ARet: TRetornoNFe): Boolean;
var
  Doc: IXMLDocument;
begin
  Doc := NewXMLDocument;
  Doc.Options := [doNodeAutoIndent];
  Doc.LoadFromXML(AXML);
  Result := _ParseDocument(Doc, ARet);
end;

function ParseRetornoXML(const AStream: TStream; out ARet: TRetornoNFe): Boolean;
var
  Doc: IXMLDocument;
begin
  Doc := NewXMLDocument;
  Doc.Options := [doNodeAutoIndent];
  Doc.LoadFromStream(AStream);
  Result := _ParseDocument(Doc, ARet);
end;

// Remove zeros à esquerda, mas mantém pelo menos um dígito (ex.: "0000" -> "0")
function StripLeftZeros(const S:String):String;
begin
   Result := TRegEx.Replace(S, '^0+(?!$)', '');
end;

function EnviarNFSincrono(const recSpdNFe:TspdNFe; const NumLote, XmlAssinado:String): TRetornoNFe;
var
   RetStr,axNrNota:String;
   Doc:IXMLDocument;
   Root,Prot,InfProt: IXMLNode;
   CStat,XMotivo,Ch,ProtNum,dhRecbto:String;
begin
   Result := Default(TRetornoNFe);
   try
      RetStr := recSpdNFe.EnviarNFSincrono(NumLote, XmlAssinado, False);
      Result.XmlBruto := RetStr;

      // Carregar XML
      Doc := TXMLDocument.Create(nil);
      Doc.Options := [doNodeAutoIndent];
      Doc.LoadFromXML(RetStr);
      Doc.Active := True;

      Root := Doc.DocumentElement;

      // cStat do retEnviNFe (nível do lote/processamento)
      CStat   := Root.ChildValues['cStat'];
      XMotivo := Root.ChildValues['xMotivo'];

      // Quando síncrono, geralmente cStat=104 (Lote processado). A decisão final vem no infProt (protNFe/infProt)
      Prot := Root.ChildNodes.FindNode('protNFe');
      if Assigned(Prot) then InfProt := Prot.ChildNodes.FindNode('infProt');

      if Assigned(InfProt) then
      begin
         CStat    := VarToStr(InfProt.ChildValues['cStat']);
         XMotivo  := VarToStr(InfProt.ChildValues['xMotivo']);
         Ch       := VarToStr(InfProt.ChildValues['chNFe']);
         ProtNum  := VarToStr(InfProt.ChildValues['nProt']);
         dhRecbto := VarToStr(InfProt.ChildValues['dhRecbto']);
         axNrNota := StripLeftZeros(Copy(Ch,26,9));
      end
      else axNrNota := '';

      Result.CStat    := CStat;
      Result.XMotivo  := XMotivo;
      Result.ChNFe    := Ch;
      Result.NrNota   := axNrNota;
      Result.NProt    := ProtNum;
      Result.dhRecbto := dhRecbto;

      if CStat = '100' then
      begin
         Result.Sucesso := True; // Autorizado
         Exit;
      end;
      if MatchStr(cStat,['108','109']) then
      begin
         Result.Indisponivel := True;   // Serviço paralisado momentâneo / sem previsão
         Exit;
      end;
      // Outros cStat ? 100 ?Rejeição / Denegação / Erro catalogado
      Result.Sucesso := False;
   except
      on E:Exception do
      begin
        // Se a camada HTTP/transport falhar, o será retornada exceção, tratada como indisponibilidade sem XML válido.
        SalvaLog(USUARIO, PastaLog, 'ERRO enviar dados NFCe pela função EnviarNFeSincrono (uNFRetorno) -> '+E.Message);
        Result.Indisponivel := True;
        Result.XMotivo := 'Falha transporte/HTTP: '+E.Message;
        Result.CStat   := '';
      end;
   end;
end;

end.

