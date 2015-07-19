object frmImportLevels: TfrmImportLevels
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import Level'
  ClientHeight = 288
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblFilename: TLabel
    Left = 8
    Top = 8
    Width = 46
    Height = 13
    Caption = 'Filename:'
  end
  object lblLevelName: TLabel
    Left = 192
    Top = 40
    Width = 59
    Height = 13
    Caption = 'Level Name:'
  end
  object lblLevelDesc: TLabel
    Left = 192
    Top = 64
    Width = 85
    Height = 13
    Caption = 'Level Description:'
  end
  object lblLevelAuthor: TLabel
    Left = 192
    Top = 176
    Width = 65
    Height = 13
    Caption = 'Level Author:'
  end
  object lblLevelHomepage: TLabel
    Left = 192
    Top = 200
    Width = 55
    Height = 13
    Caption = 'Homepage:'
  end
  object lblDescription: TLabel
    Left = 280
    Top = 64
    Width = 161
    Height = 97
    AutoSize = False
    WordWrap = True
  end
  object lblName: TLabel
    Left = 272
    Top = 40
    Width = 3
    Height = 13
  end
  object lblAuthor: TLabel
    Left = 272
    Top = 176
    Width = 3
    Height = 13
  end
  object lblHomepage: TLabel
    Left = 272
    Top = 200
    Width = 3
    Height = 13
  end
  object txtFilename: TEdit
    Left = 64
    Top = 8
    Width = 345
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object cmdBrowse: TButton
    Left = 416
    Top = 8
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = cmdBrowseClick
  end
  object cmdCancel: TButton
    Left = 368
    Top = 256
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object cmdImport: TButton
    Left = 288
    Top = 256
    Width = 75
    Height = 25
    Caption = '&Import'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = cmdImportClick
  end
  object imgScreen: TImage32
    Left = 8
    Top = 34
    Width = 176
    Height = 216
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smStretch
    ShowHint = True
    TabOrder = 4
  end
  object OpenDialog: TOpenDialog
    Filter = 'Ms. Pacman Level (*.pac)|*.pac|All Files (*.*)|*.*'
    Title = 'Please select a Ms. Pacman level to open'
    Left = 192
    Top = 88
  end
end
