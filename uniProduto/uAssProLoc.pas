unit uAssProLoc;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, LMDBaseControl, LMDEdit,
   LMDBaseGraphicControl, LMDBaseLabel, LMDLabel, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomLabel, LMDBaseEdit, LMDCustomEdit, RxToolEdit,
   Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, uRESTDWBasicTypes;

type
  TFrmAssProLoc = class(TForm)
    PanelBase: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    edSubGru: TLMDLabeledEdit;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    edPessoa: TLMDLabeledEdit;
    PanelBottom: TLMDSimplePanel;
    btSalvar: TAdvGlowButton;
    LMDLabel7: TLMDLabel;
    edGrupo: TLMDLabeledEdit;
    LMDLabel11: TLMDLabel;
    edDespro: TLMDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edGrupoCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edSubGruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSubGruCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retDespro:String;
    retIDFabr,retIDGrupo,retIDGruSub:Integer;
  end;

var
   FrmAssProLoc: TFrmAssProLoc;

implementation

{$R *.dfm}

uses uLibFarm;

procedure TFrmAssProLoc.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmAssProLoc.FormShow(Sender: TObject);
begin
   edPessoa.SetFocus;
end;

procedure TFrmAssProLoc.edPessoaCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqpessoa',TLMDEdit(Sender),'IDPess','Nompes','IDEsppes = 2 OR IDEsppes = 3',0);
end;

procedure TFrmAssProLoc.edPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqpessoa',TLMDEdit(Sender),'IDPess','Nompes','IDEsppes = 2 OR IDEsppes = 3',Key);
end;

procedure TFrmAssProLoc.edSubGruCustomButtons0Click(Sender: TObject; index: Integer);
begin
   if edGrupo.Tag <= 0 then
   begin
      MostraMsg('Aviso','Favor escolher um GRUPO antes!', mtWarning, [mbOk]);
      Exit;
   end;
   btBuscas('arqgruposub',TLMDEdit(edSubGru),'IDGruSub','DesgruSub','IDGrupo = '+edGrupo.Tag.ToString,0,True);
end;

procedure TFrmAssProLoc.edSubGruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
   begin
      if edGrupo.Tag <= 0 then
      begin
         MostraMsg('Aviso','Favor escolher um GRUPO antes!', mtWarning, [mbOk]);
         Exit;
      end;
      btBuscas('arqgruposub',TLMDEdit(edSubGru),'IDGruSub','DesgruSub','IDGrupo = '+edGrupo.Tag.ToString,Key,True);
   end; //if
end;

procedure TFrmAssProLoc.edGrupoCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscas('arqgrupo',TLMDEdit(edGrupo),'IDGrupo','Desgru','',0,True);
end;

procedure TFrmAssProLoc.edGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   btBuscas('arqgrupo',TLMDEdit(edGrupo),'IDGrupo','Desgru','',Key,True);
end;

procedure TFrmAssProLoc.btFecharClick(Sender: TObject);
begin
   retIDFabr   := 0;
   retIDGrupo  := 0;
   retIDGruSub := 0;
   retDespro   := '';
   Close;
end;

procedure TFrmAssProLoc.btSalvarClick(Sender: TObject);
begin
   retIDFabr   := edPessoa.Tag;
   retIDGrupo  := edGrupo.Tag;
   retIDGruSub := edSubGru.Tag;
   retDespro   := edDespro.Text.Trim;
   Close;
end;

procedure TFrmAssProLoc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
