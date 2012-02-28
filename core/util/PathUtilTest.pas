unit PathUtilTest;

interface

uses
  PathUtil, TestFramework;

type
  PTestCasePathUtil = ^TTestCasePathUtil;
  TTestCasePathUtil = class(TTestCase)
  published
    procedure TestExeName;
    procedure TestExtractFileDir;
    procedure TestExtractFileExt;
    procedure TestExtractFileName;
    procedure TestExtractFilePath;
    procedure TestLastDelimiter;
  end;

procedure RegisterTests;

implementation

// 実行ファイルのフルパスが抽出されるかどうかを確認するテストです。
procedure TTestCasePathUtil.TestExeName;
var
  S1, S2: WideString;
begin
  S1 := ExtractFileName(WideString(ParamStr(0)));
  S2 := ExtractFileName(ExeName);
  // コマンドプロンプトから実行する場合、フルパスで実行した場合のみ成功します。
  CheckEquals(S1, S2, S2 + ' is not equals ParamStr(0).');
end;

// ファイル名以外が抽出されるかどうかを確認するテストです。
procedure TTestCasePathUtil.TestExtractFileDir;
const
  STR1 = 'C:\WINDOWS\notepad.exe';
var
  S1: WideString;
begin
  S1 := Utf8Decode(STR1);
  CheckEquals('C:\WINDOWS', ExtractFileDir(S1), 'not equal "C:\WINDOWS".');
end;

// 拡張子が抽出されるかどうかを確認するテストです。
procedure TTestCasePathUtil.TestExtractFileExt;
const
  STR1 = 'C:\WINDOWS\notepad.exe';
var
  S1: WideString;
begin
  S1 := Utf8Decode(STR1);
  CheckEquals('.exe', ExtractFileExt(S1), 'not equal ".exe".');
end;

// ファイル名が抽出されるかどうかを確認するテストです。
procedure TTestCasePathUtil.TestExtractFileName;
const
  STR1 = 'C:\WINDOWS\notepad.exe';
var
  S1: WideString;
begin
  S1 := Utf8Decode(STR1);
  CheckEquals('notepad.exe', ExtractFileName(S1), 'not equal "notepad.exe".');
end;

// ファイル名以外が抽出されるかどうかを確認するテストです。
procedure TTestCasePathUtil.TestExtractFilePath;
const
  STR1 = 'C:\WINDOWS\notepad.exe';
var
  S1: WideString;
begin
  S1 := Utf8Decode(STR1);
  CheckEquals('C:\WINDOWS\', ExtractFilePath(S1), 'not equal "C:\WINDOWS\".');
end;

// 末尾から文字を検索するテストです。
procedure TTestCasePathUtil.TestLastDelimiter;
const
  STR1 = 'C:\WINDOWS\notepad.exe';
var
  S1: WideString;
begin
  S1 := Utf8Decode(STR1);
  CheckEquals(2, LastDelimiter(Utf8Decode(':'), S1), '":" position is not 2.');
  CheckEquals(5, LastDelimiter(Utf8Decode('I'), S1), '"I" position is not 5.');
  CheckEquals(9, LastDelimiter(Utf8Decode('WN'), S1), '"W" position is not 9.');
  CheckEquals(0, LastDelimiter(Utf8Decode('$'), S1), '"$" position is not 0');
  CheckEquals(0, LastDelimiter(Utf8Decode('あ'), S1), '"あ" position is not 0');
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCasePathUtil.Suite);
end;

end.
