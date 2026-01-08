---
name: delphi-patterns
description: Padrões de código Delphi específicos do projeto AIONE. Use quando trabalhar com código Delphi, criar formulários, ou revisar código Pascal.
---

# Padrões Delphi do Projeto

## Modelos de telas e cores usadas estão na pasta: .\.claude\Images ##
  - Modelo de cadastro e outras telas em geral: Modelo_TelaCadastro_base.jpg
  - Modelo de Master / Detalhe: Modelo_Master_Detail_base.jpg
  - Tabela de cores usadas no sistema: Mapa_Cores.png

## Mensagens aos Usuários ##
- Sempre usar :
```pascal
// CORRETO: MostraMsg('Aviso', 'Informe o nome!', mtWarning, [mbOk]); // Função em .\uniAuxilia\uLibFarm.pas

// ERRADO: MessageDlg(''Informe o nome!', mtWarning, [mbOk], 0, mbOk);
```

### 1. CLÁUSULA USES
- Máximo ~100 caracteres por linha
- Agrupar units por namespace quando possível
- Vírgula após cada unit, ponto-e-vírgula apenas na última

```pascal
// CORRETO
uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.JSON,
   System.Generics.Collections, System.Threading, Vcl.Graphics, Vcl.Controls,
   Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, uCopilotAPI, uCopilotConfig;

// ERRADO - linha muito longa
uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.JSON, System.Generics.Collections, System.Threading;

// ERRADO - uma unit por linha
uses
   Winapi.Windows,
   Winapi.Messages,
   System.SysUtils;
```

### 2. INDENTAÇÃO
- Sempre **3 espaços** (nunca tabs)
- Consistente em todo o código

### 3. CONSTANTES
- MAIÚSCULAS com underscore
- Valores alinhados pelo `=`
```pascal
// CORRETO
const
   PANEL_WIDTH  = 380;
   PANEL_MARGIN = 10;
   ANIM_STEP    = 40;
```

### 4. ATRIBUIÇÕES MÚLTIPLAS CONSECUTIVAS
- Alinhar os `:=` para melhor legibilidade
```pascal
// CORRETO
BorderStyle     := bsNone;
FormStyle       := fsStayOnTop;
Width           := PANEL_WIDTH;
AlphaBlend      := True;
AlphaBlendValue := 245;

Msg.IsUser    := AIsUser;
Msg.Text      := AText;
Msg.Timestamp := Now;

Btn         := TButton.Create(pnlSuggestionsContent);
Btn.Parent  := pnlSuggestionsContent;
Btn.Caption := AText;
Btn.Tag     := AIndex;
Btn.Left    := 5;

// ERRADO - não alinhado
BorderStyle := bsNone;
FormStyle := fsStayOnTop;
Width := PANEL_WIDTH;
```

### 5. IF SIMPLES (linha única)
- Se o IF tem apenas UMA ação e cabe em ~130 caracteres, usar formato inline
- Não usar begin/end para ação única
```pascal
// CORRETO
if Assigned(pnlMedInfo) then pnlMedInfo.Visible := False;
if Key = VK_ESCAPE then HidePanel;
if UserMessage = '' then Exit;
if edtMessage.CanFocus then edtMessage.SetFocus;
if FAnimating then Exit;

// ERRADO - begin/end desnecessário
if FAnimating then
begin
   Exit;
end;
```

### 6. ELSE SIMPLES (linha única)
- Se o ELSE tem apenas UMA ação, usar formato inline
- Mesmo que o IF tenha begin/end, ELSE simples fica inline
```pascal
// CORRETO
if ProdutoNome <> '' then
begin
   TextoSugestao := ProdutoNome;
   if Motivo <> '' then TextoSugestao := TextoSugestao + ' - ' + Motivo;
end
else TextoSugestao := Motivo;

if Assigned(JSON) then
begin
   // múltiplas linhas
end
else AddMessage('Resposta invalida do servidor.', False);

// CORRETO - IF e ELSE ambos simples
if ProdutoNome <> '' then memoMedInfo.SelText := ProdutoNome + #13#10
else memoMedInfo.SelText := PrincipioAtivo + #13#10;

// ERRADO - begin/end desnecessário no ELSE
if ProdutoNome <> '' then
begin
   TextoSugestao := ProdutoNome;
end
else
begin
   TextoSugestao := Motivo;
end;
```

### 7. IF-ELSE-IF EM CASCATA
- Uma condição por linha, alinhadas
- Ação após `then` na mesma linha
```pascal
// CORRETO
if AAlertType = 'warning'    then Lbl.Font.Color := clOlive
else if AAlertType = 'error' then Lbl.Font.Color := clMaroon
else Lbl.Font.Color := clNavy;

// CORRETO - com ações maiores
if Left > FTargetLeft then
begin
   Left := Left - ANIM_STEP;
   if Left < FTargetLeft then Left := FTargetLeft;
end else
begin
   tmrAnimShow.Enabled := False;
   FAnimating := False;
end;
```

### 8. TTask.Run
- `TTask.Run(` na primeira linha
- `procedure` na linha seguinte, alinhado com `TTask`
- `var` na próxima linha se houver variáveis locais
- Fechamento: `end);` junto (o `);` fica na mesma linha do `end`)
```pascal
// CORRETO
TTask.Run(
procedure
var
   Response: string;
begin
   try
      Response := CopilotAPI.GetSuggestions;
      TThread.Synchronize(nil,
      procedure
      begin
         ProcessResponse(Response);
      end);
   except
      // Silencioso
   end;
end);

// CORRETO - sem variáveis locais
TTask.Run(
procedure
begin
   try
      Response := CopilotAPI.GetMedicamentoInfo(AProdutoID);
      TThread.Synchronize(nil,
      procedure
      begin
         DisplayMedicamentoInfo(Response);
      end);
   except
      // Silencioso
   end;
end);
```

### 9. TThread.Synchronize
- `TThread.Synchronize(nil,` na primeira linha
- `procedure` na linha seguinte, alinhado
- `begin` na próxima linha
- Fechamento: `end);` junto
```pascal
// CORRETO
TThread.Synchronize(nil,
procedure
begin
   ProcessResponse(Response);
   edtMessage.Enabled := True;
   btnSend.Enabled := True;
   edtMessage.SetFocus;
end);

// CORRETO - aninhado dentro de TTask.Run
TTask.Run(
procedure
var
   Response: string;
begin
   try
      Response := CopilotAPI.SendChatMessage(UserMessage);
      TThread.Synchronize(nil,
      procedure
      begin
         ProcessResponse(Response);
         edtMessage.Enabled := True;
         btnSend.Enabled := True;
         edtMessage.SetFocus;
      end);
   except
      on E: Exception do
      begin
         TThread.Synchronize(nil,
         procedure
         begin
            AddMessage('Erro ao conectar: ' + E.Message, False);
            edtMessage.Enabled := True;
            btnSend.Enabled := True;
         end);
      end;
   end;
end);
```

### 10. TRY/FINALLY
- `try` numa linha própria
- Conteúdo indentado 3 espaços
- `finally` alinhado com `try`
- Usar FreeAndNil() ao invés de .Free
```pascal
// CORRETO
JSON := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
try
   if Assigned(JSON) then
   begin
      ResponseText := JSON.GetValue<string>('message', '');
      AddMessage(ResponseText, False);
   end;
finally
   JSON.Free;
end;
```

### 11. TRY/EXCEPT
- `except` alinhado com `try`
- `on E: Exception do` para captura específica
- `begin/end` após o `do`
```pascal
// CORRETO
try
   JSON := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
   // processar
except
   on E: Exception do
   begin
      AddMessage('Erro ao processar: ' + E.Message, False);
   end;
end;

// CORRETO - except silencioso
try
   Response := CopilotAPI.GetMedicamentoInfo(AProdutoID);
except
   // Silencioso
end;
```

### 12. FOR LOOPS
- Se ação única, sem begin/end
- `for var` para variável inline quando apropriado
```pascal
// CORRETO - ação única
for I := 0 to High(FMessages) do
   ProcessMessage(FMessages[I]);

// CORRETO - múltiplas ações
for I := 0 to High(FMessages) do
begin
   Msg := FMessages[I];
   if Msg.IsUser then Prefix := 'Voce: '
   else Prefix := 'Copilot: ';
   memoChat.SelText := Prefix + Msg.Text;
end;

// CORRETO - variável inline
for var I := 0 to JSON.Count - 1 do
begin
   Item := JSON.Items[I] as TJSONObject;
   ProcessItem(Item);
end;
```

### 13. WHILE LOOPS
- Se ação única, sem begin/end na linha seguinte
```pascal
// CORRETO
while pnlSuggestionsContent.ControlCount > 0 do
   pnlSuggestionsContent.Controls[0].Free;

// CORRETO - múltiplas ações
while not EOF do
begin
   ProcessRecord;
   Next;
end;
```

### 14. DECLARAÇÃO DE VARIÁVEIS
- Uma variável por linha (ou agrupar do mesmo tipo)
- Tipo após os dois pontos
```pascal
// CORRETO
var
   Response: string;
   JSON: TJSONObject;
   ProdutoID, ItemSeq: Integer;  // mesmo tipo pode agrupar
   Found: Boolean;

// CORRETO - múltiplas do mesmo tipo
var
   Titulo, Mensagem, Severidade, TextoAlerta: string;
```

### 15. NOMENCLATURA
- Units: prefixo `u` (uCopilotAPI.pas)
- Forms: prefixo `Frm` na variável, `TFrm` na classe (TFrmCopilotPanel)
- Campos privados: prefixo `F` (FMessages, FAnimating, FLastProdutoID)
- Parâmetros: prefixo `A` (AText, AIsUser, AResponse)
- Constantes: MAIÚSCULAS_COM_UNDERSCORE (PANEL_WIDTH, ANIM_STEP)
- Records: prefixo `T` (TChatMessage)

### 16. PARÂMETROS DE PROCEDURES/FUNCTIONS
- `const` para strings e records
- Se couber em ~130 chars, tudo na mesma linha
- Se não couber, quebrar após `(`
```pascal
// CORRETO - cabe na linha
procedure AddMessage(const AText: string; AIsUser: Boolean);
procedure SetContext(const AClienteID: Integer; const AVendaID: Integer);
procedure CreateAlertLabel(const AText: string; AAlertType: string);

// CORRETO - evento com quebra
procedure pnlHeaderMouseDown(Sender: TObject;
   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
```

### 17. COMENTÁRIOS
- `// ` com espaço após as barras
- Comentários de seção com linha de `-`
```pascal
// CORRETO
// Configura janela
BorderStyle := bsNone;

// Scroll para o final
SendMessage(memoChat.Handle, WM_VSCROLL, SB_BOTTOM, 0);

// --------------------------------------------
// Informações Farmaceuticas
// --------------------------------------------
```

### 18. ESPAÇAMENTO VERTICAL
- Linha em branco entre procedures/functions
- Linha em branco após bloco var local
- Sem linha em branco antes de `end;` final de procedure
- Sem linha em branco entre `try` e primeira linha de código
- Linha em branco para separar blocos lógicos dentro de procedure
```pascal
// CORRETO
procedure TFrmCopilotPanel.DoSendMessage;
var
   UserMessage: string;
begin
   UserMessage := Trim(edtMessage.Text);
   if UserMessage = '' then Exit;
   AddMessage(UserMessage, True);
   edtMessage.Clear;

   // Desabilita input enquanto processa
   edtMessage.Enabled := False;
   btnSend.Enabled    := False;

   // Envia para o backend em thread separada
   TTask.Run(
   procedure
   ...
   end);
end;

procedure TFrmCopilotPanel.ProcessResponse(const AResponse: string);
begin
   ...
end;
```

### 19. RESUMO IF/ELSE

| Situação                   | Formato 													|
|----------------------------|------------------------------------------------|
| IF simples, sem ELSE       | `if X then Acao;` 										|
| IF simples, ELSE simples   | `if X then Acao1 else Acao2;` 						|
| IF múltiplo, ELSE simples  | `if X then begin ... end else Acao;` 				|
| IF simples, ELSE múltiplo  | `if X then Acao else begin ... end;` 				|
| IF múltiplo, ELSE múltiplo | `if X then begin ... end else begin ... end;` 	|
| IF-ELSE-IF cascata         | Uma linha por condição, alinhadas 					|

## Liberação de Objetos

**SEMPRE use FreeAndNil:**
```pascal
// ✅ CORRETO
FreeAndNil(Qry);

// ❌ ERRADO
Qry.Free;
Qry := nil;
```

## Try-Finally

**SEMPRE use try-finally para recursos:**
```pascal
// ✅ CORRETO
Qry := TRESTDWClientSQL.Create(nil);
try
   Qry.Open;
   // processar
finally
   Qry.Close;
   FreeAndNil(Qry);
end;

// ❌ ERRADO - sem proteção
Qry := TRESTDWClientSQL.Create(nil);
Qry.Open;
Qry.Free;
```

## Nomenclatura

**Formulários:**
- Classe: `TFrmNome`
- Arquivo: `uNomeForm.pas`
- Cadastros: `uNomeCad.pas`

**Componentes:**
```pascal
ed*        // Campos de edição (edNompes, edCpfCnpj)
bt*        // Botões (btSalvar, btExcluir)
lb*        // ListBox/ComboBox (lbEmissor)
Panel*     // Painéis (PanelCadastro, PanelTop)
Tab*       // Tabelas (TabPess, TabProduto)
Sou*       // DataSource (SouPess, SouProduto)
Que*       // Queries auxiliares (QueAuxi)
```

## REST-DW Essencial

**SEMPRE declare uRESTDWBasicDB:**
```pascal
uses
   System.SysUtils, uRESTDWBasicDB;  // ⚠️ OBRIGATÓRIO
```

**SEMPRE defina UpdateTableName:**
```pascal
Qry.UpdateTableName := 'arqpessoa';  // Antes de ApplyUpdates
```

**SEMPRE configure ProviderFlags:**
```pascal
Qry.FieldByName('IDPess').ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];
```

## Tratamento de Erros

**Padrão de erro:**
```pascal
try
   // Código que pode falhar
except
   on E: Exception do
   begin
      SalvaLog(USUARIO, PastaLog, 'ERRO: ' + E.Message);
      MostraMsg('Erro', 'Falha: ' + E.Message, mtError, [mbOk]);
   end;
end;
```

## Validações

**Sempre validar antes de salvar:**
```pascal
if Trim(TabPessNompes.AsString) = '' then
begin
   MostraMsg('Aviso', 'Informe o nome!', mtWarning, [mbOk]);
   edNompes.SetFocus;
   Exit;
end;
```

## Banco de Dados

**Padrão de query:**
```pascal
Qry := TRESTDWClientSQL.Create(nil);
Qry.DataBase := DM.DWDataBase;
try
   Qry.SQL.Text := 'SELECT * FROM tabela WHERE id = :id';
   Qry.ParamByName('id').AsInteger := 123;
   Qry.Open;
   
   if not Qry.IsEmpty then
   begin
      // processar
   end;
finally
   Qry.Close;
   FreeAndNil(Qry);
end;
```

## Evitar

- Código comentado (deletar)
- Variáveis não usadas
- Magic numbers (extrair constantes)
- Concatenação SQL (usar parâmetros)
- Objetos não liberados
- Indentação inconsistente

## Funções Úteis (MarcLib)

```pascal
AdjustZoom(Form)              // Ajuste DPI
MostraMsg(...)                // Mensagens
SalvaLog(...)                 // Logging
FadeInOut(Form, 'In', 10)     // Efeito fade
ValidaCPF(CPF: String)        // Validação
OnlyNumbers(Texto: String)    // Remover não-números
Aspas(Texto: String)          // Retorna 'texto'
```

## Criação de Formulários a partir de Imagens

Ao criar formulários baseados em imagens/screenshots fornecidas pelo usuário:

1. **Fidelidade às cores**: Reproduzir os tons de cores o mais próximo possível do modelo
2. **Cores de fundo de painéis**: Identificar e usar as cores exatas de cada painel
3. **Espaçamentos**: Manter proporções e margens similares ao modelo
4. **Hierarquia visual**: Respeitar a estrutura de containers (painéis dentro de painéis)
5. **Fontes e tamanhos**: Usar tamanhos de fonte proporcionais ao modelo
6. **Alinhamentos**: Reproduzir alinhamentos (esquerda, centro, direita) conforme imagem

### Conversão de Cores Hex (#RRGGBB) para Delphi

**IMPORTANTE:** Delphi usa formato **BGR** (não RGB)!

**Fórmula de conversão:**
```
#RRGGBB -> Delphi = BB + (GG * 256) + (RR * 65536)
```

**Exemplo: #F5B689 (laranja/salmão)**
```
R = F5 = 245
G = B6 = 182
B = 89 = 137

Valor Delphi = 137 + (182 * 256) + (245 * 65536) = 9025161
```

**Cores comuns identificadas em interfaces:**
```pascal
// Tons de fundo
$00E6DAF9  // Rosa/salmão claro (fundo geral)
$00FFFFFF  // Branco (painéis de conteúdo)
$00E6F5FD  // Creme/bege claro (linhas alternadas)
$00D9EBFC  // Bege (painel de totais)
$0089B6F5  // Laranja/salmão #F5B689 (painel de ações) = 9025161

// Para TLMDSimplePanel usar propriedade Color:
PanelAcoes.Color := 9025161;  // #F5B689
```

**Propriedades de cor por componente:**
- **TLMDSimplePanel**: `Color`
- **TAdvSmoothPanel**: `Fill.Color`
- **TForm**: `Color`
- **TPanel**: `Color`
