object FrmVenIACli: TFrmVenIACli
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'IA Vendas Cliente'
  ClientHeight = 427
  ClientWidth = 673
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 14
  object PanelBas: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 673
    Height = 427
    Margins.Right = 4
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13948116
    Bevel.BorderWidth = 1
    Color = 15987185
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7039851
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 669
      Height = 27
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alTop
      ParentColor = True
      TabOrder = 2
      object LMDLabel2: TLMDLabel
        AlignWithMargins = True
        Left = 7
        Top = 6
        Width = 114
        Height = 18
        Margins.Left = 7
        Margins.Top = 6
        Align = alLeft
        Alignment = agCenterLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Seu Cliente'
        ExplicitTop = 5
        ExplicitHeight = 20
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 645
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
        Appearance.BorderColor = 15987185
        Appearance.BorderColorHot = 15987185
        Appearance.BorderColorCheckedHot = 15987185
        Appearance.BorderColorDown = 15987185
        Appearance.BorderColorChecked = 15987185
        Appearance.BorderColorDisabled = 15987185
        Appearance.BorderColorFocused = 15987185
        Appearance.Color = 15987185
        Appearance.ColorTo = 15987185
        Appearance.ColorChecked = 15987185
        Appearance.ColorCheckedTo = 15987185
        Appearance.ColorDisabled = 15987185
        Appearance.ColorDisabledTo = 15987185
        Appearance.ColorDown = 15987185
        Appearance.ColorDownTo = 15987185
        Appearance.ColorHot = 15987185
        Appearance.ColorHotTo = 15987185
        Appearance.ColorMirror = 15987185
        Appearance.ColorMirrorTo = 15987185
        Appearance.ColorMirrorHot = 15987185
        Appearance.ColorMirrorHotTo = 15987185
        Appearance.ColorMirrorDown = 15987185
        Appearance.ColorMirrorDownTo = 15987185
        Appearance.ColorMirrorChecked = 15987185
        Appearance.ColorMirrorCheckedTo = 15987185
        Appearance.ColorMirrorDisabled = 15987185
        Appearance.ColorMirrorDisabledTo = 15987185
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
    object PanelMenCli: TLMDSimplePanel
      Left = 1
      Top = 29
      Width = 671
      Height = 18
      Margins.Top = 0
      Align = alTop
      Color = 14674687
      TabOrder = 3
      DesignSize = (
        671
        18)
      object LMDLabel1: TLMDLabel
        Left = 0
        Top = 0
        Width = 671
        Height = 18
        Align = alClient
        Alignment = agCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16582
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = #218'LTIMAS COMPRAS'
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 720
        ExplicitHeight = 15
      end
      object LMDLabel4: TLMDLabel
        Left = 680
        Top = 10
        Width = 82
        Height = 16
        Alignment = agCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16582
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Anchors = [akTop, akRight]
        Caption = 'TOTAL ITEM'
        ExplicitLeft = 825
      end
      object edTotalpedIte: TLMDMaskEdit
        Left = 680
        Top = 27
        Width = 83
        Height = 24
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 12900863
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        TabStop = False
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2434341
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatNumber
        ReadOnly = True
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        Value = 0.000000000000000000
      end
    end
    object DBGrid2: TDBGrid
      AlignWithMargins = True
      Left = 1
      Top = 222
      Width = 671
      Height = 141
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = SouProdSug
      DrawingStyle = gdsGradient
      GradientEndColor = 15658734
      GradientStartColor = 15658734
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 7039851
      TitleFont.Height = -12
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'IDProd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO'
          Title.Color = clNone
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Despro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 349
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'VencProx'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'VENC.PR'#211'X'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'ESTOQ.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PrecoVen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'VLR.UNIT.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 70
          Visible = True
        end>
    end
    object LMDSimplePanel1: TLMDSimplePanel
      Left = 1
      Top = 203
      Width = 671
      Height = 18
      Margins.Top = 0
      Align = alTop
      Color = 14674687
      TabOrder = 4
      DesignSize = (
        671
        18)
      object LMDLabel3: TLMDLabel
        AlignWithMargins = True
        Left = 10
        Top = 0
        Width = 651
        Height = 18
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alClient
        Alignment = agCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16582
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'PRODUTOS SUGERIDOS'
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 720
        ExplicitHeight = 15
      end
      object LMDLabel5: TLMDLabel
        Left = 680
        Top = 10
        Width = 82
        Height = 16
        Alignment = agCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16582
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Anchors = [akTop, akRight]
        Caption = 'TOTAL ITEM'
        ExplicitLeft = 825
      end
      object LMDMaskEdit1: TLMDMaskEdit
        Left = 680
        Top = 27
        Width = 83
        Height = 24
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Color = 12900863
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        TabStop = False
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2434341
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        AutoSelect = True
        ParentFont = False
        Alignment = taRightJustify
        CustomButtons = <>
        Decimals = 2
        MaskType = meFloatNumber
        ReadOnly = True
        TabOnEnter = True
        TimeSettings.AMSign = 'am'
        TimeSettings.PMSign = 'pm'
        TimeSettings.MSign = 'm'
        Value = 0.000000000000000000
      end
    end
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 1
      Top = 48
      Width = 671
      Height = 155
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = SouUltCom
      DrawingStyle = gdsGradient
      GradientEndColor = 15658734
      GradientStartColor = 15658734
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 7039851
      TitleFont.Height = -12
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'IDProd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO'
          Title.Color = clNone
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Despro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 358
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'UltimaCompra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DATA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QtdeTotalComprada'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'QUANT.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PrecoVen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'VLR.UNIT.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5987163
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 70
          Visible = True
        end>
    end
    object PanelNfoIA: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 364
      Width = 667
      Height = 59
      Margins.Left = 1
      Margins.Top = 1
      Align = alBottom
      Color = 15397375
      TabOrder = 5
    end
  end
  object TabUltComp: TRESTDWClientSQL
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
      
        'SELECT P.IDProd,PR.Despro,Date(MAX(R.DatPed)) AS UltimaCompra,PR' +
        '.PrecoVen,'
      
        'SUM(P.QtdPed) AS QtdeTotalComprada, SUM(PL.Qtdest) AS QtdeEmEsto' +
        'que,'
      
        'MIN(PL.Datven) AS VencMaisProx,PR.PrecoVen,PR.PrecoFab, PR.Marku' +
        'p FROM arqpessoa C '
      'LEFT JOIN arqpedido R ON R.IDPess = C.IDPess'
      
        'LEFT JOIN arqpedidoite P ON P.IDPed = R.IDPed AND P.IDFilial = R' +
        '.IDFilial'
      'LEFT JOIN arqproduto PR ON PR.IDProd = P.IDProd'
      
        'LEFT JOIN arqprodutolot PL ON PL.IDProd = P.IDProd AND PL.IDFili' +
        'al = P.IDFilial AND PL.Datven > CURDATE()'
      
        'WHERE C.IDPess = 398 AND Date(R.DatPed) >= CURDATE() - INTERVAL ' +
        '18 MONTH AND R.Status = '#39'F'#39
      
        'GROUP BY P.IDProd HAVING QtdeEmEstoque > 0 ORDER BY UltimaCompra' +
        ' DESC LIMIT 10;')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 29
    Top = 91
    object TabUltCompIDProd: TIntegerField
      FieldName = 'IDProd'
    end
    object TabUltCompProduto: TWideStringField
      FieldName = 'Despro'
      ProviderFlags = []
      Size = 120
    end
    object TabUltCompUltimaCompra: TDateField
      FieldName = 'UltimaCompra'
    end
    object TabUltCompQtdeTotalComprada: TFloatField
      FieldName = 'QtdeTotalComprada'
      DisplayFormat = '###,###,##0.00'
    end
    object TabUltCompQtdeEmEstoque: TFloatField
      FieldName = 'QtdeEmEstoque'
      DisplayFormat = '###,###,##0.00'
    end
    object TabUltCompVencMaisProx: TDateField
      FieldName = 'VencMaisProx'
    end
    object TabUltCompPrecoVen: TFloatField
      FieldName = 'PrecoVen'
      DisplayFormat = '###,###,##0.00'
    end
    object TabUltCompPrecoFab: TFloatField
      FieldName = 'PrecoFab'
      DisplayFormat = '###,###,##0.00'
    end
    object TabUltCompMarkup: TFloatField
      FieldName = 'Markup'
      DisplayFormat = '###,##0.00'
    end
  end
  object SouUltCom: TDataSource
    AutoEdit = False
    DataSet = TabUltComp
    Left = 29
    Top = 147
  end
  object TabProdSug: TRESTDWClientSQL
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
      
        'SELECT P2.IDProd,PR2.Despro,COUNT(*) AS QtdAssociada,SUM(PL.Qtde' +
        'st) AS Estoque,PR2.PrecoVen,'
      'MIN(PL.Datven) AS VencProx,PR2.Markup FROM arqpedido R'
      
        'LEFT JOIN arqpedidoite P1 ON P1.IDPed = R.IDPed AND P1.IDFilial ' +
        '= R.IDFilial'
      
        'LEFT JOIN arqpedidoite P2 ON P2.IDPed = R.IDPed AND P2.IDFilial ' +
        '= R.IDFilial AND P2.IDProd != P1.IDProd'
      'LEFT JOIN arqproduto PR2 ON PR2.IDProd = P2.IDProd'
      
        'LEFT JOIN arqprodutolot PL ON PL.IDProd = P2.IDProd AND PL.Datve' +
        'n > CURDATE() '
      
        'WHERE P1.IDProd IN (SELECT DISTINCT IDProd FROM arqpedidoite WHE' +
        'RE IDPed = 141609 AND IDFilial = 1)'
      'AND R.DatPed >= CURDATE() - INTERVAL 18 MONTH AND R.Status = "F"'
      'GROUP BY P2.IDProd, PR2.Despro, PR2.Markup  HAVING Estoque > 0'
      'ORDER BY QtdAssociada DESC, Estoque DESC LIMIT 10')
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 45
    Top = 267
    object TabProdSugIDProd: TIntegerField
      FieldName = 'IDProd'
    end
    object TabProdSugDespro: TWideStringField
      FieldName = 'Despro'
      Size = 120
    end
    object TabProdSugQtdAssociada: TLargeintField
      FieldName = 'QtdAssociada'
      DisplayFormat = '###,##0.00'
    end
    object TabProdSugEstoque: TFloatField
      FieldName = 'Estoque'
      DisplayFormat = '###,##0.00'
    end
    object TabProdSugVencProx: TDateField
      FieldName = 'VencProx'
    end
    object TabProdSugMarkup: TFloatField
      FieldName = 'Markup'
      DisplayFormat = '###,##0.00'
    end
    object TabProdSugPrecoVen: TFloatField
      FieldName = 'PrecoVen'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object SouProdSug: TDataSource
    AutoEdit = False
    DataSet = TabProdSug
    Left = 45
    Top = 339
  end
end
