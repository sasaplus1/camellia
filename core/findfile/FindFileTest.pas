unit FindFileTest;

interface

uses
  FindFile, SysUtils, TestFramework, Types;

type
  PTestCaseFindFile = ^TTestCaseFindFile;
  TTestCaseFindFile = class(TTestCase)
  published
    procedure TestFindFiles;
  end;

procedure RegisterTests;

implementation

// ファイル検索をするテストです。
procedure TTestCaseFindFile.TestFindFiles;
const
  EXT = '.txt';
  FILE1 = 'aaa.txt';
  FILE2 = 'bbb.txt';
  FILE3 = 'ccc.txt';
  PATH = 'files\';
var
  i: Integer;
  Files: TWideStringDynArray;
begin
  // テストディレクトリから".txt"を検索します。
  Files := FindFiles(Utf8Decode(ExtractFilePath(ParamStr(0)) + PATH),
    Utf8Decode(EXT));

  // ファイル数が一致しているか確認します。
  CheckEquals(3, Length(Files), 'File count is not 3.');

  // ファイル名が一致しているか確認します。
  for i := 0 to High(Files) do
    Check((Files[i] = Utf8Decode(FILE1)) or
      (Files[i] = Utf8Decode(FILE2)) or
      (Files[i] = Utf8Decode(FILE3)),
      'Is an unknown filename "' + Files[i] + '".');
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseFindFile.Suite);
end;

end.
