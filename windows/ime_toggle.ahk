#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook

GetFocusHwnd() {
    hFore := DllCall("user32\GetForegroundWindow", "ptr")
    if !hFore
        return WinGetID("A")
    tid := DllCall("user32\GetWindowThreadProcessId", "ptr", hFore, "ptr", 0, "uint")
    guiInfo := Buffer(72, 0)
    NumPut("uint", 72, guiInfo, 0)
    if DllCall("user32\GetGUIThreadInfo", "uint", tid, "ptr", guiInfo.Ptr) {
        hFocus := NumGet(guiInfo, 16, "ptr")
        if hFocus
            return hFocus
    }
    return hFore
}

GetDefaultIMEWnd(hwnd) {
    return DllCall("imm32\ImmGetDefaultIMEWnd", "ptr", hwnd, "ptr")
}

GetThreadHKL(hwnd) {
    tid := DllCall("user32\GetWindowThreadProcessId", "ptr", hwnd, "ptr", 0, "uint")
    return DllCall("user32\GetKeyboardLayout", "uint", tid, "uptr")
}

SwitchToHKL(hwnd, targetHkl) {
    WM_INPUTLANGCHANGEREQUEST := 0x0050
    DllCall("user32\PostMessageW", "ptr", hwnd, "uint", WM_INPUTLANGCHANGEREQUEST, "ptr", 0, "uptr", targetHkl)
    DllCall("user32\LoadKeyboardLayoutW", "str", Format("{:08X}", targetHkl & 0xFFFFFFFF), "uint", 1, "uptr")
}

IME_GetOpen(hwnd) {
    ime := GetDefaultIMEWnd(hwnd)
    if !ime
        return -1
    WM_IME_CONTROL := 0x0283
    IMC_GETOPENSTATUS := 0x0005
    return DllCall("user32\SendMessageW", "ptr", ime, "uint", WM_IME_CONTROL, "uptr", IMC_GETOPENSTATUS, "ptr", 0, "ptr")
}

IME_GetConv(hwnd) {
    himc := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    if !himc
        return -1
    conv := Buffer(4, 0), sent := Buffer(4, 0)
    ok := DllCall("imm32\ImmGetConversionStatus", "ptr", himc, "ptr", conv.Ptr, "ptr", sent.Ptr)
    DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", himc)
    return ok ? NumGet(conv, 0, "uint") : -1
}

IME_SetOpen(hwnd, onOff) {
    ime := GetDefaultIMEWnd(hwnd)
    if !ime
        return false
    WM_IME_CONTROL := 0x0283
    IMC_SETOPENSTATUS := 0x0006
    DllCall("user32\SendMessageW", "ptr", ime, "uint", WM_IME_CONTROL, "uptr", IMC_SETOPENSTATUS, "ptr", onOff)
    return true
}

IME_SetConvHiragana(hwnd) {
    ime := GetDefaultIMEWnd(hwnd)
    if !ime
        return false
    WM_IME_CONTROL := 0x0283
    IMC_SETCONVERSIONMODE := 0x0002
    IME_CMODE_NATIVE := 0x0001
    IME_CMODE_FULLSHAPE := 0x0008
    mode := IME_CMODE_NATIVE | IME_CMODE_FULLSHAPE
    DllCall("user32\SendMessageW", "ptr", ime, "uint", WM_IME_CONTROL, "uptr", IMC_SETCONVERSIONMODE, "ptr", mode)
    return true
}

EnsureHiraganaWithRetry(hwnd, tries := 4, intervalMs := 50) {
    IME_CMODE_NATIVE := 0x0001
    IME_CMODE_FULLSHAPE := 0x0008
    Loop tries {
        IME_SetConvHiragana(hwnd)
        IME_SetOpen(hwnd, 1)
        Sleep intervalMs
        open := IME_GetOpen(hwnd)
        conv := IME_GetConv(hwnd)
        if (open = 1) && ((conv & (IME_CMODE_NATIVE | IME_CMODE_FULLSHAPE)) = (IME_CMODE_NATIVE | IME_CMODE_FULLSHAPE))
            return true
    }
    IME_SetConvHiragana(hwnd)
    IME_SetOpen(hwnd, 1)
    return false
}

ToggleLayoutHiragana() {
    hwnd := GetFocusHwnd()
    curr := GetThreadHKL(hwnd) & 0xFFFF

    LANG_JA := 0x0411
    HKL_JA := 0x00000411
    HKL_EN := 0x00000409

    if (curr = LANG_JA) {
        SwitchToHKL(hwnd, HKL_EN)
    } else {
        SwitchToHKL(hwnd, HKL_JA)
        Sleep (WinActive("ahk_exe firefox.exe") ? 80 : 40)
        EnsureHiraganaWithRetry(hwnd, (WinActive("ahk_exe firefox.exe") ? 6 : 4), 60)

        if WinActive("ahk_exe firefox.exe") {
            ; ★ 修正ポイント：SetTimer は [関数オブジェクト, 時間] の順！
            SetTimer(() => EnsureHiraganaWithRetry(hwnd, 2, 60), -180)
        }
    }
}

+Space:: {
    ToggleLayoutHiragana()
}
