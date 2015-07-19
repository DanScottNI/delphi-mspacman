object frmLevelInfo: TfrmLevelInfo
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Level Information'
  ClientHeight = 415
  ClientWidth = 441
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
  object cmdOK: TButton
    Left = 360
    Top = 384
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object lvwLevelInfo: TListView
    Left = 8
    Top = 8
    Width = 425
    Height = 369
    Columns = <
      item
        Caption = 'Stage Number'
        Width = 100
      end
      item
        Caption = 'Start Offset'
        Width = 100
      end
      item
        Caption = 'End Offset'
        Width = 100
      end
      item
        Caption = 'Compressed Size'
        Width = 100
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object cmdCopyToClip: TButton
    Left = 8
    Top = 384
    Width = 137
    Height = 25
    Caption = 'Output'
    TabOrder = 1
    OnClick = cmdCopyToClipClick
  end
end
