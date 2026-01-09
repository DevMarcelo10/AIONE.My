-- =============================================================================
-- AIONE.My - Estrutura de Persistência PBM
-- Tabelas para NSU, Autorizações, Rewards e Logs
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Tabela: pbm_operadoras
-- Cadastro das operadoras PBM ativas
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pbm_operadoras (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nome            VARCHAR(100) NOT NULL,
    tipo            ENUM('PBM','FIDELIDADE','GOVERNO') NOT NULL DEFAULT 'PBM',
    endpoint_hom    VARCHAR(255),
    endpoint_prod   VARCHAR(255),
    client_id       VARCHAR(100),
    client_secret   VARCHAR(255),
    cod_estabelec   VARCHAR(50),
    usuario         VARCHAR(100),
    senha           VARCHAR(255),
    api_key         VARCHAR(255),
    ativo           TINYINT(1) NOT NULL DEFAULT 1,
    usa_token       TINYINT(1) NOT NULL DEFAULT 1,
    token_validade  INT DEFAULT 3600 COMMENT 'Segundos',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_codigo (codigo),
    INDEX idx_tipo (tipo),
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dados iniciais - 12 PBMs catalogados
INSERT INTO pbm_operadoras (codigo, nome, tipo, endpoint_hom, endpoint_prod, usa_token, token_validade) VALUES
-- CORPORATIVOS (PBM)
('EPHARMA',         'Epharma',              'PBM',        'https://api-hml.epharma.com.br',       'https://api.epharma.com.br',           1, 3600),
('FUNCIONALCARD',   'Funcional Card',       'PBM',        'https://hml-api.funcionalcard.com.br', 'https://api.funcionalcard.com.br',     1, 3600),
('ORIZON',          'Orizon',               'PBM',        'https://hml.orizonbrasil.com.br/api',  'https://api.orizonbrasil.com.br',      1, 3600),
('VIDALINK',        'Vidalink',             'PBM',        'https://hml.vidalink.com.br/api',      'https://api.vidalink.com.br',          1, 3600),

-- GOVERNO
('FARMACIAPOPULAR', 'Farmácia Popular',     'GOVERNO',    'https://hml.saude.gov.br/farmaciapopular', 'https://ws.saude.gov.br/farmaciapopular', 0, 0),

-- INDÚSTRIA
('PHARMALINK',      'Pharmalink',           'PBM',        'https://hml.pharmalink.com.br/ws',     'https://ws.pharmalink.com.br',         0, 0),

-- COMERCIAIS / AGREGADORES
('TRNCENTRE',       'TRN Centre',           'PBM',        'https://hml.trncentre.com.br/api',     'https://api.trncentre.com.br',         1, 3600),

-- ASSOCIATIVOS
('PECFEBRAFAR',     'PEC Febrafar',         'PBM',        'https://hml.febrafar.com.br/pec/api',  'https://api.febrafar.com.br/pec',      1, 3600),

-- FIDELIZAÇÃO
('LINKEDFARMA',     'LinkedFarma',          'FIDELIDADE', 'https://hml.linkedfarma.com.br/api',   'https://api.linkedfarma.com.br',       1, 3600),
('ELLOMAIS',        'Ello+ / Facillite',    'FIDELIDADE', 'https://hml.facillite.com.br/api',     'https://api.facillite.com.br',         1, 3600),
('NOSSOCLUBE',      'Nosso Clube / Cosmos', 'FIDELIDADE', 'https://hml.cosmos.com.br/api',        'https://api.cosmos.com.br',            1, 3600),
('OBJECTPRO',       'Object Pro',           'FIDELIDADE', 'https://hml.objectpro.com.br/api',     'https://api.objectpro.com.br',         1, 3600);

-- -----------------------------------------------------------------------------
-- Tabela: pbm_tokens
-- Cache de tokens OAuth para evitar requisições desnecessárias
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pbm_tokens (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    operadora_id    INT NOT NULL,
    access_token    TEXT NOT NULL,
    token_type      VARCHAR(50) DEFAULT 'Bearer',
    expires_at      DATETIME NOT NULL,
    refresh_token   TEXT,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (operadora_id) REFERENCES pbm_operadoras(id) ON DELETE CASCADE,
    INDEX idx_operadora (operadora_id),
    INDEX idx_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- Tabela: pbm_autorizacoes
-- Registro de todas as autorizações de venda PBM
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pbm_autorizacoes (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    operadora_id        INT NOT NULL,
    venda_id            BIGINT COMMENT 'FK para tabela de vendas do ERP',
    
    -- Identificadores da transação
    nsu                 VARCHAR(50) NOT NULL,
    codigo_autorizacao  VARCHAR(50),
    protocolo           VARCHAR(50),
    transacao_id        VARCHAR(100) COMMENT 'ID interno enviado',
    
    -- Beneficiário
    carteirinha         VARCHAR(50),
    cpf                 VARCHAR(14),
    nome_beneficiario   VARCHAR(150),
    plano               VARCHAR(100),
    
    -- Valores
    valor_bruto         DECIMAL(15,2) NOT NULL DEFAULT 0,
    valor_desconto      DECIMAL(15,2) NOT NULL DEFAULT 0,
    valor_liquido       DECIMAL(15,2) NOT NULL DEFAULT 0,
    valor_subsidio      DECIMAL(15,2) DEFAULT 0,
    
    -- Status
    status              ENUM('AUTORIZADA','CANCELADA','ESTORNADA','PENDENTE','ERRO') NOT NULL DEFAULT 'AUTORIZADA',
    motivo_cancelamento VARCHAR(255),
    
    -- Timestamps
    data_autorizacao    DATETIME NOT NULL,
    data_cancelamento   DATETIME,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Dados extras em JSON
    request_json        JSON COMMENT 'Request enviado',
    response_json       JSON COMMENT 'Response recebido',
    
    FOREIGN KEY (operadora_id) REFERENCES pbm_operadoras(id),
    
    INDEX idx_nsu (nsu),
    INDEX idx_operadora (operadora_id),
    INDEX idx_venda (venda_id),
    INDEX idx_cpf (cpf),
    INDEX idx_carteirinha (carteirinha),
    INDEX idx_status (status),
    INDEX idx_data (data_autorizacao),
    UNIQUE KEY uk_operadora_nsu (operadora_id, nsu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- Tabela: pbm_autorizacao_itens
-- Itens de cada autorização (medicamentos)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pbm_autorizacao_itens (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    autorizacao_id      BIGINT NOT NULL,
    
    -- Produto
    ean                 VARCHAR(14) NOT NULL,
    descricao           VARCHAR(200),
    quantidade          DECIMAL(10,3) NOT NULL DEFAULT 1,
    
    -- Valores unitários
    preco_tabela        DECIMAL(15,4) NOT NULL DEFAULT 0,
    preco_pmc           DECIMAL(15,4) DEFAULT 0,
    preco_venda         DECIMAL(15,4) NOT NULL DEFAULT 0,
    desconto_percentual DECIMAL(5,2) DEFAULT 0,
    desconto_valor      DECIMAL(15,4) DEFAULT 0,
    valor_final         DECIMAL(15,4) NOT NULL DEFAULT 0,
    
    -- Receita (quando aplicável)
    crm_prescritor      VARCHAR(20),
    uf_prescritor       CHAR(2),
    
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (autorizacao_id) REFERENCES pbm_autorizacoes(id) ON DELETE CASCADE,
    INDEX idx_autorizacao (autorizacao_id),
    INDEX idx_ean (ean)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- Tabela: pbm_rewards
-- Pontos/Rewards de programas de fidelidade
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pbm_rewards (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    operadora_id        INT NOT NULL,
    autorizacao_id      BIGINT,
    cliente_id          BIGINT COMMENT 'FK para tabela de clientes do ERP',
    
    -- Identificação do cliente no programa
    cartao_fidelidade   VARCHAR(50),
    cpf                 VARCHAR(14),
    
    -- Movimento
    tipo                ENUM('CREDITO','DEBITO','EXPIRACAO','AJUSTE') NOT NULL,
    pontos              INT NOT NULL,
    saldo_anterior      INT DEFAULT 0,
    saldo_atual         INT DEFAULT 0,
    
    -- Referência
    descricao           VARCHAR(200),
    data_movimento      DATETIME NOT NULL,
    data_expiracao      DATE,
    
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (operadora_id) REFERENCES pbm_operadoras(id),
    FOREIGN KEY (autorizacao_id) REFERENCES pbm_autorizacoes(id) ON DELETE SET NULL,
    
    INDEX idx_operadora (operadora_id),
    INDEX idx_cpf (cpf),
    INDEX idx_cartao (cartao_fidelidade),
    INDEX idx_data (data_movimento),
    INDEX idx_tipo (tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- Tabela: pbm_log
-- Log de todas as comunicações com APIs
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pbm_log (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    operadora_id        INT NOT NULL,
    autorizacao_id      BIGINT,
    
    -- Operação
    operacao            VARCHAR(50) NOT NULL COMMENT 'AUTORIZAR, CANCELAR, CONSULTAR, TOKEN',
    endpoint            VARCHAR(500),
    metodo              ENUM('GET','POST','PUT','DELETE','PATCH') DEFAULT 'POST',
    
    -- Request/Response
    request_headers     JSON,
    request_body        TEXT,
    response_code       INT,
    response_body       TEXT,
    
    -- Timing
    tempo_ms            INT COMMENT 'Tempo de resposta em ms',
    tentativa           TINYINT DEFAULT 1,
    
    -- Status
    sucesso             TINYINT(1) NOT NULL DEFAULT 0,
    erro_mensagem       VARCHAR(500),
    
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (operadora_id) REFERENCES pbm_operadoras(id),
    INDEX idx_operadora (operadora_id),
    INDEX idx_autorizacao (autorizacao_id),
    INDEX idx_operacao (operacao),
    INDEX idx_created (created_at),
    INDEX idx_sucesso (sucesso)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- View: vw_pbm_resumo_diario
-- Resumo diário de autorizações por operadora
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_pbm_resumo_diario AS
SELECT 
    DATE(a.data_autorizacao) AS data,
    o.codigo AS operadora,
    o.nome AS operadora_nome,
    COUNT(*) AS qtd_autorizacoes,
    SUM(CASE WHEN a.status = 'AUTORIZADA' THEN 1 ELSE 0 END) AS qtd_autorizadas,
    SUM(CASE WHEN a.status = 'CANCELADA' THEN 1 ELSE 0 END) AS qtd_canceladas,
    SUM(a.valor_bruto) AS total_bruto,
    SUM(a.valor_desconto) AS total_desconto,
    SUM(a.valor_liquido) AS total_liquido
FROM pbm_autorizacoes a
JOIN pbm_operadoras o ON o.id = a.operadora_id
GROUP BY DATE(a.data_autorizacao), o.id;

-- -----------------------------------------------------------------------------
-- View: vw_pbm_pendentes
-- Autorizações que precisam de atenção
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_pbm_pendentes AS
SELECT 
    a.*,
    o.codigo AS operadora_codigo,
    o.nome AS operadora_nome
FROM pbm_autorizacoes a
JOIN pbm_operadoras o ON o.id = a.operadora_id
WHERE a.status IN ('PENDENTE', 'ERRO')
   OR (a.status = 'AUTORIZADA' AND a.venda_id IS NULL)
ORDER BY a.created_at DESC;
