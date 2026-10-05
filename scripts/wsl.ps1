$homePath = [Environment]::GetFolderPath("UserProfile")
$source = Join-Path (Convert-Path .) ".config\wsl\.wslconfig"
$destination = Join-Path $homePath ".wslconfig"

Copy-Item $source $destination -Force
exit
