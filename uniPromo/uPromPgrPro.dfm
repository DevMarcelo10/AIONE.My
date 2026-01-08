object FrmPromPgrPro: TFrmPromPgrPro
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Promocoes Progressiva Produtos Lista'
  ClientHeight = 272
  ClientWidth = 581
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object LMDSimplePanel2: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 581
    Height = 272
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderWidth = 1
    Color = 16447736
    TabOrder = 0
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 6
      Width = 579
      Height = 265
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouPromPgr
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
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
          Alignment = taCenter
          Expanded = False
          FieldName = 'IDProd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Despro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 445
          Visible = True
        end
        item
          Expanded = False
          ReadOnly = True
          Width = 22
          Visible = True
        end
        item
          Expanded = False
          Width = 22
          Visible = True
        end>
    end
    object btNovoItem: TAdvGlowButton
      AlignWithMargins = True
      Left = 539
      Top = 6
      Width = 21
      Height = 22
      Cursor = crHandPoint
      Hint = 'Adiciona Produto / Lote'
      Margins.Top = 1
      Margins.Bottom = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000180000001810040000001AEE29
        30000000206348524D00007A26000080840000FA00000080E8000075300000EA
        6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
        485973000000600000006000F06B42CF0000000774494D4507E709050D20086E
        DC2C1A000001D14944415448C7ED55BF4BC35010FE5E5189D04883A3B8A943A8
        1462C8130CE8E8A8160445B00D8243FD235C9D15A1204817077F555C1C5C2A28
        88A688833AE45F506AB49060C573D0965AF2C308E2E2B7BDBB7B77F77DEFB807
        FC2304CCCFA1CE2593B11E45612541084A4063AE4BBDE5F2E5D2CDCDB70A6856
        57173B2E1450989888D229ADECEFB7A73399B387E7E7C040BE5E2C72DDB6792E
        9B4D5122119638458984661906D76D9B4BBBBB81C1EA5C32C93911A74C26AAD6
        9A65189C1369962C37DB635F0E3D8A02002E0E0EBC928C523C3E4AF1B897AF23
        5B2C02005386867C0BD41FF49A3D3E7A2571AD7CDEB5F2792FDFE969A5020090
        3B3B9BED6D5164205314A34A178B7A212A02198C748BE2EBEADA1AA44FDA831F
        FAF2A3ED6D0040C57184995CEE8455AB3F62D0764FF4AB0C3E3A9B9FAF9FB5AD
        C34300B8989D9E6E04CD0617F8DB3768055343D64058011A735D5602745D921A
        73DD04A17F71D12F91AE4B52AD06E0D6717C25A2DE7219006A29EF4577C2AA55
        BF897991A6A60080F599662025ADB4B7C775DBD62CC3F8EEB21B9E5C58E0ECE9
        A931BECDB2B61A46BA45F1F56D731303E97424B19777768471C36865E8FBE168
        962C634355C33E1CDC3A0EEB33CDF3ABBBBB480DFDA38E777C35A04A2865A9FE
        0000000049454E44AE426082}
      Rounded = True
      Spacing = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btNovoItemClick
      Appearance.BorderColor = 14674687
      Appearance.BorderColorHot = 14674687
      Appearance.BorderColorCheckedHot = 14674687
      Appearance.BorderColorDown = 14674687
      Appearance.BorderColorChecked = 14674687
      Appearance.BorderColorDisabled = 14674687
      Appearance.BorderColorFocused = 14674687
      Appearance.Color = 14674687
      Appearance.ColorTo = 14674687
      Appearance.ColorChecked = 14674687
      Appearance.ColorCheckedTo = 14674687
      Appearance.ColorDisabled = 14674687
      Appearance.ColorDisabledTo = 14674687
      Appearance.ColorDown = 14674687
      Appearance.ColorDownTo = 14674687
      Appearance.ColorHot = 14674687
      Appearance.ColorHotTo = 14674687
      Appearance.ColorMirror = 14674687
      Appearance.ColorMirrorTo = 14674687
      Appearance.ColorMirrorHot = 14674687
      Appearance.ColorMirrorHotTo = 14674687
      Appearance.ColorMirrorDown = 14674687
      Appearance.ColorMirrorDownTo = 14674687
      Appearance.ColorMirrorChecked = 14674687
      Appearance.ColorMirrorCheckedTo = 14674687
      Appearance.ColorMirrorDisabled = 14674687
      Appearance.ColorMirrorDisabledTo = 14674687
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3750459
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 2303013
      Appearance.TextColorDisabled = 13948116
    end
  end
  object TabPromPgr: TRESTDWClientSQL
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
      'SELECT PGR.*,PRO.Despro FROM arqpromopgr PGR '
      'LEFT JOIN arqproduto PRO ON PGR.IDProd = PRO.IDProd '
      'GROUP BY PGR.IDProm,PGR.IDProd ORDER BY PRO.Despro LIMIT 10'
      '')
    UpdateTableName = 'arqpromopgr'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 47
    Top = 71
    object TabPromPgrIDProm: TIntegerField
      FieldName = 'IDProm'
      Required = True
    end
    object TabPromPgrIDProd: TIntegerField
      FieldName = 'IDProd'
      Required = True
    end
    object TabPromPgrDespro: TWideStringField
      FieldName = 'Despro'
      Size = 160
    end
  end
  object SouPromPgr: TDataSource
    AutoEdit = False
    DataSet = TabPromPgr
    Left = 47
    Top = 150
  end
end
