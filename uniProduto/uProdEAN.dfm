object FrmProdEAN: TFrmProdEAN
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Produtos Codigo Barras EAN'
  ClientHeight = 90
  ClientWidth = 139
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 13
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 139
    Height = 90
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderWidth = 1
    Color = clWhite
    TabOrder = 0
    object DBGrid1: TDBGrid
      Tag = 1
      Left = 0
      Top = 0
      Width = 137
      Height = 76
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouProdEAN
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgEditing, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
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
      Columns = <
        item
          Expanded = False
          FieldName = 'CodEAN'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 97
          Visible = True
        end
        item
          Expanded = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 20
          Visible = True
        end>
    end
  end
  object TabProdEAN: TRESTDWClientSQL
    Active = False
    AfterInsert = TabProdEANAfterInsert
    BeforePost = TabProdEANBeforePost
    AfterPost = TabProdEANAfterPost
    OnPostError = TabProdEANPostError
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
      'SELECT * FROM arqprodutoean LIMIT 5')
    UpdateTableName = 'arqprodutoean'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 21
    Top = 30
    object TabProdEANIDProd: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDProd'
      Origin = 'arqprodutoean.IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabProdEANCodEAN: TWideStringField
      FieldName = 'CodEAN'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 18
    end
  end
  object SouProdEAN: TDataSource
    DataSet = TabProdEAN
    Left = 93
    Top = 30
  end
end
