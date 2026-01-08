object FrmBusca: TFrmBusca
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Geral - Tela de Buscas'
  ClientHeight = 254
  ClientWidth = 453
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
    Width = 453
    Height = 254
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
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
      Width = 451
      Height = 232
      Align = alClient
      Ctl3D = False
      DataSource = SouAuxi
      Font.Charset = ANSI_CHARSET
      Font.Color = 6172416
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
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
          Width = 340
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Width = 25
          Visible = True
        end>
    end
    object edBusca: TEdit
      Left = 1
      Top = 1
      Width = 451
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
    FieldDefs = <
      item
        Name = 'IDComi'
        DataType = ftAutoInc
      end
      item
        Name = 'DesComi'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'PerDesIni'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'PerDesFin'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'QtdIni'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'QtdFin'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'PerCom'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'VlrCom'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'DatIni'
        DataType = ftDate
      end
      item
        Name = 'DatFin'
        DataType = ftDate
      end
      item
        Name = 'IndVenDin'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndVenPix'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndVenDeb'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndVenCre'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndVenPra'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndVenChe'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndDesEst'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TipComi'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'BasComi'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndProg'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IndAtivo'
        DataType = ftString
        Size = 1
      end>
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
      '')
    CacheUpdateRecords = False
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 48
    Top = 64
  end
  object SouAuxi: TDataSource
    AutoEdit = False
    DataSet = QueryAux
    Left = 48
    Top = 128
  end
end
