unit uPromoFiltros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDMaskEdit, Vcl.Mask,
  Vcl.StdCtrls, RxToolEdit, Vcl.ExtCtrls, LMDBaseControl, LMDBaseLabel,
  LMDBaseGraphicControl, LMDCustomLabel, LMDLabel, AdvSmoothPanel,
  AdvGlowButton, LMDControl, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDSimplePanel, LMDCheckBox, LMDButtonControl,
  Vcl.Imaging.PngImage, LMDCustomCheckBox, System.DateUtils;

type
  TFrmPromFiltros = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanPeriodo: TLMDSimplePanel;
    AdvSmoothPanel11: TAdvSmoothPanel;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    Shape4: TShape;
    edDateON: TDateEdit;
    edTimeON: TLMDMaskEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel6: TLMDLabel;
    Shape5: TShape;
    edDateOFF: TDateEdit;
    edTimeOFF: TLMDMaskEdit;
    LMDLabel3: TLMDLabel;
    PanEstilo: TLMDSimplePanel;
    AdvSmoothPanel12: TAdvSmoothPanel;
    LMDLabel7: TLMDLabel;
    LMDLabel8: TLMDLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    AdvSmoothPanel4: TAdvSmoothPanel;
    AdvSmoothPanel5: TAdvSmoothPanel;
    btModerado: TAdvGlowButton;
    btAgresivo: TAdvGlowButton;
    btConserva: TAdvGlowButton;
    PanDiaSema: TLMDSimplePanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    LMDLabel9: TLMDLabel;
    LMDLabel10: TLMDLabel;
    AdvSmoothPanel6: TAdvSmoothPanel;
    CheckDia2: TLMDCheckBox;
    CheckDia3: TLMDCheckBox;
    CheckDia4: TLMDCheckBox;
    CheckDia5: TLMDCheckBox;
    CheckDia6: TLMDCheckBox;
    CheckDia7: TLMDCheckBox;
    CheckDia1: TLMDCheckBox;
    PanMudPrec: TLMDSimplePanel;
    AdvSmoothPanel7: TAdvSmoothPanel;
    LMDLabel11: TLMDLabel;
    LMDLabel12: TLMDLabel;
    AdvSmoothPanel8: TAdvSmoothPanel;
    AdvSmoothPanel9: TAdvSmoothPanel;
    AdvSmoothPanel10: TAdvSmoothPanel;
    btSIM: TAdvGlowButton;
    btNAO: TAdvGlowButton;
    PanTipo: TLMDSimplePanel;
    AdvSmoothPanel13: TAdvSmoothPanel;
    LMDLabel4: TLMDLabel;
    LMDLabel13: TLMDLabel;
    AdvSmoothPanel14: TAdvSmoothPanel;
    AdvSmoothPanel15: TAdvSmoothPanel;
    AdvSmoothPanel16: TAdvSmoothPanel;
    btDesProgre: TAdvGlowButton;
    btDesNormal: TAdvGlowButton;
    LMDSimplePanel3: TLMDSimplePanel;
    edDatVenLot: TDateEdit;
    LMDLabel14: TLMDLabel;
    procedure timAlphaTimer(Sender: TObject);
    procedure btTipoClick(Sender: TObject);
    procedure btEstiloClick(Sender: TObject);
    procedure btSimNaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    frmAtivo:String;
    procedure btMudaCor(recButton:TAdvGlowButton; Cor:TColor);
  public
    { Public declarations }
    recIDProm:Integer;
  end;

var
  FrmPromFiltros: TFrmPromFiltros;

implementation

{$R *.dfm}

uses uLibFarm, uPromocao;

procedure TFrmPromFiltros.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromFiltros.timAlphaTimer(Sender: TObject);
begin
   if promoRecTipo    = -1 then promoRecTipo    := 0;
   if promoiAgrassivo = -1 then promoiAgrassivo := 1;
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmPromFiltros.btTipoClick(Sender: TObject);
begin
   if TAdvGlowButton(Sender).Name = 'btDesNormal' then
   begin
      promoRecTipo    := 0;
      btDesNormal.Tag := 1;
      btDesProgre.Tag := 0;
      btMudaCor(btDesNormal,$0097B9FF);
      btMudaCor(btDesProgre,clNone);
   end else
   if TAdvGlowButton(Sender).Name = 'btDesProgre' then
   begin
      promoRecTipo    := 1;
      btDesNormal.Tag := 0;
      btDesProgre.Tag := 1;
      btMudaCor(btDesNormal,clNone);
      btMudaCor(btDesProgre,$0097B9FF);
   end; //if
end;

procedure TFrmPromFiltros.btEstiloClick(Sender: TObject);
begin
   if TAdvGlowButton(Sender).Name = 'btConserva' then
   begin
      promoiAgrassivo := 0;
      btConserva.Tag  := 1;
      btModerado.Tag  := 0;
      btAgresivo.Tag  := 0;
      btMudaCor(btConserva,$0097B9FF);
      btMudaCor(btModerado,clNone);
      btMudaCor(btAgresivo,clNone);
   end else
   if TAdvGlowButton(Sender).Name = 'btModerado' then
   begin
      promoiAgrassivo := 1;
      btConserva.Tag  := 0;
      btModerado.Tag  := 1;
      btAgresivo.Tag  := 0;
      btMudaCor(btConserva,clNone);
      btMudaCor(btModerado,$0097B9FF);
      btMudaCor(btAgresivo,clNone);
   end else
   if TAdvGlowButton(Sender).Name = 'btAgresivo' then
   begin
      promoiAgrassivo := 1;
      btConserva.Tag  := 0;
      btModerado.Tag  := 0;
      btAgresivo.Tag  := 1;
      btMudaCor(btConserva,clNone);
      btMudaCor(btModerado,clNone);
      btMudaCor(btAgresivo,$0097B9FF);
   end; //if
end;

procedure TFrmPromFiltros.btSimNaoClick(Sender: TObject);
begin
   if TAdvGlowButton(Sender).Name = 'btSIM' then
   begin
      btSIM.Tag := 1;
      btNAO.Tag := 0;
      btMudaCor(btSIM,$0097B9FF);
      btMudaCor(btNAO,clNone);
   end else
   if TAdvGlowButton(Sender).Name = 'btNAO' then
   begin
      btSIM.Tag := 0;
      btNAO.Tag := 1;
      btMudaCor(btSIM,clNone);
      btMudaCor(btNAO,$0097B9FF);
   end; //if
end;

procedure TFrmPromFiltros.btMudaCor(recButton:TAdvGlowButton; Cor:TColor);
begin
   with recButton.Appearance do
   begin
      Color             := Cor;
      ColorTo           := Cor;
      BorderColor       := Cor;
      ColorMirror       := Cor;
      ColorMirrorTo     := Cor;
      ColorHot          := Cor;
      ColorHotTo        := Cor;
      ColorMirrorHot    := Cor;
      ColorMirrorHotTo  := Cor;
      BorderColorHot    := Cor;
      ColorDown         := Cor;
      ColorDownTo       := Cor;
      ColorMirrorDown   := Cor;
      ColorMirrorDownTo := Cor;
      BorderColorDown   := Cor;
   end; //with
end;

procedure TFrmPromFiltros.FormClose(Sender: TObject; var Action: TCloseAction);
var
   TimeVal:TTime;
begin
   PanEstilo.Visible  := False;
   PanPeriodo.Visible := False;
   PanDiaSema.Visible := False;
   PanMudPrec.Visible := False;
   TimeVal   := StrToTime(edTimeON.Text);
   promoDIni := EncodeDateTime(YearOf(edDateON.Date), MonthOf(edDateON.Date), DayOf(edDateON.Date), HourOf(TimeVal), MinuteOf(TimeVal), SecondOf(TimeVal), 0);
   if edDateOFF.Date > 0 then
   begin
      TimeVal   := StrToTime(edTimeOFF.Text);
      promoDFin := EncodeDateTime(YearOf(edDateOFF.Date), MonthOf(edDateOFF.Date), DayOf(edDateOFF.Date), HourOf(TimeVal), MinuteOf(TimeVal), SecondOf(TimeVal), 0);
   end
   else promoDFin := 0;
   //Action := caFree;
   //Self   := nil;
end;

end.

