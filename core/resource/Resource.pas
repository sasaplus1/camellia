unit Resource;

interface

uses
  JwaWinType, JwaWinUser;

type
  // アイコンサイズを表す列挙型です。
  //
  // * isSmall
  //     * 小さいサイズのアイコン
  // * isNormal
  //     * 通常のサイズのアイコン
  TIconSize = (
    isSmall,
    isNormal
  );

const
  IDI_MAIN = 100;
  
function LoadMainIcon(Size: TIconSize): HICON;

implementation

// メインのリソースアイコンを取得します。
//
// * Size
//     * 取得するサイズです。
function LoadMainIcon(Size: TIconSize): HICON;
var
  x, y: Integer;
begin
  case Size of
    isSmall:
    begin
      x := GetSystemMetrics(SM_CXSMICON);
      y := GetSystemMetrics(SM_CYSMICON);
    end;

    isNormal:
    begin
      x := GetSystemMetrics(SM_CXICON);
      y := GetSystemMetrics(SM_CYICON);
    end;
  end;

  Result := LoadImageW(MainInstance, MAKEINTRESOURCEW(IDI_MAIN), IMAGE_ICON,
    x, y, LR_VGACOLOR);
end;

end.
