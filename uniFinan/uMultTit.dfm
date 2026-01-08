object FrmMulTit: TFrmMulTit
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Gera'#231#227'o Multipla de Titulos'
  ClientHeight = 519
  ClientWidth = 890
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
    Top = 1
    Width = 890
    Height = 518
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 11974326
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
      Width = 888
      Height = 271
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 11974326
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 16316664
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8679793
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 2
      object LMDLabel4: TLMDLabel
        Left = 32
        Top = 65
        Width = 44
        Height = 15
        Alignment = agCenterRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'PESSOA'
      end
      object LMDLabel2: TLMDLabel
        Left = 32
        Top = 165
        Width = 33
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'FILIAL'
      end
      object LMDLabel3: TLMDLabel
        Left = 468
        Top = 65
        Width = 50
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'EMISS'#195'O'
      end
      object LMDLabel6: TLMDLabel
        Left = 469
        Top = 14
        Width = 70
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'NOTA FISCAL'
      end
      object LMDLabel5: TLMDLabel
        Left = 579
        Top = 64
        Width = 85
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = '1'#186' VENCIMENTO'
      end
      object LMDLabel7: TLMDLabel
        Left = 32
        Top = 114
        Width = 122
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'NATUREZA FINANCEIRA'
      end
      object LMDLabel8: TLMDLabel
        Left = 32
        Top = 14
        Width = 84
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'TIPO DO T'#205'TULO'
      end
      object LMDLabel9: TLMDLabel
        Left = 579
        Top = 114
        Width = 56
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'PARCELAS'
      end
      object LMDLabel10: TLMDLabel
        Left = 467
        Top = 114
        Width = 46
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'DIA FIXO'
      end
      object LMDLabel11: TLMDLabel
        Left = 310
        Top = 14
        Width = 67
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'NRO.DOCTO.'
      end
      object LMDLabel12: TLMDLabel
        Left = 32
        Top = 217
        Width = 59
        Height = 15
        Alignment = agCenterRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'HIST'#211'RICO'
      end
      object LMDLabel13: TLMDLabel
        Left = 468
        Top = 165
        Width = 57
        Height = 15
        Alignment = agCenterRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'CHAVE PIX'
      end
      object Shape1: TShape
        Left = 699
        Top = 21
        Width = 1
        Height = 232
        Pen.Color = 13158600
      end
      object edFilial: TLMDLabeledEdit
        Left = 32
        Top = 182
        Width = 422
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 9
        OnKeyDown = edFilialKeyDown
        OnKeyPress = edFilialKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
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
        EditLabel.Width = 49
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object LMDSimplePanel2: TLMDSimplePanel
        Left = 469
        Top = 82
        Width = 100
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 4
        object edDatemi: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 95
          Height = 20
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
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
          Text = '12/02/2025'
          OnKeyPress = edDatemiKeyPress
        end
      end
      object LMDSimplePanel3: TLMDSimplePanel
        Left = 580
        Top = 82
        Width = 100
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 5
        object edDataBase: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 95
          Height = 20
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
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
          Text = '12/02/2025'
          OnKeyPress = edDataBaseKeyPress
        end
      end
      object edNotFis: TLMDEdit
        Left = 469
        Top = 33
        Width = 81
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 2
        OnKeyPress = edNotFisKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
      end
      object edPessoa: TLMDLabeledEdit
        Left = 32
        Top = 82
        Width = 422
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 3
        OnExit = edPessoaExit
        OnKeyDown = edPessoaKeyDown
        OnKeyPress = edPessoaKeyPress
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
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000000473424954080808087C086488000000097048597300000071000000
              71011C3F80770000001974455874536F667477617265007777772E696E6B7363
              6170652E6F72679BEE3C1A000001094944415478DA63FCFFFF3F032980919131
              1A48A501F11D20AE6004190014D405728C91D43D038AEFC2A2B900486503B11E
              10DB01711C239068006245203E8EA4F609D0802D58345B03F153200639BB1888
              8F820C3807546C44C0D930CD9140B57F80FC7E20DB018897810CB80014342056
              33540C640003905F88D700429AC17C5C0610A319A7014085D9503FE2D58CD500
              A04290D83D20BE0EC44140B91FB834E33200941EF280F820108700F16D20FE87
              4D332E03AA80942C107F037901881701E52BB084510D909A8BCD0050E0C903F1
              0E203E0494FB8E23861600A90E82E9004FFAA09E01FB80381C68C86B1234B301
              A9DD40EC0632009458EA80989F0407FC02E269404B570000D1C79C8A61B02532
              0000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edPessoaCustomButtons0Click
            UsePngGlyph = True
          end
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
            Index = 1
            DisplayName = 'TLMDSpecialButton'
            OnClick = edPessoaCustomButtons1Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 49
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object edDesAce: TLMDLabeledMaskEdit
        Left = 717
        Top = 33
        Width = 83
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentThemeMode = False
        TabOrder = 12
        ThemeMode = ttmNative
        OnKeyPress = edDesAceKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatFixed
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        LabelSpacing = 1
        EditLabel.Width = 84
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 9600112
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'DESP.ACESS'#211'R.'
        Value = 0.000000000000000000
      end
      object edVlrtit: TLMDLabeledMaskEdit
        Left = 717
        Top = 232
        Width = 83
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentThemeMode = False
        TabOrder = 18
        ThemeMode = ttmNative
        OnKeyPress = edVlrtitKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatFixed
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        LabelSpacing = 1
        EditLabel.Width = 72
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 9600112
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'VLR.PARCELA'
        Value = 0.000000000000000000
      end
      object edDesAsso: TLMDLabeledMaskEdit
        Left = 717
        Top = 82
        Width = 83
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentThemeMode = False
        TabOrder = 13
        ThemeMode = ttmNative
        OnKeyPress = edDesAssoKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatFixed
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        LabelSpacing = 1
        EditLabel.Width = 66
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 9600112
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'DESCONTOS'
        Value = 0.000000000000000000
      end
      object edNatFin: TLMDLabeledEdit
        Left = 32
        Top = 132
        Width = 422
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 6
        OnKeyDown = edNatFinKeyDown
        OnKeyPress = edNatFinKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
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
        EditLabel.Width = 51
        EditLabel.Height = 16
        EditLabel.Caption = 'edNatFin'
      end
      object edTiptit: TLMDLabeledEdit
        Left = 32
        Top = 33
        Width = 264
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 0
        OnExit = edTiptitExit
        OnKeyDown = edTiptitKeyDown
        OnKeyPress = edTiptitKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
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
            OnClick = edTiptitCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 49
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object edNroPar: TLMDSpinEdit
        Left = 580
        Top = 132
        Width = 57
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 8
        OnKeyPress = edNroParKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        MaxLength = 3
        AutoSelect = True
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        MinValue = 1
        Value = 2
        Value = 2
      end
      object edDiaVen: TLMDSpinEdit
        Left = 469
        Top = 132
        Width = 57
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 7
        OnKeyPress = edDiaVenKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        MaxLength = 2
        AutoSelect = True
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        MinValue = 1
        MaxValue = 30
        Value = 1
        Value = 1
      end
      object edNrotit: TLMDEdit
        Left = 310
        Top = 33
        Width = 144
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 1
        OnKeyPress = edNotFisKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
      end
      object RadioPag: TLMDRadioButton
        Left = 570
        Top = 11
        Width = 66
        Height = 19
        Caption = 'PAGAR'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 19
      end
      object RadioRec: TLMDRadioButton
        Left = 570
        Top = 37
        Width = 78
        Height = 19
        Caption = 'RECEBER'
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Checked = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9600112
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 20
      end
      object edVlrJur: TLMDLabeledMaskEdit
        Left = 717
        Top = 132
        Width = 83
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentThemeMode = False
        TabOrder = 14
        ThemeMode = ttmNative
        OnKeyPress = edVlrJurKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatFixed
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        LabelSpacing = 1
        EditLabel.Width = 55
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 9600112
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'JUROS R$'
        Value = 0.000000000000000000
      end
      object edPerJur: TLMDLabeledMaskEdit
        Left = 806
        Top = 132
        Width = 49
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentThemeMode = False
        TabOrder = 15
        ThemeMode = ttmNative
        OnKeyPress = edPerJurKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatFixed
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        LabelSpacing = 1
        EditLabel.Width = 49
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 9600112
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'JUROS %'
        Value = 0.000000000000000000
      end
      object edVlrMul: TLMDLabeledMaskEdit
        Left = 717
        Top = 182
        Width = 83
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentThemeMode = False
        TabOrder = 16
        ThemeMode = ttmNative
        OnKeyPress = edVlrMulKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatFixed
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        LabelSpacing = 1
        EditLabel.Width = 56
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 9600112
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'MULTA R$'
        Value = 0.000000000000000000
      end
      object edPerMul: TLMDLabeledMaskEdit
        Left = 808
        Top = 182
        Width = 51
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentThemeMode = False
        TabOrder = 17
        ThemeMode = ttmNative
        OnKeyPress = edPerMulKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatFixed
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        LabelSpacing = 1
        EditLabel.Width = 50
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 9600112
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'MULTA %'
        Value = 0.000000000000000000
      end
      object edHist: TLMDLabeledEdit
        Left = 32
        Top = 232
        Width = 648
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 11
        OnKeyPress = edHistKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 49
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object edChaPix: TLMDLabeledEdit
        Left = 469
        Top = 182
        Width = 212
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 16119285
        Enabled = False
        TabOrder = 10
        OnKeyPress = edChaPixKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <>
        CustomButtonWidth = 18
        PasswordChar = #0
        ReadOnly = True
        Spelling.LiveSpell = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 49
        EditLabel.Height = 16
        EditLabel.Enabled = False
        EditLabel.Caption = 'edBusca'
      end
    end
    object LMDSimplePanel1: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 888
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
      Color = 15789806
      TabOrder = 1
      object LMDLabel1: TLMDLabel
        Left = 333
        Top = 6
        Width = 196
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'GERA'#199#195'O M'#218'LTIPLA DE T'#205'TULOS'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 866
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
        Appearance.BorderColor = 15789806
        Appearance.BorderColorHot = 15789806
        Appearance.BorderColorCheckedHot = 15789806
        Appearance.BorderColorDown = 15789806
        Appearance.BorderColorChecked = 15789806
        Appearance.BorderColorDisabled = 15789806
        Appearance.BorderColorFocused = 15789806
        Appearance.Color = 15789806
        Appearance.ColorTo = 15789806
        Appearance.ColorChecked = 15789806
        Appearance.ColorCheckedTo = 15789806
        Appearance.ColorDisabled = 15789806
        Appearance.ColorDisabledTo = 15789806
        Appearance.ColorDown = 15789806
        Appearance.ColorDownTo = 15789806
        Appearance.ColorHot = 15789806
        Appearance.ColorHotTo = 15789806
        Appearance.ColorMirror = 15789806
        Appearance.ColorMirrorTo = 15789806
        Appearance.ColorMirrorHot = 15789806
        Appearance.ColorMirrorHotTo = 15789806
        Appearance.ColorMirrorDown = 15789806
        Appearance.ColorMirrorDownTo = 15789806
        Appearance.ColorMirrorChecked = 15789806
        Appearance.ColorMirrorCheckedTo = 15789806
        Appearance.ColorMirrorDisabled = 15789806
        Appearance.ColorMirrorDisabledTo = 15789806
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
    object dgDados: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 301
      Width = 888
      Height = 180
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alTop
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouTitu
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnDrawColumnCell = dgDadosDrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Nrotit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DOCUMENTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Destit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'PA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 39
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Datemi'
          Title.Alignment = taCenter
          Title.Caption = 'EMISS'#195'O'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Datven'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'VENCE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Vlrtit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'VALOR'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Saltit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'SALDO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NosNum'
          Title.Caption = 'NOSSO N'#218'MERO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CodBar'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 220
          Visible = True
        end>
    end
    object PanelBottom: TLMDSimplePanel
      Left = 1
      Top = 483
      Width = 888
      Height = 35
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 11974326
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15789806
      TabOrder = 2
      ExplicitLeft = 2
      ExplicitTop = 499
      object btSalvar: TAdvGlowButton
        AlignWithMargins = True
        Left = 783
        Top = 5
        Width = 100
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alRight
        Caption = 'Salvar'
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
        OnClick = btSalvarClick
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
      object btGerar: TAdvGlowButton
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 107
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Gerar'
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
        TabOrder = 1
        OnClick = btGerarClick
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
  end
  object MemTitu: TVirtualTable
    FieldDefs = <
      item
        Name = 'Nrotit'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'Destit'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NotFis'
        DataType = ftInteger
      end
      item
        Name = 'Datemi'
        DataType = ftDate
      end
      item
        Name = 'Datven'
        DataType = ftDate
      end
      item
        Name = 'VlrAces'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'DesAsso'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'Vlrtit'
        DataType = ftFloat
        Precision = 15
      end>
    BeforePost = MemTituBeforePost
    OnCalcFields = MemTituCalcFields
    Left = 24
    Top = 384
    Data = {
      0400080006004E726F74697401000C0000000000060044657374697401000300
      0000000006004E6F7446697303000000000000000600446174656D6909000000
      00000000060044617476656E09000000000000000700566C7241636573060000
      000F00000007004465734173736F060000000F0000000600566C727469740600
      00000F000000000000000000}
    object MemTituIDTiptit: TIntegerField
      FieldName = 'IDTiptit'
    end
    object MemTituNrotit: TWideStringField
      DisplayWidth = 20
      FieldName = 'Nrotit'
      Size = 12
    end
    object MemTituDestit: TWideStringField
      Alignment = taCenter
      FieldName = 'Destit'
      Size = 3
    end
    object MemTituNotFis: TIntegerField
      FieldName = 'NotFis'
    end
    object MemTituDatemi: TDateField
      Alignment = taCenter
      FieldName = 'Datemi'
      EditMask = '!99/99/0000;1;_'
    end
    object MemTituDatven: TDateField
      Alignment = taCenter
      FieldName = 'Datven'
      EditMask = '!99/99/0000;1;_'
    end
    object MemTituVlrAces: TFloatField
      FieldName = 'VlrAces'
      DisplayFormat = '###,###,###,##0.00'
    end
    object MemTituDesAsso: TFloatField
      FieldName = 'DesAsso'
      DisplayFormat = '###,###,###,##0.00'
    end
    object MemTituVlrtit: TFloatField
      FieldName = 'Vlrtit'
      DisplayFormat = '###,###,###,##0.00'
    end
    object MemTituSaltit: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Saltit'
      DisplayFormat = '###,###,###,##0.00'
      Calculated = True
    end
    object MemTituVlrJur: TFloatField
      FieldKind = fkCalculated
      FieldName = 'VlrJur'
      DisplayFormat = '###,###,###,##0.00'
      Calculated = True
    end
    object MemTituVlrMul: TFloatField
      FieldKind = fkCalculated
      FieldName = 'VlrMul'
      DisplayFormat = '###,###,###,##0.00'
      Calculated = True
    end
    object MemTituPerJur: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PerJur'
      DisplayFormat = '###,###,###,##0.00'
      Calculated = True
    end
    object MemTituPerMul: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PerMul'
      DisplayFormat = '###,###,###,##0.00'
      Calculated = True
    end
    object MemTituNosNum: TWideStringField
      FieldName = 'NosNum'
    end
    object MemTituCodBar: TWideStringField
      DisplayWidth = 300
      FieldName = 'CodBar'
      Size = 300
    end
    object MemTituChavePIXQRCode: TWideStringField
      DisplayWidth = 300
      FieldName = 'ChavePIXQRCode'
      Size = 300
    end
    object MemTituChaPix: TWideStringField
      FieldName = 'ChaPix'
    end
  end
  object SouTitu: TDataSource
    DataSet = MemTitu
    Left = 112
    Top = 384
  end
end
