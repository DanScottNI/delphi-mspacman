unit fMirrorEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMirrorEditor = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lstMirrorSettings: TListBox;
    lblTileID: TLabel;
    txtTileID: TEdit;
    txtMirrorTileID: TEdit;
    lblMirrorTileID: TLabel;
    btnApply: TButton;
    procedure FormShow(Sender: TObject);
    procedure lstMirrorSettingsClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    { Private declarations }
    procedure PopulateListbox;
  public
    { Public declarations }
  end;

var
  frmMirrorEditor: TfrmMirrorEditor;

implementation

uses uGlobal;

{$R *.dfm}

procedure TfrmMirrorEditor.PopulateListbox;
var
  i : Integer;
begin
  lstMirrorSettings.Items.BeginUpdate;
  lstMirrorSettings.Items.Clear;

  for i := 0 to Length(MirrorConfig.MirrorSettings)-1 do
    lstMirrorSettings.items.Add(IntToHex(i,2) + ' : ' + IntToHex(MirrorConfig.MirrorSettings[i],2));

  lstMirrorSettings.Items.EndUpdate;
end;

procedure TfrmMirrorEditor.FormShow(Sender: TObject);
begin
  PopulateListbox;
end;

procedure TfrmMirrorEditor.lstMirrorSettingsClick(Sender: TObject);
begin
  if lstMirrorSettings.ItemIndex > -1 then
  begin
    txtTileID.Text := IntToHex(lstMirrorSettings.ItemIndex,2);
    txtMirrorTileID.Text := IntToHex(MirrorConfig.MirrorSettings[lstMirrorSettings.ItemIndex],2);
  end;
end;

procedure TfrmMirrorEditor.btnApplyClick(Sender: TObject);
begin
  MirrorConfig.MirrorSettings[StrToInt('$' + txtTileID.Text)] := StrToInt('$' + txtMirrorTileID.text);
  PopulateListBox();
end;

end.
