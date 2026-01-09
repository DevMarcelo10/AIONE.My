unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, LMDControl,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel;

type
  TFrmMenu = class(TForm)
    PanelMenu: TLMDSimplePanel;
    btVenda: TAdvGlowButton;
    btCaixa: TAdvGlowButton;
    btCompras: TAdvGlowButton;
    btFinanceiro: TAdvGlowButton;
    btCadastro: TAdvGlowButton;
    btIA: TAdvGlowButton;
    btConfig: TAdvGlowButton;
    btFiscal: TAdvGlowButton;
    btEstoque: TAdvGlowButton;
    procedure btMouseEnter(Sender: TObject);
    procedure btMouseLeave(Sender: TObject);
    procedure btVendaClick(Sender: TObject);
    procedure btCaixaClick(Sender: TObject);
    procedure btComprasClick(Sender: TObject);
    procedure btFinanceiroClick(Sender: TObject);
    procedure btCadastroClick(Sender: TObject);
    procedure btIAClick(Sender: TObject);
    procedure btConfigClick(Sender: TObject);
    procedure btFiscalClick(Sender: TObject);
    procedure btEstoqueClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses uLibFarm, uPrincipal;

procedure TFrmMenu.btVendaClick(Sender: TObject);
begin
   FrmPrincipal.btVendaClick(Sender);
end;

procedure TFrmMenu.btCaixaClick(Sender: TObject);
begin
   FrmPrincipal.btCaixaClick(Sender);
end;

procedure TFrmMenu.btComprasClick(Sender: TObject);
begin
   FrmPrincipal.btComprasClick(Sender);
end;

procedure TFrmMenu.btEstoqueClick(Sender: TObject);
begin
   FrmPrincipal.btEstoqueClick(Sender);
end;

procedure TFrmMenu.btFinanceiroClick(Sender: TObject);
begin
   FrmPrincipal.btFinanceiroClick(Sender);
end;

procedure TFrmMenu.btFiscalClick(Sender: TObject);
begin
   FrmPrincipal.btFiscalClick(Sender);
end;

procedure TFrmMenu.btIAClick(Sender: TObject);
begin
   // FrmPrincipal.btIAgptClick(Sender);
end;

procedure TFrmMenu.btCadastroClick(Sender: TObject);
begin
   FrmPrincipal.btCadastroClick(Sender);
end;

procedure TFrmMenu.btConfigClick(Sender: TObject);
begin
   FrmPrincipal.btConfigClick(Sender);
end;

procedure TFrmMenu.btMouseEnter(Sender: TObject);
begin
   TAdvGlowButton(Sender).ShowCaption := True;
end;

procedure TFrmMenu.btMouseLeave(Sender: TObject);
begin
   TAdvGlowButton(Sender).ShowCaption := False;
end;

end.
