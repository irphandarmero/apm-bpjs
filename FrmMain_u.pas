unit FrmMain_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkinLiquidSky,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinSilver, dxSkinTheAsphaltWorld,
  dxSkinTheBezier, dxSkinsDefaultPainters, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxLabel,
  cxGroupBox, Vcl.ComCtrls, dxCore, cxDateUtils, cxCalendar, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, dxBarBuiltInMenu, Vcl.Buttons, cxPC, ShellAPI, TlHelp32,
  dxGDIPlusClasses, Dm_u;

type
  TfrmMain = class(TForm)
    edNoSurkon: TcxTextEdit;
    edNamaDokter: TcxTextEdit;
    edNamaPoli: TcxTextEdit;
    dtTglPelayanan: TcxDateEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    gbTop: TcxGroupBox;
    btSimpanCetak: TcxButton;
    gpUtama: TGridPanel;
    gbDataPelayanan: TcxGroupBox;
    pgUtama: TcxPageControl;
    TabLogin: TcxTabSheet;
    gpLogin: TGridPanel;
    gbIdentitas: TcxGroupBox;
    SpeedButton1: TSpeedButton;
    edKodeBooking: TcxTextEdit;
    cxLabel5: TcxLabel;
    btConfirm: TcxButton;
    edNamaPasien: TcxTextEdit;
    edTglLahir: TcxTextEdit;
    edNoRM: TcxTextEdit;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    gbQRCode: TcxGroupBox;
    btFrista: TcxButton;
    btFingerprint: TcxButton;
    TabLayanan: TcxTabSheet;
    Image1: TImage;
    gbBottom: TcxGroupBox;
    btDone: TcxButton;
    procedure btFristaClick(Sender: TObject);
    procedure edKodeBookingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btDoneClick(Sender: TObject);
    procedure btConfirmClick(Sender: TObject);
  private
    procedure ShowVirtualKeyboard;
    procedure RunFrista;                          // + DITAMBAHKAN
    function  IsProcessRunning(const ExeName: string): Boolean; // + DITAMBAHKAN
    function  FindFristaWindow: HWND;              // + DITAMBAHKAN
    procedure ActivateApp(hWnd: HWND);            // + DITAMBAHKAN
    function GetFristaExe: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
const
  FRISTA_PROCESS = 'frista.exe';

implementation

{$R *.dfm}
procedure SendText(const S: string);
var
  i: Integer;
begin
  for i := 1 to Length(S) do
  begin
    keybd_event(Byte(VkKeyScan(S[i])), 0, 0, 0);
    keybd_event(Byte(VkKeyScan(S[i])), 0, KEYEVENTF_KEYUP, 0);
    Sleep(30);
  end;
end;
{ ================= HELPER FUNCTIONS ================= }

function TfrmMain.GetFristaExe: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'FRISTA\Frista.exe';
end;

function TfrmMain.IsProcessRunning(const ExeName: string): Boolean;
var
  Snap: THandle;
  Proc: TProcessEntry32;
begin
  Result := False;
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snap = INVALID_HANDLE_VALUE then Exit;

  Proc.dwSize := SizeOf(Proc);
  if Process32First(Snap, Proc) then
  repeat
    if SameText(Proc.szExeFile, ExeName) then
    begin
      Result := True;
      Break;
    end;
  until not Process32Next(Snap, Proc);

  CloseHandle(Snap);
end;

procedure TfrmMain.RunFrista;
begin
  ShellExecute(
    0,
    'open',
    PChar(GetFristaExe),
    nil,
    PChar(ExtractFilePath(GetFristaExe)),
    SW_SHOWNORMAL
  );
end;

procedure TfrmMain.btConfirmClick(Sender: TObject);
begin
  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'SELECT IsSementara FROM Register WHERE IdRegister = :kodebooking';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('kodebooking').Value := edKodeBooking.Text;
  dm.qTemp.Open;

  if dm.qTemp.FieldByName('IsSementara').AsBoolean = true then
  begin
    ShowMessage('Pasien belum check-in.');
    Exit;
  end;
  pgUtama.ActivePageIndex := 1;
end;

procedure TfrmMain.btDoneClick(Sender: TObject);
begin
  btDone.Visible := False;
end;

procedure TfrmMain.btFristaClick(Sender: TObject);
var
  dimana : HWND;
begin
  if not IsProcessRunning(FRISTA_PROCESS) then
  begin
    RunFrista;
    Exit;
  end;

  dimana := FindFristaWindow;

  if dimana <> 0 then
  begin
    ShowWindow(dimana, SW_RESTORE);
    SetForegroundWindow(dimana);
  end;

  btDone.Visible := true;

end;

function TfrmMain.FindFristaWindow: HWND;
begin
  // ! SENGAJA pakai caption sederhana (lebih stabil untuk kiosk)
  Result := FindWindow(nil,
  'Frista (Face Recognition BPJS Kesehatan) 3.0.2');
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  pgUtama.HideTabs:= true;
end;

procedure TfrmMain.ActivateApp(hWnd: HWND);
begin
  if IsIconic(hWnd) then
    ShowWindow(hWnd, SW_RESTORE);

  SetForegroundWindow(hWnd);
end;

procedure TfrmMain.edKodeBookingKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    edNamaPasien.Text := 'MOH. IRFAN';
    edTglLahir.Text := FormatDateTime('dd/mm/yyyy', Now);
    edNoRM.Text := '2026000001';
  end;
end;

procedure TfrmMain.ShowVirtualKeyboard;
begin
  ShellExecute(
    0,
    'open',
    'C:\Program Files\Common Files\Microsoft Shared\ink\TabTip.exe',
    nil,
    nil,
    SW_SHOWNORMAL
  );
end;
end.
