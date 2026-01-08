// File: MySQLSchemaSync.pas 3
unit MySQLSchemaSync;

interface

uses System.SysUtils, System.Classes, System.Generics.Collections, FireDAC.Comp.Client;

type
  TSyncOptions = record
    Execute: Boolean;              // apply plan when DRY-RUN disabled
    DropExtras: Boolean;           // drop only items existing only in target
    IncludeTriggers: Boolean;      // sync triggers
    TargetDefaultEngine: string;
    TargetDefaultCharset: string;
    TargetDefaultCollation: string;
  end;
function CompareAndSyncSchemas(
  const SrcConn, DstConn: TFDConnection;
  const SrcDB, DstDB: string;
  const Opt: TSyncOptions;
  out Plan: TStringList): Integer;
procedure SetSyncDryRun(const Value: Boolean);

implementation

uses
  System.StrUtils, System.IOUtils, System.Variants, System.DateUtils;

var
  GSyncDryRun: Boolean = True;
  GLogFile: string = '';

  procedure SetSyncDryRun(const Value: Boolean);
begin
  GSyncDryRun := Value;
end;
procedure LogInit(const SrcDB, DstDB: string);
var base: string;
begin
  base := ExtractFilePath(ParamStr(0));
  if base = '' then base := GetCurrentDir + PathDelim;
  GLogFile := IncludeTrailingPathDelimiter(base) +
              Format('schema_sync_%s__%s_%s.sql', [SrcDB, DstDB, FormatDateTime('yyyymmdd_hhnnss', Now)]);
  TFile.WriteAllText(GLogFile,
    '-- Schema Sync (SAFE, EXACT MATCH)' + sLineBreak +
    Format('-- Source: %s  Target: %s  At: %s', [SrcDB, DstDB, DateTimeToStr(Now)]) + sLineBreak +
    'SET FOREIGN_KEY_CHECKS=0;' + sLineBreak,
    TEncoding.UTF8);
end;
procedure LogLine(const S: string);
begin
  if GLogFile <> '' then
    TFile.AppendAllText(GLogFile, S + sLineBreak, TEncoding.UTF8);
end;
procedure LogPlan(const L: TStrings);
var i: Integer;
begin
  LogLine('');
  LogLine('-- PLAN BEGIN --');
  for i := 0 to L.Count-1 do LogLine(L[i]);
  LogLine('-- PLAN END --');
end;

function StartsWith(const S, Prefix: string): Boolean; inline;
begin
  if Length(Prefix) = 0 then Exit(True);
  if Length(S) < Length(Prefix) then Exit(False);
  Result := SameText(Copy(S, 1, Length(Prefix)), Prefix);
end;
function QI(const S: string): string; inline;
begin
  Result := '`' + StringReplace(S, '`', '``', [rfReplaceAll]) + '`';
end;
function LowerNoSpaces(const S: string): string;
begin
  Result := AnsiLowerCase(StringReplace(S, ' ', '', [rfReplaceAll]));
end;
function IsAutoInc(const Extra: string): Boolean; inline;
begin
  Result := Pos('auto_increment', AnsiLowerCase(Extra)) > 0;
end;
function TypeBase(const CType: string): string;
var L: string; p: Integer;
begin
  L := LowerNoSpaces(CType);
  p := Pos('(', L);
  if p>0 then Result := Copy(L, 1, p-1) else Result := L;
end;
function ExtractSizePair(const CType: string; out N1, N2: Integer): Boolean;
var L: string; p1,p2,comma: Integer; inner: string;
begin
  Result := False; N1 := 0; N2 := 0;
  L := LowerNoSpaces(CType);
  p1 := Pos('(', L); p2 := LastDelimiter(')', L);
  if (p1>0) and (p2>p1) then
  begin
    inner := Copy(L, p1+1, p2-p1-1);
    comma := Pos(',', inner);
    if comma>0 then begin
      N1 := StrToIntDef(Copy(inner,1,comma-1),0);
      N2 := StrToIntDef(Copy(inner,comma+1,MaxInt),0);
    end else
      N1 := StrToIntDef(inner,0);
    Result := True;
  end;
end;
function IsCharLikeBase(const B: string): Boolean;
begin
  Result := (B='char') or (B='varchar') or (B='text') or (B='tinytext') or
            (B='mediumtext') or (B='longtext') or (B='enum') or (B='set') or (B='json');
end;
function IsNumericBase(const B: string): Boolean;
begin
  Result := (B='tinyint') or (B='smallint') or (B='mediumint') or (B='int') or (B='integer') or
            (B='bigint') or (B='decimal') or (B='dec') or (B='numeric') or
            (B='float') or (B='double');
end;
function IsSafeWidenInt(const FromBase, ToBase: string): Boolean;
const ORDER: array[0..4] of string = ('tinyint','smallint','int','mediumint','bigint');
  function Rank(const B: string): Integer;
  var i: Integer;
  begin
    for i := Low(ORDER) to High(ORDER) do if SameText(ORDER[i], B) then Exit(i);
    Result := -1;
  end;
var rf, rt: Integer;
begin
  rf := Rank(FromBase); rt := Rank(ToBase);
  Result := (rf>=0) and (rt>=rf);
end;
function BuildDefaultSQL(const RawDef: Variant; const CType: string; const IsNullable: Boolean): string;
  function IsFuncToken(const S: string): Boolean;
  var U: string;
  begin
    U := UpperCase(Trim(VarToStr(S)));
    Result := (U='CURRENT_TIMESTAMP') or (U='CURRENT_TIMESTAMP()') or
              (U='NOW()') or (U='CURRENT_DATE') or (U='CURRENT_TIME');
  end;
  function StripQuotes(const S: string): string;
  begin
    Result := S;
    if (Result <> '') and (Result[1] = '''') and (Result[Length(Result)] = '''') then
      Result := Copy(Result, 2, Length(Result)-2);
  end;
var V, L: string;
begin
  if VarIsNull(RawDef) or VarIsEmpty(RawDef) then Exit('');
  V := VarToStr(RawDef);
  L := LowerNoSpaces(CType);
  if SameText(Trim(V), 'NULL') then Exit('DEFAULT NULL');
  if IsFuncToken(V) and (StartsWith(L,'date') or StartsWith(L,'time') or StartsWith(L,'datetime') or StartsWith(L,'timestamp')) then
    Exit('DEFAULT ' + UpperCase(StringReplace(V, '()', '', [])));
  if IsCharLikeBase(TypeBase(CType)) then
  begin
    if (Length(V)<2) or (V[1]<>'''') then V := QuotedStr(V);
    Exit('DEFAULT ' + V);
  end;
  V := StripQuotes(V);
  if V='' then Exit('');
  Result := 'DEFAULT ' + V;
end;
procedure ExecBatch(const Conn: TFDConnection; const SQLs: TStrings);
var i: Integer;
begin
  if SQLs.Count=0 then Exit;
  Conn.StartTransaction;
  try
    for i := 0 to SQLs.Count-1 do
    begin
      LogLine('-- EXEC ' + SQLs[i]);
      Conn.ExecSQL(SQLs[i]);
    end;
    Conn.Commit;
  except
    on E: Exception do
    begin
      Conn.Rollback;
      LogLine('-- ERROR: ' + E.Message);
      raise;
    end;
  end;
end;
function ShowCreateTable(const Conn: TFDConnection; const DB, TableName: string): string;
var Q: TFDQuery; ddl, qualified, unqualified: string;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text := 'SHOW CREATE TABLE IF NOT EXISTS ' + QI(DB) + '.' + QI(TableName);
    Q.Open;
    ddl := Q.Fields[1].AsString;
    // strip source DB qualifier
    qualified := QI(DB) + '.' + QI(TableName);
    unqualified := QI(TableName);
    ddl := StringReplace(ddl, qualified, unqualified, [rfIgnoreCase]);
    Result := ddl + ';';
  finally
    Q.Free;
  end;
end;
procedure LoadTables(const Conn: TFDConnection; const DB: string; out Names: TArray<string>);
var Q: TFDQuery;
begin
  SetLength(Names, 0);
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text := 'SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_SCHEMA=:db ORDER BY TABLE_NAME';
    Q.ParamByName('db').AsString := DB;
    Q.Open;
    while not Q.Eof do
    begin
      Names := Names + [Q.FieldByName('TABLE_NAME').AsString];
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;
type
  TColInfo = record
    ColType, IsNullable, Extra, Charset, Collation, Comment, DefaultSQL: string;
    Ordinal: Integer;
  end;
procedure LoadColumns(const Conn: TFDConnection; const DB, TableName: string; out Map: TDictionary<string,TColInfo>; out PK: TArray<string>);
var Q: TFDQuery; ci: TColInfo; tmp: TArray<string>;
begin
  Map := TDictionary<string,TColInfo>.Create;
  // columns
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text :=
      'SELECT COLUMN_NAME, ORDINAL_POSITION, COLUMN_TYPE, IS_NULLABLE, EXTRA,'+
      ' CHARACTER_SET_NAME, COLLATION_NAME, COLUMN_COMMENT, COLUMN_DEFAULT '+
      'FROM information_schema.columns WHERE TABLE_SCHEMA=:db AND TABLE_NAME=:t '+
      'ORDER BY ORDINAL_POSITION';
    Q.ParamByName('db').AsString := DB;
    Q.ParamByName('t').AsString := TableName;
    Q.Open;
    while not Q.Eof do
    begin
      ci.Ordinal := Q.FieldByName('ORDINAL_POSITION').AsInteger;
      ci.ColType := Q.FieldByName('COLUMN_TYPE').AsString;
      ci.IsNullable := Q.FieldByName('IS_NULLABLE').AsString; // YES/NO
      ci.Extra := Trim(Q.FieldByName('EXTRA').AsString);
      ci.Charset := Q.FieldByName('CHARACTER_SET_NAME').AsString;
      ci.Collation := Q.FieldByName('COLLATION_NAME').AsString;
      ci.Comment := Q.FieldByName('COLUMN_COMMENT').AsString;
      ci.DefaultSQL := BuildDefaultSQL(Q.FieldByName('COLUMN_DEFAULT').Value, ci.ColType, SameText(ci.IsNullable,'YES'));
      Map.Add(Q.FieldByName('COLUMN_NAME').AsString, ci);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
  // PK
  SetLength(PK, 0);
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text :=
      'SELECT COLUMN_NAME FROM information_schema.key_column_usage '+
      'WHERE TABLE_SCHEMA=:db AND TABLE_NAME=:t AND CONSTRAINT_NAME=''PRIMARY'' '+
      'ORDER BY ORDINAL_POSITION';
    Q.ParamByName('db').AsString := DB;
    Q.ParamByName('t').AsString := TableName;
    Q.Open;
    while not Q.Eof do
    begin
      tmp := tmp + [QI(Q.FieldByName('COLUMN_NAME').AsString)];
      Q.Next;
    end;
    PK := tmp;
  finally
    Q.Free;
  end;
end;
procedure LoadIndexes(const Conn: TFDConnection; const DB, TableName: string; out Sig: TDictionary<string,string>);
var Q: TFDQuery; acc: TObjectDictionary<string, TList<string>>;
    idxName: string; part: string; L: TList<string>;
begin
  Sig := TDictionary<string,string>.Create;
  acc := TObjectDictionary<string, TList<string>>.Create([doOwnsValues]);
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text :=
      'SELECT INDEX_NAME, NON_UNIQUE, INDEX_TYPE, SEQ_IN_INDEX, COLUMN_NAME, SUB_PART '+
      'FROM information_schema.statistics WHERE TABLE_SCHEMA=:db AND TABLE_NAME=:t '+
      'ORDER BY INDEX_NAME, SEQ_IN_INDEX';
    Q.ParamByName('db').AsString := DB;
    Q.ParamByName('t').AsString := TableName;
    Q.Open;
    while not Q.Eof do
    begin
      idxName := Q.FieldByName('INDEX_NAME').AsString;
      if SameText(idxName, 'PRIMARY') then begin Q.Next; Continue; end;
      if not acc.TryGetValue(idxName, L) then
      begin
        L := TList<string>.Create;
        acc.Add(idxName, L);
      end;
      part := UpperCase(Q.FieldByName('COLUMN_NAME').AsString);
      if not Q.FieldByName('SUB_PART').IsNull then
        part := part + '(' + Q.FieldByName('SUB_PART').AsString + ')';
      L.Add(part);
      Q.Next;
    end;
    for idxName in acc.Keys do
      Sig.Add(idxName, String.Join(',', acc[idxName].ToArray));
  finally
    Q.Free;
    acc.Free;
  end;
end;
procedure LoadFKsForTable(const Conn: TFDConnection; const DB, TableName: string;
                          out FKCols: TObjectDictionary<string, TList<string>>);
var Q: TFDQuery; fkName, col: string; L: TList<string>;
begin
  FKCols := TObjectDictionary<string, TList<string>>.Create([doOwnsValues]);
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text :=
      'SELECT CONSTRAINT_NAME, COLUMN_NAME, ORDINAL_POSITION ' +
      'FROM information_schema.key_column_usage ' +
      'WHERE TABLE_SCHEMA=:db AND TABLE_NAME=:t AND REFERENCED_TABLE_NAME IS NOT NULL ' +
      'ORDER BY CONSTRAINT_NAME, ORDINAL_POSITION';
    Q.ParamByName('db').AsString := DB;
    Q.ParamByName('t').AsString := TableName;
    Q.Open;
    while not Q.Eof do
    begin
      fkName := Q.FieldByName('CONSTRAINT_NAME').AsString;
      col := Q.FieldByName('COLUMN_NAME').AsString;
      if not FKCols.TryGetValue(fkName, L) then
      begin
        L := TList<string>.Create;
        FKCols.Add(fkName, L);
      end;
      L.Add(col);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;
function ColumnDDL_NoAI(const ColName: string; const C: TColInfo): string;
var parts: TArray<string>;
begin
  parts := parts + [QI(ColName) + ' ' + C.ColType];
  if C.Charset <> '' then parts := parts + ['CHARACTER SET ' + C.Charset];
  if C.Collation <> '' then parts := parts + ['COLLATE ' + C.Collation];
  if SameText(C.IsNullable,'YES') then parts := parts + ['NULL'] else parts := parts + ['NOT NULL'];
  if C.DefaultSQL<>'' then parts := parts + [C.DefaultSQL];
  if (C.Comment <> '') then parts := parts + ['COMMENT ' + QuotedStr(C.Comment)];
  Result := String.Join(' ', parts);
end;
function ModifyCol_NoAI_SQL(const TName, ColName: string; const C: TColInfo): string;
begin
  Result := 'ALTER TABLE ' + QI(TName) + ' MODIFY COLUMN ' + ColumnDDL_NoAI(ColName, C) + ';';
end;
function AddCol_NoAI_SQL(const TName, ColName: string; const C: TColInfo): string;
begin
  Result := 'ALTER TABLE ' + QI(TName) + ' ADD COLUMN ' + ColumnDDL_NoAI(ColName, C) + ';';
end;
function ModifyCol_WithAI_SQL(const TName, ColName: string; const C: TColInfo): string;
var X: TColInfo; parts: TArray<string>;
begin
  X := C;
  if not IsAutoInc(X.Extra) then
    X.Extra := Trim(IfThen(X.Extra<>'', X.Extra + ' ', '') + 'AUTO_INCREMENT');
  parts := parts + [QI(ColName) + ' ' + X.ColType, 'NOT NULL', X.Extra];
  if X.Comment<>'' then parts := parts + ['COMMENT ' + QuotedStr(X.Comment)];
  Result := 'ALTER TABLE ' + QI(TName) + ' MODIFY COLUMN ' + String.Join(' ', parts) + ';';
end;
function PKDropSQL(const TName: string): string; inline;
begin
  Result := 'ALTER TABLE ' + QI(TName) + ' DROP PRIMARY KEY;';
end;
function PKAddSQL(const TName: string; const PKCols: TArray<string>): string; inline;
begin
  Result := 'ALTER TABLE ' + QI(TName) + ' ADD PRIMARY KEY (' + String.Join(', ', PKCols) + ');';
end;
function DropIndexSQL(const TName, Idx: string): string;
begin
  Result := 'DROP INDEX ' + QI(Idx) + ' ON ' + QI(TName) + ';';
end;
function AddIndexSQL(const TName, Idx: string; const Sig: string): string;
var cols: TArray<string>; i: Integer; list: string;
begin
  cols := Sig.Split([',']); // already upper with subparts
  for i := 0 to High(cols) do
    cols[i] := QI(Trim(cols[i]));
  list := String.Join(', ', cols);
  Result := 'ALTER TABLE ' + QI(TName) + ' ADD INDEX ' + QI(Idx) + ' (' + list + ');';
end;
function TmpIdxName(const TableName, ColName: string): string;
begin
  Result := Format('_tmp_ai_%s_%s',
    [Copy(LowerCase(StringReplace(TableName,'`','',[rfReplaceAll])),1,20),
     Copy(LowerCase(StringReplace(ColName,'`','',[rfReplaceAll])),1,20)]);
end;
function IsSafeModify(const Src, Dst: TColInfo; out Why: string): Boolean;
var sb, db: string; s1,s2,d1,d2: Integer;
begin
  Why := '';
  // Block NULL->NOT NULL
  if (SameText(Dst.IsNullable,'YES')) and (not SameText(Src.IsNullable,'YES')) then
  begin Why := 'NULL->NOT NULL bloqueado'; Exit(False); end;
  sb := TypeBase(Src.ColType);
  db := TypeBase(Dst.ColType);
  if SameText(sb, db) then
  begin
    if (sb='varchar') or (sb='char') then
    begin
      if ExtractSizePair(Src.ColType,s1,s2) and ExtractSizePair(Dst.ColType,d1,d2) then
      begin
        if s1 >= d1 then Exit(True);
        Why := Format('Redução tamanho %d->%d', [d1,s1]); Exit(False);
      end;
      Exit(True);
    end;
    if (sb='decimal') or (sb='numeric') then
    begin
      if ExtractSizePair(Src.ColType,s1,s2) and ExtractSizePair(Dst.ColType,d1,d2) then
      begin
        if (s1>=d1) and (s2>=d2) then Exit(True);
        Why := Format('Redução DECIMAL (%d,%d)->(%d,%d)', [d1,d2,s1,s2]); Exit(False);
      end;
      Exit(True);
    end;
    if Pos('int', sb)>0 then Exit(True); // same int family (display width)
    Exit(True);
  end
  else
  begin
    if IsCharLikeBase(sb) and IsCharLikeBase(db) then Exit(True);
    if (Pos('int', sb)>0) and (Pos('int', db)>0) then
    begin
      if IsSafeWidenInt(sb, db) then Exit(True)
      else begin Why := 'Inteiro -> menor/incompatível'; Exit(False); end;
    end;
    if ((sb='decimal') or (sb='numeric')) and ((db='decimal') or (db='numeric')) then Exit(True);
    Why := 'Troca de tipo potencialmente destrutiva'; Exit(False);
  end;
end;
procedure LoadTriggersSig(const Conn: TFDConnection; const DB: string; out Map: TDictionary<string,string>);
var Q: TFDQuery; key, sig: string;
begin
  Map := TDictionary<string,string>.Create;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text := 'SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING, EVENT_OBJECT_TABLE, ACTION_STATEMENT '+
                  'FROM information_schema.triggers WHERE TRIGGER_SCHEMA=:db';
    Q.ParamByName('db').AsString := DB;
    Q.Open;
    while not Q.Eof do
    begin
      key := UpperCase(Q.FieldByName('TRIGGER_NAME').AsString);
      sig := UpperCase(Q.FieldByName('ACTION_TIMING').AsString) + '|' +
             UpperCase(Q.FieldByName('EVENT_MANIPULATION').AsString) + '|' +
             UpperCase(Q.FieldByName('EVENT_OBJECT_TABLE').AsString) + '|' +
             Trim(StringReplace(Q.FieldByName('ACTION_STATEMENT').AsString, #13#10, ' ', [rfReplaceAll]));
      Map.AddOrSetValue(key, sig);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;
function CompareAndSyncSchemas(
  const SrcConn, DstConn: TFDConnection;
  const SrcDB, DstDB: string;
  const Opt: TSyncOptions;
  out Plan: TStringList
): Integer;
var
  srcTabs, dstTabs: TArray<string>;
  S, TName, C: string;
  i: Integer;
  srcCols, dstCols: TDictionary<string,TColInfo>;
  srcPK, dstPK: TArray<string>;
  srcIdx, dstIdx: TDictionary<string,string>;
  planList: TStringList;
  droppedPK: TDictionary<string,Boolean>;
  function ExistsIn(const Arr: TArray<string>; const Name: string): Boolean;
  var x: string;
  begin
    for x in Arr do if SameText(x, Name) then Exit(True);
    Result := False;
  end;
  function AddDiff(const SQL: string): Boolean;
  begin
    if SQL='' then Exit(False);
    planList.Add(SQL);
    Exit(True);
  end;
  procedure RemoveAIIfAny(const TableName: string; const Cols: TDictionary<string,TColInfo>);
  var k: string; info: TColInfo;
  begin
    for k in Cols.Keys do
      if Cols.TryGetValue(k, info) and IsAutoInc(info.Extra) then
      begin
        info.Extra := Trim(StringReplace(info.Extra, 'auto_increment', '', [rfReplaceAll, rfIgnoreCase]));
        AddDiff(ModifyCol_NoAI_SQL(TableName, k, info));
      end;
  end;
begin
  Plan := TStringList.Create;
  planList := TStringList.Create;
  droppedPK := TDictionary<string,Boolean>.Create;
  SrcConn.ExecSQL('USE ' + QI(SrcDB));
  DstConn.ExecSQL('USE ' + QI(DstDB));
  LogInit(SrcDB, DstDB);
  LoadTables(SrcConn, SrcDB, srcTabs);
  LoadTables(DstConn, DstDB, dstTabs);
  // Create missing tables in destination
  for S in srcTabs do
    if not ExistsIn(dstTabs, S) then
      AddDiff(ShowCreateTable(SrcConn, SrcDB, S));
  // Tables present in both
  for S in srcTabs do
  begin
    if not ExistsIn(dstTabs, S) then Continue;
    LoadColumns(SrcConn, SrcDB, S, srcCols, srcPK);
    LoadColumns(DstConn, DstDB, S, dstCols, dstPK);
    LoadIndexes(SrcConn, SrcDB, S, srcIdx);
    LoadIndexes(DstConn, DstDB, S, dstIdx);
    // 1) ADD/MODIFY (safe, no AI)
    for C in srcCols.Keys do
    begin
      var sInfo, dInfo: TColInfo;
      srcCols.TryGetValue(C, sInfo);
      if not dstCols.TryGetValue(C, dInfo) then
        AddDiff(AddCol_NoAI_SQL(S, C, sInfo))
      else
      begin
        var why: string;
        if (LowerNoSpaces(sInfo.ColType) <> LowerNoSpaces(dInfo.ColType)) or
           (SameText(sInfo.IsNullable,'YES') <> SameText(dInfo.IsNullable,'YES')) or
           (sInfo.Charset <> dInfo.Charset) or
           (sInfo.Collation <> dInfo.Collation) or
           (sInfo.Comment <> dInfo.Comment) or
           (sInfo.DefaultSQL <> dInfo.DefaultSQL) then
        begin
          if IsSafeModify(sInfo, dInfo, why) then
            AddDiff(ModifyCol_NoAI_SQL(S, C, sInfo))
          else
            LogLine(Format('-- WARNING: PULADO MODIFY em %s.%s (%s)', [S, C, why]));
        end;
      end;
    end;
    // 2) DROP extra columns (only those not in source)
    if Opt.DropExtras then
    begin
      // Drop FKs that reference extra columns first
      var fkCols: TObjectDictionary<string, TList<string>>;
      LoadFKsForTable(DstConn, DstDB, S, fkCols);
      try
        for C in dstCols.Keys do
        begin
          if not srcCols.ContainsKey(C) then
          begin
            for var fkName in fkCols.Keys do
            begin
              var L := fkCols[fkName];
              for var colInFk in L do
                if SameText(colInFk, C) then
                begin
                  AddDiff('ALTER TABLE ' + QI(S) + ' DROP FOREIGN KEY ' + QI(fkName) + ';');
                  Break;
                end;
            end;
          end;
        end;
      finally
        fkCols.Free;
      end;
      // Drop indexes that use extra columns
      for TName in dstIdx.Keys do
      begin
        var sig := dstIdx[TName];
        for C in dstCols.Keys do
          if (not srcCols.ContainsKey(C)) and (Pos(UpperCase(C), sig) > 0) then
          begin
            AddDiff(DropIndexSQL(S, TName));
            Break;
          end;
      end;
      // If PK uses an extra column, drop AI and PK (once)
      var needDropPK := False;
      for var pkq in dstPK do
      begin
        var plain := StringReplace(pkq, '`', '', [rfReplaceAll]);
        if not srcCols.ContainsKey(plain) then begin needDropPK := True; Break; end;
      end;
      if needDropPK then
      begin
        if not droppedPK.ContainsKey(S) then
        begin
          RemoveAIIfAny(S, dstCols);
          AddDiff(PKDropSQL(S));
          droppedPK.AddOrSetValue(S, True);
        end;
      end;
      // Finally drop the extra columns
      for C in dstCols.Keys do
        if not srcCols.ContainsKey(C) then
          AddDiff('ALTER TABLE ' + QI(S) + ' DROP COLUMN ' + QI(C) + ';');
    end;
    // 3) PK diff (guard AI)
    var samePK := (Length(srcPK)=Length(dstPK));
    if samePK then
      for i := 0 to High(srcPK) do
        if not SameText(srcPK[i], dstPK[i]) then begin samePK := False; Break; end;
    if not samePK then
    begin
      if Length(dstPK)>0 then
      begin
        RemoveAIIfAny(S, dstCols);
        if not droppedPK.ContainsKey(S) then
        begin
          AddDiff(PKDropSQL(S));
          droppedPK.AddOrSetValue(S, True);
        end;
      end;
      if Length(srcPK)>0 then
        AddDiff(PKAddSQL(S, srcPK));
    end;
    // 4) Secondary indexes: add/update, drop extras
    for TName in srcIdx.Keys do
    begin
      var sSig, dSig: string;
      srcIdx.TryGetValue(TName, sSig);
      if (not dstIdx.TryGetValue(TName, dSig)) then
        AddDiff(AddIndexSQL(S, TName, sSig))
      else if not SameText(sSig, dSig) then
      begin
        AddDiff(DropIndexSQL(S, TName));
        AddDiff(AddIndexSQL(S, TName, sSig));
      end;
    end;
    if Opt.DropExtras then
      for TName in dstIdx.Keys do
        if not srcIdx.ContainsKey(TName) then
          AddDiff(DropIndexSQL(S, TName));
    // 5) AUTO_INCREMENT (ensure key via temp index)
    var srcAI := '';
    for TName in srcCols.Keys do if IsAutoInc(srcCols[TName].Extra) then begin srcAI := TName; Break; end;
    var dstAI := '';
    for TName in dstCols.Keys do if IsAutoInc(dstCols[TName].Extra) then begin dstAI := TName; Break; end;
    if (dstAI <> '') and (not SameText(srcAI, dstAI)) then
    begin
      var di := dstCols[dstAI];
      di.Extra := Trim(StringReplace(di.Extra, 'auto_increment', '', [rfReplaceAll, rfIgnoreCase]));
      AddDiff(ModifyCol_NoAI_SQL(S, dstAI, di));
    end;
    if srcAI <> '' then
    begin
      var si := srcCols[srcAI];
      var tmp := TmpIdxName(S, srcAI);
      AddDiff('ALTER TABLE ' + QI(S) + ' ADD INDEX ' + QI(tmp) + ' (' + QI(srcAI) + ');');
      AddDiff(ModifyCol_WithAI_SQL(S, srcAI, si));
      AddDiff(DropIndexSQL(S, tmp));
    end;
    // Free per-table maps
    srcCols.Free;
    dstCols.Free;
    srcIdx.Free;
    dstIdx.Free;
  end;
  // Drop extra tables
  if Opt.DropExtras then
  begin
    for S in dstTabs do
      if not ExistsIn(srcTabs, S) then
        AddDiff('DROP TABLE ' + QI(S) + ';');
  end;
  // Triggers
  if Opt.IncludeTriggers then
  begin
    var srcTrg, dstTrg: TDictionary<string,string>;
    LoadTriggersSig(SrcConn, SrcDB, srcTrg);
    LoadTriggersSig(DstConn, DstDB, dstTrg);
    try
      for TName in srcTrg.Keys do
      begin
        var sSig := srcTrg[TName]; var dSig: string;
        if not dstTrg.TryGetValue(TName, dSig) then
        begin
          // Create from source definition
          var QQ := TFDQuery.Create(nil);
          try
            QQ.Connection := SrcConn;
            QQ.SQL.Text := 'SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING, EVENT_OBJECT_TABLE, ACTION_STATEMENT ' +
                           'FROM information_schema.triggers WHERE TRIGGER_SCHEMA=:db AND TRIGGER_NAME=:n';
            QQ.ParamByName('db').AsString := SrcDB;
            QQ.ParamByName('n').AsString := TName;
            QQ.Open;
            if not QQ.Eof then
              AddDiff('CREATE TRIGGER ' + QI(QQ.FieldByName('TRIGGER_NAME').AsString) + ' ' +
                      QQ.FieldByName('ACTION_TIMING').AsString + ' ' +
                      QQ.FieldByName('EVENT_MANIPULATION').AsString + ' ON ' +
                      QI(QQ.FieldByName('EVENT_OBJECT_TABLE').AsString) + ' FOR EACH ROW ' +
                      QQ.FieldByName('ACTION_STATEMENT').AsString + ';');
          finally
            QQ.Free;
          end;
        end
        else if not SameText(sSig, dSig) then
        begin
          AddDiff('DROP TRIGGER ' + QI(TName) + ';');
          var QQ := TFDQuery.Create(nil);
          try
            QQ.Connection := SrcConn;
            QQ.SQL.Text := 'SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING, EVENT_OBJECT_TABLE, ACTION_STATEMENT ' +
                           'FROM information_schema.triggers WHERE TRIGGER_SCHEMA=:db AND TRIGGER_NAME=:n';
            QQ.ParamByName('db').AsString := SrcDB;
            QQ.ParamByName('n').AsString := TName;
            QQ.Open;
            if not QQ.Eof then
              AddDiff('CREATE TRIGGER ' + QI(QQ.FieldByName('TRIGGER_NAME').AsString) + ' ' +
                      QQ.FieldByName('ACTION_TIMING').AsString + ' ' +
                      QQ.FieldByName('EVENT_MANIPULATION').AsString + ' ON ' +
                      QI(QQ.FieldByName('EVENT_OBJECT_TABLE').AsString) + ' FOR EACH ROW ' +
                      QQ.FieldByName('ACTION_STATEMENT').AsString + ';');
          finally
            QQ.Free;
          end;
        end;
      end;
      if Opt.DropExtras then
        for TName in dstTrg.Keys do
          if not srcTrg.ContainsKey(TName) then
            AddDiff('DROP TRIGGER ' + QI(TName) + ';');
    finally
      srcTrg.Free;
      dstTrg.Free;
    end;
  end;
  // Save plan
  LogPlan(planList);
  if Opt.Execute and (planList.Count>0) and (not GSyncDryRun) then
    ExecBatch(DstConn, planList)
  else if GSyncDryRun then
    LogLine('-- DRY-RUN: plano salvo, nenhuma DDL executada.');
  Plan.Assign(planList);
  Result := planList.Count;
  planList.Free;
  droppedPK.Free;
end;
end.

