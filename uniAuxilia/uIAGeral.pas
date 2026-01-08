unit uIAGeral;

interface

uses System.SysUtils, FireDAC.Comp.Client, Data.DB, uDM, uConst, System.DateUtils,
     Variants, MarcLib, uRESTDWBasicDB, uLibFarm, uPrincipal;

   procedure CriaRegP1(recIDProd:Integer);
   function  CriaRegP2(recIDFilial,recIDProd:Integer):Boolean;
   function  CriaRegP3(recIDFilial,recIDSubs:Integer):Boolean;
   function  Trender(const Valores: array of Double): Double;
   function  Perceptron1(recSVenda,recPVence,recPotEst:Integer; recConPag:Double; recDatIni,recDatFin,recDatVenLot:TDate):TFDMemTable;
   function  Perceptron2(recDatIni:TDate; recIDFilial:Integer):TFDMemTable;
   function  Perceptron3(recDatIni:TDate; recIDFilial:Integer):TFDMemTable;

var
   MemTableIA:TFDMemTable;
   QueProd:TRESTDWClientSQL;

implementation

function Perceptron1(recSVenda,recPVence,recPotEst:Integer; recConPag:Double; recDatIni,recDatFin,recDatVenLot:TDate):TFDMemTable;
{recSVenda : Número de dias sem vendas para análise
 recPVence : Número de dias futuros de estoque de produtos à vencer
 recPotEst : Número de dias futuros de estoque necessário para vendas previstas
 recConPag : Total das despesas fixas e variadas do periodo
 recDatIni : Data início para Geração
 recDatFin : Data final  para Geração }
var
   auxMarkup:Double;
   QueAuxi:TRESTDWClientSQL;
   FieldDef:TFieldDef;
   I,Dias,auxN:Integer;
   DataIni,DataFin:String;
begin
   Result := nil;
   MemTableIA := TFDMemTable.Create(nil);
   QueAuxi    := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   try
      with MemTableIA do
      begin
         FieldDefs.Add('IDProd',    ftInteger);
         FieldDefs.Add('SemVenNDia',ftBoolean);   // Indica produto sem vendas à mais de N dias          -> recSVenda
         FieldDefs.Add('QtdEstAlto',  ftFloat);   // Estoque ultrapassa necessidade dos próximos N dias  -> recPotEst
         FieldDefs.Add('QtdVencendo', ftFloat);   // Com vencimento nos proximos N dias                  -> recPVence
         FieldDefs.Add('GiroTotal',   ftFloat);   // Quantas Vezes o Estoque Foi Vendido e Reposto       -> recSVenda
         FieldDefs.Add('QtdEstoque',  ftFloat);   // Estoque Atual
         FieldDefs.Add('PerLucReal',  ftFloat);   // Percentual Médio de Lucro Bruto Real
         FieldDefs.Add('MarkupProd',  ftFloat);   // Markup Esperado do Produto
         FieldDefs.Add('PrevVenPer',  ftFloat);   // Previsão de Vendas do Produto durante os dias de promoção (À FAZER)
         FieldDefs.Add('EstSeguro',   ftFloat);   // Estoque de Segurança
         IndexFieldNames := 'IDProd';
         FieldDefs.Update;
         CreateDataSet;
         Open;
      end; //with;

      DataIni := Aspas(FormatDateTime('yyyy-mm-dd',recDatIni));
      DataFin := Aspas(FormatDateTime('yyyy-mm-dd',recDatFin));

      with QueAuxi do
      begin
          //MsgWait('IA verificando rupturas de estoque...',FrmPrincipal);
          //.... Produtos Sem Vendas à N. Dias ...//
          SQL.Text :=
          'SELECT LOT.IDProd FROM arqprodutolot LOT LEFT JOIN (SELECT ITE.IDProd FROM arqpedidoite ITE JOIN arqpedido '+
          'PED ON ITE.IDPed = PED.IDPed WHERE PED.Datped >= '+DataIni+' - INTERVAL '+recSVenda.ToString+' DAY GROUP BY ITE.IDProd) '+
          'Ult_Venda ON LOT.IDProd = Ult_Venda.IDProd WHERE Ult_Venda.IDProd IS NULL GROUP BY LOT.IDProd HAVING SUM(LOT.Qtdest) > 0';
          QueAuxi.Open;
          while not Eof do
          begin
             CriaRegP1(FieldByName('IDProd').AsInteger);
             MemTableIA.FieldByName('SemVenNDia').AsBoolean := True;
             MemTableIA.Post;
             Next;
          end; //while

          //MsgWait('IA analisando riscos de perdas...',FrmPrincipal);
          //.... Produtos Vencendo em N. Dias ...//
          QueAuxi.Close;
          SQL.Text := 'SELECT IDProd, SUM(Qtdest) AS QtdVence FROM arqprodutolot WHERE ';
          if recDatVenLot > 1 then
               SQL.Add('Datven BETWEEN '+DataIni+' AND '+DataIni+' + INTERVAL '+recPVence.ToString+' DAY')
          else SQL.Add('Datven <= '+Aspas(FormatDateTime('yyyy-mm-dd',recDatVenLot)));
          SQL.Add(' GROUP BY IDProd HAVING SUM(Qtdest) > 0');
          QueAuxi.Open;
          while not Eof do
          begin
             CriaRegP1(FieldByName('IDProd').AsInteger);
             MemTableIA.FieldByName('QtdVencendo').AsFloat := FieldByName('QtdVence').AsFloat;
             MemTableIA.Post;
             Next;
          end; //while

          //MsgWait('IA analisando potencial de vendas...',FrmPrincipal);
          //.... Calculo Giro de Produtos em N. Dias Anteriores somados ao mesmo Periodo Futuro do Ano Anterior ...//
          QueAuxi.Close;
          SQL.Text :=
          'SELECT v.IDProd, COALESCE(SUM(v.QtdVendida), 0) AS QtdVendidaAtual, COALESCE(SUM(v.QtdVendidaAnoPassado), 0) AS QtdVendidaAnoPassado, '+
          'COALESCE(SUM(e.QtdRecebida), 0) AS QtdRecebidaAtual, COALESCE(SUM(e.QtdRecebidaAnoPassado), 0) AS QtdRecebidaAnoPassado, '+
          'ROUND(COALESCE((SUM(v.QtdVendida) / NULLIF(SUM(e.QtdRecebida), 0)), 0) + COALESCE((SUM(v.QtdVendidaAnoPassado) / NULLIF(SUM(e.QtdRecebidaAnoPassado), 0)), 0),2) AS GiroTotal '+
          'FROM (SELECT a.IDProd, SUM(a.Qtdped) AS QtdVendida, 0 AS QtdVendidaAnoPassado FROM arqpedidoite a JOIN arqpedido b ON a.IDped = b.IDped '+
          'WHERE b.Datped BETWEEN DATE_SUB(CURDATE(), INTERVAL '+recSVenda.ToString+' DAY) AND CURDATE() GROUP BY a.IDProd UNION ALL '+
          'SELECT a.IDProd, 0 AS QtdVendida, SUM(a.Qtdped) AS QtdVendidaAnoPassado FROM arqpedidoite a JOIN arqpedido b ON a.IDped = b.IDped '+
          'WHERE b.Datped BETWEEN DATE_SUB(DATE_SUB(CURDATE(), INTERVAL 1 YEAR), INTERVAL '+recSVenda.ToString+' DAY) AND DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY a.IDProd) v JOIN '+
          '(SELECT c.IDProd, SUM(c.Totrec) AS QtdRecebida, 0 AS QtdRecebidaAnoPassado FROM arqcomprarecite c JOIN arqcomprarec d ON c.IDRec = d.IDRec WHERE '+
          'd.DatRece BETWEEN DATE_SUB(CURDATE(), INTERVAL '+recSVenda.ToString+' DAY) AND CURDATE() GROUP BY c.IDProd UNION ALL '+
          'SELECT c.IDProd, 0 AS QtdRecebida, SUM(c.Totrec) AS QtdRecebidaAnoPassado FROM arqcomprarecite c JOIN arqcomprarec d ON c.IDRec = d.IDRec WHERE '+
          'd.DatRece BETWEEN DATE_SUB(DATE_SUB(CURDATE(), INTERVAL 1 YEAR), INTERVAL '+recSVenda.ToString+' DAY) AND DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY c.IDProd) e '+
          'ON v.IDProd = e.IDProd GROUP BY v.IDProd';
          QueAuxi.Open;
          while not Eof do
          begin
             CriaRegP1(FieldByName('IDProd').AsInteger);
             MemTableIA.FieldByName('GiroTotal').AsFloat := FieldByName('GiroTotal').AsFloat;
             MemTableIA.Post;
             Next;
          end; //while

          //MsgWait('IA verificando nível 2 de rupturas...',FrmPrincipal);
          //------ Produtos P/ Cálculo Estoque Acima Necessidade em "N" Dias (Estoque Muito Alto) ------//
          QueAuxi.Close;
          SQL.Text := 'WITH '+
          //.... Vendas dos últimos N dias
          'UltimosDias AS (SELECT IDProd,AVG(Qtdped) AS MediaVendas FROM arqpedidoite PEI JOIN arqpedido PED ON PEI.IDPed = PED.IDPed '+
          'WHERE PED.Datped BETWEEN '+DataIni+' - INTERVAL '+recPotEst.ToString+' DAY AND '+DataIni+' GROUP BY IDProd), '+
          //-- Vendas do mesmo período do ano passado
          'AnoPasDias AS (SELECT IDProd, AVG(Qtdped) AS MedVenAnoPas FROM arqpedidoite PEI JOIN arqpedido PED ON PEI.IDPed = PED.IDPed '+
          'WHERE PED.Datped BETWEEN '+DataIni+' - INTERVAL 1 YEAR - INTERVAL '+recPotEst.ToString+' DAY AND '+DataIni+' - INTERVAL 1 YEAR GROUP BY IDProd), '+
          //-- Vendas do futuro período no ano passado
          'FutAnoPas AS ('+
          'SELECT IDProd, AVG(Qtdped) AS MedVenFutAnoPas FROM arqpedidoite PEI JOIN arqpedido PED ON PEI.IDPed = PED.IDPed '+
          'WHERE PED.Datped BETWEEN '+DataIni+' - INTERVAL 1 YEAR AND '+DataIni+' - INTERVAL 1 YEAR + INTERVAL '+recPotEst.ToString+' DAY GROUP BY IDProd), '+
          //-- Média combinada com pesos diferentes
          'MedVendas AS (SELECT u.IDProd,(u.MediaVendas * 0.5 + COALESCE(a.MedVenAnoPas, 0) * 0.2 + COALESCE(f.MedVenFutAnoPas, 0) * 0.3) AS MediaDiaria '+
          'FROM UltimosDias u LEFT JOIN AnoPasDias a ON u.IDProd = a.IDProd LEFT JOIN FutAnoPas f ON u.IDProd = f.IDProd), '+
          //-- Estoque total por produto
          'EstAtual AS (SELECT IDProd, SUM(Qtdest) AS QtdEstoque FROM arqprodutolot WHERE Qtdest >= 0 GROUP BY IDProd) '+
          //-- Seleção final comparando estoque com a previsão de vendas
          'SELECT e.IDProd,e.QtdEstoque,m.MediaDiaria,m.MediaDiaria * '+recPotEst.ToString+' AS Previsao '+
          'FROM EstAtual e JOIN MedVendas m ON e.IDProd = m.IDProd WHERE e.QtdEstoque > m.MediaDiaria * '+recPotEst.ToString+' * 1.20 ORDER BY e.IDProd';
          QueAuxi.Open;
          while not Eof do
          begin
             CriaRegP1(FieldByName('IDProd').AsInteger);
             MemTableIA.FieldByName('QtdEstAlto').AsFloat := FieldByName('QtdEstoque').AsFloat;
             MemTableIA.Post;
             Next;
          end; //while

          //MsgWait('IA calculando % descontos ideal...',FrmPrincipal);
          //.... Cálculo da Média de Lucro Bruto Real dos Produtos que têm Estoque ...//
          SQL.Text :=
          'SELECT p.IDProd,ROUND(AVG(pedido.CustoMed), 2) AS MediaCusto,ROUND(AVG(pedido.VlrVenda), 2) AS MediaPrecoVenda, '+
          'ROUND(AVG(pedido.LucroBruto), 2) AS MedLucBru, ROUND(((AVG(pedido.LucroBruto) / total.TotalLucroBruto) * 100) * 100, 2) AS PercentualLucroBruto '+
          'FROM arqproduto p JOIN (SELECT pi.IDProd,SUM(pi.Qtdped * (pi.VlrVenda - ap.CustoMed)) AS LucroBruto,AVG(pi.VlrVenda) AS VlrVenda,AVG(ap.CustoMed) AS CustoMed '+
          'FROM arqpedidoite pi '+
          'JOIN arqpedido a ON pi.IDFilial = a.IDFilial AND pi.IDPed = a.IDPed '+
          'JOIN arqproduto ap ON pi.IDProd = ap.IDProd '+
          'WHERE a.Datped BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE() '+
          'GROUP BY pi.IDProd) AS pedido ON p.IDProd = pedido.IDProd '+
          'JOIN (SELECT IDProd FROM arqprodutolot WHERE IDProd IN (SELECT IDProd FROM arqprodutolot GROUP BY IDProd '+
          'HAVING SUM(Qtdest) > 0) GROUP BY IDProd) AS lot ON p.IDProd = lot.IDProd '+
          'JOIN (SELECT SUM(LucroBruto) AS TotalLucroBruto FROM (SELECT SUM(pi.Qtdped * (pi.VlrVenda - ap.CustoMed)) AS LucroBruto '+
          'FROM arqpedidoite pi '+
          'JOIN arqpedido a ON pi.IDFilial = a.IDFilial AND pi.IDPed = a.IDPed '+
          'JOIN arqproduto ap ON pi.IDProd = ap.IDProd WHERE a.Datped BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE() '+
          'GROUP BY pi.IDProd) AS subquery) AS total GROUP BY p.IDProd HAVING AVG(pedido.LucroBruto) > 0';
          QueAuxi.Open;
          while not Eof do
          begin
             CriaRegP1(FieldByName('IDProd').AsInteger);
             MemTableIA.FieldByName('PerLucReal').AsFloat := RoundX(FieldByName('MedLucBru').AsFloat,2);
             MemTableIA.Post;
             Next;
          end; //while

         //.... Grava Estoque e Markups Desejados em Cada Produto com Estoque ....//
         //MsgWait('IA verificando segurança de descontos...',FrmPrincipal);
         QueAuxi.Close;
         SQL.Text := 'SELECT PRO.IDProd, PRO.Markup AS PRO_Markup, SUM(LOT.Qtdest) AS TotEstoque, '+
         'IFNULL(GRU.Markup,0.00) AS GRU_Markup, IFNULL(SUB.Markup,0) AS SUB_Markup FROM arqprodutolot LOT '+
         'LEFT JOIN arqproduto PRO ON LOT.IDProd = PRO.IDProd LEFT JOIN arqgrupo GRU ON PRO.IDGrupo = GRU.IDGrupo '+
         'LEFT JOIN arqgruposub SUB ON PRO.IDGruSub = SUB.IDGruSub '+iif(recDatVenLot > 1,'WHERE LOT.Datven <= '+Aspas(FormatDateTime('yyyy-mm-dd',recDatVenLot)),'')+' '+
         'GROUP BY LOT.IDProd HAVING SUM(LOT.Qtdest) > 0';
         QueAuxi.Open;
         while not Eof do
         begin
            auxMarkup := 0.00;
            if FieldByName('PRO_Markup').AsFloat > 0.00 then auxMarkup := FieldByName('PRO_Markup').AsFloat else
            if FieldByName('GRU_Markup').AsFloat > 0.00 then auxMarkup := FieldByName('GRU_Markup').AsFloat else
            if FieldByName('SUB_Markup').AsFloat > 0.00 then auxMarkup := FieldByName('SUB_Markup').AsFloat;
            CriaRegP1(FieldByName('IDProd').AsInteger);
            MemTableIA.FieldByName('MarkupProd').AsFloat := auxMarkup;
            MemTableIA.FieldByName('QtdEstoque').AsFloat := FieldByName('TotEstoque').AsFloat;
            MemTableIA.Post;
            Next;
         end; //while
      end; //with
      Result := MemTableIA;
   finally
      //CloseMsgWait;
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;
end;

procedure CriaRegP1(recIDProd:Integer);
begin
   with MemTableIA do
   begin
      if not Locate('IDProd',recIDProd,[]) then
      begin
         Append;
         FieldByName('IDProd').AsInteger     := recIDProd;
         FieldByName('SemVenNDia').AsBoolean := False;
         FieldByName('QtdEstAlto').AsFloat   := 0.00;
         FieldByName('QtdVencendo').AsFloat  := 0.00;
         FieldByName('GiroTotal').AsFloat    := 0.00;
         FieldByName('QtdEstoque').AsFloat   := 0.00;
         FieldByName('PerLucReal').AsFloat   := 0.00;
         FieldByName('MarkupProd').AsFloat   := 0.00;
      end
      else Edit;
   end; //with
end;

// -------------- Rede Neural Compras / Produto -------------- //
function Perceptron2(recDatIni:TDate; recIDFilial:Integer):TFDMemTable;
var
   FieldDef:TFieldDef;
   DataIni,DMinDema:String;
   aQtdVenda: array of Double;
   QueAuxi,QueTens:TRESTDWClientSQL;
   antIDFilial,antIDProd,auxQtdest,acQtdest:Integer;
   Tendencia,auxQtdped,PesoAtu,PesoHis,TotalVen:Double;
begin
   Result := nil;
   MemTableIA := TFDMemTable.Create(nil);
   QueTens := TRESTDWClientSQL.Create(nil);
   QueTens.DataBase := DM.DWDataBase;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueProd := TRESTDWClientSQL.Create(nil);
   QueProd.DataBase := DM.DWDataBase;
   QueProd.SQL.Text := 'SELECT IDProd,IndPedCom,Ativo,PrecoFab FROM arqproduto ORDER BY IDProd';
   try
      QueProd.Open;

      with MemTableIA do
      begin
         FieldDefs.Add('IDFilial', ftInteger);  // ID da Filial
         FieldDefs.Add('IDProd',   ftInteger);  // ID do Produto
         FieldDefs.Add('QtdVAnt',  ftInteger);  // Quantidade vendida em anos anteriores no período solicitado
         FieldDefs.Add('QtdVAtu',  ftInteger);  // Quantidade vendida nos dias atuais
         FieldDefs.Add('EstAtual', ftInteger);  // Estoque atual do Produto
         FieldDefs.Add('QtdCompra',ftInteger);  // Quantidade à Comprar
         FieldDefs.Add('PrecoFab', ftFloat);    // Preço de Fábrica
         IndexFieldNames := 'IDFilial;IDProd';
         FieldDefs.Update;
         CreateDataSet;
         Open;
      end; //with;

      DataIni := FormatDateTime('yyyy-mm-dd',recDatIni);
      QueTens.SQL.Text := 'SELECT Comp_DMinDem,Comp_NivSerRup FROM arqiatensores';
      QueTens.Open;
      DMinDema := QueTens.FieldByName('Comp_DMinDem').AsString;

      with QueAuxi do
      begin
         //..... Agrupa Qtd.Vendas por Sazonalidade Agrupado em 1,2,3 Anos Anteriores ..... //
         SQL.Text :=
         'SET @DataBase  = DATE_ADD('+Aspas(DataIni)+', INTERVAL '+DMinDema+' DAY); '+
         'SET @DataAnte1 = DATE_SUB(@DataBase, INTERVAL 1 YEAR); '+
         'SET @DataAnte2 = DATE_SUB(@DataBase, INTERVAL 2 YEAR); '+
         'SET @DataAnte3 = DATE_SUB(@DataBase, INTERVAL 3 YEAR); '+
         'SELECT YEAR(a.Datven) AS Ano, a.IDFilial, a.IDProd, ROUND(SUM(CASE WHEN '+
            'a.Datven BETWEEN @DataAnte1 AND DATE_ADD(@DataAnte1, INTERVAL '+DMinDema+' DAY) OR '+
            'a.Datven BETWEEN @DataAnte2 AND DATE_ADD(@DataAnte2, INTERVAL '+DMinDema+' DAY) OR '+
            'a.Datven BETWEEN @DataAnte3 AND DATE_ADD(@DataAnte3, INTERVAL '+DMinDema+' DAY) THEN a.Qtdven ELSE 0 END)) AS VenAnoAnt, '+
         'COALESCE(Round(p.Qtdest), 0) AS EstAtual FROM arqvendapordia a '+
         'LEFT JOIN (SELECT IDFilial, IDProd, ROUND(SUM(Qtdest)) AS Qtdest FROM arqprodutolot WHERE Qtdest > 0 '+
         'GROUP BY IDFilial,IDProd) p ON a.IDFilial = p.IDFilial AND a.IDProd = p.IDProd '+
         'WHERE a.Datven BETWEEN DATE_SUB(@DataBase, INTERVAL 3 YEAR) AND @DataBase GROUP BY a.IDFilial,a.IDProd,Ano '+
         'HAVING SUM(CASE WHEN '+
            'a.Datven BETWEEN @DataAnte1 AND DATE_ADD(@DataAnte1, INTERVAL '+DMinDema+' DAY) OR '+
            'a.Datven BETWEEN @DataAnte2 AND DATE_ADD(@DataAnte2, INTERVAL '+DMinDema+' DAY) OR '+
            'a.Datven BETWEEN @DataAnte3 AND DATE_ADD(@DataAnte3, INTERVAL '+DMinDema+' DAY) THEN a.Qtdven ELSE 0 END) '+
         'ORDER BY a.IDFilial,a.IDProd,Ano';
         QueAuxi.Open;

         SetLength(aQtdVenda, 0);
         antIDFilial := FieldByName('IDFilial').AsInteger;
         antIDProd   := FieldByName('IDProd').AsInteger;

         // ..... Análise de Vendas Por Sazonalidade ..... //
         while not Eof do
         begin
            auxQtdest := FieldByName('EstAtual').AsInteger;
            SetLength(aQtdVenda, Length(aQtdVenda) + 1);
            aQtdVenda[High(aQtdVenda)] := FieldByName('VenAnoAnt').AsFloat;
            Next;
            if (antIDProd <> FieldByName('IDProd').AsInteger) or (antIDFilial <> FieldByName('IDFilial').AsInteger) or Eof then
            begin
               if Length(aQtdVenda) > 0 then
               begin
                  if CriaRegP2(FieldByName('IDFilial').AsInteger, FieldByName('IDProd').AsInteger) then
                  begin
                     if Length(aQtdVenda) > 0 then
                     begin
                        Tendencia := Trender(aQtdVenda);
                        if Tendencia <> 0 then
                             auxQtdped := aQtdVenda[High(aQtdVenda)] * (1 + Tendencia / 100)
                        else auxQtdped := aQtdVenda[High(aQtdVenda)];
                        MemTableIA.FieldByName('QtdVAnt').AsInteger  := Round(auxQtdped);
                        MemTableIA.FieldByName('EstAtual').AsInteger := auxQtdest;
                        MemTableIA.Post;
                     end; //if
                  end; //if
               end; //if
               if not Eof then
               begin
                  SetLength(aQtdVenda, 0);
                  antIDFilial := FieldByName('IDFilial').AsInteger;
                  antIDProd   := FieldByName('IDProd').AsInteger;
               end;
            end; //if
         end; //while

         //..... Salva QTD. Vendas Nos Dias Atuais e Estoque Atual ..... //
         QueAuxi.Close;
         SQL.Text := 'SELECT v.IDFilial, v.IDProd,ROUND(v.Qtdven,2) AS QtdVendas, COALESCE(SUM(p.Qtdest), 0) AS EstAtual FROM arqvendapordia v '+
         'LEFT JOIN (SELECT IDFilial, IDProd, ROUND(SUM(Qtdest)) AS Qtdest FROM arqprodutolot WHERE Qtdest > 0 '+
         'GROUP BY IDFilial,IDProd) p ON v.IDFilial = p.IDFilial AND v.IDProd = p.IDProd '+
         'WHERE v.Datven >= CURDATE() - INTERVAL '+DMinDema+' DAY GROUP BY v.IDFilial,v.IDProd';
         QueAuxi.Open;
         while not Eof do
         begin
            if CriaRegP2(FieldByName('IDFilial').AsInteger, FieldByName('IDProd').AsInteger) then
            begin
               MemTableIA.FieldByName('QtdVAtu').AsFloat    := FieldByName('QtdVendas').AsFloat;
               MemTableIA.FieldByName('EstAtual').AsInteger := FieldByName('EstAtual').AsInteger;
               MemTableIA.Post;
            end; //if
            Next;
         end; //while

         // ....... Salva o Tempo Médio Para Entrega de Cada Produto ....... //
         {QueAuxi.Close;
         SQL.Text := 'SELECT a.IDProd, AVG(DATEDIFF(b.Datrec, c.Datped)) AS TemMedEnt FROM arqcompraite a JOIN arqcompra c '+
         'ON a.IDComp = c.IDComp JOIN arqcomprarecite d ON a.IDProd = d.IDProd JOIN arqcomprarec b ON d.IDRec = b.IDRec '+
         'WHERE c.Datped >= DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH) GROUP BY a.IDProd';
         QueAuxi.Open;
         while not Eof do
         begin
            if CriaRegP2(FieldByName('IDProd').AsInteger) then
            begin
               MemTableIA.FieldByName('TempRepo').AsInteger := FieldByName('TemMedEnt').AsInteger;
               MemTableIA.Post;
            end;
            Next;
         end; //while}
      end; //with

      // ..... Calcular Estoque à Comprar ..... //
      with MemTableIA do
      begin
         First;
         while not Eof do
         begin
            Edit;
            TotalVen := FieldByName('QtdVAnt').AsInteger + FieldByName('QtdVAtu').AsInteger;
            if TotalVen > 0 then
            begin
               PesoAtu := FieldByName('QtdVAtu').AsInteger / TotalVen;
               PesoHis := FieldByName('QtdVAnt').AsInteger / TotalVen;
               FieldByName('QtdCompra').AsInteger := Round((FieldByName('QtdVAtu').AsInteger * PesoAtu) + (FieldByName('QtdVAnt').AsInteger * PesoHis));
               Post;
            end; //if
            Next;
         end; //while
      end; //with

            // ....... Verifica se Há pedidos de Compras Já Realizados ....... //
      QueAuxi.Close;
      QueAuxi.SQL.Text := 'SELECT a.IDProd, SUM(Qtdped) AS TotQtdped FROM arqcompraite a JOIN arqcompra c ON a.IDComp = c.IDComp '+
      'WHERE a.Status = "0" AND c.Datped >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH) GROUP BY a.IDProd';
      QueAuxi.Open;
      MemTableIA.IndexFieldNames := 'IDProd;IDFilial';
      while not QueAuxi.Eof do
      begin
         acQtdest := QueAuxi.FieldByName('TotQtdped').AsInteger;
         MemTableIA.First;
         if MemTableIA.Locate('IDProd',QueAuxi.FieldByName('IDProd').AsInteger,[]) then
         begin
            while (acQtdest > 0) and (QueAuxi.FieldByName('IDProd').AsInteger = MemTableIA.FieldByName('IDProd').AsInteger) and (not MemTableIA.Eof) do
            begin
               if acQtdest <= MemTableIA.FieldByName('QtdCompra').AsInteger then
               begin
                  if acQtdest < MemTableIA.FieldByName('QtdCompra').AsInteger then
                  begin
                     MemTableIA.Edit;
                     MemTableIA.FieldByName('QtdCompra').AsInteger := MemTableIA.FieldByName('QtdCompra').AsInteger - acQtdest;
                     MemTableIA.Post;
                  end
                  else MemTableIA.Delete;
                  Break;
               end else
               begin
                  acQtdest := acQtdest - MemTableIA.FieldByName('QtdCompra').AsInteger;
                  MemTableIA.Delete;
                  Continue;
               end; //if
               MemTableIA.Next;
            end; //while
         end; //if
         QueAuxi.Next;
      end; //while
      MemTableIA.IndexFieldNames := 'IDFilial;IDProd';
      MemTableIA.First;

      Result := MemTableIA;
   finally
      QueAuxi.Close;
      QueTens.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueTens);
   end;
end;

function CriaRegP2(recIDFilial,recIDProd:Integer):Boolean;
var
   auxIDSubs:Integer;
   auxPrecoFab:Double;
begin
   Result := False;
   if QueProd.Locate('IDProd',recIDProd,[]) then
   begin
      if (QueProd.FieldByName('Ativo').AsString <> '1') or (QueProd.FieldByName('IndPedCom').AsString <> '1') then Exit;
      auxPrecoFab := QueProd.FieldByName('PrecoFab').AsFloat;
   end
   else Exit;

   with MemTableIA do
   begin
      if not Locate('IDFilial;IDProd',VarArrayOf([recIDFilial,recIDProd]) ,[]) then
      begin
         Append;
         FieldByName('IDFilial').AsInteger  := recIDFilial;
         FieldByName('IDProd').AsInteger    := recIDProd;
         FieldByName('PrecoFab').AsFloat    := auxPrecoFab;
         FieldByName('QtdVAnt').AsInteger   := 0;
         FieldByName('QtdVAtu').AsInteger   := 0;
         FieldByName('EstAtual').AsInteger  := 0;
         FieldByName('QtdCompra').AsInteger := 0;
      end
      else Edit;
   end; //with
   Result := True;
end;

// -------------- Rede Neural Compras / Moléculas -------------- //
function Perceptron3(recDatIni:TDate; recIDFilial:Integer):TFDMemTable;
var
   FieldDef:TFieldDef;
   DataIni,DMinDema:String;
   aQtdVenda: array of Double;
   QueAuxi,QueTens:TRESTDWClientSQL;
   antIDFilial,antIDSubs,auxQtdest:Integer;
   Tendencia,auxQtdped,PesoAtu,PesoHis,TotalVen:Double;
begin
   Result := nil;
   MemTableIA := TFDMemTable.Create(nil);
   QueTens := TRESTDWClientSQL.Create(nil);
   QueTens.DataBase := DM.DWDataBase;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueProd := TRESTDWClientSQL.Create(nil);
   QueProd.DataBase := DM.DWDataBase;
   QueProd.SQL.Text := 'SELECT SUB.IDSubs,AVG(PRO.PrecoFab) AS PrecoFab FROM arqproduto PRO LEFT JOIN '+
   'arqprodutosub SUB ON PRO.IDProd = SUB.IDProd WHERE SUB.IDSubs > 0 GROUP BY SUB.IDSubs ORDER BY SUB.IDSubs';
   try
      QueProd.Open;

      with MemTableIA do
      begin
         FieldDefs.Add('IDFilial',  ftInteger); // ID da Filial
         FieldDefs.Add('IDSubs',   ftInteger);  // ID da Substância / Molécula
         FieldDefs.Add('QtdVAnt',  ftInteger);  // Quantidade vendida em anos anteriores no período solicitado
         FieldDefs.Add('QtdVAtu',  ftInteger);  // Quantidade vendida nos dias atuais
         FieldDefs.Add('EstAtual', ftInteger);  // Estoque atual do Produto
         FieldDefs.Add('QtdCompra',ftInteger);  // Quantidade à Comprar
         FieldDefs.Add('PrecoFab', ftFloat);    // Preço de Fábrica
         IndexFieldNames := 'IDSubs';
         FieldDefs.Update;
         CreateDataSet;
         Open;
      end; //with;

      DataIni := FormatDateTime('yyyy-mm-dd',recDatIni);
      QueTens.SQL.Text := 'SELECT Comp_DMinDem,Comp_NivSerRup FROM arqiatensores';
      QueTens.Open;
      DMinDema := QueTens.FieldByName('Comp_DMinDem').AsString;

      with QueAuxi do
      begin
         //MsgWait('IA analisando sazonalidade de vendas...',FrmPrincipal);
         //..... Agrupa Qtd.Vendas por Sazonalidade Agrupado em 1,2,3 Anos Anteriores ..... //
         SQL.Text :=
         'SET @DataBase  = DATE_ADD('+Aspas(DataIni)+', INTERVAL '+DMinDema+' DAY); '+
         'SET @DataAnte1 = DATE_SUB(@DataBase, INTERVAL 1 YEAR); '+
         'SET @DataAnte2 = DATE_SUB(@DataBase, INTERVAL 2 YEAR); '+
         'SET @DataAnte3 = DATE_SUB(@DataBase, INTERVAL 3 YEAR); '+
         'SELECT YEAR(a.Datven) AS Ano, a.IDFilial, s.IDSubs, ROUND(SUM(CASE WHEN'+
         '   a.Datven BETWEEN @DataAnte1 AND DATE_ADD(@DataAnte1, INTERVAL '+DMinDema+' DAY) '+
         'OR a.Datven BETWEEN @DataAnte2 AND DATE_ADD(@DataAnte2, INTERVAL '+DMinDema+' DAY) '+
         'OR a.Datven BETWEEN @DataAnte3 AND DATE_ADD(@DataAnte3, INTERVAL '+DMinDema+' DAY) '+
         'THEN a.Qtdven ELSE 0 END)) AS VenAnoAnt, COALESCE(Round(p.Qtdest), 0) AS EstAtual '+
         'FROM arqvendapordia a LEFT JOIN '+
         '(SELECT IDFilial, IDProd, ROUND(SUM(Qtdest)) AS Qtdest FROM arqprodutolot WHERE Qtdest > 0 '+
         'GROUP BY IDFilial,IDProd) p ON a.IDFilial = p.IDFilial AND a.IDFilial = p.IDFilial AND a.IDProd = p.IDProd '+
         'JOIN arqprodutosub s ON a.IDProd = s.IDProd WHERE a.Datven BETWEEN DATE_SUB(@DataBase, INTERVAL 3 YEAR) AND @DataBase '+
         'GROUP BY a.IDFilial, s.IDSubs, Ano HAVING SUM(CASE WHEN'+
         '   a.Datven BETWEEN @DataAnte1 AND DATE_ADD(@DataAnte1, INTERVAL '+DMinDema+' DAY) '+
         'OR a.Datven BETWEEN @DataAnte2 AND DATE_ADD(@DataAnte2, INTERVAL '+DMinDema+' DAY) '+
         'OR a.Datven BETWEEN @DataAnte3 AND DATE_ADD(@DataAnte3, INTERVAL '+DMinDema+' DAY) '+
         'THEN a.Qtdven ELSE 0 END) ORDER BY a.IDFilial,s.IDSubs, Ano;';
         QueAuxi.Open;
         SetLength(aQtdVenda, 0);
         antIDFilial := FieldByName('IDFilial').AsInteger;
         antIDSubs   := FieldByName('IDSubs').AsInteger;

         // ..... Análise de Vendas Por Sazonalidade ..... //
         while not Eof do
         begin
            auxQtdest := FieldByName('EstAtual').AsInteger;
            SetLength(aQtdVenda, Length(aQtdVenda) + 1);
            aQtdVenda[High(aQtdVenda)] := FieldByName('VenAnoAnt').AsFloat;
            Next;
            if (antIDSubs <> FieldByName('IDSubs').AsInteger) or (antIDFilial <> FieldByName('IDFilial').AsInteger) or Eof then
            begin
               if Length(aQtdVenda) > 0 then
               begin
                  if CriaRegP3(FieldByName('IDFilial').AsInteger,FieldByName('IDSubs').AsInteger) then
                  begin
                     if Length(aQtdVenda) > 0 then
                     begin
                        Tendencia := Trender(aQtdVenda);
                        if Tendencia <> 0 then
                             auxQtdped := aQtdVenda[High(aQtdVenda)] * (1 + Tendencia / 100)
                        else auxQtdped := aQtdVenda[High(aQtdVenda)];
                        MemTableIA.FieldByName('QtdVAnt').AsInteger  := Round(auxQtdped);
                        MemTableIA.FieldByName('EstAtual').AsInteger := auxQtdest;
                        MemTableIA.Post;
                     end; //if
                  end; //if
               end; //if
               if not Eof then
               begin
                  SetLength(aQtdVenda, 0);
                  antIDFilial := FieldByName('IDFilial').AsInteger;
                  antIDSubs := FieldByName('IDSubs').AsInteger;
               end;
            end; //if
         end; //while

         //CloseMsgWait;
         //MsgWait('IA analisando Vendas X Estoque...',FrmPrincipal);

         //..... Salva QTD. Vendas Nos Dias Atuais e Estoque Atual ..... //
         QueAuxi.Close;
         SQL.Text := 'SELECT s.IDSubs, ROUND(SUM(v.Qtdven), 2) AS QtdVendas, COALESCE(SUM(p.Qtdest), 0) AS EstAtual '+
         'FROM arqvendapordia v JOIN arqprodutosub s ON v.IDProd = s.IDProd LEFT JOIN '+
         '(SELECT IDFilial, IDProd, ROUND(SUM(Qtdest)) AS Qtdest FROM arqprodutolot WHERE Qtdest > 0 '+
         'GROUP BY IDFilial,IDProd) p ON v.IDFilial = p.IDFilial AND v.IDProd = p.IDProd '+
         'WHERE v.Datven >= CURDATE() - INTERVAL '+DMinDema+' DAY GROUP BY p.IDFilial,s.IDSubs';
         QueAuxi.Open;
         while not Eof do
         begin
            if CriaRegP3(FieldByName('IDFilial').AsInteger,FieldByName('IDSubs').AsInteger) then
            begin
               MemTableIA.FieldByName('QtdVAtu').AsFloat    := FieldByName('QtdVendas').AsFloat;
               MemTableIA.FieldByName('EstAtual').AsInteger := FieldByName('EstAtual').AsInteger;
               MemTableIA.Post;
            end; //if
            Next;
         end; //while
      end; //with

      //CloseMsgWait;
      //MsgWait('IA analisando Estoque pra reposição...',FrmPrincipal);
      // ..... Calcular Estoque à Comprar ..... //
      with MemTableIA do
      begin
         First;
         while not Eof do
         begin
            Edit;
            TotalVen := FieldByName('QtdVAnt').AsInteger + FieldByName('QtdVAtu').AsInteger;
            if TotalVen > 0 then
            begin
               PesoAtu := FieldByName('QtdVAtu').AsInteger / TotalVen;
               PesoHis := FieldByName('QtdVAnt').AsInteger / TotalVen;
               FieldByName('QtdCompra').AsInteger := Round((FieldByName('QtdVAtu').AsInteger * PesoAtu) + (FieldByName('QtdVAnt').AsInteger * PesoHis));
               Post;
            end; //if
            Next;
         end; //while
      end; //with
      Result := MemTableIA;
   finally
      //CloseMsgWait;
      QueAuxi.Close;
      QueTens.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueTens);
   end;
end;

function CriaRegP3(recIDFilial,recIDSubs:Integer):Boolean;
var
   auxPrecoFab:Double;
begin
   Result := False;
   if QueProd.Locate('IDSubs',recIDSubs,[]) then
        auxPrecoFab := QueProd.FieldByName('PrecoFab').AsFloat
   else Exit;

   with MemTableIA do
   begin
      if not Locate('IDFilial;IDSubs',VarArrayOf([recIDFilial,recIDSubs]),[]) then
      begin
         Append;
         FieldByName('IDFilial').AsInteger  := recIDFilial;
         FieldByName('IDSubs').AsInteger    := recIDSubs;
         FieldByName('PrecoFab').AsFloat    := auxPrecoFab;
         FieldByName('QtdVAnt').AsInteger   := 0;
         FieldByName('QtdVAtu').AsInteger   := 0;
         FieldByName('EstAtual').AsInteger  := 0;
         FieldByName('QtdCompra').AsInteger := 0;
      end
      else Edit;
   end; //with
   Result := True;
end;

// ------- Analisa Tendência de Crescimento em uma Array of Double ------ //
function Trender(const Valores: array of Double):Double;
var
   I:Integer;
   SomaVariacao,VariacaoAtual:Double;
begin
   Result := 0.0;
   if Length(Valores) > 1 then
   begin
      SomaVariacao := 0.0;
      for I := Low(Valores) to High(Valores) - 1 do
      begin
         if Valores[I] <> 0 then
         begin
            VariacaoAtual := (Valores[I + 1] - Valores[I]) / Valores[I] * 100;
            SomaVariacao  := SomaVariacao + VariacaoAtual;
         end;
      end; //for
      Result := SomaVariacao / (Length(Valores) - 1);
   end; //if
end;

end.

(*
   DETERMINE O CONSUMO MÉDIO DIÁRIO DOS PRODUTOS: "Comp_DConsMed"
   Quantos itens desse produto você vende em média por dia.
   Isso pode ser feito calculando o total de vendas desse produto durante um período específico e dividindo
   pelo número de dias desse período.

   ESTIME O TEMPO DE REPOSIÇÃO:
   Determine quanto tempo leva para você receber um pedido depois de ter feito o pedido ao seu fornecedor.
   Isso pode variar dependendo do fornecedor e do produto, mas é importante ter uma estimativa precisa.

   ESCOLHA O NIVEL DE SERVIÇO DESEJADO P/ EVITAR RUPTURAS: "Comp_NivSerRup"
   O nível de serviço é a probabilidade de não ter uma ruptura de estoque. Normalmente, as empresas visam
   um nível de serviço de 95% a 99%. Quanto maior o nível de serviço desejado, maior será o estoque de
   segurança que você precisará manter.

   CALCULE O ESTOQUE DE SEGURANÇA:
   O estoque de segurança é a quantidade de produto que você precisa manter para cobrir a incerteza no
   consumo e no tempo de reposição. Ele é calculado multiplicando o desvio padrão do consumo diário pelo
   número de desvios padrão necessário para atingir o nível de serviço desejado.

   A fórmula é a seguinte: Estoque de Segurança = (Z x Desvio Padrão do Consumo Diário) x Tempo de Reposição
   O valor de "Z" é obtido a partir de tabelas estatísticas e depende do nível de serviço desejado.
   Exemplo, para um nível de serviço de 95%, Z pode ser cerca de 1,65.

   CALCULE O PONTO DE PEDIDO:
   O ponto de pedido é calculado somando o consumo médio diário ao estoque de segurança.
   A fórmula é a seguinte: Ponto de Pedido = Consumo Médio Diário + Estoque de Segurança

   ESTABELEÇA O TEMPO MÍNIMO DE PEDIDO:
   O tempo mínimo de pedido é o número de dias que você deve esperar antes de fazer um novo pedido para
   evitar rupturas de estoque. Isso pode ser calculado dividindo o Estoque Atual pelo Consumo Médio Diário.
   A fórmula é: Tempo Mínimo de Pedido = Estoque Atual / Consumo Médio Diário

-------------------------------------------------

   // .... Associar às vendas aos FATORES .... //
   SELECT a.IDProd,Date(b.Datped) AS DataVenda,m.*,t.*,ta.*,SUM(a.Qtdped) AS TotalVendido
   FROM arqpedidoite a INNER JOIN arqpedido b ON a.IDPed = b.IDPed
   LEFT JOIN arqmeteorologia m ON DATE(b.Datped) = DATE(m.Datmet)
   LEFT JOIN dbaiserver.arqtaxasmensal t ON YEAR(b.Datped) = t.IndexAno AND MONTH(b.Datped) = t.IndexMes
   LEFT JOIN dbaiserver.arqtaxasanual ta ON YEAR(b.Datped) = ta.AnoFator
   WHERE b.Datped BETWEEN DATE_SUB('2024-01-01', INTERVAL 24 MONTH) AND '2024-01-01'
   GROUP BY a.IDProd, Date(b.Datped) ORDER BY a.IDProd, b.Datped;

-------------------------------------------------

DESCRITIVO PARA CHAT GPT

Usando o banco de dados MySQL temos:
1. A tabela "arqpedido" que é a tabela master dos meus pedidos de vendas, nessa temos o campo chave: "IDPed", nessa tabela master existe o campo do tipo DateTime, chamado "Datped" que armazena a data e horas do pedido.
2. Associada à tabela "arqpedido", via o campo chave "IDPed", temos a tabela com nome "arqpedidoite" que contém os produtos vendidos com seus códigos de produtos no campo "IDProd" e no campo "Qtdped" temos a quantidade vendida.
Com essa estrutura de dados, será informada uma "data base" e eu preciso de uma query que retorne a quantidade vendida agrupada por produto e acumulada em 10,20,30 e 45 dias à ser contados à partir da data base fornecida, mas em relação à anos anterores à essa data, agrupando por sua vez, em até 3 anos anteriores.
*)

