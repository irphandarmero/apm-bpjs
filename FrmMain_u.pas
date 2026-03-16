unit FrmMain_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON, Vcl.Graphics, System.DateUtils, System.StrUtils, System.NetEncoding,
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
  dxGDIPlusClasses, Dm_u, cxMemo, Printers, sendkeys, Bpjs_U, cxStyles,
  cxClasses;

type
  TJenisKunjungan = (
    jkUnknown,
    jkRujukanBaru,
    jkKontrol,
    jkPostMRS
  );
type
  TJenisKunjunganHelper = record helper for TJenisKunjungan
    function ToCaption: string;
  end;
type
  TfrmMain = class(TForm)
    tmTimeOut: TTimer;
    GridPanel1: TGridPanel;
    gbTop: TcxGroupBox;
    gbBottom: TcxGroupBox;
    btDone: TcxButton;
    lbNotif: TcxLabel;
    pgUtama: TcxPageControl;
    TabLogin: TcxTabSheet;
    TabValbiom: TcxTabSheet;
    TabLayanan: TcxTabSheet;
    TabJSON: TcxTabSheet;
    memResponse: TMemo;
    memRequest: TMemo;
    btGetNoSEP: TButton;
    btNext: TcxButton;
    gbDataPelayanan: TcxGroupBox;
    btCariRujukan: TSpeedButton;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    dtTglPelayanan: TcxDateEdit;
    edNamaDokter: TcxTextEdit;
    edNamaPoli: TcxTextEdit;
    edNoSurkon: TcxTextEdit;
    edNoRujukan: TcxTextEdit;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    memDiagnosa: TcxMemo;
    btBatal: TcxButton;
    gpScan: TGridPanel;
    gbQRCode: TcxGroupBox;
    imgQR: TImage;
    btCariKodeBooking: TSpeedButton;
    gbNumPad: TcxGroupBox;
    gpNum: TGridPanel;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btn0: TSpeedButton;
    btnEnter: TSpeedButton;
    btnBackSpace: TSpeedButton;
    lbNamaPx: TcxLabel;
    lbTglLahirPx: TcxLabel;
    Image2: TImage;
    btBack: TcxButton;
    cxGroupBox1: TcxGroupBox;
    edKodeBooking: TcxTextEdit;
    sbUtama: TStatusBar;
    Shape1: TShape;
    Shape2: TShape;
    btSimpanCetak: TcxButton;
    cxTabSheet1: TcxTabSheet;
    edNamaPx: TcxTextEdit;
    edNomorRM: TcxTextEdit;
    edTanggalLahir: TcxTextEdit;
    edNIK: TcxTextEdit;
    memAlamat: TcxMemo;
    edNoKartu: TcxTextEdit;
    edNoTelpon: TcxTextEdit;
    gpValidasi: TGridPanel;
    btFingerprint: TcxButton;
    btFrista: TcxButton;
    gbIdentitas: TcxGroupBox;
    cxLabel5: TcxLabel;
    btConfirm: TcxButton;
    lbIdRegister: TcxLabel;
    lbNama: TcxLabel;
    lbNoRM: TcxLabel;
    lbTglLahir: TcxLabel;
    lbNoKartu: TcxLabel;
    lbNoTelp: TcxLabel;
    lbNoKtp: TcxLabel;
    lbAlamat: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    btSync: TcxButton;
    btPDR: TcxButton;
    btCetakAntrian: TcxButton;
    lbNoSep: TcxLabel;
    btShowKeyboard: TSpeedButton;
    lbInformasi: TcxLabel;
    procedure btFristaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btDoneClick(Sender: TObject);
    procedure btConfirmClick(Sender: TObject);
    procedure btSimpanCetakClick(Sender: TObject);
    procedure btShowKeyboardClick(Sender: TObject);
    procedure btCariRujukanClick(Sender: TObject);
    procedure btCariKodeBookingClick(Sender: TObject);
    procedure tmTimeOutTimer(Sender: TObject);
    procedure btPDRClick(Sender: TObject);
    procedure btCetakAntrianClick(Sender: TObject);
    procedure btBatalClick(Sender: TObject);
    procedure btFingerprintClick(Sender: TObject);
    procedure btSyncClick(Sender: TObject);
    procedure btGetNoSEPClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btNextClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure edKodeBookingKeyPress(Sender: TObject; var Key: Char);
    procedure edKodeBookingEnter(Sender: TObject);
  private
    procedure NumpadClick(Sender: TObject);
    procedure NumpadEnter(Sender: TObject);

    procedure ShowVirtualKeyboard;
    procedure RunFrista;                          // + DITAMBAHKAN
    function  IsProcessRunning(const ExeName: string): Boolean; // + DITAMBAHKAN
    function  FindFristaWindow: HWND;              // + DITAMBAHKAN

    function  GetFristaExe: string;

    procedure ClearParameterValue;

    procedure TimeOut;
    procedure TransaksiPDR;
    procedure CetakNoAntri;
    procedure SyncSEP(ANoSep : string; AJnsKunjungan : string);

    procedure WarnaLabel(AStatus : string);
    procedure ShowError(APesan : string);
    procedure MatikanCapsLock;

    var
      IdRegister, IdInstansi, IdRuang : integer;
      KodeDokter, KodeDokterMapping, KodePoliMapping : string;
      NoBPJS, NoKTP, NoRM : string;
      TglRegister : TDateTime;
      HakKelas : string;
      AsalRujukan, KodePPKAsal, TglRujukan, KodeDiag, NoTelp : string;
      tujuanKunjungan, asesmenPelayanan: string;
      NomorReferensi : string;

      KodeDPJP : string; {dokter pembuat surkon}
      RujukanFromSurkon : string;
      {result setelah create sep}
      NoSEP : string;

      FLastTick: Cardinal;
      FIsScanner: Boolean;
      FScannerBuffer: string; // Tempat rahasia menyimpan Base64


    { Private declarations }
  public
    function CreateBPJS: TBpjs;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  jenisKunjungan : TJenisKunjungan;
  FristaHandle : HWND = 0;
  LastKeyTime: TDateTime;
  IsScannerInput: Boolean;
  CharCount: Integer;

const
  KodeRS = '0190R007';
  FRISTA_PROCESS = 'frista.exe';
  TABTIP_PROCESS = 'TabTip.exe';

  YasminGreen  = TColor($539F0B);
  YasminOrange = TColor($2B9AF7);

  HalamanAwal = 'Scan QR Code untuk check-in kemudian masukkan Kode Booking';
  Halaman1 = 'Scan QR Code dan Masukkan Kode Booking';
  Halaman2 = 'Tap Validasi FRISTA / Validasi FINGER';
  Halaman21 = 'Tap LANJUTKAN';
  Halaman3 = 'Tap SIMPAN / CETAK';
implementation

{$R *.dfm}
function DecodeBase64(const S: string): string;
begin
  Result := TNetEncoding.Base64.Decode(S);
end;
function EnumWindowsProc(Wnd: HWND; LParam: LPARAM): BOOL; stdcall;
var
  Title: array[0..255] of Char;
begin
  GetWindowText(Wnd, Title, 255);

  if Pos('Frista', Title) > 0 then
  begin
    FristaHandle := Wnd;
    Result := False; // stop enumeration
  end
  else
    Result := True; // lanjut cari
end;
procedure TfrmMain.MatikanCapsLock;
begin
  // Cek apakah status Caps Lock saat ini menyala (Bit ke-0 bernilai 1)
  if (GetKeyState(VK_CAPITAL) and 1) <> 0 then
  begin
    // Simulasikan penekanan tombol Caps Lock ke Windows untuk mematikannya
    keybd_event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or 0, 0);
    keybd_event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
  end;
end;
procedure TfrmMain.NumpadClick(Sender: TObject);
var
//  Edit: TCustomEdit;
  Btn : TSpeedButton;
begin
  if not (Screen.ActiveControl is TCustomEdit) then
    Exit;

//  Edit := TCustomEdit(Screen.ActiveControl);
  Btn  := Sender as TSpeedButton;

  edKodeBooking.SelStart := Length(edKodeBooking.Text);
  edKodeBooking.SelLength := 0;
  edKodeBooking.SetFocus;

  // BACKSPACE
  if Btn.Caption = '←' then
  begin
    if edKodeBooking.SelLength > 0 then
    edKodeBooking.SelText := ''
    else if edKodeBooking.GetTextLen > 0 then
      edKodeBooking.Text := Copy(edKodeBooking.Text, 1, edKodeBooking.GetTextLen - 1);

    // paksa kursor ke belakang
    edKodeBooking.SelStart := Length(edKodeBooking.Text);
    edKodeBooking.SelLength := 0;
  end
  else
  begin
    edKodeBooking.SelText := Btn.Caption;
  end;

  edKodeBooking.SelStart := Length(edKodeBooking.Text);
  edKodeBooking.SelLength := 0;
  edKodeBooking.SetFocus;
end;
procedure TfrmMain.NumpadEnter(Sender: TObject);
begin
//  if Assigned(ActiveControl) then
//    PostMessage(Handle, WM_KEYDOWN, VK_RETURN, 0);
  btCariKodeBookingClick(sender);
end;

function GetDefaultPrinterName: string;
begin
   if (Printer.PrinterIndex > 0)then begin
     Result :=
       Printer.Printers
      [Printer.PrinterIndex];
   end else begin
     Result := '';
   end;
end;
function KillProcessByName(const ExeName: string): Boolean;
var
  hSnap: THandle;
  ProcEntry: TProcessEntry32;
  hProcess: THandle;
begin
  Result := False;

  hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnap = INVALID_HANDLE_VALUE then Exit;

  ProcEntry.dwSize := SizeOf(TProcessEntry32);

  if Process32First(hSnap, ProcEntry) then
  begin
    repeat
      if SameText(ProcEntry.szExeFile, ExeName) then
      begin
        hProcess := OpenProcess(PROCESS_TERMINATE, False, ProcEntry.th32ProcessID);
        if hProcess <> 0 then
        begin
          TerminateProcess(hProcess, 0);
          CloseHandle(hProcess);
          Result := True;
        end;
      end;
    until not Process32Next(hSnap, ProcEntry);
  end;

  CloseHandle(hSnap);
end;

function AmbilKodeDiagnosa(const Diagnosa: string): string;
var
  p: Integer;
begin
  p := Pos('-', Diagnosa);
  if p > 0 then
    Result := Trim(Copy(Diagnosa, 1, p - 1))
  else
    Result := Trim(Diagnosa);
end;

function TJenisKunjunganHelper.ToCaption: string;
begin
  case Self of
    jkRujukanBaru: Result := 'RUJUKAN BARU';
    jkKontrol:     Result := 'KONTROL PASIEN';
    jkPostMRS:     Result := 'KONTROL POST RAWAT INAP (POST MRS)';
  else
    Result := 'JENIS KUNJUNGAN TIDAK DIKETAHUI';
  end;
end;

function TfrmMain.CreateBPJS: TBpjs;
begin
  if not dm.GetApiConfig('BPJS','PRODUCTION') then
    raise Exception.Create('Config BPJS tidak ditemukan');

  Result := TBpjs.Create(
              dm.FieldStr('URL'),
              dm.FieldStr('consID'),
              dm.FieldStr('secretKey'),
              dm.FieldStr('userKey_token'));
end;
procedure TfrmMain.edKodeBookingEnter(Sender: TObject);
begin
  MatikanCapsLock;
end;

procedure TfrmMain.edKodeBookingKeyPress(Sender: TObject; var Key: Char);
var
  CurrentTick: Cardinal;
  Interval: Cardinal;
  jsv: TJSONValue;
begin
  // Hitung kecepatan ketikan
  CurrentTick := GetTickCount;
  Interval := CurrentTick - FLastTick;
  FLastTick := CurrentTick;

  // Jika tombol ENTER ditekan
  if Key = #13 then
  begin
    Key := #0; // Cegah bunyi beep Windows

    if FIsScanner then
    begin
      // 1. PROSES HASIL SCANNER (Dari Buffer Rahasia)
      try
        // Decode dari buffer, BUKAN dari TEdit
        memRequest.Text := DecodeBase64(FScannerBuffer);
        jsv := TJSONObject.ParseJSONValue(memRequest.Text);

        if Assigned(jsv) then
        try
          // Masukkan hasil akhirnya (kode booking pendek) ke TEdit agar pasien melihatnya
          edKodeBooking.Text := jsv.GetValue<string>('kodeBooking');
        finally
          jsv.Free; // Cegah Memory Leak!
        end;

        // Lanjut ke halaman berikutnya
        btNext.Click;

      except
        ShowMessage('Mohon maaf, QR Code tidak valid atau bukan dari Mobile JKN.');
        edKodeBooking.Clear;
      end;
    end
    else
    begin
      // 2. PROSES INPUT MANUAL (Tidak ada Base64, langsung lanjut)
      btNext.Click;
    end;

    // Reset status untuk pasien berikutnya
    FIsScanner := False;
    FScannerBuffer := '';
  end
  else
  begin
    // --- LOGIKA INTERSEPSI KARAKTER ---

    // Jika jeda antar karakter sangat cepat (< 30ms), berarti ini pasti Scanner
    if Interval < 30 then
    begin
      if not FIsScanner then
      begin
        FIsScanner := True;
        // Pindahkan 1 huruf pertama yang mungkin sempat masuk ke TEdit ke dalam Buffer
        FScannerBuffer := edKodeBooking.Text;
        // Bersihkan TEdit seketika!
        edKodeBooking.Clear;
      end;
    end;

    // Jika sistem sudah tahu ini adalah Scanner, cegat semua sisa karakternya!
    if FIsScanner then
    begin
      FScannerBuffer := FScannerBuffer + Key; // Simpan ke memori rahasia
      Key := #0; // SULAP! Cegah huruf tampil di layar TEdit
    end;
  end;
end;

procedure TfrmMain.WarnaLabel(AStatus: string);
begin
  if AStatus = 'ERROR' then
  begin
    lbNotif.Style.Color := clRed;
  end else
  if AStatus = 'SUKSES' then
  begin
    lbNotif.Style.Color := clBtnHighlight;
  end;
end;
procedure TfrmMain.ShowError(APesan: string);
begin
  MessageDlg(APesan, mtError, [mbOK], 0);
end;

procedure TfrmMain.ClearParameterValue;
//var
//  i: Integer;
begin
//  for i := 0 to ComponentCount - 1 do
//  begin
//    if Components[i] is TcxTextEdit then
//    begin
//      TcxTextEdit(Components[i]).Clear;
//    end
//    else
//    if Components[i] is TcxDateEdit then
//    begin
//      TcxDateEdit(Components[i]).Text := '';
//    end
//    else
//    if Components[i] is TcxMemo then
//    begin
//      TcxMemo(Components[i]).Clear;
//    end;
//
//  end;
// tab0
  edKodeBooking.Clear;
  lbNamaPx.Caption := 'Nama Pasien';
  lbTglLahirPx.Caption := 'Tanggal Lahir';
//tab1

  edNamaPx.Clear;
  edNomorRM.Clear;
  edTanggalLahir.Clear;
  edNoKartu.Clear;
  edNIK.Clear;
  edNoTelpon.Clear;
  memAlamat.Clear;
  edNoRujukan.Clear;
  edNoSurkon.Clear;
  edNamaDokter.Clear;
  edNamaPoli.Clear;
  memDiagnosa.Clear;


  tujuanKunjungan := '';
  asesmenPelayanan:= '';
  KodeDPJP := '';
  IdRegister := 0 ; //clear idregister
  lbIdRegister.Caption := '-';


  btConfirm.Enabled := False;
  lbNotif.Caption := '-';
  WarnaLabel('SUKSES');
  {tutup sementara buat test}
//  pgUtama.ActivePageIndex := 0;Self
  btNext.Visible := True;
  btSimpanCetak.Visible := False;

  btNext.Enabled := True;
  btBack.Visible := False;

  sbUtama.Panels[0].Text := HalamanAwal;
  lbInformasi.Caption := Halaman1;
end;
procedure TfrmMain.TimeOut;
begin
  dm.SambungKoneksi;

  tmTimeOut.Enabled := False;
  tmTimeOut.Enabled := True;
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

procedure TfrmMain.btBackClick(Sender: TObject);
begin
  case pgUtama.ActivePageIndex of
    2 : begin
      pgUtama.ActivePageIndex := 1;
      btNext.Visible := True;
      btNext.Enabled := True;
      btSimpanCetak.Visible := False;
    end;
    1 : begin
      ClearParameterValue;
      edNamaPx.Clear;
      pgUtama.ActivePageIndex := 0;
      edKodeBooking.SetFocus;

      btBack.Enabled := False;
      btNext.Enabled := True;
    end;
  end;
end;

procedure TfrmMain.btBatalClick(Sender: TObject);
begin
  ClearParameterValue;
  pgUtama.ActivePageIndex := 0;
  edKodeBooking.SetFocus;
end;

procedure TfrmMain.btCariKodeBookingClick(Sender: TObject);
//var
//    jSurkon : TJSONObject;
//    jsa : TJSONArray;
//    jso : TJSONObject;
//    Umur : string;
begin
//  TimeOut;
//
//  if edKodeBooking.Text = '' then
//  begin
//    lbNotif.Caption := 'Kode booking belum di isi.';
//    WarnaLabel('ERROR');
//    edKodeBooking.SetFocus;
//    Abort;
//  end;
//
//  lbIdRegister.Caption := edKodeBooking.Text;
//
//    try
//      dm.qTemp.Close;
//      dm.qTemp.SQL.Clear;
//      dm.qTemp.SQL.Text := 'SELECT IdRegister, NIK, Nama, NoRM, TglLahirPx, NoSP, IdRuang, ' +
//                           'KodeKaryawan, TglRegister, IsSementara, NoJaminan, IdInstansi, ' +
//                           'Umur, Alamat, Telp1 ' +
//                           'FROM vRegister WHERE IdRegister = :kodebooking';
//      dm.qTemp.Prepared;
//      dm.qTemp.Parameters.ParamByName('kodebooking').Value := edKodeBooking.Text;
//      dm.qTemp.Open;
//
//      if dm.qTemp.IsEmpty then
//      begin
////        ShowMessage('Kode Booking tidak ditemukan.');
//        ShowError('Kode Booking tidak ditemukan.');
//        lbNotif.Caption := 'Kode Booking tidak ditemukan.';
//        WarnaLabel('ERROR');
//        Abort;
//      end;
//
//      if dm.qTemp.FieldByName('IsSementara').AsBoolean = true then
//      begin
//        ShowMessage('Pasien belum check-in.');
//        lbNotif.Caption := 'Pasien belum Check-in, Scan QRCode terlebih dahulu';
//        WarnaLabel('ERROR');
//        Abort;
//      end;
//
//      edNamaPx.Text := dm.qTemp.FieldByName('Nama').AsString;
//      lbNamaPx.Caption := edNamaPx.Text;
//      edNomorRM.Text:= dm.qTemp.FieldByName('NoRM').AsString;
//      edTanggalLahir.Text := FormatDateTime('yyyy-mm-dd', dm.qTemp.FieldByName('TglLahirPx').AsDateTime);
//      lbTglLahirPx.Caption := edTanggalLahir.Text;
//      edNoKartu.Text := dm.qTemp.FieldByName('NoJaminan').AsString;
//      edNoTelpon.Text:= StringReplace(dm.qTemp.FieldByName('Telp1').AsString, ' ','', [rfReplaceAll]);
//      edNIK.Text := dm.qTemp.FieldByName('NIK').AsString;
//
//      IdRegister  := dm.qTemp.FieldByName('IdRegister').AsInteger;
//      IdInstansi  := dm.qTemp.FieldByName('IdInstansi').AsInteger;
//      NomorReferensi   := dm.qTemp.FieldByName('NoSP').AsString;
//      IdRuang     := dm.qTemp.FieldByName('IdRuang').AsInteger;
//      KodeDokter  := dm.qTemp.FieldByName('KodeKaryawan').AsString;
//      TglRegister := dm.qTemp.FieldByName('TglRegister').AsDateTime;
//      NoBPJS      := dm.qTemp.FieldByName('NoJaminan').AsString;
//      NoRM        := StringReplace(dm.qTemp.FieldByName('NoRM').AsString, '.', '', [rfReplaceAll]);
//      memAlamat.Text := dm.qTemp.FieldByName('Alamat').AsString;
//
//      Umur := dm.qTemp.FieldByName('Umur').AsString;
//      if StrToInt(LeftStr(Umur, 2)) < 17 then
//      begin
//        btConfirm.Enabled := True;
//      end else
//      begin
//        btConfirm.Enabled := False;
//      end;
//
////      btConfirm.Enabled := True;
//      lbNotif.Caption := 'Sukses';
//      WarnaLabel('SUKSES');
//
//      btFrista.Enabled := True;
//      btFingerprint.Enabled := True;
//    except
//      lbNotif.Caption := 'Kode Booking tidak valid';
//      WarnaLabel('ERROR');
//    end;

end;

procedure TfrmMain.btCariRujukanClick(Sender: TObject);
var
    jSurkon, jRujukan : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
    bpjs: TBpjs;
begin
  TimeOut;

  bpjs := CreateBPJS;
    try
      if jenisKunjungan <> jkPostMRS then
      begin
        memResponse.Text := bpjs.cekRujukan(edNoRujukan.Text);
        if memResponse.Text = 'Data Rujukan Tidak Ditemukan.' then
        begin
          MessageDlg('Rujukan tidak valid', mtError, [mbOK], 0);
          lbNotif.Caption := 'Rujukan tidak valid';
          WarnaLabel('ERROR');
          edNoRujukan.SetFocus;
          Abort;
        end;
        jRujukan := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
        KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
        AsalRujukan := jRujukan.GetValue<string>('asalFaskes');
        KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
        TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
        memDiagnosa.Text := KodeDiag + ' - ' +jRujukan.GetValue<string>('rujukan.diagnosa.nama');
      end;

      dm.LoadDokter(KodeDokter);
      dm.LoadPoli(IdRuang);
      KodeDokterMapping := dm.vDokter.FieldByName('KdDokterMapping').AsString;
      KodePoliMapping   := dm.vPoli.FieldByName('KdRuangInstansi').AsString;
      edNamaDokter.Text := dm.vDokter.FieldByName('Nama').AsString;
      edNamaPoli.Text := dm.vPoli.FieldByName('Nama').AsString;

      lbNotif.Caption := 'Sukses ' + jenisKunjungan.ToCaption;
      WarnaLabel('SUKSES');
    finally
      bpjs.Free;
    end;
end;

procedure TfrmMain.btCetakAntrianClick(Sender: TObject);
begin
  CetakNoAntri;
end;

procedure TfrmMain.btConfirmClick(Sender: TObject);
var TanggalKunjungan : string;
    jPeserta : TJSONObject;
    jSep, jSepItem : TJSONObject;
    SepArr, jsa : TJSONArray;
    jSurkon, jso: TJSONObject;
    jRujukan : TJSONObject;
    bpjs : TBpjs;
begin

  TimeOut;
//  btFristaClick(sender);

  TanggalKunjungan := DateToStr(Trunc(TglRegister));
  if Trunc(TglRegister) = Date then          //harusnya = bukan <>
  begin
    dtTglPelayanan.Date := TglRegister;

    bpjs := CreateBPJS;
    try
      memResponse.Text := bpjs.CekPeserta(NoBPJS, FormatDateTime('yyyy-mm-dd', TglRegister));

      jPeserta := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;

      HakKelas := jPeserta.GetValue<string>('peserta.hakKelas.kode');
      NoKTP := jPeserta.GetValue<string>('peserta.nik');
      NoTelp := jPeserta.GetValue<string>('peserta.mr.noTelepon');
      edNamaPx.Text := jPeserta.GetValue<string>('peserta.nama');
      edNomorRM.Text:= jPeserta.GetValue<string>('peserta.mr.noMR');
      edTanggalLahir.Text := jPeserta.GetValue<string>('peserta.tglLahir');
      edNoKartu.Text := jPeserta.GetValue<string>('peserta.noKartu');
      edNoTelpon.Text:= jPeserta.GetValue<string>('peserta.mr.noTelepon');

       try
//        memResponse.Text := Bpjs.cekSurkonbyNoka(NoBPJS);

//        jSurkon := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
//        jsa := jSurkon.GetValue('list') as TJSONArray;

//        jso := jsa.Get(0) as TJSONObject;
//
//        edNoSurkon.Text := jso.GetValue<string>('noSuratKontrol');
//        if jso.GetValue<string>('jnsPelayanan') = 'Rawat Inap' then
//        begin
//          edNoRujukan.Text:= jso.GetValue<string>('noSepAsalKontrol');
//          jenisKunjungan:= jkPostMRS;
//        end else
//        begin
//          jenisKunjungan:= jkKontrol;
//        end;
//
//        ShowMessage('asal sep '+jso.GetValue<string>('jnsPelayanan'));
        memResponse.Text := bpjs.CariNoSuratKontrol(NomorReferensi);
        jSurkon := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
        edNoSurkon.Text := jSurkon.GetValue<string>('noSuratKontrol');


        if jSurkon.GetValue<string>('sep.jnsPelayanan') = 'Rawat Inap' then
        begin
          edNoRujukan.Text := jSurkon.GetValue<string>('sep.noSep');
          RujukanFromSurkon := jSurkon.GetValue<string>('sep.provPerujuk.noRujukan');
          KodeDPJP := jSurkon.GetValue<string>('kodeDokter');

          memResponse.Text := bpjs.GetRiwayatSEP(edNoKartu.Text);
          jSep := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
          SepArr := jSep.GetValue('histori') as TJSONArray;
          jSepItem := SepArr.Get(0) as TJSONObject;
          memDiagnosa.Text := jSepItem.GetValue<string>('diagnosa');
          KodeDiag := AmbilKodeDiagnosa(memDiagnosa.Text);

          jenisKunjungan := jkPostMRS;
        end else
        begin
          KodeDPJP := jSurkon.GetValue<string>('kodeDokterPembuat');
          edNoRujukan.Text := jSurkon.GetValue<string>('sep.provPerujuk.noRujukan');
          RujukanFromSurkon := jSurkon.GetValue<string>('sep.provPerujuk.noRujukan');

          memRequest.Text := bpjs.CekRujukan(RujukanFromSurkon);
          jRujukan := TJSONObject.ParseJSONValue(memRequest.Text) as TJSONObject;
          KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
          AsalRujukan := jRujukan.GetValue<string>('asalFaskes');
          KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
          TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
          memDiagnosa.Text := KodeDiag + ' - ' +jRujukan.GetValue<string>('rujukan.diagnosa.nama');

          jenisKunjungan := jkKontrol;
        end;

      except
        {RUJUKAN BARU FIX}
//        memResponse.Text := Bpjs.cekRujukan(NoBPJS);
//        jRujukan := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
//        edNoRujukan.Text := jRujukan.GetValue<string>('rujukan.noKunjungan');
        edNoRujukan.Text := NomorReferensi;
        RujukanFromSurkon := NomorReferensi;

        memRequest.Text := bpjs.CekRujukan(NomorReferensi);
        jRujukan := TJSONObject.ParseJSONValue(memRequest.Text) as TJSONObject;
        KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
        AsalRujukan := jRujukan.GetValue<string>('asalFaskes');
        KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
        TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
        memDiagnosa.Text := KodeDiag + ' - ' +jRujukan.GetValue<string>('rujukan.diagnosa.nama');

        jenisKunjungan := jkRujukanBaru;
      end;

//      ShowMessage(RujukanFromSurkon);
//      memRequest.Text := bpjs.CekRujukan(RujukanFromSurkon);
//      jRujukan := TJSONObject.ParseJSONValue(bpjs.CekRujukan(RujukanFromSurkon)) ;
//      memResponse.Text := jRujukan.ToJSON;

      dm.LoadDokter(KodeDokter);
      dm.LoadPoli(IdRuang);
      KodeDokterMapping := dm.vDokter.FieldByName('KdDokterMapping').AsString;
      KodePoliMapping   := dm.vPoli.FieldByName('KdRuangInstansi').AsString;
      edNamaDokter.Text := dm.vDokter.FieldByName('Nama').AsString;
      edNamaPoli.Text := dm.vPoli.FieldByName('Nama').AsString;

    finally
      jPeserta.Free;
      bpjs.Free;
    end;

    if (LeftStr(KodeDiag , 1) = 'S') OR
      (LeftStr(KodeDiag , 1) = 'T') OR
      (LeftStr(KodeDiag , 1) = 'V') OR
      (LeftStr(KodeDiag , 1) = 'W')  then
    begin
      ShowError('Perlu verifikasi kronologi, Silakan ke Loket Pendaftaran');
      lbNotif.Caption := 'Perlu verifikasi kronologi, Silakan ke Loket Pendaftaran';
      WarnaLabel('ERROR');
      Abort;
    end;

    pgUtama.ActivePageIndex := 2;
    edNoRujukan.SetFocus;

    lbNotif.Caption := 'Sukses '+ jenisKunjungan.ToCaption;
    WarnaLabel('SUKSES');
  end else
  begin
    MessageDlg('Tanggal kunjungan tidak sesuai.', mtWarning, [mbOK], 0);
    lbNotif.Caption := 'Tanggal kunjungan anda '+ TanggalKunjungan;
    WarnaLabel('ERROR');
  end;
end;

procedure TfrmMain.btDoneClick(Sender: TObject);
begin
  btDone.Visible := False;
  btConfirm.Enabled := True;

end;

procedure TfrmMain.btFingerprintClick(Sender: TObject);
var
  finger : HWND;
  s : string;
begin
  finger := FindWindow(nil, 'Aplikasi Registrasi Sidik Jari');;

  if finger <> 0 then
  begin
    ShowWindow(finger, SW_RESTORE);
    SetForegroundWindow(finger);
    SendKeysToHandle(finger, lbNoKartu.Caption);
  end;

  btDone.Visible := true;
  btNext.Visible := True;
  btNext.Enabled := True;
  lbInformasi.Caption := Halaman21;
end;

procedure TfrmMain.btFristaClick(Sender: TObject);
var
  frista : HWND;
  s : string;
begin
  if not IsProcessRunning(FRISTA_PROCESS) then
  begin
    RunFrista;
//    btDone.Visible := true;
    Exit;
  end;

  frista := FindFristaWindow;

  if frista <> 0 then
  begin
    // 1. Bangunkan window
    ShowWindow(frista, SW_RESTORE);

    // 2. PAKSA UKURAN & REPAINT (Ini kunci mengatasi bug scale-in!)
    // SWP_FRAMECHANGED memaksa Windows mengkalkulasi ulang area klien aplikasi.
    // Ganti 800 dan 600 dengan lebar dan tinggi asli aplikasi Frista di layar Anda.
    SetWindowPos(frista, HWND_TOP, 0, 0, 800, 600, SWP_NOMOVE or SWP_SHOWWINDOW or SWP_FRAMECHANGED);

    // 3. Bawa ke depan
    SetForegroundWindow(frista);

    // 4. JEDA SANGAT PENTING! (Beri waktu Frista untuk merender UI sebelum diketik)
    // Tanpa jeda, SendKeys bisa nyasar atau merusak rendering.
    Sleep(300);

    // 5. Tembak NIK
    SendKeysToHandle(frista, lbNoKtp.Caption);

    btNext.Visible := True;
    btNext.Enabled := True;
    lbInformasi.Caption := Halaman21;
  end;
end;

procedure TfrmMain.btGetNoSEPClick(Sender: TObject);
var
  jSep : TJSONObject;
begin
  jSep := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
  {mandatory}
  NoSEP := jSep.GetValue<string>('sep.noSep');
  lbNoSep.Caption := jSep.GetValue<string>('sep.noSep');
end;

procedure TfrmMain.btnEnterClick(Sender: TObject);
begin
  btCariKodeBookingClick(sender);
end;

procedure TfrmMain.btNextClick(Sender: TObject);
var
    jSurkon : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
    Umur : string;

    TanggalKunjungan : string;
    jPeserta : TJSONObject;
    jSep, jSepItem : TJSONObject;
    SepArr : TJSONArray;
    jRujukan : TJSONObject;
    bpjs : TBpjs;

    s : string;
begin
  case pgUtama.ActivePageIndex of
    0 : begin    //scan QR / checkin

      TimeOut;
      if edKodeBooking.Text = '' then
      begin
        lbNotif.Caption := 'Kode booking belum di isi.';
        WarnaLabel('ERROR');
        edKodeBooking.SetFocus;
        Abort;
      end;

      lbIdRegister.Caption := edKodeBooking.Text;
//      if edNamaPx.Text = '' then
//      begin
      try
        dm.qTemp.Close;
        dm.qTemp.SQL.Clear;
        dm.qTemp.SQL.Text := 'SELECT IdRegister, NIK, Nama, NoRM, TglLahirPx, NoSP, IdRuang, ' +
                             'KodeKaryawan, TglRegister, IsSementara, NoJaminan, IdInstansi, ' +
                             'Umur, Alamat, Telp1 ' +
                             'FROM vRegister WHERE IdRegister = :kodebooking';
        dm.qTemp.Prepared;
        dm.qTemp.Parameters.ParamByName('kodebooking').Value := edKodeBooking.Text;
        dm.qTemp.Open;

        if dm.qTemp.IsEmpty then
        begin
          ShowError('Kode Booking tidak ditemukan.');
          lbNotif.Caption := 'Kode Booking tidak ditemukan.';
          WarnaLabel('ERROR');
          edKodeBooking.SetFocus;
          Abort;
        end;

        if dm.qTemp.FieldByName('IsSementara').AsBoolean = true then
        begin
          ShowError('Pasien belum check-in.');
          lbNotif.Caption := 'Pasien belum Check-in, Scan QRCode terlebih dahulu';
          s := lbNotif.Caption;
          WarnaLabel('ERROR');
          Abort;
        end;

        {edNamaPx.Text := dm.qTemp.FieldByName('Nama').AsString;
        edNomorRM.Text:= dm.qTemp.FieldByName('NoRM').AsString;
        edTanggalLahir.Text := FormatDateTime('yyyy-mm-dd', dm.qTemp.FieldByName('TglLahirPx').AsDateTime);
        edNoKartu.Text := dm.qTemp.FieldByName('NoJaminan').AsString;
        edNoTelpon.Text:= StringReplace(dm.qTemp.FieldByName('Telp1').AsString, ' ','', [rfReplaceAll]);
        edNIK.Text := dm.qTemp.FieldByName('NIK').AsString;
        memAlamat.Text := dm.qTemp.FieldByName('Alamat').AsString; }

        lbNama.Caption := dm.qTemp.FieldByName('Nama').AsString;
        lbNoRM.Caption := dm.qTemp.FieldByName('NoRM').AsString;
        lbTglLahir.Caption := FormatDateTime('yyyy-mm-dd', dm.qTemp.FieldByName('TglLahirPx').AsDateTime);
        lbNoKartu.Caption := dm.qTemp.FieldByName('NoJaminan').AsString;
        lbNoTelp.Caption := StringReplace(dm.qTemp.FieldByName('Telp1').AsString, ' ','', [rfReplaceAll]);
        lbNoKtp.Caption := dm.qTemp.FieldByName('NIK').AsString;
        lbAlamat.Caption := dm.qTemp.FieldByName('Alamat').AsString;

        IdRegister  := dm.qTemp.FieldByName('IdRegister').AsInteger;
        IdInstansi  := dm.qTemp.FieldByName('IdInstansi').AsInteger;
        NomorReferensi := dm.qTemp.FieldByName('NoSP').AsString;
        IdRuang     := dm.qTemp.FieldByName('IdRuang').AsInteger;
        KodeDokter  := dm.qTemp.FieldByName('KodeKaryawan').AsString;
        TglRegister := dm.qTemp.FieldByName('TglRegister').AsDateTime;
        NoBPJS      := dm.qTemp.FieldByName('NoJaminan').AsString;
        NoRM        := StringReplace(dm.qTemp.FieldByName('NoRM').AsString, '.', '', [rfReplaceAll]);

        Umur := dm.qTemp.FieldByName('Umur').AsString;

//        btConfirm.Enabled := True;
        lbNotif.Caption := 'Sukses';
        WarnaLabel('SUKSES');
        s := lbNotif.Caption;
        sbUtama.Panels[0].Text := s;
      except
        if s <> '' then
        begin
          sbUtama.Panels[0].Text := s;
          lbNotif.Caption := s;
          WarnaLabel('ERROR');
        end else
        begin
          sbUtama.Panels[0].Text := 'Kode Booking tidak valid';
          lbNotif.Caption := 'Kode Booking tidak valid';
          WarnaLabel('ERROR');
        end;
        edKodeBooking.SetFocus;
        Abort;
      end;
//    end;

      pgUtama.ActivePageIndex := 1;
      btBack.Visible := True;
      btBack.Enabled := True;

      if StrToInt(LeftStr(Umur, 2)) < 17 then
      begin
        btNext.Enabled := True;
        btFrista.Visible := False;
        btFingerprint.Visible := False;
        lbInformasi.Caption := Halaman21;
      end else
      begin
        btNext.Enabled := False;
        btNext.Visible := False;
        btFrista.Visible := True;
        btFingerprint.Visible := True;

        btFrista.Enabled := True;
        btFingerprint.Enabled := True;
        lbInformasi.Caption := Halaman2;
      end;

    end;
    1 : begin
//      identitas pasien
//      Pastikan form utama APM mengunci posisi teratas
      Self.BringToFront;
      SetForegroundWindow(Self.Handle);

      TimeOut;

      TanggalKunjungan := DateToStr(Trunc(TglRegister));
      if Trunc(TglRegister) = Date then
      begin
        dtTglPelayanan.Date := TglRegister;

        bpjs := CreateBPJS;
        try
          memResponse.Text := bpjs.CekPeserta(NoBPJS, FormatDateTime('yyyy-mm-dd', TglRegister));

          jPeserta := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
          if Assigned(jPeserta) then
          try
            HakKelas := jPeserta.GetValue<string>('peserta.hakKelas.kode');
            NoKTP := jPeserta.GetValue<string>('peserta.nik');
            NoTelp := jPeserta.GetValue<string>('peserta.mr.noTelepon');
            edNamaPx.Text := jPeserta.GetValue<string>('peserta.nama');
            edNomorRM.Text:= jPeserta.GetValue<string>('peserta.mr.noMR');
            edTanggalLahir.Text := jPeserta.GetValue<string>('peserta.tglLahir');
            edNoKartu.Text := jPeserta.GetValue<string>('peserta.noKartu');
            edNoTelpon.Text:= jPeserta.GetValue<string>('peserta.mr.noTelepon');
          finally
            jPeserta.Free;
          end;

           try
            memResponse.Text := bpjs.CariNoSuratKontrol(NomorReferensi);
            jSurkon := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
            if Assigned(jSurkon) then
            try
              edNoSurkon.Text := jSurkon.GetValue<string>('noSuratKontrol');

              if jSurkon.GetValue<string>('sep.jnsPelayanan') = 'Rawat Inap' then
              begin
                jenisKunjungan := jkPostMRS;
                lbNotif.Caption := jenisKunjungan.ToCaption;
                {tambahan baru}
                edNoRujukan.Text := jSurkon.GetValue<string>('sep.noSep');
                RujukanFromSurkon := jSurkon.GetValue<string>('sep.provPerujuk.noRujukan');
                KodeDPJP := jSurkon.GetValue<string>('kodeDokter');
                {sampe sini}
                AsalRujukan := '2';
                KodePPKAsal := '0190R007';
                TglRujukan := jSurkon.GetValue<string>('tglTerbit');

                memResponse.Text := bpjs.GetRiwayatSEP(edNoKartu.Text);
                jSep := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
                if Assigned(jSep) then
                try
                  SepArr := jSep.GetValue('histori') as TJSONArray;
                  jSepItem := SepArr.Get(0) as TJSONObject;
                  memDiagnosa.Text := jSepItem.GetValue<string>('diagnosa');
                  KodeDiag := AmbilKodeDiagnosa(memDiagnosa.Text);
                finally
                  jSep.Free;
                end;
              end
              else
              if jSurkon.GetValue<string>('sep.jnsPelayanan') = 'Rawat Jalan' then
              begin
                jenisKunjungan := jkKontrol;
                lbNotif.Caption := jenisKunjungan.ToCaption;

                KodeDPJP := jSurkon.GetValue<string>('kodeDokterPembuat');
                edNoRujukan.Text := jSurkon.GetValue<string>('sep.provPerujuk.noRujukan');
                RujukanFromSurkon := jSurkon.GetValue<string>('sep.provPerujuk.noRujukan');
  //              ShowMessage('kontrol');
                try
                  memRequest.Text := bpjs.CekRujukan(RujukanFromSurkon);
                  jRujukan := TJSONObject.ParseJSONValue(memRequest.Text) as TJSONObject;
                  if Assigned(jRujukan) then
                  try
                    KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
                    AsalRujukan := jRujukan.GetValue<string>('asalFaskes');
                    KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
                    TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
                    memDiagnosa.Text := KodeDiag + ' - ' + jRujukan.GetValue<string>('rujukan.diagnosa.nama');
                  finally
                    jRujukan.Free; // Bersihkan memori Faskes 1
                  end;
                except
                  // Jika Faskes 1 gagal/error, coba Faskes 2
                  memRequest.Text := bpjs.CekRujukanFaskes2(RujukanFromSurkon);
                  jRujukan := TJSONObject.ParseJSONValue(memRequest.Text) as TJSONObject;
                  if Assigned(jRujukan) then
                  try
                    KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
                    AsalRujukan := jRujukan.GetValue<string>('asalFaskes');
                    KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
                    TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
                    memDiagnosa.Text := KodeDiag + ' - ' + jRujukan.GetValue<string>('rujukan.diagnosa.nama');
                  finally
                    jRujukan.Free; // Bersihkan memori Faskes 2
                  end;
                end;
              end;
            finally
              jSurkon.Free;
            end
            else
            begin
                          {RUJUKAN BARU FIX}
            // Jika jSurkon sempat ter-create (misal: JSON isinya pesan error dari BPJS),
              // kita harus tetap men-free memorinya sebelum lanjut.
              if Assigned(jSurkon) then
                jSurkon.Free;

              edNoRujukan.Text := NomorReferensi;
              RujukanFromSurkon := NomorReferensi;

              jenisKunjungan := jkRujukanBaru;
              lbNotif.Caption := jenisKunjungan.ToCaption;

              memRequest.Text := bpjs.CekRujukan(NomorReferensi);
              jRujukan := TJSONObject.ParseJSONValue(memRequest.Text) as TJSONObject;
              if Assigned(jRujukan) then
              try
                KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
                AsalRujukan := jRujukan.GetValue<string>('asalFaskes');
                KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
                TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
                memDiagnosa.Text := KodeDiag + ' - ' +jRujukan.GetValue<string>('rujukan.diagnosa.nama');
              finally
                jRujukan.Free;
              end;
            end;
          except

          end;
          dm.LoadDokter(KodeDokter);
          dm.LoadPoli(IdRuang);
          KodeDokterMapping := dm.vDokter.FieldByName('KdDokterMapping').AsString;
          KodePoliMapping   := dm.vPoli.FieldByName('KdRuangInstansi').AsString;
          edNamaDokter.Text := dm.vDokter.FieldByName('Nama').AsString;
          edNamaPoli.Text := dm.vPoli.FieldByName('Nama').AsString;

        finally

          bpjs.Free;
        end;

        if (KodeDiag <> '') AND ((LeftStr(KodeDiag , 1) = 'S') OR
          (LeftStr(KodeDiag , 1) = 'T') OR
          (LeftStr(KodeDiag , 1) = 'V') OR
          (LeftStr(KodeDiag , 1) = 'W'))  then
        begin
          ShowError('Perlu verifikasi kronologi, Silakan ke Loket Pendaftaran');
          lbNotif.Caption := 'Perlu verifikasi kronologi, Silakan ke Loket Pendaftaran';
          WarnaLabel('ERROR');
          Abort;
        end;

        pgUtama.ActivePageIndex := 2;
        edNoRujukan.SetFocus;

        lbNotif.Caption := 'Sukses '+ jenisKunjungan.ToCaption;
        WarnaLabel('SUKSES');
        s := jenisKunjungan.ToCaption;
        sbUtama.Panels[0].Text := sbUtama.Panels[0].Text+ ' > ' + s;
      end else
      begin
        MessageDlg('Tanggal kunjungan tidak sesuai.', mtWarning, [mbOK], 0);
        lbNotif.Caption := 'Tanggal kunjungan anda '+ TanggalKunjungan;
        WarnaLabel('ERROR');

        s := lbNotif.Caption;
        sbUtama.Panels[0].Text := sbUtama.Panels[0].Text+ ' > ' + s;

        Abort;
      end;
      pgUtama.ActivePageIndex := 2;
      lbInformasi.Caption := Halaman3;
      btSimpanCetak.Visible := True;
      btNext.Visible := False;
      btBack.Enabled := True;
    end;
  end;
end;

procedure TfrmMain.btPDRClick(Sender: TObject);
begin
  try
    TransaksiPDR;
    ShowMessage('Transaksi PDR Sukses');
  except
    MessageDlg('Transaksi Gagal', mtError, [mbOK], 0);
  end;
end;

procedure TfrmMain.btSimpanCetakClick(Sender: TObject);
var request : TJSONObject;
    t_sep : TJSONObject;
    klsRawat : TJSONObject;
    rujukan : TJSONObject;
    poli : TJSONObject;
    cob, katarak, jaminan : TJSONObject;
    penjamin, suplesi, lokasiLaka : TJSONObject;
    skdp : TJSONObject;
    reqBody : TJSONObject;

    jSep : TJSONObject;

//    parameter : TJSONObject;
//    namahari : string;
    jnsKunjungan : integer;
    res : string;
//    lama : integer;
//    nomorantri : integer;
//    jamawalpraktek : string;
//    tanggal : Tdatetime;
    bpjs : TBpjs;

begin
  TimeOut;

  dm.SambungKoneksi;
//  ADD ANTRIAN
//  try
//    namahari := dm.Get_Hari(dtTglPelayanan.Date);

//    "jeniskunjungan": {1 (Rujukan FKTP), 2 (Rujukan Internal), 3 (Kontrol), 4 (Rujukan Antar RS)},
//    "tujuanKunj":{"0": Normal, "1": Prosedur, "2": Konsul Dokter},
//    "assesmentPel":{"1": Poli spesialis tidak tersedia pada hari sebelumnya,
//                                 "2": Jam Poli telah berakhir pada hari sebelumnya,
//                                 "3": Dokter Spesialis yang dimaksud tidak praktek pada hari sebelumnya,
//                                 "4": Atas Instruksi RS} ==> diisi jika tujuanKunj = "2" atau "0" (politujuan beda dengan poli rujukan dan hari beda),
//                                 "5": Tujuan Kontrol,   }
    if jenisKunjungan = jkRujukanBaru then
    begin
      tujuanKunjungan := '0';
      asesmenPelayanan:= '';
      jnsKunjungan := 1;
    end else
    if jenisKunjungan = jkPostMRS then
    begin
      tujuanKunjungan := '0';
      asesmenPelayanan:= '';
      jnsKunjungan := 3;
    end else
    if jenisKunjungan = jkKontrol then
    begin
      tujuanKunjungan := '2';
      asesmenPelayanan:= '5';
      jnsKunjungan := 3;
    end;

   { dm.qTemp.Close;
    dm.qTemp.SQL.Clear;
    dm.qTemp.SQL.Text := 'exec Pr_TampilInfoAntrean :idregister, :namahari';
    dm.qTemp.Prepared;
    dm.qTemp.Parameters.ParamByName('idregister').Value := IdRegister;
    dm.qTemp.Parameters.ParamByName('namahari').Value := namahari;
    dm.qTemp.Open;

    nomorantri := dm.qTemp.FieldByName('angkaantrean').AsInteger-1;
    lama := dm.qTemp.FieldByName('LamaPemeriksaan').AsInteger;
    lama := lama * nomorantri;
    jamawalpraktek := LeftStr(dm.qTemp.FieldByName('jampraktek').AsString, 5) + ':01';
    tanggal := StrToDateTime(dtTglPelayanan.Text+ ' '+jamawalpraktek);
    tanggal := IncMinute(tanggal, lama);

    parameter := TJSONObject.Create;
    parameter.AddPair('kodebooking'      , IntToStr(IdRegister));
    parameter.AddPair('jenispasien'      , 'JKN');
    parameter.AddPair('nomorkartu'       , NoBPJS);
    parameter.AddPair('nik'              , NoKTP);
    parameter.AddPair('nohp'             , ReplaceStr(NoTelp,' ',''));
    parameter.AddPair('kodepoli'         , KodePoliMapping);
    parameter.AddPair('namapoli'         , edNamaPoli.Text);
    parameter.AddPair('pasienbaru'       , TJSONNumber.Create(dm.qTemp.FieldByName('IsBaru').AsInteger));
    parameter.AddPair('norm'             , ReplaceStr(edNoRM.Text,'.',''));
    parameter.AddPair('tanggalperiksa'   , FormatDateTime('yyyy-mm-dd',dtTglPelayanan.Date));
    parameter.AddPair('kodedokter'       , KodeDokterMapping);
    parameter.AddPair('namadokter'       , edNamaDokter.Text);
    parameter.AddPair('jampraktek'       , ReplaceStr(dm.qTemp.FieldByName('jampraktek').AsString,' - ','-'));
    parameter.AddPair('jeniskunjungan'   , TJSONNumber.Create(jnsKunjungan));
    parameter.AddPair('nomorreferensi'   , nomorreferensi);
    parameter.AddPair('nomorantrean'     , dm.qTemp.FieldByName('nomorantrean').AsString);
    parameter.AddPair('angkaantrean'     , TJSONNumber.Create(dm.qTemp.FieldByName('angkaantrean').AsInteger));
    parameter.AddPair('estimasidilayani' , TJSONNumber.Create(DateTimeToUnix(tanggal)*1000));
    parameter.AddPair('sisakuotajkn'     , TJSONNumber.Create(dm.qTemp.FieldByName('sisakuotajkn').AsInteger));
    parameter.AddPair('kuotajkn'         , TJSONNumber.Create(dm.qTemp.FieldByName('kuotajkn').AsInteger));
    parameter.AddPair('sisakuotanonjkn'  , TJSONNumber.Create(dm.qTemp.FieldByName('sisakuotanonjkn').AsInteger));
    parameter.AddPair('kuotanonjkn'      , TJSONNumber.Create(dm.qTemp.FieldByName('kuotanonjkn').AsInteger));
    parameter.AddPair('keterangan'       , dm.qTemp.FieldByName('keterangan').AsString);
    sss := parameter.ToJSON;
  finally
    parameter.Free;
  end;   }

  btSimpanCetak.Enabled := False;
  bpjs := CreateBPJS;
  try
    t_sep := TJSONObject.Create;
    t_sep.AddPair('noKartu', NoBPJS);   //
    t_sep.AddPair('tglSep', FormatDateTime('yyyy-mm-dd', TglRegister)); //
    t_sep.AddPair('ppkPelayanan', KodeRS); //
    t_sep.AddPair('jnsPelayanan', '2');
      klsRawat := TJSONObject.Create;
      klsRawat.AddPair('klsRawatHak', HakKelas); //
      klsRawat.AddPair('klsRawatNaik', '');
      klsRawat.AddPair('pembiayaan', '');
      klsRawat.AddPair('penanggungJawab', '');
    t_sep.AddPair('klsRawat', klsRawat); //
    t_sep.AddPair('noMR', NoRM); //
      rujukan := TJSONObject.Create;
      rujukan.AddPair('asalRujukan', AsalRujukan);
      rujukan.AddPair('tglRujukan', TglRujukan);
      rujukan.AddPair('noRujukan', edNoRujukan.Text);
      rujukan.AddPair('ppkRujukan', KodePPKAsal);
    t_sep.AddPair('rujukan', rujukan);
    if jenisKunjungan = jkPostMRS then
      t_sep.AddPair('catatan', 'NIK '+ NoKTP + #13 + jenisKunjungan.ToCaption) //
    else
      t_sep.AddPair('catatan', 'NIK '+ NoKTP); //
    t_sep.AddPair('diagAwal', KodeDiag);
      poli := TJSONObject.Create;
      poli.AddPair('tujuan', KodePoliMapping); //
      poli.AddPair('eksekutif', '0');
    t_sep.AddPair('poli', poli); //
      cob := TJSONObject.Create;
      cob.AddPair('cob', '0');
    t_sep.AddPair('cob', cob); //
      katarak := TJSONObject.Create;
      katarak.AddPair('katarak', '0');
    t_sep.AddPair('katarak', katarak); //
      jaminan := TJSONObject.Create;
      jaminan.AddPair('lakaLantas', '0');
      jaminan.AddPair('noLP', '');
        penjamin := TJSONObject.Create;
        penjamin.AddPair('tglKejadian', '');
        penjamin.AddPair('keterangan', '');
          suplesi := TJSONObject.Create;
          suplesi.AddPair('suplesi', '');
          suplesi.AddPair('noSepSuplesi', '');
            lokasiLaka := TJSONObject.Create;
            lokasiLaka.AddPair('kdPropinsi', '');
            lokasiLaka.AddPair('kdKabupaten', '');
            lokasiLaka.AddPair('kdKecamatan', '');
          suplesi.AddPair('lokasiLaka', lokasiLaka);
        penjamin.AddPair('suplesi', suplesi);
      jaminan.AddPair('penjamin', penjamin);
    t_sep.AddPair('jaminan', jaminan); //
    t_sep.AddPair('tujuanKunj', tujuanKunjungan);
    t_sep.AddPair('flagProcedure', '');
    t_sep.AddPair('kdPenunjang', '');
    t_sep.AddPair('assesmentPel', asesmenPelayanan);
      skdp := TJSONObject.Create;
      skdp.AddPair('noSurat', edNoSurkon.Text);
      skdp.AddPair('kodeDPJP', KodeDPJP);
    t_sep.AddPair('skdp', skdp);
    t_sep.AddPair('dpjpLayan', KodeDokterMapping);
    t_sep.AddPair('noTelp', NoTelp);
    t_sep.AddPair('user', 'WS Mandiri');

    request := TJSONObject.Create;
    request.AddPair('t_sep', t_sep);

    reqBody := TJSONObject.Create;
    reqBody.AddPair('request', request);

    memRequest.Text := reqBody.ToJSON;
    {untuk test}
//    Abort;
//    ShowMessage(jenisKunjungan.ToCaption);
//    memResponse.Lines.Add(sss);
    try
      {Buat SEP}
      memResponse.Text := bpjs.CreateSEP(memRequest.Text);
      jSep := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
      {mandatory}
      NoSEP := jSep.GetValue<string>('sep.noSep');
      lbNoSep.Caption := NoSEP;

      SyncSEP(NoSEP, jenisKunjungan.ToCaption);

      TransaksiPDR;
      CetakNoAntri;
      lbNotif.Caption := 'SEP terbit dengan nomor '+ NoSEP;
      WarnaLabel('SUKSES');
      sbUtama.Panels[0].Text := lbNotif.Caption;
    except
//      ShowMessage(memResponse.Text);
      ShowError(memResponse.Text);
      lbNotif.Caption := memResponse.Text;
      WarnaLabel('ERROR');
      sbUtama.Panels[0].Text := memResponse.Text;
    end;

  finally
    ClearParameterValue;
    reqBody.Free;
    bpjs.Free;
    btSimpanCetak.Enabled := True;
  end;
  pgUtama.ActivePageIndex := 0;
  edKodeBooking.SetFocus;
end;

procedure TfrmMain.btSyncClick(Sender: TObject);
begin
  SyncSEP(lbNoSep.Caption, jenisKunjungan.ToCaption);
end;

function TfrmMain.FindFristaWindow: HWND;
begin
  // ! SENGAJA pakai caption sederhana (lebih stabil untuk kiosk)
  Result := FindWindow(nil,
  'Frista (Face Recognition BPJS Kesehatan) 3.0.2');
//  FristaHandle := 0;
//  EnumWindows(@EnumWindowsProc, 0);
//  Result := FristaHandle;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  I: Integer;
  Btn: TSpeedButton;
begin
  for I := 0 to gpNum.ControlCount - 1 do
  begin
    if gpNum.Controls[I] is TSpeedButton then
    begin
      Btn := TSpeedButton(gpNum.Controls[I]);

      if SameText(Btn.Caption, 'ENTER') then
        Btn.OnClick := NumpadEnter
      else
        Btn.OnClick := NumpadClick;
    end;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=vk_F11) and (pgUtama.HideTabs = false) then
    begin
      pgUtama.HideTabs := true;
    end else
  if (key=vk_F11) and (pgUtama.HideTabs = true) then
    begin
      pgUtama.HideTabs := false;
    end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  dm.fpath := ExtractFilePath(Application.ExeName);
//  ShowMessage(fpath);

  dm.koneksi.Close;
  dm.koneksi.Provider:=dm.fpath+'koneksi.udl';
  dm.koneksi.ConnectionString:='FILE NAME='+dm.fpath+'koneksi.udl';
  dm.koneksi.Open;
  dm.koneksi.Connected:=true;

  pgUtama.HideTabs:= true;
  pgUtama.ActivePageIndex := 0;
  edKodeBooking.SetFocus;
  Shape1.Brush.Color := YasminOrange;
  Shape2.Brush.Color := YasminGreen;
  {tombol lanjutkan}
  btNext.Colors.Normal := RGB(11,159,83);   // hijau brand
  btNext.Colors.Hot := RGB(9,140,73);       // hover
  btNext.Colors.Pressed := RGB(7,120,60);   // ditekan

  btNext.Font.Color := clWhite;

  {tombol kembali}
  btBack.Colors.Normal := RGB(220,220,220);
  btBack.Colors.Hot := RGB(200,200,200);
  btBack.Colors.Pressed := RGB(180,180,180);

  btBack.Font.Color := clBlack;
  btBack.Visible := False;
//  gbBottom.Style.Color := YasminOrange;
  {tombol simpan}
  btSimpanCetak.Colors.Normal := RGB(11,159,83);   // hijau brand
  btSimpanCetak.Colors.Hot := RGB(9,140,73);       // hover
  btSimpanCetak.Colors.Pressed := RGB(7,120,60);   // ditekan

  btSimpanCetak.Font.Color := clWhite;
  btSimpanCetak.Visible := False;

  sbUtama.Panels[0].Text := HalamanAwal;
  lbInformasi.Caption := Halaman1;

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
procedure TfrmMain.tmTimeOutTimer(Sender: TObject);
begin
  ClearParameterValue;
  pgUtama.ActivePageIndex:= 0;
end;

procedure TfrmMain.btShowKeyboardClick(Sender: TObject);
begin
  KillProcessByName(TABTIP_PROCESS);
  ShowVirtualKeyboard;
end;

procedure TfrmMain.TransaksiPDR;
var
//IdJenisPembayaran, IdJenisPendapatan, IdJenisPembayaranDiskon : integer;
//    TotalBersih, TotalKotor, TotalDiskon : Currency;
//    GrupJenisBayar, TotalPendapatan : string;
    KodeTransaksiPenghasilan : string;
begin
  dm.qTransaksi.Close;
  dm.qTransaksi.SQL.Clear;
  dm.qTransaksi.SQL.Text := 'exec pr_BuatKodeTransaksiRi :JenisTransaksi';
  dm.qTransaksi.Prepared;
  dm.qTransaksi.Parameters.ParamByName('JenisTransaksi').Value := 'PRJ';
  dm.qTransaksi.Open;
  KodeTransaksiPenghasilan := dm.qTransaksi.Fields[0].AsString;

//insert transaksi pengahasilan
  dm.qTransaksi.Close;
  dm.qTransaksi.SQL.Clear;
  dm.qTransaksi.SQL.Text := 'exec pr_InsertTransaksiPenghasilan :KodeTransaksiPenghasilan , '+
            ':KodeUser ,:KodeJenisTransBayar ,:IdRegister ,:KodeSo ,:StatusValidasi , '+
            ':StatusBayar ,:TanggalTransaksi,:TanggalBayar,:NoBuktiPendukung,:PPNKeluaran, '+
            ':TotalBayar,:IsResep,:RefJurnal,:DP,:WaktuPesan, :WaktuAmbil, :Voucher, :Status, '+
            ':KodeMeja, :KodeKategoriCustomer, :KodeKaryawan, :IdRuang,:KodeMedTrans, :GrupTrans, ' +
            ':Poin, :TotalBruto, :TglEdPoin, :IdPosTransaksi';
  dm.qTransaksi.Prepared;
  dm.qTransaksi.Parameters.ParamByName('KodeTransaksiPenghasilan').Value := KodeTransaksiPenghasilan;
  dm.qTransaksi.Parameters.ParamByName('KodeUser').Value            := 'mobilejkn';
  dm.qTransaksi.Parameters.ParamByName('KodeJenisTransBayar').Value := 'PRJ2902';
  dm.qTransaksi.Parameters.ParamByName('IdRegister').Value          := IdRegister;
  dm.qTransaksi.Parameters.ParamByName('KodeSo').Value              := '1112100';
  dm.qTransaksi.Parameters.ParamByName('StatusValidasi').Value      := 0;
  dm.qTransaksi.Parameters.ParamByName('StatusBayar').Value         := 0;
  dm.qTransaksi.Parameters.ParamByName('TanggalTransaksi').Value    := DateTimeToStr(Now);
  dm.qTransaksi.Parameters.ParamByName('TanggalBayar').Value        := Null;
  dm.qTransaksi.Parameters.ParamByName('NoBuktiPendukung').Value   := Null;
  dm.qTransaksi.Parameters.ParamByName('PPNKeluaran').Value  := null;
  dm.qTransaksi.Parameters.ParamByName('TotalBayar').Value   := 50000;
  dm.qTransaksi.Parameters.ParamByName('IsResep').Value    := 0;
  dm.qTransaksi.Parameters.ParamByName('RefJurnal').Value  := Null;
  dm.qTransaksi.Parameters.ParamByName('DP').Value         := Null;
  dm.qTransaksi.Parameters.ParamByName('WaktuPesan').Value := Null;
  dm.qTransaksi.Parameters.ParamByName('WaktuAmbil').Value := Null;
  dm.qTransaksi.Parameters.ParamByName('Voucher').Value    := Null;
  dm.qTransaksi.Parameters.ParamByName('Status').Value       := Null;
  dm.qTransaksi.Parameters.ParamByName('KodeMeja').Value     := Null;
  dm.qTransaksi.Parameters.ParamByName('KodeKategoriCustomer').Value := Null;
  dm.qTransaksi.Parameters.ParamByName('KodeKaryawan').Value :=  Null;
  dm.qTransaksi.Parameters.ParamByName('IdRuang').Value      := IdRuang ;
  dm.qTransaksi.Parameters.ParamByName('KodeMedTrans').Value := KodeDokter ;
  dm.qTransaksi.Parameters.ParamByName('GrupTrans').Value    := 'RJ';
  dm.qTransaksi.Parameters.ParamByName('Poin').Value       := 0;
  dm.qTransaksi.Parameters.ParamByName('TotalBruto').Value := 50000;
  dm.qTransaksi.Parameters.ParamByName('TglEdPoin').Value  := Null;
  dm.qTransaksi.Parameters.ParamByName('IdPosTransaksi').Value := 3;
  dm.qTransaksi.ExecSQL;

//insert detail transaksi penghasilan
  dm.qTransaksi.Close;
  dm.qTransaksi.SQL.Clear;
  dm.qTransaksi.SQL.Text := 'exec pr_InsertDetailTransaksiPenghasilanRi ' +
                       ':KodeTransaksiPenghasilan , :KodeTarif , :KodeKaryawan , ' +
                       ':KdBarang , :JumlahTransaksi , :HargaJual , :Diskon , ' +
                       ':IdGudang , :HargaRata';
  dm.qTransaksi.Prepared;
  dm.qTransaksi.Parameters.ParamByName('KodeTransaksiPenghasilan').Value := KodeTransaksiPenghasilan;
  dm.qTransaksi.Parameters.ParamByName('KodeTarif').Value    := 'RJAPO0000000004'; //PDR Spesialis
  dm.qTransaksi.Parameters.ParamByName('KodeKaryawan').Value := KodeDokter;
  dm.qTransaksi.Parameters.ParamByName('KdBarang').Value     := null;
  dm.qTransaksi.Parameters.ParamByName('JumlahTransaksi').Value := 1;
  dm.qTransaksi.Parameters.ParamByName('HargaJual').Value    := 50000;
  dm.qTransaksi.Parameters.ParamByName('Diskon').Value       := 0;  // Pasien Kerjasama
  dm.qTransaksi.Parameters.ParamByName('IdGudang').Value     := null;
  dm.qTransaksi.Parameters.ParamByName('HargaRata').Value    := 0;
  dm.qTransaksi.ExecSQL;
  dm.qTransaksi.Close;

end;
procedure TfrmMain.CetakNoAntri;
begin
  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'exec Pr_TampilAntrianPerRegister :IdRegister';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('IdRegister').Value:= IdRegister;
  dm.qTemp.Open;

  dm.vExData.Active:=false;
  dm.vExData.Active:=true;

  dm.vExData.Assign(dm.qTemp);

  dm.qTemp.Close;


  dm.ReportPrint.LoadFromFile(ExtractFilePath(Application.exename)+'Reports\'+'Nomer Antrian.fr3');
//  ShowMessage('mau coba print');
//    if BtDesign.Down=false then
//    begin
//      if BtAutoPrint.Down=false then
//      begin
//        DM.ReportPrint.PrintOptions.Printer:= GetDefaultPrinterName; //DM.vPrinters.FieldByName('namaprinter').AsString ; //'GP-7635III';
//        DM.ReportPrint.ShowReport;
//        DM.vExData.Clear;
//      end
//      else
//      begin
        DM.ReportPrint.PrintOptions.Printer := GetDefaultPrinterName;
        DM.ReportPrint.PrintOptions.ShowDialog := false;
        DM.ReportPrint.PrepareReport;
        DM.ReportPrint.Print;
        DM.vExData.Clear;
//      end;
//    end
//    else
//    begin
//      DM.ReportPrint.DesignReport;
//      DM.vExData.Clear;
//    end;
end;
procedure TfrmMain.SyncSEP(ANoSep : string; AJnsKunjungan : string);
var res : string;
    sep : TJSONValue;
    sepKontrol : TJSONValue;
    peserta : TJSONValue;
    noKartu, noRujukan : string;
    rujukan : TJSONValue;
    jenpel : string;
    bpjs : TBpjs;
begin
// ----- cari nomer sep di vclaim ------------

  try
    bpjs := CreateBPJS;
    res := bpjs.CariSEP(ANoSep);
    sep := TJSONObject.ParseJSONValue(res) as TJSONValue;
    noKartu := sep.GetValue<string>('peserta.noKartu');
    noRujukan := sep.GetValue<string>('noRujukan');

    res := bpjs.CekRujukan(noRujukan);
    rujukan := TJSONObject.ParseJSONValue(res) as TJSONValue;

    if sep.GetValue<string>('jnsPelayanan') = 'Rawat Jalan' then
    begin
      jenpel := 'R.Jalan';
    end else
    begin
      jenpel := 'R.Inap';
    end;

    res := bpjs.CariSepKontrol(ANoSep);
    sepKontrol := TJSONObject.ParseJSONValue(res) as TJSONValue;

    res := bpjs.cekPeserta(noKartu, FormatDateTime('yyyy-MM-dd', Now));
    peserta:= TJSONObject.ParseJSONValue(res) as TJSONValue;
  finally
    bpjs.Free;
  end;


//  -------------cek di tabel SJP ----------
  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'SELECT * FROM SJP ' +
                       'WHERE NOSJP = :noSep ';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('noSep').Value := ANoSEP ;
  dm.qTemp.Open;

  if dm.qTemp.RecordCount > 0 then
  begin
    ShowError('No SEP sudah digunakan '+ dm.qTemp.FieldByName('NAMAPESERTA').AsString);
    Abort;
  end;
//  -------------- insert tabel sjp -----------

//  EdRegDiagnosaMasuk.Text := res;

  try
    dm.qTemp.Close;
    dm.qTemp.SQL.Clear;
    dm.qTemp.SQL.Add('exec pr_InsertSEP5 :IdInstansi, :IdRegister, :ERRORCODE, :ERRORDESC, :NOSJP,' +
                ':TGLSJP, :NOMORRUJUKAN, :TGLRUJUKAN, :KDPPKASALRUJUKAN, :NMPPKASALRUJUKAN,' +
                ':KDPOLI, :NMPOLI, :KDDIAG, :NMDIAG, :NOKAPESERTA, :NAMAPESERTA, :PLAN,' +
                ':PLANDESC, :KELAS, :KELASDESC, :NOMEDICALRECORD, :JENISKELAMIN, :TGLLAHIR, ' +
                ':KDBU, :NMBU, :IDAKOMODASI, :TIPESJP, :TIPECOB, :NOBPJS, :JENPELSJP, :TGLBUATSJP, :KodeUser, '+
                ':KodeKasus, :KdDiagnosaTambahan, :NmDiagnosaTambahan, :CatatanKhusus, :IdRuang, :isKatarak,' +
                ':IsSuplesi, :Penjamin, :KodeDPJP, :NamaDPJP, :catatan') ;
    dm.qTemp.Prepared;
    dm.qTemp.Parameters.ParamByName('IdInstansi').Value   := 154;
    dm.qTemp.Parameters.ParamByName('IdRegister').Value   := IdRegister;
    dm.qTemp.Parameters.ParamByName('ERRORCODE').Value    := 200;
    dm.qTemp.Parameters.ParamByName('ERRORDESC').Value    := 'SUKSES';
    dm.qTemp.Parameters.ParamByName('NOSJP').Value        := ANoSEP;
    dm.qTemp.Parameters.ParamByName('TGLSJP').Value       := DateTimeToStr(DM.StringToDateTime(sep.GetValue<string>('tglSep') +' '+TimeToStr(Now)));
    dm.qTemp.Parameters.ParamByName('NOMORRUJUKAN').Value := sep.GetValue<string>('noRujukan');
    dm.qTemp.Parameters.ParamByName('TGLRUJUKAN').Value   := DateTimeToStr(DM.StringToDateTime(sepKontrol.GetValue<string>('provPerujuk.tglRujukan')));
    dm.qTemp.Parameters.ParamByName('KDPPKASALRUJUKAN').Value := sepKontrol.GetValue<string>('provPerujuk.kdProviderPerujuk');
    dm.qTemp.Parameters.ParamByName('NMPPKASALRUJUKAN').Value := sepKontrol.GetValue<string>('provPerujuk.nmProviderPerujuk');
    try
      dm.qTemp.Parameters.ParamByName('KDPOLI').Value       := rujukan.GetValue<string>('rujukan.poliRujukan.kode');
      dm.qTemp.Parameters.ParamByName('NMPOLI').Value       := rujukan.GetValue<string>('rujukan.poliRujukan.nama');
      dm.qTemp.Parameters.ParamByName('KDDIAG').Value       := rujukan.GetValue<string>('rujukan.diagnosa.kode');
      dm.qTemp.Parameters.ParamByName('NMDIAG').Value       := rujukan.GetValue<string>('rujukan.diagnosa.nama');
    except
      dm.qTemp.Parameters.ParamByName('KDPOLI').Value       := '-';
      dm.qTemp.Parameters.ParamByName('NMPOLI').Value       := '-';
      dm.qTemp.Parameters.ParamByName('KDDIAG').Value       := '-';
      dm.qTemp.Parameters.ParamByName('NMDIAG').Value       := '-';
    end;
    dm.qTemp.Parameters.ParamByName('NOKAPESERTA').Value  := peserta.GetValue<string>('peserta.noKartu');
    dm.qTemp.Parameters.ParamByName('NAMAPESERTA').Value  := peserta.GetValue<string>('peserta.nama');
    dm.qTemp.Parameters.ParamByName('PLAN').Value         := peserta.GetValue<string>('peserta.hakKelas.kode');
    dm.qTemp.Parameters.ParamByName('PLANDESC').Value     := peserta.GetValue<string>('peserta.hakKelas.keterangan');
    dm.qTemp.Parameters.ParamByName('KELAS').Value        := sep.GetValue<string>('klsRawat.klsRawatHak');
    dm.qTemp.Parameters.ParamByName('KELASDESC').Value    := sep.GetValue<string>('kelasRawat');
    dm.qTemp.Parameters.ParamByName('NOMEDICALRECORD').Value := sep.GetValue<string>('peserta.noMr');
    dm.qTemp.Parameters.ParamByName('JENISKELAMIN').Value    := sep.GetValue<string>('peserta.kelamin');
    dm.qTemp.Parameters.ParamByName('TGLLAHIR').Value        := DateTimeToStr(DM.StringToDateTime(sep.GetValue<string>('peserta.tglLahir')));
    dm.qTemp.Parameters.ParamByName('KDBU').Value         := peserta.GetValue<string>('peserta.provUmum.kdProvider');
    dm.qTemp.Parameters.ParamByName('NMBU').Value         := peserta.GetValue<string>('peserta.provUmum.nmProvider');
    dm.qTemp.Parameters.ParamByName('IDAKOMODASI').Value  := peserta.GetValue<string>('peserta.mr.noTelepon');
    dm.qTemp.Parameters.ParamByName('TIPESJP').Value      := peserta.GetValue<string>('peserta.jenisPeserta.keterangan');
    dm.qTemp.Parameters.ParamByName('TIPECOB').Value      := sep.GetValue<string>('cob');
    dm.qTemp.Parameters.ParamByName('NOBPJS').Value       := peserta.GetValue<string>('peserta.noKartu');
    dm.qTemp.Parameters.ParamByName('JENPELSJP').Value    := jenpel;
    dm.qTemp.Parameters.ParamByName('TGLBUATSJP').Value   := DateTimeToStr(DM.StringToDateTime(sep.GetValue<string>('tglSep') +' '+TimeToStr(Now)));
    dm.qTemp.Parameters.ParamByName('KodeUser').Value     := 'mobilejkn';
    dm.qTemp.Parameters.ParamByName('KodeKasus').Value    := sep.GetValue<string>('kdStatusKecelakaan');
    dm.qTemp.Parameters.ParamByName('KdDiagnosaTambahan').Value := AJnsKunjungan;
    dm.qTemp.Parameters.ParamByName('NmDiagnosaTambahan').Value := sep.GetValue<string>('kontrol.noSurat');
    dm.qTemp.Parameters.ParamByName('CatatanKhusus').Value      := sep.GetValue<string>('catatan');
    dm.qTemp.Parameters.ParamByName('IdRuang').Value       := IdRuang;
    dm.qTemp.Parameters.ParamByName('isKatarak').Value     := sep.GetValue<integer>('katarak');
    dm.qTemp.Parameters.ParamByName('IsSuplesi').Value     := 0;
    dm.qTemp.Parameters.ParamByName('Penjamin').Value      := sep.GetValue<string>('penjamin');
    dm.qTemp.Parameters.ParamByName('KodeDPJP').Value      := sep.GetValue<string>('dpjp.kdDPJP');
    dm.qTemp.Parameters.ParamByName('NamaDPJP').Value      := sep.GetValue<string>('dpjp.nmDPJP');
    dm.qTemp.Parameters.ParamByName('catatan').Value       := peserta.GetValue<string>('peserta.informasi.prolanisPRB');
    dm.qTemp.ExecSQL;

    lbNotif.Caption := 'SEP Berhasil disimpan';
    WarnaLabel('SUKSES');
  except

  end;

end;
end.
