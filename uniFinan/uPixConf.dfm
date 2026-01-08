object FrmPixConf: TFrmPixConf
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FINANCEIRO - PIX Confer'#234'ncia'
  ClientHeight = 530
  ClientWidth = 1095
  Color = clWhite
  Constraints.MaxWidth = 1095
  Constraints.MinHeight = 530
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object PanelBack: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 1095
    Height = 530
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 16053492
    Bevel.BorderWidth = 1
    Color = 16447736
    TabOrder = 0
    object PanelFiltros: TLMDSimplePanel
      Left = 1
      Top = 1
      Width = 1093
      Height = 97
      Align = alTop
      Color = 15724527
      TabOrder = 0
      TabStop = True
      object Label22: TLabel
        Left = 883
        Top = 6
        Width = 46
        Height = 13
        Caption = 'PER'#205'ODO'
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 980
        Top = 26
        Width = 8
        Height = 14
        Caption = #192
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 697
        Top = 54
        Width = 53
        Height = 13
        Caption = 'SITUA'#199#195'O'
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 695
        Top = 6
        Width = 76
        Height = 13
        Caption = 'FORMA DO PIX'
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 402
        Top = 4
        Width = 79
        Height = 13
        Caption = 'TIPO DA VENDA'
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object edFilial: TLMDLabeledEdit
        Left = 8
        Top = 70
        Width = 305
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 1
        OnKeyDown = edFilialKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
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
            OnClick = edFilialCustomButtons0Click
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 2
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'FILIAL'
      end
      object edNompes: TLMDLabeledEdit
        Left = 8
        Top = 22
        Width = 375
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 0
        OnKeyDown = edNompesKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
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
            OnClick = edNompesCustomButtons0Click
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 2
        EditLabel.Width = 44
        EditLabel.Height = 15
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'PESSOA'
      end
      object LMDSimplePanel1: TLMDSimplePanel
        Left = 695
        Top = 22
        Width = 181
        Height = 22
        Color = 15724527
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object Label1: TLabel
          Left = 21
          Top = 5
          Width = 49
          Height = 14
          Caption = 'MANUAL'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label2: TLabel
          Left = 100
          Top = 5
          Width = 74
          Height = 14
          Caption = 'INTEGRADOR'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object RadioNor: TLMDRadioButton
          Left = 1
          Top = 2
          Width = 14
          Height = 17
          Alignment.Alignment = agCenter
          Alignment.Spacing = 4
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'RadioRadio'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object RadioCon: TLMDRadioButton
          Left = 82
          Top = 5
          Width = 14
          Height = 14
          Alignment.Alignment = agCenter
          Alignment.Spacing = 4
          Checked = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object LMDSimplePanel2: TLMDSimplePanel
        Left = 695
        Top = 70
        Width = 172
        Height = 22
        Color = 15724527
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object Label3: TLabel
          Left = 21
          Top = 5
          Width = 60
          Height = 14
          Caption = 'PENDENTE'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 111
          Top = 6
          Width = 58
          Height = 14
          Caption = 'RECEBIDO'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object RadioReg: TLMDRadioButton
          Left = 1
          Top = 5
          Width = 14
          Height = 14
          Alignment.Alignment = agCenter
          Alignment.Spacing = 4
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'RadioRadio'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object RadioCan: TLMDRadioButton
          Left = 93
          Top = 6
          Width = 14
          Height = 14
          Alignment.Alignment = agCenter
          Alignment.Spacing = 4
          Checked = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object edNotFis: TLMDLabeledEdit
        Left = 321
        Top = 70
        Width = 62
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
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 2
        EditLabel.Width = 59
        EditLabel.Height = 15
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'DOCUMEN.'
      end
      object edLocRece: TLMDLabeledEdit
        Left = 402
        Top = 70
        Width = 284
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
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
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 2
        EditLabel.Width = 129
        EditLabel.Height = 15
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'LOCAL DE RECEBIMENTO'
      end
      object LMDSimplePanel3: TLMDSimplePanel
        Left = 882
        Top = 22
        Width = 94
        Height = 23
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 7
        object edDataIni: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 86
          Height = 19
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          AutoSelect = False
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
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
      end
      object edDatfin: TLMDSimplePanel
        Left = 992
        Top = 22
        Width = 94
        Height = 23
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 8
        object edDataFin: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 86
          Height = 19
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          AutoSelect = False
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
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
      end
      object btBuscar: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 882
        Top = 66
        Width = 204
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Buscar Movimento'
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
        Rounded = True
        Spacing = 7
        TabOrder = 9
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
      object LMDSimplePanel11: TLMDSimplePanel
        Left = 402
        Top = 21
        Width = 146
        Height = 22
        Color = 15724527
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object Label37: TLabel
          Left = 19
          Top = 5
          Width = 53
          Height = 14
          Caption = 'ENTREGA'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label39: TLabel
          Left = 109
          Top = 5
          Width = 30
          Height = 14
          Caption = 'LOJA'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Radio55: TLMDRadioButton
          Left = 1
          Top = 4
          Width = 14
          Height = 16
          Alignment.Alignment = agCenter
          Alignment.Spacing = 4
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'RadioRadio'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object Radio65: TLMDRadioButton
          Left = 90
          Top = 4
          Width = 14
          Height = 16
          Alignment.Alignment = agCenter
          Alignment.Spacing = 4
          Checked = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 101
      Width = 1093
      Height = 389
      Margins.Left = 0
      Margins.Right = 0
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
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
      OnDrawColumnCell = DBGrid1DrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'EMISS'#195'O'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 86
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'DOCUMENTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'TIP.DOC.'
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
          Title.Alignment = taCenter
          Title.Caption = 'PESSOA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 246
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'FILIAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 141
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'ID DO PIX'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 184
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'ORIGEM RECEB.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 107
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'STATUS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 47
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'VALOR R$'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'S'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 21
          Visible = True
        end>
    end
    object V: TLMDSimplePanel
      Left = 1
      Top = 493
      Width = 1093
      Height = 36
      Align = alBottom
      Color = 15724527
      TabOrder = 2
      TabStop = True
      object AdvGlowButton1: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 95
        Top = 6
        Width = 145
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'IMPRIMIR DOC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5855577
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 10
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
          C546000000CB4944415478DACCD43D6EC2401086E14702290DDC0945A1851B50
          52C20DA294B9024A411D5152215A44C515F8B989D38C958D15DB0B02894FFA34
          B634F3EE78C7BB8AA2700FBB2BA8A209B62D9EA40575A00FEC31ADF13E72B240
          4BF55A3681BA18C78AEB8C8ED6F13C4227057DE192B137555FB028BF6A802386
          784147BE86513B2841E788EFD589B428ADFDFB72A51A41F368B7C9F3FF40AF38
          452CC7BFC15B8D37C9F87F6B63C757386011B1ED3F4A73BFD3F1F731C3277619
          A05DE4CED07BF811B9FDD03ED57DF43300197F5EFD71AD76580000000049454E
          44AE426082}
        Rounded = True
        Spacing = 4
        TabOrder = 0
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
        Layout = blGlyphLeftAdjusted
      end
      object AdvGlowButton2: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 257
        Top = 6
        Width = 164
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'CANCELAR DOC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5855577
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 18
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000014C49
          444154388D7DD2BB4A5D411406E0CFC41C21F80E82210A225808DE1A9B342109
          061BB15650142B2D04C5179058684E3079128B0801092904451B93D2344141B4
          D1464FB4987574336ECF820DB3FFCBBACC1A1E470FAAF88D2B5CE208EBE82ED1
          DF470BBEA1861D2C60041FB1885FC17D46A5CCFC03FFF0A641917738C5F73CC9
          D730B7356A31E2552459AF033DD15ABD722B064B8C437819E70FB8411769A69D
          4C58C354019B0BACB780EDE213FCC17C566D320CB391A886E94CB38C43D2AA46
          4A5A9EC4FFF872338CE1E259FC3495089E3F71AE47136E9B718CD71939852F31
          C20D3603AF16341DF84B5AC7CF02312CCD3C51C066021B28607B58253DCF1ADE
          06D18ABE9296FB3DAC7114D7E8AC93559CA0BDC4984707CEB056042BD8965ED8
          FB06E6D1306FE1454E56B0215DDA2E96A4558D6305FBD1F65A99B9185DD20B3B
          C405CE71205D58672EBE038F2649F485116BDC0000000049454E44AE426082}
        Rounded = True
        Spacing = 10
        TabOrder = 1
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
        Layout = blGlyphLeftAdjusted
      end
      object AdvGlowButton3: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 438
        Top = 6
        Width = 193
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'BAIXAR PIX PENDENTES'
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
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000015049
          444154388D85D2BF4A9C511005F09F4536422CB4B108D8B82226FE79020B5F40
          6CAC7C005FC052021676A24412B4B232209A22DAAA888DA02E82446D042BC152
          F00F06417753DCF9E4E3DB554F75EFCC9C3367E65EEAD18F799CE21E37F88B59
          7C6950FF828F58C033AA38C4325670841AAEDE22EF44D17AB828A28C81387FC6
          060EB2E4629067D0F4964D8CE23A9C4E896ECF587D870813D2781718CC82DF43
          A0FC0E79325CEEA10D2534C3192AB9C2710C15C863D1791B9F22B6847DB895B6
          9DA182470CC7BD1B0F38476BAE6E197799C09F5CA223667CC40876F10FBD0557
          BF82EB0CC7856426528DB9A7D5E31C27A42556D1F98AC8255A0AB99E109E833E
          3C61AD419756B417624DD80CCED72CF83314271B8814F12D6AE7F3C192F44435
          FC465703623972356CE143B1A0841F61AD262D6955FAF347D29E9EA2731D398F
          5E693927D23BDFC579566EE60CFF012E2258E4D61AAC340000000049454E44AE
          426082}
        Rounded = True
        Spacing = 5
        TabOrder = 2
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
        Layout = blGlyphLeftAdjusted
      end
      object AdvGlowButton5: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 647
        Top = 6
        Width = 174
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'VER LAN'#199'AMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5855577
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 14
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000F149
          444154388D9DD3BD4A03411486E14793C242140411BC8794764B1AB1B2B58808
          365E84A06221DE8501410D626F2B82360A29046DFC696C2C1214C14650120B67
          21067667D703879903F3BDE77C330C2CA38B7EC9ECA23112364D9C2917F35883
          1E92926241D31BFD87F04F5487EA1DAC4434C7D8CA021CE23602B8C99BE03164
          E118062C6161A0BEC27E1E207689FDB02638C1397631893B6C127FC6045F38C2
          36EE71814A7A200668E160A09E0DC07A110B3013BAA6F1820F4C17055C633574
          86754CE0213D10B3308E4B7CE30D9F78C6136A55BC6211631980B65FBF73C14E
          1BEFD8C32934D091FD6D3772A69BFA01AC9643394FEE252B0000000049454E44
          AE426082}
        Rounded = True
        Spacing = 6
        TabOrder = 3
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
        Layout = blGlyphLeftAdjusted
      end
      object AdvGlowButton6: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 838
        Top = 6
        Width = 159
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'IMPRIME RELA'#199#195'O'
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
          89504E470D0A1A0A0000000D494844520000001200000012080600000056CE8E
          57000000097048597300000B1300000B1301009A9C18000000206348524D0000
          7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
          C546000000CB4944415478DACCD43D6EC2401086E14702290DDC0945A1851B50
          52C20DA294B9024A411D5152215A44C515F8B989D38C958D15DB0B02894FFA34
          B634F3EE78C7BB8AA2700FBB2BA8A209B62D9EA40575A00FEC31ADF13E72B240
          4BF55A3681BA18C78AEB8C8ED6F13C4227057DE192B137555FB028BF6A802386
          784147BE86513B2841E788EFD589B428ADFDFB72A51A41F368B7C9F3FF40AF38
          452CC7BFC15B8D37C9F87F6B63C757386011B1ED3F4A73BFD3F1F731C3277619
          A05DE4CED07BF811B9FDD03ED57DF43300197F5EFD71AD76580000000049454E
          44AE426082}
        Rounded = True
        Spacing = 4
        TabOrder = 4
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
        Layout = blGlyphLeftAdjusted
      end
    end
  end
end
