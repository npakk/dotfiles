$homePath = [Environment]::GetFolderPath("User")
$path_1 = (Convert-Path .) + "\.config\doom\config.el"
$path_2 = (Convert-Path .) + "\.config\doom\init.el"
$path_3 = (Convert-Path .) + "\.config\doom\packages.el"
$path_4 = (Convert-Path .) + "\.config\doom\custom.el"
$configPath = $homePath + "\.doom.d"
New-Item $configPath -ItemType Directory -ErrorAction SilentlyContinue
$destination_1 = $configPath + "\config.el"
$destination_2 = $configPath + "\init.el"
$destination_3 = $configPath + "\packages.el"
$destination_4 = $configPath + "\custom.el"
Copy-Item -Path $path_1 -Destination $destination_1 -Recurse -Force
Copy-Item -Path $path_2 -Destination $destination_2 -Recurse -Force
Copy-Item -Path $path_3 -Destination $destination_3 -Recurse -Force
Copy-Item -Path $path_4 -Destination $destination_4 -Recurse -Force
exit
