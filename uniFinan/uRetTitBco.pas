unit uRetTitBco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, LMDControl, LMDCustomControl, Marclib, Vcl.Graphics,
  LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel, Vcl.StdCtrls, uRESTDWBasicDB,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
  AdvGlowButton, LMDCustomComponent, LMDVistaDialogs, ACBrBase, ACBrPagFor,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls, AdvCGrid, AdvUtil;

type
  TFrmRetTitBco = class(TForm)
    LMDSimplePanel2: TLMDSimplePanel;
    LMDFileOpenDialog1: TLMDFileOpenDialog;
    ACBrPagFor1: TACBrPagFor;
    OpenDialog1: TOpenDialog;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    btFechar: TAdvGlowButton;
    btEnviaBco: TAdvGlowButton;
    cgDados: TAdvColumnGrid;
    AdvGlowButton1: TAdvGlowButton;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    LMDLabel4: TLMDLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFecharClick(Sender: TObject);
    procedure btRetornoBcoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btEnviaBcoClick(Sender: TObject);
  private
     Caminho,CamNomeArq,DestinoArq: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRetTitBco: TFrmRetTitBco;

implementation

{$R *.dfm}

uses uDM, uConst, uLibFarm, ACBrPagForConversao;

procedure TFrmRetTitBco.btEnviaBcoClick(Sender: TObject);
var
   AuxNome,AuxCPFCNPJ,AuxDoc,AuxCodPes,AuxCodBar,NomeArq: String;
   AuxDatVen:TDatetime;
   AuxIdTitu,i,NroBaiAux,AuxEnvBco: Integer;
   QuePes,QueTitu,QueAuxi: TRESTDWClientSQL;
   BaiConDeb,BaiConCre,vErro: String;
   SalTitAux,AuxVal,TotPagSalva:Double;
   AuxDatPag: TDateTime;
begin
   if MostraMsg('Confirmação','Confirma baixa destes títulos do arquivo?', mtConfirmation,[mbYes, mbNo]) = mrNo then Exit;

   if not Ping(IPRemoto,PortaRemoto) then
   begin
      SalvaLog(USUARIO, PastaLog, 'uTituloBai -> Perda de conexão com o servidor');
      MostraMsg('Erro','Perda de conexão com o servidor!',mtError, [mbOk]);
      Exit;
   end; //if
   QuePes  := TRESTDWClientSQL.Create(nil);
   QueTitu := TRESTDWClientSQL.Create(nil);
   QueAuxi := TRESTDWClientSQL.Create(nil);
   try
      QuePes.DataBase  := DM.DWDataBase;
      QueTitu.DataBase := DM.DWDataBase;
      QueAuxi.DataBase := DM.DWDataBase;
      i := 1;
      while i < cgDados.rowcount do
      begin
         AuxNome := cgDados.Cells[0, i];
         AuxCPFCNPJ := cgDados.Cells[1, i];
         AuxDoc := cgDados.cells[2, i];
         AuxVal := StrToFloat(cgDados.cells[3, i]);
         AuxDatPag := StrToDate(cgDados.cells[4, i]);
         AuxCodBar := cgDados.cells[6, i];
         AuxDatVen := StrToDate(cgDados.cells[7, i]);
         if AuxCPFCNPJ <> '' then
         begin
            QuePes.Close;
            QuePes.SQL.Clear;
            QuePes.SQL.Text := 'SELECT * FROM arqpessoa WHERE CpfCnpjPes = ' + Aspas(AuxCPFCNPJ);
            QuePes.Open;
            if QuePes.IsEmpty then
            begin
               MostraMsg('Aviso','Não foi encontrado fornecedor ' +AuxNome+ '  CPF/CNPJ ' +AuxCPFCNPJ+ '!',mtWarning, [mbOk]);
               Inc(i,1);
               Continue;
            end; // if
            AuxCodPes := QuePes.FieldByName('IDPess').AsString;
         end;
         QueTitu.Close;
         QueTitu.SQL.Clear;
         if AuxDoc = '' then
         begin
            QueTitu.SQL.Text :=
            'SELECT TIT.*,NAT.Desnat,NAT.CodconDebPro,NAT.CodconCrePro,NAT.CodconDebBai,NAT.CodconCreBai,FIL.Nomfil FROM arqtitulo TIT '+
            'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '+
            'LEFT JOIN arqnatfin NAT ON TIT.IDNatfin = NAT.IDNatfin '+
            'WHERE IDPess = '+AuxCodPes+ ' AND Datven = ' +Aspas(FormatDateTime('yyyy-mm-dd',AuxDatVen))+ ' AND Saltit = '+FormatDouble(AuxVal,11,2);
         end
         else if AuxCPFCNPJ = '' then
         begin
            QueTitu.SQL.Text :=
            'SELECT TIT.*,NAT.Desnat,NAT.CodconDebPro,NAT.CodconCrePro,NAT.CodconDebBai,NAT.CodconCreBai,'+
            'FIL.Nomfil FROM arqtitulo TIT '+
            'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '+
            'LEFT JOIN arqnatfin NAT ON TIT.IDNatfin = NAT.IDNatfin '+
            'WHERE CodBarra = '+AuxCodBar+ ' AND Nrotit = ' +AuxDoc+ ' AND Saltit = '+FormatDouble(AuxVal,11,2);
         end else
         begin
            QueTitu.SQL.Text :=
            'SELECT TIT.*,NAT.Desnat,NAT.CodconDebPro,NAT.CodconCrePro,NAT.CodconDebBai,NAT.CodconCreBai,'+
            'FIL.Nomfil FROM arqtitulo TIT '+
            'LEFT JOIN arqfilial FIL ON TIT.IDFilial = FIL.IDFilial '+
            'LEFT JOIN arqnatfin NAT ON TIT.IDNatfin = NAT.IDNatfin '+
            'WHERE IDPess = '+AuxCodPes+ ' AND Nrotit = ' +AuxDoc+ ' AND Saltit = '+FormatDouble(AuxVal,11,2);
         end;
         QueTitu.Open;
         QueTitu.First;
         if QueTitu.IsEmpty then
         begin
            MostraMsg('Aviso','Não foi encontrado nenhum titulo deste fornecedor ' +AuxNome+'!',mtWarning, [mbOk]);
            Inc(i,1);
            Continue;
         end; // if
         // 'S' retornou ok do banco.  'N' Retornou com algum erro do banco
         if cgDados.Cells[8, 1] = 'S' then
         begin
            if QueTitu.FieldByName('IndEnvBco').AsString = 'S' then
            begin
               BaiConDeb := QueTitu.FieldByName('CodconCrePro').AsString;
               if (BaiConCre = '') or (BaiConDeb = '') then
               begin
                  BaiConDeb := '';
                  BaiConCre := ''
               end; // if

               QueAuxi.SQL.Text := 'SELECT MAX(Nrobai) AS UltBai FROM arqtituloBai WHERE IDTitu = '+QueTitu.FieldByName('IDTitu').AsString;
               QueAuxi.Open;

               if QueAuxi.FieldByName('UltBai').AsString = '' then NroBaiAux := 1
               else NroBaiAux := QueAuxi.FieldByName('UltBai').AsInteger + 1;

               QueAuxi.Close;                                                                 //
               QueAuxi.SQL.Text := 'INSERT INTO arqtitulobai (IDTitu,NroBai,CodconDeb,CodconCre,Datpag,VlrJuro,VlrDesc,VlrPago,TotPago) VALUES ('+
               QueTitu.FieldByName('IDTitu').AsString+','+
               NroBaiAux.ToString+','+
               Aspas(BaiConDeb)+','+
               Aspas(BaiConCre)+','+
               Aspas(FormatDateTime('yyyy-mm-dd',AuxDatPag))+','+
               FormatDouble(0.00,11,2)+','+
               FormatDouble(0.00,11,2)+','+
               FormatDouble(QueTitu.FieldByName('Saltit').AsFloat,11,2)+','+
               FormatDouble(QueTitu.FieldByName('Saltit').AsFloat,11,2)+')';
               TotPagSalva := QueTitu.FieldByName('Saltit').AsFloat;
               QueAuxi.ExecSQL(vErro);
               SalTitAux := QueTitu.FieldByName('Saltit').AsFloat - TotPagSalva;
               AuxEnvBco := QueTitu.FieldByName('NumEnvBco').AsInteger + 1;
               QueAuxi.SQL.Clear;
               QueAuxi.SQL.Text := 'UPDATE arqtitulo SET Saltit = '+FormatDouble(SalTitAux,11,2)+', IndSel = '+Aspas('0')+' WHERE IDTitu = '+QueTitu.FieldByName('IDTitu').AsString;
               QueAuxi.ExecSQL(vErro);
            end; //if
         end // if
         else
         begin
            AuxIdTitu := QueTitu.FieldByName('IDTitu').AsInteger;
            AuxEnvBco := QueTitu.FieldByName('NumEnvBco').AsInteger + 1;
            Quetitu.SQL.Clear;
            Quetitu.SQL.Text := 'UPDATE arqtitulo SET IndEnvBco = '+Aspas('N')+' WHERE IDTitu = '+AuxIdTitu.ToString;
            Quetitu.ExecSQL(vErro);
         end;
         Inc(i,1);
      end; // While

      if FileExists(CamNomeArq) then
      begin
         DestinoArq := PathExe+'RetornoBancoBaixado\';
         NomeArq:=ExtractFileName(CamNomeArq);
         if not DirectoryExists(DestinoArq) then CreateDir(DestinoArq);
         DestinoArq := DestinoArq + NomeArq;
         if MoveFile(Pchar(CamNomeArq), PChar(DestinoArq)) then
              MostraMsg('Aviso','Arquivo movido com sucesso! ' +AuxNome+'!',mtInformation, [mbOk])
         else MostraMsg('Erro', 'Erro ao mover arquivo!',mtError, [mbOk]);
      end; // if
   finally
      QuePes.Close;
      QueTitu.Close;
      QueAuxi.Close;
      FreeAndNil(QuePes);
      FreeAndNil(QueTitu);
      FreeAndNil(QueAuxi);
   end;
end;

procedure TFrmRetTitBco.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmRetTitBco.btRetornoBcoClick(Sender: TObject);
var
   i,k: Integer;
   Fornecedor: String;
   CPFCNPJ: String;
   SeuNumero: String;
   Valor: Double;
   DataBaixa: TDateTime;
   Erro: String;
begin
   Caminho := PathExe+'RetornoBanco\';
   if not DirectoryExists(Caminho) then CreateDir(Caminho);

   OpenDialog1.Title := 'Selecione o Arquivo de Retorno';
   OpenDialog1.DefaultExt := '*.ret';
   OpenDialog1.Filter := 'Arquivos RET (*.ret)|*.ret';
   OpenDialog1.InitialDir := Caminho;
   if OpenDialog1.Execute then
   begin
      cgDados.RowCount := 0;
      cgDados.cells[0, 1] := '';
      cgDados.cells[1, 1] := '';
      cgDados.cells[2, 1] := '';
      cgDados.cells[3, 1] := '';
      cgDados.cells[4, 1] := '';
      cgDados.cells[5, 1] := '';

      CamNomeArq := OpenDialog1.FileName;
      ACBrPagFor1.LerTxtRetorno(CamNomeArq);
      for i := 0 to ACBrPagFor1.Arquivos.Count -1 do
      begin
         for k := 0 to ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Count -1 do
         begin
            if (k <> 0) or (cgDados.RowCount <> 2) then
               cgDados.RowCount := cgDados.RowCount+1;

            if ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Count > 0 then
            begin
               cgDados.cells[0, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].Favorecido.Nome;
               if ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].SegmentoB.Last.Inscricao.Tipo = tiCPF then
                  cgDados.cells[1, cgDados.rowcount-1] := Copy(ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].SegmentoB.Last.Inscricao.Numero,5,11)
               else if ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].SegmentoB.Last.Inscricao.Tipo = tiCNPJ then
                  cgDados.cells[1, cgDados.rowcount-1] := Copy(ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].SegmentoB.Last.Inscricao.Numero,2,14);
               cgDados.cells[2, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].Credito.SeuNumero;
               cgDados.cells[3, cgDados.rowcount-1] := FormatFloat('###,###,##0.00', ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].Credito.ValorPagamento);
               cgDados.cells[4, cgDados.rowcount-1] := FormatDateTime('dd/MM/yyyy',ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].Credito.DataPagamento);
               cgDados.cells[5, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Last.CodigoRetorno + ' - ' + ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Last.MensagemRetorno;
               cgDados.cells[6, cgDados.rowcount-1] := '';
               cgDados.cells[7, cgDados.rowcount-1] := FormatDateTime('dd/MM/yyyy',ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoA.Items[k].SegmentoB.Last.DataVencimento);
            end
            else
            if ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Count > 0 then
            begin
               cgDados.cells[0, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].SegmentoJ52.Last.Beneficiario.Nome;
               if ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].SegmentoJ52.Last.Beneficiario.Inscricao.Tipo = tiCPF then
                  cgDados.cells[1, cgDados.rowcount-1] := Copy(ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].SegmentoJ52.Last.Beneficiario.Inscricao.Numero,5,11)
               else if ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].SegmentoJ52.Last.Beneficiario.Inscricao.Tipo = tiCNPJ then
                  cgDados.cells[1, cgDados.rowcount-1] := Copy(ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].SegmentoJ52.Last.Beneficiario.Inscricao.Numero,2,14);
               cgDados.cells[2, cgDados.rowcount-1] := '';
               cgDados.cells[3, cgDados.rowcount-1] := FormatFloat('###,###,##0.00', ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].ValorPagamento);
               cgDados.cells[4, cgDados.rowcount-1] := FormatDateTime('dd/MM/yyyy',ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].DataPagamento);
               cgDados.cells[5, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Last.CodigoRetorno + ' - ' + ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Last.MensagemRetorno;
               cgDados.cells[6, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].CodigoBarras;
               cgDados.cells[7, cgDados.rowcount-1] := FormatDateTime('dd/MM/yyyy',ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoJ.Items[k].DataVencimento);
            end
            else
            if ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoO.Count > 0 then
            begin
               cgDados.cells[0, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoO.Items[k].NomeConcessionaria;
               cgDados.cells[1, cgDados.rowcount-1] := '';
               cgDados.cells[2, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoO.Items[k].SeuNumero;
               cgDados.cells[3, cgDados.rowcount-1] := FormatFloat('###,###,##0.00', ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoO.Items[k].ValorPagamento);
               cgDados.cells[4, cgDados.rowcount-1] := FormatDateTime('dd/MM/yyyy',ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoO.Items[k].DataPagamento);
               cgDados.cells[5, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Last.CodigoRetorno + ' - ' + ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Last.MensagemRetorno;
               cgDados.cells[6, cgDados.rowcount-1] := ACBrPagFor1.Arquivos.Items[i].PagFor.Lote.Last.SegmentoO.Items[k].CodigoBarras;
               cgDados.cells[7, cgDados.rowcount-1] := '';
            end;
            if ACBrPagFor1.Arquivos.Items[i].PagFor.Registro0.Aviso.Last.CodigoRetorno = '00' then
                 cgDados.cells[8, cgDados.rowcount-1] := 'S'
            else cgDados.cells[8, cgDados.rowcount-1] := 'N';
         end;
      end;
   end;
end;

procedure TFrmRetTitBco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Self   := nil;
   Action := caFree;
end;

procedure TFrmRetTitBco.FormShow(Sender: TObject);
begin
   cgDados.cells[0, 0]:= 'FORNECEDOR';
   cgDados.ColumnByName['FORNECEDOR'].Alignment := taLeftJustify;
   cgDados.ColumnByName['FORNECEDOR'].Font.Size := 9;
   cgDados.cells[1, 0]:= 'Nº CPF/CNPJ';
   cgDados.ColumnByName['CPF/CNPJ'].Alignment := taCenter;
   cgDados.ColumnByName['CPF/CNPJ'].Font.Size := 9;
   cgDados.cells[2, 0]:= 'Nº DOCUMENTO';
   cgDados.ColumnByName['DOCUMENTO'].Alignment := taCenter;
   cgDados.ColumnByName['DOCUMENTO'].Font.Size := 9;
   cgDados.cells[3, 0]:= 'VALOR R$';
   cgDados.ColumnByName['VALOR'].Alignment := taRightJustify;
   cgDados.ColumnByName['VALOR'].Font.Size := 9;
   cgDados.cells[4, 0]:= 'DATA BAIXA';
   cgDados.ColumnByName['DATA'].Alignment := taCenter;
   cgDados.ColumnByName['DATA'].Font.Size := 9;
   cgDados.cells[5, 0]:= 'STATUS DO RETORNO';
   cgDados.ColumnByName['STATUS'].Alignment := taLeftJustify;
   cgDados.ColumnByName['STATUS'].Font.Size := 9;
   cgDados.cells[6, 0]:= 'CÓDIGO BARRA';
   cgDados.ColumnByName['CODBAR'].Alignment := taLeftJustify;
   cgDados.ColumnByName['CODBAR'].Font.Size := 9;
   cgDados.cells[7, 0]:= 'DATA VENCIMENTO';
   cgDados.ColumnByName['VENCIMENTO'].Alignment := taLeftJustify;
   cgDados.ColumnByName['VENCIMENTO'].Font.Size := 9;
   cgDados.cells[8, 0]:= 'RETORNO ERRO BANCO';
   cgDados.ColumnByName['ERRO'].Alignment := taLeftJustify;
   cgDados.ColumnByName['ERRO'].Font.Size := 9;
   cgDados.RowColor[0] := $00E5E5E5;
   cgdados.Font.Height := 9;
end;

end.
