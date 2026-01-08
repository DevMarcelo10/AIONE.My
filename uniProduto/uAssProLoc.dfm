object FrmAssProLoc: TFrmAssProLoc
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Associa Produtos Local Estoque'
  ClientHeight = 235
  ClientWidth = 461
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelBase: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 461
    Height = 235
    Margins.Left = 0
    Margins.Top = 0
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
      AlignWithMargins = True
      Left = 1
      Top = 27
      Width = 459
      Height = 167
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alClient
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15263976
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = clWhitesmoke
      TabOrder = 0
      object LMDLabel4: TLMDLabel
        Left = 13
        Top = 8
        Width = 66
        Height = 15
        Alignment = agCenterRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6381921
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'FABRICANTE'
      end
      object LMDLabel2: TLMDLabel
        Left = 244
        Top = 60
        Width = 64
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6381921
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'SUB GRUPO'
      end
      object LMDLabel7: TLMDLabel
        Left = 13
        Top = 60
        Width = 39
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6381921
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'GRUPO'
      end
      object LMDLabel11: TLMDLabel
        Left = 14
        Top = 111
        Width = 177
        Height = 15
        Alignment = agBottomRight
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6381921
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'PRODUTOS QUE TENHA NO NOME'
      end
      object edSubGru: TLMDLabeledEdit
        Left = 244
        Top = 78
        Width = 197
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 2
        OnKeyDown = edSubGruKeyDown
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
            OnClick = edSubGruCustomButtons0Click
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
      object edPessoa: TLMDLabeledEdit
        Left = 14
        Top = 26
        Width = 427
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
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 49
        EditLabel.Height = 16
        EditLabel.Caption = 'edBusca'
      end
      object edGrupo: TLMDLabeledEdit
        Left = 14
        Top = 78
        Width = 221
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 1
        OnKeyDown = edGrupoKeyDown
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
            OnClick = edGrupoCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 48
        EditLabel.Height = 16
        EditLabel.Caption = 'edGrupo'
      end
      object edDespro: TLMDEdit
        Left = 14
        Top = 130
        Width = 427
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        MaxLength = 65
        ParentFont = False
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
      Width = 459
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14145495
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15263976
      TabOrder = 1
      object LMDLabel1: TLMDLabel
        Left = 167
        Top = 4
        Width = 125
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 33785
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = 'ASSOCIA PRODUTOS'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 437
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
    object PanelBottom: TLMDSimplePanel
      Left = 1
      Top = 197
      Width = 459
      Height = 37
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14342874
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15263976
      TabOrder = 2
      object btSalvar: TAdvGlowButton
        AlignWithMargins = True
        Left = 156
        Top = 7
        Width = 147
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Associar Produtos'
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
        Spacing = 0
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
    end
  end
end
