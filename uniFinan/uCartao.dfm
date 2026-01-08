object FrmCartao: TFrmCartao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Financeiro - Cart'#245'es Credito / Debito'
  ClientHeight = 542
  ClientWidth = 973
  Color = 16250871
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 2236186
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelQuitacao: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 973
    Height = 542
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
      Top = 126
      Width = 971
      Height = 1
      Align = alTop
      Pen.Color = 13224393
      ExplicitLeft = 0
    end
    object PanelBaixa: TLMDSimplePanel
      Left = 1
      Top = 465
      Width = 971
      Height = 76
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      Bevel.StyleInner = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = clSilver
      Color = 16250871
      TabOrder = 2
      object Label6: TLabel
        Left = 50
        Top = 16
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'TOTAL BRUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 426
        Top = 16
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'TAX.ADICION.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 252
        Top = 16
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'TARIFAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 622
        Top = 16
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'TOTAL L'#205'QUIDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 8
        Top = 48
        Width = 121
        Height = 14
        Alignment = taRightJustify
        Caption = 'CONTA BANCO BAIXA'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 971
        Height = 1
        Align = alTop
        Pen.Color = 13224393
        ExplicitTop = 104
        ExplicitWidth = 886
      end
      object VlrJurAux: TCurrencyEdit
        Left = 135
        Top = 11
        Width = 103
        Height = 23
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = 15134463
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
      end
      object VlrDesAux: TCurrencyEdit
        Left = 508
        Top = 11
        Width = 96
        Height = 23
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = 15134463
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
      end
      object VlrPagAux: TCurrencyEdit
        Left = 309
        Top = 11
        Width = 96
        Height = 23
        Margins.Left = 4
        Margins.Top = 1
        AutoSize = False
        Color = 15134463
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
      end
      object TotPagAux: TCurrencyEdit
        Left = 714
        Top = 11
        Width = 116
        Height = 23
        Margins.Left = 1
        Margins.Top = 1
        AutoSize = False
        Color = 15134463
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object edCodcon: TLMDLabeledEdit
        Left = 135
        Top = 44
        Width = 469
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 4
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
      object btBaiTudo: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 846
        Top = 40
        Width = 122
        Height = 23
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Baixar TUDO'
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
        Rounded = False
        Spacing = 7
        TabOrder = 5
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
        Left = 846
        Top = 9
        Width = 121
        Height = 23
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Baixar Sele'#231#227'o'
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
        Rounded = False
        Spacing = 7
        TabOrder = 6
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
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 9
      Top = 4
      Width = 960
      Height = 27
      Margins.Left = 8
      Align = alTop
      ParentColor = True
      TabOrder = 3
      object LMDLabel2: TLMDLabel
        Left = 0
        Top = 0
        Width = 177
        Height = 27
        Margins.Left = 0
        Align = alLeft
        Alignment = agCenterLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Cart'#245'es D'#233'bito / Cr'#233'dito'
        ExplicitTop = 4
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 936
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
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 130
      Width = 971
      Height = 333
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 2
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
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'ADIQUIRENTE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'BANDEIRA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 133
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'IDENTIFICA'#199#195'O DA PESSOA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 202
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'NOTA FISCAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'PAR.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 36
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'VENCIMENTO'
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
          Title.Caption = 'VALOR'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 89
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'TARIFAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'VLR.L'#205'QUIDO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          Width = 24
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = ' '
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 24
          Visible = True
        end>
    end
    object PanelFiltros: TLMDSimplePanel
      Left = 1
      Top = 34
      Width = 971
      Height = 92
      Align = alTop
      Color = 16053492
      TabOrder = 0
      ExplicitLeft = 17
      ExplicitTop = 37
      object Label21: TLabel
        Left = 26
        Top = 12
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'BANDEIRA'
        Color = 14405561
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label22: TLabel
        Left = 699
        Top = 13
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
        Left = 47
        Top = 39
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'FILIAL'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 849
        Top = 13
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
        Left = 354
        Top = 39
        Width = 24
        Height = 13
        Alignment = taRightJustify
        Caption = 'TIPO'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 30
        Top = 69
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'ARQUIVO '
        Font.Charset = ANSI_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object LMDSimplePanel11: TLMDSimplePanel
        Left = 582
        Top = 9
        Width = 98
        Height = 49
        Color = 16250871
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Label37: TLabel
          Left = 21
          Top = 2
          Width = 73
          Height = 13
          Caption = 'LAN'#199'AMENTO'
          Color = 16514043
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
          Width = 69
          Height = 13
          Caption = 'VENCIMENTO'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object RadioLan: TLMDRadioButton
          Left = 1
          Top = 2
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
        object RadioVen: TLMDRadioButton
          Left = 1
          Top = 30
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
      object edFilial: TLMDLabeledEdit
        Left = 84
        Top = 35
        Width = 254
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 0
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
        Left = 749
        Top = 7
        Width = 94
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 3
        object edDataIni: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 87
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
          Text = '01/01/2024'
        end
      end
      object edDatfin: TLMDSimplePanel
        Left = 861
        Top = 7
        Width = 94
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 4
        object edDataFin: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 87
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
          Text = '01/01/2024'
        end
      end
      object btBuscar: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 749
        Top = 62
        Width = 206
        Height = 24
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
        TabOrder = 5
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
        Left = 383
        Top = 35
        Width = 64
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 1
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
      object LMDSimplePanel4: TLMDSimplePanel
        Left = 473
        Top = 9
        Width = 89
        Height = 49
        Color = 16250871
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object Label13: TLabel
          Left = 21
          Top = 2
          Width = 60
          Height = 13
          Caption = 'EM ABERTO'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label14: TLabel
          Left = 21
          Top = 31
          Width = 64
          Height = 13
          Caption = 'CONCILIADO'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object RadioAbe: TLMDRadioButton
          Left = 1
          Top = 2
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
        object RadioCon: TLMDRadioButton
          Left = 1
          Top = 30
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
      object edNomcar: TLMDLabeledEdit
        Left = 84
        Top = 7
        Width = 363
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 7
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <
          item
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000012000000180806000000F755AD
              31000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC300000EC301C76FA864000000A34944415478DAED933B
              0E8420004487C653D0500077C00AE3B1893612CE0016345C429BDD9582C26D0C
              EB1A0B5F350478099F21AF0F3801F2886E245A96055A6B1042308E239AA6A913
              CDF30C2144CE210470CEEB44DB662965CEDEFB22BD4EB4AE2B524A651C6344DF
              F7391B63C0182B7394D272675F22A5149C7338C2B6D65AFBBBA86D5B4CD3F4E7
              A3DDEFD5F69CF621B78A745D972B320C437D458EF2882E14BD01566DB3B9AEE8
              10B30000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edNomcarCustomButtons0Click
            UsePngGlyph = True
          end
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
            Index = 1
            DisplayName = 'TLMDSpecialButton'
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = 'edBusca'
      end
      object edArquivo: TLMDLabeledEdit
        Left = 84
        Top = 64
        Width = 598
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        TabOrder = 8
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
            OnClick = edArquivoCustomButtons0Click
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
    end
  end
  object OpenPastaDialog: TOpenPictureDialog
    Ctl3D = False
    Filter = 'Todos (*.txt)|*.txt|Arquivos txt (*.txt)|*.txt'
    Title = 'Procura arquivo concilia'#231#227'o'
    Left = 895
    Top = 201
  end
end
