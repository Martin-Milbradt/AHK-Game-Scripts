#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
SetTitleMatchMode 2
ListLines False
SetMouseDelay 30

#HotIf WinActive("A Way Out")
~e::
    {
        Sleep 250
        While GetKeyState("e", "P")
        {
            Send "e"
            Sleep 10
        }
        Return
    }