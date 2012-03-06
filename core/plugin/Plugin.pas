unit Plugin;

interface

uses
  JwaWinBase, JwaWinType;

type
  // プラグインのステータスを表す列挙型です。
  //
  // * psLoading
  //     * 読み込み中
  // * psSuccess
  //     * 読み込み成功
  // * psLoadError
  //     * 読み込み失敗
  // * psGetProcError
  //     * メッセージハンドラの取得に失敗
  TPluginStatus = (
    psLoading,
    psSuccess,
    psLoadError,
    psGetProcError
  );

  // プラグインが持つメッセージハンドラの型です。
  TMainProc = procedure (Msg: UINT; wParam: WPARAM; lParam: LPARAM); stdcall;

  // プラグインを管理するクラスです。
  PPlugin = ^TPlugin;
  TPlugin = class(TObject)
  private
    FFileName: WideString;
    FId: Integer;
    FHandle: HMODULE;
    FMainProc: TMainProc;
    FStatus: TPluginStatus;
  public
    constructor Create(const FileName: WideString; Id: Integer);
    destructor Destroy; override;
    procedure MainProc(Msg: UINT; wParam: WPARAM; lPARAM: LPARAM);
    property FileName: WideString read FFileName;
    property Handle: HMODULE read FHandle;
    property Id: Integer read FId;
    property Status: TPluginStatus read FStatus;
  end;

implementation

// コンストラクタです。
//
// * FileName
//     * プラグインDLLのパスです。
// * Id
//     * プラグインのIDです。
constructor TPlugin.Create(const FileName: WideString; Id: Integer);

  // プラグインを読み込む関数内関数です。
  // 読み込みに失敗した場合はステータスを変更し、falseを返します。
  function LoadLibrary: Boolean;
  begin
    FHandle := LoadLibraryW(PWideChar(FileName));
    if (Handle = 0) then
      FStatus := psLoadError;
    Result := (Status <> psLoadError);
  end;

  // メッセージハンドラを読み込む関数内関数です。
  // 読み込みに失敗した場合はステータスを変更し、falseを返します。
  function LoadMainProc: Boolean;
  const
    PROC_NAME = 'MainProc';
  begin
    Pointer(FMainProc) := GetProcAddress(Handle, PROC_NAME);
    if not Assigned(FMainProc) then
      FStatus := psGetProcError;
    Result := (Status <> psGetProcError);
  end;

begin
  inherited Create;

  FStatus := psLoading;
  FFileName := FileName;
  FId := Id;

  // プラグインの読み込みに失敗、または
  // メッセージハンドラの読み込みに失敗した場合、終了します。
  if not LoadLibrary or not LoadMainProc then
    Exit;

  FStatus := psSuccess;
end;

destructor TPlugin.Destroy;
begin
  if (Handle <> 0) then
    FreeLibrary(Handle);
  inherited Destroy;
end;

// プラグインのメッセージハンドラへメッセージを渡します。
//
// * Msg
//     * プラグインへ渡すメッセージです。
// * wParam
//     * メッセージのパラメータです。
// * lParam
//     * メッセージのパラメータです。
procedure TPlugin.MainProc(Msg: UINT; wParam: WPARAM; lPARAM: LPARAM);
begin
  if (Status <> psSuccess) or not Assigned(FMainProc) then
    Exit;
  FMainProc(Msg, wParam, lParam);
end;

end.
