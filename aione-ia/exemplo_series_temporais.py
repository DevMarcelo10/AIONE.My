"""
Exemplo de uso do AnalisadorSeriesTemporal
Demonstra análise de histórico de vendas e extração de padrões estatísticos
"""

import sys
import os
from datetime import date, timedelta
import pandas as pd
import numpy as np

# Adicionar o path do projeto
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from core.database import DatabaseManager
from modules.compras.processadores.series_temporais import AnalisadorSeriesTemporal


def exemplo_analise_completa():
    """Exemplo completo de análise de séries temporais"""

    print("=== EXEMPLO - ANALISADOR DE SÉRIES TEMPORAIS ===\n")

    # 1. INICIALIZAR COMPONENTES
    print("1. Inicializando componentes...")
    db = DatabaseManager()
    analisador = AnalisadorSeriesTemporal(db)

    print("✅ Analisador inicializado\n")

    # 2. BUSCAR PRODUTO PARA ANÁLISE
    print("2. Buscando produtos com histórico...")
    produto_exemplo = buscar_produto_com_historico(analisador)

    if not produto_exemplo:
        print("❌ Nenhum produto com histórico encontrado")
        return

    id_prod, id_filial = produto_exemplo
    print(f"📦 Produto selecionado: ID {id_prod}, Filial {id_filial}\n")

    # 3. ANÁLISE COMPLETA
    print("3. Executando análise completa de séries temporais...")
    resultado = analisador.analisar(id_prod=id_prod, id_filial=id_filial, dias=90)

    print("✅ Análise concluída\n")

    # 4. APRESENTAR RESULTADOS
    apresentar_resultados_analise(resultado, id_prod, id_filial)

    # 5. DEMONSTRAR MÉTODOS INDIVIDUAIS
    demonstrar_metodos_individuais(analisador, id_prod, id_filial)


def buscar_produto_com_historico(analisador: AnalisadorSeriesTemporal) -> tuple:
    """Busca um produto que tenha histórico de vendas"""
    try:
        # Buscar produtos com movimentação recente na tabela ia_arqhistcom
        sql = """
            SELECT DISTINCT IDProd, IDFilial, COUNT(*) as total_movimentos
            FROM ia_arqhistcom
            WHERE TipoHist = 'SAÍDA'
              AND OriItem = 'AIONE'
              AND DatMovi >= DATE_SUB(NOW(), INTERVAL 30 DAY)
            GROUP BY IDProd, IDFilial
            HAVING total_movimentos >= 5
            ORDER BY total_movimentos DESC
            LIMIT 1
        """

        with analisador.db.session_scope() as session:
            from sqlalchemy import text
            result = session.execute(text(sql))
            row = result.fetchone()

        if row:
            return (row.IDProd, row.IDFilial)

        # Fallback: usar IDs fixos para teste
        print("⚠️ Usando produto de exemplo (ID: 1, Filial: 1)")
        return (1, 1)

    except Exception as e:
        print(f"⚠️ Erro ao buscar produto: {e}")
        return (1, 1)


def apresentar_resultados_analise(resultado: dict, id_prod: int, id_filial: int):
    """Apresenta os resultados da análise de forma organizada"""

    print("=" * 60)
    print(f"📊 RESULTADOS DA ANÁLISE - Produto {id_prod}, Filial {id_filial}")
    print("=" * 60)

    # QUALIDADE DOS DADOS
    qualidade = resultado.get('qualidade_dados', 'N/A')
    dias_venda = resultado.get('dias_com_venda', 0)
    dias_total = resultado.get('dias_analisados', 0)
    outliers = resultado.get('outliers_count', 0)

    print(f"\n🎯 QUALIDADE DOS DADOS: {qualidade}")
    print(f"   - Dias com vendas: {dias_venda}/{dias_total}")
    print(f"   - Outliers detectados: {outliers}")

    # ESTATÍSTICAS BÁSICAS
    stats = resultado.get('estatisticas', {})
    print(f"\n📈 ESTATÍSTICAS BÁSICAS:")
    print(f"   - Média diária: {stats.get('media', 0):.2f} unidades")
    print(f"   - Mediana: {stats.get('mediana', 0):.2f} unidades")
    print(f"   - Desvio padrão: {stats.get('desvio_padrao', 0):.2f}")
    print(f"   - Coeficiente variação: {stats.get('coef_variacao', 0):.2%}")
    print(f"   - Min/Max: {stats.get('min', 0):.0f} / {stats.get('max', 0):.0f}")
    print(f"   - Total vendido: {stats.get('total_vendido', 0):.0f} unidades")

    # DISTRIBUIÇÃO PROBABILÍSTICA
    dist = resultado.get('distribuicao', {})
    print(f"\n🎲 DISTRIBUIÇÃO PROBABILÍSTICA:")
    print(f"   - Tipo: {dist.get('distribuicao', 'N/A')}")
    print(f"   - P10 (otimista): {dist.get('p10', 0):.2f}")
    print(f"   - P25: {dist.get('p25', 0):.2f}")
    print(f"   - P50 (mediana): {dist.get('p50', 0):.2f}")
    print(f"   - P75: {dist.get('p75', 0):.2f}")
    print(f"   - P90 (pessimista): {dist.get('p90', 0):.2f}")
    print(f"   - Aderência: {dist.get('aderencia', 0):.0%}")

    # ANÁLISE DE TENDÊNCIA
    tend = resultado.get('tendencia', {})
    print(f"\n📊 ANÁLISE DE TENDÊNCIA:")
    print(f"   - Tendência: {tend.get('tendencia', 'N/A')}")
    print(f"   - Coeficiente: {tend.get('coeficiente', 0):.4f}")
    print(f"   - R² (qualidade): {tend.get('r_squared', 0):.3f}")
    print(f"   - Variação percentual: {tend.get('variacao_percentual', 0):+.1f}%")

    # HISTÓRICO RESUMIDO
    historico = resultado.get('historico', pd.DataFrame())
    if not historico.empty and 'data' in historico.columns and 'quantidade' in historico.columns:
        print(f"\n📅 HISTÓRICO RESUMIDO (últimos 7 dias):")
        ultimos_7 = historico.tail(7)
        for _, row in ultimos_7.iterrows():
            data_str = row['data'].strftime('%d/%m') if hasattr(row['data'], 'strftime') else str(row['data'])[:10]
            print(f"   - {data_str}: {row['quantidade']:.0f} unidades")

    print("\n" + "=" * 60)


def demonstrar_metodos_individuais(analisador: AnalisadorSeriesTemporal, id_prod: int, id_filial: int):
    """Demonstra o uso de métodos individuais da classe"""

    print("\n🔧 DEMONSTRAÇÃO DE MÉTODOS INDIVIDUAIS\n")

    # 1. ESTOQUE ATUAL
    print("1. Consultando estoque atual...")
    estoque = analisador.obter_estoque_atual(id_prod, id_filial)
    print(f"   Estoque atual: {estoque:.2f} unidades\n")

    # 2. GRUPO DO PRODUTO
    print("2. Consultando grupo do produto...")
    grupo = analisador.obter_grupo_produto(id_prod)
    print(f"   Grupo: {grupo if grupo else 'N/A'}\n")

    # 3. ÚLTIMA COMPRA
    print("3. Consultando última compra...")
    ultima_compra = analisador.obter_ultima_compra(id_prod, id_filial)
    if ultima_compra:
        print(f"   Data: {ultima_compra.get('data', 'N/A')}")
        print(f"   Quantidade: {ultima_compra.get('quantidade', 0):.0f}")
        print(f"   Valor unitário: R$ {ultima_compra.get('valor_unitario', 0):.2f}")
        print(f"   Fornecedor: {ultima_compra.get('fornecedor', 'N/A')}")
    else:
        print("   Nenhuma compra encontrada")
    print()

    # 4. HISTÓRICO DETALHADO
    print("4. Obtendo histórico de vendas (30 dias)...")
    df_historico = analisador.obter_historico_vendas(id_prod, id_filial, dias=30)

    if not df_historico.empty:
        total_vendas = df_historico['quantidade'].sum()
        dias_com_vendas = (df_historico['quantidade'] > 0).sum()
        media_diaria = df_historico['quantidade'].mean()

        print(f"   Registros: {len(df_historico)} dias")
        print(f"   Dias com vendas: {dias_com_vendas}")
        print(f"   Total vendido: {total_vendas:.0f} unidades")
        print(f"   Média diária: {media_diaria:.2f} unidades")

        # Análise por dia da semana
        if 'dia_semana' in df_historico.columns:
            vendas_dia = df_historico.groupby('dia_semana')['quantidade'].mean()
            dias_semana = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb']

            print("\n   📅 Vendas médias por dia da semana:")
            for dia_num, venda_media in vendas_dia.items():
                nome_dia = dias_semana[int(dia_num)] if 0 <= dia_num < 7 else f'Dia{dia_num}'
                print(f"      {nome_dia}: {venda_media:.1f} unidades")

    else:
        print("   Nenhum registro encontrado")

    print()

    # 5. DETECÇÃO DE OUTLIERS
    if not df_historico.empty:
        print("5. Detectando outliers...")
        df_outliers = analisador.detectar_outliers(df_historico, metodo='iqr')

        if 'outlier' in df_outliers.columns:
            outliers_encontrados = df_outliers[df_outliers['outlier'] == True]

            if not outliers_encontrados.empty:
                print(f"   Outliers encontrados: {len(outliers_encontrados)}")
                for _, row in outliers_encontrados.head(3).iterrows():
                    data_str = row['data'].strftime('%d/%m') if hasattr(row['data'], 'strftime') else str(row['data'])[:10]
                    print(f"      {data_str}: {row['quantidade']:.0f} unidades")
            else:
                print("   Nenhum outlier detectado")
        print()


def exemplo_dados_simulados():
    """Exemplo com dados simulados para demonstrar funcionalidades"""

    print("\n🧪 EXEMPLO COM DADOS SIMULADOS\n")

    # Criar analisador
    db = DatabaseManager()
    analisador = AnalisadorSeriesTemporal(db)

    # Dados simulados com tendência crescente e sazonalidade
    np.random.seed(42)  # Para resultados reproduzíveis

    datas = pd.date_range(start=date.today() - timedelta(days=60), end=date.today(), freq='D')
    base_demand = 10
    trend = 0.1
    noise = np.random.normal(0, 2, len(datas))

    # Simular sazonalidade semanal (mais vendas na segunda e terça)
    day_factors = {0: 1.2, 1: 1.5, 2: 1.3, 3: 1.0, 4: 0.8, 5: 0.9, 6: 0.7}  # Dom=0 até Sáb=6
    seasonal_factors = [day_factors[d.weekday()] for d in datas]

    quantities = []
    for i, (data, factor) in enumerate(zip(datas, seasonal_factors)):
        qty = base_demand + (i * trend) + noise[i]
        qty *= factor
        quantities.append(max(0, qty))  # Não pode ser negativo

    # Criar DataFrame
    df_simulado = pd.DataFrame({
        'data': datas,
        'quantidade': quantities,
        'valor': [q * 12.5 for q in quantities],  # Preço fictício de R$ 12,50
        'dia_semana': [d.weekday() for d in datas],
        'semana_mes': [((d.day - 1) // 7) + 1 for d in datas],
        'mes': [d.month for d in datas]
    })

    print("📊 Dados simulados criados:")
    print(f"   Período: {len(df_simulado)} dias")
    print(f"   Demanda base: {base_demand} unidades/dia")
    print(f"   Tendência: +{trend} unidade/dia")
    print(f"   Total simulado: {df_simulado['quantidade'].sum():.0f} unidades\n")

    # Analisar dados simulados
    print("🔍 Analisando dados simulados...\n")

    estatisticas = analisador.calcular_estatisticas_basicas(df_simulado)
    distribuicao = analisador.gerar_distribuicao_probabilistica(df_simulado)
    tendencia = analisador.calcular_tendencia(df_simulado)
    df_outliers = analisador.detectar_outliers(df_simulado)

    # Resultados
    print("📈 RESULTADOS DA ANÁLISE SIMULADA:")
    print(f"   Média: {estatisticas['media']:.2f} ± {estatisticas['desvio_padrao']:.2f}")
    print(f"   Tendência detectada: {tendencia['tendencia']} (R²={tendencia['r_squared']:.3f})")
    print(f"   P50 (mediana): {distribuicao['p50']:.2f}")
    print(f"   Outliers: {df_outliers['outlier'].sum()} de {len(df_outliers)}")

    # Verificar se a tendência foi detectada corretamente
    if tendencia['tendencia'] == 'CRESCENTE':
        print("✅ Tendência crescente detectada corretamente!")
    else:
        print("⚠️ Tendência não detectada como esperado")

    print()


if __name__ == "__main__":
    try:
        exemplo_analise_completa()
        exemplo_dados_simulados()

        print("🎉 Demonstração concluída com sucesso!")

    except Exception as e:
        print(f"❌ Erro durante execução: {e}")
        import traceback
        traceback.print_exc()