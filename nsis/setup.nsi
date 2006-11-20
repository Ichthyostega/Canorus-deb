# Auto-generated by EclipseNSIS Script Wizard
# 20.11.2006 13:48:36

Name Canorus
# Defines
!define REGKEY "SOFTWARE\$(^Name)"
!define VERSION 0.0.99svn
!define COMPANY "Matev� Jekovec"
!define URL http://canorus.berlios.de

# Included files
!include Sections.nsh

# Reserved Files
ReserveFile "${NSISDIR}\Plugins\StartMenu.dll"

# Variables
Var StartMenuGroup

# Installer pages
Page license
Page custom StartMenuGroupSelect "" ": $(StartMenuPageTitle)"
Page instfiles

# Installer languages
LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"

# Installer attributes
OutFile canorus-0.0.99svn-setup.exe
InstallDir $PROGRAMFILES\Canorus
CRCCheck on
XPStyle on
Icon "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
ShowInstDetails show
AutoCloseWindow false
LicenseData ..\LICENSE.GPL
VIProductVersion 0.0.99.0
VIAddVersionKey /LANG=${LANG_ENGLISH} ProductName Canorus
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} CompanyName "${COMPANY}"
VIAddVersionKey /LANG=${LANG_ENGLISH} CompanyWebsite "${URL}"
VIAddVersionKey /LANG=${LANG_ENGLISH} FileVersion ""
VIAddVersionKey /LANG=${LANG_ENGLISH} FileDescription ""
VIAddVersionKey /LANG=${LANG_ENGLISH} LegalCopyright ""
InstallDirRegKey HKLM "${REGKEY}" Path
UninstallIcon "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"
ShowUninstDetails show

# Installer sections
Section -Main SEC0000
    SetOutPath $INSTDIR\canorus
    SetOverwrite on
    File /r canorus\*
    WriteRegStr HKLM "${REGKEY}\Components" Main 1
SectionEnd

Section -post SEC0001
    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    WriteRegStr HKLM "${REGKEY}" StartMenuGroup $StartMenuGroup
    WriteUninstaller $INSTDIR\uninstall.exe
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^UninstallLink).lnk" $INSTDIR\uninstall.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section /o un.Main UNSEC0000
    RmDir /r /REBOOTOK $INSTDIR\canorus
    DeleteRegValue HKLM "${REGKEY}\Components" Main
SectionEnd

Section un.post UNSEC0001
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^UninstallLink).lnk"
    Delete /REBOOTOK $INSTDIR\uninstall.exe
    DeleteRegValue HKLM "${REGKEY}" StartMenuGroup
    DeleteRegValue HKLM "${REGKEY}" Path
    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}"
    RmDir /REBOOTOK $SMPROGRAMS\$StartMenuGroup
    RmDir /REBOOTOK $INSTDIR
SectionEnd

# Installer functions
Function StartMenuGroupSelect
    Push $R1
    StartMenu::Select /autoadd /text ": $(StartMenuPageText)" /lastused $StartMenuGroup Canorus
    Pop $R1
    StrCmp $R1 success success
    StrCmp $R1 cancel done
    MessageBox MB_OK $R1
    Goto done
success:
    Pop $StartMenuGroup
done:
    Pop $R1
FunctionEnd

Function .onInit
    InitPluginsDir
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    ReadRegStr $StartMenuGroup HKLM "${REGKEY}" StartMenuGroup
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd


# Installer Language Strings
# TODO Update the Language Strings with the appropriate translations.

LangString StartMenuPageTitle ${LANG_ENGLISH} "Start Menu Folder"
LangString StartMenuPageText ${LANG_ENGLISH} "Select the Start Menu folder in which you would like to create the program's shortcuts:"

LangString ^UninstallLink ${LANG_ENGLISH} "Uninstall $(^Name)"