unit uPessoas;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDDBEdit, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDEdit, LMDCustomMaskEdit, LMDCustomExtCombo,
   LMDLabel, LMDListComboBox, LMDDBListComboBox, Vcl.StdCtrls, Vcl.Mask,
   RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel,
   LMDCustomListComboBox, LMDCustomLabel, LMDCustomBevelPanel, MarcLib,
   Vcl.ExtCtrls, AdvGlowButton, AdvSmoothPanel, LMDGraph, uRESTDWBasicDB,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
   FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, uRESTDWBasicTypes,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmPessoas = class(TForm)
    timAlpha: TTimer;
    timWaitBusca: TTimer;
    PanelAbre: TAdvSmoothPanel;
    PanelBusca: TAdvSmoothPanel;
    lbAjuda: TLMDLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    edBusca: TLMDLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timAlphaTimer(Sender: TObject);
    procedure timWaitBuscaTimer(Sender: TObject);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
    procedure edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure FormResize(Sender: TObject);
 private
    { Private declarations }
    antTyping:Integer;
    antEdBusca: String;
    Digitando:Boolean;
    procedure AbreCadastro;
    function Aleatorio(recTipo: String): String;
    function VerificaTipo: Integer;
 public
    { Public declarations }
    auxIDPess: Integer;
 end;

var
   FrmPessoas: TFrmPessoas;

implementation

{$R *.dfm}

uses uDM, uConst, uPrincipal, uLibFarm, uBuscaPes, uPessoasCad;

procedure TFrmPessoas.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmPessoas.FormShow(Sender: TObject);
begin
   auxIDPess := 0;
   Digitando := False;
   edBusca.SetFocus;
end;

procedure TFrmPessoas.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmPessoas.AbreCadastro;
var
   QueAuxi:TRESTDWClientSQL;
   strLimpo,auxCampo:String;
begin
   PanelAbre.SetFocus;
   if auxIDPess = 0 then
   begin
      auxCampo := '';
      strLimpo := edBusca.Text.Trim;
      if Length(strLimpo) >= 1 then
      begin
         if IsNumeric(strLimpo) then
         begin
            if CNPJ(strLimpo) and (Length(strLimpo) >= 14) then auxCampo := 'CpfCnpjPes = ' else
            if CPF(strLimpo)  and (Length(strLimpo) >= 11) then auxCampo := 'CpfCnpjPes = ' else
            if ValidaCelular (strLimpo) and (Length(strLimpo) >  11) then auxCampo := 'CelularPes = ' else
            if ValidaFoneFixo(strLimpo) and (Length(strLimpo) >= 10) then auxCampo := 'FonePes = '    else
               auxCampo := 'IDPess = ';
            if auxCampo <> '' then
            begin
               QueAuxi := TRESTDWClientSQL.Create(nil);
               try
                  with QueAuxi do
                  begin
                     DataBase := DM.DWDataBase;
                     SQL.Text := 'SELECT IDPess FROM arqpessoa WHERE '+auxCampo+Aspas(AllTrim(edBusca.Text)+iif(AnsiPos('Nompes',auxCampo) > 0, '%', ''))+' LIMIT 1';
                     QueAuxi.Open;
                     if not QueAuxi.IsEmpty then
                          auxIDPess := QueAuxi.FieldByName('IDPess').AsInteger
                     else auxIDPess := 0;
                  end;
               finally
                  QueAuxi.Close;
                  FreeAndNil(QueAuxi);
               end;
            end;
         end; //if
      end else
      if Length(strLimpo) >= 3 then auxCampo := 'Nompes';
   end; // if

   FrmPesCad := TFrmPesCad.Create(Application);
   CentralizarControl(FrmPesCad, PanelAbre);
   FrmPesCad.Parent := PanelAbre;
   FrmPesCad.recCampo  := EliminaCaracteres(auxCampo, ' =');
   FrmPesCad.recIDPess := auxIDPess;
   FrmPesCad.recOrigem := 'CAD';
   if auxCampo <> '' then FrmPesCad.recValor := strLimpo;
   auxIDPess := 0;
   FrmPesCad.Show;
   edBusca.Clear;
end;

procedure TFrmPessoas.edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      edBusca.Tag := 0;
      FrmBuscaPes := TFrmBuscaPes.Create(Application);
      with FrmBuscaPes do
      begin
         lPoint := Self.edBusca.ClientToScreen(Point(0,0));
         Left   := lPoint.X;
         Top    := lPoint.Y;
         Width  := Self.edBusca.Width;
         edRetorno := TLMDEdit(Self.edBusca);
         edBusca.Text := Self.edBusca.Text;
         ShowModal;
      end; // with
   finally
      if edBusca.Tag > 0 then
      begin
         edBusca.Text := edBusca.Tag.ToString;
         AbreCadastro;
      end;
      FrmBuscaPes.Free;
   end;
end;

procedure TFrmPessoas.edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
begin
   AbreCadastro;
end;

procedure TFrmPessoas.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F2 then
   begin
      edBuscaCustomButtons0Click(Self,0);
      Key := 0;
   end else
   if Key = VK_RETURN then
   begin
      Key := 0;
      AbreCadastro;
   end;
end;

procedure TFrmPessoas.edBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   Digitando := True;
end;

procedure TFrmPessoas.timWaitBuscaTimer(Sender: TObject);
var
   QueAuxi: TRESTDWClientSQL;
   nTyping: Integer;
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
         //PanelBusca.Height := 154;
         lbAjuda.Alignment := agTopCenter;
         TypingSimulation(lbAjuda,'Entre com nome, telefone, CPF ou CNPJ', 20, 0);
         Exit;
      end
      else antTyping := nTyping;

      if antEdBusca <> edBusca.Text.Trim then
           antEdBusca := edBusca.Text.Trim
      else Exit;

      case nTyping of
         1: begin
               auxCampo  := 'IDPess = ';
               txtFind   := 'Parece ser um código. ';
               txtNoFind := 'Tem a forma de um código, mas não é válido.';
            end;
         2..3:begin
                auxCampo  := 'CpfCnpjPes = ';
                txtFind   := 'Tem tudo para ser um '+iif(Length(Trim(edBusca.Text)) > 11, 'CNPJ. ', 'CPF. ');
                txtNoFind := 'Tem o formato de um ' +iif(Length(Trim(edBusca.Text)) > 11, 'CNPJ', 'CPF')+'  mas não encontrei ninguém com este...';
              end;
         4: begin
              auxCampo  := 'Nompes LIKE ';
              txtFind   := 'Formato de nome ou razão social. ';
              txtNoFind := 'Procurei por alguém que tenha o nome ou razão social que comecem com este acima, mas não achei.';
            end;
         5: begin
               auxCampo := 'CelularPes = ';
               txtFind := 'Acredito ser número de celular. ';
               txtNoFind := 'Procurei por um celular como este, mas não tem.';
            end;
         6: begin
               auxCampo  := 'FonePes = ';
               txtFind   := 'Pode ser um fone fixo. ';
               txtNoFind := 'Procurei pelo número de um fone fixo e não encontrei.';
            end;
      end; //case
      Application.ProcessMessages;
      if (auxCampo <> '') and (not Digitando) then
      begin
         auxIDPess := 0;
         QueAuxi   := TRESTDWClientSQL.Create(nil);
         try
            with QueAuxi do
            begin
               DataBase := DM.DWDataBase;
               if (nTyping = 2) or (nTyping = 3) then edBusca.Text := EliminaCaracteres(edBusca.Text,' ./-');
               SQL.Text := 'SELECT IDPess,Nompes,Endpes,CpfCnpjPes,FonePes,CelularPes FROM arqpessoa WHERE '+auxCampo+Aspas(edBusca.Text.Trim+iif(nTyping = 4,'%', ''))+' LIMIT 1';
               QueAuxi.Open;
               if not IsEmpty then
               begin
                  lbAjuda.Caption := '';
                  txtType := txtFind+#10+Aleatorio('PES')+FieldByName('Nompes').AsString.Trim+', '+
                  iif(FieldByName('Endpes').AsString.Trim <> '',FieldByName('Endpes').AsString.Trim,'')+
                  iif(FieldByName('CpfCnpjPes').AsString.Trim <> '',' com '+iif(Length(Trim(FieldByName('CpfCnpjPes').AsString)) > 11, 'CNPJ ','CPF ')+
                  iif(Length(Trim(FieldByName('CpfCnpjPes').AsString)) > 11,FormataCNPJ(FieldByName('CpfCnpjPes').AsString),FormataCPF(FieldByName('CpfCnpjPes').AsString)),'')+
                  iif(FieldByName('FonePes').AsString.Trim    <> '',', '+FormataFone(FieldByName('FonePes').AsString.Trim,   0),'')+
                  iif(FieldByName('CelularPes').AsString.Trim <> '',', '+FormataFone(FieldByName('CelularPes').AsString.Trim,9),'');
                  nTyping := 99;
                  //PanelBusca.Height := 133;
                  lbAjuda.Alignment := agCenterLeft;
                  TypingSimulation(lbAjuda, txtType, 10, 0);
                  auxIDPess := QueAuxi.FieldByName('IDPess').AsInteger;
               end else
               if nTyping <> 91 then
               begin
                  nTyping := 91;
                  //PanelBusca.Height := 154;
                  lbAjuda.Alignment := agTopCenter;
                  TypingSimulation(lbAjuda, txtNoFind, 10, 0);
               end;
            end; // with
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
function TFrmPessoas.VerificaTipo:Integer;
var
   strLimpo: String;
begin
   Result := 1;
   strLimpo := EliminaCaracteres(edBusca.Text,' ./-');
   if Length(strLimpo) >= 3 then
   begin
      if IsNumeric(strLimpo) then
      begin
         if CNPJ(strLimpo) and (Length(strLimpo) >= 14) then Result := 3 else
         if ValidaCelular(strLimpo)  and (Length(strLimpo) >= 11) then Result := 5 else
         if ValidaFoneFixo(strLimpo) and (Length(strLimpo) >= 10) then Result := 6 else
         if CPF(strLimpo) and (Length(strLimpo) >= 11) then Result := 2;
      end
      else Result := 4;
   end else
   if (strLimpo <> '') and IsNumeric(strLimpo) then Result := 1 else
   if (strLimpo = '') then Result := 0;
end;

function TFrmPessoas.Aleatorio(recTipo: String): String;
var
   rndNumero:Integer;
begin
   rndNumero := Random(3);
   case rndNumero of
      0:Result := 'Olha este: ';
      1:Result := 'Encontrei essa pessoa: ';
      2:Result := 'Esta pessoa tem esses dados: ';
      3:Result := 'Achei este: ';
   end;
end;

procedure TFrmPessoas.FormResize(Sender: TObject);
begin
   PanelBusca.Top  := (PanelAbre.Height - PanelBusca.Height) div 2;
   PanelBusca.Left := (PanelAbre.Width  - PanelBusca.Width) div 2;
end;

procedure TFrmPessoas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
