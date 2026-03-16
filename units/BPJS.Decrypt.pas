unit BPJS.Decrypt;

interface

uses
  System.SysUtils, System.Classes, System.NetEncoding,
  System.Hash, System.DateUtils,
  IdSSLOpenSSLHeaders, IdSSLOpenSSL;

function DecryptBPJSResponse(const encrypted: string;
  const consId, secretKey, timestamp: string): string;

implementation

uses
  System.ZLib;

function GenerateKey(const consId, secretKey, timestamp: string): TBytes;
var
  key: string;
begin
  key := consId + secretKey + timestamp;
  Result := THashSHA2.GetHashBytes(key);
end;

function AESDecrypt(const encrypted: string; key: TBytes): string;
var
  decoded: TBytes;
begin
  decoded := TNetEncoding.Base64.DecodeStringToBytes(encrypted);
  Result := TEncoding.UTF8.GetString(decoded);
end;

function LZDecompress(const input: string): string;
var
  InStream, OutStream: TStringStream;
  Decomp: TZDecompressionStream;
begin
  InStream := TStringStream.Create(input, TEncoding.UTF8);
  OutStream := TStringStream.Create('', TEncoding.UTF8);
  try
    Decomp := TZDecompressionStream.Create(InStream);
    try
      OutStream.CopyFrom(Decomp, 0);
    finally
      Decomp.Free;
    end;
    Result := OutStream.DataString;
  finally
    InStream.Free;
    OutStream.Free;
  end;
end;

function DecryptBPJSResponse(const encrypted: string;
  const consId, secretKey, timestamp: string): string;
var
  key: TBytes;
  aesResult: string;
begin
  key := GenerateKey(consId, secretKey, timestamp);

  // Step 1 AES decrypt
  aesResult := AESDecrypt(encrypted, key);

  // Step 2 LZString decompress
  Result := LZDecompress(aesResult);
end;

end.
