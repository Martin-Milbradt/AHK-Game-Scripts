#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon
SetTitleMatchMode 3
return

#UseHook

#HotIf WinActive("Enshrouded")
media_play_pause::{
    send "e"
    n := 0
    while(n < 50){
        n++
        sleep(10)
        send "f"
    }
}

y::{
    send "e"
    sleep(750)
    send "+r"
    sleep(50)
    send "+f"
    sleep(10)
    send "t"
    sleep(10)
    send "g"
}
