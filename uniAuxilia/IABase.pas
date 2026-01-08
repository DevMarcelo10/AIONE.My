unit IABase;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient,
  System.Net.URLClient, System.Net.HttpClientComponent, uRESTDWBasicDB,
  Data.DB;

type
  TOpenAIChat = class
  private
    FAPIKey: string;
    FModel: string;
    FHttpClient: TNetHTTPClient;
    function BuildJSONBody(const Messages: TJSONArray): string;
  public
    constructor Create(const Model: string = 'gpt-4.1-nano');
    destructor Destroy; override;
    function SendMessage(const Messages: TJSONArray): string;
    function GerarJSON(FDQuery:TRESTDWClientSQL; const Titulo, Descricao: string): string;
    function GerarSQL(const Pergunta: string):String;
    function ExecSQLToJSON(FDQuery:TRESTDWClientSQL; const SQL: string): string;
    function InterpretaIA(const JSONDados: string): string;
  end;

function CreateMessage(Role, Content: string): TJSONObject;

const
   // API Key deve ser configurada no config.ini [OPENAI] APIKey=
   APIKey:String = '';

implementation

function CreateMessage(Role, Content: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('role', Role);
  Result.AddPair('content', Content);
end;

{ TOpenAIChat }

constructor TOpenAIChat.Create(const Model: string);
begin
  inherited Create;
  FAPIKey := APIKey;
  FModel := Model;
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpClient.ContentType := 'application/json';
  FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + FAPIKey;
end;

destructor TOpenAIChat.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TOpenAIChat.BuildJSONBody(const Messages: TJSONArray): string;
var
  JSONBody: TJSONObject;
begin
  JSONBody := TJSONObject.Create;
  try
    JSONBody.AddPair('model', FModel);
    JSONBody.AddPair('messages', Messages);
    Result := JSONBody.ToJSON;
  finally
    JSONBody.Free;
  end;
end;

function TOpenAIChat.SendMessage(const Messages: TJSONArray): string;
var
  Response: IHTTPResponse;
  RequestBody: string;
  ResponseJSON: TJSONObject;
  Choices: TJSONArray;
  MessageObj: TJSONObject;
  Stream: TStringStream;
begin
  Result := '';
  RequestBody := BuildJSONBody(Messages);
  Stream := TStringStream.Create(RequestBody, TEncoding.UTF8);
  try
    Response := FHttpClient.Post('https://api.openai.com/v1/chat/completions', Stream);

    if Response.StatusCode <> 200 then
      raise Exception.Create('Erro na API: ' + Response.StatusText + sLineBreak + Response.ContentAsString(TEncoding.UTF8));

    ResponseJSON := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8)) as TJSONObject;
    try
      Choices := ResponseJSON.GetValue<TJSONArray>('choices');
      if (Choices.Count > 0) then
      begin
        MessageObj := Choices.Items[0].GetValue<TJSONObject>('message');
        Result := MessageObj.GetValue<string>('content');
      end
      else
        Result := 'Nenhuma resposta gerada pela IA.';
    finally
      ResponseJSON.Free;
    end;
  finally
    Stream.Free;
  end;
end;

function FieldTypeToString(FieldType: TFieldType): string;
begin
  case FieldType of
    ftUnknown: Result := 'Unknown';
    ftString: Result := 'String';
    ftSmallint: Result := 'Smallint';
    ftInteger: Result := 'Integer';
    ftWord: Result := 'Word';
    ftBoolean: Result := 'Boolean';
    ftFloat: Result := 'Float';
    ftCurrency: Result := 'Currency';
    ftBCD: Result := 'BCD';
    ftDate: Result := 'Date';
    ftTime: Result := 'Time';
    ftDateTime: Result := 'DateTime';
    ftBytes: Result := 'Bytes';
    ftVarBytes: Result := 'VarBytes';
    ftAutoInc: Result := 'AutoInc';
    ftBlob: Result := 'Blob';
    ftMemo: Result := 'Memo';
    ftGraphic: Result := 'Graphic';
    ftCursor: Result := 'Cursor';
    ftFixedChar: Result := 'FixedChar';
    ftWideString: Result := 'WideString';
    ftLargeint: Result := 'Largeint';
    ftADT: Result := 'ADT';
    ftArray: Result := 'Array';
    ftReference: Result := 'Reference';
    ftDataSet: Result := 'DataSet';
    ftOraBlob: Result := 'OraBlob';
    ftOraClob: Result := 'OraClob';
    ftVariant: Result := 'Variant';
    ftInterface: Result := 'Interface';
    ftIDispatch: Result := 'IDispatch';
    ftGuid: Result := 'Guid';
    ftTimeStamp: Result := 'TimeStamp';
    ftFMTBcd: Result := 'FMTBCD';
    ftFixedWideChar: Result := 'FixedWideChar';
    ftWideMemo: Result := 'WideMemo';
    ftOraTimeStamp: Result := 'OraTimeStamp';
    ftOraInterval: Result := 'OraInterval';
    ftLongWord: Result := 'LongWord';
    ftShortint: Result := 'Shortint';
    ftByte: Result := 'Byte';
    ftExtended: Result := 'Extended';
    ftConnection: Result := 'Connection';
    ftParams: Result := 'Params';
    ftStream: Result := 'Stream';
    ftTimeStampOffset: Result := 'TimeStampOffset';
    ftObject: Result := 'Object';
    ftSingle: Result := 'Single';
  else
    Result := 'Desconhecido';
  end;
end;

function TOpenAIChat.GerarJSON(FDQuery:TRESTDWClientSQL; const Titulo, Descricao: string): string;
var
  i:Integer;
  JsonDados: TJSONArray;
  JsonPrincipal, JsonColunas, JsonLinha: TJSONObject;
begin
  JsonPrincipal := TJSONObject.Create;
  try
    // Adiciona metadados
    JsonPrincipal.AddPair('titulo', Titulo);
    JsonPrincipal.AddPair('descricao', Descricao);

    // Gera descrições automáticas dos campos
    JsonColunas := TJSONObject.Create;
    for i := 0 to FDQuery.FieldCount - 1 do
    begin
       JsonColunas.AddPair(FDQuery.Fields[i].FieldName,
       'Campo do tipo '+FieldTypeToString(FDQuery.Fields[i].DataType)+' que representa "'+FDQuery.Fields[i].DisplayLabel+'"');
    end;
    JsonPrincipal.AddPair('colunas', JsonColunas);

    // Converte dados da query
    JsonDados := TJSONArray.Create;
    FDQuery.First;
    while not FDQuery.Eof do
    begin
      JsonLinha := TJSONObject.Create;
      for i := 0 to FDQuery.FieldCount - 1 do
        JsonLinha.AddPair(FDQuery.Fields[i].FieldName, FDQuery.Fields[i].AsString);
      JsonDados.AddElement(JsonLinha);
      FDQuery.Next;
    end;
    JsonPrincipal.AddPair('dados', JsonDados);

    Result := JsonPrincipal.ToJSON;
  finally
    JsonPrincipal.Free;
  end;
end;

function TOpenAIChat.GerarSQL(const Pergunta: string):String;
var
   OpenAI:TOpenAIChat;
   Messages:TJSONArray;
   Prompt,TabelasEstrutura,JSONBody,Resposta:String;
begin
   TabelasEstrutura :=
    'Tabelas disponíveis (com campos e descrições):\n' +
    '- arqpedido (dados relativos às vendas) Campos: (IDFilial: ID da Filial, IDPed: ID do Pedido, Datped: Data/Hora, IDPess: ID do Cliente, IDVend: ID do Vendedor, TotDesc: Total de Desconto, TotPedido: Total do Pedido)\n' +
    '- arqpedidoite (dados relativos às vendas produto à produto) Campos: (IDFilial, IDPed, Nroite: Número do Item, IDProd: Produto, IDVend: Vendedor do Item, IndComi: Incide Comissão, '+
    'PrecoVen: Preço Tabela, PrecoFab: Preço Fábrica, CustoMed: Custo Médio, Qtdped: Qtde, PerDesc: % Desconto, VlrDesc: Valor Desconto, VlrVenda: Valor Venda com Desconto)\n' +
    '- arqproduto (Dados de produtos) Campos: (IDProd: Código, Despro: Descrição do Produto)\n' +
    '- arqpessoa (dados relativos à pessoas: clientes, vendedores, fornecedores) Campos: (IDPess: ID, Nome: Nome da Pessoa)\n' +
    '- arqprodutolot (Dados de estoque de produtos, separado por lotes) Campos: (IDFilial, IDProd, Nrolot: Número do Lote, IDPess: Fornecedor, Datfab: Fabricação, Datven: Vencimento, Qtdest: Estoque)\n\n' +
    'Chaves e relações:\n' +
    '* arqpedido.IDFilial + IDPed = arqpedidoite.IDFilial + IDPed\n' +
    '* arqpedido.IDPess = arqpessoa.IDPess (cliente)\n' +
    '* arqpedido.IDVend = arqpessoa.IDPess (vendedor)\n' +
    '* arqpedidoite.IDProd = arqproduto.IDProd\n' +
    '* arqprodutolot.IDProd = arqproduto.IDProd\n' +
    '* arqprodutolot.IDFilial + IDProd = arqpedidoite.IDFilial + IDProd';
   Prompt :=
   'Baseado na estrutura de tabelas abaixo, Retorne apenas a query em MySQL SQL. Nada mais, sem aspas ou caracteres especiais nem antes, '+
   'nem ao final da query e que só venham comandos e caracteres válidos, '+ sLineBreak +
   'INSTRUÇÕES ADICIONAIS:' + sLineBreak +
   '- Sempre que possível, filtre os dados para os últimos 12 meses usando o campo arqpedido.Datped.' + sLineBreak +
   '- Se a pergunta for ampla ou envolver muitas linhas, use LIMIT 50 ou agrupamento adequado para evitar excesso de dados.' + sLineBreak +
   '- Foque em gerar SQL que seja eficaz, otimizada e segura para uso em sistemas com limite de tokens.' + sLineBreak +
   'INSTRUÇÕES MUITO IMPORTANTE:' + sLineBreak +
   ' - Cada uma de suas respostas devem priorizar à consultas na base dados fornecida, pricipalente, como vendas, compras, estoque '+ sLineBreak +
   ' - Referencie os campo do MySQL sempre com alias para evitar ambiguides em campos com o mesmo nome em tabelas diferentes ' + sLineBreak +
   ' - Caso a pergunta ou solicitação recebida não caber ou não gerar SQL válido, retornar um "##ERROR##" e não gerar o SQL.'+ sLineBreak +
   'Os dados coletados dever ser usados diretamente em uma query que responda à seguinte solicitação:' + sLineBreak +
   Pergunta + sLineBreak + TabelasEstrutura;

   Messages := TJSONArray.Create;
   Messages.AddElement(CreateMessage('system', 'Você é um gerador de SQL especialista em MySQL. Apenas retorne a query MySQL, sem explicações.'));
   Messages.AddElement(CreateMessage('user', Prompt));

   //OpenAI := TOpenAIChat.Create;
   OpenAI := TOpenAIChat.Create('gpt-4o-mini');
   try
      Result := OpenAI.SendMessage(Messages);
   finally
      OpenAI.Free;
   end;
end;

function TOpenAIChat.ExecSQLToJSON(FDQuery: TRESTDWClientSQL; const SQL: string): string;
var
  OpenAI: TOpenAIChat;
begin
  FDQuery.Close;
  FDQuery.SQL.Text := SQL;
  FDQuery.Open;

  OpenAI := TOpenAIChat.Create;
  try
    Result := OpenAI.GerarJSON(
      FDQuery,
      'Resultado da consulta solicitada. ',
      'Este conjunto de dados foi gerado com base em uma solicitação do usuário e deve ser interpretado de forma resumida, '+
      'objetiva e sem repetições.'
    );
  finally
    OpenAI.Free;
  end;
end;

function TOpenAIChat.InterpretaIA(const JSONDados: string): string;
var
   OpenAI:TOpenAIChat;
   Messages:TJSONArray;
begin
   Messages := TJSONArray.Create;
   Messages.AddElement(CreateMessage('system',
   'Você é um analista de dados, experiente em vendas, finanças, estoque e gestão lojas de varejo, com enfase em farmácias. '+
   'Receberá uma tabela em JSON e deve responder com uma análise cursiva e resumida, sem repetir termos e focando em interpretação humana clara.'));
   Messages.AddElement(CreateMessage('user', 'Aqui estão os dados:' + sLineBreak + JSONDados));
   OpenAI := TOpenAIChat.Create('gpt-4o-mini');
   try
      Result := OpenAI.SendMessage(Messages);
   finally
      OpenAI.Free;
  end;
end;

end.

