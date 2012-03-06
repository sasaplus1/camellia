unit PluginListTest;

interface

uses
  PluginList, TestFramework;

type
  TTestCasePluginList = class(TTestCase)
  published
    procedure TestAddAndGet;
  end;

procedure RegisterTests;

implementation

procedure TTestCasePluginList.TestAddAndGet;
const
  PLUGIN_ID = 1;
  PLUGIN_FILENAME = 'LoadSuccessPlugin.dll';
var
  PluginList: TPluginList;
begin
  PluginList := TPluginList.Create;
  try
    PluginList.Add(Utf8Decode(PLUGIN_FILENAME), PLUGIN_ID);
    CheckEquals(Utf8Decode('LoadSuccessPlugin.dll'), PluginList[0].FileName,
      '[0].FileName is not "LoadSuccessPlugin.dll".');
    CheckEquals(1, PluginList[0].Id, '[0].Id is not 1.');
  finally
    PluginList.Free;
  end;
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCasePluginList.Suite);
end;

end.
