object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = 'frmLogin'
  ClientHeight = 469
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 37
  object gpLogin: TGridPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 794
    Height = 463
    Align = alClient
    ColumnCollection = <
      item
        Value = 30.000000000000000000
      end
      item
        Value = 70.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = gbIdentitas
        Row = 0
      end
      item
        Column = 0
        Control = gbQRCode
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 0
    ExplicitHeight = 394
    object gbIdentitas: TcxGroupBox
      AlignWithMargins = True
      Left = 241
      Top = 4
      Align = alClient
      Alignment = alTopCenter
      Caption = 'IDENTITAS PASIEN'
      TabOrder = 0
      ExplicitLeft = 281
      ExplicitTop = 20
      ExplicitHeight = 386
      DesignSize = (
        549
        455)
      Height = 455
      Width = 549
      object SpeedButton1: TSpeedButton
        Left = 523
        Top = 430
        Width = 23
        Height = 22
        OnClick = SpeedButton1Click
      end
      object edKodeBooking: TcxTextEdit
        Left = 96
        Top = 87
        Anchors = []
        TabOrder = 0
        TextHint = 'Insert Kode Booking'
        OnKeyDown = edKodeBookingKeyDown
        Width = 361
      end
      object cxLabel1: TcxLabel
        Left = 191
        Top = 40
        Caption = 'Kode Booking'
      end
      object btConfirm: TcxButton
        Left = 203
        Top = 395
        Width = 147
        Height = 49
        Caption = 'Konfirmasi'
        TabOrder = 2
        OnClick = btConfirmClick
      end
      object edNamaPasien: TcxTextEdit
        Left = 16
        Top = 171
        TabOrder = 3
        TextHint = 'Nama Pasien'
        Width = 521
      end
      object edTglLahir: TcxTextEdit
        Left = 16
        Top = 247
        TabOrder = 4
        TextHint = 'Tanggal Lahir'
        Width = 521
      end
      object edNoRM: TcxTextEdit
        Left = 16
        Top = 328
        TabOrder = 5
        TextHint = 'Nomor Rekam Medis'
        Width = 521
      end
      object cxLabel2: TcxLabel
        Left = 16
        Top = 146
        Caption = 'Nama Pasien'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -19
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object cxLabel3: TcxLabel
        Left = 16
        Top = 222
        Caption = 'Tanggal Lahir'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -19
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object cxLabel4: TcxLabel
        Left = 16
        Top = 303
        Caption = 'Nomor Rekam Medis'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -19
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
    end
    object gbQRCode: TcxGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Align = alClient
      TabOrder = 1
      ExplicitHeight = 386
      Height = 455
      Width = 231
      object btFrista: TcxButton
        Left = 3
        Top = 247
        Width = 225
        Height = 65
        Caption = 'Validasi Frista'
        TabOrder = 0
      end
      object btFingerprint: TcxButton
        Left = 3
        Top = 318
        Width = 225
        Height = 65
        Caption = 'Validasi Finger'
        TabOrder = 1
      end
    end
  end
end
