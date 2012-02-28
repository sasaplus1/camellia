unit StrUtilTest;

interface

uses
  StrUtil, TestFramework;

type
  PTestCaseStrUtil = ^TTestCaseStrUtil;
  TTestCaseStrUtil = class(TTestCase)
  published
    procedure TestStrEnd;
    procedure TestStrLen;
    procedure TestStrRScan;
    procedure TestStrScan;
  end;

procedure RegisterTests;

implementation

// 文字列の最後の位置が返されるかどうかを確認するテストです。
procedure TTestCaseStrUtil.TestStrEnd;
const
  STR1 = 'あいう';
var
  S1, R1: PWideChar;
begin
  S1 := PWideChar(Utf8Decode(STR1));
  R1 := StrEnd(S1);
  CheckEquals(#$0000, R1^, '"' + STR1 + '" has not "#$0000".');

  R1 := StrEnd(nil);
  Check(not Assigned(R1), '"(nil)" not equal nil.');
end;

// ヌル文字までの長さを返されるかどうかを確認するテストです。
procedure TTestCaseStrUtil.TestStrLen;
const
  STR1 = 'abc';
  STR2 = 'あいう';
  STR3 = 'あ' + #$00 + 'あ';
var
  S1, S2, S3: PWideChar;
begin
  S1 := PWideChar(Utf8Decode(STR1));
  S2 := PWideChar(Utf8Decode(STR2));
  S3 := PWideChar(Utf8Decode(STR3));
  CheckEquals(3, StrLen(S1), '"' + STR1 + '" is not 3 length.');
  CheckEquals(3, StrLen(S2), '"' + STR2 + '" is not 3 length.');
  CheckEquals(1, StrLen(S3), '"' + STR3 + '" is not 1 length.');
end;

// 文字を正常に検索できるかどうか確認するテストです。
procedure TTestCaseStrUtil.TestStrRScan;
const
  STR1 = '/usr/local/bin';
var
  S1, R1: PWideChar;
begin
  S1 := PWideChar(Utf8Decode(STR1));
  R1 := StrRScan(S1, '/');
  CheckEquals('/', WideString(R1^), '"/" not found.');

  R1 := StrRScan(S1, 'n');
  CheckEquals('n', WideString(R1^), '"n" not found.');

  R1 := StrRScan(S1, '$');
  Check(not Assigned(R1), '"$" found.');
end;

// 文字を正常に検索できるかどうか確認するテストです。
procedure TTestCaseStrUtil.TestStrScan;
const
  STR1 = '/usr/local/bin';
var
  S1, R1: PWideChar;
begin
  S1 := PWideChar(Utf8Decode(STR1));
  R1 := StrScan(S1, '/');
  CheckEquals('/', WideString(R1^), '"/" not found.');

  R1 := StrScan(S1, 'n');
  CheckEquals('n', WideString(R1^), '"n" not found.');

  R1 := StrScan(S1, '$');
  Check(not Assigned(R1), '"$" found.');
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseStrUtil.Suite);
end;

end.
