$sourcePath = Join-Path (Convert-Path .) "agents\claude"
$configPath = Join-Path $HOME ".claude"

New-Item $configPath -ItemType Directory -Force | Out-Null
Copy-Item (Join-Path (Convert-Path .) "agents\AGENTS.md") (Join-Path $configPath "CLAUDE.md") -Force
Copy-Item (Join-Path $sourcePath "settings.json") $configPath -Force
exit
