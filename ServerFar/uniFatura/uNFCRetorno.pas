unit uNFCRetorno;

interface

uses
  Xml.XMLIntf, Xml.XMLDoc, System.SysUtils, System.Variants,
  System.StrUtils, uDM, uConst, spdNFCe, MarcLib, System.RegularExpressions;

type
  TNFCeResultado = record
     Sucesso: Boolean;       // true se autorizado (cStat=100 no infProt)
     Indisponivel: Boolean;  // true se 108/109 ou sem resposta
     CStat: string;
     XMotivo: string;
     ChNFe: string;
     NrNota: string;
     NProt: string;
     dhRecbto: string;
     XmlBruto: string;       // XML completo de retorno (log)
  end;

  function EnviarNFCeSincrono(recSpdNFCe:TspdNFCe; const NumLote, XmlAssinado:String): TNFCeResultado;

implementation

// Remove zeros à esquerda, mas mantém pelo menos um dígito (ex.: "0000" -> "0")
function StripLeftZeros(const S:String):String;
begin
   Result := TRegEx.Replace(S, '^0+(?!$)', '');
end;

function EnviarNFCeSincrono(recSpdNFCe:TspdNFCe; const NumLote, XmlAssinado:String): TNFCeResultado;
var
   RetStr,axNrNota:String;
   Doc:IXMLDocument;
   locServer:TDMServer;
   Root,Prot,InfProt: IXMLNode;
   CStat,XMotivo,Ch,ProtNum,dhRecbto:String;
begin
   Result := Default(TNFCeResultado);
   locServer := TDMServer.Create(nil);
   try
      try
         RetStr := recSpdNFCe.EnviarNFSincrono(NumLote, XmlAssinado, False);
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
           SalvaLog(USUARIO, PastaLog, '[ERRO] Enviado dados NFCe pela função EnviarNFCeSincrono (uNFCRetorno) -> '+E.Message);
           Result.Indisponivel := True;
           Result.XMotivo := 'Falha transporte/HTTP: '+E.Message;
           Result.CStat   := '';
         end;
      end;
   finally
      locServer.Free;
   end;
end;

end.
