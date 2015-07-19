unit fAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, shellapi, ComCtrls, MMSystem;

type
  TfrmAbout = class(TForm)
    cmdOK: TButton;
    lblHomepage: TLabel;
    lblDescription: TLabel;
    lblTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblHomepageMouseEnter(Sender: TObject);
    procedure lblHomepageMouseLeave(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    _Buffer : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses uResourcestrings;

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  Caption := 'About ' + APPLICATIONTITLE;
//  grpTripNSlip.Caption := 'About ' + APPLICATIONNAME;
  _Buffer := '';
end;

procedure TfrmAbout.lblHomepageClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar('http://dan.panicus.org'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.lblHomepageMouseEnter(Sender: TObject);
begin
  lblHomepage.Font.Style := [fsUnderline];
end;

procedure TfrmAbout.lblHomepageMouseLeave(Sender: TObject);
begin
  lblHomepage.Font.Style := [];
end;

procedure TfrmAbout.FormKeyPress(Sender: TObject; var Key: Char);
begin
  _Buffer := _Buffer + Key;
  if length(_Buffer) = 6 then _Buffer := '';
  if _Buffer = 'DAMN' then
  begin
    PlaySound(PChar('DAMN'), hInstance, snd_ASync or snd_Resource);
    _Buffer := '';
  end;
end;

end.
