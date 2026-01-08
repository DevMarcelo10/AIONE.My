object FrmBuscaCon: TFrmBuscaCon
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Produtos - Tela de Buscas Produtos'
  ClientHeight = 254
  ClientWidth = 595
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
    Width = 595
    Height = 254
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 9812223
    Bevel.BorderWidth = 1
    Color = 14342874
    Font.Charset = ANSI_CHARSET
    Font.Color = 6172416
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 1
      Top = 21
      Width = 593
      Height = 232
      Align = alClient
      Ctl3D = False
      DataSource = SouAuxi
      Font.Charset = ANSI_CHARSET
      Font.Color = 6172416
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = 6172416
      TitleFont.Height = -12
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'Nomcon'
          Width = 208
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nompes'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CpfCnpjPes'
          Width = 110
          Visible = True
        end>
    end
    object edBusca: TEdit
      Left = 1
      Top = 1
      Width = 593
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
      TabOrder = 1
      OnChange = edBuscaChange
      OnKeyDown = edBuscaKeyDown
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
      
        'SELECT arqconvenio.IDConv, arqconvenio.Nomcon, arqpessoa.Nompes,' +
        ' arqpessoa.CpfCnpjPes'
      
        'FROM arqconvenio LEFT JOIN arqpessoa ON arqconvenio.IDPess = arq' +
        'pessoa.IDPess'
      
        'WHERE arqconvenio.IDConv = '#39'36419289000125'#39' OR arqconvenio.Nomco' +
        'n LIKE '#39'%36419289000125%'#39' OR'
      
        '  arqpessoa.Nompes LIKE '#39'%36419289000125%'#39' OR arqpessoa.CpfCnpjP' +
        'es = '#39'36419289000125'#39)
    CacheUpdateRecords = False
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 40
    Top = 48
    object QueryAuxIDConv: TFDAutoIncField
      FieldName = 'IDConv'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object QueryAuxNomcon: TWideStringField
      FieldName = 'Nomcon'
      Size = 53
    end
    object QueryAuxNompes: TWideStringField
      FieldName = 'Nompes'
      Size = 106
    end
    object QueryAuxCpfCnpjPes: TWideStringField
      FieldName = 'CpfCnpjPes'
      Size = 18
    end
  end
  object SouAuxi: TDataSource
    AutoEdit = False
    DataSet = QueryAux
    Left = 40
    Top = 112
  end
  object Timer: TTimer
    Interval = 500
    OnTimer = TimerTimer
    Left = 40
    Top = 176
  end
end
