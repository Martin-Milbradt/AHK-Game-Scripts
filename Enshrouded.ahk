#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon
SetTitleMatchMode 3
return

#HotIf WinActive("Enshrouded")
~e::{
    n := 0
    while(n < 50){
        n++
        sleep(10)
        send "f"
    }
}
