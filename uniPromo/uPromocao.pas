unit uPromocao;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   LMDControl, LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDEdit,
   LMDBaseEdit, LMDCustomEdit, LMDLabel, RxToolEdit, RxDBCtrl, MarcLib,
   LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel,
   LMDCustomBevelPanel, Vcl.ExtCtrls, AdvSmoothPanel, LMDGraph, RTTI,
   Vcl.Imaging.PngImage, AdvGlowButton, TypInfo, System.DateUtils,
   LMDCheckBox, FireDAC.Comp.Client, uRESTDWBasicDB, Vcl.StdCtrls;

type
  TFrmPromocao = class(TForm)
    PanelAbre: TLMDSimplePanel;
    PanelBusca: TAdvSmoothPanel;
    lbAjuda: TLMDLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    timAlpha: TTimer;
    timWaitBusca: TTimer;
    PanelItens: TLMDSimplePanel;
    PanelBotes: TLMDSimplePanel;
    btRetorna: TAdvGlowButton;
    btContinue: TAdvGlowButton;
    edBusca: TLMDLabeledEdit;
    procedure PanelAbreResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timAlphaTimer(Sender: TObject);
    procedure timWaitBuscaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edBuscaCustomButtons0Click(Sender: TObject; index: Integer);
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btContinueClick(Sender: TObject);
    procedure btRetornaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
  private
    { Private declarations }
    FormAtivo:TForm;
    antTyping:Integer;
    antEdBusca:String;
    procedure AbreCadastro;
    function  Aleatorio:String;
    function  VerificaTipo:Integer;
    procedure MudaAba(NomeAba: String);
    procedure AbreFrm(ClasFrm: TFormClass);
    procedure NovaPromo;
    procedure FechaSubForms;
  public
    { Public declarations }
    auxIDProm:Integer;
  end;

var
   FrmPromocao: TFrmPromocao;
   promoDIni,promoDFin:TDateTime;
   promoRecTipo,promoiAgrassivo:Integer;
   promoaIDGrupo,promoaIDGruSub,promoaFabrica:TArray<Integer>;

implementation

{$R *.dfm}

uses uDM, uConst, uMenCad, uPrincipal, uLibFarm, uPromocaoCad, uPromFil, uPromoFiltros,
     uPromFpg, uPromGru, uPromSub, uPromFab, uIAPromo, uBuscaProm, uPromCli;

procedure TFrmPromocao.FormCreate(Sender: TObject);
begin
   promoDIni := 0;
   promoDFin := 0;
   AdjustZoom(Self);
   SetLength(promoaIDGrupo, 0);
   SetLength(promoaIDGruSub,0);
   SetLength(promoaFabrica, 0);
   promoRecTipo    := -1;
   promoiAgrassivo := -1;
end;

procedure TFrmPromocao.FormShow(Sender:TObject);
begin
   auxIDProm := 0;
   edBusca.SetFocus;
end;

procedure TFrmPromocao.timAlphaTimer(Sender: TObject);
begin
   timAlpha.Enabled := False;
   FadeInOut(Self, 'In', 8);
end;

procedure TFrmPromocao.edBuscaCustomButtons0Click(Sender: TObject; index:Integer);
var
   lPoint:TPoint;
begin
   try
      edBusca.Tag := 0;
      FrmBuscaProm := TFrmBuscaProm.Create(Application);
      with FrmBuscaProm do
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
         auxIDProm := 0;
         edBusca.Text := edBusca.Tag.ToString;
         AbreCadastro;
      end;
      FrmBuscaProm.Free;
   end;
end;

procedure TFrmPromocao.edBuscaCustomButtons1Click(Sender: TObject; index: Integer);
begin
   AbreCadastro;
end;

// ------- Abre Promo já Cadastrada ou Inicia Nova Promoção ------- //
procedure TFrmPromocao.AbreCadastro;
var
   QueAuxi:TRESTDWClientSQL;
   strLimpo,auxCampo:String;
begin
   PanelAbre.SetFocus;
   if auxIDProm = 0 then
   begin
      auxCampo := '';
      strLimpo := Trim(edBusca.Text);
      if Length(strLimpo) >= 1 then
      begin
         if not IsNumeric(strLimpo) then
         begin
            if Length(strLimpo) >= 3 then auxCampo := 'DesProm LIKE ';
         end
         else auxCampo := 'IDProm = ';
         if auxCampo <> '' then
         begin
            QueAuxi := TRESTDWClientSQL.Create(nil);
            try
               with QueAuxi do
               begin
                  DataBase := DM.DWDataBase;
                  SQL.Text := 'SELECT IDProm FROM arqpromocao WHERE '+auxCampo+Aspas(edBusca.Text.Trim+iif(AnsiPos('DesProm',auxCampo) > 0,'%',''))+' LIMIT 1';
                  QueAuxi.Open;
                  if QueAuxi.IsEmpty then
                       auxIDProm := 0
                  else auxIDProm := QueAuxi.FieldByName('IDProm').AsInteger;
               end;
            finally
               QueAuxi.Close;
               FreeAndNil(QueAuxi);
            end;
         end; //if
      end; //if
   end; //if

   if auxIDProm > 0 then
   begin
      edBusca.Text := '';
      FrmPromCad := TFrmPromCad.Create(Application);
      FrmPromCad.Parent := FrmPrincipal.PanelBas;
      CentralizarControl(FrmPromCad, FrmPrincipal.PanelBas);
      FrmPromCad.recCampo  := EliminaCaracteres(auxCampo, ' =');
      FrmPromCad.recIDProm := auxIDProm;
      if auxCampo <> '' then FrmPromCad.recValor := strLimpo;
      FrmPromCad.Show;
      auxIDProm := 0;
      Exit;
   end;

   if Length(edBusca.Text) < 3 then
   begin
      TypingSimulation(lbAjuda, 'Para começar uma nova promoção, é preciso de um nome válido...' ,10,0);
      edBusca.SetFocus;
      Exit;
   end;

   MudaAba('PanTipo');
   btRetorna.Tag  := 1;
   btContinue.Tag := 2;
end;

procedure TFrmPromocao.btContinueClick(Sender: TObject);
begin
   case btContinue.Tag of
      1: MudaAba('PanTipo');
      2: MudaAba('PanEstilo');
      3: begin
            if FrmPromFiltros.edDateON.Date = StrToDate('01/01/2024') then
               FrmPromFiltros.edDateON.Date := Now();
            MudaAba('PanPeriodo');
         end;
      4: MudaAba('PanDiaSema');
      5: MudaAba('PanMudPrec');
      6: begin
            if not Assigned(FrmPromFil) then FrmPromFil := TFrmPromFil.Create(Application);
            AbreFrm(TFrmPromFil);
         end;
      7: begin
            if not Assigned(FrmPromFpg) then FrmPromFpg := TFrmPromFpg.Create(Application);
            AbreFrm(TFrmPromFpg);
         end;
      8: begin
            if not Assigned(FrmPromGru) then FrmPromGru := TFrmPromGru.Create(Application);
            AbreFrm(TFrmPromGru);
         end;
      9: begin
            if not Assigned(FrmPromSub) then FrmPromSub := TFrmPromSub.Create(Application);
            AbreFrm(TFrmPromSub);
         end;
     10: begin
            if not Assigned(FrmPromFab) then FrmPromFab := TFrmPromFab.Create(Application);
            AbreFrm(TFrmPromFab);
         end;
     11: begin
            if not Assigned(FrmPromCli) then FrmPromCli := TFrmPromCli.Create(Application);
            AbreFrm(TFrmPromCli);
         end;
     12: begin
            if MostraMsg('Confirmação', 'Posso gerar uma nova promoção?', mtConfirmation, [mbYes, mbNo]) = mrYes then
               NovaPromo
            else Exit
         end;
   end; //case
   btRetorna.Tag := btContinue.Tag;
   if btContinue.Tag < 12 then btContinue.Tag := btContinue.Tag + 1;
end;

procedure TFrmPromocao.btRetornaClick(Sender: TObject);
begin
   btContinue.Tag := btRetorna.Tag;
   if btRetorna.Tag > 0 then btRetorna.Tag := btRetorna.Tag - 1;
   case btRetorna.Tag of
      1: MudaAba('PanTipo');
      2: MudaAba('PanEstilo');
      3: MudaAba('PanPeriodo');
      4: MudaAba('PanDiaSema');
      5: MudaAba('PanMudPrec');
      6: AbreFrm(TFrmPromFil);
      7: AbreFrm(TFrmPromFpg);
      8: AbreFrm(TFrmPromGru);
      9: AbreFrm(TFrmPromSub);
     10: AbreFrm(TFrmPromFab);
     11: AbreFrm(TFrmPromCli);
      0: begin
            PanelItens.Visible := False;
            PanelBusca.Visible := True;
            edBusca.SetFocus;
         end;
   end; //with
end;

procedure TFrmPromocao.MudaAba(NomeAba:String);
var
   auxPanel:TAdvSmoothPanel;
begin
   if FormAtivo <> nil then FormAtivo.Hide;
   if not Assigned(FrmPromFiltros) then
        FrmPromFiltros := TFrmPromFiltros.Create(Application)
   else FrmPromFiltros.Close;
   FrmPromFiltros.Parent := PanelItens;
   auxPanel := TAdvSmoothPanel(FrmPromFiltros.FindComponent(NomeAba));
   auxPanel.Visible   := True;
   auxPanel.Top       := 1;
   auxPanel.Left      := 1;
   PanelItens.Width   := auxPanel.Width  + 8;
   PanelItens.Height  := auxPanel.Height + PanelBotes.Height + 8;
   PanelItens.Top     := (Self.Height - PanelItens.Height) div 2;
   PanelItens.Left    := (Self.Width  - PanelItens.Width)  div 2;
   PanelItens.Visible := True;
   PanelBusca.Visible := False;
   PanelBotes.Margins.Left  := 4;
   PanelBotes.Margins.Right := 8;
   FrmPromFiltros.Height := auxPanel.Height + 8;
   FrmPromFiltros.Width  := auxPanel.Width  + 8;
   FrmPromFiltros.Show;
end;

procedure TFrmPromocao.AbreFrm(ClasFrm:TFormClass);
var
  auxForm:TForm;
  NomeFrm:String;
  Tipo:TRttiType;
  Contexto:TRttiContext;
  Campo,camMosTop:TRttiField;
begin
   if Assigned(FrmPromFiltros) then FrmPromFiltros.Close;
   if FormAtivo <> nil then FormAtivo.Hide;
   NomeFrm   := Copy(ClasFrm.ClassName,2,Length(ClasFrm.ClassName)-1);
   auxForm   := Application.FindComponent(NomeFrm) as TForm;
   FormAtivo := auxForm;
   Tipo      := Contexto.GetType(FormAtivo.ClassType);
   Campo     := Tipo.GetField('recIndNew');
   camMosTop := Tipo.GetField('recMostop');
   if Assigned(Campo)     then Campo.SetValue(FormAtivo, True);
   if Assigned(camMosTop) then camMosTop.SetValue(FormAtivo, True);
   PanelItens.Width  := FormAtivo.Width;
   PanelItens.Height := 308 + PanelBotes.Height;
   PanelItens.Top    := (Self.Height - PanelItens.Height) div 2;
   PanelItens.Left   := (Self.Width  - PanelItens.Width)  div 2;
   FormAtivo.Parent  := PanelItens;
   PanelBotes.Margins.Left  := 0;
   PanelBotes.Margins.Right := 0;
   FormAtivo.Show;
end;

procedure TFrmPromocao.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then AbreCadastro;
end;

procedure TFrmPromocao.timWaitBuscaTimer(Sender: TObject);
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
              auxCampo  := 'IDProm = ';
              txtFind   := 'Parece ser um código interno. ';
              txtNoFind := 'Tem a forma de um código, mas não é válido.';
           end;
         2:begin
              auxCampo  := 'DesProm LIKE ';
              txtFind   := 'Formato de uma descrição da promoção. ';
              txtNoFind := 'Procurei por promoções cuja a descrição comece assim, mas não achei.'+#10+'Vou considerar que deseja fazer uma nova';
           end;
      end; //case
      if auxCampo <> '' then
      begin
         auxIDProm := 0;
         QueAuxi := TRESTDWClientSQL.Create(nil);
         try
            with QueAuxi do
            begin
               DataBase := DM.DWDataBase;
               SQL.Text := 'SELECT IDProm,DesProm FROM arqpromocao WHERE '+auxCampo+Aspas(AllTrim(edBusca.Text)+iif(nTyping = 2,'%',''))+' LIMIT 1';
               QueAuxi.Open;
               if not IsEmpty then
               begin
                  lbAjuda.Caption := '';
                  txtType := txtFind+#10+Aleatorio+AllTrim(FieldByName('DesProm').AsString)+', código: '+FieldByName('IDProm').AsString;
                  nTyping := 99;
                  lbAjuda.Alignment := agCenterLeft;
                  TypingSimulation(lbAjuda, txtType, 10, 0);
                  auxIDProm := QueAuxi.FieldByName('IDProm').AsInteger;
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
function TFrmPromocao.VerificaTipo:Integer;
var
   strLimpo:String;
begin
   Result := 0;
   strLimpo := edBusca.Text.Trim;
   if IsNumeric(strLimpo) then
      Result := 1
   else
   if Length(strLimpo) >= 3 then Result := 2;
end;

function TFrmPromocao.Aleatorio:String;
var
   rndNumero: Integer;
begin
   rndNumero := Random(3);
   case rndNumero of
      0: Result := 'Olha este: ';
      1: Result := 'Encontrei essa promoção: ';
      2: Result := 'Esta promoção tem estes dados: ';
      3: Result := 'Achei esta: ';
   end;
end;
// ------------- Criação de Nova Promoção ------------- //
procedure TFrmPromocao.NovaPromo;
var
   auxDiaSem:String;
   auxDatVenLot:TDate;
   GravouAlgum:Boolean;
   MemPromocao:TFDMemTable;
   QueAuxi,QueIncl:TRESTDWClientSQL;
   auxDataON,auxDataOF:TDateTime;
   auxPerDesIA,auxPrePromo,auxCusto:Double;
   I,acReg,auxDAVenc,auxDSVenda,auxDEAlto:Integer;
begin
   try
      auxDataON := StrToDateTime(FrmPromFiltros.edDateON.Text+' '+FrmPromFiltros.edTimeON.Text+':00');
      if FrmPromFiltros.edDateOFF.Date > 1 then
           auxDataOF := StrToDateTime(FrmPromFiltros.edDateOFF.Text+' '+FrmPromFiltros.edTimeOFF.Text+':00')
      else auxDataOF := 0;
      if FrmPromFiltros.edDatVenLot.Date > 1 then
           auxDatVenLot := FrmPromFiltros.edDatVenLot.Date
      else auxDatVenLot := 0;
   except
      MostraMsg('Erro','Período da promoção está inválido!', mtError, [mbOk]);
      Exit;
   end;

   auxDiaSem := '';
   for I := 1 to 7 do
   begin
      if TLMDCheckBox(FrmPromFiltros.FindComponent('CheckDia'+I.ToString)).Checked then
         auxDiaSem := auxDiaSem + iif(auxDiaSem.Trim = '','',',')+I.ToString;
   end; //for

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DM.DWDataBase;
   QueIncl := TRESTDWClientSQL.Create(nil);
   QueIncl.DataBase := DM.DWDataBase;
   try
      Screen.Cursor := crHourGlass;
      QueAuxi.SQL.Text := 'INSERT INTO arqpromocao (Desprom,DataON,DataOFF,DatVenLot,ManPre,TipoProm,DiaSema,IndAtivo) VALUES ('+
      Aspas(edBusca.Text.Trim)+','+
      Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',auxDataON))+','+
      iif(auxDataOF > 1,    Aspas(FormatDateTime('yyyy-mm-dd hh:mm:ss',auxDataOF)),'NULL')+','+
      iif(auxDatVenLot > 1, Aspas(FormatDateTime('yyyy-mm-dd',auxDatVenLot)),'NULL')+','+
      iif(FrmPromFiltros.btSIM.Tag = 1,'True','False')+','+promoRecTipo.ToString+','+
      Aspas(auxDiaSem.Trim)+','+Aspas('1')+');';
      QueAuxi.SQL.Add('SELECT LAST_INSERT_ID() AS NewID;');
      QueAuxi.Open;
      auxIDProm := QueAuxi.FieldByName('NewID').AsInteger;
      QueAuxi.Close;

      with FrmPromFil do
      begin
         if not MemPromFil.IsEmpty then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'INSERT INTO arqpromofil (IDProm,IDFilial) VALUES ';
            MemPromFil.First;
            while not MemPromFil.Eof do
            begin
               QueAuxi.SQL.Add('('+auxIDProm.ToString+','+MemPromFilIDFilial.AsString+'), ');
               MemPromFil.Next;
            end;
            QueAuxi.SQL.Text := Copy(QueAuxi.SQL.Text,1,LastDelimiter(',',QueAuxi.SQL.Text)-1)+';';
            QueAuxi.ExecSQL;
         end; //if
      end; //with

      with FrmPromFpg do
      begin
         if not MemPromFpg.IsEmpty then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'INSERT INTO arqpromofpg (IDProm,IDForPag) VALUES ';
            MemPromFpg.First;
            while not MemPromFpg.Eof do
            begin
               QueAuxi.SQL.Add('('+auxIDProm.ToString+','+MemPromFpgIDForPag.AsString+'), ');
               MemPromFpg.Next;
            end;
            QueAuxi.SQL.Text := Copy(QueAuxi.SQL.Text,1,LastDelimiter(',',QueAuxi.SQL.Text)-1)+';';
            QueAuxi.ExecSQL;
         end; //if
      end; //with

      with FrmPromCli do
      begin
         if not MemPromCli.IsEmpty then
         begin
            QueAuxi.Close;
            QueAuxi.SQL.Text := 'INSERT INTO arqpromocli (IDProm,IDPess) VALUES ';
            MemPromCli.First;
            while not MemPromCli.Eof do
            begin
               QueAuxi.SQL.Add('('+auxIDProm.ToString+','+MemPromCliIDPess.AsString+'), ');
               MemPromCli.Next;
            end;
            QueAuxi.SQL.Text := Copy(QueAuxi.SQL.Text,1,LastDelimiter(',',QueAuxi.SQL.Text)-1)+';';
            QueAuxi.ExecSQL;
         end; //if
      end; //with

      if promoRecTipo = 0 then
      begin
         // ....... Verifica se Há Grupos à Filtrar ....... //
         SetLength(promoaIDGrupo, 0);
         with FrmPromGru do
         begin
            if not MemPromGru.IsEmpty then
            begin
               MemPromGru.First;
               while not MemPromGru.Eof do
               begin
                  SetLength(promoaIDGrupo, Length(promoaIDGrupo)+1);
                  promoaIDGrupo[High(promoaIDGrupo)] := MemPromGruIDGrupo.AsInteger;
                  MemPromGru.Next;
               end; //while
            end; //if
         end; //with
         // ....... Verifica se Há Sub Grupos à Filtrar ...... //
         SetLength(promoaIDGruSub, 0);
         with FrmPromSub do
         begin
            if not MemPromSub.IsEmpty then
            begin
               MemPromSub.First;
               while not MemPromSub.Eof do
               begin
                  SetLength(promoaIDGruSub, Length(promoaIDGruSub)+1);
                  promoaIDGruSub[High(promoaIDGruSub)] := MemPromSubIDGruSub.AsInteger;
                  MemPromSub.Next;
               end; //while
            end; //if
         end; //with
         // ....... Verifica se Há Fabricantes à Filtrar ....... //
         SetLength(promoaFabrica, 0);
         with FrmPromFab do
         begin
            if not MemPromFab.IsEmpty then
            begin
               MemPromFab.First;
               while not MemPromFab.Eof do
               begin
                  SetLength(promoaFabrica, Length(promoaFabrica)+1);
                  promoaFabrica[High(promoaFabrica)] := MemPromFabIDPess.AsInteger;
                  MemPromFab.Next;
               end; //while
            end; //if
         end; //with

         // ...... Aciona IA de Seleção de Produtos P/ Promoção ..... //
         QueAuxi.Close;
         QueAuxi.SQL.Text := 'SELECT * FROM arqiatensores LIMIT 1';
         QueAuxi.Open;
         auxDAVenc   := QueAuxi.FieldByName('Promo_Dias_AVenc').AsInteger;
         auxDSVenda  := QueAuxi.FieldByName('Promo_Dias_SVenda').AsInteger;
         auxDEAlto   := QueAuxi.FieldByName('Promo_Dias_EAlto').AsInteger;
         MemPromocao := TFDMemTable.Create(nil);
         MemPromocao := SelProdProm(promoaIDGrupo,promoaIDGruSub,promoaFabrica,auxDSVenda,auxDAVenc,auxDEAlto,promoiAgrassivo,0.00,promoDIni,promoDFin,auxDatVenLot);

         // ...... Salva Produtos com Descontos em arqpromopro ...... //
         QueAuxi.Close;
         QueAuxi.SQL.Text :=
         'SELECT p.IDProd,a.DatRece,COALESCE(a.Vlruni, 0.00) AS UltPreCom,p.CustoMed,p.PrecoVen FROM arqproduto p '+
         'LEFT JOIN (SELECT i.IDProd, i.Vlruni, c.DatRece FROM arqcomprarecite i INNER JOIN arqcomprarec c ON i.IDRec = c.IDRec '+
         'INNER JOIN (SELECT IDProd, MAX(DatRece) AS MaxDatRece FROM arqcomprarecite ic '+
         'INNER JOIN arqcomprarec cc ON ic.IDRec = cc.IDRec GROUP BY IDProd) m ON i.IDProd = m.IDProd AND c.DatRece = m.MaxDatRece) a '+
         'ON p.IDProd = a.IDProd WHERE NOT ISNULL(a.DatRece) AND p.PrecoVen > 0.00 AND p.CustoMed > 0.00 ORDER BY p.IDProd ';
         QueAuxi.Open;
         acReg := 0;
         GravouAlgum := False;
         QueIncl.SQL.Text := 'INSERT INTO arqpromopro (IDProm,IDProd,Qtdest,PrecoVen,Cusmed,UltPreCom,PerDesIA,PrePromo) VALUES ';

         MemPromocao.First;
         while not MemPromocao.Eof do
         begin
            if MemPromocao.FieldByName('IndEntra').AsBoolean then
            begin
               if (MemPromocao.FieldByName('NewMark').AsFloat > 0.00)  and
                  QueAuxi.Locate('IDProd',MemPromocao.FieldByName('IDProd').AsInteger,[]) then
               begin
                  auxCusto := iif(QueAuxi.FieldByName('CustoMed').AsFloat <= 0.00, QueAuxi.FieldByName('UltPreCom').AsFloat, QueAuxi.FieldByName('CustoMed').AsFloat);
                  auxPrePromo := RoundX(auxCusto * (1 + (MemPromocao.FieldByName('NewMark').AsFloat/100)),2);
                  if auxPrePromo > 0.00 then
                       auxPerDesIA := ((QueAuxi.FieldByName('PrecoVen').AsFloat - auxPrePromo) / QueAuxi.FieldByName('PrecoVen').AsFloat) * 100
                  else auxPerDesIA := 0.00;
                  if auxPerDesIA > 0 then
                  begin
                     QueIncl.SQL.Add('('+auxIDProm.ToString+','+
                     MemPromocao.FieldByName('IDProd').AsString+','+
                     FormatDouble(MemPromocao.FieldByName('QtdEstoque').AsFloat,9,2)+','+
                     FormatDouble(QueAuxi.FieldByName('PrecoVen').AsFloat,9,2)+','+
                     FormatDouble(QueAuxi.FieldByName('CustoMed').AsFloat,9,2)+','+
                     FormatDouble(QueAuxi.FieldByName('UltPreCom').AsFloat,9,2)+','+
                     FormatDouble(auxPerDesIA,6,2)+','+
                     FormatDouble(auxPrePromo,9,2)+'),');
                     Inc(acReg);
                  end; //if
               end; //if
            end; //if
            MemPromocao.Next;
            if (acReg > 80) or MemPromocao.Eof then
            begin
               if AcReg > 0 then
               begin
                  QueIncl.SQL.Text := Copy(QueIncl.SQL.Text,1,LastDelimiter(',',QueIncl.SQL.Text)-1)+' ';
                  QueIncl.SQL.Add('ON DUPLICATE KEY UPDATE PerDesIA = VALUES(PerDesIA), PrePromo = VALUES(PrePromo);');
                  QueIncl.ExecSQL;
                  GravouAlgum := True;;
               end; //if
               acReg := 0;
               QueIncl.SQL.Text := 'INSERT INTO arqpromopro (IDProm,IDProd,Qtdest,PrecoVen,Cusmed,UltPreCom,PerDesIA,PrePromo) VALUES ';
            end; //if
         end; //while
      end; //if

      if not GravouAlgum then
         MostraMsg('Aviso','IA não encontrou produtos, com os parâmetros informados, para promoção!', mtWarning, [mbOk]);

      FechaSubForms;
      PanelItens.Visible := False;
      PanelBusca.Visible := True;

      // ------ Abre Tela de Cadastro ------ //
      edBusca.Text := '';
      FrmPromCad := TFrmPromCad.Create(Application);
      FrmPromCad.Parent := FrmPrincipal.PanelBas;
      CentralizarControl(FrmPromCad, FrmPrincipal.PanelBas);
      FrmPromCad.recIDProm := auxIDProm;
      FrmPromCad.recCampo  := '';
      FrmPromCad.recValor  := '';
      FrmPromCad.Margins.Top := 1;
      FrmPromCad.Show;
      auxIDProm := 0;
   finally
      QueAuxi.Close;
      QueAuxi.Free;
      QueIncl.Free;
      Screen.Cursor := crDefault;
   end;
end;

procedure TFrmPromocao.PanelAbreResize(Sender:TObject);
begin
   PanelBusca.Top  := (Self.Height - PanelBusca.Height) div 2;
   PanelBusca.Left := (Self.Width  - PanelBusca.Width)  div 2;
end;

procedure TFrmPromocao.FechaSubForms;
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

procedure TFrmPromocao.FormClose(Sender: TObject; var Action:TCloseAction);
begin
   Action := caFree;
end;

end.
