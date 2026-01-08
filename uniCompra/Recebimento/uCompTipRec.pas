unit uCompTipRec;

interface

uses
   Winapi.Windows, Vcl.Forms, AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDLabel, AdvOfficeButtons, LMDControl, LMDCustomControl,
   LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.Controls, Vcl.ExtCtrls,
   System.Classes, AdvSmoothPanel, MarcLib;

type
  TFrmCompTipRec = class(TForm)
    AdvSmoothPanel1: TAdvSmoothPanel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    LMDSimplePanel1: TLMDSimplePanel;
    RadioXML: TAdvOfficeRadioButton;
    RadioKey: TAdvOfficeRadioButton;
    RadioDFe: TAdvOfficeRadioButton;
    RadioMan: TAdvOfficeRadioButton;
    CheckNor: TAdvOfficeRadioButton;
    CheckPre: TAdvOfficeRadioButton;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    Shape1: TShape;
    LMDSimplePanel2: TLMDSimplePanel;
    btConfirma: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retOpcao,retTipEnt:String;
    ClickBtConfirma: Boolean;
  end;

var
  FrmCompTipRec: TFrmCompTipRec;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmCompTipRec.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
   retOpcao := '1';
   ClickBtConfirma := False;
end;

procedure TFrmCompTipRec.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompTipRec.btConfirmaClick(Sender: TObject);
begin
   retTipEnt := iif(CheckNor.Checked,'1','2');
   if RadioXML.Checked then retOpcao := '1' else  // XML
   if RadioKey.Checked then retOpcao := '2' else  // KEY
   if RadioDFe.Checked then retOpcao := '3' else  // DFE
   if RadioMan.Checked then retOpcao := '4';      // MANUAL
   ClickBtConfirma := True;
   Close;
end;

end.

