;NSIS Modern User Interface
;Basic Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General


  ;Name and file
  Name "ParaWorld Paragames v1.1"
    !insertmacro MUI_DEFAULT MUI_ICON "icon.ico"
  OutFile "paraworld_paragames.exe"

Function .onInit
   InitPluginsDir
   File /oname=$PLUGINSDIR\splash.bmp "paragamessplash.bmp"
   splash::show 10000 $PLUGINSDIR\splash
   ClearErrors
   ReadRegStr $INSTDIR HKLM "SOFTWARE\Sunflowers\ParaWorld" "InstallDir"
   IfErrors nopw
   Goto nopwend
   nopw:
   MessageBox MB_OK|MB_ICONEXCLAMATION "The installer could not detect an installation of ParaWorld. You have to set the ParaWorld-path yourself."
   StrCpy $INSTDIR "[insert ParaWorld directory here]"
   nopwend:
   ClearErrors
   RMDir /r "$0\Data\Paragames"
   Delete "$0\Data\Info\Paragames.info"
   Delete "$DESKTOP\Paragames.lnk"
   Delete "$SMPROGRAMS\Sunflowers\ParaWorld\Paragames.lnk"
   Delete "$SMPROGRAMS\Sunflowers\ParaWorld\Paragames Readme.lnk"
   ClearErrors
FunctionEnd

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

  ;Default installation folder
  InstallDir $INSTDIR

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_LICENSE "desc.txt"
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "!Base files" SecBasic

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...
  File /r "data\"

  SetOutPath "$INSTDIR\bin"
  
  ;Store installation folder

  CreateShortCut "$DESKTOP\Paragames.lnk" "$INSTDIR\bin\Paraworld.exe" "-enable paragames"
  CreateDirectory "$SMPROGRAMS\Sunflowers\ParaWorld"
  CreateShortCut "$SMPROGRAMS\Sunflowers\ParaWorld\Paragames.lnk" "$INSTDIR\bin\Paraworld.exe" "-enable paragames"

  SetOutPath "$INSTDIR\Data\Paragames"
  CreateShortCut "$SMPROGRAMS\Sunflowers\ParaWorld\Paragames Readme.lnk" "$INSTDIR\Data\Paragames\Readme.txt"
  
  
  SetOutPath "$INSTDIR"

  MessageBox MB_OK "Now the installer will clear the cache, don't panic, the next window is harmless!"
  ExecWait "$INSTDIR\Tools\ClearCache.exe"
  Exec "notepad.exe $INSTDIR\Data\Paragames\Readme.txt"

SectionEnd
