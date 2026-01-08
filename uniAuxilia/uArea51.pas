unit uArea51;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Data.DB, FireDAC.Comp.Client, System.DateUtils,
  uLibFarm, MarcLib, LMDControl, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDEdit,Vcl.Mask,
  Vcl.Grids, Vcl.DBGrids, DBAccess, AdvGlowButton, Vcl.ExtCtrls,
  RxToolEdit, RxDBCtrl, Vcl.ComCtrls, System.JSON, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Types,
  uRESTDWBasicClass, uRESTDWIdBase, uConsultJSONParser, Uni;

type
  TFrmArea51 = class(TForm)
    Button1: TButton;
    edPasta: TLMDLabeledEdit;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Button4: TButton;
    UniDataSource: TUniDataSource;
    Button6: TButton;
    UniSouPromo: TUniDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    btFechar: TAdvGlowButton;
    Button7: TButton;
    btPrgres: TAdvGlowButton;
    Shape1: TShape;
    Button10: TButton;
    DateTimePicker1: TDateTimePicker;
    Button11: TButton;
    Memo1: TMemo;
    Button12: TButton;
    btProduto: TAdvGlowButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button7Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
    MemProduto,MemPromocao:TFDMemTable;
  public
    { Public declarations }
  end;

var
  FrmArea51: TFrmArea51;

implementation

{$R *.dfm}

uses uDM, uConst, uMigracao, uIAPromo, uIAGeral, uConsultFiscal;

procedure TFrmArea51.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmArea51.Button1Click(Sender: TObject);
begin
   MigraNF(edPasta.Text,'S',5);
end;

procedure TFrmArea51.Button2Click(Sender: TObject);
begin
   LerProdutosCSV(edPasta.Text);
end;

procedure TFrmArea51.Button3Click(Sender: TObject);
begin
   LerProdutosCMED(edPasta.Text);
end;

procedure TFrmArea51.Button5Click(Sender: TObject);
begin
   AtuProdutoCMED;
end;

procedure TFrmArea51.Button4Click(Sender: TObject);
begin
   GeraTestesIA;
end;

procedure TFrmArea51.Button6Click(Sender: TObject);
begin
   MemProduto := TFDMemTable.Create(nil);
   MemProduto := Perceptron1(60, 45, 1, 0.00, Date,IncDay(Date,15),0);
   if MemProduto.RecordCount > 0 then UniDataSource.DataSet := MemProduto;
end;

procedure TFrmArea51.Button7Click(Sender: TObject);
var
   aIDGrupo,aIDGruSub,aFabrica:TArray<Integer>;
begin
   MemPromocao := TFDMemTable.Create(nil);
   MemPromocao := SelProdProm(aIDGrupo,aIDGruSub,aFabrica,45,60,45,1,0.00,Date,IncDay(Date,15),0);
   if MemPromocao.RecordCount > 0 then UniSouPromo.DataSet := MemPromocao;
end;

procedure TFrmArea51.Button8Click(Sender: TObject);
begin
   GravaMacroIndices(StrToDate('01/12/2023'),StrToDate('31/12/2023'));
end;

procedure TFrmArea51.Button9Click(Sender: TObject);
begin
   GravaMeterologia(-20.421793,-54.597565, StrToDate('18/12/2023'), StrToDate('03/01/2024'), CheckBox1.Checked)
end;

procedure TFrmArea51.DBGrid1CellClick(Column: TColumn);
begin
   if Assigned(MemPromocao) then
      MemPromocao.Locate('IDProd',MemProduto.FieldByName('IDProd').AsInteger,[]);
end;

procedure TFrmArea51.DBGrid2CellClick(Column: TColumn);
begin
   if Assigned(MemProduto) then
      MemProduto.Locate('IDProd',MemPromocao.FieldByName('IDProd').AsInteger,[]);
end;

procedure TFrmArea51.Button10Click(Sender: TObject);
var
   MemCompras:TFDMemTable;
begin
   MemCompras := TFDMemTable.Create(nil);
   try
      MemCompras := Perceptron2(DateTimePicker1.Date, 0);
   finally
      UniDataSource.DataSet := MemCompras;
   end;
end;

procedure TFrmArea51.Button11Click(Sender: TObject);
begin
   {try
      DownXlsCIMED('C:\Fontes\AIOne\Diversos\CIMED');
   except
    on E: Exception do
      ShowMessage(E.ClassName + ': ' + E.Message);
  end; }
end;

procedure TFrmArea51.Button12Click(Sender: TObject);
var
   Lines: TStringList;
   RequestJSON,Response,recToken:string;
   JSONString: string;
   JSONResponse: TJSONResponse;
   Cabecalho: TCabecalho;
   Resumo: TResumo;
   Produto: TProduto;
   CFOPItem: TCFOPItem;
   CFOP: TCFOP;
   Erro: TErro;
begin
   recToken := ConsultToken('27124815000139','271248');
   if AnsiPos('Erro',recToken) > 0 then
   begin
      ShowMessage('Não foi possível gerar o Token.'+#10+recToken);
      Exit;
   end;
   Lines := TStringList.Create;
   try
      Lines.Add('7898653174130;0229671;CAFEINA 420MG 60 CPS POWER ON');
      Lines.Add('7898379205910;0004818;MACA PERUANA 100CP');
      Lines.Add('7891058017507;0100000;DIPIRONA + CAFEÍNA');
//    Lines.Add('7896083400027;13041501;ALCACHOFRA HERBA C/45 CAPS');
      RequestJSON := BuildJSONRequest('27124815000139', 'MG', '1', '101', Lines, recToken);
      Response    := SendConsultRequest(RequestJSON);
      if AnsiPos('Erro', Response) > 0 then
      begin
         ShowMessage(Response);
         Exit;
      end;

      Memo1.Lines.Clear;
//Memo1.Lines.Add(Response);
//EXIT;

      // Parseando o JSON retornado para objetos Delphi
      JSONResponse := ParseJSONResponse(Response);
      try
        // Acessando os dados dos objetos
        Memo1.Lines.Add('Cabeçalho:');
        for Cabecalho in JSONResponse.CABECALHO do
        begin
          Memo1.Lines.Add(Format('CNPJ: %s, Data: %s, Hora: %s, Tipo Arquivo: %s',
            [Cabecalho.CNPJ, Cabecalho.DT_TRANS, Cabecalho.HR_TRANS, Cabecalho.TP_ARQ]));
        end;

        Memo1.Lines.Add('Resumo:');
        for Resumo in JSONResponse.RESUMO do
        begin
           Memo1.Lines.Add(Format('Total: %s, Certos: %s, Ajustado: %s, Análise Cliente: %s, Análise Consult: %s',
           [Resumo.TOTAL, Resumo.CERTOS, Resumo.AJUSTADO, Resumo.ANALISECLIENTE, Resumo.ANALISECONSULT]));
        end;

        Memo1.Lines.Add('Produtos:');
        for Produto in JSONResponse.PRODUTO do
        begin
          Memo1.Lines.Add(Format('Código de Barras: %s, Código Interno: %s, Descrição: %s',[Produto.COD_BARRAS, Produto.COD_INTERNO, Produto.DESCRICAO]));

         //..... Acessando os valores de CFOP
          Memo1.Lines.Add('CFOP:');
          for CFOPItem in Produto.CFOP do
          begin
            Memo1.Lines.Add('  Operações Internas:');
            for CFOP in CFOPItem.OP_INTERNO do
            begin
               Memo1.Lines.Add(Format('    CFOP_EI: %s, CFOP_SI: %s', [CFOP.CFOP_EI, CFOP.CFOP_SI]));
            end;
            Memo1.Lines.Add('  Operações Interestaduais:');
            for CFOP in CFOPItem.OP_INTESTADUAL do
            begin
              Memo1.Lines.Add(Format('    CFOP_EE: %s, CFOP_SE: %s', [CFOP.CFOP_EE, CFOP.CFOP_SE]));
            end;
          end;

          // Acesse outros campos conforme necessário
        end;

        Memo1.Lines.Add('Erros:');
        for Erro in JSONResponse.ERRO do
        begin
          Memo1.Lines.Add(Format('Código Interno: %s, Descrição: %s, Mensagem de Erro: %s',
            [Erro.COD_INTERNO, Erro.DESCRICAO, Erro.MSGERR]));
        end;
      finally
        JSONResponse.Free;
      end;
      //Memo1.Lines.Text := Response;
   finally
      Lines.Free;
   end;
end;

end.

