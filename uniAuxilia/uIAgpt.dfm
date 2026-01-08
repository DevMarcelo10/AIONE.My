object FrmIAgpt: TFrmIAgpt
  AlignWithMargins = True
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'IA GPT'
  ClientHeight = 784
  ClientWidth = 1141
  Color = 4144959
  TransparentColorValue = 4605510
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 14
  object PanelBas: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1141
    Height = 784
    Cursor = crDefault
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
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
    Caption.Line = False
    Fill.Color = 15399935
    Fill.ColorTo = 10146044
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = clNone
    Fill.BorderOpacity = 0
    Fill.BorderWidth = 0
    Fill.Rounding = 8
    Fill.ShadowColor = clNone
    Fill.ShadowOffset = 0
    Fill.ShadowType = stSurround
    Fill.Glow = gmNone
    Fill.GlowGradientColor = clNone
    Fill.GlowRadialColor = clNone
    Version = '1.7.1.6'
    Align = alClient
    TabOrder = 0
    DesignSize = (
      1141
      784)
    TMSStyle = 0
    object PanelCenter: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 179
      Top = 176
      Width = 782
      Height = 521
      Cursor = crDefault
      Margins.Left = 20
      Margins.Top = 2
      Margins.Right = 20
      Margins.Bottom = 1
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
      Caption.Line = False
      Caption.TextWordWrapping = False
      Fill.Color = clNone
      Fill.ColorTo = clNone
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtVertical
      Fill.GradientMirrorType = gtVertical
      Fill.Opacity = 0
      Fill.BorderColor = clNone
      Fill.BorderWidth = 0
      Fill.Rounding = 0
      Fill.RoundingType = rtNone
      Fill.ShadowColor = clNone
      Fill.ShadowOffset = 10
      Fill.ShadowType = stSurround
      Fill.Glow = gmNone
      Fill.GlowGradientColor = clNone
      Fill.GlowRadialColor = clNone
      Version = '1.7.1.6'
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      TMSStyle = 0
      object lbResposta: TLMDLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 776
        Height = 480
        Margins.Bottom = 38
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 11064319
        Bevel.BorderWidth = 1
        Align = alClient
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 423118
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = []
        MultiLine = True
        Options = []
        ParentFont = False
        ExplicitTop = 48
        ExplicitHeight = 555
      end
    end
    object PanelBusca: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 179
      Top = 721
      Width = 779
      Height = 34
      Cursor = crDefault
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
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
      Caption.ColorStart = 4144959
      Caption.ColorEnd = 4144959
      Caption.Line = False
      Fill.Color = 8045052
      Fill.ColorTo = clNone
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtVertical
      Fill.GradientMirrorType = gtVertical
      Fill.BorderColor = clNone
      Fill.BorderWidth = 0
      Fill.Rounding = 6
      Fill.ShadowColor = clWhite
      Fill.ShadowOffset = 0
      Fill.ShadowType = stSurround
      Fill.Glow = gmNone
      Fill.GlowGradientColor = clNone
      Fill.GlowRadialColor = clNone
      Version = '1.7.1.6'
      Anchors = [akLeft, akBottom]
      TabOrder = 1
      DesignSize = (
        779
        34)
      TMSStyle = 0
      object AdvSmoothPanel3: TAdvSmoothPanel
        AlignWithMargins = True
        Left = 748
        Top = 0
        Width = 0
        Height = 34
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
      object edPergunta: TLMDEdit
        Left = 15
        Top = 7
        Width = 720
        Height = 20
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.Mode = bmCustom
        Bevel.StandardStyle = lsNone
        Caret.BlinkRate = 530
        Color = 8045052
        TabOrder = 1
        OnKeyPress = edPerguntaKeyPress
        Anchors = [akLeft, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 421828
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        Text = ''
      end
      object btBusca: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 748
        Top = 7
        Width = 22
        Height = 26
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 7
        Margins.Right = 9
        Margins.Bottom = 1
        Align = alRight
        Anchors = [akLeft, akTop, akBottom]
        BorderStyle = bsNone
        DownPicture.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000181006000000B0E7E1
          BB000000097048597300000B1300000B1301009A9C18000000206348524D0000
          7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
          C546000003A14944415478DAD4977F685B5514C73FF725DA21A3B4CD9B6C1104
          53ED4AACD2C62E4E5A268CFDA36EC5C6A68C324BB1C9AB4E843A868C515DB015
          44C6E81F52248DC19F65BAEDB56C5D0943861BAE8651ADD3E81F15B65143A95B
          92D62A4C2179D73FD654D69ABDAE4BBBEEFC7539F79C7BBFDFF3BEEFDC7B9152
          4A2959B5F66795A681AA4EC916A0A828EBCFE2B6AE16A0BFB7BDB21B1C0ECBA9
          B41D3C1EF6898FC053FF4F0523F0E46622F7C66066E68F73ADA7A0B4F47A562A
          B5E2049227DBC2E0743248083C1E668CA3E0A9975D990054B9E812E3B3A15B6F
          481CA3190A0BAFFD75CFBB60B516CEBA45F65308218410F9039A7AC8EF86472B
          3217C579F0BE20BEA11CBC8D94B3059CCE5B5EB087AD303CAC1E08EE849A9ADB
          9690940140511289B80FAA5CA84A08763CA7B8714253933144253C5226125402
          507E7B05917B390D7A3F076EF45BCD817A1BC1629D4A1517C1539B8D3E00AF37
          694CEC818606817208EC76126800726879A467ECB158A15F9FEF5F20A1D4A72F
          3BA0A6D6582327C1D7CAB87C1FEAEA68260A25257943344C3564D2A2911EB8F6
          B78CE386B56B17006C970118FDDEF679AF1D5C4FE4EC42573B350D36D80D8731
          0267CF50C6365014209AD752EEA3162E5D14112A21F4A13CCD07D0D99933BE50
          6900BD3FD7B4921D4C4F163C0FA994E8918370E187BC6BE06D1A201C161E631A
          B63C2D5B6802BF9F32AA670BF5FFB61D1FE87AAEE99C5D687E17515AD060D72E
          7910A0F46133BC623FED70F58AD4E806AD4DDD140CC2C040B2401B824F3E9671
          06E0C5E69CF92E6A616CCCF65BB019366E5CF86FCEE2BED5366A4AEC2D221089
          104FEF84D656F544F83D98984816F81D50EF9171B10DF463A61BE9F8E09D2EB5
          2DE8868E37F34660E14200429972F8DDE074965CEA3D0F3FC7B2F3891D2FBD01
          763B4E4B007EBCC05ED10E36D5745D0C03AA37AD5B170AC17723CB46C08C58B2
          4ED3E1E409C244E099674D13BB1986CB976D5DC118384AAF6392462E02CA725D
          19A6B7FB2AE0B18A4503FF4F3A3DD0AFE7029EB30BE5DB8A064331F829C65700
          E3E38BCD531E9767E1E8B145C72F1781B90AF6F1D9CDDAE05C7CAD3C049393C5
          871FE88068F48E1398DBE03EB91F8E1C31D79CE2005D17220018C6AA21507CB8
          B703BE8D9A49498EA0DEECC4BD63044CA5745076433261B36FF805CE7CBDEA08
          984AE97EF1201C3F2E2C01209D5E42BF5E9937F1DCB9F0BAD607A3A389739A0B
          3299ECED77C9B857FA51FFEBABAF0D41C19A2B5FECFE12D6AF5F7A41E69DC477
          AB29DCE5F6EF00A93DAFEF13B14E4C0000000049454E44AE426082}
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16363008
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearType
        HotPicture.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000181006000000B0E7E1
          BB000000097048597300000B1300000B1301009A9C18000000206348524D0000
          7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
          C546000003654944415478DACC985F689B6514C67FE74D459131422CA30D6548
          523B8975B05875B6A3DECEAA81C66548E9446C374BE9BA147721A2A5300551D1
          36EC62CCAEFE1BA3742E1B6594B1ABAD94DA8BAD66DD9432248E20A37433C810
          F522798F176BBBB290F6D3346BCEE5FB9D73BEE739DF73CECBF9505555A5644D
          B3EF04A1BC5C350AB8DD4BE70BB8CB4A06A846FF009F0F6B3B201CC6C8AC3485
          9B2153C5F9E7B703756CBC7347B5E74D4DFBFD77A3D2695964222222F22080EE
          1F8340006B26211C065AA531DC8CE10813DB822B842631D6621FDAA899CA4ACC
          A7DFA9CECF178D806ACF6678AA16340591D74027A52EB21B18613A10F81F29C3
          344D4E8A0C34EAD986868225A4DA071803E96ED816041383575F06FD5C6A5B5A
          C0A6F8F9899A6521234C175493CFF46CFCF4FD87AB7E01D5C86E7095612B8FC0
          0BDB31F28A4C4422403F2DBB760127F8CDEB2DBEF8A44FADDF2FD2EF86647209
          F7FD0454A30968D801BA5306DBDB8000EF8642C056D21ECF1A220A61B21920CD
          A37FFF034CF0E7860D395E960E76FC382DAE8127753CF84CDE29A41A3D0E955E
          D05E291BBF08BCCE3E638A50CA4E6A7E4D02AD3A3B780CA890BF0E1D027C79FC
          8FEB78AE7416ED1E409BF5403A8DE513EAAF24D61CB6D5285F0F0D61ED2F3ADB
          F822502D357BF7023EEC0A8532B61EE2F1BCC2CAD7033953C4EA98045A5B319C
          67D65FED00720D9B6ECD8374EADCBEB745FA81336754A34139FCED37A08D74EF
          796385317190DAEBD74562553AB3654B6E6FE6E981FF3C1E7389BD47FBB97390
          6DD7A36D6D228747E1E64DD5EE21680E83CC88899F72F0A62AD21F7D28123BA8
          EEF73F583302B98900C440CF66080444BE48C14FD7EE3DEF0A81D70BAE2ED934
          730518E3F663E50E325BB575CF8AC46270F9523E020537E95DD26A73812F10B3
          AE84740C7EE91C38F354DFB801B1184CAF7A7398A28D6D7B20044FD7620873F4
          A526E77174317C3ABE5898F523600646E1EA35C08D2F95721EA7310D7E7FCAB1
          7BD1EECDA50A6A2F27F28FC165D68B776E0E3CC33035B5EE0496598B3E77F2A4
          03BF0B0CC6E3227D80B5254420360C3F4CAD2E257D5C77E6BF71D78D80032935
          51FEFB6DAC2708172F941C010752F2F0F1E8A8B8FA804CA684092C48C992A43E
          9158DAB090327DEBD857056C4E0F76A9D7ECFE3178F811D5CE11A8A82814B794
          FA5F8952EA81A2D8BF0300C4C5BB36F6B4D4CE0000000049454E44AE426082}
        MarginVert = 2
        MarginHorz = 0
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000181006000000B0E7E1
          BB000000097048597300000B1300000B1301009A9C18000000206348524D0000
          7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
          C546000003A14944415478DAD4977F685B5514C73FF725DA21A3B4CD9B6C1104
          53ED4AACD2C62E4E5A268CFDA36EC5C6A68C324BB1C9AB4E843A868C515DB015
          44C6E81F52248DC19F65BAEDB56C5D0943861BAE8651ADD3E81F15B65143A95B
          92D62A4C2179D73FD654D69ABDAE4BBBEEFC7539F79C7BBFDFF3BEEFDC7B9152
          4A2959B5F66795A681AA4EC916A0A828EBCFE2B6AE16A0BFB7BDB21B1C0ECBA9
          B41D3C1EF6898FC053FF4F0523F0E46622F7C66066E68F73ADA7A0B4F47A562A
          B5E2049227DBC2E0743248083C1E668CA3E0A9975D990054B9E812E3B3A15B6F
          481CA3190A0BAFFD75CFBB60B516CEBA45F65308218410F9039A7AC8EF86472B
          3217C579F0BE20BEA11CBC8D94B3059CCE5B5EB087AD303CAC1E08EE849A9ADB
          9690940140511289B80FAA5CA84A08763CA7B8714253933144253C5226125402
          507E7B05917B390D7A3F076EF45BCD817A1BC1629D4A1517C1539B8D3E00AF37
          694CEC818606817208EC76126800726879A467ECB158A15F9FEF5F20A1D4A72F
          3BA0A6D6582327C1D7CAB87C1FEAEA68260A25257943344C3564D2A2911EB8F6
          B78CE386B56B17006C970118FDDEF679AF1D5C4FE4EC42573B350D36D80D8731
          0267CF50C6365014209AD752EEA3162E5D14112A21F4A13CCD07D0D99933BE50
          6900BD3FD7B4921D4C4F163C0FA994E8918370E187BC6BE06D1A201C161E631A
          B63C2D5B6802BF9F32AA670BF5FFB61D1FE87AAEE99C5D687E17515AD060D72E
          7910A0F46133BC623FED70F58AD4E806AD4DDD140CC2C040B2401B824F3E9671
          06E0C5E69CF92E6A616CCCF65BB019366E5CF86FCEE2BED5366A4AEC2D221089
          104FEF84D656F544F83D98984816F81D50EF9171B10DF463A61BE9F8E09D2EB5
          2DE8868E37F34660E14200429972F8DDE074965CEA3D0F3FC7B2F3891D2FBD01
          763B4E4B007EBCC05ED10E36D5745D0C03AA37AD5B170AC17723CB46C08C58B2
          4ED3E1E409C244E099674D13BB1986CB976D5DC118384AAF6392462E02CA725D
          19A6B7FB2AE0B18A4503FF4F3A3DD0AFE7029EB30BE5DB8A064331F829C65700
          E3E38BCD531E9767E1E8B145C72F1781B90AF6F1D9CDDAE05C7CAD3C049393C5
          871FE88068F48E1398DBE03EB91F8E1C31D79CE2005D17220018C6AA21507CB8
          B703BE8D9A49498EA0DEECC4BD63044CA5745076433261B36FF805CE7CBDEA08
          984AE97EF1201C3F2E2C01209D5E42BF5E9937F1DCB9F0BAD607A3A389739A0B
          3299ECED77C9B857FA51FFEBABAF0D41C19A2B5FECFE12D6AF5F7A41E69DC477
          AB29DCE5F6EF00A93DAFEF13B14E4C0000000049454E44AE426082}
        Rounded = False
        Spacing = 4
        TabOrder = 2
        OnClick = btBuscaClick
        Appearance.BorderColor = 8045052
        Appearance.BorderColorHot = 8045052
        Appearance.BorderColorCheckedHot = 8045052
        Appearance.BorderColorDown = 8045052
        Appearance.BorderColorChecked = 8045052
        Appearance.BorderColorDisabled = 8045052
        Appearance.BorderColorFocused = 8045052
        Appearance.Color = 8045052
        Appearance.ColorTo = 8045052
        Appearance.ColorChecked = 8045052
        Appearance.ColorCheckedTo = 8045052
        Appearance.ColorDisabled = 8045052
        Appearance.ColorDisabledTo = 8045052
        Appearance.ColorDown = 8045052
        Appearance.ColorDownTo = 8045052
        Appearance.ColorHot = 8045052
        Appearance.ColorHotTo = 8045052
        Appearance.ColorMirror = 8045052
        Appearance.ColorMirrorTo = 8045052
        Appearance.ColorMirrorHot = 8045052
        Appearance.ColorMirrorHotTo = 8045052
        Appearance.ColorMirrorDown = 8045052
        Appearance.ColorMirrorDownTo = 8045052
        Appearance.ColorMirrorChecked = 8045052
        Appearance.ColorMirrorCheckedTo = 8045052
        Appearance.ColorMirrorDisabled = 8045052
        Appearance.ColorMirrorDisabledTo = 8045052
        Appearance.TextColorChecked = 12180992
        Appearance.TextColorDown = 12180992
        Appearance.TextColorHot = 12180992
        Appearance.TextColorDisabled = 12180992
      end
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 32
    Top = 16
  end
end
