object FrmValidaFis: TFrmValidaFis
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FrmValidaFis'
  ClientHeight = 245
  ClientWidth = 445
  Color = clWhite
  TransparentColorValue = 12615935
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  TextHeight = 15
  object LMDSimplePanel1: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 445
    Height = 245
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 8695039
    Bevel.BorderWidth = 2
    Color = clWhite
    TabOrder = 0
    object LMDLabel1: TLMDLabel
      Left = 82
      Top = 16
      Width = 281
      Height = 22
      Alignment = agCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6118749
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'Valida'#231#227'o Fiscal em processamento...'
    end
    object LMDLabel2: TLMDLabel
      Left = 21
      Top = 47
      Width = 42
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6118749
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'Avisos'
    end
    object btValidaFisco: TAdvGlowButton
      AlignWithMargins = True
      Left = 174
      Top = 204
      Width = 98
      Height = 26
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
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
        89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
        F80000000473424954080808087C086488000000097048597300000EC400000E
        C401952B0E1B0000001974455874536F667477617265007777772E696E6B7363
        6170652E6F72679BEE3C1A000002F1494441544889D595CF6B146718C73FCFCC
        0666A3517A34D0A850FF0189E325D0E6A222D696C6DCC31E927566E21A5D8827
        B3F1E48F852561DF31E410D2AB0D54AD825E3C95121C6CFF811C92B690428287
        364D37B0D9A787CCE2EC24AB5B7AF2B9CCBCDFF9BEDFEF3CCF3BCF33F0B18774
        4A9C9898C8D66AB563008EE3AC572A957FFEB7412E97EB711CC7B72CEB8AAA9E
        4EF01578032CA9AA09C370EB3F1B044130A4AA0F811EE007E085AAFE0E6059D6
        A7AA7A1EF812F813C81B63BEEFD8C0F3BC9B22F200789CC964AECFCCCCFC7A10
        AF5028F4D5EBF559E0B2AADE0CC3B0F24103CFF3AE88C823A06C8C9964AF1CEF
        0BF17DFF017003184A67D262303E3E7EA4D168AC003F1A63863A104F9A3C06CE
        AAEA67C933B192AC46A3E1033DAA5A688A178BC5439EE70D1E90E960B1583C14
        2F15B8061CB52CCB4BF25A0C547558559F8461F85B13DBDEDE7645E495EFFBB7
        9B98EFFBB745E455AD563BD3C48C316BC033551D4E6ADACD9BD1D1D16EDBB667
        45A41245D12F4D3C8AA255D7751598765D575DD7FD1C9806A68C31DF26C55CD7
        3D0A8C0D0C0CDC5F5E5EAEB76490C9647AD93B93B574398C3177805BB1F0B4AA
        96622C1D6B80D4EBF5DE7D25B26D5B012CCBEAB8BBD3A1AA125F1BFB0C767676
        D6F79EE9F1F446DFF72781BBAA5A026E8948C9F3BCA9344F44FA00EDEAEAFA63
        9FC1FCFCFCB688FCACAAE7929BE22FE82E301586E1B431E61E302522A52008BE
        48795C00A2E49C4A7FA64BC0E542A1D0D7C4BABBBB5F8BC860B2E6C6983B2232
        E8384ED4C4F2F9FC09E012B0D492557291CBE57AB2D9EC8AAAFE1486E13774D8
        68A552C9DAD8D87802F4ABEAA9B68DB6B0B0F017901791AFE2F6EFE4C0657373
        B30C5C1491B1F4646D37EC2644A40C3CDFDDDDBD363737B77A102F088293AA3A
        1B8BDFA856AB33FBDCDBBD5610045FC7E3FA13F63AF425EF7AE4B8889C072E89
        C85B205FAD569F1E985E3B833893C32272151806FA69FDE14422F29DE3380FCB
        E5F2DFED343A6EAA919111279BCDF6DAB6AD5B5B5BEB8B8B8BB54EF77EDCF12F
        CDCF3376496C4CE00000000049454E44AE426082}
      Rounded = True
      Spacing = 0
      TabOrder = 0
      OnClick = btValidaFiscoClick
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
      Layout = blGlyphRight
    end
    object MemoErro: TMemo
      Left = 21
      Top = 72
      Width = 403
      Height = 120
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3487029
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object Timer: TTimer
    Interval = 250
    OnTimer = TimerTimer
    Left = 401
    Top = 10
  end
end
