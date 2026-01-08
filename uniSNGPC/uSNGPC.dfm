object FrmSNGPC: TFrmSNGPC
  Left = 470
  Top = 249
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'SNGPC'
  ClientHeight = 654
  ClientWidth = 1099
  Color = 16381167
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelCadastro: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 1099
    Height = 654
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
    ExplicitWidth = 1251
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 4
      Top = 6
      Width = 1091
      Height = 31
      Margins.Top = 5
      Align = alTop
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 1243
      object LMDLabel2: TLMDLabel
        Left = 483
        Top = 7
        Width = 125
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'SNGPC - ANVISA'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 1066
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
        Appearance.BorderColor = 16119285
        Appearance.BorderColorHot = 16119285
        Appearance.BorderColorCheckedHot = 16119285
        Appearance.BorderColorDown = 16119285
        Appearance.BorderColorChecked = 16119285
        Appearance.BorderColorDisabled = 16119285
        Appearance.BorderColorFocused = 16119285
        Appearance.Color = 16119285
        Appearance.ColorTo = 16119285
        Appearance.ColorChecked = 16119285
        Appearance.ColorCheckedTo = 16119285
        Appearance.ColorDisabled = 16119285
        Appearance.ColorDisabledTo = 16119285
        Appearance.ColorDown = 16119285
        Appearance.ColorDownTo = 16119285
        Appearance.ColorHot = 16119285
        Appearance.ColorHotTo = 16119285
        Appearance.ColorMirror = 16119285
        Appearance.ColorMirrorTo = 16119285
        Appearance.ColorMirrorHot = 16119285
        Appearance.ColorMirrorHotTo = 16119285
        Appearance.ColorMirrorDown = 16119285
        Appearance.ColorMirrorDownTo = 16119285
        Appearance.ColorMirrorChecked = 16119285
        Appearance.ColorMirrorCheckedTo = 16119285
        Appearance.ColorMirrorDisabled = 16119285
        Appearance.ColorMirrorDisabledTo = 16119285
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3750459
        Appearance.TextColorDown = 2303013
        Appearance.TextColorHot = 2303013
        Appearance.TextColorDisabled = 13948116
        ExplicitLeft = 1218
      end
    end
    object PanelDadCom: TLMDSimplePanel
      Left = 1
      Top = 40
      Width = 1097
      Height = 613
      Align = alClient
      Color = 16381943
      TabOrder = 0
      ExplicitWidth = 1249
      object PnaelBasMenus: TLMDSimplePanel
        Left = 0
        Top = 0
        Width = 1097
        Height = 32
        Align = alTop
        Color = 14674687
        TabOrder = 0
        ExplicitWidth = 1249
        object Shape2: TShape
          Left = 0
          Top = 31
          Width = 1097
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
          Width = 1097
          Height = 31
          Align = alClient
          Color = 14674687
          TabOrder = 1
          Visible = False
          ExplicitWidth = 1249
          object btConFor: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 5
            Top = 1
            Width = 152
            Height = 30
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
            Height = 30
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
            Height = 30
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
            Height = 30
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
            Height = 30
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
        object PanelMen: TLMDSimplePanel
          Left = 0
          Top = 0
          Width = 1097
          Height = 31
          Align = alClient
          Color = 14674687
          TabOrder = 0
          ExplicitWidth = 1249
          object btMapas: TAdvGlowButton
            AlignWithMargins = True
            Left = 464
            Top = 1
            Width = 68
            Height = 27
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Mapas'
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000012649
              444154388D8D92314B03411484BF39CE23453A11C4326063D046B8EBC52A1616
              F6F90362A9A5ADC4526CADECFC09F61202A6D0562B110B05C14AB8908C8517B9
              5C6E83AFD9F776E77DCCC08AA2B22C3B9C4C265B846B14C7F171BFDFFF2E5FC6
              A5BE2B295D0020CFF373E02504C0F69BA4BB625C02F6012D8246E541D23B3004
              86B687C0A8BA90A6E9539665D72107134953D808382D9E36806ED1B780CF5A80
              A43560BBC6692B1421AECC8F927A5591EDDD00780EB063FBA646B7FC5F07B7B6
              8FAA22497BC0C57F001D499DD2FC0C7C012B210751E801C0F615D00BC4AA7530
              5392CE8A33A829035E81F505BC9CDF8F3543FB030C0683038076BB9D349BCDCD
              EAB66D45517412044CABD168ACDABEAFB35017650E9024C9C7783CBEB49D84B2
              D87E98F63F5D9756B79C4F410A0000000049454E44AE426082}
            Rounded = False
            Spacing = 1
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
            Appearance.TextColorDisabled = clSilver
            ExplicitHeight = 26
          end
          object btEnvia: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 538
            Top = 1
            Width = 102
            Height = 27
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Transmiss'#227'o'
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000015149
              444154388D9D533D4B0341149CB797188B145A5869216821DAD88A5EF68285D8
              082209A820E27FF02F8858FA1B24212216C13EBBDA09292C043BD35BE6C02261
              C7E60CCBE5CCA953BD8F99F7E6B1ACE01F88A2A840322C954ACFF2079D542A95
              0DA5D411C93A803992DBB903C2305C0D82A04EF218C0B2D7FA88E378BEF083C5
              05E7DC01809A886C921CB72372DBED7607054F34E39CDB13911AC95D11092639
              73CE350040A2285A24790D6007C054DE4909DEADB54B00A892C2EC04711BC055
              AAD604400050C6989EB536544A6D2564FFE0FB388E0F01ACF86A11698EE2F4BA
              6AB5BA46F21CC074BFDF3F2B97CB3700F63DCA8BB576FD3B197B854EA7F30AE0
              1400B4D6AD9418249B7EAE300122F2992A5129D5FAF5000097009C973F19637A
              BF1E608C7903F0305A4F36D29C3C07504A5D24E1A0582CDEE5F133A1B57ED45A
              B7B37A997F210D1139190E872EABF705E56F72CEC807D5F20000000049454E44
              AE426082}
            Rounded = False
            Spacing = 1
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
            Appearance.TextColorDisabled = clSilver
            ExplicitHeight = 26
          end
          object btCompr: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 180
            Top = 1
            Width = 117
            Height = 27
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Comp./Transf.'
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000021A49
              444154388D8D934F6B534114C57F777813626B4A578A4B69A952692DC4F7A66A
              D12E8A14DD8920BA2982E02710BF89200845C18528285854D08DA809F3D22E6A
              40ECBF9D582CA8C55743308F775DE4556349A1673370EF9C33E79E99117294CB
              E54341101C55D521604844EE79EF3F4451349365D986B5D657ABD5EFEC800044
              51F40298EE6C1863869BCDE67AA150F891975AC02311B9E5BDFFFC771F80885C
              56D57A073F4D9264AD582CF6038F81452000AEAA6ADD3937F19F03E75C5955DF
              02FBF2FA4A1CC7439D8E9C73C3AA7A1B380B6C655976627E7E7EC900A2AA7772
              F21C50019676CEEABDFFD8D3D333053C07F61B63EE024818866744E40DB0090C
              5A6B7FB75AADA9388E9FEC14C99D1C54D515A0648C190F44E45C9EC353EFFDB7
              7C5F5772EEE46B144573C0952CCBA60D7038EF2DEE46EA825ABE0E18F22001DD
              2B5B55B76F4F8C88ACE6C568AF0222723CE7AC4914452769279F04413058A954
              36BA91C230BC5828145E351A8DA2B57615E853D5D3268EE3AA88BC074A699ACE
              4E4E4E06BB9C7AADD56ABDB4D6CE027D2212D76AB58A0148D3F43AB0059C6F34
              1AAFC3303CD645E308700AB80034B22CBB01FF02C43937A1AACF807EDA81D681
              6563CCCD2449BEF4F6F6FEA2FD9C51D5BA3166C27BFFD36C0B78EFDF89C808F0
              80F6C719052E359BCDCD52A934B04DCEC71951D587FF39E8C4D8D858BFB5765C
              440EC4717CDF3937AAAA33C0B2882CA769FA696161611DE00F8AAED5F3B2453B
              5F0000000049454E44AE426082}
            Rounded = False
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
            Appearance.TextColorDisabled = clSilver
            ExplicitHeight = 29
          end
          object btEstoque: TAdvGlowButton
            Tag = 30990
            AlignWithMargins = True
            Left = 377
            Top = 1
            Width = 81
            Height = 27
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Estoque'
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000010149
              444154388DCD923D4EC4301085BF19AD2C5AF60C499A14547002043D62113780
              9613700DB802BB178016247ADAE40ACBF656E2A1B151367F8802895759F33E3F
              6B662CF494E7F90370036066570022F214EDC7AAAA6EBBBCF6034464D9AFCD79
              8B29385EB806648E990D002E7EF0872DFC567F126033FCC01B9BC1BD996D465F
              53FD18041445711A423804A8EB7A9DCE22129C73CF4DD34808E1CCCCB46DDB25
              409665AB18B85B98D98B88A45589AADE99D90AC07B7F19EB1B114144D6C07BFA
              5866664A67CF65593AC07D376CA6914972914992BD1978EF5F81A3B1FE63E0B9
              F7FE6D6F063DE664EA72D40170DC2DFC8F8FB49DF082AA7EAAEA0E0813CCF60B
              D7E45484FF9A67150000000049454E44AE426082}
            Rounded = False
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
            Appearance.TextColorDisabled = clSilver
            ExplicitHeight = 29
          end
          object btVendas: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 102
            Top = 1
            Width = 72
            Height = 27
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Vendas'
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000016F49
              444154388D8D92316B14511485BFF32626042B3B41088BED7616363B03DB89CA
              8A85D8EE16A9C49F90FF62B9686C826861A1ECCC76B2B585206C114C1148212E
              983CDEB1D9099B6146F69687F39DF7EEE18AFF4C51140F6D8F4208B76ACDF6A5
              A4695996DF0142179CE7F908284308FD94D2EF94D2454AE9C2F61FE041EDCBBA
              604953DB63DB9F42087D49B725ED4BDAB77DA7D7EB9D2D97CBF39D263C180C1E
              4B9A02872184BFB64BDBBB4D9FED0970A0261C4238060E25AD6C1F0335FC43D2
              3BDBCF813EC06AB5DA0D5BC26459F6AC2CCBA318E323C0B5BE035014C553E02D
              309674D58401628C7BEBA03DE0FAE75A07FC025E77C100924E8113DB4F805EBD
              425DE2645DD4FB36785DDA3DE0D58674BE582C6200A8AAEAB3A4375D70CB5C02
              13C07589064EB7856DBFA8AAEA236C5CA2ED11F0738B975FCEE7F30FB570E30E
              F23C3F90F415B8DF05575575B229AAE9EA0869855B035A423AE1CE0080E17078
              37C638CEB2ECCB6C36FBD6E5FB07F731AEC7408EC40C0000000049454E44AE42
              6082}
            Rounded = False
            Spacing = 1
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
            Appearance.TextColorDisabled = clSilver
            ExplicitHeight = 26
          end
          object btPerdas: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 303
            Top = 1
            Width = 68
            Height = 27
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Perdas'
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
              61000000097048597300000B1300000B1301009A9C18000000CB49444154789C
              D5923D0AC2401046537805B5B5F20E42D83724A457CC1DBC86E221C4D3582908
              1A2C3C80958DF883D808016541425C774D02360E4CB31FF36666BFF1BC5F8488
              3CCC04E65A03C4A6EB2C02C42F6D5608006E46F10EA819530E0CC0350FD81880
              2D30D51986615B29D501EE0620C9D3C78E310F404B44F6961547192008822670
              B1002622B2B0BC9F7DDFAFBF3901C4406A74595A3AA74AA99ECBCEBE889C5CBF
              0E1C81EED79B88A2A8A1F703D6B9C21530D45A99BBCAE2C3EFAA21FF09108703
              A56155014F7816D68016D34B4B0000000049454E44AE426082}
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
            Appearance.TextColorDisabled = clSilver
            ExplicitHeight = 26
          end
          object btInvent: TAdvGlowButton
            AlignWithMargins = True
            Left = 5
            Top = 1
            Width = 91
            Height = 27
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Inven.In'#237'cio'
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
              444154388DAD913F68145110C67FDFF30EB7BBE6629126826220822208119B7B
              BB488A685084F8AFB012D3581A4979118B54D6B6062CCC2128189413760F0411
              0B49A395A012B430452211CC79C71B0BF78E355CD2E854F398F97EF3CD3CF8C7
              5031F7DE1F95744092DBD6F7254DD357BD471CC7B7819BC0250124493262660F
              81F11D2749E3699ABEF1DECF48BA07606673F2DE47925680D15D9CAE9AD949E7
              DC98992D0325E0F5D6D6565272CE5D36B3D13F40BB3E3434B4D868347E6D27C4
              717CD8CC9672F1A772B97C36CBB29FCECC8EE53D6F373737EFAFADADCD7AEFCF
              15C5131313FB80A74005F80E9C69369BDF001CB037EFDBA8542AA724DD91F428
              49926900EF7DD4E9749E00FB81AEA40B5996BDEBC14BC54921849792DE036366
              B6E8BD5F97740D38911FED469665CDA2E6AFEF6AB55A3F244D025F8148D20BE0
              625EBEDB6EB717E3389EF4DE47030100699A7E36B3D3F9AE00487A5CABD566A3
              285A00969D730B3B0272272B66765CD23C30134298AED7EB41D270BECA70F106
              1B797ED07B5F6AB55ADD1CF201A817B832B34379BEDE0738E79E87106E0123CE
              B94692244B40B7E82884B047D214702477F0AC4F0588E3F8017065D03A036239
              CBB229C0FA37A856AB57CD6C0EF8B88B7055D27CB55A3DDF13FF97F80DCD10B6
              583955A1F90000000049454E44AE426082}
            Rounded = False
            Spacing = 0
            TabOrder = 6
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
            Appearance.TextColorDisabled = clSilver
            ExplicitHeight = 23
          end
          object LMDSimplePanel1: TLMDSimplePanel
            Left = 0
            Top = 28
            Width = 1097
            Height = 3
            Align = alBottom
            Color = 14674687
            TabOrder = 7
            ExplicitWidth = 1249
            object barselBut: TShape
              Left = 11
              Top = 0
              Width = 98
              Height = 2
              Brush.Color = 6461951
              Pen.Color = 6461951
            end
          end
        end
      end
      object PanelSubCad: TLMDSimplePanel
        Left = 0
        Top = 32
        Width = 1097
        Height = 581
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Color = 15855599
        TabOrder = 1
        OnClick = btAbreFormsClick
        ExplicitLeft = 11
        ExplicitTop = 152
      end
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 992
    Top = 14
  end
end
