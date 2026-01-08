object FrmConfig: TFrmConfig
  AlignWithMargins = True
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'Configura'#231#245'es gerais'
  ClientHeight = 721
  ClientWidth = 1141
  Color = 4144959
  TransparentColorValue = 4605510
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 14
  object PanelBas: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1141
    Height = 721
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
    Caption.Line = False
    Fill.Color = 15399935
    Fill.ColorTo = 10146044
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = clNone
    Fill.BorderOpacity = 0
    Fill.BorderWidth = 0
    Fill.Rounding = 8
    Fill.ShadowColor = clNone
    Fill.ShadowOffset = 0
    Fill.ShadowType = stSurround
    Fill.Glow = gmNone
    Fill.GlowGradientColor = clNone
    Fill.GlowRadialColor = clNone
    Version = '1.7.1.6'
    Align = alClient
    TabOrder = 0
    TMSStyle = 0
    object PanelCenter: TLMDSimplePanel
      Left = 94
      Top = 82
      Width = 953
      Height = 543
      Bevel.BorderColor = 16053492
      Color = 16381943
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object PanelCaixa: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = 16514043
        TabOrder = 6
        object pnFormasPagto: TLMDSimplePanel
          AlignWithMargins = True
          Left = 438
          Top = 31
          Width = 494
          Height = 455
          Margins.Left = 30
          Margins.Top = 30
          Margins.Right = 20
          Margins.Bottom = 30
          Align = alRight
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 13553358
          Bevel.BorderWidth = 1
          Color = 16447736
          TabOrder = 0
          object DBGrid1: TDBGrid
            Tag = 1
            AlignWithMargins = True
            Left = 1
            Top = 1
            Width = 492
            Height = 453
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = SouForPagto
            DrawingStyle = gdsGradient
            FixedColor = 16447736
            GradientEndColor = 16447736
            GradientStartColor = 16447736
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = 5131854
            TitleFont.Height = -13
            TitleFont.Name = 'Roboto'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            OnDrawColumnCell = DBGrid1DrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'DesForPag'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Roboto'
                Font.Style = []
                Title.Alignment = taCenter
                Title.Caption = 'FORMAS DE PAGAMENTO'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = 5131854
                Title.Font.Height = -12
                Title.Font.Name = 'Roboto'
                Title.Font.Style = []
                Width = 164
                Visible = True
              end
              item
                DropDownRows = 10
                Expanded = False
                FieldName = 'DesForPagNFLook'
                ReadOnly = False
                Title.Alignment = taCenter
                Title.Caption = 'FORMA DE PAGAMENTO NF'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = 5131854
                Title.Font.Height = -12
                Title.Font.Name = 'Roboto'
                Title.Font.Style = []
                Width = 210
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'IndPagVis'
                ReadOnly = False
                Title.Alignment = taCenter
                Title.Caption = #192' VISTA'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = 5131854
                Title.Font.Height = -12
                Title.Font.Name = 'Roboto'
                Title.Font.Style = []
                Width = 57
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'IndAtivo'
                Title.Alignment = taCenter
                Title.Caption = 'ATIVO'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = 5131854
                Title.Font.Height = -12
                Title.Font.Name = 'Roboto'
                Title.Font.Style = []
                Width = 41
                Visible = True
              end>
          end
        end
        object LMDSimplePanel2: TLMDSimplePanel
          AlignWithMargins = True
          Left = 21
          Top = 31
          Width = 394
          Height = 455
          Margins.Left = 20
          Margins.Top = 30
          Margins.Right = 0
          Margins.Bottom = 30
          Align = alLeft
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 13553358
          Bevel.BorderWidth = 1
          Color = clWhite
          TabOrder = 1
          object LMDLabel34: TLMDLabel
            Left = 15
            Top = 303
            Width = 215
            Height = 16
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6118749
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            Options = []
            ParentFont = False
            Caption = '8 - LIMITE VALOR BLOQUEIO DE CAIXA'
          end
          object LMDLabel35: TLMDLabel
            Left = 16
            Top = 337
            Width = 209
            Height = 16
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6118749
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            Options = []
            ParentFont = False
            Caption = '9 - LIMITE ARREDONDAMENTO CAIXA'
          end
          object LMDLabel39: TLMDLabel
            Left = 16
            Top = 267
            Width = 147
            Height = 16
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6118749
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            Options = []
            ParentFont = False
            Caption = '7 - EFETIVA'#199#195'O DE CAIXA'
          end
          object Shape6: TShape
            Left = 16
            Top = 246
            Width = 363
            Height = 1
            Pen.Color = 13553358
          end
          object cbIndCxEfetiva: TLMDLabeledListComboBox
            Left = 236
            Top = 268
            Width = 130
            Height = 21
            Bevel.StyleOuter = bvNormal
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 15657192
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            TabOrder = 6
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6118749
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Items.Strings = (
              'TODO MOVIMENTO'
              'APENAS VENDAS')
            ItemIndex = 0
            LabelPosition = lpLeft
            LabelSpacing = -10
            LabelSync = True
            EditLabel.Width = 9
            EditLabel.Height = 21
            EditLabel.AutoSize = False
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = 7039851
            EditLabel.Font.Height = -12
            EditLabel.Font.Name = 'Roboto'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            EditLabel.Visible = False
            EditLabel.Caption = '2'
          end
          object LMDDBCheckBox12: TLMDDBCheckBox
            Left = 12
            Top = 26
            Width = 127
            Height = 17
            Caption = '1 - CAIXA CEGO'
            Alignment.Alignment = agTopLeft
            Alignment.Spacing = 4
            TabOrder = 0
            DataSource = SouParam
            ValueChecked = '0'
            ValueUnchecked = '1'
          end
          object LMDDBCheckBox13: TLMDDBCheckBox
            Left = 12
            Top = 63
            Width = 183
            Height = 17
            Caption = '2 - CONFER'#202'NCIA DE ITENS'
            Alignment.Alignment = agTopLeft
            Alignment.Spacing = 4
            TabOrder = 1
            DataField = 'IndCxConfereIte'
            DataSource = SouParam
            ValueChecked = '0'
            ValueUnchecked = '1'
          end
          object LMDDBCheckBox14: TLMDDBCheckBox
            Left = 12
            Top = 99
            Width = 370
            Height = 17
            Caption = '3 - PODE ENTRAR QUANTIDADE CONFERIDA MANUALMENTE'
            Alignment.Alignment = agTopLeft
            Alignment.Spacing = 4
            TabOrder = 2
            DataField = 'IndCxDigQtdConfMan'
            DataSource = SouParam
            ValueChecked = '0'
            ValueUnchecked = '1'
          end
          object LMDDBCheckBox15: TLMDDBCheckBox
            Left = 12
            Top = 136
            Width = 346
            Height = 17
            Caption = '4 - PERMITE BUSCAR ITENS POR NOME NA CONFER'#202'NCIA'
            Alignment.Alignment = agTopLeft
            Alignment.Spacing = 4
            TabOrder = 3
            DataField = 'IndCxBusIteNomeConf'
            DataSource = SouParam
            ValueChecked = '0'
            ValueUnchecked = '1'
          end
          object LMDDBCheckBox16: TLMDDBCheckBox
            Left = 12
            Top = 172
            Width = 361
            Height = 17
            Caption = '5 - BLOQUEAR SANGRIA QUANDO  SALDO DO CAIXA ZERADO'
            Alignment.Alignment = agTopLeft
            Alignment.Spacing = 4
            TabOrder = 4
            DataField = 'IndCxBloqSangria'
            DataSource = SouParam
            ValueChecked = '0'
            ValueUnchecked = '1'
          end
          object LMDDBCheckBox17: TLMDDBCheckBox
            Left = 12
            Top = 209
            Width = 301
            Height = 17
            Caption = '6 - IMPRIME AUDITORIA FECHAMENTO DO CAIXA'
            Alignment.Alignment = agTopLeft
            Alignment.Spacing = 4
            TabOrder = 5
            DataField = 'IndCxImpAudiFecha'
            DataSource = SouParam
            ValueChecked = '0'
            ValueUnchecked = '1'
          end
          object LMDDBLabeledEdit30: TLMDDBLabeledEdit
            Left = 236
            Top = 300
            Width = 130
            Height = 21
            Bevel.StyleOuter = bvNormal
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 14737632
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            TabOrder = 7
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6118749
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CustomButtons = <>
            DataField = 'IndCxLimVlrBloqueio'
            DataSource = SouParam
            LabelSpacing = -15
            EditLabel.Width = 121
            EditLabel.Height = 16
            EditLabel.Caption = 'LMDDBLabeledEdit30'
          end
          object LMDDBLabeledEdit31: TLMDDBLabeledEdit
            Left = 236
            Top = 333
            Width = 130
            Height = 21
            Bevel.StyleOuter = bvNormal
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 14737632
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            TabOrder = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6118749
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            Alignment = taRightJustify
            CustomButtons = <>
            DataField = 'IndCxLimArrenCaixa'
            DataSource = SouParam
            LabelSpacing = -15
            EditLabel.Width = 121
            EditLabel.Height = 16
            EditLabel.Caption = 'LMDDBLabeledEdit30'
          end
        end
      end
      object PanelImpos: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = 16514043
        TabOrder = 8
        object LMDSimplePanel4: TLMDSimplePanel
          AlignWithMargins = True
          Left = 256
          Top = 11
          Width = 684
          Height = 495
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alLeft
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 13948116
          Bevel.BorderWidth = 1
          Color = 16514043
          TabOrder = 1
          object LMDSimplePanel6: TLMDSimplePanel
            AlignWithMargins = True
            Left = 11
            Top = 11
            Width = 662
            Height = 53
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 13948116
            Bevel.BorderWidth = 1
            Color = 16514043
            TabOrder = 0
            object LMDDBLabeledEdit17: TLMDDBLabeledEdit
              Left = 235
              Top = 21
              Width = 54
              Height = 23
              Hint = 'Al'#237'quota IBS Municipal'
              Bevel.StyleOuter = bvNormal
              Bevel.WidthOuter = 0
              Bevel.BorderColor = 14602705
              Bevel.BorderWidth = 1
              Bevel.Mode = bmCustom
              Caret.BlinkRate = 530
              Color = clWhite
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7039851
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              CharCase = ecUpperCase
              ParentFont = False
              Alignment = taCenter
              CustomButtons = <>
              TabOnEnter = True
              DataField = 'AliqIBSMun'
              DataSource = SouParam
              LabelSpacing = 1
              EditLabel.Width = 58
              EditLabel.Height = 15
              EditLabel.Font.Charset = DEFAULT_CHARSET
              EditLabel.Font.Color = 9600112
              EditLabel.Font.Height = -11
              EditLabel.Font.Name = 'Roboto'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              EditLabel.Caption = '% IBS Mun.'
            end
            object LMDDBLabeledEdit18: TLMDDBLabeledEdit
              Left = 374
              Top = 21
              Width = 54
              Height = 23
              Hint = 'Al'#237'quota CBS'
              Bevel.StyleOuter = bvNormal
              Bevel.WidthOuter = 0
              Bevel.BorderColor = 14602705
              Bevel.BorderWidth = 1
              Bevel.Mode = bmCustom
              Caret.BlinkRate = 530
              Color = clWhite
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7039851
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              CharCase = ecUpperCase
              ParentFont = False
              Alignment = taCenter
              CustomButtons = <>
              TabOnEnter = True
              DataField = 'AliqCBS'
              DataSource = SouParam
              LabelSpacing = 1
              EditLabel.Width = 56
              EditLabel.Height = 15
              EditLabel.Font.Charset = DEFAULT_CHARSET
              EditLabel.Font.Color = 9600112
              EditLabel.Font.Height = -11
              EditLabel.Font.Name = 'Roboto'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              EditLabel.Caption = '% Aliq.CBS'
            end
            object LMDDBLabeledEdit19: TLMDDBLabeledEdit
              Left = 304
              Top = 21
              Width = 54
              Height = 23
              Hint = 'Al'#237'quota IBS Estadual'
              Bevel.StyleOuter = bvNormal
              Bevel.WidthOuter = 0
              Bevel.BorderColor = 14602705
              Bevel.BorderWidth = 1
              Bevel.Mode = bmCustom
              Caret.BlinkRate = 530
              Color = clWhite
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7039851
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              CharCase = ecUpperCase
              ParentFont = False
              Alignment = taCenter
              CustomButtons = <>
              TabOnEnter = True
              DataField = 'AliqIBSEst'
              DataSource = SouParam
              LabelSpacing = 1
              EditLabel.Width = 52
              EditLabel.Height = 15
              EditLabel.Font.Charset = DEFAULT_CHARSET
              EditLabel.Font.Color = 9600112
              EditLabel.Font.Height = -11
              EditLabel.Font.Name = 'Roboto'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              EditLabel.Caption = '% IBS Est.'
            end
          end
          object LMDSimplePanel7: TLMDSimplePanel
            AlignWithMargins = True
            Left = 11
            Top = 77
            Width = 662
            Height = 407
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alBottom
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 13948116
            Bevel.BorderWidth = 1
            Color = 16514043
            TabOrder = 1
            object DBGrid3: TDBGrid
              AlignWithMargins = True
              Left = 1
              Top = 1
              Width = 660
              Height = 405
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alClient
              BorderStyle = bsNone
              Color = clWhite
              DataSource = SouClaTribIte
              DrawingStyle = gdsGradient
              FixedColor = 15790320
              GradientEndColor = 14408667
              GradientStartColor = 14408667
              Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = 7039851
              TitleFont.Height = -12
              TitleFont.Name = 'Roboto'
              TitleFont.Style = []
              OnDrawColumnCell = DBGrid1DrawColumnCell
              Columns = <
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'CodClasIte'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Roboto'
                  Font.Style = []
                  Title.Alignment = taCenter
                  Title.Caption = 'C'#211'DIGO'
                  Title.Color = 1513239
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = 1513239
                  Title.Font.Height = -12
                  Title.Font.Name = 'Roboto'
                  Title.Font.Style = [fsBold]
                  Width = 73
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DesClaIte'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Roboto'
                  Font.Style = []
                  Title.Alignment = taCenter
                  Title.Caption = 'DESCRI'#199#195'O DA CLASSIFICA'#199#195'O IS'
                  Title.Color = 1513239
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = 1513239
                  Title.Font.Height = -12
                  Title.Font.Name = 'Roboto'
                  Title.Font.Style = [fsBold]
                  Width = 449
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'PerRedIBS'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Roboto'
                  Font.Style = []
                  Title.Alignment = taCenter
                  Title.Caption = '% RED IBS'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = 1513239
                  Title.Font.Height = -11
                  Title.Font.Name = 'Roboto'
                  Title.Font.Style = [fsBold]
                  Width = 58
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PerRedCBS'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Roboto'
                  Font.Style = []
                  Title.Alignment = taCenter
                  Title.Caption = '% RED CBS'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = 7039851
                  Title.Font.Height = -11
                  Title.Font.Name = 'Roboto'
                  Title.Font.Style = [fsBold]
                  Width = 58
                  Visible = True
                end>
            end
          end
        end
        object LMDSimplePanel3: TLMDSimplePanel
          AlignWithMargins = True
          Left = 11
          Top = 11
          Width = 225
          Height = 495
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alLeft
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 13948116
          Bevel.BorderWidth = 1
          Color = 16514043
          TabOrder = 0
          object LMDSimplePanel5: TLMDSimplePanel
            AlignWithMargins = True
            Left = 11
            Top = 11
            Width = 203
            Height = 53
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alTop
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 13948116
            Bevel.BorderWidth = 1
            Color = 16514043
            TabOrder = 0
            object LMDDBLabeledEdit13: TLMDDBLabeledEdit
              Left = 10
              Top = 21
              Width = 54
              Height = 23
              Hint = '% PIS'
              Bevel.StyleOuter = bvNormal
              Bevel.WidthOuter = 0
              Bevel.BorderColor = 14602705
              Bevel.BorderWidth = 1
              Bevel.Mode = bmCustom
              Caret.BlinkRate = 530
              Color = clWhite
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7039851
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              CharCase = ecUpperCase
              ParentFont = False
              Alignment = taCenter
              CustomButtons = <>
              TabOnEnter = True
              DataField = 'PercPIS'
              DataSource = SouParam
              LabelSpacing = 1
              EditLabel.Width = 30
              EditLabel.Height = 15
              EditLabel.Font.Charset = DEFAULT_CHARSET
              EditLabel.Font.Color = 9600112
              EditLabel.Font.Height = -11
              EditLabel.Font.Name = 'Roboto'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              EditLabel.Caption = '% PIS'
            end
            object LMDDBLabeledEdit15: TLMDDBLabeledEdit
              Left = 74
              Top = 21
              Width = 54
              Height = 23
              Hint = '% COFINS'
              Bevel.StyleOuter = bvNormal
              Bevel.WidthOuter = 0
              Bevel.BorderColor = 14602705
              Bevel.BorderWidth = 1
              Bevel.Mode = bmCustom
              Caret.BlinkRate = 530
              Color = clWhite
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7039851
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              CharCase = ecUpperCase
              ParentFont = False
              Alignment = taCenter
              CustomButtons = <>
              TabOnEnter = True
              DataField = 'PerCOFINS'
              DataSource = SouParam
              LabelSpacing = 1
              EditLabel.Width = 52
              EditLabel.Height = 15
              EditLabel.Font.Charset = DEFAULT_CHARSET
              EditLabel.Font.Color = 9600112
              EditLabel.Font.Height = -11
              EditLabel.Font.Name = 'Roboto'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              EditLabel.Caption = '% COFINS'
            end
            object LMDDBLabeledEdit29: TLMDDBLabeledEdit
              Left = 138
              Top = 21
              Width = 54
              Height = 23
              Hint = '% Cr'#233'dito ICMS Simples Nacional'
              Bevel.StyleOuter = bvNormal
              Bevel.WidthOuter = 0
              Bevel.BorderColor = 14602705
              Bevel.BorderWidth = 1
              Bevel.Mode = bmCustom
              Caret.BlinkRate = 530
              Color = clWhite
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7039851
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              CharCase = ecUpperCase
              ParentFont = False
              Alignment = taCenter
              CustomButtons = <>
              TabOnEnter = True
              DataField = 'PerCreICMSSN'
              DataSource = SouParam
              LabelSpacing = 1
              EditLabel.Width = 58
              EditLabel.Height = 15
              EditLabel.Font.Charset = DEFAULT_CHARSET
              EditLabel.Font.Color = 9600112
              EditLabel.Font.Height = -11
              EditLabel.Font.Name = 'Roboto'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              EditLabel.Caption = '% CRED.SN'
            end
          end
          object LMDSimplePanel1: TLMDSimplePanel
            AlignWithMargins = True
            Left = 11
            Top = 77
            Width = 203
            Height = 407
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Align = alBottom
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 13948116
            Bevel.BorderWidth = 1
            Color = 16514043
            TabOrder = 1
            object DBGrid2: TDBGrid
              AlignWithMargins = True
              Left = 1
              Top = 1
              Width = 201
              Height = 405
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alClient
              BorderStyle = bsNone
              Color = clWhite
              DataSource = SouICMS
              DrawingStyle = gdsGradient
              FixedColor = 15790320
              GradientEndColor = 14408667
              GradientStartColor = 14408667
              Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = 7039851
              TitleFont.Height = -12
              TitleFont.Name = 'Roboto'
              TitleFont.Style = []
              OnDrawColumnCell = DBGrid1DrawColumnCell
              Columns = <
                item
                  Alignment = taCenter
                  Color = 14674687
                  Expanded = False
                  FieldName = 'UFICMS'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 7039851
                  Font.Height = -13
                  Font.Name = 'Roboto'
                  Font.Style = [fsBold]
                  ReadOnly = True
                  Title.Alignment = taCenter
                  Title.Caption = 'UF'
                  Title.Color = 1513239
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = 1513239
                  Title.Font.Height = -13
                  Title.Font.Name = 'Roboto'
                  Title.Font.Style = []
                  Width = 43
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'PerICMS'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 7039851
                  Font.Height = -13
                  Font.Name = 'Roboto'
                  Font.Style = []
                  Title.Alignment = taCenter
                  Title.Caption = '% ICMS INT.'
                  Title.Color = 1513239
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = 1513239
                  Title.Font.Height = -13
                  Title.Font.Name = 'Roboto'
                  Title.Font.Style = []
                  Width = 83
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'PerFCP'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 7039851
                  Font.Height = -13
                  Font.Name = 'Roboto'
                  Font.Style = []
                  Title.Alignment = taCenter
                  Title.Caption = '% FCP '
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = 1513239
                  Title.Font.Height = -13
                  Title.Font.Name = 'Roboto'
                  Title.Font.Style = []
                  Width = 55
                  Visible = True
                end>
            end
          end
        end
      end
      object PanelContas: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 2
        object Shape18: TShape
          Left = 35
          Top = 290
          Width = 884
          Height = 1
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 13555967
        end
        object edNatFinVlrDevo: TLMDDBLabeledEdit
          Left = 87
          Top = 90
          Width = 344
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 1
          OnKeyDown = edNatFinVlrDevoKeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edDesNatEntCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'DesnatDEV'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 5
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = ' '
        end
        object edCodNatFinVlrDevo: TLMDDBLabeledEdit
          Left = 49
          Top = 90
          Width = 32
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          OnExit = edCodNatFinVlrDevoExit
          ValidationMsgString = 'NATUREZA PIS / COFINS ENTRADAS '
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDNatFinVlrDevo'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 284
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '01 - NATUREZA FINANCEIRA DEVOLU'#199#195'O DE COMPRAS'
        end
        object edNatFinDesAce: TLMDDBLabeledEdit
          Left = 87
          Top = 141
          Width = 344
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 3
          OnKeyDown = edNatFinDesAceKeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edNatFinDesAceCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'DesnatACE'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 5
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = ' '
        end
        object edCodNatFinDesAce: TLMDDBLabeledEdit
          Left = 49
          Top = 142
          Width = 32
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 2
          OnExit = edCodNatFinDesAceExit
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDNatFinDesAce'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 271
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '02 - NATUREZA FINANCEIRA DESPESAS ACESS'#211'RIAS'
        end
        object edNatFinDesAsso: TLMDDBLabeledEdit
          Left = 87
          Top = 194
          Width = 344
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 5
          OnKeyDown = edNatFinDesAssoKeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edNatFinDesAssoCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'DesnatASS'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 5
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = ' '
        end
        object edCodNatFinDesAsso: TLMDDBLabeledEdit
          Left = 49
          Top = 194
          Width = 32
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 4
          OnExit = edCodNatFinDesAssoExit
          ValidationMsgString = 'NATUREZA PIS / COFINS ENTRADAS '
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDNatFinDesAsso'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 283
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '03 - NATUREZA FINANCEIRA DESCONTOS ASSOCIADOS'
        end
        object edNatFinVlrJur: TLMDDBLabeledEdit
          Left = 87
          Top = 246
          Width = 344
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 7
          OnKeyDown = edNatFinVlrJurKeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edNatFinVlrJurCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'DesnatVLJ'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 67
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'edDesNatEnt'
        end
        object edCodNatFinVlrJur: TLMDDBLabeledEdit
          Left = 49
          Top = 246
          Width = 32
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 6
          OnExit = edCodNatFinVlrJurExit
          ValidationMsgString = 'NATUREZA PIS / COFINS ENTRADAS '
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDNatFinVlrJur'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 247
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '04 - NATUREZA FINANCEIRA VALOR DOS JUROS'
        end
        object edNatFinPerJur: TLMDDBLabeledEdit
          Left = 559
          Top = 92
          Width = 344
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 9
          OnKeyDown = edNatFinPerJurKeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edNatFinPerJurCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'DesnatPEJ'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 67
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'edDesNatEnt'
        end
        object edCodNatFinPerJur: TLMDDBLabeledEdit
          Left = 521
          Top = 90
          Width = 32
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 8
          OnExit = edCodNatFinPerJurExit
          ValidationMsgString = 'NATUREZA PIS / COFINS ENTRADAS '
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDNatFinPerJur'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 195
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '05 - NATUREZA FINANCEIRA % JUROS'
        end
        object edNatFinVlrMul: TLMDDBLabeledEdit
          Left = 559
          Top = 142
          Width = 344
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 11
          OnKeyDown = edNatFinVlrMulKeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edNatFinVlrMulCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'DesnatVLM'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 5
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = ' '
        end
        object edCodNatFinVlrMul: TLMDDBLabeledEdit
          Left = 521
          Top = 142
          Width = 32
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 10
          OnExit = edCodNatFinVlrMulExit
          ValidationMsgString = 'NATUREZA PIS / COFINS ENTRADAS '
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDNatFinVlrMul'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 230
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '06 - NATUREZA FINANCEIRA VALOR MULTAS'
        end
        object edNatFinPerMul: TLMDDBLabeledEdit
          Left = 559
          Top = 194
          Width = 344
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 13
          OnKeyDown = edNatFinPerMulKeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edNatFinPerMulCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'DesnatPEM'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 67
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'edDesNatEnt'
        end
        object edCodNatFinPerMul: TLMDDBLabeledEdit
          Left = 522
          Top = 194
          Width = 32
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 12
          OnExit = edCodNatFinPerMulExit
          ValidationMsgString = 'NATUREZA PIS / COFINS ENTRADAS '
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDNatFinPerMul'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 203
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '07 - NATUREZA FINANCEIRA % MULTAS'
        end
        object LMDDBLabeledEdit8: TLMDDBLabeledEdit
          Left = 49
          Top = 323
          Width = 382
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 14
          OnKeyDown = LMDDBLabeledEdit8KeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBLabeledEdit8CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'NomConCreSup'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 231
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '08 - CONTA CR'#201'DITO SUPRIMENTO DE CAIXA'
        end
        object LMDDBLabeledEdit9: TLMDDBLabeledEdit
          Left = 521
          Top = 325
          Width = 382
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 15
          OnKeyDown = LMDDBLabeledEdit9KeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBLabeledEdit9CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'NomConDebSup'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 224
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '09 - CONTA D'#201'BITO SUPRIMENTO DE CAIXA'
        end
        object LMDDBLabeledEdit10: TLMDDBLabeledEdit
          Left = 49
          Top = 378
          Width = 382
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 16
          OnKeyDown = LMDDBLabeledEdit10KeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBLabeledEdit10CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'NomConCreSan'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 207
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '10 - CONTA CR'#201'DITO SANGRIA DE CAIXA'
        end
        object LMDDBLabeledEdit7: TLMDDBLabeledEdit
          Left = 521
          Top = 378
          Width = 382
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14998748
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 17
          OnKeyDown = LMDDBLabeledEdit7KeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBLabeledEdit7CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'NomConDebSan'
          DataSource = SouParam
          LabelSpacing = 2
          EditLabel.Width = 200
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = '11 - CONTA D'#201'BITO SANGRIA DE CAIXA'
        end
      end
      object PanelSNGPC: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 5
        object lbCamGerArq: TLMDLabel
          Left = 88
          Top = 309
          Width = 256
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '12 - CAMINHO DE GERA'#199#195'O DE ARQUIVO XML'
        end
        object lbTipEnv: TLMDLabel
          Left = 88
          Top = 340
          Width = 108
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '13 - TIPO DE ENVIO'
        end
        object lbBloVenConVenDia: TLMDLabel
          Left = 88
          Top = 279
          Width = 355
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '11 - BLOQUEAR VENDAS COM CONTROLADOS QUE VENCEM EM '
        end
        object lbDefTipRecLis: TLMDLabel
          Left = 88
          Top = 371
          Width = 231
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '14 - DEFINIR TIPO DE RECEITA POR LISTA'
        end
        object LMDLabel1: TLMDLabel
          Left = 489
          Top = 279
          Width = 28
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6316128
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = 'DIAS'
        end
        object Shape2: TShape
          Left = 63
          Top = 253
          Width = 840
          Height = 1
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 13555967
        end
        object ckContSNGPC: TLMDDBCheckBox
          Left = 88
          Top = 82
          Width = 379
          Height = 17
          HelpType = htKeyword
          Caption = '01 - CONTROLE DE SNGPC'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 206
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          OnClick = ckContSNGPCClick
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          DataField = 'ControleSNGPC'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckCadCompCom: TLMDDBCheckBox
          Left = 88
          Top = 113
          Width = 381
          Height = 17
          Caption = '02 - CADASTRO DE COMPRADOR COMPLETO'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 104
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 1
          OnClick = ckCadCompComClick
          DataField = 'CadComCom'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckSNGPCObrCom: TLMDDBCheckBox
          Left = 88
          Top = 145
          Width = 381
          Height = 17
          Caption = '03 - SNGPC OBRIGAT'#211'RIO NA COMPRA'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 136
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 2
          OnClick = ckSNGPCObrComClick
          DataField = 'SNGPCObrCompra'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckSNGPCObrVen: TLMDDBCheckBox
          Left = 88
          Top = 177
          Width = 381
          Height = 17
          Caption = '04 - SNGPC OBRIGAT'#211'RIO NA VENDA'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 147
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 3
          OnClick = ckSNGPCObrVenClick
          DataField = 'SNGPCObrVenda'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckQuantPresRec: TLMDDBCheckBox
          Left = 88
          Top = 209
          Width = 381
          Height = 17
          Caption = '05 - INFORMAR QUANTIDADE PRESCRITA NA RECEITA'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 54
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 4
          OnClick = ckQuantPresRecClick
          DataField = 'InfQuanPreRec'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckConInsMan: TLMDDBCheckBox
          Left = 516
          Top = 82
          Width = 380
          Height = 17
          Caption = '06 - CONTROLE DE INSUMOS MANIPULA'#199#195'O'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 107
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 5
          OnClick = ckConInsManClick
          DataField = 'ConInsMan'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckCadObrVenSNGPC: TLMDDBCheckBox
          Left = 516
          Top = 114
          Width = 381
          Height = 17
          Caption = '07 - CADASTRO OBRIGAT'#211'RIO EM VENDAS SNGPC'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 74
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 6
          OnClick = ckCadObrVenSNGPCClick
          DataField = 'CadObrVenSNGPC'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckSNGPCObrPerProd: TLMDDBCheckBox
          Left = 516
          Top = 146
          Width = 377
          Height = 17
          Caption = '08 - SNGPC OBRIGAT'#211'RIO EM PERDAS DE PRODUTOS'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 56
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 7
          OnClick = ckSNGPCObrPerProdClick
          DataField = 'SNGPCObrPerPro'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckSolConFar: TLMDDBCheckBox
          Left = 516
          Top = 178
          Width = 377
          Height = 17
          Caption = '09 - SOLICITAR CONFIRMA'#199#195'O DO FARMAC'#202'UTICO'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 69
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 8
          OnClick = ckSolConFarClick
          DataField = 'SolConFar'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckImpEtiRecSNGPC: TLMDDBCheckBox
          Left = 516
          Top = 210
          Width = 377
          Height = 17
          Caption = '10 - IMPRIMIR ETIQUETA DE RECEITA SNGPC'
          Alignment.Alignment = agTopLeft
          Alignment.AlignText2Glyph = taLeft
          Alignment.Spacing = 105
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          MultiLine = False
          ParentFont = False
          TabOrder = 9
          OnClick = ckImpEtiRecSNGPCClick
          DataField = 'ImpEtiRecSNGPC'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object edCaminho: TLMDDBLabeledEdit
          Left = 448
          Top = 306
          Width = 297
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 12566463
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Bevel.StandardStyle = lsDoubleLowered
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 11
          OnExit = edCaminhoExit
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 22
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'CamGerArqXML'
          DataSource = SouParam
          LabelSpacing = 0
          EditLabel.Width = 5
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = ' '
        end
        object btBuscar: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 720
          Top = 308
          Width = 19
          Height = 17
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
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
          Picture.Data = {
            89504E470D0A1A0A0000000D49484452000000110000000F0804000000A8B8EC
            9A000000097048597300000B1300000B1301009A9C18000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000000FA4944415478DA84D0BF2A057018C6F1CFEBC8A1386721E57F89A2
            9470940C16938D0B60B45ADD84C51D58B8052B91325814750622A1C4491C247E
            068E5078BFF3F37C7BDE48FEBB2A227D652EF98E4822A579FDCE15E4E5A3F0A3
            37AAC0801979250D10DFA01A34D8D6E7C588A554D2A8DE7BB425EA2A22CE9C28
            BA7767D295870FC95834A58824FE1C95A21A528757395943C60DE99275A9C69A
            E198A88856EDD95294F3A25697AC473D76F5C6CA478B4EAD16AD3BB4EFD98D9C
            63ED92299F8BEA6DDA1576749BB6ACCFB382B25A2AA2537B8E3C7972AEECC0B5
            8C8236CDB150116DC86893D0EFD6A80B650FF60DBE8F22FDCE6CFAEF29E06D00
            FB056E61E129F6980000000049454E44AE426082}
          Rounded = False
          Spacing = 7
          TabOrder = 12
          OnClick = btBuscarClick
          Appearance.BorderColor = clWhite
          Appearance.BorderColorHot = clWhite
          Appearance.BorderColorCheckedHot = clWhite
          Appearance.BorderColorDown = clWhite
          Appearance.BorderColorChecked = clWhite
          Appearance.BorderColorDisabled = clWhite
          Appearance.BorderColorFocused = clWhite
          Appearance.Color = clWhite
          Appearance.ColorTo = clWhite
          Appearance.ColorChecked = clWhite
          Appearance.ColorCheckedTo = clWhite
          Appearance.ColorDisabled = clWhite
          Appearance.ColorDisabledTo = clWhite
          Appearance.ColorDown = clWhite
          Appearance.ColorDownTo = clWhite
          Appearance.ColorHot = clWhite
          Appearance.ColorHotTo = clWhite
          Appearance.ColorMirror = clWhite
          Appearance.ColorMirrorTo = clWhite
          Appearance.ColorMirrorHot = clWhite
          Appearance.ColorMirrorHotTo = clWhite
          Appearance.ColorMirrorDown = clWhite
          Appearance.ColorMirrorDownTo = clWhite
          Appearance.ColorMirrorChecked = clWhite
          Appearance.ColorMirrorCheckedTo = clWhite
          Appearance.ColorMirrorDisabled = clWhite
          Appearance.ColorMirrorDisabledTo = clWhite
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
        object cbTipoEnvio: TLMDLabeledListComboBox
          Left = 448
          Top = 337
          Width = 297
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 12566463
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 13
          OnChange = cbTipoEnvioChange
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'MANUAL'
            'AUTOMATICAMENTE')
          ItemIndex = 0
          LabelPosition = lpLeft
          LabelSync = True
          EditLabel.Width = 5
          EditLabel.Height = 22
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = ' '
        end
        object LMDDBMaskEdit1: TLMDDBMaskEdit
          Left = 448
          Top = 275
          Width = 36
          Height = 22
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 12566463
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          Alignment = taRightJustify
          CustomButtons = <>
          Decimals = 0
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          DataField = 'BloVenConVenDia'
          DataSource = SouParam
        end
        object AdvGlowButton1: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 448
          Top = 365
          Width = 297
          Height = 23
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = 'BUSCAR RECEITA POR LISTA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -11
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
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
            A9000000097048597300000B1300000B1301009A9C18000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000000F54944415478DA62FCFF9F8132F0FF3F03438E4962522ED7A28525
            31DC3CB8D4E0C20CFFFF3330E43E78F43037EFFFFF9C23070F6233049F014C0C
            0C0C0CFF674546FF6FFBFC8971959DDDCFA89DDBCBD478F948F202030303434E
            95B54DCE974F1F73F3FEFFCFDD76E430B22104BD0003B80C21DA005C86906400
            03030343AE8CAD5DEE84CF9F73F3FEFFCF7DB5633BC14044078C97FEFF837332
            1899F0852186644E95B5CD3FB66D5B19EEF1F030781C3DC279252494A858A038
            10298A467C9A0919C0C2C0C0C0C07860D952862FBC7C0C12870FFDFDE2E5DD75
            EBCB179252626E484242EE87C58BB356F1909C991829CDCE80010078BF21266F
            ECE3290000000049454E44AE426082}
          Rounded = False
          Spacing = 7
          TabOrder = 14
          OnClick = AdvGlowButton1Click
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
      object PanelNotas: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14207947
        Bevel.BorderWidth = 1
        Color = 16514043
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object LMDLabel4: TLMDLabel
          Left = 39
          Top = 87
          Width = 108
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SENHA CERTIFICADO'
        end
        object LMDLabel6: TLMDLabel
          Left = 454
          Top = 335
          Width = 207
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'IMPRESSORA DO DANFE NFCe (MOD.65)'
        end
        object LMDLabel7: TLMDLabel
          Left = 39
          Top = 282
          Width = 163
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'PASTA CONFIGURA'#199#213'ES NFC-e'
        end
        object LMDLabel10: TLMDLabel
          Left = 494
          Top = 87
          Width = 53
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'CSC NFCe'
        end
        object LMDLabel8: TLMDLabel
          Left = 786
          Top = 87
          Width = 61
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'TOKEN NFC'
        end
        object LMDLabel9: TLMDLabel
          Left = 39
          Top = 160
          Width = 198
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'EMAIL ORIGEM PARA ENVIO NF / NFCE'
        end
        object LMDLabel11: TLMDLabel
          Left = 399
          Top = 160
          Width = 73
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SENHA EMAIL'
        end
        object LMDLabel13: TLMDLabel
          Left = 582
          Top = 160
          Width = 67
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SMTP EMAIL'
        end
        object LMDLabel12: TLMDLabel
          Left = 786
          Top = 160
          Width = 37
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'PORTA'
        end
        object Shape1: TShape
          Left = 28
          Top = 146
          Width = 894
          Height = 1
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 12898303
        end
        object Shape4: TShape
          Left = 28
          Top = 264
          Width = 894
          Height = 1
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 12898303
        end
        object LMDLabel5: TLMDLabel
          Left = 39
          Top = 335
          Width = 193
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'LOGOTIPO EMPRESA PARA DANFE NF'
        end
        object LMDLabel21: TLMDLabel
          Left = 454
          Top = 388
          Width = 200
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'IMPRESSORA DO DANFE NFe (MOD.55)'
        end
        object LMDLabel22: TLMDLabel
          Left = 39
          Top = 388
          Width = 180
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'EMAIL ENVIO XML CONTABILIDADE'
        end
        object LMDLabel23: TLMDLabel
          Left = 454
          Top = 284
          Width = 156
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'PASTA CONFIGURA'#199#213'ES NF-e'
        end
        object LMDLabel24: TLMDLabel
          Left = 804
          Top = 335
          Width = 46
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'ULT.NFC'
        end
        object LMDLabel25: TLMDLabel
          Left = 803
          Top = 389
          Width = 45
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'ULT.NFE'
        end
        object LMDLabel26: TLMDLabel
          Left = 866
          Top = 335
          Width = 46
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SER.NFC'
        end
        object LMDLabel27: TLMDLabel
          Left = 867
          Top = 389
          Width = 45
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SER.NFe'
        end
        object LMDLabel28: TLMDLabel
          Left = 39
          Top = 212
          Width = 191
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'MENSAGEM ENVIO NF PARA CLIENTE'
        end
        object LMDLabel29: TLMDLabel
          Left = 39
          Top = 436
          Width = 108
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SITE CONSULTA NFC'
        end
        object LMDLabel30: TLMDLabel
          Left = 454
          Top = 436
          Width = 107
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SITE CONSULTA NFe'
        end
        object LMDDBLabeledEdit4: TLMDDBLabeledEdit
          Left = 666
          Top = 52
          Width = 109
          Height = 23
          Bevel.StyleInner = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = 15397375
          TabOrder = 6
          TabStop = False
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
          Font.Height = -15
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          DataField = 'ValDigital'
          DataSource = SouParam
          ReadOnly = True
          LabelSpacing = 2
          LabelSync = True
          EditLabel.Width = 109
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Color = 16514043
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentColor = False
          EditLabel.ParentFont = False
          EditLabel.Caption = 'VALIDADE CERTIFIC.'
        end
        object LMDDBLabeledEdit5: TLMDDBLabeledEdit
          Left = 399
          Top = 103
          Width = 85
          Height = 23
          Bevel.StyleInner = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          DataField = 'PinCerDig'
          DataSource = SouParam
          LabelSpacing = 2
          LabelSync = True
          EditLabel.Width = 85
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'PIN (A3)'
        end
        object LMDDBEdit2: TLMDDBEdit
          Left = 39
          Top = 298
          Width = 403
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              Color = clWhite
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000013000000120806000000B90CE5
                69000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC300000EC301C76FA8640000018769545874584D4C3A63
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
                3F3E2C94980B000000714944415478DA63FC0F040C54028C83DF30464646AC0A
                E2E2E218162E5C48BA61D81C894B9C2CC358595919FEFCF98355B3B4B434C393
                274F88370C1FD0D3D363B874E912750C43D7433002700139393986478F1EE136
                8CAA2E1B358CF686090808307CF8F001BB61A402F47C3B788B2000099692CB00
                9409C40000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Roboto'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit2CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'PastaConfNFCe'
          DataSource = SouParam
        end
        object edSenDigital: TLMDEdit
          Left = 39
          Top = 103
          Width = 348
          Height = 23
          Bevel.StyleInner = bvNormal
          Bevel.WidthInner = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 2
          OnExit = edSenDigitalExit
          Font.Charset = SYMBOL_CHARSET
          Font.Color = 2236186
          Font.Height = -16
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 16
          ParentFont = False
          CustomButtons = <>
          PasswordChar = #171
          Spelling.LiveSpell = True
          Text = ''
        end
        object LMDDBLabeledSpinEdit2: TLMDDBLabeledSpinEdit
          Left = 747
          Top = 350
          Width = 51
          Height = 20
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 19
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 2
          AutoSelect = True
          ParentFont = False
          Alignment = taRightJustify
          CheckOnExitOnly = True
          CustomButtons = <>
          ReadOnly = True
          TabOnEnter = True
          MinValue = 1
          MaxValue = 10
          DataField = 'NroViasNFC'
          DataSource = SouParam
          UseDBMinMax = False
          LabelSpacing = 2
          EditLabel.Width = 37
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'N.VIAS'
          Value = 0
        end
        object LMDDBEdit1: TLMDDBEdit
          Left = 494
          Top = 103
          Width = 281
          Height = 23
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          DataField = 'CSCNFCe'
          DataSource = SouParam
        end
        object LMDDBEdit3: TLMDDBEdit
          Left = 786
          Top = 103
          Width = 60
          Height = 23
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          DataField = 'TokenNFCe'
          DataSource = SouParam
        end
        object edEMail: TLMDDBEdit
          Left = 39
          Top = 176
          Width = 348
          Height = 21
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 7
          OnExit = edEMailExit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'MailUsuario'
          DataSource = SouParam
        end
        object edMailPorta: TLMDDBEdit
          Left = 786
          Top = 176
          Width = 38
          Height = 21
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'MailPorta'
          DataSource = SouParam
        end
        object edSenMail: TLMDEdit
          Left = 399
          Top = 176
          Width = 171
          Height = 21
          Bevel.StyleInner = bvNormal
          Bevel.WidthInner = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 8
          Font.Charset = SYMBOL_CHARSET
          Font.Color = 7039851
          Font.Height = -16
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 16
          ParentFont = False
          CustomButtons = <>
          PasswordChar = #171
          Spelling.LiveSpell = True
          TabOnEnter = True
          Text = ''
        end
        object edSMTP: TLMDDBEdit
          Left = 582
          Top = 176
          Width = 193
          Height = 21
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Caret.BlinkRate = 530
          TabOrder = 9
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'ServidorSMTP'
          DataSource = SouParam
        end
        object LMDDBEdit5: TLMDDBEdit
          Left = 454
          Top = 350
          Width = 286
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 18
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000013000000120806000000B90CE5
                69000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC100000EC101B8916BED0000018769545874584D4C3A63
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
                3F3E2C94980B000000A24944415478DAD593310EC3201443CD023B2357E23C30
                2036D810C7C999D898114BDB0CAD821A0AA9924AF508FA4FC6DF90DB433849E4
                7218216438B8E7A10BFB64B877FF0730630C628CA8B5CEE60D4A299452F0DEB7
                30C618524AE09C4FC372CE1042A094D2C29ED6A5945896651AB87DF21BECA87E
                0B3B52DA5DD87601B3D5E82EC05A8B10C2AB1A23D8AAB51A5A6B38E75A582F87
                514ECDF9E51FFD5B9D0ABB03A34AB0CB9FCFC6460000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit5CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'PrinterNFC'
          DataSource = SouParam
        end
        object LMDDBEdit4: TLMDDBEdit
          Left = 39
          Top = 350
          Width = 403
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D494844520000001200000012080600000056CE8E
                57000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
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
                3F3E2C94980B000000D84944415478DA63FC0F040C54008C83D320464646B234
                23BB016402881702145C43920B18198B80541FCC304688C1FF91156800F93788
                348C01AB4140895E20550CC4F38162899418B414484503F10EA098072506F103
                296F20DE05147B43B6417834B000A924205E0654FB85288380927C40EA0B50EC
                1F94CF09A496037100109F05622FA0DC4B9C06416DED01E27C203E07C48140FC
                19883701B12D9203EF00B10750CF1D0C8380D81488EB80D81749C373207E07C4
                DA587C0B72D124206E4537E83110CB120A5C6C00DD20B201DC20AAE5B541578C
                0000802699CBA0F36A450000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Roboto'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit4CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'ImagemNF'
          DataSource = SouParam
        end
        object LMDDBLabeledSpinEdit1: TLMDDBLabeledSpinEdit
          Left = 747
          Top = 404
          Width = 51
          Height = 20
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 2
          AutoSelect = True
          ParentFont = False
          Alignment = taRightJustify
          CheckOnExitOnly = True
          CustomButtons = <>
          ReadOnly = True
          TabOnEnter = True
          MinValue = 1
          MaxValue = 10
          DataField = 'NroViasNF'
          DataSource = SouParam
          UseDBMinMax = False
          LabelSpacing = 2
          EditLabel.Width = 37
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'N.VIAS'
          Value = 0
        end
        object LMDDBEdit6: TLMDDBEdit
          Left = 454
          Top = 404
          Width = 286
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000013000000120806000000B90CE5
                69000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC100000EC101B8916BED0000018769545874584D4C3A63
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
                3F3E2C94980B000000A24944415478DAD593310EC3201443CD023B2357E23C30
                2036D810C7C999D898114BDB0CAD821A0AA9924AF508FA4FC6DF90DB433849E4
                7218216438B8E7A10BFB64B877FF0730630C628CA8B5CEE60D4A299452F0DEB7
                30C618524AE09C4FC372CE1042A094D2C29ED6A5945896651AB87DF21BECA87E
                0B3B52DA5DD87601B3D5E82EC05A8B10C2AB1A23D8AAB51A5A6B38E75A582F87
                514ECDF9E51FFD5B9D0ABB03A34AB0CB9FCFC6460000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit6CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'PrinterNFe'
          DataSource = SouParam
        end
        object ckAutentica: TLMDDBCheckBox
          Left = 582
          Top = 204
          Width = 102
          Height = 19
          Caption = 'Autentica SSL'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3618615
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          DataField = 'MailAutentica'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBEdit7: TLMDDBEdit
          Left = 39
          Top = 404
          Width = 403
          Height = 22
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 22
          OnExit = LMDDBEdit7Exit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'MailContabil'
          DataSource = SouParam
        end
        object LMDDBEdit8: TLMDDBEdit
          Left = 454
          Top = 298
          Width = 458
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              Color = clWhite
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000013000000120806000000B90CE5
                69000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC300000EC301C76FA8640000018769545874584D4C3A63
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
                3F3E2C94980B000000714944415478DA63FC0F040C54028C83DF30464646AC0A
                E2E2E218162E5C48BA61D81C894B9C2CC358595919FEFCF98355B3B4B434C393
                274F88370C1FD0D3D363B874E912750C43D7433002700139393986478F1EE136
                8CAA2E1B358CF686090808307CF8F001BB61A402F47C3B788B2000099692CB00
                9409C40000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Roboto'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit8CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'PastaConfNFe'
          DataSource = SouParam
        end
        object LMDDBEdit9: TLMDDBEdit
          Left = 804
          Top = 348
          Width = 58
          Height = 22
          Hint = 'Nro.'#218'ltima NFc gerada na implanta'#231#227'o'
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = 15397375
          ParentShowHint = False
          ShowHint = True
          TabOrder = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5987163
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'NroUltNFC'
          DataSource = SouParam
        end
        object LMDDBEdit10: TLMDDBEdit
          Left = 804
          Top = 404
          Width = 58
          Height = 22
          Hint = 'Nro.'#218'ltima NFe gerada na implanta'#231#227'o'
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = 15397375
          ParentShowHint = False
          ShowHint = True
          TabOrder = 25
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5987163
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'NroUltNFE'
          DataSource = SouParam
        end
        object LMDDBEdit11: TLMDDBEdit
          Left = 867
          Top = 350
          Width = 45
          Height = 23
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'SerNFC'
          DataSource = SouParam
        end
        object LMDDBEdit12: TLMDDBEdit
          Left = 867
          Top = 404
          Width = 45
          Height = 22
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'SerNFe'
          DataSource = SouParam
        end
        object LMDDBEdit16: TLMDDBEdit
          Left = 39
          Top = 228
          Width = 873
          Height = 21
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 14
          OnExit = edEMailExit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'MenEnvMailNF'
          DataSource = SouParam
        end
        object LMDDBEdit17: TLMDDBEdit
          Left = 39
          Top = 452
          Width = 403
          Height = 22
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 27
          OnExit = LMDDBEdit7Exit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'SiteConsNFC'
          DataSource = SouParam
        end
        object LMDDBEdit18: TLMDDBEdit
          Left = 454
          Top = 452
          Width = 458
          Height = 22
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 28
          OnExit = LMDDBEdit7Exit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'SiteConsNFe'
          DataSource = SouParam
        end
        object btTesteMail: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 840
          Top = 173
          Width = 72
          Height = 24
          Cursor = crHandPoint
          Margins.Left = 8
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = 'Testar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          MarginVert = 0
          MarginHorz = 4
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001A549
            444154388DA593BF6B537114C53FC7976F141DEAE4AF21E481480775E82804BE
            EF2504445C04258B080E2EC182FA0FB838080A4A3B542DB8290E05B14E21E9C3
            59144107B104328A9B839684BEEF75D1F808D6443CCB8503E7C3B9172EFCA734
            6978EF0F49BA2AE9AC99CD03067C94B42E6969341A8552A9F441D2A98D8D8D7E
            A9184E92E402F008D836B3E7C0AA9949D282992D9AD9621445778103928E00BF
            01DEFB16F004781C45D1F56EB7FB75A2D90D492B926E16FD1240AD563B2CE901
            B09A65D9953FAC755CD23360EF2F2FCF731B039C736D33DB72CE5DDBE1569F81
            3549658010C2D670387C53DCFD5D9AA6F77608FF55BB7ECE6366F676D690F77E
            3E4992DB4500926C5680A4D340BB08D80C219C9C15009C0036C700337B21A9E5
            BDDF332DD96834E68073C0FA18502E9797803949B7A6B5CFF3FC3E60CEB96580
            08A0DFEF7F8BE3B80FDC89E3787FB55A7D35180CB68BC966B3B9AF52A9AC0017
            CDEC52AFD77B0D13BF90A6E979337B087C97F43484F01E90A405A005EC062E67
            59B636AE34D9B15EAF1F0C21B48133C0512092F4C9CC5E3AE7963B9DCE976977
            FA27FD00C7FF8E8CCFFB441B0000000049454E44AE426082}
          Rounded = True
          Spacing = 0
          TabOrder = 13
          OnClick = btTesteMailClick
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
        object ckUseTLS: TLMDDBCheckBox
          Left = 708
          Top = 203
          Width = 75
          Height = 19
          Caption = 'Usar TLS'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3618615
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          DataField = 'MailUseTLS'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object cbCertificado: TLMDLabeledListComboBox
          Left = 39
          Top = 52
          Width = 618
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 0
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          ItemIndex = -1
          LabelSpacing = 2
          EditLabel.Width = 111
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 7039851
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CERTIFICADO DIGITAL'
        end
        object LMDLabeledListComboBox1: TLMDLabeledListComboBox
          Left = 786
          Top = 52
          Width = 126
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 1
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'A1'
            'A3 SmartCard'
            'ActiveDirectory'
            'LocalMachine'
            'Memory')
          ItemIndex = 0
          LabelSpacing = 2
          EditLabel.Width = 114
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 7039851
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'TIPO DO CERTIFICADO'
        end
      end
      object PanelParam: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = 16514043
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        object Shape15: TShape
          Left = 25
          Top = 297
          Width = 902
          Height = 1
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 13555967
        end
        object Shape19: TShape
          Left = 475
          Top = 0
          Width = 1
          Height = 287
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 13555967
        end
        object lbTitulo: TLMDLabel
          AlignWithMargins = True
          Left = 628
          Top = 7
          Width = 137
          Height = 17
          Margins.Left = 5
          Margins.Top = 4
          Alignment = agCenterLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8811110
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'CLIENTE OBRIGAT'#211'RIO'
        end
        object LMDLabel14: TLMDLabel
          Left = 39
          Top = 180
          Width = 235
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '6 - ARREDONDAR VENDAS AO M'#193'XIMO DE'
        end
        object LMDLabel15: TLMDLabel
          Left = 319
          Top = 177
          Width = 13
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -15
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '%'
        end
        object LMDLabel16: TLMDLabel
          Left = 39
          Top = 209
          Width = 207
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '7 - DESCONTO ADICIONAL AO GRUPO'
        end
        object LMDLabel17: TLMDLabel
          Left = 319
          Top = 206
          Width = 13
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -15
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '%'
        end
        object Shape3: TShape
          Left = 498
          Top = 127
          Width = 434
          Height = 1
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 13555967
        end
        object LMDLabel18: TLMDLabel
          Left = 39
          Top = 266
          Width = 232
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '17 - QUANT. VIAS COMP. TELE ENTREGAS'
        end
        object LMDLabel19: TLMDLabel
          Left = 39
          Top = 238
          Width = 226
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '16 - CENTRALIZAR ENTREGAS NA FILIAL'
        end
        object LMDLabel20: TLMDLabel
          Left = 497
          Top = 359
          Width = 311
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = '25 - '#218'LTIMO NSU DE MANIFEST'#199#195'O DE DESTINAT'#193'RIOS '
        end
        object Shape5: TShape
          Left = 25
          Top = 411
          Width = 902
          Height = 1
          Margins.Top = 2
          Margins.Bottom = 2
          Pen.Color = 13555967
        end
        object LMDLabel31: TLMDLabel
          Left = 28
          Top = 421
          Width = 175
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'PASTA MANIFESTO NF ENTRADAS'
        end
        object LMDLabel32: TLMDLabel
          Left = 393
          Top = 421
          Width = 111
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'CERTIFICADO DIGITAL'
        end
        object LMDLabel33: TLMDLabel
          Left = 764
          Top = 421
          Width = 101
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'SENHA ERTIFICADO'
        end
        object LMDLabel2: TLMDLabel
          Left = 30
          Top = 466
          Width = 131
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'PASTA SALVAR BOLETOS'
        end
        object gpVendaClieObg: TLMDCheckGroup
          Left = 493
          Top = 28
          Width = 366
          Height = 96
          Bevel.Mode = bmCustom
          BtnAlignment.Alignment = agCenterLeft
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = 7039851
          CaptionFont.Height = -13
          CaptionFont.Name = 'Roboto'
          CaptionFont.Style = [fsBold]
          CaptionParentFont = False
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Items.Strings = (
            'DINHEIRO'
            'CART'#195'O DE D'#201'BITO'
            'CART'#195'O DE CR'#201'DITO'
            'PIX'
            'CUPOM / VOUCHER'
            'PBM'#180'S'
            'FARM'#193'CIA POPULAR'
            'CONTROLADOS - SNGPC')
          ParentFont = False
          TabOrder = 8
          OnChange = gpVendaClieObgChange
          Value = -1
        end
        object cbVenFecha: TLMDLabeledListComboBox
          Left = 279
          Top = 25
          Width = 142
          Height = 21
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 0
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'PADR'#195'O'
            'R'#193'PIDO')
          ItemIndex = 0
          LabelPosition = lpLeft
          LabelSpacing = 38
          LabelSync = True
          EditLabel.Width = 202
          EditLabel.Height = 21
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 7039851
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          EditLabel.Caption = '1 - VENDAS - TIPO DE FECHAMENTO'
        end
        object cbVenCesta: TLMDLabeledListComboBox
          Left = 279
          Top = 83
          Width = 142
          Height = 21
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 2
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'OBRIGAT'#211'RIO'
            'OPCIONAL')
          ItemIndex = 0
          LabelPosition = lpLeft
          LabelSpacing = 30
          LabelSync = True
          EditLabel.Width = 210
          EditLabel.Height = 21
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 7039851
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          EditLabel.Caption = '3 - VENDAS - USA N'#218'MERO DE CESTA'
        end
        object cbVenProdExibComEst: TLMDLabeledListComboBox
          Left = 279
          Top = 52
          Width = 142
          Height = 21
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 1
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'TODOS'
            'APENAS C/ ESTOQUE')
          ItemIndex = 0
          LabelPosition = lpLeft
          LabelSpacing = 65
          LabelSync = True
          EditLabel.Width = 175
          EditLabel.Height = 21
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 7039851
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          EditLabel.Caption = '2 - VENDAS - EXIBE PRODUTOS'
        end
        object cbVenProdBloqSemEst: TLMDLabeledListComboBox
          Left = 279
          Top = 114
          Width = 142
          Height = 21
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 3
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'PERMITE'
            'BLOQUEIA')
          ItemIndex = 0
          LabelPosition = lpLeft
          LabelSpacing = 16
          LabelSync = True
          EditLabel.Width = 224
          EditLabel.Height = 21
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 7039851
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          EditLabel.Caption = '4 - VENDAS DE PRODUTO SEM ESTOQUE'
        end
        object cbVenCustoMed: TLMDLabeledListComboBox
          Left = 279
          Top = 145
          Width = 142
          Height = 21
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 4
          OnExit = cbVenFechaExit
          OnKeyDown = cbVenFechaKeyDown
          OnKeyPress = cbVenFechaKeyPress
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'PERMITE'
            'BLOQUEIA')
          ItemIndex = 0
          LabelPosition = lpLeft
          LabelSpacing = 13
          LabelSync = True
          EditLabel.Width = 227
          EditLabel.Height = 21
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 7039851
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          EditLabel.Caption = '5 - PRE'#199'O VENDA ABAIXO CUSTO M'#201'DIO'
        end
        object ckAltMarProRec: TLMDDBCheckBox
          Left = 39
          Top = 309
          Width = 345
          Height = 22
          Caption = '19 - RECEBIMENTO - ALTERA MARGEM DO PRODUTO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 16
          OnClick = ckAltMarProRecClick
          DataField = 'AlteraMargProdEnt'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ckAltMarProCadProd: TLMDDBCheckBox
          Left = 39
          Top = 334
          Width = 429
          Height = 22
          Caption = '20 - RECEBIMENTO - ALTERA MARGEM DO PRODUTO NO CADASTRO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
          OnClick = ckAltMarProCadProdClick
          DataField = 'AlteraMargProdCad'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBMaskEdit2: TLMDDBMaskEdit
          Left = 279
          Top = 175
          Width = 36
          Height = 21
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          Alignment = taRightJustify
          CustomButtons = <>
          Decimals = 0
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          DataField = 'ArrVenPer'
          DataSource = SouParam
        end
        object LMDDBMaskEdit3: TLMDDBMaskEdit
          Left = 279
          Top = 204
          Width = 36
          Height = 21
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 6
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          Alignment = taRightJustify
          CustomButtons = <>
          Decimals = 0
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          DataField = 'DescAdGru'
          DataSource = SouParam
        end
        object LMDDBCheckBox1: TLMDDBCheckBox
          Left = 498
          Top = 135
          Width = 340
          Height = 20
          Caption = '8 - PERMITE MAIS DE UM VENDEDOR NA MESMA VENDA'
          Alignment.Alignment = agCenterLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 9
          OnClick = ckAltMarProRecClick
          DataField = 'PerVenAdd'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox2: TLMDDBCheckBox
          Left = 498
          Top = 157
          Width = 350
          Height = 20
          Caption = '9 - PERMISS'#195'O PARA INFORMAR PERFUMISTA NA VENDA'
          Alignment.Alignment = agCenterLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 10
          OnClick = ckAltMarProRecClick
          DataField = 'PerAddPerf'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox3: TLMDDBCheckBox
          Left = 498
          Top = 179
          Width = 340
          Height = 20
          Caption = '11 - VISUALIZAR ESTAT'#205'STICAS DE CLIENTES NA VENDA'
          Alignment.Alignment = agCenterLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 11
          OnClick = ckAltMarProRecClick
          DataField = 'PerVisEst'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox4: TLMDDBCheckBox
          Left = 498
          Top = 201
          Width = 310
          Height = 20
          Caption = '12 - LIBERAR VENDA VIA PIX NA T.E. AP'#211'S VENDA'
          Alignment.Alignment = agCenterLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 12
          OnClick = ckAltMarProRecClick
          DataField = 'PerPIXTA'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox5: TLMDDBCheckBox
          Left = 498
          Top = 223
          Width = 361
          Height = 20
          Caption = '13 - PERMITE ALTERAR PRE'#199'OS PROMOCIONAIS NA VENDA'
          Alignment.Alignment = agCenterLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 13
          OnClick = ckAltMarProRecClick
          DataField = 'PerAltProm'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox6: TLMDDBCheckBox
          Left = 498
          Top = 245
          Width = 422
          Height = 20
          Caption = '14 - PERMITE ALTERAR PRE'#199'OS DE MEDICAM. REGULADOS NA VENDA'
          Alignment.Alignment = agCenterLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 14
          OnClick = ckAltMarProRecClick
          DataField = 'PerAltRegu'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox7: TLMDDBCheckBox
          Left = 498
          Top = 267
          Width = 290
          Height = 20
          Caption = '15 - PERMITE ENVIAR ENTREGAS PARA FILIAIS'
          Alignment.Alignment = agCenterLeft
          Alignment.Spacing = 4
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 15
          OnClick = ckAltMarProRecClick
          DataField = 'PerEnvFilial'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBMaskEdit4: TLMDDBMaskEdit
          Left = 279
          Top = 263
          Width = 36
          Height = 21
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 7
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          Alignment = taRightJustify
          CustomButtons = <>
          Decimals = 0
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          DataField = 'QtdViaTel'
          DataSource = SouParam
        end
        object LMDDBCheckBox8: TLMDDBCheckBox
          Left = 39
          Top = 360
          Width = 392
          Height = 22
          Caption = '21 - OBRIGAT'#211'RIA A CONFER'#202'NCIA DE ITENS NO RECEBIMENTO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
          OnClick = ckAltMarProCadProdClick
          DataField = 'ObrConfRec'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox9: TLMDDBCheckBox
          Left = 39
          Top = 385
          Width = 420
          Height = 22
          Caption = '22 - USAR PR'#201'-ENTRADAS NO RECEBIMENTO (PEND'#202'NCIAS)'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
          OnClick = ckAltMarProCadProdClick
          DataField = 'IndPreEntra'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox10: TLMDDBCheckBox
          Left = 496
          Top = 309
          Width = 316
          Height = 21
          Caption = '23 - CONSIDERAR DIFAL NO CUSTO DE COMPRAS'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          OnClick = ckAltMarProCadProdClick
          DataField = 'IndDIFAL'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBCheckBox11: TLMDDBCheckBox
          Left = 496
          Top = 334
          Width = 346
          Height = 20
          Caption = '24 - PERMITIR RECEBIMENTOS SEM PEDIDO VINCULADO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6118749
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
          OnClick = ckAltMarProCadProdClick
          DataField = 'PerRecPedVin'
          DataSource = SouParam
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object LMDDBMaskEdit6: TLMDDBMaskEdit
          Left = 812
          Top = 355
          Width = 58
          Height = 21
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          Alignment = taRightJustify
          CustomButtons = <>
          Decimals = 0
          TimeSettings.AMSign = 'am'
          TimeSettings.PMSign = 'pm'
          TimeSettings.MSign = 'm'
          DataField = 'UltNSUMani'
          DataSource = SouParam
        end
        object LMDDBLabeledEdit1: TLMDDBLabeledEdit
          Left = 279
          Top = 232
          Width = 179
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 23
          OnKeyDown = LMDDBLabeledEdit1KeyDown
          ValidationMsgString = 'a subst'#226'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = 5131854
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBLabeledEdit1CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'Nomfil'
          DataSource = SouParam
          LabelSpacing = -18
          EditLabel.Width = 5
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = ' '
        end
        object LMDDBEdit19: TLMDDBEdit
          Left = 28
          Top = 437
          Width = 353
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              Color = clWhite
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000013000000120806000000B90CE5
                69000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC300000EC301C76FA8640000018769545874584D4C3A63
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
                3F3E2C94980B000000714944415478DA63FC0F040C54028C83DF30464646AC0A
                E2E2E218162E5C48BA61D81C894B9C2CC358595919FEFCF98355B3B4B434C393
                274F88370C1FD0D3D363B874E912750C43D7433002700139393986478F1EE136
                8CAA2E1B358CF686090808307CF8F001BB61A402F47C3B788B2000099692CB00
                9409C40000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Roboto'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit19CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'PastaManifesto'
          DataSource = SouParam
        end
        object LMDDBEdit20: TLMDDBEdit
          Left = 393
          Top = 437
          Width = 360
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 25
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              Color = clWhite
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000013000000120806000000B90CE5
                69000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC300000EC301C76FA8640000018769545874584D4C3A63
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
                3F3E2C94980B000000714944415478DA63FC0F040C54028C83DF30464646AC0A
                E2E2E218162E5C48BA61D81C894B9C2CC358595919FEFCF98355B3B4B434C393
                274F88370C1FD0D3D363B874E912750C43D7433002700139393986478F1EE136
                8CAA2E1B358CF686090808307CF8F001BB61A402F47C3B788B2000099692CB00
                9409C40000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Roboto'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit20CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'PastaCertDigital'
          DataSource = SouParam
        end
        object edCertSenPar: TLMDEdit
          Left = 764
          Top = 437
          Width = 164
          Height = 22
          Bevel.StyleInner = bvNormal
          Bevel.WidthInner = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 26
          OnExit = edSenDigitalExit
          Font.Charset = SYMBOL_CHARSET
          Font.Color = 5131854
          Font.Height = -16
          Font.Name = 'Roboto'
          Font.Style = []
          MaxLength = 16
          ParentFont = False
          CustomButtons = <>
          PasswordChar = #171
          Spelling.LiveSpell = True
          Text = ''
        end
        object LMDDBEdit13: TLMDDBEdit
          Left = 28
          Top = 481
          Width = 353
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5131854
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <
            item
              Color = clWhite
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000013000000120806000000B90CE5
                69000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC300000EC301C76FA8640000018769545874584D4C3A63
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
                3F3E2C94980B000000714944415478DA63FC0F040C54028C83DF30464646AC0A
                E2E2E218162E5C48BA61D81C894B9C2CC358595919FEFCF98355B3B4B434C393
                274F88370C1FD0D3D363B874E912750C43D7433002700139393986478F1EE136
                8CAA2E1B358CF686090808307CF8F001BB61A402F47C3B788B2000099692CB00
                9409C40000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Roboto'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = LMDDBEdit13CustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphi
          CustomButtonWidth = 19
          TabOnEnter = True
          DataField = 'PastaBoletos'
          DataSource = SouParam
        end
        object edDBBanco: TLMDDBLabeledEdit
          Left = 393
          Top = 481
          Width = 360
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14207947
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          TabOrder = 28
          OnKeyDown = edDBBancoKeyDown
          ValidationMsgString = 'a Cidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = 5131854
          Font.Height = -13
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
                89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
                EA000000097048597300000B1300000B1301009A9C1800000319694343505068
                6F746F73686F70204943432070726F66696C65000078DA6360609EE0E8E2E4CA
                24C0C050505452E41EE418191119A5C07E9E818D819981818181812131B9B8C0
                3120C087818181212F3F2F9501037CBBC6C0C8C0C0C07059D7D1C5C9958134C0
                9A5C5054C2C0C070808181C12825B538998181E10B0303437A79494109030363
                0C03038348527641090303630103038348764890330303630B0303134F496A45
                0903030383737E416551667A468982A1A5A5A582634A7E52AA42706571496A6E
                B182675E727E51417E5162496A0A030303D40E060606065E97FC1205F7C4CC3C
                05435355062A8388C82805F4F0418821407269511984C5C8C0C0C020C0A0C5E0
                C750C9B08AE101A3346314E33CC6A74C864C0D4C979835981B99EFB2D8B0CC63
                6566CD66BDCAE6C4B6895D857D2687004727272B67331733571B3737F7441E29
                9EA5BCC6BC87F882F99EF1570B0809AC1674137C24D428AC287C58245D945774
                AB589C38A7F85689144961C9A35215D2BAD24F64E6C886CA09CA9D95EF51F051
                E455BCA03445394A4549E5B5EA56B546753F0D598DB79AFBB4266AA7EA58EB0A
                E9BED23BA23FDFA0C630CAC8D258D2F8B7C93DD3C3662BCCFB2D2A2C13AD7CAC
                2D6C546D45EC58ECBEDA3F77B8ED78C1E998F35E97ADAEEBDD56BA2FF558E4B9
                D06B81F7429FC5BECBFC56F9AF0FD81AB837E858F0F9905BA1CFC2BE4430450A
                4629451BC7B8C546C5E5C5B724CC4EDC9C7436F9792A539A5CBA4D46546655D6
                ACEC3D39F7F298F2D50B7C0A8B8B66171F2E795B2651EE52515839AFEA6CF5DF
                5ABDBAF8FA490DC71A7F371BB4A4B7CE6BBBDE21D8E9DDD5DE7DB897A1CFBEBF
                6EC2BE89FF273B4E699D7A623AEF8CE099B3663D9AA335B764DEBE055C0BC316
                2D5EFC71A9C3B209CB1FAE345ED5BAFAE65ADD754DEB6F6E34D8D4B1F9C156AB
                6D53B77FD8E9BB6BD51E8EBDE9FB8E1F503FD879E8F511BFA39B8F8B9FA83DF9
                E4B4F7992DE764CFB75FF87429EEF2A9AB16D796DD10BDD97AEBEB9DF4BB37EF
                FB3C38F0C8F4F1EAA78ACF66BE107CD9F59AF94DDDDB9FEF4B3F7CFA54F0F9DD
                D7BC6FEF7EE4FFFCF0BBF8CFB77F55FFFF03002ABF1D8AF36F515B00003F6E69
                545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
                657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
                65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
                783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F62
                6520584D5020436F726520352E352D633031342037392E3135313438312C2032
                3031332F30332F31332D31323A30393A31352020202020202020223E0A202020
                3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77
                332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E732322
                3E0A2020202020203C7264663A4465736372697074696F6E207264663A61626F
                75743D22220A202020202020202020202020786D6C6E733A786D703D22687474
                703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A2020202020
                20202020202020786D6C6E733A64633D22687474703A2F2F7075726C2E6F7267
                2F64632F656C656D656E74732F312E312F220A20202020202020202020202078
                6D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F
                7861702F312E302F6D6D2F220A202020202020202020202020786D6C6E733A73
                744576743D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E
                302F73547970652F5265736F757263654576656E7423220A2020202020202020
                20202020786D6C6E733A73745265663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F7861702F312E302F73547970652F5265736F757263655265662322
                0A202020202020202020202020786D6C6E733A70686F746F73686F703D226874
                74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
                220A202020202020202020202020786D6C6E733A746966663D22687474703A2F
                2F6E732E61646F62652E636F6D2F746966662F312E302F220A20202020202020
                2020202020786D6C6E733A657869663D22687474703A2F2F6E732E61646F6265
                2E636F6D2F657869662F312E302F223E0A2020202020202020203C786D703A43
                726561746F72546F6F6C3E41646F62652050686F746F73686F70204343202857
                696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A202020202020
                2020203C786D703A437265617465446174653E323031352D31302D3234543132
                3A30333A33372D30323A30303C2F786D703A437265617465446174653E0A2020
                202020202020203C786D703A4D65746164617461446174653E323031352D3130
                2D32345431323A30363A31352D30323A30303C2F786D703A4D65746164617461
                446174653E0A2020202020202020203C786D703A4D6F64696679446174653E32
                3031352D31302D32345431323A30363A31352D30323A30303C2F786D703A4D6F
                64696679446174653E0A2020202020202020203C64633A666F726D61743E696D
                6167652F706E673C2F64633A666F726D61743E0A2020202020202020203C786D
                704D4D3A496E7374616E636549443E786D702E6969643A61653336656435332D
                386636342D313034372D383066622D6463346431383831336436313C2F786D70
                4D4D3A496E7374616E636549443E0A2020202020202020203C786D704D4D3A44
                6F63756D656E7449443E786D702E6469643A31386631313431362D343262652D
                373834312D623735332D6365373435653361663734643C2F786D704D4D3A446F
                63756D656E7449443E0A2020202020202020203C786D704D4D3A4F726967696E
                616C446F63756D656E7449443E786D702E6469643A31386631313431362D3432
                62652D373834312D623735332D6365373435653361663734643C2F786D704D4D
                3A4F726967696E616C446F63756D656E7449443E0A2020202020202020203C78
                6D704D4D3A486973746F72793E0A2020202020202020202020203C7264663A53
                65713E0A2020202020202020202020202020203C7264663A6C69207264663A70
                61727365547970653D225265736F75726365223E0A2020202020202020202020
                202020202020203C73744576743A616374696F6E3E637265617465643C2F7374
                4576743A616374696F6E3E0A2020202020202020202020202020202020203C73
                744576743A696E7374616E636549443E786D702E6969643A3138663131343136
                2D343262652D373834312D623735332D6365373435653361663734643C2F7374
                4576743A696E7374616E636549443E0A20202020202020202020202020202020
                20203C73744576743A7768656E3E323031352D31302D32345431323A30333A33
                372D30323A30303C2F73744576743A7768656E3E0A2020202020202020202020
                202020202020203C73744576743A736F6674776172654167656E743E41646F62
                652050686F746F73686F70204343202857696E646F7773293C2F73744576743A
                736F6674776172654167656E743E0A2020202020202020202020202020203C2F
                7264663A6C693E0A2020202020202020202020202020203C7264663A6C692072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020202020202020203C73744576743A616374696F6E3E73617665643C2F
                73744576743A616374696F6E3E0A202020202020202020202020202020202020
                3C73744576743A696E7374616E636549443E786D702E6969643A626439623339
                31372D353438372D353634612D383838312D6466663930363364396135383C2F
                73744576743A696E7374616E636549443E0A2020202020202020202020202020
                202020203C73744576743A7768656E3E323031352D31302D32345431323A3036
                3A31352D30323A30303C2F73744576743A7768656E3E0A202020202020202020
                2020202020202020203C73744576743A736F6674776172654167656E743E4164
                6F62652050686F746F73686F70204343202857696E646F7773293C2F73744576
                743A736F6674776172654167656E743E0A202020202020202020202020202020
                2020203C73744576743A6368616E6765643E2F3C2F73744576743A6368616E67
                65643E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E636F6E7665727465643C2F73744576743A61
                6374696F6E3E0A2020202020202020202020202020202020203C73744576743A
                706172616D65746572733E66726F6D206170706C69636174696F6E2F766E642E
                61646F62652E70686F746F73686F7020746F20696D6167652F706E673C2F7374
                4576743A706172616D65746572733E0A2020202020202020202020202020203C
                2F7264663A6C693E0A2020202020202020202020202020203C7264663A6C6920
                7264663A7061727365547970653D225265736F75726365223E0A202020202020
                2020202020202020202020203C73744576743A616374696F6E3E646572697665
                643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
                2020203C73744576743A706172616D65746572733E636F6E7665727465642066
                726F6D206170706C69636174696F6E2F766E642E61646F62652E70686F746F73
                686F7020746F20696D6167652F706E673C2F73744576743A706172616D657465
                72733E0A2020202020202020202020202020203C2F7264663A6C693E0A202020
                2020202020202020202020203C7264663A6C69207264663A7061727365547970
                653D225265736F75726365223E0A202020202020202020202020202020202020
                3C73744576743A616374696F6E3E73617665643C2F73744576743A616374696F
                6E3E0A2020202020202020202020202020202020203C73744576743A696E7374
                616E636549443E786D702E6969643A61653336656435332D386636342D313034
                372D383066622D6463346431383831336436313C2F73744576743A696E737461
                6E636549443E0A2020202020202020202020202020202020203C73744576743A
                7768656E3E323031352D31302D32345431323A30363A31352D30323A30303C2F
                73744576743A7768656E3E0A2020202020202020202020202020202020203C73
                744576743A736F6674776172654167656E743E41646F62652050686F746F7368
                6F70204343202857696E646F7773293C2F73744576743A736F66747761726541
                67656E743E0A2020202020202020202020202020202020203C73744576743A63
                68616E6765643E2F3C2F73744576743A6368616E6765643E0A20202020202020
                20202020202020203C2F7264663A6C693E0A2020202020202020202020203C2F
                7264663A5365713E0A2020202020202020203C2F786D704D4D3A486973746F72
                793E0A2020202020202020203C786D704D4D3A4465726976656446726F6D2072
                64663A7061727365547970653D225265736F75726365223E0A20202020202020
                20202020203C73745265663A696E7374616E636549443E786D702E6969643A62
                643962333931372D353438372D353634612D383838312D646666393036336439
                6135383C2F73745265663A696E7374616E636549443E0A202020202020202020
                2020203C73745265663A646F63756D656E7449443E786D702E6469643A313866
                31313431362D343262652D373834312D623735332D6365373435653361663734
                643C2F73745265663A646F63756D656E7449443E0A2020202020202020202020
                203C73745265663A6F726967696E616C446F63756D656E7449443E786D702E64
                69643A31386631313431362D343262652D373834312D623735332D6365373435
                653361663734643C2F73745265663A6F726967696E616C446F63756D656E7449
                443E0A2020202020202020203C2F786D704D4D3A4465726976656446726F6D3E
                0A2020202020202020203C70686F746F73686F703A436F6C6F724D6F64653E31
                3C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020202020202020
                3C70686F746F73686F703A49434350726F66696C653E446F74204761696E2031
                35253C2F70686F746F73686F703A49434350726F66696C653E0A202020202020
                2020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269
                656E746174696F6E3E0A2020202020202020203C746966663A585265736F6C75
                74696F6E3E3732303030302F31303030303C2F746966663A585265736F6C7574
                696F6E3E0A2020202020202020203C746966663A595265736F6C7574696F6E3E
                3732303030302F31303030303C2F746966663A595265736F6C7574696F6E3E0A
                2020202020202020203C746966663A5265736F6C7574696F6E556E69743E323C
                2F746966663A5265736F6C7574696F6E556E69743E0A2020202020202020203C
                657869663A436F6C6F7253706163653E36353533353C2F657869663A436F6C6F
                7253706163653E0A2020202020202020203C657869663A506978656C5844696D
                656E73696F6E3E31363C2F657869663A506978656C5844696D656E73696F6E3E
                0A2020202020202020203C657869663A506978656C5944696D656E73696F6E3E
                31363C2F657869663A506978656C5944696D656E73696F6E3E0A202020202020
                3C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244463E
                0A3C2F783A786D706D6574613E0A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A20202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020200A2020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020200A202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020200A20202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020200A2020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020200A202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020200A20
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020200A20202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020200A2020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020200A202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020200A20202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020200A2020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020200A202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                200A202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020200A20202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020200A2020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020200A202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020200A20202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020200A2020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020202020202020202020200A
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020200A202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020200A20202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020200A2020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020200A202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020200A20202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020200A2020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20200A2020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020200A202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020200A20202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020200A2020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                202020202020202020202020202020202020202020200A202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020200A20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                0A202020202020202020202020202020202020202020202020202020200A3C3F
                787061636B657420656E643D2277223F3E1A6F5CDF0000013D4944415478DA8D
                91CD2B446118C5CFB9C534DC292C68523E9A58A048623376D869941A8BD1A459
                51B62CEC9562291FFF828F856616C466146533EA6A9A51938D449429F35E5673
                1F773EEE98849CD55BCFEF3DEFF39E43C1DF623550D7C3656D425C849C604325
                BE01FA1863F2C8531832403FBA39F3B65F05D4776A3734F201ED0510D08528C6
                AD41F3BA02E85B8CD06B658922007133635D98C132A037D190B8846CCBC2B074
                6793A15CA30374F00E2BB2569A141C6C2D723DE776805A26702BD3CEC21A2CC8
                8E16C8792B3B7896B02AFD4C890334208D3335FBB5E4248FE49C0B922AFEDE87
                6D8CE687DE93CE13233C44AB7DF8C09EA4D98508B21256B1720EFA30A368C633
                E6D02761F6CABDEDB6AB92E524753F0FD082279952577660355A9BF56A66ABBA
                F064E0930704D5E52F65E9C76C977915FF479B3FE913A5217A01191813C00000
                000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edDBBancoCustomButtons0Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsExplorer
          CustomButtonWidth = 18
          CustomButtonParentCtlXP = False
          TabOnEnter = True
          DataField = 'Nomban'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 150
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'BANCO ENVIO DOS BOLETOS'
        end
      end
      object PanelEntre: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = 16514043
        TabOrder = 7
      end
      object PanelTEF: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = 16514043
        TabOrder = 9
        object LMDLabel36: TLMDLabel
          Left = 385
          Top = 190
          Width = 188
          Height = 21
          Alignment = agCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -16
          Font.Name = 'Roboto'
          Font.Style = []
          Options = []
          ParentFont = False
          Caption = 'PANEL PARA CONFIG TEF'
        end
      end
      object PanelFarma: TLMDSimplePanel
        Left = 0
        Top = 26
        Width = 953
        Height = 517
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = 16514043
        TabOrder = 1
        ExplicitHeight = 518
        object LMDLabel3: TLMDLabel
          Left = 764
          Top = 328
          Width = 95
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9600112
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Options = []
          ParentFont = False
          Caption = 'IN'#205'CIO USO AIONE'
        end
        object LMDDBLabeledListComboBox6: TLMDDBLabeledListComboBox
          Left = 520
          Top = 292
          Width = 48
          Height = 23
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 14
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          MaxLength = 2
          ParentFont = False
          Alignment = taCenter
          Items.Strings = (
            'NEUTRA'
            'POSITIVA'
            'NEGATIVA'
            '')
          ItemIndex = 0
          DropDownCount = 3
          ReadOnly = True
          DataField = 'Estmun'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 16
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'UF'
        end
        object edRazaoSocial: TLMDDBLabeledEdit
          Left = 92
          Top = 88
          Width = 365
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Nomefar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 78
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'RAZ'#195'O SOCIAL'
        end
        object LMDDBLabeledEdit2: TLMDDBLabeledEdit
          Left = 92
          Top = 139
          Width = 365
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Nomefan'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 88
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'NOME FANTASIA'
        end
        object LMDDBLabeledEdit3: TLMDDBLabeledEdit
          Left = 520
          Top = 88
          Width = 145
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          CharCase = ecUpperCase
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'ApelidoFar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 143
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'APELIDO / NOME REDUZIDO'
        end
        object LMDDBLabeledEdit6: TLMDDBLabeledEdit
          Left = 520
          Top = 139
          Width = 145
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'CNPJFar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 30
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CNPJ'
        end
        object LMDDBLabeledEdit14: TLMDDBLabeledEdit
          Left = 92
          Top = 190
          Width = 365
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Endfar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 57
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'ENDERE'#199'O'
        end
        object LMDDBLabeledEdit11: TLMDDBLabeledEdit
          Left = 520
          Top = 190
          Width = 46
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'NroEnt'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 31
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'N'#218'M.'
        end
        object LMDDBLabeledEdit16: TLMDDBLabeledEdit
          Left = 92
          Top = 292
          Width = 365
          Height = 24
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Nommun'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 39
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CIDADE'
        end
        object LMDDBLabeledEdit20: TLMDDBLabeledEdit
          Left = 520
          Top = 241
          Width = 60
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Codmun'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 59
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'COD.MUNI.'
        end
        object LMDDBLabeledEdit21: TLMDDBLabeledEdit
          Left = 92
          Top = 241
          Width = 365
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'CompEnd'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 142
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'COMPLEMENTO ENDERE'#199'O'
        end
        object LMDDBLabeledEdit12: TLMDDBLabeledEdit
          Left = 593
          Top = 190
          Width = 72
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Cepfar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 22
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CEP'
        end
        object LMDDBLabeledEdit22: TLMDDBLabeledEdit
          Left = 764
          Top = 139
          Width = 109
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'InsEstFar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 91
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'INSCR.ESTADUAL'
        end
        object LMDDBLabeledEdit23: TLMDDBLabeledEdit
          Left = 764
          Top = 190
          Width = 109
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'FoneFar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 87
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'FONE FARM'#193'CIA'
        end
        object LMDDBLabeledEdit24: TLMDDBLabeledEdit
          Left = 764
          Top = 241
          Width = 109
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'CelularFar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 85
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CELULAR FARM.'
        end
        object LMDDBLabeledEdit25: TLMDDBLabeledEdit
          Left = 92
          Top = 344
          Width = 365
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'EmailFar'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 39
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'E-MAIL'
        end
        object LMDDBLabeledEdit26: TLMDDBLabeledEdit
          Left = 520
          Top = 344
          Width = 145
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Nomger'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 83
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'NOME GERENTE'
        end
        object LMDDBLabeledEdit27: TLMDDBLabeledEdit
          Left = 764
          Top = 292
          Width = 109
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'Foneger'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 98
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CELULAR GERENTE'
        end
        object LMDDBLabeledEdit28: TLMDDBLabeledEdit
          Left = 764
          Top = 88
          Width = 57
          Height = 23
          Hint = 'Imp. Circ. Mer. Ser. (Interno)'
          Bevel.StyleOuter = bvNormal
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 14602705
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Color = clWhite
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          Alignment = taCenter
          CustomButtons = <>
          TabOnEnter = True
          DataField = 'IDFilial'
          DataSource = SouParam
          LabelSpacing = 1
          EditLabel.Width = 58
          EditLabel.Height = 15
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'C'#211'D.FILIAL'
        end
        object ComboRegime: TLMDLabeledListComboBox
          Left = 92
          Top = 395
          Width = 365
          Height = 22
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 15657192
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          TabOrder = 19
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          Items.Strings = (
            'SIMPLES NACIONAL'
            'SIMPLES NACIONAL -  EXCESSO RECEITA BRUTA '
            'REGIME NORMAL')
          ItemIndex = 0
          DropDownCount = 5
          LabelSpacing = 2
          EditLabel.Width = 106
          EditLabel.Height = 15
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 9600112
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'REGIME TRIBUT'#193'RIO'
        end
        object ModernDBDateEdit1: TModernDBDateEdit
          Left = 764
          Top = 344
          Width = 109
          Height = 23
          Alignment = taLeftJustify
          BorderRadius = 0
          ButtonWidth = 22
          Color = clWhite
          Colors.Border = 14602705
          TabOrder = 18
          DataField = 'DataIniOpe'
          DataSource = SouParam
        end
      end
      object PanelBasMenus: TLMDSimplePanel
        Left = 0
        Top = 0
        Width = 953
        Height = 26
        Align = alTop
        Color = 14674687
        TabOrder = 0
        object PanelMenu: TLMDSimplePanel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 951
          Height = 24
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          Color = 14674687
          TabOrder = 0
          object btFarma: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 5
            Top = 1
            Width = 96
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 7
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Farm'#225'cia'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000007949
              444154388DC593C109803010042762118265E4675596621B12D2869D04AC22FA
              C847923B38CC230BF7C8B2CC63200E390BB0565D026E65DF24004F75411A4E0A
              40EAC5AD0630A71BE028C28E0AB6214BBC3EEF0CEC009E5698F5FC7807DD8099
              22E7E49FC4A48123ADB0280DC73BD000D9D8E11480F93BBF542728A5B97D2B3B
              0000000049454E44AE426082}
            Rounded = False
            TabOrder = 0
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 29
          end
          object btContas: TAdvGlowButton
            Tag = 2
            AlignWithMargins = True
            Left = 108
            Top = 1
            Width = 74
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 7
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Contas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000DB49
              444154388DC5D22F4E03411406F0DF924D9050412F00170082A94270833A2421
              41A08A005781C081AEE90D0817C0438AE901384505842E0D8BE06DD890EC7451
              FD92C9BC7FF3E6FB661EAB46862DDCE11303CCD0C12ED612673FF00C3728635D
              46F2A9164BAD618ED75AD7CA7E44371836618E49E51CA297286E448E75ECA3C0
              0B1691DB907E83026F70E557D35924EF2DD7FF85D3A61BCA960ACA2C249C07A5
              D13F24CCF19E87318D068B5AC1AC0D850C271887DFC703AE712CFD8D050639B6
              6BC19DD88FFEC49B70508DF2AD9F51BE08EA9BD8D37294578B6F52173ECA7E3B
              2FAA0000000049454E44AE426082}
            Rounded = False
            TabOrder = 1
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 29
          end
          object btParam: TAdvGlowButton
            Tag = 4
            AlignWithMargins = True
            Left = 279
            Top = 1
            Width = 96
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 7
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Par'#226'metros'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
            MarginHorz = 0
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -12
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Picture.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
              EA000000206348524D00007A26000080840000FA00000080E8000075300000EA
              6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
              485973000000600000006000F06B42CF0000000774494D4507E70A0C14241FA0
              3CC17C000000AC4944415428CF85D1416EC2301404D0A76E730258148E965C03
              8E93A3E045E90A8E910B241258FA5DC4216E5195F1CAF3479E996F6A9C65D9D9
              1B1A9D1D6E42B861A7D3ACE38B30E83D85F0D41B84CB22E9C43FA79D057B4321
              46493296DB60BF98F442F8F2090EAE42E897E4770F612CE35932090F77277279
              30FDEA950A9B3F6CE2F4B238BCB8636DB186BC16C9D1771DB2AE394992E96FCD
              CD456DAE9A46FBF659ED3AAE1B6579493EE30725D77DD0DA5006C50000000049
              454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 3
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 26
          end
          object btNotFis: TAdvGlowButton
            Tag = 3
            AlignWithMargins = True
            Left = 189
            Top = 1
            Width = 83
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 7
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Not.Fiscal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
            MarginHorz = 0
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -12
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Picture.Data = {
              89504E470D0A1A0A0000000D494844520000001200000012080600000056CE8E
              57000000097048597300000B1300000B1301009A9C18000000206348524D0000
              7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
              C546000000D44944415478DAB494310EC2300C459FABAECCDC801545EA65BA23
              71811E831354DD39466706A4B27203161810F36769202D2D4A45B164C57162C7
              FFC78949621691449B2C071EADFB1169E7AFF820510D0838B7638C5DFBF8B457
              E04DD22A0689995DC379D25B3F4D60A5B3371D396D07ACBF2428FACE8499241D
              B9C92282A3FF54948C9C569B99BC023897C9B94C43D58C4203F6C0217434CD71
              3B9923A01CE0AD9C0C2DE872AF1D68532A9A07DA108CD027E993F0E0D1563D38
              315AFA78F3FF91992D800DB08C6C9D0B5049BA03EF44BFCA73003BDC863D5D83
              AE530000000049454E44AE426082}
            Rounded = False
            Spacing = 0
            TabOrder = 2
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
          end
          object btSNGPC: TAdvGlowButton
            Tag = 5
            AlignWithMargins = True
            Left = 382
            Top = 1
            Width = 72
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 7
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'SNGPC'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
            MarginHorz = 0
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -12
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Picture.Data = {
              89504E470D0A1A0A0000000D494844520000001100000011080400000091648F
              71000000097048597300000B1300000B1301009A9C18000000206348524D0000
              7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
              C546000000C44944415478DA8492B10A02311044DFDC4550D442EC84606525F8
              01FE3F7E84D8483A6D04F5AA3BD722B93306C1949B97D999DDC8F8771C780002
              DE84CD79000641F126500128F15151998220229F724DC3E50B00079811451D57
              96EC3851E17B93AA72632D8BC79955D9AC4834F10D0ABF13011C36FB23605F22
              C832042B9CF6A18510C696D3FA033C07AAF0E2C17E79C9A8FBEC26F0E6E852D7
              2097F335632D98016D56AD486682A063C494577A1DA2495CB957A162742E4FA8
              2175BE50FDFF2FEF01003354327DBF4CEBF60000000049454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 4
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 26
          end
          object btEntregas: TAdvGlowButton
            Tag = 6
            AlignWithMargins = True
            Left = 461
            Top = 1
            Width = 97
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 7
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Tax.Entrega'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001DE49
              444154388DA5913F68146110C5DFFBBE051753045436A86071C2FDD93D0E2128
              22512E622336C1C2560808DA588858D868212236695388185B39B4D368BA60B0
              1005D7DB45B0B8C6086E2401B9C3E2EE7B16EEC5453C2EE094F3E6FD667803FC
              67D99D0C552A950341105C9D9A9AFA9E655956D4BC71E6300C4F02780E6042D2
              59003345DD8C03186336242D0300C9B5BF758E0300401445339256016C01389D
              24C9FB6D40B95CDEE779DE02C91F003E4BEA939C76CE850056D334BDD66C36BD
              2CCB36244D92FCD4ED768F743A9D9F00C0288A2E4A7A346ABBB5764F1CC79BB5
              5AAD45F27CDEBE9224C9E230831680957F9949DE8FE37833CF62B9205D28954A
              9343C0250067461CB05480BD2BF4677DDFFF50ABD5EA9EA41B009E917C485292
              E624CD03A0EFFB9DA16330181C26B945F29EA4B7920E02B86E8C31C7243D95B4
              E49C7BE29C5B27790B007ABDDE0900A856ABD324EF5A6BE7249D02F0D21873D3
              18B3C06AB5BAD718F305C0AEE136E7DCAC31E6157F9FF40DC07E002F00BC0170
              7B382769CDF33C2F70CE6D9BF3C082FCD4E00FD33DB0D65E96540CF910019830
              0C5F03389EF7D7ADB5F561FAC5AAD7EB4D492B926C0EB8430068341A13FD7E7F
              9EE46EE7DCE3344DBF8EF80AA2283A2AE91CC98FED76BB356A6EC7F50B9E76C0
              5D8383983A0000000049454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 5
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 26
          end
          object btCaixa: TAdvGlowButton
            Tag = 7
            AlignWithMargins = True
            Left = 565
            Top = 1
            Width = 65
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Caixa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
            MarginHorz = 0
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -12
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Picture.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000EC100000EC101B8916BED000000206348524D0000
              7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
              C546000000E34944415478DAA4D33D4A04411005E0AF65583307343352610C35
              34D523282C5E41AFA68267D823ECC68288E97800932D936E1887F9F1A7E0514D
              7575F5AB57DD2922FCC7AAB248298DE51CE1A0176BF10622C2048B1B6C113D6C
              710D3B330CCF30442DE1FC2705666DAEC02653EE5B600DA9F49F526AB037907C
              88BAF48C67BC47C4AA9B743F20D41CEEBA2D5CE689A42EF2DE132EF0927D895F
              750B1C4FE8708A25F6B3DF0C9D6927A8AEB34E1FD917615B1D3A4BECFE72829F
              7884E60F021634151623373CE035AF4F32CBBE2DAA317E1171FBEDEDA634FA61
              EA1911C7D0A2FE1A00429871BAF25C15100000000049454E44AE426082}
            Rounded = False
            TabOrder = 6
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 29
          end
          object btImposto: TAdvGlowButton
            Tag = 8
            AlignWithMargins = True
            Left = 692
            Top = 1
            Width = 81
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 7
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Impostos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
            MarginHorz = 0
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -12
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Picture.Data = {
              89504E470D0A1A0A0000000D494844520000000E0000000D080600000099DC5F
              7F000000097048597300000EC100000EC101B8916BED000000206348524D0000
              7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
              C546000002044944415478DA54D1BF4B55711CC6F1F7F339F71C0D2BBD52704D
              071583BA8B454B1836F68B30A8A590A0211B6BEA8F686DA8458228C4A5B08202
              17A1AD4D24B7AE88978B7644CDAB8457BFE77C5A8E54CFF40C9FD7B37C54AD56
              91743A8EE3EBEEBE3D3838F801F805B0B9B9C9EEEE2E002184A3C031600BD82B
              49EA8FE3F82B5091C4D2D2D2AC99DDCCB2ECA05C2E03E0EEA78017C035E00D30
              61C00DA042114957F23C3FD9D1D18199E1EE835996BD93744B529BA471495867
              67E73C108A654208B5AEAEAEADA1A1215AADD6992CCB66245D2C7683A4A79288
              464747EB699AAE4A529EE7F3E572F9497F7F7F3D4DD3F31B1B1BEFCDEC6C81F6
              253D36B397EDEDED940E0E0ED8DFDF9F8CA268B252A9D0D7D747A3D1B8D46834
              A69324E92BD06F491351144D01D4EB754A003D3D3D48A2B7B797959595AB6B6B
              6B6F93243951A06D33BB2FE9539EE7B8FBFF308E63969797EFA469FA2A4992E3
              05FA6966F7DC7DCECCC8F39C2CCB00B0388E71776AB5DA83F5F5F5D7FFA06533
              1B93349765D98510C2B4BB7F94F41040232323008F9ACDE6F352A9D456A04533
              BB6B66DFDDFD48086111189004109ACDE6E5D2CECE0EC0B37FD037331B97540B
              2100744B1AE06F4ADDDDDDE7CCCC30B32977DF0366A228BA2DA976F857774FDD
              7DF650B9FB6AABD5FAACE1E16180B66279278AA2DDC3A3858585C3DA55AD56C7
              DCBDD3DDBF003FFE0C00FFDADEEAA7ECF49A0000000049454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 8
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 26
          end
          object btTEF: TAdvGlowButton
            Tag = 9
            AlignWithMargins = True
            Left = 631
            Top = 1
            Width = 59
            Height = 23
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 2
            Margins.Bottom = 0
            Align = alLeft
            BorderStyle = bsNone
            Caption = 'TEF'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = []
            MarginVert = 2
            MarginHorz = 0
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
              643D2777273F3E2C94980B000000DB49444154384FADD2314A834110C5F19F11
              5B1B4BCB34A945F0087A044F919378105BBB14626FA79D08E9B4B01005A39020
              599BD9B0AE2389E01F1EBB036FDFCEECF7F14F1CE209658DDEC3BB623BD6318E
              31C3035E1215ECC6FEB20D81B330ACA38477C5A02D8249D2FA736FAA64017F22
              0B38C156A7BDDE54A9019FB1CE30FD45758CEAFDC6011E93D97BBD85376518A6
              29F6F11AF5112E623FEC0FB5D4804573A0E02ADADF38A0FE34997E04645F618E
              537C443DC675E749A91D2C71D3DC7A176169072D35E01E3BCD238E70BE49C020
              1E6F99CC5E709B8DFC0517BF5F235BA4CC570000000049454E44AE426082}
            Rounded = False
            Spacing = 0
            TabOrder = 7
            OnClick = MudaAba
            Appearance.BorderColor = 14674687
            Appearance.BorderColorHot = 14674687
            Appearance.BorderColorCheckedHot = 14674687
            Appearance.BorderColorDown = 14674687
            Appearance.BorderColorChecked = 14674687
            Appearance.BorderColorDisabled = 14674687
            Appearance.BorderColorFocused = 14674687
            Appearance.Color = 14674687
            Appearance.ColorTo = 14674687
            Appearance.ColorChecked = 14674687
            Appearance.ColorCheckedTo = 14674687
            Appearance.ColorDisabled = 14674687
            Appearance.ColorDisabledTo = 14674687
            Appearance.ColorDown = 14674687
            Appearance.ColorDownTo = 14674687
            Appearance.ColorHot = 14674687
            Appearance.ColorHotTo = 14674687
            Appearance.ColorMirror = 14674687
            Appearance.ColorMirrorTo = 14674687
            Appearance.ColorMirrorHot = 14674687
            Appearance.ColorMirrorHotTo = 12177407
            Appearance.ColorMirrorDown = 14674687
            Appearance.ColorMirrorDownTo = 14674687
            Appearance.ColorMirrorChecked = 14674687
            Appearance.ColorMirrorCheckedTo = 12177407
            Appearance.ColorMirrorDisabled = 14674687
            Appearance.ColorMirrorDisabledTo = 14674687
            Appearance.GradientHot = ggVertical
            Appearance.GradientMirrorHot = ggVertical
            Appearance.GradientDown = ggVertical
            Appearance.GradientMirrorDown = ggVertical
            Appearance.GradientChecked = ggVertical
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
          end
        end
      end
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 93
    Top = 11
  end
  object TabParam: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      
        'SELECT PAR.*,DEV.Desnat AS DesnatDEV,ACE.Desnat AS DesnatACE,ASS' +
        '.Desnat AS DesnatASS, BAN.Nomban,'
      
        'VLJ.Desnat AS DesnatVLJ,PEJ.Desnat AS DesnatPEJ,VLM.Desnat AS De' +
        'snatVLM,PEM.Desnat AS DesnatPEM, FIL.Nomfil,'
      
        'PLC1.Nomcon AS NomConDebSan,PLC2.Nomcon AS NomConCreSan,PLC3.Nom' +
        'con AS NomConDebSup,PLC4.Nomcon AS NomConCreSup'
      ' FROM arqparametros PAR'
      'LEFT JOIN arqnatfin DEV ON DEV.IDNatfin = PAR.IDNatFinVlrDevo'
      'LEFT JOIN arqnatfin ACE ON ACE.IDNatfin = PAR.IDNatFinDesAce'
      'LEFT JOIN arqnatfin ASS ON ASS.IDNatfin = PAR.IDNatFinDesAsso'
      'LEFT JOIN arqnatfin VLJ ON VLJ.IDNatfin = PAR.IDNatFinVlrJur'
      'LEFT JOIN arqnatfin PEJ ON PEJ.IDNatfin = PAR.IDNatFinPerJur'
      'LEFT JOIN arqnatfin VLM ON VLM.IDNatfin = PAR.IDNatFinVlrMul'
      'LEFT JOIN arqnatfin PEM ON PEM.IDNatfin = PAR.IDNatFinPerMul'
      'LEFT JOIN arqplacon PLC1 ON PAR.ConDebSan = PLC1.IDCon'
      'LEFT JOIN arqplacon PLC2 ON PAR.ConCreSan = PLC2.IDCon'
      'LEFT JOIN arqplacon PLC3 ON PAR.ConDebSup = PLC3.IDCon'
      'LEFT JOIN arqplacon PLC4 ON PAR.ConCreSup = PLC4.IDCon'
      'LEFT JOIN arqFilial FIL ON PAR.IDFilialEntr = FIL.IDFilial'
      
        'LEFT JOIN arqbanco BAN ON PAR.Codban = BAN.Codban AND PAR.IDFili' +
        'al = BAN.IDFilial'
      'LIMIT 1')
    UpdateTableName = 'arqparametros'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 164
    Top = 11
    object TabParamCNPJFar: TWideStringField
      FieldName = 'CNPJFar'
      Size = 14
    end
    object TabParamIDFilial: TWideStringField
      FieldName = 'IDFilial'
      Size = 11
    end
    object TabParamNomefar: TWideStringField
      FieldName = 'Nomefar'
      Size = 60
    end
    object TabParamNomefan: TWideStringField
      FieldName = 'Nomefan'
      Size = 35
    end
    object TabParamApelidoFar: TWideStringField
      FieldName = 'ApelidoFar'
      Size = 15
    end
    object TabParamEndfar: TWideStringField
      FieldName = 'Endfar'
      Size = 80
    end
    object TabParamNroEnt: TWideStringField
      FieldName = 'NroEnt'
      Size = 8
    end
    object TabParamCompEnd: TWideStringField
      FieldName = 'CompEnd'
      Size = 40
    end
    object TabParamBaifar: TWideStringField
      FieldName = 'Baifar'
      Size = 40
    end
    object TabParamNommun: TWideStringField
      FieldName = 'Nommun'
      Size = 40
    end
    object TabParamEstmun: TWideStringField
      FieldName = 'Estmun'
      Size = 2
    end
    object TabParamCodmun: TIntegerField
      FieldName = 'Codmun'
    end
    object TabParamCepfar: TWideStringField
      FieldName = 'Cepfar'
      Size = 8
    end
    object TabParamInsEstFar: TWideStringField
      FieldName = 'InsEstFar'
    end
    object TabParamFoneFar: TWideStringField
      FieldName = 'FoneFar'
      Size = 10
    end
    object TabParamValDigital: TDateField
      FieldName = 'ValDigital'
    end
    object TabParamCelularFar: TWideStringField
      FieldName = 'CelularFar'
      Size = 11
    end
    object TabParamEmailFar: TWideStringField
      FieldName = 'EmailFar'
      Size = 60
    end
    object TabParamNomger: TWideStringField
      FieldName = 'Nomger'
      Size = 35
    end
    object TabParamFoneger: TWideStringField
      FieldName = 'Foneger'
      Size = 11
    end
    object TabParamMailUsuario: TWideStringField
      FieldName = 'MailUsuario'
      Size = 80
    end
    object TabParamMailPorta: TWideStringField
      FieldName = 'MailPorta'
      Size = 4
    end
    object TabParamMailSenha: TWideStringField
      FieldName = 'MailSenha'
      Size = 18
    end
    object TabParamServidorSMTP: TWideStringField
      FieldName = 'ServidorSMTP'
      Size = 60
    end
    object TabParamMailAssunto: TWideStringField
      FieldName = 'MailAssunto'
      Size = 100
    end
    object TabParamMailAutentica: TBooleanField
      FieldName = 'MailAutentica'
    end
    object TabParamCerDigital: TWideStringField
      DisplayWidth = 255
      FieldName = 'CerDigital'
      Size = 255
    end
    object TabParamSenDigital: TWideStringField
      FieldName = 'SenDigital'
      Size = 18
    end
    object TabParamSerDigital: TWideStringField
      FieldName = 'SerDigital'
      Size = 100
    end
    object TabParamModDANFE: TWideStringField
      FieldName = 'ModDANFE'
      Size = 15
    end
    object TabParamCSCNFCe: TWideStringField
      FieldName = 'CSCNFCe'
      Size = 40
    end
    object TabParamTokenNFCe: TWideStringField
      FieldName = 'TokenNFCe'
      Size = 12
    end
    object TabParamHomolNFCe: TBooleanField
      FieldName = 'HomolNFCe'
    end
    object TabParamPrinterNFC: TWideStringField
      FieldName = 'PrinterNFC'
      Size = 90
    end
    object TabParamNroUltNFC: TIntegerField
      FieldName = 'NroUltNFC'
    end
    object TabParamIndContNFC: TBooleanField
      FieldName = 'IndContNFC'
    end
    object TabParamDatContNFC: TDateTimeField
      FieldName = 'DatContNFC'
    end
    object TabParamUltPedCom: TDateTimeField
      FieldName = 'UltPedCom'
    end
    object TabParamUsuIntFIscal: TWideStringField
      FieldName = 'UsuIntFIscal'
      Size = 32
    end
    object TabParamPassIntFiscal: TWideStringField
      FieldName = 'PassIntFiscal'
      Size = 32
    end
    object TabParamRTRIBFiscal: TWideStringField
      FieldName = 'RTRIBFiscal'
      Size = 1
    end
    object TabParamFAT12M: TWideStringField
      FieldName = 'FAT12M'
      Size = 3
    end
    object TabParamIDNatFinVlrDevo: TIntegerField
      FieldName = 'IDNatFinVlrDevo'
    end
    object TabParamIDNatFinDesAce: TIntegerField
      FieldName = 'IDNatFinDesAce'
    end
    object TabParamIDNatFinDesAsso: TIntegerField
      FieldName = 'IDNatFinDesAsso'
    end
    object TabParamIDNatFinVlrJur: TIntegerField
      FieldName = 'IDNatFinVlrJur'
    end
    object TabParamIDNatFinPerJur: TIntegerField
      FieldName = 'IDNatFinPerJur'
    end
    object TabParamIDNatFinVlrMul: TIntegerField
      FieldName = 'IDNatFinVlrMul'
    end
    object TabParamIDNatFinPerMul: TIntegerField
      FieldName = 'IDNatFinPerMul'
    end
    object TabParamConDebSan: TIntegerField
      FieldName = 'ConDebSan'
    end
    object TabParamConCreSan: TIntegerField
      FieldName = 'ConCreSan'
    end
    object TabParamConDebSup: TIntegerField
      FieldName = 'ConDebSup'
    end
    object TabParamConCreSup: TIntegerField
      FieldName = 'ConCreSup'
    end
    object TabParamAlteraMargProdEnt: TBooleanField
      FieldName = 'AlteraMargProdEnt'
    end
    object TabParamAlteraMargProdCad: TBooleanField
      FieldName = 'AlteraMargProdCad'
    end
    object TabParamTipoCerDig: TWideStringField
      FieldName = 'TipoCerDig'
      Size = 15
    end
    object TabParamNroViasNF: TSmallintField
      FieldName = 'NroViasNF'
    end
    object TabParamPinCerDig: TWideStringField
      FieldName = 'PinCerDig'
      Size = 12
    end
    object TabParamDesnatDEV: TWideStringField
      FieldName = 'DesnatDEV'
      ProviderFlags = []
      Size = 40
    end
    object TabParamDesnatACE: TWideStringField
      FieldName = 'DesnatACE'
      ProviderFlags = []
      Size = 40
    end
    object TabParamDesnatASS: TWideStringField
      FieldName = 'DesnatASS'
      ProviderFlags = []
      Size = 40
    end
    object TabParamDesnatVLJ: TWideStringField
      FieldName = 'DesnatVLJ'
      ProviderFlags = []
      Size = 40
    end
    object TabParamDesnatPEJ: TWideStringField
      FieldName = 'DesnatPEJ'
      ProviderFlags = []
      Size = 40
    end
    object TabParamDesnatVLM: TWideStringField
      FieldName = 'DesnatVLM'
      ProviderFlags = []
      Size = 40
    end
    object TabParamDesnatPEM: TWideStringField
      FieldName = 'DesnatPEM'
      ProviderFlags = []
      Size = 40
    end
    object TabParamVenFecha: TIntegerField
      FieldName = 'VenFecha'
    end
    object TabParamVenProdExibComEst: TIntegerField
      FieldName = 'VenProdExibComEst'
    end
    object TabParamMailUseTLS: TBooleanField
      FieldName = 'MailUseTLS'
    end
    object TabParamVenCesta: TIntegerField
      FieldName = 'VenCesta'
    end
    object TabParamVenProdBloqSemEst: TIntegerField
      FieldName = 'VenProdBloqSemEst'
    end
    object TabParamVenCustoMed: TIntegerField
      FieldName = 'VenCustoMed'
    end
    object TabParamVenFormaPagto: TWideStringField
      FieldName = 'VenFormaPagto'
      Size = 50
    end
    object TabParamUltNSUNFe: TWideStringField
      FieldName = 'UltNSUNFe'
      Size = 15
    end
    object TabParamMaxNSUNFe: TWideStringField
      FieldName = 'MaxNSUNFe'
      Size = 15
    end
    object TabParamDataHoraUltAcesso: TDateTimeField
      FieldName = 'DataHoraUltAcesso'
    end
    object TabParamIDNatFinEntMerRec: TIntegerField
      FieldName = 'IDNatFinEntMerRec'
    end
    object TabParamControleSNGPC: TBooleanField
      FieldName = 'ControleSNGPC'
    end
    object TabParamCadComCom: TBooleanField
      FieldName = 'CadComCom'
    end
    object TabParamInfQuanPreRec: TBooleanField
      FieldName = 'InfQuanPreRec'
    end
    object TabParamCamGerArqXML: TWideStringField
      FieldName = 'CamGerArqXML'
      Size = 100
    end
    object TabParamTipoEnvio: TWideStringField
      FieldName = 'TipoEnvio'
      Size = 1
    end
    object TabParamConInsMan: TBooleanField
      FieldName = 'ConInsMan'
    end
    object TabParamCadObrVenSNGPC: TBooleanField
      FieldName = 'CadObrVenSNGPC'
    end
    object TabParamSNGPCObrPerPro: TBooleanField
      FieldName = 'SNGPCObrPerPro'
    end
    object TabParamSolConFar: TBooleanField
      FieldName = 'SolConFar'
    end
    object TabParamBloVenConVenDia: TIntegerField
      DisplayWidth = 3
      FieldName = 'BloVenConVenDia'
      DisplayFormat = '##0'
      EditFormat = '##0'
      MaxValue = 999
    end
    object TabParamDefTipRecLista: TIntegerField
      FieldName = 'DefTipRecLista'
    end
    object TabParamImpEtiRecSNGPC: TBooleanField
      FieldName = 'ImpEtiRecSNGPC'
    end
    object TabParamSNGPCObrCompra: TBooleanField
      FieldName = 'SNGPCObrCompra'
    end
    object TabParamSNGPCObrVenda: TBooleanField
      FieldName = 'SNGPCObrVenda'
    end
    object TabParamReceitaA1: TIntegerField
      FieldName = 'ReceitaA1'
    end
    object TabParamReceitaA2: TIntegerField
      FieldName = 'ReceitaA2'
    end
    object TabParamReceitaA3: TIntegerField
      FieldName = 'ReceitaA3'
    end
    object TabParamReceitaAM: TIntegerField
      FieldName = 'ReceitaAM'
    end
    object TabParamReceitaB1: TIntegerField
      FieldName = 'ReceitaB1'
    end
    object TabParamReceitaB2: TIntegerField
      FieldName = 'ReceitaB2'
    end
    object TabParamReceitaC1: TIntegerField
      FieldName = 'ReceitaC1'
    end
    object TabParamReceitaC2: TIntegerField
      FieldName = 'ReceitaC2'
    end
    object TabParamReceitaC3: TIntegerField
      FieldName = 'ReceitaC3'
    end
    object TabParamReceitaC4: TIntegerField
      FieldName = 'ReceitaC4'
    end
    object TabParamReceitaC5: TIntegerField
      FieldName = 'ReceitaC5'
    end
    object TabParamReceitaD1: TIntegerField
      FieldName = 'ReceitaD1'
    end
    object TabParamValDiaA1: TIntegerField
      FieldName = 'ValDiaA1'
    end
    object TabParamValDiaA2: TIntegerField
      FieldName = 'ValDiaA2'
    end
    object TabParamValDiaA3: TIntegerField
      FieldName = 'ValDiaA3'
    end
    object TabParamValDiaAM: TIntegerField
      FieldName = 'ValDiaAM'
    end
    object TabParamValDiaB1: TIntegerField
      FieldName = 'ValDiaB1'
    end
    object TabParamValDiaB2: TIntegerField
      FieldName = 'ValDiaB2'
    end
    object TabParamValDiaC1: TIntegerField
      FieldName = 'ValDiaC1'
    end
    object TabParamValDiaC2: TIntegerField
      FieldName = 'ValDiaC2'
    end
    object TabParamValDiaC3: TIntegerField
      FieldName = 'ValDiaC3'
    end
    object TabParamValDiaC4: TIntegerField
      FieldName = 'ValDiaC4'
    end
    object TabParamValDiaC5: TIntegerField
      FieldName = 'ValDiaC5'
    end
    object TabParamValDiaD1: TIntegerField
      FieldName = 'ValDiaD1'
    end
    object TabParamArrVenPer: TFloatField
      FieldName = 'ArrVenPer'
      DisplayFormat = '##0.00'
    end
    object TabParamDescAdGru: TFloatField
      FieldName = 'DescAdGru'
      DisplayFormat = '##0.00'
    end
    object TabParamIDFilialEntr: TIntegerField
      FieldName = 'IDFilialEntr'
    end
    object TabParamQtdViaTel: TSmallintField
      FieldName = 'QtdViaTel'
      DisplayFormat = '##0'
    end
    object TabParamPerVenAdd: TBooleanField
      FieldName = 'PerVenAdd'
    end
    object TabParamPerAddPerf: TBooleanField
      FieldName = 'PerAddPerf'
    end
    object TabParamPerVisEst: TBooleanField
      FieldName = 'PerVisEst'
    end
    object TabParamPerPIXTA: TBooleanField
      FieldName = 'PerPIXTA'
    end
    object TabParamPerAltProm: TBooleanField
      FieldName = 'PerAltProm'
    end
    object TabParamPerAltRegu: TBooleanField
      FieldName = 'PerAltRegu'
    end
    object TabParamPerEnvFilial: TBooleanField
      FieldName = 'PerEnvFilial'
    end
    object TabParamObrConfRec: TBooleanField
      FieldName = 'ObrConfRec'
    end
    object TabParamIndPreEntra: TBooleanField
      FieldName = 'IndPreEntra'
    end
    object TabParamIndDIFAL: TBooleanField
      FieldName = 'IndDIFAL'
    end
    object TabParamSerNFC: TSmallintField
      FieldName = 'SerNFC'
    end
    object TabParamSerNFe: TSmallintField
      FieldName = 'SerNFe'
    end
    object TabParamPerRecPedVin: TBooleanField
      FieldName = 'PerRecPedVin'
    end
    object TabParamUltNSUMani: TIntegerField
      FieldName = 'UltNSUMani'
    end
    object TabParamPastaConfNFe: TWideStringField
      FieldName = 'PastaConfNFe'
      Size = 200
    end
    object TabParamPastaConfNFCe: TWideStringField
      FieldName = 'PastaConfNFCe'
      Size = 200
    end
    object TabParamHomolNFe: TBooleanField
      FieldName = 'HomolNFe'
    end
    object TabParamIndContNFe: TBooleanField
      FieldName = 'IndContNFe'
    end
    object TabParamImagemNF: TWideStringField
      FieldName = 'ImagemNF'
      Size = 200
    end
    object TabParamRegTributa: TWideStringField
      FieldName = 'RegTributa'
      Size = 1
    end
    object TabParamPrinterNFe: TWideStringField
      FieldName = 'PrinterNFe'
      Size = 90
    end
    object TabParamMailContabil: TWideStringField
      FieldName = 'MailContabil'
      Size = 100
    end
    object TabParamNroViasNFC: TSmallintField
      FieldName = 'NroViasNFC'
    end
    object TabParamNroUltNFE: TIntegerField
      FieldName = 'NroUltNFE'
    end
    object TabParamPercPIS: TFloatField
      FieldName = 'PercPIS'
      DisplayFormat = '##0.00'
    end
    object TabParamPerCOFINS: TFloatField
      FieldName = 'PerCOFINS'
      DisplayFormat = '##0.00'
    end
    object TabParamAliqIBSMun: TFloatField
      FieldName = 'AliqIBSMun'
      DisplayFormat = '##0.00'
    end
    object TabParamAliqIBSEst: TFloatField
      FieldName = 'AliqIBSEst'
      DisplayFormat = '##0.00'
    end
    object TabParamAliqCBS: TFloatField
      FieldName = 'AliqCBS'
      DisplayFormat = '##0.00'
    end
    object TabParamPerCreICMSSN: TFloatField
      FieldName = 'PerCreICMSSN'
      DisplayFormat = '##0.00'
    end
    object TabParamMenEnvMailNF: TWideStringField
      FieldName = 'MenEnvMailNF'
      Size = 180
    end
    object TabParamSiteConsNFC: TWideStringField
      FieldName = 'SiteConsNFC'
      Size = 255
    end
    object TabParamSiteConsNFe: TWideStringField
      FieldName = 'SiteConsNFe'
      Size = 255
    end
    object TabParamCodban: TIntegerField
      FieldName = 'Codban'
    end
    object TabParamPastaBoletos: TWideStringField
      FieldName = 'PastaBoletos'
      Size = 200
    end
    object TabParamPastaManifesto: TWideStringField
      FieldName = 'PastaManifesto'
      Size = 200
    end
    object TabParamPastaCertDigital: TWideStringField
      FieldName = 'PastaCertDigital'
      Size = 200
    end
    object TabParamSenhaCertMan: TWideStringField
      FieldName = 'SenhaCertMan'
    end
    object TabParamIndCxEfetiva: TSmallintField
      FieldName = 'IndCxEfetiva'
    end
    object TabParamIndCxCega: TBooleanField
      FieldName = 'IndCxCega'
    end
    object TabParamIndCxConfereIte: TBooleanField
      FieldName = 'IndCxConfereIte'
    end
    object TabParamIndCxDigQtdConfMan: TBooleanField
      FieldName = 'IndCxDigQtdConfMan'
    end
    object TabParamIndCxBusIteNomeConf: TBooleanField
      FieldName = 'IndCxBusIteNomeConf'
    end
    object TabParamIndCxBloqSangria: TBooleanField
      FieldName = 'IndCxBloqSangria'
    end
    object TabParamIndCxImpAudiFecha: TBooleanField
      FieldName = 'IndCxImpAudiFecha'
    end
    object TabParamIndCxLimVlrBloqueio: TFloatField
      FieldName = 'IndCxLimVlrBloqueio'
    end
    object TabParamIndCxLimArrenCaixa: TFloatField
      FieldName = 'IndCxLimArrenCaixa'
    end
    object TabParamNomConCreSup: TWideStringField
      FieldName = 'NomConCreSup'
      ProviderFlags = []
      Size = 45
    end
    object TabParamNomConDebSup: TWideStringField
      FieldName = 'NomConDebSup'
      ProviderFlags = []
      Size = 45
    end
    object TabParamNomConCreSan: TWideStringField
      FieldName = 'NomConCreSan'
      ProviderFlags = []
      Size = 45
    end
    object TabParamNomConDebSan: TWideStringField
      FieldName = 'NomConDebSan'
      ProviderFlags = []
      Size = 45
    end
    object TabParamNomfil: TWideStringField
      FieldName = 'Nomfil'
      ProviderFlags = []
      Size = 45
    end
    object TabParamNomban: TWideStringField
      FieldName = 'Nomban'
      ProviderFlags = []
      Size = 80
    end
    object TabParamDataIniOpe: TDateTimeField
      FieldName = 'DataIniOpe'
    end
  end
  object SouParam: TDataSource
    DataSet = TabParam
    Left = 232
    Top = 11
  end
  object TabFormasPagtos: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDForPag'
        DataType = ftInteger
      end
      item
        Name = 'IndAtivo'
        DataType = ftInteger
      end
      item
        Name = 'DesForPag'
        DataType = ftWideString
        Size = 20
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'select IDForPag, DesForPag, IndAtivo from arqforpagto '
      'where IDForPag not in (4,5,8)'
      'and IndAtivo = 1 '
      'UNION'
      
        'select 90 as IDForPag, '#39'PBMs'#39' as DesForPag, 1 as IndAtivo from a' +
        'rqforpagto '
      'UNION'
      
        'select 91 as IDForPag, '#39'Farm'#225'cia Popular'#39' as DesForPag, 1 as Ind' +
        'Ativo from arqforpagto '
      'UNION'
      
        'select 92 as IDForPag, '#39'Controlados (SNGPC)'#39' as DesForPag, 1 as ' +
        'IndAtivo from arqforpagto '
      'order by IDForPag')
    UpdateTableName = 'arqforpagto'
    CacheUpdateRecords = False
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 339
    Top = 11
    object TabFormasPagtosIDForPag: TIntegerField
      FieldName = 'IDForPag'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabFormasPagtosDesForPag: TWideStringField
      FieldName = 'DesForPag'
    end
    object TabFormasPagtosIndAtivo: TIntegerField
      FieldName = 'IndAtivo'
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileName = 'C:\Users\DevDelphi\Downloads'
    FileTypes = <>
    Options = [fdoPickFolders, fdoPathMustExist]
    Left = 445
    Top = 11
  end
  object SouForPagto: TDataSource
    AutoEdit = False
    DataSet = TabForPagto
    Left = 906
    Top = 11
  end
  object TabForPagto: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'SELECT * FROM arqforpagto ORDER BY IDForPag')
    UpdateTableName = 'arqforpagto'
    CacheUpdateRecords = False
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 827
    Top = 11
    object TabForPagtoIDForPag: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDForPag'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabForPagtoDesForPag: TWideStringField
      FieldName = 'DesForPag'
    end
    object TabForPagtoIDForPagNF: TWideStringField
      FieldName = 'IDForPagNF'
      Size = 2
    end
    object TabForPagtoIndPagVis: TWideStringField
      FieldName = 'IndPagVis'
      Size = 1
    end
    object TabForPagtoIndAtivo: TBooleanField
      FieldName = 'IndAtivo'
    end
    object TabForPagtoDesForPagNFLook: TWideStringField
      DisplayWidth = 60
      FieldKind = fkLookup
      FieldName = 'DesForPagNFLook'
      LookupDataSet = TabForPagNF
      LookupKeyFields = 'IDForPagNF'
      LookupResultField = 'DesForPagNF'
      KeyFields = 'IDForPagNF'
      ProviderFlags = []
      Size = 60
      Lookup = True
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 734
    Top = 11
  end
  object FileOpenDialog2: TFileOpenDialog
    FavoriteLinks = <>
    FileName = 'C:\Users\DevDelphi\Downloads'
    FileTypes = <>
    Options = [fdoForceFileSystem, fdoPathMustExist, fdoFileMustExist]
    Left = 544
    Top = 14
  end
  object TabICMS: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'SELECT * FROM arqicmsuf'
      '')
    UpdateTableName = 'arqicmsuf'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 128
    Top = 638
    object TabICMSUFICMS: TWideStringField
      FieldName = 'UFICMS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object TabICMSIndGEN: TWideStringField
      FieldName = 'IndGEN'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 1
    end
    object TabICMSPerICMS: TFloatField
      FieldName = 'PerICMS'
      DisplayFormat = '##0.00'
    end
    object TabICMSPerFCP: TFloatField
      FieldName = 'PerFCP'
      DisplayFormat = '##0.00'
    end
  end
  object SouICMS: TDataSource
    DataSet = TabICMS
    Left = 199
    Top = 637
  end
  object TabForPagNF: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'SELECT * FROM arqforpagnf ORDER BY IDForPagNF')
    UpdateTableName = 'arqforpagnf'
    CacheUpdateRecords = False
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 990
    Top = 11
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
  end
  object TabClaTribIte: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'SELECT * FROM arqclatribite ORDER BY CodClasIte')
    UpdateTableName = 'arqclatribite'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 440
    Top = 638
    object TabClaTribIteCodClasIte: TWideStringField
      FieldName = 'CodClasIte'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object TabClaTribIteDesClaIte: TWideStringField
      FieldName = 'DesClaIte'
      Size = 255
    end
    object TabClaTribItePerRedCBS: TFloatField
      FieldName = 'PerRedCBS'
      DisplayFormat = '##0.00'
    end
    object TabClaTribItePerRedIBS: TFloatField
      FieldName = 'PerRedIBS'
      DisplayFormat = '##0.00'
    end
  end
  object SouClaTribIte: TDataSource
    AutoEdit = False
    DataSet = TabClaTribIte
    Left = 524
    Top = 638
  end
  object FileOpenDialog3: TFileOpenDialog
    FavoriteLinks = <>
    FileName = 'C:\Fontes\AIONE.My\API_Conv'
    FileTypes = <
      item
        DisplayName = 'Certificado'
        FileMask = '*.pfx'
      end>
    Options = []
    Left = 644
    Top = 16
  end
  object ACBrMail: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 640
    Top = 635
  end
end
