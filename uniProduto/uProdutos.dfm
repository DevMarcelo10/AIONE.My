object FrmProdutos: TFrmProdutos
  AlignWithMargins = True
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  Align = alClient
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'Produtos'
  ClientHeight = 544
  ClientWidth = 917
  Color = 4144959
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 14
  object PanelAbre: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 917
    Height = 544
    Cursor = crDefault
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Caption.HTMLFont.Charset = DEFAULT_CHARSET
    Caption.HTMLFont.Color = clWindowText
    Caption.HTMLFont.Height = -12
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
    Fill.Color = 15787752
    Fill.ColorTo = 11060456
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtSolid
    Fill.BorderColor = clWhite
    Fill.BorderWidth = 0
    Fill.Rounding = 12
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Version = '1.7.1.6'
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 5
    ExplicitTop = 6
    ExplicitWidth = 916
    ExplicitHeight = 483
    TMSStyle = 0
    object PanelBusca: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 147
      Top = 190
      Width = 622
      Height = 162
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
      Caption.ColorStart = 4474440
      Caption.ColorEnd = 4474440
      Caption.LineColor = 12895944
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
      Version = '1.7.1.6'
      TabOrder = 0
      TabStop = True
      DesignSize = (
        622
        162)
      TMSStyle = 0
      object lbAjuda: TLMDLabel
        Left = 20
        Top = 72
        Width = 582
        Height = 76
        Alignment = agTopCenter
        AutoSize = False
        Color = 9600370
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 19948
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        MultiLine = True
        Options = []
        ParentColor = False
        ParentFont = False
        Anchors = [akLeft, akTop, akBottom]
        Caption = 'Entre com descri'#231#227'o, c'#243'digo interno ou c'#243'digo de barras'
      end
      object AdvSmoothPanel2: TAdvSmoothPanel
        AlignWithMargins = True
        Left = 622
        Top = 0
        Width = 0
        Height = 162
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
        TabOrder = 1
        TMSStyle = 0
      end
      object edBusca: TLMDLabeledEdit
        Left = 20
        Top = 42
        Width = 582
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
        TabOrder = 0
        Transparent = True
        OnKeyDown = edBuscaKeyDown
        OnKeyUp = edBuscaKeyUp
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
        EditLabel.Width = 57
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = 16582
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'PRODUTO'
      end
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 32
    Top = 16
  end
  object timWaitBusca: TTimer
    Interval = 1500
    OnTimer = timWaitBuscaTimer
    Left = 32
    Top = 80
  end
end
