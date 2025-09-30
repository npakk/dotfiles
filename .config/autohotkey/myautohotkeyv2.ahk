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
#HotIf (AltTabMenu := true)
	LShift::ShiftAltTab
#HotIf
RCtrl & Tab::AltTab

/* 日本語サポート（ATOK設定必須） */
; F22	 → 変換 		=>	入力文字種全角ひらがな（文字未入力、入力中、変換中、次候補、全候補、文節区切り、半角入力）
; F21	 → 無変換		=>	日本語入力OFF（文字未入力、入力中、変換中、次候補、全候補、文節区切り、半角入力、記号入力）
; Ctrl+[ → Escape + 無変換	=>	日本語入力OFF（文字未入力、入力中、変換中、次候補、全候補、文節区切り、半角入力、記号入力）
; Ctrl+; → Shift+Ctrl+2		=>	半角無変換(後)変換（入力中、変換中、次候補、全候補、文節区切り）
; Ctrl+' → Shift+Ctrl+6		=>	全角無変換(後)変換（入力中、変換中、次候補、全候補、文節区切り）

/* 日本語入力 */
F22::Send ("{vk1C}") ; 変換
F21::Send ("{vk1D}") ; 無変換

/* Ctrl-[でESCと無変換送信 */
^[::Send ("{Escape}{vk1D}") ; Esc,無変換

/* 後変換 */
LCtrl & sc027::^+2
^sc028::^+6

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
