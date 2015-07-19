unit fStartingLives;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,danhexedit;

type
  TfrmStartingLives = class(TForm)
    lblStartingLives: TLabel;
    lblStartingScore: TLabel;
    txtStartingLives: TSpinEdit;
    cmdOK: TButton;
    cmdCancel: TButton;
    txtScoreDigit1: TEdit;
    txtScoreDigit2: TEdit;
    txtScoreDigit3: TEdit;
    txtScoreDigit4: TEdit;
    txtScoreDigit5: TEdit;
    txtScoreDigit6: TEdit;
    procedure txtScoreDigit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    procedure SaveData;
    procedure LoadData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStartingLives: TfrmStartingLives;

implementation

{$R *.dfm}

uses uGlobal;

procedure TfrmStartingLives.LoadData;
begin
  txtStartingLives.Value :=  ROMData.Properties['StartingLives'].Value;
  txtScoreDigit1.Text := IntToHex(ROMData.GetScoreDigit(0),1);
  txtScoreDigit2.Text := IntToHex(ROMData.GetScoreDigit(1),1);
  txtScoreDigit3.Text := IntToHex(ROMData.GetScoreDigit(2),1);
  txtScoreDigit4.Text := IntToHex(ROMData.GetScoreDigit(3),1);
  txtScoreDigit5.Text := IntToHex(ROMData.GetScoreDigit(4),1);
  txtScoreDigit6.Text := IntToHex(ROMData.GetScoreDigit(5),1);
end;

procedure TfrmStartingLives.SaveData;
begin
  ROMData.Properties['StartingLives'].Value := txtStartingLives.Value;

  ROMData.SetScoreDigit(0,StrToInt('$' + txtScoreDigit1.Text));
  ROMData.SetScoreDigit(1,StrToInt('$' + txtScoreDigit2.Text));
  ROMData.SetScoreDigit(2,StrToInt('$' + txtScoreDigit3.Text));
  ROMData.SetScoreDigit(3,StrToInt('$' + txtScoreDigit4.Text));
  ROMData.SetScoreDigit(4,StrToInt('$' + txtScoreDigit5.Text));
  ROMData.SetScoreDigit(5,StrToInt('$' + txtScoreDigit6.Text));
end;

procedure TfrmStartingLives.FormShow(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmStartingLives.cmdOKClick(Sender: TObject);
begin
  SaveData;
end;

procedure TfrmStartingLives.txtScoreDigit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Chr(8) then exit;

  if (Key >= '0') and (Key <= '9') then
    exit;

  Key := chr(0);
end;

end.
