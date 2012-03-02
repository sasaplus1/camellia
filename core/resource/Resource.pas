unit Resource;

interface

uses
  JwaWinType, JwaWinUser;

type
  // �A�C�R���T�C�Y��\���񋓌^�ł��B
  //
  // * isSmall
  //     * �������T�C�Y�̃A�C�R��
  // * isNormal
  //     * �ʏ�̃T�C�Y�̃A�C�R��
  TIconSize = (
    isSmall,
    isNormal
  );

const
  IDI_MAIN = 100;
  
function LoadMainIcon(Size: TIconSize): HICON;

implementation

// ���C���̃��\�[�X�A�C�R�����擾���܂��B
//
// * Size
//     * �擾����T�C�Y�ł��B
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
