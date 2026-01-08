object FrmCaixa: TFrmCaixa
  Left = 470
  Top = 249
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'CAIXA'
  ClientHeight = 608
  ClientWidth = 1098
  Color = 16381167
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 14
  object PanelCadastro: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 1098
    Height = 608
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13948116
    Bevel.BorderWidth = 1
    Color = 16382200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7039851
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 4
      Top = 6
      Width = 1090
      Height = 31
      Margins.Top = 5
      Align = alTop
      ParentColor = True
      TabOrder = 1
      object LMDLabel2: TLMDLabel
        Left = 523
        Top = 7
        Width = 47
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'CAIXA'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 1065
        Top = 3
        Width = 24
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Right = 1
        Margins.Bottom = 4
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
        Appearance.BorderColor = clWhitesmoke
        Appearance.BorderColorHot = clWhitesmoke
        Appearance.BorderColorCheckedHot = clWhitesmoke
        Appearance.BorderColorDown = clWhitesmoke
        Appearance.BorderColorChecked = clWhitesmoke
        Appearance.BorderColorDisabled = clWhitesmoke
        Appearance.BorderColorFocused = clWhitesmoke
        Appearance.Color = clWhitesmoke
        Appearance.ColorTo = clWhitesmoke
        Appearance.ColorChecked = clWhitesmoke
        Appearance.ColorCheckedTo = clWhitesmoke
        Appearance.ColorDisabled = clWhitesmoke
        Appearance.ColorDisabledTo = clWhitesmoke
        Appearance.ColorDown = clWhitesmoke
        Appearance.ColorDownTo = clWhitesmoke
        Appearance.ColorHot = clWhitesmoke
        Appearance.ColorHotTo = clWhitesmoke
        Appearance.ColorMirror = clWhitesmoke
        Appearance.ColorMirrorTo = clWhitesmoke
        Appearance.ColorMirrorHot = clWhitesmoke
        Appearance.ColorMirrorHotTo = clWhitesmoke
        Appearance.ColorMirrorDown = clWhitesmoke
        Appearance.ColorMirrorDownTo = clWhitesmoke
        Appearance.ColorMirrorChecked = clWhitesmoke
        Appearance.ColorMirrorCheckedTo = clWhitesmoke
        Appearance.ColorMirrorDisabled = clWhitesmoke
        Appearance.ColorMirrorDisabledTo = clWhitesmoke
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
      object btBusca: TAdvGlowButton
        AlignWithMargins = True
        Left = 1026
        Top = 0
        Width = 24
        Height = 31
        Cursor = crHandPoint
        Hint = 'Buscar metas'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 15
        Margins.Bottom = 0
        Align = alRight
        AntiAlias = aaAntiAlias
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
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
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000024049
          4441544889ED93BF6B137118C63FEFC5DEC528A160268BD8529DAA2E4510411A
          5092201171888AE0AE62F10F70E9A0832838288A8B9BD050053585704D5B833F
          A8148A08C5ED0683458503E55A3525DCBD0E49214D4D7355DCFA4CC7F77DEFF9
          DCF3BDF7854D7590846DCC64320755F5023004F401DF800F22F2B85AAD3E2C97
          CB4B7F054826935B2CCBBA0D5C020CC0032AC076A0B7D1560982E05CA9547AD3
          FABED1C15F2CCB1A052E038EAA9E725D3761DBF67EDBB6FB7CDFDF0DDC057619
          8661A752A9C31B4A904AA52E8AC83D60767979395D2E97BFB7E93B2B228F808A
          699A038542E1E74A2DD2CE7C7070B02B168B3D01BA8220189A9E9EFEDAAED771
          9CF9FEFEFE1D2292F67DFF8BE338B32BB5B6579448240E89488F88E42727272B
          EB25058844223701054E379FAFF70F0E00A8EAAB4EE600C562F113F011180805
          109158E3F1471840434B80150A10044105C0308CBD619C73B99C497D6C3F8702
          98A6F91AF055F5CCC8C848A771667171314B7D375E84028C8F8F2F00CF807D33
          3333C3EB992793C96E55BD01A86118F743010054F52AF5C9B8954EA7AFFC2949
          2693E98D46A325608FAADE29168BEF9AEB6D172D97CB6DF53CAF001C6D3A9E17
          913CF5ADDE061CA13E965120EFBAEEF9B9B9B95A47408BF994EFFBC386615C17
          9193ADA955754144AED9B6FDA0917695D6005ACDE3F1F889B1B1B15F00D96CB6
          A756AB0DA9EA4E11A902EF5DD77DDBFAD56D010DF3E7C031E0A5AA1E9F9898D8
          C81EACD1AAB89EE78D36CCA7E2F178E65FCDD700806EE069F3B56CEABFEB376F
          47E0B7A8A8DABC0000000049454E44AE426082}
        Rounded = True
        ShortCutHint = ' Ctrl+B '
        ShortCutHintPos = shpBottom
        Spacing = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Visible = False
        Appearance.BorderColor = 16382200
        Appearance.BorderColorHot = 16382200
        Appearance.BorderColorCheckedHot = 16382200
        Appearance.BorderColorDown = 16382200
        Appearance.BorderColorChecked = 16382200
        Appearance.BorderColorDisabled = 16382200
        Appearance.BorderColorFocused = 16382200
        Appearance.Color = 16382200
        Appearance.ColorTo = 16382200
        Appearance.ColorChecked = 16382200
        Appearance.ColorCheckedTo = 16382200
        Appearance.ColorDisabled = 16382200
        Appearance.ColorDisabledTo = 16382200
        Appearance.ColorDown = 16382200
        Appearance.ColorDownTo = 16382200
        Appearance.ColorHot = 16382200
        Appearance.ColorHotTo = 16382200
        Appearance.ColorMirror = 16382200
        Appearance.ColorMirrorTo = 16382200
        Appearance.ColorMirrorHot = 16382200
        Appearance.ColorMirrorHotTo = 16382200
        Appearance.ColorMirrorDown = 16382200
        Appearance.ColorMirrorDownTo = 16382200
        Appearance.ColorMirrorChecked = 16382200
        Appearance.ColorMirrorCheckedTo = 16382200
        Appearance.ColorMirrorDisabled = 16382200
        Appearance.ColorMirrorDisabledTo = 16382200
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
    object PanelDadCom: TLMDSimplePanel
      Left = 1
      Top = 40
      Width = 1096
      Height = 567
      Align = alClient
      Color = 16381943
      TabOrder = 0
      object PnaelBasMenus: TLMDSimplePanel
        Left = 0
        Top = 0
        Width = 1096
        Height = 36
        Align = alTop
        Color = 14674687
        TabOrder = 0
        object Shape2: TShape
          Left = 0
          Top = 35
          Width = 1096
          Height = 1
          Align = alBottom
          Pen.Color = 12572415
          ExplicitLeft = 668
          ExplicitTop = 16
          ExplicitWidth = 65
        end
        object PanelMenFor: TLMDSimplePanel
          Left = 0
          Top = 0
          Width = 1096
          Height = 35
          Align = alClient
          Color = 14674687
          TabOrder = 1
          Visible = False
          object btConFor: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 5
            Top = 1
            Width = 152
            Height = 34
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Contatos Fonecedor'
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
              57000000097048597300000B1300000B1301009A9C18000000B149444154789C
              BDD2BB0902511085E11F045361338DB6063134120C0CB60FB702231FA0A15884
              76A0A9B660B6550876E0838111868BC9DC410F9CF4BB7798811FA60BB4A3C802
              7802870832065E5AC186B9D0CE40D22BD0CA815609249DE4408304B901059939
              19684D20257057A8013A11AC021E8A5DA237559B11CFE667852EC0B5CD99C11A
              60A30BF89C86EBCEA666CCB472B47BCFE89559405A79A4E7DDE6F10B34F72036
              7D60096C81512EF29FBC01861A3CAB77FB0DE20000000049454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 0
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 26
          end
          object btPedEle: TAdvGlowButton
            AlignWithMargins = True
            Left = 312
            Top = 1
            Width = 139
            Height = 34
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Pedido Eletr'#244'nico'
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
              EA000000097048597300000B1300000B1301009A9C18000000206348524D0000
              7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
              C546000000BD4944415478DA7C90310AC2401444DF8258D9D97B011B85606BE1
              31BC809D90337801AD6D6D2DED55B0B01441ADA2A548A21E208C4592DD900DEE
              34FB3F8FF9C320E8B32726C975125C084426040F54D251203E0C1CA01AC0223E
              70B39B37411D900A9EF93FA903C4BE3C186144F5256C79012D8D7D8725216931
              D59D9809A60E6858DB1D5700DAC09C0E61B6B619645C0483DB5A07131301F0D5
              88A6D958DACB3011ACFE853CB0765306DCBDAA0A4559513D16743195B2C45943
              F80D00A48EBE0F43514C9C0000000049454E44AE426082}
            Rounded = False
            TabOrder = 1
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 29
          end
          object btNegoci: TAdvGlowButton
            AlignWithMargins = True
            Left = 457
            Top = 1
            Width = 113
            Height = 34
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Negocia'#231#245'es'
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
              89504E470D0A1A0A0000000D49484452000000180000001808040000004A7EF5
              73000000206348524D00007A26000080840000FA00000080E8000075300000EA
              6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
              485973000000600000006000F06B42CF0000000774494D4507E70811111217F9
              83C6F2000001654944415438CBE5D24B4B145018C6F19F4E4297452184588960
              880C3610843998420AB50B4DA945CB40A3745988861BA155DFC0A5442E22D0BC
              80F509DABAB0950806316A259A9378998E0BC7D1B9558B763D6777CEFF799FF7
              3DE7F03FE8C4EF0E2F5BF03C6BE7A584FAE2F89220E81471578F1EAF05C17261
              4BB54541F0C6199342D62A9072587DDC691339F841CA95E3784D1A0FA24604C1
              477382E0A7BD4C4AF4E80EBA54A5AD755E29336BDA9E6631931A8C8AA0C26D9F
              0E1322C6D275360D6AD52B61D143370D89BA6F5730A2E47853277D36E19D545E
              F709510F2C28CD1DBBC20595FACC5B2D60B99E7FAD0DD67C409953DE67E0EF5E
              D895509B8B97F862CB2D71DF0CE8C8187E88B967C7D3FC84C76E885B97D4A4DD
              2FC19A613B56D4399F3F01945A96D4A6DA454F04495775D8F6ACF8E77BA451B3
              0D33CE7A2BE5AB7AE585AB1FA5ACDAD4A2C625776CE9F74775BBA64AD214CE65
              3F5671951B13FF3BF4DF6B1F3F7C92D610A0D1CB0000000049454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 2
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 31
          end
          object btBanFor: TAdvGlowButton
            AlignWithMargins = True
            Left = 163
            Top = 1
            Width = 143
            Height = 34
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Dados Financeiros'
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
              485973000000600000006000F06B42CF0000000774494D4507E708110E220F22
              D38C1A000000E64944415428CF55CF314E02611005E02F828BBD873001F40036
              104B3BCF80B1F10096C64A1B8904A29527B0D728CA016C814213626B63039428
              16ECCE2EF33733EFBD796F7EB2DAD53132373772A36EAD2A6EFD5A16DE424F92
              D383209E3C46FF9649EE0A7B07F64C62EEAEB233F3899DD4F33E166A652D1B29
              7CE1C399A677CD142969310EC3439C9AAF1D3B641AC38B2D6CBBF417D8B42858
              FA74A282ABA260BC66B934C07E1E51D6574D4F3AF7A5614020F4A95BA4EA6325
              D0F01DDFAC422F0C7F541D15E23A2B9BC46B400F9EA3EFDBCC9212DD08CACC3B
              39BDAA9AB6A19999A1EBFCCC7F1A69989D593D86AA0000000049454E44AE4260
              82}
            Rounded = False
            TabOrder = 3
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 29
          end
          object btObsFor: TAdvGlowButton
            AlignWithMargins = True
            Left = 576
            Top = 1
            Width = 113
            Height = 34
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Observa'#231#245'es'
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
              89504E470D0A1A0A0000000D49484452000000180000001810040000001AEE29
              30000000206348524D00007A26000080840000FA00000080E8000075300000EA
              6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
              485973000000600000006000F06B42CF0000000774494D4507E70807150C1E26
              65E116000002294944415448C7636018050400232E09FBFF2C2C7CA6D6D6FF43
              9494FE1F6665C5A6E67FFCAF5FCC5DF7EF7F3A7DF4E841C63F7F88B6C07389A7
              2753F18C190C2672724439B3F2C10386CF19195B3D77EE246881E7124F4FA68E
              CD9B19E49999490A8B877FFF32747B7BA35BC2841E2C4C27A74F27D970060606
              0679666606DE1933ECFFB3B0E0B4803BD8CA8AE19EBC3CC986C340BB8202EF59
              0B0B9C1630442829916D3814FCBBA7A282D302C6856C6C28AA85AE5FFF5FDCD5
              F5BFF1CB170606060686A255AB18FEAF5ECDC0C0C0C070E1F3E7FFC55D5D0C42
              D7AFE3330325BCD0C1FFBD6565DB166FD9E223CDCDFDDF202A6AAB7344040303
              0383D72F575786174B966C932B2FF7293F72E4FFBB4D9B709981D70246F69C1C
              AF93BCBCFF7EFAF9315E1110F0B6AFACFC9FC4C8C8182820C070C6CFCF7BD1D1
              A3FFC4131319AFE0310399E3F5373999D16FCE1C4AE2E0FFA694946DCC73E762
              8D0326B9E7CF29319C8181818171D7932728662273382D0F1DFABFFEC307F28D
              7FFF9E51F4F0619C16AC5EF3E50BC3E3EA6AB283C7A5B2728BC9B76FC8621839
              F6F6A4D3A755EDBF7D6364B6B363F8C9C24294C9FC3F7F326CABACDCB675F264
              8C20C3A5C7BF4856F6CFEFE0608669E9E90C1E1A1A7089D81F3F184E1F3FFEDF
              E3F16306F54F9F982CEFDCF9CBB976EDF63BA8614F34F04E5ABCD8DBFBFF7F6F
              EF77EFBC0E1516BA5EE4E626453F7141D077F32673BC8FCF26BB3B77C872253E
              E0E3A8AFEF7A514C8CEA068F02180000C984BFDDA6C67DCE0000000049454E44
              AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 4
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 31
          end
        end
        object PanelMenCli: TLMDSimplePanel
          Left = 0
          Top = 0
          Width = 1096
          Height = 35
          Align = alClient
          Color = 14674687
          TabOrder = 0
          object btEntregas: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 644
            Top = 2
            Width = 93
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Entregas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
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
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
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
              643D2777273F3E2C94980B0000039849444154484BD5934F685C5514C67FDF9D
              314D53C53A2DD4544843702306A399796F420D14C4628A08151BB0B6C53F85B4
              2E8AE242852EC42C7463505128A95284A2D5BA105C29822218C87B77C6B6625B
              140C63E9C2456CA484D80C99775CCCBCE1651275DD0F2E9C77CE77BF73CF9F07
              373B941AA552E9A073EEF4EA30C4712C80D1D1D13BEAF5FA3133B37ABDFEDE85
              0B17FEEAE4AE07D7369C9B31B331333B001C035E33B377D378BD5E3F0BBC2E69
              B2ABABEBB3B6C2FFA05D418A72B95CEC702D455174390882EB926E0330B3EBDE
              FBDB3B78EBA25D410A33AB749C4B00923ECDD0CE64ECFFC49A0AD6C3F8F8786E
              6E6E6E83A45D00954AE52BC04AA5D21E497B25FD18C7F174E73D807C6A044170
              1C783C1B74CE1D8AA2E872AD567BC139F792736EB2BBBBFB146034AB3A2CE909
              33AB01EB26C8B6A84F52DAFFAD2DBBA75C2EF74B9A94D46B66D34B4B4B3F8561
              B817C07BBF2F49923E49FDE572B93FA3D5C69A1978EF4BCEB937D26F333B6166
              1B24ED6C6DD716E08B300C678220382A691C984B92245CADD4C49A04592449B2
              071803DE8EA2288AE3F8FDE5E5E501337BD5CC06259D9034050C38E73677DE27
              3BE42008A6254D9859B5D5A21DC045E05EE0A299DD00AADEFB2300C562716B3E
              9FDF01DC6366A7CDEC7760DE7B5FCA26C85670A5250E30DFB2E7CCAC6A663724
              6D97F4ECC8C84801A05AADCE4751544D92E4379A03BF75BDAD5CE3F837944AA5
              C79C735F0287E3383E95FA8320784AD2C734E7F55D2E977B747676F6EF34DE5E
              53C005413025E919A0B39F338B8B8B0F6DDAB469A135D47602609799AD489A92
              F44AA3D13805EC4F83D9193C2DE923E07B33FBA54D90868161E75C5FA3D17853
              D293CEB93B676767AF158BC59E5C2E77053817C7F1EE300C4F00479324092B95
              8A273B034921C0C68D1BC7BCF747D203BC0C3833DB67669F03B72449B297E68F
              F83CB0C5CC3E0058595979ABA5F5485B37353AB6A80D4939E07E33FB616161E1
              E142A1F00E5069341A679C737392B601E7CC2C69D2356C6627D36D5BB545C0AF
              928A92EE6E9D22D063665725ED2C140A0F4AFA50D279E7DC7149DBCCAC0E0C02
              DB253D6066D75A5ACD0766121086E13870D6CC26683EE724300EFC097C9BE5D2
              DC9A4B402F7051D27EE01C703E8EE3DD29675582A1A1A1CD5D5D5D3F4BBAAB25
              70354992C1818181C55AADF69C736E155F52A5D1681C92F462EA33B303DEFB4F
              DA9C36BB85E1E1E1DE7C3E3F41933CEDBDFFA393D3011786E141E03E495F4751
              F44D27E1E6C63FB36D8F2940A5FFA70000000049454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 2
            OnClick = btAbreFormsClick
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 31
          end
          object btSuprir: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 238
            Top = 2
            Width = 114
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Suprimento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
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
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000097048597300000EC300000EC301C76FA864000000206348524D0000
              7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
              C546000003E04944415478DAA4955B681C6514C77FE79BACEBD86CA152B0460D
              226910DB3C24F3CDA6314223B62091DA3EF8283E296A51444BA5950ADA52112A
              5AC10B940A2222F8501A8A60BDD06E89189299CD3E98F5C1D64BAD97565A22B8
              6E36C9EE777C992DD34D9A543D300CCCF79FF33F97FF778EA82A22C21226BDBD
              BD376732998E7ABDDE96CD66CF8D8D8DFD0E3896315545AE461086E11DAAFA2C
              B015B8ADE5F83C70CCF3BC37C7C7C7BFFD57044343436D954AE515E019E0BA65
              82ACABEAA15C2EB7A35028D4962558B76E5DBBEFFB23C07D09E0271179D73977
              7C7676F687952B5736E6E7E73B814DC0E3404FE26BCC18B3656262E2D25204C6
              5A7B04D806A888ECAF56ABFBCAE5F21CC0860D1B6EAFD7EBABE2382E25FF1B6B
              ED76E07520039C52D5CDC562713E4D6052357F22710EF06414452F369D03D4EB
              F5ED22F24E2A4017C7F15B498FEAC04660CF0285A82AEBD7AF6FF77DFF0C7013
              F05E1CC78FB6F4E479E029E046E05311391045D1D74D4C10047B44641FF077A3
              D1E82E954ABF5D9181EFFB5B12E7332272451449C3F703E780E3C090AABE91C6
              E472B9D754F5576085E7790FA7CF9A25DA92BC3F8BA2E87C4B965B81B3711C0F
              C471BCCD18D3053C9206140A859A887C9CC25FB6360011E9565554757411299E
              01EE0F826067AD567B3B51CAA54524392A22CF01772D2070CEAD4994D41A3D8D
              4663BBE7794745E455DFF777876178B85AADBE542E972B69B50023C0821BDBCC
              E02F00634C7B2BA0542A9D056C5F5FDFB0316697AAEEF07D7F23D0AFAACE5ADB
              99CFE7BBD3FF38E76AC562F1AB740F7E49DEDDAD0441106400373939F9491CC7
              F788C84780B5D6AE4D82DAABAA5FA41F11190D8260753A8313AABAC939F720B0
              13D0A68C4564C45A0B705044E654B5079833C65C4CCAE32D3643DADADABCCB19
              88C811C089C8DA20081EBAE2A2887C036C063E57D542D2C41DAD63E16A660026
              2626BE033E4C1C1EECEDEDED68F62F8AA25D22D2A9AA478173CEB93B931BCC35
              130064329917800B4087E779C78320E86C9E455174DE18730C18999C9C3C9352
              0EA9722EBE4CD2D3349FCF0F38E7BE046E002E022FB7B7B71F6E1DC55D5D5DD9
              D3A74FCF2633EC686A86A59534A0AA3F2FD8077D7D7D81316604B8B5392D8093
              22F2A373EECF5AAD76606A6AAA62ADED149122B07A8985F3FEA21BADA7A76755
              369BDD0D3C0D5CDFD2F4D16AB53A3C353555C9E7F3A1AA9E04562C288DC889E9
              E9E961596A270F0E0EE6E6E6E68681BB55F59684EC82887C1045D12955C55AFB
              80888C34259F583C3333736FB95CAEC8352CFDA597BA0861183EA6AA8792CFDF
              7B9E37383E3E7E811635FC2782D4C2DA6BADFDA3BFBF7FED5541FF870090300C
              D7B462FE190091F0DBAAEAAAAFC30000000049454E44AE426082}
            Rounded = False
            Spacing = 1
            TabOrder = 3
            OnClick = btAbreFormsClick
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 31
          end
          object btLancar: TAdvGlowButton
            Tag = 30990
            AlignWithMargins = True
            Left = 504
            Top = 2
            Width = 129
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Lan'#231'amentos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
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
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000031A49
              4441544889B594CD6B5C6514C67F67EE9B9958AC24551B4C8A193FB0B1886DBC
              B9F78660942212B72E06377ED05A0AD2BA7755B13BB12E4BDD7453D08501FF00
              9180E2B4BE77266045850A15877C75654DA68D61E6BDF7B8C84CB999CE4CAAD2
              07CEE23EF7BCCF73CEB9E7BE709F217DDEE580747A7ABAA8AA0FF71331C6AC95
              CBE5D57B3688A2E8509AA6E72B95CAD1300C2F016FED56A9AA9EAF542AA7BB55
              7997B8AA2E88C8C46EA23B2A15391545D1A1BE06BEEF4FA8EA37C0C8BF11CFE0
              404F03DFF7273CCF5B001EFB8FE25D910328954A9EE779178141E0662BBE6FE5
              ECFB3F06FDB688A9A9A9C95C2E77B965BCBB98C89CB5F6EB2C6700666666C69D
              739F74243FA8AA47EF55BC170C80736E082865F8DF54B50EFCD2E58C07DC50D5
              CF819F0706066E369BCDFDC04B9EE7AD7535E8C0D5388E8FEC565918864F88C8
              8BCEB92111596E341A172B95CA5F9D79D24A3E0CFCD8E252E00711D9ECC85D76
              CE9D2C140AC349925C50D5D7D9F90D3755F55CB1583C3B3F3F9FF4EB2007CCA8
              6A96D3344D670B85C2B073EE0AF0648B6F02D780E7803D2272A656AB3D0BBC01
              685BAC1375E023E0837688C8BBD56AB59C24C9858C38C097E3E3E34780950C57
              0A82E044BF115D37C6BC92CBE536EEB4694C7D6B6BEB409AA6BF67C6521391E7
              ADB51B5114F9AA5ACD985C8BE378A257074F39E7FE68341A7FB6A35EAF3FADAA
              B3EC9C796CADDD08C3F06DE07887C6C1288A467A19DC0563CC2D551DEAA0E782
              20782D8EE34B49927CC1F672DC81736EB897C175634C319FCFEF6B87B5761558
              CE26A9EA2D116984613857AD56AF00B733AF1363CC2A74DFA2FDCEB963C0DF6D
              220CC3CB49922C789EB709EC81ED3F5D446E586B7F0D82E03D606F46E33B6BED
              462F83BDC0871DDCD5C5C5C5178220382722675ADC43AAFA99EFFB6F8AC8A7D9
              EA3339DB2332C6ACD1DADB1E381C86E1C962B1781698CFF0B39EE7D58007DAE2
              AAFABEB5B67D13E3012C2D2DDD1E1B1B037899DE37ECABEBEBEB711CC71F8F8E
              8EAE88C833C0236D61E05B1179278EE3AFB28776884D4E4E3E9ACFE71FEFD349
              D35AFB53FB218AA211E7DCF0E0E0E04AB95CAEF73977FFF00FE6F13183D52757
              690000000049454E44AE426082}
            Rounded = False
            TabOrder = 4
            OnClick = btAbreFormsClick
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 34
          end
          object btSangria: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 136
            Top = 2
            Width = 91
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Sangria'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
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
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000097048597300000EC300000EC301C76FA864000000206348524D0000
              7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
              C546000003D04944415478DAAC965D681C5518869F6F36EB763529A82D6AA3B9
              102262C845B26736AC31B8FE146BFC2BF4C29BDE89148A6225562AA2A26810EA
              2F2842AF44C42BA56BEB8578615305C3EECC6CD0667B51A3B53FD4045222644C
              36D9DDF379E16C9D6C923660070E33E7CC99F79DF37EDF79BF83AA72952E715D
              F7E6D641E76AA1BBAEFBBAAAFE323030D0BD8255551191FF0BFEB4AA1E8ABABF
              251289C162B138734582C1C1C18EE5E5E561E06E55ED0436013322F299E779C7
              551563CC23225200DA629FFA8B8B8BF7552A95704D82DEDEDEEB53A9D44BC0B3
              11E87F4B16F97161616178727232CC66B3AEAA1E03AE5B151091EFE7E6E68657
              11F4F7F7671CC72900B7464321704C444E5B6BFFAA56AB0727272743634C9788
              04C096F5A453D54F5704399BCDE61CC7F921029F05F6B5B7B76FF57DFFF14422
              F1BE88142A954AD8DDDD9D0A82E0BCE7795B81C25AE0D6DA9CB5F6E54BBAE572
              B9CE5AAD7618B81638A1AA8F064170B6F9BE5EAFEF15912120373535B514C39A
              5F8B20994C9E2E168B3397086AB5DA28701370A1D168EC2897CB1744847C3EDF
              1686E18BC06E55BDC1187358440E7A9EF75353EECB65585B24CD1DD6DADD916E
              FB2626262E34278461380AEC074A51CBABEA3660602329DC1681EE021C55FD35
              08822F5BE63C019CF17D3F07D86C367BA3B576CB46F74893E07E00C7718E00AD
              DE3105ECC86432FBABD5EAC7A552E9227031968E8DB5ECA65EAF37E256D14CC9
              53AD131B8DC65EE06711793B9D4E9F775DF79D9E9E9EF658B6BC2A22DBE34D55
              878220988DAFA04344B0D686AD041313136700D3DFDF3FEC38CE01551D49A7D3
              F70203226281B3AA7A763D899C489AE9A8BFCA0D33994C12B0E572F91BDFF7EF
              11912F00638CE98EC9843166A7EBBAEABAEE9C88D06CCD159C0232519EBFB772
              C74BC11803F081882CAB6A2FB0EC38CE6C8B350C458F27D7B2EBA3D1FDA1564F
              179113C076E03B551D03EE0246A2600390CFE737A9EA9351F7EB55048B8B8B47
              811920ADAA6FC6EDC4F3BC0322D2A5AA878173D6DA3B7DDFFF280E323F3FFF82
              8874027F371A8DCF5711542A955044DE88C69E32C6EC894FF23C6F3A4AE142B9
              5C9E8A64857F83F1B088BC168DBD1BDFA4ADF5C031C67C05EC045444DE2A954A
              AF5CA1D03C13C52C091C57D5ED4110D4D6AD683D3D3DEDE974BA003C10FDD11F
              22F289B5F6DBA5A5A5DF376FDEDCA8D56A5DC083C01EA037C219771CE7B1785C
              D62D9991B98D02CF01D75CC109EAAA7AA8A3A363646C6CACBAE64960BD92E9BA
              EEEDAAFA7CE445B7B5BC9E068E2412890F8BC5E2C9CB1E353650F4A5AFAFEF96
              6432B9AD5EAFB7A552A973E3E3E37F02762366F7CF00D72CC368709AF8350000
              000049454E44AE426082}
            Rounded = False
            TabOrder = 1
            OnClick = btAbreFormsClick
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 34
          end
          object btReceber: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 363
            Top = 2
            Width = 130
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Recebimentos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
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
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000031049
              4441544889BD9441685C6510C77F33EF95AE2F6263B454C92585804A250DAEFB
              76577291A282073D14C483152D588414455AEDCD83DE14B4EA45024A2C82172F
              B5A0602F4102BBFB76534835602422C1448BD65562B209BBBE6F3C7477FB7CAD
              713705E736DF7FE6FF9F99EF9B0F766EDA4B90F4C398CFE79F048E9B590EF081
              45333BE3FBFE3BA55269F34604349FCF7F6066CFB4FD79335B1291C300667641
              441E8EA2E8B76B127B610FC3F044875C4422E009553D2A22D3EDB3FB80333BEA
              60747474F7D0D0D025601040550B661638E7469D73D39EE75D066EE960E572B9
              D25707838383F777C8019C73778AC82511794155DF066EEE60711C3F94CEFF4F
              01DFF76F4B1D4D99D91D41101445645F924355F7F62DE09CFB29E99BD94766F6
              D6E6E6E6F341101C011A096CA56F81288A2E003F26AA3C6F664F01175BADD62E
              AEDEA373CE7DD6B700E044E49544951F7A9EB75755175AADD697C04D6D68AA56
              AB2DA693BD1E04585D5DFD667878B8011C02F698D921337B1428B4433EADD7EB
              C7EAF57A9CCEED6B93C3303C282293CEB98288F8C0B7AA3A5D2E97AF194D5F02
              F97C7E9F73EE5E55FD637D7DFDEB85858566AF456D2B3036363690C964DE059E
              E6CADF03F083736EB256AB7DB14D410FC671BC51ABD5223F0D866178300882C5
              99999966269339CB95B9276DBFAA7E1E8661C7FF258EE30373737397B3D96CE0
              FBFE69337B4E55CB40D14F10EF37B33781C38D46E3BD62B1782A8EE3BBAE53E0
              AF22329FF057B6B6B6D672B9DCB8AA7E62667703DFABEA6477446118BE0CBC06
              64DA497F99D938302E221FA704DE88A2E854C7C966B37B3CCF3B06BC0EEC6EC7
              4F562A95B5AE402E973B2B228F2559CCEC7CB55A7D240CC359E081EB7492B63F
              81E35114FDE357158042A1708F736E1ED8950455F5F1388E7F169132DB2FE5AC
              E779CF964AA5A534D07D45B95CEEB488BC98C2973636360E0C0C0C9C04C6531D
              C6C00A70AE5AAD7EF56FCA5D818989895B9BCDE677C0ED29A223D56A357D0F3D
              5BB7EDD9D9D9DFCDECD5041603EF3BE7CEED941CAE2E0F0023232353CBCBCB47
              81351179A952A95CBC11F2FFC5FE065D4D3602B23A13890000000049454E44AE
              426082}
            Rounded = False
            Spacing = 1
            TabOrder = 5
            OnClick = btAbreFormsClick
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 31
          end
          object btPendente: TAdvGlowButton
            AlignWithMargins = True
            Left = 9
            Top = 2
            Width = 116
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 9
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Pend'#234'ncias'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
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
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000021349
              4441544889B554CF6B134114FEDE6677D2604E592A15BC285552F0228BB6C5CB
              4076E7588A073D88974ABD080AE2D95E443D58F0EC9F600BCA22246143D8BBD0
              9C3C48C08B28526F2A5188B3CFCB06B7E9667F10FD606178F3FD9879333BC07F
              0615253A8E63D9B67D496BCD5AEBB76118FEFE67014AA90BCCEC033813973E18
              86B1D1ED76DFE5698D3C82E3381633EF25CC01E06C1445FB8EE3587307341A8D
              DB009A29534DDBB6B7F3F4992D9252D6851043665E9A41F96A9AE672BBDDFE36
              CB23730742880753E63AFE2658D45ADFCFF298B90329E59265594300F5B87408
              E0A2D69A2A95CA00C0625CFF311E8FCF8561F8A5D40E2CCBDA499803C0200882
              CFFD7EFF138041A25E8FB9A9480D68B55AE701DC4AD6888813E3684AB2EDBAEE
              4AE100C3309E02C8BD82095488E851A100A5D42A80CD12E6135CF53CEF4A6E00
              33EFA2C413328567D3DA23014AA94D00C75651026BAEEB6EA40648294D667E9C
              2136678C8F80889E4829CD634421C41633A7DE040060E635CFF314331333AF67
              2C644508B105E00510F74B2975829987004E6508CBE0B056AB2DFBBEFF7DD2A2
              BB05CC7F02B8C6CCD701FCCAE19E1C8D467780F80C98F96681551D0441B0D7EB
              F55E0238C82313D10DE0EF192C140858F53CEF5E3CBE5C80BF900C780520F355
              8CB9CF0B18030088E83510B788881E32F39BA2E202F0ABD5EA0E30F5D729A59A
              51149D9EC7D934CD8F9D4EE7FD3C1EA5F007AE889BFF4AE58A10000000004945
              4E44AE426082}
            Rounded = False
            TabOrder = 0
            OnClick = btAbreFormsClick
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
            Appearance.TextColorChecked = 16641249
            Appearance.TextColorDown = 3191038
            Appearance.TextColorHot = 20985
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 34
          end
          object LMDSimplePanel1: TLMDSimplePanel
            Left = 0
            Top = 32
            Width = 1096
            Height = 3
            Align = alBottom
            Color = 14674687
            TabOrder = 6
            object barselBut: TShape
              Left = 11
              Top = 0
              Width = 107
              Height = 2
              Brush.Color = 6461951
              Pen.Color = 6461951
            end
          end
        end
      end
      object PanelSubCad: TLMDSimplePanel
        Left = 0
        Top = 36
        Width = 1096
        Height = 531
        Margins.Bottom = 2
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Bevel.BorderWidth = 1
        Color = 15855599
        TabOrder = 1
        OnClick = btAbreFormsClick
        object LMDSimplePanel2: TLMDSimplePanel
          Left = 1
          Top = 499
          Width = 1094
          Height = 31
          Align = alBottom
          Color = 14674687
          TabOrder = 0
          object LMDLabel7: TLMDLabel
            AlignWithMargins = True
            Left = 936
            Top = 8
            Width = 45
            Height = 18
            Margins.Left = 8
            Margins.Top = 8
            Margins.Bottom = 2
            Align = alRight
            Alignment = agCenterRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8811110
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'SALDO'
          end
          object LMDLabel1: TLMDLabel
            AlignWithMargins = True
            Left = 770
            Top = 8
            Width = 46
            Height = 18
            Margins.Left = 8
            Margins.Top = 8
            Margins.Bottom = 2
            Align = alRight
            Alignment = agCenterRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8811110
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'SA'#205'DAS'
          end
          object LMDLabel3: TLMDLabel
            AlignWithMargins = True
            Left = 584
            Top = 8
            Width = 66
            Height = 18
            Margins.Left = 8
            Margins.Top = 8
            Margins.Bottom = 2
            Align = alRight
            Alignment = agCenterRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8811110
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'ENTRADAS'
          end
          object LMDLabel4: TLMDLabel
            AlignWithMargins = True
            Left = 393
            Top = 8
            Width = 69
            Height = 18
            Margins.Left = 8
            Margins.Top = 8
            Margins.Bottom = 2
            Align = alRight
            Alignment = agCenterRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8811110
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'ABERTURA'
          end
          object LMDLabel5: TLMDLabel
            AlignWithMargins = True
            Left = 0
            Top = 8
            Width = 68
            Height = 18
            Margins.Left = 8
            Margins.Top = 8
            Margins.Right = 1
            Margins.Bottom = 2
            Align = alRight
            Alignment = agCenter
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8811110
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'OPERADOR'
          end
          object LMDLabel6: TLMDLabel
            AlignWithMargins = True
            Left = 190
            Top = 8
            Width = 67
            Height = 18
            Margins.Left = 13
            Margins.Top = 8
            Margins.Bottom = 2
            Align = alRight
            Alignment = agCenter
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8811110
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'DATA/HORA'
          end
          object LMDSimplePanel3: TLMDSimplePanel
            Left = 0
            Top = 28
            Width = 1094
            Height = 3
            Align = alBottom
            Color = 14674687
            TabOrder = 0
          end
          object edSaldo: TLMDMaskEdit
            AlignWithMargins = True
            Left = 987
            Top = 5
            Width = 105
            Height = 22
            Margins.Top = 5
            Margins.Right = 2
            Margins.Bottom = 1
            Align = alRight
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 14211288
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            Color = clWhite
            TabOrder = 1
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            Alignment = taRightJustify
            BlankChar = #0
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '-1,1'
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
          object edSaidas: TLMDMaskEdit
            AlignWithMargins = True
            Left = 822
            Top = 5
            Width = 103
            Height = 22
            Margins.Top = 5
            Margins.Bottom = 1
            Align = alRight
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 14211288
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            Color = clWhite
            TabOrder = 2
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            Alignment = taRightJustify
            BlankChar = #0
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '-1,1'
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
          object edEntrada: TLMDMaskEdit
            AlignWithMargins = True
            Left = 656
            Top = 5
            Width = 103
            Height = 22
            Margins.Top = 5
            Margins.Bottom = 1
            Align = alRight
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 14211288
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            Color = clWhite
            TabOrder = 3
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            Alignment = taRightJustify
            BlankChar = #0
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '-1,1'
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
          object edAbre: TLMDMaskEdit
            AlignWithMargins = True
            Left = 468
            Top = 5
            Width = 105
            Height = 22
            Margins.Top = 5
            Margins.Bottom = 1
            Align = alRight
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = 14211288
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            Color = clWhite
            TabOrder = 4
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            Alignment = taRightJustify
            BlankChar = #0
            CurrencySettings.SystemDefaults = cmUser
            CurrencySettings.PositiveFormatStr = ' 1,1'
            CurrencySettings.NegativeFormatStr = '-1,1'
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
          object edOperador: TLMDLabeledEdit
            AlignWithMargins = True
            Left = 70
            Top = 5
            Width = 107
            Height = 22
            Margins.Left = 1
            Margins.Top = 5
            Margins.Right = 0
            Margins.Bottom = 1
            Align = alRight
            Bevel.StyleOuter = bvNormal
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = clLightgray
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            Color = clWhite
            TabOrder = 5
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            Alignment = taCenter
            CustomButtons = <>
            PasswordChar = #0
            ReadOnly = True
            Spelling.LiveSpell = True
            Text = 'MARCELO'
            LabelPosition = lpLeft
            LabelSpacing = -20
            LabelSync = True
            EditLabel.Width = 5
            EditLabel.Height = 22
            EditLabel.AutoSize = False
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = 8811110
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Roboto'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            EditLabel.Caption = '.'
          end
          object edDatAbre: TLMDLabeledEdit
            AlignWithMargins = True
            Left = 264
            Top = 5
            Width = 121
            Height = 22
            Margins.Left = 4
            Margins.Top = 5
            Margins.Right = 0
            Margins.Bottom = 1
            Align = alRight
            Bevel.StyleOuter = bvNormal
            Bevel.WidthInner = 0
            Bevel.WidthOuter = 0
            Bevel.BorderColor = clLightgray
            Bevel.BorderWidth = 1
            Bevel.Mode = bmCustom
            Caret.BlinkRate = 530
            Color = clWhite
            TabOrder = 6
            TabStop = False
            AutoSize = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7039851
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            Alignment = taCenter
            CustomButtons = <>
            PasswordChar = #0
            ReadOnly = True
            Spelling.LiveSpell = True
            Text = '99/99/9999 99:99'
            LabelPosition = lpLeft
            LabelSpacing = -20
            LabelSync = True
            EditLabel.Width = 5
            EditLabel.Height = 22
            EditLabel.AutoSize = False
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = 8811110
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Roboto'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            EditLabel.Caption = '.'
          end
        end
      end
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 986
    Top = 50
  end
end
