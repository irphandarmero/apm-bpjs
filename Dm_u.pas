unit Dm_u;

interface

uses
  System.SysUtils, System.Classes, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Data.DB, Data.Win.ADODB, System.Hash, System.JSON,
  System.NetEncoding, System.DateUtils, Winapi.Windows;

type
  Tdm = class(TDataModule)
    koneksi: TADOConnection;
    qTemp: TADOQuery;
  private
    { Private declarations }
  public
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

constructor TBpjs.Create;
begin

  dm.qtemp.Close;
  dm.qtemp.SQL.Clear;
  dm.qtemp.SQL.Text := 'SELECT * FROM tb_url_api ' +
                       'WHERE namaKerjasama = :nama ' +
                       'AND type = :tipe ' +
                       'AND isAktif = 1 ';
  dm.qtemp.Prepared;
  dm.qtemp.Parameters.ParamByName('nama').Value := 'BPJS';
  dm.qtemp.Parameters.ParamByName('tipe').Value := 'PRODUCTION';
  dm.qtemp.Open;

  BaseUrl := DM.qtemp.FieldValues['URL'];
  UserKey := DM.qtemp.FieldValues['userKey_token'];
  ConsID := DM.qtemp.FieldValues['consID'];
  SecretKey := DM.qtemp.FieldValues['secretKey'];

  dm.qtemp.Close;

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

end.
