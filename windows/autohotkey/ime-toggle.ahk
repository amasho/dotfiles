; ime-toggle.ahk - Ctrl+Shift+E で IME のオン/オフを切り替える (AutoHotkey v2)
;
; キー入力を合成せず IME に直接メッセージを送るため、Jump Desktop などリモート越しでも
; Ctrl / Shift が押しっぱなし扱いにならない (PowerToys の置換ではこれが起きた)。
; install.sh が %APPDATA%\dotfiles\ime-toggle.ahk にコピーする。
#Requires AutoHotkey v2.0
#SingleInstance Force

; IME ウィンドウは非表示なので、検出対象に含めないと SendMessage が失敗する
DetectHiddenWindows(true)

WM_IME_CONTROL := 0x283
IMC_GETOPENSTATUS := 0x5
IMC_SETOPENSTATUS := 0x6

; フォーカスのあるウィンドウ (Windows Terminal などは子ウィンドウ) の IME ウィンドウを返す
ImeWnd() {
    hwnd := WinExist("A")
    info := Buffer(A_PtrSize = 8 ? 72 : 48, 0)
    NumPut("UInt", info.Size, info, 0)
    if DllCall("GetGUIThreadInfo", "UInt", 0, "Ptr", info) {
        focus := NumGet(info, A_PtrSize = 8 ? 16 : 12, "Ptr")
        if focus
            hwnd := focus
    }
    return DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
}

ImeToggle() {
    ime := ImeWnd()
    if !ime
        return
    try {
        open := SendMessage(WM_IME_CONTROL, IMC_GETOPENSTATUS, 0, , "ahk_id " ime, , , , 500)
        SendMessage(WM_IME_CONTROL, IMC_SETOPENSTATUS, !open, , "ahk_id " ime, , , , 500)
    }
}

^+e:: ImeToggle()
