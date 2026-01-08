object FrmNFEven: TFrmNFEven
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'FATURAMENTO - NF Eventuais'
  ClientHeight = 543
  ClientWidth = 1095
  Color = 16250871
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 14
  object PanelBas: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 0
    Width = 1094
    Height = 543
    Margins.Left = 1
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleInner = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 14211288
    Color = clWhite
    TabOrder = 0
    object PanelIte: TLMDSimplePanel
      AlignWithMargins = True
      Left = 3
      Top = 185
      Width = 1088
      Height = 299
      Align = alBottom
      Bevel.StyleInner = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = clSilver
      Bevel.BorderWidth = 1
      Color = clWhite
      TabOrder = 0
      object LMDLabel14: TLMDLabel
        AlignWithMargins = True
        Left = 4
        Top = 286
        Width = 1080
        Height = 11
        Margins.Top = 0
        Margins.Bottom = 1
        Align = alBottom
        Alignment = agCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6381921
        Font.Height = -9
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'DUPLO CLIQUE SOBRE O ITEM PARA ALTERAR'
        ExplicitLeft = 5
      end
      object PaneliIte: TPanel
        Left = 1
        Top = 1
        Width = 1086
        Height = 109
        Align = alTop
        BevelOuter = bvNone
        Color = 15790320
        ParentBackground = False
        TabOrder = 0
        object LMDLabel2: TLMDLabel
          Left = 688
          Top = 4
          Width = 57
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'QUANTID.'
        end
        object LMDLabel1: TLMDLabel
          Left = 750
          Top = 4
          Width = 62
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'VLR. UNIT.'
        end
        object LMDLabel7: TLMDLabel
          Left = 884
          Top = 4
          Width = 77
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'TOTAL ITEM'
        end
        object LMDLabel8: TLMDLabel
          Left = 452
          Top = 4
          Width = 42
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'UN'
        end
        object LMDLabel10: TLMDLabel
          Left = 498
          Top = 4
          Width = 65
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'C'#211'D. NCM'
        end
        object lbcst: TLMDLabel
          Left = 568
          Top = 4
          Width = 61
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'CST/CSON'
        end
        object LMDLabel5: TLMDLabel
          Left = 816
          Top = 4
          Width = 63
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'VLR. DESC.'
        end
        object LMDLabel9: TLMDLabel
          Left = 673
          Top = 60
          Width = 46
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = '% ICMS'
        end
        object LMDLabel6: TLMDLabel
          Left = 722
          Top = 60
          Width = 60
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = '% RED.ICM'
        end
        object LMDLabel15: TLMDLabel
          Left = 787
          Top = 60
          Width = 62
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = '% DIF.ICM'
        end
        object LMDLabel3: TLMDLabel
          Left = 632
          Top = 4
          Width = 50
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'PIS/COF.'
        end
        object LMDLabel4: TLMDLabel
          Left = 599
          Top = 60
          Width = 68
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'BASE ICMS'
        end
        object LMDLabel11: TLMDLabel
          Left = 550
          Top = 60
          Width = 42
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = '% IS'
        end
        object LMDLabel12: TLMDLabel
          Left = 919
          Top = 60
          Width = 42
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = '% ST'
        end
        object LMDLabel13: TLMDLabel
          Left = 854
          Top = 60
          Width = 60
          Height = 15
          Alignment = agCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'BASE ST.'
        end
        object Shape5: TShape
          Left = -40
          Top = 52
          Width = 1004
          Height = 1
          Pen.Color = 13750737
        end
        object Shape4: TShape
          Left = 0
          Top = 108
          Width = 1086
          Height = 1
          Align = alBottom
          Pen.Color = clSilver
          ExplicitLeft = -32
          ExplicitTop = 61
          ExplicitWidth = 1004
        end
        object edQtdped: TLMDMaskEdit
          Left = 688
          Top = 21
          Width = 57
          Height = 23
          Hint = 'Quantidade do item'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnExit = edQtdpedExit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          AutoSelect = True
          ParentFont = False
          Alignment = taRightJustify
          CustomButtons = <>
          MaskType = meFloat
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edVlruni: TLMDMaskEdit
          Left = 750
          Top = 21
          Width = 62
          Height = 23
          Hint = 'Valor unit'#225'rio do Item'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnExit = edQtdpedExit
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
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edTotite: TLMDMaskEdit
          Left = 884
          Top = 21
          Width = 77
          Height = 23
          Hint = 'Total do Item com desconto'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = 14674687
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          Alignment = taRightJustify
          CustomButtons = <>
          Decimals = 2
          MaskType = meFloatFixed
          ReadOnly = True
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edDespro: TLMDLabeledEdit
          Left = 9
          Top = 21
          Width = 438
          Height = 23
          Hint = 'Descri'#231#227'o do item ou produto'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnEnter = edDesproEnter
          OnExit = edDesproExit
          OnKeyUp = edDesproKeyUp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2236186
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          MaxLength = 120
          ParentFont = False
          CustomButtons = <
            item
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000010000000180806000000F3A07D
                0C000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC300000EC301C76FA864000001B74944415478DAED92BD
                AB816118C6AF77341A2499E523222584814D19506460F10710B341FE0146060A
                61B01B498981C980F2112903259B309C739E7B506FAFF7A47356F7F6F4DCD7EF
                79EEEBBEB8AF9FC23F8AFB00C401F3F91CF97C1EBD5E0FB7DB0D1CC7C1E3F120
                994CC26432FD0E60A2502804B95C4E22BD5E8FE9748AD16884D56A856AB58A40
                20F01AB0DD6E61B3D948D46AB52093C99E77EC27E17018DD6E1783C10046A351
                0848A552A8D7EB582E97904AA582D1AED72B09AD562BF5F100E7F31976BB1D0E
                8703954A45D4B8743A8D76BB8DFD7ECF07EC763B180C0664B3596A12AB52A984
                4C2683D3E9C407DCEF77389D4EA8542A341A0D5140229140A7D32143051E140A
                05E472390C874368341A81F872B9C06C36C3ED76A35C2E0B018C1C8944C80706
                53ABD5CFBBCD6643263378BFDF874EA7E303C6E331A2D1280E87039D25120982
                C1208DB45EAFC975B619E681D7EBE5E7603299D08E99316CF7C56211B3D90CCD
                66138BC5024AA5123E9F0FF1781C5AAD969F44F6A5582C86E3F148E96301B258
                2CD4F0783C685DECE557B920000B069B4FA150A056AB5112DF2D02F8FD7E7A85
                99E672B9DE16F33CF86B7D00C037E1BE10C8B843C9CB0000000049454E44AE42
                6082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edDesproCustomButtons0Click
              UsePngGlyph = True
            end>
          PasswordChar = #0
          Spelling.LiveSpell = True
          TabOnEnter = True
          Text = ''
          LabelSpacing = 2
          EditLabel.Width = 118
          EditLabel.Height = 16
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = -1
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'DESCRI'#199#195'O DO ITEM'
        end
        object edUnipro: TLMDEdit
          Left = 452
          Top = 21
          Width = 42
          Height = 23
          Hint = 'Unidade do Item'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          MaxLength = 3
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          PasswordChar = #0
          Spelling.LiveSpell = True
          TabOnEnter = True
          Text = ''
        end
        object edCodNCM: TLMDEdit
          Left = 498
          Top = 21
          Width = 65
          Height = 23
          Hint = 'C'#243'digo NCM'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnKeyPress = edCodKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 8
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          PasswordChar = #0
          Spelling.LiveSpell = True
          TabOnEnter = True
          Text = ''
        end
        object edAliICMS: TLMDMaskEdit
          Left = 673
          Top = 78
          Width = 46
          Height = 23
          Hint = 'Al'#237'quota do ICMS'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          AutoSelect = True
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          Decimals = 2
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edPerCof: TLMDMaskEdit
          Left = 1118
          Top = 22
          Width = 55
          Height = 22
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 19
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
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edVlrDesc: TLMDMaskEdit
          Left = 816
          Top = 21
          Width = 63
          Height = 23
          Hint = 'Valor unit'#225'rio do Desconto '
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnExit = edQtdpedExit
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
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edAliRedICM: TLMDMaskEdit
          Left = 724
          Top = 78
          Width = 58
          Height = 23
          Hint = 'Percentual Redu'#231#227'o do ICMS'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          AutoSelect = True
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          Decimals = 2
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edAliIcmDif: TLMDMaskEdit
          Left = 787
          Top = 78
          Width = 62
          Height = 23
          Hint = 'Percentual Diferimento do ICMS'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          AutoSelect = True
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          Decimals = 2
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edClaIBSCBS: TLMDLabeledEdit
          Left = 9
          Top = 78
          Width = 536
          Height = 23
          Hint = 'C'#243'digo de Classica'#231#227'o do Item IBS / CBS'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnKeyUp = edClaIBSCBSKeyUp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2236186
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <
            item
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000010000000180806000000F3A07D
                0C000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC300000EC301C76FA864000001B74944415478DAED92BD
                AB816118C6AF77341A2499E523222584814D19506460F10710B341FE0146060A
                61B01B498981C980F2112903259B309C739E7B506FAFF7A47356F7F6F4DCD7EF
                79EEEBBEB8AF9FC23F8AFB00C401F3F91CF97C1EBD5E0FB7DB0D1CC7C1E3F120
                994CC26432FD0E60A2502804B95C4E22BD5E8FE9748AD16884D56A856AB58A40
                20F01AB0DD6E61B3D948D46AB52093C99E77EC27E17018DD6E1783C10046A351
                0848A552A8D7EB582E97904AA582D1AED72B09AD562BF5F100E7F31976BB1D0E
                8703954A45D4B8743A8D76BB8DFD7ECF07EC763B180C0664B3596A12AB52A984
                4C2683D3E9C407DCEF77389D4EA8542A341A0D5140229140A7D32143051E140A
                05E472390C874368341A81F872B9C06C36C3ED76A35C2E0B018C1C8944C80706
                53ABD5CFBBCD6643263378BFDF874EA7E303C6E331A2D1280E87039D25120982
                C1208DB45EAFC975B619E681D7EBE5E7603299D08E99316CF7C56211B3D90CCD
                66138BC5024AA5123E9F0FF1781C5AAD969F44F6A5582C86E3F148E96301B258
                2CD4F0783C685DECE557B920000B069B4FA150A056AB5112DF2D02F8FD7E7A85
                99E672B9DE16F33CF86B7D00C037E1BE10C8B843C9CB0000000049454E44AE42
                6082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edClaIBSCBSCustomButtons0Click
              UsePngGlyph = True
            end>
          PasswordChar = #0
          Spelling.LiveSpell = True
          TabOnEnter = True
          Text = ''
          LabelSpacing = 2
          EditLabel.Width = 150
          EditLabel.Height = 16
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = -1
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CLASSIFICA'#199#195'O IBS / CBS'
        end
        object edBasCIMS: TLMDMaskEdit
          Left = 599
          Top = 78
          Width = 68
          Height = 23
          Hint = 'Valor Base do ICMS'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnExit = edQtdpedExit
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
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edImpSel: TLMDMaskEdit
          Left = 552
          Top = 78
          Width = 42
          Height = 23
          Hint = 'Percentual do Imposto Seletivo'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          AutoSelect = True
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          Decimals = 2
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edAliST: TLMDMaskEdit
          Left = 919
          Top = 78
          Width = 42
          Height = 23
          Hint = 'Al'#237'quota de Substitui'#231#227'o Tribut'#225'ria'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 16
          OnExit = edAliSTExit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          AutoSelect = True
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          Decimals = 2
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object edBaseST: TLMDMaskEdit
          Left = 854
          Top = 78
          Width = 60
          Height = 23
          Hint = 'Vlr. Base Substitui'#231#227'o Tribut'#225'ria'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          OnExit = edQtdpedExit
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
          MaskType = meFloatNumber
          TabOnEnter = True
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
        object btSalvaIte: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 997
          Top = 62
          Width = 74
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 8
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = 'Salvar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginVert = 0
          MarginHorz = 5
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001FC49
            444154388D85933D6B544114869F77F6628A5C48C856C2DE3B4BB2462109DA08
            41C4C264C554E607682106626511B5B24A2DF8010A010916FA03922A244A1041
            08365A78515071E706AD5D48E366778FCDAEAC211F6F35BC739E79CFC039628F
            4AA5D24414457366360DF88E1D24BD6EB55ACFB6B7B73FF5D6AB7BA8542A7DBB
            BBBB0F8179E0AD99AD00DF019C7315339B05CE034B711C2F6459D6F8F740075E
            0346255DADD56A6FF67606E0BDBF08BC00BEC4713C936559C301341A8D47C068
            B3D99C3C080608216C465134099CDAD9D97900A052A9345128143E489A3E0CEE
            559AA65392D6DBEDF699C2D0D0D03DE04F0861F108E8DAE0E0E0857ABDFEBE5E
            AFFF181818989274DC995955D2EA61B0F77E4ED27333FBDDF59C732B92AA0E48
            DAEDF6B7EE45B95CBE9C24C9D95E185802E6F33C7FD9F53B4C1AED1338E99CBB
            9DA6E98CA4935D3884B0BC5F7711903BE72A5DA356AB2D7AEF8B92D681BE8360
            492780DC497AD51992AE2C84704BD27D33BB7E50B2A459604349928C3BE73E02
            9742089BFB15EF559AA655496B66761A00EFFD13EFFDCF919191E42878787838
            F5DEFF2A97CB8F011C401CC70BC0E766B3B995A6E9D461C9AD566B0BC88AC5E2
            1DE859A6B1B1B1639DF1BC6966EF24AD9AD9D7CE7F47255D31B373929EF6F7F7
            DFFD6F997A9524C9B8A41B92AAF4AC33B06166CB799E67BDF57F0181B2C7FC4E
            64D2950000000049454E44AE426082}
          Rounded = True
          Spacing = 4
          TabOrder = 17
          OnClick = btSalvaIteClick
          Appearance.BorderColor = 8695039
          Appearance.BorderColorHot = 2846975
          Appearance.BorderColorCheckedHot = 8695039
          Appearance.BorderColorDown = 8695039
          Appearance.BorderColorChecked = 8695039
          Appearance.BorderColorDisabled = 8695039
          Appearance.BorderColorFocused = 9845
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
        object btLimpar: TAdvGlowButton
          AlignWithMargins = True
          Left = 997
          Top = 28
          Width = 74
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 6
          Margins.Bottom = 0
          Caption = 'Limpar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000022449
            444154388D7D933D4F154114869F33BBD184F52F48616099F50A7406682C0C31
            7E45A4B0B32242945068C39F5063208222C69FA0C45888741A3031570CE16677
            038D7416965820735F0BEF35CB8D7AAA99CCFBBCE723678C8E48D374D0CC26CD
            EC3CD00D08D803DE99D9529EE7DB55BDB50F3D3D3DC7E3389E0726CC6C5DD28A
            A41DE79C49F2C035E02CB01845D1BD46A371F0C7A005BF05FACCEC669EE76B9D
            950164597659D20B495B711C5F6A341A070E208EE3B9163CF42F1820CFF33787
            8787C366361042B80F60699A0E3AE73E9BD9853CCFD76AB5DA8910427F51141B
            55D87B3F9224C9977ABDFEC37B7F15781945D18073CEDD32B3F576E610C200F0
            C17B3F55816780F7FBFBFB19405114AF81CD10C2440C8C4A5A6A8B8BA258CFB2
            6C4AD2D32CCB624987C02349D36559D6DB3A492B667623064E4ADAEDE87539CB
            32DAC692EE9465F9A4AA71CEED48EA76AD8BD11192A28A38EA7C074C921CF0B5
            D96CF6760C6C0A5890340D4C499ACBB26CBA23416A667B8EDF1B365681CF010B
            66365996E5625114CFCC6CA6653254F11803569D992D0143699A5E0488A2A8DE
            6C3687F33C7F5E99C982736EA4ABAB6BAB95641CE897B40C405F5FDF63EFFDB7
            344D4FFDA5D723E1BD4FBDF7DFBDF70F01DA9B7817D876CE7DF4DE5FF90F3C0E
            6C009F92249985CA67AAD56AC742080F80DBC0A6A457CEB9DDD6A07B255D37B3
            33C07C9224B3F57AFDE711838AD1E910C204300A744B9299ED01AB9296CBB22C
            ABFA5F5B33FD9DD51566C30000000049454E44AE426082}
          Rounded = True
          Spacing = 3
          TabOrder = 18
          OnClick = btLimparClick
          Appearance.BorderColor = 2412287
          Appearance.BorderColorHot = 50943
          Appearance.BorderColorCheckedHot = 50175
          Appearance.BorderColorDown = 46826
          Appearance.BorderColorChecked = 50175
          Appearance.BorderColorDisabled = 50175
          Appearance.BorderColorFocused = 9845
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
          Layout = blGlyphLeftAdjusted
        end
        object edCstite: TLMDComboBoxExt
          Left = 568
          Top = 21
          Width = 61
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Caret.CanEnable = False
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 3
          OnKeyPress = edCodKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ItemIndex = 0
          ItemHeight = 16
          HeaderSections = <
            item
              ImageIndex = -1
              Width = 50
            end>
          Delimiter = ';'
          Style = csDropDownList
        end
        object edCSTPISCOF: TLMDComboBoxExt
          Left = 633
          Top = 21
          Width = 50
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14211288
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Caret.CanEnable = False
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 4
          OnKeyPress = edCodKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          ItemIndex = 0
          ItemHeight = 16
          HeaderSections = <
            item
              ImageIndex = -1
              Width = 50
            end>
          Delimiter = ';'
          Style = csDropDownList
        end
      end
      object DBGrid1: TDBGrid
        Tag = 1
        AlignWithMargins = True
        Left = 1
        Top = 113
        Width = 1086
        Height = 170
        Margins.Left = 0
        Margins.Right = 0
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = SouNFEveIte
        DrawingStyle = gdsGradient
        FixedColor = 16447736
        GradientEndColor = 16447736
        GradientStartColor = 16447736
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
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
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = []
            Width = 23
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Desitem'
            Title.Alignment = taCenter
            Title.Caption = 'DESCRI'#199#195'O DO ITEM'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 440
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'UniVen'
            Title.Alignment = taCenter
            Title.Caption = 'UN'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 42
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CodNCM'
            Title.Alignment = taCenter
            Title.Caption = 'C'#211'D.NCM'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 72
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CST_CSON'
            Title.Alignment = taCenter
            Title.Caption = 'CST/CSON'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 71
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CSTPisCof'
            Title.Alignment = taCenter
            Title.Caption = 'PIS/COF'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Qtdped'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'QUANT.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Vlruni'
            Title.Alignment = taCenter
            Title.Caption = 'VLR.UNIT.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VlrDesc'
            ReadOnly = False
            Title.Alignment = taCenter
            Title.Caption = 'DESCONTO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TotIteCalc'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Title.Alignment = taCenter
            Title.Caption = 'TOTAL ITEM'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 85
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CodClasIte'
            Title.Alignment = taCenter
            Title.Caption = 'IBS/CBS'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AliqIS'
            Title.Alignment = taCenter
            Title.Caption = '% IS'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BaseICMS'
            Title.Alignment = taCenter
            Title.Caption = 'BASE ICMS'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'AliqICMS'
            Title.Alignment = taCenter
            Title.Caption = '% ICMS'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 58
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'AliqRedICM'
            Title.Alignment = taCenter
            Title.Caption = '% RED.ICM'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 71
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'AliqIcmDif'
            Title.Alignment = taCenter
            Title.Caption = '% DIF.ICM'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BaseST'
            Title.Alignment = taCenter
            Title.Caption = 'BASE ST'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'AliqST'
            Title.Alignment = taCenter
            Title.Caption = '% ST'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5131854
            Title.Font.Height = -12
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 41
            Visible = True
          end>
      end
    end
    object PanelBotton: TLMDSimplePanel
      AlignWithMargins = True
      Left = 3
      Top = 490
      Width = 1088
      Height = 50
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = clSilver
      Bevel.BorderWidth = 1
      Color = 15790320
      TabOrder = 1
      object Shape1: TShape
        Left = 223
        Top = 8
        Width = 1
        Height = 36
        Pen.Color = 12369084
      end
      object Shape2: TShape
        Left = 560
        Top = 8
        Width = 1
        Height = 36
        Pen.Color = 12369084
      end
      object Shape3: TShape
        Left = 799
        Top = 8
        Width = 1
        Height = 36
        Pen.Color = 12369084
      end
      object btPrever: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 813
        Top = 13
        Width = 143
        Height = 27
        Cursor = crHandPoint
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'PR'#201' VISUALIZAR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5855577
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 7
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000110000001108060000003B6D47
          FA000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
          00097048597300000EC100000EC101B8916BED0000001974455874536F667477
          617265007777772E696E6B73636170652E6F72679BEE3C1A0000018769545874
          584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420
          626567696E3D27EFBBBF272069643D2757354D304D7043656869487A7265537A
          4E54637A6B633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D
          2261646F62653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A
          7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32
          322D7264662D73796E7461782D6E7323223E3C7264663A446573637269707469
          6F6E207264663A61626F75743D22757569643A66616635626464352D62613364
          2D313164612D616433312D6433336437353138326631622220786D6C6E733A74
          6966663D22687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E
          302F223E3C746966663A4F7269656E746174696F6E3E313C2F746966663A4F72
          69656E746174696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264
          663A5244463E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E
          643D2777273F3E2C94980B0000018149444154384FAD93CF6A534114C6BFAF49
          C8AE0BC114DCF8045D0A31267328BE82144B8BFB2EBA56685D18F00FF806EA42
          11AC92459F40E45C344DA1CB6EEC52506295A07439349F0BEF95EB187241FA83
          8139DFF9C3993333C03940335B03F02A755421E93BC92D777FCD10C23700CF48
          BE4D03E721E93AC93BEE4E9899CCAC9B065561665D3313002CA4CEFFA15E3642
          087D9277CBDA0CEEBBFB4E59483B79096075DE92F422C9C1B9CCE4AFE398D90D
          0083B20600EECE54CBF9B748CE93D27EDFDD9FE79D6E496A91FCD068341EC718
          8F006C237F6C02D073F7F7A5E43F985957D23B926F241D935C07F0B5D56AAD0C
          068333CC18EC2C3601ECBAFB469665FD18E38AA4ABE3F1F85A11505944D21280
          8F853D1C0EBF903CADD56A170BADB208C90392B73A9DCE25FC7E4BB7252D4EA7
          D3E322A6B2088087924EEAF5FA27339B00B847F23380BD10C2328AC14A7A34E7
          031EBAFBCF5EAF7785E492A4C318E38F66B3F934BF90CB34B39B0076D3CC0249
          DB59963D48750068B7DB1746A3D1E417A97F9D57924ABDAF0000000049454E44
          AE426082}
        Rounded = True
        Spacing = 5
        TabOrder = 8
        Appearance.BorderColor = 8695039
        Appearance.BorderColorHot = 2846975
        Appearance.BorderColorCheckedHot = 8695039
        Appearance.BorderColorDown = 8695039
        Appearance.BorderColorChecked = 8695039
        Appearance.BorderColorDisabled = 8695039
        Appearance.BorderColorFocused = 9845
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
      object LMDDBLabeledEdit1: TLMDDBLabeledEdit
        AlignWithMargins = True
        Left = 696
        Top = 23
        Width = 93
        Height = 22
        Margins.Top = 1
        Margins.Right = 145
        Margins.Bottom = 1
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 14674687
        TabOrder = 7
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        DataField = 'TotPedido'
        DataSource = SouNFEve
        ReadOnly = True
        LabelSpacing = 2
        EditLabel.Width = 92
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Color = 15790320
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 2236186
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'TOTAL DA NOTA'
      end
      object LMDDBLabeledEdit5: TLMDDBLabeledEdit
        Left = 234
        Top = 23
        Width = 91
        Height = 22
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 3
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <>
        DataField = 'Marca'
        DataSource = SouNFEve
        LabelSpacing = 2
        EditLabel.Width = 44
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'MARCA'
      end
      object LMDDBLabeledEdit6: TLMDDBLabeledEdit
        Left = 330
        Top = 23
        Width = 91
        Height = 22
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 4
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <>
        DataField = 'Especie'
        DataSource = SouNFEve
        LabelSpacing = 2
        EditLabel.Width = 50
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'ESP'#201'CIE'
      end
      object LMDDBLabeledEdit7: TLMDDBLabeledEdit
        Left = 427
        Top = 23
        Width = 58
        Height = 22
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 5
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        DataField = 'PesoBru'
        DataSource = SouNFEve
        LabelSpacing = 2
        EditLabel.Width = 57
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'PES. BRU.'
      end
      object LMDDBLabeledEdit8: TLMDDBLabeledEdit
        Left = 491
        Top = 23
        Width = 59
        Height = 22
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 6
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        DataField = 'PesoLiq'
        DataSource = SouNFEve
        LabelSpacing = 2
        EditLabel.Width = 61
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'PES.L'#205'QUI.'
      end
      object btEnviaNF: TAdvGlowButton
        AlignWithMargins = True
        Left = 962
        Top = 13
        Width = 119
        Height = 27
        Cursor = crHandPoint
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 6
        Margins.Bottom = 0
        Caption = 'ENVIAR NF'
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
          61000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000012749
          444154388DBD92314BC3501485BFFB5A886E1DC441C4C1A564EC5270776935E4
          A590517072757150148A9B83A2BB83F907214E22E8DE9F5017076747A11078D7
          C1B68492483AE81DDFE13BF7DC7B1FFC4785617862AD3D2ED31A750C7CDF7F05
          F6DBEDF6CA783C7E296AA666880680889C5A6BAF8B82541141106C1963BAC698
          0D55BD2D3653D5AB2CCBCE4A0DC230EC8BC810E8FE1669663237E8F57A9EE779
          F7C041CDB1002E05208EE3469EE78F407F0918E0C300E4793E5C1656D589881C
          C96030D874CEBD01ABCBC0C698284DD3A7A673EE70017E071E8011F0397D1B31
          3D65110668AAEA9EC87C9737AD56EB22499249B1A3B556CB6080A6886C4FC5F9
          6D4BEA4B55BD45187E3EC71AF0DCE974CEAB6676CEED8AC8CE223C8B771745D1
          7A15FCE7F50D66277038764402030000000049454E44AE426082}
        Rounded = True
        TabOrder = 9
        OnClick = btEnviaNFClick
        Appearance.BorderColor = 2412287
        Appearance.BorderColorHot = 50943
        Appearance.BorderColorCheckedHot = 50175
        Appearance.BorderColorDown = 46826
        Appearance.BorderColorChecked = 50175
        Appearance.BorderColorDisabled = 50175
        Appearance.BorderColorFocused = 9845
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
        Layout = blGlyphRight
      end
      object LMDDBLabeledEdit9: TLMDDBLabeledEdit
        Left = 7
        Top = 23
        Width = 66
        Height = 22
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        DataField = 'VlrFrete'
        DataSource = SouNFEve
        LabelSpacing = 2
        EditLabel.Width = 56
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'FRETE R$'
      end
      object LMDDBLabeledEdit10: TLMDDBLabeledEdit
        Left = 77
        Top = 23
        Width = 66
        Height = 22
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 1
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        DataField = 'VlrSeguro'
        DataSource = SouNFEve
        LabelSpacing = 2
        EditLabel.Width = 66
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'SEGURO R$'
      end
      object LMDDBLabeledEdit11: TLMDDBLabeledEdit
        Left = 149
        Top = 23
        Width = 66
        Height = 22
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        DataField = 'VlrOutros'
        DataSource = SouNFEve
        LabelSpacing = 2
        EditLabel.Width = 66
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'OUTROS R$'
      end
      object edItens: TLMDLabeledEdit
        Left = 573
        Top = 23
        Width = 36
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 14674687
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        PasswordChar = #0
        ReadOnly = True
        Spelling.LiveSpell = True
        Text = '0'
        LabelSpacing = 2
        EditLabel.Width = 35
        EditLabel.Height = 16
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = -1
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'ITENS'
      end
      object LMDDBLabeledEdit4: TLMDDBLabeledEdit
        AlignWithMargins = True
        Left = 616
        Top = 23
        Width = 73
        Height = 22
        Margins.Top = 1
        Margins.Right = 145
        Margins.Bottom = 1
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 14674687
        TabOrder = 11
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        DataField = 'TotDesc'
        DataSource = SouNFEve
        ReadOnly = True
        LabelSpacing = 2
        EditLabel.Width = 68
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Color = 15790320
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = 2236186
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'TOT.DESCO.'
      end
    end
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1088
      Height = 176
      Margins.Bottom = 1
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = clSilver
      Bevel.BorderWidth = 1
      Color = 15790320
      TabOrder = 2
      object LMDLabel16: TLMDLabel
        Left = 10
        Top = 55
        Width = 255
        Height = 16
        Alignment = agCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'NATUREZA DE OPERA'#199#195'O PRINCIPAL - CFOP'
      end
      object LMDLabel17: TLMDLabel
        Left = 628
        Top = 55
        Width = 136
        Height = 16
        Alignment = agCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'FORMA DE PAGAMENTO'
      end
      object LMDLabel18: TLMDLabel
        Left = 925
        Top = 102
        Width = 133
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'DATA / HORA DA SA'#205'DA'
      end
      object edPess: TLMDDBLabeledEdit
        Left = 10
        Top = 24
        Width = 606
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 0
        OnExit = edPessExit
        OnKeyUp = edPessKeyUp
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <
          item
            Cursor = crHandPoint
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000180806000000F3A07D
              0C000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC300000EC301C76FA864000001B74944415478DAED92BD
              AB816118C6AF77341A2499E523222584814D19506460F10710B341FE0146060A
              61B01B498981C980F2112903259B309C739E7B506FAFF7A47356F7F6F4DCD7EF
              79EEEBBEB8AF9FC23F8AFB00C401F3F91CF97C1EBD5E0FB7DB0D1CC7C1E3F120
              994CC26432FD0E60A2502804B95C4E22BD5E8FE9748AD16884D56A856AB58A40
              20F01AB0DD6E61B3D948D46AB52093C99E77EC27E17018DD6E1783C10046A351
              0848A552A8D7EB582E97904AA582D1AED72B09AD562BF5F100E7F31976BB1D0E
              8703954A45D4B8743A8D76BB8DFD7ECF07EC763B180C0664B3596A12AB52A984
              4C2683D3E9C407DCEF77389D4EA8542A341A0D5140229140A7D32143051E140A
              05E472390C874368341A81F872B9C06C36C3ED76A35C2E0B018C1C8944C80706
              53ABD5CFBBCD6643263378BFDF874EA7E303C6E331A2D1280E87039D25120982
              C1208DB45EAFC975B619E681D7EBE5E7603299D08E99316CF7C56211B3D90CCD
              66138BC5024AA5123E9F0FF1781C5AAD969F44F6A5582C86E3F148E96301B258
              2CD4F0783C685DECE557B920000B069B4FA150A056AB5112DF2D02F8FD7E7A85
              99E672B9DE16F33CF86B7D00C037E1BE10C8B843C9CB0000000049454E44AE42
              6082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edPessCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonsStyle = ubsExplorer
        CustomButtonWidth = 18
        CustomButtonParentCtlXP = False
        TabOnEnter = True
        DataField = 'Nompes'
        DataSource = SouNFEve
        LabelSpacing = 1
        EditLabel.Width = 47
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'PESSOA'
      end
      object cbTipoFrete: TLMDLabeledListComboBox
        Left = 628
        Top = 24
        Width = 448
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Bevel.ShadowColor = clWhite
        Caret.BlinkRate = 530
        Caret.CanEnable = False
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        Items.Strings = (
          'FRETE POR CONTA DO REMETENTE (CIF)'
          'FRETE POR CONTA DO DESTINAT'#193'RIO (FOB)'#10
          'FRETE POR CONTA DE TERCEIROS'#10
          'TRANSPORTE PR'#211'PRIO POR CONTA DO REMETENTE'
          #10'TRANSPORTE PR'#211'PRIO POR CONTA DO DESTINAT'#193'RIO'
          #10'SEM OCORR'#202'NCIA DE TRANSPORTE')
        ItemIndex = -1
        Style = csDropDownList
        LabelSpacing = 1
        EditLabel.Width = 86
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Color = clBlack
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = -1
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Caption = 'TIPO DE FRETE'
      end
      object edMotDevu: TLMDDBLabeledEdit
        Left = 10
        Top = 118
        Width = 908
        Height = 24
        Bevel.StyleInner = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        Ctl3D = False
        Enabled = False
        ParentCtl3D = False
        TabOrder = 5
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        CharCase = ecUpperCase
        ParentFont = False
        CustomButtons = <>
        TabOnEnter = True
        DataField = 'MotDevu'
        DataSource = SouNFEve
        LabelSpacing = 1
        EditLabel.Width = 139
        EditLabel.Height = 16
        EditLabel.AutoSize = False
        EditLabel.Enabled = False
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'MOTIVO DA DEVOLU'#199#195'O'
      end
      object PanelButtons: TLMDSimplePanel
        AlignWithMargins = True
        Left = 1
        Top = 148
        Width = 1086
        Height = 25
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 2
        Align = alBottom
        ParentColor = True
        TabOrder = 7
        object btSalvar: TAdvGlowButton
          AlignWithMargins = True
          Left = 957
          Top = 0
          Width = 119
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alRight
          Caption = 'Salvar Capa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginHorz = 7
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
          Appearance.BorderColorFocused = 9845
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
        object btExcluir: TAdvGlowButton
          AlignWithMargins = True
          Left = 833
          Top = 0
          Width = 119
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alRight
          Caption = 'Excluir NF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5723991
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginHorz = 7
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
          TabOrder = 1
          OnClick = btExcluirClick
          Appearance.BorderColor = 2412287
          Appearance.BorderColorHot = 50943
          Appearance.BorderColorCheckedHot = 50175
          Appearance.BorderColorDown = 46826
          Appearance.BorderColorChecked = 50175
          Appearance.BorderColorDisabled = 50175
          Appearance.BorderColorFocused = 9845
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
        object btNovo: TAdvGlowButton
          AlignWithMargins = True
          Left = 709
          Top = 0
          Width = 119
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alRight
          Caption = 'Nova NF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginHorz = 11
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
          Spacing = 5
          TabOrder = 2
          Appearance.BorderColor = 8695039
          Appearance.BorderColorHot = 2846975
          Appearance.BorderColorCheckedHot = 8695039
          Appearance.BorderColorDown = 8695039
          Appearance.BorderColorChecked = 8695039
          Appearance.BorderColorDisabled = 8695039
          Appearance.BorderColorFocused = 9845
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
        object btReferen: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 258
          Top = 0
          Width = 125
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Referenciados'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginVert = 0
          MarginHorz = 6
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001ED49
            444154388D8D93BF6B535114C73FE73E7934D174902A2226BAB9B56320BEF74C
            4B0675112499C445707050414ADB4D0B222DEAE62068FF09410B12687EDC2022
            044107DDA411E2E2102C34297DF738F4B594F487BDD3857B3E1FCEF972AE7084
            1345D10D557D0C5C00DAC0C366B3D90690FFC14110CC8AC802E0803FC029E0AF
            E779E3B55AEDA7390C0EC3702681D78C31A566B3795A559F0099388EEF001C28
            08C370065804D654F56ABD5E5F499EEA002272E640C1306CADB500F97C7E5444
            9E0238E7ECBE194451744D55DF6DC3C69809206B8C79B5B9B93925224BAABA62
            AD2D016E4F07CEB9E9E45A36C61455F5A5AACEC671FC4544BE89C8BCAA5E672B
            548E0D0B44E42CA01B1B1B1F7DDFBF055C014AC034F0A2D16884BBEBF7742022
            2D407CDF5F1291F7C0FDC160B000F48089E1FA9D0E8AC5E289388E9FF9BE3F3F
            180C2E0365552D038F52A9D4B8736E54443EED2BA8542A5EB7DB7D2B2293FD7E
            FFD7FAFAFA783A9DBE29224E55BF3BE7960151D5E7C3020F606C6CEC36F000F8
            3C323272AFD56AADADAEAEB6B3D9EC7111590632AA3A67AD7D3D2C3000AA7A29
            997FAE5AADF600822008920CB6E1C561787788BF019C73930051144D1D058664
            910A85C279CFF3BE0219B63ECCC964E643E19D0C3A9D4E2F97CB7D10918BC039
            E087AADEB5D6BE390C06F807F300D8441690D6710000000049454E44AE426082}
          Rounded = True
          Spacing = 0
          TabOrder = 3
          OnClick = btReferenClick
          Appearance.BorderColor = 8695039
          Appearance.BorderColorHot = 2846975
          Appearance.BorderColorCheckedHot = 8695039
          Appearance.BorderColorDown = 8695039
          Appearance.BorderColorChecked = 8695039
          Appearance.BorderColorDisabled = 8695039
          Appearance.BorderColorFocused = 9845
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
        object btObserva: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 10
          Top = 0
          Width = 119
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Observa'#231#245'es'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginVert = 0
          MarginHorz = 7
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
            00097048597300000EC100000EC101B8916BED0000001974455874536F667477
            617265007777772E696E6B73636170652E6F72679BEE3C1A0000018769545874
            584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420
            626567696E3D27EFBBBF272069643D2757354D304D7043656869487A7265537A
            4E54637A6B633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D
            2261646F62653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A
            7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32
            322D7264662D73796E7461782D6E7323223E3C7264663A446573637269707469
            6F6E207264663A61626F75743D22757569643A66616635626464352D62613364
            2D313164612D616433312D6433336437353138326631622220786D6C6E733A74
            6966663D22687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E
            302F223E3C746966663A4F7269656E746174696F6E3E313C2F746966663A4F72
            69656E746174696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264
            663A5244463E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E
            643D2777273F3E2C94980B0000008B49444154384FED93B10DC2500C44CF6693
            7F9E8515E8E9B3020D8265324166416E9982AFA34129AC9F02A542E249AEEEE9
            A42B0CECC40020228E92961A6E21E96966E7CC5C0C00484AD2ECEE8F2A8FE8BD
            D3DD4F9969C0A72022EE55DCA2B576232900F01A7ECBB080E44452E5A6EAADFC
            27EC6358F05B13D65F007035B3431546487A01B864A6EDFEC637AAE255ABB73A
            C2840000000049454E44AE426082}
          Rounded = True
          TabOrder = 4
          OnClick = btObservaClick
          Appearance.BorderColor = 8695039
          Appearance.BorderColorHot = 2846975
          Appearance.BorderColorCheckedHot = 8695039
          Appearance.BorderColorDown = 8695039
          Appearance.BorderColorChecked = 8695039
          Appearance.BorderColorDisabled = 8695039
          Appearance.BorderColorFocused = 9845
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
        object btTransp: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 134
          Top = 0
          Width = 119
          Height = 25
          Cursor = crHandPoint
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Tranportes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
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
            89504E470D0A1A0A0000000D49484452000000120000001008060000001B062F
            5C000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
            00097048597300000EC100000EC101B8916BED0000001974455874536F667477
            617265007777772E696E6B73636170652E6F72679BEE3C1A0000018769545874
            584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420
            626567696E3D27EFBBBF272069643D2757354D304D7043656869487A7265537A
            4E54637A6B633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D
            2261646F62653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A
            7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32
            322D7264662D73796E7461782D6E7323223E3C7264663A446573637269707469
            6F6E207264663A61626F75743D22757569643A66616635626464352D62613364
            2D313164612D616433312D6433336437353138326631622220786D6C6E733A74
            6966663D22687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E
            302F223E3C746966663A4F7269656E746174696F6E3E313C2F746966663A4F72
            69656E746174696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264
            663A5244463E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E
            643D2777273F3E2C94980B0000012D49444154384FCD93AD4E43411046CF5C52
            033854650506477882EEA692F00604D12A82231508DE00456509093F82549020
            70B32BD04848AA1AA840D5414A103B984B72B929042E8693AC39F3ED9759B1F0
            DF10E75C5B443AC05C79380B33BB0E21EC97BD38E75E4464BE3CF8865355DD2C
            CBEC97255F9295C54F70CE3D7BEFADE82A158510165555BCF74FCEB9152A162D
            359BCD358094D21E70D16AB516AA144D628CB70031C663E032A5D493F25BAB52
            65A399148B5E81BE993D16DC2C1E807E9E074055250306C03D70A6AA1D11E99A
            D924F79F8E994D44A4ABAA1DE03CBF37001000EFFD86991D6659B66B666D60A8
            AA3BC535F25C0F58169123333B48296DC718AFF8F85FA3D168D8683412B005DC
            4DA7D3BDF178FC562EAAD7EB37B55A6D155807FA21849372E6CFBC0397D6747E
            EAB4E0BD0000000049454E44AE426082}
          Rounded = True
          TabOrder = 5
          OnClick = btTranspClick
          Appearance.BorderColor = 8695039
          Appearance.BorderColorHot = 2846975
          Appearance.BorderColorCheckedHot = 8695039
          Appearance.BorderColorDown = 8695039
          Appearance.BorderColorChecked = 8695039
          Appearance.BorderColorDisabled = 8695039
          Appearance.BorderColorFocused = 9845
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
      object edSpinParc: TLMDDBLabeledSpinEdit
        Left = 1024
        Top = 72
        Width = 52
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        OnChange = edSpinParcChange
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        CustomButtonWidth = 17
        MaxValue = 0
        DataField = 'NroParc'
        DataSource = SouNFEve
        LabelSpacing = 1
        EditLabel.Width = 56
        EditLabel.Height = 15
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'PARCELAS'
        Value = 0
      end
      object LMDDBLookupComboBox1: TLMDDBLookupComboBox
        Left = 10
        Top = 72
        Width = 600
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        ItemHeight = 16
        HeaderSections = <
          item
            ImageIndex = -1
            Width = 50
          end>
        Delimiter = ';'
        DataSource = SouNFEve
        ListSource = SouCFOP
        DataField = 'IDCFOP'
        ListField = 'Desnat'
        KeyField = 'IDCFOP'
      end
      object LMDDBLookupComboBox2: TLMDDBLookupComboBox
        Left = 628
        Top = 72
        Width = 386
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14211288
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        ItemHeight = 16
        HeaderSections = <
          item
            ImageIndex = -1
            Width = 50
          end>
        Delimiter = ';'
        DataSource = SouNFEve
        ListSource = SouForPagNF
        DataField = 'IDForPagNF'
        ListField = 'DesForPagNF'
        KeyField = 'IDForPagNF'
      end
      object LMDSimplePanel2: TLMDSimplePanel
        Left = 925
        Top = 118
        Width = 151
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 6
        object LMDLabel19: TLMDLabel
          AlignWithMargins = True
          Left = 140
          Top = 1
          Width = 7
          Height = 20
          Margins.Top = 0
          Margins.Bottom = 2
          Align = alRight
          Alignment = agCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9863798
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = 'h'
          ExplicitLeft = 141
          ExplicitTop = 0
        end
        object Shape6: TShape
          AlignWithMargins = True
          Left = 97
          Top = 4
          Width = 1
          Height = 14
          Margins.Left = 0
          Margins.Bottom = 5
          Align = alRight
          Pen.Color = 13877440
          ExplicitLeft = 99
        end
        object edDate: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 86
          Height = 20
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          AutoSelect = False
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
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
        end
        object edTime: TLMDMaskEdit
          Left = 101
          Top = 1
          Width = 36
          Height = 22
          Margins.Left = 2
          Margins.Right = 0
          Align = alRight
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          Mask = 'HH:mm'
          MaskType = meTime
          TimeSettings.FormatStr = 'HH:mm'
          TimeSettings.Format = tfCustom
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          Value = 0.000000000000000000
        end
      end
    end
  end
  object TabNFEve: TRESTDWClientSQL
    Active = False
    AfterInsert = TabNFEveAfterInsert
    BeforePost = TabNFEveBeforePost
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDFilial'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'IDPed'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Datped'
        DataType = ftDateTime
      end
      item
        Name = 'IDPess'
        DataType = ftInteger
      end
      item
        Name = 'IDCFOP'
        DataType = ftInteger
      end
      item
        Name = 'IDForPagNF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'TipFrete'
        DataType = ftSmallint
      end
      item
        Name = 'VlrDesc'
        DataType = ftFloat
      end
      item
        Name = 'TotDesc'
        DataType = ftFloat
      end
      item
        Name = 'TotPedido'
        DataType = ftFloat
      end
      item
        Name = 'VlrFrete'
        DataType = ftFloat
      end
      item
        Name = 'VlrSeguro'
        DataType = ftFloat
      end
      item
        Name = 'VlrOutros'
        DataType = ftFloat
      end
      item
        Name = 'NroParc'
        DataType = ftSmallint
      end
      item
        Name = 'IDTransp'
        DataType = ftInteger
      end
      item
        Name = 'PesoBru'
        DataType = ftFloat
      end
      item
        Name = 'PesoLiq'
        DataType = ftFloat
      end
      item
        Name = 'Marca'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Especie'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CpfCnpjTran'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'IETran'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'NomeTran'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'EndTran'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'CidTran'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'EstTran'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'PlaVeiTran'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'UFPlaVeiTran'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'RNTCTran'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MotDevu'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ModNF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'SerNF'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NroNF'
        DataType = ftInteger
      end
      item
        Name = 'EmiNF'
        DataType = ftDateTime
      end
      item
        Name = 'ChaveNF'
        DataType = ftString
        Size = 44
      end
      item
        Name = 'ProtoNF'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'ResulNF'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Contigencia'
        DataType = ftBoolean
      end
      item
        Name = 'Status'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ObsNF'
        DataType = ftWideMemo
      end
      item
        Name = 'SituNF'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DatHorAlt'
        DataType = ftDateTime
      end
      item
        Name = 'IndDelete'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Nompes'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'Desnat'
        DataType = ftString
        Size = 180
      end
      item
        Name = 'DatHorSai'
        DataType = ftDateTime
      end>
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
      'SELECT EVE.*,PES.Nompes,OPE.Desnat FROM arqnfeven EVE'
      'LEFT JOIN arqcfop OPE ON EVE.IDCFOP = OPE.IDCFOP '
      'LEFT JOIN arqpessoa PES ON EVE.IDPess = PES.IDPess'
      'WHERE IDPed = 0 OR ISNULL(IDPed) ')
    UpdateTableName = 'arqnfeven'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 34
    Top = 325
    object TabNFEveIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabNFEveIDPed: TIntegerField
      FieldName = 'IDPed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabNFEveDatped: TDateTimeField
      FieldName = 'Datped'
    end
    object TabNFEveDatHorSai: TDateTimeField
      FieldName = 'DatHorSai'
    end
    object TabNFEveIDPess: TIntegerField
      FieldName = 'IDPess'
    end
    object TabNFEveIDCFOP: TIntegerField
      FieldName = 'IDCFOP'
    end
    object TabNFEveIDForPagNF: TWideStringField
      FieldName = 'IDForPagNF'
      Size = 2
    end
    object TabNFEveTipFrete: TSmallintField
      FieldName = 'TipFrete'
    end
    object TabNFEveVlrDesc: TFloatField
      FieldName = 'VlrDesc'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveTotDesc: TFloatField
      FieldName = 'TotDesc'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveTotPedido: TFloatField
      FieldName = 'TotPedido'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveVlrFrete: TFloatField
      FieldName = 'VlrFrete'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveVlrSeguro: TFloatField
      FieldName = 'VlrSeguro'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveVlrOutros: TFloatField
      FieldName = 'VlrOutros'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveNroParc: TSmallintField
      FieldName = 'NroParc'
    end
    object TabNFEveIDTransp: TIntegerField
      FieldName = 'IDTransp'
    end
    object TabNFEvePesoBru: TFloatField
      FieldName = 'PesoBru'
      DisplayFormat = '###,##0.00'
    end
    object TabNFEvePesoLiq: TFloatField
      FieldName = 'PesoLiq'
      DisplayFormat = '###,##0.00'
    end
    object TabNFEveMarca: TWideStringField
      FieldName = 'Marca'
      Size = 50
    end
    object TabNFEveEspecie: TWideStringField
      FieldName = 'Especie'
      Size = 50
    end
    object TabNFEveCpfCnpjTran: TWideStringField
      FieldName = 'CpfCnpjTran'
      Size = 14
    end
    object TabNFEveIETran: TWideStringField
      FieldName = 'IETran'
      Size = 25
    end
    object TabNFEveNomeTran: TWideStringField
      FieldName = 'NomeTran'
      Size = 45
    end
    object TabNFEveEndTran: TWideStringField
      FieldName = 'EndTran'
      Size = 60
    end
    object TabNFEveCidTran: TWideStringField
      FieldName = 'CidTran'
      Size = 40
    end
    object TabNFEveEstTran: TWideStringField
      FieldName = 'EstTran'
      Size = 2
    end
    object TabNFEvePlaVeiTran: TWideStringField
      FieldName = 'PlaVeiTran'
      Size = 7
    end
    object TabNFEveUFPlaVeiTran: TWideStringField
      FieldName = 'UFPlaVeiTran'
      Size = 2
    end
    object TabNFEveRNTCTran: TWideStringField
      FieldName = 'RNTCTran'
    end
    object TabNFEveMotDevu: TWideStringField
      FieldName = 'MotDevu'
      Size = 100
    end
    object TabNFEveModNF: TWideStringField
      FieldName = 'ModNF'
      Size = 2
    end
    object TabNFEveSerNF: TWideStringField
      FieldName = 'SerNF'
      Size = 3
    end
    object TabNFEveNroNF: TIntegerField
      FieldName = 'NroNF'
    end
    object TabNFEveEmiNF: TDateTimeField
      FieldName = 'EmiNF'
    end
    object TabNFEveChaveNF: TWideStringField
      FieldName = 'ChaveNF'
      Size = 44
    end
    object TabNFEveProtoNF: TWideStringField
      FieldName = 'ProtoNF'
      Size = 18
    end
    object TabNFEveResulNF: TWideStringField
      FieldName = 'ResulNF'
      Size = 4
    end
    object TabNFEveContigencia: TBooleanField
      FieldName = 'Contigencia'
    end
    object TabNFEveStatus: TWideStringField
      FieldName = 'Status'
      Size = 1
    end
    object TabNFEveObsNF: TWideMemoField
      FieldName = 'ObsNF'
      BlobType = ftWideMemo
    end
    object TabNFEveSituNF: TWideStringField
      FieldName = 'SituNF'
      Size = 1
    end
    object TabNFEveDatHorAlt: TDateTimeField
      FieldName = 'DatHorAlt'
    end
    object TabNFEveIndDelete: TWideStringField
      FieldName = 'IndDelete'
      Size = 1
    end
    object TabNFEveNompes: TWideStringField
      FieldName = 'Nompes'
      ProviderFlags = []
      Size = 80
    end
    object TabNFEveDesnat: TWideStringField
      FieldName = 'Desnat'
      ProviderFlags = []
      Size = 180
    end
  end
  object SouNFEve: TDataSource
    AutoEdit = False
    DataSet = TabNFEve
    Left = 35
    Top = 389
  end
  object SouNFEveIte: TDataSource
    AutoEdit = False
    DataSet = TabNFEveIte
    Left = 1021
    Top = 397
  end
  object TabCFOP: TRESTDWClientSQL
    Active = False
    AfterInsert = TabNFEveAfterInsert
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
    SequenceField = 'IDNota'
    MasterCascadeDelete = True
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT * FROM arqcfop ORDER BY Desnat')
    UpdateTableName = 'arqcfop'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 114
    Top = 325
    object TabCFOPIDCFOP: TFDAutoIncField
      FieldName = 'IDCFOP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TabCFOPDesnat: TWideStringField
      FieldName = 'Desnat'
      Size = 180
    end
    object TabCFOPDesNatred: TWideStringField
      FieldName = 'DesNatred'
      Size = 8
    end
    object TabCFOPEntSai: TWideStringField
      FieldName = 'EntSai'
      Size = 1
    end
    object TabCFOPCFOP_EST: TSmallintField
      FieldName = 'CFOP_EST'
    end
    object TabCFOPCFOP_INT: TSmallintField
      FieldName = 'CFOP_INT'
    end
    object TabCFOPCFOP_EST_ST: TSmallintField
      FieldName = 'CFOP_EST_ST'
    end
    object TabCFOPCFOP_INT_ST: TSmallintField
      FieldName = 'CFOP_INT_ST'
    end
    object TabCFOPCFOP_EST_ISE: TSmallintField
      FieldName = 'CFOP_EST_ISE'
    end
    object TabCFOPCFOP_INT_ISE: TSmallintField
      FieldName = 'CFOP_INT_ISE'
    end
    object TabCFOPCFOP_ECF: TSmallintField
      FieldName = 'CFOP_ECF'
    end
    object TabCFOPCFOP_NFCE: TSmallintField
      FieldName = 'CFOP_NFCE'
    end
    object TabCFOPIndRefe: TBooleanField
      FieldName = 'IndRefe'
    end
    object TabCFOPAlteraEnt: TWideStringField
      FieldName = 'AlteraEnt'
      Size = 1
    end
    object TabCFOPMovEst: TWideStringField
      FieldName = 'MovEst'
      Size = 1
    end
  end
  object SouCFOP: TDataSource
    AutoEdit = False
    DataSet = TabCFOP
    Left = 115
    Top = 389
  end
  object TabForPagNF: TRESTDWClientSQL
    Active = False
    AfterInsert = TabNFEveAfterInsert
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
    SequenceField = 'IDNota'
    MasterCascadeDelete = False
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT * FROM arqforpagnf ORDER BY DesForPagNF')
    UpdateTableName = 'arqforpagnf'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 210
    Top = 325
    object TabForPagNFIDForPagNF: TWideStringField
      FieldName = 'IDForPagNF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object TabForPagNFDesForPagNF: TWideStringField
      FieldName = 'DesForPagNF'
      Size = 60
    end
    object TabForPagNFIDGruCard: TBooleanField
      FieldName = 'IDGruCard'
    end
  end
  object SouForPagNF: TDataSource
    AutoEdit = False
    DataSet = TabForPagNF
    Left = 211
    Top = 389
  end
  object TabNFEveIte: TRESTDWClientSQL
    Active = False
    BeforePost = TabNFEveIteBeforePost
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
    MasterDataSet = TabNFEve
    MasterCascadeDelete = True
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <
      item
        DataType = ftString
        Name = 'IDFilial'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IDPed'
        ParamType = ptInput
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      
        'SELECT NFI.*,CLA.DesclaIte,PRO.Despro,ROUND((NFI.Qtdped * NFI.Vl' +
        'runi) - (NFI.Qtdped * NFI.VlrDesc)) AS TotIteCalc FROM arqnfeven' +
        'ite NFI '
      'LEFT JOIN arqproduto PRO ON NFI.IDProd = PRO.IDProd'
      'LEFT JOIN arqclatribite CLA ON NFI.CodClasIte = CLA.CodClasIte'
      
        'WHERE NFI.IDFilial = :IDFilial AND NFI.IDPed = :IDPed ORDER BY N' +
        'FI.IDFilial,NFI.IDPed,NFI.IDItem')
    RelationFields.Strings = (
      'IDFilial=IDFilial'
      'IDPed=IDPed')
    UpdateTableName = 'arqnfevenite'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 1020
    Top = 343
    object TabNFEveIteIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabNFEveIteIDPed: TIntegerField
      FieldName = 'IDPed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabNFEveIteIDItem: TIntegerField
      FieldName = 'IDItem'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabNFEveIteIDProd: TIntegerField
      FieldName = 'IDProd'
    end
    object TabNFEveIteDesitem: TWideStringField
      FieldName = 'Desitem'
      Size = 120
    end
    object TabNFEveIteCodEAN: TWideStringField
      FieldName = 'CodEAN'
      Size = 14
    end
    object TabNFEveIteCodNCM: TWideStringField
      FieldName = 'CodNCM'
      Size = 8
    end
    object TabNFEveIteCodCEST: TWideStringField
      FieldName = 'CodCEST'
      Size = 7
    end
    object TabNFEveIteCSTPisCof: TSmallintField
      FieldName = 'CSTPisCof'
    end
    object TabNFEveIteCST_CSON: TWideStringField
      FieldName = 'CST_CSON'
      Size = 3
    end
    object TabNFEveIteCodClasIte: TWideStringField
      FieldName = 'CodClasIte'
      Size = 6
    end
    object TabNFEveIteUniVen: TWideStringField
      FieldName = 'UniVen'
      Size = 10
    end
    object TabNFEveIteVlruni: TFloatField
      FieldName = 'Vlruni'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveIteQtdped: TFloatField
      FieldName = 'Qtdped'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveIteVlrDesc: TFloatField
      FieldName = 'VlrDesc'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveIteBaseICMS: TFloatField
      FieldName = 'BaseICMS'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveIteAliqICMS: TFloatField
      FieldName = 'AliqICMS'
      DisplayFormat = '##0.00'
    end
    object TabNFEveIteAliqRedICM: TFloatField
      FieldName = 'AliqRedICM'
      DisplayFormat = '##0.00'
    end
    object TabNFEveIteAliqIcmDif: TFloatField
      FieldName = 'AliqIcmDif'
      DisplayFormat = '##0.00'
    end
    object TabNFEveIteAliPis: TFloatField
      FieldName = 'AliPis'
      DisplayFormat = '##0.00'
    end
    object TabNFEveIteAliCof: TFloatField
      FieldName = 'AliCof'
      DisplayFormat = '##0.00'
    end
    object TabNFEveIteBaseST: TFloatField
      FieldName = 'BaseST'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabNFEveIteAliqST: TFloatField
      FieldName = 'AliqST'
      DisplayFormat = '##0.00'
    end
    object TabNFEveIteAliqIS: TFloatField
      FieldName = 'AliqIS'
      DisplayFormat = '##0.00'
    end
    object TabNFEveIteDesclaIte: TWideStringField
      FieldName = 'DesclaIte'
      ProviderFlags = []
      Size = 255
    end
    object TabNFEveIteDespro: TWideStringField
      FieldName = 'Despro'
      ProviderFlags = []
      Size = 120
    end
    object TabNFEveIteTotIteCalc: TFloatField
      FieldName = 'TotIteCalc'
      ProviderFlags = []
      DisplayFormat = '###,###,###,##0.00'
    end
  end
end
