unit EncodeUtilTest;

interface

uses
  EncodeUtil, TestFramework;

type
  TTestCaseEncodeUtil = class(TTestCase)
    procedure TestWideToUtf8;
    procedure TestUtf8ToWide;
  end;

procedure RegisterTests;

implementation

// WideStringをUTF-8に変換するテストです。
procedure TTestCaseEncodeUtil.TestWideToUtf8;
const
  STR1 = 'abcde';
  STR2 = 'あいうえお';
var
  s1, s2: UTF8String;
begin
  // 半角英数字を変換するテストです。
  s1 := Utf8Decode(STR1);
  CheckEquals(STR1, WideToUtf8(s1), '"' + STR1 + '" is not UTF8String.');

  // 全角文字を変換するテストです。
  s2 := Utf8Decode(STR2);
  CheckEquals(STR2, WideToUtf8(s2), '"' + STR2 + '" is not UTF8String.');
end;

// UTF-8をWideStringに変換するテストです。
procedure TTestCaseEncodeUtil.TestUtf8ToWide;
const
  STR1 = 'abcde';
  STR2 = 'あいうえお';
var
  s1, s2: WideString;
begin
  // 半角英数字を変換するテストです。
  s1 := Utf8Decode(STR1);
  CheckEquals(s1, Utf8ToWide(STR1), '"' + STR1 + '" is not WideString.');

  // 全角文字を変換するテストです。
  s2 := Utf8Decode(STR2);
  CheckEquals(s2, Utf8ToWide(STR2), '"' + STR2 + '" is not WideString.');
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseEncodeUtil.Suite);
end;

end.
