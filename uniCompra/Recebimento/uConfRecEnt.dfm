object FrmConfRecEnt: TFrmConfRecEnt
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'COMPRAS - Conferencia Recebe Produtos '
  ClientHeight = 88
  ClientWidth = 230
  Color = clBtnFace
  TransparentColor = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
  TextHeight = 15
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 230
    Height = 88
    Align = alClient
    Bevel.BorderColor = 14079702
    Bevel.BorderWidth = 1
    Color = 11060735
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3618615
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LMDLabel8: TLMDLabel
      AlignWithMargins = True
      Left = 32
      Top = 21
      Width = 166
      Height = 16
      Margins.Left = 7
      Alignment = agCenterLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4868682
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'C'#211'DIGO BARRA DO PRODUTO'
    end
    object edBusca: TLMDEdit
      Left = 32
      Top = 39
      Width = 166
      Height = 27
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14079702
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4605510
      Font.Height = -17
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      Spelling.LiveSpell = True
      Text = ''
    end
    object btFechar: TAdvGlowButton
      AlignWithMargins = True
      Left = 210
      Top = 7
      Width = 15
      Height = 16
      Cursor = crHandPoint
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
      TabOrder = 1
      OnClick = btFecharClick
      Appearance.BorderColor = 11060735
      Appearance.BorderColorHot = 11060735
      Appearance.BorderColorCheckedHot = 11060735
      Appearance.BorderColorDown = 11060735
      Appearance.BorderColorChecked = 11060735
      Appearance.BorderColorDisabled = 11060735
      Appearance.BorderColorFocused = 11060735
      Appearance.Color = 11060735
      Appearance.ColorTo = 11060735
      Appearance.ColorChecked = 11060735
      Appearance.ColorCheckedTo = 11060735
      Appearance.ColorDisabled = 11060735
      Appearance.ColorDisabledTo = 11060735
      Appearance.ColorDown = 11060735
      Appearance.ColorDownTo = 11060735
      Appearance.ColorHot = 11060735
      Appearance.ColorHotTo = 11060735
      Appearance.ColorMirror = 11060735
      Appearance.ColorMirrorTo = 11060735
      Appearance.ColorMirrorHot = 11060735
      Appearance.ColorMirrorHotTo = 11060735
      Appearance.ColorMirrorDown = 11060735
      Appearance.ColorMirrorDownTo = 11060735
      Appearance.ColorMirrorChecked = 11060735
      Appearance.ColorMirrorCheckedTo = 11060735
      Appearance.ColorMirrorDisabled = 11060735
      Appearance.ColorMirrorDisabledTo = 11060735
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
