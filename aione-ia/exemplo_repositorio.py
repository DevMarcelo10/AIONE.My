"""
Exemplo de uso do ForecastRepositorio
Demonstra como salvar e consultar forecasts na tabela ia_arqforecast
"""

import sys
import os
from datetime import date, timedelta

# Adicionar o path do projeto
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from core.database import DatabaseManager
from modules.compras.processadores import (
    ForecastEngine,
    ForecastRepositorio,
    MetricasProduto,
    ResultadoForecast
)


def exemplo_uso_repositorio():
    """Exemplo completo de uso do repositório"""

    print("=== EXEMPLO DE USO - FORECAST REPOSITÓRIO ===\n")

    # 1. INICIALIZAR COMPONENTES
    print("1. Inicializando componentes...")
    db = DatabaseManager()
    repo = ForecastRepositorio(db)
    engine = ForecastEngine(db)

    print("✅ Componentes inicializados\n")

    # 2. LISTAR PRODUTOS SEM FORECAST
    print("2. Produtos sem forecast ativo (filial 1):")
    produtos_sem_forecast = repo.listar_produtos_sem_forecast(id_filial=1, limite=5)

    for produto in produtos_sem_forecast:
        print(f"   - {produto['Despro']} (ID: {produto['IDProd']})")

    if not produtos_sem_forecast:
        print("   Nenhum produto encontrado")
    print()

    # 3. GERAR E SALVAR FORECAST
    if produtos_sem_forecast:
        print("3. Gerando forecast para primeiro produto...")
        produto = produtos_sem_forecast[0]

        try:
            # Gerar forecast
            resultado = engine.gerar_forecast(
                id_prod=produto['IDProd'],
                id_filial=1
            )

            # Salvar no repositório
            id_forecast = repo.salvar(resultado, dias_validade=7)
            print(f"✅ Forecast salvo com ID: {id_forecast}")

            # Mostrar métricas
            m = resultado.metricas
            print(f"   CMD: {m.consumo_medio_diario:.2f}")
            print(f"   Cenário conservador: {m.cen_conservador:.0f} unidades")
            print(f"   Risco ruptura: {m.risco_ruptura:.0%}")
            print(f"   Confiança: {resultado.confianca:.0f}%")

        except Exception as e:
            print(f"❌ Erro ao gerar forecast: {e}")

    print()

    # 4. CONSULTAR FORECASTS ATIVOS
    print("4. Forecasts ativos da filial 1:")
    forecasts_ativos = repo.listar_filial(
        id_filial=1,
        apenas_ativos=True,
        ordem='risco',
        limite=5
    )

    for forecast in forecasts_ativos:
        print(f"   - {forecast.get('produto_nome', 'N/A')} | "
              f"Risco: {forecast.get('RiscoRupt', 0):.0%} | "
              f"Dias cobertura: {forecast.get('DiasCobre', 0):.1f}")

    if not forecasts_ativos:
        print("   Nenhum forecast ativo encontrado")
    print()

    # 5. CONSULTAR FORECASTS CRÍTICOS
    print("5. Forecasts críticos (abaixo ponto de pedido):")
    criticos = repo.listar_filial(
        id_filial=1,
        apenas_ativos=True,
        apenas_criticos=True,
        limite=3
    )

    for forecast in criticos:
        print(f"   - {forecast.get('produto_nome', 'N/A')} | "
              f"Estoque: {forecast.get('EstqAtual', 0):.0f} | "
              f"Ponto pedido: {forecast.get('PontoPed', 0):.0f}")

    if not criticos:
        print("   Nenhum produto crítico")
    print()

    # 6. RESUMO ESTATÍSTICO
    print("6. Resumo estatístico da filial 1:")
    resumo = repo.resumo_filial(id_filial=1)

    print(f"   Total produtos: {resumo['total_produtos']}")
    print(f"   Com forecast ativo: {resumo['com_forecast_ativo']}")
    print(f"   Abaixo ponto pedido: {resumo['abaixo_ponto_pedido']}")
    print(f"   Risco alto (>30%): {resumo['risco_ruptura_alto']}")
    print(f"   Confiança média: {resumo['confianca_media']:.1f}%")

    qualidade = resumo['qualidade_dados']
    print(f"   Qualidade dados - Boa: {qualidade['BOA']}, "
          f"Média: {qualidade['MEDIA']}, Ruim: {qualidade['RUIM']}")

    if resumo['ultima_atualizacao']:
        print(f"   Última atualização: {resumo['ultima_atualizacao']}")
    print()

    # 7. PRODUTOS PARA RECÁLCULO
    print("7. Produtos que precisam recálculo:")
    para_recalculo = repo.obter_produtos_para_recalculo(id_filial=1, max_produtos=3)

    for produto in para_recalculo:
        print(f"   - {produto['produto_nome']} | "
              f"Risco: {produto['risco_atual']:.0%} | "
              f"Cobertura: {produto['dias_cobertura']:.1f} dias")

    if not para_recalculo:
        print("   Todos forecasts atualizados")
    print()

    # 8. OPERAÇÕES DE MANUTENÇÃO
    print("8. Operações de manutenção:")

    # Marcar expirados
    expirados = repo.marcar_expirados()
    print(f"   Forecasts expirados: {expirados}")

    # Verificar se existe forecast ativo para produto específico
    if forecasts_ativos:
        primeiro = forecasts_ativos[0]
        existe = repo.existe_ativo(primeiro['IDProd'], primeiro['IDFilial'])
        print(f"   Forecast ativo para produto {primeiro['IDProd']}: {existe}")

    print("\n=== FIM DO EXEMPLO ===")


def exemplo_salvar_lote():
    """Exemplo de salvamento em lote"""

    print("\n=== EXEMPLO SALVAMENTO EM LOTE ===")

    db = DatabaseManager()
    repo = ForecastRepositorio(db)
    engine = ForecastEngine(db)

    # Buscar produtos para processar
    produtos = repo.listar_produtos_sem_forecast(id_filial=1, limite=3)

    if not produtos:
        print("Nenhum produto encontrado para processamento em lote")
        return

    print(f"Processando {len(produtos)} produtos em lote...")

    resultados = []
    for produto in produtos:
        try:
            resultado = engine.gerar_forecast(
                id_prod=produto['IDProd'],
                id_filial=1
            )
            resultados.append(resultado)
            print(f"✅ Forecast gerado para {produto['Despro']}")

        except Exception as e:
            print(f"❌ Erro no produto {produto['Despro']}: {e}")

    if resultados:
        count_salvos = repo.salvar_lote(resultados, dias_validade=7)
        print(f"\n📊 Resultado: {count_salvos}/{len(resultados)} forecasts salvos com sucesso")
    else:
        print("Nenhum forecast foi gerado")


if __name__ == "__main__":
    try:
        exemplo_uso_repositorio()
        exemplo_salvar_lote()

    except Exception as e:
        print(f"Erro durante execução: {e}")
        import traceback
        traceback.print_exc()