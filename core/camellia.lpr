program camellia;

{$IFDEF TEST}
uses
  EncodeUtilTest, FindFileTest, TextTestRunner;

begin
  EncodeUtilTest.RegisterTests;
  FindFileTest.RegisterTests;
  RunRegisteredTests;
end.
{$ELSE}

{$R *.res}

begin

end.
{$ENDIF}
