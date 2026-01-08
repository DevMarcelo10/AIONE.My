unit uTabConfigRecCtl;

interface

uses
  System.SysUtils, System.Generics.Collections, uLibFarm, uRESTDWBasicDB, uRESTDWIdBase;

type
  TReceitaInfo = record    // Estrutura para armazenar a configuração tipo de receita e Validade Dias
    UsoRece: string;
    IDRece: Integer;
    DesRece: string;
    ValDia: Integer;
  end;

  TTabConfigRecCtl = class
  private
    ListaRecCtl: TList<TReceitaInfo>;
    procedure Adicionar(UsoRece: String; IDRece: Integer; DesRece: String; ValDia: Integer);
  public
    IDInvIni: Integer;       // Código do Inventário Confirmado para transações
    // Configurações do SNGPC
    ControleSNGPC: Boolean;  // *** 01-Controle de SNGPC
    CadComCom: Boolean;      //     02-Cadastro de Comprador Completo
    SNGPCObrCompra: Boolean; //     03-SNGPC Obrigatorio Na compra
    SNGPCObrVenda: Boolean;  // *** 04-SNGPC Obrigatorio Na Venda
    InfQuanPreRec: Boolean;  //     05-Informar Quantidade Prescrita Na Receita
    ConInsMan: Boolean;      //     06-Controle de Insumos Manipulação (Para Integração com outros Sistemas)
    CadObrVenSNGPC: Boolean; // *** 07-Cadastro Obrigatorio Em Vendas SNGPC
    SNGPCObrPerPro: Boolean; //     08-SNGPC Obrigatorio Em Perdas de Produtos
    TipoCerDig: Boolean;     // *** 09-Solicitar Confirmação do Farmaceutico
    ImpEtiRecSNGPC: Boolean; // *** 10-Imprimir Etiqueta de Receita SNGPC

    constructor Create;
    destructor Destroy; override;
    function Existe(UsoRece: String): Boolean;
    function ValDias(UsoRece: String): Integer;
    procedure Limpar;
    procedure Carrega(dwDataBase: TRESTDWIdDatabase; idFilial: Integer);
    function InventarioConfirmado(dwDataBase: TRESTDWIdDatabase; idFilial: Integer): Boolean;
  end;

implementation

constructor TTabConfigRecCtl.Create;
begin
  inherited;
  ListaRecCtl := TList<TReceitaInfo>.Create;
end;

destructor TTabConfigRecCtl.Destroy;
begin
  ListaRecCtl.Free;
  inherited;
end;

procedure TTabConfigRecCtl.Limpar;
begin
  ListaRecCtl.Clear;
end;

procedure TTabConfigRecCtl.Adicionar(UsoRece: String; IDRece: Integer; DesRece: String; ValDia: Integer);
var
  Info: TReceitaInfo;
begin
  Info.UsoRece := UsoRece;
  Info.IDRece := IDRece;
  Info.DesRece := DesRece;
  Info.ValDia := ValDia;
  ListaRecCtl.Add(Info);
end;

function TTabConfigRecCtl.Existe(UsoRece: String): Boolean;
var
  Info: TReceitaInfo;
begin
  Result := False;
  for Info in ListaRecCtl do
    if SameText(Info.UsoRece, UsoRece) then
      Exit(True);
end;

function TTabConfigRecCtl.ValDias(UsoRece: String): Integer;
var
  Info: TReceitaInfo;
begin
  Result := 0;
  for Info in ListaRecCtl do
    if SameText(Info.UsoRece, UsoRece) then
      Exit(Info.ValDia);
end;

procedure TTabConfigRecCtl.Carrega(dwDataBase: TRESTDWIdDatabase; idFilial: Integer);
var
  Query: TRESTDWClientSQL;
begin
   Query := TRESTDWClientSQL.Create(nil);
   Query.DataBase := dwDataBase;

   Query.SQL.Text :=  'SELECT PAR.CNPJFar, PAR.IDFilial, ' +
   'ControleSNGPC, CadComCom, SNGPCObrCompra, SNGPCObrVenda, InfQuanPreRec, ConInsMan, ' +
   'CadObrVenSNGPC, SNGPCObrPerPro, TipoCerDig, ImpEtiRecSNGPC, ' +
   'PAR.ReceitaA1, PAR.ReceitaA2, PAR.ReceitaA3, PAR.ReceitaAM, PAR.ReceitaB1, PAR.ReceitaB2, ' +
   'PAR.ReceitaC1, PAR.ReceitaC2, PAR.ReceitaC3, PAR.ReceitaC4, PAR.ReceitaC5, PAR.ReceitaD1, PAR.ValDiaA1, PAR.ValDiaA2, ' +
   'PAR.ValDiaA3, PAR.ValDiaAM, PAR.ValDiaB1, PAR.ValDiaB2, PAR.ValDiaC1, PAR.ValDiaC2, PAR.ValDiaC3, ' +
   'PAR.ValDiaC4, PAR.ValDiaC5, PAR.ValDiaD1, A1.DesRece AS DesReceA1, ' +
   'A2.DesRece AS DesReceA2, A3.DesRece AS DesReceA3, AM.DesRece AS DesReceAM, B1.DesRece AS DesReceB1, ' +
   'B2.DesRece AS DesReceB2, C1.DesRece AS DesReceC1, C2.DesRece AS DesReceC2, C3.DesRece AS DesReceC3, ' +
   'C4.DesRece AS DesReceC4, C5.DesRece AS DesReceC5, D1.DesRece AS DesReceD1 FROM arqparametros PAR ' +
   'LEFT JOIN arqreceitas A1 ON A1.IDRece = PAR.ReceitaA1 ' +
   'LEFT JOIN arqreceitas A2 ON A2.IDRece = PAR.ReceitaA2 ' +
   'LEFT JOIN arqreceitas A3 ON A3.IDRece = PAR.ReceitaA3 ' +
   'LEFT JOIN arqreceitas AM ON AM.IDRece = PAR.ReceitaAM ' +
   'LEFT JOIN arqreceitas B1 ON B1.IDRece = PAR.ReceitaB1 ' +
   'LEFT JOIN arqreceitas B2 ON B2.IDRece = PAR.ReceitaB2 ' +
   'LEFT JOIN arqreceitas C1 ON C1.IDRece = PAR.ReceitaC1 ' +
   'LEFT JOIN arqreceitas C2 ON C2.IDRece = PAR.ReceitaC2 ' +
   'LEFT JOIN arqreceitas C3 ON C3.IDRece = PAR.ReceitaC3 ' +
   'LEFT JOIN arqreceitas C4 ON C4.IDRece = PAR.ReceitaC4 ' +
   'LEFT JOIN arqreceitas C5 ON C5.IDRece = PAR.ReceitaC5 ' +
   'LEFT JOIN arqreceitas D1 ON D1.IDRece = PAR.ReceitaD1 ' +
   'WHERE PAR.IDFilial = ' + idFilial.ToString;
   with Query do
   begin
     Open;
     if not IsEmpty then
     begin
       ControleSNGPC := FieldByname('ControleSNGPC').AsBoolean;
       CadComCom     := FieldByname('CadComCom').AsBoolean;
       SNGPCObrCompra:= FieldByname('SNGPCObrCompra').AsBoolean;
       SNGPCObrVenda := FieldByname('SNGPCObrVenda').AsBoolean;
       InfQuanPreRec := FieldByname('InfQuanPreRec').AsBoolean;
       ConInsMan     := FieldByname('ConInsMan').AsBoolean;
       CadObrVenSNGPC:= FieldByname('CadObrVenSNGPC').AsBoolean;
       SNGPCObrPerPro:= FieldByname('SNGPCObrPerPro').AsBoolean;
       TipoCerDig    := FieldByname('TipoCerDig').AsBoolean;
       ImpEtiRecSNGPC:= FieldByname('ImpEtiRecSNGPC').AsBoolean;

       Adicionar('A1',FieldByname('ReceitaA1').AsInteger,FieldByname('DesReceA1').AsString,FieldByname('ValDiaA1').AsInteger);
       Adicionar('A2',FieldByname('ReceitaA2').AsInteger,FieldByname('DesReceA2').AsString,FieldByname('ValDiaA2').AsInteger);
       Adicionar('A3',FieldByname('ReceitaA3').AsInteger,FieldByname('DesReceA3').AsString,FieldByname('ValDiaA3').AsInteger);
       Adicionar('AM',FieldByname('ReceitaAM').AsInteger,FieldByname('DesReceAM').AsString,FieldByname('ValDiaAM').AsInteger);
       Adicionar('B1',FieldByname('ReceitaB1').AsInteger,FieldByname('DesReceB1').AsString,FieldByname('ValDiaB1').AsInteger);
       Adicionar('B2',FieldByname('ReceitaB2').AsInteger,FieldByname('DesReceB2').AsString,FieldByname('ValDiaB2').AsInteger);
       Adicionar('C1',FieldByname('ReceitaC1').AsInteger,FieldByname('DesReceC1').AsString,FieldByname('ValDiaC1').AsInteger);
       Adicionar('C2',FieldByname('ReceitaC2').AsInteger,FieldByname('DesReceC2').AsString,FieldByname('ValDiaC2').AsInteger);
       Adicionar('C3',FieldByname('ReceitaC3').AsInteger,FieldByname('DesReceC3').AsString,FieldByname('ValDiaC3').AsInteger);
       Adicionar('C4',FieldByname('ReceitaC4').AsInteger,FieldByname('DesReceC4').AsString,FieldByname('ValDiaC4').AsInteger);
       Adicionar('C5',FieldByname('ReceitaC5').AsInteger,FieldByname('DesReceC5').AsString,FieldByname('ValDiaC5').AsInteger);
       Adicionar('D1',FieldByname('ReceitaD1').AsInteger,FieldByname('DesReceD1').AsString,FieldByname('ValDiaD1').AsInteger);
     end;
     Close;
   end;
   Query.Free;
end;

function TTabConfigRecCtl.InventarioConfirmado(dwDataBase: TRESTDWIdDatabase; idFilial: Integer): Boolean;
var
  qry: TRESTDWClientSQL;
  idStatus: Integer;
begin
  Result:= False;

  // Status Inventário SNGPC
  // IndFecha = (0 - Aberto   1 - Confirmado    2 - Encerrado)
  idStatus:= 1;
  Self.IDInvIni:= 0; // Código do Inventário Atual

  try
    qry:= CreateSQL(dwDataBase,
                 'SELECT IDFilial, IDInvIni, IDPess, DataAbe, MailSNGPC, IndFecha FROM arqsngpcinve ' +
                 'where IDFilial = :idFilial ' +
                 'AND IndFecha   = :IdStatus ' ,
                 [idFilial.ToString, idStatus.ToString]);
    qry.Open;
    if not qry.IsEmpty then
    begin
      Result:= True;

      Self.IDInvIni:= qry.FieldByName('IDInvIni').AsInteger;
    end;
    qry.Close;
  finally
    qry.Free;
  end;
end;

end.
