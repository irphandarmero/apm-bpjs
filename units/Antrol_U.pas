unit Antrol_U;

interface
uses
  System.SysUtils, System.JSON, System.Net.HttpClient,
  System.NetEncoding, System.Hash, System.DateUtils,
  Winapi.Windows, System.Net.HttpClientComponent, System.Classes;

type
  TAntrol = class(TDataModule)
    res  : IHTTPResponse;
    http : TNetHTTPClient;
  private
    FBaseUrl  : string;
    FConsID   : string;
    FSecretKey: string;
    FUserKey  : string;

    function NowUTC: TDateTime;
    function CreateSignature(const ATimestamp: string): string;
    function ExecutePost(const AUrl, AJson: string): string;
  public
    constructor Create(const ABaseUrl, AConsID, ASecretKey, AUserKey: string);
//    function TambahAntrean(AData : string): string;
    function UpdateAntrean(const AJson : string): string;
//    function BatalAntrean(KodeBooking : string; Waktu : Int64) : string;
  end;

implementation
constructor TAntrol.Create(const ABaseUrl, AConsID, ASecretKey, AUserKey: string);
begin
  FBaseUrl   := ABaseUrl;
  FConsID    := AConsID;
  FSecretKey := ASecretKey;
  FUserKey   := AUserKey;
end;

function TAntrol.NowUTC: TDateTime;
var ST: TSystemTime;
begin
  GetSystemTime(ST);
  Result := SystemTimeToDateTime(ST);
end;

function TAntrol.CreateSignature(const ATimestamp: string): string;
var Bytes: TBytes;
begin
  Bytes := THashSHA2.GetHMACAsBytes(
              FConsID + '&' + ATimestamp,
              FSecretKey,
              SHA256);
  Result := TNetEncoding.Base64.EncodeBytesToString(Bytes);
end;
function TAntrol.ExecutePost(const AUrl, AJson: string): string;
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
//      if J.GetValue<Integer>('metadata.code') = 200 then
      Result := J.GetValue<string>('metadata.message');
    finally
      J.Free;
    end;

  finally
    Client.Free;
  end;
end;
function TAntrol.UpdateAntrean(const AJson: string): string;
begin
  Result := ExecutePost('antrean/updatewaktu', AJson);
end;
end.
