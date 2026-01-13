object FrmPlaCon: TFrmPlaCon
  Left = 470
  Top = 249
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'Financeiro - Pano de Contas'
  ClientHeight = 709
  ClientWidth = 743
  Color = clWhite
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -14
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 115
  TextHeight = 17
  object PanelCadastro: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 743
    Height = 709
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 5
    Margins.Bottom = 4
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13948116
    Bevel.BorderWidth = 1
    Color = 16382200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7039851
    Font.Height = -16
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Shape1: TShape
      Left = 1
      Top = 216
      Width = 741
      Height = 1
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      Pen.Color = 14211288
      ExplicitTop = 218
    end
    object PanelButtons: TLMDSimplePanel
      Left = 219
      Top = 173
      Width = 384
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ParentColor = True
      TabOrder = 3
      object btSalvar: TAdvGlowButton
        AlignWithMargins = True
        Left = 265
        Top = 0
        Width = 119
        Height = 33
        Cursor = crHandPoint
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Salvar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -16
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
        Left = 134
        Top = 0
        Width = 120
        Height = 33
        Cursor = crHandPoint
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 7
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5723991
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -16
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
        Left = 6
        Top = 0
        Width = 119
        Height = 33
        Cursor = crHandPoint
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 7
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Novo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -16
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
      Left = 7
      Top = 4
      Width = 731
      Height = 45
      Margins.Left = 6
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alTop
      ParentColor = True
      TabOrder = 4
      object LMDLabel2: TLMDLabel
        AlignWithMargins = True
        Left = 12
        Top = 7
        Width = 143
        Height = 34
        Margins.Left = 12
        Margins.Top = 7
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Alignment = agCenterLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -19
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Pano de Contas'
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 702
        Top = 1
        Width = 29
        Height = 34
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 10
        Align = alRight
        AntiAlias = aaAntiAlias
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
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
        NotesFont.Height = -16
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
    object LMDDBLabeledEdit1: TLMDDBLabeledEdit
      Left = 80
      Top = 129
      Width = 93
      Height = 28
      Hint = 'N'#250'mero documento'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      OnEnter = LMDDBLabeledEdit1Enter
      OnExit = LMDDBLabeledEdit1Exit
      ValidationMsgString = 'o c'#243'digo da conta'
      CustomButtons = <>
      CustomButtonWidth = 19
      TabOnEnter = True
      DataField = 'Codcon'
      DataSource = SouPlco
      EditLabel.Width = 50
      EditLabel.Height = 17
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'C'#211'DIGO'
    end
    object LMDDBLabeledEdit2: TLMDDBLabeledEdit
      Left = 180
      Top = 129
      Width = 423
      Height = 28
      Hint = 'Parcela / Desdobramento'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnExit = LMDDBLabeledEdit2Exit
      ValidationMsgString = 'a descri'#231#227'o da conta'
      CharCase = ecUpperCase
      CustomButtons = <>
      CustomButtonWidth = 19
      TabOnEnter = True
      DataField = 'Nomcon'
      DataSource = SouPlco
      EditLabel.Width = 135
      EditLabel.Height = 17
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'DESCRI'#199#195'O DA CONTA'
    end
    object LMDDBLabeledEdit0: TLMDDBLabeledEdit
      Left = 17
      Top = 129
      Width = 54
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = 15397119
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -16
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      CustomButtonWidth = 19
      DataField = 'IDCon'
      DataSource = SouPlco
      ReadOnly = True
      OnDataChange = LMDDBLabeledEdit0DataChange
      EditLabel.Width = 15
      EditLabel.Height = 17
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'ID'
    end
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 4
      Top = 221
      Width = 735
      Height = 483
      Margins.Top = 4
      Margins.Bottom = 4
      Align = alBottom
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouAuxPlc
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -18
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Codcon'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -14
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -14
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 132
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nomcon'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -14
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O DA CONTA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -14
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 539
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DevCre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -14
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'D/C'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -14
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 39
          Visible = True
        end>
    end
    object PanelBckBut: TLMDSimplePanel
      AlignWithMargins = True
      Left = 17
      Top = 51
      Width = 713
      Height = 44
      Margins.Left = 16
      Margins.Top = 2
      Margins.Right = 12
      Margins.Bottom = 4
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12572415
      Bevel.BorderWidth = 1
      Color = 14674687
      TabOrder = 7
      object edBusPlc: TLMDLabeledEdit
        AlignWithMargins = True
        Left = 111
        Top = 9
        Width = 520
        Height = 28
        Hint = 'Busca natureza financeira'
        Margins.Left = 4
        Margins.Top = 5
        Margins.Right = 4
        Margins.Bottom = 5
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
        OnKeyPress = edBusPlcKeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
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
              89504E470D0A1A0A0000000D4948445200000016000000180806000000FEBE0D
              4B000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              000970485973000011AF000011AF01F7FD4B840000018769545874584D4C3A63
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
              3F3E2C94980B000001C44944415478DAED93BDAB816118C6AF77341A2499E523
              222584814D19506460F10710B341FE0146060A61B01B498981C980F211290325
              9B309C739E7B38CBCBE93D4EEA0CAEEDED7E9FDF733FD77DDDDCC797F002716F
              F0FF004FA75364B359743A1D5C2E17701C0797CB85783C0E83C1F01C98C10281
              00A45229C1B45A2DC6E331068301168B05CAE5327C3EDFEFC0EBF51A168B8560
              8D46031289E4BBC63A0F068368B7DBE8F57AD0EBF5C2C1894402D56A15F3F91C
              62B198573F9FCF04349BCDF49F20F0F17884D56A85CD6643A9547A6855329944
              B3D9C476BB1506DE6C36D0E97448A7D374F8910A850252A9140E878330F0F57A
              85DD6E8742A140AD567B088EC56268B55A3448C11EE77239643219F4FB7DA854
              2A5EFD743AC16834C2E974A2582C0A07B34E42A110F9CC2E512A95DFB5D56A45
              C3659776BB5D68341A61E0E1708870388CDD6E47DF2291087EBF9FAC592E9794
              029614E6B1DBEDE69DBF0B1E8D469451361096DD7C3E8FC964827ABD8ED96C06
              B95C0E8FC78368340AB55A7DF7B53C307B5A2412C17EBFA76D638B613299A876
              BBDD2856ACD37BB9FE11CC02CFFC93C964A8542AB479CF8807F67ABDD4151B96
              C3E1780AFAE3F0FEAA37F8F5E04F763110C8804E7E0F0000000049454E44AE42
              6082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edBusPlcCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 23
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelPosition = lpLeft
        LabelSpacing = 2
        LabelSync = True
        EditLabel.Width = 46
        EditLabel.Height = 28
        EditLabel.Margins.Left = 4
        EditLabel.Margins.Top = 4
        EditLabel.Margins.Right = 4
        EditLabel.Margins.Bottom = 4
        EditLabel.AutoSize = False
        EditLabel.Caption = 'Busca'
      end
    end
    object LMDDBRadioGroup1: TLMDDBRadioGroup
      Left = 609
      Top = 107
      Width = 123
      Height = 74
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Bevel.BorderColor = 16382200
      Bevel.Mode = bmCustom
      BtnAlignment.Alignment = agCenterLeft
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = 9600112
      CaptionFont.Height = -12
      CaptionFont.Name = 'Roboto'
      CaptionFont.Style = [fsBold]
      CaptionParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -14
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ImageIndex = 1
      Items.Strings = (
        ' DEVEDORA'
        'CREDORA')
      ParentFont = False
      TabOrder = 2
      OnClick = LMDDBRadioGroup1Click
      OnEnter = LMDDBRadioGroup1Enter
      DataField = 'DevCre'
      DataSource = SouPlco
      Values.Strings = (
        'D'
        'C')
    end
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 665
    Top = 290
  end
  object SouPlco: TDataSource
    DataSet = TabPlco
    Left = 485
    Top = 14
  end
  object TabPlco: TRESTDWClientSQL
    Active = False
    AfterInsert = TabPlcoAfterInsert
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
      'SELECT * FROM arqplacon ORDER BY Codcon')
    UpdateTableName = 'arqplacon'
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 405
    Top = 15
    object TabPlcoIDCon: TFDAutoIncField
      FieldName = 'IDCon'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TabPlcoCodcon: TWideStringField
      DisplayWidth = 8
      FieldName = 'Codcon'
      EditMask = '#.#.#.##.###;0;_'
      Size = 8
    end
    object TabPlcoNomcon: TWideStringField
      FieldName = 'Nomcon'
      Size = 60
    end
    object TabPlcoNivcon: TWideStringField
      FieldName = 'Nivcon'
      Size = 1
    end
    object TabPlcoDevCre: TWideStringField
      FieldName = 'DevCre'
      Size = 1
    end
    object TabPlcoIndFixa: TWideStringField
      FieldName = 'IndFixa'
      Size = 1
    end
  end
  object TabAuxPlco: TRESTDWClientSQL
    Active = False
    AfterOpen = TabAuxPlcoAfterOpen
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
      'SELECT * FROM arqplacon ORDER BY Codcon')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 52
    Top = 268
    object TabAuxPlcoIDCon: TFDAutoIncField
      FieldName = 'IDCon'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TabAuxPlcoCodcon: TWideStringField
      DisplayWidth = 8
      FieldName = 'Codcon'
      EditMask = '#.#.#.##.###;0;_'
      Size = 8
    end
    object TabAuxPlcoNomcon: TWideStringField
      FieldName = 'Nomcon'
      Size = 60
    end
    object TabAuxPlcoNivcon: TWideStringField
      FieldName = 'Nivcon'
      Size = 1
    end
    object TabAuxPlcoDevCre: TWideStringField
      FieldName = 'DevCre'
      Size = 1
    end
    object TabAuxPlcoIndFixa: TWideStringField
      FieldName = 'IndFixa'
      Size = 1
    end
  end
  object SouAuxPlc: TDataSource
    AutoEdit = False
    DataSet = TabAuxPlco
    Left = 41
    Top = 362
  end
end
