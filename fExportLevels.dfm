object frmExportLevels: TfrmExportLevels
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Export Levels'
  ClientHeight = 167
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblLevelFileName: TLabel
    Left = 8
    Top = 8
    Width = 46
    Height = 13
    Caption = 'Filename:'
  end
  object lblLevelName: TLabel
    Left = 8
    Top = 32
    Width = 59
    Height = 13
    Caption = 'Level Name:'
  end
  object lblLevelDes: TLabel
    Left = 8
    Top = 56
    Width = 85
    Height = 13
    Caption = 'Level Description:'
  end
  object lblLevelAuthor: TLabel
    Left = 8
    Top = 80
    Width = 65
    Height = 13
    Caption = 'Level Author:'
  end
  object lblHomepage: TLabel
    Left = 8
    Top = 104
    Width = 55
    Height = 13
    Caption = 'Homepage:'
  end
  object txtFilename: TEdit
    Left = 112
    Top = 8
    Width = 345
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object cmdBrowse: TButton
    Left = 464
    Top = 8
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = cmdBrowseClick
  end
  object txtName: TEdit
    Left = 112
    Top = 32
    Width = 345
    Height = 21
    MaxLength = 255
    TabOrder = 2
  end
  object txtDescription: TEdit
    Left = 112
    Top = 56
    Width = 345
    Height = 21
    MaxLength = 255
    TabOrder = 3
  end
  object txtAuthor: TEdit
    Left = 112
    Top = 80
    Width = 345
    Height = 21
    MaxLength = 255
    TabOrder = 4
  end
  object txtHomepage: TEdit
    Left = 112
    Top = 104
    Width = 345
    Height = 21
    MaxLength = 255
    TabOrder = 5
  end
  object cmdOK: TButton
    Left = 336
    Top = 136
    Width = 75
    Height = 25
    Caption = '&Export'
    Default = True
    ModalResult = 1
    TabOrder = 6
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 416
    Top = 136
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.pac'
    Filter = 'Ms. Pacman Level (*.pac)|*.pac|All Files (*.*)|*.*'
    Title = 'Please enter a filename'
    Left = 464
    Top = 32
  end
end
