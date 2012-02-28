unit StrUtil;

interface

function StrEnd(const Str: PWideChar): PWideChar;
function StrLen(const Str: PWideChar): Cardinal;
function StrRScan(const Str: PWideChar; Chr: WideChar): PWideChar;
function StrScan(const Str: PWideChar; Chr: WideChar): PWideChar;

implementation

// 文字列の最後の位置のポインタを返します。
//
// * Str
//     * 検索する文字列へのポインタです。
function StrEnd(const Str: PWideChar): PWideChar;
begin
  Result := nil;
  if Assigned(Str) then
    Result := Str + StrLen(Str);
end;

// 文字列の長さを返します。
//
// * Str
//     * 検索する文字列へのポインタです。
function StrLen(const Str: PWideChar): Cardinal;
begin
  Result := 0;

  if not Assigned(Str) then
    Exit;

  // ヌル文字が見つかるまで位置をインクリメントします。
  while (Str[Result] <> #0000) do
    Inc(Result);
end;

// 文字を文字列の後方から検索し、
// 見つかった場合はその位置のポインタを返します。
//
// * Str
//     * 検索する文字列へのポインタです。
// * Chr
//     + 検索する文字です。
function StrRScan(const Str: PWideChar; Chr: WideChar): PWideChar;
var
  Index: Integer;
begin
  Index := StrLen(Str) + 1;

  // 文字列長を超えるか、Chrが現れるまで文字位置をデクリメントします。
  while (Index > 0) and (Str[Index] <> Chr) do
    Dec(Index);

  if (Index = 0) then
    Result := nil
  else
    Result := @Str[Index];
end;

// 文字を文字列の前方から検索し、
// 見つかった場合はその位置のポインタを返します。
//
// * Str
//     * 検索する文字列へのポインタです。
// * Chr
//     + 検索する文字です。
function StrScan(const Str: PWideChar; Chr: WideChar): PWideChar;
var
  Index, LastIndex: Integer;
begin
  Index := 0;
  LastIndex := StrLen(Str) + 1;

  // 文字列長を超えるか、Chrが現れるまで文字位置をインクリメントします。
  while (LastIndex > Index) and (Str[Index] <> Chr) do
    Inc(Index);

  if (Index = LastIndex) then
    Result := nil
  else
    Result := @Str[Index];
end;

end.
