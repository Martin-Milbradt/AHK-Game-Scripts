#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#MaxThreadsPerHotkey 2
global configFile := "config.ini"
global defaultConfigFile := "config.default.ini"
SetTitleMatchMode 3
SetMouseDelay,30
ListLines,Off

global wait = GetConfigValue("waitBeforeRepeat")
global delay = GetConfigValue("clickDelay")
global mute = GetConfigValue("startMuted")
global autoClickHold = GetConfigValue("autoClickHold")

Hotkey, IfWinActive, Valheim
SetConfigHotkey("autoClick", "AutoClick")
SetConfigHotkey("autoRun", "AutoRun")
SetConfigHotkey("mute", "Mute")
SetConfigHotkey("toggleAutoClickHold", "ToggleAutoClickHold")
SetConfigHotkey("clickFaster", "ClickFaster")
SetConfigHotkey("clickSlower", "ClickSlower")

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
    }
    clicking := False
    Return

~RButton::
    clicking := False
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

SetConfigHotkey(keyName, handle) {
    IniRead, key, %configFile%, Hotkeys, %keyName%
    if (key == "ERROR") {
        IniRead, key, %defaultConfigFile%, Hotkeys, %keyName%
    }
    Hotkey, %key%, %handle%
}

GetConfigValue(variableName) {
    IniRead, value, %configFile%, General, %variableName%
    if (value == "ERROR") {
        IniRead, value, %defaultConfigFile%, General, %variableName%
    }
    return %value%
}