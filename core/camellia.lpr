program camellia;

{$L camellia.obj}

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

begin

end.
{$ENDIF}
