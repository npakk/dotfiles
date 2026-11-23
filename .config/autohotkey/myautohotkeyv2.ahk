RShiftDownAt := 0
RShiftOffAt := 0

/* Alacrittyにペーストすると改行が増える問題対応 */
/* READ: https://github.com/alacritty/alacritty/issues/2324 */
#HotIf WinActive("Alacritty")
$^+v::
{
    A_Clipboard := StrReplace(A_Clipboard, "`r`n", "`n")
    Send("^+v")
}
return
#HotIf

/* 文字列削除 */
#HotIf WinActive("ahk_exe Notepad.exe", ) or WinActive("ahk_exe vivaldi.exe", ) or WinActive("ahk_exe EXCEL.EXE", )
LCtrl & h::Send ("{BackSpace}")
LCtrl & d::Send ("{Delete}")
LCtrl & u::{
	Send ("+{Home}{Delete}")
}
#HotIf

/* Macライクなアンドゥリドゥ */
RCtrl & z::{
	If GetKeyState("Shift", "P")
		Send ("^y")
	else
		Send ("{Blind}^z")
}

/* アプリ切り替え */
#HotIf WinExist("ahk_group AltTabWindow")  ; Alt-Tabメニュー表示中だけ有効
	LShift::ShiftAltTab
#HotIf
RCtrl & Tab::AltTab

/* 日本語サポート（ATOKつかうなら設定必須） */
; Ctrl+; → Shift+Ctrl+2		=>	半角無変換(後)変換（入力中、変換中、次候補、全候補、文節区切り）
; Ctrl+' → Shift+Ctrl+6		=>	全角無変換(後)変換（入力中、変換中、次候補、全候補、文節区切り）

/*
  日本語入力
  RShift単体 → IMEオン / LShift+RShift → IMEオフ（操作側・操作される側で共通）

  GLKVM（Comet X）は左右Shiftを同時に受け取るとShiftが押されたままになる不具合があるため、
  GLKVMのウィンドウではRShiftをKVMに送らず、代わりにF13(オン)/F14(オフ)を送る。
  操作される側では、KVMから届いたF13/F14でIMEを切り替える。
*/
IsGlkvm() => WinActive("GLKVM - Google Chrome")

ImeOn() {
    if IsGlkvm()
        Send("{F13}")   ; 操作される側へ
    else
        Send("{vk16}")  ; このPCのIMEをオン
}

ImeOff() {
    if IsGlkvm()
        Send("{F14}")   ; 操作される側へ
    else
        Send("{vk1A}")  ; このPCのIMEをオフ
}

; RShiftを押している間にLShiftが押されていれば（押す順番はどちらでも）オフ、
; 押されないまま離せばオン。押下中のキーリピートは、このスレッドが動いている間は無視される。
*RShift:: {
    offSent := false
    while GetKeyState("RShift", "P") {
        if !offSent && GetKeyState("LShift", "P") {
            ImeOff()
            offSent := true
        }
        Sleep(10)
    }
    if !offSent
        ImeOn()
}

; 操作される側：KVMから届いたF13/F14でIMEを切り替える
*F13::Send("{vk16}")  ; オン
*F14::Send("{vk1A}")  ; オフ

/* Ctrl-[でESCとIMEオフ送信 */
^[::{
    Send("{Escape}")
    ImeOff()
}

; /* 後変換 */
; LCtrl & sc027::^+2
; ^sc028::^+6
;
; /* 通常配列のキーボード用の設定（F23、F24を使用）*/
; /* カーソル移動 */
; F24 & sc01A::{
; 	if GetKeyState("RCtrl", "P")
; 		Send ("{Blind}{Home}")
; 	else if GetKeyState("LCtrl", "P") and GetKeyState("LAlt", "P")
; 		Send ("{LWin Down}{Up}{LWin Up}")
; 	else
; 		Send ("{Blind}{Up}")
; }
; F24 & sc035::{
; 	if GetKeyState("RCtrl", "P")
; 		Send ("{Blind}{End}")
; 	else if GetKeyState("LCtrl", "P") and GetKeyState("LAlt", "P")
; 		Send ("{LWin Down}{Down}{LWin Up}")
; 	else
; 		Send ("{Blind}{Down}")
; }
; F24 & sc027::{
; 	if GetKeyState("RCtrl", "P")
; 		Send ("{Blind}{RCtrl Up}{Home}{RCtrl Down}")
; 	else if GetKeyState("LCtrl", "P") and GetKeyState("LAlt", "P")
; 		Send ("{LWin Down}{Left}{LWin Up}")
; 	else if GetKeyState("LShift", "P") and GetKeyState("LAlt", "P")
; 		Send ("{Shift Down}{Ctrl Down}{Left}{Ctrl Up}{Shift Up}")
; 	else if GetKeyState("LAlt", "P")
; 		Send ("{Ctrl Down}{Left}{Ctrl Up}")
; 	else
; 		Send ("{Blind}{Left}")
; }
; F24 & sc028::{
; 	if GetKeyState("RCtrl", "P")
; 		Send ("{Blind}{RCtrl Up}{End}{RCtrl Down}")
; 	else if GetKeyState("LCtrl", "P") and GetKeyState("LAlt", "P")
; 		Send ("{LWin Down}{Right}{LWin Up}")
; 	else if GetKeyState("LShift", "P") and GetKeyState("LAlt", "P")
; 		Send ("{Shift Down}{Ctrl Down}{Right}{Ctrl Up}{Shift Up}")
; 	else if GetKeyState("LAlt", "P")
; 		Send ("{Ctrl Down}{Right}{Ctrl Up}")
; 	else
; 		Send ("{Blind}{Right}")
; }
; 
; /* ナンバーキーをファンクンションに */
; F24 & 1::F1
; F24 & 2::F2
; F24 & 3::F3
; F24 & 4::F4
; F24 & 5::F5
; F24 & 6::F6
; F24 & 7::F7
; F24 & 8::F8
; F24 & 9::F9
; F24 & 0::F10
; F24 & -::F11
; F24 & =::F12
; 
; /* ページスクロール */
; F24 & l::PgUp
; F24 & .::PgDn
; 
; /* メディアキー */
; F24 & s::Volume_Up
; F24 & a::Volume_Down
; F24 & d::Volume_Mute
