unit fFileProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmFileProperties = class(TForm)
    lblFilename: TLabel;
    txtFilename: TEdit;
    lblMemoryMapper: TLabel;
    lblPRGCount: TLabel;
    lblCHRCount: TLabel;
    lblFileSize: TLabel;
    cmdOK: TButton;
    cmdRestoreHeaderToDefault: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdRestoreHeaderToDefaultClick(Sender: TObject);
  private
    procedure Load;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFileProperties: TfrmFileProperties;

implementation

{$R *.dfm}

uses uglobal, inifiles;

procedure TfrmFileProperties.FormShow(Sender: TObject);
begin
  Load;
end;

procedure TfrmFileProperties.Load;
begin
  txtFilename.Text := ROMData.Filename;
  lblCHRCount.Caption := 'CHR Count: ' + IntToStr(ROMData.CHRCount);
  lblPRGCount.Caption := 'PRG Count: ' + IntToStr(ROMData.PRGCount);
  lblMemoryMapper.Caption := 'Memory Mapper: ' + IntToStr(ROMData.MemoryMapper) + ' (' + ROMData.MemoryMapperStr + ')';
  if ROMData.DiskDudePresent = True then
    lblMemoryMapper.Caption := lblMemoryMapper.Caption + ' (Diskdude Tag Present)';
  lblFilesize.Caption := 'File Size: ' + IntToStr(ROMData.FileSize) + ' bytes';
end;

procedure TfrmFileProperties.cmdRestoreHeaderToDefaultClick(
  Sender: TObject);
begin
  ROMData.RestoreDefaultiNESHeader;
  Load;
  showmessage('Header restored.');
end;

end.
