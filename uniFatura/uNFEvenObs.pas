unit uNFEvenObs;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, Vcl.Dialogs,
     System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
     Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDLabel, LMDBaseLabel,
     LMDCustomLabel, LMDControl, LMDCustomControl, LMDCustomPanel,
     LMDSimplePanel, AdvGlowButton, LMDCustomBevelPanel, Vcl.ExtCtrls,
     LMDBaseGraphicControl, LMDBaseEdit, LMDCustomMemo, LMDDBMemo;

type
  TFrmNFEvenObs = class(TForm)
    PanelTop: TLMDSimplePanel;
    OBSER: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    DBMemo: TLMDDBMemo;
    btSalvaIte: TAdvGlowButton;
    btLimpar: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btSalvaIteClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure DBMemoKeyPress(Sender: TObject; var Key: Char);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmNFEvenObs: TFrmNFEvenObs;

implementation

{$R *.dfm}

uses uDM, uNFEven, uLibFarm;

procedure TFrmNFEvenObs.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmNFEvenObs.FormShow(Sender: TObject);
begin
   DBMemo.SetFocus;
end;

procedure TFrmNFEvenObs.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmNFEvenObs.btLimparClick(Sender: TObject);
begin
   DBMemo.Lines.Clear;
end;

procedure TFrmNFEvenObs.btSalvaIteClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmNFEvenObs.DBMemoKeyPress(Sender: TObject; var Key: Char);
begin
   Key := UpCase(Key);
end;

procedure TFrmNFEvenObs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
