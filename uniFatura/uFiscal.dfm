object FrmFiscal: TFrmFiscal
  Left = 470
  Top = 249
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'FISCAL'
  ClientHeight = 620
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
  object PanelForm: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 1098
    Height = 620
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
        Left = 518
        Top = 7
        Width = 55
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'FISCAL'
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
      end
    end
    object PanelBack: TLMDSimplePanel
      Left = 1
      Top = 40
      Width = 1096
      Height = 579
      Align = alClient
      Color = 16381943
      TabOrder = 0
      object PanelBase: TLMDSimplePanel
        Left = 0
        Top = 36
        Width = 1096
        Height = 543
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
        object TesteNFC: TButton
          Tag = 65
          Left = 99
          Top = 105
          Width = 162
          Height = 24
          Caption = 'EMITIR NFCe'
          TabOrder = 0
          Visible = False
          OnClick = TesteNFCClick
        end
        object edPedido: TLMDLabeledEdit
          Left = 11
          Top = 75
          Width = 73
          Height = 24
          Caret.BlinkRate = 530
          TabOrder = 1
          Visible = False
          CustomButtons = <>
          PasswordChar = #0
          Spelling.LiveSpell = True
          Text = '141765'
          EditLabel.Width = 48
          EditLabel.Height = 17
          EditLabel.Visible = False
          EditLabel.Caption = 'PEDIDO'
        end
        object Button4: TButton
          Tag = 55
          Left = 99
          Top = 75
          Width = 162
          Height = 24
          Caption = 'EMITIR NFe'
          TabOrder = 2
          Visible = False
          OnClick = TesteNFCClick
        end
        object Memo1: TMemo
          Left = 11
          Top = 216
          Width = 1054
          Height = 289
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Lines.Strings = (
            'Memo1')
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 3
          Visible = False
        end
        object Button2: TButton
          Left = 11
          Top = 186
          Width = 162
          Height = 24
          Caption = 'CERTIFICADOS'
          TabOrder = 4
          Visible = False
          OnClick = Button2Click
        end
      end
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
          object btSpeed: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 248
            Top = 2
            Width = 153
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'SPED / SINTEGRA'
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
              C5460000028D4944415478DAB4954F48545114C6BFEFBD378B9984884A21C8B1
              45992098BDDEBC699218B4DC542B71D322A25549429B56D12202774194E1225A
              B58818DA192D74F120D27957A641448C82A2594852BB22ACE9DED3C6641AE7CF
              53F1C05BDD73CFEFFCB9EF3B1411ECA459D86173008064C3247CDF4F19634E91
              DC0380001645243F3737F7B11980225213E0BA6EC2B6ED9B004600B4D6BA2C22
              8165596361184E6D0A904AA58E009804703862279E6AADAF160A859F4D01E974
              BACB1873474416482ACBB24A5AEB5F000E5A96D56D8C1924790E805D156BBE5C
              2E9F2D168B5F1B02B2D96C4B10043F1AA59BC96492E572F91EC9A1AAA3994422
              311004C1AAE77919DBB697EBCE208A799E778DE4C3CA6A484E8BC85E00C7B4D6
              ADDB02ACCD6B14C0830DBD27DF8561D8E56CE389D3F3BC010083755ED89B0D3F
              9AEFFB6D9BC8BC03C04500676AD2C999EA2133954AAD909C0730DEDEDE3E99CB
              E5743390EBBABB1DC7B92C22370074541C752AA5DEAF035CD73D6ADBF6524589
              CB241F6BADC70B85C2B766A0E1E161BB542A9D07705D447A94526D00641DE0FB
              FE15117952E3EEAA883C23795729F5294AFB7CDF6F0BC370E5BF191863FAEAF4
              B240F25532992C459DCFBFE0EB62070096659DAC25DD22F25C2995534A6D5DAE
              5DD7DD27229D008A24A7AB7CEE7B9E37B2AD7D108BC55A44A44F29753C1E8F5F
              003053E943F291EFFB2FD2E97447B380D96C76575335EDEDEDDD1F8BC5A600F4
              54DDD722F292E414C94563CC6700719287009C10916EDBB66FE7F3F9A5A8FB60
              02C0A528AD109105C771866667673F445A381582D64FF21680FE3A2E5F008C25
              1289892008FE44DE683524FA80D6FAB4887493FC2D22DF01BC564ABD05601A95
              D6287B8A08A27C5B0254641FDB74E035FB3B00BDB74FABCE40A6EF0000000049
              454E44AE426082}
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
          object bNatoPE: TAdvGlowButton
            Tag = 30990
            AlignWithMargins = True
            Left = 558
            Top = 2
            Width = 170
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Natureza Opera'#231#227'o'
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000022D49
              4441544889B595CF6B135110C73FB3FBD8DA4DDBC01EC4E8D1A042A1506B2265
              11D29E04C15B2EEAC183178F4215FF057F9CFD0BEA59B0074F9A0886855741E8
              3985968A975230AD6E5B77B3CF431BDCD666B3A4F47B7B33DFEFCCF0E6BD1938
              63C869C4B55AED5C1886574544A5ED96657582205805CCD0097CDFBF18459106
              2EF5A1BCD55A3FB0864D10C7F1ED8CE000F7A6A6A60A43274892646400452626
              261C35807404333333AE526A01B8658CB99247933B41B95C1EB16DFB8B31661A
              D8054C1E5DEE2BF23CEF21300DBCD45A8F196316F2E854BD5EB7373636EE1863
              2EF48C4992FC2C140AEF9BCDE65E8A7B03208AA2D74002C483821B6362B5BEBE
              FE0A789276880861182E017753E6518062B1B80BA0946A74BBDD1D60BC4FFC4F
              AD566B4701B53E84F9ACEA822068FBBE7F2D8AA29B1CEBA58874B6B6B63E73E8
              E8D707B75AADAEA6CEE78F135AADD60FE05D562143FF83BC501C34EC24845AEB
              CBBD43B55A5D04EEA70987E3A2EF15B5DBED7D053438787E47608CF99855D9EC
              EC6C398AA26FC0D8095A3CCF6B00F34A6BFDB452A9342DCB2AF508BD677A4CB7
              0BD0E97446815F711CCF89C87FC15398F37D7F5C01C9F2F2F25256B587F80A3C
              524A3DABD7EBCFD7D6D6064E011151B9C7F5E4E4A4E3BA6E2022D7F9372ADC2C
              8DE3389E9D37C1E6E666B7542A2D8AC8DE4171E202C52C8D6DDB2F865E38954A
              E5B188BCC9E2388EE30DFD0F2CCBDA1F4031DBDBDB7F4EB3D13E00DF33288B2B
              2B2BBFCF7CE99F267E2EFC0533F2C573ED799D4C0000000049454E44AE426082}
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
            Appearance.TextColorDisabled = 16641249
            ExplicitHeight = 34
          end
          object btNFEven: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 135
            Top = 2
            Width = 102
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Emitir NF'
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
              C5460000021A4944415478DAB496BF6B144114C73F6FE7DCD8A9589E2120A268
              1110618743D06B420AAB042DCE6011D014A2FF8085ADB5208236DA1808579988
              10B0112C327BB7B642C0602158452B9BF1E69ECD2D6C96FBB1B9902F6CF186F7
              DE7CE7FBDEBE1951558E1311C78C1A80B57611780ACC8CF17DEB9C7B911B2232
              31B9AA22AA8AB5B60B5C1BE3EB817810F4ACD3E93CA9C25E550F2F91883C4C92
              E46555796B45C33937F2DCD6DABC1B4E014B4992CCCCCDCDADB5DBED30965045
              897A6532C09E88747ABDDEBD2CCBFE1D55A2DA90B5F3AA7AD518B3D16C364F4E
              2D51419A22EED76AB54FF57AFDE740A2E8A81201FC1591C7AAFA4644E6557519
              B80008F0A3DFEFBFEF76BBE9B46D0A20711C9FF1DEBF026E0F1297B11D4258CD
              B2ECD7D01A38E724FFCAC9BDF7A7BDF75F803B85E41F81F582DFA231C6351A8D
              FAD01A8CD05B00E2387E0D5C2911BA3588BB5B589E0D21BC039A95679188CC0F
              64A98A9BD6DA85CA1BA8EAD208CDC7C52C8FEAEF61B8986B9ECB32AABDADB5EB
              400BB854E504218470425573BF3F15C8EC17AF82492730C69873C0DEC05EB1D6
              AE94998F688EEF556B70238AA2CD29A6EE66A50D44E4C1CECE8E03B60F51E0AF
              CEB9AD4A4556D5EB4992B44208ABC61807CC960ABA5F0AF92D222DA07F983B79
              5D44CE1A631AC0E7C27A0B7854640E34D234DD3DF0278BC8B749AF8B288A9E7B
              EFD7B22C6B5A6B17547549552F8B4804EC8AC887344DB772E607A6E971E2FF00
              42DCE82DAC9C2DA10000000049454E44AE426082}
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
          object btAjuste: TAdvGlowButton
            Tag = 1
            AlignWithMargins = True
            Left = 412
            Top = 2
            Width = 135
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'Ajustes Fiscais'
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
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000036A49
              4441544889BD9541685C6510C77FF3E5255930B1624425D960C112B44214C3BE
              4D580F6B0F8AA7A2CDF6E04144C543C122584B4A110C88225A534404C94DB096
              46AA3D946A415C219BF8BEDD259092689B2839889A88A4A5EE12B3FBDE78E83E
              79FB36B152D4B9CDFC67FE33F37DDFCC07FFB1C87680EBBA3DAA7A50449E040A
              D6DAA763F887401A3801BC67ADFDED1F27705DF759E018B023B4A9EA1B8EE3BC
              BDB9B9691CC71953D59722215754F5E562B13879DD04A9546A42445EDCAEB3BF
              131199F43CEFF96D1364B3D944B55ABD0C74DE4802E06AA552B96D6161613334
              B445D19595957A5F5FDF2EE08158E0651139A3AAA781AF45640D48028958071F
              CCCDCD9D8DDA9C780922F283AA86AA0FBCB6B1B1F1D6FCFC7C25EA97CD66BBAA
              D5EA1870043000AABAD6C21755868686DA8D31DF88C883802F22FB3CCF3B13E2
              B95CAE6D6A6A4A8120B4A5D3E97DAA7A0A30AA7A617D7D3DB5BCBCFC47538274
              3A3DA8AAF7010780871AD8ABD6DAF158F2B3C618711CE78942A17035C452A9D4
              EB2272A4A1CEA8EAA4AA2E954AA5820C0F0FEF0C826099E6FB58F77D3F592E97
              AB00232323B7FABE3F0B0C34F037ADB563A1732693E9AED56A3F0237473802E0
              5EE3FB7E3A460E702E24070882601418109163C073223211756E74F3458CC300
              7B1C11B99D56598AE92B00AA3A0AFC047403C7633E97E22422B2CB6C41DE229E
              E79D57D543C0CF409FAA4EB8AEBB27CE178F0B82C03122F2EB169C035BD83E02
              DE1191138DEAEEBA5E8C88AC19A00C680C7B6C7070F0A6A8C118730838A5AA63
              C0B7F57AFD74886532996EE0D1780255F58CE7794B229232C6EC1591730DEC96
              CECECEC35167C771C681AF80CF7DDFBFBF5C2E5F09B15AAD76946BF702B02022
              CF1863868BC5E297F15DE4542A152F1C3460D45AFB59886F3568AEEBE680935C
              7B35BF747474EC9E9E9E5E0FF1F82E0AFAFBFBEF041E6E04E492C9A4D3D3D363
              5757576B8B8B8B1A1E672693E9EEEDED1D07261ABE009FCECECE7EDCD479FCDC
              8220D829F257636DAAFA4A229178C175DDF3AAFA1D8088ECAED56A8FD03C5800
              77C7F9FEED754D1004F7944AA58BA1DE3407F97C7E0378F746C9814FBABABABE
              8F1A5A06CD5A7B18D80F34AD5E1179DF719C3B4464077094E6A7FD3B70D05ABB
              3F9FCFD79BE2B62BA5B1C00E004F014BD6DAC7A3A48DAF75AFAA9E6C6F6F3F3E
              3333D3F217FC2FF227481C5E630A8378EA0000000049454E44AE426082}
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
          object btNFEmitida: TAdvGlowButton
            AlignWithMargins = True
            Left = 9
            Top = 2
            Width = 115
            Height = 30
            Cursor = crHandPoint
            Margins.Left = 9
            Margins.Top = 2
            Margins.Right = 6
            Margins.Bottom = 0
            Align = alLeft
            AutoSize = True
            BorderStyle = bsNone
            Caption = 'NF Emitidas'
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
              C546000002944944415478DAB4954D68135110C77FB3DD651B22782842A55A6A
              05EB075434219BE8A582552B7E80222278147A2AF5503D09F6268A78160ADEC4
              9B1EAC14113487DA649320DEAC37956AADE0454D6CF3B1E365B7AC69A235B503
              038F79F3FEFF371F6F9EA82AEB2926808800C8C0C0809D4EA71763B198659AE6
              59A0B356AB4D150A85B78D6C00A9542A92C9647E36025755445549A5523D9EE7
              A5814DAA3A6518C61E55DDE9FB5544E421B0376C031E01BB7DBD91CBE5AE3525
              701CE70A706B0D9928E672B90D8D080C7F1D5D63AA9B9E375867319BD8270107
              E8005C1129D6852E401CD8D80AC13BD7754F02388EA3C0816C36BBC2C9719C4B
              C0442B043D8EE33C0192802722D3C964B2511BC6D692A2E3A1741CFCDF355055
              9D1091C34097AA3E1591A5067E0ED0DD0AC17B11190EC844E474B0E1BA6EB806
              C3C0DD966A00BC0282573B072CF9A0BF9D1591CBE572F9A56DDB763C1EEF0BC6
              C76ADEC13E20E2AFBB80DEB08AC87CB55A3DAFAA439665E53DCF9B360C633691
              48CCC6E3F1A1BF119444E402F01C5850D551111956D531E03B305FA954C64CD3
              7C0C1CAD3BDB6718C66422913817188259340E5CF76D9F81CD410D0009017C10
              913BAA3A041CA903F78032D00E7C1591DE6C36FBAD51049D40CD070F4802DD5A
              ABD56680C110E822F043550FA96A105187E779C7FE5483A6334A44DA83A85475
              DCB2ACED2232188D46670CC3180DF96D6B69D855ABD54A08E462B95CF6229148
              A1542A3D50D533A1BD4FE1362DAEFA659A6637F006D805EC10917CB158FC2222
              FB436E4BC08BE5082CCBBA0FBC5E25C7D5B6B6B611BF4E005BEAC0016EBBAE3B
              B7DC45FE9FFC4F924C264F799E77CF1FE9CB3757D59BF97C7EDC1F39AD1300F4
              F7F7476DDB3E21223DAABA609AE6B34C26F371C59FBC9EF26B00C73C10267B55
              D5A10000000049454E44AE426082}
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
            ExplicitHeight = 31
          end
          object LMDSimplePanel1: TLMDSimplePanel
            Left = 0
            Top = 32
            Width = 1096
            Height = 3
            Align = alBottom
            Color = 14674687
            TabOrder = 5
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
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 986
    Top = 10
  end
end
