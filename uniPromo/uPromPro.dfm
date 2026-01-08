object FrmPromPro: TFrmPromPro
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'Promocoes de Produtos'
  ClientHeight = 273
  ClientWidth = 1006
  Color = clWhite
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
  object LMDSimplePanel2: TLMDSimplePanel
    Left = 0
    Top = 0
    Width = 1006
    Height = 273
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderWidth = 1
    Color = 16447736
    TabOrder = 0
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 6
      Width = 1004
      Height = 236
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouPromPro
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnTitleClick = DBGrid1TitleClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'IDProd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'DIGO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 58
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
          Title.Font.Style = []
          Width = 278
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CalcNrolot'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'LOTE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qtdest'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'ESTOQ.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 51
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Cusmed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'CUS.M'#201'DIO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UltPreCom'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'P.COMPRA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 66
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
          Title.Font.Style = []
          Width = 67
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CalcDescM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'DESC.M.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 59
          Visible = True
        end
        item
          Alignment = taCenter
          Color = 15397375
          Expanded = False
          FieldName = 'CalcDescIA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Title.Alignment = taCenter
          Title.Caption = 'DESC.IA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 58
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CalcMarkup'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'MARKUP'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PrePromo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          Title.Alignment = taCenter
          Title.Caption = 'PROMO'#199#195'O'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          Width = 22
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Width = 22
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IndSel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 22
          Visible = True
        end>
    end
    object btNovoItem: TAdvGlowButton
      AlignWithMargins = True
      Left = 962
      Top = 3
      Width = 23
      Height = 29
      Cursor = crHandPoint
      Hint = 'Adiciona Produto / Lote'
      Margins.Top = 1
      Margins.Bottom = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -13
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
        89504E470D0A1A0A0000000D49484452000000180000001810040000001AEE29
        30000000206348524D00007A26000080840000FA00000080E8000075300000EA
        6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
        485973000000600000006000F06B42CF0000000774494D4507E709050D20086E
        DC2C1A000001D14944415448C7ED55BF4BC35010FE5E5189D04883A3B8A943A8
        1462C8130CE8E8A8160445B00D8243FD235C9D15A1204817077F555C1C5C2A28
        88A688833AE45F506AB49060C573D0965AF2C308E2E2B7BDBB7B77F77DEFB807
        FC2304CCCFA1CE2593B11E45612541084A4063AE4BBDE5F2E5D2CDCDB70A6856
        57173B2E1450989888D229ADECEFB7A73399B387E7E7C040BE5E2C72DDB6792E
        9B4D5122119638458984661906D76D9B4BBBBB81C1EA5C32C93911A74C26AAD6
        9A65189C1369962C37DB635F0E3D8A02002E0E0EBC928C523C3E4AF1B897AF23
        5B2C02005386867C0BD41FF49A3D3E7A2571AD7CDEB5F2792FDFE969A5020090
        3B3B9BED6D5164205314A34A178B7A212A02198C748BE2EBEADA1AA44FDA831F
        FAF2A3ED6D0040C57184995CEE8455AB3F62D0764FF4AB0C3E3A9B9FAF9FB5AD
        C34300B8989D9E6E04CD0617F8DB3768055343D64058011A735D5602745D921A
        73DD04A17F71D12F91AE4B52AD06E0D6717C25A2DE7219006A29EF4577C2AA55
        BF897991A6A60080F599662025ADB4B7C775DBD62CC3F8EEB21B9E5C58E0ECE9
        A931BECDB2B61A46BA45F1F56D731303E97424B19777768471C36865E8FBE168
        962C634355C33E1CDC3A0EEB33CDF3ABBBBB480DFDA38E777C35A04A2865A9FE
        0000000049454E44AE426082}
      Rounded = True
      Spacing = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btNovoItemClick
      Appearance.BorderColor = 14674687
      Appearance.BorderColorHot = 14674687
      Appearance.BorderColorCheckedHot = 14674687
      Appearance.BorderColorDown = 14674687
      Appearance.BorderColorChecked = 14674687
      Appearance.BorderColorDisabled = 14674687
      Appearance.BorderColorFocused = 14674687
      Appearance.Color = 14674687
      Appearance.ColorTo = 14674687
      Appearance.ColorChecked = 14674687
      Appearance.ColorCheckedTo = 14674687
      Appearance.ColorDisabled = 14674687
      Appearance.ColorDisabledTo = 14674687
      Appearance.ColorDown = 14674687
      Appearance.ColorDownTo = 14674687
      Appearance.ColorHot = 14674687
      Appearance.ColorHotTo = 14674687
      Appearance.ColorMirror = 14674687
      Appearance.ColorMirrorTo = 14674687
      Appearance.ColorMirrorHot = 14674687
      Appearance.ColorMirrorHotTo = 14674687
      Appearance.ColorMirrorDown = 14674687
      Appearance.ColorMirrorDownTo = 14674687
      Appearance.ColorMirrorChecked = 14674687
      Appearance.ColorMirrorCheckedTo = 14674687
      Appearance.ColorMirrorDisabled = 14674687
      Appearance.ColorMirrorDisabledTo = 14674687
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
    object LMDSimplePanel1: TLMDSimplePanel
      Left = 1
      Top = 243
      Width = 1004
      Height = 29
      Align = alBottom
      Color = 16052464
      TabOrder = 1
      object Label4: TLabel
        Left = 7
        Top = 10
        Width = 193
        Height = 13
        Alignment = taRightJustify
        Caption = 'DESCONTO GERAL EM TODA SELE'#199#195'O'
        Font.Charset = ANSI_CHARSET
        Font.Color = 7039851
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object btExcluir: TAdvGlowButton
        AlignWithMargins = True
        Left = 827
        Top = 3
        Width = 174
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 2
        Margins.Bottom = 1
        Caption = 'Eliminar todos marcados'
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
        TabOrder = 3
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
      object edPerDesc: TCurrencyEdit
        AlignWithMargins = True
        Left = 203
        Top = 5
        Width = 82
        Height = 20
        Margins.Left = 2
        Margins.Top = 0
        Margins.Bottom = 0
        AutoSelect = False
        AutoSize = False
        Color = clWhite
        Ctl3D = True
        DisplayFormat = '###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        FormatOnEditing = True
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        OnExit = edPerDescExit
      end
      object btDescExe: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 460
        Top = 3
        Width = 108
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Aplicar Desconto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5066061
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        MarginVert = 0
        MarginHorz = 0
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -12
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Rounded = True
        TabOrder = 2
        OnClick = btDescExeClick
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
        Layout = blGlyphTop
      end
      object LMDSimplePanel11: TLMDSimplePanel
        Left = 291
        Top = 5
        Width = 163
        Height = 20
        Color = 16447736
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TabStop = True
        object Label37: TLabel
          Left = 20
          Top = 5
          Width = 68
          Height = 13
          Caption = 'PERCENTUAL'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label39: TLabel
          Left = 121
          Top = 5
          Width = 35
          Height = 13
          Caption = 'VALOR'
          Color = 16514043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object RadioPerc: TLMDRadioButton
          Left = 2
          Top = 4
          Width = 14
          Height = 14
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'RadioRadio'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
        end
        object RadioValor: TLMDRadioButton
          Left = 103
          Top = 4
          Width = 14
          Height = 14
          Alignment.Alignment = agTopLeft
          Alignment.Spacing = 4
          Checked = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = True
        end
      end
    end
  end
  object TabPromPro: TRESTDWClientSQL
    Active = False
    AutoCalcFields = False
    OnCalcFields = TabPromProCalcFields
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
      'SELECT PRM.*,PRO.Despro FROM arqpromopro PRM '
      'LEFT JOIN arqproduto PRO ON PRM.IDProd = PRO.IDProd'
      'LIMIT 10')
    UpdateTableName = 'arqpromopro'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = False
    Left = 51
    Top = 111
    object TabPromProIDProm: TIntegerField
      FieldName = 'IDProm'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPromProIDProd: TIntegerField
      FieldName = 'IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPromProNrolot: TWideStringField
      FieldName = 'Nrolot'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 26
    end
    object TabPromProQtdest: TFloatField
      FieldName = 'Qtdest'
      DisplayFormat = '###,##0.00'
    end
    object TabPromProPrecoVen: TFloatField
      FieldName = 'PrecoVen'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPromProCusmed: TFloatField
      FieldName = 'Cusmed'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPromProUltPreCom: TFloatField
      FieldName = 'UltPreCom'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPromProPrePromo: TFloatField
      FieldName = 'PrePromo'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPromProPerDesMan: TFloatField
      FieldName = 'PerDesMan'
      DisplayFormat = '##0.00'
    end
    object TabPromProPerDesIA: TFloatField
      FieldName = 'PerDesIA'
      DisplayFormat = '##0.00'
    end
    object TabPromProIndSel: TWideStringField
      FieldName = 'IndSel'
      Size = 1
    end
    object TabPromProCalcNrolot: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CalcNrolot'
      ProviderFlags = []
      Calculated = True
    end
    object TabPromProCalcDescIA: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CalcDescIA'
      ProviderFlags = []
      Size = 12
      Calculated = True
    end
    object TabPromProCalcDescM: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CalcDescM'
      ProviderFlags = []
      Size = 12
      Calculated = True
    end
    object TabPromProDespro: TWideStringField
      FieldName = 'Despro'
      ProviderFlags = []
      Size = 160
    end
    object TabPromProCalcMarkup: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CalcMarkup'
      ProviderFlags = []
      Size = 12
      Calculated = True
    end
  end
  object SouPromPro: TDataSource
    AutoEdit = False
    DataSet = TabPromPro
    Left = 54
    Top = 174
  end
end
