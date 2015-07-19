unit fExportLevels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmExportLevels = class(TForm)
    lblLevelFileName: TLabel;
    lblLevelName: TLabel;
    lblLevelDes: TLabel;
    lblLevelAuthor: TLabel;
    lblHomepage: TLabel;
    txtFilename: TEdit;
    cmdBrowse: TButton;
    txtName: TEdit;
    txtDescription: TEdit;
    txtAuthor: TEdit;
    txtHomepage: TEdit;
    cmdOK: TButton;
    cmdCancel: TButton;
    SaveDialog: TSaveDialog;
    procedure cmdBrowseClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExportLevels: TfrmExportLevels;

implementation

{$R *.dfm}

uses uGlobal, uResourceStrings;

procedure TfrmExportLevels.cmdOKClick(Sender: TObject);
begin
  ROMData.ExportLevel(txtFilename.Text,ROMData.Level,txtName.Text,txtDescription.Text,txtAuthor.Text,txtHomepage.Text);
  showmessage(RES_EXPORTFILE + CRLF + txtFilename.Text);
end;

procedure TfrmExportLevels.cmdBrowseClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    txtFilename.Text := SaveDialog.FileName;
    txtFilename.SelStart := Length(txtFilename.Text);
  end;
end;

end.
