# =============================================================================
# NOVOS ENDPOINTS PARA CONSULTA DO CACHE DE FORECAST
# Adicionar ao routes.py após os endpoints existentes
# =============================================================================

# ===== ADICIONAR IMPORTS NO TOPO DO ARQUIVO =====
from sqlalchemy import text
from datetime import date, timedelta


# ===== ADICIONAR NO FINAL DOS ENDPOINTS EXISTENTES =====

@router.get("/forecast/cache/{id_filial}",
           response_model=List[Dict[str, Any]],
           summary="Lista forecast em cache da filial",
           description="Retorna todos os forecasts ativos em cache para uma filial",
           tags=["Forecast Cache"])
async def listar_forecast_cache(
    id_filial: int,
    apenas_criticos: bool = Query(False, description="Apenas produtos críticos"),
    limit: int = Query(100, le=1000, description="Limite de registros")
):
    """
    Lista todos os forecasts ativos no cache para uma filial.

    - **id_filial**: ID da filial
    - **apenas_criticos**: Se true, retorna apenas produtos com alto risco
    - **limit**: Limite de registros (máx 1000)
    """
    try:
        with DatabaseManager().session_scope() as session:

            # Query base
            query_base = """
                SELECT
                    fc.IDForecast,
                    fc.IDProd,
                    p.Despro as produto_nome,
                    fc.DatCalculo,
                    fc.DatValidade,
                    fc.ConsMedio,
                    fc.ConsDesvio,
                    fc.EstqAtual,
                    fc.DiasCobre,
                    fc.CenOtim,
                    fc.CenCons,
                    fc.CenCrit,
                    fc.RiscoRupt,
                    fc.Confianca,
                    fc.QualidDados,
                    fc.Tendencia,
                    fc.Status
                FROM ia_arqforecast fc
                INNER JOIN arqproduto p ON fc.IDProd = p.IDProd
                WHERE fc.IDFilial = :id_filial
                  AND fc.Status = 'ATIVO'
                  AND fc.DatValidade >= CURDATE()
            """

            # Adicionar filtro críticos se solicitado
            if apenas_criticos:
                query_base += """
                    AND (fc.RiscoRupt > 0.3 OR fc.DiasCobre <= 7 OR fc.EstqAtual <= fc.PontoPed)
                """

            query_base += """
                ORDER BY fc.RiscoRupt DESC, fc.DiasCobre ASC
                LIMIT :limit
            """

            resultado = session.execute(text(query_base), {
                'id_filial': id_filial,
                'limit': limit
            }).fetchall()

            if not resultado:
                return []

            # Converter para formato da API
            forecasts = []
            for row in resultado:
                forecasts.append({
                    'id_forecast': row.IDForecast,
                    'id_produto': row.IDProd,
                    'produto_nome': row.produto_nome,
                    'data_calculo': row.DatCalculo.isoformat(),
                    'valido_ate': row.DatValidade.isoformat(),
                    'consumo_medio_diario': float(row.ConsMedio),
                    'desvio_padrao': float(row.ConsDesvio),
                    'estoque_atual': float(row.EstqAtual),
                    'dias_cobertura': float(row.DiasCobre),
                    'cenario_otimista': float(row.CenOtim),
                    'cenario_conservador': float(row.CenCons),
                    'cenario_critico': float(row.CenCrit),
                    'risco_ruptura': float(row.RiscoRupt),
                    'confianca': float(row.Confianca),
                    'qualidade_dados': row.QualidDados,
                    'tendencia': row.Tendencia,
                    'status': row.Status
                })

            return forecasts

    except Exception as e:
        logger.error(f"Erro ao listar forecast cache: {e}")
        raise HTTPException(
            status_code=500,
            detail=f"Erro interno: {str(e)}"
        )


@router.get("/forecast/cache/produto/{id_prod}",
           response_model=Dict[str, Any],
           summary="Forecast em cache de produto específico",
           description="Retorna forecast em cache para produto específico",
           tags=["Forecast Cache"])
async def obter_forecast_cache_produto(
    id_prod: int,
    id_filial: int = Query(..., description="ID da filial")
):
    """
    Obtém forecast em cache para um produto específico.

    - **id_prod**: ID do produto
    - **id_filial**: ID da filial
    """
    try:
        with DatabaseManager().session_scope() as session:

            query = """
                SELECT
                    fc.*,
                    p.Despro as produto_nome,
                    g.Desgru as grupo_nome
                FROM ia_arqforecast fc
                INNER JOIN arqproduto p ON fc.IDProd = p.IDProd
                LEFT JOIN arqgrupo g ON fc.IDGrupo = g.IDGrupo
                WHERE fc.IDProd = :id_prod
                  AND fc.IDFilial = :id_filial
                  AND fc.Status = 'ATIVO'
                  AND fc.DatValidade >= CURDATE()
                ORDER BY fc.DatCalculo DESC
                LIMIT 1
            """

            resultado = session.execute(text(query), {
                'id_prod': id_prod,
                'id_filial': id_filial
            }).fetchone()

            if not resultado:
                raise HTTPException(
                    status_code=404,
                    detail="Forecast não encontrado no cache"
                )

            # Converter para formato completo
            import json

            forecast = {
                'id_forecast': resultado.IDForecast,
                'produto': {
                    'id': resultado.IDProd,
                    'nome': resultado.produto_nome,
                    'grupo': resultado.grupo_nome
                },
                'filial_id': resultado.IDFilial,
                'calculo': {
                    'data_calculo': resultado.DatCalculo.isoformat(),
                    'valido_ate': resultado.DatValidade.isoformat(),
                    'dias_historico': resultado.DiasHist,
                    'dias_cobertura_alvo': resultado.DiasCobreAlvo,
                    'tempo_reposicao': resultado.TempoRepo
                },
                'consumo': {
                    'medio_diario': float(resultado.ConsMedio),
                    'desvio_padrao': float(resultado.ConsDesvio),
                    'coeficiente_variacao': float(resultado.ConsCoefVar or 0),
                    'tendencia': resultado.Tendencia
                },
                'estoque': {
                    'atual': float(resultado.EstqAtual),
                    'seguranca': float(resultado.EstqSegur),
                    'ponto_pedido': float(resultado.PontoPed),
                    'dias_cobertura': float(resultado.DiasCobre)
                },
                'cenarios_compra': {
                    'otimista_p10': float(resultado.CenOtim),
                    'conservador_p50': float(resultado.CenCons),
                    'critico_p90': float(resultado.CenCrit)
                },
                'analise': {
                    'risco_ruptura': float(resultado.RiscoRupt),
                    'confianca': float(resultado.Confianca),
                    'qualidade_dados': resultado.QualidDados,
                    'fator_ajuste': float(resultado.FatorAjuste),
                    'sazonalidade_detectada': bool(resultado.SazonalDetec)
                },
                'auditoria': {
                    'eventos_aplicados': json.loads(resultado.EventosJSON or '[]'),
                    'alertas_gerados': json.loads(resultado.AlertasJSON or '[]'),
                    'indices_sazonais': json.loads(resultado.IndSazonJSON or '{}')
                },
                'status': resultado.Status
            }

            return forecast

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Erro ao obter forecast cache: {e}")
        raise HTTPException(
            status_code=500,
            detail=f"Erro interno: {str(e)}"
        )


@router.get("/forecast/dashboard/{id_filial}",
           response_model=Dict[str, Any],
           summary="Dashboard executivo de forecast",
           description="Visão executiva do forecast para tomada de decisão",
           tags=["Forecast Cache"])
async def dashboard_forecast(id_filial: int):
    """
    Dashboard executivo com métricas consolidadas de forecast.

    - **id_filial**: ID da filial
    """
    try:
        with DatabaseManager().session_scope() as session:

            # Query consolidada para dashboard
            query_dashboard = """
                SELECT
                    COUNT(*) as total_produtos,
                    COUNT(CASE WHEN fc.RiscoRupt > 0.5 THEN 1 END) as produtos_criticos,
                    COUNT(CASE WHEN fc.DiasCobre <= 7 THEN 1 END) as produtos_baixa_cobertura,
                    COUNT(CASE WHEN fc.QualidDados = 'BOA' THEN 1 END) as produtos_confianca_alta,
                    COUNT(CASE WHEN fc.Status = 'ATIVO' AND fc.DatValidade >= CURDATE() THEN 1 END) as forecasts_validos,
                    AVG(fc.Confianca) as confianca_media,
                    SUM(fc.CenCons * p.PrecoVen) as valor_compra_sugerida,
                    MAX(fc.DatCalculo) as ultima_atualizacao
                FROM ia_arqforecast fc
                INNER JOIN arqproduto p ON fc.IDProd = p.IDProd
                WHERE fc.IDFilial = :id_filial
                  AND fc.Status = 'ATIVO'
            """

            resultado = session.execute(text(query_dashboard), {
                'id_filial': id_filial
            }).fetchone()

            # Top 10 produtos críticos
            query_criticos = """
                SELECT
                    p.Despro as produto_nome,
                    fc.RiscoRupt,
                    fc.DiasCobre,
                    fc.CenCons
                FROM ia_arqforecast fc
                INNER JOIN arqproduto p ON fc.IDProd = p.IDProd
                WHERE fc.IDFilial = :id_filial
                  AND fc.Status = 'ATIVO'
                  AND fc.DatValidade >= CURDATE()
                ORDER BY fc.RiscoRupt DESC
                LIMIT 10
            """

            produtos_criticos = session.execute(text(query_criticos), {
                'id_filial': id_filial
            }).fetchall()

            dashboard = {
                'resumo': {
                    'total_produtos': resultado.total_produtos or 0,
                    'produtos_criticos': resultado.produtos_criticos or 0,
                    'produtos_baixa_cobertura': resultado.produtos_baixa_cobertura or 0,
                    'produtos_confianca_alta': resultado.produtos_confianca_alta or 0,
                    'forecasts_validos': resultado.forecasts_validos or 0,
                    'confianca_media': float(resultado.confianca_media or 0),
                    'valor_compra_sugerida': float(resultado.valor_compra_sugerida or 0),
                    'ultima_atualizacao': resultado.ultima_atualizacao.isoformat() if resultado.ultima_atualizacao else None
                },
                'alertas': {
                    'produtos_criticos': [
                        {
                            'produto_nome': row.produto_nome,
                            'risco_ruptura': float(row.RiscoRupt),
                            'dias_cobertura': float(row.DiasCobre),
                            'quantidade_sugerida': float(row.CenCons)
                        }
                        for row in produtos_criticos
                    ]
                },
                'indicadores': {
                    'percentual_criticos': round((resultado.produtos_criticos or 0) / max(1, resultado.total_produtos or 1) * 100, 1),
                    'percentual_baixa_cobertura': round((resultado.produtos_baixa_cobertura or 0) / max(1, resultado.total_produtos or 1) * 100, 1),
                    'percentual_confianca_alta': round((resultado.produtos_confianca_alta or 0) / max(1, resultado.total_produtos or 1) * 100, 1)
                }
            }

            return dashboard

    except Exception as e:
        logger.error(f"Erro ao gerar dashboard: {e}")
        raise HTTPException(
            status_code=500,
            detail=f"Erro interno: {str(e)}"
        )