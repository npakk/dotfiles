$homePath = [Environment]::GetFolderPath("User")
$path_1 = (Convert-Path .) + "\.config\wsl\.wslconfig"
New-Item $configPath -ItemType Directory -ErrorAction SilentlyContinue
$destination_1 = $homePath + "\.wslconfig"
Copy-Item -Path $path_1 -Destination $destination_1 -Recurse -Force
exit
