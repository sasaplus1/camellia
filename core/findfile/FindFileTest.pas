unit FindFileTest;

interface

uses
  FindFile, TestFramework, Types;

type
  PTestCaseFindFile = ^TTestCaseFindFile;
  TTestCaseFindFile = class(TTestCase)
  protected
    procedure TestFindFiles;
  end;

procedure RegisterTests;

implementation

// FindFiles関数のテストをします。
procedure TTestCaseFindFile.TestFindFiles;
begin

end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseFindFile.Suite);
end;

end.
