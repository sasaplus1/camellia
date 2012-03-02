unit ResourceTest;

interface

uses
  Resource, TestFramework;

type
  PTestResource = ^TTestResource;
  TTestResource = class(TTestCase)
  published
    procedure TestLoadMainIcon;
  end;

implementation

// ���C���̃A�C�R�����\�[�X�����s�����A
// ����ɓǂݍ��߂邱�Ƃ��m�F����e�X�g�ł��B
procedure TestLoadMainIcon;
begin
  Check(LoadMainIcon(isSmall) <> 0, 'failed LoadMainIcon(isSmall).');
  Check(LoadMainIcon(isNormal) <> 0, 'failed LoadMainIcon(isNormal).');
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCaseResource.Suite);
end;

end.
