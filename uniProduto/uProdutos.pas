unit uProdutos;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl,
   LMDCustomPanel, LMDDBEdit, LMDSimplePanel, LMDBaseEdit, LMDCustomEdit, LMDEdit,
   LMDCustomMaskEdit, LMDCustomExtCombo, LMDLabel, LMDListComboBox, LMDDBListComboBox,
   Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxDBCtrl, LMDBaseControl, LMDBaseGraphicControl,
   LMDBaseLabel, LMDCustomListComboBox, LMDCustomLabel, LMDCustomBevelPanel,MarcLib,
   Vcl.ExtCtrls, AdvGlowButton, AdvSmoothPanel, uRESTDWBasicDB, LMDGraph;

type
   TFrmProdutos = class(TForm)
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
    Digitando:Boolean;
    antTyping:Integer;
    antEdBusca:String;
    procedure AbreCadastro;
    function Aleatorio: String;
    function VerificaTipo: Integer;
 public
    { Public declarations }
    auxIDProd: Integer;
 end;

var
   FrmProdutos: TFrmProdutos;

implementation

{$R *.dfm}

uses uDM, uConst, uPrincipal, uLibFarm, uBuscaPro, uProdutoCad;

procedure TFrmProdutos.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmProdutos.FormShow(Sender: TObject);
begin
   auxIDProd := 0;
   Digitando := False;
   edBusca.SetFocus;
end;

procedure TFrmProdutos.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmProdutos.AbreCadastro;
var
   QueAuxi:TRESTDWClientSQL;
   strLimpo,auxCampo:String;
begin
   PanelAbre.SetFocus;
   Screen.Cursor := crHourGlass;
   try
      if auxIDProd = 0 then
      begin
         auxCampo := '';
         strLimpo := edBusca.Text.Trim;
         if Length(strLimpo) >= 1 then
         begin
            if not IsNumeric(strLimpo) then
            begin
               if Length(strLimpo) >= 3 then auxCampo := 'Despro LIKE ';
            end else
            if IsValidEANCode(strLimpo) then
                 auxCampo := 'CodEAN = '
            else auxCampo := 'PRO.IDProd = ';
            if auxCampo <> '' then
            begin
               QueAuxi := TRESTDWClientSQL.Create(nil);
               try
                  QueAuxi.DataBase := DM.DWDataBase;
                  QueAuxi.SQL.Text := 'SELECT PRO.IDProd FROM arqproduto PRO LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd ';
                  QueAuxi.SQL.Add('WHERE '+iif(AnsiPos(auxCampo,'CodEAN') > 0,'PRO.CodEANPri = '+Aspas(edBusca.Text.Trim)+' OR ','')+
                  auxCampo+Aspas(edBusca.Text.Trim+iif(AnsiPos('Despro',auxCampo) > 0,'%',''))+' LIMIT 1');
                  QueAuxi.Open;
                  if not QueAuxi.IsEmpty then
                       auxIDProd := QueAuxi.FieldByName('IDProd').AsInteger
                  else auxIDProd := 0;
               finally
                  QueAuxi.Close;
                  FreeAndNil(QueAuxi);
               end;
            end; //if
         end; //if
      end; //if

      FrmProdCad := TFrmProdCad.Create(Application);
      CentralizarControl(FrmProdCad, PanelAbre);
      FrmProdCad.Parent    := PanelAbre;
      FrmProdCad.recCampo  := EliminaCaracteres(auxCampo,' =');
      FrmProdCad.recIDProd := auxIDProd;
      FrmProdCad.recOrigem := 'PRO';
      FrmProdCad.FPainelOrigem := PanelBusca;
      if auxCampo <> '' then FrmProdCad.recValor := strLimpo;
      PanelBusca.Visible := False;
      FrmProdCad.Show;
      auxIDProd := 0;
   finally
      Screen.Cursor := crDefault;
   end;
end;

procedure TFrmProdutos.edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
var
   lPoint:TPoint;
begin
   try
      edBusca.Tag := 0;
      FrmBuscaPro := TFrmBuscaPro.Create(Application);
      with FrmBuscaPro do
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
         auxIDProd := 0;
         edBusca.Text := edBusca.Tag.ToString;
         AbreCadastro;
      end;
      FrmBuscaPro.Free;
   end;
end;

procedure TFrmProdutos.edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
begin
   AbreCadastro;
end;

procedure TFrmProdutos.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F2 then
   begin
      edBuscaCustomButtons0Click(Self,0);
      Key := 0;
   end else
   if Key = VK_RETURN then AbreCadastro;
end;

procedure TFrmProdutos.edBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   Digitando := True;
end;

procedure TFrmProdutos.timWaitBuscaTimer(Sender: TObject);
var
   QueAuxi:TRESTDWClientSQL;
   nTyping:Integer;
   auxCampo,txtType,txtNoFind,txtFind:String;
begin
   if nTyping = 99 then Exit;
   Digitando := False;
   timWaitBusca.Enabled := False;
   try
      nTyping := VerificaTipo;
      if ((Trim(edBusca.Text) = '') or (nTyping = 0)) and (antTyping <> 0) then
      begin
         antTyping := 0;
         PanelBusca.Height := 145;
         lbAjuda.Alignment := agTopCenter;
         TypingSimulation(lbAjuda,'Entre com descrição, código interno ou código de barras',20,0);
         Exit;
      end
      else antTyping := nTyping;

      if antEdBusca <> Trim(edBusca.Text) then
           antEdBusca := Trim(edBusca.Text)
      else Exit;

      case nTyping of
         1:begin
              auxCampo  := 'PRO.IDProd = ';
              txtFind   := 'Parece ser um código interno. ';
              txtNoFind := 'Tem a forma de um código, mas não é válido.';
           end;
         2:begin
              auxCampo  := 'CodEANpri = ';
              txtFind   := 'Tem tudo para ser um código de barras ';
              txtNoFind := 'Tem o formato de um código de barras mas não encontrei produtos com este...';
           end;
         3:begin
              auxCampo  := 'Despro LIKE ';
              txtFind   := 'Formato de uma descrição de produto. ';
              txtNoFind := 'Procurei por alguém que tenha a descrição que comecem com este acima, mas não achei.';
           end;
      end; //case

      Application.ProcessMessages;
      if (auxCampo <> '') and (not Digitando) then
      begin
         auxIDProd := 0;
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            with QueAuxi do
            begin
               DataBase := DM.DWDataBase;
               SQL.Text := 'SELECT PRO.IDProd,PRO.Despro,EAN.CodEAN FROM arqproduto PRO ';
               SQL.Add('LEFT JOIN arqprodutoean EAN ON PRO.IDProd = EAN.IDProd ');
               SQL.Add('WHERE '+auxCampo+Aspas(AllTrim(edBusca.Text)+iif(nTyping = 3,'%',''))+' LIMIT 1');
               QueAuxi.Open;
               if not IsEmpty then
               begin
                  lbAjuda.Caption := '';
                  txtType := txtFind+#10+Aleatorio+AllTrim(FieldByName('Despro').AsString)+', código: '+FieldByName('IDProd').AsString+iif(FieldByName('CodEAN').AsString.Trim <> '',' e código de barras: '+FieldByName('CodEAN').AsString,'');
                  nTyping := 99;
                  PanelBusca.Height := 155;
                  lbAjuda.Alignment := agCenterLeft;
                  TypingSimulation(lbAjuda, txtType,10,0);
                  auxIDProd := QueAuxi.FieldByName('IDProd').AsInteger;
               end else
               if nTyping <> 91 then
               begin
                  nTyping := 91;
                  PanelBusca.Height := 145;
                  lbAjuda.Alignment := agTopCenter;
                  TypingSimulation(lbAjuda, txtNoFind,10,0);
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

procedure TFrmProdutos.FormResize(Sender: TObject);
begin
   PanelBusca.Top  := (PanelAbre.Height - PanelBusca.Height) div 2;
   PanelBusca.Left := (PanelAbre.Width  - PanelBusca.Width) div 2;
end;

// ----------- Verifica Tipos do Campo de Busca ---------- //
function TFrmProdutos.VerificaTipo: Integer;
var
   strLimpo:String;
begin
   Result   := 0;
   strLimpo := edBusca.Text.Trim;
   if IsNumeric(strLimpo) then
   begin
      if Length(strLimpo) >= 12 then
           Result := 2
      else Result := 1;
   end
   else if Length(strLimpo) >= 3 then Result := 3;
end;

function TFrmProdutos.Aleatorio: String;
var
   rndNumero:Integer;
begin
   rndNumero := Random(3);
   case rndNumero of
      0: Result := 'Olha este: ';
      1: Result := 'Encontrei esse produto: ';
      2: Result := 'Este produto tem estes dados: ';
      3: Result := 'Achei este: ';
   end;
end;

procedure TFrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
