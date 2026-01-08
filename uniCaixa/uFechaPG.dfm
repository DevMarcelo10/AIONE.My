object FrmFechaPG: TFrmFechaPG
  Left = 470
  Top = 249
  BorderStyle = bsNone
  Caption = 'Caixa - Pagamento'
  ClientHeight = 342
  ClientWidth = 725
  Color = 16381167
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 14
  object PanelCadastro: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 32
    Width = 723
    Height = 309
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13619151
    Bevel.BorderWidth = 1
    Color = 16382200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Shape1: TShape
      Left = 1
      Top = 274
      Width = 721
      Height = 1
      Align = alBottom
      Pen.Color = 14211288
      ExplicitTop = 171
      ExplicitWidth = 501
    end
    object PanelBckBut: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 1
      Width = 167
      Height = 241
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 12572415
      Bevel.BorderWidth = 1
      Color = 14674687
      TabOrder = 0
      object PanelMen: TLMDSimplePanel
        Left = 1
        Top = 1
        Width = 165
        Height = 239
        Align = alClient
        Color = 14674687
        TabOrder = 0
        object LMDSimplePanel1: TLMDSimplePanel
          Left = 0
          Top = 236
          Width = 165
          Height = 3
          Align = alBottom
          Color = 14674687
          TabOrder = 4
        end
        object btPag2: TAdvGlowButton
          Tag = 3
          AlignWithMargins = True
          Left = 4
          Top = 31
          Width = 161
          Height = 29
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F3 - D'#201'BITO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA864000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000000F54944415478DAEC95314A044110455F174B83C1E40A2673014598
            5E984B88D750DCD43B180B8BD7D81B4C360C3388BB89E9446E6464A00C4B9581
            CBB08899DD888B3FEA4EFEEFFABFAADA9919292124C6DF17980038E728CBF260
            18861311C97E42A8AAAFDEFB555DD76F6686333342085360011C467AF85A44CE
            9BA6E9645BC13C2239C091AACEC70CCCEC3481FD67C0A745C9430E21DC013E32
            F7D0B6ED6CB2BD5C272A60B69F93FC025CC4B2ED3B81A7AEEB16799EDF47EBA2
            2F98164571DBF7FD714C81CDCED9033711E663B36BD163827C1F460111B904D6
            11C99F55F56A5C15B1D7759665CBAAAADEC775FDFF65FEAAC0C70038C758113B
            8D71820000000049454E44AE426082}
          Rounded = False
          Spacing = 5
          TabOrder = 1
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
        object btPag1: TAdvGlowButton
          Tag = 2
          AlignWithMargins = True
          Left = 4
          Top = 1
          Width = 160
          Height = 29
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F2 - DINHEIRO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA864000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000001C74944415478DAEC55B14E1B41149CB7773642163959562A64AA83
            7C80779BF434A1A44993324A9A0309A434F9090C142452CA48F9831450A7B973
            E906BBA38B912D27C505FBEE86C26B7496EE04427211C4AB56AB37F376DFCCDB
            15925866282C399E0BDC1BA2B55EAACAEEBCD092F8E90240188630C6CC7AA6D4
            5692246B8F61AB542A7FD234ED0100C98F22326B5118862232BB44ABD5BA1491
            CD02FC25C90BBBDE2ECA21D9EB743A5B760D630CE72D8231E635C9B7008AC8BF
            C6711CD46AB535008DE17078E079DE8988BC5F105464536B7D2C223F00FC5A70
            11C9004000200370953F791CC741B55AF5B22CFB9965D9F746A3F1723C1E0700
            FAB9BC2B8B0D2C57A94DF7A228DA00F0C516BEE876BB13A5D42AC91AC9D32449
            FEF5FBFD1B1139B798338BD97FC81C4891B3945204F0592915388EB35E842129
            6536CD475B6BFD0940732EA8EFFB2BB6C78724FFBAAE7BEDFBFE0AC96D9BF341
            6BFD06C07AE90D481E916CDBBD665E38CFF34E46A3D1EFC964B2EB38CEBBC160
            705DAFD74F01F839AE260045B24DF26861921F6253923D00E74A29B127F78BAC
            1C45D1AB429BDEF5CC7577A6D3E98BB2614AD31400BE950D5AA106C618E43E9E
            DE7FF5D8C9F397F9F40BDC0E00785DC60966C6B4A30000000049454E44AE4260
            82}
          Rounded = False
          Spacing = 5
          TabOrder = 0
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
        object btPag3: TAdvGlowButton
          Tag = 4
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 161
          Height = 29
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F4 - CR'#201'DITO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000019E49
            4441544889ED94BF8A13511487BF73663420A389B1585B5D9F40F2474CE30B28
            6C9177D8C26271C1DA620BB19005451FC0666BC57E608B2033629AED0291DD52
            2421043790E41C9B1D71B389BAE374FA3503BFCBFD7E73E7CEBDF09FDF208B41
            B3D95C9BCD66AF55B5055CC82335B36F22F26E381C6E858B83F3F9FC99886CB8
            7B1E3700227215D82C97CBBD3305EEFE4A55DFE4F0AE010FDDFD4E16A8EAED1F
            9FA8D56A5D1E8D46670AFF842008BCDBED0EDBED76D0EFF75F029B27437BD268
            34AE99D95BE06E1EF94FF4CCEC41A954FA3C9D4E0F801BC09E9AD9A302E400B7
            54F569A7D33906DE67A102370B9067AC9F3CBF6641087C1091A008BBBB1F2D66
            619AA6BBC06E1105CB086BB5DA968814B107B8FB519AA6DBA70A80A6BBB78B28
            000E8053055A907825B90E16702C22130077BF022CFD4944A497670587511455
            9324A926495275F77B2BE4FB93C9E4799E155C1F8FC7DBF57AFD0BC0B282288A
            76E2387E02108A889DF3E6BC08ECAC986300711CCFB240814FE7B1FF0A77FFB8
            988583C1E045A5525977F7FBAA7A29A77BEAEEFB66F6F82FDFF15FE43BFF1C95
            BDAA1B4CC10000000049454E44AE426082}
          Rounded = False
          Spacing = 5
          TabOrder = 2
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
        object btPag4: TAdvGlowButton
          Tag = 5
          AlignWithMargins = True
          Left = 4
          Top = 91
          Width = 161
          Height = 29
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F5 - CHEQUE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001DF49
            4441544889C595B16B136118C69FE73352B0A9B9232EC580603EC896E5BA891A
            DBE25CA19D5D1C5C1C3BF81738E8645D0405C5ADE2A2051D04FF80CE2D861C07
            C2A1DB912F437215EF7B9D0AC7E52EBD5C233EE3FB7DEFEFF7C0777017708E74
            3A9D15D7755F349BCD388AA220EF0ECF034F92E433801B00626BEDAD20080EB3
            F7D402E0338BCE2DE876BBCB49927C4CC17F03D8C96B3FD35C041F8FC707007A
            29F8B6EFFB9F8A764A0BAAC04B0BAAC201809EE75D1C0E870F495ECD9C0D5BAD
            D6B3288A96F2E08D46E38B316617C0E53CB088848EE3BCAC19631E907C9E855B
            6BEF9E01DF07B055D89CC46834FAA3729A03C0FD7ABD7E5C159E4A6BEA331591
            5FBEEF1F4C26932729F889886CCD090700D47266EF01C05ABB4DF2B4F98EE338
            5F53F0130047002455AC4EB273A64029F5416B7D13402C224F45E49DEBBADFD3
            CD49EE0D0683DDEC6EBBDDFE497275A680A4514A05FD7EFF7AAFD7AB8561B861
            8CD903703BD5F691D6FA4E667519C06A66362DB0D6BE22F95A6BED8561780F40
            337B07C012002F673E95BC37581391B532CB5505A779AC94DA2F0B4A92E412C9
            6F00AE941288C886B5568ACEB3514AAD8848233B2F1490DC04B059562092DFA5
            D20F679E2800F13FE4C7356BED5B92EB00AE2D18FE4344DE2C98F91FF217DFF1
            E58FF5D12AB70000000049454E44AE426082}
          Rounded = False
          Spacing = 5
          TabOrder = 3
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
        object btPag5: TAdvGlowButton
          Tag = 6
          AlignWithMargins = True
          Left = 4
          Top = 121
          Width = 160
          Height = 29
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F6 - '#192' PRAZO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001C849
            4441544889C5D53D6B15411406E0E7FA81110BBF45545454D42E908F22885A18
            414821225682984214112CFC0FA61204C526225AE517A4D0C6223F40829DA820
            22821F042212D178AFC59C25E37573EFEEB5C80BCB9E993DF39EF39E39B3C30A
            610FD685BD159BC25E8F5DFF4BDEC03C6EC77806D361DFC7873A64AB337B036E
            E23246B005FD38891D388C5149DD6E1CC42C16AB663D8356CD67BA8CAC0C8762
            C10456A1897BF16D3682C3137C0BFB41ACD91EE39DB88AB3C1F11706C3F94A8C
            6F6020ECF3180B7B24F319C014FA308C2F99B2A96E01EA601873F88C5378145C
            7B9549E981FC99B4D1A3782EB574133F60CD320BAF617FDBDC22EE4AA528237F
            19D99FC31D7CCA17B797E89D7F3BE6374E64E44559FAA54A3C0EBF491536792D
            36B73D7DBD92970538860B38D3E637D40B795980B91837A5535BA87AD50B7959
            807D317724F3391D3EE375C897EBA29FF15EC8E686B2F7388EE3A1747A9B9DB2
            2F53F0D552E714BFE722E39654A65B9D32EFA6E0A27412E7F131E626F0142FA4
            BDE89A75270555308637962EA35214125B75B2091CC5016CEBE45494E82D7E49
            9BD7A840DE90CAF81DEFAB66745DEA9EAA97CD022E55C924C746E92AECA6A285
            D75213AC2CFE0063F98EDEBB866BB60000000049454E44AE426082}
          Rounded = False
          Spacing = 5
          TabOrder = 5
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
        object btPag7: TAdvGlowButton
          Tag = 8
          AlignWithMargins = True
          Left = 4
          Top = 179
          Width = 161
          Height = 27
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F8 - CONV'#202'NIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001D949
            4441544889A5D54F888D611406F09FE9FA33C5684C2C58A8D9B0B04016145998
            856261A54436B2B1F1270B3B49C9DA429452328BD1A8BB9285D8202B4CB9B3C2
            C24D77378C142ED3B578DFDB7D5DEF77EF37779E7AEBEB9CF33ECFF9CE77BE73
            288765B88087182D79A734B6E3095AF17CC2090C0D4A58C1369CC6532C24E4E9
            798FCBD887358B11389C216BA28A07A867FCF78AC872AFF93B637B8723388A9B
            197F73A902AD82E7367E150954FA647305357C496C557CC072DCC0582F811C36
            EBD4764B9FD8B731EE5C5140AE4475CCC7E7557D04DAFE5A9FB8FF301533FB81
            393C4B7C67A36D3EC67CEF9548D1CF7227C9701423896FB8CB36899F8B4A3FE2
            B1CEB768E02026309DD8BF62D320E4B00EB3F27F714BE89C038392B7B116B733
            E4B3D8B554F214BB7157984DC7B0B247EC38EEE3D62042233D7CAB714DE8BCF6
            FC2A3504D7E3123EC68B75A1CB86A37F0827F159A784DF84D9055608DD31819D
            D15611A6EAB4D082B98FBC1F57854198DA6BD89A66988E86173824B4657AE9A5
            B064F6E094B02B8E6744A762A9FE41B7C0C5AE4B0D9CC16BFCC14C144C175113
            E7B3052E21D0EFD4B1B7887CE0BD1A51C50E3C2F0AC8ED83195C1706DA023608
            BD3D2ECCA006DE0833E855992C3646B2393C2A9D7B49FC056CF3A5C2D8E9ED6D
            0000000049454E44AE426082}
          Rounded = False
          Spacing = 7
          TabOrder = 6
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
        object btPag6: TAdvGlowButton
          Tag = 7
          AlignWithMargins = True
          Left = 4
          Top = 151
          Width = 161
          Height = 27
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F7 - PIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000016000000160806000000C4B46C
            3B000000097048597300000B1300000B1301009A9C18000000F049444154789C
            BD95310E82301486BFCD1310C5C14DCFE0861E8A45AEA0B87015E11E32B8183C
            85AB989257D360438B807FF22FEDCF97A6EFBD02FE0AC5A329000AA016E7B236
            187A35A0DA37603136B41E020F1CD09FE15B20059E1D50B57792ACD74933F960
            07AC81CA02AD646F2FD9ACABA001501A1FBF801858B5E095ACC592D1EBA50D1E
            B4A0A635FC2ED6505BF60B5E388A94003371E2C8AA3E6FB4F4A8BEBE828767B6
            E994B007D856489BE7FAD4B92378E8711597BF146FB2766B0FC81188808D6340
            22C9760E882935A6678F914E7D477AF24768B26713D1240FBD0937FB5CF5E9E0
            5F932975C2CF44B9F4067E1ADA36613589A10000000049454E44AE426082}
          Rounded = False
          Spacing = 7
          TabOrder = 7
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
        object btPag8: TAdvGlowButton
          Tag = 9
          AlignWithMargins = True
          Left = 4
          Top = 207
          Width = 161
          Height = 27
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          Caption = 'F9 - CUPOM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Roboto'
          Font.Style = [fsBold]
          MarginVert = 0
          MarginHorz = 2
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA864000000206348524D0000
            7A25000080830000F9FF000080E9000075300000EA6000003A980000176F925F
            C546000001594944415478DAECD5B14A5D4110C6F1DF4A50349D18482A09D8D9
            88F65A24F621451E229D8508B636B617E3132856DAEA231888428AA408214520
            90902E8537205CC7668F2C87733C57E162E3C0C032BBEC7FE6DBDDD914114669
            63466C8F804E7B0229A50DBC2E27226235A5748067F7D9382256AB019C214ACF
            F1837AFC0E7E1611ED12A5947A2D5317F8913729ED4F5B298D15B4F8D742B237
            B8CAF11E5E345550013EB648D4ABC537B080930CF986EF98C2CE6D80796CE17F
            07601F1358C40CFE61192B18DC06A86CB35870D820DD15F6B08E2F3981A7C599
            7402DE150BFA0D59955E4A33C0DF2EC0344E3B24AA7C5048F30B73C5C10F9A00
            1F7039C42147716B2A69B6F112C719F2A909D0744D3FE7ECEAF19FB55B738471
            BCC2247E0FF5D0F2E28996B935BCCFE3B7D8CD559CE0F9500FAD43A23BB78AFE
            081A691F52444829CD60B656D979EE494BF7ECA6E73780C71FED4101D703008E
            96174814A1C7810000000049454E44AE426082}
          Rounded = False
          Spacing = 7
          TabOrder = 8
          Visible = False
          OnClick = btPagtoClick
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
          Appearance.ColorMirrorHotTo = 12177407
          Appearance.ColorMirrorDown = 14674687
          Appearance.ColorMirrorDownTo = 14674687
          Appearance.ColorMirrorChecked = 14674687
          Appearance.ColorMirrorCheckedTo = 12177407
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
          Layout = blGlyphLeftAdjusted
        end
      end
    end
    object DBGrid1: TDBGrid
      Tag = 1
      AlignWithMargins = True
      Left = 171
      Top = 1
      Width = 551
      Height = 241
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      DataSource = SouPedidoPag
      DrawingStyle = gdsGradient
      GradientEndColor = 15395562
      GradientStartColor = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Roboto'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 2236186
      TitleFont.Height = -13
      TitleFont.Name = 'Roboto'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'DesForPag'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'FORMA DE PAGAMENTO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 263
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NroNSU'
          Title.Alignment = taCenter
          Title.Caption = 'NSU'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrPago'
          Title.Alignment = taCenter
          Title.Caption = 'VALOR'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 125
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'POS'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Roboto'
          Title.Font.Style = [fsBold]
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          ReadOnly = True
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -12
          Title.Font.Name = 'Roboto'
          Title.Font.Style = []
          Width = 24
          Visible = True
        end>
    end
    object PanelButtons: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 277
      Width = 719
      Height = 30
      Margins.Left = 1
      Margins.Top = 2
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      Color = 15132390
      TabOrder = 2
      DesignSize = (
        719
        30)
      object btSalvar: TAdvGlowButton
        AlignWithMargins = True
        Left = 288
        Top = 3
        Width = 157
        Height = 25
        Cursor = crHandPoint
        Margins.Top = 0
        Margins.Right = 14
        Margins.Bottom = 0
        Anchors = [akLeft, akTop, akBottom]
        Caption = 'Concluir - F10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5131854
        Font.Height = -15
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
          485973000000600000006000F06B42CF0000000774494D4507E70719150F0A25
          04D1D50000017F4944415448C763601805A3801450FF9F89095D8C891C83D041
          EE3665E5AC3BB76EBDE17CF62C779BB232B21C0B350CFF9773E000A3A78C0C43
          3203C3DF2F86860C0C77EF52C50730C3193C6564181818181884B66DFBB37BE3
          46AAF820FDBF82C2BF977BF6C00DF7DEB1E38B6770F042C6DFBF91D561F82097
          D3CC2C779B96162197B3281F3ECCD0ACA0007339134340C042C61F3FD0D5A258
          90B9CCDEFE5FD2C993FF122F5ECCC90E0D253658982C8382267BFDFC894D3D8A
          054C5BFEFF6760606060086161F9BF66D932744B48359C81818181199973FAF2
          C387A62E9F3E31FE747767D0626262700E0A32DF7FE7CEA9AF972FA7FF575060
          E4DBB78FE1999C1C3CCCD3828266A9E1361CC30206060686D3474E9C305DF2E5
          0BE349373786FB4C4C0CD7FDFD4DF3BE7C614E9B3D1B6EB8D0B66D4CB2818184
          0C6760606060C42591555958C8F8A9AF0F43C27BC78E2F9E8181D82294281FA0
          F804165C641A4E14C849CDCFCF7AF3F367F6C9D5AB73B7B1B353CD606480AD10
          1B05A3000E006DFDA65FD6E403700000000049454E44AE426082}
        Rounded = True
        Spacing = 1
        TabOrder = 0
        OnClick = btSalvarClick
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
    end
    object PanelTotais: TLMDSimplePanel
      AlignWithMargins = True
      Left = 2
      Top = 243
      Width = 719
      Height = 30
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 13750737
      Bevel.BorderWidth = 1
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object Label8: TLabel
        AlignWithMargins = True
        Left = 549
        Top = 7
        Width = 64
        Height = 19
        Margins.Top = 6
        Margins.Right = 1
        Align = alRight
        Alignment = taRightJustify
        Caption = #192' PAGAR'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitHeight = 18
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 378
        Top = 7
        Width = 49
        Height = 19
        Margins.Left = 0
        Margins.Top = 6
        Margins.Right = 5
        Align = alRight
        Alignment = taRightJustify
        Caption = 'TROCO'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitHeight = 18
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 7
        Width = 92
        Height = 19
        Margins.Top = 6
        Align = alLeft
        Alignment = taRightJustify
        Caption = 'VALOR PAGO'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitHeight = 18
      end
      object Label3: TLabel
        AlignWithMargins = True
        Left = 219
        Top = 7
        Width = 63
        Height = 19
        Margins.Left = 12
        Margins.Top = 6
        Margins.Right = 2
        Align = alLeft
        Alignment = taRightJustify
        Caption = 'AJUSTES'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitHeight = 18
      end
      object edVlrPagar: TCurrencyEdit
        AlignWithMargins = True
        Left = 618
        Top = 3
        Width = 97
        Height = 24
        Margins.Left = 4
        Margins.Top = 2
        Margins.Bottom = 2
        TabStop = False
        Align = alRight
        AutoSize = False
        Color = 14674687
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object edAjustes: TCurrencyEdit
        AlignWithMargins = True
        Left = 288
        Top = 3
        Width = 74
        Height = 24
        Margins.Left = 4
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 2
        Align = alLeft
        AutoSize = False
        Color = clWhite
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
      end
      object edVlrPago: TCurrencyEdit
        AlignWithMargins = True
        Left = 103
        Top = 3
        Width = 89
        Height = 24
        Margins.Left = 4
        Margins.Top = 2
        Margins.Right = 15
        Margins.Bottom = 2
        Align = alLeft
        AutoSize = False
        Color = clWhite
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        OnExit = edVlrPagoExit
      end
      object edTroco: TCurrencyEdit
        AlignWithMargins = True
        Left = 432
        Top = 3
        Width = 74
        Height = 24
        Margins.Left = 0
        Margins.Top = 2
        Margins.Right = 40
        Margins.Bottom = 2
        TabStop = False
        Align = alRight
        AutoSize = False
        Color = 14674687
        Ctl3D = True
        DisplayFormat = '###,###,##0.00;-###,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
    end
  end
  object PanelTop: TLMDSimplePanel
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 723
    Height = 29
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    Bevel.StyleOuter = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = 13619151
    Bevel.BorderWidth = 1
    Color = 15132390
    TabOrder = 1
    object LMDLabel2: TLMDLabel
      AlignWithMargins = True
      Left = 106
      Top = 5
      Width = 489
      Height = 20
      Margins.Left = 105
      Margins.Top = 4
      Margins.Right = 103
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderWidth = 1
      Align = alClient
      Alignment = agCenter
      Color = 15263976
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Options = []
      ParentColor = False
      ParentFont = False
      Caption = 'PAGAMENTO'
      ExplicitLeft = 117
      ExplicitWidth = 508
    end
    object btFechar: TAdvGlowButton
      Tag = 3099
      AlignWithMargins = True
      Left = 698
      Top = 2
      Width = 24
      Height = 25
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
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
      Appearance.BorderColor = 15132390
      Appearance.BorderColorHot = 15132390
      Appearance.BorderColorCheckedHot = 15132390
      Appearance.BorderColorDown = 15132390
      Appearance.BorderColorChecked = 15132390
      Appearance.BorderColorDisabled = 15132390
      Appearance.BorderColorFocused = 15132390
      Appearance.Color = 15132390
      Appearance.ColorTo = 15132390
      Appearance.ColorChecked = 15132390
      Appearance.ColorCheckedTo = 15132390
      Appearance.ColorDisabled = 15132390
      Appearance.ColorDisabledTo = 15132390
      Appearance.ColorDown = 15132390
      Appearance.ColorDownTo = 15132390
      Appearance.ColorHot = 15132390
      Appearance.ColorHotTo = 15132390
      Appearance.ColorMirror = 15132390
      Appearance.ColorMirrorTo = 15132390
      Appearance.ColorMirrorHot = 15132390
      Appearance.ColorMirrorHotTo = 15132390
      Appearance.ColorMirrorDown = 15132390
      Appearance.ColorMirrorDownTo = 15132390
      Appearance.ColorMirrorChecked = 15132390
      Appearance.ColorMirrorCheckedTo = 15132390
      Appearance.ColorMirrorDisabled = 15132390
      Appearance.ColorMirrorDisabledTo = 15132390
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
  object TabPedidoPag: TRESTDWClientSQL
    Active = False
    BeforeInsert = TabPedidoPagBeforeInsert
    BeforePost = TabPedidoPagBeforePost
    AfterPost = TabPedidoPagAfterPost
    Filtered = False
    FieldDefs = <
      item
        Name = 'IDFilial'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'IDPed'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Nropag'
        Attributes = [faRequired]
        DataType = ftSmallint
      end
      item
        Name = 'IDForPag'
        Attributes = [faRequired]
        DataType = ftSmallint
      end
      item
        Name = 'IndPOS'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IDCartao'
        DataType = ftSmallint
      end
      item
        Name = 'NroNSU'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'Tipcar'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'VlrPago'
        DataType = ftFloat
      end
      item
        Name = 'DesForPag'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Nomred'
        DataType = ftString
        Size = 12
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
    MasterCascadeDelete = False
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <
      item
        DataType = ftInteger
        Name = 'IDFilial'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDPed'
        ParamType = ptInput
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      'SELECT PAG.*,FPG.DesForPag,CAR.Nomred  FROM arqpedidopag PAG'
      'LEFT JOIN  arqforpagto FPG ON PAG.IDForPag = FPG.IDForPag'
      'LEFT JOIN arqcartao CAR ON CAR.IDCartao = PAG.IDCartao'
      'WHERE PAG.IDFilial = :IDFilial AND PAG.IDPed = :IDPed')
    UpdateTableName = 'arqpedidopag'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 661
    Top = 76
    object TabPedidoPagIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoPagIDPed: TIntegerField
      FieldName = 'IDPed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoPagNropag: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'Nropag'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoPagIDForPag: TSmallintField
      FieldName = 'IDForPag'
      Required = True
    end
    object TabPedidoPagIndPOS: TWideStringField
      FieldName = 'IndPOS'
      Size = 1
    end
    object TabPedidoPagIDCartao: TSmallintField
      FieldName = 'IDCartao'
    end
    object TabPedidoPagNroNSU: TWideStringField
      FieldName = 'NroNSU'
      Size = 12
    end
    object TabPedidoPagTipcar: TWideStringField
      FieldName = 'Tipcar'
      Size = 1
    end
    object TabPedidoPagVlrPago: TFloatField
      FieldName = 'VlrPago'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedidoPagDesForPag: TWideStringField
      FieldName = 'DesForPag'
      ProviderFlags = []
    end
    object TabPedidoPagNomred: TWideStringField
      FieldName = 'Nomred'
      ProviderFlags = []
      Size = 12
    end
  end
  object SouPedidoPag: TDataSource
    DataSet = TabPedidoPag
    Left = 661
    Top = 140
  end
end
