program apmBpjs;

uses
  Vcl.Forms,
  FrmMain_u in 'FrmMain_u.pas' {frmMain},
  Dm_u in 'Dm_u.pas' {dm: TDataModule},
  sendkeys in 'units\sendkeys.pas',
  Bpjs_U in 'units\Bpjs_U.pas',
  Antrol_U in 'units\Antrol_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
