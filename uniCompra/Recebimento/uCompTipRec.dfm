object FrmCompTipRec: TFrmCompTipRec
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'COMPRAS - Tipo Recebimento '
  ClientHeight = 316
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 15
  object AdvSmoothPanel1: TAdvSmoothPanel
    Left = 0
    Top = 0
    Width = 261
    Height = 316
    Cursor = crDefault
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 5
    Caption.Text = ' '
    Caption.HTMLFont.Charset = DEFAULT_CHARSET
    Caption.HTMLFont.Color = clWindowText
    Caption.HTMLFont.Height = -11
    Caption.HTMLFont.Name = 'Tahoma'
    Caption.HTMLFont.Style = []
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -16
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.ColorStart = 4474440
    Caption.ColorEnd = 4474440
    Caption.LineColor = 12895944
    Caption.Line = False
    Fill.Color = 15528703
    Fill.ColorTo = clNone
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = 11908533
    Fill.Rounding = 10
    Fill.RoundingType = rtNone
    Fill.ShadowColor = 13748681
    Fill.ShadowOffset = 0
    Fill.ShadowType = stSurround
    Fill.Glow = gmNone
    Fill.GlowGradientColor = clNone
    Fill.GlowRadialColor = clNone
    Version = '1.7.1.6'
    Align = alClient
    TabOrder = 0
    TabStop = True
    TMSStyle = 0
    object Shape1: TShape
      Left = 26
      Top = 188
      Width = 209
      Height = 1
      Pen.Color = 13092807
    end
    object AdvSmoothPanel3: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 261
      Top = 32
      Width = 0
      Height = 237
      Cursor = crDefault
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption.Text = 'AdvSmoothPanel3'
      Caption.HTMLFont.Charset = DEFAULT_CHARSET
      Caption.HTMLFont.Color = clWindowText
      Caption.HTMLFont.Height = -11
      Caption.HTMLFont.Name = 'Tahoma'
      Caption.HTMLFont.Style = []
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clWindowText
      Caption.Font.Height = -16
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = []
      Caption.ColorStart = 4474440
      Caption.ColorEnd = 4474440
      Caption.LineColor = 12895944
      Caption.Line = False
      Fill.Color = 16382200
      Fill.ColorTo = clNone
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtVertical
      Fill.GradientMirrorType = gtVertical
      Fill.BorderColor = 16382200
      Fill.Rounding = 10
      Fill.ShadowColor = 13748681
      Fill.ShadowOffset = 10
      Fill.ShadowType = stSurround
      Fill.Glow = gmNone
      Fill.GlowGradientColor = clNone
      Fill.GlowRadialColor = clNone
      Version = '1.7.1.6'
      Align = alRight
      TabOrder = 0
      TMSStyle = 0
    end
    object LMDSimplePanel1: TLMDSimplePanel
      Left = 53
      Top = 47
      Width = 155
      Height = 125
      Color = 15528703
      TabOrder = 1
      object RadioXML: TAdvOfficeRadioButton
        Tag = 1
        Left = 9
        Top = 4
        Width = 102
        Height = 20
        Cursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -14
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Alignment = taLeftJustify
        Caption = 'XML da NFe'
        Checked = True
        ReturnIsTab = True
        Version = '1.8.4.0'
      end
      object RadioKey: TAdvOfficeRadioButton
        Tag = 2
        Left = 9
        Top = 36
        Width = 120
        Height = 20
        Cursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Alignment = taLeftJustify
        Caption = 'Chave da NFe'
        ReturnIsTab = False
        Version = '1.8.4.0'
      end
      object RadioDFe: TAdvOfficeRadioButton
        Tag = 3
        Left = 9
        Top = 68
        Width = 148
        Height = 20
        Cursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Alignment = taLeftJustify
        Caption = 'Manifesto da NFe'
        ReturnIsTab = False
        Version = '1.8.4.0'
      end
      object RadioMan: TAdvOfficeRadioButton
        Tag = 4
        Left = 9
        Top = 100
        Width = 120
        Height = 20
        Cursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Alignment = taLeftJustify
        Caption = 'Manualmente'
        ReturnIsTab = False
        Version = '1.8.4.0'
      end
    end
    object CheckNor: TAdvOfficeRadioButton
      Left = 61
      Top = 203
      Width = 85
      Height = 20
      Cursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -15
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Alignment = taLeftJustify
      Caption = 'NORMAL'
      Checked = True
      ReturnIsTab = False
      Version = '1.8.4.0'
    end
    object CheckPre: TAdvOfficeRadioButton
      Tag = 1
      Left = 61
      Top = 232
      Width = 168
      Height = 28
      Cursor = crHandPoint
      AutoSize = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -15
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Alignment = taLeftJustify
      Caption = 'PR'#201' RECEBIMENTO'
      ReturnIsTab = False
      Version = '1.8.4.0'
    end
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 259
      Height = 30
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Color = 14280447
      TabOrder = 4
      object LMDLabel2: TLMDLabel
        Left = 61
        Top = 7
        Width = 140
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16582
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'TIPO RECEBIMENTO'
      end
      object btFechar: TAdvGlowButton
        AlignWithMargins = True
        Left = 235
        Top = 3
        Width = 21
        Height = 24
        Cursor = crHandPoint
        Align = alRight
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
          A9000000206348524D00007A26000080840000FA00000080E8000075300000EA
          6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
          485973000000600000006000F06B42CF0000000774494D4507E70913001308E7
          1DD23A000001BD4944415438CBAD92314B235110C7FF6FA3C4B85B5C6921A25B
          C8711BB0102160B23146D040E266D626C55557F809AC0EE12CC4CA46C817D03A
          2212DC2A040B6D140B1344B138FC00278AFBF2D6A0D96795BBC44B620AA77C33
          BFFFCCFCE7019F15F65224625774FDC3BA8AAED35A38FC1F4C7BBE4F63AE6BE7
          4DB31B9C8D26936408917D6A3456728601000A00B0F2FD3D7E7B1EA6354D261C
          8716E2F14E307B281631190AB1B010CAABEBB61558A5588CC65C97484ADAA8D5
          B2D164F2EF8479D3A42BCE89A4A42BCE2D3937D7CCB1F722CA0FC7C1B4A6614A
          08595A5E56722F2F32E1385857556CD66AFEB774FA901D1F7735A96D923BCFA3
          3BCFEBD4B96758A5588C0C2188A46C0A7583954E8F811BC66481FD5B4F0D0494
          3FAADA97809D374D99701CF67368486E3D3FE3D6F3B03A3888DDFDFDEC753ADD
          53A009370D935F53297F677111179CE33418644785827596C974DCBBD7A9DA8C
          8DD4EBAD220C00567286E157CFCF31190AE182733CA552078F2727AD0D686D7E
          1E5AB188CBE161CCD6EBFEC8CCCCE1F76A550180C6AF89895E30001C6C97CBE0
          990CA684C06930C80646475BD28CD1423C6EC9F1F18F4E6C57749DBE44A37DFD
          877EE20D53CEDA02451D39260000000049454E44AE426082}
        Rounded = True
        TabOrder = 0
        OnClick = btFecharClick
        Appearance.BorderColor = 14280447
        Appearance.BorderColorHot = 14280447
        Appearance.BorderColorCheckedHot = 14280447
        Appearance.BorderColorDown = 14280447
        Appearance.BorderColorChecked = 14280447
        Appearance.BorderColorDisabled = 14280447
        Appearance.BorderColorFocused = 14280447
        Appearance.Color = 14280447
        Appearance.ColorTo = 14280447
        Appearance.ColorChecked = 14280447
        Appearance.ColorCheckedTo = 14280447
        Appearance.ColorDisabled = 14280447
        Appearance.ColorDisabledTo = 14280447
        Appearance.ColorDown = 14280447
        Appearance.ColorDownTo = 14280447
        Appearance.ColorHot = 14280447
        Appearance.ColorHotTo = 14280447
        Appearance.ColorMirror = 14280447
        Appearance.ColorMirrorTo = 14280447
        Appearance.ColorMirrorHot = 14280447
        Appearance.ColorMirrorHotTo = 14280447
        Appearance.ColorMirrorDown = 14280447
        Appearance.ColorMirrorDownTo = 14280447
        Appearance.ColorMirrorChecked = 14280447
        Appearance.ColorMirrorCheckedTo = 14280447
        Appearance.ColorMirrorDisabled = 14280447
        Appearance.ColorMirrorDisabledTo = 14280447
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
    object LMDSimplePanel2: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 270
      Width = 259
      Height = 45
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      Color = 14280703
      TabOrder = 5
      object btConfirma: TAdvGlowButton
        AlignWithMargins = True
        Left = 60
        Top = 8
        Width = 139
        Height = 29
        Cursor = crHandPoint
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Confirmar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6579300
        Font.Height = -15
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
          89504E470D0A1A0A0000000D49484452000000180000001810040000001AEE29
          30000000206348524D00007A26000080840000FA00000080E8000075300000EA
          6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
          485973000000600000006000F06B42CF0000000774494D4507E70719150F0A25
          04D1D50000017F4944415448C763601805A3801450FF9F89095D8C891C83D041
          EE3665E5AC3BB76EBDE17CF62C779BB232B21C0B350CFF9773E000A3A78C0C43
          3203C3DF2F86860C0C77EF52C50730C3193C6564181818181884B66DFBB37BE3
          46AAF820FDBF82C2BF977BF6C00DF7DEB1E38B6770F042C6DFBF91D561F82097
          D3CC2C779B96162197B3281F3ECCD0ACA0007339134340C042C61F3FD0D5A258
          90B9CCDEFE5FD2C993FF122F5ECCC90E0D253658982C8382267BFDFC894D3D8A
          054C5BFEFF6760606060086161F9BF66D932744B48359C81818181199973FAF2
          C387A62E9F3E31FE747767D0626262700E0A32DF7FE7CEA9AF972FA7FF575060
          E4DBB78FE1999C1C3CCCD3828266A9E1361CC30206060686D3474E9C305DF2E5
          0BE349373786FB4C4C0CD7FDFD4DF3BE7C614E9B3D1B6EB8D0B66D4CB2818184
          0C6760606060C42591555958C8F8A9AF0F43C27BC78E2F9E8181D82294281FA0
          F804165C641A4E14C849CDCFCF7AF3F367F6C9D5AB73B7B1B353CD606480AD10
          1B05A3000E006DFDA65FD6E403700000000049454E44AE426082}
        Rounded = True
        TabOrder = 0
        OnClick = btConfirmaClick
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
    end
  end
end
