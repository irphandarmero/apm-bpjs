program apmBpjs;

uses
  Vcl.Forms,
  FrmMain_u in 'FrmMain_u.pas' {frmMain},
  Dm_u in 'Dm_u.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
