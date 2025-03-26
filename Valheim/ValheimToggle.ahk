#NoTrayIcon
#MaxThreadsPerHotkey 2
global configFile := "config.ini"
global defaultConfigFile := "config.default.ini"
SetTitleMatchMode 3
SetMouseDelay 30
ListLines False

global wait := GetConfigValue("waitBeforeRepeat")
global delay := GetConfigValue("clickDelay")
global muted := GetConfigValue("startMuted")
global autoClickHold := GetConfigValue("autoClickHold")

HotIfWinActive "Valheim"
SetConfigHotkey("autoClick", "AutoClick")
SetConfigHotkey("autoRun", "AutoRun")
SetConfigHotkey("muted", "Mute")
SetConfigHotkey("toggleAutoClickHold", "ToggleAutoClickHold")
SetConfigHotkey("clickFaster", "ClickFaster")
SetConfigHotkey("clickSlower", "ClickSlower")

#UseHook

ScrollLock::
{
    loop 3
        SoundBeep 900
    ExitApp
}

AutoClick(*)
{
    static clicking := false
    clicking := !clicking
    While (clicking) {
        Click
        Sleep delay
    }
}

ClickFaster(*)
{
    ChangeSpeed(100)
}

ClickSlower(*)
{
    ChangeSpeed(-100)
}

AutoRun(*)
{
    global running := !running
    if (running) {
        Send "{w down}"
    }
    else {
        Send "{w up}"
    }
}

Mute(*)
{
    global muted := !muted
    if (muted)
    {
        SoundBeep 900
        SoundBeep 500
    }
    Else
    {
        SoundBeep 500
        SoundBeep 900
    }
}

ToggleAutoClickHold(*)
{
    global autoClickHold := !autoClickHold
    if (muted) {
        return
    }
    if (autoClickHold)
    {
        SoundBeep 500
        SoundBeep 900
    }
    Else
    {
        SoundBeep 900
        SoundBeep 500
    }
}

HotIfWinActive "Valheim"
~LButton::
{
    static clicking := false
    if (autoClickHold) {
        AutoClick2()
    }
    clicking := False
}

~RButton::
{
    static clicking := false
    clicking := False
}

~e::
{
    Sleep wait
    While (GetKeyState("e", "P")) {
        Send "e"
        Sleep 25
    }
}

~w:: StopRunning()

~Tab::
{
    static clicking := false
    clicking := False
}

~s:: StopRunning()

StopRunning()
{
    global running
    if (!running) {
        return
    }
    Send "{w up}"
    running := False
}

AutoClick2()
{
    Sleep wait
    While (GetKeyState("LButton", "P")) {
        Click
        Sleep delay
    }
}

ChangeSpeed(value)
{
    global delay, muted
    delay -= value
    if (delay < 100) {
        delay := 100
    }
    if (muted) {
        return
    }

    pitch := 0
    if (delay > 2000) {
        pitch := 100 + 40000 / (delay - 1900)
    }
    Else {
        pitch := 1500 - delay / 2
    }
    SoundBeep pitch
}

SetConfigHotkey(keyName, handle)
{
    key := IniRead(configFile, "Hotkeys", keyName, "ERROR")
    if (key == "ERROR") {
        key := IniRead(defaultConfigFile, "Hotkeys", keyName, "")
    }
    Hotkey key, handle
}

GetConfigValue(variableName)
{
    value := IniRead(configFile, "General", variableName, "ERROR")
    if (value == "ERROR") {
        value := IniRead(defaultConfigFile, "General", variableName, "")
    }
    return value
}