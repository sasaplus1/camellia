program camellia;

{$L camellia.obj}

{$IFDEF TEST}
uses
  CommandListTest, EncodeUtilTest, FindFileTest, PathUtilTest, PluginTest,
  PluginContainerTest, PluginListTest, StrUtilTest, TextTestRunner;

begin
  CommandListTest.RegisterTests;
  EncodeUtilTest.RegisterTests;
  FindFileTest.RegisterTests;
  PathUtilTest.RegisterTests;
  PluginTest.RegisterTests;
  PluginContainerTest.RegisterTests;
  PluginListTest.RegisterTests;
  StrUtilTest.RegisterTests;
  RunRegisteredTests;
end.
{$ELSE}
begin

end.
{$ENDIF}
