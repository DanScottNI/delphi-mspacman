unit uresourcestrings;

interface

resourcestring
  APPLICATIONTITLE = 'Blinky v0.1';
  APPLICATIONTITLESHORT = 'Blinky';
  RES_ROMNOTLOADED = 'ROM not loaded.';
  RES_ROMCHANGESSAVE = 'This ROM has some changes. Do you wish to save?';
  RES_LEFT = 'Left';
  RES_MIDDLE = 'Middle';
  RES_LEVELNO = 'Level: ';
  RES_SCREENNO = ' Screen: ';
  RES_SCREENID = ' Screen ID: ';
  RES_NOTVALIDROM = 'This is not a <insertgame> ROM.';
  RES_NOTVALIDROMCONTINUE = 'The memory mapper of this ROM does not match the specifications of valid Ms Pacman ROMs. Do you wish to continue?';
  RES_LAUNCHEMU = 'Launch ';
  RES_NOEMUASSOC = 'No emulator associated';
  RES_ZIPCREATEDON = 'ZIP Created By Blinky on: ';
  RES_CHANGESSAVED = 'Changes saved.';
  RES_CHANGESAVEFAIL = 'ROM cannot be saved. Another program is probably using the file.';
  RES_OBJEDIT = 'Object Editing Mode';
  RES_MAPEDIT = 'Map Editing Mode';
  RES_LOADROMFIRST = 'Please load the ROM first.';
  RES_NOEMUASSOCIATED = 'There is no emulator associated, or the emulator cannot be found.';
  RES_WARNINGDISABLED = 'Please note, this warning can be disabled in the Preferences dialog.';
  RES_WARNINGWILLSAVE = 'Warning: This will save all currently made changes to the ROM. Do you wish to proceed?';
  RES_PELLETCOUNT = 'Pellet Count:';
  RES_CURRENTCOLOURPAL = 'Current Colour: $';
  RES_DAHRKDAIZPALHACK = 'DahrkDaiz''s extended palette hack has been applied to the ROM.';
  RES_DAHRKDAIZPALHACK2 = 'Please save the ROM so you never get this message again.';
  RES_DAHRKDAIZHOMEPAGE = 'DahrkDaiz''s Homepage: http://dahrkdaiz.panicus.org';
  RES_PACBROKE = 'The file that has been specified has a problem with it.';
  RES_PACUNSUPPORTED = 'The PAC file uses a version that is unsupported by this version of Blinky.';
  RES_PACHEADERBAD = 'This is not a valid PAC file.';
  RES_EXPORTFILE = 'Level exported to: ';
const
  CRLF : String = chr(13) + chr(10);
implementation

end.
