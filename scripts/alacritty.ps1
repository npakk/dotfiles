#$applicationPath = [Environment]::GetFolderPath("App")
$path_1 = (Convert-Path .) + "\.config\alacritty\win_alacritty.toml"
$path_2 = (Convert-Path .) + "\.config\alacritty\common.toml"
$path_3 = (Convert-Path .) + "\.config\alacritty\win.toml"
$configPath = [Environment]::GetFolderPath("App") + "\alacritty"
New-Item $configPath -ItemType Directory -ErrorAction SilentlyContinue
$destination_1 = $configPath + "\alacritty.toml"
$destination_2 = $configPath + "\common.toml"
$destination_3 = $configPath + "\win.toml"
Copy-Item -Path $path_1 -Destination $destination_1 -Recurse -Force
Copy-Item -Path $path_2 -Destination $destination_2 -Recurse -Force
Copy-Item -Path $path_3 -Destination $destination_3 -Recurse -Force
exit
