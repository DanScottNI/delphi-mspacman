unit cROMdata;

interface

uses gr32,ImgList,GR32_Image, dialogs, forms, classes, bytelist, offsetlist,
  cLevel,Types,cFreeSpace,pasCRC32, ROMObj, iNESImage;

type

  TImportResult = (irGood = 0,irHeaderBad = 1,irUnsupportedVersion =2 );

  TLevelHeaderInfo = record
    Name : String;
    Description : String;
    Author : String;
    Homepage : String;
  end;

  TWidthHeight = record
    Width : Integer;
    Height : Integer;
  end;

  T8x8Graphic = record
    Pixels : Array [0..7, 0..7] of Byte;
  end;

  TObjDetect = record
    ObjType : integer;
    ObjIndex : Integer;
  end;

  TROMData = class(TiNESImageAccessor)
  private
    _Tiles : TBitmap32;
    _DataFile : String;
    _PatternTable : Array [0.. 4095] of Byte;
    _Palette : Array [0..7,0..3] of Byte;
    _TitlePal : Array [0..7,0..3] of Byte;
    _Level : Integer;
    _DrawTiles : Array [0..255] Of Boolean;
    _NumberOfLevels : Byte;
    _ASMHackCodeSize : Byte;
    _ASMHackJSR : Integer;
    _ASMHackPal : Integer;
    _MsPacmanStartX : Integer;
    _MsPacmanStartY : Integer;
    // functions
    function GetChanged(): Boolean;
    function GetTitlePalette(pIndex1,pIndex2 : Integer) : Byte;
    function GetPalette(pIndex1,pIndex2 : Integer) : Byte;
    function GetROMFilename(): String;
    function GetRoomData(pIndex,pIndex1 : Integer): Byte;
    function GetColor32NESPal(pElement: Integer): TColor32;
    // procedures
    procedure DrawLevelTile(pIndex : Integer);
    procedure LoadColonSeparatedFile(pStringList : TStringList;pFilename : String);
    procedure LoadDataFile();
    procedure LoadRoomTiles();
    procedure SetChanged(pChanged: Boolean);
    procedure SetLevel(pLevel : Integer);
    procedure SetRoomData(pIndex,pIndex1 : Integer; pData : Byte);
    procedure SetTitlePalette(pIndex1,pIndex2 : Integer;pNewTile : Byte);
    procedure SetPalette(pIndex1,pIndex2 : Integer;pNewTile : Byte);
    procedure DecompressLevels;overload;
    function CompressLevels : Boolean;
    procedure LoadStartingPositions;
    procedure SaveStartingPositions;
    procedure DumpDecompressedLevels;
  public
    Properties : T1BytePropertyList;
    Levels : TLevelList;
    CurrentLevel : TLevel;
    FreeSpace : TFreeSpaceList;
    // constructor(s)
    constructor Create(pFilename, pDataFile : String);
    // destructor
    destructor Destroy;override;
    // functions
    function Export8x8Pat(pID: Integer) : T8x8Graphic;
    function IsValidROM(): Boolean;
    function GetRectTileNumber(pIndex : Byte) : TRect;
    function Save: Boolean;
    function SaveAs(pFilename : String): Boolean;
    function CHRCount : Byte;
    function PRGCount : Byte;
    function MemoryMapper : Byte;
    function MemoryMapperStr : String;
    function FileSize : Integer;
    function DiskDudePresent : Boolean;
    function LevelOffset(pStageID : Integer) : Integer;
    function InstallPalASMHack() : Boolean;
    function DetectObjectUnderMouse(pX,pY : Integer) : TObjDetect;
    function ImportLevelInformation(pFilename : String) : TLevelHeaderInfo;
    function GetScoreDigit(pIndex : Integer) : Byte;
    procedure DecompressLevels(pOffset : integer);overload;
    procedure SetScoreDigit(pIndex : Integer;pValue : Byte);
    // procedures
    procedure DrawCurrentScreen(pBitmap : TBitmap32;pFilter : Byte;pBitmap32List : TBitmap32List);
    procedure DrawTileSelector(pBitmap : TBitmap32);
    procedure DumpPatternTable(pFilename : String);
    procedure Import8x8Pat(pID: Integer; p8x8: T8x8Graphic);
    procedure LoadBGPalette();
    procedure LoadDefaultPalette;
    procedure LoadPaletteFile(pPaletteFile : String);
    procedure LoadPatternTable();
    procedure RefreshOnScreenTiles();
    procedure SaveBGPalette();
    procedure LoadTitlePalette;
    procedure SaveTitlePalette;
    procedure SavePatternTable();
    procedure RestoreDefaultiNESHeader;
    function ImportLevel(pFilename : String; pLevelToReplace : Integer) : TImportResult;
    procedure ExportLevel(pFilename : String; pLevelToExport : Byte;
      pLevelName,pLevelDesc,pLevelAuthor,pLevelHomepage : String);
    procedure DrawByteArray(pBitmap : TBitmap32;pByteArray : Array Of Byte);
    procedure DrawImportLevel(pBitmap : Tbitmap32;pFilename : String);
    // properties
    property Changed : Boolean read GetChanged write SetChanged;
    property Level : Integer read _Level write SetLevel;
    property DataFile : String read _DataFile write _DataFile;
    property Filename : String read GetROMFilename;
    property NumberOfLevels : Byte read _NumberOfLevels write _NumberOfLevels;
    property Palette[index1,index2 : Integer] : Byte read GetPalette write SetPalette;
    property TitlePalette[index1,index2 : Integer] : Byte read GetTitlePalette write SetTitlePalette;
    property RoomData[index1 : integer;index2 : Integer] : Byte read GetRoomData write SetRoomData;
    property NESPal [index : Integer] : TColor32 read GetColor32NESPal;
    property MsPacmanStartX : Integer read _MsPacmanStartX write _MsPacmanStartX;
    property MsPacmanStartY : Integer read _MsPacmanStartY write _MsPacmanStartY;
  end;

implementation

uses sysutils,MemINIHexFile;

const
  UNKNOWNENEMY : String = 'N\A';

{ TROMData }

constructor TROMData.Create(pFilename, pDataFile : String);
begin
  ROM := TiNESImage.Create(pFilename);

  _DataFile := pDataFile;
  LoadDataFile();
  DecompressLevels;
  LoadStartingPositions;
//  dumpdecompressedlevels;
  self._Level := -1;
  LoadTitlePalette;
//  self._Palette[0] := $0F;
//  self._Palette[1] := $0F;
//  self._Palette[2] := $1a;
//  self._Palette[3] := $27;
end;

procedure TROMData.LoadColonSeparatedFile(pStringList : TStringList;pFilename : String);
var
  ColonFile : TStringList;
  Index : String;
  i, count : Integer;
begin

  for i := 0 to 255 do
    pStringList.Add('$' + IntToHex(i,2) + ' - ' +  UNKNOWNENEMY);

  // Now load in the enemy names from the file 'enemy.dat' in the data directory.
  if FileExists(pFilename) = True then
  begin
    ColonFile := TStringList.Create;
    ColonFile.LoadFromFile(pFilename);

    for i := 0 to ColonFile.Count - 1 do
    begin
      if copy(ColonFile[i],1,2) <> '//' then
      begin
        count := 1;
        Index := '';
        while ((ColonFile[i][count] <> ':') or (count = length(ColonFile[i]))) do
        begin
          Index := Index + ColonFile[i][count];
          inc(Count);
        end;
        inc(Count);
        pStringList[StrToInt('$' + Index)] := '$' + Index + ' - ' + copy(ColonFile[i],Count,Length(ColonFile[i]) - count +1);
      end;

    end;

  end;
  FreeAndNil(ColonFile);

end;

destructor TROMData.Destroy;
begin
  FreeAndNil(ROM);
  FreeAndNil(_Tiles);
  FreeAndNil(Properties);
  FreeAndNil(Levels);
  FreeAndNil(FreeSpace);
  inherited;
end;

procedure TROMData.LoadDataFile();
var
  INI : TMemINIHexFile;
  i : Integer;
begin

  INI := TMemINIHexFile.Create(_DataFile);
  try
    if Assigned(self.Properties) then
      FreeAndNil(Properties);

    Properties := T1BytePropertyList.Create(True);
    Properties.Capacity := 3;
    Properties.Add(T1ByteProperty.Create('LevelPointers',INI.ReadHexValue('General','LevelPointers') ));
    Properties.Add(T1ByteProperty.Create('StartStage',INI.ReadHexValue('General','StartStage') ));
    Properties.Add(T1ByteProperty.Create('StartingLives',INI.ReadHexValue('General','StartingLives') ));
    Properties.Add(T1ByteProperty.Create('ASMHackInstallOffset',INI.ReadHexValue('General','ASMHackInstallOffset') ));
    Properties.Add(T1ByteProperty.Create('StartingScore',INI.ReadHexValue('General','StartingScore') ));
    Properties.Add(T1ByteProperty.Create('StartingPosX',INI.ReadHexValue('General','StartingPosX') ));
    Properties.Add(T1ByteProperty.Create('StartingPosY',INI.ReadHexValue('General','StartingPosY') ));
    Properties.Add(T1ByteProperty.Create('PalettePointer',INI.ReadHexValue('General','PalettePointer') ));
    Properties.Add(T1ByteProperty.Create('TitlePalettePointer',INI.ReadHexValue('General','TitlePalettePointer') ));

    _ASMHackCodeSize :=INI.ReadHexValue('General','ASMHackCodeSize');
    _ASMHackJSR := INi.ReadHexValue('General','ASMHackJSR');
    _ASMHackPal := INI.ReadHexValue('General','ASMHackPalLoc');

    _NumberOfLevels := INI.ReadInteger('General','NumberOfLevels');

    if Assigned(Levels) then
      FreeAndNil(Levels);

    Levels := TLevelList.Create(true);
    Levels.Capacity := _NumberOfLevels;

    for i := 0 to _NumberOfLevels - 1 do
    begin
      Levels.Add(TLevel.Create);
      Levels.Last.LevelID := i; 
    end;

    if Assigned(FreeSpace) then
      FreeAndNil(FreeSpace);

    FreeSpace := TFreeSpaceList.Create(true);
    FreeSpace.Capacity := INI.ReadInteger('FreeSpace','NumberOfFreeSpace');

    for i := 0 to FreeSpace.Capacity - 1 do
    begin
      FreeSpace.Add(TFreeSpace.Create);
      FreeSpace.Last.StartOffset := INI.ReadHexValue('FreeSpace','FreeSpace' + IntToStr(i) + 'Offset');
      FreeSpace.Last.EndOffset := INI.ReadHexValue('FreeSpace','FreeSpace' + IntToStr(i) + 'EndOffset');
    end;

  finally
    FreeAndNil(INI);
  end;

end;

function TROMData.Save(): Boolean;
begin
  if   CompressLevels = false then
  begin
    result := false;
    exit;
  end;
  SaveBGPalette;
  SaveTitlePalette;
  SaveStartingPositions;
  result := ROM.Save;

end;

function TROMData.SaveAs(pFilename : String) : Boolean;
begin
  result := ROM.SaveAs(pFilename);
end;

procedure TROMData.LoadPatternTable();
var
  Offset,i : Integer;
begin
  offset := (ROM.PRGCount * $4000) + $10;

  for i := 0 to High(_PatternTable) do
    _PatternTable[i] := ROM[offset + i];

//  DumpPatternTable(ExtractFileDir(Application.Exename) + '\test.nes');
end;

procedure TROMData.SavePatternTable();
var
  Offset,i : Integer;
begin
  offset := (ROM.PRGCount * $4000) + $10;

  for i := 0 to High(_PatternTable) do
    ROM[offset + i] := _PatternTable[i];


end;

procedure TROMData.DumpPatternTable(pFilename : String);
var
  Mem : TMemoryStream;
begin
  Mem := TMemoryStream.Create;
  try
    Mem.Write(_PatternTable[0],4096);
    Mem.SaveToFile(pFilename);
  finally
    FreeAndNil(Mem);
  end;
end;

procedure TROMData.LoadBGPalette();
var
  offset,i,x : Integer;
begin
  offset := Properties['ASMHackInstallOffset'].Offset + _ASMHackPal + (self._Level * 4);

  for i := 0 to 3 do
    self._Palette[0,i] :=  ROM[offset+i];


  offset :=  ROM.PointerToOffset(Properties['PalettePointer'].Offset);

  for i := 1 to 7 do
    for x := 0 to 3 do
      _Palette[i,x] := ROM[offset + (i*4) + x];

end;

procedure TROMData.SaveBGPalette();
var
  offset,i,x : Integer;
begin
  offset := Properties['ASMHackInstallOffset'].Offset + _ASMHackPal + (self._Level * 4);

  for i := 0 to 3 do
    ROM[offset+i] := self._Palette[0,i];

  offset :=  ROM.PointerToOffset(Properties['PalettePointer'].Offset);

  for i := 1 to 7 do
    for x := 0 to 3 do
      ROM[offset + (i*4) + x] := _Palette[i,x];

end;

procedure TROMData.LoadTitlePalette;
var
  offset,i,x : Integer;
begin

  offset :=  ROM.PointerToOffset(Properties['TitlePalettePointer'].Offset);

  for i := 0 to 7 do
    for x := 0 to 3 do
      _TitlePal[i,x] := ROM[offset + (i*4) + x];

end;

procedure TROMData.SaveTitlePalette;
var
  offset,i,x : Integer;
begin

  offset :=  ROM.PointerToOffset(Properties['TitlePalettePointer'].Offset);

  for i := 0 to 7 do
    for x := 0 to 3 do
      ROM[offset + (i*4) + x] := _TitlePal[i,x];

end;

procedure TROMData.SetLevel(pLevel : Integer);
var
  i : Integer;
begin

  self._Level := pLevel;

  CurrentLevel := Levels[pLevel];

  // Reinitialise DrawTiles
  for i := 0 to 255 do
    _DrawTiles[i] := False;


  if Assigned(_Tiles) = False then
    _Tiles := TBitmap32.Create;

  _Tiles.Width := $FF * 8;
  _Tiles.Height := 8;
  LoadPatternTable();
  LoadBGPalette();

  LoadRoomTiles;

end;

// This function iterates through the current screen's level data
// and fills in the tiles that haven't yet been drawn onto to the
// tiles bitmap.
procedure TROMData.LoadRoomTiles();
var
  i : integer;
begin
  for i := 0 to $3f do
    DrawLevelTile(i);



end;

procedure TROMData.DrawLevelTile(pIndex : Integer);
begin
  if Assigned(_Tiles) = False then
    exit;
  ROM.DrawNESTile(  @_PatternTable[pIndex * $10],_Tiles,pIndex * 8,0,@_Palette[0]);

end;

procedure TROMData.DrawCurrentScreen(pBitmap : TBitmap32; pFilter : Byte;pBitmap32List : TBitmap32List);
var
  i,x : Integer;
begin
  for i := 0 to 26 do
    for x := 0 to 21 do
      pBitmap.Draw(bounds(x*8,i*8,8,8),bounds(Levels[self._Level].UncompressedBuffer[(i * 22) + x] * 8,0,8,8),_tiles);

  pBitmap.Draw(_MsPacmanStartX,_MsPacmanStartY,pBitmap32List[2]);

end;

procedure TROMData.DrawByteArray(pBitmap : TBitmap32;pByteArray : Array Of Byte);
var
  i,x : Integer;
begin
  for i := 0 to 26 do
    for x := 0 to 21 do
      pBitmap.Draw(bounds(x*8,i*8,8,8),bounds(pByteArray[(i * 22) + x] * 8,0,8,8),_tiles);

end;

function TROMData.GetRoomData(pIndex,pIndex1 : Integer): Byte;
begin

  result := CurrentLevel.UncompressedBuffer[(pIndex1 * 22) + pIndex];

end;

procedure TROMData.SetRoomData(pIndex,pIndex1 : Integer; pData : Byte);

begin

  CurrentLevel.UncompressedBuffer[(pIndex1 * 22) + pIndex] := pData;
  ROM.Changed := True;
end;

procedure TROMData.DrawTileSelector(pBitmap : TBitmap32);
var
  i,x : Integer;
begin
  if Assigned(_Tiles) = False then
    exit;
  for i := 0 to 15 do
    for x := 0 to 3 do
      pBitmap.Draw(bounds(x*8,i*8,8,8),bounds(((i * 4) + x) * 8,0,8,8),_tiles);


end;

procedure TROMData.RefreshOnScreenTiles;
var
  i : integer;
begin

  // Reset all the tiles back to the false drawing state.
  for i := 0 to high(_DrawTiles) do
    _DrawTiles[i] := false;

  LoadRoomTiles();

end;

procedure TROMData.LoadPaletteFile(pPaletteFile : String);
begin
  ROM.LoadPaletteFile(pPaletteFile);
end;

procedure TROMData.LoadDefaultPalette;
begin
  ROM.LoadDefaultPalette;
end;

function TROMData.GetROMFilename(): String;
begin
  result := ROM.Filename;
end;

procedure TROMData.SetChanged(pChanged: Boolean);
begin
  ROM.Changed := pChanged;
end;

function TROMData.GetChanged(): Boolean;
begin
  result := ROM.Changed;
end;



function TROMData.Export8x8Pat(pID: Integer) : T8x8Graphic;
var
  x,y : Integer;
  curBit, curBit2 : Char;
  TempBin1,TempBin2, TempBin3 : String;
  Tile1 : Array [0..15] of Byte;
  p8x8 : T8x8Graphic;
begin
  For y := 0 To 15 do
    Tile1[y] := self._PatternTable[(pID * 16) +y];

  for y := 0 to 7 do
  begin
    TempBin1 := ROM.ByteToBin(Tile1[y]);
    TempBin2 := ROM.ByteToBin(Tile1[y + 8]);
    for x := 0  to 7 do
    begin
      CurBit := TempBin1[x + 1];
      CurBit2 := TempBin2[x + 1];
      TempBin3 := CurBit + CurBit2;

      if TempBin3 = '00' Then
        p8x8.Pixels[y,x] := 0
      else if TempBin3 = '10' Then
        p8x8.Pixels[y,x] := 1
      else if TempBin3 = '01' Then
        p8x8.Pixels[y,x] := 2
      else if TempBin3 = '11' Then
        p8x8.Pixels[y,x] := 3;
    end;
  end;
  result := p8x8;
end;


procedure TROMData.Import8x8Pat(pID: Integer; p8x8: T8x8Graphic);
var
  x,y : Integer;
  TempBin1, TempBin2 : String;
  Tile1 : Array [0..15] of Byte;
begin
  For y := 0 To 15 do
    Tile1[y] := self._PatternTable[(pID * 16) +y];

  for y := 0 to 7 do
  begin
    for x := 0  to 7 do
    begin

      TempBin1 := IntToStr(p8x8.Pixels[y,x] and 1) + TempBin1;
      TempBin2 := IntToStr(p8x8.Pixels[y,x] shr 1) + TempBin2;


    end;

    self._PatternTable[(pID * 16) +y] := ROM.BinToByte(TempBin1);
    self._PatternTable[(pID * 16) +y + 8] := ROM.BinToByte(TempBin2);

  end;
end;

function TROMData.GetColor32NESPal(pElement: Integer): TColor32;
begin
  result := ROM.NESPal[pElement];
end;

procedure TROMData.SetPalette(pIndex1,pIndex2 : Integer;pNewTile : Byte);
begin
  self._Palette[pIndex1,pIndex2] := pNewTile;
end;

function TROMData.GetPalette(pIndex1,pIndex2 : Integer) : Byte;
begin
  result := self._Palette[pIndex1,pIndex2];
end;

procedure TROMData.SetTitlePalette(pIndex1,pIndex2 : Integer;pNewTile : Byte);
begin
  self._TitlePal[pIndex1,pIndex2] := pNewTile;
end;

function TROMData.GetTitlePalette(pIndex1,pIndex2 : Integer) : Byte;
begin
  result := self._TitlePal[pIndex1,pIndex2];
end;

function TROMData.CHRCount : Byte;
begin
  result := ROM.CHRCount;
end;

function TROMData.PRGCount : Byte;
begin
  result := ROM.PRGCount;
end;

function TROMData.MemoryMapper : Byte;
begin
  result := ROM.MapperNumber;
end;

function TROMData.MemoryMapperStr : String;
begin
  result := ROM.MapperName;
end;

function TROMData.FileSize : Integer;
begin
  result := ROM.ROMSize;
end;

function TROMData.IsValidROM(): Boolean;
var
  Mapper,PRG,CHR : Integer;
  INI : TMemINIHexFile;
begin
  INI := TMemINIHexFile.Create(self._Datafile);
  try
    Mapper := INI.ReadInteger('Mapper','MapperNum',0);
    PRG := INI.ReadInteger('Mapper','PRGSize',2);
    CHR := INI.ReadInteger('Mapper','CHRSize',1);
    result := true;
    if ROM.ValidImage = False then
      result := false
    else if Mapper <> ROM.MapperNumber then
      result := false
    else if PRG <> ROM.PRGCount then
      result := false
    else if CHR <> ROM.CHRCount then
      result := false;
  finally
    freeandNil(INI);
  end;
end;

procedure TROMData.RestoreDefaultiNESHeader;
var
  Mapper,PRG,CHR,Vertical : Integer;
  INI : TMemINIHexFile;
begin
  INI := TMemINIHexFile.Create(self._Datafile);
  try
    Mapper := INI.ReadInteger('Mapper','MapperNum',0);
    PRG := INI.ReadInteger('Mapper','PRGSize',2);
    CHR := INI.ReadInteger('Mapper','CHRSize',1);
    Vertical := INI.ReadInteger('Mapper','Vertical',0);
    ROM[0] := $4E;
    ROM[1] := $45;
    ROM[2] := $53;
    ROM[3] := $1A;
    ROM[4] := PRG;
    ROM[5] := CHR;
    ROM[6] := ((Mapper and $0F) Shl 4) + Vertical;
    ROM[7] := (Mapper and $F0);
    ROM[8] := $00;
    ROM[9] := $00;
    ROM[10] := $00;
    ROM[11] := $00;
    ROM[12] := $00;
    ROM[13] := $00;
    ROM[14] := $00;
    ROM[15] := $00;
  finally
    freeandNil(INI);
  end;

end;

function TROMData.DiskDudePresent : Boolean;
begin
  result := ROM.DiskDudePresent;
end;

procedure TROMData.DecompressLevels;
var
  i,x,offset,count  : integer;
  repeatbyte,tile : Byte;
begin

  for i := 0 to Levels.Count -1 do
  begin
    offset := ROM.PointerToOffset(  Properties['LevelPointers'].Offset + (Levels[i].LevelID) * 2,0,$8000);

    count := 0;

    while (count < 594) do
    begin
      repeatbyte := ROM[offset] div $40;
      tile := ROM[offset] mod $40;

      for x := 0 to repeatbyte do
        Levels[i].UncompressedBuffer[count + x] := tile;

      inc(count,repeatbyte + 1);
      inc(offset);
    end;

    levels[i].CompressedSize := offset - ROM.PointerToOffset(Properties['LevelPointers'].Offset + (Levels[i].LevelID) * 2,0,$8000);

  end;

end;

procedure TROMData.DecompressLevels(pOffset : Integer);
var
  i,x,offset, toffset,count, TempInt,size  : integer;
  repeatbyte,tile,output : Byte;
  Mem : TMemoryStream;
  TempStr : String;

begin

    Mem := TMemoryStream.Create;
    try
      // Write the header file.
      TempStr := 'BLINKY';
      Mem.Write(TempStr[1],6);

      // Write the version number
      TempInt := 1;
      Mem.Write (TempInt,1);

      // Write a blank offset.
      Offset := 0;
      Mem.Write(Offset,4);

      // Write the level name size
      TempStr := 'Offset Export';
      size := Length(TempStr);
      Mem.Write(Size,1);
      Mem.Write (TempStr[1],Length(TempStr));

      // Write the level description
      TempStr := 'n/a';
      size := Length(TempStr);
      Mem.Write(Size,1);

      Mem.Write (TempStr[1],Length(TempStr));

      // Write the level author
      TempStr := 'Blinky';
      size := Length(TempStr);
      Mem.Write(Size,1);
      Mem.Write (TempStr[1],Length(TempStr));

    // Write the level homepage
    TempStr := 'http://dan.panicus.org';
    size := Length(TempStr);
    Mem.Write(Size,1);
    Mem.Write (TempStr[1],Length(TempStr));

    tOffset := Mem.Position;

    offset := pOffset;

    count := 0;

    while (count < 594) do
    begin
      repeatbyte := ROM[offset] div $40;
      tile := ROM[offset] mod $40;

      for x := 0 to repeatbyte do
      begin
        output := tile;
        Mem.write(output,1);
      end;
      inc(count,repeatbyte + 1);
      inc(offset);
    end;
    Mem.Seek(7,soFromBeginning);

    Mem.Write(tOffset,4);

    Mem.SaveToFile('extract.pac');
    
  finally
    FreeAndNil(Mem);
  end;

end;

procedure TROMData.DumpDecompressedLevels;
var
  i,x : Integer;
  temp : Byte;
  Mem : TMemoryStream;
begin
  for i := 0 to Levels.Count -1 do
  begin
    Mem := TMemoryStream.Create;
    try
      for x := 0 to 593 do
      begin
        temp := Levels[i].UncompressedBuffer[x];
        Mem.Write(temp,1);

      end;
      Mem.SaveToFile(ExtractFileDir(Application.ExeName) + '\level' + inttostr(i) + '.bin');
    finally
      FreeAndNil(Mem);
    end;

  end;
end;

function TROMData.GetRectTileNumber(pIndex : Byte) : TRect;
var
  TempRect : TRect;
begin
  TempRect.Left := (pIndex mod 4) * 8;
  TempRect.Top := (pIndex div 4) * 8;
  TempRect.Right := TempRect.Left+8;
  TempRect.Bottom := TempRect.Top+8;
  result := TempRect;
end;

function TROMData.CompressLevels : Boolean;
var
  i,j,l,k,x,z, freespaceoff : Integer;
  buffer : Array [0..999] Of Byte;
  CRCs : Array Of LongWord;
  SavePlaces : Array Of Integer;
  toobig : Boolean;
begin

  // First, we begin with backing up the banks incase
  // all the level data put together exceeds the amount of free space
  // available in the ROM.
  ROM.BackupBank(0,$8000);

  // Right, CRCs contains the CRC32 values of each of the level data.
  // SavePlaces is an array used to store which levels are identical, and
  // which should use the same positions in the ROM.
  Setlength(CRCs,Levels.Count);
  SetLength(SavePlaces,Levels.Count);

  // Create CRC32's for each of the levels.
  // We really don't need to create separate variables to
  // store the CRC32 value, I only created this variable when
  // I wasn't sure what the hell I was doing!
  // Oh yeah, we also initialise the saveplaces
  for x := 0 to Levels.Count -1 do
  begin
    CRCs[x] := Levels[x].CRC32;
    SavePlaces[x] := -1;
  end;

  // Erase previous level data.
  // This function erases all data respective of whether the data
  // is shared or anything. (It doesn't really matter if we erase the
  // same area of memory repeatedly!)
  for i := 0 to Levels.Count -1 do
  begin
    z := ROM.PointerToOffset(  Properties['LevelPointers'].Offset + (Levels[i].LevelID) * 2,0,$8000);

    // Go through and delete the data.
    for x := 0 to Levels[i].CompressedSize - 1 do
    begin
      rom[z] := $FF;
      inc(z);
    end;
  end;


  // This FOR loop loops through the array of CRC32s and works
  // out which levels are identical. If a level is identical
  // to a level before it, the SavePlaces index is set to the
  // preceding identical level.
  for x := 0 to Levels.Count -1 do
  begin

    for j := 0 to x - 1 do
    begin
      if (CRCs[x] = CRCs[j]) then
      begin
        if SavePlaces[x] = -1 then
          SavePlaces[x] := j;
      end;
    end;

    if SavePlaces[x] = -1 then
      SavePlaces[x] := x;

  end;

  // Now the really meaty part of the function!
  for x := 0 to Levels.Count -1 do
  begin

    // If the SavePlaces index is set to another level,
    // don't bother compressing this level. It's been done before.
    if SavePlaces[x] = x then
    begin
      // Clear the compressed buffer.
      for i := 0 to high(buffer) do
        buffer[i] := $FF;


      // A Delphi port of DahrkDaiz's compression code.
      // Originally used in Apple (http://dahrkdaiz.panicus.org/editor/apple.html)
      // I generally have no idea how this thing works, because I just did a direct
      // port. My old compression routine was too good for the game, and this one
      // has been proven to work, so why not use it? ;)

      k := 0;
      l := 0;

      for j := 0 to 26 do
      begin
        for i := 0 to 21 do
        begin
          if (i <> 00) and (((Levels[x].UncompressedBuffer[k] mod $40) = (buffer[l-1] mod $40)) and (buffer[l-1] < $C0)) then
            buffer[l-1] := buffer[l-1] + $40
          else
          begin
            buffer[l] := Levels[x].UncompressedBuffer[k];
            inc(l);
          end;
        inc(k);
        end;
      end;

      // Reset the compressed size variable.
      Levels[x].CompressedSize := l;

      toobig := false;
      FreeSpaceOff := 0;
      // Search through all the known freespace locations in the ROM,
      // and find a place to store the level.
      for z := 0 to FreeSpace.Count -1 do
      begin
        FreeSpaceoff := ROM.FindFreeSpace(Levels[x].CompressedSize,FreeSpace[z].StartOffset,FreeSpace[z].EndOffset);
        if FreeSpaceOff > -1 then
        begin
          toobig := false;
          break;
        end
        else
          toobig := true;
      end;
      // If this is ever reached, then there is no place with which to store the
      // level. The levels are simply too big to fit in the available space.
      // Not that this should ever happen, the ROM has a ton of freespace!
      if toobig = true then
      begin

        result := false;
        ROM.RestoreBank(0);
        exit;
      end;
      // Write the pointer of where we are going to store the level data.
      ROM.StorePointerOffset(FreeSpaceOff,Properties['LevelPointers'].Offset + (x*2));
      // Now, we actually write the compressed level data to the ROM.
      for z := 0 to Levels[x].CompressedSize -1 do
        ROM[FreeSpaceOff + z] := buffer[z];


    end
  end;

  // Now we scan through the levels that share level data, and fix the pointers.
  for x := 0 to Levels.count -1 do
  begin
    if SavePlaces[x] <> x then
    begin
      ROM[Properties['LevelPointers'].Offset + (x*2)] :=
        ROM[Properties['LevelPointers'].Offset + (SavePlaces[x] * 2)];
      ROM[Properties['LevelPointers'].Offset + (x*2) + 1] :=
        ROM[Properties['LevelPointers'].Offset + (SavePlaces[x] * 2) +1];

      Levels[x].CompressedSize := Levels[SavePlaces[x]].CompressedSize;
    end;
  end;
  result := true;

end;

function TROMData.LevelOffset(pStageID : Integer) : Integer;
begin
  result := ROM.PointerToOffset(  Properties['LevelPointers'].Offset + (pStageID) * 2,0,$8000);
end;

function TROMData.InstallPalASMHack() : Boolean;
var
  Mem : TMemoryStream;
  PalHack : Array Of Byte;
  i : Integer;
  offset : String;
  lwCRC32PalHack : LongWord;
  lwCRC32ROM : LongWord;
begin
  result := False;

  Mem := TMemoryStream.Create;

  Mem.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Resources\palhack.bin');
  SetLength(PalHack, Mem.Size);
  Mem.Read(PalHack[0],Mem.Size);
  FreeAndNil(Mem);

  lwCRC32PalHack := $FFFFFFFF;
  lwCRC32ROM := $FFFFFFFF;

  CalcCRC32(@PalHack[0], self._ASMHackCodeSize, lwCRC32PalHack);
  CalcCRC32(@ROM.RawROM[Properties['ASMHackInstallOffset'].Offset],self._ASMHackCodeSize,lwCRC32ROM);

  lwCRC32PalHack := not(lwCRC32PalHack);
  lwCRC32ROM := not(lwCRC32ROM);

  // Step 1 - Check for the existence of the hack.

  if lwCRC32PalHack = lwCRC32ROM then
  begin
    result := true;
    exit;
  end;

  // Step 2 - Apply it, if it doesn't exist.
  for i := 0 to high(PalHack) do
  begin

    ROM[Properties['ASMHackInstallOffset'].Offset+i] := PalHack[i];

  end;
  // Insert a JSR
  ROM[_ASMHackJSR] := $20;
  offset := IntToHex(ROM.OffsetToPointer(Properties['ASMHackInstallOffset'].Offset,$C000),4);


  ROM[_ASMHackJSR+1] := StrToInt('$' + offset[3] + offset[4]);
  ROM[_ASMHackJSR+2] := StrToInt('$' + offset[1] + offset[2]);
end;

function TROMData.DetectObjectUnderMouse(pX,pY : Integer) : TObjDetect;
var
  Obj : TObjDetect;
begin

  if (pX >= _MsPacmanStartX) and (pX <= _MsPacmanStartX + 16) then
    if (pY >= _MsPacmanStartY) and (pY <= _MsPacmanStartY + 16) then
    begin
      Obj.ObjType := 1;
      Obj.ObjIndex := 0;
      result := obj;
      exit;
    end;

  Obj.ObjType := -1;
  Obj.ObjIndex := -1;
  result := obj;

end;

procedure TROMData.LoadStartingPositions;
begin
  _MsPacmanStartX := Properties['StartingPosX'].Value;
  _MsPacmanStartY := Properties['StartingPosY'].Value - $10;
end;

procedure TROMData.SaveStartingPositions;
begin
  Properties['StartingPosX'].Value := _MsPacmanStartX;
  Properties['StartingPosY'].Value := _MsPacmanStartY + $10;
end;

function TROMData.ImportLevel(pFilename : String; pLevelToReplace : Integer) : TImportResult;
var
  Mem : TMemoryStream;
  txt : String;
  int : Integer;
  i : Integer;
begin
  result := cROMdata.irGood;
  Mem := TMemoryStream.Create;
  try
    Mem.LoadFromFile(pFilename);
    SetLength(txt,6);
    Mem.Read(txt[1],6);
    if txt = 'BLINKY' then
    begin
      // Read the version number.
      int := 0;
      Mem.Read(int,1);
      // Supports only version 1 of the export format.
      if int = 1 then
      begin
        // Skip ahead to the level data.
        int := 0;
        mem.read(int,4);

        Mem.Seek(int,soFromBeginning);
        if pLevelToReplace > -1 then
        begin
          for i := 0 to 593 do
          begin
            int := 0;
            mem.read(int,1);
            Levels[pLevelToReplace].UncompressedBuffer[i] := int;
          end;
        end;

      end
      else
      begin
        result := cROMData.irUnsupportedVersion;
      end;

    end
    else
    begin
      result := cROMData.irHeaderBad;
    end;

  finally
    FreeAndNil(Mem);
  end;

end;

procedure TROMData.ExportLevel(pFilename : String; pLevelToExport : Byte;
  pLevelName,pLevelDesc,pLevelAuthor,pLevelHomepage : String);
var
  Mem : TMemoryStream;
  TempStr : String;
  TempInt : Byte;
  i, offset,size : Integer;
begin

  // BLINKY
  // Version Number
  // 4-Byte Offset of Level Data
  // Level Name Size (1-Byte)
  // Level Name
  // Level Description Size (1-Byte)
  // Level Description
  // Level Author Size (1-Byte)
  // Level Author
  // Level Homepage Size (1-Byte)
  // Level Homepage
  // Level Data

  Mem := TMemoryStream.Create;
  try
    // Write the header file.
    TempStr := 'BLINKY';
    Mem.Write(TempStr[1],6);

    // Write the version number
    TempInt := 1;
    Mem.Write (TempInt,1);

    // Write a blank offset.
    Offset := 0;
    Mem.Write(Offset,4);

    // Write the level name size
    TempStr := pLevelName;
    size := Length(TempStr);
    Mem.Write(Size,1);
    Mem.Write (TempStr[1],Length(TempStr));

    // Write the level description
    TempStr := pLevelDesc;
    size := Length(TempStr);
    Mem.Write(Size,1);

    Mem.Write (TempStr[1],Length(TempStr));

    // Write the level author
    TempStr := pLevelAuthor;
    size := Length(TempStr);
    Mem.Write(Size,1);
    Mem.Write (TempStr[1],Length(TempStr));

    // Write the level homepage
    TempStr := pLevelHomepage;
    size := Length(TempStr);
    Mem.Write(Size,1);
    Mem.Write (TempStr[1],Length(TempStr));

    Offset := Mem.Position;

    // Write the level data
    for i := 0 to 593 do
    begin
      TempInt := Levels[pLevelToExport].UncompressedBuffer[i];
      Mem.Write(TempInt,1);
    end;
    Mem.Seek(7,soFromBeginning);

    Mem.Write(Offset,4);

    Mem.SaveToFile(pFilename);

  finally
    FreeAndNil(Mem);
  end;
end;

function TROMData.ImportLevelInformation(pFilename : String) : TLevelHeaderInfo;
var
  Mem : TMemoryStream;
  txt : String;
  int : Integer;
  LevelInfo : TLevelHeaderInfo;
begin

  Mem := TMemoryStream.Create;
  try
    Mem.LoadFromFile(pFilename);
    SetLength(txt,6);
    Mem.Read(txt[1],6);
    if txt = 'BLINKY' then
    begin
      // Read the version number.
      int := 0;
      Mem.Read(int,1);
      // Supports only version 1 of the export format.
      if int = 1 then
      begin
        Mem.Seek(4,soFromCurrent);

        // Read the level name
        int := 0;
        mem.Read(int,1);
        Setlength(LevelInfo.Name,int);
        Mem.Read(LevelInfo.Name[1],int);

        // Read the level description
        int := 0;
        mem.Read(int,1);
        Setlength(LevelInfo.Description,int);
        Mem.Read(LevelInfo.Description[1],int);

        // Read the level author
        int := 0;
        mem.Read(int,1);
        Setlength(LevelInfo.Author,int);
        Mem.Read(LevelInfo.Author[1],int);

        // Read the level homepage
        int := 0;
        mem.Read(int,1);
        Setlength(LevelInfo.Homepage,int);
        Mem.Read(LevelInfo.Homepage[1],int);

        result := LevelInfo;


      end;

    end;

  finally
    FreeAndNil(Mem);
  end;

end;

procedure TROMData.DrawImportLevel(pBitmap : Tbitmap32;pFilename : String);
var
  Temp : Array [0..593] of Byte;
  Mem : TMemoryStream;
  txt : String;
  int : Integer;
  i : Integer;
begin

  Mem := TMemoryStream.Create;
  try
    Mem.LoadFromFile(pFilename);
    SetLength(txt,6);
    Mem.Read(txt[1],6);
    if txt = 'BLINKY' then
    begin
      // Read the version number.
      int := 0;
      Mem.Read(int,1);
      
      // Supports only version 1 of the export format.
      if int = 1 then
      begin
        // Skip ahead to the level data.
        int := 0;
        mem.read(int,4);

        Mem.Seek(int,soFromBeginning);

        for i := 0 to 593 do
        begin
          int := 0;
          mem.read(int,1);
          Temp[i] := int;
        end;

        DrawByteArray(pBitmap,Temp); 

      end;

    end;

  finally
    FreeAndNil(Mem);
  end;
end;

function TROMData.GetScoreDigit(pIndex : Integer) : Byte;
begin
  result := ROM[Properties['StartingScore'].Offset + pIndex];
end;

procedure TROMData.SetScoreDigit(pIndex : Integer;pValue : Byte);
begin
  ROM[Properties['StartingScore'].Offset + pIndex] := pValue;
end;

end.
