unit uPessObser;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, RxToolEdit,
   RxDBCtrl, LMDBaseEdit, LMDCustomEdit, LMDDBEdit, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDSimplePanel, LMDCustomMemo, LMDMemo, LMDButtonControl, LMDDBMemo,
   LMDDBCheckBox;

type
  TFrmPesObser = class(TForm)
    PanelTrabalho: TLMDSimplePanel;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledMemo1: TLMDDBLabeledMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
 end;

var
   FrmPesObser: TFrmPesObser;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, uPessoasCad;

procedure TFrmPesObser.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPesObser.FormShow(Sender: TObject);
begin
   if not(FrmPesCad.TabPess.State in dsEditModes) then FrmPesCad.TabPess.Edit;
end;

procedure TFrmPesObser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if FrmPesCad.TabPess.State in dsEditModes then
      FrmPesCad.TabPess.Post;
end;

end.
