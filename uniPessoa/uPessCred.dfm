object FrmPesCred: TFrmPesCred
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Pessoas Credito'
  ClientHeight = 162
  ClientWidth = 990
  Color = 15855599
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object PanelTrabalho: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 990
    Height = 162
    Align = alClient
    Color = 16382200
    TabOrder = 0
    object Shape1: TShape
      Left = 499
      Top = 12
      Width = 1
      Height = 139
      Pen.Color = 11711154
    end
    object LMDLabel1: TLMDLabel
      Left = 539
      Top = 136
      Width = 86
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'DATA BLOQUEIO'
    end
    object LMDLabel2: TLMDLabel
      Left = 363
      Top = 108
      Width = 93
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'SENHA AUTORIZA'
    end
    object LMDDBLabeledEdit6: TLMDDBLabeledEdit
      Left = 27
      Top = 75
      Width = 314
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 3
      ValidationMsgString = 'O Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      CharCase = ecUpperCase
      ParentFont = False
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'RefPess'
      DataSource = SouPesCred
      LabelSpacing = 2
      EditLabel.Width = 116
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'REFER'#202'NCIA PESSOAL'
    end
    object LMDDBLabeledEdit10: TLMDDBLabeledEdit
      Left = 363
      Top = 75
      Width = 107
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'LimCredito'
      DataSource = SouPesCred
      LabelSpacing = 2
      EditLabel.Width = 83
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'LIMITE CR'#201'DITO'
    end
    object LMDDBLabeledEdit17: TLMDDBLabeledEdit
      Left = 27
      Top = 124
      Width = 314
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'RefCome'
      DataSource = SouPesCred
      LabelSpacing = 2
      EditLabel.Width = 129
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'REFER'#202'NCIA COMERCIAL'
    end
    object LMDDBLabeledEdit19: TLMDDBLabeledEdit
      Left = 627
      Top = 106
      Width = 38
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 9
      OnExit = LMDDBLabeledEdit19Exit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'PerDesc'
      DataSource = SouPesCred
      LabelPosition = lpLeft
      LabelSpacing = 2
      LabelSync = True
      EditLabel.Width = 105
      EditLabel.Height = 23
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = '% DESCON. / JUROS'
    end
    object LMDDBLabeledListComboBox2: TLMDDBLabeledListComboBox
      Left = 27
      Top = 27
      Width = 96
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      Alignment = taCenter
      Items.Strings = (
        'ALUGADA'
        'PR'#211'PRIA')
      ItemIndex = 0
      DropDownCount = 2
      ReadOnly = True
      DataField = 'TipResid'
      DataSource = SouPesCred
      EditLabel.Width = 90
      EditLabel.Height = 15
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'TIPO RESID'#202'NCIA'
    end
    object LMDDBLabeledEdit1: TLMDDBLabeledEdit
      Left = 363
      Top = 27
      Width = 107
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'NroCarFid'
      DataSource = SouPesCred
      LabelSpacing = 2
      EditLabel.Width = 105
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'CART'#195'O FIDELIDADE'
    end
    object LMDDBLabeledListComboBox1: TLMDDBLabeledListComboBox
      Left = 627
      Top = 7
      Width = 108
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 5
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      Items.Strings = (
        'DIA ESPEC'#205'FICO'
        'DIAS CORRIDOS')
      ItemIndex = 0
      DropDownCount = 2
      ReadOnly = True
      DataField = 'FormaVenc'
      DataSource = SouPesCred
      LabelPosition = lpLeft
      LabelSync = True
      EditLabel.Width = 87
      EditLabel.Height = 23
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'FORMA VENCIM.'
    end
    object LMDDBLabeledEdit2: TLMDDBLabeledEdit
      Left = 680
      Top = 106
      Width = 38
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'PerJuro'
      DataSource = SouPesCred
      LabelPosition = lpLeft
      LabelSpacing = 2
      LabelSync = True
      EditLabel.Width = 12
      EditLabel.Height = 23
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = ' / '
    end
    object LMDDBLabeledEdit3: TLMDDBLabeledEdit
      Left = 627
      Top = 32
      Width = 38
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'PrazoPag'
      DataSource = SouPesCred
      LabelPosition = lpLeft
      LabelSync = True
      EditLabel.Width = 89
      EditLabel.Height = 23
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'PRAZO P/ PAGTO'
    end
    object LMDDBLabeledEdit4: TLMDDBLabeledEdit
      Left = 627
      Top = 57
      Width = 38
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 7
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'DiasCaren'
      DataSource = SouPesCred
      LabelPosition = lpLeft
      LabelSync = True
      EditLabel.Width = 97
      EditLabel.Height = 23
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'DIAS DE CAR'#202'NCIA'
    end
    object LMDDBLabeledEdit5: TLMDDBLabeledEdit
      Left = 627
      Top = 81
      Width = 38
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'NroMaxPar'
      DataSource = SouPesCred
      LabelPosition = lpLeft
      LabelSync = True
      EditLabel.Width = 94
      EditLabel.Height = 23
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'N.M'#193'X.PARCELAS'
    end
    object LMDDBCheckBox2: TLMDDBCheckBox
      Left = 792
      Top = 32
      Width = 171
      Height = 20
      Caption = 'Pemite Pre'#231'o Promocional'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      DataField = 'PerPrePro'
      DataSource = SouPesCred
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object LMDDBCheckBox3: TLMDDBCheckBox
      Left = 792
      Top = 57
      Width = 139
      Height = 20
      Caption = 'N'#227'o Gera Comiss'#227'o'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      DataField = 'NaoGerCom'
      DataSource = SouPesCred
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object LMDDBCheckBox4: TLMDDBCheckBox
      Left = 792
      Top = 83
      Width = 180
      Height = 20
      Caption = 'N'#227'o Vender '#224' Prazo P/ Este'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      DataField = 'NaoVenPra'
      DataSource = SouPesCred
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object LMDDBCheckBox5: TLMDDBCheckBox
      Left = 792
      Top = 8
      Width = 167
      Height = 20
      Caption = 'Calcular Juros Por Atraso'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      DataField = 'CalJurAtr'
      DataSource = SouPesCred
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object LMDDBCheckBox6: TLMDDBCheckBox
      Left = 792
      Top = 134
      Width = 155
      Height = 20
      Caption = 'Cliente Negativado SPC'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      DataField = 'CliNegSPC'
      DataSource = SouPesCred
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object LMDDBCheckBox7: TLMDDBCheckBox
      Left = 792
      Top = 108
      Width = 167
      Height = 20
      Caption = 'N'#227'o Bloquear Este Cliente'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      DataField = 'NaoBloVen'
      DataSource = SouPesCred
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object LMDSimplePanel2: TLMDSimplePanel
      Left = 627
      Top = 131
      Width = 95
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Color = clWhite
      TabOrder = 11
      object DBDateEdit1: TDBDateEdit
        AlignWithMargins = True
        Left = 4
        Top = 3
        Width = 88
        Height = 19
        Margins.Top = 2
        Margins.Right = 2
        Align = alClient
        DataField = 'DatBloq'
        DataSource = SouPesCred
        AutoSelect = False
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DialogTitle = 'Entre com Data'
        Font.Charset = ANSI_CHARSET
        Font.Color = 2236186
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        GlyphKind = gkCustom
        Glyph.Data = {
          5E0B0000424D5E0B00000000000036000000280000002D000000150000000100
          180000000000280B000000000000000000000000000000000000241CED241CED
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
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A8AF686B77686B77
          686B77686B77686B77686B77686B77686B77686B77A6A8AFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFA6A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0
          B9B5C0B9B5A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF68
          6B77F7EFEAF5ECE7F4E8E2F2E5DEF1E3DBF0E1D8EFDFD6F2E5DEF2E5DE686B77
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF686B77F9F2EFC2BBB8C0B9B5BFB6B1BEB4AEBDB2ACBCB0A9BD
          B2ACF2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF686B77FAF5F3C3BEBBFFFFFFC0B9B5FFFF
          FFBEB4AEFFFFFFBCB0A9EFDFD6686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF686B77FCF8F7C4C0BF
          C3BEBBC2BBB8C0B9B5BFB6B1BEB4AEBDB2ACF0E1D8686B77FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6
          E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF68
          6B77FDFBFAC6C3C2FFFFFFC3BEBBFFFFFFC0B9B5FFFFFFBEB4AEF1E3DB686B77
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF686B77FEFEFDC6C5C4C6C3C2C4C0BFC3BEBBC2BBB8C0B9B5BF
          B6B1F2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6
          FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF686B77FFFFFFC7C7C6FFFFFFC6C3C2FFFF
          FFC3BEBBFFFFFFC0B9B5F4E8E2686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
          ED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF686B77FFFFFFC8C8C8
          C7C7C6C6C5C4C6C3C2C4C0BFC3BEBBC2BBB8F5ECE7686B77FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6
          E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF68
          6B77FFFFFFFFFFFFFFFFFFFEFEFDFDFBFAFCF8F7FAF5F3F9F2EFF7EFEA686B77
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF686B77FFFFFFC8C8C8C8C8C8C8C8C8C7C7C6C6C5C4C6C3C2C4
          C0BFF9F2EF686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CEDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A8AF686B77686B77686B77686B77686B
          77686B77686B77686B77686B77A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6
          A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5A6A8AF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
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
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED00241CED241CED
          241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
          ED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED24
          1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
          241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
          ED00}
        NumGlyphs = 2
        ParentCtl3D = False
        ParentFont = False
        PopupColor = 15461355
        TabOrder = 0
      end
    end
    object edSenha: TLMDEdit
      Left = 363
      Top = 124
      Width = 107
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15000804
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Bevel.ShadowColor = 10526880
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 14
      Font.Charset = SYMBOL_CHARSET
      Font.Color = 5590594
      Font.Height = -15
      Font.Name = 'Roboto'
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #171
      Spelling.LiveSpell = True
      Text = ''
    end
  end
  object TabPesCred: TRESTDWClientSQL
    Active = False
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
      'SELECT * FROM arqpesscred LIMIT 1'
      ''
      ''
      ''
      ''
      '')
    UpdateTableName = 'arqpesscred'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 207
    Top = 15
    object TabPesCredIDPess: TIntegerField
      FieldName = 'IDPess'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPesCredLimCredito: TFloatField
      FieldName = 'LimCredito'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPesCredPrazoPag: TSmallintField
      FieldName = 'PrazoPag'
    end
    object TabPesCredDiasCaren: TSmallintField
      FieldName = 'DiasCaren'
    end
    object TabPesCredNroMaxPar: TSmallintField
      FieldName = 'NroMaxPar'
    end
    object TabPesCredPerDesc: TFloatField
      FieldName = 'PerDesc'
      DisplayFormat = '###0.00'
    end
    object TabPesCredPerJuro: TFloatField
      FieldName = 'PerJuro'
      DisplayFormat = '###0.00'
    end
    object TabPesCredDatBloq: TDateField
      FieldName = 'DatBloq'
    end
    object TabPesCredTipResid: TWideStringField
      FieldName = 'TipResid'
      Size = 9
    end
    object TabPesCredRefPess: TWideStringField
      FieldName = 'RefPess'
      Size = 60
    end
    object TabPesCredRefCome: TWideStringField
      FieldName = 'RefCome'
      Size = 60
    end
    object TabPesCredNroCarFid: TIntegerField
      FieldName = 'NroCarFid'
    end
    object TabPesCredSenVenPra: TWideStringField
      FieldName = 'SenVenPra'
      Size = 16
    end
    object TabPesCredFormaVenc: TWideStringField
      FieldName = 'FormaVenc'
    end
    object TabPesCredCalJurAtr: TBooleanField
      FieldName = 'CalJurAtr'
    end
    object TabPesCredPerPrePro: TBooleanField
      FieldName = 'PerPrePro'
    end
    object TabPesCredNaoGerCom: TBooleanField
      FieldName = 'NaoGerCom'
    end
    object TabPesCredNaoVenPra: TBooleanField
      FieldName = 'NaoVenPra'
    end
    object TabPesCredNaoBloVen: TBooleanField
      FieldName = 'NaoBloVen'
    end
    object TabPesCredCliNegSPC: TBooleanField
      FieldName = 'CliNegSPC'
    end
  end
  object SouPesCred: TDataSource
    DataSet = TabPesCred
    Left = 287
    Top = 14
  end
end
