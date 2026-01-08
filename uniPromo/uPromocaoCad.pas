unit uPromocaoCad;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, RxToolEdit, RxDBCtrl,
   LMDBaseControl, LMDBaseLabel, LMDBaseGraphicControl, LMDCustomLabel,
   LMDCustomBevelPanel, Vcl.ExtCtrls, AdvGlowButton, MarcLib, Data.DB,
   LMDButtonControl, LMDCustomCheckBox, LMDDBCheckBox, Vcl.StdCtrls,
   LMDCheckBox, LMDSimplePanel, LMDDBEdit, Vcl.Mask, LMDControl,
   LMDCustomControl, LMDCustomPanel, System.DateUtils, LMDCustomMaskEdit,
   LMDMaskEdit, Vcl.Grids, Vcl.DBGrids, System.Rtti, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicDB,
   FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmPromCad = class(TForm)
    PanelCadastro: TLMDSimplePanel;
    timAlpha: TTimer;
    PanelTop: TLMDSimplePanel;
    LMDLabel2: TLMDLabel;
    btVoltar: TAdvGlowButton;
    PanelPromo: TLMDSimplePanel;
    PanelBotton: TLMDSimplePanel;
    PanelBack: TLMDSimplePanel;
    PanelMenCli: TLMDSimplePanel;
    PanelBas: TLMDSimplePanel;
    PanelDescr: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel3: TLMDLabel;
    LMDLabel4: TLMDLabel;
    LMDDBLabeledEdit1: TLMDDBLabeledEdit;
    LMDDBLabeledEdit2: TLMDDBLabeledEdit;
    LMDSimplePanel2: TLMDSimplePanel;
    LMDLabel5: TLMDLabel;
    Shape4: TShape;
    edDateON: TDateEdit;
    edTimeON: TLMDMaskEdit;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel6: TLMDLabel;
    Shape5: TShape;
    edDateOFF: TDateEdit;
    edTimeOFF: TLMDMaskEdit;
    LMDDBCheckBox3: TLMDDBCheckBox;
    CheckDia2: TLMDCheckBox;
    CheckDia3: TLMDCheckBox;
    CheckDia4: TLMDCheckBox;
    CheckDia5: TLMDCheckBox;
    CheckDia6: TLMDCheckBox;
    CheckDia7: TLMDCheckBox;
    CheckDia1: TLMDCheckBox;
    LMDDBCheckBox1: TLMDDBCheckBox;
    PanelButMen: TLMDSimplePanel;
    btProduto: TAdvGlowButton;
    btFilial: TAdvGlowButton;
    btForPG: TAdvGlowButton;
    btConve: TAdvGlowButton;
    btEcome: TAdvGlowButton;
    PanelButtons: TLMDSimplePanel;
    btExcluir: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    TabPromo: TRESTDWClientSQL;
    SouPromo: TDataSource;
    TabPromoIDProm: TIntegerField;
    TabPromoDesprom: TWideStringField;
    TabPromoDataON: TDateTimeField;
    TabPromoDataOFF: TDateTimeField;
    TabPromoDiaSema: TWideStringField;
    TabPromoManPre: TBooleanField;
    TabPromoTipoProm: TSmallintField;
    TabPromoIndAtivo: TWideStringField;
    btClientes: TAdvGlowButton;
    procedure timAlphaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btVoltarClick(Sender: TObject);
    procedure TabPromoAfterInsert(DataSet: TDataSet);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edTimeONExit(Sender: TObject);
    procedure edTimeOFFExit(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDateOFFExit(Sender: TObject);
  private
    { Private declarations }
    function Salvar:Boolean;
    procedure FechaSubForms;
  public
    { Public declarations }
    AtiForm:TForm;
    recIDProm:Integer;
    recCampo,recValor:String;
  end;

var
   FrmPromCad: TFrmPromCad;
   basIDDesc: Integer = 0;

implementation

{$R *.dfm}

uses uDM, uConst, uMenCad, uPrincipal, uPromocao, uLibFarm, uPromFil, uPromCli,
     uPromFpg, uPromEco, uPromCon, uPromPro, uPromPgr, uPromPgrPro;

procedure TFrmPromCad.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPromCad.FormShow(Sender: TObject);
var
   I:Integer;
   QueAuxi:TRESTDWClientSQL;
begin
   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase  := DM.DWDataBase;
   SouPromo.DataSet  := nil;
   TabPromo.SQL.Text := 'SELECT * FROM arqpromocao WHERE IDProm = '+recIDProm.ToString+' LIMIT 1';
   TabPromo.Open;
   if recIDProm > 0 then
   begin
      promoRecTipo := TabPromoTipoProm.Value;
      for I := 1 to 7 do
        TLMDCheckBox(Self.FindComponent('CheckDia'+I.ToString)).Checked := AnsiPos(I.ToString,TabPromoDiaSema.Value) > 0;
   end
   else TabPromo.Append;
   edDateON.Date    := DateOf(TabPromoDataON.Value);
   edDateOFF.Date   := DateOf(TabPromoDataOFF.Value);
   edTimeON.Text    := Copy(TimeToStr(TimeOf(TabPromoDataON.Value)), 1,5);
   edTimeOFF.Text   := Copy(TimeToStr(TimeOf(TabPromoDataOFF.Value)),1,5);
   SouPromo.DataSet := TabPromo;
   btProduto.Click;
   LMDDBLabeledEdit1.SetFocus;
end;

procedure TFrmPromCad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   i,prevIndex:Integer;
begin
   if (Key = VK_TAB) and (ssShift in Shift) then
   begin
      prevIndex := -1;
      for i := 0 to Self.ControlCount - 1 do
      begin
         if Self.Controls[i] = ActiveControl then
         begin
            if prevIndex >= 0 then
            begin
               TWinControl(Self.Controls[prevIndex]).SetFocus;
               Break;
            end;
         end
         else if TWinControl(Self.Controls[i]).CanFocus then prevIndex := i;
      end; //for
      Key := 0;
   end; //if
end;

procedure TFrmPromCad.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmPromCad.TabPromoAfterInsert(DataSet: TDataSet);
var
   I:Integer;
begin
   TabPromoDataON.Value := DataServer;
   TabPromoManPre.Value := False;
   TabPromoIndAtivo.Value := '1';
   for I := 1 to 7 do TLMDCheckBox(Self.FindComponent('CheckDia'+I.ToString)).Checked := True;
end;

procedure TFrmPromCad.edDateOFFExit(Sender: TObject);
begin
   if edDateOFF.Date < edDateON.Date then
   begin
      MostraMsg('Aviso', 'Data final está menor que a data de início!', mtWarning, [mbOk]);
      edDateOFF.SetFocus;
   end;
end;

procedure TFrmPromCad.edTimeOFFExit(Sender: TObject);
begin
   if edDateOFF.Date > 0 then
   begin
      try
         StrToDateTime(edDateOFF.Text+' '+edTimeOFF.Text+':00');
      except
         MostraMsg('Erro', 'A hora não é válida!', mtError, [mbOk]);
         edTimeOFF.SetFocus;
         Exit;
      end;
   end
   else edTimeOFF.Text := '00:00';
end;

procedure TFrmPromCad.edTimeONExit(Sender: TObject);
begin
   if edDateON.Date > 0 then
   begin
      try
         StrToDateTime(edDateON.Text+' '+edTimeON.Text+':00');
      except
         MostraMsg('Erro', 'A hora não é válida!', mtError, [mbOk]);
         edTimeON.SetFocus;
         Exit;
      end;
   end
   else edTimeON.Text := '00:00';
end;

procedure TFrmPromCad.btSalvarClick(Sender: TObject);
begin
   Salvar;
end;

// ------------------- Salvar ----------------- //
function TFrmPromCad.Salvar:Boolean;
var
   I,Erro:Integer;
   auxDiaSema:String;
begin
   Result := True;
   PanelTop.SetFocus;
   Erro := 0;
   if Length(AllTrim(TabPromoDesProm.Value)) < 5 then Erro := 1 else
   if edDateON.Date < 10 then Erro := 2 else
   if Erro > 0 then
   begin
      if Erro = 1 then
      begin
         MostraMsg('Aviso', 'Favor preencher a descrição corretamente!', mtWarning, [mbOk]);
         LMDDBLabeledEdit1.SetFocus;
      end else
      if Erro = 2 then
      begin
         MostraMsg('Aviso', 'A data da ativação deve ser preenchida!', mtWarning, [mbOk]);
         edDateON.SetFocus;
      end else
      Result := False;
      Exit;
   end; //if
   try
      StrToDateTime(edDateON.Text+' '+edTimeON.Text+':00');
   except
      MostraMsg('Erro', 'Esta data/hora não é válida!', mtError, [mbOk]);
      edTimeON.SetFocus;
      Result := False;
      Exit;
   end;
   if edDateOFF.Date > 0 then
   begin
      try
         StrToDateTime(edDateOFF.Text+' '+edTimeOFF.Text+':00');
      except
         MostraMsg('Erro', 'A data/hora não é válida!', mtError, [mbOk]);
         edTimeOFF.SetFocus;
         Result := False;
         Exit;
      end;
   end; //if

   if not (TabPromo.State in dsEditModes) then TabPromo.Edit;
   TabPromoDataON.Value := StrToDateTime(edDateON.Text+' '+edTimeON.Text+':00');
   if edDateOFF.Date > 0 then
      TabPromoDataOFF.Value := StrToDateTime(edDateOFF.Text+' '+edTimeOFF.Text+':00');
   auxDiaSema  := '';
   for I := 1 to 7 do
   begin
      if TLMDCheckBox(Self.FindComponent('CheckDia'+I.ToString)).Checked then
         auxDiaSema := auxDiaSema + iif(auxDiaSema.Trim = '','',',')+I.ToString;
   end; //for

   TabPromoDiaSema.Value := auxDiaSema;
   try
      TabPromo.Post;
   except
      on E:Exception do
      begin
         SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar salvar Promoção -> '+E.Message);
         MostraMsg('Erro', 'Não foi possível salvar', mtError, [mbOk]);
         Result := False;
         Exit;
      end;
   end;
end;

procedure TFrmPromCad.btNovoClick(Sender: TObject);
begin
   TabPromo.Cancel;
   TabPromo.Append;
end;

procedure TFrmPromCad.MenuClick(Sender: TObject);
var
   TAtiForm:TFormClass;
   Ctx:TRttiContext;
   Field:TRttiField;
   QueAuxi:TRESTDWClientSQL;
begin
   if AtiForm <> nil then AtiForm.Close;
   case TAdvGlowButton(Sender).Tag of
      1: TAtiForm := TFrmPromCon;
      2: TAtiForm := TFrmPromEco;
      3: TAtiForm := TFrmPromFpg;
      4: TAtiForm := TFrmPromFil;
      6: TAtiForm := TFrmPromCli;
      5: begin
         if promoRecTipo <> 0 then
         begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            QueAuxi.DataBase := DM.DWDataBase;
            try
               QueAuxi.SQL.Text := 'SELECT 1 FROM arqpromopgr WHERE IDProm = '+TabPromoIDProm.AsString+' LIMIT 1';
               QueAuxi.Open;
               if QueAuxi.IsEmpty then
                    TAtiForm := TFrmPromPgr
               else TAtiForm := TFrmPromPgrPro;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end //if
         else TAtiForm := TFrmPromPro;
      end;
   end; //case
   AtiForm := TAtiForm.Create(nil);
   Ctx := TRttiContext.Create;
   try
      Field := Ctx.GetType(AtiForm.ClassType).GetField('recIDProm');
      if Assigned(Field) then Field.SetValue(AtiForm, TabPromoIDProm.Value);
      AtiForm.Parent := PanelBas;
      AtiForm.Show;
   finally
      Ctx.Free;
   end;

   if (TAdvGlowButton(Sender).Tag = 5) and (promoRecTipo = 0) then
   begin
      Self.Width     := Round(1045 * GlobalScaleFactor);
      PanelBas.Width := Round(1045 * GlobalScaleFactor);
   end else
   if (TAdvGlowButton(Sender).Tag = 5) and (promoRecTipo = 1) then
   begin
      Self.Width     := Round(791 * GlobalScaleFactor);
      PanelBas.Width := Round(581 * GlobalScaleFactor);
   end else
   begin
      Self.Width     := Round(642 * GlobalScaleFactor);
      PanelBas.Width := Round(432 * GlobalScaleFactor);
   end;
   Self.Left         := (Screen.Width - PanelCadastro.Width) div 2;
   PanelDescr.Left   := (PanelCadastro.Width - PanelDescr.Width) div 2;
   PanelBas.Left     := (Self.Width - PanelBas.Width) div 2;
   PanelButMen.Left  := (PanelBack.Width - PanelButMen.Width)  div 2;
   PanelButtons.Left := (PanelBack.Width - PanelButtons.Width) div 2;
end;

// --------------- Exclusão de Promoções ------------ //
procedure TFrmPromCad.btExcluirClick(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
begin
   if (TabPromo.State <> dsInsert) and (TabPromoIDProm.Value > 0) then
   begin
      try
         QueAuxi := TRESTDWClientSQL.Create(nil);
         with QueAuxi do
         begin
            DataBase := DM.DWDataBase;
            //--> SQL.Text := 'SELECT 1 FROM arqpedido WHERE IDProm = '+TabPromoIDProm.AsString+' LIMIT 1';
            //--> Open;
            //--> if not IsEmpty then
            //--> begin
            //-->    MostraMsg('Não pode ser excluído','Existem itens vendidos com essa promoção.', mtInformation, [mbOk]);
            //-->    Exit;
            //--> end;
            //--> QueAuxi.Close;
            if MostraMsg('Confirmação', 'Deseja realmente excluir esta promoção?', mtConfirmation, [mbYes, mbNo]) = mrYes then
            begin
               try
                  SQL.Clear;
                  SQL.Add('DELETE FROM arqpromofil WHERE IDProm = '+TabPromoIDProm.AsString+';');
                  SQL.Add('DELETE FROM arqpromofpg WHERE IDProm = '+TabPromoIDProm.AsString+';');
                  SQL.Add('DELETE FROM arqpromoeco WHERE IDProm = '+TabPromoIDProm.AsString+';');
                  SQL.Add('DELETE FROM arqpromocon WHERE IDProm = '+TabPromoIDProm.AsString+';');
                  SQL.Add('DELETE FROM arqpromopro WHERE IDProm = '+TabPromoIDProm.AsString+';');
                  SQL.Add('DELETE FROM arqpromopgr WHERE IDProm = '+TabPromoIDProm.AsString+';');
                  SQL.Add('DELETE FROM arqpromocao WHERE IDProm = '+TabPromoIDProm.AsString+';');
                  ExecSQL;
                  Self.Close;
               except
                  on E:Exception do
                  begin
                     SalvaLog(USUARIO, PastaLog, 'ERRO ao tentar excluir registro do aquivo: arqpromocao, IDProm = '+TabPromoIDProm.AsString+' -> '+E.Message);
                     MostraMsg('Erro', 'Não foi possível efetivar a exclusão!',mtError, [mbOk]);
                     Exit;
                  end;
               end;
               SalvaLog(USUARIO, PastaLog, 'EXCLUSAO arqpromocao, IDProm = '+TabPromoIDProm.AsString);
            end; //if
         end; //with
      finally
         QueAuxi.Close;
         FreeAndNil(QueAuxi);
      end;
   end else
   begin
      TabPromo.Cancel;
      TabPromo.Append;
   end;
end;

procedure TFrmPromCad.btVoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmPromCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if TabPromoDesProm.AsString.Trim <> '' then CanClose := Salvar;
end;

procedure TFrmPromCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabPromo.State in dsEditModes then TabPromo.Cancel;
   TabPromo.Close;
   FechaSubForms;
  {if Assigned(FrmPromCon) then FrmPromCon.Close;
   if Assigned(FrmPromEco) then FrmPromEco.Close;
   if Assigned(FrmPromFpg) then FrmPromFpg.Close;
   if Assigned(FrmPromFil) then FrmPromFil.Close;
   if Assigned(FrmPromPro) then FrmPromPro.Close;
   if Assigned(FrmPromPgrPro) then FrmPromPgrPro.Close;
   if Assigned(FrmPromPgr) then
   begin
      FrmPromPgr.Close;
      FreeAndNil(FrmPromPgr);
   end;}
   FadeInOut(Self,'Out',10);
   Action := caFree;
end;

procedure TFrmPromCad.FechaSubForms;
var
   I:Integer;
begin
   for I := Application.ComponentCount - 1 downto 0 do
   begin
      if (Application.Components[I] is TFrmPrincipal) or (Application.Components[I] is TFrmMenCad) or
         (Application.Components[I] is TFrmPromCad)   or (Application.Components[I] is TFrmPromocao) then Continue;
      try
         if Application.Components[I] is TForm then (Application.Components[I] as TForm).Close;
      except
      end;
   end; //for
end;

end.

