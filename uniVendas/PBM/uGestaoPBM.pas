unit uGestaoPBM;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, System.DateUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
   Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
   Vcl.Buttons, Vcl.Imaging.pngimage, MarcLib, FireDAC.Stan.Intf, LMDEdit,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, LMDCustomCheckBox,
   FireDAC.Comp.Client, uRESTDWBasicTypes, uRESTDWBasicDB, DBGridEx,
   AdvGlowButton, AdvSmoothPanel, LMDControl, LMDBaseControl, LMDButtonControl,
   LMDBaseGraphicControl, LMDGraphicControl, LMDBaseLabel, LMDLabel,
   LMDCustomPanel, LMDSimplePanel, LMDCustomControl, LMDCustomEdit, LMDCheckBox,
   LMDCustomBevelPanel, LMDCustomMaskEdit, RxToolEdit, ModernDateEdit,
   RxCurrEdit, Vcl.Mask, RxDBCtrl, LMDBaseEdit, LMDDBEdit, LMDCustomLabel;

type
   TFrmGestaoPBM = class(TForm)
      PanelCadastro: TAdvSmoothPanel;
      PanelTop: TLMDSimplePanel;
      lblTitulo: TLMDLabel;
      PanelFiltros: TLMDSimplePanel;
      edAutorizacao: TLMDDBLabeledEdit;
      edCRUFPrescritor: TLMDDBLabeledEdit;
      PanelButtons: TLMDSimplePanel;
      btCancelar: TAdvGlowButton;
      btImprimir: TAdvGlowButton;
      btInfoVenda: TAdvGlowButton;
      btReposicao: TAdvGlowButton;
      edPBM: TLMDLabeledEdit;
      edFilial: TLMDLabeledEdit;
      LMDLabeledEdit1: TLMDLabeledEdit;
      edFabrica: TLMDLabeledEdit;
      edGrupo: TLMDLabeledEdit;
      edSubGrupo: TLMDLabeledEdit;
      edDataIni: TModernDateEdit;
      LMDLabel1: TLMDLabel;
      Label2: TLMDLabel;
      edDataFin: TModernDateEdit;
      LMDSimplePanel6: TLMDSimplePanel;
      chkEfetiva: TLMDCheckBox;
      chkAberto: TLMDCheckBox;
      LMDLabel2: TLMDLabel;
      btBuscar: TAdvGlowButton;
      DBGridEx1: TDBGridEx;
      btFechar: TAdvGlowButton;
    LMDSimplePanel1: TLMDSimplePanel;
    chkAReceber: TLMDCheckBox;
    chkPendente: TLMDCheckBox;
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure btFiltrarClick(Sender: TObject);
      procedure btCancelarClick(Sender: TObject);
      procedure btImprimirClick(Sender: TObject);
      procedure btVenderClick(Sender: TObject);
      procedure btInfoVendaClick(Sender: TObject);
      procedure btReposicaoClick(Sender: TObject);
      procedure btFecharClick(Sender: TObject);
   private
      procedure CarregaDados;
   public
      { Public declarations }
   end;

var
   FrmGestaoPBM: TFrmGestaoPBM;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmGestaoPBM.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmGestaoPBM.FormShow(Sender: TObject);
begin
   edDataIni.Date := StartOfTheMonth(Date);
   edDataFin.Date := Date;
   chkAberto.Checked := True;
   CarregaDados;
end;

procedure TFrmGestaoPBM.btFiltrarClick(Sender: TObject);
begin
   CarregaDados;
end;

procedure TFrmGestaoPBM.CarregaDados;
var
   sSQL: String;
begin
   // TODO: Implementar query de busca de PBMs
   sSQL := 'SELECT * FROM ........ WHERE 1=1 ';
   // Aplicar filtros conforme campos preenchidos
   TabPBM.Close;
   TabPBM.SQL.Text := sSQL;
   TabPBM.Open;
end;

procedure TFrmGestaoPBM.btCancelarClick(Sender: TObject);
begin
   // TODO: Implementar cancelamento de transação PBM
end;

procedure TFrmGestaoPBM.btImprimirClick(Sender: TObject);
begin
   // TODO: Implementar impressão
end;

procedure TFrmGestaoPBM.btVenderClick(Sender: TObject);
begin
   // TODO: Implementar venda PBM
end;

procedure TFrmGestaoPBM.btInfoVendaClick(Sender: TObject);
begin
   // TODO: Implementar informações da venda
end;

procedure TFrmGestaoPBM.btReposicaoClick(Sender: TObject);
begin
   // TODO: Implementar reposição fornecedor
end;

procedure TFrmGestaoPBM.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmGestaoPBM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPBM.Close;
   Action := caFree;
end;

end.
