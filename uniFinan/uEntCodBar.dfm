object FrmTitCodBar: TFrmTitCodBar
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Convenios Grupos Limitados'
  ClientHeight = 102
  ClientWidth = 623
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
  object PanelBase: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 623
    Height = 102
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 8224125
    Bevel.BorderWidth = 1
    Bevel.EdgeStyle = etRaised
    Color = 16447736
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Roboto'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object PanelTop: TLMDSimplePanel
      Left = 1
      Top = 27
      Width = 621
      Height = 74
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 11974326
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15461355
      TabOrder = 0
      object edCodBar: TLMDEdit
        Left = 14
        Top = 21
        Width = 593
        Height = 33
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 0
        OnKeyPress = edCodBarKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Roboto'
        Font.Style = []
        MaxLength = 47
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
      end
    end
    object LMDSimplePanel1: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 621
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 13553358
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15461355
      TabOrder = 1
      object LMDLabel1: TLMDLabel
        Left = 233
        Top = 5
        Width = 155
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 19967
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'LINHA DIGIT'#193'VEL BOLETO'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 599
        Top = 4
        Width = 20
        Height = 16
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Right = 1
        Align = alRight
        AntiAlias = aaAntiAlias
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearType
        HotPicture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000F149
          444154388DAD93A1CEC23014464F77F7DB49140242DF80279840CC903D2AAE02
          8140CF2396308142CE11D614419B0C280592FFBAB5F79C9BAF3783FF2AB746BB
          8AE2635F45E1D6E8F09D05D83A0E36A77115D3043CB5398D751C822403E0CA19
          3802DAE6EC62120FEF000D1C3D731728432F0325D07AC9DED5CCDEC09D082B65
          E80154624A2742C985E1F94C6DE802F32088485A7FAC8156064A65388DFB5F04
          1109B1C9A1B298E0977A114422B4C0CC5AB6B1ED6409B8136195DA0E8CDE20B6
          81903975A77C4361731A12AFFD1C4D0696CAD0DF23FC3101E6EF600065388DE2
          CC3D339A50B3F8FA67AA597CEAFBBA6E891281795F993F800000000049454E44
          AE426082}
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
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000012849
          444154388DAD933D6EC2401046DFAE8D915250A67201C237C80928380908A5B1
          140A40E92C51205345DA2605374941919A9EC2122EA852BA88E4C4981478157E
          D68648F9BA9D9DEF8D666617FE4BBDE1CCF3FDA0712DCFF783466F38F3F4596A
          B325F6EBB4E6ACFAE3D02D33F7C7A19BD69C9525F66B0D91007759FA016C004F
          66BBA509D21F87AECC764BC0033685E700502A4872DBEA005101797F7C9A354B
          CCB1CC4557A9200110155562998B4EE6C8EC3CF6FAF21C6BCF09C000898AB007
          44B96D7516F3C9F638FF02608060AAAC254D80BFE802606821029AB9DCBF99B6
          232BCCB1CC45B76A3B703403D30674CF5577020ECF33AD392B2AA67DDE5AFDFB
          EB41A92091009F76FD1E6895990116F3C9F6A89D56E1F9D560346DDFFA9906A3
          69FB5ADECDFA010A40A5B26FC545D30000000049454E44AE426082}
        Rounded = True
        Spacing = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
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
        Appearance.TextColorChecked = 3750459
        Appearance.TextColorDown = 2303013
        Appearance.TextColorHot = 2303013
        Appearance.TextColorDisabled = 13948116
      end
    end
  end
end
