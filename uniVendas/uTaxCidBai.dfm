object FrmTaxCidBai: TFrmTaxCidBai
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'VENDAS - Taxas de Entrega Cidade / Bairro'
  ClientHeight = 289
  ClientWidth = 653
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
    Width = 653
    Height = 51
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
      653
      51)
    object LMDLabel4: TLMDLabel
      Left = 10
      Top = 6
      Width = 39
      Height = 15
      Color = 16582
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5855577
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'CIDADE'
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 636
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
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000012C49
        444154388DAD934D6AC33010859F64E1789BEE4D53F7040D3D804B6F6023103A
        A030F80A8504BA4C73843A093980D7B665D445A5E0D8AA9B4506B4D030EF9B3F
        09B8976559B696522EFF8BE39C3F6459B67677EAC494D27DDBB65F4288F82FB1
        102236C6EC28A5FB3CCF5F2E80288A0E002A0089D67AEB83082162ADF5164002
        A05A2C16C70B40295533C65263CCB7857C72CE9F86E2AEEB36567C628CBD2BA5
        6A0020E32C5DD76D0821CF004E8490B72008F4D0C7184B8BA2383ACD15C057AA
        7527002A2B3E0FE327004F25F06576467D009FF57DEF4D3601B8166CF6CA9E47
        63CC876F3BB343648CA500FAF160CBB23C4C003EB1EBD9B71D0721C0EFF334C6
        EC3033EDF176C2307C554AD5D40E6835270680A228CEB6A50A40D234CDEA2AE0
        D6CF24A55CBA7F7017FB0104BEABAD9D4A95EB0000000049454E44AE426082}
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
    object edNommun: TLMDEdit
      Left = 10
      Top = 22
      Width = 253
      Height = 21
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 0
      OnKeyDown = edNommunKeyDown
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #0
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
    end
    object btSalvar: TAdvGlowButton
      AlignWithMargins = True
      Left = 569
      Top = 22
      Width = 74
      Height = 21
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 20
      Margins.Bottom = 4
      Caption = 'Incluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -12
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000010B49
        444154388DDDD13F4A034114C7F1EF1B16760B71AA88B980206863A316828A17
        F006A916249930A7102B61216C117B41F6001A215682DEC03F0730B61AEC6667
        6CB212451753EAAF7D7C7EF0DE833F1F991574BBDD15607F341A1D16455146B3
        E04EA7B30A0C8146B3D97C0532350B564A0D810670E79C3B0388005AAD56A2B5
        3E064EB32CBBFE8AADB5CBDEFBCB097EF0DEEFE579FE0CA000B4D6ED10C24108
        E1DC18B3F50DBE02162778B7D7EB3D557305E0BD3F016E813911B9B0D66EFF06
        C3D4178C31F3223200368037A00D1CD5E14F0500699AEA244906C03A1026F37B
        E7DC4EB5736D415512C7F1A3882C0063E7DCD24FF8E306D3E9F7FB2F5114AD89
        C84D59969B75F89FE41D070B7371D480D5260000000049454E44AE426082}
      Rounded = True
      TabOrder = 3
      OnClick = btSalvarClick
      Appearance.BorderColor = 8695039
      Appearance.BorderColorHot = 2846975
      Appearance.BorderColorCheckedHot = 8695039
      Appearance.BorderColorDown = 8695039
      Appearance.BorderColorChecked = 8695039
      Appearance.BorderColorDisabled = 8695039
      Appearance.BorderColorFocused = 8695039
      Appearance.Color = 14017279
      Appearance.ColorTo = 9943551
      Appearance.ColorChecked = 9943551
      Appearance.ColorCheckedTo = 9943551
      Appearance.ColorDisabled = 9943551
      Appearance.ColorDisabledTo = 9943551
      Appearance.ColorDown = 9943551
      Appearance.ColorDownTo = 9943551
      Appearance.ColorHot = 7972351
      Appearance.ColorHotTo = 10337791
      Appearance.ColorMirror = 9943551
      Appearance.ColorMirrorTo = 9943551
      Appearance.ColorMirrorHot = 7972351
      Appearance.ColorMirrorHotTo = 7972351
      Appearance.ColorMirrorDown = 9943551
      Appearance.ColorMirrorDownTo = 9943551
      Appearance.ColorMirrorChecked = 9943551
      Appearance.ColorMirrorCheckedTo = 9943551
      Appearance.ColorMirrorDisabled = 9943551
      Appearance.ColorMirrorDisabledTo = 9943551
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
    object edNombai: TLMDLabeledEdit
      Left = 270
      Top = 22
      Width = 288
      Height = 21
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      OnEnter = edNombaiEnter
      OnKeyDown = edNombaiKeyDown
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3617579
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <
        item
          ParentFont = False
          PngGlyph.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
            00097048597300000EC000000EC0016AD689090000001974455874536F667477
            617265007777772E696E6B73636170652E6F72679BEE3C1A0000003949444154
            78DA63FC0F040C34048CA3160C2D0B181919C134296E1AB560A45A0033885480
            CDE281B180E641346AC108B6801C306AC1C05B00001E1289B9778978BC000000
            0049454E44AE426082}
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Index = 0
          DisplayName = 'TLMDSpecialButton'
          ThemeMode = ttmNative
          OnClick = edNombaiCustomButtons0Click
          UsePngGlyph = True
        end
        item
          ParentFont = False
          PngGlyph.Data = {
            89504E470D0A1A0A0000000D4948445200000010000000100802000000909168
            36000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
            00097048597300000EC300000EC301C76FA864000001944944415478DA9D923F
            8F015114C5774AE51422A2164C46884410147412059310058D0F40A815E20B98
            9282043153E8952312A1309502893F211205894C37190A7BB28AC16C76B37BAB
            9777EFEFDD77CEBDC4FD7EFFF84B105A60B15854ABD5C160A0280A4110E17038
            9FCF3B9DCEEF01D425120983C1803A9AA667B3D9643259AFD7AD562B1E8FBF03
            BBDDCEEBF5A28EE779BD5EFFB8449F64322908C2683472381C2F40A150E8743A
            ABD58A24C9E7B6B22CA3D4E3F120AB0297CBC5E7F3F9FDFE66B3A9D55A2C167B
            BDDEE1705081FD7E6FB7DBCBE532725AA05EAF974AA5F3F9AC02D7EB35100898
            CDE66EB7AB0572B95CBFDF87FA170D2CCB562A95F1786CB55A9FAB254972B95C
            A150A8D168BC007823954A4106488BC5F2B8DC6EB73003AF0C87438AA254603A
            9DA6D3E9E3F188B34EA7631806DFDB6C367006A64143241251E7208A22CC8626
            D85FABD5E6F339C771CBE5D2643245A3D16C366BB3D9D449A35D2693399D4E18
            3046E676BB91B8DD6E3091FC8AF75DC250F051A3D1D86EB731E9DF972F168BE1
            31080D0683FFD9D69FE313D0AFE0E187B7AB460000000049454E44AE426082}
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Index = 1
          DisplayName = 'TLMDSpecialButton'
          OnClick = edNombaiCustomButtons1Click
          UsePngGlyph = True
        end>
      CustomButtonWidth = 18
      PasswordChar = #0
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = 2
      EditLabel.Width = 41
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 5855577
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'BAIRRO'
    end
  end
  object PanelCadastro: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 52
    Width = 652
    Height = 237
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
      Width = 648
      Height = 233
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouTaxaMun
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
          FieldName = 'Nommun'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nombai'
          Width = 308
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
  object SouTaxaMun: TDataSource
    AutoEdit = False
    DataSet = TabTaxaMun
    Left = 47
    Top = 143
  end
  object TabTaxaMun: TRESTDWClientSQL
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
      'SELECT TMU.*,MUN.Nommun,BAI.Nombai FROM arqtaxaentmun TMU '
      'LEFT JOIN arqmuni MUN ON TMU.Codmun = MUN.Codmun'
      
        'LEFT JOIN arqbairro BAI ON TMU.Codmun = BAI.Codmun AND TMU.Codba' +
        'i = BAI.Codbai'
      'WHERE TMU.IDTaxEnt = 1'
      '')
    UpdateTableName = 'arqtaxaentmun'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 47
    Top = 71
    object TabTaxaMunIDTaxEnt: TIntegerField
      FieldName = 'IDTaxEnt'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTaxaMunCodmun: TIntegerField
      FieldName = 'Codmun'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTaxaMunCodbai: TIntegerField
      FieldName = 'Codbai'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTaxaMunNommun: TWideStringField
      FieldName = 'Nommun'
      ProviderFlags = []
      Size = 55
    end
    object TabTaxaMunNombai: TWideStringField
      FieldName = 'Nombai'
      ProviderFlags = []
      Size = 45
    end
  end
end
