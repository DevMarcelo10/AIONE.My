object FrmTransmite: TFrmTransmite
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'SNGPC - Transmite / Gerar'
  ClientHeight = 342
  ClientWidth = 346
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelTop: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 346
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 9276813
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 15066597
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    DesignSize = (
      346
      25)
    object LMDLabel4: TLMDLabel
      AlignWithMargins = True
      Left = 4
      Top = 5
      Width = 319
      Height = 16
      Margins.Top = 4
      Margins.Right = 22
      Align = alTop
      Alignment = agCenter
      Color = 15066597
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5855577
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'TRANSMITE / GERAR SNGPC'
      ExplicitLeft = 76
      ExplicitTop = 9
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 327
      Top = 5
      Width = 15
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
      HotPicture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000EC49
        444154388DC5D1314EC3401005D0B70837744839834B52C0052C5CD023C119A0
        A1C931525021AE00127D04C90DA0085DEE10899E0599C298C4F6BAA2C8AF5633
        F3FFFE3FC3AE119A4775EB5E908B2EC2C43A355C4D8D641EB10A37AE606F4B2A
        472133AFA64603E4390A95BCA96F0432E778C35866B12D52DD399499618CA52F
        97BD087F839F9E0527588A4A07BE452F386E6ADB115B021DABF56F35C6297252
        20E1C410B9BD832E425ABC3FF6CF082D07BD6D47A54CA1F2AABE4EEFC4A1451E
        D876A7F72E3A6D7A1B07D1538A0CE1DA87E8EC37D2917D0FA9082B2C86B61D26
        D6A2120BC1AADBDF1D7E00403362526997B3F70000000049454E44AE426082}
      MarginVert = 0
      MarginHorz = 0
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000F949
        444154388DC591314AC4401885BFDF3981B06748690A2D534C3085BDA067F046
        5E41C15E740321A4D462ED7287052F90E159985992CD04B1DABF1AFEFFBDC77B
        6FE0D463F1E1BD7F949499D95DD334FB14D87BBF91F42CA96FDBF601E02C1E25
        65402969EBBDDFAC90B740696659DC1F044208B7C027904BAAA72245519C4B7A
        0572606766F78B0811E89C7B03AE4660350C4370CEBD039771378D381338B29A
        03BB719DA7C849818413D6C8B30E129314FF13F4DF08330789B6AB1042097CF0
        FB3B8B2FB62979ADEDA3DB97995DC7DBC18173EE254506E8BAEEDBCC6EC64817
        929E161124F592EAB5B69BA6D99B5925A906FA459B279B1FB6F08F86D2B14DA1
        0000000049454E44AE426082}
      Rounded = False
      Spacing = 3
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = btFecharClick
      Appearance.BorderColor = 15066597
      Appearance.BorderColorHot = 15066597
      Appearance.BorderColorCheckedHot = 15066597
      Appearance.BorderColorDown = 15066597
      Appearance.BorderColorChecked = 15066597
      Appearance.BorderColorDisabled = 15066597
      Appearance.BorderColorFocused = 15066597
      Appearance.Color = 15066597
      Appearance.ColorTo = 15066597
      Appearance.ColorChecked = 15066597
      Appearance.ColorCheckedTo = 15066597
      Appearance.ColorDisabled = 15066597
      Appearance.ColorDisabledTo = 15066597
      Appearance.ColorDown = 15066597
      Appearance.ColorDownTo = 15066597
      Appearance.ColorHot = 15066597
      Appearance.ColorHotTo = 15066597
      Appearance.ColorMirror = 15066597
      Appearance.ColorMirrorTo = 15066597
      Appearance.ColorMirrorHot = 15066597
      Appearance.ColorMirrorHotTo = 15066597
      Appearance.ColorMirrorDown = 15066597
      Appearance.ColorMirrorDownTo = 15066597
      Appearance.ColorMirrorChecked = 15066597
      Appearance.ColorMirrorCheckedTo = 15066597
      Appearance.ColorMirrorDisabled = 15066597
      Appearance.ColorMirrorDisabledTo = 15066597
      Appearance.TextColorChecked = 3191038
      Appearance.TextColorHot = 15234048
      Appearance.TextColorDisabled = 3191038
    end
  end
  object PanelCadastro: TLMDSimplePanel
    Left = 0
    Top = 129
    Width = 346
    Height = 213
    Margins.Top = 1
    Margins.Right = 0
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 4934475
    Bevel.BorderWidth = 1
    Bevel.EdgeStyle = etRaised
    Color = clWhite
    TabOrder = 1
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 342
      Height = 209
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouSNGPC
      DrawingStyle = gdsGradient
      FixedColor = 16447736
      GradientEndColor = 16447736
      GradientStartColor = 16447736
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
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
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DataIni'
          Title.Alignment = taCenter
          Title.Caption = 'DATA INICIAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DataFin'
          Title.Alignment = taCenter
          Title.Caption = 'DATA FINAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TipoStr'
          Title.Alignment = taCenter
          Title.Caption = 'TIPO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 102
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -11
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 20
          Visible = True
        end>
    end
  end
  object LMDSimplePanel1: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 28
    Width = 346
    Height = 98
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 9276813
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = clWhitesmoke
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    object LMDLabel1: TLMDLabel
      Left = 13
      Top = 16
      Width = 69
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'DATA INICIAL'
    end
    object LMDLabel2: TLMDLabel
      Left = 122
      Top = 16
      Width = 62
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9600112
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentFont = False
      Caption = 'DATA FINAL'
    end
    object btExcluir: TAdvGlowButton
      AlignWithMargins = True
      Left = 856
      Top = 90
      Width = 80
      Height = 24
      Cursor = crHandPoint
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
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
        89504E470D0A1A0A0000000D494844520000000E00000010080600000026944E
        3A000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
        00097048597300000EC100000EC101B8916BED0000001974455874536F667477
        617265007777772E696E6B73636170652E6F72679BEE3C1A000000F249444154
        384FBD52BB0E824010BC2381C2C61FB220563E626CE8EDF8240A3A7B1B42E849
        F4874C8C0590C39993C5E334964CB2ECB13773B32CA76687E6234DD3651445C7
        A6692E799E3FED8E077016E024E014E0DC031629423A235724B0E66210555892
        43AEB2423A21D588D8173BA218510FDC77AB04096118965AEB355E6FC6986DD7
        75466A7DDF5F11BB2CCB1EE48F42C23FDD163F4E7BF7FB2742C27356BE93C07E
        E33FE080AFC38989505A1DDCD82A63150441C93D72043F8723EDB9C301C50E4C
        5AB68EBE53DBB61B12380CAC0FAC2126CE720112A49FD3E39A352CE53F933B5E
        8002E9E48B048E981C726787522F1F809DFB1F94CBFE0000000049454E44AE42
        6082}
      Rounded = True
      Spacing = 1
      TabOrder = 1
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
    object btSalvar: TAdvGlowButton
      AlignWithMargins = True
      Left = 856
      Top = 120
      Width = 80
      Height = 24
      Cursor = crHandPoint
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Salvar'
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
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000010449
        444154388DD592B14A03411445CF5B97510982588B24B67E80A228581A2CFD07
        1B6176D560CAC172777B1B3B7F41B40A4A14D1C2BFB04E040D06D47D16496031
        D990ADC45BCE70EF390303FF32CE39E39C33007ED1723D08CA9DD75643852EB0
        E2152D7F92DE282CA3BC004C3C7062EDD2376943A00CDC7B66660F40262DA7A2
        3D72AF5C8DA2E80D600AA016DAFAFADAEAF6C3E3D3DD28ED2FD15BA00234F1CD
        4E1CC7EF837B0F40550F81D3E3C09E65AD066FEE6B37F14D3549924E162000B5
        E06043F1AE813981F3D2FCC2FE47BBBD98A73D34007064ED96885E0125E04261
        731C7968E0B749FF28973C7220637209FA8C3FBD9B471E9B300C679D73853ED9
        DFE5070E00657C15F09B390000000049454E44AE426082}
      Rounded = True
      Spacing = 4
      TabOrder = 0
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
    object btNovo: TAdvGlowButton
      AlignWithMargins = True
      Left = 856
      Top = 60
      Width = 80
      Height = 24
      Cursor = crHandPoint
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Novo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      MarginHorz = 3
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC300000EC301C76FA8640000001974455874536F
        667477617265007777772E696E6B73636170652E6F72679BEE3C1A000000D349
        444154388DCD533B0E8250101C3E8F50682124426267A585D77AE118730CC2B5
        6CB4B034010B2CB402796B23348A79D19838DD6627B33BFB017E09923E49FF1D
        C7194B68AD5518863B1131711CAF49DE5EF146D55DD79D01583A8E83B22C2300
        A797BC77EDD9E06B8161065A6BE579DEA48F95520B00DB47B869DBF6D8E7BAAE
        BB1645D10E0224FDBAAEF7009696850F5114AD48DE060B22626CDB161179B240
        D2AFAA6A6A632149924BBFD6D13BC8B26C1E044105004DD324799EFFE91A472F
        D118730670101149D3B4FE48DDE699BEC61DBA7F50077F8D59A0000000004945
        4E44AE426082}
      Rounded = True
      Spacing = 7
      TabOrder = 2
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
      Layout = blGlyphLeftAdjusted
    end
    object LMDSimplePanel2: TLMDSimplePanel
      Left = 14
      Top = 33
      Width = 94
      Height = 23
      Margins.Top = 2
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15129563
      Bevel.BorderWidth = 1
      Color = clWhite
      TabOrder = 3
      object edDataIni: TDateEdit
        AlignWithMargins = True
        Left = 4
        Top = 3
        Width = 86
        Height = 19
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        AutoSelect = False
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DialogTitle = 'Selecione uma data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        GlyphKind = gkCustom
        Glyph.Data = {
          860A0000424D860A000000000000360000002800000028000000160000000100
          180000000000500A0000000000000000000000000000000000000000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0808080808080808080808080
          808080808080808080808080808080C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
          8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
          C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
          FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
          DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFF
          FFC0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
          8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
          C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
          FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
          DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
          8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C080808080
          8080808080808080808080808080808080808080808080C0C0C0FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FF}
        ButtonWidth = 18
        NumGlyphs = 2
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object LMDSimplePanel3: TLMDSimplePanel
      Left = 122
      Top = 33
      Width = 94
      Height = 23
      Margins.Top = 2
      Bevel.StyleOuter = bvNormal
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 15129563
      Bevel.BorderWidth = 1
      Color = clWhite
      TabOrder = 4
      object edDataFin: TDateEdit
        AlignWithMargins = True
        Left = 4
        Top = 3
        Width = 86
        Height = 19
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        AutoSelect = False
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DialogTitle = 'Selecione uma data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7039851
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        GlyphKind = gkCustom
        Glyph.Data = {
          860A0000424D860A000000000000360000002800000028000000160000000100
          180000000000500A0000000000000000000000000000000000000000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0808080808080808080808080
          808080808080808080808080808080C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
          8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
          C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
          FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
          DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFF
          FFC0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
          8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0
          C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF808080FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDFFFFFFDDDDDDFFFF
          FFDDDDDDFFFFFFDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
          DDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFF
          FF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF80
          8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFC0C0C0FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C080808080
          8080808080808080808080808080808080808080808080C0C0C0FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDC0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000FF0000FF}
        ButtonWidth = 18
        NumGlyphs = 2
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object ckTipEnvio: TLMDCheckBox
      Left = 232
      Top = 36
      Width = 106
      Height = 18
      Caption = 'ENVIO MANUAL'
      Alignment.Alignment = agTopLeft
      Alignment.Spacing = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object btBuscar: TAdvGlowButton
      Tag = 1
      AlignWithMargins = True
      Left = 3
      Top = 73
      Width = 340
      Height = 23
      Cursor = crHandPoint
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 1
      Align = alBottom
      Caption = 'Enviar / Gerar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5855577
      Font.Height = -13
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
      Picture.Data = {
        89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
        A9000000097048597300000B1300000B1301009A9C18000000206348524D0000
        7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
        C546000000F54944415478DA62FCFF9F8132F0FF3F03438E4962522ED7A28525
        31DC3CB8D4E0C20CFFFF3330E43E78F43037EFFFFF9C23070F6233049F014C0C
        0C0C0CFF674546FF6FFBFC8971959DDDCFA89DDBCBD478F948F202030303434E
        95B54DCE974F1F73F3FEFFCFDD76E430B22104BD0003B80C21DA005C86906400
        03030343AE8CAD5DEE84CF9F73F3FEFFCF7DB5633BC14044078C97FEFF837332
        1899F0852186644E95B5CD3FB66D5B19EEF1F030781C3DC279252494A858A038
        10298A467C9A0919C0C2C0C0C0C07860D952862FBC7C0C12870FFDFDE2E5DD75
        EBCB179252626E484242EE87C58BB356F1909C991829CDCE80010078BF21266F
        ECE3290000000049454E44AE426082}
      Rounded = True
      Spacing = 3
      TabOrder = 6
      OnClick = btBuscarClick
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
      Layout = blGlyphRight
    end
  end
  object SouSNGPC: TDataSource
    DataSet = TabSNGPC
    Left = 127
    Top = 263
  end
  object TabSNGPC: TRESTDWClientSQL
    Active = False
    OnCalcFields = TabSNGPCCalcFields
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
      'SELECT * FROM arqsngpc ORDER BY IDFilial,DataIni DESC LIMIT 200')
    UpdateTableName = 'arqsngpcenv'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 39
    Top = 263
    object TabSNGPCIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabSNGPCDataIni: TDateField
      FieldName = 'DataIni'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabSNGPCDataFin: TDateField
      FieldName = 'DataFin'
    end
    object TabSNGPCTipoEnv: TWideStringField
      FieldName = 'TipoEnv'
      Size = 1
    end
    object TabSNGPCTipoStr: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TipoStr'
      ProviderFlags = []
      Size = 15
      Calculated = True
    end
  end
  object XMLDoc: TXMLDocument
    NodeIndentStr = #9
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 224
    Top = 263
    DOMVendorDesc = 'MSXML'
  end
  object XMLDocument1: TXMLDocument
    Left = 104
    Top = 201
  end
end
