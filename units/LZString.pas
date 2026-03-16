unit LZString;

interface

uses
  System.SysUtils, System.Classes;

function DecompressFromEncodedURIComponent(const Input: string): string;

implementation

uses
  System.NetEncoding;

function DecompressFromEncodedURIComponent(const Input: string): string;
var
  Decoded: string;
begin
  if Input = '' then
    Exit('');

  // decode url encoded
  Decoded := TNetEncoding.URL.Decode(Input);

  // BPJS biasanya pakai base64 setelah LZ
  Result := TNetEncoding.Base64.Decode(Decoded);
end;

end.
