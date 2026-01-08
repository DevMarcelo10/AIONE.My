unit uConfRecEnt;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, AdvGlowButton,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  LMDBaseEdit, LMDCustomEdit, LMDLabel, Vcl.StdCtrls, LMDControl,
  LMDCustomControl, LMDCustomPanel, LMDEdit, LMDCustomBevelPanel,
  LMDSimplePanel, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomLabel, Vcl.ExtCtrls;

type
  TFrmConfRecEnt = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    edBusca: TLMDEdit;
    btFechar: TAdvGlowButton;
    LMDLabel8: TLMDLabel;
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfRecEnt: TFrmConfRecEnt;

implementation

{$R *.dfm}

uses uDM, uConst;

procedure TFrmConfRecEnt.FormShow(Sender: TObject);
begin
   edBusca.SetFocus;
end;

procedure TFrmConfRecEnt.btFecharClick(Sender: TObject);
begin
   Close;
end;

end.

