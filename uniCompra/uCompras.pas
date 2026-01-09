unit uCompras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, AdvSmoothPanel,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, System.Threading;

type
  TFrmCompras = class(TForm)
    PanelShow: TAdvSmoothPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCompras: TFrmCompras;

implementation

{$R *.dfm}

uses uLibFarm, uMenComp;

procedure TFrmCompras.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmCompras.FormShow(Sender: TObject);
begin
   FrmCompras := Self;
end;

procedure TFrmCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := TCloseAction.caFree;
   Self   := nil
end;

end.

(*
  "COMPRAR O NECESSÁRIO ATÉ O VENCIMENTO DE CADA BOLETO - Just-in-Time"
  "Sistema de compras para reduzir o estoque parado e melhorar o fluxo de caixa."
  "TER ESTOQUE DISPONÍVEL ATÉ O PRÓXIMO RECEBIMENTO DE COMPRAS - Lead Time"
  "Previsão do tempo necessário desde a realização do pedido até a entrega."
  "Ajuste do timing das compras para garantir que o novo estoque chegue antes que o atual se esgote."

  1. IA - DEMANDA DE ESTOQUE / PRODUTO

     1. Cálculo da demanda de estoque, com as futuras previsões por Produto / Filial

        1.1 Agrupar produtos por sazonalidade para prever a demanda para os próximos
          10/20/30/45 dias, acumulando em períodos anuais até os 3 últimos anos - OK

        1.2 Agrupa produtos por qtd.vendida nos últimos 10/20/30/40 dias. - OK

        1.3 Verifica as vendas dos últimos 3 meses e veja a demanda: - OK
            - Se a demanda 10 dias -> separa os produto para os próximos 10 dias
            - Se a demanda 20 dias -> separa os produto para os próximos 20 dias
            - Se a demanda 30 dias -> separa os produto para os próximos 30 dias
            - Se a demanda 45 dias -> separa os produto para os próximos 45 dias

        1.4 Analisar relação com Clima (Chuva,Temperatura), eventos Locais e tendências de saúde, fatores macroeconômicos

        1.6 Ponderar a quantidade à pedir, de acordo com as quantidades levantadas nos 1.3 e 1.4 na forma:

            1.6.1 Se houve grande diferença na demanda (15% abaixo ou acima) nos últimos dias deste ano em
                  relação ao mesmo agrupamento de dias do ano anterior, mas calculando dentro do agrupamento
                  de dias (10/20/30/40) "futuros" -> SINAL DE INVERSÃO DE SAZONALIDADE e deve ser considerada
                  a quantidade pedida nos anos anteriores.

            1.6.2 Caso contrário ao cenário acima, manter a quantidade demandadad nos últimos (10/20/30/40)
                  anteriores à data atual.

            1.6.3 Ambas quantidade demandadas acima (1.5.1 ou 1.5.2) poderão ser modificadas caso haja uma diferença
                  (15% abaixo ou acima) em relação aos cálculos da REDE NEURAL.

            1.6.4 A REDE NEURAL treinada por agrupamento de dias (10/20/30/40) com as quantidade acumuladas
                  dentro de faixas determinadas de cada fator.

  2. VERIFCAR ESTOQUE

     2.1  Ver estoque total, analisar estoque de cada FILIAL.
     2.2  De acordo com a PREVISÃO DE VENDAS de cada FILIAL, redistribuir estoque em excesso entre FILIAIS (Trilho)
     2.3  Produtos com quantidade > 0 nas faixas de dias, do mesmo período dos anos anteriores - o estoque após o
          Trilho =  QUANTIDADE À PEDIR.

  3. REALIZAR ORÇAMENTO:

     3.1 Integração com Distribuidoras


  4. ANALISE PREÇOS COTADOS:

     4.1  Menor custo, prazo, caixa, impostos, regime tributário da farmácia, custo financeiro (desconto adicional com industria)
          Desc.Finan. = Preço Fábrica(PF) - desconto normal - desconto boleto + impostos

     4.2  Negociações expecíficas com Fornecedor


  3. REAVALIAR QUANTIDADES À PEDIR:

     3.1 Demanda X Prazo Pagto em relação ao prazo médio de vencimento dos titulos do fornecedor de determinado
         produto gerando assim demandas: 10,20,30,45

     3.2 Em relação ao prazo médio de vencimento dos títulos da compra do produto verificar se vendeu estoque comprado no
         tempo médio de vencimento da fatura, casos esteja fora dos limites de pagamento, ou seja, prazo médio de pagamento
         menor que o giro do estoque, verificar o impacto no Fluxo de Caixa, caso não for suficiente, este produto deve ficar
         fora do pedido atual até que o Fluxo de Caixa (com previsão de vendas para o período) seja reestabelecido.
*)

