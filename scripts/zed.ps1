$path_1 = (Convert-Path .) + "\.config\zed\keymap.json"
$path_2 = (Convert-Path .) + "\.config\zed\settings.json"

$configPath = Join-Path $env:APPDATA "Zed"
New-Item $configPath -ItemType Directory -ErrorAction SilentlyContinue

$destination_1 = $configPath + "\keymap.json"
$destination_2 = $configPath + "\settings.json"

Copy-Item -Path $path_1 -Destination $destination_1 -Force
Copy-Item -Path $path_2 -Destination $destination_2 -Force
exit

