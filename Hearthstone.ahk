#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

#HotIf WinActive("ahk_exe Hearthstone.exe")
^space:: SpamSpace() ;Hearthstone: Open booster packs

PrintScreen:: { ;Hearthstone: Take screenshot with Greenshot
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

~Esc:: spam := false ;Hearthstone: Stop opening booster packs
