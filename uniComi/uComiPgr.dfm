object FrmComiPgr: TFrmComiPgr
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Comiss'#245'es Tabela  Progressiva'
  ClientHeight = 336
  ClientWidth = 398
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
  object PanelEdits: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 398
    Height = 44
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
    TabOrder = 0
    DesignSize = (
      398
      44)
    object LMDLabel1: TLMDLabel
      Left = 11
      Top = 19
      Width = 101
      Height = 15
      Alignment = agCenterRight
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
      Left = 185
      Top = 19
      Width = 54
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'VALOR R$'
    end
    object btIncluir: TAdvGlowButton
      AlignWithMargins = True
      Left = 308
      Top = 15
      Width = 64
      Height = 20
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
      TabOrder = 2
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
    object edLimi: TLMDMaskEdit
      Left = 118
      Top = 14
      Width = 57
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
    object edFixo: TLMDMaskEdit
      Left = 242
      Top = 14
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
      TabOrder = 1
      OnExit = edFixoExit
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
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 379
      Top = 3
      Width = 15
      Height = 16
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
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000EC49
        444154388DC5D1314EC3401005D0B70837744839834B52C0052C5CD023C119A0
        A1C931525021AE00127D04C90DA0085DEE10899E0599C298C4F6BAA2C8AF5633
        F3FFFE3FC3AE119A4775EB5E908B2EC2C43A355C4D8D641EB10A37AE606F4B2A
        472133AFA64603E4390A95BCA96F0432E778C35866B12D52DD399499618CA52F
        97BD087F839F9E0527588A4A07BE452F386E6ADB115B021DABF56F35C6297252
        20E1C410B9BD832E425ABC3FF6CF082D07BD6D47A54CA1F2AABE4EEFC4A1451E
        D876A7F72E3A6D7A1B07D1538A0CE1DA87E8EC37D2917D0FA9082B2C86B61D26
        D6A2120BC1AADBDF1D7E00403362526997B3F70000000049454E44AE426082}
      MarginVert = 0
      MarginHorz = 0
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000F949
        444154388DC591314AC4401885BFDF3981B06748690A2D534C3085BDA067F046
        5E41C15E740321A4D462ED7287052F90E159985992CD04B1DABF1AFEFFBDC77B
        6FE0D463F1E1BD7F949499D95DD334FB14D87BBF91F42CA96FDBF601E02C1E25
        65402969EBBDDFAC90B740696659DC1F044208B7C027904BAAA72245519C4B7A
        0572606766F78B0811E89C7B03AE4660350C4370CEBD039771378D381338B29A
        03BB719DA7C849818413D6C8B30E129314FF13F4DF08330789B6AB1042097CF0
        FB3B8B2FB62979ADEDA3DB97995DC7DBC18173EE254506E8BAEEDBCC6EC64817
        929E161124F592EAB5B69BA6D99B5925A906FA459B279B1FB6F08F86D2B14DA1
        0000000049454E44AE426082}
      Rounded = False
      Spacing = 3
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
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
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3191038
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 15234048
      Appearance.TextColorDisabled = 3191038
    end
  end
  object LMDSimplePanel2: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 45
    Width = 398
    Height = 291
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderWidth = 1
    Color = 16447736
    TabOrder = 1
    DesignSize = (
      398
      291)
    object LMDSimplePanel1: TLMDSimplePanel
      Left = 96
      Top = 8
      Width = 206
      Height = 274
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
        Width = 202
        Height = 266
        Margins.Left = 1
        Margins.Top = 5
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = SouComiPgr
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'Vlrlim'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'AT'#201' A QTD.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = []
            Width = 84
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Vlrfix'
            Title.Alignment = taCenter
            Title.Caption = '% COMIS.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = []
            Width = 69
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
  object TabComiPgr: TRESTDWClientSQL
    Active = False
    AfterOpen = TabComiPgrAfterOpen
    AfterInsert = TabComiPgrAfterInsert
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
    Params = <
      item
        DataType = ftString
        Name = 'IDComi'
        ParamType = ptInput
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT * FROM arqcomipgr WHERE IDComi = :IDComi ORDER BY Vlrlim'
      ''
      ''
      ''
      '')
    UpdateTableName = 'arqcomipgr'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 31
    Top = 119
    object TabComiPgrIDComi: TIntegerField
      FieldName = 'IDComi'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabComiPgrVlrlim: TFloatField
      FieldName = 'Vlrlim'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      DisplayFormat = '###,##0.00'
    end
    object TabComiPgrVlrfix: TFloatField
      FieldName = 'Vlrfix'
      DisplayFormat = '###,##0.00'
    end
  end
  object SouComiPgr: TDataSource
    AutoEdit = False
    DataSet = TabComiPgr
    Left = 31
    Top = 190
  end
end
