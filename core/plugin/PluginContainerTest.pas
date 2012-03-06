unit PluginContainerTest;

interface

uses
  Command, Plugin, PluginContainer, SysUtils, TestFramework;

type
  TTestCasePluginContainer = class(TTestCase)
  private
    FPluginContainer: TPluginContainer;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddCommandAndGetCommand;
    procedure TestFindCommand;
    procedure TestMainProc;
    procedure TestProperties;
  end;

procedure RegisterTests;

implementation

const
  PLUGIN_ID = 1;
  PLUGIN_FILENAME = 'LoadSuccessPlugin.dll';

procedure TTestCasePluginContainer.SetUp;
begin
  FPluginContainer := TPluginContainer.Create(Utf8Decode(PLUGIN_FILENAME), PLUGIN_ID);
end;

procedure TTestCasePluginContainer.TearDown;
begin
  FPluginContainer.Free;
end;

// コマンドの追加と取得をテストします。
procedure TTestCasePluginContainer.TestAddCommandAndGetCommand;
var
  Command: TCommand;
begin
  Command.Id := 1;
  Command.Name := 'first';

  with FPluginContainer do
  begin
    AddCommand(Command);
    CheckEquals(1, GetCommand(0).Id, 'Id is not 1.');
    CheckEquals('first', GetCommand(0).Name, 'Name is not "first".');

    AddCommand(2, 'second');
    CheckEquals(2, GetCommand(1).Id, 'Id is not 2.');
    CheckEquals('second', GetCommand(1).Name, 'Name is not "second".');
  end;
end;

// コマンドの検索をテストします。
procedure TTestCasePluginContainer.TestFindCommand;
begin
  with FPluginContainer do
  begin
    AddCommand(1, 'first');
    CheckEquals(1, FindCommand(1).Id, 'failed FindCommand(1).');

    AddCommand(2, 'second');
    CheckEquals(2, FindCommand(2).Id, 'failed FindCommand(2).');

    AddCommand(3, 'third');
    CheckEquals(3, FindCommand(3).Id, 'failed FindCommand(3).');
  end;
end;

// メッセージハンドラの呼び出しをテストします。
procedure TTestCasePluginContainer.TestMainProc;
begin
  try
    FPluginContainer.MainProc(0, 0, 0);
  except
    Fail('failed call MainProc.');
  end;
  Check(true);
end;

// プラグインのプロパティをテストします。
procedure TTestCasePluginContainer.TestProperties;
begin
  with FPluginContainer do
  begin
    Check(psSuccess = Status, 'failed load "' + PLUGIN_FILENAME + '".');
    CheckEquals(PLUGIN_FILENAME, FileName, 'FileName is not "' + PLUGIN_FILENAME + '".');
    CheckEquals(PLUGIN_ID, Id, 'Id is not ' + IntToStr(PLUGIN_ID) + '.');
    CheckNotEquals(0, Handle, 'Handle is 0.');
  end;
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCasePluginContainer.Suite);
end;

end.
