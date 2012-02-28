unit PathUtil;

interface

uses
  JwaWinBase, JwaShellAPI, JwaWinType, StrUtil;

function ExeName: WideString;
function ExtractFileDir(const FileName: WideString): WideString;
function ExtractFileExt(const FileName: WideString): WideString;
function ExtractFileName(const FileName: WideString): WideString;
function ExtractFilePath(const FileName: WideString): WideString;
function LastDelimiter(const Delimiters, S: WideString): Integer;

implementation

// 実行ファイルの絶対パスを返します。
function ExeName: WideString;
var
  Len: Integer;
  Buffer: array[0..MAX_PATH - 1] of WideChar;
begin
  Len := GetModuleFileNameW(0, Buffer, MAX_PATH - 1);
  if (Len <> 0) then
    SetString(Result, Buffer, Len)
  else
    Result := WideString(ParamStr(0));
end;

// ファイル名を除いたパスを返します。
// 末尾に区切り文字は付加されません。
//
// * FileName
//     * 抽出されるファイルパスです。
function ExtractFileDir(const FileName: WideString): WideString;
var
  Index: Integer;
begin
  Index := LastDelimiter('\:', FileName);
  if (Index > 0) then
    SetString(Result, PWideChar(FileName), Index - 1)
  else
    Result := '';
end;

// ファイル名のドットを含めた拡張子部分を返す関数です。
//
// * FileName
//     * 抽出されるファイルパスです。
function ExtractFileExt(const FileName: WideString): WideString;
var
  Index: Integer;
begin
  Index := LastDelimiter('.', FileName);
  if (Index > 0) then
    SetString(Result, PWideChar(FileName) + Index - 1,
      Length(FileName) - Index + 1)
  else
    Result := '';
end;

// ファイル名と拡張子を返す関数です。
//
// * FileName
//     * 抽出されるファイルパスです。
function ExtractFileName(const FileName: WideString): WideString;
var
  Index: Integer;
begin
  Index := LastDelimiter('\', FileName);
  if (Index > 0) then
    SetString(Result, PWideChar(FileName) + Index, Length(FileName) - Index)
  else
    Result := '';
end;

// ファイル名を除いたパスを返す関数です。末尾に区切り文字が付加されます。
//
// * FileName
//     * 抽出されるファイルパスです。
function ExtractFilePath(const FileName: WideString): WideString;
var
  Index: Integer;
begin
  Index := LastDelimiter('\:', FileName);
  if (Index > 0) then
    SetString(Result, PWideChar(FileName), Index)
  else
    Result := '';
end;

// 文字列の後方に一番近い区切り文字の位置を返します。
//
// * Delimiters
//     * 検索する区切り文字の集まりです。
// * S
//     * 検索元となる文字列です。
function LastDelimiter(const Delimiters, S: WideString): Integer;
var
  P1, P2: PWideChar;
begin
  P1 := PWideChar(S);
  P2 := PWideChar(Delimiters);
  Result := Length(S);

  while (Result > -1) do
  begin
    // 文字位置がヌル文字でなく、区切り文字のいずれかであった場合、ループを抜けます。
    if (P1[Result] <> #$0000) and (StrScan(P2, P1[Result]) <> nil) then
      Break;
    Dec(Result);
  end;

  Inc(Result);
end;

end.
