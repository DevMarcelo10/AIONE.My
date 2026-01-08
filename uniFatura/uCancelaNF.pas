unit uCancelaNF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDEdit,
  LMDCustomLabel, LMDLabel, LMDControl, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, DB,
  LMDSimplePanel, LMDButtonControl, LMDRadioButton, LMDBaseEdit, LMDCustomEdit, AdvGlowButton,
  MarcLib;

type
  TFrmCancNF = class(TForm)
    LMDSimplePanel10: TLMDSimplePanel;
    LMDSimplePanel11: TLMDSimplePanel;
    LMDLabel15: TLMDLabel;
    LMDLabel29: TLMDLabel;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    btFechar: TAdvGlowButton;
    lbMensagem: TLMDLabel;
    btCancelaNF: TAdvGlowButton;
    edJustifica: TLMDEdit;
    procedure btCancelaNFClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    ArqResp:TSearchRec;
  public
    { Public declarations }
  end;

var
  FrmCancNF: TFrmCancNF;

implementation

{$R *.dfm}

uses uDM, uLibFarm;

procedure TFrmCancNF.FormShow(Sender: TObject);
begin
   edJustifica.SetFocus;
end;

procedure TFrmCancNF.btCancelaNFClick(Sender: TObject);
var
   vErro:String;
   ResulCan:Boolean;
   DWParams:TDWParams;
begin
   if Length(AllTrim(edJustifica.Text)) < 15 then
   begin
      MessageDlg('A justificativa deve ter o mínimo de 15 caracteres!', mtWarning, [mbOk], 0);
      edJustifica.SetFocus;
      Exit;
   end; //if
   if MessageDlg('Tem certeza que deseja cancelar CANCELAR NFe?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Close;

   lbMensagem.Caption := 'Aguardando retorno do SEFAZ/MG';
   Application.ProcessMessages;

   DWParams := TDWParams.Create;
   try
      try
         DM.DWClientEvents.CreateDWParams('CancelaNFe', DWParams);
         DWParams.ItemsString['IDEmp'].AsInteger    := TabNofi.FieldByName('IDEmp').AsInteger;
         DWParams.ItemsString['ChaveNF'].AsString   := TabNofi.FieldByName('ChaveNF').AsString;
         DWParams.ItemsString['NroProto'].AsString  := TabNofi.FieldByName('NroProto').AsString;
         DWParams.ItemsString['Justifica'].AsString := AllTrim(edJustifica.Text);
         DWParams.ItemsString['NroInul'].AsString   := '';
         DM.DWClientEvents.SendEvent('CancelaNFe',DWParams,vErro);
         if vErro <> '' then raise Exception.Create(vErro);
         ResulCan := DWParams.ItemsString['Result'].AsBoolean;
      except
         ResulCan := False;
      end;
   finally
      DWParams.Free;
   end;

   lbMensagem.Visible  := False;
   lbMensagem.Caption  := '';
   Application.ProcessMessages;

   if ResulCan then
   begin
      MessageDlg('Cancelamento homologado com sucesso!', mtInformation, [mbOk], 0);
      if not (TabNofi.State in dsEditModes) then TabNofi.Edit;
      QueAuxi := TRESTDWClientSQL.Create(nil);
      try
         with QueAuxi do
         begin
            DataBase := DM.RESTDWDataBase;
            SQL.Text := 'UPDATE arqnofi SET Indcan = "S" WHERE IDNota = '+TabNofi.FieldByName('IDNota').AsString+';';
            if TabNofi.FieldByName('Docori').AsString = 'PEVE' then
               SQL.Add('UPDATE arqpeve SET '+iif(TabNofi.FieldByName('Codpes').AsInteger = 0,'Nronot','Nronot2')+' = 0 WHERE Nroped = '+TabNofi.FieldByName('Nroori').AsString+';')
            else if TabNofi.FieldByName('Docori').AsString = 'DEVO' then SQL.Add('UPDATE arqdevo SET Nronot = 0 WHERE Nroped = '+TabNofi.FieldByName('Nroori').AsString+';');
            ExecSQL;
         end; //with
      finally
         FreeAndNil(QueAuxi);
      end;
      TabNofi.Close;
      TabNofi.Open;
      Self.Close;
   end else
   begin
      btCancelaNF.Visible := True;
      MessageDlg('Não foi possível cancelar NFe!', mtError, [mbOk], 0);
   end;
end;

procedure TFrmCancNF.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCancNF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   FrmCancNF := nil;
end;

end.
