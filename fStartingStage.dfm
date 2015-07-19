object frmStartingStage: TfrmStartingStage
  Left = 413
  Top = 379
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Starting Stage'
  ClientHeight = 75
  ClientWidth = 201
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
  object lblStartingStage: TLabel
    Left = 8
    Top = 8
    Width = 73
    Height = 13
    Caption = 'Starting Stage:'
  end
  object txtStartingStage: TSpinEdit
    Left = 128
    Top = 8
    Width = 65
    Height = 22
    MaxLength = 2
    MaxValue = 32
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object cmdOK: TButton
    Left = 40
    Top = 40
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 120
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
