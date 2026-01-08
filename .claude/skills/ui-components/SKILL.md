# Componentes UI do Projeto AIONE

> **Modelo de Referência:** `.claude/skills/delphi-patterns/uModeloForm.pas` e `uModeloForm.dfm`

## 1. Formulário Base (TForm)

```pascal
object FrmXxx: TFrmXxx
  Align = alClient
  AlphaBlend = True
  BorderStyle = bsNone
  Color = 4144959              // Fundo cinza escuro
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 3881787         // Texto padrão
  Font.Height = -13
  Font.Name = 'Roboto'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
end
```

### Código Pascal Padrão
```pascal
uses uDM, uConst, MarcLib, uLibFarm;

procedure TFrmXxx.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmXxx.FormShow(Sender: TObject);
begin
   // Inicializações
end;

procedure TFrmXxx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;
```

---

## 2. TAdvSmoothPanel (PanelPrincipal)

Container principal do formulário com cantos arredondados.

```pascal
object PanelPrincipal: TAdvSmoothPanel
  AlignWithMargins = True
  Margins.Left = 5
  Margins.Top = 6
  Margins.Right = 5
  Margins.Bottom = 6
  Align = alClient
  Fill.Color = 15528703        // Bege claro
  Fill.ColorTo = clNone
  Fill.ColorMirror = clNone
  Fill.ColorMirrorTo = clNone
  Fill.GradientType = gtVertical
  Fill.BorderColor = clWhite
  Fill.BorderWidth = 0
  Fill.Rounding = 14           // Cantos arredondados
  Fill.ShadowOffset = 0
  Fill.Glow = gmNone
  Caption.ColorStart = 4474440
  Caption.ColorEnd = 4474440
end
```

---

## 3. TLMDSimplePanel

### 3.1 PanelTop (Cabeçalho com Título)
```pascal
object PanelTop: TLMDSimplePanel
  AlignWithMargins = True
  Margins.Left = 10
  Margins.Top = 10
  Margins.Right = 10
  Margins.Bottom = 1
  Align = alTop
  Height = 31
  Bevel.BorderColor = 14803425
  Bevel.BorderWidth = 1
  Color = 16382200             // Branco gelo
  TabOrder = 1
end
```

### 3.2 PanelConteudo (Área Principal)
```pascal
object PanelConteudo: TLMDSimplePanel
  AlignWithMargins = True
  Margins.Left = 10
  Margins.Right = 10
  Margins.Bottom = 10
  Align = alClient
  Bevel.StyleOuter = bvNormal
  Bevel.WidthOuter = 0
  Bevel.BorderColor = 14803425
  Bevel.BorderWidth = 1
  Color = clWhite
end
```

### 3.3 PanelButtons (Área de Botões)
```pascal
object PanelButtons: TLMDSimplePanel
  Left = 815
  Top = 583
  Width = 322
  Height = 28
  Color = clWhite
end
```

---

## 4. TLMDLabel

### 4.1 Título do Formulário
```pascal
object lbTitulo: TLMDLabel
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 8811110         // Marrom título
  Font.Height = -16
  Font.Name = 'Roboto'
  Font.Style = [fsBold]
  Options = []
  Caption = 'Titulo do Formulario'
end
```

### 4.2 Label de Campo
```pascal
object lbCampo: TLMDLabel
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 9600112         // Marrom label
  Font.Height = -11
  Font.Name = 'Roboto'
  Font.Style = [fsBold]
  Options = []
  Caption = 'NOME DO CAMPO'
end
```

---

## 5. TLMDDBLabeledEdit

### 5.1 Campo Editável
```pascal
object edNomeCampo: TLMDDBLabeledEdit
  Width = 255
  Height = 22
  Bevel.StyleOuter = bvNormal
  Bevel.WidthOuter = 0
  Bevel.BorderColor = 14342874   // Borda bege
  Bevel.BorderWidth = 1
  Bevel.Mode = bmCustom
  Caret.BlinkRate = 530
  Color = clWhite
  TabOrder = 1
  CharCase = ecUpperCase         // Opcional: maiúsculas
  CustomButtons = <>
  TabOnEnter = True
  DataField = 'NomeCampo'
  DataSource = SouXxx
  EditLabel.Font.Charset = DEFAULT_CHARSET
  EditLabel.Font.Color = 9600112
  EditLabel.Font.Height = -11
  EditLabel.Font.Name = 'Roboto'
  EditLabel.Font.Style = [fsBold]
  EditLabel.Caption = 'NOME DO CAMPO'
end
```

### 5.2 Campo Somente Leitura (Código/ID)
```pascal
object edCodigo: TLMDDBLabeledEdit
  Width = 84
  Height = 23
  Bevel.StyleOuter = bvNormal
  Bevel.WidthOuter = 0
  Bevel.BorderColor = 14342874
  Bevel.BorderWidth = 1
  Bevel.Mode = bmCustom
  Color = 16052978               // Cinza claro (readonly)
  TabStop = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 4276545
  Font.Height = -13
  Font.Name = 'Roboto'
  Font.Style = [fsBold]
  Alignment = taCenter
  ReadOnly = True
  DataField = 'IDCampo'
  EditLabel.Font.Color = 9600112
  EditLabel.Font.Height = -11
  EditLabel.Font.Name = 'Roboto'
  EditLabel.Font.Style = [fsBold]
  EditLabel.Caption = 'CÓDIGO'
end
```

---

## 6. TLMDLabeledListComboBox

```pascal
object cbTipo: TLMDLabeledListComboBox
  Width = 117
  Height = 23
  Bevel.StyleOuter = bvNormal
  Bevel.WidthInner = 0
  Bevel.WidthOuter = 0
  Bevel.BorderColor = 14342874
  Bevel.BorderWidth = 1
  Bevel.Mode = bmCustom
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 1447446
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  Items.Strings = (
    'OPÇÃO 1'
    'OPÇÃO 2')
  ItemIndex = 0
  EditLabel.Font.Charset = DEFAULT_CHARSET
  EditLabel.Font.Color = 9600112
  EditLabel.Font.Height = -11
  EditLabel.Font.Name = 'Roboto'
  EditLabel.Font.Style = [fsBold]
  EditLabel.Caption = 'TIPO'
end
```

---

## 7. TLMDDBCheckBox

```pascal
object chkAtivo: TLMDDBCheckBox
  Width = 85
  Height = 19
  Caption = 'Descrição'
  ParentColor = False
  ParentBackground = False
  Alignment.Alignment = agTopLeft
  Alignment.Spacing = 4
  AutoSize = True
  Color = 16382200
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 5194300           // Verde escuro
  Font.Height = -12
  Font.Name = 'Roboto'
  Font.Style = []
  ParentCtl3D = False
  DataField = 'IndAtivo'
  ValueChecked = '1'
  ValueUnchecked = '0'
end
```

---

## 8. TModernDBDateEdit

```pascal
object edData: TModernDBDateEdit
  Width = 99
  Height = 22
  BorderRadius = 0
  ButtonWidth = 22
  Color = clWhite
  Colors.Border = 14342874
  Colors.BorderFocus = 14342874
  DataField = 'DataCampo'
  DataSource = SouXxx
end
```

---

## 9. TDBGridEx

```pascal
object dgDados: TDBGridEx
  Color = clWhite
  GradientStartColor = 14079702  // Cabeçalho gradiente
  BorderColor = 13948116
  RowHeightEx = 22
  Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines,
             dgTabs, dgConfirmDelete, dgCancelOnExit,
             dgTitleClick, dgTitleHotTrack]
  TitleFont.Charset = DEFAULT_CHARSET
  TitleFont.Color = 3881787
  TitleFont.Height = -13
  TitleFont.Name = 'Roboto'
  TitleFont.Style = []
  Columns = <
    item
      Expanded = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2894892       // Texto célula
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = []
      Title.Alignment = taCenter
      Title.Caption = 'TITULO COLUNA'
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = 1776411  // Título coluna (escuro)
      Title.Font.Height = -12
      Title.Font.Name = 'Roboto'
      Title.Font.Style = [fsBold]
      Width = 200
      Visible = True
    end>
end
```

---

## 10. TAdvGlowButton

### 10.1 Botão Verde (Salvar) - COM ÍCONE

```pascal
object btSalvar: TAdvGlowButton
  AlignWithMargins = True
  Left = 222
  Top = 0
  Width = 100
  Height = 28
  Cursor = crHandPoint
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  Align = alRight
  Caption = 'Salvar'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 7039851
  Font.Height = -13
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
    F804165C641A4E14C849CDCFCF7AF3F367F6C9D5AB73B7B1B353CD606280AD10
    1B05A3000E006DFDA65FD6E403700000000049454E44AE426082}
  Rounded = True
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
```

### 10.2 Botão Vermelho (Excluir) - COM ÍCONE

```pascal
object btExcluir: TAdvGlowButton
  AlignWithMargins = True
  Left = 111
  Top = 0
  Width = 100
  Height = 28
  Cursor = crHandPoint
  Margins.Top = 0
  Margins.Right = 8
  Margins.Bottom = 0
  Align = alRight
  Caption = 'Excluir'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 5723991
  Font.Height = -13
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
```

### 10.3 Botão Verde (Novo) - COM ÍCONE

```pascal
object btNovo: TAdvGlowButton
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 100
  Height = 28
  Cursor = crHandPoint
  Margins.Top = 0
  Margins.Right = 8
  Margins.Bottom = 0
  Align = alRight
  Caption = 'Novo'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 7039851
  Font.Height = -13
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
    89504E470D0A1A0A0000000D4948445200000010000000101004000000E56AEB
    A9000000206348524D00007A26000080840000FA00000080E8000075300000EA
    6000003A98000017709CBA513C00000002624B47440000AA8D23320000000970
    485973000000600000006000F06B42CF0000000774494D4507E70802140117DC
    0BBDFA000000EA4944415438CBC5933B0AC2401445EFC4A4B410ADD3650D621B
    45F103B6EE40C8C82CC12CC14234B8035BC10F8ABDB885D1CE3EB682669E8536
    EA0CA820DEEAC2BB1CDE87C76090885DF712AFD70040996231CA1E0EBA9C6D02
    24AD7A9D799E07006CD7680051A4CB592600368EA3F56F03DED4FF01B6885D37
    1996CB685B8FB085EF637BF703DFE7D5D3E9A13E522A15AC562CD84BC97AB76D
    7FACA39416EB127DDD7F4864AB7EA9644595CAEB08B51AB6CD2600203F99A03A
    9F3F8FA072CBA511CED342704EC439114F0B61CAFDFF8C3F0414CE67AD7F92F1
    1B53E3D92CE948899048E5A65364F5B92B4C674F3CED4A6AC10000000049454E
    44AE426082}
  Rounded = True
  Spacing = 3
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
end
```

### 10.4 Botão Fechar (X no PanelTop) - COM ÍCONES Picture e HotPicture

```pascal
object btFechar: TAdvGlowButton
  Tag = 3099
  AlignWithMargins = True
  Left = 1142
  Top = 3
  Width = 24
  Height = 26
  Cursor = crHandPoint
  Margins.Left = 0
  Margins.Top = 2
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
    A72BEDAAB452B001E094DB1645AFDD98C090D9DF3F5EC8B3D880B930FA0095A1
    78262AE75EBB3181E21980CA73BEF718766EA77FAE6F167DBB96DA8EA7150000
    000049454E44AE426082}
  Rounded = True
  Spacing = 3
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  Appearance.BorderColor = 16382200
  Appearance.BorderColorHot = 16382200
  Appearance.BorderColorCheckedHot = 16382200
  Appearance.BorderColorDown = 16382200
  Appearance.BorderColorChecked = 16382200
  Appearance.BorderColorDisabled = 16382200
  Appearance.BorderColorFocused = 16382200
  Appearance.Color = 16382200
  Appearance.ColorTo = 16382200
  Appearance.ColorChecked = 16382200
  Appearance.ColorCheckedTo = 16382200
  Appearance.ColorDisabled = 16382200
  Appearance.ColorDisabledTo = 16382200
  Appearance.ColorDown = 16382200
  Appearance.ColorDownTo = 16382200
  Appearance.ColorHot = 16382200
  Appearance.ColorHotTo = 16382200
  Appearance.ColorMirror = 16382200
  Appearance.ColorMirrorTo = 16382200
  Appearance.ColorMirrorHot = 16382200
  Appearance.ColorMirrorHotTo = 16382200
  Appearance.ColorMirrorDown = 16382200
  Appearance.ColorMirrorDownTo = 16382200
  Appearance.ColorMirrorChecked = 16382200
  Appearance.ColorMirrorCheckedTo = 16382200
  Appearance.ColorMirrorDisabled = 16382200
  Appearance.ColorMirrorDisabledTo = 16382200
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
```

---

## 11. Mapa de Cores do Projeto

```pascal
// === CORES DE FUNDO ===
4144959  ($3F3F3F)    // Form.Color (fundo escuro)
15528703 ($ECFFFF)    // PanelPrincipal Fill.Color
16382200 ($F9F8F8)    // PanelTop Color (branco gelo)
clWhite               // PanelConteudo Color
16052978 ($F4F2F2)    // Campo ReadOnly Color

// === BORDAS ===
14803425 ($E1DBD1)    // Bevel.BorderColor painéis
14342874 ($DADBDA)    // Bevel.BorderColor campos/edits
13948116 ($D4CDD4)    // DBGridEx.BorderColor

// === TEXTOS ===
3881787  ($3B3B3B)    // Form.Font.Color (texto padrão)
8811110  ($866B66)    // Título do formulário
9600112  ($928370)    // Labels de campos (marrom)
4276545  ($414141)    // Texto campos editáveis
1447446  ($161616)    // ComboBox Font.Color
5194300  ($4F4F4C)    // CheckBox Font.Color

// === GRID ===
14079702 ($D6DFCE)    // GradientStartColor (cabeçalho)
2894892  ($2C2C2C)    // Célula Font.Color
1776411  ($1B1B1B)    // Título coluna Font.Color

// === BOTÃO VERDE (Salvar/Novo) ===
7039851  ($6B6B6B)    // Font.Color
8695039  ($849FFF)    // BorderColor
2846975  ($2B7FFF)    // BorderColorHot
14017279 ($D5FFFF)    // Color
9943551  ($97DFFF)    // ColorTo
7972351  ($79ADFF)    // ColorHot
10337791 ($9DDFFF)    // ColorHotTo

// === BOTÃO VERMELHO (Excluir) ===
5723991  ($575757)    // Font.Color
2412287  ($24C3FF)    // BorderColor
50943    ($C6FF)      // BorderColorHot
11792127 ($B4007F)    // Color
50175    ($C3FF)      // ColorTo
1887487  ($1CBFFF)    // ColorHot

// === BOTÃO FECHAR (Transparente) ===
16382200 ($F9F8F8)    // Todas as cores (mesmo do PanelTop)
```

---

## 12. Estrutura de Layout Padrão

```
┌─────────────────────────────────────────────────────────┐
│ PanelPrincipal (TAdvSmoothPanel) - Margins: 5/6/5/6    │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ PanelTop - Height: 31, Align: alTop                 │ │
│ │ [Título Centralizado]                    [X Fechar] │ │
│ ├─────────────────────────────────────────────────────┤ │
│ │ PanelConteudo - Align: alClient                     │ │
│ │ ┌─────────────────────────────────────────────────┐ │ │
│ │ │  Campos de Edição (TLMDDBLabeledEdit)           │ │ │
│ │ │  ComboBoxes (TLMDLabeledListComboBox)           │ │ │
│ │ │  CheckBoxes (TLMDDBCheckBox)                    │ │ │
│ │ │  Datas (TModernDBDateEdit)                      │ │ │
│ │ ├─────────────────────────────────────────────────┤ │ │
│ │ │  Grid (TDBGridEx)                               │ │ │
│ │ │                                                 │ │ │
│ │ ├─────────────────────────────────────────────────┤ │ │
│ │ │  PanelButtons [Novo] [Excluir] [Salvar]         │ │ │
│ │ └─────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

---

## 13. Convenções de Nomenclatura

| Prefixo | Componente | Exemplo |
|---------|------------|---------|
| `ed` | TLMDDBLabeledEdit, TLMDEdit | `edNompes`, `edCodigo` |
| `cb` | TComboBox, TLMDLabeledListComboBox | `cbTipo`, `cbFilial` |
| `chk` | TCheckBox, TLMDDBCheckBox | `chkAtivo`, `chkIsento` |
| `dg` | TDBGrid, TDBGridEx | `dgProdutos`, `dgItens` |
| `bt` | TAdvGlowButton | `btSalvar`, `btExcluir`, `btNovo` |
| `lb` | TLMDLabel | `lbTitulo`, `lbNome` |
| `Panel` | TLMDSimplePanel, TAdvSmoothPanel | `PanelTop`, `PanelConteudo` |
| `Sou` | TDataSource | `SouPess`, `SouProd` |

---

## 14. Melhores Práticas

1. **Sempre use `AdjustZoom(Self)`** no FormCreate para DPI
2. **Fonte Roboto** para toda a interface
3. **Labels em MAIÚSCULAS** para campos
4. **Cores consistentes** conforme mapa de cores
5. **TDBGridEx** em vez de TDBGrid para grids avançados
6. **TModernDBDateEdit** para campos de data
7. **Botões alinhados à direita** no PanelButtons
8. **Margens padronizadas**: 10px laterais/inferior, 5-6px no PanelPrincipal
