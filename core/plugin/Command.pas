unit Command;

interface

type
  // コマンド情報を格納するレコードです。
  PCommand = ^TCommand;
  TCommand = packed record
    Id: Integer;
    Name: WideString;
  end;

implementation

end.
