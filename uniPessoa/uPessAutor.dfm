object FrmPesAutor: TFrmPesAutor
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Pessoas Autorizadas'
  ClientHeight = 161
  ClientWidth = 983
  Color = 15855599
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object DBGrid1: TDBGrid
    Tag = 1
    AlignWithMargins = True
    Left = 0
    Top = 3
    Width = 983
    Height = 158
    Margins.Left = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    DataSource = SouPesAutor
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
        FieldName = 'Nomaut'
        Title.Alignment = taCenter
        Title.Caption = 'Nome da Pessoa Autorizada'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 180
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CPFaut'
        Title.Alignment = taCenter
        Title.Caption = 'CPF'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RGEaut'
        Title.Alignment = taCenter
        Title.Caption = 'RG / Emissor'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 86
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CelularAut'
        Title.Alignment = taCenter
        Title.Caption = 'Celular'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'GraParAut'
        PickList.Strings = (
          'FILHO(A)'
          'ESPOSO(A)'
          'M'#195'E'
          'PAI'
          'IRM'#195'OS'
          'AV'#211'S'
          'OUTROS')
        Title.Alignment = taCenter
        Title.Caption = 'Parentesco'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 102
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DatnasAut'
        Title.Alignment = taCenter
        Title.Caption = 'Nascimento'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 91
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SitAutor'
        PickList.Strings = (
          'AUTORIZADO'
          'BLOQUEADO')
        Title.Alignment = taCenter
        Title.Caption = 'Situa'#231'ao'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Obsautor'
        Title.Alignment = taCenter
        Title.Caption = 'Observa'#231#245'es'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = 5131854
        Title.Font.Height = -13
        Title.Font.Name = 'Roboto'
        Title.Font.Style = []
        Width = 178
        Visible = True
      end
      item
        Expanded = False
        ReadOnly = True
        Width = 21
        Visible = True
      end>
  end
  object DBDateEdit1: TDBDateEdit
    AlignWithMargins = True
    Left = 580
    Top = 26
    Width = 89
    Height = 19
    Margins.Top = 2
    Margins.Right = 2
    DataField = 'DatnasAut'
    DataSource = SouPesAutor
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
  object TabPesAutor: TRESTDWClientSQL
    Active = False
    AfterInsert = TabPesAutorAfterInsert
    BeforePost = TabPesAutorBeforePost
    AfterPost = TabPesAutorAfterPost
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
      'SELECT * FROM arqpessauto LIMIT 10'
      ''
      ''
      '')
    UpdateTableName = 'arqpessauto'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 47
    Top = 63
    object TabPesAutorIDPess: TIntegerField
      FieldName = 'IDPess'
      Origin = 'arqpessauto.IDPess'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPesAutorIDAuto: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDAuto'
      Origin = 'arqpessauto.IDAuto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPesAutorCelularAut: TWideStringField
      FieldName = 'CelularAut'
      Size = 14
    end
    object TabPesAutorDatnasAut: TDateField
      FieldName = 'DatnasAut'
      Origin = 'arqpessauto.DatnasAut'
      EditMask = '!99/99/0000;1;_'
    end
    object TabPesAutorCPFaut: TWideStringField
      FieldName = 'CPFaut'
      Size = 14
    end
    object TabPesAutorRGEaut: TWideStringField
      FieldName = 'RGEaut'
    end
    object TabPesAutorGraParAut: TWideStringField
      FieldName = 'GraParAut'
      Size = 16
    end
    object TabPesAutorSitAutor: TWideStringField
      FieldName = 'SitAutor'
      Size = 13
    end
    object TabPesAutorObsautor: TWideStringField
      FieldName = 'Obsautor'
      Size = 106
    end
    object TabPesAutorNomaut: TWideStringField
      FieldName = 'Nomaut'
      Size = 53
    end
  end
  object SouPesAutor: TDataSource
    DataSet = TabPesAutor
    Left = 143
    Top = 62
  end
end
