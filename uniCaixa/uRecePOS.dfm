object FrmRecePos: TFrmRecePos
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form'
  ClientHeight = 77
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object PanelBase: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 514
    Height = 77
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13948116
    Bevel.BorderWidth = 1
    Color = 16053492
    TabOrder = 0
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 510
      Height = 18
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14408667
      Bevel.BorderWidth = 1
      Color = 15395562
      TabOrder = 4
      object LMDLabel2: TLMDLabel
        AlignWithMargins = True
        Left = 106
        Top = 1
        Width = 284
        Height = 16
        Margins.Left = 105
        Margins.Top = 0
        Margins.Right = 103
        Margins.Bottom = 0
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderWidth = 1
        Align = alClient
        Alignment = agCenter
        Color = 15263976
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 26574
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'RECEBE VIA POS'
        ExplicitHeight = 15
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 493
        Top = 1
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        AntiAlias = aaAntiAlias
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearType
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
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000F349
          444154388DDD903D4EC34010859FD7B7F0CE0D68683C7B292B0A8126394150C4
          1AA543E21AB9418A68A741E20CE38E22A2019AA1B1A5C55A842861AA7DDFCC9B
          9F05FE57B46DFBC0CCDD777966EE98F931672E1755553D03D833F3AA605E01D8
          0378CA799D0B554D447406109BA6791F86E108002184258068661B11895F8696
          560D212CCDAC37B3B573EE6D7A8BC8765E5B6C30AE7C05E06E94D729A5BE54E7
          4AF0375197E0383D9AD9C6397700D013D187AA1E7F6C9099D722B255D513119D
          CD6C576A52CFCC1D807B003722B29BB8AA9EBCF7AF006EBDF72FAA9AA6DCFC0F
          2E012C524A71C631B205808BD2D97F383E01C26369DBB3CFAA91000000004945
          4E44AE426082}
        Rounded = True
        Spacing = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btFecharClick
        Appearance.BorderColor = 15395562
        Appearance.BorderColorHot = 15395562
        Appearance.BorderColorCheckedHot = 15395562
        Appearance.BorderColorDown = 15395562
        Appearance.BorderColorChecked = 15395562
        Appearance.BorderColorDisabled = 15395562
        Appearance.BorderColorFocused = 15395562
        Appearance.Color = 15395562
        Appearance.ColorTo = 15395562
        Appearance.ColorChecked = 15395562
        Appearance.ColorCheckedTo = 15395562
        Appearance.ColorDisabled = 15395562
        Appearance.ColorDisabledTo = 15395562
        Appearance.ColorDown = 15395562
        Appearance.ColorDownTo = 15395562
        Appearance.ColorHot = 15395562
        Appearance.ColorHotTo = 15395562
        Appearance.ColorMirror = 15395562
        Appearance.ColorMirrorTo = 15395562
        Appearance.ColorMirrorHot = 15395562
        Appearance.ColorMirrorHotTo = 15395562
        Appearance.ColorMirrorDown = 15395562
        Appearance.ColorMirrorDownTo = 15395562
        Appearance.ColorMirrorChecked = 15395562
        Appearance.ColorMirrorCheckedTo = 15395562
        Appearance.ColorMirrorDisabled = 15395562
        Appearance.ColorMirrorDisabledTo = 15395562
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
    object edPOS: TLMDDBLabeledEdit
      Left = 8
      Top = 44
      Width = 32
      Height = 24
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 0
      ValidationMsgString = 'o Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      CustomButtonsStyle = ubsExplorer
      CustomButtonWidth = 19
      CustomButtonParentCtlXP = False
      TabOnEnter = True
      LabelSpacing = 1
      EditLabel.Width = 25
      EditLabel.Height = 16
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -12
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'POS'
    end
    object LMDDBLabeledEdit1: TLMDDBLabeledEdit
      Left = 46
      Top = 44
      Width = 129
      Height = 24
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 1
      ValidationMsgString = 'o Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <
        item
          Cursor = crHandPoint
          ParentFont = False
          PngGlyph.Data = {
            89504E470D0A1A0A0000000D4948445200000014000000130806000000908C2D
            B5000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
            00097048597300000EC300000EC301C76FA864000001BE4944415478DACD93BF
            ABC15118C69FEF68344832CB8F889410063665409181C51F40CC06F907181928
            84C16E2425062603CA8F481928D984E1DE7BDE41095FD7ED76BBEF767ACFF99C
            F73CCF73B88FAFC22F16F7E7C0F1788C743A8D56AB85D3E9048EE3E07038108D
            46A1D3E9DE033288CFE783582C26885AADC6703844AFD7C36C3643B15884C7E3
            F91E70B95CC2643211A456AB4124125D7B6C52BFDF8F66B3894EA703AD56FB1A
            188BC5502E97319D4E21140AEFFAC7E3914046A391F6F102F7FB3DCC66332C16
            0B0A85C2537DE3F138EAF53AD6EB353F70B55A41A3D120994CD2A16795CBE590
            4824B0DBEDF881E7F31956AB1532990C954AE529301289A0D16890412F35CC64
            3248A552E876BB50281477FDC3E100BD5E0FBBDD8E7C3EFF1AC86E0E0402A423
            83CBE5F26B6FB1589069ECB276BB0D954AC50FECF7FB080683D86C36B4160804
            F07ABD24C17C3E275799F34C43A7D37973F60E38180C28634C6896BD6C368BD1
            68846AB58AC96402A9540A97CB8570380CA55279F7B21B207B422814C276BBA5
            DFC1026D3018A877B95C281E6CB247B97C08644165FA482412944A25FA29EFD6
            0DD0ED76D314CC049BCDF6368CD7E59FD6FF077E023F58FCC85AF06322000000
            0049454E44AE426082}
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Index = 0
          DisplayName = 'TLMDSpecialButton'
          UsePngGlyph = True
        end>
      CustomButtonsStyle = ubsExplorer
      CustomButtonWidth = 19
      CustomButtonParentCtlXP = False
      TabOnEnter = True
      DataField = 'Desban'
      DataSource = SouPedidoPos
      LabelSpacing = 1
      EditLabel.Width = 61
      EditLabel.Height = 16
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -12
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'BANDEIRA'
    end
    object edTipPag: TLMDLabeledListComboBox
      Left = 180
      Top = 44
      Width = 100
      Height = 24
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1447446
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Items.Strings = (
        'CREDITO'
        'DEBITO'
        'PARCELADO')
      ItemIndex = 0
      LabelSpacing = 2
      EditLabel.Width = 29
      EditLabel.Height = 16
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -12
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'TIPO'
    end
    object LMDDBLabeledEdit2: TLMDDBLabeledEdit
      Left = 285
      Top = 44
      Width = 126
      Height = 24
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 3
      ValidationMsgString = 'o Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      CustomButtonsStyle = ubsExplorer
      CustomButtonWidth = 19
      CustomButtonParentCtlXP = False
      TabOnEnter = True
      DataField = 'NroNSU'
      DataSource = SouPedidoPos
      LabelSpacing = 1
      EditLabel.Width = 25
      EditLabel.Height = 16
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -12
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'NSU'
    end
    object LMDDBLabeledEdit3: TLMDDBLabeledEdit
      Left = 418
      Top = 44
      Width = 86
      Height = 24
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 5
      ValidationMsgString = 'o Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      CustomButtonsStyle = ubsExplorer
      CustomButtonWidth = 19
      CustomButtonParentCtlXP = False
      TabOnEnter = True
      DataField = 'VlrPago'
      DataSource = SouPedidoPos
      LabelSpacing = 1
      EditLabel.Width = 41
      EditLabel.Height = 16
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -12
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'VALOR'
    end
  end
  object TabPedidoPos: TRESTDWClientSQL
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
    MasterCascadeDelete = False
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <
      item
        DataType = ftInteger
        Name = 'IDFilial'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDPed'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'Nropag'
        ParamType = ptInput
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT POS.*,BAN.Desban FROM arqpedidopagpos POS'
      'LEFT JOIN arqbandeira BAN ON BAN.IDBan = POS.IDBan'
      
        'WHERE POS.IDFilial = :IDFilial AND POS.IDPed = :IDPed AND POS.Nr' +
        'opag = :Nropag')
    UpdateTableName = 'arqpedidopagpos'
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 397
    Top = 1
    object TabPedidoPosIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoPosIDPed: TIntegerField
      FieldName = 'IDPed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoPosNropag: TSmallintField
      FieldName = 'Nropag'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoPosNroPos: TSmallintField
      FieldName = 'NroPos'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoPosIDBan: TIntegerField
      FieldName = 'IDBan'
    end
    object TabPedidoPosNroNSU: TWideStringField
      FieldName = 'NroNSU'
      Size = 12
    end
    object TabPedidoPosTipcar: TWideStringField
      FieldName = 'Tipcar'
      Size = 1
    end
    object TabPedidoPosVlrPago: TFloatField
      FieldName = 'VlrPago'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedidoPosDesban: TWideStringField
      FieldName = 'Desban'
      ProviderFlags = []
      Size = 40
    end
  end
  object SouPedidoPos: TDataSource
    AutoEdit = False
    DataSet = TabPedidoPos
    Left = 446
    Top = 1
  end
end
