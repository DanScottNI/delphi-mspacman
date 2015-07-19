object frmStartingLives: TfrmStartingLives
  Left = 369
  Top = 363
  ActiveControl = txtStartingLives
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Values Editor'
  ClientHeight = 108
  ClientWidth = 288
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
  object lblStartingLives: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Starting Lives:'
  end
  object lblStartingScore: TLabel
    Left = 8
    Top = 40
    Width = 72
    Height = 13
    Caption = 'Starting Score:'
  end
  object txtStartingLives: TSpinEdit
    Left = 88
    Top = 8
    Width = 50
    Height = 22
    MaxLength = 1
    MaxValue = 9
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object cmdOK: TButton
    Left = 128
    Top = 72
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 7
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 208
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object txtScoreDigit1: TEdit
    Left = 88
    Top = 40
    Width = 30
    Height = 21
    MaxLength = 1
    TabOrder = 1
    Text = '0'
    OnKeyPress = txtScoreDigit1KeyPress
  end
  object txtScoreDigit2: TEdit
    Left = 120
    Top = 40
    Width = 30
    Height = 21
    MaxLength = 1
    TabOrder = 2
    Text = '0'
    OnKeyPress = txtScoreDigit1KeyPress
  end
  object txtScoreDigit3: TEdit
    Left = 152
    Top = 40
    Width = 30
    Height = 21
    MaxLength = 1
    TabOrder = 3
    Text = '0'
    OnKeyPress = txtScoreDigit1KeyPress
  end
  object txtScoreDigit4: TEdit
    Left = 184
    Top = 40
    Width = 30
    Height = 21
    MaxLength = 1
    TabOrder = 4
    Text = '0'
    OnKeyPress = txtScoreDigit1KeyPress
  end
  object txtScoreDigit5: TEdit
    Left = 216
    Top = 40
    Width = 30
    Height = 21
    MaxLength = 1
    TabOrder = 5
    Text = '0'
    OnKeyPress = txtScoreDigit1KeyPress
  end
  object txtScoreDigit6: TEdit
    Left = 248
    Top = 40
    Width = 30
    Height = 21
    MaxLength = 1
    TabOrder = 6
    Text = '0'
    OnKeyPress = txtScoreDigit1KeyPress
  end
end
