$sourcePath = Join-Path (Convert-Path .) ".config\doom"
$configPath = Join-Path $HOME ".config\doom"

New-Item `
    -Path $configPath `
    -ItemType Directory `
    -Force |
    Out-Null

Copy-Item `
    -Path "$sourcePath\*.el" `
    -Destination $configPath `
    -Force
exit
