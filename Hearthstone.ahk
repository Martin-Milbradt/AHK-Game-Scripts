#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

#HotIf WinActive("ahk_exe Hearthstone.exe")
^space:: SpamSpace()

; Don't use hearthstone's printscreen
PrintScreen:: {
    Send("^{Esc}")
    Send("+{PrintScreen}") ; Greenshot: capture last window
    Send("^{Esc}")
}

SpamSpace() {
    spam := true
    while (spam) {
        if not WinActive("ahk_exe Hearthstone.exe")
            break
        Send " "
        Sleep(500)
    }
}

~Esc:: spam := false