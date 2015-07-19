unit fStartingStage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TfrmStartingStage = class(TForm)
    lblStartingStage: TLabel;
    txtStartingStage: TSpinEdit;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure cmdOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStartingStage: TfrmStartingStage;

implementation

uses uGlobal;

{$R *.dfm}

procedure TfrmStartingStage.FormShow(Sender: TObject);
begin
  txtStartingStage.Value := ROMData.Properties['StartStage'].Value;
end;

procedure TfrmStartingStage.cmdOKClick(Sender: TObject);
begin
  ROMData.Properties['StartStage'].Value := txtStartingStage.Value;
end;

end.
