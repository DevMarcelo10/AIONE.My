object FrmProSubs: TFrmProSubs
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Produtos Subst'#226'ncias'
  ClientHeight = 258
  ClientWidth = 721
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
  object PanelTop: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 721
    Height = 54
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
    TabOrder = 0
    DesignSize = (
      721
      54)
    object LMDLabel4: TLMDLabel
      Left = 289
      Top = 6
      Width = 144
      Height = 15
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 33785
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'SUBST'#194'NCIAS / MOL'#201'CULA'
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 704
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
      NotesFont.Height = -12
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
      TabOrder = 1
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
    object edNomsub: TLMDEdit
      Left = 4
      Top = 27
      Width = 712
      Height = 21
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 13487565
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 0
      OnKeyDown = edNomsubKeyDown
      CustomButtons = <
        item
          ParentFont = False
          PngGlyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
            000970485973000016250000162501495224F00000001974455874536F667477
            617265007777772E696E6B73636170652E6F72679BEE3C1A0000009D49444154
            78DAC592310EC3200C45CDC22958320077800994632358409C8130B07009B2B4
            85812153D234EA9FBE64FB49B63F7A7D0437841E03B4D6402905082170CE01C6
            F81A20E70C8CB1E1B76D034AE935401FE29C0F9F529AB0E700FBBE43AD75164A
            29B0AEEBF0C618589665D60821F3261320848018E3A9CBF7DE10C2F700292578
            EF7FBCC2FFBF70D4ED20F5286BAD4794ADB5D7A37C56B7016F99B093D15402FA
            770000000049454E44AE426082}
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          Index = 0
          DisplayName = 'TLMDSpecialButton'
          OnClick = edNomsubCustomButtons0Click
          UsePngGlyph = True
        end>
      CustomButtonsStyle = ubsFlat
      PasswordChar = #0
      Spelling.LiveSpell = True
      Text = ''
    end
  end
  object PanelCadastro: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 54
    Width = 721
    Height = 204
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
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
      Width = 717
      Height = 200
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouSubs
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
          FieldName = 'Dessubs'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 675
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
  object TabSubs: TRESTDWClientSQL
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
      
        'SELECT PSUB.*,SUB.Dessubs FROM arqprodutosub PSUB LEFT JOIN arqs' +
        'ubstancia SUB ON PSUB.IDSubs = SUB.IDSubs LIMIT 5'
      '')
    UpdateTableName = 'arqprodutosub'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 47
    Top = 71
    object TabSubsIDProd: TIntegerField
      FieldName = 'IDProd'
      Origin = 'arqprodutosub.IDProd'
    end
    object TabSubsIDSubs: TIntegerField
      FieldName = 'IDSubs'
      Origin = 'arqprodutosub.IDSubs'
    end
    object TabSubsDessubs: TWideStringField
      FieldName = 'Dessubs'
      Origin = 'arqsubstancia.DesSubs'
      ProviderFlags = []
      Size = 190
    end
  end
  object SouSubs: TDataSource
    DataSet = TabSubs
    Left = 111
    Top = 71
  end
end
