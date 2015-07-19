unit fPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32_Image;

type
  TfrmPreview = class(TForm)
    imgPreview: TImage32;
  private
    _Filename : String;
    { Private declarations }
  public
    property Filename : String read _Filename;
    { Public declarations }
  end;

var
  frmPreview: TfrmPreview;

implementation

{$R *.dfm}

end.
