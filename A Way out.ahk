#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2
ListLines,Off
SetMouseDelay,30

#IfWinActive A Way Out
~e::
    Sleep, 250
    While(GetKeyState("e","P")){
        Send e
        Sleep, 10
    }
    Return