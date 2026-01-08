object FrmGeraBol: TFrmGeraBol
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FINANCEIRO - Gerar Boletos'
  ClientHeight = 169
  ClientWidth = 422
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  TextHeight = 15
  object PanelCabecalho: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 422
    Height = 26
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 1
    Align = alTop
    Bevel.BorderColor = clSilver
    Bevel.BorderInnerWidth = 1
    Color = 15987699
    TabOrder = 0
    DesignSize = (
      422
      26)
    object LMDLabel1: TLMDLabel
      Left = 156
      Top = 6
      Width = 110
      Height = 14
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alCustom
      Alignment = agTopCenter
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'GERAR BOLETOS'
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 398
      Top = 2
      Width = 24
      Height = 23
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 5
      Anchors = [akTop, akRight]
      AntiAlias = aaAntiAlias
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Font.Quality = fqClearType
      HotPicture.Data = {
        89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
        F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000015B49
        4441544889ED543B6E0231149CB776012847400469D3A700459BDD14E4007006
        EEC401C819481B09A4C8BB8A024DEA2045842B0428EC750A58F2E1D959A5444C
        65D9CF33EF337AC009470FE22EEDB87386DAAA0F6146D49E2D7C0476DA6AC088
        1E2A9B215DBE7CFC7E0FD85FB5551F9606D0525915874E721587D052C1D200EB
        6A9F8BE1058419015802A84398092762551C429809803A8025827C545A80DAB3
        058CB801F0B61749AF2FF6E459D484300F7BF23CB8A5ABE777968BADE02BCBF3
        5D96CD82086435C88EBFDF519CBDBA38BC023B919FADD8627B36A243493AF7FD
        FF5380A904289179017EC8075179A944FE2560551C82EC238A9E17EE0AF2B1CF
        C2A50438B7F8DCC5C159BACDA2A6CB2D9CBB5CF3E057C5B4D580960A1EB71CB8
        4BEA845B2B7C8B8CE8F9C8018092740E233A2866A26597A392AC406533C4BA6A
        21F53D454FCE6547493AB7D356022DBBA8AEEF5C71271C393E017EACA8007609
        F2770000000049454E44AE426082}
      MarginVert = 0
      MarginHorz = 0
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -12
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
        F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000017749
        4441544889ED93DD4A02511485D739676C087A0431617A0BBB30E8369F411006
        114123060C14820914EC0711BA181083DEC0EB40217C8B84325F218498737617
        39E1CF9971E8325C57C3F959DFD97BAF0176FAF762BAC552E9EAC037CD3C141B
        789DDA34CAC0AEB452E0949B0BA3FF74E37CAEEF73DD25DF34F360D4055763DB
        71AD5073C7B5C0D5188CBAFBEA2BAF3BA30540B10108333024E18B910E623BAE
        055F8CC0900461668006B1015EA736955C1D03780B2085F3E651B05FAC36D390
        E239309760270F77F50F9D977606810A17D78782F808403A304A107CC569B8BC
        D6BBBF7C0DF38804009BAD58DCFAF93664D66B372651F7B702362A0110E7E581
        F4435E53428A580FF913C0765C4B317AC1A2E741BA04681815E158005D5AA2D2
        A55368E9C56A331D96165DBAC2E6A1ADC0AEB4522B6D316476D9A0775B7F8790
        A72BEDAAB452B101E094DB1645AFDD98C090D9DF3F5EC8B3D880B930FA0095A1
        78262AE75EBB3181E21980CA73BEF718766EA77FAE6F167DBB96DA8EA7150000
        000049454E44AE426082}
      Rounded = True
      Spacing = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btFecharClick
      Appearance.BorderColor = 15987699
      Appearance.BorderColorHot = 15987699
      Appearance.BorderColorCheckedHot = 15987699
      Appearance.BorderColorDown = 15987699
      Appearance.BorderColorChecked = 15987699
      Appearance.BorderColorDisabled = 15987699
      Appearance.BorderColorFocused = 15987699
      Appearance.Color = 15987699
      Appearance.ColorTo = 15987699
      Appearance.ColorChecked = 15987699
      Appearance.ColorCheckedTo = 15987699
      Appearance.ColorDisabled = 15987699
      Appearance.ColorDisabledTo = 15987699
      Appearance.ColorDown = 15987699
      Appearance.ColorDownTo = 15987699
      Appearance.ColorHot = 15987699
      Appearance.ColorHotTo = 15987699
      Appearance.ColorMirror = 15987699
      Appearance.ColorMirrorTo = 15987699
      Appearance.ColorMirrorHot = 15987699
      Appearance.ColorMirrorHotTo = 15987699
      Appearance.ColorMirrorDown = 15987699
      Appearance.ColorMirrorDownTo = 15987699
      Appearance.ColorMirrorChecked = 15987699
      Appearance.ColorMirrorCheckedTo = 15987699
      Appearance.ColorMirrorDisabled = 15987699
      Appearance.ColorMirrorDisabledTo = 15987699
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
  object PanelInventario: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 125
    Width = 422
    Height = 43
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 1
    Align = alClient
    Bevel.BorderColor = clSilver
    Bevel.BorderInnerWidth = 1
    Color = 15987699
    TabOrder = 1
    object btGeraBoleto: TAdvGlowButton
      AlignWithMargins = True
      Left = 139
      Top = 10
      Width = 145
      Height = 24
      Cursor = crHandPoint
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Gerar Boletos'
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
      Rounded = True
      Spacing = 0
      TabOrder = 0
      OnClick = btGeraBoletoClick
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
  end
  object LMDSimplePanel1: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 28
    Width = 422
    Height = 96
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = clSilver
    Bevel.BorderWidth = 1
    Color = clWhite
    TabOrder = 2
    object ckPessoa: TLMDCheckBox
      Left = 34
      Top = 13
      Width = 117
      Height = 17
      Caption = 'POR PESSOA'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = ckPessoaClick
      Checked = True
      State = cbChecked
    end
    object ckConvenio: TLMDCheckBox
      Left = 226
      Top = 13
      Width = 117
      Height = 17
      Caption = 'POR CONV'#202'NIO'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = ckConvenioClick
    end
    object chbPdfBol: TLMDCheckBox
      AlignWithMargins = True
      Left = 34
      Top = 39
      Width = 203
      Height = 19
      Caption = 'GERAR BOLETOS EM PDF'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = chbPdfBolClick
      Checked = True
      State = cbChecked
    end
    object chbEmailBol: TLMDCheckBox
      Left = 34
      Top = 66
      Width = 186
      Height = 19
      Caption = 'ENVIAR BOLETOS POR EMAIL'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = chbEmailBolClick
    end
    object chbGeraRem: TLMDCheckBox
      Left = 226
      Top = 39
      Width = 132
      Height = 19
      Caption = 'GERAR REMESSA'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = chbGeraRemClick
      Checked = True
      State = cbChecked
    end
    object chbRegOnLine: TLMDCheckBox
      Left = 226
      Top = 66
      Width = 171
      Height = 19
      Caption = 'REGISTRAR BOLETO ONLINE'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
  end
end
