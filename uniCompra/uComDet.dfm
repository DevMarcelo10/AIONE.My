object FrmComDet: TFrmComDet
  Left = 1
  Top = 291
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'COMPRAS - Detalhes das Compras'
  ClientHeight = 512
  ClientWidth = 1090
  Color = 15263976
  TransparentColor = True
  TransparentColorValue = 15263976
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object PanelGrid: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1090
    Height = 512
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
    Caption.TextWordWrapping = False
    Fill.Color = 14085118
    Fill.ColorTo = clNone
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = 33497
    Fill.Rounding = 8
    Fill.ShadowColor = clNone
    Fill.ShadowOffset = 7
    Fill.ShadowType = stSurround
    Fill.Glow = gmNone
    Fill.GlowGradientColor = clNone
    Fill.GlowRadialColor = clNone
    Version = '1.7.1.6'
    TabOrder = 0
    TMSStyle = 0
    object PanelGrids: TLMDSimplePanel
      AlignWithMargins = True
      Left = 12
      Top = 74
      Width = 1066
      Height = 418
      Margins.Left = 12
      Margins.Top = 5
      Margins.Right = 12
      Align = alClient
      Color = clWhite
      TabOrder = 0
      object DBGrid1: TDBGrid
        Tag = 1
        AlignWithMargins = True
        Left = 1
        Top = 8
        Width = 1064
        Height = 409
        Hint = 'Agrupar por mol'#233'cula / subst'#226'ncia'
        Margins.Left = 1
        Margins.Top = 8
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DrawingStyle = gdsGradient
        FixedColor = 16447736
        GradientEndColor = 14019327
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [dgTitles, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = 5131854
        TitleFont.Height = -15
        TitleFont.Name = 'Roboto'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IDProd'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'C'#211'DIGO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 74
            Visible = True
          end
          item
            Expanded = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'C'#211'D.BARRAS'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Despro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 390
            Visible = True
          end
          item
            Expanded = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'GRUPO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 119
            Visible = True
          end
          item
            Expanded = False
            Title.Alignment = taCenter
            Title.Caption = 'FABRICANTE'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 136
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Qtdest'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'ESTOQUE'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 56
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'QtddemIA'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'DEM.IA'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 53
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Qtdped'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Title.Alignment = taCenter
            Title.Caption = 'QTD.PED'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Vlrult'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'PR.COMPRA'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -11
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 73
            Visible = True
          end>
      end
    end
    object LMDSimplePanel1: TLMDSimplePanel
      AlignWithMargins = True
      Left = 12
      Top = 42
      Width = 1066
      Height = 27
      Margins.Left = 12
      Margins.Top = 9
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alTop
      Color = 14085118
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      object edBusFor: TAdvEditBtn
        AlignWithMargins = True
        Left = 227
        Top = 2
        Width = 326
        Height = 21
        Margins.Left = 10
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 4
        BorderColor = 9685503
        EmptyText = 'Fornecedor ou todos...'
        EmptyTextStyle = []
        FlatLineColor = 11250603
        FocusColor = clWhite
        FocusFontColor = 3881787
        SoftBorder = True
        ReturnIsTab = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -13
        LabelFont.Name = 'Segoe UI'
        LabelFont.Style = []
        Lookup.Font.Charset = DEFAULT_CHARSET
        Lookup.Font.Color = 4276545
        Lookup.Font.Height = -11
        Lookup.Font.Name = 'Segoe UI'
        Lookup.Font.Style = []
        Lookup.Separator = ';'
        Align = alLeft
        AutoSelect = False
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        ShortCut = 0
        TabOrder = 1
        Text = ''
        Visible = True
        OnKeyDown = edBusForKeyDown
        Version = '1.7.1.3'
        ButtonStyle = bsButton
        ButtonWidth = 20
        ButtonTransparent = True
        Flat = False
        Etched = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFF4F4F4
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE3E3E3707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD9D9D9D
          707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D707070B9B9B9FFFFFFFFFFFFFF
          FFFFF7F7F7ECECECF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFC9D9D9D707070BABABAD2D2D28E8E8E707070707070727272949494DBDB
          DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D70707070707081
          8181B2B2B2C1C1C1AEAEAE7B7B7B717171C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC9C9C9707070A4A4A4FBFBFBFFFFFFFFFFFFFFFFFFF6F6F69595
          95717171DADADAFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE838383898989FCFCFCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F57B7B7B929292FFFFFFFFFFFFFFFFFF
          FFFFFFEFEFEF707070C2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFABABAB717171F8F8F8FFFFFFFFFFFFFFFFFFDCDCDC707070D5D5D5FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF707070EAEAEAFFFFFFFFFFFF
          FFFFFFECECEC707070C6C6C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFAFAFAF717171F5F5F5FFFFFFFFFFFFFFFFFFFEFEFE7D7D7D919191FEFEFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFA7F7F7F8D8D8DFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC1C1C1707070B0B0B0FEFEFEFFFFFFFFFFFFFFFFFFFBFBFBA0A0
          A0707070D2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA2A2A27070708E
          8E8EC3C3C3CFCFCFBEBEBE868686707070B1B1B1FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEC0C0C07C7C7C707070707070707070828282CACA
          CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
          FDFDE3E3E3D9D9D9E7E7E7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF}
        ReadOnly = False
        OnClickBtn = edBusForClickBtn
        ButtonColor = clWhite
        ButtonColorHot = 15917525
        ButtonColorDown = 14925219
        ButtonTextColor = 4474440
        ButtonTextColorHot = 2303013
        ButtonTextColorDown = 2303013
      end
      object edBusFilial: TAdvEditBtn
        AlignWithMargins = True
        Left = 1
        Top = 2
        Width = 216
        Height = 21
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 4
        BorderColor = 9685503
        EmptyText = 'Filial ou todas'
        EmptyTextStyle = []
        FlatLineColor = 11250603
        FocusColor = clWhite
        FocusFontColor = 3881787
        SoftBorder = True
        ReturnIsTab = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -13
        LabelFont.Name = 'Segoe UI'
        LabelFont.Style = []
        Lookup.Font.Charset = DEFAULT_CHARSET
        Lookup.Font.Color = 4276545
        Lookup.Font.Height = -11
        Lookup.Font.Name = 'Segoe UI'
        Lookup.Font.Style = []
        Lookup.Separator = ';'
        Align = alLeft
        AutoSelect = False
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        ShortCut = 0
        TabOrder = 0
        Text = ''
        Visible = True
        OnKeyDown = edBusFilialKeyDown
        Version = '1.7.1.3'
        ButtonStyle = bsButton
        ButtonWidth = 20
        ButtonTransparent = True
        Flat = False
        Etched = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFF4F4F4
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE3E3E3707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD9D9D9D
          707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D707070B9B9B9FFFFFFFFFFFFFF
          FFFFF7F7F7ECECECF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFC9D9D9D707070BABABAD2D2D28E8E8E707070707070727272949494DBDB
          DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D70707070707081
          8181B2B2B2C1C1C1AEAEAE7B7B7B717171C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC9C9C9707070A4A4A4FBFBFBFFFFFFFFFFFFFFFFFFF6F6F69595
          95717171DADADAFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE838383898989FCFCFCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F57B7B7B929292FFFFFFFFFFFFFFFFFF
          FFFFFFEFEFEF707070C2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFABABAB717171F8F8F8FFFFFFFFFFFFFFFFFFDCDCDC707070D5D5D5FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF707070EAEAEAFFFFFFFFFFFF
          FFFFFFECECEC707070C6C6C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFAFAFAF717171F5F5F5FFFFFFFFFFFFFFFFFFFEFEFE7D7D7D919191FEFEFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFA7F7F7F8D8D8DFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC1C1C1707070B0B0B0FEFEFEFFFFFFFFFFFFFFFFFFFBFBFBA0A0
          A0707070D2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA2A2A27070708E
          8E8EC3C3C3CFCFCFBEBEBE868686707070B1B1B1FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEC0C0C07C7C7C707070707070707070828282CACA
          CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
          FDFDE3E3E3D9D9D9E7E7E7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF}
        ReadOnly = False
        OnClickBtn = edBusFilialClickBtn
        ButtonColor = clWhite
        ButtonColorHot = 15917525
        ButtonColorDown = 14925219
        ButtonTextColor = 4474440
        ButtonTextColorHot = 2303013
        ButtonTextColorDown = 2303013
      end
      object edSubGru: TAdvEditBtn
        AlignWithMargins = True
        Left = 773
        Top = 2
        Width = 200
        Height = 21
        Margins.Left = 10
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 4
        BorderColor = 9685503
        EmptyText = 'Sub-Grupo ou todos...'
        EmptyTextStyle = []
        FlatLineColor = 11250603
        FocusColor = clWhite
        FocusFontColor = 3881787
        SoftBorder = True
        ReturnIsTab = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -13
        LabelFont.Name = 'Segoe UI'
        LabelFont.Style = []
        Lookup.Font.Charset = DEFAULT_CHARSET
        Lookup.Font.Color = 4276545
        Lookup.Font.Height = -11
        Lookup.Font.Name = 'Segoe UI'
        Lookup.Font.Style = []
        Lookup.Separator = ';'
        Align = alLeft
        AutoSelect = False
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        ShortCut = 0
        TabOrder = 3
        Text = ''
        Visible = True
        OnKeyDown = edSubGruKeyDown
        Version = '1.7.1.3'
        ButtonStyle = bsButton
        ButtonWidth = 20
        ButtonTransparent = True
        Flat = False
        Etched = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFF4F4F4
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE3E3E3707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD9D9D9D
          707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D707070B9B9B9FFFFFFFFFFFFFF
          FFFFF7F7F7ECECECF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFC9D9D9D707070BABABAD2D2D28E8E8E707070707070727272949494DBDB
          DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D70707070707081
          8181B2B2B2C1C1C1AEAEAE7B7B7B717171C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC9C9C9707070A4A4A4FBFBFBFFFFFFFFFFFFFFFFFFF6F6F69595
          95717171DADADAFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE838383898989FCFCFCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F57B7B7B929292FFFFFFFFFFFFFFFFFF
          FFFFFFEFEFEF707070C2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFABABAB717171F8F8F8FFFFFFFFFFFFFFFFFFDCDCDC707070D5D5D5FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF707070EAEAEAFFFFFFFFFFFF
          FFFFFFECECEC707070C6C6C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFAFAFAF717171F5F5F5FFFFFFFFFFFFFFFFFFFEFEFE7D7D7D919191FEFEFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFA7F7F7F8D8D8DFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC1C1C1707070B0B0B0FEFEFEFFFFFFFFFFFFFFFFFFFBFBFBA0A0
          A0707070D2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA2A2A27070708E
          8E8EC3C3C3CFCFCFBEBEBE868686707070B1B1B1FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEC0C0C07C7C7C707070707070707070828282CACA
          CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
          FDFDE3E3E3D9D9D9E7E7E7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF}
        ReadOnly = False
        OnClickBtn = edSubGruClickBtn
        ButtonColor = clWhite
        ButtonColorHot = 15917525
        ButtonColorDown = 14925219
        ButtonTextColor = 4474440
        ButtonTextColorHot = 2303013
        ButtonTextColorDown = 2303013
      end
      object edGrupo: TAdvEditBtn
        AlignWithMargins = True
        Left = 563
        Top = 2
        Width = 200
        Height = 21
        Margins.Left = 10
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 4
        BorderColor = 9685503
        EmptyText = 'Grupo ou todos...'
        EmptyTextStyle = []
        FlatLineColor = 11250603
        FocusColor = clWhite
        FocusFontColor = 3881787
        SoftBorder = True
        ReturnIsTab = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -13
        LabelFont.Name = 'Segoe UI'
        LabelFont.Style = []
        Lookup.Font.Charset = DEFAULT_CHARSET
        Lookup.Font.Color = 4276545
        Lookup.Font.Height = -11
        Lookup.Font.Name = 'Segoe UI'
        Lookup.Font.Style = []
        Lookup.Separator = ';'
        Align = alLeft
        AutoSelect = False
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        ShortCut = 0
        TabOrder = 2
        Text = ''
        Visible = True
        OnKeyDown = edGrupoKeyDown
        Version = '1.7.1.3'
        ButtonStyle = bsButton
        ButtonWidth = 20
        ButtonTransparent = True
        Flat = False
        Etched = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFF4F4F4
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE3E3E3707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD9D9D9D
          707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D707070B9B9B9FFFFFFFFFFFFFF
          FFFFF7F7F7ECECECF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFC9D9D9D707070BABABAD2D2D28E8E8E707070707070727272949494DBDB
          DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D70707070707081
          8181B2B2B2C1C1C1AEAEAE7B7B7B717171C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC9C9C9707070A4A4A4FBFBFBFFFFFFFFFFFFFFFFFFF6F6F69595
          95717171DADADAFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE838383898989FCFCFCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F57B7B7B929292FFFFFFFFFFFFFFFFFF
          FFFFFFEFEFEF707070C2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFABABAB717171F8F8F8FFFFFFFFFFFFFFFFFFDCDCDC707070D5D5D5FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF707070EAEAEAFFFFFFFFFFFF
          FFFFFFECECEC707070C6C6C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFAFAFAF717171F5F5F5FFFFFFFFFFFFFFFFFFFEFEFE7D7D7D919191FEFEFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFA7F7F7F8D8D8DFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC1C1C1707070B0B0B0FEFEFEFFFFFFFFFFFFFFFFFFFBFBFBA0A0
          A0707070D2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA2A2A27070708E
          8E8EC3C3C3CFCFCFBEBEBE868686707070B1B1B1FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEC0C0C07C7C7C707070707070707070828282CACA
          CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
          FDFDE3E3E3D9D9D9E7E7E7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF}
        ReadOnly = False
        OnClickBtn = edGrupoClickBtn
        ButtonColor = clWhite
        ButtonColorHot = 15917525
        ButtonColorDown = 14925219
        ButtonTextColor = 4474440
        ButtonTextColorHot = 2303013
        ButtonTextColorDown = 2303013
      end
      object btAddItem: TAdvGlowButton
        AlignWithMargins = True
        Left = 979
        Top = 2
        Width = 86
        Height = 23
        Cursor = crHandPoint
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alRight
        AntiAlias = aaAntiAlias
        BorderStyle = bsNone
        Caption = 'Mostrar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 6
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000473424954080808087C086488000000097048597300000EC400000E
          C401952B0E1B0000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A0000020249444154388D7593CF4B54511CC53FDFA7
          CEDCA732FE0351440BA132689F1041BAA8554522056985D6C6453F0CDCB89216
          2684A1A011F32666358BDA2461A42DFA0B5AD4C2A022DA168CC2BC7933CC3B2D
          5E8EF346BBDB7BCEE79EEFB9F71A6D4BF9CC00D631013A071C011AC04FA47748
          2FEC66ED4BABDEF68C38F01730DD01224C6F89ED2B461DEC346810E8C16C996A
          78DF26A937012AE153716BC059D03C9DD19C5D673B95AC488E7A7616B329E003
          51F5C22E0405FEB20217ABE05F691A846985AE7D2306FEA802D750DE7F0A607A
          993949EC7DC2B46037A2E916E133880FD11D8DD8556A2948C13D463C40F18047
          DC3109D4A846736D877D04BB48E85E6B916C6AA79E990742CC6E7949DB5AB349
          CAA976C7C212D835C4107DEE552BC46E6FFF016D8037E4014731BEB5CFDA8418
          E38861FADCF3B6ED2D880F77264359741020DD1E6AC3D7804E0FF89EDCF3019E
          823F82C863ACB35D9D48FBE9077E78609BA04115C9ED37AB08B64EB97AC9A668
          A654895EC430B20D0FAFB102F452CFCEB6453E037A4377983203507133400F6A
          AC26DABCBFA4C0D515F8A34DFFFF1FD26505AEA182BF089094B813DE23E7FA41
          4515DC29E87A62B6F31BFE3DD5DDD81537037A046C520E1F2655EC0A16C992F3
          174077810AE83DB0855984741CEC3CD08BD91271386DE3545380BD889913D0FC
          CEC74011D8AFA4ECC6AA8DD53EB7EAFF02E0E4DAD2DF1AA4F80000000049454E
          44AE426082}
        Rounded = True
        Spacing = 3
        TabOrder = 4
        Appearance.BorderColor = 13625854
        Appearance.BorderColorHot = 10474237
        Appearance.BorderColorCheckedHot = 10868478
        Appearance.BorderColorDown = 8701949
        Appearance.BorderColorChecked = 9095677
        Appearance.BorderColorDisabled = 9095677
        Appearance.BorderColorFocused = 3383547
        Appearance.Color = 13625854
        Appearance.ColorTo = 13625854
        Appearance.ColorChecked = clNone
        Appearance.ColorCheckedTo = clNone
        Appearance.ColorDisabled = clNone
        Appearance.ColorDisabledTo = clNone
        Appearance.ColorDown = 8701949
        Appearance.ColorDownTo = 8701949
        Appearance.ColorHot = 10474237
        Appearance.ColorHotTo = 10474237
        Appearance.ColorMirror = 13625854
        Appearance.ColorMirrorTo = 13625854
        Appearance.ColorMirrorHot = 10474237
        Appearance.ColorMirrorHotTo = 10474237
        Appearance.ColorMirrorDown = 8701949
        Appearance.ColorMirrorDownTo = 8701949
        Appearance.ColorMirrorChecked = clNone
        Appearance.ColorMirrorCheckedTo = clNone
        Appearance.ColorMirrorDisabled = clNone
        Appearance.ColorMirrorDisabledTo = clNone
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 12577023
        Appearance.TextColorDown = 23470
        Appearance.TextColorHot = 23470
        Appearance.TextColorDisabled = 12577023
        Layout = blGlyphRightAdjusted
      end
    end
    object LMDSimplePanel2: TLMDSimplePanel
      AlignWithMargins = True
      Left = 12
      Top = 495
      Width = 1066
      Height = 14
      Margins.Left = 12
      Margins.Top = 0
      Margins.Right = 12
      Align = alBottom
      Color = 14085118
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      object LMDLabel1: TLMDLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 1063
        Height = 14
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Alignment = agCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7237230
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Clicando na DESCRI'#199#195'O, detalhar'#225' por Filial'
        ExplicitTop = -3
      end
    end
    object LMDSimplePanel3: TLMDSimplePanel
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 1070
      Height = 25
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alTop
      Color = 14085118
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 0
        Top = 3
        Width = 14
        Height = 22
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
          610000000473424954080808087C086488000000097048597300000EC400000E
          C401952B0E1B0000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000000B949444154388D9593BB0DC2301040DF6584
          889E8A111880555820B62890A829228464C4002C96060ABA840590381A1786FC
          CEEEECF37B3EF9EEC0B85A4FDD39EE6DC53A3D2F2C70E708A2EC8125B0CD12B4
          9E1A7071DB50704CE33207C797011A15368BC0D324B0C0A3022B3C28C8817B82
          CEB343395B61F8AF82FE0855DFE814DCCB40415E8E0054D62C7A7F902B19AC42
          8E64B40FAC92C94EB44826674140CB0B1EE11A8F567C38A47766874940CB8053
          38010F556E69FC0BCBF463B37B0FA6D80000000049454E44AE426082}
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
          610000000473424954080808087C086488000000097048597300000EC400000E
          C401952B0E1B0000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000000DC49444154388D95D1B16A02411080E17FE7
          9AA4536C851CDC43689B62AE4BBA40EA3C816021E9535808BE89A590E2AEB5F0
          11E4F6AAE003A4BEDB340A4BD4736EBBD9E1FF585887F1A8EA12786FDBF6AD28
          8AFDF95E2C719EE76B60013C89C847BCBB0BA8EA3284303B8D87A669BEE2BD33
          3C7B11C5CF6559FE98004B7C13B0C657813EF105A0AA7360658DE1DF2F841062
          30244912BA6280241EBCF7BB2CCB06C0141801AF699A6EEABAFE350127E43B46
          44E4A50BB900FA2257813EC84DC08A740211320426C0C839F7E0BDDF9A810879
          04C622F25955D5F1BCFB03E2108221A89BAA120000000049454E44AE426082}
        Rounded = True
        Spacing = 3
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = btFecharClick
        Appearance.BorderColor = 14085118
        Appearance.BorderColorHot = 14085118
        Appearance.BorderColorCheckedHot = 14085118
        Appearance.BorderColorDown = 14085118
        Appearance.BorderColorChecked = 14085118
        Appearance.BorderColorDisabled = 14085118
        Appearance.BorderColorFocused = 14085118
        Appearance.Color = 14085118
        Appearance.ColorTo = 14085118
        Appearance.ColorChecked = 14085118
        Appearance.ColorCheckedTo = 14085118
        Appearance.ColorDisabled = 14085118
        Appearance.ColorDisabledTo = 14085118
        Appearance.ColorDown = 14085118
        Appearance.ColorDownTo = 14085118
        Appearance.ColorHot = 14085118
        Appearance.ColorHotTo = 14085118
        Appearance.ColorMirror = 14085118
        Appearance.ColorMirrorTo = 14085118
        Appearance.ColorMirrorHot = 14085118
        Appearance.ColorMirrorHotTo = 14085118
        Appearance.ColorMirrorDown = 14085118
        Appearance.ColorMirrorDownTo = 14085118
        Appearance.ColorMirrorChecked = 14085118
        Appearance.ColorMirrorCheckedTo = 14085118
        Appearance.ColorMirrorDisabled = 14085118
        Appearance.ColorMirrorDisabledTo = 14085118
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
      object edBusca: TAdvEditBtn
        Left = 361
        Top = 3
        Width = 344
        Height = 22
        BorderColor = 11589887
        EmptyText = 'Procurar...'
        EmptyTextStyle = []
        FlatLineColor = 11250603
        FocusColor = clWindow
        FocusFontColor = 3881787
        SoftBorder = True
        ReturnIsTab = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -13
        LabelFont.Name = 'Segoe UI'
        LabelFont.Style = []
        Lookup.Font.Charset = DEFAULT_CHARSET
        Lookup.Font.Color = 4276545
        Lookup.Font.Height = -11
        Lookup.Font.Name = 'Segoe UI'
        Lookup.Font.Style = []
        Lookup.Separator = ';'
        AutoSelect = False
        AutoSize = False
        Color = 12378110
        Ctl3D = False
        ParentCtl3D = False
        ShortCut = 0
        TabOrder = 1
        Text = ''
        Visible = True
        Version = '1.7.1.3'
        ButtonStyle = bsButton
        ButtonWidth = 0
        ButtonTransparent = True
        Flat = False
        Etched = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFF4F4F4
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE3E3E3707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD9D9D9D
          707070B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D707070B9B9B9FFFFFFFFFFFFFF
          FFFFF7F7F7ECECECF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFC9D9D9D707070BABABAD2D2D28E8E8E707070707070727272949494DBDB
          DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC9D9D9D70707070707081
          8181B2B2B2C1C1C1AEAEAE7B7B7B717171C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC9C9C9707070A4A4A4FBFBFBFFFFFFFFFFFFFFFFFFF6F6F69595
          95717171DADADAFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE838383898989FCFCFCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F57B7B7B929292FFFFFFFFFFFFFFFFFF
          FFFFFFEFEFEF707070C2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFABABAB717171F8F8F8FFFFFFFFFFFFFFFFFFDCDCDC707070D5D5D5FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF707070EAEAEAFFFFFFFFFFFF
          FFFFFFECECEC707070C6C6C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFAFAFAF717171F5F5F5FFFFFFFFFFFFFFFFFFFEFEFE7D7D7D919191FEFEFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFA7F7F7F8D8D8DFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC1C1C1707070B0B0B0FEFEFEFFFFFFFFFFFFFFFFFFFBFBFBA0A0
          A0707070D2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA2A2A27070708E
          8E8EC3C3C3CFCFCFBEBEBE868686707070B1B1B1FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFEFEC0C0C07C7C7C707070707070707070828282CACA
          CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
          FDFDE3E3E3D9D9D9E7E7E7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF}
        ReadOnly = False
        ButtonColor = clWhite
        ButtonColorHot = 15917525
        ButtonColorDown = 14925219
        ButtonTextColor = 4474440
        ButtonTextColorHot = 2303013
        ButtonTextColorDown = 2303013
      end
      object btAnaIA: TAdvGlowButton
        AlignWithMargins = True
        Left = 1042
        Top = 0
        Width = 28
        Height = 25
        Cursor = crHandPoint
        Hint = 'An'#225'lise IA'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        AntiAlias = aaAntiAlias
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 34043
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 0
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D494844520000001C000000130806000000835B6D
          41000000097048597300000B1300000B1301009A9C18000000206348524D0000
          7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
          C5460000025F4944415478DAB495BF4B1B6118C7DF415A07A7EAE83F901F7751
          5B4B8A5B4C4C0B4ED2BAB450170503C95D8A935D32B948BDCBDB043298500597
          0E4D4031D0BC17716A972E4E1D2AD150421A422004CE1E04BF1D42DE4B34C6C4
          D817BE703CCF7D9FCFFB3EBC3F08E973E43E3A46ABAA2D5F556DF95365EA11F9
          DF0300C97D9830725B8EBF004827DDFB282BF64859B147EE772569FF0858E005
          3469E5AA2A7B0B4795BD85A34E3930F939D2FE91FE602C300D269F4393712731
          F91C99E093DE60D9F70FC1E4D33BC33854FA85B4FF410FC0A073601857F0690F
          ED0CBEE286E46B20360D44C4DE149B06926F4C60467AD919B2313E0C6A5903B5
          A4B0E33D691A8CE8240C6A6D28F6CCFCBEAAD65C74D204EE784F402D2950CB1A
          36C6871BB05DE79041ADC7756A459D5A514FB8B841A736E8D40623E9037E7E81
          91F2F158B75CD35F4FB8D0AC6B50EB31769D43A416B678DB0A2466B9A11AB6A3
          1AB6C360210020060BF158B71CEF5062B66D72356AF3908A2A2CB616D0136E6E
          28AB02CAAA003DD328AA67423CD62DC73B9470B74DAEA20A8BE46C531C2BAB42
          A9F973356E024BAA88922AA276B80E00A476B8CE63DD72BC4371B7393945F873
          B6298E1142082928C2E392227E2FAA42BD1AF77043213C818222A2189D41E5F3
          0A8A91191414B14DD772E1C916A0074555A89714F1DB6F2A4E75D8ADCE611CAC
          2EF196EECC23BFE5E84BE54FF3E62E3D585DBAF54247569E6B3DBCFAFE326AC9
          B73D49DF5F6E3FF85979EE76E0D777A360F2C5E0579B7CD1F393052D1800932E
          07B8472FA105037DBD9160B20B9AB40D26653A2A13D090F6FDB8264DDA06935D
          37C1FE0D00098A39D85E891EB90000000049454E44AE426082}
        Rounded = True
        Spacing = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Appearance.BorderColor = 15267071
        Appearance.BorderColorHot = 10474237
        Appearance.BorderColorCheckedHot = 10474237
        Appearance.BorderColorDown = 10474237
        Appearance.BorderColorChecked = 10474237
        Appearance.BorderColorDisabled = 10474237
        Appearance.BorderColorFocused = 3383547
        Appearance.Color = 14085118
        Appearance.ColorTo = 14085118
        Appearance.ColorChecked = 10474237
        Appearance.ColorCheckedTo = 10474237
        Appearance.ColorDisabled = 10474237
        Appearance.ColorDisabledTo = 10474237
        Appearance.ColorDown = 15267071
        Appearance.ColorDownTo = 15267071
        Appearance.ColorHot = 13100798
        Appearance.ColorHotTo = 13100798
        Appearance.ColorMirror = 14085118
        Appearance.ColorMirrorTo = 14085118
        Appearance.ColorMirrorHot = 14085118
        Appearance.ColorMirrorHotTo = 13100798
        Appearance.ColorMirrorDown = 15267071
        Appearance.ColorMirrorDownTo = 15267071
        Appearance.ColorMirrorChecked = 10474237
        Appearance.ColorMirrorCheckedTo = 10474237
        Appearance.ColorMirrorDisabled = 10474237
        Appearance.ColorMirrorDisabledTo = 10474237
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 12577023
        Appearance.TextColorDown = 26822
        Appearance.TextColorHot = 30433
        Appearance.TextColorDisabled = 12577023
        Layout = blGlyphTop
      end
      object btAgruSubs: TAdvGlowButton
        AlignWithMargins = True
        Left = 1006
        Top = 0
        Width = 28
        Height = 25
        Cursor = crHandPoint
        Hint = 'Agrupar por mol'#233'cula / subst'#226'ncia'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 8
        Margins.Bottom = 0
        Align = alRight
        AntiAlias = aaAntiAlias
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 34043
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 0
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000473424954080808087C086488000000097048597300000EC400000E
          C401952B0E1B0000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A00000257494441544889EDD24F88956514C7F1CF79
          E7360E09173245889171515654186256304A83911484B5AD45F307A14809C4D5
          D862360A4E05098289CEBD25E64211A23642AD0B12C486627240029D2432501C
          88BCCEDCD3E25E87EBA8E3355AFA5B3DEF39CFF3FB9E73DEC37DDD45F17F98E4
          9817857EA92C4C0AFB63C01F37017244A1C753EA6A31E46CDBE6155BB117454B
          F8A2C286E877AE6856F0B81526A471E1D71CF35D1E516EC37C193EC235E93D75
          CF0B9FE311B30E4049A38FA35885EF511636AAF9045B162484D7A52E7C1C433E
          834CA7546D10FAF280A5451EB41C6BF08BF3D62B7901FFE0D53626D4D568C5D5
          3966484CA350E82A29FC8D6B58A6C72A33BAD189CB77B5AF1B1708EF67D54935
          67747A575A8D9F638BA9520C99CE8A83D82A4DB43C3FBE90778E592D1C697E2E
          977EF40012D4F001CD2DCA633A4CDB2EBC8519ACC545E984F052B3A30BD2972E
          386C8537852FB01847F103FAB11467845D31E0D41CE096EA2A4E62534B68161D
          CDF3049E400AC3FA8D36E77E5B15F30359F51CFA9AA6C31659E2BC4EE115691C
          4FE23A36C7803D0B9973634D5B55372C74625B0CDAD792F9362B5EC669742BFC
          B690F16D3BC81125E1355C56F757564CE6218FDEC8C7A04BA8342EDF34C2F600
          BA95357EE89F0ACFE231A177DE9BDF41DDC3F70E98720557D1A3F053A36C9F66
          D51B7377D2D3CDF8D43D0362441D5FA1CBAC5E8CE2416C86AC7A461844CDAC6F
          DA01DCB2A659B5523A8D87F0B5744CE19CD4871D5822EC8C01BBFF1300F29075
          0A27D03D2F751DA331E8C376CCEF08803C6CB1196F4BBD42196775188B774CB6
          6B7E5F6DE95F197FB45D58055E1E0000000049454E44AE426082}
        Rounded = True
        Spacing = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Appearance.BorderColor = 15267071
        Appearance.BorderColorHot = 10474237
        Appearance.BorderColorCheckedHot = 10474237
        Appearance.BorderColorDown = 10474237
        Appearance.BorderColorChecked = 10474237
        Appearance.BorderColorDisabled = 10474237
        Appearance.BorderColorFocused = 3383547
        Appearance.Color = 14085118
        Appearance.ColorTo = 14085118
        Appearance.ColorChecked = 10474237
        Appearance.ColorCheckedTo = 10474237
        Appearance.ColorDisabled = 10474237
        Appearance.ColorDisabledTo = 10474237
        Appearance.ColorDown = 15267071
        Appearance.ColorDownTo = 15267071
        Appearance.ColorHot = 13100798
        Appearance.ColorHotTo = 13100798
        Appearance.ColorMirror = 14085118
        Appearance.ColorMirrorTo = 14085118
        Appearance.ColorMirrorHot = 14085118
        Appearance.ColorMirrorHotTo = 13100798
        Appearance.ColorMirrorDown = 15267071
        Appearance.ColorMirrorDownTo = 15267071
        Appearance.ColorMirrorChecked = 10474237
        Appearance.ColorMirrorCheckedTo = 10474237
        Appearance.ColorMirrorDisabled = 10474237
        Appearance.ColorMirrorDisabledTo = 10474237
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 12577023
        Appearance.TextColorDown = 26822
        Appearance.TextColorHot = 30433
        Appearance.TextColorDisabled = 12577023
      end
    end
  end
end
