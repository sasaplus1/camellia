unit CommandList;

interface

uses
  Classes, Command, JwaWinBase, JwaWinNT;

type
  // コマンドを管理するクラスです。
  PCommandList = ^TCommandList;
  TCommandList = class(TObject)
  private
    FList: TFPList;
    function Get(Index: Integer): TCommand;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(Command: TCommand): Integer; overload;
    function Add(Id: Integer; const Name: WideString): Integer; overload;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TCommand read Get; default;
  end;

implementation

constructor TCommandList.Create;
begin
  inherited Create;
  FList := TFPList.Create;
end;

destructor TCommandList.Destroy;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    HeapFree(GetProcessHeap, 0, FList[i]);
  FList.Free;
  inherited Destroy;
end;

function TCommandList.Get(Index: Integer): TCommand;
begin
  Result := PCommand(FList[Index])^;
end;

function TCommandList.GetCount: Integer;
begin
  Result := FList.Count;
end;

// コマンドを追加します。
//
// * Command
//     * 追加するコマンドです。
function TCommandList.Add(Command: TCommand): Integer;
var
  Cmd: PCommand;
begin
  Cmd := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY, SizeOf(TCommand));
  Cmd^.Id := Command.Id;
  Cmd^.Name := Command.Name;
  Result := FList.Add(Cmd);
end;

// コマンドを追加します。
//
// * Id
//     * 追加するコマンドのIDです。
// * Name
//     * 追加するコマンドの名前です。
function TCommandList.Add(Id: Integer; const Name: WideString): Integer;
var
  Cmd: TCommand;
begin
  Cmd.Id := Id;
  Cmd.Name := Name;
  Result := Self.Add(Cmd);
end;

end.
