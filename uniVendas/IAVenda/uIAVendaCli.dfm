object FrmIAVenCli: TFrmIAVenCli
  Left = 0
  Top = 0
  Margins.Top = 8
  BorderStyle = bsNone
  Caption = 'VENDAS -IA Venda Cliente'
  ClientHeight = 563
  ClientWidth = 835
  Color = 10329501
  TransparentColorValue = clNone
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 14
  object PanelTop: TLMDSimplePanel
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 831
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 0
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13553358
    Bevel.BorderSides = [fsLeft, fsRight, fsTop]
    Bevel.BorderWidth = 1
    Color = 15461355
    TabOrder = 0
    DesignSize = (
      831
      27)
    object lbTitulo: TLMDLabel
      AlignWithMargins = True
      Left = 4
      Top = 6
      Width = 823
      Height = 17
      Margins.Top = 5
      Align = alClient
      Alignment = agCenter
      Color = 4159487
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 19967
      Font.Height = -15
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'AN'#193'LISE IA DE CLIENTE'
      ExplicitLeft = 331
      ExplicitWidth = 113
      ExplicitHeight = 20
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 808
      Top = 5
      Width = 20
      Height = 18
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Bottom = 6
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
        89504E470D0A1A0A0000000D49484452000000100000001010060000004F6323
        22000000206348524D00007A26000080840000FA00000080E8000075300000EA
        6000003A98000017709CBA513C00000006624B4744000000000000F943BB7F00
        00000970485973000000600000006000F06B42CF0000000774494D4507E70913
        00162241D1EFA9000002864944415448C7CD95DD4B937114C7BFE759BAD956D0
        457706D36EC2B78B28949ACF93896DB34D2FA27F20F2AAAE02378B422AA8D4A0
        8BD5BF20844A88315CD4D2F94646C448843421A45B91706E33F3F976319F4DF6
        3436B48BCEEDC3CEE773CEF99D33E07F0B32B0A4B1A989ECE971B9AAAB0F9E2F
        9387FA9D068D7575F9DF957C3020C7D13B3B0B3064D98AC7A907DF35AFABEA3E
        0AB97521D1DA0AF08C455D5880EC34E27D3C4E068FB5DCADAD3509809C66DBDA
        1A8006A8A914809B38EC7000589143E130D9BDD862D1B4D2C1728E8FC6C6007C
        C44C45058041049349105DBFB48D0D93802803D7626F979741FD3A1B3D1E00CF
        914C242058119FDD0E286E3D120EE7007960A35394533A4747B360E2245F6F6E
        024860DEEF17A5AF7FA66D7535CB2D5889DE7D5FDD686E8628FD72311CDED391
        41DC4B26015E95A68E0E502EEF6C6F6F1B9DCA0A1B604197387C3E913E999489
        897C4E41811244226249A701A9601200A8C26AB3950A2E59C02C224E791C8900
        B2B83B5B23550C5BE934C059CC79BDC5C0E647583414177F8B00F20C51F98B38
        5F50B55800F4C8B2DD5E72D6E29567D7303363C00DABCD0620B25B710DCEA752
        005ECA87B2320097F4132323D4BB7F68F4F9F62D6002E73F2EE033E6BC5E90DF
        79DBED86B135C01BF158AD10E52BD3C3C3D483AFB41ABFBF6481A2E0BCC725CA
        406FECC8D414A807186D6F378B20845061913D9770F74209D69581F1F1DCFE67
        137E1387C753709D0C11C8692E757622BBAE388B07E5E5101CE5A7A121EAC180
        1AAAAF377780FA17FD61551572972B03266E60DEEB15A5AF7F52A6A78BCD54E4
        C954EC67340A889357FCFE3D22464766E46965A579E6CCFCDC38B964901A9DCE
        62C06291FB330A0634BA5C07CDF7CFE30F28D475C76F6FFE520000000049454E
        44AE426082}
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
        A9000000206348524D00007A26000080840000FA00000080E8000075300000EA
        6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
        485973000000600000006000F06B42CF0000000774494D4507E70913001308E7
        1DD23A000001BD4944415438CBAD92314B235110C7FF6FA3C4B85B5C6921A25B
        C8711BB0102160B23146D040E266D626C55557F809AC0EE12CC4CA46C817D03A
        2212DC2A040B6D140B1344B138FC00278AFBF2D6A0D96795BBC44B620AA77C33
        BFFFCCFCE7019F15F65224625774FDC3BA8AAED35A38FC1F4C7BBE4F63AE6BE7
        4DB31B9C8D26936408917D6A3456728601000A00B0F2FD3D7E7B1EA6354D261C
        8716E2F14E307B281631190AB1B010CAABEBB61558A5588CC65C97484ADAA8D5
        B2D164F2EF8479D3A42BCE89A4A42BCE2D3937D7CCB1F722CA0FC7C1B4A6614A
        08595A5E56722F2F32E1385857556CD66AFEB774FA901D1F7735A96D923BCFA3
        3BCFEBD4B96758A5588C0C2188A46C0A7583954E8F811BC66481FD5B4F0D0494
        3FAADA97809D374D99701CF67368486E3D3FE3D6F3B03A3888DDFDFDEC753ADD
        53A009370D935F53297F677111179CE33418644785827596C974DCBBD7A9DA8C
        8DD4EBAD220C00567286E157CFCF31190AE182733CA552078F2727AD0D686D7E
        1E5AB188CBE161CCD6EBFEC8CCCCE1F76A550180C6AF89895E30001C6C97CBE0
        990CA684C06930C80646475BD28CD1423C6EC9F1F18F4E6C57749DBE44A37DFD
        877EE20D53CEDA02451D39260000000049454E44AE426082}
      Rounded = False
      Spacing = 3
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
  object LMDSimplePanel1: TLMDSimplePanel
    AlignWithMargins = True
    Left = 2
    Top = 29
    Width = 831
    Height = 459
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 1
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 14671839
    Bevel.BorderWidth = 1
    Color = 16250100
    TabOrder = 1
    object Label21: TLabel
      Left = 39
      Top = 16
      Width = 42
      Height = 13
      Caption = 'CLIENTE'
      Color = 14405561
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 610
      Top = 16
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'CADASTRO'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 596
      Top = 45
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'ULT.COMPRA'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 26
      Top = 43
      Width = 55
      Height = 13
      Caption = 'ENDERE'#199'O'
      Color = 14405561
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 613
      Top = 72
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'CPF/CNPJ'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 462
      Top = 43
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'NRO.'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 42
      Top = 70
      Width = 39
      Height = 13
      Caption = 'BAIRRO'
      Color = 14405561
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 637
      Top = 99
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'FONE'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 44
      Top = 98
      Width = 37
      Height = 13
      Caption = 'CIDADE'
      Color = 14405561
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 474
      Top = 98
      Width = 14
      Height = 13
      Alignment = taRightJustify
      Caption = 'UF'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 468
      Top = 70
      Width = 20
      Height = 13
      Alignment = taCenter
      Caption = 'CEP'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 26
      Top = 125
      Width = 55
      Height = 13
      Caption = 'CONV'#202'NIO'
      Color = 14405561
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 454
      Top = 125
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'LIMITE'
      Font.Charset = ANSI_CHARSET
      Font.Color = 7039851
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edNompes: TLMDLabeledEdit
      Left = 88
      Top = 11
      Width = 344
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object edDatcad: TLMDLabeledEdit
      Left = 671
      Top = 11
      Width = 77
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 1
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object DBGrid2: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 1
      Top = 176
      Width = 829
      Height = 150
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouPedidoIte
      DrawingStyle = gdsGradient
      FixedColor = 15066597
      GradientEndColor = 15855599
      GradientStartColor = 15855599
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5131854
      TitleFont.Height = -15
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      Columns = <
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'DATA/HORA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 101
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'D.PROD.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 397
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'QTD.VEN.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'VLR.UNIT.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'TOTAL ITEM'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 5131854
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 86
          Visible = True
        end>
    end
    object LMDSimplePanel4: TLMDSimplePanel
      AlignWithMargins = True
      Left = 1
      Top = 152
      Width = 829
      Height = 21
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 13553358
      Bevel.BorderSides = [fsLeft, fsRight, fsTop]
      Bevel.BorderWidth = 1
      Color = 15461355
      TabOrder = 3
      object LMDLabel2: TLMDLabel
        AlignWithMargins = True
        Left = 8
        Top = 4
        Width = 110
        Height = 13
        Margins.Left = 7
        Align = alLeft
        Alignment = agCenterLeft
        Color = 4159487
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 19967
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        Options = []
        ParentColor = False
        ParentFont = False
        Caption = #218'LTIMAS COMPRAS'
        ExplicitLeft = 7
        ExplicitTop = 3
        ExplicitHeight = 14
      end
    end
    object edUltComp: TLMDLabeledEdit
      Left = 671
      Top = 38
      Width = 77
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 4
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object edEndpes: TLMDLabeledEdit
      Left = 88
      Top = 38
      Width = 344
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit3: TLMDLabeledEdit
      Left = 671
      Top = 65
      Width = 132
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 6
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit1: TLMDLabeledEdit
      Left = 494
      Top = 38
      Width = 53
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 7
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit2: TLMDLabeledEdit
      Left = 88
      Top = 65
      Width = 344
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit4: TLMDLabeledEdit
      Left = 671
      Top = 93
      Width = 132
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 9
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit5: TLMDLabeledEdit
      Left = 88
      Top = 93
      Width = 344
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit6: TLMDLabeledEdit
      Left = 494
      Top = 93
      Width = 25
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 11
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 5
      EditLabel.Height = 16
      EditLabel.Caption = ' '
    end
    object LMDLabeledEdit7: TLMDLabeledEdit
      Left = 494
      Top = 65
      Width = 69
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 12
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taCenter
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit8: TLMDLabeledEdit
      Left = 88
      Top = 120
      Width = 344
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDLabeledEdit9: TLMDLabeledEdit
      Left = 494
      Top = 120
      Width = 87
      Height = 22
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12500670
      Bevel.BorderWidth = 1
      Bevel.Mode = bmCustom
      Caret.BlinkRate = 530
      TabOrder = 14
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 789516
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      CustomButtons = <>
      PasswordChar = #0
      ReadOnly = True
      Spelling.LiveSpell = True
      TabOnEnter = True
      Text = ''
      LabelSpacing = -15
      EditLabel.Width = 49
      EditLabel.Height = 16
      EditLabel.Caption = 'edBusca'
    end
    object LMDSimplePanel5: TLMDSimplePanel
      Left = 1
      Top = 326
      Width = 829
      Height = 132
      Margins.Bottom = 0
      Align = alBottom
      Color = 16250100
      TabOrder = 15
      object LMDSimplePanel6: TLMDSimplePanel
        AlignWithMargins = True
        Left = 419
        Top = 0
        Width = 417
        Height = 132
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Color = 16250100
        TabOrder = 0
        object LMDSimplePanel8: TLMDSimplePanel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 417
          Height = 21
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 13553358
          Bevel.BorderSides = [fsLeft, fsRight, fsTop]
          Bevel.BorderWidth = 1
          Color = 15461355
          TabOrder = 0
          object LMDLabel3: TLMDLabel
            AlignWithMargins = True
            Left = 8
            Top = 4
            Width = 153
            Height = 13
            Margins.Left = 7
            Align = alLeft
            Alignment = agCenterLeft
            Color = 4159487
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 19967
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentColor = False
            ParentFont = False
            Caption = 'PRODUTOS SUGERIDOS'
            ExplicitHeight = 14
          end
        end
        object DBGrid3: TDBGrid
          Tag = 1
          AlignWithMargins = True
          Left = 1
          Top = 22
          Width = 415
          Height = 109
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alBottom
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DataSource = SouPend
          DrawingStyle = gdsGradient
          FixedColor = 15066597
          GradientEndColor = 15855599
          GradientStartColor = 15855599
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = 5131854
          TitleFont.Height = -15
          TitleFont.Name = 'Roboto'
          TitleFont.Style = []
          OnDrawColumnCell = DBGrid1DrawColumnCell
          Columns = <
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'C'#211'D.PROD.'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'DESCRI'#199#195'O PRODUTO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 234
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'VALOR'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 81
              Visible = True
            end>
        end
      end
      object LMDSimplePanel7: TLMDSimplePanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 417
        Height = 132
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Color = 16250100
        TabOrder = 1
        object LMDSimplePanel3: TLMDSimplePanel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 417
          Height = 21
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 13553358
          Bevel.BorderSides = [fsLeft, fsRight, fsTop]
          Bevel.BorderWidth = 1
          Color = 15461355
          TabOrder = 0
          object LMDLabel1: TLMDLabel
            AlignWithMargins = True
            Left = 8
            Top = 4
            Width = 89
            Height = 13
            Margins.Left = 7
            Align = alLeft
            Alignment = agCenterLeft
            Color = 4159487
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 19967
            Font.Height = -13
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentColor = False
            ParentFont = False
            Caption = 'PEND'#202'NCIAS'
            ExplicitHeight = 14
          end
        end
        object DBGrid1: TDBGrid
          Tag = 1
          AlignWithMargins = True
          Left = 0
          Top = 22
          Width = 416
          Height = 109
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alBottom
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DataSource = SouPend
          DrawingStyle = gdsGradient
          FixedColor = 15066597
          GradientEndColor = 15855599
          GradientStartColor = 15855599
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = 5131854
          TitleFont.Height = -15
          TitleFont.Name = 'Roboto'
          TitleFont.Style = []
          OnDrawColumnCell = DBGrid1DrawColumnCell
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'ID PEDIDO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 87
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'DATA VENDA'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 94
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'VENCIMENTO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 94
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'PARC'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 38
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'VALOR'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 5131854
              Title.Font.Height = -12
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 80
              Visible = True
            end>
        end
      end
    end
  end
  object LMDSimplePanel2: TLMDSimplePanel
    AlignWithMargins = True
    Left = 2
    Top = 489
    Width = 830
    Height = 71
    Margins.Left = 2
    Margins.Top = 0
    Align = alBottom
    Color = 15397375
    TabOrder = 2
  end
  object TabPend: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'Codmun'
        DataType = ftInteger
      end
      item
        Name = 'Codbai'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Nombai'
        DataType = ftString
        Size = 45
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
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 40
    Top = 476
  end
  object SouPend: TDataSource
    AutoEdit = False
    DataSet = TabPend
    Left = 120
    Top = 476
  end
  object TabPedidoIte: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <
      item
        Name = 'Codmun'
        DataType = ftInteger
      end
      item
        Name = 'Codbai'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Nombai'
        DataType = ftString
        Size = 45
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
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 40
    Top = 268
  end
  object SouPedidoIte: TDataSource
    AutoEdit = False
    DataSet = TabPedidoIte
    Left = 128
    Top = 268
  end
end
