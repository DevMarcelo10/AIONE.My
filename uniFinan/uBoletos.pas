unit uBoletos;

interface

uses
   Windows, Messages, MarcLib, Vcl.Forms, Classes, Controls, Dialogs, ExtCtrls, DateUtils,
   System.SysUtils, Variants, Vcl.StdCtrls, uRESTDWBasicDB, Data.DB, Vcl.DBCtrls, ACBrMail,
   ACBrBoleto, ACBrUtil.FilesIO, ComCtrls, ACBrBoletoConversao, ACBrBoletoFPDF,
   ACBrBoletoFCFortesFr, Winapi.ShellAPI;

   procedure EnviaEmail(recMailDest:String);
   function  SetConfigEmail(recFACBrMail:TACBrMail;recIDFilial:Integer):Boolean;
   function  GeraBoleto(recIDTitu,recIDFilial,recCodban,recForma:Integer;TabTitu:TRESTDWClientSQL;recValTitu:Double;recConv,recGeraRem:Boolean):String;
   function  retTipoCobranca(NumeroBanco: Integer; Carteira: String = ''):TACBrTipoCobranca;

var
   FACBrBoleto :TACBrBoleto;
   FACBrMail   :TACBrMail;
   auxDirLogo,auxDirBole:String;
   TabTitu:TRESTDWClientSQL;

implementation

uses uDM, uConst, uLibFarm, uMsgEnvBol;

function GeraBoleto(recIDTitu,recIDFilial,recCodban,recForma:Integer;TabTitu:TRESTDWClientSQL;recValTitu:Double;recConv,recGeraRem:Boolean):String;
var
   auxMoraDia:Double;
   Titulo:TACBrTitulo;
   auxNossoNro,auxNomeArq:String;
   auxFormEnv: TFrmMsgEnvBol;
   intNosNor:Integer;
   FACBrBoletoFPDF:TACBrBoletoFPDF;
   FACBrBoletoFCRL:TACBrBoletoFCFortes;
   QueAuxi,QueBanco,QueParam,QueConv:TRESTDWClientSQL;
   auxEmailTexto:TstringList;
   Data: TDateTime;
   Ano, Mes, Dia: Word;
   Hora, Minuto, Segundo, Mili: Word;
   Mail:TACBrMail;
begin
   Result := '';
   auxDirLogo  := PathExe+'Boletos\Logos\Colorido\png';
   FACBrBoleto     := TACBrBoleto.Create(nil);
   FACBrBoletoFPDF := TACBrBoletoFPDF.Create(FACBrBoleto);
   FACBrBoletoFCRL := TACBrBoletoFCFortes.Create(FACBrBoleto);
   FACBrBoleto.ACBrBoletoFC := FACBrBoletoFCRL;
   FACBrMail       := TACBrMail.Create(FACBrBoleto);
   QueAuxi   := TRESTDWClientSQL.Create(nil);
   QueBanco  := TRESTDWClientSQL.Create(nil);
   QueParam  := TRESTDWClientSQL.Create(nil);
   QueConv   := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase   := DM.DWDataBase;
   QueBanco.DataBase  := DM.DWDataBase;
   QueParam.DataBase  := DM.DWDataBase;
   QueConv.DataBase   := DM.DWDataBase;
   Screen.Cursor      := crHourGlass;
   auxEmailTexto      := TStringList.Create;
   try
      try
         QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+recIDFilial.ToString;
         QueParam.Open;

         QueBanco.SQL.Text := 'SELECT * FROM arqbanco WHERE Codban = '+recCodban.ToString+' AND IDFilial = '+recIDFilial.ToString;
         QueBanco.Open;
         if QueBanco.IsEmpty then raise Exception.Create('Banco/Filial não encontrado para emissão do boleto. Codban - > '+recCodban.ToString);

         FACBrBoleto.LayoutRemessa      := iif(QueBanco.FieldByName('CNABMod').AsString = '400', c400, c240);
         FACBrBoleto.Banco.Numero       := QueBanco.FieldByName('Codban').AsInteger;
         FACBrBoleto.Banco.TipoCobranca := retTipoCobranca(QueBanco.FieldByName('Codban').AsInteger);
         FACBrBoleto.ImprimirMensagemPadrao := True;
         FACBrBoleto.ListadeBoletos.Clear;

         with FACBrBoleto.Cedente do
         begin
            ResponEmissao := tbCliEmite;
            CaracTitulo   := tcSimples;
            TipoInscricao := pJuridica;
            TipoCarteira  := tctRegistrada;
            CNPJCPF       := QueParam.FieldByName('CNPJFar').AsString;
            Nome          := QueParam.FieldByName('Nomefar').AsString;
            Logradouro    := QueParam.FieldByName('Endfar').AsString;
            NumeroRes     := QueParam.FieldByName('NroEnt').AsString;
            Complemento   := QueParam.FieldByName('CompEnd').AsString;
            Bairro        := QueParam.FieldByName('Baifar').AsString;
            Cidade        := QueParam.FieldByName('Nommun').AsString;
            UF            := QueParam.FieldByName('Estmun').AsString;
            CEP           := QueParam.FieldByName('Cepfar').AsString;
            Agencia       := QueBanco.FieldByName('AgeBco').AsString;
            CodigoCedente := QueBanco.FieldByName('CodCedBco').AsString;
            Conta         := QueBanco.FieldByName('ContaBco').AsString;
            ContaDigito   := QueBanco.FieldByName('DigitoBco').AsString;
            Modalidade    := QueBanco.FieldByName('ModCobBco').AsString;
            Convenio      := iif(QueBanco.FieldByName('Convenio').AsString  <> '', QueBanco.FieldByName('Convenio').AsString, '');
            AgenciaDigito := iif(QueBanco.FieldByName('DigAgeBco').AsString <> '', QueBanco.FieldByName('DigAgeBco').AsString,'');
            CodigoTransmissao := iif(QueBanco.FieldByName('CodTraBco').AsString <> '', QueBanco.FieldByName('CodTraBco').AsString,'');
         end; //with

         TabTitu.Filtered := False;
         TabTitu.Filter   := 'GeraBol = '+Aspas('1');
         TabTitu.Filtered := True;
         TabTitu.First;
         if recConv then
         begin
            QueConv.SQL.Text := 'SELECT PES.*, MUN.Nommun, MUN.Estmun FROM arqpessoa PES '+
            'LEFT JOIN arqconvenio CON ON CON.IDPessPri = PES.IDpess '+
            'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '+
            'WHERE CON.IDConv = '+ TabTitu.FieldByName('IDConv').AsString;
            QueConv.Open;
            Titulo := FACBrBoleto.CriarTituloNaLista;
            with Titulo do
            begin
               if TabTitu.FieldByName('NossoNro').AsString = '' then
               begin
                  intNosNor := QueBanco.FieldByName('UltNosNBco').AsInteger + 1;
                  auxNossoNro := intNosNor.ToString;
               end
               else auxNossoNro := QueBanco.FieldByName('UltNosNBco').AsString;
               DataDocumento   := Date;
               Carteira        := QueBanco.FieldByName('CarCobBco').AsString;
               Vencimento      := TabTitu.FieldByName('Datven').AsDateTime;
               NumeroDocumento := TabTitu.FieldByName('Nrotit').AsString+StrZero(TabTitu.FieldByName('Destit').AsString,3);
               EspecieDoc      := TabTitu.FieldByName('RedTiptit').AsString;
               EspecieMod      := 'REAIS';
               Aceite          := iif(QueBanco.FieldByName('AceiteBco').AsString = '1', atSim, atNao);
               NossoNumero     := auxNossoNro;
               ValorDocumento  := recValTitu;
               with Sacado do
               begin
                  Sacado.NomeSacado := QueConv.FieldByName('Nompes').AsString;
                  Sacado.CNPJCPF    := QueConv.FieldByName('CpfCnpjPes').AsString;
                  Sacado.Logradouro := QueConv.FieldByName('Endpes').AsString;
                  Sacado.Numero     := QueConv.FieldByName('NroEnd').AsString;
                  Sacado.Bairro     := QueConv.FieldByName('Baipes').AsString;
                  Sacado.Cidade     := QueConv.FieldByName('Nommun').AsString;
                  Sacado.UF         := QueConv.FieldByName('Estmun').AsString;
                  Sacado.CEP        := QueConv.FieldByName('Ceppes').AsString;
               end; //with
               LocalPagamento  := 'PAGAR PREFERENCIALMENTE NO '+QueBanco.FieldByName('Nomban').AsString;
               TipoDesconto    := tdNaoConcederDesconto;
               CodigoMoraJuros := cjTaxaDiaria;
               OcorrenciaOriginal.Tipo := toRemessaRegistrar;

               if QueBanco.FieldByName('PerMorBco').AsFloat > 0.00 then
               begin
                  DataMoraJuros  := IncDay(TabTitu.FieldByName('Datven').AsDateTime);
                  ValorMoraJuros := RoundX(recValTitu * (QueBanco.FieldByName('PerMorBco').AsFloat/100)/30, 3);
               end;

               if QueBanco.FieldByName('PerMulBco').AsFloat > 0.00 then
               begin
                  CodigoMulta     := cmPercentual;
                  PercentualMulta := QueBanco.FieldByName('PerMulBco').AsFloat;
                  DataMulta       := IncDay(TabTitu.FieldByName('Datven').AsDateTime);
               end; //if
               TipoPagamento := tpNao_Aceita_Valor_Divergente;
            end; //with
         end
         else
         begin
            //Aqui faz o while para gerar vários boletos
            while not TabTitu.Eof do
            begin
               Titulo := FACBrBoleto.CriarTituloNaLista;
               with Titulo do
               begin
                  if TabTitu.FieldByName('NossoNro').AsString = '' then
                  begin
                     intNosNor := QueBanco.FieldByName('UltNosNBco').AsInteger + 1;
                     auxNossoNro := intNosNor.ToString;
                     TabTitu.Edit;
                     TabTitu.FieldByName('NossoNro').AsString := auxNossoNro;
                     TabTitu.Post;
                  end
                  else auxNossoNro := QueBanco.FieldByName('UltNosNBco').AsString;
                  DataDocumento   := Date;
                  Carteira        := QueBanco.FieldByName('CarCobBco').AsString;
                  Vencimento      := TabTitu.FieldByName('Datven').AsDateTime;
                  NumeroDocumento := TabTitu.FieldByName('Nrotit').AsString+StrZero(TabTitu.FieldByName('Destit').AsString,3);
                  EspecieDoc      := TabTitu.FieldByName('RedTiptit').AsString;
                  EspecieMod      := 'REAIS';
                  Aceite          := iif(QueBanco.FieldByName('AceiteBco').AsString = '1', atSim, atNao);
                  NossoNumero     := auxNossoNro;
                  ValorDocumento  := TabTitu.FieldByName('Vlrtit').AsFloat;
                  with Sacado do
                  begin
                     Sacado.NomeSacado := TabTitu.FieldByName('Nompes').AsString;
                     Sacado.CNPJCPF    := TabTitu.FieldByName('CpfCnpjPes').AsString;
                     Sacado.Logradouro := TabTitu.FieldByName('Endpes').AsString;
                     Sacado.Numero     := TabTitu.FieldByName('NroEnd').AsString;
                     Sacado.Bairro     := TabTitu.FieldByName('Baipes').AsString;
                     Sacado.Cidade     := TabTitu.FieldByName('Nommun').AsString;
                     Sacado.UF         := TabTitu.FieldByName('Estmun').AsString;
                     Sacado.CEP        := TabTitu.FieldByName('Ceppes').AsString;
                  end; //with
                  LocalPagamento  := 'PAGAR PREFERENCIALMENTE NO '+QueBanco.FieldByName('Nomban').AsString;
                  TipoDesconto    := tdNaoConcederDesconto;
                  CodigoMoraJuros := cjTaxaDiaria;
                  OcorrenciaOriginal.Tipo := toRemessaRegistrar;

                  if QueBanco.FieldByName('PerMorBco').AsFloat > 0.00 then
                  begin
                     DataMoraJuros  := IncDay(TabTitu.FieldByName('Datven').AsDateTime);
                     ValorMoraJuros := RoundX(TabTitu.FieldByName('Vlrtit').AsFloat * (QueBanco.FieldByName('PerMorBco').AsFloat/100)/30, 3);
                  end;

                  if QueBanco.FieldByName('PerMulBco').AsFloat > 0.00 then
                  begin
                     CodigoMulta     := cmPercentual;
                     PercentualMulta := QueBanco.FieldByName('PerMulBco').AsFloat;
                     DataMulta       := IncDay(TabTitu.FieldByName('Datven').AsDateTime);
                  end; //if
                  TipoPagamento := tpNao_Aceita_Valor_Divergente;
               end; //with
               TabTitu.Next;
            end;
         end;

         Data := Now;
         DecodeDate(Data, Ano, Mes, Dia);
         DecodeTime(Data, Hora, Minuto, Segundo, Mili);
         auxNomeArq := 'Boleto'+IntToStr(Ano)+IntToStr(Mes)+IntToStr(Dia)+IntToStr(Hora)+IntToStr(Minuto)+IntToStr(Segundo)+IntToStr(Mili)+'.PDF';
         auxDirBole := QueParam.FieldByName('PastaBoletos').AsString +'\'+ auxNomeArq;
         if recForma = 1 then
         begin
            FACBrBoleto.ACBrBoletoFC := FACBrBoletoFPDF;
            FACBrBoletoFPDF.DirLogo  := auxDirLogo;
            if FileExists(auxDirBole) then DeleteFile(auxDirBole);
            FACBrBoletoFPDF.NomeArquivo := auxDirBole;
            FACBrBoleto.GerarPDF;
            MostraMsg('Aviso','Boleto em PDF salvo na pasta de boletos!',mtInformation, [mbOk]);
         end;
         if recForma = 2 then
         begin
            if TabTitu.FieldByName('EmailPes').AsString <> '' then
            begin
               SetConfigEmail(FACBrMail,recIDFilial);
               EnviaEmail('ildmann@gmail.com');
            end
            else
            begin
               MostraMsg('Aviso','Pessoa (sacado) não possui email no cadastro!',mtWarning, [mbOk]);
               Exit;
            end;
         end;
         ShellExecute(0, 'open', PChar(auxDirBole), nil, nil, SW_SHOWNORMAL);

         if recGeraRem then
         begin
            // Gera a remessa
            FACBrBoleto.DirArqRemessa := QueParam.FieldByName('PastaBoletos').AsString+'\Remessa';
            FACBrBoleto.GerarRemessa(StrToInt64Def(auxNomeArq,0));
         end;

         TabTitu.First;
         while not TabTitu.Eof do
         begin
            // ----- Atualiza o Nosso Número do Banco / Titulo ----- //
            if TabTitu.FieldByName('NossoNro').AsString = '' then
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Add('UPDATE arqtitulo SET NossoNro = ' +Aspas(auxNossoNro)+', NomeArqBol = '+Aspas(auxNomeArq)+' BolGerado = '+Aspas('1')+
               ' WHERE IDTitu = '+TabTitu.FieldByName('IDTitu').AsString);
               QueAuxi.ExecSQL;
            end  else
            begin
               QueAuxi.Close;
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Add('UPDATE arqtitulo SET NomeArqBol ='+Aspas(auxNomeArq)+' BolGerado = '+Aspas('1')+
               ' WHERE IDTitu = '+TabTitu.FieldByName('IDTitu').AsString);
               QueAuxi.ExecSQL;
            end;
            TabTitu.Next;
         end;
         TabTitu.Last;
         QueAuxi.Close;
         QueAuxi.SQL.Clear;
         QueAuxi.SQL.Add('UPDATE arqbanco SET UltNosNBco = '+auxNossoNro+' WHERE Codban = '+recCodban.ToString);
         QueAuxi.ExecSQL;
      except
         on E:Exception do
         begin
            Result := 'Não foi possível emitir boleto!'+#10+E.Message;
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível emitir boleto uBoletos -> '+E.Message);
            Exit;
         end;
      end;
   finally
      Screen.Cursor := crDefault;
      QueAuxi.Close;
      QueBanco.Close;
      QueParam.Close;
      QueConv.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueBanco);
      FreeAndNil(QueParam);
      FreeAndNil(QueConv);
      Titulo.Free;
      FACBrBoletoFPDF.Free;
      FACBrBoletoFCRL.Free;
      auxEmailTexto.Free;
      FACBrMail.Free;
   end;
   result := '1';
end;

function SetConfigEmail(recFACBrMail:TACBrMail;recIDFilial:Integer):Boolean;
var
  Mail:TACBrMail;
  QueParam:TRESTDWClientSQL;
begin
   Result  := True;
   FACBrBoleto.MAIL := FACBrMail;
   QueParam := TRESTDWClientSQL.Create(nil);
   QueParam.DataBase := DM.DWDataBase;
   try
      try
         QueParam.SQL.Text := 'SELECT * FROM arqparametros WHERE IDFilial = '+recIDFilial.ToString;
         QueParam.Open;
         Mail := recFACBrMail;
         Mail.FromName := QueParam.FieldByName('Nomefar').AsString.Trim;
         Mail.From     := QueParam.FieldByName('MailUsuario').AsString.Trim;
         Mail.Host     := QueParam.FieldByName('ServidorSMTP').AsString.Trim;
         Mail.Username := QueParam.FieldByName('MailUsuario').AsString.Trim;
         Mail.Password := QueParam.FieldByName('MailSenha').AsString.Trim;
         Mail.Port     := QueParam.FieldByName('MailPorta').AsString.Trim;
         Mail.SetTLS   := iif(QueParam.FieldByName('MailAutentica').AsString = '1',True,False);
         Mail.SetSSL   := iif(QueParam.FieldByName('MailAutentica').AsString = '1',True,False);
      except
         on E:Exception do
         begin
            Result := False;
            SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível enviar Email com boleto, uBoletos -> '+E.Message);
         end;
      end;
   finally
      QueParam.Close;
      FreeAndNil(QueParam);
   end;
end;

procedure EnviaEmail(recMailDest:String);
var
   SL:TStringList;
begin
   SL := TStringList.Create;
   try
      SL.Add('Olá,');
      SL.Add('Nosso Boleto segue em anexo');
      FACBrBoleto.EnviarEmail(recMailDest,'Teste de Envio de Email', SL, True);
   finally
      SL.Free;
   end;
end;

function retTipoCobranca(NumeroBanco: Integer; Carteira: String = ''):TACBrTipoCobranca;
begin
   case NumeroBanco of
     001: Result := cobBancoDoBrasil;
     003: Result := cobBancoDaAmazonia;
     004: Result := cobBancoDoNordeste;
     008,033,353: Result := cobSantander;
     021: Result := cobBanestes;
     025: Result := cobBancoAlfa;
     041: Result := cobBanrisul;
     047: Result := cobBanese;
     070: Result := cobBRB;
     077: Result := cobBancoInter;
     084: Result := cobUniprimeNortePR;
     085: Result := cobBancoCECRED;
     091: Result := cobUnicredRS;
     097: Result := cobCrediSIS;
     099: Result := cobUniprime;
     104: Result := cobCaixaEconomica;
     107: Result := cobBancoBocomBBM;
     133: Result := cobBancoCresol;
     136: Result := cobUnicredES;
     174: Result := cobBancoPefisa;
     208: Result := cobBTGPactual;
     212: Result := cobBancoOriginal;
     218: Result := cobBS2;
     224: Result := cobBancoFibra;
     237: Result := cobBradesco;
     246: Result := cobBancoABCBrasil;
     274: Result := cobMoneyPlus;
     329: Result := cobBancoQITechSCD;
     336: Result := cobBancoC6;
     341: Result := cobItau;
     389: Result := cobBancoMercantil;
     399: Result := cobHSBC;
     403: Result := cobBancoCora;
     422: Result := cobBancoSafra;
     457: Result := cobBancoUY3;
     604: Result := cobBancoIndustrialBrasil;
     633: Result := cobBancoRendimento;
     637: begin
            if StrToInt(Carteira) = 109 then
                 Result := cobBancoSofisaItau
            else Result := cobBancoSofisaSantander;
          end;
     643: begin
            if StrToInt(Carteira) = 9 then
                 Result := cobBancoPineBradesco
            else Result := cobBancoPine;
          end;
     655: Result := cobBancoVotorantim;
     707: Result := cobDaycoval;
     745: Result := cobCitiBank;
     748: Result := cobSicred;
     756: Result := cobBancoob;
   else
      raise Exception.Create('Erro ao configurar o tipo de cobrança.'+sLineBreak+'Número do Banco inválido: '+IntToStr(NumeroBanco));
   end;
end;

end.
