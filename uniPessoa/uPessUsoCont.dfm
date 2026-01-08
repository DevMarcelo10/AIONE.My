object FrmPesUCon: TFrmPesUCon
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Pessoas Uso Continuo'
  ClientHeight = 161
  ClientWidth = 990
  Color = 15855599
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object DBGrid1: TDBGrid
    Tag = 1
    AlignWithMargins = True
    Left = 0
    Top = 5
    Width = 990
    Height = 156
    Margins.Left = 0
    Margins.Top = 5
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    DataSource = SouPesUCon
    DrawingStyle = gdsGradient
    FixedColor = 15066597
    GradientEndColor = 15855599
    GradientStartColor = 15855599
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = 5131854
    TitleFont.Height = -15
    TitleFont.Name = 'Roboto'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnColExit = DBGrid1ColExit
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Despro'
        Title.Alignment = taCenter
        Title.Caption = 'Produto de Uso Cont'#237'nuo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 248
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CpfPBM'
        Title.Alignment = taCenter
        Title.Caption = 'CPF no PBM'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QtdDia'
        Title.Alignment = taCenter
        Title.Caption = 'Qt./Dia'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 43
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DatUltCom'
        Title.Alignment = taCenter
        Title.Caption = 'Ult.Comp.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 92
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DatProCom'
        PickList.Strings = (
          '')
        Title.Alignment = taCenter
        Title.Caption = 'Prox.Comp.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 92
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NomPBM'
        Title.Alignment = taCenter
        Title.Caption = 'Identifica'#231#227'o PBM'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 130
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NroRegProf'
        Title.Alignment = taCenter
        Title.Caption = 'CRM. PBM'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nommed'
        Title.Alignment = taCenter
        Title.Caption = 'M'#233'dico(a) PBM'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -12
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 165
        Visible = True
      end
      item
        Expanded = False
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 20
        Visible = True
      end>
  end
  object DBDateEdit1: TDBDateEdit
    AlignWithMargins = True
    Left = 397
    Top = 29
    Width = 86
    Height = 19
    Margins.Top = 2
    Margins.Right = 2
    DataField = 'DatUltCom'
    DataSource = SouPesUCon
    AutoSelect = False
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    DialogTitle = 'Entre com Data'
    Font.Charset = ANSI_CHARSET
    Font.Color = 2236186
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    GlyphKind = gkCustom
    Glyph.Data = {
      0E0A0000424D0E0A000000000000360000002800000028000000150000000100
      180000000000D809000000000000000000000000000000000000241CED241CED
      241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED24
      1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
      241CED241CED241CED241CED241CED241CED241CEDFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFA6A8AF686B77686B7768
      6B77686B77686B77686B77686B77686B77686B77FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFA6A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9
      B5C0B9B5A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFF686B77F7EFEAF5ECE7F4E8E2F2E5DEF1E3DB
      F0E1D8EFDFD6F2E5DEF2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9
      B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFF686B77F9F2EFC2BBB8C0B9B5BFB6B1BEB4AEBDB2ACBCB0A9BDB2
      ACF2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6
      E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B
      77FAF5F3C3BEBBFFFFFFC0B9B5FFFFFFBEB4AEFFFFFFBCB0A9EFDFD6686B77FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6
      E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B77FCF8F7C4C0BFC3
      BEBBC2BBB8C0B9B5BFB6B1BEB4AEBDB2ACF0E1D8686B77FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6
      E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFF686B77FDFBFAC6C3C2FFFFFFC3BEBBFFFFFF
      C0B9B5FFFFFFBEB4AEF1E3DB686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9
      B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFF686B77FEFEFDC6C5C4C6C3C2C4C0BFC3BEBBC2BBB8C0B9B5BFB6
      B1F2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FF
      FFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B
      77FFFFFFC7C7C6FFFFFFC6C3C2FFFFFFC3BEBBFFFFFFC0B9B5F4E8E2686B77FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6
      E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B77FFFFFFC8C8C8C7
      C7C6C6C5C4C6C3C2C4C0BFC3BEBBC2BBB8F5ECE7686B77FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6
      E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFF686B77FFFFFFFFFFFFFFFFFFFEFEFDFDFBFA
      FCF8F7FAF5F3F9F2EFF7EFEA686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9
      B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFF686B77FFFFFFC8C8C8C8C8C8C8C8C8C7C7C6C6C5C4C6C3C2C4C0
      BFF9F2EF686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFA6A8
      AF686B77686B77686B77686B77686B77686B77686B77686B77686B77A6A8AFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9B5
      C0B9B5C0B9B5C0B9B5C0B9B5A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CED241CED
      241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED24
      1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
      241CED241CED241CED241CED241CED241CED}
    ButtonWidth = 19
    NumGlyphs = 2
    ParentCtl3D = False
    ParentFont = False
    PopupColor = 15461355
    TabOrder = 1
    Visible = False
    OnExit = DBDateEdit1Exit
  end
  object DBDateEdit2: TDBDateEdit
    AlignWithMargins = True
    Left = 490
    Top = 29
    Width = 84
    Height = 19
    Margins.Top = 2
    Margins.Right = 2
    DataField = 'DatProCom'
    DataSource = SouPesUCon
    AutoSelect = False
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    DialogTitle = 'Entre com Data'
    Font.Charset = ANSI_CHARSET
    Font.Color = 2236186
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    GlyphKind = gkCustom
    Glyph.Data = {
      0E0A0000424D0E0A000000000000360000002800000028000000150000000100
      180000000000D809000000000000000000000000000000000000241CED241CED
      241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED24
      1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
      241CED241CED241CED241CED241CED241CED241CEDFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFA6A8AF686B77686B7768
      6B77686B77686B77686B77686B77686B77686B77FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFA6A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9B5C0B9
      B5C0B9B5A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFF686B77F7EFEAF5ECE7F4E8E2F2E5DEF1E3DB
      F0E1D8EFDFD6F2E5DEF2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9
      B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFF686B77F9F2EFC2BBB8C0B9B5BFB6B1BEB4AEBDB2ACBCB0A9BDB2
      ACF2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6
      E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B
      77FAF5F3C3BEBBFFFFFFC0B9B5FFFFFFBEB4AEFFFFFFBCB0A9EFDFD6686B77FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6
      E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B77FCF8F7C4C0BFC3
      BEBBC2BBB8C0B9B5BFB6B1BEB4AEBDB2ACF0E1D8686B77FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6
      E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFF686B77FDFBFAC6C3C2FFFFFFC3BEBBFFFFFF
      C0B9B5FFFFFFBEB4AEF1E3DB686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9
      B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFF686B77FEFEFDC6C5C4C6C3C2C4C0BFC3BEBBC2BBB8C0B9B5BFB6
      B1F2E5DE686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FF
      FFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B
      77FFFFFFC7C7C6FFFFFFC6C3C2FFFFFFC3BEBBFFFFFFC0B9B5F4E8E2686B77FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6
      E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFF686B77FFFFFFC8C8C8C7
      C7C6C6C5C4C6C3C2C4C0BFC3BEBBC2BBB8F5ECE7686B77FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFC0B9B5FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6E6FFFFFFE6E6
      E6FFFFFFC0B9B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFF686B77FFFFFFFFFFFFFFFFFFFEFEFDFDFBFA
      FCF8F7FAF5F3F9F2EFF7EFEA686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9
      B5FFFFFFE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6FFFFFFC0B9B5FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
      FFFFFFFFFFFF686B77FFFFFFC8C8C8C8C8C8C8C8C8C7C7C6C6C5C4C6C3C2C4C0
      BFF9F2EF686B77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0B9B5FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFA6A8
      AF686B77686B77686B77686B77686B77686B77686B77686B77686B77A6A8AFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A8AFC0B9B5C0B9B5C0B9B5C0B9B5C0B9B5
      C0B9B5C0B9B5C0B9B5C0B9B5A6A8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24
      1CED241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CED241CED
      241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED24
      1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
      241CED241CED241CED241CED241CED241CED}
    ButtonWidth = 19
    NumGlyphs = 2
    ParentCtl3D = False
    ParentFont = False
    PopupColor = 15461355
    TabOrder = 2
    Visible = False
    OnExit = DBDateEdit2Exit
  end
  object TabPesUCon: TRESTDWClientSQL
    Active = False
    AfterInsert = TabPesUConAfterInsert
    BeforePost = TabPesUConBeforePost
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDPess'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'IDProd'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CpfPBM'
        DataType = ftWideString
        Size = 14
      end
      item
        Name = 'QtdDia'
        DataType = ftFloat
        Precision = 6
      end
      item
        Name = 'DatUltCom'
        DataType = ftDate
      end
      item
        Name = 'DatProCom'
        DataType = ftDate
      end
      item
        Name = 'IDPBM'
        DataType = ftInteger
      end
      item
        Name = 'NroRegProf'
        DataType = ftWideString
        Size = 10
      end>
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
      'SELECT * FROM arqpessucon LIMIT 10'
      ''
      ''
      ''
      '')
    UpdateTableName = 'arqpessucon'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 31
    Top = 39
    object TabPesUConIDPess: TIntegerField
      FieldName = 'IDPess'
      Origin = 'arqpessucon.IDPess'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPesUConIDProd: TIntegerField
      FieldName = 'IDProd'
      Origin = 'arqpessucon.IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPesUConIDPBM: TIntegerField
      FieldName = 'IDPBM'
      Origin = 'arqpessucon.IDPBM'
    end
    object TabPesUConNroRegProf: TWideStringField
      FieldName = 'NroRegProf'
      Size = 8
    end
    object TabPesUConQtdDia: TFloatField
      FieldName = 'QtdDia'
      Origin = 'arqpessucon.QtdDia'
    end
    object TabPesUConDatUltCom: TDateField
      FieldName = 'DatUltCom'
      Origin = 'arqpessucon.DatUltCom'
    end
    object TabPesUConDatProCom: TDateField
      FieldName = 'DatProCom'
      Origin = 'arqpessucon.DatProCom'
    end
    object TabPesUConCpfPBM: TWideStringField
      FieldName = 'CpfPBM'
      Size = 14
    end
    object TabPesUConDespro: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Despro'
      LookupDataSet = TabProd
      LookupKeyFields = 'IDProd'
      LookupResultField = 'Despro'
      KeyFields = 'IDProd'
      ProviderFlags = []
      Size = 80
      Lookup = True
    end
    object TabPesUConNommed: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Nommed'
      LookupDataSet = TabMedico
      LookupKeyFields = 'NroRegProf'
      LookupResultField = 'Nompes'
      KeyFields = 'NroRegProf'
      ProviderFlags = []
      Size = 45
      Lookup = True
    end
    object TabPesUConNomPBM: TWideStringField
      FieldKind = fkLookup
      FieldName = 'NomPBM'
      LookupDataSet = TabPBM
      LookupKeyFields = 'IDPBM'
      LookupResultField = 'NomPBM'
      KeyFields = 'IDPBM'
      ProviderFlags = []
      Size = 35
      Lookup = True
    end
  end
  object SouPesUCon: TDataSource
    Left = 31
    Top = 102
  end
  object TabProd: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDProd'
        DataType = ftAutoInc
      end
      item
        Name = 'Despro'
        DataType = ftWideString
        Size = 160
      end>
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
      
        'SELECT IDProd,Despro FROM arqproduto WHERE Ativo AND Despro != '#39 +
        #39' ORDER By Despro'
      ''
      ''
      ''
      '')
    UpdateTableName = 'arqproduto'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 127
    Top = 39
    object TabProdIDProd: TFDAutoIncField
      FieldName = 'IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TabProdDespro: TWideStringField
      FieldName = 'Despro'
      Size = 160
    end
  end
  object TabMedico: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'NroRegProf'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'Nompes'
        DataType = ftWideString
        Size = 80
      end>
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
      
        'SELECT NroRegProf,Nompes FROM arqpessoa WHERE IDEsppes = 4 ORDER' +
        ' BY Nompes'
      ''
      ''
      ''
      ''
      ''
      '')
    UpdateTableName = 'arqpessoa'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 215
    Top = 39
    object TabMedicoNroRegProf: TWideStringField
      FieldName = 'NroRegProf'
      Size = 10
    end
    object TabMedicoNompes: TWideStringField
      FieldName = 'Nompes'
      Size = 80
    end
  end
  object TabPBM: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDPBM'
        DataType = ftSmallint
      end
      item
        Name = 'NomPBM'
        DataType = ftWideString
        Size = 46
      end>
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
      'SELECT * FROM arqpbm ORDER BY Nompbm')
    UpdateTableName = 'arqpessoa'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 287
    Top = 39
    object TabPBMIDPBM: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDPBM'
      Origin = 'arqpbm.IDPBM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPBMNomPBM: TWideStringField
      FieldName = 'NomPBM'
      Size = 46
    end
  end
end
