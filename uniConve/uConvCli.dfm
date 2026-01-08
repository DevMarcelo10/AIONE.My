object FrmConPesAti: TFrmConPesAti
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Convenios Pessoas Ativas'
  ClientHeight = 263
  ClientWidth = 545
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object PanelTop: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 545
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 11974326
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 15461355
    TabOrder = 0
    DesignSize = (
      545
      25)
    object LMDLabel4: TLMDLabel
      Left = 181
      Top = 6
      Width = 183
      Height = 16
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5592405
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'CLIENTES ATIVOS NO CONV'#202'NIO'
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 525
      Top = 4
      Width = 16
      Height = 16
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      Anchors = [akTop, akRight]
      AntiAlias = aaAntiAlias
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Font.Quality = fqClearType
      MarginVert = 0
      MarginHorz = 0
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
        F80000000473424954080808087C086488000000097048597300000EC400000E
        C401952B0E1B0000001974455874536F667477617265007777772E696E6B7363
        6170652E6F72679BEE3C1A000001A4494441544889DD55BD6EC230183C3BCAC2
        806029EAD82E45A8EF50178385C4ECF7C9339427E9408510813C44855421C158
        85A1440C0C50EC2E409D7F33B6B7C4FEECEFCE67FB8B817F07C6584D4AE95C9B
        27A5741863B5649C9A9D6EB73B705D771345D18273DEB225E79CB7A2285AB8AE
        BB1142BC9863E4DCE8F7FBF5FD7EFF658C854AA9B6EFFBF332724AE91440E31C
        3B1C0EF52008A298834AA5B205B032721B94D26991932C72004BC6D836E50000
        7ABDDEC3F1789C01B835C26B42081F8FC7EFE65C2144536B3D2D9B1B13B015B1
        25CF14281301F06D4B9E2B00E4EE6F78FAC66245972157A0C08989DC955B0994
        889492038942CB8252AA741145284CCEB92D264A5DE43AE09CB7B4D641823CC4
        EF4103C08DD67A52548C9902428826A57482F86D5913423A8EE33C01F834E20D
        4AE94C08F198C595DA229B22BAA6E26302D754A8ADC8658BA4948ED6FA2D9110
        2AA59EB30E71341A7D28A53A489FC9ABE77917DE4B63B7DB5501DC25C80B7FD7
        BEEFCF9552ED84C87D1004D594C07038DC104206A7EED2E62D4888AC00801032
        38BF0599608CD54C8BB6F03C8F663D997F1F3F86FC04F06B55E1DB0000000049
        454E44AE426082}
      Rounded = False
      Spacing = 0
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = btFecharClick
      Appearance.BorderColor = 15461355
      Appearance.BorderColorHot = 15461355
      Appearance.BorderColorCheckedHot = 15461355
      Appearance.BorderColorDown = 15461355
      Appearance.BorderColorChecked = 15461355
      Appearance.BorderColorDisabled = 15461355
      Appearance.BorderColorFocused = 15461355
      Appearance.Color = 15461355
      Appearance.ColorTo = 15461355
      Appearance.ColorChecked = 15461355
      Appearance.ColorCheckedTo = 15461355
      Appearance.ColorDisabled = 15461355
      Appearance.ColorDisabledTo = 15461355
      Appearance.ColorDown = 15461355
      Appearance.ColorDownTo = 15461355
      Appearance.ColorHot = 15461355
      Appearance.ColorHotTo = 15461355
      Appearance.ColorMirror = 15461355
      Appearance.ColorMirrorTo = 15461355
      Appearance.ColorMirrorHot = 15461355
      Appearance.ColorMirrorHotTo = 15461355
      Appearance.ColorMirrorDown = 15461355
      Appearance.ColorMirrorDownTo = 15461355
      Appearance.ColorMirrorChecked = 15461355
      Appearance.ColorMirrorCheckedTo = 15461355
      Appearance.ColorMirrorDisabled = 15461355
      Appearance.ColorMirrorDisabledTo = 15461355
      Appearance.TextColorChecked = 3191038
      Appearance.TextColorHot = 15234048
      Appearance.TextColorDisabled = 3191038
    end
  end
  object PanelCadastro: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 26
    Width = 545
    Height = 237
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 11974326
    Bevel.BorderWidth = 1
    Bevel.EdgeStyle = etRaised
    Color = clWhite
    TabOrder = 1
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 2
      Top = 1
      Width = 541
      Height = 234
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouPess
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'Nompes'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO BARRAS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 400
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CpfCnpjPes'
          Width = 120
          Visible = True
        end>
    end
  end
  object SouPess: TDataSource
    AutoEdit = False
    DataSet = TabPess
    Left = 103
    Top = 127
  end
  object TabPess: TRESTDWClientSQL
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
      
        'SELECT PES.Nompes,PES.CpfCnpjPes FROM arqpessconv PEC LEFT JOIN ' +
        'arqpessoa PES'
      
        'ON PEC.IDPess = PES.IDPess WHERE PEC.IDConv = 1 AND IndAtivo = '#39 +
        '1'#39
      '')
    UpdateTableName = 'arqconvglim'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 31
    Top = 127
    object TabPessNompes: TWideStringField
      FieldName = 'Nompes'
      Size = 106
    end
    object TabPessCpfCnpjPes: TWideStringField
      FieldName = 'CpfCnpjPes'
      Size = 18
    end
  end
end
