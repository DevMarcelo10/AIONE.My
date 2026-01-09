-- ============================================================================
-- AIONE IA - Tabela de Forecast Probabilístico
-- TABELA: ia_arqforecast
-- Armazena resultados de forecast por produto/filial com controle de validade
-- ============================================================================

USE dbaione;

DROP TABLE IF EXISTS ia_arqforecast;

CREATE TABLE ia_arqforecast (
    -- Identificação
    IDForecast      BIGINT(20)    NOT NULL AUTO_INCREMENT COMMENT 'ID único do forecast',
    IDProd          INT(11)       NOT NULL COMMENT 'ID do produto',
    IDFilial        INT(11)       NOT NULL COMMENT 'ID da filial',
    IDGrupo         INT(11)       NULL COMMENT 'ID do grupo do produto',

    -- Data/Hora
    DatCalculo      DATETIME      NOT NULL COMMENT 'Data/hora do cálculo',
    DatValidade     DATE          NOT NULL COMMENT 'Data até quando o forecast é válido',

    -- Parâmetros usados
    DiasHist        INT(11)       NOT NULL COMMENT 'Dias de histórico analisados',
    DiasCobreAlvo   INT(11)       NOT NULL COMMENT 'Dias de cobertura alvo',
    TempoRepo       INT(11)       NOT NULL COMMENT 'Tempo de reposição considerado',

    -- Métricas de consumo
    ConsMedio       DECIMAL(12,4) NOT NULL COMMENT 'Consumo médio diário',
    ConsDesvio      DECIMAL(12,4) NOT NULL COMMENT 'Desvio padrão diário',
    ConsCoefVar     DECIMAL(6,4)  NULL COMMENT 'Coeficiente de variação',
    Tendencia       ENUM('CRESCENTE','ESTAVEL','DECRESCENTE') NULL COMMENT 'Tendência detectada',

    -- Estoque
    EstqAtual       DECIMAL(12,4) NOT NULL COMMENT 'Estoque no momento do cálculo',
    EstqSegur       DECIMAL(12,4) NOT NULL COMMENT 'Estoque de segurança calculado',
    PontoPed        DECIMAL(12,4) NOT NULL COMMENT 'Ponto de pedido',
    DiasCobre       DECIMAL(8,2)  NOT NULL COMMENT 'Dias de cobertura atual',

    -- Cenários de compra
    CenOtim         DECIMAL(12,4) NOT NULL COMMENT 'Quantidade cenário otimista (P10)',
    CenCons         DECIMAL(12,4) NOT NULL COMMENT 'Quantidade cenário conservador (P50)',
    CenCrit         DECIMAL(12,4) NOT NULL COMMENT 'Quantidade cenário crítico (P90)',

    -- Ajustes aplicados
    FatorAjuste     DECIMAL(6,4)  DEFAULT 1.0 COMMENT 'Fator de ajuste por eventos',
    EventosJSON     LONGTEXT      NULL COMMENT 'Eventos considerados (JSON)',
    AlertasJSON     LONGTEXT      NULL COMMENT 'Alertas considerados (JSON)',

    -- Qualidade e confiança
    Confianca       DECIMAL(5,2)  NOT NULL COMMENT 'Confiança do forecast 0-100',
    QualidDados     ENUM('BOA','MEDIA','RUIM','INSUFICIENTE') NOT NULL COMMENT 'Qualidade dos dados',
    RiscoRupt       DECIMAL(5,4)  NOT NULL COMMENT 'Probabilidade de ruptura 0-1',

    -- Sazonalidade
    SazonalDetec    TINYINT(1)    DEFAULT 0 COMMENT 'Sazonalidade detectada',
    IndSazonJSON    LONGTEXT      NULL COMMENT 'Índices sazonais (JSON)',

    -- Status
    Status          ENUM('ATIVO','EXPIRADO','SUBSTITUIDO') DEFAULT 'ATIVO' COMMENT 'Status do registro',

    -- Chaves e Índices
    PRIMARY KEY (IDForecast),
    INDEX idx_prod_filial (IDProd, IDFilial),
    INDEX idx_filial_status (IDFilial, Status),
    INDEX idx_validade (DatValidade),
    INDEX idx_calculo (DatCalculo),
    INDEX idx_risco_critico (RiscoRupt DESC, DiasCobre ASC),
    INDEX idx_grupo_filial (IDGrupo, IDFilial),
    INDEX idx_status_validade (Status, DatValidade),

    -- Foreign Keys
    CONSTRAINT fk_forecast_produto
        FOREIGN KEY (IDProd) REFERENCES arqproduto(IDProd)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_forecast_filial
        FOREIGN KEY (IDFilial) REFERENCES arqfilial(IDFilial)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_forecast_grupo
        FOREIGN KEY (IDGrupo) REFERENCES arqgrupo(IDGrupo)
        ON DELETE SET NULL ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Resultados de forecast por produto/filial';

-- ============================================================================
-- DOCUMENTAÇÃO E FLUXO DE USO
-- ============================================================================

/*
CAMPOS PRINCIPAIS:

DatValidade     - Forecast válido até X dias (ex: recalcular semanalmente)
EventosJSON     - Guarda quais eventos influenciaram (auditoria)
AlertasJSON     - Alertas gerados durante o cálculo (auditoria)
Confianca       - 0-100% - quanto confiar no número
QualidDados     - Se tinha dados suficientes para calcular
Status          - ATIVO = usar, EXPIRADO = passou validade, SUBSTITUIDO = tem mais recente
FatorAjuste     - Fator multiplicador aplicado por eventos/sazonalidade

FLUXO DO FORECAST:

JOB DIÁRIO (4h):
1. Marca forecasts antigos como EXPIRADO
2. Recalcula produtos críticos (abaixo ponto pedido)
3. Recalcula produtos com eventos/alertas ativos
4. Amostragem dos demais
5. INSERT em ia_arqforecast com Status='ATIVO'

TELA DO COMPRADOR:
SELECT * FROM ia_arqforecast
WHERE IDFilial = ? AND Status = 'ATIVO'
  AND DatValidade >= CURDATE()
ORDER BY RiscoRupt DESC

APRENDIZADO:
- Compara CenCons previsto vs venda real
- Alimenta ia_arqdecapren com desvios
- Recalibra parâmetros
*/