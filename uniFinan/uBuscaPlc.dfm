object FrmBuscaPlc: TFrmBuscaPlc
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Buscas Plano de Contas'
  ClientHeight = 237
  ClientWidth = 595
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
    Width = 595
    Height = 237
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
      Top = 22
      Width = 593
      Height = 214
      Align = alClient
      Ctl3D = False
      DataSource = SouAuxi
      Font.Charset = ANSI_CHARSET
      Font.Color = 6172416
      Font.Height = -12
      Font.Name = 'Roboto'
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
          FieldName = 'Codcon'
          Title.Alignment = taCenter
          Title.Caption = 'TIPO'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 6172416
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nomcon'
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O'
          Title.Color = clWhitesmoke
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 6172416
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 450
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DevCre'
          Font.Charset = ANSI_CHARSET
          Font.Color = 6172416
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Title.Alignment = taCenter
          Title.Caption = 'D/C'
          Width = 28
          Visible = True
        end>
    end
    object edBusca: TEdit
      Left = 1
      Top = 1
      Width = 593
      Height = 21
      Align = alTop
      AutoSelect = False
      CharCase = ecUpperCase
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = 6172416
      Font.Height = -12
      Font.Name = 'Roboto'
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
      'SELECT IDCon,Codcon,Nomcon,DevCre FROM arqplacon ORDER BY Nomcon')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 40
    Top = 48
    object QueryAuxIDCon: TFDAutoIncField
      FieldName = 'IDCon'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object QueryAuxCodcon: TWideStringField
      DisplayWidth = 8
      FieldName = 'Codcon'
      EditMask = '#.#.#.##.###;0;_'
      Size = 8
    end
    object QueryAuxNomcon: TWideStringField
      FieldName = 'Nomcon'
      Size = 60
    end
    object QueryAuxDevCre: TWideStringField
      FieldName = 'DevCre'
      Size = 1
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
