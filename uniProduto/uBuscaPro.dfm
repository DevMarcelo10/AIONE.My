object FrmBuscaPro: TFrmBuscaPro
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Produtos - Tela de Buscas Produtos'
  ClientHeight = 259
  ClientWidth = 610
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
    Width = 610
    Height = 259
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 11974326
    Bevel.BorderWidth = 1
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = 6172416
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 1
      Top = 26
      Width = 608
      Height = 232
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
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
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = 6172416
      TitleFont.Height = -12
      TitleFont.Name = 'Roboto'
      TitleFont.Style = [fsBold]
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'Despro'
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
          Width = 318
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nompes'
          Title.Alignment = taCenter
          Title.Caption = 'FABRICANTE'
          Width = 186
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'EstTotal'
          Title.Alignment = taCenter
          Title.Caption = 'ESTOQUE'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Width = 23
          Visible = True
        end>
    end
    object edBusca: TEdit
      Left = 1
      Top = 1
      Width = 608
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
      
        'SELECT p.IDProd,p.Despro,GROUP_CONCAT(DISTINCT s.DesSubs SEPARAT' +
        'OR ", ") AS DesSubs,pe.Nompes,SUM(pl.Qtdest) AS EstTotal,'
      
        'P.PrecoVen, P.PrecoPMC, P.PrecoFP, P.PrecoFab, P.CustoMed, 0 as ' +
        'EstFilial1, 0 as EstFilial2, 0 as EstFilial3, 0 as EstFilial4'
      
        'FROM arqproduto p LEFT JOIN arqprodutosub ps ON p.IDProd = ps.ID' +
        'Prod'
      'LEFT JOIN arqsubstancia s ON ps.IDSubs = s.IDSubs'
      'LEFT JOIN arqpessoa pe ON p.IDFabr = pe.IDPess'
      'LEFT JOIN arqprodutolot pl ON p.IDProd = pl.IDProd'
      
        'WHERE p.Despro LIKE CONCAT("%", "DIPIRONA", "%") OR s.DesSubs LI' +
        'KE CONCAT("%", "DIPIRONA", "%")'
      'GROUP BY p.IDProd,p.Despro,pe.Nompes ORDER BY p.Despro LIMIT 500')
    CacheUpdateRecords = False
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
    object QueryAuxDesSubs: TWideMemoField
      FieldName = 'DesSubs'
      BlobType = ftWideMemo
    end
    object QueryAuxNompes: TWideStringField
      FieldName = 'Nompes'
      Size = 80
    end
    object QueryAuxEstTotal: TFloatField
      FieldName = 'EstTotal'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxPrecoVen: TFloatField
      FieldName = 'PrecoVen'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxPrecoPMC: TFloatField
      FieldName = 'PrecoPMC'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxPrecoFP: TFloatField
      FieldName = 'PrecoFP'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxPrecoFab: TFloatField
      FieldName = 'PrecoFab'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxCustoMed: TFloatField
      FieldName = 'CustoMed'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxEstFilial1: TIntegerField
      FieldName = 'EstFilial1'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxEstFilial2: TIntegerField
      FieldName = 'EstFilial2'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxEstFilial3: TIntegerField
      FieldName = 'EstFilial3'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueryAuxEstFilial4: TIntegerField
      FieldName = 'EstFilial4'
      DisplayFormat = '###,###,###,##0.00'
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
