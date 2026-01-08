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
      TabPBM: TRESTDWClientSQL;
      SouPBM: TDataSource;
      TabPBMIDPed: TIntegerField;
      TabPBMNroAutor: TWideStringField;
      TabPBMDesPro: TWideStringField;
      TabPBMNomGru: TWideStringField;
      TabPBMNomCli: TWideStringField;
      TabPBMQtde: TFloatField;
      TabPBMValor: TCurrencyField;
      TabPBMCRUF: TWideStringField;
      TabPBMDatVenda: TDateField;
      TabPBMNomPBM: TWideStringField;
      TabPBMIDPBM: TSmallintField;
      TabPBMIDFilial: TIntegerField;
      TabPBMIDPro: TIntegerField;
      TabPBMIDCli: TIntegerField;
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
      procedure btBuscarClick(Sender: TObject);
      procedure DBGridEx1DrawColumnCell(Sender: TObject; const Rect: TRect;
         DataCol: Integer; Column: TColumn; State: TGridDrawState);
   private
      FIDFilial: Integer;
      FIDPBM: Integer;
      FIDGru: Integer;
      FIDSub: Integer;
      FIDFab: Integer;
      FIDCli: Integer;
      procedure CarregaDados;
      procedure LimpaFiltros;
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
   LimpaFiltros;
end;

procedure TFrmGestaoPBM.FormShow(Sender: TObject);
begin
   edDataIni.Date := StartOfTheMonth(Date);
   edDataFin.Date := Date;
   chkAberto.Checked := True;
   DBGridEx1.DataSource := SouPBM;
   CarregaDados;
end;

procedure TFrmGestaoPBM.LimpaFiltros;
begin
   FIDFilial := 0;
   FIDPBM := 0;
   FIDGru := 0;
   FIDSub := 0;
   FIDFab := 0;
   FIDCli := 0;
end;

procedure TFrmGestaoPBM.btFiltrarClick(Sender: TObject);
begin
   CarregaDados;
end;

procedure TFrmGestaoPBM.btBuscarClick(Sender: TObject);
begin
   CarregaDados;
end;

procedure TFrmGestaoPBM.CarregaDados;
var
   sSQL: String;
begin
   sSQL := 'SELECT PED.IDPed, ITE.NroAutor, PRO.DesPro, GRU.NomGru, CLI.NomPes AS NomCli, ' +
           'ITE.QtdIte AS Qtde, ITE.ValIte AS Valor, ' +
           'CONCAT(ITE.CRMPres, ''/'', ITE.UFCRM) AS CRUF, ' +
           'PED.DatPed AS DatVenda, PBM.NomPBM, PED.IDPBM, PED.IDFilial, ' +
           'ITE.IDPro, PED.IDCli ' +
           'FROM arqpedido PED ' +
           'INNER JOIN arqpedidoite ITE ON PED.IDPed = ITE.IDPed ' +
           'LEFT JOIN arqproduto PRO ON ITE.IDPro = PRO.IDPro ' +
           'LEFT JOIN arqprodutogpr GRU ON PRO.IDGruPro = GRU.IDGruPro ' +
           'LEFT JOIN arqpessoa CLI ON PED.IDCli = CLI.IDPes ' +
           'LEFT JOIN arqpbm PBM ON PED.IDPBM = PBM.IDPBM ' +
           'WHERE PED.IDPBM > 0 ' +
           'AND PED.DatPed BETWEEN :pDataIni AND :pDataFin ';

   // Filtro por Filial
   if FIDFilial > 0 then
      sSQL := sSQL + 'AND PED.IDFilial = :pFilial ';

   // Filtro por PBM
   if FIDPBM > 0 then
      sSQL := sSQL + 'AND PED.IDPBM = :pPBM ';

   // Filtro por Grupo
   if FIDGru > 0 then
      sSQL := sSQL + 'AND PRO.IDGruPro = :pGrupo ';

   // Filtro por Sub-Grupo
   if FIDSub > 0 then
      sSQL := sSQL + 'AND PRO.IDSubGru = :pSubGrupo ';

   // Filtro por Fabricante
   if FIDFab > 0 then
      sSQL := sSQL + 'AND PRO.IDFab = :pFabricante ';

   // Filtro por Cliente
   if FIDCli > 0 then
      sSQL := sSQL + 'AND PED.IDCli = :pCliente ';

   // Filtro por Autorização
   if Trim(edAutorizacao.Text) <> '' then
      sSQL := sSQL + 'AND ITE.NroAutor LIKE :pAutorizacao ';

   // Filtro por CR/UF do Prescritor
   if Trim(edCRUFPrescritor.Text) <> '' then
      sSQL := sSQL + 'AND (ITE.CRMPres LIKE :pCRUF OR ITE.UFCRM LIKE :pCRUF) ';

   // Filtros de status
   if chkEfetiva.Checked and not chkAberto.Checked then
      sSQL := sSQL + 'AND PED.StaPed = ''F'' '
   else if chkAberto.Checked and not chkEfetiva.Checked then
      sSQL := sSQL + 'AND PED.StaPed = ''A'' ';

   sSQL := sSQL + 'ORDER BY PED.DatPed DESC, PED.IDPed DESC';

   try
      TabPBM.Close;
      TabPBM.SQL.Text := sSQL;

      TabPBM.Params.ParamByName('pDataIni').AsDate := edDataIni.Date;
      TabPBM.Params.ParamByName('pDataFin').AsDate := edDataFin.Date;

      if FIDFilial > 0 then
         TabPBM.Params.ParamByName('pFilial').AsInteger := FIDFilial;

      if FIDPBM > 0 then
         TabPBM.Params.ParamByName('pPBM').AsInteger := FIDPBM;

      if FIDGru > 0 then
         TabPBM.Params.ParamByName('pGrupo').AsInteger := FIDGru;

      if FIDSub > 0 then
         TabPBM.Params.ParamByName('pSubGrupo').AsInteger := FIDSub;

      if FIDFab > 0 then
         TabPBM.Params.ParamByName('pFabricante').AsInteger := FIDFab;

      if FIDCli > 0 then
         TabPBM.Params.ParamByName('pCliente').AsInteger := FIDCli;

      if Trim(edAutorizacao.Text) <> '' then
         TabPBM.Params.ParamByName('pAutorizacao').AsString := '%' + Trim(edAutorizacao.Text) + '%';

      if Trim(edCRUFPrescritor.Text) <> '' then
         TabPBM.Params.ParamByName('pCRUF').AsString := '%' + Trim(edCRUFPrescritor.Text) + '%';

      TabPBM.Open;
   except
      on E: Exception do
      begin
         SalvaLog(USUARIO, PastaLog, '[ERRO] Gestão PBM - CarregaDados: ' + E.Message);
         MostraMsg('Erro', 'Erro ao carregar dados de PBM: ' + E.Message, mtError, [mbOk]);
      end;
   end;
end;

procedure TFrmGestaoPBM.btCancelarClick(Sender: TObject);
begin
   if TabPBM.IsEmpty then
   begin
      MostraMsg('Aviso', 'Nenhum registro selecionado para cancelar.', mtWarning, [mbOk]);
      Exit;
   end;

   if MostraMsg('Confirmação', 'Deseja realmente cancelar a transação PBM do pedido ' +
                TabPBMIDPed.AsString + '?' + sLineBreak + sLineBreak +
                'Produto: ' + TabPBMDesPro.AsString + sLineBreak +
                'Autorização: ' + TabPBMNroAutor.AsString,
                mtConfirmation, [mbYes, mbNo]) = mrNo then
      Exit;

   try
      // Registra o cancelamento no log
      SalvaLog(USUARIO, PastaLog, Format(
         '[PBM] Cancelamento solicitado - Pedido: %d, Autorização: %s, PBM: %s, Usuário: %s',
         [TabPBMIDPed.AsInteger, TabPBMNroAutor.AsString, TabPBMNomPBM.AsString, USUARIO]));

      MostraMsg('Informação', 'Solicitação de cancelamento registrada.' + sLineBreak +
                'O cancelamento será processado junto à operadora PBM.', mtInformation, [mbOk]);

      CarregaDados;
   except
      on E: Exception do
      begin
         SalvaLog(USUARIO, PastaLog, '[ERRO] Gestão PBM - Cancelamento: ' + E.Message);
         MostraMsg('Erro', 'Erro ao processar cancelamento: ' + E.Message, mtError, [mbOk]);
      end;
   end;
end;

procedure TFrmGestaoPBM.btImprimirClick(Sender: TObject);
begin
   if TabPBM.IsEmpty then
   begin
      MostraMsg('Aviso', 'Nenhum registro para imprimir.', mtWarning, [mbOk]);
      Exit;
   end;

   MostraMsg('Informação', 'Funcionalidade de impressão em desenvolvimento.', mtInformation, [mbOk]);
end;

procedure TFrmGestaoPBM.btVenderClick(Sender: TObject);
begin
   MostraMsg('Informação', 'Para realizar vendas com PBM, utilize o módulo de Vendas.', mtInformation, [mbOk]);
end;

procedure TFrmGestaoPBM.btInfoVendaClick(Sender: TObject);
var
   sInfo: String;
begin
   if TabPBM.IsEmpty then
   begin
      MostraMsg('Aviso', 'Nenhum registro selecionado.', mtWarning, [mbOk]);
      Exit;
   end;

   sInfo := 'INFORMAÇÕES DA VENDA PBM' + sLineBreak + sLineBreak +
            'Pedido: ' + TabPBMIDPed.AsString + sLineBreak +
            'Data: ' + FormatDateTime('dd/mm/yyyy', TabPBMDatVenda.AsDateTime) + sLineBreak +
            'PBM: ' + TabPBMNomPBM.AsString + sLineBreak +
            'Autorização: ' + TabPBMNroAutor.AsString + sLineBreak + sLineBreak +
            'Produto: ' + TabPBMDesPro.AsString + sLineBreak +
            'Grupo: ' + TabPBMNomGru.AsString + sLineBreak +
            'Quantidade: ' + FormatFloat('#,##0.00', TabPBMQtde.AsFloat) + sLineBreak +
            'Valor: R$ ' + FormatFloat('#,##0.00', TabPBMValor.AsCurrency) + sLineBreak + sLineBreak +
            'Cliente: ' + TabPBMNomCli.AsString + sLineBreak +
            'Prescritor CR/UF: ' + TabPBMCRUF.AsString;

   MostraMsg('Informações da Venda', sInfo, mtInformation, [mbOk]);
end;

procedure TFrmGestaoPBM.btReposicaoClick(Sender: TObject);
begin
   if TabPBM.IsEmpty then
   begin
      MostraMsg('Aviso', 'Nenhum registro selecionado.', mtWarning, [mbOk]);
      Exit;
   end;

   MostraMsg('Informação', 'Funcionalidade de reposição de fornecedor em desenvolvimento.' + sLineBreak +
             'Produto: ' + TabPBMDesPro.AsString, mtInformation, [mbOk]);
end;

procedure TFrmGestaoPBM.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmGestaoPBM.DBGridEx1DrawColumnCell(Sender: TObject;
   const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color := clBlack;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

   if TabPBM.Active then
   begin
      // Desenha ícone do PBM na primeira coluna
      if (Column.Index = 0) and (TabPBMIDPBM.AsInteger > 0) then
         DM.ImagePBM.Draw(TDBGrid(Sender).Canvas, Rect.Left + 2, Rect.Top + 2, TabPBMIDPBM.AsInteger);
   end;
end;

procedure TFrmGestaoPBM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabPBM.Close;
   Action := caFree;
end;

end.
