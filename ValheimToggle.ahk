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
IniRead, wait, %configFile%, General, waitBeforeRepeat
global wait=wait
IniRead, delay, %configFile%, General, clickDelay
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

#UseHook ; Prevents scripts from triggering Hotekeys themselves

ScrollLock::
    loop 3
        SoundBeep,900
    exitApp
    Return

AutoClick:
    clicking := !clicking
    While(clicking){
        Click
        Sleep, %delay%
    }
    Return

ClickFaster:
    ChangeSpeed(100)
    Return

ClickSlower:
    ChangeSpeed(-100)
    Return

AutoRun:
    global running := !running
    if(running){
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
    if(muted) {
        Return
    }
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
        clicking := False
    }
    Return

~e::
    Sleep, %wait%
    While(GetKeyState("e","P")){
        Send e
        Sleep, 25
    }
    Return

~w::
    StopRunning()
    Return

~Tab::
    clicking := False
    Return

~s::
    StopRunning()
    Return

StopRunning() {
    if (!running) {
        Return
    }
    Send {w up}
    running := False
    Return
}

AutoClick() {
    Sleep, %wait%
    While(GetKeyState("LButton","P")){
        Click
        Sleep, %delay%
    }
    Return
}

ChangeSpeed(value)
{
    delay -= %value%
    if (delay < 100) {
        delay = 100
    }
    if(muted) {
        Return
    }

    if (delay > 2000) {
        pitch := 100+40000/(delay-1900)
    }
    Else {
        pitch := 1500-delay/2
    }
    SoundBeep, %pitch%
    Return
}