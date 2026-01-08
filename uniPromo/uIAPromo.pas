unit uIAPromo;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, System.DateUtils,
  uLibFarm, MarcLib, uDM, uConst, uIAGeral, uRESTDWBasicDB, uPrincipal;

  procedure CriaRegSel(recIDProd:Integer; campoPerDesc:String; recPerDesc:Double);
  function  SelProdProm(aIDGrupo,aIDGruSub,aFabrica:TArray<Integer>; recSVenda,recPVence,recPotEst,iAgressivo:Integer; recConPag:Double; recDatIni,recDatFin,recDatVenLot:TDate):TFDMemTable;

var
   MemPromoIA:TFDMemTable;

implementation

//-------------- Seleção dos Produtos que Participarão da Promoção --------------//
function SelProdProm(aIDGrupo,aIDGruSub,aFabrica:TArray<Integer>; recSVenda,recPVence,recPotEst,iAgressivo:Integer; recConPag:Double; recDatIni,recDatFin,recDatVenLot:TDate):TFDMemTable;
{aIDGrupo  : Grupos que participarão da Promoção
 aIDGruSub : Sub-Grupos que participarão da Promoção
 aFabrica  : Fábricas que participarão da Promoção
 recSVenda : Número de dias sem vendas para análise
 recPVence : Número de dias futuros de estoque de produtos à vencer
 recPotEst : Número de dias futuros de estoque necessário para vendas previstas
 iAgrassivo: Calibra o % de desconto p/ promoção -> 0 = Sem agresividade, 1 = Moderado, 2 = Agressivo
 recConPag : Total das despesas fixas e variadas do pérido pós promoção
 recDatIni : Data início da Promoção
 recDatFin : Data final  da Promoção }
var
   I:Integer;
   MemDadosIA:TFDMemTable;
   QuePromoPro,QueTensor,QueFilial,QueAuxi:TRESTDWClientSQL;
   auxFator,auxNivel,DescoIni,Proporcao,QtdProVen,QtdProLon,auxDesc,maiDesc,auxTensor:Double;
begin
   Result := nil;
   QuePromoPro := TRESTDWClientSQL.Create(nil);
   QuePromoPro.DataBase := DM.DWDataBase;
   QueTensor := TRESTDWClientSQL.Create(nil);
   QueTensor.DataBase := DM.DWDataBase;
   QueTensor.SQL.Text := 'SELECT * FROM arqiatensores LIMIT 1';
   QueFilial := TRESTDWClientSQL.Create(nil);
   QueFilial.DataBase := DM.DWDataBase;
   QueFilial.SQL.Text   := 'SELECT MetPerLuc FROM arqfilial WHERE IDFilial = '+FILIAL.ToString;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;

   MemDadosIA := TFDMemTable.Create(nil);
   MemPromoIA := TFDMemTable.Create(nil);
   try
      try
         QueTensor.Open;
         QueFilial.Open;
         with MemPromoIA do
         begin
            FieldDefs.Add('IDProd', ftInteger);
            FieldDefs.Add('MarkVenc',ftFloat);
            FieldDefs.Add('MarkSVen',ftFloat);
            FieldDefs.Add('MarkAEst',ftFloat);
            FieldDefs.Add('MarkAMar',ftFloat);
            FieldDefs.Add('NewMark',ftFloat);
            FieldDefs.Add('IndEntra',ftBoolean);
            FieldDefs.Add('QtdEstoque',ftFloat);
            FieldDefs.Update;
            CreateDataSet;
            Open;
         end; //with;

         MemDadosIA := Perceptron1(recSVenda,recPVence,recPotEst,recConPag,recDatIni,recDatFin,recDatVenLot);

         //MsgWait('Finalizando lista de promoções.',FrmPrincipal);
         with MemDadosIA do
         begin
            First;
            while not Eof do
            begin
               maiDesc := 0.00;
               // .... Seleciona Produtos Próximos à Data de Vencimento .... //
               if FieldByName('MarkupProd').AsFloat > 0.00 then
               begin
                  if FieldByName('QtdVencendo').AsFloat > 0.00 then
                  begin
                     QtdProVen := FieldByName('QtdVencendo').AsFloat;
                     QtdProLon := FieldByName('QtdEstoque').AsFloat - QtdProVen;
                     auxFator  := QueTensor.FieldByName(iif(FieldByName('GiroTotal').AsFloat > 1,'Promo_PVencNDias_GAlt','Promo_PVencNDias_GBai')).AsFloat;
                     DescoIni  := (auxFator / 100) * FieldByName('MarkupProd').AsFloat;
                     Proporcao := QtdProVen / (QtdProVen + QtdProLon);  //... Calcula proporção de produtos próximos do vencimento
                     auxDesc   := Roundx(DescoIni * Proporcao,1);
                     CriaRegSel(FieldByName('IDProd').AsInteger, 'MarkVenc', auxDesc);
                     if auxDesc > maiDesc then maiDesc := auxDesc;
                  end; //if

                  // .... Seleciona Produtos Sem Vendas à "N" Dias .... //
                  if FieldByName('SemVenNDia').AsBoolean then
                  begin
                     auxFator := FieldByName('MarkupProd').AsFloat;
                     auxDesc  := auxFator - (auxFator * (QueTensor.FieldByName('Promo_PSemVen').AsFloat/100));
                     CriaRegSel(FieldByName('IDProd').AsInteger, 'MarkSVen', auxDesc);
                     if auxDesc > maiDesc then maiDesc := auxDesc;
                  end; //if

                  // .... Seleciona Produtos Com Estoque Alto .... //
                  if FieldByName('QtdEstAlto').AsFloat > 0.00 then
                  begin
                     auxFator := FieldByName('MarkupProd').AsFloat;
                     auxNivel := QueTensor.FieldByName('Promo_PEst_Nivel').AsFloat;
                     if FieldByName('QtdEstoque').AsFloat > (FieldByName('QtdEstAlto').AsFloat * (1 + auxNivel/100)) then
                          auxDesc := auxFator - (auxFator * (QueTensor.FieldByName('Promo_PEst_Alto').AsFloat /100))
                     else auxDesc := auxFator - (auxFator * (QueTensor.FieldByName('Promo_PEst_Baixo').AsFloat/100));
                     CriaRegSel(FieldByName('IDProd').AsInteger, 'MarkAEst', auxDesc);
                     if auxDesc > maiDesc then maiDesc := auxDesc;
                  end; //if

                  //.... Seleciona Produtos Markup Acima do Esperado Pela FILIAL (arqfilial -> MetPerLuc) ....//
                  auxFator := FieldByName('MarkupProd').AsFloat;
                  if (auxFator > 0.00) and (auxFator > QueFilial.FieldByName('MetPerLuc').AsFloat) then
                  begin
                     auxNivel := 100 - RoundX((QueFilial.FieldByName('MetPerLuc').AsFloat / auxFator) * 100,2);
                     if auxNivel > QueTensor.FieldByName('Promo_PLuc_Nivel').AsFloat then
                          auxDesc := auxFator - (auxFator * (QueTensor.FieldByName('Promo_PLuc_Alto').AsFloat  / 100))
                     else auxDesc := auxFator - (auxFator * (QueTensor.FieldByName('Promo_PLuc_Baixo').AsFloat / 100));
                     CriaRegSel(FieldByName('IDProd').AsInteger, 'MarkAMar', auxDesc);
                     if Roundx(auxDesc,2) > maiDesc then maiDesc := auxDesc;
                  end; //if

                  if maiDesc > 0.00 then CriaRegSel(FieldByName('IDProd').AsInteger, 'NewMark', maiDesc);

                  auxDesc := FieldByName('QtdEstoque').AsFloat;
                  CriaRegSel(FieldByName('IDProd').AsInteger, 'QtdEstoque', auxDesc);
               end; //if
               Next;
            end; //wilhe

            //.......... Filtra: Grupo / SubGrupo / Fabricantes Solicitados .........//
            if (Length(aIDGrupo) > 0) or (Length(aIDGruSub) > 0) or (Length(aFabrica) > 0) or (iAgressivo > 0) then
            begin
               if (Length(aIDGrupo) > 0) or (Length(aIDGruSub) > 0) or (Length(aFabrica) > 0) then
               begin
                  QueAuxi.Close;
                  QueAuxi.SQL.Text := 'SELECT PRO.IDProd FROM arqproduto PRO WHERE ';
                  if Length(aIDGrupo) > 0 then
                  begin
                     QueAuxi.SQL.Add('IDGrupo IN (');
                     for I := Low(aIDGrupo) to High(aIDGrupo) do
                        QueAuxi.SQL.Add(iif(I > Low(aIDGrupo),',','')+ IntToStr(aIDGrupo[I])+ iif(I = High(aIDGrupo),')',''));
                  end; //if
                  if Length(aIDGruSub) > 0 then
                  begin
                     if (Length(aIDGrupo) > 0) then QueAuxi.SQL.Add(' AND ');
                     QueAuxi.SQL.Add('IDGruSub IN (');
                     for I := Low(aIDGruSub) to High(aIDGruSub) do
                        QueAuxi.SQL.Add(iif(I > Low(aIDGruSub),',','')+ IntToStr(aIDGruSub[I])+ iif(I = High(aIDGruSub),')',''));
                  end; //if
                  if Length(aFabrica) > 0 then
                  begin
                     if (Length(aIDGrupo) > 0) or (Length(aIDGruSub) > 0) then QueAuxi.SQL.Add(' AND ');
                     QueAuxi.SQL.Add('IDFabr IN (');
                     for I := Low(aFabrica) to High(aFabrica) do
                        QueAuxi.SQL.Add(iif(I > Low(aFabrica),',','')+ IntToStr(aFabrica[I])+ iif(I = High(aFabrica),')',''));
                  end; //if
                  QueAuxi.SQL.Add(' ORDER BY IDProd');
                  QueAuxi.Open;
               end; //if

               auxTensor := QueTensor.FieldByName('Promo_PEstilo_'+iif(iAgressivo = 1,'Mod','Agr')).AsFloat;

               MemPromoIA.First;
               while not MemPromoIA.Eof do
               begin
                  MemPromoIA.Edit;
                  if (Length(aIDGrupo) > 0) or (Length(aIDGruSub) > 0) or (Length(aFabrica) > 0) then
                     MemPromoIA.FieldByName('IndEntra').AsBoolean := QueAuxi.Locate('IDProd',MemPromoIA.FieldByName('IDProd').AsString,[]);

                  if MemPromoIA.FieldByName('IndEntra').AsBoolean and (recDatVenLot > 1) then
                     MemPromoIA.FieldByName('IndEntra').AsBoolean := MemPromoIA.FieldByName('QtdVencendo').AsInteger > 0;

                  // ..... Aplica Peso, via Tensor, com a Diminuição do Markup ..... //
                  if iAgressivo > 0 then
                  begin
                     if (MemPromoIA.FieldByName('NewMark').AsFloat - auxTensor) >= 1 then
                        MemPromoIA.FieldByName('NewMark').AsFloat := MemPromoIA.FieldByName('NewMark').AsFloat - auxTensor;
                  end; //if

                  MemPromoIA.Post;
                  MemPromoIA.Next;
               end; //while
            end; //if
         end; //with
         Result := MemPromoIA;
      except
         on E:Exception do
            SalvaLog('ERRO:',PastaLog,'uIAPromo -> SelProdProm -> '+E.Message);
      end;
   finally
      //CloseMsgWait;
      QueAuxi.Close;       QueAuxi.Free;
      MemDadosIA.Close;    MemDadosIA.Free;
      QueTensor.Close;     QueTensor.Free;
      QueFilial.Close;     QueFilial.Free;
      QuePromoPro.Close;   QuePromoPro.Free;
   end;
end;

// -------- Cria Registro de Regra de Seleção de Produtos -------- //
procedure CriaRegSel(recIDProd:Integer; campoPerDesc:String; recPerDesc:Double);
begin
   with MemPromoIA do
   begin
      if not Locate('IDProd',recIDProd,[]) then
      begin
         Append;
         FieldByName('IDProd').AsInteger   := recIDProd;
         FieldByName('IndEntra').AsBoolean := True;
      end
      else Edit;
      FieldByName(campoPerDesc).AsFloat := Roundx(recPerDesc,2);
      Post;
   end; //with
end;

end.

(* ALGORITIMO DE SELEÇÃO:

    1. Os % de descontos abaixo, devem receber a calibração de: Conservador, Moderado (Promo_PEstilo_Mod), Agresivo (Promo_PEstilo_Agr):
       1.1 Interferirá sobre: cada percentual de desconto sobre margem de lucro bruta (markup):
           1.1.1: Diminuir em "N%" (Promo_PEstilo_Mod) ou (Promo_PEstilo_Agr) para cada caso.
       1.2 Interferirá sobre: o percentual de sucesso de venda da planejado em em relação ao fluxo de caixa previsto
           1.2.1: Diminuir em "N%" (Promo_PEstilo_Mod) ou (Promo_PEstilo_Agr) para cada caso.

   2. Seleciona produtos próximos à data de vencimento em "N" dias (Promo_PVencNDias)
      2.1 Caso o produto tenha um bom giro,   aplicar N% sobre margem de lucro bruta. (Promo_PVencNDias_GAlt)
      2.2 Caso o produto tenha um giro baixo, aplicar N% sobre margem de lucro bruta. (Promo_PVencNDias_GBai)
      2.3 Em ambos casos acima ponderar o estoque à vencer com estoque que estiver regular, Func: CalcDescPVenc();

    3. Seleciona produtos sem vendas à "N" dias.
       3.1 Se o estoque estiver sem vendas: aplicar "N%" (Promo_PSemVen) sobre margem de lucro bruta.

    4. Seleciona produtos com estoque alto.
       4.1 Se o estoque estiver "N%" (Promo_PEst_Nivel) acima da quantidade prevista de vendas, aplicar "N%" (Promo_PEst_Alto) sobre margem de lucro bruta.
       4.2 Se o estoque estiver mais de "N%" (Promo_PEst_Nivel) acima da quantidade prevista de vendas, aplicar "N%" (Promo_PEst_Baixo) sobre margem de lucro bruta.

    5. Seleciona produtos com margem acima do percentual lucro bruto esperado pelo Grupo de Produtos
       5.1 Se o estoque estiver "N%" (Promo_PLuc_Nivel) acima da quantidade prevista de vendas, aplicar "N%" (Promo_PLuc_Alto) sobre margem de lucro bruta.
       5.2 Se o estoque estiver mais de "N%" (Promo_PLuc_Nivel) acima da quantidade prevista de vendas, aplicar "N%" (Promo_PLuc_Baixo) sobre margem de lucro bruta.

    6. À cada produto que tiver seu cáculo nas formas acima, todos os % de Desconto Calculados, Salvar Somente o que for Maior

    //----> NESSE PONTO: À FAZER:
    7. Ao terminar o processo acima, verificar o provável impacto da promoção com os parâmetros determinados sobre o resultado
       da empresa em relação ao fluxo de caixa para os próximos "N" dias, levando em consideração as despesas fixas e variáveis.
         7.1 Simule: caso, o sucesso de venda chegue a "N%" do planejado, o caixa gerado será suficiente para pagar as contas?
         7.2 Sobre a simulação acima, deve ser considerado, também a previsão de vendas de produtos que ficaram de fora da promoção.
         7.3 Verificar também se a magem esperada para o perírodo ficará "N%" sobre a margem de lucro esperada para filial, caso
             ultrapasse, recalcular o processo acima.

----------------------------------------------------------------------------
  PONTOS DE ANÁLISE:

   1. Margem de Lucro Atual por Produto: Conheça a margem de lucro específica de cada produto.
   Alguns produtos podem ter margens maiores, permitindo mais flexibilidade em descontos.

   2. Custo Fixo e Variável: Entenda seus custos fixos e variáveis.
   Promoções não devem reduzir o preço de venda a um ponto onde não cubra os custos variáveis e
   contribua negativamente para os custos fixos.

   3. Elasticidade de Preço da Demanda: Avalie como a demanda por um produto muda com a alteração do preço.
   Para produtos com alta elasticidade, uma pequena redução no preço pode levar a um grande aumento no volume de vendas.

   4. Objetivos da Promoção: Defina claramente os objetivos da promoção (por exemplo, aumento do volume de vendas,
   redução de estoque, atração de novos clientes). Isso ajudará a determinar a extensão do desconto necessário
   para atingir esses objetivos.

   5. Efeito nos Produtos Complementares e Substitutos: Considere o impacto da promoção em produtos complementares
   (que podem ser vendidos juntos) e substitutos (que podem substituir o produto promovido).

   6. Percepção de Valor: Evite descontos que possam afetar negativamente a percepção de valor dos clientes a longo prazo.
   Descontos muito profundos podem levar os clientes a questionar a qualidade ou o valor real dos produtos.

   7. Análise da Concorrência: Observe as estratégias de preço e promoção dos concorrentes para garantir que suas promoções
   sejam competitivas, mas não uma corrida para o fundo do poço.

   8. Impacto na Lealdade do Cliente: Considere como as promoções afetarão a lealdade do cliente. Promoções frequentes podem
   levar os clientes a esperar por elas e atrasar as compras regulares.

   9. Capacidade de Estoque e Cadeia de Suprimentos: Garanta que você tenha capacidade suficiente para atender ao aumento da
   demanda, sem causar rupturas de estoque.

   10. Análise Pós-Promoção: Planeje avaliar o impacto da promoção após a sua conclusão para aprender com os resultados e
   ajustar estratégias futuras.

RESUMO: Como regra geral, o desconto oferecido em uma promoção deve ser tal que o preço de venda promocional ainda cubra o
custo do produto e contribua positivamente para cobrir os custos fixos, enquanto ajuda a alcançar os objetivos
específicos da promoção. A análise cuidadosa e a tomada de decisão baseada em dados são fundamentais neste processo.
No varejo de farmácias, ao considerar uma promoção com um percentual de lucro médio de 30%, diversos fatores devem ser
ponderados para determinar o limite de desconto que você pode oferecer sem prejudicar sua lucratividade e sustentabilidade
do negócio. Aqui estão alguns pontos importantes a considerar.

*)

