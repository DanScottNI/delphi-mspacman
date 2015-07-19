object frmPaletteEditor: TfrmPaletteEditor
  Left = 360
  Top = 226
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Palette Editor'
  ClientHeight = 256
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl000F: TLabel
    Left = 352
    Top = 9
    Width = 34
    Height = 13
    Caption = '00 - 0F'
  end
  object lbl101F: TLabel
    Left = 352
    Top = 27
    Width = 34
    Height = 13
    Caption = '10 - 1F'
  end
  object lbl202F: TLabel
    Left = 352
    Top = 45
    Width = 34
    Height = 13
    Caption = '20 - 2F'
  end
  object lbl303F: TLabel
    Left = 352
    Top = 63
    Width = 34
    Height = 13
    Caption = '30 - 3F'
  end
  object lblCurrentPalette: TLabel
    Left = 64
    Top = 88
    Width = 133
    Height = 13
    Caption = 'Current Palette Colour: $00'
  end
  object imgNESColours: TImage32
    Left = 64
    Top = 8
    Width = 286
    Height = 73
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 0
    OnMouseMove = imgNESColoursMouseMove
    OnMouseUp = imgNESColoursMouseUp
  end
  object cmdOK: TButton
    Left = 312
    Top = 224
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DragCursor = crDefault
    ModalResult = 1
    TabOrder = 2
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 392
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 1
    TabOrder = 3
    OnClick = cmdCancelClick
  end
  object pgcPalettes: TPageControl
    Left = 8
    Top = 112
    Width = 457
    Height = 105
    ActivePage = tshBGPalettes
    TabOrder = 1
    object tshBGPalettes: TTabSheet
      Caption = 'Level Palette'
      object lblLevelBG: TLabel
        Left = 2
        Top = 6
        Width = 17
        Height = 13
        Caption = 'BG:'
      end
      object lblLevelSpr: TLabel
        Left = 0
        Top = 40
        Width = 20
        Height = 13
        Caption = 'Spr:'
      end
      object imgLevelBGPal1: TImage32
        Left = 26
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 0
        OnMouseUp = imgLevelBGPal1MouseUp
      end
      object imgLevelBGPal2: TImage32
        Tag = 1
        Left = 130
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 1
        OnMouseUp = imgLevelBGPal1MouseUp
      end
      object imgLevelBGPal3: TImage32
        Tag = 2
        Left = 234
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 2
        OnMouseUp = imgLevelBGPal1MouseUp
      end
      object imgLevelBGPal4: TImage32
        Tag = 3
        Left = 338
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 3
        OnMouseUp = imgLevelBGPal1MouseUp
      end
      object imgLevelSpr1: TImage32
        Tag = 4
        Left = 26
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 4
        OnMouseUp = imgLevelBGPal1MouseUp
      end
      object imgLevelSpr2: TImage32
        Tag = 5
        Left = 130
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 5
        OnMouseUp = imgLevelBGPal1MouseUp
      end
      object imgLevelSpr3: TImage32
        Tag = 6
        Left = 234
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 6
        OnMouseUp = imgLevelBGPal1MouseUp
      end
      object imgLevelSpr4: TImage32
        Tag = 7
        Left = 338
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 7
        OnMouseUp = imgLevelBGPal1MouseUp
      end
    end
    object tshTitleScreenPalette: TTabSheet
      Caption = 'Title Screen Palette'
      ImageIndex = 1
      object Label1: TLabel
        Left = 2
        Top = 6
        Width = 17
        Height = 13
        Caption = 'BG:'
      end
      object Label2: TLabel
        Left = 0
        Top = 40
        Width = 20
        Height = 13
        Caption = 'Spr:'
      end
      object imgTitleBG1: TImage32
        Left = 26
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 0
        OnMouseUp = imgTitleBG1MouseUp
      end
      object imgTitleBG2: TImage32
        Tag = 1
        Left = 130
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 1
        OnMouseUp = imgTitleBG1MouseUp
      end
      object imgTitleBG3: TImage32
        Tag = 2
        Left = 234
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 2
        OnMouseUp = imgTitleBG1MouseUp
      end
      object imgTitleBG4: TImage32
        Tag = 3
        Left = 338
        Top = 6
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 3
        OnMouseUp = imgTitleBG1MouseUp
      end
      object imgTitleSpr4: TImage32
        Tag = 7
        Left = 338
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 4
        OnMouseUp = imgTitleBG1MouseUp
      end
      object imgTitleSpr3: TImage32
        Tag = 6
        Left = 234
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 5
        OnMouseUp = imgTitleBG1MouseUp
      end
      object imgTitleSpr2: TImage32
        Tag = 5
        Left = 130
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 6
        OnMouseUp = imgTitleBG1MouseUp
      end
      object imgTitleSpr1: TImage32
        Tag = 4
        Left = 26
        Top = 38
        Width = 100
        Height = 25
        BitmapAlign = baTopLeft
        ParentShowHint = False
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        ShowHint = True
        TabOrder = 7
        OnMouseUp = imgTitleBG1MouseUp
      end
    end
  end
end
