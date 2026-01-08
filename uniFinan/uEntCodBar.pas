unit uEntCodBar;

interface

uses
   System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
   Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, LMDBaseControl, LMDSimplePanel,
   LMDEdit, AdvGlowButton, LMDBaseGraphicControl, LMDBaseLabel,
   LMDCustomLabel, LMDLabel, LMDBaseEdit, LMDCustomEdit, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, Winapi.Windows;

type
  TFrmTitCodBar = class(TForm)
    PanelBase: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edCodBar: TLMDEdit;
    btFechar: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCodBarKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    retCodBar:String;
  end;

var
   FrmTitCodBar: TFrmTitCodBar;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmTitCodBar.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTitCodBar.FormShow(Sender: TObject);
begin
   retCodBar := '';
   edCodBar.SetFocus;
end;

procedure TFrmTitCodBar.edCodBarKeyPress(Sender: TObject; var Key: Char);
begin
   if Word(key) = VK_RETURN then
   begin
      if edCodBar.Text.Trim.Length = 47 then
           retCodBar := edCodBar.Text.Trim
      else retCodBar := '';
      Self.Close;
   end; //if
   if (key in ['0'..'9'] = False) and (Word(key) <> VK_BACK) and (Word(key) <> VK_TAB) then key := #0;
end;

procedure TFrmTitCodBar.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTitCodBar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
