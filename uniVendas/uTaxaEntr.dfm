object FrmTaxaEntr: TFrmTaxaEntr
  Left = 470
  Top = 249
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'Vendas - Taxas de Entrega'
  ClientHeight = 390
  ClientWidth = 625
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
  OnShow = FormShow
  TextHeight = 14
  object PanelCadastro: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 625
    Height = 390
    Margins.Right = 4
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13948116
    Bevel.BorderWidth = 1
    Color = 16382200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7039851
    Font.Height = -12
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Shape1: TShape
      Left = 1
      Top = 388
      Width = 623
      Height = 1
      Align = alBottom
      Pen.Color = 14211288
      ExplicitTop = 171
      ExplicitWidth = 501
    end
    object LMDLabel6: TLMDLabel
      AlignWithMargins = True
      Left = 406
      Top = 177
      Width = 9
      Height = 17
      Margins.Top = 0
      Margins.Bottom = 2
      Alignment = agCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9863798
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      Options = []
      ParentFont = False
      Caption = 'h'
    end
    object LMDLabel4: TLMDLabel
      Left = 365
      Top = 159
      Width = 52
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'HOR.IN'#205'C.'
    end
    object LMDLabel5: TLMDLabel
      AlignWithMargins = True
      Left = 474
      Top = 178
      Width = 9
      Height = 17
      Margins.Top = 0
      Margins.Bottom = 2
      Alignment = agCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9863798
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      Options = []
      ParentFont = False
      Caption = 'h'
    end
    object LMDLabel7: TLMDLabel
      Left = 436
      Top = 159
      Width = 47
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'HOR.FIM'
    end
    object PanelButtons: TLMDSimplePanel
      Left = 267
      Top = 333
      Width = 320
      Height = 28
      ParentColor = True
      TabOrder = 14
      object btSalvar: TAdvGlowButton
        AlignWithMargins = True
        Left = 220
        Top = 0
        Width = 100
        Height = 28
        Cursor = crHandPoint
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Salvar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
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
          485973000000600000006000F06B42CF0000000774494D4507E70719150F0A25
          04D1D50000017F4944415448C763601805A3801450FF9F89095D8C891C83D041
          EE3665E5AC3BB76EBDE17CF62C779BB232B21C0B350CFF9773E000A3A78C0C43
          3203C3DF2F86860C0C77EF52C50730C3193C6564181818181884B66DFBB37BE3
          46AAF820FDBF82C2BF977BF6C00DF7DEB1E38B6770F042C6DFBF91D561F82097
          D3CC2C779B96162197B3281F3ECCD0ACA0007339134340C042C61F3FD0D5A258
          90B9CCDEFE5FD2C993FF122F5ECCC90E0D253658982C8382267BFDFC894D3D8A
          054C5BFEFF6760606060086161F9BF66D932744B48359C81818181199973FAF2
          C387A62E9F3E31FE747767D0626262700E0A32DF7FE7CEA9AF972FA7FF575060
          E4DBB78FE1999C1C3CCCD3828266A9E1361CC30206060686D3474E9C305DF2E5
          0BE349373786FB4C4C0CD7FDFD4DF3BE7C614E9B3D1B6EB8D0B66D4CB2818184
          0C6760606060C42591555958C8F8A9AF0F43C27BC78E2F9E8181D82294281FA0
          F804165C641A4E14C849CDCFCF7AF3F367F6C9D5AB73B7B1B353CD606480AD10
          1B05A3000E006DFDA65FD6E403700000000049454E44AE426082}
        Rounded = True
        TabOrder = 0
        OnClick = btSalvarClick
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
      end
      object btExcluir: TAdvGlowButton
        AlignWithMargins = True
        Left = 111
        Top = 0
        Width = 100
        Height = 28
        Cursor = crHandPoint
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 6
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5723991
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
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
          485973000000600000006000F06B42CF0000000774494D4507E707191513379B
          1BC099000001DF4944415448C7ED92C14BDB501CC7BF2F31B8BCD246DB9332D8
          6105C18BBB889A0E0423AD4118B2BF6196D557D97AF4B4D3987737E786B7E18E
          22281AA9DE66A0D8EE2E7408C23C0CA4A6264889E6ED3283B8B689DB4DFC1EDF
          EFF73E9FFCF27BC07DEE7CC4568557BCAB6BE0B8B3B3F2BDD1680798DD8CC59E
          4444B15271DD6675A1D961C18CC72F5E54AB52FFE1218B0E0DB582E7E752294F
          3A3A92760E0E0AA62C871600007E4A12AADDDD58DDDECE2587879BC1F9ECD616
          D614855728151785D6AC6661A591113661598C71CE44DBCE7D1D1DBDAAE54E54
          951DD7EB8C71CE8AA7A7EDA6244112BC310C3C8EC5B0E438DE97C949645C5768
          1806DE46A398B22C3CCF643E9C954AFF24F84BF2EDFC1CAF394799D230F05002
          5FA2168B781989000059711C7EA9694170A0DD92AFC54B128265E27F0C7F2408
          5CA734CCDD4041EE4455858661A04C2964DBC692E3E0A92C137D6323FF796CEC
          BF043EFC6AA19FC6C7BD5FE9347ED4EB2853CAA5F5F52089101AFE67A11F13A6
          E9ADE8FA75C98CAB69617E979F6CB6A7C77FE70F6BB5196D70F0664F7E2E95F2
          7B44DBCE3FEBED0D3DC183794982DED18164ADC6FBD2E9C5DDFDFD9B3DEFDFED
          ED91055DC794656199908B4B12EA45FA61A544223BAD2881D34E2B4AC18CC76F
          05BFCFDDCA6FE813D275370C23920000000049454E44AE426082}
        Rounded = True
        TabOrder = 1
        OnClick = btExcluirClick
        Appearance.BorderColor = 2412287
        Appearance.BorderColorHot = 50943
        Appearance.BorderColorCheckedHot = 50175
        Appearance.BorderColorDown = 46826
        Appearance.BorderColorChecked = 50175
        Appearance.BorderColorDisabled = 50175
        Appearance.BorderColorFocused = 50175
        Appearance.Color = 11792127
        Appearance.ColorTo = 50175
        Appearance.ColorChecked = 50175
        Appearance.ColorCheckedTo = 50175
        Appearance.ColorDisabled = 50175
        Appearance.ColorDisabledTo = 50175
        Appearance.ColorDown = 50175
        Appearance.ColorDownTo = 50175
        Appearance.ColorHot = 1887487
        Appearance.ColorHotTo = 1887487
        Appearance.ColorMirror = 50175
        Appearance.ColorMirrorTo = 50175
        Appearance.ColorMirrorHot = 1887487
        Appearance.ColorMirrorHotTo = 1887487
        Appearance.ColorMirrorDown = 50175
        Appearance.ColorMirrorDownTo = 50175
        Appearance.ColorMirrorChecked = 50175
        Appearance.ColorMirrorCheckedTo = 50175
        Appearance.ColorMirrorDisabled = 50175
        Appearance.ColorMirrorDisabledTo = 50175
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
      object btNovo: TAdvGlowButton
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 100
        Height = 28
        Cursor = crHandPoint
        Margins.Top = 0
        Margins.Right = 6
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Novo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
          A9000000206348524D00007A26000080840000FA00000080E8000075300000EA
          6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
          485973000000600000006000F06B42CF0000000774494D4507E70802140117DC
          0BBDFA000000EA4944415438CBC5933B0AC2401445EFC4A4B410ADD3650D621B
          45F103B6EE40C8C82CC12CC14234B8035BC10F8ABDB885D1CE3EB682669E8536
          EA0CA820DEEAC2BB1CDE87C76090885DF712AFD70040996231CA1E0EBA9C6D02
          24AD7A9D799E07006CD7680051A4CB592600368EA3F56F03DED4FF01B6885D37
          1996CB685B8FB085EF637BF703DFE7D5D3E9A13E522A15AC562CD84BC97AB76D
          7FACA39416EB127DDD7F4864AB7EA9644595CAEB08B51AB6CD2600203F99A03A
          9F3F8FA072CBA511CED342704EC439114F0B61CAFDFF8C3F0414CE67AD7F92F1
          1B53E3D92CE948899048E5A65364F5B92B4C674F3CED4A6AC10000000049454E
          44AE426082}
        Rounded = True
        Spacing = 3
        TabOrder = 2
        OnClick = btNovoClick
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
      end
    end
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 615
      Height = 37
      Margins.Left = 5
      Margins.Top = 5
      Margins.Bottom = 0
      Align = alTop
      ParentColor = True
      TabOrder = 16
      object LMDLabel2: TLMDLabel
        AlignWithMargins = True
        Left = 10
        Top = 6
        Width = 135
        Height = 28
        Margins.Left = 10
        Margins.Top = 6
        Align = alLeft
        Alignment = agCenterLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Taxas de Entrega'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 591
        Top = 1
        Width = 24
        Height = 28
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 8
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
    object PanelBckBut: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 43
      Width = 621
      Height = 34
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12572415
      Bevel.BorderWidth = 1
      Color = 14674687
      TabOrder = 15
      object edBusca: TLMDLabeledEdit
        AlignWithMargins = True
        Left = 148
        Top = 7
        Width = 325
        Height = 21
        Hint = 'Busca Filial'
        Margins.Top = 4
        Margins.Bottom = 4
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyDown = edBuscaKeyDown
        Font.Charset = DEFAULT_CHARSET
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
              89504E470D0A1A0A0000000D494844520000001200000014080600000080976D
              4A000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC300000EC301C76FA864000001C44944415478DAD592BD
              CB816114C6AF6751468324B37C44A48430B029038A0C2CFE006236C83FC0C840
              210C762329313019503E2265A0641386F77DEF3328799EB7F76B79CF76779FF3
              3BE75CE7E2DE3E027F10DCFF02CD6633E4723974BB5D5CAF57701C07B7DB8D44
              2201A3D1F835102B0E068390C96454ACD3E930994C301C0EB15C2E51A954E0F7
              FB3F076D361B58AD562A6E369B904AA58F3F3659281442A7D341BFDF87C16010
              06259349D46A352C160B48249297692F970B012C160BE5F1824EA7136C361BEC
              763BCAE5B2A0B8A9540AAD560BBBDD8E1FB4DD6EA1D7EB91C9642859288AC522
              D2E9348EC7233FE876BBC1E17040A954A25EAF0B82E2F138DAED36092FA8513E
              9F47369BC56030805AAD7E819CCF67984C26B85C2E944A256110EB140E874927
              0655A9548FBFF57A4DC7604D7ABD1EB45A2D3F68341A21128960BFDFD35B2C16
              231008D0AAABD58AAEC42EC934F2783CFC3E1A8FC7E4112620F34EA150C0743A
              45A3D1C07C3E8742A180D7EB452C168346A379DAE20162A346A3511C0E077233
              33A2D96CA6A4FBFD4E676693F0F9EA09C40CC6F697CBE5A856ABE4ECEFC403E4
              F3F9A82B13D7E9747E0B2278B59FC4138899512412FD1EF49B7807C22803D414
              9A2D2C0000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edBuscaCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelPosition = lpLeft
        LabelSync = True
        EditLabel.Width = 36
        EditLabel.Height = 21
        EditLabel.AutoSize = False
        EditLabel.Caption = 'Busca'
      end
    end
    object LMDDBLabeledEdit4: TLMDDBLabeledEdit
      Left = 167
      Top = 176
      Width = 70
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 1
      ValidationMsgString = 'o n'#250'mero da ag'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      CharCase = ecUpperCase
      ParentFont = False
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'CEPIni'
      DataSource = SouTaxEnt
      LabelSpacing = 2
      EditLabel.Width = 62
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'CEP INICIAL'
    end
    object LMDDBLabeledEdit1: TLMDDBLabeledEdit
      Left = 123
      Top = 121
      Width = 39
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhitesmoke
      ParentShowHint = False
      ShowHint = False
      TabOrder = 17
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      TabOnEnter = True
      DataSource = SouTaxEnt
      ReadOnly = True
      EditLabel.Width = 42
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'C'#211'DIGO'
    end
    object LMDDBLabeledEdit2: TLMDDBLabeledEdit
      Left = 168
      Top = 121
      Width = 320
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ValidationMsgString = 'o nome da taxa'
      CharCase = ecUpperCase
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'Destax'
      DataSource = SouTaxEnt
      EditLabel.Width = 147
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'NOME DA TAXA DE ENTREGA'
    end
    object LMDSimplePanel3: TLMDSimplePanel
      Left = 40
      Top = 333
      Width = 179
      Height = 28
      Margins.Right = 5
      ParentColor = True
      TabOrder = 18
      object btFiliais: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 0
        Top = 3
        Width = 86
        Height = 22
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Right = 5
        Align = alLeft
        Caption = 'FILIAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5987163
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
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
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001AB49
          4441544889DD94C16A13511486BF73273A8190558A76D137100ABE401B08991B
          DC74A545BAF13D74D93E87BBAEBAE9A234332130B6EA4E04A1F80075A1604007
          A5499B99D3CD4D094332935A2BD8B3B997F9FFFFFC67CE3DF7C2FF1E52460882
          604B4456E6C0A76118EEFEB14110043511F955405155AD4751F47B1EC1141954
          ABD5421C90324E59821BC7AD1B548AC02449CE7CDFFF0C2CBB4F35B74E7AFE35
          4992B3BF568DB576CF5ABB771DCDADB768E698369BCDAAEFFB5F80C6827906A3
          D168258EE3611E9879069EE7D58086AA6E1B633E1565CEB26C55445E39CD6206
          9350D5E36EB71B1571DAEDF64F91F9F7F50AB1D63E025E3AD3FBC00670047C73
          66AFA3283A04E8743A4F54F585933E04D6807DE01C18033B61189EE4FFA0033C
          CF15B0765589C80570E8CCB680A739EEC6D4FE03700277E126FFBBA74255DF1A
          63225535AA7A4F44D6818FC0C0510EA67407C003B76F008F55F58D885C8848A6
          AAC713E2CCF96AB55A8D4AA5F23DCB32DBEBF5CAC63430C684E3F178A9DFEF0F
          F2F8CC16A5699A02789E9716259FE64C340B19C471FC03D81C0E87EFCA0CEAF5
          FA7B1179E63477302E01F93A91127144CE190000000049454E44AE426082}
        Rounded = True
        Spacing = 4
        TabOrder = 0
        OnClick = btFiliaisClick
        Appearance.BorderColor = 7709439
        Appearance.BorderColorHot = 7709439
        Appearance.BorderColorCheckedHot = 7709439
        Appearance.BorderColorDown = 7709439
        Appearance.BorderColorChecked = 7709439
        Appearance.BorderColorDisabled = 7709439
        Appearance.BorderColorFocused = 7709439
        Appearance.Color = 12308991
        Appearance.ColorTo = 12308991
        Appearance.ColorChecked = 12308991
        Appearance.ColorCheckedTo = 12308991
        Appearance.ColorDisabled = 12308991
        Appearance.ColorDisabledTo = 12308991
        Appearance.ColorDown = 12308991
        Appearance.ColorDownTo = 12308991
        Appearance.ColorHot = 12308991
        Appearance.ColorHotTo = 12308991
        Appearance.ColorMirror = 12308991
        Appearance.ColorMirrorTo = 12308991
        Appearance.ColorMirrorHot = 12308991
        Appearance.ColorMirrorHotTo = 12308991
        Appearance.ColorMirrorDown = 12308991
        Appearance.ColorMirrorDownTo = 12308991
        Appearance.ColorMirrorChecked = 12308991
        Appearance.ColorMirrorCheckedTo = 12308991
        Appearance.ColorMirrorDisabled = 12308991
        Appearance.ColorMirrorDisabledTo = 12308991
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
      object btCidades: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 91
        Top = 3
        Width = 86
        Height = 22
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Right = 5
        Align = alLeft
        Caption = 'CIDADES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5987163
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
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
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000018249
          444154388D7D513148C340147DBF57389C6AC738885B0445E82614A18B08C6C4
          C1C549071DD5C95DEBE0E0EC200882934841C85DAB6B449C3A4975286E4E3A09
          29486B6DCEE5528E6BF441E0BFF7DF7FFF1F2158A8542AF942A1B00560532935
          A7E5270097711C5F4451F463FAC9249EE71519631240D90ED678180C06AB8D46
          E3331572661863ECDA1A7ED75F8A05C6D89599380C0882C007B0A8694729B52C
          847084100E1179003ABAB7E4FBFE4AD605EBC353880EA49477290FC3F016C0A1
          D11F7ACD00372D9224B98705A55464D0E9AC80BEB161CA0EB0B4E19F3003DA86
          B9EA795E31E5BA3E32BCAF699137C410C0863E779631F61C04C18DEEAD01708C
          05F59100CE79BDD7EBBD0198D4D204801DFB29003E922491234FA8D56ADF4474
          9C3160E3444AF935120000A552E91CC0E33FC32DCEF9A92990EDF07D7F86889A
          00C6AC565F29559652364D31679920A57C21A2ED8CED7BF63000B0AC3BDBED76
          CB75DD7100F35A3A134254B3BCF92C110038E7FBDD6ED721A25C1CC7BB7FF97E
          0110CA767E97B7498A0000000049454E44AE426082}
        Rounded = True
        Spacing = 4
        TabOrder = 1
        OnClick = btCidadesClick
        Appearance.BorderColor = 7709439
        Appearance.BorderColorHot = 7709439
        Appearance.BorderColorCheckedHot = 7709439
        Appearance.BorderColorDown = 7709439
        Appearance.BorderColorChecked = 7709439
        Appearance.BorderColorDisabled = 7709439
        Appearance.BorderColorFocused = 7709439
        Appearance.Color = 12308991
        Appearance.ColorTo = 12308991
        Appearance.ColorChecked = 12308991
        Appearance.ColorCheckedTo = 12308991
        Appearance.ColorDisabled = 12308991
        Appearance.ColorDisabledTo = 12308991
        Appearance.ColorDown = 12308991
        Appearance.ColorDownTo = 12308991
        Appearance.ColorHot = 12308991
        Appearance.ColorHotTo = 12308991
        Appearance.ColorMirror = 12308991
        Appearance.ColorMirrorTo = 12308991
        Appearance.ColorMirrorHot = 12308991
        Appearance.ColorMirrorHotTo = 12308991
        Appearance.ColorMirrorDown = 12308991
        Appearance.ColorMirrorDownTo = 12308991
        Appearance.ColorMirrorChecked = 12308991
        Appearance.ColorMirrorCheckedTo = 12308991
        Appearance.ColorMirrorDisabled = 12308991
        Appearance.ColorMirrorDisabledTo = 12308991
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
    object LMDDBLabeledEdit6: TLMDDBLabeledEdit
      Left = 250
      Top = 177
      Width = 70
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 2
      ValidationMsgString = 'o n'#250'mero da ag'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      CharCase = ecUpperCase
      ParentFont = False
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'CEPFIn'
      DataSource = SouTaxEnt
      LabelSpacing = 2
      EditLabel.Width = 55
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'CEP FINAL'
    end
    object edHorini: TLMDMaskEdit
      Left = 367
      Top = 176
      Width = 36
      Height = 22
      Margins.Left = 2
      Margins.Right = 0
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      Mask = 'HH:mm'
      MaskType = meTime
      TimeSettings.FormatStr = 'HH:mm'
      TimeSettings.Format = tfCustom
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object edHorfin: TLMDMaskEdit
      Left = 436
      Top = 176
      Width = 36
      Height = 22
      Margins.Left = 2
      Margins.Right = 0
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
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
      Alignment = taCenter
      CustomButtons = <>
      Mask = 'HH:mm'
      MaskType = meTime
      TimeSettings.FormatStr = 'HH:mm'
      TimeSettings.Format = tfCustom
      TimeSettings.AMSign = 'am'
      TimeSettings.PMSign = 'pm'
      TimeSettings.MSign = 'm'
      Value = 0.000000000000000000
    end
    object LMDDBLabeledEdit3: TLMDDBLabeledEdit
      Left = 167
      Top = 231
      Width = 70
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 5
      ValidationMsgString = 'o n'#250'mero da ag'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      CharCase = ecUpperCase
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'VlrIni'
      DataSource = SouTaxEnt
      LabelSpacing = 2
      EditLabel.Width = 77
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'VALOR INICIAL'
    end
    object LMDDBLabeledEdit5: TLMDDBLabeledEdit
      Left = 250
      Top = 231
      Width = 70
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      CharCase = ecUpperCase
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'VlrFin'
      DataSource = SouTaxEnt
      LabelSpacing = 2
      EditLabel.Width = 70
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'VALOR FINAL'
    end
    object LMDDBLabeledEdit7: TLMDDBLabeledEdit
      Left = 401
      Top = 231
      Width = 84
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 7
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      CharCase = ecUpperCase
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'VlrTaxEnt'
      DataSource = SouTaxEnt
      LabelSpacing = 2
      EditLabel.Width = 87
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'VALOR ENTREGA'
    end
    object LMDDBCheckBox1: TLMDDBCheckBox
      Left = 166
      Top = 266
      Width = 50
      Height = 19
      Caption = 'PIX'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      TabOrder = 8
      DataField = 'PagPIX'
      DataSource = SouTaxEnt
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object LMDDBCheckBox2: TLMDDBCheckBox
      Left = 284
      Top = 266
      Width = 77
      Height = 19
      Caption = 'CR'#201'DITO'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      TabOrder = 9
      DataField = 'PagCre'
      DataSource = SouTaxEnt
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object LMDDBCheckBox3: TLMDDBCheckBox
      Left = 420
      Top = 266
      Width = 67
      Height = 19
      Caption = 'D'#201'BITO'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      TabOrder = 10
      DataField = 'PagDeb'
      DataSource = SouTaxEnt
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object LMDDBCheckBox4: TLMDDBCheckBox
      Left = 166
      Top = 295
      Width = 78
      Height = 19
      Caption = #192' PRAZO'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      TabOrder = 11
      DataField = 'PagPra'
      DataSource = SouTaxEnt
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object LMDDBCheckBox5: TLMDDBCheckBox
      Left = 284
      Top = 295
      Width = 80
      Height = 19
      Caption = 'DINHEIRO'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      TabOrder = 12
      DataField = 'PagDin'
      DataSource = SouTaxEnt
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object LMDDBCheckBox6: TLMDDBCheckBox
      Left = 420
      Top = 295
      Width = 72
      Height = 19
      Caption = 'CHEQUE'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      TabOrder = 13
      DataField = 'PagChe'
      DataSource = SouTaxEnt
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 26
    Top = 252
  end
  object SouTaxEnt: TDataSource
    DataSet = TabTaxEnt
    Left = 29
    Top = 182
  end
  object TabTaxEnt: TRESTDWClientSQL
    Active = False
    AfterInsert = TabTaxEntAfterInsert
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
    MasterCascadeDelete = False
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT * FROM arqtaxaent')
    UpdateTableName = 'arqtaxaent'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 29
    Top = 111
    object TabTaxEntIDTaxEnt: TFDAutoIncField
      FieldName = 'IDTaxEnt'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TabTaxEntDestax: TWideStringField
      FieldName = 'Destax'
      Size = 35
    end
    object TabTaxEntCEPIni: TWideStringField
      FieldName = 'CEPIni'
      Size = 8
    end
    object TabTaxEntCEPFIn: TWideStringField
      FieldName = 'CEPFIn'
      Size = 8
    end
    object TabTaxEntHorIni: TTimeField
      FieldName = 'HorIni'
      EditMask = '!90:00;1;_'
    end
    object TabTaxEntHorFin: TTimeField
      FieldName = 'HorFin'
      EditMask = '!90:00;1;_'
    end
    object TabTaxEntVlrIni: TFloatField
      FieldName = 'VlrIni'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTaxEntVlrFin: TFloatField
      FieldName = 'VlrFin'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTaxEntVlrTaxEnt: TFloatField
      FieldName = 'VlrTaxEnt'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTaxEntPagPIX: TWideStringField
      FieldName = 'PagPIX'
      Size = 1
    end
    object TabTaxEntPagCre: TWideStringField
      FieldName = 'PagCre'
      Size = 1
    end
    object TabTaxEntPagDeb: TWideStringField
      FieldName = 'PagDeb'
      Size = 1
    end
    object TabTaxEntPagDin: TWideStringField
      FieldName = 'PagDin'
      Size = 1
    end
    object TabTaxEntPagPra: TWideStringField
      FieldName = 'PagPra'
      Size = 1
    end
    object TabTaxEntPagChe: TWideStringField
      FieldName = 'PagChe'
      Size = 1
    end
  end
end
