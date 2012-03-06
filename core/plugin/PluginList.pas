unit PluginList;

interface

uses
  Classes, Plugin, PluginContainer, JwaWinBase;

type
  // プラグインコンテナを管理するクラスです。
  PPluginList = ^TPluginList;
  TPluginList = class(TObject)
  private
    FList: TFPList;
    function Get(Index: Integer): TPluginContainer;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const FileName: WideString; Id: Integer);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPluginContainer read Get; default;
  end;

implementation

constructor TPluginList.Create;
begin
  inherited Create;
  FList := TFPList.Create;
end;

destructor TPluginList.Destroy;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    TPluginContainer(FList[i]).Free;
  inherited Destroy;
end;

function TPluginList.Get(Index: Integer): TPluginContainer;
begin
  Result := TPluginContainer(FList[Index]);
end;

function TPluginList.GetCount: Integer;
begin
  Result := FList.Count;
end;

// プラグインを追加します。
//
// * FileName
//     * プラグインDLLのパスです。
// * Id
//     * プラグインのIDです。
procedure TPluginList.Add(const FileName: WideString; Id: Integer);
begin
  FList.Add(TPluginContainer.Create(FileName, Id));
end;

end.
