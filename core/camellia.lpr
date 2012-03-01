program camellia;

{$IFDEF TEST}
uses
  EncodeUtilTest, FindFileTest, PathUtilTest, StrUtilTest, TextTestRunner;

begin
  EncodeUtilTest.RegisterTests;
  FindFileTest.RegisterTests;
  PathUtilTest.RegisterTests;
  StrUtilTest.RegisterTests;
  RunRegisteredTests;
end.
{$ELSE}

{$L camellia.obj}

begin

end.
{$ENDIF}
