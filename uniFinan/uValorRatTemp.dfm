object FrmVlrRatTemp: TFrmVlrRatTemp
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'FrmVlrRatTemp'
  ClientHeight = 411
  ClientWidth = 427
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object PanelBack: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 427
    Height = 411
    Margins.Left = 0
    Margins.Top = 2
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 8158332
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 16316664
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object PanelRatNatFixo: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 27
      Width = 425
      Height = 313
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 13553358
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Color = 15921906
      TabOrder = 3
      object Shape3: TShape
        Left = 0
        Top = 312
        Width = 425
        Height = 1
        Align = alBottom
        Pen.Color = 13553358
        ExplicitLeft = 116
        ExplicitTop = 91
        ExplicitWidth = 124
      end
      object DBGrid2: TDBGrid
        AlignWithMargins = True
        Left = 0
        Top = 4
        Width = 425
        Height = 308
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = SouNatFin
        DrawingStyle = gdsGradient
        FixedColor = 16447736
        GradientEndColor = 16447736
        GradientStartColor = 16447736
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid2DrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'Desnat'
            Title.Caption = 'NATUREZA FINANCEIRA'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 304
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorRat'
            Title.Alignment = taCenter
            Title.Caption = 'VALOR'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end>
      end
    end
    object PanelRod: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 340
      Width = 425
      Height = 32
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 16316664
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 14149375
      TabOrder = 0
      object Label35: TLabel
        AlignWithMargins = True
        Left = 273
        Top = 10
        Width = 41
        Height = 16
        Margins.Top = 9
        Margins.Right = 4
        Margins.Bottom = 5
        Align = alRight
        Alignment = taCenter
        Caption = 'SALDO'
        Color = 14149375
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clAppWorkSpace
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitHeight = 15
      end
      object edTotPer: TCurrencyEdit
        AlignWithMargins = True
        Left = 321
        Top = 5
        Width = 99
        Height = 24
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabStop = False
        Align = alRight
        AutoSelect = False
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4802889
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object PanelButtons: TLMDSimplePanel
      Left = 1
      Top = 373
      Width = 425
      Height = 37
      Align = alBottom
      Color = 16382975
      TabOrder = 2
      object btRatFin: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 92
        Top = 3
        Width = 241
        Height = 31
        Cursor = crHandPoint
        Caption = 'Rateio Natureza Financeira Fixa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5131854
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
        Rounded = True
        Spacing = 3
        TabOrder = 0
        OnClick = btRatFinClick
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
    object PanelCab: TLMDSimplePanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 419
      Height = 20
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 16579836
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 16316664
      TabOrder = 4
      object lbTitulo: TLMDLabel
        AlignWithMargins = True
        Left = 6
        Top = 4
        Width = 235
        Height = 12
        Margins.Left = 5
        Align = alLeft
        Alignment = agCenterLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -14
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Rateio Natureza Financeira'
        ExplicitLeft = 5
        ExplicitTop = 3
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 400
        Top = 1
        Width = 17
        Height = 17
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 1
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
          89504E470D0A1A0A0000000D49484452000000100000001010060000004F6323
          22000000206348524D00007A26000080840000FA00000080E8000075300000EA
          6000003A98000017709CBA513C00000006624B4744000000000000F943BB7F00
          00000970485973000000600000006000F06B42CF0000000774494D4507E70913
          00162241D1EFA9000002864944415448C7CD95DD4B937114C7BFE759BAD956D0
          457706D36EC2B78B28949ACF93896DB34D2FA27F20F2AAAE02378B422AA8D4A0
          8BD5BF20844A88315CD4D2F94646C448843421A45B91706E33F3F976319F4DF6
          3436B48BCEEDC3CEE773CEF99D33E07F0B32B0A4B1A989ECE971B9AAAB0F9E2F
          9387FA9D068D7575F9DF957C3020C7D13B3B0B3064D98AC7A907DF35AFABEA3E
          0AB97521D1DA0AF08C455D5880EC34E27D3C4E068FB5DCADAD3509809C66DBDA
          1A8006A8A914809B38EC7000589143E130D9BDD862D1B4D2C1728E8FC6C6007C
          C44C45058041049349105DBFB48D0D93802803D7626F979741FD3A1B3D1E00CF
          914C242058119FDD0E286E3D120EE7007960A35394533A4747B360E2245F6F6E
          024860DEEF17A5AF7FA66D7535CB2D5889DE7D5FDD686E8628FD72311CDED391
          41DC4B26015E95A68E0E502EEF6C6F6F1B9DCA0A1B604197387C3E913E999489
          897C4E41811244226249A701A9601200A8C26AB3950A2E59C02C224E791C8900
          B2B83B5B23550C5BE934C059CC79BDC5C0E647583414177F8B00F20C51F98B38
          5F50B55800F4C8B2DD5E72D6E29567D7303363C00DABCD0620B25B710DCEA752
          005ECA87B2320097F4132323D4BB7F68F4F9F62D6002E73F2EE033E6BC5E90DF
          79DBED86B135C01BF158AD10E52BD3C3C3D483AFB41ABFBF6481A2E0BCC725CA
          406FECC8D414A807186D6F378B20845061913D9770F74209D69581F1F1DCFE67
          137E1387C753709D0C11C8692E757622BBAE388B07E5E5101CE5A7A121EAC180
          1AAAAF377780FA17FD61551572972B03266E60DEEB15A5AF7F52A6A78BCD54E4
          C954EC67340A889357FCFE3D22464766E46965A579E6CCFCDC38B964901A9DCE
          62C06291FB330A0634BA5C07CDF7CFE30F28D475C76F6FFE520000000049454E
          44AE426082}
        MarginVert = 0
        MarginHorz = 0
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
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
        Spacing = 3
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = btFecharClick
        Appearance.BorderColor = 16579836
        Appearance.BorderColorHot = 16579836
        Appearance.BorderColorCheckedHot = 16579836
        Appearance.BorderColorDown = 16579836
        Appearance.BorderColorChecked = 16579836
        Appearance.BorderColorDisabled = 16579836
        Appearance.BorderColorFocused = 16579836
        Appearance.Color = 16579836
        Appearance.ColorTo = 16579836
        Appearance.ColorChecked = 16579836
        Appearance.ColorCheckedTo = 16579836
        Appearance.ColorDisabled = 16579836
        Appearance.ColorDisabledTo = 16579836
        Appearance.ColorDown = 16579836
        Appearance.ColorDownTo = 16579836
        Appearance.ColorHot = 16579836
        Appearance.ColorHotTo = 16579836
        Appearance.ColorMirror = 16579836
        Appearance.ColorMirrorTo = 16579836
        Appearance.ColorMirrorHot = 16579836
        Appearance.ColorMirrorHotTo = 16579836
        Appearance.ColorMirrorDown = 16579836
        Appearance.ColorMirrorDownTo = 16579836
        Appearance.ColorMirrorChecked = 16579836
        Appearance.ColorMirrorCheckedTo = 16579836
        Appearance.ColorMirrorDisabled = 16579836
        Appearance.ColorMirrorDisabledTo = 16579836
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
    object PanelRatNatFin: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 27
      Width = 425
      Height = 313
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 13553358
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Color = 16382975
      TabOrder = 1
      object Shape2: TShape
        Left = 0
        Top = 312
        Width = 425
        Height = 1
        Align = alBottom
        Pen.Color = 13553358
        ExplicitLeft = 116
        ExplicitTop = 91
        ExplicitWidth = 124
      end
      object LMDSimplePanel1: TLMDSimplePanel
        Left = 0
        Top = 0
        Width = 425
        Height = 96
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13553358
        Bevel.BorderSides = [fsLeft, fsRight, fsTop]
        Color = 16382975
        TabOrder = 0
        object Shape1: TShape
          Left = 0
          Top = 95
          Width = 425
          Height = 1
          Align = alBottom
          Pen.Color = 13553358
          ExplicitLeft = 116
          ExplicitTop = 91
          ExplicitWidth = 124
        end
        object edNatFin: TLMDLabeledEdit
          Left = 13
          Top = 24
          Width = 296
          Height = 23
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 15130077
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          TabOrder = 0
          OnKeyDown = edNatFinKeyDown
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3617579
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
              OnClick = edNatFinCustomButtons0Click
              UsePngGlyph = True
            end>
          PasswordChar = #0
          Spelling.LiveSpell = True
          TabOnEnter = True
          Text = ''
          LabelSpacing = 2
          EditLabel.Width = 122
          EditLabel.Height = 15
          EditLabel.Color = clBlack
          EditLabel.Enabled = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 8811110
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          EditLabel.Caption = 'NATUREZA FINANCEIRA'
        end
        object edVlrRateio: TLMDLabeledMaskEdit
          Left = 315
          Top = 24
          Width = 98
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 15130077
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Enabled = False
          ParentThemeMode = False
          TabOrder = 1
          ThemeMode = ttmNative
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
          LabelSpacing = 2
          EditLabel.Width = 69
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Color = clWhite
          EditLabel.Enabled = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 8811110
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          EditLabel.Caption = 'QUANTIDADE'
          Value = 0.000000000000000000
        end
        object btIncluir: TAdvGlowButton
          AlignWithMargins = True
          Left = 13
          Top = 57
          Width = 92
          Height = 28
          Cursor = crHandPoint
          Margins.Top = 0
          Margins.Right = 8
          Margins.Bottom = 0
          Caption = 'Novo'
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
            89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
            A9000000206348524D00007A26000080840000FA00000080E8000075300000EA
            6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
            485973000000600000006000F06B42CF0000000774494D4507E70802140117DC
            0BBDFA000000EA4944415438CBC5933B0AC2401445EFC4A4B410ADD3650D621B
            45F103B6EE40C8C82CC12CC14234B8035BC10F8ABDB885D1CE3EB682669E8536
            EA0CA820DEEAC2BB1CDE87C76090885DF712AFD70040996231CA1E0EBA9C6D02
            24AD7A9D799E07006CD7680051A4CB592600368EA3F56F03DED4FF01B6885D37
            1996CB685B8FB085EF637BF703DFE7D5D3E9A13E522A15AC562CD84BC97AB76D
            7FACA39416EB127DDD7F4864AB7EA9644595CAEB08B51AB6CD2600203F99A03A
            9F3F8FA072CBA511CED342704EC439114F0B61CAFDFF8C3F0414CE67AD7F92F1
            1B53E3D92CE948899048E5A65364F5B92B4C674F3CED4A6AC10000000049454E
            44AE426082}
          Rounded = True
          Spacing = 3
          TabOrder = 2
          OnClick = btIncluirClick
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
        object btCancelar: TAdvGlowButton
          AlignWithMargins = True
          Left = 112
          Top = 57
          Width = 91
          Height = 28
          Cursor = crHandPoint
          Margins.Top = 0
          Margins.Right = 8
          Margins.Bottom = 0
          Caption = 'Cancelar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5723991
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
          TabOrder = 3
          OnClick = btCancelarClick
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
          Enabled = False
        end
        object btExcluir: TAdvGlowButton
          AlignWithMargins = True
          Left = 210
          Top = 57
          Width = 98
          Height = 28
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Caption = 'Excluir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5723991
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
            61000000097048597300000B1300000B1301009A9C18000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000000794944415478DAD493CB0DC4200C05A7106EA981327C8C5E1DE984
            8EDF5E1605413E68578A144B237C80B11118DBFCC39E8CB1497205D8FA0DBD60
            6D0FDC01ACBD20497229E596AF200D57A802209D90AB401297825AA55F9F1344
            846D131106F2F31DBC5F90DBB76F9912CCFCC44301B04CCEC132087EE5330028
            FDD803B9FFB6D80000000049454E44AE426082}
          Rounded = True
          TabOrder = 4
          OnClick = btExcluirClick
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
        object btConfirmar: TAdvGlowButton
          AlignWithMargins = True
          Left = 315
          Top = 57
          Width = 98
          Height = 28
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 6
          Caption = 'Confirmar'
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
            610000000473424954080808087C086488000000017352474200AECE1CE90000
            000467414D410000B18F0BFC6105000000097048597300000074000000740131
            85E5810000001974455874536F667477617265007777772E696E6B7363617065
            2E6F72679BEE3C1A0000018769545874584D4C3A636F6D2E61646F62652E786D
            7000000000003C3F787061636B657420626567696E3D27EFBBBF272069643D27
            57354D304D7043656869487A7265537A4E54637A6B633964273F3E0D0A3C783A
            786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F22
            3E3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E
            77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E7323
            223E3C7264663A4465736372697074696F6E207264663A61626F75743D227575
            69643A66616635626464352D626133642D313164612D616433312D6433336437
            353138326631622220786D6C6E733A746966663D22687474703A2F2F6E732E61
            646F62652E636F6D2F746966662F312E302F223E3C746966663A4F7269656E74
            6174696F6E3E313C2F746966663A4F7269656E746174696F6E3E3C2F7264663A
            4465736372697074696F6E3E3C2F7264663A5244463E3C2F783A786D706D6574
            613E0D0A3C3F787061636B657420656E643D2777273F3E2C94980B000000BA49
            444154384FD5924D0AC2301085BF36203D8582E2CE163CCEBB9607105DCD6DDC
            A82B17A2971041A88B26250DAD3F3BFD762F6F26339909FC2B4E520D2CF3D4F9
            00076C0024EDB2D47D8393F408C2CC16DF74E0807510665601C76EC8300ED84A
            AAFDDBCB6064FE00339B00D74E5A43DA76091C82CECD6C4533900B300E86A71D
            183DC900193092748F82A6C0B9A77205ECDB4C4FD8427AC95CD229D2BDC94417
            0014926E918681B663D27F90763258F91585DFCC2C357E9327B3E342CFDEC09E
            BF0000000049454E44AE426082}
          Rounded = True
          Spacing = 1
          TabOrder = 5
          OnClick = btConfirmarClick
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
          Enabled = False
        end
      end
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 1
        Top = 99
        Width = 423
        Height = 212
        Margins.Left = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = SouNatFin
        DrawingStyle = gdsGradient
        FixedColor = 16447736
        GradientEndColor = 16447736
        GradientStartColor = 16447736
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Roboto'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'Desnat'
            Title.Caption = 'NATUREZA FINANCEIRA'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 298
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorRat'
            Title.Alignment = taCenter
            Title.Caption = 'VALOR'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 99
            Visible = True
          end>
      end
    end
  end
  object TabRateio: TRESTDWClientSQL
    Active = False
    AfterOpen = TabRateioAfterOpen
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
    BinaryRequest = False
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT RAT.*,NAT.Desnat FROM arqtitulorattemp RAT'
      'LEFT JOIN arqnatfin NAT ON RAT.IDNatFin = NAT.IDNatfin LIMIT 1;'
      '')
    UpdateTableName = 'arqnatfin'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 455
    Top = 682
    object TabRateioIDTitu: TLongWordField
      FieldName = 'IDTitu'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabRateioIDNatFin: TIntegerField
      FieldName = 'IDNatFin'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabRateioRatFixo: TWideStringField
      FieldName = 'RatFixo'
      Size = 1
    end
    object TabRateioValorRat: TFloatField
      FieldName = 'ValorRat'
      DisplayFormat = '###,###,##0.00'
    end
    object TabRateioDesnat: TWideStringField
      FieldName = 'Desnat'
      Size = 40
    end
  end
  object SouNatFin: TDataSource
    AutoEdit = False
    DataSet = TabRateio
    Left = 503
    Top = 682
  end
end
