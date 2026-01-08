unit uLibServer;

interface

uses
   Windows, Messages, MarcLib, Vcl.Forms, Classes, Controls, Dialogs, ExtCtrls,
   DateUtils, System.SysUtils, Variants, Vcl.StdCtrls, Data.DB, System.Types,
   ACBrNFe, uGeraNFCe, uGeraNFe, spdNFeDataSets, Xml.XMLDoc, Xml.XMLIntf, uConst,
   FireDAC.Comp.Client, uDM;

   procedure ConsutaNF(recChave:String; recModelo:Integer);
   function  CodigoUF(recUF:String):String;
   function  SalvarNF(rec:TNFSalvar; recFilial:String; IN_CONT:Boolean = False):Boolean;
   function  PrnDANFE(ChaveRec,recModelo,recSitu:String; Prever:Boolean):String;
   function  CancelaNF(ChaveRec,NroProRec,JustRec,Modelo,Serie,recAno:String; NroInuIni:Integer = 0; NroInuFim:Integer = 0):String;

implementation

// -------- Salvar Dados Gerados pela NF (55 / 65) na sua Tabela Base -------- //
function SalvarNF(rec:TNFSalvar; recFilial:String; IN_CONT:Boolean = False):Boolean;
var
   QueAuxi:TFDQuery;
   locServer:TDMServer;
begin
   Result := False;
   locServer := TDMServer.Create(nil);
   QueAuxi   := TFDQuery.Create(nil);
   QueAuxi.Connection := locServer.FDConnect;
   try
      try
         with QueAuxi do
         begin
            SQL.Text := 'UPDATE '+rec.Tabela+' SET Contigencia = '+iif(IN_CONT,'True','False');
            if rec.CodRet.Trim <> '' then SQL.Add(', ResulNF = '+Aspas(rec.CodRet));
            if rec.NroPro.Trim <> '' then SQL.Add(', ProtoNF = '+Aspas(rec.NroPro));
            if rec.IDCFOP.Trim <> '' then SQL.Add(', IDCFOP = ' +rec.IDCFOP);
            if rec.NroNF.Trim  <> '' then SQL.Add(', NroNF = '  +rec.NroNF);
            if rec.Chave.Trim  <> '' then SQL.Add(', ChaveNF = '+Aspas(rec.Chave));
            if rec.Status.Trim <> '' then SQL.Add(', Status = ' +Aspas(rec.Status));
            if rec.DatEmi.Trim <> '' then SQL.Add(', EmiNF = '  +Aspas(Copy(rec.DatEmi,1,10)+' '+Copy(rec.DatEmi,12,8)));
            if rec.Modelo.Trim <> '' then SQL.Add(', ModNF = '  +Aspas(rec.Modelo));
            SQL.Add(' WHERE IDFilial = '+recFilial+' AND '+rec.CmpKey+' = '+rec.CmpDad);
            ExecSQL;
            Result := True;
         end; //with
      except
         on E:Exception do
         begin
            SalvaLog(USUARIO, PastaLog, '[ERRO]  Salvando dados da NF no '+rec.Tabela+' (uLibFarm) -> '+E.Message);
            Exit;
         end;
      end;
   finally
      FreeAndNil(QueAuxi);
      locServer.FDConnect.Close;
      locServer.Free;
   end;
end;

// ---------- Retorna o Código Fiscal de Cadas Estado (UF) ---------- //
function CodigoUF(recUF:String):String;
begin
   if recUF = 'AC' then Result := '12' else
   if recUF = 'AL' then Result := '27' else
   if recUF = 'AP' then Result := '16' else
   if recUF = 'AM' then Result := '13' else
   if recUF = 'BA' then Result := '29' else
   if recUF = 'CE' then Result := '23' else
   if recUF = 'DF' then Result := '53' else
   if recUF = 'ES' then Result := '32' else
   if recUF = 'GO' then Result := '52' else
   if recUF = 'MA' then Result := '21' else
   if recUF = 'MT' then Result := '51' else
   if recUF = 'MS' then Result := '50' else
   if recUF = 'MG' then Result := '31' else
   if recUF = 'PA' then Result := '15' else
   if recUF = 'PB' then Result := '25' else
   if recUF = 'PR' then Result := '41' else
   if recUF = 'PE' then Result := '26' else
   if recUF = 'PI' then Result := '22' else
   if recUF = 'RJ' then Result := '33' else
   if recUF = 'RN' then Result := '24' else
   if recUF = 'RS' then Result := '43' else
   if recUF = 'RO' then Result := '11' else
   if recUF = 'RR' then Result := '14' else
   if recUF = 'SC' then Result := '42' else
   if recUF = 'SP' then Result := '35' else
   if recUF = 'SE' then Result := '28' else
   if recUF = 'TO' then Result := '17';
end;

// ----------- Consulta Situação de NF no SEFAZ ----------- //
procedure ConsutaNF(recChave:String; recModelo:Integer);
var
   mmXml:String;
begin
   {if recModelo = 55 then
   begin
      ConfAmbienteNF;
      mmXml := locServer.spdNFe.ConsultarNF(recChave);
   end else
   begin
      ConfAmbienteNFC;
      mmXml := locServer.spdNFCe.ConsultarNF(recChave);
   end; //if
   var arq: TextFile;
   AssignFile(arq, '.\NFC_Teste_Consulta.xml');
   Rewrite(arq);
   Writeln(arq, mmXml);
   CloseFile(arq); }
end;

function RemoveCaracterEsp40(texto:String):String;
begin
   texto := StringReplace(texto,'Ã§', 'ç', [rfReplaceAll]);
   texto := StringReplace(texto,'Ã£', 'ã', [rfReplaceAll]);
   texto := StringReplace(texto,'Ãº', 'ú', [rfReplaceAll]);
   texto := StringReplace(texto,'Ã¡', 'á', [rfReplaceAll]);
   Result := Texto;
end;

function GetFusoUF(const UFrec:String):String;
begin
    if UFrec = 'MG' then Result := '-03:00' else
    if UFrec = 'AC' then Result := '-04:00' else
    if UFrec = 'AL' then Result := '-03:00' else
    if UFrec = 'AM' then Result := '-04:00' else
    if UFrec = 'AP' then Result := '-03:00' else
    if UFrec = 'BA' then Result := '-03:00' else
    if UFrec = 'CE' then Result := '-03:00' else
    if UFrec = 'DF' then Result := '-03:00' else
    if UFrec = 'ES' then Result := '-03:00' else
    if UFrec = 'GO' then Result := '-03:00' else
    if UFrec = 'MA' then Result := '-03:00' else
    if UFrec = 'MS' then Result := '-04:00' else
    if UFrec = 'MT' then Result := '-04:00' else
    if UFrec = 'PA' then Result := '-03:00' else
    if UFrec = 'PB' then Result := '-03:00' else
    if UFrec = 'PE' then Result := '-03:00' else
    if UFrec = 'PI' then Result := '-03:00' else
    if UFrec = 'PR' then Result := '-03:00' else
    if UFrec = 'RJ' then Result := '-03:00' else
    if UFrec = 'RN' then Result := '-03:00' else
    if UFrec = 'RO' then Result := '-04:00' else
    if UFrec = 'RR' then Result := '-04:00' else
    if UFrec = 'RS' then Result := '-02:00' else
    if UFrec = 'SC' then Result := '-03:00' else
    if UFrec = 'SE' then Result := '-03:00' else
    if UFrec = 'SP' then Result := '-03:00' else
    if UFrec = 'TO' then Result := '-03:00';
end;

// ------------ Carrega XML ----------- //
function CarregarXML(Arquivo:String):String;
var
   Arq:TextFile;
   Linha:String;
   Texto:TStrings;
begin
   Result := '';
   if not FileExists(Arquivo) then
   begin
      Result := 'ERRO';
      Exit;
   end;
   Texto := TStringList.Create;
   Texto.LoadFromFile(Arquivo);
   Result := RemoveCaracterEsp40(Texto.Text);
   Texto.Free;
end;

// ----------- Imprime DANFE Notas Fiscais -------- //
function PrnDANFE(ChaveRec,recModelo,recSitu:String; Prever:Boolean):String;
var
   Arquivo:String;
   xmlNF:WideString;
   locServer:TDMServer;
begin
   Result := '';
   xmlNF  := '';
   locServer := TDMServer.Create(nil);
   try
      if recModelo = '55' then
      begin
         ConfAmbienteNF(locServer.spdNFe_base);
         Arquivo := locServer.spdNFe_base.DiretorioXmlDestinatario;
      end else
      begin
         ConfAmbienteNFC(locServer.spdNFCe);
         Arquivo := locServer.spdNFCe.DiretorioXmlDestinatario;
      end; //if

      if recSitu = 'C' then
      begin
         Arquivo := Arquivo + ChaveRec + '-caneve.xml';
         if not FileExists(Arquivo) then
         begin
            SalvaLog(USUARIO, PastaLog,'[ERRO] Impressão NF dengada, Arquivo XML cancelamento não foi encontrado - Chave: '+ChaveRec);
            Result := 'Arquivo XML da denegação da NF não foi encontrado.';
            Exit;
         end;
      end else
      if recSitu = 'D' then
      begin
         Arquivo := Arquivo + ChaveRec + '-den.xml';
         if not FileExists(Arquivo) then
         begin
            SalvaLog(USUARIO, PastaLog,'[ERRO] Impressão NF cancelada, Arquivo XML cancelamento não foi encontrado - Chave: '+ChaveRec);
            Result := 'Arquivo XML de cancelamento não foi encontrado.';
            Exit;
         end;
      end else
      begin
         Arquivo := Arquivo + ChaveRec + iIf(recModelo = '55','-nfe','-nfce')+'.xml';
         if not FileExists(Arquivo) then
         begin
            SalvaLog(USUARIO, PastaLog,'[ERRO] Impressão NF, Arquivo XML não foi encontrado - Chave: '+ChaveRec);
            Result := 'Arquivo XML da NF não foi encontrado.';
            Exit;
         end; //if
      end; //if

      xmlNF := CarregarXML(Arquivo);
      if xmlNF = 'ERRO' then
      begin
         Result := 'XML da NF-e não foi encontrado!';
         Exit;
      end;

      if recModelo = '55' then
      begin
         if not Prever then
              locServer.spdNFe_base.ImprimirDanfe  ('00001', xmlNF,'',PRINTERNF)
         else locServer.spdNFe_base.VisualizarDanfe('00001', xmlNF,'');
      end else
      begin
         if not Prever then
              locServer.spdNFCe.ImprimirDanfce  ('00001', xmlNF,'',PRINTERNF)
         else locServer.spdNFCe.VisualizarDanfce('00001', xmlNF,'');
      end; //if
   finally
      locServer.Free;
      DeleteFile(PWideChar(Arquivo));
   end;
end;

function ExtractTags(const AXML: string; out cStat: Integer; out xMotivo, nProt, dhRegEvento: string): Boolean;
  function FirstTextByLocalName(const Root: IXMLNode; const ALocal: string): string;
    // Busca em profundidade pela 1ª tag cujo LocalName (ou NodeName) case com ALocal
    function Recurse(N: IXMLNode): string;
    var
      i: Integer;
      R,LName: string;
    begin
      Result := '';
      if N = nil then Exit;
      LName := N.LocalName;
      if LName = '' then LName := N.NodeName; // fallback
      if SameText(LName, ALocal) then Exit(N.Text);

      if N.HasChildNodes then
        for i := 0 to N.ChildNodes.Count - 1 do
        begin
          R := Recurse(N.ChildNodes[i]);
          if R <> '' then Exit(R);
        end;
    end;
  begin
    Result := '';
    if (Root <> nil) then Result := Recurse(Root);
  end;

var
   Doc: IXMLDocument;
   sCStat: string;
begin
   Result := False;
   cStat   := 0;
   xMotivo := '';
   nProt   := '';
   dhRegEvento := '';

   Doc := TXMLDocument.Create(nil);
   Doc.Options := [doNodeAutoIndent];
   Doc.ParseOptions := [poResolveExternals];
   Doc.Active := False;
   Doc.LoadFromXML(AXML);
   Doc.Active := True;

   if Doc.DocumentElement = nil then Exit;

   sCStat      := FirstTextByLocalName(Doc.DocumentElement, 'cStat');
   xMotivo     := FirstTextByLocalName(Doc.DocumentElement, 'xMotivo');
   nProt       := FirstTextByLocalName(Doc.DocumentElement, 'nProt');
   dhRegEvento := FirstTextByLocalName(Doc.DocumentElement, 'dhRegEvento');
   Result      := TryStrToInt(sCStat, cStat) and (xMotivo <> '');
end;

// ---------- Cancelamento ou Inutilização de Numeração de NF ---------- //
function CancelaNF(ChaveRec,NroProRec,JustRec,Modelo,Serie,recAno:String; NroInuIni:Integer = 0; NroInuFim:Integer = 0):String;
var
   OK:Boolean;
   cStat:Integer;
   locServer:TDMServer;
   aXML,xMotivo,tipOpe:String;
   xm,nProt,dhReg:String;
begin
   Result := '';
   tipOpe := iif(NroInuIni <= 0,'C','I');
   locServer := TDMServer.Create(nil);
   try
      if Modelo = '55' then
      begin
         ConfAmbienteNF(locServer.spdNFe_base);
         if tipOpe = 'I' then
              aXML := RemoveCaracterEsp40(locServer.spdNFe_base.InutilizarNF('', recAno, EMPRESA.CNPJ, Modelo, Serie, NroInuIni.ToString, iif(NroInuFim > 0, NroInuFim.ToString, NroInuIni.ToString), JustRec))
         else aXML := RemoveCaracterEsp40(locServer.spdNFe_base.CancelarNFeEvento(ChaveRec, NroProRec, JustRec, FormatDateTime('YYYY-MM-DD"T"HH:MM:SS',Now),1,GetFusoUF(EMPRESA.UF)));
      end else
      begin
         ConfAmbienteNFC(locServer.spdNFCe);
         if tipOpe = 'I' then
              aXML := RemoveCaracterEsp40(locServer.spdNFCe.InutilizarNF('', recAno, EMPRESA.CNPJ, Modelo, Serie, NroInuIni.ToString, iif(NroInuFim > 0, NroInuFim.ToString, NroInuIni.ToString), JustRec))
         else aXML := RemoveCaracterEsp40(locServer.spdNFCe.CancelarNF(ChaveRec, NroProRec, JustRec, FormatDateTime('YYYY-MM-DD"T"HH:MM:SS',Now),1,GetFusoUF(EMPRESA.UF)));
      end;

      ExtractTags(aXML, cStat, xMotivo, nProt, dhReg);
      OK := cStat = 135;

      if not OK then
      begin
         if tipOpe = 'I' then
         begin
            SalvaLog(USUARIO, PastaLog,'[ERRO] Não foi possível inutilizar NF: '+ChaveRec+' Motivo: '+xMotivo);
            Result := 'Não foi possível inutilizar NF. Motivo: '+xMotivo;
         end else
         begin
            SalvaLog(USUARIO, PastaLog,'[ERRO] Não foi possível cancelar NF C/ Chave: '+ChaveRec+' Motivo: '+xMotivo);
            Result := 'Não foi possível cancelar NF. Motivo: '+xMotivo;
         end;
      end;
   finally
      locServer.Free;
   end;
end;

end.

