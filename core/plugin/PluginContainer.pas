unit PluginContainer;

interface

uses
  Command, CommandList, Plugin, JwaWinBase, JwaWinType;

type
  // PluginとCommandListを内包するクラスです。
  PPluginContainer = ^TPluginContainer;
  TPluginContainer = class(TObject)
  private
    FCommandList: TCommandList;
    FPlugin: TPlugin;
    function GetFileName: WideString;
    function GetHandle: HMODULE;
    function GetId: Integer;
    function GetStatus: TPluginStatus;
  public
    constructor Create(const FileName: WideString; Id: Integer);
    destructor Destroy; override;
    function FindCommand(Id: Integer): TCommand;
    function GetCommand(Index: Integer): TCommand;
    procedure AddCommand(Command: TCommand); overload;
    procedure AddCommand(Id: Integer; const Name: WideString); overload;
    procedure MainProc(Msg: UINT; wParam: WPARAM; lPARAM: LPARAM);
    property FileName: WideString read GetFileName;
    property Handle: HMODULE read GetHandle;
    property Id: Integer read GetId;
    property Status: TPluginStatus read GetStatus;
  end;

implementation

// コンストラクタです。
//
// * FileName
//     * プラグインDLLのパスです。
// * Id
//     * プラグインのIDです。
constructor TPluginContainer.Create(const FileName: WideString; Id: Integer);
begin
  inherited Create;
  FCommandList := TCommandList.Create;
  FPlugin := TPlugin.Create(FileName, Id);
end;

destructor TPluginContainer.Destroy;
begin
  FPlugin.Free;
  FCommandList.Free;
  inherited Destroy;
end;

function TPluginContainer.GetFileName: WideString;
begin
  Result := FPlugin.FileName;
end;

function TPluginContainer.GetHandle: HMODULE;
begin
  Result := FPlugin.Handle;
end;

function TPluginContainer.GetId: Integer;
begin
  Result := FPlugin.Id;
end;

function TPluginContainer.GetStatus: TPluginStatus;
begin
  Result := FPlugin.Status;
end;

// IDに一致するコマンドを検索し、返します。
//
// * Id
//     * 検索するIDです。
function TPluginContainer.FindCommand(Id: Integer): TCommand;
var
  i: Integer;
begin
  SecureZeroMemory(@Result, SizeOf(TCommand));
  for i := 0 to FCommandList.Count - 1 do
    if FCommandList[i].Id = Id then
    begin
      Result := FCommandList[i];
      Break;
    end;
end;

function TPluginContainer.GetCommand(Index: Integer): TCommand;
begin
  Result := FCommandList[Index];
end;

procedure TPluginContainer.AddCommand(Command: TCommand);
begin
  FCommandList.Add(Command);
end;

procedure TPluginContainer.AddCommand(Id: Integer; const Name: WideString);
begin
  FCommandList.Add(Id, Name);
end;

procedure TPluginContainer.MainProc(Msg: UINT; wParam: WPARAM; lPARAM: LPARAM);
begin
  FPlugin.MainProc(Msg, wParam, lParam);
end;

end.
