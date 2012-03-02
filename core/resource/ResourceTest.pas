unit ResourceTest;

interface

uses
  Resource, TestFramework;

type
  PTestResource = ^TTestResource;
  TTestResource = class(TTestCase)
  published
    procedure TestLoadMainIcon;
  end;

implementation

// メインのアイコンリソースが失敗せず、
// 正常に読み込めることを確認するテストです。
procedure TestLoadMainIcon;
begin
  Check(LoadMainIcon(isSmall) <> 0, 'failed LoadMainIcon(isSmall).');
  Check(LoadMainIcon(isNormal) <> 0, 'failed LoadMainIcon(isNormal).');
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseResource.Suite);
end;

end.
