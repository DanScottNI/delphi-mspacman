unit cLevel;

interface

uses contnrs,pascrc32;

type
  TLevel = class
  private
    _LevelID : Byte;
    _UncompressedBuffer : Array [0.. 593] Of Byte;
    _CompressedSize : Integer;
    function GetUncompressedBuffer(pIndex : Integer) : Byte;
    procedure SetUncompressedBuffer(pIndex : Integer; pTile : Byte);
    function GetCRC32 : LongWord;
    function GetPelletCount : SmallInt;
  public
    procedure ClearLevel(pTileType : Byte);
    function IndentLevel() : Boolean;
    function AddGhostTrap : Boolean;
    property LevelID : Byte read _LevelID write _LevelID;
    property CRC32 : LongWord read GetCRC32;
    property UncompressedBuffer [index : Integer] : Byte read GetUncompressedBuffer write SetUncompressedBuffer;
    property CompressedSize : Integer read _CompressedSize write _CompressedSize;
    property PelletCount : SmallInt read GetPelletCount;
  end;

  TLevelList = class(TObjectList)
  protected
    function GetLevelItem(Index: Integer) : TLevel;
    procedure SetLevelItem(Index: Integer; const Value: TLevel);
  public
    function Add(AObject: TLevel) : Integer;
    property Items[Index: Integer] : TLevel read GetLevelItem write SetLevelItem;default;
    function Last : TLevel;
  end;

implementation

var
  GhostTrap : Array [0..19] of Byte = ($1f, $17, $9, $16, $1D, $11, $0, $0, $0,
    $11, $11, $0, $0, $0, $11, $1e, $10, $10, $10, $1C);

function TLevel.GetUncompressedBuffer(pIndex : Integer) : Byte;
begin
  result := 0;
  if pIndex > high(_UncompressedBuffer) then
    exit;

  result := _UncompressedBuffer[pIndex];
end;

procedure TLevel.SetUncompressedBuffer(pIndex : Integer; pTile : Byte);
begin
  if pIndex > high(_UncompressedBuffer) then
    exit;

  _UncompressedBuffer[pIndex] := pTile;
end;

function TLevel.GetCRC32 : LongWord;
var
  lwCRC32 : LongWord;
begin
  lwCRC32 := $FFFFFFFF; // match "normal" / PKZIP / etc. , step one: initialize with $FFFFFFFF (-1 signed)

  CalcCRC32(@_UncompressedBuffer[0], Length(_UncompressedBuffer), lwCRC32);
  lwCRC32 := not lwCRC32; // match "normal" / PKZIP / etc. , step two: invert the bits of the result
  result := lwCRC32;
end;

procedure TLevel.ClearLevel(pTileType : Byte);
var
  i : Integer;
begin
  for i := 0 to 593 do
    _UncompressedBuffer[i] := pTileType and $3F;
end;

function TLevel.GetPelletCount : SmallInt;
var
  i : Integer;
  temp : SmallInt;
begin
  temp := 0;
  for i := 0 to 593 do
    if self._UncompressedBuffer[i] = $03 then
      inc(temp);

  result := temp;
end;

function TLevel.IndentLevel() : Boolean;
var
  i : Integer;
begin
  result := false;
  for i := 0 to 26 do
    if _UnCompressedBuffer[i*22] <> $00 then
    begin
      _UnCompressedBuffer[i*22] := $00;
      result := true;
    end;
end;

function TLevel.AddGhostTrap : Boolean;
var
  i, x : Integer;
begin
  result := false;
  for i := 0 to 3 do
    for x := 0 to 4 do
    begin
      if GhostTrap[(i * 5) + x] <> _UnCompressedBuffer[251 + (i * 22) + x] then
      begin
        _UnCompressedBuffer[251 + (i * 22) + x] := GhostTrap[(i * 5) + x];
        result := true;
      end;
    end;
    
end;


{ TLevelList }

function TLevelList.Add(AObject: TLevel): Integer;
begin
  Result := inherited Add(AObject);
end;

function TLevelList.GetLevelItem(Index: Integer): TLevel;
begin
  Result := TLevel(inherited Items[Index]);
end;

procedure TLevelList.SetLevelItem(Index: Integer; const Value: TLevel);
begin
  inherited Items[Index] := Value;
end;

function TLevelList.Last : TLevel;
begin
  result := TLevel(inherited Last);
end;


end.
