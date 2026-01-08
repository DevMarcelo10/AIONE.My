object FrmPesConv: TFrmPesConv
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Pessoas Convenios'
  ClientHeight = 148
  ClientWidth = 985
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
  object DBGridEx1: TDBGridEx
    Left = 0
    Top = 0
    Width = 985
    Height = 148
    Align = alClient
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    DataSource = SouPessConv
    FixedColor = 15790320
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Roboto'
    TitleFont.Style = [fsBold]
    OnCellClick = DBGridEx1CellClick
    OnColEnter = DBGridEx1ColEnter
    OnKeyDown = DBGridEx1KeyDown
    Images = DM.ImagesGer
    RowHeightEx = 23
    SelectionColor = 15265791
    SelectionTextColor = clBlack
    CheckedImage.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000140000
      001408060000008D891D0D000000097048597300000B1300000B1301009A9C18
      000001394944415478DAADD4BB4A034114C6F119D0A490345E1E43B00C12D20B
      8AC6262A04F2025A58254125AB787980A44D9958788990107D01DFC0CAD64E04
      2B6F08EBFFB0B3B24882339B3DF083ECCEEEB7B333D9A37DDF5749969640ADF5
      04BF0F50C1A463C617CE7044D6771878C8897D74D03717D9540ACBD88047563D
      0C94800B6CC57C5399C83A59E93050167213E73103E5DE36593A1AB8861B8B9B
      675046131FE6DC2ABA71033B66CD6A381D3750AEB9C613E6F13A4EE02C1E3087
      25DC45C6AC028B9842CB1C5FCA4EA281ED3F0FFB3750E319D3D8C18BEC221EB1
      8037D740A91C066696EF48238FFB21CB61BD868BB84546059F5775C4FA3A6D4A
      1625ECE23389409B1A1A98E8A727AF726506E2944CA4106D0E9E0AFAA10CF494
      5BFB5A51C17FB64E96176DB07B2AD8C594E3ECE4E12738FE6DB049D60F5A6AC5
      D96A12D7080000000049454E44AE426082}
    UncheckedImage.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000140000
      001408060000008D891D0D000000097048597300000B1300000B1301009A9C18
      000000B14944415478DAED94490A0231104553E07039C561A3ED4914543A8AE2
      49D48588821E4E11E22B4C244B137A677F785064789D0EA4C43967AA8CA85044
      1AD44B984233D1F1841DAC71BD8270C5C0020E70F78B7E490B3A30068BAB0C42
      159CA827C9BF2862FC4186EC6F07A15E64417DCC1416B067BFC4C23EF53553D8
      834B2DAC857F21ACF4E93D1838FB899CE841067173B0E6D30F75E266D2DA5717
      4650E2B271839DC3CC2F4A897E7C0B9B6F83AD326FDD4FD4D93C582B88000000
      0049454E44AE426082}
    UseDateEditor = True
    Columns = <
      item
        Expanded = False
        FieldName = 'Nomcon'
        Title.Alignment = taCenter
        Title.Caption = 'IDENTIFICA'#199#195'O DO CONV'#202'NIO'
        Width = 322
        Visible = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DatcadCon'
        Title.Alignment = taCenter
        Title.Caption = 'CADASTRO'
        Width = 93
        Visible = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      item
        Expanded = False
        FieldName = 'NroMatric'
        Title.Alignment = taCenter
        Title.Caption = 'MATR'#205'CULA'
        Width = 105
        Visible = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      item
        Expanded = False
        FieldName = 'NroCartao'
        Title.Alignment = taCenter
        Title.Caption = 'NRO. CART'#195'O'
        Width = 124
        Visible = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      item
        Expanded = False
        FieldName = 'VlrLimite'
        Title.Alignment = taCenter
        Title.Caption = 'VLR.LIMITE'
        Width = 83
        Visible = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      item
        Expanded = False
        FieldName = 'NomFilCli'
        Title.Alignment = taCenter
        Title.Caption = 'FILIAL PERTENCENTE'
        Width = 164
        Visible = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IndAtivo'
        Title.Alignment = taCenter
        Title.Caption = 'ATIVO'
        Width = 44
        Visible = True
        CheckBox = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      item
        Alignment = taCenter
        Expanded = False
        Title.Alignment = taCenter
        Width = 21
        Visible = True
        ImageIndex = 0
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end>
    RowHeightExStored = 23
  end
  object TabPessConv: TRESTDWClientSQL
    Active = False
    AfterInsert = TabPessConvAfterInsert
    BeforePost = TabPessConvBeforePost
    AfterScroll = TabPessConvAfterScroll
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'SELECT * FROM arqpessconv LIMIT 10'
      ''
      ''
      ''
      '')
    UpdateTableName = 'arqpessconv'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 39
    Top = 31
    object TabPessConvIDPess: TIntegerField
      FieldName = 'IDPess'
      Origin = 'arqpessconv.IDPess'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPessConvIDConv: TIntegerField
      FieldName = 'IDConv'
      Origin = 'arqpessconv.IDConv'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPessConvVlrLimite: TFloatField
      FieldName = 'VlrLimite'
      Origin = 'arqpessconv.VlrLimite'
      DisplayFormat = '###,##0.00'
    end
    object TabPessConvCNPJFil: TWideStringField
      FieldName = 'CNPJFil'
      LookupDataSet = TabConvCli
      LookupKeyFields = 'CNPJFil'
      LookupResultField = 'Nomfil'
      Size = 14
    end
    object TabPessConvDatcadCon: TDateField
      FieldName = 'DatcadCon'
    end
    object TabPessConvNroMatric: TWideStringField
      FieldName = 'NroMatric'
      Size = 24
    end
    object TabPessConvNroCartao: TWideStringField
      FieldName = 'NroCartao'
      Size = 24
    end
    object TabPessConvIndAtivo: TWideStringField
      FieldName = 'IndAtivo'
      Size = 1
    end
    object TabPessConvNomcon: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Nomcon'
      LookupDataSet = TabConv
      LookupKeyFields = 'IDConv'
      LookupResultField = 'Nomcon'
      KeyFields = 'IDConv'
      ProviderFlags = []
      Size = 45
      Lookup = True
    end
    object TabPessConvNomFilCli: TWideStringField
      FieldKind = fkLookup
      FieldName = 'NomFilCli'
      LookupDataSet = TabConvCli
      LookupKeyFields = 'CNPJFil'
      LookupResultField = 'Nomfil'
      KeyFields = 'CNPJFil'
      ProviderFlags = []
      Size = 45
      Lookup = True
    end
  end
  object SouPessConv: TDataSource
    DataSet = TabPessConv
    Left = 39
    Top = 86
  end
  object SouConv: TDataSource
    Left = 127
    Top = 86
  end
  object TabConv: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDConv'
        DataType = ftAutoInc
      end
      item
        Name = 'Nomcon'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'IDPessPri'
        DataType = ftInteger
      end
      item
        Name = 'TipConv'
        DataType = ftWideString
        Size = 12
      end
      item
        Name = 'DiaFecha'
        DataType = ftSmallint
      end
      item
        Name = 'DiaVence'
        DataType = ftSmallint
      end
      item
        Name = 'PerJurAtr'
        DataType = ftFloat
        Precision = 8
      end
      item
        Name = 'IndDesVenVis'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndDesVenPra'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndRepCom'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndPreProm'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndDesProg'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndLibLim'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndSolSen'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndVenVis'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndVenPra'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndPonFid'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'NroDiaCar'
        DataType = ftSmallint
      end
      item
        Name = 'NroMaxPar'
        DataType = ftSmallint
      end
      item
        Name = 'PraParBlo'
        DataType = ftSmallint
      end
      item
        Name = 'LimCreCli'
        DataType = ftFloat
        Precision = 9
      end
      item
        Name = 'VlrMinCup'
        DataType = ftFloat
        Precision = 9
      end
      item
        Name = 'IDDesc'
        DataType = ftInteger
      end
      item
        Name = 'ObsNFC'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Codban'
        DataType = ftInteger
      end
      item
        Name = 'AgeBco'
        DataType = ftWideString
        Size = 6
      end
      item
        Name = 'DigAgeBco'
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'ContaBco'
        DataType = ftWideString
        Size = 12
      end
      item
        Name = 'DigitoBco'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'CodCedBco'
        DataType = ftWideString
        Size = 12
      end
      item
        Name = 'CodTraBco'
        DataType = ftWideString
        Size = 25
      end
      item
        Name = 'MaxNroBco'
        DataType = ftInteger
      end
      item
        Name = 'UltNosNBco'
        DataType = ftInteger
      end
      item
        Name = 'ModCobBco'
        DataType = ftWideString
        Size = 3
      end
      item
        Name = 'CarCobBco'
        DataType = ftWideString
        Size = 3
      end
      item
        Name = 'AceiteBco'
        DataType = ftBoolean
      end
      item
        Name = 'PerMulBco'
        DataType = ftFloat
        Precision = 6
      end
      item
        Name = 'PerMorBco'
        DataType = ftFloat
        Precision = 6
      end
      item
        Name = 'EmailWeb'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'SenhaWeb'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'DatcadCon'
        DataType = ftDateTime
      end
      item
        Name = 'IndAtivo'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'Obscon'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'IndDelete'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'IndDelWeb'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'DatHorAlt'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'SELECT * FROM arqconvenio WHERE IndAtivo = '#39'1'#39' ORDER BY Nomcon'
      ''
      ''
      '')
    UpdateTableName = 'arqconvenio'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 127
    Top = 31
    object TabConvIDConv: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDConv'
    end
    object TabConvNomcon: TWideStringField
      FieldName = 'Nomcon'
      Size = 40
    end
  end
  object TabConvCli: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDConv'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CNPJFil'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 14
      end
      item
        Name = 'Nomfil'
        DataType = ftWideString
        Size = 45
      end
      item
        Name = 'NomRed'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'Endfil'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'NroEnd'
        DataType = ftWideString
        Size = 8
      end
      item
        Name = 'CompEnd'
        DataType = ftWideString
        Size = 35
      end
      item
        Name = 'Baifil'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Codmun'
        DataType = ftInteger
      end
      item
        Name = 'CEPFil'
        DataType = ftWideString
        Size = 8
      end
      item
        Name = 'InsEstFil'
        DataType = ftWideString
        Size = 18
      end
      item
        Name = 'FoneFil'
        DataType = ftWideString
        Size = 11
      end
      item
        Name = 'Nomcon'
        DataType = ftWideString
        Size = 35
      end
      item
        Name = 'IndAtivo'
        DataType = ftBoolean
      end
      item
        Name = 'IndDelete'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 1
      end
      item
        Name = 'DatHorAlt'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
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
      'SELECT * FROM arqconvfilcli LIMIT 10'
      ''
      '')
    UpdateTableName = 'arqconvfilcli'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 199
    Top = 31
    object TabConvCliIDConv: TIntegerField
      FieldName = 'IDConv'
      Required = True
    end
    object TabConvCliCNPJFil: TWideStringField
      FieldName = 'CNPJFil'
      Required = True
      Size = 14
    end
    object TabConvCliNomfil: TWideStringField
      FieldName = 'Nomfil'
      Size = 45
    end
  end
  object SouConvCli: TDataSource
    AutoEdit = False
    DataSet = TabConvCli
    Left = 199
    Top = 94
  end
end
