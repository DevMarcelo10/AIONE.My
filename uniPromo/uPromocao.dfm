object FrmPromocao: TFrmPromocao
  Left = 490
  Top = 228
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'Promocoes'
  ClientHeight = 582
  ClientWidth = 942
  Color = 16381167
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelAbre: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 942
    Height = 582
    Align = alClient
    Color = 15792383
    TabOrder = 0
    OnResize = PanelAbreResize
    object PanelBusca: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 160
      Top = 99
      Width = 623
      Height = 138
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
      Fill.Color = 11060735
      Fill.ColorTo = clNone
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtVertical
      Fill.GradientMirrorType = gtVertical
      Fill.BorderColor = 14867104
      Fill.BorderWidth = 0
      Fill.Rounding = 10
      Fill.ShadowColor = 13748681
      Fill.ShadowOffset = 2
      Fill.ShadowType = stSurround
      Fill.Glow = gmNone
      Fill.GlowGradientColor = clNone
      Fill.GlowRadialColor = clNone
      Version = '1.7.1.5'
      TabOrder = 0
      TabStop = True
      DesignSize = (
        623
        138)
      TMSStyle = 0
      object lbAjuda: TLMDLabel
        Left = 14
        Top = 72
        Width = 595
        Height = 52
        Alignment = agTopCenter
        AutoSize = False
        Color = 9600370
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 19948
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        MultiLine = True
        Options = []
        ParentColor = False
        ParentFont = False
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Entre com a descri'#231#227'o ou nosso c'#243'digo interno'
      end
      object AdvSmoothPanel2: TAdvSmoothPanel
        AlignWithMargins = True
        Left = 623
        Top = 0
        Width = 0
        Height = 138
        Cursor = crDefault
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption.Text = 'AdvSmoothPanel2'
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
        Version = '1.7.1.5'
        Align = alRight
        TabOrder = 0
        TMSStyle = 0
      end
      object edBusca: TLMDLabeledEdit
        Left = 14
        Top = 41
        Width = 595
        Height = 24
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15657192
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        ParentThemeMode = False
        TabOrder = 1
        Transparent = True
        OnKeyDown = edBuscaKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 15801
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <
          item
            Color = clWhite
            Cursor = crHandPoint
            Layout.Spacing = 0
            Layout.ArrowIndent = 2
            Layout.ArrowSize = 2
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F80000000473424954080808087C086488000000017352474200AECE1CE90000
              000467414D410000B18F0BFC6105000000097048597300000EC200000EC20115
              284A800000001974455874536F667477617265007777772E696E6B7363617065
              2E6F72679BEE3C1A000000524944415478DA63FC0F040C34048CA3168C540BBE
              7D616078F6803493A4141818B87888B3E0FF8AC90C8C978E9364FE7F3D4B06C6
              88DC41E2036A82D14846E8198D64EA5A301AC9042DA02218B560E02D0000ECE7
              89B97B82FFB00000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edBuscaCustomButtons0Click
            UsePngGlyph = True
          end
          item
            Color = clWhite
            Cursor = crHandPoint
            Layout.Spacing = 0
            Layout.ArrowIndent = 0
            Layout.ArrowSize = 2
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              000970485973000012740000127401DE661F780000018F4944415478DAED954B
              28446118869F6992CB4659B13145915B98921166C94E962E1BD1EC64A738C5A4
              2485050A2B9B6121091B0B4D211B947219166E85052521492C8CEFEFD0087366
              E64811EFE674EA3FEFF37DEFF7FD1D8B5FC437CAF20FF8C580A727D859839579
              585F82AB0B98D8FA22E0ADE9D12E6416802D0DE6C6E0E61286BD2600CA746F53
              3755CFB45C7094417A1E9C9F427F339457C1810F5C6D61028C4C2D16FDCCD989
              6EDED8050BD3905F0AD985610054AB1DF5F281138AC434353B60FAAAB3631868
              81A66E484C06AD063A2526AB350CC0E3038C4A55C77B629E05792590239545C7
              7E344FB24934DB7A07AEF64F130E3E03BFC4742883DC58069F0C362A1AB264A8
              ABDE80B992A74F8A2896221C1102DEEBF65AB6C5239DC44165C34B117EC37822
              03BC4206251E6D447FDF97BD5F9CFD747BCC0194DC75D03A0431D289A737E8F6
              98074C0E434A26D865CBB46A89673C683CE600EA422DCD80B322643CE6006ABB
              B45AC8B0EB5D18C4630EA034E2D66F78CF94613CE601EA32DEDF417C42C8A33F
              F87FF06700CF07FFDFB9F95E7D720000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 1
            DisplayName = 'TLMDSpecialButton'
            OnClick = edBuscaCustomButtons1Click
            UsePngGlyph = True
          end>
        CustomButtonsStyle = ubsDelphi
        CustomButtonWidth = 22
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 4
        EditLabel.Width = 74
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = 16582
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'PROMO'#199#213'ES'
      end
    end
    object PanelItens: TLMDSimplePanel
      Left = 229
      Top = 267
      Width = 485
      Height = 278
      Color = 15792383
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      Transparent = True
      Visible = False
      object PanelBotes: TLMDSimplePanel
        AlignWithMargins = True
        Left = 0
        Top = 250
        Width = 485
        Height = 28
        Margins.Left = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alBottom
        Bevel.BorderColor = clWhite
        Color = 15792383
        TabOrder = 0
        object btRetorna: TAdvGlowButton
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 95
          Height = 28
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Retorna'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2697513
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Font.Quality = fqClearType
          MarginVert = 0
          MarginHorz = 8
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
            A9000000097048597300000B1300000B1301009A9C18000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000000F34944415478DA62FCFF9F813280CB8092186E9E5CAE450B734C12
            93FEFF87A8C386B11A5012C3CD9373E4E0C1DCBCFFFF731F3C7A88CF002674CD
            656ABC7C3FA3766E675C6567F7BFEDF3A7FFB322A389F642991A2F5FEEB62387
            73F3FEFFCFF9F2E9634E95B50D4C0D412FE0D24C9401F83413328085818181E1
            FB91D52B195AAC6D1894BE7C61D4F0F69DFCE4E8116263111288198CF0C064BC
            F4FF1F29C9808981818181F34A482883C7D1230CF77878FEB16DDB8AEE05A262
            81A240A44A34E23384A494D875EBF3A7BF5F3C3C19240E1F62ACE2E5633CB06C
            295999296B150F4FEE87C58B73431212F0B98091D2EC0C1800643711070BE34F
            2B0000000049454E44AE426082}
          Rounded = True
          Spacing = 5
          TabOrder = 0
          OnClick = btRetornaClick
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
          Layout = blGlyphLeftAdjusted
        end
        object btContinue: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 390
          Top = 0
          Width = 95
          Height = 28
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alRight
          Caption = 'Continue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2697513
          Font.Height = -13
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
            89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
            A9000000097048597300000B1300000B1301009A9C18000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000000F54944415478DA62FCFF9F8132F0FF3F03438E4962522ED7A28525
            31DC3CB8D4E0C20CFFFF3330E43E78F43037EFFFFF9C23070F6233049F014C0C
            0C0C0CFF674546FF6FFBFC8971959DDDCFA89DDBCBD478F948F202030303434E
            95B54DCE974F1F73F3FEFFCFDD76E430B22104BD0003B80C21DA005C86906400
            03030343AE8CAD5DEE84CF9F73F3FEFFCF7DB5633BC14044078C97FEFF837332
            1899F0852186644E95B5CD3FB66D5B19EEF1F030781C3DC279252494A858A038
            10298A467C9A0919C0C2C0C0C0C07860D952862FBC7C0C12870FFDFDE2E5DD75
            EBCB179252626E484242EE87C58BB356F1909C991829CDCE80010078BF21266F
            ECE3290000000049454E44AE426082}
          Rounded = True
          Spacing = 7
          TabOrder = 1
          OnClick = btContinueClick
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
          Layout = blGlyphRightAdjusted
        end
      end
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 32
    Top = 24
  end
  object timWaitBusca: TTimer
    Interval = 1500
    OnTimer = timWaitBuscaTimer
    Left = 32
    Top = 104
  end
end
