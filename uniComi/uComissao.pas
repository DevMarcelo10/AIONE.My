unit uComissao;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, RxToolEdit, RxDBCtrl, MarcLib,
   LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
   LMDCustomBevelPanel, Vcl.ExtCtrls, AdvSmoothPanel, LMDGraph, LMDEdit,
   uRESTDWBasicDB, Vcl.StdCtrls;

type
  TFrmComissao = class(TForm)
    PanelAbre: TLMDSimplePanel;
    PanelBusca: TAdvSmoothPanel;
    lbAjuda: TLMDLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    timAlpha: TTimer;
    timWaitBusca: TTimer;
    edBusca: TLMDLabeledEdit;
    procedure PanelAbreResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure timWaitBuscaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
    antTyping:Integer;
    antEdBusca:String;
    procedure AbreCadastro;
    function  Aleatorio:String;
    function  VerificaTipo:Integer;
  public
    { Public declarations }
    auxIDComi: Integer;
  end;

var
   FrmComissao: TFrmComissao;

implementation

{$R *.dfm}

uses uDM, uConst, uPrincipal, uLibFarm, uBuscaCom, uComiCad;

procedure TFrmComissao.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmComissao.FormShow(Sender:TObject);
begin
   auxIDComi := 0;
   edBusca.SetFocus;
end;

procedure TFrmComissao.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmComissao.edBuscaCustomButtons0Click(Sender: TObject; index:Integer);
var
   lPoint:TPoint;
begin
   try
      edBusca.Tag := 0;
      FrmBuscaCom := TFrmBuscaCom.Create(Application);
      with FrmBuscaCom do
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
         auxIDComi := 0;
         edBusca.Text := edBusca.Tag.ToString;
         AbreCadastro;
      end;
      FrmBuscaCom.Free;
   end;
end;

procedure TFrmComissao.edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
begin
   AbreCadastro;
end;

procedure TFrmComissao.AbreCadastro;
var
   QueAuxi:TRESTDWClientSQL;
   strLimpo,auxCampo:String;
begin
   PanelAbre.SetFocus;
   if auxIDComi = 0 then
   begin
      auxCampo := '';
      strLimpo := Trim(edBusca.Text);
      if Length(strLimpo) >= 1 then
      begin
         if not IsNumeric(strLimpo) then
         begin
            if Length(strLimpo) >= 3 then auxCampo := 'DesComi LIKE ';
         end
         else auxCampo := 'IDComi = ';
         if auxCampo <> '' then
         begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            try
               with QueAuxi do
               begin
                  DataBase := DM.DWDataBase;
                  SQL.Text   := 'SELECT IDComi FROM arqcomi WHERE '+auxCampo+Aspas(Trim(edBusca.Text)+iif(AnsiPos('DesComi',auxCampo) > 0,'%',''))+' LIMIT 1';
                  QueAuxi.Open;
                  if not QueAuxi.IsEmpty then
                       auxIDComi := QueAuxi.FieldByName('IDComi').AsInteger
                  else auxIDComi := 0;
               end;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end; //if
      end; //if
   end; //if

   edBusca.Text := '';
   FrmComiCad := TFrmComiCad.Create(Application);
   FrmComiCad.Parent    := FrmPrincipal.PanelBas;
   CentralizarControl(FrmComiCad, FrmPrincipal.PanelBas);
   FrmComiCad.recCampo  := EliminaCaracteres(auxCampo, ' =');
   FrmComiCad.recIDComi := auxIDComi;
   if auxCampo <> '' then FrmComiCad.recValor := strLimpo;
   FrmComiCad.Show;
   auxIDComi := 0;
end;

procedure TFrmComissao.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then AbreCadastro;
end;

procedure TFrmComissao.timWaitBuscaTimer(Sender: TObject);
var
   nTyping:Integer;
   QueAuxi:TRESTDWClientSQL;
   auxCampo,txtType,txtNoFind,txtFind:String;
begin
   if nTyping = 99 then Exit;
   timWaitBusca.Enabled := False;
   try
      nTyping := VerificaTipo;
      if ((Trim(edBusca.Text) = '') or (nTyping = 0)) and (antTyping <> 0) then
      begin
         antTyping := 0;
         lbAjuda.Alignment := agTopCenter;
         TypingSimulation(lbAjuda,'Entre com a descrição ou nosso código interno',20,0);
         Exit;
      end
      else antTyping := nTyping;

      if antEdBusca <> Trim(edBusca.Text) then
           antEdBusca := Trim(edBusca.Text)
      else Exit;

      case nTyping of
         1:begin
              auxCampo  := 'IDComi = ';
              txtFind   := 'Parece ser um código interno. ';
              txtNoFind := 'Tem a forma de um código, mas não é válido.';
           end;
         2:begin
              auxCampo  := 'DesComi LIKE ';
              txtFind   := 'Formato de uma descrição da regra de comissão. ';
              txtNoFind := 'Procurei por algum que tenha a descrição que comecem com esta, mas não achei.';
           end;
      end; //case
      if auxCampo <> '' then
      begin
         auxIDComi := 0;
         QueAuxi   := TRESTDWClientSQL.Create(nil);
         try
            with QueAuxi do
            begin
               DataBase := DM.DWDataBase;
               SQL.Text := 'SELECT IDComi,DesComi FROM arqcomi WHERE '+auxCampo+Aspas(Trim(edBusca.Text)+iif(nTyping = 2,'%',''))+' LIMIT 1';
               QueAuxi.Open;
               if not IsEmpty then
               begin
                  lbAjuda.Caption := '';
                  txtType := txtFind+#10+Aleatorio+AllTrim(FieldByName('DesComi').AsString)+', código: '+FieldByName('IDComi').AsString;
                  nTyping := 99;
                  lbAjuda.Alignment := agCenterLeft;
                  TypingSimulation(lbAjuda, txtType, 10, 0);
                  auxIDComi := QueAuxi.FieldByName('IDComi').AsInteger;
               end else
               if nTyping <> 91 then
               begin
                  nTyping := 91;
                  lbAjuda.Alignment := agTopCenter;
                  TypingSimulation(lbAjuda,txtNoFind,10,0);
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
function TFrmComissao.VerificaTipo:Integer;
var
   strLimpo:String;
begin
   Result := 0;
   strLimpo := Trim(edBusca.Text);
   if IsNumeric(strLimpo) then
      Result := 1
   else
   if Length(strLimpo) >= 3 then Result := 2;
end;

function TFrmComissao.Aleatorio:String;
var
   rndNumero: Integer;
begin
   rndNumero := Random(3);
   case rndNumero of
      0:Result := 'Olha este: ';
      1:Result := 'Encontrei essa regra de comissão: ';
      2:Result := 'Este regra de desconto que tem estes dados: ';
      3:Result := 'Achei este: ';
   end;
end;

procedure TFrmComissao.PanelAbreResize(Sender:TObject);
begin
   PanelBusca.Top  := (Self.Height - PanelBusca.Height) div 2;
   PanelBusca.Left := (Self.Width  - PanelBusca.Width)  div 2;
end;

procedure TFrmComissao.FormClose(Sender: TObject; var Action:TCloseAction);
begin
   Action := caFree;
end;

end.
