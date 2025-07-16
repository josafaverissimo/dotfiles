SetCapsLockState, AlwaysOff

CapsLock & h::SendInput, {Blind}{Left}
CapsLock & j::SendInput, {Blind}{Down}
CapsLock & k::SendInput, {Blind}{Up}
CapsLock & l::SendInput, {Blind}{Right}

CapsLock::Return

#2::Send, ^#{Right}
#1::Send, ^#{Left}

#SingleInstance Force

taskBarState=0
 RCtrl::
 global taskBarState
    if (taskBarState =1) {
        WinHide ahk_class Shell_TrayWnd
        WinHide Start ahk_class Button
        taskBarState:=0
    }
    else {
        WinShow ahk_class Shell_TrayWnd
        WinShow Start ahk_class Button
        taskBarState:=1
        Send, {RCtrl down} ;passthru the keypress to show the start menu
    	Send, {RCtrl up}
    }
 return
