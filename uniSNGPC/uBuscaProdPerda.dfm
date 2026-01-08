object FrmBuscaProdPerda: TFrmBuscaProdPerda
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Tela de Busca de Produtos das Perdas do SNGPC'
  ClientHeight = 257
  ClientWidth = 398
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object edBusca: TEdit
    Left = 0
    Top = 0
    Width = 398
    Height = 20
    Align = alTop
    AutoSelect = False
    CharCase = ecUpperCase
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = 3617579
    Font.Height = -12
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyDown = edBuscaKeyDown
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 20
    Width = 398
    Height = 237
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
        FieldName = 'IDProd'
        Title.Caption = 'C'#211'DIGO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = 6172416
        Title.Font.Height = -11
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Despro'
        Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = 6172416
        Title.Font.Height = -11
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 315
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
      
        'SELECT PRO.IDProd, PRO.Despro, PRO.CodEANpri, EAN.CodEAN  FROM a' +
        'rqproduto PRO  '
      'LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd'
      'GROUP BY PRO.IDProd, PRO.Despro'
      'ORDER BY PRO.Despro'
      'LIMIT 500')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 40
    Top = 48
    object QueryAuxIDProd: TIntegerField
      FieldName = 'IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QueryAuxDespro: TWideStringField
      FieldName = 'Despro'
      Size = 120
    end
    object QueryAuxCodEANpri: TWideStringField
      FieldName = 'CodEANpri'
      Size = 14
    end
    object QueryAuxCodEAN: TWideStringField
      FieldName = 'CodEAN'
      Size = 14
    end
  end
  object SouAuxi: TDataSource
    AutoEdit = False
    DataSet = QueryAux
    Left = 40
    Top = 112
  end
  object Timer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTimer
    Left = 38
    Top = 171
  end
end
