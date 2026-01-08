object frmPBM_Test: TfrmPBM_Test
  Left = 0
  Top = 0
  Caption = 'PBM - Testes Individuais por Operadora'
  ClientHeight = 621
  ClientWidth = 1176
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 390
    Height = 581
    Align = alLeft
    TabOrder = 0
    ExplicitLeft = 2
    ExplicitTop = -1
    object gbxOperadoras: TGroupBox
      Left = 8
      Top = 5
      Width = 376
      Height = 417
      Caption = ' Operadoras PBM '
      TabOrder = 0
      object Label1: TLabel
        Left = 43
        Top = 362
        Width = 275
        Height = 13
        Caption = 'Duplo-clique sobre operadora, testa individualmente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lvOperadoras: TListView
        Left = 8
        Top = 20
        Width = 353
        Height = 340
        Columns = <
          item
            Caption = 'Operadora'
            Width = 110
          end
          item
            Caption = 'Categoria'
            Width = 80
          end
          item
            Caption = 'Status'
            Width = 70
          end
          item
            Caption = 'Tempo'
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = lvOperadorasDblClick
        OnSelectItem = lvOperadorasSelectItem
      end
      object chkHomologacao: TCheckBox
        Left = 10
        Top = 394
        Width = 180
        Height = 17
        Caption = 'Ambiente Homologacao'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object pnlTestesIndividuais: TPanel
      Left = 8
      Top = 428
      Width = 304
      Height = 100
      BevelOuter = bvNone
      TabOrder = 1
      object lblTesteIndividual: TLabel
        Left = 0
        Top = 0
        Width = 304
        Height = 17
        Align = alTop
        Alignment = taCenter
        Caption = 'Testar: (selecione uma operadora)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 211
      end
      object btnIndivElegibilidade: TSpeedButton
        Left = 8
        Top = 28
        Width = 140
        Height = 30
        Caption = 'Elegibilidade (F2)'
        OnClick = btnIndivElegibilidadeClick
      end
      object btnIndivAutorizacao: TSpeedButton
        Left = 156
        Top = 28
        Width = 140
        Height = 30
        Caption = 'Autorizacao (F3)'
        OnClick = btnIndivAutorizacaoClick
      end
      object btnIndivCancelamento: TSpeedButton
        Left = 8
        Top = 64
        Width = 140
        Height = 30
        Caption = 'Cancelamento (F4)'
        Enabled = False
        OnClick = btnIndivCancelamentoClick
      end
      object btnIndivConsulta: TSpeedButton
        Left = 156
        Top = 64
        Width = 140
        Height = 30
        Caption = 'Consulta (F5)'
        Enabled = False
        OnClick = btnIndivConsultaClick
      end
    end
    object btnTestarSelecionada: TBitBtn
      Left = 8
      Top = 535
      Width = 145
      Height = 35
      Caption = 'Fluxo Completo (F6)'
      TabOrder = 2
      OnClick = btnTestarSelecionadaClick
    end
    object btnTestarTodas: TBitBtn
      Left = 160
      Top = 535
      Width = 152
      Height = 35
      Caption = 'Testar TODAS'
      TabOrder = 3
      OnClick = btnTestarTodasClick
    end
  end
  object pnlCenter: TPanel
    Left = 390
    Top = 0
    Width = 406
    Height = 581
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 392
    ExplicitTop = -1
    ExplicitWidth = 486
    ExplicitHeight = 610
    object gbxConexao: TGroupBox
      Left = 8
      Top = 8
      Width = 384
      Height = 90
      Caption = ' Conexao MySQL (Opcional) '
      TabOrder = 0
      object lblServer: TLabel
        Left = 9
        Top = 25
        Width = 34
        Height = 13
        Caption = 'Server:'
      end
      object lblDatabase: TLabel
        Left = 155
        Top = 24
        Width = 51
        Height = 13
        Caption = 'Database:'
      end
      object lblUser: TLabel
        Left = 9
        Top = 55
        Width = 43
        Height = 13
        Caption = 'Usuario:'
      end
      object lblPassword: TLabel
        Left = 155
        Top = 54
        Width = 35
        Height = 13
        Caption = 'Senha:'
      end
      object shpConexao: TShape
        Left = 295
        Top = 24
        Width = 8
        Height = 8
        Brush.Color = clGray
        Shape = stCircle
      end
      object edtServer: TEdit
        Left = 55
        Top = 21
        Width = 90
        Height = 21
        TabOrder = 0
        Text = 'localhost'
      end
      object edtDatabase: TEdit
        Left = 210
        Top = 21
        Width = 80
        Height = 21
        TabOrder = 1
        Text = 'dbaione'
      end
      object edtUser: TEdit
        Left = 55
        Top = 51
        Width = 90
        Height = 21
        TabOrder = 2
        Text = 'root'
      end
      object edtPassword: TEdit
        Left = 210
        Top = 51
        Width = 80
        Height = 21
        PasswordChar = '*'
        TabOrder = 3
        Text = 'f68interdb'
      end
      object btnConectar: TBitBtn
        Left = 307
        Top = 20
        Width = 69
        Height = 52
        Caption = 'Conectar'
        TabOrder = 4
        OnClick = btnConectarClick
      end
    end
    object gbxBeneficiario: TGroupBox
      Left = 8
      Top = 105
      Width = 384
      Height = 100
      Caption = ' Dados do Beneficiario '
      TabOrder = 1
      object lblCarteirinha: TLabel
        Left = 12
        Top = 24
        Width = 60
        Height = 13
        Caption = 'Carteirinha:'
      end
      object lblCPF: TLabel
        Left = 265
        Top = 24
        Width = 22
        Height = 13
        Caption = 'CPF:'
      end
      object lblDataNasc: TLabel
        Left = 12
        Top = 54
        Width = 57
        Height = 13
        Caption = 'Data Nasc.:'
      end
      object edtCarteirinha: TEdit
        Left = 75
        Top = 21
        Width = 180
        Height = 21
        TabOrder = 0
      end
      object edtCPF: TEdit
        Left = 290
        Top = 21
        Width = 85
        Height = 21
        TabOrder = 1
      end
      object edtDataNasc: TMaskEdit
        Left = 85
        Top = 51
        Width = 80
        Height = 21
        EditMask = '!99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
      end
      object chkUsarDadosPadrao: TCheckBox
        Left = 180
        Top = 53
        Width = 195
        Height = 17
        Caption = 'Usar dados padrao (homologacao)'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = chkUsarDadosPadraoClick
      end
    end
    object gbxProdutos: TGroupBox
      Left = 8
      Top = 212
      Width = 384
      Height = 180
      Caption = ' Produtos para Autorizacao '
      TabOrder = 2
      object sgProdutos: TStringGrid
        Left = 8
        Top = 20
        Width = 368
        Height = 120
        DefaultRowHeight = 22
        FixedCols = 0
        RowCount = 4
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
        TabOrder = 0
      end
      object btnAddProduto: TBitBtn
        Left = 8
        Top = 148
        Width = 75
        Height = 25
        Caption = 'Adicionar'
        TabOrder = 1
        OnClick = btnAddProdutoClick
      end
      object btnRemProduto: TBitBtn
        Left = 90
        Top = 148
        Width = 75
        Height = 25
        Caption = 'Remover'
        TabOrder = 2
        OnClick = btnRemProdutoClick
      end
      object btnProdutosPadrao: TBitBtn
        Left = 280
        Top = 148
        Width = 95
        Height = 25
        Caption = 'Prod. Padrao'
        TabOrder = 3
        OnClick = btnProdutosPadraoClick
      end
    end
    object gbxAcoes: TGroupBox
      Left = 8
      Top = 400
      Width = 384
      Height = 126
      Caption = ' Acoes de Teste '
      TabOrder = 3
      object btnTestarElegibilidade: TBitBtn
        Left = 12
        Top = 24
        Width = 170
        Height = 35
        Caption = 'Testar Elegibilidade'
        TabOrder = 0
        OnClick = btnTestarElegibilidadeClick
      end
      object btnTestarAutorizacao: TBitBtn
        Left = 200
        Top = 24
        Width = 170
        Height = 35
        Caption = 'Testar Autorizacao'
        TabOrder = 1
        OnClick = btnTestarAutorizacaoClick
      end
      object btnTestarCancelamento: TBitBtn
        Left = 12
        Top = 68
        Width = 170
        Height = 35
        Caption = 'Testar Cancelamento'
        Enabled = False
        TabOrder = 2
        OnClick = btnTestarCancelamentoClick
      end
      object btnTestarConsulta: TBitBtn
        Left = 200
        Top = 68
        Width = 170
        Height = 35
        Caption = 'Testar Consulta'
        Enabled = False
        TabOrder = 3
        OnClick = btnTestarConsultaClick
      end
    end
    object btnLimparLog: TBitBtn
      Left = 16
      Top = 535
      Width = 120
      Height = 35
      Caption = 'Limpar Log'
      TabOrder = 4
      OnClick = btnLimparLogClick
    end
  end
  object pnlRight: TPanel
    Left = 796
    Top = 0
    Width = 380
    Height = 581
    Align = alRight
    TabOrder = 2
    ExplicitLeft = 720
    ExplicitHeight = 610
    object gbxResultado: TGroupBox
      Left = 6
      Top = 9
      Width = 364
      Height = 130
      Caption = ' Ultimo Resultado '
      TabOrder = 0
      object lblNSU: TLabel
        Left = 39
        Top = 23
        Width = 25
        Height = 13
        Caption = 'NSU:'
      end
      object lblCodAutorizacao: TLabel
        Left = 209
        Top = 24
        Width = 41
        Height = 13
        Caption = 'Codigo:'
      end
      object lblValorDesconto: TLabel
        Left = 12
        Top = 54
        Width = 52
        Height = 13
        Caption = 'Desconto:'
      end
      object lblPontos: TLabel
        Left = 25
        Top = 87
        Width = 39
        Height = 13
        Caption = 'Pontos:'
      end
      object edtNSU: TEdit
        Left = 70
        Top = 21
        Width = 119
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object edtCodAutorizacao: TEdit
        Left = 255
        Top = 21
        Width = 100
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object edtValorDesconto: TEdit
        Left = 70
        Top = 51
        Width = 119
        Height = 21
        ReadOnly = True
        TabOrder = 2
      end
      object edtPontos: TEdit
        Left = 70
        Top = 84
        Width = 80
        Height = 21
        ReadOnly = True
        TabOrder = 3
      end
    end
    object gbxLog: TGroupBox
      Left = 8
      Top = 145
      Width = 364
      Height = 420
      Caption = ' Log de Execucao '
      TabOrder = 1
      object mmoLog: TMemo
        Left = 8
        Top = 20
        Width = 348
        Height = 390
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 581
    Width = 1176
    Height = 40
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 610
    ExplicitWidth = 1100
    object lblStatusTempo: TLabel
      Left = 820
      Top = 13
      Width = 4
      Height = 13
      Caption = '-'
    end
    object pnlStatus: TPanel
      Left = 8
      Top = 5
      Width = 800
      Height = 30
      BevelOuter = bvLowered
      TabOrder = 0
      object lblStatusOperadora: TLabel
        Left = 8
        Top = 8
        Width = 750
        Height = 13
        AutoSize = False
        Caption = 'Pronto'
      end
    end
    object pbProgress: TProgressBar
      Left = 900
      Top = 10
      Width = 190
      Height = 20
      TabOrder = 1
    end
  end
end
