object FrmCompRecTit: TFrmCompRecTit
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'COMPRAS - Recebimento de Produtos - T'#237'tulos'
  ClientHeight = 434
  ClientWidth = 997
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 14
  object PanelCabTit: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 28
    Width = 995
    Height = 153
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 15130077
    Bevel.BorderWidth = 1
    Color = 15528703
    TabOrder = 0
    object LMDLabel2: TLMDLabel
      Left = 715
      Top = 7
      Width = 71
      Height = 15
      Alignment = agCenterRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7561559
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'VENCIMENTO'
    end
    object edChaPix: TLMDLabeledEdit
      Left = 501
      Top = 69
      Width = 198
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = 15658734
      Enabled = False
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3617579
      Font.Height = -13
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
      LabelSpacing = 1
      EditLabel.Width = 57
      EditLabel.Height = 15
      EditLabel.Enabled = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 16582
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'CHAVE PIX'
    end
    object edTiptit: TLMDDBLabeledEdit
      Left = 10
      Top = 24
      Width = 261
      Height = 23
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 1
      OnExit = edTiptitExit
      OnKeyDown = edTiptitKeyDown
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
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
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Index = 0
          DisplayName = 'TLMDSpecialButton'
          OnClick = edTiptitCustomButtons0Click
          UsePngGlyph = True
        end>
      DataField = 'DesTiptit'
      DataSource = SouTitulo
      LabelSpacing = 1
      EditLabel.Width = 84
      EditLabel.Height = 15
      EditLabel.Color = clBlack
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'TIPO DO T'#205'TULO'
    end
    object edNatFin: TLMDDBLabeledEdit
      Left = 280
      Top = 24
      Width = 420
      Height = 23
      Hint = 'Natureza financeira...'
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnExit = edNatFinExit
      ValidationMsgString = 'a Natureza financeira'
      Font.Charset = ANSI_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      CharCase = ecLowerCase
      ParentFont = False
      CustomButtons = <
        item
          Color = clWhite
          Cursor = crHandPoint
          ParentFont = False
          PngGlyph.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
            00097048597300000EC100000EC101B8916BED0000001974455874536F667477
            617265007777772E696E6B73636170652E6F72679BEE3C1A000000E549444154
            78DAEDD12D0A84401C05F0375D4DDA0D26BD8541F41A161141F4227E1483416F
            21983C856013BB49B3ECAE134CBB302CFF855DD8975E99F9316FD8ED117C30EC
            0FFC16308E231863304D931EE8FB1EAEEB5EDD711C5AA0AA2A445174F5300C69
            81799E91E7399F284D53E8BA4E0BBC9B97C0BEEF58D755E812555521CBB238B0
            6D1B922441DBB64280EFFB7C3E4551C48173E7A6698481A2289EBE8264224DD3
            204992F8449411069665419665388E83FF8F6118B4405DD7088280F7B22C11C7
            312D300C036CDBE6BDEB3A789E470B9C99A6894F645996E8912FFAE43FF0B1DC
            01464BADB9C5E872660000000049454E44AE426082}
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Index = 0
          DisplayName = 'TLMDSpecialButton'
          OnClick = edNatFinCustomButtons0Click
          UsePngGlyph = True
        end>
      CustomButtonsStyle = ubsExplorer
      CustomButtonWidth = 20
      CustomButtonParentCtlXP = False
      TabOnEnter = True
      DataField = 'Desnat'
      DataSource = SouTitulo
      ReadOnly = True
      LabelSpacing = 1
      EditLabel.Width = 122
      EditLabel.Height = 15
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'NATUREZA FINANCEIRA'
    end
    object edHist: TLMDDBLabeledEdit
      Left = 10
      Top = 69
      Width = 485
      Height = 22
      Hint = 'N'#250'mero documento'
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      ValidationMsgString = 'o N'#250'mero do Docto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'Histit'
      DataSource = SouTitulo
      LabelSpacing = 1
      EditLabel.Width = 59
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'HIST'#211'RICO'
    end
    object LMDSimplePanel2: TLMDSimplePanel
      Left = 715
      Top = 24
      Width = 112
      Height = 25
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Color = clWhite
      TabOrder = 4
      object edDatVenTit: TDBDateEdit
        AlignWithMargins = True
        Left = 4
        Top = 2
        Width = 104
        Height = 21
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alClient
        DataField = 'Datven'
        DataSource = SouTitulo
        AutoSelect = False
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DialogTitle = 'Entre com Data'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        GlyphKind = gkCustom
        Glyph.Data = {
          6E0C0000424D6E0C00000000000036000000280000002D000000170000000100
          180000000000380C000000000000000000000000000000000000241CED241CED
          241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
          ED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED24
          1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
          241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6
          A8AF41424A41424A41424A41424A41424A41424A41424A41424A41424AA6A8AF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9
          B5C0B9B5C0B9B5C0B9B5C0B9B5A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41424AFFFFFF41424A41424A41424A4142
          4A41424A41424A41424AFFFFFF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41424AFFFFFF41424A
          FFFFFF41424AFFFFFF41424AFFFFFF41424AFFFFFF41424AFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41
          424AFFFFFF41424A41424A41424A41424A41424A41424A41424AFFFFFF41424A
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFF
          FFE6E6E6FFFFFFE6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF41424AFFFFFF41424AFFFFFF41424AFFFFFF41424AFFFFFF41
          424AFFFFFF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41424AFFFFFF41424A41424A41424A4142
          4A41424A41424A41424AFFFFFF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFC0B9B5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41424AFFFFFF41424A
          FFFFFF41424AFFFFFF41424AFFFFFF41424AFFFFFF41424AFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41
          424AFFFFFF41424A41424A41424A41424A41424A41424A41424AFFFFFF41424A
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFF
          FFE6E6E6FFFFFFE6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF8F7FAF5F3F9
          F2EFFFFFFF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41424AFFFFFFC8C8C8C8C8C8C8C8C8C7C7
          C6C6C5C4C6C3C2C4C0BFF9F2EF41424AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A8AF41424A41424A
          41424A41424A41424A41424A41424A41424A41424AA6A8AFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFA6A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0
          B9B5C0B9B5A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CED241CED241CED241CED241CED241CED241CED24
          1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
          241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
          ED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED24
          1CED241CED241CED241CED241CED241CED00}
        ButtonWidth = 27
        NumGlyphs = 2
        ParentCtl3D = False
        ParentFont = False
        PopupColor = 15461355
        TabOrder = 0
      end
    end
    object edValTit: TLMDDBLabeledEdit
      Left = 715
      Top = 69
      Width = 112
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Enabled = False
      TabOrder = 5
      OnKeyPress = edValTitKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'Vlrtit'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 37
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Enabled = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'VALOR'
    end
    object edCodBarTit: TLMDDBLabeledEdit
      Left = 10
      Top = 117
      Width = 690
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = 15658734
      Enabled = False
      TabOrder = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      DataField = 'CodBarra'
      DataSource = SouTitulo
      ReadOnly = True
      LabelSpacing = 1
      EditLabel.Width = 103
      EditLabel.Height = 15
      EditLabel.Color = clBlack
      EditLabel.Enabled = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'C'#211'DIGO DE BARRAS'
    end
    object edNosNumTit: TLMDDBLabeledEdit
      Left = 715
      Top = 117
      Width = 112
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Enabled = False
      TabOrder = 7
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'NossoNro'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 90
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Enabled = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'NOSSO N'#218'MERO'
    end
    object btExcluiTit: TAdvGlowButton
      AlignWithMargins = True
      Left = 846
      Top = 54
      Width = 113
      Height = 26
      Cursor = crHandPoint
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Excluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5197647
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
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000014D49
        444154388DDD933D4B034110869F357B27912BECB51414AC24A44891CC06ECFC
        6884FC000B0BED05FF808DAD4D0A112CD30901BB235C133585B58D9DD6E9947C
        DC587827A7AEA8AD2F2CC3BEF3F0B23B30068F9C73EBAA7A0A2C030ADCABEA41
        9224F167D67C366AB55A390CC327E005E866F626303B1A8D16FAFDFEF39700E7
        DCA2AA1E011698075AC000B8CBB835A00A7480213029954AC7711C3FDA0C5802
        F6B2805CD5EC14D5CAEA44553BC0E37B4744DA22A2BE991425222A22EDFC3EE3
        832A95CA5CB3D9DCC89946A3B1ED9C8B7CACF5995114EDA4697A51AFD757ADB5
        419AA697AABA0B9CFF2A002803586BCB052FF081DE2FFC45FF20C03B44551D18
        63BAE3F1F8613A9D9A300CBBC698DB9F0226F0B60B4992DC015B85DE56DE2BB2
        1F0254F5C618B31F04C19588DC7FF3E295AC5EE746711B6744E404D8E56DA17C
        1A1A63CE7ABDDE219002BC02455063E17EF1AA0E0000000049454E44AE426082}
      Rounded = True
      Spacing = 4
      TabOrder = 8
      OnClick = btExcluiTitClick
      Appearance.BorderColor = 2412287
      Appearance.BorderColorHot = 50943
      Appearance.BorderColorCheckedHot = 50175
      Appearance.BorderColorDown = 46826
      Appearance.BorderColorChecked = 50175
      Appearance.BorderColorDisabled = 50175
      Appearance.BorderColorFocused = 50175
      Appearance.Color = 11792127
      Appearance.ColorTo = 50175
      Appearance.ColorChecked = 50175
      Appearance.ColorCheckedTo = 50175
      Appearance.ColorDisabled = 50175
      Appearance.ColorDisabledTo = 50175
      Appearance.ColorDown = 50175
      Appearance.ColorDownTo = 50175
      Appearance.ColorHot = 1887487
      Appearance.ColorHotTo = 1887487
      Appearance.ColorMirror = 50175
      Appearance.ColorMirrorTo = 50175
      Appearance.ColorMirrorHot = 1887487
      Appearance.ColorMirrorHotTo = 1887487
      Appearance.ColorMirrorDown = 50175
      Appearance.ColorMirrorDownTo = 50175
      Appearance.ColorMirrorChecked = 50175
      Appearance.ColorMirrorCheckedTo = 50175
      Appearance.ColorMirrorDisabled = 50175
      Appearance.ColorMirrorDisabledTo = 50175
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
    object btConfirmaTit: TAdvGlowButton
      AlignWithMargins = True
      Left = 846
      Top = 84
      Width = 113
      Height = 26
      Cursor = crHandPoint
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5197647
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
      TabOrder = 9
      OnClick = btConfirmaTitClick
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
      Appearance.TextColorDisabled = 9211020
    end
    object btCancelaTit: TAdvGlowButton
      AlignWithMargins = True
      Left = 846
      Top = 114
      Width = 113
      Height = 26
      Cursor = crHandPoint
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Cancela'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5197647
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
        485973000000600000006000F06B42CF0000000774494D4507E707191513379B
        1BC099000001DF4944415448C7ED92C14BDB501CC7BF2F31B8BCD246DB9332D8
        6105C18BBB889A0E0423AD4118B2BF6196D557D97AF4B4D3987737E786B7E18E
        22281AA9DE66A0D8EE2E7408C23C0CA4A6264889E6ED3283B8B689DB4DFC1EDF
        EFF73E9FFCF27BC07DEE7CC4568557BCAB6BE0B8B3B3F2BDD1680798DD8CC59E
        4444B15271DD6675A1D961C18CC72F5E54AB52FFE1218B0E0DB582E7E752294F
        3A3A92760E0E0AA62C871600007E4A12AADDDD58DDDECE2587879BC1F9ECD616
        D614855728151785D6AC6661A591113661598C71CE44DBCE7D1D1DBDAAE54E54
        951DD7EB8C71CE8AA7A7EDA6244112BC310C3C8EC5B0E438DE97C949645C5768
        1806DE46A398B22C3CCF643E9C954AFF24F84BF2EDFC1CAF394799D230F05002
        5FA2168B781989000059711C7EA9694170A0DD92AFC54B128265E27F0C7F2408
        5CA734CCDD4041EE4455858661A04C2964DBC692E3E0A92C137D6323FF796CEC
        BF043EFC6AA19FC6C7BD5FE9347ED4EB2853CAA5F5F52089101AFE67A11F13A6
        E9ADE8FA75C98CAB69617E979F6CB6A7C77FE70F6BB5196D70F0664F7E2E95F2
        7B44DBCE3FEBED0D3DC183794982DED18164ADC6FBD2E9C5DDFDFD9B3DEFDFED
        ED91055DC794656199908B4B12EA45FA61A544223BAD2881D34E2B4AC18CC76F
        05BFCFDDCA6FE813D275370C23920000000049454E44AE426082}
      Rounded = True
      Spacing = 0
      TabOrder = 10
      OnClick = btCancelaTitClick
      Appearance.BorderColor = 2412287
      Appearance.BorderColorHot = 50943
      Appearance.BorderColorCheckedHot = 50175
      Appearance.BorderColorDown = 46826
      Appearance.BorderColorChecked = 50175
      Appearance.BorderColorDisabled = 50175
      Appearance.BorderColorFocused = 50175
      Appearance.Color = 11792127
      Appearance.ColorTo = 50175
      Appearance.ColorChecked = 50175
      Appearance.ColorCheckedTo = 50175
      Appearance.ColorDisabled = 50175
      Appearance.ColorDisabledTo = 50175
      Appearance.ColorDown = 50175
      Appearance.ColorDownTo = 50175
      Appearance.ColorHot = 1887487
      Appearance.ColorHotTo = 1887487
      Appearance.ColorMirror = 50175
      Appearance.ColorMirrorTo = 50175
      Appearance.ColorMirrorHot = 1887487
      Appearance.ColorMirrorHotTo = 1887487
      Appearance.ColorMirrorDown = 50175
      Appearance.ColorMirrorDownTo = 50175
      Appearance.ColorMirrorChecked = 50175
      Appearance.ColorMirrorCheckedTo = 50175
      Appearance.ColorMirrorDisabled = 50175
      Appearance.ColorMirrorDisabledTo = 50175
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3750459
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 2303013
      Appearance.TextColorDisabled = 9211020
    end
    object btIncluiTit: TAdvGlowButton
      AlignWithMargins = True
      Left = 846
      Top = 24
      Width = 109
      Height = 25
      Cursor = crHandPoint
      Hint = 'Quantidade do produto do lote.'
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 6
      Caption = 'Incluir'
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
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
        00097048597300000B1100000B11017F645F910000018769545874584D4C3A63
        6F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E
        3D27EFBBBF272069643D2757354D304D7043656869487A7265537A4E54637A6B
        633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D2261646F62
        653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A7264663D22
        687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D726466
        2D73796E7461782D6E7323223E3C7264663A4465736372697074696F6E207264
        663A61626F75743D22757569643A66616635626464352D626133642D31316461
        2D616433312D6433336437353138326631622220786D6C6E733A746966663D22
        687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E302F223E3C
        746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269656E7461
        74696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264663A524446
        3E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E643D277727
        3F3E2C94980B0000009549444154384FBD91310AC24014445F6C047309ADD22C
        68F03AD3792EBBBD8E85B04D2A4FA1902A161AF8F984259AE883CF0E3BC3EC2E
        0B3FA496D449EA8083377B567EE35372051BA34BA307E40A26B15841008E6E2A
        93AB46FC0050005B4937139E4C8C7137FB09C57B0DC0DA797B49675E279D80AB
        F35B20F53748C0C54D63C2CD889F58F217BE2657F030FA6EF4805CC17F780279
        321DC01497E8EB0000000049454E44AE426082}
      Rounded = True
      Spacing = 3
      TabOrder = 11
      OnClick = btIncluiTitClick
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
  end
  object PanelRodTit: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 403
    Width = 995
    Height = 30
    Margins.Left = 1
    Margins.Top = 2
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alBottom
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 15130077
    Bevel.BorderWidth = 1
    Color = 15790320
    TabOrder = 1
    object edVlrTotTit: TLMDDBLabeledEdit
      AlignWithMargins = True
      Left = 901
      Top = 4
      Width = 88
      Height = 24
      Margins.Left = 5
      Margins.Right = 5
      Margins.Bottom = 1
      Align = alRight
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = 14280447
      Ctl3D = True
      Enabled = False
      ParentCtl3D = False
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      LabelPosition = lpLeft
      LabelSpacing = 4
      LabelSync = True
      EditLabel.Width = 116
      EditLabel.Height = 24
      EditLabel.AutoSize = False
      EditLabel.Color = clBlack
      EditLabel.Enabled = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clBlack
      EditLabel.Font.Height = -12
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'TOTAL DOS T'#205'TULOS'
    end
    object btRateios: TAdvGlowButton
      Tag = 1
      AlignWithMargins = True
      Left = 4
      Top = 3
      Width = 189
      Height = 24
      Cursor = crHandPoint
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alLeft
      Caption = 'Ratear Valores do T'#237'tulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5197647
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
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
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000027349
        444154388D7D934F6B545910C57F756F4783300B3B2BED103B0F154174E54688
        F03ADDF8C04076F900C38020339BD16C4514DC8822884198F1CFC26F204A6CE8
        BCBEB4BD9A2C675693C16E31C230300644C4F4F5DE72F35E6C2558AB4B714EDD
        AA53A7A4D1680C803A5FE283F77EBADFEF6F8DE5C8B2AC3A1A8D5E03FBC6D243
        03D48C3167430827816D11B9F72D19A0DD6EBF15917BC0B6AA9E30C69C056A06
        2084B0D5EBF5FE54D547AABAD46AB5128066B339D56C36A7005AAD56A2AA4BAA
        FAC839F75708610B401A8DC60840551FA469FAB3736E45441681D1D86843608F
        AA3E19C3FC0450013E8AC86FC092736EA500FC03BC51D557D65A8931CE00B534
        4D6F17E47322724755CF1BEFFDA13CCF97ADB50D115974CEFDEA9CBB658C5937
        C6DC57D5DF2B95CA1FCEB95BBD5EEFA2882C5A6B1B799E2F7BEF0F9952B04EA7
        3328DADE2C46BA22222F45E4EF18E3658018E326B0DDE9745E02F4FBFD2D53AA
        9CA6E91450B7D6768A026F54F5A8AA6E88C8C302D601664B614B0D00B0D66A8C
        71676D22F25C552B22B21063FC04BCD821552A5ABE773A585B5BFB1F1886105A
        45EA471149800DE060916B018376BBFD76A7409665D572CFC01E60BAE8E81A70
        0C381242B85AE06BC0DED227599655EDCCCCCC7F49924CC5186FA8EAD3344D2F
        1B632E85107E50D5C7D6DA27C0F17ABD9EA5697A7B381C1E56D5EB49924C8710
        1E7FCF48DBC06CF1F300D8BB9B914A0D4E3BE72E9426B1D69EE976BB89F7BEEA
        BDAF76BBDDC45A7B4644CE39E7569C731780D35058D918B3E0BDFFD75ABB2E22
        77F33C5F6697989F9FBFA9AABFA8EA296BED8118E333D9E59CDF4F4E4ED65657
        57DF8D93E7E6E6F64F4C4C6CF2F5390F3E033A313F8539DDFA7C000000004945
        4E44AE426082}
      Rounded = False
      Spacing = 1
      TabOrder = 1
      OnClick = btRateiosClick
      Appearance.BorderColor = 7709439
      Appearance.BorderColorHot = 7709439
      Appearance.BorderColorCheckedHot = 7709439
      Appearance.BorderColorDown = 7709439
      Appearance.BorderColorChecked = 7709439
      Appearance.BorderColorDisabled = 7709439
      Appearance.BorderColorFocused = 7709439
      Appearance.Color = 12308991
      Appearance.ColorTo = 12308991
      Appearance.ColorChecked = 12308991
      Appearance.ColorCheckedTo = 12308991
      Appearance.ColorDisabled = 12308991
      Appearance.ColorDisabledTo = 12308991
      Appearance.ColorDown = 12308991
      Appearance.ColorDownTo = 12308991
      Appearance.ColorHot = 12308991
      Appearance.ColorHotTo = 12308991
      Appearance.ColorMirror = 12308991
      Appearance.ColorMirrorTo = 12308991
      Appearance.ColorMirrorHot = 12308991
      Appearance.ColorMirrorHotTo = 12308991
      Appearance.ColorMirrorDown = 12308991
      Appearance.ColorMirrorDownTo = 12308991
      Appearance.ColorMirrorChecked = 12308991
      Appearance.ColorMirrorCheckedTo = 12308991
      Appearance.ColorMirrorDisabled = 12308991
      Appearance.ColorMirrorDisabledTo = 12308991
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
  object LMDSimplePanel1: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 995
    Height = 24
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 2
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 15130077
    Bevel.BorderWidth = 1
    Color = 15790320
    TabOrder = 2
    object LMDLabel1: TLMDLabel
      Left = 406
      Top = 4
      Width = 186
      Height = 17
      Alignment = agCenterRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7561559
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'ENTRADA DE T'#205'TULOS '#192' PAGAR'
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 973
      Top = 2
      Width = 20
      Height = 19
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 2
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
      Appearance.BorderColor = 15790320
      Appearance.BorderColorHot = 15790320
      Appearance.BorderColorCheckedHot = 15790320
      Appearance.BorderColorDown = 15790320
      Appearance.BorderColorChecked = 15790320
      Appearance.BorderColorDisabled = 15790320
      Appearance.BorderColorFocused = 15790320
      Appearance.Color = 15790320
      Appearance.ColorTo = 15790320
      Appearance.ColorChecked = 15790320
      Appearance.ColorCheckedTo = 15790320
      Appearance.ColorDisabled = 15790320
      Appearance.ColorDisabledTo = 15790320
      Appearance.ColorDown = 15790320
      Appearance.ColorDownTo = 15790320
      Appearance.ColorHot = 15790320
      Appearance.ColorHotTo = 15790320
      Appearance.ColorMirror = 15790320
      Appearance.ColorMirrorTo = 15790320
      Appearance.ColorMirrorHot = 15790320
      Appearance.ColorMirrorHotTo = 15790320
      Appearance.ColorMirrorDown = 15790320
      Appearance.ColorMirrorDownTo = 15790320
      Appearance.ColorMirrorChecked = 15790320
      Appearance.ColorMirrorCheckedTo = 15790320
      Appearance.ColorMirrorDisabled = 15790320
      Appearance.ColorMirrorDisabledTo = 15790320
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
  object LMDSimplePanel3: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 182
    Width = 995
    Height = 218
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 15130077
    Bevel.BorderWidth = 1
    Color = clWhite
    TabOrder = 3
    object dgTitulos: TDBGrid
      Tag = 1
      Left = 1
      Top = 1
      Width = 993
      Height = 216
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouTitulo
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -12
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnCellClick = dgTitulosCellClick
      OnDrawColumnCell = dgTitulosDrawColumnCell
      OnEnter = dgTitulosEnter
      OnExit = dgTitulosExit
      OnKeyDown = dgTitulosKeyDown
      OnMouseUp = dgTitulosMouseUp
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Nrotit'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'DOCUMENTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 109
          Visible = True
        end
        item
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
          Width = 26
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Datemi'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'EMISS'#195'O'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Datven'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'VENCE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrAces'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'DES.ACESS.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DesAsso'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'DESC.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorJuros'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'VL.JUROS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PercenJuros'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = '% JUR.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorMulta'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'VL.MULTA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PercenMulta'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = '% MUL.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Vlrtit'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'VALOR'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SalTitCalc'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'SALDO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NossoNro'
          Title.Caption = 'NOSSO N'#218'MERO'
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
          FieldName = 'CodBarra'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 191
          Visible = True
        end>
    end
  end
  object TabTitulo: TRESTDWClientSQL
    Active = False
    OnCalcFields = TabTituloCalcFields
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
    Params = <
      item
        DataType = ftInteger
        Name = 'IDPess'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NotFis'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NroSerie'
        ParamType = ptInput
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      
        'SELECT TIT.*,PES.Nompes,FIL.Nomfil,TIP.DesTiptit,NAT.Desnat FROM' +
        ' arqtitulotemp TIT '
      'LEFT JOIN arqtiptitu TIP ON TIT.IDTiptit = TIP.IDTiptit '
      'LEFT JOIN arqnatfin NAT ON TIT.IDNatFin = NAT.IDNatFin '
      'LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '
      'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '
      
        'WHERE TIT.IDPess = :IDPess  AND TIT.NotFis = :NotFis  AND TIT.Nr' +
        'oSerie = :NroSerie')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 78
    Top = 222
    object TabTituloIDTitu: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDTitu'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituloIDPess: TIntegerField
      FieldName = 'IDPess'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituloNotFis: TIntegerField
      FieldName = 'NotFis'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituloNroSerie: TIntegerField
      FieldName = 'NroSerie'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituloNrotit: TWideStringField
      FieldName = 'Nrotit'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabTituloDestit: TWideStringField
      FieldName = 'Destit'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 3
    end
    object TabTituloPagRec: TWideStringField
      FieldName = 'PagRec'
      Size = 1
    end
    object TabTituloIDTiptit: TIntegerField
      FieldName = 'IDTiptit'
    end
    object TabTituloDatemi: TDateField
      FieldName = 'Datemi'
    end
    object TabTituloDatven: TDateField
      FieldName = 'Datven'
    end
    object TabTituloDesAsso: TFloatField
      FieldName = 'DesAsso'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituloVlrAces: TFloatField
      FieldName = 'VlrAces'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituloVlrDevo: TFloatField
      FieldName = 'VlrDevo'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituloVlrtit: TFloatField
      FieldName = 'Vlrtit'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituloSaltit: TFloatField
      FieldName = 'Saltit'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituloHistit: TWideStringField
      FieldName = 'Histit'
      Size = 120
    end
    object TabTituloIDFilial: TIntegerField
      FieldName = 'IDFilial'
    end
    object TabTituloIDPed: TIntegerField
      FieldName = 'IDPed'
    end
    object TabTituloIDNatFin: TIntegerField
      FieldName = 'IDNatFin'
    end
    object TabTituloIDConv: TIntegerField
      FieldName = 'IDConv'
    end
    object TabTituloCodBarra: TWideStringField
      FieldName = 'CodBarra'
      Size = 48
    end
    object TabTituloIndSel: TWideStringField
      FieldName = 'IndSel'
      Size = 1
    end
    object TabTituloIndEnvBco: TWideStringField
      FieldName = 'IndEnvBco'
      Size = 1
    end
    object TabTituloNossoNro: TWideStringField
      FieldName = 'NossoNro'
    end
    object TabTituloCodRec: TIntegerField
      FieldName = 'CodRec'
    end
    object TabTituloNumReferencia: TWideStringField
      FieldName = 'NumReferencia'
    end
    object TabTituloDatCompApur: TDateField
      FieldName = 'DatCompApur'
    end
    object TabTituloValorJuros: TFloatField
      FieldName = 'ValorJuros'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituloValorMulta: TFloatField
      FieldName = 'ValorMulta'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituloPercenJuros: TFloatField
      FieldName = 'PercenJuros'
      DisplayFormat = '##0.00'
    end
    object TabTituloPercenMulta: TFloatField
      FieldName = 'PercenMulta'
      DisplayFormat = '##0.00'
    end
    object TabTituloChavePIXQRCode: TWideStringField
      FieldName = 'ChavePIXQRCode'
      Size = 300
    end
    object TabTituloAgBenef: TLargeintField
      FieldName = 'AgBenef'
    end
    object TabTituloNumEnvBco: TIntegerField
      FieldName = 'NumEnvBco'
    end
    object TabTituloNompes: TWideStringField
      FieldName = 'Nompes'
      Size = 80
    end
    object TabTituloNomfil: TWideStringField
      FieldName = 'Nomfil'
      Size = 45
    end
    object TabTituloDesTiptit: TWideStringField
      FieldName = 'DesTiptit'
      Size = 50
    end
    object TabTituloDesnat: TWideStringField
      FieldName = 'Desnat'
      Size = 40
    end
    object TabTituloSalTitCalc: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SalTitCalc'
      DisplayFormat = '###,###,##0.00'
      Calculated = True
    end
  end
  object SouTitulo: TDataSource
    DataSet = TabTitulo
    Left = 76
    Top = 294
  end
end
