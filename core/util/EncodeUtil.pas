unit EncodeUtil;

interface

uses
  JwaWinBase, JwaWinNLS, JwaWinNT;

function WideToUtf8(const S: WideString): UTF8String;
function Utf8ToWide(const S: UTF8String): WideString;

implementation

// WideStringをUTF-8に変換して返します。
function WideToUtf8(const S: WideString): UTF8String;
var
  Len: Integer;
  Buf: PAnsiChar;
begin
  Result := '';

  // WideStringをUTF-8に変換した後のバイトサイズを取得し、メモリを取得します。
  Len := WideCharToMultiByte(CP_UTF8, 0, PWideChar(S), -1, nil, 0, nil, nil);
  Buf := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY, Len + 1);

  // バイトサイズを取得できない、またはメモリが取得できなかった場合終了します。
  if (Len = 0) or not Assigned(Buf) then
    Exit;

  try
    WideCharToMultiByte(CP_UTF8, 0, PWideChar(S), -1, Buf, Len + 1, nil, nil);
    Result := UTF8String(Buf);
  finally
    HeapFree(GetProcessHeap, 0, Buf);
  end;
end;

// UTF-8をWideStringにして返します。
function Utf8ToWide(const S: UTF8String): WideString;
var
  Len: Integer;
  Buf: PWideChar;
begin
  Result := '';

  // UTF-8をWideStringに変換した後のバイトサイズを取得し、メモリを取得します。
  Len := MultiByteToWideChar(CP_UTF8, 0, PAnsiChar(S), -1, nil, 0);
  Buf := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY, (Len + 1) * 2);

  // バイトサイズを取得できない、またはメモリが取得できなかった場合終了します。
  if (Len = 0) or not Assigned(Buf) then
    Exit;

  try
    MultiByteToWideChar(CP_UTF8, 0, PAnsiChar(S), -1, Buf, Len + 1);
    Result := WideString(Buf);
  finally
    HeapFree(GetProcessHeap, 0, Buf);
  end;
end;

end.
