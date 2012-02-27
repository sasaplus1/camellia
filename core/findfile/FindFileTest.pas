unit FindFileTest;

interface

uses
  FindFile, TestFramework, Types;

type
  PTestCaseFindFile = ^TTestCaseFindFile;
  TTestCaseFindFile = class(TTestCase)
    procedure TestFindFiles;
  end;

procedure RegisterTests;

implementation

// ファイル検索をするテストです。
procedure TTestCaseFindFile.TestFindFiles;
const
  EXT = '.exe';
  FILENAME = '.\camellia.exe';
  PATH = '.\';
var
  Files: TWideStringDynArray;
begin
  // カレントディレクトリから".exe"を検索するテストです。
  Files := FindFiles(Utf8Decode(PATH), Utf8Decode(EXT));
  CheckEquals(1, Length(Files), 'File count is not 1.');
  CheckEquals(Utf8Decode(FILENAME), Files[0],
    'Files[0] is not "' + FILENAME + '".');
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseFindFile.Suite);
end;

end.
