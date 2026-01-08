object FrmBuscaPes: TFrmBuscaPes
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Pessoas - Tela de Buscas Pessoas'
  ClientHeight = 254
  ClientWidth = 465
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  SnapBuffer = 8
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object PanelBusca: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 465
    Height = 254
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 9812223
    Bevel.BorderWidth = 1
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = 6172416
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object edBusca: TEdit
      Left = 1
      Top = 1
      Width = 463
      Height = 20
      Align = alTop
      AutoSelect = False
      CharCase = ecUpperCase
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = 6172416
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edBuscaChange
      OnKeyDown = edBuscaKeyDown
    end
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 21
      Width = 463
      Height = 232
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouAuxi
      DrawingStyle = gdsGradient
      FixedColor = 15066597
      GradientEndColor = 15855599
      GradientStartColor = 15855599
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Nompes'
          Title.Alignment = taCenter
          Title.Caption = 'Nome da Pessoa'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 444
          Visible = True
        end>
    end
  end
  object QueryAux: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    BinaryCompatibleMode = False
    MasterCascadeDelete = True
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT DISTINCT p.IDPess, p.Nompes FROM arqpessoa p'
      'LEFT JOIN arqpessconv C ON p.IDPess = c.IDPess'
      'WHERE p.IDPess = '#39'1'#39' OR p.FonePes = '#39'1'#39' OR CelularPes = '#39'1'#39' OR '
      
        'p.Nompes LIKE '#39'%1%'#39' OR p.NomfanPes LIKE '#39'%1%'#39' OR p.CpfCnpjPes = ' +
        #39'1'#39
      'OR c.NroMatric = '#39'1'#39' OR c.NroCartao = '#39'1'#39' '
      'ORDER BY p.Nompes')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 48
    Top = 64
    object QueryAuxIDPess: TIntegerField
      FieldName = 'IDPess'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QueryAuxNompes: TWideStringField
      FieldName = 'Nompes'
      Size = 80
    end
  end
  object SouAuxi: TDataSource
    AutoEdit = False
    DataSet = QueryAux
    Left = 48
    Top = 128
  end
  object Timer: TTimer
    Interval = 500
    OnTimer = TimerTimer
    Left = 48
    Top = 192
  end
end
