object frmAbout: TfrmAbout
  Left = 313
  Top = 184
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'About Blinky Editor'
  ClientHeight = 224
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblHomepage: TLabel
    Left = 4
    Top = 192
    Width = 58
    Height = 13
    Cursor = crHandPoint
    Hint = 'http://dan.panicus.org'
    Caption = 'Dan'#39's Space'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
    OnClick = lblHomepageClick
    OnMouseEnter = lblHomepageMouseEnter
    OnMouseLeave = lblHomepageMouseLeave
  end
  object lblDescription: TLabel
    Left = 8
    Top = 52
    Width = 361
    Height = 109
    AutoSize = False
    Caption = 
      'Blinky is a level editor for the NES game, Ms Pacman. It was wri' +
      'tten by Dan (dan@panicus.org).'#13#10#13#10'This program is not in any way' +
      ' associated with Namco, Nintendo, or any other stupid companies.' +
      ' Do not email me for the Ms Pacman ROM, because it'#39's rude.'
    WordWrap = True
  end
  object lblTitle: TLabel
    Left = 8
    Top = 8
    Width = 64
    Height = 25
    Caption = 'Blinky'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cmdOK: TButton
    Left = 294
    Top = 191
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
