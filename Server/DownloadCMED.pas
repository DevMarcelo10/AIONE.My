unit DownloadCMED;

interface

uses
  Windows, Classes, Dialogs, ShellAPI, IdHTTP, IdSSLOpenSSL, Variants, ComObj,
  StrUtils, ShlObj, ActiveX, MarcFMX, System.SysUtils, Vcl.Forms, UnitTypes,
  System.Generics.Collections, FireDAC.Comp.Client, System.Types, Registry,
  System.Net.HttpClient, Vcl.Controls, Vcl.ComCtrls, SHDocVw, MSHTML;

  function GetXLSLink:String;
  function GetLastUpdated(const FilePath:String):TDateTime;
  function DownXlsCMED(recPasta:String; out Registros:TList<TRegistro>):Boolean;
  function AtuServerCMED(Registros: TList<TRegistro>):Boolean;

var
  NomeArqXLS:String;

implementation

uses uDWServer,uDM;

// ---------- Verifica a Última Versão Disponível do Site da CMED ---------- //
function GetLastUpdated(const FilePath:String):TDateTime;
var
   i,j:Integer;
   Found:Boolean;
   DateStr, TimeStr,DateTimeStr:String;
   ExcelApp,Workbook,Worksheet,CellValue:Variant;
begin
   Result   := 0;
   ExcelApp := CreateOleObject('Excel.Application');
   try
      ExcelApp.Visible := False;
      Workbook := ExcelApp.Workbooks.Open(FilePath);
      try
         Found := False;
         for i := 1 to Workbook.Worksheets.Count do
         begin
            Worksheet := Workbook.Worksheets[i];
            for j := 1 to Worksheet.UsedRange.Rows.Count do
            begin
               CellValue := Worksheet.Cells[j, 1].Value;
               if VarIsStr(CellValue) and (Pos('Publicada em', CellValue) > 0) then
               begin
                  Found := True;
                  Break;
               end; //if
            end; //for
            if Found then Break;
         end; //for

         if Found then
         begin
            CellValue := Trim(CellValue);
            DateStr := Copy(CellValue, Pos('em', CellValue) + 3, 10);
            TimeStr := Copy(CellValue, Pos('às', CellValue) + 3, 7);
            DateTimeStr := DateStr + ' ' + TimeStr;
            Result := StrToDateTime(DateTimeStr);
         end;
      finally
         Workbook.Close(False);
      end; //try
   finally
     ExcelApp.Quit;
   end; //try
end;

function ExtractXLSLink(const HTMLContent: string): string;
var
   StartPos,EndPos:Integer;
begin
   Result := '';
   StartPos := Pos('class="govbr-card-content"', HTMLContent);
   while StartPos > 0 do
   begin
      StartPos := PosEx('href="', HTMLContent, StartPos);
      if StartPos > 0 then
      begin
         Inc(StartPos, 6);
         EndPos := PosEx('"', HTMLContent, StartPos);
         if EndPos > 0 then
         begin
            Result := Copy(HTMLContent, StartPos, EndPos - StartPos);
            if ContainsStr(Result, '.xls') then
                 Exit(Result)
            else Result := '';
         end;
      end; //if
      StartPos := PosEx('class="govbr-card-content"', HTMLContent, EndPos);
   end;
end;

// ---------- Retorna Apenas o Nome do XLS CMED Disponivel no Site ---------- //
function GetXLSLink:String;
var
   IdHTTP:TIdHTTP;
   HTMLContent:String;
   IdSSLHandler:TIdSSLIOHandlerSocketOpenSSL;
begin
   Result := '';
   IdHTTP := TIdHTTP.Create(nil);
   IdSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
   try
      IdHTTP.IOHandler := IdSSLHandler;
      IdSSLHandler.SSLOptions.Method := sslvTLSv1_2;
      IdSSLHandler.SSLOptions.Mode   := sslmClient;
      HTMLContent := IdHTTP.Get('https://www.gov.br/anvisa/pt-br/assuntos/medicamentos/cmed/precos');
      Result := ExtractXLSLink(HTMLContent);
      if Result <> '' then
      begin
         if Pos('http', Result) <> 1 then
         Result := 'https://www.gov.br' + Result;
      end
      else SalvaLog(ArqLog,'IAServer - ERRO: Não foi possível encontrar o link CMED para download do arquivo XLS.');
   finally
      IdHTTP.Free;
      IdSSLHandler.Free;
   end;
end;

function FormatarStrReais(const valor:String; recFormSQL:Boolean = False):String;
begin
   Result := valor.Trim;
   Result := EliminaCaracteres(Result,'*');
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

// ----------------- Faz o Download do XML da CMED ------------- //
function DownXlsCMED(recPasta:String; out Registros:TList<TRegistro>):Boolean;
var
   Doc    : IHTMLDocument2;
   Anchor : IHTMLAnchorElement;
   Web    : TWebBrowser;
   Http   : THTTPClient;
   Index  : Integer;
   mArq   : TMemoryStream;
   Excel  : OleVariant;
   AbaXLS : OleVariant;
   Linhas : Integer;
   Row    : Integer;
   FForm  : TForm;
   Registro  : TRegistro;
   FileName, Caminho, FUrlArqCmed, PathArqCMED, auxTipPro, auxTipoLista, auxRegPreco : String;

   function CellStr(ARow, ACol: Integer): string;
   begin
      Result := Trim(VarToStr(Excel.Cells.Item[ARow, ACol].Value));
   end;
begin
   Result := False;
   Registros := TList<TRegistro>.Create;

   // 1) Achar o link da planilha CMED na página da ANVISA
   try
      try
         FForm := TForm.Create(nil);
         FForm.BorderStyle := bsNone;
         FForm.Position    := poDesigned;
         FForm.Left        := -20000;
         FForm.Top         := -20000;
         FForm.Width       := 0;
         FForm.Height      := 0;
         FForm.HandleNeeded;

         Web := TWebBrowser.Create(FForm);  // use o form como Owner
         Web.Align   := alClient;
         Web.Silent  := True;
         Web.Visible := False;
         Web.HandleNeeded;

         Web.Navigate('https://www.gov.br/anvisa/pt-br/assuntos/medicamentos/cmed/precos');

         while Web.ReadyState <> READYSTATE_COMPLETE do Application.ProcessMessages;

         Doc := Web.Document as IHTMLDocument2;
         FUrlArqCmed := '';

         for Index := 0 to Doc.all.length - 1 do
         begin
            if Supports(Doc.all.item(Index, 0), IHTMLAnchorElement, Anchor) then
            begin
               // Ajuste este filtro se a Anvisa mudar o padrão do link
               if (Pos('.xls', LowerCase(Anchor.href)) > 0) or (Pos('.xlsx', LowerCase(Anchor.href)) > 0) then
               begin
                  if Pos('@download', LowerCase(Anchor.href)) > 0 then
                  begin
                     FUrlArqCmed := Anchor.href;
                     Break;
                  end;
               end;  //if
            end;
         end; //for

         if FUrlArqCmed = '' then
            raise Exception.Create('Não foi possível localizar o link da planilha CMED na página.');

         // 2) Baixar o arquivo (xls/xlsx) para a pasta indicada
         Http := THTTPClient.Create;
         mArq := TMemoryStream.Create;
         try
            Http.Get(FUrlArqCmed, mArq);
            PathArqCMED := ExtractFilePath(Application.ExeName)+'CMED';
            if not DirectoryExists(PathArqCMED) then ForceDirectories(PathArqCMED);
            FileName := 'CMED.xlsx'; // fallback
            Caminho := IncludeTrailingPathDelimiter(PathArqCMED) + FileName;
            if FileExists(Caminho) then DeleteFile(Caminho);
            mArq.SaveToFile(Caminho);
         finally
            mArq.Free;
            Http.Free;
         end;

         // 3) Abrir no Excel e ler as linhas
         Excel := Unassigned;
         Excel := CreateOleObject('Excel.Application');
         Excel.Visible := False;
         Excel.WorkBooks.Open(Caminho);
         Excel.WorkSheets[1].Activate;
         AbaXLS := Excel.Workbooks[1].WorkSheets[1];
         Linhas := Excel.Cells.SpecialCells(11).Row;
         Registros.Clear;

         for Row := 2 to Linhas do
         begin
            if (CellStr(Row,9) <> '') and (CellStr(Row,9).Trim.ToUpper <> 'PRODUTO') then  // Coluna 9 = Produto (se estiver vazia, ignora a linha)
            begin
               auxTipPro := '';
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'G' then auxTipPro := 'G' else   // Genérico
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'S' then auxTipPro := 'S' else   // Similar
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'F' then auxTipPro := 'F' else   // Fitoterápico
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'N' then auxTipPro := 'N' else   // Novo
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'B' then auxTipPro := 'B' else   // Biológico
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'E' then auxTipPro := 'E' else   // Específico
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'P' then auxTipPro := 'A' else   // Produto de Terapia Avançada
               if UpperCase(Copy(CellStr(Row, 12),1,1)) = 'O' then auxTipPro := 'O';       // Outros

               auxTipoLista := '';
               if UTF8Encode(CellStr(Row, 71)) = 'Positiva' then auxTipoLista := 'P' else
               if UTF8Encode(CellStr(Row, 71)) = 'Negativa' then auxTipoLista := 'N' else
               if UTF8Encode(CellStr(Row, 71)) = 'Neutra'   then auxTipoLista := 'E';
               auxRegPreco  := Copy(UTF8Encode(CellStr(Row, 13)),1,1);

               Registro := TRegistro.Create;
               Registro.EAN1 := OnlyNumbers(CellStr(Row, 6));  // CodEAN1,
               Registro.EAN2 := OnlyNumbers(CellStr(Row, 7));  // CodEAN2,
               Registro.EAN3 := OnlyNumbers(CellStr(Row, 8));  // CodEAN3,
               if Registro.EAN1.Trim = '' then
               begin
                  Registro.EAN1 := Registro.EAN2;
                  Registro.EAN2 := Registro.EAN3;
                  Registro.EAN3 := '';
               end;
               Registro.Substancia  := UTF8Encode(CellStr(Row, 1));   // DesSubs,
               Registro.CNPJ        := OnlyNumbers(CellStr(Row,2));   // CNPJlab,
               Registro.Laboratorio := UTF8Encode(CellStr(Row, 3));   // NomLab,
               Registro.CodigoGREM  := UTF8Encode(CellStr(Row, 4));   // CodGGREM
               Registro.Registro    := UTF8Encode(CellStr(Row, 5));   // RegistroMS,
               Registro.Produto     := UTF8Encode(CellStr(Row, 9));   // Despro,
               Registro.Apresenta   := UTF8Encode(CellStr(Row,10));   // Aprpro,
               Registro.ClasTerap   := UTF8Encode(CellStr(Row,11));   // ClasTerap,
               Registro.TipoProd    := auxTipPro;                     // TipoPro,
               Registro.RegimePre   := auxRegPreco;                   // RegPreco,

               Registro.PreFabSImp  := CellStr(Row, 14);   // PF Sem Impostos
               Registro.PreFab00    := CellStr(Row, 15);   // PF 0%
               Registro.PreFab12    := CellStr(Row, 16);   // PF 12 %
               Registro.PreFabALC12 := CellStr(Row, 17);   // PF 12 % ALC
               Registro.PreFab17    := CellStr(Row, 18);   // PF 17 %
               Registro.PreFabALC17 := CellStr(Row, 19);   // PF 17 % ALC
               Registro.PreFab175   := CellStr(Row, 20);   // PF 17,5 %
               Registro.PreFabALC175:= CellStr(Row, 21);   // PF 17,5 % ALC
               Registro.PreFab18    := CellStr(Row, 22);   // PF 18 %
               Registro.PreFabALC18 := CellStr(Row, 23);   // PF 18 % ALC
               Registro.PreFab19    := CellStr(Row, 24);   // PF 19 %
               Registro.PreFabALC19 := CellStr(Row, 25);   // PF 19 %  ALC
               Registro.PreFab195   := CellStr(Row, 26);   // PF 19,5 %
               Registro.PreFabALC195:= CellStr(Row, 27);   // PF 19,5 %  ALC
               Registro.PreFab20    := CellStr(Row, 28);   // PF 20 %
               Registro.PreFabALC20 := CellStr(Row, 29);   // PF 20 %  ALC
               Registro.PreFab205   := CellStr(Row, 30);   // PF 20,5 %
               Registro.PreFabALC205:= CellStr(Row, 31);   // PF 20,5 % ALC
               Registro.PreFab21    := CellStr(Row, 32);   // PF 21 %
               Registro.PreFabALC21 := CellStr(Row, 33);   // PF 21 %  ALC
               Registro.PreFab22    := CellStr(Row, 34);   // PF 22 %
               Registro.PreFabALC22 := CellStr(Row, 35);   // PF 22 %  ALC
               Registro.PreFab225   := CellStr(Row, 36);   // PF 22,5 %
               Registro.PreFabALC225:= CellStr(Row, 37);   // PF 22,5 % ALC
               Registro.PreFab23    := CellStr(Row, 38);   // PF 23 %
               Registro.PreFabALC23 := CellStr(Row, 39);   // PF 23 %  ALC
               Registro.PrePMCSImp  := CellStr(Row, 40);   // PMC Sem Imposto
               Registro.PrePMC00    := CellStr(Row, 41);   // PMC 0 %
               Registro.PrePMC12    := CellStr(Row, 42);   // PMC 12 %
               Registro.PrePMCALC12 := CellStr(Row, 43);   // PMC 12 %  ALC
               Registro.PrePMC17    := CellStr(Row, 44);   // PMC 17 %
               Registro.PrePMCALC17 := CellStr(Row, 45);   // PMC 17 %  ALC
               Registro.PrePMC175   := CellStr(Row, 46);   // PMC 17,5 %
               Registro.PrePMCALC175:= CellStr(Row, 47);   // PMC 17,5 %  ALC
               Registro.PrePMC18    := CellStr(Row, 48);   // PMC 18 %
               Registro.PrePMCALC18 := CellStr(Row, 49);   // PMC 18 %  ALC
               Registro.PrePMC19    := CellStr(Row, 50);   // PMC 19 %
               Registro.PrePMCALC19 := CellStr(Row, 51);   // PMC 19 %  ALC
               Registro.PrePMC195   := CellStr(Row, 52);   // PMC 19,5 %
               Registro.PrePMCALC195:= CellStr(Row, 53);   // PMC 19,5 %  ALC
               Registro.PrePMC20    := CellStr(Row, 54);   // PMC 20 %
               Registro.PrePMC205   := CellStr(Row, 55);   // PMC 20 %  ALC
               Registro.PrePMCALC205:= CellStr(Row, 56);   // PMC 20,5 %
               Registro.PrePMCALC20 := CellStr(Row, 57);   // PMC 20,5 %  ALC
               Registro.PrePMC21    := CellStr(Row, 58);   // PMC 21 %
               Registro.PrePMCALC21 := CellStr(Row, 59);   // PMC 21 %  ALC
               Registro.PrePMC22    := CellStr(Row, 60);   // PMC 22 %
               Registro.PrePMCALC22 := CellStr(Row, 61);   // PMC 22 %  ALC
               Registro.PrePMC225   := CellStr(Row, 62);   // PMC 22,5 %
               Registro.PrePMCALC225:= CellStr(Row, 63);   // PMC 22,5 %  ALC
               Registro.PrePMC23    := CellStr(Row, 64);   // PMC 23 %
               Registro.PrePMCALC23 := CellStr(Row, 65);   // PMC 23 %  ALC

               Registro.RestHosp    := UTF8Encode(CellStr(Row, 66));  // IndRestHos,
               Registro.CAP         := UTF8Encode(CellStr(Row, 67));  // IndCAP,
               Registro.ICMSZer     := UTF8Encode(CellStr(Row, 69));  // IndICMSZer,
               Registro.ListCreTrib := auxTipoLista;                  // TipoLista,
               Registro.Tarja       := EliminaCaracteres(UTF8Encode(CellStr(Row,73)),'-(*)');  // Tarja
               Registros.Add(Registro);
            end; //if
         end; //for

         Result := True;
      except
         on E: Exception do
         begin
            SalvaLog(ArqLog,'IASERVER - [ERRO] Erro ao atualizar tabela arqcmed (function DownXlsCMED): '+E.Message);
            Registros.Free;
            Registros := nil;
         end;
      end;
   finally
      Web.Free;
      FForm.Free;
      if not VarIsEmpty(Excel) then
      begin
         Excel.Quit;
         Excel := Unassigned;
      end;
   end;
end;

// ----------- Atualiza a Tabela CMED (arqcmed) que está no Servidor dbaione -------
function AtuServerCMED(Registros: TList<TRegistro>):Boolean;
var
   I,acReg:Integer;
   Registro: TRegistro;
   Campos,auxDUP:String;
   locServer: TDMServer;
   LisSubs:TStringDynArray;
   QueIncl,QueSubs:TFDQuery;
begin
   Result := False;
   Campos :=
      'CNPJlab,'+
      'NomLab,'+
      'CodGGREM,'+
      'RegistroMS,'+
      'CodEAN,'+
      'CodEAN2,'+
      'CodEAN3,'+
      'Despro,'+
      'Aprpro,'+
      'ClasTerap,'+
      'TipoPro,'+
      'RegPreco,'+
      'IndICMSZer,'+
      'TipoLista,'+
      'Tarja,'+
      'DesSubs,'+
      'IndRestHos,'+
      'IndCAP,' +
      'PreFabSImp,'+
      'PreFab00,'+
      'PreFab12,'+
      'PreFabALC12,'+
      'PreFab17,'+
      'PreFabALC17,'+
      'PreFab175,'+
      'PreFabALC175,'+
      'PreFab18,'+
      'PreFabALC18,'+
      'PreFab19,'+
      'PreFabALC19,'+
      'PreFab195,'+
      'PreFabALC195,'+
      'PreFab20,'+
      'PreFabALC20,'+
      'PreFab205,'+
      'PreFabALC205,'+
      'PreFab21,'+
      'PreFabALC21,'+
      'PreFab22,'+
      'PreFabALC22,'+
      'PreFab225,'+
      'PreFabALC225,'+
      'PrePMCSImp,'+
      'PrePMC00,'+
      'PreFab23,'+
      'PreFabALC23,'+
      'PrePMC12,'+
      'PrePMCALC12,'+
      'PrePMC17,'+
      'PrePMCALC17,'+
      'PrePMC175,'+
      'PrePMCALC175,'+
      'PrePMC18,'+
      'PrePMCALC18,'+
      'PrePMC19,'+
      'PrePMCALC19,'+
      'PrePMC195,'+
      'PrePMCALC195,'+
      'PrePMC20,'+
      'PrePMC205,'+
      'PrePMCALC205,'+
      'PrePMCALC20,'+
      'PrePMC21,'+
      'PrePMCALC21,'+
      'PrePMC22,'+
      'PrePMCALC22,'+
      'PrePMC225,'+
      'PrePMCALC225,'+
      'PrePMC23,'+
      'PrePMCALC23';

   auxDUP := 'ON DUPLICATE KEY UPDATE '+
      'CNPJlab      = VALUES(CNPJlab),'+
      'NomLab       = VALUES(NomLab),'+
      'CodGGREM     = VALUES(CodGGREM),'+
      'RegistroMS   = VALUES(RegistroMS),'+
      'CodEAN       = VALUES(CodEAN),'+
      'CodEAN2      = VALUES(CodEAN2),'+
      'CodEAN3      = VALUES(CodEAN3),'+
      'Despro       = VALUES(Despro),'+
      'Aprpro       = VALUES(Aprpro),'+
      'ClasTerap    = VALUES(ClasTerap),'+
      'TipoPro      = VALUES(TipoPro),'+
      'RegPreco     = VALUES(RegPreco),'+
      'IndICMSZer   = VALUES(IndICMSZer),'+
      'TipoLista    = VALUES(TipoLista),'+
      'Tarja        = VALUES(Tarja),'+
      'DesSubs      = VALUES(DesSubs),'+
      'IndRestHos   = VALUES(IndRestHos),'+
      'IndCAP       = VALUES(IndCAP),'+
      'PreFabSImp   = VALUES(PreFabSImp),'+
      'PreFab00     = VALUES(PreFab00),'+
      'PreFab12     = VALUES(PreFab12),'+
      'PreFabALC12  = VALUES(PreFabALC12),'+
      'PreFab17     = VALUES(PreFab17),'+
      'PreFabALC17  = VALUES(PreFabALC17),'+
      'PreFab175    = VALUES(PreFab175),'+
      'PreFabALC175 = VALUES(PreFabALC175),'+
      'PreFab18     = VALUES(PreFab18),'+
      'PreFabALC18  = VALUES(PreFabALC18),'+
      'PreFab19     = VALUES(PreFab19),'+
      'PreFabALC19  = VALUES(PreFabALC19),'+
      'PreFab195    = VALUES(PreFab195),'+
      'PreFabALC195 = VALUES(PreFabALC195),'+
      'PreFab20     = VALUES(PreFab20),'+
      'PreFabALC20  = VALUES(PreFabALC20 ),'+
      'PreFab205    = VALUES(PreFab205),'+
      'PreFabALC205 = VALUES(PreFabALC205),'+
      'PreFab21     = VALUES(PreFab21),'+
      'PreFabALC21  = VALUES(PreFabALC21 ),'+
      'PreFab22     = VALUES(PreFab22),'+
      'PreFabALC22  = VALUES(PreFabALC22 ),'+
      'PreFab225    = VALUES(PreFab225),'+
      'PreFabALC225 = VALUES(PreFabALC225),'+
      'PrePMCSImp   = VALUES(PrePMCSImp),'+
      'PrePMC00     = VALUES(PrePMC00),'+
      'PreFab23     = VALUES(PreFab23),'+
      'PreFabALC23  = VALUES(PreFabALC23),'+
      'PrePMC12     = VALUES(PrePMC12),'+
      'PrePMCALC12  = VALUES(PrePMCALC12),'+
      'PrePMC17     = VALUES(PrePMC17),'+
      'PrePMCALC17  = VALUES(PrePMCALC17),'+
      'PrePMC175    = VALUES(PrePMC175),'+
      'PrePMCALC175 = VALUES(PrePMCALC175),'+
      'PrePMC18     = VALUES(PrePMC18),'+
      'PrePMCALC18  = VALUES(PrePMCALC18),'+
      'PrePMC19     = VALUES(PrePMC19),'+
      'PrePMCALC19  = VALUES(PrePMCALC19),'+
      'PrePMC195    = VALUES(PrePMC195),'+
      'PrePMCALC195 = VALUES(PrePMCALC195),'+
      'PrePMC20     = VALUES(PrePMC20),'+
      'PrePMC205    = VALUES(PrePMC205),'+
      'PrePMCALC205 = VALUES(PrePMCALC205),'+
      'PrePMCALC20  = VALUES(PrePMCALC20),'+
      'PrePMC21     = VALUES(PrePMC21),'+
      'PrePMCALC21  = VALUES(PrePMCALC21),'+
      'PrePMC22     = VALUES(PrePMC22),'+
      'PrePMCALC22  = VALUES(PrePMCALC22),'+
      'PrePMC225    = VALUES(PrePMC225),'+
      'PrePMCALC225 = VALUES(PrePMCALC225),'+
      'PrePMC23     = VALUES(PrePMC23),'+
      'PrePMCALC23  = VALUES(PrePMCALC23)';

   locServer := TDMServer.Create(nil);
   QueIncl   := TFDQuery.Create(nil);
   QueSubs   := TFDQuery.Create(nil);
   QueIncl.Connection := locServer.FDConnect;
   QueSubs.Connection := locServer.FDConnect;
   QueSubs.SQL.Clear;
   QueIncl.SQL.Clear;
   try
      if Assigned(Registros) then
      begin
         acReg := 0;
         QueIncl.SQL.Text := 'INSERT INTO arqcmed ('+Campos+') VALUES ';
         for Registro in Registros do
         begin
            with Registro do
            begin
               QueIncl.SQL.Add('('+
               Aspas(CNPJ)+','+                     // CNPJlab,
               Aspas(Laboratorio)+','+              // NomLab,
               Aspas(CodigoGREM)+','+               // CodGGREM,
               Aspas(Registro)+','+                 // RegistroMS,
               Aspas(EAN1)+','+                     // CodEAN,
               Aspas(EAN2)+','+                     // CodEAN2,
               Aspas(EAN3)+','+                     // CodEAN3,
               Aspas(Produto)+','+                  // Despro,
               Aspas(Apresenta)+','+                // Aprpro,
               Aspas(ClasTerap)+','+                // ClasTerap,
               Aspas(TipoProd)+','+                 // TipoPro,
               Aspas(RegimePre)+','+                // RegPreco,
               iif(ICMSZer  = 'Sim','1','0')+','+   // IndICMSZer,
               Aspas(ListCreTrib)+','+              // TipoLista,
               Aspas(Copy(Tarja.Trim,1,30))+','+    // Tarja
               Aspas(Substancia.Trim)+','+          // Substância
               iif(RestHosp = 'Sim','1','0')+','+   // IndRestHos,
               iif(CAP      = 'Sim','1','0')+','+   // IndCAP,
               FormatarStrReais(PreFabSImp  )+','+
               FormatarStrReais(PreFab00    )+','+
               FormatarStrReais(PreFab12    )+','+
               FormatarStrReais(PreFabALC12 )+','+
               FormatarStrReais(PreFab17    )+','+
               FormatarStrReais(PreFabALC17 )+','+
               FormatarStrReais(PreFab175   )+','+
               FormatarStrReais(PreFabALC175)+','+
               FormatarStrReais(PreFab18    )+','+
               FormatarStrReais(PreFabALC18 )+','+
               FormatarStrReais(PreFab19    )+','+
               FormatarStrReais(PreFabALC19 )+','+
               FormatarStrReais(PreFab195   )+','+
               FormatarStrReais(PreFabALC195)+','+
               FormatarStrReais(PreFab20    )+','+
               FormatarStrReais(PreFabALC20 )+','+
               FormatarStrReais(PreFab205   )+','+
               FormatarStrReais(PreFabALC205)+','+
               FormatarStrReais(PreFab21    )+','+
               FormatarStrReais(PreFabALC21 )+','+
               FormatarStrReais(PreFab22    )+','+
               FormatarStrReais(PreFabALC22 )+','+
               FormatarStrReais(PreFab225   )+','+
               FormatarStrReais(PreFabALC225)+','+
               FormatarStrReais(PrePMCSImp  )+','+
               FormatarStrReais(PrePMC00    )+','+
               FormatarStrReais(PreFab23    )+','+
               FormatarStrReais(PreFabALC23 )+','+
               FormatarStrReais(PrePMC12    )+','+
               FormatarStrReais(PrePMCALC12 )+','+
               FormatarStrReais(PrePMC17    )+','+
               FormatarStrReais(PrePMCALC17 )+','+
               FormatarStrReais(PrePMC175   )+','+
               FormatarStrReais(PrePMCALC175)+','+
               FormatarStrReais(PrePMC18    )+','+
               FormatarStrReais(PrePMCALC18 )+','+
               FormatarStrReais(PrePMC19    )+','+
               FormatarStrReais(PrePMCALC19 )+','+
               FormatarStrReais(PrePMC195   )+','+
               FormatarStrReais(PrePMCALC195)+','+
               FormatarStrReais(PrePMC20    )+','+
               FormatarStrReais(PrePMC205   )+','+
               FormatarStrReais(PrePMCALC205)+','+
               FormatarStrReais(PrePMCALC20 )+','+
               FormatarStrReais(PrePMC21    )+','+
               FormatarStrReais(PrePMCALC21 )+','+
               FormatarStrReais(PrePMC22    )+','+
               FormatarStrReais(PrePMCALC22 )+','+
               FormatarStrReais(PrePMC225   )+','+
               FormatarStrReais(PrePMCALC225)+','+
               FormatarStrReais(PrePMC23    )+','+
               FormatarStrReais(PrePMCALC23 )+'),');

               // ------ Gera Registro no arqsubscmed (molécula) ------ //
               LisSubs := SplitString(Trim(Substancia),';');
               if Length(LisSubs) > 0 then
               begin
                  for I := 0 to Length(LisSubs)-1 do
                  begin
                     QueSubs.SQL.Add('INSERT INTO arqsubscmed (DesSubs, IndControle) '+
                     'SELECT '+Aspas(LisSubs[I])+', CASE WHEN INSTR('+Aspas(Tarja)+', '+Aspas('Preta')+') > 0 THEN TRUE ELSE FALSE END '+
                     'FROM dual WHERE NOT EXISTS (SELECT 1 FROM arqsubscmed WHERE DesSubs = '+Aspas(LisSubs[I])+') LIMIT 1;');
                  end; //for
               end; //if
            end; //with

            Inc(acReg);
            if acReg > 49 then
            begin
               try
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' '+auxDUP;
                  QueIncl.ExecSQL;
                  QueIncl.SQL.Text := 'INSERT INTO arqcmed ('+Campos+') VALUES ';
                  if QueSubs.SQL.Text <> '' then QueSubs.ExecSQL;
                  QueSubs.SQL.Clear;
                  acReg := 0;
               except
                  on E: Exception do
                  begin
                     SalvaLog(ArqLog,'IASERVER - [ERRO] tentando atualizar tabelas do arqcmed (AtuServerCMED): '+E.Message+#10+QueIncl.SQL.Text);
                     Exit;
                  end;
               end;
            end; //if
         end; //for

         if acReg > 0 then
         begin
            try
               QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' '+auxDUP;
               QueIncl.ExecSQL;
            except
               on E: Exception do
               begin
                  SalvaLog(ArqLog,'IASERVER - [ERRO] tentando atualizar tabelas do arqcmed (AtuServerCMED): '+E.Message+#10+QueIncl.SQL.Text);
                  Exit;
               end;
            end;
         end; //if
         Result := True;
      end;//if
   finally
      FreeAndNil(QueIncl);
      FreeAndNil(QueSubs);
      locServer.FDConnect.Connected := False;
      FreeAndNil(locServer);
   end;
end;

end.

