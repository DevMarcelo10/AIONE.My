unit uDM;
//TDMServer.RESTDWPoolerDB
interface

uses
   SysUtils, System.Classes, Dialogs, Forms, Vcl.Controls, Data.DB,
   System.Variants, DateUtil, Windows, System.Types, ACBrBase, MarcLib,
   System.ImageList, Vcl.ImgList, spdNFe, ACBrBoleto, LMDCustomImageList,
   LMDImageList, spdNFCeDataSets, ACBrDFe, ACBrNFe, spdNFCe, spdNFeDataSets,
   System.IniFiles, FireDAC.Stan.Intf,  FireDAC.Stan.Option, FireDAC.Stan.Error,
   FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
   FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
   FireDAC.Phys.Intf, spdNFCeType, FireDAC.Phys.MySQLDef, System.Contnrs,
   uRESTDWAbout, uRESTDWBasicDB, uRESTDWIdBase, uRESTDWServerEvents, uRESTDWBasic,
   uRESTDWComponentBase;

type
  TDM = class(TDataModule)
    DWDataBase: TRESTDWIdDatabase;
    RESTClientPooler: TRESTDWIdClientPooler;
    DWClientEvents: TRESTDWClientEvents;
    ImagePBM: TImageList;
    ImageListRec: TLMDImageList;
    spdNFCeDS: TspdNFCeDataSets;
    spdNFCe: TspdNFCe;
    spdNFe: TspdNFe;
    spdNFeDS: TspdNFeDataSets;
    ACBrNFe: TACBrNFe;
    ImagesGer: TImageList;
    RESTClientAIONE: TRESTDWIdClientPooler;
    DWClientAIONE: TRESTDWClientEvents;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure RESTClientPoolerBeforeExecute(ASender: TObject);
    procedure RESTClientAIONEBeforeExecute(ASender: TObject);
  private
    procedure CriaConfig;
    procedure LerConfig;
    { Private declarations }
  public
    { Public declarations }
     DownNewVersao:Boolean;
  end;

var
   DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses uConfgIni, uLibFarm, uConst;

procedure TDM.DataModuleCreate(Sender: TObject);
var
   Handle:Thandle;
   QueAuxi:TRESTDWClientSQL;
begin
   Handle := FindWindow('TFrmPrincipal', nil);
   if Handle <> 0 then
   begin
      MostraMsg('Aviso','Aplicação já está aberta!', mtInformation, [mbOk]);
      Application.Terminate;
   end;

   PathExe  := ExtractFileDir(Application.ExeName)+'\';
   PastaLog := PathExe+'doc\';
   if not DirectoryExists(PastaLog) then CreateDir(PastaLog);
   if not FileExists(PathExe+'config.ini') then CriaConfig;
   LerConfig;

//--> NESSE PONTO: ATIVAR O uVeChaves  <<<<<<<

   RESTClientPooler.Host    := IPRemoto;
   DWDataBase.PoolerService := IPRemoto;
   DataServer := VeDataServer;

   QueAuxi := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase := DWDataBase;
   try
      try
         QueAuxi.SQL.Text := 'SELECT * FROM arqparametros LIMIT 1';
         QueAuxi.Open;
         with EMPRESA,QueAuxi do
         begin
            CNPJ     := FieldByName('CNPJFar').AsString.Trim;
            RAZAO    := FieldByName('Nomefar').AsString.Trim;
            INSEST   := FieldByName('InsEstFar').AsString.Trim;
            ENDERECO := FieldByName('Endfar').AsString.Trim;
            NROEND   := FieldByName('NroEnt').AsString.Trim;
            COMPEND  := FieldByName('CompEnd').AsString.Trim;
            BAIRRO   := FieldByName('Baifar').AsString.Trim;
            CODMUN   := FieldByName('Codmun').AsString.Trim;
            CIDADE   := FieldByName('Nommun').AsString.Trim;
            UF       := FieldByName('Estmun').AsString.Trim;
            CEP      := FieldByName('Cepfar').AsString.Trim;
         end; //with
         FILIAL := QueAuxi.FieldByName('IDFilial').AsInteger;
      except
         on E:Exception do
         begin
            MessageDlg('Não foi possível ler os parâmetros da Farmácia!', mtInformation, [mbOk], 0);
            SalvaLog(USUARIO, PastaLog, '[ERRO] Ao abir o aplicativo, Não foi possível ler os parâmetros da Farmácia -> '+E.Message);
            DWDataBase.Active := False;
            Application.Terminate;
            Exit;
         end;
      end;
   finally
      QueAuxi.Close;
      FreeAndNil(QueAuxi);
   end;

end;

procedure TDM.CriaConfig;
var
   ConfigManager: TConfigManager;
begin
   ConfigManager := TConfigManager.Create(PathExe+'config.ini');
   try
      ConfigManager.SaveConfig('localhost',PortaRemoto);
   finally
      ConfigManager.Free;
   end;
end;

procedure TDM.LerConfig;
var
   ConfigManager:TConfigManager;
begin
   ConfigManager := TConfigManager.Create(PathExe+'config.ini');
   try
      ConfigManager.LoadConfig(IPRemoto,PortaRemoto);
   finally
      ConfigManager.Free;
   end;
end;

procedure TDM.RESTClientPoolerBeforeExecute(ASender: TObject);
begin
   RESTClientPooler.Host := IPRemoto;
end;

procedure TDM.RESTClientAIONEBeforeExecute(ASender: TObject);
begin
   RESTClientPooler.Host := IPAIONE;
end;


procedure TDM.DataModuleDestroy(Sender: TObject);
begin
   DWDataBase.Close;
end;

end.

