object dm: Tdm
  OldCreateOrder = False
  Height = 520
  Width = 769
  object koneksi: TADOConnection
    ConnectionString = 'FILE NAME=C:\Developments\apm-bpjs\Win32\Debug\koneksi.udl'
    LoginPrompt = False
    Provider = 'C:\Developments\apm-bpjs\Win32\Debug\koneksi.udl'
    Left = 640
    Top = 184
  end
  object qTemp: TADOQuery
    Connection = koneksi
    Parameters = <>
    Left = 640
    Top = 240
  end
  object vDokter: TVirtualTable
    Left = 480
    Top = 24
    Data = {04000000000000000000}
  end
  object vPoli: TVirtualTable
    Left = 480
    Top = 80
    Data = {04000000000000000000}
  end
  object ReportPrint: TfrxReport
    Version = '6.5.15'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 46052.335015844910000000
    ReportOptions.LastChange = 46052.335015844910000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 520
    Top = 376
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 520
    Top = 424
  end
  object vTemp: TVirtualTable
    Left = 480
    Top = 128
    Data = {04000000000000000000}
  end
  object frdbTemp: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 480
    Top = 184
  end
end
