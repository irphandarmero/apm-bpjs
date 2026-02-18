unit Dm_u;

interface

uses
  System.SysUtils, System.Classes, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Data.DB, Data.Win.ADODB, System.Hash, System.JSON,
  System.NetEncoding, System.DateUtils, Winapi.Windows, MemDS, VirtualTable,
  frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF, frxADOComponents,
  frxBarcode;

type
  Tdm = class(TDataModule)
    koneksi: TADOConnection;
    qTemp: TADOQuery;
    vDokter: TVirtualTable;
    vPoli: TVirtualTable;
    ReportPrint: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    vTemp: TVirtualTable;
    frdbTemp: TfrxDBDataset;
    vExData: TVirtualTable;
    frxDbExData: TfrxDBDataset;
    dsExData: TDataSource;
    frxADOComponents1: TfrxADOComponents;
    frxBarCodeObject1: TfrxBarCodeObject;
  private
    { Private declarations }
  public
    procedure LoadDokter(AKodeKaryawan : string);
    procedure LoadPoli(AIdRuang : integer);

    function SambungKoneksi : Boolean;
    function Get_Hari(ATanggal : TDateTime):string;
    function StringToDateTime(const Value: String): TDateTime;
    { Public declarations }
  end;

  TBpjs = class
    http : TNetHTTPClient;
    res  : IHTTPResponse;

    private
      FBaseUrl  : string;
      FConsID   : string;
      FSecretKey: string;
      FKodeRs   : string;
      FUserKey  : string;
      FTimeStamp: string;
      FSignature: string;
      FEnvironment : string;

      function CreateSignature(): string;
      function Decrypt(AKey: string; AText : string):string;
    public
      property BaseUrl : string read FBaseUrl write FBaseUrl;
      property ConsID : string read FConsID write FConsID;
      property SecretKey : string read FSecretKey write FSecretKey;
      property UserKey : string read FUserKey write FUserKey;
      property KodeRs : string read FKodeRs write FKodeRs;
      property Signature : string read FSignature write FSignature;
      property TimeStamp : string read FTimeStamp write FTimeStamp;
      property Environment : string read FEnvironment write FEnvironment;

      constructor Create;


      function CariNoSuratKontrol(NoSurkon : string): string;
      function CariSEP(NoSep : string) : string;
      function CariSEPkontrol(NoSEP: string): string;
      function CekPeserta(NoKartu: string; tgl :string): string;

      function CekRujukan(ANoRujukan : string): string;
      function CekSurkonbyNoka(ANoKartu : string) : string;

      function CreateSEP(AData : string): string;
      procedure CetakSEP(NoSep : string ;  desain :boolean);

      function HistoriSEP(ANoKartu : string): string;

  end;
  TAntrol = class(TDataModule)
    res  : IHTTPResponse;
    http : TNetHTTPClient;

    private
      FBaseUrl  : string;
      FConsID   : string;
      FSecretKey: string;
      FKodeRs   : string;
      FUserKey  : string;
      FTimeStamp: string;
      FSignature: string;

      function CreateSignature(): string;
    public
      property BaseUrl : string read FBaseUrl write FBaseUrl;
      property ConsID : string read FConsID write FConsID;
      property SecretKey : string read FSecretKey write FSecretKey;
      property UserKey : string read FUserKey write FUserKey;
      property KodeRs : string read FKodeRs write FKodeRs;
      property Signature : string read FSignature write FSignature;
      property TimeStamp : string read FTimeStamp write FTimeStamp;

      constructor Create;
      function TambahAntrean(AData : string): string;
  end;
var
  dm: Tdm;
  bpjs : TBpjs;
  antrol : TAntrol;
  CONST LzString  = 'http://192.168.1.125/lzstring/Decompress.php?';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function NowUTC: TDateTime;
var
  system_datetime: TSystemTime;
begin
  GetSystemTime(system_datetime);
  Result := SystemTimeToDateTime(system_datetime);
end;
function Tdm.StringToDateTime(const Value: String): TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  GetLocaleFormatSettings(LOCALE_USER_DEFAULT, FormatSettings);
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy/mm/dd hh:nn:ss';
  Result := StrToDateTime(Value, FormatSettings);
end;
function Tdm.Get_Hari(ATanggal : TDateTime):string;
begin
  try
    qTemp.Close;
    qTemp.SQL.Clear;
    qTemp.SQL.Text := 'exec Pr_WScariHari :tanggal';
    qTemp.Prepared;
    qTemp.Parameters.ParamByName('tanggal').Value := FormatDateTime('yyyy-mm-dd', ATanggal);
    qTemp.Open;
  except

  end;

  Result := dm.qtemp.FieldValues['hari'];
end;
function Tdm.SambungKoneksi: Boolean;
var I : integer;
begin
  Result := False;

  if koneksi.Connected then
    Exit(True);

  for I := 1 to 3 do
    begin
      try
        koneksi.Connected := True;
        Exit(True);
      except
        Sleep(1000);
      end;
    end;
end;

procedure Tdm.LoadDokter(AKodeKaryawan: string);
begin
  qTemp.Close;
  qTemp.SQL.Clear;
  qTemp.SQL.Text := 'SELECT k.KodeKaryawan, k.Nama, mdi.KdDokterMapping FROM Karyawan k ' +
                    'INNER JOIN Map_Dokter_Instansi mdi ON mdi.KodeKaryawan = k.KodeKaryawan ' +
                    'AND mdi.IdInstansi = 154 AND mdi.IsAktif=1 ' +
                    'WHERE k.KodeKaryawan = :kode';
  qTemp.Prepared;
  qTemp.Parameters.ParamByName('kode').Value := AKodeKaryawan;
  qTemp.Open;

  vDokter.Active := true;
  vDokter.Assign(qTemp);
end;

procedure Tdm.LoadPoli(AIdRuang: integer);
begin
  qTemp.Close;
  qTemp.SQL.Clear;
  qTemp.SQL.Text := 'SELECT r.IdRuang , r.Nama, mri.KdRuangInstansi FROM Ruang r ' +
                    'INNER JOIN Map_Ruang_Instansi mri ON mri.IdRuang = r.IdRuang ' +
                    'AND mri.IdInstansi = 154 ' +
                    'WHERE r.IdRuang = :IdRuang ';
  qTemp.Prepared;
  qTemp.Parameters.ParamByName('IdRuang').Value := AIdRuang;
  qTemp.Open;

  vPoli.Active := True;
  vPoli.Assign(qTemp);
end;
//========================
constructor TBpjs.Create;
begin

  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'SELECT * FROM tb_url_api ' +
                       'WHERE namaKerjasama = :nama ' +
                       'AND type = :tipe ' +
                       'AND isAktif = 1 ';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('nama').Value := 'BPJS';
  dm.qTemp.Parameters.ParamByName('tipe').Value := 'PRODUCTION';
  dm.qTemp.Open;

  BaseUrl := dm.qTemp.FieldValues['URL'];
  UserKey := dm.qTemp.FieldValues['userKey_token'];
  ConsID := dm.qTemp.FieldValues['consID'];
  SecretKey := dm.qTemp.FieldValues['secretKey'];
  KodeRs  := dm.qTemp.FieldValues['username'];

  dm.qTemp.Close;

end;
function TBpjs.CreateSignature(): string;
var LBytes : TBytes;
    Sign : string;
begin
  LBytes := THashSHA2.GetHMACAsBytes(ConsID +'&'+ TimeStamp , SecretKey , SHA256);
  LBytes := TNetEncoding.Base64.Encode(LBytes);
  Sign := TEncoding.Default.GetString(LBytes);

  Result := Sign;
end;

function TBpjs.CariNoSuratKontrol(NoSurkon: string) : string;
var jsv : TJSONValue;
    sss : string;
begin

  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    res := http.Get(BaseUrl + 'RencanaKontrol/noSuratKontrol/' + NoSurkon);
    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;

  finally
    jsv.Free;
  end;
  Result :=  sss;

end;
function TBpjs.Decrypt(AKey: string; AText : string):string;
var sss : string;
    key : string;
    URL : string;
    res : IHTTPResponse;
begin
  sss := AText;
  Key := AKey;
  URL := LzString+'key='+Key+'&string='+ sss;
  http.ContentType := 'application/json; charset=utf-8';
  res := http.Get(URL);
  sss := res.ContentAsString;
  result := sss;
end;
function TBpjs.CariSEP(NoSep: string) : string;
var jsv : TJSONValue;
    sss : string;
begin
  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    res := http.Get(BaseUrl + 'SEP/' + NoSep);
    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;

  finally
    jsv.Free;
  end;
  Result :=  sss;
end;
function TBpjs.CariSEPkontrol(NoSEP: string):string;
var jsv : TJSONValue;
    sss : string;
begin
  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    res := http.Get(BaseUrl + 'RencanaKontrol/nosep/' + NoSep);
    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;

  finally
    jsv.Free;
  end;
  Result :=  sss;
end;
function TBpjs.CekPeserta(NoKartu: string; tgl :string): string;
var sss : string;
    jsv : TJSONValue;
    now : string;
begin
  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    res := http.Get(BaseUrl + 'Peserta/nokartu/'+NoKartu+'/tglSEP/'+tgl);
    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;
  finally
    jsv.Free;
  end;
  Result := sss;
end;

function TBpjs.CekRujukan(ANoRujukan: string): string;
var sss : string;
    jsv : TJSONValue;
begin
  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    if Length(ANoRujukan) < 19 then
    begin
      res := http.Get(BaseUrl+ 'Rujukan/Peserta/'+ ANoRujukan{parameter}) //ini pakai nomer kartu bpjs
    end else
    begin
      res := http.Get(BaseUrl + 'Rujukan/'+ ANoRujukan {parameter});
    end;
    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;
  finally
    jsv.Free;
  end;
  Result := sss;
end;

function TBpjs.CekSurkonbyNoka(ANoKartu: string) : string;
var sss : string;
    jsv : TJSONValue;
begin
  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    res := http.Get(BaseUrl + 'RencanaKontrol/ListRencanaKontrol/Bulan/'+ FormatDateTime('mm', Now) +
                    '/Tahun/'+FormatDateTime('yyyy', Now) +
                    '/Nokartu/'+ ANoKartu +'/filter/2');

    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;
  finally
    jsv.Free;
  end;
  Result := sss;
end;
function TBpjs.CreateSEP(AData: string): string;
var req : TStringStream;
    jsv : TJSONValue;
    sss : string;
begin
  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    req := TStringStream.Create(AData , TEncoding.UTF8);

    res := http.Post(BaseUrl+'SEP/2.0/insert', req );
    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;
  finally
    jsv.Free;
  end;
  Result := sss;
end;
function TBpjs.HistoriSEP(ANoKartu: string) : string;
var sss : string;
    jsv : TJSONValue;
begin
  http := TNetHTTPClient.Create(nil);
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    res := http.Get(BaseUrl + 'monitoring/HistoriPelayanan/NoKartu/'+ ANoKartu +
                    '/tglMulai/'+ FormatDateTime('yyyy-mm-dd', Now -30) +
                    '/tglAkhir/'+FormatDateTime('yyyy-mm-dd', Now));

    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
    if jsv.GetValue<integer>('metaData.code') = 200 then
    begin
      sss := jsv.GetValue<string>('response');
      sss := Decrypt(ConsID+SecretKey+TimeStamp, sss);
    end else
    begin
      sss := jsv.GetValue<string>('metaData.message');
    end;
  finally
    jsv.Free;
  end;
  Result := sss;

end;
procedure TBpjs.CetakSEP(NoSep: string ; desain : boolean);
var sep , rujukan, peserta, sepKontrol: TJSONValue;
    sss , noRujukan, noKartu : string;
begin
  sss := CariSEP(NoSep);
  sep := TJSONObject.ParseJSONValue(sss) as TJSONValue;

  sss := cariSEPkontrol(NoSep);
  sepKontrol := TJSONObject.ParseJSONValue(sss) as TJSONValue;

//  noRujukan := sep.GetValue<string>('noRujukan');
  noKartu := sep.GetValue<string>('peserta.noKartu');

//  sss := CariRujukan(noRujukan);
//  rujukan := TJSONObject.ParseJSONValue(sss) as TJSONValue;
//
  sss := cekPeserta(noKartu, FormatDateTime('yyyy-mm-dd', Now));
  peserta := TJSONObject.ParseJSONValue(sss) as TJSONValue;


  {noSep
  tglSep
  noKartu
  noMr
  namaPeserta
  tgllahir
  jenisKelamin
  noTelp
  poli
  dpjp
  faskesPerujuk
  kdDiagnosa
  nmDiagnosa
  catatan
  jnsPeserta
  jnsRawat
  jnsKunjungan
  assesmen
  poliPerujuk
  kelasHak
  kelasRawat
  penjamin}

  dm.frdbTemp.UserName := 'SEP';
  dm.vTemp.Active := True;
  dm.vTemp.DeleteFields;
  dm.vTemp.AddField('noSep', ftString, 20);
  dm.vTemp.AddField('tglSep', ftString, 20);
  dm.vTemp.AddField('noKartu', ftString, 20);
  dm.vTemp.AddField('noMr', ftString, 20);
  dm.vTemp.AddField('namaPeserta', ftString, 100);
  dm.vTemp.AddField('tglLahir', ftString, 20);
  dm.vTemp.AddField('jenisKelamin', ftString, 20);
  dm.vTemp.AddField('noTelp', ftString, 20);
  dm.vTemp.AddField('poli', ftString, 100);
  dm.vTemp.AddField('dpjp', ftString, 50);
  dm.vTemp.AddField('faskesPerujuk', ftString, 250);
//  DM.cdsTemp.AddField('kdDiagnosa', ftString, 10);
  dm.vTemp.AddField('nmDiagnosa', ftString, 250);
  dm.vTemp.AddField('Catatan', ftString, 50);
  dm.vTemp.AddField('jnsPeserta', ftString, 20);
  dm.vTemp.AddField('jnsRawat', ftString, 50);
  dm.vTemp.AddField('jnsKunjungan', ftString, 50);
  dm.vTemp.AddField('assesmen', ftString, 50);
  dm.vTemp.AddField('prosedur', ftString, 50);
  dm.vTemp.AddField('poliPerujuk', ftString, 20);
  dm.vTemp.AddField('kelasHak', ftString, 50);
  dm.vTemp.AddField('kelasRawat', ftString, 50);
  dm.vTemp.AddField('penjamin', ftString, 50);
  dm.vTemp.AddField('prolanisPrb', ftString, 50);

//  if tipe = 'RAWATJALAN' then
//  begin
    dm.vTemp.Append;
    dm.vTemp.FieldByName('noSep').Value         := sep.GetValue<string>('noSep');
    dm.vTemp.FieldByName('tglSep').Value        := sep.GetValue<string>('tglSep');
    dm.vTemp.FieldByName('noKartu').Value       := sep.GetValue<string>('peserta.noKartu');
    dm.vTemp.FieldByName('noMr').Value          := sep.GetValue<string>('peserta.noMr');
    dm.vTemp.FieldByName('namaPeserta').Value   := sep.GetValue<string>('peserta.nama');
    dm.vTemp.FieldByName('tglLahir').Value      := sep.GetValue<string>('peserta.tglLahir');
    if sep.GetValue<string>('peserta.kelamin') = 'L' then
      dm.vTemp.FieldByName('jenisKelamin').Value  := 'Laki laki' else
      dm.vTemp.FieldByName('jenisKelamin').Value  := 'Perempuan';
    dm.vTemp.FieldByName('noTelp').Value        := peserta.GetValue<string>('peserta.mr.noTelepon');
    dm.vTemp.FieldByName('poli').Value          := sepKontrol.GetValue<string>('poli');

    dm.vTemp.FieldByName('faskesPerujuk').Value := sepKontrol.GetValue<string>('provPerujuk.nmProviderPerujuk');
//    DM.cdsTemp.FieldByName('kdDiagnosa').Value    := rujukan.GetValue<string>('rujukan.diagnosa.kode');
    dm.vTemp.FieldByName('nmDiagnosa').Value    := sepKontrol.GetValue<string>('diagnosa');
    dm.vTemp.FieldByName('catatan').Value       := sep.GetValue<string>('catatan');
    dm.vTemp.FieldByName('jnsPeserta').Value    := sep.GetValue<string>('peserta.jnsPeserta');
    dm.vTemp.FieldByName('jnsRawat').Value      := sep.GetValue<string>('jnsPelayanan');
    if sep.GetValue<string>('tujuanKunj.kode') = '0' then
      begin
        dm.vTemp.FieldByName('jnsKunjungan').Value := 'Konsultasi dokter (Pertama)';
        dm.vTemp.FieldByName('dpjp').Value := sep.GetValue<string>('dpjp.nmDPJP');
      end else
      if sep.GetValue<string>('tujuanKunj.kode') = '1' then
      begin
        dm.vTemp.FieldByName('jnsKunjungan').Value := 'Prosedur Lanjutan';
        dm.vTemp.FieldByName('dpjp').Value          := sep.GetValue<string>('kontrol.nmDokter');
      end else
      begin
        dm.vTemp.FieldByName('jnsKunjungan').Value := 'Kunjungan Kontrol (ulangan)';
        dm.vTemp.FieldByName('dpjp').Value          := sep.GetValue<string>('kontrol.nmDokter');
      end;
  //  DM.cdsTemp.FieldByName('jnsKunjungan').Value  := sep.GetValue<string>('tujuanKunj.nama');
    dm.vTemp.FieldByName('assesmen').Value      := sep.GetValue<string>('assestmenPel.nama');
    dm.vTemp.FieldByName('prosedur').Value      := sep.GetValue<string>('flagProcedure.nama');
    dm.vTemp.FieldByName('poliPerujuk').Value   := '-'; //sep.GetValue<string>('n');
    dm.vTemp.FieldByName('kelasHak').Value      := sep.GetValue<string>('peserta.hakKelas');
    if sep.GetValue<string>('jnsPelayanan') = 'Rawat Jalan' then
    begin
      dm.vTemp.FieldByName('kelasRawat').Value  := '-';
    end else
    begin
      dm.vTemp.FieldByName('kelasRawat').Value  := sep.GetValue<string>('kelasRawat');
    end;
    dm.vTemp.FieldByName('penjamin').Value      := sep.GetValue<string>('penjamin');
    dm.vTemp.FieldByName('prolanisPrb').Value   := peserta.GetValue<string>('peserta.informasi.prolanisPRB');
    dm.vTemp.Post;

//  DM.ReportPrint.LoadFromFile(DM.vSeting.FieldByName('fpath').AsString+'Reports\'+'Cetak SEP 2.fr3');

  DM.frxPDFExport1.FileName := dm.vTemp.FieldByName('noSep').Value;
  DM.frxPDFExport1.Author := 'RS Yasmin Banyuwangi';
  DM.frxPDFExport1.Compressed:=true;
  DM.frxPDFExport1.EmbeddedFonts:=false;
  if desain = True then
    DM.ReportPrint.DesignReport else
    DM.ReportPrint.ShowReport;
end;

constructor TAntrol.Create;
begin

  dm.qTemp.Close;
  dm.qTemp.SQL.Clear;
  dm.qTemp.SQL.Text := 'SELECT * FROM tb_url_api ' +
                       'WHERE namaKerjasama = :nama ' +
                       'AND type = :tipe ' +
                       'AND isAktif = 1 ';
  dm.qTemp.Prepared;
  dm.qTemp.Parameters.ParamByName('nama').Value := 'ANTROL BPJS';
  dm.qTemp.Parameters.ParamByName('tipe').Value := 'PRODUCTION';
  dm.qTemp.Open;

  BaseUrl   := dm.qTemp.FieldValues['URL'];
  UserKey   := dm.qTemp.FieldValues['userKey_token'];
  ConsID    := dm.qTemp.FieldValues['consID'];
  SecretKey := dm.qTemp.FieldValues['secretKey'];

  DM.qtemp.Close;

end;
function TAntrol.CreateSignature(): string;
var LBytes : TBytes;
    Sign : string;
begin
  LBytes := THashSHA2.GetHMACAsBytes(ConsID +'&'+ TimeStamp , SecretKey , SHA256);
  LBytes := TNetEncoding.Base64.Encode(LBytes);
  Sign := TEncoding.Default.GetString(LBytes);

  Result := Sign;
end;
function TAntrol.TambahAntrean(AData: string) : string;
var jsv : TJSONValue;
    sss : string;
    str : TstringStream;
begin
  TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
  Signature := CreateSignature;
  str := TStringStream.Create(AData,TEncoding.UTF8);

  http := TNetHTTPClient.Create(nil);
  try
    http.CustomHeaders['X-cons-id'] := ConsID;
    http.CustomHeaders['X-timestamp'] := TimeStamp;
    http.CustomHeaders['X-signature'] := Signature;
    http.CustomHeaders['Content-Type'] := 'Application/x-www-form-urlencoded';

    res := http.Post(BaseUrl + 'antrean/add', str);
//    jsv := TJSONObject.ParseJSONValue(res.ContentAsString);
//    if jsv.GetValue<integer>('metaData.code') = 200 then
//    begin
//      sss := jsv.GetValue<string>('response');
//      sss := dm_Api.Decrypt(ConsID+SecretKey+TimeStamp, sss);
//    end else
//    begin
//      sss := jsv.GetValue<string>('metaData.message');
//    end;

  finally
    jsv.Free;
  end;
  Result :=  res.ContentAsString;


end;

end.                        
