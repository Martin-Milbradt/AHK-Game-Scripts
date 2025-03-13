#SingleInstance Force
#NoTrayIcon

#HotIf WinActive("Heroes of the Storm")
F1:: PickTalent("F1")
F2:: PickTalent("F2")
F3:: PickTalent("F3")
F4:: PickTalent("F4")
F5:: PickTalent("F5")
^:: PickTalent("F6")

PickTalent(key) {
    Send "{z down}"
    Sleep 5
    Send "{" key "}"
    Sleep 1000
    Send "{z up}"
}