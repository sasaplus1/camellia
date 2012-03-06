unit CommandListTest;

interface

uses
  Command, CommandList, TestFramework;

type
  TTestCaseCommandList = class(TTestCase)
  published
    procedure TestAddAndGet;
  end;

procedure RegisterTests;

implementation

// コマンドの追加と取得をテストします。
procedure TTestCaseCommandList.TestAddAndGet;
var
  Command: TCommand;
  CommandList: TCommandList;
begin
  CommandList := TCommandList.Create;
  try
    // 何も追加されていない状態のカウントをテストします。
    CheckEquals(0, CommandList.Count, 'CommandList already added items.');

    // コマンド追加のテストをします。
    CommandList.Add(1, Utf8Decode('first'));
    CheckEquals(1, CommandList.Count, 'CommandList.Count is not 1.');
    CheckEquals(1, CommandList[0].Id, '[0].Id is not 1.');
    CheckEquals(Utf8Decode('first'), CommandList[0].Name, '[0].Name is not "first".');

    // コマンド追加のテストをします。
    Command.Id := 2;
    Command.Name := 'second';
    CommandList.Add(Command);
    CheckEquals(2, CommandList.Count, 'CommandList.Count is not 2.');
    CheckEquals(2, CommandList[1].Id, '[1].Id is not 2.');
    CheckEquals(Utf8Decode('second'), CommandList[1].Name, '[1].Name is not "second".');
  finally
    CommandList.Free;
  end;
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseCommandList.Suite);
end;

end.
