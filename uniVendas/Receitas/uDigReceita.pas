unit uDigReceita;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomLabel, LMDControl, LMDCustomControl, MarcLib,
   LMDCustomPanel, LMDSimplePanel, LMDBaseEdit, LMDEdit, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomEdit, LMDDBEdit, LMDButtonControl, LMDCustomCheckBox,
   LMDDBCheckBox, Vcl.ExtCtrls;

type
  TFrmDigRecei = class(TForm)
    PanelTop: TLMDSimplePanel;
    lbTitulo: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    btBuscar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    AdvGlowButton1: TAdvGlowButton;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmDigRecei: TFrmDigRecei;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmDigRecei.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmDigRecei.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then Close;
end;

procedure TFrmDigRecei.FormShow(Sender: TObject);
begin
  //btBuscar.SetFocus;
end;

procedure TFrmDigRecei.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmDigRecei.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
