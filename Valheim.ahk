#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2
ListLines,Off
SetMouseDelay,30
I_Icon = Valheim.ico
IfExist, %I_Icon%
    Menu, Tray, Icon, %I_Icon%
return

#IfWinActive Valheim
ScrollLock::
    SoundBeep,400
    SoundBeep,500
    run ValheimToggle.ahk