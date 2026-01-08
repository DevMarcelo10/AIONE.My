unit uPBM.PDV;

{******************************************************************************
  PBM PDV - Interface Visual Unificada
  
  Form para integração de vendas com PBMs no PDV.
  Suporta todas as operadoras através da interface IPBMClient.
  
  Autor: AIONE.My
  Data: Dezembro/2024
******************************************************************************}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Generics.Collections, System.DateUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.Buttons, Data.DB,
  FireDAC.Comp.Client,
  MarcLib,  // iif() function
  uPBM.Interfaces, uPBM.Persistence, uPBM.Factory;

type
  // Evento para retornar autorização ao PDV principal
  TPBMAutorizadoEvent = procedure(Sender: TObject; 
    const AAutorizacao: RPBMAutorizacao) of object;
  
  // Status visual
  TPBMStatusVisual = (svAguardando, svProcessando, svSucesso, svErro);
  
  TfrmPBM_PDV = class(TForm)
    pnlTop: TPanel;
    pnlCenter: TPanel;
    pnlBottom: TPanel;
    pnlStatus: TPanel;
    
    // Seleção de operadora
    gbxOperadora: TGroupBox;
    cbbOperadora: TComboBox;
    lblOperadora: TLabel;
    chkHomologacao: TCheckBox;
    
    // Dados do beneficiário
    gbxBeneficiario: TGroupBox;
    lblCarteirinha: TLabel;
    edtCarteirinha: TEdit;
    lblCPF: TLabel;
    edtCPF: TEdit;
    lblDataNasc: TLabel;
    edtDataNasc: TMaskEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    btnConsultar: TBitBtn;
    
    // Produtos
    gbxProdutos: TGroupBox;
    sgProdutos: TStringGrid;
    lblValorBruto: TLabel;
    edtValorBruto: TEdit;
    lblValorDesconto: TLabel;
    edtValorDesconto: TEdit;
    lblValorLiquido: TLabel;
    edtValorLiquido: TEdit;
    
    // Resultado
    gbxResultado: TGroupBox;
    lblNSU: TLabel;
    edtNSU: TEdit;
    lblCodAutorizacao: TLabel;
    edtCodAutorizacao: TEdit;
    mmoMensagem: TMemo;
    
    // Rewards (para programas de fidelidade)
    gbxRewards: TGroupBox;
    lblPontosAtuais: TLabel;
    edtPontosAtuais: TEdit;
    lblPontosGanhos: TLabel;
    edtPontosGanhos: TEdit;
    
    // Ações
    btnAutorizar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    btnLimpar: TBitBtn;
    
    // Timer para timeout visual
    tmrProcessando: TTimer;
    
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    
    procedure cbbOperadoraChange(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnAutorizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    
    procedure tmrProcessandoTimer(Sender: TObject);
    
  private
    FConnection: TFDConnection;
    FPersistence: IPBMPersistence;
    FClients: TDictionary<string, IPBMClient>;
    FOperadoras: TArray<RPBMOperadora>;
    FClienteAtual: IPBMClient;
    FAutorizacaoAtual: RPBMAutorizacao;
    FProdutos: TArray<RPBMAutorizacaoItem>;
    FVendaID: Int64;
    FTransacaoID: string;
    
    FOnAutorizado: TPBMAutorizadoEvent;
    
    // UI Helpers
    procedure SetStatus(AStatus: TPBMStatusVisual; const AMensagem: string);
    procedure AtualizarTotais;
    procedure HabilitarControles(AHabilitar: Boolean);
    procedure ConfigurarGrid;
    procedure LimparFormulario;
    procedure CarregarOperadoras;
    
    // PBM Helpers
    function GetClienteAtual: IPBMClient;
    function GetOperadoraSelecionada: RPBMOperadora;
    function MontarProdutosRequest: TArray<TPBMProduto>;
    procedure ProcessarResultadoConsulta(const AElegibilidade: IPBMElegibilidade);
    procedure ProcessarResultadoAutorizacao(const AAutorizacao: IPBMAutorizacao);
    
  public
    /// <summary>Inicializa o form com conexão de banco</summary>
    procedure Inicializar(AConnection: TFDConnection);
    
    /// <summary>Define os produtos da venda</summary>
    procedure DefinirProdutos(const AProdutos: TArray<RPBMAutorizacaoItem>);
    
    /// <summary>Define ID da venda para vinculação</summary>
    procedure DefinirVenda(AVendaID: Int64; const ATransacaoID: string);
    
    /// <summary>Pré-seleciona uma operadora</summary>
    procedure SelecionarOperadora(const ACodigo: string);
    
    /// <summary>Pré-preenche dados do beneficiário</summary>
    procedure PreencherBeneficiario(const ACarteirinha, ACPF: string; ADataNasc: TDate);
    
    /// <summary>Retorna a última autorização realizada</summary>
    property AutorizacaoAtual: RPBMAutorizacao read FAutorizacaoAtual;
    
    /// <summary>Evento disparado quando autorização é concluída com sucesso</summary>
    property OnAutorizado: TPBMAutorizadoEvent read FOnAutorizado write FOnAutorizado;
  end;

var
  frmPBM_PDV: TfrmPBM_PDV;

implementation

{$R *.dfm}

{ TfrmPBM_PDV }

procedure TfrmPBM_PDV.FormCreate(Sender: TObject);
begin
  FClients := TDictionary<string, IPBMClient>.Create;
  FProdutos := [];
  FVendaID := 0;
  FTransacaoID := '';
  
  ConfigurarGrid;
end;

procedure TfrmPBM_PDV.FormDestroy(Sender: TObject);
begin
  FClients.Free;
end;

procedure TfrmPBM_PDV.FormShow(Sender: TObject);
begin
  if edtCarteirinha.CanFocus then
    edtCarteirinha.SetFocus;
end;

procedure TfrmPBM_PDV.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: btnFecharClick(nil);
    VK_F2: btnConsultarClick(nil);
    VK_F5: btnAutorizarClick(nil);
    VK_F6: btnCancelarClick(nil);
    VK_F12: btnLimparClick(nil);
  end;
end;

procedure TfrmPBM_PDV.Inicializar(AConnection: TFDConnection);
begin
  FConnection := AConnection;
  FPersistence := TPBMPersistence.Create(AConnection);
  CarregarOperadoras;
end;

procedure TfrmPBM_PDV.CarregarOperadoras;
var
  LOp: RPBMOperadora;
begin
  cbbOperadora.Items.Clear;
  FOperadoras := FPersistence.ListOperadoras(True);
  
  for LOp in FOperadoras do
    cbbOperadora.Items.AddObject(LOp.Nome, TObject(LOp.ID));
  
  if cbbOperadora.Items.Count > 0 then
    cbbOperadora.ItemIndex := 0;
    
  cbbOperadoraChange(nil);
end;

procedure TfrmPBM_PDV.cbbOperadoraChange(Sender: TObject);
var
  LOp: RPBMOperadora;
begin
  LOp := GetOperadoraSelecionada;
  
  // Mostra/esconde grupo de rewards para programas de fidelidade
  gbxRewards.Visible := (LOp.Tipo = otFidelidade);
  
  // Ajusta label de CPF/Carteirinha conforme operadora
  if LOp.Tipo = otGoverno then
  begin
    lblCarteirinha.Caption := 'NIS:';
    lblCPF.Visible := True;
    edtCPF.Visible := True;
  end
  else
  begin
    lblCarteirinha.Caption := 'Carteirinha:';
    lblCPF.Visible := True;
    edtCPF.Visible := True;
  end;
  
  FClienteAtual := nil; // Força recriação do client
end;

function TfrmPBM_PDV.GetOperadoraSelecionada: RPBMOperadora;
begin
  Result := Default(RPBMOperadora);
  if (cbbOperadora.ItemIndex >= 0) and (cbbOperadora.ItemIndex < Length(FOperadoras)) then
    Result := FOperadoras[cbbOperadora.ItemIndex];
end;

function TfrmPBM_PDV.GetClienteAtual: IPBMClient;
var
  LOp: RPBMOperadora;
  LKey: string;
  LTipo: TPBMType;
begin
  LOp := GetOperadoraSelecionada;
  if LOp.ID = 0 then
  begin
    Result := nil;
    Exit;
  end;
  
  LKey := LOp.Codigo + iif(chkHomologacao.Checked, '_HOM', '_PROD');
  
  if not FClients.TryGetValue(LKey, Result) then
  begin
    // Mapeia código para tipo
    if SameText(LOp.Codigo, 'EPHARMA') then
      LTipo := ptEpharma
    else if SameText(LOp.Codigo, 'FUNCIONALCARD') then
      LTipo := ptFuncionalCard
    else if SameText(LOp.Codigo, 'ORIZON') then
      LTipo := ptOrizon
    else if SameText(LOp.Codigo, 'FARMACIAPOPULAR') then
      LTipo := ptFarmaciaPopular
    else
      LTipo := ptEpharma; // Default
    
    // Cria client via Factory
    Result := TPBMFactory.CreateClient(
      LTipo,
      LOp.ClientID,
      LOp.ClientSecret,
      LOp.CodEstabelecimento,
      chkHomologacao.Checked
    );
    
    // Configura credenciais extras se necessário
    if (LOp.Usuario <> '') and Supports(Result, IPBMClientEx) then
      (Result as IPBMClientEx).SetCredenciais(LOp.Usuario, LOp.Senha, LOp.APIKey);
    
    FClients.Add(LKey, Result);
  end;
end;

procedure TfrmPBM_PDV.ConfigurarGrid;
begin
  with sgProdutos do
  begin
    ColCount := 7;
    RowCount := 2;
    FixedRows := 1;
    
    Cells[0, 0] := 'EAN';
    Cells[1, 0] := 'Descrição';
    Cells[2, 0] := 'Qtd';
    Cells[3, 0] := 'Preço';
    Cells[4, 0] := 'Desc%';
    Cells[5, 0] := 'Desconto';
    Cells[6, 0] := 'Final';
    
    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 50;
    ColWidths[3] := 80;
    ColWidths[4] := 50;
    ColWidths[5] := 80;
    ColWidths[6] := 80;
  end;
end;

procedure TfrmPBM_PDV.DefinirProdutos(const AProdutos: TArray<RPBMAutorizacaoItem>);
var
  I: Integer;
begin
  FProdutos := AProdutos;
  
  sgProdutos.RowCount := Length(FProdutos) + 1;
  if sgProdutos.RowCount < 2 then
    sgProdutos.RowCount := 2;
  
  for I := 0 to High(FProdutos) do
  begin
    sgProdutos.Cells[0, I + 1] := FProdutos[I].EAN;
    sgProdutos.Cells[1, I + 1] := FProdutos[I].Descricao;
    sgProdutos.Cells[2, I + 1] := FormatFloat('0.###', FProdutos[I].Quantidade);
    sgProdutos.Cells[3, I + 1] := FormatFloat('#,##0.00', FProdutos[I].PrecoVenda);
    sgProdutos.Cells[4, I + 1] := '';
    sgProdutos.Cells[5, I + 1] := '';
    sgProdutos.Cells[6, I + 1] := FormatFloat('#,##0.00', FProdutos[I].ValorFinal);
  end;
  
  AtualizarTotais;
end;

procedure TfrmPBM_PDV.DefinirVenda(AVendaID: Int64; const ATransacaoID: string);
begin
  FVendaID := AVendaID;
  FTransacaoID := ATransacaoID;
  if FTransacaoID = '' then
    FTransacaoID := FormatDateTime('yyyymmddhhnnsszzz', Now);
end;

procedure TfrmPBM_PDV.SelecionarOperadora(const ACodigo: string);
var
  I: Integer;
begin
  for I := 0 to High(FOperadoras) do
  begin
    if SameText(FOperadoras[I].Codigo, ACodigo) then
    begin
      cbbOperadora.ItemIndex := I;
      cbbOperadoraChange(nil);
      Break;
    end;
  end;
end;

procedure TfrmPBM_PDV.PreencherBeneficiario(const ACarteirinha, ACPF: string; ADataNasc: TDate);
begin
  edtCarteirinha.Text := ACarteirinha;
  edtCPF.Text := ACPF;
  if ADataNasc > 0 then
    edtDataNasc.Text := FormatDateTime('dd/mm/yyyy', ADataNasc)
  else
    edtDataNasc.Clear;
end;

function TfrmPBM_PDV.MontarProdutosRequest: TArray<TPBMProduto>;
var
  I: Integer;
begin
  SetLength(Result, Length(FProdutos));
  for I := 0 to High(FProdutos) do
  begin
    Result[I].EAN := FProdutos[I].EAN;
    Result[I].Descricao := FProdutos[I].Descricao;
    Result[I].Quantidade := FProdutos[I].Quantidade;
    Result[I].PrecoUnitario := FProdutos[I].PrecoVenda;
    Result[I].PrecoTotal := FProdutos[I].PrecoVenda * FProdutos[I].Quantidade;
  end;
end;

procedure TfrmPBM_PDV.AtualizarTotais;
var
  LBruto, LDesconto, LLiquido: Currency;
  I: Integer;
begin
  LBruto := 0;
  LDesconto := 0;
  
  for I := 0 to High(FProdutos) do
  begin
    LBruto := LBruto + (FProdutos[I].PrecoVenda * FProdutos[I].Quantidade);
    LDesconto := LDesconto + FProdutos[I].DescontoValor;
  end;
  
  LLiquido := LBruto - LDesconto;
  
  edtValorBruto.Text := FormatFloat('#,##0.00', LBruto);
  edtValorDesconto.Text := FormatFloat('#,##0.00', LDesconto);
  edtValorLiquido.Text := FormatFloat('#,##0.00', LLiquido);
end;

procedure TfrmPBM_PDV.SetStatus(AStatus: TPBMStatusVisual; const AMensagem: string);
begin
  case AStatus of
    svAguardando:
    begin
      pnlStatus.Color := clBtnFace;
      pnlStatus.Font.Color := clWindowText;
    end;
    svProcessando:
    begin
      pnlStatus.Color := clYellow;
      pnlStatus.Font.Color := clBlack;
      tmrProcessando.Enabled := True;
    end;
    svSucesso:
    begin
      pnlStatus.Color := clGreen;
      pnlStatus.Font.Color := clWhite;
      tmrProcessando.Enabled := False;
    end;
    svErro:
    begin
      pnlStatus.Color := clRed;
      pnlStatus.Font.Color := clWhite;
      tmrProcessando.Enabled := False;
    end;
  end;
  
  pnlStatus.Caption := AMensagem;
  Application.ProcessMessages;
end;

procedure TfrmPBM_PDV.HabilitarControles(AHabilitar: Boolean);
begin
  cbbOperadora.Enabled := AHabilitar;
  gbxBeneficiario.Enabled := AHabilitar;
  btnConsultar.Enabled := AHabilitar;
  btnAutorizar.Enabled := AHabilitar;
  btnCancelar.Enabled := AHabilitar and (edtNSU.Text <> '');
  btnLimpar.Enabled := AHabilitar;
  btnFechar.Enabled := AHabilitar;
end;

procedure TfrmPBM_PDV.LimparFormulario;
begin
  edtCarteirinha.Clear;
  edtCPF.Clear;
  edtDataNasc.Clear;
  edtNome.Clear;
  edtNSU.Clear;
  edtCodAutorizacao.Clear;
  edtPontosAtuais.Clear;
  edtPontosGanhos.Clear;
  mmoMensagem.Clear;
  
  // Limpa descontos do grid
  for var I := 1 to sgProdutos.RowCount - 1 do
  begin
    sgProdutos.Cells[4, I] := '';
    sgProdutos.Cells[5, I] := '';
  end;
  
  // Reseta produtos
  for var I := 0 to High(FProdutos) do
  begin
    FProdutos[I].DescontoPercentual := 0;
    FProdutos[I].DescontoValor := 0;
    FProdutos[I].ValorFinal := FProdutos[I].PrecoVenda * FProdutos[I].Quantidade;
  end;
  
  AtualizarTotais;
  SetStatus(svAguardando, 'Aguardando...');
  FAutorizacaoAtual := Default(RPBMAutorizacao);
end;

procedure TfrmPBM_PDV.btnConsultarClick(Sender: TObject);
var
  LClient: IPBMClient;
  LEleg: IPBMElegibilidade;
  LDataNasc: TDate;
  LStart: TDateTime;
begin
  LClient := GetClienteAtual;
  if LClient = nil then
  begin
    SetStatus(svErro, 'Selecione uma operadora');
    Exit;
  end;
  
  if Trim(edtCarteirinha.Text) = '' then
  begin
    SetStatus(svErro, 'Informe a carteirinha');
    edtCarteirinha.SetFocus;
    Exit;
  end;
  
  // Parse data nascimento
  LDataNasc := 0;
  if Trim(edtDataNasc.Text) <> '' then
  try
    LDataNasc := StrToDate(edtDataNasc.Text);
  except
    SetStatus(svErro, 'Data de nascimento inválida');
    edtDataNasc.SetFocus;
    Exit;
  end;
  
  HabilitarControles(False);
  SetStatus(svProcessando, 'Consultando elegibilidade...');
  LStart := Now;
  
  try
    LEleg := LClient.ConsultarElegibilidade(
      Trim(edtCarteirinha.Text),
      Trim(edtCPF.Text),
      LDataNasc
    );
    
    // Log
    TPBMClientHelper.RegistrarLog(
      FPersistence,
      GetOperadoraSelecionada.ID,
      0,
      'CONSULTAR',
      '', 'POST', '', '',
      iif(LEleg.Sucesso, 200, 400),
      MilliSecondsBetween(Now, LStart),
      1, LEleg.Sucesso, LEleg.Mensagem
    );
    
    ProcessarResultadoConsulta(LEleg);
  except
    on E: Exception do
    begin
      SetStatus(svErro, 'Erro: ' + E.Message);
      TPBMClientHelper.RegistrarLog(
        FPersistence,
        GetOperadoraSelecionada.ID,
        0,
        'CONSULTAR',
        '', 'POST', '', '',
        0,
        MilliSecondsBetween(Now, LStart),
        1, False, E.Message
      );
    end;
  end;
  
  HabilitarControles(True);
end;

procedure TfrmPBM_PDV.ProcessarResultadoConsulta(const AElegibilidade: IPBMElegibilidade);
var
  I: Integer;
  LDescProd: TPBMDescontoProduto;
begin
  if AElegibilidade.Sucesso then
  begin
    SetStatus(svSucesso, 'Beneficiário elegível');
    edtNome.Text := AElegibilidade.NomeBeneficiario;
    
    // Aplica descontos nos produtos
    for I := 0 to High(FProdutos) do
    begin
      for LDescProd in AElegibilidade.Descontos do
      begin
        if SameText(FProdutos[I].EAN, LDescProd.EAN) then
        begin
          FProdutos[I].DescontoPercentual := LDescProd.DescontoPercentual;
          FProdutos[I].DescontoValor := LDescProd.DescontoValor;
          FProdutos[I].ValorFinal := (FProdutos[I].PrecoVenda * FProdutos[I].Quantidade) - LDescProd.DescontoValor;
          
          // Atualiza grid
          sgProdutos.Cells[4, I + 1] := FormatFloat('0.00', LDescProd.DescontoPercentual);
          sgProdutos.Cells[5, I + 1] := FormatFloat('#,##0.00', LDescProd.DescontoValor);
          sgProdutos.Cells[6, I + 1] := FormatFloat('#,##0.00', FProdutos[I].ValorFinal);
          Break;
        end;
      end;
    end;
    
    AtualizarTotais;
    mmoMensagem.Lines.Add('Elegibilidade confirmada: ' + AElegibilidade.Mensagem);
  end
  else
  begin
    SetStatus(svErro, 'Não elegível');
    mmoMensagem.Lines.Add('Erro: ' + AElegibilidade.Mensagem);
    if AElegibilidade.CodigoErro <> '' then
      mmoMensagem.Lines.Add('Código: ' + AElegibilidade.CodigoErro);
  end;
end;

procedure TfrmPBM_PDV.btnAutorizarClick(Sender: TObject);
var
  LClient: IPBMClient;
  LAuth: IPBMAutorizacao;
  LDataNasc: TDate;
  LValorBruto: Currency;
  LStart: TDateTime;
  I: Integer;
begin
  LClient := GetClienteAtual;
  if LClient = nil then
  begin
    SetStatus(svErro, 'Selecione uma operadora');
    Exit;
  end;
  
  if Trim(edtCarteirinha.Text) = '' then
  begin
    SetStatus(svErro, 'Informe a carteirinha');
    edtCarteirinha.SetFocus;
    Exit;
  end;
  
  if Length(FProdutos) = 0 then
  begin
    SetStatus(svErro, 'Nenhum produto informado');
    Exit;
  end;
  
  // Confirmação
  if MessageDlg('Confirma autorização da venda PBM?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  
  // Parse data nascimento
  LDataNasc := 0;
  if Trim(edtDataNasc.Text) <> '' then
    LDataNasc := StrToDate(edtDataNasc.Text);
  
  // Calcula valor bruto
  LValorBruto := 0;
  for I := 0 to High(FProdutos) do
    LValorBruto := LValorBruto + (FProdutos[I].PrecoVenda * FProdutos[I].Quantidade);
  
  HabilitarControles(False);
  SetStatus(svProcessando, 'Autorizando venda...');
  LStart := Now;
  
  try
    LAuth := LClient.AutorizarVenda(
      Trim(edtCarteirinha.Text),
      Trim(edtCPF.Text),
      LDataNasc,
      MontarProdutosRequest,
      LValorBruto,
      FTransacaoID
    );
    
    ProcessarResultadoAutorizacao(LAuth);
    
    // Persiste autorização
    if LAuth.Sucesso then
    begin
      FAutorizacaoAtual.ID := TPBMClientHelper.PersistirAutorizacao(
        FPersistence,
        GetOperadoraSelecionada.ID,
        LAuth,
        FTransacaoID,
        Trim(edtCarteirinha.Text),
        Trim(edtCPF.Text),
        LValorBruto,
        FProdutos,
        '', '' // Request/Response JSON
      );
      
      // Vincula venda se informada
      if FVendaID > 0 then
        FPersistence.VincularVenda(FAutorizacaoAtual.ID, FVendaID);
      
      // Dispara evento
      if Assigned(FOnAutorizado) then
        FOnAutorizado(Self, FAutorizacaoAtual);
    end;
    
    // Log
    TPBMClientHelper.RegistrarLog(
      FPersistence,
      GetOperadoraSelecionada.ID,
      FAutorizacaoAtual.ID,
      'AUTORIZAR',
      '', 'POST', '', '',
      iif(LAuth.Sucesso, 200, 400),
      MilliSecondsBetween(Now, LStart),
      1, LAuth.Sucesso, LAuth.Mensagem
    );
    
  except
    on E: Exception do
    begin
      SetStatus(svErro, 'Erro: ' + E.Message);
      TPBMClientHelper.RegistrarLog(
        FPersistence,
        GetOperadoraSelecionada.ID,
        0,
        'AUTORIZAR',
        '', 'POST', '', '',
        0,
        MilliSecondsBetween(Now, LStart),
        1, False, E.Message
      );
    end;
  end;
  
  HabilitarControles(True);
end;

procedure TfrmPBM_PDV.ProcessarResultadoAutorizacao(const AAutorizacao: IPBMAutorizacao);
begin
  if AAutorizacao.Sucesso then
  begin
    SetStatus(svSucesso, 'AUTORIZADO - NSU: ' + AAutorizacao.NSU);
    
    edtNSU.Text := AAutorizacao.NSU;
    edtCodAutorizacao.Text := AAutorizacao.CodigoAutorizacao;
    edtNome.Text := AAutorizacao.NomeBeneficiario;
    edtValorDesconto.Text := FormatFloat('#,##0.00', AAutorizacao.ValorDesconto);
    
    // Atualiza valor líquido
    var LBruto := StrToFloatDef(StringReplace(edtValorBruto.Text, '.', '', [rfReplaceAll]), 0);
    edtValorLiquido.Text := FormatFloat('#,##0.00', LBruto - AAutorizacao.ValorDesconto);
    
    // Rewards
    if gbxRewards.Visible then
    begin
      // Busca saldo atualizado
      var LSaldo := FPersistence.GetSaldoRewards(
        GetOperadoraSelecionada.ID, 
        Trim(edtCPF.Text)
      );
      edtPontosAtuais.Text := IntToStr(LSaldo);
    end;
    
    mmoMensagem.Lines.Add('=== AUTORIZAÇÃO APROVADA ===');
    mmoMensagem.Lines.Add('NSU: ' + AAutorizacao.NSU);
    mmoMensagem.Lines.Add('Código: ' + AAutorizacao.CodigoAutorizacao);
    mmoMensagem.Lines.Add('Desconto: R$ ' + FormatFloat('#,##0.00', AAutorizacao.ValorDesconto));
    mmoMensagem.Lines.Add(AAutorizacao.Mensagem);
    
    btnCancelar.Enabled := True;
  end
  else
  begin
    SetStatus(svErro, 'NÃO AUTORIZADO');
    
    mmoMensagem.Lines.Add('=== AUTORIZAÇÃO NEGADA ===');
    mmoMensagem.Lines.Add('Motivo: ' + AAutorizacao.Mensagem);
    if AAutorizacao.CodigoErro <> '' then
      mmoMensagem.Lines.Add('Código Erro: ' + AAutorizacao.CodigoErro);
  end;
end;

procedure TfrmPBM_PDV.btnCancelarClick(Sender: TObject);
var
  LClient: IPBMClient;
  LCancel: IPBMCancelamento;
  LStart: TDateTime;
begin
  if Trim(edtNSU.Text) = '' then
  begin
    SetStatus(svErro, 'Nenhuma autorização para cancelar');
    Exit;
  end;
  
  if MessageDlg('Confirma CANCELAMENTO da autorização NSU ' + edtNSU.Text + '?',
    mtWarning, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  
  LClient := GetClienteAtual;
  if LClient = nil then
  begin
    SetStatus(svErro, 'Selecione uma operadora');
    Exit;
  end;
  
  HabilitarControles(False);
  SetStatus(svProcessando, 'Cancelando autorização...');
  LStart := Now;
  
  try
    LCancel := LClient.CancelarVenda(
      Trim(edtNSU.Text),
      Trim(edtCodAutorizacao.Text),
      'Cancelamento pelo operador'
    );
    
    if LCancel.Sucesso then
    begin
      SetStatus(svSucesso, 'Cancelamento confirmado');
      
      // Atualiza status no banco
      TPBMClientHelper.PersistirCancelamento(
        FPersistence,
        GetOperadoraSelecionada.ID,
        Trim(edtNSU.Text),
        'Cancelamento pelo operador'
      );
      
      mmoMensagem.Lines.Add('=== CANCELAMENTO CONFIRMADO ===');
      mmoMensagem.Lines.Add('NSU: ' + edtNSU.Text);
      mmoMensagem.Lines.Add('Protocolo: ' + LCancel.ProtocoloCancelamento);
      
      edtNSU.Clear;
      edtCodAutorizacao.Clear;
      btnCancelar.Enabled := False;
    end
    else
    begin
      SetStatus(svErro, 'Cancelamento não autorizado');
      mmoMensagem.Lines.Add('=== CANCELAMENTO NEGADO ===');
      mmoMensagem.Lines.Add('Motivo: ' + LCancel.Mensagem);
    end;
    
    // Log
    TPBMClientHelper.RegistrarLog(
      FPersistence,
      GetOperadoraSelecionada.ID,
      FAutorizacaoAtual.ID,
      'CANCELAR',
      '', 'POST', '', '',
      iif(LCancel.Sucesso, 200, 400),
      MilliSecondsBetween(Now, LStart),
      1, LCancel.Sucesso, LCancel.Mensagem
    );
    
  except
    on E: Exception do
    begin
      SetStatus(svErro, 'Erro: ' + E.Message);
      TPBMClientHelper.RegistrarLog(
        FPersistence,
        GetOperadoraSelecionada.ID,
        FAutorizacaoAtual.ID,
        'CANCELAR',
        '', 'POST', '', '',
        0,
        MilliSecondsBetween(Now, LStart),
        1, False, E.Message
      );
    end;
  end;
  
  HabilitarControles(True);
end;

procedure TfrmPBM_PDV.btnLimparClick(Sender: TObject);
begin
  LimparFormulario;
  if edtCarteirinha.CanFocus then
    edtCarteirinha.SetFocus;
end;

procedure TfrmPBM_PDV.btnFecharClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TfrmPBM_PDV.tmrProcessandoTimer(Sender: TObject);
const
  DOTS: array[0..3] of string = ('', '.', '..', '...');
var
  LBase: string;
  LIdx: Integer;
begin
  LBase := StringReplace(pnlStatus.Caption, '...', '', [rfReplaceAll]);
  LBase := StringReplace(LBase, '..', '', [rfReplaceAll]);
  LBase := StringReplace(LBase, '.', '', [rfReplaceAll]);
  
  LIdx := (GetTickCount div 500) mod 4;
  pnlStatus.Caption := LBase + DOTS[LIdx];
end;

end.
