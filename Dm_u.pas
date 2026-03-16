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
    qTransaksi: TADOQuery;
  private
    { Private declarations }
  public
    procedure LoadDokter(AKodeKaryawan : string);
    procedure LoadPoli(AIdRuang : integer);

    function SambungKoneksi : Boolean;
    function Get_Hari(ATanggal : TDateTime):string;
    function StringToDateTime(const Value: String): TDateTime;

    function GetApiConfig(const ANama, ATipe: string): Boolean;
    function FieldStr(const AField: string): string;
    { Public declarations }
    var
      fpath : string;
  end;


var
  dm: Tdm;
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
function Tdm.GetApiConfig(const ANama, ATipe: string): Boolean;
begin
  qTemp.Close;
  qTemp.SQL.Text :=
    'SELECT * FROM tb_url_api ' +
    'WHERE namaKerjasama = :nama ' +
    'AND type = :tipe ' +
    'AND isAktif = 1';

  qTemp.Parameters.ParamByName('nama').Value := ANama;
  qTemp.Parameters.ParamByName('tipe').Value := ATipe;
  qTemp.Open;

  Result := not qTemp.IsEmpty;
end;

function Tdm.FieldStr(const AField: string): string;
begin
  Result := qTemp.FieldByName(AField).AsString;
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
  try
    koneksi.Close;
    koneksi.Provider:=fpath+'koneksi.udl';
    koneksi.ConnectionString:='FILE NAME='+fpath+'koneksi.udl';
    koneksi.Open;
    koneksi.Connected:=true;
  finally

  end;
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


end.
