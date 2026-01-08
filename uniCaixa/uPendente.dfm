object FrmCxPend: TFrmCxPend
  Left = 0
  Top = 0
  Align = alClient
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'CAIXA - Pendentes'
  ClientHeight = 501
  ClientWidth = 1100
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 2236186
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 14
  object PanelPri: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1100
    Height = 501
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Bevel.StyleInner = bvNormal
    Bevel.WidthInner = 0
    Bevel.WidthOuter = 0
    Bevel.BorderColor = clSilver
    Color = 16382975
    TabOrder = 0
    object LMDSimplePanel6: TLMDSimplePanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 1100
      Height = 253
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Color = clWhitesmoke
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object Shape3: TShape
        Left = 0
        Top = 252
        Width = 1100
        Height = 1
        Align = alBottom
        Pen.Color = 14145495
        ExplicitLeft = 2
        ExplicitTop = 34
        ExplicitWidth = 1149
      end
      object Shape5: TShape
        Left = 0
        Top = 0
        Width = 1100
        Height = 0
        Align = alTop
        Pen.Color = 14145495
        ExplicitTop = 9
        ExplicitWidth = 1133
      end
      object LMDSimplePanel1: TLMDSimplePanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 1100
        Height = 252
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Color = clWhitesmoke
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object Shape2: TShape
          Left = 0
          Top = 0
          Width = 1100
          Height = 0
          Align = alTop
          Pen.Color = 14145495
          ExplicitTop = 9
          ExplicitWidth = 1133
        end
        object Shape1: TShape
          Left = 0
          Top = 0
          Width = 1100
          Height = 1
          Align = alTop
          Pen.Color = 14145495
          ExplicitLeft = 2
          ExplicitTop = 34
          ExplicitWidth = 1149
        end
        object DBGrid1: TDBGrid
          Tag = 1
          AlignWithMargins = True
          Left = 0
          Top = 32
          Width = 1100
          Height = 203
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DataSource = SouPedido
          DrawingStyle = gdsGradient
          GradientEndColor = 15658734
          GradientStartColor = 15658734
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2236186
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = 2236186
          TitleFont.Height = -12
          TitleFont.Name = 'Roboto'
          TitleFont.Style = []
          OnCellClick = DBGrid1CellClick
          OnDrawColumnCell = DBGrid2DrawColumnCell
          OnDblClick = DBGrid1DblClick
          OnKeyDown = DBGrid1KeyDown
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'NroCesta'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2236186
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'CESTA'
              Title.Color = clNone
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 58
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'IDPed'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'PEDIDO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 82
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Datped'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2236186
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'DATA / HORA'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 140
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NomeCli'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'CLIENTE'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 228
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TotPedido'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'VALOR'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 97
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Nomven'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2236186
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'VENDEDOR'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 147
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DesForPag'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2236186
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'FORMA PAGTO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 155
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'NomPBM'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2236186
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'PBM'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 115
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'IndEntr'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2236186
              Font.Height = -15
              Font.Name = 'Roboto'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'ENTR.'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = 2236186
              Title.Font.Height = -15
              Title.Font.Name = 'Roboto'
              Title.Font.Style = [fsBold]
              Width = 48
              Visible = True
            end>
        end
        object PanelTop: TLMDSimplePanel
          Left = 0
          Top = 1
          Width = 1100
          Height = 31
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Bevel.BorderColor = 14342874
          Color = 15528703
          TabOrder = 1
          object LMDLabel8: TLMDLabel
            AlignWithMargins = True
            Left = 466
            Top = 6
            Width = 162
            Height = 19
            Margins.Left = 100
            Margins.Top = 4
            Margins.Right = 150
            Margins.Bottom = 0
            Alignment = agCenter
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 16582
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'VENDAS PENDENTES'
          end
          object AdvGlowButton1: TAdvGlowButton
            Tag = 3
            Left = 1198
            Top = 23
            Width = 21
            Height = 21
            Cursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -12
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Picture.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000002C849
              44415448899D964D68136110869FF952F5A0D48322DAA287A2945E4AD7509152
              ED558516BDE94510A468412D66D3A207B129283689222A2A1E3D0852C57F45F1
              A07850D06CED495BA44AB5828288284893EC788849369B64A39DE33BB3CF3BF3
              B13BDF0A01A1035603597A10BA8126D0469010F011E43DEADE03B92149E74335
              86540447C24B11D706FA8105414D002EC835C80C4A627CAAA68146ACCD085780
              C535C0FEF885CA4E49A6AE7B45E383EF41B83D0738C0424447D5B60E7AC5C204
              1A5DBB09D53B40680EF0923E41B64B2275B560A0FDE115D4B96F807A8FF57394
              34B0A106F029C27C94F51EED2726DB2223E31F734734CF8D95C1E34E87249C8D
              A04703E0C39270BA883B1DA02F3CFA225C1303307AB07D25CA2EDF9069010590
              C4D810E8E12AF023B97E50205D9A969D3A185E6530996D949FFB068DB49D2894
              26C68E039162033A92870368D41A02E9F4314264DDAD06D85271789101B5AD58
              D1C439091C00862539365880DB560CE5482504B059D4B62681D5550A72DD7A80
              25A9A8351400079830C0F28082B2490AF0E0CEF3D16000B74691227CAD204FF3
              F7450888AC016682E1B24FE2CE99A290FB7624317609917D354C3E1B6032189E
              3A57106CEB18D1B60B059378EA5CA0893061406F574EFAE16BE3C021547AAB98
              94872B770DE9CC2D60D6477F98872B88DAD66950BB389BF4625BE74B4D78E4C3
              CF6242B772BBC86E3B05D2EF49BEE68769A7E155969FD659606FC50EE1228B9C
              3E66C221EADD97406BB109CE48D2D99F3338B46E09E9F41B60A9E7E1772019D0
              E62AF0FCB46F11771E2A4D1EF11B645B2431FEA5B8AE23E14EC47D0CCC0F06D6
              8C2C4AB7249DFBE0B97024F9EA19CA6ECA96D6FFC2A52F0F874A5766D4EA4219
              A5F4B8FE25BE23B243E2A9075ED1F8AB24EE3C213BDB0C9C007EFF03D8052E23
              752D7E3854F9ABC887DAADCB50D383916E94354023B9D53E0D4CA17A07576FCA
              A9D79FAA31FE00CB8E108EC042D2D10000000049454E44AE426082}
            Rounded = True
            ShowCaption = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Appearance.BorderColor = 11382963
            Appearance.BorderColorHot = 11565130
            Appearance.BorderColorCheckedHot = 11565130
            Appearance.BorderColorDown = 11565130
            Appearance.BorderColorChecked = 13744549
            Appearance.BorderColorDisabled = 13948116
            Appearance.BorderColorFocused = 15528703
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
          object AdvGlowButton2: TAdvGlowButton
            Tag = 3
            Left = 1223
            Top = 23
            Width = 21
            Height = 21
            Cursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -12
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Picture.Data = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000026B49
              4441544889AD96BF4F535114C73FE7BEE224EC580A18D0E820D812FE08904058
              74C0C904A3891229142609244E14D068620C264E3A11A302253A60FF00639F3A
              E806FE0071324116135EEF7178D8B4F5B514EA19BFE79ECF39F7E67B6FAE5026
              34DE19C164FB40CF01CD40642FF50D58472485782F64FAC3462986048287DBC3
              846402954B40A8DC108005798A6A4266DD2FFB36D078B417A38F416AF7011757
              EE80199099CC52BE6A0A9624A2D7313C3B381CFC1A7DAEA3B16B056A0E3E12ED
              4258029C83C30BC262E997397731D74087DBC338F2E9709307C62F3C734AEEBC
              DDF28FC8315355C145D7809F794A1D35D9493F15EF8C60BC750E7B34CA23BEB6
              5E26F2F95811C7236B9B8DEFF32AE0B5EEA02C2C6439B2EB50E8CA1046FA0C68
              7755F049AC0EB787F1E41545AE444CB7015A02CA37808F15C1C7DA1A704C1A38
              19B0B0C580D617A91E35356739EA9E41B957161EEF8C609D3470A2C4246113A0
              3AECFEAE9749ACCCBA43283703E1E31D8D182F0DB496DC296040B68A34016755
              47621D0032EBDE02B902F2B0006EB369828F371FB5293A1A5D01BA02B6B78395
              7E9973570BD4916813421A385E1E0E20298348AA44B216C38A26621772F0F18E
              468CBEAE0C0EA82E8B8EB535609D754A3FCB166402B12E2AF781A68AE07B17CD
              7F8B4663F3A08315165616C20349BA577D17199DF4DFF3FF16DB109A82BD9B27
              D3EE77C49C07B2FF016E11B928C9373F720D00249979097203B055C287249959
              CE718B576822D683EA13A0EE80F06DD001997957E0CA7F6EB22433CBA86901EE
              025E05600FD1793C73BA180E257E157FC3FF5D985E941E7CEFE77D5B640DD114
              9E5D94DBEF374B31FE002B96E3D4261DE3E90000000049454E44AE426082}
            Rounded = True
            ShowCaption = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Appearance.BorderColor = 11382963
            Appearance.BorderColorHot = 11565130
            Appearance.BorderColorCheckedHot = 11565130
            Appearance.BorderColorDown = 11565130
            Appearance.BorderColorChecked = 13744549
            Appearance.BorderColorDisabled = 13948116
            Appearance.BorderColorFocused = 15528703
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
        end
        object LMDSimplePanel3: TLMDSimplePanel
          AlignWithMargins = True
          Left = 0
          Top = 235
          Width = 1100
          Height = 17
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alBottom
          TabOrder = 2
          object LMDSimplePanel4: TLMDSimplePanel
            Left = 382
            Top = 1
            Width = 337
            Height = 16
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 1973271
            Font.Height = -12
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object LMDLabel1: TLMDLabel
              Left = 223
              Top = 0
              Width = 13
              Height = 16
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alLeft
              Alignment = agCenter
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 6710886
              Font.Height = -17
              Font.Name = 'Roboto'
              Font.Style = []
              Options = []
              ParentFont = False
              Caption = ' '#9658
              ExplicitLeft = 217
              ExplicitTop = -1
            end
            object LMDLabel2: TLMDLabel
              AlignWithMargins = True
              Left = 242
              Top = 2
              Width = 95
              Height = 14
              Margins.Left = 6
              Margins.Top = 2
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alLeft
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 6710886
              Font.Height = -11
              Font.Name = 'Roboto'
              Font.Style = [fsBold]
              Options = []
              ParentFont = False
              Caption = 'FINALIZAR VENDA'
              ExplicitLeft = 236
            end
            object LMDLabel3: TLMDLabel
              AlignWithMargins = True
              Left = 0
              Top = 4
              Width = 223
              Height = 9
              Margins.Left = 0
              Margins.Top = 4
              Margins.Right = 0
              Align = alLeft
              Alignment = agCenterLeft
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 6710886
              Font.Height = -11
              Font.Name = 'Roboto'
              Font.Style = [fsBold]
              Options = []
              ParentFont = False
              Caption = 'DUPLO CLIQUE SOBRE VENDA / F5 / ENTER'
            end
          end
        end
      end
    end
    object LMDSimplePanel2: TLMDSimplePanel
      AlignWithMargins = True
      Left = 0
      Top = 253
      Width = 1100
      Height = 249
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Bevel.StyleOuter = bvNormal
      Bevel.WidthInner = 0
      Bevel.WidthOuter = 0
      Bevel.BorderColor = 14145495
      Color = 16316664
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      object DBGrid2: TDBGrid
        Tag = 2
        AlignWithMargins = True
        Left = 0
        Top = 33
        Width = 1100
        Height = 195
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = SouPedIte
        DrawingStyle = gdsGradient
        GradientEndColor = 15658734
        GradientStartColor = 15658734
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2236186
        Font.Height = -12
        Font.Name = 'Roboto'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = 2236186
        TitleFont.Height = -12
        TitleFont.Name = 'Roboto'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid2DrawColumnCell
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2236186
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'SIT'
            Title.Color = clNone
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 5987163
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Despro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'DESCRI'#199#195'O DO PRODUTO'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 452
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Qtdped'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2236186
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'QUANT.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QtdConf'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2236186
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'QT.CONF'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PrecoVen'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'VLR.UNI. R$'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 106
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'PerDesc'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2236186
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'DESC. %'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 63
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TotItemCalc'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2236186
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'TOTAL R$'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 106
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Nomven'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2236186
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'VENDEDOR'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 134
            Visible = True
          end
          item
            Expanded = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2236186
            Font.Height = -15
            Font.Name = 'Roboto'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = 2236186
            Title.Font.Height = -15
            Title.Font.Name = 'Roboto'
            Title.Font.Style = [fsBold]
            Width = 32
            Visible = True
          end>
      end
      object PanelBot: TLMDSimplePanel
        AlignWithMargins = True
        Left = 0
        Top = 229
        Width = 1100
        Height = 19
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alBottom
        TabOrder = 1
        object PanelHelp: TLMDSimplePanel
          Left = 375
          Top = 2
          Width = 350
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1973271
          Font.Height = -12
          Font.Name = 'Roboto'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object LMDLabel10: TLMDLabel
            Left = 264
            Top = 0
            Width = 13
            Height = 16
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 5
            Align = alLeft
            Alignment = agCenter
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6710886
            Font.Height = -17
            Font.Name = 'Roboto'
            Font.Style = []
            Options = []
            ParentFont = False
            Caption = ' '#9658
            ExplicitTop = -4
          end
          object LMDLabel9: TLMDLabel
            AlignWithMargins = True
            Left = 283
            Top = 2
            Width = 69
            Height = 14
            Margins.Left = 6
            Margins.Top = 2
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6710886
            Font.Height = -11
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'EDITAR ITEM'
            ExplicitLeft = 756
            ExplicitTop = 4
            ExplicitHeight = 12
          end
          object LMDLabel11: TLMDLabel
            AlignWithMargins = True
            Left = 0
            Top = 4
            Width = 264
            Height = 9
            Margins.Left = 0
            Margins.Top = 4
            Margins.Right = 0
            Align = alLeft
            Alignment = agCenterLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6710886
            Font.Height = -11
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            Options = []
            ParentFont = False
            Caption = 'DUPLO CLIQUE SOBRE O ITEM VENDIDO OU CTRL E'
            ExplicitLeft = 48
          end
        end
      end
      object PanelConf: TLMDSimplePanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 1100
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alTop
        Bevel.BorderColor = 14342874
        Color = 14674687
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        DesignSize = (
          1100
          32)
        object AdvGlowButton3: TAdvGlowButton
          Tag = 3
          Left = 1198
          Top = 23
          Width = 21
          Height = 21
          Cursor = crHandPoint
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A000002C849
            44415448899D964D68136110869FF952F5A0D48322DAA287A2945E4AD7509152
            ED558516BDE94510A468412D66D3A207B129283689222A2A1E3D0852C57F45F1
            A07850D06CED495BA44AB5828288284893EC788849369B64A39DE33BB3CF3BF3
            B13BDF0A01A1035603597A10BA8126D0469010F011E43DEADE03B92149E74335
            86540447C24B11D706FA8105414D002EC835C80C4A627CAAA68146ACCD085780
            C535C0FEF885CA4E49A6AE7B45E383EF41B83D0738C0424447D5B60E7AC5C204
            1A5DBB09D53B40680EF0923E41B64B2275B560A0FDE115D4B96F807A8FF57394
            34B0A106F029C27C94F51EED2726DB2223E31F734734CF8D95C1E34E87249C8D
            A04703E0C39270BA883B1DA02F3CFA225C1303307AB07D25CA2EDF9069010590
            C4D810E8E12AF023B97E50205D9A969D3A185E6530996D949FFB068DB49D2894
            26C68E039162033A92870368D41A02E9F4314264DDAD06D85271789101B5AD58
            D1C439091C00862539365880DB560CE5482504B059D4B62681D5550A72DD7A80
            25A9A8351400079830C0F28082B2490AF0E0CEF3D16000B74691227CAD204FF3
            F7450888AC016682E1B24FE2CE99A290FB7624317609917D354C3E1B6032189E
            3A57106CEB18D1B60B059378EA5CA0893061406F574EFAE16BE3C021547AAB98
            94872B770DE9CC2D60D6477F98872B88DAD66950BB389BF4625BE74B4D78E4C3
            CF6242B772BBC86E3B05D2EF49BEE68769A7E155969FD659606FC50EE1228B9C
            3E66C221EADD97406BB109CE48D2D99F3338B46E09E9F41B60A9E7E1772019D0
            E62AF0FCB46F11771E2A4D1EF11B645B2431FEA5B8AE23E14EC47D0CCC0F06D6
            8C2C4AB7249DFBE0B97024F9EA19CA6ECA96D6FFC2A52F0F874A5766D4EA4219
            A5F4B8FE25BE23B243E2A9075ED1F8AB24EE3C213BDB0C9C007EFF03D8052E23
            752D7E3854F9ABC887DAADCB50D383916E94354023B9D53E0D4CA17A07576FCA
            A9D79FAA31FE00CB8E108EC042D2D10000000049454E44AE426082}
          Rounded = True
          ShowCaption = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Appearance.BorderColor = 11382963
          Appearance.BorderColorHot = 11565130
          Appearance.BorderColorCheckedHot = 11565130
          Appearance.BorderColorDown = 11565130
          Appearance.BorderColorChecked = 13744549
          Appearance.BorderColorDisabled = 13948116
          Appearance.BorderColorFocused = 15528703
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
        object AdvGlowButton4: TAdvGlowButton
          Tag = 3
          Left = 1223
          Top = 23
          Width = 21
          Height = 21
          Cursor = crHandPoint
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
            F8000000097048597300000EC300000EC301C76FA8640000001974455874536F
            667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000026B49
            4441544889AD96BF4F535114C73FE7BEE224EC580A18D0E820D812FE08904058
            74C0C904A3891229142609244E14D068620C264E3A11A302253A60FF00639F3A
            E806FE0071324116135EEF7178D8B4F5B514EA19BFE79ECF39F7E67B6FAE5026
            34DE19C164FB40CF01CD40642FF50D58472485782F64FAC3462986048287DBC3
            846402954B40A8DC108005798A6A4266DD2FFB36D078B417A38F416AF7011757
            EE80199099CC52BE6A0A9624A2D7313C3B381CFC1A7DAEA3B16B056A0E3E12ED
            4258029C83C30BC262E997397731D74087DBC338F2E9709307C62F3C734AEEBC
            DDF28FC8315355C145D7809F794A1D35D9493F15EF8C60BC750E7B34CA23BEB6
            5E26F2F95811C7236B9B8DEFF32AE0B5EEA02C2C6439B2EB50E8CA1046FA0C68
            7755F049AC0EB787F1E41545AE444CB7015A02CA37808F15C1C7DA1A704C1A38
            19B0B0C580D617A91E35356739EA9E41B957161EEF8C609D3470A2C4246113A0
            3AECFEAE9749ACCCBA43283703E1E31D8D182F0DB496DC296040B68A34016755
            47621D0032EBDE02B902F2B0006EB369828F371FB5293A1A5D01BA02B6B78395
            7E9973570BD4916813421A385E1E0E20298348AA44B216C38A26621772F0F18E
            468CBEAE0C0EA82E8B8EB535609D754A3FCB166402B12E2AF781A68AE07B17CD
            7F8B4663F3A08315165616C20349BA577D17199DF4DFF3FF16DB109A82BD9B27
            D3EE77C49C07B2FF016E11B928C9373F720D00249979097203B055C287249959
            CE718B576822D683EA13A0EE80F06DD001997957E0CA7F6EB22433CBA86901EE
            025E05600FD1793C73BA180E257E157FC3FF5D985E941E7CEFE77D5B640DD114
            9E5D94DBEF374B31FE002B96E3D4261DE3E90000000049454E44AE426082}
          Rounded = True
          ShowCaption = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Appearance.BorderColor = 11382963
          Appearance.BorderColorHot = 11565130
          Appearance.BorderColorCheckedHot = 11565130
          Appearance.BorderColorDown = 11565130
          Appearance.BorderColorChecked = 13744549
          Appearance.BorderColorDisabled = 13948116
          Appearance.BorderColorFocused = 15528703
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
        object edConfPro: TLMDLabeledEdit
          Left = 317
          Top = 4
          Width = 466
          Height = 24
          Bevel.StyleOuter = bvNormal
          Bevel.WidthInner = 0
          Bevel.WidthOuter = 0
          Bevel.BorderColor = 12500670
          Bevel.BorderWidth = 1
          Bevel.Mode = bmCustom
          Caret.BlinkRate = 530
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 2
          OnExit = edConfProExit
          OnKeyDown = edConfProKeyDown
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3617579
          Font.Height = -15
          Font.Name = 'Roboto'
          Font.Style = []
          CharCase = ecUpperCase
          ParentFont = False
          CustomButtons = <
            item
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000016000000160806000000C4B46C
                3B000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC100000EC101B8916BED0000001974455874536F667477
                617265007777772E696E6B73636170652E6F72679BEE3C1A0000018769545874
                584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420
                626567696E3D27EFBBBF272069643D2757354D304D7043656869487A7265537A
                4E54637A6B633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D
                2261646F62653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A
                7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32
                322D7264662D73796E7461782D6E7323223E3C7264663A446573637269707469
                6F6E207264663A61626F75743D22757569643A66616635626464352D62613364
                2D313164612D616433312D6433336437353138326631622220786D6C6E733A74
                6966663D22687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E
                302F223E3C746966663A4F7269656E746174696F6E3E313C2F746966663A4F72
                69656E746174696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264
                663A5244463E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E
                643D2777273F3E2C94980B000000844944415478DA63FC0F040C34008CC3D760
                4B4BCB3340EAFFF1E3C74DA96AB0A3A32398DEBF7F3F755D3C6A306D0DB6B5B5
                55676161B90962FFF9F347FDF0E1C33749321894A43838384C8872121AF8F9F3
                E7A963C78E99E132F834D060A2D22916834F020D36A76F50E003432B558C1A8C
                02ACACAC4E01A9FFC8498A2A06930A869EC10074549FBF8F4184B50000000049
                454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              Index = 0
              DisplayName = 'TLMDSpecialButton'
              OnClick = edConfProCustomButtons0Click
              UsePngGlyph = True
            end
            item
              ParentFont = False
              PngGlyph.Data = {
                89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
                F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000EC100000EC101B8916BED0000001974455874536F667477
                617265007777772E696E6B73636170652E6F72679BEE3C1A0000018769545874
                584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420
                626567696E3D27EFBBBF272069643D2757354D304D7043656869487A7265537A
                4E54637A6B633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D
                2261646F62653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A
                7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32
                322D7264662D73796E7461782D6E7323223E3C7264663A446573637269707469
                6F6E207264663A61626F75743D22757569643A66616635626464352D62613364
                2D313164612D616433312D6433336437353138326631622220786D6C6E733A74
                6966663D22687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E
                302F223E3C746966663A4F7269656E746174696F6E3E313C2F746966663A4F72
                69656E746174696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264
                663A5244463E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E
                643D2777273F3E2C94980B000001984944415478DAED923D48C35014859B6470
                E8A0AEED2694261111C14137A19B9B089D85EA26BA2885E20F8A888B220E8A83
                7475B0834E057F7014CC22129B14028276110A2A4E8144BF4085226924AD2242
                2F3CCE4DDE79E7DC77DF15DE89C82F86D036F83F06BD84EBBA73A4231CE91204
                E1013C9624695BD7F56A4B06B22C67803D441FC102ABCAB104DF69F2578C474D
                D3BC69CA20994CA644513C25DD8F46A3B39AA6D99F7B8AA2C4801356CCB66DD5
                B2ACE7D0068868C09B611829A88ECFBE6762B2B70567399401AD89D3860AE978
                A9542A04F00EE00DC2E90F65A0AAEA10DB57A47D1CBE0D30980772DCA03BEC0D
                642A3378C4148F781ED0C64D608C227A4219202EF1C8F7A445AA9BF2E330BD1D
                14E0BDC1199CC95006B5EAA6811D6869048EBE16C0257749271CC7192897CB77
                CD187893B1C272A1E619D943C49EBC0E92CF80C3FCCF609EF7ED429001E24BC0
                2A9445F0858AB360BC8E72CD5E16F18B866D6E645027BE80C05AAD25222D49D0
                F34E6F7CF95F897C13BE0688E780F57AF166A391C1255064EC365A110F6CD14F
                45DBE0EF0D3E0081571BC8AB45C6AC0000000049454E44AE426082}
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Index = 1
              DisplayName = 'TLMDSpecialButton'
              OnClick = edConfProCustomButtons1Click
              UsePngGlyph = True
            end>
          CustomButtonsStyle = ubsDelphiFlat
          CustomButtonWidth = 20
          PasswordChar = #0
          Spelling.LiveSpell = True
          TabOnEnter = True
          Text = ''
          LabelPosition = lpLeft
          LabelSync = True
          EditLabel.Width = 120
          EditLabel.Height = 24
          EditLabel.AutoSize = False
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = 16582
          EditLabel.Font.Height = -12
          EditLabel.Font.Name = 'Roboto'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          EditLabel.Caption = 'CONFERE PRODUTOS'
        end
      end
    end
  end
  object ImagesCx: TImageList
    Height = 18
    Width = 18
    Left = 36
    Top = 416
    Bitmap = {
      494C010104000800040012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000480000002400000001002000000000008028
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DADAFD008383F8004747F5002B2BF4002B2BF4004747F5008484
      F800DADAFD000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECC09D00A788BA00876EC700886F
      C600A889B900EDC19C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CDBAC6008A7D
      D9006B61E1006B61E1008B7ED900CEBBC6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E4F8
      E40081DD810036C9360014BF140014BF140037C9370081DD8100E4F8E4000000
      000000000000000000000000000000000000000000000000000000000000FAFA
      FF007F7FF8002424F3002121F3002121F3002121F3002121F3002121F3002121
      F3002424F3008181F800FBFBFF00000000000000000000000000000000000000
      00000000000000000000E8BD9F006250D6000403FD000000FF000000FF000000
      FF000000FF000403FD006452D500E9BE9E000000000000000000000000000000
      000000000000000000000000000000000000CBB9C700453FEC000000FF000000
      FF000000FF000000FF000000FF000000FF004741EB00CDBAC600000000000000
      00000000000000000000000000000000000000000000000000008BE08B000ABD
      0A0000BA000000BA000000BA000000BA000000BA000000BA00000ABD0A008BE0
      8B00000000000000000000000000000000000000000000000000FAFAFF005B5B
      F6002121F3002121F3002121F3002121F3002121F3002121F3002121F3002121
      F3002121F3002121F3005C5CF600FBFBFF000000000000000000000000000000
      000000000000D0AAA9001C17F3000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF001D18F300D2ABA80000000000000000000000
      0000000000000000000000000000B2A2CE000E0DFB000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000F0EFB00B3A3CE000000
      0000000000000000000000000000000000000000000067D6670000BA000000BA
      000000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA
      000067D6670000000000000000000000000000000000000000007E7EF8002121
      F3002121F3002121F3002121F3005D5DF600D9D9FD00D9D9FD005C5CF6002121
      F3002121F3002121F3002121F3008181F8000000000000000000000000000000
      0000E7BC9F001B16F4000000FF000000FF000000FF000000FF007C7CFF007C7C
      FF000000FF000000FF000000FF000000FF001D18F300E9BE9E00000000000000
      00000000000000000000CBB9C7000E0DFB000000FF000000FF000000FF000606
      FF00A8A8FF00A5A5FF000606FF000000FF000000FF000000FF000F0EFB00CDBA
      C6000000000000000000000000000000000095E2950000BA000000BA000000BA
      000000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA
      000000BA000097E39700000000000000000000000000D9D9FD002424F3002121
      F3002121F3002121F3002121F3007777F800F9F9FF00F9F9FF007676F8002121
      F3002121F3002121F3002121F3002424F300DADAFD0000000000000000000000
      0000614FD7000000FF000000FF000000FF000000FF000000FF00C0C0FF00C0C0
      FF000000FF000000FF000000FF000000FF000000FF006552D500000000000000
      00000000000000000000453FEC000000FF000000FF000000FF000606FF00B3B3
      FF00FFFFFF00FFFFFF00B3B3FF000606FF000000FF000000FF000000FF004842
      EB00000000000000000000000000EFFBEF0011BF110000BA000000BA000000BA
      000000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA
      000000BA000012BF1200EFFBEF0000000000000000008282F8002121F3002121
      F3002121F3002121F3002121F3002121F300D3D3FD00D3D3FD002121F3002121
      F3002121F3002121F3002121F3002121F3008484F8000000000000000000EBC0
      9D000403FD000000FF000000FF000000FF000000FF000000FF00C0C0FF00C0C0
      FF000000FF000000FF000000FF000000FF000000FF000403FD00EDC19C000000
      000000000000CBB9C7000000FF000000FF000000FF000606FF00B2B2FF00FEFE
      FF00F3F3FF00F3F3FF00FEFEFF00B3B3FF000606FF000000FF000000FF000000
      FF00CDBAC600000000000000000099E3990000BA000000BA000000BA000000BA
      000008BC0800A1E6A1009AE49A0005BB050000BA000000BA000000BA000000BA
      000000BA000000BA00009AE49A0000000000000000004646F5002121F3002121
      F3002121F3002121F3002121F3002121F300D3D3FD00D3D3FD002121F3002121
      F3002121F3002121F3002121F3002121F3004747F5000000000000000000A788
      BA000000FF000000FF000000FF000000FF000000FF000000FF00C0C0FF00C0C0
      FF000000FF000000FF000000FF000000FF000000FF000000FF00A889B9000000
      000000000000897CD9000000FF000000FF000101FF00B3B3FF00FEFEFF006B6B
      FF00C2C2FF00C2C2FF006D6DFF00FEFEFF00B1B1FF000000FF000000FF000000
      FF008B7ED900000000000000000053D0530000BA000000BA000000BA000008BC
      0800B7ECB7000000000000000000AFE9AF0005BB050000BA000000BA000000BA
      000000BA000000BA000054D1540000000000000000002C2CF4002121F3002121
      F3002121F3002121F3002121F3002121F300D3D3FD00D3D3FD002121F3002121
      F3002121F3002121F3002121F3002121F3002D2DF4000000000000000000876E
      C7000000FF000000FF000000FF000000FF000000FF000000FF00C0C0FF00C0C0
      FF000000FF000000FF000000FF000000FF000000FF000000FF008970C6000000
      0000000000006C62E1000000FF000000FF000A0AFF00D8D8FF006868FF000000
      FF00C2C2FF00C2C2FF000000FF006C6CFF00DDDDFF000A0AFF000000FF000000
      FF006D63E100000000000000000036C9360000BA000000BA000000BA0000A1E6
      A10000000000A7E7A700B0EAB00000000000AFE9AF0005BB050000BA000000BA
      000000BA000000BA000036C9360000000000000000002B2BF4002121F3002121
      F3002121F3002121F3002121F3007777F800F9F9FF00D3D3FD002121F3002121
      F3002121F3002121F3002121F3002121F3002C2CF4000000000000000000866D
      C7000000FF000000FF000505FF00D9D9FF007373FF000000FF00C0C0FF00C0C0
      FF000000FF006F6FFF00D5D5FF000505FF000000FF000000FF00876EC7000000
      0000000000006A60E2000000FF000000FF000000FF000000FF000000FF000000
      FF00C2C2FF00C2C2FF000000FF000000FF000000FF000000FF000000FF000000
      FF006C62E100000000000000000036C9360000BA000000BA000000BA00007DDC
      7D0090E1900004BB040006BC0600B0EAB00000000000AFE9AF0005BB050000BA
      000000BA000000BA000036C9360000000000000000004646F5002121F3002121
      F3002121F3002121F3002121F3005D5DF600B5B5FB007373F7002121F3002121
      F3002121F3002121F3002121F3002121F3004747F5000000000000000000A687
      BA000000FF000000FF000000FF00A3A3FF00FFFFFF007575FF00C0C0FF00C0C0
      FF007272FF00FFFFFF00A6A6FF000000FF000000FF000000FF00A889B9000000
      000000000000887BD9000000FF000000FF000000FF000000FF000000FF000000
      FF00C2C2FF00C2C2FF000000FF000000FF000000FF000000FF000000FF000000
      FF008A7DD900000000000000000053D0530000BA000000BA000000BA000000BA
      000000BA000000BA000000BA000006BC0600B0EAB000000000009AE49A0000BA
      000000BA000000BA000054D1540000000000000000008181F8002121F3002121
      F3002121F3002121F3002121F3002121F3004040F5003F3FF5002121F3002121
      F3002121F3002121F3002121F3002121F3008383F8000000000000000000EBC0
      9D000302FE000000FF000000FF000303FF00A7A7FF00FFFFFF00F4F4FF00F4F4
      FF00FFFFFF00A8A8FF000404FF000000FF000000FF000403FD00ECC09D000000
      000000000000CAB8C7000000FF000000FF000000FF000000FF000000FF000000
      FF00C2C2FF00C2C2FF000000FF000000FF000000FF000000FF000000FF000000
      FF00CCBAC700000000000000000098E3980000BA000000BA000000BA000000BA
      000000BA000000BA000000BA000000BA000006BC06009BE49B0088DF880000BA
      000000BA000000BA000099E399000000000000000000D8D8FD002323F3002121
      F3002121F3002121F3002121F3002121F300EEEEFE00EDEDFE002121F3002121
      F3002121F3002121F3002121F3002424F300DADAFD0000000000000000000000
      00005E4DD8000000FF000000FF000000FF000303FF00A7A7FF00FFFFFF00FFFF
      FF00A8A8FF000404FF000000FF000000FF000000FF006250D600000000000000
      00000000000000000000433CED000000FF000000FF000000FF000000FF000000
      FF00C2C2FF00C2C2FF000000FF000000FF000000FF000000FF000000FF00453F
      EC00000000000000000000000000EEFAEE0011BF110000BA000000BA000000BA
      000000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA
      000000BA000012BF1200EFFBEF000000000000000000000000007C7CF8002121
      F3002121F3002121F3002121F3002121F3008A8AF9008989F9002121F3002121
      F3002121F3002121F3002121F3007F7FF8000000000000000000000000000000
      0000E6BC9F001A15F4000000FF000000FF000000FF000303FF009898FF009999
      FF000404FF000000FF000000FF000000FF001C17F300E8BD9F00000000000000
      00000000000000000000CAB8C7000D0CFB000000FF000000FF000000FF000000
      FF008787FF008787FF000000FF000000FF000000FF000000FF000E0DFB00CBB9
      C7000000000000000000000000000000000095E2950000BA000000BA000000BA
      000000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA
      000000BA000097E3970000000000000000000000000000000000F9F9FF005A5A
      F6002121F3002121F3002121F3002121F3002121F3002121F3002121F3002121
      F3002121F3002121F3005A5AF600FAFAFF000000000000000000000000000000
      000000000000CFA9A9001A15F4000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF001B16F400D1AAA80000000000000000000000
      0000000000000000000000000000B0A0CE000D0CFB000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000E0DFB00B2A2CE000000
      0000000000000000000000000000000000000000000068D6680000BA000000BA
      000000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA
      000068D66800000000000000000000000000000000000000000000000000F9F9
      FF007C7CF8002323F3002121F3002121F3002121F3002121F3002121F3002121
      F3002424F3007E7EF800FAFAFF00000000000000000000000000000000000000
      00000000000000000000E6BC9F005F4DD8000302FE000000FF000000FF000000
      FF000000FF000302FE00614FD700E7BC9F000000000000000000000000000000
      000000000000000000000000000000000000CAB7C700433DEC000000FF000000
      FF000000FF000000FF000000FF000000FF00453FEC00CBB9C700000000000000
      00000000000000000000000000000000000000000000000000008ADF8A000ABD
      0A0000BA000000BA000000BA000000BA000000BA000000BA00000ABD0A008BE0
      8B00000000000000000000000000000000000000000000000000000000000000
      000000000000D8D8FD008181F8004646F5002B2BF4002B2BF4004646F5008282
      F800D9D9FD000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EBC09D00A687BA00876EC700876E
      C700A687BA00EBC09D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CBB9C700897C
      D9006A60E2006A60E200897CD900CCBAC7000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E3F7
      E30081DD810037C9370015C0150015C0150037C9370081DD8100E4F8E4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000240000000100010000000000B00100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFF000000F807FF03FFC0FFE01F000000
      E001FC00FF003FC00F000000C000F8007E001F8007000000C000F0003C000F00
      03000000800070003C000E000100000080006000180006000100000080006000
      1800060601000000800060001800060901000000800060001800060081000000
      800060001800060041000000800060001800060001000000800070003C000E00
      01000000C000F0003C000F0003000000C000F8007E001F8007000000E001FC00
      FF003FC00F000000F807FF03FFC0FFE01F000000FFFFFFFFFFFFFFFFFF000000
      00000000000000000000000000000000000000000000}
  end
  object TabPedido: TRESTDWClientSQL
    Active = False
    AfterScroll = TabPedidoAfterScroll
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
      
        'SELECT PED.*,CLI.Nompes AS NomeCli, VEN.Nompes AS Nomven, PBM.No' +
        'mPBM, FPG.DesForPag  FROM arqpedido PED'
      'LEFT JOIN  arqforpagto FPG ON PED.IDForPag = FPG.IDForPag'
      'LEFT JOIN arqpbm PBM ON PED.IDPBM = PBM.IDPBM'
      'LEFT JOIN arqpessoa CLI ON PED.IDPess = CLI.IDPess'
      'LEFT JOIN arqpessoa VEN ON PED.IDVend = VEN.IDPess'
      'WHERE Status = "A" AND NOT IndDelete')
    UpdateTableName = 'arqpedido'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 37
    Top = 116
    object TabPedidoIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoIDPed: TIntegerField
      FieldName = 'IDPed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedidoDatped: TDateTimeField
      FieldName = 'Datped'
      DisplayFormat = 'dd/mm/yyyy - hh:mm'
    end
    object TabPedidoIDPess: TIntegerField
      FieldName = 'IDPess'
    end
    object TabPedidoIDDesc: TIntegerField
      FieldName = 'IDDesc'
    end
    object TabPedidoIDConv: TIntegerField
      FieldName = 'IDConv'
    end
    object TabPedidoIDVend: TIntegerField
      FieldName = 'IDVend'
    end
    object TabPedidoIDPBM: TIntegerField
      FieldName = 'IDPBM'
    end
    object TabPedidoIDEntre: TIntegerField
      FieldName = 'IDEntre'
    end
    object TabPedidoIDForPag: TSmallintField
      FieldName = 'IDForPag'
    end
    object TabPedidoIndEntr: TWideStringField
      FieldName = 'IndEntr'
      Size = 1
    end
    object TabPedidoEmiNF: TDateTimeField
      FieldName = 'EmiNF'
    end
    object TabPedidoTotDesc: TFloatField
      FieldName = 'TotDesc'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedidoNroCesta: TWideStringField
      FieldName = 'NroCesta'
    end
    object TabPedidoTotPedido: TFloatField
      FieldName = 'TotPedido'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedidoStatus: TWideStringField
      FieldName = 'Status'
      Size = 2
    end
    object TabPedidoTotBruCalc: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotBruCalc'
      ProviderFlags = []
      DisplayFormat = '###,###,###,##0.00'
      Calculated = True
    end
    object TabPedidoNomeCli: TWideStringField
      FieldName = 'NomeCli'
      ProviderFlags = []
      Size = 80
    end
    object TabPedidoNomPBM: TWideStringField
      FieldName = 'NomPBM'
      ProviderFlags = []
      Size = 35
    end
    object TabPedidoNomven: TWideStringField
      FieldName = 'Nomven'
      ProviderFlags = []
      Size = 80
    end
    object TabPedidoDesForPag: TWideStringField
      FieldName = 'DesForPag'
      ProviderFlags = []
    end
  end
  object SouPedido: TDataSource
    AutoEdit = False
    DataSet = TabPedido
    Left = 117
    Top = 116
  end
  object TabPedIte: TRESTDWClientSQL
    Active = False
    OnCalcFields = TabPedIteCalcFields
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
    MasterDataSet = TabPedido
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
        Value = 1
      end
      item
        DataType = ftInteger
        Name = 'IDPed'
        ParamType = ptInput
        Value = 141540
      end>
    DataBase = DM.DWDataBase
    SQL.Strings = (
      
        'SELECT PEI.*,PRO.Despro, FAB.Nompes AS NomeFab, VEN.Nompes AS No' +
        'mven, UsoRece FROM arqpedidoite PEI'
      'LEFT JOIN arqproduto PRO ON PEI.IDProd = PRO.IDProd'
      'LEFT JOIN arqpessoa  FAB ON PRO.IDFabr = FAB.IDPess'
      'LEFT JOIN arqpessoa VEN ON PEI.IDVend = VEN.IDPess'
      'WHERE PEI.IDFilial = :IDFilial AND PEI.IDPed = :IDPed')
    RelationFields.Strings = (
      'IDFilial=IDFilial'
      'IDPed=IDPed')
    UpdateTableName = 'arqpedidoite'
    CacheUpdateRecords = False
    AutoCommitData = True
    AutoRefreshAfterCommit = False
    ThreadRequest = False
    RaiseErrors = True
    ReflectChanges = True
    Left = 37
    Top = 340
    object TabPedIteIDFilial: TIntegerField
      FieldName = 'IDFilial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedIteIDPed: TIntegerField
      FieldName = 'IDPed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabPedIteNroite: TSmallintField
      FieldName = 'Nroite'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object TabPedIteIDProd: TIntegerField
      FieldName = 'IDProd'
    end
    object TabPedIteIDVend: TIntegerField
      FieldName = 'IDVend'
    end
    object TabPedItePerDesc: TFloatField
      FieldName = 'PerDesc'
      DisplayFormat = '##0.00'
    end
    object TabPedItePrecoVen: TFloatField
      FieldName = 'PrecoVen'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedItePrecoPMC: TFloatField
      FieldName = 'PrecoPMC'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedItePrecoFP: TFloatField
      FieldName = 'PrecoFP'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedItePrecoFab: TFloatField
      FieldName = 'PrecoFab'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedIteCustoMed: TFloatField
      FieldName = 'CustoMed'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedIteVlrPIS: TFloatField
      FieldName = 'VlrPIS'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedIteVlrCOF: TFloatField
      FieldName = 'VlrCOF'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedIteQtdped: TFloatField
      FieldName = 'Qtdped'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPedIteQtdConf: TFloatField
      FieldName = 'QtdConf'
      DisplayFormat = '###,###,##0.00'
    end
    object TabPedIteVlrDesc: TFloatField
      FieldName = 'VlrDesc'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedIteVlrVenda: TFloatField
      FieldName = 'VlrVenda'
      DisplayFormat = '###,###,###,##0.00'
    end
    object TabPedIteDatHorAlt: TDateTimeField
      FieldName = 'DatHorAlt'
    end
    object TabPedIteIndComi: TBooleanField
      FieldName = 'IndComi'
    end
    object TabPedIteDespro: TWideStringField
      FieldName = 'Despro'
      ProviderFlags = []
      Size = 120
    end
    object TabPedIteNomeFab: TWideStringField
      FieldName = 'NomeFab'
      ProviderFlags = []
      Size = 80
    end
    object TabPedIteNomven: TWideStringField
      FieldName = 'Nomven'
      ProviderFlags = []
      Size = 80
    end
    object TabPedIteUsoRece: TWideStringField
      FieldName = 'UsoRece'
      ProviderFlags = []
      Size = 2
    end
    object TabPedIteTotItemCalc: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotItemCalc'
      ProviderFlags = []
      DisplayFormat = '###,###,###,##0.00'
      Calculated = True
    end
  end
  object SouPedIte: TDataSource
    AutoEdit = False
    DataSet = TabPedIte
    Left = 109
    Top = 340
  end
end
