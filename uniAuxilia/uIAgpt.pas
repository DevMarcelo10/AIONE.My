unit uIAgpt;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   AdvSmoothPanel, Vcl.ExtCtrls, Vcl.Imaging.PNGimage, Vcl.StdCtrls,
   REST.Client, REST.Types, System.JSON, Data.Bind.ObjectScope, Data.DB,
   AdvReflectionLabel, LMDBaseControl, LMDBaseGraphicControl, LMDLabel,
   LMDBaseLabel, LMDCustomLabel, MarcLib, System.DateUtils, AdvGlowButton,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDRTFBase, LMDRTFLabel,
   uRESTDWBasicDB, Data.Bind.Components, REST.Authenticator.OAuth;

type
   TFrmIAgpt = class(TForm)
    PanelBas: TAdvSmoothPanel;
    PanelCenter: TAdvSmoothPanel;
    timAlpha: TTimer;
    PanelBusca: TAdvSmoothPanel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    edPergunta: TLMDEdit;
    btBusca: TAdvGlowButton;
    lbResposta: TLMDLabel;
    procedure FormResize(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure edPerguntaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btAtivarClick(Sender: TObject);
   private
      { Private declarations }
      acuJsonStr:String;
   public
      { Public declarations }
   end;

var
   FrmIAgpt: TFrmIAgpt;

const
   // API Key deve ser configurada no config.ini [OPENAI] APIKey=
   APIKey:String = '';

implementation

{$R *.dfm}

uses uDM, IABase, uLibFarm;

procedure TFrmIAgpt.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmIAgpt.FormShow(Sender: TObject);
begin
   //TypingSimulation(lbSaudar, Saldar + USUARIO, 50, 0);
end;

procedure TFrmIAgpt.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmIAgpt.btBuscaClick(Sender: TObject);
var
   OpenAI:TOpenAIChat;
   Messages:TJSONArray;
   QueAuxi:TRESTDWClientSQL;
   MsgSystem,MsgUser:TJSONObject;
   SQLGerada,JSONDados,Resposta:String;
begin
   if edPergunta.Text.Trim = '' then
   begin
      edPergunta.SetFocus;
      Exit;
   end;

   Screen.Cursor := crHourGlass;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   OpenAI := TOpenAIChat.Create;
   try
      try
         SQLGerada := OpenAI.GerarSQL(edPergunta.Text.Trim);
         SQLGerada := StringReplace(SQLGerada,'`','', [rfReplaceAll]);
         SQLGerada := StringReplace(SQLGerada,'sql','', [rfReplaceAll,rfIgnoreCase]);
         //ShowMessage('SQL gerada:' + sLineBreak + SQLGerada);
         if AnsiPos(SQLGerada,'##ERROR##') <= 0 then
         begin
            QueAuxi.SQL.Text := SQLGerada;
            QueAuxi.Open;
            JSONDados := OpenAI.ExecSQLToJSON(QueAuxi, SQLGerada);
            Resposta  := OpenAI.InterpretaIA(JSONDados);
         end else
         begin
            Messages := TJSONArray.Create;
            MsgSystem := CreateMessage('system',
            'Você tem o perfil de um experiente farmaceutico e profundo conhecedor de doenças e bulas de medicamentos. '+
            'Uma outra grande habilidade que vcoê tem também é de um experiente gestor de empresas de varejo, sendo você'+
            ' também expecialista e gestor em analises, financeiras, DRE, custos, compras estoque e vendas. '+
            'Desejo que o formato das suas respostas seja resumido, coeso e direto, evitando repetições.');
            MsgUser := CreateMessage('user', acuJsonStr+'. Pergunta: '+edPergunta.Text.Trim);
            Messages.AddElement(MsgSystem);
            Messages.AddElement(MsgUser);
            Resposta := OpenAI.SendMessage(Messages);
         end;
         TypingSimulation(lbResposta, edPergunta.Text.Trim + #13+#10 + #13+#10 + Resposta, 10,0);
      except
         on E:Exception do

      end;
   finally
      Screen.Cursor := crDefault;
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      OpenAI.Free;
      edPergunta.Clear;
      edPergunta.SetFocus;
   end;
end;

procedure TFrmIAgpt.edPerguntaKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then btBusca.Click;
end;

procedure TFrmIAgpt.FormResize(Sender: TObject);
begin
   PanelCenter.Top  := ((Self.Height - PanelCenter.Height) div 2) - 55;
   PanelCenter.Left := ((Self.Width  - PanelCenter.Width)  div 2);
   PanelBusca.Left  := (Self.Width   - PanelBusca.Width)   div 2 + 10;
   PanelBusca.Top   := (Self.Height  - PanelBusca.Height) - 30;
end;

procedure TFrmIAgpt.btAtivarClick(Sender: TObject);
//var
//   OpenAI: TOpenAIChat;
//   JsonStr:String;
//   QueAuxi:TRESTDWClientSQL;
//   Texto: TStringList;
begin
   (*acuJsonStr := '';
   Screen.Cursor := crHourGlass;
   OpenAI := TOpenAIChat.Create;
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   Texto := TStringList.Create;
   try
      try
         // ------------- Vendas Por Dia ----------- //
         QueAuxi.SQL.Text :=
         'SELECT DATE(Datped) AS DataPed,SUM(TotPedido) AS TotVendas,COUNT(DISTINCT IDPed) AS NroPedidos, '+
         'ROUND(SUM(TotPedido) / COUNT(DISTINCT IDPed), 2) AS TicketMedio FROM arqpedido '+
         'WHERE IDFilial = '+FILIAL.ToString+' GROUP BY DataPed ORDER BY DataPed LIMIT 365';
         QueAuxi.Open;
         JsonStr := OpenAI.GerarJSON(QueAuxi,
         'Relatório de Vendas Por Dia',
         'Cada linha apresenta um dia com o total de vendas, total de pedidos e Ticket Medio em cada dia nos últimos 12 meses.');
         acuJsonStr := acuJsonStr + JsonStr;

         // ------------- Vendas Por Mês ----------- //
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT DATE_FORMAT(Datped, "%Y-%m") AS MesAno, SUM(TotPedido) AS TotVendas, COUNT(DISTINCT IDPed) AS NroPedidos FROM arqpedido '+
         'WHERE IDFilial = '+FILIAL.ToString+' GROUP BY MesAno ORDER BY MesAno LIMIT 12';
         QueAuxi.Open;
         JsonStr := OpenAI.GerarJSON(QueAuxi,
         'Relatório de Vendas Agrupadas Por Mes e Ano ',
         'Cada linha apresenta os dados: Ano Mes, Total Vendas, Numero total de pedidos no periodo de 12 meses.');
         acuJsonStr := acuJsonStr + ' '+JsonStr;

         // ------------- Variação de preços ao longo do tempo (tabela, fábrica, custo médio)  ----------- //
         QueAuxi.Close;
         QueAuxi.SQL.Text :=
         'SELECT i.IDProd, DATE_FORMAT(p.Datped, "%Y-%m") AS MesAno, ROUND(AVG(i.PrecoVen), 2) AS PrecoVendaMedio, '+
         'ROUND(AVG(i.PrecoFab), 2) AS PrecoFabricaMedio, ROUND(AVG(i.CustoMed), 2) AS CustoMedio FROM arqpedidoite i '+
         'JOIN arqpedido p ON i.IDFilial = p.IDFilial AND i.IDPed = p.IDPed WHERE p.Datped >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH) '+
         'AND i.IDFilial = '+FILIAL.ToString+' GROUP BY i.IDProd, MesAno ORDER BY i.IDProd, MesAno ';
         QueAuxi.Open;
         JsonStr := OpenAI.GerarJSON(QueAuxi,
         'Relatório de Vendas Agrupadas Por Mes e Ano ',
         'Cada linha apresenta os dados: Ano Mes, Total Vendas, Numero total de pedidos no periodo de 24 meses.');
         acuJsonStr := acuJsonStr + ' '+JsonStr;

         // ------------- Vendas Agrupadas Por Vendedor ----------- //
         QueAuxi.Close;
         QueAuxi.SQL.Text :=
         'SELECT ITE.IDVend AS IDVendedor,PES.Nompes AS NomeVendedor,SUM(ITE.Qtdped) AS TotalUnidadesVendidas,'+
         'SUM(ITE.Qtdped * ITE.VlrVenda) AS TotalVendas FROM arqpedidoite ITE '+
         'JOIN arqpedido PED ON ITE.IDFilial = PED.IDFilial AND ITE.IDPed = PED.IDPed '+
         'LEFT JOIN arqpessoa PES ON ITE.IDVend = PES.IDPess '+
         'WHERE ITE.IDFilial = '+FILIAL.ToString+' AND PED.Datped >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH) '+
         'GROUP BY ITE.IDVend ORDER BY TotalVendas DESC';
         QueAuxi.Open;
         JsonStr := OpenAI.GerarJSON(QueAuxi,
         'Relatório de Vendas Agrupada Por Vendedor nos últimos 12 Meses.',
         'Cada linha apresenta com os dados: ID do Vendendor, Nome do Vendedor, Quantida de unidades vendidas, Total das Vendas.');
         acuJsonStr := acuJsonStr + ' '+JsonStr;

         // ------------- Vendas Agrupadas Por Produto ----------- //
         QueAuxi.Close;
         QueAuxi.SQL.Text :=
         'SELECT i.IDProd, pr.Despro AS DescricaoProduto,SUM(i.Qtdped) AS TotalUnidadesVendidas, SUM(i.Qtdped * i.VlrVenda) AS ValorTotalVendido, '+
         'ROUND(AVG(i.VlrVenda - i.CustoMed), 2) AS MargemBrutaUnitaria, ROUND(AVG((i.VlrVenda - i.CustoMed) / i.VlrVenda) * 100, 2) AS MargemPercentual '+
         'FROM arqpedidoite i JOIN arqpedido p  ON i.IDFilial = p.IDFilial AND i.IDPed = p.IDPed '+
         'JOIN arqproduto pr ON i.IDProd = pr.IDProd '+
         'WHERE i.IDFilial = '+FILIAL.ToString+' AND i.VlrVenda > 0 AND p.Datped >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH) '+
         'GROUP BY i.IDProd, pr.Despro ORDER BY ValorTotalVendido DESC LIMIT 500';
         QueAuxi.Open;
         JsonStr := OpenAI.GerarJSON(QueAuxi,
         'Relatório de Vendas Agrupada Por Produto com suas Margem Bruta Média nos últimos 12 Meses.',
         'Cada linha apresenta com os dados: ID do Produto, Descricao do Produto Quantidade de unidades vendidas, Valor Total Vendido, Margem Bruta Unitaria, Margem Percentual');
         acuJsonStr := acuJsonStr + ' '+JsonStr;

         // ------------- Vendedores por Total de Descontos ----------- //
         QueAuxi.Close;
         QueAuxi.SQL.Text :=
         'SELECT i.IDVend,pes.Nompes AS NomeVendedor,SUM(i.VlrDesc * i.Qtdped) AS TotalDesconto '+
         'FROM arqpedidoite i JOIN arqpedido p  ON i.IDFilial = p.IDFilial AND i.IDPed = p.IDPed '+
         'LEFT JOIN arqpessoa pes ON i.IDVend = pes.IDPess WHERE i.IDFilial = '+FILIAL.ToString+' AND '+
         'p.Datped >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) GROUP BY i.IDVend, pes.Nompes ORDER BY TotalDesconto DESC';
         QueAuxi.Open;
         JsonStr := OpenAI.GerarJSON(QueAuxi,
         'Relatório de Vendedores por Total de Descontos últimos 6 Meses.',
         'Cada linha apresenta com os dados: ID do Vendedor, Nome do Vendedor, Valor Total Vendido, Total de Descontos.');
         acuJsonStr := acuJsonStr + ' '+JsonStr;

         Texto.Text := acuJsonStr;
         Texto.SaveToFile(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'acuJsonStr.txt', TEncoding.UTF8);
         except
         on E:Exception do
      end;
   finally
      Texto.Free;
      OpenAI.Free;
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
      Screen.Cursor := crDefault;
      edPergunta.SetFocus;
   end; *)
end;

end.

(*
Em um banco de dados em MySQL temos as seguintes tabelas:
-> Tabela: arqpedido, master de vendas com os campos:
   - IDFilial  - ID da Filial da Farmácia
   - IDPed     - ID do Pedido de Vendas
   - Datped    - Data / Hora do Pedido
   - IDPess    - ID do Cliente (Pessoa)
   - IDVend    - ID do Vendedor Principal
   - TotDesc   - Total do desconto
   - TotPedido - Total do Pedido

-> Tabela: arqpedidoite, detail de vendas, com os campos:
   - IDFilial  - ID da Filial da Farmácia
   - IDPed     - ID do Pedido de Vendas
   - Nroite    - Número Item
   - IDProd    - ID do Produto
   - IDVend    - ID do Vendedor do Item
   - IndComi   - Incide (tem) comissão
   - PrecoVen  - Preço de Venda tabela na data da venda
   - PrecoFab  - Preço unitário de Fábrica na data da venda
   - CustoMed  - Custo Médio na Data da Venda
   - Qtdped    - Quantidade vendida
   - PerDesc   - Percentual do Desconto
   - VlrDesc   - Valor unitário do Desconto
   - VlrVenda  - Valor unitário da venda do Item (com desconto)

   As duas tabelas, sendo a master arqpedido com os itens em: arqpedidoite, são ligadas via os campos chave: IDFilial, IDPed

-> Tabela: arqproduto, arquivo de produtos, com os campos:
   - IDProd - ID do Produto
   - Despro - Descrição do Produto

-> Tabela: arqpessoa, arquivo de pessoas (clientes, vendedores, fornecedores, fabricantes) com os campos:
   - IDProd - ID do Produto
   - Despro - Descrição do Produto

-> Tabela: arqprodutolot, que contém o estoque separados por data de vencimento, com os campos:
   - IDFilial - ID da Filial da Farmácia
   - IDProd   - ID do Produto
   - Nrolot   - Número do Lote
   - IDPess   - ID do Fornencedor
   - Datfab   - Data de Fabricação
   - Datven   - Data de Vencimento
   - Qtdest   - Quantidade em Estoque

   As tabelas de arqprodutolot se conecta à arqpedidoite via os campos: IDFilial, IDProd
   As tabelas de arqprodutolot se conecta à arqproduto via o campo: IDProd
   As tabelas de arqpedido se conecta à arqpessoa via o campo: IDPess (Cliente), e via IDVen (Vendedor) ao campo arqpessoa.IDPess


Você é um gestor consultor experiente em vendas, finanças e gestão lojas de varejo, com enfase em farmácias.
Abaixo estão os dados de vendas de uma farmácia, agrupadas de diversas formas.
À cada bloco de dados temos um descritivo do que se trata o bloco e os dados que contém, até seu indicativo de finalizaçao do bloco. No final, temos a pergunta que você deve responder.'+


1 - Vendas cruzadas para esse clietne em relação à pedidos anteriores,
2 - Vendas cruzadas para esse cliente em relação ao perfil, como: sexo, idade, habitos de consumo
3 - Vendas cruzadas com os produtos que ele pediu, associados ao que outros clientes compram
4 - Associar dados por pesos de importância com  produtos com maior lucrativide, porutos similares, com estoque proximos de vencimento e/ou com estoque muito alto
5 - Mostrar os últimos produtos comprados por ele.
6 - Listar produtos similares ou relacionados (com estoque).
 *)

