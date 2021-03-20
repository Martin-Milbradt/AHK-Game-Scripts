#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#MaxThreadsPerHotkey 2
SetTitleMatchMode 3
ListLines,Off
SetMouseDelay,30
global delay := 4
return

#IfWinActive Valheim
ScrollLock::
    loop 3
        SoundBeep,900
    exitApp
    return

XButton2::
    Clicking := !Clicking
    While(Clicking){
        Click
        clickDelay := 100*delay
        Sleep, %clickDelay%

    }
    return

~e::
    While(GetKeyState("e","P")){
        Send e
        eDelay := 10*delay
        Sleep, %eDelay%
    }
    return

+::
    ChangeSpeed(1)
    Return

-::
    ChangeSpeed(-1)
    return

XButton1::
    if(running:=!running){
        Send {w down}
    }
    else{
        Send {w up}
    }
    return

F1::
    global mute:=!mute
    if(mute)
    {
        SoundBeep, 900
        SoundBeep, 500
    }
    Else
    {
        SoundBeep, 500
        SoundBeep, 900
    }
    return

ChangeSpeed(value)
{
    delay-=%value%
    if (delay == 0) {
        delay = 1
    }
    if (!mute) {
        pitch := 1500-delay*50
        SoundBeep, %pitch%
    }
    Return
}