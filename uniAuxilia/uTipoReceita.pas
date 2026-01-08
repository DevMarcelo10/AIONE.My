unit uTipoReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDButtonControl, LMDCustomCheckBox,
  LMDCheckBox, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, LMDCustomMaskEdit, LMDMaskEdit,
  LMDBaseEdit, LMDCustomEdit, LMDEdit, AdvGlowButton, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomLabel, LMDLabel, Vcl.ExtCtrls, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, LMDDBEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRESTDWBasicTypes,
   uRESTDWBasicDB, Vcl.DBCtrls, LMDDBMaskEdit;

type
  TFrmTipoReceita = class(TForm)
    PanelPri: TLMDSimplePanel;
    PanelTop: TLMDSimplePanel;
    LMDLabel8: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCabe: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    LMDLabel6: TLMDLabel;
    LMDLabel7: TLMDLabel;
    LMDLabel9: TLMDLabel;
    LMDLabel10: TLMDLabel;
    LMDLabel11: TLMDLabel;
    LMDLabel12: TLMDLabel;
    LMDLabel13: TLMDLabel;
    LMDLabel14: TLMDLabel;
    LMDLabel15: TLMDLabel;
    LMDLabel16: TLMDLabel;
    LMDLabel17: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    LMDSimplePanel4: TLMDSimplePanel;
    LMDSimplePanel5: TLMDSimplePanel;
    LMDSimplePanel6: TLMDSimplePanel;
    LMDSimplePanel8: TLMDSimplePanel;
    LMDSimplePanel9: TLMDSimplePanel;
    LMDSimplePanel10: TLMDSimplePanel;
    LMDSimplePanel11: TLMDSimplePanel;
    LMDSimplePanel12: TLMDSimplePanel;
    LMDSimplePanel13: TLMDSimplePanel;
    LMDSimplePanel14: TLMDSimplePanel;
    LMDSimplePanel15: TLMDSimplePanel;
    LMDSimplePanel16: TLMDSimplePanel;
    LMDSimplePanel17: TLMDSimplePanel;
    LMDSimplePanel18: TLMDSimplePanel;
    LMDLabel18: TLMDLabel;
    LMDLabel19: TLMDLabel;
    LMDLabel20: TLMDLabel;
    LMDLabel21: TLMDLabel;
    LMDLabel22: TLMDLabel;
    LMDLabel23: TLMDLabel;
    LMDLabel24: TLMDLabel;
    LMDLabel25: TLMDLabel;
    LMDLabel26: TLMDLabel;
    LMDLabel27: TLMDLabel;
    LMDLabel28: TLMDLabel;
    LMDLabel29: TLMDLabel;
    edA1: TLMDDBLabeledEdit;
    TabParam: TRESTDWClientSQL;
    TabParamCNPJFar: TWideStringField;
    TabParamIDFilial: TWideStringField;
    SouParam: TDataSource;
    TabParamDesReceA1: TWideStringField;
    TabParamDesReceA2: TWideStringField;
    TabParamDesReceA3: TWideStringField;
    TabParamDesReceAM: TWideStringField;
    TabParamDesReceB1: TWideStringField;
    TabParamDesReceB2: TWideStringField;
    TabParamDesReceC1: TWideStringField;
    TabParamDesReceC2: TWideStringField;
    TabParamDesReceC3: TWideStringField;
    TabParamDesReceC4: TWideStringField;
    TabParamDesReceC5: TWideStringField;
    TabParamDesReceD1: TWideStringField;
    TabParamReceitaA1: TIntegerField;
    TabParamReceitaA2: TIntegerField;
    TabParamReceitaA3: TIntegerField;
    TabParamReceitaAM: TIntegerField;
    TabParamReceitaB1: TIntegerField;
    TabParamReceitaB2: TIntegerField;
    TabParamReceitaC1: TIntegerField;
    TabParamReceitaC2: TIntegerField;
    TabParamReceitaC3: TIntegerField;
    TabParamReceitaC4: TIntegerField;
    TabParamReceitaC5: TIntegerField;
    TabParamReceitaD1: TIntegerField;
    edA2: TLMDDBLabeledEdit;
    edAM: TLMDDBLabeledEdit;
    edA3: TLMDDBLabeledEdit;
    edD1: TLMDDBLabeledEdit;
    edC5: TLMDDBLabeledEdit;
    edC4: TLMDDBLabeledEdit;
    edC3: TLMDDBLabeledEdit;
    edC2: TLMDDBLabeledEdit;
    edC1: TLMDDBLabeledEdit;
    edB2: TLMDDBLabeledEdit;
    edB1: TLMDDBLabeledEdit;
    edValDiaB1: TLMDDBMaskEdit;
    edValDiaD1: TLMDDBMaskEdit;
    edValDiaC5: TLMDDBMaskEdit;
    edValDiaC4: TLMDDBMaskEdit;
    edValDiaC3: TLMDDBMaskEdit;
    edValDiaC2: TLMDDBMaskEdit;
    edValDiaC1: TLMDDBMaskEdit;
    edValDiaB2: TLMDDBMaskEdit;
    edValDiaA1: TLMDDBMaskEdit;
    edValDiaA2: TLMDDBMaskEdit;
    edValDiaA3: TLMDDBMaskEdit;
    edValDiaAM: TLMDDBMaskEdit;
    TabParamValDiaA1: TIntegerField;
    TabParamValDiaA2: TIntegerField;
    TabParamValDiaA3: TIntegerField;
    TabParamValDiaAM: TIntegerField;
    TabParamValDiaB1: TIntegerField;
    TabParamValDiaB2: TIntegerField;
    TabParamValDiaC1: TIntegerField;
    TabParamValDiaC2: TIntegerField;
    TabParamValDiaC3: TIntegerField;
    TabParamValDiaC4: TIntegerField;
    TabParamValDiaC5: TIntegerField;
    TabParamValDiaD1: TIntegerField;
    procedure btFecharClick(Sender: TObject);
    procedure edA1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edA1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edA2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edA3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edAMKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edB1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edB2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edC1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edC2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edC3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edC4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edC5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edD1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edA2CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edA3CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edAMCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edB1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edB2CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edC1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edC2CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edC3CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edC4CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edC5CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edD1CustomButtons0Click(Sender: TObject; index: Integer);
    procedure edValDiaD1Exit(Sender: TObject);
    procedure edValDiaC5Exit(Sender: TObject);
    procedure edValDiaC4Exit(Sender: TObject);
    procedure edValDiaC3Exit(Sender: TObject);
    procedure edValDiaC2Exit(Sender: TObject);
    procedure edValDiaC1Exit(Sender: TObject);
    procedure edValDiaB2Exit(Sender: TObject);
    procedure edValDiaB1Exit(Sender: TObject);
    procedure edValDiaAMExit(Sender: TObject);
    procedure edValDiaA3Exit(Sender: TObject);
    procedure edValDiaA2Exit(Sender: TObject);
    procedure edValDiaA1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTipoReceita: TFrmTipoReceita;

implementation

uses uDM, uConst, uLibFarm;

{$R *.dfm}

procedure TFrmTipoReceita.btFecharClick(Sender: TObject);
begin
   btFechar.SetFocus;
   Close;
end;

procedure TFrmTipoReceita.edA1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edA1),'ReceitaA1','IDRece','DesRece','DesReceA1','',0);
end;

procedure TFrmTipoReceita.edA1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edA1),'ReceitaA1','IDRece','DesRece','DesReceA1','',Key);
end;

procedure TFrmTipoReceita.edA2CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edA2),'ReceitaA2','IDRece','DesRece','DesReceA2','',0);
end;

procedure TFrmTipoReceita.edA2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edA2),'ReceitaA2','IDRece','DesRece','DesReceA2','',Key);
end;

procedure TFrmTipoReceita.edA3CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edA3),'ReceitaA3','IDRece','DesRece','DesReceA3','',0);
end;

procedure TFrmTipoReceita.edA3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edA3),'ReceitaA3','IDRece','DesRece','DesReceA3','',Key);
end;

procedure TFrmTipoReceita.edAMCustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edAM),'ReceitaAM','IDRece','DesRece','DesReceAM','',0);
end;

procedure TFrmTipoReceita.edAMKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edAM),'ReceitaAM','IDRece','DesRece','DesReceAM','',Key);
end;

procedure TFrmTipoReceita.edB1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edB1),'ReceitaB1','IDRece','DesRece','DesReceB1','',0);
end;

procedure TFrmTipoReceita.edB1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edB1),'ReceitaB1','IDRece','DesRece','DesReceB1','',Key);
end;

procedure TFrmTipoReceita.edB2CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edB2),'ReceitaB2','IDRece','DesRece','DesReceB2','',0);
end;

procedure TFrmTipoReceita.edB2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edB2),'ReceitaB2','IDRece','DesRece','DesReceB2','',Key);
end;

procedure TFrmTipoReceita.edC1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC1),'ReceitaC1','IDRece','DesRece','DesReceC1','',0);
end;

procedure TFrmTipoReceita.edC1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC1),'ReceitaC1','IDRece','DesRece','DesReceC1','',Key);
end;

procedure TFrmTipoReceita.edC2CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC2),'ReceitaC2','IDRece','DesRece','DesReceC2','',0);
end;

procedure TFrmTipoReceita.edC2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC2),'ReceitaC2','IDRece','DesRece','DesReceC2','',Key);
end;

procedure TFrmTipoReceita.edC3CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC3),'ReceitaC3','IDRece','DesRece','DesReceC3','',0);
end;

procedure TFrmTipoReceita.edC3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC3),'ReceitaC3','IDRece','DesRece','DesReceC3','',Key);
end;

procedure TFrmTipoReceita.edC4CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC4),'ReceitaC4','IDRece','DesRece','DesReceC4','',0);
end;

procedure TFrmTipoReceita.edC4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC4),'ReceitaC4','IDRece','DesRece','DesReceC4','',Key);
end;

procedure TFrmTipoReceita.edC5CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC5),'ReceitaC5','IDRece','DesRece','DesReceC5','',0);
end;

procedure TFrmTipoReceita.edC5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edC5),'ReceitaC5','IDRece','DesRece','DesReceC5','',Key);
end;

procedure TFrmTipoReceita.edD1CustomButtons0Click(Sender: TObject; index: Integer);
begin
   btBuscasDB(TabParam,'arqreceitas',TDBEdit(edD1),'ReceitaD1','IDRece','DesRece','DesReceD1','',0);
end;

procedure TFrmTipoReceita.edD1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key <> VK_RETURN then
      btBuscasDB(TabParam,'arqreceitas',TDBEdit(edD1),'ReceitaD1','IDRece','DesRece','DesReceD1','',Key);
end;

procedure TFrmTipoReceita.FormShow(Sender: TObject);
begin
   TabParam.Open;

end;

procedure TFrmTipoReceita.edValDiaA1Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaA1.AsString := edValDiaA1.Text;
end;

procedure TFrmTipoReceita.edValDiaA2Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaA2.AsString := edValDiaA2.Text;
end;

procedure TFrmTipoReceita.edValDiaA3Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaA3.AsString := edValDiaA3.Text;
end;

procedure TFrmTipoReceita.edValDiaAMExit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaAM.AsString := edValDiaAM.Text;
end;

procedure TFrmTipoReceita.edValDiaB1Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaB1.AsString := edValDiaB1.Text;
end;

procedure TFrmTipoReceita.edValDiaB2Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaB2.AsString := edValDiaB2.Text;
end;

procedure TFrmTipoReceita.edValDiaC1Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaC1.AsString := edValDiaC1.Text;
end;

procedure TFrmTipoReceita.edValDiaC2Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaC2.AsString := edValDiaC2.Text;
end;

procedure TFrmTipoReceita.edValDiaC3Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaC3.AsString := edValDiaC3.Text;
end;

procedure TFrmTipoReceita.edValDiaC4Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaC4.AsString := edValDiaC4.Text;
end;

procedure TFrmTipoReceita.edValDiaC5Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaC5.AsString := edValDiaC5.Text;
end;

procedure TFrmTipoReceita.edValDiaD1Exit(Sender: TObject);
begin
   if not(TabParam.State in dsEditModes) then
      TabParam.Edit;
   TabParamValDiaD1.AsString := edValDiaD1.Text;
end;

procedure TFrmTipoReceita.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabParam.State in dsEditModes then
      MyApplayUpdates(TabParam, 'IDFilial', 'IDFilial = '+FILIAL.ToString, TabParam.State, True);
   TabParam.Close;
end;

end.
