object frmMirrorEditor: TfrmMirrorEditor
  Left = 365
  Top = 312
  BorderStyle = bsSingle
  Caption = 'Mirror Editor'
  ClientHeight = 336
  ClientWidth = 327
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
  object lblTileID: TLabel
    Left = 8
    Top = 248
    Width = 34
    Height = 13
    Caption = 'Tile ID:'
  end
  object lblMirrorTileID: TLabel
    Left = 168
    Top = 248
    Width = 65
    Height = 13
    Caption = 'Mirror Tile ID:'
  end
  object btnOK: TButton
    Left = 168
    Top = 304
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 248
    Top = 304
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object lstMirrorSettings: TListBox
    Left = 8
    Top = 8
    Width = 313
    Height = 233
    ItemHeight = 13
    TabOrder = 2
    OnClick = lstMirrorSettingsClick
  end
  object txtTileID: TEdit
    Left = 88
    Top = 248
    Width = 75
    Height = 21
    MaxLength = 2
    TabOrder = 3
  end
  object txtMirrorTileID: TEdit
    Left = 248
    Top = 248
    Width = 75
    Height = 21
    MaxLength = 2
    TabOrder = 4
  end
  object btnApply: TButton
    Left = 248
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Apply'
    Default = True
    TabOrder = 5
    OnClick = btnApplyClick
  end
end
