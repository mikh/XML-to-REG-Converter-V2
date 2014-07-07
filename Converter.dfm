object MainForm: TMainForm
  Left = 1436
  Top = 240
  Width = 870
  Height = 627
  Caption = 'XML->REG CONVERTER 2.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object IndividualStatusLabel: TLabel
    Left = 40
    Top = 232
    Width = 3
    Height = 13
  end
  object OverallStatusLabel: TLabel
    Left = 40
    Top = 288
    Width = 3
    Height = 13
  end
  object FileBox: TListBox
    Left = 40
    Top = 24
    Width = 417
    Height = 201
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
  end
  object LogBox: TListBox
    Left = 40
    Top = 360
    Width = 777
    Height = 217
    ItemHeight = 13
    TabOrder = 1
  end
  object IndividualProgressBar: TProgressBar
    Left = 40
    Top = 256
    Width = 417
    Height = 17
    TabOrder = 2
  end
  object OverallProgressBar: TProgressBar
    Left = 40
    Top = 312
    Width = 417
    Height = 17
    TabOrder = 3
  end
  object AddFilesBtn: TButton
    Left = 480
    Top = 24
    Width = 97
    Height = 41
    Caption = 'Add Files'
    TabOrder = 4
    OnClick = AddFilesBtnClick
  end
  object AddFolderBtn: TButton
    Left = 600
    Top = 24
    Width = 97
    Height = 41
    Caption = 'Add Folder'
    TabOrder = 5
    OnClick = AddFolderBtnClick
  end
  object DeleteFilesBtn: TButton
    Left = 480
    Top = 88
    Width = 97
    Height = 41
    Caption = 'Delete Files'
    TabOrder = 6
    OnClick = DeleteFilesBtnClick
  end
  object ClearFilesBtn: TButton
    Left = 600
    Top = 88
    Width = 97
    Height = 41
    Caption = 'Clear Files'
    TabOrder = 7
    OnClick = ClearFilesBtnClick
  end
  object SettingsBtn: TButton
    Left = 480
    Top = 152
    Width = 97
    Height = 41
    Caption = 'Settings'
    TabOrder = 8
  end
  object OutputPathBtn: TButton
    Left = 600
    Top = 152
    Width = 97
    Height = 41
    Caption = 'Output Path'
    TabOrder = 9
    OnClick = OutputPathBtnClick
  end
  object ConvertBtn: TButton
    Left = 480
    Top = 224
    Width = 217
    Height = 49
    Caption = 'XML -> REG'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = ConvertBtnClick
  end
end
