program camellia;

{$IFDEF TEST}
uses
  EncodeUtilTest, TextTestRunner;

begin
  EncodeUtilTest.RegisterTests;
  RunRegisteredTests;
end.
{$ELSE}

{$R *.res}

begin

end.
{$ENDIF}
