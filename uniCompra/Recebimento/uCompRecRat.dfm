object FrmCompRecRat: TFrmCompRecRat
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'COMPRAS - Recebimento Rateio de Valores'
  ClientHeight = 240
  ClientWidth = 311
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
  TextHeight = 15
  object LMDSimplePanel1: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 309
    Height = 24
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 2
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 15130077
    Bevel.BorderWidth = 1
    Color = 15790320
    TabOrder = 0
    object LMDLabel1: TLMDLabel
      Left = 102
      Top = 4
      Width = 106
      Height = 17
      Alignment = agCenterRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7561559
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'VALORES  RATEIO'
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 287
      Top = 2
      Width = 20
      Height = 19
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 2
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
      Transparent = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btFecharClick
      Appearance.BorderColor = 15790320
      Appearance.BorderColorHot = 15790320
      Appearance.BorderColorCheckedHot = 15790320
      Appearance.BorderColorDown = 15790320
      Appearance.BorderColorChecked = 15790320
      Appearance.BorderColorDisabled = 15790320
      Appearance.BorderColorFocused = 15790320
      Appearance.Color = 15790320
      Appearance.ColorTo = 15790320
      Appearance.ColorChecked = 15790320
      Appearance.ColorCheckedTo = 15790320
      Appearance.ColorDisabled = 15790320
      Appearance.ColorDisabledTo = 15790320
      Appearance.ColorDown = 15790320
      Appearance.ColorDownTo = 15790320
      Appearance.ColorHot = 15790320
      Appearance.ColorHotTo = 15790320
      Appearance.ColorMirror = 15790320
      Appearance.ColorMirrorTo = 15790320
      Appearance.ColorMirrorHot = 15790320
      Appearance.ColorMirrorHotTo = 15790320
      Appearance.ColorMirrorDown = 15790320
      Appearance.ColorMirrorDownTo = 15790320
      Appearance.ColorMirrorChecked = 15790320
      Appearance.ColorMirrorCheckedTo = 15790320
      Appearance.ColorMirrorDisabled = 15790320
      Appearance.ColorMirrorDisabledTo = 15790320
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
    Top = 27
    Width = 309
    Height = 179
    Margins.Left = 1
    Margins.Top = 0
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 14540253
    Bevel.BorderWidth = 1
    Color = 15528703
    TabOrder = 1
    object edDesAce: TLMDDBLabeledEdit
      Left = 60
      Top = 34
      Width = 88
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 0
      OnKeyPress = edDesAceKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'VlrAces'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 84
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'DESP.ACESS'#211'R.'
    end
    object edDesAsso: TLMDDBLabeledEdit
      Left = 161
      Top = 34
      Width = 82
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 1
      OnKeyPress = edDesAceKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'DesAsso'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 66
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'DESCONTOS'
    end
    object edVlrJur: TLMDDBLabeledEdit
      Left = 60
      Top = 89
      Width = 88
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 2
      OnKeyPress = edDesAceKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'ValorJuros'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 55
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'JUROS R$'
    end
    object edVlrMul: TLMDDBLabeledEdit
      Left = 60
      Top = 143
      Width = 88
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 4
      OnKeyPress = edDesAceKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'ValorMulta'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 56
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'MULTA R$'
    end
    object edPerMul: TLMDDBLabeledEdit
      Left = 161
      Top = 143
      Width = 66
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 5
      OnKeyPress = edDesAceKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'PercenMulta'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 50
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'MULTA %'
    end
    object edPerJur: TLMDDBLabeledEdit
      Left = 161
      Top = 89
      Width = 66
      Height = 23
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15130077
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      Color = clWhite
      TabOrder = 3
      OnKeyPress = edDesAceKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2236186
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      TabOnEnter = True
      DataField = 'PercenJuros'
      DataSource = SouTitulo
      LabelSpacing = 2
      EditLabel.Width = 49
      EditLabel.Height = 15
      EditLabel.Color = 16382200
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = 7561559
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Roboto'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentColor = False
      EditLabel.ParentFont = False
      EditLabel.Caption = 'JUROS %'
    end
  end
  object LMDSimplePanel3: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 208
    Width = 309
    Height = 31
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alBottom
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 15130077
    Bevel.BorderWidth = 1
    Color = 15790320
    TabOrder = 2
    object btConfirma: TAdvGlowButton
      Tag = 1
      AlignWithMargins = True
      Left = 112
      Top = 3
      Width = 96
      Height = 25
      Cursor = crHandPoint
      Caption = 'CONFIRMAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000F649
        444154388DE5D1B14AC44010C6F1FF9E206902296C9720D82DC8C195BB811416
        36622768E92BF80216BE8A9D60739D88B14891348A85281642B656ECD46C92B5
        51B9E3B81CD7EA74C3F0FB1866E0FF95D65A19630E7FFA95657092249BDEFB2B
        603F8EE3BBAAAA1E06CBE0AEEB2E8135E0B66DDBEBC90D065AEB132925D6DAE7
        45D839B75514C52B800030C61C78EF4F81776037CFF38B3E5C96E5CBD40DC230
        7C0C82600828604F4A7963AD7D5A847F3700504AAD46517406EC009F428823EF
        FD711F9E0A0048D33470CE9D03DB80FF9ECFC533011321F7C0BA10E2ADAEEB8D
        791860E68D59967D344D3314428C81511FFE23F505054E7EFB3ECFA3C8000000
        0049454E44AE426082}
      Rounded = True
      Spacing = 0
      TabOrder = 0
      OnClick = btConfirmaClick
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
      Appearance.ColorHotTo = 9943551
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
  object SouTitulo: TDataSource
    DataSet = TabTitu
    Left = 252
    Top = 140
  end
  object TabTitu: TRESTDWClientSQL
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
    Params = <
      item
        DataType = ftInteger
        Name = 'IDTitu'
        ParamType = ptInput
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT * FROM arqtitulotemp WHERE IDTitu = :IDTitu')
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 254
    Top = 84
    object TabTituIDTitu: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDTitu'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituIDPess: TIntegerField
      FieldName = 'IDPess'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituNotFis: TIntegerField
      FieldName = 'NotFis'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituNroSerie: TIntegerField
      FieldName = 'NroSerie'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabTituNrotit: TWideStringField
      FieldName = 'Nrotit'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabTituDestit: TWideStringField
      FieldName = 'Destit'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 3
    end
    object TabTituPagRec: TWideStringField
      FieldName = 'PagRec'
      Size = 1
    end
    object TabTituIDTiptit: TIntegerField
      FieldName = 'IDTiptit'
    end
    object TabTituDatemi: TDateField
      FieldName = 'Datemi'
    end
    object TabTituDatven: TDateField
      FieldName = 'Datven'
    end
    object TabTituDesAsso: TFloatField
      FieldName = 'DesAsso'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituVlrAces: TFloatField
      FieldName = 'VlrAces'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituVlrDevo: TFloatField
      FieldName = 'VlrDevo'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituVlrtit: TFloatField
      FieldName = 'Vlrtit'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituSaltit: TFloatField
      FieldName = 'Saltit'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituHistit: TWideStringField
      FieldName = 'Histit'
      Size = 120
    end
    object TabTituIDFilial: TIntegerField
      FieldName = 'IDFilial'
    end
    object TabTituIDPed: TIntegerField
      FieldName = 'IDPed'
    end
    object TabTituIDNatFin: TIntegerField
      FieldName = 'IDNatFin'
    end
    object TabTituIDConv: TIntegerField
      FieldName = 'IDConv'
    end
    object TabTituCodBarra: TWideStringField
      FieldName = 'CodBarra'
      Size = 48
    end
    object TabTituIndSel: TWideStringField
      FieldName = 'IndSel'
      Size = 1
    end
    object TabTituIndEnvBco: TWideStringField
      FieldName = 'IndEnvBco'
      Size = 1
    end
    object TabTituNossoNro: TWideStringField
      FieldName = 'NossoNro'
    end
    object TabTituCodRec: TIntegerField
      FieldName = 'CodRec'
    end
    object TabTituNumReferencia: TWideStringField
      FieldName = 'NumReferencia'
    end
    object TabTituDatCompApur: TDateField
      FieldName = 'DatCompApur'
    end
    object TabTituValorJuros: TFloatField
      FieldName = 'ValorJuros'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituValorMulta: TFloatField
      FieldName = 'ValorMulta'
      DisplayFormat = '###,###,##0.00'
    end
    object TabTituPercenJuros: TFloatField
      FieldName = 'PercenJuros'
      DisplayFormat = '##0.00'
    end
    object TabTituPercenMulta: TFloatField
      FieldName = 'PercenMulta'
      DisplayFormat = '##0.00'
    end
    object TabTituChavePIXQRCode: TWideStringField
      FieldName = 'ChavePIXQRCode'
      Size = 300
    end
  end
end
