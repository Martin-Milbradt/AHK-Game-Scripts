#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#MaxThreadsPerHotkey 2
configFile := "Config.ini"
SetTitleMatchMode 3
SetMouseDelay,30
ListLines,Off

; Set general configuration from config
IniRead, delay, %configFile%, General, initialDelay
global delay=delay
IniRead, mute, %configFile%, General, startMuted
global mute=mute
IniRead, autoClickHold, %configFile%, General, autoClickHold
global autoClickHold=autoClickHold

; Set hotkeys from config
Hotkey, IfWinActive, Valheim
IniRead, autoClick, %configFile%, Hotkeys, autoClick
Hotkey, %autoClick%, AutoClick
IniRead, autoRun, %configFile%, Hotkeys, autoRun
Hotkey, %autoRun%, AutoRun
IniRead, mute, %configFile%, Hotkeys, mute
Hotkey, %mute%, Mute
IniRead, toggleAutoClickHold, %configFile%, Hotkeys, toggleAutoClickHold
Hotkey, %toggleAutoClickHold%, ToggleAutoClickHold
IniRead, clickFaster, %configFile%, Hotkeys, clickFaster
Hotkey, %clickFaster%, ClickFaster
IniRead, clickSlower, %configFile%, Hotkeys, clickSlower
Hotkey, %clickSlower%, ClickSlower

Return

ScrollLock::
    loop 3
        SoundBeep,900
    exitApp
    Return

AutoClick:
    clicking := !clicking
    While(clicking){
        Click
        clickDelay := 100*delay
        Sleep, %clickDelay%
    }
    Return

ClickFaster:
    ChangeSpeed(1)
    Return

ClickSlower:
    ChangeSpeed(-1)
    Return

AutoRun:
    if(running := !running){
        Send {w down}
    }
    else{
        Send {w up}
    }
    Return

Mute:
    global muted := !muted
    if(muted)
    {
        SoundBeep, 900
        SoundBeep, 500
    }
    Else
    {
        SoundBeep, 500
        SoundBeep, 900
    }
    Return

ToggleAutoClickHold:
    global autoClickHold := !autoClickHold
    if(autoClickHold)
    {
        SoundBeep, 500
        SoundBeep, 900
    }
    Else
    {
        SoundBeep, 900
        SoundBeep, 500
    }
    Return

#IfWinActive Valheim
~LButton::
    if (autoClickHold) {
        AutoClick()
    } Else {
        Clicking := False
    }
    Return

~e::
    Sleep, 100
    While(GetKeyState("e","P")){
        Send e
        Sleep, 25
    }
    Return

~w::
    running := False
    Return

AutoClick() {
    While(GetKeyState("LButton","P")){
        clickDelay := 100*delay
        Sleep, %clickDelay%
        Click
    }
    Return
}

ChangeSpeed(value)
{
    delay -= %value%
    if (delay < 1) {
        delay = 1
    }
    if (!muted) {
        if (delay > 20) {
            pitch := 100+400/(delay-19)
        }
        Else {
            pitch := 1500-delay*50
        }
        SoundBeep, %pitch%
    }
    Return
}