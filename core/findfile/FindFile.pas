unit FindFile;

interface

uses
  Types, JwaWinBase, JwaWinError, JwaWinNT, JwaWinType;

function FindFiles(const Directory, FileExt: WideString): TWideStringDynArray;

implementation

// 指定されたディレクトリから拡張子に一致するファイルを検索して返します。
//
// * Directory
//     * 検索するディレクトリのパスです。末尾が"\"で終わる文字列を渡してください。
// * FileExt
//     * 検索するファイルの拡張子です。".dll"のような指定をしてください。
function FindFiles(const Directory, FileExt: WideString): TWideStringDynArray;
const
  DEFAULT_LENGTH = 16;
var
  Index: Integer;
  FindData: TWin32FindDataW;
  FindHandle: HANDLE;
begin
  Result := nil;

  // "ディレクトリ + * + 拡張子"で検索します。
  FindHandle := FindFirstFileW(PWideChar(Directory + '*' + FileExt), FindData);

  // 該当するファイルが存在しなかった場合、
  // 検索を終了します。
  if (FindHandle = INVALID_HANDLE_VALUE) or
    (GetLastError = ERROR_FILE_NOT_FOUND) then
    Exit;

  try

    Index := 0;
    SetLength(Result, DEFAULT_LENGTH);

    repeat

      // カレントディレクトリ、親ディレクトリは無視します。
      if (FindData.cFileName[0] = '.') or (FindData.cFileName = '..') then
        Continue;

      // フォルダは無視します。
      if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) then
        Continue;

      // 添字が動的配列の長さを超えていた場合、
      // 動的配列の要素数を2倍にします。
      if (Index > High(Result)) then
        SetLength(Result, Length(Result) * 2);

      // ファイル名を動的配列に代入します。
      with FindData do
        SetString(Result[Index], cFileName, lstrlenW(cFileName));
      Inc(Index);

    // ディレクトリ内の検索が終わるまでループします。
    until not FindNextFileW(FindHandle, FindData);

    //if (GetLastError <> ERROR_NO_MORE_FILE) then

    // 動的配列を要素分の長さに変更します。
    SetLength(Result, Index);

  finally
    FindClose(FindHandle);
  end;
end;

end.
