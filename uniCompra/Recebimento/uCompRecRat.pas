unit uCompRecRat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvGlowButton,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
  LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel,
  LMDBaseEdit, LMDCustomEdit, LMDDBEdit, uRESTDWBasicDB, uWaitForm, MarcLib, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uRESTDWBasicTypes;

type
  TFrmCompRecRat = class(TForm)
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    btFechar: TAdvGlowButton;
    LMDSimplePanel2: TLMDSimplePanel;
    edDesAce: TLMDDBLabeledEdit;
    edDesAsso: TLMDDBLabeledEdit;
    edVlrJur: TLMDDBLabeledEdit;
    edVlrMul: TLMDDBLabeledEdit;
    edPerMul: TLMDDBLabeledEdit;
    edPerJur: TLMDDBLabeledEdit;
    SouTitulo: TDataSource;
    LMDSimplePanel3: TLMDSimplePanel;
    btConfirma: TAdvGlowButton;
    TabTitu: TRESTDWClientSQL;
    TabTituIDTitu: TIntegerField;
    TabTituIDPess: TIntegerField;
    TabTituNotFis: TIntegerField;
    TabTituNroSerie: TIntegerField;
    TabTituNrotit: TWideStringField;
    TabTituDestit: TWideStringField;
    TabTituPagRec: TWideStringField;
    TabTituIDTiptit: TIntegerField;
    TabTituDatemi: TDateField;
    TabTituDatven: TDateField;
    TabTituDesAsso: TFloatField;
    TabTituVlrAces: TFloatField;
    TabTituVlrDevo: TFloatField;
    TabTituVlrtit: TFloatField;
    TabTituSaltit: TFloatField;
    TabTituHistit: TWideStringField;
    TabTituIDFilial: TIntegerField;
    TabTituIDPed: TIntegerField;
    TabTituIDNatFin: TIntegerField;
    TabTituIDConv: TIntegerField;
    TabTituCodBarra: TWideStringField;
    TabTituIndSel: TWideStringField;
    TabTituIndEnvBco: TWideStringField;
    TabTituNossoNro: TWideStringField;
    TabTituCodRec: TIntegerField;
    TabTituNumReferencia: TWideStringField;
    TabTituDatCompApur: TDateField;
    TabTituValorJuros: TFloatField;
    TabTituValorMulta: TFloatField;
    TabTituPercenJuros: TFloatField;
    TabTituPercenMulta: TFloatField;
    TabTituChavePIXQRCode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure edDesAceKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    recIDTitu:Integer;
  end;

var
  FrmCompRecRat: TFrmCompRecRat;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm;

procedure TFrmCompRecRat.FormShow(Sender: TObject);
begin
   TabTitu.ParamByName('IDTitu').AsInteger := recIDTitu;
   TabTitu.Open;
   edDesAce.SetFocus;
end;

procedure TFrmCompRecRat.btConfirmaClick(Sender: TObject);
var
   vErro:String;
   AuxTotTit:Double;
   auxDespes,auxDescon,auxSaltit:Double;
   QueAuxi,QueGrava,QueParam:TRESTDWClientSQL;
begin
   if (TabTituVlrAces.AsFloat <= 0.00)    and (TabTituDesAsso.AsFloat <= 0.00) and
      (TabTituValorJuros.AsFloat <= 0.00) and (TabTituValorMulta.AsFloat <= 0.00) then Exit;

   TabTitu.Post;

   QueAuxi  := TRESTDWClientSQL.Create(nil);
   QueGrava := TRESTDWClientSQL.Create(nil);
   QueParam := TRESTDWClientSQL.Create(nil);
   QueAuxi.DataBase  := DM.DWDataBase;
   QueGrava.DataBase := DM.DWDataBase;
   QueParam.DataBase := DM.DWDataBase;

   ShowWait('Aguarde...', Self);
   try
      try
         if not (TabTitu.State in dsEditModes) then TabTitu.Edit;
         auxSaltit := TabTituVlrtit.AsFloat + TabTituVlrAces.AsFloat - TabTituDesAsso.AsFloat;
         TabTituSaltit.AsFloat := auxSaltit;
         TabTitu.Post;
         auxDespes := TabTituVlrAces.AsFloat;
         auxDescon := TabTituDesAsso.AsFloat;
      except
         on E:Exception do
         begin
            HideWait;
            SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar as alterações em arqtitulotemp (uCompRecRat) -> '+E.Message);
            MostraMsg('Erro','Não foi possível executar rateio.'+#10+E.Message, mtError, [mbOk]);
            Exit;
         end;
      end;

      QueParam.SQL.Text := 'SELECT * FROM arqparametros';
      QueParam.Open;
      QueAuxi.SQL.Text  := 'SELECT * FROM arqtitulorattemp WHERE IDTitu = '+TabTituIDTitu.AsString+' AND RatFixo = 1';
      QueAuxi.Open;
      QueAuxi.First;

      // Grava Rateio Despesas Acessórias //
      if QueAuxi.Locate('IDNatFin;OrigTitu', VarArrayOf([QueParam.FieldByName('IDNatFinDesAce').AsString,'1']),[]) then
      begin
         if auxDespes <> QueAuxi.FieldByName('ValorRat').AsFloat then
         begin
            try
               QueGrava.Close;
               QueGrava.SQL.Text := 'UPDATE arqtitulorattemp'+
               ' SET ValorRat = '+ FormatDouble(auxDespes,11,2)+' WHERE'+
               ' IDTitu = '+TabTituIDTitu.AsString+' AND IDNatFin = '+QueAuxi.FieldByName('IDNatFin').AsString+
               ' AND OrigTitu = 1 AND RatFixo = 1';
               QueGrava.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            except
               on E:Exception do
               begin
                  HideWait;
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar a alteração das Despesas Acessórias em arqtitulorattemp em uCompRecRat -> '+E.Message);
                  MostraMsg('Erro','Não foi possível concluir o rateio.'+#10+E.Message, mtError, [mbOk]);
                  Exit;
               end;
            end;
         end; //if
      end else
      begin
         if auxDespes > 0 then
         begin
            try
               QueGrava.Close;
               QueGrava.SQL.Text := 'INSERT INTO arqtitulorattemp (IDTitu,IDNatFin,OrigTitu,ValorRat,RatFixo) VALUES ('+
               TabTituIDTitu.AsString+','+
               QueParam.FieldByName('IDNatFinDesAce').AsString+','+
               Aspas('1')+','+
               FormatDouble(auxDespes,11,2)+','+
               Aspas('1')+')';
               QueGrava.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            except
               on E:Exception do
               begin
                  HideWait;
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar a iclusão das Despesas Acessórias em arqtitulorattemp (uCompRecRat) -> '+E.Message);
                  MostraMsg('Erro','Não foi possível incluir.'+#10+E.Message, mtError, [mbOk]);
                  Exit;
               end;
            end;
         end; //if
      end; //if

      // --- Grava Rateio Descontos Associados --- //
      if QueAuxi.Locate('IDNatFin;OrigTitu', VarArrayOf([QueParam.FieldByName('IDNatFinDesAsso').AsString,'1']),[]) then
      begin
         if auxDescon <> QueAuxi.FieldByName('ValorRat').AsFloat then
         begin
            try
               QueGrava.Close;
               QueGrava.SQL.Text := 'UPDATE arqtitulorattemp'+
               'SET ValorRat = '+FormatDouble(auxDescon,11,2)+
               ' WHERE IDTitu = '+TabTituIDTitu.AsString+' AND IDNatFin = '+QueAuxi.FieldByName('IDNatFin').AsString+
               ' AND OrigTitu = 1 AND RatFixo = 1';
               QueGrava.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            except
               on E:Exception do
               begin
                  HideWait;
                  SalvaLog(USUARIO, PastaLog, 'ERRO Não foi possível salvar a alteração do Desconto Associado em arqtitulorattemp (uCompRecRat) -> '+E.Message);
                  MostraMsg('Erro','Não foi possível alterar.'+#10+E.Message, mtError, [mbOk]);
                  Exit;
               end;
            end;
         end; //if
      end else
      begin
         if auxDescon > 0 then
         begin
            try
               QueGrava.Close;
               QueGrava.SQL.Text := 'INSERT INTO arqtitulorattemp (IDTitu,IDNatFin,OrigTitu,ValorRat,RatFixo) VALUES ('+
               TabTituIDTitu.AsString+','+
               QueParam.FieldByName('IDNatFinDesAsso').AsString+','+
               Aspas('1')+','+
               FormatDouble(auxDescon,11,2)+','+
               Aspas('1')+')';
               QueGrava.ExecSQL(vErro);
               if vErro <> '' then Raise Exception.Create(vErro);
            except
               on E:Exception do
               begin
                  HideWait;
                  SalvaLog(USUARIO, PastaLog, '[ERRO] Não foi possível salvar a inclusão do Desconto Associado em arqtitulorattemp (uCompRecRat) -> '+E.Message);
                  MostraMsg('Erro','Não foi possível incluir.'+#10+E.Message, mtError, [mbOk]);
                  Exit;
               end;
            end;
         end; //if
      end; //if
   finally
      QueAuxi.Close;
      QueGrava.Close;
      QueParam.Close;
      FreeAndNil(QueAuxi);
      FreeAndNil(QueGrava);
      FreeAndNil(QueParam);
      HideWait;
   end;
   Close;
end;

procedure TFrmCompRecRat.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCompRecRat.edDesAceKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = '-' then Key := #0;
end;

end.
