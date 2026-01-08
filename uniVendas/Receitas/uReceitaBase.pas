unit uReceitaBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, Datasnap.DBClient, uDM, uConst, uPessoasCad, uBuscaPes;

type
  TFrmReceitaBase = class(TForm)
    cdArqSngpcLot: TClientDataSet;
    cdArqSngpcLotIDInvIni: TIntegerField;
    cdArqSngpcLotIDProd: TIntegerField;
    cdArqSngpcLotNrolot: TWideStringField;
    cdArqSngpcLotDatven: TDateTimeField;
    cdArqSngpcLotQtdest: TFloatField;
    cdArqSngpcLotQtdSel: TFloatField;
    dsArqSngpcLot: TDataSource;
    cdArqSngpcLotIDPess: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    recIncluindo: Boolean;
    recSNGPCObrVenda: Boolean; // Vem da Configuração SNGPC -> 04-SNGPC Obrigatorio Na Venda (Desmarcado) não valida nada
    //
    recDatVen: TDateTime;
    recDatPresc: TDateTime;
    //
    recIDPessMed: Integer;
    recNommed: String;
    recNroRegProf: String;
    recConRegProf: String;
    recEstRegProf: String;
    recNroRec: String;
    recUfpac: String;
    recIdade: Integer;
    recSexo: String;
    recUsoRece: String;
    recUsoProlog: String; // '0'-Sim '1'-Não
    recUsoMed: String;    // H-Humano / V-Veterinário
    //
    recIDPac: Integer;
    recNomepac: String;
    recEndpac: String;
    recCidpac: String;
    recTelpac: String;
    recUnidadeIdade: String; // '1'-Anos  '2'-Meses
    recIdadePac: Integer;    // Idade do Paciente
    //
    recRgpac: String;
    recSspac: String;
    //
    recTipDocComp: String; // '1 RG - Registro Geral / 2 CPF - Cadastro de Pessoa Física / 3 PASS - Passaporte
                           // '4 CNH - Carteira Nacional de Habilitação / 5 RNE - Registro Nacional de Estrangeiro
                           // '6 TIT - Título de Eleitor / 7 CTPS - Carteira de Trabalho e Previdência Social
                           // '8 CC - Carteira de Conselho (Ex: CRM, CFF, etc.) / '99 OUTROS - Outros Documentos
    recNumDocComp: String;
    recOrgExpComp: String;
    recUFEmiComp: String;
    //
    recIDFilial: Integer;
    recIDInvIni: Integer;
    recIDProd: Integer;
    recDespro: String;
    recDesSubs: String;
    recQtdped: Double;
    // Configuração - Validade Dias do Tipo da Receita
    recValDias: Integer;
  end;

var
  FrmReceitaBase: TFrmReceitaBase;

implementation

{$R *.dfm}

end.
