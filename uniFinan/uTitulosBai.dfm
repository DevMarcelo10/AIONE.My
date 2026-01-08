object FrmTitBai: TFrmTitBai
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Financeiro - Baixa de T'#237'tulos'
  ClientHeight = 566
  ClientWidth = 1168
  Color = 16250871
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 2236186
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelQuitacao: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 1168
    Height = 566
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 12369084
    Bevel.BorderWidth = 1
    Color = 16053492
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7039851
    Font.Height = -11
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Shape1: TShape
      Left = 1
      Top = 32
      Width = 1312
      Height = 1
      Pen.Color = 11316396
    end
    object PanelBaixa: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 445
      Width = 1166
      Height = 120
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      Bevel.StyleInner = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = clSilver
      Color = 16250871
      TabOrder = 2
      ExplicitLeft = 2
      object Label10: TLabel
        Left = 175
        Top = 54
        Width = 5
        Height = 14
        Caption = '/'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 259
        Top = 55
        Width = 48
        Height = 13
        Caption = 'PAGO EM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 610
        Top = 55
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'DESCONTOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 792
        Top = 55
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'TOTAL PAGO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        AlignWithMargins = True
        Left = 34
        Top = 55
        Width = 36
        Height = 13
        Margins.Left = 13
        Margins.Top = 15
        Margins.Right = 5
        Alignment = taRightJustify
        Caption = 'DOCTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label15: TLabel
        Left = 449
        Top = 55
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'JUROS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 635
        Top = 22
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'JUROS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 812
        Top = 22
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = #192' PAGAR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 28
        Top = 20
        Width = 42
        Height = 13
        Margins.Left = 13
        Margins.Top = 15
        Margins.Right = 5
        Alignment = taRightJustify
        Caption = 'PESSOA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 447
        Top = 21
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'MULTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 429
        Top = 89
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'PAGAR VIA'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        AlignWithMargins = True
        Left = 15
        Top = 89
        Width = 55
        Height = 13
        Margins.Top = 16
        Alignment = taRightJustify
        Caption = 'NATUREZA'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object PanelBotoes: TLMDSimplePanel
        Left = 1045
        Top = 0
        Width = 121
        Height = 120
        Align = alRight
        Color = 16250871
        TabOrder = 0
        object btRetornoBco: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 8
          Top = 95
          Width = 105
          Height = 20
          Cursor = crHandPoint
          Hint = 'L'#234' a remessa de retorno dos t'#237'tulos ao banco. '
          Margins.Left = 8
          Margins.Right = 8
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Retorno Banco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -12
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
          TabOrder = 0
          OnClick = btRetornoBcoClick
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
        object btBaiTudo: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 8
          Top = 72
          Width = 105
          Height = 20
          Cursor = crHandPoint
          Margins.Left = 8
          Margins.Right = 8
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Baixar TUDO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -12
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
          TabOrder = 1
          OnClick = btBaiTudoClick
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
        object btSelecao: TAdvGlowButton
          Tag = 2
          AlignWithMargins = True
          Left = 8
          Top = 49
          Width = 105
          Height = 20
          Cursor = crHandPoint
          Margins.Left = 8
          Margins.Right = 8
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Baixar Sele'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -12
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
          OnClick = btBaiTudoClick
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
        object btBaixa: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 8
          Top = 26
          Width = 105
          Height = 20
          Cursor = crHandPoint
          Margins.Left = 8
          Margins.Right = 8
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Baixa '#218'nica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -12
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
          TabOrder = 3
          OnClick = btBaixaClick
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
        object btEnviaBco: TAdvGlowButton
          Tag = 1
          AlignWithMargins = True
          Left = 8
          Top = 3
          Width = 105
          Height = 20
          Cursor = crHandPoint
          Hint = 'Envia t'#237'tulos ao banco para pagamento '
          Margins.Left = 8
          Margins.Right = 8
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Enviar P/ Banco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -12
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
          TabOrder = 4
          OnClick = btEnviaBcoClick
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
      object LMDDBEdit2: TLMDDBEdit
        Left = 77
        Top = 50
        Width = 92
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 15134463
        Enabled = False
        TabOrder = 1
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <>
        DataField = 'Nrotit'
        DataSource = SouQueTitu
        ReadOnly = True
      end
      object LMDDBEdit4: TLMDDBEdit
        Left = 184
        Top = 50
        Width = 31
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 15134463
        Enabled = False
        TabOrder = 2
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        Alignment = taCenter
        CustomButtons = <>
        DataField = 'Destit'
        DataSource = SouQueTitu
        ReadOnly = True
      end
      object LMDSimplePanel1: TLMDSimplePanel
        Left = 312
        Top = 50
        Width = 94
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 3
        object DatPagAux: TDateEdit
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
          Text = '01/01/2024'
        end
      end
      object VlrDesAux: TCurrencyEdit
        Left = 679
        Top = 50
        Width = 69
        Height = 23
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = clWhite
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        OnExit = VlrJurAuxExit
      end
      object TotPagAux: TCurrencyEdit
        Left = 865
        Top = 50
        Width = 79
        Height = 23
        Margins.Left = 1
        Margins.Top = 1
        AutoSize = False
        Color = 15134463
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
      object VlrJurBanco: TCurrencyEdit
        Left = 493
        Top = 50
        Width = 69
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = 15134463
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        OnExit = VlrJurAuxExit
      end
      object LMDDBEdit1: TLMDDBEdit
        Left = 78
        Top = 17
        Width = 331
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 15134463
        Enabled = False
        TabOrder = 7
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <>
        DataField = 'Nompes'
        DataSource = SouQueTitu
        ReadOnly = True
        OnDataChange = LMDDBEdit1DataChange
      end
      object VlrJurAux: TCurrencyEdit
        Left = 678
        Top = 17
        Width = 69
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = clWhite
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 8
        OnExit = VlrJurAuxExit
      end
      object VlrPagAux: TCurrencyEdit
        Left = 864
        Top = 17
        Width = 79
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = clWhite
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 9
        OnExit = VlrJurAuxExit
      end
      object VlrMulBanco: TCurrencyEdit
        Left = 491
        Top = 17
        Width = 69
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = 15134463
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
        OnExit = VlrJurAuxExit
      end
      object LMDDBEdit5: TLMDDBEdit
        Left = 77
        Top = 85
        Width = 331
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 15134463
        Enabled = False
        TabOrder = 11
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <>
        DataField = 'Desnat'
        DataSource = SouQueTitu
        ReadOnly = True
      end
      object edCodcon: TLMDLabeledEdit
        Left = 492
        Top = 85
        Width = 395
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 12
        OnKeyDown = edCodconKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = 'edBusca'
      end
    end
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 151
      Width = 1166
      Height = 260
      Margins.Left = 0
      Margins.Right = 0
      Align = alTop
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouQueTitu
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
      OnKeyDown = DBGrid1KeyDown
      OnTitleClick = DBGrid1TitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Nompes'
          Title.Alignment = taCenter
          Title.Caption = 'IDENTIFICA'#199#195'O DA PESSOA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 290
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
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nrotit'
          Title.Alignment = taCenter
          Title.Caption = 'NRO.DOCTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Destit'
          Title.Alignment = taCenter
          Title.Caption = 'PAR'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 30
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'NotFis'
          Title.Alignment = taCenter
          Title.Caption = 'NOTA FISCAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 70
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
          Title.Caption = 'VENCIMENTO'
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
          Title.Caption = 'PAGAMENTO'
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
          Title.Caption = 'VLR. T'#205'TULO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrAces'
          Title.Alignment = taCenter
          Title.Caption = 'DESP.ACESS.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DesAsso'
          Title.Alignment = taCenter
          Title.Caption = 'DESC.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorJuros'
          Title.Alignment = taCenter
          Title.Caption = 'VLR.JUROS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PercenJuros'
          Title.Alignment = taCenter
          Title.Caption = '% JUROS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorMulta'
          Title.Alignment = taCenter
          Title.Caption = 'VLR. MULTA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PercenMulta'
          Title.Alignment = taCenter
          Title.Caption = '% MULTA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
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
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'IndSel'
          Title.Alignment = taCenter
          Title.Caption = ' '
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 20
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'IndEnvBco'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'ENV'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
    object PanelTotal: TLMDSimplePanel
      Left = 1
      Top = 414
      Width = 1166
      Height = 30
      Margins.Left = 0
      Margins.Right = 0
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14079702
      Bevel.BorderWidth = 1
      Color = 16053492
      TabOrder = 3
      object Label35: TLabel
        AlignWithMargins = True
        Left = 936
        Top = 12
        Width = 100
        Height = 14
        Margins.Top = 11
        Margins.Right = 1
        Align = alRight
        Alignment = taRightJustify
        Caption = 'TOTAL DO PER'#205'ODO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitHeight = 13
      end
      object Label13: TLabel
        AlignWithMargins = True
        Left = 668
        Top = 12
        Width = 109
        Height = 14
        Margins.Left = 1
        Margins.Top = 11
        Margins.Right = 1
        Align = alRight
        Alignment = taRightJustify
        Caption = 'TOTAL SELECIONADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitHeight = 13
      end
      object LMDSimplePanel3: TLMDSimplePanel
        AlignWithMargins = True
        Left = 1040
        Top = 2
        Width = 122
        Height = 26
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alRight
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Color = 15134463
        TabOrder = 0
        object edTotPer: TCurrencyEdit
          AlignWithMargins = True
          Left = 2
          Top = 4
          Width = 115
          Height = 22
          Margins.Left = 2
          Margins.Top = 0
          Margins.Bottom = 0
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BorderStyle = bsNone
          Color = 15134463
          Ctl3D = False
          DisplayFormat = '###,###,##0.00;-###,###,##0.00'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -14
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          FormatOnEditing = True
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object LMDSimplePanel4: TLMDSimplePanel
        AlignWithMargins = True
        Left = 781
        Top = 2
        Width = 122
        Height = 26
        Margins.Top = 1
        Margins.Right = 30
        Margins.Bottom = 1
        Align = alRight
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Color = 15134463
        TabOrder = 1
        object edTotSel: TCurrencyEdit
          AlignWithMargins = True
          Left = 4
          Top = 5
          Width = 115
          Height = 22
          Margins.Left = 2
          Margins.Top = 0
          Margins.Bottom = 0
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BorderStyle = bsNone
          Color = 15134463
          Ctl3D = False
          DisplayFormat = '###,###,##0.00;-###,###,##0.00'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -14
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          FormatOnEditing = True
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
    object PanelFiltros: TLMDSimplePanel
      Left = 1
      Top = 29
      Width = 1166
      Height = 98
      Align = alTop
      Bevel.BorderColor = 15923199
      Color = 15923199
      TabOrder = 0
      object Label21: TLabel
        Left = 23
        Top = 12
        Width = 42
        Height = 13
        Caption = 'PESSOA'
        Color = 14405561
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label22: TLabel
        Left = 893
        Top = 24
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
      object Label38: TLabel
        Left = 34
        Top = 73
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'FILIAL'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 1045
        Top = 24
        Width = 7
        Height = 13
        Caption = #192
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
      object Label4: TLabel
        Left = 404
        Top = 74
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'NOT.FIS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 10
        Top = 43
        Width = 55
        Height = 13
        Caption = 'CONV'#202'NIO'
        Color = 14405561
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object LMDSimplePanel11: TLMDSimplePanel
        Left = 555
        Top = 8
        Width = 87
        Height = 49
        Bevel.BorderColor = 15923199
        Color = 15923199
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object Label37: TLabel
          Left = 21
          Top = 5
          Width = 45
          Height = 13
          Caption = #192' PAGAR'
          Color = 7039851
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label39: TLabel
          Left = 21
          Top = 31
          Width = 56
          Height = 13
          Caption = #192' RECEBER'
          Color = 7039851
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object RadioPag: TLMDRadioButton
          Left = 1
          Top = 5
          Width = 14
          Height = 14
          Alignment.Alignment = agTopLeft
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
        object RadioRec: TLMDRadioButton
          Left = 1
          Top = 31
          Width = 14
          Height = 14
          Alignment.Alignment = agTopLeft
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
      object edNompes: TLMDLabeledEdit
        Left = 71
        Top = 7
        Width = 456
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 0
        OnKeyDown = edNompesKeyDown
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
            OnClick = edNompesCustomButtons0Click
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = 'edBusca'
      end
      object edFilial: TLMDLabeledEdit
        Left = 71
        Top = 69
        Width = 316
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 1
        OnKeyDown = edFilialKeyDown
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
            OnClick = edFilialCustomButtons0Click
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 103
        EditLabel.Height = 15
        EditLabel.Caption = 'FILIAL RECEBEDORA'
      end
      object LMDSimplePanel2: TLMDSimplePanel
        Left = 945
        Top = 19
        Width = 94
        Height = 23
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 5
        object edDataIni: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 87
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
          Text = '01/01/2024'
        end
      end
      object edDatfin: TLMDSimplePanel
        Left = 1062
        Top = 19
        Width = 94
        Height = 23
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 6
        object edDataFin: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 87
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
          Text = '01/01/2024'
        end
      end
      object btBuscar: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 945
        Top = 55
        Width = 211
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Buscar T'#237'tulos'
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
        TabOrder = 7
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
      object edNotFis: TLMDLabeledEdit
        Left = 449
        Top = 69
        Width = 78
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 2
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
        LabelSpacing = -15
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = 'edBusca'
      end
      object IndBaixados: TLMDCheckBox
        Left = 555
        Top = 70
        Width = 79
        Height = 19
        Caption = 'BAIXADOS'
        ParentColor = False
        ParentBackground = False
        Alignment.Alignment = agTopLeft
        Alignment.Spacing = 4
        Color = 15923199
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnChange = IndBaixadosChange
      end
      object LMDSimplePanel6: TLMDSimplePanel
        Left = 654
        Top = 3
        Width = 233
        Height = 97
        Bevel.BorderColor = 15923199
        Bevel.StandardStyle = lsSingleRaised
        Color = 15923199
        TabOrder = 8
        object Label16: TLabel
          Left = 3
          Top = 8
          Width = 70
          Height = 13
          Caption = 'FILTRAR POR:'
          Color = 7039851
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5460819
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object ckVencimento: TLMDCheckBox
          Left = 3
          Top = 72
          Width = 90
          Height = 19
          Caption = 'VENCIMENTO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = ckVencimentoClick
          Checked = True
          State = cbChecked
        end
        object ckPagamento: TLMDCheckBox
          Left = 3
          Top = 51
          Width = 89
          Height = 19
          Caption = 'PAGAMENTO'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = ckPagamentoClick
        end
        object ckEmissao: TLMDCheckBox
          Left = 3
          Top = 30
          Width = 69
          Height = 19
          Caption = 'EMISS'#195'O'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = ckEmissaoClick
        end
        object ckEnvNao: TLMDCheckBox
          Left = 122
          Top = 29
          Width = 105
          Height = 20
          Caption = 'ENVIADOS N'#195'O'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = ckEnvNaoClick
        end
        object ckEnvSim: TLMDCheckBox
          Left = 122
          Top = 51
          Width = 105
          Height = 19
          Caption = 'ENVIADOS SIM'
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = ckEnvSimClick
        end
      end
      object edConv: TLMDLabeledEdit
        Left = 72
        Top = 38
        Width = 455
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14079702
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 9
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
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = 'edBusca'
      end
    end
    object LMDSimplePanel9: TLMDSimplePanel
      Left = 1
      Top = 127
      Width = 1166
      Height = 21
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14079702
      Bevel.BorderWidth = 1
      TabOrder = 4
      object btDesmarTudo: TAdvGlowButton
        AlignWithMargins = True
        Left = 1118
        Top = 1
        Width = 22
        Height = 19
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
        TabOrder = 0
        OnClick = btDesmarTudoClick
        Appearance.BorderColor = 14079702
        Appearance.BorderColorHot = 14079702
        Appearance.BorderColorCheckedHot = 14079702
        Appearance.BorderColorDown = 14079702
        Appearance.BorderColorChecked = 14079702
        Appearance.BorderColorDisabled = 14079702
        Appearance.BorderColorFocused = 14079702
        Appearance.Color = 14079702
        Appearance.ColorTo = 14079702
        Appearance.ColorChecked = 14079702
        Appearance.ColorCheckedTo = 14079702
        Appearance.ColorDisabled = 14079702
        Appearance.ColorDisabledTo = 14079702
        Appearance.ColorDown = 14079702
        Appearance.ColorDownTo = 14079702
        Appearance.ColorHot = 14079702
        Appearance.ColorHotTo = 14079702
        Appearance.ColorMirror = 14079702
        Appearance.ColorMirrorTo = 14079702
        Appearance.ColorMirrorHot = 14079702
        Appearance.ColorMirrorHotTo = 14079702
        Appearance.ColorMirrorDown = 14079702
        Appearance.ColorMirrorDownTo = 14079702
        Appearance.ColorMirrorChecked = 14079702
        Appearance.ColorMirrorCheckedTo = 14079702
        Appearance.ColorMirrorDisabled = 14079702
        Appearance.ColorMirrorDisabledTo = 14079702
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
      object btSelecTudo: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 1142
        Top = 1
        Width = 22
        Height = 19
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
        TabOrder = 1
        OnClick = btSelecTudoClick
        Appearance.BorderColor = 14079702
        Appearance.BorderColorHot = 14079702
        Appearance.BorderColorCheckedHot = 14079702
        Appearance.BorderColorDown = 14079702
        Appearance.BorderColorChecked = 14079702
        Appearance.BorderColorDisabled = 14079702
        Appearance.BorderColorFocused = 14079702
        Appearance.Color = 14079702
        Appearance.ColorTo = 14079702
        Appearance.ColorChecked = 14079702
        Appearance.ColorCheckedTo = 14079702
        Appearance.ColorDisabled = 14079702
        Appearance.ColorDisabledTo = 14079702
        Appearance.ColorDown = 14079702
        Appearance.ColorDownTo = 14079702
        Appearance.ColorHot = 14079702
        Appearance.ColorHotTo = 14079702
        Appearance.ColorMirror = 14079702
        Appearance.ColorMirrorTo = 14079702
        Appearance.ColorMirrorHot = 14079702
        Appearance.ColorMirrorHotTo = 14079702
        Appearance.ColorMirrorDown = 14079702
        Appearance.ColorMirrorDownTo = 14079702
        Appearance.ColorMirrorChecked = 14079702
        Appearance.ColorMirrorCheckedTo = 14079702
        Appearance.ColorMirrorDisabled = 14079702
        Appearance.ColorMirrorDisabledTo = 14079702
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
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 6
      Top = 2
      Width = 1158
      Height = 27
      Margins.Left = 5
      Margins.Top = 1
      Margins.Bottom = 0
      Align = alTop
      ParentColor = True
      TabOrder = 5
      object LMDLabel2: TLMDLabel
        AlignWithMargins = True
        Left = 6
        Top = 3
        Width = 182
        Height = 21
        Margins.Left = 6
        Align = alLeft
        Alignment = agCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Baixa / Quita'#231#227'o de T'#237'tulos'
        ExplicitLeft = 275
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 1134
        Top = 1
        Width = 24
        Height = 21
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 5
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
        Appearance.BorderColor = 16053492
        Appearance.BorderColorHot = 16053492
        Appearance.BorderColorCheckedHot = 16053492
        Appearance.BorderColorDown = 16053492
        Appearance.BorderColorChecked = 16053492
        Appearance.BorderColorDisabled = 16053492
        Appearance.BorderColorFocused = 16053492
        Appearance.Color = 16053492
        Appearance.ColorTo = 16053492
        Appearance.ColorChecked = 16053492
        Appearance.ColorCheckedTo = 16053492
        Appearance.ColorDisabled = 16053492
        Appearance.ColorDisabledTo = 16053492
        Appearance.ColorDown = 16053492
        Appearance.ColorDownTo = 16053492
        Appearance.ColorHot = 16053492
        Appearance.ColorHotTo = 16053492
        Appearance.ColorMirror = 16053492
        Appearance.ColorMirrorTo = 16053492
        Appearance.ColorMirrorHot = 16053492
        Appearance.ColorMirrorHotTo = 16053492
        Appearance.ColorMirrorDown = 16053492
        Appearance.ColorMirrorDownTo = 16053492
        Appearance.ColorMirrorChecked = 16053492
        Appearance.ColorMirrorCheckedTo = 16053492
        Appearance.ColorMirrorDisabled = 16053492
        Appearance.ColorMirrorDisabledTo = 16053492
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
  object QueTitu: TRESTDWClientSQL
    Active = False
    AfterOpen = QueTituAfterOpen
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
      
        'SELECT TIT.*,NAT.Desnat,NAT.CodconDebPro,NAT.CodconCrePro,NAT.Co' +
        'dconDebBai,NAT.CodconCreBai,PES.Nompes,'
      
        'PES.CpfCnpjPes,PES.Endpes,PES.NroEnd,PES.CompEnd,PES.Baipes,PES.' +
        'Ceppes,BAN.IDPix,BAN.Codban,BAN.Agencia,BAN.NroConta,'
      
        'BAN.CodChaPix,BAT.IDTipCon,FIL.Nomfil,MUN.Nommun,MUN.Estmun,TIP.' +
        'CodForLan,TIP.CodTipSer,BAI.Datpag FROM arqtitulo TIT'
      'LEFT JOIN arqpessoa PES ON TIT.IDPess = PES.IDPess '
      'LEFT JOIN arqpessbanc BAN ON BAN.IDPess = PES.IDPess'
      'LEFT JOIN arqbancotip BAT ON BAT.IDTipCon = BAN.IDTipCon'
      'LEFT JOIN arqmuni MUN ON PES.Codmun = MUN.Codmun '
      'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial'
      'LEFT JOIN arqnatfin NAT ON TIT.IDNatfin = NAT.IDNatfin '
      'LEFT JOIN arqtiptitu TIP ON TIT.IDTiptit = TIP.IDTiptit '
      'LEFT JOIN arqtitulobai BAI on TIT.IDTitu = BAI.IDTitu'
      'WHERE Datven BETWEEN '#39'2024-01-01'#39' AND '#39'2024-12-31'#39)
    UpdateTableName = 'arqtitulo'
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 30
    Top = 254
    object QueTituIDTitu: TFDAutoIncField
      FieldName = 'IDTitu'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object QueTituIDPess: TIntegerField
      FieldName = 'IDPess'
    end
    object QueTituNrotit: TWideStringField
      FieldName = 'Nrotit'
      Size = 12
    end
    object QueTituDestit: TWideStringField
      FieldName = 'Destit'
      Size = 3
    end
    object QueTituIDTiptit: TIntegerField
      FieldName = 'IDTiptit'
    end
    object QueTituDatemi: TDateField
      FieldName = 'Datemi'
    end
    object QueTituDatven: TDateField
      FieldName = 'Datven'
    end
    object QueTituDesAsso: TFloatField
      FieldName = 'DesAsso'
    end
    object QueTituVlrAces: TFloatField
      FieldName = 'VlrAces'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueTituVlrDevo: TFloatField
      FieldName = 'VlrDevo'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueTituVlrtit: TFloatField
      FieldName = 'Vlrtit'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueTituSaltit: TFloatField
      FieldName = 'Saltit'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QueTituIDFilial: TIntegerField
      FieldName = 'IDFilial'
    end
    object QueTituIDPed: TIntegerField
      FieldName = 'IDPed'
    end
    object QueTituIDNatFin: TIntegerField
      FieldName = 'IDNatFin'
      ProviderFlags = []
    end
    object QueTituPagRec: TWideStringField
      FieldName = 'PagRec'
      Size = 1
    end
    object QueTituNotFis: TIntegerField
      FieldName = 'NotFis'
    end
    object QueTituHistit: TWideStringField
      FieldName = 'Histit'
      Size = 120
    end
    object QueTituCodBarra: TWideStringField
      FieldName = 'CodBarra'
      Size = 48
    end
    object QueTituIndSel: TWideStringField
      FieldName = 'IndSel'
      Size = 1
    end
    object QueTituIndEnvBco: TWideStringField
      FieldName = 'IndEnvBco'
      Size = 1
    end
    object QueTituNumEnvBco: TIntegerField
      FieldName = 'NumEnvBco'
    end
    object QueTituDesnat: TWideStringField
      FieldName = 'Desnat'
      ProviderFlags = []
      Size = 40
    end
    object QueTituCodconDebPro: TWideStringField
      FieldName = 'CodconDebPro'
      ProviderFlags = []
      Size = 8
    end
    object QueTituCodconCrePro: TWideStringField
      FieldName = 'CodconCrePro'
      ProviderFlags = []
      Size = 8
    end
    object QueTituCodconDebBai: TWideStringField
      FieldName = 'CodconDebBai'
      ProviderFlags = []
      Size = 8
    end
    object QueTituCodconCreBai: TWideStringField
      FieldName = 'CodconCreBai'
      ProviderFlags = []
      Size = 8
    end
    object QueTituNompes: TWideStringField
      FieldName = 'Nompes'
      ProviderFlags = []
      Size = 80
    end
    object QueTituCpfCnpjPes: TWideStringField
      FieldName = 'CpfCnpjPes'
      ProviderFlags = []
      Size = 14
    end
    object QueTituEndpes: TWideStringField
      FieldName = 'Endpes'
      ProviderFlags = []
      Size = 50
    end
    object QueTituNroEnd: TWideStringField
      FieldName = 'NroEnd'
      ProviderFlags = []
      Size = 8
    end
    object QueTituCompEnd: TWideStringField
      FieldName = 'CompEnd'
      ProviderFlags = []
      Size = 35
    end
    object QueTituBaipes: TWideStringField
      FieldName = 'Baipes'
      ProviderFlags = []
      Size = 40
    end
    object QueTituCeppes: TWideStringField
      FieldName = 'Ceppes'
      ProviderFlags = []
      Size = 8
    end
    object QueTituIDPix: TWideStringField
      FieldName = 'IDPix'
      ProviderFlags = []
      Size = 80
    end
    object QueTituCodban: TIntegerField
      FieldName = 'Codban'
      ProviderFlags = []
    end
    object QueTituAgencia: TWideStringField
      FieldName = 'Agencia'
      ProviderFlags = []
      Size = 8
    end
    object QueTituNroConta: TWideStringField
      FieldName = 'NroConta'
      ProviderFlags = []
      Size = 15
    end
    object QueTituNomfil: TWideStringField
      FieldName = 'Nomfil'
      ProviderFlags = []
      Size = 45
    end
    object QueTituNommun: TWideStringField
      FieldName = 'Nommun'
      ProviderFlags = []
      Size = 55
    end
    object QueTituEstmun: TWideStringField
      FieldName = 'Estmun'
      ProviderFlags = []
      Size = 2
    end
    object QueTituIDConv: TIntegerField
      FieldName = 'IDConv'
      ProviderFlags = []
    end
    object QueTituNossoNro: TWideStringField
      FieldName = 'NossoNro'
      ProviderFlags = []
    end
    object QueTituCodForLan: TIntegerField
      FieldName = 'CodForLan'
      ProviderFlags = []
    end
    object QueTituCodTipSer: TIntegerField
      FieldName = 'CodTipSer'
      ProviderFlags = []
    end
    object QueTituCodChaPix: TIntegerField
      FieldName = 'CodChaPix'
      ProviderFlags = []
    end
    object QueTituCodRec: TIntegerField
      FieldName = 'CodRec'
      ProviderFlags = []
    end
    object QueTituNumReferencia: TWideStringField
      FieldName = 'NumReferencia'
      ProviderFlags = []
    end
    object QueTituDatCompApur: TDateField
      FieldName = 'DatCompApur'
      ProviderFlags = []
    end
    object QueTituValorJuros: TFloatField
      FieldName = 'ValorJuros'
      ProviderFlags = []
    end
    object QueTituValorMulta: TFloatField
      FieldName = 'ValorMulta'
      ProviderFlags = []
    end
    object QueTituPercenJuros: TFloatField
      FieldName = 'PercenJuros'
      ProviderFlags = []
    end
    object QueTituPercenMulta: TFloatField
      FieldName = 'PercenMulta'
      ProviderFlags = []
    end
    object QueTituIDTipCon: TWideStringField
      FieldName = 'IDTipCon'
      ProviderFlags = []
      Size = 3
    end
    object QueTituChavePIXQRCode: TWideStringField
      FieldName = 'ChavePIXQRCode'
      ProviderFlags = []
      Size = 100
    end
    object QueTituAgBenef: TLargeintField
      FieldName = 'AgBenef'
      ProviderFlags = []
    end
    object QueTituDatpag: TDateField
      FieldName = 'Datpag'
      ProviderFlags = []
    end
  end
  object SouQueTitu: TDataSource
    AutoEdit = False
    DataSet = QueTitu
    Left = 98
    Top = 254
  end
  object ACBrPagFor1: TACBrPagFor
    Configuracoes.Geral.Empresa.TipoInscricao = tiIsento
    Configuracoes.Geral.Empresa.Conta.AgenciaCodigo = 0
    Configuracoes.Geral.Empresa.Conta.ContaNumero = 0
    Configuracoes.Geral.Empresa.Conta.TipoConta = 0
    Configuracoes.Geral.Empresa.Endereco.CEP = 0
    Configuracoes.Arquivos.PathSalvar = 'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\'
    Configuracoes.Arquivos.Salvar = True
    Left = 181
    Top = 254
  end
  object odAbrirArq: TLMDFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    FileTypeIndex = 0
    OkButtonLabel = 'Voltar'
    Options = []
    Left = 262
    Top = 254
  end
end
