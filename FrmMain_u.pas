unit FrmMain_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON, Vcl.Graphics, System.DateUtils, System.StrUtils,
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
  dxGDIPlusClasses, Dm_u, cxMemo, Printers, sendkeys;

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
    cxLabel10: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    Shape1: TShape;
    memDiagnosa: TcxMemo;
    Image2: TImage;
    tmTimeOut: TTimer;
    memResponse: TMemo;
    edNIK: TcxTextEdit;
    lbNoKtp: TcxLabel;
    edNIKKtp: TcxTextEdit;
    cxLabel11: TcxLabel;
    btBatal: TcxButton;
    btPDR: TcxButton;
    btCetakAntrian: TcxButton;
    btSync: TcxButton;
    lbIdRegister: TcxLabel;
    memRequest: TMemo;
    btGetNoSEP: TButton;
    lbNoSep: TcxLabel;
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
  private
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

    var
      IdRegister, IdInstansi, IdRuang : integer;
      KodeDokter, KodeDokterMapping, KodePoliMapping : string;
      NoBPJS, NoKTP, NoRM : string;
      TglRegister : TDateTime;
      KodeRS, HakKelas : string;
      AsalRujukan, KodePPKAsal, TglRujukan, KodeDiag, NoTelp : string;
      sss : string;
      tujuanKunjungan, asesmenPelayanan: string;
      NomorReferensi : string;

      KodeDPJP : string; {dokter pembuat surkon}

      {result setelah create sep}
      NoSEP : string;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  jenisKunjungan : TJenisKunjungan;
const
  FRISTA_PROCESS = 'frista.exe';
  TABTIP_PROCESS = 'TabTip.exe';

implementation

{$R *.dfm}
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

procedure TfrmMain.ClearParameterValue;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TcxTextEdit then
    begin
      TcxTextEdit(Components[i]).Clear;
    end
    else
    if Components[i] is TcxDateEdit then
    begin
      TcxDateEdit(Components[i]).Text := '';
    end
    else
    if Components[i] is TcxMemo then
    begin
      TcxMemo(Components[i]).Clear;
    end;

  end;
  tujuanKunjungan := '';
  asesmenPelayanan:= '';
  KodeDPJP := '';

  btConfirm.Enabled := False;
  lbNotif.Caption := '-';
  WarnaLabel('SUKSES');
  {tutup sementara buat test}
//  pgUtama.ActivePageIndex := 0;
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

procedure TfrmMain.btBatalClick(Sender: TObject);
begin
  ClearParameterValue;
  pgUtama.ActivePageIndex := 0;
end;

procedure TfrmMain.btCariKodeBookingClick(Sender: TObject);
var
    jSurkon : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
begin
  TimeOut;

  if edKodeBooking.Text = '' then
  begin
    lbNotif.Caption := 'Kode booking belum di isi.';
    WarnaLabel('ERROR');
    edKodeBooking.SetFocus;
    Abort;
  end;

  lbIdRegister.Caption := edKodeBooking.Text;

    try
      dm.qTemp.Close;
      dm.qTemp.SQL.Clear;
      dm.qTemp.SQL.Text := 'SELECT IdRegister, NIK, Nama, NoRM, TglLahirPx, NoSP, IdRuang, ' +
                           'KodeKaryawan, TglRegister, IsSementara, NoJaminan, IdInstansi ' +
                           'FROM vRegister WHERE IdRegister = :kodebooking';
      dm.qTemp.Prepared;
      dm.qTemp.Parameters.ParamByName('kodebooking').Value := edKodeBooking.Text;
      dm.qTemp.Open;

      if dm.qTemp.IsEmpty then
      begin
        ShowMessage('Kode Booking tidak ditemukan.');
        lbNotif.Caption := 'Kode Booking tidak ditemukan.';
        WarnaLabel('ERROR');
        Abort;
      end;

      if dm.qTemp.FieldByName('IsSementara').AsBoolean = true then
      begin
        ShowMessage('Pasien belum check-in.');
        lbNotif.Caption := 'Pasien belum Check-in, Scan QRCode terlebih dahulu';
        WarnaLabel('ERROR');
        Abort;
      end;

      edNamaPasien.Text := dm.qTemp.FieldValues['Nama'];
      edTglLahir.Text   := FormatDateTime('dd/mm/yyyy', dm.qTemp.FieldValues['TglLahirPx']);
      edNoRM.Text       := dm.qTemp.FieldValues['NoRM'];
      edNIKKtp.Text     := dm.qTemp.FieldValues['NIK'];
      edNIK.Text := dm.qTemp.FieldValues['NIK'];

      IdRegister  := dm.qTemp.FieldValues['IdRegister'];
      IdInstansi  := dm.qTemp.FieldValues['IdInstansi'];
      NomorReferensi   := dm.qTemp.FieldValues['NoSP'];
      IdRuang     := dm.qTemp.FieldValues['IdRuang'];
      KodeDokter  := dm.qTemp.FieldValues['KodeKaryawan'];
      TglRegister := dm.qTemp.FieldValues['TglRegister'];
      NoBPJS      := dm.qTemp.FieldValues['NoJaminan'];
      NoRM        := StringReplace(edNoRM.Text, '.', '', [rfReplaceAll]);

//      btConfirm.Enabled := True;
      lbNotif.Caption := 'Sukses';
      WarnaLabel('SUKSES');

      btFrista.Enabled := True;
      btFingerprint.Enabled := True;
    except
      lbNotif.Caption := 'Kode Booking tidak valid';
      WarnaLabel('ERROR');
    end;

end;

procedure TfrmMain.btCariRujukanClick(Sender: TObject);
var
    jSurkon, jRujukan : TJSONObject;
    jsa : TJSONArray;
    jso : TJSONObject;
begin
  TimeOut;

  bpjs := TBpjs.Create;
    try
      memResponse.Text := bpjs.cekRujukan(edNoRujukan.Text);
      if memResponse.Text = 'Data Rujukan Tidak Ditemukan.' then
      begin
        MessageDlg('Rujukan tidak valid', mtError, [mbOK], 0);
        lbNotif.Caption := 'Rujukan tidak valid';
        WarnaLabel('ERROR');
        edNoRujukan.SetFocus;
        Abort;
      end;
      jRujukan := TJSONObject.Create;
      jRujukan := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
      KodeDiag := jRujukan.GetValue<string>('rujukan.diagnosa.kode');
      AsalRujukan := jRujukan.GetValue<string>('asalFaskes');
      KodePPKAsal := jRujukan.GetValue<string>('rujukan.provPerujuk.kode');
      TglRujukan := jRujukan.GetValue<string>('rujukan.tglKunjungan');
      memDiagnosa.Text := KodeDiag + ' - ' +jRujukan.GetValue<string>('rujukan.diagnosa.nama');

      dm.LoadDokter(KodeDokter);
      dm.LoadPoli(IdRuang);
      KodeDokterMapping := dm.vDokter.FieldValues['KdDokterMapping'];
      KodePoliMapping   := dm.vPoli.FieldValues['KdRuangInstansi'];
      edNamaDokter.Text := dm.vDokter.FieldValues['Nama'];
      edNamaPoli.Text := dm.vPoli.FieldValues['Nama'];

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
begin

  TimeOut;
//  btFristaClick(sender);

  TanggalKunjungan := DateToStr(Trunc(TglRegister));
  if Trunc(TglRegister) = Date then
  begin
    dtTglPelayanan.Date := TglRegister;

    bpjs := TBpjs.Create;
    try
      KodeRS  := bpjs.KodeRs;

      memResponse.Text := bpjs.cekPeserta(NoBPJS, FormatDateTime('yyyy-mm-dd', TglRegister));
      jPeserta := TJSONObject.Create;
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
        memResponse.Text := bpjs.HistoriSEP(NoBPJS);

        jSep := TJSONObject.Create;
        jSep := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
        SepArr := jSep.GetValue('histori') as TJSONArray;
        jSepItem := SepArr.Get(0) as TJSONObject;
      except

      end;


      try
//        memResponse.Text := bpjs.cekSurkonbyNoka(NoBPJS);
//
//        jSurkon := TJSONObject.Create;
//        jSurkon := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
//        jsa := jSurkon.GetValue('list') as TJSONArray;
//
//        jso := TJSONObject.Create;
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
        jSurkon := TJSONObject.Create;
        jSurkon := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
        edNoSurkon.Text := jSurkon.GetValue<string>('noSuratKontrol');
        KodeDPJP := jSurkon.GetValue<string>('kodeDokterPembuat');

        if jSurkon.GetValue<string>('sep.jnsPelayanan') = 'Rawat Inap' then
        begin
          edNoRujukan.Text := jSurkon.GetValue<string>('sep.noSep');
          jenisKunjungan := jkPostMRS;
        end else
        begin
          jenisKunjungan := jkKontrol;
        end;
      except
        jenisKunjungan := jkRujukanBaru;
      end;

      memResponse.Text := bpjs.cekRujukan(NoBPJS);
      jRujukan := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
      edNoRujukan.Text := jRujukan.GetValue<string>('rujukan.noKunjungan');

    finally
      jPeserta.Free;
      bpjs.Free;
    end;

    pgUtama.ActivePageIndex := 1;
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
    SendKeysToHandle(finger, edNIKKtp.Text);
  end;

  btDone.Visible := true;

end;

procedure TfrmMain.btFristaClick(Sender: TObject);
var
  dimana : HWND;
  s : string;
begin
//  if not IsProcessRunning(FRISTA_PROCESS) then
//  begin
//    RunFrista;
//    btDone.Visible := true;
//    Exit;
//  end;

  dimana := FindFristaWindow;

  if dimana <> 0 then
  begin
    ShowWindow(dimana, SW_RESTORE);
    SetForegroundWindow(dimana);
    SendKeysToHandle(dimana, edNIKKtp.Text);
  end;

  btDone.Visible := true;

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
      rujukan.AddPair('asalRujukan', AsalRujukan);
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

//    ShowMessage(jenisKunjungan.ToCaption);
//    memResponse.Lines.Add(sss);

    {Buat SEP}
    memResponse.Text := bpjs.CreateSEP(memRequest.Text);
    jSep := TJSONObject.ParseJSONValue(memResponse.Text) as TJSONObject;
    {mandatory}
    NoSEP := jSep.GetValue<string>('sep.noSep');
//    lbNoSep.Caption := jSep.GetValue<string>('sep.noSep');

    SyncSEP(NoSEP, jenisKunjungan.ToCaption);
    lbNotif.Caption := 'SEP terbit dengan nomor '+ NoSEP;
    WarnaLabel('SUKSES');
    TransaksiPDR;
    CetakNoAntri;

  finally
    ClearParameterValue;
    bpjs.Free;
  end;

  pgUtama.ActivePageIndex := 0;

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
end;

procedure TfrmMain.FormShow(Sender: TObject);
var fpath : string;
begin
  fpath := ExtractFilePath(Application.ExeName);
//  ShowMessage(fpath);

  dm.koneksi.Close;
  dm.koneksi.Provider:=fpath+'koneksi.udl';
  dm.koneksi.ConnectionString:='FILE NAME='+fpath+'koneksi.udl';
  dm.koneksi.Open;
  dm.koneksi.Connected:=true;

  pgUtama.HideTabs:= true;
  pgUtama.ActivePageIndex := 0;
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
  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'exec pr_BuatKodeTransaksiRi :JenisTransaksi';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('JenisTransaksi').Value := 'PRJ';
  dm.qTemp.Open;
  KodeTransaksiPenghasilan := dm.qTemp.Fields[0].AsString;

//insert transaksi pengahasilan
  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'exec pr_InsertTransaksiPenghasilan :KodeTransaksiPenghasilan , '+
            ':KodeUser ,:KodeJenisTransBayar ,:IdRegister ,:KodeSo ,:StatusValidasi , '+
            ':StatusBayar ,:TanggalTransaksi,:TanggalBayar,:NoBuktiPendukung,:PPNKeluaran, '+
            ':TotalBayar,:IsResep,:RefJurnal,:DP,:WaktuPesan, :WaktuAmbil, :Voucher, :Status, '+
            ':KodeMeja, :KodeKategoriCustomer, :KodeKaryawan, :IdRuang,:KodeMedTrans, :GrupTrans, ' +
            ':Poin, :TotalBruto, :TglEdPoin, :IdPosTransaksi';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('KodeTransaksiPenghasilan').Value := KodeTransaksiPenghasilan;
  dm.qTemp.Parameters.ParamByName('KodeUser').Value            := 'mobilejkn';
  dm.qTemp.Parameters.ParamByName('KodeJenisTransBayar').Value := 'PRJ2902';
  dm.qTemp.Parameters.ParamByName('IdRegister').Value          := IdRegister;
  dm.qTemp.Parameters.ParamByName('KodeSo').Value              := '1112100';
  dm.qTemp.Parameters.ParamByName('StatusValidasi').Value      := 0;
  dm.qTemp.Parameters.ParamByName('StatusBayar').Value         := 0;
  dm.qTemp.Parameters.ParamByName('TanggalTransaksi').Value    := DateTimeToStr(Now);
  dm.qTemp.Parameters.ParamByName('TanggalBayar').Value        := Null;
  dm.qTemp.Parameters.ParamByName('NoBuktiPendukung').Value   := Null;
  dm.qTemp.Parameters.ParamByName('PPNKeluaran').Value  := null;
  dm.qTemp.Parameters.ParamByName('TotalBayar').Value   := 50000;
  dm.qTemp.Parameters.ParamByName('IsResep').Value    := 0;
  dm.qTemp.Parameters.ParamByName('RefJurnal').Value  := Null;
  dm.qTemp.Parameters.ParamByName('DP').Value         := Null;
  dm.qTemp.Parameters.ParamByName('WaktuPesan').Value := Null;
  dm.qTemp.Parameters.ParamByName('WaktuAmbil').Value := Null;
  dm.qTemp.Parameters.ParamByName('Voucher').Value    := Null;
  dm.qTemp.Parameters.ParamByName('Status').Value       := Null;
  dm.qTemp.Parameters.ParamByName('KodeMeja').Value     := Null;
  dm.qTemp.Parameters.ParamByName('KodeKategoriCustomer').Value := Null;
  dm.qTemp.Parameters.ParamByName('KodeKaryawan').Value :=  Null;
  dm.qTemp.Parameters.ParamByName('IdRuang').Value      := IdRuang ;
  dm.qTemp.Parameters.ParamByName('KodeMedTrans').Value := KodeDokter ;
  dm.qTemp.Parameters.ParamByName('GrupTrans').Value    := 'RJ';
  dm.qTemp.Parameters.ParamByName('Poin').Value       := 0;
  dm.qTemp.Parameters.ParamByName('TotalBruto').Value := 50000;
  dm.qTemp.Parameters.ParamByName('TglEdPoin').Value  := Null;
  dm.qTemp.Parameters.ParamByName('IdPosTransaksi').Value := 3;
  dm.qTemp.ExecSQL;

//insert detail transaksi penghasilan
  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'exec pr_InsertDetailTransaksiPenghasilanRi ' +
                       ':KodeTransaksiPenghasilan , :KodeTarif , :KodeKaryawan , ' +
                       ':KdBarang , :JumlahTransaksi , :HargaJual , :Diskon , ' +
                       ':IdGudang , :HargaRata';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('KodeTransaksiPenghasilan').Value := KodeTransaksiPenghasilan;
  dm.qTemp.Parameters.ParamByName('KodeTarif').Value    := 'RJAPO0000000004'; //PDR Spesialis
  dm.qTemp.Parameters.ParamByName('KodeKaryawan').Value := KodeDokter;
  dm.qTemp.Parameters.ParamByName('KdBarang').Value     := null;
  dm.qTemp.Parameters.ParamByName('JumlahTransaksi').Value := 1;
  dm.qTemp.Parameters.ParamByName('HargaJual').Value    := 50000;
  dm.qTemp.Parameters.ParamByName('Diskon').Value       := 0;  // Pasien Kerjasama
  dm.qTemp.Parameters.ParamByName('IdGudang').Value     := null;
  dm.qTemp.Parameters.ParamByName('HargaRata').Value    := 0;
  dm.qTemp.ExecSQL;

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
begin
// ----- cari nomer sep di vclaim ------------
  try
    Bpjs := TBpjs.Create;
    res := Bpjs.CariSEP(ANoSep);
    sep := TJSONObject.ParseJSONValue(res) as TJSONValue;
    noKartu := sep.GetValue<string>('peserta.noKartu');
    noRujukan := sep.GetValue<string>('noRujukan');

    res := Bpjs.CekRujukan(noRujukan);
    rujukan := TJSONObject.ParseJSONValue(res) as TJSONValue;

    if sep.GetValue<string>('jnsPelayanan') = 'Rawat Jalan' then
    begin
      jenpel := 'R.Jalan';
    end else
    begin
      jenpel := 'R.Inap';
    end;

    res := Bpjs.cariSEPkontrol(ANoSep);
    sepKontrol := TJSONObject.ParseJSONValue(res) as TJSONValue;

    res := Bpjs.cekPeserta(noKartu, FormatDateTime('yyyy-MM-dd', Now));
    peserta:= TJSONObject.ParseJSONValue(res) as TJSONValue;
  finally
    Bpjs.Free;
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
    ShowMessage('No SEP sudah digunakan '+ dm.qTemp.FieldValues['NAMAPESERTA']);
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
