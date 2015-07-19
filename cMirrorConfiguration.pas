unit cMirrorConfiguration;

interface

uses SysUtils,classes, INIFiles;

  type
    TMirrorConfiguration = class
    private
      _Filename : String;
    public
      MirrorSettings : Array [0..$3F] of byte;
      procedure Save(pFilename : String);overload;
      procedure Save();overload;
      procedure Load(pFilename : String);
      constructor Create(pFilename : String);
    end;

implementation

constructor TMirrorConfiguration.Create(pFilename : String);
begin
  _Filename := pFilename;
  Load(pFilename);
end;

procedure TMirrorConfiguration.Save();
begin
  Save(_Filename);
end;

procedure TMirrorConfiguration.Save(pFilename:String);
var
  ini : TMemINIFile;
  i : Integer;
begin
  INI := TMemINIFile.Create(pFilename);
  try
    for i := 0 to Length(MirrorSettings)-1 do
    begin
      INI.WriteInteger('Mirror',IntToStr(i),MirrorSettings[i]);
    end;
    INI.UpdateFile;
  finally
    FreeAndNil(INI);
  end;
end;

procedure TMirrorConfiguration.Load(pFilename: String);
var
  ini : TMemINIFile;
  i : Integer;
begin
  INI := TMemINIFile.Create(pFilename);
  try
    for i := 0 to Length(MirrorSettings)-1 do
    begin
      MirrorSettings[i] := INI.ReadInteger('Mirror',IntToStr(i),i);
    end;
  finally
    FreeAndNil(INI);
  end;

end;

end.
