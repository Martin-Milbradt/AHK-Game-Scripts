#Requires AutoHotkey v2.0
SendMode "Input"
SetWorkingDir A_ScriptDir
SetTitleMatchMode 2
ListLines False
SetMouseDelay 30
I_Icon := "Valheim.ico"
if FileExist(I_Icon)
    A_TrayMenu.Icon(I_Icon)

#HotIf WinActive("Valheim")
ScrollLock:: {
    SoundBeep(400)
    SoundBeep(500)
    Run "ValheimToggle.ahk"
}