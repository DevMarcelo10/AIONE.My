object FrmTitEst: TFrmTitEst
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FINANCEIRO - Estorno de Baixa de T'#237'tulos'
  ClientHeight = 147
  ClientWidth = 888
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 3158064
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 14
  object PanelBas: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 888
    Height = 129
    Align = alClient
    Bevel.StyleInner = bvNormal
    Bevel.WidthInner = 0
    Bevel.BorderColor = clSilver
    Bevel.BorderWidth = 1
    Color = 16053492
    TabOrder = 0
    object Shape1: TShape
      Left = 1
      Top = 127
      Width = 886
      Height = 1
      Align = alBottom
      Pen.Color = 13224393
      ExplicitLeft = 2
      ExplicitTop = 105
    end
    object PanelTop: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 4
      Width = 886
      Height = 24
      Margins.Left = 0
      Margins.Right = 0
      Align = alTop
      ParentColor = True
      TabOrder = 0
      object LMDLabel2: TLMDLabel
        Left = 0
        Top = 0
        Width = 131
        Height = 24
        Margins.Left = 1
        Align = alLeft
        Alignment = agCenterLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8811110
        Font.Height = -14
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentFont = False
        Caption = 'Estorno de Baixas'
        ExplicitLeft = 112
        ExplicitTop = -3
      end
      object btFechar: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 862
        Top = 0
        Width = 24
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
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
        Appearance.BorderColor = 16053492
        Appearance.BorderColorHot = 16053492
        Appearance.BorderColorCheckedHot = 16053492
        Appearance.BorderColorDown = 16053492
        Appearance.BorderColorChecked = 16053492
        Appearance.BorderColorDisabled = 16053492
        Appearance.BorderColorFocused = 16053492
        Appearance.Color = 16053492
        Appearance.ColorTo = 16053492
        Appearance.ColorChecked = 16053492
        Appearance.ColorCheckedTo = 16053492
        Appearance.ColorDisabled = 16053492
        Appearance.ColorDisabledTo = 16053492
        Appearance.ColorDown = 16053492
        Appearance.ColorDownTo = 16053492
        Appearance.ColorHot = 16053492
        Appearance.ColorHotTo = 16053492
        Appearance.ColorMirror = 16053492
        Appearance.ColorMirrorTo = 16053492
        Appearance.ColorMirrorHot = 16053492
        Appearance.ColorMirrorHotTo = 16053492
        Appearance.ColorMirrorDown = 16053492
        Appearance.ColorMirrorDownTo = 16053492
        Appearance.ColorMirrorChecked = 16053492
        Appearance.ColorMirrorCheckedTo = 16053492
        Appearance.ColorMirrorDisabled = 16053492
        Appearance.ColorMirrorDisabledTo = 16053492
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
    object DBGrid1: TDBGrid
      Left = 1
      Top = 31
      Width = 886
      Height = 99
      Align = alTop
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouTItuBai
      DrawingStyle = gdsGradient
      FixedColor = 15658734
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'NroBai'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'NRO'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 32
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Datpag'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DATA BAIXA'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrPago'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'VLR.PRINCIPAL'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrJuro'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'JUROS'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrDesc'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESCONTOS'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TotPago'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'TOTAL PAGO'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NomdebLook'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'CONTA D'#201'BITO'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 195
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NomcreLook'
          Font.Charset = ANSI_CHARSET
          Font.Color = 2697513
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'CONTA CR'#201'DITO'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = 1184274
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 195
          Visible = True
        end>
    end
  end
  object PanelTotal: TLMDSimplePanel
    Left = 0
    Top = 129
    Width = 888
    Height = 18
    Margins.Bottom = 10
    Align = alBottom
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 14211288
    Bevel.BorderWidth = 1
    Color = 16053492
    TabOrder = 1
    object Label33: TLabel
      AlignWithMargins = True
      Left = 151
      Top = 2
      Width = 586
      Height = 12
      Margins.Left = 150
      Margins.Top = 1
      Margins.Right = 150
      Align = alClient
      Alignment = taCenter
      Caption = 'Para estornar, d'#234' um duplo clique sobre o t'#237'tulo desejado'
      Color = 16250871
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6447714
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      ExplicitWidth = 285
      ExplicitHeight = 13
    end
  end
  object TmpTituBai: TRESTDWClientSQL
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
      
        'SELECT TIP.*, PCD.Nomcon AS NomdebLook,PCC.Nomcon AS NomcreLook ' +
        'FROM arqtitulobai TIP'
      
        'LEFT JOIN arqplacon PCD ON TIP.CodConDeb = PCD.Codcon LEFT JOIN ' +
        'arqplacon PCC ON TIP.CodConCre = PCC.Codcon')
    UpdateTableName = 'arqtitubai'
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 30
    Top = 71
    object TmpTituBaiIDTitu: TFDAutoIncField
      FieldName = 'IDTitu'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TmpTituBaiNroBai: TIntegerField
      FieldName = 'NroBai'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TmpTituBaiDatpag: TDateField
      FieldName = 'Datpag'
    end
    object TmpTituBaiVlrJuro: TFloatField
      FieldName = 'VlrJuro'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TmpTituBaiVlrDesc: TFloatField
      FieldName = 'VlrDesc'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TmpTituBaiVlrPago: TFloatField
      FieldName = 'VlrPago'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TmpTituBaiTotPago: TFloatField
      FieldName = 'TotPago'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TmpTituBaiCodconDeb: TWideStringField
      DisplayWidth = 8
      FieldName = 'CodconDeb'
      Size = 8
    end
    object TmpTituBaiCodconCre: TWideStringField
      DisplayWidth = 8
      FieldName = 'CodconCre'
      Size = 8
    end
    object TmpTituBaiNomdebLook: TWideStringField
      FieldName = 'NomdebLook'
      Size = 60
    end
    object TmpTituBaiNomcreLook: TWideStringField
      FieldName = 'NomcreLook'
      Size = 60
    end
  end
  object SouTItuBai: TDataSource
    AutoEdit = False
    DataSet = TmpTituBai
    Left = 107
    Top = 71
  end
end
