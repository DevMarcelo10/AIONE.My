unit uAlteraDataVenci;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, LMDBaseControl,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDControl, RxCurrEdit,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.Mask,
  Vcl.StdCtrls, RxToolEdit, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, Data.DB, FireDAC.Comp.Client,
  uRESTDWBasicTypes;

type
  TFrmAlteraDataVenci = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    edDataVenc: TDateEdit;
    PanelTop: TLMDSimplePanel;
    btOk: TAdvGlowButton;
    btCancelar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    procedure btOkClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recDatVenc:TDateTime;
  end;

var
  FrmAlteraDataVenci: TFrmAlteraDataVenci;

implementation

{$R *.dfm}

procedure TFrmAlteraDataVenci.btOkClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmAlteraDataVenci.btCancelarClick(Sender: TObject);
begin
   Close;
end;

end.
