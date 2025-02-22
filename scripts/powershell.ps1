$systemPath = [Environment]::GetFolderPath("System")
$path = (Convert-Path .) + "\.config\powershell\profile.ps1"
$configPath = $systemPath + "\WindowsPowerShell\v1.0"
New-Item $configPath -ItemType Directory -ErrorAction SilentlyContinue
$destination = $configPath + "\profile.ps1"
Copy-Item -Path $path -Destination $destination -Recurse -Force
exit
