unit Bpjs_U;

interface

uses
  System.SysUtils, System.JSON, System.Net.HttpClient,
  System.NetEncoding, System.Hash, System.DateUtils,
  Winapi.Windows, System.Net.HttpClientComponent, System.Classes;

type
  TBpjs = class
  private
    FBaseUrl  : string;
    FConsID   : string;
    FSecretKey: string;
    FUserKey  : string;

    function NowUTC: TDateTime;
    function CreateSignature(const ATimestamp: string): string;
    function Decrypt(const AKey, AText: string): string;
    function ExecuteGet(const AUrl: string): string;
    function ExecutePost(const AUrl, AJson: string): string;
  public
    constructor Create(const ABaseUrl, AConsID, ASecretKey, AUserKey: string);
    function CariSEP(const NoSep: string): string;
    function CekPeserta(const NoKartu, Tgl: string): string;
    function CekRujukan(const NoRujukan: string): string;
    function CariNoSuratKontrol(const NoSurkon: string): string;
    function CreateSEP(const AJson: string): string;
    function CariSepKontrol(const NoSep: string): string;
    function GetRiwayatSEP(const NoKartu: string): string;
    function CekRujukanFaskes2(const NoRujukan: string): string;
  end;

implementation

constructor TBpjs.Create(const ABaseUrl, AConsID, ASecretKey, AUserKey: string);
begin
  FBaseUrl   := ABaseUrl;
  FConsID    := AConsID;
  FSecretKey := ASecretKey;
  FUserKey   := AUserKey;
end;

function TBpjs.NowUTC: TDateTime;
var ST: TSystemTime;
begin
  GetSystemTime(ST);
  Result := SystemTimeToDateTime(ST);
end;

function TBpjs.CreateSignature(const ATimestamp: string): string;
var Bytes: TBytes;
begin
  Bytes := THashSHA2.GetHMACAsBytes(
              FConsID + '&' + ATimestamp,
              FSecretKey,
              SHA256);
  Result := TNetEncoding.Base64.EncodeBytesToString(Bytes);
end;

function TBpjs.Decrypt(const AKey, AText: string): string;
var Client: TNetHttpClient;
    Resp  : IHTTPResponse;
begin
  Client := TNetHTTPClient.Create(nil);
  try
    Resp := Client.Get(
      'http://192.168.1.125/lzstring/Decompress.php?key=' +
      AKey + '&string=' + AText);
    Result := Resp.ContentAsString;
  finally
    Client.Free;
  end;
end;

function TBpjs.ExecuteGet(const AUrl: string): string;
var Client: TNetHTTPClient;
    Resp  : IHTTPResponse;
    J     : TJSONValue;
    TimeStamp, Signature: string;
begin
  Client := TNetHTTPClient.Create(nil);
  try
    TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
    Signature := CreateSignature(TimeStamp);

    Client.CustomHeaders['X-cons-id'] := FConsID;
    Client.CustomHeaders['X-timestamp'] := TimeStamp;
    Client.CustomHeaders['X-signature'] := Signature;
    Client.CustomHeaders['user_key'] := FUserKey;

    Resp := Client.Get(FBaseUrl + AUrl);

    J := TJSONObject.ParseJSONValue(Resp.ContentAsString);
    if not Assigned(J) then
      Exit('Invalid JSON response');

    try
      if J.GetValue<Integer>('metaData.code') = 200 then
        Result := Decrypt(FConsID + FSecretKey + TimeStamp,
                          J.GetValue<string>('response'))
      else
        Result := J.GetValue<string>('metaData.message');
    finally
      J.Free;
    end;

  finally
    Client.Free;
  end;
end;

function TBpjs.CariSEP(const NoSep: string): string;
begin
  Result := ExecuteGet('SEP/' + NoSep);
end;

function TBpjs.CekPeserta(const NoKartu, Tgl: string): string;
begin
  Result := ExecuteGet('Peserta/nokartu/' + NoKartu + '/tglSEP/' + Tgl);
end;

function TBpjs.CekRujukan(const NoRujukan: string): string;
begin
  if Length(NoRujukan) < 19 then
    begin
      Result := ExecuteGet('Rujukan/Peserta/'+ NoRujukan{parameter}) //ini pakai nomer kartu bpjs
    end else
    begin
      Result := ExecuteGet('Rujukan/'+ NoRujukan {parameter});
    end;

end;
function TBpjs.CekRujukanFaskes2(const NoRujukan: string): string;
begin
  if Length(NoRujukan) < 19 then
    begin
      Result := ExecuteGet('Rujukan/RS/Peserta/'+ NoRujukan{parameter}) //ini pakai nomer kartu bpjs
    end else
    begin
      Result := ExecuteGet('Rujukan/RS/'+ NoRujukan {parameter});
    end;

end;
function TBpjs.CariNoSuratKontrol(const NoSurkon: string): string;
begin
  Result := ExecuteGet('RencanaKontrol/noSuratKontrol/' + NoSurkon);
end;
function TBpjs.ExecutePost(const AUrl, AJson: string): string;
var
  Client: TNetHTTPClient;
  Resp  : IHTTPResponse;
  J     : TJSONValue;
  TimeStamp, Signature: string;
  Stream: TStringStream;
begin
  Client := TNetHTTPClient.Create(nil);
  try
    TimeStamp := IntToStr(DateTimeToUnix(NowUTC));
    Signature := CreateSignature(TimeStamp);

    Client.CustomHeaders['X-cons-id'] := FConsID;
    Client.CustomHeaders['X-timestamp'] := TimeStamp;
    Client.CustomHeaders['X-signature'] := Signature;
    Client.CustomHeaders['user_key'] := FUserKey;
    Client.ContentType := 'application/x-www-form-urlencoded';

    Stream := TStringStream.Create(AJson, TEncoding.UTF8);
    try
      Resp := Client.Post(FBaseUrl + AUrl, Stream);
    finally
      Stream.Free;
    end;

    J := TJSONObject.ParseJSONValue(Resp.ContentAsString);
    if not Assigned(J) then
      Exit('Invalid JSON response');

    try
      if J.GetValue<Integer>('metaData.code') = 200 then
        Result := Decrypt(FConsID + FSecretKey + TimeStamp,
                          J.GetValue<string>('response'))
      else
        Result := J.GetValue<string>('metaData.message');
    finally
      J.Free;
    end;

  finally
    Client.Free;
  end;
end;
function TBpjs.CreateSEP(const AJson: string): string;
begin
  Result := ExecutePost('SEP/2.0/insert', AJson);
end;
function TBpjs.CariSepKontrol(const NoSep: string): string;
begin
  Result := ExecuteGet('RencanaKontrol/nosep/' + NoSep);
end;
function TBpjs.GetRiwayatSEP(const NoKartu: string): string;
begin
  Result := ExecuteGet('monitoring/HistoriPelayanan/NoKartu/'+ NoKartu +
                    '/tglMulai/'+ FormatDateTime('yyyy-mm-dd', Now -30) +
                    '/tglAkhir/'+FormatDateTime('yyyy-mm-dd', Now));
end;
end.

