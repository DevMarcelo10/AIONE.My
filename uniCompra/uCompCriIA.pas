unit uCompCriIA;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.StdCtrls, LMDSimplePanel, LMDControl, LMDMaskEdit,
   LMDCustomControl, LMDCustomPanel, AdvSmoothPanel, LMDCustomMaskEdit,
   AdvGaugeCircle, Vcl.ExtCtrls, uRESTDWBasicTypes, Vcl.Imaging.PngImage,
   AdvEdBtn, uRESTDWBasicDB, AdvGlowButton, LMDBaseGraphicControl,
   LMDCustomLabel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit,
   VCL.Forms, Vcl.Controls, LMDBaseLabel, LMDLabel, LMDBaseControl;

type
  TFrmCompCIA = class(TForm)
    PanelBas: TAdvSmoothPanel;
    AdvSmoothPanel5: TAdvSmoothPanel;
    LMDLabel20: TLMDLabel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    LMDLabel26: TLMDLabel;
    LMDSimplePanel14: TLMDSimplePanel;
    LMDLabel22: TLMDLabel;
    Shape10: TShape;
    Image2: TImage;
    LMDLabel23: TLMDLabel;
    LMDMaskEdit13: TLMDMaskEdit;
    LMDSimplePanel15: TLMDSimplePanel;
    LMDLabel24: TLMDLabel;
    Shape11: TShape;
    Image3: TImage;
    LMDLabel25: TLMDLabel;
    LMDMaskEdit14: TLMDMaskEdit;
    LMDSimplePanel16: TLMDSimplePanel;
    LMDLabel27: TLMDLabel;
    Image4: TImage;
    LMDLabel28: TLMDLabel;
    LMDMaskEdit15: TLMDMaskEdit;
    AdvSmoothPanel2: TAdvSmoothPanel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel3: TLMDLabel;
    Image5: TImage;
    btFechar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    AdvGaugeCircle1: TAdvGaugeCircle;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDComp:Integer;
  end;

var
   FrmCompCIA: TFrmCompCIA;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmCompCIA.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   {for I := 0 to Self.ComponentCount - 1 do
   begin
      if Self.Components[i] is TLMDMaskEdit then
      begin
         TLMDMaskEdit(Self.Components[I]).MaskType := meNone;
         TLMDMaskEdit(Self.Components[I]).CurrencySettings.NegativeFormatStr := '-R$ 1,1';
         TLMDMaskEdit(Self.Components[I]).CurrencySettings.PositiveFormatStr := 'R$ 1,1';
         TLMDMaskEdit(Self.Components[I]).MaskType := meCurrency;
      end;
   end; //for}
end;

procedure TFrmCompCIA.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompCIA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := TCloseAction.caFree;
end;

end.
