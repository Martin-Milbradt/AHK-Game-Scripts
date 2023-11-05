#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force  ; Ensures only one instance of the script is running at a time
#NoTrayIcon

#IfWinActive Heroes of the Storm
F1::
    PickTalent("F1")
return

F2::
    PickTalent("F2")
return

F3::
    PickTalent("F3")
return

F4::
    PickTalent("F4")
return

F5::
    PickTalent("F5")
return

^::
    PickTalent("F6")
return

PickTalent(key) {
    Send {z down}
    sleep 5
    send {%key%}
    sleep 1000
    send {z up}
    return
}
