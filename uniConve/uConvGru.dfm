object FrmConLimGru: TFrmConLimGru
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Convenios Grupos Limitados'
  ClientHeight = 258
  ClientWidth = 603
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object PanelTop: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 603
    Height = 46
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 11974326
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 15461355
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    DesignSize = (
      603
      46)
    object LMDLabel4: TLMDLabel
      Left = 6
      Top = 6
      Width = 49
      Height = 15
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4934475
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'GRUPOS '
    end
    object LMDLabel1: TLMDLabel
      Left = 309
      Top = 6
      Width = 74
      Height = 15
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4934475
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'SUB GRUPOS '
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 586
      Top = 3
      Width = 14
      Height = 17
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      Anchors = [akTop, akRight]
      AntiAlias = aaAntiAlias
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Font.Quality = fqClearType
      HotPicture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001010060000004F6323
        22000000206348524D00007A26000080840000FA00000080E8000075300000EA
        6000003A98000017709CBA513C00000006624B4744000000000000F943BB7F00
        00000970485973000000600000006000F06B42CF0000000774494D4507E70A0D
        113A152ADFB233000001214944415448C7ED94BB4A03511086BF59847D043B2D
        853C805859F9085AA509812590C0F6C62AC59EBC4170932DB68FAD2FA09DBE43
        ECEDEC1237EC58ECC542F672128414F99B03C3CC3FB77F0E1C71A850355F3099
        A84E5DE876EDE3B3B882A7CACFA9E17887D50A348438560D6EA1D76B4E5CF865
        71BF3C3B4F22B8827E5FD59CC276ABA9B984C1A02A71E9A7D36B180E9BF8C5B6
        10900F98CF51CE613442F40C361B90578822900BF07D91FB1798CD76EEBCB290
        D4DC81E7A99A1892A47C73BB2D9F631B80A84292B4B637E0A475E7A5B8CA517F
        82EF43FA0DEB75B69A28CA34E2BAE28CDF200CF71C787B71B515AB45E2F28E63
        9B1DFFD548FD3F52B3027D864E07F4113C4F9C87A7FCAE6B21CE78098B856A50
        6822E7E166EF751CF11FF8013EEFB40E5A83464B0000000049454E44AE426082}
      MarginVert = 0
      MarginHorz = 0
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
        EA000000206348524D00007A26000080840000FA00000080E8000075300000EA
        6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
        485973000000600000006000F06B42CF0000000774494D4507E70A0D113903F5
        2654A10000006D4944415428CFBD904B0A80300C441FE2697AA52E2A4210BC45
        CFE1C67BA60B17ADB5910A82E02C029919F219F80D116F7A4FB4868032D56E42
        09F7193389A5C889B5B7265B1E65004151A4A50663D0A67690875FB774657BAE
        F9BBDD2DE899CB582887B057C386E23E87FF1607B28E1E7AA340F10300000000
        49454E44AE426082}
      Rounded = False
      Spacing = 3
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = btFecharClick
      Appearance.BorderColor = 15461355
      Appearance.BorderColorHot = 15461355
      Appearance.BorderColorCheckedHot = 15461355
      Appearance.BorderColorDown = 15461355
      Appearance.BorderColorChecked = 15461355
      Appearance.BorderColorDisabled = 15461355
      Appearance.BorderColorFocused = 15461355
      Appearance.Color = 15461355
      Appearance.ColorTo = 15461355
      Appearance.ColorChecked = 15461355
      Appearance.ColorCheckedTo = 15461355
      Appearance.ColorDisabled = 15461355
      Appearance.ColorDisabledTo = 15461355
      Appearance.ColorDown = 15461355
      Appearance.ColorDownTo = 15461355
      Appearance.ColorHot = 15461355
      Appearance.ColorHotTo = 15461355
      Appearance.ColorMirror = 15461355
      Appearance.ColorMirrorTo = 15461355
      Appearance.ColorMirrorHot = 15461355
      Appearance.ColorMirrorHotTo = 15461355
      Appearance.ColorMirrorDown = 15461355
      Appearance.ColorMirrorDownTo = 15461355
      Appearance.ColorMirrorChecked = 15461355
      Appearance.ColorMirrorCheckedTo = 15461355
      Appearance.ColorMirrorDisabled = 15461355
      Appearance.ColorMirrorDisabledTo = 15461355
      Appearance.TextColorChecked = 3191038
      Appearance.TextColorHot = 15234048
      Appearance.TextColorDisabled = 3191038
    end
    object edNomgru: TLMDEdit
      Left = 3
      Top = 20
      Width = 291
      Height = 21
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 0
      OnKeyDown = edNomgruKeyDown
      CustomButtons = <>
      PasswordChar = #0
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
    end
    object edSubg: TLMDEdit
      Left = 309
      Top = 20
      Width = 291
      Height = 21
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 1
      OnEnter = edSubgEnter
      OnKeyDown = edSubgKeyDown
      CustomButtons = <>
      PasswordChar = #0
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
    end
  end
  object PanelCadastro: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 47
    Width = 294
    Height = 211
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alLeft
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 11974326
    Bevel.BorderWidth = 1
    Bevel.EdgeStyle = etRaised
    Color = clWhite
    TabOrder = 1
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 290
      Height = 207
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouGrupLim
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
          FieldName = 'Desgru'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 250
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
  object LMDSimplePanel1: TLMDSimplePanel
    AlignWithMargins = True
    Left = 309
    Top = 47
    Width = 294
    Height = 211
    Margins.Left = 15
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alRight
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 11974326
    Bevel.BorderWidth = 1
    Bevel.EdgeStyle = etRaised
    Color = clWhite
    TabOrder = 2
    object DBGrid2: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 290
      Height = 207
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouSubgLim
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
      OnCellClick = DBGrid2CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'DesgruSub'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 250
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
  object SouGrupLim: TDataSource
    AutoEdit = False
    DataSet = TabGrupLim
    Left = 127
    Top = 71
  end
  object SouSubgLim: TDataSource
    AutoEdit = False
    DataSet = TabSubgLim
    Left = 447
    Top = 71
  end
  object TabGrupLim: TRESTDWClientSQL
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
      
        'SELECT GRL.*,GRU.Desgru FROM arqconvglim GRL LEFT JOIN arqgrupo ' +
        'GRU ON GRL.IDGrupo = GRU.IDGrupo WHERE IDConv = 1'
      '')
    UpdateTableName = 'arqconvglim'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 47
    Top = 71
    object TabGrupLimIDConv: TIntegerField
      FieldName = 'IDConv'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabGrupLimIDGrupo: TIntegerField
      FieldName = 'IDGrupo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabGrupLimDesgru: TWideStringField
      FieldName = 'Desgru'
      ProviderFlags = []
      Size = 46
    end
  end
  object TabSubgLim: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    BinaryCompatibleMode = False
    MasterDataSet = TabGrupLim
    MasterCascadeDelete = True
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <
      item
        DataType = ftInteger
        Name = 'IDConv'
        ParamType = ptInput
        Value = 1
      end
      item
        DataType = ftInteger
        Name = 'IDGrupo'
        ParamType = ptInput
        Value = 5
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      
        'SELECT GRL.*,SUB.DesgruSub FROM arqconvslim GRL LEFT JOIN arqgru' +
        'posub SUB'
      'ON GRL.IDGrupo = SUB.IDGrupo AND GRL.IDGruSub = SUB.IDGruSub'
      'WHERE GRL.IDConv = :IDConv AND GRL.IDGrupo = :IDGrupo')
    RelationFields.Strings = (
      'IDConv=IDConv'
      'IDGrupo=IDGrupo')
    UpdateTableName = 'arqconvslim'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 357
    Top = 70
    object TabSubgLimIDConv: TIntegerField
      FieldName = 'IDConv'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabSubgLimIDGrupo: TIntegerField
      FieldName = 'IDGrupo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabSubgLimIDGruSub: TIntegerField
      FieldName = 'IDGruSub'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabSubgLimDesgruSub: TWideStringField
      FieldName = 'DesgruSub'
      ProviderFlags = []
      Size = 46
    end
  end
end
