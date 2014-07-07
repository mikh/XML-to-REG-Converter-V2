object outputPathForm: ToutputPathForm
  Left = 1397
  Top = 346
  Width = 629
  Height = 172
  Caption = 'Set Output Path...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object outputPathLabel: TLabel
    Left = 24
    Top = 24
    Width = 76
    Height = 13
    Caption = 'Set output path:'
  end
  object outputPathEdit: TEdit
    Left = 112
    Top = 24
    Width = 441
    Height = 21
    TabOrder = 0
  end
  object browseBtn: TButton
    Left = 560
    Top = 24
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = browseBtnClick
  end
  object newFolderBtn: TButton
    Left = 32
    Top = 64
    Width = 113
    Height = 41
    Caption = 'Add New Folder'
    TabOrder = 2
    OnClick = newFolderBtnClick
  end
  object saveBtn: TButton
    Left = 352
    Top = 64
    Width = 105
    Height = 41
    Caption = 'OK'
    TabOrder = 3
    OnClick = saveBtnClick
  end
  object cancelBtn: TButton
    Left = 472
    Top = 64
    Width = 105
    Height = 41
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = cancelBtnClick
  end
  object newFolderEdit: TEdit
    Left = 160
    Top = 72
    Width = 129
    Height = 21
    TabOrder = 5
    Text = 'New folder'
  end
end
