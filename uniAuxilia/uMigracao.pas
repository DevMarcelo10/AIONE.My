unit uMigracao;

interface

uses
   Windows, Messages, MarcLib, VCL.Dialogs, System.SysUtils,
   ACBrNFe, ACBrNFeNotasFiscais, System.Classes,
   System.StrUtils, System.Types, uRESTDWBasicDB;

   function AtuProdutoCMED:Boolean;
   function LerProdutosCSV(recPasta:String):Boolean;
   function LerProdutosCMED(recPasta:String):Boolean;
   function RemoveZerosDireita(const Value:String):String;
   function ProcessaString(const StrEntrada:String):String;
   function MigraNF(recPasta,recEntSai:String; recIDFIlial:Integer):Boolean;
   function FormatarStrReais(const valor:String; recFormSQL:Boolean):String;
   function GravaMacroIndices(recPIni,recPFin:TDate):Boolean;
   function GravaMeterologia(recLati,recLong:Double; recPIni,recPFin:TDate; recPrev:Boolean):Boolean;
   procedure GeraTestesIA;

implementation

uses uDM, uConst, uFatores, WeatherAPI;
//dcc32 Error] uMigracao.pas(60): E2010 Incompatible types: 'pcnNFe.TNFe' and 'ACBrNFe.Classes.TNFe'
// ------ Carrega arquivos XMLs NF-e e NFC-E de Compras/Vendas Para arqhistcomercio ------ //
function MigraNF(recPasta,recEntSai:String; recIDFIlial:Integer):Boolean;
var
   I,acReg:Integer;
   Busca:TSearchRec;
   ACBrNFe:TACBrNFe;
   QueIncl,QueIPro:TRESTDWClientSQL;
   Campos,CamPro,auxNroNot,auxDatEmi,auxCNPJCPF,auxNroLot,auxDatVen:String;
begin
   if FindFirst(recPasta+'\*.xml', faAnyFile, Busca) <> 0 then
   begin
      FindClose(Busca);
      Exit;
   end
   else FindClose(Busca);

   ACBrNFe := TACBrNFe.Create(nil);
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueIPro := TRESTDWClientSQL.Create(nil);
   Campos  := 'TipoHis,IDFilial,NroNFe,Datmov,CpfCnpj,IDProd,CodEAN,CodNCM,Nrolot,Datven,Qtdmov,PreVenda,VlrICM,VlrST,VlrPIS,VlrCOF,VlrIPI,VlrIImp';
   CamPro  := 'IDProd,Despro,CodNCM,CodCEST,PrecoVen,CodEANpri';
   try
      if FindFirst(recPasta+'\*.xml', faAnyFile, Busca) = 0 then
      begin
         acReg := 0;
         QueIPro.DataBase := DM.DWDataBase;
         QueIncl.DataBase := DM.DWDataBase;
         QueIPro.SQL.Text := 'INSERT INTO arqproduto ('+CamPro+') VALUES ';
         QueIncl.SQL.Text := 'INSERT INTO arqhistcomercio ('+Campos+') VALUES';
         try
            try
               repeat
                  ACBrNFe.NotasFiscais.Clear;
                  ACBrNFe.NotasFiscais.LoadFromFile(recPasta+'\'+Busca.Name);
                  with ACBrNFe.NotasFiscais.Items[0] do
                  begin
                     if IsNumeric(NFe.procNFe.chNFe) then
                     begin
                        auxNroNot  := NFe.Ide.nNF.ToString;
                        auxDatEmi  := FormatDateTime('yyyy-mm-dd hh:mm:ss',NFe.Ide.dEmi);
                        auxCNPJCPF := iif(recEntSai = 'S',NFe.Dest.CNPJCPF,NFe.Emit.CNPJCPF);
                        for I := 0 to NFe.Det.Count-1 do
                        begin
                           with NFe.Det.Items[I] do
                           begin
                              if Prod.Rastro.Count > 0 then
                              begin
                                 auxNroLot := Prod.Rastro[0].nLote;
                                 auxDatVen := Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',Prod.Rastro[0].dVal));
                              end else
                              begin
                                 auxNroLot := '';
                                 auxDatVen := 'null';
                              end;
                              QueIncl.SQL.Add('('+
                              Aspas(recEntSai)+','+
                              recIDFIlial.ToString+','+
                              auxNroNot+','+
                              Aspas(auxDatEmi)+','+
                              Aspas(auxCNPJCPF)+','+
                              Aspas(Prod.cProd)+','+
                              Aspas(Prod.cEAN)+','+
                              Aspas(Prod.NCM)+','+
                              Aspas(auxNroLot)+','+
                              auxDatVen+','+
                              FormatDouble(Prod.qCom,9,2)+','+
                              FormatDouble(RoundX((Prod.vProd + Imposto.ICMS.vICMSST - Prod.vDesc) / Prod.qCom,2),9,2)+','+
                              FormatDouble(Imposto.ICMS.vICMS,9,2)+','+
                              FormatDouble(Imposto.ICMS.vICMSST,9,2)+','+
                              FormatDouble(Imposto.PIS.vPIS,9,2)+','+
                              FormatDouble(Imposto.COFINS.vCOFINS,9,2)+','+
                              FormatDouble(Imposto.IPI.vIPI,9,2)+','+
                              FormatDouble(Imposto.II.vII,9,2)+'),');

                              QueIPro.SQL.Add('('+Prod.cProd+','+
                              Aspas(AnsiLeftStr(Prod.xProd,120))+','+
                              Aspas(AnsiLeftStr(Prod.NCM, 8))+','+
                              Aspas(AnsiLeftStr(Prod.CEST,7))+','+
                              FormatDouble(Prod.vProd,9,2)+','+
                              Aspas(Prod.cEAN)+'),');
                           end; //with
                        end; //with
                     end; //for
                     Inc(acReg);
                  end; //if

                  if acReg > 100 then
                  begin
                     acReg := 0;
                     QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+';';
                     QueIncl.ExecSQL;
                     QueIncl.SQL.Text := 'INSERT INTO arqhistcomercio ('+Campos+') VALUES ';

                     QueIPro.SQL.Text := Copy(QueIPro.SQL.Text,1,LastDelimiter(',',QueIPro.SQL.Text)-1)+' '+
                     'ON DUPLICATE KEY UPDATE CodEANpri = VALUES(CodEANpri)';
                     QueIPro.ExecSQL;
                     QueIPro.SQL.Text := 'INSERT INTO arqproduto ('+CamPro+') VALUES ';
                  end; //if
               until FindNext(Busca) <> 0;

               if acReg > 0 then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+';';
                  QueIncl.ExecSQL;

                  QueIPro.SQL.Text := Copy(QueIPro.SQL.Text,1,LastDelimiter(',',QueIPro.SQL.Text)-1)+' '+
                  'ON DUPLICATE KEY UPDATE Despro = VALUES(Despro), RegistoMS = VALUES(RegistoMS),'+
                  'CodEANpri = VALUES(CodEANpri), PrecoVen = VALUES(PrecoVen), Markup = VALUES(Markup), QtdFrac = VALUES(QtdFrac)';
                  QueIPro.ExecSQL;
               end;
            except
               on E:Exception do
               begin
                  SalvaLog('GESTAO',PastaLog,'ERRO: Processo migração NF, '+recEntSai+' -> '+E.Message+#10+QueIncl.SQL.Text+#10+QueIPro.SQL.Text);
                  ShowMessage('ERRO - Não foi p+ssível concluir!'+#10+E.Message);
               end;
            end;
         finally
            FindClose(Busca);
         end; //try
      end; //if
      //Path Exemplo: C:\Program Files (x86)\Embarcadero\AcBR\Exemplos\ACBrDFe\ACBrNFe\Delphi\Frm_ACBrNFe.pas
   finally
      ACBrNFe.Free;
      FreeAndNil(QueIncl);
      FreeAndNil(QueIPro);
      ShowMessage('Terminou!');
   end;
end;

{
Código      Produto	                        Laboratório	   Grupo	         Seção	         Lista	     Estoque    NCM	      Tributo	       CEST     Fração	  Preço Compra  Valor ST	Custo/PF	  Markup   Preço Venda	Pre.Cus.Méd. Pre.Máx.Cons.	 Código Barra	  Registro MS
206503;     ALEKTOS 2,5MG/ML XAROPE 120ML;   HYPERMARCAS;   REFERENCIA;    MEDICAMENTOS;  NEGATIVA;   2;        30049069;  SUBSTITUICAO;  1300401;    1;       51,80;      10,66;      62,28;     33,30;     83,02;         62,46;      0,00;       7896641815027;  1781709090011
   0         1                                  2               3             4             5         6              7          8            9        10        11            12         13         14         15           16           17             18             19
Despro,CodNCM,CodCEST,RegistoMS,PrecoVen,PrecoPMC,CustoMed,Markup,QtdFrac,ValorST,CodEANpri
   1      7      9       19        15       17       16    14     10      12       18
}
// ------------ Migra arquivo CSV para tabela arqproduto ------------ //
function LerProdutosCSV(recPasta:String):Boolean;
var
   I,acReg:Integer;
   Campos,Linha:String;
   Lista:TStringDynArray;
   ArquivoCSV:TextFile;
   QueIncl,QueAuxi:TRESTDWClientSQL;
begin
   Result  := False;
   if not FileExists(recPasta) then
   begin
      ShowMessage('Arquivo não encontrado.');
      Exit;
   end;

   QueIncl := TRESTDWClientSQL.Create(nil);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      AssignFile(ArquivoCSV, recPasta);
      Reset(ArquivoCSV);
      if IOResult <> 0 then Exit;

      QueIncl.SQL.Clear;
      QueIncl.DataBase := DM.DWDataBase;
      Campos := 'IDProd,Despro,CodNCM,CodCEST,RegistoMS,PrecoVen,PrecoPMC,CustoMed,Markup,QtdFrac,ValorST,CodEANpri';
      acReg  := 0;

      QueIncl.SQL.Text := 'TRUNCATE TABLE arqproduto;';
      QueIncl.SQL.Add('ALTER TABLE arqproduto AUTO_INCREMENT = 1;');
      QueIncl.ExecSQL;

      QueIncl.SQL.Text := 'INSERT INTO arqproduto ('+Campos+') VALUES ';
      try
         while not Eof(ArquivoCSV) do
         begin
            Readln(ArquivoCSV, Linha);
            Lista := SplitString(Linha,';');
            if Length(Lista) <> 20 then Continue;
            QueIncl.SQL.Add('('+Trim(Lista[0])+','+
            Aspas(AnsiLeftStr(Trim(Lista[1]),120))+','+
            Aspas(AnsiLeftStr(Trim(Lista[7]),  8))+','+
            Aspas(AnsiLeftStr(Trim(Lista[9]),  7))+','+
            Aspas(AnsiLeftStr(Trim(Lista[19]),13))+','+
            FormatarStrReais(Lista[15],False)+','+
            FormatarStrReais(Lista[17],False)+','+
            FormatarStrReais(Lista[16],False)+','+
            FormatarStrReais(Lista[14],False)+','+
            iif(Trim(Lista[10]) <> '',FormatarStrReais(Lista[10],False),'0')+','+
            FormatarStrReais(Lista[12],False)+','+
            Aspas(AnsiLeftStr(Trim(Lista[18]),14))+'),');
            Inc(acReg);
            if (acReg > 50) or Eof(ArquivoCSV) then
            begin
               QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
               QueIncl.SQL.Add('ON DUPLICATE KEY UPDATE Despro = VALUES(Despro), RegistoMS = VALUES(RegistoMS), '+
               'CodEANpri = VALUES(CodEANpri), PrecoVen = VALUES(PrecoVen), Markup = VALUES(Markup), QtdFrac = VALUES(QtdFrac)');
               QueIncl.ExecSQL;
               QueIncl.SQL.Text := 'INSERT INTO arqproduto ('+Campos+') VALUES ';
               acReg := 0;
            end; //if
         end; //while
      except
         on E:Exception do
         begin
            SalvaLog('MIGRA_PRODUTOS',PastaLog,#10+QueIncl.SQL.Text+#10+E.Message);
            raise;
         end;
      end;

      // ---------- Salva e Associa Codigos EAN arqprodutoean --------- //
      QueIncl.SQL.Clear;
      QueAuxi.DataBase := DM.DWDataBase;
      acReg := 0;
      QueAuxi.SQL.Text := 'SELECT IDProd,CodEANpri FROM arqproduto WHERE NOT ISNULL(CodEANpri) AND CodEANpri != '+Aspas('')+' ORDER BY IDProd';
      QueAuxi.Open;
      if not QueAuxi.IsEmpty then
      begin
         QueIncl.SQL.Text := 'INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ';
         try
            while not QueAuxi.Eof do
            begin
               QueIncl.SQL.Add('('+QueAuxi.FieldByName('IDProd').AsString+','+
               Aspas(QueAuxi.FieldByName('CodEANpri').AsString)+'),');
               Inc(acReg);
               QueAuxi.Next;
               if (acReg > 50) or QueAuxi.Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.SQL.Add('ON DUPLICATE KEY UPDATE IDProd = VALUES(IDProd)');
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ';
                  acReg := 0;
               end; //if
            end; //while
            Result := True;
         except
            SalvaLog('MIGRA_PRODUTOS',PastaLog,#10+QueIncl.SQL.Text);
            raise;
         end;
      end; //if
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueIncl);
      CloseFile(ArquivoCSV);
      ShowMessage('Terminou!');
   end;
end;

// -------- Atualiza arqcmed tabelas CMED e Produtos à Partir do CSV da CMED -------- //
function LerProdutosCMED(recPasta:String):Boolean;
var
   I,acI,acReg:Integer;
   ArquivoCSV:TextFile;
   Lista:TStringDynArray;
   LisSubs:TStringDynArray;
   QueIncl,QueAuxi,QueSubs:TRESTDWClientSQL;
   Campos,Linha,auxTipoPro,auxTipoLis,auxValores,auxDUP:String;
begin
   Result  := False;
   if not FileExists(recPasta) then
   begin
      ShowMessage('Arquivo não encontrado.');
      Exit;
   end;

   QueIncl := TRESTDWClientSQL.Create(nil);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueSubs := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueIncl.DataBase := DM.DWDataBase;
   QueSubs.DataBase := DM.DWDataBase;
   QueSubs.SQL.Clear;
   QueIncl.SQL.Clear;

   try
      AssignFile(ArquivoCSV, recPasta);
      Reset(ArquivoCSV);
      if IOResult <> 0 then Exit;

      Campos := 'CodEAN,CodEAN2,CodEAN3,DesSubs,CNPJlab,RegistoMS,Despro,Aprpro,TipoPro,TipoLista,RegPreco,IndICMS0,Tarja,PreFabSImp,'+
                'PreFab00,PreFab12,PreFabALC12,PreFab17,PreFabALC17,PreFab175,PreFabALC175,PreFab18,PreFabALC18,PreFab19,PreFabALC19,'+
                'PreFab20,PreFabALC20,PreFab21,PreFabALC21,PrePMCSImp,PrePMC00,PrePMC12,PrePMCALC12,PrePMC17,PrePMCALC17,PrePMC175,'+
                'PrePMCALC175,PrePMC18,PrePMCALC18,PrePMC19,PrePMCALC19,PrePMC20,PrePMCALC20,PrePMC21,PrePMCALC21,PrePMC22,PrePMCALC22';

      auxDUP := 'ON DUPLICATE KEY UPDATE CodEAN2 = VALUES(CodEAN2),CodEAN3 = VALUES(CodEAN3),DesSubs = VALUES(DesSubs),'+
                'CNPJlab = VALUES(CNPJlab),RegistoMS = VALUES(RegistoMS),Despro = VALUES(Despro),Aprpro = VALUES(Aprpro),'+
                'TipoPro = VALUES(TipoPro),TipoLista = VALUES(TipoLista),RegPreco = VALUES(RegPreco),IndICMS0 = VALUES(IndICMS0),Tarja = VALUES(Tarja),'+
                'PreFabSImp = VALUES(PreFabSImp),PreFab00 = VALUES(PreFab00),PreFab12 = VALUES(PreFab12),PreFabALC12 = VALUES(PreFabALC12),'+
                'PreFab17 = VALUES(PreFab17),PreFabALC17 = VALUES(PreFabALC17),PreFab175 = VALUES(PreFab175),PreFabALC175 = VALUES(PreFabALC175),'+
                'PreFab18 = VALUES( PreFab18),PreFabALC18 = VALUES(PreFabALC18),PreFab19 = VALUES( PreFab19),PreFabALC19 = VALUES(PreFabALC19),'+
                'PreFab20 = VALUES( PreFab20),PreFabALC20 = VALUES(PreFabALC20),PreFab21 = VALUES(PreFab21),PreFabALC21 = VALUES(PreFabALC21),'+
                'PrePMCSImp = VALUES(PrePMCSImp),PrePMC00 = VALUES(PrePMC00),PrePMC12 = VALUES(PrePMC12),PrePMCALC12 = VALUES(PrePMCALC12),'+
                'PrePMC17 = VALUES(PrePMC17),PrePMCALC17 = VALUES(PrePMCALC17),PrePMC175 = VALUES(PrePMC175),PrePMCALC175 = VALUES(PrePMCALC175),'+
                'PrePMC18 = VALUES(PrePMC18),PrePMCALC18 = VALUES(PrePMCALC18),PrePMC19 = VALUES(PrePMC19),PrePMCALC19 = VALUES(PrePMCALC19),'+
                'PrePMC20 = VALUES(PrePMC20),PrePMCALC20 = VALUES(PrePMCALC20),PrePMC21 = VALUES(PrePMC21),PrePMCALC21 = VALUES(PrePMCALC21),'+
                'PrePMC22 = VALUES(PrePMC22),PrePMCALC21 = VALUES(PrePMCALC22);';

      acReg := 0;
      QueIncl.SQL.Text := 'INSERT INTO arqcmed ('+Campos+') VALUES ';
      try
         while not Eof(ArquivoCSV) do
         begin
            Readln(ArquivoCSV, Linha);
            Linha := ProcessaString(Linha);
            Lista := SplitString(Linha,';');
            if Length(Lista) < 57  then Continue;
            if (OnlyNumbers(Lista[5]) = '') and (OnlyNumbers(Lista[6]) = '')  then Continue;
            if (OnlyNumbers(Lista[5]) = '') and (OnlyNumbers(Lista[6]) <> '') then
            begin
               Lista[5] := Lista[6];
               Lista[6] := '';
            end;

            auxTipoPro := 'O';
            if Trim(Lista[11]) = 'Genérico'     then auxTipoPro := 'G' else
            if Trim(Lista[11]) = 'Similar'      then auxTipoPro := 'S' else
            if Trim(Lista[11]) = 'Fitoterápico' then auxTipoPro := 'F' else
            if Trim(Lista[11]) = 'Novo'         then auxTipoPro := 'N' else
            if Trim(Lista[11]) = 'Biológico'    then auxTipoPro := 'B' else
            if Trim(Lista[11]) = 'Específico'   then auxTipoPro := 'E' else
            if Trim(Lista[11]) = 'Produto de Terapia Avançada' then auxTipoPro := 'A';
            auxTipoLis := 'E';
            if Trim(Lista[54]) = 'Positiva' then auxTipoLis := 'P' else
            if Trim(Lista[54]) = 'Negativa' then auxTipoLis := 'N';
            auxValores := '';
            for acI := 13 to 28 do auxValores := auxValores + FormatarStrReais(Lista[acI],True)+',';
            for acI := 31 to 46 do auxValores := auxValores + FormatarStrReais(Lista[acI],True)+iif(acI < 46,',',' ');

            QueIncl.SQL.Add('('+
            Aspas(AnsiLeftStr(OnlyNumbers(Lista[5]),14))+','+
            Aspas(AnsiLeftStr(OnlyNumbers(Lista[6]),14))+','+
            Aspas(AnsiLeftStr(OnlyNumbers(Lista[7]),14))+','+
            Aspas(AnsiLeftStr(Trim(Lista[0]),255))+','+
            Aspas(OnlyNumbers(AnsiLeftStr(Trim(Lista[1]),18)))+','+
            Aspas(OnlyNumbers(AnsiLeftStr(Trim(Lista[4]),13)))+','+
            Aspas(AnsiLeftStr(Trim(Lista[8]),120))+','+
            Aspas(AnsiLeftStr(Trim(Lista[9]),180))+','+
            Aspas(auxTipoPro)+','+
            Aspas(auxTipoLis)+','+
            Aspas(iif(Trim(Lista[12]) = 'Regulado','R','L'))+','+
            iif(Copy(Lista[52],1,1) = 'N','False','True')+','+
            Aspas(AnsiLeftStr(Trim(Lista[56]),20))+','+auxValores+'),');

            // ------ Gera Registro no arqsubstancia (molécula) ------ //
            LisSubs := SplitString(Trim(Lista[0]),'|');
            if Length(LisSubs) > 0 then
            begin
               for I := 0 to Length(LisSubs)-1 do
               begin
                  QueSubs.SQL.Add('INSERT INTO arqsubstancia (DesSubs, IndControle) '+
                  'SELECT '+Aspas(LisSubs[I])+', CASE WHEN INSTR('+Aspas(Lista[56])+', '+Aspas('Preta')+') > 0 THEN TRUE ELSE FALSE END '+
                  'FROM dual WHERE NOT EXISTS (SELECT 1 FROM arqsubstancia WHERE DesSubs = '+Aspas(LisSubs[I])+') LIMIT 1;');
               end; //for
            end; //if

            Inc(acReg);
            if acReg > 50 then
            begin
               QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+auxDUP;
               QueIncl.ExecSQL;
               QueIncl.SQL.Text := 'INSERT INTO arqcmed ('+Campos+') VALUES ';
               if QueSubs.SQL.Text <> '' then QueSubs.ExecSQL;
               QueSubs.SQL.Clear;
               acReg := 0;
            end; //if
         end; //while

         if acReg > 0 then
         begin
            QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+auxDUP;
            QueIncl.ExecSQL;
            if QueSubs.SQL.Text <> '' then QueSubs.ExecSQL;
         end;


///////------> PARTE ABAIXO NO SERVER DO FARMACIA

         // --------- Associa CodEAN ao Produto (arqprodutoean) --------- //
         acReg := 0;
         QueIncl.SQL.Clear;
         with QueAuxi do
         begin
            SQL.Text := 'SELECT CME.CodEAN,CME.CodEAN2,CME.CodEAN3,PRO.IDProd FROM arqcmed CME LEFT JOIN '+
            'arqproduto PRO ON CME.CodEAN = PRO.CodEANpri OR CME.CodEAN2 = PRO.CodEANpri OR CME.CodEAN3 = PRO.CodEANpri '+
            'WHERE PRO.CodEANpri != '+Aspas('')+' AND NOT ISNULL(PRO.CodEANpri)';
            QueAuxi.Open;
            while not Eof do
            begin
               if FieldByName('CodEAN').AsString.Trim <> '' then
               begin
                  QueIncl.SQL.Add('INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ('+
                  FieldByName('IDProd').AsString+','+Aspas(FieldByName('CodEAN').AsString)+') '+
                  'ON DUPLICATE KEY UPDATE CodEAN = VALUES(CodEAN);');
               end;
               if FieldByName('CodEAN2').AsString.Trim <> '' then
               begin
                  QueIncl.SQL.Add('INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ('+
                  FieldByName('IDProd').AsString+','+Aspas(FieldByName('CodEAN2').AsString)+') '+
                  'ON DUPLICATE KEY UPDATE CodEAN = VALUES(CodEAN);');
               end;
               if FieldByName('CodEAN3').AsString.Trim <> '' then
               begin
                  QueIncl.SQL.Add('INSERT INTO arqprodutoean (IDProd,CodEAN) VALUES ('+
                  FieldByName('IDProd').AsString+','+Aspas(FieldByName('CodEAN3').AsString)+') '+
                  'ON DUPLICATE KEY UPDATE CodEAN = VALUES(CodEAN);');
               end;
               Inc(acReg);
               if acReg > 50 then
               begin
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Clear;
                  acReg := 0;
               end;
               Next;
            end; //while

            if acReg > 0 then QueIncl.ExecSQL;
         end; //with

         // --------- Associa Substância ao Produto (arqprodutosub) --------- //
         acReg := 0;
         QueIncl.SQL.Text := 'INSERT INTO arqprodutosub (IDProd,IDSubs) VALUES ';
         with QueAuxi do
         begin
            SQL.Text := 'SELECT EAN.IDProd,SUB.IDSubs FROM arqcmed CME LEFT JOIN arqprodutoean EAN ON '+
            'CME.CodEAN = EAN.CodEAN OR CME.CodEAN2 = EAN.CodEAN OR CME.CodEAN3 = EAN.CodEAN '+
            'LEFT JOIN arqsubstancia SUB ON INSTR(CME.DesSubs, SUB.DesSubs) > 0 WHERE NOT ISNULL(EAN.IDProd)';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+FieldByName('IDProd').AsString+','+Aspas(FieldByName('IDSubs').AsString)+'),');
               Inc(acReg);
               if (acReg > 50) or Eof then
               begin
                  acReg := 0;
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1);
                  QueIncl.SQL.Add(' ON DUPLICATE KEY UPDATE IDSubs = VALUES(IDSubs);');
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqprodutosub (IDProd,IDSubs) VALUES ';
               end;
               Next;
            end; //while
         end; //with

         // ------- Associa o Fabricante ao Produto / Reg.Min.Saúde ------- //
         acReg := 0;
         QueIncl.SQL.Clear;
         with QueAuxi do
         begin
            SQL.Text := 'SELECT EAN.IDProd,PES.IDPess,CME.RegistoMS FROM arqcmed CME '+
            'LEFT JOIN arqprodutoean EAN ON CME.CodEAN = EAN.CodEAN OR CME.CodEAN2 = EAN.CodEAN OR CME.CodEAN3 = EAN.CodEAN '+
            'LEFT JOIN arqpessoa PES ON CME.CNPJlab = PES.CpfCnpjPes WHERE NOT ISNULL(IDProd)';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('UPDATE arqproduto SET IDFabr = '+FieldByName('IDPess').AsString+', '+
               'RegistoMS = '+Aspas(FieldByName('RegistoMS').AsString)+' WHERE IDProd = '+FieldByName('IDProd').AsString+';');
               Inc(acReg);
               if acReg > 80 then
               begin
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Clear;
                  acReg := 0;
               end;
               Next;
            end; //while
            if acReg > 0 then QueIncl.ExecSQL;
         end; //with

         // ...... Inclui na Tabela arqprodutoean os CodEAN que não Existem .... //
         QueIncl.SQL.Text := 'INSERT INTO arqprodutoean (IDProd,CodEAN) SELECT a.IDProd, a.CodEANpri '+
         'FROM arqproduto a WHERE NOT EXISTS (SELECT 1 FROM arqprodutoean b WHERE b.IDProd = a.IDProd);';
         QueIncl.ExecSQL;
      except
         SalvaLog('MIGRA_CMED',PastaLog,#10+QueIncl.SQL.Text+#10+QueSubs.SQL.Text);
         raise;
      end;
   finally
      QueAuxi.Close;
      QueSubs.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueIncl);
      FreeAndNil(QueSubs);
      CloseFile(ArquivoCSV);
      ShowMessage('Terminou!');
   end;
//https://dados.gov.br/dados/conjuntos-dados/preco-de-medicamentos-no-brasil-governo
//https://consultas.anvisa.gov.br/#/
end;

// ---------- Atualiza Produtos (arqproduto) C/ Dados CMED (arqcmed) -------- //
function AtuProdutoCMED:Boolean;
var
   I,acReg:Integer;
   auxPrecoPMC,auxPrecoPF:Double;
   strPerICM,strPerALC,strPerGEN:String;
   QueICMS,QueAuxi,QueIncl:TRESTDWClientSQL;
begin
   Result  := False;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueICMS := TRESTDWClientSQL.Create(nil);
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueICMS.DataBase := DM.DWDataBase;
   QueIncl.DataBase := DM.DWDataBase;
   QueIncl.SQL.Clear;
   acReg := 0;

   try
      try
         // ------ Pega o Estado (UF) e Verifica Cidade é ALC ------ //
         strPerICM := '';
         strPerALC := '';
         strPerGEN := '';
         QueICMS.SQL.Text := 'SELECT ICM.*,MUN.IndALC FROM arqparametros PAR ';
         QueICMS.SQL.Add('LEFT JOIN arqmuni MUN ON PAR.Codmun = MUN.Codmun ');
         QueICMS.SQL.Add('LEFT JOIN arqicmsuf ICM ON MUN.Estmun = ICM.UFICMS');
         QueICMS.Open;
         while not QueICMS.Eof do
         begin
            if QueICMS.FieldByName('IndGEN').AsString = '1' then
                 strPerGEN := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)))
            else
            if QueICMS.FieldByName('IndALC').AsBoolean then
                 strPerALC := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)))
            else strPerICM := RemoveZerosDireita(IntToStr(Trunc(QueICMS.FieldByName('PerICMS').AsFloat * 100)));
            QueICMS.Next;
         end; //while

         with QueAuxi do
         begin
            SQL.Text := 'SELECT EAN.IDProd,CME.* FROM arqprodutoean EAN LEFT JOIN arqcmed CME ON ';
            SQL.Add('EAN.CodEAN = CME.CodEAN OR EAN.CodEAN = CME.CodEAN2 OR EAN.CodEAN = CME.CodEAN3 WHERE ');
            SQL.Add('NOT ISNULL(CME.CodEAN) OR NOT ISNULL(CME.CodEAN2) OR NOT ISNULL(CME.CodEAN3) GROUP BY EAN.IDProd');
            Open;
            while not Eof do
            begin
               if not FieldByName('IndICMS0').AsBoolean then
               begin
                  if FieldByName('TipoPro').AsString = 'G' then
                  begin
                     auxPrecoPMC := FieldByName('PrePMC'+strPerGEN).AsFloat;
                     auxPrecoPF  := FieldByName('PreFab'+strPerGEN).AsFloat;
                  end else
                  begin
                     auxPrecoPMC := FieldByName('PrePMC'+strPerICM).AsFloat;
                     auxPrecoPF  := FieldByName('PreFab'+strPerICM).AsFloat;
                  end;
               end else
               begin
                  auxPrecoPMC := FieldByName('PrePMC00').AsFloat;
                  auxPrecoPF  := FieldByName('PreFab00').AsFloat;
               end; //if

               QueIncl.SQL.Add('UPDATE arqproduto SET '+
               'TipoLista = '+Aspas(FieldByName('TipoLista').AsString)+','+
               'TipoPre = '  +Aspas(iif(FieldByName('RegPreco').AsString = 'R','REGULADO','LIBERADO'))+','+
               'TipoPro = '  +Aspas(FieldByName('TipoPro').AsString)+','+
               'PrecoFab = ' +FormatDouble(auxPrecoPF,9,2)+' / IF(QtdFrac > 0.00, QtdFrac, 1)'+
                iif(FieldByName('RegPreco').AsString = 'R',',PrecoPMC = '+FormatDouble(auxPrecoPMC,9,2)+' / IF(QtdFrac > 0.00, QtdFrac, 1) ',' ')+
               'WHERE IDProd = '+FieldByName('IDProd').AsString+';');

               if acReg > 50 then
               begin
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Clear;
                  acReg := 0;
               end; //if
               Inc(acReg);
               QueAuxi.Next;
            end; //while
         end; //with

         if acReg > 0 then QueIncl.ExecSQL;
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog('ATU_PROD_CMED',PastaLog,E.Message);
            raise
         end;
      end; //try
   finally
      QueICMS.Close;   FreeAndNil(QueICMS);
      QueIncl.Close;   FreeAndNil(QueIncl);
      QueAuxi.Close;   FreeAndNil(QueAuxi);
   end;
end;

// ---------- Grava Fatores e Índices Macro Econômicos  ---------- //
function GravaMacroIndices(recPIni,recPFin:TDate):Boolean;
var
   I:Integer;
   QueIncl:TRESTDWClientSQL;
   aFatorICC,aFatorCEA,aFatorCEF,aFatorLIC,aFatorPCA,aFatorPIC:TArray<TIndiceBCP>;
begin
   Result := False;
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueIncl.DataBase := DM.DWDataBase;
   QueIncl.SQL.Clear;
   try
      try
         aFatorICC := GetIndiceBCP(recPIni, recPFin, 'ICC', 0);
         aFatorCEA := GetIndiceBCP(recPIni, recPFin, 'CEA', 0);
         aFatorCEF := GetIndiceBCP(recPIni, recPFin, 'CEF', 0);
         aFatorLIC := GetIndiceBCP(recPIni, recPFin, 'LIC', 0);
         aFatorPCA := GetIndiceBCP(recPIni, recPFin, 'PCA', 0);
         aFatorPIC := GetIndiceBCP(recPIni, recPFin, 'PIC', 0);
         for I := 0 to Length(aFatorICC) -1 do QueIncl.SQL.Add('INSERT INTO arqtaxasmensal (IndexAno,IndexMes,IndexICC) VALUES ('+FormatDateTime('yyyy',aFatorICC[I].Data)+','+FormatDateTime('mm',aFatorICC[I].Data)+','+FormatDouble(aFatorICC[I].Valor,6,2)+') ON DUPLICATE KEY UPDATE IndexICC = VALUES(IndexICC);');
         QueIncl.ExecSQL;
         for I := 0 to Length(aFatorCEA) -1 do QueIncl.SQL.Add('INSERT INTO arqtaxasmensal (IndexAno,IndexMes,IndexCEA) VALUES ('+FormatDateTime('yyyy',aFatorCEA[I].Data)+','+FormatDateTime('mm',aFatorCEA[I].Data)+','+FormatDouble(aFatorCEA[I].Valor,6,2)+') ON DUPLICATE KEY UPDATE IndexCEA = VALUES(IndexCEA);');
         QueIncl.ExecSQL;
         for I := 0 to Length(aFatorCEF) -1 do QueIncl.SQL.Add('INSERT INTO arqtaxasmensal (IndexAno,IndexMes,IndexCEF) VALUES ('+FormatDateTime('yyyy',aFatorCEF[I].Data)+','+FormatDateTime('mm',aFatorCEF[I].Data)+','+FormatDouble(aFatorCEF[I].Valor,6,2)+') ON DUPLICATE KEY UPDATE IndexCEF = VALUES(IndexCEF);');
         QueIncl.ExecSQL;
         for I := 0 to Length(aFatorLIC) -1 do QueIncl.SQL.Add('INSERT INTO arqtaxasmensal (IndexAno,IndexMes,IndexLIC) VALUES ('+FormatDateTime('yyyy',aFatorLIC[I].Data)+','+FormatDateTime('mm',aFatorLIC[I].Data)+','+FormatDouble(aFatorLIC[I].Valor,6,2)+') ON DUPLICATE KEY UPDATE IndexLIC = VALUES(IndexLIC);');
         QueIncl.ExecSQL;
         for I := 0 to Length(aFatorPCA) -1 do QueIncl.SQL.Add('INSERT INTO arqtaxasmensal (IndexAno,IndexMes,IndexPCA) VALUES ('+FormatDateTime('yyyy',aFatorPCA[I].Data)+','+FormatDateTime('mm',aFatorPCA[I].Data)+','+FormatDouble(aFatorPCA[I].Valor,6,2)+') ON DUPLICATE KEY UPDATE IndexPCA = VALUES(IndexPCA);');
         QueIncl.ExecSQL;
         for I := 0 to Length(aFatorPIC) -1 do QueIncl.SQL.Add('INSERT INTO arqtaxasmensal (IndexAno,IndexMes,IndexPIC) VALUES ('+FormatDateTime('yyyy',aFatorPCA[I].Data)+','+FormatDateTime('mm',aFatorPCA[I].Data)+','+FormatDouble(aFatorPIC[I].Valor,6,2)+') ON DUPLICATE KEY UPDATE IndexPIC = VALUES(IndexPIC);');
         QueIncl.ExecSQL;
         Result := True;
      except
         on E:Exception do
            SalvaLog('GravaMacroIndices',PastaLog,'ERRO: ao gravar ->'+E.Message);
      end;
   finally
      QueIncl.Free;
   end;
end;

// ---------------- Grava Índices Meteorológicos  ---------------- //
function GravaMeterologia(recLati,recLong:Double; recPIni,recPFin:TDate; recPrev:Boolean):Boolean;
var
   I,acReg:Integer;
   QueIncl:TRESTDWClientSQL;
   aMeteorol:TWeatherDataArray;
begin
   Result  := False;
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueIncl.DataBase := DM.DWDataBase;
   QueIncl.SQL.Text := 'INSERT INTO arqmeteorologia (Datmet,TempMin,TempMax,TempMed,Pluviomet) VALUES ';
   try
      try
         acReg := 0;
         aMeteorol := GetDailyWeather(recLati,recLong,recPIni,recPFin,recPrev);
         for I := 0 to Length(aMeteorol) -1 do
         begin
            QueIncl.SQL.Add('('+Aspas(FormatDateTime('yyyy-mm-dd',aMeteorol[I].DataTemp))+','+
            FormatDouble(aMeteorol[I].MaxTemperature, 6,2)+','+FormatDouble(aMeteorol[I].MinTemperature,  6,2)+','+
            FormatDouble(aMeteorol[I].MeanTemperature,6,2)+','+FormatDouble(aMeteorol[I].PrecipitationSum,6,2)+'),');
            Inc(acReg);
            if (acReg > 50) or (I = Length(aMeteorol)-1) then
            begin
               acReg := 0;
               QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
               QueIncl.SQL.Add('ON DUPLICATE KEY UPDATE TempMin = VALUES(TempMin),'+
               'TempMax = VALUES(TempMax),TempMed = VALUES(TempMed),Pluviomet = VALUES(Pluviomet);');
               QueIncl.ExecSQL;
               QueIncl.SQL.Text := 'INSERT INTO arqmeteorologia (Datmet,TempMin,TempMax,TempMed,Pluviomet) VALUES ';
            end; //if
         end; //for
         Result := True;
      except
         on E:Exception do
         begin
            SalvaLog('arqmeteorologia',PastaLog,#10+QueIncl.SQL.Text+#10+E.Message);
            raise;
         end;
      end; //try
   finally
      QueIncl.Free;
   end;
end;

// -------- Geração de Movimento Para Treinamento IA  -------- //
procedure GeraTestesIA;
var
   Campos:String;
   acReg:Integer;
   QueIncl,QueAuxi:TRESTDWClientSQL;
begin
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueIncl.DataBase := DM.DWDataBase;
   try
      // ........ Gera Dados Lotes arqprodutolot ........ //
      acReg  := 0;
      QueIncl.SQL.Text := 'INSERT INTO arqprodutolot (IDProd,Nrolot,Datven,Qtdest) VALUES ';
      try
         with QueAuxi do
         begin
            SQL.Text := 'SELECT HIS.Nrolot,HIS.Datven,HIS.Qtdmov,PRO.IDProd FROM arqhistcomercio HIS '+
            'LEFT JOIN arqproduto PRO ON HIS.CodEAN = PRO.CodEANpri WHERE HIS.Nrolot != '+Aspas('')+' AND NOT '+
            'ISNULL(HIS.Nrolot) AND TipoHis = '+Aspas('E')+' AND PRO.IDProd > 0';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+FieldByName('IDProd').AsString+','+Aspas(FieldByName('Nrolot').AsString)+','+
               Aspas(FormatDateTime('yyyy-mm-dd',FieldByName('Datven').AsDateTime))+','+
               FormatDouble(FieldByName('Qtdmov').AsFloat,9,2)+'),');
               Inc(acReg);
               Next;
               if (acReg > 100) or Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.SQL.Add('ON DUPLICATE KEY UPDATE Datven = VALUES(Datven), Qtdest = VALUES(Qtdest)');
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqprodutolot (IDProd,Nrolot,Datven,Qtdest) VALUES ';
                  acReg  := 0;
               end; //if
            end; //while
         end; //with
      except
         SalvaLog('GERAR_ESTOQUE',PastaLog,#10+QueIncl.SQL.Text);
         raise;
      end;

      // ........ Gera Dados Vendas arqpedidoite e arqpedido ........ //
      acReg  := 0;
      Campos := 'IDPed,IDProd,VlrPIS,VlrCOF,Qtdped,VlrVenda';
      QueIncl.SQL.Text := 'INSERT INTO arqpedidoite ('+Campos+') VALUES ';
      try
         with QueAuxi do
         begin
            SQL.Text := 'SELECT * FROM arqhistcomercio WHERE TipoHis = '+Aspas('S')+' AND IDProd > 0 ORDER BY Datmov';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+
               FieldByName('NroNFe').AsString+','+
               FieldByName('IDProd').AsString+','+
               FormatDouble(FieldByName('VlrPIS').AsFloat,9,2)+','+
               FormatDouble(FieldByName('VlrCOF').AsFloat,9,2)+','+
               FormatDouble(FieldByName('Qtdmov').AsFloat,9,2)+','+
               FormatDouble(FieldByName('PreVenda').AsFloat,9,2)+'),');
               Inc(acReg);
               Next;
               if (acReg > 100) or Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqpedidoite ('+Campos+') VALUES ';
                  acReg  := 0;
               end; //if
            end; //while

            QueIncl.SQL.Text := 'INSERT INTO arqpedido (IDPed,Datped,TotPedido) VALUES ';
            QueAuxi.Close;
            SQL.Text := 'SELECT NroNFe,Datmov,SUM(Qtdmov * PreVenda) AS TotItem FROM arqhistcomercio '+
            'WHERE TipoHis = '+Aspas('S')+' AND IDProd > 0 GROUP BY NroNFe ORDER BY Datmov';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+
               FieldByName('NroNFe').AsString+','+
               Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',FieldByName('Datmov').AsDateTime))+','+
               FormatDouble(FieldByName('TotItem').AsFloat,9,2)+'),');
               Inc(acReg);
               Next;
               if (acReg > 100) or Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqpedido (IDPed,Datped,TotPedido) VALUES ';
                  acReg  := 0;
               end; //if
            end; //while
         end; //with
      except
         SalvaLog('GERAR_VENDAS',PastaLog,#10+QueIncl.SQL.Text);
         raise;
      end;

      // ........ Gera Custo Médio CustoMed (arqproduto e arqpedidoite) ........ //
      acReg  := 0;
      Campos := 'IDPed,IDProd,VlrPIS,VlrCOF,Qtdped,VlrVenda';
      QueIncl.SQL.Text := 'INSERT INTO arqpedidoite ('+Campos+') VALUES ';
      try
         with QueAuxi do
         begin
            SQL.Text := 'SELECT * FROM arqhistcomercio WHERE TipoHis = '+Aspas('S')+' AND IDProd > 0 ORDER BY Datmov';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+
               FieldByName('NroNFe').AsString+','+
               FieldByName('IDProd').AsString+','+
               FormatDouble(FieldByName('VlrPIS').AsFloat,9,2)+','+
               FormatDouble(FieldByName('VlrCOF').AsFloat,9,2)+','+
               FormatDouble(FieldByName('Qtdmov').AsFloat,9,2)+','+
               FormatDouble(FieldByName('PreVenda').AsFloat,9,2)+'),');
               Inc(acReg);
               Next;
               if (acReg > 100) or Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqpedidoite ('+Campos+') VALUES ';
                  acReg  := 0;
               end; //if
            end; //while

            QueIncl.SQL.Text := 'INSERT INTO arqpedido (IDPed,Datped,TotPedido) VALUES ';
            QueAuxi.Close;
            SQL.Text := 'SELECT NroNFe,Datmov,SUM(Qtdmov * PreVenda) AS TotItem FROM arqhistcomercio '+
            'WHERE TipoHis = '+Aspas('S')+' AND IDProd > 0 GROUP BY NroNFe ORDER BY Datmov';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+
               FieldByName('NroNFe').AsString+','+
               Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',FieldByName('Datmov').AsDateTime))+','+
               FormatDouble(FieldByName('TotItem').AsFloat,9,2)+'),');
               Inc(acReg);
               Next;
               if (acReg > 100) or Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqpedido (IDPed,Datped,TotPedido) VALUES ';
                  acReg  := 0;
               end; //if
            end; //while
         end; //with
      except
         SalvaLog('GERAR_VENDAS',PastaLog,#10+QueIncl.SQL.Text);
         raise;
      end;

      // ........ Gera Dados Vendas arqcomprarecite e arqcomprarec ........ //
      acReg  := 0;
      Campos := 'IDRec,IDProd,Qtdrec,VlrPIS,VlrCOF,VlrIPI,VlrST,Vlruni';
      QueIncl.SQL.Text := 'INSERT INTO arqcomprarecite ('+Campos+') VALUES ';
      try
         with QueAuxi do
         begin
            SQL.Text := 'SELECT HIS.*, PRO.IDProd AS PRO_IDProd FROM arqhistcomercio HIS JOIN arqproduto '+
            'PRO ON HIS.CodEAN = PRO.CODEANpri WHERE HIS.TipoHis = '+Aspas('E')+' ORDER BY HIS.Datmov';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+
               FieldByName('NroNFe').AsString+','+
               FieldByName('PRO_IDProd').AsString+','+
               FormatDouble(FieldByName('Qtdmov').AsFloat,9,2)+','+
               FormatDouble(FieldByName('VlrPIS').AsFloat,9,2)+','+
               FormatDouble(FieldByName('VlrCOF').AsFloat,9,2)+','+
               FormatDouble(FieldByName('VlrIPI').AsFloat,9,2)+','+
               FormatDouble(FieldByName('VlrST').AsFloat,9,2)+','+
               FormatDouble(FieldByName('PreVenda').AsFloat,9,2)+'),');
               Inc(acReg);
               Next;
               if (acReg > 100) or Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqcomprarecite ('+Campos+') VALUES ';
                  acReg  := 0;
               end; //if
            end; //while

            QueIncl.SQL.Text := 'INSERT INTO arqcomprarec (IDRec,Datrec,TotReceb) VALUES ';
            QueAuxi.Close;
            SQL.Text := 'SELECT NroNFe,Datmov,SUM(Qtdmov * PreVenda) AS TotItem FROM arqhistcomercio '+
            'WHERE TipoHis = '+Aspas('E')+' AND IDProd > 0 GROUP BY NroNFe ORDER BY Datmov';
            QueAuxi.Open;
            while not Eof do
            begin
               QueIncl.SQL.Add('('+
               FieldByName('NroNFe').AsString+','+
               Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',FieldByName('Datmov').AsDateTime))+','+
               FormatDouble(FieldByName('TotItem').AsFloat,9,2)+'),');
               Inc(acReg);
               Next;
               if (acReg > 100) or Eof then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqcomprarec (IDRec,Datrec,TotReceb) VALUES ';
                  acReg  := 0;
               end; //if
            end; //while
         end; //with
      except
         SalvaLog('GERAR_ENTRADAS',PastaLog,#10+QueIncl.SQL.Text);
         raise;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueIncl);
      ShowMessage('Terminou!');
   end;
end;

function FormatarStrReais(const valor:String; recFormSQL:Boolean):String;
begin
   Result := Trim(valor);
   if Result <> '' then
   begin
      if not recFormSQL then
      begin
         Result := StringReplace(Result,'.','', [rfReplaceAll]);
         Result := StringReplace(Result,',','.',[rfReplaceAll]);
      end;
   end
   else Result := '0.00';
end;

function ProcessaString(const StrEntrada:String):String;
var
   PosInicio,PosFim:Integer;
   Substring,Resultado:String;
begin
   Resultado := StrEntrada;
   PosInicio := Pos('"', Resultado);
   while PosInicio > 0 do
   begin
      PosFim := PosEx('"', Resultado, PosInicio+1);
      if PosFim > 0 then
      begin
         Substring := Copy(Resultado, PosInicio + 1, PosFim - PosInicio - 1);
         Substring := StringReplace(Substring, ';', '|', [rfReplaceAll]);
         Resultado := Copy(Resultado,1,PosInicio-1) + Substring + Copy(Resultado, PosFim+1, Length(Resultado));
         PosInicio := PosEx('"', Resultado, PosFim + 1);
      end
      else Break;
   end;
   Result := Resultado;
end;

function RemoveZerosDireita(const Value:String):String;
var
   I:Integer;
begin
   I := Length(Value);
   while (I > 0) and (Value[I] = '0') do Dec(I);
   Result := Copy(Value, 1, I);
end;

end.

