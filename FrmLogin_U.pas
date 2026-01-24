unit FrmLogin_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkinLiquidSky, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinSeven, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinSilver, dxSkinTheAsphaltWorld, dxSkinTheBezier, dxSkinsDefaultPainters,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxLabel, cxTextEdit, cxGroupBox, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfrmLogin = class(TForm)
    gpLogin: TGridPanel;
    gbIdentitas: TcxGroupBox;
    edKodeBooking: TcxTextEdit;
    gbQRCode: TcxGroupBox;
    cxLabel1: TcxLabel;
    btConfirm: TcxButton;
    SpeedButton1: TSpeedButton;
    btFrista: TcxButton;
    btFingerprint: TcxButton;
    edNamaPasien: TcxTextEdit;
    edTglLahir: TcxTextEdit;
    edNoRM: TcxTextEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    procedure btConfirmClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edKodeBookingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure ShowVirtualKeyboard;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}
uses ShellAPI;

procedure TfrmLogin.edKodeBookingKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    lbNamaPasien.Caption := 'MOH. IRFAN';
    lbTglLahir.Caption := FormatDateTime('dd/mm/yyyy', Now);
    lbNoRM.Caption := '2026000001'
  end;
end;

procedure TfrmLogin.ShowVirtualKeyboard;
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
procedure TfrmLogin.SpeedButton1Click(Sender: TObject);
begin
  ShowVirtualKeyboard;
end;

procedure TfrmLogin.btConfirmClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
