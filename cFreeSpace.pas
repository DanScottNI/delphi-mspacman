unit cFreeSpace;

interface

uses contnrs;

type
  TFreeSpace = class
  private
    _StartOffset : Integer;
    _EndOffset : Integer;
  public
    property StartOffset : Integer read _StartOffset write _StartOffset;
    property EndOffset : Integer read _EndOffset write _EndOffset;
  end;

  TFreeSpaceList = class(TObjectList)
  protected
    function GetItem(Index: Integer) : TFreeSpace;
    procedure SetItem(Index: Integer; const Value: TFreeSpace);
  public
    function Add(AObject: TFreeSpace) : Integer;
    property Items[Index: Integer] : TFreeSpace read GetItem write SetItem;default;
    function Last : TFreeSpace;
  end;

implementation

{ TFreeSpaceList }

function TFreeSpaceList.Add(AObject: TFreeSpace): Integer;
begin
  Result := inherited Add(AObject);
end;

function TFreeSpaceList.GetItem(Index: Integer): TFreeSpace;
begin
  Result := TFreeSpace(inherited Items[Index]);
end;

procedure TFreeSpaceList.SetItem(Index: Integer; const Value: TFreeSpace);
begin
  inherited Items[Index] := Value;
end;

function TFreeSpaceList.Last : TFreeSpace;
begin
  result := TFreeSpace(inherited Last);
end;

end.
