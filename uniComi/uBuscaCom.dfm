object FrmBuscaCom: TFrmBuscaCom
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Comiss'#245'es - Tela de Buscas Regras de Comiss'#245'es '
  ClientHeight = 254
  ClientWidth = 380
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  SnapBuffer = 8
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelBusca: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 380
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
      Width = 378
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
          FieldName = 'DesComi'
          Width = 356
          Visible = True
        end>
    end
    object edBusca: TEdit
      Left = 1
      Top = 1
      Width = 378
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
    BinaryRequest = False
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT IDComi,DesComi FROM arqcomi ORDER BY DesComi')
    CacheUpdateRecords = False
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 40
    Top = 48
    object QueryAuxIDComi: TFDAutoIncField
      FieldName = 'IDComi'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object QueryAuxDesComi: TWideStringField
      FieldName = 'DesComi'
      Size = 40
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
