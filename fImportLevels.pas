unit fImportLevels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32,GR32_Image, StdCtrls;

type
  TfrmImportLevels = class(TForm)
    lblFilename: TLabel;
    txtFilename: TEdit;
    OpenDialog: TOpenDialog;
    cmdBrowse: TButton;
    cmdCancel: TButton;
    cmdImport: TButton;
    imgScreen: TImage32;
    lblLevelName: TLabel;
    lblLevelDesc: TLabel;
    lblLevelAuthor: TLabel;
    lblLevelHomepage: TLabel;
    lblDescription: TLabel;
    lblName: TLabel;
    lblAuthor: TLabel;
    lblHomepage: TLabel;
    procedure cmdImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportLevels: TfrmImportLevels;

implementation

{$R *.dfm}

uses cROMData,uglobal, uResourceStrings;

procedure TfrmImportLevels.cmdBrowseClick(Sender: TObject);
var
  LevelInfo : TLevelHeaderInfo;
  TempBitmap : TBitmap32;
begin
  if OpenDialog.Execute then
  begin
    if fileexists(OpenDialog.FileName) = false then
      exit;

    txtFilename.Text := OpenDialog.Filename;
    txtFilename.SelStart := Length(txtFilename.Text);
    if ROMData.ImportLevel(txtFilename.Text,-1) = cROMData.irGood then
    begin
      LevelInfo := ROMData.ImportLevelInformation(txtFilename.Text);

      lblDescription.Caption := LevelInfo.Description;
      lblName.Caption := LevelInfo.Name;
      lblAuthor.Caption := LevelInfo.Author;
      lblHomepage.Caption := LevelInfo.Homepage;

      lblLevelName.Visible := True;
      lblLevelDesc.Visible := True;
      lblLevelAuthor.Visible := True;
      lblLevelHomepage.Visible := True;
      lblDescription.Visible := True;
      lblName.Visible := True;
      lblAuthor.Visible := True;
      lblHomepage.Visible := True;

      TempBitmap := TBitmap32.Create;
      try
        TempBitmap.Height := 216;
        TempBitmap.Width := 176;
        ROMData.DrawImportLevel(TempBitmap,txtFilename.Text);
        imgScreen.Bitmap := tempbitmap;
      finally
        FreeAndNil(TempBitmap);
      end;
    end
    else
    begin
      showmessage(RES_PACBROKE);
    end;
  end;
end;

procedure TfrmImportLevels.FormShow(Sender: TObject);
begin
  lblLevelName.Visible := False;
  lblLevelDesc.Visible := False;
  lblLevelAuthor.Visible := False;
  lblLevelHomepage.Visible := False;
  lblDescription.Visible := False;
  lblName.Visible := False;
  lblAuthor.Visible := False;
  lblHomepage.Visible := False;
end;

procedure TfrmImportLevels.cmdImportClick(Sender: TObject);
var
  ImportRes : TImportResult;

begin
  ImportRes := ROMData.ImportLevel(txtFilename.Text,ROMData.Level);
  if ImportRes = cROMData.irHeaderBad then
  begin
    showmessage(RES_PACHEADERBAD);
  end
  else if ImportRes = cROMData.irUnsupportedVersion then
  begin
    showmessage(RES_PACUNSUPPORTED);
  end;
end;

end.
