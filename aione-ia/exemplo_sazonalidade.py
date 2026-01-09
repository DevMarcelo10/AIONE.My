"""
Exemplo de uso do DetectorSazonalidade
Demonstra detecção e quantificação de padrões sazonais em vendas farmacêuticas
"""

import sys
import os
from datetime import date, timedelta
import pandas as pd
import numpy as np
from typing import Dict, List

# Adicionar o path do projeto
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from modules.compras.processadores.sazonalidade import DetectorSazonalidade


def exemplo_analise_completa():
    """Exemplo completo de análise de sazonalidade"""

    print("=== EXEMPLO - DETECTOR DE SAZONALIDADE ===\n")

    # 1. INICIALIZAR DETECTOR
    print("1. Inicializando detector de sazonalidade...")
    detector = DetectorSazonalidade()
    print("✅ Detector inicializado\n")

    # 2. CRIAR DADOS SIMULADOS COM PADRÕES SAZONAIS
    print("2. Criando dados simulados com padrões sazonais...")
    df_simulado = criar_dados_sazonais()

    print(f"📊 Dados criados: {len(df_simulado)} registros")
    print(f"   Período: {df_simulado['data'].min().date()} até {df_simulado['data'].max().date()}")
    print(f"   Total vendido: {df_simulado['quantidade'].sum():.0f} unidades\n")

    # 3. ANÁLISE COMPLETA
    print("3. Executando análise completa de sazonalidade...")
    resultado = detector.analisar(df_simulado, min_dias=30)

    print("✅ Análise concluída\n")

    # 4. APRESENTAR RESULTADOS
    apresentar_resultados_sazonalidade(resultado)

    # 5. DEMONSTRAR APLICAÇÃO PRÁTICA
    demonstrar_aplicacao_pratica(detector, resultado)

    # 6. TESTAR COM DADOS INSUFICIENTES
    testar_dados_insuficientes(detector)


def criar_dados_sazonais() -> pd.DataFrame:
    """Cria dados simulados com padrões sazonais conhecidos"""

    np.random.seed(42)  # Reproduzibilidade

    # Período de 4 meses
    data_inicio = date.today() - timedelta(days=120)
    data_fim = date.today()
    datas = pd.date_range(start=data_inicio, end=data_fim, freq='D')

    # Base de demanda
    base_demanda = 15.0

    dados = []

    for data_atual in datas:
        # SAZONALIDADE DIA DA SEMANA
        dia_semana = data_atual.weekday()
        fatores_dia = {0: 0.85, 1: 0.95, 2: 1.00, 3: 1.00, 4: 1.10, 5: 1.15, 6: 0.70}
        fator_dia = fatores_dia[dia_semana]

        # SAZONALIDADE SEMANA DO MÊS
        semana_mes = ((data_atual.day - 1) // 7) + 1
        fatores_semana = {1: 1.15, 2: 1.00, 3: 0.95, 4: 0.90, 5: 0.95}
        fator_semana = fatores_semana.get(semana_mes, 1.0)

        # SAZONALIDADE MENSAL
        mes = data_atual.month
        fatores_mes = {1: 0.90, 2: 0.95, 3: 1.00, 4: 1.00, 5: 1.05, 6: 1.15,
                      7: 1.20, 8: 1.10, 9: 1.00, 10: 0.95, 11: 0.95, 12: 1.00}
        fator_mes = fatores_mes.get(mes, 1.0)

        # Aplicar sazonalidade
        demanda = base_demanda * fator_dia * fator_semana * fator_mes

        # Adicionar ruído
        ruido = np.random.normal(0, 2)
        demanda += ruido
        demanda = max(0, demanda)  # Não pode ser negativo

        dados.append({
            'data': data_atual,
            'quantidade': demanda,
            'valor': demanda * 8.50,  # Preço fictício
            'dia_semana': dia_semana,
            'semana_mes': semana_mes,
            'mes': mes
        })

    return pd.DataFrame(dados)


def apresentar_resultados_sazonalidade(resultado: Dict):
    """Apresenta resultados da análise de sazonalidade"""

    print("=" * 70)
    print("📊 RESULTADOS DA ANÁLISE DE SAZONALIDADE")
    print("=" * 70)

    # RESUMO GERAL
    usar_padrao = resultado.get('usar_padrao', True)
    detectada = resultado.get('sazonalidade_detectada', False)
    forca = resultado.get('forca_sazonalidade', 0.0)
    recomendacao = resultado.get('recomendacao', 'N/A')

    print(f"\n🎯 RESUMO GERAL:")
    print(f"   Sazonalidade detectada: {'✅ SIM' if detectada else '❌ NÃO'}")
    print(f"   Força da sazonalidade: {forca:.3f}")
    print(f"   Usando padrões: {'✅ SIM' if usar_padrao else '❌ NÃO'}")
    print(f"   Recomendação: {recomendacao}")

    # ÍNDICES DIA DA SEMANA
    idx_dia = resultado.get('dia_semana', {})
    conf_dia = idx_dia.pop('confianca', 0) if isinstance(idx_dia, dict) else 0

    print(f"\n📅 SAZONALIDADE DIA DA SEMANA (Confiança: {conf_dia:.0%}):")
    dias_nome = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom']

    for dia_num in range(7):
        if dia_num in idx_dia:
            indice = idx_dia[dia_num]
            variacao = (indice - 1.0) * 100
            sinal = "+" if variacao >= 0 else ""
            print(f"   {dias_nome[dia_num]}: {indice:.2f} ({sinal}{variacao:.0f}%)")

    # ÍNDICES SEMANA DO MÊS
    idx_semana = resultado.get('semana_mes', {})
    conf_semana = idx_semana.pop('confianca', 0) if isinstance(idx_semana, dict) else 0

    print(f"\n📆 SAZONALIDADE SEMANA DO MÊS (Confiança: {conf_semana:.0%}):")
    for semana in range(1, 6):
        if semana in idx_semana:
            indice = idx_semana[semana]
            variacao = (indice - 1.0) * 100
            sinal = "+" if variacao >= 0 else ""
            print(f"   {semana}ª semana: {indice:.2f} ({sinal}{variacao:.0f}%)")

    # ÍNDICES MENSAIS
    idx_mes = resultado.get('mes', {})
    conf_mes = idx_mes.pop('confianca', 0) if isinstance(idx_mes, dict) else 0

    print(f"\n📈 SAZONALIDADE MENSAL (Confiança: {conf_mes:.0%}):")
    meses_nome = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
                  'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']

    # Mostrar apenas meses com maior variação
    meses_ordenados = sorted([(m, idx_mes.get(m, 1.0)) for m in range(1, 13)],
                            key=lambda x: x[1], reverse=True)

    print("   Maiores índices:")
    for i, (mes_num, indice) in enumerate(meses_ordenados[:3]):
        variacao = (indice - 1.0) * 100
        sinal = "+" if variacao >= 0 else ""
        print(f"      {meses_nome[mes_num-1]}: {indice:.2f} ({sinal}{variacao:.0f}%)")

    print()


def demonstrar_aplicacao_pratica(detector: DetectorSazonalidade, resultado: Dict):
    """Demonstra aplicação prática dos ajustes sazonais"""

    print("🔧 DEMONSTRAÇÃO DE APLICAÇÃO PRÁTICA\n")

    # 1. AJUSTE SAZONAL PARA DATAS ESPECÍFICAS
    print("1. Ajuste sazonal para datas específicas:")
    cmd_base = 10.0  # Consumo médio diário base

    datas_teste = [
        date.today(),                           # Hoje
        date.today() + timedelta(days=1),       # Amanhã
        date.today() + timedelta(days=6),       # Próximo sábado (aproximadamente)
        date.today() + timedelta(days=7)        # Próximo domingo (aproximadamente)
    ]

    for data_teste in datas_teste:
        demanda_ajustada = detector.aplicar_ajuste_sazonal(cmd_base, data_teste, resultado)
        dia_nome = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'][data_teste.weekday()]
        fator = demanda_ajustada / cmd_base if cmd_base > 0 else 1.0

        print(f"   {data_teste} ({dia_nome}): {cmd_base:.1f} → {demanda_ajustada:.1f} (fator {fator:.2f})")

    print()

    # 2. PROJEÇÃO PARA PERÍODO
    print("2. Projeção de demanda para próximos 14 dias:")
    projecoes = detector.projetar_demanda_periodo(
        cmd=cmd_base,
        data_inicio=date.today(),
        dias=14,
        indices=resultado
    )

    if projecoes:
        total_projetado = sum(p['demanda_esperada'] for p in projecoes)
        media_fator = np.mean([p['indice_aplicado'] for p in projecoes])

        print(f"   Total projetado: {total_projetado:.1f} unidades")
        print(f"   Fator médio: {media_fator:.2f}")
        print(f"   Variação diária: {min(p['demanda_esperada'] for p in projecoes):.1f} - "
              f"{max(p['demanda_esperada'] for p in projecoes):.1f}")

        # Mostrar primeiros 5 dias
        print("   Primeiros 5 dias:")
        for i in range(min(5, len(projecoes))):
            p = projecoes[i]
            dia_nome = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'][p['data'].weekday()]
            print(f"      {p['data']} ({dia_nome}): {p['demanda_esperada']:.1f} (fator {p['indice_aplicado']:.2f})")

    print()


def demonstrar_metodos_individuais():
    """Demonstra uso de métodos individuais"""

    print("🔍 DEMONSTRAÇÃO DE MÉTODOS INDIVIDUAIS\n")

    detector = DetectorSazonalidade()

    # Criar dados pequenos para teste
    dados_teste = []
    for i in range(21):  # 3 semanas
        data_atual = date.today() - timedelta(days=20-i)
        dados_teste.append({
            'data': data_atual,
            'quantidade': 10 + (i % 7) * 2,  # Variação por dia da semana
            'dia_semana': data_atual.weekday(),
            'semana_mes': ((data_atual.day - 1) // 7) + 1,
            'mes': data_atual.month
        })

    df_teste = pd.DataFrame(dados_teste)

    # 1. ÍNDICES DIA DA SEMANA
    print("1. Cálculo de índices por dia da semana:")
    idx_dia = detector.calcular_indices_dia_semana(df_teste)

    dias_nome = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom']
    for dia_num in range(7):
        if dia_num in idx_dia and isinstance(idx_dia[dia_num], (int, float)):
            print(f"   {dias_nome[dia_num]}: {idx_dia[dia_num]:.2f}")

    print(f"   Confiança: {idx_dia.get('confianca', 0):.0%}")
    print()

    # 2. ÍNDICES PADRÃO
    print("2. Índices padrão de farmácias:")
    print("   Baseados em padrões conhecidos do setor farmacêutico")

    print("   Dia da semana:")
    for dia_num, indice in detector.INDICES_PADRAO['dia_semana'].items():
        print(f"      {dias_nome[dia_num]}: {indice:.2f}")

    print("   Mês do ano (maiores):")
    meses_nome = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
                  'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
    for mes_num, indice in detector.INDICES_PADRAO['mes'].items():
        if indice >= 1.1:  # Mostrar apenas picos
            print(f"      {meses_nome[mes_num-1]}: {indice:.2f}")

    print()


def testar_dados_insuficientes(detector: DetectorSazonalidade):
    """Testa comportamento com dados insuficientes"""

    print("⚠️ TESTE COM DADOS INSUFICIENTES\n")

    # Dados muito poucos (menos que min_dias)
    df_pouco = pd.DataFrame({
        'data': pd.date_range(start=date.today()-timedelta(days=5), periods=5),
        'quantidade': [5, 8, 6, 9, 7],
        'dia_semana': [0, 1, 2, 3, 4],
        'semana_mes': [1, 1, 1, 1, 1],
        'mes': [12, 12, 12, 12, 12]
    })

    print(f"Testando com apenas {len(df_pouco)} dias de dados...")
    resultado_pouco = detector.analisar(df_pouco, min_dias=30)

    print(f"✅ Resultado: usar_padrao = {resultado_pouco['usar_padrao']}")
    print(f"   Recomendação: {resultado_pouco['recomendacao']}")
    print(f"   Sazonalidade detectada: {resultado_pouco['sazonalidade_detectada']}")

    # DataFrame vazio
    print("\nTestando com DataFrame vazio...")
    resultado_vazio = detector.analisar(pd.DataFrame(), min_dias=30)

    print(f"✅ Resultado: usar_padrao = {resultado_vazio['usar_padrao']}")
    print(f"   Recomendação: {resultado_vazio['recomendacao']}")

    print()


def exemplo_integracao_forecast():
    """Exemplo de integração com sistema de forecast"""

    print("🔗 EXEMPLO DE INTEGRAÇÃO COM FORECAST\n")

    detector = DetectorSazonalidade()

    # Simular resultado de análise
    resultado_sazonalidade = {
        'dia_semana': {0: 0.85, 1: 0.95, 2: 1.00, 3: 1.00, 4: 1.10, 5: 1.15, 6: 0.70},
        'semana_mes': {1: 1.15, 2: 1.00, 3: 0.95, 4: 0.90, 5: 0.95},
        'mes': {1: 0.90, 12: 1.00},  # Simulando apenas Jan e Dez
        'sazonalidade_detectada': True,
        'forca_sazonalidade': 0.15
    }

    # CMD base do produto
    cmd_produto = 12.0  # unidades/dia

    print(f"CMD base do produto: {cmd_produto:.1f} unidades/dia")
    print("Aplicando ajustes sazonais para próximos dias:\n")

    # Aplicar para diferentes cenários
    cenarios = [
        ("Segunda-feira comum", date.today().replace(month=3, day=15)),  # março, 3ª semana, segunda
        ("Sexta-feira 1ª semana", date.today().replace(month=7, day=4)),  # julho, 1ª semana, sexta
        ("Sábado 4ª semana", date.today().replace(month=1, day=28)),     # janeiro, 4ª semana, sábado
    ]

    for descricao, data_teste in cenarios:
        cmd_ajustado = detector.aplicar_ajuste_sazonal(cmd_produto, data_teste, resultado_sazonalidade)
        fator_total = cmd_ajustado / cmd_produto
        diferenca = cmd_ajustado - cmd_produto
        sinal = "+" if diferenca >= 0 else ""

        print(f"📅 {descricao}:")
        print(f"   Data: {data_teste}")
        print(f"   CMD ajustado: {cmd_produto:.1f} → {cmd_ajustado:.1f} ({sinal}{diferenca:.1f})")
        print(f"   Fator total: {fator_total:.2f}")
        print()


if __name__ == "__main__":
    try:
        exemplo_analise_completa()
        demonstrar_metodos_individuais()
        exemplo_integracao_forecast()

        print("🎉 Demonstração de sazonalidade concluída com sucesso!")

    except Exception as e:
        print(f"❌ Erro durante execução: {e}")
        import traceback
        traceback.print_exc()