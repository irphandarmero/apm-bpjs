object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Pembuatan SEP'
  ClientHeight = 768
  ClientWidth = 1280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 37
  object edNoSurkon: TcxTextEdit
    Left = 448
    Top = 240
    TabOrder = 0
    TextHint = 'Nomor Surat Kontrol'
    Width = 417
  end
  object edNamaDokter: TcxTextEdit
    Left = 448
    Top = 299
    TabOrder = 1
    TextHint = 'Nama Dokter'
    Width = 417
  end
  object edNamaPoli: TcxTextEdit
    Left = 448
    Top = 358
    TabOrder = 2
    TextHint = 'Nama Poli'
    Width = 417
  end
  object cxDateEdit1: TcxDateEdit
    Left = 448
    Top = 173
    TabOrder = 3
    Width = 305
  end
  object cxLabel1: TcxLabel
    Left = 184
    Top = 174
    Caption = 'Tanggal Pelayanan'
  end
  object cxLabel2: TcxLabel
    Left = 184
    Top = 241
    Caption = 'Nomor Surat Kontrol'
  end
  object cxLabel3: TcxLabel
    Left = 184
    Top = 300
    Caption = 'Dokter DPJP'
  end
  object cxLabel4: TcxLabel
    Left = 184
    Top = 359
    Caption = 'Nama Poli'
  end
end
