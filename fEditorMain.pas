unit fEditorMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Menus, ComCtrls, ToolWin, GR32_Image, StdCtrls, ImgList, dialogs,
  ActnList, ExtCtrls, gr32, gr32_layers, AbBase, AbBrowse, AbZBrows, FileCtrl,
  AbZipper, shellAPI, JvDragDrop,cROMData, JvComponentBase, JvBalloonHint;

type
  TfrmEditorMain = class(TForm)
    imgScreen: TImage32;
    tlbToolbar: TToolBar;
    tlbOpenROM: TToolButton;
    imgTiles: TImage32;
    StatusBar: TStatusBar;
    ActionList: TActionList;
    actAbout: TAction;
    actPreferences: TAction;
    ImageList: TImageList;
    actOpenROM: TAction;
    actSaveROM: TAction;
    actCloseROM: TAction;
    tlbSaveROM: TToolButton;
    tlbCloseROM: TToolButton;
    actEnableGridlines: TAction;
    AbZipper: TAbZipper;
    tlbSep1: TToolButton;
    tlbMapEditingMode: TToolButton;
    tlbObjectEditingMode: TToolButton;
    actSetMapEditingMode: TAction;
    actObjectEditingMode: TAction;
    actSaveAsIPS: TAction;
    actProperties: TAction;
    tlbSep2: TToolButton;
    actKeyboardLayout: TAction;
    Bitmap32List: TBitmap32List;
    actGoToLevel: TAction;
    tlbGoToLevel: TToolButton;
    actDebugROMViewer: TAction;
    actBackupManager: TAction;
    tlbEnableGridlines: TToolButton;
    sep3: TToolButton;
    OpenDialog: TOpenDialog;
    MainMenu: TMainMenu;
    mnuFile: TMenuItem;
    mnuOpenROM: TMenuItem;
    mnuRecent: TMenuItem;
    mnuRecentItem1: TMenuItem;
    mnuRecentItem2: TMenuItem;
    mnuRecentItem3: TMenuItem;
    mnuRecentItem4: TMenuItem;
    mnuRecentItem5: TMenuItem;
    mnuSaveROM: TMenuItem;
    mnuDistributeHack: TMenuItem;
    mnuCloseROM: TMenuItem;
    N1: TMenuItem;
    mnuBackupManager: TMenuItem;
    mnuPreferences: TMenuItem;
    mnuProperties: TMenuItem;
    mnuLaunchAssociatedEmulator: TMenuItem;
    N2: TMenuItem;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuMapEditingMode: TMenuItem;
    mnuObjectEditingMode: TMenuItem;
    mnuView: TMenuItem;
    mnuStartPosition: TMenuItem;
    mnuGridlines: TMenuItem;
    N4: TMenuItem;
    mnuGotolevel: TMenuItem;
    mnuTools: TMenuItem;
    mnuDebugROMViewer: TMenuItem;
    mnuHelp: TMenuItem;
    mnuKeyboardLayout: TMenuItem;
    N5: TMenuItem;
    mnuVisitRockAndRollHomepage: TMenuItem;
    N3: TMenuItem;
    mnuAbout: TMenuItem;
    actDistributeHack: TAction;
    mnuPaletteEditor: TMenuItem;
    actStartingStage: TAction;
    actValuesEditor: TAction;
    mnuStartingStage: TMenuItem;
    mnuValuesEditor: TMenuItem;
    Debug1: TMenuItem;
    actLevelInfo: TAction;
    mnuLevelInformation: TMenuItem;
    tlbSep3: TToolButton;
    tlbCreateGhostTrap: TToolButton;
    tlbIndentLevel: TToolButton;
    tlbClear: TToolButton;
    popClearOptions: TPopupMenu;
    FillWithPellets1: TMenuItem;
    FillWithEmptySpace1: TMenuItem;
    tlbErasePills: TToolButton;
    actIndentLevel: TAction;          
    actEraseLevel: TAction;
    actEraseLevelPellets: TAction;
    actCreateGhostTrap: TAction;
    N6: TMenuItem;
    mnuCreateGhostTrap: TMenuItem;
    mnuIndentLevel: TMenuItem;
    mnuEraseLevel: TMenuItem;
    mnuEraseLevelPellets: TMenuItem;
    actMirroringMode: TAction;
    actPalette: TAction;
    N7: TMenuItem;
    mnuImportLevel: TMenuItem;
    ExportLevel1: TMenuItem;
    actImportLevel: TAction;
    actExportLevel: TAction;
    N8: TMenuItem;
    JvDropTarget1: TJvDropTarget;
    JvBalloonHint1: TJvBalloonHint;
    Label1: TLabel;
    tlbMirroringMode: TToolButton;
    actMirrorEditor: TAction;
    mnuMirrorEditor: TMenuItem;
    mnuMirrorMaze: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actValuesEditorExecute(Sender: TObject);
    procedure actExportLevelExecute(Sender: TObject);
    procedure actImportLevelExecute(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;var Resize: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure actOpenROMExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure imgScreenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure scrTilesChange(Sender: TObject);
    procedure scrTilesScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure imgTilesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure actPreferencesExecute(Sender: TObject);
    procedure mnuRecentItem1Click(Sender: TObject);
    procedure actSaveROMExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure scrLevelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actObjectEditingModeExecute(Sender: TObject);
    procedure actSetMapEditingModeExecute(Sender: TObject);
    procedure mnuLaunchAssociatedEmulatorClick(Sender: TObject);
    procedure actSaveAsIPSExecute(Sender: TObject);
    procedure JvDropTargetDragDrop(Sender: TJvDropTarget;
      var Effect: TJvDropEffect; Shift: TShiftState; X, Y: Integer);
    procedure actCloseROMExecute(Sender: TObject);
    procedure imgScreenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure imgScreenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
//    procedure actSoundEffectsExecute(Sender: TObject);
    procedure actKeyboardLayoutExecute(Sender: TObject);
    procedure mnuVisitRockAndRollHomepageClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure actGoToLevelExecute(Sender: TObject);
    procedure actDebugROMViewerExecute(Sender: TObject);
    procedure mnuStartPositionClick(Sender: TObject);
    procedure actBackupManagerExecute(Sender: TObject);
    procedure actPropertiesExecute(Sender: TObject);
    procedure actEnableGridlinesExecute(Sender: TObject);
    procedure actDistributeHackExecute(Sender: TObject);
    procedure actStartingStageExecute(Sender: TObject);
    procedure actLevelInfoExecute(Sender: TObject);
    procedure actIndentLevelExecute(Sender: TObject);
    procedure actCreateGhostTrapExecute(Sender: TObject);
    procedure actMirroringModeExecute(Sender: TObject);
    procedure actEraseLevelExecute(Sender: TObject);
    procedure actEraseLevelPelletsExecute(Sender: TObject);
    procedure actPaletteExecute(Sender: TObject);
    procedure actMirrorEditorExecute(Sender: TObject);
  private
    _CurTileLeft, _CurTileMid : Byte;
    _EditingMode : Byte;
    _Obj : TObjDetect;
//    _MouseDownX, _MouseDownY : INteger;
    procedure SetIconTransparency();
    procedure SetVisibleStatus(pVisible : Boolean);
    procedure DisplayScreenInfo;
    procedure LoadROM(pFilename,pDataFile : String;pAutoCheck : Boolean);
    procedure CreateRecentMenu();
    procedure SetEmuMenuText();
    procedure BackupFile();
    procedure SetupLevel();
    procedure ExecuteEmulator;
    procedure SetIPSEnabled;
    procedure ClearImageIndex;
    function AutoCheckROMType(pFilename : String) : String;
    function CloseROM() : Boolean;
    procedure LoadEmulatorIcon;
    procedure DisplayPellet;
    { Private declarations }
  public
    procedure RedrawScreen;
    procedure DrawLevelData();
    procedure DrawTileSelector();
    procedure UpdateTitleCaption;
    property CurTileLeft : Byte read _CurTileLeft write _CurTileLeft;
    property CurTileMid : Byte read _CurTileMid write _CurTileMid;
    { Public declarations }
  end;

var
  frmEditorMain: TfrmEditorMain;

implementation

uses uglobal,cConfiguration, fAbout,fStartingStage,fStartingLives,
  fPreferences, uLunarCompress,fOpenDialog,fLevelInfo,fTileEditor,
  fFileProperties,fKeyboardLayouts, fGoToLevel,fDebugROMViewer,
  fBackupManagement,iNESImage,MemINIHexFile, uresourcestrings, fDistribution,
  fExportLevels,fImportLevels, fPalette, cMirrorConfiguration, fMirrorEditor;

{$R *.dfm}

const
  MAPEDITINGMODE : Byte = 0;
  OBJECTEDITINGMODE : Byte = 1;

procedure TfrmEditorMain.SetVisibleStatus(pVisible : Boolean);
begin
  imgScreen.Visible := pVisible;
  imgTiles.Visible := pVisible;
  actLevelInfo.Enabled := pVisible;
  mnuLaunchAssociatedEmulator.Enabled := pVisible;
  actSetMapEditingMode.Enabled := pVisible;
  actObjectEditingMode.Enabled := pVisible;
  actValuesEditor.Enabled := pVisible;
  actStartingStage.Enabled := pVisible;
  Debug1.Enabled := pVisible;
  actSaveROM.Enabled := pVisible;
  actCloseROM.Enabled := pVisible;
  actProperties.Enabled := pVisible;
  actGoToLevel.Enabled := pVisible;
  actDebugROMViewer.Enabled := pVisible;
  self.mnuStartPosition.Enabled := pVisible;
  mnuGridlines.Enabled := pVisible;
  actEnableGridlines.Enabled := pVisible;
  actEraseLevel.Enabled := pVisible;
  actEraseLevelPellets.Enabled := pVisible;
  actIndentLevel.Enabled := pVisible;
  actDistributeHack.Enabled := pVisible;
  actCreateGhostTrap.Enabled := pVisible;
  actMirroringMode.Enabled := pVisible;
  actPalette.Enabled := pVisible;
  actExportLevel.Enabled := pVisible;
  actImportLevel.Enabled := pVisible;
  actMirroringMode.Enabled := pVisible;
  if pVisible = False then
  begin
    Statusbar.Panels[0].Text := RES_ROMNOTLOADED;
    Statusbar.Panels[0].Width := self.ClientWidth;
    Statusbar.Panels[1].Width := 0;
    Statusbar.Panels[2].Width := 0;
  end
  else
  begin
    Statusbar.Panels[0].Width := 125;
    Statusbar.Panels[1].Width := 130;
    Statusbar.Panels[2].Width := 50;
  end;

  if DEBUG = False then
  begin
    actDebugROMViewer.Visible := False;
    actDebugROMViewer.Enabled := False;
  end;
end;


procedure TfrmEditorMain.FormCreate(Sender: TObject);
begin
  if DEBUG = true then
  begin
//    MemCheckLogFileName := ExtractFileDir(Application.EXEName) + '\memory.log';
//    memchk();
  end
  else
  begin
    mnuDebugROMViewer.Visible := False;
  end;

  EditorConfig := TEditorConfig.Create(ExtractFileDir(Application.ExeName) + '\options.ini');
  MirrorConfig := TMirrorConfiguration.Create(ExtractFileDir(Application.ExeName) + '\Resources\MirrorSetup.ini');
  SetVisibleStatus(False);

  _Obj.ObjType := -1;
  _Obj.ObjIndex := -1;

  Caption := APPLICATIONTITLE;
  Application.Title := APPLICATIONTITLE;
  CreateRecentMenu();
  SetEmuMenuText;
  SetIPSEnabled;
  ClearImageIndex;
  UpdateTitleCaption();
  // to whether the gridlines are actually on.
  actEnableGridlines.Checked := EditorConfig.GridlinesOn;
  self.actMirroringMode.Checked := EditorConfig.MirrorLevels;

  // Now look up the commandline parameters. If the user has
  // passed a ROM's filename along with EXE name, open the ROM.
  if ParamCount >= 1 then
  begin
    if FileExists(ParamStr(1)) then
      LoadROM(ParamStr(1),EditorConfig.FullDataFileName, EditorConfig.AutoCheck);
    // This uses another parameter to dump the level at the specified offset
    // to a file called 'extract.pac'.
    if ParamCount >=2 then
    begin
      ROMData.DecompressLevels(StrToInt('$' +  ParamStr(2)));
    end;

  end;

end;

procedure TfrmEditorMain.actOpenROMExecute(Sender: TObject);
var
  OpDlg : TfrmOpenDialog;
begin
  OpDlg := TfrmOpenDialog.Create(self);
  try
    OpDlg.OpenDir := ExtractFileDir(EditorConfig.RecentFile[0]);
    OpDlg.ShowModal;

    if FileExists(OpDlg.Filename) = True then
      LoadROM(OpDlg.FileName,OpDlg.DataFile,OpDlg.AutoCheck);
  finally
    FreeAndNil(OpDlg);
  end;

end;

procedure TfrmEditorMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if CloseROM() = false then
  begin
    if Assigned(EditorConfig) then
    begin
      if EditorConfig.Changed = True then
        EditorConfig.Save;
      FreeAndNil(EditorConfig);
    end;

    if Assigned(MirrorConfig) = True then
    begin
      MirrorConfig.Save();
      FreeAndNil(MirrorConfig);
    end;

  end
  else
  begin
    CanClose := False;
  end;
end;

function TfrmEditorMain.CloseROM() : Boolean;
var
  MsgRes : Integer;
begin
  if EditorConfig.Changed = True then
    EditorConfig.Save;
  MirrorConfig.Save;
  result := false;

  if (Assigned(ROMData) = True) and (ROMData.Changed = True) then
  begin
    MsgRes := MessageDlg(RES_ROMCHANGESSAVE,mtConfirmation,[mbYes, mbNo,mbCancel],0);

    if msgres <> mrCancel then
    begin
      if MsgRes = mrYes then
      ROMData.Save;
      FreeAndNil(ROMData);
      UpdateTitleCaption;
      SetVisibleStatus(False);
    end;

    if msgres = mrCancel then
      result := true;
  end
  else if Assigned(ROMData) = True then
  begin
      FreeAndNil(ROMData);
      UpdateTitleCaption;
      SetVisibleStatus(False);
  end;

end;

procedure TfrmEditorMain.actAboutExecute(Sender: TObject);
var
  About : TfrmAbout;
begin
  About := TfrmAbout.Create(self);
  try
    About.ShowModal;
  finally
    FreeAndNil(About);
  end;
end;

procedure TfrmEditorMain.DrawLevelData();
var
  TempBitmap, temp2 : Tbitmap32;
  Filter : Byte;
  i : Integer;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 22*8;
    TempBitmap.Height := 27*8;
    filter := 0;
    if mnuStartPosition.Checked = True then
      Filter := Filter + 1;

    ROMData.DrawCurrentScreen(TempBitmap, Filter,Bitmap32List);

    temp2 := TBitmap32.Create;
    temp2.Width := TempBitmap.Width * 2;
    temp2.Height := TempBitmap.Height *2;

    temp2.Draw(bounds(0,0,temp2.width,temp2.Height),bounds(0,0,TempBitmap.Width,TempBitmap.Height),tempbitmap); 

    if EditorConfig.GridlinesOn = True then
    begin
      for i := 1 to 21 do
        temp2.Line(i*16,0,i*16,Temp2.Height,EditorConfig.GridlineColour);
      for i := 1 to 26 do
        temp2.Line(0,i*16,Temp2.Width,i*16,EditorConfig.GridlineColour);
    end;

    imgScreen.Bitmap := temp2;
    freeandNil(temp2);
  finally
    FreeAndNil(TempBitmap);
  end;

  DisplayPellet;

end;

procedure TfrmEditorMain.SetIconTransparency();
var
  i : Integer;
begin
  for i := 0 to Bitmap32List.Bitmaps.Count - 1 do
  begin
    if EditorConfig.DrawTransparentIcons = True then
      Bitmap32List.Bitmap[i].DrawMode := dmBlend
    else
      Bitmap32List.Bitmap[i].DrawMode := dmOpaque;

    Bitmap32List.Bitmap[i].MasterAlpha := EditorConfig.IconTransparency;
  end;

end;

procedure TfrmEditorMain.DrawTileSelector();
var
  TempBitmap : TBitmap32;
  TempRect : TRect;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 32;
    TempBitmap.Height := 128;
    ROMData.DrawTileSelector(TempBitmap);


    TempRect := ROMData.GetRectTileNumber(CurTileLeft);
    if CurTileLeft = CurTileMid then
    begin

      TempBitmap.Line(TempRect.Left,TempRect.Top,TempRect.Left,TempRect.Top + 8,EditorConfig.LeftTextColour);
      TempBitmap.Line(TempRect.Left,TempRect.Top,TempRect.Left+8,TempRect.Top,EditorConfig.LeftTextColour);

    end
    else
      TempBitmap.FrameRectS(TempRect,EditorConfig.LeftTextColour);


    TempBitmap.Font.Color := wincolor(EditorConfig.MiddleTextColour);
    TempRect := ROMData.GetRectTileNumber(CurTileMid);
    if CurTileLeft = CurTileMid then
    begin

      TempBitmap.Line(TempRect.Left+  7,TempRect.Top,TempRect.Left+7,TempRect.Top + 8,EditorConfig.MiddleTextColour);
      TempBitmap.Line(TempRect.Left+0,TempRect.Top+7,TempRect.Left+8,TempRect.Top+7,EditorConfig.MiddleTextColour);

    end
    else
      TempBitmap.FrameRectS(TempRect,EditorConfig.MiddleTextColour);


    imgTiles.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;



procedure TfrmEditorMain.DisplayScreenInfo;
begin
  StatusBar.Panels[1].Text := RES_LEVELNO + IntToStr(ROMData.Level+1);
end;

procedure TfrmEditorMain.imgScreenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  CurTilePos : Integer;
  TileDrawX : Integer;
begin
  if _EditingMode = MAPEDITINGMODE then
  begin
    if button = mbLeft then
    begin

      if ssShift in Shift then
        ROMData.RoomData[(x div 2) div 8,(y div 2) div 8] := _CurTileMid
      else
        ROMData.RoomData[(x div 2) div 8,(y div 2) div 8] := _CurTileLeft;

      if EditorConfig.MirrorLevels = True then
      begin
        TileDrawX := 21-  ( (x div 2) div 8 );

        if ssShift in Shift then
          ROMData.RoomData[TileDrawX,(y div 2) div 8] := MirrorConfig.MirrorSettings[_CurTileMid]
        else
          ROMData.RoomData[TileDrawX,(y div 2) div 8] := MirrorConfig.MirrorSettings[_CurTileLeft];
      end;

      DrawLevelData();
    end
    else if button = mbRight then
    begin

//      showmessage( inttostr(  ( ((y div 2) div 8) * 22)   + ( (x div 2) div 8) ));
      CurTilePos := ROMData.RoomData[(x div 2) div 8,(y div 2) div 8];
      if ssShift in Shift then
        CurTileMid := CurTilePos
      else
        CurTileLeft := CurTilePos;
      DrawTileSelector();
    end
    else if Button = mbMiddle then
    begin

      if ssShift in Shift then
        _CurTileMid := ROMData.RoomData[(x div 2) div 8,(y div 2) div 8]
      else
        ROMData.RoomData[(x div 2) div 8,(y div 2) div 8] := _CurTileMid;

      if EditorConfig.MirrorLevels = True then
      begin
        TileDrawX := 21-  ( (x div 2) div 8 );
        ROMData.RoomData[TileDrawX,(y div 2) div 8] := MirrorConfig.MirrorSettings[_CurTileMid]
      end;

      DrawLevelData();
    end;

  end
  else if _EditingMode = OBJECTEDITINGMODE then
  begin

    // Detect what type of object (if any), is under the mouse
    // when you clicked.
    _Obj := ROMData.DetectObjectUnderMouse(x div 2,y div 2);

  end;

  UpdateTitleCaption();
end;

procedure TfrmEditorMain.scrTilesChange(Sender: TObject);
begin
  DrawTileSelector();
end;

procedure TfrmEditorMain.scrTilesScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  DrawTileSelector();
end;

procedure TfrmEditorMain.imgTilesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  CalcTile : Byte;
  TilEd : Tfrm16x16TileEditor;
begin
  CalcTile := (X div 16) + ((Y div 16) * 4);
  if ((Button = mbLeft) and (ssShift in Shift)) or (Button = mbMiddle) then
  begin

    _CurTileMid := CalcTile;
  end
  else if Button = mbLeft then
  begin
    _CurTileLeft := CalcTile;
  end
  else if Button = mbRight then
  begin
    TilEd := Tfrm16x16TileEditor.Create(self);
    try
      TilEd.TileID := CalcTile;
      if TilEd.ShowModal = mrOK then
      begin
        ROMData.RefreshOnScreenTiles;
        ROMData.SavePatternTable;
        DrawTileSelector;
        DrawLevelData;

      end;
    finally
      FreeAndNil(TilEd);
    end;
  end;

  UpdateTitleCaption;
  DrawTileSelector();
end;

procedure TfrmEditorMain.actPreferencesExecute(Sender: TObject);
var
  Pref : TfrmPreferences;
begin
  Pref := TfrmPreferences.Create(self);
  try
    if Pref.ShowModal = mrOk then
    begin
      EditorConfig.Save;
      SetEmuMenuText();
      SetIPSEnabled;
      if ROMData <> nil then
      begin
        ROMData.LoadPaletteFile(EditorConfig.FullPaletteName);
        ROMData.RefreshOnScreenTiles;
        SetIconTransparency;
        DrawLevelData();
        DrawTileSelector();
        actEnableGridlines.Checked := EditorConfig.GridlinesOn;
      end;
    end;
  finally
    FreeAndNil(Pref);
  end;
end;

procedure TfrmEditorMain.LoadROM(pFilename,pDataFile : String;pAutoCheck : Boolean);
var
  TempFilename : String;
//  i : Integer;
begin
  // If the ROM file does not exist then exit the subroutine.
  if FileExists(pFilename) = False then
    exit;
  // Transfer the datafile's filename over to another variable.
  TempFilename := pDataFile;
  // If the user wants to automatically check the ROM type then
  // check it. If there is no matches, reset the TempFileName variable
  // back to pDataFile (Usually the default datafile).
  if pAutoCheck = True then
  begin
    TempFilename := AutoCheckROMType(pFilename);
    if TempFilename = '' then
      TempFilename := pDataFile
    else
      TempFilename := ExtractFileDir(Application.ExeName) + '\Resources\' + TempFilename;
  end;

  // If the datafile does not exist, then exit the subroutine.
  if FileExists(TempFileName) = False then
    exit;

  // First check if the ROM is already loaded.
  if assigned(ROMData) = True then
  begin
    FreeAndNil(ROMData);
  end;
  EditorConfig.AddRecentFile(pFilename);
  CreateRecentMenu();
  ROMData := TROMData.Create(pFilename,TempFilename);
  if ROMData.IsValidROM = false then
  begin
    // If the user elects to not load the ROM, then
    // display a prompt informing the user that the ROM will
    // not be loaded, free the ROM, and exit the subroutine.
    if EditorConfig.MapperWarnings = 0 then
    begin
        Messagebox(handle,PChar(RES_NOTVALIDROM),PChar(Application.Title),0);
        FreeAndNil(ROMData);
        exit;
    end
    // If the user has elected to be prompted about the
    // ROM not conforming to the standard Mega Man settings
    // tell the user, and give them the choice of whether or not to load it.
    else if EditorConfig.MapperWarnings = 1 then
    begin
      if MessageBox(Handle,PChar(RES_NOTVALIDROMCONTINUE),
            PChar(Application.Title),MB_YESNO) = IDNO	then
      begin
        FreeAndNil(ROMData);
        exit;
      end;
    end;

  end;
  // If the palette specified exists, then load it.
  if FileExists(EditorConfig.FullPaletteName) = True then
    ROMData.LoadPaletteFile(EditorConfig.FullPaletteName)
  else
    ROMData.LoadDefaultPalette;

  if ROMData.InstallPalASMHack() = false then
  begin

    JvBalloonHint1.ActivateHint(Label1,RES_DAHRKDAIZPALHACK + CRLF + RES_DAHRKDAIZPALHACK2 +
      CRLF+ CRLF + RES_DAHRKDAIZHOMEPAGE,'Palette Hack');
{    showmessage(RES_DAHRKDAIZPALHACK + CRLF + RES_DAHRKDAIZPALHACK2 +
      CRLF+ CRLF + RES_DAHRKDAIZHOMEPAGE);}
  end;

  ROMData.Level := 0;

//  StatusBar.Panels[2].Text := ExtractFileName(ROMData.DataFile);
  SetVisibleStatus(True);
  actSetMapEditingMode.Execute;
  SetIconTransparency;
  SetEmuMenuText();
  SetIPSEnabled;
  SetupLevel;
  UpdateTitleCaption();
{  for i := 0 to ROMData.Levels.COunt -1 do
  begin
    ROMData.ExportLevel(extractfiledir(Application.ExeName) + '\Level' + IntToStr(i+1) + '.pac',i,'Level ' + IntToStr(i+1),'Original Level Data for Level ' + IntToStr(i+1),'Namco','http://www.namco.com');
  end;}
end;

procedure TfrmEditorMain.SetupLevel();
begin

//  scrTiles.Position := ROMData.CurrLevel.StartTSAAt;
  DrawLevelData();

  DrawTileSelector();

  DisplayScreenInfo;
  DisplayPellet;

  UpdateTitleCaption();
end;

procedure TfrmEditorMain.CreateRecentMenu();
var
  Bitmap : TBitmap;
begin
  if EditorConfig.NumberOfRecentlyOpenedFiles = 0 then
    mnuRecent.Visible := False
  else
    mnuRecent.Visible := True;

  if EditorConfig.RecentFile[0] = '' then
    mnuRecentItem1.Visible := False
  else
    mnuRecentItem1.Visible := True;
  if EditorConfig.RecentFile[1] = '' then
    mnuRecentItem2.Visible := False
  else
    mnuRecentItem2.Visible := True;
  if EditorConfig.RecentFile[2] = '' then
    mnuRecentItem3.Visible := False
  else
    mnuRecentItem3.Visible := True;
  if EditorConfig.RecentFile[3] = '' then
    mnuRecentItem4.Visible := False
  else
    mnuRecentItem4.Visible := True;
  if EditorConfig.RecentFile[4] = '' then
    mnuRecentItem5.Visible := False
  else
    mnuRecentItem5.Visible := True;

  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := 400;
    Bitmap.Height :=  40;
//    self.FindChildControl()
    mnuRecentItem1.Caption := MinimizeName(EditorConfig.RecentFile[0],Bitmap.Canvas,400);
    mnuRecentItem2.Caption := MinimizeName(EditorConfig.RecentFile[1],Bitmap.Canvas,400);
    mnuRecentItem3.Caption := MinimizeName(EditorConfig.RecentFile[2],Bitmap.Canvas,400);
    mnuRecentItem4.Caption := MinimizeName(EditorConfig.RecentFile[3],Bitmap.Canvas,400);
    mnuRecentItem5.Caption := MinimizeName(EditorConfig.RecentFile[4],Bitmap.Canvas,400);
  finally
    FreeAndNil(Bitmap);
  end;

end;

procedure TfrmEditorMain.mnuRecentItem1Click(Sender: TObject);
begin
  LoadROM(EditorConfig.RecentFile[TMenuItem(sender).MenuIndex],EditorConfig.FullDataFileName, EditorConfig.AutoCheck);
end;

procedure TfrmEditorMain.SetEmuMenuText();
begin
  if (EditorConfig.EmulatorPath <> '') and (FileExists(EditorConfig.EmulatorPath) = True) then
  begin
    mnuLaunchAssociatedEmulator.Caption := RES_LAUNCHEMU + ExtractFileName(EditorConfig.EmulatorPath);
    mnuLaunchAssociatedEmulator.Enabled := True;
  end
  else
  begin
    mnuLaunchAssociatedEmulator.Caption := RES_NOEMUASSOC;
    mnuLaunchAssociatedEmulator.Enabled := False;
  end;
  LoadEmulatorIcon;
  if Assigned(ROMData) = False then
    mnuLaunchAssociatedEmulator.Enabled := False;
end;

procedure TfrmEditorMain.BackupFile();
begin

  if DirectoryExists(ExtractFileDir(ParamStr(0))+'\Backups') = false then
  begin
    CreateDir(ExtractFileDir(ParamStr(0))+'\Backups');
  end;
  ShortDateFormat := 'dd-mm-yyyy';
  TimeSeparator	:= '-';

  AbZipper.FileName := ExtractFileDir(ParamStr(0))+'\Backups\MsPac ' + DateTimeToStr(Now) + '.zip';
  AbZipper.AddFiles(ROMData.Filename,0);
  AbZipper.ZipfileComment := RES_ZIPCREATEDON + DateTimeToStr(Now);
  AbZipper.Save;
end;

procedure TfrmEditorMain.actSaveROMExecute(Sender: TObject);
begin
  if EditorConfig.BackupFilesWhenSaving = True then
    BackupFile();
  if Assigned(ROMData)  then
  begin
    if ROMData.Save = True then
      messagebox(Handle,PChar(RES_CHANGESSAVED),PChar(APPLICATIONTITLE),0)
    else
      messagebox(Handle,PChar(RES_CHANGESAVEFAIL),PChar(APPLICATIONTITLE),0);
      UpdateTitleCaption();
  end;

end;

procedure TfrmEditorMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if assigned(ROMData) = True then
  begin

    if Key = VK_PRIOR	then
    begin
      if ROMData.Level = ROMData.NumberOfLevels - 1 then
        ROMData.Level := 0
      else
        ROMData.Level := ROMData.Level + 1;
    end
    else if Key = VK_NEXT	then
    begin
      if ROMData.Level = 0 then
        ROMData.Level := ROMData.NumberOfLevels - 1
      else
        ROMData.Level  := ROMData.Level - 1;
    end
    else
      exit;

    SetupLevel;
  end;
end;

procedure TfrmEditorMain.scrLevelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_PRIOR) or (Key = VK_NEXT) then
    Key := 0;
end;

procedure TfrmEditorMain.actObjectEditingModeExecute(Sender: TObject);
begin
  actObjectEditingMode.Checked := True;
  actSetMapEditingMode.Checked := False;
  // Set the toolbar buttons
  tlbMapEditingMode.Down := actSetMapEditingMode.Checked;
  tlbObjectEditingMode.Down := actObjectEditingMode.Checked;
  _EditingMode := OBJECTEDITINGMODE;
  Statusbar.Panels[0].Text := RES_OBJEDIT;
end;

procedure TfrmEditorMain.actSetMapEditingModeExecute(Sender: TObject);
begin
  actObjectEditingMode.Checked := False;
  actSetMapEditingMode.Checked := True;
  // Set the toolbar buttons
  tlbMapEditingMode.Down := actSetMapEditingMode.Checked;
  tlbObjectEditingMode.Down := actObjectEditingMode.Checked;
  _EditingMode := MAPEDITINGMODE;
  Statusbar.Panels[0].Text := RES_MAPEDIT;
end;

procedure TfrmEditorMain.ExecuteEmulator;
begin
  if Assigned(ROMData) = False then
  begin
    messagebox(handle,PChar(RES_LOADROMFIRST),PChar(Application.Title),0);
    exit;
  end;

  if (FileExists(EditorConfig.EmulatorPath) = false) or (EditorConfig.EmulatorPath = '') then
  begin
    messagebox(handle,PChar(RES_NOEMUASSOCIATED),PChar(Application.Title),0);
    exit;
  end;

  if EditorConfig.EmulatorDisplaySaveWarning = true then
    if MessageDlg(RES_WARNINGWILLSAVE + CRLF + CRLF + RES_WARNINGDISABLED,mtWarning,[mbYes, mbNo],0) = mrNo then
      exit;

  ROMData.Save;
  if EditorConfig.EmulatorFileSettings = 0 then
    ShellExecute(Handle,'open',PChar(EditorConfig.EmulatorPath),PChar(' ' + ROMData.Filename),'',SW_SHOW)
  else if EditorConfig.EmulatorFileSettings = 1 then
    ShellExecute(Handle,'open',PChar(EditorConfig.EmulatorPath),PChar(' ' + ExtractShortPathName(ROMData.Filename)),'',SW_SHOW)
  else if EditorConfig.EmulatorFileSettings = 2 then
    ShellExecute(Handle,'open',PChar(EditorConfig.EmulatorPath),PChar(' "' + ROMData.Filename + '"'),'',SW_SHOW);
end;

procedure TfrmEditorMain.mnuLaunchAssociatedEmulatorClick(
  Sender: TObject);
begin
  ExecuteEmulator();
end;

procedure TfrmEditorMain.actSaveAsIPSExecute(Sender: TObject);
var
  output : String;
begin
  if Assigned(ROMData) then
  begin
    if (FileExists(EditorConfig.OriginalROMFile) = true) then
    begin
      if EditorConfig.IPSOutput = '' then
        Output := ChangeFileExt(ROMData.Filename,'.ips')
      else
        Output := EditorConfig.IPSOutput;

      ROMData.Save;
      LunarIPSCreate(handle,PChar(Output),PChar(EditorConfig.OriginalROMFile),PChar(ROMData.Filename),0);
      UpdateTitleCaption;
    end;
  end;

end;

procedure TfrmEditorMain.UpdateTitleCaption;
var
  AppTitleBarText : String;
begin
  if Assigned(ROMData) = True then
  begin

    AppTitleBarText := APPLICATIONTITLE + ' - [' + ExtractFilename(ROMData.Filename) + ']';


    if ROMData.Changed = True then
    begin
      Caption := AppTitleBarText + ' *';
    end
    else
    begin
      Caption := AppTitleBarText;
    end;
  end
  else
  begin

    Caption := APPLICATIONTITLE


  end;
end;

procedure TfrmEditorMain.SetIPSEnabled;
begin
  if FileExists(EditorConfig.OriginalROMFile) = True then
    actSaveAsIPS.Enabled := True
  else
    actSaveAsIPS.Enabled := False;

  if Assigned(ROMData) = False then
    actSaveAsIPS.Enabled := False;
end;

procedure TfrmEditorMain.ClearImageIndex;
begin
  mnuMapEditingMode.ImageIndex := -1;
  mnuObjectEditingMode.ImageIndex := -1;
  mnuGridlines.ImageIndex := -1;
  mnuMirrorMaze.ImageIndex := -1;
end;

procedure TfrmEditorMain.JvDropTargetDragDrop(Sender: TJvDropTarget;
  var Effect: TJvDropEffect; Shift: TShiftState; X, Y: Integer);
var
  Files : TStringList;
begin
  Files := TStringList.Create;
  try
    sender.GetFilenames(Files);
    LoadROM(Files[0],EditorConfig.FullDataFileName,EditorConfig.AutoCheck);
  finally
    FreeAndNil(Files);
  end;

end;

procedure TfrmEditorMain.actCloseROMExecute(Sender: TObject);
begin
  CloseROM();
end;

procedure TfrmEditorMain.imgScreenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
  TileDrawX : Integer;
  TempX, TempY : Integer;
begin

  if _EditingMode = OBJECTEDITINGMODE then
  begin
    if (_Obj.ObjIndex > -1) then
    begin
      if (_Obj.ObjType = 1) and (mnuStartPosition.Checked = true) then
      begin
        if ssLeft in Shift then
        begin

          if (X >= imgScreen.Width) or (X < 0) then exit;
          if (Y >= imgScreen.Height) or (Y < 0) then exit;

          if ssCtrl in Shift then
          begin
            TempX := X div 2;
            TempY := Y div 2;
          end
          else
          begin
            TempX := (X div 2) and $F8;
            TempY := (Y div 2) and $FE;
          end;

          if ROMData.MsPacmanStartX  <> TempX then
          begin
            ROMData.MsPacmanStartX := TempX;
            ROMData.Changed := True;
          end;
          if ROMData.MsPacmanStartY <> TempY then
          begin
            ROMData.MsPacmanStartY := TempY;

            if ROMData.MsPacmanStartY > $EF then
              ROMData.MsPacmanStartY := $EF;
              
            ROMData.Changed := True;
          end;

          DrawLevelData;
          UpdateTitleCaption;

        end;
      end
    end;
  end
  else if (_EditingMode = MAPEDITINGMODE) and
    ( (X >= 0) and (X < imgScreen.Width) and (y >= 0) and (y < imgScreen.Height) ) then
  begin

    if ssLeft in Shift then
    begin
      if ssShift in Shift then
        ROMData.RoomData[(x div 2) div 8,(y div 2) div 8] := _CurTileMid
      else
        ROMData.RoomData[(x div 2) div 8,(y div 2) div 8] := _CurTileLeft;

      if EditorConfig.MirrorLevels = True then
      begin

        TileDrawX := 21-  ( (x div 2) div 8 );

        if ssShift in Shift then
          ROMData.RoomData[TileDrawX,(y div 2) div 8] := MirrorConfig.MirrorSettings[_CurTileMid]
        else
          ROMData.RoomData[TileDrawX,(y div 2) div 8] := MirrorConfig.MirrorSettings[_CurTileLeft];
      end;
    
      DrawLevelData();
    end
    else if ssRight in Shift then
    begin
      if ssShift in Shift then
        _CurTileMid := ROMData.RoomData[(x div 2) div 8,(y div 2) div 8]
      else
        _CurTileLeft := ROMData.RoomData[(x div 2) div 8,(y div 2) div 8];
    end
    else if ssMiddle in Shift then
    begin
      if ssShift in Shift then
        _CurTileMid := ROMData.RoomData[(x div 2) div 8,(y div 2) div 8]
      else
        ROMData.RoomData[(x div 2) div 8,(y div 2) div 8] := _CurTileMid;

      if EditorConfig.MirrorLevels = True then
      begin
        TileDrawX := 21-  ( (x div 2) div 8 );
        ROMData.RoomData[TileDrawX,(y div 2) div 8] := MirrorConfig.MirrorSettings[_CurTileMid]
      end;

      DrawLevelData();
    end;
  end;

end;

procedure TfrmEditorMain.imgScreenMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if _EditingMode = OBJECTEDITINGMODE then
  begin
    _Obj.ObjIndex := -1;
    _Obj.ObjType := -1;
    UpdateTitleCaption;



//    _MouseDownX := -1;
//    _MouseDownY := -1;
  end;
end;

procedure TfrmEditorMain.actKeyboardLayoutExecute(Sender: TObject);
var
  KeyboardLayout : TfrmKeyboardLayout;
begin
  KeyboardLayout := TfrmKeyboardLayout.Create(self);
  try
    JvDropTarget1.AcceptDrag := False;
    KeyboardLayout.ShowModal;
    JvDropTarget1.AcceptDrag := True;
  finally
    FreeAndNil(KeyboardLayout);
  end;

end;

procedure TfrmEditorMain.mnuVisitRockAndRollHomepageClick(
  Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar('http://dan.panicus.org'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmEditorMain.RedrawScreen;
begin
  ROMData.RefreshOnScreenTiles();
  DrawLevelData();
  DrawTileSelector();
end;

procedure TfrmEditorMain.mnuExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmEditorMain.actGoToLevelExecute(Sender: TObject);
var
  GoToLevel : TfrmGotoLevel;
begin
  GotoLevel := TfrmGotoLevel.Create(self);
  try
    JvDropTarget1.AcceptDrag := False;
    if GotoLevel.ShowModal = mrOk then
    begin
      if GotoLevel.Level <> ROMData.Level then
      begin
        ROMData.Level := GotoLevel.Level;
        SetupLevel();
      end;

    end;
    JvDropTarget1.AcceptDrag := True;
  finally
    FreeAndNil(GotoLevel);
  end;
end;

procedure TfrmEditorMain.actDebugROMViewerExecute(Sender: TObject);
var
  DebugROM : TfrmDebugROMViewer;
begin
  DebugROM := TfrmDebugROMViewer.Create(self);
  try
    JvDropTarget1.AcceptDrag := False;
    DebugROM.ShowModal;
    JvDropTarget1.AcceptDrag := True;
  finally
    FreeAndNil(DebugROM);
  end;
end;

procedure TfrmEditorMain.mnuStartPositionClick(Sender: TObject);
begin
  DrawLevelData();
end;

procedure TfrmEditorMain.actBackupManagerExecute(Sender: TObject);
var
  Backup : TfrmBackupManagement;
begin
  Backup := TfrmBackupManagement.Create(self);
  try
    JvDropTarget1.AcceptDrag := False;
    Backup.ShowModal;
    JvDropTarget1.AcceptDrag := True;
  finally
    FreeAndNil(Backup);
  end;
end;

procedure TfrmEditorMain.actPropertiesExecute(Sender: TObject);
var
  Prop : TfrmFileProperties;
begin
  Prop := TfrmFileProperties.Create(self);
  try
    JvDropTarget1.AcceptDrag := False;
    Prop.ShowModal;
    JvDropTarget1.AcceptDrag := True;
    UpdateTitleCaption;
  finally
    FreeAndNil(Prop);
  end;
end;

procedure TfrmEditorMain.actEnableGridlinesExecute(Sender: TObject);
begin
  EditorConfig.GridlinesOn := not(EditorConfig.GridlinesOn);
  tlbEnableGridlines.Down := EditorConfig.GridlinesOn;
  mnuGridlines.Checked := EditorConfig.GridlinesOn;
  DrawLevelData();
end;

function TfrmEditorMain.AutoCheckROMType(pFilename : String) : String;
var
  DataFiles : TStringList;
  INI : TMemINIHexFile;
  i : Integer;
  Loc : Integer;
  Auto1,Auto2,Auto3,Auto4 : Byte;
  TempROM : TiNESImage;
begin
  result := '';
  DataFiles := TStringList.Create;
  try
    DataFiles.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Resources\data.dat');

    for i := 0 to DataFiles.Count -1 do
    begin
      INI := TMemINIHexFile.Create(ExtractFileDir(Application.ExeName) + '\Resources\' + DataFiles[i]);
      try
        Loc := INI.ReadHexValue('AutoCheck','Location');
        Auto1 := INI.ReadHexValue('AutoCheck','Auto1');
        Auto2 := INI.ReadHexValue('AutoCheck','Auto2');
        Auto3 := INI.ReadHexValue('AutoCheck','Auto3');
        Auto4 := INI.ReadHexValue('AutoCheck','Auto4');
        TempROM := TiNESImage.Create(pFilename);
        if TempROM.ROM[Loc] = Auto1 then
          if TempROM.ROM[Loc+1] = Auto2 then
            if TempROM.ROM[Loc+2] = Auto3 then
              if TempROM.ROM[Loc+3] = Auto4 then
              begin
                result := DataFiles[i];
                break;
              end;
      finally
        FreeAndNil(TempROM);
        FreeAndNil(INI);
      end;
    end;
  finally
    FreeAndNil(DataFiles);
  end;

end;

procedure TfrmEditorMain.LoadEmulatorIcon;
var
  Icon : TIcon;
  Buffer: array[0..2048] of char;
  IconHandle: HIcon;
  IconIndex : word;
begin
  if (FileExists(EditorConfig.EmulatorPath) = True) and (FileExists(ExtractFileDir(Application.Exename) + '\emu.ico')) then
  begin

    //get the associated icon for this file
    StrCopy(@Buffer, pchar(EditorConfig.EmulatorPath));
    IconIndex := 0;
    IconHandle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);

    begin

      //now that we have an icon, add it to the image list.
      Icon := TIcon.Create;
      try
        Icon.Handle := IconHandle;
        mnuLaunchAssociatedEmulator.ImageIndex := ImageList.AddIcon(Icon);
      finally
        FreeAndNil(Icon);
      end;

    end;
  end
  else
  begin
    // Insert the number of the default NES emulator icon here.
    mnuLaunchAssociatedEmulator.ImageIndex := 7;
  end;

end;

procedure TfrmEditorMain.actDistributeHackExecute(Sender: TObject);
var
  Distrib : TfrmDistribution;
begin
  Distrib := TfrmDistribution.Create(self);
  try
    Distrib.ShowModal;
  finally
    FreeAndNil(Distrib);
  end;
end;



procedure TfrmEditorMain.actStartingStageExecute(Sender: TObject);
var
  StartStage : TfrmStartingStage;
begin
  StartStage := TfrmStartingStage.Create(self);
  try
    StartStage.ShowModal;
  finally
    FreeAndNil(StartStage);
  end;
end;

procedure TfrmEditorMain.DisplayPellet;
begin
  statusbar.Panels[2].text :=  uresourcestrings.RES_PELLETCOUNT + ' ' + IntToStr(ROMData.CurrentLevel.PelletCount);
end;

procedure TfrmEditorMain.actLevelInfoExecute(Sender: TObject);
var
  LevelInfo : TfrmLevelInfo;
begin
  LevelInfo := TfrmLevelInfo.Create(self);
  try
    LevelInfo.ShowModal;
  finally
    FreeAndNil(LevelInfo);
  end;
end;

procedure TfrmEditorMain.actIndentLevelExecute(Sender: TObject);
begin
  if ROMData.CurrentLevel.IndentLevel = true then
    ROMData.Changed := True;

  DrawLevelData;
  UpdateTitleCaption;
end;

procedure TfrmEditorMain.actCreateGhostTrapExecute(Sender: TObject);
begin
  if ROMData.CurrentLevel.AddGhostTrap = true then
    ROMData.Changed := True;

  DrawLevelData;
  UpdateTitleCaption;
end;

procedure TfrmEditorMain.actMirroringModeExecute(Sender: TObject);
begin
  EditorConfig.MirrorLevels := not(EditorConfig.MirrorLevels);
  tlbMirroringMode.Down := EditorConfig.MirrorLevels;
  mnuMirrorMaze.Checked := EditorConfig.MirrorLevels;
  DrawLevelData();
end;

procedure TfrmEditorMain.actEraseLevelExecute(Sender: TObject);
begin
  ROMData.CurrentLevel.ClearLevel($00);
  ROMData.Changed := True;
  DrawLevelData();
  UpdateTitleCaption;
end;

procedure TfrmEditorMain.actEraseLevelPelletsExecute(Sender: TObject);
begin
  ROMData.CurrentLevel.ClearLevel($03);
  ROMData.Changed := True;
  DrawLevelData();
  UpdateTitleCaption;
end;

procedure TfrmEditorMain.actPaletteExecute(Sender: TObject);
var
  Pal : TfrmPaletteEditor;
begin
  Pal := TfrmPaletteEditor.Create(self);
  try
    if Pal.ShowModal = mrOk then
    begin
      UpdateTitleCaption;
      RedrawScreen;
    end;
  finally
    FreeAndNil(Pal);
  end;
end;

procedure TfrmEditorMain.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize := False;
end;

procedure TfrmEditorMain.actImportLevelExecute(Sender: TObject);
var
  Import : TfrmImportLevels;
begin
  Import := TfrmImportLevels.Create(self);
  try
    if Import.ShowModal = mrOk then
    begin
      UpdateTitleCaption;
      RedrawScreen;
    end;
  finally
    FreeAndNil(Import);
  end;
end;

procedure TfrmEditorMain.actExportLevelExecute(Sender: TObject);
var
  ExportLvl : TfrmExportLevels;
begin
  ExportLvl := TfrmExportLevels.Create(self);
  try
    ExportLvl.ShowModal;
  finally
    FreeAndNil(ExportLvl);
  end;
end;

procedure TfrmEditorMain.actValuesEditorExecute(Sender: TObject);
var
  Val : TfrmStartingLives;
begin
  Val := TfrmStartingLives.Create(self);
  try
    Val.ShowModal;
    UpdateTitleCaption;
  finally
    FreeAndNil(Val);
  end;
end;

procedure TfrmEditorMain.actMirrorEditorExecute(Sender: TObject);
var
  fMirrorEditor : TfrmMirrorEditor;
begin
  fMirrorEditor := TfrmMirrorEditor.Create(self);
  try
    fMirrorEditor.ShowModal;
  finally
    FreeAndNil(fMirrorEditor);
  end;
end;

end.
