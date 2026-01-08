object FrmProcCX: TFrmProcCX
  Left = 470
  Top = 249
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'FINANCEIRO - Processos do Caixa'
  ClientHeight = 619
  ClientWidth = 1095
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
    Width = 1095
    Height = 619
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
    ExplicitWidth = 1098
    ExplicitHeight = 608
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 4
      Top = 6
      Width = 1087
      Height = 31
      Margins.Top = 5
      Align = alTop
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 1090
      object LMDLabel2: TLMDLabel
        Left = 449
        Top = 7
        Width = 188
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'PROCESSOS DOS CAIXAS'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 1062
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
        ExplicitLeft = 1065
      end
    end
    object PanelBack: TLMDSimplePanel
      Left = 1
      Top = 40
      Width = 1093
      Height = 578
      Align = alClient
      Color = 16381943
      TabOrder = 0
      ExplicitWidth = 1096
      ExplicitHeight = 567
      object PanelBase: TLMDSimplePanel
        Left = 0
        Top = 36
        Width = 1093
        Height = 542
        Margins.Bottom = 2
        Align = alClient
        Bevel.StyleInner = bvNormal
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 13948116
        Color = 15855599
        TabOrder = 1
        OnClick = btAbreFormsClick
        ExplicitLeft = 3
        ExplicitTop = 38
      end
      object PnaelBasMenus: TLMDSimplePanel
        Left = 0
        Top = 0
        Width = 1093
        Height = 36
        Align = alTop
        Color = 14674687
        TabOrder = 0
        ExplicitWidth = 1096
        object Shape2: TShape
          Left = 0
          Top = 35
          Width = 1093
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
          Width = 1093
          Height = 35
          Align = alClient
          Color = 14674687
          TabOrder = 1
          Visible = False
          ExplicitWidth = 1096
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
          Width = 1093
          Height = 35
          Align = alClient
          Color = 14674687
          TabOrder = 0
          ExplicitWidth = 1096
          object btCofre: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 190
            Top = 2
            Width = 78
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 2
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Cofre'
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
              89504E470D0A1A0A0000000D4948445200000017000000170806000000E02AD4
              A0000000097048597300000B1300000B1301009A9C180000012349444154789C
              D595BD4E024110C77F52A8ADF8061634CACBD003D5057ABF5AC1CA275082914A
              0B1ADE003FDEC082C477C09216D74CF23F72D9C099CDDE164E32D99BB9DDDF7E
              CCEC2CFC67A90157C0B442BD14972EE01268DBE0773256C0181845E8581C27EE
              06FE013480EB086D88B315DE2AD9E61AF851BBAB4F2B14BE0432E00878509BC9
              1F055F028B3CF25E862DB64C1004CF043A006E81776028DBFCBD1078B310EDB5
              8E00811F8153E00918C85FF762500ACF414E83EEE57B13D8E40C78D5F74B087C
              D7CA875AB14D3029ACFC38045E76E603EDE006D807F6807E6CB67C09E4CB676C
              B638017A0ADEB38EC2ECEF2A2E91ABEA8626AB2DAB1455B193B29ED7800B605E
              F8310B7C79AC7F3ED638E77E3D3A044EA47EA1FA4BAC7F3ED638E9E517400829
              9AA086A8720000000049454E44AE426082}
            Rounded = False
            Spacing = 3
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
          end
          object btPixCon: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 103
            Top = 2
            Width = 79
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 2
            Margins.Right = 8
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'PIX'
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
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000097048597300000B1300000B1301009A9C18000000DC49444154789C
              B595C10A824014458F8BB62AB6ED0F745141DFD25FB8A88DD4AF19B80EC23E24
              75DDCA187803223633D978E1828C6F0EFADE7504BB02200352B9FE4B0970037A
              71296BB31403F7014CBB06D6BE60FD1CE80AA80C30ED4A6A8D0A819D3CE11168
              2740ADDC8BA536FC0653CD7EC8A63790037BA019C01A59CBA5A6973D896BCFAE
              C01678011D7000CEB69E06A3688C5D001B7161A82B754E3387013CC5B6BAD415
              58FF020C7CBFB269289789A19C5C839EF88CCD38D89143B0235BB017F9F41639
              1CB04067C1B454B3551CBC1CB05A2A5B2AB04EBF800FB5ACB456B36A226E0000
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
          end
          object btConfe: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 273
            Top = 2
            Width = 128
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 2
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Confer'#234'ncias'
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
              89504E470D0A1A0A0000000D494844520000001B0000001B08060000008DD4F4
              55000000097048597300000B1300000B1301009A9C18000000F449444154789C
              ED95410A82501086BF689D112DEA0EDDA1455D203A42BB4ED226CAD6D105A265
              BB8E10D505B45585BA4808DA45C5835948A4F9D4A2853F0CC2F8FB3EC61947C8
              952B810C60026C011BF080734478E2537E539E8F2D057AA488910E6C9712B6D1
              81D91A07FBC0EA2567E9C0DC98A03BD0060AC025907774607E4CD854FCBD37D5
              660A3B0115A02E1399196C29E31DCC75C4BB08E9632298EA451168042A988BAF
              1B3134892B1B48BE091C811A50060EDF80A9E8CBBDAA5C671F3E8754B05BA04F
              2D19FB4C606EC821576028AF326A521D1DD83EE5BAB2FE76379ABFDCFA063006
              D69AFFB3B5804A3AB05CB9507A025F89FBEBCFD3A3AE0000000049454E44AE42
              6082}
            Rounded = False
            Spacing = 0
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
            ExplicitLeft = 238
          end
          object btCartao: TAdvGlowButton
            AlignWithMargins = True
            Left = 9
            Top = 2
            Width = 89
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 9
            Margins.Top = 2
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Cart'#245'es'
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
              89504E470D0A1A0A0000000D4948445200000019000000190806000000C4E985
              63000000097048597300000B1300000B1301009A9C18000000FB49444154789C
              ED95BD0E014114853F8D50F20A3A859A824790205E416B1B91780C9D56AF1185
              CA0308F1042AC44F549B48886245728A35B1143B93289CE46473EECCDCAF98CC
              5DF8EBD795064A4033864BEAF3561560070416BC55BF176581932540201F814C
              18D2B00C08E47A18D276046987215E68E1027480963C8E01F1A22013E3BEF22E
              205303527001B9037DA00BF480B90B4860D15E14E4060C8101B0526DA43C539E
              298F9457CA439DFF0A590009D5AB800F249573DAF3FCA2BAAF7DE8DC320A62BE
              933DB006AECA67655FD9573E2B5F95F79FDE49DDD19DD4CCD975B40C3898B30B
              4DCDAD25C0062813A114508CF93F29AACF5F3FAC07EB3B2E0B6B4190ED000000
              0049454E44AE426082}
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
            Appearance.TextColorDisabled = 16641249
          end
          object LMDSimplePanel1: TLMDSimplePanel
            Left = 0
            Top = 32
            Width = 1093
            Height = 3
            Align = alBottom
            Color = 14674687
            TabOrder = 4
            ExplicitWidth = 1096
            object barselBut: TShape
              Left = 9
              Top = 0
              Width = 89
              Height = 2
              Brush.Color = 6461951
              Pen.Color = 6461951
            end
          end
        end
      end
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 986
    Top = 10
  end
end
