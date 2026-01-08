object FrmPerdas: TFrmPerdas
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'SNGPC - Perdas'
  ClientHeight = 497
  ClientWidth = 1130
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 2236186
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 14
  object PanelPri: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 1128
    Height = 495
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    Bevel.StyleInner = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = clSilver
    Color = 16382975
    TabOrder = 0
    object Shape1: TShape
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 1126
      Height = 1
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      ExplicitLeft = 51
      ExplicitTop = 4
      ExplicitWidth = 1149
    end
    object Shape3: TShape
      AlignWithMargins = True
      Left = 1
      Top = 105
      Width = 1126
      Height = 1
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      ExplicitLeft = 51
      ExplicitTop = 139
      ExplicitWidth = 1149
    end
    object Shape4: TShape
      AlignWithMargins = True
      Left = 1
      Top = 452
      Width = 1126
      Height = 1
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      ExplicitLeft = 59
      ExplicitTop = 556
      ExplicitWidth = 1149
    end
    object Shape5: TShape
      AlignWithMargins = True
      Left = 1
      Top = 493
      Width = 1126
      Height = 1
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      ExplicitLeft = 67
      ExplicitTop = 710
      ExplicitWidth = 1149
    end
    object PanelProd: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 108
      Width = 1126
      Height = 342
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      Bevel.StyleInner = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14145495
      Color = 16316664
      TabOrder = 0
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1120
        Height = 336
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = SouPerda
        DrawingStyle = gdsGradient
        GradientEndColor = 15658734
        GradientStartColor = 15658734
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = 2236186
        TitleFont.Height = -12
        TitleFont.Name = 'Roboto'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DatPer'
            Title.Alignment = taCenter
            Title.Caption = 'DATA PERDA'
            Title.Color = clNone
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5987163
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Motivo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Caption = 'MOTIVO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5987163
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 193
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
            Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5987163
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 300
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'RegistoMS'
            Title.Alignment = taCenter
            Title.Caption = 'REGISTRO MS'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QtdPer'
            Title.Alignment = taRightJustify
            Title.Caption = 'QUANT.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'NroLot'
            Title.Alignment = taCenter
            Title.Caption = 'LOTE'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DatVen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'VENCIMENTO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5987163
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NroNot'
            Title.Alignment = taCenter
            Title.Caption = 'NOTA FISCAL'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Status'
            Title.Caption = 'STATUS'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -11
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end>
      end
    end
    object PanelRodape: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 455
      Width = 1126
      Height = 36
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14145495
      Color = 16382975
      TabOrder = 1
      object btImprimir: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 5
        Top = 3
        Width = 136
        Height = 30
        Cursor = crHandPoint
        Margins.Left = 5
        Align = alLeft
        Caption = 'Impress'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
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
          610000000473424954080808087C086488000000097048597300000076000000
          76014E7B26080000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000000DE49444154388D9DD3314E02411406E06F17
          2A0B2B0B124BA0B3F0085BD0790330B1E31E5CC00340CD11EC2478040B2A4DE8
          E8B4171B2C968DB303A32C7F32C9BC3FEFFD33EF9F37993A2EF1800BC7B1C11C
          BB8A6847098FE860951018ED8BE729812E267849087CA11F12B1C07FF88C890C
          3986B8C618CF589F2056F9E15ED9D7396B94A3D7B08D0283FDBE9F372C8616BE
          ABA0A989B00883736E50431BDB887B921EA41BDC05F196D2C477BFCE167F1C58
          04796FCAC1AB617982C03224620F764A975368093E1287AFB0C0547A12BB9885
          447624E9165709810FBC86C40F4C58329B591A14320000000049454E44AE4260
          82}
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
      object btIncluir: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 149
        Top = 3
        Width = 136
        Height = 30
        Cursor = crHandPoint
        Margins.Left = 5
        Align = alLeft
        Caption = 'Incluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
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
          610000000473424954080808087C08648800000009704859730000006F000000
          6F01F1A2DC430000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A0000013B49444154388D8DD3B14B965114C7F1CF0D
          27315C2BA7A2218A36A12D22A451DB5B9A9A22025B2C6CEA3FC8BD3510175709
          5E509ADEA1B1A8C1C145DCE45D8A7A7F0DCF7DF0F1B1C7BC7086FBE39CEFFDDD
          7BCE9504EEE2237E22E7C4184F9268A324514A19E1181BF86578DDC33B5C4F72
          D08A0B957EB34B1E8AEA62B5DDCFE072054D4A2973581C387D3FC93E269D1A33
          BDA4A7783F00F884A5BE78A9BB49B291A40CC499E2330E4A298FF172C0C138C9
          2B7CD6BCC33FAFF015A301C097EAF2F5A0031CF40053EC2599765CDED13CF456
          9209DCD2B4F10A9E3B3D3853DCEFB4700DBF359D1857ED04F09FFEBFA9C063BC
          C51FCC5F088075CD98AFE043CDDFBC9003BCA8C5CBB886EFD8C55C0B387794F1
          A3DEFD2ABE758B93689346D8C6233CC08DAADFAEF01D1CF68BBB80FE77DEADFA
          431C6113CF30DB77F8170CA521A92FFDDB1A0000000049454E44AE426082}
        Rounded = True
        Spacing = 4
        TabOrder = 1
        OnClick = btIncluirClick
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
        Tag = 1
        AlignWithMargins = True
        Left = 437
        Top = 3
        Width = 136
        Height = 30
        Cursor = crHandPoint
        Margins.Left = 5
        Align = alLeft
        Caption = 'Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
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
          610000000473424954080808087C086488000000097048597300000076000000
          76014E7B26080000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A0000012449444154388DADD3BD2E046114C6F1DFFA
          CC4641419815210A8D48D4226CC43DA8B813B544E31ADC8392826D95128D8F44
          622D21123611E2AB9883D931A2E069E6CD39E7F9BFE7CC99E18F2A15C43A7180
          815CFC129378FD0DD08326AAF1843E6CA31B4F458035CC622C62C378C881CB38
          C71B4EB18BD58E48EE620223A861145D39C023CE308F46D4B568193B997309D3
          988AF372E46A582A18DD220ED18E1754B081F5E8E82940C798FB30B565007524
          61BEC160263784AB983F89DA6F800BF44AB7D00853167029DD4639F2DF00B7D2
          379F4471B683C1885570E76BBD2D808F2E2A3F001A91AB670D4580248A8B3A48
          A2E6531D5A558F5BB6C2D4C433FAA5DFC04CBE833CE0040BD8C37D267E2D5D61
          15FB5943FE5FA86013E38A75849518E77FF40ED1FE413C875B178B0000000049
          454E44AE426082}
        Rounded = True
        Spacing = 4
        TabOrder = 2
        OnClick = btExcluirClick
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
      object btAlterar: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 293
        Top = 3
        Width = 136
        Height = 30
        Cursor = crHandPoint
        Margins.Left = 5
        Align = alLeft
        Caption = 'Alterar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000473424954080808087C086488000000017352474200AECE1CE90000
          000467414D410000B18F0BFC6105000000097048597300000073000000730163
          C143FE0000001974455874536F667477617265007777772E696E6B7363617065
          2E6F72679BEE3C1A0000018769545874584D4C3A636F6D2E61646F62652E786D
          7000000000003C3F787061636B657420626567696E3D27EFBBBF272069643D27
          57354D304D7043656869487A7265537A4E54637A6B633964273F3E0D0A3C783A
          786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F22
          3E3C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E
          77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E7323
          223E3C7264663A4465736372697074696F6E207264663A61626F75743D227575
          69643A66616635626464352D626133642D313164612D616433312D6433336437
          353138326631622220786D6C6E733A746966663D22687474703A2F2F6E732E61
          646F62652E636F6D2F746966662F312E302F223E3C746966663A4F7269656E74
          6174696F6E3E313C2F746966663A4F7269656E746174696F6E3E3C2F7264663A
          4465736372697074696F6E3E3C2F7264663A5244463E3C2F783A786D706D6574
          613E0D0A3C3F787061636B657420656E643D2777273F3E2C94980B0000009B49
          444154384F9592C11102210C451F3B7BB61B4BB1186F5B95272BD0B1054BD816
          F0429CF043707D3361E0137E0243E13755857FC90CCE405D44AC83C8D8018A88
          D901CD334207467131C51BF8EA5927016FE0E75A799575CA4985C1A36A044143
          E98A949674F162E30DBCE43A66B8D8DC0C669881E6151B2AB0C926C003B8251D
          7CB5231D8C0806D77E1F80277057B1110C66E89FE8C8BEF2613E03142D417CE6
          67440000000049454E44AE426082}
        Rounded = True
        Spacing = 4
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btAlterarClick
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
        Appearance.TextColorDisabled = 9211020
      end
    end
    object PanelCabecalho: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 4
      Width = 1126
      Height = 99
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Color = clWhitesmoke
      TabOrder = 2
      DesignSize = (
        1126
        99)
      object Label22: TLabel
        Left = 10
        Top = 5
        Width = 34
        Height = 13
        Caption = 'PERDA'
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 110
        Top = 27
        Width = 7
        Height = 13
        Caption = #192
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 457
        Top = 53
        Width = 29
        Height = 13
        Caption = 'LISTA'
        Color = 7039851
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object AdvGlowButton1: TAdvGlowButton
        Tag = 3099
        AlignWithMargins = True
        Left = 1097
        Top = 2
        Width = 24
        Height = 23
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Anchors = [akTop, akRight]
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
        Appearance.BorderColor = 11382963
        Appearance.BorderColorHot = 11565130
        Appearance.BorderColorCheckedHot = 11565130
        Appearance.BorderColorDown = 11565130
        Appearance.BorderColorChecked = 13744549
        Appearance.BorderColorDisabled = 13948116
        Appearance.BorderColorFocused = clWhitesmoke
        Appearance.Color = clWhite
        Appearance.ColorTo = clWhite
        Appearance.ColorChecked = 13744549
        Appearance.ColorCheckedTo = 13744549
        Appearance.ColorDisabled = clWhite
        Appearance.ColorDisabledTo = clNone
        Appearance.ColorDown = 11565130
        Appearance.ColorDownTo = 11565130
        Appearance.ColorHot = 16444643
        Appearance.ColorHotTo = 16444643
        Appearance.ColorMirror = clWhite
        Appearance.ColorMirrorTo = clWhite
        Appearance.ColorMirrorHot = 16444643
        Appearance.ColorMirrorHotTo = 16444643
        Appearance.ColorMirrorDown = 11565130
        Appearance.ColorMirrorDownTo = 11565130
        Appearance.ColorMirrorChecked = 13744549
        Appearance.ColorMirrorCheckedTo = 13744549
        Appearance.ColorMirrorDisabled = clWhite
        Appearance.ColorMirrorDisabledTo = clNone
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
        Left = 10
        Top = 23
        Width = 94
        Height = 23
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 1
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
      object edDatfin: TLMDSimplePanel
        Left = 123
        Top = 21
        Width = 94
        Height = 24
        Margins.Top = 2
        Bevel.StyleOuter = bvNormal
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 15129563
        Bevel.BorderWidth = 1
        Color = clWhite
        TabOrder = 2
        object edDataFin: TDateEdit
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 86
          Height = 20
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          AutoSelect = False
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
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
      object edNomfab: TLMDLabeledEdit
        Left = 237
        Top = 21
        Width = 341
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 3
        OnKeyDown = edNomfabKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3617579
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <
          item
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000012000000160806000000CD5FCC
              41000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC100000EC101B8916BED0000018769545874584D4C3A63
              6F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E
              3D27EFBBBF272069643D2757354D304D7043656869487A7265537A4E54637A6B
              633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D2261646F62
              653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A7264663D22
              687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D726466
              2D73796E7461782D6E7323223E3C7264663A4465736372697074696F6E207264
              663A61626F75743D22757569643A66616635626464352D626133642D31316461
              2D616433312D6433336437353138326631622220786D6C6E733A746966663D22
              687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E302F223E3C
              746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269656E7461
              74696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264663A524446
              3E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E643D277727
              3F3E2C94980B000001BD4944415478DAE592BFAB816114C7BFEF68344832CB8F
              889410063665409181C51F40CC06F90718192884C16E2425062603CA8F481928
              D984E1DEFB9CE12D79DFDBBDB73BDD7BB6A7E79CCF39E77BBEDCDB47E01782FB
              A7A0F97C8E7C3E8F5EAF87DBED068EE3E0F178904C26613299BE0662C5A15008
              72B99C8AF57A3DA6D32946A31156AB15AAD52A0281C0E7A0ED760B9BCD46C5AD
              560B32998CFF639385C36174BB5D0C0603188D4671502A9542BD5EC772B98454
              2A7D99F67ABD12C06AB5529E20E87C3EC36EB7C3E170A052A9888A9B4EA7D16E
              B7B1DFEF8541BBDD0E068301D96C9692C5A2542A2193C9E0743A0983EEF73B9C
              4E27542A151A8D8628289148A0D3E990F0A21A150A05E472390C874368349A17
              C8E57281D96C86DBED46B95C1607B14E914884746250B55ACDFF6D361B3A066B
              D2EFF7A1D3E98441E3F118D1681487C381DE128904C16090565DAFD774257649
              A691D7EB15F6D16432218F300199778AC52266B3199ACD26168B05944A257C3E
              1FE2F138B45AEDD3163C888D1A8BC5703C1EC9CDCC88168B85921E8F079D994D
              22E4AB27103318DB5FA150A056AB91B3BF133CC8EFF7535726AECBE5FA1644F4
              6A3F893F0C7A07890B08CEDBDF1D680000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edNomfabCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 2
        EditLabel.Width = 66
        EditLabel.Height = 15
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'FABRICANTE'
      end
      object edNomgru: TLMDLabeledEdit
        Left = 10
        Top = 65
        Width = 207
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        OnKeyDown = edNomgruKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3617579
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <
          item
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000012000000160806000000CD5FCC
              41000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC100000EC101B8916BED0000018769545874584D4C3A63
              6F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E
              3D27EFBBBF272069643D2757354D304D7043656869487A7265537A4E54637A6B
              633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D2261646F62
              653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A7264663D22
              687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D726466
              2D73796E7461782D6E7323223E3C7264663A4465736372697074696F6E207264
              663A61626F75743D22757569643A66616635626464352D626133642D31316461
              2D616433312D6433336437353138326631622220786D6C6E733A746966663D22
              687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E302F223E3C
              746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269656E7461
              74696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264663A524446
              3E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E643D277727
              3F3E2C94980B000001BD4944415478DAE592BFAB816114C7BFEF68344832CB8F
              889410063665409181C51F40CC06F90718192884C16E2425062603CA8F481928
              D984E1DEFB9CE12D79DFDBBDB73BDD7BB6A7E79CCF39E77BBEDCDB47E01782FB
              A7A0F97C8E7C3E8F5EAF87DBED068EE3E0F178904C26613299BE0662C5A15008
              72B99C8AF57A3DA6D32946A31156AB15AAD52A0281C0E7A0ED760B9BCD46C5AD
              560B32998CFF639385C36174BB5D0C0603188D4671502A9542BD5EC772B98454
              2A7D99F67ABD12C06AB5529E20E87C3EC36EB7C3E170A052A9888A9B4EA7D16E
              B7B1DFEF8541BBDD0E068301D96C9692C5A2542A2193C9E0743A0983EEF73B9C
              4E27542A151A8D8628289148A0D3E990F0A21A150A05E472390C874368349A17
              C8E57281D96C86DBED46B95C1607B14E914884746250B55ACDFF6D361B3A066B
              D2EFF7A1D3E98441E3F118D1681487C381DE128904C16090565DAFD774257649
              A691D7EB15F6D16432218F300199778AC52266B3199ACD26168B05944A257C3E
              1FE2F138B45AEDD3163C888D1A8BC5703C1EC9CDCC88168B85921E8F079D994D
              22E4AB27103318DB5FA150A056AB91B3BF133CC8EFF7535726AECBE5FA1644F4
              6A3F893F0C7A07890B08CEDBDF1D680000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edNomgruCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 2
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'GRUPO'
      end
      object edNomsub: TLMDLabeledEdit
        Left = 237
        Top = 65
        Width = 200
        Height = 23
        Bevel.StyleOuter = bvNormal
        Bevel.WidthInner = 0
        Bevel.WidthOuter = 0
        Bevel.BorderColor = 12500670
        Bevel.BorderWidth = 1
        Bevel.Mode = bmCustom
        Caret.BlinkRate = 530
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
        OnKeyDown = edNomsubKeyDown
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3617579
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        CustomButtons = <
          item
            ParentFont = False
            PngGlyph.Data = {
              89504E470D0A1A0A0000000D4948445200000012000000160806000000CD5FCC
              41000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC100000EC101B8916BED0000018769545874584D4C3A63
              6F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E
              3D27EFBBBF272069643D2757354D304D7043656869487A7265537A4E54637A6B
              633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D2261646F62
              653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A7264663D22
              687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D726466
              2D73796E7461782D6E7323223E3C7264663A4465736372697074696F6E207264
              663A61626F75743D22757569643A66616635626464352D626133642D31316461
              2D616433312D6433336437353138326631622220786D6C6E733A746966663D22
              687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E302F223E3C
              746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269656E7461
              74696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264663A524446
              3E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E643D277727
              3F3E2C94980B000001BD4944415478DAE592BFAB816114C7BFEF68344832CB8F
              889410063665409181C51F40CC06F90718192884C16E2425062603CA8F481928
              D984E1DEFB9CE12D79DFDBBDB73BDD7BB6A7E79CCF39E77BBEDCDB47E01782FB
              A7A0F97C8E7C3E8F5EAF87DBED068EE3E0F178904C26613299BE0662C5A15008
              72B99C8AF57A3DA6D32946A31156AB15AAD52A0281C0E7A0ED760B9BCD46C5AD
              560B32998CFF639385C36174BB5D0C0603188D4671502A9542BD5EC772B98454
              2A7D99F67ABD12C06AB5529E20E87C3EC36EB7C3E170A052A9888A9B4EA7D16E
              B7B1DFEF8541BBDD0E068301D96C9692C5A2542A2193C9E0743A0983EEF73B9C
              4E27542A151A8D8628289148A0D3E990F0A21A150A05E472390C874368349A17
              C8E57281D96C86DBED46B95C1607B14E914884746250B55ACDFF6D361B3A066B
              D2EFF7A1D3E98441E3F118D1681487C381DE128904C16090565DAFD774257649
              A691D7EB15F6D16432218F300199778AC52266B3199ACD26168B05944A257C3E
              1FE2F138B45AEDD3163C888D1A8BC5703C1EC9CDCC88168B85921E8F079D994D
              22E4AB27103318DB5FA150A056AB91B3BF133CC8EFF7535726AECBE5FA1644F4
              6A3F893F0C7A07890B08CEDBDF1D680000000049454E44AE426082}
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Index = 0
            DisplayName = 'TLMDSpecialButton'
            OnClick = edNomsubCustomButtons0Click
            UsePngGlyph = True
          end>
        CustomButtonWidth = 18
        PasswordChar = #0
        Spelling.LiveSpell = True
        TabOnEnter = True
        Text = ''
        LabelSpacing = 2
        EditLabel.Width = 64
        EditLabel.Height = 15
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Roboto'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        EditLabel.Caption = 'SUB GRUPO'
      end
      object ComboLista: TLMDComboBox
        Left = 457
        Top = 66
        Width = 86
        Height = 22
        Color = clWhite
        Ctl3D = False
        DropDownCount = 13
        Items.Strings = (
          'TODOS'
          'A1'
          'A2'
          'A3'
          'AM'
          'B1'
          'B2'
          'C1'
          'C2'
          'C3'
          'C4'
          'C5'
          'D1')
        MRUMax = 12
        ParentCtl3D = False
        Style = csOwnerDrawFixed
        TabOrder = 6
      end
      object btLimpaDados: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 690
        Top = 37
        Width = 112
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Limpar filtros'
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
        Rounded = True
        Spacing = 1
        TabOrder = 7
        OnClick = btLimpaDadosClick
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
      object btBuscar: TAdvGlowButton
        Tag = 1
        AlignWithMargins = True
        Left = 818
        Top = 37
        Width = 112
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Selecionar'
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
        Spacing = 1
        TabOrder = 8
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
  end
  object SouPerda: TDataSource
    AutoEdit = False
    DataSet = TabPerda
    Left = 48
    Top = 272
  end
  object TabPerda: TRESTDWClientSQL
    Active = False
    AfterOpen = TabPerdaAfterOpen
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
      'SELECT PER.*,PRO.Despro,PRO.RegistoMS FROM arqsngpcper PER'
      'LEFT JOIN arqproduto PRO ON PER.IDProd = PRO.IDProd LIMIT 10')
    UpdateTableName = 'arqsngpcven'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 51
    Top = 207
    object TabPerdaIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPerdaIDPerda: TFDAutoIncField
      FieldName = 'IDPerda'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object TabPerdaIDInvIni: TIntegerField
      FieldName = 'IDInvIni'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPerdaIDProd: TIntegerField
      FieldName = 'IDProd'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPerdaNroLot: TWideStringField
      FieldName = 'NroLot'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPerdaMotivo: TWideStringField
      FieldName = 'Motivo'
      Size = 2
    end
    object TabPerdaQtdPer: TFloatField
      FieldName = 'QtdPer'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPerdaNroNot: TIntegerField
      FieldName = 'NroNot'
    end
    object TabPerdaDespro: TWideStringField
      FieldName = 'Despro'
      Size = 120
    end
    object TabPerdaRegistoMS: TWideStringField
      FieldName = 'RegistoMS'
      Size = 13
    end
    object TabPerdaStatus: TWideStringField
      FieldName = 'Status'
      Size = 1
    end
    object TabPerdaUsoRece: TWideStringField
      FieldName = 'UsoRece'
      Size = 2
    end
    object TabPerdaDatPer: TDateField
      FieldName = 'DatPer'
    end
    object TabPerdaDatVen: TDateField
      FieldName = 'DatVen'
    end
  end
end
