unit uPBM.TestForm;

{******************************************************************************
  PBM Test Form - Testes Individuais das 12 Operadoras
  
  Form VCL para testar cada operadora PBM de forma individual.
  Permite testar: Elegibilidade, Autorizacao, Cancelamento, Consulta.
  
  Recursos:
  - Teste individual por operadora (duplo clique ou menu)
  - SpeedButtons para testes rapidos
  - Menu popup com opcoes de teste
  - Fluxo completo (Eleg > Auth > Consulta > Cancel)
  - NSU/CodAuth armazenados por operadora
  - Dados padrao de homologacao por operadora
  
  Operadoras:
  1. Epharma           7. TRN Centre
  2. Funcional Card    8. PEC Febrafar
  3. Orizon            9. LinkedFarma
  4. Vidalink         10. Ellomais
  5. Farmacia Popular 11. Nosso Clube
  6. Pharmalink       12. Object Pro
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.DateUtils, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.Buttons, Vcl.Menus, Vcl.Mask,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Phys.MySQL,
  FireDAC.Stan.Async, FireDAC.DApt,
  MarcLib,  // iif() function
  uPBM.Interfaces, uPBM.Factory, uPBM.Persistence, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait;

type
  /// <summary>Status do teste</summary>
  TTestStatus = (tsNaoTestado, tsTestando, tsSucesso, tsFalha);
  
  /// <summary>Informacoes de teste por operadora</summary>
  TOperadoraTestInfo = record
    Tipo: TPBMType;
    Codigo: string;
    Nome: string;
    Status: TTestStatus;
    UltimoTeste: TDateTime;
    UltimaMensagem: string;
    TempoMS: Integer;
    UltimoNSU: string;
    UltimoCodAuth: string;
  end;

  TfrmPBM_Test = class(TForm)
    pnlLeft: TPanel;
    pnlCenter: TPanel;
    pnlRight: TPanel;
    pnlBottom: TPanel;
    
    // === PAINEL ESQUERDO - Lista de Operadoras ===
    gbxOperadoras: TGroupBox;
    lvOperadoras: TListView;
    chkHomologacao: TCheckBox;
    btnTestarTodas: TBitBtn;
    btnTestarSelecionada: TBitBtn;
    
    // Botoes de teste individual por operadora selecionada
    pnlTestesIndividuais: TPanel;
    lblTesteIndividual: TLabel;
    btnIndivElegibilidade: TSpeedButton;
    btnIndivAutorizacao: TSpeedButton;
    btnIndivCancelamento: TSpeedButton;
    btnIndivConsulta: TSpeedButton;
    
    // === PAINEL CENTRAL - Dados do Teste ===
    gbxConexao: TGroupBox;
    lblServer: TLabel;
    edtServer: TEdit;
    lblDatabase: TLabel;
    edtDatabase: TEdit;
    lblUser: TLabel;
    edtUser: TEdit;
    lblPassword: TLabel;
    edtPassword: TEdit;
    btnConectar: TBitBtn;
    shpConexao: TShape;
    
    gbxBeneficiario: TGroupBox;
    lblCarteirinha: TLabel;
    edtCarteirinha: TEdit;
    lblCPF: TLabel;
    edtCPF: TEdit;
    lblDataNasc: TLabel;
    edtDataNasc: TMaskEdit;
    chkUsarDadosPadrao: TCheckBox;
    
    gbxProdutos: TGroupBox;
    sgProdutos: TStringGrid;
    btnAddProduto: TBitBtn;
    btnRemProduto: TBitBtn;
    btnProdutosPadrao: TBitBtn;
    
    gbxAcoes: TGroupBox;
    btnTestarElegibilidade: TBitBtn;
    btnTestarAutorizacao: TBitBtn;
    btnTestarCancelamento: TBitBtn;
    btnTestarConsulta: TBitBtn;
    btnLimparLog: TBitBtn;
    
    // === PAINEL DIREITO - Resultados ===
    gbxResultado: TGroupBox;
    lblNSU: TLabel;
    edtNSU: TEdit;
    lblCodAutorizacao: TLabel;
    edtCodAutorizacao: TEdit;
    lblValorDesconto: TLabel;
    edtValorDesconto: TEdit;
    lblPontos: TLabel;
    edtPontos: TEdit;
    
    gbxLog: TGroupBox;
    mmoLog: TMemo;
    
    // === PAINEL INFERIOR - Status ===
    pnlStatus: TPanel;
    lblStatusOperadora: TLabel;
    lblStatusTempo: TLabel;
    pbProgress: TProgressBar;
    Label1: TLabel;
    
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    
    procedure btnConectarClick(Sender: TObject);
    procedure lvOperadorasSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvOperadorasDblClick(Sender: TObject);
    procedure chkUsarDadosPadraoClick(Sender: TObject);
    procedure btnProdutosPadraoClick(Sender: TObject);
    procedure btnAddProdutoClick(Sender: TObject);
    procedure btnRemProdutoClick(Sender: TObject);
    
    procedure btnTestarElegibilidadeClick(Sender: TObject);
    procedure btnTestarAutorizacaoClick(Sender: TObject);
    procedure btnTestarCancelamentoClick(Sender: TObject);
    procedure btnTestarConsultaClick(Sender: TObject);
    procedure btnTestarTodasClick(Sender: TObject);
    procedure btnTestarSelecionadaClick(Sender: TObject);
    procedure btnLimparLogClick(Sender: TObject);
    
    // Testes individuais via SpeedButtons
    procedure btnIndivElegibilidadeClick(Sender: TObject);
    procedure btnIndivAutorizacaoClick(Sender: TObject);
    procedure btnIndivCancelamentoClick(Sender: TObject);
    procedure btnIndivConsultaClick(Sender: TObject);
    
    // PopupMenu
    procedure mnuTestarElegibilidadeClick(Sender: TObject);
    procedure mnuTestarAutorizacaoClick(Sender: TObject);
    procedure mnuTestarCancelamentoClick(Sender: TObject);
    procedure mnuTestarConsultaClick(Sender: TObject);
    procedure mnuTestarFluxoCompletoClick(Sender: TObject);
    
  private
    FConnection: TFDConnection;
    FPersistence: IPBMPersistence;
    FOperadoras: TArray<TOperadoraTestInfo>;
    FOperadoraSelecionada: Integer;
    
    // PopupMenu para testes rapidos (criado em runtime)
    FpmOperadora: TPopupMenu;
    FmnuTestarElegibilidade: TMenuItem;
    FmnuTestarAutorizacao: TMenuItem;
    FmnuTestarCancelamento: TMenuItem;
    FmnuTestarConsulta: TMenuItem;
    FmnuSep1: TMenuItem;
    FmnuTestarFluxoCompleto: TMenuItem;
    
    procedure InicializarOperadoras;
    procedure AtualizarListaOperadoras;
    procedure ConfigurarGrid;
    procedure ConfigurarPopupMenu;
    procedure CarregarProdutosPadrao;
    procedure CarregarDadosPadrao;
    procedure CarregarDadosPadraoOperadora(ATipo: TPBMType);
    
    procedure Log(const AMsg: string; ACor: TColor = clBlack);
    procedure LogSeparador;
    procedure SetStatus(const AOperadora, AStatus: string; ACor: TColor);
    
    function GetOperadoraSelecionada: TOperadoraTestInfo;
    function GetProdutosTeste: TArray<TPBMProduto>;
    function CriarClient(ATipo: TPBMType): IPBMClient;
    function GetOperadoraIndex(ATipo: TPBMType): Integer;
    
    procedure AtualizarStatusOperadora(AIndex: Integer; AStatus: TTestStatus; 
      const AMensagem: string; ATempoMS: Integer);
    procedure AtualizarBotoesIndividuais;
    procedure HabilitarControles(AHabilitar: Boolean);
    
    function StrToDateSafe(const S: string; ADefault: TDateTime): TDateTime;
    
    // Testes
    procedure ExecutarTesteElegibilidade(ATipo: TPBMType);
    procedure ExecutarTesteAutorizacao(ATipo: TPBMType);
    procedure ExecutarTesteCancelamento(ATipo: TPBMType);
    procedure ExecutarTesteConsulta(ATipo: TPBMType);
    procedure ExecutarFluxoCompleto(ATipo: TPBMType);
    
  public
    property Connection: TFDConnection read FConnection;
  end;

var
  frmPBM_Test: TfrmPBM_Test;

implementation

{$R *.dfm}

const
  // Dados padrao para testes em homologacao
  CPF_TESTE = '12345678909';
  DATA_NASC_TESTE = '15/06/1980';
  
  // Cores de status
  COR_NAO_TESTADO = clGray;
  COR_TESTANDO = clYellow;
  COR_SUCESSO = clGreen;
  COR_FALHA = clRed;
  
  // Carteirinhas padrao por operadora (homologacao)
  CARTEIRINHAS_PADRAO: array[0..11] of string = (
    '1234567890123456',    // Epharma
    '9876543210123456',    // Funcional Card
    '1111222233334444',    // Orizon
    '5555666677778888',    // Vidalink
    '12345678901234567',   // Farmacia Popular (NIS 17 digitos)
    '0000111122223333',    // Pharmalink
    '4444555566667777',    // TRN Centre
    '8888999900001111',    // PEC Febrafar
    '',                    // LinkedFarma (usa CPF)
    '',                    // Ellomais (usa CPF)
    '',                    // Nosso Clube (usa CPF)
    ''                     // Object Pro (usa CPF)
  );

{ TfrmPBM_Test }

function TfrmPBM_Test.StrToDateSafe(const S: string; ADefault: TDateTime): TDateTime;
begin
  try
    Result := StrToDate(S);
  except
    Result := ADefault;
  end;
end;

procedure TfrmPBM_Test.FormCreate(Sender: TObject);
begin
  FConnection := TFDConnection.Create(Self);
  FConnection.DriverName := 'MySQL';
  
  FOperadoraSelecionada := -1;
  
  InicializarOperadoras;
  ConfigurarGrid;
  ConfigurarPopupMenu;
  
  // Valores padrao de conexao
  edtServer.Text := 'localhost';
  edtDatabase.Text := 'dbaione';
  edtUser.Text := 'root';
  edtPassword.Text := 'f68interdb';
  
  chkHomologacao.Checked := True;
  chkUsarDadosPadrao.Checked := True;
  
  // Desabilita botoes de cancelamento/consulta ate ter NSU
  btnIndivCancelamento.Enabled := False;
  btnIndivConsulta.Enabled := False;
  btnTestarCancelamento.Enabled := False;
  btnTestarConsulta.Enabled := False;
end;

procedure TfrmPBM_Test.FormDestroy(Sender: TObject);
begin
  if Assigned(FConnection) then
    FConnection.Connected := False;
end;

procedure TfrmPBM_Test.FormShow(Sender: TObject);
begin
  AtualizarListaOperadoras;
  CarregarDadosPadrao;
  CarregarProdutosPadrao;
  
  if lvOperadoras.Items.Count > 0 then
  begin
    lvOperadoras.Items[0].Selected := True;
    lvOperadoras.Items[0].Focused := True;
  end;
end;

procedure TfrmPBM_Test.InicializarOperadoras;
var
  I: Integer;
begin
  SetLength(FOperadoras, 12);
  
  // Corporativos
  FOperadoras[0].Tipo := ptEpharma;
  FOperadoras[0].Codigo := 'EPHARMA';
  FOperadoras[0].Nome := 'Epharma';
  
  FOperadoras[1].Tipo := ptFuncionalCard;
  FOperadoras[1].Codigo := 'FUNCIONALCARD';
  FOperadoras[1].Nome := 'Funcional Card';
  
  FOperadoras[2].Tipo := ptOrizon;
  FOperadoras[2].Codigo := 'ORIZON';
  FOperadoras[2].Nome := 'Orizon';
  
  FOperadoras[3].Tipo := ptVidalink;
  FOperadoras[3].Codigo := 'VIDALINK';
  FOperadoras[3].Nome := 'Vidalink';
  
  // Governo
  FOperadoras[4].Tipo := ptFarmaciaPopular;
  FOperadoras[4].Codigo := 'FARMACIAPOPULAR';
  FOperadoras[4].Nome := 'Farmacia Popular';
  
  // Industria
  FOperadoras[5].Tipo := ptPharmalink;
  FOperadoras[5].Codigo := 'PHARMALINK';
  FOperadoras[5].Nome := 'Pharmalink';
  
  // Comerciais
  FOperadoras[6].Tipo := ptTRNCentre;
  FOperadoras[6].Codigo := 'TRNCENTRE';
  FOperadoras[6].Nome := 'TRN Centre';
  
  // Associativos
  FOperadoras[7].Tipo := ptPECFebrafar;
  FOperadoras[7].Codigo := 'PECFEBRAFAR';
  FOperadoras[7].Nome := 'PEC Febrafar';
  
  // Fidelizacao
  FOperadoras[8].Tipo := ptLinkedfarma;
  FOperadoras[8].Codigo := 'LINKEDFARMA';
  FOperadoras[8].Nome := 'LinkedFarma';
  
  FOperadoras[9].Tipo := ptEllomais;
  FOperadoras[9].Codigo := 'ELLOMAIS';
  FOperadoras[9].Nome := 'Ello+ / Facillite';
  
  FOperadoras[10].Tipo := ptNossoClube;
  FOperadoras[10].Codigo := 'NOSSOCLUBE';
  FOperadoras[10].Nome := 'Nosso Clube';
  
  FOperadoras[11].Tipo := ptObjectPro;
  FOperadoras[11].Codigo := 'OBJECTPRO';
  FOperadoras[11].Nome := 'Object Pro';
  
  // Inicializa status
  for I := 0 to High(FOperadoras) do
  begin
    FOperadoras[I].Status := tsNaoTestado;
    FOperadoras[I].UltimoTeste := 0;
    FOperadoras[I].UltimaMensagem := '';
    FOperadoras[I].TempoMS := 0;
    FOperadoras[I].UltimoNSU := '';
    FOperadoras[I].UltimoCodAuth := '';
  end;
end;

procedure TfrmPBM_Test.AtualizarListaOperadoras;
var
  I: Integer;
  LItem: TListItem;
  LCategoria: string;
begin
  lvOperadoras.Items.BeginUpdate;
  try
    lvOperadoras.Items.Clear;
    
    for I := 0 to High(FOperadoras) do
    begin
      LItem := lvOperadoras.Items.Add;
      LItem.Caption := FOperadoras[I].Nome;
      LItem.Data := Pointer(I);
      
      // Categoria
      case FOperadoras[I].Tipo of
        ptEpharma, ptFuncionalCard, ptOrizon, ptVidalink:
          LCategoria := 'PBM Corporativo';
        ptFarmaciaPopular:
          LCategoria := 'Governo';
        ptPharmalink:
          LCategoria := 'Industria';
        ptTRNCentre:
          LCategoria := 'Comercial';
        ptPECFebrafar:
          LCategoria := 'Associativo';
        ptLinkedfarma, ptEllomais, ptNossoClube, ptObjectPro:
          LCategoria := 'Fidelizacao';
        else
          LCategoria := 'Outro';
      end;
      
      // SubItems: Categoria, Status, Tempo, Ultima Msg
      LItem.SubItems.Add(LCategoria);
      LItem.SubItems.Add('Nao testado');
      LItem.SubItems.Add('-');
      LItem.SubItems.Add('');
    end;
  finally
    lvOperadoras.Items.EndUpdate;
  end;
end;

procedure TfrmPBM_Test.ConfigurarGrid;
begin
  sgProdutos.ColCount := 5;
  sgProdutos.RowCount := 2;
  sgProdutos.FixedRows := 1;
  
  sgProdutos.Cells[0, 0] := 'EAN';
  sgProdutos.Cells[1, 0] := 'Descricao';
  sgProdutos.Cells[2, 0] := 'Qtd';
  sgProdutos.Cells[3, 0] := 'Preco Unit.';
  sgProdutos.Cells[4, 0] := 'Total';
  
  sgProdutos.ColWidths[0] := 120;
  sgProdutos.ColWidths[1] := 200;
  sgProdutos.ColWidths[2] := 50;
  sgProdutos.ColWidths[3] := 80;
  sgProdutos.ColWidths[4] := 80;
end;

procedure TfrmPBM_Test.ConfigurarPopupMenu;
begin
  // Cria o PopupMenu programaticamente
  if FpmOperadora = nil then
  begin
    FpmOperadora := TPopupMenu.Create(Self);
    
    FmnuTestarElegibilidade := TMenuItem.Create(FpmOperadora);
    FmnuTestarElegibilidade.Caption := 'Testar &Elegibilidade (F2)';
    FmnuTestarElegibilidade.ShortCut := VK_F2;
    FmnuTestarElegibilidade.OnClick := mnuTestarElegibilidadeClick;
    FpmOperadora.Items.Add(FmnuTestarElegibilidade);
    
    FmnuTestarAutorizacao := TMenuItem.Create(FpmOperadora);
    FmnuTestarAutorizacao.Caption := 'Testar &Autorizacao (F3)';
    FmnuTestarAutorizacao.ShortCut := VK_F3;
    FmnuTestarAutorizacao.OnClick := mnuTestarAutorizacaoClick;
    FpmOperadora.Items.Add(FmnuTestarAutorizacao);
    
    FmnuTestarCancelamento := TMenuItem.Create(FpmOperadora);
    FmnuTestarCancelamento.Caption := 'Testar &Cancelamento (F4)';
    FmnuTestarCancelamento.ShortCut := VK_F4;
    FmnuTestarCancelamento.OnClick := mnuTestarCancelamentoClick;
    FpmOperadora.Items.Add(FmnuTestarCancelamento);
    
    FmnuTestarConsulta := TMenuItem.Create(FpmOperadora);
    FmnuTestarConsulta.Caption := 'Testar C&onsulta (F5)';
    FmnuTestarConsulta.ShortCut := VK_F5;
    FmnuTestarConsulta.OnClick := mnuTestarConsultaClick;
    FpmOperadora.Items.Add(FmnuTestarConsulta);
    
    FmnuSep1 := TMenuItem.Create(FpmOperadora);
    FmnuSep1.Caption := '-';
    FpmOperadora.Items.Add(FmnuSep1);
    
    FmnuTestarFluxoCompleto := TMenuItem.Create(FpmOperadora);
    FmnuTestarFluxoCompleto.Caption := 'Testar &Fluxo Completo (F6)';
    FmnuTestarFluxoCompleto.ShortCut := VK_F6;
    FmnuTestarFluxoCompleto.OnClick := mnuTestarFluxoCompletoClick;
    FpmOperadora.Items.Add(FmnuTestarFluxoCompleto);
    
    lvOperadoras.PopupMenu := FpmOperadora;
  end;
end;

procedure TfrmPBM_Test.CarregarDadosPadrao;
begin
  edtCPF.Text := CPF_TESTE;
  edtDataNasc.Text := DATA_NASC_TESTE;
  edtCarteirinha.Text := CARTEIRINHAS_PADRAO[0]; // Epharma por padrao
end;

procedure TfrmPBM_Test.CarregarDadosPadraoOperadora(ATipo: TPBMType);
var
  LIdx: Integer;
begin
  LIdx := GetOperadoraIndex(ATipo);
  if (LIdx >= 0) and (LIdx <= High(CARTEIRINHAS_PADRAO)) then
  begin
    if CARTEIRINHAS_PADRAO[LIdx] <> '' then
      edtCarteirinha.Text := CARTEIRINHAS_PADRAO[LIdx]
    else
      edtCarteirinha.Text := ''; // Operadoras que usam so CPF
  end;
end;

procedure TfrmPBM_Test.CarregarProdutosPadrao;
begin
  sgProdutos.RowCount := 4;
  
  // Produto 1 - Medicamento referencia
  sgProdutos.Cells[0, 1] := '7891234567890';
  sgProdutos.Cells[1, 1] := 'DIPIRONA 500MG C/10';
  sgProdutos.Cells[2, 1] := '1';
  sgProdutos.Cells[3, 1] := '15.90';
  sgProdutos.Cells[4, 1] := '15.90';
  
  // Produto 2 - Medicamento generico
  sgProdutos.Cells[0, 2] := '7899876543210';
  sgProdutos.Cells[1, 2] := 'LOSARTANA 50MG C/30';
  sgProdutos.Cells[2, 2] := '2';
  sgProdutos.Cells[3, 2] := '28.50';
  sgProdutos.Cells[4, 2] := '57.00';
  
  // Produto 3 - Medicamento similar
  sgProdutos.Cells[0, 3] := '7891111222333';
  sgProdutos.Cells[1, 3] := 'OMEPRAZOL 20MG C/28';
  sgProdutos.Cells[2, 3] := '1';
  sgProdutos.Cells[3, 3] := '42.90';
  sgProdutos.Cells[4, 3] := '42.90';
end;

procedure TfrmPBM_Test.Log(const AMsg: string; ACor: TColor);
begin
  mmoLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + ' | ' + AMsg);
  // Scroll para o final
  SendMessage(mmoLog.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TfrmPBM_Test.LogSeparador;
begin
  mmoLog.Lines.Add(StringOfChar('-', 60));
end;

procedure TfrmPBM_Test.SetStatus(const AOperadora, AStatus: string; ACor: TColor);
begin
  lblStatusOperadora.Caption := AOperadora + ': ' + AStatus;
  lblStatusOperadora.Font.Color := ACor;
  Application.ProcessMessages;
end;

function TfrmPBM_Test.GetOperadoraSelecionada: TOperadoraTestInfo;
begin
  if (FOperadoraSelecionada >= 0) and (FOperadoraSelecionada <= High(FOperadoras)) then
    Result := FOperadoras[FOperadoraSelecionada]
  else
    FillChar(Result, SizeOf(Result), 0);
end;

function TfrmPBM_Test.GetOperadoraIndex(ATipo: TPBMType): Integer;
begin
  for Result := 0 to High(FOperadoras) do
    if FOperadoras[Result].Tipo = ATipo then
      Exit;
  Result := -1;
end;

function TfrmPBM_Test.GetProdutosTeste: TArray<TPBMProduto>;
var
  I, LCount: Integer;
begin
  LCount := 0;
  for I := 1 to sgProdutos.RowCount - 1 do
    if Trim(sgProdutos.Cells[0, I]) <> '' then
      Inc(LCount);
  
  SetLength(Result, LCount);
  LCount := 0;
  
  for I := 1 to sgProdutos.RowCount - 1 do
  begin
    if Trim(sgProdutos.Cells[0, I]) <> '' then
    begin
      Result[LCount].EAN := Trim(sgProdutos.Cells[0, I]);
      Result[LCount].Descricao := Trim(sgProdutos.Cells[1, I]);
      Result[LCount].Quantidade := StrToFloatDef(sgProdutos.Cells[2, I], 1);
      Result[LCount].PrecoUnitario := StrToCurrDef(sgProdutos.Cells[3, I], 0);
      Result[LCount].PrecoTotal := StrToCurrDef(sgProdutos.Cells[4, I], 0);
      Inc(LCount);
    end;
  end;
end;

function TfrmPBM_Test.CriarClient(ATipo: TPBMType): IPBMClient;
begin
  // Credenciais de homologacao (ajustar conforme necessario)
  Result := TPBMFactory.CreateClient(
    ATipo,
    'CLIENT_ID_TESTE',
    'CLIENT_SECRET_TESTE',
    '12345678',  // Codigo estabelecimento
    chkHomologacao.Checked
  );
  
  if Result = nil then
    Log('ERRO: Nao foi possivel criar client para ' + TPBMFactory.TipoToNome(ATipo), clRed);
end;

procedure TfrmPBM_Test.AtualizarStatusOperadora(AIndex: Integer; AStatus: TTestStatus;
  const AMensagem: string; ATempoMS: Integer);
var
  LStatusStr: string;
begin
  if (AIndex < 0) or (AIndex > High(FOperadoras)) then Exit;
  
  FOperadoras[AIndex].Status := AStatus;
  FOperadoras[AIndex].UltimoTeste := Now;
  FOperadoras[AIndex].UltimaMensagem := AMensagem;
  FOperadoras[AIndex].TempoMS := ATempoMS;
  
  // Atualiza ListView
  if (AIndex < lvOperadoras.Items.Count) then
  begin
    case AStatus of
      tsNaoTestado: LStatusStr := 'Nao testado';
      tsTestando: LStatusStr := 'Testando...';
      tsSucesso: LStatusStr := 'OK Sucesso';
      tsFalha: LStatusStr := 'X Falha';
    end;
    
    lvOperadoras.Items[AIndex].SubItems[1] := LStatusStr;
    lvOperadoras.Items[AIndex].SubItems[2] := iif(ATempoMS > 0, IntToStr(ATempoMS) + 'ms', '-');
    lvOperadoras.Items[AIndex].SubItems[3] := Copy(AMensagem, 1, 50);
  end;
  
  AtualizarBotoesIndividuais;
end;

procedure TfrmPBM_Test.AtualizarBotoesIndividuais;
var
  LTemNSU: Boolean;
begin
  if (FOperadoraSelecionada >= 0) and (FOperadoraSelecionada <= High(FOperadoras)) then
  begin
    LTemNSU := FOperadoras[FOperadoraSelecionada].UltimoNSU <> '';
    
    btnIndivCancelamento.Enabled := LTemNSU;
    btnIndivConsulta.Enabled := LTemNSU;
    btnTestarCancelamento.Enabled := LTemNSU;
    btnTestarConsulta.Enabled := LTemNSU;
    
    // Atualiza campos de resultado
    edtNSU.Text := FOperadoras[FOperadoraSelecionada].UltimoNSU;
    edtCodAutorizacao.Text := FOperadoras[FOperadoraSelecionada].UltimoCodAuth;
    
    // Atualiza menu popup
    if Assigned(FmnuTestarCancelamento) then
      FmnuTestarCancelamento.Enabled := LTemNSU;
    if Assigned(FmnuTestarConsulta) then
      FmnuTestarConsulta.Enabled := LTemNSU;
  end
  else
  begin
    btnIndivCancelamento.Enabled := False;
    btnIndivConsulta.Enabled := False;
    btnTestarCancelamento.Enabled := False;
    btnTestarConsulta.Enabled := False;
  end;
end;

procedure TfrmPBM_Test.HabilitarControles(AHabilitar: Boolean);
begin
  lvOperadoras.Enabled := AHabilitar;
  gbxBeneficiario.Enabled := AHabilitar;
  gbxProdutos.Enabled := AHabilitar;
  gbxAcoes.Enabled := AHabilitar;
  btnTestarTodas.Enabled := AHabilitar;
  btnTestarSelecionada.Enabled := AHabilitar;
  pnlTestesIndividuais.Enabled := AHabilitar;
end;

// === EVENTOS DE INTERFACE ===

procedure TfrmPBM_Test.btnConectarClick(Sender: TObject);
begin
  try
    FConnection.Connected := False;
    FConnection.Params.Clear;
    FConnection.Params.Values['Port'] := '3307';
    FConnection.Params.Values['Server'] := edtServer.Text;
    FConnection.Params.Values['Database'] := edtDatabase.Text;
    FConnection.Params.Values['User_Name'] := edtUser.Text;
    FConnection.Params.Values['Password'] := edtPassword.Text;
    FConnection.DriverName := 'MySQL';
    FConnection.Connected  := True;

    shpConexao.Brush.Color := clLime;
    Log('Conectado ao banco de dados', clGreen);
    
    // Cria persistence
    FPersistence := TPBMPersistence.Create(FConnection);
    
  except
    on E: Exception do
    begin
      shpConexao.Brush.Color := clRed;
      Log('ERRO conexao: ' + E.Message, clRed);
    end;
  end;
end;

procedure TfrmPBM_Test.lvOperadorasSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected and Assigned(Item) then
  begin
    FOperadoraSelecionada := Integer(Item.Data);
    lblTesteIndividual.Caption := 'Testar: ' + FOperadoras[FOperadoraSelecionada].Nome;
    
    // Carrega dados padrao para a operadora selecionada
    if chkUsarDadosPadrao.Checked then
      CarregarDadosPadraoOperadora(FOperadoras[FOperadoraSelecionada].Tipo);
    
    AtualizarBotoesIndividuais;
  end;
end;

procedure TfrmPBM_Test.lvOperadorasDblClick(Sender: TObject);
begin
  // Duplo clique executa elegibilidade
  if FOperadoraSelecionada >= 0 then
    ExecutarTesteElegibilidade(FOperadoras[FOperadoraSelecionada].Tipo);
end;

procedure TfrmPBM_Test.chkUsarDadosPadraoClick(Sender: TObject);
begin
  if chkUsarDadosPadrao.Checked then
  begin
    CarregarDadosPadrao;
    if FOperadoraSelecionada >= 0 then
      CarregarDadosPadraoOperadora(FOperadoras[FOperadoraSelecionada].Tipo);
  end;
end;

procedure TfrmPBM_Test.btnProdutosPadraoClick(Sender: TObject);
begin
  CarregarProdutosPadrao;
end;

procedure TfrmPBM_Test.btnAddProdutoClick(Sender: TObject);
begin
  sgProdutos.RowCount := sgProdutos.RowCount + 1;
end;

procedure TfrmPBM_Test.btnRemProdutoClick(Sender: TObject);
begin
  if sgProdutos.RowCount > 2 then
    sgProdutos.RowCount := sgProdutos.RowCount - 1;
end;

procedure TfrmPBM_Test.btnLimparLogClick(Sender: TObject);
begin
  mmoLog.Clear;
end;

// === BOTOES DE ACAO PRINCIPAL ===

procedure TfrmPBM_Test.btnTestarElegibilidadeClick(Sender: TObject);
begin
  if FOperadoraSelecionada >= 0 then
    ExecutarTesteElegibilidade(FOperadoras[FOperadoraSelecionada].Tipo);
end;

procedure TfrmPBM_Test.btnTestarAutorizacaoClick(Sender: TObject);
begin
  if FOperadoraSelecionada >= 0 then
    ExecutarTesteAutorizacao(FOperadoras[FOperadoraSelecionada].Tipo);
end;

procedure TfrmPBM_Test.btnTestarCancelamentoClick(Sender: TObject);
begin
  if FOperadoraSelecionada >= 0 then
    ExecutarTesteCancelamento(FOperadoras[FOperadoraSelecionada].Tipo);
end;

procedure TfrmPBM_Test.btnTestarConsultaClick(Sender: TObject);
begin
  if FOperadoraSelecionada >= 0 then
    ExecutarTesteConsulta(FOperadoras[FOperadoraSelecionada].Tipo);
end;

// === BOTOES DE TESTE INDIVIDUAL (SpeedButtons) ===

procedure TfrmPBM_Test.btnIndivElegibilidadeClick(Sender: TObject);
begin
  btnTestarElegibilidadeClick(Sender);
end;

procedure TfrmPBM_Test.btnIndivAutorizacaoClick(Sender: TObject);
begin
  btnTestarAutorizacaoClick(Sender);
end;

procedure TfrmPBM_Test.btnIndivCancelamentoClick(Sender: TObject);
begin
  btnTestarCancelamentoClick(Sender);
end;

procedure TfrmPBM_Test.btnIndivConsultaClick(Sender: TObject);
begin
  btnTestarConsultaClick(Sender);
end;

// === POPUP MENU ===

procedure TfrmPBM_Test.mnuTestarElegibilidadeClick(Sender: TObject);
begin
  btnTestarElegibilidadeClick(Sender);
end;

procedure TfrmPBM_Test.mnuTestarAutorizacaoClick(Sender: TObject);
begin
  btnTestarAutorizacaoClick(Sender);
end;

procedure TfrmPBM_Test.mnuTestarCancelamentoClick(Sender: TObject);
begin
  btnTestarCancelamentoClick(Sender);
end;

procedure TfrmPBM_Test.mnuTestarConsultaClick(Sender: TObject);
begin
  btnTestarConsultaClick(Sender);
end;

procedure TfrmPBM_Test.mnuTestarFluxoCompletoClick(Sender: TObject);
begin
  if FOperadoraSelecionada >= 0 then
    ExecutarFluxoCompleto(FOperadoras[FOperadoraSelecionada].Tipo);
end;

// === TESTAR TODAS / SELECIONADA ===

procedure TfrmPBM_Test.btnTestarSelecionadaClick(Sender: TObject);
begin
  if FOperadoraSelecionada >= 0 then
    ExecutarFluxoCompleto(FOperadoras[FOperadoraSelecionada].Tipo);
end;

procedure TfrmPBM_Test.btnTestarTodasClick(Sender: TObject);
var
  I: Integer;
begin
  HabilitarControles(False);
  try
    pbProgress.Max := Length(FOperadoras);
    pbProgress.Position := 0;
    
    LogSeparador;
    Log('INICIANDO TESTE DE TODAS AS OPERADORAS', clBlue);
    LogSeparador;
    
    for I := 0 to High(FOperadoras) do
    begin
      pbProgress.Position := I + 1;
      Application.ProcessMessages;
      
      // Carrega dados padrao da operadora
      if chkUsarDadosPadrao.Checked then
        CarregarDadosPadraoOperadora(FOperadoras[I].Tipo);
      
      // Executa apenas elegibilidade para teste em lote
      ExecutarTesteElegibilidade(FOperadoras[I].Tipo);
      
      Application.ProcessMessages;
      Sleep(500); // Pequena pausa entre operadoras
    end;
    
    LogSeparador;
    Log('TESTE DE TODAS AS OPERADORAS CONCLUIDO', clBlue);
    LogSeparador;
    
  finally
    HabilitarControles(True);
    pbProgress.Position := 0;
  end;
end;

// === EXECUCAO DOS TESTES ===

procedure TfrmPBM_Test.ExecutarFluxoCompleto(ATipo: TPBMType);
begin
  Log('', clBlack);
  LogSeparador;
  Log('FLUXO COMPLETO: ' + TPBMFactory.TipoToNome(ATipo), clBlue);
  LogSeparador;
  
  // 1. Elegibilidade
  ExecutarTesteElegibilidade(ATipo);
  Application.ProcessMessages;
  
  // 2. Autorizacao
  ExecutarTesteAutorizacao(ATipo);
  Application.ProcessMessages;
  
  // 3. Consulta (se teve autorizacao)
  if FOperadoras[GetOperadoraIndex(ATipo)].UltimoNSU <> '' then
  begin
    ExecutarTesteConsulta(ATipo);
    Application.ProcessMessages;
    
    // 4. Cancelamento
    if MessageDlg('Deseja cancelar a transacao NSU ' + 
       FOperadoras[GetOperadoraIndex(ATipo)].UltimoNSU + '?', 
       mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ExecutarTesteCancelamento(ATipo);
    end;
  end;
  
  LogSeparador;
  Log('FLUXO COMPLETO FINALIZADO', clBlue);
  LogSeparador;
end;

procedure TfrmPBM_Test.ExecutarTesteElegibilidade(ATipo: TPBMType);
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LStart: TDateTime;
  LTempoMS: Integer;
  LNome: string;
  LIdx: Integer;
begin
  LNome := TPBMFactory.TipoToNome(ATipo);
  LIdx := GetOperadoraIndex(ATipo);
  
  LogSeparador;
  Log('[' + LNome + '] Testando ELEGIBILIDADE...', clBlue);
  SetStatus(LNome, 'Testando elegibilidade...', clYellow);
  AtualizarStatusOperadora(LIdx, tsTestando, '', 0);
  Application.ProcessMessages;
  
  LClient := CriarClient(ATipo);
  if LClient = nil then
  begin
    AtualizarStatusOperadora(LIdx, tsFalha, 'Client nao criado', 0);
    Exit;
  end;
  
  LStart := Now;
  LTempoMS := 0;
  try
    LEleg := LClient.ConsultarElegibilidade(
      Trim(edtCarteirinha.Text),
      Trim(edtCPF.Text),
      StrToDateSafe(edtDataNasc.Text, EncodeDate(1980, 1, 1))
    );
    
    LTempoMS := MilliSecondsBetween(Now, LStart);
    
    if LEleg.Sucesso then
    begin
      Log('[' + LNome + '] OK Elegibilidade OK - ' + LEleg.NomeBeneficiario, clGreen);
      Log('  Plano: ' + LEleg.Plano, clGreen);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      
      if LEleg.SaldoPontos > 0 then
      begin
        Log('  Saldo Pontos: ' + IntToStr(LEleg.SaldoPontos), clGreen);
        edtPontos.Text := IntToStr(LEleg.SaldoPontos);
      end;
      
      AtualizarStatusOperadora(LIdx, tsSucesso, LEleg.Mensagem, LTempoMS);
      SetStatus(LNome, 'Elegivel', clGreen);
    end
    else
    begin
      Log('[' + LNome + '] X Nao elegivel: ' + LEleg.Mensagem, clRed);
      if LEleg.CodigoErro <> '' then
        Log('  Codigo: ' + LEleg.CodigoErro, clRed);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      
      AtualizarStatusOperadora(LIdx, tsFalha, LEleg.Mensagem, LTempoMS);
      SetStatus(LNome, 'Nao elegivel', clRed);
    end;
    
  except
    on E: Exception do
    begin
      LTempoMS := MilliSecondsBetween(Now, LStart);
      Log('[' + LNome + '] X ERRO: ' + E.Message, clRed);
      AtualizarStatusOperadora(LIdx, tsFalha, E.Message, LTempoMS);
      SetStatus(LNome, 'ERRO', clRed);
    end;
  end;
  
  lblStatusTempo.Caption := IntToStr(LTempoMS) + 'ms';
end;

procedure TfrmPBM_Test.ExecutarTesteAutorizacao(ATipo: TPBMType);
var
  LClient: IPBMClient;
  LAuth: IPBMAutorizacao;
  LProdutos: TArray<TPBMProduto>;
  LStart: TDateTime;
  LTempoMS: Integer;
  LNome: string;
  LIdx: Integer;
  LValorTotal: Currency;
  I: Integer;
begin
  LNome := TPBMFactory.TipoToNome(ATipo);
  LIdx := GetOperadoraIndex(ATipo);
  
  LogSeparador;
  Log('[' + LNome + '] Testando AUTORIZACAO...', clBlue);
  SetStatus(LNome, 'Testando autorizacao...', clYellow);
  AtualizarStatusOperadora(LIdx, tsTestando, '', 0);
  Application.ProcessMessages;
  
  LClient := CriarClient(ATipo);
  if LClient = nil then
  begin
    AtualizarStatusOperadora(LIdx, tsFalha, 'Client nao criado', 0);
    Exit;
  end;
  
  LProdutos := GetProdutosTeste;
  if Length(LProdutos) = 0 then
  begin
    Log('[' + LNome + '] X Nenhum produto para autorizar', clRed);
    Exit;
  end;
  
  // Calcula total
  LValorTotal := 0;
  for I := 0 to High(LProdutos) do
    LValorTotal := LValorTotal + LProdutos[I].PrecoTotal;
  
  LStart := Now;
  LTempoMS := 0;
  try
    LAuth := LClient.AutorizarVenda(
      Trim(edtCarteirinha.Text),
      Trim(edtCPF.Text),
      StrToDateSafe(edtDataNasc.Text, EncodeDate(1980, 1, 1)),
      LProdutos,
      LValorTotal,
      'TEST_' + FormatDateTime('yyyymmddhhnnsszzz', Now)
    );
    
    LTempoMS := MilliSecondsBetween(Now, LStart);
    
    if LAuth.Sucesso then
    begin
      // Guarda NSU e Codigo para cancelamento/consulta
      FOperadoras[LIdx].UltimoNSU := LAuth.NSU;
      FOperadoras[LIdx].UltimoCodAuth := LAuth.CodigoAutorizacao;
      
      Log('[' + LNome + '] OK AUTORIZADO', clGreen);
      Log('  NSU: ' + LAuth.NSU, clGreen);
      Log('  Codigo: ' + LAuth.CodigoAutorizacao, clGreen);
      Log('  Desconto: R$ ' + FormatFloat('#,##0.00', LAuth.ValorDesconto), clGreen);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      
      // Atualiza campos de resultado
      edtNSU.Text := LAuth.NSU;
      edtCodAutorizacao.Text := LAuth.CodigoAutorizacao;
      edtValorDesconto.Text := FormatFloat('#,##0.00', LAuth.ValorDesconto);
      
      if LAuth.SaldoPontos > 0 then
        edtPontos.Text := IntToStr(LAuth.SaldoPontos);
      
      AtualizarStatusOperadora(LIdx, tsSucesso, 'NSU: ' + LAuth.NSU, LTempoMS);
      SetStatus(LNome, 'AUTORIZADO - NSU: ' + LAuth.NSU, clGreen);
    end
    else
    begin
      Log('[' + LNome + '] X NAO AUTORIZADO: ' + LAuth.Mensagem, clRed);
      if LAuth.CodigoErro <> '' then
        Log('  Codigo Erro: ' + LAuth.CodigoErro, clRed);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      
      AtualizarStatusOperadora(LIdx, tsFalha, LAuth.Mensagem, LTempoMS);
      SetStatus(LNome, 'NAO AUTORIZADO', clRed);
    end;
    
  except
    on E: Exception do
    begin
      LTempoMS := MilliSecondsBetween(Now, LStart);
      Log('[' + LNome + '] X ERRO: ' + E.Message, clRed);
      AtualizarStatusOperadora(LIdx, tsFalha, E.Message, LTempoMS);
      SetStatus(LNome, 'ERRO', clRed);
    end;
  end;
  
  lblStatusTempo.Caption := IntToStr(LTempoMS) + 'ms';
  AtualizarBotoesIndividuais;
end;

procedure TfrmPBM_Test.ExecutarTesteCancelamento(ATipo: TPBMType);
var
  LClient: IPBMClient;
  LCancel: IPBMCancelamento;
  LStart: TDateTime;
  LTempoMS: Integer;
  LNome: string;
  LIdx: Integer;
  LNSU, LCodAuth: string;
begin
  LNome := TPBMFactory.TipoToNome(ATipo);
  LIdx := GetOperadoraIndex(ATipo);
  
  LNSU := FOperadoras[LIdx].UltimoNSU;
  LCodAuth := FOperadoras[LIdx].UltimoCodAuth;
  
  if LNSU = '' then
  begin
    Log('[' + LNome + '] X Nenhum NSU para cancelar', clRed);
    Exit;
  end;
  
  LogSeparador;
  Log('[' + LNome + '] Testando CANCELAMENTO - NSU: ' + LNSU, clBlue);
  SetStatus(LNome, 'Cancelando...', clYellow);
  Application.ProcessMessages;
  
  LClient := CriarClient(ATipo);
  if LClient = nil then
    Exit;
  
  LStart := Now;
  LTempoMS := 0;
  try
    LCancel := LClient.CancelarVenda(LNSU, LCodAuth, 'Teste de cancelamento');
    
    LTempoMS := MilliSecondsBetween(Now, LStart);
    
    if LCancel.Sucesso then
    begin
      Log('[' + LNome + '] OK CANCELAMENTO CONFIRMADO', clGreen);
      Log('  Protocolo: ' + LCancel.ProtocoloCancelamento, clGreen);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      
      SetStatus(LNome, 'Cancelado', clGreen);
      
      // Limpa NSU
      FOperadoras[LIdx].UltimoNSU := '';
      FOperadoras[LIdx].UltimoCodAuth := '';
      edtNSU.Clear;
      edtCodAutorizacao.Clear;
    end
    else
    begin
      Log('[' + LNome + '] X CANCELAMENTO NEGADO: ' + LCancel.Mensagem, clRed);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      SetStatus(LNome, 'Cancelamento negado', clRed);
    end;
    
  except
    on E: Exception do
    begin
      LTempoMS := MilliSecondsBetween(Now, LStart);
      Log('[' + LNome + '] X ERRO: ' + E.Message, clRed);
      SetStatus(LNome, 'ERRO', clRed);
    end;
  end;
  
  lblStatusTempo.Caption := IntToStr(LTempoMS) + 'ms';
  AtualizarBotoesIndividuais;
end;

procedure TfrmPBM_Test.ExecutarTesteConsulta(ATipo: TPBMType);
var
  LClient: IPBMClient;
  LConsulta: IPBMConsultaTransacao;
  LStart: TDateTime;
  LTempoMS: Integer;
  LNome: string;
  LIdx: Integer;
  LNSU: string;
begin
  LNome := TPBMFactory.TipoToNome(ATipo);
  LIdx := GetOperadoraIndex(ATipo);
  
  LNSU := FOperadoras[LIdx].UltimoNSU;
  
  if LNSU = '' then
  begin
    Log('[' + LNome + '] X Nenhum NSU para consultar', clRed);
    Exit;
  end;
  
  LogSeparador;
  Log('[' + LNome + '] Testando CONSULTA - NSU: ' + LNSU, clBlue);
  SetStatus(LNome, 'Consultando...', clYellow);
  Application.ProcessMessages;
  
  LClient := CriarClient(ATipo);
  if LClient = nil then
    Exit;
  
  LStart := Now;
  LTempoMS := 0;
  try
    LConsulta := LClient.ConsultarTransacao(LNSU);
    
    LTempoMS := MilliSecondsBetween(Now, LStart);
    
    if LConsulta.Sucesso then
    begin
      Log('[' + LNome + '] OK CONSULTA OK', clGreen);
      Log('  Status: ' + LConsulta.Status, clGreen);
      Log('  Valor Bruto: R$ ' + FormatFloat('#,##0.00', LConsulta.ValorBruto), clGreen);
      Log('  Desconto: R$ ' + FormatFloat('#,##0.00', LConsulta.ValorDesconto), clGreen);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      
      SetStatus(LNome, 'Status: ' + LConsulta.Status, clGreen);
    end
    else
    begin
      Log('[' + LNome + '] X CONSULTA FALHOU: ' + LConsulta.Mensagem, clRed);
      Log('  Tempo: ' + IntToStr(LTempoMS) + 'ms', clGray);
      SetStatus(LNome, 'Consulta falhou', clRed);
    end;
    
  except
    on E: Exception do
    begin
      LTempoMS := MilliSecondsBetween(Now, LStart);
      Log('[' + LNome + '] X ERRO: ' + E.Message, clRed);
      SetStatus(LNome, 'ERRO', clRed);
    end;
  end;
  
  lblStatusTempo.Caption := IntToStr(LTempoMS) + 'ms';
end;

end.
