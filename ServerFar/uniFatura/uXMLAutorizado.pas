unit uXMLAutorizado;

interface

uses System.SysUtils, System.Variants;

  function MontarNFeAutorizada_XML(const XmlEnviOuNFe, XmlRet: string): string;
  function MontarNFeAutorizada_Arquivos(const ArqEnviOuNFe, ArqRet, ArqSaidaNFeProc: string): string;

implementation

uses System.Classes, System.IOUtils, Xml.XMLDoc, Xml.XMLIntf;

const
  NS_NFE = 'http://www.portalfiscal.inf.br/nfe';

// ------------------------ Helpers ------------------------ //
function RootLocalName(const Node: IXMLNode): string; inline;
begin
  if Node = nil then Exit('');
  if Node.LocalName <> '' then
       Result := Node.LocalName
  else Result := Node.NodeName;
end;

function FindChildLocal(const Parent: IXMLNode; const ALocalName: string): IXMLNode;
var
  i: Integer;
  LName: string;
begin
  Result := nil;
  if (Parent = nil) or (Parent.ChildNodes = nil) then Exit;
  for i := 0 to Parent.ChildNodes.Count - 1 do
  begin
    LName := Parent.ChildNodes[i].LocalName;
    if LName = '' then
      LName := Parent.ChildNodes[i].NodeName;
    if SameText(LName, ALocalName) then
      Exit(Parent.ChildNodes[i]);
  end;
end;

function GetAttr(const Node: IXMLNode; const AttrName: string): string; inline;
begin
  if (Node <> nil) and Node.HasAttribute(AttrName) then
    Result := VarToStr(Node.Attributes[AttrName])
  else
    Result := '';
end;

function ChildText(const Parent: IXMLNode; const ALocalName: string): string; inline;
var
  N: IXMLNode;
begin
  N := FindChildLocal(Parent, ALocalName);
  if N <> nil then
    Result := N.Text
  else
    Result := '';
end;

function ExtrairChaveDaInfNFeId(const InfNFe: IXMLNode): string;
var
  Id: string;
begin
  Id := GetAttr(InfNFe, 'Id');             // ex: "NFe3519..."
  if (Id <> '') and (Length(Id) > 3) and SameText(Copy(Id,1,3), 'NFe') then
       Result := Copy(Id, 4, MaxInt)       // remove prefixo "NFe"
  else Result := Id;
end;

// --------------------- Núcleo: montar o nfeProc ------------------------- //
function MontarNFeAutorizada_XML(const XmlEnviOuNFe, XmlRet: string): string;
var
  DocEnvi, DocRet: IXMLDocument;
  RootEnvi, RootRet: IXMLNode;
  NodeNFe, NodeInfNFe: IXMLNode;
  NodeProt, NodeInfProt: IXMLNode;
  VersaoNFe, VersaoProt, VersaoProc: string;
  ChEnvi, ChProt, cStat: string;
  Header: string;
begin
  // --- Carrega o XML do envio (pode ser <enviNFe> com <NFe> dentro OU <NFe> direto)
  DocEnvi := NewXMLDocument;
  DocEnvi.Options := [doNodeAutoIndent];
  DocEnvi.Encoding := 'UTF-8';
  DocEnvi.LoadFromXML(XmlEnviOuNFe);
  RootEnvi := DocEnvi.DocumentElement;
  if RootEnvi = nil then
    raise Exception.Create('XML de envio inválido: sem elemento raiz.');

  if SameText(RootLocalName(RootEnvi), 'enviNFe') then
    NodeNFe := FindChildLocal(RootEnvi, 'NFe')
  else if SameText(RootLocalName(RootEnvi), 'NFe') then
    NodeNFe := RootEnvi
  else
    raise Exception.CreateFmt('Raiz inesperada no XML de envio: %s', [RootEnvi.NodeName]);

  if NodeNFe = nil then
    raise Exception.Create('Tag <NFe> não encontrada no XML de envio.');

  NodeInfNFe := FindChildLocal(NodeNFe, 'infNFe');
  if NodeInfNFe = nil then
    raise Exception.Create('Tag <infNFe> não encontrada dentro de <NFe>.');

  VersaoNFe := GetAttr(NodeInfNFe, 'versao');
  ChEnvi    := ExtrairChaveDaInfNFeId(NodeInfNFe);

  // --- Carrega o XML de retorno (deve conter <protNFe> com cStat=100)
  DocRet := NewXMLDocument;
  DocRet.Options := [doNodeAutoIndent];
  DocRet.Encoding := 'UTF-8';
  DocRet.LoadFromXML(XmlRet);
  RootRet := DocRet.DocumentElement;
  if RootRet = nil then
    raise Exception.Create('XML de retorno inválido: sem elemento raiz.');

  NodeProt := FindChildLocal(RootRet, 'protNFe');
  if NodeProt = nil then
    raise Exception.Create('Tag <protNFe> não encontrada no XML de retorno.');

  NodeInfProt := FindChildLocal(NodeProt, 'infProt');
  if NodeInfProt = nil then
    raise Exception.Create('Tag <infProt> não encontrada dentro de <protNFe>.');

  cStat := ChildText(NodeInfProt, 'cStat');
  if cStat <> '100' then
    raise Exception.CreateFmt('NF-e não autorizada (cStat=%s).', [cStat]);

  ChProt := ChildText(NodeInfProt, 'chNFe');
  if (ChEnvi <> '') and (ChProt <> '') and (ChEnvi <> ChProt) then
    raise Exception.CreateFmt('Chave da NFe do envio (%s) difere da chave do protocolo (%s).', [ChEnvi, ChProt]);

  VersaoProt := GetAttr(NodeProt, 'versao');
  if VersaoProt <> '' then
    VersaoProc := VersaoProt
  else if VersaoNFe <> '' then
    VersaoProc := VersaoNFe
  else
    VersaoProc := '4.00';

  // --- Montagem final do nfeProc por concatenação (preserva a assinatura da NFe)
  Header := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Header + sLineBreak +
    Format('<nfeProc versao="%s" xmlns="%s">', [VersaoProc, NS_NFE]) + sLineBreak +
    NodeNFe.XML + sLineBreak + NodeProt.XML + sLineBreak + '</nfeProc>';
end;

function MontarNFeAutorizada_Arquivos(const ArqEnviOuNFe, ArqRet, ArqSaidaNFeProc: string): string;
var
  XmlEnvi, XmlRet, XmlProc: string;
begin
  XmlEnvi := TFile.ReadAllText(ArqEnviOuNFe, TEncoding.UTF8);
  XmlRet  := TFile.ReadAllText(ArqRet,       TEncoding.UTF8);
  XmlProc := MontarNFeAutorizada_XML(XmlEnvi, XmlRet);
  if ArqSaidaNFeProc <> '' then
     TFile.WriteAllText(ArqSaidaNFeProc, XmlProc, TEncoding.UTF8);
  Result := XmlProc;
end;

end.

