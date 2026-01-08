object FrmPromPgr: TFrmPromPgr
  Left = 0
  Top = 0
  Margins.Top = 8
  Margins.Bottom = 10
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Promo'#231#227'o Descontos  Progressivos'
  ClientHeight = 314
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
  object PanelEdits: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 35
    Width = 581
    Height = 64
    Margins.Left = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 15461355
    TabOrder = 0
    object LMDLabel1: TLMDLabel
      Left = 153
      Top = 40
      Width = 101
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'AT'#201' A QUANTIDADE'
    end
    object LMDLabel2: TLMDLabel
      Left = 336
      Top = 40
      Width = 81
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'PR.PROMO'#199#195'O'
    end
    object LMDLabel6: TLMDLabel
      Left = 18
      Top = 11
      Width = 53
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'PRODUTO'
    end
    object LMDLabel3: TLMDLabel
      Left = 34
      Top = 40
      Width = 37
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'PRE'#199'O'
    end
    object btIncluir: TAdvGlowButton
      AlignWithMargins = True
      Left = 501
      Top = 36
      Width = 70
      Height = 21
      Cursor = crHandPoint
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Incluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Rounded = True
      TabOrder = 5
      OnClick = btIncluirClick
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
    end
    object edPrVenda: TLMDMaskEdit
      Left = 419
      Top = 35
      Width = 68
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14737632
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
      OnKeyPress = edPrVendaKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      BlankChar = #0
      CustomButtons = <>
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edQtdven: TLMDMaskEdit
      Left = 259
      Top = 35
      Width = 60
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14737632
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      BlankChar = #0
      CustomButtons = <>
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edIDProd: TLMDEdit
      Left = 74
      Top = 6
      Width = 100
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14737632
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      OnExit = edIDProdExit
      OnKeyPress = edIDProdKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #0
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
    end
    object edNompro: TLMDLabeledEdit
      Left = 182
      Top = 7
      Width = 389
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14737632
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 1
      OnKeyDown = edNomproKeyDown
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      CharCase = ecUpperCase
      ParentFont = False
      CustomButtons = <
        item
          Color = clWhite
          Cursor = crHandPoint
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
          Index = 0
          DisplayName = 'TLMDSpecialButton'
          OnClick = edNomproCustomButtons0Click
          UsePngGlyph = True
        end>
      PasswordChar = #0
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -12
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Caption = 'edBusca'
    end
    object edPreco: TLMDMaskEdit
      Left = 75
      Top = 35
      Width = 62
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14079702
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = 14017279
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      BlankChar = #0
      CustomButtons = <>
      Decimals = 2
      MaskType = meFloatNumber
      ReadOnly = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
  end
  object LMDSimplePanel2: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 101
    Width = 581
    Height = 207
    Margins.Left = 0
    Margins.Top = 2
    Margins.Right = 0
    Margins.Bottom = 6
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderWidth = 1
    Color = 16447736
    TabOrder = 1
    DesignSize = (
      581
      207)
    object LMDSimplePanel1: TLMDSimplePanel
      Left = 200
      Top = 8
      Width = 217
      Height = 190
      Margins.Top = 0
      Anchors = [akLeft, akTop, akBottom]
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15132390
      Bevel.BorderWidth = 1
      Color = clWhitesmoke
      TabOrder = 0
      object DBGrid1: TDBGrid
        Tag = 1
        AlignWithMargins = True
        Left = 2
        Top = 6
        Width = 213
        Height = 182
        Margins.Left = 1
        Margins.Top = 5
        Margins.Right = 1
        Margins.Bottom = 1
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
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
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
            FieldName = 'Qtdven'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'AT'#201' A QTD.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = []
            Width = 73
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'PreVenda'
            Title.Alignment = taCenter
            Title.Caption = 'PRE'#199'O VENDA'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = []
            Width = 95
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
            Width = 26
            Visible = True
          end>
      end
    end
  end
  object PanelTop: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 581
    Height = 32
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 15461355
    TabOrder = 2
    Visible = False
    object LMDLabel4: TLMDLabel
      Left = 204
      Top = 9
      Width = 173
      Height = 17
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 19967
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'DESCONTOS PROGRESSIVOS'
    end
  end
  object TabPromPgr: TRESTDWClientSQL
    Active = False
    AfterOpen = TabPromPgrAfterOpen
    AfterInsert = TabPromPgrAfterInsert
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
      'SELECT * FROM arqpromopgr ORDER BY Qtdven LIMIT 10'
      ''
      ''
      ''
      '')
    UpdateTableName = 'arqpromopgr'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 63
    Top = 135
    object TabPromPgrIDProm: TIntegerField
      FieldName = 'IDProm'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPromPgrIDProd: TIntegerField
      FieldName = 'IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPromPgrQtdven: TFloatField
      FieldName = 'Qtdven'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = '###,##0.00'
    end
    object TabPromPgrPreVenda: TFloatField
      FieldName = 'PreVenda'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object SouPromPgr: TDataSource
    AutoEdit = False
    DataSet = TabPromPgr
    Left = 63
    Top = 206
  end
end
