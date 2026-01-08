object FrmGrupoPre: TFrmGrupoPre
  Left = 470
  Top = 249
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'Produtos - Grupos de Pre'#231'os'
  ClientHeight = 518
  ClientWidth = 997
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
    Width = 997
    Height = 518
    Margins.Right = 4
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
    object Shape1: TShape
      Left = 1
      Top = 193
      Width = 995
      Height = 1
      Align = alBottom
      Pen.Color = 14211288
      ExplicitTop = 171
      ExplicitWidth = 501
    end
    object PanelButtons: TLMDSimplePanel
      Left = 363
      Top = 125
      Width = 329
      Height = 26
      ParentColor = True
      TabOrder = 1
      object btSalvar: TAdvGlowButton
        AlignWithMargins = True
        Left = 225
        Top = 0
        Width = 104
        Height = 26
        Cursor = crHandPoint
        Margins.Left = 0
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
        Left = 113
        Top = 0
        Width = 104
        Height = 26
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 8
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
        Left = 1
        Top = 0
        Width = 104
        Height = 26
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 8
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
      Top = 4
      Width = 987
      Height = 27
      Margins.Left = 5
      Margins.Bottom = 0
      Align = alTop
      ParentColor = True
      TabOrder = 2
      object LMDLabel2: TLMDLabel
        AlignWithMargins = True
        Left = 0
        Top = 3
        Width = 143
        Height = 21
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
        Caption = 'Grupos de Pre'#231'os'
        ExplicitLeft = 10
        ExplicitTop = 6
        ExplicitHeight = 28
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 963
        Top = 1
        Width = 24
        Height = 18
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
    object LMDDBLabeledEdit2: TLMDDBLabeledEdit
      Left = 363
      Top = 92
      Width = 329
      Height = 23
      Hint = 'Parcela / Desdobramento'
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
      ValidationMsgString = 'a descri'#231#227'o do local'
      CharCase = ecUpperCase
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'DesGruPre'
      DataSource = SouGrupoPre
      LabelSpacing = 2
      EditLabel.Width = 153
      EditLabel.Height = 15
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'NOME DO GRUPO DE PRE'#199'OS'
    end
    object LMDDBLabeledEdit0: TLMDDBLabeledEdit
      Left = 307
      Top = 92
      Width = 45
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15657192
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = 15397119
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      DataField = 'IDGruPre'
      DataSource = SouGrupoPre
      ReadOnly = True
      OnDataChange = LMDDBLabeledEdit0DataChange
      EditLabel.Width = 40
      EditLabel.Height = 15
      EditLabel.AutoSize = False
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 9600112
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      EditLabel.Caption = 'ID GRU.'
    end
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 197
      Width = 995
      Height = 283
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alBottom
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouProd
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'IDProd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'ID PROD.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Despro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 355
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qtdest'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'ESTOQUE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CustoMed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'CUS.M'#201'DIO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PrecoFab'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'P.COMPRA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PrecoVen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'PR.VENDA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Markup'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'MARKUP'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PerDesMan'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESC.M'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 47
          Visible = True
        end
        item
          Color = 15528703
          Expanded = False
          FieldName = 'PerDesIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESC.IA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PrePromo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'PROMO'#199#195'O'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 23
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'IndSel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = ' '
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 23
          Visible = True
        end>
    end
    object PanelBckBut: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 31
      Width = 995
      Height = 32
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12572415
      Bevel.BorderWidth = 1
      Color = 14674687
      TabOrder = 5
      object edBusca: TLMDLabeledEdit
        AlignWithMargins = True
        Left = 314
        Top = 5
        Width = 370
        Height = 22
        Hint = 'Busca natureza financeira'
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
        Font.Color = clBlack
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
        EditLabel.Width = 51
        EditLabel.Height = 22
        EditLabel.AutoSize = False
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = 7039851
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'BUSCAR'
      end
    end
    object LMDSimplePanel1: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 159
      Width = 995
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12572415
      Bevel.BorderWidth = 1
      Color = 15791615
      TabOrder = 6
      object LMDLabel6: TLMDLabel
        Left = 171
        Top = 10
        Width = 53
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7561815
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'PRODUTO'
      end
      object edCodpro: TLMDEdit
        Left = 227
        Top = 5
        Width = 110
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14737632
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        OnExit = edCodproExit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        CustomButtons = <>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
      end
      object edNompro: TLMDLabeledEdit
        Left = 343
        Top = 5
        Width = 404
        Height = 22
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 14737632
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = clWhite
        TabOrder = 1
        OnKeyDown = edNomproKeyDown
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
            OnClick = edNomproCustomButtons0Click
            UsePngGlyph = True
          end>
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = -15
        EditLabel.Width = 52
        EditLabel.Height = 17
        EditLabel.Caption = 'edBusca'
      end
      object btIncProd: TAdvGlowButton
        AlignWithMargins = True
        Left = 758
        Top = 5
        Width = 68
        Height = 20
        Cursor = crHandPoint
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Incluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000FD49
          444154388DDD8FAD4EC4401446CFF40F4C430055D38437D8A22658E00DA82159
          839FA68637C056566F82478084E5012A1B92BE03091882C0F40E8669BA1B5258
          099FBD39E7FB2EFCF9F89B02C6984C6B7DA3B5FE689AE6C9DB042ECBF25029B5
          048E8053805F0BCAB29C89C83DB007B441105CAE088C315B53CD22F208EC036D
          DFF7C75555BD0C82A228AE94526F4551CCD761634C26220FAE390CC393BAAE5F
          DDDD2DF08108588C25C698ECEBE70176CD2E0A20CF733F499205300704B8F03C
          AF1591A59BFD1D3C0846926BE01CE89552EFD6DA9D29D84D07A0EB3A9BA6E96D
          1CC707C00CD8FE095E118C2477711CEF5A6B9FA3283A9B82FF493E011AE15F70
          C2956D500000000049454E44AE426082}
        Rounded = True
        TabOrder = 2
        OnClick = btIncProdClick
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
    object LMDSimplePanel2: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 482
      Width = 995
      Height = 35
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12572415
      Bevel.BorderWidth = 1
      Color = 15791615
      TabOrder = 7
      object btAssProd: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 4
        Top = 6
        Width = 185
        Height = 24
        Cursor = crHandPoint
        Margins.Top = 5
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Associa Diversos Produtos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6250335
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
          00097048597300000EC100000EC101B8916BED0000001974455874536F667477
          617265007777772E696E6B73636170652E6F72679BEE3C1A0000025949444154
          484BE5943B881351148667321AC488A088121457546CC442B4130D5858B87109
          92CDDB47E1A39315B75E512CD415B1B55AA3641292F828345B584550414410B1
          5B58564109581A349887DFCD9C89199D1D630A41FCE1E7BFE79C7BCFB9F7CCBD
          A3FDF3D0458742341A5DEDF3F90EE8BABE065DF0FBFD8FB3D9EC570977317481
          783C7E189921F94ACBA3699D4E67C1308C43A669BE1197E613F544381C5E9E4C
          2623A9546A44D9E8662467272F140ADD8D628FB45AAD5C28145AA26C05CF0299
          4C666D2291B8180804DEB1BBFBED767B8E9D5F23C938C996C93407F0EF080683
          FBC4746F1149B631F11C498FFE9C08DF23E423FE13F6CEFBC186A689CDE5F3F9
          9BCA764C88C5627B084E321C435D4F478117C82CF1F396C76A11893B62AA538C
          52A0A2C6BD24D2DF4D04D72F965C81D82EE425EC25EC071BF8D06C369F88F9A3
          00FD8DB2789A09776104D72C744B6230EF343A05BBF1BEDD7FE1BA9E2C954A9F
          C5767E641606E16586B7E15B0A8DA277D06F2A2E78C66672E87BAE6484D855C6
          33E8143BDF6EB7C6866B2B28A2AEDF24FA006DA16324B8205A416FE0BFC56DBA
          87EEC7B70EDD582E97E7510716EDB5C00F8FC30A499E4393E497A04AA8A0DAB5
          1B1E845BC5E7C0EF0AD8D069C70A54F18F306881A1317001DA33D47FEBAF9EE0
          93A82BF888AE0FCB0627745DDF2BC073CF92642FC38796C7098F16CD139BA8D7
          EBC7C476C075112F73277216A6A0A17C601C96AC6117AF7970D76BB59A59AD56
          9BE2FB059E1F8EBFEA16E40C3CC5E98EA0AAC053C65778B1EAA49E6D5318E866
          A4D3E90D8D466329FF9955C562F195B8FF0B68DA775FDCDACD90C388EE000000
          0049454E44AE426082}
        Rounded = True
        Spacing = 0
        TabOrder = 0
        OnClick = btAssProdClick
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
      object btDelMarc: TAdvGlowButton
        AlignWithMargins = True
        Left = 801
        Top = 6
        Width = 190
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 5
        Margins.Bottom = 4
        Align = alRight
        Caption = 'Elimina Produtos Marcados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5723991
        Font.Height = -12
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
        Spacing = 0
        TabOrder = 1
        OnClick = btDelMarcClick
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
      object btEtiq: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 197
        Top = 6
        Width = 121
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 8
        Margins.Top = 5
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Etiquetas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6250335
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000EC300000EC301C76FA8640000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000011949
          444154388D9592214B04511485BFF3F68120F80BFC031344FF81C5E8EC6D36BB
          988485059BC5220806D382C5647ECECF102D9B5E134483C5627377AF41065C99
          19674F7BE7BCEF70E15ED1A1B22C37DD7DEDB71763FC4A29BDD46FB5B032B34B
          60D414BAFBB8AAAACBB60299D91570D231DC9DA473773F0B3DE1A92403DE6B63
          369B05E020F480013E420819F8AC8D18A300C59E63EFCEE7F3DC14841E70A782
          995DAC0A4B7AA8D71B81A315E1EBC562310921DCBBFB7300C680AF009F4A4AEE
          BE2DC90639E7C7A2285E8192F6C3C2DD27EE3E9694801D497B29A5E90020E7FC
          5414C55B5B89BB4F80D15F1860507F6A2BE982970A9A4AFE83E1E70E969452BA
          01F681C3AAAA8E25DD025B4D702F99D9C670385C6FCBBF011997863D44CEDDAE
          0000000049454E44AE426082}
        Rounded = True
        Spacing = 3
        TabOrder = 2
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
  end
  object timAlpha: TTimer
    Interval = 250
    OnTimer = timAlphaTimer
    Left = 34
    Top = 84
  end
  object TabProd: TRESTDWClientSQL
    Active = False
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
      
        'SELECT ap.IDProd,ap.Despro,ap.CustoMed,ap.PrecoVen,ap.PrecoFab,a' +
        'p.IndSel,ap.Markup AS Margem,SUM(LOT.Qtdest) AS Qtdest,arp.PrePr' +
        'omo,'
      '    arp.PerDesIA,arp.PerDesMan,CASE '
      
        '        WHEN ap.CustoMed > 0 THEN ((arp.PrePromo - ap.CustoMed) ' +
        '/ ap.CustoMed) * 100 '
      '        ELSE NULL '
      '    END AS CalculatedMarkup,'
      '    CASE '
      '        WHEN arp.PrePromo IS NOT NULL AND arp.PrePromo > 0 THEN '
      '            ((arp.PrePromo - ap.CustoMed) / ap.CustoMed) * 100 '
      '        ELSE ap.Markup'
      '    END AS Markup'
      'FROM arqproduto ap'
      'LEFT JOIN arqprodutolot LOT ON ap.IDProd = LOT.IDProd'
      'LEFT JOIN '
      
        '    (SELECT arp.IDProd,arp.PrePromo,arp.PerDesIA,arp.PerDesMan,a' +
        'rp.IDProm,MAX(arp.IDProm) AS MostRecentPromo'
      '        FROM arqpromopro arp'
      '        INNER JOIN arqpromocao apc ON arp.IDProm = apc.IDProm'
      '        WHERE apc.IndAtivo = "1" '
      
        '            AND CURDATE() BETWEEN apc.DataON AND apc.DataOFF GRO' +
        'UP BY arp.IDProd) AS arp ON ap.IDProd = arp.IDProd'
      'WHERE ap.IDGruPre = 1'
      'GROUP BY ap.IDProd, ap.IDGruPre ORDER BY ap.Despro;')
    UpdateTableName = 'arqproduto'
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 21
    Top = 261
    object TabProdIDProd: TIntegerField
      FieldName = 'IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabProdDespro: TWideStringField
      FieldName = 'Despro'
      Size = 120
    end
    object TabProdCustoMed: TFloatField
      FieldName = 'CustoMed'
      DisplayFormat = '###,###,##0.00'
    end
    object TabProdPrecoVen: TFloatField
      FieldName = 'PrecoVen'
      DisplayFormat = '###,###,##0.00'
    end
    object TabProdPrecoFab: TFloatField
      FieldName = 'PrecoFab'
      DisplayFormat = '###,###,##0.00'
    end
    object TabProdQtdest: TFloatField
      FieldName = 'Qtdest'
      DisplayFormat = '###,###,##0.00'
    end
    object TabProdIndSel: TWideStringField
      FieldName = 'IndSel'
      Size = 1
    end
    object TabProdPrePromo: TFloatField
      FieldName = 'PrePromo'
      ProviderFlags = []
      DisplayFormat = '###,###,##0.00'
    end
    object TabProdPerDesIA: TFloatField
      FieldName = 'PerDesIA'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
    end
    object TabProdPerDesMan: TFloatField
      FieldName = 'PerDesMan'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
    end
    object TabProdMarkup: TFloatField
      FieldName = 'Markup'
      ProviderFlags = []
      DisplayFormat = '###,##0.00'
    end
  end
  object SouProd: TDataSource
    AutoEdit = False
    DataSet = TabProd
    Left = 21
    Top = 348
  end
  object TabGrupoPre: TRESTDWClientSQL
    Active = False
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
      'SELECT * FROM arqprodutogpr ORDER BY DesGruPre'
      '')
    UpdateTableName = 'arqprodutogpr'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 799
    Top = 90
    object TabGrupoPreIDGruPre: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDGruPre'
      Origin = 'arqprodutogpr.IDGruPre'
    end
    object TabGrupoPreDesGruPre: TWideStringField
      FieldName = 'DesGruPre'
      Origin = 'arqprodutogpr.DesGruPre'
    end
  end
  object SouGrupoPre: TDataSource
    DataSet = TabGrupoPre
    Left = 903
    Top = 90
  end
end
