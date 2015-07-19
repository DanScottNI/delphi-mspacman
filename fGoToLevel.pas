unit fGoToLevel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmGoToLevel = class(TForm)
    lstLevels: TListBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    Level : Integer;
    { Public declarations }
  end;

var
  frmGoToLevel: TfrmGoToLevel;

implementation

uses uglobal;

{$R *.dfm}

procedure TfrmGoToLevel.FormShow(Sender: TObject);
var
  i : Integer;
begin
  lstLevels.Items.BeginUpdate;
  lstLevels.Clear;
  for i := 0 to ROMData.Levels.Count -1 do
    lstLevels.Items.Add(IntToStr(i+1));
  lstLevels.Items.EndUpdate;
  lstLevels.ItemIndex := ROMData.Level;
end;

procedure TfrmGoToLevel.cmdOKClick(Sender: TObject);
begin
  Level := lstLevels.ItemIndex;
end;

end.
