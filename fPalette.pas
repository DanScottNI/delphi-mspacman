unit fPalette;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32,GR32_Image, GR32_Layers, ComCtrls;

type
  TfrmPaletteEditor = class(TForm)
    lbl000F: TLabel;
    lbl101F: TLabel;
    lbl202F: TLabel;
    lbl303F: TLabel;
    lblCurrentPalette: TLabel;
    imgNESColours: TImage32;
    cmdOK: TButton;
    cmdCancel: TButton;
    pgcPalettes: TPageControl;
    tshBGPalettes: TTabSheet;
    imgLevelBGPal1: TImage32;
    lblLevelBG: TLabel;
    imgLevelBGPal2: TImage32;
    imgLevelBGPal3: TImage32;
    imgLevelBGPal4: TImage32;
    imgLevelSpr1: TImage32;
    imgLevelSpr2: TImage32;
    imgLevelSpr3: TImage32;
    imgLevelSpr4: TImage32;
    tshTitleScreenPalette: TTabSheet;
    imgTitleBG1: TImage32;
    imgTitleBG2: TImage32;
    imgTitleBG3: TImage32;
    imgTitleBG4: TImage32;
    imgTitleSpr4: TImage32;
    imgTitleSpr3: TImage32;
    imgTitleSpr2: TImage32;
    imgTitleSpr1: TImage32;
    lblLevelSpr: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure imgNESColoursMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer; Layer: TCustomLayer);
    procedure imgNESColoursMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevelBGPal1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure imgTitleBG1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  private
    TileX, TileY : Integer;
    CurColour : Byte;
    procedure DrawNESColours;
    procedure DisplayTitlePalette;
    procedure DisplayLevelPalette;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPaletteEditor: TfrmPaletteEditor;

implementation

uses uGlobal, uResourceStrings,fEditorMain;

{$R *.dfm}

procedure TfrmPaletteEditor.DrawNESColours();
var
  i,x : Integer;
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 287;
    TempBitmap.Height := 74;

    for i := 0 to 3 do
      for x :=0 to 15 do
        TempBitmap.FillRect(x*18,i*18 + 1,(x*18)+17,i*18+18,ROMData.NESPal[(i*16) + x]);

    tempbitmap.Line(0,0,0,74, clBlack32);


    if TileX = 0 then
      TempBitmap.FrameRectS(TileX,TileY,TileX+18,TileY+19,clRed32)

    else
      TempBitmap.FrameRectS(TileX-1,TileY,TileX+18,TileY+19,clRed32);

    imgNESColours.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;


procedure TfrmPaletteEditor.DisplayTitlePalette();
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 100;
    TempBitmap.Height := 25;

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[0,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[0,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[0,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[0,3]]);
    imgTitleBG1.Bitmap := TempBitmap;
    imgTitleBG1.Hint := '$' + IntToHex(ROMData.TitlePalette[0,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[0,1],2) + ' $' + IntToHex(ROMData.TitlePalette[0,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[0,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[1,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[1,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[1,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[1,3]]);
    imgTitleBG2.Bitmap := TempBitmap;
    imgTitleBG2.Hint := '$' + IntToHex(ROMData.TitlePalette[1,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[1,1],2) + ' $' + IntToHex(ROMData.TitlePalette[1,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[1,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[2,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[2,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[2,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[2,3]]);
    imgTitleBG3.Bitmap := TempBitmap;
    imgTitleBG3.Hint := '$' + IntToHex(ROMData.TitlePalette[2,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[2,1],2) + ' $' + IntToHex(ROMData.TitlePalette[2,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[2,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[3,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[3,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[3,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[3,3]]);
    imgTitleBG4.Bitmap := TempBitmap;
    imgTitleBG4.Hint := '$' + IntToHex(ROMData.TitlePalette[3,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[3,1],2) + ' $' + IntToHex(ROMData.TitlePalette[3,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[3,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[4,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[4,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[4,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[4,3]]);
    imgTitleSpr1.Bitmap := TempBitmap;
    imgTitleSpr1.Hint := '$' + IntToHex(ROMData.TitlePalette[4,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[4,1],2) + ' $' + IntToHex(ROMData.TitlePalette[4,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[4,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[5,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[5,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[5,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[5,3]]);
    imgTitleSpr2.Bitmap := TempBitmap;
    imgTitleSpr2.Hint := '$' + IntToHex(ROMData.TitlePalette[5,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[5,1],2) + ' $' + IntToHex(ROMData.TitlePalette[5,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[5,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[6,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[6,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[6,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[6,3]]);
    imgTitleSpr3.Bitmap := TempBitmap;
    imgTitleSpr3.Hint := '$' + IntToHex(ROMData.TitlePalette[6,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[6,1],2) + ' $' + IntToHex(ROMData.TitlePalette[6,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[6,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.TitlePalette[7,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.TitlePalette[7,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.TitlePalette[7,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.TitlePalette[7,3]]);
    imgTitleSpr4.Bitmap := TempBitmap;
    imgTitleSpr4.Hint := '$' + IntToHex(ROMData.TitlePalette[7,0],2) + ' $' +
      IntToHex(ROMData.TitlePalette[7,1],2) + ' $' + IntToHex(ROMData.TitlePalette[7,2],2) +
        ' $' + IntToHex(ROMData.TitlePalette[7,3],2);


  finally
    FreeAndNil(TempBitmap);
  end;

end;

procedure TfrmPaletteEditor.DisplayLevelPalette();
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 100;
    TempBitmap.Height := 25;

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[0,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[0,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[0,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[0,3]]);
    imgLevelBGPal1.Bitmap := TempBitmap;
    imgLevelBGPal1.Hint := '$' + IntToHex(ROMData.Palette[0,0],2) + ' $' +
      IntToHex(ROMData.Palette[0,1],2) + ' $' + IntToHex(ROMData.Palette[0,2],2) +
        ' $' + IntToHex(ROMData.Palette[0,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[1,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[1,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[1,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[1,3]]);
    imgLevelBGPal2.Bitmap := TempBitmap;
    imgLevelBGPal2.Hint := '$' + IntToHex(ROMData.Palette[1,0],2) + ' $' +
      IntToHex(ROMData.Palette[1,1],2) + ' $' + IntToHex(ROMData.Palette[1,2],2) +
        ' $' + IntToHex(ROMData.Palette[1,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[2,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[2,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[2,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[2,3]]);
    imgLevelBGPal3.Bitmap := TempBitmap;
    imgLevelBGPal3.Hint := '$' + IntToHex(ROMData.Palette[2,0],2) + ' $' +
      IntToHex(ROMData.Palette[2,1],2) + ' $' + IntToHex(ROMData.Palette[2,2],2) +
        ' $' + IntToHex(ROMData.Palette[2,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[3,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[3,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[3,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[3,3]]);
    imgLevelBGPal4.Bitmap := TempBitmap;
    imgLevelBGPal4.Hint := '$' + IntToHex(ROMData.Palette[3,0],2) + ' $' +
      IntToHex(ROMData.Palette[3,1],2) + ' $' + IntToHex(ROMData.Palette[3,2],2) +
        ' $' + IntToHex(ROMData.Palette[3,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[4,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[4,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[4,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[4,3]]);
    imgLevelSpr1.Bitmap := TempBitmap;
    imgLevelSpr1.Hint := '$' + IntToHex(ROMData.Palette[4,0],2) + ' $' +
      IntToHex(ROMData.Palette[4,1],2) + ' $' + IntToHex(ROMData.Palette[4,2],2) +
        ' $' + IntToHex(ROMData.Palette[4,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[5,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[5,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[5,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[5,3]]);
    imgLevelSpr2.Bitmap := TempBitmap;
    imgLevelSpr2.Hint := '$' + IntToHex(ROMData.Palette[5,0],2) + ' $' +
      IntToHex(ROMData.Palette[5,1],2) + ' $' + IntToHex(ROMData.Palette[5,2],2) +
        ' $' + IntToHex(ROMData.Palette[5,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[6,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[6,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[6,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[6,3]]);
    imgLevelSpr3.Bitmap := TempBitmap;
    imgLevelSpr3.Hint := '$' + IntToHex(ROMData.Palette[6,0],2) + ' $' +
      IntToHex(ROMData.Palette[6,1],2) + ' $' + IntToHex(ROMData.Palette[6,2],2) +
        ' $' + IntToHex(ROMData.Palette[6,3],2);

    TempBitmap.FillRect(0,0,25,25, ROMData.NESPal[ROMData.Palette[7,0]]);
    TempBitmap.FillRect(25,0,50,25, ROMData.NESPal[ROMData.Palette[7,1]]);
    TempBitmap.FillRect(50,0,75,25, ROMData.NESPal[ROMData.Palette[7,2]]);
    TempBitmap.FillRect(75,0,100,25, ROMData.NESPal[ROMData.Palette[7,3]]);
    imgLevelSpr4.Bitmap := TempBitmap;
    imgLevelSpr4.Hint := '$' + IntToHex(ROMData.Palette[7,0],2) + ' $' +
      IntToHex(ROMData.Palette[7,1],2) + ' $' + IntToHex(ROMData.Palette[7,2],2) +
        ' $' + IntToHex(ROMData.Palette[7,3],2);


  finally
    FreeAndNil(TempBitmap);
  end;

end;


procedure TfrmPaletteEditor.FormShow(Sender: TObject);
begin
  DrawNESColours();
  DisplayLevelPalette();
  DisplayTitlePalette();
end;

procedure TfrmPaletteEditor.imgNESColoursMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  lblCurrentPalette.Caption := RES_CURRENTCOLOURPAL + IntToHex(((X div 18) + (Y div 18) * 16),2);
end;

procedure TfrmPaletteEditor.imgNESColoursMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  CurColour := ((X div 18) + (Y div 18) * 16);
  TileX := (X div 18) * 18;
  TileY := (y div 18) * 18;
  DrawNESColours();
end;

procedure TfrmPaletteEditor.imgLevelBGPal1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin


  ROMData.Palette[TImage32(Sender).Tag, x div 25] := CurColour;
  DisplayLevelPalette;
  TfrmEditorMain(Owner).RedrawScreen();

end;

procedure TfrmPaletteEditor.cmdCancelClick(Sender: TObject);
begin
  ROMData.LoadBGPalette;
  ROMData.LoadTitlePalette;

  TfrmEditorMain(Owner).RedrawScreen;
end;

procedure TfrmPaletteEditor.cmdOKClick(Sender: TObject);
begin
  ROMData.SaveBGPalette;
  ROMData.SaveTitlePalette;
end;

procedure TfrmPaletteEditor.imgTitleBG1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  ROMData.TitlePalette[TImage32(Sender).Tag, x div 25] := CurColour;

end;

end.
