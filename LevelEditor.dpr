program LevelEditor;



uses
  Forms,
  cLevel in 'cLevel.pas',
  cConfiguration in 'cConfiguration.pas',
  cROMdata in 'cROMdata.pas',
  uGlobal in 'uGlobal.pas',
  fAbout in 'fAbout.pas' {frmAbout},
  fBackupManagement in 'fBackupManagement.pas' {frmBackupManagement},
  fDebugROMViewer in 'fDebugROMViewer.pas' {frmDebugROMViewer},
  fDistribution in 'fDistribution.pas' {frmDistribution},
  fEditorMain in 'fEditorMain.pas' {frmEditorMain},
  fFileProperties in 'fFileProperties.pas' {frmFileProperties},
  fGoToLevel in 'fGoToLevel.pas' {frmGoToLevel},
  fKeyboardLayouts in 'fKeyboardLayouts.pas' {frmKeyboardLayout},
  fOpenDialog in 'fOpenDialog.pas' {frmOpenDialog},
  fPreferences in 'fPreferences.pas' {frmPreferences},
  fTileEditor in 'fTileEditor.pas' {frm16x16TileEditor},
  uLunarcompress in 'uLunarcompress.pas',
  uResourcestrings in 'uResourcestrings.pas',
  uROM in 'uROM.pas',
  fStartingLives in 'fStartingLives.pas' {frmStartingLives},
  fStartingStage in 'fStartingStage.pas' {frmStartingStage},
  fLevelInfo in 'fLevelInfo.pas' {frmLevelInfo},
  cFreeSpace in 'cFreeSpace.pas',
  fPalette in 'fPalette.pas' {frmPaletteEditor},
  fExportLevels in 'fExportLevels.pas' {frmExportLevels},
  fImportLevels in 'fImportLevels.pas' {frmImportLevels},
  cMirrorConfiguration in 'cMirrorConfiguration.pas',
  fMirrorEditor in 'fMirrorEditor.pas' {frmMirrorEditor};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Blinky';
  Application.CreateForm(TfrmEditorMain, frmEditorMain);
  Application.Run;
end.
