unit uCertificados;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.DateUtils;
   function  FormatDNOrdered(const Subject, SerialHex: string): string;
   procedure ListarCertificadosPessoais(Dest: TStrings; OnlyValid: Boolean = False; OnlyWithPrivateKey: Boolean = False);

implementation

type
  DWORD     = Winapi.Windows.DWORD;
  PBYTE     = ^Byte;
  ULONG_PTR = NativeUInt;
  BOOL      = LongBool;

  HCERTSTORE = Pointer;

  PCRYPT_DATA_BLOB = ^CRYPT_DATA_BLOB;
  CRYPT_DATA_BLOB = record
    cbData: DWORD;
    pbData: PBYTE;
  end;

  PCRYPT_INTEGER_BLOB = ^CRYPT_INTEGER_BLOB;
  CRYPT_INTEGER_BLOB = CRYPT_DATA_BLOB;

  PCERT_CONTEXT = ^CERT_CONTEXT;
  CERT_CONTEXT = record
    dwCertEncodingType: DWORD;
    pbCertEncoded: PBYTE;
    cbCertEncoded: DWORD;
    pCertInfo: Pointer;   // PCERT_INFO
    hCertStore: HCERTSTORE;
  end;

  PCERT_INFO = ^CERT_INFO;
  CERT_INFO = record
    dwVersion: DWORD;
    SerialNumber: CRYPT_INTEGER_BLOB;
    SignatureAlgorithm: record
      pszObjId: PAnsiChar;
      Parameters: CRYPT_DATA_BLOB;
    end;
    Issuer: record end;
    NotBefore: FILETIME;
    NotAfter: FILETIME;
    Subject: record end;
    // Demais campos omitidos
  end;

const
  CERT_NAME_SIMPLE_DISPLAY_TYPE    = 4;
  CERT_NAME_FRIENDLY_DISPLAY_TYPE  = 5;

  CERT_NAME_ISSUER_FLAG            = $00000001;

  CERT_HASH_PROP_ID                = 3;

  CERT_CLOSE_STORE_FORCE_FLAG      = $00000001;
  CERT_CLOSE_STORE_CHECK_FLAG      = $00000002;

  CRYPT_ACQUIRE_ONLY_NCRYPT_KEY_FLAG = $00040000;
  CRYPT_ACQUIRE_COMPARE_KEY_FLAG     = $00020000;
  CRYPT_ACQUIRE_SILENT_FLAG          = $00000040;

  CERT_NCRYPT_KEY_SPEC             = DWORD($FFFFFFFF);

function CertOpenSystemStoreW(hProv: ULONG_PTR; szSubsystemProtocol: PWideChar): HCERTSTORE; stdcall; external 'crypt32.dll' name 'CertOpenSystemStoreW';
function CertEnumCertificatesInStore(hCertStore: HCERTSTORE; pPrevCertContext: PCERT_CONTEXT): PCERT_CONTEXT; stdcall; external 'crypt32.dll' name 'CertEnumCertificatesInStore';
function CertCloseStore(hCertStore: HCERTSTORE; dwFlags: DWORD): BOOL; stdcall; external 'crypt32.dll' name 'CertCloseStore';
function CertGetNameStringW(pCertContext: PCERT_CONTEXT; dwType, dwFlags: DWORD; pvTypePara: Pointer; pszNameString: PWideChar; cchNameString: DWORD): DWORD; stdcall; external 'crypt32.dll' name 'CertGetNameStringW';
function CertGetCertificateContextProperty(pCertContext: PCERT_CONTEXT; dwPropId: DWORD; pvData: Pointer; var pcbData: DWORD): BOOL; stdcall; external 'crypt32.dll' name 'CertGetCertificateContextProperty';
function CryptAcquireCertificatePrivateKey(pCert: PCERT_CONTEXT; dwFlags: DWORD; pvReserved: Pointer; out phCryptProvOrNCryptKey: ULONG_PTR; out pdwKeySpec: DWORD; out pfCallerFreeProvOrNCryptKey: BOOL): BOOL; stdcall; external 'crypt32.dll' name 'CryptAcquireCertificatePrivateKey';

// Liberações conforme o tipo de chave retornado
function CryptReleaseContext(hProv: ULONG_PTR; dwFlags: DWORD): BOOL; stdcall; external 'advapi32.dll' name 'CryptReleaseContext';
function NCryptFreeObject(hObject: ULONG_PTR): Integer; stdcall; external 'ncrypt.dll' name 'NCryptFreeObject';

function FileTimeToDateTimeLocal(const FT: FILETIME): TDateTime;
var
  L: FILETIME;
  ST: SYSTEMTIME;
begin
  if (FT.dwLowDateTime = 0) and (FT.dwHighDateTime = 0) then
    Exit(0);
  FileTimeToLocalFileTime(FT, L);
  FileTimeToSystemTime(L, ST);
  Result := SystemTimeToDateTime(ST);
end;

function BlobToHexReversed(const B: CRYPT_INTEGER_BLOB): string;
var
  i: Integer;
  bytes: TBytes;
begin
  // Por que: pbData é ponteiro; copiamos para array para indexar com segurança
  SetLength(bytes, B.cbData);
  if B.cbData > 0 then
    Move(B.pbData^, bytes[0], B.cbData);

  Result := '';
  for i := Integer(Length(bytes)) - 1 downto 0 do
    Result := Result + IntToHex(bytes[i], 2);
end;

function GetNameStr(pCtx: PCERT_CONTEXT; DispType: DWORD; Flags: DWORD = 0): string;
var
  Len: DWORD;
begin
  Result := '';
  Len := CertGetNameStringW(pCtx, DispType, Flags, nil, nil, 0);
  if Len <= 1 then Exit;
  SetLength(Result, Len - 1);
  CertGetNameStringW(pCtx, DispType, Flags, nil, PWideChar(Result), Len);
end;

function GetThumbprintSHA1(pCtx: PCERT_CONTEXT): string;
var
  Len: DWORD;
  Buf: TBytes;
  i: Integer;
begin
  Result := '';
  Len := 0;
  CertGetCertificateContextProperty(pCtx, CERT_HASH_PROP_ID, nil, Len);
  if Len = 0 then Exit;
  SetLength(Buf, Len);
  if not CertGetCertificateContextProperty(pCtx, CERT_HASH_PROP_ID, @Buf[0], Len) then Exit;
  for i := 0 to Len-1 do
  begin
    Result := Result + IntToHex(Buf[i], 2);
    if i < Len-1 then Result := Result + ' ';
  end;
end;

function HasPrivateKey(pCtx: PCERT_CONTEXT): Boolean;
var
  hProvOrKey: ULONG_PTR;
  KeySpec: DWORD;
  MustFree: BOOL;
begin
  // Por que: apenas detectar presença da chave privada (sem UI)
  Result := CryptAcquireCertificatePrivateKey(
              pCtx,
              CRYPT_ACQUIRE_ONLY_NCRYPT_KEY_FLAG or CRYPT_ACQUIRE_COMPARE_KEY_FLAG or CRYPT_ACQUIRE_SILENT_FLAG,
              nil, hProvOrKey, KeySpec, MustFree);
  // Por que: se a API exigiu liberação, liberamos corretamente conforme o provedor
  if Result and MustFree then
  begin
    if KeySpec = CERT_NCRYPT_KEY_SPEC then
      NCryptFreeObject(hProvOrKey)
    else
      CryptReleaseContext(hProvOrKey, 0);
  end;
end;

procedure ListarCertificadosPessoais(Dest: TStrings; OnlyValid, OnlyWithPrivateKey: Boolean);
var
  hStore: HCERTSTORE;
  pCtx: PCERT_CONTEXT;
  CN, Friendly, Issuer, Serial, Thumb: string;
  NotBefore, NotAfter, NowDt: TDateTime;
  HasKey: Boolean;
  Info: PCERT_INFO;
begin
  Dest.BeginUpdate;
  try
    Dest.Clear;

    hStore := CertOpenSystemStoreW(0, 'MY'); // Loja "Pessoal" do usuário atual
    if hStore = nil then
      raise Exception.Create('Não foi possível abrir a loja "Pessoal (MY)".');

    try
      NowDt := Now;
      pCtx := nil;
      while True do
      begin
        pCtx := CertEnumCertificatesInStore(hStore, pCtx);
        if pCtx = nil then Break;

        CN       := GetNameStr(pCtx, CERT_NAME_SIMPLE_DISPLAY_TYPE);
        Friendly := GetNameStr(pCtx, CERT_NAME_FRIENDLY_DISPLAY_TYPE);
        Issuer   := GetNameStr(pCtx, CERT_NAME_SIMPLE_DISPLAY_TYPE, CERT_NAME_ISSUER_FLAG);

        Info      := PCERT_INFO(pCtx^.pCertInfo);
        Serial    := BlobToHexReversed(Info^.SerialNumber);
        NotBefore := FileTimeToDateTimeLocal(Info^.NotBefore);
        NotAfter  := FileTimeToDateTimeLocal(Info^.NotAfter);

        HasKey := HasPrivateKey(pCtx);
        Thumb  := GetThumbprintSHA1(pCtx);

        if OnlyValid and not ((NowDt >= NotBefore) and (NowDt <= NotAfter)) then
          Continue;
        if OnlyWithPrivateKey and not HasKey then
          Continue;

        Dest.Add(Format('CN=%s | Friendly=%s | Série=%s | Emissor=%s | Val=%s a %s | ChavePrivada=%s | SHA1=%s',
          [ CN,
            Friendly,
            Serial,
            Issuer,
            FormatDateTime('dd/mm/yyyy', NotBefore),
            FormatDateTime('dd/mm/yyyy', NotAfter),
            BoolToStr(HasKey, True),
            Thumb ]));
      end;
    finally
      CertCloseStore(hStore, 0);
    end;
  finally
    Dest.EndUpdate;
  end;
end;

// Drop-in: funções para formatar Subject (DN) + Serial em uma linha padrão.
function SpaceHexPairs(const Hex: string): string;
var
  s: string; i: Integer;
begin
  s := UpperCase(StringReplace(Hex, ' ', '', [rfReplaceAll]));
  if (Length(s) mod 2) = 1 then s := '0' + s;
  Result := '';
  for i := 1 to Length(s) do
  begin
    Result := Result + s[i];
    if (i mod 2 = 0) and (i < Length(s)) then
      Result := Result + ' ';
  end;
end;

// Reordena para: CN, OU(última), O, C, S, L, E, SE
function FormatDNOrdered(const Subject, SerialHex: string): string;
var
  parts: TArray<string>;
  i, p: Integer;
  token, k, v: string;
  CN, OU, O_, C_, S_, L_, E_, SE: string;
begin
  CN := ''; OU := ''; O_ := ''; C_ := ''; S_ := ''; L_ := ''; E_ := '';

  parts := Subject.Split([',']); // divide por vírgulas
  for i := 0 to High(parts) do
  begin
    token := Trim(parts[i]);
    p := Pos('=', token);        // <<< 1-based (corrige o erro)
    if p <= 1 then Continue;
    k := UpperCase(Trim(Copy(token, 1, p-1)));
    v := Trim(Copy(token, p+1, MaxInt));

    if k = 'CN' then CN := v
    else if k = 'OU' then OU := v       // mantém a ÚLTIMA OU
    else if k = 'O'  then O_ := v
    else if k = 'C'  then C_ := v
    else if k = 'S'  then S_ := v
    else if k = 'L'  then L_ := v
    else if k = 'E'  then E_ := v;
  end;

  SE := SpaceHexPairs(SerialHex);

  Result := Format('CN=%s, OU=%s, O=%s, C=%s, S=%s, L=%s, E=%s, SE=%s',
    [CN, OU, O_, C_, S_, L_, E_, SE]);
end;

end.

(*
Ainda contém erros graves: passei à função FormatDNOrdered:
"C=BR, O=ICP-Brasil, S=MG, L=UBERLANDIA, OU=19460807000135, OU=Secretaria da Receita Federal do Brasil - RFB, OU=RFB e-CNPJ A1, OU=presencial, CN=BERMAIA E DUTRA LTDA:18710233000143", "6C598E6E17056B9B"
Me retornou errado assim "CN=, OU=, O==presencial, C==BERMAIA E DUTRA LTDA:18710233000143, S=, L=, E=, SE=6C 59 8E 6E 17 05 6B 9B"
O certo seria: "CN=BERMAIA E DUTRA LTDA:18710233000143, OU=presencial, O=ICP-Brasil, C=BR, S=MG, L=UBERLANDIA, E=, SE=70 96 2F C8 25 CA 04 8D"
Está duplicando os "=", retonando valores em posições erradas ou valores vazios mesmo que esse contenh algo. Analise com cuidado.


CN=BERMAIA E DUTRA LTDA:18710233000143, OU=presencial, O=ICP-Brasil, C=BR, S=MG, L=UBERLANDIA, E=, SE=6C 59 8E 6E 17 05 6B 9B
CN=BERMAIA E DUTRA LTDA:18710233000143, OU=presencial, O=ICP-Brasil, C=BR, S=MG, L=UBERLANDIA, E=, SE=70 96 2F C8 25 CA 04 8D

CN=LBS SISTEMAS E ASSESSORIA LTDA:36419289000125, OU=AC SyngularID Multipla, O=ICP-Brasil, C=BR, S=, L=, E=, SE=00 C6 2A 05 76 85 D3 D3 2A 52 3C
CN=LBS SISTEMAS E ASSESSORIA LTDA:36419289000125, OU=AC SyngularID Multipla, O=ICP-Brasil, C=BR, S=, L=, E=, SE=00 C6 2A 05 76 85 D3 D3 2A 52 3C
*)
