object FrmCaixaLan: TFrmCaixaLan
  Left = 388
  Top = 249
  Align = alClient
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'Caixa - Lan'#231'amentos de Caixa'
  ClientHeight = 530
  ClientWidth = 1096
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object DBGrid1: TDBGrid
    Tag = 1
    AlignWithMargins = True
    Left = 1
    Top = 3
    Width = 1094
    Height = 526
    Hint = 'Agrupar por mol'#233'cula / subst'#226'ncia'
    Margins.Left = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    Anchors = [akTop, akRight]
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    DataSource = SouMovto
    DrawingStyle = gdsGradient
    FixedColor = 15658734
    GradientEndColor = 15658734
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Roboto'
    Font.Style = []
    Options = [dgTitles, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = 5131854
    TitleFont.Height = -15
    TitleFont.Name = 'Roboto'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'ORIGEM'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'PEDIDO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'PESSOA'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 237
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'DATA/HORA'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 105
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'VENDEDOR'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 160
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'FORMA PAGTO.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 101
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'ENTR.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 28
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = 'NF'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = [fsBold]
        Width = 28
        Visible = True
      end>
  end
  object TabMovto: TRESTDWClientSQL
    Active = False
    BeforeInsert = TabMovtoBeforeInsert
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDComp'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Nroite'
        DataType = ftSmallint
      end
      item
        Name = 'IDProd'
        DataType = ftInteger
      end
      item
        Name = 'IDFilial'
        DataType = ftInteger
      end
      item
        Name = 'QtddemIA'
        DataType = ftFloat
        Precision = 9
      end
      item
        Name = 'Qtdped'
        DataType = ftFloat
        Precision = 9
      end
      item
        Name = 'QtdpedRec'
        DataType = ftFloat
        Precision = 9
      end
      item
        Name = 'Vlrult'
        DataType = ftFloat
        Precision = 9
      end
      item
        Name = 'Qtdest'
        DataType = ftFloat
        Precision = 9
      end
      item
        Name = 'IndPed'
        DataType = ftBoolean
      end
      item
        Name = 'Status'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'Despro'
        Attributes = [faReadonly]
        DataType = ftWideString
        Size = 120
      end
      item
        Name = 'IDFabr'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'IDGruSub'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'CodEAN'
        Attributes = [faReadonly]
        DataType = ftWideString
        Size = 14
      end
      item
        Name = 'Desgru'
        Attributes = [faReadonly]
        DataType = ftWideString
        Size = 35
      end
      item
        Name = 'Nompes'
        Attributes = [faReadonly]
        DataType = ftWideString
        Size = 80
      end>
    IndexDefs = <>
    IndexFieldNames = 'Despro'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      
        'SELECT ITE.*,PRO.Despro, PRO.IDFabr,PRO.IDGruSub,EAN.CodEAN,GRU.' +
        'Desgru,PES.Nompes FROM arqcompraite ITE'
      'LEFT JOIN arqproduto PRO ON ITE.IDProd = PRO.IDProd'
      'LEFT JOIN arqgrupo GRU ON PRO.IDGrupo = GRU.IDGrupo'
      'LEFT JOIN arqpessoa PES ON PRO.IDFabr = PES.IDPess'
      
        'LEFT JOIN (SELECT IDProd,MIN(CodEAN) AS CodEAN FROM arqprodutoea' +
        'n GROUP BY IDProd) EAN ON PRO.IDProd = EAN.IDProd'
      'LIMIT 1')
    UpdateTableName = 'arqcompraite'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 53
    Top = 74
  end
  object SouMovto: TDataSource
    DataSet = TabMovto
    Left = 53
    Top = 138
  end
end
