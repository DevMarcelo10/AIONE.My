object FrmMetaFil: TFrmMetaFil
  AlignWithMargins = True
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 1
  Align = alClient
  BorderStyle = bsNone
  Caption = 'VENDAS - Metas Comiss'#245'es / Filial'
  ClientHeight = 309
  ClientWidth = 890
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object LMDSimplePanel2: TLMDSimplePanel
    Left = 0
    Top = 52
    Width = 890
    Height = 257
    Align = alClient
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
      Top = 8
      Width = 888
      Height = 248
      Margins.Left = 0
      Margins.Top = 7
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouFilial
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
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
          FieldName = 'Nomfil'
          Title.Alignment = taCenter
          Title.Caption = 'NOME DA FILIAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 297
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrMeta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'VALOR META'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SupMeta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'SUPER META'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HipMeta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'HIPER META'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TicMeta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESCONTOS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrDesc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'TICKET M'#201'DIO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UniMeta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'UNIDADES'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 90
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 22
          Visible = True
        end>
    end
  end
  object PanelEdit: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 890
    Height = 50
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 2
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 14674687
    TabOrder = 1
    object LMDLabel1: TLMDLabel
      Left = 7
      Top = 6
      Width = 39
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'FILIAL'
    end
    object LMDLabel2: TLMDLabel
      Left = 283
      Top = 6
      Width = 77
      Height = 16
      Alignment = agCenterLeft
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'META R$'
    end
    object LMDLabel3: TLMDLabel
      Left = 377
      Top = 6
      Width = 94
      Height = 16
      Alignment = agCenterLeft
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'SUPER META %'
    end
    object LMDLabel4: TLMDLabel
      Left = 477
      Top = 3
      Width = 90
      Height = 16
      Alignment = agCenterLeft
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'HIPER META %'
    end
    object LMDLabel5: TLMDLabel
      Left = 568
      Top = 6
      Width = 95
      Height = 16
      Alignment = agCenterLeft
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'TICKET M'#201'D. %'
    end
    object LMDLabel6: TLMDLabel
      Left = 667
      Top = 6
      Width = 77
      Height = 16
      Alignment = agCenterLeft
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'DESCONTO %'
    end
    object LMDLabel7: TLMDLabel
      Left = 748
      Top = 6
      Width = 77
      Height = 16
      Alignment = agCenterLeft
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8811110
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'UNIDADES'
    end
    object edNomfil: TLMDLabeledEdit
      Left = 7
      Top = 23
      Width = 270
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = clLightgray
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 0
      OnKeyDown = edNomfilKeyDown
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      CharCase = ecUpperCase
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
          OnClick = edNomfilCustomButtons0Click
          UsePngGlyph = True
        end>
      PasswordChar = #0
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -12
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Caption = 'edBusca'
    end
    object btLimpaIte: TAdvGlowButton
      Tag = 3
      AlignWithMargins = True
      Left = 833
      Top = 23
      Width = 21
      Height = 21
      Cursor = crHandPoint
      Hint = 'Limpa campos'
      Margins.Top = 22
      Margins.Bottom = 5
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -12
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
        F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A000002C849
        44415448899D964D68136110869FF952F5A0D48322DAA287A2945E4AD7509152
        ED558516BDE94510A468412D66D3A207B129283689222A2A1E3D0852C57F45F1
        A07850D06CED495BA44AB5828288284893EC788849369B64A39DE33BB3CF3BF3
        B13BDF0A01A1035603597A10BA8126D0469010F011E43DEADE03B92149E74335
        86540447C24B11D706FA8105414D002EC835C80C4A627CAAA68146ACCD085780
        C535C0FEF885CA4E49A6AE7B45E383EF41B83D0738C0424447D5B60E7AC5C204
        1A5DBB09D53B40680EF0923E41B64B2275B560A0FDE115D4B96F807A8FF57394
        34B0A106F029C27C94F51EED2726DB2223E31F734734CF8D95C1E34E87249C8D
        A04703E0C39270BA883B1DA02F3CFA225C1303307AB07D25CA2EDF9069010590
        C4D810E8E12AF023B97E50205D9A969D3A185E6530996D949FFB068DB49D2894
        26C68E039162033A92870368D41A02E9F4314264DDAD06D85271789101B5AD58
        D1C439091C00862539365880DB560CE5482504B059D4B62681D5550A72DD7A80
        25A9A8351400079830C0F28082B2490AF0E0CEF3D16000B74691227CAD204FF3
        F7450888AC016682E1B24FE2CE99A290FB7624317609917D354C3E1B6032189E
        3A57106CEB18D1B60B059378EA5CA0893061406F574EFAE16BE3C021547AAB98
        94872B770DE9CC2D60D6477F98872B88DAD66950BB389BF4625BE74B4D78E4C3
        CF6242B772BBC86E3B05D2EF49BEE68769A7E155969FD659606FC50EE1228B9C
        3E66C221EADD97406BB109CE48D2D99F3338B46E09E9F41B60A9E7E1772019D0
        E62AF0FCB46F11771E2A4D1EF11B645B2431FEA5B8AE23E14EC47D0CCC0F06D6
        8C2C4AB7249DFBE0B97024F9EA19CA6ECA96D6FFC2A52F0F874A5766D4EA4219
        A5F4B8FE25BE23B243E2A9075ED1F8AB24EE3C213BDB0C9C007EFF03D8052E23
        752D7E3854F9ABC887DAADCB50D383916E94354023B9D53E0D4CA17A07576FCA
        A9D79FAA31FE00CB8E108EC042D2D10000000049454E44AE426082}
      Rounded = True
      ShowCaption = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btLimpaIteClick
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
      Appearance.ColorMirrorHotTo = 14674687
      Appearance.ColorMirrorDown = 14674687
      Appearance.ColorMirrorDownTo = 14674687
      Appearance.ColorMirrorChecked = 14674687
      Appearance.ColorMirrorCheckedTo = 14674687
      Appearance.ColorMirrorDisabled = 14674687
      Appearance.ColorMirrorDisabledTo = 14674687
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
    object btIncluir: TAdvGlowButton
      Tag = 3
      AlignWithMargins = True
      Left = 860
      Top = 23
      Width = 21
      Height = 21
      Cursor = crHandPoint
      Hint = 'Salva item'
      Margins.Top = 22
      Margins.Right = 8
      Margins.Bottom = 5
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -12
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
        F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000026B49
        4441544889AD96BF4F535114C73FE7BEE224EC580A18D0E820D812FE08904058
        74C0C904A3891229142609244E14D068620C264E3A11A302253A60FF00639F3A
        E806FE0071324116135EEF7178D8B4F5B514EA19BFE79ECF39F7E67B6FAE5026
        34DE19C164FB40CF01CD40642FF50D58472485782F64FAC3462986048287DBC3
        846402954B40A8DC108005798A6A4266DD2FFB36D078B417A38F416AF7011757
        EE80199099CC52BE6A0A9624A2D7313C3B381CFC1A7DAEA3B16B056A0E3E12ED
        4258029C83C30BC262E997397731D74087DBC338F2E9709307C62F3C734AEEBC
        DDF28FC8315355C145D7809F794A1D35D9493F15EF8C60BC750E7B34CA23BEB6
        5E26F2F95811C7236B9B8DEFF32AE0B5EEA02C2C6439B2EB50E8CA1046FA0C68
        7755F049AC0EB787F1E41545AE444CB7015A02CA37808F15C1C7DA1A704C1A38
        19B0B0C580D617A91E35356739EA9E41B957161EEF8C609D3470A2C4246113A0
        3AECFEAE9749ACCCBA43283703E1E31D8D182F0DB496DC296040B68A34016755
        47621D0032EBDE02B902F2B0006EB369828F371FB5293A1A5D01BA02B6B78395
        7E9973570BD4916813421A385E1E0E20298348AA44B216C38A26621772F0F18E
        468CBEAE0C0EA82E8B8EB535609D754A3FCB166402B12E2AF781A68AE07B17CD
        7F8B4663F3A08315165616C20349BA577D17199DF4DFF3FF16DB109A82BD9B27
        D3EE77C49C07B2FF016E11B928C9373F720D00249979097203B055C287249959
        CE718B576822D683EA13A0EE80F06DD001997957E0CA7F6EB22433CBA86901EE
        025E05600FD1793C73BA180E257E157FC3FF5D985E941E7CEFE77D5B640DD114
        9E5D94DBEF374B31FE002B96E3D4261DE3E90000000049454E44AE426082}
      Rounded = True
      ShowCaption = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btIncluirClick
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
      Appearance.ColorMirrorHotTo = 14674687
      Appearance.ColorMirrorDown = 15528703
      Appearance.ColorMirrorDownTo = 14674687
      Appearance.ColorMirrorChecked = 14674687
      Appearance.ColorMirrorCheckedTo = 14674687
      Appearance.ColorMirrorDisabled = 14674687
      Appearance.ColorMirrorDisabledTo = 14674687
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
    object edVlrMeta: TLMDMaskEdit
      Left = 284
      Top = 23
      Width = 90
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      AutoSelect = True
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      CustomButtonsStyle = ubsFlat
      CustomButtonWidth = 20
      CustomButtonParentCtlXP = False
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edSupMeta: TLMDMaskEdit
      Left = 378
      Top = 23
      Width = 93
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      AutoSelect = True
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      CustomButtonsStyle = ubsFlat
      CustomButtonWidth = 20
      CustomButtonParentCtlXP = False
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edHipMeta: TLMDMaskEdit
      Left = 475
      Top = 23
      Width = 90
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      AutoSelect = True
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      CustomButtonsStyle = ubsFlat
      CustomButtonWidth = 20
      CustomButtonParentCtlXP = False
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edTicMed: TLMDMaskEdit
      Left = 569
      Top = 23
      Width = 95
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      AutoSelect = True
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      CustomButtonsStyle = ubsFlat
      CustomButtonWidth = 20
      CustomButtonParentCtlXP = False
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edDesco: TLMDMaskEdit
      Left = 668
      Top = 23
      Width = 76
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      AutoSelect = True
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      CustomButtonsStyle = ubsFlat
      CustomButtonWidth = 20
      CustomButtonParentCtlXP = False
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edUnidade: TLMDMaskEdit
      Left = 748
      Top = 23
      Width = 76
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 6
      OnExit = edUnidadeExit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      AutoSelect = True
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      CustomButtonsStyle = ubsFlat
      CustomButtonWidth = 20
      CustomButtonParentCtlXP = False
      Decimals = 2
      MaskType = meFloatNumber
      TabOnEnter = True
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
  end
  object TabFilial: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDMetVen'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'IDFilial'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'VlrMeta'
        DataType = ftFloat
      end
      item
        Name = 'HipMeta'
        DataType = ftFloat
      end
      item
        Name = 'TicMeta'
        DataType = ftFloat
      end
      item
        Name = 'VlrDesc'
        DataType = ftFloat
      end
      item
        Name = 'UniMeta'
        DataType = ftFloat
      end
      item
        Name = 'Nomfil'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'SupMeta'
        DataType = ftFloat
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
    Params = <
      item
        DataType = ftString
        Name = 'IDMetVen'
        ParamType = ptInput
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT MET.*,FIL.Nomfil FROM arqmetafil MET'
      'LEFT JOIN arqfilial FIL ON MET.IDFilial = FIL.IDFilial'
      'WHERE MET.IDMetVen = :IDMetVen')
    UpdateTableName = 'arqmetafil'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 60
    Top = 107
    object TabFilialIDMetVen: TIntegerField
      FieldName = 'IDMetVen'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabFilialIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabFilialVlrMeta: TFloatField
      FieldName = 'VlrMeta'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabFilialSupMeta: TFloatField
      FieldName = 'SupMeta'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabFilialHipMeta: TFloatField
      FieldName = 'HipMeta'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabFilialTicMeta: TFloatField
      FieldName = 'TicMeta'
      DisplayFormat = '###,###,##0.00'
    end
    object TabFilialVlrDesc: TFloatField
      FieldName = 'VlrDesc'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabFilialUniMeta: TFloatField
      FieldName = 'UniMeta'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabFilialNomfil: TWideStringField
      FieldName = 'Nomfil'
      ProviderFlags = []
      Size = 45
    end
  end
  object SouFilial: TDataSource
    AutoEdit = False
    DataSet = TabFilial
    Left = 58
    Top = 171
  end
end
