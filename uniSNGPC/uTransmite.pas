unit uTransmite;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Data.DB, Vcl.ComCtrls, Vcl.Grids, MarcLib, LMDBaseControl,LMDEdit,
   LMDBaseGraphicControl, LMDBaseLabel, Vcl.DBGrids, LMDLabel, LMDControl,
   LMDCustomControl, LMDCustomPanel, LMDSimplePanel, LMDCustomBevelPanel,
   AdvGlowButton, LMDCustomLabel, VirtualTable, System.Types, System.StrUtils,
   LMDBaseEdit, LMDCustomEdit, Vcl.StdCtrls, FireDAC.Stan.Intf, uRESTDWBasicDB,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, uRESTDWBasicTypes,
   FireDAC.Comp.Client, Vcl.ExtCtrls, LMDDBEdit, Vcl.Mask, RxToolEdit, RxDBCtrl,
   LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, Xml.xmldom, Xml.XMLIntf,
   Xml.XMLDoc, Xml.Win.msxmldom;

type
  TFrmTransmite = class(TForm)
    PanelTop: TLMDSimplePanel;
    LMDLabel4: TLMDLabel;
    btFechar: TAdvGlowButton;
    PanelCadastro: TLMDSimplePanel;
    DBGrid1: TDBGrid;
    SouSNGPC: TDataSource;
    TabSNGPC: TRESTDWClientSQL;
    LMDSimplePanel1: TLMDSimplePanel;
    btExcluir: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    LMDSimplePanel2: TLMDSimplePanel;
    edDataIni: TDateEdit;
    LMDSimplePanel3: TLMDSimplePanel;
    edDataFin: TDateEdit;
    ckTipEnvio: TLMDCheckBox;
    btBuscar: TAdvGlowButton;
    TabSNGPCIDFilial: TIntegerField;
    TabSNGPCDataIni: TDateField;
    TabSNGPCDataFin: TDateField;
    TabSNGPCTipoEnv: TWideStringField;
    TabSNGPCTipoStr: TWideStringField;
    XMLDoc: TXMLDocument;
    XMLDocument1: TXMLDocument;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender:TObject; const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
    procedure TabSNGPCCalcFields(DataSet: TDataSet);
    procedure btBuscarClick(Sender: TObject);
  private
    { Private declarations }
    procedure AjustGrid;
  public
    { Public declarations }
  end;

var
   FrmTransmite: TFrmTransmite;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmTransmite.FormCreate(Sender: TObject);
begin
   AdjustZoom(Self);
end;

procedure TFrmTransmite.FormShow(Sender: TObject);
begin
   Left := (Parent.Width  - Width)  div 2;
   Top  := (Parent.Height - Height) div 2;
   try
      TabSNGPC.SQL.Text := 'SELECT * FROM arqsngpcenv WHERE IDFilial = '+FILIAL.ToString+' ORDER BY DataIni DESC LIMIT 200';
      TabSNGPC.Open;
   except
      MostraMsg('Erro', 'Não foi possível continuar!',mtError, [mbOk]);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
   end;
   AjustGrid;
   edDataIni.SetFocus;
end;

procedure TFrmTransmite.AjustGrid;
begin
   DBGrid1.Width := DBGrid1.Width - 10;
   DBGrid1.Width := DBGrid1.Width + 10;
end;

procedure TFrmTransmite.DBGrid1CellClick(Column: TColumn);
begin
   if Column.ID = 3 then
   begin
      if TabSNGPC.RecordCount > 0 then
      begin
         if MostraMsg('Confirmação','Confirma eliminação deste?',mtConfirmation, [mbYes, mbNo]) = mrYes then
            TabSNGPC.Delete;
      end; //if
      DBGrid1.SelectedField := TabSNGPCTipoStr;
   end;
end;

procedure TFrmTransmite.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) or (gdFocused in State) then
   begin
      TDBGrid(Sender).Canvas.Brush.Color := $00E1EBFF;
      TDBGrid(Sender).Canvas.Font.Color  := clBlack;
   end;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
   if Column.ID = 3 then DM.ImagesGer.Draw((Sender as TDBGrid).Canvas, Rect.Left+2, Rect.Top+1, 0);
end;

procedure TFrmTransmite.TabSNGPCCalcFields(DataSet: TDataSet);
begin
   TabSNGPCTipoStr.Value := iif(TabSNGPCTipoEnv.Value = '1','VIA API','MANUAL');
end;

procedure TFrmTransmite.btBuscarClick(Sender: TObject);
begin
   XMLDoc.FileName := '';
   XMLDoc.XML.Text := '';
   XMLDoc.Active   := False;
   XMLDoc.Active   := True;
   XMLDoc.Version  := '1.0';
   XMLDoc.Encoding := 'iso-8859-1'
{
uses
  Xml.XMLDoc, Xml.XMLIntf, System.SysUtils;

procedure GerarXMLSNGPC;
var
  XMLDoc: IXMLDocument;
  RootNode, CabecalhoNode, RegistroNode: IXMLNode;
begin
  // Criar instância do XMLDocument
  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.Active := True;
  XMLDoc.Version := '1.0';
  XMLDoc.Encoding := 'UTF-8';

  // Criar nó raiz
  RootNode := XMLDoc.AddChild('transmissao');

  // Criar nó <cabecalho>
  CabecalhoNode := RootNode.AddChild('cabecalho');
  CabecalhoNode.AddChild('cnpj').Text := '12345678000199';
  CabecalhoNode.AddChild('razaoSocial').Text := 'Farmácia Exemplo LTDA';
  CabecalhoNode.AddChild('dataInicio').Text := '01/09/2025';
  CabecalhoNode.AddChild('dataFim').Text := '04/09/2025';
  CabecalhoNode.AddChild('numeroTransmissao').Text := '000001';

  // Criar nó <registro>
  RegistroNode := RootNode.AddChild('registro');

  // Exemplo de movimentação
  with RegistroNode.AddChild('movimentacaoEntradaMedicamento') do
  begin
    AddChild('numeroNotificacaoReceita').Text := 'N/A';
    AddChild('dataEntrada').Text := '03/09/2025';
    AddChild('codigoProduto').Text := '7891234567890';
    AddChild('numeroLote').Text := 'L12345';
    AddChild('quantidade').Text := '100';
    AddChild('dataFabricacao').Text := '01/01/2025';
    AddChild('dataValidade').Text := '01/01/2027';
    AddChild('cnpjFabricante').Text := '98765432000188';
  end;

  // Você pode adicionar outros nós conforme o manual da ANVISA:
  // movimentacaoSaidaMedicamento, movimentacaoEntradaMateriaPrima, etc.

  // Salvar o XML
  XMLDoc.SaveToFile('C:\XML\SNGPC_Transmissao.xml');

  ShowMessage('XML SNGPC gerado com sucesso.');
end;
}
end;

procedure TFrmTransmite.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmTransmite.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TabSNGPC.Close;
end;

end.
