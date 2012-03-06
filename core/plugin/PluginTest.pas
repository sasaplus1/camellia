unit PluginTest;

interface

uses
  Plugin, SysUtils, TestFramework;

type
  TTestCasePlugin = class(TTestCase)
  published
    procedure TestGetProcError;
    procedure TestLoadError;
    procedure TestLoadSuccess;
  end;

procedure RegisterTests;

implementation

const
  GETPROC_ERROR_PLUGIN = 'GetProcErrorPlugin.dll';
  LOAD_ERROR_PLUGIN = '__not_a_.dll';
  LOAD_SUCCESS_PLUGIN = 'LoadSuccessPlugin.dll';

// DLLであるが、メッセージハンドラを持っていないプラグインを読み込むテストです。
procedure TTestCasePlugin.TestGetProcError;
var
  P: TPlugin;
begin
  P := TPlugin.Create(Utf8Decode(GETPROC_ERROR_PLUGIN), 1);
  with P do
  try
    Check(Status = psGetProcError, 'Status is not psGetProcError.');
    CheckEquals(GETPROC_ERROR_PLUGIN, FileName, 'FileName is not "' + GETPROC_ERROR_PLUGIN + '".');
    CheckEquals(1, Id, 'Id is not 1.');
    CheckNotEquals(0, Handle, 'Handle is 0.');
  finally
    P.Free;
  end;
end;

// 存在しないファイルを読み込むテストです。
procedure TTestCasePlugin.TestLoadError;
var
  P: TPlugin;
begin
  P := TPlugin.Create(Utf8Decode(LOAD_ERROR_PLUGIN), 1);
  with P do
  try
    Check(Status = psLoadError, 'Status is not psLoadError.');
    CheckEquals(LOAD_ERROR_PLUGIN, FileName, 'FileName is not "' + LOAD_ERROR_PLUGIN + '".');
    CheckEquals(1, Id, 'Id is not 1.');
    CheckEquals(0, Handle, 'Handle is not 0.');
  finally
    P.Free;
  end;
end;

// 正常なプラグインを読み込むテストです。
procedure TTestCasePlugin.TestLoadSuccess;
var
  P: TPlugin;
begin
  P := TPlugin.Create(Utf8Decode(LOAD_SUCCESS_PLUGIN), 1);
  with P do
  try
    Check(Status = psSuccess, 'Status is not psSuccess.');
    CheckEquals(LOAD_SUCCESS_PLUGIN, FileName, 'FileName is not "' + LOAD_SUCCESS_PLUGIN + '".');
    CheckEquals(1, Id, 'Id is not 1.');
    CheckNotEquals(0, Handle, 'Handle is 0.');
    try
      P.MainProc(0, 0, 0);
    except
      Fail('failed call MailProc.');
    end;
    Check(true);
  finally
    P.Free;
  end;
end;

procedure RegisterTests;
begin
  TestFramework.RegisterTest(TTestCasePlugin.Suite);
end;

end.
