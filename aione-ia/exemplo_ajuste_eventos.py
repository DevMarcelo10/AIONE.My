"""
Exemplo de uso do AjustadorEventos
Demonstra ajuste de previsões baseado em eventos futuros detectados pelos coletores
"""

import sys
import os
from datetime import date, timedelta
from typing import Dict, List

# Adicionar o path do projeto
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from core.database import DatabaseManager
from modules.compras.processadores.ajuste_eventos import AjustadorEventos


def exemplo_ajuste_completo():
    """Exemplo completo de ajuste por eventos"""

    print("=== EXEMPLO - AJUSTADOR DE EVENTOS ===\n")

    # 1. INICIALIZAR COMPONENTES
    print("1. Inicializando ajustador de eventos...")
    db = DatabaseManager()
    ajustador = AjustadorEventos(db)

    print("✅ Ajustador inicializado")
    print(f"   Categorias configuradas: {len(ajustador.CATEGORIAS_GRUPOS)}")
    print(f"   Níveis de severidade: {len(ajustador.MULT_SEVERIDADE)}\n")

    # 2. DEMONSTRAR BUSCA DE DADOS
    demonstrar_busca_dados(ajustador)

    # 3. EXEMPLO COM DADOS SIMULADOS
    exemplo_calculo_ajustes(ajustador)

    # 4. TESTE DE CATEGORIAS
    testar_mapeamento_categorias(ajustador)

    # 5. DEMONSTRAR APLICAÇÃO EM CENÁRIOS
    demonstrar_aplicacao_cenarios(ajustador)


def demonstrar_busca_dados(ajustador: AjustadorEventos):
    """Demonstra busca de eventos e alertas"""

    print("2. Demonstrando busca de dados...\n")

    # Período de teste
    data_inicio = date.today()
    data_fim = date.today() + timedelta(days=30)
    id_regiao = 1

    print(f"📅 Período de análise: {data_inicio} até {data_fim}")
    print(f"🌍 Região: {id_regiao}\n")

    # 2.1 BUSCAR EVENTOS
    print("2.1 Buscando eventos ativos no período...")
    eventos = ajustador.obter_eventos_periodo(data_inicio, data_fim, id_regiao)

    if eventos:
        print(f"   ✅ {len(eventos)} evento(s) encontrado(s):")
        for evento in eventos[:3]:  # Mostrar apenas primeiros 3
            print(f"      - {evento.get('DescEvt', 'N/A')} ({evento.get('TipoEvt', 'N/A')})")
            print(f"        Impacto: {evento.get('PercImpac', 0)}%")
    else:
        print("   ⚠️ Nenhum evento encontrado no período")
    print()

    # 2.2 BUSCAR ALERTAS
    print("2.2 Buscando alertas ativos...")
    alertas = ajustador.obter_alertas_ativos(id_regiao)

    if alertas:
        print(f"   ✅ {len(alertas)} alerta(s) ativo(s):")
        for alerta in alertas[:3]:  # Mostrar apenas primeiros 3
            print(f"      - {alerta.get('DescAlert', 'N/A')} ({alerta.get('TipAlerta', 'N/A')})")
            print(f"        Severidade: {alerta.get('Severidade', 'N/A')}")
    else:
        print("   ⚠️ Nenhum alerta ativo encontrado")
    print()

    # 2.3 BUSCAR CORRELAÇÕES
    print("2.3 Buscando correlações para produto exemplo...")
    id_prod_teste = 1
    id_grupo_teste = 1

    correlacoes = ajustador.obter_correlacoes_produto(id_prod_teste, id_grupo_teste)

    if correlacoes:
        print(f"   ✅ {len(correlacoes)} correlação(ões) encontrada(s):")
        for corr in correlacoes[:2]:  # Mostrar apenas primeiras 2
            print(f"      - Tipo: {corr.get('TipoEvento', 'N/A')}")
            print(f"        Impacto: {corr.get('PercImpac', 0)}%")
            print(f"        Confiança: {corr.get('Confianca', 0)}%")
    else:
        print("   ⚠️ Nenhuma correlação encontrada")
    print()


def exemplo_calculo_ajustes(ajustador: AjustadorEventos):
    """Exemplo de cálculo completo de ajustes"""

    print("3. Exemplo de cálculo de ajustes...\n")

    # Parâmetros do exemplo
    id_prod = 1        # Produto exemplo
    id_grupo = 1       # Grupo antigripais
    id_filial = 1      # Filial exemplo
    id_regiao = 1      # Região exemplo
    data_inicio = date.today()
    data_fim = date.today() + timedelta(days=30)

    print(f"📦 Produto: {id_prod} (Grupo: {id_grupo})")
    print(f"🏪 Filial: {id_filial} (Região: {id_regiao})")
    print(f"📅 Período: {data_inicio} até {data_fim}\n")

    # Executar cálculo
    print("🔄 Executando cálculo de ajustes...")
    resultado = ajustador.calcular_ajustes(
        id_prod=id_prod,
        id_grupo=id_grupo,
        id_filial=id_filial,
        id_regiao=id_regiao,
        data_inicio=data_inicio,
        data_fim=data_fim
    )

    print("✅ Cálculo concluído\n")

    # Apresentar resultados
    apresentar_resultado_ajustes(resultado)


def apresentar_resultado_ajustes(resultado: Dict):
    """Apresenta resultados do cálculo de ajustes"""

    print("📊 RESULTADOS DO AJUSTE:\n")

    # Fator principal
    fator = resultado.get('fator_ajuste', 1.0)
    eventos = resultado.get('eventos_aplicados', [])
    alertas = resultado.get('alertas_aplicados', [])
    correlacoes = resultado.get('correlacoes_usadas', [])
    recomendacao = resultado.get('recomendacao', 'N/A')

    print(f"🎯 FATOR DE AJUSTE: {fator:.3f}")

    if fator > 1:
        percentual = (fator - 1) * 100
        print(f"   📈 Aumento de {percentual:.1f}% na demanda")
    elif fator < 1:
        percentual = (1 - fator) * 100
        print(f"   📉 Redução de {percentual:.1f}% na demanda")
    else:
        print("   ➖ Sem alteração na demanda")

    print(f"\n💡 RECOMENDAÇÃO: {recomendacao}\n")

    # Eventos aplicados
    if eventos:
        print(f"⚡ EVENTOS APLICADOS ({len(eventos)}):")
        for i, evento in enumerate(eventos, 1):
            impacto = evento.get('impacto_percentual', 1.0)
            percentual = (impacto - 1) * 100
            sinal = "+" if percentual >= 0 else ""
            print(f"   {i}. {evento.get('evento', 'N/A')}")
            print(f"      Tipo: {evento.get('tipo', 'N/A')}")
            print(f"      Impacto: {sinal}{percentual:.1f}% (fator {impacto:.2f})")
            print(f"      Período: {evento.get('data_inicio_impacto')} até {evento.get('data_fim_impacto')}")
            print(f"      Confiança: {evento.get('confianca', 0):.0f}%")
        print()

    # Alertas aplicados
    if alertas:
        print(f"🚨 ALERTAS APLICADOS ({len(alertas)}):")
        for i, alerta in enumerate(alertas, 1):
            impacto = alerta.get('impacto_percentual', 1.0)
            percentual = (impacto - 1) * 100
            sinal = "+" if percentual >= 0 else ""
            print(f"   {i}. {alerta.get('alerta', 'N/A')}")
            print(f"      Tipo: {alerta.get('tipo', 'N/A')}")
            print(f"      Severidade: {alerta.get('severidade', 'N/A')}")
            print(f"      Impacto: {sinal}{percentual:.1f}% (fator {impacto:.2f})")
            print(f"      Período: {alerta.get('data_inicio_impacto')} até {alerta.get('data_fim_impacto')}")
        print()

    # Correlações utilizadas
    if correlacoes:
        print(f"🔗 CORRELAÇÕES UTILIZADAS: {len(correlacoes)} ID(s)")
        print(f"   IDs: {', '.join(map(str, correlacoes))}\n")

    # Detalhamento diário (primeiros 5 dias)
    detalhamento = resultado.get('detalhamento_diario', [])
    if detalhamento:
        print("📅 DETALHAMENTO DIÁRIO (primeiros 5 dias):")
        for dia in detalhamento[:5]:
            data = dia.get('data', 'N/A')
            fator_dia = dia.get('fator_ajuste', 1.0)
            eventos_dia = dia.get('eventos_ativos', 0)
            alertas_dia = dia.get('alertas_ativos', 0)

            variacao = (fator_dia - 1) * 100
            sinal = "+" if variacao >= 0 else ""

            print(f"   {data}: fator {fator_dia:.2f} ({sinal}{variacao:.1f}%) "
                  f"- {eventos_dia} eventos, {alertas_dia} alertas")
        print()


def testar_mapeamento_categorias(ajustador: AjustadorEventos):
    """Testa mapeamento de categorias para grupos"""

    print("4. Testando mapeamento de categorias...\n")

    # Cenários de teste
    cenarios = [
        {
            'id_grupo': 1,
            'categorias': ['antigripais'],
            'esperado': True,
            'descricao': 'Grupo 1 (antigripais) com categoria antigripais'
        },
        {
            'id_grupo': 5,
            'categorias': ['protetor_solar'],
            'esperado': True,
            'descricao': 'Grupo 5 (protetor solar) com categoria protetor_solar'
        },
        {
            'id_grupo': 1,
            'categorias': ['vitaminas'],
            'esperado': False,
            'descricao': 'Grupo 1 (antigripais) com categoria vitaminas'
        },
        {
            'id_grupo': 999,
            'categorias': ['antigripais'],
            'esperado': False,
            'descricao': 'Grupo inexistente com categoria antigripais'
        }
    ]

    print("🧪 CENÁRIOS DE TESTE:")
    for i, cenario in enumerate(cenarios, 1):
        id_grupo = cenario['id_grupo']
        categorias = cenario['categorias']
        esperado = cenario['esperado']
        descricao = cenario['descricao']

        resultado = ajustador._produto_afetado(id_grupo, categorias)

        status = "✅" if resultado == esperado else "❌"
        print(f"   {i}. {status} {descricao}")
        print(f"      Resultado: {resultado}, Esperado: {esperado}")

    print()

    # Mostrar mapeamento completo
    print("📋 MAPEAMENTO DE CATEGORIAS CONFIGURADO:")
    categorias_ordenadas = sorted(ajustador.CATEGORIAS_GRUPOS.items())
    for categoria, grupos in categorias_ordenadas[:10]:  # Mostrar primeiras 10
        print(f"   {categoria}: grupos {grupos}")

    if len(ajustador.CATEGORIAS_GRUPOS) > 10:
        print(f"   ... e mais {len(ajustador.CATEGORIAS_GRUPOS) - 10} categorias")

    print()


def demonstrar_aplicacao_cenarios(ajustador: AjustadorEventos):
    """Demonstra aplicação de ajustes em diferentes cenários"""

    print("5. Demonstrando aplicação em cenários de forecast...\n")

    # Valores base de exemplo
    valores_base = {
        'OTIMISTA': 100.0,    # P10 - cenário otimista
        'CONSERVADOR': 150.0, # P50 - cenário conservador
        'CRITICO': 200.0      # P90 - cenário crítico
    }

    # Fatores de ajuste para teste
    fatores_teste = [0.7, 1.0, 1.3, 1.8]  # -30%, sem ajuste, +30%, +80%

    print("📊 APLICAÇÃO DE AJUSTES POR CENÁRIO:")
    print("   Valores base: Otimista=100, Conservador=150, Crítico=200\n")

    for fator in fatores_teste:
        variacao = (fator - 1) * 100
        sinal = "+" if variacao >= 0 else ""
        print(f"🎯 FATOR {fator:.1f} ({sinal}{variacao:.0f}%):")

        for tipo_cenario, valor_base in valores_base.items():
            valor_ajustado = ajustador.aplicar_ajuste_cenario(
                valor_base=valor_base,
                fator_ajuste=fator,
                tipo_cenario=tipo_cenario
            )

            diferenca = valor_ajustado - valor_base
            sinal_dif = "+" if diferenca >= 0 else ""

            print(f"   {tipo_cenario:12}: {valor_base:6.1f} → {valor_ajustado:6.1f} "
                  f"({sinal_dif}{diferenca:+5.1f})")

        print()


def exemplo_combinacao_impactos():
    """Demonstra lógica de combinação de múltiplos impactos"""

    print("6. Exemplo de combinação de múltiplos impactos...\n")

    db = DatabaseManager()
    ajustador = AjustadorEventos(db)

    # Simular múltiplos impactos
    impactos_simulados = [
        {
            'tipo': 'ONDA_FRIO',
            'impacto_percentual': 1.5,  # +50%
            'aplicavel': True
        },
        {
            'tipo': 'ONDA_FRIO',
            'impacto_percentual': 1.3,  # +30% (mesmo tipo, deve usar maior)
            'aplicavel': True
        },
        {
            'tipo': 'SURTO',
            'impacto_percentual': 1.2,  # +20%
            'aplicavel': True
        },
        {
            'tipo': 'PROMOCAO',
            'impacto_percentual': 0.8,  # -20%
            'aplicavel': True
        }
    ]

    print("📋 IMPACTOS SIMULADOS:")
    for i, impacto in enumerate(impactos_simulados, 1):
        percentual = (impacto['impacto_percentual'] - 1) * 100
        sinal = "+" if percentual >= 0 else ""
        print(f"   {i}. {impacto['tipo']}: {sinal}{percentual:.0f}% "
              f"(fator {impacto['impacto_percentual']:.1f})")

    print()

    # Combinar impactos
    fator_combinado = ajustador.combinar_impactos(impactos_simulados)

    print(f"🧮 LÓGICA DE COMBINAÇÃO:")
    print(f"   1. Mesmo tipo (ONDA_FRIO): usa maior valor (1.5)")
    print(f"   2. Tipos diferentes: multiplica (1.5 × 1.2 × 0.8)")
    print(f"   3. Aplicar limites (0.5 ≤ valor ≤ 3.0)")
    print(f"   4. Resultado: {fator_combinado:.2f}")

    variacao_final = (fator_combinado - 1) * 100
    sinal = "+" if variacao_final >= 0 else ""
    print(f"   5. Impacto final: {sinal}{variacao_final:.1f}%\n")


if __name__ == "__main__":
    try:
        exemplo_ajuste_completo()
        exemplo_combinacao_impactos()

        print("🎉 Demonstração de ajuste por eventos concluída com sucesso!")

    except Exception as e:
        print(f"❌ Erro durante execução: {e}")
        import traceback
        traceback.print_exc()