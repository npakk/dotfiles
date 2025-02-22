$startupPath = [Environment]::GetFolderPath("Startup")
$wsShell = New-Object -ComObject WScript.Shell
$shortcutPath = $startupPath + "\myautohotkeyv2.lnk"
$shortcut = $wsShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = (Convert-Path .) + "\.config\autohotkey\myautohotkeyv2.ahk"
$shortcut.Save()
Invoke-Item $shortcutPath
exit
