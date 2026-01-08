unit uNFCCancela;

interface

uses
  Xml.XMLIntf, Xml.XMLDoc, System.SysUtils, System.Variants, System.StrUtils,
  uDM, uConst, spdNFCe, uGeraNFCe;

type
  // Classificação do Resultado do Cancelamento
  TCancelOutcome = (
    coHomologado,           // 135
    coHomologadoForaPrazo,  // 155
    coJaCancelada,          // 420
    coNaoEncontrada,        // 217
    coForaPrazo,            // 501 / 220
    coIndisponivel,         // 108 / 109
    coRejeicao,             // Outros códigos de rejeição
    coErroTransporte,       // Sem XML válido / exceção / HTML / SOAP Fault
    coDesconhecido          // Não enquadrou
  );

  TNFCeCancelResult = record
    Outcome     : TCancelOutcome;
    CStat       : string;
    XMotivo     : string;
    ChNFe       : string;
    NProt       : string;
    DhRegEvento : string;
    TpAmb       : string;
    COrgao      : string;
    VerAplic    : string;
    RawXml      : string; // XML de retorno (log)
    function Authorized: Boolean;
    function IsRejected: Boolean;
  end;

  function NFCeCancelar(const Chave,Justificativa,Protocolo: string; const NSeqEvento: Integer):TNFCeCancelResult;
  function NFCe_ParseCancelReturn(const RetXml: string): TNFCeCancelResult;

implementation

var
  locServer:TDMServer;

// --------- Helpers de XML (tolerantes a namespace) ----------- //
function LocalNameOf(const Node: IXMLNode): string;
var
   S:String;
   P:Integer;
begin
   if not Assigned(Node) then Exit('');
   S := Node.NodeName;
   P := S.LastDelimiter(':');
   if P > 0 then
        Result := Copy(S, P + 1, MaxInt)
   else Result := S;
end;

function FindChildByLocalName(const Parent: IXMLNode; const AName: string): IXMLNode;
begin
   Result := nil;
   if not Assigned(Parent) then Exit;
   for var I := 0 to Parent.ChildNodes.Count - 1 do
      if SameText(LocalNameOf(Parent.ChildNodes[I]), AName) then Exit(Parent.ChildNodes[I]);
end;

function GetChildText(const Parent: IXMLNode; const AName: string): string;
var
   N: IXMLNode;
begin
   Result := '';
   N := FindChildByLocalName(Parent, AName);
   if Assigned(N) then Result := N.Text;
end;

// ----------- Classificação por cStat ----------- //
function ClassifyByCStat(const CStat:String):TCancelOutcome;
begin
   if (CStat = '135') then Exit(coHomologado);
   if (CStat = '155') then Exit(coHomologadoForaPrazo);
   if (CStat = '420') then Exit(coJaCancelada);
   if (CStat = '217') then Exit(coNaoEncontrada);
   if (CStat = '501') or (CStat = '220') then Exit(coForaPrazo);
   if (CStat = '108') or (CStat = '109') then Exit(coIndisponivel);
   if (CStat <> '') and (CStat[1] in ['2','3','4','5','6','9']) then Exit(coRejeicao);
  Result := coDesconhecido;
end;

// ---------- Parser Pulico --------- //
function NFCe_ParseCancelReturn(const RetXml: string): TNFCeCancelResult;
var
   Doc: IXMLDocument;
   Root, RetEvento, InfEvento: IXMLNode;
   CStat, XMotivo, Ch, ProtNum, Dh, TpAmb, COrgao, VerAplic: string;
begin
   Result := Default(TNFCeCancelResult);
   Result.RawXml := RetXml;
   if RetXml.Trim = '' then
   begin
      Result.Outcome := coErroTransporte;
      Result.XMotivo := 'Retorno vazio (sem XML).';
      Exit;
   end;
   try
      Doc := TXMLDocument.Create(nil);
      Doc.Options := [doNodeAutoIndent];
      Doc.LoadFromXML(RetXml);
      Doc.Active := True;

      Root := Doc.DocumentElement;
      if not Assigned(Root) or not SameText(LocalNameOf(Root), 'retEnvEvento') then
      begin
         Result.Outcome := coErroTransporte;
         Result.XMotivo := 'XML inesperado (esperado retEnvEvento).';
         Exit;
      end; //if

      TpAmb    := GetChildText(Root, 'tpAmb');
      VerAplic := GetChildText(Root, 'verAplic');
      COrgao   := GetChildText(Root, 'cOrgao');

      RetEvento := FindChildByLocalName(Root, 'retEvento');
      if Assigned(RetEvento) then InfEvento := FindChildByLocalName(RetEvento, 'infEvento');

      if Assigned(InfEvento) then
      begin
         CStat   := GetChildText(InfEvento, 'cStat');
         XMotivo := GetChildText(InfEvento, 'xMotivo');
         Ch      := GetChildText(InfEvento, 'chNFe');
         ProtNum := GetChildText(InfEvento, 'nProt');
         Dh      := GetChildText(InfEvento, 'dhRegEvento');
         Result.CStat       := CStat;
         Result.XMotivo     := XMotivo;
         Result.ChNFe       := Ch;
         Result.NProt       := ProtNum;
         Result.DhRegEvento := Dh;
         Result.TpAmb       := TpAmb;
         Result.COrgao      := COrgao;
         Result.VerAplic    := VerAplic;
         Result.Outcome := ClassifyByCStat(CStat);
         Exit;
      end; //if

      // fallback: tentar cStat/xMotivo no nível do lote
      CStat   := GetChildText(Root, 'cStat');
      XMotivo := GetChildText(Root, 'xMotivo');

      Result.CStat    := CStat;
      Result.XMotivo  := XMotivo;
      Result.TpAmb    := TpAmb;
      Result.COrgao   := COrgao;
      Result.VerAplic := VerAplic;

     if (CStat = '128') then Result.Outcome := coDesconhecido else
     if (CStat = '108') or (CStat = '109') then Result.Outcome := coIndisponivel
     else Result.Outcome := ClassifyByCStat(CStat);
   except
      on E: Exception do
      begin
         Result.Outcome := coErroTransporte;
         Result.XMotivo := 'Falha ao interpretar XML: '+E.Message;
      end;
   end; //try
end;

// -------- Chamador Evento CancelarNF da TecnoSpeed -------- //
function NFCeCancelar(const Chave,Justificativa,Protocolo: string; const NSeqEvento: Integer):TNFCeCancelResult;
var
   RetXml:String;
   DataHoje:TDateTime;
begin
   Result := Default(TNFCeCancelResult);
   try
      DataHoje := Now;
      RetXml   := locServer.spdNFCe.CancelarNF(Chave, Protocolo.Trim, Justificativa.Trim, FormatDateTime('YYYY-mm-dd"T"HH:mm:ss',DataHoje),1,'-03:00');
   except
      on E:Exception do
      begin
         Result.Outcome := coErroTransporte;
         Result.XMotivo := 'Falha ao invocar CancelarNFe/EnviarEvento: '+E.Message+' -> '+E.Message;
         Exit;
      end;
   end; //try
   Result := NFCe_ParseCancelReturn(RetXml);
end;

// ---------- Helpers do Record ---------- //
function TNFCeCancelResult.Authorized: Boolean;
begin
   Result := (Outcome = coHomologado) or (Outcome = coHomologadoForaPrazo);
end;

function TNFCeCancelResult.IsRejected: Boolean;
begin
   Result := (Outcome in [coRejeicao, coJaCancelada, coNaoEncontrada, coForaPrazo, coDesconhecido]);
end;

end.

(* --------- COMO USAR --------- */
uses uNFCeCancelService;

procedure TFrm.CancelarNFCE(const AChave, AJust: string; const Seq: Integer);
var
  R: TNFCeCancelResult;
begin
  R := NFCe_Cancelar(spdNFCe, AChave, AJust, Seq);

  if R.Authorized then
  begin
    // sucesso: gravar NProt/DhRegEvento, marcar cancelada, arquivar procEventoNFe se quiser
    ShowMessage('Cancelado: ' + R.XMotivo + sLineBreak + 'Protocolo: ' + R.NProt);
  end
  else if R.Outcome = coIndisponivel then
  begin
    // SEFAZ fora do ar (108/109) ou indisponibilidade na camada
    ShowMessage('Serviço indisponível: ' + R.XMotivo);
    // retry/backoff ou reagendar
  end
  else if R.Outcome = coErroTransporte then
  begin
    ShowMessage('Erro de transporte/retorno: ' + R.XMotivo);
  end
  else
  begin
    // Rejeições / já cancelada / fora do prazo / não encontrada...
    ShowMessage(Format('Cancelamento rejeitado (%s): %s', [R.CStat, R.XMotivo]));
  end;
end;

*)

