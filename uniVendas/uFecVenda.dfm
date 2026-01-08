object FrmFecVenda: TFrmFecVenda
  Left = 0
  Top = 0
  Margins.Top = 8
  ActiveControl = edNrCesta
  BorderStyle = bsNone
  Caption = 'VENDAS - Fecha Venda'
  ClientHeight = 549
  ClientWidth = 358
  Color = 10329501
  TransparentColorValue = clNone
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 14
  object PanelTop: TLMDSimplePanel
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 354
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 15461355
    TabOrder = 0
    DesignSize = (
      354
      27)
    object lbTitulo: TLMDLabel
      AlignWithMargins = True
      Left = 4
      Top = 6
      Width = 346
      Height = 17
      Margins.Top = 5
      Align = alClient
      Alignment = agCenter
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 19967
      Font.Height = -15
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'FECHA VENDA'
      ExplicitLeft = -148
      ExplicitTop = 7
      ExplicitWidth = 806
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 331
      Top = 5
      Width = 20
      Height = 18
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Bottom = 6
      Anchors = [akTop, akRight]
      AntiAlias = aaAntiAlias
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
      NotesFont.Height = -12
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
      Rounded = False
      Spacing = 3
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = btFecharClick
      Appearance.BorderColor = 15461355
      Appearance.BorderColorHot = 15461355
      Appearance.BorderColorCheckedHot = 15461355
      Appearance.BorderColorDown = 15461355
      Appearance.BorderColorChecked = 15461355
      Appearance.BorderColorDisabled = 15461355
      Appearance.BorderColorFocused = 15461355
      Appearance.Color = 15461355
      Appearance.ColorTo = 15461355
      Appearance.ColorChecked = 15461355
      Appearance.ColorCheckedTo = 15461355
      Appearance.ColorDisabled = 15461355
      Appearance.ColorDisabledTo = 15461355
      Appearance.ColorDown = 15461355
      Appearance.ColorDownTo = 15461355
      Appearance.ColorHot = 15461355
      Appearance.ColorHotTo = 15461355
      Appearance.ColorMirror = 15461355
      Appearance.ColorMirrorTo = 15461355
      Appearance.ColorMirrorHot = 15461355
      Appearance.ColorMirrorHotTo = 15461355
      Appearance.ColorMirrorDown = 15461355
      Appearance.ColorMirrorDownTo = 15461355
      Appearance.ColorMirrorChecked = 15461355
      Appearance.ColorMirrorCheckedTo = 15461355
      Appearance.ColorMirrorDisabled = 15461355
      Appearance.ColorMirrorDisabledTo = 15461355
      Appearance.TextColorChecked = 3191038
      Appearance.TextColorHot = 15234048
      Appearance.TextColorDisabled = 3191038
    end
  end
  object pnGeral: TLMDSimplePanel
    AlignWithMargins = True
    Left = 2
    Top = 29
    Width = 354
    Height = 519
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 1
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 14671839
    Bevel.BorderWidth = 1
    Color = 16250100
    TabOrder = 1
    object pnCesta: TLMDSimplePanel
      Left = 1
      Top = 1
      Width = 352
      Height = 64
      Align = alTop
      Color = 15397375
      TabOrder = 2
      object lbNrCesta: TLMDLabel
        Left = 10
        Top = 11
        Width = 331
        Height = 16
        Alignment = agCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'N'#218'MERO DA CESTA'
      end
      object edNrCesta: TLMDEdit
        Left = 10
        Top = 31
        Width = 331
        Height = 25
        Caret.BlinkRate = 530
        TabOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2434341
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
      end
    end
    object pnEntrega: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 435
      Width = 352
      Height = 37
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15129563
      Bevel.BorderWidth = 1
      Color = clWhite
      TabOrder = 0
      DesignSize = (
        352
        37)
      object chEnviarEntrega: TLMDDBCheckBox
        Left = 11
        Top = 11
        Width = 331
        Height = 21
        Caption = ' ENVIAR P/ ENTREGA'
        Alignment.Alignment = agTopRight
        Alignment.Spacing = 4
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2367260
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        ValueChecked = #39'1'#39
        ValueUnchecked = #39'0'#39
      end
    end
    object pnBotaoFinalizar: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 472
      Width = 352
      Height = 46
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15129563
      Color = 16250100
      TabOrder = 1
      object btFinalizar: TAdvGlowButton
        AlignWithMargins = True
        Left = 96
        Top = 10
        Width = 161
        Height = 27
        Cursor = crHandPoint
        Margins.Top = 0
        Margins.Right = 14
        Margins.Bottom = 0
        Caption = 'Finalizar Venda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ModalResult = 2
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
        ShortCutHint = ' Ctrl+S '
        Spacing = 1
        TabOrder = 0
        TabStop = True
        OnClick = btFinalizarClick
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
    object pnFormasPagto: TLMDSimplePanel
      Left = 1
      Top = 169
      Width = 352
      Height = 264
      Align = alTop
      TabOrder = 3
      object pnFormaPagtoTotal: TLMDSimplePanel
        AlignWithMargins = True
        Left = 0
        Top = 224
        Width = 352
        Height = 40
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alBottom
        Color = 15397375
        TabOrder = 2
        object lbTotalApagar: TLMDLabel
          Left = 11
          Top = 11
          Width = 110
          Height = 16
          Alignment = agCenterRight
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 19967
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'TOTAL A PAGAR'
        end
        object edTotalApagar: TLMDMaskEdit
          Left = 143
          Top = 7
          Width = 209
          Height = 25
          Margins.Right = 5
          Caret.BlinkRate = 530
          TabOrder = 0
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -14
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          Alignment = taRightJustify
          CurrencySettings.SystemDefaults = cmUser
          CurrencySettings.PositiveFormatStr = ' 1,1'
          CurrencySettings.NegativeFormatStr = '- 1,1'
          CurrencySettings.Symbol = 'R$'
          CustomButtons = <>
          Decimals = 2
          MaskType = meCurrency
          ReadOnly = True
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
      end
      object LMDSimplePanel3: TLMDSimplePanel
        Left = 0
        Top = 24
        Width = 352
        Height = 200
        Align = alTop
        Color = clWhite
        TabOrder = 1
        object pnCupom: TLMDSimplePanel
          Tag = 9
          Left = 0
          Top = 175
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 7
          object lbDinheiro: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'CUPOM / VOUCHER'
          end
          object edCupom: TLMDMaskEdit
            Tag = 9
            Left = 143
            Top = 0
            Width = 209
            Height = 25
            Margins.Right = 5
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'com CUPOM / VOUCHER'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <>
            Decimals = 2
            MaskType = meCurrency
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
        end
        object pnPix: TLMDSimplePanel
          Tag = 7
          Left = 0
          Top = 150
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 6
          object LMDLabel1: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'PIX'
          end
          object edPix: TLMDMaskEdit
            Tag = 7
            Left = 143
            Top = 0
            Width = 209
            Height = 25
            Margins.Right = 5
            Align = alRight
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'com PIX'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <>
            Decimals = 2
            MaskType = meCurrency
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
        end
        object pnCartDigital: TLMDSimplePanel
          Tag = 6
          Left = 0
          Top = 125
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 5
          object LMDLabel2: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'CARTEIRA DIGITAL'
          end
          object edCartDigital: TLMDMaskEdit
            Tag = 6
            Left = 143
            Top = 0
            Width = 209
            Height = 25
            Margins.Right = 5
            Align = alRight
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'com CARTEIRA DIGITAL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <>
            Decimals = 2
            MaskType = meCurrency
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
        end
        object pnAprazo: TLMDSimplePanel
          Tag = 5
          Left = 0
          Top = 100
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 4
          object LMDLabel3: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'A PRAZO'
          end
          object edAprazo: TLMDMaskEdit
            Tag = 5
            Left = 207
            Top = 0
            Width = 145
            Height = 25
            Margins.Right = 5
            Align = alRight
            Caret.BlinkRate = 530
            TabOrder = 1
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'A PRAZO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <
              item
                Layout.OffsetX = 2
                ParentFont = False
                PngGlyph.Data = {
                  89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
                  F8000000097048597300000EC300000EC301C76FA864000000AD4944415478DA
                  EDD0BD0A84301004E04963A34D82606524B6BEFF9304DB444141414C934A0BEF
                  6E8B70D59183FB69324D6097EC07C3AE7BF0C5B0042420017F02966541966510
                  4284D9B66DF496651966FBBEE33C4F5455150F0CC380B66D51D735FABE475114
                  745C29457B6B2D21DE7B745D87699A608C41D33471C0388E043C3E68AD91E779
                  00186374EC1998E7996652CAF88AD675A58A38E72F2B72CEE1388EF72AFA7412
                  908004FC00B801EFECA1B94E4C14350000000049454E44AE426082}
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Segoe UI'
                Font.Style = []
                Index = 0
                DisplayName = 'TLMDSpecialButton'
                OnClick = edAprazoCustomButtons0Click
                UsePngGlyph = True
              end>
            Decimals = 2
            MaskType = meCurrency
            ReadOnly = True
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
          object edAprazoParc: TLMDSpinEdit
            Tag = 5
            Left = 143
            Top = 0
            Width = 65
            Height = 26
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnExit = edAprazoParcExit
            OnKeyDown = edDinheiroKeyDown
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            AutoSelect = True
            ParentFont = False
            CustomButtons = <>
            TabOnEnter = True
            Value = 0
          end
        end
        object pnCheque: TLMDSimplePanel
          Tag = 4
          Left = 0
          Top = 75
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 3
          object LMDLabel4: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'CHEQUE'
          end
          object edCheque: TLMDMaskEdit
            Tag = 4
            Left = 143
            Top = 0
            Width = 209
            Height = 25
            Margins.Right = 5
            Align = alRight
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'com CHEQUE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <>
            Decimals = 2
            MaskType = meCurrency
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
        end
        object pnCredito: TLMDSimplePanel
          Tag = 3
          Left = 0
          Top = 50
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 2
          object LMDLabel5: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'CART'#195'O DE CR'#201'DITO'
          end
          object edCredito: TLMDMaskEdit
            Tag = 3
            Left = 143
            Top = 0
            Width = 209
            Height = 25
            Margins.Right = 5
            Align = alRight
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'com CART'#195'O DE CR'#201'DITO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <>
            Decimals = 2
            MaskType = meCurrency
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
        end
        object pnDebito: TLMDSimplePanel
          Tag = 2
          Left = 0
          Top = 25
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 1
          object LMDLabel6: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'CART'#195'O DE D'#201'BITO'
          end
          object edDebito: TLMDMaskEdit
            Tag = 2
            Left = 143
            Top = 0
            Width = 209
            Height = 25
            Margins.Right = 5
            Align = alRight
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'com CART'#195'O DE D'#201'BITO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <>
            Decimals = 2
            MaskType = meCurrency
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
        end
        object pnDinheiro: TLMDSimplePanel
          Tag = 1
          Left = 0
          Top = 0
          Width = 352
          Height = 25
          HelpType = htKeyword
          Align = alTop
          Color = clWhite
          TabOrder = 0
          object LMDLabel7: TLMDLabel
            Left = 3
            Top = 6
            Width = 135
            Height = 16
            Alignment = agCenterRight
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2367260
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'DINHEIRO'
          end
          object edDinheiro: TLMDMaskEdit
            Tag = 1
            Left = 143
            Top = 0
            Width = 209
            Height = 25
            Margins.Right = 5
            Align = alRight
            Caret.BlinkRate = 530
            TabOrder = 0
            OnEnter = edDinheiroEnter
            OnKeyDown = edDinheiroKeyDown
            ValidationMsgString = 'a DINHEIRO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -14
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '- 1,1'
            CurrencySettings.Symbol = 'R$'
            CustomButtons = <>
            Decimals = 2
            MaskType = meCurrency
            TabOnEnter = True
            TimeSettings.AMSign = 'am'
            TimeSettings.PMSign = 'pm'
            TimeSettings.MSign = 'm'
            Value = 0.000000000000000000
          end
        end
      end
      object pnFormaPagtoCab: TLMDSimplePanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 352
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderSides = [fsLeft, fsRight, fsTop]
        Bevel.BorderWidth = 1
        Color = 15461355
        TabOrder = 0
        object lbFormaPagtoCab: TLMDLabel
          AlignWithMargins = True
          Left = 1
          Top = 4
          Width = 350
          Height = 16
          Margins.Left = 0
          Margins.Right = 0
          Bevel.BorderColor = 15129563
          Align = alClient
          Alignment = agCenter
          Color = 4159487
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 19967
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentColor = False
          ParentFont = False
          Caption = 'FORMAS DE PAGAMENTO'
          ExplicitLeft = 0
          ExplicitTop = 5
          ExplicitWidth = 143
        end
      end
    end
    object pnTotalPed: TLMDSimplePanel
      Left = 1
      Top = 65
      Width = 352
      Height = 104
      Align = alTop
      TabOrder = 4
      object LMDLabel8: TLMDLabel
        Left = 184
        Top = 42
        Width = 13
        Height = 16
        Alignment = agCenterRight
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2367260
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = '%'
      end
      object edTotalPedido: TLMDDBLabeledEdit
        Left = 145
        Top = 70
        Width = 140
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 15397375
        TabOrder = 0
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        CharCase = ecUpperCase
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        TabOnEnter = True
        DataField = 'TotPedido'
        DataSource = FrmVendas.SouPedido
        ReadOnly = True
        LabelPosition = lpLeft
        LabelSpacing = 12
        LabelSync = True
        EditLabel.Width = 85
        EditLabel.Height = 23
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = 2367260
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'TOTAL PEDIDO'
      end
      object edDescVlr: TLMDDBLabeledEdit
        Left = 204
        Top = 39
        Width = 80
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 15397375
        TabOrder = 1
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        TabOnEnter = True
        DataField = 'TotDesc'
        DataSource = FrmVendas.SouPedido
        ReadOnly = True
        LabelPosition = lpLeft
        LabelSync = True
        EditLabel.Width = 5
        EditLabel.Height = 23
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = 2367260
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = ' '
      end
      object edTotalBruto: TLMDDBLabeledEdit
        Left = 145
        Top = 8
        Width = 140
        Height = 25
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 15397375
        TabOrder = 2
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        CharCase = ecUpperCase
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        TabOnEnter = True
        DataField = 'TotBruCalc'
        DataSource = FrmVendas.SouPedido
        ReadOnly = True
        LabelPosition = lpLeft
        LabelSpacing = 12
        LabelSync = True
        EditLabel.Width = 81
        EditLabel.Height = 25
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = 2367260
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'TOTAL BRUTO'
      end
      object edDescPerc: TLMDDBLabeledEdit
        Left = 143
        Top = 39
        Width = 38
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 3
        TabStop = False
        ValidationMsgString = 'a descri'#231#227'o da regra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <>
        TabOnEnter = True
        DataField = 'TotPercDescCalc'
        DataSource = FrmVendas.SouPedido
        ReadOnly = True
        LabelPosition = lpLeft
        LabelSpacing = 12
        LabelSync = True
        EditLabel.Width = 70
        EditLabel.Height = 23
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = 2367260
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'DESCONTOS'
      end
    end
  end
  object TimerDebounce: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerDebounceTimer
    Left = 39
    Top = 461
  end
  object TimerPromDesc: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerPromDescTimer
    Left = 151
    Top = 461
  end
end
