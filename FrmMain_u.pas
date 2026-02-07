unit FrmMain_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON, Vcl.Graphics, System.DateUtils, 
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
  dxGDIPlusClasses, Dm_u, cxMemo;

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
    btShowKeyboard: TSpeedButton;
    lbNotif: TcxLabel;
    TabJSON: TcxTabSheet;
    memResponse: TcxMemo;
    gbDataPx: TcxGroupBox;
    edNoRujukan: TcxTextEdit;
    cxLabel9: TcxLabel;
    lbNama: TcxLabel;
    lbNoRM: TcxLabel;
    lbTglLahir: TcxLabel;
    lbNoKartu: TcxLabel;
    lbNoTelp: TcxLabel;
    edNamaPx: TcxTextEdit;
    edNomorRM: TcxTextEdit;
    edTanggalLahir: TcxTextEdit;
    edNoKartu: TcxTextEdit;
    edNoTelpon: TcxTextEdit;
    btCariRujukan: TSpeedButton;
    btCariKodeBooking: TSpeedButton;
    edDiagnosa: TcxTextEdit;
    cxLabel10: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    btRujukanBaru: TcxButton;
    btTujuanKontrol: TcxButton;
    Shape1: TShape;
    procedure btFristaClick(Sender: TObject);
    procedure edKodeBookingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btDoneClick(Sender: TObject);
    procedure btConfirmClick(Sender: TObject);
    procedure btSimpanCetakClick(Sender: TObject);
    procedure btShowKeyboardClick(Sender: TObject);
    procedure edNoRujukanKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCariRujukanClick(Sender: TObject);
    procedure btCariKodeBookingClick(Sender: TObject);
    procedure btRujukanBaruClick(Sender: TObject);
    procedure btTujuanKontrolClick(Sender: TObject);
  private
    procedure ShowVirtualKeyboard;
    procedure RunFrista;                          // + DITAMBAHKAN
    function  IsProcessRunning(const ExeName: string): Boolean; // + DITAMBAHKAN
    function  FindFristaWindow: HWND;              // + DITAMBAHKAN
    procedure ActivateApp(hWnd: HWND);            // + DITAMBAHKAN
    function  GetFristaExe: string;

    procedure ClearParameterValue;

    procedure CariSurkon(ANoSurkon : string);

    var
      IdRegister, IdInstansi, IdRuang : integer;
      KodeDokter,  KodePoli, KodeDokterMapping, KodePoliMapping : string;
      NoBPJS, NoRujukan, NoKTP, NoRM : string;
      TglRegister : TDateTime;
      KodeRS, HakKelas : string;
      AsalRujukan, KodePPKAsal, TglRujukan, KodeDiag, NoTelp : string;
      sss : string;
      tujuanKunjungan, asesmenPelayanan: string;
      
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
const
  FRISTA_PROCESS = 'frista.exe';
  TABTIP_PROCESS = 'TabTip.exe';

implementation

{$R *.dfm}
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

procedure TfrmMain.ClearParameterValue;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TcxTextEdit then
      TcxTextEdit(Components[i]).Clear

    else if Components[i] is TcxDateEdit then
    begin
      TcxDateEdit(Components[i]).Text := '';
    end;

  end;
  tujuanKunjungan := '';
  asesmenPelayanan:= '';
  btRujukanBaru.LookAndFeel.SkinName := 'HighContrast';
  btTujuanKontrol.LookAndFeel.SkinName := 'HighContrast';
end;
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

procedure TfrmMain.btCariKodeBookingClick(Sender: TObject);
var
    jSurkon : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
begin
  if tujuanKunjungan = '' then
  begin
    ShowMessage('Tujuan kunjungan belum dipilih!');
    Abort;
  end;
    try
      dm.qTemp.Close;
      dm.qTemp.SQL.Clear;
      dm.qTemp.SQL.Text := 'SELECT IdRegister, Nama, NoRM, TglLahirPx, NoSP, IdRuang, ' +
                           'KodeKaryawan, TglRegister, IsSementara, NoJaminan, IdInstansi ' +
                           'FROM vRegister WHERE IdRegister = :kodebooking';
      dm.qTemp.Prepared;
      dm.qTemp.Parameters.ParamByName('kodebooking').Value := edKodeBooking.Text;
      dm.qTemp.Open;

      if dm.qTemp.IsEmpty then
      begin
        ShowMessage('Kode Booking tidak ditemukan.');
        Exit;
      end;

//      if dm.qTemp.FieldByName('IsSementara').AsBoolean = true then
//      begin
//        ShowMessage('Pasien belum check-in.');
//        Exit;
//      end;

      edNamaPasien.Text := dm.qTemp.FieldValues['Nama'];
      edTglLahir.Text   := FormatDateTime('dd/mm/yyyy', dm.qTemp.FieldValues['TglLahirPx']);
      edNoRM.Text       := dm.qTemp.FieldValues['NoRM'];

      IdRegister  := dm.qTemp.FieldValues['IdRegister'];
      IdInstansi  := dm.qTemp.FieldValues['IdInstansi'];
//      NoRujukan   := dm.qTemp.FieldValues['NoSP'];
      IdRuang     := dm.qTemp.FieldValues['IdRuang'];
      KodeDokter  := dm.qTemp.FieldValues['KodeKaryawan'];
      TglRegister := dm.qTemp.FieldValues['TglRegister'];
      NoBPJS      := dm.qTemp.FieldValues['NoJaminan'];
      NoRM        := StringReplace(edNoRM.Text, '.', '', [rfReplaceAll]);

      btConfirm.Enabled := True;
    except
      ShowMessage('Kode Booking tidak valid');
    end;

end;

procedure TfrmMain.btCariRujukanClick(Sender: TObject);
var
    jSurkon, jRujukan : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
begin
  bpjs := TBpjs.Create;
    try
      memResponse.Text := bpjs.cekRujukan(edNoRujukan.Text);
      if memResponse.Text = 'Data Rujukan Tidak Ditemukan.' then
      begin
        MessageDlg('Rujukan tidak valid', mtError, [mbOK], 0);
        edNoRujukan.SetFocus;
        Abort;
      end;
      jRujukan := TJSONObject.Create;
      jRujukan := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
      KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
      KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
      TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
      edDiagnosa.Text := KodeDiag + ' - ' +jRujukan.GetValue<string>('rujukan.diagnosa.nama');

      memResponse.Text := bpjs.cekSurkonbyNoka(NoBPJS);
      jSurkon := TJSONObject.Create;
      jSurkon := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
      jsa := jSurkon.GetValue('list') as TJSONArray;

      jso := TJSONObject.Create;
      jso := jsa.Get(0) as TJSONObject;

      edNoSurkon.Text := jso.GetValue<string>('noSuratKontrol');
      dm.LoadDokter(KodeDokter);
      dm.LoadPoli(IdRuang);
      KodeDokterMapping := dm.vDokter.FieldValues['KdDokterMapping'];
      KodePoliMapping   := dm.vPoli.FieldValues['KdRuangInstansi'];
      edNamaDokter.Text := dm.vDokter.FieldValues['Nama'];
      edNamaPoli.Text := dm.vPoli.FieldValues['Nama'];
    finally
      bpjs.Free;
    end;
end;

procedure TfrmMain.btConfirmClick(Sender: TObject);
var TanggalKunjungan : string;
    jPeserta : TJSONObject;
begin

  dm.SambungKoneksi;

  TanggalKunjungan := DateToStr(Trunc(TglRegister));
  if Trunc(TglRegister) = Date then
  begin
    dtTglPelayanan.Date := TglRegister;

    bpjs := TBpjs.Create;
    try
//      memResponse.Text := bpjs.cekPeserta(NoBPJS, FormatDateTime('yyyy-mm-dd', TglRegister));
      memResponse.Text := bpjs.cekRujukan(NoBPJS);
      jPeserta := TJSONObject.Create;
      jPeserta := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;

      KodeRS  := bpjs.KodeRs;

      HakKelas := jPeserta.GetValue<string>('rujukan.peserta.hakKelas.kode');
      NoKTP := jPeserta.GetValue<string>('rujukan.peserta.nik');
      NoTelp := jPeserta.GetValue<string>('rujukan.peserta.mr.noTelepon');

      edNoRujukan.Text := jPeserta.GetValue<string>('rujukan.noKunjungan');


    finally
      jPeserta.Free;
      bpjs.Free;
    end;
  
    
    pgUtama.ActivePageIndex := 1;
    edNoRujukan.SetFocus;
  end else
  begin
    MessageDlg('Tanggal kunjungan tidak sesuai.', mtWarning, [mbOK], 0);
    lbNotif.Caption := 'Tanggal kunjungan anda '+ TanggalKunjungan;
  end;
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
    btDone.Visible := true;
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

procedure TfrmMain.btRujukanBaruClick(Sender: TObject);
begin
  {"tujuanKunj":{"0": Normal,
                "1": Prosedur,
                "2": Konsul Dokter}
  tujuanKunjungan := '0';
  asesmenPelayanan:= '';
  btRujukanBaru.LookAndFeel.SkinName := 'Whiteprint';
  btTujuanKontrol.LookAndFeel.SkinName := 'HighContrast';
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
begin

  dm.SambungKoneksi;

  bpjs := TBpjs.Create;
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
      rujukan.AddPair('asalRujukan', '1');
      rujukan.AddPair('tglRujukan', TglRujukan);
      rujukan.AddPair('noRujukan', edNoRujukan.Text);
      rujukan.AddPair('ppkRujukan', KodePPKAsal);
    t_sep.AddPair('rujukan', rujukan);
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
      skdp.AddPair('kodeDPJP', KodeDokterMapping);
    t_sep.AddPair('skdp', skdp);
    t_sep.AddPair('dpjpLayan', KodeDokterMapping);
    t_sep.AddPair('noTelp', NoTelp);
    t_sep.AddPair('user', 'WS Mandiri');


    request := TJSONObject.Create;
    request.AddPair('t_sep', t_sep);

    reqBody := TJSONObject.Create;
    reqBody.AddPair('request', request);

    memResponse.Text := reqBody.ToJSON;
    ClearParameterValue;

    btConfirm.Enabled := false;
    pgUtama.ActivePageIndex := 0;
  finally
    bpjs.Free;
  end;


end;

procedure TfrmMain.btTujuanKontrolClick(Sender: TObject);
begin
//  {"tujuanKunj":{"0": Normal,
//                "1": Prosedur,
//                "2": Konsul Dokter}
//  "assesmentPel":{"1": Poli spesialis tidak tersedia pada hari sebelumnya,
//                                 "2": Jam Poli telah berakhir pada hari sebelumnya,
//                                 "3": Dokter Spesialis yang dimaksud tidak praktek pada hari sebelumnya,
//                                 "4": Atas Instruksi RS} ==> diisi jika tujuanKunj = "2" atau "0" (politujuan beda dengan poli rujukan dan hari beda),
//                                 "5": Tujuan Kontrol,}
  tujuanKunjungan := '2';
  asesmenPelayanan:= '5';
  btTujuanKontrol.LookAndFeel.SkinName := 'Whiteprint';
  btRujukanBaru.LookAndFeel.SkinName := 'HighContrast';
end;

function TfrmMain.FindFristaWindow: HWND;
begin
  // ! SENGAJA pakai caption sederhana (lebih stabil untuk kiosk)
  Result := FindWindow(nil,
  'Frista (Face Recognition BPJS Kesehatan) 3.0.2');
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
//  pgUtama.HideTabs:= true;
  pgUtama.ActivePageIndex := 0;
end;

procedure TfrmMain.ActivateApp(hWnd: HWND);
begin
  if IsIconic(hWnd) then
    ShowWindow(hWnd, SW_RESTORE);

  SetForegroundWindow(hWnd);
end;

procedure TfrmMain.edKodeBookingKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    jSurkon : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
begin
  if Key = VK_RETURN then
  begin
    try
      dm.qTemp.Close;
      dm.qTemp.SQL.Clear;
      dm.qTemp.SQL.Text := 'SELECT IdRegister, Nama, NoRM, TglLahirPx, NoSP, IdRuang, ' +
                           'KodeKaryawan, TglRegister, IsSementara, NoJaminan, IdInstansi ' +
                           'FROM vRegister WHERE IdRegister = :kodebooking';
      dm.qTemp.Prepared;
      dm.qTemp.Parameters.ParamByName('kodebooking').Value := edKodeBooking.Text;
      dm.qTemp.Open;

      if dm.qTemp.IsEmpty then
      begin
        ShowMessage('Kode Booking tidak ditemukan.');
        Exit;
      end;

//      if dm.qTemp.FieldByName('IsSementara').AsBoolean = true then
//      begin
//        ShowMessage('Pasien belum check-in.');
//        Exit;
//      end;

      edNamaPasien.Text := dm.qTemp.FieldValues['Nama'];
      edTglLahir.Text   := FormatDateTime('dd/mm/yyyy', dm.qTemp.FieldValues['TglLahirPx']);
      edNoRM.Text       := dm.qTemp.FieldValues['NoRM'];

      IdRegister  := dm.qTemp.FieldValues['IdRegister'];
      IdInstansi  := dm.qTemp.FieldValues['IdInstansi'];
//      NoRujukan   := dm.qTemp.FieldValues['NoSP'];
      IdRuang     := dm.qTemp.FieldValues['IdRuang'];
      KodeDokter  := dm.qTemp.FieldValues['KodeKaryawan'];
      TglRegister := dm.qTemp.FieldValues['TglRegister'];
      NoBPJS      := dm.qTemp.FieldValues['NoJaminan'];
      NoRM        := StringReplace(edNoRM.Text, '.', '', [rfReplaceAll]);

      btConfirm.Enabled := True;


    except

    end;

  end;
end;

procedure TfrmMain.edNoRujukanKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
jSurkon : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
begin
  if Key = VK_RETURN then
  begin
    bpjs := TBpjs.Create;
    try
      memResponse.Text := bpjs.cekRujukan(edNoRujukan.Text);
      if memResponse.Text = 'Data Rujukan Tidak Ditemukan.' then
      begin
        MessageDlg('Rujukan tidak valid', mtError, [mbOK], 0);
        edNoRujukan.SetFocus;
        Abort;
      end;

      memResponse.Text := bpjs.cekSurkonbyNoka(NoBPJS);
      jSurkon := TJSONObject.Create;
      jSurkon := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
      jsa := jSurkon.GetValue('list') as TJSONArray;

      jso := TJSONObject.Create;
      jso := jsa.Get(0) as TJSONObject;

      edNoSurkon.Text := jso.GetValue<string>('noSuratKontrol');
      dm.LoadDokter(KodeDokter);
      dm.LoadPoli(IdRuang);
      KodeDokterMapping := dm.vDokter.FieldValues['KdDokterMapping'];
      KodePoliMapping   := dm.vPoli.FieldValues['KdRuangInstansi'];
      edNamaDokter.Text := dm.vDokter.FieldValues['Nama'];
      edNamaPoli.Text := dm.vPoli.FieldValues['Nama'];
    finally
      bpjs.Free;
    end;

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
procedure TfrmMain.btShowKeyboardClick(Sender: TObject);
begin
  KillProcessByName(TABTIP_PROCESS);
  ShowVirtualKeyboard;
end;

procedure TfrmMain.CariSurkon(ANoSurkon: string);
var jso : TJSONObject;
begin
  bpjs := TBpjs.Create;
  try

    sss := bpjs.CariNoSuratKontrol(ANoSurkon);
    jso := TJSONObject.ParseJSONValue(sss) as TJSONObject;
    KodePPKAsal := jso.GetValue<string>('sep.provPerujuk.kdProviderPerujuk');
    KodeDokterMapping := jso.GetValue<string>('kodeDokter');
    KodePoliMapping := jso.GetValue<string>('poliTujuan');
    edNamaDokter.Text := jso.GetValue<string>('namaDokter');
    edNamaPoli.Text := jso.GetValue<string>('namaPoliTujuan');
  finally
    bpjs.Free;

  end;
end;
end.
