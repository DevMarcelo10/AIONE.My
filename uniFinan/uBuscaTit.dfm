object FrmBusTit: TFrmBusTit
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Busca T'#237'tulos'
  ClientHeight = 443
  ClientWidth = 1062
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
    Left = 1
    Top = 0
    Width = 1060
    Height = 443
    Margins.Left = 1
    Margins.Top = 0
    Margins.Right = 1
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 14671839
    Bevel.BorderWidth = 1
    Bevel.EdgeStyle = etRaised
    Color = clWhite
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Roboto'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object PanelFiltros: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 27
      Width = 1056
      Height = 126
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14671839
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15923199
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2894892
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object LMDLabel4: TLMDLabel
        Left = 23
        Top = 11
        Width = 47
        Height = 16
        Alignment = agCenterRight
        Color = 15461355
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'PESSOA'
      end
      object LMDLabel2: TLMDLabel
        Left = 31
        Top = 69
        Width = 39
        Height = 16
        Alignment = agBottomRight
        Color = 15461355
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'FILIAL'
      end
      object LMDLabel3: TLMDLabel
        Left = 843
        Top = 15
        Width = 53
        Height = 16
        Alignment = agBottomRight
        Color = 15461355
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'PER'#205'ODO'
      end
      object LMDLabel5: TLMDLabel
        Left = 940
        Top = 38
        Width = 10
        Height = 16
        Alignment = agBottomRight
        Color = 15461355
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = #192
      end
      object LMDLabel6: TLMDLabel
        Left = 319
        Top = 100
        Width = 57
        Height = 16
        Alignment = agBottomRight
        Color = 15461355
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'NOTA FIS.'
      end
      object LMDLabel7: TLMDLabel
        Left = 7
        Top = 100
        Width = 63
        Height = 16
        Alignment = agBottomRight
        Color = 15461355
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'NATUREZA'
      end
      object LMDLabel8: TLMDLabel
        Left = 9
        Top = 40
        Width = 61
        Height = 16
        Alignment = agBottomRight
        Color = 15461355
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'CONV'#202'NIO'
      end
      object edFilial: TLMDLabeledEdit
        Left = 75
        Top = 66
        Width = 367
        Height = 24
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14540253
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 2
        OnKeyDown = edFilialKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <
          item
            Color = clWhite
            Cursor = crHandPoint
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D494844520000001200000014080600000080976D
              4A000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC300000EC301C76FA864000001C44944415478DAD592BD
              CB816114C6AF6751468324B37C44A48430B029038A0C2CFE006236C83FC0C840
              210C762329313019503E2265A0641386F77DEF3328799EB7F76B79CF76779FF3
              3BE75CE7E2DE3E027F10DCFF02CD6633E4723974BB5D5CAF57701C07B7DB8D44
              2201A3D1F835102B0E068390C96454ACD3E930994C301C0EB15C2E51A954E0F7
              FB3F076D361B58AD562A6E369B904AA58F3F3659281442A7D341BFDF87C16010
              06259349D46A352C160B48249297692F970B012C160BE5F1824EA7136C361BEC
              763BCAE5B2A0B8A9540AAD560BBBDD8E1FB4DD6EA1D7EB91C9642859288AC522
              D2E9348EC7233FE876BBC1E17040A954A25EAF0B82E2F138DAED36092FA8513E
              9F47369BC56030805AAD7E819CCF67984C26B85C2E944A256110EB140E874927
              0655A9548FBFF57A4DC7604D7ABD1EB45A2D3F68341A21128960BFDFD35B2C16
              231008D0AAABD58AAEC42EC934F2783CFC3E1A8FC7E4112620F34EA150C0743A
              45A3D1C07C3E8742A180D7EB452C168346A379DAE20162A346A3511C0E077233
              33A2D96CA6A4FBFD4E676693F0F9EA09C40CC6F697CBE5A856ABE4ECEFC403E4
              F3F9A82B13D7E9747E0B2278B59FC4138899512412FD1EF49B7807C22803D414
              9A2D2C0000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edFilialCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 47
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object LMDSimplePanel2: TLMDSimplePanel
        Left = 843
        Top = 34
        Width = 94
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14540253
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 6
        object edDatIni: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 86
          Height = 20
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          MinDate = 45292.000000000000000000
          Align = alLeft
          AutoSelect = False
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DefaultToday = True
          DialogTitle = 'Escolha uma data'
          Font.Charset = ANSI_CHARSET
          Font.Color = 3487029
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          GlyphKind = gkCustom
          Glyph.Data = {
            860A0000424D860A000000000000360000002800000028000000160000000100
            180000000000500A0000000000000000000000000000000000000000FF0000FF
            0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
            FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
            00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
            0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0808080808080808080808080
            808080808080808080808080808080C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
            C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
            8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
            C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
            FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFF
            FFC0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
            C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
            8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
            C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
            FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
            C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
            8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C080808080
            8080808080808080808080808080808080808080808080C0C0C0FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
            FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
            00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
            0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
            FF0000FF0000FF0000FF}
          ButtonWidth = 18
          NumGlyphs = 2
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          Text = '13/12/2024'
        end
      end
      object LMDSimplePanel3: TLMDSimplePanel
        Left = 955
        Top = 34
        Width = 94
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14540253
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 7
        object edDatFin: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 86
          Height = 20
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          MinDate = 45292.000000000000000000
          Align = alLeft
          AutoSelect = False
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DefaultToday = True
          DialogTitle = 'Escolha uma data'
          Font.Charset = ANSI_CHARSET
          Font.Color = 3487029
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          GlyphKind = gkCustom
          Glyph.Data = {
            860A0000424D860A000000000000360000002800000028000000160000000100
            180000000000500A0000000000000000000000000000000000000000FF0000FF
            0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
            FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
            00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
            0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0808080808080808080808080
            808080808080808080808080808080C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
            C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
            8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
            C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
            FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFF
            FFC0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
            C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
            8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
            C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
            FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
            C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
            FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
            8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C080808080
            8080808080808080808080808080808080808080808080C0C0C0FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
            FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
            00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
            0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
            FF0000FF0000FF0000FF}
          ButtonWidth = 18
          NumGlyphs = 2
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          Text = '13/12/2024'
        end
      end
      object edNotFis: TLMDEdit
        Left = 382
        Top = 96
        Width = 60
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14540253
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 4
        OnKeyPress = edNotFisKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
      end
      object btBuscar: TAdvGlowButton
        AlignWithMargins = True
        Left = 843
        Top = 85
        Width = 206
        Height = 24
        Cursor = crHandPoint
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Buscar'
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
          F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001D249
          4441544889ED54316B5351183DE7B6491DEC202EE2E096294BD1C5EA9BA46450
          3AE62748458A3858C8BD8F964BE0BD1BD4494594F62774104A514404E1294E25
          4B1607F10F888BD22686FBB9DCA4CFF4A5693B6ACFF69DEFE31CBEEF5C2E708A
          7F1E1C25EAF5FA54A552F92A22AF9C73F701C8A017C7F1868854BDF7375BADD6
          8FA318A851A25AADCE00B844F25E1CC72FADB5C31911A900B8AA947AAFB53E7F
          2203007D00BF83E0ED5EAFF7146153927B61668EE4DB46A371EED806D6DA9E88
          ACE5A8BBC6986700E8BD6F02F819F8CB4AA977934C0E643080D6FA01C947C341
          72BD542ADDE976BBF3245F03980DADB6882C38E7BE17E94C8D33C8B2EC531445
          BF48D60275C57B7FB15C2EBFE8F7FB1F48D601CC00B840B21645D1669665BBA3
          3A45190CE19C7B2C22F1A00E99AC3AE73E8AC82DEC9F6B8EE4160A2E72A8C109
          20A3C4A106C6981592C9A026B99EA669536B7D9DE43680B3A1D51691C5228DB1
          211B6356003CCC8B2749B2A4B5BE769C900B37D05A37F2E2009EE7C4DFE4C477
          BCF737C689171A586BCB249B79F1344D970188526A0DFB67D9F1DE2F4CFA328A
          369806500286375F46084F44CE8499B688D48EF21F1D30E8743A5D00DF44E449
          92244BF8FB657C01F079D2594EF19FE10F2069C2971FD6C43B0000000049454E
          44AE426082}
        Rounded = True
        Spacing = 0
        TabOrder = 8
        OnClick = btBuscarClick
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
      object edPessoa: TLMDLabeledEdit
        Left = 75
        Top = 8
        Width = 367
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14540253
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 0
        OnKeyDown = edPessoaKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <
          item
            Color = clWhite
            Cursor = crHandPoint
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D494844520000001200000014080600000080976D
              4A000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC300000EC301C76FA864000001C44944415478DAD592BD
              CB816114C6AF6751468324B37C44A48430B029038A0C2CFE006236C83FC0C840
              210C762329313019503E2265A0641386F77DEF3328799EB7F76B79CF76779FF3
              3BE75CE7E2DE3E027F10DCFF02CD6633E4723974BB5D5CAF57701C07B7DB8D44
              2201A3D1F835102B0E068390C96454ACD3E930994C301C0EB15C2E51A954E0F7
              FB3F076D361B58AD562A6E369B904AA58F3F3659281442A7D341BFDF87C16010
              06259349D46A352C160B48249297692F970B012C160BE5F1824EA7136C361BEC
              763BCAE5B2A0B8A9540AAD560BBBDD8E1FB4DD6EA1D7EB91C9642859288AC522
              D2E9348EC7233FE876BBC1E17040A954A25EAF0B82E2F138DAED36092FA8513E
              9F47369BC56030805AAD7E819CCF67984C26B85C2E944A256110EB140E874927
              0655A9548FBFF57A4DC7604D7ABD1EB45A2D3F68341A21128960BFDFD35B2C16
              231008D0AAABD58AAEC42EC934F2783CFC3E1A8FC7E4112620F34EA150C0743A
              45A3D1C07C3E8742A180D7EB452C168346A379DAE20162A346A3511C0E077233
              33A2D96CA6A4FBFD4E676693F0F9EA09C40CC6F697CBE5A856ABE4ECEFC403E4
              F3F9A82B13D7E9747E0B2278B59FC4138899512412FD1EF49B7807C22803D414
              9A2D2C0000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edPessoaCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 47
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object edNatFin: TLMDLabeledEdit
        Left = 75
        Top = 96
        Width = 239
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14540253
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 3
        OnKeyDown = edNatFinKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <
          item
            Color = clWhite
            Cursor = crHandPoint
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D494844520000001200000014080600000080976D
              4A000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC300000EC301C76FA864000001C44944415478DAD592BD
              CB816114C6AF6751468324B37C44A48430B029038A0C2CFE006236C83FC0C840
              210C762329313019503E2265A0641386F77DEF3328799EB7F76B79CF76779FF3
              3BE75CE7E2DE3E027F10DCFF02CD6633E4723974BB5D5CAF57701C07B7DB8D44
              2201A3D1F835102B0E068390C96454ACD3E930994C301C0EB15C2E51A954E0F7
              FB3F076D361B58AD562A6E369B904AA58F3F3659281442A7D341BFDF87C16010
              06259349D46A352C160B48249297692F970B012C160BE5F1824EA7136C361BEC
              763BCAE5B2A0B8A9540AAD560BBBDD8E1FB4DD6EA1D7EB91C9642859288AC522
              D2E9348EC7233FE876BBC1E17040A954A25EAF0B82E2F138DAED36092FA8513E
              9F47369BC56030805AAD7E819CCF67984C26B85C2E944A256110EB140E874927
              0655A9548FBFF57A4DC7604D7ABD1EB45A2D3F68341A21128960BFDFD35B2C16
              231008D0AAABD58AAEC42EC934F2783CFC3E1A8FC7E4112620F34EA150C0743A
              45A3D1C07C3E8742A180D7EB452C168346A379DAE20162A346A3511C0E077233
              33A2D96CA6A4FBFD4E676693F0F9EA09C40CC6F697CBE5A856ABE4ECEFC403E4
              F3F9A82B13D7E9747E0B2278B59FC4138899512412FD1EF49B7807C22803D414
              9A2D2C0000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edNatFinCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 47
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object edConv: TLMDLabeledEdit
        Left = 75
        Top = 37
        Width = 367
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14540253
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 1
        OnExit = edConvExit
        OnKeyDown = edConvKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <
          item
            Color = clWhite
            Cursor = crHandPoint
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100802000000909168
              36000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC300000EC301C76FA864000001944944415478DA9D923F
              8F015114C5774AE51422A2164C46884410147412059310058D0F40A815E20B98
              9282043153E8952312A1309502893F211205894C37190A7BB28AC16C76B37BAB
              9777EFEFDD77CEBDC4FD7EFFF84B105A60B15854ABD5C160A0280A4110E17038
              9FCF3B9DCEEF01D425120983C1803A9AA667B3D9643259AFD7AD562B1E8FBF03
              BBDDCEEBF5A28EE779BD5EFFB8449F64322908C2683472381C2F40A150E8743A
              ABD58A24C9E7B6B22CA3D4E3F120AB0297CBC5E7F3F9FDFE66B3A9D55A2C167B
              BDDEE1705081FD7E6FB7DBCBE532725AA05EAF974AA5F3F9AC02D7EB35100898
              CDE66EB7AB0572B95CBFDF87FA170D2CCB562A95F1786CB55A9FAB254972B95C
              A150A8D168BC007823954A4106488BC5F2B8DC6EB73003AF0C87438AA254603A
              9DA6D3E9E3F188B34EA7631806DFDB6C367006A64143241251E7208A22CC8626
              D85FABD5E6F339C771CBE5D2643245A3D16C366BB3D9D449A35D2693399D4E18
              3046E676BB91B8DD6E3091FC8AF75DC250F051A3D1D86EB731E9DF972F168BE1
              31080D0683FFD9D69FE313D0AFE0E187B7AB460000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edConvCustomButtons0Click
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 47
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object LMDSimplePanel6: TLMDSimplePanel
        Left = 457
        Top = 0
        Width = 380
        Height = 123
        Bevel.StandardStyle = lsSingleRaised
        Color = 15923199
        TabOrder = 5
        object LMDLabel9: TLMDLabel
          Left = 3
          Top = 83
          Width = 46
          Height = 16
          Alignment = agBottomRight
          Color = 15923199
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2894892
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentColor = False
          ParentFont = False
          Caption = 'ORDEM:'
        end
        object LMDLabel10: TLMDLabel
          Left = 3
          Top = 42
          Width = 53
          Height = 16
          Alignment = agBottomRight
          Color = 15923199
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2894892
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentColor = False
          ParentFont = False
          Caption = 'FILTROS:'
        end
        object ckVencimento: TLMDCheckBox
          Left = 188
          Top = 102
          Width = 105
          Height = 17
          Caption = 'VENCIMENTO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          OnClick = ckVencimentoClick
          Checked = True
          State = cbChecked
        end
        object ckPagamento: TLMDCheckBox
          Left = 84
          Top = 102
          Width = 97
          Height = 16
          Caption = 'PAGAMENTO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          OnClick = ckPagamentoClick
        end
        object ckEmissao: TLMDCheckBox
          Left = 3
          Top = 102
          Width = 77
          Height = 16
          Caption = 'EMISS'#195'O'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = ckEmissaoClick
        end
        object ckEnviados: TLMDCheckBox
          Left = 177
          Top = 61
          Width = 84
          Height = 17
          Caption = 'ENVIADOS'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = ckEnviadosClick
        end
        object ckNaoEnviados: TLMDCheckBox
          Left = 266
          Top = 61
          Width = 111
          Height = 17
          Caption = 'N'#195'O ENVIADOS'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = ckNaoEnviadosClick
        end
        object ckTodos: TLMDCheckBox
          Left = 3
          Top = 61
          Width = 70
          Height = 17
          Caption = 'TODOS'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = ckTodosClick
          Checked = True
          State = cbChecked
        end
        object ckBaixados: TLMDCheckBox
          Left = 84
          Top = 61
          Width = 79
          Height = 19
          Caption = 'BAIXADOS'
          ParentColor = False
          ParentBackground = False
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Color = 15923199
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
        object ckPagar: TLMDCheckBox
          Left = 3
          Top = 16
          Width = 76
          Height = 19
          Caption = 'A PAGAR'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = ckPagarClick
          Checked = True
          State = cbChecked
        end
        object ckReceber: TLMDCheckBox
          Left = 84
          Top = 16
          Width = 86
          Height = 15
          Caption = 'A RECEBER'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 8158332
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = ckReceberClick
        end
      end
    end
    object PanelCabecalho: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 1
      Width = 1056
      Height = 24
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14671839
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15263976
      TabOrder = 4
      object LMDLabel1: TLMDLabel
        Left = 481
        Top = 4
        Width = 97
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'BUSCA T'#205'TULOS'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 1034
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
        Transparent = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btFecharClick
        Appearance.BorderColor = 15263976
        Appearance.BorderColorHot = 15263976
        Appearance.BorderColorCheckedHot = 15263976
        Appearance.BorderColorDown = 15263976
        Appearance.BorderColorChecked = 15263976
        Appearance.BorderColorDisabled = 15263976
        Appearance.BorderColorFocused = 15263976
        Appearance.Color = 15263976
        Appearance.ColorTo = 15263976
        Appearance.ColorChecked = 15263976
        Appearance.ColorCheckedTo = 15263976
        Appearance.ColorDisabled = 15263976
        Appearance.ColorDisabledTo = 15263976
        Appearance.ColorDown = 15263976
        Appearance.ColorDownTo = 15263976
        Appearance.ColorHot = 15263976
        Appearance.ColorHotTo = 15263976
        Appearance.ColorMirror = 15263976
        Appearance.ColorMirrorTo = 15263976
        Appearance.ColorMirrorHot = 15263976
        Appearance.ColorMirrorHotTo = 15263976
        Appearance.ColorMirrorDown = 15263976
        Appearance.ColorMirrorDownTo = 15263976
        Appearance.ColorMirrorChecked = 15263976
        Appearance.ColorMirrorCheckedTo = 15263976
        Appearance.ColorMirrorDisabled = 15263976
        Appearance.ColorMirrorDisabledTo = 15263976
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
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 175
      Width = 1058
      Height = 235
      Hint = 'Marcar todos t'#237'tulos'
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouTitu
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'GeraBol'
          Title.Caption = '  '
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 20
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nompes'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'NOME DA PESSOA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 242
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nomfil'
          Title.Alignment = taCenter
          Title.Caption = 'FILIAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nomcon'
          Title.Alignment = taCenter
          Title.Caption = 'CONV'#202'NIO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 128
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Nrotit'
          Title.Alignment = taCenter
          Title.Caption = 'DOCUMENTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Destit'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'PA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 23
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Datemi'
          Title.Alignment = taCenter
          Title.Caption = 'EMISS'#195'O'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Datven'
          Title.Alignment = taCenter
          Title.Caption = 'VENCE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Datpag'
          Title.Alignment = taCenter
          Title.Caption = 'PAGAMEN.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Vlrtit'
          Title.Alignment = taCenter
          Title.Caption = 'VALOR'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Saltit'
          Title.Alignment = taCenter
          Title.Caption = 'SALDO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'IndEnvBco'
          Title.Caption = 'ENV'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 27
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BolGerado'
          Title.Caption = 'BOL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
    object PanelRodape: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 413
      Width = 1056
      Height = 28
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14671839
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15263976
      TabOrder = 3
      object Label35: TLabel
        AlignWithMargins = True
        Left = 821
        Top = 7
        Width = 110
        Height = 17
        Margins.Left = 2
        Margins.Top = 6
        Margins.Right = 5
        Align = alRight
        Alignment = taCenter
        BiDiMode = bdLeftToRight
        Caption = 'TOTAL DO PER'#205'ODO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Transparent = True
        ExplicitHeight = 14
      end
      object Label13: TLabel
        AlignWithMargins = True
        Left = 552
        Top = 7
        Width = 120
        Height = 17
        Margins.Left = 2
        Margins.Top = 6
        Margins.Right = 5
        Align = alRight
        Alignment = taRightJustify
        Caption = 'TOTAL SELECIONADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitHeight = 14
      end
      object edTotPer: TCurrencyEdit
        AlignWithMargins = True
        Left = 939
        Top = 2
        Width = 115
        Height = 23
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 10
        TabStop = False
        Align = alRight
        AutoSelect = False
        AutoSize = False
        BorderStyle = bsNone
        Color = 15134463
        Ctl3D = False
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        FormatOnEditing = True
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edTotSel: TCurrencyEdit
        AlignWithMargins = True
        Left = 679
        Top = 3
        Width = 115
        Height = 23
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 25
        Margins.Bottom = 10
        TabStop = False
        Align = alRight
        AutoSelect = False
        AutoSize = False
        BorderStyle = bsNone
        Color = 15134463
        Ctl3D = False
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        FormatOnEditing = True
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object btRetorno: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 127
        Top = 2
        Width = 123
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 5
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Caption = 'Retorno Remessa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5855577
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 0
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Rounded = False
        Spacing = 7
        TabOrder = 2
        Visible = False
        OnClick = btRetornoClick
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
      object btGeraBoleto: TAdvGlowButton
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 120
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Caption = 'Gerar Boletos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5855577
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
        Rounded = False
        Spacing = 0
        TabOrder = 3
        Visible = False
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
    object LMDSimplePanel4: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 155
      Width = 1056
      Height = 18
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14671839
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15263976
      TabOrder = 2
      object btSelecTudo: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 1032
        Top = 1
        Width = 22
        Height = 16
        Cursor = crHandPoint
        Hint = 'Marcar todos t'#237'tulos'
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4868682
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D494844520000000E0000000E08060000001F482D
          D1000000097048597300000EC300000EC301C76FA864000000206348524D0000
          7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
          C546000000904944415478DABCD2310EC2300C856157AC6541CC2CDC80853543
          E45F114AB6DC0B8E8504678191A50A4BA6D6D0521096BCF993EC270B50E6B47C
          0D4B2932A50750462AC6B816918F60031C810ED84D858DAA9EEACC35A5B41C40
          EFFD0638AB6AB010B032570D216C813BF0000E167A79A3AAEE2BEE2CF4369C8A
          6FC0A58F465375CEB539E78595D6EF1EE06FBFFA1C00AA591B533B85F9AD0000
          000049454E44AE426082}
        Rounded = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btSelecTudoClick
        Appearance.BorderColor = 14737632
        Appearance.BorderColorHot = 14737632
        Appearance.BorderColorCheckedHot = 14737632
        Appearance.BorderColorDown = 14737632
        Appearance.BorderColorChecked = 14737632
        Appearance.BorderColorDisabled = 14737632
        Appearance.BorderColorFocused = 14737632
        Appearance.Color = 14737632
        Appearance.ColorTo = 14737632
        Appearance.ColorChecked = 14737632
        Appearance.ColorCheckedTo = 14737632
        Appearance.ColorDisabled = 14737632
        Appearance.ColorDisabledTo = 14737632
        Appearance.ColorDown = 14737632
        Appearance.ColorDownTo = 14737632
        Appearance.ColorHot = 14737632
        Appearance.ColorHotTo = 14737632
        Appearance.ColorMirror = 14737632
        Appearance.ColorMirrorTo = 14737632
        Appearance.ColorMirrorHot = 14737632
        Appearance.ColorMirrorHotTo = 14737632
        Appearance.ColorMirrorDown = 14737632
        Appearance.ColorMirrorDownTo = 14737632
        Appearance.ColorMirrorChecked = 14737632
        Appearance.ColorMirrorCheckedTo = 14737632
        Appearance.ColorMirrorDisabled = 14737632
        Appearance.ColorMirrorDisabledTo = 14737632
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3750459
        Appearance.TextColorDown = clWhite
        Appearance.TextColorHot = clWhite
        Appearance.TextColorDisabled = 13948116
      end
      object btDesmarTudo: TAdvGlowButton
        AlignWithMargins = True
        Left = 1008
        Top = 1
        Width = 22
        Height = 16
        Cursor = crHandPoint
        Hint = 'Desmarcar todos t'#237'tulos'
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -10
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D494844520000000E0000000E08060000001F482D
          D1000000097048597300000EC300000EC301C76FA864000000206348524D0000
          7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
          C546000000284944415478DA62707777FF4F0E66A058E3FFFFFF1988C1A31A47
          355229C9918A01000000FFFF0300A541DA640FF3E2600000000049454E44AE42
          6082}
        Rounded = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btDesmarTudoClick
        Appearance.BorderColor = 14737632
        Appearance.BorderColorHot = 14737632
        Appearance.BorderColorCheckedHot = 14737632
        Appearance.BorderColorDown = 14737632
        Appearance.BorderColorChecked = 14737632
        Appearance.BorderColorDisabled = 14737632
        Appearance.BorderColorFocused = 14737632
        Appearance.Color = 14737632
        Appearance.ColorTo = 14737632
        Appearance.ColorChecked = 14737632
        Appearance.ColorCheckedTo = 14737632
        Appearance.ColorDisabled = 14737632
        Appearance.ColorDisabledTo = 14737632
        Appearance.ColorDown = 14737632
        Appearance.ColorDownTo = 14737632
        Appearance.ColorHot = 14737632
        Appearance.ColorHotTo = 14737632
        Appearance.ColorMirror = 14737632
        Appearance.ColorMirrorTo = 14737632
        Appearance.ColorMirrorHot = 14737632
        Appearance.ColorMirrorHotTo = 14737632
        Appearance.ColorMirrorDown = 14737632
        Appearance.ColorMirrorDownTo = 14737632
        Appearance.ColorMirrorChecked = 14737632
        Appearance.ColorMirrorCheckedTo = 14737632
        Appearance.ColorMirrorDisabled = 14737632
        Appearance.ColorMirrorDisabledTo = 14737632
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3750459
        Appearance.TextColorDown = clWhite
        Appearance.TextColorHot = clWhite
        Appearance.TextColorDisabled = 13948116
      end
    end
  end
  object SouTitu: TDataSource
    AutoEdit = False
    DataSet = TabTitu
    Left = 87
    Top = 303
  end
  object TabTitu: TRESTDWClientSQL
    Active = False
    AfterOpen = TabTituAfterOpen
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    BinaryCompatibleMode = False
    MasterCascadeDelete = True
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      
        'SELECT TIT.IDTitu,TIP.RedTiptit,PES.Nompes,PES.CpfCnpjPes,PES.En' +
        'dpes,PES.NroEnd,PES.Baipes,PES.Ceppes,MUN.Nommun,MUN.Estmun,FIL.' +
        'Nomfil,'
      
        'TIT.IDFilial,TIT.Nrotit,TIT.Destit,TIT.PagRec,TIT.Datemi,TIT.Dat' +
        'ven,BAI.Datpag,TIT.Vlrtit,TIT.Saltit,CON.Nomcon, TIT.IndEnvBco,'
      
        'TIT.GeraBol,TIT.BolGerado,TIT.IDConv,TIT.NomeArqBol,TIT.NossoNro' +
        '  FROM arqtitulo TIT'
      'LEFT JOIN arqtiptitu TIP ON TIT.IDTiptit = TIP.IDTiptit '
      'LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '
      'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun'
      'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial'
      'LEFT JOIN arqconvenio CON ON TIT.IDConv = CON.IDConv'
      
        'LEFT JOIN (SELECT IDTitu, MIN(Datpag) AS Datpag FROM arqtituloba' +
        'i GROUP BY IDTitu) BAI ON TIT.IDTitu = BAI.IDTitu'
      'ORDER BY TIT.Datven LIMIT 10')
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 32
    Top = 303
    object TabTituIDTitu: TFDAutoIncField
      FieldName = 'IDTitu'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TabTituNompes: TWideStringField
      FieldName = 'Nompes'
      ProviderFlags = []
      Size = 106
    end
    object TabTituIDFilial: TIntegerField
      FieldName = 'IDFilial'
    end
    object TabTituNomfil: TWideStringField
      FieldName = 'Nomfil'
      ProviderFlags = []
      Size = 60
    end
    object TabTituNrotit: TWideStringField
      FieldName = 'Nrotit'
      Size = 16
    end
    object TabTituDestit: TWideStringField
      FieldName = 'Destit'
      Size = 4
    end
    object TabTituPagRec: TWideStringField
      FieldName = 'PagRec'
      Size = 1
    end
    object TabTituDatemi: TDateField
      FieldName = 'Datemi'
    end
    object TabTituDatven: TDateField
      FieldName = 'Datven'
    end
    object TabTituDatpag: TDateField
      FieldName = 'Datpag'
    end
    object TabTituVlrtit: TFloatField
      FieldName = 'Vlrtit'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabTituSaltit: TFloatField
      FieldName = 'Saltit'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabTituNomcon: TWideStringField
      FieldName = 'Nomcon'
      ProviderFlags = []
      Size = 40
    end
    object TabTituIndEnvBco: TWideStringField
      FieldName = 'IndEnvBco'
      Size = 1
    end
    object TabTituGeraBol: TWideStringField
      FieldName = 'GeraBol'
      Size = 1
    end
    object TabTituBolGerado: TWideStringField
      FieldName = 'BolGerado'
      Size = 1
    end
    object TabTituIDConv: TIntegerField
      FieldName = 'IDConv'
    end
    object TabTituNomeArqBol: TWideStringField
      FieldName = 'NomeArqBol'
      Size = 30
    end
    object TabTituCpfCnpjPes: TWideStringField
      FieldName = 'CpfCnpjPes'
      Size = 14
    end
    object TabTituEndpes: TWideStringField
      FieldName = 'Endpes'
      Size = 50
    end
    object TabTituNroEnd: TWideStringField
      FieldName = 'NroEnd'
      Size = 8
    end
    object TabTituBaipes: TWideStringField
      FieldName = 'Baipes'
      Size = 40
    end
    object TabTituCeppes: TWideStringField
      FieldName = 'Ceppes'
      Size = 8
    end
    object TabTituNommun: TWideStringField
      FieldName = 'Nommun'
      Size = 55
    end
    object TabTituEstmun: TWideStringField
      FieldName = 'Estmun'
      Size = 2
    end
    object TabTituNossoNro: TWideStringField
      FieldName = 'NossoNro'
    end
    object TabTituRedTiptit: TWideStringField
      FieldName = 'RedTiptit'
      Size = 2
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 152
    Top = 304
  end
end
