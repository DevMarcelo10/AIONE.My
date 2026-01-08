object FrmBuscaInv: TFrmBuscaInv
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Invent'#225'rios - Tela de Busca de invent'#225'rios '
  ClientHeight = 254
  ClientWidth = 548
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  SnapBuffer = 8
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object edBusca: TEdit
    Left = 0
    Top = 0
    Width = 548
    Height = 24
    Align = alTop
    AutoSelect = False
    CharCase = ecUpperCase
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = 3617579
    Font.Height = -15
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = edBuscaChange
    OnKeyDown = edBuscaKeyDown
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 24
    Width = 548
    Height = 230
    Align = alClient
    Ctl3D = False
    DataSource = SouAuxi
    Font.Charset = ANSI_CHARSET
    Font.Color = 6172416
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = 6172416
    TitleFont.Height = -12
    TitleFont.Name = 'Roboto'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'Nompes'
        Title.Caption = 'REPONS'#193'VEL T'#201'CNICO'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IDInvIni'
        Title.Caption = 'INVENT'#193'RIO'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DataAbe'
        Title.Caption = 'DATA ABERTURA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IndFecha'
        Title.Caption = 'STATUS'
        Width = 90
        Visible = True
      end>
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
      
        'SELECT IDInvIni,DataAbe,PES.Nompes,IndFecha FROM arqsngpcinve IN' +
        'V'
      'LEFT JOIN arqpessoa PES ON INV.IDPess = PES.IDPess')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 40
    Top = 48
    object QueryAuxIDInvIni: TIntegerField
      FieldName = 'IDInvIni'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QueryAuxDataAbe: TDateField
      FieldName = 'DataAbe'
    end
    object QueryAuxNompes: TWideStringField
      FieldName = 'Nompes'
      Size = 80
    end
    object QueryAuxIndFecha: TWideStringField
      FieldName = 'IndFecha'
      Size = 1
    end
  end
  object SouAuxi: TDataSource
    AutoEdit = False
    DataSet = QueryAux
    Left = 40
    Top = 112
  end
end
