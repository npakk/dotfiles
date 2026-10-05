$source = Join-Path (Convert-Path .) ".config\powershell\profile.ps1"
$destination = $PROFILE.CurrentUserAllHosts

New-Item (Split-Path $destination) -ItemType Directory -Force | Out-Null
Copy-Item $source $destination -Force
exit
