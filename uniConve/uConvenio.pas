unit uConvenio;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDLabel, RxToolEdit, RxDBCtrl,
   LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,MarcLib, LMDGraph,
   LMDCustomLabel, LMDCustomBevelPanel, Vcl.ExtCtrls, AdvSmoothPanel,
   uRESTDWBasicDB, Vcl.StdCtrls;

type
   TFrmConvenios = class(TForm)
    PanelAbre: TLMDSimplePanel;
    PanelBusca: TAdvSmoothPanel;
    lbAjuda: TLMDLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    timAlpha: TTimer;
    timWaitBusca: TTimer;
    edBusca: TLMDLabeledEdit;
    procedure PanelAbreResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timAlphaTimer(Sender: TObject);
    procedure timWaitBuscaTimer(Sender: TObject);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
 private
    { Private declarations }
    Digitando:Boolean;
    antTyping:Integer;
    antEdBusca:String;
    procedure AbreCadastro;
    function Aleatorio: String;
    function VerificaTipo: Integer;
 public
    { Public declarations }
    auxIDConv: Integer;
 end;

var
   FrmConvenios: TFrmConvenios;

implementation

{$R *.dfm}

uses uDM, uConst, uPrincipal, uConvenioCad, uBuscaCon, uLibFarm;

procedure TFrmConvenios.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmConvenios.FormShow(Sender: TObject);
begin
   auxIDConv := 0;
   Digitando := False;
   edBusca.SetFocus;
end;

procedure TFrmConvenios.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmConvenios.edBuscaCustomButtons0Click(Sender: TObject;index: Integer);
var
   lPoint:TPoint;
begin
   try
      edBusca.Tag := 0;
      FrmBuscaCon := TFrmBuscaCon.Create(Application);
      with FrmBuscaCon do
      begin
         lPoint := Self.edBusca.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edBusca.Width;
         edRetorno := TEdit(Self.edBusca);
         edBusca.Text := Self.edBusca.Text;
         ShowModal;
      end; // with
   finally
      if edBusca.Tag > 0 then
      begin
         auxIDConv := 0;
         edBusca.Text := edBusca.Tag.ToString;
         AbreCadastro;
      end;
      FrmBuscaCon.Free;
   end;
end;

procedure TFrmConvenios.edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
begin
   AbreCadastro;
end;

procedure TFrmConvenios.AbreCadastro;
var
   Rct:TRect;
   QueAuxi:TRESTDWClientSQL;
   strLimpo,auxCampo:String;
begin
   PanelAbre.SetFocus;
   if auxIDConv = 0 then
   begin
      auxCampo := '';
      strLimpo := edBusca.Text.Trim;
      if Length(strLimpo) >= 1 then
      begin
         if IsNumeric(strLimpo)   then auxCampo := 'IDConv' else
         if Length(strLimpo) >= 3 then auxCampo := 'Nomcon';

         if auxCampo <> '' then
         begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            try
               with QueAuxi do
               begin
                  DataBase := DM.DWDataBase;
                  SQL.Text := 'SELECT IDConv FROM arqconvenio WHERE '+auxCampo+iif(auxCampo = 'Nomcon',' LIKE '+Aspas(strLimpo+'%'),' = '+strLimpo)+' LIMIT 1';
                  QueAuxi.Open;
                  if not QueAuxi.IsEmpty then
                       auxIDConv := QueAuxi.FieldByName('IDConv').AsInteger
                  else auxIDConv := 0;
               end;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end; //if
      end; //if
   end; //if

   GetWindowRect(TWinControl(FrmPrincipal.PanelBas).Handle, Rct);
   FrmConvCad := TFrmConvCad.Create(Application);
   FrmConvCad.Parent    := FrmPrincipal.PanelBas;
   FrmConvCad.RctAuxi   := Rct;
   FrmConvCad.recCampo  := EliminaCaracteres(auxCampo, ' =');
   FrmConvCad.recIDConv := auxIDConv;
   if auxCampo <> '' then FrmConvCad.recValor := strLimpo;
   FrmConvCad.FPainelOrigem := PanelBusca;
   PanelBusca.Visible := False;
   FrmConvCad.Show;
   edBusca.Clear;
   auxIDConv := 0;
end;

procedure TFrmConvenios.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then AbreCadastro;
end;

procedure TFrmConvenios.edBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   Digitando := True;
end;

procedure TFrmConvenios.timWaitBuscaTimer(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   nTyping:Integer;
   auxCampo,txtType,txtNoFind,txtFind:String;
begin
   if nTyping = 99 then Exit;
   timWaitBusca.Enabled := False;
   Digitando := False;
   Application.ProcessMessages;
   try
      nTyping := VerificaTipo;
      if ((edBusca.Text.Trim = '') or (nTyping = 0)) and (antTyping <> 0) then
      begin
         antTyping := 0;
         lbAjuda.Alignment := agTopCenter;
         TypingSimulation(lbAjuda, 'Entre com nome ou código', 20, 0);
         Exit;
      end
      else antTyping := nTyping;

      if antEdBusca <> edBusca.Text.Trim then
           antEdBusca := edBusca.Text.Trim
      else Exit;

      case nTyping of
        1:begin
             auxCampo  := 'IDConv = ';
             txtFind   := 'Parece ser um código. ';
             txtNoFind := 'Tem a forma de um código, mas não é válido.';
          end;
        2:begin
             auxCampo  := 'PES.CpfCnpjPes = ';
             txtFind   := 'Parece ser um CPF ou CNPJ. ';
             txtNoFind := 'Tem a forma de CPF/CNPJ, mas não é válido.';
          end;
        3:begin
             auxCampo  := 'Nomcon LIKE ';
             txtFind   := 'Formato de um nome de convênio. ';
             txtNoFind := 'Procurei por algum covênio que comecem com este nome, mas não achei.';
          end;
      end; //case

      Application.ProcessMessages;
      if (auxCampo <> '') and (not Digitando) then
      begin
         auxIDConv := 0;
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            with QueAuxi do
            begin
               DataBase := DM.DWDataBase;
               SQL.Text := 'SELECT CON.IDConv,CON.Nomcon,PES.CpfCnpjPes FROM arqconvenio CON LEFT JOIN '+
               'arqpessoa PES ON CON.IDPessPri = PES.IDPess WHERE '+auxCampo+Aspas(edBusca.Text.Trim+iif(nTyping = 3,'%',''))+' LIMIT 1';
               QueAuxi.Open;
               if not IsEmpty then
               begin
                  lbAjuda.Caption := '';
                  txtType := txtFind+#10+Aleatorio+FieldByName('Nomcon').AsString.Trim;
                  nTyping := 99;
                  lbAjuda.Alignment := agCenterLeft;
                  TypingSimulation(lbAjuda, txtType, 10, 0);
                  auxIDConv := QueAuxi.FieldByName('IDConv').AsInteger;
               end else
               if nTyping <> 91 then
               begin
                  nTyping := 91;
                  lbAjuda.Alignment := agTopCenter;
                  TypingSimulation(lbAjuda, txtNoFind, 10, 0);
               end;
            end; //with
         finally
            QueAuxi.Close;
            FreeAndNil(QueAuxi);
         end;
      end; //if
   finally
      timWaitBusca.Enabled := True;
   end;
end;

// ----------- Verifica Tipos do Campo de Busca ---------- //
function TFrmConvenios.VerificaTipo:Integer;
var
   strLimpo:String;
begin
   strLimpo := Trim(edBusca.Text);
   if not IsNumeric(strLimpo) then Result := 3 else
   if (strLimpo <> '') and IsNumeric(strLimpo) and (strLimpo.Trim.Length > 10) then Result := 2 else
   if (strLimpo <> '') and IsNumeric(strLimpo) then Result := 1 else
   if (strLimpo = '') then Result := 0;
end;

function TFrmConvenios.Aleatorio: String;
var
   rndNumero:Integer;
begin
   rndNumero := Random(3);
   case rndNumero of
      0: Result := 'Olha este: ';
      1: Result := 'Encontrei esse convênio: ';
      2: Result := 'Este convênio tem esses dados: ';
      3: Result := 'Achei este: ';
   end;
end;

procedure TFrmConvenios.PanelAbreResize(Sender: TObject);
begin
   PanelBusca.Top  := (Self.Height - PanelBusca.Height) div 2;
   PanelBusca.Left := (Self.Width  - PanelBusca.Width)  div 2;
end;

procedure TFrmConvenios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
