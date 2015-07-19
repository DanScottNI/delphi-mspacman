unit fLevelInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TfrmLevelInfo = class(TForm)
    cmdOK: TButton;
    lvwLevelInfo: TListView;
    cmdCopyToClip: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdCopyToClipClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLevelInfo: TfrmLevelInfo;

implementation

uses uGlobal;

{$R *.dfm}

procedure TfrmLevelInfo.FormShow(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to ROMData.Levels.Count -1 do
  begin
    with lvwLevelInfo.Items.Add do
    begin
      Caption := IntToStr(i+1);
      SubItems.Add(IntToHex(ROMData.LevelOffset(i),2) );
      SubItems.Add(IntToHex(ROMData.LevelOffset(i) + ROMData.Levels[i].CompressedSize - 1,2));
      SubItems.Add(IntToHex(ROMData.Levels[i].CompressedSize,2));
    end;
  end;

end;

procedure TfrmLevelInfo.cmdCopyToClipClick(Sender: TObject);
var
  Filestr : TStringList;
  i : Integer;
begin

  Filestr := TStringList.Create;

  for i := 0 to ROMData.Levels.Count -1 do
  begin
    FileStr.Add('Stage: ' + IntToStr(i+1) + ',' +
      IntToHex(ROMData.LevelOffset(i),2) + ',' +
        IntToHex(ROMData.LevelOffset(i) +
          ROMData.Levels[i].CompressedSize - 1,2) + ',' +
            IntToHex(ROMData.Levels[i].CompressedSize,2));
  end;
  FileStr.SaveToFile(extractfiledir(application.ExeName) + '\levelinfo.txt');
  FreeAndNil(FileStr);
end;

end.
